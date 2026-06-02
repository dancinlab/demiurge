<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — bulk compound-semi crystal, wafer, epi-substrate -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; no lattice anchoring of bandgap/k/mobility -->
---
domain: compound-semi
requires: []
verb_group: ceramic_inorganic
status: SPEC_FIRST
verdict_basis: NIST + Sze + vendor datasheets; no lattice fit
---

# Compound-Semi — n=6 소재 substrate, material verb (Phase D 19/29)

> **Material layer only.** III-V (GaN, GaAs, InP, AlN) + IV-IV
> wide-bandgap (SiC) + II-VI (CdTe) + chalcopyrite (CIGS) bulk crystal
> growth, wafer prep, defect engineering. **Device design** (HEMT, LED,
> laser diode, power MOSFET, photodetector) lives in `hexa-chip`.
> SiC's material side cross-links to `silicon/silicon.md §1` and
> `ceramics/`.

> breakdown field, k_th, lattice constant are physical-chemistry
> parameters, NOT n=6 lattice outputs. Wolfspeed (SiC), Sumitomo
> (GaAs), IQE (InP epi), Coherent (GaAs/InP), Mitsubishi Chemical
> (GaN) capacity figures cited verbatim; no projection.

---

## §1 WHY — why compound-semi belongs in hexa-matter

Compound semiconductors are crystalline materials whose electronic
properties (direct bandgap, high mobility, high breakdown field,
high k_th, or radiation hardness) exceed elemental Si in specific
domains. The **material layer** — bulk single-crystal growth,
substrate prep, dislocation engineering, polytype control — is
distinct from device fab (which lives in `hexa-chip`).

| Family | Bandgap (300 K, eV) | Direct/indirect | Industrial signature |
|--------|---------------------|-----------------|----------------------|
| Si (reference) | 1.12 | indirect | logic / DRAM (→ hexa-chip) |
| GaAs | 1.42 | direct | RF / microwave, laser, HBT |
| InP | 1.34 | direct | telecom laser, 100G+ photonic |
| GaN | 3.4 | direct | blue/UV LED, RF power, EV inverter |
| AlN | 6.2 | direct | DUV LED, HEMT buffer |
| 4H-SiC | 3.26 | indirect | EV inverter MOSFET (Wolfspeed) |
| GaP | 2.26 | indirect | red/yellow LED |
| InGaN (alloy) | 0.7–3.4 (tunable) | direct | full-color LED, laser |
| CdTe | 1.45 | direct | thin-film PV (First Solar) |
| CIGS | 1.0–1.7 | direct | thin-film PV |
| Ge | 0.66 | indirect | IR detector, Si-Ge alloy strain layer |

---

## §2 Real-limits-first — compound-semi's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| CS-L1 | GaN bandgap (300 K) | Physical / HARD | **3.4 eV** | Sze SM Physics 3rd ed. |
| CS-L2 | 4H-SiC bandgap (300 K) | Physical / HARD | **3.26 eV** | Saddow & Agarwal 2004 |
| CS-L3 | GaAs bandgap (300 K) | Physical / HARD | **1.42 eV** | NIST / Sze |
| CS-L4 | InP bandgap (300 K) | Physical / HARD | **1.34 eV** | Sze |
| CS-L5 | AlN bandgap (300 K) | Physical / HARD | **6.2 eV** (widest III-V binary) | Slack et al. 2002 |
| CS-L6 | SiC breakdown field (4H) | Physical / HARD | **3 MV/cm** (vs Si 0.3) | Wolfspeed datasheet |
| CS-L7 | GaN breakdown field | Physical / HARD | **3.3 MV/cm** | Mishra UCSB review 2008 |
| CS-L8 | GaAs electron mobility (300 K, undoped) | Physical / HARD | **8500 cm²/V·s** (vs Si 1450) | Sze |
| CS-L9 | InP electron mobility (300 K) | Physical / HARD | **5400 cm²/V·s** | Sze |
| CS-L10 | SiC thermal conductivity (4H, room T) | Physical / HARD | **370–490 W/m·K** (vs Si 150) | Wolfspeed |
| CS-L11 | GaN-on-Si lattice mismatch | Engineering / SOFT | **17 %** (large; requires AlN/AlGaN buffer stack) | Mishra 2008 |
| CS-L12 | SiC-on-Si lattice mismatch | Engineering / SOFT | **20 % (3C-SiC on Si)** | Saddow 2004 |
| CS-L13 | Commercial SiC wafer diameter (ramping) | Engineering / SOFT | **200 mm 4H-SiC** (Wolfspeed Mohawk Valley 2022–) | Wolfspeed press |
| CS-L14 | Commercial GaN bulk wafer diameter | Engineering / SOFT | **100 mm (4-inch)** ammonothermal | Mitsubishi Chemical / Soitec |
| CS-L15 | GaAs commercial wafer diameter | Engineering / SOFT | **150 mm (6-inch)** standard, **200 mm** R&D | Sumitomo / Freiberger |

**Note on lattice mismatch (CS-L11/12).** The 17–20 % GaN/Si and SiC/Si
mismatches mean heteroepitaxy requires graded buffer stacks (AlN seed
+ AlGaN step) to reach device-grade dislocation density (~ 10⁹ cm⁻²
typical, vs ideal 10³ cm⁻² for native substrate). This is the central
engineering constraint of GaN-on-Si vs GaN-on-SiC.

**Note on wafer diameter (CS-L13/14/15).** Commercial diameter is far
behind Si (300 mm standard). The 200 mm 4H-SiC ramp at Wolfspeed
(Mohawk Valley 2022, full ramp 2024–) and the 100 mm GaN bulk
ammonothermal ceiling at Mitsubishi Chemical / Soitec are the
state-of-the-art. **UNVERIFIED in this repo**: production yield at
those diameters; cited from vendor public statements.

---


| Producer | Material focus | Reported scale | Source |
|----------|----------------|----------------|--------|
| Wolfspeed (Cree) | 4H-SiC substrates + power MOSFET | 200 mm wafers, Mohawk Valley fab ~ $1B capex | Wolfspeed IR |
| II-VI / Coherent | SiC + GaN power, InP photonic | not separately broken out | Coherent IR |
| Soitec | GaN-on-Si engineered substrate | wafer count not public | Soitec IR |
| Sumitomo Electric | GaAs + InP wafers (~ 50% global GaAs) | wafer area not public | Sumitomo IR |
| Freiberger Compound Materials | GaAs ingot (LEC) | ~ 200 t/yr ingot | company release |
| IQE plc | epitaxy on GaAs / InP / GaN | wafer-area count | IQE annual |
| Mitsubishi Chemical | bulk GaN ammonothermal | 2-inch + 4-inch demo | Mitsubishi public |
| Nichia | GaN epi for LED | not broken out | Nichia public |
| First Solar | CdTe thin-film PV | ~ 16 GW/yr nameplate (2024) | First Solar IR |

> **Honesty caveat (LATTICE_POLICY §3.3):** these producers do not
> anchor capacity to n=6. Wafer count / ingot tonnage is bounded by
> crucible size, PVT sublimation rate (SiC), LEC encapsulation chemistry
> (GaAs), and ammonothermal autoclave pressure (GaN) — not by lattice.

---

## §4 STRUCT — compound-semi material flow

```
[III-V or IV-IV elemental feedstock]                   [SiC: high-purity SiC powder]
   Ga + As, Ga + N, In + P, Al + N                          ↓ PVT sublimation 2500 °C
        ↓                                                [4H-SiC ingot, 150–200 mm]
[LEC Czochralski w/ B₂O₃ encapsulant]                       ↓ wire-saw + CMP
[GaAs / InP bulk ingot]                                  [4H-SiC wafer]
        ↓                                                       ↓
[Wafer wire-saw + CMP]                              [→ epi via MOCVD or homoepitaxy]
        ↓                                                       ↓
[GaAs / InP wafer]                                  [→ hexa-chip: SiC MOSFET design]
        ↓
[→ epi via MOCVD or MBE]
        ↓
[→ hexa-chip: HEMT / HBT / laser device design]

GaN branch:
   [Sapphire or SiC substrate]
        ↓ MOCVD GaN heteroepitaxy
   [GaN-on-sapphire / GaN-on-SiC]
        ↓ (alternative) ammonothermal bulk GaN
   [Bulk GaN crystal, 50–100 mm]
        ↓
   [→ hexa-chip: GaN HEMT, blue LED]
```

---

## §5 FLOW — process aspects in scope

| Process step | Material-aspect concern (this repo) | Out-of-scope (→ hexa-chip) |
|--------------|-------------------------------------|----------------------------|
| LEC Czochralski (GaAs/InP) | dislocation density, EPD, twin formation | — |
| PVT sublimation (SiC) | polytype stability (4H vs 6H vs 3C), micropipe density | — |
| Ammonothermal (bulk GaN) | autoclave pressure, mineralizer chemistry, GaN crystal habit | — |
| MOCVD heteroepitaxy | layer thickness control, composition uniformity | device structure design |
| MBE | atomic-layer control, doping incorporation | device structure design |
| HVPE GaN | growth rate (~ 100 µm/h), bulk crystal habit | — |
| Wire-saw + CMP | TTV, bow, warp, edge-profile | mask aligner specs |

---

## §6 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | 100 mm GaAs LEC | Commercial commodity |
| Mk.II | 150 mm 4H-SiC PVT (Cree/Wolfspeed ~2010) | Commercial commodity |
| Mk.III | 200 mm 4H-SiC (Wolfspeed Mohawk Valley 2022–) | Ramping |
| Mk.IV | Bulk GaN 100 mm ammonothermal | Niche commercial |
| Mk.V | 300 mm SiC | R&D — UNVERIFIED at commercial yield |
| Mk.VI | Bulk AlN 50 mm (Hexatech) | Niche / R&D |
| Mk.VII | Diamond as semiconductor (5.45 eV) | R&D — UNPROVEN at wafer scale |

---

## §7 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| SiC as ceramic + Si-cross-link | `silicon/silicon.md §1 + Si-L11`, `ceramics/ceramics.md` |
| Diamond as ultra-wide-bandgap | `carbon/carbon.md`, GRAPHENE-CARBON.md |
| Perovskite halide as direct-bandgap semi | `perovskite/perovskite.md` |
| 2D-material semiconductors (MoS₂, WSe₂) | `2d-materials/2d-materials.md` |
| Magnetic semiconductors (CrI₃) | `magnetic-materials/magnetic-materials.md` |
| **Device + fab + lithography + EUV resist** | **`hexa-chip materials`** |
| Power-electronic device + EV inverter | `hexa-energy`, `hexa-mobility` |

Boundary rule: this spec ends at the **wafer leaving CMP**. What
happens after — wafer in, die out — is `hexa-chip`'s domain.

---

## §8 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| GaN E_g = 3.4 eV | Sze SM Physics | CS-L1 sanity |
| 4H-SiC E_g = 3.26 eV | Saddow & Agarwal 2004 | CS-L2 sanity |
| GaAs E_g = 1.42 eV | NIST / Sze | CS-L3 sanity |
| GaAs μ_e = 8500 cm²/V·s | Sze | CS-L8 sanity |
| 4H-SiC k_th = 370–490 W/m·K | Wolfspeed | CS-L10 sanity |
| Wolfspeed 200 mm SiC ramp | Wolfspeed press | CS-L13 sanity |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-CS-1 | 300 mm 4H-SiC commercial wafer ramp (peer-confirmed yield) | OPEN |
| F-CS-2 | Bulk GaN > 200 mm wafer at commercial yield | OPEN |
| F-CS-3 | Diamond semiconductor commercial wafer > 50 mm | OPEN |
| F-CS-4 | GaN-on-Si dislocation density < 10⁷ cm⁻² at 8-inch | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "GaN E_g 3.4 eV equals σ·τ/(n×0.5)" — coincidence; do not write
- ✗ "SiC k_th 490 W/m·K fits n=6 lattice" — coincidence; do not write
- ✗ "Wolfspeed 200 mm wafer follows n=6" — they have not heard of it

---

## §9 Honest scope + caveats

1. **Material layer only.** Device structure, HEMT/HBT design, LED
   internal quantum efficiency, MOSFET R_dson — **not here.** Call
   `hexa-chip materials` for those.

2. **Bulk-GaN at production scale is still narrow.** Mitsubishi
   Chemical / Soitec demonstrate 100 mm ammonothermal; 200 mm is
   R&D-only as of 2026. **UNVERIFIED**: cost-effective 6/8-inch bulk
   GaN; cited as vendor public R&D status.

3. **No lattice anchoring of vendor numbers.** Wolfspeed / Sumitomo /
   IQE / Freiberger / Mitsubishi capacities are their own published
   figures; this spec does not project onto n=6.

4. **Diamond as semiconductor remains UNPROVEN at wafer scale.** Mk.VII
   in §6 is R&D; do not claim production diamond device wafer.

5. **SPEC_FIRST verdict.** No numbers in this file are MEASURED in
   this repo; all are cited from Sze / NIST / Saddow / Wolfspeed /
   Sumitomo / Mitsubishi public disclosures.

6. **Coincidence disclosure (LATTICE_POLICY §1.1).** Any apparent fit
   of bandgap / mobility / breakdown to n=6 is coincidence; the
   lattice does not predict these.


---

## §10 References

- Sze S.M., Ng K.K., *Physics of Semiconductor Devices*, 3rd ed. (2007)
- Saddow S.E., Agarwal A. (eds.), *Advances in Silicon Carbide Processing & Applications* (2004)
- Mishra U.K., Parikh P., Wu Y.-F., "GaN-Based RF Power Devices and Amplifiers," *Proc. IEEE* 96, 287 (2008)
- Slack G.A., Tanzilli R.A., Pohl R.O., Vandersande J.W., "The intrinsic thermal conductivity of AlN," *J. Phys. Chem. Solids* 48, 641 (1987)
- NIST WebBook — electronic properties of binary semiconductors
- Wolfspeed — 4H-SiC wafer / MOSFET datasheets
- Sumitomo Electric — GaAs / InP substrate datasheets
- Mitsubishi Chemical — bulk GaN ammonothermal public statements
- Soitec — engineered substrate annual report
- IQE plc — epitaxy on compound substrates
- `silicon/silicon.md` §1, Si-L11
- `LATTICE_POLICY.md` §1.2 + §1.3
- `LIMIT_BREAKTHROUGH.md` (Wave M)
- Cross-link: `dancinlab/hexa-chip` (device layer)

---

*Authored 2026-05-13 by 박민우. Material-layer spec for Phase D
`compound-semi` verb (19 of 29). Real-limits-first per
LATTICE_POLICY.md §1.2; no lattice fit on bandgap / mobility / k_th
or vendor capacity. Device + fab process out of scope — `hexa-chip`.*

---

## Related NOVEL candidate

- `hxm-weyl-tas-001` — see [NOVEL.md §4.C.4](../NOVEL.md): TaAs-family Weyl semimetal.

> SIM / proxy status is NOT a measurement and does NOT promote to `EXTERNAL-VERIFIED` without attributed external-lab evidence (NOVEL.md §7 · @F f2 / f5).
