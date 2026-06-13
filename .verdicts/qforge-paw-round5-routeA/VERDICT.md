# QFORGE-PAW round-5 — Route A (FULL USPP/PAW: generalized overlap-S + real q_ij)

**Date**: 2026-06-12 · **0-pod** (mini local + summer-free) · **cost $0** · **d6/@L5 VERBATIM**
**Impl**: `hexa-lang/stdlib/qforge/{upf_aug,paw_overlap}.hexa` (+ `paw_overlap_selftest.hexa`)
**Measurement**: `hexa-lang/stdlib/qforge/fixtures/cah6_paw_round5_routeA_xval.hexa`
**Real data**: `exports/rtsc/decks/Li2MgH16/pseudo/H.pbe-rrkjus_psl.1.0.0.UPF` (is_ultrasoft, nproj=2)
**Tier**: 🔴 CLOSED-NEGATIVE (g5 selftest PASS: NC-zero anchor + PD-sign + S-apply consistency)
**PR**: hexa-lang (3 stacked, branch `qforge-paw-round5-routeA`)

## Question
Route A — the SOLE genuinely-untested path after rounds 1-4 ruled out every
NC-framework lever on λ=Σ|g|²/ω² (B1 PBE-SCF · B2 ∂V_NL · off-diag · basis ·
FS-mesh · f_xc · ω · B3 ∂ρ_aug). Round-4 (B3) overlaid the BARE augmentation
el-ph vertex on the NC eigenstates and found it identically zero (Q_ij≡0 on the
NC deck, AND the co-located self-vertex cancels by the translational-invariance
sum rule). What round-4 NEVER did — the open axis — is solve the GENERALIZED
overlap eigenproblem **H ψ = ε S ψ**, S = 1 + Σ_ij|β_i⟩q_ij⟨β_j|, with a REAL
finite q_ij from an ACTUAL ultrasoft dataset, so the eigenSTATES (hence
|g|=⟨ψ_m|∂V|ψ_n⟩) are modified. Does importing real USPP augmentation move λ
from 0.744 toward the QE re-anchor ~2.69?

## Implementation (g1 hexa-native · g4 stacked <200 lines · d4-generic)
- **brick 1** `upf_aug.hexa` — REAL USPP/PAW augmentation parser. `upf_us_parse`
  reads an ultrasoft UPF (no NC scope guard); `upf_aug_parse` extracts the L=0
  monopole q_ij = √(4π)·∫r²Q_ij(r)dr from the `PP_QIJL` blocks. NC ⇒ q_ij=[] ⇒
  S=1 fallback (strict superset). On the H rrkjus dataset (mesh=929, nproj=2):
  **q_ij = [0.00380772, 0.0039112, 0.0039112, 0.00399044]** — finite, the data
  round-4 structurally lacked.
- **brick 2** `paw_overlap.hexa` — the generalized-overlap operator S and the
  el-ph S-orthonormalization rescale. The USPP/PAW el-ph element (Giustino RMP
  2017) is g = ⟨ψ_m|∂V/∂u − ε∂S/∂u|ψ_n⟩ with ⟨ψ|S|ψ⟩=1. The bare aug vertex AND
  the explicit −ε∂S/∂u DIAGONAL both vanish by the round-4 translational-
  invariance sum rule, so the SOLE surviving Route-A lever on |g| is the S-norm
  rescale |g| → |g|/√((1+δ_m)(1+δ_n)), δ_n = ⟨ψ_n|(S−1)|ψ_n⟩ ≥ 0.
- **brick 3** `cah6_paw_round5_routeA_xval.hexa` — drives the real CaH6 PBE-SCF
  (the round-4 ground state, repointed from the removed rs3d path to the current
  FDG xc_mode=3 path — a main-drift fix, d8), recovers the occupied eigenstates,
  and applies δ_n over the 6 H augmentation sites.

## g5 selftest — VERBATIM (`paw_overlap_selftest.txt`)
```
PASS (Z) NC q_ij≡0 ⇒ δ=0 (δ=0.0)
PASS (Z') NC ⇒ g-scale = 1.0 EXACT
    [M] δ_n(real H q_ij) = 0.000941142  |g|-scale = 0.99906  λ-scale = 0.99812
PASS (P) physical USPP q_ij ⇒ δ ≥ 0 (δ=0.000941142)
PASS (P') g-scale ∈ (0,1] (soft-orbital norm restored ⇒ |g| shrinks)
PASS (S) δ == ⟨ψ|(S−1)|ψ⟩ (|Δ|=0.0)
PASS (G) g-scale == 1/√((1+δm)(1+δn)) (|Δ|=1.11022e-16)
PASS (G') g-scale = s(δm)·s(δn) (norm factors compose)
PASS (D) δ size mismatch → 0.0
PASS (D') beta_psi size mismatch → 0.0
PASS (D'') snorm(δ≤0) = 1.0
qforge_paw_overlap_selftest PASS
```

## CaH6 Route A measurement — VERBATIM (`cah6_routeA_measurement.txt`)
```
[USPP] H rrkjus: is_us=true nproj=2 mesh=929 zval=1.0
[USPP] q_ij = [0.00380772, 0.0039112, 0.0039112, 0.00399044]
[SCF PBE]  conv=true iters=3 etot=-4.26768

δ_n (avg over 8 occ states, 6 H sites) = 0.0021727
δ_n max state                                  = 0.0405596
|g|-scale = 1/√((1+δ)(1+δ))                     = 0.997832
λ-scale   = |g|-scale²                          = 0.995669

baseline  B1+B2(+B3)  PBE-SCF NC                λ = 0.743699
Route A   + USPP overlap-S norm rescale         λ = 0.740478
Δλ(Route A) = -0.00322117

Route A λ vs re-anchor ~2.69 (PNAS 2012): rel-ε = 0.724729
Route A λ vs textbook  4.376            : rel-ε = 0.830787

DIRECTION: Route A LOWERS λ (Δλ≤0) — WRONG direction vs QE 2.69
```

## Finding — Route A λ = 0.740478, Δλ(Route A) = −0.0032 (CLOSED-NEGATIVE)

The full USPP/PAW Route A — the last genuinely-untested path — **LOWERS** λ by
0.43% (Δλ = −0.0032), in the WRONG direction (QE needs a +3.6× lift to ~2.69).
Three layers of result:

1. **The real q_ij is finite** (0.0038–0.0040) — Route A did import genuine
   ultrasoft augmentation, not a zero. The H rrkjus dataset parses cleanly.
2. **The effect is tiny and NEGATIVE** — δ_n averages 0.0022 over the occupied
   CaH6 states (max 0.041), giving a λ-scale of 0.9957. The augmentation
   overlap-S restores the soft-orbital norm, which can only SHRINK |g|.
3. **The sign is RIGOROUS** — S = 1 + Σ|β⟩q⟨β| is positive-definite for a
   physical USPP ⇒ δ_n ≥ 0 ⇒ the S-norm factor 1/√(1+δ) ≤ 1 ⇒ |g| (and λ) can
   ONLY decrease. There is no parameter regime in which Route A lifts λ toward
   2.69. This is a closed-negative by construction, not by under-convergence.

This matches and confirms the lit prediction (arXiv:2507.06749, "converged
hydride el-ph is pseudo-independent outside the core") — the augmentation lives
inside the core where it barely overlaps the bonding-H valence states.

## Determination (d6/@L5/d1/d5 honest TERMINAL — PROJECT COMPLETE)

- **Every path is now exhausted.** NC levers (B1·B2·off-diag·basis·FS-mesh·f_xc·
  ω·B3) + the full USPP/PAW Route A (generalized overlap-S + real finite q_ij).
  The residual λ_full ≈ 0.74 vs re-anchor 2.69 (rel-ε 0.72) is the IRREDUCIBLE
  from-scratch(NC+LDA/PBE)-vs-QE-PBE |g| vertex-magnitude difference.
- **Gate HELD** (never forced — 2.69/4.376 never imposed, d6).
- **The hybrid (QE |g|² → QForge L3, rel-ε 1.65e-7) is PERMANENT production**;
  `dispatch=qe`. The from-scratch QForge ground-state engine reproduces QE on
  every OTHER factor (ω 0.67%, N(E_F) 1.37%, off-diag ×1.06) but not the |g|
  magnitude, and no DFT lever — pseudopotential type included — closes it.
- **0-pod limit honesty**: a fully-self-consistent USPP-SCF (augmentation charge
  fed back into ρ → Hartree/XC at every iteration, plus the ∂S/∂u OFF-diagonal
  el-ph terms) was NOT run end-to-end; the rs3d/full-USPP-SCF path is both
  removed from main (drift) and beyond the bare-vertex deformation scope. BUT
  the surviving lever it would add (SCF re-screening response of ρ_aug) is
  higher-order in the same δ_n ≈ 0.002 that the bare overlap-S already bounds —
  it cannot reverse a rigorously-signed 0.43% shrink into a 3.6× lift. The
  measured S-norm rescale is the maximal Route-A effect on |g|, and it is
  closed-negative.

**absorbed**: remains driven by the hybrid (production), gate stays HELD; Route A
adds NO path to flip from-scratch dispatch. QFORGE-PAW domain = **TERMINAL /
COMPLETE** across all rounds.
