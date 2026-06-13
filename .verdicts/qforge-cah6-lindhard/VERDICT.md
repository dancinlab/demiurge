# QFORGE CaH6 screened-λ migration gate — density-norm + Lindhard ε(q) closure

Branch: `qforge-lindhard-density-screened` (worktree .wt-qforge-lindhard)
Checkpoint: 39a72ab83 "wip(qforge): density-norm Ntot²/Ω + Lindhard ε(q) screened-Hartree regularization"
Deck: exports/rtsc/decks/CaH6_NC (16 e⁻, Ω=135.04 a.u.³, ecutwfc=80 Ry, ibrav=3 celldm=6.464)
Driver: stdlib/qforge/fixtures/cah6_fullbz_xval.hexa <deck> 0 4 1 0.3 5  (npw_cap=0 full ecut shell, 4³ MP, SCREENED Anderson β=0.3 m=5)
Run host: mini native-CPU (no pod; anchor pod 39610026 untouched). HEXA_LANG = worktree (fixed stdlib).

## Two fixes under test (both committed at 39a72ab83)
(a) DENSITY-NORM (screening_pwfft.hexa): dens_scale Ntot/Ω → **Ntot²/Ω** (Parseval-derived;
    ifft3 carries ÷Ntot, ψ_phys = Ntot·ψ_r ⇒ ρ_phys = rho_r·Ntot²/Ω). Pre-fix ρ̄≈1e-4/1e-6;
    physical target ρ̄ = Nelec/Ω = 16/135.04 = **0.1185 bohr⁻³** (≈0.11-0.12).
(b) LINDHARD ε(q) (screening_pwfft.hexa): bare Hartree 4π/|G|² → 4π/(|G|²+k_TF²·F_L(|G|/2k_F)),
    static RPA macroscopic dielectric. Bounds the Dyson gain → physical ε O(0.1-2),
    vs the prior non-physical un-regularized blow-up.

## Selftests (worktree stdlib, all green)
- qforge_correlation_selftest  PASS
- qforge_screening_selftest    PASS  (Hartree Poisson + f_x/f_c kernels exact)
- qforge_screened_dv_selftest  PASS  (ratio 0.749 <1, ε_eff(q→0)=1.336 ≥1, full-path 1.126 — physical O(0.1-2))
- pw_frontend_selftest         PASS  (end-to-end λ=0.180634 > 0)

## Baselines (qforge-lane1-basis-sweep)
- npw_cap=0 full n=645 BARE    : λ=4.13647 (rel-ε 5.47% over QE 4.376)
- npw_cap=0 full n=645 SCREENED (pre-fix): λ=5.05165 (rel-ε 15.44%); witness ‖ΔV_scr‖/‖ΔV_bare‖=1.0, 0 Anderson iters (screening fell below seed → screened==bare; Δ was ω_log RMS-anchor artifact)
- QE answer-key: λ=4.376

## Measured (THIS run — density-norm + Lindhard active) — d6 VERBATIM, NOT tuned
- n(PW)=645 (full ecut shell) · nelec=16 · SCF-converged=true (17 iters)
- POW2-FFT-Poisson grid 32³ · local-ALDA folds=21 · Lindhard k_TF²=1.93464 (RPA+ALDA convolution ENGAGED)
- Dyson: 18 SCF iters · **conv=false** · ‖fp_res‖_max=0.777441 · **‖ΔV_scr‖/‖ΔV_bare‖=3.52275e+07** (still NON-physical)
- **QFORGE λ = 5.04832** · QE answer-key λ = 4.376 · **rel-ε = 15.3637%** · Δλ vs 4.137 bare baseline = +0.911846
- Allen-Dynes Tc (computed, not injected) = 351.504 K
- **GATE: NOT MET** — rel-ε 15.36% > 1% (HONEST FINDING, d6/@L5 — NOT forced to 4.376)

## Verdict (d6/@L5 — the honest engine fate)
density-norm Ntot²/Ω + Lindhard ε(q) made the Dyson loop genuinely ENGAGE (RPA+ALDA local-field
convolution, was a 0-iter bare-collapse before), and the unit-level screened_dv_selftest is now
physical (ratio 0.749, ε_eff(q→0)=1.336). BUT the full CaH6 cell screening ratio stays NON-physical
(3.5e7, conv=false) and λ=5.05 is essentially unchanged from pre-fix — 15.4% OVER QE 4.376. The BARE
vertex (4.137, 5.47%) is actually CLOSER than the screened path. Remaining (named, d2): the screening
needs the FULL self-consistent ∂V_scf inner loop with correlation-XC at a real q-mesh — static-Lindhard
+ density-norm does NOT close it. Migration-gate accuracy half stays HELD on the from-scratch screened
vertex; the hybrid (QE |g|² → QFORGE assembler, 1.65e-7) remains the working route to candidate λ/Tc.
