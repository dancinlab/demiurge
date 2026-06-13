# AGA-RX Round-3 — AR Off-Target Gate: VALIDATION (redock RMSD gate)

date: 2026-06-03 · host: mini (macOS arm64) · engine: **AutoDock Vina v1.2.7**
toolchain: micromamba env `dock` (vina 1.2.7 · openbabel 3.1.0 · meeko 0.7.1 · rdkit 2025.09.5)
target: **AR-LBD, PDB 2AM9**, chain A · native co-crystal ligand = **TES (testosterone, C19H28O2)**

## TL;DR

> **VALIDATION GATE = PASS.** Native testosterone redocks to **1.27 Å RMSD (rigid)** /
> **1.23 Å RMSD (flexible side chains)** to the crystal pose — both well under the 2 Å
> threshold. The round-2 "DHT lands ~6 Å off native" result was **NOT** a scoring-function
> wall: it was two reproducible setup bugs (below). With them fixed, rigid Vina already
> reproduces the buried orthosteric steroid pose to <1.3 Å, so the positive control is
> re-established and comparative ΔG is now trustworthy.

## Root cause of the round-2 "6 Å miss" (two independent bugs)

1. **Docking box centered 24 Å off the pocket.** Round-2 used box center
   `(2.34, 4.63, 1.00)`. The true native-TES centroid (computed from the 2AM9 crystal
   ligand, identical coordinate frame as the apo receptor) is **(26.767, 2.339, 4.632)**.
   The round-2 center is the native centroid with its components scrambled/dropped
   (`2.34` = native y, `4.63` = native z, but placed as x,y) → the search box sat ~24 Å
   away from the orthosteric site. Any pose it found was a surface artifact.

2. **The redock "testosterone" ligand was a truncated C18 molecule.** The round-3
   `TES_fresh` SMILES `C[C@]12CC[C@H](O)...` encodes **C18H28O2** (one angular methyl
   missing); real testosterone is **C19H28O2** (rdkit-verified). The redock therefore
   compared a wrong molecule against the C19 native — RMSD atom-matching even failed on
   the element count (19 C native vs 18 C pose).

Both were fixed here: box re-centered on the true native centroid; ligand re-prepared from
the rdkit-verified canonical testosterone SMILES (PubChem CID 6013).

## Method (corrected)

- box center **(26.767, 2.339, 4.632)**, size **20³ Å**, `--exhaustiveness 64`, `--seed 42`,
  `--num_modes 20`.
- ligand prep: canonical SMILES → `obabel --gen3d -p 7.4` → `mk_prepare_ligand.py` (verified
  21 heavy atoms = 19 C + 2 O).
- **flexible receptor** (`mk_prepare_receptor.py -f`): 8 pocket side chains made flexible —
  **Asn705, Gln711, Met742, Met745, Arg752, Phe764, Met780, Thr877** (the H-bond anchors +
  the flexible Met cavity + Phe764), `--read_pdb` (prody bypassed; numpy-incompat), altloc A.
- RMSD: symmetry-naive heavy-atom Hungarian matcher (`validation/rmsd.py`), ligand-only
  (flex side-chain atoms excluded via BEGIN_RES/END_RES). Reported value is an **upper bound**
  (no internal-symmetry permutation).

## Result — REDOCK RMSD GATE

| redock mode | top-pose ΔG (kcal/mol) | top-pose RMSD to native | best-of-top-5 RMSD | gate (<2 Å) |
|---|---|---|---|---|
| **rigid** (corrected box + correct ligand) | **−9.97** | **1.27 Å** | 1.27 Å | ✅ PASS |
| **flexible** (8 pocket side chains) | **−10.02** | **1.23 Å** | **1.10 Å** (model 8) | ✅ PASS |

All top-5 modes of both runs sit between 1.0–2.1 Å; the #1 (best-affinity) pose is the
native-like pose in both. The scoring function **does** resolve the orthosteric AR pose.

artifacts:
- `validation/TES_correct.pdbqt` — corrected C19 testosterone ligand
- `validation/TES_correct_rigid_redock.pdbqt` — rigid redock poses (top = 1.27 Å)
- `validation/2AM9_flex_{rigid,flex}.pdbqt` — flexible-receptor input (8 flexres)
- `validation/TES_flex_redock.pdbqt` — flex redock poses (top = 1.23 Å)
- `validation/rmsd.py` — heavy-atom Hungarian RMSD (ligand-only, flex-aware)
- `validation/hbond_signature.py` — AR-agonism anchor-contact analyzer

## Consequence for the gate

The round-2 🟠 INCONCLUSIVE was driven by a broken positive control (controls compressed
into a −5.5..−5.9 band, redock 6 Å off). With the control re-established at <1.3 Å and the
agonists DHT/TES now scoring −9.5..−9.9 in the **correct** pocket, the gate has discriminating
power. The per-lead verdict is in `VERDICT.md`.
