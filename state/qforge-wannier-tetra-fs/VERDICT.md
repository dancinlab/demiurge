# QFORGE Wannier-interp Fermi-surface + tetrahedron FS integration — VERDICT

**date**: 2026-06-10 · **cost**: $0 (0-pod local-CPU ONLY) · **branch**: `qforge-wannier-tetra-fs`
(isolated worktree off `qforge-elph-normalization`) · **base**: the el-ph NORMALIZATION verdict
(`.verdicts/qforge-elph-normalization/`, λ=9.26e-10 vs QE 4.376, residual named = the Γ-only
Fermi-surface manifold).

## RESIDUAL THIS ROUND ATTACKS (the named 0-pod path, d6)
The normalization round wired ε⁻¹ screening + real N(E_F) + amplitude and lifted λ **+51 orders**
(2.98e-61 → 9.26e-10), but it sampled the α²F double-δ δ(ε_k−E_F)·δ(ε_{k+q}−E_F) at **ONE
k-point (Γ)**, nb=12. QE's λ=4.376 is a CONVERGED full-BZ sum over the 16³ MP k-mesh. The verdict
named the residual the **Γ-only Fermi-surface manifold** and named the 0-pod path: Wannier-interp
FS (`wannier_ginterp.hexa`, exists) + **tetrahedron FS integration**. This round BUILDS the
tetrahedron FS integrator and MEASURES, on the REAL converged CaH6 band structure, whether dense-FS
sampling closes the ~9.5-order gap.

## IMPLEMENTATION (d4-generic, d3/d19 reuse — zero new α²F/DFPT physics) — hexa-lang stdlib
- `stdlib/qforge/tetra_fs.hexa` (NEW) — the **Blöchl 1994 linear-tetrahedron** Fermi-surface
  integrator: `qforge_tetra_build` (6-tetra-per-cube decomposition of a regular k-mesh) +
  `qforge_tetra_dos_weights` / `qforge_tetra_nef` / `qforge_tetra_fs_weight` (the σ-FREE FS measure
  via the per-corner filling-weight derivative, w_i=dI_i/dε, with a degeneracy lift). The σ-free
  convergent replacement for the Gaussian δ(ε_k−E_F).
- `stdlib/qforge/tetra_fs_selftest.hexa` (NEW) — g5 gate, **9/9 PASS**: linear-band tetra DOS ==
  analytic 1/slope to 6.7 % (σ-free, converging), Σ_k w^t_k = N(E_F) exact, parabolic band finite +
  positive + growing with mesh density.
- `stdlib/qforge/fs_dense_a2f.hexa` (NEW) — the dense-FS α²F driver: `qforge_fs_phase_gauss[_wk]`
  (the FS double-δ phase space over a dense / symmetry-weighted k-mesh) · `qforge_fs_phase_tetra`
  (the σ-free tetra FS measure) · `qforge_fs_gamma_phase` (the Γ-only residual baseline) ·
  `qforge_fs_convergence` (the Γ-vs-dense bundle + the λ-scaling ratio).
- `stdlib/qforge/fixtures/cah6_dense_fs_xval.hexa` + `cah6_dense_fs_bands.dat` (NEW) — the CaH6
  measurement, reading the REAL QE scf.out eigenvalues ε_k on all **2052 irreducible k-points of the
  16³ MP mesh** (the answer-key dense FS, **0-pod — NO per-k SCF re-run**, pure d19 reuse of the QE
  converged eigenvalues). The 24624-float eig set is read at runtime from a `.dat` (a 24k-element
  hexa array literal OOM-kills the transpiler — the runtime-parse is the d4 fix).
- (verdict + logs live here in demiurge `.verdicts/qforge-wannier-tetra-fs/`.)

## g5 GATE
- `qforge_tetra_fs_selftest` — **9/9 PASS** (closed-form analytic targets, no number forcing).

## THE DECISIVE MEASUREMENT (VERBATIM — d6, real CaH6, the QE answer-key band structure)
### (1) the dense-FS machinery is VALIDATED against the QE answer-key
```
converged N(E_F) [dense FS, σ=0.068 eV] = 2.450 states/spin/Ry/cell
QE answer-key N(E_F) [ph.out DOS(E_F)]  = 2.484 states/spin/Ry/cell
rel-ε(N_dense, QE)                       = 1.37 %   ← FS DOS REPRODUCED, σ-stable
```
The 0-pod dense-FS integration reproduces the converged QE Fermi-surface DOS to **1.4 %** from the
answer-key ε(k), with NO per-k SCF. The FS-integration machinery is correct and converged.

### (2) BUT dense-FS sampling closes < 1 order of the ~9.5-order λ gap (the HONEST finding)
```
Γ-only N(E_F) used by the prior round  = 159.6 st/Ha = 2.93 st/spin/Ry   ← already ~O(1), near-converged!
dense double-δ / Γ-only double-δ ratio = 3.76
net λ scaling (Sd/Sg)·(N_Γ/N_dense)    = 4.43
λ_dense ≈ 9.26e-10 × 4.43             = 4.10e-09
remaining deficit vs QE 4.376         = 1.07e+09   ← ~9 ORDERS STILL OPEN
```

## OUTCOME (d6 HONEST — outcome (2)/(3): the named residual is RE-POINTED, NOT closed)
- **The Γ-only Fermi-surface k-mesh sampling was NOT the dominant ~9.5-order residual.** The prior
  round's structural diagnosis (the ~5e9 deficit = the missing FS phase space) is **falsified by
  measurement**: the Γ-only N(E_F)=2.93 st/spin/Ry was ALREADY within ~18 % of the converged
  2.484, and the full dense-FS double-δ correction is only **~4.4×**, closing **< 1 order** of the
  ~9.5-order gap.
- **The TRUE residual (~9 orders) lives in the ABSOLUTE |g(k,k+q)|² matrix-element MAGNITUDE**, NOT
  the FS phase-space sampling. The dense-FS axis is now a **closed-negative** (a ruled-out axis):
  refining the k-mesh — even to the converged QE FS DOS — does not lift λ toward 4.376.
- **GATE: HELD (NOT MET). λ NOT forced to 4.376.** Hybrid (QFORGE + QE |g|², rel-ε 1.65e-7) remains
  production · dispatch=qe. cost=$0.
- **NET PRODUCT**: a g5-PROVEN, QE-VALIDATED (1.4 %) tetrahedron + dense-FS integrator (reusable for
  every metallic-wall domain), AND a measurement that RULES OUT the FS-mesh axis and re-points the
  el-ph residual at the |g|² absolute scale — a real diagnostic advance.

## BREAKTHROUGH PATHS for the RE-POINTED residual (d2 — do not concede)
1. **|g|² absolute-scale audit** (the new highest-leverage 0-pod path): the off-diag round lifted
   Σ|g|² ×2.6e33 and the PW-norm fix lifted it another ~22 orders, yet a ~9-order |g|² deficit
   persists. Re-audit the off-diag V_scr(G_a−G_b) vertex magnitude + the ℏ/2Mω amplitude UNITS
   against a single QE |g(Γ,Γ)|² datapoint (QE writes per-mode |g|² in the .elph files) — a direct
   1-number cross-check that localizes the missing |g|² orders WITHOUT any k×q mesh. **0-pod.**
2. **Wannier-interp |g(k,k+q)| on the dense FS** (`wannier_ginterp.hexa`, q-axis verified): now that
   the FS k-mesh is in hand (this round) and validated, interpolate the coarse-q |g| onto the dense
   FS k×q pairs and feed the SAME FS double-δ — isolates whether the |g| MESH (not magnitude) carries
   the residual. Couples this round's FS k-sum to the existing q-axis interp. **0-pod.**
3. **Direct QE |g|² anchor** (hybrid-validation, not migration): pin the QFORGE |g(Γ)|² to the QE
   .elph |g(Γ)|² (rel-ε already 1.65e-7 on the assembled λ) to bound the magnitude gap empirically.

## RETURN (the asked answer, VERBATIM)
- **dense-FS CaH6 λ vs 4.376:** λ_dense ≈ **4.10e-09** (Γ-only 9.26e-10 × the 4.43× dense-FS
  correction) — **NOT within 1 %** (rel-ε ≈ 100 %, remaining deficit ~1.07e9, ~9 orders).
- **did Γ-only → dense raise λ:** YES, but only **~4.4×** (< 1 order) — NOT the ~5e9 the prior round
  projected. The dense-FS N(E_F) is VALIDATED to **1.37 %** of QE (2.450 vs 2.484 st/spin/Ry), so
  the FS machinery is correct; the small λ lift is the HONEST measurement, not a tool failure.
- **≤1 %? or the true final residual / 0-pod convergence limit:** NO, not ≤1 %. The Γ-only FS
  sampling is now a **ruled-out axis** (closed-negative): it is NOT the dominant residual, and 0-pod
  dense-FS is NOT compute-limited here (it already matched QE's N(E_F) to 1.4 % at $0). The TRUE
  final residual is the **absolute |g(k,k+q)|² matrix-element magnitude** (~9 orders) — addressable
  by a 0-pod |g|²-vs-QE single-number audit (path 1), NOT a GPU-pod k×q DFPT. **No GPU pod needed
  to make the next advance.**
