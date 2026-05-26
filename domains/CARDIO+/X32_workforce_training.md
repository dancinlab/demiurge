# X32 — CARDIO+ 교육·인력 설계 (workforce/training · PGx-guided care 배포의 인적 역량)

> CARDIO+ 메타도메인 X32 산출물 · cross-cutting · current-state · no history.
> **목적 (1줄) = X22 CDS spec·X29 EMR/cath lab 배포·X30 채택 lever 가 깔린 PGx-guided DAPT 배포에서, 실제로 그것을 운영할 _사람_의 역량을 설계한다 — (a) 심장내과 수련·CME 교육 모듈로 전공의·전문의·약사·간호가 결정맵을 인지·해석·적용하게 만들고, (b) 한국 genetic counselor 부족이라는 PGx 해석 인력 병목을 임상약사 PGx 클리닉(X30 #6)+CDS 자동해석(X22)으로 보완하는 경로를 형식화한다. 본 문서는 인적 역량 설계(workforce design)이며 교육 커리큘럼·인력 충원의 실집행이 아니다.**
> 출처 = X22 (CDS 알고리즘 spec — deterministic 결정 트리·grade carry·AI/ML refinement layer VERBATIM) · X29 (EMR/cath lab 배포·BPA·POCT·SaaS scale-out VERBATIM) · X30 (#6 약사 주도 클리닉 lever·#5 시간 장벽·lever↔장벽 매핑 VERBATIM) · X16 (§2 출혈순위·§4 ticagrelor stopping rule VERBATIM). grade 는 X8 ledger / X22 / X16 / X30 VERBATIM — **X32 새 판정 0건** (per @D g5 · LLM self-judge 0건). **인력 수치·교육 효과는 전부 ⚪ proposal** (실측 전).

---

## ⚠ DISCLAIMER (반드시 읽기)

> 본 문서는 **PGx-guided care 배포의 인적 역량(교육·인력) 설계 자료이며 처방·진단·용량 지시도, 면허/수가 행정 결정도 아니다.**
> - 모든 약제·검사·용량·중단 결정은 심장내과 전문의가 환자별(출혈위험 ARC-HBR · 시술 복잡도 · 신기능 · 연령/체중 · 동반약)로 종합 판단한다. 본 문서의 교육 모듈·역할 분담·약사 클리닉 설계의 어떤 항목도 자동 처방·비-의사 단독 처방으로 해석해서는 안 된다 — 약사·간호·CDS 는 **해석·상담·자동화 지원**이며 처방 결정은 의사 권한이다.
> - 환자는 현 항혈소판제(특히 DAPT)를 **임의로 중단·변경하지 말 것** — 스텐트 혈전증 위험.
> - 근거 등급(g5)은 X8 ledger / X22 / X16 / X30 verify verdict 의 **VERBATIM 인용**이다 (본 X32 가 새로 판정한 것이 아님 · LLM self-judge 0건).
> - **인력 수치·교육 효과 미실증(d6 정직)**: 본 X32 의 한국 genetic counselor 부족 규모·약사 클리닉 인력 gap·교육 모듈의 결정맵 준수율 향상 효과·CME 이수 후 채택률은 모두 **방향성 설계 명세이며 실측 0건**이다. 어떤 인력 수치·교육 효과도 확정치로 제시하지 않으며 전부 ⚪ proposal / 🟠 DEFERRED 로 격리한다. genetic counselor 면허·임상약사 행위 수가는 한국 제도 현황 인용 영역이며 본 문서가 행정 결정하지 않는다.

---

## §0. g5 등급 규약 (rubric VERBATIM — `hexa verify rubric`)

| 등급 | 의미 (X32 내 용법) |
|---|---|
| 🔵 SUPPORTED-FORMAL | closed-form 산식 · atlas-registered recompute pass |
| 🟢 SUPPORTED-NUMERICAL | 시뮬레이션 / 수치 재계산 재현 가능 |
| 🟡 SUPPORTED-BY-CITATION | peer-review 1차 출처 cite (literature carry) |
| 🟠 INSUFFICIENT/DEFERRED | wet-lab · 임상 readout · 전향 cohort · 배포/교육 audit 의존 — 현 단계 검증 불가 |
| 🔴 FALSIFIED | 명시적 reject (large RCT null 등) — 닫힌 음성, wall 아님 |
| ⚪ SPECULATION-FENCED | 본질적 미검증 (인력 수치 추정 · 교육 효과 · 채택률 향상) — ⚪ ≠ 거짓 |

> g5 준수: 본 §0 이하 모든 등급은 X8 ledger / X22 / X16 / X30 의 verbatim 복사다. 교육 모듈의 _내용_(결정맵 분기·안전 alert·grade)은 X22 §2 / X16 §4 VERBATIM, 약사 클리닉 lever 는 X30 #6 VERBATIM, CDS 자동해석은 X22 §2/§5.3 VERBATIM 이다. 인력 부족 규모·교육 효과·CME 후 채택률은 ⚪/🟠 로 분리한다. d6 — 억지 등급/숫자 강제 0건 · 인력·교육 효과 미실증 명시.

---

## §1. 교육 모듈 표 — 대상별 PGx-DAPT 커리큘럼 + CME (#9)

> #9 심장내과 수련에 PGx-DAPT 모듈 + 보수교육 평점. 교육 _내용_은 X22 결정맵·X16 stopping rule VERBATIM (교육이 새 임상 내용을 만들지 않음 — 결정맵을 _가르칠_ 뿐). **이수 효과(채택률·결정맵 준수율 향상)는 ⚪ proposal** (교육 audit 의존).

| 대상 | 내용 (X22/X16 VERBATIM) | 형식 (CME · 실습) | 평점/인증 |
|---|---|---|---|
| **전공의 (심장내과 fellow)** | ① CYP2C19 phenotype(NM/IM/PM·freq 0.1521/0.6279) → DAPT 결정맵 (X22 §2.2: NM→clopi · IM/PM×HBR-low→prasug 5mg · PM×HBR-high→clopi+PFT) · ② 금기 게이트(≥75세 prasug 회피·<60kg 주의·CYP3A4+노인 ticag 회피, X22 §2.1) · ③ ticagrelor Month-1 출혈/호흡곤란/서맥 stopping rule (X16 §4.1) | **수련 정규 모듈** (강의 4h + 결정맵 case-based 실습) + cath lab BPA 시뮬(X29 §2 워크플로우 따라 POCT→결정 창 roleplay) | 전문의 자격 수련 이수 항목 편입 (학회 수련 커리큘럼 등재 — ⚪ 제도 path) |
| **전문의 (심장내과 attending)** | 동일 결정맵 + **lever↔책임 장벽**(X30 §3: 가이드라인 부합 = 면책 기준선 이동) · 출혈 dual jeopardy(ticagrelor 한국 2배, X16 §2 HR 2.26) · override 사유 구조화(X22 §3.1) | **CME 연수강좌** (KSC 학술대회 세션 1-2h) + audit & feedback 결과 리뷰(X30 #3) | **대한심장학회 보수교육(CME) 평점** (연수교육 평점 인정 — ⚪ 학회 인증 path) |
| **임상약사 (PGx 클리닉)** | ① phenotype 해석(diplotype→phenotype 산출 근거·caller 한계, X22 §1.1) · ② 결정맵 적정성 검토·복약상담(X30 #6) · ③ 약물상호작용(CYP3A4·polypharmacy 노인 ticag, X16 §1.2) · ④ override 사유 audit 입력 | **약사 PGx 인증 과정** (이론 + 약사 클리닉 OJT 실습·의사 협진 프로토콜) | 임상약사 PGx 인증 (병원약사회/학회 인증 — ⚪ 인증 path · 행위 수가 전제 X30 #6) |
| **간호 (cath lab·외래)** | ① 채혈 시점·3-axis 패널 sample 처리(X29 §2: sheath insertion 동시 채혈·POCT cartridge load) · ② ticagrelor cell **Month-1 monthly 모니터 booking**·환자교육(BARC diary·DAPT 임의중단 금지, X16 §4) · ③ 출혈/호흡곤란/서맥 즉시 trigger 인지(BARC≥2→보고) | **간호 직무 교육** (모니터 프로토콜 + 환자교육 실습) | 직무교육 이수 (병원 내 인증 — ⚪ path) |

> **교육 모듈 핵심**: 교육은 **새 임상 내용을 생성하지 않고 X22 결정맵·X16 stopping rule 을 _대상별 역량 수준_에 맞춰 전달**한다 — 전공의=결정맵 backbone 습득, 전문의=책임·lever 맥락 + CME 평점, 약사=해석·상담 심화, 간호=모니터·환자교육 실무. 가장 우선 교육 항목은 **ticagrelor Month-1 stopping rule**(X16 §4.1 top-1 — 한국 최대 약물 안전 신호)로, 4 대상 전체에 공통 삽입한다. **이수 효과(결정맵 준수율·채택률 향상)는 ⚪** (교육 audit 의존 · X22 §5.1 결정 일치율 2순위 / X30 채택률 ⚪ 정렬).

---

## §2. 인력 병목 ↔ 보완 — genetic counselor 부족 돌파 path (#25, d2)

> #25 한국 genetic counselor 부족 → PGx 해석 인력 병목. 한국은 인증 genetic counselor 수가 적어(인력 수치 ⚪ proposal — 실측 전), 모든 CYP2C19 결과를 전담 counselor 가 해석하는 모델은 PCI 현장 scale 에서 병목이다. **d2: 병목을 "불가"로 닫지 않고 — 임상약사 PGx 클리닉(X30 #6) + CDS 자동해석(X22) 2개 보완 경로로 돌파.**

```
 PGx 해석 인력 병목 ↔ 2-경로 보완 (d2 돌파 path)
═══════════════════════════════════════════════════════════════════════════════════════

   [병목]  한국 genetic counselor 부족  (인증 인력 적음 · 수치 ⚪ proposal)
              │   모든 CYP2C19 phenotype 해석을 전담 counselor 가 → PCI volume scale 에서 정체
              │   (응급 primary PCI 흐름 · 결정 창 90분 · X29 §2)
              ▼
   ┌──────────────────────── 무엇을 해석해야 하나 (해석 부하 분해) ────────────────────────┐
   │  ① phenotype call (diplotype→NM/IM/PM)  ── 결정론적 변환 (caller + HW)                 │
   │  ② 결정맵 적용 (phenotype×HBR→약제)      ── deterministic 트리 (X22 §2)                │
   │  ③ 환자 상담 (유전형=modifier, 운명 아님) ── 인간 소통 (counselor 고유 역량)            │
   └────────────────────────────────────────┬──────────────────────────────────────────────┘
                                             │  부하를 자동화·task-shift 로 분산
              ┌──────────────────────────────┼──────────────────────────────┐
              ▼                               ▼                              ▼
   ╔══════ 보완 A: CDS 자동해석 ══════╗  ╔═══ 보완 B: 약사 PGx 클리닉 ═══╗  ╔═ counselor 잔여역할 ═╗
   ║  X22 §2 deterministic 결정 트리  ║  ║  X30 #6 pharmacist-led       ║  ║  복잡·고위험 case 만   ║
   ║  · ① phenotype call 검증         ║  ║  · ② 결정맵 적정성 검토       ║  ║  · 가족력·다중유전     ║
   ║  · ② 결정맵 자동 적용 → CDS card ║  ║  · 복약상담·override audit    ║  ║  · 윤리·심층 상담      ║
   ║  · grade X8 VERBATIM carry       ║  ║  · 의사 시간 부담 분산(#6)    ║  ║  (희소 인력을 high-    ║
   ║  (해석 부하 ①②를 자동화)        ║  ║  (해석 부하 ②③ 일부 task-shift)║  ║   value case 에 집중) ║
   ╚══════════════════════════════════╝  ╚═══════════════════════════════╝  ╚═══════════════════════╝
              │                               │                              │
              └───────── 셋이 합쳐 counselor 단일 병목을 분산 ──────────────┘
                                             ▼
   결과: 일상 case = CDS 자동해석 + 약사 검토로 처리 → counselor 는 복잡 case 에 집중
        (단 효과·잔여 병목 = ⚪ proposal · CDS 정확도는 caller concordance gate 선행 §3)
```

| 보완 경로 | 무엇을 메우나 | 근거 (VERBATIM) | grade |
|---|---|---|---|
| **A. CDS 자동해석 (X22)** | phenotype call 검증 + 결정맵 자동 적용 — 해석 부하 ①②를 deterministic 엔진이 자동화 → 매 case 인간 해석 불요 | X22 §2 "deterministic 결정 트리 backbone(explainable)" · §3 "grade X8 VERBATIM carry, 새 판정 금지" VERBATIM | 🟡 (X22 cite) · 효과 ⚪ |
| **B. 약사 PGx 클리닉 (X30 #6)** | 결정맵 적정성 검토·복약상담·override audit 을 임상약사에 task-shift → 의사·counselor 시간 부담 분산 | X30 #6 "task-shifting 으로 의사 시간 마찰 제거 · 한국 일부 상급종합병원 PGx/항응고 클리닉 선례" VERBATIM | 🟡 (X30 #6 cite) · 효과 ⚪ |
| **C. counselor 잔여 집중** | 희소 counselor 를 복잡·고위험·가족력 case 에 집중 (일상 case 는 A+B 처리) | X32 인력 설계 (병목 분산 원칙) | ⚪ (proposal) |

> **병목 보완 핵심 (d2)**: genetic counselor 부족을 "PGx 배포 불가"로 닫지 않는다 — 해석 부하를 ①phenotype call ②결정맵 적용 ③환자 상담으로 분해하면, **①②는 X22 CDS 가 deterministic 자동화**하고(매 case 인간 불요) **②③ 일부는 X30 #6 약사 클리닉이 task-shift** 한다. 그 결과 희소한 counselor 인력은 복잡·고위험 case 에 집중된다. **단 (1) CDS 자동해석의 정확도는 caller concordance gate 가 선행**(X22 §5.1 1순위 🟠 DEFERRED — phenotype 입력이 틀리면 자동해석도 틀림, §3)하고, **(2) 약사 클리닉은 행위 수가·책임 경계 프로토콜이 전제**(X30 #6 역효과 칸 VERBATIM)다. **인력 부족 규모·보완 후 잔여 병목·효과는 전부 ⚪ proposal** (미실측).

---

## §3. 역량 단계 — 인지 → 해석 → 적용 (역할 분담)

> PGx-guided care 의 인적 역량을 3 단계로 위계화하고, 각 단계를 **누가** 담당하는지 역할 분담을 명시. 역할 경계 = X22(CDS 자동화)·X30 #6(약사 task-shift)·DISCLAIMER(의사 처방 권한) VERBATIM. **단계별 인력 효과는 ⚪.**

```
 역량 3 단계 + 역할 분담 (인지 → 해석 → 적용 · 누가 무엇을)
─────────────────────────────────────────────────────────────────────────
 [단계 1] 인지 (awareness)   ── "CYP2C19 phenotype 이 DAPT 효과를 바꾼다를 안다"
   누가: 전공의·전문의·약사·간호 _전원_ (교육 모듈 §1 으로 확보)
   무엇: PM freq 0.1521 🟢·IM+PM 0.6279 🟢 · ticagrelor 한국 출혈 2배(HR 2.26 🟡)
         결정맵의 _존재_와 _왜 필요한가_(출혈 dual jeopardy, X16 §2)
              │
              ▼
 [단계 2] 해석 (interpretation) ── "이 환자의 phenotype·HBR 를 결정맵 분기에 매핑한다"
   누가: ★ CDS 자동(X22) → 약사 검토(X30 #6) → counselor(복잡 case 만)  [§2 보완 경로]
   무엇: ① CDS = phenotype call + 결정맵 자동 적용 (deterministic, X22 §2)
         ② 약사 = 적정성 검토·복약상담·override audit (task-shift, X30 #6)
         ③ counselor = 가족력·다중유전·윤리 심층 (희소 인력 집중)
              │   ← 인력 병목이 가장 큰 단계 (genetic counselor 부족 #25) → §2 로 분산
              ▼
 [단계 3] 적용 (application)  ── "최종 약제·용량·중단을 _처방_으로 결정한다"
   누가: ★ 심장내과 전문의 _단독_ (처방 권한 · 비위임)
   무엇: CDS card(권고+grade+override 사유)·약사 검토를 _입력_으로 받아
         환자별 종합 판단(ARC-HBR·신기능·연령·동반약) → 처방 결정 + override
         (CDS·약사·counselor 는 _지원_, 처방 결정은 의사 — DISCLAIMER VERBATIM)
─────────────────────────────────────────────────────────────────────────
 역할 분담 1줄: 의사 = 결정(적용·처방) · 약사 = 해석(검토·상담) · CDS = 자동화(call·결정맵)
              · counselor = 복잡 case 심층해석 · 간호 = 모니터·환자교육
─────────────────────────────────────────────────────────────────────────
```

| 단계 | 핵심 역량 | 주 담당 (역할 분담) | 근거 (VERBATIM) | grade |
|---|---|---|---|---|
| **1 인지** | phenotype→DAPT 효과·출혈위험을 안다 | 전공의·전문의·약사·간호 전원 (교육 §1) | freq 0.1521/0.6279 🟢 (X8) · ticag HR 2.26 🟡 (X16 §2) | 🟢/🟡 carry · 교육 효과 ⚪ |
| **2 해석** | phenotype·HBR → 결정맵 분기 매핑 | **CDS 자동(X22) → 약사 검토 → counselor 복잡 case** | X22 §2 deterministic 트리 · X30 #6 약사 task-shift · §2 병목 분산 | 🟡 cite · 효과 ⚪ |
| **3 적용** | 최종 처방·용량·중단 결정 | **심장내과 전문의 단독** (비위임 처방 권한) | DISCLAIMER "처방 결정은 의사 권한" · X22 "CDS=지원, 처방 아님" VERBATIM | 🟡 (governance/cite) |

> **역량 단계 + 역할 분담 핵심**: 인력 병목은 **단계 2 해석에 집중**(genetic counselor 부족 #25)되므로, 이 단계만 CDS 자동(X22)+약사(X30 #6)+counselor(복잡 case)로 분산한다(§2). 단계 1 인지는 교육(§1)으로 전원 확보하고, 단계 3 적용(처방)은 **의사 단독·비위임**으로 둔다 — CDS·약사·counselor 의 해석은 모두 _의사 결정의 입력_이지 처방 대체가 아니다(DISCLAIMER VERBATIM). 즉 **의사=결정·약사=해석·CDS=자동화·counselor=심층해석·간호=모니터**의 5-역할 분담으로, 한 사람(counselor)에 몰린 해석 부하를 자동화+task-shift 로 풀되 처방 권한은 의사에 보존한다. **각 단계 인력 효과·해석 정확도는 ⚪/🟠** — 특히 단계 2 CDS 자동해석은 **caller concordance(X22 §5.1 1순위 🟠 DEFERRED)가 선행 gate** 다(phenotype call 이 틀리면 자동해석·약사 검토·의사 결정 전부 틀린 입력에서 출발).

---

## §4. g5 grade — X32 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 교육 모듈 표 | 🟡 + ⚪ (compositional) | 교육 _내용_ = X22 §2.2 결정맵 + X16 §4 stopping rule VERBATIM · CME/수련 편입 = 제도 path ⚪ · 이수 효과(준수율·채택률) ⚪ proposal |
| §2 인력 병목 ↔ 보완 | 🟡 + ⚪ | CDS 자동해석 = X22 §2/§3 VERBATIM · 약사 클리닉 = X30 #6 VERBATIM · counselor 부족 규모·보완 효과·잔여 병목 = ⚪ proposal (d2 돌파 path 동반) |
| §3 역량 단계 + 역할 분담 | 🟢/🟡 + ⚪ | freq 0.1521/0.6279 🟢 · ticag HR 2.26 🟡 (X8/X16 carry) · 역할 경계 = X22/X30 #6/DISCLAIMER VERBATIM · 단계별 효과 ⚪ · CDS 정확도 caller concordance 🟠 (X22 §5.1) |

**X32 종합 등급**: ⚪ SPECULATION-FENCED (인력 수치·교육 효과는 ⚪ proposal) over 🟡 (교육 내용·보완 경로·역할 경계는 X22/X16/X30 VERBATIM carry) — **인적 역량 설계의 본질이 미래 교육·인력 효과 예측**이므로 honest 하게 ⚪ fence. **X32 새 판정 0건** (per @D g5 · LLM self-judge 0건): 교육 내용(결정맵·stopping rule)·약사 lever·CDS 자동화·grade(freq 0.1521/0.6279 🟢·ticag HR 2.26 🟡·caller concordance 🟠)는 모두 X8/X22/X16/X30 VERBATIM 인용. **d6 준수**: (a) 한국 genetic counselor 부족 규모·약사 인력 gap·교육 효과·CME 후 채택률 전부 ⚪/🟠 명시 · (b) 교육이 새 임상 내용을 만들지 않고 결정맵을 _전달_할 뿐임을 명시 · (c) CDS 자동해석 정확도는 caller concordance gate(🟠 DEFERRED) 선행 명시. **d2 준수**: genetic counselor 부족을 "배포 불가"로 닫지 않고 CDS 자동해석(A)+약사 클리닉(B)+counselor 집중(C) 3-경로 돌파 path 동반(포기 0건). **d1 준수**: completed-form 인적 역량 설계. "교육·인력 지원, 처방 아님" 톤 (단계 3 적용=의사 단독 처방 권한 보존).

---

## §5. X32 산출 요약

- **교육 모듈 (#9)**: 4 대상별 PGx-DAPT 커리큘럼 — 전공의(수련 정규 모듈, 결정맵 backbone+cath lab 시뮬) · 전문의(KSC CME 연수강좌+보수교육 평점, 책임·lever 맥락) · 약사(PGx 인증+클리닉 OJT, 해석·상담) · 간호(직무교육, Month-1 모니터·환자교육). 교육 _내용_은 X22 결정맵·X16 stopping rule VERBATIM — 가장 우선 항목 = ticagrelor Month-1 stopping rule(X16 §4.1 top-1) 4 대상 공통.
- **인력 병목 보완 (#25, d2)**: 한국 genetic counselor 부족(⚪)을 해석 부하 분해(①phenotype call ②결정맵 적용 ③상담)로 풀어 — **A. CDS 자동해석(X22 deterministic 트리가 ①② 자동화) + B. 약사 PGx 클리닉(X30 #6 가 ②③ task-shift) + C. counselor 복잡 case 집중**의 3-경로로 분산. 단 CDS 정확도는 caller concordance gate(X22 §5.1 1순위 🟠) 선행 · 약사 클리닉은 수가·책임 프로토콜 전제(X30 #6).
- **역량 단계 + 역할 분담**: 인지(전원, 교육) → 해석(CDS→약사→counselor, 병목 집중 단계) → 적용(의사 단독 처방). **역할 분담 = 의사 결정·약사 해석(검토·상담)·CDS 자동화(call·결정맵)·counselor 복잡 case 심층·간호 모니터** — 처방 권한은 의사에 비위임 보존.
- **g5/d1/d2/d6 준수**: 새 판정 0건 · grade X8/X22/X16/X30 VERBATIM · 인력 수치·교육 효과 ⚪/🟠 정직 격리 · genetic counselor 부족 돌파 path 동반(d2) · CDS 정확도 caller concordance gate 선행 명시 · "교육·인력 지원, 처방 아님" 톤 · completed-form(d1).

---

> ⚠ **하단 DISCLAIMER (반복)**: 본 문서는 PGx-guided care 배포의 교육·인력 설계 자료이며 처방·진단·용량 지시도, 면허/수가 행정 결정도 아니다. 교육 모듈·역할 분담·약사 클리닉 설계의 어떤 항목도 자동 처방·비-의사 단독 처방으로 해석해서는 안 되며, 약사·간호·CDS·counselor 는 해석·상담·자동화 지원이고 최종 약제·용량·중단 처방 결정은 전적으로 심장내과 전문의 판단이다(단계 3 적용=의사 단독 권한). 환자는 항혈소판제를 임의 중단·변경하지 말 것(스텐트 혈전증 위험). 근거 등급·빈도(freq 0.1521/0.6279 🟢·ticag HR 2.26 🟡·caller concordance 🟠)는 X8/X22/X16/X30 verify verdict 의 verbatim 인용이고, **한국 genetic counselor 부족 규모·약사 인력 gap·교육 모듈의 결정맵 준수율·CME 후 채택률 향상은 모두 미실증 영역(⚪ proposal / 🟠 DEFERRED)이며 본 X32 의 어떤 인력 수치·교육 효과도 실측 결과로 제시하지 않는다 (d6 정직).**
</content>
</invoke>
