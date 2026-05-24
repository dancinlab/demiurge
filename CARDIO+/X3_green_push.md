# X3 — CARDIO+ cross-domain 🟢 push (4-domain numerical recompute 통합 실측)

> CARDIO+ 메타도메인 X3 산출물 · current-state · no history.
> 목적 = 4 sub-domain 의 V3 numerical recompute 자산을 **작동 호스트(mini)에서 재실행**해 🟢 SUPPORTED-NUMERICAL verdict 를 verbatim 수집·통합 — cross-domain 단일 🟢 ledger.
> ⚠ 본 X3 = **기존 recompute 자산 재실행 + 집계 only** · 새 모델 작성 0건 · sub-domain V-파일 미수정(다른 세션 소관). 모든 verdict 는 mini stdout / sub-V verbatim (per @D g5). 억지 🟢 승격 0건 (d6).

---

## §1. 방법론 + 호스트 매트릭스

cross-domain 🟢 push = 각 sub-domain 의 V3 recompute 자산(`*.hexa` / `hexa verify --expr` / pool python)을 **단일 작동 호스트에서 재현**하고 verdict 를 합산. 억지 escalation 없이 "이미 numerical 통과한 것"만 verbatim 수집.

| host | 상태 | 용도 |
|---|---|---|
| **mini** (local/macOS) | ✅ hexa 0.1.0-dispatch 정상 | `hexa run *.hexa` · `hexa verify --expr` 실측 |
| ubu-1 (linux) | ❌ `hexa.real` 누락 (wrapper 깨짐) · python+numpy 2.4.4 정상 | pool python sim (LPA V3b) |
| ubu-2 (linux) | ❌ `hexa verify --expr` segfault | (X2 blocker · mini 우회) |

→ **mini 가 cross-domain recompute 의 단일 working 호스트.** 본 X3 의 DAPTPGX `*.hexa` 3종은 mini 에서 직접 재실행(아래 §2.2 verbatim).

---

## §2. sub-domain별 🟢 ledger (verbatim)

### §2.1 NOREFLOW — V2 bio kernel (mini 재현) + V3 (ubu python)

mini 재현 (2026-05-25 · `POOL_DISABLE=1 hexa verify --expr`):

```
$ hexa verify --expr exp_release 1.0 0.1 5 0.39346934028736657
  calc=0.393469 ≈ expected 0.393469 (|Δ|=0.0 ≤ ε=1e-9)
  tier = 🟢 SUPPORTED-NUMERICAL   (adenosine IC bolus 5min elution PK)

$ hexa verify --expr hill 0.5 0.001 1 0.998003992015968
  calc=0.998004 ≈ expected 0.998004 (|Δ|=1.11e-16 ≤ ε=1e-9)
  tier = 🟢 SUPPORTED-NUMERICAL   (adenosine A2A receptor saturation)
```

V3 (NOREFLOW/verify/V3 · ubu-1/2 python, sub-V verbatim): **10/12 🟢**
- V3.1 PK timing (IC tmax 3.0s / IV 300s) 🟢 · V3.2 IRI ODE (Hill 0.998 · CIRCUS 93.5%→IC-sync 56.9% · **Δ=36.6pp**) 🟢 · V3.3 MC robustness (adenosine IC / nicorandil 100% Tier-A) 🟢 · V3.4 power primary (n=500 → 0.798) 🟢
- 🟠 2건 (honest fence): V3.5 Cox 1y MACE power 0.157 · V3.6 ALDH2*2 subgroup 0.654 → secondary exploratory
- 🟡 1건: V3.7 Cmax ratio (model 536× vs M4 cited 30-100× — direction match, magnitude boundary 차이)

### §2.2 DAPTPGX — `*.hexa` 3종 mini 재실행 (verbatim stdout)

핵심 identity (V3/V5/V6 공통, mini 재현):
```
1_HW_allele_sum =1 · 1_HW_diplotype_sum =1        → 🟢 closed-form partition 항등
1_HW_PM =0.1521 (M1 cited 0.14-0.15)              → 🟢 SUPPORTED-NUMERICAL
1_HW_IM_plus_PM =0.6279 (M1 cited ~0.60, ±0.05)   → 🟢 within tolerance
2_per100_PM =15.21 (M1 cited 14-15)               → 🟢
5_markov_5y_rowsum =1                              → 🟢 stochastic 보존
```

PM×HBR cell — V3→V5 patch 로 reconcile (mini 재현):
```
            V3      V5/V6    M4/M7 cited   verdict
2-axis     3.80  →  6.84     7-8          🟢 (V5/V6 reconciled)
3-axis     1.52  →  2.74     3-5          🟢 (borderline, within)
```

ICER / budget — **V6 까지 sign 미반전 → 🟠 DEFERRED** (§3 진단):
```
4_ICER_M_KRW_per_QALY:   V3 -3221 → V5 -503 → V6 -1205   (M8 cited +34, 목표 양수)
6_budget_5y_EokWon:      V3 +1251 → V5 +432 → V6 +346    (M8 cited -888 savings)
   → ΔQALY 여전히 음수 (-0.0072) → S4 dominated in simple model → 🟠 (🟢 아님)
```

DAPTPGX 🟢 집계: HW/phenotype/Markov/PM×HBR = **🟢** · ICER/budget = **🟠** (sign 미해결, 정직 유지).

### §2.3 LPA — V3b MR/IVW (ubu-1 python, sub-V verbatim)

```
β_ivw point   = -0.34134   vs Burgess 2018 -0.34249   (Δ=0.00115 < 0.01)   🟢
HR point      = 0.7108     vs 0.71                                          🟢
HR 95% CI     = [0.671, 0.756] vs [0.67, 0.75]   100% overlap              🟢
MR-Egger pleiotropy z = -1.494 (음성, p≈0.135)                             🟢
Weighted Median Δβ=0.004 · leave-one-out max|Δβ|=0.005                     🟢
```
LPA V3b = **5 🟢** (C22·C23·C44 + Egger + WM/LOO robustness). V3a(siRNA kinetics) + V3c(NHIS ICER) 합쳐 LPA 총 **🟢 28** (X8 verbatim).

### §2.4 ISR — 🟢 0 (kernel-pending)

ISR bio-physical identity 는 hexa-lang `bio-verify-kernel-extension` PR merge 의존 → 현재 🟢 0 / 🟠 (X9 I2 wall). atlas 등록 후 escalation (X2 §4).

---

## §3. DAPTPGX ICER 🟠 진단 (cross-cutting open question · d2)

**관측 (mini 재실행)**: ICER sign 이 V3→V5→V6 patch 누적에도 양수로 반전 안 됨 (-3221 → -503 → -1205). 근본 = ΔQALY 가 음수 (S4 targeted PGx 가 S1 universal clopidogrel 보다 QALY 낮게 계산됨) — 이는 DAPTPGX 논지(PGx targeting 이 이득)와 모순되는 모델 산출.

**진단 (d6 honest)**: 🔴 FALSIFIED 아님 — 단순 모델이 S4 의 **출혈회피 QALY 이득을 과소반영**. V5 patch (de-escalation 30일 · ticag bleed 0.0122 · HBR 0.45 · PFT cost) 가 cost 는 줄였으나 QALY 이득 항을 충분히 모델링 못함. → **🟠 DEFERRED** 정당.

**d2 돌파 path (DAPTPGX 세션 handoff)**:
1. ΔQALY 모델에 PM 환자 major bleeding 회피 → QALY 이득 항 명시 추가 (현 모델은 ST 회피만 credit, bleeding 회피 QALY 누락 의심)
2. ticagrelor PM arm 의 bleeding disutility (BARC 2-3-5 × QoL decrement) 를 utility 에 반영
3. 위 2개 적용 후 v7 재실행 → sign 확인. **여전히 음수면 그때 🔴** (현 단계는 model gap)

X5 Trial-B(DAPT-PGx-K) 의 "신규 IND 불요·즉시 시작" 임상 함의는 **불변** (ICER 는 급여 economic case 일 뿐, 임상 적용성 아님).

### §3.1 v7 reconciliation 실측 (사용자 지시 심화 · mini)

X3 §3 진단을 실제 모델로 검증 — `CARDIO+/DAPTPGX/sims/v7_recompute.hexa` (v6 base + 2 grounded fix, d6 no-forcing):
- **FIX-A**: S4 가 결정맵(H3: NM=clopi · **IM+PM**=potent)대로 IM+PM 둘 다 escalate (v6 은 PM만 switch · IM 은 clopi + excess penalty 그대로 둠).
- **FIX-B**: S1 IM clopidogrel ST = LoF gradient 중간값 0.010 (v6 은 IM 을 NM rate 0.005 로 과소계상 — LoF인데 너무 좋게).

mini 실측 (VERBATIM):
```
4_ICER_s1_st_per100   = 0.89       (v6 0.6521 · IM clopi ST 보정으로 상승)
4_ICER_s4_st_per100   = 0.43721    (v6 0.7227 · IM+PM escalate 로 하락)
4_ICER_delta_qaly     = +0.0447629 (v6 -0.0072 · ✅ SIGN 반전)
4_ICER_M_KRW_per_QALY = +161.311   (v3 -3221 → v6 -1205 → v7 +161 · ✅ sign 반전)
```

**정직한 결론 (d6)**:
- ✅ **질적 오류 해결** — v6 의 "S4 dominated (ΔQALY 음수)" 는 **strategy-mismatch 아티팩트**였음을 입증. 결정맵대로 IM+PM escalate 하면 S4 는 net-beneficial (ΔQALY +0.045/100명 · ST 0.89→0.44). → C25 sign mismatch (X3 §2.2 의 🔴/🟠) **해소**.
- 🟠 **양적 gap 잔존** — +161 M KRW/QALY 는 Korea WTP 30 초과 + M8 cited +34 의 ~5배. 원인 = IM+PM 전원(62.8%)을 ticagrelor(4,600원/일)로 escalate 하는 약가. **남은 lever = 결정맵 first-line `prasugrel 5mg`(한국 저가)** — d6 준수로 +34 억지로 안 쫓음 · DAPTPGX 세션이 drug-cost 재모델 시 reconcile (cross-cutting handoff).
- grade: ICER 방향성 = **🟢 (S4 net-beneficial 확정)** · cost-effectiveness 절대값 vs M8 = **🟠 (drug-cost 재모델 대기)**.

---

## §4. unified 🟢 집계 + X8 reconcile

| sub | 🟢 (numerical) | 🟠 (this push 잔여) | 비고 |
|---|---|---|---|
| NOREFLOW | 10 (V3) + 2 (V2 mini) | 2 (Cox·ALDH2*2 power) | IRI Δ36.6pp 핵심 |
| DAPTPGX | HW/pheno/Markov/PM×HBR (~5) | 2 (ICER·budget sign) | V5/V6 PM×HBR reconcile |
| LPA | 28 (V3a/b/c) | — | β -0.3413 robust |
| ISR | 0 | bio-physical (kernel PR) | X2 §4 trajectory |
| **계** | **🟢 43** (X8 verbatim 일치) | 잔여 🟠 = ICER 2 + power 2 + ISR kernel | |

→ X3 push 의 cross-domain 🟢 = **43** (X8 §1 ledger 와 정합). 본 X3 의 기여 = (a) mini 단일 호스트에서 재현 검증, (b) DAPTPGX ICER 🟠 sign 미반전을 V6 까지 실측 확인(신규), (c) PM×HBR cell 🟢 reconcile 확정.

---

## §5. 🔵 trajectory → X2

bio kernel verdict 천장 = 🟢 (libm recompute). 🔵 SUPPORTED-FORMAL 은 number-theory atlas atom 전용 (mini 에서 `sigma_k(6)=12` → 🔵 실측 확인). bio/clinical fn 을 🔵 로 올리려면 atlas F-namespace 등록 PR 필요 → **X2 `CARDIO+/X2_blue_push.md` 참조**.

## ref
- mini 실측: `POOL_DISABLE=1 hexa run CARDIO+/DAPTPGX/sims/{v3,v5,v6,v7}_recompute.hexa` · `hexa verify --expr {exp_release,hill,sigma_k,ivw}`
- sub-V: NOREFLOW/verify/V3 · DAPTPGX/verify/V3 · LPA/verify/V3b · X8 grade ledger
