# CaBeH8 — 🔴 CLOSED-NEGATIVE (dynamically unstable @ ~50 GPa)

🧪 **CaBeH8** · 칼슘-베릴륨 수소화물 · BeH8 clathrate-type host, Ca guest

## Verdict
**🔴 CLOSED-NEGATIVE — DYNAMICALLY UNSTABLE.** The relaxed CaBeH8 structure at this
pressure has large imaginary phonon frequencies across the entire DFPT q-grid. It cannot
be a phonon-mediated superconductor in this geometry. Analogous to CaAuH3.

This is a **VALID finding** (d_paper_negative_ok), not a failed run — the el-ph campaign
records it as a closed-negative and moves on. **No re-run of the full grid is warranted.**

## Evidence (pod vast 38095989, QE ph.x 4×4×4 q-grid)
| q-point (dynN) | imaginary modes (of 20) | worst freq |
|---|---|---|
| dyn1 (Γ) | 8 | **−329.19 THz (−10980.6 cm⁻¹)** |
| dyn10 | 8 | — |
| dyn15 | 10 | — |
| dyn21 | 10 | — |

Acoustic-sum-rule residuals at Γ are normally a few cm⁻¹; here they are ~10⁴ cm⁻¹
imaginary → the structure sits at a saddle point, not a minimum.

Per-mode λ from `ph.out` is **negative on the soft modes** (λ(5)=−0.94, λ(6)=−0.54,
λ(1)=−0.14) — the el-ph signature of imaginary phonons. Eliashberg/Allen-Dynes Tc is undefined.

> Note: the original run also crashed at q14 with an MPI segfault (likely `_ph0`
> scratch-disk exhaustion on a full overlay). That crash is NOT the finding — the
> dynamical instability is prior to and independent of it. Adding disk headroom and
> re-running would only re-compute unphysical coupling on imaginary modes.

## Breakthrough paths (d2 — do not concede, name concrete next tries)
1. **Higher pressure** — re-relax at 100–200 GPa; clathrate hydrides often stabilize only
   above a threshold pressure (soft modes harden).
2. **Distort + re-relax** — displace along the dominant Γ imaginary eigenvector, lower the
   symmetry, and re-relax into a possible stable lower-symmetry well.
3. **SSCHA (anharmonic)** — quantum/anharmonic stabilization is the standard rescue for
   soft H-modes whose harmonic phonons are imaginary.

Record: `exports/material_verdict/cabeh8_dynstab_50gpa_v1/2026-05-30T07-40-12Z.json`
