# The Missing Local Field — QFORGE screened vertex, round 7

Arxiv-style paper documenting **round 7** of the QFORGE from-scratch screened
electron–phonon vertex search, which **reverses** the prior six-round
"closed-negative / bare-is-best" ruling.

## TL;DR

Engaging the structurally-dead local-field exchange–correlation convolution
`f_xc[ρ(r)]·Δρ(r)` (never previously *called* in the production Woodbury
vertex; folds 0→24) raises CaH₆ `λ` to **4.1518** — the **first** of seven
rounds to **cross** the bare baseline `λ_bare = 4.137`, and the first to beat
the bare vertex's own QE-distance (**rel-ε = 5.12% < bare 5.47%**). The local
field was the missing enhancement physics.

Honest ceiling (d6): 5.12% does **not** meet the ≤1% production-migration gate.
Residual = LDA-vs-QE XC functional (QFORGE: LDA-x + PW92-c ALDA; QE: full
ε⁻¹). Round 8 (GGA `f_xc`) is in progress. The from-scratch screened engine is
**not closed — converging**; the validated hybrid route (QE |g|² → QFORGE
assembler, rel-ε = 1.65×10⁻⁷) remains the production path for gate-grade `T_c`.

## Build

```
make            # → main.pdf  (tectonic / xelatex)
make pages      # page count
make lint       # /paper lint .
```

## Provenance

- Central result: `.verdicts/qforge-cah6-fxc-localfield-r7/VERDICT.md` (verbatim).
- Trajectory rows: `.verdicts/qforge-cah6-{lindhard,rpa-chi0-r4,dvscf-r5,phonon-scr-r6}/`.
- Bare baseline: `qforge-lane1-basis-sweep`.
- Engine-status SSOT: `QFORGE/QFORGE.md` ⭐ ENGINE STATUS mode (c).

## Note

Supersedes the never-committed draft `qforge-screened-vertex-closed-negative`
(slug retired — its central "bare-is-best / closed" claim was falsified by R7).
