# X16 — CARDIO+ 안전성 / harm profile 통합 (효능의 이면)

> CARDIO+ 메타도메인 X16 산출물 · current-state · no history.
> **목적 = 4 트랙(N no-reflow · D DAPT-PGx · I ISR · L Lp(a))의 각 중재가 효능 문서(X5 portfolio · X11 layered-care)에서 약속한 이득의 honest 이면 — 부작용 프로파일 · 모니터링 · 중단/회피 규칙 — 을 단일 harm ledger 로 통합한다. 효능이 "무엇을 얻는가"라면 X16 은 "그 대가가 무엇이고 언제 멈춰야 하는가"이다.**
> 출처 = X5 (4-trial 중재) · X11 (침상 알고리즘) · X8 (grade ledger) + DOCTOR H2(no-reflow)·H3(DAPTPGX)·H4(ISR)·H5(LPA) + sub-V safety 파일 (NOREFLOW M6 · LPA M6 · ISR M7 · DAPTPGX M4/M7/M8/M12). **빈도·grade 는 모두 X8 / sub-V VERBATIM 인용** — X16 새 판정 0건 (per @D g5 · LLM self-judge 0건). d6 정직 · d2 돌파 path 동반.

---

## ⚠ DISCLAIMER (반드시 읽기)

> 이 문서는 **의사결정 지원(decision support) 자료이며 처방·진단·용량 지시가 아니다.**
> - 모든 약제·검사·용량·중단 결정은 심장내과 전문의가 환자별(출혈위험 ARC-HBR · 신기능 · 연령 · 동반약 · 시술 복잡도)로 종합 판단한다. 본 문서의 어떤 수치도 처방·중단 명령으로 해석해서는 안 된다.
> - 환자는 현 항혈소판제(특히 DAPT)를 **임의로 중단·변경하지 말 것** — 스텐트 혈전증 위험. 본 문서의 "중단/회피 규칙"은 의료진 판단의 입력일 뿐 환자 self-action 이 아니다.
> - 빈도·근거 등급(g5)은 CARDIO+ sub-domain verify verdict / X8 ledger 의 **VERBATIM 인용**이다. 효과·위험 추정 중 verdict 가 없는 것은 ⚪/🟠 로 분리한다.

---

## §0. g5 등급 규약 (rubric VERBATIM — `hexa verify rubric`)

| 등급 | 의미 (X16 내 용법) |
|---|---|
| 🔵 SUPPORTED-FORMAL | closed-form 산식 · atlas-registered recompute pass |
| 🟢 SUPPORTED-NUMERICAL | 시뮬레이션 / 수치 재계산 재현 가능 |
| 🟡 SUPPORTED-BY-CITATION | peer-review 1차 출처 cite (literature carry — 본 X16 harm 빈도의 대부분) |
| 🟠 INSUFFICIENT/DEFERRED | wet-lab · 임상 readout · 장기 registry 의존 — 현 단계 검증 불가 |
| 🔴 FALSIFIED | 명시적 reject (large RCT null 등) — 닫힌 음성, wall 아님 |
| ⚪ SPECULATION-FENCED | 본질적 미검증 (장기 추정 · 미래 trial · 이론적 우려) — ⚪ ≠ 거짓 |

> g5 준수: 본 §0 이하 모든 빈도·등급은 X8 ledger / sub-V safety 파일의 verbatim 복사다. **harm 빈도는 대부분 🟡 (pharmacovigilance/RCT citation)** — 효능 측과 동일하게 인체 RCT/registry citation-locked. 효과 추정(ST↓X% · LLL↓ · siRNA -80% MACE)은 효능 문서에서 이미 ⚪/🟠 로 분리됐고, 본 X16 은 그 효능의 **부작용 빈도** 를 verbatim 으로 마주 세운다. d6 — 억지 등급·억지 숫자 강제 0건.

---

## §1. 중재별 harm 표 — 4 트랙 (X5/X11 효능의 이면)

> 빈도·grade 는 sub-V safety 파일 / X8 ledger VERBATIM. "한국 특이" 칸은 동아시아/한국 인구 특이 안전 신호.

### 1.1 N 트랙 — no-reflow / IRI 미세혈관 (Trial-A NICORADENO 중재)

| 중재 | 주요 부작용 | 빈도 (근거 grade VERBATIM) | 모니터링 | 중단 / 회피 규칙 | 한국 특이 |
|---|---|---|---|---|---|
| **adenosine IC 24 mg distal** | 일과성 AV-block (1-3급) · sinus pause · flushing · 흉부 압박감 (5-10s) | transient AV-block "minor" (AMISTAD-II) · IC route hypotension <5% (REOPEN-AMI) — 🟡 [NOREFLOW M6 §3·§5] · 모든 부작용 t½ <10s, 가역성 최우수 🟡 [M6 §3.1] | 12-lead ECG · 후속 박동 (M6 §3) | **bradycardia 위험군 ❌ 회피** (M6 §4) · 천식 + 고도 AV-block 시 회피 (IV form bronchospasm) · t½ <10s 라 중단=수초 내 소실 | — (체격·ICH 와 무관, transient) |
| **nicorandil PO/IV** | **궤양 (구강·항문·위장관·각막)** · headache · 저혈압 | oral/anal ulcer **0.5-2% (long-term, ENABLE RCTs)** — 🟡 [M6 §5] · 장기 사용 시 ↑ (M6 §3) | 점막 ulcer 확인 (구강·항문 검진) — 장기 사용 시 필수 (M6 §3.1) | ulcer 발생 시 **감량/중단**으로 회복 가능 (M6 §5) · LVEF<30 · CrCl 30 까지는 사용 가능 (M6 §4) | 한국·일본 처방 우위(보험 등재) → 장기 노출 多 → ulcer monitor 부담 한국 특이 (M6 §3.1·§7) |
| **tirofiban IC 25 μg/kg** (대형 thrombus bailout) | major bleeding (TIMI) · thrombocytopenia (낮음, abciximab 대비 ↓) | bleeding "abciximab 보다 ↓" · IC route systemic exposure 1/10-1/100 (INFUSE-AMI IC bleeding 무증가) — 🟡 [M6 §3·§5] | plt count · 출혈 부위 (M6 §3) | **bleeding 위험군 ⚠ 주의** · renal failure 시 dose 조정 ⚠ (M6 §4) | ★ **한국인 출혈 baseline ↑** (TICAKOREA 신호 · 동양인 ICH risk ↑) → IC IIb/IIIa **dose-down 또는 회피 검토** (M6 §7) |

> N 트랙 핵심 이면: Tier-A 권고(adenosine IC + nicorandil)는 **가장 안전한 no-reflow 약물군** (M6 §6.1 Tier-A: transient만 / ulcer monitor 가능). 효능 측 IC-sync ODE Δ36.6pp (🟢)의 대가는 adenosine 의 일과성 AV-block(bradycardia 군 회피)과 nicorandil 의 장기 궤양뿐 — 모두 가역. 단 **mPTP IV bolus 가설은 🔴 FALSIFIED (4 RCT null)** — 즉 효능 자체가 닫힌 음성이라 harm 논의 대상에서 제외(X8 §5 F1-F4).

### 1.2 D 트랙 — CYP2C19 DAPT (Trial-B DAPT-PGx-K 중재)

| 중재 | 주요 부작용 | 빈도 (근거 grade VERBATIM) | 모니터링 | 중단 / 회피 규칙 | 한국 특이 |
|---|---|---|---|---|---|
| **clopidogrel** (NM/RM 권장) | (HTPR) 약효 부족 → ST 위험 · 출혈은 P2Y12 중 최저 | PM 에서 효과 大저하 (HTPR) — PM freq **0.1521** 🟢 / IM+PM **0.6279** 🟢 [DAPTPGX V3 §61 / X8] · ST↓X% 효과 = 🟠/⚪ (cohort 미측정) | PFT (VerifyNow PRU) — 환경변수(PPI·신기능) 시 (H3) | PM/IM 에서 단독 사용 시 **ST 위험으로 회피 고려** (H3 결정맵) | 한국인 IM+PM ~60% → clopidogrel 단독 비-최적 비율이 글로벌 최고 |
| **prasugrel 5 mg** (한국 dose · IM/PM) | major bleeding (clopi 대비 ↑) | ≥75yo **TIMI major bleeding 4.3% vs clopi 3.3% (HR 1.36, net harm)** — 🟡 [DAPTPGX M12 §5.2 / TRITON-TIMI 38] | Day 7-14 wound · Hb · Cr · BARC diary (M7 §5.3) | ★ **≥75yo "generally not recommended"** (FDA label) → 모든 prasug cell **clopi 강제** (M12 §5.6) · <60kg 주의 | 한국 5 mg 저용량 채택 = 동양인 출혈 baseline ↑ 대응 (서구 10 mg 대비) |
| **ticagrelor** (PM × HBR-low 옵션) | **major bleeding ↑↑** · **호흡곤란(dyspnea)** · **서맥(bradycardia)** | ★ **TICAKOREA major bleeding 2.8% vs PLATO 1.4% = 한국인 2배 (HR 2.26, 11.7% vs 5.3%)** — 🟡 [DAPTPGX M8 §92·M4 / Park 2020] · dyspnea ~14% (TALOS-AMI substudy) — 🟡 [M9 PMID 38574757] | Month 1~ **출혈/호흡곤란/서맥 monthly 모니터** (M12 §5.6) · 즉시 trigger=BARC≥2·흉통재발·호흡곤란 (M7 §5.3) | ★ dyspnea 시 **clopi switch 후 호흡곤란 거의 소실 + 허혈 동등** (Kim 2024) · polypharmacy(CYP3A4)·≥75yo 시 회피 (M12) · **dual jeopardy → universal ticagrelor 부적합** (H3) | ★★ **한국 최대 약물 안전 신호** — 동양인 ticag 출혈 2배 (TICAKOREA·Loh 2025 JACC Asia 재확인) → KSC 2024 clopi-first |

> D 트랙 핵심 이면: 효능 측 "결정맵 ST↓"의 직접 대가는 **출혈의 dual jeopardy** — PM/IM 에 강력제를 쓰면 ST 는 줄지만 한국인은 출혈이 서구의 2배(TICAKOREA HR 2.26). 그래서 결정맵 자체가 harm-reduction 도구다(§3). prasugrel 5 mg(한국 dose)·ticagrelor 회피·HOST-EXAM clopi 단독(HR 0.73)이 모두 출혈 가드레일.

### 1.3 I 트랙 — ISR / 비-mTOR (Trial-C ROCK-DCB 중재)

| 중재 | 주요 부작용 | 빈도 (근거 grade VERBATIM) | 모니터링 | 중단 / 회피 규칙 | 한국 특이 |
|---|---|---|---|---|---|
| **fasudil-coated DCB** (ROCK, FIH) | 저혈압 · 두통 · 간효소 ↑ (ROCK class) | ROCK family safety **A grade** — local 시 systemic 노출 거의 0 · JP 30년(cerebral vasospasm) + netarsudil US 녹내장 8년 — 🟡 [ISR M7 §5·§7] · NO↑ → re-endo 보조(약점 아닌 이점) | 30d safety endpoint (procedural · LST) — Trial-C 1차 종결점에 포함 (H4/X5) | safety 무강등 top pick (M7 §7) · 단 fasudil-DCB **전체 설계 = ⚪ proposal** (verify verdict 부재 · porcine NH 40-50%↓ 는 🟡 cite only, X5 §6) | 한국 small vessel 35-40% + OCT/IVUS 70%+ (세계 최고) → 재시술 원인별 안전 평가 platform (H4) |
| **(DCB carrier) paclitaxel-DCB** (대조/기존) | 후기 사망률 signal (역사적) | Katsanos 2018: 2y all-cause mortality **HR 1.68** · 5y **HR 1.93** (PAD, dose-dep) — 🟡 [ISR M7 §4] · **관상동맥 = dose <1mg → signal 부재** · **FDA 2023 black-box 해제** (signal 약화, A- grade) — 🟡 [M7 §4.2-4.4] | long-term mortality 추적 (M7 §8.1, FDA 2023 후 데이터 축적 중) | 관상동맥 적응증 정상화(현재) · 단 cumulative dose 高(긴 lesion) 회피 | — |
| **(device) Mg-BRS / PLLA-BRS** (차세대) | **scaffold/late stent thrombosis** | Absorb PLLA **scaffold thrombosis 1.9% vs DES 0.8%** (ABSORB III 3y) → 2017 시장 철수 (C grade) · Magmaris Mg-BRS **LST 0.7%/3y** (B grade, Absorb 대비 ↓) — 🟡 [M7 §6] | VLST 추적 · H₂ evolution (Mg, 임상영향 미상) | Absorb PLLA = 이미 철수(C) · Mg-BRS = 잠정 B, 추적 필요 (M7 §6.4) | — |

> I 트랙 핵심 이면: ISR 분야의 진짜 harm 은 약물보다 **device-level** — VLST(잔여 0.3-0.5%/yr, NA driver 미해결)와 BRS scaffold thrombosis(Absorb 철수). 비-mTOR top pick(ROCK/fasudil)은 오히려 safety A(local 노출 ~0)라 효능-안전 trade-off 가 가장 유리. 강등 red-flag = **HIF·Wnt (C, deferred)** · **BET (B-C, BETonMACE NS + 혈소판/간)** (M7 §5·§7). ISR grade = 🟢 0 / 🔵 0 (전부 bio-verify-kernel PR-pending) · 🟡 150+ citation-locked (X8).

### 1.4 L 트랙 — Lp(a) siRNA/ASO + PCSK9 (Trial-D K-LpA-OUTCOMES 중재)

| 중재 | 주요 부작용 | 빈도 (근거 grade VERBATIM) | 모니터링 | 중단 / 회피 규칙 | 한국 특이 |
|---|---|---|---|---|---|
| **pelacarsen** (ASO, Q4W) | **flu-like reaction** · 주사부위 반응 · ALT↑ (간효소) · (1세대) platelet/renal | flu-like **~30% (Q4W 24-48h, TLR9)** · hepatotox ALT↑ **~5%** (GalNAc-ASO class, 대부분 무증상·가역) — 🟡 [LPA M6 §3] · platelet/renal = rare (GalNAc 로 hepatocyte 좁혀짐, pelacarsen Ph2 신호 없음) | ALT/AST · platelet · 주사부위 (M6 §9) | washout **1-2개월 (회수 high)** → idiosyncratic AE 시 가장 회수 쉬움 (M6 §8) · 가임 여성 회피(태반, M6 §6) | 한국 sub-analysis 대기 (M6 §7, 🟠 DEFERRED) — ASGPR uptake 라 ethnicity 변동 낮음 |
| **olpasiran** (siRNA, Q12W) | 주사부위 반응 (LSR) · ALT↑ 거의 없음 | LSR **~10%** · ALT↑ 신호 거의 없음 · major safety signal 없음 (OCEAN(a)-DOSE Ph2) — 🟡 [LPA M6 §4·§9] · inclisiran(ORION n>3,600, 1.5y) 플랫폼 안전 외삽 🟡 | 주사부위 · ALT (M6 §9) | washout **3-6개월 (회수 mid)** (M6 §8) · 가임 여성 회피 | inclisiran 한국 시판 후 KSoLA registry 신호 미미 (M6 §7) |
| **lepodisiran** (siRNA, Q24-48W) | LSR · **chronic 효과 unknown** | LSR ~10% · chronic(Q12m) **unknown** — 🟠 [LPA M6 §9] | 장기 chronic 추적 (Q24W+ 데이터 부족, 🟠 DEFERRED M6 §10) | ★ **washout 1년+ (회수 low)** → **idiosyncratic AE 시 약효 reversal 불가 = platform 최대 우려** (M6 §4·§8 핵심) | — |
| **PCSK9 mAb** (evolocumab/alirocumab · arm A background) | 주사부위 반응 · neurocog 약신호 | 주사부위 반응 only · FOURIER(n=27,564)·ODYSSEY(n=18,924) 5-7y 안전 — 🟡 [ISR M7 §5] · Lp(a) -25% 는 LDL 급여의 부수효과 (H5) | 표준 LDL 추적 | safety A · ASCVD 2차 급여(LDL 기준) 즉시 가용 | — |

> L 트랙 핵심 이면 (2축, LPA M6 §1): **(축 A 표적)** Lp(a)↓ 자체는 KIV-2 high-copy lifelong-null carrier(~인구 10%)의 부정 표현형 부재로 **강한 Mendelian 안전 보증** 🟡 — 즉 "낮추는 것" 자체는 안전. **(축 B 플랫폼)** 핵심 미지 = **long-acting siRNA 회수 불가** + 10-30년 누적 안전성 미관찰(🟠). 효능 측 siRNA -80~98% Lp(a)↓(surrogate, MACE 는 🟠 DEFERRED)의 대가는 acute flu-like/LSR(가역)와, lepodisiran 의 비가역성이라는 정직한 platform 우려.

---

## §2. 출혈위험 종합 순위 — 가장 위험한 중재 + 가드레일

> X16 의 핵심 cross-track 질문: "어느 중재가 가장 출혈위험이 높고, 그 가드레일은 무엇인가." 출혈은 D 트랙(DAPT)에 집중되며 한국 특이 신호가 가장 강하다.

```
 출혈위험 순위 (한국인 기준 · sub-V VERBATIM)
─────────────────────────────────────────────────────────────────────────
 #1 ticagrelor (D)   ██████████  TICAKOREA major bleed 2.8% vs PLATO 1.4% (2배, HR 2.26)
                                  + dyspnea ~14% + 서맥 → dual jeopardy
 #2 prasugrel 5mg(D)  ██████░░░░  ≥75yo TIMI major 4.3% vs 3.3% (HR 1.36, net harm)
 #3 tirofiban IC (N)  ████░░░░░░  bleeding (abciximab 대비↓) · 한국 dose-down 검토
 #4 pelacarsen (L)    ██░░░░░░░░  platelet drop = rare (GalNAc, Ph2 신호 없음)
 #5 clopidogrel (D)   █░░░░░░░░░  P2Y12 중 출혈 최저 (단 PM HTPR = 약효 부족 위험)
─────────────────────────────────────────────────────────────────────────
```

| 항목 | 내용 |
|---|---|
| **가장 출혈위험 높은 중재** | **ticagrelor (D 트랙)** — TICAKOREA major bleeding **2.8% vs PLATO 1.4% (한국인 2배 · HR 2.26)** + dyspnea ~14% + 서맥. 동양인 출혈 baseline ↑ + ICH risk ↑ 가 겹쳐 "약효(ST↓)와 출혈 과다"의 **dual jeopardy** (H3). 🟡 [DAPTPGX M8 §92] |
| **그 가드레일** | (1) **universal ticagrelor 거부** — PM × HBR-low cell 에서만 옵션, 나머지는 clopidogrel/prasugrel 5mg (M7 결정맵) · (2) **Month 1~ 출혈/호흡곤란/서맥 monthly 모니터** + BARC≥2 즉시 trigger (M12 §5.6 · M7 §5.3) · (3) **dyspnea 시 clopi switch** (호흡곤란 소실 + 허혈 동등, Kim 2024) · (4) **≥75yo·polypharmacy·CYP3A4 병용 시 회피** · (5) HOST-EXAM **clopi 단독 chronic** (HR 0.73) 으로 출혈 부담 자체 축소 |

---

## §3. cross-domain 안전 시너지 / 충돌 — 3-axis 층화가 harm 도 줄인다

> X5/X11 의 3-axis 층화(ALDH2\*2 × CYP2C19 LoF × Lp(a)/KIV-2)는 효능뿐 아니라 **harm 도 stratify** 한다 — 채혈 1회 패널이 "누구에게 어떤 약이 위험한가"를 동시에 분기한다.

### 3.1 시너지 — 층화가 harm 을 줄이는 경로

| 패널 축 | 효능 leverage (X11) | **harm-reduction leverage (X16)** |
|---|---|---|
| **CYP2C19 LoF** | NM=clopi · IM/PM=강력제로 ST↓ | ★ **출혈 회피**: PM/IM 식별 → 강력제가 필요한 환자만 선별 → 불필요한 universal ticagrelor 의 한국인 출혈 2배(TICAKOREA)를 회피. NM 에는 출혈 최저 clopidogrel 유지 → harm 최소화. 즉 **결정맵 = 동시에 efficacy 도구이자 bleeding-avoidance 도구** |
| **ALDH2\*2** | NO bioavailability↓ 인지 | nicorandil/adenosine 은 모두 safety Tier-A(transient/ulcer-monitorable) → ALDH2 층화가 IRI harm 을 키우지 않음 (효능 modifier 일 뿐) |
| **Lp(a)/KIV-2** | 잔여위험 stratify | ★ **narrow staging = 노출 최소화**: ≥180mg/dL·ASCVD 2차로 좁히면 siRNA 의 장기 누적 미지 노출(축 B 우려)을 최고위험군에만 한정 → 불필요한 평생 비가역 노출 회피 |

### 3.2 충돌 — 트랙 간 병용 시 출혈 가산 (cross-track harm)

```
   D 트랙 (DAPT)              ↔        L 트랙 (siRNA/ASO)          ↔   I 트랙 (DCB/BRS)
   강력 P2Y12 출혈↑                    pelacarsen platelet drop(rare)     LST/VLST → DAPT 연장
        │                                    │                                │
        └──────────── 동일 PCI 환자가 동시 보유 가능 (cross-cut) ──────────────┘
                                    ▼
   ★ 충돌 1: 강력 DAPT(D) + ASO platelet 신호(L, rare) → 출혈 가산 모니터 (희박하나 평가)
   ★ 충돌 2: BRS/DCB LST 위험(I) → DAPT 연장 필요 ↔ 한국인 출혈 baseline↑(D) → 기간 trade-off
   ★ 충돌 3: ticagrelor CYP3A4 병용(D) ↔ polypharmacy 노인 → 약물상호작용 출혈 (M12)
```

| 충돌 | 내용 | 완화 (가드레일) |
|---|---|---|
| **DAPT 기간 ↔ 한국 출혈 baseline** | I 트랙 LST/VLST 예방은 DAPT 연장을 요구하나, D 트랙 한국인 출혈 baseline↑ 와 충돌 | 3G bio-polymer DES(uncovered strut 2-5%) + STOPDAPT-2/MASTER-DAPT **1m DAPT** 로 LST 무신호 하 단축 (ISR M7 §3.2) · HBR-HIGH 3-6mo 우선 |
| **강력 DAPT ↔ ASO platelet (rare)** | prasugrel/ticagrelor(D) + pelacarsen(L, platelet rare) 병용 시 이론적 출혈 가산 | platelet monitor (L M6 §9) · 신호 시 ASO 회수 high(1-2mo) |
| **ticagrelor CYP3A4 ↔ polypharmacy** | 노인 polypharmacy 시 ticag 약물상호작용 출혈 | ticag 회피·clopi 우선 (M12 §5.5) |

> §3 종합: 3-axis 층화는 **효능과 harm 을 같은 패널로 동시에 stratify** — 특히 CYP2C19 패널이 "강력제가 필요한 PM/IM 만 선별 → 나머지엔 출혈 최저 clopidogrel" 로 **universal 강력제의 한국인 출혈 2배를 구조적으로 회피**한다. 트랙 병용 충돌(DAPT 기간 ↔ 출혈, DAPT ↔ ASO platelet)은 모두 가드레일이 존재 — d2 (포기 0건).

---

## §4. layered-care (X11) 안전 가드레일 — 알고리즘 각 분기의 stopping rule

> X11 §1 침상 알고리즘의 각 분기에 대응하는 **중단/회피 규칙(stopping rule)** 을 명시. 효능 분기마다 "언제 멈추는가"를 짝지운다.

```
 X11 알고리즘 분기                          → X16 stopping rule (sub-V VERBATIM)
═══════════════════════════════════════════════════════════════════════════════════════

 [PCI 중] no-reflow 분기 (N)
   TIMI≤2 → IC adenosine 24mg              → bradycardia/고도AV-block 군 ❌ 회피 (M6 §4)
                                              · t½<10s 라 부작용=수초 내 소실
   ± nicorandil                            → 장기 사용 시 점막 ulcer 발생 → 감량/중단 (M6 §5)

 [채혈 1회 3-axis 패널] 분기점
   ① ALDH2*2                               → (약제 직결 아님, modifier — stopping rule 없음)
   ② CYP2C19 → NM                          → clopidogrel 유지 (출혈 최저, 중단 사유 적음)
              → IM/PM → prasugrel 5mg       → ★ ≥75yo prasug 절대 회피 → clopi 강제 (M12 §5.6)
                                              · <60kg 주의
              → PM × HBR-low → ticagrelor   → ★ Month1~ 출혈/호흡곤란/서맥 monthly (M12 §5.6)
                                              · dyspnea → clopi switch (Kim 2024)
                                              · BARC≥2/흉통재발/호흡곤란 = 즉시 trigger (M7 §5.3)
   ③ Lp(a)≥75/KIV-2 low → (향후) siRNA      → 가임 여성 회피(태반) · lepodisiran 비가역 우려
                                              · ALT/platelet/주사부위 monitor (L M6 §9)

 [ISR surveillance] (I, 공통 layer)
   재발 흉통 → OCT/IVUS 재시술               → BRS 사용 시 scaffold thrombosis 추적
   (향후) fasudil-DCB                        → 30d safety endpoint (procedural·LST) 평가
   DAPT 연장 필요 ↔ 출혈 baseline           → 3G bio-polymer + 1m DAPT (LST 무신호 단축)

 [공통] DAPT 전 기간                          → ★ 환자 임의 중단 금지(ST 위험) ·
                                              BARC bleeding diary (Day7-14~) (M7 §5.3)
```

| X11 분기 | stopping / 회피 rule (VERBATIM) | grade |
|---|---|---|
| IC adenosine (N) | bradycardia·고도 AV-block 군 회피 · 천식 시 IV form 회피 (M6 §4) | 🟡 |
| nicorandil (N) | 점막 ulcer 시 감량/중단 (M6 §5) | 🟡 (ulcer 0.5-2%) |
| prasugrel 5mg (D) | **≥75yo 회피 → clopi 강제** · <60kg 주의 (M12 §5.6) | 🟡 (TRITON HR 1.36) |
| ticagrelor (D) | **monthly 출혈/호흡곤란/서맥 모니터** · BARC≥2/dyspnea = 즉시 trigger → clopi switch (M12·M7) | 🟡 (TICAKOREA 2.8%) |
| siRNA/ASO (L) | 가임 여성 회피 · ALT/platelet monitor · lepodisiran 비가역 우려 (L M6 §6·§8·§9) | 🟡 acute / 🟠 chronic |
| DCB/BRS (I) | scaffold thrombosis 추적 · 1m DAPT 로 출혈 가드 (M7 §3·§6) | 🟡 |
| **공통 DAPT** | **환자 임의 중단 금지(ST)** + BARC diary (M7 §5.3) | 🟡 |

### 4.1 layered-care 에 추가할 stopping rule — top 1

> X11 알고리즘에 **명시적 stopping rule 로 가장 우선 추가할 단일 항목**.

**★ "ticagrelor cell 의 Month-1 출혈/호흡곤란/서맥 monthly 모니터 + 즉시 trigger(BARC≥2·dyspnea) → clopidogrel switch" 를 D 축 분기의 명시 stopping rule 로 삽입.**
- 근거: ticagrelor 가 4 트랙 전체에서 **최대 출혈위험 중재**(TICAKOREA 2.8% = 한국 2배, HR 2.26)이고, dyspnea ~14% 가 흔하며, 둘 다 **clopi switch 로 가역**(호흡곤란 소실 + 허혈 동등, Kim 2024)이다. X11 §1 D축 분기는 "ticagrelor(출혈균형)"까지만 명시하고 **언제 멈추고 무엇으로 바꾸는가**의 stopping rule 이 알고리즘 박스에 없다 — 이 한 줄이 한국 최대 약물 안전 신호에 직접 대응한다. 🟡 [DAPTPGX M12 §5.6 · M7 §5.3 VERBATIM].

---

## §5. g5 grade — X16 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 중재별 harm 표 (4 트랙) | 🟡 SUPPORTED-BY-CITATION (compositional) + 🟢(인용) | 빈도 = sub-V safety 파일(NOREFLOW M6·LPA M6·ISR M7·DAPTPGX M4/M8/M12) VERBATIM · PM 0.1521/IM+PM 0.6279 = 🟢 carry |
| §2 출혈위험 순위 + 가드레일 | 🟡 | TICAKOREA 2.8% · TRITON HR 1.36 VERBATIM 정렬 |
| §3 cross-domain 안전 시너지/충돌 | 🟡 | 3-axis 층화 harm-reduction = X11 §3 leverage 의 harm 측 mapping (compositional) |
| §4 layered-care 안전 가드레일 | 🟡 | X11 §1 분기 ↔ sub-V stopping rule VERBATIM 짝지음 |

**X16 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — 4 sub-domain safety 파일 + X8 ledger + DOCTOR H2-H5 의 **harm profile 통합**. **X16 새 판정 0건** (per @D g5 · LLM self-judge 0건). harm 빈도는 효능과 동일하게 인체 RCT/pharmacovigilance citation-locked(🟡) · 🟢 정량(PM 0.1521 등) verbatim carry · 장기 누적/한국 sub-population 안전은 🟠 DEFERRED 정직 격리(d6) · 🔴 mPTP 4 RCT null 은 효능 닫힌 음성으로 harm 대상 외 명시 · 미가용 옵션은 d2 가드레일 동반 · "의사결정 지원, 처방 아님" 톤 · completed-form(d1).

---

## §6. X16 산출 요약

- **4 트랙 harm 표**: N(adenosine 일과성 AV-block · nicorandil ulcer 0.5-2% · tirofiban 출혈) · D(clopi HTPR · prasugrel 5mg ≥75yo 출혈 HR 1.36 · **ticagrelor TICAKOREA 2.8%=한국 2배 + dyspnea ~14% + 서맥**) · I(fasudil-DCB safety A · paclitaxel Katsanos HR 1.68/1.93→관상동맥 signal 부재·FDA 2023 해제 · BRS scaffold thrombosis) · L(pelacarsen flu-like ~30%+ALT~5% · olpasiran LSR~10% · **lepodisiran 비가역** · PCSK9 주사부위만).
- **가장 출혈위험 높은 중재** = **ticagrelor (D)** — TICAKOREA 2.8% vs PLATO 1.4%(2배, HR 2.26) + dyspnea + 서맥. 가드레일 = universal 거부 + monthly 모니터 + dyspnea 시 clopi switch + ≥75yo/polypharmacy 회피 + HOST-EXAM clopi 단독.
- **cross-domain**: 3-axis 층화가 **harm 도 stratify** — CYP2C19 패널이 강력제 필요 환자만 선별 → universal 강력제의 한국인 출혈 2배 구조적 회피. 충돌(DAPT 기간↔출혈, DAPT↔ASO platelet, ticag CYP3A4)은 모두 가드레일 존재(d2).
- **layered-care 가드레일**: X11 각 분기에 stopping rule 짝지음 · 추가 top 1 = **ticagrelor cell Month-1 monthly 모니터 + BARC≥2/dyspnea trigger → clopi switch**.
- **g5/d2/d6 준수**: 빈도 sub-V VERBATIM · 새 판정 0건 · 장기/한국 sub-pop 안전 🟠 정직 격리 · 미가용→가드레일 path · 처방 아님 톤.

---

> ⚠ **하단 DISCLAIMER (반복)**: 본 문서는 의사결정 지원 자료이며 처방·진단·중단 명령이 아니다. 부작용 빈도·중단 규칙은 sub-domain verify verdict / pharmacovigilance citation 의 verbatim 인용이며, 모든 약제·중단 결정은 전적으로 담당 의료진 판단이다. 환자는 항혈소판제를 임의 중단·변경하지 말 것(스텐트 혈전증 위험). 장기 누적 안전성·한국 sub-population 안전(🟠)은 검증된 사실이 아닌 미래 readout/registry 의존 영역이다.
