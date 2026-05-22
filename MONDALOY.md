# MONDALOY — combustion-resistant superalloy verification target

> **Status**: spec / discovery-target framing · `absorbed=false` ·
> `gate_type=simulation-only-prediction` — no composition claim, no
> measured-oracle (MondAloy composition is SpaceX trade secret).
>
> opened: 2026-05-22 KST (demiurge domain doc) ·
> upstream draft: `hexa-space/mondaloy/mondaloy.md` (2026-05-07,
> n=6-lattice structural-pattern framing) ·
> historical log: [`./MONDALOY.log.md`](./MONDALOY.log.md)
>
> sibling of `RTSC.md` (compositional superconductor discovery) ·
> `NUCLEAR.md` (elemental discovery) — those discover/verify *novel*
> materials; MONDALOY.md tracks a **known proprietary target** whose
> structural-property envelope can be bounded by first-principles /
> thermodynamic modelling without the proprietary composition.

This document is the demiurge materials-domain doc for **MondAloy** —
SpaceX's combustion-resistant nickel-based superalloy. It frames the
non-wet-lab verification pipeline (d1) for a MondAloy-*class* alloy:
what a first-principles or CALPHAD-grade study could predict, and the
honest boundary where the proprietary composition makes the verdict
structural-pattern only.

---

## §1. What MondAloy is (public surface only)

MondAloy is SpaceX's proprietary nickel-based combustion-resistant
superalloy, publicly disclosed (by SpaceX statements / press) as the
material of:

- the **Raptor 3 combustion chamber**, and
- the **oxygen-rich preburner lining**.

Its design failure mode is **oxygen-rich high-temperature combustion**
— the regime that historically destroyed ox-rich staged-combustion
engines (the same regime the Soviet RD-170 family fought with
specialized coatings). MondAloy's claimed niche is holding integrity
against ox-rich hot gas without a separate ceramic coating.

**The composition is a SpaceX trade secret.** No public chemistry
disclosure is assumed. Everything below is either public-surface fact
or an explicitly-labelled structural-pattern model — never a chemistry
claim (governance D1 clean-room · d6 measured-oracle invariant).

## §2. Why this is a demiurge domain doc

demiurge is the meta-conductor of a materials → chip → component
program. MondAloy sits squarely in the **materials verb** for the
space domain: a combustion-chamber superalloy is the SYNTHESIZE-stage
material a rocket-engine design pass must specify and verify.

RTSC.md asks "can a novel composition reach a target Tc"; MONDALOY.md
asks the dual question — "given a *known* target alloy class, how far
can the non-wet-lab pipeline bound its high-temperature / oxidation
envelope **without** the proprietary composition?" That is a legitimate
d1 exercise: drive the *bounding* analysis to completed-form, and name
the proprietary-composition wall as the honest `not yet` boundary.

## §3. Non-wet-lab verification pipeline (d1 — what CAN be driven to done)

A MondAloy-*class* Ni-base superalloy (Ni + ~5 strengtheners — public
superalloy practice, e.g. Inconel/Hastelloy/René families) admits a
real first-principles + thermodynamic pipeline that needs *no*
proprietary data:

| stage | method | what it bounds | proprietary-free? |
|---|---|---|---|
| phase stability | CALPHAD (Thermo-Calc / OpenCALPHAD + TCNI database) | γ/γ′ phase fractions vs T for a *candidate* composition | ✓ (uses public Ni-superalloy databases) |
| oxidation kinetics | parabolic-rate / Wagner theory + DFT O-vacancy formation | NiO/Cr₂O₃/Al₂O₃ scale growth rate vs T, pO₂ | ✓ |
| el./thermal transport | DFT + Boltzmann transport (как RTSC el-ph pipeline) | thermal conductivity, used as a *low-conductivity* design lever | ✓ |
| creep / thermomech | crystal-plasticity FEM (e.g. via `hexa-lang/stdlib` fem kernel) | creep life vs stress/T for a candidate microstructure | ✓ |
| service ceiling | combine the above → T_max envelope | upper bound on service temperature for a candidate | ✓ |

Each of these is a Tier-1 *prediction* (`gate_type=simulation-only-
prediction`, exactly like RTSC DFT). None flips `absorbed=true` — that
would need a measured oracle against the *actual* MondAloy, which is
proprietary and unavailable (d6).

## §4. The honest wall (d2 framing — not a concession)

The proprietary composition is an empirically-demonstrated wall: we
cannot verify *MondAloy itself*. Per d2, the breakthrough framing is
**not** "impossible" — it is to redefine the deliverable:

1. **Bound the class, not the instance.** Drive a CALPHAD + DFT study
   of the *public* Ni-base ox-resistant superalloy envelope to
   completed-form; report the predicted T_max / oxidation-rate band
   that any Ni+5 alloy in that family can occupy. MondAloy then sits
   *somewhere in that band* — a verified bound, not a guessed point.
2. **Inverse-design a MondAloy-class candidate.** Use the same
   compositional-sweep machinery RTSC uses for hydrides (DFT screen +
   CALPHAD filter) to *propose* a Ni+5 composition that meets the
   public-spec envelope (ox-rich, ~2200 K class, low conductivity).
   That candidate is a novel demiurge prediction — publishable,
   `absorbed=false`, and entirely proprietary-free.
3. **Measure a non-proprietary analog.** A lab-castable Ni-base
   ox-resistant alloy (public composition) can be the measured-oracle
   carrier — the pipeline is then validated on the analog, exactly as
   the RTSC pipeline was validated on H₃S before being applied to
   novel H₃X.

## §5. n=6 structural-pattern note (numerology — NOT measurement)

The upstream `hexa-space/mondaloy/mondaloy.md` maps MondAloy counts to
the n=6 lattice (6 alloying elements, 12 chamber zones, 4 thermal
regimes, σ·φ = n·τ = 24, etc.). Per demiurge governance (d6/d7, and
the §8.8 hexa-atlas-witnessed stance in `RTSC.md`):

> **The n=6 mapping is a counting coincidence / mnemonic, NOT a
> physical prediction.** It carries `gate_type` nothing — it is not a
> simulation, not a measurement, not a Tier-1 prediction. It must
> never be cited as evidence for any thermomechanical property of
> MondAloy. `verify_mondaloy.hexa` tests the *count-lattice* only and
> explicitly "does NOT model thermomechanical behavior" (upstream §4).

This doc records the n=6 framing only to mark it as **out of scope**
for any `absorbed`/gate decision — the same carve-out RTSC.md applies
to hexa-atlas n6 "Tc 300K" being a *target*, not a measurement.

## §6. Status

- v0.1 — demiurge domain doc opened (this file). No pipeline run yet.
- `absorbed=false` · no measured oracle · composition proprietary.
- No demiurge `exports/` record emitted for MondAloy. When the §3
  pipeline runs (CALPHAD or DFT), records land in
  `exports/material_discovery/` with `gate_type=simulation-only-
  prediction`, exactly like the RTSC H₃X records.
- Upstream `hexa-space/mondaloy/` remains `SPEC_ONLY` v1.0.0.

## §7. Cross-references

- `hexa-space/mondaloy/mondaloy.md` — upstream n=6 structural-pattern
  draft (2026-05-07) + `verify_mondaloy.hexa` count-lattice script
- `hexa-space/falcon/falcon.md` — Merlin engine (non-MondAloy variant)
- `hexa-space/spaceship/spaceship.md` — Raptor 3 combustion path
- `RTSC.md` — sibling materials-discovery doc (the d6/d7 governance
  pattern this doc reuses)
- `NUCLEAR.md` — sibling elemental-discovery doc
- `project.tape` d1 (drive non-wet-lab verification to done) · d2
  (wall → breakthrough paths) · d6 (absorbed ⇔ measured oracle) ·
  d7 (report only converged values, no forced target)

---

Historical log entries are in [`./MONDALOY.log.md`](./MONDALOY.log.md).
