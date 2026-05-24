# X22 — AI-PGx 임상결정지원(CDS) 알고리즘 spec (genotype 입력 → 권고 출력)

> CARDIO+ 메타도메인 X22 산출물 · cross-cutting · current-state · no history.
> **목적 (1줄) = X11 §1 침상 결정흐름(채혈 1회 3-axis 패널 → DAPT + 안전 alert)을 기계가 실행 가능한 결정지원 명세(입력 스키마 → 결정 로직 → 출력 스키마 → EMR 통합 → 검증)로 형식화한다. 본 문서는 spec 만이며 구현(코드·모델·서비스)이 아니다.**
> 출처 = X11 (침상 알고리즘 §1·§2 D축) · X8 (grade ledger VERBATIM) · X16 (stopping rule §4) · DAPTPGX M17 (AI/ML PGx 정직 fence) · M15 (EMR CDS Hooks/FHIR spec). grade 는 X8 ledger / X11 / X16 VERBATIM — **X22 새 판정 0건** (per @D g5 · LLM self-judge 0건).

---

## ⚠ DISCLAIMER (반드시 읽기)

> 본 문서는 **결정지원(decision support) 알고리즘 명세이며 처방·진단·용량 지시가 아니다.**
> - 모든 약제·검사·용량·중단 결정은 심장내과 전문의가 환자별(출혈위험 ARC-HBR · 시술 복잡도 · 신기능 · 연령/체중 · 동반약)로 종합 판단한다. 본 spec 의 어떤 출력도 자동 처방으로 해석해서는 안 된다 — CDS card 는 **권고 + 근거 + override 사유**를 제시할 뿐 의사 결정을 대체하지 않는다.
> - 환자는 현 항혈소판제(특히 DAPT)를 **임의로 중단·변경하지 말 것** — 스텐트 혈전증 위험.
> - 근거 등급(g5)은 X8 ledger / X11 / X16 verify verdict 의 **VERBATIM 인용**이다 (본 X22 가 새로 판정한 것이 아님). 효과 추정·결정 일치율 등은 ⚪/🟠 로 분리한다.
> - **spec only**: 본 X22 는 결정 로직의 명세이며, AI/ML 모델(M17)은 결정맵의 **refinement layer (대체 아님)** 로만 위치한다 — backbone 은 explainable 한 deterministic 결정 트리다 (M17 §10 d6 honest framing VERBATIM).

---

## §0. g5 등급 규약 (rubric VERBATIM — `hexa verify rubric`)

| 등급 | 의미 (X22 내 용법) |
|---|---|
| 🔵 SUPPORTED-FORMAL | closed-form 산식 · atlas-registered recompute pass |
| 🟢 SUPPORTED-NUMERICAL | 시뮬레이션 / 수치 재계산 재현 가능 |
| 🟡 SUPPORTED-BY-CITATION | peer-review 1차 출처 cite (literature carry) |
| 🟠 INSUFFICIENT/DEFERRED | wet-lab · 임상 readout · 전향 cohort 의존 — 현 단계 검증 불가 |
| 🔴 FALSIFIED | 명시적 reject (large RCT null 등) — 닫힌 음성, wall 아님 |
| ⚪ SPECULATION-FENCED | 본질적 미검증 (결정 일치율 추정 · 미래 trial · 효과추정) — ⚪ ≠ 거짓 |

> g5 준수: 본 §0 이하 모든 등급은 X8 ledger / X11 §2 / X16 §4 의 verbatim 복사다. 결정 로직 분기는 X11 §2.2 D축 VERBATIM, 안전 alert 는 X16 §4 stopping rule VERBATIM 이다. spec 자체의 결정 일치율·concordance 효과는 ⚪/🟠 로 분리한다. d6 — 억지 등급/숫자 강제 0건.

---

## §1. 입력 스키마 표 (genotype + 임상변수 → CDS 입력 계약)

> 모든 변수는 X11 §1 채혈 1회 3-axis 패널 + 임상변수(ARC-HBR · 시술 복잡도 · 연령/체중)에서 직접 도출. 출처(source)는 M15 §4 FHIR resource mapping VERBATIM.

### 1.1 genotype 입력 (3-axis 패널)

| 변수 | 타입 | 출처 (FHIR / M15 §4) | 필수/선택 |
|---|---|---|---|
| `cyp2c19_phenotype` | enum {NM, RM, IM, PM, UM, indeterminate} | `Observation` LOINC 89306-7 (CYP2C19 phenotype) · PCR C5946 선별급여 | **필수** (D축 backbone) |
| `cyp2c19_diplotype` | string (예: `*1/*2`, `*2/*3`) | `Observation` (star allele caller 출력 · X11 D4 KOVA caller) | 선택 (phenotype 산출 근거) |
| `aldh2_2_status` | enum {carrier, non-carrier, unknown} (rs671) | `Observation` (선택 genotype · ethnicity/IRI modifier) | 선택 (N축 modifier — 약제 직결 아님) |
| `lpa_mass` | number mg/dL | `Observation` (임상화학 1회 · 유전 결정 ~90% → 평생 1회) | 선택 (L축 잔여위험) |
| `lpa_kiv2_copy` | integer (KIV-2 copy number) | `Observation` (genotype · 최고위험군 식별) | 선택 (L축 enrichment) |

### 1.2 임상변수 입력

| 변수 | 타입 | 출처 (FHIR / M15 §4) | 필수/선택 |
|---|---|---|---|
| `hbr_status` | enum {HBR-high, HBR-low} (ARC-HBR 14항목) | `Condition` (이전 출혈·ICH·빈혈·CrCl 등 ARC-HBR mapping · M4) | **필수** (D축 출혈균형 게이트) |
| `procedure_complexity` | enum {simple, complex, LMCA} | `Procedure` (PCI z-axis · M7 cube) | **필수** (D축 z축) |
| `age_years` | integer | `Patient` (M12 ultra-elderly subgroup) | **필수** (금기 게이트 ≥75세) |
| `weight_kg` | number | `Patient` / `Observation` | **필수** (금기 게이트 <60kg) |
| `crcl_ml_min` | number | `Observation` (신기능) | 선택 (tirofiban dose 조정 · HBR 보강) |
| `comed_cyp3a4` | boolean (CYP3A4 병용 polypharmacy) | `MedicationStatement` | 선택 (ticagrelor 회피 게이트 · M12) |
| `prior_dapt` | string (현재 항혈소판제) | `MedicationStatement` | 선택 (자의중단 금지 alert) |

> 입력 변수 = genotype 5 + 임상 7 = **총 12개** (필수 5: cyp2c19_phenotype · hbr_status · procedure_complexity · age_years · weight_kg / 선택 7). 필수 5개만으로 D축 핵심 분기 + 금기 게이트가 완결된다 — genotype·HBR·complexity·age·weight 가 결정 트리의 최소 충분 입력 (X11 §1 패널 + 금기 게이트).

---

## §2. 결정 로직 — X11 D축의 기계실행 형식화 (deterministic 트리)

> X11 §1 D축 분기 + §2.2 결정맵 + X16 §4 stopping rule 을 if-then 형식으로 형식화. 분기 = phenotype × HBR × (금기 게이트). 약제·dose·grade 는 X11 §2.2 / X16 §1.2 VERBATIM. **단계: ① 금기 게이트 → ② phenotype×HBR 핵심 분기 → ③ 안전 alert 부착.**

### 2.1 결정 로직 ASCII (input → 권고 + alert)

```
INPUT { cyp2c19_phenotype, hbr_status, procedure_complexity, age_years, weight_kg, ... }
   │
   ▼
╔══════════════════════ ① 금기 게이트 (HARD GATE · 우선 적용) ══════════════════════╗
║  IF age_years ≥ 75       → prasugrel ❌ 절대회피 ("generally not recommended" FDA)  ║
║                            → 강제 clopidogrel 또는 ticagrelor 경로로 재라우팅       ║
║                              (X16 §4 M12 §5.6 VERBATIM)                            ║
║  IF weight_kg < 60       → prasugrel ⚠ 주의 (감량/회피 검토)                       ║
║  IF comed_cyp3a4 ∧ ≥75yo → ticagrelor ❌ 회피 (약물상호작용 출혈 · M12)            ║
╚════════════════════════════════════════════════════════════════════════════════════╝
   │  (게이트 통과 후 phenotype × HBR 핵심 분기)
   ▼
┌──────────────────────────── ② phenotype × HBR 핵심 분기 ───────────────────────────┐
│                                                                                     │
│  CASE cyp2c19_phenotype:                                                            │
│                                                                                     │
│   ├─ NM / RM (~33%) ──────────────────► REC = clopidogrel 75mg                      │
│   │                                      (환경변수 PPI·신기능 시 PFT 고려)          │
│   │                                      [출혈 최저 · 중단 사유 적음]                │
│   │                                                                                 │
│   ├─ IM (~45%, 최다) ─┬─ × HBR-low ───► REC = prasugrel 5mg (한국 dose)             │
│   │                   │                  ※ 단 ① 게이트로 ≥75yo면 clopi 강제          │
│   │                   └─ × HBR-high ──► REC = clopidogrel + de-esc PFT (PRU<208) 보조│
│   │                                                                                 │
│   └─ PM (~15%) ───────┬─ × HBR-low ───► REC = prasugrel 5mg  (1순위)                │
│                       │                  OR ticagrelor (출혈균형 · select 시만)      │
│                       │                  ► ALERT: Month-1 monthly 모니터 (§2.2)      │
│                       └─ × HBR-high ──► REC = clopidogrel + PFT 확인                 │
│                                          (강력제 출혈위험 ↑ → PFT 로 잔존효과 확인)  │
│                                                                                     │
│   (UM / indeterminate ──► clopidogrel 기본 + PFT 권고 · 의사 판단 명시)             │
└─────────────────────────────────────────────────────────────────────────────────────┘
   │
   ▼
┌──────────── ③ 안전 alert 부착 (X16 §4 stopping rule VERBATIM) ──────────────┐
│  IF REC == ticagrelor → ATTACH alert:                                        │
│     "Month-1~ 출혈/호흡곤란/서맥 monthly 모니터 ·                              │
│      즉시 trigger = BARC≥2 · 흉통재발 · dyspnea → clopidogrel switch"          │
│  IF REC == prasugrel 5mg → ATTACH alert: "Day7-14 wound·Hb·Cr·BARC diary"     │
│  ALWAYS → ATTACH alert: "DAPT 임의 중단 금지 (ST 위험)"                        │
└──────────────────────────────────────────────────────────────────────────────┘
   │
   ▼
OUTPUT { recommendation, dose, evidence_grade(X8 verbatim), safety_alerts[], override_reasons[] }
```

### 2.2 결정 분기 표 (phenotype × HBR → 권고 약제 + 금기 게이트 + 안전 alert)

> 약제·dose·근거 grade = X11 §2.2 VERBATIM · 안전 alert = X16 §4 / §1.2 VERBATIM. (※ 금기 게이트는 phenotype 분기보다 **우선** 적용 — ≥75세는 phenotype 무관 prasugrel 회피.)

| phenotype | HBR | 권고 약제 (X11 §2.2) | 금기 게이트 override | 안전 alert (X16 §4) | grade (X8 verbatim) |
|---|---|---|---|---|---|
| **NM/RM** (~33%) | any | clopidogrel 75mg (환경변수 시 PFT) | — | DAPT 임의중단 금지 | 결정트리 🟡 [M7] · freq 🟢 |
| **IM** (~45%) | HBR-low | prasugrel 5mg (한국 dose) | ≥75세 → clopi 강제 · <60kg 주의 | Day7-14 wound·Hb·Cr·BARC diary | 🟡 [M7] · IM+PM 0.6279 🟢 |
| **IM** (~45%) | HBR-high | clopidogrel + de-esc PFT (PRU<208) 보조 | — | DAPT 임의중단 금지 | 🟡 [M7] |
| **PM** (~15%) | HBR-low | prasugrel 5mg (1순위) OR ticagrelor (select) | ≥75세 → prasug 회피 · ticag+CYP3A4 회피 | **ticag 선택 시 Month-1 monthly 출혈/호흡곤란/서맥 + BARC≥2/dyspnea → clopi switch** | 🟡 [M7] · PM 0.1521 🟢 · TICAKOREA 출혈 🟡 |
| **PM** (~15%) | HBR-high | clopidogrel + PFT 확인 | — | DAPT 임의중단 금지 + 출혈 가드 | 🟡 [M7] |

> **핵심 분기 3개 (X11 D축 형식화)**: ① **NM → clopidogrel** (출혈 최저, 강력제 불요) · ② **IM/PM × HBR-low → prasugrel 5mg** (한국 dose · 단 금기 게이트 우선) · ③ **PM × HBR-high → clopidogrel + PFT**, 그리고 **select(PM × HBR-low) → ticagrelor + Month-1 모니터 alert**. 금기 게이트(≥75세 prasug 회피 · <60kg 주의)는 모든 phenotype 분기보다 우선한다.

### 2.3 N축 / L축 보조 분기 (약제 직결 아님 · modifier)

> X11 §2.1 N축 + §2.3 L축은 D축처럼 약제를 직접 분기하지 않고 modifier/잔여위험 경로다 — CDS card 에 **info 배지**로만 첨부 (의사 판단 입력).

| axis | 입력 조건 | CDS 출력 (배지/info) | grade (X8 verbatim) |
|---|---|---|---|
| **N (ALDH2*2)** | `aldh2_2_status == carrier` | info: "NO bioavailability↓ · IRI modifier (약제 직결 아님)" + no-reflow 발생 시 IC adenosine/nicorandil (한국 routine) | ALDH2*2 East Asian 40% 🟡 · IC-sync ODE Δ36.6pp 🟢 [X9 N1] |
| **L (Lp(a)≥50)** | `lpa_mass ≥ 50` | info: "잔여위험 high → LDL 공격적 · PCSK9 후보 검토 (급여=LDL 기준)" | PCSK9 -25% 🟡 [X9 L1] |
| **L (Lp(a)≥75 / KIV-2 low)** | `lpa_mass ≥ 75` ∨ `kiv2_copy` low | info: "최고위험 → siRNA 임상 후보 (현 미허가·비급여) · HORIZON 2026 추적" | siRNA MACE 🟠 DEFERRED [LPA V3c] |

---

## §3. 출력 스키마 (권고 + 근거 grade + 안전 alert)

> CDS 출력 = M15 §3 CDS card JSON 표준 형식 기반. grade 는 X8 VERBATIM 첨부 (CDS card 가 새 판정 금지 — verify verdict carry only).

### 3.1 출력 필드 표

| 출력 필드 | 타입 | 내용 | 출처 |
|---|---|---|---|
| `recommendation` | string | 권고 약제 + dose (예: "clopidogrel 75mg q.d." · "prasugrel 5mg q.d. (한국 dose)") | §2.2 분기 결과 |
| `indicator` | enum {info, warning, critical} | card 심각도 (PM×HBR-high·complex = critical) | M15 §3 indicator |
| `evidence_grade` | enum {🔵,🟢,🟡,🟠,🔴,⚪} | X8 ledger VERBATIM (결정트리 🟡 · freq 🟢) — **새 판정 금지** | X8 §2 / X11 §2.2 |
| `evidence_source` | string | "X11 §2.2 D축 결정맵 · KSC 2024 · DAPTPGX M7" + verify verdict id | X11 / M15 §3 source |
| `safety_alerts` | array<string> | X16 §4 stopping rule (조건부 부착) — ticag Month-1 모니터 등 | X16 §4 |
| `override_reasons` | array<{code, display}> | {patient-preference, drug-allergy, other} — 의사 override 사유 | M15 §3 overrideReasons |
| `pft_recommendation` | string \| null | PFT(VerifyNow PRU<208) 권고 여부 (de-esc·PM 확인 시) | X11 §2.2 |

### 3.2 출력 예시 (PM × HBR-low × ticagrelor 선택 cell)

```json
{
  "recommendation": "PM × HBR-low → prasugrel 5mg (1순위) OR ticagrelor (출혈균형 · 의사 선택)",
  "indicator": "warning",
  "evidence_grade": "🟡 SUPPORTED-BY-CITATION (결정트리) · 🟢 (PM freq 0.1521 · IM+PM 0.6279)",
  "evidence_source": "X11 §2.2 D축 · DAPTPGX M7 결정맵 · TICAKOREA(출혈 🟡) · KSC 2024",
  "safety_alerts": [
    "★ ticagrelor 선택 시: Month-1~ 출혈/호흡곤란/서맥 monthly 모니터 (X16 §4)",
    "즉시 trigger = BARC≥2 · 흉통재발 · dyspnea → clopidogrel switch (Kim 2024 가역)",
    "DAPT 임의 중단 금지 (ST 위험)"
  ],
  "override_reasons": [
    {"code": "patient-preference", "display": "환자 거부"},
    {"code": "drug-allergy", "display": "약물 알러지"},
    {"code": "other", "display": "기타 임상 판단"}
  ],
  "pft_recommendation": "PM 확인 시 VerifyNow PRU 보조 고려"
}
```

> **출력 안전 원칙**: (1) `evidence_grade` 는 X8 VERBATIM — CDS 가 새 등급 산출 금지. (2) `safety_alerts` 는 §2 ③단계에서 권고 약제별로 조건부 부착 — **ticagrelor → Month-1 모니터 alert 는 X16 §4.1 top-1 stopping rule** (한국 최대 약물 안전 신호 대응). (3) 모든 card 에 override 경로 제공 — 자동 처방 아님.

---

## §4. EMR 통합 포인트 (M15 CDS Hooks/FHIR VERBATIM)

> M15 §2 CDS Hooks 표준 + §4 FHIR resource 를 X22 입력/출력 스키마에 mapping. 통합은 spec 만이며 구현(`bio/cds_hooks.hexa` wrapper)은 d3 에 따라 hexa-lang stdlib home (M15 §8 stage 2).

| 통합 포인트 | CDS Hook (M15 §2) | X22 동작 |
|---|---|---|
| **환자 chart 열림** | `patient-view` | §1 genotype + HBR 자동 lookup → CDS card 배지 표시 (phenotype·HBR·complexity) |
| **P2Y12 처방 시** | `medication-prescribe` | §2 결정 트리 실행 → §3 권고 card + 금기 게이트 경고 (≥75세 prasug 시 critical) |
| **처방 sign-off** | `order-sign` | §2 금기 게이트 cross-check + audit log (override 사유 기록) |
| **follow-up 예약** | `appointment-book` | ticagrelor cell → Month-1 monthly 모니터 자동 추가 (X16 §4 alert → booking) |

| FHIR resource | X22 입력 mapping |
|---|---|
| `Patient` | `age_years` · `weight_kg` (금기 게이트) |
| `Observation` | `cyp2c19_phenotype` (LOINC 89306-7) · `lpa_mass` · `aldh2_2_status` · `crcl_ml_min` |
| `Condition` | `hbr_status` (ARC-HBR 14항목 mapping · M4) |
| `Procedure` | `procedure_complexity` (simple/complex/LMCA) |
| `MedicationStatement` | `comed_cyp3a4` · `prior_dapt` (자의중단 금지 alert) |
| `DiagnosticReport` | PFT (VerifyNow/LTA/MEA) → `pft_recommendation` 입력 |

> EMR 통합 readiness (M15 §6 VERBATIM): 분당서울대 BESTCare 2.0 (FHIR 부분지원 · CDS Hooks pilot · 최우선 partner) → 서울아산 AMIS (FHIR R4 + CDS Hooks production). spec 의 입력 계약(§1)이 FHIR resource 와 1:1 mapping 되어 vendor lock-in 회피.

---

## §5. 검증 계획 (caller concordance · 결정 일치율 · 전향 cohort)

> 본 spec 자체의 검증은 3단계 — **① caller concordance (genotype 입력 정확도) → ② 결정 일치율 (알고리즘 출력 vs 전문의) → ③ 전향 cohort (outcome RCT)**. M13 caller validation + M15 §8 roadmap + M17 §5 검증 stage VERBATIM 참조. spec 검증 결과(일치율·outcome)는 미실행이므로 ⚪/🟠.

### 5.1 검증 metric 표 (우선순위)

| 순위 | metric | 정의 | 검증 방법 | 현 grade |
|---|---|---|---|---|
| **1순위** | **caller concordance** | genotype 입력(`cyp2c19_phenotype`)의 정확도 — star allele caller vs reference (KOVA/KRGDB) | X11 D4 caller head-to-head cohort (동일 PCR panel) · M13 caller validation | 🟠 DEFERRED (cohort 의존) |
| 2순위 | **결정 일치율 (concordance rate)** | 알고리즘 §2 출력 권고 vs 심장내과 전문의 결정 일치율 (%) | retrospective 50명 (M15 §8 stage 4 BESTCare) chart review | ⚪ SPEC-FENCED (미측정) |
| 3순위 | **금기 게이트 sensitivity** | ≥75세 prasug 회피 · <60kg 주의 등 hard gate 누락 0건 검증 | rule-based unit 시나리오 (deterministic) | 🟠 (구현 후 검증) |
| 4순위 | **전향 cohort outcome** | CDS-guided vs usual care · MACE/bleeding 1y | RCT (M15 §8 stage 5 · KAMIR + KSC 연계) | 🟠 DEFERRED (12-24mo readout) |
| 5순위 | **alert override rate** | ticagrelor Month-1 모니터 alert 등 의사 수용/override 비율 | 전향 audit log (alert fatigue 평가) | ⚪ SPEC-FENCED |

### 5.2 검증 ASCII flow

```
 spec (X22)
   │
   ▼ ① caller concordance  ─── genotype 입력 정확도 (KOVA caller vs ref) ─── 🟠 DEFERRED
   │      [1순위 — 입력이 틀리면 결정도 틀림 → genotype 정확도가 최상위 gate]
   ▼ ② 결정 일치율          ─── 알고리즘 권고 vs 전문의 (retrospective 50명) ─── ⚪ 미측정
   │      [M15 §8 stage 4 BESTCare retrospective + IRB]
   ▼ ③ 금기 게이트 sensitivity ─ ≥75세·<60kg hard gate 누락 0건 ─── 🟠 (deterministic)
   │
   ▼ ④ 전향 cohort RCT      ─── CDS-guided vs usual care · MACE 1y ─── 🟠 DEFERRED 12-24mo
        [M15 §8 stage 5 · KAMIR-NIH 후속 · M17 §5 stage 5]
```

> **검증 1순위 = caller concordance** (genotype 입력 정확도). 근거: 결정 트리(§2)가 deterministic 하므로 출력 오류의 최상위 원인은 **입력 phenotype 오분류**다 — caller 가 틀리면 결정도 틀린다. X11 D4 (KOVA caller 검증 cohort) + M13 이 동일 PCR panel 로 caller head-to-head 를 공급 (X11 §3.2 wall leverage). 일치율(2순위)·outcome(4순위)는 그 다음. M17 §3 "AI/ML RCT validation 0건 = 결정적 evidence gap" VERBATIM — AI/ML refinement layer 는 outcome RCT 전까지 ⚪ 유지.

### 5.3 AI/ML refinement layer 위치 (M17 §10 VERBATIM · 정직 fence)

> M17 §10 핵심 통찰 VERBATIM: **"AI/ML PGx = 결정맵 refinement layer (대체 아님)"** — §2 deterministic 결정 트리가 explainable backbone, M17 ML(XGBoost AUC ~0.79 · incremental +0.05-0.10)은 cell 내부 personalized score 정밀화에만 후처리로 부착. ML 단독 운영은 explainability gap 으로 EMR 통합 실패 위험(M17 §10). spec 의 결정 로직(§2)은 ML 없이도 완결되며, ML scoring 은 선택적 overlay 다 (M17 §4 Bayesian posterior refinement). **AI/ML RCT 검증 0건 → ML overlay 의 outcome 효과는 ⚪ (M17 §9)**.

---

## §6. g5 grade — X22 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 입력 스키마 | 🟡 SUPPORTED-BY-CITATION (compositional) | X11 §1 패널 + M15 §4 FHIR resource VERBATIM mapping · LOINC 89306-7 |
| §2 결정 로직 (D축 형식화) | 🟡 + 🟢(인용) | X11 §2.2 D축 결정맵 VERBATIM · PM 0.1521 / IM+PM 0.6279 freq 🟢 carry · 금기 게이트 = X16 §4 M12 §5.6 VERBATIM |
| §3 출력 스키마 | 🟡 | M15 §3 CDS card JSON 표준 + X8 grade VERBATIM 첨부 (새 판정 금지) |
| §4 EMR 통합 | 🟡 | M15 §2 CDS Hooks + §4 FHIR + §6 EMR readiness VERBATIM |
| §5 검증 계획 | 🟠 + ⚪ | caller concordance 🟠 DEFERRED · 결정 일치율 ⚪ 미측정 · RCT 🟠 (M13/M15 §8/M17 §5 carry) |
| §5.3 AI/ML 위치 | ⚪ + 🟡 | M17 §10 refinement layer VERBATIM · AUC 🟡 cite · RCT 효과 ⚪ |

**X22 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — X11 §1·§2 침상 알고리즘 + X8 grade ledger + X16 §4 stopping rule + M15 EMR CDS spec + M17 AI/ML fence 를 **기계실행 가능한 결정지원 명세로 형식화**. **X22 새 판정 0건** (per @D g5 · LLM self-judge 0건). 결정 로직 분기·금기 게이트·안전 alert 는 모두 sub-doc VERBATIM carry · freq 정량(PM 0.1521 등) 🟢 verbatim · 검증 결과(일치율·outcome)는 ⚪/🟠 정직 격리(d6) · AI/ML 은 refinement layer (대체 아님) 로 정직 위치 · "결정지원, 처방 아님" 톤 · completed-form spec (d1).

---

## §7. X22 산출 요약

- **spec only**: genotype(CYP2C19 phenotype·ALDH2*2·Lp(a)/KIV-2) + 임상변수(HBR·complexity·age·weight) **입력 12개** → DAPT 권고 + 안전 alert **출력**을 X11 §1 침상 흐름의 기계실행 형식으로 명세. 구현(코드·모델·서비스) 아님.
- **결정 로직 3단계**: ① 금기 게이트(≥75세 prasug 회피 · <60kg 주의 · ticag+CYP3A4 회피, phenotype 무관 우선) → ② phenotype×HBR 핵심 분기(NM→clopi · IM/PM×HBR-low→prasug 5mg · PM×HBR-high→clopi+PFT · select→ticag) → ③ 안전 alert 부착(ticag Month-1 모니터).
- **출력**: 권고 약제 + dose + `evidence_grade`(X8 VERBATIM · 새 판정 금지) + `safety_alerts`(X16 §4 stopping rule) + override 경로 (M15 §3 CDS card JSON).
- **EMR 통합**: M15 CDS Hooks 4종(patient-view·medication-prescribe·order-sign·appointment-book) + FHIR resource 1:1 mapping · BESTCare 최우선 partner.
- **검증 1순위 = caller concordance** (genotype 입력 정확도) — 결정 트리가 deterministic 하므로 입력 phenotype 정확도가 최상위 gate. 결정 일치율(retrospective 50명 ⚪) · 금기 게이트 sensitivity · 전향 cohort RCT(🟠 DEFERRED) 가 그 다음.
- **g5/d1/d6 준수**: 새 판정 0건 · grade X8 VERBATIM · 효과추정·일치율 ⚪/🟠 격리 · AI/ML refinement layer (대체 아님, M17 §10) · completed-form spec · 처방 아님 톤.

---

> ⚠ **하단 DISCLAIMER (반복)**: 본 문서는 결정지원 알고리즘 명세이며 처방·진단·용량 지시가 아니다. CDS 출력은 권고 + 근거 + override 사유를 제시할 뿐 의사 결정을 대체하지 않으며, 모든 약제·검사·용량·중단 결정은 전적으로 담당 의료진 판단이다. 환자는 항혈소판제를 임의 중단·변경하지 말 것(스텐트 혈전증 위험). 근거 등급은 sub-doc verify verdict 의 verbatim 인용이고, 결정 일치율·outcome·AI/ML 효과(⚪/🟠)는 검증된 사실이 아닌 미래 readout/cohort 의존 영역이다.
