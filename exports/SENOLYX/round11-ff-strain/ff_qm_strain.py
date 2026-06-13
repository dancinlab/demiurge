#!/usr/bin/env python3
# SENOLYX R11 — macrocycle force-field strain probe (FF vs QM), cause-① discriminator
# for the R10b ABFE falsification (geldanamycin/HSP90 ABFE over-bound by ~8.5 kcal/mol
# vs experiment; honest cause candidates: ① macrocycle FF systematic error · ② pose ·
# ③ entropy undersampling · ④ protonation/restraint).
#
# Hypothesis under test (①): the universal small-molecule FF (openff-2.1.0 Sage, the
# exact FF used in the R10b ABFE) UNDER-penalizes the strained bound macrocycle
# conformation relative to first-principles QM (GFN2-xtb). If so, the FF makes the
# bound state artificially low in energy → a direct, quantifiable contribution to the
# ABFE over-binding. This is a d6 move: first-principles physics (QM) probes the
# empirical-FF wall, computed in minutes (no MD, no GPU, $0 on summer pool).
#
# Definition (conformational strain = E(bound pose) - E(relaxed)), same molecule, vacuum:
#   strain_MM = E_MM(bound)  - E_MM(min)     using openff-2.1.0 + NAGL am1bcc (ABFE FF)
#   strain_QM = E_QM(bound)  - E_QM(opt)     using GFN2-xtb (first-principles reference)
#   DDelta    = strain_QM - strain_MM
# Interpretation:
#   DDelta >> 0  -> FF under-penalizes bound strain -> over-stabilizes bound -> overbind
#                   source attributed (at least in part) to macrocycle FF valence error.
#   DDelta ~ 0   -> macrocycle intramolecular FF is faithful -> overbind is NOT this;
#                   points to pose (②) or protein-ligand interaction FF, not ring strain.
#
# Inputs reused from R9/R10: /tmp/abfe/kos_pose.sdf (the docked bound pose).
# Run: /home/summer/micromamba/envs/fep/bin/python ff_qm_strain.py
import os, sys, subprocess, shutil, re, tempfile, json
import numpy as np

HARTREE2KCAL = 627.5094740631
HERE = os.path.dirname(os.path.abspath(__file__))
LIG_SDF = os.environ.get("LIG_SDF", "/tmp/abfe/kos_pose.sdf")
XTB = shutil.which("xtb") or "/home/summer/micromamba/envs/fep/bin/xtb"
WORK = tempfile.mkdtemp(prefix="r11strain_")
print(f"[R11] work={WORK}  lig={LIG_SDF}  xtb={XTB}", flush=True)

# ----------------------------------------------------------------------------- load
from openff.toolkit import Molecule, ForceField
from openff.toolkit.utils.nagl_wrapper import NAGLToolkitWrapper
from openff.units import unit as off_unit
import openmm as mm
from openmm import unit, app

mol = Molecule.from_file(LIG_SDF, allow_undefined_stereo=True)
if isinstance(mol, list):
    mol = mol[0]
tot_q = float(mol.total_charge.m_as(off_unit.elementary_charge))
coords_ang = np.array(mol.conformers[0].m_as(off_unit.angstrom))
elems = [a.symbol for a in mol.atoms]
print(f"[R11] molecule: {mol.to_smiles(explicit_hydrogens=False)}", flush=True)
print(f"[R11] n_atoms={mol.n_atoms}  total_charge={tot_q:+.2f}", flush=True)

# assign the SAME charges as the ABFE deck (NAGL openff-gnn-am1bcc-1.0.0)
NAGLToolkitWrapper().assign_partial_charges(mol, partial_charge_method="openff-gnn-am1bcc-1.0.0.pt")

# ----------------------------------------------------------------------------- MM
ff = ForceField("openff-2.1.0.offxml")
inter = ff.create_interchange(mol.to_topology(), charge_from_molecules=[mol])
omm_sys = inter.to_openmm(combine_nonbonded_forces=True)  # vacuum, no PBC
integ = mm.VerletIntegrator(1.0 * unit.femtosecond)
ctx = mm.Context(omm_sys, integ, mm.Platform.getPlatformByName("Reference"))
pos = coords_ang * unit.angstrom
ctx.setPositions(pos)

def mm_energy():
    return ctx.getState(getEnergy=True).getPotentialEnergy().value_in_unit(unit.kilocalorie_per_mole)

e_mm_bound = mm_energy()
mm.LocalEnergyMinimizer.minimize(ctx, 1e-4, 50000)
e_mm_min = mm_energy()
strain_mm = e_mm_bound - e_mm_min
print(f"[R11][MM] E_bound={e_mm_bound:.3f}  E_min={e_mm_min:.3f}  strain_MM={strain_mm:.3f} kcal/mol", flush=True)

# ----------------------------------------------------------------------------- QM (GFN2-xtb)
def write_xyz(path, elems, xyz_ang, comment=""):
    with open(path, "w") as fh:
        fh.write(f"{len(elems)}\n{comment}\n")
        for s, (x, y, z) in zip(elems, xyz_ang):
            fh.write(f"{s} {x:.6f} {y:.6f} {z:.6f}\n")

QCHRG = str(int(round(tot_q)))
def xtb_energy(xyz_path, opt=False):
    cmd = [XTB, os.path.basename(xyz_path), "--gfn", "2", "--chrg", QCHRG, "--uhf", "0"]
    cmd += ["--opt", "tight"] if opt else ["--sp"]
    env = dict(os.environ); env.setdefault("OMP_NUM_THREADS", "4")
    r = subprocess.run(cmd, cwd=os.path.dirname(xyz_path), capture_output=True, text=True, env=env)
    out = r.stdout + r.stderr
    es = re.findall(r"TOTAL ENERGY\s+(-?\d+\.\d+)\s+Eh", out)
    if not es:
        es = re.findall(r"\|\s*TOTAL ENERGY\s+(-?\d+\.\d+)", out)
    if not es:
        sys.stderr.write(out[-2000:]); raise RuntimeError("xtb: no TOTAL ENERGY parsed")
    return float(es[-1]) * HARTREE2KCAL  # kcal/mol

bxyz = os.path.join(WORK, "bound.xyz")
write_xyz(bxyz, elems, coords_ang, "geldanamycin bound pose")
e_qm_bound = xtb_energy(bxyz, opt=False)
# optimize a COPY so the bound xyz stays intact; xtb writes xtbopt.xyz in cwd
e_qm_opt = xtb_energy(bxyz, opt=True)
strain_qm = e_qm_bound - e_qm_opt
print(f"[R11][QM] E_bound={e_qm_bound:.3f}  E_opt={e_qm_opt:.3f}  strain_QM={strain_qm:.3f} kcal/mol", flush=True)

# ----------------------------------------------------------------------------- verdict
ddelta = strain_qm - strain_mm
print("\n================ R11 FF-vs-QM macrocycle strain ================", flush=True)
print(f"  strain_MM (openff-2.1.0) = {strain_mm:8.3f} kcal/mol", flush=True)
print(f"  strain_QM (GFN2-xtb)     = {strain_qm:8.3f} kcal/mol", flush=True)
print(f"  DDelta = QM - MM         = {ddelta:8.3f} kcal/mol", flush=True)
if ddelta > 2.0:
    verdict = ("FF UNDER-PENALIZES bound macrocycle strain by %.1f kcal/mol -> cause-① "
               "(macrocycle FF systematic error) CONFIRMED as an overbind contributor" % ddelta)
elif ddelta < -2.0:
    verdict = ("FF OVER-penalizes strain by %.1f -> would UNDER-bind from this term; "
               "overbind is elsewhere (pose/interaction)" % (-ddelta))
else:
    verdict = ("macrocycle intramolecular FF is faithful (|DDelta|<2) -> overbind NOT "
               "from ring strain; points to pose (②) or protein-ligand interaction FF")
print(f"  VERDICT: {verdict}", flush=True)
print("================================================================", flush=True)

res = dict(smiles=mol.to_smiles(explicit_hydrogens=False), n_atoms=int(mol.n_atoms),
           strain_MM=strain_mm, strain_QM=strain_qm, DDelta=ddelta,
           e_mm_bound=e_mm_bound, e_mm_min=e_mm_min,
           e_qm_bound=e_qm_bound, e_qm_opt=e_qm_opt, verdict=verdict)
with open(os.path.join(HERE, "r11_strain_result.json"), "w") as fh:
    json.dump(res, fh, indent=2)
print(f"[R11] wrote r11_strain_result.json", flush=True)
