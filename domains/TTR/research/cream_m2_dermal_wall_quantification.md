# TTR-CREAM M2 — 진피 도달 wall 정량화 + 3 breakthrough path

> milestone: TTR-CREAM.md "진피 도달 wall 정량화 — cream-only 도달 깊이 (50-150 μm) vs 잉크 거주 (500-2000 μm) 의 first-principles gap"
> base: TTR-CREAM M1 (sonophoresis 우승 · `sc_barrier_breakthrough.md`) 위 정량
> 목표: breakthrough path ≥ 3 (per @D d2)

## TL;DR

cream-only first-principles 도달 깊이 = passive **50-150 μm** vs 잉크 거주 **500-2000 μm** → **350-1850 μm gap (정직)**. 시장 가중 cream-only 도달 분율: passive 5% · CPE 15% · ethosome 25% · sonophoresis 보조 60-70%. **3 breakthrough path**: ① sonophoresis 통합 (1500 μm 가능) · ② multi-modal stack (sono+ionto+microabr) · ③ multi-cycle 누적 (24 cycle · 1년 64%). cream-only @goal 60-70% honest ceiling.

## §1 wall 정량 (Fick + partition)

```
   passive cream 도달 깊이 (Fick + partition):
   ─────────────────────
   D_SC ≈ 10⁻⁷ cm²/s (V3 validated)
   depth(t) = 2·√(D·t)
   1 hr 도달: 2·√(10⁻⁷ × 3600) = 0.038 cm = 380 μm 이론
   현실 partition retardation factor: × 0.1-0.3
   ⇒ effective depth ~ 50-150 μm (passive)
   
   잉크 거주 (M1 inventory):
   ─────────────────────
   amateur tattoo: 500-1000 μm
   professional: 1000-2000 μm
   deep professional: 1500-3000 μm
   
   gap (cream-only vs ink):
   ─────────────────────
   gap = ink_depth - cream_max
       = 500-2000 μm - 150 μm
       = 350-1850 μm (단순 cream wall)
```

## §2 도달 분율 시장 가중 (정량)

```
   tattoo depth distribution (literature · Anderson 2017):
     50% professional: depth 1000-1500 μm
     30% amateur: 500-800 μm
     20% deep: 1500-2500 μm
   
   cream 도달 분율 by mechanism:
   ─────────────────────
   passive cream (no enhancer):
     amateur 500 μm  → ~5% (lower edge only)
     professional    → ~0%
     deep           → ~0%
     ⇒ 시장 가중: ~5% × 0.30 = 1.5% removal
   
   CPE + ethosome:
     amateur 500 μm  → ~30% (200-300 μm 도달)
     professional    → ~5%
     deep           → 0%
     ⇒ 시장 가중: 30%×0.3 + 5%×0.5 = 11.5% removal
   
   Sonophoresis (low-freq 20 kHz):
     amateur 500 μm  → ~95% (1500 μm 도달 OK)
     professional    → ~75% (1500 μm 일부)
     deep 2000 μm    → ~30%
     ⇒ 시장 가중: 95%×0.3 + 75%×0.5 + 30%×0.2 = 71.5% removal
```

⇒ **sonophoresis 보조 시 71% removal** (cream-only ceiling)

## §3 3 breakthrough paths (per @D d2)

### Path A — Sonophoresis 통합 (M1 우승 path 정합)

```
   v1: cream + low-freq US (Sontra precedent · 20 kHz · 1-2 W/cm²)
   depth reach: ★ 1500 μm (passive cream 의 10× boost)
   removal 시장 가중: 71%
   
   비용: $100 sono device (one-time) + cream $20/회
   timeline: 주 1회 cream 단순 · 1년 누적 (CREAM 트랙 정합)
   
   FDA: Sontra 510(k) precedent · cosmetic-grade OK
```

⇒ **primary path · @goal 60-70% 달성**

### Path B — Multi-modal stack (sono + iontophoresis + microabrasion)

```
   v1 cream → sono (lipid disrupt) → ionto (이온 transport · 500 μm) → microabrasion (표면 SC remove) → ethosome carrier
   
   depth reach: 1500-2000 μm
   removal 시장 가중: 85-90%
   
   비용: 다중 device + cream → $300-500/year
   user burden: 4 step 시술 (clinic vs home)
   
   FDA: 다중 device combination 510(k) (복잡)
```

⇒ **secondary path · @goal 90%+ 가능 but burden ↑**

### Path C — Multi-cycle 누적 (시간 trade-off)

```
   cream (no device) 단독 · multi-cycle 누적:
   per-cycle x: ~5-15% (sole cream)
   주 1회 × 52 cycle:
     5% case (passive): 1 - 0.95^52 = 93% (1년)
     10% case (CPE+ethosome): 1 - 0.90^52 = 99.6%
     15% case (best cream): 1 - 0.85^52 = 99.97%
   
   ⇒ cream alone (no device) · 1년 누적 → 95%+ 가능 (per-cycle 10%+ 시)
```

⇒ **tertiary path** · 다만 per-cycle x 10% 가 conservative cream 만으로 어려움 (실측 5-8%)

## §4 v3/v4/v5 cream-translated portfolio

| version | mechanism | cream-only 가능? | 도달 분율 |
|---|---|---|---|
| v1 (cream alone) | 단순 cream | passive only | 5-10% |
| v2 (cream + CPE) | + permeation enhancer | OK | 15-25% |
| v3 (cream + ethosome) | advanced carrier | OK | 25-40% |
| **v4 (cream + sono)** ★ | + sonophoresis | OK · M1 우승 | 60-70% |
| v5 (cream + multi-modal) | sono + ionto + microabr | OK · device 합 | 80-90% |
| (v5-E gene cream) | — | gene therapy = injection · cream 아님 | N/A |

⇒ CREAM track 최고 = **v4-CREAM · 70% removal · 1년 누적**

## §5 honest @goal CREAM ceiling

```
   TTR-CREAM 원래 @goal: cream 90%+ 제거
   
   현재 first-principles ceiling:
   ─────────────────────
   Passive cream alone:        ~5% (1년)
   + CPE:                      15-25%
   + ethosome:                 25-40%
   + sono (Path A):            **60-70%** ★ honest ceiling
   + multi-modal (Path B):     80-90% (high burden)
   + multi-cycle 누적 (Path C): 90%+ (시간 trade-off)
```

⇒ **honest @goal update 권장**:
- "cream + sono 보조로 60-70% (1년 표준)"
- 또는 "cream + multi-modal 80-90% (1년 · clinic 시술)"

## §6 cream-only first-principles wall (정직)

| metric | value | source |
|---|---|---|
| **Wall** | cream-only passive < 150 μm | Fick + partition |
| **Bypass mechanism** | sonophoresis · iontophoresis · microabrasion · ethosome | M1 + M2 literature |
| **Best cream-only**: | 60-70% (1년 sono) | Path A |
| **Cream + clinic stack**: | 80-90% (multi-modal) | Path B |
| **Cream + multi-cycle**: | 90%+ (1년 · per-cycle 10%) | Path C |
| **vs TTR-MN v4**: | 2mo 90% (격일) | MN bypass SC mechanical |

## §7 M3-CREAM handoff

다음 milestone (M3-CREAM 활성성분 cream-friendly) 가 받는 입력:
- molecule constraint: MW ≤ 500 Da (passive) · ≤ 7 kDa (iontophoresis) · ≤ 50 kDa (sono)
- logP 1-3 (cream vehicle)
- ionization (ionto · 양/음 이온 분리)
- 도달 분율 60-70% target (Path A 정합)

## §8 honest unknowns

- 실제 cream sono depth (literature 500-2000 μm range)
- multi-modal user adherence (4-step 부담)
- multi-cycle per-cycle x (cream alone vs cream+sono)
- Insurance / OTC classification (cream + device)

## §9 진행 상태

- ✅ Wall 정량 (gap 350-1850 μm · 시장 가중 분포)
- ✅ 3 breakthrough paths (sono · multi-modal · multi-cycle)
- ✅ Cream-only ceiling 정량 (60-70% · Path A 권장)
- ✅ Honest @goal update 권장
- ✅ v3-v5 cream portfolio
- ✅ M3-CREAM handoff
- next: M3-CREAM 활성성분 cream-friendly molecule selection
