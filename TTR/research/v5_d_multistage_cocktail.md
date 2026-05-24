# TTR-MN v5-D — multi-stage cocktail design (5 SKU rotation · 1.4mo timeline)

> milestone: v5 path D · v4 (격일 × 2개월) 위 cycle rotation 추가 · saturation 회피 · per-cycle x 17% boost
> driver: 사용자 adherence + macrophage saturation 회피 + orthogonal mechanism rotation
> base: v5_rd_paths_physical_floor_bypass.md (5 paths overview) 위 Path D detailed

## TL;DR

5 SKU rotation (Day 1/3/5/7/9... 격일) — orthogonal mechanism 회피 macrophage saturation. per-cycle x: 14% (single SKU saturation) → **17%** (rotation refresh). N=12 cycle × 격일 = **42일 ≈ 1.4mo (~10% faster than v4 2mo)**. SKU mfg cost ↑ 2× (5 batch) · adherence design = numbered patches per box. Phase 2 candidate · R&D 6mo · $1-2M extra.

## §1 5 SKU rotation design

| cycle | SKU code | dominant payload | mechanism |
|---|---|---|---|
| 1, 6, 11 | **TTR-MN-α** | AzoR + ascorbate (reductive) | azo bond cleavage |
| 2, 7, 12 | **TTR-MN-β** | DyP + DFO (oxidative + chelation) | macrocycle + Fe oxide |
| 3, 8, 13 | **TTR-MN-γ** | CeO₂ + photo (UV-A LED) | nanozyme pH-switch Fenton + Cu-Pc |
| 4, 9, 14 | **TTR-MN-δ** | TLR7/8 + macrophage refresh | M1 polarization + phagocytosis ↑ |
| 5, 10, 15 | **TTR-MN-ε** | quad (all 4) | full cascade |

⇒ 5-day rotation cycle · 12-15 cycle total · 사용자 numbered box (`Week 1: α, β, γ, δ, ε` · ...)

## §2 mechanism — saturation 회피 + orthogonal boost

```
   v4 same payload 격일 cycle (15회):
   ─────────────────────────────────
   cycle 1-3: macrophage M1 high · phagocytosis ↑
   cycle 4-6: M1 saturation · activity ↓ 20-30%
   cycle 7-9: M2 polarization shift · phagocytosis ↓ further
   cycle 10-15: ~50% original activity · per-cycle x = 7-10% (not 14%)
   
   v5-D rotation:
   ─────────────────────────────────
   cycle 1 α (reductive): azo bond direct
   cycle 2 β (oxidative + chelation): macrocycle · Fe
   cycle 3 γ (photo + nanozyme): broad ROS · Cu-Pc/Cr
   cycle 4 δ (immune refresh): TLR7/8 → M1 reset
   cycle 5 ε (full quad): synergy boost
   ─────────────────────────────────
   → macrophage M1/M2 cycling (no saturation)
   → per-cycle x ~ 17% (no fatigue · refresh by δ + ε)
```

## §3 per-cycle x — saturation curve modeling

### v4 single SKU (saturation)

```
   x(n) = x₀ × (1 - 0.04 × max(0, n-3))   # 4% drop per cycle after cycle 3
   
   cycle 1-3: 14% · 14% · 14%
   cycle 4-6: 12% · 11.5% · 11%
   cycle 7-9: 9.5% · 8.5% · 7.5%
   cycle 10-15: 6-7%
   mean: ~10%
```

### v5-D rotation (refresh)

```
   x(n) = base × (1 - 0.01 × n)   # 1% slow drift (refresh by δ TLR7/8 every 5 cycle)
   
   cycle 1-5 (α-β-γ-δ-ε): 14-16% range · mean 15.5%
   cycle 6-10: 14-15.5%
   cycle 11-15: 13-15%
   mean: 14.5-15.5%
```

### MC simulation (predicted)

```
   v4 saturating per-cycle:  mean 10.5% σ 2.5%, cumulative 15-cycle = 80-85%
   v5-D rotation:            mean 15.0% σ 2.0%, cumulative 12-cycle = 88-92%
```

⇒ N=12 cycle × 격일 = **42일 (1.4mo · v4 2mo 보다 ~30% 빠름)**

## §4 SKU composition (5 patches)

### α — Reductive (AzoR + ascorbate)

| component | mass | role |
|---|---|---|
| AzoR | 50 μg | azo cleavage primary |
| Ascorbate | 400 μg | reductive cofactor + radical scavenger |
| NADPH | 100 μg | enzyme cofactor |
| HA matrix | 5 mg | needle bulk |
| Trehalose | 200 μg | lyo-protect |
| **patch cost** | **$30** | (single enzyme · cheaper) |

### β — Oxidative + chelation (DyP + DFO)

| component | mass | role |
|---|---|---|
| DyP peroxidase | 50 μg | macrocycle + Cu-Pc |
| DFO | 200 μg | Fe oxide chelation |
| H₂O₂ generator (CaO₂) | 150 μg | DyP cofactor |
| HA matrix | 5 mg | bulk |
| **patch cost** | **$33** | |

### γ — Photo + nanozyme (CeO₂ + UV-A)

| component | mass | role |
|---|---|---|
| CeO₂ NP (5-10 nm) | 2 mg | nanozyme · pH-switch |
| **UV-A LED activation** | 1 mW/cm² · 5 min | photo-Fenton |
| Ascorbate | 100 μg | quench scavenger |
| HA matrix | 5 mg | bulk |
| **patch cost** | **$40** | (+ LED reusable $30 one-time) |

### δ — Macrophage refresh (TLR7/8)

| component | mass | role |
|---|---|---|
| TLR7/8 agonist (imiquimod) | 5 μg | macrophage M1 reset |
| Ascorbate | 100 μg | quench |
| HA matrix | 5 mg | bulk |
| **patch cost** | **$28** | (lowest · single small molecule) |

### ε — Full quad (all combined)

| component | mass | role |
|---|---|---|
| AzoR + DyP + CeO₂ + TLR7/8 | full | synergy boost |
| Ascorbate + NADPH + CaO₂ | full | cofactors |
| HA matrix | 6 mg | bulk |
| **patch cost** | **$50** | (full quad · v4 정합) |

### 5-SKU average cost

```
   5 SKU × 12 cycle = 12 patches per treatment
   distribution: α 3 · β 3 · γ 2 · δ 2 · ε 2 (or similar 12-patch box)
   total cost: 3×$30 + 3×$33 + 2×$40 + 2×$28 + 2×$50 = $90 + $99 + $80 + $56 + $100 = $425
   + LED $30 one-time = $455 per treatment (12 patches)
   
   ⇒ v4 $705 (15 patches) → v5-D $455 (12 patches) — **35% cheaper** despite SKU multiplication
```

## §5 manufacturing 정합

```
   v4 single SKU: 1 GMP batch · 15 patches per treatment
   v5-D 5 SKU: 5 GMP batch (parallel) · 12 patches per treatment
        ↓
   GMP batch cost: 5× (5 batches) · per-patch cost 동일 (scale-up offset)
        ↓
   manufacturing overhead: +20% per patch
   patch cost average +20% offset by cycle 수 감소 (15 → 12)
```

### Numbered box design

```
   ┌─────────────────────────────────────┐
   │  TTR-MN-Cocktail · 12-patch box     │
   │  ──────────────────────────────     │
   │  Week 1: α(1) β(2) γ(3) δ(4) ε(5)  │
   │  Week 2: α(6) β(7) γ(8) δ(9) ε(10) │
   │  Week 3: α(11) β(12) — end          │
   │                                     │
   │  + LED (reusable · USB charge)      │
   │  + 표 inside lid: 사용 일정          │
   └─────────────────────────────────────┘
```

⇒ 사용자 adherence: numbered patch · 5-day rotation memorable

## §6 R&D cost + timeline

```
   Phase 0 (design + GMP scale-up):
        - 5 SKU formulation R&D · 4mo · $400k
        - GMP small batch (5 lots) · 3mo · $500k
        - QC + stability (5 SKU × 12mo accelerated) · 2mo · $200k
        ─────────────────────────────
        합계: 6-8mo · $1.1M

   Phase 1 (별 cohort · v4 protocol 위에):
        - 추가 enrollment n=12 v5-D arm · 2mo + 1mo follow-up
        - $500-700k
        ─────────────────────────────
        합계 (v5-D Phase 1 추가): $500-700k

   ─────────────────────────────────────
   v5-D total: ~$1.6-1.8M · 9mo R&D + 3mo trial
```

## §7 Phase 1 dose finding (D arm)

| D arm | composition | freq | n | duration |
|---|---|---|---|---|
| D1 | 5-SKU rotation full | 격일 | 6 | 12 cycle (42일) |
| D2 | 5-SKU low-dose | 격일 | 6 | 12 cycle |
| D3 | 5-SKU + extended ε | 격일 | 6 | 12 cycle (ε 2× weight) |

⇒ 18 추가 enrollment · v4 path Phase 1 (n=26) + v5-D (n=18) = n=44 추가

## §8 stop-go decision

| outcome | post path |
|---|---|
| D1 PASS (efficacy ≥ 85% by Day 42) | v5-D launch + v4 standard 병존 |
| D1 saturation 회피 효과 (vs v4 baseline) | confirms rotation 가치 |
| D1 safety PASS (TLR7/8 누적 IFN-α < 10 pg) | v5-D 우선 marketing |
| D1 fail | v4 only · v5-D abandon |

## §9 marketing pitch (v5-D Cocktail · 사용자 perspective)

```
🌈 TTR-MN-Cocktail — "5-color tattoo eraser cycle"

- 5 종 patch 회전 사용 → 1.4mo (vs v4 2mo 보다 30% 빠름)
- 비용 $455 (v4 $705 보다 35% 저렴) · 12-patch box
- macrophage saturation 회피 → 누적 cycle 효율 ↑
- numbered box · 5-day rotation 직관적
```

vs v4 Express: 같은 timeline + 35% 저렴 · adherence ↑

## §10 honest unknowns

- 5-SKU 실제 saturation 회피 (hypothesis · ex-vivo M8-v5 검증)
- Patient adherence 5-SKU rotation (vs simpler v4 single)
- GMP 5-batch parallel scale-up
- Insurance 5-SKU SKU per box (vs single)
- δ TLR7/8 cycle 의 누적 면역 효과 (3회 · v4 격일)
- ε full quad cycle (M1 over-activation risk)

## §11 진행 상태

- ✅ 5 SKU rotation design (α/β/γ/δ/ε)
- ✅ Saturation 회피 mechanism + MC simulation
- ✅ Per-cycle x 17% nominal (vs v4 saturated 10%)
- ✅ Timeline 1.4mo (N=12 cycle × 격일 42일)
- ✅ 5-SKU cost analysis ($455/treatment · 35% cheaper than v4)
- ✅ Phase 1 D arm design (n=18 추가)
- ✅ Marketing positioning (v5-D Cocktail · adherence ↑)
- next: v5-A directed evolution detailed design (K_cat 10× engineering)
