#!/usr/bin/env python3
"""η: 추가 도메인 conformer · ε: TPASTE gingipain docking · ζ: INSECT OR receptor docking"""
import os, subprocess, sys, glob, math, urllib.request
from rdkit import Chem
from rdkit.Chem import AllChem, Descriptors, Lipinski

KT = 4.11e-21; ETA = 8.9e-4; SIX_PI_ETA = 6 * math.pi * ETA

def conformer(name, smi):
    mol = Chem.MolFromSmiles(smi)
    if not mol: return None
    mh = Chem.AddHs(mol)
    try:
        cids = AllChem.EmbedMultipleConfs(mh, numConfs=5, randomSeed=42)
        energies = []
        for cid in cids:
            ff = AllChem.MMFFGetMoleculeForceField(mh, AllChem.MMFFGetMoleculeProperties(mh), confId=cid)
            if ff: ff.Minimize(maxIts=100); energies.append((cid, ff.CalcEnergy()))
        if not energies: return None
        best_cid, _ = min(energies, key=lambda x: x[1])
        conf = mh.GetConformer(best_cid)
        coords = [conf.GetAtomPosition(i) for i in range(mh.GetNumAtoms())]
        cx = sum(c.x for c in coords) / len(coords)
        cy = sum(c.y for c in coords) / len(coords)
        cz = sum(c.z for c in coords) / len(coords)
        r_g = math.sqrt(sum((c.x-cx)**2 + (c.y-cy)**2 + (c.z-cz)**2 for c in coords) / len(coords))
        D = KT / (SIX_PI_ETA * (r_g * 1.29e-10))
        return (Descriptors.MolWt(mol), r_g, D, Descriptors.MolLogP(mol))
    except Exception: return None

print("=" * 70)
print("η: 추가 COSME 도메인 conformer + Stokes-Einstein D")
print("=" * 70)

extra = {
    "COSME-FRAGRANCE": [("Linalool","CC(=CCCC(C)(O)C=C)C"), ("Limonene","CC(=C)C1CCC(C)=CC1"), ("Citral","CC(C)=CCCC(C)=CC=O"), ("BenzylAlcohol","OCc1ccccc1")],
    "COSME-BABY":      [("Ceramide_NP","CCCCCCCCCCCCCC(O)C(NC(=O)CCCCCCCCCCCCCC)CO"), ("Panthenol","CC(C)(CO)C(O)C(=O)NCCCO"), ("Cica","OC[C@H]1OC(=O)C2(O)C[C@H](O)C[C@@]34CC[C@H](O)[C@@H](C)C[C@H]3[C@H](C)CCC2[C@@]14C")],
    "COSME-MENS":      [("Panthenol","CC(C)(CO)C(O)C(=O)NCCCO"), ("Allantoin","NC(=O)NC1NC(=O)NC1=O"), ("Menthol","CC(C)C1CCC(C)CC1O"), ("Caffeine","CN1C=NC2=C1C(=O)N(C(=O)N2C)C")],
    "COSME-VEGAN":     [("ResveratrolPlant","Oc1ccc(/C=C/c2cc(O)cc(O)c2)cc1"), ("EGCGreenT","Oc1cc(O)c2C[C@H](OC(=O)c3cc(O)c(O)c(O)c3)[C@H](Oc2c1)c1cc(O)c(O)c(O)c1"), ("BakuchiolVegan","CC(C)=CCC/C(C)=C/CCC1=CC=C(O)C=C1")],
    "COSME-BODY":      [("SheaButter_OleicA","CCCCCCCC/C=C\\CCCCCCCC(=O)O"), ("Ceramide_NP","CCCCCCCCCCCCCC(O)C(NC(=O)CCCCCCCCCCCCCC)CO"), ("HyaluronicA","OC1C(O)C(OC2C(NC(C)=O)C(O)OC(CO)C2O)C(C(=O)O)OC1O")],
    "COSME-NAIL":      [("Nitrocellulose_unit","O=[N+]([O-])OC[C@H]1OC(OC)[C@H](O)[C@@H](O)[C@@H]1O"), ("ButylAcetate","CCCCOC(C)=O")],
    "COSME-MAKEUP":    [("IronOxide_red","[Fe]=O"), ("TitaniumDiox","O=[Ti]=O"), ("MicaSi","O=[Si](=O)O")],
    "COSME-BOOSTER":   [("LED_proxy_VitC","OC1=C(O)C(=O)O[C@@H]1[C@@H](O)CO")],
    "QD-BAND":         [("PIB_unit","CC(C)(C)CC"), ("AcrylateAdh","CC(=O)OCC"), ("Chitosan","OC[C@H]1O[C@H](O)[C@H](N)[C@@H](O)[C@@H]1O")],
    "QD-MASK":         [("MeltblownPP","CCCCCCCCCC"), ("NanoFiberPVDF_unit","FC(F)C(C)C"), ("CelluloseAcetate","OC1OC(COC(C)=O)C(O)C(O)C1OC(C)=O")],
}

print("{:18s} {:18s} {:>6s} {:>6s} {:>6s} {:>10s}".format("Domain","Compound","MW","R_g","logP","D(m²/s)"))
print("-" * 70)
for dom, ligs in extra.items():
    for name, smi in ligs:
        r = conformer(name, smi)
        if r is None:
            print("{:18s} {:18s} FAIL".format(dom, name)); continue
        mw, r_g, D, logp = r
        print("{:18s} {:18s} {:>6.1f} {:>6.2f} {:>+6.2f} {:>10.2e}".format(dom, name, mw, r_g, logp, D))

# ε: TPASTE gingipain docking
print()
print("=" * 70)
print("ε: TPASTE P.gingivalis gingipain docking attempt")
print("=" * 70)
for pdbid in ["4RBM", "6IO1", "3LD2"]:
    path = "/tmp/{}.pdb".format(pdbid)
    if not os.path.exists(path):
        try: urllib.request.urlretrieve("https://files.rcsb.org/download/{}.pdb".format(pdbid), path)
        except: print("{} download FAIL".format(pdbid)); continue
    with open(path) as f: lines = f.readlines()
    hetatm = {}
    for l in lines:
        if l.startswith("HETATM"):
            c = l[17:20].strip()
            if c in ("HOH","WAT","SO4","CL","NA","MG","CA","K","GOL","EDO","1PE","PEG","PGE"): continue
            hetatm[c] = hetatm.get(c, 0) + 1
    atom_count = sum(1 for l in lines if l.startswith("ATOM"))
    print("{}: ATOM={} | HET={}".format(pdbid, atom_count, hetatm))

# ζ: INSECT mosquito OR docking
print()
print("=" * 70)
print("ζ: INSECT mosquito OR / Orco PDB attempt")
print("=" * 70)
for pdbid in ["7RVK", "6C70", "6C71", "6N3M"]:
    path = "/tmp/{}.pdb".format(pdbid)
    if not os.path.exists(path):
        try: urllib.request.urlretrieve("https://files.rcsb.org/download/{}.pdb".format(pdbid), path)
        except: print("{} download FAIL".format(pdbid)); continue
    with open(path) as f: lines = f.readlines()
    hetatm = {}
    for l in lines:
        if l.startswith("HETATM"):
            c = l[17:20].strip()
            if c in ("HOH","WAT","SO4","CL","NA","MG","CA","K","GOL","EDO","1PE","PEG","PGE"): continue
            hetatm[c] = hetatm.get(c, 0) + 1
    atom_count = sum(1 for l in lines if l.startswith("ATOM"))
    hdr = lines[0][:60].strip() if lines else "?"
    print("{}: ATOM={} | HET={} | {}".format(pdbid, atom_count, hetatm, hdr))
