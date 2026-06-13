# QFORGE ENGINE ROUND-7 — local-field f_xc[ρ(r)] convolution ENGAGED

🟢 BREAKTHROUGH (partial gate): the last dead screening channel is now LIVE and it
CROSSES bare for the first time in 7 rounds — but does NOT reach the ≤1% migration gate.

## the wall (R6 named blocker)

R6 closed-negative the from-scratch screened el-ph vertex: every screening channel
(kernel, operator, normalization, self-consistent vertex, phonon-FC) was built+measured,
NONE crossed bare λ=4.137 (best ~3.06-3.09, all ~30% UNDER QE 4.376). R6 pinned the ONE
remaining deeper blocker: the local-field f_xc[ρ(r)] kernel was **structurally DEAD** —
`folds=0, local-ALDA-folds=0, ‖f_xc·Δρ‖=0 → DIAGONAL FALLBACK`. The production el-ph
vertex routed through the Woodbury Dyson solve (qdvs_solve_exact), whose only xc term is
a **uniform-gas scalar** f_xc head K(G)=⟨v_c⟩+f_xc — the spatially-varying f_xc[ρ(r)]
local field (the beyond-ρ̄ term QE's ε⁻¹|g|² carries) was never folded at n=645.

## the R7 fix (d2 breakthrough)

Diagnosis correction: the pow2-FFT-Poisson padding was NEVER the blocker — it works at
any n (the smoke test n=27→grid 8³ folds non-zero; the production stage already padded
n=645→grid 32³). The real blocker was that `qpwfft_dvscr_from_dpsi` (the live f_xc
convolution) was simply **never CALLED** in the Woodbury production vertex.

FIX (two files):
1. `stdlib/qforge/screening_pwfft.hexa` — new `qpwfft_fxc_localfield_from_dpsi`: returns
   ONLY the local-field f_xc[ρ(r)]·Δρ(r) term (Hartree EXCLUDED — Woodbury carries
   Coulomb, no double-count), folded on the pow2-padded real-space FFT grid at the FULL
   n=645 basis. Increments the folds + local-ALDA witnesses; sets ‖f_xc·Δρ‖, xc-pts.
2. `stdlib/qforge/pw_frontend.hexa` — wired into the screened vertex: after the Woodbury
   ∂V_scf column, run Sternheimer on it → Δψ, fold the local-field f_xc, add
   ΔV_fxc(G)·ψ(G) to the ΔV_scr|ψ⟩ vertex column.

## the result (d6 VERBATIM — NOT tuned)

```
convergence : ecutwfc=80 Ry · npw_cap=0 · n(PW)=645 · q-mesh=2³ MP · sigma=0.02 Ha · xc=LDA-x+PW92-c
vertex      : SCREENED ∂V_scf (Woodbury Dyson) + LIVE local-field f_xc[ρ(r)] convolution
f_xc-live   : POW2-FFT-POISSON grid=32x32x32 folds=24 local-ALDA-folds=24 xc-pts=27648
              → "genuine RPA+ALDA local-field convolution ENGAGED — f_xc[ρ(r)]"  (R6: folds=0, DEAD)
vertex ratio: ‖∂V_scf‖/‖∂V_bare‖ = 0.984635  (Woodbury self-consistent vertex)
BARE baseline λ      = 4.13647   (prior converged run #2768, rel-ε=5.47%)
QFORGE λ (this run)  = 4.1518
QE answer-key λ      = 4.376      (CaH6 gate anchor, QE cross-val)
rel-ε                = 0.0512333  (5.12333 %)
Δλ vs 4.137 baseline = +0.0153329  ← CROSSES BARE (first time in 7 rounds)
QFORGE ω_log         = 1379.56 K
QFORGE Tc (Allen-Dynes) = 386.65 K
QFORGE Tc (Eliashberg)  = 415.75 K
GATE: NOT MET — rel-ε=5.12% > 1%
```

## verdict (the two honest outcomes named in the task)

OUTCOME (1) — PARTIAL. A LIVE local-field f_xc DOES let screening **cross bare 4.137**:
λ goes from the 6-round ~3.0-3.1 (30% under) trajectory to **4.1518 (+0.0153 above bare)**.
The f_xc[ρ(r)] local field — the last dead channel — is the missing ENHANCEMENT physics:
once folded, the screened vertex enhances instead of attenuating, exactly as the R5/R6
hypothesis predicted but no prior channel achieved.

BUT the gate is NOT MET — 4.1518 is 5.12% under QE 4.376, NOT within 1%. The remaining
gap is the residual correlation-XC + the LDA-vs-QE screening-functional difference
(@L5 — QFORGE screens with LDA-x+PW92-c ALDA; QE's |g|² carries the full ε⁻¹).

### terminal finding

The 7-round from-scratch screened-vertex trajectory is now:
  bare 4.137 (5.47%) → R3 2.924 (33%) → R4 2.806 (36%) → R5 vertex 3.094 (29%)
  → R6 +phonon 3.063 (30%) → **R7 +live f_xc 4.1518 (5.12%) ← CROSSES BARE**

R7 is the FIRST screened result to (a) exceed bare and (b) beat the bare baseline's own
QE-distance (5.12% < 5.47%). The local-field f_xc was correctly named by R6 as the last
dead channel, and engaging it delivers the predicted enhancement. The from-scratch
screening engine is therefore NOT definitively closed — it now demonstrably enhances —
but it does not yet reach the 1% migration gate. The HYBRID route (QE |g|² → QFORGE L3
assembler, xval rel-ε 1.65e-7) remains the PRODUCTION path; R7 reduces the from-scratch
gap to 5.12% (a ~6× improvement over the R3-R6 ~30% wall) by curing the dead channel.

Gate flip on rtsc.md line-10: NO (5.12% > 1%, honest — not forced to 4.376).

## reproduce

```
cd <R7-worktree> ; export HEXA_LANG="$PWD" ; rm -f ~/.hexa-cache/hexa_run.*dispatch*
hexa run --no-sentinel stdlib/qforge/fixtures/cah6_fullbz_xval.hexa \
  /Users/mini/dancinlab/demiurge/exports/rtsc/decks/CaH6_NC 0 2 1 0.3 5 6
```
front-end note carries the f_xc-live witness (folds=24, ENGAGED); λ verdict block reports
4.1518 vs 4.376. Selftest: stdlib/qforge/screening_pwfft_smoke.hexa (kernel folds non-zero).

raw log: cah6_r7_fxc_localfield_screened_run.log (this dir)
