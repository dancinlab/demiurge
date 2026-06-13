#!/usr/bin/env python3
# SENOLYX R12 — build the RBFE validation congeneric pair in the HSP90-bound frame.
# Research-grounded (deep research 2026-06-06): the ONLY clean matched experimental
# congeneric DDG_bind for the geldanamycin class is 17-AAG <-> 17-AG (C17: allylamino
# vs amino), same paper cb600224w, same redox state. We build them from the existing
# 17-DMAG bound pose (kos_pose.sdf, quinone form) via constrained embedding onto the
# shared ansamycin macrocycle core, so all three sit in the identical pocket frame.
# Quinone form kept for all (matches the ABFE/R11 pose) -> validate vs DDG_exp(quinone)
# ~ -1.9 kcal/mol (17-AAG -> 17-AG, 17-AG tighter); hydroquinone analog = -0.65.
import os, sys
from rdkit import Chem
from rdkit.Chem import AllChem, rdFMCS

HERE = os.path.dirname(os.path.abspath(__file__))
TEMPLATE = os.environ.get("TEMPLATE", "/tmp/abfe/kos_pose.sdf")  # 17-DMAG bound pose

# C17 substituent edits on the shared 17-DMAG SMILES (quinone core identical):
SMILES = {
    # 17-DMAG: ...C(NCCN(C)C)=...   (reference, already have the bound pose)
    "17DMAG": "CO[C@H]1C=CC=C(C)C(=O)NC2=CC(=O)C(NCCN(C)C)=C(C[C@@H](C)C[C@H](OC)[C@H](O)[C@@H](C)C=C(C)[C@@H]1OC(N)=O)C2=O",
    "17AAG":  "CO[C@H]1C=CC=C(C)C(=O)NC2=CC(=O)C(NCC=C)=C(C[C@@H](C)C[C@H](OC)[C@H](O)[C@@H](C)C=C(C)[C@@H]1OC(N)=O)C2=O",
    "17AG":   "CO[C@H]1C=CC=C(C)C(=O)NC2=CC(=O)C(N)=C(C[C@@H](C)C[C@H](OC)[C@H](O)[C@@H](C)C=C(C)[C@@H]1OC(N)=O)C2=O",
}

tmpl = Chem.MolFromMolFile(TEMPLATE, removeHs=False, sanitize=True)
if tmpl is None:
    sys.exit("template load failed")
print(f"[R12] template atoms(H incl)={tmpl.GetNumAtoms()}", flush=True)

def build(name, smi):
    probe = Chem.AddHs(Chem.MolFromSmiles(smi))
    # MCS on heavy atoms -> shared core (macrocycle+quinone, excludes the C17 tail diff)
    mcs = rdFMCS.FindMCS([Chem.RemoveHs(tmpl), Chem.RemoveHs(probe)],
                         bondCompare=rdFMCS.BondCompare.CompareOrderExact,
                         atomCompare=rdFMCS.AtomCompare.CompareElements,
                         ringMatchesRingOnly=True, completeRingsOnly=True, timeout=60)
    core_q = Chem.MolFromSmarts(mcs.smartsString)
    t_match = tmpl.GetSubstructMatch(core_q)
    p_match = probe.GetSubstructMatch(core_q)
    if not t_match or not p_match:
        print(f"[R12][{name}] MCS match failed (t={len(t_match)} p={len(p_match)})", flush=True); return None
    # coordmap: probe core atom -> template 3D coord
    conf_t = tmpl.GetConformer()
    cmap = {p_match[i]: conf_t.GetAtomPosition(t_match[i]) for i in range(len(p_match))}
    ok = AllChem.EmbedMolecule(probe, coordMap=cmap, randomSeed=20260606, maxAttempts=200)
    if ok != 0:
        print(f"[R12][{name}] embed retry (basic)", flush=True)
        AllChem.EmbedMolecule(probe, randomSeed=20260606)
    # light MMFF cleanup of the NEW substituent while restraining core to template
    ff = AllChem.MMFFGetMoleculeForceField(probe, AllChem.MMFFGetMoleculeProperties(probe))
    if ff:
        for pa in p_match: ff.AddFixedPoint(pa)
        ff.Minimize(maxIts=500)
    out = os.path.join(HERE, f"{name}.sdf")
    w = Chem.SDWriter(out); w.write(probe); w.close()
    print(f"[R12][{name}] core={len(p_match)} atoms matched -> wrote {name}.sdf ({probe.GetNumAtoms()} atoms)", flush=True)
    return out

for n, s in SMILES.items():
    build(n, s)
print("[R12] done — congeneric set in bound frame: 17DMAG.sdf 17AAG.sdf 17AG.sdf", flush=True)
print("[R12] RBFE edge = 17AAG <-> 17AG  (DDG_exp quinone ~ -1.9, hydroquinone -0.65; cb600224w)", flush=True)
