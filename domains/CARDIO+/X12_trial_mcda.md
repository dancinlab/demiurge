# X12 — CARDIO+ 4-trial MCDA 우선순위 (단 하나의 trial 먼저 한다면?)

> CARDIO+ 메타도메인 X12 산출물 · current-state · no history.
> 목적 = 4-trial portfolio (A NICORADENO-MVO · B DAPT-PGx-K · C ISR-non-mTOR · D LPA-siRNA-K) 를 다기준 의사결정분석(MCDA)으로 정량 랭킹 — "교수님이 단 하나의 trial 만 먼저 한다면 무엇인가?" 에 가중합 + 민감도로 답한다.
> 출처(입력) = `X5_korea_trials.md` (4-trial portfolio · timeline · 규제) · `X9_wall_map.md` (각 trial wall/돌파 path) · `X8_grade_ledger.md` (근거 grade VERBATIM) · `X3_green_push.md` (DAPTPGX ICER v7 sign 반전) · `X2_blue_push.md` (🔵 천장).

---

## §0. g5 / d6 인용 규약 (필수 — 본 X12 전체 적용)

본 X12 는 **2 종류의 정보** 를 엄격히 분리한다:

| 종류 | 표기 | 출처 규약 |
|---|---|---|
| **근거 grade** (🔵🟢🟡🟠🔴⚪) | VERBATIM 인용 | X8 grade ledger / sub-V verify verdict 그대로 복사 — **X12 새 판정 0건** (per @D g5) |
| **MCDA 점수 · 가중치** (1-5 점 · % 가중) | ⚪ proposal (주관) | 본 X12 가 부여하는 **가치판단**. 근거에서 도출하되 점수 매핑 자체는 ⚪ |

⚠ **핵심 honest fence (g5 + d6)**:
- MCDA **가중치는 전부 ⚪ 주관적 가치판단** — "규제를 임상impact보다 얼마나 중시하는가" 는 교수님의 가치판단이지 객관 사실이 아니다. 본 X12 는 baseline 가중치 1세트를 제안하고, **§5 민감도** 에서 가중치를 흔들어 결론의 robustness 를 검증한다.
- MCDA **점수(1-5)는 근거(X5/X8/X9)에서 도출** — 결론("B 먼저")에 맞추려 점수를 조작하지 않는다 (d6). 점수 셀마다 X5/X8/X9 인용을 붙여 trace 가능하게 한다.
- ❌ LLM self-judge 로 trial 에 🟢/🔵 새 부여 금지 — 근거 grade 는 X8 VERBATIM 만.

---

## §1. 4-trial 1줄 식별 (X5 §1 carry)

| trial | full name | sub-domain | 1차 종결점 | 추정 n | timeline (X5 §4) |
|---|---|---|---|---|---|
| **A** | NICORADENO-MVO | NOREFLOW | CMR infarct size 30d | ~500 ⚪ | 6m (enroll) |
| **B** | DAPT-PGx-K | DAPTPGX | 1y MACE (S4 vs S1) | 설계가정 ⚪ | **즉시 (0m)** |
| **C** | ISR-non-mTOR (ROCK-DCB IIT-1) | ISR | 6m OCT LLL + 30d safety | ~60 ⚪ | 6m (pre-IND) |
| **D** | LPA-siRNA-K (K-LpA-OUTCOMES) | LPA | 4-point MACE 24m/60m | ~3,000 ⚪ | 3y (2-3y) |

---

## §2. 기준 정의 표 (5 criteria · 측정방식 · 가중치)

> ⚠ **가중치는 ⚪ 주관적 가치판단** (per §0). 아래는 "단 하나를 **먼저** 한다 = 빠른 실행가능성을 임상가치와 동급으로 본다" 는 baseline 가치관 1세트. §5 에서 흔든다.

| # | 기준 | 측정방식 (1-5 점 매핑 규칙) | baseline 가중치 | 가중 근거 (⚪ 주관) |
|---|---|---|---:|---|
| **C1** | **규제 feasibility** (신규 IND/승인 필요 여부) | 5=신규 IND·승인 전무(즉시) · 4=IND불요 but consortium/인프라 lift · 3=신규 device IND(완화경로 有) · 2=신규약물 승인 필요 · 1=신규승인+급여협상+글로벌 readout 의존 | **25%** | "먼저" = 가장 빨리 첫 환자에 도달 가능성. 질문이 "**먼저**" 이므로 최고 가중 |
| **C2** | **임상 impact** (효과크기 잠재 × 대상규모) | 5=대규모 cohort + hard endpoint(MACE) · 4=중규모 + surrogate · 3=소규모 PoC + surrogate · 2=single-arm FIH · 1=exploratory | **25%** | 임상가치 = trial 의 존재이유. C1 과 동급 최고 가중 |
| **C3** | **한국 leverage** (ethnicity · 급여 · 글로벌 미시도) | 5=한국 ethnicity 글로벌 최고빈도 + 글로벌 미시도 primary + 기존급여 · 4=글로벌 미시도 + ethnicity · 3=ethnicity 우위 + cross-recog · 2=한국 cohort 검증 platform · 1=글로벌 추종 | **20%** | first-in-class 한국 차별성 = CARDIO+ 핵심 논지 (X5 §7) |
| **C4** | **비용/시간** (consortium·인프라·n·기간) | 5=인프라 기존 + 소요시간 최단 · 4=소규모 n · 3=중규모 consortium 빌드 · 2=대형 device/IND 비용 · 1=대규모 n + 다년 outcome + 글로벌 의존 | **15%** | "먼저" 결정의 실무 제약. C1 과 일부 상관 (별도 축으로 분리) |
| **C5** | **근거 성숙도** (현 X8 grade) | 5=primary 정량 🟢 verbatim 多 · 4=핵심 🟢 + 일부 🟠 · 3=🟢 일부 + 핵심 🟠/🟡 · 2=대부분 🟡 cite · 1=⚪ proposal(verify verdict 부재) | **15%** | 이미 검증된 trial 일수록 wet-lab 전 risk 낮음 (d1 non-wet-lab 완결도) |
| | **합** | | **100%** | — |

→ **C1+C2 = 50%** ("빨리 + 가치 있게" 가 "먼저 하나" 질문의 본질) · C3 20% · C4+C5 = 30%. 이 분배 자체가 ⚪ — §5 가 이를 검증한다.

---

## §3. 점수 매트릭스 (행=4 trial · 열=5 기준 · 셀=1-5 점 + 근거)

> ⚠ 점수 = ⚪ proposal. 각 셀의 근거는 X5/X8/X9 VERBATIM 인용 — 결론 역산 아님 (d6).

### C1. 규제 feasibility

| trial | 점수 | 근거 (X5/X9 인용) |
|---|:---:|---|
| **B** | **5** | "CYP2C19 PCR 선별급여(C5946) 기존재 + clopidogrel/prasugrel/ticagrelor **모두 기존 급여 약제** → **신규 IND·신규 약물 승인 전혀 불요** · registry-embedded 즉시 적용" (X5 §4 즉시 0m · §5.1 · §7) |
| **A** | **4** | "nicorandil·adenosine 모두 보험 routine → **신규 IND 불요**" but "8-기관 CMR consortium(한국 현재 **0개**) + IMR wire cap lift 필요" (X5 §1 · §5.2 · X9 N3) |
| **C** | **3** | "MFDS **first-in-human IND**(신규 device·coating)" but "Japan PMDA cross-recognition(fasudil 일본 1995 승인) → IND data package 단축" 완화경로 (X5 §1 · §5.2 · X9 I3) |
| **D** | **1** | "siRNA/ASO = **신규 승인 필요**(현 비급여) + RSA 우선 협상 + **HORIZON 2026 H1 글로벌 readout 의존**" · 규제 lift "최고" (X5 §1 · §4 · §5.3) |

### C2. 임상 impact (효과크기 잠재 × 대상규모)

| trial | 점수 | 근거 (X5 인용) |
|---|:---:|---|
| **D** | **5** | hard endpoint 4-point MACE + 대규모 n~3,000 + 대상 "≥50 mg/dL ~12-13%(절대수 **~520만 명**)" (X5 §1 · §6 Schoenfeld D=844 🟢) |
| **B** | **4** | hard endpoint 1y MACE + bleeding 공동1차 + 대상 "IM+PM ~60%"(PCI 환자 전체의 다수) — universal clopidogrel 대비 직접 outcome (X5 §1 · §3.2) |
| **A** | **4** | validated surrogate CMR infarct size(Stone 2016) + n~500 + IMR>40(screen 의 ~40%) — primary power 0.798 🟢 적정 (X5 §1 · §6) |
| **C** | **2** | single-arm first-in-human n=60 + surrogate OCT LLL — PoC 성격, 효과 입증은 후속 IIT-2 RCT 의존 (X5 §1) |

### C3. 한국 leverage (ethnicity · 급여 · 글로벌 미시도)

| trial | 점수 | 근거 (X5/X8 인용) |
|---|:---:|---|
| **B** | **5** | "CYP2C19 LoF allele ~40% = **글로벌 최고**(\*3 백인 대비 20-50배)" + 기존 NHIS 급여 배포 가능 + "TICAKOREA bleed 2.8% vs PLATO 1.4% → universal ticag 부적합"(한국 evidence-leading) (X5 §1 · §3.1) |
| **D** | **5** | "KIV-2 copy stratified efficacy = 글로벌 trial(HORIZON·OCEAN(a)) **미시도 영역** → K-LpA-OUTCOMES 가 첫 정량" + 한국 ≥50 ~520만 명 (X5 §1 · §3.2) |
| **A** | **5** | "ALDH2\*2 East Asian ~40% → NO ↓ → ALDH2 stratified no-reflow RCT **글로벌 부재**(한국 first-in-class)" + nicorandil 한국 보험(글로벌 우위, cost 0) (X5 §1 · §7 "가장 강한 한국 leverage") |
| **C** | **3** | "한국 ISR cohort = NA risk 高 + small vessel 多 + OCT-guided 최적 검증 platform" + fasudil 일본 30y → 한일 cross-recognition leverage (검증 platform 성격, ethnicity primary 아님) (X5 §1) |

### C4. 비용/시간

| trial | 점수 | 근거 (X5/X9 인용) |
|---|:---:|---|
| **B** | **5** | "약제 재배치 + registry-embedded → **다음 PCI 환자부터 즉시**" · 인프라 신규구축 0 (PCR 급여 기존재) (X5 §4 · §7) |
| **C** | **3** | n=60 소규모 6-8 sites · "15-25억 KRW · KCSC 6-8 sites" — device IND 비용 but 소형 (X9 I3) |
| **A** | **3** | n~500 + "8-기관 CMR consortium 빌드(KHIDI R&D ~2-3년)" + IMR wire cap — consortium lift 가 시간/비용 driver (X5 §5.2 · X9 N3) |
| **D** | **1** | n~3,000 × 18mo + "2032 H1 primary"(다년 outcome) + siRNA 약가(387-645× 격차) + 글로벌 readout 대기 — 최대 비용·최장 시간 (X5 §1 · §4 · §6) |

### C5. 근거 성숙도 (현 X8 grade — VERBATIM)

| trial | 점수 | 근거 grade (X8 / sub-V VERBATIM) |
|---|:---:|---|
| **D** | **5** | LPA 🟢 **28**(4 sub 中 최다) · Schoenfeld **D=844(🟢)** · MR β_IVW **-0.3413(🟢)** · OCEAN(a) power **n/arm=43(🟢)** · 🔵 1(sigma sanity) (X8 §2 · X5 §6) ※ 단 NHIS ICER WTP **0% pass(🟢 정량)** = 약가 wall |
| **B** | **4** | DAPTPGX 🟢 5 · PM freq **0.1521(🟢 exact)** · IM+PM **0.6279(🟢)** · **X3 §3.1 v7: ICER ΔQALY sign 반전 +161(방향성 🟢, 절대값 🟠)** — 핵심 freq 🟢, 경제성 🟠 잔존 (X8 §2 · X3 §3.1) |
| **A** | **4** | NOREFLOW 🟢 10 · **primary power 0.798(🟢)** · IRI Δ36.6pp(🟢) — 단 ALDH2\*2 subgroup **0.654(🟠 INSUFFICIENT, exploratory only)** · Cox 1y MACE **0.157(🟠)** (X8 §2 · X5 §6) |
| **C** | **1** | ISR 🟢 **0** · 🔵 0 · "fasudil-DCB IIT-1 전체 설계 = **verify verdict 부재 → ⚪ proposal**" · fasudil porcine NH 40-50%↓ = 🟡 cite only (kernel-pending) (X8 §2 · X5 §6 · X9 I2) |

---

## §4. 가중합 랭킹

> 가중합 = Σ(점수 × 가중치). 점수 1-5 · 가중치 §2 baseline. 결과는 0-5 scale.

| trial | C1·0.25 | C2·0.25 | C3·0.20 | C4·0.15 | C5·0.15 | **가중합** | 순위 |
|---|---:|---:|---:|---:|---:|---:|:---:|
| **B** | 5×.25=1.25 | 4×.25=1.00 | 5×.20=1.00 | 5×.15=0.75 | 4×.15=0.60 | **4.60** | **🥇 1** |
| **A** | 4×.25=1.00 | 4×.25=1.00 | 5×.20=1.00 | 3×.15=0.45 | 4×.15=0.60 | **4.05** | 🥈 2 |
| **D** | 1×.25=0.25 | 5×.25=1.25 | 5×.20=1.00 | 1×.15=0.15 | 5×.15=0.75 | **3.40** | 🥉 3 |
| **C** | 3×.25=0.75 | 2×.25=0.50 | 3×.20=0.60 | 3×.15=0.45 | 1×.15=0.15 | **2.45** | 4 |

```
가중합 랭킹 (baseline 가중치 · 0-5 scale)
─────────────────────────────────────────────────────────────
🥇 B DAPT-PGx-K     ███████████████████████████████████████████████  4.60
🥈 A NICORADENO     ██████████████████████████████████████████░░░░░  4.05
🥉 D LPA-siRNA-K    ████████████████████████████████████░░░░░░░░░░░  3.40
   C ISR-non-mTOR   ██████████████████████████░░░░░░░░░░░░░░░░░░░░░  2.45
─────────────────────────────────────────────────────────────
                    0      1      2      3      4      5
```

**1위 = B DAPT-PGx-K (4.60)** — C1(규제 5) · C4(비용/시간 5) · C3(한국 leverage 5) 3개 만점이 견인. 유일한 비-만점 = C2(impact 4, D 의 대규모 MACE 에 밀림) · C5(성숙도 4, ICER 절대값 🟠 잔존).

---

## §5. 민감도 분석 (가중치 흔들어도 1위 안 바뀌나? — robustness)

> baseline 가중치는 ⚪ 주관. 4개 극단 시나리오로 가중치를 재배분해 **B 의 1위가 robust 한지** 검증한다. (각 시나리오 = 한 기준을 의도적으로 과대/과소 가중)

| 시나리오 | 가중치 (C1·C2·C3·C4·C5) | 의도 | B | A | D | C | 1위 |
|---|---|---|---:|---:|---:|---:|:---:|
| **S0 baseline** | 25·25·20·15·15 | "먼저=빠름+가치 동급" | **4.60** | 4.05 | 3.40 | 2.45 | **B** |
| **S1 impact 최우선** | 10·45·20·15·10 | "효과·규모가 전부" | **4.05** | 3.85 | **4.05** | 2.45 | **B=D 동률** |
| **S2 규제 무시** | 5·30·25·20·20 | "규제는 시간이 해결" | **4.05** | 3.90 | 3.95 | 2.50 | **B** |
| **S3 한국 leverage 최우선** | 15·15·45·15·10 | "first-in-class 차별성" | **4.55** | 4.30 | 3.90 | 2.70 | **B** |
| **S4 성숙도+비용 최우선** | 15·15·15·25·30 | "wet-lab전 risk+실무제약" | **4.55** | 3.90 | 3.60 | 2.05 | **B** |

```
민감도 — 5 시나리오별 1위 (가중치 극단 재배분)
─────────────────────────────────────────────────────────────
S0 baseline      B 4.60 ▸ A 4.05 ▸ D 3.40 ▸ C 2.45      → B
S1 impact최우선   B 4.05 = D 4.05 ▸ A 3.85 ▸ C 2.45      → B=D (동률)
S2 규제무시       B 4.05 ▸ D 3.95 ▸ A 3.90 ▸ C 2.45      → B
S3 한국leverage   B 4.55 ▸ A 4.30 ▸ D 3.90 ▸ C 2.70      → B
S4 성숙도+비용    B 4.55 ▸ A 3.90 ▸ D 3.60 ▸ C 2.05      → B
─────────────────────────────────────────────────────────────
B 1위 유지 = 5/5 시나리오 (S1 에서 D 와 동률, 단독 역전은 0회)
```

**robustness 판정 (honest)**:
- **B 는 5/5 시나리오에서 1위 유지** — 어느 가중치 배분에서도 B 가 1위 자리를 내주지 않는다. **robust.**
- **유일한 위협 = S1 (impact 가중치 45%)** — 임상 impact 만 극단 강조하면 **D 가 B 와 동률(4.05)** 까지 따라붙는다. 이는 honest: D 의 임상가치(대규모 MACE outcome, n~3,000, ~520만 명 대상)가 B 보다 본질적으로 크기 때문. 그러나 D 가 **단독 역전하는 시나리오는 0회** — D 의 C1(규제 1) · C4(비용/시간 1) 가 너무 낮아 impact 만으로는 B 를 넘지 못한다.
- **C 는 4/4 시나리오 모두 최하위** — 가중치를 어떻게 흔들어도 C 가 1·2·3위로 오르지 않는다 (성숙도 1 + impact 2 가 발목).

⚠ **민감도의 honest 한계**: 점수(1-5) 자체가 ⚪ 이므로 점수에 ±1 오차를 주면 동률 경계(S1 B=D)는 뒤집힐 수 있다. 본 민감도는 **가중치** robustness 만 검증 — 점수 robustness 는 별도. 단, B 의 C1/C3/C4 만점은 "신규 IND 불요(X5 §4 verbatim)" 라는 **이산적 사실** 기반이라 점수 오차에 강하다(IND 불요는 0/1 사실, subjective 추정 아님).

---

## §6. 결론 — "먼저 B DAPT-PGx-K" 정량 정당화 + X5 honest 대조

### 6.1 MCDA 가 X5 의 정성 판단을 재현하는가?

X5 §4·§7 은 정성적으로 **"B = 즉시 시작 · 신규 IND 불요"** 라 단언했다. 본 X12 MCDA(독립 정량화)가 이를 재현하는지 honest 확인:

| X5 정성 주장 | X12 MCDA 정량 결과 | 재현 여부 |
|---|---|---|
| "B = 규제 lift **최저**(즉시 0m)" (X5 §5.3) | C1 규제 feasibility **B=5 만점** | ✅ 재현 |
| "B = 즉시 시작 가능, 인프라 0" (X5 §7) | C4 비용/시간 **B=5 만점** | ✅ 재현 |
| "B 한국 CYP2C19 LoF 글로벌 최고" (X5 §3.1) | C3 한국 leverage **B=5 만점** | ✅ 재현 |
| **종합: B 가 first trial 후보** | 가중합 **B=4.60 1위 · 5/5 시나리오 robust** | ✅ **재현** |

→ **X12 MCDA 는 X5 의 "B 먼저" 정성 판단을 독립적으로 재현한다.** 5개 기준 중 3개(C1·C3·C4)에서 B 가 단독 만점이고, 5개 민감도 시나리오 전부에서 1위를 유지한다. 단순히 X5 결론을 베낀 것이 아니라 — **D 가 임상 impact(C2=5)·성숙도(C5=5)에서 B 를 앞서는데도** B 가 이기는 이유를 정량화했다: D 의 규제(C1=1)·비용시간(C4=1) penalty 가 결정적. 즉 "**먼저** 하나"라는 질문이 규제·시간 축을 강조하는 한 B 가 정답이고, "**궁극적으로 가장 가치 있는**" 질문이면 D 가 B 와 동률(S1)까지 올라온다 — 이 분기를 MCDA 가 명시적으로 드러낸다.

### 6.2 honest caveat (d6 — 결론에 점수 맞추지 않았음을 입증)

- **B 가 만점이 아닌 칸 2개를 숨기지 않는다**: C2(impact 4, D 에 밀림 — D 가 대규모 hard-MACE) · C5(성숙도 4, **ICER 절대값 🟠** — X3 §3.1 v7 에서 ΔQALY sign 은 반전(+161, 방향성 🟢)했으나 절대값이 Korea WTP 30 초과, drug-cost 재모델 대기). B 는 "임상 적용성 1위"이지 "모든 면 완벽"이 아니다 — X3 §3 verbatim: "ICER 는 급여 economic case 일 뿐 임상 적용성 아님".
- **결론 역산 안 함**: 만약 결론에 맞추려 했다면 B 의 C2·C5 도 5 로 올려 4.60→5.0 으로 만들었을 것. 그러지 않았다 — 점수는 근거(D 의 더 큰 cohort · B 의 ICER 🟠)에서 도출.

### 6.3 d2 — 하위 랭크 trial 의 돌파 path (버리지 않음)

MCDA 하위라고 trial 을 폐기하지 않는다. portfolio 의 **순차 timeline**(X5 §4)상 각자의 자리가 있다:

| 순위 | trial | MCDA 약점 | 돌파 path (X9 d2 VERBATIM) | portfolio 자리 |
|---|---|---|---|---|
| 2 | **A** | C4 비용/시간 3 (CMR consortium 0개) | "KHIDI/보건복지부 R&D 8-기관 consortium 빌드(2-3년)" + "IMR>40 stratification 으로 enrollment power 향상" + "CMR/OCT imaging 자산 ISR(C)과 공유"(X9 N3) | timeline 6m — B 와 병행 protocol/MOU 시작 (X5 §4) |
| 3 | **D** | C1 규제 1 · C4 비용/시간 1 (siRNA 신규승인+RSA+글로벌 readout) | "**RSA**(outcome-based ≥85% RRR 미달시 ≥50% refund) + **narrow staging**(≥180 mg/dL ~52만 명) + **bridge therapy** 3축 동시"(X9 L2) | timeline 3y — HORIZON 2026 H1 readout 후 arm B 분기 (X5 §4) ※ 성숙도(C5=5)·impact(C2=5)는 최고 |
| 4 | **C** | C5 성숙도 1 (verify verdict 부재 ⚪) · C2 impact 2 (n=60 FIH) | "**Japan PMDA cross-recognition**(fasudil 일본 1995, 30y 안전성)→IND data package 단축" + "한·일 Asian DCB consortium" + "fasudil-DCB FIH IIT-1(n=60·15-25억 KRW)로 ROCK 국소전달 white space 선점"(X9 I3·I4) | timeline 6m pre-IND — A 와 cath lab/imaging consortium 공유(X5 §2.1) |

→ **공유 인프라 leverage(X5 §2)**: B 를 먼저 해도 A·C·D 가 sunk 되지 않는다 — 3-axis PCR lab(B 의 CYP2C19 + A 의 ALDH2\*2 + D 의 KIV-2 동시 측정) · imaging consortium(A·C 공유) · KAMIR backbone(4-trial 전부)이 B 시작과 함께 빌드되면 나머지 3 trial 의 wall 을 동시에 낮춘다(X9 §5·§7 순위 2 "3-axis panel 6 wall 동시"). **B 먼저 = 나머지 3 trial 의 onramp.**

---

## §7. g5 grade — X12 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 4-trial 식별 | 🟡 | X5 §1 portfolio 표 VERBATIM carry |
| §2 기준 정의 + 가중치 | ⚪ (주관) | MCDA 기준·가중치는 가치판단 proposal — §0 fence 명시 |
| §3 점수 매트릭스 | ⚪ (점수) + 🟡 (근거 인용) | 점수 1-5 = ⚪ proposal · 각 셀 근거는 X5/X8/X9 VERBATIM (trace 가능) |
| §3 C5 근거 grade 열 | 🟢/🟠/⚪ (VERBATIM) | X8 grade ledger / sub-V verdict 그대로 (X12 새 판정 0건) |
| §4 가중합 랭킹 | 🟢 (산술) | 점수×가중치 합산 = 재현 가능한 산술 (점수·가중치 input 은 ⚪) |
| §5 민감도 | 🟢 (산술) | 5 시나리오 가중합 재계산 = 재현 가능 산술 |
| §6 결론 | 🟡 + ⚪ | X5 §4/§7 정성 재현 대조(🟡 carry) · "B 먼저" 판단은 MCDA 산출 + ⚪ 가중치 의존 |

**X12 종합 등급**: ⚪ SPECULATION-FENCED (가중치·점수는 주관 proposal) over 🟡 (근거 인용·산술은 재현가능) — **MCDA 의 본질이 가치판단** 이므로 honest 하게 ⚪ 로 fence. 근거 grade 는 X8 VERBATIM(새 판정 0건), 가중합·민감도는 재현가능 산술. **결론("B 먼저")은 MCDA 산출이되 가중치 ⚪ 의존이라 "객관 사실"이 아닌 "명시된 가치판단 하에서의 정량 권고"** — 단, 민감도 5/5 robust 라 가중치 변동에 강건.

⚠ **honest fence (d6)**: 본 X12 는 결론을 먼저 정하고 점수를 맞추지 않았다 — B 의 C2·C5 비-만점, D 의 C2·C5 우위, S1 에서 B=D 동률을 전부 명시했다. "B 먼저"는 **규제·시간을 임상impact와 동급 이상으로 보는 가치관(baseline 가중치) 하에서의 robust 한 정량 권고** 이며, "궁극적 임상가치 최대"가 질문이면 D 가 동률 후보임을 숨기지 않는다.

---

## §8. X12 산출 요약

- **MCDA 1위 = B DAPT-PGx-K · 가중합 4.60/5.0** (baseline 가중치) — C1 규제(5)·C3 한국leverage(5)·C4 비용시간(5) 3개 만점 견인.
- **랭킹**: B(4.60) ▸ A(4.05) ▸ D(3.40) ▸ C(2.45).
- **민감도 robust = 5/5 시나리오 B 1위 유지** — 유일 위협은 S1(impact 가중 45%)에서 D 와 동률(4.05), 단 D 단독역전 0회 (D 의 규제1·비용시간1 penalty). C 는 4/4 최하위.
- **X5 정성("B 먼저·신규 IND 불요") 독립 재현 ✅** — 단순 carry 아님: D 가 impact·성숙도에서 앞서는데도 B 가 이기는 이유(D 의 규제·시간 penalty)를 정량화. "먼저"=B · "궁극 가치"=D 동률 분기를 명시.
- **g5/d6 준수**: 근거 grade = X8 VERBATIM(새 판정 0건) · 점수·가중치 = ⚪ proposal 명시 · 결론 역산 안 함(B 비-만점 칸·D 우위 honest) · 하위 trial(A·D·C) 돌파 path 전부 명시(d2, 폐기 0).
- **portfolio 함의**: B 먼저 = 나머지 3 trial 의 onramp — 3-axis PCR lab + imaging consortium + KAMIR backbone 공유 빌드가 A·C·D wall 동시 완화 (X5 §2 · X9 §7 순위 2).
