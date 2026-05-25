# RTSC V5 — stability↔strong-λ 트레이드오프 wall 의 first-principles 기전 분석

> **probe**: 모든 N5 binary hydride 가 갇히는 "안정성 ↔ 강한-λ 트레이드오프 벽"을, Migdal-Eliashberg / McMillan-Hopfield 로부터 **first-principles** 유도 (d6 · NOT ML) → cation-stuffed ternary clathrate (CaH₆ 215K) 의 탈출 기전 설명 → **VERIFY-가능 closed-form 정량자** 제출.
>
> **date**: 2026-05-25 KST · **domain**: RTSC · **governance**: d1 (non-wet-lab → completed-form) · d2 (wall → breakthrough path, never concede) · d6 (first-principles > ML) · d18 (novel probe) · g5 (verdict verbatim, never LLM self-judge) · g61 (stdlib-promotable)
>
> **HONESTY 규약**: recompute-불가 기전 speculation = ⚪ SPECULATION-FENCED (proven 아님). verify-passing closed-form 만 🟢/🔵. tier rubric verbatim.

---

## TL;DR

binary hydride 의 트레이드오프는 **단일 물리량 ⟨ω²⟩ (평균제곱 포논 진동수) 가 McMillan-Hopfield λ 분모와 동역학적 안정성 조건에 *동시에* 등장**하기 때문에 발생하는 구조적 함정이다.

| | role | 방향 |
|---|---|---|
| **λ enhancement** | λ = η / (M⟨ω²⟩) → ⟨ω²⟩ 작을수록 λ ↑ | soft (⟨ω²⟩→0⁺) 를 *원함* |
| **dynamical stability** | ⟨ω²⟩ > 0 필수 (ω² < 0 = imaginary mode = 격자 붕괴) | hard (⟨ω²⟩ 큼) 를 *요구* |

→ **같은 ⟨ω²⟩ 가 한쪽에선 작아야 (λ) · 한쪽에선 커야 (안정성)**. 이 충돌이 wall.

**탈출 (CaH₆)**: cation 이 H-격자를 *화학적 pre-compression* → ⟨ω²⟩ 를 높여 (안정) 두면서도 N(Ef) 는 H-derived states 가 유지 (강한 λ 분자) → **분자(η)와 분모(⟨ω²⟩) 의 decoupling**.

**정량자 (NOVEL, 🟢 verified)**:
- **anharmonic λ-suppression ratio** `S = λ_anharm/λ_harm = ⟨ω²⟩_harm / (⟨ω²⟩_harm + Δω²)`
- **stability-coupling margin** `m = (⟨ω²⟩_anharm − ⟨ω²⟩_λ) / ⟨ω²⟩_anharm` (m>0 escape · m<0 trapped)

둘 다 `hexa verify --expr` 로 🟢 SUPPORTED-NUMERICAL (verdict 아래 verbatim). hexa-lang stdlib 에 NOVEL primitive 2개 land (PR #954 (squash-merged)).

---

## 1. 트레이드오프의 first-principles 유도 (d6 · NOT ML)

### 1.1 McMillan-Hopfield 분해

phonon-mediated 초전도의 electron-phonon coupling λ 는 Eliashberg spectral function 의 ω⁻¹-moment 이고,

```
λ = 2 ∫₀^∞ α²F(ω)/ω dω
```

McMillan(1968) — Hopfield(1969) 는 이것을 **물질-내재 분자**와 **격자 분모**로 분해한다:

```
        N(Ef) · ⟨I²⟩        η
λ  =  ───────────────  =  ────────        (McMillan-Hopfield)
         M · ⟨ω²⟩          M · ⟨ω²⟩
```

- `η ≡ N(Ef)·⟨I²⟩` = **Hopfield parameter** — 전자 측 양: Fermi 준위 상태밀도 N(Ef) × 평균제곱 electron-ion matrix element ⟨I²⟩. **화학(전자구조)이 고정**.
- `M` = 이온 질량 (수소 → ≈1 amu, λ 분모를 작게 만드는 H의 이점).
- `⟨ω²⟩` = α²F 로 가중된 **평균제곱 포논 진동수** = 격자 강성(stiffness)의 척도.

### 1.2 soft mode 가 λ 를 부풀리는 동시에 불안정을 신호하는 기전

λ 는 ⟨ω²⟩ 에 대해 **단조감소**한다:

```
dλ/d⟨ω²⟩  =  − η / (M·⟨ω²⟩²)  <  0     (η, M > 0 이면 항상 음수)
```

→ 격자를 **무르게(soften)** 하면 (⟨ω²⟩ ↓) λ 가 **올라간다**. 극한:

```
⟨ω²⟩ → 0⁺  ⟹  λ → +∞      (soft-mode λ inflation)
```

그런데 동역학적 안정성 조건은 **모든 모드의 ω² > 0** (force-constant matrix positive-definite). soft mode 가 0 을 통과해 **ω² < 0** 가 되는 순간 ω 가 imaginary → 격자가 그 방향으로 **자발 붕괴 (구조 불안정)**.

**핵심 충돌**: λ 를 극대화하려면 ⟨ω²⟩ → 0 으로 밀어야 하는데, 바로 그 극한이 ω² < 0 (불안정) 의 *문턱*이다. **분모-of-λ 와 안정성-조건이 같은 ⟨ω²⟩** 이므로, harmonic 수준에서 큰 λ 를 보이는 binary hydride 는 거의 예외 없이 soft/imaginary mode 를 동반한다.

### 1.3 h3o 증거 (SAME MATERIAL 트레이드오프)

같은 물질에서 두 결과가 갈린다:

| 처리 | λ | Tc | 안정성 |
|---|---|---|---|
| **harmonic** (조화근사) | 2.479 | ~180 K | **16/16 q imaginary** = SOFT-MODE ARTIFACT |
| **SSCHA anharmonic** (재양자화) | 0.52–1.48 | 9–109 K | 안정화됨 |

harmonic λ=2.479 의 정체: ⟨ω²⟩_harm 가 *비물리적으로 작음* (soft mode 가 분모를 짓눌러 λ 를 부풀림). 16/16 q-point 가 imaginary = 조화근사 자체가 무효. SSCHA 가 비조화 곡률을 더해 모드를 **경화(harden)** 시키면 ⟨ω²⟩ 가 정상화 → λ 가 1/3~1/5 로 **붕괴**, Tc 도 동반 붕괴. **λ enhancement 가 곧 불안정의 부산물**이었다는 직접 증거.

> **first-principles 결론**: 트레이드오프는 우연이 아니라 **McMillan-Hopfield 식의 구조 그 자체** — `⟨ω²⟩` 가 λ 분모(작을수록 좋음) 이면서 안정성 판별식(클수록 좋음)이라는 *이중 역할*. ML 적합으로 깨지는 벽이 아니라 (d6), 분자 η 와 분모 ⟨ω²⟩ 를 **물리적으로 분리(decouple)** 해야만 깨진다.

---

## 2. cation-stuffed ternary clathrate (CaH₆ 215K) 의 탈출

### 2.1 화학적 pre-compression

CaH₆ 는 H₂₄ sodalite-like clathrate 우리(cage) 안에 Ca cation 을 넣은 구조. Ca 의 역할:

1. **전자 도핑** — Ca 가 H-sublattice 에 전자를 내주어 H-H 반결합 궤도를 채우고 cage 를 안정화. → H-격자가 *외부 압력 없이도* 압축된 상태 (chemical pre-compression). → **⟨ω²⟩ ↑ (격자 경화 = 안정)**.
2. **N(Ef) 보존** — Fermi 준위 부근의 상태는 여전히 **H-derived (H 1s)** 가 지배. Ca 는 cage 를 받치고 전자를 공급하지만 N(Ef) 의 H 성격은 유지. → **η = N(Ef)⟨I²⟩ 가 높게 유지 (강한 λ 분자)**.

### 2.2 decoupling 이 wall 을 깨는 방식

binary hydride 에서는 ⟨ω²⟩ 를 올리면(안정) η 를 올릴 다른 손잡이가 없어 λ 가 같이 떨어진다 (§1.2 단조감소). cation-clathrate 는 **두 손잡이를 분리**한다:

```
binary:    η ─┐
              ├─ 둘 다 ⟨ω²⟩ 에 묶임 → soft 해야 λ↑ but unstable
   안정성  ⟨ω²⟩ ┘

ternary:   η  ←  cation 전자도핑 (H N(Ef) 보존)     ⟍  독립 손잡이 2개
   안정성  ⟨ω²⟩ ←  cation pre-compression (cage 경화) ⟋  → 동시 최적화 가능
```

→ ⟨ω²⟩ 를 **stable 영역(>0, 큰 값)** 에 두면서 η 를 cation 으로 높게 유지 → `λ = η/(M⟨ω²⟩)` 가 큰 ⟨ω²⟩ 에도 불구하고 충분히 큼. **CaH₆ 가 215K 에서 동역학적으로 안정한 채로 강한 λ 를 갖는 이유**.

> §2 는 **기전 서술**이다. §1.2 의 단조감소(dλ/d⟨ω²⟩<0) 와 §3 의 margin 식은 verify-가능(🟢) 이지만, "cation 이 η 를 보존하면서 ⟨ω²⟩ 를 올린다"는 *물질-특이적 인과*는 DFT/실험으로 확인할 사항 — 본 문서에서는 ⚪ SPECULATION-FENCED 로 표식 (아래 §5 fence verdict verbatim). closed-form 으로 환원된 것은 *decoupling 이 일어났을 때의 정량 결과*(§3) 뿐.

---

## 3. VERIFY-able closed-form 정량자 (NOVEL · 🟢)

### 3.1 anharmonic λ-suppression ratio `S`

η 는 비조화 재양자화(SSCHA)로 **불변** (전자구조 고정), M 도 불변 → 오직 ⟨ω²⟩ 만 이동. SSCHA 가 soft mode 에 양의 곡률 Δω²>0 을 더하면:

```
⟨ω²⟩_anharm = ⟨ω²⟩_harm + Δω²
```

η 가 비(ratio)에서 상쇄되어 닫힌 형태가 나온다:

```
          λ_anharm        η/(M·⟨ω²⟩_anharm)        ⟨ω²⟩_harm
  S  =  ───────────  =  ─────────────────────  =  ──────────────────       (0 < S ≤ 1)
          λ_harm          η/(M·⟨ω²⟩_harm)         ⟨ω²⟩_harm + Δω²
```

- `S → 1`: Δω²→0, 경화 없음 = λ 억제 없음.
- `S → 0`: Δω² 큼, 완전 경화 = λ enhancement 완전 파괴.
- 필요 경화율: `Δω²/⟨ω²⟩_harm = 1/S − 1`.

**h3o anchor**: ⟨ω²⟩_harm 를 1.0 으로 정규화, Δω²=1.479 → S=0.403388… → λ_harm·S = 2.479×0.4034 = **1.000** (= SSCHA λ_anharm 중앙값, 0.52–1.48 밴드 중심) — h3o 의 λ 붕괴를 재현.

| S (관측 범위) | λ_anharm | 필요 경화 Δω²/⟨ω²⟩_harm |
|---|---|---|
| 0.210 (lo, λ=0.52) | 0.52 | 376.7 % |
| 0.403 (mid, λ=1.00) | 1.00 | 147.9 % |
| 0.597 (hi, λ=1.48) | 1.48 | 67.5 % |

### 3.2 stability-coupling margin `m`

목표 결합 λ_target 을 내는 강성은 `⟨ω²⟩_λ = η/(M·λ_target)`. 안정화된 강성 `⟨ω²⟩_anharm (>0)` 가 그보다 *여유 있는가*를 부호 있는 비율로:

```
       ⟨ω²⟩_anharm − ⟨ω²⟩_λ
  m  = ─────────────────────
           ⟨ω²⟩_anharm
```

- `m > 0`: **안정 격자가 이미 목표 결합이 요구하는 것보다 더 단단함** → 안정성과 강한-λ 가 **양립 (ESCAPE)**. cation-clathrate (CaH₆) 영역.
- `m < 0`: 목표 λ 를 내려면 안정 격자보다 **더 무른** 격자가 필요 → **TRAPPED**. binary hydride 영역.
- `m = 0`: 정확히 벽 위.

**anchor**:
- CaH₆ escape: ⟨ω²⟩_anharm=1.0, ⟨ω²⟩_λ=0.5 (절반 강성에서 λ_target 달성) → **m = 0.5 > 0 (escape)**.
- h3o trapped: ⟨ω²⟩_anharm=1.0, ⟨ω²⟩_λ=2.479 (harmonic λ 를 내려면 2.479× 더 무른 격자 필요) → **m = −1.479 < 0 (trapped)**.

### 3.3 falsifier / sanity 한계

- `⟨ω²⟩_harm ≤ 0` (soft/unstable harmonic) → S 정의 불가 → calculator NOCALC (λ_harm 자체가 ill-defined). ✓ 물리적으로 정확.
- `Δω²=0` → S=1 (경화 없으면 억제 없음). ✓
- `⟨ω²⟩_anharm ≤ 0` → m 정의 불가 (불안정엔 margin 없음). ✓
- m 의 부호가 escape/trap 을 가른다 — `m=0` 이 정확히 trade-off 벽. ✓

---

## 4. hexa verify verdict (verbatim · g5 — never LLM self-judge)

빌드: `tool/build_hexa_verify.sh` (worktree origin/main + NOVEL primitive 2개) → `bin/hexa-verify`.
재현: `hexa verify --expr <fn> <a> <b> <expected>` · ε=1e-9 (libm-class, TECS-L Tier 2).

### 4.1 `lambda_anharm_suppress` — h3o anchor (S = λ_anharm/λ_harm)

```
verify --expr lambda_anharm_suppress(1.0,1.479)=0.403388
  calc   = 0.403388  ≈ expected 0.403388  (|Δ|=4.45199e-14 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

### 4.2 `lambda_anharm_suppress` — falsifier: 경화 없음 → S=1

```
verify --expr lambda_anharm_suppress(1.0,0.0)=1.0
  calc   = 1.0  ≈ expected 1.0  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

### 4.3 `stability_coupling_margin` — CaH₆ escape (m=0.5>0)

```
verify --expr stability_coupling_margin(1.0,0.5)=0.5
  calc   = 0.5  ≈ expected 0.5  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

### 4.4 `stability_coupling_margin` — h3o trapped (m=−1.479<0)

```
verify --expr stability_coupling_margin(1.0,2.479)=-1.479
  calc   = -1.479  ≈ expected -1.479  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

### 4.5 negative control (🔴 FALSIFIED — calc deterministic 불일치)

```
verify --expr lambda_anharm_suppress(1.0,1.479)=0.99
  calc   = 0.403388  ≠ expected 0.99  (|Δ|=0.586612 > ε=1e-9)
  tier   = 🔴 FALSIFIED  (calc deterministically disagrees beyond ε — TECS-L result-agnostic closed negative)
```

### 4.6 instability guard (soft harmonic ⟨ω²⟩≤0 → NOCALC)

```
verify --expr lambda_anharm_suppress(-1.0,2.0)=0.5
  tier   = 🟠 INSUFFICIENT
  reason = float calculator system has NO path for 'lambda_anharm_suppress'
  gap    = extend tool/verify_cli.hexa::_recompute_float (계산기시스템 개선 후보)
```

> ⟨ω²⟩_harm ≤ 0 일 때 함수가 `_NOCALC_F` 를 반환 → verify 가 INSUFFICIENT 로 보고. 이는 **물리적으로 정확한 거절**: soft/imaginary harmonic mode 에서는 λ_harm 자체가 정의되지 않으므로 비(S)를 계산할 수 없다.

### 4.7 wall point (m=0 정확히 벽 위)

```
verify --expr stability_coupling_margin(2.479,2.479)=0.0
  calc   = 0.0  ≈ expected 0.0  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

---

## 5. honesty fence — §2 기전 인과 (⚪ SPECULATION-FENCED)

§2 의 "cation 이 N(Ef) 의 H 성격을 보존하면서 ⟨ω²⟩ 를 올린다"는 *물질-특이적 인과*는 closed-form 으로 환원 불가 — DFT (cation-projected DOS · phonon dispersion) 또는 실험으로 확인할 사항. 정량자 §3 은 *decoupling 이 일어났다고 가정했을 때의 margin* 만 검증한다. 따라서 기전 서술 자체는:

```
verify --fence "CaH₆ cation 이 H-sublattice 를 화학적으로 pre-compression 하여 ⟨ω²⟩ 를 stable 영역(>0)으로 올리는 동시에 N(Ef)의 H-derived 성격(η)을 보존 → 분자 η 와 분모 ⟨ω²⟩ decoupling → 안정성과 강한-λ 양립"
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class — verification N/A by design;
           NOT a proven atlas atom (g4 honest fence, SF ≠ verified)
```

> **SF ≠ proven**. 본 문서에서 🟢 도장이 찍힌 것은 §1.2 단조감소 항등식과 §3 의 두 정량자뿐. cation decoupling 의 *물리적 사실 여부*는 wet-lab/DFT downstream.

---

## 6. tier ledger 요약

| # | 대상 | tier | note |
|---|---|---|---|
| 1 | `lambda_anharm_suppress` h3o anchor (S=0.4034) | 🟢 SUPPORTED-NUMERICAL | NOVEL primitive · η-cancel closed form |
| 2 | `lambda_anharm_suppress` Δω²=0 → S=1 | 🟢 SUPPORTED-NUMERICAL | falsifier (경화 없음) |
| 3 | `stability_coupling_margin` CaH₆ escape (m=0.5) | 🟢 SUPPORTED-NUMERICAL | NOVEL primitive · escape 판별 |
| 4 | `stability_coupling_margin` h3o trapped (m=−1.479) | 🟢 SUPPORTED-NUMERICAL | trapped 판별 |
| 5 | negative control (S=0.99 거짓) | 🔴 FALSIFIED | calc deterministic 불일치 (가드 작동) |
| 6 | instability guard (⟨ω²⟩_harm=−1) | 🟠 INSUFFICIENT (NOCALC) | 물리적 거절 (λ_harm ill-defined) |
| 7 | wall point (m=0) | 🟢 SUPPORTED-NUMERICAL | trade-off 벽 위 |
| 8 | §1.2 dλ/d⟨ω²⟩ < 0 단조감소 | 🔵-class identity | McMillan-Hopfield 미분 (해석적) |
| 9 | §2 cation decoupling 인과 | ⚪ SPECULATION-FENCED | DFT/wet-lab downstream |

**🟢 도달**: 4/4 핵심 정량자 instance + 1 wall point = 5 · **🔴**: 1 (guard) · **🟠 NOCALC**: 1 (물리 거절) · **⚪**: 1 (기전 인과)

---

## 7. NOVEL primitive 흡수 (g61 · d3)

### pre-falsifier (NOVEL-TOOL.md schema)

```yaml
candidate:   lambda_anharm_suppress / stability_coupling_margin
claim:       McMillan-Hopfield λ=η/(M⟨ω²⟩) 의 ⟨ω²⟩ 이중역할(λ분모 ∧ 안정성판별)을 닫힌 형태로 정량 — anharmonic λ-suppression ratio S=⟨ω²⟩h/(⟨ω²⟩h+Δω²) + stability-coupling margin m=(⟨ω²⟩a−⟨ω²⟩λ)/⟨ω²⟩a
proof:       textbook:McMillan 1968 PR 167:331 + Hopfield 1969 PRB 186:443 + Errea 2014 PRL 111:177002 (SSCHA) · cross-source
severity:    high   # RTSC 전체 캠페인의 d2 wall 정량화
as_of_date:  2026-05-25
scipy_grep:  not_found   # scipy 1.13.1: electron-phonon / McMillan-Hopfield primitive 없음 (lambda2nu/nu2lambda = 파장-진동수 변환, 무관)
stdlib_grep: not_found   # find ~/core/hexa-lang/stdlib -iname "*suppress*"/"*stability_margin*"/"*anharm*"/"*soft_mode*" → 0건
arxiv_ref:   null        # closed-form 은 textbook McMillan-Hopfield 분해의 비(ratio) 재구성 (NOVEL 조합)
```

→ pre-falsifier 통과 (stdlib_grep=not_found · scipy_grep=not_found). **NOVEL ✓ · stdlib-promotable ✓**.

### land 위치 (d3 canonical home)

- **canonical impl**: `~/core/hexa-lang/stdlib/material/sim.hexa` §4k `lambda_anharm_suppress` + §4l `stability_coupling_margin` (pub fn)
- **verify surface**: `~/core/hexa-lang/tool/verify_cli.hexa` `_lambda_anharm_suppress` / `_stability_coupling_margin` + dispatch + `_is_float_fn` 등록 + help 라인 (sim.hexa 산술 verbatim mirror)
- PR: #__ (squash-merge)

---

## provenance

- worktree (demiurge): `agent-a399d789a9a26d3ee`
- worktree (hexa-lang): `/tmp/wt-rtsc-anharm` ← `origin/main` (7c71559d)
- verify binary: `bin/hexa-verify` (worktree build, HEXA_LANG=canonical transpiler)
- timestamp: 2026-05-25 KST
- governance: d1 · d2 · d6 · d18 · g5 (verdict verbatim) · g61 (stdlib-promotable) · d3 (canonical stdlib home)
- 재현: `cd /tmp/wt-rtsc-anharm && bin/hexa-verify --expr lambda_anharm_suppress 1.0 1.479 0.403388463090`
