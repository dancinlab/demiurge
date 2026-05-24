# X11 — 통합 한국 PCI layered-care 프로토콜 (단일 침상 결정 알고리즘)

> CARDIO+ 메타도메인 X11 산출물 · current-state · no history.
> **목적 = 한국 PCI 환자 1명이 입원→primary PCI→유전자패널→층화치료→추적까지 거치는 4축(no-reflow · CYP2C19 DAPT · ISR · Lp(a))을 별개 문서가 아닌 하나의 coupled 침상 결정 흐름으로 통합한다 — 모든 분기가 "채혈 1회 3-axis 패널 (ALDH2\*2 × CYP2C19 LoF × Lp(a)/KIV-2)" 한 지점에서 갈라진다.**
> 출처 = X5 (4-trial portfolio) · X6 (4-axis 개인적용) · X7 (thesis + 4-track) · X9 (3-axis 시너지 §5 · wall map) + DOCTOR H2(no-reflow) · H3(DAPTPGX) · H4(ISR) · H5(LPA). grade 는 X8 ledger VERBATIM.

---

## ⚠ DISCLAIMER (반드시 읽기)

> 이 문서는 **의사결정 지원(decision support) 자료이며 처방·진단·용량 지시가 아니다.**
> - 모든 약제·검사·용량은 심장내과 전문의가 환자별(출혈위험 ARC-HBR · 시술 복잡도 · 신기능 · 동반약 · 동반질환)로 종합 판단한다. 본 문서의 어떤 수치도 처방으로 해석해서는 안 된다.
> - 환자는 현 항혈소판제(특히 DAPT)를 **임의로 중단·변경하지 말 것** — 스텐트 혈전증 위험.
> - 근거 등급(g5)은 CARDIO+ 4 sub-domain verify verdict 의 **VERBATIM 인용**이다 (본 X11 이 새로 판정한 것이 아님 · LLM self-judge 0건). 효과 추정은 ⚪ proposal / 연구단계로 라벨했다.

---

## §0. g5 등급 규약 (rubric VERBATIM — `hexa verify rubric`)

| 등급 | 의미 (X11 내 용법) |
|---|---|
| 🔵 SUPPORTED-FORMAL | closed-form 산식 · atlas-registered recompute pass |
| 🟢 SUPPORTED-NUMERICAL | 시뮬레이션 / 수치 재계산 재현 가능 |
| 🟡 SUPPORTED-BY-CITATION | peer-review 1차 출처 cite (literature carry) |
| 🟠 INSUFFICIENT/DEFERRED | wet-lab · 임상 readout · IPD 의존 — 현 단계 검증 불가 |
| 🔴 FALSIFIED | 명시적 reject (large RCT null 등) — 닫힌 음성, wall 아님 |
| ⚪ SPECULATION-FENCED | 본질적 미검증 (가치판단 · 미래 trial · prognostic · metaphor) — ⚪ ≠ 거짓 |

> g5 준수: 본 §0 이하 모든 등급은 X8 ledger / 4 sub-V verdict 의 verbatim 복사다. 효과 추정(결정맵 ST↓X% · siRNA -80% · DCB LLL↓ 등)은 전부 ⚪/🟠 로 분리한다. d6 준수 — 억지 등급/숫자 강제 0건.

---

## §1. 메인 ASCII 결정흐름도 — STEMI 도착 → 추적 (단일 coupled 경로)

> 핵심 = primary PCI 중의 **no-reflow 분기**와, PCI 직후 **채혈 1회 3-axis 패널**에서 출발하는 DAPT + ISR + Lp(a) 3개 경로가 **하나의 흐름**으로 묶인다. 한국인은 ALDH2\*2(~40%) × CYP2C19 LoF(IM+PM ~60%) × Lp(a) high(~12-13%)를 동시에 가질 확률이 비-동아시아 대비 현저히 높아, 이 단일 패널이 N+D+L 도메인을 한 점에서 stratify 한다 (X9 §5).

```
╔══════════════════════════════════════════════════════════════════════════════════════╗
║  한국 STEMI 환자 1명 · 단일 coupled 침상 결정 흐름 (입원 → 추적)                        ║
╚══════════════════════════════════════════════════════════════════════════════════════╝

 [0m] STEMI 도착 / activation
        │  · 표준 loading (aspirin + P2Y12 — 결과 전이라 통상 clopidogrel/ticagrelor)
        │  · STEMI activation 시 nicorandil PO 10mg loading + IV 4mg bolus 고려 (한국 보험 routine)  [H2 Tier-A]
        ▼
 [0m] primary PCI (관상동맥 재관류)
        │
        ▼
   ┌────────────────────── no-reflow 분기 (N축 · IRI/MVO) ──────────────────────┐
   │  재관류 후 TIMI flow 평가                                                    │
   │     │                                                                        │
   │     ├─ TIMI 3 (정상 flow) ──► no-reflow 중재 불요, 표준 진행                  │
   │     │                                                                        │
   │     └─ TIMI ≤2 (no-reflow / slow-flow) ──► IC vasodilator 즉시              │
   │            · adenosine IC 24mg distal microcatheter (4mg split, 60s 간격)    │  ← REOPEN-AMI
   │            · ± nicorandil IC/IV (한국 등재 · 추가 cost 0)                    │     MVO 14% vs 35%
   │            · (가용 시) IMR 측정 → >40 = MVO+ subset (Trial-A enroll 후보)     │  [H2 §Tier-A]
   │            ★ "IV bolus 실패 = mPTP mis-delivered" — IC + 재관류 동기가 교정변수 │
   │              (IC-sync ODE 93.5%→56.9% cell death, Δ36.6pp 🟢 / X9 N1)        │
   └─────────────────────────────────────┬──────────────────────────────────────┘
                                          │  PCI 완료 · 환자 입원 유지
                                          ▼
   ╔════════════════════════════════════════════════════════════════════════════╗
   ║  [입원 중 · 단일 시점] ★ 채혈 1회 3-axis 패널 ★  (= 본 알고리즘의 분기점)     ║
   ║  ─────────────────────────────────────────────────────────────────────────  ║
   ║    한 번의 채혈 + PCR/측정으로 동시 확보:                                      ║
   ║      ① ALDH2*2 (rs671)        — 유전형 (선택 · ethnicity/IRI 맥락)            ║
   ║      ② CYP2C19 LoF (*2/*3)    — PCR C5946 선별급여 (₩50,000, 1회)            ║
   ║      ③ Lp(a) / KIV-2 copy     — 임상화학 1회 (유전 결정 ~90% → 평생 1회)      ║
   ║  → N4·N5·D1·D4·L1·L2 6 wall 을 단일 패널이 동시 stratify (X9 §5 · 신규 IND 불요)║
   ╚════════════════════════════════════════════════════════════════════════════╝
        │                          │                          │
        │ (① 결과)                 │ (② 결과)                 │ (③ 결과)
        ▼                          ▼                          ▼
 ┌──────────────┐      ┌──────────────────────┐      ┌──────────────────────┐
 │ N축 modifier │      │  D축 — DAPT 분기      │      │  L축 — Lp(a) 잔여위험 │
 │ (IRI/no-refl)│      │  (CYP2C19 결정맵)     │      │  경로                 │
 ├──────────────┤      ├──────────────────────┤      ├──────────────────────┤
 │ ALDH2*2(+):   │      │ NM/RM (~33%) ──►      │      │ Lp(a) <50: 표준 2차   │
 │ NO 대사↓ ·    │      │   clopidogrel 적절 가능│      │   예방 (LDL 목표)      │
 │ IRI 수정인자 ·│      │   (환경변수 시 PFT)    │      │                       │
 │ alternative   │      │                        │      │ Lp(a) ≥50 (KSoLA high):│
 │ NO donor 맥락 │      │ IM (~45%, 최다) ──►   │      │   잔여위험 high →      │
 │ (연구단계)    │      │   clopi 부분저하 가능 ·│      │   LDL 더 공격적 ·     │
 │               │      │   위험낮으면 prasugrel │      │   PCSK9 mAb 후보검토   │
 │ ALDH2*2(−):   │      │   5mg (한국 dose) ·    │      │   (단 PCSK9 급여=LDL    │
 │ 표준 IRI 관리 │      │   de-esc PFT 보조      │      │    기준, Lp(a) -25%     │
 │               │      │                        │      │    는 부수효과)        │
 │ ※ N축은 시술  │      │ PM (~15%) ──►         │      │                       │
 │   당시 IC 중재 │      │   clopi 효과 大저하 · │      │ Lp(a) ≥75 / KIV-2 low │
 │   가 1차 ·    │      │   prasugrel 5mg or    │      │   copy: 최고위험 →    │
 │   패널은 후속  │      │   ticagrelor (출혈균형)│      │   향후 siRNA 임상      │
 │   modifier    │      │   · PFT 확인           │      │   (HORIZON 2026 추적) │
 │               │      │ ★ ticagrelor 한국 출혈↑│      │   · Trial-D 후보       │
 │               │      │   (TICAKOREA dual      │      │                       │
 │               │      │   jeopardy)            │      │                       │
 └──────┬───────┘      └──────────┬───────────┘      └──────────┬───────────┘
        │                          │                              │
        └──────────────────────────┼──────────────────────────────┘
                                    ▼
   ┌──────────────────────── ISR surveillance (I축, 모든 경로 공통) ─────────────┐
   │  · PCI 후 정기 외래 (NHIS 급여 ~4회/년) + 증상기반 평가                       │
   │  · 위험인자 관리 = 스타틴/LDL · 당뇨 · 혈압 (N·I·L 공통 토대)                 │
   │  · 재발 흉통/허혈증상 시 즉시 진료 → 재시술 시 OCT/IVUS-guided                │
   │    (한국 사용률 70%+ 세계 최고 → neointima vs neoatherosclerosis vs strut 구분)│
   │  · 한국인: small vessel 35-40% · NA risk 高 = ISR 추적 강화 군                 │
   └────────────────────────────────────────┬───────────────────────────────────┘
                                             ▼
 [6m]  검사결과 기반 재평가 (약제 재배치 · 신규 승인 불요)
        · D축: 결정맵 따라 DAPT 적정성 재평가 (NM 유지 / IM·PM 강력제 고려)
        · L축: Lp(a) 결과 기반 LDL 목표 재설정 · PCSK9 후보 검토
        · I축: surveillance 지속 · 증상 시 OCT 재시술
        ▼
 [3y]  미래 옵션 도착 추적 (신약 승인 대기)
        · L축: siRNA/ASO (HORIZON 2026 H1 readout → 허가/급여 분기 · RSA 협상)
        · I축: fasudil-DCB 등 비-mTOR (MFDS FIH 단계)
        · N축: NMN-PRECON 등 IRB-light pilot (효과 미확립 · 설계단계)
```

> **흐름 핵심**: no-reflow 중재(N축)는 **시술 당시 IC 약물**이 1차 결정이고, **채혈 1회 3-axis 패널**이 그 직후 단일 분기점이 되어 D·L 경로를 동시에 연다. I축(ISR)은 모든 경로가 합류하는 공통 surveillance layer 다. → 4축이 **4개 따로가 아닌 하나의 침상 흐름**.

---

## §2. 3-axis 분기 표 (패널 결과 → 즉시 행동 → 약제/검사 + 급여 → grade)

> grade = X8 ledger / 4 sub-V verdict VERBATIM. 효과 추정 칸은 전부 ⚪/🟠 로 분리.

### 2.1 ① ALDH2\*2 (rs671) — N축 (no-reflow / IRI modifier)

| axis 결과 | 즉시 행동 (침상) | 약제/검사 (한국 급여 여부) | 근거 grade (X8 verbatim) |
|---|---|---|---|
| **ALDH2\*2 보유 (East Asian ~40%)** | NO bioavailability↓ · IRI 수정인자로 인지 · (no-reflow 발생 시) alternative NO donor 맥락 — 단 직접 약제결정 연결은 연구단계 | ALDH2\*2 유전형 검사 (선택 · 연구/임상 맥락) · no-reflow 시 IC adenosine/nicorandil (한국 보험 routine) | ALDH2\*2 East Asian 40% = 🟡 SUPPORTED-BY-CITATION [NOREFLOW M9§5] · "first-in-class 기회" 인과부 = ⚪ |
| **ALDH2\*2 비보유** | 표준 IRI 후속 관리 | (해당 없음) · no-reflow 시 동일 IC 중재 | 동일 🟡 |
| **(N축 공통) no-reflow 발생 시** | TIMI≤2 시 IC vasodilator 즉시 (§1 분기) | adenosine IC 24mg distal (off-label routine) · nicorandil (한국 등재) — **신규 IND 불요** | adenosine REOPEN-AMI = 🟡 · IC-sync ODE Δ36.6pp = 🟢 SUPPORTED-NUMERICAL [X9 N1] · mPTP IV bolus 가설 = 🔴 FALSIFIED (4 RCT null) [X8 §5 F1-F4] |

### 2.2 ② CYP2C19 LoF (\*2/\*3) — D축 (DAPT 결정맵)

> 출처 = DAPTPGX M7 결정맵 (한국 100명: NM/RM ~33 · IM ~45 · PM ~15) VERBATIM [H3 · X6 §4].

| axis 결과 | 즉시 행동 (주치의 판단) | 약제/검사 (한국 급여 여부) | 근거 grade (X8 verbatim) |
|---|---|---|---|
| **NM/RM (~33%)** | clopidogrel 대체로 적절 가능 · 환경변수(PPI·신기능) 시 PFT 고려 | clopidogrel (기존 급여) · VerifyNow PRU (일부 indication) | 결정 트리 = 🟡 [M7] · PM/IM 빈도 산식 = 🟢 (아래) |
| **IM (~45%, 가장 흔함)** | clopidogrel 효과 부분저하 가능 · 출혈위험 낮으면 prasugrel 5mg(한국 dose) · de-escalation 시 PFT(PRU<208) 보조 | prasugrel 5mg · clopidogrel (모두 기존 급여 = 재배치만) | 🟡 [M7] · IM+PM 합 freq = **0.6279** (cited 0.60) 🟢 SUPPORTED-NUMERICAL [DAPTPGX V3 §61 / X5 §6] |
| **PM (~15%)** | clopidogrel 효과 大저하 (ST 위험↑) → prasugrel 5mg 또는 ticagrelor · ★ ticagrelor 한국 출혈↑(TICAKOREA, dual jeopardy) → 출혈균형 핵심 · PFT 확인 | prasugrel 5mg · ticagrelor (기존 급여) · CYP2C19 PCR (C5946 **선별급여**, ₩50,000, 1회) | 🟡 [M7] · PM phenotype freq = **0.1521** (cited 0.14-0.15) 🟢 SUPPORTED-NUMERICAL (exact) [DAPTPGX V3 §61] · TICAKOREA 출혈 = 🟡 · 결정맵 적용 ST↓X% = 🟠/⚪ (model assumption, cohort 미측정) |

### 2.3 ③ Lp(a) / KIV-2 — L축 (잔여 위험)

| axis 결과 | 즉시 행동 | 약제/검사 (한국 급여 여부) | 근거 grade (X8 verbatim) |
|---|---|---|---|
| **Lp(a) <50 mg/dL** | 표준 2차 예방 (LDL 목표) 유지 | Lp(a) 1회 측정 (임상화학 routine, 유전 결정 90% → 평생 1회) | 한국 분포 = 🟡 [LPA M2] · Lp(a)→CHD 인과 β_IVW = **-0.3413** (Burgess -0.34249, Δ0.0012) 🟢 SUPPORTED-NUMERICAL [LPA V3b / X5 §6] |
| **Lp(a) ≥50 (KSoLA high)** | 잔여위험 high → LDL 더 공격적 · PCSK9 mAb 후보 검토 (급여=LDL 기준 충족 시) | PCSK9 mAb evolocumab/alirocumab (ASCVD 2차 급여, LDL 기준) — Lp(a) -25% 는 부수효과 · 스타틴 무효(오히려 +5-10%) | PCSK9 -25% = 🟡 · 스타틴 무효 = 🟡 [X9 L1] |
| **Lp(a) ≥75 / KIV-2 low copy (최고위험)** | 최고 잔여위험 → 향후 siRNA 임상 후보 · HORIZON 2026 readout 추적 · (해당 시) Trial-D enroll 후보 | siRNA/ASO (pelacarsen·olpasiran -80~98%) = **현 미허가·비급여** (NHIS WTP 0% pass) → d2 대안 §4 | siRNA Lp(a) 강하 = 🟡 (surrogate) · MACE 감소 = 🟠 DEFERRED (HORIZON 2026 / OCEAN(a) 2027 대기) · NHIS WTP 0% pass = 🟢 [LPA V3c] · GalNAc free-tool 부재 = 🔴 [X8 §5 F5] |

> ⚠ g5 fence: 이 표에서 sub-V 에 🟢 verdict 가 있는 정량은 **PM 0.1521 · IM+PM 0.6279 (D축) · β_IVW -0.3413 · NHIS 0% pass (L축) · IC-sync ODE Δ36.6pp (N축)** 5건뿐이다. 그 외 효과 추정(결정맵 ST↓ · PCSK9 MACE↓ · siRNA -80% MACE · DCB LLL↓)은 전부 🟡(literature) 또는 🟠/⚪(미래 readout 의존)다.

---

## §3. coupled 통찰 — 왜 4개 따로보다 1개 통합이 우월한가 (X9 §5 연결)

### 3.1 단일 패널이 N+D+L 을 동시 stratify

```
                   ALDH2*2 (East Asian ~40%)          ← N축 (no-reflow/IRI modifier)
                          │  NO↓ · IRI 악화 · nicorandil null 정당화
                          ▼
 한국 PCI 환자 ──── CYP2C19 LoF (IM+PM ~60%) ──── KIV-2 high / Lp(a) ≥50 (~12-13%)
    │                     │  HTPR 50-60%                 │  잔여위험 30%
    │  N4/N5 wall          │  D1/D4 wall                  │  L1/L2 wall
    │                     │                              │
    └────────────── 단일 입원 채혈 1회 + PCR/측정 panel ──────────────┘
                          │  (기존 NHIS 급여 안에서 배포 가능)
                          ▼
            ┌─────────────┴─────────────┐
            │  ISR 5-10% 추가위험 (I축, mTOR plateau) — 모든 경로 공통 surveillance
            ▼
      4-trial portfolio (X5): A NICORADENO · B DAPT-PGx-K · C ISR-non-mTOR · D LPA-siRNA-K
```

### 3.2 단일 패널이 동시에 낮추는 6 wall (X9 §5.2 VERBATIM)

| 패널 1축 | 동시 낮추는 wall | leverage 근거 |
|---|---|---|
| **ALDH2\*2 enrichment** | N5 (Trial-A Cox under-power 0.654 → effect size 증폭) + N4 (alternative NO donor sub-group) | ethnicity-aware fast track + power 회복 |
| **CYP2C19 LoF panel** | D1 (60% 비-최적 결정 트리) + D4 (KOVA caller 검증 cohort) | 동일 PCR panel 이 결정맵 + caller head-to-head cohort 양쪽 공급 |
| **Lp(a)/KIV-2 측정** | L1 (잔여위험 stratify) + L2 (narrow staging enrollment) + L3 boost (KIV-2 정수 copy → 🔵 후보) | 1회 측정이 risk stratify + IIT enrollment + 🔵 잠재 atom 동시 공급 |

### 3.3 통합이 우월한 4가지 이유

1. **확률적 공발생**: 한국인은 ALDH2\*2(~40%) × CYP2C19 LoF(~60% diplotype) × Lp(a) high(~12-13%)를 동시에 보유할 확률이 비-동아시아보다 현저히 높다. 4축이 한 환자에서 겹치므로 분리 측정은 **중복 채혈·중복 외래·중복 비용**을 낳는다. 단일 패널은 1회 채혈로 끝난다.
2. **단일 분기점**: 4개 따로 본 review 에서는 안 보이지만, 통합 흐름에서는 모든 분기가 **채혈 1회 한 지점**에서 갈라진다 — 임상 워크플로가 단순해지고 누락이 줄어든다 (X7 thesis: single-track review 로는 안 보임).
3. **공유 인프라**: 동일 PCR lab 1개가 ① ALDH2\*2 + ② CYP2C19 + ③ KIV-2 genotyping 을 동시 공급 (X9 §6.2 — KOVA/KRGDB 한국 WGS 자산 1개 = 3 도메인 genotyping). imaging consortium(CMR+OCT) 1회 구축이 N축(infarct size)·I축(NA OCT) 공용 (X9 §6.1).
4. **wall leverage**: 단일 패널이 6 wall 을, 단일 hexa-lang bio-verify-kernel phase 2 PR 이 3 proof wall(N2·D3·I2)을 동시에 낮춘다 (X9 §7 순위 2·1). 따라서 통합은 **임상 leverage(6 wall)와 코드 leverage(50-90 🔵) 양쪽에서 4분리보다 우월**.

> → **핵심 1줄**: 글로벌 trial(HORIZON·OCEAN(a))이 미시도한 차별점 = **KIV-2 copy stratified efficacy primary + ALDH2\*2 enrichment** 를 한국이 단일 패널로 동시 구현 가능 — "채혈 1회 → N개 도메인 동시 stratify"가 글로벌 미시도 differentiator (X9 §5).

---

## §4. d2 — 한국 미가용 옵션의 대안 path (포기 금지)

> 거버넌스 d2: 미가용 약물/옵션에 막혀도 "불가능"으로 닫지 않고 **현 가용 대안 path** 를 동반한다 (모두 주치의·임상센터 논의 옵션).

| 축 | 한국 미가용 (wall) | 가용 대안 path (d2) | 근거 |
|---|---|---|---|
| **N (IRI)** | mPTP 직접약물 NIM811·debio-025·TRO40303 미수입·미허가 · elamipretide 미승인 | (A) **시술 당시 IC adenosine + nicorandil**(한국 보험 routine, 신규 IND 불요) — peri-PCI no-reflow 차단 · (B) 표준 2차 예방 극대화(IRI 후속 토대) · (C) ALDH2\*2 군 ethnicity-aware 관리 | H2 · X9 N4 |
| **D (DAPT)** | vicagrel(CYP2C19-무관 신약) 미도입(~2028 예상) · selatogrel 연구단계 | (A) **기존 급여 약제 내 최적화** — NM=clopidogrel · IM/PM=prasugrel 5mg/ticagrelor(출혈균형) → 신약 없이 결정맵 대응 가능 · (B) PFT(PRU) 잔존효과 확인 · (C) HOST-EXAM clopi 단독 chronic (HR 0.73, Kim 2020 Lancet) | H3 · X9 D1 |
| **I (ISR)** | fasudil-DCB·dual-DCB·차세대 Mg-BRS = 임상/연구단계 | (A) **OCT/IVUS-guided 표준 재시술**(한국 세계 최고 사용률) — 원인별 최적 치료 · (B) 기존 paclitaxel/sirolimus DCB · (C) 위험인자 관리 + 증상기반 surveillance | H4 · X9 I3 |
| **L (Lp(a))** | siRNA/ASO 미허가·비급여 (NHIS WTP 0% pass, 387-645× 약가격차 = 최대 wall) | (A) **PCSK9 mAb**(ASCVD 2차 급여, LDL 기준) — Lp(a) -25% 부수효과 즉시 가용 · (B) LDL 공격적 조절로 전체 ASCVD 위험↓ · (C) HORIZON 2026 readout 후 허가/급여 또는 임상참여 추적 · (RSA outcome-based 협상 · narrow staging) | H5 · X9 L2 |

> 가장 큰 wall = **L축 Lp(a) 신약(siRNA)** — 효능 크나(연구단계 -80~98%) 한국 미허가·비급여. 그러나 "PCSK9 + LDL 공격적 조절 + 향후 임상참여/허가 추적"이라는 **현 가용 대안이 분명히 존재**한다 (포기 아님). d6 준수 — siRNA MACE 효과는 🟠 DEFERRED 로 정직히 격리, 억지 🟢 강제 0건.

---

## §5. 환자 timeline — 즉시 / 6개월 / 3년 (ASCII)

> "지금 당장 할 수 있는 것 → 결과 기반 조정 → 미래 옵션" 순서. 모든 항목 주치의 상의 전제.

```
 시점        통합 행동 (단일 흐름)                                규제/급여 상태
═══════════════════════════════════════════════════════════════════════════════════════

 즉시        ┌─ ★ 채혈 1회 3-axis 패널 (§1 분기점)               ★ 최저 장벽
 (0m)        │   = CYP2C19 PCR (C5946 선별급여)                   · CYP2C19 = 선별급여
             │   + Lp(a) 1회 측정 (임상화학)                      · Lp(a) = 일반 검사
             │   + (선택) ALDH2*2 유전형                          · 신규 IND/약 승인 전혀 불요
             │   → "한 번 채혈"로 N(ethnicity)+D+L 동시 확보
             │
             ├─ (시술 당시 N축) no-reflow 시 IC adenosine          · 한국 보험 routine
             │   + nicorandil — 이미 지난 시점이면 기록 확인        · 신규 IND 불요
             │
             ├─ 현 항혈소판제 복용 지속 (결과 전 임의변경 금지)     · DAPT 자의중단 = ST 위험
             │
             └─ 표준 2차 예방 점검 (스타틴/LDL·혈압·금연·운동·      · 모두 기존 급여
                당뇨) = N·I·L 공통 토대

───────────────────────────────────────────────────────────────────────────────────────

 6개월       ┌─ D축: 검사결과 기반 DAPT 적정성 재평가 (§2.2 결정맵)  ★ 중 (약제 재배치)
 (3-6m~)     │   · NM → clopidogrel 적절 가능                       · 약제 전부 기존 급여
             │   · IM/PM → prasugrel 5mg/ticagrelor·PFT 고려        · 신규 승인 불요
             │
             ├─ L축: Lp(a) 결과 기반 LDL 목표 재설정 · PCSK9 검토    · PCSK9 급여 = LDL 기준
             │
             └─ I축: ISR surveillance — 증상 점검 + 정기 외래        · 외래 NHIS 급여 ~4회/년

───────────────────────────────────────────────────────────────────────────────────────

 3년         ┌─ L축: Lp(a) 신약(siRNA/ASO) 한국 허가·급여 추적       ★ 최고 (신약 승인 대기)
 (2-3y~)     │   · HORIZON 2026 H1 readout → 허가/급여 분기점         · 현재 미허가·비급여
             │   · Lp(a) high 면 → 임상참여/신약 가용 시 후보         · RSA 협상 의존
             │
             ├─ I축: ISR 신규 옵션(fasudil-DCB 등) = 임상시험 단계     · MFDS FIH 단계
             │   재협착 시 표준 치료(재시술/DCB) + trial 정보 문의
             │
             └─ N축: NMN-PRECON 등 IRB-light pilot = 설계 단계(참고만)  · 효과 미확립

───────────────────────────────────────────────────────────────────────────────────────

 decision gates: 2026 H1 HORIZON readout · 2027 Q4 NMN-PRECON · 2028 Q2 CMR primary · 2032 Lp(a) MACE
```

### 5.1 "오늘 당장 가능" — 신규 IND 불요 (강조)

```
┌──────────────────────────────────────────────────────────────────────────────┐
│  ★ 오늘 당장 가능 (신규 IND·신규 약물 승인 전혀 불요 · 기존 NHIS 급여 안)        │
│                                                                                │
│  ① 채혈 1회 3-axis 패널                                                         │
│     · CYP2C19 PCR = C5946 선별급여 (₩50,000, 1회) — 지금 주문 가능              │
│     · Lp(a) = 임상화학 1회 (유전 결정 90% → 평생 1회로 충분)                    │
│     · → N+D+L 6 wall 동시 stratify · 다음 PCI 환자부터 즉시 배포 가능           │
│                                                                                │
│  ② 결정맵 약제 재배치 (B. DAPT-PGx-K · 규제 장벽 최저)                          │
│     · clopidogrel/prasugrel 5mg/ticagrelor = 전부 기존 급여 약제 (재배치만)     │
│     · no-reflow 시 IC adenosine + nicorandil = 한국 보험 routine                │
│     · → registry-embedded 즉시 시작 가능                                        │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## §6. g5 grade — X11 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 메인 결정흐름도 | 🟡 SUPPORTED-BY-CITATION (compositional) | 4 sub-V + H2-H5 결정맵/Tier-A/분기 VERBATIM carry · 흐름 통합은 X9 §5 leverage 기반 |
| §2 3-axis 분기 표 | 🟡 + 🟢(인용) | grade = X8 ledger VERBATIM · PM 0.1521 / IM+PM 0.6279 / β -0.3413 / NHIS 0% / ODE Δ36.6pp 🟢 verbatim |
| §3 coupled 통찰 | 🟡 | X9 §5/§6 leverage + 6 wall 동시 stratify VERBATIM carry |
| §4 d2 대안 path | 🟡 | 4 sub-V d2 path VERBATIM · 미가용→대안 명시 (포기 0건) |
| §5 timeline + 오늘 가능 | 🟡 | X5 §4 + X6 §2 + X7 timeline carry · 급여 사실 진술 |

**X11 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — 4 sub-domain(NOREFLOW·DAPTPGX·ISR·LPA) + cross-cutting(X5·X6·X7·X9) + DOCTOR(H2-H5) verdict 의 **단일 coupled 침상 알고리즘 통합**. **X11 새 판정 0건** (per @D g5 · LLM self-judge 0건). 효과 추정 = ⚪/🟠 분리 · 미가용 옵션 = d2 대안 동반 · 억지 등급/숫자 = d6 거부 · 환자 적용 = "의사결정 지원, 처방 아님" 톤 · completed-form (d1).

---

## §7. X11 산출 요약

- **단일 coupled 흐름**: STEMI 도착 → primary PCI (+ no-reflow 분기: TIMI≤2 시 IC adenosine/nicorandil) → **채혈 1회 3-axis 패널 (ALDH2\*2 × CYP2C19 LoF × Lp(a)/KIV-2)** → 분기별 DAPT(NM=clopi · IM/PM=potent) + ISR surveillance + Lp(a) 잔여위험 경로 → 즉시/6m/3y 추적.
- **단일 분기점 = 채혈 1회 패널**: 4축이 4개 따로가 아닌 한 점에서 갈라지며, N4·N5·D1·D4·L1·L2 6 wall 을 동시 stratify (X9 §5) · 기존 NHIS 급여 안 배포 가능 (신규 IND 불요).
- **grade**: X8 ledger VERBATIM · 🟢 정량 5건(PM 0.1521 · IM+PM 0.6279 · β -0.3413 · NHIS 0% · ODE Δ36.6pp) · 효과 추정 ⚪/🟠 분리 · 🔴 5(4 RCT null + GalNAc) 정직 격리.
- **g5/d1/d2/d6 준수**: 새 판정 0건 · completed-form · 미가용→대안 path · 억지 등급 거부 · 처방 아님 톤.

---

> ⚠ **하단 DISCLAIMER (반복)**: 본 문서는 의사결정 지원 자료이며 처방·진단이 아니다. 검사·약제·용량은 전적으로 담당 의료진 판단이며, 항혈소판제를 임의 중단·변경하지 말 것. 근거 등급은 sub-domain verify verdict 의 verbatim 인용이고, 효과 추정·미래 전망(⚪/🟠)은 검증된 사실이 아니다.
