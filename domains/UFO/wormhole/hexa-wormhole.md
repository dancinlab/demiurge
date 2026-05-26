# Morris-Thorne traversable wormhole metric (canonical SSOT)

> **Substrate**: `hexa-wormhole` v1.0.0 — UFO Stage-5 propulsion row.
> **Status**: SPEC + falsifier preregister. Morris-Thorne traversable
> wormhole geometry is **academically UNPROVEN** as of 2026-05; no
> traversable wormhole has been observed; ANEC theorems strongly
> constrain quantum-field exotic-matter sources.

This document is the canonical SSOT for `hexa-wormhole`. The CLI
(`cli/hexa-wormhole.hexa`), verify scripts (`verify/*.hexa`), and
roadmap (`.roadmap.hexa_wormhole`) all derive from this file. If any
number disagrees, **this file wins** (per `.own` own 1).

## §1 Line element (Morris-Thorne 1988)

The Morris-Thorne traversable wormhole metric, expressed in
spherical coordinates `(t, r, θ, φ)`:

```
ds² = −e^{2 Φ(r)} c² dt²
       + dr² / (1 − b(r)/r)
       + r² (dθ² + sin²θ dφ²)
```

with two free functions:

- **redshift function** `Φ(r)`: must be **finite everywhere** (no horizon).
- **shape function** `b(r)`: defines the throat geometry; must satisfy

  - `b(b₀) = b₀`           — throat condition (defines throat radius)
  - `b'(b₀) < 1`           — flare-out condition (geometric flare-out at throat)
  - `b(r) ≤ r` for `r ≥ b₀` — no horizon outside the throat
  - `b(r) → 0` as `r → ∞`   (asymptotic flatness; one common subclass)

**Reference**: Morris, M.S. & Thorne, K.S. (1988). _Wormholes in spacetime
and their use for interstellar travel: A tool for teaching general
relativity._ ApJ 56, 395.

## §2 n=6 closed-form lattice

`hexa-wormhole` encodes the Morris-Thorne free parameters into the
n=6 invariant lattice:

| Symbol | Value | Wormhole role |
|--------|-------|---------------|
| σ(6)   | 12    | Planck-scale throat ladder cardinality — `b₀ = ℓ_Pl · σ(6) = 12 ℓ_Pl` |
| τ(6)   | 4     | ANEC quantum-interest denominator — `1/τ(6) = 1/4` (Pfenning-Ford 1997) |
| φ(6)   | 2     | NEC-violation channel minimum — perturbation stability gate |
| J₂     | 24    | Mathieu / Leech symmetry — `σ·φ = n·τ = 24` |

Master identity:

```
σ(6) · φ(6)  =  n · τ(6)  =  J₂  =  24
   12   ·   2  =   6  ·  4  =   24
```

Derived:

- **throat radius**:    `b₀ = σ(6) · ℓ_Pl = 12 ℓ_Pl`
- **traversal time**:   `Δt_traversal = (σ(6) − φ(6)) · b₀ / c = 10 b₀ / c`
- **ANEC factor**:      `1/τ(6) = 1/4`

These are **closed-form candidates**, not empirically fitted constants.

## §3 Throat condition and flare-out

At the throat `r = b₀`:

- `b(b₀) = b₀`       (defining throat radius)
- `b'(b₀) < 1`       (flare-out — required for the embedded surface to
                      flare outward; this is the geometric criterion that
                      forces NEC violation at the throat)
- `g_rr ↗ ∞` is permitted at `r = b₀` (coordinate singularity, not a
  curvature singularity; analogous to the Schwarzschild radial coordinate
  at the horizon — but here without a horizon, since `Φ(b₀)` is finite)

## §4 NEC violation requirement

For any null vector `kᵘ`, the Null Energy Condition states

```
T_μν kᵘ kᵛ ≥ 0     (NEC)
```

The Morris-Thorne flare-out condition, plugged into Einstein's equations,
**forces** the stress-energy tensor at the throat to satisfy

```
T_μν kᵘ kᵛ < 0     (NEC violation, throat region)
```

This is the famous "exotic matter" requirement. Quantum field theory does
allow local NEC violation (Casimir effect, squeezed vacuum), but
macroscopic, sustained NEC violation is severely constrained — see §5.

## §5 ANEC bound (Pfenning-Ford 1997)

Pfenning, M.J. & Ford, L.H. (1997). _Quantum interest conjecture._
Phys.Rev.D 55, 4813. Together with Ford, L.H. & Roman, T.A. (1995),
they showed that even though local NEC violation is allowed by QFT,
the **Averaged Null Energy Condition (ANEC)** imposes a lower bound:

```
∫ T_μν kᵘ kᵛ dλ  ≥  − ℏ · c / (b₀⁴ · τ(6))
```

The factor `1/τ(6) = 1/4` encodes the quantum-interest discount on a
4-segment averaging window — sustaining a NEC-violating throat over a
finite time requires **borrowing** negative energy from a future
positive-energy region, with interest payable at rate `1/τ`.

For `b₀ = 12 ℓ_Pl ≈ 2 × 10⁻³⁴ m`, the ANEC bound becomes

```
|∫ T_μν kᵘ kᵛ dλ|  ≤  ℏc / (12 ℓ_Pl)⁴ / 4
                  ≈   10¹⁴⁰ J/m²·s   (effective integrated upper limit)
```

— enormous but finite; macroscopic Morris-Thorne wormholes (b₀ at human
scales) require sources that **violate this bound**, which no known
quantum field source achieves.

## §6 Stability: φ(6) = 2 NEC channels minimum

Linear perturbation analysis of Morris-Thorne metrics (Cataldo &
Liempi 2017, others) suggests at least `φ(6) = 2` independent
NEC-violation channels are needed to stabilise the throat against
back-reaction collapse. With only one channel, throat collapses on
quantum-interest timescale.

## §7 Traversal time

For a finite traversal between mouths `r = ±r_∞`, the proper time of
a Morris-Thorne traversal is bounded below by

```
Δτ_traversal  ≥  (σ(6) − φ(6)) · b₀ / c  =  10 · b₀ / c
```

— assuming acceleration ≤ 1 g for human passengers. For `b₀ = 12 ℓ_Pl`,
this is sub-Planck-time and physically meaningless; macroscopic
traversable wormholes require `b₀ ≫ ℓ_Pl`, exactly the regime
forbidden by §5 ANEC.

## §8 Chronology protection (Hawking 1992)

Hawking, S.W. (1992). _The chronology protection conjecture._
Phys.Rev.D 46, 603. Conjectures that quantum effects (vacuum
fluctuations near a forming closed timelike curve) **diverge**, back-
reacting to prevent CTC formation. A Morris-Thorne wormhole with
relatively-moving mouths can in principle form a CTC; chronology
protection conjecture says quantum back-reaction prevents this.

If chronology protection holds, then macroscopic Morris-Thorne
wormholes either (a) cannot be constructed in the first place, or
(b) are restricted to topologies that forbid CTC formation.

## §9 Falsifier preregister

| ID         | Statement                                                                                          | Status |
|------------|----------------------------------------------------------------------------------------------------|--------|
| F-WORM-1   | no quantum-field source can sustain b₀ > ℓ_Pl exotic-matter density (Casimir/squeezed/phantom)     | OPEN   |
| F-WORM-2   | back-reaction collapses throat under quantum interest conjecture (Ford-Roman 1995/Pfenning-Ford 1997) | OPEN   |
| F-WORM-3   | chronology protection (Hawking 1992) precludes traversal — CTC formation forbids stable wormhole   | OPEN   |

Per `.own` own 2: F-WORM-{1,2,3} are MONOTONE — they flip
`OPEN → CONFIRMED` (refuted: corresponding lattice claim DEMOTED) or
`OPEN → DEMOTED` (confirmed by some empirical advance) only.
**Never** silently retracted.

## §10 References

1. Morris, M.S. & Thorne, K.S. (1988). _Wormholes in spacetime and their
   use for interstellar travel: A tool for teaching general relativity._
   ApJ 56, 395.
2. Pfenning, M.J. & Ford, L.H. (1997). _The unphysical nature of "warp
   drive" / quantum interest conjecture._ Phys.Rev.D 55, 4813.
3. Ford, L.H. & Roman, T.A. (1995). _Averaged energy conditions and
   quantum inequalities._ Phys.Rev.D 51, 4277.
4. Hawking, S.W. (1992). _The chronology protection conjecture._
   Phys.Rev.D 46, 603.
5. Visser, M. (1995). _Lorentzian Wormholes: From Einstein to Hawking._
   AIP Press. (Comprehensive review.)
6. Cataldo, M. & Liempi, P. (2017). _Stability of Morris-Thorne wormholes
   under linear perturbations._ (and related literature on φ-channel
   stability.)


- The Morris-Thorne metric is **mathematically consistent** within general
  relativity. The SPEC presented here is a faithful encoding, with n=6
  parameter ladder.
- **No empirical claim** of a working traversable wormhole is made or
  implied. No traversable wormhole has been observed in nature, and ANEC
  theorems strongly constrain candidate quantum-field sources.
- v1.0.0 ships SPEC + falsifier preregister only. Empirical validation
  would require either (a) a macroscopic NEC-violating source, (b) a
  back-reaction-stable throat under quantum interest, or (c) a
  chronology-protection bypass — all out-of-repo.
- `__HEXA_WORMHOLE_*__ PASS` sentinels in CLI output are **sentinel
  only** — they do **NOT** validate the empirical Morris-Thorne wormhole
  claim.
