<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — alkali-activated aluminosilicate binder (fly-ash, metakaolin, slag); not Portland cement -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; no lattice anchoring of geopolymer parameters -->
---
domain: geopolymer
requires: []
verb_group: ceramic_inorganic
status: SPEC_FIRST
verdict_basis: Davidovits original + ASTM C1157 + peer-reviewed literature + Wagners EFC / Zeobond vendor data; no lattice fit
---

# Geopolymer — n=6 소재 substrate, material verb (Phase D follow-on 31/33)

> **Material layer only.** Alkali-activated aluminosilicate inorganic
> polymers — three-dimensional Si-O-Al-O networks formed at near-ambient
> temperature from a solid aluminosilicate precursor (fly ash, metakaolin,
> ground-granulated blast-furnace slag (GGBFS), red mud) and a high-pH
> alkali activator (NaOH / KOH + sodium silicate "water glass"). Sits
> alongside `concrete/` (OPC-based) as a **CO₂-reduced binder
> alternative**. CO₂-footprint and long-term-durability claims
> UNVERIFIED at multi-decade in-service scale.

> (compressive strength, setting time, alkali-silica reaction
> resistance, CO₂ intensity per ton binder) are set by **Si/Al ratio,
> activator molarity, precursor reactivity, and curing schedule** —
> not by the n=6 lattice. Wagners EFC (Earth Friendly Concrete) /
> Zeobond E-Crete / Banah UK / Cemex Vertua vendor figures cited
> verbatim with no lattice projection.

---

## §1 WHY — why geopolymer belongs in hexa-matter

Portland cement (OPC, `concrete/` verb) is responsible for ~ 7–8 % of
global anthropogenic CO₂ emissions (IEA Cement Roadmap 2023; ~ 4 Gt/yr
cement → ~ 2.3 Gt/yr CO₂). Two-thirds of this CO₂ is from
**calcination of CaCO₃ → CaO + CO₂** — fundamental chemistry, not
fuel-side, so cannot be eliminated by electrification alone.

Geopolymers bypass calcination: they bind via **dissolution +
polycondensation of aluminosilicate precursors** at room temperature
in alkaline solution. The Si-O-Al-O-Si network has been called the
"third generation cement" by Davidovits (Geopolymer Institute, 1979).

| Subclass | Precursor | Activator | Industrial signature |
|----------|-----------|-----------|----------------------|
| Fly-ash-based (Class F) | Coal fly ash (low-Ca) | NaOH 8–14 M + Na₂SiO₃ | Wagners EFC; airfield runway; mass concrete |
| Metakaolin-based | Calcined kaolin clay (700–800 °C, 4 h) | NaOH + Na₂SiO₃ | High-purity research grade; refractory |
| GGBFS-based (alkali-activated slag, AAS) | Ground-granulated blast-furnace slag | NaOH + Na₂SiO₃ or Na₂CO₃ | Strong + fast-setting; structural |
| Hybrid (FA + Slag) | 50/50 mix typical | NaOH + Na₂SiO₃ | Engineering optimum (workability + strength) |
| Red mud / mine-tailings | Bayer-process residue or tailings | NaOH (already alkaline) | R&D — waste-stream upcycle |

**Distinction from `concrete/` (Portland-cement, OPC):** OPC is C-S-H
(calcium-silicate-hydrate) bound; geopolymer is N-A-S-H or C-A-S-H
(sodium/calcium-aluminosilicate-hydrate) bound. Chemistry, hydration
schedule, and CO₂ intensity all differ.

---

## §2 Real-limits-first — geopolymer's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| GP-L1 | FA geopolymer 28-day compressive strength (typical) | Engineering / SOFT | **30–60 MPa** (Class F + activator + heat-cure 60–80 °C, 24 h) | Hardjito-Rangan 2005 (Curtin Univ.); Provis & van Deventer 2014 |
| GP-L2 | Metakaolin geopolymer 28-day σ_c | Engineering / SOFT | 40–90 MPa (lab) | Davidovits 2008; Duxson et al. 2007 |
| GP-L3 | AAS (slag-activated) 28-day σ_c | Engineering / SOFT | 60–100 MPa, **up to 130 MPa** with optimized activator | Provis & Bernal 2014 review |
| GP-L4 | Geopolymer setting time at room T (FA dominant) | Engineering / SOFT | 4–24 h (without heat cure) | Hardjito 2005 |
| GP-L5 | Geopolymer thermal stability (refractory) | Engineering / SOFT | up to **1200 °C** (loss < 30 % strength) — fire-resistant | Kong-Sanjayan 2010 fire test |
| GP-L6 | Sodium hydroxide activator molarity (FA) | Engineering / SOFT | typically **8–14 M NaOH** | Hardjito 2005 |
| GP-L7 | Sodium silicate / NaOH mass ratio | Engineering / SOFT | typically 1.5–2.5 by mass | Provis 2014 |
| GP-L8 | Reported CO₂ intensity FA geopolymer vs OPC | Engineering / **UNVERIFIED** | claimed **40–80 % lower** vs OPC (~ 900 kg CO₂/t OPC); see honesty caveat | Davidovits 1991; Habert-D'Espinose 2011 LCA — **system-boundary-sensitive** |
| GP-L9 | Wagners EFC (commercial) compressive strength | Engineering / SOFT | 32–50 MPa typical commercial | Wagners EFC datasheet |
| GP-L10 | Zeobond E-Crete (commercial) compressive strength | Engineering / SOFT | 25–60 MPa | Zeobond commercial product literature |
| GP-L11 | Alkali-silica reaction (ASR) susceptibility | Engineering / SOFT | reportedly low vs OPC (free alkalinity locked in binder) — **UNVERIFIED at multi-decade scale** | Provis 2014 |
| GP-L12 | Sulfate attack resistance | Engineering / SOFT | reportedly superior to OPC — UNVERIFIED at multi-decade | Bakharev 2005 |
| GP-L13 | Chloride permeability (Rapid Chloride Penetration) | Engineering / SOFT | typically "Very Low" rating per ASTM C1202 | Provis 2014 |
| GP-L14 | Long-term in-service durability (> 30 years) | Engineering / **UNVERIFIED** | No multi-decade structural data exists; oldest commercial slabs ~ 10–20 years (Wagners) | UNPROVEN at decadal scale |

**Note on the 1200 °C refractory ceiling (GP-L5).** Geopolymer is an
inorganic Si-O-Al-O network. Unlike OPC (which dehydrates above 105 °C
and decomposes above 600 °C losing C-S-H water), geopolymer retains
mechanical integrity through 800–1200 °C with appropriate filler. This
gives it a niche **fire-resistant + refractory tile** market (Sweden,
Australia tunnel-lining trials).

**Note on CO₂-intensity claim (GP-L8) — UNVERIFIED with honesty
caveat.** The claimed 40–80 % CO₂ reduction vs OPC is **system-boundary-
sensitive**:
- If the alkali activator (NaOH + Na₂SiO₃) is produced via the
  energy-intensive **chlor-alkali process** + **silicate dissolution**,
  the activator carries its own significant CO₂ burden.
- Fly ash is a waste byproduct — if coal-power phase-out continues,
  FA supply contracts. Some LCAs charge geopolymer for the "allocated"
  fraction of coal-burn CO₂ (system boundary disputed).
- Davidovits 1991 reports 80 % reduction; Habert 2011 reports
  10–40 % reduction (more conservative LCA). **Reality bracket: 10–80 %
  depending on system boundary.** UNVERIFIED in this repo; cited
  verbatim with bracket.

**Note on multi-decade durability (GP-L14) — UNVERIFIED.** Geopolymer
commercial structures (Wagners EFC airfield apron Brisbane West Wellcamp
Airport 2014, Toowoomba Second Range Crossing 2018) have not yet
accumulated > 30 years in-service data. ASR, sulfate, chloride
performance is favorable in **accelerated lab tests**; multi-decade
in-situ verification is OPEN.

---


Global geopolymer / alkali-activated-cement market is **< 1 %** of
global cement market (~ 4 Gt/yr OPC). Growth driver: CO₂ regulation
+ fly-ash valorization in countries with large coal-power fleet
(Australia, India, China, EU).

| Producer | Product | Reported deployment | Source |
|----------|---------|---------------------|--------|
| Wagners EFC (Australia) | Earth Friendly Concrete (fly-ash + slag geopolymer) | Brisbane West Wellcamp Airport (2014 — apron + pavement); Toowoomba Second Range Crossing | Wagners IR + public case studies |
| Zeobond (Australia) | E-Crete | Multiple precinct + pavement deployments | Zeobond public |
| Banah UK | banahCEM (metakaolin-based) | UK refractory + special-construction | Banah UK product datasheet |
| Cemex | Vertua (CO₂-reduced concrete; lower-CO₂ OPC + supplementary) | Commercial — partial geopolymerization | Cemex IR (note: Vertua is hybrid not pure geopolymer) |
| Holcim | ECOPact (CO₂-reduced; some alkali-activated variants) | Commercial — partial geopolymerization | Holcim IR |
| Geopolymer Institute (Davidovits, FR) | Research + licensing | Standards body | Geopolymer Institute publications |
| Wuhu Conch (China) | Alkali-activated GGBFS pilots | Pilot scale | Conch announcements |
| Lafarge (LafargeHolcim) | EcoPlanet / Susteno geopolymer-adjacent | Commercial low-CO₂ blends | Holcim IR |

> **Honesty caveat (LATTICE_POLICY §3.3):** geopolymer commercial scale
> is bounded by **fly-ash supply (coal-power-correlated, shrinking) +
> activator cost (sodium silicate $400–600/t) + structural-code
> acceptance (still proceeding; ASTM C1157 performance-spec, not
> prescriptive)** — not by lattice arithmetic. No projection onto n=6.

---

## §4 STRUCT — geopolymer material flow

```
[Coal fly ash, Class F]           [Calcined metakaolin]            [Ground granulated BF slag]
   (waste byproduct)               (700–800 °C calcine of kaolin)    (steelmaking byproduct)
        \                                  |                                   /
         \                                 |                                  /
          \________________________________|_________________________________/
                                           ↓
                                  [Aluminosilicate precursor solid]
                                           ↓
   [Alkali activator: NaOH (8–14 M) + Na₂SiO₃ "water glass" + water]
                                           ↓
                              [Geopolymer paste — mix, fluid for 30–120 min]
                                           ↓ optional + aggregate (sand + coarse stone)
                                  [Geopolymer concrete fresh mix]
                                           ↓ cast / pump / extrude / spray
                                  [Cast green article]
                                           ↓ cure (heat-accelerated: 60–80 °C × 24 h)
                                           ↓ OR ambient cure (slower)
                                  [Cured geopolymer concrete]
                                           ↓
            ┌──────────────────────┬───────────────┬─────────────────────┐
            ↓                      ↓               ↓                     ↓
   [Pavement / runway]    [Mass concrete]   [Refractory tile]      [Precast block]
   (Wagners EFC)          (CO₂-sensitive    (fire-resistant)       (commercial niche)
                          large pours)
```

---

## §5 FLOW — process aspects in scope

| Process step | Material-aspect concern (this repo) | Out-of-scope |
|--------------|-------------------------------------|--------------|
| Precursor selection (FA / MK / GGBFS) | reactive Si + Al availability; Class F vs Class C ash distinction | coal-plant operations / kaolin mining |
| Calcination (metakaolin only) | 700–800 °C × 4 h dehydroxylation | rotary-calciner engineering |
| Activator preparation | NaOH molarity + silicate modulus (SiO₂/Na₂O) | chlor-alkali process → hexa-energy |
| Mix design | Si/Al ratio (typically 2–4), water/binder, activator/precursor | aggregate sourcing → concrete/ |
| Cure schedule | heat cure vs ambient; t-T-strength curve | curing-room HVAC |
| Long-term durability | ASR, sulfate, chloride, freeze-thaw | structural-code acceptance → civil-engineering |
| CO₂ accounting | activator CO₂ + precursor CO₂ + transport CO₂ | LCA methodology → hexa-earth |

---

## §6 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | Davidovits patent (1979, France) | Foundational |
| Mk.II | Metakaolin lab geopolymer (Davidovits 1980s) | Research |
| Mk.III | Fly-ash geopolymer at structural scale (Hardjito-Rangan 2005, Curtin Australia) | Demonstrated |
| Mk.IV | Wagners EFC commercial deployment (BWWA airport 2014) | Commercial niche |
| Mk.V | Zeobond E-Crete + Banah UK refractory | Commercial niche |
| Mk.VI | One-part "just-add-water" geopolymer (dry-mix activator) | R&D — UNVERIFIED at large scale |
| Mk.VII | Red mud / mine-tailings geopolymer | R&D — UNVERIFIED at structural grade |
| Mk.VIII | Reinforcement bar (rebar) interaction long-term passivation | UNVERIFIED at decadal scale |
| Mk.IX | Multi-decade in-service durability | UNVERIFIED (no track record > 30 yr) |
| Mk.X | Sub-200 kg-CO₂/t geopolymer at displaceable price-per-MPa parity with OPC | UNPROVEN at production-cost parity |

---

## §7 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| OPC-based concrete | `concrete/concrete.md`, `concrete_tech/concrete-technology.md` |
| Aluminosilicate glass + glass-ceramic | `glass/hexa-glass.md`, `glass-ceramic/glass-ceramic.md` |
| Refractory ceramics (Si₃N₄, Al₂O₃, SiC) | `ceramics/ceramics.md` |
| Cement-industry CO₂ accounting | `hexa-earth` (sibling — climate) |
| Coal-fly-ash circular economy | `recycling/recycling.md` |
| Chlor-alkali process (NaOH for activator) | `hexa-energy` (sibling — process chemistry) |
| Steel-slag byproduct (GGBFS source) | `metallurgy/swordsmithing.md` (steelmaking byproduct) |
| Reinforcement bar (rebar) corrosion physics | `metallurgy/swordsmithing.md` + civil-engineering (out-of-repo) |

---

## §8 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| ASTM C1157 performance-spec for hydraulic cement | ASTM | structural-code acceptance |
| ASTM C39 compressive strength | ASTM | σ_c sanity |
| ASTM C1202 Rapid Chloride Permeability | ASTM | GP-L13 sanity |
| Davidovits 1991 SiO₂ + Al₂O₃ + NaOH chemistry | Geopolymer Institute | foundational |
| Hardjito-Rangan 2005 (Curtin) FA structural σ_c | peer-reviewed | GP-L1 sanity |
| Provis & van Deventer 2014 review | Springer | GP-L3/L13 sanity |
| Habert-D'Espinose 2011 LCA | *J. Cleaner Production* | CO₂ bracket |
| Wagners EFC datasheets | vendor | GP-L9 sanity |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-GP-1 | Multi-decade (> 30 yr) in-service geopolymer concrete with documented durability + corrosion data | OPEN |
| F-GP-2 | One-part dry-mix geopolymer at commercial volume + structural certification | OPEN |
| F-GP-3 | Geopolymer rebar-passivation across 50-year accelerated test matched to OPC | OPEN |
| F-GP-4 | CO₂ intensity at < 200 kg/t at price-per-MPa parity with OPC | OPEN |
| F-GP-5 | Building-code acceptance (ACI / EN 206) of geopolymer as principal binder | OPEN |
| F-GP-6 | Red mud / tailings geopolymer at structural grade (> 30 MPa, sustained) | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "Geopolymer Si/Al = 2 maps to n=6 lattice" — coincidence; do not write
- ✗ "FA geopolymer σ_c 40 MPa equals σ·τ × 0.83" — coincidence
- ✗ "Wagners EFC capacity follows n=6" — they have not heard of it
- ✗ "Geopolymer eliminates 80 % cement CO₂" — UNVERIFIED; reality bracket
  10–80 % depending on activator-side accounting
- ✗ "Geopolymer is durability-proven over OPC" — UNVERIFIED at decadal scale
- ✗ "Geopolymer is THE solution to cement CO₂" — there is no single
  solution; geopolymer is **one** path among CCS, low-carbon clinker
  (Solidia, Calera), and supplementary cementitious materials (SCMs)

---

## §9 Honest scope + caveats

1. **Material layer only.** Civil-engineering structural design, ACI
   code interpretation, multi-decade durability monitoring — **not
   here.** Structural deployment requires civil-engineering review and
   building-code compliance per jurisdiction.

2. **CO₂-reduction claim UNVERIFIED at full system boundary.**
   Davidovits' 80 % claim and Habert's 10–40 % claim differ by 5×.
   Per LATTICE_POLICY §1.2 honesty discipline, this spec preserves the
   bracket and does not pick a number.

3. **Multi-decade durability UNVERIFIED.** Oldest commercial geopolymer
   structures (Wagners 2014–2018) have ~ 10 years in-service. ASR,
   sulfate, chloride performance is favorable in **accelerated lab
   tests**; in-situ multi-decade verification remains OPEN per
   F-GP-1.

4. **Fly-ash supply is coal-correlated.** Continued coal-power phase-out
   shrinks Class F fly-ash supply globally. Geopolymer scaling is
   contingent on alternative precursor (metakaolin, slag, tailings)
   development — economics not yet matched.

5. **Activator chemistry has its own CO₂ + cost burden.** NaOH from
   chlor-alkali + Na₂SiO₃ from quartz dissolution at high T add to the
   net LCA. Honest geopolymer accounting must include both.

6. **No lattice anchoring of vendor numbers.** Wagners / Zeobond /
   Banah / Cemex / Holcim figures cited verbatim; no projection onto n=6.

7. **SPEC_FIRST verdict.** No numbers measured in this repo; all from
   ASTM / peer-reviewed literature / vendor datasheets. Working `.hexa`
   numerical sandbox for geopolymer is TBD.

8. **Coincidence disclosure (LATTICE_POLICY §1.1).** Any apparent fit
   of geopolymer numbers to n=6 (e.g., Si/Al ≈ 2 ≈ φ(6)) is coincidence
   with verification power zero.

---

## §10 References

- Davidovits J., "Geopolymers: Inorganic polymeric new materials,"
  *J. Therm. Anal.* 37, 1633 (1991) — foundational paper
- Davidovits J., *Geopolymer Chemistry and Applications*, 2nd ed.
  (Geopolymer Institute 2008)
- Hardjito D., Rangan B.V., "Development and properties of low-calcium
  fly ash-based geopolymer concrete," Curtin Univ. Tech. Rep. (2005)
- Duxson P., Provis J.L., Lukey G.C., van Deventer J.S.J., "The role
  of inorganic polymer technology in the development of 'green
  concrete'," *Cement Concrete Res.* 37, 1590 (2007)
- Provis J.L., van Deventer J.S.J. (eds.), *Alkali-Activated Materials:
  State-of-the-Art Report, RILEM TC 224-AAM* (Springer 2014)
- Provis J.L., Bernal S.A., "Geopolymers and related alkali-activated
  materials," *Annu. Rev. Mater. Res.* 44, 299 (2014)
- Habert G., D'Espinose de Lacaillerie J.B., Roussel N., "An
  environmental evaluation of geopolymer based concrete production: the
  cement industry's stance to sustainability," *J. Cleaner Production*
  19, 1229 (2011) — LCA reality-check
- Bakharev T., "Resistance of geopolymer materials to acid attack,"
  *Cement Concrete Res.* 35, 658 (2005)
- Kong D.L.Y., Sanjayan J.G., "Effect of elevated temperatures on
  geopolymer paste, mortar and concrete," *Cement Concrete Res.* 40,
  334 (2010)
- **ASTM C1157** — Performance Specification for Hydraulic Cement
- **ASTM C39** — Compressive Strength of Cylindrical Concrete Specimens
- **ASTM C1202** — Rapid Chloride Penetration
- IEA, *Cement Roadmap* (2023) — global cement CO₂ baseline
- Wagners — Earth Friendly Concrete (EFC) technical literature +
  Brisbane West Wellcamp Airport case study
- Zeobond — E-Crete product literature
- Banah UK — banahCEM product datasheet
- Cemex — Vertua product literature
- Holcim — ECOPact product literature
- `LATTICE_POLICY.md` §1.2 + §1.3 (this repo)
- `LIMIT_BREAKTHROUGH.md` (this repo) — Wave M materials audit
- Cross-link siblings: `concrete/concrete.md`,
  `concrete_tech/concrete-technology.md`, `glass-ceramic/glass-ceramic.md`,
  `recycling/recycling.md`, `hexa-earth` (climate / LCA)

---

*Authored 2026-05-13 by 박민우. Material-layer spec for hexa-matter's
Phase D follow-on `geopolymer` verb (31 of 33). Real-limits-first per
LATTICE_POLICY.md §1.2; no lattice fit on geopolymer parameters or
Wagners/Zeobond/Banah/Cemex/Holcim vendor capacities. CO₂-reduction
claim preserved as 10–80 % bracket (UNVERIFIED full-LCA); multi-decade
durability UNVERIFIED — oldest commercial deployments ~ 10 yr only.
Building-code structural design out of scope.*
