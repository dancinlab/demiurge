# Parity attempt — `space + synthesize` (OpenMDAO substrate)

> status: **resolved** (κ-50) — Tsiolkovsky rel err ≤ 1e-4 (all 3 samples). Flip NO (SLSQP walked to lower bound, MDO machinery not meaningfully exercised, parity algebraically trivial).

**Date**: 2026-05-20
**ROI rank**: 8 (⭐⭐⭐⭐)
**Substrate**: `~/core/hexa-lang/stdlib/space/openmdao_mission.py`
  on hexa-lang origin/main (76b2a7ea or later)
**Substrate version**: openmdao 3.39.0, scipy 1.13.1, numpy 1.26.4
**Note status**: parity-attempt-only — `absorbed=false` REMAINS (banned-absorbed
list: OpenMDAO is external pip dep, same stance as Skyfield / POPPY / ngspice).

## Substrate (SLSQP MDO, 1-discipline)

Design var: `dv_mps ∈ [10, 4000]`. Maximises `m_payload = m_initial − m_prop − m_dry`
subject to `m_prop ≤ 12000 kg` and `m_payload ≥ 0`. Per-sample run, 3 wet-mass samples.
Run dir: `/tmp/space_synth_parity_96539/`, input_sha256_16 `59a317d06b9c7528`.

## Analytic oracle — Tsiolkovsky 1903

The rocket equation (Tsiolkovsky 1903; see Curtis, *Orbital Mechanics for
Engineering Students*, §11.2 — propulsion fundamentals) gives propellant
expended for a velocity increment ΔV applied to an instantaneous stage:

```
m_prop = m_initial · (1 − exp(−ΔV / (Isp · g0)))
```

With Isp = 320 s, g0 = 9.80665 m/s², the effective exhaust velocity is
`v_e = Isp·g0 = 3138.128 m/s`.

**Key insight**: payload `m_payload = m_initial − m_prop − m_dry` is *strictly
decreasing* in ΔV (because `m_prop` is monotonically increasing in ΔV via the
exponential). Therefore the unconstrained payload-maximising ΔV is the **lower
bound** `DV_MIN = 10 m/s`. The propellant-budget constraint (≤12000 kg) is
inactive at ΔV=10 m/s since `m_prop(10) ≪ 12000` for all three samples.

So the closed-form optimum is:
- `ΔV* = 10 m/s` (bound-active at lower limit)
- `m_prop* = m_initial · (1 − exp(−10 / 3138.128)) = m_initial · 0.00318154`
- `m_payload* = m_initial − m_prop* − 1500`

## Per-sample parity table

| m_initial (kg) | substrate ΔV / m_prop / m_payload | analytic ΔV / m_prop / m_payload | %parity (ΔV, m_prop, m_payload) |
|---:|---|---|---|
|  8000.0 | 10.0000 / 25.4523 / 6474.5477  | 10.0000 / 25.4523 / 6474.5477  | +0.0000% / −0.0001% / +0.0000% |
| 12500.0 | 10.0000 / 39.7693 / 10960.2307 | 10.0000 / 39.7693 / 10960.2307 | +0.0000% / +0.0001% / −0.0000% |
| 18000.0 | 10.0000 / 57.2677 / 16442.7323 | 10.0000 / 57.2677 / 16442.7323 | +0.0000% / −0.0001% / +0.0000% |

All three samples match the Tsiolkovsky closed-form to within **±0.0001%**
(below the substrate's `round(_, 4)` reporting resolution; well inside the
±0.01% tolerance). SLSQP converged to the bound-active optimum in every case.

## Flip recommendation

**DO NOT flip `absorbed=true`.** Reasons:

1. **Parity is algebraically trivial**: the substrate is a single-discipline
   Tsiolkovsky ExecComp wrapped in SLSQP. The "MDO" is monotone-in-ΔV so the
   optimiser merely walks to the lower bound — there is no multi-discipline
   coupling being exercised. Perfect parity here only confirms the optimiser
   correctly evaluates the closed-form, not that OpenMDAO's MDO machinery has
   been validated.
2. **Banned-absorbed stance holds**: OpenMDAO is an external Python library
   (NASA GSC-17177-1, BSD-3, pip-installed). Same posture as Skyfield /
   POPPY / ngspice — substrate-only, never absorbed.
3. **Toy model, GATE_OPEN**: the substrate header (`HONESTY g3`) explicitly
   states this is scoping-level: no gravity loss, no drag, no staging, no
   AOCS/thermal/comms, generic upper-stage params (not a flight-validated
   spec sheet). Stage-up to GATE_CLOSED_MEASURED requires multi-discipline
   coupling + a real vehicle dataset (separate ROI-15 GMAT cell, deferred).
4. **What real absorption would look like**: a hexa-native MDO kernel
   exercising multi-discipline coupling (e.g. ΔV ↔ propellant ↔ thermal ↔
   structural mass) where the closed-form parity would NOT be trivial, and
   the substrate would have nothing to give us beyond an atlas-registered
   equation set.

## Recommendation

Keep this note as documentation of the parity attempt; leave the substrate
as-is on `absorbed=false`. The `space + synthesize` cohort row in the empty-
cells research stays an OpenMDAO-substrate-producer cell, not an absorbed one.

## Citations

- Tsiolkovsky, K. E. (1903). *Исследование мировых пространств реактивными
  приборами* ("Exploration of cosmic space by means of reaction devices"),
  Научное Обозрение №5.
- Curtis, H. D. *Orbital Mechanics for Engineering Students* (4th ed., 2020),
  Butterworth-Heinemann, §11.2 (Equations of motion of a variable-mass body /
  rocket equation derivation).
- OpenMDAO: NASA GSC-17177-1, BSD-3, https://openmdao.org.
