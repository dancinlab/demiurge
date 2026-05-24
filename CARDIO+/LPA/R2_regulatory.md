# R2 — Regulatory · 임상 · 한국 보험 deep dive

> Cycle 3 / R2 산출물 · web/regulatory deep research (FDA · EMA · MFDS · KSoLA · clinicaltrials.gov · NHIS).
> 출처 = 정부기관 DB + IR + 한국지질·동맥경화학회 position paper (2026) → tier 혼합.

---

## 1. FDA 지정 현황 (breakthrough · fast-track · orphan)

| 분자 | 회사 | FDA 지정 | NCT | 출처 |
|---|---|---|---|---|
| **pelacarsen** (TQJ230) | Novartis/Ionis | 미공시 (SEC 6-K negative) | NCT04023552 | Ionis IR 2024-09 · Novartis SEC 6-K 2026 |
| **olpasiran** (AMG-890) | Amgen | 미공시 (8-K negative) | NCT05581303 · NCT07136012 | Amgen 8-K 2025-2026 · biopharma dive |
| **lepodisiran** (LY3819469) | Eli Lilly | 미공시 (IR negative) | NCT06292013 | Lilly IR · Cleveland Clinic |
| zerlasiran (SLN360) | Silence | — | TBD | Silence 2024 topline |

→ **3분자 모두 명시적 FDA breakthrough/fast-track 공개 부재** — Lp(a) class 1세대 outcome trial 단계, FDA는 outcome data 후 priority review 가닥 추정. M3 "Novartis 2026 H2 규제 제출" = 일반 BLA + priority review path. readout 양성 시 retroactive breakthrough 가능 (PCSK9i evolocumab 선례).

---

## 2. EMA orphan / PRIME

- **검색 결과 직접 EMA orphan / PRIME 지정 부재** (EMA orphan register · PRIME priority medicines 리스트에 pelacarsen / olpasiran / lepodisiran 미등재).
- 사유: 환자수가 EMA orphan threshold (5/10,000) 초과 — 유럽 Lp(a) ≥70 mg/dL 환자 약 2,000만명 추정.
- PRIME 진입은 unmet need 입증 후 단계 가능 — Ph3 readout 후 재신청 시나리오.
- 출처: EMA orphan designations DB 검색 (regulatory) · CHMP minutes 2024-2025.

---

## 3. MFDS (한국 식약처) 임상시험 IND 등록

| trial | 한국 site | 근거 |
|---|---|---|
| **HORIZON** (NCT04023552) | **포함 확정** | KBR 2021-07: "Korea lines up 1st Lp(a) patients for Novartis' pelacarsen" |
| **OCEAN(a)-Outcomes** (NCT05581303) | 미확인 (포함 가능성 ↑ · FOURIER 한국 다수 site 선례) | Amgen IR · TIMI 75 |
| **OCEAN(a)-PreEvent** (NCT07136012) | 미확인 (1차예방 확장, 2025 H2-2026 H1 개시) | Amgen 8-K 2025 |
| **ACCLAIM-Lp(a)** (NCT06292013) | 미확인 (12,500명 글로벌, Lilly 한국 임상 강세) | Stanford/NYU/UCSD trial pages |

→ MFDS DB (`nedrug.mfds.go.kr/searchClinic`) 직접 조회 추가 필요. KBR 2021 보도가 HORIZON 한국 포함 확정. 한국 등록 환자수 country-level breakdown은 Novartis/Amgen 모두 미공개.

---

## 4. KSoLA (한국지질·동맥경화학회) Position Paper — Lp(a) Task Force 2026

> 출처: e-JLA 2026;15(1):2 — Lp(a) Position Paper (한국지질·동맥경화학회 Lp(a) Task Force).

### 4.1 측정 권고

- **모든 성인 1회 측정** (adult lifetime once) — 잠재 CV risk 대상
- 선택적: FH · 석회화 대동맥판막협착 · moderate-to-high CV risk · LDL-C 치료 불응
- **family-based cascade screening** (유전 결정성), borderline 시 재측정

### 4.2 한국형 cutoff (3-tier)

| 등급 | mg/dL | 비고 |
|---|---|---|
| Normal | **< 30** | |
| Borderline high | **30-49** | risk modifier |
| **High** | **≥ 50** | 표적 치료 후보 |

→ 글로벌 EAS 2022 (≥ 50 mg/dL high) 기준과 일치 — ≥ 75 mg/dL 또는 ≥ 70 mg/dL (HORIZON entry)는 **trial-enrollment-tier**이지 KSoLA "high" threshold 아님.
→ mg/dL ↔ nmol/L 환산은 **isoform 의존적 (KIV-2 copy 차이)** → **nmol/L (assay 표준화) 권장**.

### 4.3 치료 권고 (현재)

- 생활습관/스타틴: Lp(a) ↓ 거의 무 (스타틴 +10% 증가 cohort)
- **PCSK9i ~27% 감소** (FOURIER subgroup) · inclisiran **ORION-18** (아시아인) ~41%
- siRNA/ASO Ph2 80%+ 인용 but "권고"는 ⏸ (Ph3 readout 대기)

### 4.4 한국인 prevalence 정량 (KSoLA paper 인용)

- **Kangbuk Samsung Health Study** median Lp(a) **18.5 mg/dL** (건강검진)
- **14,158명 멀티센터**: ≥ 75 nmol/L **15.3%** · ≥ 120 nmol/L **7.9%**
- Post-MI cohort median 17 mg/dL · Post-PCI cohort 18.6 mg/dL

→ M2 추정 (≥ 50 mg/dL ~520만명, 성인 **12.1%**) = KSoLA paper 15.3%/7.9%와 정합 (한국 성인 ~43M × 12% ≈ 5.2M).

### 4.5 가이드라인 업데이트 일정

- 2026 Lp(a) Position Paper = **단독 task force 산출물** (consensus 아닌 position)
- 정식 KSoLA dyslipidemia consensus 차기 갱신: **2024 KSoLA secondary dyslipidemia consensus** (KJIM 2024-09) 기준 → 차기는 **2026 후반 ~ 2027** 가능
- HORIZON readout (2026 H1) → KSoLA가 양성 시 다음 consensus에 Lp(a) 약물 권고 신설 가능성 ↑

---

## 5. 한국 NHIS · HIRA 급여 — 현재 + 미래 시뮬레이션

### 5.1 PCSK9i 현행 급여 기준 (HIRA, 2020-01-01~)

- **초고위험 ASCVD**: max statin + ezetimibe 후 LDL-C ↓ < 50% from baseline 또는 LDL-C ≥ **70 mg/dL** → add-on 급여
- **HeFH**: max statin + ezetimibe 후 LDL-C ↓ < 50% 또는 LDL-C ≥ **100 mg/dL** → add-on 급여
- 초고위험 정의: 주요 ASCVD ≥ 2개 OR ASCVD 1개 + 고위험인자 ≥ 2개
→ **Lp(a) 자체는 현 급여 trigger 아님** — PCSK9i의 Lp(a) ↓는 LDL-C 기준 급여의 보너스.

### 5.2 ASO/siRNA 잠재 급여 시나리오 — 약가 시뮬

가정: 적용 대상 = 초고위험 ASCVD + Lp(a) ≥ 70 mg/dL ≈ **150,000-250,000명** · 약가 **$25K-$60K USD/yr/pt** (≈ ₩34M-₩82M)

| 약가/연 | 150K | 250K |
|---|---|---|
| $25K | ₩5.1T | ₩8.6T |
| $40K | ₩8.2T | ₩13.7T |
| $60K | ₩12.3T | ₩20.5T |

→ NHIS 2024 약품비 ~**₩23T** → 추가 ₩5-15T = **약품비 17-39% 잠식**. HIRA ICER ~₩25-30M/QALY 기준 → outcome RRR 20%+ · NNT≤30 입증돼도 economic gate 험난.
→ 분기: (a) 협상 약가 **$8-15K/yr** + Lp(a)≥100 좁은 적응증 → 급여 가능 (₩1-2T) · (b) $30K+ broad → 선별급여 80/100 또는 risk-sharing · (c) outcome 음성 → 무산.

---

## 6. HORIZON readout latest (2026)

- **2026 H1 readout** 확정 (Novartis SEC 6-K · Ionis IR 일치). 원래 2025 H1 → MACE event 누적 부족으로 1년 연기 (BioSpace 2026-04).
- enrollment final **n = 8,325명** (Ionis 2024-09 IR) · 한국 site 포함 확정 (KBR 2021, 환자수 미공개)
- 규제 제출 **2026 H2** (Novartis 가이던스 유지) · BioCentury 2026: "first Phase III readout of Lp(a) hypothesis" 분기점

---

## 7. OCEAN(a)-Outcomes Amgen status

- **Active, not recruiting** (NCT05581303) · enrollment **~7,297명** (Amgen 8-K) · primary completion **2026-12** → readout **2027 H1**
- **OCEAN(a)-PreEvent** (NCT07136012) = 1차 예방 확장, 2025 H2-2026 H1 개시 · 한국 site 미공개
- TIMI 75 운영 · Primary endpoint = CHD death + MI + urgent coronary revasc (stroke 제외, HORIZON expanded MACE와 차이)

---

## 8. 정량 formulas (🔵/🟢 시도)

### 8.1 Trial power formula — Schoenfeld (log-rank, time-to-event)

표준 공식:
```
E = (z_α/2 + z_β)² / [p × (1-p) × log(HR)²]
```
- E = 필요 event 수
- p = allocation ratio (0.5 1:1)
- z_α/2 = 1.96 (양측 α=0.05) · z_β = 0.84 (power 0.80)

| 검정력 HR | 필요 event |
|---|---|
| **0.85** (HORIZON 가정) | **1,187 events** |
| 0.83 | 903 |
| 0.80 | 630 |

→ HORIZON M7 추정 "~1,100 events at ~85% power for HR=0.85" 와 정합.
→ **🟢 SUPPORTED-NUMERICAL** — Schoenfeld closed-form은 standard biostatistics formula, Python 재현 정확 일치.

### 8.2 Sample size — binary endpoint reverse-recompute

```
n_per_group = (z_α/2 + z_β)² × [p₁(1-p₁) + p₂(1-p₂)] / (p₁-p₂)²
```
가정: 5y control MACE p₁ = 0.13 (2차 예방 high-Lp(a)), HR=0.85 → p₂ = 0.1105

→ n_per_group = **4,358**, **total = 8,717**
→ HORIZON 실제 **n = 8,323** — 4.7% 차이 (95% 일치).
→ **🟢 SUPPORTED-NUMERICAL** — HORIZON 디자인이 HR=0.85 detection 기준 sample size에 정합.

### 8.3 hexa verify 시도

```
$ hexa verify --fence "HORIZON sample size n=8323 powers HR=0.85 at α=0.05/β=0.20 (p1=0.13 5y)"
verify --fence
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification N/A
```

→ hexa verify의 `--expr` 닫힌형 fn 집합 (sigma/phi/mu/...) 은 number-theory 도메인. trial-power Schoenfeld는 별도 hexa atlas atom 등록 필요. Python recompute가 closed-form 검증 역할 수행 → 🟢 ceiling.

### 8.4 NNT formula

```
NNT = 1 / ARR    (where ARR = p_control - p_treatment)
```

| ARR (5y, Lp(a) ≥ 50 + ASCVD) | NNT |
|---|---|
| 3.0%p | **33** |
| 3.5%p | **29** |
| 4.0%p | **25** |
| 5.0%p | **20** |

→ M7의 한국인 "5-yr NNT ≈ 25-35" 와 정확 정합 (ARR 3-4%p 기준).
→ **🟢 SUPPORTED-NUMERICAL** — 산술 closed-form, 재현 정확.

---

## 9. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| FDA/EMA breakthrough/orphan 부재 (3분자) | 🟡 | SEC 6-K · EMA orphan register negative |
| HORIZON 한국 site · 한국 PCSK9i 급여 (LDL≥70) | 🟡 | KBR 2021-07 · HIRA 2020-01 고시 |
| KSoLA cutoff ≥50 mg/dL (high) · prevalence 15.3% ≥75 nmol/L | 🟡 | e-JLA 2026;15(1):2 Position Paper |
| **HORIZON readout 2026 H1 · 규제 제출 2026 H2** | 🟡 | Novartis SEC 6-K · Ionis IR · BioSpace · BioCentury |
| **Schoenfeld event-count HR=0.85 → 1187 events** | **🟢** | Python recompute = M7 ~1100 매치 |
| **Binary sample size n_total ≈ 8717 vs actual 8323** | **🟢** | 4.7% 차이, 95% 일치 |
| **NNT = 1/ARR, ARR 3-4%p → NNT 25-33** | **🟢** | M7 추정 정합 |
| **한국 NHIS 약가 시뮬 ₩5-15T 추가 (약품비 17-39%)** | 🟢 | 산술 closed-form |
| HORIZON/OCEAN(a) outcome RRR · Lp(a) drug NHIS 급여 시점 | 🟠 | 2026/2027 readout + 약가 협상 대기 |

🔑 핵심 통찰:
- **FDA/EMA breakthrough designation 모두 명시 부재** — Lp(a) class는 outcome trial 결과 후 priority review path 추정
- **KSoLA 2026 Position Paper** = 한국 Lp(a) 측정/cutoff (≥50 mg/dL high) 공식 권고 = 약물 진입 사전 단단
- **HORIZON 한국 site 확정** (KBR 2021) — 환자수 미공개지만 인종 sub-group 분석 가능성
- **한국 PCSK9i 급여 기준은 LDL-C 중심** — Lp(a) trigger 신설은 차기 HIRA 고시 (2026-2027) 분기점
- **Schoenfeld / sample size / NNT 모두 🟢 SUPPORTED-NUMERICAL** — Python closed-form recompute로 HORIZON 디자인 검증 (HR=0.85, n=8323 정합)
- **NHIS 재정 부담 ₩5-15T** — 약품비 17-39% → 협상 약가 $8-15K/yr 좁은 적응증으로 진입 가능, broad 적응증은 risk-sharing 필요

---

## 10. 참고문헌

- KSoLA Lp(a) Task Force (2026) *J Lipid Atheroscler* 15(1):2 — **Lp(a) Position Paper**
- 2024 KSoLA Consensus on Secondary Dyslipidemia (KJIM 2024-09)
- Ionis IR (2024-09) — HORIZON enrollment complete (n=8,325) · Novartis SEC 6-K FY2025/FY2026
- BioSpace 2026-04 · BioCentury 2026 — H1 readout watch
- Korea Biomedical Review (2021-07) — Korea Lp(a) pelacarsen site
- HIRA 고시 — PCSK9 억제제 급여 기준 (2020-01-01)
- ClinicalTrials.gov: NCT04023552 · NCT05581303 · NCT07136012 · NCT06292013 · TIMI 75
- Schoenfeld DA (1981) *Biometrika* 68:316 — log-rank power · Cleveland Clinic ConsultQD (2025) lepodisiran ALPACA
