# TTR-MN M8-v2 — ex-vivo 4.5개월 timeline 검증 protocol

> milestone: TTR-MN.md "M8-MN v2 — ex-vivo 4.5개월 timeline 검증 (density 1000 + triple cascade · ink removal rate per cycle)"
> driver: @goal v3 (4.5개월 90%) · M7-MN v2 + M3-MN v2 동시 검증
> base: M8-MN v1 (`TTR/research/m8_mn_ex_vivo_protocol.md`) 위 v2 compressed timeline

## TL;DR

ex-vivo porcine ear skin **19-cycle compressed timeline** (4.5개월 → 압축 4주 ex-vivo run). v2 array (density 1000 · M7 v2) + triple cascade (AzoR+DyP+CeO₂ · M3 v2) 결합 검증. per-cycle x ≈ 12% 측정 · 누적 90% target. 9 cell (3 잉크 × 3 cascade-combo: full triple · double · single) + 3 single-control. 비용 ~$15k (v1 $5.9k 2.5×).

## §1 ex-vivo 4.5개월 → 4주 compressed protocol

```
   in-vivo:    Day 0 → Day 7 → Day 14 → ... → Day 133 (4.5mo)
                 ↓ cycle 19
   ex-vivo:    Day 0 → Day 1 → Day 2 → ... → Day 28 (4주 compressed)
                 ↓ same 19 cycle (compressed)
                 
   compression factor = 5× (1주 cycle → 1일 cycle ex-vivo)
   가정: ex-vivo macrophage 활성 ~5× 가속 (postmortem · 한정)
```

⚠ **caveat**: ex-vivo macrophage 활성 한정 (사후 변화) — compressed timeline 정확 시뮬 X · per-cycle relative coverage 측정 primary.

## §2 cell matrix (12 cell)

| cell | cascade | 잉크 | n | target |
|---|---|---|---|---|
| T1 | **AzoR + DyP + CeO₂** (triple) | Carbon black | 3 | x ≈ 9-11%/cycle |
| T2 | triple | Azo (methyl orange) | 3 | x ≈ 13-15%/cycle (최강 target) |
| T3 | triple | Fe₂O₃ | 3 | x ≈ 11-13%/cycle |
| D1 | AzoR + CeO₂ (double · F5+F1) | Azo | 3 | x ≈ 9-10%/cycle |
| D2 | DyP + CeO₂ (double · F5+F1) | Mixed | 3 | x ≈ 9-10%/cycle |
| S1 | AzoR only (v1 baseline) | Azo | 3 | x ≈ 4-5%/cycle |
| S2 | DyP only | Carbon | 3 | x ≈ 4-5%/cycle |
| S3 | CeO₂ only | Fe₂O₃ | 3 | x ≈ 5-6%/cycle |
| Neg1 | HA-only patch (v2 array) | Mixed | 2 | x ≈ 0%/cycle |
| Neg2 | No patch (untreated) | Mixed | 2 | x ≈ 0%/cycle |

⇒ 총 12 cell · n=29 punch biopsy · 각 19-cycle compressed.

## §3 measurement (per cycle + cumulative)

### Per-cycle measurement (Day 0 · 4 · 9 · 14 · 19)

5 timepoint snapshots:

```
   Day 0  baseline (잉크 주입 후 24h)
   Day 4  cycle 4 후 (누적 ~40% target)
   Day 9  cycle 9 후 (누적 ~70%)
   Day 14 cycle 14 후 (누적 ~85%)
   Day 19 cycle 19 후 (누적 ~91% target ★)
```

### 3-axis endpoint (per timepoint)

1. **Digital RGB delta** (calibrated · ColorChecker)
2. **OCT** (in-situ skin · ink layer thickness)
3. **Histology** (Day 19 final · Masson trichrome · IHC · Fontana-Masson)
4. **LC-MS byproduct** (aromatic amine + Ce³⁺ leach + 효소 fragment) · per cycle

### Per-cycle x 계산

```
   x(cycle n) = (RGB_n−1 − RGB_n) / (RGB_max possible − 0)
   목표 mean: x ≈ 12% (triple cascade)
   목표 cumulative: 91% by cycle 19
```

## §4 success gate (M9-MN v2 진입)

| metric | target | fail-fast |
|---|---|---|
| **Triple cascade per-cycle x** | ≥ 10% | < 7% (synergy 안 됨) |
| **Triple cascade cumulative @ cycle 19** | ≥ 85% | < 70% |
| **Single vs triple ratio** | ≥ 2.0× | < 1.5× (synergy 약함) |
| **TI (cascade vs collagen)** | ≥ 1e-5 | < 1e-7 |
| **Aromatic amine** (skin lysate) | < 100 ng/cm² | > 500 ng |
| **Ce³⁺ leach** | < 1% of CeO₂ NP | > 5% |
| **Collagen 손상 (Masson)** | minimal | severe |

## §5 control comparisons

핵심 검증 — **synergy 정량**:

```
   triple cascade T2 (AzoR+DyP+CeO₂ vs Azo)
     vs S1 (AzoR only) · per-cycle 비교
     synergy = x_triple / x_single = target ≥ 2.5×
   
   double D1 (AzoR+CeO₂) vs S1 (AzoR) vs S3 (CeO₂)
     → AzoR-CeO₂ synergy 단독 측정
   
   double D2 (DyP+CeO₂) vs S2 (DyP) vs S3 (CeO₂)
     → DyP-CeO₂ synergy 단독 측정
   
   triple T1 vs D1+D2+S2 → multi-attack overlap factor
```

## §6 비용 (v2 ex-vivo)

| 항목 | $ |
|---|---|
| 돼지 귀 acquisition (15 ear) | 300 |
| v2 MN patches (12 cell × 19 cycle × 3 rep = ~684 patches · CDMO small batch) | 5,000 |
| AzoR + DyP + CeO₂ payload | 1,500 |
| Histology + IHC (29 final biopsies) | 1,800 |
| LC-MS multi-cycle (5 timepoint × 12 cell) | 3,000 |
| OCT (rental · 19 daily) | 1,000 |
| Franz cell + DMEM + 인건비 | 2,500 |
| CRO management | 1,500 |
| **합계** | **~$16,600** |

⇒ v1 $5.9k 대비 ~2.8× (cell 수 ↑ + 다중 timepoint · 다만 v3 timeline 검증 critical)

## §7 risks + mitigations (v2 specific)

| risk | likelihood | mitigation |
|---|---|---|
| ex-vivo macrophage 활성 부족 → cascade synergy 부정확 | high | live macrophage 추가 (PMA + co-culture) 또는 immortalized THP-1 cell |
| Compressed timeline 5× artifact (cycle 1일 간격) | high | per-cycle relative coverage 측정 (절대 timeline X) |
| Multi-payload 결합 안정성 | mid | lyophilize core trehalose shell + ascorbate quench |
| Ce³⁺ leach + 효소 fragment LC-MS artifact | mid | calibration standard 별 cohort |
| Sample size n=3/cell (preliminary) | inherent | M9 in-vivo 시 n=8-12 boost |

## §8 M9-MN v2 handoff

다음 milestone (M9-MN v2: in-vivo 격일 cohort) 가 받는 입력:
- Triple cascade pass cell list (ex-vivo v2 PASS 시)
- Synergy factor 실측 (e.g., 2.3× vs 추정 2.5×)
- 안전성 신호 (aromatic amine · Ce³⁺ leach · collagen)
- GMP precursor batch lot (M7-MN v2 array + M3-MN v2 payload)
- 격일 cycle interval 정합 (physical floor v4 prerequisite)

## §9 timeline (실제 lab 실행 별 작업)

| step | duration |
|---|---|
| GMP small batch (v2 patches 684개) | 4 wk |
| ex-vivo Day 0-19 run | 3 wk |
| Histology + LC-MS turnaround | 4 wk |
| Analysis + report | 2 wk |
| **합계 (M9 진입까지)** | **~3 mo from CRO start** |

## §10 honest unknowns

- ex-vivo compressed timeline 정확성 (5× artifact 정량 어려움)
- macrophage cell co-culture viability (THP-1 등)
- v2 patch lot uniformity (1000/cm² precision)
- 효소 lyo activity retention (4주 storage)
- 멜라닌세포 ex-vivo viability (사후 사라짐 가능성)

## §11 진행 상태

- ✅ 12-cell experimental matrix (triple/double/single + control)
- ✅ 19-cycle compressed protocol (4주 ex-vivo)
- ✅ 4-axis endpoint (RGB · OCT · histology · LC-MS)
- ✅ Synergy 측정 design (triple vs single 2.5× target)
- ✅ Success gate (per-cycle 10% · cumulative 85% · TI 1e-5)
- ✅ 비용 ~$16.6k · 3 mo turnaround
- ✅ M9-MN v2 handoff
- next: M9-MN v2 (in-vivo 격일 cohort · physical floor v4 검증)
