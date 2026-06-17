# QFORGE-PAW round-2 — B1 (LDA→PBE SCF) + B2 (∂V_NL/∂u) — VERDICT

**date**: 2026-06-12 · **cost**: $0 (0-pod, mini local-CPU; summer not needed)
**repo**: hexa-lang · **branch**: `qforge-paw-round2` (worktree `/private/tmp/wt-paw2`, cut from origin/main)
**modules**: `stdlib/qforge/dvnl_du.hexa` (+selftest) · `stdlib/qforge/dvnl_du_block.hexa`
  (+selftest) · fixture `stdlib/qforge/fixtures/cah6_paw_round2_b1b2_xval.hexa`
**PR**: hexa-lang (3 stacked commits — bricks dvnl_du · dvnl_du_block · measurement fixture)

## SCOPE
Round-1 (`drafts/qforge-paw-round1-design.md`) identified Route B's first two levers as the
SOLE un-tried gate axes after every other axis was ruled out:
  • **B1** — LDA→PBE in the GROUND-STATE SCF (distinct from the f_xc-in-χ Dyson *screening*
    kernel, which was CLOSED-NEGATIVE — that was the screening functional, NOT the SCF one).
  • **B2** — the MISSING nonlocal deformation potential ∂V_NL/∂u (the from-scratch CaH6 compose
    path dropped the KB nonlocal part entirely, `nprojs=[0,0]`).
Hypothesis under test: the live ~1.95× |g| residual (λ 1.15 vs QE) is LDA→PBE SCF + the missing
∂V_NL/∂u, and closing them lifts λ toward the re-anchored converged target **~2.69** (PNAS 2012,
PBE+PAW; the textbook 4.376 is an under-converged outlier).

## IMPLEMENTATION (g1 hexa-native, g5-verified)

### B2 brick-1 — `dvnl_du.hexa` (∂β_i/∂u_d KB projector derivative)
The phased projector β_i(q)=β̃_i(|q|)exp(−iq·τ) is position-dependent only through the phase, so
∂β_i(q)/∂u_d = −i q_d β_i(q) (structure-factor route, reuses `qforge_proj_radial` — d19).
**g5 selftest VERBATIM** (`dvnl_du_selftest`, l=0 Gaussian fixture):
```
PASS (A) FD vs analytic ∂β/∂u < 1e-6 (all q,dir)
PASS (B) ∂β/∂u(−q)=conj(∂β/∂u(q)) < 1e-10 (max=0.0)
PASS (C) Γ-head ∂β/∂u(q=0) re = 0 (-0.0)
PASS (C) Γ-head ∂β/∂u(q=0) im = 0 (0.0)
PASS (A') explicit ∂β/∂u_x re @q=(0.5,0,0) (got -0.0212786, rel 1.13539e-11)
PASS (A') explicit ∂β/∂u_x im @q=(0.5,0,0) (got -0.113705, rel 1.13538e-11)
PASS (D) bad dir → []  /  size mismatch → []  /  qvecs not 3· → []
qforge_dvnl_du_selftest PASS
```

### B2 brick-2 — `dvnl_du_block.hexa` (full ∂V_NL/∂u block + apply)
⟨q_a|∂V_NL/∂u_d|q_b⟩ = Σ_ij D_ij[conj(∂β_i(a))β_j(b)+conj(β_i(a))∂β_j(b)] (product rule on
V_NL=Σ|β_i⟩D_ij⟨β_j|), same-l addition-theorem angular factor matching `qforge_vnl_block` (d19).
**g5 selftest VERBATIM** (`dvnl_du_block_selftest`, l=0 Gaussian D=2.5):
```
PASS block size 2·nq²
PASS (A) ∂V[a,b]=conj(∂V[b,a]) < 1e-10 (max=0.0)
PASS (B) FD(phased V_NL) vs analytic ∂V < 1e-5 (max rel=1.44762e-10)
PASS (C) apply == explicit Σ_b ∂V[a,b]ψ(b)
PASS (D) Σ_a Re ∂V[a,a] = 0 (got 2.04367e-18)
PASS (E) bad dir → []  /  Ω≤0 → []  /  apply size mismatch → []
qforge_dvnl_du_block_selftest PASS
```
The block is exactly the τ-derivative of the SAME V_NL the assembler uses (FD anchor at 1e-10).

## CaH6 MEASUREMENT (VERBATIM — d6, NOT tuned, mini 0-pod $0)
`cah6_paw_round2_b1b2_xval.hexa` — NPW=64 converged SCF, 4 configs on ONE cell. Bare-composed
a+b+c (single Einstein ω₀=1236.4 K + real N(E_F)=Γ single-k; the band & N(E_F) are IDENTICAL
across configs so each Δλ isolates the |g|² change). Sternheimer screening NOT used (metastable
on the converged cell — compose-fixture note); the bare-composed vertex is the robust comparator.

| config | SCF XC | vertex | λ (VERBATIM) | Δλ vs baseline |
|--------|--------|--------|--------------|----------------|
| (0) BASELINE | LDA (xc_mode=1, G-diag) | ∂V_loc/∂u | **1.65742** | — |
| (1) **B1** | **PBE (xc_mode=3, RS3D)** | ∂V_loc/∂u | **0.742514** | **−0.914903** |
| (2) **B2** | LDA | ∂V_loc/∂u + **∂V_NL/∂u** | **1.65433** | **−0.00309022** |
| (3) **B1+B2** | PBE | ∂V_loc/∂u + ∂V_NL/∂u | **0.743699** | −0.91372 |

SCF physicality (both genuine non-degenerate metallic manifolds):
  • LDA: converged 21 iter, etot=2.74425, e_F=1.10718, eps[0]=−1.76726, spread=3.0119 Ha
  • PBE: converged 3 iter, etot=−3.58942 (Δetot=−6.33367 Ha), e_F=0.781892, eps[0]=−2.27519, spread=3.07474 Ha

Gate (re-anchor 2.69): |0.743699−2.69|/2.69 = **0.7235** (textbook 4.376: rel-ε 0.8301).

## VERDICT — outcome (3): round-1 hypothesis FALSIFIED (d6/@L5 HONEST)
- **B1 (PBE-SCF) moves λ the WRONG way.** A genuinely converged, deeper-bound PBE ground state
  (etot −3.589 vs LDA +2.744; e_F 0.782 vs 1.107) **LOWERS** λ from 1.657 → 0.743 (Δλ=−0.915),
  it does NOT lift λ toward the re-anchored 2.69. The round-1 culprit ranking — "the ~1.95× |g|
  residual is mostly LDA→PBE SCF" — is **DISPROVEN**: aligning the ground-state functional to QE's
  PBE does not recover QE λ; it suppresses it. PBE deepens the well and pulls E_F down, reducing
  N(E_F) and the Fermi-surface |g|²/ω.
- **B2 (∂V_NL/∂u) is negligible AND slightly negative.** Adding the full, g5-verified missing
  nonlocal deformation potential changes λ by only −0.0031 (~0.19%). The KB nonlocal el-ph head is
  NOT the missing magnitude — consistent with arXiv:2507.06749 (NC ≈ PAW off-core for hydride el-ph).
- **Gate HELD** (NOT flipped). λ_full=0.743699 is 72% below the 2.69 re-anchor and 83% below 4.376.
  Neither lever closes the 1% bar. **No λ forced to 2.69 or 4.376** (d6 verbatim). The hybrid path
  (QE |g|² → QFORGE L3, rel-ε 1.65e-7) stays the QE-grade production route; dispatch=qforge NOT
  flipped from this work.
- **What this rules out (the value of a closed-negative):** the from-scratch λ deficit is NOT the
  SCF XC functional choice (LDA vs PBE) and NOT the missing KB nonlocal vertex. Combined with the
  prior CLOSED-NEGATIVES (f_xc-in-χ ALDA Dyson kernel; off-diag assembler ×1.06; basis/k×q-mesh;
  FS-mesh N(E_F)), every NAMED ground-state/vertex DFT lever inside the NC framework is now walked
  down. The residual is a deeper NC-vs-PAW core/augmentation effect OR a phonon-side (ω, screened
  ΔV, anharmonic) magnitude — NOT a ground-state functional or nonlocal-vertex term.

## NEXT (un-tried by this negative — for round-3 / B3)
- **B3 — augmentation-density overlay ∂ρ_aug/∂u** (the genuine PAW piece round-1 deferred): load
  Q_ij(r) for H from a USPP/PAW UPF, add ∂ρ_aug/∂u into ∂V_scf/∂u as a perturbative overlay on the
  converged NC ψ (no generalized eigenproblem). This is the ONE lever the round-1 design left for
  after B1/B2, and the ONLY remaining clean-ish NC→PAW magnitude test. NOTE the lit caveat
  (2507.06749): converged hydride el-ph is pseudo-INDEPENDENT off-core, so B3 is expected SMALL —
  if it too is negligible, the NC-framework gate is exhausted and the hybrid path is the verdict.
- **Phonon-side re-examination**: B1's λ-suppression came through E_F/N(E_F); the bare single-ω₀
  band is a scope simplification. A converged screened ΔV + real q-resolved ω(q,ν) (gated on a β
  knob in qforge_force_constant, d2) may carry magnitude the bare-composed path misses — but that
  is an accuracy refinement, not a 2×-magnitude lever.
- DO NOT re-attempt B1 (PBE-SCF) or the f_xc-in-χ kernel — both now CLOSED-NEGATIVE.

## provenance
- bricks + measurement: hexa-lang branch `qforge-paw-round2` (3 stacked commits, pushed origin).
- live install `~/.hx/src/stdlib/qforge/` carries the same files (hexa run source resolution).
- run logs: `/tmp/wt-paw2/round2_measure.log`, `round2_measure_probe.log` (manifold physicality).
- d6 VERBATIM throughout; cost = $0.
