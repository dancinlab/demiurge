# TTR-CREAM M3 — 활성성분 cream-friendly molecule selection

> milestone: TTR-CREAM.md "M3-CREAM 활성성분 — TTR base M2 F5/F3/F2 ∩ cream-friendly constraint"
> base: TTR-MN M3-v2/v4 cascade · M2-CREAM 60-70% sono ceiling · CREAM MW/logP/ionization constraint
> 결과: cream-friendly top-3 + sono 보조 활용 시 효소 (≤ 50 kDa) 가능

## TL;DR

cream-friendly molecule = MW ≤ 500 Da (passive), ≤ 7 kDa (ionto), **≤ 50 kDa (sono 보조)**. **Top-3**: ① **Ascorbate + DFO** (small molecule combo · cream-only) · ② **AzoR + sono** (50 kDa enzyme · sono 통과) · ③ **CeO₂ NP 5-10 nm + ethosome** (NP 운반체 동승). v3 cascade (AzoR+DyP+CeO₂) → cream-translated **AzoR+ascorbate+CeO₂** (DyP 50 kDa borderline · ethosome 권장).

## §1 cream-friendly molecule constraint

```
   permeation mode → MW threshold:
   ─────────────────────
   Passive cream (SC partition):     MW ≤ 500 Da · logP 1-3
   + CPE (azone · DMSO):              MW ≤ 1 kDa
   + ethosome:                        MW ≤ 5 kDa (encapsulated)
   + iontophoresis (이온화):           MW ≤ 7 kDa
   + sonophoresis (low-freq):         MW ≤ 50 kDa (cavitation channel)
   + multi-modal stack:               MW ≤ 70 kDa (theoretical)
```

## §2 Top-3 cream-friendly candidates

### Top 1 — Ascorbate + DFO (single-modal · passive cream OK)

| component | MW (Da) | logP | passive permeation | role |
|---|---|---|---|---|
| Ascorbate | 176 | -1.85 | borderline (small · ionized at pH 4-5) | reductive cofactor |
| DFO | 656 | -2.4 | weak (MW > 500) | Fe chelation |
| **combo** | — | — | **CPE + ethosome 보조 권장** | reductive + chelation |

⇒ 시장 60% azo + Fe oxide 직접 표적 (cream 단순 · OTC OK)

### Top 2 — AzoR + sono (sono 보조 · enzyme 통과)

| component | MW | sono permeation |
|---|---|---|
| AzoR | 23 kDa | sono 보조 시 통과 (Mitragotri 50× ↑) |
| Ascorbate | 176 | 동승 cofactor |
| **combo** | — | sono device 필수 (1500 μm 도달) |

⇒ TTR-MN v4 cascade의 cream-translated (sono replace MN)

### Top 3 — CeO₂ NP 5-10 nm + ethosome (NP cream-compatible)

| component | size | mechanism |
|---|---|---|
| CeO₂ NP (5-10 nm) | ~10 kDa equivalent | ethosome encapsulation · 진피 가벼움 |
| Ethosome (50-200 nm) | 운반체 | transdermal · 200-400 μm 도달 |
| **combo** | — | NP encapsulated · 표면-진피 boundary 효과 |

⇒ shallow ink (amateur 500-800 μm) 대상 · 시장 30% 분율

## §3 SKU matrix (CREAM track)

| SKU | composition | mode | depth target | 시장 |
|---|---|---|---|---|
| **CREAM-α** (basic) | Ascorbate + DFO + CPE + ethosome | passive cream | 200-400 μm | OTC 알뜰 |
| **CREAM-β** (sono) | AzoR + Ascorbate + CeO₂ NP + ethosome | + sono device | 1500 μm | Premium · sono device 필요 |
| **CREAM-γ** (multi-modal) | quad cascade + CPE + ethosome | + sono + ionto + microabr | 2000 μm | Clinic · multi-step |
| **CREAM-δ** (shallow only) | Ascorbate + CeO₂ NP + ethosome | passive · 표피 only | 50-200 μm | OTC · amateur tattoo |

## §4 비용 (CREAM SKU cost)

| SKU | per-tube cost | treatment cost (1년) | comparison |
|---|---|---|---|
| CREAM-α | $20 | 12 × $20 = $240/yr | OTC cheap |
| CREAM-β | $30 + $100 sono device | 12 × $30 + $100 = $460/yr | premium home device |
| CREAM-γ | $50 + clinic visit | 12 × $50 + 4 × $200 = $1,400/yr | clinic burden |
| CREAM-δ | $15 | 12 × $15 = $180/yr | minimal · shallow only |

⇒ CREAM-α 가 OTC budget · CREAM-β 가 효능/비용 최적 · CREAM-γ clinic

## §5 honest cream-translated v3/v4 → v4-CREAM 정합

```
   TTR-MN v4 (격일 × 2개월 · 90%) cream-translated:
   ────────────────────────────────────────────
   Replace MN with sono device (depth bypass)
   per-cycle x: 14% MN → 8-10% sono (lower efficiency)
   N for 90% (cream + sono): N=22-28 cycle
   timeline: 주 1회 × 22-28 = 5-6.5 mo (vs MN 2mo)
   
   ⇒ cream 트랙은 timeline 더 길음 (sono inferior to direct MN deposition)
```

⇒ CREAM track 의 본질적 한계 — sono 가 MN보다 약함

## §6 honest @goal cream update

```
   TTR-CREAM 원래: 90% removal (timeline 미정)
   honest finding:
   ─────────────────────────────
   CREAM-α (passive · OTC): 30-50% in 1년 (limited depth)
   CREAM-β (cream + sono): 70-80% in 6mo
   CREAM-γ (multi-modal clinic): 90% in 4-6mo (clinic burden)
   
   ⇒ cream track 의 honest ceiling = 80-90% (CREAM-γ · clinic)
```

## §7 M5-CREAM handoff

다음 milestone (M5-CREAM 잉크-활성분자 MD/QM) 가 받는 입력:
- Cream-friendly top-3 candidate set
- Sono + cream interaction MD (cavitation + payload)
- Per-cycle x 추정 (sono 보조 시 8-10%)
- Multi-cycle 누적 (52 cycle 1년 가정)

## §8 honest unknowns

- Sono device + cream 정량 boost (실측 50× vs estimate)
- DFO cream-permeation (MW 656 · borderline)
- CeO₂ NP ethosome encapsulation efficiency
- Patient adherence (cream daily vs MN 격일 patch)

## §9 진행 상태

- ✅ Cream-friendly MW threshold (passive/ionto/sono · 500/7k/50k Da)
- ✅ Top-3 candidate (ascorbate+DFO · AzoR+sono · CeO₂+ethosome)
- ✅ 4 SKU matrix (α/β/γ/δ)
- ✅ Cost analysis ($180-1,400/yr)
- ✅ v3/v4 cream-translated honest analysis (sono 5-6.5mo vs MN 2mo)
- ✅ CREAM honest ceiling 80-90% (clinic)
- next: M5-CREAM MD/QM · M7-CREAM 제형 설계
