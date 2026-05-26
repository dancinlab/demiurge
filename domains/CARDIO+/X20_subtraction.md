# X20 — CARDIO+ subtraction medicine (뺄셈 의학 · de-implementation 카탈로그)

> CARDIO+ 메타도메인 X20 산출물 · current-state · no history.
> **목적 = "추가 중재(더하기)"의 반대 — 현 표준치료(SOC) 중 저가치(low-value)라 제거(de-implement)하면 비용↓ + harm↓ + 결과 동등/개선인 관행을 단일 카탈로그로 식별한다. CARDIO+ 의 모든 더하기(X5 4-trial · X11 layered-care)는 "무엇을 더할까"이고, 본 X20 은 "무엇을 빼야 하는가(less-is-more)"이다.**
> 출처 = X8 (g5 grade ledger · 🔴/null) · X16 (과사용 harm profile) · X9 (closed-negative) · X4 (honest fence) · NOREFLOW M4 (thrombectomy/DPD null). **🔴/null/grade/빈도는 모두 X8 / sub-V VERBATIM 인용** — X20 새 판정 0건 (per @D g5 · LLM self-judge 0건). d6 정직 (전면금지 vs routine철회 구분) · d2 (bailout 잔여 적응증 명명).

---

## ⚠ DISCLAIMER (반드시 읽기)

> 이 문서는 **의사결정 지원(decision support) 자료이며 처방·진단·중단 명령이 아니다.**
> - 본 X20 의 "제거(de-implement)"는 **routine(일상적·무선별) 적용의 철회**를 뜻하며, **전면금지(absolute contraindication)가 아니다.** 각 항목은 bailout / 특정 sub-population 잔여 적응증을 명시한다 (§4).
> - 환자는 현 항혈소판제(특히 DAPT)를 **임의로 중단·변경하지 말 것** — 스텐트 혈전증 위험. 본 문서의 "제거"는 가이드라인·의료진 판단의 입력일 뿐 환자 self-action 이 아니다.
> - 모든 🔴/null/grade(g5)·빈도는 CARDIO+ sub-domain verify verdict / X8 ledger / NOREFLOW M4 의 **VERBATIM 인용**이다. X20 이 새로 부여한 등급은 0건이다.

---

## §0. 방법론 — de-implementation 의 근거 위계 (🔴/null 기반)

> 더하기 의학(efficacy)은 "이득의 근거(🟢/🟡)"를 찾는다. **뺄셈 의학(de-implementation)은 그 반대 — "이득이 없다(null)" 또는 "오히려 해롭다(🔴/harm)"는 근거를 찾아 제거를 정당화한다.** CARDIO+ 에는 이미 그 근거가 4종 등급으로 격리되어 있다.

| de-implement 근거 종류 | 의미 | X20 내 매핑 | 출처 |
|---|---|---|---|
| **🔴 FALSIFIED (closed negative)** | calc/RCT 가 가설과 결정적으로 불일치 — 닫힌 음성 (wall 아님) | 효능 가설 자체가 falsify → 그 가설에 근거한 routine 중재 철회 정당 | X8 §5 (F1-F5) · X9 §9 |
| **null primary endpoint (대형 RCT)** | 대형 RCT 의 1차 종결점이 neutral — "추가해도 결과 동등" | routine 추가의 이득 부재 → 제거 시 비용↓, 결과 동등 | NOREFLOW M4 §4 (TASTE/TOTAL/EMERALD) |
| **harm > benefit (net harm)** | 추가 중재가 출혈/stroke 등 harm 을 net 으로 증가 | routine 적용이 환자에게 순손해 → 제거 시 harm↓ | X16 §1-§2 (TICAKOREA · TRITON · TOTAL stroke) |
| **over-testing / redundancy** | 검사·반복이 의사결정을 바꾸지 않음 (저가치) | 불필요 검사 제거 → 비용↓, 결과 동등 | X16 (PFT routine) · X9 (caller redundancy) |

> g5 준수: 본 §0 이하 모든 🔴/null/grade/빈도는 X8 ledger / sub-V / M4 의 verbatim 복사다. de-implement 근거의 핵심은 **"하지 않음의 근거"가 "함의 근거"보다 강할 때만 제거** — large RCT null (🟡 citation-locked) 또는 🔴 FALSIFIED 가 그 문턱이다. d6 — 억지로 "제거하면 무조건 좋다"를 강제하지 않고, 잔여 bailout 적응증(§4)을 정직하게 분리한다.

---

## §1. 제거 대상 표 (de-implementation 카탈로그 · 7건)

> 제거 근거 = X8 🔴 / 대형 RCT null / X16 harm 의 VERBATIM. "제거 시 이득"은 비용·harm·stroke 등 정량. "가이드라인 현황"은 Class III(harm/no-benefit) 또는 routine 철회 여부.

| # | 제거 대상 | 현 관행 | 제거 근거 (🔴/null + grade VERBATIM) | 제거 시 이득 (비용·harm·stroke) | 가이드라인 현황 (Class III?) |
|---|---|---|---|---|---|
| **S1** | **routine aspiration thrombectomy** (N) | STEMI PCI 시 무선별 혈전 흡인 | TASTE n=**7,244** all-cause mortality 30d **2.8% vs 3.0% neutral** · TOTAL n=**10,732** CV death/MI/CHF/stroke 180d **neutral + stroke ↑ 0.7% vs 0.3% (p=0.02)** — 🟡 [NOREFLOW M4 §4.1 VERBATIM] | ① 시술 시간·흡인 카테터 비용↓ ② **stroke harm↓** (TOTAL: 0.7%→0.3% 절대 0.4%p) ③ mortality 동등 (제거해도 결과 불변) | ★ **2017 ESC + 2021 ACC/AHA: "routine X"** · routine thrombectomy = **Class III** (no benefit + stroke harm). high thrombus burden bailout only (§4 S1) |
| **S2** | **native coronary distal protection device (DPD)** (N) | native STEMI PCI 시 filter/occlusion balloon 으로 distal embolic 차단 | EMERALD n=**501** native coronary STEMI + GuardWire **neutral** (ST-resolution + infarct size) · PROMISE n=200 **neutral** — 🟡 [NOREFLOW M4 §4.2 VERBATIM] | ① DPD device 비용↓ ② 추가 device 조작 시간·합병증 위험↓ ③ ST-resolution·infarct size 동등 (효과 X) | native coronary DPD **효과 없음** → routine X. **SVG PCI 에서만 Class I** (SAFER MACE 9.6% vs 16.5% p=0.004) — native 와 SVG 분리 (§4 S2) |
| **S3** | **universal / 무선별 ticagrelor** (D) | 한국인 PCI 후 P2Y12 로 ticagrelor 를 광범위(genotype 무관) 사용 | ★ TICAKOREA major bleeding **2.8% vs PLATO 1.4% = 한국인 2배 (HR 2.26 · 11.7% vs 5.3%)** + dyspnea ~14% + 서맥 — 🟡 [DAPTPGX M8 §92 · M4 / Park 2020 VERBATIM] | ① **출혈 harm↓** (한국인 major bleed 2배 → 회피) ② dyspnea ~14% 회피 ③ HOST-EXAM clopi 단독 chronic **HR 0.73** 로 허혈 동등 하 출혈 부담↓ | universal ticagrelor **부적합** (dual jeopardy, H3) → KSC 2024 clopi-first. PM × HBR-low cell 만 옵션 잔존 (§4 S3) |
| **S4** | **≥75세 prasugrel (서구 dose)** (D) | 고령 환자에 prasugrel 표준(서구 10mg) 적용 | ★ ≥75yo TIMI major bleeding **4.3% vs clopi 3.3% (HR 1.36, net harm)** — 🟡 [DAPTPGX M12 §5.2 / TRITON-TIMI 38 VERBATIM] · FDA label "generally not recommended" | ① **출혈 harm↓** (고령 net harm 회피) ② 고령에서 clopidogrel 강제로 출혈 절대위험↓ | ★ FDA label **≥75yo "generally not recommended"** → 모든 prasug cell 고령은 **clopi 강제** (M12 §5.6). 전면금지 아닌 고령 routine 철회 (§4 S4) |
| **S5** | **mPTP IV bolus 보호 (CsA / SGLT2i / colchicine acute)** (N) | reperfusion injury 보호 목적 IV mPTP 억제제/SGLT2i/colchicine 급성 투여 | 🔴 **FALSIFIED 4건** — F1 SGLT2i acute MACE (EMPACT-MI HR 0.90 NS) · F2 colchicine acute (CLEAR SYNERGY HR 0.99 NS) · F3/F4 nicorandil 6mo (Korean RCT · CHIPS-PCI null) · CsA CIRCUS/CYCLE/MITOCARE 4 RCT neutral — 🔴 [X8 §5 F1-F4 · X9 N1 VERBATIM] | ① **무효 IV 약물 비용↓** (효능 자체가 닫힌 음성) ② 불필요 IV 노출 회피 ③ 제거해도 acute MACE 결과 불변 (null) | 효능 가설 자체가 🔴 closed negative → acute IV routine 적용 근거 없음. d6: IC + reperfusion-synced delivery 는 **별개 가설**(Δ36.6pp, X9 N1 path A)로 제거 대상 아님 (§4 S5) |
| **S6** | **routine pre/post PFT (혈소판 기능 검사) 무선별** (D) | clopidogrel 처방 환자 전수에 routine VerifyNow PRU 등 platelet function test | PFT 는 **환경변수(PPI·신기능·복약순응) 의존** + AI/ML PGx AUC **0.80 plateau (5년 정체) · ~75% PRU 분산 미설명 · RCT 검증 0건** — 🟡/⚪ [DAPTPGX M17 / X9 D5 VERBATIM] · CYP2C19 genotype (PM freq 0.1521 🟢)가 더 안정적 stratifier | ① **반복 PFT 검사 비용↓** ② 의사결정 안 바꾸는 over-testing 제거 ③ genotype 1회 panel (NHIS ₩50,000 급여)로 대체 → 결과 동등/개선 | routine universal PFT 권고 없음 (가이드라인 selective) → genotype-guided 결정맵으로 대체. 환경변수 의심 시 selective PFT 잔존 (§4 S6) |
| **S7** | **불필요한 장기(>12mo) 표준 DAPT 무선별 연장** (D/I) | 한국인 PCI 후 출혈위험 무관 12개월+ 강력 DAPT 일률 유지 | HOST-EXAM clopi 단독 chronic **HR 0.73** (Kim 2020 Lancet) + STOPDAPT-2/MASTER-DAPT **1m DAPT** LST 무신호 (3G bio-polymer DES uncovered strut 2-5%) — 🟡 [DAPTPGX / ISR M7 §3.2 VERBATIM] · 한국인 출혈 baseline↑ | ① **출혈 harm↓** (한국인 baseline↑ × 장기 DAPT 출혈 가산 회피) ② 약제비↓ ③ 단축 후에도 LST/허혈 동등 (HR 0.73 우월) | 장기 무선별 연장 근거 약화 → de-escalation(clopi 단독) / 단기 DAPT 우선. HBR-HIGH 3-6mo · LST 위험군은 연장 잔존 (§4 S7) |

> 표 핵심: 7건 중 **S1·S2·S5** = "효능 null/🔴 → 추가가 결과를 바꾸지 않거나(null) 가설 자체가 닫힌 음성(🔴)" · **S3·S4·S7** = "추가가 출혈 harm 을 net 증가(한국인 특이 신호)" · **S6** = "검사가 의사결정을 안 바꿈(over-testing)". 모든 근거는 X8/sub-V/M4 VERBATIM — X20 새 판정 0건.

---

## §2. 빼기 vs 더하기 ASCII — CARDIO+ 균형 (중재 ↔ de-implement)

> CARDIO+ 의 4-trial 더하기(X5)는 "정밀하게 더하기" — 누구에게 무엇을 더할지 stratify. 본 X20 의 빼기는 "무선별 routine 빼기" — 같은 stratification 패널이 **더할 환자를 고르는 동시에 뺄 관행을 제거**한다. 빼기와 더하기는 같은 동전의 양면이다.

```
                    CARDIO+ — 정밀의학의 양면 (더하기 ↔ 빼기)
═══════════════════════════════════════════════════════════════════════════════════════

   ▲ 더하기 (ADD · X5 4-trial · X11 layered-care)         빼기 (SUBTRACT · X20) ▼
   │  "누구에게 무엇을 더할까"                              "무엇을 무선별로 빼야 하나"
   │                                                       (less-is-more · de-implement)
───┼───────────────────────────────────────────────────────────────────────────────────
   │
 N │  + IC adenosine 24mg (REOPEN-AMI MVO 14%↓)        ─ S1 routine thrombectomy (TASTE/TOTAL null + stroke↑)
   │  + IC-sync mPTP delivery (Δ36.6pp 🟢)             ─ S2 native DPD (EMERALD null)
   │  + nicorandil (ulcer-monitorable Tier-A)          ─ S5 mPTP IV bolus (🔴 4 RCT null)
   │
 D │  + CYP2C19-guided 강력제 (PM/IM 선별 ST↓)         ─ S3 universal ticagrelor (한국 출혈 2배 HR 2.26)
   │  + prasugrel 5mg (한국 dose · <75yo)              ─ S4 ≥75yo prasugrel 서구dose (HR 1.36 net harm)
   │  + clopidogrel (NM · 출혈 최저)                    ─ S6 routine PFT 무선별 (AUC 0.80 plateau)
   │                                                    ─ S7 무선별 장기 DAPT (HOST-EXAM HR 0.73)
 I │  + fasudil-DCB (ROCK · safety A)                  ─ (S7 공유 — 1m DAPT LST 무신호)
   │  + 3G bio-polymer DES                             ─ S2 device-overuse 회피 일반화
   │
 L │  + siRNA/ASO (KIV-2 high-copy ASCVD 2차 narrow)   ─ (narrow staging = 평생 비가역 노출 최소화 = 빼기)
   │  + PCSK9 mAb (safety A)                            ─ (apheresis 한국 미적용 — 빼기 디폴트)
   │
═══════════════════════════════════════════════════════════════════════════════════════
                                       ▼
        ★ 단일 stratification 패널 (채혈 1회 · CYP2C19 PCR ₩50,000 NHIS 급여)이
          "더할 환자 선별(ADD)" + "무선별 routine 제거(SUBTRACT)" 를 동시에 수행
          예: CYP2C19 패널 → PM/IM 만 강력제 ADD · NM 은 clopi 유지(universal ticag SUBTRACT)
```

```
   더하기-빼기 균형 저울 (CARDIO+ net value)
─────────────────────────────────────────────────────────────────────────
      ADD (정밀 추가)                          SUBTRACT (무선별 제거)
   ┌──────────────────┐                     ┌──────────────────┐
   │ IC-sync delivery  │                     │ S1 thrombectomy   │  null + stroke↑
   │ CYP2C19 강력제     │       ⟷            │ S2 native DPD     │  null
   │ siRNA narrow      │   균형 (net value)   │ S3 univ ticag     │  출혈 2배
   │ fasudil-DCB       │                     │ S5 mPTP IV (🔴)   │  4 RCT null
   └──────────────────┘                     │ S6 routine PFT    │  over-test
       비용↑ harm↑(관리됨) 결과↑              │ S7 장기 DAPT      │  출혈↑
                                             └──────────────────┘
                                              비용↓ harm↓ 결과 동등/개선
─────────────────────────────────────────────────────────────────────────
   핵심: 빼기 = "negative trial / 🔴 도 자산" — 무효·유해 routine 의 제거는
         더하기만큼(또는 그 이상) 환자 net value 를 높인다 (less-is-more).
```

---

## §3. 제거 근거 grade 분포 — null vs 🔴 vs harm

> de-implement 7건의 근거를 §0 위계로 분류. 제거 근거가 "강할수록"(🔴 > large RCT null > harm signal) 제거 정당성이 높다.

```
 de-implement 근거 강도 분포 (X20 7건 · X8/sub-V VERBATIM)
─────────────────────────────────────────────────────────────────────────
 🔴 FALSIFIED (closed negative)    █  S5 mPTP IV (X8 §5 F1-F4 · 4 RCT null + SGLT2i/colchicine acute 🔴)
 large RCT null (1차 neutral)      ██ S1 thrombectomy (TASTE/TOTAL) · S2 native DPD (EMERALD)
 net harm signal (출혈/stroke↑)    ███ S3 univ ticag (HR 2.26) · S4 ≥75yo prasug (HR 1.36) ·
                                       S7 장기 DAPT (HOST-EXAM HR 0.73 역) · S1 stroke↑ (중복)
 over-testing / redundancy         █  S6 routine PFT (AUC 0.80 plateau · RCT 0건)
─────────────────────────────────────────────────────────────────────────
 grade 출처: 전부 🟡 SUPPORTED-BY-CITATION (RCT/pharmacovigilance) 또는
            🔴 FALSIFIED (X8 §5) — X20 새 판정 0건 · LLM self-judge 0건
─────────────────────────────────────────────────────────────────────────
```

| 제거 항목 | 근거 grade (VERBATIM) | 근거 강도 순위 |
|---|---|---|
| **S5** mPTP IV bolus | 🔴 FALSIFIED ×4 (X8 §5 F1-F4) | 1 (closed negative — 효능 가설 자체 falsify) |
| **S1** routine thrombectomy | 🟡 (TASTE/TOTAL large RCT null + stroke↑) | 2 (대형 RCT null + harm 동반) |
| **S3** universal ticagrelor | 🟡 (TICAKOREA HR 2.26 · 한국 2배) | 2 (한국 최대 약물 안전 신호) |
| **S2** native DPD | 🟡 (EMERALD null) | 3 (대형은 아니나 일관 null) |
| **S4** ≥75yo prasugrel | 🟡 (TRITON HR 1.36 net harm) | 3 (FDA label 명시) |
| **S7** 장기 무선별 DAPT | 🟡 (HOST-EXAM HR 0.73 + 1m DAPT 무신호) | 4 (de-escalation 우월) |
| **S6** routine PFT | 🟡/⚪ (AUC 0.80 plateau · RCT 0건) | 5 (over-testing — selective 잔존) |

---

## §4. 정직성 — 전면금지(absolute) 아닌 routine 철회 + bailout 잔여 적응증 (d6 · d2)

> ★ **핵심 정직성 (d6)**: 본 X20 의 모든 "제거"는 **routine(무선별·일상적) 적용의 철회**이지 **전면금지(absolute contraindication)가 아니다.** 각 항목은 명확한 bailout / sub-population 잔여 적응증을 보유한다 (d2 — 잔여 적응증 명명, 포기 0건). "제거 = 그 도구를 영원히 버려라"가 아니라 "기본값(default)을 '하지 않음'으로 전환하고, 명시적 trigger 에서만 사용하라".

| # | 제거 대상 | routine 철회 (default = NO) | ★ bailout / 잔여 적응증 (여기선 유지 · d2) |
|---|---|---|---|
| **S1** | routine aspiration thrombectomy | 무선별 STEMI thrombectomy 철회 | ★ **high thrombus burden (TIMI thrombus grade ≥4) bailout only** — large thrombus 에서 distal flow 회복 목적 선택적 사용 (M4 §4.1 VERBATIM) |
| **S2** | native coronary DPD | native coronary routine 철회 | ★ **SVG (saphenous vein graft) PCI 에서 Class I 유지** — SAFER MACE 9.6% vs 16.5% (p=0.004). native ≠ SVG 명확 분리 (M4 §4.2) |
| **S3** | universal ticagrelor | genotype-무관 universal 사용 철회 | ★ **PM × HBR-low cell 에서 옵션 잔존** (M7 결정맵) · dyspnea 시 clopi switch (Kim 2024). 전면금지 아님 — 출혈저위험 PM 에선 ST↓ 이득 |
| **S4** | ≥75세 prasugrel 서구dose | 고령 prasugrel routine 철회 (clopi 강제) | ★ **<75세 + 한국 5mg 저용량 dose 는 IM/PM 에서 유지** (M12). 고령 routine 만 철회 — 연령 미만 + 저용량은 출혈 가드 하 적응증 |
| **S5** | mPTP IV bolus acute 보호 | IV bolus / acute SGLT2i·colchicine MACE 목적 철회 | ★ **IC + reperfusion-synced delivery 는 별개 살아있는 가설** (X9 N1 path A · Δ36.6pp 🟢 정량). SGLT2i/colchicine 의 **만성 적응증(HF·항염)은 별개**로 제거 대상 아님 — acute MACE 가설만 🔴 |
| **S6** | routine universal PFT | 전수 무선별 PFT 철회 | ★ **환경변수(PPI 병용·신부전·복약 비순응) 의심 시 selective PFT 잔존** (H3). genotype 이 불확실한 특정 임상 상황의 보조 도구 |
| **S7** | 무선별 장기(>12mo) 강력 DAPT | 출혈위험 무관 일률 연장 철회 | ★ **LST/VLST 고위험(복잡 PCI·BRS·다혈관)은 연장 유지** (ISR M7) · HBR-HIGH 는 오히려 3-6mo 단축. 위험층화로 기간 개별화 — 일률 제거 아님 |

```
   전면금지(absolute) ❌    vs    routine 철회 + bailout 유지 ✅ (X20 채택)
─────────────────────────────────────────────────────────────────────────
   ❌ "thrombectomy 금지"            ✅ default NO · high thrombus burden bailout
   ❌ "DPD 폐기"                     ✅ native NO · SVG Class I 유지
   ❌ "ticagrelor 금지"              ✅ universal NO · PM×HBR-low 옵션
   ❌ "prasugrel 금지"               ✅ ≥75 NO · <75 한국5mg 유지
   ❌ "mPTP 연구 종료"               ✅ IV-acute NO · IC-sync 가설 살아있음 (d2)
─────────────────────────────────────────────────────────────────────────
   d6 정직: "less-is-more" ≠ "none-is-best". 제거는 default 전환이지 도구 폐기가 아니다.
   d2 준수: 모든 제거 항목에 잔여 적응증 path 명명 — "쓸 데가 없다" 식 닫음 0건.
```

> §4 종합: de-implementation 의 정직성은 **"무선별 default 를 NO 로 전환하되 명시적 trigger 에서만 사용"** — 전면금지(absolute contraindication)와 명확히 구분된다. S1(high thrombus bailout) · S2(SVG Class I) · S5(IC-sync 가설 + 만성 적응증)는 특히 "제거가 곧 폐기"로 오해되기 쉬운 항목으로, 잔여 적응증을 verbatim 으로 분리 보존했다 (d2 — 포기 0건 · d6 — over-subtraction 방지).

---

## §5. g5 grade — X20 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §0 de-implementation 근거 위계 | 🟡 | X8 §5 (🔴) + M4 §4 (null) + X16 (harm) 위계 carry (compositional) |
| §1 제거 대상 표 (7건) | 🟡 SUPPORTED-BY-CITATION (compositional) | 🔴/null/빈도 = X8 ledger / NOREFLOW M4 / X16 VERBATIM (TASTE 7244 · TOTAL stroke 0.7/0.3 · EMERALD 501 · TICAKOREA HR 2.26 · TRITON HR 1.36 · HOST-EXAM HR 0.73) |
| §2 빼기 vs 더하기 ASCII | 🟡 | X5/X11 더하기 ↔ X20 빼기 매핑 (compositional) |
| §3 근거 grade 분포 | 🟡 | §1 근거 grade 의 §0 위계 재정렬 (X8/sub-V VERBATIM) |
| §4 routine 철회 vs 전면금지 (bailout) | 🟡 | M4 §4 bailout (high thrombus · SVG) + X9 N1 (IC-sync) + M7 결정맵 잔여 적응증 VERBATIM |

**X20 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — 4 sub-domain 🔴/null/harm verdict + X8 ledger + NOREFLOW M4 의 **de-implementation 카탈로그 통합**. **X20 새 판정 0건** (per @D g5 · LLM self-judge 0건). 제거 근거(🔴/null/빈도)는 전부 X8 §5 / M4 §4 / X16 §1-§2 의 verbatim 인용 · 🔴 4 RCT null 은 효능 닫힌 음성(X8 §5 F1-F4)으로 제거 정당화 · large RCT null(TASTE/TOTAL/EMERALD)은 M4 §4 VERBATIM · 한국 harm 신호(TICAKOREA/TRITON)는 X16 VERBATIM. **d6 정직 — 전면금지(absolute) vs routine철회 명확 구분 (§4)** · **d2 — 모든 제거 항목에 bailout/잔여 적응증 path 명명 (포기 0건)** · "의사결정 지원, 처방·중단 명령 아님" 톤 · completed-form(d1).

---

## §6. X20 산출 요약

- **제거 대상 7건 (de-implementation 카탈로그)**:
  - **S1** routine aspiration thrombectomy — TASTE n=7,244 + TOTAL n=10,732 **null + stroke↑(0.7% vs 0.3%)** → Class III (M4 §4.1)
  - **S2** native coronary DPD — EMERALD n=501 **null** → SVG Class I 만 유지 (M4 §4.2)
  - **S3** universal ticagrelor — TICAKOREA major bleed **2배(HR 2.26)** + dyspnea ~14% (X16 §1.2)
  - **S4** ≥75세 prasugrel 서구dose — TRITON **net harm HR 1.36** · FDA "generally not recommended" (X16)
  - **S5** mPTP IV bolus acute 보호 — 🔴 FALSIFIED ×4 (X8 §5 F1-F4: SGLT2i/colchicine/nicorandil/CsA RCT null)
  - **S6** routine universal PFT — AUC **0.80 plateau** · RCT 0건 over-testing (X9 D5)
  - **S7** 무선별 장기 DAPT — HOST-EXAM clopi 단독 **HR 0.73** + 1m DAPT LST 무신호 (DAPTPGX/ISR M7)
- **제거 1순위** = **S5 mPTP IV bolus** (근거 강도 1위 — 🔴 FALSIFIED ×4 closed negative, 효능 가설 자체가 falsify). 단 임상 실시 빈도 기준 1순위 = **S1 routine thrombectomy** (Class III, 대형 RCT 2건 null + stroke harm).
- **harm 가장 크게 주는 제거** = **S3 universal ticagrelor** — 한국인 major bleeding 2배(TICAKOREA HR 2.26) + dyspnea ~14% + 서맥. 제거(genotype-guided)가 한국 최대 약물 안전 신호를 직접 차단.
- **빼기 vs 더하기**: 단일 stratification 패널(CYP2C19 PCR ₩50,000 NHIS)이 "더할 환자 선별"과 "무선별 routine 제거"를 동시 수행 — less-is-more.
- **g5/d6/d2 준수**: 🔴/null/빈도 X8/M4/X16 VERBATIM · 새 판정 0건 · **전면금지 아닌 routine철회 명시(§4)** · 모든 항목 bailout 잔여 적응증 명명(S1 high thrombus · S2 SVG · S5 IC-sync) · 처방 아님 톤.

---

> ⚠ **하단 DISCLAIMER (반복)**: 본 문서는 의사결정 지원 자료이며 처방·진단·중단 명령이 아니다. "제거(de-implement)"는 모두 routine(무선별) 적용의 철회이며 전면금지(absolute contraindication)가 아니다 — 각 항목은 bailout/sub-population 잔여 적응증을 보유한다(§4). 🔴/null/빈도·근거 등급(g5)은 CARDIO+ sub-domain verify verdict / X8 ledger / NOREFLOW M4 의 verbatim 인용이며, 모든 약제·검사·중재 제거 결정은 전적으로 담당 의료진의 환자별 판단이다. 환자는 항혈소판제를 임의 중단·변경하지 말 것(스텐트 혈전증 위험).
