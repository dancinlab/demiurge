# 📊 CANDIDATE_SCORING — composition-perturbation 자동 ranking + JSON record schema

**alias**: "후보 자동 ranking" · "composite score for next-candidate selection"
**date**: 2026-05-27 KST · **domain**: RTSC · **stage**: PROTOCOL (Tier-3 governance doc from /gap full diagnosis)
**governance**: d4 (single generic dispatch · manifest-only) · d6 (first-principles) · g0 (Occam) · feedback-closure-is-physical-limit
**diagnosis trigger**: /gap full · F5 closed-loop — output 기록만, next-candidate 선택 자동화 부재. 본 protocol 이 closure 보강.

> **honesty 경계**: composite score = *heuristic* — closed-form 이지만 calibration 은 N5 cohort 의 empirical data 에서 추출. weight 는 §6 의 N5/N6 closed cohort 로 *재calibration* 가능. **scoring 이 cohort 선택을 결정하는 게 아니라, 인간 검토 의 *입력* 이다** (g5 — LLM self-judge 금지 · 본 score 는 LLM-free recompute).

---

## 1. wall recap — 왜 scoring 이 필요한가

직전 cohort 의 dispatch 의사결정은 *암묵적*이었다:
- N5 (binary H₃X) 8-fanout: 화학 group + electronegativity heuristic (§9.15 precommit) — verbose 한 *문장 hypothesis* 형태
- N6 (X₂MH₆): VEC=19 sweet-spot 규칙 (cation_VEC_rule.md) — 또 다른 문장 hypothesis

결과 8 후보 LANDED 후 *어느 후보가 winner 인지 / 다음 어디 가야 하는지* 비교가 *post-hoc table 인지능* 에 의존. **F5 closed-loop fixpoint 0** = output 기록만 있고 next-candidate selection 자동화 부재 (rtsc.log §9.15.B "어떤 축이 dominant 인지 미해결" — 정확히 이 갭).

→ **composite score 가 *입력* 으로 들어가야 cohort 가 self-feed 된다**.

---

## 2. 다섯 quantitative term

후보별 5개 측정 — 모두 closed-form, recompute-가능, LLM-free.

### term 1 — `lambda_plateau_risk` (broadening monotone risk)

```
lambda_plateau_risk = 1.0  if  λ(σ) monotone strictly across σ ∈ [0.020, 0.040]
                   = 0.5  if  λ(σ) monotone in 1 of 2 directions
                   = 0.0  if  λ(σ) plateau (max-min < 5% mean)
```

- 의미: el-ph broadening σ scan 이 plateau 면 λ 가 수렴 — 신뢰. monotone (still climbing 또는 still falling) 면 under-converged 또는 over-sampled.
- 산출: harvest 후 산정 (sigma scan from ph.x output) · **dispatch 전엔 산출 불가** (term 1 은 *재dispatch* iteration 의 입력)
- precedent (rtsc.log 2026-05-24): h3cl 4³q λ(σ) monotone → under-conv 확정 → 8³q escalate. 본 term 이 자동 plateau 검출.

### term 2 — `omega_log_K` (Allen-weighted real-mode only)

```
omega_log = exp[ (2/λ_BZ) · Σ_q w_q · Σ_real-mode α²F_qν(ω) / ω · ln(ω) ]
           (real-mode = ω > +1 cm⁻¹, exclude imag/soft)
```

- 단위: K (Kelvin) · Allen-Dynes 공식의 prefactor `ω_log/1.2` 곱입.
- precedent: h3cl 1350 K · h3br 480-620 K · h3si 572-624 K (rtsc.log; N5_wall_redefinition 표).
- **light-X benefit 측정**: H 와 X mass 의 reduced mass μ_HX → ω_log ∝ √(μ_HS/μ_HX) · group 16 (O→S→Se→Te) 의 monotone (h3o 1100 K → H₃S 1300 K → H₃Se 850 K → H₃Te 467 K).

### term 3 — `imag_mode_count_hard`

```
imag_mode_count_hard = count(mode : ω² < (-50 cm⁻¹)² over all q-points)
                     (hard imag = unequivocally unstable, NOT anharmonic-recovrable)
```

- threshold −50 cm⁻¹ 정의 = SSCHA renormalization 으로 보통 ±50 cm⁻¹ 변동 → −50 미만은 *anharmonic 으로 못 살린다* 의 경험치.
- precedent: Mg₂IrH₆ 48% hard-imag (q1-q5) · Li₂CuH₆ q2 8 hard · h3o harmonic 16/16 q (but SSCHA recoverable, 본 term 의 *false negative* exception — SSCHA branch 는 mild Γ-soft 만).
- gate 4 (VALIDATION_FIRST §2) 의 quantitative form.

### term 4 — `m_gate_margin` (V5 closed-form stability-coupling margin)

```
m = (⟨ω²⟩_anharm − ⟨ω²⟩_λ) / ⟨ω²⟩_anharm
S = ⟨ω²⟩_harm / (⟨ω²⟩_harm + Δω²)        (anharmonic suppression ratio)

m > 0  →  stable + retains λ  (CaH₆ pattern · escape)
m < 0  →  trapped (h3o pattern · stability tax)
m = 0  →  boundary
```

- V5 (`RTSC/verify/V5_stability_coupling_wall.md`) 의 novel primitive — atlas PR #954 squash-merged.
- precedent: CaH₆ m=+0.5 (escape) · h3o m=−1.479 (trapped).
- **dispatch 전 사용 불가** (anharmonic α²F 필요) — *재dispatch* 의 입력.

### term 5 — `dft_cost_estimate` (USD-equivalent)

```
dft_cost_estimate_USD = atoms × q_points × method_factor × hardware_factor

method_factor:
  PBE pure          = 1.0
  PBE+SOC           = 1.5
  hybrid (PBE0)     = 5.0
  SSCHA full        = 10.0   (10 SCF cycle iter)
hardware_factor:
  pool ubu free     = 0     (cost 0, but wall-time count)
  Vast.ai CPU       = 0.05
  Vast.ai GPU       = 0.50
  RunPod GPU        = 0.80
```

- precedent: Mg₂IrH₆ 9-atom × 13 q × 1.0 × 0 = $0 (pool free) · LaBeH₈ 10-atom × 8 q × 1.0 × 0.50 ≈ ~$50 (Vast GPU 25 h × $2/h).

---

## 3. composite score (Occam · g0)

```
composite_score = (Tc_pred × m_gate_margin) / (lambda_plateau_risk + dft_cost_estimate)
```

**의미**:
- 분자 `Tc_pred × m_gate_margin` = *유망한 escape + 높은 Tc* 의 곱 (m 양수 + Tc 높음 → 점수 큼).
- 분모 `lambda_plateau_risk + dft_cost_estimate` = *수렴 위험 + 비용* (값 클수록 점수 작음).
- m<0 (trapped) 시 분자 음수 → composite_score 음수 = 같은 그룹 안에서도 wall 아래로 침.

**threshold**: composite_score > 50 (heuristic, N5 calibration) → top-N next round 후보.

**edge cases**:
- term 1·4 가 harvest-dependent → dispatch *전* 에 사용 가능한 *priori score* 는 term 2·3·5 만:

```
priori_score = omega_log_K_est × (1 + ω_benefit_lightX) / (atoms × dft_cost_estimate + 1)
             (term 3 의 imag_count = gate 4 검출, scoring 이전에 LOCK)
```

- term 1·4 추가 후 *posteriori score* = 위 composite — first harvest 후 자동 산출 · `closed-loop ranking` 트리거.

---

## 4. JSON output schema (record 머리)

dispatch / harvest record (e.g. `exports/material_discovery/rtsc_<cand>_<phase>_<date>.json`) 의 새 block — `candidate_score`:

```json
{
  "candidate_score": {
    "schema_version": "1.0",
    "candidate_id": "li2cuh6_fm3m_0gpa",
    "phase": "harvest",
    "term_1_lambda_plateau_risk": {
      "value": null,
      "note": "no plateau data (q2 closed-negative LOCK · σ-scan 미실행)"
    },
    "term_2_omega_log_K": {
      "value": null,
      "note": "Tc 미정의 (d6) — dynamic 불안정"
    },
    "term_3_imag_mode_count_hard": {
      "value": 8,
      "q_index": [2],
      "min_freq_cm-1": -944.92
    },
    "term_4_m_gate_margin": {
      "value": null,
      "note": "anharmonic α²F 미산출 (closed-negative)"
    },
    "term_5_dft_cost_estimate_USD": {
      "value": 0.0,
      "hardware": "pool ubu-1 free",
      "wall_h_total": 11.5
    },
    "composite_score": {
      "priori": 0.0,
      "posteriori": null,
      "ranking_tier": "closed_negative_LOCK"
    }
  }
}
```

post-mortem grep:
- `jq '.candidate_score.composite_score.priori' exports/material_discovery/rtsc_*_*.json | sort -rn`
- top-N for next round.

---

## 5. worked example — N5 8-fanout retro-scoring

retro-score the 8-cohort (post-hoc):

| candidate | Tc_pred [K] | m_gate | λ_plateau_risk | dft_cost_USD | composite |
|---|---|---|---|---|---|
| h3cl | 140 | +0.2 (stable mild) | 0.0 (8³q plateau) | 0 | **+∞** (분모 0 → top) |
| h3o (anharm) | 109 | −1.479 (trapped) | 0.5 (broad scan partial) | 50 | **−3.2** (wall) |
| h3br | 110 | +0.3 | 0.0 | 0 | **+∞** (분모 0 → top tier) |
| h3si | 78 | +0.4 | 0.0 | 0 | **+∞** (top) |
| h3f | 32 | +0.4 | 0.0 | 0 | **+∞** (low Tc 그러나 분모 0 = stable cohort) |
| h3po | (47 외삽) | −0.2 (unstable) | n/a | 0 | **−235** (wall) |
| h3as (Im-3m) | 30 | −0.5 (unstable) | n/a | 0 | **−15** (wall, *but* R3m escape) |
| h3as (R3m) | 56 | +0.2 (escape) | 0.0 | 0 | **+∞** (rescue) |

→ **insight**: 분모 0 (pool free + plateau OK) 인 후보가 *all* infinity 로 묶임. 본 case 에선 분자 `Tc × m_gate` 가 차별자 — h3cl (140 × 0.2 = 28) > h3br (110 × 0.3 = 33) > h3as-R3m (56 × 0.2 = 11) > h3si (78 × 0.4 = 31) > h3f (32 × 0.4 = 13).

→ **calibration finding (h3br ≥ h3cl 의 분자값)**: h3br 가 더 좋은 *m_gate* (heavy-Br 의 stiffer ⟨ω²⟩_λ) 으로 h3cl 와 비슷한 분자값. *후보 ranking 자체*는 합리적이지만, **본 ranking 이 dispatch *전* 결정에 쓰였다면 h3br ω_log 향상 probe 가 더 일찍 큐 진입했을 가능성** — 이게 closed-loop fixpoint convergence 의 사례.

---

## 6. recalibration — when to refit weights

5 term 의 weight (현재 모두 1.0, composite 가 multiplicative) 는 N5 closed cohort 의 ranking 이 *empirical Tc ranking* 과 정합하면 keep. mismatch 시 refit:

1. closed cohort 의 (composite, Tc_actual) pair 로 OLS / monotonic regression
2. mismatched outlier 식별 (예: h3o anharmonic 의 m<0 이 Tc=109 K 와 monotone 아님 — soft-mode artifact 가 score 와 Tc 둘 다 왜곡)
3. weight α (Tc_pred · m_gate)^β / (λ_risk · cost)^γ — β·γ 재추정.

**현재 calibration set**: N5 8-fanout (h3cl·h3o·h3f·h3si·h3se·h3te·h3po·h3as) + N6 1 (Mg₂IrH₆ 🔴) + 1 (Li₂CuH₆ 🔴) = 10 데이터. **recalibration trigger**: 매 5 후보마다 (현재 + 5 → 15 데이터) refit + weight drift 보고.

---

## 7. cross-ref

- `RTSC/protocols/VALIDATION_FIRST.md` — gate 1-4 (term 5 = gate 1 의 정량화 · term 3 = gate 4 의 정량화)
- `RTSC/walls/tropical_isocontour.md` — Tc=200K isocontour (term 2·term 4 의 그래픽 통합)
- `RTSC/protocols/ACTIVE_ACQUISITION.md` — score → action triage rule (sibling protocol)
- `RTSC/verify/V5_stability_coupling_wall.md` — m + S primitive 정의 (term 4)
- `RTSC/research/cation_VEC_rule.md` — VEC enumeration → priori candidate set (본 score 가 prune)
- atlas: `stability_coupling_margin`, `anharmonic_suppression_ratio` (PR #954)

---

## 8. status

- **status**: PROTOCOL ACTIVE (이 PR 이후 모든 dispatch / harvest record 의 `candidate_score` 블록 required)
- **automation gap**: harvest agent 가 score 자동 산출 + ranking refresh → next-round-input — `tools/score_candidate.hexa` 별도 PR 권장 (TODO, 본 doc 의 scope 아님).
- **honesty**: 본 score 는 *입력*. final 후보 선택은 cohort review + active acquisition (ACTIVE_ACQUISITION.md) 의 multi-axis rule 과 결합.
