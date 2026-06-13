# CaH6 real-cell stabilization — literature grounding + NOVEL probe (d18)

**Lane C of the QFORGE-NC CaH6 gate.** Grounds two sibling-agent engine fixes — (1) real-cell PW-DFT SCF
basis-stability (etot non-monotone in NPW even under the Mermin free-energy fix), (2) screened ΔV NaN
(needs an Anderson/GMRES screening solver) — in the published literature, and surfaces the best NOVEL route.

Honesty (d6): citations below are verified against abstracts / canonical bibliographic records via arxiv + web
search. Where I could not open the exact value in a primary source I mark it **unverified-citation** and say so.

---

## Q1 — Real-cell PW-DFT SCF basis-stability for high-λ metals (the etot-vs-NPW non-monotone wall)

The wall (etot non-monotone / non-variational in plane-wave count for a metal with bands straddling E_F) is a
**solved, standard problem** in mature PW codes. Three orthogonal machinery layers, ranked by fit for a
from-scratch PW engine:

### (1) Smearing the Fermi occupation with a VARIATIONAL free-energy functional — adopt FIRST
A metal's etot is non-analytic in the cutoff because band crossings of E_F move discontinuously as the basis
changes. The cure is to replace the step occupation with a smooth one AND minimize the corresponding **free
energy** F = E − σS (not E), so the result is variational and stationary in the smearing width σ.
- **Methfessel & Paxton, Phys. Rev. B 40, 3616 (1989)** — Hermite-polynomial ("high-order") smearing. The
  N=1/N=2 MP functions make F converge to the σ→0 (true ground-state) energy to high order in σ, so a
  *modest* k-mesh gives a σ-insensitive, near-variational total energy. **Verified** (canonical record).
- **Marzari, Vanderbilt, De Vita & Payne, Phys. Rev. Lett. 82, 3296 (1999)** — "cold smearing": a
  positive-definite occupation whose free energy is independent of σ to second order, so F ≈ E_{T=0} with
  *no* entropy extrapolation. **Verified** (PRL 82, 3296, 1999 confirmed via web search).
- Fermi-Dirac (Mermin finite-T) smearing is the one the sibling already tried; it is *physically* correct but
  requires the **−TS entropy term added to etot** and a σ→0 extrapolation to be variational — if the sibling
  added Mermin occupations but is still comparing the *band energy* (not F = E − TS) across NPW, that alone
  explains a residual non-monotone etot. **Recommendation: switch the comparison variable to the free energy
  F, and prefer Marzari-Vanderbilt cold smearing over plain Fermi-Dirac** (σ-insensitive to 2nd order ⇒ the
  cleanest etot-vs-NPW curve for a hydride metal). MP-N1 is the robust fallback.

### (2) Dual-grid / dense-FFT-for-density decoupling — adopt SECOND
Decouple the **wavefunction cutoff** (ecutwfc, sets the PW basis for ψ) from the **density/potential cutoff**
(ecutrho, sets the FFT grid for ρ and V). The density has 2× the highest G of ψ, so a charge grid at
4×ecutwfc (norm-conserving) or higher (ultrasoft/PAW augmentation) removes the "egg-box" / aliasing wiggles
that make etot non-monotone as ecutwfc climbs.
- This is QE's `ecutwfc` vs `ecutrho` split and VASP's `ENCUT` / augmentation-grid (`PREC=Accurate`)
  machinery — **Kresse & Furthmüller, Phys. Rev. B 54, 11169 (1996)** (the VASP efficiency paper) and
  **Comput. Mater. Sci. 6, 15 (1996)**. **Verified** (canonical record). For hydrides specifically, H's hard
  1s density demands a dense charge grid — the dual-grid decoupling is essentially mandatory.

### (3) Kerker / Thomas-Fermi preconditioning of the SCF density mixing — adopt to stop charge-sloshing
Independent of the etot-vs-NPW issue but co-occurring on metals: long-wavelength (small-G) density components
must be **down-weighted** in the mix or the SCF "sloshes" and the per-iteration energy is non-monotone.
- **Kerker, Phys. Rev. B 23, 3082 (1981)** — the G²/(G²+G₀²) screening factor on the mixed density (TF-like
  metallic screening). **Verified** (canonical record). Combine with Pulay/Broyden history mixing (see Q2).
- Modern applicability analysis: **Zhou et al., Phys. Rev. E 97, 033305 (2018)** (arXiv:1707.00848). **Verified.**

**Ranked for a from-scratch PW engine:** (1) cold-smearing free-energy functional → (2) dual-grid density
decoupling → (3) Kerker-preconditioned mixing. (1) is the direct fix for the reported non-monotone etot;
(2) removes the residual aliasing wiggle; (3) stabilizes the SCF path to that minimum.

---

## Q2 — Self-consistent screening / linear-response solver that does NOT diverge (the ΔV NaN wall)

The ΔV NaN is the self-consistent Sternheimer/DFPT linear-response equation (I − χ·v)·ΔV = ΔV_ext going
singular at the metal's small gap (χ near-divergent at E_F). Standard fixes, ranked by fit:

### (1) Anderson / Broyden acceleration of the self-consistent response iteration — adopt FIRST
The DFPT response density is solved by the same fixed-point self-consistency as the ground state; replace
naive linear mixing with quasi-Newton history mixing.
- **Anderson, J. ACM 12, 547 (1965)** — Anderson mixing. **Provably equivalent to GMRES on the linear inner
  problem** (web-verified: Anderson acceleration ≡ GMRES for linear systems) — so a from-scratch engine gets
  GMRES-grade robustness from a short residual-history mix without writing a full Krylov solver. **Verified.**
- **Broyden, Math. Comp. 19, 577 (1965)** + **Johnson, Phys. Rev. B 38, 12807 (1988)** ("modified Broyden"
  for SCF) — the DFT-standard Broyden-II history mix; more stable than Anderson near the singular point.
  **Johnson 1988 verified** via web (modified-Broyden-for-self-consistent-calculations record).
- This is exactly what QE's `mix_beta` / Broyden mixing and ABINIT's response-function mixing do inside the
  DFPT loop. **Recommendation: Anderson (≡GMRES, easy to implement) as the default; Broyden-II as the
  hardened fallback.**

### (2) Line-search / adaptive damping + a finite smearing IN the response (broaden the singular χ)
The (I − χv) near-singularity is regularized by the SAME smearing used in Q1 — a finite electronic σ broadens
the E_F δ-function in χ, lifting the divergence; combine with under-relaxation (damped step) when the
residual grows.
- **Baroni, de Gironcoli, Dal Corso & Giannozzi, Rev. Mod. Phys. 73, 515 (2001)** (arXiv:cond-mat/0012092)
  — the canonical DFPT review; §on metals prescribes exactly the smeared-occupation Sternheimer linear
  response that keeps the response equation non-singular for metals. **Verified** (RMP 73, 515, 2001).
- de Gironcoli, Phys. Rev. B 51, 6773 (1995) — DFPT for metals with smearing (the metal-DFPT extension).
  **unverified-citation** (recalled, not opened this round).

### (3) Solve the Sternheimer equation directly (conjugate-gradient / MINRES on the projected linear system)
Rather than forming/inverting (I − χv), solve the per-perturbation Sternheimer equation
(H − ε_n)·|Δψ_n⟩ = −P_c·ΔV·|ψ_n⟩ with the empty-state projector P_c, by CG/MINRES — this never builds the
dense response matrix and is the QE `solve_linter` approach.
- Covered in **Baroni RMP 2001** (above). Pairing the Sternheimer CG inner solve with Anderson/Broyden outer
  self-consistency is the QE/ABINIT-standard stack and is the most NaN-proof combination.

**Ranked for a from-scratch PW engine:** (1) Anderson mixing (≡GMRES, minimal code) on the response density →
(2) finite-σ broadening of χ + damped line-search → (3) projected Sternheimer CG inner solve. (1)+(2) together
are the minimal change that kills the NaN; (3) is the principled long-term solver.

---

## Q3 — Is λ=4.376 a converged published CaH6 value? **NO — it needs re-checking.**

The campaign's QE reference fixture pins CaH6 at **λ=4.376** (per `migration_gate_anchors.hexa`, the
QFORGE→production gate target). **The published, converged literature does NOT support λ=4.376 at the
campaign's stated pressure (172 GPa / 150-250 GPa range):**

| Source | Pressure | λ | Tc | mesh / method |
|---|---|---|---|---|
| **Wang, Tse, Tanaka, Iitaka, Ma, PNAS 109, 6463 (2012)** (arXiv:1203.0263) — the original CaH6 prediction | 150 GPa | **2.69** | 220-235 K (Eliashberg, μ*=0.10/0.13) | DFPT (harmonic) |
| **arXiv:2111.10797** (CaH6 el-ph, 2021) — pressure-dependence study | 150→250 GPa | falls with P (~2.7→lower) | 235→201→187 K @ 150/200/250 GPa | DFPT |
| **Sci. Rep. 14 (2024), s41598-024-69190-0** (PMC11310335) — fully-ab-initio Eliashberg | 170 / 200 / 250 GPa | **2.27 / 1.92 / 1.62** | 225-235 K @ 200 GPa | 96³ k, 8³ q, self-consistent G |

All converged published CaH6 λ at 150-250 GPa fall in **λ ≈ 1.6-2.7**, with the **highest credible harmonic
value ≈ 2.69 at the 150 GPa stability edge** (Wang 2012). **λ=4.376 is ~1.6-2.7× higher than every converged
published value at these pressures** and matches NO standard CaH6 reference. Two ways λ=4.376 could arise — both
arguing AGAINST using it as a gate target:
1. **Low-pressure / near-dynamical-instability regime** (~120-130 GPa): as P→ the Im-3m stability boundary the
   H-cage optical modes soften and λ blows up — but those harmonic phonons are *unstable/under-converged*, not a
   converged number. This is the most likely origin of a 4.x value.
2. **Harmonic-uncorrected DFPT on a soft mesh**: anharmonic SSCHA corrections HARDEN the soft H modes and drop
   λ substantially — e.g. the literature reports anharmonicity cutting CaH6 Tc from **240 K → 190 K**
   (web-verified, J. Phys. Chem. C 2023 / PMC8707326 future-hydrides review). A harmonic λ=4.376 would be a
   strong over-estimate that anharmonicity erases.

**Recommendation:** do NOT treat λ=4.376 as the converged gate target. Re-anchor the QE reference to a
**convergence-tested, k/q-mesh-converged harmonic λ** (target ≈ **2.3-2.7 at 170 GPa**, matching Wang 2012 /
Sci.Rep.2024), and record the pressure + mesh + smearing alongside it. If 4.376 was produced by the campaign's
own QE run, it is almost certainly under-converged (too-coarse q-mesh on soft H modes, or run too close to the
instability pressure) — this is itself a finding the basis-stability fix should resolve.

---

## Q4 — NOVEL route: best alternative to DFPT-linear-response that sidesteps the basis instability

**Best single route: Wannier-interpolated electron-phonon (EPW-style) on top of a frozen-phonon /
finite-displacement supercell force-constant set.**

Rationale (one paragraph): The two diagnosed walls — real-cell SCF basis non-monotonicity and the
linear-response (I−χv) NaN — are **both artifacts of self-consistent DFPT linear response on a metal**. A
**finite-displacement (frozen-phonon) supercell** computes phonons purely from *ground-state* total-energy /
force differences — it never forms the response matrix χ, so the ΔV NaN wall vanishes entirely, and it only
needs the SCF to converge robustly per displaced config (a much weaker requirement, fully handled by the Q1+Q2
mixing fixes). Then **Wannier interpolation (EPW: Giustino, Cohen, Louie, Phys. Rev. B 76, 165108 (2007);
Poncé et al., Comput. Phys. Commun. 209, 116 (2016), arXiv:1604.03525 — both verified)** computes the
electron-phonon matrix elements g(k,q) on a coarse DFT grid and Fourier-interpolates them to an arbitrarily
dense k/q mesh, which is precisely what converges λ for a sharp-Fermi-surface hydride (the published 96³ k /
8³ q convergence is only tractable via interpolation). This combination is *maximally hexa-native*: the
frozen-phonon force constants reuse QFORGE's existing SCF + the campaign's eigen/fft primitives (no new
linear-response solver), and Wannier interpolation is a localized-basis Fourier transform — a natural fit for
a from-scratch engine and a clean fix for the very Γ-only-vs-4×4×4q BZ-undersampling gap the scoreboard already
named (CaH6 rel-ε 97.95%). The MLFF-phonon variant (machine-learned force field → phonons → DFPT-on-top) is a
strong *accelerator* but adds a training-distribution dependence that d6 warns against for the converged gate —
so frozen-phonon + Wannier-EPW is the recommended NOVEL anchor, with MLFF reserved as a later speed layer.

---

## Bottom line for the sibling agents
- **Basis-stability wall:** minimize the FREE energy F=E−σS with **Marzari-Vanderbilt cold smearing** (PRL 82,
  3296, 1999) [or MP-N1, PRB 40, 3616, 1989]; decouple **ecutwfc/ecutrho dual grid** (Kresse-Furthmüller PRB
  54, 11169, 1996); add **Kerker mixing** (PRB 23, 3082, 1981).
- **Screening-NaN wall:** **Anderson mixing** (J.ACM 12, 547, 1965; ≡GMRES on the linear problem) on the
  response density, with **finite-σ broadening of χ** and damped line-search per **Baroni RMP 73, 515, 2001**;
  Broyden-II (Johnson PRB 38, 12807, 1988) as the hardened fallback; projected Sternheimer-CG inner solve.
- **λ=4.376 is NOT a converged published value** — converged CaH6 is λ≈1.6-2.7 (Wang PNAS 2012: 2.69 @150 GPa;
  Sci.Rep.2024: 2.27/1.92/1.62 @170/200/250 GPa). Re-anchor the gate to ≈2.3-2.7 @170 GPa.
- **NOVEL route:** frozen-phonon (finite-displacement) force constants + Wannier-interpolated el-ph (EPW-style)
  — sidesteps DFPT linear response entirely (kills the NaN), reuses QFORGE eigen/fft, and is the right tool to
  converge the dense k/q mesh that the Γ-only undersampling gap demands.
