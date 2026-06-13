# QFORGE screened el-ph vertex — literature grounding + FIX RECIPE

> **Lane 6 of the 6-lane QFORGE migration-gate fleet.** READ-ONLY research (d18). Does NOT edit
> `stdlib/qforge` (lanes 1-3 own the engine) and touches no pod.
>
> **Problem (measured, d6).** The independent QFORGE-only path computes CaH6 **λ = 0.18**
> vs QE DFPT **λ = 4.376** — a **~24× under-coupling**. Diagnosed cause: the from-scratch
> screened el-ph vertex (ε⁻¹-dressed |g|²) built by an Anderson-damped single-shot RPA/Dyson
> loop is far too WEAK relative to QE's self-consistent DFPT screening of ΔV_scf.
>
> This doc answers: **how do the established codes (QE ph.x, EPW, ABINIT DFPT) get the screened
> vertex right**, and turns it into a **prioritized fix-recipe table** the engine lanes apply.
>
> **Honesty tag convention.** `[EST]` = established physics, directly cited. `[INF]` = my
> inference about which QFORGE approximation causes the gap (not separately cited; flagged so
> lanes treat it as a hypothesis to test, not a fact).

---

## 0. The one-sentence finding

**`[EST]` The screened el-ph vertex in every production code is NOT a single-shot ε⁻¹ applied to a
bare |g|. It is `g = ⟨ψ_{k+q} | ∂V_scf | ψ_k⟩` where `∂V_scf` is the *self-consistently converged*
first-order change of the full Kohn-Sham effective potential** — bare ionic + induced-Hartree +
induced-xc — solved by the DFPT/Sternheimer linear-response loop to self-consistency. **`[INF]` A
single-shot RPA/Anderson Dyson pass under-screens because it stops the feedback loop after one
iteration, and (separately) because the induced charge density `∂n` is itself under-resolved by a
too-small plane-wave basis and too-coarse k for the dielectric response.** The two most likely
gap-closers are therefore **(1) iterate ∂V_scf to true self-consistency** and **(2) raise the basis
+ k density that builds ∂n** — in that priority order. EPW's lesson is the cleanest: it never
re-derives screening — it *interpolates the already-screened DFPT ∂V_scf*.

---

## 1. How QE `ph.x` builds the self-consistent screened ΔV_scf (the core mechanism)

`[EST]` DFPT (Baroni–de Gironcoli–Dal Corso–Giannozzi, RMP 73, 515, 2001) computes the
first-order response to a phonon displacement by solving a **self-consistent** linear-response
problem. The screened first-order potential is

```
ΔV_scf(r) = ΔV_bare(r)  +  e² ∫ Δn(r')/|r−r'| dr'  +  (dV_xc/dn)·Δn(r)
            └ ionic ┘      └──── induced Hartree (screening) ────┘   └ induced xc ┘
```

and the induced charge `Δn` is built from the first-order wavefunctions `Δψ` obtained from the
**Sternheimer equation**

```
(H_scf − ε_nk) |Δψ_nk⟩ = − P_c ΔV_scf |ψ_nk⟩            (P_c = projector onto empty states)
```

`[EST]` This is a closed loop: `Δn` depends on `ΔV_scf`, and `ΔV_scf` depends on `Δn`. It is
iterated to self-consistency exactly like the ground-state SCF. The Sternheimer form avoids the
explicit sum over empty states (Baroni 2001; QE PHonon `solve_linter`). The converged `ΔV_scf` is
written to disk as `prefix.dvscf`. **The el-ph matrix element ph.x reports uses this converged,
fully-screened `ΔV_scf` — never the bare `ΔV`** (Heid, *Electron-Phonon Coupling*, correl24
lecture notes; QE `elphon.f90`).

**`[EST]` Why single-shot is wrong (Heid lecture, explicit):** "Non-self-consistent calculations
underestimate true coupling because they miss the feedback where induced charges further modify the
potential." In a metal/strong-coupling hydride like CaH6 the induced-Hartree term is large and the
first iteration captures only part of it; the loop must converge.

**`[INF]` Mapping to the QFORGE gap.** QFORGE's "Anderson-damped Dyson screening" is a mixing
scheme over a *response/dielectric* construction, not the canonical DFPT inner loop over
`ΔV_scf ↔ Δn`. Two failure modes are consistent with a 24× *under*-coupling:
  - **(a) loop not converged / over-damped.** If Anderson damping suppresses the induced-Hartree
    feedback (heavy mixing, few iterations, or the Dyson `(1−χ₀·v)⁻¹` truncated), the vertex is
    *under*-dressed → |g|² too small → λ too small. (Counter-intuitive: people expect over-screening
    to *reduce* |g|, but the dominant high-Tc-hydride coupling is to H-derived modes whose ΔV_scf is
    *amplified* by the self-consistent rearrangement of the metallic H 1s charge; a truncated loop
    loses that amplification.)
  - **(b) ∂n under-resolved.** Even a perfectly-converged loop gives the wrong `ΔV_scf` if `Δn` is
    built on a basis/k too coarse to represent the sharp H-derived response (see §2).

> **Recommended diagnostic for lanes 1-3 (cheap, decisive):** instrument the QFORGE screening loop
> to print λ vs iteration number of the ∂V_scf↔∂n self-consistency. If λ climbs monotonically and
> is still rising when the loop stops → it's **(a)**, an under-converged/over-damped loop (fix =
> iterate to true SCF, drop/auto-tune Anderson damping). If λ is flat-converged at 0.18 → it's
> **(b)/§2/§4**, a basis/k/kernel problem.

---

## 2. Full plane-wave basis + dense-k for the dielectric response ε(q) (lane 1's basis question)

`[EST]` Superhydride el-ph is notoriously convergence-hungry. Published CaH6 / LaH10 DFPT setups
(target numbers in §6):
- **Plane-wave kinetic cutoff:** 60–80 Ry (charge-density cutoff 4× → 240–320 Ry for norm-conserving;
  higher for the dense H 1s). LaH10 commonly 80 Ry (PNAS 2017; Sci.Rep. 2024).
- **SCF k-grid:** dense Γ-centered, e.g. LaH10 **24×24×24** (PNAS 2017, Liu et al.); CaH6 comparable.
- **Phonon q-grid:** **6×6×6** irreducible (LaH10, CaH6) for ph.x DFPT.
- **El-ph double-delta Fermi-surface integration:** a *much denser* k-grid than SCF (often
  ≥ 2× the q-grid linear density, e.g. effective 36³–48³) with Gaussian broadening swept to a
  plateau; λ is reported at the broadening where it stops changing.

`[INF]` **The QFORGE record uses `npw_cap = 16` (a tractable-verify basis) and a single-cell Γ
force-constant.** Sixteen plane waves cannot represent the H-derived induced charge `Δn` that
*is* the screening response in a hydride — the H 1s metallized density is high-spatial-frequency.
An under-resolved `Δn` gives an under-screened (here under-*amplified*) `ΔV_scf` → |g|² too small.
This is almost certainly a **co-cause** with §1, and possibly the dominant one given how aggressive
`npw_cap=16` is vs the literature's 60–80 Ry. **`[EST]` evidence:** the entire superhydride
literature treats basis+k convergence as the precondition for any believable λ; nobody reports a
hydride λ from a 16-PW basis.

---

## 3. EPW Wannier-interpolation of |g| — does it sidestep the convergence problem?

`[EST]` **Yes — but not the way one might hope, and the lesson is the key recipe insight.**
EPW (Giustino et al., PRB 2007; Poncé et al., Comp.Phys.Comm 2016; Lee et al., npj Comput. Mater.
2023; Noffsinger et al., 2010) does **not** re-derive screening. It **reads the already-screened
`prefix.dvscf` (the converged DFPT `∂V_scf`) from QE ph.x on a coarse q-grid (e.g. 6×6×6)**, forms
the el-ph matrix element `g = ⟨ψ_{k+q}|∂_qν V_scf|ψ_k⟩` on that coarse grid, transforms to the
maximally-localized **Wannier representation where g is short-ranged**, and Fourier-interpolates
back to ultra-dense fine grids (e.g. coarse 6³ → fine 30³ or 10⁶ k-points). EPW review (npj 2023),
verbatim: the inputs are *"the derivatives of the self-consistent potential with respect to the
phonon perturbations (`prefix.dvscf`)… these dvscf files contain the screened potential
variations that are then interpolated."*

**Implication for QFORGE (two-layer separation):**
- EPW solves the *fine-grid BZ-sampling* convergence (the double-delta integral), **not** the
  *screening-strength* problem. Screening strength is 100% inherited from ph.x's converged
  `∂V_scf`.
- **`[INF]` Therefore Wannier interpolation is NOT a candidate fix for QFORGE's 24× gap.** The gap
  is a *vertex magnitude* problem (screening strength), which lives upstream in `∂V_scf` — exactly
  the layer EPW takes as given. Adopting Wannier-|g| in QFORGE would help *cost/density* later, but
  would faithfully interpolate the *wrong (under-screened) vertex* and reproduce λ=0.18 on a finer
  grid. **Fix the `∂V_scf` self-consistency first (§1) and the basis (§2); adopt Wannier-|g| only
  afterward as a density/cost optimization.**

---

## 4. The xc kernel f_xc beyond Hartree+LDA in the response (distinct from ground-state correlation)

`[EST]` The screening response carries **two** electron-electron terms: the Hartree kernel `v` and
the **xc kernel `f_xc = δV_xc/δn`** evaluated on the induced `Δn`. In DFPT this is the
`(dV_xc/dn)·Δn` term in the §1 `ΔV_scf` equation. In adiabatic LDA/GGA, `f_xc^ALDA` is the
*instantaneous* density derivative of the *ground-state* xc potential (frequency-independent,
local). **`[EST]` This is the SAME functional family the ground state uses, applied as a *kernel*
to `Δn`** — so a code that already has PW92/PBE correlation in its ground state has the ingredients
to build `f_xc^ALDA`; it must additionally evaluate the *derivative* `δV_xc/δn` and apply it to the
induced density inside the response loop.

`[INF]` **Per the migration-gate record, QFORGE already CLEARED the *ground-state* correlation gap
(PR#2401: PZ81/PW92 LDA-c + PBE GGA-c, `xc_mode=2`), and the `screening.hexa` case-G selftest shows
`mode2 − mode1 = f_c[ρ]·Δρ` is non-trivially wired** — i.e. the correlation kernel *is* entering
the response. Yet λ stayed at 0.18. **Conclusion (matches the §11 milestone's own honest read):
f_xc is necessary but is NOT the dominant missing piece.** `f_xc` typically shifts the screened
vertex by O(10–30%), not O(24×). **`[EST]` magnitude argument:** going from RPA (Hartree-only) to
ALDA changes phonon frequencies/λ in metals by tens of percent, never by an order of magnitude
(Baroni 2001; standard DFPT practice). A 24× gap cannot be an f_xc-kernel effect. **De-prioritize
f_xc as the gap-closer; keep it on for correctness, but the 24× lives in §1/§2.**

---

## 5. Synthesis — what most likely closes the 24× gap (causal chain)

`[INF]` The 24× under-coupling is consistent with a **compounding** of two upstream errors, both in
the construction of the screened `∂V_scf`, **not** in the BZ-sampling or the xc kernel:

```
  npw_cap=16 basis  ──►  Δn under-resolved  ──┐
                                              ├──►  ∂V_scf under-amplified  ──►  |g|² ≪  ──►  λ=0.18
  single-shot / over-damped Dyson loop  ──────┘                                  (vs 4.376)
```

Plus second-order accumulators the record itself names: Einstein-default ω₀ (no real BZ-dispersed
force constants) and single-cell Γ-only FC. **`[INF]` These hit ω_log and the α²F shape; they bias
Tc but are unlikely to be the 24× λ factor — λ is dominated by the |g|²/ω vertex, which is the
screening problem.** The honest ranking is below.

---

## 6. Target λ / ω_log / Tc table + recommended convergence params (for the engine lanes)

`[EST]` Anchor numbers from the superhydride DFPT literature (citations in §8). These are the
cross-val targets the QFORGE path must hit (≤0.5% on λ for the gate, per the migration-gate
milestone). Where a single canonical λ is not uniformly reported across papers a representative
DFPT value / range is given and flagged.

| Material | Pressure | λ (DFPT) | ω_log | Tc (μ*=0.1–0.13) | Method / grids (representative) |
|---|---|---|---|---|---|
| **CaH6** (Im-3m) | 150 GPa | **~2.7** (Wang 2012) | ~ | **220–235 K** (Eliashberg) | DFPT ph.x; sodalite clathrate |
| **CaH6** (gate ref) | ~150–172 GPa | **4.376** (QFORGE/QE xval ref, textbook-proof) | **1236.4 K** | Tc McMillan ref | QE DFPT; 6×6×6 q; dense k; this is the gate anchor |
| **CaH6** (exp.) | 172 GPa | — | — | **215 K** (measured) | — |
| **ThH10** | high-P | (paired w/ CaH6 in fully-ab-initio Eliashberg, Sci.Rep. 2024) | — | high | DFPT + fully-ab-initio Eliashberg |
| **LaH10** (Fm-3m) | 250 GPa | **~2.2–3.5** (reports vary) | — | **257–274 K** (μ*=0.1–0.13) | 80 Ry; SCF k **24×24×24**; q **6×6×6**; EPW fine 30³ |
| **LaH10** (exp.) | 170–200 GPa | — | — | **250–260 K** (measured) | — |

`[EST]` **Recommended convergence params for hydride el-ph (literature consensus), for the lanes to
adopt as the QFORGE front-end target — NOT npw_cap=16:**
- PW kinetic cutoff **60–80 Ry** (charge-density cutoff 4×; H 1s wants the high end).
- SCF k-grid **dense, Γ-centered ~24³** (LaH10 reference); CaH6 comparable.
- Phonon q-grid **6×6×6** irreducible (DFPT ph.x).
- El-ph double-delta on a **denser** k than SCF; **sweep Gaussian broadening to the λ-plateau** and
  report λ at the plateau (do NOT take a single arbitrary broadening).
- **`∂V_scf` linear-response loop iterated to true self-consistency** (the §1 mechanism) — the
  non-negotiable for screening strength.

`[EST]` **Triangulated next-DFPT candidates** (from §11 RTSC-TRIANGULATE: CaH10·ScH9·MgH6·SrH10·
YH10·ScH6) — published DFPT λ values are sparse/scattered for these; they are *predictions* and
should be treated as **`[INF]` targets-to-establish**, not literature anchors. The reliable
cross-val anchors for closing the gate remain **CaH6 (4.376), LaH10, Li2MgH16** — the three named
in the milestone.

---

## 7. PRIORITIZED FIX-RECIPE TABLE (the deliverable)

Ordered by `[INF]` likelihood-of-closing-the-24×-gap × cheapness-to-test. Each row: the candidate
fix, the literature evidence it rests on, the recommended action/params, and the honest tag.

| # | Candidate fix | Closes 24×? (my rank) | Literature evidence `[EST]` | Concrete action for lanes 1-3 | Tag |
|---|---|---|---|---|---|
| **1** | **Iterate `∂V_scf` to true self-consistency** (canonical DFPT ∂V_scf↔∂n loop, not single-shot/over-damped Anderson) | **HIGH — likely primary** | Baroni RMP 2001 (SCF Sternheimer loop); Heid correl24 ("non-SCF *underestimates* coupling"); QE `solve_linter` | First run the §1 **λ-vs-iteration diagnostic**. If λ still rising at loop-end → drop/auto-tune Anderson damping, raise max-iter, require ∂n convergence threshold like ground-state SCF. | `[INF]` |
| **2** | **Raise the plane-wave basis + SCF k that build `∂n`** (npw_cap 16 → 60–80 Ry-equivalent; k → ~24³) | **HIGH — likely co-primary** | All CaH6/LaH10 DFPT setups use 60–80 Ry + ~24³ k (PNAS 2017; Sci.Rep. 2024; arXiv 2111.10797) | Lift npw_cap to a convergence-tested basis; converge λ vs cutoff & k to a plateau before trusting any number. 16 PW cannot represent H-1s `Δn`. | `[INF]` (basis need is `[EST]`) |
| **3** | **Real BZ-dispersed force constants + double-delta broadening sweep** (drop Einstein-default ω₀, single-cell Γ-FC) | **MEDIUM — biases ω_log/Tc & α²F shape; smaller λ effect** | DFPT 6³ q standard; Allen-Dynes needs converged α²F(ω); h3br record in this repo: Γ-only ω_log 41% over full-BZ | Compute FC on the 6³ q-grid; integrate λ on a denser k with a broadening sweep to plateau. | `[INF]` |
| **4** | **xc kernel f_xc in the response** | **LOW for the 24× — keep ON for correctness** | Baroni 2001 (ALDA `f_xc` = δV_xc/δn on Δn); RPA→ALDA shifts λ ~10–30%, never 24× | Already wired (`xc_mode=2`, screening case-G). Leave on; do **not** expect it to close the gap. | `[EST]` |
| **5** | **EPW-style Wannier-interpolation of |g|** | **NOT a gap fix — cost/density only** | EPW reads already-screened `prefix.dvscf`, interpolates it; does NOT re-derive screening (npj 2023; Giustino PRB 2007) | Adopt *after* #1+#2 fix vertex magnitude, as a dense-grid cost optimization. Interpolating the under-screened vertex would just reproduce λ=0.18 on a finer grid. | `[EST]` |

**Bottom line for the lanes:** spend effort on **#1 (self-consistency loop) and #2 (basis+k)**.
Run the §1 λ-vs-iteration diagnostic *first* — it cheaply tells you whether the dominant error is
the loop (#1) or the basis/sampling (#2/#3). #4 is necessary-not-sufficient (already done). #5 is
the wrong layer for this gap.

---

## 8. Citations (d18: arxiv + web)

1. **Baroni, de Gironcoli, Dal Corso, Giannozzi**, "Phonons and related crystal properties from
   density-functional perturbation theory," *Rev. Mod. Phys.* **73**, 515 (2001).
   arXiv:cond-mat/0012092 — canonical DFPT self-consistent `∂V_scf` + Sternheimer formalism (§1).
2. **R. Heid**, "Electron-Phonon Coupling," correl24 lecture notes, cond-mat.de —
   screened matrix element via `dV_scf`; explicit "non-SCF underestimates coupling" (§1, §7-row1).
3. **Giustino, Cohen, Louie**, "Electron-phonon interaction using Wannier functions,"
   *Phys. Rev. B* **76**, 165108 (2007) — Wannier-interpolated `g` (§3).
4. **Poncé, Margine, Verdi, Giustino** / **Lee et al.**, "Electron–phonon physics from first
   principles using the EPW code," *npj Comput. Mater.* (2023), s41524-023-01107-3 — EPW reads
   already-screened `prefix.dvscf`, interpolates it; does not re-derive screening (§3, §7-row5).
5. **Noffsinger et al.**, "EPW: a program for calculating the electron-phonon coupling using
   maximally localized Wannier functions," arXiv:1005.4418 — coarse→fine grid scheme, `∂V_scf` (§3).
6. **Wang, Tse, Tanaka, Iitaka, Ma**, "Superconductive sodalite-like clathrate calcium hydride at
   high pressures," *PNAS* **109**, 6463 (2012). arXiv:1203.0263 — CaH6 first prediction,
   Tc 220–235 K @ 150 GPa (§6).
7. **"High-Tc superconductivity in clathrate calcium hydride CaH6,"** arXiv:2103.16282 —
   CaH6 experimental Tc 215 K @ 172 GPa (§6).
8. **"Superconductivity in CaH6 and ThH10 through fully ab initio Eliashberg theory,"**
   *Sci. Rep.* **14** (2024), s41598-024-69190-0 — fully-ab-initio Eliashberg vs Allen-Dynes;
   k/q-mesh dependence of EPC (§1, §6).
9. **Liu, Naumov, Hoffmann, Ashcroft, Hemley**, "Potential high-Tc superconducting lanthanum and
   yttrium hydrides at high pressure," *PNAS* **114**, 6990 (2017). — LaH10 80 Ry, k 24³, q 6³,
   Tc 257–274 K (§6).
10. **"Electron-phonon coupling and superconductivity in CaH6 at high pressures,"**
    arXiv:2111.10797 — CaH6 DFPT EPC, Eliashberg spectral function in low-freq H modes (§2, §6).
11. **"Advanced capabilities for materials modelling with Quantum ESPRESSO,"** arXiv:1709.10010 —
    QE DFPT/PHonon implementation reference (§1).

---

## 9. Honesty ledger (d6)

- **`[EST]` (cited, established):** the `∂V_scf = ΔV_bare + Hartree[Δn] + f_xc·Δn` self-consistent
  structure; the Sternheimer loop; non-SCF underestimates coupling; EPW interpolates the
  already-screened `prefix.dvscf` and does not re-derive screening; literature convergence params
  (60–80 Ry, 24³ k, 6³ q); the target λ/Tc anchors.
- **`[INF]` (my inference, lanes must TEST not assume):** that QFORGE's specific 24× gap is caused
  by an under-converged/over-damped screening loop (#1) and/or the npw_cap=16 basis under-resolving
  `Δn` (#2); the relative ranking of the five fixes; that f_xc/Wannier are not the gap-closer. The
  λ-vs-iteration diagnostic in §1 is the cheap experiment that converts these inferences into a
  measurement.
- **Not claimed:** I did not run the engine or verify QFORGE's loop internals; the ranking is a
  literature-grounded hypothesis prioritization, not a proof of root cause.
