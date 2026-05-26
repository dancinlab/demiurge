# X30 — CARDIO+ 채택 lever (adoption levers · 임상의가 실제로 채택하게 만드는 행동·인센티브·경제 묶음)

> CARDIO+ 메타도메인 X30 산출물 · current-state · no history.
> **목적 = 채택률은 "근거의 함수"가 아니라 "lever 의 함수"다 — 아무리 강한 근거(X8 🟢/🟡)라도 default·인센티브·audit-feedback·business case·champion·약사클리닉 같은 행동/경제 lever 없이는 임상 현장 채택률이 오르지 않는다. 본 X30 은 CARDIO+ 중재(특히 X11/X12 의 "오늘 당장 가능한" CYP2C19 결정맵·3-axis 패널)의 현장 채택을 끌어올리는 lever 묶음을 통합하고, 각 lever 가 어느 거부 장벽을 푸는지 매핑한다.**
> 출처 = X19 (budget-neutral business case · self-funding 구조) · X12 (4-trial MCDA · "B 먼저" 규제 feasibility) · X16 (safety harm profile · 책임 우려의 실체) · X11 (layered-care 침상 알고리즘 · EMR 분기점). **채택률 수치는 전부 ⚪ proposal (실측 전)** · grade 인용은 X8/X19 VERBATIM (per @D g5 · LLM self-judge 0건). d6 정직(역효과 명시) · d2 돌파 path 동반.

---

## ⚠ DISCLAIMER (반드시 읽기)

> 이 문서는 **임상 정책·실행(implementation) 전략 자료이며 처방·진단·급여결정 지시가 아니다.**
> - 본 문서의 "lever" 는 임상 중재 자체가 아니라 그 중재의 **현장 채택(adoption)을 촉진하는 정책·행동·경제 도구**다. 어떤 lever 도 특정 환자에게 특정 약을 쓰라는 처방 명령이 아니다.
> - **default-nudge** lever 는 "처방을 강제(forcing)"하는 것이 아니라 **opt-out 가능한 기본값**이다 — 주치의가 환자별(출혈위험 ARC-HBR · 신기능 · 연령 · 동반약)로 override 할 수 있어야 하며, override 경로 부재 = 안전 역효과(§표 위험 칸).
> - **채택률 수치(%·배수)는 전부 ⚪ proposal** — CARDIO+ 중재의 실제 한국 PCI 현장 채택률은 측정 전이다. 본 문서는 행동과학 일반 근거(default > 교육 > 권고)에 기반한 **방향성 제안**이지 한국 실측치가 아니다.
> - grade(🔵🟢🟡🟠🔴⚪)는 X8/X19 의 VERBATIM 인용이며, 채택 lever 자체의 효과크기는 별도로 ⚪/🟡 로 fence 한다.

---

## §0. 핵심 명제 — 채택률 = 근거 아닌 lever 의 함수

> CARDIO+ 의 "오늘 당장 가능"(X11 §5.1)한 중재 — CYP2C19 결정맵, 3-axis 패널 — 은 **이미 신규 IND 불요·기존 NHIS 급여 안**(X12 C1=5 만점)이고 근거도 🟢/🟡 carry 가 있다. 그런데도 현장 채택이 자동으로 일어나지 않는 이유는 근거 부족이 아니라 **lever 부재**다.

```
 채택률을 결정하는 것은 무엇인가? (행동과학 일반 명제)
─────────────────────────────────────────────────────────────────────────
   강한 근거 (X8 🟢/🟡)         ───┐
                                   │  근거가 강해도 lever 없으면 채택률 정체
   "당장 가능"(X11 §5.1·X12 C1=5)─┤  → 채택률 = f(lever), NOT f(근거)
                                   │
   업무흐름 마찰 · 습관 · 책임우려 ─┘  ← 이것이 진짜 채택 거부 원인 (§3, X16 책임)
─────────────────────────────────────────────────────────────────────────
   ▼  lever 가 마찰·습관·책임·시간을 푸는 만큼만 채택률이 오른다
─────────────────────────────────────────────────────────────────────────
```

> ⚠ 정직: 본 X30 은 "근거가 약하니 lever 로 밀어붙이자"가 **아니다**(d6). CARDIO+ 중재의 근거는 X8 에 grade-locked 돼 있고, 효과 추정은 X11/X16 에서 ⚪/🟠 로 격리돼 있다. lever 는 **이미 정당화된(또는 self-funding 인) 중재**의 채택 마찰을 줄이는 도구이지, 근거 공백을 메우는 도구가 아니다. lever 가 강할수록 근거가 약한 중재를 잘못 밀어붙일 역효과 위험도 커지므로(§표 위험 칸), lever 강도와 근거 grade 를 짝지어 본다(§4).

---

## §1. lever 표 (6 lever · 기전 · 채택률 영향 · 실행 주체 · 역효과 위험)

> ⚠ 채택률 영향 칸의 수치·강도는 **⚪ proposal** (한국 PCI 현장 실측 전). "근거 유형" = 그 lever 가 일반적으로 채택률을 올린다는 행동과학/실행과학(implementation science) 근거의 성격(🟡 일반문헌 cite / ⚪ CARDIO+ 미실측). CARDIO+ 중재 근거 grade 는 X8/X19 VERBATIM.

| lever | 기전 (어떻게 채택률을 올리나) | 채택률 영향 (근거 유형) | 실행 주체 | 위험 (역효과) |
|---|---|---|---|---|
| **① default-nudge (EMR opt-out)** | IM/PM clopidogrel 처방 시도 시 EMR 이 **기본값을 potent(prasugrel 5mg/ticagrelor)로 제시 + opt-out** — 의사는 "아무것도 안 하면 권장안이 적용"됨. 결정 부담을 기본값으로 흡수. (#16 forcing nudge) | **최강 (⚪ 영향 大)** — 행동과학상 default 가 모든 lever 중 채택률 효과 최대(opt-in→opt-out 전환은 수용률을 수배로). 근거 유형 = 🟡 일반 행동경제 cite (CARDIO+ 현장치 ⚪) | **병원 EMR 팀 + 심장내과 + IT** (원내 의사결정지원 빌드) | ★ **최대 역효과 위험** — (a) X16 의 안전 가드레일을 무시한 default 는 위험: ticagrelor 는 한국인 출혈 2배(TICAKOREA 2.8% vs PLATO 1.4%, HR 2.26)·≥75yo prasugrel net harm(HR 1.36) → **default 가 강력제로 고정되면 출혈 dual jeopardy 를 오히려 조장**. (b) override 경로가 번거로우면 alert fatigue·맹목 수용. → default 는 **"potent 일괄"이 아니라 X16 결정맵(NM=clopi·IM/PM=출혈위험 보정 potent·≥75yo clopi 강제)을 그대로 기본값화**해야 안전 |
| **② P4P / 적정성평가 편입** | HIRA(심평원) **AMI 적정성평가 지표에 "PGx-guided DAPT 적정성" 편입 + P4P(성과연동지불)** — 채택이 병원 평가등급·인센티브에 직결. (#3) | **강 (⚪ 영향 大·지속)** — 적정성평가는 한국 병원 행동을 가장 강하게 움직이는 제도적 lever(등급=환자유입·수가 가산). 근거 유형 = 🟡 제도효과 일반 cite (CARDIO+ ⚪) | **HIRA / 보건복지부** (지표 신설·가중치 부여) | ★ **gaming·지표 왜곡** — 지표가 "PCR 시행률"이면 결정맵 적용 없이 검사만 늘려 점수 따기(teaching to the test). "potent 처방률"이면 ②의 default 역효과와 동일하게 출혈 위험군에도 강력제 → 환자 harm. → 지표는 **process(PCR 시행)가 아니라 "결정맵 부합률"(NM 에 clopi·IM/PM 에 적정약·≥75yo clopi)** 로 설계해야 함. 도입 lead-time 길다(d2) |
| **③ audit & feedback** | 의사별/팀별 **결정맵 준수율을 정기(분기) 비교 피드백** — "당신 팀 IM/PM 적정처방률 X%, 원내 중앙값 Y%". 동료비교(peer comparison)가 행동 교정. (#32) | **중 (⚪ 영향 中)** — audit & feedback 은 실행과학에서 효과 입증된 중간강도 lever(특히 동료비교·반복 시). 단 default 보다 약함(능동적 행동 변화 요구). 근거 유형 = 🟡 Cochrane A&F 일반 cite (CARDIO+ ⚪) | **병원 QI 팀 + 심장내과 과장** (대시보드·정기 리뷰) | **수치 조작·사기저하·비교 불공정** — case-mix 보정 없는 비교는 고위험 환자 많은 의사를 부당하게 낮게 평가 → 반발·신뢰 상실. 피드백이 처벌적이면 차트 조작(override 사유 과다기재). → **case-mix 보정 + 비처벌적 학습 프레임** 필수 |
| **④ business case (병원경영 ROI · X19 연계)** | 병원 경영진에 **"self-funding/비용중립" 재무 논리 제시** — ③ adenosine+nicorandil 중재비 ≈ 0(보험 routine)·② 3-axis 패널 한계비용 ≈ 0(채혈 1회)·① CYP2C19 5y −44억 절감(80k scale). 신규예산 없이 굴러간다(X19 §2 self-funding). (#14) | **중강 (⚪ 영향 中·경영 결재 필수조건)** — ROI 논리는 경영진 채택 결재의 게이트키퍼. 강제력은 없으나 **없으면 도입 자체가 막힘**(예산 거부). 근거 유형 = X19 cost-offset 산술(🟡 compositional, 단가 🟠) | **병원 경영진 + 기획실 + 심장내과** (도입 비즈니스 케이스 작성) | ★ **horizon 오도·단가 불확실** — X19 §4 정직: ① CYP2C19 는 **1y +29.5M 순지출 → 5y −44억 절감(부호 반전)**. ROI 를 "1y 절감"으로 과장하면 1년차 적자에 경영진 신뢰 붕괴 → 도입 철회. ③ 의 회피 사건비도 ⚪ proposal(6mo MACE 4 RCT null 🔴, X16) → "절감 확정"으로 팔면 역풍. → **"최소 비용중립, 5y 절감(부호 반전 명시)"** 으로 정직 제시(d6) |
| **⑤ champion (KSC opinion leader)** | **대한심장학회(KSC) opinion leader 가 가이드라인·연수강좌·KAMIR 레지스트리에서 결정맵을 공개 지지** — 권위·동료 신뢰가 초기 수용을 점화(early adopter → diffusion). (#2) | **중 (⚪ 영향 中·초기 점화)** — champion 은 확산곡선의 초기(early adopter) 점화에 핵심이나, 본인이 직접 처방을 바꾸지 않는 동료에는 영향 제한적(권고 수준). 근거 유형 = 🟡 diffusion-of-innovation 일반 cite (CARDIO+ ⚪) | **KSC / KAMIR consortium / 학회 가이드라인 위원회** (가이드라인 등재·연수강좌) | **권위 편향·이해상충·근거 초과 홍보** — champion 이 근거(X8 grade)를 초과해 홍보하면(예: ③ adenosine MACE 효과를 확정처럼) 추종자가 ⚪/🔴 격리 무시. champion 1인 의존은 그 사람 이탈 시 붕괴. → **가이드라인 등재는 X8 grade VERBATIM 수준에서만**(권고강도 = 근거강도) |
| **⑥ 약사 주도 클리닉 (pharmacist-led)** | **임상약사가 PGx 결과 해석·DAPT 적정성 검토·복약상담을 주도** — 의사 시간 부담(§3 장벽)을 약사에게 분산, 결정맵 적용을 약사 워크플로에 내장. (#6) | **중 (⚪ 영향 中·시간장벽 직격)** — task-shifting 으로 의사 시간 마찰을 제거 → "시간 없어서 못 한다"는 거부를 직접 해소. 한국 일부 상급종합병원 PGx/항응고 클리닉 선례. 근거 유형 = 🟡 pharmacist-led 일반 cite (CARDIO+ ⚪) | **병원 약제부 + 심장내과 협진** (PGx/DAPT 약사 클리닉 신설) | **책임 경계 모호·수가 미비·의사 저항** — 약사 권고와 의사 처방권 경계가 불명확하면 책임 공백(§3 책임 장벽 역설적 악화). 한국 임상약사 행위 수가 미비 → 인력 자체가 ④ business case 의 비용 항목으로 역작용. → **명확한 협진 프로토콜 + 약사 행위 수가 확보** 전제 |

**표 grade 추적 주석 (VERBATIM)**:
- ① default 안전 근거 = X16 §1.2: ticagrelor TICAKOREA major bleeding **2.8% vs PLATO 1.4% (HR 2.26)** 🟡 · prasugrel ≥75yo TIMI major **4.3% vs 3.3% (HR 1.36, net harm)** 🟡 → default 는 X16 결정맵(NM=clopi·≥75yo clopi 강제) 그대로여야 안전.
- ④ ROI 근거 = X19 §1·§2 VERBATIM: ③ 중재비 ≈ 0(보험 routine) · ② 한계비용 ≈ 0(채혈 1회 multiplex) · ① 1y **+29.5M 순지출** → 5y **−44억 절감**(80k scale, M8 §7) 부호 반전. 사건 단가 🟠 INSUFFICIENT(DRG 추정) · 회피량 ⚪ proposal.
- ⑤ champion 등재 상한 = X12 결론: B(CYP2C19 결정맵) MCDA 1위·신규 IND 불요(C1=5) — 단 ICER 절대값 🟠 잔존(X12 C5=4). champion 홍보는 이 grade 안에서만.

---

## §2. lever 강도 순위 ASCII (행동과학: default > 교육 > 권고)

> 행동과학 일반 원칙: 채택 행동을 바꾸는 강도는 **환경을 바꾸는 lever(default·제도) > 동료/시간 마찰을 줄이는 lever(audit·약사) > 정보를 주는 lever(교육·권고)** 순. CARDIO+ 6 lever 를 이 위계에 배치한다. 강도는 ⚪ proposal.

```
 lever 강도 순위 (행동과학 위계 · ⚪ proposal · 한국 현장 미실측)
─────────────────────────────────────────────────────────────────────────
 [환경을 바꾼다 — 능동적 결심 불요, 채택률 최강]
 ① default-nudge (EMR opt-out)   ██████████  최강  "안 바꾸면 권장안 적용"
    (#16 · 실행: 병원 EMR)                     ★ 단 X16 결정맵 그대로여야 안전

 ② P4P / 적정성평가 편입          █████████░  강    "채택이 병원 등급·돈에 직결"
    (#3 · 실행: HIRA)                          ★ lead-time 김 · gaming 위험

 [마찰을 줄인다 — 시간/동료압력으로 행동 유도, 중강도]
 ④ business case (ROI · X19)      ███████░░░  중강  "도입 결재 게이트 통과"
    (#14 · 실행: 병원경영)                     ★ horizon 오도 금지(1y 적자 정직)

 ⑥ 약사 주도 클리닉              ██████░░░░  중    "의사 시간 부담 분산"
    (#6 · 실행: 약제부)                        ★ 책임경계·수가 전제

 ③ audit & feedback              █████░░░░░  중    "동료비교가 행동 교정"
    (#32 · 실행: QI 팀)                        ★ case-mix 보정 필수

 [정보를 준다 — 결심에 맡김, 채택률 최약 (단 초기 점화)]
 ⑤ champion (KSC opinion leader) ████░░░░░░  중약  "권위·신뢰가 초기 점화"
    (#2 · 실행: 학회)                          ★ early adopter 후 diffusion 필요

   ─ (참고: 단순 교육·권고만) ─    ██░░░░░░░░  최약  "알지만 안 바꾼다" (습관 장벽)
─────────────────────────────────────────────────────────────────────────
 행동과학 핵심: default(①) 1개가 교육·권고 여러 개보다 채택률을 더 올린다.
 "임상의는 근거를 몰라서가 아니라 업무흐름이 안 바뀌어서 채택 안 한다"(§3)
─────────────────────────────────────────────────────────────────────────
```

| 순위 | lever | 위계 분류 | 강도 (⚪) | 핵심 한 줄 |
|---|---|---|:---:|---|
| **#1** | ① default-nudge | 환경 변경 (능동 결심 불요) | **최강** | 안 바꾸면 권장안 적용 — 단 X16 결정맵 그대로 |
| **#2** | ② P4P/적정성평가 | 환경 변경 (제도 인센티브) | **강** | 채택이 병원 등급·돈에 직결 — lead-time 김 |
| **#3** | ④ business case | 마찰 제거 (도입 게이트) | 중강 | ROI 결재 통과 — 1y 적자 정직(X19) |
| **#4** | ⑥ 약사 클리닉 | 마찰 제거 (시간 분산) | 중 | 의사 시간장벽 직격 — 수가 전제 |
| **#5** | ③ audit & feedback | 마찰 제거 (동료압력) | 중 | 동료비교 교정 — case-mix 보정 |
| **#6** | ⑤ champion | 정보 제공 (초기 점화) | 중약 | 권위 점화 — diffusion 필요 |

> **묶음 통찰**: lever 는 단독이 아니라 **스택**으로 작동한다. ⑤ champion 이 가이드라인 등재로 정당성을 점화 → ④ business case 가 경영 결재 통과 → ① default 가 EMR 에 안전 결정맵을 내장 → ② P4P 가 지속 강제 → ③ audit + ⑥ 약사가 마찰을 메운다. **default(①) 가 채택률의 주엔진이고 나머지는 그것을 켜고·지속시키는 보조엔진**이다.

---

## §3. contrarian 노트 — 채택 거부의 진짜 이유 (#5) → 각 lever 가 푸는 장벽

> ⚠ contrarian: 임상의가 CARDIO+ 결정맵을 채택하지 않는 진짜 이유는 **"근거를 모른다"가 아니다**. 근거는 X8 에 있고 X11/X12 가 "당장 가능"을 보였다. 진짜 거부 이유는 **책임·시간·습관**(#5)이라는 인간/제도 마찰이다. lever 는 이 마찰을 풀 때만 작동한다.

### 3.1 거부 장벽 3종 (#5 책임·시간·습관)

```
 채택 거부의 진짜 이유 (#5 · 근거 부족이 아님)
─────────────────────────────────────────────────────────────────────────
 [장벽 A] 책임 (legal/clinical liability)  ★ 가장 큰 장벽
   "결정맵 따라 potent 처방했다가 출혈나면 누가 책임지나?"
   → X16 가 실증: ticagrelor 한국 출혈 2배(HR 2.26)·≥75yo prasugrel net harm(HR 1.36)
   → 의사 입장: 표준(clopidogrel) 유지가 책임 면에서 가장 안전한 선택
   → "검사 결과를 봤는데도 안 따랐다"는 역설적 책임도 두려움 (knew-but-ignored)

 [장벽 B] 시간 (workflow friction)
   "PCR 결과 해석·결정맵 조회·환자 설명할 시간이 PCI 현장에 없다"
   → 응급 primary PCI 흐름에서 유전형 분기를 추가 인지부하로 처리할 여유 부족

 [장벽 C] 습관 (clinical inertia)
   "지금까지 ticagrelor/clopidogrel 로 잘 해왔다 — 바꿀 이유를 못 느낀다"
   → 근거를 알아도(교육받아도) 기존 처방 패턴이 default 로 굳어 있음
─────────────────────────────────────────────────────────────────────────
```

### 3.2 각 lever ↔ 장벽 매핑 (어느 lever 가 어느 장벽을 푸나)

| 거부 장벽 (#5) | 이 장벽을 푸는 lever | 어떻게 푸나 | 푸는 강도 (⚪) |
|---|---|---|:---:|
| **A. 책임** (가장 큰 장벽) | **⑤ champion + ② P4P/적정성평가** (1차) · ① default(2차) | champion/학회 가이드라인 등재 = "표준이 결정맵이다"로 **책임 기준선 자체를 이동**(가이드라인 부합이 곧 면책 근거) · 적정성평가 편입 = 제도가 결정맵을 정상규범으로 인정 · default = "권장안 따랐다"는 시스템 기록이 방어 근거 | 중 — 책임은 lever 로 **완전히** 풀리지 않음(법적 판단). 가이드라인+제도가 기준선을 옮겨야 |
| **B. 시간** | **① default-nudge + ⑥ 약사 클리닉** | default = 결정맵 조회·계산을 EMR 이 대신(인지부하 0) · 약사 클리닉 = 해석·상담 task 를 약사에게 이전(의사 시간 0) | 강 — 시간 장벽은 lever 로 가장 직접적으로 풀림 |
| **C. 습관** | **① default-nudge + ③ audit & feedback** | default = 습관(기존 처방)을 새 기본값으로 **교체**(능동 결심 불요) · audit = 동료비교로 "나만 안 바꿨다" 자각 → 관성 깨기 | 강 — default 가 습관 장벽의 정면 해법(환경을 바꿔 습관을 무력화) |

### 3.3 contrarian 결론 — default(①) 가 B·C 를 풀지만 A 는 못 푼다

> **★ 가장 큰 거부 장벽 = A 책임(liability)이며, 이것은 채택률 최강 lever 인 ①default 로도 완전히 풀리지 않는다 — 정직 명시(d6).**
> - default(①)는 **시간(B)·습관(C)을 강하게 푼다** — EMR 이 결정맵을 대신 조회/제시하니 시간 마찰이 사라지고, 새 기본값이 옛 습관을 교체한다. 그래서 ①이 채택률 최강 lever 다.
> - **그러나 책임(A)은 lever 로 완전히 안 풀린다**. 의사가 두려워하는 것은 "결정맵 따라 potent 처방 → 한국인 출혈 2배(X16 HR 2.26) → 출혈 사고 → 책임"이다. default 가 강력제로 밀면 이 두려움이 오히려 커진다(역효과). 책임 장벽은 **②적정성평가 편입(제도가 결정맵을 정상규범으로 인정)+⑤가이드라인 등재(가이드라인 부합 = 면책 기준선 이동)**라는 **제도적 lever 가 기준선 자체를 옮겨야** 비로소 완화된다 — 그리고 그것은 lead-time 이 긴 lever 다(d2 돌파 path: KSC 가이드라인 등재 → HIRA 적정성평가 편입을 병행 추진).
> - **그래서 lever 스택이 필요하다**: ①default 단독은 B·C 만 풀고 A 를 못 풀어 채택률이 정체된다. **①(B·C) + ②⑤(A)** 를 함께 깔아야 세 장벽이 모두 풀린다. 그리고 ①의 default 는 반드시 **X16 안전 결정맵(NM=clopi·≥75yo clopi 강제·ticagrelor 회피·monthly 출혈 모니터)** 을 그대로 기본값화해야 — 책임 장벽을 키우지 않는다.

---

## §4. lever 강도 ↔ 근거 grade 짝지음 (역효과 방지 게이트)

> ⚠ 정직(d6): lever 가 강할수록 **근거가 약한 중재를 잘못 밀어붙일 역효과**가 크다. 강한 lever 는 grade 가 견고한 중재에만, 약한 근거 중재는 약한 lever(권고)에만 — 이 짝지음이 역효과 방지 게이트다. grade 는 X8/X19 VERBATIM.

| CARDIO+ 중재 | 근거 grade (X8/X19 VERBATIM) | lever 적용 적정선 | 역효과 경고 |
|---|---|---|---|
| **CYP2C19 결정맵 (X11 D축)** | PM freq **0.1521** 🟢 · IM+PM **0.6279** 🟢 (X8) · ICER 방향 🟢/절대값 🟠 (X3 v8) | **①default + ②P4P 적용 가능** (빈도·방향 견고) — 단 default = X16 결정맵 그대로 | ST↓X% 효과 = 🟠/⚪(cohort 미측정, X11 §2.2) → "potent 일괄 default" 금지, **출혈위험 보정 결정맵**만 |
| **3-axis 패널 (X11 분기점)** | 한계비용 ≈ 0 견고(X19 #2) · 패널 측정 자체 = 검사 행위(grade 무관) | ①default(패널 자동 오더) + ④business case 적용 가능 | harm-stratify 회피량 = ⚪ proposal(X19 §4) → "패널이 사건 줄인다" 과장 금지 |
| **adenosine+nicorandil (X11 N축)** | IC-sync ODE Δ36.6pp 🟢(surrogate) · **6mo MACE 4 RCT null 🔴**(X16 §1.1 / X8 §5) | ④business case(중재비≈0) 가능 · ★ **강한 lever(①②) 부적합** | ★ 임상 MACE 회피 🔴 falsify → ①default/②P4P 로 밀면 **falsify 된 효과를 제도화**하는 중대 역효과. champion 홍보도 surrogate 한정 |
| **siRNA/PCSK9 (X11 L축)** | MACE 🟠 DEFERRED · NHIS WTP 0% pass 🟢 · 약가 387-645× 격차 | ⑤champion(추적)·⑥약사(상담)만 · ★ **①②④ 전부 부적합** | ★ 순지출 명백(X19 #5) → business case 로 ROI 주장 불가 · default/P4P 로 밀면 NHIS 재정 역효과 |

> **게이트 원칙 (d6)**: **강한 lever(①default·②P4P)는 grade 가 견고한 중재(CYP2C19 결정맵·3-axis 패널)에만.** 효과가 🔴 falsify(adenosine 6mo MACE)거나 🟠 deferred(siRNA MACE)인 중재에 강한 lever 를 걸면 **lever 가 근거 공백을 은폐**하는 역효과 — 채택률은 오르나 falsify/미검증 효과를 제도화하는 의료적 위험. 약한 근거 중재는 약한 lever(권고·추적)에 머물러야 한다.

---

## §5. g5 grade — X30 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 lever 표 (6 lever) | 🟡 (행동과학 cite) + ⚪ (영향 강도) | lever 효과 = implementation science 일반 cite 🟡 · CARDIO+ 현장 채택률 = ⚪ proposal(미실측) · 안전/ROI 근거 = X16/X19 VERBATIM |
| §2 lever 강도 순위 | ⚪ (강도 proposal) | default>교육>권고 = 행동과학 일반 위계 🟡 · CARDIO+ 6 lever 강도 배치 = ⚪ proposal |
| §3 거부 장벽 + 매핑 | 🟡 (compositional) + ⚪ | 책임/시간/습관 장벽 = 일반 cite 🟡 · 책임 근거 = X16 VERBATIM(HR 2.26·1.36) · lever↔장벽 매핑 = ⚪ 논리 |
| §4 lever↔grade 게이트 | 🟢/🟠/🔴/⚪ (X8 VERBATIM) + ⚪ | 중재 grade = X8/X19 VERBATIM(새 판정 0건) · 게이트 짝지음 원칙 = ⚪ 정책 제안 |

**X30 종합 등급**: ⚪ SPECULATION-FENCED (채택률 영향·lever 강도는 ⚪ proposal) over 🟡 (행동과학 일반 cite + X16/X19 안전·ROI VERBATIM carry) — **채택 lever 의 본질이 미래 실행 효과 예측**이므로 honest 하게 ⚪ fence. **X30 새 판정 0건** (per @D g5 · LLM self-judge 0건): 중재 grade(0.1521 🟢·HR 2.26 🟡·6mo MACE 🔴·siRNA MACE 🟠 등)는 X8/X16/X19 VERBATIM 인용. **d6 준수**: (a) 채택률 수치 전부 ⚪ 명시 · (b) 각 lever 역효과 위험 명시(①default→X16 출혈 dual jeopardy·②P4P→gaming·④ROI→1y 적자 horizon 오도·⑤champion→근거초과 홍보) · (c) §4 게이트로 강한 lever 가 🔴/🟠 중재를 제도화하는 역효과 차단 · (d) 책임 장벽이 최강 lever 로도 안 풀림을 정직 인정. **d2 준수**: 책임 장벽 돌파 path(가이드라인 등재→적정성평가 편입 병행)·약사 수가/지표 설계 path 동반(포기 0건).

---

## §6. X30 산출 요약

- **핵심 명제**: 채택률 = 근거 아닌 **lever 의 함수**. CARDIO+ 중재는 이미 "당장 가능"(X11 §5.1·X12 C1=5)·근거 있음(X8 🟢/🟡)인데도 lever 없이는 채택 정체 — 거부 원인은 근거 부족이 아니라 책임·시간·습관(#5).
- **6 lever**: ①default-nudge(EMR opt-out, #16) · ②P4P/적정성평가(HIRA, #3) · ③audit&feedback(#32) · ④business case(ROI·X19, #14) · ⑤champion(KSC, #2) · ⑥약사 클리닉(#6).
- **강도 순위(⚪)**: ①default(최강·환경변경) > ②P4P(강·제도) > ④business case(중강) > ⑥약사 = ③audit(중·마찰제거) > ⑤champion(중약·정보). 행동과학: **default > 교육 > 권고**.
- **거부 장벽(#5) ↔ lever**: A 책임(최대) ← ②⑤(제도/가이드라인이 기준선 이동) · B 시간 ← ①⑥(default+약사가 마찰 제거) · C 습관 ← ①③(default+동료비교). **①default 는 B·C 를 강하게 풀지만 A 책임은 못 푼다 → ②⑤ 스택 필요.**
- **역효과 게이트(§4)**: 강한 lever(①②)는 grade 견고 중재(CYP2C19 결정맵 0.1521 🟢·3-axis 패널)에만 · adenosine 6mo MACE 🔴 falsify·siRNA MACE 🟠 deferred 에 강한 lever 부적합(근거 공백 은폐 역효과).
- **g5/d6/d2 준수**: 채택률 ⚪ proposal · grade X8/X19 VERBATIM(새 판정 0건) · 각 lever 역효과 명시 · 책임 장벽 미해결 정직 인정 · 돌파 path 동반(d2).

---

> ⚠ **하단 DISCLAIMER (반복)**: 본 X30 은 임상 중재 채택을 촉진하는 정책·행동·경제 전략 자료이며 처방·진단·급여결정 지시가 아니다. 채택률 수치(%·배수)는 전부 ⚪ proposal(한국 PCI 현장 실측 전)이고, lever 효과는 행동과학/실행과학 일반 근거(🟡)에 기반한 방향성 제안이다. default-nudge 는 opt-out 가능한 기본값이며 주치의 override(환자별 출혈위험·신기능·연령·동반약)를 반드시 허용해야 하고, X16 안전 결정맵(NM=clopidogrel·≥75yo clopi 강제·ticagrelor 회피·monthly 출혈 모니터)을 그대로 기본값화해야 출혈 dual jeopardy 역효과를 피한다. 중재 근거 grade·안전 빈도·ROI 산술은 X8/X16/X19 의 VERBATIM 인용이다.
