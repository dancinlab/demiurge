#!/usr/bin/env python3
# SENOLYX R11c — solvent-screening confound test for the R11b MM-vs-QM divergence.
# R11b found openff-2.1.0 vs GFN2 relative-conformer energies diverge a LOT (RMSE 75,
# bound dev 67 kcal/mol) — but in VACUUM, which amplifies intramolecular electrostatics
# the way explicit-solvent ABFE does NOT. Question: how much of that divergence is a
# screenable electrostatic artifact vs a robust FF deficiency?
#
# Test (QM-only, xtb, $0): score the SAME conformer ensemble with GFN2 in VACUUM and in
# implicit water (ALPB). If solvent COMPRESSES the QM relative-energy spread toward the
# MM-comparable range, the vacuum divergence was largely a screenable artifact -> cause-①
# weaker in the real ABFE -> arrow back toward pose(②). If the spread stays large, the FF
# deficiency is robust -> cause-① stands. Also reports MM-vac vs QM-ALPB residual as a
# rough "solution-phase" landscape mismatch (MM here is still vacuum; directional only).
import os, subprocess, shutil, re, tempfile, json
import numpy as np
HARTREE2KCAL = 627.5094740631
HERE = os.path.dirname(os.path.abspath(__file__))
LIG_SDF = os.environ.get("LIG_SDF", "/tmp/abfe/kos_pose.sdf")
XTB = shutil.which("xtb") or "/home/summer/micromamba/envs/fep/bin/xtb"
NCONF = int(os.environ.get("NCONF", "24"))
WORK = tempfile.mkdtemp(prefix="r11c_")

from openff.toolkit import Molecule, ForceField
from openff.toolkit.utils.nagl_wrapper import NAGLToolkitWrapper
from openff.units import unit as off_unit
from rdkit import Chem
from rdkit.Chem import AllChem
import openmm as mm
from openmm import unit

mol = Molecule.from_file(LIG_SDF, allow_undefined_stereo=True)
mol = mol[0] if isinstance(mol, list) else mol
tot_q = int(round(float(mol.total_charge.m_as(off_unit.elementary_charge))))
elems = [a.symbol for a in mol.atoms]
bound = np.array(mol.conformers[0].m_as(off_unit.angstrom))

rd = mol.to_rdkit(); rd = Chem.AddHs(rd, addCoords=True)
p = AllChem.ETKDGv3(); p.randomSeed = 20260606; p.pruneRmsThresh = 0.5
AllChem.EmbedMultipleConfs(rd, numConfs=NCONF, params=p)
geoms = [bound] + [np.array([[c.GetAtomPosition(i).x, c.GetAtomPosition(i).y, c.GetAtomPosition(i).z]
                             for i in range(rd.GetNumAtoms())]) for c in rd.GetConformers()]
print(f"[R11c] ensemble={len(geoms)} charge={tot_q:+d}", flush=True)

# MM (vacuum, openff-2.1.0 + NAGL) — reference
NAGLToolkitWrapper().assign_partial_charges(mol, partial_charge_method="openff-gnn-am1bcc-1.0.0.pt")
ff = ForceField("openff-2.1.0.offxml")
sysmm = ff.create_interchange(mol.to_topology(), charge_from_molecules=[mol]).to_openmm(combine_nonbonded_forces=True)
ctx = mm.Context(sysmm, mm.VerletIntegrator(1.0*unit.femtosecond), mm.Platform.getPlatformByName("Reference"))
def mm_sp(g):
    ctx.setPositions(g*unit.angstrom); return ctx.getState(getEnergy=True).getPotentialEnergy().value_in_unit(unit.kilocalorie_per_mole)
E_mm = np.array([mm_sp(g) for g in geoms])

def xtb_e(g, tag, alpb):
    fp = os.path.join(WORK, f"{tag}.xyz")
    with open(fp,"w") as fh:
        fh.write(f"{len(elems)}\n{tag}\n")
        for s,(x,y,z) in zip(elems,g): fh.write(f"{s} {x:.6f} {y:.6f} {z:.6f}\n")
    cmd=[XTB, os.path.basename(fp), "--gfn","2","--sp","--chrg",str(tot_q),"--uhf","0"]
    if alpb: cmd += ["--alpb","water"]
    env=dict(os.environ); env["OMP_NUM_THREADS"]="4"
    r=subprocess.run(cmd, cwd=WORK, capture_output=True, text=True, env=env)
    es=re.findall(r"TOTAL ENERGY\s+(-?\d+\.\d+)\s+Eh", r.stdout+r.stderr)
    return float(es[-1])*HARTREE2KCAL if es else np.nan
E_qv = np.array([xtb_e(g,f"v{i}",False) for i,g in enumerate(geoms)])
E_qa = np.array([xtb_e(g,f"a{i}",True)  for i,g in enumerate(geoms)])

def rel(x): return x - np.nanmin(x)
mmr, qvr, qar = rel(E_mm), rel(E_qv), rel(E_qa)
def spread(x): return float(np.nanmax(x)-np.nanmin(x)), float(np.nanstd(x))
sp_mm, sd_mm = spread(mmr); sp_qv, sd_qv = spread(qvr); sp_qa, sd_qa = spread(qar)
from scipy.stats import spearmanr
ok=~np.isnan(E_qa)
rmse_va = float(np.sqrt(np.nanmean((mmr[ok]-qar[ok])**2)))   # MM(vac) vs QM(ALPB)
rmse_vv = float(np.sqrt(np.nanmean((mmr[ok]-qvr[ok])**2)))   # MM(vac) vs QM(vac) [~R11b]
compress = sp_qa/sp_qv if sp_qv else float('nan')            # ALPB spread / vacuum spread

print("\n============ R11c solvent-screening confound (rel-energy spreads) ============", flush=True)
print(f"  QM vacuum  spread={sp_qv:7.1f}  std={sd_qv:6.1f} kcal/mol", flush=True)
print(f"  QM ALPB-w  spread={sp_qa:7.1f}  std={sd_qa:6.1f} kcal/mol   (compress {compress:.2f}x)", flush=True)
print(f"  MM vacuum  spread={sp_mm:7.1f}  std={sd_mm:6.1f} kcal/mol", flush=True)
print(f"  RMSE MM(vac)-QM(vac) = {rmse_vv:6.1f}   MM(vac)-QM(ALPB) = {rmse_va:6.1f} kcal/mol", flush=True)
print(f"  bound rel: MM={mmr[0]:.1f}  QM_vac={qvr[0]:.1f}  QM_ALPB={qar[0]:.1f}", flush=True)
if compress < 0.5 and rmse_va < 0.6*rmse_vv:
    v=(f"solvent SCREENS most divergence (QM spread {compress:.2f}x, RMSE {rmse_vv:.0f}->{rmse_va:.0f}) "
       f"-> R11b magnitude largely a VACUUM artifact -> cause-① WEAKER in real ABFE; pose(②) more likely")
elif rmse_va > 3.0:
    v=(f"divergence ROBUST to solvent (RMSE still {rmse_va:.0f} kcal/mol) -> FF deficiency real in "
       f"solution -> cause-① STANDS as overbind contributor")
else:
    v=(f"intermediate: solvent compresses to RMSE {rmse_va:.0f} -> partial FF contribution")
print(f"  VERDICT: {v}", flush=True)
print("=============================================================================", flush=True)
json.dump(dict(spread_qm_vac=sp_qv, spread_qm_alpb=sp_qa, spread_mm=sp_mm, compress=compress,
               rmse_mmvac_qmvac=rmse_vv, rmse_mmvac_qmalpb=rmse_va,
               bound_mm=float(mmr[0]), bound_qv=float(qvr[0]), bound_qa=float(qar[0]), verdict=v),
          open(os.path.join(HERE,"r11c_solvent_result.json"),"w"), indent=2)
print("[R11c] wrote r11c_solvent_result.json", flush=True)
