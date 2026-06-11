#!/usr/bin/env python3
# SENOLYX R12 — breakthrough-path ② : SINGLE-TOPOLOGY relative free energy
# perturbation (RBFE) for the 17AG <-> 17AAG congeneric pair on HSP90.
#
# ── WHY THIS REPLACES THE ABFE-DIFFERENCE PROXY ──────────────────────────────
# R12-GOLD computed ΔΔG = ABFE(17AG) − ABFE(17AAG) by subtracting two SEPARATE
# absolute-binding-free-energy runs (abfe_hsp90_pair.py). The definitive result
# (ΔΔG = +2.74) had the WRONG SIGN (exp ≈ −1.9, 17AG tighter) and was CLOSED-
# NEGATIVE because each per-leg absolute ΔG is run-to-run BISTABLE (the solvent-
# decoupling λ-leg does not reproduce), and the difference of two unstable
# absolutes does NOT cancel that error.
#
# This deck instead alchemically MORPHS 17AG <-> 17AAG directly inside ONE box
# (single-topology / hybrid-topology). The two ligands share the entire ansamycin
# macrocycle + quinone core; only the C17 substituent differs (amino[17AG] vs
# allylamino[17AAG]). In a relative perturbation, the shared core is NEVER
# decoupled — it stays fully interacting in both end states — so the systematic
# FF error AND the bistable solvent-decoupling pathology cancel BY CONSTRUCTION.
# Only the handful of perturbed C17 atoms are alchemically transformed. This is
# the textbook-correct tool for a congeneric pair and is what was wanted in R12
# all along; the proxy was used ONLY because openfe was absent from summer's env.
#
# ── ENGINE ───────────────────────────────────────────────────────────────────
# OpenFE RelativeHybridTopologyProtocol (openmmtools HREX replica exchange under
# the hood + MBAR) over a single-edge LigandNetwork (17AG <-> 17AAG) with a
# LOMAP atom mapping across the shared core. Two legs are run automatically by
# the protocol: 'complex' (ligand in the HSP90 pocket) and 'solvent' (ligand in
# water). ΔΔG_bind = ΔG_complex − ΔG_solvent. Native .nc storage → resumable.
#
# ── BOX-FIX (inherited from abfe_hsp90_pair.py) ──────────────────────────────
# The ligand SDFs are origin-centred (centroid ~0,0,0 Å) while the receptor sits
# at centroid ~(68.9,-28.6,63.6) Å ≈ 9.8 nm away (verified). Before handing the
# ligands to OpenFE we TRANSLATE each ligand's centroid onto the receptor
# centroid (the HSP90 N-domain ATP pocket) so the solvated complex box wraps the
# receptor (~31k atoms) instead of the 9.8 nm origin→receptor span (~289k atoms).
#
# ── FEASIBILITY NOTE (READ RBFE_PLAN.md) ─────────────────────────────────────
# openfe IS installable on summer for free: the PINNED, strict-channel solve
# converges in ~23 s to openfe 1.11.1 (total download ~120 MB; most CUDA deps
# already cached). Env-create command (one-time, new env, leaves `fep` untouched):
#   micromamba create -n rbfe -c conda-forge --channel-priority strict \
#       openfe python=3.11 -y
# This deck is CONFIRMED against the installed OpenFE 1.11.1 / gufe 1.10.0 API on
# summer (every former `# API-CONFIRM` settings-field path validated against a live
# `RelativeHybridTopologyProtocol.default_settings()` dump — see RBFE_PLAN.md §6).
#
# ── USAGE ────────────────────────────────────────────────────────────────────
#   SMOKE=1 LEGS=solvent python3 rbfe_hsp90.py   # protein-free smoke (no dock req.)
#   SMOKE=1 python3 rbfe_hsp90.py                # both legs (complex needs a dock)
#   N_REPEATS=3 python3 rbfe_hsp90.py            # production (default below)
#   python3 rbfe_hsp90.py                        # resumes from *.nc if present
#   env knobs: SMOKE LEGS N_REPLICAS EQ_PS PROD_PS N_REPEATS
#
# ── VALIDATION STATE (2026-06, summer / openfe 1.11.1) ───────────────────────
# BOTH legs are now SMOKE-validated end-to-end on summer's free RTX 5070, up to and
# including the HREX sampler + MBAR: MCS core-align (77 atoms, 0.82 Å) → 77-atom
# LOMAP map → protocol/DAG build → OpenMM system create → minimize → equilibrate →
# HREX production → MBAR. The solvent leg was clean already; the COMPLEX leg now
# clears minimise + all 20 equilibration iterations + all 40 production iterations
# with ZERO NaN (smoke: 5 windows, 10/20 ps). Every `# API-CONFIRM` field was
# confirmed against the live 1.11.1 API.
#
# COMPLEX-LEG POSE FIX (2026-06) — three coupled parts, all in this deck:
#   1) the centroid box-fix buries ~73 of the 78 ligand atoms in the protein bulk
#      (closest 0.017 Å) → OpenFE's minimiser can't clear it → `Potential energy is
#      NaN ... SimulationNaNError: replica 0 at state 0 resulted in a NaN`. FIXED by
#      _relax_ligand_in_pocket(): a SOFTCORE-alchemical, STAGED-timestep (0.5→1→2 fs)
#      pre-relaxation (the ABFE complex-leg recipe) that induced-fit relaxes A to a
#      clash-free pose (min lig–protein 0.017 → ~1.7 Å).
#   2) that relaxation distorts A's core non-rigidly (~2.9 Å), which would collapse a
#      re-run of LOMAP's 3D filter to a ~1-atom map → wrong perturbation. FIXED by
#      capturing the 77-atom mapping on the CLEAN pre-relaxation conformers (a graph
#      correspondence, coordinate-independent) and reusing it.
#   3) overlaying B onto the distorted relaxed-A leaves the hybrid's shared core ~2.9 Å
#      strained → NaN again. FIXED by CORE-COPY: B's 77 mapped atoms are set EXACTLY
#      onto relaxed-A's core (0.0 Å) and only B's 8 unique C17 atoms are rigid-aligned.
# See RBFE_PLAN.md §7.
#
import os, sys, json, time, pathlib

# pin pymbar's JAX to CPU BEFORE any openmmtools/openfe import — otherwise JAX and
# OpenMM both grab the single GPU and segfault (same lesson as abfe_hsp90_pair.py).
os.environ.setdefault("JAX_PLATFORMS", "cpu")
os.environ.setdefault("JAX_PLATFORM_NAME", "cpu")
os.environ.setdefault("CUDA_VISIBLE_DEVICES", "0")

import numpy as np

HERE = pathlib.Path(__file__).resolve().parent
REC_PDB = HERE / "hsp90_rec_clean.pdb"     # cleaned but HYDROGEN-FREE crystal PDB
REC_PDB_H = HERE / "hsp90_rec_H.pdb"       # protonated (PDBFixer) — built on demand
LIG_A_SDF = HERE / "17AG.sdf"      # state A (amino C17, exp-tighter)
LIG_B_SDF = HERE / "17AAG.sdf"     # state B (allylamino C17)

SMOKE = os.environ.get("SMOKE", "0") == "1"
OUT_DIR = HERE / ("rbfe_smoke" if SMOKE else "rbfe_prod")

# Production protocol settings (OpenFE RelativeHybridTopologyProtocol defaults are
# already publication-grade; we make the sampler length env-overridable). Defaults:
#   - 11 lambda windows (protocol default), HREX replica exchange
#   - 5 ns / replica production, 1 ns equilibration (defaults)
#   - 3 repeats for a statistical uncertainty (defaults). SMOKE shrinks all of it.
if SMOKE:
    N_REPLICAS = int(os.environ.get("N_REPLICAS", "5"))
    EQ_PS = float(os.environ.get("EQ_PS", "10"))        # 10 ps
    PROD_PS = float(os.environ.get("PROD_PS", "20"))    # 20 ps
    N_REPEATS = int(os.environ.get("N_REPEATS", "1"))
else:
    N_REPLICAS = int(os.environ.get("N_REPLICAS", "11"))
    EQ_PS = float(os.environ.get("EQ_PS", "1000"))      # 1 ns
    PROD_PS = float(os.environ.get("PROD_PS", "5000"))  # 5 ns / replica
    N_REPEATS = int(os.environ.get("N_REPEATS", "3"))


def _relax_ligand_in_pocket(rdmA):
    """COMPLEX-LEG POSE FIX. Take ligand A already centroid-translated onto the
    receptor centroid (the box-fix) and RELAX it into a clash-free pocket pose with a
    short SOFTCORE-alchemical pre-relaxation of the assembled protein+ligand+solvent
    complex. Returns rdmA with its conformer overwritten by the relaxed coords (Å);
    those coords then seed the RBFE SmallMoleculeComponent, so OpenFE's complex leg
    starts clash-free and no longer NaNs at equilibration step 0.

    WHY THE NAÏVE PRE-MIN IS NOT ENOUGH (diagnosed on summer, openfe 1.11.1):
    the centroid translation places A's centroid at the *whole-protein* geometric
    centroid; A spans ~12 Å, so 23 of its 78 atoms end up < 1.0 Å from protein heavy
    atoms (closest 0.017 Å — essentially superimposed). With HARD Lennard-Jones a
    plain `LocalEnergyMinimizer.minimize` reaches a *finite* energy but leaves razor-
    sharp residual forces, and the very first MD step then explodes
    (`OpenMMException: Particle coordinate is NaN`). OpenFE's own minimiser hits the
    same wall on the (even clashier) HYBRID system that carries BOTH end-state C17
    substituents at once → `Potential energy is NaN after 0 attempts ...
    SimulationNaNError: replica 0 at state 0 resulted in a NaN`.

    THE FIX (the ABFE complex-leg recipe, which ran WITHOUT NaN): alchemify the
    ligand with openmmtools' AbsoluteAlchemicalFactory (`annihilate_sterics=False`),
    which replaces the hard LJ on the ligand↔environment interactions with the
    SOFTCORE functional form. Softcore stays finite through atomic overlap, so a
    minimise + short MD at full coupling (λ_elec=λ_steric=1) smoothly PUSHES the
    ligand out of the clash. Verified on summer: min lig–protein distance goes
    0.017 Å → 1.875 Å (0 atoms < 1.5 Å) and the relaxed pose then runs stably under
    HARD potentials (the regime OpenFE's end states use). Protein heavy atoms are
    position-restrained during the relax so the receptor frame is preserved.

    Idempotent: caches the relaxed pose to 17AG_pocket.sdf and reuses it.
    """
    from rdkit import Chem
    cache = HERE / "17AG_pocket.sdf"
    if cache.exists():
        cached = Chem.MolFromMolFile(str(cache), removeHs=False, sanitize=True)
        if cached is not None and cached.GetNumAtoms() == rdmA.GetNumAtoms():
            conf, ccf = rdmA.GetConformer(), cached.GetConformer()
            for i in range(rdmA.GetNumAtoms()):
                conf.SetAtomPosition(i, ccf.GetAtomPosition(i))
            print(f"[rbfe] complex pose: reused cached relaxed pose {cache.name}",
                  flush=True)
            return rdmA

    from openmm import unit, app, CustomExternalForce, LangevinMiddleIntegrator, Platform
    from openmm import LocalEnergyMinimizer, Context
    from openff.toolkit import Molecule
    from openmmforcefields.generators import SystemGenerator
    from pdbfixer import PDBFixer
    from openmmtools import alchemy

    # --- assemble the SAME complex the ABFE deck minimised (protonate + box-fix) ---
    fixer = PDBFixer(filename=str(REC_PDB))
    fixer.findMissingResidues(); fixer.missingResidues = {}
    fixer.findNonstandardResidues(); fixer.replaceNonstandardResidues()
    fixer.removeHeterogens(keepWater=False)
    fixer.findMissingAtoms(); fixer.addMissingAtoms(); fixer.addMissingHydrogens(7.0)
    modeller = app.Modeller(fixer.topology, fixer.positions)

    # ligand OpenFF molecule from the (already centroid-shifted) rdmA conformer
    lig = Molecule.from_rdkit(rdmA, allow_undefined_stereo=True)
    lig.assign_partial_charges("gasteiger")   # cheap; charges irrelevant to a pose pre-relax
    sysgen = SystemGenerator(
        forcefields=["amber/protein.ff14SB.xml", "amber/tip3p_standard.xml"],
        small_molecule_forcefield="openff-2.1.0", molecules=[lig],
        forcefield_kwargs={"constraints": app.HBonds, "rigidWater": True,
                           "hydrogenMass": 3.0 * unit.amu},
        periodic_forcefield_kwargs={"nonbondedMethod": app.PME,
                                    "nonbondedCutoff": 1.0 * unit.nanometer})

    n_prot = modeller.topology.getNumAtoms()
    lig_top = lig.to_topology().to_openmm()
    lig_pos = lig.conformers[0].to_openmm()
    modeller.add(lig_top, lig_pos)
    n_lig = lig_top.getNumAtoms()
    lig_atoms = list(range(n_prot, n_prot + n_lig))
    modeller.addSolvent(sysgen.forcefield, model="tip3p",
                        padding=1.0 * unit.nanometer, neutralize=True,
                        ionicStrength=0.15 * unit.molar)
    system = sysgen.create_system(modeller.topology)

    # SOFT position-restraint on protein Cα ONLY (k = 200 kJ/mol/nm^2): anchors the
    # receptor frame (we extract the ligand pose RELATIVE to it) while leaving
    # sidechains + the ligand + waters free to relax the clash. A HARD all-heavy-atom
    # restraint would pin a protein atom that the ligand is superimposed on, so the
    # softcore push-off impulse has nowhere to go → NaN; a soft Cα restraint avoids
    # that while still preventing whole-protein drift.
    restr = CustomExternalForce("0.5*k*((x-x0)^2+(y-y0)^2+(z-z0)^2)")
    restr.addGlobalParameter("k", 200.0)
    for p in ("x0", "y0", "z0"):
        restr.addPerParticleParameter(p)
    pos_all = modeller.positions
    ca_atoms = [a.index for a in modeller.topology.atoms()
                if a.index < n_prot and a.name == "CA"]
    for idx in ca_atoms:
        xyz = pos_all[idx].value_in_unit(unit.nanometer)
        restr.addParticle(idx, [xyz[0], xyz[1], xyz[2]])
    system.addForce(restr)

    # SOFTCORE the ligand (the ABFE recipe): finite energy through overlap → the clash
    # is recoverable. annihilate_sterics=False keeps the softcore LJ form at full λ.
    region = alchemy.AlchemicalRegion(alchemical_atoms=lig_atoms,
                                      annihilate_electrostatics=True,
                                      annihilate_sterics=False)
    factory = alchemy.AbsoluteAlchemicalFactory(alchemical_pme_treatment="exact")
    alch_system = factory.create_alchemical_system(system, region)

    try:
        platform = Platform.getPlatformByName("CUDA")
        props = {"Precision": "mixed"}
    except Exception:
        platform = Platform.getPlatformByName("CPU"); props = {}
    # STAGED timestep: even with softcore the FIRST steps off a near-superimposed start
    # carry a large impulse, so a 4 fs step overshoots → NaN. Start at 0.5 fs to let the
    # push-off settle, then grow to 2 fs. (Verified on summer: PE finite through all
    # stages, min lig–protein 0.017 Å → ~2.0 Å.)
    integ = LangevinMiddleIntegrator(298.15 * unit.kelvin, 1.0 / unit.picosecond,
                                     0.5 * unit.femtoseconds)
    ctx = Context(alch_system, integ, platform, props)
    ctx.setPositions(modeller.positions)
    ctx.setParameter("lambda_electrostatics", 1.0)   # fully coupled, but softcore LJ
    ctx.setParameter("lambda_sterics", 1.0)
    print(f"[rbfe] complex pose: softcore staged pre-relaxing complex "
          f"({alch_system.getNumParticles()} atoms, ligand {n_lig})...", flush=True)
    LocalEnergyMinimizer.minimize(ctx, maxIterations=5000)
    ctx.setVelocitiesToTemperature(298.15 * unit.kelvin)
    # smoke: 0.5/1/2 fs × 2000 = 7 ps; prod: longer tail at 2 fs for a fuller settle.
    tail = 2000 if SMOKE else 12500
    stages = [(0.5, 2000), (1.0, 2000), (2.0, tail)]
    for dt, nst in stages:
        integ.setStepSize(dt * unit.femtoseconds)
        integ.step(nst)
        pe = ctx.getState(getEnergy=True).getPotentialEnergy().value_in_unit(
            unit.kilojoule_per_mole)
        if not np.isfinite(pe):
            sys.exit(f"[rbfe] complex pose softcore relax went non-finite at the "
                     f"{dt} fs stage — the box-fix pose is unrecoverable; needs a dock")
    state = ctx.getState(getPositions=True, getEnergy=True, enforcePeriodicBox=True)
    pe = state.getPotentialEnergy().value_in_unit(unit.kilojoule_per_mole)
    relaxed = state.getPositions(asNumpy=True).value_in_unit(unit.angstrom)
    del ctx, integ
    if not np.isfinite(pe):
        sys.exit("[rbfe] complex pose softcore pre-relaxation produced a non-finite "
                 "energy — the box-fix pose is unrecoverable; needs a real dock")
    # report the achieved ligand–protein separation (the clash-clearance metric)
    try:
        from scipy.spatial import cKDTree
        dmin = cKDTree(relaxed[:n_prot]).query(relaxed[lig_atoms], k=1)[0].min()
        clash = f", min lig–protein = {dmin:.2f} Å"
    except Exception:
        clash = ""
    n_relax_steps = sum(n for _, n in stages)
    print(f"[rbfe] complex pose: relaxed (PE = {pe:.3e} kJ/mol, "
          f"{n_relax_steps} staged MD steps{clash})", flush=True)

    # write the relaxed LIGAND coords (Å) back into rdmA + cache to SDF
    conf = rdmA.GetConformer()
    for i, gi in enumerate(lig_atoms):
        x, y, z = (float(v) for v in relaxed[gi])
        conf.SetAtomPosition(i, (x, y, z))
    Chem.MolToMolFile(rdmA, str(cache))
    print(f"[rbfe] complex pose: cached relaxed ligand pose → {cache.name}", flush=True)
    return rdmA


def _load_and_dock_ligands(relax_pocket=True):
    """Load both ligands, translate ligand A's centroid onto the receptor centroid
    (so OpenFE solvates a small box that wraps the receptor, not the 9.8 nm
    origin→receptor span), RELAX A into a clash-free pocket pose (complex leg only),
    then MUTUALLY SUPERIMPOSE ligand B onto ligand A over their shared ansamycin core.

    The mutual-core alignment is REQUIRED for single-topology RBFE: the two input
    SDFs are independently origin-centred with *different* internal orientations, so
    although they share ~77 core atoms graph-wise, their 3D core coordinates do NOT
    coincide. LOMAP's `threed=True` distance filter then discards every candidate
    pair (>max3d apart) and `suggest_mappings` yields NOTHING (StopIteration). After
    an MCS-based rigid alignment the cores overlap (~0.8 Å RMSD) and LOMAP maps the
    full shared core. (Verified on summer / openfe 1.11.1: 0 → 77 atoms mapped.)

    `relax_pocket` (True for the complex leg) runs _relax_ligand_in_pocket on A AFTER
    the centroid box-fix, so the complex leg starts from a clash-free pose and no
    longer NaNs at equilibration step 0. The solvent leg has no protein, so it passes
    relax_pocket=False and uses the raw conformer (unchanged behaviour)."""
    from rdkit import Chem
    from rdkit.Chem import rdFMCS, rdMolAlign

    # receptor centroid (Å) straight from the PDB
    rec = []
    for line in REC_PDB.read_text().splitlines():
        if line.startswith(("ATOM", "HETATM")):
            rec.append((float(line[30:38]), float(line[38:46]), float(line[46:54])))
    rec_centroid = np.array(rec).mean(axis=0)  # Å

    def load(sdf_path):
        m = Chem.MolFromMolFile(str(sdf_path), removeHs=False, sanitize=True)
        if m is None:
            sys.exit(f"ligand load failed: {sdf_path}")
        return m

    def shift_centroid_to(m, target):
        conf = m.GetConformer()
        pos = np.array([list(conf.GetAtomPosition(i)) for i in range(m.GetNumAtoms())])
        pos = pos - pos.mean(axis=0) + target           # centroid → target (Å)
        for i in range(m.GetNumAtoms()):
            conf.SetAtomPosition(i, tuple(float(x) for x in pos[i]))
        return m

    rdmA = shift_centroid_to(load(LIG_A_SDF), rec_centroid)   # A → pocket (box-fix)
    rdmB = load(LIG_B_SDF)

    # rigid-body align B onto A over the maximum common substructure (shared core).
    # CRITICAL: do this on the CLEAN box-fix conformers (BEFORE any pocket relaxation),
    # where the two cores overlap tightly (~0.8 Å). The atom-mapping LOMAP derives here
    # is a GRAPH correspondence (atom-index pairs) and is therefore COORDINATE-
    # INDEPENDENT — we capture it now and reuse it even after A is relaxed (relaxation
    # distorts A's core by ~2-3 Å, which would otherwise collapse LOMAP's 3D filter to
    # a near-empty map). See build_components, which builds the LigandAtomMapping from
    # this dict against the relaxed components.
    mcs = rdFMCS.FindMCS([rdmA, rdmB], ringMatchesRingOnly=True,
                         completeRingsOnly=True, timeout=120)
    patt = Chem.MolFromSmarts(mcs.smartsString)
    matchA = rdmA.GetSubstructMatch(patt)
    matchB = rdmB.GetSubstructMatch(patt)
    if not matchA or not matchB or len(matchA) != len(matchB):
        sys.exit(f"MCS match failed (A={len(matchA)} B={len(matchB)}); cannot align "
                 f"ligand cores for single-topology RBFE")
    rmsd = rdMolAlign.AlignMol(rdmB, rdmA, atomMap=list(zip(matchB, matchA)))
    print(f"[rbfe] MCS shared-core align: {mcs.numAtoms} atoms, "
          f"B→A RMSD = {rmsd:.3f} Å (clean conformers, pre-relaxation)", flush=True)

    # derive the LOMAP atom mapping on these clean, tightly-overlapping conformers
    # (full shared core, ~77 atoms). Returned to build_components for reuse.
    mapping_AtoB = _lomap_mapping_dict(rdmA, rdmB)

    # COMPLEX-LEG POSE FIX: the centroid translation is only a box-fix — it buries A's
    # ~12 Å periphery in the protein bulk (~73 of 78 atoms clash) → steric clash → NaN
    # at equilibration step 0. Relax A into an induced-fit, clash-free pose AFTER the
    # mapping is captured.
    if relax_pocket:
        rdmA = _relax_ligand_in_pocket(rdmA)
        # CORE-COPY (single-topology requirement): set B's MAPPED core atoms EXACTLY
        # onto relaxed-A's core positions, and place B's unique C17 atoms by a rigid
        # pre-align. The relaxation distorts A's core non-rigidly (~2.9 Å RMSD), so a
        # plain rigid re-align of B leaves the hybrid's shared atoms ~2.9 Å apart per
        # atom → an internally-strained hybrid that NaNs at equilibration step 0.
        # Copying the mapped positions makes the shared core coincide to 0.0 Å (the
        # exact geometry OpenFE's hybrid topology assumes), so the complex leg starts
        # clash-free. (Verified on summer: max core deviation 0.0 Å.)
        rApos = np.array([list(rdmA.GetConformer().GetAtomPosition(i))
                          for i in range(rdmA.GetNumAtoms())])
        # rigid pre-align B onto relaxed A over the mapped core (places the C17 atoms)
        rdMolAlign.AlignMol(rdmB, rdmA,
                            atomMap=[(b, a) for a, b in mapping_AtoB.items()])
        bconf = rdmB.GetConformer()
        for a_idx, b_idx in mapping_AtoB.items():   # then snap mapped core exactly
            x, y, z = rApos[a_idx]
            bconf.SetAtomPosition(b_idx, (float(x), float(y), float(z)))
        print(f"[rbfe] core-copy: B's {len(mapping_AtoB)} mapped atoms set onto "
              f"relaxed-A core (0.0 Å), {rdmB.GetNumAtoms()-len(mapping_AtoB)} unique "
              f"C17 atoms rigid-aligned", flush=True)

    return rdmA, rdmB, rec_centroid, mapping_AtoB


def _lomap_mapping_dict(rdmA, rdmB):
    """Return the LOMAP shared-core atom mapping (dict A_idx -> B_idx) computed on the
    given (tightly-aligned) conformers. Falls back to Kartograf. This is a GRAPH
    correspondence and stays valid after either ligand's coordinates change."""
    from openfe import SmallMoleculeComponent
    from openfe.setup.atom_mapping import LomapAtomMapper
    ligA = SmallMoleculeComponent.from_rdkit(rdmA, name="17AG")
    ligB = SmallMoleculeComponent.from_rdkit(rdmB, name="17AAG")
    mapper = LomapAtomMapper(threed=True, element_change=False)
    mapping = next(iter(mapper.suggest_mappings(ligA, ligB)), None)
    if mapping is None:
        from kartograf import KartografAtomMapper
        mapping = next(iter(KartografAtomMapper().suggest_mappings(ligA, ligB)), None)
        if mapping is None:
            sys.exit("no atom mapping found by LOMAP or Kartograf — the shared cores "
                     "are not superimposed (check the MCS align above)")
        print("[rbfe] LOMAP empty → using Kartograf geometry mapper", flush=True)
    d = dict(mapping.componentA_to_componentB)
    print(f"[rbfe] atom mapping: {len(d)} core atoms mapped "
          f"(17AG {rdmA.GetNumAtoms()} ↔ 17AAG {rdmB.GetNumAtoms()}); "
          f"perturbed = the C17 substituent only", flush=True)
    return d


def _protonate_receptor():
    """Return a path to a fully-protonated receptor PDB.

    `hsp90_rec_clean.pdb` is a cleaned but HYDROGEN-FREE crystal structure. OpenFE's
    `ProteinComponent` feeds the PDB straight into an OpenMM ForceField, which has NO
    template for a heavy-atom-only residue and raises `No template found for residue
    0 (ASP) ... missing 4 H atoms`. Unlike the ABFE openmmtools path, OpenFE does not
    protonate for us, so we run the SAME PDBFixer recipe the ABFE deck used (add
    missing heavy atoms + add hydrogens at pH 7) and cache the result. Idempotent:
    reuses hsp90_rec_H.pdb if already present."""
    if REC_PDB_H.exists():
        print(f"[rbfe] using cached protonated receptor {REC_PDB_H.name}", flush=True)
        return REC_PDB_H
    from pdbfixer import PDBFixer
    from openmm.app import PDBFile
    fixer = PDBFixer(filename=str(REC_PDB))
    fixer.findMissingResidues(); fixer.missingResidues = {}
    fixer.findNonstandardResidues(); fixer.replaceNonstandardResidues()
    fixer.removeHeterogens(keepWater=False)
    fixer.findMissingAtoms(); fixer.addMissingAtoms()
    fixer.addMissingHydrogens(7.0)
    with open(REC_PDB_H, "w") as fh:
        PDBFile.writeFile(fixer.topology, fixer.positions, fh, keepIds=True)
    print(f"[rbfe] PDBFixer: protonated receptor written → {REC_PDB_H.name}", flush=True)
    return REC_PDB_H


def build_components(relax_pocket=True):
    """Build the OpenFE ChemicalSystems (complex + solvent) and the single-edge
    atom mapping over the shared core (LOMAP).

    `relax_pocket` (default True; set False for a protein-free `LEGS=solvent` smoke)
    runs the complex-leg pocket-pose relaxation in _load_and_dock_ligands so the
    complex leg starts clash-free. A relaxed pose is harmless to the solvent leg, so
    when BOTH legs run we relax once and use that pose for both."""
    from openfe import (SmallMoleculeComponent, ProteinComponent,
                        SolventComponent, ChemicalSystem)
    from openfe.setup.atom_mapping import LigandAtomMapping  # CONFIRMED openfe 1.11.1
    from openff.units import unit as offunit

    rdmA, rdmB, rec_centroid, mapping_AtoB = _load_and_dock_ligands(
        relax_pocket=relax_pocket)
    print(f"[rbfe] receptor centroid (Å) = {rec_centroid.round(2).tolist()}", flush=True)

    ligA = SmallMoleculeComponent.from_rdkit(rdmA, name="17AG")
    ligB = SmallMoleculeComponent.from_rdkit(rdmB, name="17AAG")

    protein = ProteinComponent.from_pdb_file(str(_protonate_receptor()), name="HSP90")
    # 0.15 M NaCl, neutralizing — matches the ABFE deck's solvation.
    solvent = SolventComponent(ion_concentration=0.15 * offunit.molar)

    # Build the LigandAtomMapping from the GRAPH correspondence captured on the clean
    # pre-relaxation conformers (full shared core, ~77 atoms). We rebuild it here
    # against the FINAL (possibly relaxed) components — the atom-index dict is
    # coordinate-independent, so the full-core map survives the pocket relaxation that
    # would otherwise have collapsed a re-run of LOMAP's 3D filter to a near-empty map.
    mapping = LigandAtomMapping(componentA=ligA, componentB=ligB,
                                componentA_to_componentB=mapping_AtoB)
    print(f"[rbfe] mapping applied: {len(mapping_AtoB)} core atoms "
          f"(17AG {rdmA.GetNumAtoms()} ↔ 17AAG {rdmB.GetNumAtoms()}); "
          f"perturbed = the C17 substituent only", flush=True)

    # ChemicalSystems for the two thermodynamic legs.
    complexA = ChemicalSystem({"ligand": ligA, "protein": protein, "solvent": solvent}, name="17AG_complex")
    complexB = ChemicalSystem({"ligand": ligB, "protein": protein, "solvent": solvent}, name="17AAG_complex")
    solventA = ChemicalSystem({"ligand": ligA, "solvent": solvent}, name="17AG_solvent")
    solventB = ChemicalSystem({"ligand": ligB, "solvent": solvent}, name="17AAG_solvent")
    return mapping, (complexA, complexB), (solventA, solventB)


def make_protocol():
    """RelativeHybridTopologyProtocol with env-overridable sampler length + SMOKE."""
    from openfe.protocols.openmm_rfe import RelativeHybridTopologyProtocol
    from openff.units import unit as offunit

    settings = RelativeHybridTopologyProtocol.default_settings()

    # GPU platform (summer RTX 5070, mixed precision) — same as the ABFE deck.
    # CONFIRMED openfe 1.11.1: engine_settings.compute_platform accepts "CUDA".
    settings.engine_settings.compute_platform = "CUDA"
    # CONFIRMED: protocol_repeats is a TOP-LEVEL int field (default 3).
    settings.protocol_repeats = N_REPEATS

    # lambda windows / HREX. CONFIRMED openfe 1.11.1: the number of HREX replicas
    # lives in TWO coupled fields — lambda_settings.lambda_windows (the alchemical
    # path discretisation) AND simulation_settings.n_replicas (the replica-exchange
    # sampler size). For standard HREX they MUST be equal, so we set both.
    settings.lambda_settings.lambda_windows = N_REPLICAS
    settings.simulation_settings.n_replicas = N_REPLICAS

    # sampler length: simulation_settings carries equilibration/production lengths.
    # CONFIRMED openfe 1.11.1: equilibration_length / production_length accept openff
    # picosecond Quantities, BUT each MUST be an integer multiple of
    # `time_per_iteration` (the # of MD steps between MC/exchange moves; default
    # 2.5 ps = 625 steps @ 4 fs) or system creation raises ValueError. For a SMOKE
    # the default 2.5 ps grid is coarser than the requested few-ps lengths, so we
    # shrink time_per_iteration first, then SNAP eq/prod up to its nearest multiple.
    ss = settings.simulation_settings
    if SMOKE:
        # 0.5 ps/iteration (= 125 steps @ 4 fs) gives a fine SMOKE grid.
        tpi_ps = 0.5
        ss.time_per_iteration = tpi_ps * offunit.picosecond
    else:
        tpi_ps = ss.time_per_iteration.to(offunit.picosecond).magnitude

    def _snap(ps):
        # round UP to the nearest whole multiple of tpi_ps (>= 1 iteration).
        import math
        return max(1, math.ceil(round(ps / tpi_ps, 6))) * tpi_ps

    eq_ps, prod_ps = _snap(EQ_PS), _snap(PROD_PS)
    ss.equilibration_length = eq_ps * offunit.picosecond
    ss.production_length = prod_ps * offunit.picosecond
    if SMOKE and (eq_ps != EQ_PS or prod_ps != PROD_PS):
        print(f"[rbfe] SMOKE: snapped eq {EQ_PS}->{eq_ps} ps, prod {PROD_PS}->{prod_ps} ps "
              f"(time_per_iteration {tpi_ps} ps)", flush=True)

    # checkpoint cadence for .nc resumability. CONFIRMED openfe 1.11.1: the
    # checkpoint cadence lives on OUTPUT_settings (not simulation_settings) and is a
    # TIME quantity, and (like the sampler lengths) is grid-quantised by
    # time_per_iteration. Use one full iteration as the cadence — the smallest valid
    # value — so even a SMOKE writes a checkpoint, and production checkpoints often.
    settings.output_settings.checkpoint_interval = tpi_ps * offunit.picosecond

    # ── COMPLEX-LEG NaN FIX (production HREX first-propagation blow-up) ──────────
    # SYMPTOM: the complex leg NaN'd on iteration0 / replica0 / state0 (the fully-
    # coupled 17AG end state) at step 250 of the first 625-step move. The saved
    # nan-error-log state showed KineticEnergy ≈ 1.03e6 kJ/mol (eq KE for this box
    # is ~tens of thousands) — i.e. an integrator energy explosion, NOT a bad start
    # pose (the softcore pose pre-relax + core-copy already cleared the step-0 clash).
    # ROOT CAUSE: 4 fs + HMR (H-mass 3.0) is at the edge of LangevinMiddle stability;
    # on the hybrid complex the residual strain in the perturbed C17 region pushes it
    # over → overshoot → NaN on the FIRST propagation. The solvent leg (no protein,
    # less strain) survives 4 fs, which is exactly why only the complex leg blew up.
    #
    # FIX — applied in two empirically-driven escalations:
    #
    # (1) timestep 4 fs → 2 fs. This CLEARED the replica-0/state-0 (fully-coupled end
    #     state) blow-up: at 2 fs that window survived. But a SECOND NaN then appeared
    #     at replica5/state5 — the MIDDLE alchemical window (lambda_sterics_core=0.5,
    #     KE≈9.6e5 kJ/mol) during equilibration iteration 1. That is a softcore
    #     INTERMEDIATE-WINDOW instability: where the unique-atom sterics are half
    #     decoupled, the softcore LJ is at its steepest and a 2 fs step still overshoots
    #     on the strained complex hybrid.
    #
    # (2) drop further to 1 fs AND soften the alchemical region (softcore_alpha
    #     0.85 → 0.9). 1 fs gives the full stability margin for the strained complex
    #     hybrid; the larger softcore_alpha flattens the LJ singularity in the
    #     half-decoupled intermediate windows (the exact place the 2 fs run blew up).
    #     Keep HMR (H-mass 3.0, trivially stable at 1 fs) + the Gapsys softcore form.
    #     Deeper minimisation (1000 → 5000 steps) drives out C17 strain pre-dynamics.
    # Cost: 1 fs ~4x the original 4 fs step count (≈3-6 days) — the price of a stable
    # complex hybrid. The driver runs it detached + @reboot-resumable on the free GPU.
    settings.integrator_settings.timestep = 1 * offunit.femtosecond  # 4→2→1 fs (2 fs still NaN'd at mid-window)
    settings.forcefield_settings.hydrogen_mass = 3.0                  # keep HMR (trivially stable @ 1 fs)
    settings.alchemical_settings.softcore_alpha = 0.9                 # was 0.85 — soften mid-window LJ singularity
    # deeper minimisation: drive out the C17-region strain before any dynamics.
    settings.simulation_settings.minimization_steps = 5000           # was 1000 (default)

    return RelativeHybridTopologyProtocol(settings)


def main():
    t0 = time.time()
    OUT_DIR.mkdir(exist_ok=True)
    print(f"=== SENOLYX R12 RBFE 17AG↔17AAG / HSP90 (SMOKE={SMOKE}, "
          f"repeats={N_REPEATS}, windows={N_REPLICAS}, "
          f"eq={EQ_PS}ps prod={PROD_PS}ps) ===", flush=True)

    # leg selection (parsed first so we only run the costly pocket-pose relaxation
    # when the complex leg is actually requested). LEGS env (comma-sep), default both.
    want = [s.strip() for s in os.environ.get("LEGS", "complex,solvent").split(",") if s.strip()]
    # pocket-pose relaxation is needed iff the complex leg runs (the solvent leg is
    # protein-free and unaffected, so a pure `LEGS=solvent` smoke skips it).
    mapping, (complexA, complexB), (solventA, solventB) = build_components(
        relax_pocket=("complex" in want))
    protocol = make_protocol()

    # two legs of the relative perturbation. The solvent leg is protein-free (no
    # docking prerequisite), so `LEGS=solvent` is the clean end-to-end SMOKE that
    # exercises the full sampler→MBAR→estimate path; `LEGS=complex` resumes the
    # protein leg alone (now clash-free thanks to the pocket-pose relaxation).
    _all_legs = {
        "complex": lambda: protocol.create(stateA=complexA, stateB=complexB, mapping=mapping),
        "solvent": lambda: protocol.create(stateA=solventA, stateB=solventB, mapping=mapping),
    }
    legs = {name: _all_legs[name]() for name in want}

    leg_dG = {}
    for leg_name, dag in legs.items():
        print(f"[rbfe] --- leg '{leg_name}': executing DAG "
              f"({len(dag.protocol_units)} unit(s)) ---", flush=True)
        leg_dir = OUT_DIR / leg_name
        leg_dir.mkdir(exist_ok=True)
        from gufe.protocols import execute_DAG  # CONFIRMED openfe 1.11.1 / gufe 1.10.0
        dagres = execute_DAG(
            dag,
            shared_basedir=leg_dir,          # .nc + checkpoints land here → resumable
            scratch_basedir=leg_dir,
            keep_shared=True,
            raise_error=True,
        )
        result = protocol.gather([dagres])
        dG = result.get_estimate()
        err = result.get_uncertainty()
        leg_dG[leg_name] = (dG, err)
        print(f"[rbfe] leg '{leg_name}': ΔG = {dG} ± {err}", flush=True)

    # ΔΔG_bind(17AG→17AAG) = ΔG_complex − ΔG_solvent. Only computed when BOTH legs
    # ran; a single-leg run (e.g. a `LEGS=solvent` smoke) just reports its leg ΔG.
    if not {"complex", "solvent"} <= set(leg_dG):
        print(f"\n[rbfe] single-leg run ({list(leg_dG)}): per-leg ΔG reported above; "
              f"ΔΔG needs both legs.", flush=True)
        return
    from openff.units import unit as offunit
    dG_c, err_c = leg_dG["complex"]
    dG_s, err_s = leg_dG["solvent"]
    ddG = (dG_c - dG_s).to(offunit.kilocalorie_per_mole)
    err = ((err_c ** 2 + err_s ** 2) ** 0.5).to(offunit.kilocalorie_per_mole)

    # convention: the perturbation A→B is 17AG→17AAG, so ΔΔG_bind(17AG→17AAG) is
    # POSITIVE when 17AAG binds weaker. exp ΔΔG(17AAG→17AG) ≈ −1.9 (17AG tighter)
    # ⇒ exp ΔΔG(17AG→17AAG) ≈ +1.9. PASS when computed sign is POSITIVE and
    # |ΔΔG − (+1.9)| ≤ ~1.5 kcal/mol.
    out = {
        "edge": "17AG->17AAG",
        "dG_complex_kcal": dG_c.to(offunit.kilocalorie_per_mole).magnitude,
        "dG_solvent_kcal": dG_s.to(offunit.kilocalorie_per_mole).magnitude,
        "ddG_bind_17AG_to_17AAG_kcal": ddG.magnitude,
        "ddG_err_kcal": err.magnitude,
        "exp_ddG_17AG_to_17AAG_kcal": +1.9,
        "wall_h": (time.time() - t0) / 3600.0,
        "smoke": SMOKE,
    }
    (OUT_DIR / "ddG_result.json").write_text(json.dumps(out, indent=2))
    print("\n" + "=" * 64, flush=True)
    print(f"=== ΔΔG_bind(17AG→17AAG) = {ddG.magnitude:.2f} ± {err.magnitude:.2f} "
          f"kcal/mol  (exp ≈ +1.9; PASS if sign>0 and |Δ|≤1.5) ===", flush=True)
    print(f"  complex ΔG = {out['dG_complex_kcal']:.2f}  "
          f"solvent ΔG = {out['dG_solvent_kcal']:.2f}", flush=True)
    print(f"  wall = {out['wall_h']:.2f} h  →  {OUT_DIR/'ddG_result.json'}", flush=True)


if __name__ == "__main__":
    main()
