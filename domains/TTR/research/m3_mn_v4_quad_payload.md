# TTR-MN M3-v4 — quad payload (triple cascade + TLR7/8 macrophage re-engage)

> milestone: TTR-MN.md "M3-MN v4 — quad payload (triple cascade + TLR7/8 micro-dose)"
> driver: v4 floor (격일 × 2개월) · per-cycle x ≈ 15% target · cascade synergy + macrophage re-activation
> base: M3-MN v2 triple (`TTR/research/m3_mn_v2_triple_cascade.md`) 위 quad 확장

## TL;DR

triple cascade (AzoR + DyP + CeO₂) + **TLR7/8 agonist micro-dose** (imiquimod 유사 · 5 μg/cm²) → macrophage M1/M2 polarization shift · phagocytosis ↑ · cascade efficacy boost ~10%. payload cost $2.6 → **$3.5** (+35%). 안전성: TLR7/8 전신 immune 자극 회피 (micro-dose · site-localized). M6 safety stacking에 immune cohort 추가 monitoring.

## §1 quad payload composition

| component | M3-v2 (triple) | **M3-v4 (quad)** | 변동 · 역할 |
|---|---|---|---|
| AzoR (azoreductase) | 30 μg | **40 μg** | +33% (density 1500 정합) |
| DyP-type peroxidase | 30 μg | **40 μg** | +33% |
| CeO₂ NP (5-10 nm) | 1.5 mg | **2.0 mg** | +33% |
| **TLR7/8 agonist** ★ NEW | — | **5 μg/cm²** | macrophage re-activate (imiquimod 유사) |
| Ascorbate | 200 μg | **300 μg** | +50% (aromatic amine quench) |
| NADPH cofactor | 50 μg | **70 μg** | +40% (격일 turnover) |
| Trehalose | 200 μg | 250 μg | +25% |
| H₂O₂ generator (CaO₂) | 100 μg | 120 μg | +20% |
| **payload subtotal** | **$2.6** | **$3.5** | **+35%** |

## §2 TLR7/8 agonist mechanism (4번째 active)

### Macrophage re-engagement path

```
   기존 잉크 macrophage 처리 cycle
   ─────────────────────────────────
   잉크 phagocytose (Day 0)
        ↓ 3-7 days
   파괴/배출 (Day 3-7)
        ↓
   M0/M2 polarization (rest)
        ↓ 다음 잉크 도착 wait
   
   격일 cycle 시 (3.5일 interval):
   - macrophage 처리 완료 전 다음 cycle 도착
   - M2 polarization (anti-inflammatory) → 새 잉크 받기 어려움
   - cascade 효율 saturation
   
   TLR7/8 agonist 효과
   ─────────────────────────────────
   imiquimod (TLR7) / resiquimod (TLR7/8) micro-dose
        ↓ 24-48 hr
   IFN-α 분비 ↑ (local)
        ↓
   macrophage M1 polarization shift (pro-inflammatory)
        ↓
   phagocytosis 활성 ↑ 2-3× (잉크 +payload 흡수 ↑)
        ↓
   cascade payload encounter ↑
        ↓
   per-cycle x boost ~10% (literature · imiquimod 별 tattoo trial)
```

### micro-dose 정합

```
   imiquimod clinical dose (Aldara cream): 50 mg/dose × 5x/week
   v4 TLR7/8 in patch: 5 μg/cm² × 1 cm² × 15 cycle (2mo) = 75 μg total
   
   ratio: 75 μg / 50,000 μg = 0.0015 (0.15% of clinical dose)
   → systemic immune activation 회피 · local effect only
```

⇒ **micro-dose 1000× 낮음** · 전신 면역 자극 회피

## §3 cascade × TLR7/8 synergy 정량

```
   기존 v3 triple cascade synergy (mass-action): 1.71×
   v4 + macrophage activation: 1.71 × 1.10 = 1.88× (literature: imiquimod 효과 10-30%)
   
   per-cycle x:
     v3 baseline 4.7% × 1.71 × density 1000 (1.33×) = 10.7%
     v4 추가: 10.7% × 1.10 (TLR7/8) × density 1500 (1.25×) × photo 1.20× = 17.6% optimistic
     v4 conservative (mass-action only): 10.7% × 1.10 × 1.20 = 14.1%
```

⇒ **v4 per-cycle x ≈ 14-15% · conservative 12%**

## §4 candidate TLR7/8 agonist (imiquimod analog)

| compound | type | clinical precedent | cost · availability |
|---|---|---|---|
| **Imiquimod** | TLR7 | Aldara (FDA-approved · genital warts · BCC) | $200/g · OTC strength 5% cream |
| Resiquimod (R-848) | TLR7/8 | Phase 2-3 (HPV · cutaneous T-cell lymphoma) | $500/g · research grade |
| Gardiquimod | TLR7/8 | research | $300/g |
| **CL264** | TLR7 selective | research | $100/g · selective · less side effect |
| **Vesatolimod (GS-9620)** | TLR7 | Phase 2 (HBV) | high (clinical grade) · long half-life |
| Polymer-conjugated imiquimod | TLR7 (slow release) | research | custom synthesis |

⇒ **primary: Imiquimod** (FDA-approved 선례 + low cost) · secondary: CL264 (selectivity)

### Imiquimod-MN integration

- micro-dose 5 μg in trehalose core (별 enzyme aliquot)
- lyophilized · stability 12-24mo
- 365 nm UV-A 안전 (imiquimod photo-stable)
- TLR7 활성 → IFN-α + IL-12 release (local · 24-48 hr)

## §5 M6 safety 추가 monitoring (v4 specific)

### Immune cohort endpoint (M9-MN v4)

```
   추가 monitoring (Tier 2c · in-vivo 격일 cohort):
   ─────────────────────────────────
   IFN-α serum (LC-MS · ELISA)         · Cmax · AUC · 누적
   IL-12 cytokine panel                · Day 0 · 7 · 28 · 52
   Macrophage M1/M2 ratio (IHC)        · Day 28 · 52 biopsy
   IgE 항-AzoR · 항-DyP                · serum baseline → Day 52
   Local autoimmunity markers          · ANA · 항-cardiolipin (low-frequency)
   Lymphadenopathy                     · drainage 림프절 ultrasound
```

### gate criteria (safety wall)

| metric | gate | fail-fast |
|---|---|---|
| IFN-α serum Cmax | < 10 pg/mL | > 50 pg/mL (전신 immune 활성) |
| IL-12 Cmax | < 5 pg/mL | > 20 pg/mL |
| M1/M2 ratio Day 52 | ≤ 2.5× baseline | > 4× (chronic inflammation) |
| IgE anti-enzyme | ≤ 2× baseline | > 5× |
| ANA | negative | positive (autoimmune wall) |

## §6 multi-cycle 누적 (v4 quad · 격일)

per-cycle x = 14% (conservative · macrophage boost 1.10 + density 1500 + photo 1.20):

| cycle | 누적 % |
|---|---|
| 1 | 14.0% |
| 4 | 45.4% |
| 8 | 70.2% |
| 12 | 86.0% |
| **15** | **90.5%** ★ |

⇒ 격일 × 15 cycle = **52일 ≈ 1.7-1.9mo** (v4 nominal goal)

## §7 비용 분석 (v3 vs v4)

| item | v3 ($2.6/patch payload) | **v4 ($3.5/patch payload)** | 변동 |
|---|---|---|---|
| AzoR | $0.50 | $0.65 | +30% |
| DyP | $0.50 | $0.65 | +30% |
| CeO₂ NP | $0.30 | $0.40 | +33% |
| **TLR7/8 (imiquimod)** | — | $0.40 | new |
| Ascorbate + NADPH | $0.70 | $0.95 | +36% |
| Trehalose + excipients | $0.40 | $0.50 | +25% |
| HA matrix | $0.20 | $0.25 | +25% |
| **payload total** | **$2.60** | **$3.80** | **+46%** |

⇒ patch total (with manufacturing) = M7-v4 $45/patch · payload 차지 8% 비중

## §8 manufacturing 정합 (M7-v4 정합)

```
   v4 patch composition (1500/cm² · 1 cm² · 1500 needles)
   ───────────────────────────────────────────────────
   tip-loaded core: AzoR + DyP + CeO₂ + TLR7/8 + NADPH
   matrix dispersed: ascorbate + CaO₂ + trehalose
   needle bulk: HA (100-500 kDa)
   
   per-needle loading:
   - AzoR: 27 ng (40 μg / 1500)
   - DyP: 27 ng
   - CeO₂: 1.3 μg
   - TLR7/8: 3.3 ng (5 μg / 1500)
   - ascorbate: 200 ng
   
   lot uniformity: ± 10% per needle (M7-v4 precision casting)
```

## §9 M5-MN v4 handoff

다음 milestone (M5-MN v4: photo MD/QM) 가 받는 입력:
- Quad payload SMILES + 3D models
- TLR7/8 + imiquimod 결합 affinity (TLR7 ECD docking)
- Cu-Pc + UV-A 365 nm triplet state TD-DFT
- Cr₂O₃ band-gap excited state DFT
- Cascade ternary MD with TLR7/8 (10k-15k atom)

## §10 honest unknowns

- TLR7/8 micro-dose boost factor 1.10× (literature 10-30% range)
- Imiquimod cumulative immune activation (반복 격일 dose)
- Photo + TLR7/8 + cascade interaction (지금 시점 모름)
- IFN-α serum Cmax 정확 추정 (10 pg/mL gate · literature sparse)
- 5-yr autoimmune incidence (post-market commitment)
- Polymer-conjugated imiquimod 가능성 (slow release · v5 후보)

## §11 진행 상태

- ✅ Quad payload composition (4 active + 4 excipient)
- ✅ TLR7/8 micro-dose mechanism (macrophage M1 shift + phagocytosis ↑)
- ✅ Synergy quantification (1.71× cascade × 1.10× immune = 1.88×)
- ✅ Candidate TLR7/8 agonist (imiquimod primary · CL264 secondary)
- ✅ Safety monitoring (IFN-α · IL-12 · M1/M2 · IgE · ANA)
- ✅ Multi-cycle 누적 (15 cycle × 격일 × 14% = 90.5% in 52일)
- ✅ 비용 payload $3.80 · patch $45 (M7-v4 정합)
- ✅ M5-MN v4 handoff (photo MD/QM input)
- next: M5-MN v4 (photo MD/QM · GPU pod)
