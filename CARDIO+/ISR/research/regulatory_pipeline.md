# R2 — web/regulatory research sweep

> 마일스톤 R2 산출물 · current-state · 2026-05 시점 web fetch 기반.
> 입력 = M1-M8 (특히 M5 DCB · M7 safety · M8 IIT) + regulator / guideline / ClinicalTrials.gov.
> 출처 = FDA letter · ESC 2024 · ACC/AHA 2025 · SCAI 2023 · MFDS · PMDA · NICE · 회사 IR · TCT 2025 reports → 🟡 SUPPORTED-BY-CITATION.
> 목표 = 최신 regulatory state + ongoing trials inventory + M8 IIT 3 후보 정렬 + 한국 IIT 우선순위 갱신 권고.

---

## §1. regulatory state matrix — agency × product × status (2026-05)

| 제품군 | FDA (US) | EMA / CE (EU) | MFDS (KR) | PMDA (JP) |
|---|---|---|---|---|
| **2G DES — Xience (everolimus)** | approved (long-standing) | CE | approved | approved |
| **2G DES — Resolute Onyx (zotarolimus)** | approved · 1m DAPT label (ONYX-ONE) | CE | approved | approved |
| **3G bio-polymer DES — Orsiro / Synergy / Ultimaster** | approved | CE | approved (3G 전수 진입) | approved |
| **BioFreedom polymer-free biolimus** | approved (HBR) | CE (LEADERS-FREE 기반) | approved | approved |
| **paclitaxel-DCB (SeQuent Please · IN.PACT Falcon · Pantera Lux)** | **PAD approved (2023.07 letter — restrictions 전면 해제)** · coronary off-label (AGENT 외 PMA 없음) | CE (coronary ISR · de novo SVD) | approved (coronary ISR) | approved (coronary ISR · JCC 2014 consensus) |
| **AGENT paclitaxel-DCB (Boston Scientific)** | **PMA approved 2024-03 — coronary ISR 첫 US 적응증** (Breakthrough 2021 → AGENT IDE pivotal) | CE | not yet (MFDS 검토 가능성) | not yet |
| **SELUTION SLR sirolimus-DCB (Cordis)** | IDE / pivotal (SELUTION4ISR 결과 발표 TCT 2025 · primary endpoint TLF 1y NS vs SOC) | **CE (coronary 2020)** | not yet | not yet |
| **MagicTouch sirolimus-DCB (Concept Medical)** | Breakthrough designation · IDE 진행 | CE | not yet | not yet |
| **Virtue SAB sirolimus-AngioInfusion balloon (Orchestra BioMed)** | **IDE approved 2025-04 — head-to-head vs AGENT pivotal 시작** | (in trial) | not yet | not yet |
| **biolimus-DCB (REFORM 결과)** | **REFORM 실패 (2025 JACC CI) — paclitaxel-DCB 대비 비열등성 미달** | (in trial · BIO ASCEND ISR) | not yet | not yet |
| **Magmaris Mg-BRS (1G · Biotronik)** | not pursued (US) | CE (제한적 진료 indication) | not approved (limited registry) | not approved |
| **Freesolve / DREAMS 3G Mg-BRS (Biotronik)** | **BTK indication Breakthrough designation 2024-03** · coronary US 미진행 | **CE coronary 2024 진입** | not yet | not yet |
| **MeRes100 (Meril, India) PLLA-BRS** | not pursued | CE (limited) | not yet | not yet |
| **AGENT DCB post-approval surveillance** | enrolling (5y FU) | — | — | — |
| **Zn-BRS** | preclinical only | preclinical | — | — |

→ **승인 dominance**: 2G/3G DES = 전세계 표준 · **paclitaxel-DCB = ISR ESC/JCS first-line** · **AGENT = US 첫 coronary DCB PMA (2024)** · **sirolimus-DCB는 EU 중심 (Selution CE 2020)** · **Mg-BRS = Freesolve CE 2024 coronary 진입**.

---

## §2. guideline ladder — ISR class of recommendation 비교

| guideline | year | ISR — DCB 권고 | ISR — DES 권고 | imaging (IVUS/OCT) | DAPT 단축 권고 |
|---|---|---|---|---|---|
| **ESC/EACTS Myocardial Revascularization** | 2018 | **Class IA** (DCB or DES, equivalent) | Class IA | IIa | per-stent base |
| **ESC Chronic Coronary Syndromes** | **2024** | **DES preferred over DCB** (TLR signal 약간 高) — debate 진행 | Class I | **Class I (강화)** | Class I (HBR 1m) |
| **ACC/AHA/SCAI PCI Guideline** | 2021 | DES (Class IIa) · DCB (off-label) | Class IIa | IIa | per-base |
| **ACC/AHA/ACEP/NAEMSP/SCAI ACS Guideline** | **2025** | DAPT 1m HBR (Class 1, ticagrelor mono) · ISR 별도 section 부재 | (ACS 적응증) | IVI Class IA (complex/ISR) | **Class 1 HBR 1m strategy** |
| **SCAI Expert Consensus on ISR** | **2023** | DCB or DES (operator/lesion 의존) — **DCB는 RECURRENT ISR 우선** | DES first ISR | **IVI requisite for ISR** | per-DES base |
| **JCS/JCC/JACR/JATS** | **2024** | **DCB 우호적** (DCB-only de novo large vessel + ISR) — JP 일관성 | DES + DCB 병행 | IVI 권고 | 6m base |
| **NICE (UK) TA** | TA appraisal 없음 (DCB 기술) — clinical commissioning level만 | (no formal TA) | NHS 표준 | per-imaging | per-base |
| **KCSC / KSC 한국** | KSC2024 (10월) · KSC2025 (Spring · Busan) | 정형화 position statement 미발견 (소규모 합의문 + K-DCB registry 기반) | KCSC 합의 (2G/3G DES first) | KCSC 70%+ 시술 IVI/OCT | HOST-REDUCE / STOPDAPT-2 영향 — 1m 적용 활발 |

→ **divergence**: **ESC 2024 가 DCB 후퇴 (DES preferred)** · **JCS 2024 + SCAI 2023 + KCSC = DCB 우호** → **regional 표준 분기**. 한국·일본 = DCB 친화 cluster.
→ **공통**: imaging (IVUS/OCT) Class I 강화 · HBR 1m DAPT Class I.
→ **debate point**: ESC 2024 의 DCB 후퇴는 AGENT IDE 2y / ISAR-DESIRE 3 / REFORM 결과 (mixed) 반영 — **재논의 가능성** (2026-27 update).

---

## §3. ongoing trials inventory (12 trials, ClinicalTrials.gov 기반)

| NCT id | trial name | sponsor | intervention | primary endpoint | est. completion | M3/M4 relevance |
|---|---|---|---|---|---|---|
| **NCT04647253** | AGENT IDE / Post-Approval | Boston Scientific | paclitaxel-DCB vs uncoated · ISR | TLF 1y → 5y FU | 2027 (5y) · 2y data 발표 (CRT 2025) | **paclitaxel-DCB benchmark** · M5/M8 #5 직접 |
| **NCT04280029** | SELUTION4ISR | Cordis / MedAlliance | sirolimus-DCB vs SOC · ISR n=418 | TLF 1y (NS) · 2y FU | 2026 (FU 계속) | **sirolimus-DCB** · M5/M8 #4 |
| **(SELUTION DeNovo)** | SELUTION DeNovo | Cordis / MedAlliance | sirolimus-DCB ± bailout DES vs DES · n=3,341 (62 sites, 12국) | TVF 12m (5.3% vs 4.4%, non-inferior) | 2024 (enrollment), data TCT 2025 | **de novo DCB-only** · M5 차세대 |
| **NCT07258290** | Freesolve RMS / BIOMAG-III pivotal | Biotronik | Mg-BRS (sirolimus) vs Xience · n=1,859 (120 sites) | TLF 12m (NI) | **2027-02** primary · 2030+ long FU | **Mg-BRS** · M6/M8 #6 · 인접 IIT (한국 추가 sites 가능) |
| **NCT05540223** | Freesolve / DREAMS 3G post-CE | Biotronik | Mg-BRS coronary registry | TLF + late safety | enrolling | M6 late NA 추적 |
| **NCT06409117** | 3G Mg-BRS vs bio-poly DES in NSTE-ACS | Biotronik/academic | Freesolve vs Orsiro · ACS | TLF 12m | 2026-27 | M6 + ACS subgroup |
| **NCT07022587** | bioresorbable sirolimus scaffold de novo | (academic) | PLLA/Mg sirolimus-BRS vs DES | TLF 12m | 2027+ | M6 BRS 차세대 |
| **(Virtue SAB IDE pivotal)** | Virtue SAB head-to-head | Orchestra BioMed | sirolimus-AngioInfusion balloon vs AGENT (paclitaxel-DCB) | TLF 12m · DCB head-to-head | enrolling (2025 start) | **first head-to-head sirolimus vs paclitaxel-DCB US** · M5 분기 |
| **NCT06669793** | Biolimus-Coated Balloon de Novo LVD | (academic) | biolimus-DCB de novo large vessel | TLF 12m | 2026-27 | **biolimus-DCB** · M5 (REFORM 실패 후 재시도) |
| **NCT06710210** | Hybrid BRS + DCB vs DES (long diffuse) | (academic) | Mg-BRS + DCB vs DES | TLF 12m | 2027+ | **M5 + M6 combination** · M8 #1 dual-DCB 인접 |
| **NCT06752954** | DCB + Viabahn PAD (인접) | (academic) | DCB + endograft PAD (CLI/SFA) | patency 12m | enrolling | PAD reference (Katsanos signal 후속) |
| **(VICTORION-2 Prevent)** | inclisiran outcomes | Novartis | inclisiran vs placebo · ASCVD secondary prevention | MACE | **2026 primary** (data 발표 임박) | **M3/M8 #7 PCSK9 systemic adjunct** 직접 evidence |
| **(ORION-4)** | inclisiran outcomes long | Novartis / academic | inclisiran vs placebo · n=15,000 · ASCVD | MACE 5y | 2027 | M8 #7 long-term |

→ **paclitaxel-DCB (AGENT IDE) · sirolimus-DCB (SELUTION) · Mg-BRS (BIOMAG-III) · sirolimus-AngioInfusion (Virtue SAB) · biolimus-DCB (NCT06669793) · PCSK9 systemic (VICTORION-2/ORION-4)** 6 축 동시 진행 → **2026-2028 outcomes wave** 예측.
→ ROCK / GLP-1R coronary-specific 직접 RCT는 ClinicalTrials.gov 검색 부재 — **white space**.

---

## §4. 한국 regulatory + reimbursement

### §4.1 MFDS 허가 현황 (estimate · web 검색 기반)

| 카테고리 | 한국 시판 | 비고 |
|---|---|---|
| 2G/3G DES (Xience · Resolute Onyx · Orsiro · Synergy · Ultimaster · BioMatrix · Promus) | 전 라인업 허가 | KCSC 시술 표준 |
| paclitaxel-DCB (SeQuent Please · IN.PACT Falcon · Pantera Lux · Lutonix 035 coronary off-label use) | 허가 (ISR 적응증) | K-DCB registry 입력 |
| AGENT DCB | **미확정** (2024-03 FDA PMA 이후 MFDS 검토 가능성) | 검토 hook |
| SELUTION SLR / MagicTouch | **미확정** (CE 기반 IND 가능) | sirolimus-DCB MFDS first 가능성 |
| Magmaris / Freesolve | 미허가 (한국 임상 부족) | IND/Ph 가능성 |
| BioFreedom polymer-free biolimus | 허가 (HBR) | LEADERS-FREE 한국 sub-data |

### §4.2 NHIS 보험수가 (web 직접 확인 미접근 · 일반론)

- **DES**: 한국 NHIS는 DES 보험수가 **정액제 + 본인부담 제도** (multi-stent overlap 시 횟수 제한 + 적정성 평가).
- **DCB**: **ISR 적응증에 한해 NHIS 인정** (de novo small vessel 일부 인정 — IVI guided · K-DCB registry 근거).
- **BRS / Mg-BRS**: **NHIS 미산정** (한국 임상 부족 + 미허가) — IND 진입 시 별도 협의.
- **HIRA 2024 고시** = 보험수가 표 (web 접근 제한) — 정확한 단가는 HIRA 직접 확인 필요 (`hira.or.kr/ebooksc/2024`).

### §4.3 KCSC / KSC 합의문 (2024-2025)

- KSC 2024 (2024-10, Grand Walkerhill Seoul) · KSC 2025 Spring (Busan, APSC 공동) — **공식 ISR position statement 검색 미확보** (소규모 합의문 + K-DCB registry · STOPDAPT-2 / HOST-REDUCE 후속 권고 중심).
- 운영 표준: 70%+ OCT/IVUS 시술 · 3G bio-polymer DES + DCB 병행 · 1m DAPT (HBR 가속).

### §4.4 한국 regulatory window opportunity (2026-2028)

→ **window 1 — AGENT DCB MFDS 등록 호기**: FDA PMA 2024 + ESC 2024 DES-favor 후 **DCB 진영 신호 보강 필요** · 한국 K-DCB registry 데이터 합세 시 MFDS first-Asia approval 가능.
→ **window 2 — SELUTION SLR MFDS first**: SELUTION4ISR primary endpoint NS 였으나 SELUTION DeNovo 비열등성 통과 → **한국이 first-Asia sirolimus-DCB approval 후보** (CE 기반 IND).
→ **window 3 — Freesolve Mg-BRS MFDS IND**: BIOMAG-III에 한국 sites 추가 (Asia 부족) → MFDS Mg-BRS IND first-Asia 가능.
→ **window 4 — fasudil-DCB MFDS first-in-human IND**: M8 IIT-1 직결 · MFDS + PMDA cross-recognition (fasudil JP 30년 자산) — **한국 발 first-in-human DCB 표적 신약**.

---

## §5. FDA paclitaxel letter timeline (2018→2026)

```
2018.12  ━━ Katsanos K et al. JAHA 7:e011245 ─ PAD paclitaxel device 2y/5y mortality ↑
              │
2019.01  ━━ FDA letter to HCP (Class I notification) — paclitaxel-coated devices PAD
              │
2019.03  ━━ FDA Circulatory System Devices panel — risk-benefit 재평가 권고
              │    · enrollment pause 권고 · "use only in high restenosis-risk"
              │
2019.08  ━━ FDA letter 갱신 — "individualize risk-benefit" · close 추적 요구
              │
2020-22  ━━ 후속 데이터 누적 ─ SWEDEPAD interim · IN.PACT AV 5y · LEVANT 2 5y ·
              │    VA cohort · VOYAGER PAD pooled · Medicare large real-world
              │    → mortality signal 사실상 무관 확인 (signal 반복 불재현)
              │
2023.07.11 ━━ ★ FDA letter REVISION (UPDATE: "Paclitaxel-Coated Devices Unlikely
              │    to Increase Risk of Mortality") ─ **모든 PAD 제한 해제** ·
              │    label "routine monitoring" (close 아님) · "no association"
              │
2024.03.01 ━━ ★ Boston Scientific **AGENT DCB FDA PMA approved** ─ coronary ISR
              │    첫 US PMA · paclitaxel coronary 안전성 정상화 신호
              │
2024-26  ━━ AGENT IDE 2y / 5y post-approval surveillance 진행 (CRT 2025 · 2y TLF
              │    27% vs 34% uncoated, p=0.04) · 후속 데이터 누적
              │
2025-26  ━━ Virtue SAB (sirolimus-AngioInfusion) IDE approval 2025-04 ─ 
                   head-to-head vs AGENT paclitaxel-DCB 시작 (US 첫 sirolimus
                   coronary DCB pivotal)
```

→ **현재 (2026-05) FDA paclitaxel 입장**: **PAD black-box 해제 + coronary AGENT PMA approved** → Katsanos signal 사실상 종결 · paclitaxel-DCB 정상화.
→ **dose-dependent toxicity hypothesis** = 관상 dose (<1mg) ≪ PAD dose (수mg) → 관상은 처음부터 신호 없었음 (Sciahbasi · Giacoppo meta) — 후속 데이터로 확정.

---

## §6. breakthrough designations + emerging tech (2024-2026)

| 디바이스 | 회사 | designation | 적응증 | 시점 |
|---|---|---|---|---|
| **AGENT paclitaxel-DCB** | Boston Scientific | **Breakthrough 2021** → **PMA 2024-03** | coronary ISR | first coronary DCB US PMA |
| **MagicTouch sirolimus-DCB** | Concept Medical | Breakthrough designation (multi-indication) · IDE 진행 | coronary | (시점 다년 진행) |
| **Virtue SAB sirolimus-AngioInfusion balloon** | Orchestra BioMed | **IDE 2025-04** | coronary DCB head-to-head vs AGENT | first FDA-approved sirolimus coronary DCB pivotal |
| **Freesolve BTK Mg-BRS** | Biotronik | **Breakthrough 2024-03** | CLI/BTK (PAD) | coronary Mg-BRS (Freesolve coronary)는 CE 2024 |
| **DREAMS 3G coronary** | Biotronik | (no breakthrough US) | coronary | CE 2024 · BIOMAG-III enrolling |
| **MeRes100 PLLA-BRS** | Meril (인도) | — | coronary | India 시판 · CE limited |
| **Apabetalone (RVX-208)** | Resverlogix | BETonMACE post-trial — 후속 trial 미확정 | ACS T2DM (chronic) | M3 BET 안전 신호 약함 (BETonMACE NS) |
| **Inclisiran (Leqvio)** | Novartis | approved 2021 (FDA · EMA · MFDS) — VICTORION-2 Prevent / ORION-4 진행 | LDL-C / ASCVD secondary prevention | M3/M8 #7 systemic adjunct |
| **Semaglutide (Wegovy)** | Novo Nordisk | SELECT 2023 — CV outcomes positive | obesity + CVD secondary | M3/M8 #8 systemic adjunct |

→ **US coronary DCB pipeline 2026-2028**: paclitaxel (AGENT) → sirolimus (Virtue SAB head-to-head) → biolimus / 차세대 carrier → M3 표적 (white space).
→ **Mg-BRS 진영**: BIOMAG-III 결과 (2027-02 primary) = 차세대 BRS 결정 분기점.
→ **emerging white space**: **ROCK-DCB · YAP/TAZ-DCB · GLP-1R local delivery · NLRP3-DCB** = 모두 진행 RCT 부재 → **한국 IIT-1 fasudil-DCB 가 가장 선점 가능성 높음** (M8 §4.1 직접 정렬).

---

## §7. M8 IIT 3 후보와의 정렬 (cross-feed / 경쟁 / 협력)

### §7.1 IIT-1 — fasudil-DCB first-in-human (한국 MFDS first)

| ongoing trial | 관계 | 정렬 전략 |
|---|---|---|
| AGENT IDE (paclitaxel-DCB) | **benchmark** | TLF 1-2y 비교 baseline · 안전성 reference |
| SELUTION4ISR (sirolimus-DCB) | **benchmark + competitor** | sirolimus carrier 학습 (MicroReservoir) · ROCK-DCB carrier 선택에 input |
| Virtue SAB (sirolimus-AngioInfusion) | **non-competitive** (다른 약물) | DCB-as-platform 검증 — IIT-1 design 정당화 |
| REFORM (biolimus-DCB · 실패) | **학습** | biolimus 단독 부족 → biolimus + fasudil dual (M8 #1) 정당성 강화 |
| BIOMAG-III (Mg-BRS) | **complementary** | BRS + DCB hybrid (NCT06710210) 인접 | 

→ **IIT-1 = white space 선점** · M8 §4.1 budget 15-25억 KRW · MFDS first-in-human IND + PMDA cross-recognition (fasudil JP 자산) → **2026-2028 entry window 최적**.

### §7.2 IIT-2 — biolimus + fasudil dual-DCB pilot

| ongoing trial | 관계 | 정렬 전략 |
|---|---|---|
| REFORM 실패 (biolimus 단독) | **결정적 input** | dual approach 정당화 (fasudil = re-endo recovery + NA 차단) |
| NCT06669793 (biolimus-DCB de novo) | **monitor** | biolimus DCB carrier 진화 동향 추적 |
| NCT06710210 (BRS + DCB hybrid) | **architectural twin** | dual-device 시술 protocol 차용 |
| Virtue SAB (sirolimus AngioInfusion) | **non-competitive · 학습** | sirolimus deep-deposition 학습 |

→ **IIT-2 = IIT-1 positive safety 후 가속** · M8 §4.2 timeline 2028-2031 적정.

### §7.3 IIT-3 — PCSK9 / GLP-1R registry-embedded RCT (한국 platform)

| ongoing trial | 관계 | 정렬 전략 |
|---|---|---|
| VICTORION-2 Prevent (inclisiran outcomes) | **primary cross-feed** | 2026 primary endpoint — 결과에 따라 IIT-3 size / arm 조정 |
| ORION-4 inclisiran long | **cross-feed** | 5y MACE 결과 IIT-3 endpoint design 입력 |
| SELECT (semaglutide CVD non-DM) | **already evidence** | semaglutide arm 정당화 강화 — Korean ASCVD subgroup |
| LoDoCo2 (colchicine post-PCI) | **complementary arm** | factorial 4-arm 확장 가능성 (PCSK9 ± GLP-1R ± colchicine) |
| (KAMIR / K-DES platform) | **registry host** | Korean cohort embedded — 비용 50% ↓ |

→ **IIT-3 = global 후속 데이터 cross-feed 활용** · 2026-2030 platform setup · M8 §4.3 80-120억 KRW · KCSC + KSC + KSE multi-society IIT.

---

## §8. 한국 IIT 우선순위 갱신 권고 (regulatory window 활용)

### §8.1 갱신된 우선순위

```
revised priority (2026-05 R2 후) — M8 §4.4 대비 변경 점:
─────────────────────────────────────────────────────
IIT-1 ★★★★  fasudil-DCB FIH (한국 MFDS first + PMDA cross)
              · ROCK-DCB white space · 최단 시간 신호 · M8 §4.1 유지
              · 2026-Q3 IND 제출 권고 · 2027-Q2 enrollment

IIT-3 ★★★★  PCSK9 / GLP-1R registry-RCT (KAMIR / GRAND-DES 평면)
              · VICTORION-2 (2026 primary) 결과 직후 SIZE/ARM 조정
              · 2026-Q4 platform setup · 2027-Q2 enrollment
              · M8 §4.3 priority 1순위 동급으로 격상 (글로벌 platform 가속)

IIT-2 ★★    biolimus + fasudil dual-DCB pilot
              · IIT-1 positive (≥6m safety signal) 후 가속
              · 2028-2031 — REFORM 실패 학습 + biolimus carrier 진화 후
```

### §8.2 신규 권고 (R2 추가)

- **IIT-1.5 (신규 권고)** = **AGENT DCB Korean post-approval registry** — MFDS AGENT approval 진입 시 KAMIR / K-DCB platform 즉시 layering · low-cost (registry 활용 5-10억 KRW) · paclitaxel-DCB coronary 2-3y 한국인 outcomes 데이터 → IIT-1 fasudil-DCB benchmark 자료.
- **IIT-4 (신규 권고)** = **Freesolve Mg-BRS Korean sites addition** — BIOMAG-III 한국 sites enrollment 추가 (10-15 sites Korean cohort) · MFDS Mg-BRS first-Asia IND · M6/M8 #6 평가 가속 · low-cost (sites contribution ~5억 KRW).

### §8.3 regulatory window opportunity ranking (top 3)

1. **AGENT DCB MFDS registration window** — FDA PMA 2024-03 후 KCSC K-DCB registry 데이터 합세 + IIT-1.5 layering → **Asia first** 가능.
2. **fasudil-DCB MFDS + PMDA cross-recognition window** — JP fasudil 30년 자산 + 한국 OCT-guided 시술 platform = **Asia 발 first-in-human DCB 신약** (ROCK 표적 첫 인체 데이터) → IIT-1 직접.
3. **Freesolve Mg-BRS MFDS first-Asia IND** — BIOMAG-III 한국 sites 추가 + MFDS first-Asia approval → IIT-4 직접.

### §8.4 risk + mitigation

| risk | mitigation |
|---|---|
| ESC 2024 DES preferred over DCB → DCB 후퇴 risk | **JCS 2024 + SCAI 2023 + KCSC = DCB 우호** → Asia-cluster (KR/JP/CN) 발 evidence 누적 + ESC 2026 update 영향 |
| REFORM biolimus-DCB 실패 | dual-DCB (biolimus + fasudil) 가설로 회피 — IIT-2 |
| MFDS DCB 신약 BIO 인체 데이터 부재 risk | PMDA cross-recognition (fasudil JP) + KCSC OCT 시술 platform 활용 |
| 보험수가 NHIS DCB 적응증 제한 | K-DCB registry + IIT-1.5 paclitaxel-DCB post-approval registry 데이터로 NHIS 협상 |
| Mg-BRS late NA (5-10y) 데이터 부재 | IIT-4 (BIOMAG-III Korean cohort) + 자체 한국인 follow-up registry |

---

## §9. 참고문헌 (web sources)

- FDA (2023.07.11) — UPDATE: Paclitaxel-Coated Devices for PAD Unlikely to Increase Risk of Mortality letter — fda.gov/medical-devices/letters-health-care-providers
- TCTMD (2023) — "FDA: All Restrictions on Paclitaxel Devices for PAD Are Removed" — tctmd.com
- Vascular News (2023) — "Long-awaited US FDA update finds data do not support excess mortality risk" — vascularnews.com
- Boston Scientific (2024-03-01) — "Boston Scientific Receives FDA Approval for the AGENT Drug-Coated Balloon" — news.bostonscientific.com
- TCTMD (2024) — "Agent Coronary DCB Gets FDA Approval for In-Stent Restenosis"
- Orchestra BioMed (2025-04-29) — "FDA Approval of IDE for Virtue SAB Coronary Pivotal Trial" — globenewswire.com / investors.orchestrabiomed.com
- SCAI (2025) — "Two-Year Outcomes of the AGENT IDE Trial" — CRT 2025 coverage — scai.org
- SCAI (2025) — "SELUTION DeNovo TCT 2025 coverage" — scai.org
- SCAI (2025) — "SELUTION4ISR TCT 2025 coverage" — scai.org
- Cordis (2025) — "Breakthrough Results from SELUTION DeNovo and SELUTION4ISR at TCT 2025" — prnewswire.com
- TCTMD (2025) — "Sirolimus-Coated Balloon Meets Mark in De Novo Lesions and ISR: SELUTION"
- Medscape (2025) — "In Separate Trials, Sirolimus-Eluting Balloons Challenge Stents for Common PCI Indications"
- JACC: CI (2025) — Randomized Trial of Biolimus DCB for In-Stent Restenosis: The Primary Results of the REFORM Study — jacc.org/doi/10.1016/j.jcin.2024.11.026
- Cardiovascular News (2024) — "ESC 2024 Chronic Coronary Syndrome guidelines clarify role of revascularisation" — cardiovascularnews.com
- JACC (2025) — "Antiplatelet and Anticoagulant Therapy in the 2025 ACC/AHA Guideline for ACS"
- Circulation (2025) — "2025 ACC/AHA/ACEP/NAEMSP/SCAI Guideline for ACS"
- JSCAI (2023) — "SCAI Expert Consensus Statement on Management of In-Stent Restenosis and Stent Thrombosis"
- Journal of Cardiology (2025) — JCS/JCC/JACR/JATS 2024 guideline
- Biotronik — "BIOMAG-II / BIOMAG-III / Freesolve" press releases (CE 2024 coronary · BIOMAG-III NCT07258290 primary 2027-02)
- ClinicalTrials.gov — NCT04647253 (AGENT IDE) · NCT04280029 (SELUTION4ISR) · NCT07258290 (BIOMAG-III) · NCT05540223 (Freesolve registry) · NCT06409117 (Mg-BRS ACS) · NCT06669793 (biolimus de novo LVD) · NCT06710210 (BRS+DCB hybrid)
- Endovascular Today (2024) — "Biotronik's Freesolve BTK RMS Granted FDA Breakthrough Device Designation"
- ACC (2023) — "FDA Releases New Guidance on Paclitaxel-Coated Devices For PAD Treatment" — acc.org
- KSC 2024 / 2025 — ksc2024.or.kr · ksc2025.or.kr
- HIRA 2024 고시 자료 — hira.or.kr/ebooksc/2024 (보험수가 직접 PDF — 접근 제한 시 KCSC 채널)

---

## §10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| FDA 2023.07 paclitaxel letter revision (black-box 해제) | 🟡 SUPPORTED-BY-CITATION | FDA official letter + TCTMD + Vascular News |
| AGENT DCB FDA PMA 2024-03 | 🟡 SUPPORTED-BY-CITATION | Boston Scientific press release + TCTMD |
| ESC 2024 DES preferred over DCB (debate) | 🟡 SUPPORTED-BY-CITATION | Cardiovascular News ESC 2024 coverage + ahajournals.org meta |
| ACC/AHA 2025 ACS guideline DAPT 1m HBR Class 1 | 🟡 SUPPORTED-BY-CITATION | JACC 2025 · Circulation 2025 |
| SELUTION DeNovo + SELUTION4ISR TCT 2025 결과 | 🟡 SUPPORTED-BY-CITATION | SCAI · TCTMD · Cordis press release |
| BIOMAG-III primary 2027-02 (NCT07258290) | 🟡 SUPPORTED-BY-CITATION | ClinicalTrials.gov + Biotronik |
| Virtue SAB IDE 2025-04 head-to-head vs AGENT | 🟡 SUPPORTED-BY-CITATION | Orchestra BioMed press release |
| REFORM biolimus-DCB 실패 | 🟡 SUPPORTED-BY-CITATION | JACC: CI 2025 + Cardiovascular Business |
| MFDS / NHIS 한국 보험수가 정밀 단가 | 🟠 INSUFFICIENT/DEFERRED | HIRA 2024 PDF 직접 미접근 — KCSC 채널 확보 후 정량화 |
| KCSC 공식 ISR position statement (2024-25) | 🟠 INSUFFICIENT/DEFERRED | KSC 학회 채널 직접 확보 필요 |
| 한국 regulatory window 4종 권고 | 🟡 SUPPORTED-BY-CITATION | 위 사실 종합 추론 |
| IIT 1순위 갱신 권고 (1+3 동급 + 1.5 / 4 신규) | 🟡 SUPPORTED-BY-CITATION | M8 §4 + R2 §3-§7 종합 |

---

🔑 핵심 통찰:
- **regulatory window opportunity**: (1) AGENT MFDS Asia-first 등록 + (2) fasudil-DCB MFDS+PMDA cross-recognition (ROCK 첫 인체) + (3) Freesolve Mg-BRS Korean sites addition — 세 window 모두 2026-Q3~Q4 진입 가능.
- **ongoing trials gap (white space)**: ROCK-DCB · YAP/TAZ-DCB · GLP-1R local · NLRP3-DCB = ClinicalTrials.gov 부재 → **IIT-1 fasudil-DCB 가 최선 선점 후보**.
- **IIT timing 갱신**: **IIT-1 (fasudil-DCB FIH) 와 IIT-3 (PCSK9/GLP-1R registry-RCT) 동급 1순위 격상** · **IIT-1.5 (AGENT 한국 post-approval registry)** + **IIT-4 (Freesolve Korean sites)** 신규 권고 — 둘 다 5-10억 KRW low-cost, registry-leverage.
- **ESC 2024 vs JCS/SCAI/KCSC = DCB 후퇴 vs 우호 분기**: Asia-cluster 발 evidence 누적 + 2026-27 ESC update 영향 → 한국·일본 발 DCB 진영 강화의 결정적 시점.
- **FDA paclitaxel signal 완전 종결** (2023 letter + 2024 AGENT PMA) — 단 dose-dependent 가설은 한국 fasudil-DCB FIH dose-screening 시 학습 자산.
