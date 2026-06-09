# QFORGE interpreter-fault — full-ε Sternheimer χ⁰ n=645 "high-|G| column" fault

date: 2026-06-09 · host: mini (macOS 25.5 / Darwin 25.5.0) · 0-POD local-CPU ONLY
engine: hexa-lang 0.1.0-dispatch · branch qforge-cah6-sternheimer-chi0 (commit 16ac40d6)

## TL;DR
The "high-|G| column interpreter runtime fault" that made the full ε(G,G')
Sternheimer χ⁰ build (n=645, 5160 solves) intractable is **NOT a non-finite
numerical fault** and **NOT OOM-of-a-single-object**. It is **macOS jetsam
SIGKILL (exit 137)** triggered by **monotonic transient-allocation pile-up** in a
push()-heavy hot loop that the per-function arena never reclaims mid-build. The 3
finiteness guards were correct but guarding the wrong failure mode.

## fault origin — VERBATIM
- The full build dies SILENTLY (no Hexa error, no `memory cap` line, no trace) at
  a G-column that DRIFTS with available RAM (observed col ~65 in the real run; col
  192–320 in the n=729 synthetic repro). `exit code = 137 = 128 + 9 = SIGKILL`.
- Tight-loop `ps rss` sampling: RSS swings **0.5 → 4.5–6.5 GB WITHIN ONE G-column**,
  then jetsam fires. Peak does NOT scale with n (n=125 already ~3.3 GB) — set by the
  per-iteration allocation RATE, not a cumulative working set.
- With MORE free RAM the run reaches a LATER column and a HIGHER peak (6.4 GB) before
  jetsam → the garbage grows monotonically until the OS arbitrates; never reclaimed.
- `isolated n=645 dense inversion = 6.5 s` (allocates the n² matrix ONCE) → confirms
  it is neither the inversion nor a single-object OOM.

## root cause (two upstream hexa-runtime defects)
1. **push()-grown arrays are heap-promoted, not arena-tracked** (`HEXA_ARRAY_PUSH_ARENA`
   default OFF). The whole χ⁰ build is ONE `while gj` loop → every pushed transient
   (`fft3`/`ifft3` internal `lre/lim` + packed outputs, CG `ap`/projection temporaries,
   G-shift columns) piles on the heap for the ENTIRE build → multi-GB → jetsam.
2. **`HEXA_ARRAY_PUSH_ARENA=1` reclaims it but CORRUPTS results.** Flipping it on
   makes the n=729 build complete flat (peak 6064 → **199 MB**, exit 0) — proving (1)
   is the leak — but the answer is silently WRONG (`solves=0/nvc=0` vs correct 590,
   even at n=125, RAM-independent): an array push()-built in a helper and RETURNED
   has its arena rewound out from under it (`__hexa_fn_arena_return` misses push
   escapees). A crash-for-wrong-answer trade, not a usable workaround.

→ No env knob makes a push()-heavy hot loop both correct AND memory-bounded.

## application-side mitigation — SHIPPED (commit 16ac40d6, physics byte-identical)
- `sternheimer.hexa` CG: preallocate b/x/r/p/pc_p/ap2 ONCE + in-place P_c projection
  (`st_project_out_inplace`) — removes ~5 length-n push-arrays per CG iteration.
- `screening_pwfft.hexa`: reuse module buffers for the G-shift columns
  (PWFFT_SHIFTP/M/C) + the cross-density output (PWFFT_RHOOUT); extract the per-(G,v)
  solve into `_qpwfft_stern_chi0_rho`.
- Effect: n=729 transient peak **6064 → ~1180 MB (5×)**.
- Residual = `fft3/ifft3` push()-internal churn (pure-Hexa builtins, cannot be
  buffered from the application layer) → the dominant remainder. → upstream d8.

## does full-ε n=645 complete fault-free now?
- PARTIAL. The 5× reduction does NOT by itself clear jetsam on a RAM-tight Mac
  (~1.5 GB free during testing); the FFT-internal residual still spikes >1 GB.
  With `HEXA_ARRAY_PUSH_ARENA=1` the full n=729 build completes flat (199 MB, exit 0)
  — proving the fix path is correct — but push-arena currently corrupts the result,
  so it is NOT usable until the upstream `__hexa_fn_arena_return` heapify is fixed.
- HONEST (d6): a genuinely fault-free full n=645 run requires the upstream arena fix
  (heapify push escapees + flip push-arena ON, OR per-loop-body arena rewind, OR an
  in-place fft3). The cap-bypass partial cell (`stern_cap`>0) remains the only
  tractable real-data path until then. The hybrid (QE |g|² → QFORGE L3, rel-ε 1.65e-7)
  stays production.

## HEXA_MEM_CAP_MB handling
- Setting it does NOT help and makes it WORSE: it is a CAP, not a floor — when RSS
  crosses N the runtime `exit(77)`s EARLIER than jetsam. Default-OFF
  (`_hx_mem_cap_disabled=1`) is correct. The task's `HEXA_MEM_CAP_MB=12288` would not
  prevent the fault (the transient peak is the problem, not the ceiling). No qforge
  front-end cap raise recommended; the upstream arena fix makes the build flat at a
  few hundred MB on its own.

## g5 regression — GREEN (all PASS, byte-identical numbers)
- qforge_sternheimer_selftest PASS (spectral identity · residual · P_c orthogonality
  · convergence · FD direction)
- sternheimer_chi0_smoke PASS (off-frac=0.0884943 · rel-ε=0.00504607 · solves=10 —
  IDENTICAL to pre-refactor)
- qforge_dfpt_response_selftest PASS · qforge_screened_dv_selftest PASS ·
  qforge_screening_anderson_selftest PASS (all qforge_sternheimer callers)

## d8 handoff
sidecar handoff id **da19aa72** → hexa-lang (full patch:
demiurge `drafts/hexa-runtime-hotloop-array-alloc-jetsam-patch.md`). Repro:
`stdlib/qforge/stern_chi0_memrepro.hexa` @ qforge-cah6-sternheimer-chi0 16ac40d6.

## artifacts
- engine fix: hexa-lang qforge-cah6-sternheimer-chi0 @ 16ac40d6 (pushed to origin)
- repro harness: stdlib/qforge/stern_chi0_memrepro.hexa (same branch)
- d8 patch draft + sidecar handoff da19aa72
