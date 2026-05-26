# V2 — HERPES formal identities · `hexa verify` 검증 deliverable

> @goal — M1-M10 닫힌형(closed-form) 항등식에 `hexa verify --expr` 를 적용하고 verdict 를 verbatim 기록 · `hexa atlas register` 시도 · 🔵/🟢/🟠/⚪ 등급 honest 부여.
>
> @D g5 강제: "verdict 는 paste verbatim, LLM 자가심판 금지" — 본 문서는 hexa CLI stdout 을 fence 안에 원문 그대로 옮긴다.

---

## 0. CLI signature discovery (필수 first step)

본 deliverable 의 사전 가정은 "`hexa verify --expr exp 1 0.6321` 같은 analytic 항등식을 직접 호출하면 🔵 가 나온다" 였다. 실제 CLI 가 그것을 지원하는지 확인 없이 출발하면 안 되므로 먼저 menu 를 조회한다.

### 0.1 `hexa verify --help`

```text
hexa verify — cross-project tier rubric (TECS-L-aligned, LATTICE_POLICY real-limits-first)

  🔵 SUPPORTED-FORMAL      hexa-native calc reproduces a CLOSED-FORM/symbolic
                           identity exactly — TECS-L n6-rep Tier 1 (pure-math,
                           deterministic) · g_self_verify · anima HEXAD g_verdict_tier_blue(a)
  🟢 SUPPORTED-NUMERICAL   hexa-native NUMERICAL recompute matches (libm/Newton,
                           non-symbolic) — TECS-L n6-rep Tier 2 (~10min suite)
  🟡 SUPPORTED-BY-CITATION atlas/literature registered, NO hexa recompute
                           (external sympy/citation carry — never auto-🔵)
  🟠 INSUFFICIENT          not in atlas + no calc path (g_tier_default default)
  🟠 DEFERRED              external hw/data/API dep — TECS-L Tier 3 (GPU) /
                           g_external_calc_forbidden (closure-external)
  🔴 FALSIFIED             calc DETERMINISTICALLY disagrees with the claim —
                           a CLOSED negative (TECS-L result-agnostic: PASS or
                           FAIL both verified-closed; ≠ INSUFFICIENT)
  ⚪ SPECULATION-FENCED    imagination/metaphor (hexa-bio AXIS) — verify N/A,
                           SF ≠ proven (g4 honest fence)

usage:
  hexa verify <id> [--absorb]              atlas atom: lookup + calc recompute
  hexa verify --expr <fn> <n> <v> [--absorb]   recompute fn(n)==v hexa-native
  hexa verify --expr <fn> <a> <b> <v> [--absorb]   2-operand (sigma_k/jacobi/...)
  hexa verify --fence <claim>              ⚪ SPECULATION-FENCED (honest)
  hexa verify rubric | list                this rubric

  --absorb : a 🔵 result is folded into atlas/inbox/verified_equations.tape
             (g7 inbox · self-verified, g_self_verify · reviewer-merge → MAIN.tape).
             Verifies & absorbs equations NOT YET in the atlas — verify computes
             them; the binary built-in atlas grows with proven closed-forms.
  calc fns : sigma|sigma_0|sigma_2|phi|mu|tau|is_perfect|aliquot|gamma0_index|
             gamma0_cusps|gamma0_genus|isotropy_lcm|first_cusp_form_weight
             2-op: sigma_k|jacobi|kronecker|dim_cusp_forms  (extend _recompute on gap)
```

### 0.2 `hexa verify rubric`

(`--help` 출력과 동일 — rubric · usage · calc fns 가 한 메뉴에 통합되어 있다.)

### 0.3 핵심 발견 — pre-loaded assumption 와의 충돌

`calc fns` 줄이 결정적이다:

```
calc fns : sigma | sigma_0 | sigma_2 | phi | mu | tau | is_perfect | aliquot |
           gamma0_index | gamma0_cusps | gamma0_genus | isotropy_lcm |
           first_cusp_form_weight
   2-op : sigma_k | jacobi | kronecker | dim_cusp_forms
```

→ **hexa verify --expr 의 지원 함수는 number-theoretic atom 전용이다.** `exp`, `pow`, `hill`, `frac`, `div` 같은 analytic / 비-NT 함수는 모두 `🟠 INSUFFICIENT (no calc path)` 로 떨어진다.

이는 HERPES M1-M10 의 닫힌형 항등식 (Poisson `1-e^(-x)`, chromatin steady-state fraction `k_m/(k_m+k_d)`, MOI Poisson, viral 1차 decay, Hill 용량반응) 이 모두 `hexa verify --expr` 로 **직접 🔵 promotion 불가능**함을 의미한다. 정직한 verdict 는 🟠 INSUFFICIENT 또는 ⚪ SPECULATION-FENCED 다.

본 V2 deliverable 은 이 honest constraint 를 verbatim 으로 기록하고, hexa CLI 가 실제 산출한 verdict 를 fence 에 그대로 옮긴다 (@D g5 강제).

---

## 1. ID-1 — Poisson neuron reactivation rate

### 1.1 닫힌형 (LaTeX)

$$P(\text{reactivation per year}) = 1 - e^{-r \cdot k \cdot \Delta t}$$

- $r$ = per-genome reactivation rate (/yr)
- $k$ = latent HSV genome copy count per TG neuron
- $\Delta t = 1$ yr

### 1.2 Canonical inputs

| symbol | value | source |
|---|---|---|
| $r$ | $0.05$ /yr (per-genome) | M2 §3.1 추정치 (Sawtell mouse · Cuddy 2020 calibration) |
| $k$ | $20$ copies/neuron (median) | M2 §1.1 (Wang 2005 ddPCR) |
| $\Delta t$ | $1$ yr | annual reactivation window |
| **expected** | $P \approx 1 - e^{-1.0} = 0.6321$ | $-r \cdot k \cdot \Delta t = -1.0$ |

### 1.3 hexa verify command issued

```bash
hexa verify --expr exp 1 0.6321
```

### 1.4 Verdict (verbatim)

```text
error: to_int: trailing garbage in "0.6321"
```

→ hexa verify --expr 는 정수 expected 만 받는다 (calc fns 는 NT atom 전용 · float 입력 자체가 to_int 파싱 단계에서 거부). reframe 불가능.

### 1.5 Reframe attempt → fence form

```bash
hexa verify --fence "Poisson neuron reactivation P=1-exp(-r*k*dt) with r=0.05/yr, k=20, dt=1yr yields P=0.632"
```

```text
verify --fence
  claim  = Poisson neuron reactivation P=1-exp(-r*k*dt) with r=0.05/yr, k=20, dt=1yr yields P=0.632
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

### 1.6 Atlas registration

skip — `hexa atlas register --from-verify exp 1 0.6321` 도 to_int 단계에서 실패 (float expected unsupported). Atlas 등록 대상 아님.

### 1.7 Tier earned

**⚪ SPECULATION-FENCED** (정직한 fence form · 🔵 path absent in CLI).

---

## 2. ID-2 — LAT silencing steady-state (chromatin closed-form)

### 2.1 닫힌형 (LaTeX)

$$P_{Me3}^{ss} = \frac{k_m}{k_m + k_d}$$

(M3 §7.2 의 3-state Markov steady-state · methylation-rate / (meth + demeth) ratio.)

### 2.2 Canonical inputs

| symbol | value | source |
|---|---|---|
| $k_m$ | $0.1$ (relative · methylation forward rate) | M3 §7.3 G9a/SUV39H1 rate |
| $k_d$ | $0.001$ (KDM4A/B demeth rate) | M3 §7.3 Hauri 2016 |
| **expected** | $P_{Me3}^{ss} = 0.1 / 0.101 \approx 0.9901$ | $\approx 0.99$ |

### 2.3 hexa verify command issued

```bash
hexa verify --expr frac 100 1 99
```

(`frac` 시도 — 100/(100+1) = 99/100 wouldn't be exact, but the test goal is to see if any fraction atom exists.)

### 2.4 Verdict (verbatim)

```text
verify --expr frac(100,1)=99
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'frac'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

### 2.5 Reframe attempt → fence form

```bash
hexa verify --fence "LAT silencing steady-state P_Me3=k_m/(k_m+k_d) with k_m=0.1, k_d=0.001 yields P_Me3=0.9901"
```

```text
verify --fence
  claim  = LAT silencing steady-state P_Me3=k_m/(k_m+k_d) with k_m=0.1, k_d=0.001 yields P_Me3=0.9901
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

### 2.6 Atlas registration

skip — verify 가 🟠 / no calc path → register 대상 아님 (`--from-verify` 는 🔵/🟢 결과만 atlas 로 fold).

### 2.7 Tier earned

**🟠 INSUFFICIENT (calc path)** + **⚪ SPECULATION-FENCED (fence form)** — 둘 다 honest 옵션. 본 deliverable 은 fence verdict 를 채택한다 (claim 이 입력값 + 수치까지 완결되어 있어 SF axis 에 적합).

---

## 3. ID-3 — CRISPR per-genome cleavage probability

### 3.1 닫힌형 (LaTeX)

$$P(\text{cleavage per latent genome}) = 1 - e^{-\lambda \cdot \phi_{act}}$$

- $\lambda$ = AAV MOI per neuron (Poisson)
- $\phi_{act}$ = fraction of delivered nuclease cassettes that yield active enzyme

### 3.2 Canonical inputs

| symbol | value | source |
|---|---|---|
| $\lambda$ | $3$ (MOI per neuron) | M5 §6 AAV titer assumption |
| $\phi_{act}$ | $1.0$ (idealised) | M5 §7.2 upper-bound |
| **expected** | $P = 1 - e^{-3} \approx 0.9502$ | $1 - 0.0498$ |

### 3.3 hexa verify command issued

```bash
hexa verify --expr exp 3 0.0498
```

### 3.4 Verdict (verbatim)

```text
error: to_int: trailing garbage in "0.0498"
```

→ float expected, parser rejects (NT atom 만 받는 ABI).

### 3.5 Reframe attempt → fence form

```bash
hexa verify --fence "CRISPR per-genome cleavage P=1-exp(-MOI*phi_act) with MOI=3 phi_act=1 yields P=0.95"
```

```text
verify --fence
  claim  = CRISPR per-genome cleavage P=1-exp(-MOI*phi_act) with MOI=3 phi_act=1 yields P=0.95
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

### 3.6 Atlas registration

skip (verify 실패).

### 3.7 Tier earned

**⚪ SPECULATION-FENCED**.

---

## 4. ID-4 — Viral 1차 (exponential) decay

### 4.1 닫힌형 (LaTeX)

$$N(t) = N_0 \cdot e^{-\lambda \cdot t}$$

- $\lambda = \varepsilon \cdot \phi$ = combined clearance rate (immune efficacy × drug fraction)
- $t$ = time (days)

### 4.2 Canonical inputs

| symbol | value | source |
|---|---|---|
| $\lambda$ | $1$ /day | M5 §8 combined ε·ϕ idealised |
| $t$ | $2$ days | acute decay window |
| **expected** | $N/N_0 = e^{-2} \approx 0.1353$ | exponential closed-form |

### 4.3 hexa verify command issued

```bash
hexa verify --expr exp 2 0.135
```

### 4.4 Verdict (verbatim)

```text
error: to_int: trailing garbage in "0.135"
```

### 4.5 Reframe attempt → fence form

```bash
hexa verify --fence "Viral first-order decay N(t)=N0*exp(-lambda*t) with lambda=1 t=2 yields N/N0=0.135"
```

```text
verify --fence
  claim  = Viral first-order decay N(t)=N0*exp(-lambda*t) with lambda=1 t=2 yields N/N0=0.135
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

### 4.6 Atlas registration

skip (verify 실패).

### 4.7 Tier earned

**⚪ SPECULATION-FENCED**.

---

## 5. ID-5 — mRNA vaccine Hill dose-response

### 5.1 닫힌형 (LaTeX)

$$T(D) = T_{max} \cdot \frac{D^n}{K^n + D^n}$$

- $D$ = 백신 용량 (μg)
- $K$ = half-saturation (μg)
- $n$ = Hill 협동성 지수

### 5.2 Canonical inputs

| symbol | value | source |
|---|---|---|
| $D$ | $30$ μg | M9 §3 BNT-/Mod-class clinical dose |
| $K$ | $10$ μg | M9 §5 fitted half-saturation |
| $n$ | $2$ | M9 §5 cooperative IgG induction |
| **expected** | $T = T_{max} \cdot 900 / 1000 = 0.9 \cdot T_{max}$ | Hill closed-form |

### 5.3 hexa verify commands issued

#### 5.3.1 Hill (3-operand)

```bash
hexa verify --expr hill 30 10 2 0.9
```

```text
verify --expr hill(30,10)=2
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'hill'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

(CLI 가 4-operand form 미지원 → 앞 3 인자만 파싱하고 hill(30,10)=2 로 해석되었다.)

#### 5.3.2 `pow(30, 2) = 900` (numerator-only)

```bash
hexa verify --expr pow 30 2 900
```

```text
verify --expr pow(30,2)=900
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'pow'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

→ Hill 부분조차 (정수 거듭제곱 $30^2$) atomic calc path 가 없다.

### 5.4 Reframe → fence form

```bash
hexa verify --fence "mRNA vaccine Hill dose-response T=Tmax*D^n/(K^n+D^n) with D=30, K=10, n=2 yields T=0.9*Tmax"
```

```text
verify --fence
  claim  = mRNA vaccine Hill dose-response T=Tmax*D^n/(K^n+D^n) with D=30, K=10, n=2 yields T=0.9*Tmax
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

### 5.5 Atlas registration

skip (verify 실패).

### 5.6 Tier earned

**🟠 INSUFFICIENT (no calc path · hill nor pow)** + **⚪ SPECULATION-FENCED (fence form)**.

---

## 6. 양성 대조군 (positive control) — hexa verify 가 🔵 를 내는 형태

본 deliverable 의 부정적 결과 5건이 "CLI 가 망가져서가 아니라 calc fns 범위가 NT 전용이라서" 임을 보이기 위해, NT atom 한 개에 verify 를 동일 형식으로 돌려 verbatim 출력을 옮긴다.

### 6.1 `sigma(6) = 12` (perfect number divisor sum)

```bash
hexa verify --expr sigma 6 12
```

```text
verify --expr sigma(6)=12
  calc   = 12  == expected 12
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
```

### 6.2 `phi(10) = 4` (Euler totient)

```bash
hexa verify --expr phi 10 4
```

```text
verify --expr phi(10)=4
  calc   = 4  == expected 4
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
```

### 6.3 `tau(12) = 6` (divisor count)

```bash
hexa verify --expr tau 12 6
```

```text
verify --expr tau(12)=6
  calc   = 6  == expected 6
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
```

→ CLI 는 멀쩡하다. NT atom 은 🔵 / 비-NT analytic 은 🟠. 본 deliverable 의 5 identity 가 모두 비-NT 인 것이 결과의 원인.

### 6.4 Atlas register 시도 (mechanism 검증)

```bash
cd ~/core/hexa-lang
hexa atlas register --from-verify sigma 6 12
```

```text
hexa atlas register --from-verify sigma(6) = 12
  calc   = 12  == expected 12
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form; @D g_self_verify · TECS-L Tier1)
  embed  = appended @F verified-sigma-6 to ./compiler/atlas/embedded.gen.hexa (ATLAS_F_NODES section)
  note   = next compile folds this into the binary built-in atlas (@D g_atlas_binary_builtin)

hexa atlas register: edit landed on the CURRENT branch (no --auto-pr).
  commit it with:  git -C . add ./compiler/atlas/embedded.gen.hexa && git commit -m 'atlas(F): register verified-sigma-6'
```

→ mechanism 동작 확인 · 등록은 `compiler/atlas/embedded.gen.hexa` 에 line 추가 + (옵션) `--auto-pr` 로 PR 자동 생성.

**본 deliverable scope 외 이므로 atlas edit 은 `git checkout` 으로 되돌렸다** — HERPES verify 작업이 hexa-lang atlas growth 와 섞이는 것을 막기 위함 (@D d9 worktree index isolation · @D d3 implementation-home discipline).

생성 직전 atlas 상태:

```bash
hexa atlas lookup F verified-sigma-6
```

```text
atlas: loaded 16062 nodes from atlas.n6
# not found: F:verified-sigma-6
```

→ sigma(6) 은 atlas 에 아직 없었음 (real first-landing 가능했으나 scope 외라 보류).

---

## 7. 최종 tier-promotion 요약표

```
ID  | claim                              | calc path?  | verify verdict           | fence verdict            | tier earned
----+------------------------------------+-------------+--------------------------+--------------------------+--------------------------
ID1 | Poisson reactivation 1-e^(-rkΔt)   | NO (exp)    | error: to_int trailing   | ⚪ SPECULATION-FENCED    | ⚪ SPECULATION-FENCED
ID2 | LAT silencing k_m/(k_m+k_d)        | NO (frac)   | 🟠 INSUFFICIENT          | ⚪ SPECULATION-FENCED    | ⚪ SPECULATION-FENCED
ID3 | CRISPR cleavage 1-e^(-MOI·φ)       | NO (exp)    | error: to_int trailing   | ⚪ SPECULATION-FENCED    | ⚪ SPECULATION-FENCED
ID4 | Viral decay N0·e^(-λt)             | NO (exp)    | error: to_int trailing   | ⚪ SPECULATION-FENCED    | ⚪ SPECULATION-FENCED
ID5 | mRNA Hill T_max·D^n/(K^n+D^n)      | NO (hill)   | 🟠 INSUFFICIENT          | ⚪ SPECULATION-FENCED    | 🟠 INSUFFICIENT + ⚪ SF
----+------------------------------------+-------------+--------------------------+--------------------------+--------------------------
PC1 | sigma(6) = 12 (positive control)   | YES (sigma) | 🔵 SUPPORTED-FORMAL      | n/a                      | 🔵 SUPPORTED-FORMAL
PC2 | phi(10) = 4  (positive control)    | YES (phi)   | 🔵 SUPPORTED-FORMAL      | n/a                      | 🔵 SUPPORTED-FORMAL
PC3 | tau(12) = 6  (positive control)    | YES (tau)   | 🔵 SUPPORTED-FORMAL      | n/a                      | 🔵 SUPPORTED-FORMAL
----+------------------------------------+-------------+--------------------------+--------------------------+--------------------------
🔵 SUPPORTED-FORMAL  : 0 / 5 HERPES identities  (3 / 3 positive controls)
🟠 INSUFFICIENT      : 2 / 5 HERPES identities  (ID2 frac · ID5 hill+pow)
⚪ SPECULATION-FENCED: 5 / 5 HERPES identities  (모두 fence form 으로 honest 라벨링)
```

---

## 8. Honest acknowledgement — 무엇이 성공했고 무엇이 실패했나

### 8.1 🔵 promotion 시도 결과 — 0/5

HERPES M1-M10 의 닫힌형 5 개 (Poisson reactivation · LAT silencing fraction · CRISPR MOI · viral 1차 decay · Hill 용량반응) 중 **단 한 개도 🔵 SUPPORTED-FORMAL 로 promote 되지 않았다**. 이유는 단 하나:

> `hexa verify --expr` 의 `calc fns` 카탈로그가 number-theoretic atom (sigma / phi / mu / tau / 모듈러 차원 · 야코비 기호 등) **전용**이고, analytic biology (exp · pow · hill · 분수) 함수가 단 하나도 등재되어 있지 않다.

이것은 hexa CLI 의 honest constraint 이며 V2 deliverable 의 verdict 다.

### 8.2 정직한 fallback — 5/5 가 ⚪ SPECULATION-FENCED

`hexa verify --fence` 를 통한 SF 라벨은 **CLI 가 의도적으로 제공한 honest path** 다 (@D g4 honest fence · `g_self_verify` 정합). 모든 5 claim 이 fence verdict 를 받아 "검증 N/A — 추측 / 모형 가정" 임을 명시적으로 라벨링했다. 이는 🔵 보다 약하지만, 🟡 SUPPORTED-BY-CITATION 보다 honest 하다 (citation 이 없으므로).

### 8.3 🟠 INSUFFICIENT 2 건 (ID2, ID5) — 의도된 verbatim

`frac` (ID2) · `hill` (ID5) · `pow` (ID5) 시도는 CLI 가 `🟠 INSUFFICIENT · calculator system has NO path` 를 직접 출력했다. 이는 g_tier_default 동작이며 **calc fns 카탈로그 확장 후보 (verify_cli.hexa::_recompute extend)** 라고 명시 → 향후 hexa-lang inbox 으로 보낼 만한 합법적 gap (@D d8 vast trouble 패턴과 유사하게 patches/ 인박스 후보).

### 8.4 Atlas registration — 0 PR opened (scope-out 결정)

| identity | atlas register 가능? | 행동 |
|---|---|---|
| ID1-4 (exp 기반) | NO — `to_int trailing garbage` 단계에서 거부 | skip |
| ID5 (hill/pow) | NO — `🟠 INSUFFICIENT`, register 는 🔵/🟢 만 fold | skip |
| PC1 sigma(6)=12 | YES — `embedded.gen.hexa` 에 line 추가 가능 | 시도하여 mechanism 확인 후 `git checkout` 으로 revert (scope-out) |

→ HERPES verify deliverable 에서 hexa-lang atlas 에 PR 을 자동으로 여는 것은 scope 위반이라 판단. 만약 sigma(6) (또는 다른 NT atom) atlas growth 가 별도 작업으로 승인되면, 동일 명령 (`hexa atlas register --from-verify sigma 6 12 --auto-pr`) 으로 즉시 가능하다.

### 8.5 CLI signature surprises (pre-loaded assumption contradiction)

1. **`--expr` 는 정수만 받는다.** float expected value (`0.6321`, `0.135` ...) 는 `to_int: trailing garbage` 로 거부됨 → analytic 항등식 직접 호출 불가. **사전 가정 (`hexa verify --expr exp 1 0.6321`) 은 잘못된 형식이었다.**
2. **`calc fns` 가 NT-only 다.** `exp`, `pow`, `frac`, `hill`, `div` 등 일반 수학 함수는 calc 경로가 없다 — bio domain identity 직접 verify 불가능. 이를 우회하려면 (a) verify_cli.hexa::_recompute 확장 inbox 패치 또는 (b) fence form 사용.
3. **`--expr <fn> <a> <b> <v>` 는 2-operand form** (`sigma_k`, `jacobi`, `kronecker`, `dim_cusp_forms`). Hill 의 3-operand form (D, K, n) 은 지원되지 않으며 CLI 가 앞 3 인자만 파싱하여 `hill(30,10)=2` 로 해석되었다.
4. **`hexa atlas register --from-verify` 는 verify-실패 입력에서도 동일한 to_int 오류로 끝난다** (float-expected 단계 공유). register 가 verify path 를 호출하기 때문.

---

## 9. 후속 권장 — gap inbox 항목

V2 의 honest blocker 를 hexa-lang 으로 escalate 할 수 있는 inbox 항목들 (@D d8 패턴):

1. **`hexa-lang/inbox/rfc_drafts/verify_cli_analytic_extension.md`** — verify_cli.hexa::_recompute 에 `exp · pow · hill · gauss · poisson_cdf` 등 analytic-biology atom 추가하여 biomedicine domain 의 닫힌형도 🔵/🟢 reach.
2. **`hexa-lang/inbox/rfc_drafts/verify_expr_float_expected.md`** — `--expr <fn> <n> <v>` 의 `<v>` 파서가 float 를 받도록 확장 (현재 to_int hard-rejects) → libm-class 🟢 SUPPORTED-NUMERICAL 직접 reach.

이 두 inbox 패치가 land 되면 V2 의 5 identity 는 즉시 🟢 (또는 🔵) 로 promote 가능하다. 본 V2 는 **현재 CLI 능력 한도에서 honest verdict 를 기록한 snapshot** 이다.

---

## 10. 결론

- HERPES M1-M10 의 5 개 닫힌형 항등식에 `hexa verify` 적용 → **0 / 5 🔵 promotion** (CLI calc fns 가 NT-only).
- 5 / 5 가 정직한 ⚪ SPECULATION-FENCED 로 라벨됨 (@D g4 honest fence).
- 2 / 5 (ID2, ID5) 는 추가로 🟠 INSUFFICIENT verdict 도 직접 받음 (calc path 명시적 부재).
- atlas registration 은 mechanism 확인 후 scope-out (HERPES verify 가 hexa-lang atlas growth 와 섞이지 않게).
- 후속 gap-inbox 2 건 (verify_cli analytic extension · float expected) 권장.

본 deliverable 은 @D g5 "verbatim verdict, no LLM self-judge" 를 준수하여 모든 hexa CLI 출력을 fence 안에 원문 그대로 옮겼다.

— V2 close
