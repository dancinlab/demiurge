---
slug: qforge-screening-route-debug
mode: auto (4-axis: complete forced ← recommend-default)
status: done
auto-weights: complete-forced
created: 2026-06-05
---

## task brief
Make QFORGE's Anderson screened-ΔV Dyson loop ACTUALLY fold the pow2-padded real-space
FFT-Poisson convolution (`screening_pwfft.hexa`, already built on branch
`qforge-pow2-fft-resume` / PR #2778) at the CONVERGED CaH6 basis n=645 — so the screening
witness becomes NON-ZERO (Anderson iters>0, ‖ΔV_scr‖/‖ΔV_bare‖≠1.0), instead of the
current 0-iter/ratio=1.0 where it stays on the G-diagonal fallback. Then measure whether
QFORGE screened CaH6 λ moves from the bare 4.137 toward QE 4.376 (migration gate ≤1%).
The α²F→λ TAIL is already validated to 1e-7 on CaH6+LaH10 (#2774) — the screening ENGINE
is the only remaining gap.

## locked decisions
- @L1 (complete): verify on the CONVERGED n=645 full run (not a small-cell PoC) — that is the
  gate's evidence. · assert:grep n(PW)=645
- @L2 (complete): run/build on mini first, local Mac fallback; summer hexa toolchain is BROKEN
  (clang18/glibc malloc-shim, d8 filed) — do NOT use summer. · assert:grep !summer
- @L3 (complete): the FIX = wire `ad_map` (screening_anderson.hexa) → `qpwfft_dvscr_from_dpsi`
  (screening_pwfft.hexa) so the Anderson map folds the genuine real-space convolution Δρ(r)=
  Σ2ψ_n·Δψ_n, replacing the vanishing G-diagonal proxy at n=645. · assert:grep qpwfft
- @L4 (complete/honesty): NO forced flip to 4.376. After correct routing, if the screening
  witness is non-zero but λ still off >1%, the residual is the correlation-XC-beyond-
  Hartree+LDA-x gap (@L5) — report it as the real finding, do NOT fabricate agreement. ·
  assert:grep !fabricat
- @L5 (safe): RTSC anchor pods (ScH9 39291033 / Li2MgH16 39309987, running QE el-ph) are
  OFF-LIMITS — read-only CaH6 deck (exports/rtsc/decks/CaH6_NC) only, no pod ops. ·
  assert:grep !destroy

## next-action checklist
- [ ] worktree off origin/main; fetch branch qforge-pow2-fft-resume (the built screening_pwfft + WIP)
- [ ] read screening_pwfft.hexa (qpwfft_stage / qpwfft_dvscr_from_dpsi) + screening_anderson.hexa (ad_map / the affine fixed-point map) + pw_frontend.hexa (qforge_pw_frontend_phonons_scr screened path) — find WHERE the Anderson map currently calls the G-diagonal qpwd kernel instead of qpwfft
- [ ] FIX the routing: make ad_map (the per-iteration screened-ΔV producer) call qpwfft_dvscr_from_dpsi when the pow2-FFT grid staged OK, so the genuine convolution drives the Dyson fixed point
- [ ] small-basis smoke: a tractable cell run shows the witness is now NON-ZERO (Anderson iterates · ratio≠1.0) — proves the routing engages
- [ ] CONVERGED run: cah6_fullbz_xval.hexa <CaH6_NC deck> 0 4 1 0.3 4 → capture screened λ + witness VERBATIM; n=645 witness MUST be ≠0 if the fix worked
- [ ] HONEST verdict (d6): screened λ vs QE 4.376 + rel-ε; gate MET (≤1%) OR moved-but-not-met OR still-0 diagnosis. If witness now ≠0 but λ off → correlation-XC gap finding (@L5). NO faking.
- [ ] ship: commit verdict + code to qforge-pow2-fft-resume (or a fresh branch), update PR #2778 body, reconcile demiurge domains/QFORGE-FEATURE.md (flip pow2-FFT-Poisson [x] ONLY if gate MET; else keep [ ] with refined diagnosis), explicit paths · Korean commit msg · no force-push · sidecar sync after push

## completion criteria
The converged n=645 screened run shows a NON-ZERO screening witness (proving the FFT-Poisson
engages, vs the current 0-iter), AND an HONEST λ verdict vs QE 4.376 is recorded VERBATIM —
either gate-MET (≤1%, flip milestone [x]) or a precisely-diagnosed honest gap (correlation-XC,
keep [ ]). No fabricated 4.376. RTSC anchors untouched, no paid rent, summer avoided.

## 2026-06-05 follow-on (correlation-XC / local-ALDA) — install-resolution finding
- ROOT-CAUSE of "verdict unchanged after edits": `hexa run` resolves `use "stdlib/..."`
  against the INSTALL ROOT `~/.hx/src` (a git mirror), NOT cwd and NOT `HEXA_LANG`.
  Edits in a worktree (or runs with the bogus `HEXA_STDLIB_ROOT`) silently use the
  stale `~/.hx/src` stdlib (pinned #2781). FIX: `git -C ~/.hx/src checkout FETCH_HEAD --
  stdlib/qforge/...` after pushing the branch, THEN `hexa run` from `~/.hx/src`.
- @L update: the prior @L2 "summer broken" is stale (summer FIXED #2780); this follow-on
  ran on mini native-CPU regardless (local Mac). No summer dependency. No pod ops (@L5 held).
