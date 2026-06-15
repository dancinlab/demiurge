#!/usr/bin/env python3
# Extract a clash-free BOUND ligand pose from a co-crystal PDB:
#   heavy-atom coords come from the PDB HETATM (the real bound pose), bond orders +
#   hydrogens from the RCSB ideal SDF used as a template. Writes lig_<RESN>_bound.sdf
#   with the ligand IN the receptor frame (no recenter needed downstream).
#   usage: extract_pose.py <PDB> <RESN> <CHAIN> <ideal.sdf> <out.sdf>
import sys
from rdkit import Chem
from rdkit.Chem import AllChem
pdb, resn, chain, ideal_sdf, out = sys.argv[1:6]

# 1) pull the het residue out of the PDB as a residue-only PDB block
lines = [l for l in open(pdb)
         if l.startswith("HETATM") and l[17:20].strip() == resn and l[21] == chain]
# keep ONE copy (first occurrence's resSeq)
resseq = lines[0][22:26]
block = "".join(l for l in lines if l[22:26] == resseq) + "END\n"
bound = Chem.MolFromPDBBlock(block, sanitize=False, removeHs=False)
if bound is None:
    print("BOUND_PARSE_FAIL"); sys.exit(3)

# 2) template (correct bond orders + H topology) from the ideal SDF
templ = Chem.MolFromMolFile(ideal_sdf, sanitize=True, removeHs=False)
templ_noH = Chem.RemoveHs(templ)

# 3) assign template bond orders onto the bound heavy-atom skeleton
try:
    fixed = AllChem.AssignBondOrdersFromTemplate(templ_noH, bound)
except Exception as e:
    print("BONDORDER_FAIL", e); sys.exit(4)

# 4) add hydrogens at the bound coordinates (addCoords keeps the pose)
fixed = Chem.AddHs(fixed, addCoords=True)
Chem.SanitizeMol(fixed)
w = Chem.SDWriter(out); w.write(fixed); w.close()
print(f"BOUND_OK {out} heavy={templ_noH.GetNumAtoms()} total={fixed.GetNumAtoms()}")
