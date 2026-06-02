# PEROVSKITE — Phase D candidate stub

> **Authored**: 2026-05-13 (Phase A elevation) · **Status**: STUB — Phase D roadmap marker
> **Author**: 박민우 <nerve011235@gmail.com>
> **Target group**: GROUP_CER · **Phase D priority**: HIGH (per `USER_ACTION_REQUIRED.md §2`)
>
> Stub placeholder for the Phase D `perovskite` verb covering ABO₃ structures
> + halide perovskites + the LK-99 status disambiguation.

---

## §1 Scope

The perovskite structure is **ABX₃**: large A cation in cuboctahedral coordination, small B cation in octahedral coordination, X anion (oxide or halide) at corners. This single structure type spans 4 distinct material families:

| Family | Composition | Property highlight | Use |
|--------|-------------|---------------------|-----|
| Oxide perovskite | ABO₃ | piezoelectric, ferroelectric, dielectric | capacitor (BaTiO₃), actuator (PZT), memory (BiFeO₃) |
| Halide perovskite | APbX₃ (X = I, Br, Cl) | direct bandgap solar absorber, tunable LED | solar (MAPbI₃, FAPbI₃), LED |
| Double perovskite | A₂BB'X₆ | tunable magnetism / multiferroic | spintronic, multiferroic |
| Antiperovskite | A₃BX (X = N, C) | superconductor (LK-99 candidate), Mn-N magnetism | research frontier |

---

## §2 Workhorse compositions

| Composition | Property | Source |
|-------------|----------|--------|
| BaTiO₃ | ε_r 1000-15000; piezoelectric d₃₃ ~ 200 pC/N | Murata datasheet, multilayer ceramic capacitor industry |
| Pb(Zr,Ti)O₃ (PZT) | piezoelectric d₃₃ 200-600 pC/N | PiezoTech datasheet, actuator industry |
| BiFeO₃ | multiferroic (ferroelectric + antiferromagnetic) at room T | research literature |
| LaCoO₃ | spin-state transition + thermoelectric | research |
| LaMnO₃ + doping | CMR (colossal magnetoresistance) | research |
| MAPbI₃ (CH₃NH₃PbI₃) | tunable bandgap 1.55 eV; PCE 25%+ in solar cells | Saliba et al. 2018 *Energy Environ. Sci.* 11, 277 |
| FAPbI₃ | bandgap 1.48 eV; longer-lifetime perovskite solar | research literature |
| SrTiO₃ | epitaxial substrate, superconductor when n-doped | Bednorz-Müller 1986 (cuprate context) |

---

## §3 LK-99 status

LK-99 (Lee, Kim, Kwon 2023): Cu-doped lead-apatite "Pb₁₀₋ₓCuₓ(PO₄)₆O" claimed as **room-T ambient-pressure superconductor** in July 2023.

By 2024:
- Multiple independent groups (Stanford, Princeton, IIT-Bombay, several PRC labs) attempted reproduction
- Result: **null** for superconductivity; the resistance drop appeared due to Cu₂S impurity phase transition near 110 °C (similar resistivity signature, not actual SC)
- Per `LIMIT_BREAKTHROUGH.md §4`: LK-99 "Not reproduced; HARD_WALL until peer-reviewed reproduction" — **the HARD_WALL stands.**

Phase D `PEROVSKITE.md` will:
- Disambiguate true antiperovskite structures (Cu₃N, Mn₃Cu) from the LK-99 "apatite" structure (which is hexagonal, NOT perovskite proper)
- Document the rep failure honestly (no lattice fit on the original claim; cite the failed reproductions)

---

## §4 Real-limit anchors (planned)

- L4 Mohs hardness — perovskite oxides typically Mohs 5-7 (Curtis 1968)
- L7 glass T_g — silicate-perovskite glass-ceramic frontier
- HARD_WALL on LK-99 SC reproduction (per `LIMIT_BREAKTHROUGH.md §4`)

---

## §5 Cross-links (when expanded)

- `ceramics/ceramics.md` + `CERAMIC-ENGINEERING.md` — oxide perovskite ceramic processing
- `compound-semi/` (Phase D) — halide perovskite (MAPbI₃) as semiconductor
- `magnetic-materials/` (Phase D stub) — perovskite magnetism + multiferroic
- `LIMIT_BREAKTHROUGH.md` — LK-99 HARD_WALL row
- `hexa-energy` — perovskite solar cell device level

---

## §6 Honest C3

Phase D candidate. Stub-level. LK-99 status is treated honestly (null reproduction → HARD_WALL until peer-reviewed). No lattice fit on any composition. Per `LATTICE_POLICY §1.2`.

---

*Stub authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase D roadmap marker.*
