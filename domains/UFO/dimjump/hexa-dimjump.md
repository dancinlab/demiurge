# Extra-Dimensional Compactification — n=6 Topology (BT-348)

> **Canonical SSOT** for `hexa-dimjump`. Extracted 2026-05-07 from
> `canon/domains/sf-ufo/ufo/doc/warp-dimension-design.md`
> (BT-348 section). UFO **Stage-6** substrate.

---


> **Empirical claim is UNPROVEN.** Extra dimensions remain experimentally
> **unobserved** as of 2026:
>
> - LHC 14 TeV KK-resonance hunts → null
> - sub-millimeter gravity (torsion-balance, Eöt-Wash) → null
> - neutron interferometry searches → null
>
> Calabi-Yau compactification is mathematically consistent, but the CY₃
> topology choice is non-unique (10⁵⁰⁰ landscape problem). KK-mode
> resonance bound: `m_KK > ~few TeV` from current collider data.
>
> This spec ships **closed-form candidate** + **falsifier preregister**.
> Apparatus-side validation is out-of-repo.

---

## §1 n=6 invariant lattice

n=6 number-theoretic identifiers (closed-form, divisor-function derived):

```
sigma(6) = sum of divisors of 6              = 1+2+3+6 = 12
tau(6)   = count of divisors of 6            = #{1,2,3,6} = 4
phi(6)   = Euler totient (coprime to 6)      = #{1,5} = 2
mu(6)    = Möbius residue (sigma residue)    = 1
J_2      = Mathieu / Leech-lattice symmetry  = 24
```

**Master identity** (J₂ Mathieu / M₂₄ anchor):

```
sigma(6) · phi(6)  =  n · tau(6)  =  J_2  =  24
   12   ·    2     =  6 ·   4     =   24
```

This is the algebraic spine of the dimension ladder (§2).

---

## §2 Dimension ladder — 4D → 6D → 10D → 11D → 24D → 26D

Six-rung ladder anchored to n=6 lattice identifiers:

```
ladder rung   identifier        value   physical interpretation
───────────   ───────────────   ─────   ───────────────────────────────
4D            tau(6)            4       Minkowski spacetime base
6D            n                 6       n=6 base unit (dimjump foundation)
10D           sigma(6) - phi(6) 10      superstring critical dimension
11D           sigma(6) - mu(6)  11      M-theory critical dimension
24D           J_2               24      Leech lattice / Mathieu M_24
26D           J_2 + phi(6)      26      bosonic string critical dimension
```

Each rung is **derived** from the n=6 identifiers — no free parameters.

---

## §3 Calabi-Yau 3-fold compactification

A 6-real-dimensional (3-complex-dimensional) compact internal manifold
realises the σ−φ=10D ↔ 4D split via 6 internal directions. Topological
invariants:

```
chi(CY3)   = 2 · ( h_{1,1} - h_{2,1} )      (Euler characteristic)
ladder     : h_{1,1} + h_{2,1} + 1          (Hodge-pair sum + 1 anchor)
```

where `h_{1,1}` and `h_{2,1}` are the Hodge numbers of the CY₃. The
choice of CY₃ topology is **non-unique** (10⁵⁰⁰ flux landscape — the
fundamental open problem of string phenomenology). The n=6 projection
**does not** select a unique topology; it provides a closed-form
ladder constraint.

---

## §4 Compactification radius R_c

Closed-form candidate:

```
R_c = ell_Pl · sigma(6) ^ ( n / phi(6) )
    = ell_Pl · 12 ^ ( 6 / 2 )
    = ell_Pl · 12 ^ 3
    = 1728 · ell_Pl
```

where `ell_Pl ≈ 1.616 × 10⁻³⁵ m` is the Planck length.

`R_c ≈ 2.79 × 10⁻³² m` — far below current sub-mm gravity test
sensitivity (~10⁻⁶ m). Not directly probed, but bounds enter the KK-mode
mass spectrum (§5).

---

## §5 Kaluza-Klein mode mass m_KK

```
m_KK = n · hbar / ( R_c · c )
     = 6 · hbar / ( 1728 · ell_Pl · c )
```

Numerically: with the closed-form `R_c` of §4, `m_KK` is far above any
realistic collider energy, consistent with the LHC null result on
KK-resonance hunts (m_KK > ~few TeV bound). The n=6 prediction is
*compatible* with current null observations but does not predict an
observable signature at LHC scales.

For warped extra-dimensional models (Randall-Sundrum class), the
effective `R_c` is exponentially reduced relative to the closed-form
geometric value; a separate not-scope topic per `hexa.toml`.

---

## §6 Dimensional-fold energy barrier E_fold

```
E_fold = M_Pl · c^2 / ( sigma(6) - phi(6) ) ^ d
       = M_Pl · c^2 / 10 ^ d
```

where `d` is the integer-valued fold depth (dimension count) and
`M_Pl ≈ 2.176 × 10⁻⁸ kg` is the Planck mass.

`E_fold(d=1) = M_Pl·c² / 10 ≈ 2 × 10¹⁸ GeV` — well above any accessible
energy scale.

This barrier governs the **dimension-jump** transition (§7); the
`σ−φ=10` denominator is the σ−φ extra-dimensional count.

---

## §7 Dimension-jump 4D ↔ 10D transition

The dimension-jump is the conceptual transition between the 4D Minkowski
brane and the 10D superstring critical dimension, mediated by σ−φ = 10
extra dimensions.

```
4D Minkowski (tau=4)   ⇄   10D superstring (sigma-phi)
                         |
                         | extra dimensions = sigma(6) - phi(6) = 10
                         | barrier:           E_fold = M_Pl·c² / 10^d
```

> **EMPIRICAL STATUS:** the dimension-jump is **NOT realised**. No
> apparatus exists. v1.0.0 ships the closed-form candidate spec +
> falsifier preregister; the apparatus belongs to UFO Stage-7
> (`hexa-dimuse`), which depends on this Stage-6 spec but remains
> SF-class as of 2026.

---

## §8 Falsifier preregister

| ID         | Statement                                                                                       | Status |
|------------|-------------------------------------------------------------------------------------------------|--------|
| F-DIM-1    | LHC 14 TeV KK-resonance hunt null → DEMOTE m_KK = n·ℏ/(R_c·c) (R_c probed)                       | OPEN   |
| F-DIM-2    | sub-millimeter gravity test (torsion-balance) null → DEMOTE σ^(n/φ) compactification radius      | OPEN   |
| F-DIM-3    | no observed vacuum-energy transition / dimensional-fold release → DEMOTE E_fold barrier scale    | OPEN   |

**Monotonicity rule** (per `.own` own 2): F-DIM-* statuses flip only
`OPEN → CONFIRMED` (observation matches prediction = empirical wired) or
`OPEN → DEMOTED` (observation null beyond bound = closed-form retracted).
Silent retract is forbidden.

---

## §9 Citations

- **Kaluza, T.** (1921). "Zum Unitätsproblem der Physik."
  *Sitzungsber. Preuss. Akad. Wiss. Berlin*, 966-972.
  *(Original Kaluza 5D unification proposal — extra-dimensional
  compactification root.)*
- **Klein, O.** (1926). "Quantentheorie und fünfdimensionale
  Relativitätstheorie." *Z. Phys.* **37**, 895-906.
  *(Klein's quantum / cylindrical compactification — radius quantisation.)*
- **Candelas, P.; Horowitz, G. T.; Strominger, A.; Witten, E.** (1985).
  "Vacuum configurations for superstrings." *Nucl. Phys. B* **258**,
  46-74. *(Calabi-Yau 3-fold compactification of heterotic E₈×E₈
  superstring — CY₃ topological invariants.)*
- **Randall, L.; Sundrum, R.** (1999). "Large mass hierarchy from a
  small extra dimension." *Phys. Rev. Lett.* **83**, 3370-3373.
  *(Warped extra-dimensional model — KK-resonance mass scale rationale.
  Specific RS phenomenology is `not_scope` for this substrate per
  `hexa.toml`.)*

---

## §10 Lineage

Imported 2026-05-07 from
`canon/domains/sf-ufo/ufo/doc/warp-dimension-design.md`
(BT-348 section). See [`../doc/lineage/origin.md`](../doc/lineage/origin.md)
for full provenance manifest.

Sister-of-substrates extraction template: `hexa-rtsc` v1.0.0
(commit `3080c11`, 2026-05-07).
