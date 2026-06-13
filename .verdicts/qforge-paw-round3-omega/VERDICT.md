# QFORGE-PAW round-3 — phonon ω(q,ν) audit (QForge vs QE)

**Date**: 2026-06-12 · **0-pod** (mini local) · **cost $0** · **d6/@L5 VERBATIM**
**Script**: `omega_audit.py` (reproducible; parses harvested QE dyn files + reads QForge anchor)

## Question
After round-2 ruled out every |g|(vertex) DFT lever (PBE-SCF Δλ=−0.915, ∂V_NL/∂u
Δλ=−0.003, off-diag ×1.06, basis, FS-mesh N(E_F), f_xc-in-χ — ALL CLOSED-NEGATIVE),
the SOLE remaining magnitude factor in **λ = 2∫α²F/ω dω ∝ Σ|g|²/ω²** (per mode) is the
phonon **ω(q,ν)**. The campaign only ever audited |g|, never ω. IF QForge ω is
systematically HIGHER than QE (phonon harder), λ is suppressed by that factor → ω
would be the deficit culprit. This is a focused single-number diagnostic, the
phonon-side companion of g2-audit.

## Data (VERBATIM)

**QForge ω** — the CaH6-path magnitude is a SINGLE Einstein anchor ω₀ = **1236.4 K =
859.34 cm⁻¹ = 25.762 THz**. Used in `orchestrator_selftest`, `qmesh_qfold_selftest`,
`realcell_qmesh` (header: "ONE hardcoded Einstein frequency ω₀=1236.4 K"),
`nc_norm_convention_selftest`, `qforge_cli`, etc. In `cah6_realcell_compose_xval.hexa`
(lines 268-289) the DFPT dynamical-matrix eigenvalue band is RMS-NORMALIZED and the
**absolute scale is ANCHORED to 1236.4 K** — in-code (d6): *"the broadening (mode
spread) is the real brick-(a) contribution; the absolute scale is anchored, not the
shape."* So the QForge ω magnitude = 1236.4 K by construction; DFPT supplies only the
mode SHAPE/spread.

**QE ω(Γ,ν)** — `exports/rtsc/CaH6/harvest_final/cah6.dyn1`, 3N=21 modes:
- acoustic (sum-rule residual): 22.73 / 22.80 / 23.03 cm⁻¹ (mean 22.85 cm⁻¹ — small,
  nonzero; ASR satisfied to ~23 cm⁻¹, typical of a finite-mesh DFPT solve)
- optical (18): min 928.9, max 1952.2, mean 1342.6 cm⁻¹
- mode-7 = 1011.79 cm⁻¹ = 9.220e-3 Ry — **exactly** the g2-audit-cited value ✓
- λ-weighted ω_log(Γ) = 1076.5 cm⁻¹ = 1548.8 K (λ_tot(Γ)=36.7)

**QE full-BZ ω_log** — all 8 q-points (cah6.dyn1..8 + elph.1..8), 0.005 Ry broadening,
λ-weighted: **ω_log = 853.59 cm⁻¹ = 1228.1 K** (Σλ over q = 122.3).

## Term-by-term ratio (QForge ω / QE ω)

| comparison | QForge | QE | ratio |
|---|---|---|---|
| ω₀ vs ω_log(Γ) | 859.3 cm⁻¹ | 1076.5 cm⁻¹ | **0.798** |
| ω₀ vs ω_log(full-BZ) ★ | 859.3 cm⁻¹ | 853.6 cm⁻¹ | **1.0067** |

Required ratio IF ω were the culprit (λ ∝ 1/ω²): √(λ_QE/λ_QForge) =
√(2.69/1.1545) = **1.53** (reanchor) or √(4.376/1.1545) = **1.95** (outlier).

## VERDICT — outcome (2): ω is NOT the λ-deficit culprit

- QForge ω matches the QE **full-BZ ω_log to 0.67%** (ratio 1.0067). This is not a
  coincidence: the 1236.4 K anchor was itself taken "VERBATIM from the demiurge
  verdict" (the QE el-ph dataset's own ω_log), so QForge's phonon SCALE *is* QE's.
- For ω to explain the λ-gap, QForge would need ω **1.53-1.95× HIGHER**. It is instead
  essentially EQUAL — and at Γ slightly **LOWER** (0.798×), which if anything would
  RAISE QForge λ, not lower it. The deficit direction is the opposite of what an
  ω-driven gap requires.
- **ω is ruled out, in the same family as round-2's CLOSED-NEGATIVE results.** The
  residual is the irreducible **from-scratch (NC+LDA) vs QE-PBE |g| vertex magnitude**,
  consistent with round-1/2's conclusion. Both magnitude factors in Σ|g|²/ω² are now
  audited: ω matches QE; the gap lives entirely in |g|.

## Consequence
Gate **HELD** (no flip; no 2.69/4.376 forcing — d6). The hybrid path (QE |g|² → QForge
L3, rel-ε 1.65e-7) remains production; dispatch stays QE. With ω now closed on the
phonon side, the campaign's named DFT levers (functional · off-diag · basis · FS-mesh ·
f_xc · ∂V_NL · **ω**) are ALL exhausted within the NC frame. The only un-probed lever is
B3 augmentation-density overlay ∂ρ_aug/∂u (round-1 PAW lever, predicted small by
arXiv:2507.06749's NC≈PAW off-core result). If B3 is also small, this is the HONEST
TERMINAL: from-scratch-vs-QE |g| is irreducible and hybrid stays permanent production.

## CLOSED-NEGATIVE (do not retry)
- **phonon ω(q,ν)** — QForge matches QE full-BZ ω_log to 0.67%; ratio in the wrong
  direction to explain the gap. Added to: B1 PBE-SCF · f_xc-in-χ ALDA · off-diag ×1.06 ·
  basis · FS-mesh · ∂V_NL/∂u.
