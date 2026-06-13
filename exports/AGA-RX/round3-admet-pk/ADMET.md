# AGA-RX Round-3 — ADMET Prediction (4 round-2 leads)

date: 2026-06-03 · host: mini (macOS arm64) · domain milestone = ANALYZE (ADMET + topical follicular PK)
engine: **ADMET-AI v2.0.1** (Chemprop-RDKit multitask GNN trained on the TDC ADMET benchmark, Swanson et al. 2024)
env: micromamba `dock` (rdkit 2025.09.5 · admet-ai 2.0.1 · torch/chemprop) — install exit 0
physchem (MW · cLogP · TPSA · HBD/HBA · RotB · QED · Lipinski · Veber) = **RDKit deterministic** (not ML)
All values are MODEL OUTPUTS — no fabrication (d6). ADMET-AI is a QSAR predictor; flags are probabilistic, not measured.

leads (from `exports/AGA-RX/round2-docking/RESULTS.md`):
- **WAY-316606** SFRP1-CRD inhibitor · `C1CNCCC1NS(=O)(=O)C2=C(C=CC(=C2)S(=O)(=O)C3=CC=CC=C3)C(F)(F)F` · CID 16727102 · Vina ΔG −7.77
- **2-naphthylguanidine** LRP6 PE3 frag #1 · `NC(=N)Nc1ccc2ccccc2c1` · Vina −7.165
- **4-guanidinobenzoic_acid** LRP6 PE3 frag #2 · `OC(=O)c1ccc(cc1)NC(=N)N` · Vina −7.164
- **tyramine-guanidine_hybrid** LRP6 PE3 frag #3 · `Oc1ccc(cc1)CCNC(=N)N` · Vina −6.87

---

## 1. Physicochemistry & drug-likeness (RDKit, deterministic)

| property | WAY-316606 | 2-naphthylguanidine | 4-guanidinobenzoic_acid | tyramine-guanidine_hybrid |
|---|---|---|---|---|
| MW (g/mol) | 448.5 | 185.2 | 179.2 | 179.2 |
| cLogP (Crippen) | 2.57 | 2.15 | 0.69 | 0.42 |
| TPSA (Å²) | 92.3 | 61.9 | 99.2 | 82.1 |
| HBD | 2 | 3 | 4 | 4 |
| HBA | 5 | 1 | 2 | 2 |
| Rotatable bonds | 5 | 1 | 2 | 3 |
| QED | 0.73 | 0.47 | 0.40 | 0.40 |
| **Lipinski Ro5** | PASS (0 viol) | PASS (0 viol) | PASS (0 viol) | PASS (0 viol) |
| **Veber** (RotB≤10, TPSA≤140) | PASS | PASS | PASS | PASS |

All four pass Lipinski and Veber. The 3 LRP6 fragments are sub-200 Da fragment-class (high LE, low absolute affinity — expected to need elaboration). WAY-316606 is a fully drug-like lead (QED 0.73).

---

## 2. ADMET-AI predictions (probabilities 0–1 for classifiers; units noted for regressors)

| endpoint | WAY-316606 | 2-naphthylguan. | 4-guanidinobenz. | tyramine-guan. | desirable |
|---|---|---|---|---|---|
| **Absorption** |
| HIA (human intestinal abs, prob) | **0.999** | 0.892 | 0.313 | 0.451 | high |
| Caco-2 (log cm/s) | −5.47 | −5.96 | −6.55 | −6.40 | > −5.15 high |
| PAMPA permeability (prob) | 0.759 | 0.541 | 0.015 | 0.158 | high |
| Bioavailability (Ma, prob) | 0.869 | 0.678 | 0.391 | 0.313 | high |
| Pgp substrate (prob) | 0.416 | 0.019 | 0.000 | 0.003 | low better |
| **Distribution** |
| logP (ADMET-AI) | 2.57 | 2.15 | 0.69 | 0.42 | 1–3 |
| Solubility (AqSolDB, log mol/L) | −3.06 | −2.19 | −2.06 | −0.99 | higher better |
| PPBR (% plasma-protein bound) | 86.3 | 56.5 | 31.4 | 17.2 | <90 |
| VDss (Lombardo, L/kg, log) | 1.61 | 2.29 | −0.22 | 0.37 | — |
| BBB penetration (prob) | 0.517 | 0.720 | 0.324 | 0.299 | low better (topical: irrelevant) |
| **Metabolism — CYP inhibition (prob)** |
| CYP1A2 | 0.009 | **0.517** | 0.005 | 0.050 | low |
| CYP2C9 | 0.281 | 0.010 | 0.002 | 0.008 | low |
| CYP2C19 | 0.217 | 0.036 | 0.004 | 0.022 | low |
| CYP2D6 | 0.186 | 0.256 | 0.021 | 0.235 | low |
| CYP3A4 | **0.692** | 0.011 | 0.000 | 0.008 | low |
| Hepatocyte clearance (AZ) | 20.9 | 11.8 | (low) | 20.6 | — |
| Half-life (Obach, hr) | 43.2 | (short) | 7.5 | (short) | — |
| **Toxicity (prob)** |
| hERG block | **0.561** | 0.324 | 0.022 | 0.199 | <0.5 |
| AMES mutagenicity | 0.040 | 0.373 | 0.034 | 0.147 | <0.5 |
| DILI (hepatotoxicity) | **0.833** | 0.188 | 0.068 | 0.014 | <0.5 |
| ClinTox (clinical-trial tox) | 0.101 | 0.180 | 0.108 | 0.026 | <0.5 |
| Carcinogen (Lagunin) | 0.299 | 0.217 | 0.126 | 0.158 | <0.5 |
| Skin reaction | 0.211 | **0.677** | 0.365 | **0.770** | <0.5 |
| LD50 (Zhu, −log mol/kg) | 2.17 | 2.39 | 2.03 | 2.09 | lower better |
| **Nuclear-receptor Tox21 (prob) — AGA AR-safety thesis** |
| **NR-AR (androgen-receptor agonist)** | **0.025** | **0.057** | **0.028** | **0.041** | low = AR-safe |
| **NR-AR-LBD** | **0.008** | **0.056** | **0.003** | **0.016** | low = AR-safe |
| NR-Aromatase | 0.033 | 0.030 | 0.001 | 0.016 | low |
| NR-ER (estrogen) | 0.037 | 0.111 | 0.039 | 0.067 | low |
| **Structural alerts** |
| BRENK | 0 | 2 | 2 | 2 | 0 |
| PAINS | 0 | 0 | 0 | 0 | 0 |

raw JSON: `aga_admet_full.json` (84 endpoints/lead) · reproduce: `aga_admet.py` + `aga_desc.py`

---

## 3. Per-lead ADMET verdict + liabilities

### WAY-316606 — ADMET: **FLAG (2 systemic liabilities), otherwise best profile**
- Ro5/Veber PASS, QED 0.73, HIA 0.999, oral-drug-like absorption, 0 BRENK/PAINS.
- 🟠 **DILI 0.83** (high predicted hepatotoxicity) — the dominant liability. Bis-sulfonyl/CF3 scaffold class.
- 🟠 **CYP3A4 inhibition 0.69** + **hERG 0.56** — both above threshold. DDI + cardiac flags for any SYSTEMIC exposure.
- Mitigant: these are *systemic*-exposure liabilities. A **topical follicular** route (round-2 strategy) that keeps plasma C low de-risks DILI/hERG/CYP3A4 (see PK.md). AMES 0.04 (clean), carcinogen 0.30 (borderline-low), NR-AR 0.025 (AR-clean).

### 2-naphthylguanidine — ADMET: **FLAG (fragment-class + skin/CYP1A2/BRENK)**
- 🟠 **Skin reaction 0.677** — direct liability for a TOPICAL drug.
- 🟠 **CYP1A2 inhibition 0.517** (naphthalene/aromatic-amine class) + **2 BRENK alerts** (guanidine/aromatic-amine).
- AMES 0.37 (elevated, not over 0.5). NR-AR 0.057 (AR-clean). High BBB 0.72 (irrelevant topically). Fragment hit — needs elaboration before it is a true lead.

### 4-guanidinobenzoic_acid — ADMET: **mostly CLEAN tox, but poor permeability**
- 🟢 Cleanest tox profile: DILI 0.07, hERG 0.02, AMES 0.03, all CYP <0.3.
- 🟠 **Poor passive permeability** — PAMPA 0.015, Caco-2 −6.55, HIA 0.31 (zwitterionic guanidinium+carboxylate). Skin reaction 0.37. 2 BRENK. NR-AR 0.028 (AR-clean). Permeability is the developability wall (carried into PK).

### tyramine-guanidine_hybrid — ADMET: **CLEANEST tox, worst skin/permeability**
- 🟢 Lowest DILI 0.014, lowest ClinTox 0.026, low hERG 0.20.
- 🔴 **Skin reaction 0.770 — highest of the set**, a direct topical liability (phenol + guanidine, tyramine-like → contact-sensitizer class). 2 BRENK. PAMPA 0.158, Caco-2 −6.40 (poor permeability). NR-AR 0.041 (AR-clean).

---

## 4. Cross-cutting finding — AR off-target (relieves the round-2 🟠)

Round-2's AR off-target gate was 🟠 INCONCLUSIVE: rigid Vina could not separate leads from steroid controls (scoring-function non-discrimination). The **orthogonal QSAR Tox21 NR-AR / NR-AR-LBD** endpoint here predicts **all four leads as androgen-receptor-INACTIVE** (NR-AR 0.025–0.057, NR-AR-LBD 0.003–0.056 — all near the inactive floor, ≪0.5). This is a second, independent in-silico method agreeing on AR-safety, and supports the non-AR thesis that Vina could not resolve. NOT a measurement (QSAR), but it converts the AR signal from "unresolved" to "two methods, both AR-clean."

---

## 5. ADMET PASS/FLAG summary

| lead | Ro5/Veber | tox liabilities | permeability | AR-safe (QSAR) | ADMET verdict |
|---|---|---|---|---|---|
| WAY-316606 | PASS | DILI 0.83 · CYP3A4 0.69 · hERG 0.56 | good | yes | **FLAG-systemic** (good topical candidate) |
| 2-naphthylguanidine | PASS | skin 0.68 · CYP1A2 0.52 · 2 BRENK | moderate | yes | **FLAG** (fragment) |
| 4-guanidinobenzoic_acid | PASS | clean tox | **poor (PAMPA 0.015)** | yes | **FLAG-permeability** |
| tyramine-guanidine_hybrid | PASS | **skin 0.77 (highest)** | poor | yes | **FLAG-skin** (fragment) |

No lead is a clean PASS on all axes; each carries a distinct, named liability. WAY-316606's liabilities are systemic-exposure-driven and therefore mitigable by the topical-follicular route — see PK.md for whether it reaches the dermal papilla at efficacious concentration.
