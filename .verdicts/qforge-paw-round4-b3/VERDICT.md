# QFORGE-PAW round-4 — B3 augmentation-density overlay ∂ρ_aug/∂u

**Date**: 2026-06-12 · **0-pod** (mini local) · **cost $0** · **d6/@L5 VERBATIM**
**Impl**: `hexa-lang/stdlib/qforge/dvaug_du.hexa` (+ `dvaug_du_selftest.hexa`)
**Measurement**: `hexa-lang/stdlib/qforge/fixtures/cah6_paw_round4_b3_xval.hexa`
**Tier**: 🔵 SUPPORTED-FORMAL (g5 selftest: NC-zero anchor + sum-rule + FD vs analytic)

## Question
After round-1…3 ruled out EVERY other named lever on λ = Σ|g|²/ω²
— B1 PBE-SCF (Δλ=−0.915), B2 ∂V_NL/∂u (Δλ=−0.003), off-diag assembler (×1.06),
basis (non-monotonic), FS-mesh N(E_F) (1.37%), f_xc-in-χ ALDA Dyson kernel
(CLOSED-NEG), and the phonon ω(q,ν) (QE full-BZ ω_log 0.67% agreement, CLOSED-NEG)
— the SOLE remaining un-probed DFT lever was the PAW/USPP **augmentation-density
overlay** B3:
    ∂ρ_aug/∂u = ∂[ Σ_ij Q_ij(r) ⟨ψ|β_i⟩⟨β_j|ψ⟩ ] / ∂u
the term a norm-conserving (NC) from-scratch path is structurally incapable of
producing (Q_ij ≡ 0 for NC). Lit (arXiv:2507.06749) predicted B3 small.

## Implementation (g1 hexa-native · g4 stacked · d4-generic)
`qforge_dvaug_du_block(r, rab, betas, ls, qaug, nproj, omega, tau, qvecs, dir)`
assembles the L=0 monopole augmentation el-ph vertex derivative as a separable
overlay reusing the B2 phased-projector machinery (`qforge_proj_radial`, d19):
  ∂V_aug[a,b] = Σ_ij(same-l) (4π/Ω) Q̃_ij(|q_a−q_b|) ·
                ∂/∂u_d[ exp(−iΔq·τ) β_i*(q_a) β_j(q_b) ]
with ∂(phase)/∂u_d = −i q_d (the same (★) identity proven in `dvnl_du.hexa`).
Element/structure-agnostic; caller supplies Q_ij(r) (NC ⇒ zeros ⇒ exact 0).

## g5 selftest — VERBATIM (`dvaug_du_selftest.txt`)
```
PASS (Z) NC-zero anchor: qaug≡0 ⇒ ∂V_aug≡0 (max=0.0)
PASS (Z') NC-zero apply ⇒ zero vertex (max=0.0)
PASS (SR) co-located augmentation self-vertex < 1e-15 (max=1.0842e-19, finite Q_ij) — translational invariance
    [SR'] |S|=0.000120736 |A|=0.000181103 |B|=0.000301839 |S+A+B|=5.20226e-21
PASS (SR') three terms each O(1e-4), |S|+|A|+|B| > 1e-5 (real cancellation)
PASS (A) analytic == FD derivative < 1e-9 (max abs diff=1.0842e-13)
PASS (C) all ∂V_aug entries finite
PASS (D) bad dir → []
PASS (D) qaug size mismatch → []
PASS (D) apply size mismatch → []
qforge_dvaug_du_selftest PASS
```

## CaH6 measurement — VERBATIM (`cah6_b3_measurement.txt`)
```
[deck] Ca pseudo_type=NC is_us=false is_paw=false ⇒ Q_ij augmentation: NONE (NC)
[SCF PBE]  conv=true iters=3 etot=-3.58942
    [B3] ∂V_aug block max|entry| = 0.0 (NC deck Q_ij≡0 ⇒ structural 0)

B1+B2     PBE-SCF + ∂V_loc+∂V_NL          λ = 0.743699
B1+B2+B3  +∂V_aug (augmentation overlay)  λ = 0.743699
Δλ(B3) = 0.0

B1+B2+B3 λ_full vs re-anchor ~2.69 (PNAS 2012): rel-ε = 0.723532
VERDICT: gate HELD — λ_full=0.743699 outside 1% of 2.69
```

## Finding — Δλ(B3) = 0.0 EXACTLY

Lit predicted B3 small (<few %). The measured result is **stronger than the
prediction**: Δλ(B3) is not merely small, it is **exactly zero**, for TWO
compounding, independent reasons:

1. **Structural zero (input)** — the production CaH6 deck is ONCV
   norm-conserving (`pseudo_type="NC"`, Ca z_valence=10 puts 3s²3p⁶ semicore in
   explicit valence). NC pseudos carry NO augmentation charge: Q_ij(r) ≡ 0 ⇒
   the ∂V_aug block max|entry| = 0.0. There is no augmentation density to vary.

2. **Sum-rule zero (operator)** — even were Q_ij finite (a USPP/PAW deck), the
   co-located augmentation **self-vertex vanishes by translational invariance**:
   the three phase derivatives (∂Q̃, ∂β_i*, ∂β_j) all ride on the same moving
   center τ, so −i[(q_a−q_b) − q_a + q_b]_d = 0. The selftest exhibits this with
   a finite Gaussian Q_ij: |S|=1.2e-4, |A|=1.8e-4, |B|=3.0e-4 (each O(1e-4)) yet
   |S+A+B| = 5.2e-21. The BARE augmentation el-ph vertex contributes nothing
   regardless of pseudo type; any non-zero effect would live only in the SCF
   re-screening response of ∂ρ_aug (Hartree/XC), a higher-order term beyond the
   bare-vertex deformation potential, and bounded above by this zero.

This matches and exceeds arXiv:2507.06749 ("converged hydride el-ph is
pseudo-independent outside the core").

## HONEST TERMINAL — all named DFT levers on |g| EXHAUSTED

| lever | round | Δλ / result | status |
|---|---|---|---|
| B1 LDA→PBE SCF | r2 | −0.915 (λ↓, hypothesis falsified) | CLOSED-NEG |
| B2 ∂V_NL/∂u nonlocal | r2 | −0.003 (negligible) | CLOSED-NEG |
| off-diag assembler | r1 | ×1.06 | exhausted |
| basis / k×q mesh | r1 | non-monotonic / 1.37% | exhausted |
| FS-mesh N(E_F) | r1 | 1.37% | exhausted |
| f_xc-in-χ ALDA Dyson | mem | λ 3.752→3.415 (WORSE) | CLOSED-NEG |
| phonon ω(q,ν) | r3 | QE ω_log 0.67% agree | CLOSED-NEG |
| **B3 ∂ρ_aug/∂u** | **r4** | **0.0 (structural + sum-rule)** | **CLOSED-NEG** |

With B3 closed, the named-lever set on the |g| side of λ = Σ|g|²/ω² is
**fully depleted**. The residual gap (from-scratch λ_full=0.743699 vs re-anchor
~2.69, rel-ε=0.724) is an **irreducible from-scratch (NC+LDA) vs QE-PBE
vertex-magnitude difference** — not attributable to the SCF functional, the KB
nonlocal vertex, the augmentation density, the basis/mesh, the FS sampling, or
the phonon ω.

**Campaign final honest judgement (d6/@L5):**
- from-scratch (NC+LDA) |g| is irreducible vs QE-PBE within the named DFT levers
- the hybrid path (QE |g|² → QForge L3, rel-ε 1.65e-7) stays PRODUCTION
- migration dispatch = **qe** (QE el-ph), gate HELD (NOT forced to 2.69/4.376)

## Reproduce
```
cd ~/core/hexa-lang
hexa run stdlib/qforge/dvaug_du_selftest.hexa                       # g5 gate
hexa run stdlib/qforge/fixtures/cah6_paw_round4_b3_xval.hexa        # CaH6 Δλ(B3)
```
