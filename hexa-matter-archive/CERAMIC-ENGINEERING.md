# CERAMIC-ENGINEERING — extended chapter (GROUP_CER deep dive)

> **Authored**: 2026-05-13 (Phase A elevation)
> **Author**: 박민우 <nerve011235@gmail.com>
> **Scope**: engineering ceramics (Si₃N₄, SiC, ZTA, alumina-zirconia, Y-TZP),
> their microstructure, hardness mapping, and industrial uses.
> **Companion**: `ceramics/ceramics.md` (spec doc; ceramic verb headline) ·
> `CERAMICS.md` (37 kB upstream-canon-imported chapter).
>
> values are cited from ASM Handbook vol. 21, manufacturer datasheets
> (Coorstek, Kyocera, Saint-Gobain, Morgan, NGK Spark Plug), and primary
> literature. Vendor figures are not lattice-fitted.

---

## §1 Engineering ceramics — what makes them "engineering"

The term "engineering ceramic" (also called "advanced ceramic" or "technical ceramic") distinguishes from "traditional ceramic" (whiteware, refractories, brick). The differences:

| Axis | Traditional ceramic | Engineering ceramic |
|------|---------------------|----------------------|
| Composition | natural raw (clay, feldspar, silica) | synthesized high-purity oxide / nitride / carbide |
| Microstructure | porous, polyphase | dense (>99 %), single-phase or controlled multi-phase |
| Property control | application-tuned, broad tolerance | spec-tight (Vickers ± 10%, σ_f ± 15%) |
| End use | container, brick, tile, sanitary ware | tooling, prosthetic, ballistic, electronic |
| Examples | terracotta, stoneware, porcelain | Si₃N₄, SiC, ZrO₂, Al₂O₃ (>99.9% purity), ZTA, AlN, MgO, B₄C |

We focus here on **5 workhorse engineering ceramics**: Si₃N₄, SiC, ZTA, alumina (Al₂O₃ high-purity), and Y-TZP zirconia.

---

## §2 Silicon nitride (Si₃N₄) — the turbocharger blade

### §2.1 Structure + bonding

Si₃N₄ has 3 crystalline forms: α (trigonal), β (hexagonal), γ (cubic, high-pressure). Production-relevant form is α/β mixed (RBSN) or pure β (sintered, HIP-densified). All forms are based on SiN₄ tetrahedra sharing corners.

| Property | Value | Source |
|----------|-------|--------|
| Crystal structure | α: P31c (trigonal); β: P63/m (hexagonal) | ASM vol. 21 |
| Density (sintered) | 3.18-3.22 g/cm³ | Kyocera datasheet |
| Vickers hardness (1 kg) | 14-18 GPa | ASM vol. 21 |
| Knoop hardness | 13-17 GPa | NIST SRM 2100 calibration |
| Flexural strength (HIP, 4-pt bend) | **600-1200 MPa** | ASM vol. 21 (also `LIMIT_BREAKTHROUGH.md` Si-L12) |
| Fracture toughness K_IC | 5-8 MPa·m^(1/2) | ASM vol. 21 |
| Young's modulus E | 290-320 GPa | manufacturer datasheets |
| Thermal expansion α | 3.0-3.3 × 10⁻⁶ /K | manufacturer datasheets |
| Max use temperature | 1400-1500 °C (oxidation-limited) | Coorstek datasheet |

### §2.2 Why Si₃N₄ for turbocharger blades

Diesel turbocharger blades operate at exhaust temperatures up to 1000 °C with very rapid (~100 ms) acceleration ramps. Material requirements:
- High σ_f and K_IC at 1000 °C — Si₃N₄ keeps ~ 80% of room-T flexural up to 1200 °C
- Low density (3.2 vs 8.0 g/cm³ for Inconel 718) — 2.5× rotational inertia reduction
- Thermal-shock resistance — α × E modest; can survive 700 K thermal ramps without spalling
- Oxidation: passivating SiO₂ layer at < 1500 °C (Si₃N₄ + 3 O₂ → 3 SiO₂ + 2 N₂)

Commercial deployment: **NGK Spark Plug + Toyota** demonstrated Si₃N₄ turbocharger blades on Camry/Lexus models in the 1990s-2000s. Cost (~$50-100 per rotor) limits adoption vs Inconel 718 forging; but **rotational inertia matters more in racing / motorsport** applications where Si₃N₄ blades remain spec.

### §2.3 Manufacturing route

Powder → green body → sinter → HIP:
1. **Powder**: α-Si₃N₄ + sintering aids (Y₂O₃, Al₂O₃, MgO — typically 5-10 wt%)
2. **Green body**: dry-press or CIP (cold isostatic press) at 200-400 MPa → ~ 60% theoretical density
3. **Sinter**: 1750-1800 °C in N₂ atmosphere (prevents Si₃N₄ → Si + N₂ decomposition); α → β transformation during sintering creates elongated β grains (the "self-toughening" microstructure)
4. **HIP** (Hot Isostatic Press): 1700 °C × 200 MPa × 1-3 hours → 99.5-99.9% density; closes residual porosity

Reference: Greil 1991 *Mater. Sci. Eng. A* 145, 121; Kingery, Bowen & Uhlmann (1976) *Introduction to Ceramics*, 2nd ed.

---

## §3 Silicon carbide (SiC) — armor + power devices

### §3.1 Polytypes

SiC has > 200 known polytypes, but only 3 are production-relevant:
- **3C-SiC** (cubic, zinc-blende) — bandgap 2.36 eV; less common in commerce
- **4H-SiC** (hexagonal) — bandgap 3.26 eV; **dominant for power devices** (Wolfspeed, Coherent)
- **6H-SiC** (hexagonal) — bandgap 3.00 eV; older substrate technology

Industrial wafer production focuses on **4H-SiC** — see `silicon/silicon.md §1` cross-link.

### §3.2 Mechanical properties (sintered + reaction-bonded SiC)

| Property | Sintered (SSiC) | Reaction-bonded (RBSC) | Source |
|----------|-----------------|------------------------|--------|
| Density (g/cm³) | 3.1 | 2.95-3.05 | Saint-Gobain datasheet |
| Vickers hardness (GPa) | 25-32 | 22-26 | NIST SRM 2100 |
| Flexural strength (MPa) | 400-550 | 300-400 | ASM vol. 21 |
| K_IC (MPa·m^1/2) | 4.0-4.6 | 3.0-3.5 | Saint-Gobain |
| Young's E (GPa) | 410 | 380-400 | manufacturer |
| Thermal cond. k (W/m·K) | 80-120 | 50-70 | Coorstek |

### §3.3 SiC armor (lightweight ballistic protection)

SiC has the **highest specific hardness** (Vickers / ρ) of any production engineering ceramic. Hardness ~ 30 GPa, density ~ 3.1 g/cm³ → specific hardness ~ 9.7 GPa·cm³/g. Compare:
- Al₂O₃: V ~ 18 GPa / ρ 3.96 = 4.5 GPa·cm³/g
- B₄C: V ~ 30 GPa / ρ 2.5 = 12 GPa·cm³/g (highest, but processing-hard)
- Si₃N₄: V ~ 16 GPa / ρ 3.2 = 5.0 GPa·cm³/g

SiC tile armor (typically 5-10 mm thick) + UHMWPE / aramid backing is standard for body armor + light vehicle armor (e.g., Stryker side panels). The SiC fractures the incoming projectile (high hardness defeats the penetrator); the backing absorbs residual momentum.

### §3.4 SiC for power devices (cross-link to hexa-chip)

The **3.26 eV bandgap** of 4H-SiC (Si-L11 in `LIMIT_BREAKTHROUGH.md`) enables:
- High breakdown voltage (10× Si)
- High operating temperature (300 °C vs Si 175 °C)
- Low switching loss in MOSFETs
- Use cases: EV traction inverter (Tesla S3 Plaid; >100 EV models 2024-2025), solar inverter, fast charging

Device-level engineering (MOSFET cell pitch, gate-oxide reliability, body-diode dynamics) lives in `hexa-chip`. **The wafer + bulk crystal growth is in scope here**.

---

## §4 Zirconia (ZrO₂) family — Y-TZP, ZTA, MgO-PSZ

### §4.1 Why zirconia is special

ZrO₂ exhibits a **martensitic phase transformation** from tetragonal (t) to monoclinic (m) with a 4% volume expansion. Engineered correctly (with Y₂O₃, MgO, or CeO₂ stabilizer), this transformation can be **triggered by stress at the crack tip**, with the expansion **closing the crack** (transformation toughening).

Three production grades:

| Grade | Stabilizer | Phase content | Use |
|-------|-----------|---------------|-----|
| Y-TZP (3Y-TZP) | 3 mol% Y₂O₃ | 100% tetragonal | dental crown, hip ball, biomedical |
| ZTA (Zirconia-Toughened Alumina) | Y-TZP particles in Al₂O₃ matrix | mixed | cutting tool, structural |
| MgO-PSZ (Partially Stabilized Zirconia) | 8-12 mol% MgO | cubic matrix with tetragonal precipitates | extrusion die, slip-cast |

### §4.2 Y-TZP — the workhorse

| Property | 3Y-TZP value | Source |
|----------|--------------|--------|
| Density (g/cm³) | 6.05 | Tosoh datasheet |
| Vickers hardness (GPa) | 12.0-13.5 | NIST SRM 2100 |
| Flexural strength (MPa) | 900-1500 | Tosoh / Coorstek |
| K_IC (MPa·m^1/2) | 8-12 | manufacturer (high due to transformation toughening) |
| Young's E (GPa) | 200-220 | datasheet |
| Color (sintered) | white / ivory | (matters for dental; pigment doping for "tooth-color" Y-TZP) |

### §4.3 Aging issue — LTD (Low-Temperature Degradation)

Y-TZP undergoes spontaneous t→m transformation at 200-300 °C in water vapor over years (LTD; Kobayashi et al. 1981). This is a real problem for biomedical Y-TZP (hip ball implants): after 10-20 years in vivo, surface t→m can roughen the articulating surface → reduced clinical lifespan.

Solutions:
- Smaller grain size (< 0.5 µm) → slower LTD kinetics
- CeO₂ stabilizer instead of Y₂O₃ (Ce-TZP — slower LTD, lower hardness)
- ZTA — Al₂O₃ matrix dilutes the Y-TZP phase

### §4.4 ZTA (Zirconia-Toughened Alumina)

20-30 vol% Y-TZP particles dispersed in Al₂O₃ matrix gives:
- Hardness: 17-19 GPa (better than Y-TZP, lower than pure Al₂O₃ 18-22)
- K_IC: 6-8 MPa·m^1/2 (better than pure Al₂O₃ 3-4)
- σ_f: 800-1000 MPa
- Use: cutting tools (DIN ISO 513), femoral hip head (BIOLOX delta from CeramTec — actually a ZTA composite with chromia + strontium dopants)

---

## §5 High-purity alumina (Al₂O₃ > 99.5%)

The workhorse engineering ceramic. Vendor grades:

| Grade | Purity | Vickers (GPa) | σ_f (MPa) | Application |
|-------|--------|---------------|-----------|-------------|
| 92% | 92% (with SiO₂/MgO/CaO sintering aids) | 11 | 280 | substrate, refractory |
| 96% | 96% | 14 | 320 | sealing, structural |
| 99.5% | 99.5% | 17 | 350 | electronic substrate (LTCC) |
| 99.7% | 99.7% | 18 | 380 | high-grade structural |
| 99.9%+ (translucent) | 99.9%+ | 20 | 400+ | optical (Lucalox; HPS lamp tubes), high-vacuum window |

Production: BAYER process → Al₂O₃ powder → ball mill + spray dry → dry press / CIP → 1500-1700 °C sinter in air → 99% theoretical density.

**Source**: Coorstek + Kyocera + Saint-Gobain manufacturer datasheets.

---

## §6 Vickers / Knoop hardness map (Mohs ladder + L4 anchor)

### §6.1 The Mohs → Vickers transformation

Mohs scale (1812) is a 1-10 *qualitative* hardness ranking (talc=1, gypsum=2, ..., diamond=10). It is non-linear: Mohs 9 (corundum) to Mohs 10 (diamond) is a ~ 5× jump in Vickers; Mohs 1 (talc) to Mohs 2 (gypsum) is a ~ 2× jump.

Approximate Mohs → Vickers (GPa):

| Mohs | Mineral | Vickers (GPa) | Knoop (GPa) |
|------|---------|---------------|-------------|
| 1 | talc | 0.027 | — |
| 2 | gypsum | 0.36 | 0.32 |
| 3 | calcite | 1.0 | 1.35 |
| 4 | fluorite | 1.9 | 1.63 |
| 5 | apatite | 5.4 | 4.3 |
| 6 | orthoclase | 7.2 | 5.6 |
| 7 | quartz | 11.0 | 8.2 |
| 8 | topaz | 17.6 | 13.0 |
| 9 | corundum (Al₂O₃) | 22 | 18-22 |
| 10 | diamond | 70-100 | 70-85 |

The Mohs-10 anchor is the L4 HARD_WALL in `LIMIT_BREAKTHROUGH.md`. Calculated harder materials (lonsdaleite ~ 150 GPa Vickers per Pan et al. 2009; w-BN ~ 85 GPa) have NOT been synthesized in usable bulk form.

### §6.2 Engineering ceramic Vickers map

| Ceramic | Vickers (GPa) | Notes |
|---------|---------------|-------|
| Al₂O₃ 92% | 11 | refractory grade |
| Al₂O₃ 99.5% | 17 | substrate grade |
| Al₂O₃ 99.9% translucent | 20 | optical grade |
| Y-TZP | 12-13.5 | hip ball, dental |
| ZTA | 17-19 | cutting tool |
| Si₃N₄ (HIPed) | 14-18 | turbocharger blade |
| SiC (sintered) | 25-32 | armor, power device |
| B₄C | 30 | armor (Ka51 BAE Land), but processing-hard |
| WC (Co-bonded) | 17 (W-Co 6%) - 22 (W-Co 0.5%) | cutting tool, drilling |
| Diamond CVD | 70-100 | NIST SRM hardness reference; bulk-form L4 anchor |

---

## §7 SEM microstructure — what to look for

A polished + thermally-etched ceramic, imaged in SEM at ~ 5000-10000× magnification, shows:
- **Grain size distribution** (target: monomodal for engineering grade; bimodal indicates abnormal grain growth → toughness loss)
- **Porosity** (< 0.5 % closed, 0% open for HIP-densified grade)
- **Grain shape** (Si₃N₄: elongated β grains 1-3 µm wide × 10-15 µm long for the self-toughening microstructure; Y-TZP: equiaxed ~ 0.3-0.5 µm)
- **Intergranular phase** (Y₂O₃·Al₂O₃·SiO₂ glassy phase at Si₃N₄ grain boundaries; YIG / Y-Al garnet for the better grades)
- **Second-phase precipitates** (ZTA: Y-TZP particles embedded in Al₂O₃ matrix at 20-30 vol%)

The **grain size — toughness — strength** triangle:
- Fine grain (< 1 µm): high σ_f, lower K_IC (less crack-deflection per grain)
- Coarse grain (~ 5 µm): lower σ_f, higher K_IC (more crack-deflection)
- Optimal for engineering: 0.5-2 µm equiaxed (Y-TZP, ZTA) or elongated (Si₃N₄)

---

## §8 Vickers vs cost map (production-grade)

Per-kg cost is dominated by raw material + densification cycle:

| Ceramic | Vickers (GPa) | Cost (USD/kg, billet) | Cost-per-GPa-of-V |
|---------|---------------|-----------------------|---------------------|
| Al₂O₃ 92% | 11 | $5-15 | $0.5-1.4 |
| Al₂O₃ 99.5% | 17 | $20-40 | $1.2-2.4 |
| Y-TZP | 13 | $200-300 | $15-23 |
| ZTA | 18 | $80-150 | $4.4-8.3 |
| Si₃N₄ (HIP) | 16 | $150-300 | $9-19 |
| SiC (sintered) | 28 | $80-150 | $2.9-5.4 |
| B₄C (armor grade) | 30 | $400-800 | $13-27 |
| WC (Co-bonded) | 19 | $80-120 | $4-6 |
| Diamond (CVD bulk) | 80 | $10⁴-10⁵ | $125-1250 |

**Observation**: SiC has the best "hardness per dollar" — explains its dominance in armor + abrasive markets.

---

## §9 Cross-links

| Cross-ref | Type | Why |
|-----------|------|-----|
| `ceramics/ceramics.md` | spec doc | ceramic verb headline |
| `CERAMICS.md` | upstream-canon chapter | 37 kB historical content |
| `silicon/silicon.md` | substrate | Si → SiC, Si₃N₄ shared chemistry |
| `SILICON.md` | extended chapter | SiC wafer growth |
| `gemology/gemology.md` | substrate | corundum (Al₂O₃) shared chemistry |
| `LIMIT_BREAKTHROUGH.md` | real-limits | L4 Mohs / L7 T_g / L9 thermal k |
| `hexa-bio/HEXA-NANOBOT.md` | cross-domain | ceramic substrate for nanobot scaffolds |

---

## §10 References

- **ASM Handbook vol. 21**: Composites + Ceramic-matrix composites (ASM International 2001)
- **Kingery W.D., Bowen H.K., Uhlmann D.R.** (1976) *Introduction to Ceramics*, 2nd ed., Wiley
- **Greil P.** (1991) *Mater. Sci. Eng. A* 145, 121 — Si₃N₄ self-toughening β-grain microstructure
- **Kobayashi K., Kuwajima H., Masaki T.** (1981) *Solid State Ionics* 3-4, 489 — Y-TZP LTD (low-temperature degradation)
- **Saddow S.E. & Agarwal A.** (2004) *Advances in SiC Processing and Applications*, Artech House
- **Pan Z., Sun H., Zhang Y., Chen C.** (2009) *PRL* 102, 055503 — lonsdaleite Vickers calculation
- **Mohs F.** (1812) *Versuch einer Elementar-Methode...*
- **NIST SRM 2100** — Vickers hardness reference material
- **NIST SRM 1960** — silicon dioxide / quartz refractive-index reference
- **Coorstek datasheets** — engineering-ceramic property tables
- **Kyocera Advanced Ceramics catalog** — Si₃N₄ + Y-TZP grades
- **Saint-Gobain Performance Ceramics datasheets** — SiC armor grades
- **Tosoh Zirconia datasheets** — 3Y-TZP / 8Y-CSZ grades
- **CRC Handbook**, 105th ed. (2024)
- **Ashby M.F.** *Materials Selection in Mechanical Design*, 5th ed. (2017)

---


- All Vickers / Knoop / σ_f / K_IC values cite ASM Handbook vol. 21, NIST SRM 2100 / 1960, or manufacturer datasheets. No values are lattice-derived.
- Vendor cost figures in §8 are 2024-2025 market estimates; ranges given because spot prices vary 20-50% by region + order size. **No lattice fit on cost figures.**
- The Mohs → Vickers translation in §6.1 is empirical, calibrated by 19th-21st century measurements; the non-linearity is well-documented.
- Lonsdaleite / w-BN hardness claims are **calculated**, not measured in bulk form — labeled as such throughout.
- The L4 anchor (diamond Mohs 10) is a HARD_WALL per `LIMIT_BREAKTHROUGH.md`; calculated harder materials (lonsdaleite, w-BN) have NOT been synthesized in usable bulk form despite > 60 years of attempts.
- No n=6 lattice anchoring of any ceramic property.

---

*Document authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase A elevation — engineering-ceramic deep-dive chapter, complementing `ceramics/ceramics.md` + the upstream-canon `CERAMICS.md` chapter.*
