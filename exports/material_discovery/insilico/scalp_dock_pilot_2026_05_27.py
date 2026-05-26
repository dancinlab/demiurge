#!/usr/bin/env python3
"""SRD5A2 docking pilot — 9 ligand descriptor + PDBQT prep"""
import os
from rdkit import Chem
from rdkit.Chem import AllChem, Descriptors, Lipinski
from meeko import MoleculePreparation, PDBQTWriterLegacy

ligands = {
    "Finasteride (ref)":  "CC12CCC3C(C1CCC2(C(=O)NC(C)(C)C)O)CCC4=CC(=O)NCC34C",
    "Dutasteride":        "CC12CCC3C(C1CCC2C(=O)NC4=C(C=C(C=C4)C(F)(F)F)C(F)(F)F)CC=C5C3=CC(=O)NC5",
    "Caffeine":           "CN1C=NC2=C1C(=O)N(C(=O)N2C)C",
    "Biotin":             "O=C1N[C@H]2CS[C@@H](CCCCC(=O)O)[C@@H]2N1",
    "SalicylicAcid":      "O=C(O)c1ccccc1O",
    "Niacinamide":        "NC(=O)c1cccnc1",
    "Dexpanthenol":       "CC(C)(CO)C(O)C(=O)NCCCO",
    "L-Menthol":          "CC(C)C1CCC(C)CC1O",
    "Adenosine":          "Nc1ncnc2c1ncn2[C@@H]1O[C@H](CO)[C@@H](O)[C@H]1O",
    "Procapil (acetyl)":  "CC(=O)NCCCC(=O)NC(CCCNC(=N)N)C(=O)O",
}

os.makedirs("/tmp/lig", exist_ok=True)
hdr = "{:22s} {:>7s} {:>6s} {:>4s} {:>4s} {:>6s} {:>5s} {:>4s} {:>7s}"
print(hdr.format("Compound", "MW", "logP", "HBD", "HBA", "TPSA", "RotB", "Ro5", "PDBQT"))
print("-" * 80)
for name, smi in ligands.items():
    mol = Chem.MolFromSmiles(smi)
    if not mol:
        print("{:22s} SMILES PARSE FAIL".format(name)); continue
    mol_h = Chem.AddHs(mol)
    pdbqt_ok = "ERR"
    try:
        AllChem.EmbedMolecule(mol_h, randomSeed=42)
        AllChem.MMFFOptimizeMolecule(mol_h)
        prep = MoleculePreparation()
        prep.prepare(mol_h)
        pdbqt, _, _ = PDBQTWriterLegacy.write_string(prep.setup)
        slug = name.split()[0].replace("-", "")
        with open("/tmp/lig/{}.pdbqt".format(slug), "w") as f:
            f.write(pdbqt)
        pdbqt_ok = "{}B".format(len(pdbqt))
    except Exception as e:
        pdbqt_ok = "ERR:" + type(e).__name__
    mw = Descriptors.MolWt(mol)
    logp = Descriptors.MolLogP(mol)
    hbd = Lipinski.NumHDonors(mol)
    hba = Lipinski.NumHAcceptors(mol)
    tpsa = Descriptors.TPSA(mol)
    rotb = Lipinski.NumRotatableBonds(mol)
    ro5 = sum([mw <= 500, logp <= 5, hbd <= 5, hba <= 10])
    fmt = "{:22s} {:7.1f} {:+6.2f} {:4d} {:4d} {:6.1f} {:5d} {:4d} {:>7s}"
    print(fmt.format(name, mw, logp, hbd, hba, tpsa, rotb, ro5, pdbqt_ok))

print()
print("Ro5 = Lipinski rule-of-five (4 = excellent · 3 = moderate · <=2 = poor)")
print("PDBQT files at /tmp/lig/*.pdbqt (Vina docking ready)")
