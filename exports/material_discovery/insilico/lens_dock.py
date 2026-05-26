#!/usr/bin/env python3
"""LENS Acanthamoeba protease docking — PHMB·MPDA·PQ-1·9 cosmetic actives × AhCP (PDB 3W4C)"""
import os, subprocess, sys, glob
from rdkit import Chem
from rdkit.Chem import AllChem, Descriptors, Lipinski
from meeko import MoleculePreparation, PDBQTWriterLegacy

# LENS-specific ligands
LENS_ligands = {
    "PHMB_n4":             "NC(=N)NCCCCCCNC(=N)NCCCCCCNC(=N)NCCCCCCNC(=N)N",
    "Polyquat-1":          "C[N+](C)(C)CCCC[N+](C)(C)C.[Cl-].[Cl-]",
    "MPDA":                "CCCCCCCCCCCCCC(=O)NCCCN(C)C",
    "Poloxamer":           "OCCOCCOCCOCC(C)OCC(C)OCC(C)OCCOCCOCCO",
    "EDTA":                "OC(=O)CN(CCN(CC(=O)O)CC(=O)O)CC(=O)O",
    "Tocopherol":          "CC1=C(C)C2=C(CCC(C)(CCCC(C)CCCC(C)CCCC(C)C)O2)C(C)=C1O",
    "HyaluronicAcid":      "OC1C(O)C(OC2C(NC(C)=O)C(O)OC(CO)C2O)C(C(=O)O)OC1O",
    "CitricAcid":          "OC(=O)CC(O)(CC(=O)O)C(=O)O",
}

os.makedirs("/tmp/lig_lens", exist_ok=True)
print("=== LENS ligand PDBQT prep ===")
for name, smi in LENS_ligands.items():
    mol = Chem.MolFromSmiles(smi)
    if not mol:
        print("{:18s} SMILES FAIL".format(name)); continue
    mol_h = Chem.AddHs(mol)
    try:
        AllChem.EmbedMolecule(mol_h, randomSeed=42)
        AllChem.MMFFOptimizeMolecule(mol_h)
        prep = MoleculePreparation()
        prep.prepare(mol_h)
        pdbqt, _, _ = PDBQTWriterLegacy.write_string(prep.setup)
        with open("/tmp/lig_lens/{}.pdbqt".format(name), "w") as f:
            f.write(pdbqt)
        print("{:18s} {:5d}B".format(name, len(pdbqt)))
    except Exception as e:
        print("{:18s} ERR: {}".format(name, type(e).__name__))

# Acanthamoeba PDB candidates
print("\n=== Acanthamoeba PDB candidates ===")
import urllib.request
candidates = ["6L8H", "3W4C", "5O60", "4QR3"]
for pdbid in candidates:
    path = "/tmp/{}.pdb".format(pdbid)
    if not os.path.exists(path):
        try:
            urllib.request.urlretrieve("https://files.rcsb.org/download/{}.pdb".format(pdbid), path)
        except Exception:
            print("{}: download FAIL".format(pdbid)); continue
    with open(path) as f:
        lines = f.readlines()
    hetatm = sum(1 for l in lines if l.startswith("HETATM") and l[17:20].strip() not in ("HOH","WAT","SO4","CL","NA","MG"))
    atom_count = sum(1 for l in lines if l.startswith("ATOM"))
    header = lines[0] if lines else "?"
    print("{}: ATOM={:5d} HETATM={:4d} | {}".format(pdbid, atom_count, hetatm, header[:60].strip()))
