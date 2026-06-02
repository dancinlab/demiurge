<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — PLA, PHA, PBS, starch blends; biodegradation standards + cost vs petroleum -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; marine-biodegradable UNVERIFIED preserved -->
---
domain: biodegradable-plastics
requires: []
verb_group: polymer
status: SPEC_FIRST
verdict_basis: ASTM/EN standards + European Bioplastics market data + vendor datasheets; no lattice fit; marine-biodegradable UNVERIFIED preserved
---

# Biodegradable Plastics — n=6 소재 substrate, material verb (Phase D 27/29)

> **Material layer only.** PLA, PHA (PHB, PHBV), PBS, PCL, starch
> blends (Mater-Bi class), cellulose-derived (CA, regenerated
> cellulose). **Marine-biodegradability claims preserved as
> UNVERIFIED** until peer-reviewed evidence at end-use conditions.

> standards (ASTM D6400 industrial compost, ASTM D7081 marine,
> EN 13432 EU compost, ISO 14855) cited; mechanical and cost values
> from NatureWorks / Danimer / Mitsubishi Chemical / Novamont / Eastman
> public disclosures. No lattice fit.

---

## §1 WHY — why biodegradable-plastics belongs in hexa-matter

Biodegradable polymers decompose under defined conditions
(composting, marine, soil microbial) into CO₂ + H₂O + biomass within
months to a few years. Three orthogonal axes must be disambiguated:

| Property | Definition | Example |
|----------|-----------|---------|
| **Bio-based** | feedstock is renewable (plant / microbial) | bio-PE from sugarcane — bio-based but NOT biodegradable |
| **Biodegradable** | enzyme + microbial breakdown to CO₂ + H₂O + biomass under defined conditions | PLA, PHA, PBS, PCL |
| **Compostable** | subset; certified to ASTM D6400 (industrial compost only) | PLA + cert. |
| **Marine-biodegradable** | subset; ASTM D7081 | PHA partial — UNVERIFIED for routine real-marine |

These four properties are independent. Petroleum-feedstock PBAT is
biodegradable but not bio-based; bio-PE is bio-based but not
biodegradable.

---

## §2 Real-limits-first — biodegradable-plastics' actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| BD-L1 | PLA T_g | Physical / HARD | **55–65 °C** (depends on D/L ratio + crystallinity) | NatureWorks Ingeo datasheet, CRC 105th |
| BD-L2 | PLA T_m (PLLA, fully isotactic) | Physical / HARD | **170–180 °C** | NatureWorks |
| BD-L3 | PLA tensile σ_f (oriented film) | Engineering / SOFT | 50–70 MPa | NatureWorks Ingeo datasheet |
| BD-L4 | PLA tensile σ_f (cast bottle) | Engineering / SOFT | 20–50 MPa | NatureWorks |
| BD-L5 | PHA (PHB) T_m | Physical / HARD | **170–180 °C** | Danimer Scientific datasheet |
| BD-L6 | PHA (PHBV) tensile σ_f | Engineering / SOFT | **20–40 MPa** | Danimer Nodax datasheet |
| BD-L7 | PBS T_m | Physical / HARD | **115 °C** | Mitsubishi Chemical Bio PBS datasheet |
| BD-L8 | PBS tensile σ_f | Engineering / SOFT | 30–40 MPa | Mitsubishi |
| BD-L9 | PCL T_m | Physical / HARD | **60 °C** (slow degradation) | Perstorp CAPA datasheet |
| BD-L10 | Industrial composting time, PLA (ASTM D6400, EN 13432) | Engineering / SOFT | **< 180 days at 58 °C, 50–60 % RH** (industrial compost) | ASTM D6400 / EN 13432 / vendor |
| BD-L11 | PHA marine biodegradation (ASTM D7081) | Engineering / SOFT | **Danimer Nodax cert. 6 months** (some grades); **PHB ~ 12+ months** in real seawater | ASTM D7081 / Danimer + research |
| BD-L12 | PLA cost (NatureWorks Ingeo, mid-2024 spot) | Engineering / SOFT | **~ $2–3 / kg** | NatureWorks public + ICIS pricing |
| BD-L13 | PHA cost | Engineering / SOFT | **~ $4–8 / kg** | Danimer / industry estimates |
| BD-L14 | PBS cost | Engineering / SOFT | **~ $3–5 / kg** | Mitsubishi |
| BD-L15 | Petroleum PE / PP commodity cost (reference) | Engineering / SOFT | **~ $1.0–1.5 / kg** | ICIS / Platts |
| BD-L16 | Cellulose acetate cost (Eastman) | Engineering / SOFT | ~ $3–5 / kg | Eastman / Daicel |

**Note on cost gap (BD-L12 vs L15).** Biodegradable plastics carry a
**2–6× cost premium** vs commodity petroleum analogs. This is the
central barrier to displacement.

**Note on marine biodegradation (BD-L11).** True marine biodegradation
is **UNVERIFIED at routine real-seawater conditions for most grades**.
ASTM D7081 is a laboratory standard; field validation across
temperature / salinity / microbial-community variation remains R&D.
Danimer Nodax has some grades certified to D7081 (6 months); pure
PHB literature suggests 12+ months in real seawater. Other
biodegradable grades (PLA, PBS) do NOT routinely biodegrade in
ocean conditions. **Anti-claim: do NOT say "PLA biodegrades in the
ocean" — it does not, under normal conditions.**

---

## §3 Marine-biodegradable UNVERIFIED — anti-claim preserved

The popular claim that biodegradable plastics solve ocean plastic
pollution:

**Verdict per `LIMIT_BREAKTHROUGH.md §4` and this spec:**
**UNVERIFIED for most grades, including PLA.** Status as of 2026:

- PLA: does NOT degrade meaningfully in marine conditions (10–25 °C, low microbial activity vs compost) — PLA fragments persist as microplastic
- PHA (specifically PHB / PHBV / certain Nodax grades): some lab marine D7081 certification; real-ocean field validation limited
- PBS: limited marine degradation
- Starch blends: starch portion degrades; petroleum-cobinder portion may persist
- PCL: slow even in compost; marine degradation slow

**Anti-claim:** do NOT write "biodegradable plastic solves ocean
plastic pollution" — this is UNVERIFIED at real-marine scale.

---


| Producer | Material focus | Reported global production 2024 (kt/yr) | Source |
|----------|----------------|------------------------------------------|--------|
| NatureWorks (Cargill / PTT) | PLA (Ingeo) | ~ 150 kt/yr (Blair, Nebraska) + 75 kt expansion under construction | NatureWorks public |
| Total Corbion PLA | PLA (Luminy) | ~ 75 kt/yr (Rayong, Thailand) | Total Corbion public |
| Danimer Scientific | PHA (Nodax PHBH) | ~ 8 kt/yr (Winchester, KY); 20 kt expansion target | Danimer IR |
| RWDC Industries | PHA | pilot to ~ 5 kt | RWDC public |
| CJ CheilJedang | PHA | ~ 5 kt (Pasuruan, Indonesia) | CJ public |
| Mitsubishi Chemical / PTT MCC | Bio PBS | ~ 20 kt (Rayong) + additional capacity | PTT MCC public |
| Showa Denko | Bionolle PBS | ~ 3 kt | Showa Denko |
| Novamont | Mater-Bi starch blend | ~ 150 kt | Novamont public |
| Cardia Bioplastics | starch blend | smaller scale | Cardia public |
| Eastman Chemical | cellulose acetate | ~ 200 kt (Tennessee) | Eastman IR |
| Celanese | cellulose acetate | ~ 100 kt | Celanese IR |
| Daicel | cellulose acetate | ~ 60 kt | Daicel IR |
| Mango Materials | methane-to-PHA | pilot | Mango Materials |
| Perstorp | PCL (CAPA) | smaller scale | Perstorp |

**Global biodegradable bioplastic production** (European Bioplastics 2024):
~ 1.4 Mt/yr total biodegradable bioplastic (out of ~ 400 Mt/yr global plastic) — i.e., **~ 0.35 % of total plastic market.**

> **Honesty caveat (LATTICE_POLICY §3.3):** these vendors' capacity is
> bounded by lactic-acid fermentation throughput (PLA), microbial
> reactor count (PHA), succinic-acid + 1,4-BDO supply (PBS), and corn-
> starch feedstock cost (Mater-Bi). No projection to n=6 lattice.

---


| Standard | Conditions | Pass criterion |
|----------|-----------|----------------|
| **ASTM D6400** | industrial compost ~ 58 °C, 50–60 % RH | ≥ 90 % conversion to CO₂ in ≤ 180 days |
| **ASTM D7081** | marine seawater | ≥ 90 % conversion in 180 days (laboratory; field UNVERIFIED) |
| **ASTM D5511** | high-solids anaerobic digestion | ≥ 70 % conversion in 30 days |
| **EN 13432** | industrial compost (EU) | ≥ 90 % CO₂ conversion + ≤ 10 % > 2 mm fragments at 12 weeks |
| **ISO 14855** | controlled-compost lab test | CO₂ evolution measurement |
| **OK compost HOME (TÜV)** | home compost ~ 25 °C | full biodegradation at lower T |
| **DIN CERTCO label** | EU compliance scheme | varies |
| **California SB 343** | "compostable" labeling law | requires accepted local infrastructure |

---

## §6 STRUCT — biodegradable-plastics material flow

```
PLA branch (NatureWorks Ingeo):
   [Corn dextrose] → fermentation → [Lactic acid (L-LA + D-LA)]
        ↓ purification
   [Lactide dimer]
        ↓ ring-opening polymerization (Sn(II) octoate catalyst)
   [PLA polymer pellet]
        ↓ injection / film extrusion / fiber spin
   [Cup, bag, fiber, 3D-print filament]

PHA branch (Danimer Nodax):
   [Plant oil (canola / palm)]
        ↓ bacterial fermentation (Cupriavidus necator or recombinant E. coli)
   [Intracellular PHA granules]
        ↓ cell lysis + solvent extraction
   [PHA / PHBH polymer pellet]
        ↓ injection / film extrusion
   [Straw, film, packaging]

PBS branch (Mitsubishi Bio PBS):
   [Succinic acid (bio or petroleum) + 1,4-BDO]
        ↓ step-growth polycondensation
   [PBS polymer pellet]
        ↓
   [Film, foam, fiber]

Starch blend (Novamont Mater-Bi):
   [Corn starch + plasticizer + petroleum-cobinder]
        ↓ extrusion blending
   [Mater-Bi pellet]
        ↓
   [Shopping bag, food packaging]

Cellulose acetate (Eastman):
   [Cellulose pulp]
        ↓ acetic anhydride esterification
   [Cellulose acetate flake]
        ↓ spin or extrude
   [Cigarette filter, fiber, eyewear frame]
```

---

## §7 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | PLA + corn fermentation (Cargill / NatureWorks 2002) | Commercial workhorse |
| Mk.II | PHA / PHB (ICI Biopol 1980s; Danimer Nodax 2010s) | Commercial niche |
| Mk.III | Bio PBS (Mitsubishi 2012–) | Commercial |
| Mk.IV | Methane-to-PHA (Mango Materials) | Pilot |
| Mk.V | True marine-biodegradable PE-class polymer | UNVERIFIED — no peer-reviewed proof of routine ocean degradation at PE-class properties |
| Mk.VI | PLA tensile σ_f matching PET (~ 70 MPa film) | Commercial — oriented film |
| Mk.VII | Biodegradable PE / PP commodity-grade | UNVERIFIED — PE / PP backbone is not enzyme-cleavable |
| Mk.VIII | Cost parity with PE / PP at < $2/kg | UNVERIFIED — current 2–6× premium |

---

## §8 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| Polymer chemistry depth | POLYMER-CHEMISTRY.md §5 (depth content) |
| PET non-biodegradable comparison | `pet_film/pet-film.md` |
| Microplastics environmental fate | `microplastics/microplastics.md` |
| Wood + cellulose-derived (CA, regenerated cellulose) | `wood-cellulose/wood-cellulose.md` |
| Fermentation production (PHA, PLA, succinic acid) | `hexa-bio` |
| Bio-feedstock (corn, sugarcane) | `hexa-farm` |
| Marine biodegradation field testing | `hexa-earth` (climate) |
| Composting infrastructure | `hexa-earth` |
| Cellulose acetate | `wood-cellulose/wood-cellulose.md` cross-link |

---

## §9 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| PLA T_g 55–65 °C | NatureWorks Ingeo + CRC | BD-L1 sanity |
| PLA T_m 170–180 °C | NatureWorks | BD-L2 sanity |
| ASTM D6400 industrial compost | ASTM | BD-L10 sanity |
| ASTM D7081 marine | ASTM | BD-L11 + UNVERIFIED anchor |
| European Bioplastics 2024 market data | EBP public | global production sanity |
| ICIS / Platts commodity PE / PP | ICIS public | cost-gap sanity |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-BD-1 | True commercial marine biodegradation of PE-class polymer at field-validated rate | OPEN |
| F-BD-2 | Cost parity ($1/kg) for PLA or PHA with commodity PE | OPEN |
| F-BD-3 | Biodegradable polymer matching PET barrier + thermal | OPEN |
| F-BD-4 | PLA / PHA reaching > 5 % of global plastic by mass | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "Biodegradable plastic solves ocean plastic pollution" — UNVERIFIED
- ✗ "PLA biodegrades in seawater" — does not, under normal conditions
- ✗ "PLA T_g 60 °C equals σ·τ × 1.25" — coincidence
- ✗ "NatureWorks / Danimer capacity follows n=6" — they have not heard of it
- ✗ "Bio-based = biodegradable" — false (bio-PE is bio-based, not biodegradable)

---

## §10 Honest scope + caveats

1. **Material layer only.** Composting infrastructure, marine policy,
   plastic-pollution treaty — `hexa-earth`. Bacterial fermentation
   pipeline (recombinant strain, reactor design) — `hexa-bio`.

2. **Marine biodegradability UNVERIFIED for most grades.** Only
   certain PHA grades (Danimer Nodax, PHB) have lab D7081
   certification; field validation across real-ocean conditions
   remains R&D.

3. **Cost gap to petroleum commodity is 2–6×.** Central economic
   barrier; honest distinction preserved.

4. **Biodegradable bioplastic = 0.35 % of global plastic by mass.**
   Do not over-claim displacement.

5. **No lattice anchoring of vendor numbers.** NatureWorks / Total
   Corbion / Danimer / RWDC / CJ / Mitsubishi / Showa Denko / Novamont
   / Eastman / Celanese / Daicel / Perstorp capacities cited
   verbatim.

6. **SPEC_FIRST verdict.** All numbers from ASTM / EN / ISO standards,
   European Bioplastics 2024 market data, ICIS / Platts pricing, and
   vendor public disclosures.


---

## §11 References

- **ASTM D6400** — Compostable Plastics (industrial compost)
- **ASTM D7081** — Marine Biodegradation (laboratory)
- **ASTM D5511** — High-Solids Anaerobic Digestion
- **EN 13432** — Packaging Compostability (EU)
- **ISO 14855** — Controlled-Compost Lab Test
- **OK compost HOME** (TÜV Austria) — Home compost certification
- **California SB 343** — Compostable labeling law (2021)
- **European Bioplastics** — Annual Market Data 2024
- NatureWorks LLC — Ingeo Biopolymer technical data
- Total Corbion PLA — Luminy PLA datasheet
- Danimer Scientific — Nodax PHBH datasheet + IR
- Mitsubishi Chemical / PTT MCC — Bio PBS datasheet
- Novamont — Mater-Bi technical sheet
- Eastman Chemical — cellulose acetate datasheet
- Celanese, Daicel — cellulose acetate datasheets
- Perstorp — CAPA PCL datasheet
- ICIS / Platts — commodity PE / PP / PET pricing 2024
- CRC Handbook of Chemistry and Physics 105th ed.
- POLYMER-CHEMISTRY.md §5 (depth content)
- `LATTICE_POLICY.md` §1.2 + §1.3
- `LIMIT_BREAKTHROUGH.md` (Wave M)
- Cross-link: `microplastics/`, `wood-cellulose/`, `hexa-bio`, `hexa-farm`, `hexa-earth`

---

*Authored 2026-05-13 by 박민우. Material-layer spec for Phase D
`biodegradable-plastics` verb (27 of 29). Marine-biodegradable claim
UNVERIFIED preserved. No lattice fit on T_g / T_m / cost or vendor
capacity. Fermentation pipeline + marine policy out of scope.*

---

## Related NOVEL candidate

- `hxm-algae-plastic-001` — see [NOVEL.md §4.F.13](../NOVEL.md): algae-feedstock biodegradable plastic.

> SIM / proxy status is NOT a measurement and does NOT promote to `EXTERNAL-VERIFIED` without attributed external-lab evidence (NOVEL.md §7 · @F f2 / f5).
