<!-- @canonical: canon@0570a835:reports/sessions/specs/2026-04-06-ufo-warp-dimension-design.md -->
<!-- @extracted: 2026-05-07 -->
<!-- @section: BT-349 (Warp-Dimension Unified Propulsion n=6 Architecture) -->
# 🛸 hexa-dimuse — UFO Stage-7 Warp+Dim-Jump Unified Propulsion Spec (BT-349)

> **SSOT** for the composite-of-warp-and-dimjump empirical claim. CLI table,
> roadmap §A.1, README badges, and `verify/*.hexa` all derive from this
> document. If numbers disagree, **this spec wins**.

> **Status: UNPROVEN² (Mk.V 2150+ SF-class target).** Both upstream
> substrates (hexa-warp Stage-4 BT-347, hexa-dimjump Stage-6 BT-348) are
> themselves academically UNPROVEN. This spec is a **closed-form composite
> candidate + falsifier preregister**, not an empirical claim.

---

## §1. Identity

- **Substrate**: `hexa-dimuse` (UFO Stage-7 terminal composite)
- **n=6 master identity**: σ·φ ≡ n·τ ≡ 24
- **Composite-of**: hexa-warp (Stage-4 BT-347) + hexa-dimjump (Stage-6 BT-348)
- **Alternative path**: hexa-wormhole (Stage-5 — separate composite, NOT a dependency)
- **Source SSOT**: `canon/domains/sf-ufo/ufo/doc/warp-dimension-design.md` §BT-349

---

## §2. n=6 invariant lattice

```
σ(6) · φ(6) = n · τ(6) = J₂ = 24
   12   ·   2  =  6  ·   4  = 24

derived:   (σ − φ)² = (12 − 2)² = 100c   (effective composite speed)
```

| Symbol            | Value | Role                                       |
|-------------------|-------|--------------------------------------------|
| σ(6)              | 12    | composite drive cardinality (12 propulsion sub-systems / Stage4+Stage6 fan-out) |
| τ(6)              | 4     | 4-stage cycle (dimension-fold/warp-accelerate/cruise/dimension-jump) |
| φ(6)              | 2     | binary verdict bit (composite cycle complete / aborted) |
| (σ − φ)²          | 100   | derived effective composite speed (in c) |
| sopfr(6)          | 5     | 2 + 3 = sum of prime factors with multiplicity |
| J₂                | 24    | Mathieu / Leech symmetry; cycle group |

These are **closed-form candidates**, not empirically fitted constants.

---

## §3. τ=4 stage cycle (canonical)

| Stage | Phase                | Action                                                  | Upstream substrate    |
|-------|----------------------|---------------------------------------------------------|-----------------------|
| 1     | dimension-fold       | extra-dimensional compactification radius collapse → energy release | hexa-dimjump (BT-348) |
| 2     | warp-accelerate      | feed released energy into negative-energy bubble → 10c warp factor | hexa-warp (BT-347)    |
| 3     | cruise               | 100c effective composite traversal (warp 10c × dim compression 10×) | both                  |
| 4     | dimension-jump       | 4D ↔ 10D transition at target → land                    | hexa-dimjump (BT-348) |

**Cycle closes (Stage 4 → Stage 1)**: self-cycle energy = dimensional-fold
release feeds next warp burst. Closed-loop within the design spec.

---

## §4. Effective composite speed

Composite chain:

```
warp factor          = σ − φ = 12 − 2 = 10c   (hexa-warp Stage-4 BT-347)
dim compression      = σ − φ = 10×              (hexa-dimjump Stage-6 BT-348)
effective composite  = (σ − φ)² = 10 × 10 = 100c
```

### α-Centauri 4.37 ly travel-time (BT-349 design spec)

The BT-349 design spec gives **~16 days canonical** for α-Centauri. The
heuristic formula is:

```
t = sopfr · (σ − φ) / (σ − φ)²
  = 5 · 10 / 100
  = 0.5  (in spec-internal units)
```

**Note**: bare arithmetic gives 0.5 spec-units; canonical 16 days encodes
design-internal unit reconciliation (Mk.V design spec maps the spec-unit
to ~32 days, giving 0.5 × 32 = 16 days). This unit reconciliation is
flagged in roadmap §A.5 as a **pending-decision** item for v1.1.0
simulator validation. Do not treat the bare formula as the empirical
claim — the canonical 16-day value is the design target.

### Sirius (8.6 ly) projection

Linear scaling at 100c effective: ~86 days canonical (per Mk.V spec).

---

## §5. Energy source: self-cycle closed-loop

```
Stage 1 (fold)     →  E_fold = M_Pl · c² / (σ − φ)^d   (released)
Stage 2 (warp)     →  E_warp = solar mass / σ²         (consumed; ~1/144 M☉ via Van Den Broeck)
Stage 4 (jump)     →  E_jump = (σ − φ) extra dims      (transition cost)
```

Closed-loop assumes:

1. Stage-1 fold release > Stage-2 warp consumption (net energy positive)
2. 2nd law of thermodynamics not violated in 4D projection
3. Composite back-reaction does not destabilize the cycle

These are **falsifier-bound** conditions (see §6).

---

## §6. Falsifier preregister (composite UNPROVEN^2)

| ID         | Statement                                                                                       | Status     |
|------------|-------------------------------------------------------------------------------------------------|------------|
| F-USE-1    | warp Stage-4 ANEC bound saturated → DEMOTE 10c warp factor (upstream hexa-warp BT-347 dep)      | OPEN |
| F-USE-2    | dimjump Stage-6 KK m > 14 TeV from LHC → DEMOTE 10× dimensional compression (BT-348 dep)        | OPEN |
| F-USE-3    | self-cycle violates 2nd law thermodynamics in 4D projection → DEMOTE closed-loop energy claim    | OPEN |
| F-USE-4    | composite back-reaction destabilizes both stages simultaneously → DEMOTE τ=4 cycle stability     | OPEN |

**Composite UNPROVEN propagation**: F-USE-1 + F-USE-2 are upstream-derived
falsifiers (their disposition is gated by upstream substrate empirical
status). F-USE-3 + F-USE-4 are composite-specific (testable in v1.1.0
simulator).

---

## §7. Mk-stage roadmap

Per upstream BT-349 design spec (warp-dimension-design.md §2):

- **Mk.II (2036, personal 6m)** — Dimension-Sensor Payload (BT-348 verification platform)
- **Mk.III (2056, family 12m)** — Casimir Warp-Field experiment (BT-347 verification platform)
- **Mk.IV (2076, orbital 24m)** — Dimensional-Fold Prototype (BT-349 Phase 1)
- **Mk.V (2150+, urban 288m)** — Full Warp + Dim-Jump (full τ=4 cycle, 100c, α-Cen 16d) — **SF-class target**

This repo's v1.0.0 covers the **spec layer**; empirical realisation is
Mk.V 2150+.

---

## §8. Provenance

- BT-349 spec **scaffolded** from `canon/domains/sf-ufo/ufo/doc/warp-dimension-design.md`
  (canonical SHA `0570a835`, BT-349 section, extracted 2026-05-07).
- Upstream substrates referenced:
  - `canon` BT-347 (Alcubierre warp metric n=6 encoding) → `hexa-warp`
  - `canon` BT-348 (extra-dimensional compactification n=6 topology) → `hexa-dimjump`
- Sister-of-substrates extraction template: `hexa-rtsc` v1.0.0
  (post-3080c11 hive raw.mk2 arch.001).

---


> 1. **(sentinel only — does NOT validate empirical composite Warp+Dim-Jump claim)**
> 2. **(UNPROVEN^2 — both upstream substrates hexa-warp and hexa-dimjump are themselves UNPROVEN)**
> 3. The 100c effective speed claim assumes both warp and dimensional
>    compression work as specified — neither has been demonstrated.
> 4. Self-cycle energy claim requires NEC violation control AND extra-
>    dimensional energy extraction — none observed.
> 5. v1.0.0 ships SPEC + falsifier preregister only. Empirical composite
>    realisation is Mk.V 2150+ SF-class target.

---

## §10. Cross-link

- Upstream substrate (composite-of): `hexa-warp` (Stage-4 BT-347)
- Upstream substrate (composite-of): `hexa-dimjump` (Stage-6 BT-348)
- Alternative path (NOT dependency): `hexa-wormhole` (Stage-5)
- Sister substrate: `hexa-rtsc` (Stage-1 Meissner dependency upstream)
- Source SSOT: `canon/domains/sf-ufo/ufo/doc/warp-dimension-design.md` §BT-349
