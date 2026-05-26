# TTR-CREAM M8 — ex-vivo 돼지 피부 PoC protocol (4 SKU)

> milestone: TTR-CREAM.md "M8-CREAM ex-vivo 돼지 피부 PoC — cream 도포 → 잉크 제거율 측정 (제거율 ≥ 30% goal, 정직)"
> base: TTR-MN M8-v2 (ex-vivo · 9-cell) · 위 cream-translated
> 결과: 12-cell matrix (4 SKU × 3 ink class) · Franz cell · 12주 protocol

## TL;DR

ex-vivo porcine ear · **12주 (CREAM-α 1년 → ex-vivo 가속)** · 4 SKU × 3 ink class = 12-cell. Franz cell + (CREAM-β/γ) sono module · daily/weekly application schedule. Endpoint: RGB delta · OCT · histology · LC-MS. **gate ≥ 30% (CREAM-α/δ) · ≥ 70% (CREAM-β/γ)**. 비용 ~$25k (TTR-MN v2 $16.6k + 4 SKU multi + sono device).

## §1 4 SKU × 3 ink class matrix

| SKU | application | Carbon | Azo | Fe₂O₃ | n |
|---|---|---|---|---|---|
| **CREAM-α** | daily cream (12 wk) | 3 | 3 | 3 | 9 punch |
| **CREAM-β** | cream + sono 주 1회 (12 wk) | 3 | 3 | 3 | 9 punch |
| **CREAM-γ** | + multi-modal 격주 (6 vis) | 3 | 3 | 3 | 9 punch |
| **CREAM-δ** | shallow tattoo only · daily cream | 3 (shallow only) | 3 | 3 | 9 punch |
| **Neg1** | placebo cream (no payload) | 2 | 2 | 2 | 6 |
| **Neg2** | no cream | 2 | 2 | 2 | 6 |

⇒ 총 **48 punch biopsy** (ear skin · 3 cm × 3 cm)

## §2 application protocol (3 modes)

### Mode A (CREAM-α/δ · daily passive cream)

```
   Day 0: ink injection (Franz cell · 1 cm × 1 cm)
   Day 1: cream first apply (0.5 g · 30 min · gauze cover)
   Day 1-7: daily apply (week 1)
   Week 2-12: continuous daily
   Day 84 final: RGB · OCT · histology · LC-MS
```

### Mode B (CREAM-β · weekly cream + sono)

```
   Day 0: ink
   Week 1-12 (12 cycles · 주 1회):
        - cream apply 5 min
        - sono 20 kHz · 1.5 W/cm² · 30 sec
        - wait 1 hr · cover
   Day 84 final: full endpoint
```

### Mode C (CREAM-γ · bi-weekly clinic)

```
   Day 0: ink
   Week 1, 3, 5, 7, 9, 11 (6 visits):
        - microabrasion (sandpaper-light)
        - ionto patch 10 min
        - cream apply
        - sono 30 sec
   Day 84 final: full endpoint
```

## §3 endpoint measurement (5 axis)

| axis | timepoint | method |
|---|---|---|
| RGB delta | Day 0/14/28/56/84 | digital photo · ColorChecker |
| OCT | Day 0/28/56/84 | ink layer thickness |
| Histology | Day 84 (final) | Masson + IHC + Fontana-Masson |
| LC-MS | Day 28/56/84 | aromatic amine + degradation product |
| TEWL | weekly | SC barrier 누적 (CREAM-γ multi-modal critical) |

## §4 success / fail gate

| SKU | gate (12 wk removal) | fail-fast |
|---|---|---|
| **CREAM-α** (basic OTC) | ≥ 30% | < 20% |
| **CREAM-β** (sono) | ≥ 70% | < 50% |
| **CREAM-γ** (multi-modal) | ≥ 85% | < 70% |
| **CREAM-δ** (shallow only) | ≥ 50% (shallow) · < 10% (deep) | shallow < 30% |
| TEWL (γ multi-modal) | ≤ 30% above baseline | > 60% (SC wall) |
| Collagen 손상 | minimal | severe |
| Aromatic amine | < 100 ng/cm² | > 500 ng/cm² |

## §5 비용 (CREAM ex-vivo)

| item | $ |
|---|---|
| 20 돼지 귀 (충분 backup) | 500 |
| 4 SKU cream batch (12 cell × 12 wk daily = many tubes) | 8,000 |
| Sono device prototype (10 unit · 60 cycle reuse) | 1,500 |
| Multi-modal device (ionto · sandpaper) | 1,000 |
| Histology + IHC (48 final biopsies) | 3,500 |
| LC-MS multi-timepoint (4 SKU × 3 timepoint × 3 ink) | 5,000 |
| OCT + TEWL device rental (12 wk) | 2,500 |
| Franz cell + DMEM + 인건비 | 3,500 |
| **합계** | **~$25,000** |

## §6 timeline

| step | duration |
|---|---|
| GMP small batch (4 SKU lots · cosmetic CDMO) | 6 wk |
| ex-vivo Day 0-84 run | 12 wk |
| Histology + LC-MS turnaround | 4 wk |
| Analysis + report | 2 wk |
| **합계 (M9-CREAM 진입)** | **~6 mo** |

## §7 honest expected outcome

| SKU | nominal 추정 | realistic (95% CI) |
|---|---|---|
| CREAM-α | 30-50% removal | 20-40% |
| CREAM-β | 70-80% | 60-75% |
| CREAM-γ | 85-95% | 80-90% |
| CREAM-δ (shallow only) | 50% shallow · 5% deep | 40% shallow |

⇒ TTR-CREAM @goal 90% 약함 (multi-modal clinic 만 도달)

## §8 risks + mitigation

| risk | mitigation |
|---|---|
| ex-vivo viability (12 wk long-term) | rotating fresh ear · 4-week sub-cohort |
| CREAM-α/δ low removal (< gate) | 추가 enhancer optimization · ethosome variant |
| Multi-cycle daily application fatigue (ex-vivo) | robotic application 자동화 |
| TEWL 누적 (γ multi-modal) | sub-cohort early stop |

## §9 M9-CREAM handoff

다음 milestone (M9-CREAM in-vivo) 가 받는 입력:
- pass SKU profile (CREAM-α: 30%? · β: 70%? · γ: 85%?)
- TEWL 누적 baseline
- Aromatic amine clearance
- GMP precursor batch (4 SKU)
- 사용자 adherence prediction (daily vs weekly)

## §10 진행 상태

- ✅ 12-cell matrix (4 SKU × 3 ink class)
- ✅ 3-mode application (daily passive · weekly sono · bi-weekly clinic)
- ✅ 5-axis endpoint
- ✅ Success gate (30% α · 70% β · 85% γ · 50% δ shallow)
- ✅ 비용 \$25k · 6 mo turnaround
- ✅ Honest expected outcome (CREAM track 90% 약함 · γ clinic 만 도달)
- next: M9-CREAM in-vivo protocol
