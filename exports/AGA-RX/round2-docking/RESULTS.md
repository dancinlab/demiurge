# AGA-RX Round-2 Docking — MEASURED ΔG + AR Off-Target Gate

date: 2026-06-03 · host: mini (macOS arm64) · engine: **AutoDock Vina v1.2.7**
toolchain: local micromamba env `dock` (vina 1.2.7 · openbabel 3.1.0 · meeko 0.7.1 · rdkit 2025.09.5 · prody 2.5.0)
ligand prep: SMILES → obabel `--gen3d -p 7.4` → meeko `mk_prepare_ligand.py`
receptor prep: meeko `mk_prepare_receptor.py -p -a` (rigid, Gasteiger)
All ΔG are MEASURED Vina top-pose affinities (kcal/mol), seed=42. No fabricated values (d6/g63).

This converts the two DEFERRED dockings (PATH A, PATH B) to MEASURED, and runs the
gating AR-LBD off-target screen with pre-registered falsifier + steroid positive controls.

---

## 1. Master results table

| ligand | target | box | ΔG (kcal/mol) | verdict |
|---|---|---|---|---|
| WAY-316606 | SFRP1-CRD (Q8N474) | 24³ exh32 | **−7.77** | ✅ on-band (−5..−8), not artifact |
| 2-naphthylguanidine | LRP6 PE3 (3S2K) | 24³ exh16 | **−7.165** | PATH-B rank #1 |
| 4-guanidinobenzoic_acid | LRP6 PE3 | 24³ exh16 | **−7.164** | PATH-B rank #2 |
| tyramine-guanidine_hybrid | LRP6 PE3 | 24³ exh16 | **−6.87** | PATH-B rank #3 |
| 4-hydroxyphenylguanidine | LRP6 PE3 | 24³ exh16 | −6.415 | #4 |
| phenethyl-guanidine | LRP6 PE3 | 24³ exh16 | −6.408 | #5 |
| tryptamine | LRP6 PE3 | 24³ exh16 | −6.38 | #6 |
| 4-aminobenzamidine | LRP6 PE3 | 24³ exh16 | −6.32 | #7 |
| naphthyl-ethylenediamine | LRP6 PE3 | 24³ exh16 | −6.203 | #8 |
| DHT (dihydrotestosterone) | AR-LBD (2AM9) | 18³ exh48 | −5.57 | AR positive control |
| finasteride | AR-LBD (2AM9) | 18³ exh48 | −5.901 | AR positive control |
| testosterone | AR-LBD (2AM9) | 18³ exh48 | −5.499 | AR positive control |
| WAY-316606 | AR-LBD (2AM9) | 18³ exh48 | −6.199 | 🔴 see gate §4 |
| 2-naphthylguanidine | AR-LBD (2AM9) | 18³ exh48 | −5.28 | 🔴 see gate §4 |
| 4-guanidinobenzoic_acid | AR-LBD (2AM9) | 18³ exh48 | −4.904 | 🔴 see gate §4 |
| tyramine-guanidine_hybrid | AR-LBD (2AM9) | 18³ exh48 | −4.938 | 🔴 see gate §4 |

---

## 2. PATH A — WAY-316606 → SFRP1 CRD Wnt groove

receptor: SFRP1_CRD_receptor.pdb (AF Q8N474 CRD res 32-180, 1187 atoms) · box center 8.6/3.1/2.9 size 24³ exh32
**Top pose ΔG = −7.77 kcal/mol** (modes 1-20 span −7.77 → −6.28).

Sanity vs lit: parent is a weak mM binder, ΔG_bind(est from Kd≈80µM) ≈ −5.6 kcal/mol.
Vina −7.77 is ~2 kcal/mol deeper (typical Vina over-binding on hydrophobic grooves) but
**stays inside the −5..−8 band** and is **not deeper than −8** → NOT flagged as artifact.
Consistent with a weak/moderate Fz-CRD groove binder. Pose: `poses/wayA_sfrp1_docked.pdbqt`.

## 3. PATH B — 8 DKK1-mimetic fragments → LRP6 PE3 hotspot

receptor: lrp6_chainA_receptor.pdb (3S2K chain A, 4860 atoms) · box center 22.5/-0.7/-13.7 size 24³ exh16
All 8 docked successfully. **Top-3**:
1. **2-naphthylguanidine −7.165** (extended aromatic + guanidinium dual pharmacophore)
2. **4-guanidinobenzoic_acid −7.164** (bidentate guanidinium + carboxylate)
3. **tyramine-guanidine_hybrid −6.87** (phenol + guanidinium DKK1 mimic)

The guanidinium/aromatic-bearing probes (matching the DKK1 basic-finger pharmacophore)
rank above the plain amines, internally consistent with the design rationale.
Logs: `path-b/*_vina.log`; ranked scores: `path-b/pathb_scores.tsv`.

---

## 4. AR OFF-TARGET GATE (frontier #1 — thesis-gating step)

target: **AR-LBD, PDB 2AM9** (apo from chain A; native co-crystal ligand = TES/testosterone-class steroid).
orthosteric pocket center = native-steroid centroid **(2.34, 4.63, 1.00)**.
positive controls (docked here too): **DHT, finasteride, testosterone** (verified PubChem SMILES — CID 10635/57363/6013).

### Pre-registered falsifier (as authored)
> A non-AR lead must NOT bind AR-LBD with ΔG comparable to a known AR binder (DHT/finasteride).
> If a lead docks AR comparably (within ~1.5 kcal/mol of the control) → that lead FAILS the
> non-AR safety thesis (🔴).

### Result (18³ tight orthosteric box, exh48 — primary run)
controls: DHT −5.57 · finasteride −5.901 · testosterone −5.499

| lead | AR-LBD ΔG | Δ vs DHT | Δ vs finasteride | literal gate |
|---|---|---|---|---|
| WAY-316606 | −6.199 | −0.63 | −0.30 | 🔴 FAIL (within 1.5 of both controls) |
| 2-naphthylguanidine | −5.28 | +0.29 | +0.62 | 🔴 FAIL |
| 4-guanidinobenzoic_acid | −4.904 | +0.67 | +1.00 | 🔴 FAIL |
| tyramine-guanidine_hybrid | −4.938 | +0.63 | +0.96 | 🔴 FAIL |

A confirmatory wider 22.5³ box (exh32) gave the same ranking and the same literal verdict
for WAY-316606 + 2-naphthylguanidine (FAIL); only the two weakest leads cross +1.5 vs DHT
there (borderline). Across both boxes the result is robust: **no lead clears the falsifier.**

### Honest interpretation — gate verdict = 🟠 INCONCLUSIVE (cannot CLEAR; "FAIL" is scoring-resolution-limited)
Per d6/g6/g63 I will not overstate. Two facts must be reported together:

1. **Literal falsifier → all four leads FAIL.** As written, every lead docks AR-LBD within
   1.5 kcal/mol of DHT and finasteride. Taken at face value this 🔴-flags all four leads on
   the non-AR safety thesis. This CANNOT be hidden.

2. **But the gate lacks discriminating power at this resolution.** The steroid positive
   controls themselves only score −5.5 to −5.9 (tight box) / −6.5 to −6.8 (wide box) — i.e.
   the *known strong AR binders* are weak in rigid Vina, and ALL seven molecules compress
   into a ~1.3 kcal/mol band that sits entirely inside Vina's ±1.5–2 kcal/mol error. A
   redock-control check showed the DHT top pose centroid lands ~6 Å from the native steroid
   position (rigid-receptor Vina did NOT reproduce the buried orthosteric pose to <2 Å).
   So the controls neither separate from the leads nor reproduce native binding — the
   scoring function cannot resolve AR selectivity here.

**Conclusion:** the AR off-target gate, run with rigid-receptor Vina, **cannot clear any lead
as AR-safe, and its literal FAIL is dominated by scoring-function non-discrimination rather
than by demonstrated AR agonism.** This is a genuine wall in the method, not a closed verdict.
Status = 🟠 INCONCLUSIVE — the leads are NOT exonerated and NOT confirmed AR-active.

### Breakthrough paths to convert 🟠 → terminal (d2 — never concede)
1. **Flexible-receptor / induced-fit redock first** (Vina `--flexres` on pocket Leu/Met/Phe,
   or AutoDock-GPU): require the DHT redock to reproduce native pose <2 Å BEFORE trusting any
   comparative ΔG — re-establish the positive control as a true control.
2. **Rescore with an MM-GBSA / physics endpoint** (single-pod, d7 small-ligand): Vina rank is
   too coarse; an MM-GBSA ΔΔG between DHT and each lead gives a discriminating margin.
3. **AR-agonism-specific filter**: dock into the AGONIST conformation + check the activation-
   function-2 (AF-2) helix-12 contact (the steroid 3-keto/17-OH H-bond network to Gln711/
   Arg752/Asn705). A lead lacking that H-bond pattern is mechanistically a non-agonist even
   at comparable Vina ΔG. Score the H-bond signature, not just total affinity.

### SRD5A2 (7BW1) — secondary off-target
Structure downloaded (`ar-gate/7BW1_SRD5A2_source.pdb`, NADP+/NDX cofactor present).
DEFERRED for this round: 7BW1 catalysis is cofactor-dependent (NADPH hydride transfer to
the steroid Δ4 bond) — its "pocket" is a cofactor-coupled catalytic site, not a clean
orthosteric box, so a rigid fragment dock would be low-confidence and is not reported as a
number (d6 honesty). Retry recipe: model with NADP+ retained as part of the receptor, box on
the steroid sub-site, treat as substrate-competition not affinity.

---

## 5. Provenance / reproduce
- toolchain: `/tmp/aga-dock-tc/bin/micromamba run -n dock vina ...` (env recreatable via the create line in §top)
- PATH A: `path-a/vina_log.txt` · pose `poses/wayA_sfrp1_docked.pdbqt`
- PATH B: `path-b/pathb_scores.tsv` · `path-b/*_vina.log` · poses `poses/*_lrp6_docked.pdbqt`
- AR gate: `ar-gate/argate_scores_tight.tsv` (primary) · `ar-gate/argate_scores.tsv` (confirm) ·
  `ar-gate/*_ar_*vina.log` · poses `poses/*_ar_tight_docked.pdbqt` · receptor `ar-gate/AR-LBD_2AM9_apo.pdbqt` ·
  native ref `ar-gate/2AM9_native_TES_ligand.pdb`
- candidates KEPT in pool (d_defer_no_delete) — no 🔴 FALSIFIED verdict closes any candidate;
  the AR gate is 🟠 INCONCLUSIVE pending flexible-receptor + MM-GBSA rescoring.
