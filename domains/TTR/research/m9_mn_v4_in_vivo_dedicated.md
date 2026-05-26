# TTR-MN M9-v4 — in-vivo 격일 dedicated cohort (n=12 · 2개월)

> milestone: TTR-MN.md "M9-MN v4 — in-vivo 격일 dedicated cohort (n=12 · 2개월 endpoint · TEWL/M1/amine 누적)"
> driver: v4 floor (격일 × 2개월 physical floor) · in-vivo 검증
> base: M9-MN v2 Tier 2c (6 mini-pig 격일 · `m9_mn_v2_in_vivo_alternate.md`) 위 v4 dedicated 확장

## TL;DR

Tier 2c (M9-v2 baseline 6 mini-pig) → **dedicated 12 mini-pig · 2개월 endpoint**. v4 array (1500/cm² + LED) + quad payload + 격일 cycle 15회. 6-axis safety (TEWL · M1/M2 · IFN-α · 항-enzyme IgE · ANA · aromatic amine). 비용 ~$350k (v2 Tier 2c 50k → 350k · dedicated cohort expand). Phase 1 B arm prerequisite.

## §1 cohort design (v2 Tier 2c expansion)

| arm | v2 (M9-v2) | **v4 dedicated (M9-v4)** |
|---|---|---|
| **n** | 6 | **12** (statistical power ↑) |
| Duration | 2mo (15 cycle 격일) | 동일 |
| Array | v2 (1000/cm²) | **v4 (1500/cm² + LED)** |
| Payload | triple | **quad (+ TLR7/8 5 μg)** |
| Photo | none | **UV-A LED 1 mW/cm² 5min post-MN** |
| Group split | 6 same dose | **3 sub-cohort × 4 pigs** |
|   sub-A | — | full v4 (4 pigs) |
|   sub-B | — | v4 without LED (ablation · 4 pigs) |
|   sub-C | — | v4 without TLR7/8 (ablation · 4 pigs) |

⇒ 12 pigs · 3 sub-cohort · 격일 × 15 cycle (52일) · v2 Tier 2c (single dose 6 pigs) 보강

## §2 endpoint (6-axis safety + efficacy)

### Efficacy (Day 0/4/14/28/42/52)

| metric | timepoint | gate |
|---|---|---|
| Removal RGB delta | daily (selected) · biopsy | ≥ 14%/cycle |
| OCT ink layer | weekly | thickness ↓ ≥ 70% by Day 52 |
| Histology ink count | Day 28 · 52 biopsy | depth-resolved · 90%+ by Day 52 |

### Safety stacking (6-axis)

| axis | measurement | baseline | gate |
|---|---|---|---|
| **1. SC barrier** | TEWL (g/h/m²) | 5-10 | ≤ 10% above baseline |
| **2. Macrophage M1/M2** | IHC CD68 / F4-80 / iNOS (Day 28 · 52) | M2 dominant | M1 ratio ≤ 2.5× baseline |
| **3. IFN-α serum** | LC-MS · ELISA (격일 prior to cycle) | < 5 pg/mL | Cmax < 10 pg/mL |
| **4. anti-enzyme IgE** | serum (Day 0/28/52) | baseline | ≤ 2× baseline |
| **5. ANA** | Day 0/52 (autoimmune wall) | negative | negative (positive = wall) |
| **6. Aromatic amine** | LC-MS serum + skin lysate (격일) | < 1 ng/mL | Cmax ≤ 15 ng/mL serum · skin lysate < 200 ng/cm² |

### Additional clinical (peri-treatment)

- Body weight (격일)
- CBC + clinical chemistry (Day 0/28/52)
- ECG + echocardiogram (Day 52 final)
- Local pain score (visual analog · 격일 self-report mock-up)

## §3 stop-go decision (M10 v4 IND 진입)

| outcome | M10-v4 path |
|---|---|
| sub-A PASS (efficacy + 6-axis safety) | **v4 → Phase 1 B arm dose escalation** |
| Sub-A PASS · sub-B/C ablation profile valid | v4 launch + dose-response evidence |
| TEWL > 30% above baseline (SC wall) | v4 reduce frequency (격일 → 주1회 · v3 fallback) |
| IFN-α > 50 pg/mL (전신 immune wall) | TLR7/8 micro-dose ↓ 또는 제거 (triple only) |
| Aromatic amine > 50 ng/mL | ascorbate quench ↑ · dose 조정 |
| ANA positive (autoimmune wall) | **v4 abandon** · v3 only path |
| Efficacy < 85% by Day 52 | v4 abandon · v3 only |

## §4 비용 (v4 in-vivo dedicated)

| 항목 | $ |
|---|---|
| 12 Yucatan mini-pigs (vs 6 · v2 Tier 2c expand) | 50,000 |
| Housing 90일 + GMP/GLP audit | 90,000 |
| v4 MN patches (12 pig × 15 cycle × 3 site = 540 patches · GMP batch) | 25,000 |
| UV-A LED patches (test units · disposable) | 8,000 |
| Quad payload (TLR7/8 GMP-grade) | 25,000 |
| Histology + IHC × 5 timepoint × 12 pig | 60,000 |
| Multiphoton SHG + cutometer + TEWL | 15,000 |
| LC-MS multi-timepoint (격일 serum · skin lysate) | 50,000 |
| IFN-α + IL-12 + IgE + ANA panels | 25,000 |
| ECG + clinical chem | 8,000 |
| CRO management v4 dedicated | 50,000 |
| **합계** | **~$406,000** |

(v2 Tier 2c $50k · v4 dedicated $406k · +710% · 12 pigs + 6-axis safety + LED + quad GMP)

## §5 timeline (실제 lab 실행)

| step | duration |
|---|---|
| IACUC v4 amendment (격일 dedicated cohort) | 2 mo |
| GMP v4 batch (patches + LED) + cascade payload lot release | 3 mo |
| Tier 2c v4 run (2mo · daily monitoring) | 2 mo |
| Histology · LC-MS · IFN/IgE/ANA analysis | 3 mo |
| Ablation analysis + stop-go report | 2 mo |
| **합계 (M10-v4 IND 진입까지)** | **~12 mo** (M9-v2 동일) |

## §6 Phase 1 B arm prerequisite

M9-v4 PASS → Phase 1 B arm dose escalation:

| B arm | dose | freq | n | duration | per-cycle target |
|---|---|---|---|---|---|
| **B1 (low v4)** | 1 cm² × 1 patch | 격일 | 6 | 15 cycle (2mo) | ≥ 8%/cycle |
| **B2 (mid v4)** | 1 cm² × 3 concurrent | 격일 | 6 | 15 cycle | ≥ 12%/cycle |
| **B3 (full v4)** ★ | 1 cm² × 3 + LED | 격일 | 8 | 15 cycle | ≥ 14%/cycle (target) |
| **B4 (high v4)** | 5 cm² × 1 + LED | 격일 | 6 | 15 cycle | ≥ 14%/cycle (larger area) |

⇒ Phase 1 B arm 4-cohort · n=26 · ~$1M

## §7 honest unknowns

- TLR7/8 systemic immune (in vivo cumulative)
- Mini-pig vs human dermis 격일 cycle (translation factor)
- Aromatic amine 누적 serum clearance (hepatic 차이)
- UV-A LED Fitzpatrick variability (light absorbance)
- Adherence (격일 schedule · post-marketing)
- 12 pig statistical power (subdivided 4×3 → marginal)

## §8 진행 상태

- ✅ Cohort design (12 pigs · 3 sub-cohort: full v4 · -LED · -TLR7/8 · ablation in vivo)
- ✅ 6-axis safety (TEWL · M1/M2 · IFN-α · IgE · ANA · amine)
- ✅ Stop-go matrix (v4 → Phase 1 B / fallback v3 / abandon)
- ✅ 비용 ~$406k · timeline 12mo
- ✅ Phase 1 B arm prerequisite (4-cohort dose escalation)
- next: TTR-MN v4 measured-oracle PASS endpoint (Phase 1 B arm dose escalation · 2mo absorbed)
