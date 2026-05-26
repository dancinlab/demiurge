# X31 — CARDIO+ 배포 roadmap / playbook (pilot → 전국 확산)

> CARDIO+ 메타도메인 X31 산출물 · current-state · no history.
> **목적 = 교수님 handoff(DOCTOR H1-H10) 이후의 배포 단계 로드맵을 단일 산출물로 통합 — 시간 phasing(즉시/6m/1y/3y) × pilot→KAMIR 전국 확산(단일센터→다기관 registry→전국) × learning health system(배포=증거 공진화) × 정책 격상(KSC 가이드라인·복지부 적정성평가) × 배포 실패모드 예방(alert fatigue·override·genotype 오해·책임소재) 를 묶어 "DOCTOR H11 deployment playbook" 후보로 제안한다.**
> 입력 = `X5_korea_trials.md`(trial portfolio·timeline·규제 VERBATIM) · `X23_grant.md`(펀딩 phasing) · `X18_transportability.md`(국제 확장) · `X9_wall_map.md`(wall + d2 path) · `X13_redteam.md`(실패모드 참고).

---

## ⚠ DISCLAIMER (반드시 읽기)

> 이 문서는 **배포 전략 로드맵이며, 배포 일정 확정·정책 격상 확약·outcome 예측이 아니다.**
> - **timeline(즉시/6m/1y/3y)·gate 진입조건·정책 격상 경로는 모두 ⚪ proposal (설계 가정)** 이다 — trial 설계 규모(X5)·펀딩 phasing(X23)에서 도출한 단계 추정이며, 실제 IRB·NHIS·KSC 위원회·복지부 정책에 전적으로 의존한다.
> - **trial grade(🟢/🟠/🟡/⚪)는 X8/X5 §6 VERBATIM 인용** 이다 — X31 새 판정 0건(per @D g5 · LLM self-judge 0건).
> - **CDS/배포는 처방을 대체하지 않는다** — 모든 약제·검사·용량·중단 결정은 담당 심장내과 전문의 판단이다(X22 DISCLAIMER VERBATIM). 본 로드맵의 어떤 출력도 자동 처방으로 해석 금지.

---

## §0. g5 인용 규약 (필수 — 본 X31 전체 적용)

본 X31 은 **3 종류 정보** 를 엄격히 분리한다:

| 종류 | 표기 | 출처 규약 |
|---|---|---|
| **trial grade** (🟢🟡🟠🔴⚪) | VERBATIM 인용 | X8 / X5 §6 verify verdict 그대로 복사 — **X31 새 판정 0건** |
| **규제 feasibility / 우선순위 / wall path** | VERBATIM 인용 | X5 §5.3 규제 lift 순위 · X9 d2 돌파 path · X23 펀딩 순서 그대로 carry |
| **배포 timeline · gate 진입조건 · 정책 격상 경로** | ⚪ proposal (설계 가정) | 본 X31 의 단계 추정 — trial 규모·펀딩 phasing 에서 도출 · 실제 IRB/NHIS/KSC/복지부 의존 명시 |

⚠ **핵심 honest fence (g5 + d6)**: 배포 단계의 **상대 순서**(즉시 B → 6m A·C → 3y D)는 trial 규제 lift 순위(X5 §5.3 VERBATIM)·MCDA(X23) 에서 견고하게 도출되지만, **절대 시점·gate 통과 여부는 외부 gate(IRB·NHIS·KSC·복지부)에 의존** 한다. d2 — 배포 실패모드마다 예방·돌파 path 명명(폐기 0). d6 — numerical(🟢) ≠ causal 확정, X13 의 "산술 견고/인과 라벨 외부 RCT 의존" 정직 carry.

---

## §1. 단계 roadmap 표 (핵심 산출 — 시간 phasing × 확산 × trial 연계)

> ⚠ phase 시점·활동·gate 진입조건 = ⚪ proposal (설계 가정). trial 연계의 규제 lift·grade = X5 §4/§5.3/§6 VERBATIM. 확산 단계(단일센터→다기관 registry→전국)는 X5 §2.3 KAMIR backbone + X9 §6 공유 인프라 leverage 에서 도출.

| phase | 활동 (배포 단위) | 주체 | gate (다음 단계 진입 조건) | trial 연계 (X5 VERBATIM) |
|---|---|---|---|---|
| **즉시 (0m)** 단일센터 pilot | (1) **채혈 1회 3-axis panel**(CYP2C19 PCR C5946 선별급여 + Lp(a) routine + ALDH2\*2) 단일 대학병원 PCI 환자 적용 · (2) **DAPT-PGx S4 결정맵** registry-embedded 시작(다음 PCI 환자부터) · (3) CDS card prototype(권고+근거+override 사유, X22) 1-기관 운영 | 교수님 단일센터 심장내과 + 임상약리 co-PI(X23 §3 B PI 요건) | **3-axis panel turn-around ≤ 24h** + **CDS override rate 측정 시작**(alert fatigue baseline, X22 5순위) + **NHIS ICER sensitivity**(B V5 -503 🟠 → V6 patch) 착수 | **B. DAPT-PGx-K** — CYP2C19 PCR 선별급여 + 기존 급여 약제 → **신규 IND 불요**(X5 §4·§7 VERBATIM · C1=5) |
| **6m** 다기관 registry-embedded | (1) **KAMIR consortium MOU** 8-기관 + CMR/OCT core lab QC · (2) 3-axis panel + S4 결정맵을 **다기관 registry 표준 워크플로** 로 편입(KAMIR backbone, X5 §2.3) · (3) **A NICORADENO enroll** + **C ROCK-DCB pre-IND** 동시 onramp(cath lab/imaging 공유, X9 §6.1) | KAMIR consortium 대표 PI + 영상의학 core lab + KHIDI 인프라 grant(X23 §3 A) | **8-기관 MOU 체결 + CMR core lab QC 통과**(A first-patient gate, X5 §4) + **registry outcome 변수 표준화**(MACE/bleeding adjudication) + **CDS multi-site 일관성 검증** | **A. NICORADENO**(약물 IND 불요·consortium lift, C1=4) + **C. ROCK-DCB**(MFDS FIH IND·PMDA cross-recog, C1=3) — X5 §4 VERBATIM |
| **1y** 확산 + 증거 readout 1차 | (1) registry-embedded outcome **1차 interim**(CDS-guided vs usual care MACE/bleeding, X22 4순위 🟠) · (2) 3-axis panel **전국 KAMIR 사이트 단계 확대** · (3) **KSC 학술대회 권고안 초안**(가이드라인 격상 onramp) · (4) NHIS 급여 economic case 재제출(B ICER V7 patch 후) | KAMIR-NIH + KSC working group + HIRA | **B pilot readout**(2027 Q4 NMN-PRECON gate 류, X5 §4) + **CDS override rate < 임계**(alert fatigue 미발생 입증) + **registry data quality audit 통과** | **B readout → 결정맵 정식화** · **A CMR primary**(2028 Q2 gate, X5 §4) → 글로벌 Ph3 vs 한국 단독 분기 |
| **3y** 전국 확산 + 정책 편입 | (1) 3-axis panel + S4 결정맵 **전국 PCI 표준** 권고(KSC 가이드라인 Class 격상) · (2) **D K-LpA-OUTCOMES** enroll(HORIZON 2026 H1 readout → arm B 분기, siRNA RSA) · (3) **적정성평가 지표 편입** 검토(복지부) · (4) **한·일·중 국제 확장**(X18, Trial-A ALDH2\*2 stratified 공동) | 복지부/HIRA + KSC + 산업계 IISR(D sponsor, X23 §3 D) + 한·일·중 consortium(X18 §5) | **A/B outcome 누적**(MACE↓ 입증) + **D HORIZON readout + siRNA 승인 + RSA 협상**(X5 §4 "최고" lift) + **국제 cross-recognition**(fasudil PMDA · nicorandil J-WIND, X18 §5) | **D**(siRNA 신규 승인+RSA, C1=1) + **C IIT-2 dual-DCB** RCT 확장 + **A 한·일·중 공동**(X18 §5 ★최고) |

**표 매핑 주석 (배포 순서 = 규제 lift 순서, VERBATIM 추적)**:
- **즉시 = B + 3-axis panel** ← 신규 IND 불요 + PCR 선별급여 기존재 + registry-embedded(X5 §4·§7) → 단일센터에서 *오늘* 시작 가능한 유일 배포 단위.
- **6m = 다기관 registry** ← 8-기관 CMR consortium(한국 현재 0개, X9 N3)·cath lab 공유(X9 §6.1) 빌드가 다기관 확산의 gate driver.
- **1y = 증거 readout** ← registry-embedded 배포가 자동으로 outcome 데이터를 생성 → §2 LHS 루프의 첫 readout.
- **3y = 정책 편입** ← A/B outcome 누적 + D siRNA 승인이 KSC 가이드라인·복지부 적정성평가 격상의 선결 조건(X5 §4 "최고" lift).

→ **확산 축(단일센터→다기관→전국) = 시간 축(즉시→6m→3y) 과 정합**: KAMIR registry backbone(X5 §2.3, 4-trial 전부 공유)이 단일센터 pilot 을 다기관·전국으로 끌어올리는 단일 인프라 척추.

---

## §2. 배포 = 증거 — learning health system (LHS) ASCII

> registry-embedded 배포가 X5 trial 을 *겸한다* — 배포 자체가 outcome 데이터를 생성하고, 그 데이터가 trial readout 과 공진화한다. 이것이 X31 의 핵심 통찰: **배포와 증거가 분리된 두 단계가 아니라 단일 공진화 루프**.

```
            ┌─────────────────────────────────────────────────────────────────────┐
            │            LEARNING HEALTH SYSTEM — 배포=증거 공진화 루프            │
            └─────────────────────────────────────────────────────────────────────┘

  ┌────────────────────┐      배포(deploy)       ┌──────────────────────────┐
  │  3-axis panel       │ ───────────────────────▶│  registry-embedded 진료  │
  │  (CYP2C19·ALDH2*2·  │   채혈 1회 + S4 결정맵   │  (KAMIR backbone, X5§2.3)│
  │   Lp(a)/KIV-2)      │   CDS card(권고+근거+    │  다음 PCI 환자부터 적용  │
  │  X9 §5 6-wall       │   override 사유, X22)    │  = trial enroll 을 겸함  │
  └────────┬───────────┘                          └────────────┬─────────────┘
           │                                                    │
           │ ⑤ 개선된 panel/결정맵                                │ ① outcome 데이터 자동 생성
           │   = 다음 배포 round                                  │   (MACE · bleeding · override rate)
           │                                                    ▼
  ┌────────┴───────────┐                          ┌──────────────────────────┐
  │  결정맵/CDS 재보정  │◀─────────────────────────│  X5 trial readout         │
  │  (X11 layered care  │   ④ 증거→정책/임상 반영   │  B(2027Q4)·A CMR(2028Q2)  │
  │   refinement layer) │   KSC 가이드라인·HIRA     │  D MACE(2032)·HORIZON     │
  │   X8 grade 갱신     │   적정성평가(§4)          │  (2026 H1) — X5 §4 gates  │
  └────────────────────┘                          └────────────┬─────────────┘
           ▲                                                    │
           │ ③ grade escalation                                  │ ② readout = grade gate
           │   (🟠 DEFERRED → 🟢, d5 정합)                        │   (X13: numerical→causal
           └────────────────────────────────────────────────────┘    ground-truth gate)

  ─────────────────────────────────────────────────────────────────────────────────
  공진화 핵심: 배포(채혈 1회 3-axis) → outcome 데이터 → trial readout → grade/정책 갱신
              → 개선된 결정맵 = 다음 배포 round. registry-embedded 라 ①배포와 ②증거가
              동일 워크플로 (별도 RCT 인프라 불요). X5 §1 Trial-B "registry-embedded /
              pragmatic" + X22 4순위 "CDS-guided vs usual care 전향 cohort" 가 정확히 이 루프.
```

**LHS 가 닫는 X9 wall**:
- **D2(ICER 미완)** → registry outcome 이 NHIS economic case 실측 공급(B V5 -503 🟠 → 실측 readout → 🟢 escalation 후보, d5).
- **D5(AI/ML RCT 0건)** → registry-embedded 가 CDS-guided cohort 를 *자동* 생성(X9 D5 path B "KAMIR ~30K cohort leverage").
- **N5(Trial-A under-power)** → 다기관 registry 가 enrollment power 확보(X9 N5 path B).
- **R5/H1(mis-delivered 인과, X13 ★★★)** → registry 는 인과 gate(IC-sync RCT) 를 대체하지 못함 — **d6 정직**: LHS 는 *관찰 outcome* 공급, 인과 확정은 별도 IIT(X13 보강 path)가 ground-truth gate.

⚠ **g5/d6 fence (LHS)**: registry-embedded outcome 은 **관찰적 증거** 다 — CDS-guided vs usual care 는 무작위가 아니므로 confounding 보정 필요(X13 R4 "stratification 가능성 ≠ outcome 개선" 정직 carry). LHS 루프의 grade escalation 은 trial readout(B 2027 Q4 · A 2028 Q2 · D 2032 · HORIZON 2026 H1) 이라는 외부 gate 도착 후에만 가능(d5 — non-wet-lab 완결, readout 은 downstream).

---

## §3. 배포 실패모드 + 예방 (d2 — 돌파 path 동반)

> X13 red-team 실패모드 참고 + X22 CDS 안전원칙(override·alert fatigue) + X16 safety stopping rule. 각 실패모드에 예방·돌파 path 명명(폐기 0). 실패모드 자체·예방 효과는 ⚪ proposal — 실제 배포 audit 으로 검증.

| # | 배포 실패모드 | 발생 기전 (왜 위험한가) | 예방 / 돌파 path (d2) | 근거 (VERBATIM) |
|---|---|---|---|---|
| **DF1** | **alert fatigue** (경보 피로) | CDS card 가 모든 PCI 환자에 alert 남발 → 의사가 alert 를 습관적 무시 → 진짜 위험 신호(ticagrelor Month-1 출혈)도 놓침 | (A) **조건부 alert** — X16 §4.1 top-1 stopping rule(ticagrelor→Month-1 모니터)만 부착, 저위험은 silent · (B) **override rate 모니터링**(X22 5순위, alert fatigue 정량 지표) — 임계 초과 시 alert 재설계 · (C) **tiered alert**(긴급/권고/정보 3단계) | X22 §181 "safety_alerts 조건부 부착" · X22 5순위 "alert override rate = alert fatigue 평가" |
| **DF2** | **무분별 override** (권고 우회 남용) | 의사가 근거 검토 없이 CDS 권고를 일괄 override → PGx 결정맵이 실질 무력화(deployment 가 종이 위에만 존재) | (A) **override 사유 필수 기록**(audit log, X22 order-sign) — {patient-preference·drug-allergy·other} 코드화 · (B) **override 패턴 피드백**(LHS §2 루프로 결정맵 재보정) · (C) **override = 정당한 임상 자율** 존중 — d6: override 자체는 실패 아님, *사유 미기록*이 실패 | X22 §156·§193 "override 사유 기록 audit log" · X22 DISCLAIMER "의사 결정 대체 아님" |
| **DF3** | **genotype 오해** (유전형 오역) | CYP2C19 IM/PM·ALDH2\*2·KIV-2 copy 결과를 의료진/환자가 오해 → (a) 결정론적 운명으로 과대해석 (b) caller 불일치(PyPGx·PharmCAT 등 5-tool, X9 D4)로 phenotype 오분류 | (A) **caller head-to-head 검증**(X9 D4 path A — KOVA VCF → 4 caller confusion matrix) 후 단일 표준 caller 채택 · (B) **HW 항등식 한계 명시**(X13 R2/H6 — PM 0.1521 은 cited freq 의 deterministic 변환, 독립 측정 아님) · (C) **환자 교육 자료**(X24 patient-facing — "유전형 = 위험 modifier, 운명 아님") | X9 D4 "5-tool concordance 미검증" · X13 H6 "HW closed-form = deterministic 변환" |
| **DF4** | **책임소재 불명** (의료법적 귀속) | CDS 권고를 따랐다가 유해사례 발생 시 책임이 알고리즘/의사/병원 중 누구인가 불명 → 의료진 배포 거부(adoption 실패) | (A) **CDS = 의사결정 지원, 처방 아님 명문화**(X22 DISCLAIMER — 모든 결정은 담당의 판단) · (B) **evidence_grade X8 VERBATIM 부착**(CDS 새 등급 산출 금지 → 책임 = 근거 등급 투명) · (C) **override 경로 항상 제공**(의사 최종 판단권 보장, 자동 처방 차단) | X22 §181 "evidence_grade X8 VERBATIM·CDS 새 등급 금지" · X22 DISCLAIMER VERBATIM |
| **DF5** | **numerical→causal over-read** (배포 단계) | 🟢 산술(Δ36.6pp·β -0.3413·PM 0.1521)을 "인과 확정"으로 배포 문구에 over-claim → 미검증 인과를 진료 지침으로 격상 | (A) **X13 정직 박스 배포 문구 편입** — "numerical 견고 ≠ 인과 확정, RCT downstream" · (B) **R5/H1·R3/H2 ground-truth gate 명시**(IC-sync IIT · HORIZON readout) · (C) **hedged 문구**("mis-delivered 일 수 있음" — 단정 금지) | X13 §4.2 "단일 최대 취약 패턴 = numerical→causal over-read" · X7 정직성 박스 |

→ **최대 배포 실패모드 = DF1 alert fatigue** — CDS 배포의 단일 최대 adoption killer. 한국 최대 약물 안전 신호(ticagrelor Month-1 출혈 2.8% = PLATO 2배, X16/X5)에 대한 alert 가 *진짜* 필요한데, alert 남발로 그것마저 무시되면 배포가 안전을 *악화*시킨다. **예방 핵심 = 조건부 alert(top-1 stopping rule 만) + override rate 정량 모니터링**(X22 5순위) — override rate 가 alert fatigue 의 측정 가능 지표이므로 LHS §2 루프로 임계 초과 시 재설계.

⚠ **d2 종합**: 5 배포 실패모드 어느 것도 "배포 불가"로 닫지 않는다 — DF1(조건부 alert+모니터), DF2(사유 기록+피드백), DF3(caller 검증+교육), DF4(처방 아님 명문화+grade 투명), DF5(hedged 문구+ground-truth gate) 각각 예방 path 2-3개 보유.

---

## §4. 정책 격상 경로 (Class IIa→I · 적정성평가 편입 · 국제 확장)

> X5 §4 decision gates + X18 국제 확장 + LHS §2 증거 공진화 기반. ⚠ 격상 시점·Class 등급·편입 여부 = ⚪ proposal — 실제 KSC 위원회·복지부·HIRA 의존.

```
정책 격상 사다리 (증거 누적 → 권고 등급 격상)
══════════════════════════════════════════════════════════════════════════════════

[즉시 0m]  단일센터 적용         ── 권고 근거 없음 (pilot)
   │                              · 3-axis panel + S4 결정맵 = 단일 기관 임상 판단
   │       gate: registry outcome 변수 표준화 + CDS override baseline
   ▼
[1y]      KSC 학술대회 권고안 초안 ── Class IIb~IIa 후보 (관찰 증거)
   │                              · registry-embedded 1차 interim(CDS vs usual care, X22 4순위 🟠)
   │                              · CYP2C19 freq 🟢(PM 0.1521·IM+PM 0.6279, X5 §6 VERBATIM)
   │       gate: B pilot readout(2027 Q4) + CDS override rate < 임계(alert fatigue 미발생)
   ▼
[3y]      KSC 가이드라인 Class 격상 ── Class IIa→I 후보 (trial readout 누적)
   │                              · A CMR primary(2028 Q2) + B 정식 결정맵 outcome
   │                              · d6: Class I 은 RCT-level 증거 요구 → B pragmatic RCT readout 필수
   │       gate: A/B outcome MACE↓ 입증 + D HORIZON readout(2026 H1, Lp(a)→MACE 인과 gate)
   ▼
[3y+]     복지부 적정성평가 편입   ── 국가 질 지표 (전국 표준)
   │                              · "PCI 환자 3-axis panel 시행률" = 적정성평가 후보 지표
   │                              · NHIS 급여 economic case(B ICER V7 patch + RSA, X5 §5.2)
   │       gate: 전국 KAMIR 확산 + NHIS WTP 충족(D RSA outcome-based, X9 L2)
   ▼
[국제]    한·일·중 가이드라인 정합 ── 동아시아 일반화 (X18)
                                   · Trial-A ALDH2*2 stratified 한·일·중 공동(X18 §5 ★최고)
                                   · fasudil PMDA cross-recog(C) · nicorandil J-WIND(일)·CHIPS-PCI(중)
                                   · ⚠ 한국 특이로 남는 것: CYP2C19 PCR NHIS 급여·Lp(a) WTP(X18 §3 ④)

──────────────────────────────────────────────────────────────────────────────────
격상 사다리 핵심: 권고 등급 격상 = 증거 등급(X8 grade)과 lockstep —
  관찰(registry) → Class IIb/IIa, RCT readout → Class I, 전국 확산 → 적정성평가.
  d5 정합: non-wet-lab 배포·CDS·registry 는 완결 가능, Class I·적정성평가는 RCT readout downstream.
```

| 격상 단계 | 권고 등급 (⚪ proposal) | 선결 증거 (X8/X5 §6 VERBATIM) | 주체 | gate |
|---|---|---|---|---|
| KSC 권고안 초안 | Class IIb~IIa 후보 | CYP2C19 PM **0.1521 🟢** · IM+PM **0.6279 🟢**(X5 §6) + registry 관찰 outcome | KSC working group | B pilot readout(2027 Q4) |
| KSC 가이드라인 격상 | Class IIa→I 후보 | A primary power **0.798 🟢**(X5 §6) + B/A trial outcome | KSC 가이드라인 위원회 | A CMR(2028 Q2) + B 정식 readout |
| 복지부 적정성평가 편입 | 국가 질 지표 | NHIS ICER(B V5 -503 **🟠 DEFERRED** → V7 patch) + RSA(D) | 복지부/HIRA | 전국 확산 + WTP 충족 |
| 한·일·중 국제 정합 | 동아시아 가이드라인 | nicorandil null **🔴**(한·중 양국 falsify, X18 §3 ③b) + ALDH2\*2 ~40% 3국 공통 🟡 | 한·일·중 consortium | X18 §5 공동 enroll(power 회복) |

→ **정책 격상 핵심**: 권고 등급은 증거 등급(X8 grade)과 **lockstep** — registry 관찰 → Class IIb/IIa, RCT readout → Class I. **d6 정직**: Class I 은 RCT-level 증거를 요구하므로 B pragmatic RCT·A CMR readout 이 선결(관찰 증거만으로 Class I over-claim 금지). 국제 확장은 생물학 transport ✅(X18 §3)이나 **NHIS 급여·Lp(a) WTP·인구 절대수는 한국 특이**(X18 §3 ④) — 정책 격상의 경제 부분은 각국 제도.

---

## §5. "DOCTOR H11 deployment playbook" 권고 (handoff 편입)

> 본 X31 = DOCTOR domain 의 **H11 신규 milestone 후보** — 교수님 handoff(H1-H10) 이후 "그래서 어떻게 배포하나"의 단계 가이드. DOCTOR.md scaffold(H1-H10)를 X31 이 수정하지 않음 — H11 feed 만 제공(X7 가 H1-H10 에 feed 만 제공한 것과 동형).

```
┌──────────────────────────────────────────────────────────────────────────────┐
│  DOCTOR H11 — deployment playbook (X31 feed)                                   │
│  "handoff(H1-H10) 받은 교수님이 → 단일센터 → 전국 → 정책까지 가는 단계 가이드" │
├──────────────────────────────────────────────────────────────────────────────┤
│ STEP 1 (즉시·단일센터)  채혈 1회 3-axis panel + S4 결정맵 + CDS prototype       │
│                         = H6(4-trial portfolio)·H7(timeline)·H9(환자 본인) 실행 │
│ STEP 2 (6m·다기관)      KAMIR consortium MOU + registry-embedded 표준 워크플로  │
│                         = H6 의 A·C onramp(cath lab/imaging 공유)               │
│ STEP 3 (1y·증거)        LHS 루프 1차 readout + KSC 권고안 초안                  │
│                         = H8(honest limits/grade)이 정책 격상 근거로 전환        │
│ STEP 4 (3y·정책)        Class IIa→I 격상 + 적정성평가 편입 + 한·일·중 확장      │
│                         = H8 grade lockstep · H5(HORIZON 추적)·D trial          │
├──────────────────────────────────────────────────────────────────────────────┤
│ 배포 안전 원칙 (모든 STEP 공통):                                                │
│  · CDS = 의사결정 지원, 처방 아님 (override 항상 제공) ── DF4 책임소재          │
│  · 조건부 alert (top-1 stopping rule만) + override rate 모니터 ── DF1 alert      │
│  · evidence_grade X8 VERBATIM (CDS 새 등급 금지) ── DF5 over-read 차단          │
│  · numerical(🟢) ≠ 인과 확정 — IC-sync IIT·HORIZON 이 ground-truth gate         │
└──────────────────────────────────────────────────────────────────────────────┘
```

| DOCTOR H11 STEP | X31 어느 §이 채우나 | 연계 H1-H10 |
|---|---|---|
| STEP 1 즉시·단일센터 | §1 즉시 phase + §3 DF1-DF5 안전원칙 | H6(portfolio)·H7(timeline)·H9(환자) |
| STEP 2 6m·다기관 | §1 6m phase + §2 LHS 배포 루프 | H6(A·C onramp) |
| STEP 3 1y·증거 | §2 LHS readout + §4 KSC 초안 | H8(limits→정책 근거) |
| STEP 4 3y·정책 | §4 정책 격상 사다리 전체 | H8(grade lockstep)·H5(HORIZON) |

→ **H11 권고**: DOCTOR.md 에 `- [ ] H11 deployment playbook — handoff 이후 단일센터→전국→정책 단계 가이드 (배포=증거 LHS + 실패모드 예방) → DOCTOR/H11_deployment.md` milestone 추가 권고. 본 X31 §1-§4 가 H11 골격 feed 제공(§5 STEP↔§ 매핑). DOCTOR/ 파일은 X31 이 수정하지 않음 — feed 만 제공.

---

## §6. g5 grade — X31 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 단계 roadmap 표 | ⚪ (timeline/gate) + 🟡/🟢 (trial 연계 VERBATIM) | phase·gate 진입조건 = ⚪ proposal · trial 규제 lift/grade = X5 §4/§5.3/§6 VERBATIM |
| §2 LHS 배포=증거 루프 | 🟡 (compositional) + ⚪ (공진화 proposal) | registry-embedded = X5 §1 Trial-B + X22 4순위 VERBATIM · 공진화 루프는 X31 가공 |
| §3 배포 실패모드 + 예방 | 🟡 (carry) + ⚪ (예방 효과 proposal) | X22 alert/override + X16 stopping rule + X13 실패모드 VERBATIM · 예방 효과 = ⚪ |
| §4 정책 격상 경로 | ⚪ (격상 proposal) + 🟢/🟡/🔴 (선결 증거 VERBATIM) | Class 등급·편입 = ⚪ · 선결 grade = X5 §6/X18 §3 VERBATIM |
| §5 H11 playbook | ⚪ (proposal) | DOCTOR H11 = 신규 milestone 후보 · DOCTOR/ 수정 0 (feed only) |

**X31 종합 등급**: ⚪ SPECULATION-FENCED (배포 timeline·gate·정책 격상은 설계 가정 proposal) over 🟡 (trial grade·규제 lift·wall path·국제 transport 는 X5/X8/X9/X18/X22/X13 VERBATIM carry) — **배포 로드맵의 본질이 외부 gate(IRB·NHIS·KSC·복지부)-의존 단계 추정** 이므로 honest 하게 ⚪ fence. **X31 새 판정 0건**(per @D g5 · LLM self-judge 0건).

⚠ **honest fence (g5 + d2 + d6 + d1)**: 본 X31 의 배포 timeline·gate 진입조건·정책 격상 경로는 ⚪ proposal 이며 외부 gate 의존을 명시했다(§0 DISCLAIMER · §4). trial grade·규제 lift·wall path·국제 transport 는 X5/X8/X9/X18/X22/X13 VERBATIM carry(새 판정 0건). d2 — 5 배포 실패모드(DF1-DF5) 어느 것도 "배포 불가"로 닫지 않고 각각 예방 path 2-3개 명명. d6 — numerical(🟢) ≠ 인과 확정(X13 carry), LHS 관찰 outcome ≠ RCT 인과, Class I = RCT readout downstream 정직 명시. d1 — non-wet-lab 배포 로드맵·LHS 루프·실패모드 예방·정책 사다리 완결(실제 IRB/NHIS/KSC/복지부 gate 통과는 downstream).

---

## §7. X31 산출 요약

- **단계 roadmap**: 즉시(0m, 단일센터 pilot — B + 3-axis panel, 신규 IND 불요) → 6m(다기관 registry — KAMIR MOU + A enroll·C pre-IND) → 1y(증거 readout — LHS 1차 interim + KSC 초안) → 3y(전국 확산 + 정책 편입 — D enroll·Class 격상·적정성평가·국제 확장). 확산 축(단일센터→다기관→전국) = 시간 축과 정합, KAMIR backbone 이 단일 척추.
- **배포=증거 LHS**: registry-embedded 배포가 X5 trial(특히 B pragmatic) 을 *겸함* — ①배포 → outcome 데이터 → trial readout → grade/정책 갱신 → ⑤개선된 결정맵(다음 round). 배포와 증거가 분리된 두 단계가 아닌 단일 공진화 루프. D2(ICER)·D5(AI RCT)·N5(power) wall 을 LHS 가 동시에 낮춤. d6 — 관찰 outcome ≠ 인과(IC-sync IIT·HORIZON 이 ground-truth gate).
- **배포 실패모드 5(DF1-DF5)**: alert fatigue(최대) · 무분별 override · genotype 오해 · 책임소재 불명 · numerical→causal over-read. 각각 예방 path 2-3개(d2, 폐기 0). 최대 = **DF1 alert fatigue** — 조건부 alert(top-1 stopping rule만) + override rate 정량 모니터(X22 5순위)로 예방.
- **정책 격상 경로**: 권고 등급 ↔ 증거 등급 lockstep — registry 관찰 → Class IIb/IIa, RCT readout → Class I, 전국 확산 → 적정성평가 편입, 생물학 transport → 한·일·중 국제 정합(NHIS 급여·WTP는 한국 특이).
- **DOCTOR H11 권고**: handoff(H1-H10) 이후 단일센터→전국→정책 4-STEP playbook = H11 신규 milestone 후보(DOCTOR/ 수정 0, feed only). 배포 안전 원칙(CDS=처방 아님·조건부 alert·grade VERBATIM·numerical≠인과) 전 STEP 공통.
- **g5/d2/d6/d1 준수**: trial grade·규제 lift·wall path·transport = X5/X8/X9/X18/X22/X13 VERBATIM(새 판정 0건) · timeline·gate·정책 격상 = ⚪ proposal 명시 · 5 실패모드 전부 예방 path 보유(폐기 0) · numerical≠인과 정직 · 배포 로드맵 완결(외부 gate 통과는 downstream).

---

> ⚠ **하단 DISCLAIMER (반복)**: 본 X31 은 배포 전략 로드맵이며 배포 일정 확정·정책 격상 확약·outcome 예측이 아니다. 배포 timeline(즉시/6m/1y/3y)·gate 진입조건·정책 격상 경로(Class IIa→I·적정성평가)는 trial 규모·펀딩 phasing 에서 도출한 ⚪ proposal(설계 가정)이며 실제 IRB·NHIS·KSC 위원회·복지부 정책에 전적으로 의존한다. trial grade(🟢/🟠/🟡/🔴/⚪)는 X8/X5 §6 의 VERBATIM 인용이고 규제 lift·wall path·국제 transport 는 X5/X9/X18 VERBATIM 이며, X31 은 새 판정을 부여하지 않는다(LLM self-judge 0건). CDS/배포는 의사결정 지원이며 처방·진단·용량 지시가 아니다 — 모든 약제·검사·용량·중단 결정은 전적으로 담당 심장내과 전문의 판단이고, 환자는 항혈소판제를 임의 중단·변경하지 말 것(스텐트 혈전증 위험).
