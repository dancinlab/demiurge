# NON-HARRISON g(u) PROBE — 판정 🔴 CLOSES (super-linear-g ↔ instability tension generalizes the 9th law)

> The campaign's **deepest open frontier** (d2): the 9th law **STIFF-BOND-WEAK-SSH-BINDING**
> assumes the HARRISON law t∝1/d² ⇒ ∂t/∂u=−2t/d ⇒ g/t=2u₀/d ∝ 1/√Ω, which closes the ambient
> bond-bipolaron room-T escape. The 9th-law escape probe (`escape_9th_anharmonic_FINDINGS.md`)
> closed four loopholes but explicitly flagged ONE axis it did not cover: a **non-Harrison,
> anomalous SUPER-LINEAR ∂t/∂u** near a covalent bond-breaking / negative-U / charge-transfer
> instability, which could be a NEW off-Harrison bond-chemistry host class. This probe tests it.
>
> artifacts: `non_harrison_gu.py` · `non_harrison_gu_results.json`. Pure numpy, no pod.

## THE QUESTION (made precise)

The harmonic Harrison g/t at a STIFF LIGHT bond is tiny: anchor REF bond (d=1.65 Å, M=11, Ω=160 meV,
BK-borophene-like) gives **g/t = 2u₀/d = 0.042**, a **28.7× shortfall** below the 2-body bond-bipolaron
binding threshold g*/t ≈ 1.20. To escape, a non-Harrison bond must supply a **super-linearity factor
S = (∂t/∂u)_actual / (∂t/∂u)_Harrison ≈ 29** — AND keep the bond stiff (Ω≥160 meV, box criterion-2),
ambient-stable, and METALLIC. The deep tension: super-linear ∂t/∂u lives NEAR an instability, but AT
the instability the bond dimerizes/gaps (no metal, no mobile bipolaron).

## PER-CLASS SUPER-LINEARITY ESTIMATE (vs Harrison 2u₀/d)

| Class | mechanism of super-linear ∂t/∂u | S (best honest) | g/t reached | shortfall | metal at that S? |
|---|---|---|---|---|---|
| **C1 negative-U / SSH-Peierls critical** | inflection of t(u) as soft mode → dimerization; g₂/g₁ ~ 1/(u_c−u) | 1.7 → 11 (edge) | 0.07 → **0.46** | 17× → 2.6× | NO at S≫1 |
| **C2 charge-transfer / covalent-ionic crossover** | avoided-crossing slope ~1/w (crossover width w) vs Harrison 1/d | 1.8 → 13 (w=0.04 Å) | 0.07 → **0.55** | 16× → 2.2× | NO at sharp w |
| **C3 lone-pair s² breathing (bismuthate/Tl)** | Bi-O hopping modulation via 6s² disproportionation (DFT-anchored) | **1.14** | **0.047** | 26× | gaps (CDW) at the active filling |

The two "model" classes (C1, C2) DO produce genuine super-linearity — S can reach 10–13 as you push
toward the instability. But **even the most generous honest S leaves g/t ≤ 0.55, still 2.2–2.6× short**,
and only when the bond is essentially AT the instability (no metal). The one real DFT-anchored class
(C3 bismuthate) has S ≈ 1.14 — barely above Harrison — because the lone-pair breathing is, in the
campaign's own geometric audit, an off-diagonal coupling of ordinary magnitude (⟨tr g⟩(BBO)=0.0465).

## THE JOINT WINDOW (the deciding calculation — instability-vs-metal made quantitative)

The super-linear S is only USABLE if a metallic window exists where the zero-point amplitude u₀ does
NOT reach the instability displacement u_c (so the bond does not freeze / statically dimerize).

- **C1**: to hit g/t=1.20 needs S=28.7 ⇒ metal_margin (u_c−u₀)/u₀ = **0.036**. That means u_c is only
  **3.6 % beyond u₀** — the zero-point bond fluctuation already reaches **97 %** of the dimerization
  displacement. At that proximity the mode is dynamically unstable: the bond freezes into a static CDW,
  the band gaps, and there is no metal and no mobile bipolaron. **The window where S≈29 and a metal
  coexist is empty.**
- **C2**: to hit g/t=1.20 needs crossover width **w = 0.018 Å = 1.1 % of the bond**. A covalent↔ionic
  flip that sharp IS a charge-disproportionation step — i.e. exactly the static CDW (the BaBiO₃ gap).
  A smooth metallic crossover (w ≳ 0.15 Å) gives only S≲3.5, g/t≲0.15, 8× short.
- **C3**: the bismuthate breathing mode is **SOFT (Ω≈65 meV)**, the wrong direction — its small
  g/t survives only by being soft, which fails box criterion-2 (Ω≥160 meV) AND the system is a CDW
  insulator at the active filling, metallic only when K-doped *away* from the disproportionation that
  produced the coupling. Doping to metal dilutes the very coupling that was super-linear.

**This is the same trade-off as the 9th law's harmonic 1/√Ω wall, re-expressed in bond chemistry:
the super-linearity factor S and the metallic-stability margin are inversely locked.** Pushing S up
(sharper inflection / narrower crossover / stronger disproportionation) pushes the static order
parameter on; the bond gaps before S is large enough. The ~29× needed to clear the threshold demands
proximity so extreme that the zero-point motion itself triggers the instability.

## ARXIV / MATERIAL GROUNDING

- **Bond-Peierls bipolaron framework** (the threshold + light-mass physics): Sous/Berciu/Prokof'ev,
  *Bipolaronic High-Temperature Superconductivity*, PRX 13,011010 / arXiv:2203.07380; triangular-lattice
  study arXiv:2507.07662; perspective arXiv:2605.16625; semiclassical PRB 109,L220502. Off-diagonal
  ∂t/∂u gives small-but-LIGHT bipolarons — the recipe — with Tc/Ω above the Migdal-Eliashberg bound,
  but the high-Tc window needs strong coupling that, in a stiff covalent bond, the Harrison law denies.
- **C1 SSH-Peierls non-linearity**: the soft-mode "divergence" at a Peierls point is in the PHONON
  susceptibility (ω_soft→0), NOT in ∂t/∂u, which stays ≈Harrison to leading order; higher-order g₂u²
  is the genuine non-linearity (extended Peierls-Hubbard, Sci.Rep. s41598-017-01228-y; substituent SSH
  PRB 100,235129). Polyacetylene SSH λ~0.1–0.2 (Peierls-insulating, not a SC host).
- **C2/C3 negative charge-transfer / bismuthate**: BaBiO₃ breathing mode IS modeled as a Bi-O
  **hopping modulation** (off-diagonal) with λ≈0.89 (hybrid-MC, npj Comput.Mater. s41524-023-00998-6;
  first-principles K-BBO, ScienceDirect S092702562400003X, λ≈0.89). Negative charge-transfer / oxygen
  holes (arXiv:2002.08451): the disproportionation is on the LIGAND; the system is a CDW insulator at
  the parent filling, SC (Tc≤34 K) only on hole-doping. Tl-perovskite negative-U analog
  (arXiv:1302.1785, Inorg.Chem. ic400381g; charge-ordered CsTl⁺₀.₅Tl³⁺₀.₅X₃ arXiv:1302.2353): same
  lone-pair s² disproportionation, same CDW-vs-metal tension. Tl:PbTe negative-U pairing exists but Tc
  is low — the negative-U does not deliver room-T.

The campaign's own bismuthate audit already FALSIFIED the "⟨g⟩ empirically large" claim for this family
(`discovery/bismuthate_FINDINGS.md`): bismuthate is a CONVENTIONAL breathing-mode el-ph SC (λ the lever,
not geometric ⟨g⟩), geometric Tc 5 K vs measured 30 K. C3 is therefore already closed empirically; this
probe extends the closure to the C1/C2 model idealizations.

## 🔴 VERDICT — CLOSES (the 9th law generalizes to non-Harrison bond chemistry)

A non-Harrison super-linear g(u) host class does **NOT** credibly reach g/t≳1.2 at a stiff/light,
ambient-stable, metallic bond. The super-linearity is real (S up to ~10–13 near an instability) but
(a) even maxed it lands at g/t ≤ 0.55, still ≥2.2× short, and (b) the ~29× actually needed forces
proximity to the instability so extreme (u₀ within 3.6 % of u_c, or a 1 %-of-bond crossover) that the
bond statically dimerizes/disproportionates — gapping the metal. **Super-linear ∂t/∂u and a stable
metal are inversely locked; the window with both is empty.** This is the SAME g·(Ω/stability budget)
conservation the harmonic 9th law expressed as 1/√Ω, now shown to hold in the non-Harrison
bond-chemistry regime too.

**Honest residual (d6 — this WAS speculative bond-chemistry):** S is an order-of-magnitude bond-model
estimate, not a frozen-phonon DFT t(u) curve; the inflection/crossover forms are idealizations. But the
SIGN is robust: the shortfall is ~one order of magnitude (≥2.2× even at the instability edge), far larger
than the O(1) uncertainty in any single S, and the inverse-lock between S and metallic stability is a
structural argument, not a number. The one place a number could move the verdict is C1/C2 *just-before*
the edge — and there S is ≲3.5 (8× short), nowhere near 29.

## DEPLETION TEST — closes too

The ambient room-T conventional/bond-bipolaron question is now closed across **BOTH** Harmonic-Harrison
(9th law + four loopholes, `escape_9th_anharmonic`) **AND** non-Harrison super-linear bond chemistry
(this probe). Every off-diagonal lever — harmonic Harrison, anharmonic, 2nd-order SSH, coordination,
quantum-nuclear, AND now negative-U/charge-transfer/lone-pair super-linearity — fails the same way:
none supplies the ~20–29× the binding threshold demands without simultaneously destroying the stiff
metallic bond. The bond-bipolaron escape stays **CLOSED-NEGATIVE**.

**The one DFT target IF a residual is ever pursued** (it does NOT reopen, so this is contingency only):
the *just-before-instability* window of a **negative-charge-transfer perovskite at the metal–CDW phase
boundary** — concretely **hole-doped Ba₁₋ₓKₓBiO₃ right at the CDW-to-metal critical doping x_c≈0.37**,
or its Tl analog **(Cs/Rb)Tl₁₋δX₃ near the disproportionation boundary** — DFPT frozen-phonon t(Q) of
the breathing mode to measure the ACTUAL ∂t/∂u super-linearity S and confirm it stays ≲3 (g/t≲0.15)
in the metallic phase, as this estimate predicts. That DFT would convert the estimate's "closes" into a
measured closure; it is not expected to reopen the escape.
