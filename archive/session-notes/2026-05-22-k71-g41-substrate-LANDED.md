# κ-71 R10 G41 — Energy/wind substrate floor LANDED (measured-oracle flip DEFERRED)

> Date: 2026-05-22
> Exit: γ (substrate-only) · G41 ARCH §11.6 → `[~]` PARTIAL
> hexa-lang PR #308 (`power_curve_kernel.hexa` + parity test)

## What landed

**`power_curve_kernel.hexa`** (hexa-lang `stdlib/kernels/wind/` · NEW · substrate floor ZERO before this) — IEC 61400-12-1 reference wind-turbine power curve:
- `power_curve(v, v_cut_in, v_rated, v_cut_out, p_rated)` — cubic-interpolation curve (P = P_rated·(v³−v_in³)/(v_r³−v_in³) in the cut-in→rated region · plateau at rated · 0 below cut-in / above cut-out)
- `air_density_corrected_speed(v, rho)` — IEC density normalisation v·(ρ/ρ0)^⅓
- `power_curve_density_corrected(...)`
- libm `pow` only · closed-form

## Verification (cross-implementation parity · pool:ubu-2)

Python reference of the SAME IEC formula (ground truth generated on ubu-2). Kernel `fn main()` output matched **exactly**:

| v (m/s) | hexa kernel | Python ground truth |
|---|---|---|
| 4 | 43.5038 | 43.5038212816 |
| 6 | 222.222 | 222.2222222222 |
| 8 | 570.253 | 570.2527924750 |
| 10 | 1144.03 | 1144.0329218107 |
| 12-24 (rated) | 2000.0 | 2000.0 |
| 26 (>cut-out) | 0 | 0 |
| density-corr v=10 ρ=1.0 | 928.074 | 928.0735221778 |

Substrate floor established (G31-mirror · kernel parity confirmed before it serves as a measured-oracle hexa-native side).

Note: the formal `power_curve_kernel_test.hexa` (use-based harness) didn't emit via the bootstrap-built `./hexa run` (use-resolution / subcommand difference); kept as the CI / installed-hexa harness. Logic verified via the kernel's self-contained `fn main()` (no `use`) which matches ground truth.

## What's DEFERRED (the measured-oracle flip · the actual G41 absorbed=true)

Per D120 5-fold, G41 needs (beyond the now-landed kernel):
1. `EnergyWindVerifyRecord.swift` (or EnergyVerifyRecord ext) — `measuredOracle` field
2. `stdlib/energy/wtk_fetcher.py` — NREL Wind Toolkit HSDS adapter (**token-gated** · `NREL_API_KEY`)
3. `stdlib/energy/wind_power_measured_oracle.py` — producer wire · mean_rel_err ≤ 0.05 over [4,25] m/s · **PREDICTION-shape** (D110 mirror)
4. `testEnergyWindVerifyRecordCoveredByInvariantNoCodeChange` — 4th record-type G30 invariant audit
5. design.md D121 + ARCH §11.6 G41 `[x]` flip

## Why DEFERRED

- **Server 529 Overloaded** blocked the heavy multi-repo G41 agent (died at 0 tool uses · agent-spawn path congested). Substrate sub-phase done in **foreground** (main thread unaffected).
- **NREL WTK token** likely unavailable → measured-oracle fetch needs the token OR a published-IEC-curve fallback (mirror κ-70 G37's JET synthetic-fallback + 4-layer disclosure).

## Next-pickup (when server recovers OR next session)

Resume from the 5 deferred items above. The substrate (power_curve_kernel) is ready — the flip is now a G37-mirror (schema ext + fetcher + producer + invariant test + D121). Honest scope: PREDICTION-shape (wind→power is a real modeling-error axis · re-elevates honesty floor after κ-69/κ-70's 2 numeric-equivalence rounds). If NREL token absent, published IEC reference curve / windpowerlib turbine as oracle surrogate + honest disclosure.

## Anchors

- hexa-lang PR #308 (`power_curve_kernel.hexa` + test)
- design.md D120 (G40 cell-pick · the 5-fold contract) · D119 (κ-70 G37 · mirror)
- `inbox/notes/2026-05-22-k71-horizon-candidate-research.md` (Energy/wind · substrate-floor-ZERO warning)
- [[reference-hexa-is-compiled]] · [[feedback-parallel-agent-cap]] (529 Overloaded mode)
