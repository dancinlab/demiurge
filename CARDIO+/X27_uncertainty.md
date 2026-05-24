# X27 — CARDIO+ 불확실성/robustness 집계 (UQ ledger)

> CARDIO+ 메타도메인 X27 산출물 · current-state · no history.
> 목적 = 이미 산출된 numerical claim 들의 불확실성 정량(CI · 민감도 · bootstrap)을 단일 UQ ledger 로 집계하고, 점추정만 있고 CI 밴드 없는 🟢 (robustness gap)를 명시한다.
> ⚠ 본 X27 = **기존 sub-V / X3 verbatim 집계 only** — 새 sim / hexa verify / pool / cloud / python 실행 0건 · 새 판정/grade 부여 0건 · git 0건 · X27 외 파일 수정 0건. 모든 CI/민감도/grade 는 sub-V (LPA V3b · NOREFLOW V3) / X3 (§3.2 ICER) / X8 VERBATIM (per @D g5). LLM self-judge 0건 · 측정 전 결론 미단정 (d6) · completed-form (d1).

---

## §1. 방법론 — UQ ledger 정의

**UQ (uncertainty quantification)** = 점추정에 부착된 불확실성 정량 — bootstrap CI · power · 민감도 sweep · param 의존도. 본 X27 은 X8 의 🟢 43 + 🟠 power claim 중 **이미 산출된 불확실성 정량을 sub-V verbatim 으로 수집**해 한 표로 합산한다. 새 sim 은 0건이며, 점추정만 있고 CI 밴드 없는 claim 은 "robustness gap" 으로 정직하게 분리(d6 — CI 없는 것을 "robust" 로 호도 금지).

```
UQ 보유  =  (점추정에 CI/power/민감도 정량이 sub-V / X3 에 verbatim 기록)
UQ 없음  =  (점추정 단일 — CI/민감도 정량 미산출 → robustness gap → 후속 bootstrap 후보)
```

→ 입력 = LPA V3b (bootstrap 95% CI · 3-way · LOO) + NOREFLOW V3 (power 3건 · Δ36.6pp 점추정 · Cmax) + X3 §3.2 (v8 ICER QALY-horizon 민감도) + X8 (🟢 43 분모) + X14 (VoI 연결).

---

## §2. UQ ledger 마스터 표

> 모든 "CI/민감도(verbatim 출처)" 열은 sub-V / X3 stdout 원문 그대로. "UQ 유무" = 정량 부착 여부. "robustness" = CI/민감도가 방향을 닫는지(d6 정직 — CI 없으면 "점추정 only" 명시).

| # | claim | 점추정 | CI / 민감도 (verbatim 출처) | UQ 유무 | robustness |
|---|---|---|---|---|---|
| **U1** | LPA β_ivw (Lp(a)→CHD MR) | **−0.34134** | bootstrap 95% CI β [−0.3983, −0.2793] · HR CI **[0.671, 0.756]** · N_BOOT=1000 seed=42 (LPA V3b §2.3 results.json) | **✅ 보유** (bootstrap CI) | **🟢 robust** — CI 가 0 미포함(β 상한 −0.2793<0) · Burgess [0.67,0.75] 100% overlap |
| **U2** | LPA HR point (per 1-SD Lp(a)) | **0.7108** | bootstrap 95% CI **[0.671, 0.756]** vs Burgess 0.71 [0.67,0.75] (LPA V3b §3) | **✅ 보유** | **🟢 robust** — 100% overlap |
| **U3** | LPA MR-Egger pleiotropy intercept | z = **−1.494** | α=−0.000719 · SE(α)=0.000481 · p≈0.135 (양측) (LPA V3b §4.1) | **✅ 보유** (intercept test) | **🟢 robust** — z<1.96 → pleiotropy 음성 (IVW unbiased 가정 성립) |
| **U4** | LPA 3-way 일치 (IVW·Egger·WM) | β span **0.0039** | IVW −0.3413 / Egger −0.3452 / WM −0.3451 · 3-way β [−0.3452,−0.3413] (LPA V3b §4) | **✅ 보유** (sensitivity) | **🟢 robust** — span 1.1% of \|β\| · invalid-IV bias 없음 |
| **U5** | LPA leave-one-out robustness | max\|Δβ\| **0.0048** | drop rs10455872 +0.0047 / rs3798220 −0.0003 / KIV-2 −0.0048 (LPA V3b §5) | **✅ 보유** (LOO) | **🟢 robust** — 1.4% of \|β\| · 단일 outlier SNP 없음 |
| **U6** | NOREFLOW Trial-A primary power (n=500·15% rel red) | **0.798** | power(n=250/arm)=0.798 ≈ target 0.80 (Δ=0.002) (NOREFLOW V3.4 §3.1) | **✅ 보유** (power calc) | **🟢 robust** — design adequate (≈0.80 target) |
| **U7** | NOREFLOW Cox 1y MACE power (secondary) | **0.157** | power(n=500, HR=0.75)=0.157 — under-powered (NOREFLOW V3.5 §3.1) | **✅ 보유** (power calc) | **🟠 under-powered** — secondary exploratory 정직 fence (CI 아님) |
| **U8** | NOREFLOW ALDH2*2 subgroup power | **0.654** | power(n=201, 20% effect)=0.654 — exploratory only (NOREFLOW V3.6 §3.1) | **✅ 보유** (power calc) | **🟠 under-powered** — subgroup exploratory 정직 fence |
| **U9** | NOREFLOW IRI Δ (CIRCUS 93.5%→IC-sync 56.9%) | **Δ=36.6 pp** | **점추정 단일 — CI 미산출** (X14 §1.1 S3: "🟢(ODE)·CI 미공개"·X13 S3/H4) | **❌ 없음** | **점추정 only** — ODE 산술 🟢 이나 Δ 90% CI 미산출 → robustness gap |
| **U10** | NOREFLOW Cmax ratio (IC vs IV) | **536×** | model 536× vs M4 cited 30-100× (NOREFLOW V3.7 §3.1 · 17배 magnitude span) | **부분** (point vs cited range) | **🟡 magnitude span** — direction match · CI 아닌 model-boundary 차이 |
| **U11** | DAPTPGX v8 ICER (M8 strategy 재현) | **1yr +96.13M / 5y multiyr +30.74M** | QALY-horizon 민감도: 1yr-only disutility +96M(>WTP) · 표준 multiyr +31M(≈WTP30) (X3 §3.2 v8 VERBATIM) | **✅ 보유** (horizon 민감도) | **🟠→borderline** — horizon 가정에 의존 (가장 큰 민감도 폭 · §4) |
| **U12** | DAPTPGX v8 Δcost (1y) | **+27.40 M** | M8 cited +29.5M · cost side reproduce (X3 §3.2 v8) | **부분** (vs cited) | **🟢 reproduce** — cost side M8 grounded 일치 |
| **U13** | DAPTPGX PM frequency (HW closed-form) | **0.1521** | M1 cited 0.14-0.15 (X3 §2.2) · 독립 cohort HWE 검정 미실시 (X14 §1.2) | **❌ 없음** (cohort CI 없음) | **점추정 only** — closed-form 항등 🟢 이나 cohort 대표성 CI 미산출 |

```
UQ 보유 (CI/power/민감도 정량) = U1~U8, U11 (+ U10·U12 부분)  →  10건
UQ 없음 (점추정 only)         = U9, U13                       →  2건 (robustness gap)
```

---

## §3. CI-밴드 없는 🟢 목록 (robustness gap → 후속 bootstrap 후보)

> 정직 핵심(d6): **🟢 = numerical recompute 재현(산술층 닫힘)이지 "CI 밴드 있음"을 의미하지 않는다.** X8 의 🟢 43 중 bootstrap/CI 정량이 명시 부착된 것은 **LPA V3b 5건(U1~U5)** 뿐이다. 나머지 🟢 는 점추정·power·deterministic recompute 로 산술은 재현되나 **CI 밴드 없음** — "robust" 로 호도하지 않고 후속 bootstrap 후보로 명시.

### 3.1 CI 밴드 있는 🟢 vs 없는 🟢 분리

| 분류 | 해당 claim | CI 정량 | 개수(예시) |
|---|---|---|---|
| **CI 밴드 있는 🟢** (bootstrap percentile) | LPA U1·U2 (β·HR bootstrap 95% CI) + U3 (Egger intercept z-test) + U4 (3-way span) + U5 (LOO) | ✅ 1000-iter percentile + intercept test + sensitivity | **LPA V3b 5건** |
| **CI 밴드 없는 🟢** (점추정/deterministic recompute) | NOREFLOW Δ36.6pp (U9) · DAPTPGX PM 0.1521 (U13) · DAPTPGX HW/phenotype/Markov/PM×HBR closed-form · NOREFLOW Hill/PK/salvage deterministic · LPA V3a/V3c 점추정 등 | ❌ CI 미산출 (점추정 또는 deterministic single-value) | **🟢 43 − 5 = ~38** |
| (참고) power 정량 🟢 | NOREFLOW U6 (power 0.798) | power calc (CI 아닌 검정력) | 1 |

```
🟢 43 (X8 VERBATIM) 의 UQ 분해:
─────────────────────────────────────────────────────────────────────
  bootstrap CI 부착 🟢   ████░░░░░░░░░░░░░░░░░░░░░░░░░░░    5  (LPA V3b · 11.6%)
  CI 밴드 없는 🟢        ████████████████████████░░░░░  ~38  (점추정/deterministic · 88.4%)
─────────────────────────────────────────────────────────────────────
  → 정직: 🟢(numerical 재현) ≠ "CI 밴드로 robust 입증". CI 부착은 LPA bootstrap 만.
```

### 3.2 후속 bootstrap 후보 (robustness gap 우선순위 · X14 VoI 연결)

| 순위 | robustness gap claim | 현 상태 | 후속 정량 | X14 VoI 연결 |
|---|---|---|---|---|
| **1** | **NOREFLOW Δ36.6pp CI** (U9) | 점추정 only (CI 미공개) | **full param sensitivity sweep** (Hill n · Ca threshold · lethal-window τ) → Δ 90% CI | X14 §1.1 ★★★ "Δ full param sensitivity sweep" — 즉시 가능(0m) · sim 즉시 |
| 2 | DAPTPGX ICER PSA (U11) | horizon 점민감도만 | **probabilistic sensitivity analysis** + drug-cost 재모델 | X14 §1.2 ★★★ "PSA + prasugrel 5mg first-line" — 즉시 가능 |
| 3 | DAPTPGX PM 0.1521 cohort CI (U13) | closed-form 점추정 | 독립 한국 cohort genotyping HWE + cohort 간 I² | X14 §1.2 ★★ "독립 cohort HWE 검정" — 데이터 즉시 |

---

## §4. 민감도 가장 큰 claim — v8 ICER QALY-horizon (ASCII)

> 모든 numerical claim 중 **단일 가정 하나에 의해 결론(WTP 진입 여부)이 가장 크게 갈리는 것 = DAPTPGX v8 ICER** (X3 §3.2 VERBATIM). QALY-horizon 가정(사망 disutility 의 life-year crediting)에 따라 **+96M(>WTP) ↔ +31M(≈WTP)** — 절대값 ~3.1배 · WTP30 경계 양쪽으로 분기.

```
DAPTPGX v8 ICER — QALY-horizon 민감도 (X3 §3.2 v8_recompute.hexa VERBATIM)
─────────────────────────────────────────────────────────────────────────────
  WTP 30 (Korea) ─────────────────┐
                                  │
  1yr-only disutility   +96.13M   │█████████████████████████████████  >WTP (보수적)
  (death 1yr-only)                │
                                  │
  표준 multiyr CEA      +30.74M   │██████████  ≈WTP30 ≈ M8 cited +34 (borderline)
  (5y life-year crediting)        │
                                  ▼
  Δcost(1y) reproduce   +27.40M   (M8 +29.5M · cost side 🟢 일치 · horizon 무관)
─────────────────────────────────────────────────────────────────────────────
  민감도 폭 = +96M ↔ +31M  (Δ ≈ 65M · ~3.1배)  ← 전 claim 중 최대 단일-가정 분기
  분기 변수 = 사망 QALY 의 life-year crediting horizon (1yr vs multiyr)
  d6 정직 = cost side(+27~29.5M)는 horizon 무관하게 🟢 reproduce · ICER 절대값만 horizon 의존
```

**비교 — 다른 claim 의 민감도 폭** (왜 ICER 가 최대인가):
- LPA β: bootstrap CI [−0.3983, −0.2793] → 폭 0.119 (점추정의 ~35%) · **방향 불변**(상한<0) → robust
- LPA LOO: max\|Δβ\| 0.0048 (1.4%) → 거의 무영향
- NOREFLOW power: 0.798 vs 0.80 → Δ0.002 → 무시 가능
- **DAPTPGX ICER: +31M ↔ +96M → WTP30 경계를 가정 하나가 넘나듦** → 결론(cost-effective 여부) 자체가 분기 → **최대 민감도**

→ X14 §1.2 ★★★ ("ICER sign 반전이 param 전반서 robust 한가 vs 2 FIX 가정 의존인가" · weakened X13 R7/H3) 와 정합 — 이 horizon 민감도가 **PSA 후속(§3.2 순위 2)** 의 직접 동기.

---

## §5. X14 VoI 연결 — UQ gap ↔ value-of-information

> robustness gap(CI 없는 점추정)은 X14 known-unknown 의 "측정하면 닫히는 것" 과 직결. 단, **X14 의 최고 VoI 는 인과층(IC-sync IIT · HORIZON)** 이지 산술 CI 가 아니다 — UQ gap 은 산술/해석층 강화이고, 인과 ground-truth 는 별도 외부 RCT 영역(d6).

| UQ gap (X27) | 대응 X14 VoI 측정 | X14 우선순위 | timeline | 분기되는 것 |
|---|---|---|---|---|
| NOREFLOW Δ36.6pp CI 없음 (U9) | Δ full param sensitivity sweep → 90% CI | ★★★ | 즉시(0m) | CI 하한>0 → 방향 robust(🟢 유지) · ≤0 → weakened |
| DAPTPGX ICER horizon 민감도 (U11) | ICER PSA + drug-cost 재모델 | ★★★ | 즉시(0m) | sign 반전 robust → 방향 🟢 정당 · FIX 의존 → 🟠/🔴 강등 |
| DAPTPGX PM 0.1521 cohort CI 없음 (U13) | 독립 cohort HWE 검정 + I² | ★★ | 데이터 즉시 | HWE 일치 → 대표성 확인 · deviation → 단일 cohort 대표성 약화(산술 🟢 유지) |
| LPA β CI 있음 but 인과 미검증 (U1) | HORIZON pelacarsen readout | ★★★★★ | 2026 H1 | Lp(a)↓→MACE↓ → 인과 확인 · 무효 → 인과 라벨 🔴 (β 산술 🟢 유지) |

**honest 핵심 (d6 · X14 §5 정합)**: U1~U5 의 LPA bootstrap CI 는 **산술/통계층**을 닫는다(β 가 0 으로부터 유의). 그러나 이는 "Lp(a)→CHD **인과**" 를 증명하지 않는다 — 인과는 X14 §1.4 의 weakened (X13 R3/H2) 로, HORIZON readout(★★★★★)이 ground truth. 즉 **CI 부착(U1) ≠ 인과 확정**. CI 없는 🟢(U9·U13)는 산술 CI 후속(즉시 가능)으로 강화하되, 어느 쪽도 인과 over-read 를 닫지 못한다(X14 §5 "산술층은 닫혔고 known-unknown 은 전부 인과/해석층").

---

## §6. g5 grade — X27 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §2 UQ ledger 마스터 표 | 🟡 (compositional) | CI/민감도 전부 LPA V3b / NOREFLOW V3 / X3 §3.2 VERBATIM 수집 — X27 새 정량 0건 |
| §3 CI 있는/없는 🟢 분리 | 🟢 | 🟢 43(X8 VERBATIM) − LPA V3b 5(bootstrap) = ~38 산술 분해 (재현 가능) |
| §4 민감도 최대 claim | 🟡 | v8 ICER +96/+31 X3 §3.2 VERBATIM · 민감도 폭 비교는 점추정 산술 |
| §5 X14 VoI 연결 | 🟡 | X14 §1·§5 우선순위/timeline VERBATIM carry |
| §6 X27 자체 grade | 🟡 (compositional) | sub-V/X3/X8/X14 VERBATIM 집계 — 새 판정/sim 0건 |

**X27 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — 모든 CI/민감도/grade 는 LPA V3b · NOREFLOW V3 · X3 §3.2 · X8 · X14 VERBATIM 집계. **새 sim / hexa verify / 판정 0건** (per @D g5). **d6 준수**: CI 없는 🟢(U9·U13)를 "robust" 로 호도하지 않고 "점추정 only · robustness gap" 으로 정직 분리 · 민감도 최대 claim(ICER)의 horizon 의존을 명시. **d1**: completed-form.

⚠ **honest 핵심**: X8 🟢 43 중 **bootstrap CI 가 명시 부착된 것은 LPA V3b 5건뿐**이고, 나머지 ~38건은 deterministic recompute / 점추정 / power 로 산술은 재현되나 CI 밴드가 없다. 🟢(numerical 재현)을 "CI 로 robust 입증" 과 혼동하지 않는 것이 본 ledger 의 정직한 출발점이다. 단일-가정 민감도가 가장 큰 claim 은 v8 ICER(+96M↔+31M · WTP30 경계 분기)이며, 후속 bootstrap 1순위는 NOREFLOW Δ36.6pp CI(X14 ★★★ · 즉시 가능)다.

---

## §7. X27 산출 요약

- **UQ ledger 13건** (U1~U13): UQ 보유 10건(LPA bootstrap 5 + NOREFLOW power 3 + ICER horizon 1 + cost reproduce 1) · UQ 없음 2건(Δ36.6pp CI · PM cohort CI = robustness gap)
- **CI 밴드 있는 🟢 = 5건** (LPA V3b — β/HR bootstrap 95% CI + Egger z + 3-way + LOO) vs **CI 밴드 없는 🟢 = ~38건** (🟢 43 − 5 · 점추정/deterministic recompute). → 🟢 = numerical 재현이지 CI robust 입증 아님(d6)
- **민감도 가장 큰 claim** = **DAPTPGX v8 ICER** (X3 §3.2) — QALY-horizon 가정에 따라 **1yr-only +96.13M(>WTP) ↔ 표준 multiyr +30.74M(≈WTP30)**, 폭 ~3.1배로 WTP30 경계를 단일 가정이 넘나듦. cost side(+27.40M)는 horizon 무관 🟢 reproduce
- **후속 bootstrap 1순위** = **NOREFLOW Δ36.6pp full param sensitivity sweep → Δ 90% CI** (X14 §1.1 ★★★ · 즉시 가능 0m) — IRI 핵심 claim 의 유일한 CI 미산출 점추정
- **X14 VoI 연결**: 산술 CI gap(즉시 가능)은 산술/해석층 강화 · 인과 ground-truth(HORIZON ★★★★★ · IC-sync IIT)는 별도 외부 RCT — CI 부착(LPA U1)이 인과 확정을 의미하지 않음(X14 §5 정합)
- **g5/d6 준수**: 모든 정량 sub-V/X3/X8 VERBATIM · 새 sim 0건 · CI 없는 것을 robust 로 호도 0건 · 측정 전 분기 미단정

→ **다음 단계**: 본 X27 = X10 PAPER 의 robustness/limitations 섹션 + X7 DOCTOR feed 의 "불확실성 정직 공개" 입력. robustness gap 2건(Δ36.6pp CI · PM cohort CI)은 즉시 가능 후속 sim 으로 X8 강한 근거의 CI 부착 escalation 과 직결.
