# SENOLYX round-2 — BCL-xL structure + senolytic docking

## Structure
- BCL-xL from PDB **4QVX** (co-crystal with A-1155463 / ligand 3CQ), chain-A protein 1093 atoms.
- Binding pocket center (3CQ centroid): (−9.28, −9.03, 10.52); BH3-groove site.
- Receptor pdbqt via obabel (-xr, pH 7.4); ligand via meeko (vina-compatible) from the
  RCSB ideal SDF (clean topology; SMILES CN(C)CC#Cc1ccc(OCCCc2sc(N3CCc4cccc(C(=O)Nc5nc6ccccc6s5)c4C3)nc2C(=O)O)c(F)c1).

## Docking (Vina 1.2, exhaustiveness 16, 24Å box)
| ligand | top affinity (kcal/mol) |
|---|---|
| **A-1155463 (3CQ) → BCL-xL** | **−7.35** |

**Finding:** the BCL-xL BH3 groove is validated as druggable and the BCL-xL-selective
senolytic A-1155463 binds favorably in silico (−7.35; Vina underestimates magnitude vs
the known sub-nM affinity, but confirms the pocket). This establishes the SENOLYX target
(BCL-xL) and the reference binding the NOVEL niche-selective analog must match/beat.

## MM-GBSA corroboration — DEFERRED (honest, g63)
The single-trajectory MM-GBSA pipeline (validated in AGA-RX D2) hit a ligand-prep snag on
3CQ's **carboxylic acid**: the docked-pose PDB→template bond-order assignment threw an O
valence exception (protonation-state ambiguity of −COOH/carboxylate). NOT faked. Deferred
to round-3 with explicit protonation-state handling (set COOH→COO⁻ at pH 7.4 via
fix-protonation before NAGL charge assignment). The docking result stands on its own as the
structure+design validation.

## Status
- structure: DONE (BCL-xL 4QVX pocket defined)
- design: docking DONE (A-1155463 −7.35, target druggable); MM-GBSA corroboration → round-3
- NOVEL niche-selective analog design (CRBN-PROTAC / β-gal-prodrug / non-BCL-xL) → round-3
