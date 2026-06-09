# QFORGE — TRUE 3-D real-space SCF density ρ(r) (the (1,1,n) 1-D G-index REBUILD)

**Date**: 2026-06-09/10 · **Cost**: $0 (0-pod local-CPU) · **Engine**: QFORGE (hexa-native PW SCF·DFPT·λ)
**Branch**: hexa-lang `qforge-3d-realspace-scf` (isolated worktree off origin/main) · **d6/@L5 VERBATIM — 4.376 NOT forced**

## The lever (the ROOT named by A1 PBE-SCF)

The screening-vertex + functional frontier reached terminal across 6+ levers (RPA → full ε(G,G') →
Sternheimer-χ⁰ → f_xc-in-χ → PBE-SCF), all ≤1% missing, converged 5–22% off. The A1 PBE-SCF verdict
named the deepest root **verbatim** (rtsc.log.md 2026-06-09): the wall is NOT the XC functional choice
(LDA vs PBE) — it is **(a)** the pow2-FFT grid wall blocking spectral GGA at the converged n(PW)=645
basis, and **(b)** the degenerate **(1,1,n) 1-D G-index** density of the from-scratch SCF, on which a
GGA gradient ∇ρ is unphysical. The named next lever: *"a true 3-D real-space SCF density grid (replace
the (1,1,n) G-index line with the actual cubic ρ(r) grid) + a pow2-padded FFT for n=645."* **This task
is exactly that rebuild.**

## Implementation (hexa-lang stdlib, d3/d4)

- **`stdlib/qforge/scf_pw_realspace.hexa`** (NEW) — the true 3-D real-space density module:
  - pow2-PADDED 3-D cube staged from the integer Miller (h,k,l) per PW coefficient (singular-B-safe);
    n=645 maps onto a **32³ cube** (each axis a power of two ≥ 4·max|hkl|+1) — **the n≠pow2 wall is gone**.
  - `ρ(r) = Σ_b occ_b·|ψ_b(r)|²` via ψ(G) scatter → ifft3 → ψ(r) on the cube (physical density, ∫ρ=nelec).
  - 3-D spectral gradient ∂ρ/∂x_d = ifft3(i·G_d·ρ(G)) **per axis** (a genuine 3-D ∇ρ — the (1,1,n)
    line could only ever produce one flattened direction).
  - spectral PBE V_xc[ρ,|∇ρ|] = ∂e/∂ρ − ∇·(∂e/∂g·∇ρ/g) + PBE exchange F_x(s) + 3-D Hartree V_H = 4π ρ(G)/|G|².
  - reusable scratch buffers (cleared, not reallocated) — the hot-loop jetsam guard.
- **`stdlib/qforge/scf_pw.hexa`** — `qforge_scf_pw_h_multi_smeared_rs3d` routes the SCF screening through
  the 3-D ρ(r) (opt-in `PW_RS3D_ON`; capture `rho_of_psi` stores ψ for the reconstruction; LDA path
  untouched — `scf_pw_selftest` regression **20/20 PASS**).
- **`stdlib/qforge/pw_frontend.hexa`** — `qpw_set_rs3d(true)` toggle drives the front-end SCF through the
  3-D path (qpw_gvectors_miller for the exact integer Miller indices). d4-generic; default OFF.

**g5 gate `qforge_scf_pw_realspace_selftest` 10/10 PASS** (analytic plane-wave/cosine targets, no
number-forcing — `selftest_10of10.txt`):
A pow2 cube (n=7 odd, Miller±5 → 32³) · B uniform ρ ⇒ |∇ρ|=0 on all 3 axes · C PBE V_xc[uniform] ≡ LDA
V_xc (GGA→LDA reduction exact) · **D cos(G·x) ⇒ peak |∇ρ| = A·|G| exactly (the genuine 3-D gradient a
(1,1,n) line cannot produce)** · E 3-D Hartree = 4π/|G|² exact · F ∫ρ dr = nelec · G PBE V_xc[cos] ≠ LDA
(GGA term LIVE) · H F_x(s) bounds.

## CaH6 λ — VERBATIM (d6, NOT tuned to 4.376)

### The rebuild's CORE CLAIM is CONFIRMED: PBE engages at the converged n=645 basis (first time ever)

| run | n(PW) | cube | SCF conv | e_band (Ha) | result |
|---|---|---|---|---|---|
| LDA (1,1,n) baseline | 16 | (1,1,16) | ✓ | −14.7504 | λ=**0.609302** (matches A1 baseline) |
| **PBE-3D real-space** | **645** | **32³ pow2-pad** | ✓ (3 iters) | −61.7889 | **SCF CONVERGES — PBE ENGAGES** |

The A1 verdict: *"at the physical n=645 basis PBE cannot engage at all (pow2 wall)"* (n=645≠pow2 →
`core_fft` returns [] → LDA fallback). **The 3-D pow2-padded cube REMOVES that wall** — PBE V_xc[ρ,∇ρ]
runs self-consistently at n=645 for the first time. **Root cause (a) is RESOLVED.**

### But λ collapses to ~0 — the deeper root is the DIAGONAL-ONLY assembler, not the density

| run | n(PW) | λ (VERBATIM) | ω_log (K) | Tc (K) | vs QE 4.376 |
|---|---|---|---|---|---|
| LDA (1,1,n) cap16 | 16 | 0.609302 | 1222.2 | 30.0 | (baseline) |
| LDA 3-D-rs cap16 | 16 | **1.15e-57 ≈ 0** | 1205.6 | 0.0 | collapse |
| PBE 3-D-rs cap16 | 16 | **7.16e-242 ≈ 0** | 1270.4 | 0.0 | collapse |
| **PBE 3-D-rs n=645** | **645** | **1.43e-88 ≈ 0** | 1224.7 | 0.0 | collapse |

**Why λ→0**: the assembler (`assembler.hexa`) adds the screening `vscr_diag[a]` **ONLY to the diagonal
H[a][a]** — it discards the off-diagonal V(G_a−G_b). For a **local** potential V(r), the exact diagonal
matrix element is ⟨G_a|V|G_a⟩ = (1/Ω)∫V(r)dr = **V(G=0) = V̄, identical for every coefficient a**. A
correct 3-D real-space V_scr(r) therefore contributes ONLY its spatial average V̄ to the diagonal — a
uniform constant shift that does NOT modulate the el-ph coupling → **λ→0**.

**Quantified at n=645 (the dropped structure, `offdiag645.txt`)** — off-diagonal RMS / |V̄|:
- **V_H : 4.8×10¹⁵** (V̄≈0 by neutral gauge — the Hartree is ~100% off-diagonal, all discarded)
- **V_xc: 0.69** (69% of the XC structure is off-diagonal, discarded)
- **V_scr combined: 5.56** (556% of the diagonal V̄ is off-diagonal structure the assembler cannot carry)

**The (1,1,n) path's nonzero λ=0.609 was an ARTIFACT**: it fed a **per-G-varying** diagonal
(V_xc(rho[a]), with rho[a] = the G-space occupation Σocc·|c(G_a)|²) — which is NOT the diagonal a real
local potential contributes (that is V̄, the same for all a). The per-G variation injected non-physical
per-coefficient structure that happened to produce a finite λ. Replacing it with a **physically-correct**
3-D ρ(r) + correct local-potential projection (V̄) exposes that the diagonal carries essentially no el-ph
screening — the screening physics lives entirely in the off-diagonal the assembler discards.

## Finding — three-outcome honest report (d6)

**OUTCOME (2)+(3): the 3-D rebuild BREAKS the pow2-FFT wall (a real advance), and in doing so PINPOINTS
the TRUE remaining root — the diagonal-only assembler, NOT the density representation.**

1. **Root cause (a) RESOLVED** — the pow2-padded 3-D cube makes the converged n=645 basis map onto a
   valid FFT grid; spectral PBE V_xc[ρ,∇ρ] engages and the SCF converges at n=645 for the first time
   (the A1-named wall is gone). The g5 gate proves the 3-D ∇ρ is genuine (case D: peak|∇ρ|=A·|G| exact).

2. **Root cause (b) RE-DIAGNOSED** — it is NOT that a GGA gradient on the (1,1,n) line is "unphysical"
   per se; it is that the **assembler is diagonal-only**. A *correct* 3-D ρ(r) projected as a *correct*
   local potential gives λ→0 because the diagonal can carry only V̄. The (1,1,n) path's λ=0.609 came from
   an *unphysical* per-G diagonal — so the prior "3-D will fix it" hypothesis is **FALSIFIED in the
   predicted-opposite direction**: with the physics done correctly, the diagonal assembler yields ~0, not
   4.376. The real screening (offdiag RMS/V̄ = 5.56 at n=645) is in the off-diagonal V(G≠0).

3. **4.376 NOT forced.** The hybrid path (QE |g|² → QFORGE L3 assembler, rel-ε 1.65e-7) remains
   production. `absorbed` stays HELD; dispatch default = qe.

## Conclusion (gate)

**GATE = NOT MET (λ ≈ 0, not ≤1% of 4.376). 4.376 NOT forced.** The wall is now located precisely: it is
**the G-DIAGONAL-ONLY screening of `assembler.hexa`**, which can carry only the spatial average V(G=0) of
any local potential. A true 3-D real-space ρ(r) + spectral GGA (this rebuild) **resolves the pow2-FFT
wall** the A1 verdict named, but the screening's el-ph-relevant structure (offdiag RMS/|V̄| = 0.69 for
V_xc, 5.56 for V_scr at n=645) is **off-diagonal** and is discarded before it reaches the KS operator.

**Honest residual (d2 next lever, NOT this task)**: feed the screening as the FULL **off-diagonal**
V_scr(G_a−G_b) matrix into the assembler (replace the diagonal-only `vscr_diag` with the dense
⟨G_a|V_scr|G_b⟩ = V_scr(G_a−G_b) the 3-D ρ(r) now makes available via FFT). The 3-D real-space ρ(r) built
here is exactly the input that off-diagonal assembly needs — but the assembler rewrite (dense local-
potential matrix, n² scaling) is a separate large piece. That is where the diagonal V̄→0 collapse becomes
the full per-(G,G') screening the el-ph |g|² actually sees.

## Artifacts
- `selftest_10of10.txt` — g5 gate 10/10 PASS (analytic targets)
- `lam16.txt` — controlled cap16: LDA(1,1,n)=0.609 vs LDA-3D≈0 vs PBE-3D≈0
- `scf645.txt` — PBE-3D n=645 SCF CONVERGES (the pow2-wall break, e_band=−61.79, cube=32³)
- `lam645b.txt` — PBE-3D n=645 λ=1.43e-88 (VERBATIM)
- `offdiag645.txt` — off-diagonal RMS witness: V_H=4.8e15, V_xc=0.69, V_scr=5.56 (the dropped structure)
