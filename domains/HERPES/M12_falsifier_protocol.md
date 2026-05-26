# M12 — Pre-declared falsifier protocol (Popper 표준) for HSV sterilizing cure

> 마일스톤 M12 산출물 · current-state · no history. /gap F4 deep-dive (M10 §5 success endpoint 잘 정의되었으나 falsifier 미선언) 의 정식화.
>
> 정책 — @D g5 (verdict verbatim · LLM 자가심판 금지) · @D d1 (non-wet-lab → completed-form) · Popper falsifiability invariant.
>
> 본 문서는 M10 §5 (success-side hierarchy) 의 **역방향 inverse** — "어떤 관측이 H_central 을 reject 하는가" 를 사전선언 · 객관화 · LLM-judge 배제 (rule-based) 로 catalogue.

---

## 0. Popper epistemic preamble — 왜 falsifier 가 필요한가

### 0.1 Popper demarcation criterion

Karl Popper (*Logic of Scientific Discovery*, 1934):

> **"A theory is scientific if and only if it makes risky predictions that could in principle be falsified by observation."**

비대칭성 — verification 으로 prove 불가, falsification 으로만 reject 가능:

```
관측 결과 → 가설
─────────────────────────────────────────────────────
"sterilizing cure achievable" (Arm S hypothesis)
  ├─ 모든 관측 PASS → "not-yet-falsified" (corroborated, NOT proved)
  └─ 한 관측 FAIL (decisive) → FALSIFIED (epistemically stronger)
```

### 0.2 H_central — central hypothesis 정확한 formal 형태

> **H_central**: "M10 Arm S stack (M5 dual meganuclease + M6 3-axis LRA + M8 PD-1/LAG-3 + M9 pentavalent mRNA, 10-15 cycle, 12-18 month) 은 HSV seropositive 성인 (M10 §2 stratification PASS) 에서 N_residual ≤ 1 latent genome / host 를 ≥80% cohort 에서 달성한다."

falsifiable 이 되려면 — "어떤 관측이 H_central 을 reject 하는가" 가 **사전 (pre-declared, post-hoc 변형 금지)** 명시. M10 §5 4-surrogate AND-gate 는 SUCCESS condition 이지 FAILURE condition 이 아니다.

### 0.3 M12 의 epistemic 역할 = inverse of M10 §5 + selectivity boost

| M10 §5 (success) | M12 (falsifier) |
|---|---|
| 4-surrogate AND-gate PASS | 11-falsifier OR-gate FIRE (§7 consistency check) → H_central FALSIFIED |
| LLM-judge 가능 | LLM-judge 배제 — rule-based + statistical pre-specified |
| post-hoc 분석 허용 | pre-declared lock-in (post-hoc 변형 금지) |
| stop rule (M10 §8.3) — trial halt safety/futility | falsifier — hypothesis reject (program-decisive, orthogonal) |

---

## 1. Falsifier vs Validator — 1-page primer

### 1.1 정의

| 개념 | 정의 | 예 |
|---|---|---|
| **Validator** | 가설 SUPPORT 관측 (necessary-but-not-sufficient) | M10 §5 ddPCR 12/12 NEG · LAT-miRNA below LOD |
| **Incomplete validator** | validator 중 fail — reject 못함, "more data needed" | LAT-miRNA 1/4 quarter at LOD |
| **Decisive falsifier** | 관측 시 가설 reject — alternative interpretation 배제 | ddPCR 6/12 NEG-fail pattern |
| **Stop rule** | trial halt — safety/futility (별개 축) | M10 §8.3 Grade 4 irAE ≥3 patient |

### 1.2 핵심 구분

**failure of validator ≠ falsification**. M10 §5 4-surrogate AND-gate FAIL = "cure not demonstrated this protocol/cohort" 일 뿐 — achievable 여부는 별도. M12 의 falsifier 가 그 별도 판단을 객관화.

```
H_central status matrix
                    │ validator PASS │ validator FAIL │
─────────────────────┼────────────────┼────────────────┤
falsifier NOT-FIRE   │ corroborated   │ incomplete     │
                    │ (not proved)   │ (more data)    │
─────────────────────┼────────────────┼────────────────┤
falsifier FIRE       │ contradictory  │ FALSIFIED      │
                    │ → re-audit     │ (decisive)     │
─────────────────────┴────────────────┴────────────────┘
```

"contradictory" 셀 (validator PASS + falsifier FIRE) → §7 artifact filter audit 우선.

### 1.3 본 M12 catalogue 구조

- **Tier I (empirical observable)** — 임상 trial ≤24mo 안에 단일 cohort 관측으로 fire. decisive, immediate.
- **Tier II (wet-lab confirmatory)** — population-decisive · cohort-population 단위 confirm.
- **Tier III (theoretical/systemic)** — H_central mechanistic pillar collapse · program-decisive.

---

## 2. Tier I — Empirical observable falsifier (immediate decisive) — 5 falsifier

### 2.1 F-I-1 ddPCR persistent shedding

- **목표 hypothesis fragment**: "Arm S 후 ≥80% patient 에서 ddPCR shedding 12/12 NEG" (M10 §5.2 #1)
- **trigger 관측**: post-week-26 monthly oral/genital swab ddPCR ≥6/12 sample ≥1 cp/10⁵ epi cell (per-patient, n ≥ 6/cohort)
- **measurement protocol**: M10 §5.2 동일 — ddPCR (Bio-Rad QX200) HSV UL30 primer · 10⁵ epi cell input · LOD 0.5 cp/well
- **sample size + threshold**: per-patient 12 swab; binomial test H0=0.05 background, observed ≥6/12 → p<0.001 reject
- **timeline**: week 0 → week 52
- **decision**: **partial demote** — Arm S 10-15 cycle 부족, cycle 추가 또는 Arm F 전환 권고
- **falsifies**: M10 §5.2 #1 · M10 §11.3 best-case body 5 cycle · M5 §6.6

### 2.2 F-I-2 LAT-miRNA blood persistence

- **목표**: "ddPCR + LAT-miRNA AND ⇒ N_lat ≤ 10" (M10 §7.3 mapping)
- **trigger**: quarterly ddRT-PCR LAT-miRNA (miR-H1~H6 합) ≥1 cp/mL at **≥3/4 quarterly timepoint** over 12mo, n ≥ 6/cohort
- **protocol**: M10 §5.2 #2 + §7.3 lookup — ddRT-PCR LOD ~10 cp/mL · blood concentration ↔ N_lat mapping
- **threshold**: 3/4 timepoint ≥1 cp/mL ⇒ N_lat ≥ 10³ (95% CI Poisson) ≫ ≤1 target
- **timeline**: week 26 → week 78
- **decision**: **full reject** — reservoir ≥10³ 잔존 (3-log gap), Arm F 전환 mandatory
- **falsifies**: M10 §5.2 #2 · §7.3 · M2 §7.1

### 2.3 F-I-3 confirmed clinical recurrence + triple-positive

- **목표**: "Arm S 후 24-month follow-up zero clinical lesion event" (M10 §5.2 #3)
- **trigger**: confirmed (photographic + clinician-graded ≥Grade 2 HSV-typical) recurrent lesion AND lesion swab ddPCR POS AND LAT-miRNA blood concurrent POS — single event triggers per-patient
- **protocol**: M10 §5.2 #3 daily diary + photograph + lesion swab + concurrent blood draw
- **threshold**: binomial null=0.001/yr post-cure; cohort-level reject ≥30% patient
- **timeline**: post-Arm S week 26 → week 130
- **decision**: **per-patient full reject**; cohort ≥30% → cohort-level full reject
- **falsifies**: M10 §5.2 #3 zero lesion · M10 §11 best-case · M7 §5

### 2.4 F-I-4 median cycle count > 25

- **목표**: "realistic case 10-15 cycle 내 N_residual ≤ 1" (M10 §11.4)
- **trigger**: empirical cohort 에서 N_residual ≤ 1 도달 median cycle > 25 (n ≥ 6)
- **protocol**: per-cycle ddPCR + LAT-miRNA monitoring → 4-surrogate PASS 도달 cycle 기록
- **threshold**: median > 25 with 95% CI lower-bound > 20 (Wilcoxon signed-rank vs H0 median = 12)
- **timeline**: open-ended (protocol cap 30 cycle)
- **decision**: **partial demote** — Arm S timeline-impractical, Arm F 또는 next-gen LRA 권고
- **falsifies**: M10 §11.4 · M5 §6 · M2 §7.2

### 2.5 F-I-5 shedding rebound post-Arm-S

- **목표**: "Arm S 완료 후 shedding frequency monotonic decrease" (M10 §5.2 #1 longitudinal)
- **trigger**: post-Arm S month-6 → month-24 ddPCR shedding frequency cohort median ≥2-fold rebound (week-26 nadir 대비)
- **protocol**: monthly swab × 24mo → segmented regression with breakpoint at week 26
- **threshold**: rebound slope > 0 with p < 0.05 (likelihood ratio test vs monotonic-decrease null), n ≥ 6 consistent
- **timeline**: week 26 → week 130
- **decision**: **partial demote** — Arm S durability 미흡, booster cycle 또는 Arm F 전환
- **falsifies**: M10 §5.2 trajectory · M11 sensitivity · M4 §5.5 u_crit stability

---

## 3. Tier II — Wet-lab confirmatory falsifier (population-decisive) — 3 falsifier

### 3.1 F-II-6 ¹⁸F-FIAU PET imaging residual ganglion activity

- **목표**: "ddPCR shedding NEG ⇒ ganglion reservoir ≤1" (M10 §7.2 mapping)
- **trigger**: ¹⁸F-FIAU PET (M10 §7.4 PoC) shows ≥50% baseline TG SUV at 12mo post-Arm S in cohort that PASSED M10 §5.2 4-surrogate
- **protocol**: M10 §7.4 ¹⁸F-FIAU PET HSV-TK substrate · TG/sacral DRG region SUV ratio quantification (caveat: tracer label reactivating ganglion only)
- **sample + threshold**: n ≥ 10 (PET expense limit); post-Arm S TG SUV vs untreated control SUV log-ratio < log(0.5) null reject
- **timeline**: 12-month post-Arm S
- **decision**: **full reject** — shedding-to-reservoir mapping (M10 §7.2) FALSIFIED · non-biopsy verification 자체 falsified
- **falsifies**: M10 §7.2 · §5.3 · M4 §5

### 3.2 F-II-7 post-mortem TG ImmunoFISH qPCR ≥10³

- **목표**: "ddPCR + LAT-miRNA AND-PASS ⇒ N_lat ≤ 1" (M10 §5 + §7 합산)
- **trigger**: accidental-death cadaver TG biopsy (consented patient PASSED M10 §5.2 4/4 pre-death) shows ImmunoFISH+ neuron × LCM ddPCR ≥ 10³ total
- **protocol**: post-mortem TG harvest <24h · OCT freeze · ImmunoFISH (LAT probe + DNA-FISH) · LCM individual LAT+ neuron · ddPCR (Cuddy 2020)
- **sample + threshold**: n ≥ 3 cadaver (cumulative over 5-year), ≥10³ count = >3-log gap, mechanistic violation (no statistical test)
- **timeline**: open — accidental death cohort, 5-year
- **decision**: **full reject** — peripheral surrogate strategy fundamental flaw · protocol redesign with direct ganglion verification mandatory
- **falsifies**: M10 §5 framework · §7 mapping · M2 §7.1 reservoir reduction goal verifiability

### 3.3 F-II-8 KDM4 activator chemistry failure

- **목표**: "M6 3-axis LRA + KDM4 act → P_Ac 0.03→0.6, P_Me3 0.85→0.15" (M6 §3.4 + M10 §3.2)
- **trigger**: KDM4 activator medicinal chemistry program (V4 §6.2 #12) 가 hit-to-lead 후 H3K9me3 demethylation > 3-fold (in vitro chromatin) 5-year window 안에 실패
- **protocol**: recombinant KDM4 assay + chromatin H3K9me3 ChIP-seq + HSV-infected neuron LAT locus H3K9me3 ChIP-qPCR
- **threshold**: H3K9me3 demethylation < 3-fold (vs DMSO) in lead candidate after ≥3 chemotype, 5-year effort
- **timeline**: 5-year (estimate 2027-2032)
- **decision**: **program-decisive demote** — Arm S 자체가 wait-on-next-gen-LRA → Arm F + functional cure path only viable until KDM4 act 발견
- **falsifies**: M6 §3.4 · M10 §3.2 · §11 cycle math

---

## 4. Tier III — Theoretical / systemic falsifier (program-decisive) — 3 falsifier

### 4.1 F-III-9 M11 sensitivity sweep u_crit max/min > 10

- **목표**: "M6/M7 dosing 가 u_crit ±factor 5 sensitivity 내에서 stable" (M11 deliverable, M3 §7.3 rate fit assumption)
- **trigger**: M11 sweep (k_u→m × {0.1, 0.5, 1, 2, 10} on M3/M4/M6/M7 spine) 결과 u_crit (M4 §5.5.2) ratio max/min > 10 (≥1-log)
- **protocol**: pool ubu-1 scipy.solve_ivp ODE recompute · 5 rate × 5 multiplier = 25 condition, deterministic
- **threshold**: u_crit ratio (max sweep / min sweep) > 10
- **timeline**: M11 deliverable 1-2 week
- **decision**: **program-decisive partial demote** — sensitive parameter 만 wet-lab fit (V4 §6 #2 first-principles polymer-chromatin master eq fit) — quantitative dosing claim temporary halt, qualitative claim 유지
- **falsifies**: M4 §5.5 · M6 §3.4 · M7 §4 · M10 §11 spine math

### 4.2 F-III-10 AAV-rh.10 NHP TG transduction < 20%

- **목표**: "AAV-rh.10 TG transduction 30-50% (Hordeaux mouse) 가 NHP 에서 holds within factor 2" (M5 §5 + M10 §3.2)
- **trigger**: NHP toxicology + biodistribution (V4 §10.3) 에서 AAV-rh.10 IV (~1×10¹⁴ vg/kg) 후 TG transduction < 20% (GFP+ / total NeuN+ via IHC)
- **protocol**: NHP n ≥ 3-6 per dose, IV AAV-rh.10-GFP · 4-week sacrifice · TG IHC · 2-3 dose level
- **threshold**: mean transduction < 20% with 95% CI 상한 < 40%
- **timeline**: GLP tox 6-month + IND-enabling 12-month (estimate 2027-2029)
- **decision**: **full reject Arm S and Arm F as designed** — alternative serotype (Anc80, AAV9-PHP.eB) preclinical pivot mandatory
- **falsifies**: M5 §5 · §6 · M10 §11 · M7 §4 (Arm F delivery 도)

### 4.3 F-III-11 BNT163 / mRNA-1608 Phase 1 CTL boost < 5×

- **목표**: "M9 pentavalent mRNA → CTL pool 30-50× (E_vaccine ≈ 21×)" (M9 §9.4 + M10 §1.1)
- **trigger**: BNT163 (NCT05432583) 또는 mRNA-1608 Phase 1 readout HSV-specific CD8+ IFN-γ ELISpot < 5-fold post-prime/boost vs pre
- **protocol**: sponsor-reported ELISpot — PBMC IFN-γ HSV peptide pool stim pre/post · 5-fold lower-bound vs 21× assumption
- **threshold**: geomean fold change < 5 with upper 95% CI < 7
- **timeline**: BNT163 2025-26 · mRNA-1608 2026-27
- **decision**: **partial demote** — Arm S cycle budget fundamentally beyond 10-15 → Arm F 우선, M9 다음 세대 design 후 재개
- **falsifies**: M9 §9.4 · M10 §11.3-11.4 · M8 §3.2

---

## 5. Decision-rule matrix — compiled summary

### 5.1 단일-표 요약

| ID | Tier | trigger | sample | threshold | timeline | decision |
|---|---|---|---|---|---|---|
| F-I-1 | I | ≥6/12 swab POS post-w26 | n≥6 | p<0.001 binomial | week 52 | partial demote |
| F-I-2 | I | ≥3/4 quarter LAT-miRNA POS | n≥6 | 95% CI N_lat ≥10³ | week 78 | full reject |
| F-I-3 | I | lesion+swab+LAT triple | N=1 | event | 24-month | per-patient reject; cohort ≥30% = full |
| F-I-4 | I | median cycle > 25 | n≥6 | Wilcoxon vs median=12 | open (≤30 cap) | partial demote |
| F-I-5 | I | shedding rebound ≥2× nadir | n≥6 | mixed-eff p<0.05 | week 130 | partial demote |
| F-II-6 | II | PET ≥50% residual TG | n≥10 | log-ratio < log(0.5) | 12mo post-Arm S | full reject — mapping refuted |
| F-II-7 | II | post-mortem TG ≥10³ | n≥3 cadaver | mechanistic violation | 5-year | full reject — surrogate flaw |
| F-II-8 | II | KDM4 act <3-fold demeth | drug discovery | 5y + ≥3 chemotype | 5-year | program-decisive demote |
| F-III-9 | III | M11 u_crit max/min > 10 | 25 sweep | deterministic | 1-2 week | program-decisive demote |
| F-III-10 | III | NHP TG transduction <20% | n≥3 NHP | 95% CI <40% | 2027-29 | full reject — serotype pivot |
| F-III-11 | III | BNT163/mRNA-1608 CTL <5× | trial Phase 1 | upper CI <7 | 2025-27 | partial demote |

### 5.2 OR-gate logic

```
H_central FALSIFIED  ⇐  (any Tier I FIRE with §7 artifact filter PASS)
                     ∨  (any Tier II FIRE — population-decisive)
                     ∨  (any Tier III FIRE — program-decisive)
                     AND  §7 consistency check (artifact 배제)
```

단일 falsifier fire 만으로 reject 충분 (Popper asymmetry) — §7 artifact filter PASS 후. **AND-gate 가 아닌 OR-gate** 가 falsifier 본질 (validator AND · falsifier OR · Popper invariant).

### 5.3 ASCII decision tree — Arm S falsifier check at trial milestone

```
Arm S enrollment week 0
   │
   ▼
[week 12-24] M8/M6/M5 intervention
   │
   ▼
[week 26] cycle complete → entry to monitoring
   │
   ▼
[week 26-52] monthly swab ddPCR + quarterly LAT-miRNA
   │  ┌──────────────────────────────────────────────┐
   │  │ check F-I-1: ≥6/12 swab POS post-w26?         │
   │  │   YES → §7 artifact filter check               │
   │  │           ├─PASS─→ F-I-1 FIRE — partial demote │
   │  │           │         Arm S +cycle or Arm F      │
   │  │           └─FAIL─→ technical artifact, cont    │
   │  │   NO  → next check                             │
   │  └──────────────────────────────────────────────┘
   │
   ▼
[week 78] quarterly LAT-miRNA + recurrence diary review
   │  ┌──────────────────────────────────────────────┐
   │  │ check F-I-2: ≥3/4 quarter LAT-miRNA POS?      │
   │  │   YES → §7 check → F-I-2 FIRE — full reject   │
   │  │ check F-I-3: lesion + swab+ + LAT+ event?     │
   │  │   YES → per-patient reject                    │
   │  │ check F-I-5: shedding rebound ≥2× nadir?      │
   │  │   YES → §7 check → partial demote             │
   │  └──────────────────────────────────────────────┘
   │
   ▼
[week 130] 24-month follow-up complete
   │  ┌──────────────────────────────────────────────┐
   │  │ check F-I-4: median cycle count > 25?         │
   │  │   YES → partial demote — Arm F 권고            │
   │  │ check F-II-6: PET ≥50% residual? (if avail)   │
   │  │   YES → mapping refuted — full reject         │
   │  └──────────────────────────────────────────────┘
   │
   ▼
[external, parallel windows]
   ┌────────────────────────────────────────────────┐
   │ F-II-8 KDM4 act chem fail (5-year)             │
   │ F-III-9 M11 sweep u_crit >10×  (1-2 week)      │
   │ F-III-10 NHP AAV transduction <20% (2027-29)   │
   │ F-III-11 BNT163/mRNA-1608 CTL <5× (2025-27)    │
   │ F-II-7 post-mortem TG (open, 5-year)           │
   └────────────────────────────────────────────────┘
   │
   ▼
All falsifier NOT-FIRE over 24-month + 5-year window
   ⇒ "Successfully not-falsified" (Popper corroborated)
   ⇒ NOT "proven sterilizing cure"
   ⇒ §9 honest assessment
```

---

## 6. Stop rule vs falsifier — distinction

### 6.1 두 축 의미 차이

| 축 | 정의 | 대상 | 트리거 효과 |
|---|---|---|---|
| **Stop rule** (M10 §8.3) | DSMB safety/futility → trial 중단 정당화 | individual patient + cohort | trial halt / amendment |
| **Falsifier** (M12) | hypothesis H_central epistemic reject | hypothesis as theoretical claim | claim revision (Arm S viability) |

### 6.2 overlap

| 사건 | stop rule | falsifier | comment |
|---|---|---|---|
| Grade 4 irAE ≥3 patient | YES | NO | safety only |
| HSE 사례 ≥1 | YES | NO | safety |
| AAV hepatotox ≥1 | YES | NO | safety |
| therapeutic failure 12mo <30% | YES | YES (F-I-1/F-I-2 fire 시) | overlap |
| ddPCR 6/12 POS in n≥6 | NO | YES (F-I-1) | falsifier exclusive |
| BNT163 CTL <5× external | NO | YES (F-III-11) | falsifier exclusive |
| post-mortem TG ≥10³ | NO | YES (F-II-7) | falsifier exclusive |

### 6.3 함의

- Stop rule 만으로 H_central achievability 판단 불가 — safety OK 여도 hypothesis falsified 가능.
- Falsifier 만으로 trial halt 정당화 불가 — Tier II/III evidence 는 trial 진행 중 도래, protocol amendment 정도 적절.
- **두 축은 orthogonal 이 아니지만 (overlap 가능) 독립 monitor**.

---

## 7. Exception clauses — artifact filter

### 7.1 Transient single-event 배제

| 패턴 | 처리 |
|---|---|
| 1/12 monthly swab POS | F-I-1 미발화 (임계 6/12) |
| 1/4 quarterly LAT-miRNA at LOD | F-I-2 미발화 (임계 3/4 ≥1 cp/mL) |
| clinical lesion 의심 (Grade 1, no swab+, no LAT+) | F-I-3 미발화 (triple-positive 필요) |
| single cycle count > 25 in n=1 | F-I-4 미발화 (cohort median 필요) |

### 7.2 기술적 artifact 배제

| artifact source | 검출 | fire 차단 조건 |
|---|---|---|
| ddPCR contamination (carryover) | NTC well POS + sample POS 동시 | NTC POS batch sample invalidate |
| LAT-miRNA cross-reactive (host miR-138 등) | sequence verification (Sanger) on POS | host miRNA mis-amp 시 invalidate |
| swab sampling error (low cell count) | RNase P internal control < threshold | low-quality sample invalidate |
| PET tracer non-specificity (¹⁸F-FIAU host TK) | uninfected control TG PET signal | host signal subtract |
| post-mortem autolysis (>24h) | RIN < 6 or DNA quality QC | sample invalidate |

### 7.3 Consistency 요건

**falsifier fire 정당화** = ≥1 조건 충족:
- (a) 동일 falsifier ≥3 cohort patient reproduce, OR
- (b) ≥2 독립 endpoint 동시 violated (예: F-I-1 + F-I-2), OR
- (c) Tier II 또는 Tier III (본질적으로 population/program-decisive)

→ single event + single endpoint fire 는 §7.2 filter 후에도 추가 evidence 대기.

---

## 8. Cross-link to V4 §10 — 9 wet-lab essential validator vs falsifier marking

### 8.1 V4 §10 9 wet-lab essential 분류

| V4 §10 항목 | M12 ID | validator/falsifier |
|---|---|---|
| BNT163 readout (V4 §10.1) | F-III-11 | **falsifier** (CTL <5× decisive demote) |
| mRNA-1608 readout (V4 §10.1) | F-III-11 (joint) | **falsifier** |
| Excision Bio HSV CRISPR (V4 §10.1) | — | **validator** (necessary path support) |
| GNE-3511 DLK repurpose (V4 §10.1) | — | **validator** for Arm F |
| post-mortem TG biopsy (V4 §10.2) | F-II-7 | **falsifier** |
| radiolabeled pembro PET (V4 §10.2) | — (M8 §4.2 validator) | **validator** |
| post-mortem TG ImmunoFISH (V4 §10.2) | F-II-7 (joint) | **falsifier** |
| NHP toxicology safety (V4 §10.3) | F-III-10 (transduction 측) | **falsifier** + validator (safety dual-role) |
| Arm F long-term AAV-Cas9 immunity (V4 §10.3) | — | **validator** for Arm F |
| KDM4 activator (V4 §10.4) | F-II-8 | **falsifier** (5-year window) |
| HCF-1 PPI inhibitor (V4 §10.4) | — | **validator** for Arm F |

### 8.2 합산

```
V4 §10 9 wet-lab essential 중:
  • falsifier role (decisive program-level reject 가능) ── 4 항목
    BNT163 + mRNA-1608 (F-III-11 joint), post-mortem TG ImmunoFISH (F-II-7),
    NHP tox transduction (F-III-10), KDM4 activator (F-II-8)
  • validator-only ──────────────────────────────────── 5 항목
    Excision Bio, GNE-3511, radiolabeled pembro PET, HCF-1 PPI, AAV 80y
```

### 8.3 함의

V4 §10 의 9 wet-lab essential 중 **4 항목 (≈45%) 이 falsifier 자격**. V4 ledger 의 "9 wet-lab essential" 중 다수가 단순 validator 가 아니라 **decisive falsifier 잠재력**.

---

## 9. Honest assessment — "Successfully not-falsified" framing

### 9.1 모든 falsifier non-fire 시 정확한 epistemic 입장

본 M12 11 falsifier 가 24-month Phase 2 + 5-year extended window 동안 non-fire → H_central status:

```
H_central status = "Successfully not-falsified" (Popper corroborated)
                 ≠ "proven sterilizing cure"
                 = positive evidence for H_central, with caveat:
                   "future observation 이 falsifier criteria 충족 시 reject 가능"
```

### 9.2 Popper 비대칭성 적용

- **Verification 한계**: finite observation 이 universal claim ("Arm S → sterilizing cure for all eligible patient") prove 못함.
- **Falsification 우월**: 단일 decisive observation 이 universal claim reject.
- **M12 의미**: falsifier non-fire 시점에 H_central 는 "*scientific* (falsifiable + tested + 미검증 reject)" status — Popper 의미 corroborated theory.

### 9.3 정직성 invariant (V4 §12 정합)

```
M12 verdict (모든 11 falsifier non-fire 시):
  ✅ H_central scientific (Popper criterion PASS)
  ✅ H_central corroborated (24mo + 5y window observation)
  ❌ H_central proved (no observation can prove universal claim)
  ❌ "sterilizing cure unconditional promise"

  → 가용한 강한 표현: "sterilizing cure achievable via Arm S in eligible
    patient cohort, corroborated over 24-month follow-up, with all 11
    pre-declared falsifier non-fire under §7 artifact filter."
```

### 9.4 wet-lab caveat 위치

V4 §12 "9 wet-lab essential" 정직성 invariant 와 M12 의 4 falsifier-marked 항목 fire-window 모두 PASS 했을 때 §9.3 verdict 정당:
- **M12 catalogue 는 V4 §12 정직성 invariant strengthen** — wet-lab essential majority 가 falsifier 역할.
- **"sterilizing cure unconditional promise" 는 정의상 불가능** — future observation 이 falsifier 가능 (Popper invariant).

---

## 10. Cross-reference index to M10 §5.5

### 10.1 M10 §5.5 cross-link summary (≤100 line scope)

M10 §5.5 (현재 부재 — 본 M12 land 시 별도 commit) summary 권장 내용:

- §5.5.1 Popper falsifiability — M10 §5 success endpoint 만으로 부족한 이유 (1 paragraph)
- §5.5.2 11 falsifier 1-line table (Tier I 5 + Tier II 3 + Tier III 3)
- §5.5.3 OR-gate logic — single fire (§7 PASS) = H_central reject
- §5.5.4 stop rule vs falsifier 1-paragraph distinction (M10 §8.3 cross-link)
- §5.5.5 honest assessment — "successfully not-falsified ≠ proved"
- §5.5.6 detail forward → `HERPES/M12_falsifier_protocol.md`

### 10.2 reverse index — M12 → M*/V4 link map

| M12 falsifier | falsifies M-doc claim | V4 §10 wet-lab essential link |
|---|---|---|
| F-I-1 | M10 §5.2 #1 · §11.3 · M5 §6.6 | — |
| F-I-2 | M10 §5.2 #2 · §7.3 · M2 §7.1 | — |
| F-I-3 | M10 §5.2 #3 · §11 · M7 §5 | — |
| F-I-4 | M10 §11.4 · M5 §6 · M2 §7.2 | — |
| F-I-5 | M10 §5.2 traj · M4 §5.5 | — |
| F-II-6 | M10 §7.2 · §5.3 · M4 §5 | — |
| F-II-7 | M10 §5 · §7 · M2 §7.1 | V4 §10.2 ✅ |
| F-II-8 | M6 §3.4 · M10 §3.2 · §11 | V4 §10.4 ✅ |
| F-III-9 | M4 §5.5 · M6 §3.4 · M7 §4 · M10 §11 | — (M11 deliverable) |
| F-III-10 | M5 §5 · §6 · M10 §11 · M7 §4 | V4 §10.3 ✅ |
| F-III-11 | M9 §9.4 · M10 §11.3-11.4 · M8 §3.2 | V4 §10.1 ✅ |

### 10.3 Future M-doc impact

- **M11 sensitivity sweep**: F-III-9 trigger source — M11 land 시 즉시 falsifier check.
- **임상 trial readout (2025-2030)**: F-III-11 + F-III-10 trigger window — 외부 evidence stream.
- **medicinal chemistry program (2027-2032)**: F-II-8 trigger window — slow but program-decisive.

---

## 11. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| §0 Popper preamble | 🔵 SUPPORTED-FORMAL | Popper 1934 demarcation criterion logical asymmetry |
| §1 falsifier vs validator | 🟢 + 🔵 | AND-gate vs OR-gate formal 비교 |
| §2 Tier I 5 falsifier | 🟢 SUPPORTED-NUMERICAL | M10 §5 + M2 §7 + M5 §6 threshold 인용 + binomial/Wilcoxon |
| §3 Tier II 3 falsifier | 🟢 + 🟠 (PET PoC) | F-II-7 mechanism violation · F-II-8 program · F-II-6 §7.4 PoC 의존 (🟠) |
| §4 Tier III 3 falsifier | 🟢 + 🟡 (trial readout) | M11 compute · F-III-10 NHP external · F-III-11 trial 의존 (🟡) |
| §5 decision matrix | 🟢 SUPPORTED-NUMERICAL | §2-4 compilation deterministic |
| §6 stop rule vs falsifier | 🔵 SUPPORTED-FORMAL | M10 §8.3 + logical orthogonality |
| §7 artifact filter | 🟢 SUPPORTED-NUMERICAL | ddPCR/LAT-miRNA/PET artifact 검출 protocol |
| §8 V4 §10 cross-link | 🟢 SUPPORTED-NUMERICAL | V4 §10 항목별 dual-mark |
| §9 honest assessment | 🔵 SUPPORTED-FORMAL | Popper invariant 적용 |
| §10 M10 §5.5 cross-link | 🟢 SUPPORTED-NUMERICAL | M10 §5 + M2 + M5 dependency chain |

---

## 12. 핵심 단일-문장 결론

> 본 M12 protocol 은 H_central (M10 Arm S sterilizing cure) Popper falsifiability 를 — 11 pre-declared falsifier (Tier I 5 empirical + Tier II 3 wet-lab + Tier III 3 systemic) × per-falsifier objective threshold (binomial p<0.001 · Wilcoxon · log-ratio · mechanistic violation) × §7 artifact filter (transient 배제, ≥3 cohort or ≥2 endpoint consistency) × OR-gate logic (single fire = H_central reject) 로 정식화 — M10 §5 success-side AND-gate (4-surrogate validator) 와 함께 dual-axis epistemic framework 을 완성한다. 모든 falsifier non-fire 시 H_central 는 "Successfully not-falsified" (Popper corroborated) status 를 얻으나 "proved sterilizing cure" 가 아니다 — V4 §12 정직성 invariant 정합. V4 §10 9 wet-lab essential 중 4 항목 (BNT163/mRNA-1608 · post-mortem TG · NHP AAV · KDM4 activator) 이 falsifier 역할로 dual-mark 되어, wet-lab readout window (2025-2032) 가 H_central program-decisive 시점을 정의한다.

---

## 13. 참고문헌

- Popper KR (1934) *Logik der Forschung* — falsifiability demarcation criterion
- Popper KR (1963) *Conjectures and Refutations* — corroboration vs verification asymmetry
- ICH E9 (1998) *Statistical Principles for Clinical Trials* — pre-specified hypothesis test
- FDA (2019) *Adaptive Designs for Clinical Trials* — pre-declared decision rule
- M10 §5 · §7 · §8.3 · §11 — primary cross-link · M2 §7.1-7.2 baseline · M5 §6 ceiling math
- V4 §10 + §12 — 9 wet-lab essential + honest invariant

---

> end M12 — Popper falsifier protocol for HSV sterilizing cure. 다음 단계 = M10 §5.5 ≤100-line summary land (별도 commit, 본 M12 cross-link target) + V5 cross-tool 2nd-witness round 에 11 falsifier numerical recompute (binomial threshold + Wilcoxon power) 포함.
