# M4 — 후보 분자 short-list

> 마일스톤 M4 산출물 · current-state · no history.
> 입력 = M3 top 3 picks (ROCK · PCSK9 · GLP-1R) + M2 4-종 limus + M5 DCB carrier.
> 출처 = clinically-available drug label + pivotal RCT + 전임상 ISR data → 🟡 SUPPORTED-BY-CITATION.
> 목표 = 6-10 분자 short-list + delivery 경로 (DES · DCB · systemic) 매핑 → M5 DCB combo · M7 safety · M8 한국인 ranking 입력.

---

## §1. Short-list overview 표 (12 분자)

M3 top picks + drug-repurposing 후보 + DCB-friendly limus + 보조 anti-inflammatory + cardio-protective.

| # | molecule | family (M3) | mechanism | clinical maturity | delivery 경로 | NA 효과 | safety grade |
|---|---|---|---|---|---|---|---|
| 1 | **fasudil** | ROCK | RhoA/ROCK1/2 catalytic inhibitor (ATP-competitive) | **승인** (Japan 1995 · China — cerebral vasospasm) | **DES coating · DCB** (lipophilic 적정) · short IV | 중 (EC NO ↑ · 염증 ↓) | A (저혈압 외 깨끗 · 30y) |
| 2 | **netarsudil** | ROCK | ROCK1/2 + NET (norepinephrine transporter) | **승인** (US 2017 — 녹내장 안약) | DES coating 가능 (소수성) | 중 | A (안압 적응증 인체 안전성) |
| 3 | **K-115 / ripasudil** | ROCK | ROCK2-selective | **승인** (Japan 2014 — 녹내장) | DES coating 가능 | 중 | A |
| 4 | **evolocumab** | PCSK9 | mAb (humanized IgG2) anti-PCSK9 | **승인** (FOURIER · ODYSSEY) | **systemic SC q2w/q1m** | **강** (LDL ↓ 60%) | A (5y 안전성) |
| 5 | **alirocumab** | PCSK9 | mAb anti-PCSK9 | **승인** | systemic SC | **강** | A |
| 6 | **inclisiran** | PCSK9 | siRNA (GalNAc-conjugated, hepatocyte targeted) | **승인** (ORION-9/10/11 2020) | **systemic SC q6m** | **강** | A (6mo 1회 — 순응도 ↑) |
| 7 | **semaglutide** | GLP-1R | GLP-1R agonist (acylated peptide) | **승인** (SUSTAIN · STEP · SELECT) | systemic SC q1w · po qd | **강** (CV outcome ↓ 20%) | A (GI · pancreas rare) |
| 8 | **tirzepatide** | GLP-1R + GIP | dual GIP/GLP-1R agonist | **승인** (SURPASS · SURMOUNT) | systemic SC q1w | **강** (체중 ↓ + CV) | A-B (장기 CV outcome 진행중) |
| 9 | **colchicine** | NLRP3 / 미세소관 (alt path) | tubulin + NLRP3 inhibitor (low-dose anti-inflammatory) | **승인** (LoDoCo2 · COLCOT 2019/20) | **systemic po qd 0.5mg** · DES coating △ · DCB △ | **강** (CV MACE ↓ 23-31%) | B (GI · 노인 myopathy · CYP3A4) |
| 10 | **canakinumab** | NLRP3 / IL-1β | anti-IL-1β mAb | **승인** (CAPS 적응증) | systemic SC q3m | 중-강 (CANTOS MACE ↓ 15%) | C (감염 사망 ↑ · 비용 ↑) |
| 11 | **empagliflozin / dapagliflozin** | SGLT2 | SGLT2 inhibitor (renal glucose reabsorption ↓) | **승인** (EMPA-REG · DAPA-HF) | systemic po qd | 중 (CV outcome ↓ · HF ↓) | A (euglycemic DKA rare) |
| 12 | **biolimus A9 (umirolimus) — DCB** | mTORC1 (M2 baseline) | FKBP12-mTORC1 inhibitor (logP 7.4 최고) | **DES 승인** (BioMatrix · Nobori) · DCB 개발중 | **DCB primary** · DES | 弱 (NH 강 · NA 약) | A (DES 15y track record) |

추가 second-tier (deferred · M3 §6):
- **apabetalone (RVX-208)** — BET, BETonMACE NS but CKD post-hoc 신호 — M7로
- **verteporfin** — YAP/TAZ, 광독성 — local DES 코팅만 가능
- **IAG933 / GNE-7883** — TEAD inhibitor 전임상

→ **총 short-list = 12 (primary) + 3 (second-tier deferred to M7)**.
→ **delivery dual-track 표면**: local (DES/DCB — ROCK · biolimus) + systemic (PCSK9 · GLP-1R · colchicine · SGLT2i).

---

## §2. Top 5 deep-dive

### §2.1 fasudil (ROCK) — local + 30y Japan safety

| 항목 | 값 |
|---|---|
| 분자 구조 | isoquinoline sulfonamide · 5-(1,4-diazepan-1-ylsulfonyl)isoquinoline · MW 291 · logP 1.4 (free base) · logP ~3 (hydroxyfasudil 활성대사체) |
| MoA | ATP-competitive ROCK1/2 inhibitor → MLC phosphorylation ↓ → VSMC 수축·증식·migration 차단 + EC eNOS ↑ |
| 기존 적응증 | cerebral vasospasm (Japan/China 1995-) · pulmonary HTN off-label · CAD vasospasm off-label |
| ISR/CV evidence | Matsumoto 2004 (porcine stent, NH 40-50% ↓) · Vicari 2005 (Italian RCT n=84, oral fasudil ISR 25% vs 47% placebo) · Masumoto 2002 (사람 vasospasm) |
| DES/DCB 호환성 | **DES coating ★★★★** — logP 적정 + polymer reservoir 호환 · **DCB ★★★★** — 친수성/lipophilic 균형 + short contact 가능 (carrier로 lipophilic ester prodrug 시도) |
| 한계 | (a) systemic 시 저혈압 dose-limiting · (b) FDA 미승인 (Japan/China only) → US/EU 신규 IND 필요 · (c) hydroxyfasudil 활성대사체 dependence — local 시 conversion 검증 필요 |

### §2.2 evolocumab (PCSK9 mAb) — systemic adjunct · LDL · NA

| 항목 | 값 |
|---|---|
| 분자 구조 | humanized IgG2 mAb · MW 144 kDa · PCSK9 catalytic domain 결합 |
| MoA | PCSK9-LDLR 결합 차단 → hepatic LDLR recycling ↑ → 혈중 LDL ↓ 60% → arterial wall ox-LDL 침착 ↓ → foam cell · NA ↓ |
| 기존 적응증 | FH (familial hypercholesterolemia) · 2차 예방 (ASCVD) · statin intolerant |
| ISR/CV evidence | **FOURIER** (Sabatine 2017 NEJM, n=27,564) — MACE HR 0.85 · MI 27% ↓ · 2y · post-PCI subgroup positive · GLAGOV (IVUS plaque regression) |
| DES/DCB 호환성 | **DES ☓** — mAb 144 kDa → polymer coating 부적합 (denaturation · burst release 불가) · **DCB ☓** — 30s contact 부족 · **systemic ★★★★★** = **유일 경로** |
| 한계 | (a) DES local 불가 — 분자량 wall → systemic only · (b) cost (연 5000-15000 USD) — DAPTPGX-like 환자 선별 필수 · (c) ISR endpoint 직접 RCT 부재 — atheroma regression → NA-ISR extrapolation 필요 |

### §2.3 semaglutide (GLP-1R) — systemic adjunct · 염증 · endo

| 항목 | 값 |
|---|---|
| 분자 구조 | 31-aa peptide · GLP-1 (7-37) + Aib8 + C18 fatty-acid side chain → albumin binding → t½ 1주 · MW 4113 |
| MoA | GLP-1R 활성 (β-cell + EC + macrophage) → cAMP ↑ → 인슐린 ↑ + EC eNOS ↑ + macrophage NF-κB ↓ + foam cell ↓ |
| 기존 적응증 | T2DM (SUSTAIN) · obesity (STEP) · ASCVD 2차 예방 (SELECT 2023) |
| ISR/CV evidence | **SELECT** (Lincoff 2023 NEJM, n=17,604 non-DM ASCVD) — 3-point MACE HR 0.80 · 비-DM에서도 작동 · SUSTAIN-6 (CV outcome) · LEADER (liraglutide CV) |
| DES/DCB 호환성 | **DES ☓** — peptide, 분자량 + denaturation · **DCB ☓** · **systemic ★★★★★** — SC q1w (semaglutide) · po qd (Rybelsus) |
| 한계 | (a) DES local 불가 — peptide wall · (b) GI 부작용 (오심 · 구토) — 적정 dose titration 필요 · (c) ISR endpoint 직접 RCT 부재 · (d) 갑상선 C-cell tumor (rat) — 인체 신호 없음 |

### §2.4 colchicine — alt-path · NLRP3 · MACE · 저비용

| 항목 | 값 |
|---|---|
| 분자 구조 | tropolone alkaloid · MW 399 · logP 1.0 · oral bioavailability 45% |
| MoA | (i) β-tubulin 결합 → 미세소관 polymerization 차단 → 호중구 chemotaxis ↓ · (ii) **NLRP3 inflammasome 조립 차단** → IL-1β · IL-18 ↓ · (iii) macrophage activation ↓ |
| 기존 적응증 | gout (2000y+) · familial Mediterranean fever · pericarditis |
| ISR/CV evidence | **COLCOT** (Tardif 2019 NEJM, n=4745 post-MI) — MACE HR 0.77 · stroke 74% ↓ · **LoDoCo2** (Nidorf 2020 NEJM, n=5522 chronic CAD) — MACE HR 0.69 · ISR endpoint 직접 부재 but post-PCI MACE positive |
| DES/DCB 호환성 | **DES coating △★★** — small molecule + 적정 logP — 가능 but 전임상 데이터 부족 · **DCB △★★★** — lipophilic 변형 (colchicine prodrug) 검토 · **systemic ★★★★** = 1차 경로 (po 0.5mg qd) |
| 한계 | (a) **CYP3A4 / P-gp 기질** — statin · macrolide · CCB 와 약물상호작용 (rhabdomyolysis) · (b) **CKD/노인 myopathy** 위험 — dose 조정 · (c) GI 부작용 (설사) · (d) ISR-specific RCT 부재 — post-PCI MACE 데이터 extrapolation |

### §2.5 biolimus A9-DCB (umirolimus, M5 차세대 hook)

| 항목 | 값 |
|---|---|
| 분자 구조 | sirolimus C40-ethyl 치환 macrolide · MW 986 · **logP 7.4** (limus 중 최고) · FKBP12 Kd 0.3 nM |
| MoA | M2와 동일 — FKBP12-mTORC1 알로스테릭 차단 → VSMC G1 정지 (NH 차단) |
| 기존 적응증 | DES 약물 (BioMatrix · Nobori — LEADERS · NOBORI 검증, 일본·EU 주력) |
| ISR/CV evidence | LEADERS (Windecker 2008 Lancet) — Cypher 비열등 · NOBORI 1 — TLR 3.3% · BioFreedom (polymer-free, LEADERS-FREE Urban 2015 NEJM) — HBR 1mo DAPT 가능성 · **DCB 개발 라인** (Biotronik · Concept Medical) |
| DES/DCB 호환성 | **DCB ★★★★★** — **logP 7.4 = limus 중 최고 lipophilic → carrier 부담 ↓ + tissue uptake ↑** · paclitaxel-DCB 의 "rapid uptake + retention" 패러다임을 limus 계열 중 가장 잘 모사 · **DES ★★★★** (검증된 abluminal-only 분해 PLA polymer) |
| 한계 | (a) NA 약점 — mTORC1 단일 표적 — M3 d2 wall 미해결 → biolimus + 비-mTOR combo 필수 · (b) DCB clinical evidence 아직 부족 — head-to-head paclitaxel-DCB vs biolimus-DCB 트라이얼 부재 · (c) 일본/EU 중심 — US 진입 지연 |

---

## §3. Delivery route matrix

각 후보 × delivery 경로의 적합도 (★1-5, ☓ = 불가).

| molecule | DES coating | DCB | systemic adjunct |
|---|---|---|---|
| fasudil (ROCK) | ★★★★ — lipophilic 적정 + polymer reservoir | ★★★★ — short contact 가능 (carrier 필요) | △ ★★ — 단기 IV vasospasm 적응증 / 저혈압 dose 한계 |
| netarsudil (ROCK) | ★★★★ — 소수성, paclitaxel 유사 | ★★★ — 데이터 부재 but PK 적합 | ☓ — 녹내장 안약 — 시스템 노출 미검증 |
| ripasudil (ROCK2) | ★★★ — 가능 but 데이터 부재 | ★★★ — 동일 | ☓ |
| evolocumab (PCSK9) | ☓ — mAb 144 kDa, coating 불가 | ☓ — peptide 30s contact 부족 | **★★★★★** — SC q2w/q1m · FOURIER 검증 |
| alirocumab (PCSK9) | ☓ | ☓ | **★★★★★** — SC q2w · ODYSSEY |
| inclisiran (PCSK9 siRNA) | ☓ — siRNA hepatocyte targeted only | ☓ | **★★★★★** — SC q6m · 순응도 최고 |
| semaglutide (GLP-1R) | ☓ — peptide | ☓ | **★★★★★** — SC q1w · po qd · SELECT |
| tirzepatide (dual GIP/GLP-1R) | ☓ | ☓ | **★★★★★** — SC q1w · SURPASS |
| colchicine | ★★★ — small molecule, prodrug 필요 | ★★★ — lipophilic 변형 가능 | **★★★★** — po 0.5mg qd · COLCOT/LoDoCo2 |
| canakinumab (IL-1β) | ☓ — mAb | ☓ | ★★★ — SC q3m, 비용/감염 wall |
| empa/dapa (SGLT2i) | ☓ — 분자 표적 renal | ☓ | **★★★★** — po qd · EMPA-REG/DAPA-HF |
| biolimus A9-DCB | ★★★★★ — 검증된 DES coating | **★★★★★** — logP 7.4 → DCB 최적 | ☓ — local 전용 |
| paclitaxel + sirolimus dual-DCB | △ — DES dual coat 가능 (combo) | **★★★★** — combo DCB · synergy 가설 | ☓ |

### Dual-track 전략 ASCII

```
       ┌───────────────── ISR 환자 ────────────────┐
       │                                          │
       │   STEP-1 시술시점 — local intervention    │
       │   ────────────────────────────────────   │
       │                                          │
       │   ┌──────────── DES / DCB ──────────────┐ │
       │   │                                    │ │
       │   │  baseline (cytostatic anti-VSMC):  │ │
       │   │   biolimus A9 (logP 7.4) →         │ │
       │   │     DES coat / DCB primary         │ │
       │   │                                    │ │
       │   │  + adjunct (M3 비-mTOR):           │ │
       │   │   fasudil (ROCK · EC-friendly) →   │ │
       │   │     DES dual-coat / DCB combo      │ │
       │   │                                    │ │
       │   │  optional: colchicine prodrug →    │ │
       │   │     DCB (NLRP3 local)              │ │
       │   └────────────────────────────────────┘ │
       │                  │                       │
       │                  ↓                       │
       │            NH ↓ (1-6m)                   │
       │            EC 회복 보존                  │
       │                                          │
       │   STEP-2 시술 후 — systemic adjunct      │
       │   ─────────────────────────────────────  │
       │                                          │
       │   ┌────────── systemic 3-axis ─────────┐ │
       │   │                                    │ │
       │   │  LDL axis    : evolocumab /        │ │
       │   │                inclisiran (q6m)    │ │
       │   │                                    │ │
       │   │  metabolic   : semaglutide /       │ │
       │   │                tirzepatide (q1w)   │ │
       │   │                                    │ │
       │   │  inflammation: colchicine 0.5mg po │ │
       │   │                (+SGLT2i optional)  │ │
       │   └────────────────────────────────────┘ │
       │                  │                       │
       │                  ↓                       │
       │       NA 차단 (3-10y) · MACE ↓           │
       │       late-stent failure 감소            │
       └──────────────────────────────────────────┘
```

→ **핵심 통찰**: local (NH 1-6m 차단) + systemic (NA 3-10y 차단) — M1 시간축 2-phase 패러다임에 1:1 매칭.

---

## §4. Drug-repurposing logic

short-list 12 중 5개 (fasudil · netarsudil · semaglutide · colchicine · evolocumab) 는 모두 **다른 적응증으로 인체 안전성 검증 완료** — 신규 ISR IND 부담 ↓.

| 분자 | 원 적응증 | 재타겟팅 logic | 인체 안전성 누적 |
|---|---|---|---|
| **fasudil** | cerebral vasospasm (Japan 30y) | ROCK은 SAH vasospasm · ISR VSMC 증식 공통 → 표적 동일. **vasospasm 약을 vessel wall 직접 전달 (DES coating)** 로 systemic dose ↓ · local concentration ↑ | 30년 일본·중국 · 저혈압 외 깨끗 |
| **netarsudil** | 녹내장 (US 2017) | 안압 강하 = trabecular meshwork ROCK 차단 · 동일 표적이 coronary VSMC에서도 작동 → DES coating 후보 | 7년 US · 결막충혈 외 깨끗 |
| **ripasudil** | 녹내장 (Japan 2014) | ROCK2-selective — fasudil 보다 선택성 ↑ → 저혈압 ↓ 가능성 | 11년 일본 · 결막충혈 |
| **semaglutide** | T2DM → obesity → ASCVD 2차 예방 (SELECT 2023) | GLP-1R은 EC + macrophage 에서 항-염증 + endothelial 회복 → NA 차단. **이미 SELECT에서 비-DM ASCVD CV outcome positive** → ISR 환자도 동일 logic | 10년 글로벌 · GI 외 깨끗 |
| **colchicine** | gout (2000y) · pericarditis | 미세소관 + NLRP3 inflammasome — atherosclerosis 동일 driver. **LoDoCo2/COLCOT 가 post-PCI MACE benefit 입증** → ISR-NA 직접 logic 확장 | 수천년 · low-dose 0.5mg/d 안전 |
| **evolocumab / alirocumab** | FH → ASCVD 2차 예방 | LDL → arterial wall foam cell → NA — direct lipid axis · GLAGOV IVUS plaque regression → ISR-NA extrapolation | 8년 · 매우 안전 |
| **inclisiran** | ASCVD LDL ↓ | siRNA hepatocyte PCSK9 silencing — 같은 표적, 다른 modality · q6m 순응도 wall 돌파 | 5년 · ORION 검증 |
| **empa/dapa** | T2DM · HFrEF · HFpEF · CKD | SGLT2 차단 → 혈관 항-염증 · diuresis · myocardial energy ↑ → CV outcome ↓ · ISR 직접 RCT 없으나 CV outcome 일관 | 10년 · euglycemic DKA rare |

→ **repurposing logic 공통 패턴**: ① 표적이 다른 적응증에서 검증된 인체 안전성 ② ISR/NA 와 표적 mechanism 직접 연결 ③ delivery route만 조정 (local DES/DCB ↔ systemic).
→ **신규 IND 비용 절감** — Phase 2/3 직행 (Phase 1 인체 PK 부담 ↓).

---

## §5. M5 DCB combo hooks

DCB-friendly 조건 = (a) lipophilic (logP 3-7 sweet spot · 30s contact 내 tissue uptake) · (b) cytostatic (not cytotoxic — paclitaxel PMA 신호 회피) · (c) M3 신규 표적 (mTOR escape 보완).

| combo | DCB 적합성 | rationale | 단계 |
|---|---|---|---|
| **biolimus A9 mono-DCB** | ★★★★★ | logP 7.4 — limus 최고 lipophilic + paclitaxel 패러다임을 mTOR-cytostatic 으로 모사 + DES BioMatrix 검증된 분자 | M5/M6 — 차세대 표준 후보 |
| **fasudil-DCB** | ★★★★ | ROCK 차단 → EC NO ↑ → re-endo 보존 (mTOR healing 지연 wall 해소) + lipophilic prodrug (hydroxyfasudil ester) 으로 carrier 부담 ↓ | M5 — 전임상 PK 우선 |
| **paclitaxel + sirolimus dual-DCB** | ★★★★ | 저용량 paclitaxel (cytotoxic 부담 ↓) + sirolimus carrier-depot (sustained) — synergy 가설 (Cremers · Granada preclinical) | M5 — combo Ph1 |
| **biolimus + ROCK-i dual-DCB** | ★★★★ | NH (biolimus) + NA (ROCK) + EC 보존 (ROCK) — M3 d2 wall (NA) 직접 hit · 한국 발 차세대 비-mTOR combo 후보 | M5/M6 — 신규 IND |
| **biolimus + colchicine prodrug dual-DCB** | ★★★ | NH (biolimus) + NLRP3 local (colchicine 미립자 + lipophilic 변형) → NA 일부 차단 | M5 — 전임상 |
| **sirolimus + apabetalone dual-DCB** | ★★ | mTOR + BET (NA 차단) — 그러나 BET safety wall (M3 §5) → M7 절차 |

→ **DCB 차세대 최우선 = biolimus mono-DCB (logP 우위 검증)** → 그 위에 **biolimus + fasudil dual-DCB (M3 d2 wall 직접 hit)**.

---

## §6. 한계 + M7/M8 입력

### M7 (off-target / 안전성) 으로 넘기는 분자

| 분자 | 미검증 안전성 | M7 검증 task |
|---|---|---|
| fasudil-DES local | systemic spillover 시 저혈압 · hydroxyfasudil 활성대사체 conversion in vessel wall | PK porcine 모델 + late ST imaging |
| netarsudil DES local | 결막충혈 외 coronary 인체 데이터 0 | Ph1 small n + 8w OCT |
| ripasudil DES local | 동일 — 인체 coronary 데이터 0 | Ph1 |
| biolimus A9-DCB | DES 검증 but DCB head-to-head paclitaxel 부재 + neointima 패턴 | RCT vs paclitaxel-DCB |
| biolimus + fasudil dual-DCB | combo PK · 상호작용 · re-endo + late ST | 전임상 porcine + 사람 Ph1 |
| colchicine-DCB prodrug | local NLRP3 효과 · 미세소관 cytotoxic 시 endothelial 손상 | 전임상 cytotoxicity |
| paclitaxel + sirolimus dual-DCB | dose 적정 + Katsanos PMA signal 보완 | 5y mortality endpoint |
| apabetalone (BET, second-tier) | 혈소판 감소 · 간 toxicity · BETonMACE NS 의 재해석 | post-hoc CKD subgroup + DES local 비교 |
| verteporfin (YAP/TAZ, second-tier) | 광독성 · TEAD-i 신규 분자 인체 데이터 부재 | local 비-PDT 분자 (IAG933) 전임상 |
| canakinumab | 감염 사망률 ↑ (CANTOS) · 비용 | M7 risk-benefit |

### M8 (한국인 evidence + 통합 ranking) 으로 넘기는 항목

| 항목 | 한국인 evidence 현황 |
|---|---|
| fasudil-DES local | 한국 RCT 부재 — 일본/중국 fasudil 사용 데이터 차용 가능 |
| evolocumab / alirocumab (한국 ASCVD) | FOURIER Korean subgroup + HOST-EXAM 의 LDL 효과 hook |
| inclisiran (한국 보험 등재 상태) | ORION-9/10/11 한국 참여 — 보험 등재 시점 변수 |
| semaglutide / tirzepatide (한국 obesity·ASCVD) | SELECT 한국 site 참여 — KOSSO/KSCVS 가이드라인 hook |
| colchicine (한국 post-MI use) | LoDoCo-Korea 부재 — KAMIR registry 에서 colchicine post-PCI subgroup 분석 가능 |
| biolimus-DCB · biolimus+fasudil dual-DCB | K-DCB / TIS Korean RCT 신설 — 한국 발 차세대 DCB 발신 후보 |

### Short-list 한계 요약

(a) **인체 ISR endpoint 직접 RCT 부재** — 모두 atheroma / CV outcome → ISR-NA extrapolation. (b) **DES coating 인체 데이터 0** — fasudil/netarsudil/biolimus dual 전부 전임상 단계. (c) **systemic adjunct 의 ISR specificity 미검증** — PCSK9/GLP-1R/colchicine 의 ISR-NA effect 는 post-hoc · subgroup 단위. (d) **한국인 evidence 약함** — K-DCB / KAMIR / HOST 시리즈 외 ISR 특화 RCT 부재.

→ **breakthrough paths** (d2): ① biolimus + fasudil dual-DCB **한국 발 IIT** (Ph1/2) — Top 1 우선 · ② inclisiran post-PCI Korean registry (M8) · ③ colchicine + DES Korean RCT (KAMIR 확장) · ④ TEAD-i (IAG933) local DES 전임상 (M3 deferred 복귀 trigger).

---

## §7. 참고문헌

- Matsumoto Y et al. (2004) *Circ Res* 94:467 — fasudil porcine stent NH ↓
- Vicari RM et al. (2005) *JACC* 46:1803 — fasudil oral ISR small RCT
- Masumoto A et al. (2002) *Circulation* 105:1545 — fasudil vasospasm
- Sabatine MS et al. (2017) *NEJM* 376:1713 — FOURIER (evolocumab)
- Schwartz GG et al. (2018) *NEJM* 379:2097 — ODYSSEY OUTCOMES (alirocumab)
- Ray KK et al. (2020) *NEJM* 382:1507 — ORION-10/11 (inclisiran)
- Lincoff AM et al. (2023) *NEJM* 389:2221 — SELECT (semaglutide non-DM ASCVD)
- Marso SP et al. (2016) *NEJM* 375:311 — LEADER (liraglutide CV)
- Tardif JC et al. (2019) *NEJM* 381:2497 — COLCOT (colchicine post-MI)
- Nidorf SM et al. (2020) *NEJM* 383:1838 — LoDoCo2 (colchicine chronic CAD)
- Ridker PM et al. (2017) *NEJM* 377:1119 — CANTOS (canakinumab)
- Zinman B et al. (2015) *NEJM* 373:2117 — EMPA-REG OUTCOME
- Windecker S et al. (2008) *Lancet* 372:1163 — LEADERS (biolimus A9)
- Urban P et al. (2015) *NEJM* 373:2038 — LEADERS-FREE (BioFreedom HBR)
- Nicholls SJ et al. (2016) *JAMA* 316:2373 — GLAGOV (evolocumab IVUS plaque)
- Garg S, Serruys PW (2010) *JACC* 56:S1, S43 — limus PK comparison
- Cremers B et al. (2014) — paclitaxel-DCB preclinical (carrier)

---

## §8. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 12 분자 표적 정의 + 적응증 | 🟡 SUPPORTED-BY-CITATION | FDA label + pivotal RCT |
| fasudil ISR small RCT | 🟡 SUPPORTED-BY-CITATION | Vicari 2005 n=84 |
| PCSK9 / GLP-1R / colchicine CV outcome | 🟡 SUPPORTED-BY-CITATION | FOURIER · SELECT · COLCOT · LoDoCo2 |
| biolimus A9 logP / DES 효능 | 🟡 SUPPORTED-BY-CITATION | Garg & Serruys + LEADERS |
| DES coating 인체 효능 (fasudil/netarsudil/biolimus DCB) | 🟠 INSUFFICIENT/DEFERRED | 전임상 또는 개발 단계 — M5/M7 |
| systemic adjunct → ISR-NA endpoint | 🟠 INSUFFICIENT/DEFERRED | post-hoc subgroup — 직접 RCT 부재 |
| dual-DCB combo (biolimus+fasudil) | 🟠 INSUFFICIENT/DEFERRED | 가설 — M5/M6 신규 IND 입력 |

🔑 핵심 통찰:
- **short-list 12** = ROCK 3 (fasudil · netarsudil · ripasudil) + PCSK9 3 (evolocumab · alirocumab · inclisiran) + GLP-1R 2 (semaglutide · tirzepatide) + anti-inflammatory 2 (colchicine · canakinumab) + SGLT2i 2 (empa · dapa) + DCB baseline 1 (biolimus A9). **top 3 picks = fasudil-DCB · evolocumab · semaglutide** — M3 grade A 직결.
- **dual-track 전략**: local (DES/DCB · biolimus + fasudil) + systemic (PCSK9 + GLP-1R + colchicine) — M1 시간축 NH (1-6m) + NA (3-10y) 2-phase 와 1:1 매칭.
- **가장 유망한 차세대 combo = biolimus + fasudil dual-DCB** — M3 d2 wall (NA + EC 보존) 직접 hit · 한국 발 신규 IND 후보.
- **M7 안전성 검증 필요**: fasudil/netarsudil local · biolimus-DCB head-to-head · dual-DCB combo PK · apabetalone (BET 혈소판/간) · verteporfin (광독성) · canakinumab (감염).
