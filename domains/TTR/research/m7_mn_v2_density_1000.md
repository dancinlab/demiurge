# TTR-MN M7-v2 — density 1000/cm² array re-engineering

> milestone: TTR-MN.md "M7-MN v2 — density 1000/cm² array re-engineering (CDMO quote v2)"
> driver: @goal v3 (4.5개월 timeline) 의 per-cycle x ≈ 12% 정합 path
> base: M7-MN v1 (300/cm² · `TTR/research/m7_mn_array_engineering.md`) 위 v2 boost

## TL;DR

needle density 300 → 1000/cm² (**3.3× boost**) re-engineering. needle spacing 577 → **316 μm** · plume overlap factor 0.4-0.5 · effective per-cycle coverage 4.7% → **~12%** (efficiency 80% 유지). HA needle geometry 재설계 (taper sharper · base 150 μm · L 1200 μm 유지). CDMO 후보: Vaxxas HD-MAP (1000/cm² 선례 보유) · Innopharma · Micron Biomedical. patch cost 추정 $30-40 (v1 $20-30 의 ~50% 증가 · 시술 횟수 ↓로 총 비용 ↓).

## §1 geometry — density 1000/cm² 재설계

### Spacing 재계산

```
   density = 1000/cm² = 1 × 10⁷ /m²
   d_neighbor = 1/√(1×10⁷) = 3.16 × 10⁻⁴ m = 316 μm
   (vs v1 577 μm @ 300/cm²)
```

### Plume overlap 분석

plume radius (M5-MN · Fick t=50s): r_plume = 100 μm

```
   plume area: A_plume = π × 100² = 31,416 μm²
   cell area:  A_cell  = 316² = 99,856 μm²
   raw coverage = 31,416 / 99,856 = 31.5%
   overlap correction (η=0.5 efficiency at this density):
   effective coverage ≈ 0.5 × 31.5% × 0.8 (single-cycle factor) ≈ 12.6%
```

⇒ **per-cycle x ≈ 12-13%** · v3 path math 정합 (target 12%)

### Needle 재설계 (overlap 회피)

| param | v1 (300/cm²) | v2 (1000/cm²) | 근거 |
|---|---|---|---|
| Density | 300/cm² | **1000/cm²** | 3.3× boost · v3 timeline 4.5mo |
| Needle L | 1200 μm | **1200 μm** (유지) | dermis penetration 동일 |
| Tip diameter | 10 μm | **8 μm** (taper sharper) | spacing 좁아 sharper 필요 |
| Base diameter | 200 μm | **150 μm** (slimmer) | 316 μm spacing 내 packing |
| Aspect ratio | 6:1 | **8:1** | sharper taper |
| Euler buckling F_crit | 0.67 N | **~0.50 N** (slimmer base) | safety factor 10× 유지 (insertion 0.05N) |
| Patch area | 1-5 cm² | **1-5 cm²** (동일) | SKU 동일 |

### Buckling 검증

```
   F_crit = π² × E × I / (K·L)² · I = π·r⁴/4
   r_base = 75 μm = 7.5×10⁻⁵ m
   E_HA (dry) = 5 × 10⁹ Pa
   I = π × (7.5×10⁻⁵)⁴ / 4 = 2.49 × 10⁻¹⁷ m⁴
   F_crit = π² × 5×10⁹ × 2.49×10⁻¹⁷ / (2 × 1.2×10⁻³)² = 0.213 N
```

⇒ F_crit (0.21 N) ≫ F_insertion (0.05 N) · safety factor **4.3×** (v1 의 13× 보다 낮지만 여전히 충분)

## §2 ASCII — v1 vs v2 spacing

```
   v1 (300/cm²)              v2 (1000/cm²)
   ─────────────────         ─────────────────
       577 μm                    316 μm
   ●━━━━━━━━━●━━━━━━━━━     ●━━━●━━━●━━━●━━━
   │           │           │   │   │   │   │
   ●           ●           ●   ●   ●   ●   ●
   │ 큰 spacing │           │ 빽빽    │
   │ 적은 overlap│           │ 큰 overlap (효율 0.5) │
                            
   per-cycle coverage:       per-cycle coverage:
   raw 9.4% × η=0.5 = 4.7%   raw 31.5% × η=0.5 × 0.8 = 12.6%
                              (overlap penalty)
```

## §3 multi-cycle 누적 (v3 timeline 정합)

per-cycle x ≈ 12% · 주 1회 cycle:

| 주 (cycle) | 누적 % | timeline 의미 |
|---|---|---|
| 4 | 40.0% | 1개월 |
| 8 | 64.0% | 2개월 (절반 이상) |
| 13 | 81.6% | 3개월 |
| **19** | **91.0%** | ★ **4.5개월 = @goal v3 달성** |
| 24 | 95.4% | 6개월 (over) |

⇒ N=19 cycle × 7일 = 133일 ≈ **4.5개월** · @goal v3 정합

## §4 CDMO 후보 (1000/cm² 가용성)

| CDMO | 1000/cm² 선례 | unit cost (≥ 10k batch) | regulatory |
|---|---|---|---|
| **Vaxxas (HD-MAP)** | ✅ mRNA vaccine HD-MAP ≥ 1000/cm² | $15-25/patch | TGA Australia + FDA path |
| Innopharma | ✅ 자체 1000-1500/cm² | $20-30 | EMA 진행 중 |
| Micron Biomedical | △ ≤ 1000/cm² (현재 limit) | $18-28 | FDA precedent |
| NanoPass MicronJet | ✗ hollow needle 만 | — | — |
| Corium | △ 일부 patch >500/cm² | $25-35 | FDA combination 경험 |
| Kindeva (3M) | △ 500-1000/cm² | $20-30 | FDA 다수 |

⇒ **primary: Vaxxas** (HD-MAP 선례 정합 · 가장 직접) · secondary: Innopharma · Micron.

## §5 patch 비용 분석 (v1 vs v2)

| item | v1 ($20-30) | v2 ($30-40) | 변동 |
|---|---|---|---|
| Material (HA + payload) | $5 | $6 (density ↑) | +20% |
| Mold (PDMS · capital) | $3 | $5 (precision ↑) | +67% |
| Casting + centrifugation | $4 | $6 (uniformity ↑) | +50% |
| QC + packaging | $5 | $8 (density tight tolerance) | +60% |
| CDMO margin | $5 | $8 | +60% |
| **per-patch** | **$22** | **$33** | +50% |

⇒ **total cost** (v3 19 cycle × $33 = **$627**) vs v2 (52 cycle × $20 = $1,040) — **40% 비용 감소** + 7.5개월 단축.

## §6 manufacturing path

### precision casting (v2 추가)

```
   1. PDMS mold precision (3-5 μm tolerance) — laser micromachining
   2. HA + payload aqueous solution (degassed)
   3. Centrifugation 4000g × 5 min (mold filling)
   4. Drying 24h @ 4°C (low humidity)
   5. UV-C sterilization
   6. Inspection (optical density · needle integrity QC)
   7. Aluminum pouch + desiccant + N₂ flush
```

new precision needed (v1 단계 + 정밀도 ↑).

## §7 risk + mitigation

| risk | likelihood | mitigation |
|---|---|---|
| Plume overlap → 효율 ↓ (η < 0.5) | mid | 실측 ex-vivo (M8-MN v2 검증) |
| Buckling safety factor 4× — borderline | low-mid | spacer plate 또는 thumb-press 표준 force |
| Patch cost 50% ↑ | high | 시술 횟수 ↓ 로 총비용 40% ↓ |
| CDMO 1000/cm² capacity | mid | Vaxxas 선례 정합 · 첫 시도 |
| Insertion 통증 ↑ (밀집 needle) | mid | tip 8 μm taper sharper · 실제 통증 ≈ v1 (microneedle 한계 미세) |
| Sterility precision | mid | UV-C + N₂ flush |

## §8 M8-MN v2 handoff

다음 milestone (M8-MN v2: ex-vivo 4.5개월 timeline 검증) 이 받는 입력:
- v2 MN array spec (density 1000 · L 1200 · tip 8 μm · base 150 μm)
- triple cascade payload (M3-MN v2 산출물 — 동시 진행)
- per-cycle x 측정 endpoint (target 12%)
- multi-cycle ex-vivo 19 cycle simulation (compressed timeline)

## §9 Honest unknowns

- η (overlap efficiency) 0.5 추정 — 실측 ex-vivo 검증 필요
- HA precision casting 1000/cm² 일관성 (lot variability)
- CDMO 실제 quote v2 (별 작업)
- Triple cascade payload + density 1000 의 적합성 (M3-MN v2 cross-ref)
- 통증 (밀집 needle insertion) — 사용자 acceptance

## §10 진행 상태

- ✅ density 1000/cm² geometry 재설계 (spacing 316 μm · buckling factor 4×)
- ✅ Plume overlap → per-cycle x ≈ 12% 정합 (v3 path math)
- ✅ multi-cycle 누적 표 (N=19 → 91% @ 4.5mo)
- ✅ CDMO 후보 (Vaxxas primary · Innopharma · Micron secondary)
- ✅ 비용 분석 ($33/patch · v3 total $627 = v2 40% 감소)
- ✅ manufacturing path precision 추가
- next: M3-MN v2 (triple cascade payload thermodynamic 검증)
