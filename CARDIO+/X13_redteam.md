# X13 — CARDIO+ red-team falsification (적대적 검정 · devil's advocate)

> CARDIO+ 메타도메인 X13 산출물 · current-state · no history.
> 목적 = 가장 강한 claim 들을 **적극적으로 깨려고** 시도 — 각 claim 에 대해 최강 반박(steelman the null)을 구성하고 현 근거가 살아남는지 검정해 thesis robustness 를 stress-test 하고 숨은 🔴 후보를 정직하게 표면화한다.
> ⚠ 본 X13 = **적대적 검정 only** — 새 hexa verify / sim / atlas / pool / cloud / python 실행 0건 · git 0건 · X13 외 파일 수정 0건. 입력 = X8 / X1 / X4 / X9 / X7 + X2 / X3 read-only 인용.
> **g5 절대 준수**: 기존 grade 는 X8 ledger VERBATIM 인용 · **X13 agent 가 grade 를 변경·부여 0건** — "취약성 flag" 만 (실제 강등은 hexa verify 재실행 소관). **d6 정직**: 진짜 약점을 숨기지 않되 근거 없는 공격으로 과장 falsify 도 금지. **d2**: weakened / 🔴-후보 claim 마다 보강 path(어떤 측정이 구원하나) 동반.

---

## §0. 방법론 — steelman-the-null (귀무가설 최강화)

red-team 의 핵심 절차 = 각 claim 에 대해 **반대 측(null hypothesis)을 가능한 한 강하게 세운다**. straw-man (약한 반박) 이 아니라 steelman (반박을 최대한 설득력 있게) — 그래야 현 근거가 진짜로 살아남는지 검정된다.

### 0.1 검정 절차 (claim 1개당)

```
claim
  │
  ▼ ① 현 grade 확인 (X8 VERBATIM · 변경 금지)
  │
  ▼ ② steelman null 구성 — "이 claim 이 틀렸다면, 가장 그럴듯한 이유는?"
  │     (model 가정 약점 · 순환논증 · 외삽 비약 · 대안 설명 · 분모 문제)
  │
  ▼ ③ 반증에 필요한 증거 — "null 이 맞다면 무엇이 관측되어야 하나?"
  │     (어떤 측정/데이터가 도착하면 claim 이 깨지나)
  │
  ▼ ④ 생존 판정 (3-state)
        survives    = null 이 현 근거를 못 깸 (grade 정당)
        weakened    = null 이 일부 유효 — 근거는 살지만 범위 축소 필요 (flag)
        🔴-flip 후보 = null 이 강력 — 추가 측정 없이는 🔴 위험 (flag, but grade 변경 X)
```

### 0.2 g5 안전장치 (grade 변경 금지)

- 본 X13 의 "🔴-flip 후보" 는 **취약성 flag** 일 뿐 — 실제 🔴 강등은 `hexa verify` 재실행이 deterministic disagreement 를 산출해야만 가능 (rubric VERBATIM: "calc DETERMINISTICALLY disagrees"). X13 은 LLM self-judge 로 grade 를 내리지 않는다.
- "grade" 열 = X8 / 4-sub V4 VERBATIM. "생존" 열 = X13 적대검정 결과 (grade 아님).
- d6 양방향 정직: (a) 진짜 약점 은닉 금지 · (b) 근거 없는 공격으로 과장 falsify 금지 (예: 외부 RCT null 이 없는데 "🔴" 부르지 않음).

### 0.3 검정 대상 8개 claim (task 지정 + 파생)

| # | claim | 출처 | 현 grade (X8 VERBATIM) |
|---|---|---|---|
| **R-T** | **thesis**: mPTP = mis-delivered (전달 falsify, 약물 falsify 아님) | X7 Thesis · NOREFLOW N1 | (compositional — 구성 claim grade 로 검정) |
| **R1** | IC-sync ODE Δ36.6pp (CIRCUS 93.5% → IC-sync 56.9% cell death) | X3 §2.1 V3.2 · NOREFLOW V3 | 🟢 SUPPORTED-NUMERICAL |
| **R2** | DAPTPGX PM 0.1521 (IM+PM 0.6279) | X3 §2.2 · DAPTPGX V3 | 🟢 SUPPORTED-NUMERICAL |
| **R3** | LPA MR/IVW β -0.3413 (인과 확정) | X3 §2.3 · LPA V3b | 🟢 SUPPORTED-NUMERICAL |
| **R4** | 3-axis leverage (ALDH2*2 × CYP2C19 × Lp(a) 채혈 1회 6 wall 동시) | X9 §5 · X7 ◆ | 🟡 (X9 §5) · 채혈부 🟡 + 시너지부 ⚪(prognostic) |
| **R5** | IC delivery 가 4 RCT null 의 원인 (IV lag → 5분 lethal window 미도달) | NOREFLOW N1 · X7 NOREFLOW 행 | 🟢(ODE) 위 + 🔴 5(RCT null) 정직 carry |
| **R6** | 4 RCT null = 🔴 FALSIFIED (closed negative, wall 아님) | X8 §5 F1-F5 | 🔴 FALSIFIED |
| **R7** | DAPTPGX ICER S4 net-beneficial (ΔQALY +0.045 · v7 sign 반전) | X3 §3.1 | 🟢(방향성) · 🟠(절대값) |

---

## §1. claim별 red-team 표 (steelman null vs 현 근거)

| claim | 현 grade (X8 VERBATIM) | 최강 반박 (steelman null) | 반증에 필요한 증거 | 현 근거 생존? |
|---|---|---|---|---|
| **R1** IC-sync ODE Δ36.6pp | 🟢 SUPPORTED-NUMERICAL (V3.2) | **null-A (model-is-not-clinic)**: Δ36.6pp 는 *in-silico ODE 단일 결과*다. ODE 가 "delivery timing 이 cell-death 의 지배 변수" 라고 *가정* 한 뒤 timing 을 바꿨으니 Δ가 나오는 건 거의 동어반복 — 실제 4 RCT null 이 delivery 가 아닌 다른 이유(mPTP 가 minor death pathway)면 Δ36.6pp 는 in-vivo 에서 0 에 가까울 수 있다. **null-B (param-tuned)**: Hill 0.998 saturation + CIRCUS 93.5% anchoring 은 lit-fit param 으로, IC-sync 56.9% 는 그 param 에 종속 — sensitivity 폭이 미공개면 Δ는 단일 point estimate. | (1) IC-sync delivery device 의 **in-vivo infarct-size RCT** (CMR salvage index) — Δ가 임상에서 재현되나. (2) ODE param 의 **full sensitivity sweep** (Hill n, Ca threshold, lethal-window τ) → Δ 의 CI. (3) mPTP 차단의 **cell-death fraction attribution** (다축 대비 mPTP 단독 기여 %). | **survives (numerical) · weakened (clinical 외삽)** — 🟢 는 "ODE recompute 재현" 으로 정당 (X3 mini 재현 0.998 match). 그러나 "delivery 가 4 RCT null 의 원인" 으로 **외삽** 하는 순간 ⚪-성격(X4 NRF-F4 류). 🟢 자체는 살아남으나 **clinical claim 으로 over-read 금지 flag**. |
| **R2** DAPTPGX PM 0.1521 | 🟢 SUPPORTED-NUMERICAL | **null-A (순환 항등식)**: PM 0.1521 = Hardy-Weinberg `(allele freq)²` partition. 입력 allele freq (*2/*3 빈도) 자체가 cited literature 값이면, 출력 PM 은 *입력의 결정론적 재배열* — 새 정보 0, "검증" 이 아니라 "산술 확인". null 은 "PM 0.1521 은 독립 측정이 아니라 cited allele freq 의 closed-form 변환일 뿐". **null-B (cohort 특이성)**: 0.1521 vs cited 0.14-0.15 는 within-tolerance 지만, 한국 cohort (KAMIR vs KoGES vs 지역) 간 allele freq 변동이 ±tolerance 를 초과하면 단일 0.1521 은 대표성 약화. | (1) **독립 한국 cohort genotyping** (KOVA/KORV1K)에서 PM 빈도 직접 카운트 → HW 예측과 일치하나 (HWE 검정). (2) cohort 간 allele freq **이질성 (heterogeneity I²)** — 0.1521 이 pooled 인지 단일 cohort 인지. | **survives** — 🟢 는 "HW closed-form partition recompute + cited 0.14-0.15 within tolerance" 로 정당 (X3 mini 재현). null-A 는 "🟢 가 새 발견이 아니라 항등식 확인" 을 지적하지만 그게 바로 🟢 의 정의(numerical recompute)이지 falsification 아님. **단 'PM=독립측정' 으로 over-claim 시 weakened** — 본질은 cited freq 의 deterministic 변환임을 flag. |
| **R3** LPA β -0.3413 (인과) | 🟢 SUPPORTED-NUMERICAL (V3b) | **null-A (재현 ≠ 독립검증)**: β -0.34134 는 Burgess 2018 의 -0.34249 를 Δ0.00115 로 *재현* — 같은 summary stats 를 같은 IVW 공식에 넣었으니 일치는 당연. null = "독립 데이터로 인과를 재확인한 게 아니라 Burgess 의 계산을 복제한 것". **null-B (MR 가정 미검증)**: IVW 인과 해석은 (i) relevance (ii) independence (iii) exclusion-restriction(no pleiotropy) 3가정에 의존. MR-Egger z=-1.494 (p≈0.135) 는 *directional* pleiotropy 만 배제 — **balanced/correlated pleiotropy** 는 Egger 로 안 잡힌다. exclusion-restriction 은 summary stats 만으로 **원리상 검증 불가**. | (1) **독립 GWAS sample** (한국 KoGES Lp(a))로 IVW 재추정 → β 재현되나 (replication ≠ reproduction). (2) **correlated pleiotropy 검정** (CAUSE, MR-PRESSO global) — Egger 가 못 잡는 축. (3) **RCT confirmation** (pelacarsen HORIZON 2026 H1) — Lp(a) 낮춤이 실제 MACE 낮추나 (MR 인과의 ground truth). | **survives (numerical) · weakened (인과 라벨)** — 🟢 는 "IVW + Egger + WM/LOO robustness 재현" 으로 정당 (X3 verbatim, 5 robustness 통과). 그러나 **"인과 확정" (X7) 은 over-claim** — MR 은 *관찰적 인과 추론* 으로 RCT 가 아니다. exclusion-restriction 미검증 + correlated pleiotropy 미검정 → **"인과 확정" → "인과 강력 시사" 로 범위 축소 flag**. HORIZON readout 이 ground-truth gate. |
| **R4** 3-axis leverage | 🟡 (X9 §5 채혈부) + ⚪ (시너지 prognostic) | **null-A (joint prob 미계산)**: "한 환자가 ALDH2*2(40%)×CYP2C19 LoF(60%)×Lp(a) high(12-13%) 를 동시에" — 세 축이 **독립이면** joint ≈ 0.40×0.60×0.13 ≈ **3.1%** (한 자릿수)다. X7 은 "비-동아시아 대비 현저히 높음" 이라 했지만 **joint probability 를 명시 계산하지 않았다**. 세 축이 독립이면 triple-positive 는 소수파 — "단일 leverage 수렴" 의 임상 분모가 작다. **null-B (wall-count = leverage 아님)**: "6 wall 동시 stratify" 는 *측정 가능성* 이지 *효과* 가 아니다. 채혈 1회로 6축을 *재는* 것과 그 stratification 이 *outcome 을 개선* 하는 것은 별개 — 후자는 RCT 0건. | (1) **joint genotype prevalence 직접 계산** (한국 cohort 에서 triple-positive %, LD/correlation 보정). (2) **stratification → outcome RCT** (3-axis enriched arm vs unstratified) — stratify 가 MACE 낮추나. | **weakened** — 채혈부 🟡(측정 가능성)는 살아남음 (CYP2C19 PCR 급여 + Lp(a) routine = 사실). 그러나 "leverage 수렴" 의 **임상 크기(joint prob)가 미계산** + outcome 개선은 ⚪(prognostic, X4 CXF-2 "한국 first-in-class 기회" 최대 over-claim 후보와 동형). **flag: joint prob 명시 + stratification→outcome 분리 필요**. |
| **R5** IC delivery = 4 RCT null 의 원인 | 🟢(ODE) + 🔴 5(RCT null) carry | **null-A (대안 설명: drug-is-dead)**: 4 RCT null 의 가장 단순(parsimonious) 설명은 "delivery 실패" 가 아니라 "mPTP 차단이 인간 IRI 에서 임상 효과 없음" 이다. delivery-failure 가설은 *동일 데이터* 에 대한 더 복잡한 설명 — Occam 상 null(drug-dead)이 우선. **null-B (반증 불가 구조)**: "IV 는 lag 때문에 실패, IC-sync 면 성공" 은 IC-sync RCT 가 없으면 **반증 불가능한 보호가설**(unfalsifiable rescue) — 모든 null 을 "delivery 탓" 으로 돌리면 falsify 자체가 차단된다. | (1) **IC-sync delivery RCT** — 이게 유일한 결정적 증거. positive → mis-delivered 입증 · null → drug-dead 확정 (🔴). (2) **MITOCARE/EMBRACE 의 IC arm 재분석** (있다면) — IV vs IC 직접 비교. (3) mPTP open-probability 의 **human ex-vivo 측정** (재관류 timing 별). | **🔴-flip 후보 (thesis 핵심)** — 현재 "mis-delivered" 는 **ODE(🟢)로 가능성만 정량, 임상 증거 0**. drug-dead null 이 더 parsimonious 하고 IC-sync RCT 없이는 반증 불가 구조. d6 정직: 이건 thesis 의 가장 약한 고리. **단 grade 변경 X** — 🔴 가 되려면 IC-sync RCT 가 null 이어야 함 (아직 미실시 = 현재는 🟠/⚪ 영역의 가설). **보강: IC-sync delivery device IIT 가 유일 구원 path**. |
| **R6** 4 RCT null = 🔴 FALSIFIED | 🔴 FALSIFIED (F1-F5) | **null (역설적 red-team)**: 🔴 자체를 공격 — "4 RCT 가 *delivery 가 잘못된* 약을 쟀다면, 🔴 는 'mPTP 가설' 이 아니라 'IV-bolus mPTP 가설' 만 falsify 한 것". 즉 🔴 의 *범위* 가 과대 — thesis(R5)와 정합하려면 🔴 는 "IV delivery 가설" 에 한정돼야지 "mPTP 표적" 전체를 닫으면 안 됨. (이건 claim 을 *깨는* 게 아니라 🔴 의 *scope* 를 정밀화). | (참고) 🔴 의 scope 명시 — F1-F5 가 falsify 한 것은 정확히 "해당 RCT 의 primary endpoint (IV/PO acute MACE)" 이지 "표적 분자 전체" 아님. | **survives (정밀화)** — 🔴 5 는 RCT primary endpoint deterministic disagreement 로 정당 (X8 §5 VERBATIM). red-team 결과 = 🔴 는 유지하되 **scope 라벨을 "IV-bolus / acute-MACE 가설" 로 명시** (이미 X9 §9 가 "wall 아닌 closed negative" 로 분리). R5 와의 긴장은 정직하게 노출 — 🔴(IV 가설 죽음)와 🟢(IC-sync 가능성)는 *논리적으로 공존 가능* 하나, 둘 다 같은 분자라 over-coupling 위험 flag. |
| **R7** ICER S4 net-beneficial | 🟢(방향성) · 🟠(절대값) | **null-A (FIX 가 결과를 만들었다)**: v7 의 ΔQALY sign 반전(+0.045)은 FIX-A(IM+PM escalate) + FIX-B(S1 IM ST 보정) **2개 수동 patch 후** 나왔다. null = "sign 반전은 strategy 재정의로 *유도* — 같은 데이터에 다른 가정을 넣어 원하는 부호를 얻은 것". v6 까지 음수였던 게 v7 양수 = model 강건성 약함의 증거(가정 민감). **null-B (절대값이 thesis 무효화)**: +161 M KRW/QALY 는 WTP 30 의 5배 + cited +34 의 5배 — "net-beneficial" 의 *방향* 은 맞아도 *경제성* 은 fail. "PGx targeting 이 이득" 의 비용 효율 주장은 절대값에서 무너짐. | (1) **drug-cost 재모델** (prasugrel 5mg 한국 저가 first-line) → +161 이 WTP 안으로 들어오나. (2) **probabilistic sensitivity (PSA)** — sign 반전이 param 범위 전반에서 robust 한가, 아니면 FIX 가정 의존인가. (3) **DAPT-PGx-K cohort 실측 outcome**. | **weakened** — 방향성 🟢 는 "v7 mini 재현 sign 반전" 으로 정당하나, **2 FIX 가정 의존** 이라 강건성 약함 (X3 §3.1 가 이미 honest 명시). 절대값 🟠 는 "WTP 5배 초과" 로 경제성 주장 무력. **flag: sign 반전을 'PGx 이득 입증' 으로 읽으면 over-claim** — 방향만 확보, 경제성은 drug-cost 재모델 대기 (d6 준수로 +34 억지 안 쫓음, X3 명시). |

---

## §2. thesis stress-test — "mPTP = mis-delivered" 가 틀렸을 시나리오

thesis (X7): *"mPTP 는 죽은 표적이 아니라 mis-delivered — IV bolus 4 RCT null 은 약물 falsify 가 아니라 전달 falsify (IC-sync ODE Δ36.6pp)."* 이 thesis 가 **틀렸을** 가장 강한 시나리오 3개를 세우고, 우리 정량(Δ36.6pp)이 버티는지 검정한다.

### 2.1 시나리오 S1 — "drug-is-dead" (mPTP 가 인간 IRI 의 minor pathway)

```
steelman null:
  4 RCT (CIRCUS·CYCLE·EMBRACE·MITOCARE) null 의 가장 단순한 설명 =
  "mPTP 차단이 인간 재관류 손상의 cell-death 를 의미있게 줄이지 못한다"
  (다축 cell-death — ferroptosis·necroptosis·STING — 중 mPTP 는 minor).
  delivery-failure 가설은 동일 데이터에 대한 더 복잡한(가정 추가) 설명.

Δ36.6pp 가 버티나?
  ✖ 부분 실패. Δ36.6pp 는 ODE 가 "mPTP open prob → cell death" 를 지배
    경로로 *가정* 한 위에서 나온 값. S1 (mPTP=minor) 이 참이면 ODE 의
    cell-death-attribution 자체가 과대 — Δ36.6pp 의 분모(mPTP 기여분)가
    틀린 것이라 in-vivo Δ ≪ 36.6pp.
  → Δ36.6pp 는 "IF mPTP 가 지배경로" 라는 조건부 진실. 무조건부 아님.

구원 측정: mPTP 단독 cell-death fraction attribution (다축 대비 %) — 
  NOREFLOW 도메인이 이미 "다축 cell-death (STING-GPX4 ferroptosis)" 를
  N1 path C 로 인정 (X9 §1) → mPTP-minor 가능성을 도메인 스스로 carry.
```

### 2.2 시나리오 S2 — "delivery 도 했는데 똑같다" (IC arm 도 null)

```
steelman null:
  일부 mPTP trial (예 일부 IC adenosine/CsA 연구) 은 IC 투여를 했음에도
  무효였다. IC-sync 가 정말 결정적이면 기존 IC arm 이 positive 였어야.
  "IC-sync 면 다르다" 는 IV→IC 차이를 timing(sync)으로 또 좁히는
  연쇄 보호가설.

Δ36.6pp 가 버티나?
  ✖ 직접 위협. Δ36.6pp 는 "IV lag (300s) vs IC-sync (3s) tmax" 차이를
    cell-death 차이로 변환한 것. 만약 IC(비-sync) arm 이 이미 null 이면
    tmax 3s 가정 자체가 임상에서 안 먹힌다는 뜻 → Δ 의 전제 붕괴.

구원 측정: 기존 IC-route mPTP trial 의 체계적 재검토 (IC 했는데 왜 null?
  sync 안 됐나 vs sync 했는데 null 인가) + arm-to-heart lag 의 human
  실측 (NOREFLOW M4 Cmax ratio model 536× vs cited 30-100× 의 magnitude
  mismatch (X3 §2.1 🟡) 가 이미 이 전제의 불확실성을 flag).
```

### 2.3 시나리오 S3 — "ODE 가 과낙관 (param-fit artifact)"

```
steelman null:
  IRI ODE 가 CIRCUS 93.5% 를 anchor 로 fit 됐고 IC-sync 56.9% 는
  그 fit 의 외삽. Hill n·Ca threshold·lethal-window τ 를 다르게 잡으면
  Δ 가 36.6pp 가 아니라 5pp 일 수도, 60pp 일 수도. 단일 point estimate
  를 "Δ36.6pp" 로 제시 = 과낙관.

Δ36.6pp 가 버티나?
  △ 부분 생존. X3 §2.1 은 V3.3 MC robustness (adenosine IC/nicorandil
    100% Tier-A) 를 🟢 로 carry — 즉 *robustness 검정은 했다*. 그러나
    그건 ranking robustness 지 Δ36.6pp 자체의 CI 는 미공개. point
    estimate 36.6pp 에 신뢰구간이 없는 게 약점.

구원 측정: Δ36.6pp 의 full param sensitivity sweep → Δ 의 90% CI.
  CI 하한이 0 을 안 넘으면 "delivery 가 cell-death 줄인다" 는 방향은 robust.
```

### 2.4 thesis 종합 — stress-test 통과 여부

```
┌─────────────────────────────────────────────────────────────────────────┐
│ thesis "mPTP = mis-delivered" stress-test 결과                            │
├─────────────────────────────────────────────────────────────────────────┤
│ S1 (drug-dead)        Δ36.6pp 부분실패 (조건부 진실 · mPTP=지배 가정 의존)  │
│ S2 (IC arm 도 null)   Δ36.6pp 직접위협 (tmax 3s 전제 붕괴 가능 · Cmax 🟡)  │
│ S3 (ODE 과낙관)        Δ36.6pp 부분생존 (방향 robust 추정 · 단 CI 미공개)    │
├─────────────────────────────────────────────────────────────────────────┤
│ 판정: thesis 는 ❌ "통과(survives)" 아님 → ⚠ "조건부 생존(qualified)"     │
│                                                                            │
│ · 정량(Δ36.6pp) 자체는 🟢 (ODE recompute 재현) — 산술은 buged 아님         │
│ · 그러나 "mis-delivered (전달 falsify, 약물 살아있음)" 라는 *인과 해석* 은 │
│   IC-sync 임상 RCT 가 0건이라 S1(drug-dead)을 배제하지 못함                │
│ · 현재 thesis 는 "약물이 죽지 않았을 *가능성* 을 ODE 가 정량" 까지가 정직   │
│   ("죽지 않았다 *확정*" 은 over-read — R5 🔴-flip 후보와 동형)             │
└─────────────────────────────────────────────────────────────────────────┘
```

**d6 정직 결론**: thesis 의 **정량 골격(Δ36.6pp)은 stress-test 에서 산술적으로 깨지지 않는다** (🟢 recompute). 그러나 thesis 의 **인과 주장("약물 falsify 아니다")은 stress-test 를 무조건적으로 통과하지 못한다** — S1(drug-dead)이라는 더 parsimonious 한 null 을 IC-sync RCT 없이는 배제 불가. thesis 는 **"단정" 이 아니라 "가설 + 정량적 그럴듯함(plausibility)"** 으로 읽혀야 한다. X7 의 thesis 문장이 "mis-delivered (IV bolus 4 RCT null 은 ... 전달 falsify)" 로 **단정형** 인 것이 가장 큰 over-claim 표면 — "전달 falsify *일 수 있음 (ODE Δ36.6pp 가 제시)*" 으로 hedged 형이 정직.

**보강 path (d2 — 무엇이 thesis 를 구원하나)**:
1. **IC-sync delivery device IIT** (NOREFLOW N1 path A) — 유일한 결정적 gate. positive → mis-delivered 입증(thesis 무조건 생존) · null → drug-dead 확정(thesis 🔴, 그러나 정직한 닫힘).
2. **mPTP cell-death attribution** (다축 대비 mPTP 단독 %) — S1 배제 또는 확인.
3. **Δ36.6pp full sensitivity CI** — S3 배제 (방향 robustness 정량).
4. **기존 IC-route mPTP trial 체계적 재검토** — S2 배제 (IC 했는데 null 인 사례 있나).

---

## §3. 숨은 🔴 후보 — 현재 🟢/🟡 인데 적대검정서 취약 (취약 flag only · grade 변경 X)

> ⚠ 본 §3 의 어느 항목도 **grade 를 바꾸지 않는다** — hexa verify 재실행 소관. "취약 flag" = "적대검정서 이 claim 이 가장 먼저 무너질 후보" 라는 정직한 표시. 실제 강등은 우측 "🔴 되는 조건" 의 측정이 도착해 deterministic disagreement 가 나와야만 가능.

| # | claim | 현 grade (X8 VERBATIM) | 취약 사유 (steelman) | 🔴 되는 조건 (이 측정이 disagree 하면) | 취약도 |
|---|---|---|---|---|---|
| **H1** | mis-delivered 인과 ("약물 살아있다") | 🟢(ODE) 위 인과 외삽 | IC-sync RCT 0건 · drug-dead null 이 더 parsimonious · 반증불가 구조 | **IC-sync delivery RCT 가 null** → "mis-delivered" 🔴 (drug-dead 확정) | ★★★ (최고) |
| **H2** | LPA β -0.3413 "인과 확정" | 🟢 SUPPORTED-NUMERICAL | 인과 라벨이 MR 가정(exclusion-restriction) 의존 · correlated pleiotropy 미검정 · "확정" 은 RCT 아님 | **HORIZON pelacarsen 이 Lp(a) -80% 인데 MACE 무효** → MR 인과 라벨 🔴 (β 산술은 🟢 유지) | ★★★ |
| **H3** | ICER S4 net-beneficial (방향성) | 🟢(방향) · 🟠(절대값) | sign 반전이 2 FIX 가정 의존 · v6 까지 음수 · PSA 미공개 | **PSA 에서 sign 반전이 param 범위서 robust 안 함** → 방향성 🟠/🔴 강등 | ★★☆ |
| **H4** | Cmax ratio (IC delivery 전제) | 🟡 (X3 §2.1 V3.7) | model 536× vs cited 30-100× — magnitude **17배** 차이 (direction match 만) · thesis 의 IC-sync 전제 토대 | **arm-to-heart lag human 실측이 30-100× 영역 확정** → model 536× 🔴 (단 이미 🟡, thesis 전제 약화) | ★★☆ |
| **H5** | IRI ODE 99.7% 류 sim 절대값 (cross-domain) | (ISR) 🟠/⚪ · (NOREFLOW) 🟢 | ISR PK ODE 99.7% vs lit 80-90% overshoot (X4 ISR-V3-PKODE) · Mg Tafel 6.27 vs lit 40× mismatch — sim 절대값이 lit 과 체계적 어긋남 | **kernel merge 후 재현해도 lit 과 40× 어긋남 지속** → sim 절대값 🔴 (단 X4 가 이미 ⚪ fence) | ★☆☆ (이미 fenced) |
| **H6** | DAPTPGX PM 0.1521 "독립 측정" 오독 | 🟢 SUPPORTED-NUMERICAL | HW closed-form = cited allele freq 의 deterministic 변환 (순환) · 독립 cohort 카운트 아님 | **독립 한국 cohort 가 HWE deviation 보임** → PM 예측 🔴 (산술 🟢 는 유지, 대표성만) | ★☆☆ (낮음 — HW 견고) |

**숨은 🔴 후보 우선순위 (취약도 순)**:
```
★★★  H1 mis-delivered 인과  ── thesis 핵심 · IC-sync RCT 가 유일 gate
★★★  H2 LPA "인과 확정"     ── HORIZON 2026 H1 readout 이 ground-truth gate
★★☆  H3 ICER 방향성         ── PSA 가 robustness gate
★★☆  H4 Cmax 536× vs 30-100× ── thesis IC-sync 전제의 정량 토대 (이미 🟡)
★☆☆  H5 sim 절대값 lit mismatch ── 이미 ⚪ fenced (X4)
★☆☆  H6 PM 독립측정 오독      ── HW 견고, 오독 위험만
```

**d6 정직 핵심**: H1·H2 는 둘 다 **"산술(🟢)은 견고하나 인과 라벨이 취약"** 한 동형 구조다 — Δ36.6pp 와 β -0.3413 모두 *recompute 는 정확* 하지만 *"mis-delivered" / "인과 확정"* 이라는 해석층이 외부 RCT(IC-sync / HORIZON)를 ground-truth 로 요구한다. 이게 CARDIO+ thesis 의 단일 최대 취약 패턴: **numerical verification 이 causal verification 으로 over-read** 되는 지점. (X4 §5.2 가 이미 "한국 first-in-class 기회" 를 최대 over-claim 으로 식별 — H1/H2 는 그것의 *정량 버전*.)

---

## §4. 생존 요약

### 4.1 8 claim 검정 분포

| 생존 판정 | claim | 수 |
|---|---|---:|
| **survives** | R2 (PM 0.1521 · HW 견고) · R6 (🔴 5 · scope 정밀화로 유지) | **2** |
| **weakened** | R1 (Δ36.6pp · clinical 외삽 약화) · R3 (β · 인과 라벨 축소) · R4 (3-axis · joint prob 미계산) · R7 (ICER · FIX 가정 의존) | **4** |
| **🔴-flip 후보** | R5 (IC delivery = null 원인 · drug-dead null 미배제) | **1** |
| **thesis (별도)** | R-T (조건부 생존 — 정량 🟢 · 인과 해석 stress-test 무조건 통과 못함) | 1 (qualified) |

```
📊 X13 red-team 생존 분포 (검정 claim 8개 = R1-R7 + thesis)
─────────────────────────────────────────────────────────────────────────
survives      ██████░░░░░░░░░░░░░░░░░░░░░   2   (R2 · R6)
weakened      ████████████░░░░░░░░░░░░░░░   4   (R1 · R3 · R4 · R7)
🔴-flip 후보   ███░░░░░░░░░░░░░░░░░░░░░░░░░   1   (R5)
thesis        ██░░░░░░░░░░░░░░░░░░░░░░░░░░   1   (qualified — 조건부 생존)
─────────────────────────────────────────────────────────────────────────
숨은 🔴 후보 (§3 flag): 6건 (H1★★★ · H2★★★ · H3★★☆ · H4★★☆ · H5★☆☆ · H6★☆☆)
─────────────────────────────────────────────────────────────────────────
```

### 4.2 핵심 발견 (d6 정직)

- **단일 최대 취약 패턴**: numerical (🟢) → causal (인과 확정) **over-read**. Δ36.6pp(R1) · β -0.3413(R3) 둘 다 *산술은 견고*, *인과 라벨은 외부 RCT(IC-sync / HORIZON) 를 ground-truth 로 요구*. weakened 4건 중 2건(R1·R3)이 이 패턴.
- **gradedown 0건**: 적대검정 결과 **어느 claim 도 현 X8 grade 를 내릴 deterministic disagreement 를 산출하지 않았다** — 모든 🟢 는 recompute 재현으로 정당. 취약성은 전부 *해석층(인과·외삽·절대값)* 에 있지 *산술층* 에 있지 않다. → grade 변경 0건 (g5 준수) 이 정직한 결과.
- **thesis 는 단정형이 over-claim**: "mis-delivered (전달 falsify)" → "mis-delivered *일 수 있음 (ODE Δ36.6pp 가 정량적 그럴듯함 제시)*" 으로 hedged 가 정직. 정량은 buged 아니나 인과 단정이 S1(drug-dead) 을 배제 못함.
- **🔴 5 (X8) 는 견고**: red-team 이 🔴 자체를 공격해도 (R6) scope 정밀화("IV-bolus / acute-MACE 가설" 한정) 로 유지 — RCT primary endpoint deterministic disagreement 는 의심 여지 없음.

### 4.3 보강 path 요약 (d2 — 어떤 측정이 구원하나)

| 취약 claim | 단일 구원 측정 (ground-truth gate) | 시점 |
|---|---|---|
| R5 / H1 (mis-delivered) | **IC-sync delivery device IIT** (positive → 입증 · null → 🔴 정직 닫힘) | 한국 cath lab consortium IIT |
| R3 / H2 (LPA 인과) | **HORIZON pelacarsen readout** (Lp(a)↓ → MACE↓ 면 MR 인과 확인) | 2026 H1 (X9 L1) |
| R1 / H4 (Δ36.6pp · Cmax) | **Δ full sensitivity CI** + **arm-to-heart lag human 실측** | sim 재실행 + device PK |
| R4 (3-axis) | **joint genotype prevalence 직접 계산** + stratification→outcome 분리 | KOVA/cohort |
| R7 / H3 (ICER) | **PSA + drug-cost 재모델** (prasugrel 5mg first-line) | DAPTPGX 세션 handoff |

---

## §5. g5 grade — X13 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §0 방법론 (steelman-the-null) | 🟡 | g5 rubric + d6/d2 거버넌스 carry · 절차 명시 |
| §1 claim별 red-team 표 | 🟡 (compositional) | 현 grade 는 X8/X3 VERBATIM 인용 · steelman 은 X13 적대 추론 (grade 부여 0건) |
| §2 thesis stress-test | ⚪ (적대적 declaration) | S1-S3 null 구성은 X13 가공 · Δ36.6pp grade 는 X3 VERBATIM |
| §3 숨은 🔴 후보 flag | ⚪ (취약 flag · grade 변경 0건) | 취약성 식별은 X13 가공 · 실제 🔴 은 hexa verify 소관 명시 |
| §4 생존 요약 | 🟡 (compositional) | §1-§3 산술 집계 · 보강 path 는 X9 leverage carry |

**X13 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — 현 grade 는 전부 X8/X3 verdict VERBATIM 인용, steelman null + 취약 flag 는 X13 적대 추론(⚪ 성격, grade 부여 아님). **X13 새 grade 판정 0건** (per @D g5 — 취약성 flag 만 · 실제 강등은 hexa verify 재실행 소관). d6 양방향 정직 준수 (진짜 약점 노출 + 과장 falsify 금지) · weakened/🔴-후보 마다 보강 path 동반 (d2) · completed-form (d1).

⚠ **honest 핵심**: red-team 의 결론은 "claim 들이 깨졌다" 가 아니라 **"산술층은 견고, 인과/해석층이 외부 RCT 를 ground-truth 로 요구한다"** 다. 이는 CARDIO+ 가 *정직하게* numerical verification 까지 갔고 causal verification 은 아직 (wet-lab/RCT downstream, d5 정합) 임을 재확인 — over-claim 차단이 X4 fence 와 본 X13 적대검정의 공통 역할.

---

## §6. X13 산출 요약

- **검정 claim 수**: 8 (R1-R7 + thesis R-T) · 숨은 🔴 후보 flag 6 (H1-H6)
- **생존 분포**: survives **2** (R2 PM·R6 🔴scope) · weakened **4** (R1 Δ36.6pp·R3 β·R4 3-axis·R7 ICER) · 🔴-flip 후보 **1** (R5 mis-delivered 인과) · thesis **qualified** (조건부 생존)
- **가장 취약한 claim**: **R5 / H1 — "mis-delivered (약물 살아있다)" 인과** (★★★) — drug-dead null 이 더 parsimonious + IC-sync RCT 0건 = 반증불가 구조. **보강 path = IC-sync delivery device IIT** (positive → 입증 · null → 🔴 정직 닫힘). 이게 thesis 의 단일 ground-truth gate.
- **thesis stress-test 통과 여부**: ❌ 무조건 통과 아님 → ⚠ **조건부 생존(qualified)**. 정량 골격(Δ36.6pp)은 산술적으로 안 깨짐(🟢 recompute) 이나, 인과 주장("전달 falsify")은 S1(drug-dead)이라는 더 단순한 null 을 IC-sync RCT 없이 배제 못함 → "단정" 이 over-claim, "가설+정량적 그럴듯함" 이 정직.
- **단일 최대 취약 패턴**: numerical(🟢) → causal(인과 확정) **over-read** — Δ36.6pp · β -0.3413 둘 다 산술 견고/인과 라벨 취약 (외부 RCT ground-truth 의존). H1·H2 동형.
- **g5 준수**: 현 grade 전부 X8/X3 VERBATIM · **X13 grade 부여·변경 0건** (취약 flag 만) · gradedown 0건 (deterministic disagreement 미산출 — 취약성은 해석층, 산술층 아님) · d6 양방향 정직 · d2 보강 path 동반 · 시뮬/pool/cloud/python/hexa verify/git 실행 0건.

→ **다음 단계**: 본 X13 = thesis robustness 의 적대적 audit. (1) R5/H1 보강 = IC-sync delivery IIT (X5 trial portfolio A 와 정합) · (2) H2 보강 = HORIZON 2026 H1 readout 추적 (X9 L1) · (3) X7 thesis 문장을 "mis-delivered" 단정 → "mis-delivered 일 수 있음 (ODE 정량)" hedged 로 정밀화 권고. 실제 grade 강등은 위 ground-truth 측정 도착 후 hexa verify 재실행 소관.
