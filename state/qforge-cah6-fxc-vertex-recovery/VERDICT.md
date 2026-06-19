# QFORGE gate-close fxc-vertex lane — recovery + honest depletion verdict (v0.241.6)

Recovery of the fxc-vertex (screened-vertex f_xc-in-χ) lane after the prior agent halted
~07:05 at a session limit, leaving the 64³ screened-Dyson λ verdict unharvested. Core bug
#3620 (`cannot multiply non-numeric operand (tag 1 * tag 16)`) was resolved between sessions
(hexa v0.241.6). This round recovers the prior outputs, re-runs the screened-vertex pipeline
to confirm the core unblock, and renders the honest depletion verdict (d6 / d_qforge_migration_routing).

## 1 — Prior-output recovery (the 07:05 halt)

The prior agent's depletion probe swept an **xc-grid-mul** axis (mul = 2 / 4 / 6 = finer
f_xc[ρ(r)] quadrature density) over the screened-vertex fixture. ALL of those /tmp runs DIED
at the `cannot multiply (tag 1 * tag 16)` core bug, in the screening fold (DBG-A loop), BEFORE
emitting any λ:

| /tmp log | xc-grid-mul | outcome |
|---|---|---|
| cah6_base.log / base2.log | 2 (R7-exact) | EXIT=1 — cannot multiply, NO λ |
| cah6_gm4.log / gm4b.log | 4 | EXIT=1 — cannot multiply, NO λ |
| cah6_gm2.log / gm3.log | 6 | EXIT=1 — cannot multiply, NO λ |
| cah6_head_r7.log | 0 (full shell) | EXIT=143 (killed/timeout) |

**The depletion probe never produced a verdict** — the core bug killed every grid setting.
The xc-grid-mul code + the R7 local-field f_xc code (`qpwfft_fxc_localfield_from_dpsi`) were
edited only in a transient worktree that was swept; they are NOT in `~/.hx/src` and NOT in git
history (verified `git grep` across all branches = absent). The IMPLEMENTATION is lost; the
VERDICTS survive (in state/qforge-cah6-fxc-localfield-r7/VERDICT.md etc.).

## 2 — Re-run on v0.241.6 (core-unblock confirmation) — d6 VERBATIM

Re-ran the checked-in screened-vertex fixture (the exact path that died at #3620) end-to-end:

```
cd ~/.hx/src ; HEXA_LANG="$PWD" hexa run --no-sentinel \
  stdlib/qforge/fixtures/cah6_fullbz_xval.hexa \
  exports/rtsc/decks/CaH6_NC 0 4 1 0.3 5
```

Result (raw log: `cah6_screened_v0241_6_repro_run.log`, this dir):

- **cannot-multiply = 0** — ran the FULL pipeline (SCF → Sternheimer → DFPT → elph → a2f → λ)
  through the screening fold that previously died instantly. **Core bug #3620 RESOLVED on this path.**
- SCF-converged=true (17 iters) · n(PW)=645 · e_band=−65.2189 Ha (reproduces prior runs exactly)
- f_xc LOCAL-FIELD CONVOLUTION **ENGAGED**: POW2-FFT grid 32³ · folds=21 · local-ALDA-folds=21 ·
  k_TF²=1.93464 · last_err=0 ("genuine RPA+ALDA local-field convolution ENGAGED — f_xc[ρ(r)]")
- Dyson loop: 18 iters · conv=false · ‖fp_res‖_max=311.016 · ‖ΔV_scr‖/‖ΔV_bare‖=1.0
- DFPT: 0 acoustic zeros (dynamically stable)
- **QFORGE λ = 4.13658** · QE answer-key 4.376 · **rel-ε = 5.47111%** · Δλ vs bare 4.13647 = +0.00011
- ω_log = 1370.5 K · Tc(Allen-Dynes) = 381.5 K · Tc(Eliashberg) = 412.1 K
- **GATE: NOT MET** — 5.47% > 1% (NOT forced to 4.376)

## 3 — Depletion judgment (the task's three honest outcomes)

🧱 **xc-grid-density axis = DEPLETED / from-scratch screened-vertex = CLOSED-NEGATIVE.**

The screened-vertex (Dyson ε⁻¹ + ALDA f_xc-in-χ + R7 local-field f_xc) has now been swept
across EVERY xc lever and NONE reaches the ≤1% gate — the migration_gate SSOT already records
the f_xc lever as CLOSED-NEGATIVE, and this round confirms it on the unblocked core:

| screening channel | λ | rel-ε vs QE 4.376 | source |
|---|---|---|---|
| BARE (no screening) | 4.13647 | 5.47% | run #2768 |
| RPA (v_c only) | 3.75221 | 14.25% | gga-fxc-in-chi VERDICT |
| ALDA f_xc-in-χ | 3.41513 | 21.96% | gga-fxc-in-chi VERDICT |
| GGA(PBE) f_xc-in-χ | 3.41256 | 22.02% | gga-fxc-in-chi VERDICT |
| screened ΔV Dyson (+local-field f_xc, this run) | 4.13658 | **5.47%** | THIS run (v0.241.6) |
| R7 local-field f_xc (best from-scratch) | 4.1518 | 5.12% | fxc-localfield-r7 VERDICT |

Verbatim findings:
- The screened ΔV collapses to BARE (‖ΔV_scr‖/‖ΔV_bare‖=1.0 ⇒ λ 4.13658 ≈ bare 4.13647): the
  Dyson fixed point does NOT converge (conv=false, ‖fp_res‖=311) on this small Γ-class cell, so
  screening provides essentially NO enhancement at the assembled-λ level.
- f_xc-in-χ (ALDA/GGA) OVER-screens (λ drops to ~3.41, 22% under QE) — the kernel functional
  choice is RULED OUT as the closer (gga-fxc-in-chi VERDICT, A2).
- The single point that ever crossed bare is R7's local-field f_xc (λ=4.1518, 5.12%) — best
  from-scratch, still 5× over the gate. Its implementation is now lost (transient worktree).

**The xc-grid-density axis is exhausted** (pow2 quantization → only 32³/64³ reachable; the
prior probe found 64³ alive but the core bug killed it before λ; on the unblocked core the
screened vertex collapses to bare regardless). The residual is NOT the xc kernel/grid — it is
the **Dyson fixed-point gain** (ρ(L)→1⁻ on the small cell, ‖fp_res‖ blows up: aldafloor VERDICT
round-3) plus the **ground-state-functional / pseudo / χ⁰-completeness** gap (gga-fxc-in-chi).
NOT an OOM/substrate wall — the 4-proc n=645 run lives at ~2.5 GB RSS.

## Remaining named levers (d2 — not a ceiling, classified residual)

Per ARCHITECTURE.json gate_close_plan: (1) q-dependent / anisotropic f_xc + folds↑, (2)
degenerate-subspace Sternheimer, (3) bound the Dyson ρ(L) self-consistently (full ε(q)
regularization of the SELF-CONSISTENT operator, not the single-shot kernel), (4) from-scratch
PBE-SCF ground state (SIGSEGV'd previously). These are the genuine next probes if the
from-scratch route is re-attempted.

## Gate status — UNCHANGED, HELD (the from-scratch failure does NOT block the gate)

`migration_gate = HELD`. The QFORGE λ/Tc assembly (L0–L5) is ALREADY native gate-grade
(CaH6 1.65e-7), and **PRODUCTION = mode-(b) hybrid** (QE DFPT |g|² → QFORGE assembler).
fxc-vertex is a from-scratch *breakthrough attempt* only; its CLOSED-NEGATIVE outcome leaves
the gate closed by the hybrid path. No 4.376 forcing anywhere (d6).

raw log: cah6_screened_v0241_6_repro_run.log (this dir)
