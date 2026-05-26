# TTR-CREAM M9 — in-vivo 동물 효능 protocol (4 SKU · rat/mini-pig)

> milestone: TTR-CREAM.md "M9-CREAM in-vivo (rat / mini-pig) — cream-only 효능 (낮은 제거율 가능성 명시) + 안전성"
> base: TTR-MN M9-v2 (in-vivo 3-arm) · M8-CREAM (ex-vivo 4 SKU)
> 결과: 4 SKU × 2 species (rat + mini-pig) · 12-16wk treatment · safety + efficacy

## TL;DR

2-tier (rat 16wk → mini-pig 24wk) · 4 SKU separate cohort. CREAM-α/δ (OTC daily) · CREAM-β (weekly sono) · CREAM-γ (multi-modal clinic · investigator-applied). 5-axis safety (skin · TEWL · macrophage · liver/kidney · systemic). 비용 ~$400k total. Phase 1 prerequisite (OTC cosmetic claims · 별 IND/IDE 분리).

## §1 cohort design

### Tier 1 — SD rat (16 wk · screening)

| arm | SKU | mode | n | duration |
|---|---|---|---|---|
| R-α | CREAM-α (basic OTC) | daily cream | 6 | 16 wk |
| R-β | CREAM-β | weekly cream + sono | 6 | 16 wk |
| R-γ | CREAM-γ | bi-weekly multi-modal | 6 | 16 wk |
| R-δ | CREAM-δ (shallow) | daily | 6 | 16 wk |
| Sham | placebo cream | daily | 4 | 16 wk |
| Untreated | none | — | 4 | 16 wk |

⇒ 32 SD rats · 4 mo · Tier 1 screening

### Tier 2 — Yucatan mini-pig (24 wk · 인간 유사 dermis)

| arm | SKU | mode | n | duration |
|---|---|---|---|---|
| P-α | CREAM-α | daily | 4 | 24 wk |
| P-β | CREAM-β | weekly cream + sono | 4 | 24 wk |
| P-γ | CREAM-γ | bi-weekly clinic (investigator) | 4 | 24 wk |
| P-δ | CREAM-δ shallow | daily | 4 | 24 wk |
| Sham | placebo | daily | 3 | 24 wk |

⇒ 19 mini-pigs · 6 mo · Tier 2 efficacy + safety

## §2 endpoint (5-axis safety + efficacy)

### Efficacy (Day 0/28/56/84/168 + final)

- Removal % (digital RGB + OCT in vivo + final histology biopsy)
- Daily cream application count (tube depletion · adherence)

### Safety (5-axis)

1. **Skin local** — TEWL · erythema · edema (격주 평가)
2. **Macrophage M1/M2** — IHC (Day 28 · 84 · 168) 
3. **SC barrier** — TEWL 누적 (CPE/CREAM-γ critical)
4. **Systemic** — liver enzymes (CMP) · kidney function · blood count (Day 0/28/84/168)
5. **Aromatic amine serum** — LC-MS (weekly · Cmax)

## §3 success gate (M10-CREAM 진입)

| metric | gate Tier 2 (24wk) | fail |
|---|---|---|
| CREAM-α removal | ≥ 30% | < 15% |
| CREAM-β removal | ≥ 65% | < 45% |
| CREAM-γ removal | ≥ 85% | < 65% |
| CREAM-δ shallow removal | ≥ 50% | < 30% |
| TEWL 누적 | ≤ 20% above baseline | > 50% (SC wall) |
| Serum amine | Cmax < 50 ng/mL | > 200 ng/mL |
| Hepatic/renal | within 10% baseline | > 30% deviation |
| 멜라닌 손실 | minimal | severe |

## §4 비용

| item | $ |
|---|---|
| Tier 1 (32 SD rats + housing 16wk) | 35,000 |
| Tier 1 cream batches (4 SKU · GMP small) | 25,000 |
| Tier 1 histology + LC-MS + safety panels | 35,000 |
| Tier 1 CRO management | 30,000 |
| **Tier 1 subtotal** | **125,000** |
| Tier 2 (19 mini-pigs + housing 24wk · $30-50/day) | 110,000 |
| Tier 2 cream + sono device (GMP) | 60,000 |
| Tier 2 histology + IHC + multiphoton SHG | 50,000 |
| Tier 2 LC-MS + safety multi-timepoint | 40,000 |
| Tier 2 CRO management | 40,000 |
| **Tier 2 subtotal** | **300,000** |
| IACUC + GLP audit | 20,000 |
| **합계** | **~$445,000** |

⇒ TTR-MN M9 v2 ($548k 3-arm + v4 floor) 비슷 · cream 4 SKU 별 cohort

## §5 timeline (실제 lab)

| step | duration |
|---|---|
| IACUC amendment (4 SKU + 2 species) | 2 mo |
| GMP batches (4 SKU + sono + multi-modal device) | 3 mo |
| Tier 1 rat 16 wk run | 4 mo |
| Tier 1 analysis | 2 mo |
| Tier 2 mini-pig 24 wk run | 6 mo |
| Tier 2 analysis + report | 3 mo |
| **합계 (M10-CREAM 진입까지)** | **~18-20 mo** |

## §6 stop-go decision

| outcome | path |
|---|---|
| CREAM-β/γ PASS · α 부족 (< 30%) | β/γ launch · α discontinue |
| CREAM-γ PASS (≥ 85%) · others 부족 | γ only (clinic) |
| All SKU partial | re-formulate · extend Tier 2 |
| TEWL wall (γ) | γ reduce frequency 또는 abandon |
| Systemic toxicity | full re-design (formulation) |

## §7 honest expected outcomes (V3 mass-action · M2 wall 정합)

| SKU | nominal | 95% CI guarantee |
|---|---|---|
| CREAM-α | 30-40% | ≥ 20% |
| CREAM-β | 60-75% | ≥ 50% |
| CREAM-γ | 80-90% | ≥ 70% |
| CREAM-δ | 40-50% shallow | ≥ 30% |

⇒ TTR-CREAM @goal 90% 도달 = CREAM-γ (clinic) 만 가능

## §8 Phase 1 prerequisite (별 regulatory split)

```
   CREAM-α/δ (OTC cosmetic monograph):
   - No Phase 1 needed
   - FDA 21 CFR 700 (cosmetic enhancer claim)
   - directly to market post-M9 PASS
   - Insurance: cosmetic (out-of-pocket)
   
   CREAM-β (drug-device combo):
   - 505(b)(2) NDA
   - Phase 1 dose escalation needed
   - n=12 healthy volunteer · 6 mo
   
   CREAM-γ (multi-modal clinic):
   - 505(b)(2) + device combo
   - Phase 1 + 2 (more complex)
```

## §9 honest unknowns

- Daily cream user adherence (16-24wk · rodent vs human)
- Sono device 사용자 home use (mini-pig vs human)
- CREAM-γ clinic 시술 reproducibility (esthetician vs dermatologist)
- TEWL 누적 24wk (long-term · M1 monitoring 필요)
- 5-yr post-market autoimmune (TLR7/8 시 별 cohort)

## §10 진행 상태

- ✅ 2-tier cohort (32 SD rats + 19 mini-pigs)
- ✅ 4 SKU separate arm
- ✅ 5-axis safety + efficacy endpoint
- ✅ Cost ~$445k · timeline 18-20 mo
- ✅ Stop-go matrix
- ✅ Phase 1 split path (OTC α/δ · 505(b)(2) β/γ)
- ✅ Honest @goal: 90% = CREAM-γ clinic 만 가능
- next: M10-CREAM measured-oracle PASS endpoint
