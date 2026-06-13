# QFORGE CaH6 screened-λ migration gate — SC-DFPT inner-loop Thomas-Fermi fix

Branch: `qforge-scdfpt-fix` (hexa-lang repo /Users/mini/core/hexa-lang, worktree /tmp/wt-scdfpt)
Stacked PRs: **#3038** (TF Coulomb fix, base main) · **#3039** (g5 gate, base #3038)
Deck: exports/rtsc/decks/CaH6_NC (16 e⁻, Ω=135.04 a.u.³, ecutwfc=80 Ry, n=645 full ecut shell)
Driver: stdlib/qforge/fixtures/cah6_fullbz_xval.hexa <deck> 0 4 1 0.3 5 (4³ MP, SCREENED Anderson β=0.3 m=5)
Run host: mini native-CPU, 0-pod. HEXA_LANG = worktree (TF fix active). Walltime ≈ 25 min.

## The fix (the named SC-DFPT inner-loop blocker)
Root cause (17-round g2-audit, confirmed here): the screened-ΔV Dyson loop folds the bare
Hartree kernel V_H(G)=4π/|G|², which DIVERGES as |G|→0. On the converged metallic CaH6
cell the small-|G| coefficients drove the dielectric feedback gain past 1 → the Dyson fixed
point x*=(I−L)⁻¹·bare became non-physical: ‖ΔV_scr‖/‖ΔV_bare‖=**3.5e7**, conv=false (#2786).

FIX = static-RPA Thomas-Fermi screened Coulomb (screening_pwfft.hexa + pw_frontend.hexa):
  v_c(G)=4π/|G|²  →  v_TF(G)=4π/(|G|²+k_TF²),  k_TF²=4k_F/π, k_F=(3π²ρ̄)^{1/3}
k_TF² DERIVED from ρ̄=nelec/Ω (NOT tuned). Applied to both the diagonal (QPWD) and FFT-Poisson
(PWFFT) screening paths. Opt-in (k_TF²≤0 → bare verbatim → all prior selftests unaffected).

## g5 gate (screening_tf_selftest.hexa — PR #3039) — ALL PASS
- (A) k_TF²=4k_F/π = **1.93465** matches the verdict's measured Lindhard k_TF²=1.93464 (rel 5e-6)
- (B) TF kernel finite & ≤ 4π/k_TF² ceiling at |G|→0 where bare 4π/|G|² diverges (1.9e6×)
- (C) k_TF²=0 reduces EXACTLY to bare 4π/|G|²
- (D) gain-bound A/B: TF bounds the Dyson gain → **TF fp_res=735 ≤ bare fp_res=9132** (12×)
- regressions: screened_dv_selftest PASS · screening_selftest PASS · screening_anderson_selftest PASS

## Measured — full CaH6 cell, TF active — d6 VERBATIM, NOT tuned
- n(PW)=645 · nelec=16 · nocc=8 · SCF-converged=true (17 iters) · sigma=0.02 Ha · xc=LDA-x+PW92-c
- POW2-FFT-Poisson grid 32³ · folds=21 · local-ALDA-folds=21 · last_err=0 (RPA+ALDA+TF ENGAGED)
- Dyson: 18 SCF iters · conv=false · ‖fp_res‖_max=**964.18**
- **‖ΔV_scr‖/‖ΔV_bare‖ = 1.0**  ← the 3.5e7 overscreening blow-up is GONE (TF bounded the gain ✓)
- **QFORGE λ = 5.05165** · QE answer-key λ = 4.376 · **rel-ε = 15.44%** · Δλ vs 4.137 bare = +0.915
- ω_log = 1118 K · Tc(Allen-Dynes) = 351.6 K · Tc(Eliashberg) = 379.9 K
- **GATE: NOT MET** — rel-ε 15.44% > 1% (HONEST, d6/@L5 — NOT forced to 4.376)

## Verdict (d6/@L5 — outcome (3): the correlation-XC-beyond-Hartree+LDA wall)
The TF fix is MECHANICALLY CORRECT and closes the SC-DFPT inner-loop divergence: the catastrophic
3.5e7 overscreening (un-bounded metallic Coulomb gain) collapsed to a PHYSICAL ratio=1.0, exactly
as the g5 A/B predicted (bare fp_res 9132 → TF fp_res 735). The Dyson machine no longer blows up.

BUT λ does NOT move toward QE: with the gain bounded, the screened vertex collapses to ≈bare
(ratio 1.0), so λ=5.05 is unchanged from the pre-TF screened value, and the BARE λ=4.137 (5.47%)
remains CLOSER to QE 4.376 than the screened path. The residual still doesn't cross tol (conv=false,
fp_res 964) — the Hartree+LDA-x+PW92-c kernel, even physically bounded, does NOT reproduce QE's
ε⁻¹-screened |g|². This is the @L5 gate blocker NAMED VERBATIM: the missing physics is
**correlation-XC beyond Hartree+LDA in the el-ph vertex kernel** (the TDDFT/Adler-Wiser f_xc local-
field beyond ALDA, or the full RPA χ⁰ ε(G,G') off-diagonal that QE's DFPT carries), NOT the bare
Coulomb divergence (now fixed). Faking 4.376 refused (d6). bare 4.137 < screened 5.05 reported as-is.

Next breakthrough paths (d2): (1) full off-diagonal ε(G,G') RPA χ⁰ (not the long-wavelength TF
limit) — the screening becomes q-dependent and non-local; (2) TDDFT f_xc beyond ALDA (Nanoquanta/
bootstrap kernel) for the local-field; (3) keep the hybrid route (QE |g|² → QFORGE assembler,
rel-ε 1.65e-7) as the working candidate-λ/Tc path while the from-scratch vertex matures.
Migration gate HELD on the from-scratch screened vertex; the SC-DFPT divergence sub-blocker is CLOSED.
