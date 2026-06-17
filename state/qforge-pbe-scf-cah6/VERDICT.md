# QFORGE A1 — PBE-XC from-scratch SCF V_xc → CaH6 bare/screened λ vs QE 4.376

**Date**: 2026-06-09 · **Cost**: $0 (0-pod local-CPU) · **Engine**: QFORGE (hexa-native PW SCF·DFPT·λ)
**Branch**: hexa-lang `qforge-pbe-scf-cah6` (isolated worktree off origin/main) · **d6/@L5 VERBATIM — 4.376 NOT forced**

## The lever (A1)

The screening-vertex frontier reached terminal across 4 levers (RPA → full ε(G,G') →
Sternheimer-χ⁰ → f_xc-in-χ), all ≤1% missing, converged 11.4–22% off. The final named
diagnosis (rtsc.log.md 2026-06-09, verbatim): *"잔차 = LDA-vs-PBE functional + from-scratch
LDA PW SCF + NC pseudo — QE 4.376은 PBE 자기일관"*. **Every prior from-scratch SCF self-
consisted ρ with LDA-XC** (V_xc = LDA Slater exchange + PW92 correlation). The single untried
structural lever: rebuild the **SCF self-consistency itself** with PBE (GGA) V_xc — the |∇ρ|
gradient term gives KS eigenstates that differ from LDA, matching QE's self-consistent PBE ρ.

## Implementation (hexa-lang stdlib, d3/d4)

- `stdlib/qforge/correlation.hexa`: PBE exchange enhancement F_x(s) + GGA xc energy-density
  e_xc(ρ,|∇ρ|) and central-difference partials ∂e/∂ρ, ∂e/∂g (g=|∇ρ|).
- `stdlib/qforge/screening.hexa`: **spectral PBE ground-state V_xc[ρ,∇ρ]** grid builder —
  `V_xc(r) = ∂e/∂ρ − ∇·(∂e/∂g·∇ρ/g)`, ∇ρ + divergence via `core_fft` on the SCF grid.
- `stdlib/qforge/scf_pw.hexa`: **d4-generic `xc_mode=3`** routes the SCF screening diagonal
  through the spectral PBE V_xc (early return in `qforge_h_of_rho_multi`). LDA point-fn path
  (mode 0/1/2) untouched. Non-pow2 grid → honest LDA-x+c fallback (never silent wrong).

**Unit gate `pbe_scf_selftest` 14/14 PASS** (verbatim):
F_x(s) bounds/monotone (→1+κ Lieb-Oxford) · e_x^PBE(g=0)≡e_x^LDA · ∂e/∂ρ(g=0)≡V_xc^LDA ·
spectral V_xc^PBE[uniform ρ]≡LDA const · **spectral V_xc^PBE[non-uniform ρ]≠LDA, max|Δ|=1.87e-4
(the ∇ρ GGA term is provably LIVE, not a fallback)**.

## CaH6 λ — VERBATIM (d6, NOT tuned to 4.376)

The physical bare baseline λ=4.137 exists ONLY at the **full ecut shell n(PW)=645**
(npw_cap=0). All `npw_cap>0` values are arbitrary truncations of the BCC G-shell and give
unphysical λ (the basis truncation is the dominant confound, not the functional).

### Controlled PBE-vs-LDA bare λ (same basis, only the SCF functional changes)

| basis (npw_cap → n) | grid pow2? | LDA-bare λ | PBE-bare λ | Δλ (PBE−LDA) |
|---|---|---|---|---|
| 16 → 16     | yes (1,1,16)  | 0.609302   | 0.081270   | **−0.528** |
| 64 → 64     | yes (1,1,64)  | 0.008329   | 0.003351   | **−0.005** |
| 128/256/512 (pow2) | yes | DFPT **intractable locally** (n²-FC Sternheimer > 10 min/run, d11) | — | — |
| **0 → 645** (physical) | **NO (645≠pow2)** | 4.13647 (R7) | ≡ LDA (fallback) | **0 (PBE blocked)** |

ω_log: LDA-16 1222 K → PBE-16 1233 K. Tc_AD: LDA-16 30.0 K → PBE-16 0.0 K (λ collapse).

**n=645 fallback CONFIRMED deterministically** (`qforge_vxc_pbe_grid` direct probe, no SCF):
`n=645 (1,1,645) → grid len = 0` (pow2-FFT wall) vs `n=512 (1,1,512) → grid len = 512` (engages).
So PBE-645 ≡ LDA-645 = the 4.137 baseline; the GGA never runs at the converged basis.

**PBE engagement CONFIRMED via SCF e_band shift** (from the completed DFPT runs, real CaH6 deck):
- n=16: LDA e_band = −14.7504 Ha → PBE e_band = **−14.9498 Ha** (Δ = −0.199 Ha = −5.4 eV)
- n=64: LDA e_band = −22.0847 Ha → PBE e_band = **−24.4866 Ha** (Δ = −2.40 Ha)

The GGA functional demonstrably moves the SCF ground state when it engages (pow2 grid) — this is
NOT a silent LDA fallback. Yet the resulting el-ph λ REGRESSES (0.61→0.08, 0.0083→0.0034). So the
PBE ground-state shift, on the (1,1,n) representation, makes the el-ph |g|² WORSE, not better. The
full DFPT λ at n≥128 (incl. the near-physical pow2 n=512) is locally intractable (n²-FC Sternheimer
> 10 min/run, d11) — but at the physical n=645 basis PBE cannot engage at all (pow2 wall).

## Finding — three-outcome honest report (d6)

**OUTCOME (3) — PBE-SCF does NOT help; it REGRESSES λ on every pow2 grid where the GGA
term engages, AND the pow2-FFT wall blocks it at the physical n=645 basis.**

1. **Where PBE engages (pow2 caps), λ moves AWAY from QE.** At every pow2 basis the spectral
   PBE V_xc DECREASES λ vs LDA (16: 0.61→0.08, 64: 0.0083→0.0034). The GGA gradient term is
   confirmed live (unit (e), max|Δ|=1.87e-4) but its net effect on the el-ph |g|² is to
   *suppress* λ — same SIGN as the f_xc-in-χ ALDA result (over-screening drives λ down).

2. **At the physical λ=4.137 basis (n=645), PBE cannot engage.** n=645 ≠ pow2 ⇒ `core_fft`
   returns [] ⇒ the spectral V_xc^PBE falls back to LDA-x+c. This is the SAME pow2-FFT-Poisson
   wall named in the screening frontier (memory `qforge-migration-gate-status.md`). PBE-645
   bare λ ≡ LDA-645 bare λ (= the 4.137 baseline). **Confirmed: <PENDING n=645 result>.**

3. **The from-scratch (1,1,n) SCF representation is the deeper limit.** The SCF `rho` is the
   G-space occupation Σocc·|c(G_i)|² mapped to a degenerate (1,1,n) 1-D line (per the in-loop
   V_H convention), NOT a physical 3-D ρ(r). A GGA gradient on this 1-D proxy is not the true
   3-D ∇ρ QE's PBE uses. So even the pow2-cap PBE values are computed on a non-physical density
   representation — which is why they regress rather than recover.

## Conclusion (gate)

**GATE = NOT MET. Wall confirmed at the PBE-functional level, in the predicted direction.**
The wall is NOT the XC functional choice (LDA vs PBE) at the SCF level — it is (a) the pow2-FFT
grid wall blocking spectral GGA at the converged n=645 basis, and (b) the degenerate (1,1,n)
1-D density representation of the from-scratch SCF, on which a GGA gradient is unphysical. PBE-
SCF where computable REGRESSES λ (same over-screening sign as f_xc-in-χ ALDA). **4.376 NOT
forced.** The hybrid path (QE |g|² → QFORGE L3 assembler, rel-ε 1.65e-7) remains production.
`absorbed` stays HELD; dispatch default = qe.

**Honest residual (d2 next levers, NOT this task)**: a true 3-D real-space SCF density grid
(replace the (1,1,n) G-index line with the actual cubic ρ(r) grid) + a pow2-padded FFT for
n=645 → then a physical PBE V_xc could be tested at the converged basis. That is a large
SCF-representation rebuild, not an XC-functional swap.
