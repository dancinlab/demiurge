# X25 — CARDIO+ wet-lab readiness 패키지 (non-wet-lab 완료 → wet-lab 확증 다리)

> CARDIO+ 메타도메인 X25 산출물 · current-state · no history.
> 목적 = 각 핵심 claim 을 확증할 **최소 wet-lab 실험**을 도메인별 식별 — non-wet-lab verification 이 도달한 지점에서 wet-lab/실측이 무엇을 확증해야 하는지의 다리(bridge)를 명시한다.
> ⚠ 본 X25 = **wet-lab 실험 식별 only** — 새 hexa verify / sim / atlas / pool / cloud / python 실행 0건 · git 0건 · X25 외 파일 수정 0건. 입력 = X8 (g5 tier SSOT) + X14 (VoI 측정 + timeline) + X13 (weakened/🔴-flip gate) + X9 (wall map) read-only 인용 · 규모/비용/시점은 X5 trial portfolio VERBATIM carry.

---

## §0. d5 프레이밍 — non-wet-lab 완료, wet-lab 은 downstream 확증

**@D d5**: `absorbed=true ⇔ all non-wet-lab gates PASS · wet-lab 은 downstream 확증`.

CARDIO+ 의 4 sub-domain 은 non-wet-lab verification 층(sim · proof · synthesis · gate)을 정직하게 끝까지 밀었다. X13 적대검정의 핵심 결론(§4.2)과 X14 VoI 의 honest 핵심(§5)이 동일하게 가리키는 바:

```
산술층 (🟢 numerical recompute · 🔵 closed-form)   = 이미 닫힘 (non-wet-lab 완료 · VoI≈0)
                              │
                              ▼  ← 이 경계가 d5 의 경계
인과/해석층 (numerical → causal over-read)          = 외부 RCT/실측 ground-truth 의존 (wet-lab downstream)
```

→ X25 가 식별하는 wet-lab 실험은 거의 전부 **"산술(🟢)은 견고하나 인과 라벨이 외부 ground-truth 를 요구하는"** 지점을 닫는다 (X13 §4.2 numerical→causal over-read 패턴). 즉 wet-lab 은 새 산술이 아니라 **인과 확증** 이며, 이것이 정확히 d5 의 downstream 영역이다.

**경계 명시 (어디까지 absorbed · 무엇이 downstream)** — §4 에서 상술.

---

## §1. 방법론 — 최소 wet-lab 실험 매핑

```
각 핵심 claim
  │
  ▼ ① 현 tier 확인 (X8 VERBATIM · g5 · 변경 0건)
  │
  ▼ ② 확증 대상 식별 = X13 의 어느 weakened/🔴-flip 인가 (numerical→causal gate)
  │
  ▼ ③ 최소 wet-lab 실험 = X14 VoI 의 "결정적 단일 측정" VERBATIM carry
  │     (최소 = 그 claim 을 분기시키는 가장 작은 실험 · over-design 금지)
  │
  ▼ ④ 규모/비용/시점 = X5 trial portfolio VERBATIM (n · 비용 · readout 일정)
  │
  ▼ ⑤ tier 이동 = positive 시 어느 grade 로 (d6: 방향 미단정 · null 도 명시)
```

- **g5**: "현 tier" 열 = X8 ledger VERBATIM · **X25 새 grade 부여 0건**. 실험 식별과 tier-이동 매핑만 (실제 tier 변경은 wet-lab readout 후 hexa verify 재실행 소관).
- **d6 정직**: "이동(→ tier)" 열은 측정 전 결과를 단정하지 않는다 — positive(🟢/🔵 상향) / null(🔴 closed) 양방향 모두 명시. 측정 전 결과를 가정하면 wet-lab 의 목적 자체가 무너진다.
- **최소(minimal)**: 각 실험은 해당 claim 을 분기시키는 가장 작은 readout 만 식별 (예: Trial-A 전체가 아니라 ALDH2*2 stratified CMR salvage index arm). over-design 은 d1 completed-form 의 반대.

---

## §2. 도메인별 최소 wet-lab 실험 표

> "현 tier(X8)" = X8 §2 ledger / §5 🔴 명세 VERBATIM. "최소 wet-lab 실험" = X14 §1 결정적 단일 측정 VERBATIM carry. "규모/비용" = X5 §1/§6 VERBATIM. "이동(→ tier)" = d6 양방향 (positive/null 미단정).

### 2.1 NOREFLOW (meta-thesis 핵심)

| claim | 현 tier(X8) | 최소 wet-lab 실험 | 확증 대상 | 규모/비용 | 이동(→ tier) |
|---|---|---|---|---|---|
| **IC-sync delivery 가 4 RCT null 의 원인 (mis-delivered, 약물 살아있음)** | 🟢(ODE Δ36.6pp) 위 인과 = X13 R5/H1 🔴-flip 후보 (★★★ 최고 취약) | **IC-sync delivery device IIT** — CMR salvage index primary (재관류-synced IC 전달 vs IV bolus) | thesis 전체 ground-truth gate (drug-dead null 배제 · X14 §2 TOP VoI) | **n~60–500** · Ph2 IIT · 한국 cath lab consortium (신규) — 카테터 국소전달 core lab A·C 공용 (X5 §2.3) | positive → "mis-delivered" 입증 → thesis 🟢 인과 확보 · null → drug-dead 🔴 확정(정직한 닫힘) — **방향 미단정** |
| **mPTP 단독이 인간 IRI cell-death 의 지배경로** | Δ36.6pp **weakened** (X13 S1 clinical 외삽) | **mPTP cell-death fraction attribution** (ex-vivo/preclinical · 다축 ferroptosis·necroptosis·STING 대비 mPTP 단독 기여 %) | Δ36.6pp 의 분모(mPTP 기여분)가 과대인가 — S1(drug-dead) 부분 배제/확인 | preclinical ex-vivo (IIT 전 단계) — X14 §3 신규 IIT 전 단계 | mPTP 지배 → Δ36.6pp 무조건부 (🟢 강화) · mPTP minor → in-vivo Δ ≪ 36.6pp (weakened 유지) — **방향 미단정** |
| **Δ36.6pp 의 신뢰구간 (point estimate 단일)** | 🟢(ODE) · CI 미공개 (X13 S3/H4) | **arm-to-heart lag human 실측** (device PK study · IV vs IC tmax · Cmax 536× vs cited 30–100×) | IC-sync 전제(tmax 3s)의 정량 토대 — H4 Cmax 17배 magnitude 차이 해소 | device PK study (신규 IIT 동반) | 30–100× 영역 확정 → model 536× 🔴 (전제 약화) · 536× 재현 → 전제 🟢 강화 — **방향 미단정** |
| **NMN/NAD+ precon 이 한국 STEMI IRI 를 줄이나 (NRF-F4)** | ⚪ trial-outcome-projection | **Trial-B NMN-PRECON Gate-1 readout** (단일기관 IRB-light pilot · 한국 건강기능식품 NMN) | NAD+→IRI↓ 인과 (SIRT3-CypD 축) — supplement IRB-light 경로(LPA siRNA cohort 공용 X5 §1.2) | 단일기관 IRB-light pilot · **2027 Q4** Gate-1 (X14 §3 · X5) | positive → 🟢 (NRF-F4 escalation) · null → 🔴 — **방향 미단정** |

### 2.2 DAPTPGX (caller validation cohort 핵심)

| claim | 현 tier(X8) | 최소 wet-lab 실험 | 확증 대상 | 규모/비용 | 이동(→ tier) |
|---|---|---|---|---|---|
| **결정맵 적용이 실제 ST/MACE 를 줄이나 (C21 정량 KPI)** | 🟠 (model assumption) / ⚪-성격 (X4 §2.2) | **DAPT-PGx-K cohort outcome 실측** (S4 targeted vs S1 universal · 1y MACE + 공동 1차 major bleeding GUSTO/BARC) | 결정맵 outcome Δ — model assumption → 실측 (X14 §1.2 ★★★★) | CYP2C19 PCR 선별급여(C5946) 기존재 + 기존 급여 약제 → **신규 IND 불요** · registry-embedded 즉시~1y MACE (X5 §1 B · 최저 실현장벽) | outcome Δ 확인 → 🟢 (C21 land) · Δ 무효 → 🔴 — **방향 미단정** |
| **5 PGx caller 한국 cohort concordance (caller validation)** | 🟠 (gap F8 · head-to-head 0건) | **KOVA VCF → 4 caller(PyPGx·PharmCAT·Aldy·Stargazer) 병렬 → confusion matrix** | diplotype 분류 신뢰성 — 한국 cohort 첫 head-to-head (X9 D4 · X14 §1.2 ★★★) | KOVA VCF 접근 시 데이터 즉시 (in-silico/bioinformatics validation, 채혈 불요 — 既-genotyped cohort) | concordance 高 → caller 🟡 carry 정당 · 불일치 高 → 분류 불확실성 노출 (🟠 유지) — **방향 미단정** |
| **ICER S4 net-beneficial 방향성 (sign 반전 +0.045)** | 🟢(방향) · 🟠(절대값) **weakened** (X13 R7/H3 · 2 FIX 가정 의존) | **PSA + drug-cost 재모델 (prasugrel 5mg first-line)** + DAPT-PGx-K cohort 실측 | sign 반전이 param 전반서 robust 한가 vs FIX 의존인가 + 경제성(+161 WTP 진입) | sim+cohort (cohort = Trial-B 동반) — sim 즉시 (pool-route 복구 PR #700) | sign robust → 방향 🟢 정당 · FIX 의존 → 🟠/🔴 강등 — **방향 미단정** |
| **PM 0.1521 독립 한국 cohort HWE 일치 (대표성)** | 🟢(HW closed-form) · 오독 위험 (X13 H6) | **독립 한국 cohort genotyping (KOVA/KORV1K) HWE 검정 + cohort 간 I²** | 0.1521 대표성 — 단일 cohort vs pooled (산술 🟢 는 불변) | 데이터 즉시 (既-genotyped cohort · 채혈 불요) | HWE 일치 → 대표성 확인 · deviation → 단일 cohort 대표성 약화 (산술 🟢 유지) — **방향 미단정** |

### 2.3 ISR (fasudil-DCB bench/animal 핵심)

| claim | 현 tier(X8) | 최소 wet-lab 실험 | 확증 대상 | 규모/비용 | 이동(→ tier) |
|---|---|---|---|---|---|
| **fasudil-DCB (비-mTOR ROCK) 가 잔여 5–10% ISR 을 줄이나 (mTOR plateau 돌파)** | 🟠/⚪ (preclinical · I1/I3 wall) | **fasudil-DCB bench(coating elution) → animal(porcine coronary OES) → FIH IIT-1** (6m OCT-derived LLL primary + 30d safety) | 비-mTOR 가설 — mTOR plateau 가 분자 한계인가 (X13 I1 · X14 §1.3 ★★★) | **n=60** multi-center 6–8 sites · first-in-human IIT · **15–25억 KRW** (X9 I3) · MFDS FIH IND + PMDA cross-recognition · **2026 Q4 enroll → 6m readout** (X5 §1 C · X14 §3) | LLL↓ → 비-mTOR 🟢 영역 진입 · 무효 → mTOR plateau = 분자 한계 — **방향 미단정** |
| **bio identity 10건 (Hill·Cheng-Prusoff·Higuchi·Fick) closed-form 재현** | ⚪ kernel-temporary 10 (X4 §2.3) | (non-wet-lab · 코드 gate) **bio-verify-kernel phase 2 PR merge** → `hexa verify --expr` 재실행 | 산술층 — **wet-lab 아님** (§5 경계: non-wet-lab absorbed 영역) | 즉시(0m) 코드 gate — X9 §7 순위 1 leverage (NOREFLOW 11 + DAPTPGX 4 + ISR 동시) | merge+재현 → 🔵/🟢 (10건 동시) — **wet-lab 무관 (산술층 closure)** |
| **sim 절대값이 lit 과 체계적으로 어긋나나 (PK ODE 99.7% vs lit 80–90% · Mg Tafel 40×)** | ⚪ (X4 ISR-V3 · X13 H5 이미 fenced) | **kernel merge 후 재현 + lit anchor 재대조** (bench passivation 보정 실측 동반) | sim 절대값 vs 실측 lit anchor — 이미 ⚪ fenced (★☆☆) | bench 실측(in-vitro Tafel/passivation) — 낮은 우선순위 | 40× mismatch 지속 → sim 절대값 🔴 · 보정 후 수렴 → 🟢 (단 이미 ⚪ fenced) — **방향 미단정** |

### 2.4 LPA (HORIZON readout · 외부 의존 핵심)

| claim | 현 tier(X8) | 최소 wet-lab 실험 | 확증 대상 | 규모/비용 | 이동(→ tier) |
|---|---|---|---|---|---|
| **Lp(a) 낮춤이 실제 MACE 를 낮추나 (MR β -0.3413 "인과" ground truth)** | 🟢(numerical) 위 인과 = **weakened** (X13 R3/H2 ★★★) | **HORIZON pelacarsen readout (외부)** — Lp(a) -80% → MACE | MR 인과 라벨의 ground truth (X14 준-TOP VoI · ★★★★★ 동급) | **외부 글로벌 Ph3 · 자체 불가** · readout **2026 H1** (확정 · X14 §3 · X9 L1) | Lp(a)↓→MACE↓ → MR 인과 확인 (인과 라벨 정당) · Lp(a)↓인데 MACE 무효 → 인과 라벨 🔴 (β 산술 🟢 유지) — **방향 미단정** |
| **correlated/balanced pleiotropy 가 β 를 오염시키나 (Egger 미포착)** | 🟢 · 인과 가정 미검증 (X13 R3 null-B) | (non-wet-lab) **CAUSE/MR-PRESSO global + 독립 GWAS(KoGES) IVW 재추정** | exclusion-restriction 검정 — **데이터 분석층 (wet-lab 아님)** | 데이터 즉시(0m) — 既-summary stats | pleiotropy 無 → 인과 강화 · 有 → 인과 라벨 축소 — **방향 미단정 (데이터-gate, wet-lab 무관)** |
| **siRNA/ASO 가 한국 NHIS WTP 통과 약가 도달 (현 0% pass)** | 🟠/⚪ (V3c PSA 0% pass · L2 wall) | **K-LpA-OUTCOMES 60m MACE primary + RSA 협상** (arm B = pelacarsen/olpasiran, HORIZON 후 분기) | 약가-적응증 경제 gate (RRR 입증 → 급여) | **n~3,000** (2,500+buffer 500) · Ph3 outcome IIT · siRNA/ASO **신규 승인 필요** · **2032 H1** 60m primary (X5 §1 D · 최고 실현장벽) | RSA+RRR 입증 → 급여 진입 · 미달 → 387–645× 약가 격차 wall 지속 — **방향 미단정** |
| **muvalaplin 경구 lifelong 외삽 50% 감쇠 가정** | C27 🟠→🟢 (V3a sensitivity 정량화, X4 §2.4) | **muvalaplin lifelong outcome trial (외부 · vs late-onset)** | 50% 감쇠 heuristic — 이미 정량화로 부분 해소 (★★) | 외부 Ph3 readout 의존 (장기 2–3y+) | 50% 감쇠 확인 → heuristic 정당 · 다른 감쇠율 → 외삽 보정 — **방향 미단정** |

### 2.5 cross-domain (3-axis 메타)

| claim | 현 tier(X8) | 최소 wet-lab 실험 | 확증 대상 | 규모/비용 | 이동(→ tier) |
|---|---|---|---|---|---|
| **3-axis triple-positive 실제 prevalence (joint prob)** | 🟡(채혈부)·⚪(시너지) **weakened** (X13 R4) | (non-wet-lab) **한국 cohort joint genotype prevalence 직접 계산** (LD/correlation 보정) | leverage 분모 — triple-positive ≫ 3.1% 인가 (데이터-gate, wet-lab 아님) | 데이터 즉시(0m) — KOVA · 既-genotyped | ≫3.1% → leverage 분모 충분 · ≈3.1% → 소수파(임상 크기 작음) — **방향 미단정** |
| **3-axis stratification 이 실제 outcome 을 개선하나** | ⚪ prognostic (X13 R4 null-B) | **3-axis enriched arm vs unstratified RCT** | 측정가능성 ≠ 효과 — stratify→MACE↓ 인가 | enriched arm RCT (장기 신규) | stratify→MACE↓ → leverage 효과 입증 · 동일 → 측정가능성만 — **방향 미단정** |

---

## §3. wet-lab 우선순위 ASCII (VoI × 실현성)

> VoI = X14 ★ 등급 VERBATIM (영향력 × 측정 실현성). 실현성 = X14 §3 timeline 분류 (즉시 / readout-대기 / 신규 IIT / 장기). 본 §3 의 순위 가중은 X14 ★ 수 근거 · X25 ranking 가공은 ⚪.

```
VoI(영향력)
  ↑
★★★★★  🏆 IC-sync delivery IIT ────────────────────────●  (thesis 전체 gate · X14 TOP)
        │  자체 신규 IIT (한국 cath lab consortium · n~60-500)
        │     ★ HORIZON pelacarsen readout ─────────────◆  (LPA 인과 gate · 외부·자체불가)
        │        외부 글로벌 Ph3 · 2026 H1 확정 (실현 임박도 최고)
  ──────┼──────────────────────────────────────────────────────────────────
★★★★    │  ● DAPT-PGx-K cohort outcome (C21)    ● bio-verify-kernel PR (산술층·非 wet-lab)
        │     registry-embedded 즉시~1y · 최저장벽    즉시(0m) 코드 gate
  ──────┼──────────────────────────────────────────────────────────────────
★★★     │  ● fasudil-DCB bench/animal/FIH      ● mPTP cell-death attribution (ex-vivo)
        │     n=60 · 15-25억 · 2026 Q4→6m         preclinical (IIT 전)
        │  ● caller concordance (KOVA VCF)     ● arm-lag human PK · NMN-PRECON 2027 Q4
        │     데이터 즉시 (채혈 불요)              ● K-LpA-OUTCOMES 60m (n~3,000 · 2032)
  ──────┼──────────────────────────────────────────────────────────────────
★★      │  ● PM HWE 독립 cohort · 3-axis joint prob (데이터 즉시)
        │  ● muvalaplin lifelong (외부) · 3-axis stratification RCT (장기)
  ──────┼──────────────────────────────────────────────────────────────────
★☆      │  ● sim 절대값 lit mismatch (이미 ⚪ fenced)
  ──────┴──────────────────────────────────────────────────────────────────────→ 실현성
         즉시(0m)      신규 IIT(6m~2-3y)      readout-대기(일정확정)      장기(2-3y+)

범례:  ● 자체 가능 (한국 IIT/cohort/bench)    ◆ 외부 readout 의존 (자체 불가)
```

**우선순위 판독 (X14 §2 정합)**:
1. **최고 VoI (thesis gate)** = 🏆 **IC-sync delivery IIT** — 자체 신규 IIT 필요(6m~2-3y), 그러나 thesis 전체를 분기하는 유일 gate (X13 R5/H1 ★★★ 최고 취약).
2. **최고 실현-임박 VoI** = ◆ **HORIZON pelacarsen 2026 H1** — 외부·자체 불가지만 일정 확정 + LPA 인과 ground truth (★★★★★ 동급).
3. **최저장벽 자체 실험** = **DAPT-PGx-K cohort** (★★★★) — 신규 IND 불요·registry-embedded 즉시.
4. **최대 코드 leverage (非 wet-lab)** = bio-verify-kernel PR — 산술층 closure(§5 absorbed 영역), wet-lab 아님.

---

## §4. non-wet-lab vs wet-lab 경계 (d5 — 어디까지 absorbed · 무엇이 downstream)

```
┌──────────────────────────── d5 경계 ────────────────────────────┐
│                                                                  │
│  ◀── absorbed=true 가능 (non-wet-lab gate)    │   downstream ──▶ │
│                                               │   (wet-lab 확증) │
│  · 🟢 numerical recompute 재현 (43건)         │  · IC-sync IIT   │
│  · 🔵 closed-form (LPA C30 · kernel PR 후)    │  · DAPT-PGx-K     │
│  · 🟡 citation-locked (~215건 · 인체 RCT 인용)│    cohort outcome │
│  · 🟠 model assumption · DEFERRED (45건)      │  · fasudil-DCB    │
│  · 🔴 closed negative (5건 · 4 RCT null+IP)   │    bench/animal   │
│  · ⚪ honest fence (가치판단·metaphor·proj)   │  · HORIZON(외부)  │
│  · 데이터-gate (joint prob · pleiotropy ·     │  · K-LpA 60m      │
│    HWE · caller concordance — 채혈 불요)      │  · NMN-PRECON     │
│                                               │                  │
│  ▶ X8 강한 근거 44 → kernel PR 후 ~67~97      │  ▶ 인과 라벨 확증 │
│    (산술층 closure)                           │    (numerical→    │
│                                               │     causal)       │
└──────────────────────────────────────────────────────────────────┘
```

**경계 규칙 (3가지 honest 분리)**:

1. **absorbed 영역 (non-wet-lab 완료)** — 산술층(🟢/🔵)·인용층(🟡)·가정/유보층(🟠)·닫힌 음성(🔴)·정직 fence(⚪)는 모두 non-wet-lab gate 로 닫혔거나 닫을 수 있다. X8 §6 기준 강한 근거 44건 + bio-verify-kernel phase 2 PR merge 시 ~67~97 까지가 **wet-lab 없이 absorbed 가능**. **이 영역에 wet-lab 을 요구하면 d5 위반** (산술 재현에 RCT 를 끌어오는 over-design).

2. **데이터-gate 는 wet-lab 이 아니다** — joint prevalence 계산 · CAUSE/MR-PRESSO pleiotropy · HWE 검정 · 4-caller concordance(既-genotyped VCF)는 채혈/신규 측정 없이 既-데이터 분석으로 닫힌다. X14 §3 "즉시 가능(0m)" 7건 중 대부분 — **non-wet-lab absorbed 영역** (§3 에서 ● 즉시 열에 배치하되 wet-lab 표기 제외).

3. **downstream 영역 (wet-lab 확증)** — numerical → causal over-read 가 발생한 인과 라벨만이 진짜 wet-lab/실측을 요구한다 (X13 §4.2). IC-sync IIT · DAPT-PGx-K cohort outcome · fasudil-DCB bench/animal · NMN-PRECON · K-LpA 60m + 외부 readout(HORIZON · muvalaplin)이 여기 속한다. **이것이 d5 의 downstream confirmation** — non-wet-lab 이 PASS 여도 인과 확정은 이 실험들이 한다.

→ **d5 정합 결론**: CARDIO+ 는 non-wet-lab 층을 정직하게 완료(absorbed)했고(X8 강한 근거 44 + kernel PR 후 ~67~97 · X13 gradedown 0건), wet-lab 은 산술이 아니라 **인과를 확정하는 downstream** 이다. 산술층에 wet-lab 을 요구하지 않고, 인과 라벨에 wet-lab 없이 absorbed 를 주장하지 않는다 — 이 양방향 절제가 d5 의 정직성이다.

---

## §5. 외부 readout 의존 (자체 불가) — 정직 분리

> 일부 최소 실험은 한국 자체 IIT/cohort/bench 로 닫히지 않고 **외부 글로벌 Ph3 readout** 에 의존한다(자체 불가). d6 정직 — 자체 실험과 외부 의존을 섞지 않고 분리.

| 외부 readout (자체 불가) | 확증 대상 claim | 일정 | 자체 bridge path (d2) |
|---|---|---|---|
| **HORIZON pelacarsen readout** | LPA MR β -0.3413 "인과" ground truth (X13 H2 ★★★) | **2026 H1** (확정) | K-LpA-OUTCOMES arm B 가 HORIZON 후 분기 (X5 §1 D) — 외부 readout 을 한국 cohort 의 surrogate bridge 로 carry |
| **OCEAN(a) 등 글로벌 Lp(a) Ph3** | siRNA(olpasiran) MACE 보조 readout | **2026–27** | HORIZON/OCEAN(a) 동시 모니터 → K-LpA arm 분기 근거 (X14 §3) |
| **muvalaplin lifelong outcome** | C27 경구 50% 감쇠 외삽 | Ph3 readout 의존(장기) | V3a sensitivity 로 이미 부분 정량화(🟠→🟢, X4 §2.4) — interim readout 으로 조기 분기 |
| **VERVE-301 base editor 한국 적용** | single-dose lifetime Lp(a)↓ | **2033+** (preclinical→IND) | 글로벌 readout 을 surrogate bridge 로 carry (X14 §4) |

→ **자체 불가 핵심**: LPA 인과 ground truth(HORIZON · ★★★★★ 동급 VoI)는 **외부 글로벌 Ph3 에 전적으로 의존** — 한국이 자체로 만들 수 없다. 대신 K-LpA-OUTCOMES 가 HORIZON readout 후 arm 을 분기하여 한국 cohort 로 KIV-2 copy stratified efficacy(글로벌 미시도)를 확증하는 bridge 역할. 나머지 자체 가능 실험(IC-sync IIT · DAPT-PGx-K · fasudil-DCB)은 한국 consortium/cohort/bench 로 self-contained.

---

## §6. g5 grade — X25 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §0 d5 프레이밍 | 🟡 | d5 거버넌스 + X13 §4.2 / X14 §5 경계 VERBATIM carry |
| §1 방법론 | 🟡 | g5 rubric + d6/d1 거버넌스 + X14 VoI 절차 carry |
| §2 도메인별 최소 실험 표 | 🟡 (compositional) | 현 tier X8 VERBATIM · 최소 실험 X14 VERBATIM · 규모/비용/시점 X5 VERBATIM · 확증 대상 X13 VERBATIM |
| §3 우선순위 ASCII | ⚪ (VoI ranking · 자체 가공) | ★ 등급은 X14 VERBATIM · VoI×실현성 배치는 X25 가공(자의 가중) |
| §4 경계 (d5) | 🟡 | X8 §6 강한 근거 + X13 §4.2 + X14 §5 absorbed/downstream 분리 VERBATIM |
| §5 외부 readout 분리 | 🟡 | X14 §3 timeline + X5 §1/외부 readout 일정 VERBATIM |

**X25 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — 현 tier 전부 X8 VERBATIM · 최소 실험 X14 결정적 측정 VERBATIM · 규모/비용/시점 X5 VERBATIM · 확증 대상(weakened/🔴-flip) X13 VERBATIM. **X25 새 grade 부여 0건** (per @D g5). VoI×실현성 우선순위 배치만 X25 가공(§3 ⚪ 자체 표기). **d6 준수**: 모든 "이동(→ tier)" 열에서 측정 전 분기 방향 미단정(positive/null 양방향). **d5 준수**: non-wet-lab absorbed vs wet-lab downstream 경계 명시(§4). **d1**: completed-form.

⚠ **honest 핵심**: 최소 wet-lab 실험의 거의 전부가 **인과/해석층** 을 닫는다(X13 §4.2 numerical→causal over-read) — 산술층(🟢)은 non-wet-lab 으로 이미 absorbed(VoI≈0). 따라서 wet-lab 은 산술 재계산이 아니라 인과 확정이며, 이것이 정확히 d5 의 downstream 영역이다. IC-sync IIT(thesis gate)와 HORIZON(LPA 인과)은 그 인과층을 닫는 단 두 개의 ★★★★★ 측정이고, 후자는 한국 자체 불가(외부 글로벌 Ph3 의존)다.

---

## §7. X25 산출 요약

- **최소 wet-lab 실험 총 개수**: **14건** — NOREFLOW 4 · DAPTPGX 4 · ISR 3 · LPA 4 · cross-domain 2 = 17 식별 중, 순수 데이터-gate/코드-gate(non-wet-lab) 3건(ISR bio-kernel PR · LPA pleiotropy 분석 · cross joint prob)을 §4 경계 규칙으로 제외하면 **실제 wet-lab/실측 = 14건** (DAPTPGX caller concordance·PM HWE 는 既-genotyped 데이터-gate 라 wet-lab 경계상 회색 — §4.2 기준 데이터-gate 로 분류).
  - 도메인별 wet-lab(실측 동반): NOREFLOW 4 (IC-sync IIT · mPTP attribution · arm-lag PK · NMN-PRECON) · DAPTPGX 1~2 (DAPT-PGx-K cohort · [PSA 일부] ) · ISR 2 (fasudil-DCB bench/animal/FIH · bench passivation) · LPA 3 (HORIZON · K-LpA 60m · muvalaplin) · cross 1 (3-axis stratification RCT)
- **최우선 1개 (VoI 최대)**: 🏆 **IC-sync delivery device IIT** (CMR salvage index · ★★★★★) — CARDIO+ thesis 전체 ground-truth gate (X14 TOP · X13 R5/H1 최고 취약). positive → "mis-delivered" 입증(thesis 🟢 인과) · null → drug-dead 🔴 정직 닫힘. n~60–500 한국 cath lab consortium 신규 IIT. **준-최우선(외부·일정 임박)** = HORIZON pelacarsen 2026 H1 (★★★★★ 동급).
- **외부 readout 의존 (자체 불가)**: **4건** — HORIZON pelacarsen 2026 H1(LPA 인과 ★★★★★) · OCEAN(a) 2026–27 · muvalaplin lifelong · VERVE-301 2033+. 모두 글로벌 Ph3 readout 의존 — 한국 자체 생성 불가. K-LpA-OUTCOMES 가 HORIZON 후 arm 분기로 surrogate bridge.
- **d5 경계**: non-wet-lab absorbed(🟢 43 + 🔵 + 🟡 ~215 + 데이터/코드-gate · 강한 근거 44→kernel PR 후 ~67~97) vs wet-lab downstream(인과 라벨 확정). 산술층에 wet-lab 요구 금지 · 인과 라벨에 wet-lab 없이 absorbed 주장 금지.
- **g5 준수**: 현 tier 전부 X8 VERBATIM · 최소 실험 X14 VERBATIM · 규모/비용/시점 X5 VERBATIM · 확증 대상 X13 VERBATIM · **X25 새 grade 0건** · d6 방향 미단정 · d5 경계 명시 · sim/pool/cloud/python/hexa verify/git 0건.

→ **다음 단계**: 본 X25 = non-wet-lab → wet-lab 다리. 최우선 IC-sync IIT(thesis gate) + HORIZON readout 추적(2026 H1)이 두 ★★★★★ 인과 gate. X5 trial portfolio 4-trial 설계 + X7 DOCTOR feed 의 "어느 wet-lab 이 무엇을 닫나" 1-page 입력. 산술층(non-wet-lab)은 absorbed, 인과층(wet-lab)은 정직하게 downstream 으로 명시.
