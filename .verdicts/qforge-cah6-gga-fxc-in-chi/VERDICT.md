# QFORGE CaH6 screened-λ migration gate — GGA(PBE) f_xc-IN-χ (A2 round)

The final-named-DFT-lever round on the from-scratch screened-vertex wall. The prior
**ALDA f_xc-in-χ** round over-screened (LDA exchange kernel f_x=−⅓(3/π)^⅓ρ^−⅔ < 0 →
(v_c+f_xc) over-screening → λ=3.41513, **21.96% BELOW** QE 4.376, WORSE than RPA's
14.25%). ALDA's sign did NOT predict the next lever, so this round tests it directly:
the **GGA(PBE)** xc kernel `f_xc^GGA = ∂²e_xc^PBE/∂ρ²|_{∇ρ}` carrying the |∇ρ| gradient
through F_x(s) (exchange enhancement) and H(t) (correlation), evaluated on the H-cage
density by spectral differentiation (FFT·iG·IFFT) of ρ(r).

- Deck: `exports/rtsc/decks/CaH6_NC` (16 e⁻, Ω=135.04 a.u.³, ecutwfc=80 Ry)
- Driver: `stdlib/qforge/fixtures/cah6_fxc_gga_in_chi_xval.hexa <deck> 0 2 8`
  (npw_cap=0 → FULL ecut shell n(PW)=645, 2³ MP, full ε(G,G') matrix, ncond=8 χ⁰)
- Run host: mini native-CPU (NO pod; anchor pod untouched). HEXA_MEM_CAP_MB=12288.
  ~24 min wall (storm-resilient retry wrapper, backoff 30→480s — no first-hit abort).
- **cost = $0** (0-pod local-CPU).

## The implementation shipped (A2 — the GGA(PBE) f_xc-in-χ Dyson kernel, d4 toggle)

New d4 toggle `qpwd_set_fxc_gga(on)` (default false = ALDA, NO regression) selects the
f_xc-in-χ kernel FLAVOR. Wiring in `stdlib/qforge/screening_pwfft.hexa` (live ~/.hx/src):

- `_qpwfft_fx_enh_pbe(s)` — PBE exchange enhancement F_x(s)=1+κ−κ/(1+μs²/κ), κ=0.804, μ=0.21951.
- `_qpwfft_ex_pbe(ρ,∇ρ)` — ε_x^PBE = ε_x^LDA·F_x(s), s=|∇ρ|/(2k_F ρ). (s→0 ⇒ Slater, ALDA-continuous.)
- `_qpwfft_exc_pbe_dens(ρ,∇ρ)` — e_xc^PBE = ρ·(ε_x^PBE + ε_c^PBE) (reuses the SSOT `qforge_ec_pbe_from_rho`).
- `_qpwfft_fxc_gga(ρ,∇ρ)` — `∂²e_xc^PBE/∂ρ²|_{∇ρ}` by central 2nd-difference (PARALLEL to ALDA's d²e_xc^LDA/dρ²).
- `_qpwfft_grad_rho(ρ_r)` — |∇ρ|(r) by spectral differentiation: ∂_α ρ = IFFT[i G_α ρ̂(G)], |∇ρ|=√Σ_α(∂_α ρ)².
- `_qpwfft_build_fxc_gfield` GGA branch — builds ρ(r) grid → |∇ρ|(r) once → per-point GGA kernel → FFT into the Dyson kernel.

g5-validated by `stdlib/qforge/fxc_gga_in_chi_smoke.hexa` (cheap synthetic cell):
GGA engages (folds>0, |∇ρ| spectral witness alive mean=2.44), and its screened column
DIFFERS from BOTH RPA and ALDA (the gradient kernel genuinely acted) — see `impl/smoke_result.log`.

## Full-cell CaH6 result — VERBATIM (d6/@L5 — NOT forced to 4.376)

- n(PW)=645 · nelec=16 · nocc=8 · SCF-converged=true · 17 iters · ecutwfc=80 Ry
- f_xc-in-χ ON=true · **GGA ON=true** · cell-mean **|∇ρ|/ρ = 1.08899** (gradient witness — GGA engaged, not fallback)
- ε(G,G') full matrix: χ⁰-transitions=64 (ncond=8) · ‖offdiag ε‖/‖ε‖=0.9223 · min|pivot|=0.9040 (non-singular)
- f_xc-in-χ folds=416025 (=645²) · ‖f_xc‖/‖v_c‖=1.6041 (kernel ENGAGED, not RPA fallback)

| kernel | λ | rel-ε vs QE 4.376 |
|---|---|---|
| BARE (no screening) | 4.13647 | 5.47% |
| RPA (v_c only) | 3.75221 | 14.25% |
| **ALDA f_xc-in-χ** | **3.41513** | **21.96%** |
| **GGA(PBE) f_xc-in-χ (this round)** | **3.41256** | **22.0164%** |

- **Δλ vs ALDA = −0.00257** (GGA ≈ ALDA — gradient kernel made essentially NO difference)
- Δλ vs RPA = −0.33965 · ω_log=1370.5 K · Tc_AD=337.31 K · Tc_ME=364.29 K
- **GATE: NOT MET** — rel-ε 22.02% ≫ 1%.
- **DIRECTION vs ALDA: still BELOW ALDA** — GGA did NOT relieve the over-screening (≤1%? NO).

## OUTCOME (3) — verbatim: GGA also fails; the screening wall is deeper than the xc kernel

The pointwise kernel probe (`impl/kernel_probe.log`) shows the GGA kernel DOES soften the
LDA exchange at HIGH gradient (GGA/ALDA = 0.48–0.80× at s~1.5) — but **stays NEGATIVE**
(same over-screening sign, never flips). Critically, at the CONVERGED CaH6 cage density
the cell-mean reduced gradient is modest (mean |∇ρ|/ρ = 1.089 ⇒ s small ⇒ F_x(s)≈1), so
the GGA kernel **collapses back to ALDA** in the volume that dominates the el-ph fold:
λ_GGA = 3.41256 ≈ λ_ALDA = 3.41513.

Interpretation (d6/@L5): the screened-vertex residual is **NOT** the f_xc-in-χ Dyson-kernel
functional choice (ALDA vs GGA) — both land at ~22% below QE. The wall is deeper:

1. **from-scratch LDA-PW SCF** (QE 4.376 is PBE self-consistent end-to-end — XC enters the
   ground state, not only the response kernel; this round upgraded only the *response* kernel).
2. **NC pseudopotential** (the deck's norm-conserving CaH6 pseudo vs QE's).
3. **conduction-band χ⁰ truncation** (ncond=8 finite empty-state sum).

GGA-vs-LDA at the *kernel* level is now RULED OUT as the closer; the residual sits in the
*ground-state functional + pseudo + χ⁰ completeness*, not the Dyson kernel.

## Screening-vertex exploration — now COMPLETE (5 levers, all ≤1% MISS)

RPA → full ε(G,G') matrix → Sternheimer-χ⁰ → ALDA f_xc-in-χ → **GGA f_xc-in-χ** — every
lever lands 11.4–22% below QE 4.376, never ≤1%. The gate is **HELD** (not flipped):
dispatch=qe · the harmonic-vs-harmonic hybrid path (rel-ε 1.65e-7) remains the QE-grade
production route. No 4.376 forcing anywhere.
