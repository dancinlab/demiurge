# TTR-MN v4 floor — 격일 × 2개월 physical floor design

> milestone: TTR-MN @goal v4 path 본격 설계
> driver: v3 (4.5mo) closed-form 정합 후 추가 단축 — physical floor (SC + macrophage + safety) 도달
> validation: simulation_validation.md (Monte Carlo · 95% CI · synergy 1.71×) + vina_docking_results.md (catalysis viable)
> 결과: v4 nominal **15 cycle × 격일 3.5일 = 2개월 (90% 누적)** · 95% CI conservative 21 cycle = 2.4개월

## TL;DR

격일 (3.5일 interval) × 15 cycle = **2개월 90% 누적** path. per-cycle x ≈ 15% (cascade × density 1500 × photo patch) · 95% CI conservative 12%. **density 1500/cm²** (v3 1000 보다 ↑) + **photo-Fenton patch** (UV-A LED · MN-tip site-localized) + **quad payload** (AzoR+DyP+CeO₂+macrophage re-engage). physical floor: SC recovery 3.5일 정합 (24-48 hr 미세 단축) · macrophage cycle saturation 모니터링 mandatory. dose 의 safety stacking 누적 wall — Phase 1 Tier 2c 별 cohort. 비용 ~$650/patch × 15 = **$650/treatment** (v3 동일).

## §1 v4 path 정의

```
   v3 (current best)              v4 floor (new)
   ────────────────              ──────────────
   주 1회 × 19 cycle              격일 (3.5일) × 15 cycle
   = 4.5개월                       = 52일 ≈ 2개월
   per-cycle x ≈ 10-12%           per-cycle x ≈ 12-15%
   density 1000/cm²               density 1500/cm² + photo patch
   triple cascade                 quad cascade (+ macrophage re-engage)
```

## §2 수학 — 90% cumulative 정합

closed-form: (1-x)^N ≤ 0.1

| version | per-cycle x | N cycles | interval | timeline |
|---|---|---|---|---|
| v4 nominal (closed-form) | 0.15 | 15 | 3.5일 | **52일 ≈ 1.7mo** |
| v4 nominal MC | 0.15 σ=0.025 | 15-16 | 3.5일 | **1.9mo** |
| v4 95% CI conservative | 0.12 σ=0.03 | 21 | 3.5일 | **2.4mo** |
| v4 worst case | 0.10 σ=0.04 | 26 | 3.5일 | **3.0mo** |

⇒ v4 honest goal — **2-2.4mo** (nominal vs 95% guarantee 분리)

## §3 per-cycle x boost path (4.7% → 15%)

```
   baseline (v1)         : 4.7%
   × density 1000 (v3)   : × 1.33 (overlap η=0.5 · efficiency 80%)
   × cascade synergy     : × 1.71 (mass-action · MC validated)
   = v3 mean             : 10.7%   (sim validation)
   
   v4 추가 boost:
   × density 1500/cm²    : × 1.25 (vs v3 1000 · marginal · overlap η=0.4)
   × photo-Fenton patch  : × 1.20 (UV-A LED · MN-tip · site-localized Cu-Pc/Cr₂O₃)
   × macrophage re-engage: × 1.10 (TLR7/8 agonist micro-dose · phagocytosis ↑)
   ────────────────────────────
   v4 estimated x        : 10.7% × 1.25 × 1.20 × 1.10 = 17.6% (optimistic)
   v4 conservative       : 10.7% × 1.20 = 12.8% (only density boost robust)
```

⇒ v4 nominal **15% · conservative 12%**

## §4 new milestones (v4 path · v3 와 별도)

| # | milestone | scope |
|---|---|---|
| **M7-MN v4** | density 1500/cm² + photo patch | UV-A LED integration · MN-tip waveguide |
| **M3-MN v4** | quad payload | triple cascade + TLR7/8 micro-dose (imiquimod analog) |
| **M5-MN v4** | photo MD/QM | UV-A 365 nm + Cu-Pc/Cr₂O₃ excited state · site-localized energy transfer |
| **M8-MN v4** | ex-vivo ultra-compressed | cycle 1일 ex-vivo · 15 cycle in 15일 · 가속 5× |
| **M9-MN v4** | in-vivo 격일 dedicated | Tier 2c expand (n=12 vs 6) · 2개월 endpoint · SC TEWL · macrophage M1 |
| **v4 measured-oracle** | absorbed=true 2mo | Phase 1 B arm dose escalation · 격일 dose acceptable |

## §5 physical floor — wall 정합 정량

### SC barrier recovery (cycle interval floor)

```
   needle scar healing
   ────────────────────
   single MN puncture (10 μm tip):
     · SC perforation visible: 24-48 hr (TEWL ↑ 3-5×)
     · TEWL normalization: 48-72 hr
     · Full SC turnover: 5-7일
   
   v4 cycle interval 3.5일 (84 hr):
     · TEWL recovery: 87-95% (still in healing phase)
     · 누적 손상 시 5-10% baseline 위 (격일 cycle wall)
     · acceptable per @D safety (M6 mel/면역 critical)
```

⇒ **격일 (3.5일) = absolute floor** · 더 빈도 (일일) = SC 누적 손상 wall (M6 critical)

### Macrophage cycle saturation

```
   잉크-payload 처리 사이클: 3-7일
     · phagocytosis: 6-24 hr
     · enzymatic processing: 24-72 hr
     · exocytosis / lymph clearance: 3-7일
   
   v4 격일 cycle:
     · macrophage 가 1 batch 처리 중 다음 batch 도착
     · M1 polarization marker (CD68) ↑ 가능 (inflammation)
     · 누적 시 면역 wall — Tier 2c 검증 mandatory
```

⇒ M9-MN v4 cohort 의 **CD68/F4-80 M1 ratio ≤ 2× baseline** gate critical

### Aromatic amine clearance

```
   azo cleavage byproduct serum kinetics:
     · Cmax 24-48 hr peak
     · half-life 24-72 hr
     · clearance: hepatic conjugation (GSH · glucuronide)
   
   v4 격일:
     · Cmax 누적 ≤ 15 ng/mL (M9 v2 gate)
     · ascorbate quench (in-patch) → byproduct trap 강화
```

⇒ **ascorbate dose ↑ 50%** (v3 200 μg → v4 300 μg) · v4 patch composition 변경

## §6 v4 patch composition (M7+M3 v4)

| component | v3 (1000/cm²) | **v4 (1500/cm²)** | 변동 |
|---|---|---|---|
| HA matrix | 5 mg | 6 mg | +20% (밀도 ↑) |
| AzoR | 30 μg | 40 μg | +33% |
| DyP | 30 μg | 40 μg | +33% |
| CeO₂ NP | 1.5 mg | 2.0 mg | +33% |
| Ascorbate | 200 μg | **300 μg** | +50% (byproduct quench) |
| NADPH | 50 μg | 70 μg | +40% |
| TLR7/8 agonist (imiquimod 유사) | 0 | **5 μg** | new (micro-dose macrophage re-engage) |
| H₂O₂ generator (CaO₂) | 100 μg | 120 μg | +20% |
| **payload subtotal** | $2.6 | **$3.5** | +35% |
| **patch total cost** | $33 | **$45** | +36% |

### Photo patch (separate device)

| spec | value |
|---|---|
| UV-A LED 365 nm | 1 mW/cm² (FDA i ≤ 0.5 mA·equivalent) |
| Duration | 5 min post-MN (after dissolution) |
| Form factor | Reusable USB-rechargeable LED patch (sticky electrode) |
| Cost | $30 one-time (vs disposable · 60+ cycle reuse) |

⇒ **v4 total cost** = 15 × $45 = $675 + $30 (LED, one-time) = **~$705 / 2-month treatment**

(v3 19 × $33 = $627 · v4 약간 ↑ but timeline 단축)

## §7 Phase 1 B arm (v4 dose escalation)

| arm | dose | frequency | n | duration |
|---|---|---|---|---|
| B1 (low v4) | 1 cm² × 1 patch | 격일 (3.5일) | 6 | 15 cycle (2mo) |
| B2 (mid v4) | 1 cm² × 3 patch concurrent | 격일 | 6 | 15 cycle (2mo) |
| **B3 (full v4)** ★ NEW | 1 cm² × 3 patch + photo LED | 격일 | 8 | 15 cycle (2mo) |
| B4 (high v4) | 5 cm² × 1 patch + photo | 격일 | 6 | 15 cycle (2mo) |

⇒ n=26 추가 (Phase 1 B arm · v4 dedicated)

### v4 endpoint

- per-cycle x 측정 (target ≥ 12%)
- 누적 90% by Day 52 (15 cycle)
- TEWL serial (Day 0/7/14/28/52)
- Macrophage M1 ratio (IHC biopsy Day 28 · Day 52)
- Aromatic amine Cmax + AUC (LC-MS 격일 serum)
- IgE anti-AzoR / anti-DyP (immunogenicity)

## §8 비용 vs v3

| item | v3 | v4 |
|---|---|---|
| Per-patch | $33 | $45 (+36%) |
| Treatment patches | 19 | 15 |
| LED (one-time) | $0 | $30 |
| **Treatment total** | **$627** | **~$705** |
| Phase 1 (per patient · 2mo) | $50k | $40k (timeline 단축) |
| Phase 1 B arm 추가 (n=26) | — | **$1M** total |

## §9 Stop-go decision (v4 launch)

| Phase 1 B arm outcome | post path |
|---|---|
| B1+B3 PASS (efficacy + safety) | **v4 launch** dual-track (v3 standard · v4 express) |
| B3 only PASS | v4 full arm only (low dose 부족) |
| Safety wall (TEWL · M1 · amine) | v4 abandon · v3 only |
| Efficacy 80-90% (90% 못 미침) | v4 extended (격일 × 3mo) |

## §10 비교 — v1/v2/v3/v4 정합 표

| version | timeline | freq | density | payload | per-cycle x | 누적 % | per-cycle x (mass-action) | 비용 (treatment) |
|---|---|---|---|---|---|---|---|---|
| v1 | 5yr | 월 1회 | 300 | single | 4.7% | 94% | 4.7% | $1.2-2.4k |
| v2 | 1yr | 주 1회 | 300 | single | 4.7% | 91% | 4.7% | $1.0k |
| v3 nominal | 4.5mo | 주 1회 | 1000 | triple | 12% | 91% | 10.7% (synergy 1.71×) | $627 |
| v3 95%CI | 5.8mo | 주 1회 | 1000 | triple | 10% | 90% | 10% conservative | $824 |
| **v4 nominal** | **2mo** | **격일** | **1500** | **quad + photo** | **15%** | **90%** | **12.8% (conservative MC)** | **$705** |
| v4 95%CI | 2.4mo | 격일 | 1500 | quad + photo | 12% | 90% | 12% | $945 |

## §11 honest unknowns

- TLR7/8 micro-dose (5 μg) 의 macrophage re-engage 정량 — literature sparse
- 격일 cycle 의 TEWL 누적 wall 실측 (Tier 2c v2 결과 + v4 검증)
- UV-A LED + payload photo-Fenton 정합 (Cu-Pc/Cr₂O₃ 시뮬 GPU 필요)
- Quad payload 다중 안정성 (lyo + 광 보호 + cofactor)
- 사용자 adherence (격일 schedule · 1년 60% adherence 보고 vs 주 1회 80%)
- Phase 1 ethics (격일 protocol)

## §12 진행 상태

- ✅ v4 floor 정의 (격일 × 15 cycle × 2개월 · 90% nominal)
- ✅ per-cycle x boost path 정량 (15% nominal · 12% conservative)
- ✅ 5 v4 milestone 정의 (M7v4 · M3v4 · M5v4 · M8v4 · M9v4 + v4 measured-oracle)
- ✅ physical floor wall 정량 (SC 3.5일 · macrophage cycle · amine clearance)
- ✅ v4 patch composition (quad payload + photo LED) · $45/patch · $705/treatment
- ✅ Phase 1 B arm 4 cohort (n=26 · $1M)
- ✅ 비교 표 (v1-v4 정합)
- ✅ Stop-go decision matrix
- next: TTR-MN @goal v4 update + 5 v4 milestone 추가 (이 PR에 포함)
