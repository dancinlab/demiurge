# X9 — CARDIO+ d2 wall map + cross-domain 시너지

> 목적: 4 sub-domain (NOREFLOW · DAPTPGX · ISR · LPA) 이 실증적으로 부딪힌 **wall** 을 지도화하고, d2 거버넌스에 따라 wall 마다 **구체적 돌파 path 2-3개** 를 명명한다 — 핵심 가치 = 단일 PR / 단일 stratification 이 여러 도메인을 동시에 unlock 하는 cross-domain leverage.

> 입력 = `X1_unified_claims.md` §7 (cross-domain wall preview) + 4 sub-domain `.md`/`.log.md` 실증 wall grep + `CARDIO+.md`/`.log.md` d2 meta governance.
> g5 준수: tier/grade 는 X1 + sub-V4 ledger 에 기록된 verdict VERBATIM (LLM self-judge 0건). d2 준수: "현재 방법으로 불가능" 식 표현 0회 — wall 마다 시도할 path 명명.

---

## §0. 방법론 + wall 분류축

각 wall 은 7-verb pipeline 의 어느 단계에서 발생했는지로 분류한다 (demiurge V :: spec/structure/design/analyze/synthesize/verify/handoff).

| 단계 약칭 | 의미 | CARDIO+ 매핑 |
|---|---|---|
| **sim** | analyze ⟲ | 시뮬레이션 / 수치 재계산 (PK ODE · MC · ICER · IVW) — 🟢 push |
| **proof** | verify (formal) | closed-form / atlas register / `hexa verify --expr` — 🔵 push |
| **synth** | synthesize | 후보 통합 ranking · 결정맵 · modality 공간 정리 |
| **gate** | (governance) | PR merge · 규제 승인 · NHIS 급여 · IRB 등 외부 gate |
| **handoff** | handoff | 한국 임상 적용 · trial portfolio · DOCTOR feed |

wall 의 **실증 근거** = "왜 wall 인가" 를 sub-domain log 의 실측/RCT null/CLI verdict 로 명시. **돌파 path** 는 sub-V1/V4 에 이미 명시된 d2 path 를 carry + cross-domain leverage 표시.

---

## §1. NOREFLOW wall 표

| # | wall | 단계 | 실증 근거 (왜 wall 인가) | 돌파 path 2-3개 (d2) | 의존 |
|---|---|---|---|---|---|
| **N1** | mPTP IV bolus 가설 falsify | sim | CIRCUS · CYCLE · EMBRACE · MITOCARE 4 large RCT (n>2,000) 연속 neutral — CsA 2.5mg/kg IV 1.5h infusion 으로 재관류 첫 5분 lethal window 미도달 (arm-to-heart lag IV 30-120s) | (A) **IC + reperfusion-synced delivery** — M12.2 IRI ODE 실측 CIRCUS 93.5% → IC-sync 56.9% cell death (Δ=36.6pp) ✅ 정량 정당화 완료 · (B) **CypD-selective NIM811/debio-025** — CsA calcineurin off-target 제거 · (C) **다축 cell-death 차단** (STING-GPX4 ferroptosis + CypD Ser191 phospho, Nature 2025) — 단일 mPTP 표적 한계 우회 | 데이터 (delivery device IIT) · 규제 (MFDS pre-IND) |
| **N2** | bio/clinical 🔵 SUPPORTED-FORMAL 미가능 | proof | `hexa verify` atlas = number-theory only → Hill · exp_decay · pk_2comp · IMR=Pd×Tmn 직접 🔵 미가능. V4 ledger 🔵 0 filled / **11 placeholder** (PR #658 OPEN, mergedAt=null) | (A) **atlas 확장 PR #658 merge** — merge 시 🔵 0→11 즉시 fill (도메인 15.3% 커버리지 1-gate 도약) · (B) **`register --from-verify` chain** V3.1/V3.2/V3.4 → 🟢→🔵 추가 (potential 15 🔵) · (C) **⚪ honest fence** — 본질적 산식 불가 영역 정직 인정 | **hexa-lang** (PR #658 / bio-verify-kernel) |
| **N3** | 다기관 CMR consortium 부재 | gate/handoff | CMR infarct size = 유일 validated surrogate (Stone 2016 n=2,632) 이나 한국 ~15-20 기관 산재 · KAMIR-NIH CMR 미포함 → Ph2 PoC n~200-400 power 확보 불가 | (A) **KHIDI/보건복지부 R&D 8-기관 consortium 빌드** (2-3년) · (B) **IMR-guided stratification 으로 enrollment power 향상** (~10 IMR-capable 기관) · (C) **CMR/OCT/FFR imaging 자산 ISR 과 공유** (CX 시너지 — §6.2) | 데이터 (multi-site) · 규제 |
| **N4** | mPTP 직접 약물 한국 미수입 | handoff | NIM811 · debio-025 · TRO40303 한국 미허가/미수입 (M8 §3 import gap) | (A) **NAD+/NMN supplement IRB-light pilot** — SIRT3-CypD K166 deacetylation 축 한국 supplement 가용 · (B) **siRNA delivery 인프라 공유** (LPA cross — §6.3) · (C) **ALDH2*2 sub-group alternative NO donor** (BH4) — 한국 ethnicity-aware fast track | 규제 (supplement vs 의약품 IRB 분리) |
| **N5** | Trial-A Cox 1y MACE under-powered | sim | M12.4 Power n=500 실측: primary endpoint 0.798 🟢 적정이나 Cox 1y MACE 0.157 🟠 · ALDH2*2 sub-group 0.654 🟠 | (A) **secondary exploratory 로 protocol 명시** (정직한 power 분리) · (B) **n 증대 또는 event-driven design** · (C) **ALDH2*2 enrichment 로 effect size 증폭** (3-axis stratification — §5) | 데이터 (n scaling) |

NOREFLOW wall = **5건** (sim 2 · proof 1 · gate/handoff 1 · handoff 1). N1 은 sim 단계에서 d2 돌파 정량 정당성 이미 확보 (36.6pp), N2 만 hexa-lang gate 의존.

---

## §2. DAPTPGX wall 표

| # | wall | 단계 | 실증 근거 (왜 wall 인가) | 돌파 path 2-3개 (d2) | 의존 |
|---|---|---|---|---|---|
| **D1** | 한국인 60% PM/IM 비-최적 + ticag switch 출혈 | synth/handoff | CYP2C19 LoF allele ~40% (글로벌 최고) · IM+PM 합 ~60% · 단순 ticagrelor switch = TICAKOREA bleeding 2.8% vs clopidogrel 1.4% (PLATO 의 2배) → dual jeopardy | (A) **CYP2C19-guided 결정 트리** (M7 3-axis cube · 시간축 4-trigger 압축) · (B) **vicagrel/selatogrel CYP2C19-무관 신약** — CES1 1-step 활성화 PM 60% 1:1 대체 · (C) **HOST-EXAM clopi 단독 chronic** (HR 0.73 · Kim 2020 Lancet) 한국 evidence-leading | 데이터 (KAMIR) · 규제 (vicagrel KFDA) |
| **D2** | ICER sign/magnitude reconciliation 미완 | sim | V3 naïve model -3,221 M/QALY vs M8 cited +34 (sign mismatch) → V5 P1-P4 patch -503 (6.4× 개선, sign 미반전) → V6 P5 double-count fix closed-form +5,500 (sign 반전 ✅ but magnitude ~160× off vs +34) · sim exec pool-route 차단으로 defer | (A) **V7 Markov lifetime + discount + PFT rescue patch** — 1y simple → lifetime 정밀화 · (B) **pool-route 복구 후 v6_recompute.hexa 실행** (PR #700 merged 으로 unblock) · (C) **🟠 honest DEFERRED 유지** — d6 goal-pressure 거짓 🟢 거부 (🔴 FALSIFIED 부여 거부) | **hexa-lang** (pool-route) · 데이터 (NHIS 약가) |
| **D3** | atlas 🔵 SUPPORTED-FORMAL = 0 | proof | V2 honest 0개 🔵 — atlas promoter 0-proposal bug · biostat formula 부재. 4 shard staged + 2 inbox patch (`hexa-lang-stdlib-bio-stats.md` · `hexa-atlas-pgx-kind-extension.md`) upstream | (A) **inbox patch absorb** — HW/binomial/ICER 등 stdlib 확장 후 🔵 4 + 🟢 12 escalation · (B) **PR #665 merge** (LPA V2 agent 등록) → 17+ identity 일제 🟢→🔵 (cross-domain) · (C) **own atlas root** 우회 | **hexa-lang** (atlas promoter / bio-stats patch) |
| **D4** | caller cross-tool head-to-head 부재 | synth | PyPGx · PharmCAT · Aldy · Stargazer 5-tool concordance 미검증 (gap F8) — Stargazer+PyPGx 한국 저자임에도 KOVA head-to-head 0건 | (A) **KOVA VCF 추출 → 4 caller 병렬 → confusion matrix** (M13 acquisition plan) · (B) **한국 cohort 첫 검증** — KOVA/KORV1K 직접 적용 (한국 unique opportunity) · (C) **hexa-lang stdlib caller wrapper** 등록 | 데이터 (KOVA VCF 접근) |
| **D5** | AI/ML PGx AUC 0.80 plateau + RCT 0건 | synth | M17: AUC ceiling 0.80 5년 정체 · 통합 후에도 ~75% PRU 분산 미설명 · RCT 검증 0건 (evidence gap) | (A) **5 NEW axes 통합 hub** (sex · biomarker · DT-678 · Lp-PLA2 · PRS) — M7 cube refinement layer (대체 아님) · (B) **KAMIR ~30K cohort leverage** RCT design · (C) **PRS 6th axis 한국 단기 frontier** (KoGES + KOVA 보유 · 2026-28 adoption) | 데이터 (KAMIR RCT) |

DAPTPGX wall = **5건** (synth 3 · sim 1 · proof 1). D2/D3 가 hexa-lang 인프라 의존. PON1 + darapladib 는 🔴 FALSIFIED 으로 wall 아닌 closed (audit trail 보존).

---

## §3. ISR wall 표

| # | wall | 단계 | 실증 근거 (왜 wall 인가) | 돌파 path 2-3개 (d2) | 의존 |
|---|---|---|---|---|---|
| **I1** | 2nd-gen DES 잔여 5-10% ISR + mTOR 단일 plateau | synth | 4종 DES (sirolimus·everolimus·zotarolimus·biolimus) 모두 FKBP12→mTORC1 단일 경로 → escape · neoatherosclerosis (3-10y) 미해결 · BRS late ST signal | (A) **비-mTOR 신규 표적** ROCK fasudil · PCSK9 · GLP-1R (M3 top 3 · NA+safety+maturity 우수) · (B) **biolimus+fasudil dual-DCB** (M8 #1 rank 80.5) — NA+EC 보존 직접 hit · (C) **Mg-BRS 차세대** Freesolve (BIOMAG-I 24m TLF 3.5% · vasomotion 회복) | 데이터 (IIT) · 규제 (MFDS) |
| **I2** | bio-physical 🔵/🟢 closed-form block | proof/sim | V2: `hexa verify --expr` calc kernel 에 bio fn 부재 + float-arg 거부 (int-only) → 7 identity 모두 🟠/⚪. V3: bio.* kernel 부재 + ubu-1 PK/PD ODE 30d 99.7% vs lit 80-90% → 3 ⚪. V4: 🔵 0/28 · 🟢 0/10 (kernel block) | (A) **bio-verify-kernel-extension PR** — `verify_cli.hexa::_recompute` extend (~385 LOC · 4-5 stacked PR) → 7-28 🔵 + 3-10 🟢 (cross-domain 50-90 🔵) · (B) **V3 numerical 우회** NUM-01 drug-polymer DFT (pool ubu-1 free · RTSC QE 7.5 전례) · (C) **atlas append-witness --kind F** → 🟡 citation-locked 직행 | **hexa-lang** (bio-verify-kernel / `--expr` float ABI) |
| **I3** | DCB/dual-DCB FTO red-zone | gate | patent #17 ROCK-CV Markush (Asahi/UTokyo) · #5 dual-DCB (Concept Medical) · #3/#4 sirolimus carrier = FTO 🔴 red-zone 3건 | (A) **fasudil-DCB FIH IIT-1** (n=60 · 15-25억 KRW · KCSC 6-8 sites) — ROCK 국소전달 white space 선점 · (B) **한·일 Asian DCB consortium** (regulatory cross MFDS+PMDA) · (C) **GRAND-DES embedded sub-study** 우회 | 규제 (FTO 회피 설계) · 데이터 |
| **I4** | 한국 ISR IIT wet-lab 진입 미완 | handoff | M8 정성 closure 100% but 정량 = wet-lab IIT 진입 시 100% · AGENT MFDS Asia-first window 미활용 | (A) **IIT-1 fasudil-DCB + IIT-3 PCSK9/GLP-1R registry-RCT** 동급 1순위 · (B) **AGENT 한국 post-approval registry** (IIT-1.5) · (C) **Freesolve Korean sites** (IIT-4) | 규제 (MFDS pre-IND) · 데이터 |

ISR wall = **4건** (synth 1 · proof/sim 1 · gate 1 · handoff 1). I2 가 hexa-lang bio-verify-kernel 의존 — PR #707 phase 1 으로 3/7 identity (exp_release · ldl_pct · beer_lambert) 이미 🟠→🟢 해소, phase 2 PR 으로 잔여 4 (hill · cheng_prusoff · higuchi · fick) 해소 예정.

---

## §4. LPA wall 표

| # | wall | 단계 | 실증 근거 (왜 wall 인가) | 돌파 path 2-3개 (d2) | 의존 |
|---|---|---|---|---|---|
| **L1** | 30% 잔여 위험 + 스타틴 무효 + apheresis 한정 | synth | Lp(a) 유전 결정성 90% → 스타틴/ezetimibe 무효 (오히려 +5-10%) · PCSK9i -25%만 · apheresis 한국 시설 부재 + 보험 미적용 | (A) **siRNA/ASO 침묵화** pelacarsen(HORIZON) · olpasiran(OCEAN(a)) · lepodisiran · zerlasiran (-80~98%) · (B) **muvalaplin 경구** (KRAKEN -85.8% intact · 3-axis lattice pre-secretory 유일점) · (C) **VERVE-301 base editor** single-dose lifetime (Lilly $1.3B · 한국 2033+) | 데이터 (Ph3 readout) |
| **L2** | NHIS WTP 통과율 0% (387-645× 약가 격차) | sim/gate | V3c 10K PSA (seed=42): broad ICER ₩27.4B/QALY · narrow ₩13.3B · WTP ₩25M/₩30M 모두 **0% pass** · break-even $17.8-29.7/yr vs 글로벌 $11.5K · tornado: 약가 sensitivity 최약 (협상만으로 불충분) | (A) **RSA (outcome-based reimbursement)** ≥85% RRR 미달 시 ≥50% refund · (B) **narrow staging + bridge therapy + 한국 sub-group RRR** 3-축 동시 (V3c 5-path) · (C) **K-LpA-OUTCOMES IIT** (n=3,000 · 2032 readout) = HIRA 협상 leverage 도구 | 규제 (HIRA 약가) · 데이터 |
| **L3** | 🔵 SUPPORTED-FORMAL 거의 unreachable by design | proof | V2 0/8 (atlas 16,062 nodes 中 biostat formula 0개) → PR #709/#736 merge 후 🟢 ceiling 정정 (float-numerical fn ceiling = 🟢, not 🔵 — RFC 046 정수 closed-form 요구). V4: 🔵 1 (sigma sanity) · 🟢 28 (이론 천장 ~90%) | (A) **🟢 ceiling 정정 = honest reframe** (V1 "🔵 target 8" 은 misframing) · (B) **KIV-2 정수 copy 분포 + HORIZON Schoenfeld 정수 events** = LPA 유일 🔵 잠재 후보 · (C) **3-layer wall 모두 해소** L1 verify_cli(#709) · L2 atlas_cli(#736) · L3 pool(#700) | **hexa-lang** (해소 완료 — PR #709/#736/#700 MERGED) |
| **L4** | GalNAc-siRNA 자유도구 IP wall | proof | R3 §5: GalNAc-siRNA in-silico 종합 free tool 부재 = 🔴 FALSIFIED (Alnylam/Arrowhead 사내 IP · closed negative) | (A) **siDirect 2.0 + RNAxs + DSIR free 5종 조합** (부분 우회) · (B) **siRNA Tm 계산 hexa-lang stdlib 등록** (`lpa-sirna-tm-calc` inbox) · (C) **KOVA/KRGDB 한국 데이터 + 학계 협력** in-house pipeline | 데이터 · 규제 (IP) |

LPA wall = **4건** (synth 1 · sim/gate 1 · proof 2). L3 은 PR #709/#736/#700 merge 로 **이미 해소** (🟢 28 = 이론 천장 ~90% 달성). L2 (NHIS) 가 LPA 의 진짜 wall — 약물 효능이 아닌 약가-적응증 경제 gate.

---

## §5. cross-domain 시너지 — ALDH2*2 × CYP2C19 LoF × Lp(a) 3-axis (핵심)

### 5.1 한국인 PCI layered care 3-axis

한국인 ethnicity 가 만드는 3개 독립 위험축을 단일 stratification 으로 묶으면 **N · D · L 도메인 wall 을 동시에 낮춘다**.

```
                       ALDH2*2 (East Asian 40%, NOREFLOW M9§5)
                              │  → no-reflow / MVO 위험 + nicorandil null 정당화
                              ▼
한국 PCI 환자  ──── CYP2C19 LoF (DAPTPGX M1, IM+PM 60%)  ─── KIV-2 high copy / Lp(a) high (LPA C20/M6)
   │                       │  → HTPR 50-60% (Jeong 2014)         │  → 잔여 위험 30% (LPA M3)
   │                       │                                      │
   ├─ N1/N4 wall            ├─ D1 wall                            ├─ L1 wall
   │  (mPTP delivery+import) │  (clopidogrel 비-최적+출혈)         │  (siRNA 미허가+NHIS)
   │                       │                                      │
   └────────────────── 단일 PCI 입원 채혈 1회 + PCR panel ──────────────────┘
                              │  (NHIS 기존 급여 안에서 배포 가능)
                  ┌───────────┴───────────┐
                  │ ISR 5-10% 추가 위험 (I1, mTOR plateau)
                  ▼
       4-trial portfolio (X5): A NICORADENO-MVO · B DAPT-PGx-K · C ISR-non-mTOR · D LPA-siRNA-K
```

### 5.2 어느 wall 들을 동시에 낮추나

| stratification 1축 추가 | 동시 낮추는 wall | leverage 근거 |
|---|---|---|
| **ALDH2*2 enrichment** | **N5** (Trial-A Cox under-power 0.654→증폭) + **N4** (alternative NO donor sub-group) | effect size 증폭으로 Cox 1y power 회복 + ethnicity-aware fast track |
| **CYP2C19 LoF panel** | **D1** (60% 비-최적 결정 트리) + **D4** (KOVA caller 검증 cohort) | 동일 PCR panel 이 결정맵 + caller head-to-head cohort 양쪽 공급 |
| **Lp(a)/KIV-2 측정** | **L1** (잔여 위험 stratify) + **L2** (narrow staging enrollment) + **L3 boost** (KIV-2 정수 copy → 🔵 후보) | 1회 측정이 risk stratify + IIT enrollment + 🔵 잠재 atom 동시 공급 |

→ **단일 입원 채혈 1회 + 1 PCR/측정 panel 이 N4·N5·D1·D4·L1·L2 6개 wall 을 동시에 낮춘다.** 기존 NHIS 급여 안에서 배포 가능 (CYP2C19 PCR ₩50,000 NHIS 급여 + Lp(a) routine + KSoLA 2026 ≥50 cutoff). 글로벌 미시도 differentiator = **KIV-2 copy stratified efficacy primary** (LPA M9) + **ALDH2*2 enrichment** (NOREFLOW M12.4).

---

## §6. cross-domain 시너지 — 공통 인프라 leverage

### 6.1 IC delivery PK (NOREFLOW M4) ↔ drug-eluting balloon (ISR M5) — 카테터 국소전달 공통 인프라

```
NOREFLOW M4 (IC bolus PK)          ISR M5 (DCB)
   Cmax ratio 30-100× (short-t1/2)    paclitaxel/sirolimus 국소 코팅
   arm-to-heart lag ~0-3s             Mehran pattern 별 효과
   drug-eluting catheter/guidewire    drug-eluting balloon carrier
            │                              │
            └──────── 공통 = 카테터 기반 국소 약물전달 platform ───────┘
                              ▼
          단일 한국 카테터 국소전달 IIT 인프라 (8-기관 cath lab consortium)
          → N1 (IC-sync mPTP delivery) + I3 (fasudil-DCB FIH) 동시 가능
```

| 공통 자산 | NOREFLOW 활용 | ISR 활용 | 동시 낮추는 wall |
|---|---|---|---|
| drug-eluting catheter/guidewire | mPTP IC-sync bolus (N1 path A) | — | N1 |
| DCB carrier 기술 (iopromide·BTHC·sugar microreservoir) | IC vasodilator 코팅 후보 | fasudil-DCB (I3 path A) | N1 + I3 |
| 8-기관 cath lab consortium | NICORADENO-MVO (Trial-A) | fasudil-DCB IIT-1 | N3 + I4 |
| CMR/OCT/FFR imaging (CX02 자산) | infarct size surrogate (N3) | NA OCT 평가 (I1) | N3 + I4 |

→ **단일 한국 다기관 cath lab + imaging consortium** 이 N1·N3·I3·I4 4개 wall 을 동시에 낮춘다 (X1 §3 CX08 "CMR/OCT/FFR imaging 자산 공유").

### 6.2 siRNA delivery (LPA) ↔ mPTP/SIRT3 NAD+ (NOREFLOW) supplement 공통 경로

```
LPA M4 (siRNA/GalNAc delivery)      NOREFLOW M2§6 (SIRT3-CypD NAD+ 축)
   RISC catalytic · GalNAc-ASGPR      NAD+/NMN booster supplement
   간 표적 침묵화                       SIRT3 K166 deacetylation
            │                              │
            └──── 공통 = 한국 supplement IRB-light pilot 경로 ────┘
                              ▼
          IRB-light pilot 프레임 공유 (supplement vs 의약품 분리 IRB)
          → N4 (mPTP 약물 import 우회) + L4 (GalNAc free-tool gap 학계 협력)
```

| 공통 경로 | LPA 활용 | NOREFLOW 활용 | 동시 낮추는 wall |
|---|---|---|---|
| supplement IRB-light pilot 프레임 | (siRNA = 의약품 trial) | NAD+/NMN pilot (N4 path A) | N4 |
| 간/세포 표적 delivery in-silico | GalNAc-siRNA design (L4) | mitochondrial targeting | L4 + N4 |
| KOVA/KRGDB 한국 유전 데이터 | KIV-2 stratification (L1) | ALDH2*2 genotyping (N4) | L1 + N4 + D4 |

→ KOVA/KRGDB 한국 WGS 데이터 1개 자산이 LPA KIV-2 + NOREFLOW ALDH2*2 + DAPTPGX CYP2C19 caller 3 도메인 genotyping 을 동시에 공급 (§5.2 와 합류).

### 6.3 단일 hexa-lang PR — 4-domain 동시 unlock (bio-verify-kernel extension)

가장 강력한 cross-domain leverage. 4 도메인이 동일한 wall (atlas/verify 에 biostat·bio-physical kernel 부재) 에 부딪혔고, **단일 hexa-lang PR 이 4 도메인을 동시에 🟢/🔵 escalate** 한다.

```
                   hexa-lang bio-verify-kernel-extension PR (~400-600 LOC · 4-5 stacked)
                              │
        ┌──────────────┬──────┴───────┬───────────────┐
        ▼              ▼              ▼               ▼
   NOREFLOW N2     DAPTPGX D3      ISR I2          LPA L3
   🔵 0→11         🔵 0→4          🔵 0→28          🟢 14→28
   (PK·Hill·IMR)   (HW·binom·ICER) 🟢 0→10          (IVW·NNT·Schoenfeld)
                                   (DFT·MD·CFD)
        └──────────────┴──────────────┴───────────────┘
                              ▼
        단일 PR cross-domain leverage = 50-90 🔵 + 13-20 🟢 동시 escalation
```

| PR | 해소 wall | 실증 상태 (sub-log verbatim) |
|---|---|---|
| **PR #658** (noreflow-clinical-calc) | N2 | OPEN, mergedAt=null → merge 시 🔵 0→11 (NOREFLOW V4) |
| **PR #700** (pool.hexa compile) | D2 · L2 sim · I2 sim | **MERGED** — pool-route unblock (LPA·ISR·NOREFLOW·DAPTPGX·HERPES 5도메인) |
| **PR #707** (bio kernel phase 1) | I2 (partial) | **MERGED** — ISR exp_release·ldl_pct·beer_lambert 3/7 🟠→🟢 (float-arg ABI enabled) |
| **PR #709** (verify_cli biostat) | L3 (source) | **MERGED** — nnt·arr·ln_hr_to_hr 3 fn (LPA 🟢 +3) |
| **PR #736** (atlas_cli biostat) | L3 (atlas) | **MERGED** — 20 fns 등록 · verify_cli ↔ atlas_cli verdict parity |
| **bio kernel phase 2** (pending) | I2 (잔여 4) · N2 · D3 | hill·cheng_prusoff·higuchi·fick + PK kernel + HW/binom — merge 시 4-domain 동시 |

→ **이미 실현된 leverage**: PR #700 (pool) + PR #707 (bio phase 1) + PR #709/#736 (biostat) 4건이 LPA 3-layer wall 전부 + ISR 3/7 identity + DAPTPGX/NOREFLOW sim-route 동시 해소. **잔여 leverage**: bio-verify-kernel phase 2 PR 1건이 N2 (🔵 11) + D3 (🔵 4) + I2 잔여 (🔵 25 + 🟢 10) 동시 unlock.

---

## §7. leverage 우선순위 — 한 번의 돌파로 가장 많은 wall

```
순위  돌파 path                                          동시 해소 wall 수    type
────  ───────────────────────────────────────────────  ─────────────────  ──────────
 1    bio-verify-kernel phase 2 PR (hexa-lang 단일 PR)   ████████ N2·D3·I2  proof (3 wall + 50-90 🔵)
 2    3-axis stratification panel (채혈 1회 + PCR)        ██████ N4·N5·D1·D4·L1·L2  synth/handoff (6 wall)
 3    카테터 국소전달 + imaging consortium (8-기관)        ████ N1·N3·I3·I4   handoff (4 wall)
 4    KOVA/KRGDB 한국 WGS 데이터 자산 1건                  ███ L1·N4·D4       data (3 wall, §5+§6.2 합류)
 5    supplement IRB-light pilot 프레임 공유               ██ N4·L4           handoff (2 wall)
 6    이미 MERGED (PR #700·#707·#709·#736)               ██████ L1·L2sim·L3·I2부분·D2·N2sim  proof/sim (실현 완료)
```

**최고 leverage 단일 path** = **bio-verify-kernel phase 2 PR** (순위 1) — hexa-lang 단일 PR 이 NOREFLOW N2 (🔵 0→11) + DAPTPGX D3 (🔵 0→4) + ISR I2 잔여 (🔵 +25 · 🟢 +10) 3개 proof wall 을 동시에 해소, cross-domain 50-90 🔵 escalation. 코드 leverage 로는 1위, 임상 leverage 로는 **3-axis stratification panel** (순위 2) 이 6 wall 동시 (채혈 1회로 N+D+L 3도메인 + 기존 NHIS 급여 배포 가능).

---

## §8. 현재 알려진 인프라 blocker → domain wall 매핑

CARDIO+.log.md 명시 "인프라 3회귀" + sub-log pool/atlas 회귀를 domain wall 에 매핑.

| 인프라 blocker | 실증 근거 | 매핑되는 domain wall | 현재 상태 → 돌파 path (d2) |
|---|---|---|---|
| **hexa verify --expr segfault (ubu-2)** | X2 🔵push 차단 — `--expr` float-arg recompute segfault | **N2 · D3 · I2** (proof 🔵 push) | 🔵push 차단 → (A) **X2 🔵push 재시도** bio-verify-kernel phase 2 후 · (B) `--expr` ABI 회귀 inbox patch (PR #707 float ABI 부분 enable, ubu-2 segfault 잔여) · (C) atlas append-witness 우회 🟡 직행 |
| **_imagine.hexa `--root` compile error** | X10 PAPER Figure 1 생성 차단 — pool-route escalated 환경 skill compile error | (figure handoff — domain wall 직접 아님 · X10 영향) | X10 우회 완료 (fal.ai REST 직접) → (A) **hexa-lang inbox patch** (`--root` flag 회귀) · (B) fal REST 직접 (실현) · (C) toolchain 복구 후 `/imagine` 재시도 |
| **_paper.hexa `--root` compile error** | X10 PAPER compile 차단 — pdflatex 직접 3-pass 우회 | (paper handoff — domain wall 직접 아님 · X10 영향) | X10 우회 완료 (pdflatex 직접) → (A) **hexa-lang inbox patch** · (B) pdflatex 3-pass 직접 (실현) · (C) BasicTeX 표준 매크로 전환 |
| **pool.hexa compile error (ks/i undeclared)** | D2 sim exec 차단 · LPA V3 3-of-3 reproduction · ssh direct fallback | **D2 · L2sim · I2sim · N2sim** (sim push) | **MERGED PR #700** ✅ → pool-route 복구 → (A) **정식 `pool on <host>` 복귀** · (B) ssh direct fallback (잔여 시) · (C) inbox patch 추가 |
| **atlas promoter 0-proposal bug** | D3 V2 honest 0 🔵 · atlas register --from-verify PR 거부 | **D3** (proof 🔵 push) | **부분 해소 PR #736** (atlas_cli biostat register) → (A) **atlas_cli `_recompute_register` PR** (LPA M12 잔여) · (B) verify_cli↔atlas_cli parity 활용 · (C) daily-aggregate manual fold 우회 |

→ **핵심 blocker = hexa verify --expr segfault (ubu-2)** — 이것이 X2 🔵push 의 현재 차단 단일점이며, N2·D3·I2 3개 proof wall 의 공통 gate. bio-verify-kernel phase 2 PR (§7 순위 1) 이 코드 path 를 열지만, ubu-2 segfault 회귀는 별도 ABI inbox patch 가 필요 (PR #707 이 float ABI 를 부분 enable 했으나 ubu-2 segfault 잔존). _imagine/_paper `--root` 는 X10 paper handoff 영향 (이미 fal REST + pdflatex 직접 우회 완료) 으로 domain wall 직접 매핑 없음 — hexa-lang inbox patch 후속 후보.

---

## §9. g5 grade — X9 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1-§4 sub-domain wall 표 | 🟡 | 각 sub `.md`/`.log.md` 실측·RCT null·CLI verdict 직접 인용 (verbatim) |
| §5 ALDH2*2 × CYP2C19 × Lp(a) 3-axis | 🟡 | X1 §3/§7 + sub M8/M9/M12 leverage 매핑 carry |
| §6 공통 인프라 시너지 | 🟡 | X1 §3 CX08/CX12 + sub-log PR 상태 verbatim |
| §7 leverage 우선순위 | ⚪ (자체 ranking) | wall count 산술 + leverage type 분류는 X9 가공 (subjective 순위) |
| §8 인프라 blocker 매핑 | 🟡 | CARDIO+.log.md "3회귀" + sub-log pool/atlas 회귀 verbatim |

**X9 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — 4 sub-V1/V4 wall verdict + PR 상태 verbatim carry, cross-domain leverage 매핑은 X1 §3/§7 입력 기반. §7 leverage 순위만 ⚪ honest fence (wall count 는 정량이나 우선순위 가중은 자의).

⚠ **honest fence (d2 준수)**: 본 X9 의 어느 wall 도 "현재 방법으로 불가능" 으로 닫지 않음 — 모든 wall 에 path 2-3개 명명. 🔴 FALSIFIED 영역 (PON1·darapladib·GalNAc free-tool·SGLT2i acute·colchicine acute·한중 nicorandil 6mo) 은 wall 이 아닌 closed negative (audit trail 보존) 으로 분리.

---

## §10. X9 산출 요약

- **총 wall = 18건** — NOREFLOW 5 · DAPTPGX 5 · ISR 4 · LPA 4
  - 단계 분포: sim 4 · proof 6 · synth 4 · gate 2 · handoff 2 (proof wall 이 최다 — hexa-lang kernel 의존)
- **cross-domain 시너지 4축**:
  1. ALDH2*2 × CYP2C19 × Lp(a) 3-axis panel — 6 wall 동시 (N4·N5·D1·D4·L1·L2)
  2. 카테터 국소전달 + imaging consortium — 4 wall 동시 (N1·N3·I3·I4)
  3. siRNA/supplement 공통 경로 + KOVA WGS — 3 wall 동시 (L1·N4·D4)
  4. 단일 hexa-lang bio-verify-kernel PR — 3 proof wall 동시 (N2·D3·I2 · 50-90 🔵)
- **최고 leverage 단일 path** = bio-verify-kernel phase 2 PR (3 proof wall + 50-90 🔵 cross-domain escalation)
- **임상 최고 leverage** = 3-axis stratification panel (6 wall · 채혈 1회 · 기존 NHIS 급여 배포)
- **이미 실현된 leverage** = PR #700 (pool) + #707 (bio phase 1) + #709/#736 (biostat) → LPA 3-layer wall 전부 + ISR 3/7 + DAPTPGX/NOREFLOW sim-route 동시 해소
- **현재 단일 차단점** = hexa verify --expr segfault (ubu-2) → X2 🔵push gate · N2·D3·I2 공통

---

## §11. CLI commands log

본 X9 작성 시 **새 hexa verify / atlas / pool / cloud 명령 실행 없음** — 4 sub `.md`/`.log.md` + X1 read-only 인용 + wall 매핑/산술만. (절대 금지 준수: 시뮬레이션 / pool / cloud / ad-hoc python 0건 · git 0건.)

sub-log 에서 인용된 PR 상태 (verbatim):
```
PR #658  OPEN (mergedAt=null)  — noreflow-clinical-calc → N2 🔵 0→11 gate
PR #700  MERGED               — pool.hexa compile → D2·L2sim·I2sim·N2sim
PR #707  MERGED               — bio kernel phase 1 → ISR 3/7 🟠→🟢
PR #709  MERGED               — verify_cli biostat → LPA 🟢 +3
PR #736  MERGED               — atlas_cli biostat register → L3 (🟢 28)
bio kernel phase 2  pending   — N2 + D3 + I2 잔여 동시 (§7 순위 1)
```
