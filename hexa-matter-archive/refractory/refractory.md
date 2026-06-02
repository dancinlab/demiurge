<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — high-temperature service refractories (firebrick / alumina / zirconia / MgO castables / ZrO2-SiO2-Al2O3 fused-cast / carbon / SiC). T_service ≥ 1000 °C focus. -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; no lattice anchoring of refractory parameters -->
---
domain: refractory
requires: []
verb_group: ceramic_inorganic
status: SPEC_FIRST
verdict_basis: vendor-published numbers (RHI Magnesita, Vesuvius, Imerys, Saint-Gobain, Morgan Advanced Materials, Krosaki, Shinagawa) + ASTM C71/C155/C242/C16 + ISO 5022/10081 + DIN 51060; no lattice fit
---

# Refractory — n=6 소재 substrate, material verb (Phase D'' 34/36)

> **Material layer only.** High-temperature service materials engineered
> to withstand T ≥ 1000 °C without losing dimensional / chemical /
> mechanical integrity. Covers shaped products (firebrick / fireclay /
> alumina brick / silica brick / mag-carbon brick), unshaped monolithic
> castables (MgO / Al₂O₃-SiO₂ / spinel / SiC bonded), fused-cast blocks
> (ZrO₂-SiO₂-Al₂O₃ AZS glass-tank blocks), carbon refractories
> (graphite-bonded MgO-C, Al₂O₃-C), and SiC refractories (silicon-
> nitride-bonded, recrystallized). **Distinct from `ceramics/`**
> (which spans general advanced ceramics — turbine blades, armor,
> dental). Refractory selection is dictated by **service-T + chemical
> attack + thermal-shock loop + creep budget** — not by single-property
> maximization.

> (PCE, service-T, creep, slag/glass corrosion, thermal-shock cycles)
> is set by **mineralogical phase + bond system + open porosity +
> chemical compatibility with the contained melt** — **not by the n=6
> lattice**. RHI Magnesita / Vesuvius / Imerys / Saint-Gobain / Morgan
> AM / Krosaki / Shinagawa vendor figures cited verbatim with no
> lattice projection.

---

## §1 WHY — why refractory belongs in hexa-matter

The general `ceramics/` verb covers ceramic engineering broadly —
turbine ceramics, armor, dental, electronic substrates. **Refractory
is a distinct discipline** organized around three orthogonal stress
axes that ceramic verbs do not jointly own:

1. **Temperature axis**: service-T ≥ 1000 °C (often 1500–1800 °C
   continuous; localized 2000+ °C peaks).
2. **Chemical-attack axis**: contact with molten slag (basic / acid /
   neutral), molten glass (corrosive Na₂O fluxes), molten metal (steel
   ladle), or aggressive gas (HF, Cl₂, SO₃).
3. **Thermal-shock-cycle axis**: typical refractory life is measured
   in tens-to-thousands of heat cycles, not in steady-state hours.

Refractories are the enabling material of steelmaking, glassmaking,
cement clinker production, non-ferrous smelting (Cu / Al / Zn / Ni),
incineration, petrochemical reformer / cracker, and fired-ceramic
manufacture itself. Without refractories, no high-T industry exists.

| Subclass | Composition | Service-T (typical) | Industrial signature |
|----------|-------------|---------------------|----------------------|
| Fireclay / firebrick | 25–45 % Al₂O₃ + SiO₂ + impurities | 1300–1500 °C | Industrial furnace lining; cheap, mid-grade |
| High-alumina | 50–99 % Al₂O₃ | 1600–1850 °C | Cement kiln, blast-furnace stove, induction-furnace |
| Silica brick | > 93 % SiO₂ (tridymite/cristobalite) | 1650 °C (close to T_m) | Coke oven, glass-tank crown |
| Mag-carbon (MgO-C) | 70–90 % MgO + 8–25 % graphite + resin/pitch bond | 1700+ °C with slag contact | BOF / EAF / steel ladle slag-line |
| MgO castable / spinel | MgO + MgAl₂O₄ spinel | 1700–1800 °C | Cement-kiln burning zone (replacing chrome-mag) |
| ZrO₂-SiO₂-Al₂O₃ AZS fused-cast | 32–41 % ZrO₂ + Al₂O₃ + SiO₂ glass | 1700 °C in molten glass contact | Glass-melting tank sidewalls + throat |
| SiC refractory | SiC + Si₃N₄ bond or recrystallized | 1600 °C oxidation-limited | Blast-furnace bosh, Al smelter, ferrosilicon |
| Carbon / graphite | C with pitch / resin / CVD bond | > 2000 °C (inert atmosphere) | Blast-furnace hearth, Al cell cathode |
| Insulating refractory (IFB) | Al₂O₃-SiO₂ low-density (0.4–1.2 g/cm³) | 1100–1700 °C | Back-up insulation behind hot-face |
| Refractory fiber (RCF / AES / poly-crystal) | Al₂O₃-SiO₂ fiber (Saffil/Fiberfrax/Superwool) | 1000–1600 °C | Furnace blanket; **AES = bio-soluble alternative** |

---

## §2 Real-limits-first — refractory's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| RF-L1 | Pyrometric Cone Equivalent (PCE) — ASTM C24 / Orton cone | Engineering / SOFT | Cone 30–42 typical for refractory grade (≈ 1670–2015 °C softening) | ASTM C24; Orton cone chart |
| RF-L2 | Silica brick service-T near T_m | Physical / HARD | **service ~ 1650 °C** vs SiO₂ T_m 1723 °C — operates within 70 K of melt | Schacht *Refractories Handbook* 2004 |
| RF-L3 | Pure MgO refractory grain T_m | Physical / HARD | **2825 °C** (3098 K) | NIST WebBook; CRC Handbook |
| RF-L4 | Pure Al₂O₃ (corundum) T_m | Physical / HARD | **2072 °C** (2345 K) | NIST WebBook; CRC Handbook |
| RF-L5 | Pure ZrO₂ T_m (cubic) | Physical / HARD | **2715 °C** (2988 K) | NIST WebBook |
| RF-L6 | SiC oxidation limit in air | Physical / HARD | **~ 1600 °C** (passive SiO₂ scale; above this active oxidation → mass loss) | Schneider *Engineering Ceramics* 2012 |
| RF-L7 | Graphite oxidation onset in air | Physical / HARD | **~ 400 °C** in air; 2000+ °C in inert/reducing atmosphere | CRC Handbook |
| RF-L8 | Magnesia-carbon brick (MgO-C) hot σ_compressive at 1500 °C | Engineering / SOFT | typically **20–40 MPa** (lab); spec varies by grade | RHI Magnesita technical brochure |
| RF-L9 | High-alumina brick cold-crushing strength (CCS, ASTM C133) | Engineering / SOFT | 50–120 MPa typical | ASTM C133 |
| RF-L10 | AZS fused-cast glass-tank block service life | Engineering / SOFT | **5–15 years** continuous in molten glass contact (vendor-warranted) | Saint-Gobain SEFPRO AZS datasheet |
| RF-L11 | Insulating firebrick (IFB) thermal conductivity k @ 1000 °C | Engineering / SOFT | **0.25–0.6 W/(m·K)** vs dense firebrick 1–2 W/(m·K) | Morgan Advanced Materials K-23/K-26 |
| RF-L12 | Refractory ceramic fiber (RCF Al₂O₃-SiO₂) service-T | Engineering / SOFT | 1000–1260 °C continuous (Class A); 1430 °C peak (Class C) | Unifrax Fiberfrax datasheet; ISO 10081-1 |
| RF-L13 | RCF carcinogenicity classification | Toxicology / HARD | **IARC Group 2B "possibly carcinogenic"**; EU REACH classification CMR; **bio-soluble AES (alkaline-earth silicate) "Superwool" preferred replacement** | IARC Monograph 81 (2002); EU CLP regulation |
| RF-L14 | Mag-carbon brick MgO-C slag corrosion: graphite content optimum | Engineering / SOFT | 12–18 wt-% C optimal (lower = slag attack; higher = oxidation loss) | RHI Magnesita BOF brick technical |
| RF-L15 | Cement-kiln burning zone basic refractory life (mag-spinel) | Engineering / SOFT | **6–18 months** between relines (kiln-specific) | RHI Magnesita ANKRAL technical brochure; FLSmidth kiln data |
| RF-L16 | Coreless induction furnace refractory campaign (silica or alumina dry-vibratable) | Engineering / SOFT | 80–200 heats typical (depends on metal alloy) | Saint-Gobain SEFPRO induction-furnace technical |
| RF-L17 | Refractory shaped-product apparent porosity (ASTM C20) | Engineering / SOFT | 12–22 % dense brick; 50–80 % insulating brick | ASTM C20 |
| RF-L18 | Refractory permanent linear change (PLC) on reheating | Engineering / SOFT | typically −1 % to +1.5 % at service-T (ASTM C113) | ASTM C113 |
| RF-L19 | RCF airborne fiber-count regulatory threshold | Toxicology / HARD | OSHA PEL 0.2 f/cc 8-hr TWA; OEL 0.1 f/cc (EU) | OSHA 29 CFR 1910.1000; EU OEL |
| RF-L20 | Spinel (MgAl₂O₄) thermal-shock R parameter | Engineering / SOFT | k·σ_f·(1−ν)/(E·α) ≈ favorable range for cement kilns (replaces Cr-mag chrome) | Bradt *Thermal Stresses in Materials* 1995 |

**Note on graphite oxidation (RF-L7).** Carbon refractories are extreme
high-T materials in **inert / reducing atmosphere** (blast-furnace
hearth at 1500+ °C, aluminum-cell cathode). They oxidize aggressively
in oxidizing atmosphere starting ~ 400 °C, so deployment is limited to
processes that maintain CO/H₂-reducing conditions or to slag-line
applications where graphite is rapidly consumed but provides
non-wetting protection (MgO-C bricks).

**Note on RCF carcinogenicity (RF-L13, RF-L19).** Refractory Ceramic
Fiber (Al₂O₃-SiO₂ amorphous fiber, used in furnace blanket / modular
insulation) is **IARC Group 2B** and EU REACH classified as a
Category 2 carcinogen. The industry has migrated heavily to **AES
(alkaline-earth silicate) bio-soluble fibers** (Morgan Superwool /
Unifrax Insulfrax) which dissolve in lung fluid within days. AES upper
service-T is 1200–1300 °C continuous; polycrystalline wool (Saffil
3M Nextel) reaches 1600 °C but at higher cost.

---


Global refractory production is large, low-margin, regional. Total
2023 global market ~ 28 Mt and ~ $30B USD revenue (industry reports —
Roskill / Industrial Minerals). China + India dominate volume; Western
vendors dominate high-grade segments (glass-tank AZS, steel slag-line
mag-C). Tonnage per industry: steel ≈ 70 % of refractory use; cement
~ 7 %; non-ferrous ~ 5 %; glass ~ 3 %; rest petchem/incinerator/etc.

| Producer | Material focus | Reported scale / focus | Source |
|----------|----------------|-------------------------|--------|
| RHI Magnesita | basic refractories (MgO / mag-carbon / spinel) + dolomite | ~ 3.4 Mt/yr; #1 globally; ~ €3.4B revenue (2023) | RHI Magnesita annual report 2023 |
| Vesuvius plc | flow-control + monolithics for steel ladle / tundish (slide-gate, isostatic-pressed) | ~ £1.9B revenue (2023); #1 in flow control | Vesuvius annual report 2023 |
| Imerys (FR) | fused minerals + monolithics + microsilica | Major specialty refractory supplier | Imerys public |
| Saint-Gobain SEFPRO (FR) | AZS fused-cast glass-tank blocks; induction-furnace dry-vib | Dominant glass-tank refractory supplier | Saint-Gobain SEFPRO datasheets |
| Morgan Advanced Materials (UK) | insulating firebrick (K-series); Superwool AES; high-T textile | Insulation-grade global leader | Morgan AM annual report |
| Krosaki Harima (JP) | basic refractories + sliding-gate (Nippon Steel supplier) | ~ ¥130B revenue (2023) | Krosaki Harima IR |
| Shinagawa Refractories (JP) | basic + monolithic + isostatic (JFE Steel supplier) | ~ ¥110B revenue (2023) | Shinagawa Refractories IR |
| TYK / Plibrico / others | castable + repair monolithics | Specialty repair market | vendor public |
| Unifrax (now Alkegen, US) | RCF + AES (Insulfrax / Fiberfrax) + Saffil polycrystalline | Major fiber refractory producer | Alkegen public |
| 3M | Nextel polycrystalline ceramic fiber (Al₂O₃-SiO₂-B₂O₃); CMC tow | High-grade aerospace + furnace | 3M Nextel datasheet |
| Calderys (FR / Imerys) | monolithic + dry-vibratable + gun mix | Independent monolithics specialist | Calderys public |
| Resco Products (US) | castable + brick (US-Asia regional) | US regional leader | Resco public |
| HarbisonWalker International (US) | brick + castable + precast shapes | US regional leader | HWI public |

> **Honesty caveat (LATTICE_POLICY §3.3):** refractory producer capacity
> is bounded by **fused-mineral electric-arc furnace throughput +
> isostatic-press tonnage + shaped-brick kiln campaign + raw-mineral
> sourcing (magnesite, bauxite, zirconia sand)** — not by lattice
> arithmetic. RHI Magnesita 3.4 Mt/yr is reported in production
> volume, not lattice-derived.

---

## §4 STRUCT — refractory material flow

```
[Raw minerals: magnesite (MgCO₃) / bauxite (Al₂O₃·xH₂O) / zircon sand (ZrSiO₄) /
 quartzite (SiO₂) / fireclay / graphite flake / SiC grain]
        ↓ calcination (1700+ °C for dead-burned magnesia DBM; 1500 °C for tabular alumina)
[Sintered grain or fused grain (electric-arc fused → AZS / fused MgO / fused alumina)]
        ↓ size reduction + grading (multiple size fractions, Andreasen packing)
[Graded refractory aggregate + matrix fines + binder (clay / resol / pitch / cement)]
        ↓
   ┌────┴───────────────────┬────────────────────────┬──────────────────────────┐
   ↓                        ↓                        ↓                          ↓
[Shaped: mech-pressed brick]  [Unshaped: castable]    [Fused-cast block]       [Fiber product]
   ↓ dry → fire 1500–1750 °C    ↓ dry / mold → install   ↓ electric-arc fused    ↓ blow / spin
   ↓                            ↓                        ↓ cast in graphite mold  ↓ needled blanket
[Standard / high-alumina /     [Cement-castable LCC /   [AZS block 36 / 41 %    [RCF / AES / poly-
 silica / mag-C brick]          ULCC / no-cement gel]    ZrO₂ for glass tank]   crystalline wool]
        ↓                            ↓                        ↓                       ↓
   ┌────┴────────────┬───────────────┴───────┬───────────────┴───────────┐    [Back-up insulation
   ↓                 ↓                       ↓                           ↓     module]
[Steelmaking BOF]  [Cement kiln]      [Glass tank]              [Non-ferrous smelter]
[EAF / ladle]      [calciner]          [AZS sidewall + throat]    [Cu/Al/Zn]
                                                                            ↓ end-of-campaign
                                                                       [Spent refractory
                                                                       → Cr/Ni recovery
                                                                       OR landfill]
                                                                       → recycling/
```

---

## §5 FLOW — process aspects in scope

| Process step | Material-aspect concern (this repo) | Out-of-scope |
|--------------|-------------------------------------|--------------|
| Mineral calcination / fusion | grain density, mineralogy, impurity assay (CaO/SiO₂ ratio in MgO) | mine operations, raw-mineral logistics |
| Grain grading | Andreasen size distribution, packing density | mixer engineering |
| Binder selection | clay (ceramic-bonded), resol resin (carbon-bonded), CAC (calcium-aluminate cement) | binder supply chain |
| Pressing / casting / ramming | green density, compaction profile | press tonnage spec |
| Drying + curing | dewatering profile, steam explosion risk in castable | dryer / curing-room engineering |
| Firing | sinter cycle, dimensional stability (PLC) | kiln car / tunnel-kiln operation |
| In-service performance | service-T limit, slag corrosion rate, thermal-shock cycles | reline strategy, kiln-process operation → hexa-earth (cement) / metallurgy / glass |
| End-of-life | spent-refractory chemistry, recyclable fraction | landfill / recycling logistics → recycling/ |

---

## §6 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | Fireclay brick (millennium-old technology) | Commodity |
| Mk.II | Silica brick coke oven (Otto-Hoffmann ~ 1880) | Commodity |
| Mk.III | High-alumina brick (early 20th c.) | Commodity |
| Mk.IV | Fused-cast AZS for glass tank (1930s, Corhart / SEFPRO) | Commercial (high-grade) |
| Mk.V | Mag-carbon brick for BOF / ladle (1970s+) | Commercial dominant |
| Mk.VI | Magnesia-spinel cement-kiln brick (1990s — replaces chrome-mag for Cr⁶⁺ avoidance) | Commercial dominant |
| Mk.VII | Castable cement-free (no-cement / gel-bonded) | Commercial niche (high-grade) |
| Mk.VIII | AES bio-soluble fiber Superwool (Morgan / Unifrax 1990s+) | Commercial — RCF replacement |
| Mk.IX | Polycrystalline ceramic fiber (Saffil / Nextel) for > 1600 °C | Commercial niche (aerospace + furnace) |
| Mk.X | Spent-refractory recycling at high yield (steel-plant circular) | R&D / niche — UNVERIFIED at full circular closure |
| Mk.XI | Refractory replacement of CMAS-resistant ceramic for turbine TBC | Cross-link with `superalloy/` |
| Mk.XII | Self-healing refractory (oxide phase reformation on damage) | UNPROVEN |

---

## §7 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| General advanced ceramics (Si₃N₄ turbine, ZTA armor, dental) | `ceramics/ceramics.md` |
| Glass tank melt (operation side) | `glass/hexa-glass.md` |
| Glass-ceramic (controlled crystallization) | `glass-ceramic/glass-ceramic.md` |
| Carbon refractory raw material (graphite + diamond) | `carbon/carbon.md` |
| SiC + Si₃N₄ ceramic engineering | `compound-semi/compound-semi.md` (SiC material); `ceramics/ceramics.md` |
| Aerogel-based ultra-high-T insulation (NASA Stardust class) | `aerogel-foam/aerogel-foam.md` |
| Cement-kiln process / clinker chemistry / CO₂ | `hexa-earth` (sibling — climate) |
| Steelmaking ladle metallurgy (process side) | `metallurgy/swordsmithing.md` + sibling `hexa-earth` |
| Fusion-reactor first-wall material | `superalloy/superalloy.md`; sibling `hexa-fusion` |
| Spent-refractory recycling | `recycling/recycling.md` |
| Coke-oven silica brick / by-product gas | (sibling — petchem + metallurgy) |

---

## §8 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| ASTM C71 — refractory terminology | ASTM | scope |
| ASTM C155 — insulating firebrick classification | ASTM | RF-L11 sanity |
| ASTM C242 — refractory ceramic tile terms | ASTM | scope |
| ASTM C16 — refractory and refractory raw-material chemical analysis | ASTM | composition spec |
| ASTM C24 — Orton cone PCE | ASTM | RF-L1 sanity |
| ASTM C20 — apparent porosity / bulk density | ASTM | RF-L17 sanity |
| ASTM C113 — reheat change / PLC | ASTM | RF-L18 sanity |
| ASTM C133 — cold crushing strength | ASTM | RF-L9 sanity |
| ISO 5022 / 10081 — RCF / AES classification | ISO | RF-L12 / RF-L13 sanity |
| DIN 51060 — refractory classification | DIN | service-T classification |
| IARC Monograph 81 (2002) | IARC | RF-L13 — RCF Group 2B |
| OSHA 29 CFR 1910.1000 | OSHA | RF-L19 — PEL 0.2 f/cc |
| Schacht *Refractories Handbook* (Marcel Dekker 2004) | textbook | systematic anchor |
| Brosnan & Robson *Industrial Refractories* (ACerS 2014) | textbook | systematic anchor |
| RHI Magnesita ANKRAL / KRONAL / DURITAL technical literature | vendor | RF-L8/L14/L15 |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-RF-1 | Industrial spent-refractory recycling at > 80 % material recovery + structural-grade re-use | OPEN |
| F-RF-2 | Self-healing refractory (oxide-phase reformation) with > 50 % strength recovery on cool-down + reheat cycle | OPEN |
| F-RF-3 | RCF/AES bio-soluble fiber matching > 1500 °C continuous Saffil-class performance at < 2× cost | OPEN |
| F-RF-4 | Single-piece cement-kiln basic brick lifetime > 24 months commercial campaign | OPEN |
| F-RF-5 | AZS glass-tank block lifetime > 20 years continuous in flat-glass furnace | OPEN |
| F-RF-6 | Chrome-free magnesia-spinel parity with chrome-mag in all kiln zones | LARGELY ACHIEVED 2010s (still UNVERIFIED for some zones) |
| F-RF-7 | Cr⁶⁺-leach-free spent chrome-mag recycling at industrial volume | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "MgO refractory T_m 2825 °C matches σ·τ × 235" — coincidence; do not write
- ✗ "RHI Magnesita 3.4 Mt/yr fits n=6 lattice" — they have not heard of it
- ✗ "Refractory ceramic fiber is non-carcinogenic" — IARC 2B classification stands; bio-soluble AES is the replacement, not a denial of RCF status
- ✗ "Self-healing refractory is production-ready" — UNPROVEN
- ✗ "Spent refractory is 100 % recyclable" — UNVERIFIED at structural-grade re-use; most current recycling is downcycle (road-base aggregate)
- ✗ "Refractory = ceramics" — refractory is a *service envelope*
  (high-T + chemical-attack + thermal-shock cycle), not a chemistry
  class; the `ceramics/` verb owns advanced ceramics broadly,
  `refractory/` owns the high-T-service material discipline

---

## §9 Honest scope + caveats

1. **Material layer only.** Furnace design, reline scheduling,
   kiln-process operation, BOF / EAF tap-to-tap timing — **not here.**
   Call sibling repos (metallurgy / hexa-earth cement / glass).

2. **Service-T limits are atmosphere-dependent.** Graphite + SiC are
   atmospheric-environment-bounded (RF-L6/L7). A "refractory rated to
   2000 °C" claim must specify atmosphere; in air SiC tops out
   at ~ 1600 °C from passive→active oxidation.

3. **Refractory ≠ ceramic.** Refractory is the *service envelope*,
   not the chemistry. Many refractories are ceramic in chemistry (MgO,
   Al₂O₃, ZrO₂); some are not (mag-C with 15 % graphite; carbon
   brick). Routing this verb to `ceramics/` would erase the
   discipline.

4. **RCF carcinogenicity is real (RF-L13).** Industry migration to
   AES bio-soluble fiber is ongoing; RCF is still in service in many
   high-T furnaces above AES capability (>1300 °C continuous).
   Regulatory pressure (EU REACH, OSHA PEL) drives substitution.

5. **Self-healing refractory remains UNPROVEN.** R&D-only at
   academic + early industrial scale; not production-ready as of
   2026.

6. **Spent-refractory recycling at structural-grade re-use is
   UNVERIFIED.** Current circular practice is mostly downcycle
   (road-base aggregate, slag conditioner). Mag-C → MgO recovery
   exists in steel-plant integrated circular programs but not at
   global scale.

7. **No lattice anchoring of vendor numbers.** RHI Magnesita /
   Vesuvius / Imerys / Saint-Gobain / Morgan / Krosaki / Shinagawa
   capacities cited verbatim; no projection onto n=6.

8. **SPEC_FIRST verdict.** No numbers in this file are MEASURED in
   this repo; all from ASTM / ISO / DIN / IARC / OSHA / textbook /
   vendor public disclosures. Working `.hexa` numerical sandbox for
   refractory is TBD.

9. **Coincidence disclosure (LATTICE_POLICY §1.1).** Any apparent fit
   of refractory numbers to n=6 (e.g., MgO T_m 2825 °C → log fits) is
   coincidence with verification power zero.

---

## §10 References

- **ASTM C71** — Standard Terminology Relating to Refractories
- **ASTM C155** — Insulating Firebrick Classification
- **ASTM C16** — Standard Test Method for Load Testing Refractory Shapes at High Temperature
- **ASTM C24** — Pyrometric Cone Equivalent of Refractory Material
- **ASTM C20** — Apparent Porosity, Water Absorption, Apparent Specific Gravity, and Bulk Density of Burned Refractory Brick
- **ASTM C113** — Reheat Change of Refractory Brick
- **ASTM C133** — Cold Crushing Strength and Modulus of Rupture of Refractories
- **ASTM C242** — Standard Terminology of Ceramic Whitewares and Related Products
- **ISO 5022** — Shaped insulating refractory products — Sampling and acceptance testing
- **ISO 10081-1** — Classification of dense shaped refractory products
- **DIN 51060** — Refractory and high-temperature material classification
- **IARC Monograph 81** (2002) — Man-made vitreous fibres — RCF Group 2B
- **OSHA 29 CFR 1910.1000** — air contaminants (RCF PEL 0.2 f/cc)
- **EU CLP regulation** — RCF classification (CMR Category 2)
- Schacht C.A. (ed.), *Refractories Handbook* (Marcel Dekker 2004) —
  canonical industry reference
- Brosnan D.A., Robson J.G., *Industrial Refractories: Materials,
  Properties, Designs* (American Ceramic Society 2014)
- Bradt R.C., Munz D., Sakai M., White K.W. (eds.), *Fracture Mechanics
  of Ceramics — Vol. 11: Thermal Shock* (Plenum 1995)
- Schneider G.A., *Engineering Ceramics: Current and Emerging Markets*
  (Wiley 2012) — SiC oxidation
- Lee W.E., Rainforth W.M., *Ceramic Microstructures: Property Control
  by Processing* (Chapman & Hall 1994)
- Routschka G., Wuthnow H. (eds.), *Pocket Manual Refractory Materials*,
  3rd ed. (Vulkan-Verlag 2008)
- RHI Magnesita — ANKRAL / KRONAL / DURITAL technical brochures;
  annual report 2023
- Vesuvius plc — sliding-gate + flow-control technical literature;
  annual report 2023
- Imerys — fused minerals + microsilica + monolithic technical
  literature
- Saint-Gobain SEFPRO — AZS fused-cast + induction-furnace
  dry-vibratable datasheets
- Morgan Advanced Materials — K-23 / K-26 / K-30 insulating firebrick;
  Superwool AES brochure
- Krosaki Harima — sliding-gate / tundish flow-control technical
  brochures; IR 2023
- Shinagawa Refractories — basic + monolithic technical brochures; IR 2023
- Unifrax / Alkegen — Insulfrax / Fiberfrax / Isofrax datasheets
- 3M — Nextel polycrystalline ceramic fiber datasheet
- Calderys — castable + dry-vibratable technical brochures
- `LATTICE_POLICY.md` §1.2 + §1.3 (this repo)
- `LIMIT_BREAKTHROUGH.md` (this repo) — Wave M materials audit
- Cross-link siblings: `ceramics/ceramics.md`, `glass/hexa-glass.md`,
  `glass-ceramic/glass-ceramic.md`, `carbon/carbon.md`,
  `compound-semi/compound-semi.md`, `aerogel-foam/aerogel-foam.md`,
  `recycling/recycling.md`, `metallurgy/swordsmithing.md`,
  `superalloy/superalloy.md`, `hexa-earth` (cement-kiln CO₂),
  `hexa-fusion` (first-wall material)

---

*Authored 2026-05-13 by 박민우. Material-layer spec for hexa-matter's
Phase D'' `refractory` verb (34 of 36). Real-limits-first per
LATTICE_POLICY.md §1.2; no lattice fit on refractory parameters or
RHI Magnesita / Vesuvius / Imerys / Saint-Gobain / Morgan / Krosaki /
Shinagawa vendor capacities. Self-healing refractory UNPROVEN; spent-
refractory structural-grade recycling UNVERIFIED; AZS glass-tank
20-year-life UNVERIFIED. Refractory is the high-T service envelope
discipline — distinct from general `ceramics/`. Furnace design,
kiln-process operation, BOF / EAF metallurgy out of scope — see
sibling repos.*
