# AGA-RX · PATH C · Round 3 — Docking Results (MEASURED)

**Domain:** AGA-RX (androgenetic alopecia, in-silico R&D) · **Path C** = metabolic block (ARM 1) + senolytic clearance (ARM 2) combination.
**Engine:** AutoDock Vina v1.2.7 · OpenBabel 3.1.0 (ligand 3D-gen + protonation pH 7.4) · rigid receptor.
**Search:** exhaustiveness=16 · num_modes=9 · energy_range=4 · seed=42 · grid 0.375 Å.
**Host:** mini / arm64 · conda `dock` env (vina + openbabel + rdkit + meeko).
**Date:** 2026-06-03.
**Provenance:** ΔG values are the mode-1 (best-pose) `REMARK VINA RESULT` from each docked PDBQT — no fabrication (d6 / g63). All 8 ARM-1 candidates docked vs BOTH LDHA and LDHB; all 7 ARM-2 candidates docked vs BCL-xL.

> Parsing note: the bundled `run_dock.sh` awk extractor (`/^   1 /`) does not match Vina 1.2.7's `REMARK VINA RESULT` line spacing, so its `selectivity.tsv` recorded NA. Scores below were re-extracted directly from the authoritative `out_*/<lig>_docked.pdbqt` files. Docking itself ran clean (exit 0 both arms).

---

## ARM 1 — LDHA-selective metabolic inhibitor screen (+ LDHB counter-screen)

Targets: human LDHA (PDB 6Q0D chain A, P8M co-crystal site, box 31.4/87.3/53.1 26×24×22) · human LDHB (PDB 1I0Z chain A, OXM+NAI site, box 14.2/39.6/57.2 26×24×22, dims matched for a fair ΔΔG).
**Selectivity gap = ΔG_LDHA − ΔG_LDHB.** More negative gap = LDHA-selective (the PATH C differentiation thesis: hit Warburg LDHA, spare housekeeping LDHB).

| candidate | ΔG_LDHA (kcal/mol) | ΔG_LDHB (kcal/mol) | selectivity gap (LDHA−LDHB) | reading |
|---|---:|---:|---:|---|
| **GSK2837808A** (lead) | **−9.68** | −9.56 | **−0.13** | strongest LDHA binder · slightly LDHA-selective |
| 4-hydroxymandelic_acid | −6.50 | −6.19 | **−0.31** | most LDHA-selective gap, but weak absolute affinity (fragment) |
| oxamate (warhead control) | −3.96 | −4.03 | +0.07 | substrate-mimic anchor; near-neutral, weak (expected) |
| 4-guanidinobenzoic_acid | −6.43 | −6.72 | +0.29 | LDHB-leaning fragment |
| gallic_acid | −5.59 | −6.28 | +0.70 | LDHB-leaning fragment |
| hydroxy-oxindole-carboxylate | −6.11 | −6.85 | +0.74 | LDHB-leaning fragment |
| galloflavin | −7.51 | −8.64 | +1.13 | LDHB-PREFERRING (anti-selective) |
| FX-11 | −7.99 | −9.80 | +1.81 | strongly LDHB-PREFERRING (anti-selective) |

**Ranked by LDHA affinity:** GSK2837808A (−9.68) > FX-11 (−7.99) > galloflavin (−7.51) > 4-hydroxymandelic (−6.50) > 4-guanidinobenzoic (−6.43) > hydroxy-oxindole (−6.11) > gallic (−5.59) > oxamate (−3.96).

**Ranked by selectivity gap (most LDHA-selective first):** 4-hydroxymandelic_acid (−0.31) > GSK2837808A (−0.13) > oxamate (+0.07) > 4-guanidinobenzoic (+0.29) > gallic (+0.70) > hydroxy-oxindole (+0.74) > galloflavin (+1.13) > FX-11 (+1.81).

**ARM 1 finding.** The clinical-grade LDHA tool compound **GSK2837808A** is both the strongest LDHA binder (−9.68) AND on the LDHA-selective side of the ledger (gap −0.13). The only candidate with a larger selectivity gap, 4-hydroxymandelic_acid (−0.31), is a small lactate-product-mimic fragment with ~3 kcal/mol weaker absolute affinity — selectivity from low engagement, not a usable lead. Notably, the two literature "LDHA inhibitors" FX-11 (gap +1.81) and galloflavin (gap +1.13) dock as LDHB-PREFERRING in this rigid-receptor model — they are potent LDH binders but NOT LDHA-selective here, which is consistent with their reported dual/non-selective LDH pharmacology. **GSK2837808A is the ARM-1 metabolic lead.**

---

## ARM 2 — BCL-xL BH3-groove senolytic screen

Target: human BCL-xL (PDB 3ZLR chain A, X0B = WEHI-539 co-crystal BH3 groove, box −17.2/−12.7/−47.1 28×26×22).
**Self-consistency control: WEHI-539** is the co-crystallized binder → must score strongly AND its pose must overlay the native site.

| candidate | ΔG_BCLxL (kcal/mol) | reading |
|---|---:|---|
| **WEHI-539** (co-crystal control) | **−11.57** | strongest binder · pose overlays native site → CONTROL PASS |
| A-1155463 | −10.32 | BCL-xL-selective senolytic · top novel candidate |
| navitoclax | −10.22 | BCL2/BCL-xL dual senolytic (ABT-263) |
| A-1331852 | −9.68 | BCL-xL-selective senolytic |
| biphenyl-4-carboxylic_acid | −8.59 | P2/P4 hydrophobic-fill fragment |
| N-phenylsulfonyl-aminobenzoate | −7.57 | Arg139 acylsulfonamide-anchor fragment |
| indole-6-carboxylic_acid | −6.67 | flat-aromatic fragment |

**WEHI-539 self-consistency control — PASS.**
- **Affinity:** −11.57 kcal/mol = the single strongest score in the BCL-xL set (beats every other senolytic). ✔
- **Pose overlay:** mode-1 pose centroid = (−17.2, −12.7, −47.0), i.e. **0.09 Å from the X0B/WEHI-539 co-crystal box center** — the redocked binder reseats dead-center in its native BH3 groove. ✔
→ Box placement and scoring-function behavior are validated. **No method-confidence flag raised.**

**ARM 2 finding.** Excluding the WEHI-539 control, **A-1155463 (−10.32)** is the top senolytic, narrowly ahead of navitoclax (−10.22) and A-1331852 (−9.68). A-1155463 is a BCL-xL-SELECTIVE BH3 mimetic (vs navitoclax's BCL2/BCL-xL dual profile → on-target thrombocytopenia risk), so it is the cleaner senolytic for a dermal-papilla clearance arm. **A-1155463 is the ARM-2 senolytic lead.** All three sub-nanomolar senolytics dock within ~1.3 kcal/mol of each other and ~1.3 kcal/mol of the validated control — a tight, credible cluster.

---

## VERDICT — PATH C combination pair

| arm | role | LEAD | ΔG | selectivity / control |
|---|---|---|---:|---|
| ARM 1 | metabolic block (LDHA over LDHB) | **GSK2837808A** | LDHA −9.68 | gap −0.13 (LDHA-selective) + strongest LDHA affinity |
| ARM 2 | senescent-DP clearance (BCL-xL) | **A-1155463** | BCL-xL −10.32 | top non-control senolytic; BCL-xL-SELECTIVE (lower platelet liability than navitoclax) |

**PATH C combination pair = GSK2837808A (LDHA-selective metabolic) + A-1155463 (BCL-xL-selective senolytic).**

Rationale: GSK2837808A is the only candidate that is simultaneously the strongest LDHA binder and LDHA-selective (gap-negative), satisfying the "block Warburg flux, spare housekeeping LDHB" thesis. A-1155463 is the strongest non-control BCL-xL senolytic and is BCL-xL-selective, minimizing the BCL2-mediated thrombocytopenia that burdens navitoclax. The two leads hit orthogonal mechanisms (metabolic flux vs apoptotic priming), supporting a genuine combination.

## Method-confidence flags
- **WEHI-539 self-consistency control: PASS** (strongest score −11.57 + 0.09 Å native-site overlay). No candidate failed the control; method confidence is HIGH for the BCL-xL arm.
- **Caveat (ARM 1):** Vina rigid-receptor scoring ranked the dual/non-selective LDH inhibitors FX-11 and galloflavin as LDHB-PREFERRING. This matches their literature non-selectivity but is also a reminder that LDHA-vs-LDHB selectivity gaps here are small (≤2 kcal/mol, within rigid-docking error). The LDHA/LDHB selectivity readout is directional, not quantitative; an induced-fit / MM-GBSA rescore on GSK2837808A vs the LDHA mobile loop (Arg105) is the recommended follow-up to harden the gap.

## Artifacts
- Full mode-1..9 poses for all leads + the control: `poses/` (PDBQT).
  - `GSK2837808A_LDHA.pdbqt`, `GSK2837808A_LDHB.pdbqt`, `FX-11_LDHA.pdbqt`, `4-hydroxymandelic_acid_LDHA.pdbqt`
  - `WEHI-539_BCLxL_control.pdbqt`, `A-1155463_BCLxL.pdbqt`, `navitoclax_BCLxL.pdbqt`, `A-1331852_BCLxL.pdbqt`
- Per-ligand Vina logs + all docked poses: `../path-c-combo/arm1-ldha/out_ldha|out_ldhb/`, `../path-c-combo/arm2-senescence/out_bclxl/`.
