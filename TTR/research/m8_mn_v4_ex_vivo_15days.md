# TTR-MN M8-v4 — ex-vivo ultra-compressed (cycle 1일 · 15 cycle in 15일)

> milestone: TTR-MN.md "M8-MN v4 — ex-vivo ultra-compressed (15 cycle in 15일)"
> driver: v4 floor (격일 × 2개월 in-vivo) 의 ex-vivo 빠른 검증 path
> base: M8-MN v2 (4주 compressed · `m8_mn_v2_ex_vivo_4_5mo.md`) 위 ultra-compressed 추가

## TL;DR

ex-vivo porcine ear · **cycle 1일 ultra-compressed** (in-vivo 격일 3.5일 → ex-vivo 1일 · 3.5× 가속). v4 array (1500/cm²) + quad payload (cascade + TLR7/8) + UV-A LED 통합 검증. 15-day run · 15 cycle · daily measurement. per-cycle x ≈ 14% target · 누적 90% by Day 15 ex-vivo. 비용 ~$20k (v2 $16.6k + LED + photo cell).

## §1 ultra-compression rationale

```
   in-vivo v4:  격일 (3.5일) × 15 cycle = 52일 (2mo)
                  ↓ 3.5× 가속
   ex-vivo v4: cycle 1일 × 15 cycle    = 15일 (~2주 lab)
```

⇒ ex-vivo 사후 시간 한계 (porcine viability ~1주 · co-culture extension 가능) → 1-day cycle 가속.

⚠ **caveat**: ex-vivo postmortem macrophage 활성 한정 · co-culture (THP-1 또는 immortalized line) 추가로 확장.

## §2 v4 cell matrix (15-cell · 추가 photo + quad)

| cell | array | payload | photo | 잉크 | n | target |
|---|---|---|---|---|---|---|
| **Q1** ★ | v4 (1500/cm²) | quad (triple+TLR7/8) | UV-A LED | Azo (methyl orange) | 3 | x ≈ 16-18%/cycle |
| Q2 | v4 | quad | LED | Carbon black | 3 | x ≈ 13-15%/cycle |
| Q3 | v4 | quad | LED | Fe₂O₃ | 3 | x ≈ 14-16%/cycle |
| **W1** ★ | v4 | quad | LED | **Cu-Pc (PB15 · wall)** | 3 | x ≈ 7-10%/cycle (wall 분해) |
| W2 | v4 | quad | LED | **Cr₂O₃ (wall)** | 3 | x ≈ 6-8%/cycle |
| W3 | v4 | quad | LED | Cu-Pc + Cr₂O₃ mixed | 3 | x ≈ 5-7%/cycle |
| C1 (control) | v4 | quad | NO LED (photo 비활성) | Azo | 3 | x ≈ 12% (photo contribution -3%) |
| C2 | v4 | triple (no TLR7/8) | LED | Azo | 3 | x ≈ 13% (TLR7/8 contribution -1.5%) |
| C3 | v3 (1000/cm²) | triple | LED | Azo | 3 | x ≈ 12% (density boost -2%) |
| C4 | v2 (300/cm²) | single AzoR | NO LED | Azo | 3 | x ≈ 5% (full baseline · v2 정합) |
| Neg1 | v4 HA-only | — | NO LED | Mixed | 2 | x ≈ 0% |
| Neg2 | no patch | — | — | Mixed | 2 | x ≈ 0% |

⇒ 총 12-cell · n=33 punch biopsy

## §3 endpoint (daily measurement · Day 0-15)

### 5 axis (per timepoint)

```
   Day 0  baseline (잉크 주입 후 24h)
   Day 1-15: daily measurement (15 timepoint)
   Day 15: final · histology · LC-MS deep
```

| axis | method | per timepoint |
|---|---|---|
| RGB delta | digital camera (ColorChecker) | daily |
| OCT | ink layer thickness | daily |
| TEWL | transepidermal water loss (SC barrier 누적) | daily |
| LC-MS aromatic amine | skin lysate + supernatant | every 3 cycle |
| Histology | Masson + IHC F4/80 + Fontana-Masson | Day 5/10/15 |

## §4 wall pigment 분해 검증 (W1-W3)

### Cu-Pc (PB15 · 시장 ~5-7%)

```
   v3 cascade only: x_Cu-Pc ≈ 0% (DyP attempt 가능, 약함)
   v4 + UV-A: x_Cu-Pc ≈ 7-10% (photo-Fenton ¹O₂ · Q-band triplet)
   
   gate: ≥ 5%/cycle Cu-Pc removal (W1 PASS)
       · < 3%/cycle: photo path 부족 · v4 wall path fail
```

### Cr₂O₃ (시장 ~3-5%)

```
   v3 + DFO chelation: x_Cr₂O₃ ≈ 0% (DFO 약함)
   v4 + UV-A + DFO + ascorbate: x_Cr₂O₃ ≈ 6-8% (band-gap excited · ·OH · DFO chelation 가속)
   
   gate: ≥ 4%/cycle Cr₂O₃ removal (W2 PASS)
```

## §5 ablation analysis (control vs full v4)

```
   Q1 (full v4): 16-18%/cycle
   C1 (no LED · photo 빠짐):    12%/cycle    → photo contributes 4-6%/cycle
   C2 (no TLR7/8 · triple only): 13%/cycle    → TLR7/8 contributes 3-5%/cycle
   C3 (v3 density 1000):        12%/cycle    → density boost (1000→1500) contributes 4-6%/cycle
   C4 (v2 baseline):            5%/cycle     → total stack 12-13%/cycle (v4 - v2)
```

⇒ 각 component contribution 정량 (orthogonal · ablation 검증)

## §6 success / fail gate (M9-MN v4 진입 조건)

| metric | gate | fail-fast |
|---|---|---|
| Q1 (full v4 vs Azo) per-cycle x | ≥ 14% | < 10% |
| Q1 cumulative Day 15 | ≥ 85% | < 70% |
| W1+W2 (wall pigment) per-cycle | ≥ 5% each | < 3% (photo path fail) |
| TEWL Day 15 | ≤ 30% above baseline | > 60% (SC wall breach) |
| Collagen 손상 (Masson) | minimal | severe |
| Aromatic amine skin lysate | < 200 ng/cm² (격일 누적 적용) | > 1000 ng/cm² |
| Ablation orthogonality | photo + TLR7/8 + density boost 각 contribution > 2%/cycle | one < 1% (redundant) |

## §7 비용 (v4 ex-vivo)

| 항목 | $ |
|---|---|
| 돼지 귀 (20 ear · 2 batch) | 400 |
| v4 MN patches (15 cycle × 12 cell × 3 rep = ~540 patches · CDMO Innopharma) | 6,500 |
| Quad payload (TLR7/8 imiquimod 추가) | 2,500 |
| UV-A LED patches (10 reusable units · prototype) | 1,500 |
| THP-1 macrophage co-culture (LED activation 검증) | 1,800 |
| LC-MS multi-timepoint × 12 cell × 5 timepoint | 4,500 |
| Histology + IHC (Masson + Fontana-Masson + F4/80) | 2,500 |
| OCT + TEWL device rental | 1,200 |
| CRO management + 인건비 | 3,500 |
| **합계** | **~$24,400** |

⇒ v2 $16.6k · v4 ~$24.4k (+47% · LED + photo cell + TLR7/8 + ablation 추가)

## §8 timeline (실제 lab 실행)

| step | duration |
|---|---|
| GMP small batch (v4 patches 540개) + LED | 5 wk |
| ex-vivo Day 0-15 run | 2 wk |
| Histology + LC-MS turnaround | 4 wk |
| Ablation analysis + report | 2 wk |
| **합계 (M9-v4 진입까지)** | **~3 mo** |

## §9 risks + mitigations (v4 specific)

| risk | mitigation |
|---|---|
| ex-vivo macrophage 활성 부족 (TLR7/8 효과 X) | THP-1 immortalized macrophage co-culture |
| ultra-compressed timeline artifact | C3/C4 control 비교 (relative 측정) |
| UV-A LED + payload safety (in-skin photo damage) | TEWL · histology mel/col 누적 monitor |
| Wall pigment lot variability | commercial Pigment Red 254 / PB15 / Cr₂O₃ standard |
| Aromatic amine 누적 격일 ex-vivo | LC-MS time-resolved (daily serum-like) |

## §10 M9-MN v4 handoff

다음 milestone (M9-MN v4: in-vivo 격일 cohort) 가 받는 입력:
- v4 quad cascade ex-vivo PASS profile (per-cycle x · ablation factor)
- Wall pigment removal % (Cu-Pc · Cr₂O₃ 정량)
- LED + TLR7/8 + density boost ablation orthogonality
- TEWL 누적 baseline (in-vivo 격일 안전성 정량)
- Aromatic amine 누적 patterns

## §11 honest unknowns

- ex-vivo TLR7/8 효과 (postmortem macrophage · co-culture vs live)
- UV-A LED daily exposure (in-vivo 격일 cumulative)
- Wall pigment commercial lot 정합 (vs 실제 tattoo PB15)
- per-cycle x daily vs in-vivo 격일 정합 (3.5× compression artifact)
- Ablation 모든 4 factor (photo · TLR7/8 · density · cascade) 가 independent vs interaction

## §12 진행 상태

- ✅ ultra-compressed 15-day protocol (cycle 1일 · 3.5× 가속)
- ✅ 12-cell matrix (Q1-3 full v4 · W1-3 wall pigments · C1-4 ablation · neg)
- ✅ 5-axis endpoint (RGB · OCT · TEWL · LC-MS · histology)
- ✅ Wall pigment 분해 검증 (Cu-Pc · Cr₂O₃ · gate ≥ 5%/cycle)
- ✅ Ablation orthogonality (photo + TLR7/8 + density boost contribution)
- ✅ 비용 ~$24.4k · 3 mo turnaround
- ✅ M9-MN v4 handoff
- next: M9-MN v4 (in-vivo 격일 dedicated · 2mo endpoint)
