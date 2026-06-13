#!/usr/bin/env python3
# SENOLYX R12-GOLD — definitive ABFE of the 17AG / 17AAG congeneric pair on HSP90.
#
# Reconstructed gold deck (the original lived only in /tmp on summer and was wiped
# by a reboot 2026-06-10; the inputs survived in this repo, so this re-derives the
# exact engine + box-fix from the R10 base and the documented R12 smallbox fix).
#
# RBFE validation: ΔΔG = ABFE(17AG) − ABFE(17AAG) vs exp ≈ −1.9 kcal/mol
#   (cb600224w, quinone form, C17 allylamino[17AAG] vs amino[17AG]; 17AG tighter).
# The shared ansamycin macrocycle core → systematic FF error cancels in the
# difference, so the RELATIVE ΔΔG is trustworthy even though the absolute ABFE
# magnitudes are not (solvent-leg λ is run-to-run unstable — see R12 directional).
#
# This run = the DEFINITIVE (N_ITER=1000) magnitude, run sequentially 17AG then
# 17AAG. Select the ligand with the LIG env var (LIG=17AG | 17AAG).
#
# Box-fix (the R12 smallbox fix, reproduced): the ligand SDFs are origin-centred
# (centroid ~0,0,0) while the receptor sits ~9.8 nm away → naive solvate padding
# gives a 14.3 nm / 289k-atom box (a silently-wrong 2nd solvent leg). Fix: translate
# the ligand centroid onto the receptor centroid (HSP90 N-domain ATP pocket) BEFORE
# solvating → padding=1.0 nm then yields ~31k atoms (matches the recorded
# `complex: 31166 atoms, ligand 78, anchor CA [2712]`).
#
# Engine: openmmtools AbsoluteAlchemicalFactory + ReplicaExchangeSampler + MBAR,
# native .nc checkpoint (resumable). NO openfe (the reliable validated subset).
import os, sys, time, faulthandler
faulthandler.enable()
# pin pymbar's JAX to CPU BEFORE openmmtools import — otherwise JAX and OpenMM both
# grab the single GPU and segfault. MBAR is cheap on CPU; OpenMM keeps the GPU.
os.environ.setdefault("JAX_PLATFORMS", "cpu")
os.environ.setdefault("JAX_PLATFORM_NAME", "cpu")
os.environ.setdefault("CUDA_VISIBLE_DEVICES", "0")
import numpy as np
from openmm import unit, app, MonteCarloBarostat
import openmm as mm
from openff.toolkit import Molecule
from openff.toolkit.utils.nagl_wrapper import NAGLToolkitWrapper
from openmmforcefields.generators import SystemGenerator
from pdbfixer import PDBFixer
from openmmtools import alchemy, states, mcmc, multistate, forces
from openmmtools.states import (ThermodynamicState, SamplerState,
                                CompoundThermodynamicState)

SMOKE = os.environ.get("SMOKE", "0") == "1"
LIG = os.environ.get("LIG", "17AG")            # 17AG | 17AAG (selects the SDF + labels)
T = 298.15 * unit.kelvin
P = 1.0 * unit.atmosphere
PLATFORM = mm.Platform.getPlatformByName("CUDA")
PLATFORM_PROPS = {"Precision": "mixed"}
HERE = os.path.dirname(os.path.abspath(__file__))
REC_PDB = os.path.join(HERE, "hsp90_rec_clean.pdb")
LIG_SDF = os.path.join(HERE, f"{LIG}.sdf")

# ---- protocol resolution -----------------------------------------------------
if SMOKE:
    # pipeline-validation: 5 windows / leg, 100-step iters, 30 iterations (enough
    # samples for the numpy MBAR solver to converge without crashing)
    ELEC = [1.0, 0.5, 0.0, 0.0, 0.0]
    STER = [1.0, 1.0, 1.0, 0.5, 0.0]
    N_ITER, N_STEPS = 30, 100
else:
    # production gold (R10b dense 20-window λ-schedule): elec off in 0.125 steps
    # (9 win) then sterics softcore in finer steps (11 win) → tight MBAR overlap.
    ELEC = [1.000, 0.875, 0.750, 0.625, 0.500, 0.375, 0.250, 0.125, 0.000,
            0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000]
    STER = [1.000, 1.000, 1.000, 1.000, 1.000, 1.000, 1.000, 1.000, 1.000,
            0.900, 0.800, 0.700, 0.600, 0.500, 0.400, 0.300, 0.200, 0.120, 0.050, 0.000]
    N_ITER, N_STEPS = 1000, 1000  # 1000 iters * 1000 steps * 4fs(HMR) = 4 ns / window
N_STATES = len(ELEC)
assert len(STER) == N_STATES


def prep_ligand():
    lig = Molecule.from_file(LIG_SDF)
    NAGLToolkitWrapper().assign_partial_charges(
        lig, partial_charge_method="openff-gnn-am1bcc-1.0.0.pt")
    return lig


def make_system_generator(lig):
    # ff14SB protein + TIP3P water + OpenFF-2.1.0 small molecule, HMR for 4 fs.
    return SystemGenerator(
        forcefields=["amber/protein.ff14SB.xml", "amber/tip3p_standard.xml"],
        small_molecule_forcefield="openff-2.1.0",
        molecules=[lig],
        forcefield_kwargs={"constraints": app.HBonds, "rigidWater": True,
                           "hydrogenMass": 3.0 * unit.amu},
        periodic_forcefield_kwargs={"nonbondedMethod": app.PME,
                                    "nonbondedCutoff": 1.0 * unit.nanometer})


def build_complex(lig, sysgen):
    fixer = PDBFixer(filename=REC_PDB)
    fixer.findMissingResidues(); fixer.missingResidues = {}
    fixer.findNonstandardResidues(); fixer.replaceNonstandardResidues()
    fixer.removeHeterogens(keepWater=False)
    fixer.findMissingAtoms(); fixer.addMissingAtoms(); fixer.addMissingHydrogens(7.0)
    modeller = app.Modeller(fixer.topology, fixer.positions)

    # ---- BOX-FIX (R12 smallbox) ---------------------------------------------
    # The ligand SDF is origin-centred while the receptor is ~9.8 nm away. Translate
    # the ligand centroid onto the receptor centroid (≈ N-domain ATP pocket for this
    # single-domain construct) so the solvated box wraps the receptor, not the
    # 9.8 nm origin→receptor span. padding=1.0 then gives ~31k atoms (vs 289k naive).
    rec_pos = np.array(modeller.positions.value_in_unit(unit.nanometer))
    rec_centroid = rec_pos.mean(axis=0)
    lig_pos = lig.conformers[0].to_openmm().value_in_unit(unit.nanometer)
    lig_pos = np.array(lig_pos)
    lig_pos = lig_pos - lig_pos.mean(axis=0) + rec_centroid      # centroid → pocket
    lig_top = lig.to_topology().to_openmm()
    modeller.add(lig_top, lig_pos * unit.nanometer)
    n_before_solv = modeller.topology.getNumAtoms()
    # solvate + neutralize (padding now measured around the receptor, ligand inside)
    modeller.addSolvent(sysgen.forcefield, model="tip3p",
                        padding=1.0 * unit.nanometer, neutralize=True,
                        ionicStrength=0.15 * unit.molar)
    system = sysgen.create_system(modeller.topology)
    system.addForce(MonteCarloBarostat(P, T, 25))
    # ligand atom indices = the contiguous block we just added (before solvent)
    lig_n = lig_top.getNumAtoms()
    lig_atoms = list(range(n_before_solv - lig_n, n_before_solv))
    # protein anchor = CA closest to ligand centroid (for the centroid restraint)
    pos = np.array(modeller.positions.value_in_unit(unit.nanometer))
    lig_centroid = pos[lig_atoms].mean(axis=0)
    ca_idx = [a.index for a in modeller.topology.atoms()
              if a.name == "CA" and a.residue.chain.index == 0]
    anchor = min(ca_idx, key=lambda i: np.linalg.norm(pos[i] - lig_centroid))
    return system, modeller.topology, modeller.positions, lig_atoms, [anchor]


def build_solvent(lig, sysgen):
    lig_top = lig.to_topology().to_openmm()
    lig_pos = lig.conformers[0].to_openmm()
    modeller = app.Modeller(lig_top, lig_pos)
    modeller.addSolvent(sysgen.forcefield, model="tip3p",
                        padding=1.2 * unit.nanometer, neutralize=True)
    system = sysgen.create_system(modeller.topology)
    system.addForce(MonteCarloBarostat(P, T, 25))
    lig_atoms = list(range(lig_top.getNumAtoms()))
    return system, modeller.topology, modeller.positions, lig_atoms


def alchemify(system, lig_atoms):
    region = alchemy.AlchemicalRegion(alchemical_atoms=lig_atoms,
                                      annihilate_electrostatics=True,
                                      annihilate_sterics=False)
    factory = alchemy.AbsoluteAlchemicalFactory(alchemical_pme_treatment="exact")
    return factory.create_alchemical_system(system, region)


def run_leg(name, system, topology, positions, lig_atoms, anchor=None):
    out_nc = os.path.join(HERE, f"abfe_{name}{'_smoke' if SMOKE else ''}.nc")
    alch_system = alchemify(system, lig_atoms)
    box = system.getDefaultPeriodicBoxVectors()

    # complex leg: hand-rolled FLAT-BOTTOM centroid restraint (anchor protein CA <->
    # ligand centroid). A plain CustomCentroidBondForce (NOT an openmmtools
    # RadiallySymmetricRestraintForce) so the MBAR analyzer treats it as an ordinary
    # always-on force (cancels between windows) instead of the YANK-style
    # lambda_restraints unbiasing path (openmmtools 0.26 no longer supports it).
    ssc = 0.0  # kcal/mol
    composable = [alchemy.AlchemicalState.from_system(alch_system)]
    if anchor is not None:
        posn = np.array(positions.value_in_unit(unit.nanometer))
        r0 = float(np.linalg.norm(posn[lig_atoms].mean(axis=0) - posn[anchor[0]]))
        rwell = max(0.45, r0 + 0.15)                      # nm
        k_kcal_nm2 = 80.0                                  # kcal/mol/nm^2 (soft wall)
        k_kj_nm2 = k_kcal_nm2 * 4.184
        cf = mm.CustomCentroidBondForce(
            2, "step(d-rwell)*0.5*restr_k*(d-rwell)^2; d=distance(g1,g2)")
        cf.addGlobalParameter("restr_k", k_kj_nm2)         # kJ/mol/nm^2
        cf.addGlobalParameter("rwell", rwell)              # nm
        cf.addGroup(anchor)
        cf.addGroup(lig_atoms)
        cf.addBond([0, 1], [])
        alch_system.addForce(cf)
        # analytical standard-state correction: V_eff = int 4 pi r^2 exp(-beta U(r)) dr
        kT = (unit.MOLAR_GAS_CONSTANT_R * T).value_in_unit(unit.kilocalorie_per_mole)
        beta = 1.0 / kT
        rg = np.linspace(0.0, rwell + 2.0, 20000)          # nm
        U = np.where(rg <= rwell, 0.0, 0.5 * k_kcal_nm2 * (rg - rwell) ** 2)  # kcal/mol
        _trapz = getattr(np, "trapezoid", None) or np.trapz
        Veff = _trapz(4 * np.pi * rg ** 2 * np.exp(-beta * U), rg)            # nm^3
        V0 = 1.66053906                                                       # nm^3 (1 M)
        ssc = -kT * np.log(V0 / Veff)                                         # kcal/mol
        print(f"[{name}] restraint r0={r0:.2f} rwell={rwell:.2f} nm  "
              f"Veff={Veff:.3f} nm^3  SSC={ssc:.2f} kcal/mol", flush=True)

    import copy
    base = ThermodynamicState(alch_system, temperature=T, pressure=P)
    compound = CompoundThermodynamicState(base, composable_states=composable)

    # build per-window thermodynamic states (deep-copy the compound, set lambdas)
    thermo_states = []
    for k in range(N_STATES):
        cs = copy.deepcopy(compound)
        cs.lambda_electrostatics = ELEC[k]
        cs.lambda_sterics = STER[k]
        thermo_states.append(cs)

    # pre-equilibrate the fully-coupled state on the GPU so the replica-exchange start
    # is clash-free (bad contacts from the translated pose + rebuilt receptor + solvent
    # would otherwise blow up the alchemical minimize -> NaN -> segfault).
    eq_nsteps = 200 if SMOKE else 25000  # 0.1 ns equilibration at 4 fs
    print(f"[{name}] pre-equilibrating coupled state ({eq_nsteps} steps)...", flush=True)
    eq_int = mm.LangevinMiddleIntegrator(T, 1.0 / unit.picosecond, 4.0 * unit.femtoseconds)
    eq_ctx = mm.Context(alch_system, eq_int, PLATFORM, PLATFORM_PROPS)
    eq_ctx.setPositions(positions)
    eq_ctx.setParameter("lambda_electrostatics", 1.0)
    eq_ctx.setParameter("lambda_sterics", 1.0)
    mm.LocalEnergyMinimizer.minimize(eq_ctx, maxIterations=2000)
    eq_ctx.setVelocitiesToTemperature(T)
    eq_int.step(eq_nsteps)
    eq_state = eq_ctx.getState(getPositions=True, enforcePeriodicBox=True)
    positions = eq_state.getPositions(asNumpy=True)
    box = eq_state.getPeriodicBoxVectors()
    del eq_ctx, eq_int
    print(f"[{name}] equilibration done", flush=True)

    sampler_state = SamplerState(positions, box_vectors=box)
    move = mcmc.LangevinDynamicsMove(
        timestep=4.0 * unit.femtoseconds, collision_rate=1.0 / unit.picosecond,
        n_steps=N_STEPS, reassign_velocities=True)
    sampler = multistate.ReplicaExchangeSampler(
        mcmc_moves=move, number_of_iterations=N_ITER,
        online_analysis_interval=None)
    reporter = multistate.MultiStateReporter(
        out_nc, checkpoint_interval=max(1, N_ITER // 10))

    if os.path.exists(out_nc):
        # resume — reboot-safe: a killed run picks up from the last checkpoint
        print(f"[{name}] resuming from {out_nc}", flush=True)
        sampler = multistate.ReplicaExchangeSampler.from_storage(reporter)
        sampler.extend(n_iterations=max(0, N_ITER - sampler.iteration))
    else:
        print(f"[{name}] sampler.create...", flush=True)
        sampler.create(thermodynamic_states=thermo_states,
                       sampler_states=sampler_state, storage=reporter)
        print(f"[{name}] sampler.minimize...", flush=True)
        sampler.minimize()
        print(f"[{name}] sampler.run ({N_ITER} iters)...", flush=True)
        sampler.run()
    print(f"[{name}] sampling complete, analyzing...", flush=True)

    analyzer = multistate.MultiStateSamplerAnalyzer(reporter)
    dG_kt, ddG_kt = analyzer.get_free_energy()
    kT = (unit.MOLAR_GAS_CONSTANT_R * T).value_in_unit(unit.kilocalorie_per_mole)
    dG = dG_kt[0, -1] * kT
    ddG = ddG_kt[0, -1] * kT
    print(f"[{name}] dG_decouple = {dG:.2f} +/- {ddG:.2f} kcal/mol  "
          f"(ssc={ssc:.2f})", flush=True)
    return dG, ddG, ssc


def main():
    t0 = time.time()
    print(f"=== SENOLYX R12-GOLD ABFE {LIG}/HSP90 (SMOKE={SMOKE}, N_ITER={N_ITER}) ===", flush=True)
    lig = prep_ligand()
    sysgen = make_system_generator(lig)

    csys, ctop, cpos, clig, anchor = build_complex(lig, sysgen)
    print(f"complex: {csys.getNumParticles()} atoms, ligand {len(clig)}, anchor CA {anchor}", flush=True)
    dG_c, ddG_c, ssc = run_leg("complex", csys, ctop, cpos, clig, anchor=anchor)

    ssys, stop, spos, slig = build_solvent(lig, sysgen)
    print(f"solvent: {ssys.getNumParticles()} atoms, ligand {len(slig)}", flush=True)
    dG_s, ddG_s, _ = run_leg("solvent", ssys, stop, spos, slig, anchor=None)

    # ABFE assembly (double decoupling):
    #   dG_bind = dG_solvent_off - dG_complex_off + dG_SSC
    dG_bind = dG_s - dG_c + ssc
    err = (ddG_c**2 + ddG_s**2) ** 0.5
    print("\n" + "=" * 64, flush=True)
    print(f"=== dG_bind (ABFE, double-decoupling + MBAR) = {dG_bind:.2f} +/- {err:.2f} kcal/mol ===", flush=True)
    print(f"  ligand = {LIG}", flush=True)
    print(f"  complex decouple = {dG_c:.2f} +/- {ddG_c:.2f}", flush=True)
    print(f"  solvent decouple = {dG_s:.2f} +/- {ddG_s:.2f}", flush=True)
    print(f"  restraint std-state correction = {ssc:.2f}", flush=True)
    print(f"  wall = {(time.time()-t0)/3600:.2f} h", flush=True)


if __name__ == "__main__":
    main()
