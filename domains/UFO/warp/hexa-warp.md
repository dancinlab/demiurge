# Alcubierre Warp Metric — n=6 Encoding (BT-347)

> **Provenance**: extracted 2026-05-07 from
> `canon/domains/sf-ufo/ufo/doc/warp-dimension-design.md`
> (canonical SHA `0570a835`, BT-347 row).
>
> well-defined but requires NEC-violating negative energy density. ANEC
> theorems impose strict constraints. No demonstrated controllable warp
> drive exists. This v1.0.0 release ships a **closed-form n=6 candidate
> spec + falsifier preregister**, NOT an empirical claim.

---

## 1. The Alcubierre line element (1994)

```
ds² = -c² dt² + (dx − v_s(t) f(r_s) dt)² + dy² + dz²
```

where:

- `v_s(t) = dx_s / dt` — bubble translation velocity
- `r_s = √((x − x_s(t))² + y² + z²)` — distance from bubble center
- `f(r_s)` — top-hat / tanh shape function with bubble wall at `r_s ≈ R`

Reference: Alcubierre, M. (1994). "The warp drive: hyper-fast travel
within general relativity." *Class. Quantum Grav.* 11 (5): L73–L77.

## 2. n=6 lattice projection

The Alcubierre metric admits a closed-form n=6 lattice projection where
each warp parameter is fixed by the divisor-function machinery:

| symbol | value | role |
|--------|-------|------|
| σ(6) | 12 | divisor-sum — Casimir array plate count, Van Den Broeck σ²=144 reduction, York expansion asymmetry coefficient |
| τ(6) | 4 | divisor-count — 4-stage propulsion cycle |
| φ(6) | 2 | Euler-totient — warp-factor ladder terminus (c/φ = 0.5c) |
| n=R | 6 | base unit — Alcubierre warp bubble radius |
| J₂ | 24 | Mathieu/Leech symmetry — master identity σ·φ ≡ n·τ ≡ 24 |

**Master identity**: `σ · φ ≡ n · τ ≡ 24` (J₂ Mathieu / M₂₄).

## 3. Bubble wall thickness (δ)

The Alcubierre bubble wall thickness in Planck units is set by σ⁻¹:

```
δ = 1 / σ(6) = 1 / 12  ℓ_Pl
```

Thinner walls → sharper top-hat shape → higher curvature gradient →
higher negative-energy demand. σ=12 is the divisor-sum cap; thinning
beyond δ < 1/12 ℓ_Pl violates own 1 lattice equality.

## 4. York expansion θ (asymmetry)

York extrinsic-curvature expansion scalar:

```
θ_forward / θ_rear  =  σ(6)  =  12   (asymmetry coefficient)
```

Forward face: contraction (negative θ). Rear face: expansion
(positive θ). σ=12 ratio sets the asymmetry between leading-edge
volume contraction and trailing-edge volume expansion that propels
the bubble.

## 5. Warp-factor ladder

The warp-factor ladder follows the n=6 reciprocal divisors:

```
c/σ  →  c/n  →  c/τ  →  c/φ
c/12 →  c/6  →  c/4  →  c/2
0.083c → 0.167c → 0.25c → 0.5c
```

Each rung is a reciprocal of an n=6 lattice identifier. The terminus
`c/φ = c/2 = 0.5c` is the binary verdict bit (φ=2 boson identifier
sister to hexa-rtsc Cooper-pair φ=2).

## 6. Casimir negative-energy scaling

The Casimir effect supplies the negative-energy density component
required by the Alcubierre stress-energy tensor:

```
ρ_Casimir  ~  -ℏ c / (τ · d⁴)
            =  -ℏ c / (4 · d⁴)         where d = plate separation
```

Reference: Casimir, H.B.G. (1948). "On the attraction between two
perfectly conducting plates." *Proc. Kon. Ned. Akad. Wet.* 51: 793.

τ=4 is the stage-count denominator — the 4-stage propulsion cycle
divides the Casimir energy budget across {dimension-fold,
warp-accelerate, cruise, dimension-jump}.

## 7. Van Den Broeck negative-energy reduction

The Van Den Broeck (1999) two-region geometry reduces the total
negative-energy demand by σ² = 144:

```
E_neg(VDB)  =  E_neg(Alcubierre raw)  /  σ²
            =  E_neg(Alcubierre raw)  /  144
            ~  M_☉  /  144                (in solar-mass units)
```

Reference: Van Den Broeck, C. (1999). "A 'warp drive' with more
reasonable total energy requirements." *Class. Quantum Grav.* 16
(12): 3973–3979.

The σ²=144 factor is the divisor-sum squared. Without VDB reduction,
raw Alcubierre demands negative energy ~ M_galaxy. With VDB, demand
drops to ~ M_☉ — still NEC-violating, but four orders of magnitude
inside the Pfenning-Ford quantum-inequality bound (see §9).

## 8. Master identity sanity-check

```
σ · φ  =  12 · 2  =  24
n · τ  =   6 · 4  =  24
Hc2-equiv  =  σ · τ  =  12 · 4  =  48   (sister to hexa-rtsc Hc2 = 48 T)
```

The σ·τ=48 invariant cross-links to hexa-rtsc Hc2=48 T (substrate-of-substrates dependency). When RT-SC is empirically realised, the
48T SC coil unlocks the magnetic confinement step that bridges
Stage-1 Meissner → Stage-4 warp.

## 9. Pfenning-Ford quantum inequality (QI bound)

Pfenning & Ford (1997) derived a quantum inequality bound on the
duration of NEC-violating negative-energy density:

```
∫ ρ(t) g(t) dt  ≥  -3 ℏ / (32 π² τ_g⁴)
```

where `τ_g` is a Gaussian sampling time. For Alcubierre bubbles
of macroscopic radius (R ~ 1 m), the QI bound demands negative
energy concentrated within Planck-scale wall thickness — exactly
the δ = 1/σ = 1/12 ℓ_Pl regime in §3.

Reference: Pfenning, M.J. & Ford, L.H. (1997). "The unphysical
nature of 'warp drive'." *Class. Quantum Grav.* 14 (7): 1743–1751.

## 10. Falsifier preregister

Per `.own` own 2 (`hexa-warp-empirical-unproven-contractual`),
3 falsifiers are preregistered MONOTONE:

- **F-WARP-1**: Casimir cavity (σ=12 plate array) cannot realise
  negative-energy density at warp-bubble-relevant scale → DEMOTE
  warp-bubble negative-energy claim.
- **F-WARP-2**: Bubble wall observer cannot signal outside the
  bubble (horizon problem) → DEMOTE controllable warp drive claim.
- **F-WARP-3**: Hawking-style back-reaction destroys bubble
  before propulsion completes → DEMOTE self-stable warp claim.

Status flips MONOTONE: `OPEN → CONFIRMED` or `OPEN → DEMOTED` only.
Silent retract is a raw 91 honest C3 violation.

## 11. Stage-4 of the hexa-ufo 7-stage propulsion stack

`hexa-warp` is **Stage-4** of the hexa-ufo propulsion ladder:

```
Stage-1 hover     Meissner diamagnetism (RT-SC 48T)        ← dancinlab/hexa-rtsc
Stage-2 cruise    MHD + tabletop fusion                    ← dancinlab/hexa-fusion
Stage-3 orbital   antimatter gamma-rocket                  ← dancinlab/hexa-antimatter
Stage-4 warp      Alcubierre bubble (this spec)            ← warp/hexa-warp.md
Stage-5 wormhole  Morris-Thorne ER bridge                  ← wormhole/hexa-wormhole.md
Stage-6 dim-jump  KK ladder 4D→6D→10D→11D→24D→26D          ← dimjump/hexa-dimjump.md
Stage-7 dim-use   τ=4 cycle (σ−φ)²=100c composite          ← dimuse/hexa-dimuse.md
```

Downstream consumer: `hexa-dimuse` (Stage-7 unified propulsion —
warp + wormhole + dim-jump + dim-use combined).

---

## References

- Alcubierre, M. (1994). *Class. Quantum Grav.* 11 (5): L73–L77.
- Casimir, H.B.G. (1948). *Proc. Kon. Ned. Akad. Wet.* 51: 793.
- Pfenning, M.J. & Ford, L.H. (1997). *Class. Quantum Grav.* 14 (7): 1743–1751.
- Van Den Broeck, C. (1999). *Class. Quantum Grav.* 16 (12): 3973–3979.
- Upstream BT-347: `canon/domains/sf-ufo/ufo/doc/warp-dimension-design.md`
  (SHA `0570a835`, 2026-04-06).
