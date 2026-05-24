# X29 — EMR-CDS 배포 설계 (X22 CDS spec → 한국 병원 EMR/cath lab 실배포)

> CARDIO+ 메타도메인 X29 산출물 · cross-cutting · current-state · no history.
> **목적 (1줄) = X22 결정지원 명세를 한국 병원 OCS/EMR에 best-practice alert(BPA)로 배포하는 기술 설계 — alert fatigue·override 처리, cath lab 워크플로우 내 POCT 삽입 타이밍, 클라우드 PGx SaaS scale-out(다병원 API)을 spec 수준에서 형식화한다. 본 문서는 배포 설계(deployment design)이며 구현(코드·서비스·실배포)이 아니다.**
> 출처 = X22 (CDS 알고리즘 spec — 입력/결정/출력/EMR 통합 VERBATIM) · X16 (§4 stopping rule / §2 출혈순위 / §4.1 alert top-1 VERBATIM) · X11 (§1 침상 결정흐름 / §5.1 오늘 가능 VERBATIM) · M15 (EMR CDS Hooks/FHIR spec) · M13 (caller validation). grade 는 X22/X16/X8 ledger VERBATIM — **X29 새 판정 0건** (per @D g5 · LLM self-judge 0건).

---

## ⚠ DISCLAIMER (반드시 읽기)

> 본 문서는 **결정지원 시스템의 배포(deployment) 기술 설계이며 처방·진단·용량 지시가 아니다.**
> - 모든 약제·검사·용량·중단 결정은 심장내과 전문의가 환자별(출혈위험 ARC-HBR · 시술 복잡도 · 신기능 · 연령/체중 · 동반약)로 종합 판단한다. BPA alert·CDS card 의 어떤 출력도 자동 처방으로 해석해서는 안 된다 — alert 는 **권고 + 근거 + override 사유**를 제시할 뿐 의사 결정을 대체하지 않는다.
> - 환자는 현 항혈소판제(특히 DAPT)를 **임의로 중단·변경하지 말 것** — 스텐트 혈전증 위험.
> - 근거 등급(g5)은 X22/X16/X8 verify verdict 의 **VERBATIM 인용**이다 (본 X29 가 새로 판정한 것이 아님 · LLM self-judge 0건). 배포 효과(alert override rate · turnaround 단축 임상영향 · concordance)는 ⚪/🟠 로 분리한다.
> - **배포 미실증(d6 정직)**: 본 X29 의 BPA 설계·POCT turnaround·SaaS scale-out 은 모두 **설계 명세이며 실 병원 배포·측정 0건**이다. alert override rate·alert fatigue 감소·POCT 90분 turnaround 임상영향은 전부 ⚪ SPEC-FENCED / 🟠 DEFERRED — 배포 후 audit 으로만 검증 가능하다. 어떤 배포 수치도 실측 결과로 제시하지 않는다.

---

## §0. g5 등급 규약 (rubric VERBATIM — `hexa verify rubric`)

| 등급 | 의미 (X29 내 용법) |
|---|---|
| 🔵 SUPPORTED-FORMAL | closed-form 산식 · atlas-registered recompute pass |
| 🟢 SUPPORTED-NUMERICAL | 시뮬레이션 / 수치 재계산 재현 가능 |
| 🟡 SUPPORTED-BY-CITATION | peer-review 1차 출처 cite (literature carry) |
| 🟠 INSUFFICIENT/DEFERRED | wet-lab · 임상 readout · 전향 cohort · 배포 audit 의존 — 현 단계 검증 불가 |
| 🔴 FALSIFIED | 명시적 reject (large RCT null 등) — 닫힌 음성, wall 아님 |
| ⚪ SPECULATION-FENCED | 본질적 미검증 (배포 효과 추정 · alert override rate · turnaround 임상영향) — ⚪ ≠ 거짓 |

> g5 준수: 본 §0 이하 모든 등급은 X22/X16/X8 ledger 의 verbatim 복사다. BPA trigger·alert 내용·severity 는 X22 §2.2 / X16 §4 VERBATIM, 출혈순위는 X16 §2 VERBATIM, EMR Hook/FHIR 은 X22 §4 (M15) VERBATIM 이다. 배포 자체의 override rate·fatigue 감소·turnaround 임상영향은 ⚪/🟠 로 분리한다. d6 — 억지 등급/숫자 강제 0건 · 배포 미실증 명시.

---

## §1. BPA(Best-Practice Alert) 설계 표 — X22 결정 트리 → OCS/EMR alert

> trigger = X22 §4 EMR 통합 포인트(CDS Hook) + §2 결정 분기 VERBATIM. alert 내용·severity·stopping rule = X22 §2.2 / X16 §4 VERBATIM. **override 허용/fatigue 방지는 본 X29 의 배포 설계 — 단 약물 안전 신호 자체는 sub-doc VERBATIM** (override 정책은 alert fatigue 대응 설계이며 임상 효과는 ⚪).

| trigger (CDS Hook · 조건) | alert 내용 (X22/X16 VERBATIM) | severity (X22 §3.1 indicator) | override 허용? | fatigue 방지 (중복억제 · 관련성 게이팅) |
|---|---|---|---|---|
| **`order-sign` · prasugrel 처방 ∧ age ≥75** | "≥75세 prasugrel generally not recommended (FDA) → clopidogrel 또는 ticagrelor 재라우팅" (X16 §4 / M12 §5.6) | **critical** (hard gate) | **불가** (hard stop) — 사유 필수 기록 후만 진행 (audit log) | 환자당 1회만 (해당 처방 시점) · phenotype 무관 게이트라 phenotype card 와 중복 부착 안 함 · 처방 변경 시 재평가 |
| **`medication-prescribe` · prasugrel 처방 ∧ weight <60kg** | "⚠ <60kg prasugrel 감량/회피 검토" (X22 §2.1 / X16 §1.2) | warning | 허용 (사유 1택) | hard gate 와 동시 발화 금지 (≥75세면 critical 이 우선) · 동일 처방세션 내 1회 |
| **`medication-prescribe` · ticagrelor 처방 ∧ comed_cyp3a4 ∧ age ≥75** | "ticagrelor 회피 (CYP3A4 약물상호작용 출혈 · M12)" (X22 §2.1) | **critical** | **불가** (hard stop) | polypharmacy 노인 cell 에만 발화 (관련성 게이팅) · CYP3A4 약물 추가 시에만 재평가 |
| **★ `medication-prescribe` · ticagrelor 처방 (PM × HBR-low select cell)** | "★ Month-1~ 출혈/호흡곤란/서맥 monthly 모니터 · 즉시 trigger=BARC≥2·흉통재발·dyspnea → clopidogrel switch" (X16 §4.1 top-1 / M12 §5.6 · Kim 2024) | **critical** (한국 최대 약물 안전 신호) | 허용 (의사 출혈균형 판단) — 단 모니터 booking 은 강제 첨부 | **ticagrelor 선택 cell 에만 발화** (universal 아님 · X16 §2 가드레일) · 처방 1회 시점 alert + Month-1 follow-up booking 으로 분리 (반복 처방 화면 alert 없음) |
| **`medication-prescribe` · prasugrel 5mg 처방 (IM/PM × HBR-low)** | "Day7-14 wound·Hb·Cr·BARC diary" (X22 §2.2 / X16 §1.2) | warning | 허용 | 처방 시점 1회 + diary 항목은 EMR order set 으로 첨부 (반복 alert 아님) |
| **`patient-view` · CYP2C19 phenotype 존재** | phenotype·HBR·complexity 배지 표시 (PM/IM/NM + HBR-high) (X22 §4) | info (배지) | N/A (비차단 배지) | **passive 배지** — pop-up 아님 · chart 열림 1회 · 결과 변동 시에만 갱신 (alert fatigue 0) |
| **`medication-prescribe` · phenotype=PM ∧ clopidogrel 단독 처방** | "PM clopidogrel 효과 大저하(HTPR · ST 위험) → prasugrel 5mg/ticagrelor 또는 PFT 확인 검토" (X11 §2.2 / X16 §1.2) | warning | 허용 (HBR-high 시 clopi+PFT 가 정당 경로) | HBR-high cell 이면 발화 억제 (clopi+PFT 가 §2.2 권고이므로 관련성 게이팅) · 처방세션 1회 |
| **`appointment-book` · ticagrelor cell** | Month-1 monthly 모니터 예약 자동 추가 (X22 §4) | info (booking) | 허용 (일정 조정) | alert 아닌 **booking action** — 화면 interrupt 0 |
| **`order-sign` · 모든 P2Y12 처방** | "DAPT 임의 중단 금지 (ST 위험)" (X22 §2 ③ / X16 §4 공통) | info (환자교육 첨부) | N/A | sign-off 시 1회 첨부 (pop-up 아님 · 환자 안내문 print) · 반복 처방 시 미발화 |

> **BPA 설계 핵심**: severity 는 X22 §3.1 indicator(info/warning/critical)에 1:1 mapping. **hard gate(≥75세 prasug · CYP3A4+노인 ticag)만 override 불가(critical hard stop)** — 나머지는 의사 임상 판단(출혈균형·HBR)을 존중해 override 허용. alert 의 약물 안전 신호 자체는 X16 §4 stopping rule VERBATIM 이나, **override 정책·fatigue 게이팅은 본 X29 배포 설계이며 그 임상 효과(override rate·fatigue 감소)는 ⚪ SPEC-FENCED** (배포 audit 의존, X22 §5.1 5순위 alert override rate VERBATIM).

### 1.1 alert fatigue 방지 — 4-layer 게이팅 (배포 설계)

> alert fatigue = "과다 alert → 의사가 모든 alert 를 습관적 override → 진짜 critical 도 무시"되는 배포 실패 모드. X22 §5.1 5순위 metric(alert override rate · alert fatigue 평가) VERBATIM 을 배포 단계에서 4-layer 로 선제 차단. **본 절은 배포 설계 — 효과는 ⚪ (audit 의존).**

```
 alert 발화 후보 (결정 트리 매 분기마다 잠재 alert)
   │
   ▼ ① 관련성 게이팅 (relevance gate)
   │    · cell-specific 발화만: ticag Month-1 alert = ticagrelor 선택 cell 에만 (universal 아님)
   │    · HBR-high × PM = clopi+PFT 가 정당 경로 → clopi 단독 경고 억제
   │    · CYP3A4 alert = polypharmacy 노인에만 (X16 §3.2 충돌3 cell)
   │
   ▼ ② 중복억제 (de-duplication)
   │    · 동일 처방세션 내 동일 trigger 1회만 · 환자당 hard-gate 1회
   │    · critical 발화 시 하위 warning 동시발화 금지 (severity 최댓값만 표시)
   │    · passive 배지(patient-view)는 pop-up alert 와 합치지 않음
   │
   ▼ ③ severity 분리 (interrupt 최소화)
   │    · critical(hard stop) = modal pop-up · warning = inline 비차단 · info = 배지/안내문
   │    · Month-1 모니터 = alert 아닌 booking action (화면 interrupt 0)
   │
   ▼ ④ override 사유 구조화 + audit (X22 §3.1 overrideReasons VERBATIM)
   │    · override 시 {patient-preference, drug-allergy, other} 1택 강제 기록
   │    · audit log 축적 → override rate 모니터 → 고-override alert 재튜닝 (배포 후 loop)
   │
   ▼ 발화 (의사에게 최소·관련 alert 만 도달)
```

| layer | 기법 | 근거 (VERBATIM) | grade |
|---|---|---|---|
| ① 관련성 게이팅 | cell-specific 발화 (universal alert 금지) | X16 §2 "universal ticagrelor 거부 — PM×HBR-low cell 에서만" VERBATIM | 🟡 (가드레일 cite) |
| ② 중복억제 | 처방세션 1회 · severity 최댓값만 | X29 배포 설계 (구조적 de-dup) | ⚪ (효과 audit 의존) |
| ③ severity 분리 | critical=modal / warning=inline / info=배지 | X22 §3.1 indicator VERBATIM mapping | 🟡 (indicator cite) |
| ④ override 구조화 + audit | overrideReasons 강제 + override rate loop | X22 §3.1 overrideReasons + §5.1 5순위 alert override rate VERBATIM | ⚪ (override rate 미측정) |

> **fatigue 방지 핵심 = ① 관련성 게이팅** — 가장 위험한 ticagrelor Month-1 alert(X16 §4.1 top-1)를 **ticagrelor 선택 cell 에만** 발화시켜(universal 금지) 진짜 critical 신호가 alert 홍수에 묻히지 않게 한다. 단 게이팅이 실제 override rate 를 낮추는지는 **⚪ SPEC-FENCED**(X22 §5.1 5순위 — 전향 audit log 의존, 미측정).

---

## §2. cath lab 워크플로우 ASCII — 입실 → 채혈/POCT → 시술 → genotype 결과 → 결정

> X11 §1 침상 결정흐름(primary PCI → 채혈 1회 3-axis 패널 → DAPT 분기) VERBATIM 을 cath lab 물리 워크플로우에 배치. **#28 채취시점·결정 타이밍**: genotype POCT 를 cath lab 내부에 배치하면 시술 중/직후 결정 창에 phenotype 이 도착할 수 있다 (turnaround 의존). **POCT 위치·타이밍은 배포 설계 — 임상영향은 ⚪/🟠.**

```
╔══════════════════════════════════════════════════════════════════════════════════════╗
║  cath lab 워크플로우 + genotype POCT 삽입 (X11 §1 침상 흐름 VERBATIM 배치)              ║
╚══════════════════════════════════════════════════════════════════════════════════════╝

 [T+0min] 환자 입실 (STEMI activation)
   │  · 표준 loading (aspirin + P2Y12 — 결과 前이라 통상 clopidogrel/ticagrelor · X11 §1 VERBATIM)
   │  · BPA: patient-view → 과거 genotype 있으면 배지 표시 (재시술 환자)
   ▼
 [T+0~5min] ★ 동맥천자 시 동시 채혈 (3-axis 패널 1회 · X11 §1 분기점)  ◄── 채취시점 #28
   │  · sheath insertion 시 혈액 1 tube → CYP2C19 POCT cartridge 즉시 load
   │  · POCT 장비 = cath lab 내부 배치 (검체 이송 0분 · 중앙검사실 왕복 제거)  ◄── POCT 위치 #4
   │  · Lp(a)/ALDH2*2 = 동일 채혈분 → 중앙검사 (시술 중 결정 비-필수 · 평생 1회)
   ▼
 [T+0~60min] primary PCI (관상동맥 재관류)
   │  ┌──── no-reflow 분기 (N축 · X11 §1 VERBATIM) ────┐
   │  │  TIMI≤2 → IC adenosine 24mg distal ± nicorandil │  (시술 당시 IC = 1차 · 패널 무관)
   │  └────────────────────────────────────────────────┘
   │
   │  ◄═══ [T+~90min] CYP2C19 POCT 결과 도착 (cath lab 내 PCR · turnaround #4) ═══►
   │       phenotype {NM/RM, IM, PM, UM} → CDS 입력 (X22 §1.1)
   ▼
 [T+~60~90min] 시술 종료 · sheath 제거 결정 시점  ◄── 결정 타이밍 #28
   │  · ★ POCT가 90분 turnaround 면 → 시술 종료~퇴실 전 결정 창에 phenotype 도착 가능
   │  · medication-prescribe Hook → X22 §2 결정 트리 실행:
   │      ① hard gate (≥75세 prasug 회피 · <60kg 주의)
   │      ② phenotype×HBR 분기 (NM→clopi · IM/PM×HBR-low→prasug 5mg · PM×HBR-high→clopi+PFT)
   │      ③ 안전 alert 부착 (ticag → Month-1 모니터 BPA)
   ▼
 [T+90min~] 회복실 / 입원 · order-sign Hook
   │  · 금기 게이트 cross-check + override 사유 audit log (X22 §4)
   │  · DAPT 처방 확정 (P2Y12 maintenance) · 자의중단 금지 안내문 첨부
   ▼
 [퇴원~Month-1] appointment-book Hook
   │  · ticagrelor cell → Month-1 monthly 모니터 예약 자동 booking (X16 §4 alert→booking)
   ▼
 [6m/3y] X11 §5 timeline 추적 (D축 재평가 · L축 Lp(a) PCSK9 · I축 surveillance)
```

> **워크플로우 핵심 (#28 타이밍)**: ① **채취시점** = sheath insertion 시 동시 채혈(추가 천자 0 · X11 "채혈 1회"). ② **POCT 위치** = cath lab 내부(검체 이송 0). ③ **결정 타이밍** = POCT 90분 turnaround 면 phenotype 이 **시술 종료~퇴실 전 DAPT 처방 결정 창**에 도착 가능 → loading 단계의 "결과 전 통상 처방"을 maintenance 단계에서 phenotype-guided 로 교정. **단 시술 중 결정에 phenotype 을 의존시키지 않음** — loading 은 결과 전 표준(X11 §1 VERBATIM), POCT 는 maintenance 결정을 앞당기는 enabler 다. 90분 turnaround 의 실제 임상영향(결정 변경률·outcome)은 ⚪/🟠 (배포 audit 의존).

---

## §3. POCT vs 중앙검사 turnaround 비교 (시술 중 결정 가능성)

> #4 cath lab 내 PCR 90분 — POCT(cath lab 내부) vs 중앙검사실(central lab)의 turnaround 와 결정 창 정합. **turnaround 시간은 장비 사양·배포 설계 가정이며 실측 0건 — 결정 가능성은 ⚪/🟠.**

| 항목 | 중앙검사실 (central lab) | cath lab POCT (내부 PCR) |
|---|---|---|
| 검체 이송 | 채혈 → 중앙검사실 왕복 (분~시간) | **0분** (cath lab 내부 cartridge load) |
| genotyping turnaround | batch 처리 · 통상 수일~1주 (선별급여 PCR C5946 정규 경로) | **~90분** (single-cartridge PCR · 설계 목표) |
| 결과 도착 시점 | 퇴원 후 외래 (6m 재평가 시점, X11 §5) | **시술 종료~퇴실 전** (T+~90min) |
| 시술 중 결정 가능성 | ❌ 불가 (결과 시술 후 수일) | △ maintenance 결정 창에 도착 가능 (loading 은 여전히 결과 전) |
| DAPT 결정 시점 | maintenance 를 통상 처방 후 외래에서 phenotype-guided 재배치 (X11 6m) | maintenance 처방을 **퇴실 전 phenotype-guided** 로 결정 |
| caller 정확도 (입력 gate) | KOVA/KRGDB ref 대비 concordance | 동일 — POCT cartridge caller concordance 검증 필요 (X22 §5.1 1순위) |
| 비용/배포 | 기존 NHIS 급여 경로 (X11 §5.1 "오늘 가능") | POCT 장비 + cartridge 단가 (병원 도입 비용) |

> **POCT 가 바꾸는 결정 타이밍**: 중앙검사 경로에서는 phenotype 이 **퇴원 후 외래(6m 재평가)**에 도착해 maintenance DAPT 를 "통상 처방 후 재배치"한다(X11 §5). cath lab POCT(~90분)는 phenotype 을 **시술 종료~퇴실 전 결정 창**으로 당겨, maintenance 처방을 **첫 처방부터 phenotype-guided** 로 한다 — "처방 후 교정"에서 "처방 전 결정"으로 타이밍이 이동한다. **단 (1) loading 은 여전히 결과 전 표준이고(X11 §1), (2) 결정 트리는 deterministic 하므로 입력 phenotype 정확도가 최상위 gate** — POCT caller concordance 검증이 turnaround 단축보다 선행한다(X22 §5.1 1순위 caller concordance 🟠 DEFERRED VERBATIM). 90분 turnaround 달성·결정변경률·outcome 은 모두 ⚪/🟠 (배포 audit 의존).

---

## §4. 클라우드 PGx SaaS scale-out 아키텍처 (#21 다병원 API)

> #21 다병원 — 중앙 genotype-CDS API 를 클라우드 SaaS 로 두고 다병원이 FHIR/CDS Hooks 로 호출. X22 §4 EMR 통합(CDS Hooks/FHIR · BESTCare/AMIS readiness) VERBATIM 을 multi-tenant 아키텍처로 scale-out. **아키텍처는 배포 설계 — 다병원 통합 효과·확장성은 ⚪.**

```
╔══════════════════════════════════════════════════════════════════════════════════════╗
║  중앙 genotype-CDS API (multi-tenant SaaS) → 다병원 EMR (X22 §4 CDS Hooks/FHIR VERBATIM)║
╚══════════════════════════════════════════════════════════════════════════════════════╝

   병원 A (BESTCare 2.0)      병원 B (AMIS)         병원 C (기타 EMR)
   FHIR R4 + CDS Hooks        FHIR R4 production    CDS Hooks client
        │                          │                     │
        │  (CDS Hooks 요청: patient-view·medication-prescribe·order-sign·appointment-book)
        │  FHIR resource: Patient·Observation·Condition·Procedure·MedicationStatement (X22 §4)
        ▼                          ▼                     ▼
   ┌──────────────────────────────────────────────────────────────────────────┐
   │  API Gateway (TLS · 병원별 tenant 인증 · 환자 식별 de-link · 감사)         │
   │  ※ d4: 단일 generic dispatch — 병원 추가 = tenant manifest 추가 (이름 분기 0)│
   └───────────────────────────────────┬──────────────────────────────────────┘
                                        ▼
   ┌──────────────────────────── 중앙 genotype-CDS 엔진 ───────────────────────┐
   │  ① 입력 검증     : X22 §1 입력 스키마 계약 (FHIR → 12 변수, 필수 5 확인)    │
   │  ② 결정 트리     : X22 §2 deterministic backbone (hard gate → phenotype×HBR)│
   │  ③ 출력 조립     : X22 §3 CDS card JSON (recommendation·indicator·grade·alert)│
   │  ④ grade carry   : X8 ledger VERBATIM 첨부 (엔진이 새 등급 산출 금지)        │
   │  (M17 AI/ML refinement layer = 선택 overlay · backbone 대체 아님, X22 §5.3)  │
   └───────────────────────────────────┬──────────────────────────────────────┘
                                        ▼
   ┌──────────────────────────── 데이터 store (tenant 격리) ───────────────────┐
   │  · genotype store : CYP2C19 phenotype/diplotype (병원별 격리 · 평생 1회 재사용)│
   │  · audit log      : override 사유 + alert 발화/수용 (X22 §3.1 · §5.1 5순위)  │
   │  · grade ledger   : X8 VERBATIM (read-only · CDS 가 변경 금지)               │
   └──────────────────────────────────────────────────────────────────────────┘
        │
        ▼  CDS card JSON 반환 → 각 병원 EMR 가 §1 BPA 로 렌더 (severity 별 modal/inline/배지)

  데이터 흐름 (단방향 권고 · 자동 처방 아님):
   병원 EMR ──FHIR resource──► 중앙 API ──CDS card(권고+grade+alert+override)──► 병원 EMR
                                                                          │
                                                              의사 판단 → override/수용 → audit 회신
```

| 아키텍처 요소 | 설계 | 근거 (VERBATIM) | grade |
|---|---|---|---|
| 표준 인터페이스 | CDS Hooks 4종 + FHIR R4 resource 1:1 mapping | X22 §4 (M15 §2·§4) VERBATIM · "FHIR mapping 으로 vendor lock-in 회피" | 🟡 (M15 cite) |
| multi-tenant dispatch | 병원 추가 = tenant manifest only (이름 분기 0) | @D d4 single generic dispatch | 🟡 (governance) |
| 결정 엔진 | deterministic 결정 트리 backbone (explainable) | X22 §2 / §5.3 "ML 단독 = explainability gap → EMR 통합 실패 위험" VERBATIM | 🟡 (M17 cite) |
| grade carry | X8 ledger VERBATIM 첨부, 엔진 새 판정 금지 | X22 §3 "evidence_grade 는 X8 VERBATIM" VERBATIM | 🟡 |
| genotype 재사용 | phenotype 평생 1회 → 재PCI/타병원 재사용 (tenant 격리) | X11 §1 "유전 결정 ~90% → 평생 1회" VERBATIM | 🟡 |
| 다병원 통합 효과 | scale-out 확장성·다병원 concordance | 미배포 — 배포 audit 의존 | ⚪ SPEC-FENCED |

> **SaaS scale-out 핵심**: 중앙 엔진은 **X22 §2 deterministic backbone 1개**를 모든 병원이 공유 — @D d4 에 따라 병원 추가는 tenant manifest 추가일 뿐(병원명 분기 0). genotype 은 평생 1회 측정이므로(X11 §1) 환자가 타병원 재방문해도 phenotype 재사용 가능(tenant 격리 + 환자 동의 전제). M17 AI/ML 은 backbone 대체가 아닌 선택 overlay(X22 §5.3 VERBATIM) — explainability gap 으로 EMR 통합 실패하지 않도록 deterministic backbone 유지. **다병원 scale-out 의 실제 확장성·통합 효과는 ⚪** (미배포).

---

## §5. 배포 단계 (단일 EMR pilot → 통합)

> X22 §4 EMR readiness(BESTCare 최우선 → AMIS) + §5 검증 계획(caller concordance → 결정 일치율 → audit) VERBATIM 을 배포 stage 로 정렬. **각 stage 의 효과 metric 은 ⚪/🟠 (미실행).**

```
 stage 0  ── caller concordance 검증 (X22 §5.1 1순위 · 배포 전 최상위 gate) ── 🟠 DEFERRED
   │           POCT/중앙 caller vs KOVA/KRGDB ref · M13 caller validation
   │           [결정 트리 deterministic → 입력 phenotype 정확도가 출력 정확도의 상위 gate]
   ▼
 stage 1  ── 단일 EMR pilot (BESTCare 2.0 · 최우선 partner · X22 §4 VERBATIM) ── ⚪ 미측정
   │           · CDS Hooks pilot 환경 · shadow mode (alert 표시만, 처방 비간섭)
   │           · retrospective 50명 결정 일치율 (X22 §5.1 2순위) · IRB
   ▼
 stage 2  ── BPA live (단일 EMR · alert 발화 ON) ── ⚪ alert override rate 미측정
   │           · §1 4-layer fatigue 게이팅 적용 · override audit log 축적
   │           · 금기 게이트 sensitivity (≥75세·<60kg 누락 0건, X22 §5.1 3순위) 🟠
   ▼
 stage 3  ── cath lab POCT 통합 (~90분 turnaround · §2 워크플로우) ── 🟠 turnaround 미실측
   │           · POCT cartridge caller concordance 재검증 · 결정 타이밍 측정
   ▼
 stage 4  ── 다병원 SaaS scale-out (AMIS production + 다병원 · §4 아키텍처) ── ⚪ 확장성 미검증
   │           · multi-tenant API · tenant 추가 = manifest only (d4)
   ▼
 stage 5  ── 전향 cohort RCT (CDS-guided vs usual care · MACE/bleeding 1y) ── 🟠 DEFERRED 12-24mo
               [X22 §5.1 4순위 · M15 §8 stage 5 · KAMIR+KSC 연계]
```

| stage | 내용 | 검증 metric (X22 §5.1) | grade (VERBATIM) |
|---|---|---|---|
| 0 caller concordance | 입력 phenotype 정확도 (배포 전 gate) | caller concordance (1순위) | 🟠 DEFERRED (cohort 의존) |
| 1 단일 EMR pilot (shadow) | BESTCare CDS Hooks · retrospective 50명 | 결정 일치율 (2순위) | ⚪ SPEC-FENCED (미측정) |
| 2 BPA live | alert 발화 + fatigue 게이팅 + audit | alert override rate (5순위) · 게이트 sensitivity (3순위) | ⚪ / 🟠 |
| 3 cath lab POCT | 90분 turnaround 통합 | turnaround · 결정 타이밍 | 🟠 (미실측) |
| 4 다병원 SaaS | multi-tenant scale-out (AMIS+다병원) | 다병원 concordance·확장성 | ⚪ SPEC-FENCED |
| 5 전향 cohort RCT | CDS-guided vs usual care MACE 1y | 전향 outcome (4순위) | 🟠 DEFERRED (12-24mo) |

> **배포 단계 핵심**: **stage 0 caller concordance 가 모든 배포에 선행**한다 — 결정 트리가 deterministic 하므로(X22 §2) 입력 phenotype 이 틀리면 BPA 출력도 틀린다(X22 §5.1 1순위 VERBATIM). pilot 은 **shadow mode**(alert 표시만, 처방 비간섭)로 시작해 결정 일치율을 먼저 평가한 뒤 alert 발화를 켠다 — alert fatigue·override rate 가 검증되기 전에 live 차단을 강제하지 않는다(d6 정직). 단일 EMR(BESTCare) → POCT → 다병원 SaaS → RCT 순. **모든 stage 1+의 효과(일치율·override rate·turnaround·outcome)는 ⚪/🟠 — 배포 미실증(d6).**

---

## §6. g5 grade — X29 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 BPA 설계 표 | 🟡 + ⚪ (compositional) | trigger/alert/severity = X22 §2.2·§3.1·§4 + X16 §4 VERBATIM · override 정책·fatigue 게이팅 = 배포 설계 (효과 ⚪) |
| §1.1 fatigue 4-layer 게이팅 | 🟡 + ⚪ | 관련성 게이팅 = X16 §2 가드레일 VERBATIM · 중복억제·override rate 효과 = ⚪ (audit 의존) |
| §2 cath lab 워크플로우 | 🟡 + 🟠 | X11 §1 침상 흐름 VERBATIM 배치 · POCT 위치/타이밍 = 배포 설계 · 90분 임상영향 🟠 |
| §3 POCT vs 중앙검사 | 🟡 + 🟠/⚪ | turnaround 경로 = 설계 가정 · 결정 타이밍 이동 = 설계 · 90분 달성·결정변경률 ⚪/🟠 · caller concordance 1순위 🟠 (X22 §5.1) |
| §4 SaaS scale-out | 🟡 + ⚪ | CDS Hooks/FHIR = X22 §4 (M15) VERBATIM · d4 dispatch · 다병원 확장성 ⚪ |
| §5 배포 단계 | 🟠 + ⚪ | stage 0 caller concordance 🟠 · 일치율/override rate ⚪ · RCT 🟠 DEFERRED (X22 §5.1 VERBATIM carry) |

**X29 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — X22 CDS spec + X16 §4 stopping rule + X11 §1 침상 흐름 + M15 EMR CDS Hooks/FHIR 를 **한국 병원 EMR/cath lab BPA 배포 + POCT turnaround + 다병원 SaaS scale-out 기술 설계로 형식화**. **X29 새 판정 0건** (per @D g5 · LLM self-judge 0건). BPA trigger·alert·severity·stopping rule 은 X22/X16 VERBATIM carry · CDS Hooks/FHIR 은 X22 §4 (M15) VERBATIM · grade 는 X8 ledger VERBATIM 첨부(엔진 새 판정 금지) · 결정 엔진 = deterministic backbone(M17 AI/ML 은 선택 overlay, 대체 아님) · **배포 효과(alert override rate · 결정 일치율 · POCT 90분 turnaround 임상영향 · 다병원 확장성 · cohort outcome)는 전부 ⚪/🟠 정직 격리(d6 — 배포 미실증 명시)** · "결정지원, 처방 아님" 톤 · completed-form 배포 설계(d1).

---

## §7. X29 산출 요약

- **BPA 설계 (#1)**: X22 결정 트리 9개 trigger 를 OCS/EMR alert 로 mapping — severity = X22 §3.1 indicator(info/warning/critical) 1:1. **hard gate(≥75세 prasug · CYP3A4+노인 ticag)만 override 불가(critical hard stop)**, 나머지는 의사 임상 판단(출혈균형·HBR) 존중해 override 허용. alert 약물 신호는 X16 §4 VERBATIM.
- **alert fatigue 방지**: 4-layer 게이팅 — ① 관련성 게이팅(cell-specific 발화, universal 금지) ② 중복억제(세션 1회·severity 최댓값) ③ severity 분리(critical=modal/warning=inline/info=배지) ④ override 사유 구조화+audit. 핵심 = ① 관련성 게이팅으로 ticag Month-1 alert 를 ticagrelor cell 에만 발화.
- **cath lab 워크플로우 (#28·#4)**: sheath insertion 시 동시 채혈 → cath lab 내부 POCT(이송 0) → ~90분 turnaround 면 phenotype 이 시술 종료~퇴실 전 maintenance 결정 창에 도착. loading 은 결과 전 표준 유지.
- **POCT turnaround (#4)**: 중앙검사(수일, 퇴원 후 외래 도착) vs cath lab POCT(~90분, 퇴실 전) — 결정 타이밍이 "처방 후 교정"에서 "처방 전 phenotype-guided 결정"으로 이동. 단 caller concordance(X22 §5.1 1순위)가 turnaround 단축보다 선행.
- **SaaS scale-out (#21)**: 중앙 genotype-CDS API(deterministic backbone 1개) → 다병원 CDS Hooks/FHIR(X22 §4 VERBATIM) · @D d4 — 병원 추가 = tenant manifest only · genotype 평생 1회 재사용 · M17 AI/ML = 선택 overlay(대체 아님).
- **배포 단계**: stage 0 caller concordance(선행) → 1 단일 EMR shadow pilot(BESTCare) → 2 BPA live + fatigue 게이팅 → 3 cath lab POCT → 4 다병원 SaaS → 5 전향 RCT.
- **g5/d1/d6 준수**: 새 판정 0건 · grade X22/X16/X8 VERBATIM · **배포 효과(override rate·일치율·turnaround·확장성·outcome) ⚪/🟠 정직 격리 · 배포 미실증 명시(d6)** · 결정 엔진 deterministic backbone(AI/ML 대체 아님) · completed-form 배포 설계 · 처방 아님 톤.

---

> ⚠ **하단 DISCLAIMER (반복)**: 본 문서는 결정지원 시스템의 배포 기술 설계이며 처방·진단·용량 지시가 아니다. BPA alert·CDS card 출력은 권고 + 근거 + override 사유를 제시할 뿐 의사 결정을 대체하지 않으며, 모든 약제·검사·용량·중단 결정은 전적으로 담당 의료진 판단이다. 환자는 항혈소판제를 임의 중단·변경하지 말 것(스텐트 혈전증 위험). 근거 등급은 X22/X16/X8 verify verdict 의 verbatim 인용이고, **배포 효과(alert override rate · 결정 일치율 · POCT 90분 turnaround 임상영향 · 다병원 SaaS 확장성 · cohort outcome)는 모두 미배포·미측정 영역(⚪/🟠)이며 본 X29 의 어떤 배포 설계도 실 병원 배포·측정 결과로 제시하지 않는다 (d6 정직).**
