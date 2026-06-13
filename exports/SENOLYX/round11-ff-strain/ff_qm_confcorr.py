#!/usr/bin/env python3
# SENOLYX R11b — conformer relative-energy MM-vs-QM correlation (cause-① discriminator,
# REDESIGN of R11a). R11a measured strain vs a VACUUM GLOBAL minimum; a 92-atom flexible
# ligand collapses into a compact globule in vacuo, so the "strain" was dominated by an
# intramolecular-collapse artifact (both legs 150-230 kcal/mol, unphysical) and the
# MM-QM gap reflected nonbonded-model differences, NOT macrocycle valence error.
#
# Correct test: generate a conformer ENSEMBLE, score each conformer's SINGLE-POINT energy
# with BOTH methods on the SAME (fixed) geometry — no re-optimization, so no collapse.
# Relative energies (vs per-method min) cancel the absolute offset and isolate how well
# the FF reproduces the QM conformational landscape that the ABFE actually samples.
#   E_MM(i)  = openff-2.1.0 + NAGL am1bcc  single point   (the exact ABFE small-mol FF)
#   E_QM(i)  = GFN2-xtb single point                       (first-principles reference)
# Diagnostics: RMSE / MAE / Spearman of relative energies; AND the bound-pose deviation
#   delta_bound = E_MM_rel(bound) - E_QM_rel(bound)
#     delta_bound << 0  -> FF makes the BOUND conformer artificially low -> over-stabilizes
#                          the bound state -> direct ABFE over-bind contributor (cause-①).
#     delta_bound ~ 0 and low RMSE -> FF landscape faithful -> overbind is NOT ring/torsion;
#                          arrow moves to pose (②) or protein-ligand interaction FF.
# d6: first-principles QM probes the empirical-FF wall. $0 on summer pool, minutes.
import os, sys, subprocess, shutil, re, tempfile, json
import numpy as np

HARTREE2KCAL = 627.5094740631
HERE = os.path.dirname(os.path.abspath(__file__))
LIG_SDF = os.environ.get("LIG_SDF", "/tmp/abfe/kos_pose.sdf")
XTB = shutil.which("xtb") or "/home/summer/micromamba/envs/fep/bin/xtb"
NCONF = int(os.environ.get("NCONF", "24"))
WORK = tempfile.mkdtemp(prefix="r11b_")
print(f"[R11b] work={WORK} lig={LIG_SDF} nconf={NCONF}", flush=True)

from openff.toolkit import Molecule, ForceField
from openff.toolkit.utils.nagl_wrapper import NAGLToolkitWrapper
from openff.units import unit as off_unit
from rdkit import Chem
from rdkit.Chem import AllChem
import openmm as mm
from openmm import unit

mol = Molecule.from_file(LIG_SDF, allow_undefined_stereo=True)
if isinstance(mol, list):
    mol = mol[0]
tot_q = int(round(float(mol.total_charge.m_as(off_unit.elementary_charge))))
elems = [a.symbol for a in mol.atoms]
bound_xyz = np.array(mol.conformers[0].m_as(off_unit.angstrom))  # the docked bound pose
print(f"[R11b] n_atoms={mol.n_atoms} charge={tot_q:+d}", flush=True)

# ---- conformer ensemble: bound pose (idx 0) + rdkit ETKDG diverse set --------
rdmol = mol.to_rkit() if hasattr(mol, "to_rkit") else mol.to_rdkit()
rdmol = Chem.AddHs(rdmol, addCoords=True)
params = AllChem.ETKDGv3(); params.randomSeed = 20260606; params.pruneRmsThresh = 0.5
AllChem.EmbedMultipleConfs(rdmol, numConfs=NCONF, params=params)
geoms = [bound_xyz]  # idx 0 = bound
for c in rdmol.GetConformers():
    geoms.append(np.array([[p.x, p.y, p.z] for p in
                           (c.GetAtomPosition(i) for i in range(rdmol.GetNumAtoms()))]))
print(f"[R11b] ensemble size = {len(geoms)} (idx0=bound)", flush=True)

# ---- MM single points (openff-2.1.0 + NAGL, vacuum) --------------------------
NAGLToolkitWrapper().assign_partial_charges(mol, partial_charge_method="openff-gnn-am1bcc-1.0.0.pt")
ff = ForceField("openff-2.1.0.offxml")
omm_sys = ff.create_interchange(mol.to_topology(), charge_from_molecules=[mol]).to_openmm(combine_nonbonded_forces=True)
ctx = mm.Context(omm_sys, mm.VerletIntegrator(1.0 * unit.femtosecond), mm.Platform.getPlatformByName("Reference"))
def mm_sp(xyz):
    ctx.setPositions(xyz * unit.angstrom)
    return ctx.getState(getEnergy=True).getPotentialEnergy().value_in_unit(unit.kilocalorie_per_mole)
E_mm = np.array([mm_sp(g) for g in geoms])

# ---- QM single points (GFN2-xtb, vacuum, fixed geometry) ---------------------
def xtb_sp(xyz, tag):
    p = os.path.join(WORK, f"{tag}.xyz")
    with open(p, "w") as fh:
        fh.write(f"{len(elems)}\n{tag}\n")
        for s, (x, y, z) in zip(elems, xyz):
            fh.write(f"{s} {x:.6f} {y:.6f} {z:.6f}\n")
    env = dict(os.environ); env["OMP_NUM_THREADS"] = "4"
    r = subprocess.run([XTB, os.path.basename(p), "--gfn", "2", "--sp", "--chrg", str(tot_q), "--uhf", "0"],
                       cwd=WORK, capture_output=True, text=True, env=env)
    es = re.findall(r"TOTAL ENERGY\s+(-?\d+\.\d+)\s+Eh", r.stdout + r.stderr)
    return float(es[-1]) * HARTREE2KCAL if es else np.nan
E_qm = np.array([xtb_sp(g, f"c{i}") for i, g in enumerate(geoms)])

# ---- analysis (drop any xtb failures) ----------------------------------------
ok = ~np.isnan(E_qm)
mm_rel = E_mm - E_mm[ok].min()
qm_rel = E_qm - np.nanmin(E_qm[ok])
from scipy.stats import spearmanr, pearsonr
sp = spearmanr(mm_rel[ok], qm_rel[ok]).correlation
pr = pearsonr(mm_rel[ok], qm_rel[ok])[0]
resid = mm_rel[ok] - qm_rel[ok]
rmse = float(np.sqrt(np.mean(resid**2))); mae = float(np.mean(np.abs(resid)))
delta_bound = float(mm_rel[0] - qm_rel[0])  # bound pose MM-rel minus QM-rel

print("\n============== R11b conformer-landscape FF vs QM (rel. energies) ==============", flush=True)
print(f"  ensemble used      = {int(ok.sum())}/{len(geoms)} conformers", flush=True)
print(f"  Spearman rho       = {sp:.3f}   Pearson r = {pr:.3f}", flush=True)
print(f"  RMSE(MM-QM rel)    = {rmse:.2f} kcal/mol   MAE = {mae:.2f}", flush=True)
print(f"  bound-pose MM_rel  = {mm_rel[0]:.2f}   QM_rel = {qm_rel[0]:.2f}", flush=True)
print(f"  delta_bound        = {delta_bound:.2f} kcal/mol  (MM_rel - QM_rel, bound)", flush=True)
if delta_bound < -3.0:
    verdict = (f"FF OVER-stabilizes the bound conformer by {-delta_bound:.1f} kcal/mol vs QM "
               f"-> direct ABFE over-bind contributor -> cause-① (macrocycle FF) CONFIRMED")
elif rmse > 3.0:
    verdict = (f"FF conformational landscape unreliable (RMSE {rmse:.1f}, rho {sp:.2f}) -> FF "
               f"torsion/valence error present; ABFE inherits it -> cause-① SUPPORTED")
else:
    verdict = (f"FF landscape faithful (RMSE {rmse:.1f}, rho {sp:.2f}, bound dev {delta_bound:+.1f}) "
               f"-> overbind NOT from ligand FF -> arrow -> pose(②)/interaction FF")
print(f"  VERDICT: {verdict}", flush=True)
print("===============================================================================", flush=True)

res = dict(n_used=int(ok.sum()), n_total=len(geoms), spearman=float(sp), pearson=float(pr),
           rmse=rmse, mae=mae, mm_rel_bound=float(mm_rel[0]), qm_rel_bound=float(qm_rel[0]),
           delta_bound=delta_bound, charge=tot_q, verdict=verdict,
           E_mm=E_mm.tolist(), E_qm=E_qm.tolist())
with open(os.path.join(HERE, "r11b_confcorr_result.json"), "w") as fh:
    json.dump(res, fh, indent=2)
print("[R11b] wrote r11b_confcorr_result.json", flush=True)
