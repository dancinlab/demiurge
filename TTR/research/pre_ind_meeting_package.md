# TTR-MN Pre-IND Type B meeting package (FDA · briefing 자료)

> milestone: FDA Pre-IND Type B meeting prep · 22-24mo IND filing 전 합의
> base: 모든 design + verify (per @D d5 absorbed) · TTR-MN v3+v4 dual-arm
> target: FDA briefing 자료 + 5 핵심 question · meeting Y1.5

## TL;DR

Pre-IND Type B meeting 가이드 (FDA 21 CFR 312.82) · TTR-MN v3 Standard + v4 Express **dual-arm IND** 합의 목표. 5 핵심 question: ① dual-track 가능 여부 ② v3/v4 dose escalation arm split ③ TLR7/8 micro-dose IND requirement ④ 5-yr melanoma + autoimmune registry ⑤ CMC v2 (1500/cm² array + photo LED + quad cascade) acceptable.

## §1 meeting 목표 (5 핵심)

| # | question | rationale |
|---|---|---|
| Q1 | TTR-MN v3+v4 **dual-arm IND** (single submission · 두 protocol arm) 가능? | resource saving · regulatory precedent unclear |
| Q2 | Phase 1 dose escalation **8-arm** (A1-A3 v3 + B1-B4 v4 + 2 placebo) acceptable? | n=52 · 일반보다 큼 |
| Q3 | TLR7/8 micro-dose (5 μg = 0.15% Aldara) **IND 요구 수준**? | imiquimod-class drug · combination |
| Q4 | 5-yr post-market **melanoma + autoimmune registry** 적정 design? | TLR7/8 long-term commitment |
| Q5 | CMC v2 (1500/cm² density + LED + quad cascade) **acceptable specifications**? | first-in-class CMC complexity |

## §2 briefing document outline (FDA submission template)

### Section A — Introduction

```
1.1 Sponsor: [TTR Therapeutics 가칭]
1.2 Product: TTR-MN (dissolving microneedle array · topical 잉크 제거)
1.3 Indication: tattoo ink removal (cosmetic + medical · 별 indication 가능)
1.4 Regulatory pathway: 505(b)(2) combination product (CDER lead · CDRH secondary)
1.5 Pre-IND meeting type: Type B
1.6 Target IND filing: 22-24 mo post-meeting
```

### Section B — Product summary

```
2.1 Product description
    - HA dissolving MN array (1200 μm × 1500/cm² · v4 spec)
    - Triple/quad cascade payload (AzoR + DyP + CeO₂ · ± TLR7/8)
    - UV-A LED photo patch (365 nm · 1 mW/cm² · 5 min · v4 only)
2.2 Mechanism (3-tier)
    - Mechanical SC bypass (MN)
    - Chemistry cascade (enzyme + nanozyme + photo)
    - Macrophage re-engagement (TLR7/8 · v4 only)
2.3 Dual-arm formulation
    - v3 Standard: 주 1회 × 19 cycle = 4.5mo
    - v4 Express: 격일 × 15 cycle = 2mo
```

### Section C — Non-clinical pharmacology (design phase summary)

```
3.1 In-silico
    - M3-MN ranking: AzoR (P41407) · DyP (4G2C) · CeO₂ NP
    - M5 MD/QM 12-cell + photo 8-cell (별 cohort GPU pod $685)
    - Vina docking: AzoR ΔG -5.35 kcal/mol · binding viable
3.2 First-principles validation
    - V1-V6 verify 92-claim · 84% PASS
    - Monte Carlo multi-cycle validated
    - Mass-action synergy 1.71× (vs closed-form 2.5× honest disclosure)
3.3 Wall coverage (Cu-Pc · Cr₂O₃)
    - Photo-Fenton + DFO + UV-A LED stack
    - arxiv:2405.11122 + 2104.10994 정합
```

### Section D — Non-clinical toxicology (design phase summary)

```
4.1 Off-target safety (M6 · 24-cell matrix)
    - 🔴 critical: Mel × Oxidation · Mel × Photo · Col × Oxidation
    - Mitigation: CeO₂ pH-switch + ascorbate scavenger + LED site-localized
    - TI improvement v1 1e-9 → v4 1e-5 (3-4 OoM)
4.2 5-tier safety stacking (M6/M9 cross-ref)
    - Tier 1-2 immediate/24-72h (aromatic amine Cmax < 15 ng/mL)
    - Tier 3 Day 7-28 (TEWL/M1/IFN/IgE/ANA)
    - Tier 4 Day 30-90 (scar/색소)
    - Tier 5 5-yr registry (melanoma · autoimmune)
4.3 Genotoxicity
    - Ames + chromosomal aberration (aromatic amine focus)
4.4 Carcinogenicity
    - 5-yr post-market commitment
```

### Section E — Clinical protocol (Phase 1 design)

```
5.1 Phase 1 dual-track 8-arm
    A1 v3 low / A2 v3 mid / A3 v3 high (주1회)
    B1 v4 low / B2 v4 mid / B3 v4 full / B4 v4 high (격일)
    Placebo A0 (주1회) + B0 (격일)
    n=52 healthy volunteer
5.2 Inclusion criteria
    - 18-65 yr · tattoo 1-15 yr old · 1-50 cm² area
    - Fitzpatrick I-VI (subgroup analysis IV-VI)
    - 항-AAV6 antibody (if v5-E later)
5.3 Primary endpoint: safety + tolerability
5.4 Secondary endpoint: efficacy (RGB · OCT · histology biopsy)
5.5 Duration: 4.5mo v3 + 2mo v4 + 6mo follow-up
5.6 Long-term: 5-yr registry (melanoma + autoimmune)
```

### Section F — CMC

```
6.1 Drug substance
    - AzoR: recombinant E. coli BL21 · GMP USP-grade
    - DyP: B. adusta recombinant · CHARM-GUI standard
    - CeO₂ NP: 5-10 nm · USP cosmetic-grade
    - TLR7/8 (imiquimod): USP-grade pharma
6.2 Drug product
    - HA matrix 100-500 kDa
    - 1500/cm² density · 1200 μm L · 6-8 μm tip
    - 24mo @ 25°C (α/δ) · cold-chain (β/γ enzyme)
6.3 Manufacturing
    - CDMO: Vaxxas (primary) · Innopharma (secondary)
    - GMP precision casting (1-2 μm tolerance)
6.4 Quality system
    - cGMP 21 CFR 211 · ICH Q1A stability · USP <61>/<71>/<85>
```

## §3 anticipated FDA feedback (5 핵심 question 별)

### Q1 — dual-arm IND

```
   expected feedback:
   - dual-arm IND acceptable IF protocols are clearly separable
   - sponsor must justify resource sharing rationale
   - separate IND consideration in case of safety divergence
   
   sponsor argument:
   - same product (TTR-MN) different dosing (v3 vs v4)
   - safety endpoints identical · efficacy primary differ
   - cost saving · timeline shortened
```

### Q2 — 8-arm dose escalation

```
   expected feedback:
   - 8-arm complex · large n=52
   - dose escalation rules (3+3 vs CRM) need clarification
   - placebo arms (A0+B0) ethical concern (cosmetic) — may waive
   
   sponsor argument:
   - dose-response + safety stacking
   - 8-arm parallel saves time
   - placebo: open-label sham-controlled possible
```

### Q3 — TLR7/8 IND requirement

```
   expected feedback:
   - imiquimod-class drug requires separate consideration
   - micro-dose (0.15% Aldara) may waive standalone IND
   - immunogenicity monitoring critical
   
   sponsor argument:
   - 5 μg micro-dose = 0.15% Aldara · local only
   - precedent: combination patch (Aldara cream → micro-MN)
   - safety: IFN-α monitor · IgE 항-imiquimod
```

### Q4 — 5-yr registry

```
   expected feedback:
   - 5-yr melanoma standard for skin product
   - autoimmune (TLR7/8 specific) — separate consideration
   - registry scale (~500-1000 enrolled · long-term cost)
   
   sponsor argument:
   - 5-yr post-marketing commitment standard
   - autoimmune incidence ≤ background × 1.5 acceptable
   - registry funded via post-market revenue
```

### Q5 — CMC v2 acceptable

```
   expected feedback:
   - 1500/cm² density · lot reproducibility critical
   - LED + cream + cascade combination — first-in-class
   - photo activation specs · power density safety
   
   sponsor argument:
   - Vaxxas HD-MAP 선례 (1000/cm² 확립)
   - CDMO precision 1-2 μm verified
   - LED photo within FDA 510(k) class I cosmetic
```

## §4 meeting preparation timeline

| step | duration |
|---|---|
| Draft briefing document (TTR Therapeutics team) | 2 mo |
| FDA pre-meeting consultation (regulatory consultant · ~$30k) | 1 mo |
| Mock meeting + briefing doc revise | 1 mo |
| FDA Type B meeting request submission | 1 day |
| **FDA 75-day clock** (meeting scheduled within 75 days) | 75 일 |
| **Actual meeting** (60-90 min) | half-day |
| Meeting minutes + clarification | 1-2 wk |
| Post-meeting follow-up + IND draft | 2-3 mo |

⇒ total **~6 mo prep + 75-day FDA clock** · meeting Y1.5

## §5 meeting attendees

```
   Sponsor side:
   - CEO + CSO (vision · science)
   - Regulatory consultant (FDA submission expert)
   - CMC manager (manufacturing details)
   - Clinical lead (Phase 1 protocol)
   - Toxicologist
   - IP counsel (optional)
   
   FDA side:
   - Division Director (CDER · drug)
   - CDRH liaison (device)
   - Toxicology reviewer
   - CMC reviewer
   - Clinical reviewer
   - Project manager (scheduling)
   
   Total: ~12-15 attendees
```

## §6 success metrics

```
   meeting outcomes:
   ─────────────────
   ✅ Strong outcome: FDA agrees on dual-arm IND path
   △ Mid outcome: FDA requests modifications (split arms · simpler Phase 1)
   ❌ Poor outcome: FDA rejects dual-arm · forces separate IND
   
   ✅ Strong outcome 시: IND filing 22 mo · launch Y3
   ❌ Poor outcome 시: IND filing 28-32 mo · launch Y4
```

## §7 budget (pre-IND meeting + IND prep)

| item | $ |
|---|---|
| Regulatory consulting (FDA + CMC expert) | 80,000 |
| Briefing document writing (medical writer) | 30,000 |
| Mock meeting (2 rounds · expert panel) | 25,000 |
| FDA submission fees (Type B meeting free) | 0 |
| Travel + meeting prep | 10,000 |
| Post-meeting follow-up + IND draft start | 50,000 |
| **합계** | **~$195,000** |

## §8 alternate path (if FDA rejection)

```
   Plan B — separate IND:
   - v3 Standard IND first (timeline 22mo)
   - v4 Express IND 1yr later (시간 ↑)
   - cost +$300k (별 IND filing fee)
   
   Plan C — separate Phase 1:
   - v3 first n=24 · v4 next n=26
   - duration 36mo (vs dual 22mo)
   - cost +$500k
   
   Plan D — Phase 1 simplification:
   - reduce 8-arm → 4-arm
   - drop B4 high · A3 high
   - n=32 (vs 52)
```

## §9 진행 상태

- ✅ 5 핵심 question 정의
- ✅ Briefing document outline (Section A-F)
- ✅ Anticipated FDA feedback per question
- ✅ Meeting prep timeline (6mo + 75-day FDA clock)
- ✅ Attendee list + roles
- ✅ Success metrics + alternate paths
- ✅ Budget ~$195k (Seed funding 정합)
- next (별 작업): Briefing document 실제 작성 + FDA submission (Series A 후)
