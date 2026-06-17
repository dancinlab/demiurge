# VERDICT — Li2MgH16 8-q el-ph assembled λ / ω_log / Tc (3rd migration-gate anchor)

- **id**: qforge-li2mgh16-8q-assembled
- **date**: 2026-06-09
- **tier**: 🟢 GATE_CLOSED_MEASURED (real QE-DFPT el-ph data, assembled via verified hybrid path)
- **engine**: QFORGE hybrid assembler (QE `electron_phonon='simple'` .elph → α²F → λ → ω_log → Allen-Dynes Tc)

## Data provenance (g5/g6/g63 — REAL bytes, no fabrication)

- **Source**: recovered from a now-**DESTROYED** vast.ai anchor pod **39610026** (Li2MgH16 gate
  anchor). The pod had completed **all 8/8 q-points** of the 2×2×2 nosym q-mesh before being killed;
  the dyn/elph outputs were harvested to local disk prior to/at teardown.
- **Files** (`exports/rtsc/Li2MgH16/harvest_final/`, verified complete):
  `li2mgh16.dyn0` (q-grid) + `li2mgh16.dyn1..8` (dynamical matrices) +
  `li2mgh16.dyn1.elph.1 .. dyn8.elph.8` (el-ph matrix elements).
- **Cell**: nat=38 (Li2MgH16 ×2 fu clathrate), **114 modes/q** (38×3), QE 7.5,
  ecutwfc=60 / ecutrho=480, k 8×8×8, MP smearing degauss **0.020 Ry**.
- **q-grid**: `dyn0` declares 2×2×2 (8 q-pts). The 8 q-vectors are the distinct {0,±½}³-type grid
  points (Γ + 7), none symmetry-merged at the grid level ⇒ equal weight **w_q/W = 1/8 ∀q**
  (identical to the CaH6 & LaH10 2×2×2 nosym anchors).
- **Primary broadening**: el-ph σ-sweep is 0.005..0.050 Ry (el_ph_nsigma=10); the **physical**
  value = the scf self-consistent MP degauss **0.020 Ry** (same protocol as CaH6/YH10 L3 anchors).

## Assembler

- Driver = `exports/rtsc/Li2MgH16/harvest_final/assemble_lambda.py` (d19 reuse — copied + adapted
  from the LaH10 terminal anchor `LaH10/lambda_terminal/assemble_lambda.py`, which replicates QE
  `lambda.x` math: λ = Σ_q (w_q/W) Σ_ν λ(q,ν), ω_log = exp(Σ wλ ln ω / Σ wλ), Allen-Dynes Tc).
- The .elph byte layout is **identical** to the CaH6 fixture parsed by the formally g5-verified
  path `stdlib/qforge/qforge_cah6_qe_xval_test` (rel-ε **1.6524e-7** — RE-VERIFIED this session,
  `PASS`). Same header (qvec + nsig + nmodes), same ω²[Ry²] freq block, same 10 Gaussian-broadening
  λ(q,ν) blocks. The assembled λ was **independently cross-checked** by a from-raw-bytes parse
  (no assembler) → identical λ=5.7893 at 0.020 Ry.

## Assembled result (VERBATIM driver output, primary 0.020 Ry)

```
=== PRIMARY broadening (scf degauss = 0.020 Ry) — gate anchor number ===
mu*=0.10:  lambda=5.7893  omega_log=740.69 K  Tc_AD=164.12 K
mu*=0.13:  lambda=5.7893  omega_log=740.69 K  Tc_AD=158.46 K
```

Broadening sweep (μ*=0.10), showing the converged plateau (0.010–0.030 Ry):

```
broad(Ry)    lambda   wlog(K)  Tc_AD(K)
    0.005    9.4185    771.05    185.85   <- outlier (too-narrow smear, undersampled)
     0.01    5.9491    731.44    163.03
    0.015    5.9309    742.70    165.43
     0.02    5.7893    740.69    164.12   <- PRIMARY (scf degauss)
    0.025    5.5943    736.77    162.01
     0.03    5.3459    735.34    159.99
     0.035   5.1016    735.77    158.26
     0.04    4.8918    737.15    156.86
     0.045   4.7222    738.99    155.77
     0.05    4.5880    741.12    154.98
```

Per-q λ-sum at 0.020 Ry: q1(Γ)=12.07, q2..q8 ∈ {4.32, 5.32}. The Γ point carries the inflated
small-q coupling (expected — el-ph λ(q) ∝ 1/ω² peaks at small q); the 7 finite-q points are stable.

## Comparison to literature

- **Li2MgH16** (Sun, Hou, Lv, Yang, Liu — *Phys. Rev. B* **102**, 144524 (2020), arXiv:1907.09691):
  predicted the **highest-Tc** conventional superconductor known in silico — **Tc ≈ 473 K @ 250 GPa**,
  driven by λ ≈ **3.3** with a high ω_log (sodalite-like H clathrate around Li, "atomic-H-like" DOS).
- **This 8-q assembly @ 0.020 Ry**: **λ = 5.79** (HIGHER than the literature 3.3), **ω_log = 741 K**
  (LOWER / softer than the literature dense-mesh, which sustains the high Tc via a stiff ω_log),
  **Tc_AD = 164 K (μ*=0.10) / 158 K (μ*=0.13)** — i.e. **~1/3 of the predicted 473 K**.

## HONEST mesh-convergence caveat (d6 / @L5) — NOT 473 K

This is a **coarse 2×2×2 (8-q) q-mesh**. It is **NOT converged** to the literature dense-mesh result,
and the discrepancy is the **expected, well-understood coarse-mesh pathology**, not a refutation of
the Li2MgH16 prediction:

1. **λ over-shoots (5.79 vs 3.3)** because a coarse q-grid puts disproportionate BZ weight (1/8) on the
   Γ / small-q points where λ(q) ∝ 1/ω²(q) diverges (q1 alone = 12.07). A dense mesh averages this
   divergence down toward ~3.3.
2. **ω_log under-shoots (741 K vs the stiff literature value)** for the same reason — the small-q soft
   acoustic-adjacent modes dominate the log-average on a coarse grid, pulling ω_log down. Allen-Dynes
   Tc scales **linearly** with ω_log, so a softened ω_log directly suppresses Tc.
3. Net: the over-large λ and under-large ω_log partially offset, landing Tc_AD at ~164 K. **The coarse
   mesh cannot reach 473 K** and **we do NOT force it** — reaching the predicted value requires a
   **denser q-mesh** (literature used a finer grid) to converge both λ↓ and ω_log↑.

**The number that this anchor contributes to the migration gate is the assembled λ/ω_log/Tc on the
real QE el-ph bytes via the verified assembler — λ=5.79, ω_log=741 K, Tc=164/158 K — NOT a projection
of 473 K.** The gate validates the *assembler↔QE* consistency (already g5-PASS at rel-ε 1.65e-7 on
CaH6); Li2MgH16 now provides the **3rd real terminal el-ph anchor** (CaH6 ✓ · LaH10 ✓ · Li2MgH16 ✓),
all three assembled through the same byte-identical path.

## g5 verdict

- `qforge_cah6_qe_xval_test` (the canonical assembler-path g5) **PASS** (rel-ε 1.6524e-7) — RE-VERIFIED
  this session, confirming the integrator + parser applied to Li2MgH16 is the verified one.
- Li2MgH16 .elph layout byte-identical to that verified fixture; independent raw-byte λ parse =
  assembler λ (5.7893) — agreement to all printed digits.
- **RULING: 🟢 Li2MgH16 8-q el-ph assembled — real QE data, verified hybrid path.**
  λ=5.79 · ω_log=741 K · Tc_AD=164 K(μ*=0.10)/158 K(μ*=0.13). Coarse-mesh caveat recorded; 473 K NOT
  claimed (mesh-convergence, d6).
