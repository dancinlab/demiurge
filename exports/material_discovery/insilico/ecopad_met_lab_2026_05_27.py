#!/usr/bin/env python3
"""Combined met lab pipeline:
   ECOPAD: RDKit conformer + radius of gyration + diffusion estimate (no force field needed)
   GARGLE: S.mutans GtfB docking (3AIE) — antibacterial cosmetic"""
import os, subprocess, sys, glob, math, statistics, urllib.request
from rdkit import Chem
from rdkit.Chem import AllChem, Descriptors, rdMolDescriptors

print("=" * 70)
print("PART 1 — ECOPAD: conformer + R_g + Stokes-Einstein diffusion estimate")
print("=" * 70)

molecules = {
    "Cellobiose":   "OC[C@H]1O[C@@H](O[C@H]2[C@H](O)[C@@H](O)O[C@H](CO)[C@@H]2O)[C@H](O)[C@@H](O)[C@@H]1O",
    "Glycerin":     "OCC(O)CO",
    "Xylitol":      "OCC(O)C(O)C(O)CO",
    "LacticAcid":   "CC(O)C(=O)O",
    "CitricAcid":   "OC(=O)CC(O)(CC(=O)O)C(=O)O",
    "CMC_unit":     "OC(=O)C[C@H]1O[C@H](CO)[C@@H](O)[C@H](O)[C@@H]1O",
    "Chitosan_unit":"OC[C@H]1O[C@H](O)[C@H](N)[C@@H](O)[C@@H]1O",
    "Terpinen4ol":  "CC(C)C1CCC(C)=CC1O",
}

# Stokes-Einstein: D = kT / (6 * pi * eta * r_h)
# kT @ 298K = 4.11e-21 J · eta_water = 8.9e-4 Pa·s
KT = 4.11e-21
ETA = 8.9e-4
SIX_PI_ETA = 6 * math.pi * ETA

hdr = "{:14s} {:>7s} {:>7s} {:>8s} {:>10s} {:>12s} {:>8s}"
print(hdr.format("Compound", "MW", "Heavy", "R_g (Å)", "Volume(Å³)", "D (m²/s)", "logP"))
print("-" * 78)

for name, smi in molecules.items():
    mol = Chem.MolFromSmiles(smi)
    if not mol:
        print(name, "SMILES FAIL"); continue
    mh = Chem.AddHs(mol)
    try:
        # Generate 10 conformers, pick lowest energy
        cids = AllChem.EmbedMultipleConfs(mh, numConfs=10, randomSeed=42)
        energies = []
        for cid in cids:
            try:
                ff = AllChem.MMFFGetMoleculeForceField(mh, AllChem.MMFFGetMoleculeProperties(mh), confId=cid)
                if ff is None: continue
                ff.Minimize(maxIts=200)
                energies.append((cid, ff.CalcEnergy()))
            except Exception:
                pass
        if not energies:
            print("{:14s} conformer gen FAIL".format(name)); continue
        best_cid, _ = min(energies, key=lambda x: x[1])
        # Radius of gyration
        conf = mh.GetConformer(best_cid)
        coords = [conf.GetAtomPosition(i) for i in range(mh.GetNumAtoms())]
        cx = sum(c.x for c in coords) / len(coords)
        cy = sum(c.y for c in coords) / len(coords)
        cz = sum(c.z for c in coords) / len(coords)
        r_g = math.sqrt(sum((c.x-cx)**2 + (c.y-cy)**2 + (c.z-cz)**2 for c in coords) / len(coords))
        # Hydrodynamic radius estimate: r_h ~ r_g * 1.29 (sphere-like approximation)
        r_h_m = r_g * 1.29e-10  # Å → m
        D = KT / (SIX_PI_ETA * r_h_m)  # m²/s
        mw = Descriptors.MolWt(mol)
        heavy = mol.GetNumHeavyAtoms()
        vol = rdMolDescriptors.CalcExactMolWt(mol) / 0.6  # crude estimate
        logp = Descriptors.MolLogP(mol)
        print(hdr.format(name, "{:.1f}".format(mw), str(heavy), "{:.2f}".format(r_g),
                         "{:.1f}".format(vol), "{:.2e}".format(D), "{:+.2f}".format(logp)))
    except Exception as e:
        print("{:14s} ERR: {}".format(name, type(e).__name__))

print()
print("D (m²/s) = Stokes-Einstein diffusion (298K, water) — 작을수록 swelling 흡수 느림")
print("R_g (Å) = radius of gyration — 분자 크기 (compactness)")

# ============================================================
print()
print("=" * 70)
print("PART 2 — GARGLE: S.mutans GtfB docking (3AIE) attempt")
print("=" * 70)

PDB = "/tmp/3AIE.pdb"
if not os.path.exists(PDB):
    try:
        urllib.request.urlretrieve("https://files.rcsb.org/download/3AIE.pdb", PDB)
    except Exception as e:
        print("3AIE download FAIL:", e); sys.exit(0)

with open(PDB) as f: lines = f.readlines()
atom_count = sum(1 for l in lines if l.startswith("ATOM"))
hetatm_codes = {}
for l in lines:
    if l.startswith("HETATM"):
        c = l[17:20].strip()
        if c in ("HOH","WAT","SO4","CL","NA","MG","CA","K","GOL","EDO"): continue
        hetatm_codes[c] = hetatm_codes.get(c, 0) + 1
print("3AIE: ATOM={} | HET candidates={}".format(atom_count, hetatm_codes))

# GARGLE ligands
gargle_ligs = {
    "CPC":         "CCCCCCCCCCCCCCCC[N+]1=CC=CC=C1",
    "CHX":         "NC(=N)NC(=N)NCCCCCCNC(=N)NC(=N)Nc1ccc(Cl)cc1",
    "Xylitol":     "OCC(O)C(O)C(O)CO",
    "Tranexamic":  "NCC1CCC(C(=O)O)CC1",
    "CitricAcid":  "OC(=O)CC(O)(CC(=O)O)C(=O)O",
    "EGCG_GreenT": "Oc1cc(O)c2C[C@H](OC(=O)c3cc(O)c(O)c(O)c3)[C@H](Oc2c1)c1cc(O)c(O)c(O)c1",
}

if not hetatm_codes:
    print("3AIE has no active-site HET — try alternative: 3AIB or 5O0E")
    # Try alternative PDB
    for alt_id in ["3AIB", "5O0E", "5O0G"]:
        alt_path = "/tmp/{}.pdb".format(alt_id)
        if not os.path.exists(alt_path):
            try:
                urllib.request.urlretrieve("https://files.rcsb.org/download/{}.pdb".format(alt_id), alt_path)
            except Exception: continue
        with open(alt_path) as f: alt_lines = f.readlines()
        codes = {}
        for l in alt_lines:
            if l.startswith("HETATM"):
                c = l[17:20].strip()
                if c in ("HOH","WAT","SO4","CL","NA","MG","CA","K","GOL","EDO","1PE","PEG"): continue
                codes[c] = codes.get(c, 0) + 1
        print("  {}: ATOM={} HET={}".format(alt_id, sum(1 for l in alt_lines if l.startswith("ATOM")), codes))
    print()
    print("GARGLE docking: PDB selection 필요 — alternative PDB 결과 보고 후 진행")
else:
    print("GARGLE: 3AIE 사용 가능 — receptor prep 단계 진입 (별도 스크립트로 진행 권고)")
