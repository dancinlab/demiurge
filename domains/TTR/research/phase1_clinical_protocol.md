# TTR-MN Phase 1 clinical trial protocol (dual-arm 8-cohort · n=52)

> milestone: Phase 1 dose escalation protocol detail · IRB submission ready
> base: M10-MN v3 + v4 measured-oracle endpoint · Pre-IND meeting prep
> target: IRB submission Y2 · enrollment Y2.5 · 24mo trial duration

## TL;DR

Phase 1 first-in-human · **dual-arm 8-cohort** (A1-A3 v3 Standard + B1-B4 v4 Express + 2 placebo) · **n=52 healthy volunteer** · IRB submission Y2 post-IND clearance. Primary endpoint safety + tolerability · secondary efficacy (RGB · OCT · histology biopsy). 6-axis safety stacking + 5-yr melanoma + autoimmune registry. 24mo total (4.5mo treatment v3 + 6mo follow-up + 18mo extension). CRO budget ~$1.5M.

## §1 study design

### Phase 1 8-cohort breakdown

| arm | product | dose | freq | n | duration | timeline |
|---|---|---|---|---|---|---|
| **A1** | TTR-MN v3 Standard low | 1 cm² × 1 patch | 주 1회 | 6 | 19 cycle (4.5mo) | Phase 1 |
| **A2** | TTR-MN v3 Standard mid | 1 cm² × 3 patch | 주 1회 | 6 | 19 cycle | Phase 1 |
| **A3** | TTR-MN v3 Standard high | 5 cm² × 1 patch | 주 1회 | 6 | 19 cycle | Phase 1 |
| **B1** | TTR-MN v4 Express low | 1 cm² × 1 patch + LED | 격일 | 6 | 15 cycle (2mo) | Phase 1 |
| **B2** | TTR-MN v4 Express mid | 1 cm² × 3 patch + LED | 격일 | 6 | 15 cycle | Phase 1 |
| **B3** | TTR-MN v4 Express full | 1 cm² × 3 patch + LED + TLR7/8 | 격일 | 8 | 15 cycle | Phase 1 ★ |
| **B4** | TTR-MN v4 Express high | 5 cm² × 1 patch + LED + TLR7/8 | 격일 | 6 | 15 cycle | Phase 1 |
| **A0** | Placebo (HA-only) | sham | 주 1회 | 4 | 19 cycle | Phase 1 |
| **B0** | Placebo (HA-only + LED placebo) | sham | 격일 | 4 | 15 cycle | Phase 1 |

⇒ **n=52 healthy volunteer** · open-label dose escalation (3+3 design within each arm)

## §2 inclusion / exclusion criteria

### Inclusion (eligible)

```
1. Age 18-65 yr (adult only)
2. Existing tattoo 1-15 yr old · 1-50 cm² area
3. Fitzpatrick I-VI (분류 IV-VI subgroup ≥ 20%)
4. Healthy (CMP · CBC · LFT · creatinine within normal range)
5. Willing to comply with 18-24mo follow-up
6. Sign informed consent
7. Effective contraception (pre-clinical · TLR7/8 immunomodulator)
8. Anti-AAV6 antibody negative (if v5-E pathway · separate)
```

### Exclusion

```
1. Pregnancy / lactation (TLR7/8 contraindicated)
2. Active dermatitis · 잉크 부위 active skin disease
3. History of melanoma · skin cancer (5-yr risk · TLR7/8 immune)
4. Autoimmune disease (lupus · MS · psoriasis · RA · etc · TLR7/8 risk)
5. Immunosuppressive medications (steroids · biologics)
6. Other tattoo removal in past 12mo (laser · TCA · etc)
7. Allergy to HA, ascorbate, DFO, AzoR, DyP, CeO₂, imiquimod
8. Concurrent participation in clinical trial
```

## §3 endpoint table (primary + secondary + exploratory)

### Primary endpoint (safety + tolerability)

```
   Primary: Adverse event (AE) rate · severity (CTCAE v5)
        - Tier 1 (local): erythema · edema · pain
        - Tier 2 (acute 24-72h): aromatic amine · LFT/RFT
        - Tier 3 (Day 7-28): TEWL · macrophage M1 · IFN-α · IgE
        - Tier 3 (Day 7-28): ANA · 멜라닌 · 콜라겐
        - Tier 4 (Day 30-90): scar · 색소 침착 · cutometer · multiphoton SHG
        - Tier 5 (extension 5-yr): melanoma · autoimmune · 광노화
   
   Dose-limiting toxicity (DLT):
        - Grade 3+ skin reaction
        - LFT > 3× ULN
        - IFN-α > 50 pg/mL
        - Aromatic amine serum > 50 ng/mL
```

### Secondary endpoint (efficacy)

```
   Secondary:
        - Ink removal % at cycle 4 (1mo) · 8 (2mo · v4 end) · 19 (4.5mo · v3 end)
        - RGB delta · OCT thickness · biopsy histology
        - Per-cycle x rate (mean ± sd)
        - Comparative: v3 vs v4 efficacy ratio
```

### Exploratory endpoint

```
   - Patient satisfaction (visual analog · daily diary)
   - Adherence (patch usage count · tube depletion)
   - Cost-effectiveness (vs laser comparator)
   - Subgroup: Fitzpatrick IV-VI separate analysis
   - Subgroup: small (< 5cm²) vs large (> 10cm²) tattoo
```

## §4 6-axis safety endpoint detail

| axis | method | frequency | gate |
|---|---|---|---|
| Skin local | visual inspection · photo | daily (logged) | 격주 evaluation |
| TEWL | tewameter · g/h/m² | weekly | ≤ 10% above baseline (cycle 5+) |
| Macrophage M1/M2 | biopsy IHC F4/80 + CD68 | Day 28 · 84 · 168 · 365 (extension) | M1 ≤ 2.5× baseline |
| IFN-α serum | LC-MS or ELISA | bi-weekly | Cmax < 10 pg/mL |
| IgE (항-AzoR · 항-DyP) | serum panel | Day 0 · 28 · 84 · 168 · 365 | ≤ 2× baseline |
| ANA | serum (autoimmune) | Day 0 · 84 · 168 · 365 | negative |
| Aromatic amine | LC-MS serum | weekly | Cmax < 15 ng/mL |

## §5 statistical plan

### Sample size justification

```
   n=52 (8 cohort) · dose escalation 3+3:
        - Detect AE rate ≥ 30% with 80% power (α=0.05)
        - Adequate for safety + tolerability primary
        - Dose-response 분석 (efficacy secondary)
        - Subgroup (Fitzpatrick) requires n ≥ 4 per subgroup
```

### Analysis

```
   - Per-protocol + ITT
   - Bayesian dose escalation (CRM 가능)
   - Mixed-effect model (multi-cycle longitudinal)
   - Multiple comparison correction (Bonferroni for AE)
```

## §6 trial timeline

```
   Y0 (current): protocol drafting · IRB submission
        ↓
   Y2: IND clearance · IRB approval
        ↓
   Y2.5: enrollment start (3 sites US + 1 한국)
        ↓
   Y2.7: First patient enrolled · v3 arm (slow dose escalation)
        ↓
   Y3: v3 arms (A1-A3) treatment complete (4.5mo each)
        ↓
   Y3.5: v4 arms (B1-B4) treatment complete (2mo each · earlier readout)
        ↓
   Y4: Phase 1 analysis · stop-go for Phase 2
        ↓
   Y4-Y9: Extension 5-yr registry (melanoma + autoimmune)
```

## §7 budget (Phase 1)

| item | $ |
|---|---|
| Protocol drafting + IRB submission | 80,000 |
| CRO management + site setup (3 US + 1 한국) | 250,000 |
| Patient recruitment (n=52 · cost-per-patient $5k) | 260,000 |
| GMP MN array + payload (Phase 1 lots) | 200,000 |
| Sono LED device prototype + maintenance | 50,000 |
| Histology + IHC + LC-MS + multiphoton SHG | 280,000 |
| IFN-α + IL-12 + IgE + ANA panels | 80,000 |
| Multiphoton SHG + cutometer + ultrasound · device rental | 30,000 |
| Statistical analysis + medical writing | 80,000 |
| IRB + ethics review (per site) | 30,000 |
| **합계 Phase 1** | **~$1,340,000** |

## §8 5-yr post-market registry (별 trail)

```
   Phase 1 trial 종료 후 5-yr 모니터링:
   - melanoma incidence (skin cancer registry · national db)
   - autoimmune incidence (ANA · clinical follow-up)
   - 광노화 (photoaging) · cutometer 추적
   - 추가 cohort enrollment (post-marketing surveillance)
   
   Budget: $500-800k / year × 5 yr = $2.5-4M extra
```

## §9 IRB submission package (별 doc)

```
   IRB documents:
   - Protocol (this document expanded)
   - Investigator's Brochure (IB)
   - Informed consent form (ICF)
   - Recruitment materials
   - CV (PI · investigators)
   - Site qualification
   - Insurance certificate
   - Conflict of interest disclosure
```

⇒ 별 IRB package 작성 · ~$30k legal + medical writing

## §10 progression milestones (Phase 1 → Phase 2)

| milestone | gate |
|---|---|
| First patient enrolled | trial activation |
| Cohort 1 (A1 + B1 low) Q1 review | safety acceptable |
| Cohort 2 mid review | dose escalation OK |
| Cohort 3+ high review | DLT < 33% |
| End of treatment (Y3-3.5) | primary endpoint met |
| 6mo follow-up (Y4) | safety stable |
| Phase 1 final report (Y4) | Phase 2 IND filing OR stop |

## §11 honest unknowns

- IRB approval timeline (3-6mo per site)
- Recruitment efficiency (n=52 tattooed healthy volunteers)
- DLT (dose-limiting toxicity) early identification
- Subgroup (Fitzpatrick IV-VI) recruitment
- 5-yr registry funding (post-market commitment)
- Insurance / IRB ethics around v4 격일 schedule

## §12 진행 상태

- ✅ 8-cohort dual-arm protocol (n=52)
- ✅ Inclusion/Exclusion criteria
- ✅ 6-axis safety endpoint stacking
- ✅ Secondary + exploratory endpoint
- ✅ Statistical plan (3+3 + Bayesian CRM)
- ✅ Trial timeline (Y2 IRB → Y4 final)
- ✅ Budget ~$1.34M Phase 1 · $2.5-4M 5-yr extension
- ✅ IRB submission package outline
- ✅ Progression milestones
- next (별 작업): IRB submission Y2 post-IND · clinical site activation
