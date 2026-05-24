# V2 — 🔵 closed-form push (7 identities)

> verify-phase V2 산출물 · current-state · no history.
> 입력 = V1 §9.2 top 5 + V1 §6.1 tier 1 (Higuchi · Fick) 추가 = **7 identity**.
> 실행 = `hexa verify` CLI **만** (LLM-judge 금지 per @D g5) · verdict **verbatim** paste.
> 산출 = 7 identity × verdict + atlas register 시도 + §0 CLI signature + §Σ 요약 + §Δ 다음 batch 권고.

---

## §0. hexa verify CLI signature

### §0.1 `hexa verify --help` (verbatim)

```
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

### §0.2 핵심 발견사항

| 발견 | 영향 |
|---|---|
| `--expr` 의 `<n> <v>` args = **integer-only** (float trailing → `error: to_int: trailing garbage`) | bio formula의 IC50/Kd 같은 sub-integer 값 직접 입력 불가 |
| `--expr` calc 커널 = **number-theoretic 만** (sigma · phi · mu · tau · is_perfect · aliquot · gamma0_* · isotropy_lcm · first_cusp_form_weight · sigma_k · jacobi · kronecker · dim_cusp_forms) | bio identity (hill · beer_lambert · higuchi · fick1 · exp_release · ldl_pct · cheng_prusoff) **모두 calc-kernel 외** |
| 미지원 fn 에 `--expr` 호출시 → `🟠 INSUFFICIENT` + `reason = calculator system has NO path for '<fn>'` + `gap = extend tool/verify_cli.hexa::_recompute` | **bio identity 7건은 직접 🔵 불가** — 7건 모두 🟠 INSUFFICIENT |
| `--fence` 호출시 → `⚪ SPECULATION-FENCED` (claim 종류 무관) | 대안 = honest fence (atlas certification N/A) |
| exit code = **모두 0** (verdict-바디만 다름, 0=non-fatal · verdict 는 stdout 텍스트 파싱) | 자동화 시 exit 0 ≠ 🔵 — stdout 의 verdict 라인 파싱 필요 |

### §0.3 g5 honest-fence 적용 (per @D d2)

V1 §6.1 의 plan 은 `hexa verify --expr hill 3 0.5` 같은 호출을 가정했지만 — **실제 CLI**는
(a) float arg 거부 + (b) `hill`/`beer_lambert`/... 같은 fn 을 인식하지 못한다.
따라서 7 identity 모두 **🟠 INSUFFICIENT** (calc path 부재) 또는 **⚪ SPECULATION-FENCED**
(--fence form) 으로 honestly 기록한다. 이는 @D g5 **LLM-judge 금지** 의 정확한 결과 —
verify CLI 가 진실이고, LLM 이 "이건 closed-form 이니까 🔵" 라고 판정하는 것은 **금지**.

breakthrough path (per @D d2):
- **path A** — `tool/verify_cli.hexa::_recompute` extend (계산기시스템에 7 bio identity 추가).
  PR 대상 = hexa-lang repo (per @D g_atlas_binary_builtin · PR-only landing).
- **path B** — V3 numerical recompute 으로 우회. SciPy / numpy 로 각 identity 호출 →
  `hexa verify --expr <wrapper_fn>` 로 numerical 결과만 정수 캐스트 후 검증.
- **path C** — `hexa atlas append-witness --kind F --id <identity_name> --raw <equation>` 으로
  citation-locked 등록 (🟡 tier · 재현 없이 ledger 등재).

---

## §1. Hill 방정식 — `θ = [L]^n / (Kd^n + [L]^n)`

**claim source** — V1-FORM-03 (M3 §1 IC50 표 · M4 §2 FKBP12 Kd).
근거 값 — fasudil ROCK IC50 ≈ 330 nM, n=1 (Hill coefficient).

### §1.1 시도 1 — `hexa verify --expr` (V1 §6.1 plan 형식)

명령:
```
hexa verify --expr hill 3 0.5
```

verdict verbatim:
```
error: to_int: trailing garbage in "0.5"
```

exit code: 1 — float arg 거부.

### §1.2 시도 2 — integer arg

명령:
```
hexa verify --expr hill 3 5
```

verdict verbatim:
```
verify --expr hill(3)=5
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'hill'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

exit code: 0.

### §1.3 시도 3 — `--fence` honest

명령:
```
hexa verify --fence "Hill equation θ = [L]^n / (Kd^n + [L]^n) for receptor binding (fasudil ROCK IC50 330nM, n=1)"
```

verdict verbatim:
```
verify --fence
  claim  = Hill equation θ = [L]^n / (Kd^n + [L]^n) for receptor binding (fasudil ROCK IC50 330nM, n=1)
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

exit code: 0.

### §1.4 atlas register 시도

명령:
```
hexa atlas register --from-verify hill 3 5
```

verdict verbatim:
```
hexa atlas register --from-verify hill(3) = 5
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'hill'
  gap    = extend tool/atlas_cli.hexa::_recompute_register (계산기시스템 개선)
```

→ PR 생성 안 됨 (HONEST DEGRADE per `--from-verify` 의 g_atlas_binary_builtin: drill skip / verify FALSIFIED / 🟠 INSUFFICIENT 시 NO PR).

**§1 종합 tier**: 🟠 INSUFFICIENT (--expr) · ⚪ SPECULATION-FENCED (--fence).

---

## §2. Cheng-Prusoff — `K_i = IC50 / (1 + [S]/K_m)`

**claim source** — V1-FORM-04 (M3 §1 표 · M4 §2 FKBP12 Kd).

### §2.1 시도 1 — `--expr`

명령:
```
hexa verify --expr cheng_prusoff 3 1
```

verdict verbatim:
```
verify --expr cheng_prusoff(3)=1
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'cheng_prusoff'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

exit code: 0.

### §2.2 시도 2 — `--fence` honest

명령:
```
hexa verify --fence "Cheng-Prusoff K_i = IC50/(1+[S]/K_m) (M3 fasudil ROCK)"
```

verdict verbatim:
```
verify --fence
  claim  = Cheng-Prusoff K_i = IC50/(1+[S]/K_m) (M3 fasudil ROCK)
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

exit code: 0.

### §2.3 atlas register

`--from-verify cheng_prusoff` → §1.4 와 동일 패턴, 🟠 INSUFFICIENT · PR 미생성. 시도 생략 (calc kernel 동일).

**§2 종합 tier**: 🟠 INSUFFICIENT (--expr) · ⚪ SPECULATION-FENCED (--fence).

---

## §3. Beer-Lambert — `I = I₀ · exp(−μ·x)`

**claim source** — V1-FORM-09 (M1 §3 OCT/IVUS finding · 760nm tissue μ ≈ 5 mm⁻¹).

### §3.1 시도 1 — `--expr` (legacy · 2026-05-24)

명령:
```
hexa verify --expr beer_lambert 3 0
```

verdict verbatim (legacy):
```
verify --expr beer_lambert(3)=0
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'beer_lambert'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

exit code: 0.

### §3.2 시도 2 — `--fence` (legacy)

명령:
```
hexa verify --fence "Beer-Lambert I = I_0 * exp(-mu * x) for OCT 760nm (mu_tissue ~ 5/mm, x=1mm)"
```

verdict verbatim (legacy):
```
verify --fence
  claim  = Beer-Lambert I = I_0 * exp(-mu * x) for OCT 760nm (mu_tissue ~ 5/mm, x=1mm)
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

exit code: 0.

### §3.3 escalation — bio kernel phase 1 (PR #707 merged · 2026-05-25)

hexa-lang PR #707 (`feat(verify): bio kernel phase 1`) merged. `beer_lambert(I_0, mu, x) = I_0 * exp(-mu*x)` is now a libm-class `--expr` recompute target.

명령 (verbatim · `SIDECAR_NO_POOL_ROUTE=1`):
```
hexa verify --expr beer_lambert 1.0 5.0 1.0 0.006737946999085467
```

verdict verbatim:
```
verify --expr beer_lambert(1.0,5.0,1.0)=0.00673795
  calc   = 0.00673795  ≈ expected 0.00673795  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

exit code: 0.

OCT 760 nm tissue example (μ ≈ 5 /mm, x = 1 mm) → expected I/I₀ = exp(-5·1) ≈ 0.006738 (4-decimal libm-class match · |Δ|=0 ≤ ε=1e-9).

**§3 종합 tier (post-PR #707)**: **🟢 SUPPORTED-NUMERICAL** (--expr libm recompute) · legacy 🟠/⚪ verdicts retained verbatim above for honest provenance.

[^pr707]: hexa-lang PR #707 (`feat(verify): bio kernel phase 1`) merged 2026-05-24 → adds `exp_release` · `ldl_pct` · `beer_lambert` to `tool/verify_cli.hexa::_recompute` (libm-class · float-arg parsing enabled).

---

## §4. first-order exp release — `M_t = M_0 · (1 − exp(−k·t))`

**claim source** — V1-FORM-13 (M2 §3 sirolimus burst · M5 §1 30-day elution).

### §4.1 시도 1 — `--expr` (legacy · 2026-05-24)

명령:
```
hexa verify --expr exp_release 2 0
```

verdict verbatim (legacy):
```
verify --expr exp_release(2)=0
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'exp_release'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

exit code: 0.

### §4.2 시도 2 — `--fence` (legacy)

명령:
```
hexa verify --fence "first-order exp release M_t = M_0 * (1 - exp(-k*t)) for sirolimus 30-day elution"
```

verdict verbatim (legacy):
```
verify --fence
  claim  = first-order exp release M_t = M_0 * (1 - exp(-k*t)) for sirolimus 30-day elution
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

exit code: 0.

### §4.3 escalation — bio kernel phase 1 (PR #707[^pr707] merged · 2026-05-25)

`exp_release(M_0, k, t) = M_0 * (1 - exp(-k*t))` 가 libm-class `--expr` 재계산 대상에 추가됨 (3-operand form, float-arg 파싱 동시 enable).

명령 (verbatim · `SIDECAR_NO_POOL_ROUTE=1`):
```
hexa verify --expr exp_release 1.0 0.1 10 0.6321205588285577
```

verdict verbatim:
```
verify --expr exp_release(1.0,0.1,10.0)=0.632121
  calc   = 0.632121  ≈ expected 0.632121  (|Δ|=1.11022e-16 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

exit code: 0.

sirolimus 30-day elution analogue — M_0=1.0, k=0.1/day, t=10 day → M_t/M_0 = 1−e⁻¹ ≈ 0.6321 (M2 §3 burst-then-plateau 정합).

### §4.4 falsification sanity check (TECS-L result-agnostic)

`hexa verify` 가 deterministic disagreement 도 닫힌 verdict 로 표시하는지 확인:

명령:
```
hexa verify --expr exp_release 1.0 0.1 10 0.999
```

verdict verbatim:
```
verify --expr exp_release(1.0,0.1,10.0)=0.999
  calc   = 0.632121  ≠ expected 0.999  (|Δ|=0.366879 > ε=1e-9)
  tier   = 🔴 FALSIFIED  (calc deterministically disagrees beyond ε — TECS-L result-agnostic closed negative)
```

→ 정직 reciprocal — 잘못된 claim 은 🔴 FALSIFIED 로 닫힌 negative. PASS·FAIL 둘 다 verified-closed (TECS-L result-agnostic).

**§4 종합 tier (post-PR #707)**: **🟢 SUPPORTED-NUMERICAL** (--expr libm recompute · correct value) · 🔴 FALSIFIED (incorrect value, sanity check) · legacy 🟠/⚪ verdicts retained verbatim above for honest provenance.

---

## §5. LDL Δ% identity — `Δ% = (LDL_0 − LDL_t) / LDL_0 · 100`

**claim source** — V1-FORM-18 (M4 §2.2 FOURIER evolocumab LDL ↓ 60% baseline).

### §5.1 시도 1 — `--expr` (float, legacy · 2026-05-24)

명령:
```
hexa verify --expr ldl_pct 2 60.0
```

verdict verbatim (legacy):
```
error: to_int: trailing garbage in "60.0"
```

exit code: 1 — float arg 거부 (PR #707 머지 전 int-only ABI).

### §5.2 시도 2 — `--expr` (int, legacy)

명령:
```
hexa verify --expr ldl_pct 2 60
```

verdict verbatim (legacy):
```
verify --expr ldl_pct(2)=60
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'ldl_pct'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

exit code: 0.

### §5.3 시도 3 — `--fence` (legacy)

명령:
```
hexa verify --fence "LDL Δ% identity (LDL_0 - LDL_t)/LDL_0 * 100 for FOURIER evolocumab 60% baseline"
```

verdict verbatim (legacy):
```
verify --fence
  claim  = LDL Δ% identity (LDL_0 - LDL_t)/LDL_0 * 100 for FOURIER evolocumab 60% baseline
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

exit code: 0.

### §5.4 escalation — bio kernel phase 1 (PR #707[^pr707] merged · 2026-05-25)

`ldl_pct(LDL_0, LDL_t) = (LDL_t − LDL_0) / LDL_0 · 100` 가 libm-class `--expr` 재계산 대상에 추가 (signed convention: 감소 = 음수).

명령 (verbatim · `SIDECAR_NO_POOL_ROUTE=1`):
```
hexa verify --expr ldl_pct 100 70 -30
```

verdict verbatim:
```
verify --expr ldl_pct(100.0,70.0)=-30.0
  calc   = -30.0  ≈ expected -30.0  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

exit code: 0.

FOURIER evolocumab analogue — LDL_0=100, LDL_t=70 → Δ% = (70−100)/100·100 = −30% (M4 §2.2 60% reduction 의 절반 magnitude로 sanity-check; full 60% reduction = ldl_pct(100, 40, −60) 도 동일 libm path).

**§5 종합 tier (post-PR #707)**: **🟢 SUPPORTED-NUMERICAL** (--expr libm recompute) · legacy 🟠/⚪ verdicts retained verbatim above for honest provenance.

---

## §6. Higuchi release — `M_t/A = √(D·Cs·(2C₀ − Cs)·t)`

**claim source** — V1-FORM-01 (M5 §1 elution kinetics · sirolimus PVA matrix).

### §6.1 시도 1 — `--expr`

명령:
```
hexa verify --expr higuchi 3 1
```

verdict verbatim:
```
verify --expr higuchi(3)=1
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'higuchi'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

exit code: 0.

### §6.2 시도 2 — `--fence`

명령:
```
hexa verify --fence "Higuchi release M_t/A = sqrt(D * Cs * (2*C_0 - Cs) * t) for sirolimus PVA matrix"
```

verdict verbatim:
```
verify --fence
  claim  = Higuchi release M_t/A = sqrt(D * Cs * (2*C_0 - Cs) * t) for sirolimus PVA matrix
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

exit code: 0.

**§6 종합 tier**: 🟠 INSUFFICIENT (--expr) · ⚪ SPECULATION-FENCED (--fence).

---

## §7. Fick 1차 — `J = −D · dC/dx`

**claim source** — V1-FORM-02 (M5 §1 + §3 · paclitaxel DCB → vessel wall).

### §7.1 시도 1 — `--expr`

명령:
```
hexa verify --expr fick1 2 1
```

verdict verbatim:
```
verify --expr fick1(2)=1
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'fick1'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

exit code: 0.

### §7.2 시도 2 — `--fence`

명령:
```
hexa verify --fence "Fick 1st law J = -D * dC/dx for paclitaxel diffusion from DCB to vessel wall"
```

verdict verbatim:
```
verify --fence
  claim  = Fick 1st law J = -D * dC/dx for paclitaxel diffusion from DCB to vessel wall
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

exit code: 0.

**§7 종합 tier**: 🟠 INSUFFICIENT (--expr) · ⚪ SPECULATION-FENCED (--fence).

---

## §Σ V2 first batch 결과 요약

> **2026-05-25 update** — hexa-lang PR #707 (`feat(verify): bio kernel phase 1`) merged.
> §3 beer_lambert · §4 exp_release · §5 ldl_pct 의 `--expr` 경로가 🟠 INSUFFICIENT → **🟢 SUPPORTED-NUMERICAL** 로 escalate.
> 나머지 4건 (§1 hill · §2 cheng_prusoff · §6 higuchi · §7 fick1) 은 phase 2 PR 대기.

| § | identity | source | `--expr` verdict | `--fence` verdict | atlas PR |
|---|---|---|---|---|---|
| §1 | Hill 방정식 | V1-FORM-03 / M3 §1 | 🟠 INSUFFICIENT | ⚪ SPECULATION-FENCED | 미생성 (🟠 HONEST DEGRADE) |
| §2 | Cheng-Prusoff | V1-FORM-04 / M3 §1 | 🟠 INSUFFICIENT | ⚪ SPECULATION-FENCED | 미생성 |
| §3 | Beer-Lambert | V1-FORM-09 / M1 §3 | **🟢 SUPPORTED-NUMERICAL** (post-PR #707) | ⚪ SPECULATION-FENCED (legacy) | n/a (libm-class) |
| §4 | first-order exp release | V1-FORM-13 / M2 §3 | **🟢 SUPPORTED-NUMERICAL** (post-PR #707) + 🔴 sanity | ⚪ SPECULATION-FENCED (legacy) | n/a (libm-class) |
| §5 | LDL Δ% identity | V1-FORM-18 / M4 §2.2 | **🟢 SUPPORTED-NUMERICAL** (post-PR #707) | ⚪ SPECULATION-FENCED (legacy) | n/a (libm-class) |
| §6 | Higuchi release | V1-FORM-01 / M5 §1 | 🟠 INSUFFICIENT | ⚪ SPECULATION-FENCED | 미생성 |
| §7 | Fick 1차 | V1-FORM-02 / M5 §1 | 🟠 INSUFFICIENT | ⚪ SPECULATION-FENCED | 미생성 |

### §Σ.1 verdict 분포 (7 identity · post-PR #707)

| tier | N | % | Δ (pre-#707) |
|---|---|---|---|
| 🔵 SUPPORTED-FORMAL | 0 | 0% | — |
| 🟢 SUPPORTED-NUMERICAL | **3** | **43%** | **+3** (§3 · §4 · §5) |
| 🟡 SUPPORTED-BY-CITATION | 0 | 0% | — |
| 🟠 INSUFFICIENT (--expr) | **4** | **57%** | **−3** (phase 2 대기) |
| 🔴 FALSIFIED | 0 (sanity-only) | 0% | — (§4.4 sanity) |
| ⚪ SPECULATION-FENCED (--fence) | 7 (legacy retained) | 100% | — |

atlas register PR: **0건** (libm-class numerical · `--from-verify` 는 🔵 closed-form 만 fold; 🟢 numerical 은 V3 ledger 흡수).

### §Σ.2 sanity-check (실제로 🔵 가능한 fn 검증)

calc-kernel 내 fn 으로 동일 CLI 가 🔵 verdict 를 정상 반환하는지 확인 (V2 의 verify 절차가 honest 함의 sanity):

명령:
```
hexa verify --expr sigma 6 12
```

verdict verbatim:
```
verify --expr sigma(6)=12
  calc   = 12  == expected 12
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
```

→ CLI 는 정상 작동 · 🔵 verdict 반환 가능. 7 bio identity 의 🟠 결과는 **(a) 그 fn 들이 kernel 에 미등록**된 것이지 (b) 우리가 잘못 호출한 것이 아님 — honest.

### §Σ.3 V1 §9.2 예상 vs V2 실측

| 항목 | V1 예상 | V2 실측 |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | ~28 (FORM-01~28) | **0** (V2 first batch 7건 중) |
| `hexa verify --expr` arg 형식 | `<fn> <n> <v>` (n=변수수, v=reference) | int-only · `<fn>` ∈ {sigma · phi · mu · tau · ...} closed set |
| atlas register --auto-pr | 7건 즉시 PR | **0건** (🟠 HONEST DEGRADE) |

→ V1 §6.3 의 가드 `실행시 commands kernel signature 검증 필요` 가 적중. V1 §11 의 §6/§7 자체 등급도 🟠 INSUFFICIENT 였음 — V2 가 그 가드를 honest 하게 확정.

---

## §Δ 다음 V2 batch 권고

per @D d2 — wall (calc kernel 부재) 마주쳤으니 3 path 모두 surface:

### §Δ.1 path A — calc kernel extend (가장 정공)

V1 §6.1 의 tier 1-8 batch 전체 (21 fn) 를 `hexa-lang/tool/verify_cli.hexa::_recompute` 에 추가.

| tier | fn 후보 | LOC 예상 | PR target |
|---|---|---|---|
| tier 1 release kinetics | higuchi · fick1 · korsmeyer_peppas · exp_release · stokes_einstein | ~80 | hexa-lang `tool/verify_cli.hexa` + test |
| tier 2 receptor binding | hill · cheng_prusoff | ~30 | 동상 |
| tier 3 electrochem | tafel · pbr · arrhenius · stoich_mg_h2o | ~60 | 동상 |
| tier 4 mechanics | laplace · hagen_poiseuille · strut_area_ratio | ~40 | 동상 |
| tier 5 optical | beer_lambert · beer_multilayer | ~25 | 동상 |
| tier 6 ADMET | logp · ldl_pct · pct_change | ~30 | 동상 |
| tier 7 statistics | cox_ci · fisher_2x2 · logrank · proportion_ci · log_or · weighted_sum | ~120 | 동상 |

→ 총 ~385 LOC 추가 + float-arg 파싱 enable (현재 int-only) — hexa-lang inbox/patches/`verify_cli_bio_kernel.md` issue + PR.

추가 발견 — V1 §6.1 의 reference value (`<v>` 가 float) 는 **현재 CLI 에서 작동 불가**. float-arg 파싱 enable 도 동시 추가 필요.

### §Δ.2 path B — V3 numerical 우회 (즉시 가능)

V3 (다음 milestone) 의 numerical recompute 으로 우회. SciPy / numpy 로 각 identity 호출 → `hexa verify` 거치지 않고 직접 NUM-01~10 plan 진행 가능. V1-NUM-06 (PK/PD ODE 1-comp) 가 가장 단순 (local CPU SciPy `solve_ivp`).

→ V3 first push 3 후보 (V1 §9.3) = NUM-06 · NUM-03 (Mg Tafel ODE) · NUM-01 (drug-polymer DFT) — V2 의 🟠 결과를 우회하고 V3 직행.

### §Δ.3 path C — atlas append-witness (🟡 citation-locked 직행)

`hexa atlas append-witness --kind F --id <id> --raw <equation>` 으로 7 identity 를 atlas 에 citation-locked (🟡) 로 등록. closed-form 재현 없이도 ledger 에 atom 으로 남김.

| identity | kind | id 권장 | raw |
|---|---|---|---|
| Hill | F | `hill_equation` | `theta = L^n / (Kd^n + L^n)` |
| Cheng-Prusoff | F | `cheng_prusoff` | `Ki = IC50/(1+S/Km)` |
| Beer-Lambert | F | `beer_lambert` | `I = I_0 * exp(-mu*x)` |
| first-order exp release | F | `exp_release_1st` | `Mt = M0*(1-exp(-k*t))` |
| LDL Δ% | F | `ldl_pct_change` | `pct = (LDL0-LDLt)/LDL0*100` |
| Higuchi | F | `higuchi_release` | `Mt/A = sqrt(D*Cs*(2*C0-Cs)*t)` |
| Fick 1차 | F | `fick1_diffusion` | `J = -D*dC/dx` |

→ 7건 모두 staging 파일 생성 후 `hexa atlas pr --staging <file.n6>` 로 PR-only landing (hexa-lang repo).

### §Δ.4 권고 우선순위

| 순위 | path | 이유 |
|---|---|---|
| **1** | **path B (V3 numerical)** | 즉시 진행 가능 · V3 milestone 가 다음 단계라 work-flow 정합 · local CPU 만으로 NUM-06/03 cover |
| 2 | path C (atlas append-witness) | 🟡 ledger 등록 → V4 ledger 의 🟡 row 채움 · ISR domain 의 75% 🟡 비중과 정합 |
| 3 | path A (calc kernel extend) | 가장 정공이지만 hexa-lang repo 의 cross-PR 필요 (commit + test + reviewer-merge) — V2/V3 후 별도 PR |

→ **다음 V2 batch (만약 추가 진행시) 권고**: V1 §6.1 tier 8 (--fence) 3건 만 의미 있음 (Mehran 4-pattern · ARC-2 enum · TLF composite) → 모두 ⚪ SPECULATION-FENCED 으로 honest fence + atlas append-witness 동반 가능. tier 1-7 의 추가 호출은 calc kernel 부재로 동일 🟠 만 반복 — V3 (numerical) 또는 path A (kernel extend PR) 로 진로 변경 권고.

---

## §Ω 검증 등급 (g5, 본 V2 자체)

| 항목 | 등급 | 근거 |
|---|---|---|
| §0 CLI signature 캡처 | 🟢 SUPPORTED-NUMERICAL | `hexa verify --help` + `rubric` 실제 실행 verbatim |
| §1-§7 7 identity verdict | 🟢 SUPPORTED-NUMERICAL | 각 identity `hexa verify` 실행 + verbatim paste (LLM-judge 0) |
| §Σ.1 verdict 분포 | 🔵 SUPPORTED-FORMAL | 0×7 = 0 (🔵), 7×7 = 7 (🟠 · ⚪) — 계산 자명 |
| §Σ.2 sanity-check 🔵 | 🔵 SUPPORTED-FORMAL | `hexa verify --expr sigma 6 12` → 🔵 verdict 그대로 |
| §Δ 3 path | 🟡 SUPPORTED-BY-CITATION | @D d2 governance (path A/B/C concede 금지) |
| atlas register 미생성 | 🟢 SUPPORTED-NUMERICAL | `hexa atlas register --from-verify hill 3 5` 실제 호출 verbatim (HONEST DEGRADE 확인) |

🔑 핵심 통찰:
- **🔵 0건 · 🟠 7건 · ⚪ 7건** = `hexa verify` CLI 의 honest verdict (LLM-judge 0건).
- V1 §6.1 의 plan 형식 (`hexa verify --expr <bio_fn> <n> <v>`) 은 **현재 CLI 미지원** — 두 가지 이유: (a) float arg 거부 · (b) bio fn 커널 부재.
- @D g5 / d2 정합 — wall 만났지만 (calc kernel 부재) **3 path 모두 surface**: path A (kernel extend PR) · path B (V3 numerical 우회) · path C (atlas append-witness 🟡 직행).
- **atlas PR 0건** = HONEST DEGRADE per `--from-verify` 의 g_atlas_binary_builtin (🟠 INSUFFICIENT 시 PR 미생성, never claim fake PR).
- **다음 milestone V3** = path B (V3 numerical) 직행 권고 — NUM-06 PK/PD ODE · NUM-03 Mg Tafel ODE · NUM-01 drug-polymer DFT (V1 §9.3 top 3 그대로).
