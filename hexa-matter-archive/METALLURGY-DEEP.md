# METALLURGY-DEEP — extended chapter (GROUP_MET superalloy + heat treatment)

> **Authored**: 2026-05-13 (Phase A elevation)
> **Author**: 박민우 <nerve011235@gmail.com>
> **Scope**: superalloy (Ni-based, Co-based, Fe-Ni), single-crystal turbine
> blade casting, titanium grade-5 (Ti-6Al-4V), austenite-martensite-bainite
> TTT diagrams, refractory metals.
> **Companion**: `metallurgy/metallurgy.md` (spec doc) · `SWORDSMITHING.md` (~23 kB upstream-canon chapter, metallurgy anchor).
>
> from ASM Handbook vols. 1-4 + Special Metals datasheets (Inconel),
> ATI / RMI / Timet (titanium), and primary literature. Vendor figures
> are not lattice-fitted.

---

## §1 Superalloys — the high-T metallurgy class

A **superalloy** is a metal alloy designed for high-T strength, oxidation resistance, and creep resistance at temperatures > 0.7 × T_m (homologous temperature). The three families:

| Family | Matrix | Typical T_use (°C) | Strengthening | Use |
|--------|--------|--------------------|---------------|-----|
| Ni-based | γ-Ni (FCC) | 850-1150 | γ' precipitate (Ni₃Al, L1₂ ordered FCC) | turbine blade, vane, disc |
| Co-based | γ-Co (FCC) or ε-Co (HCP) | 900-1100 | carbide + solid solution | turbine vane, prosthetic |
| Fe-Ni-based (Iron-nickel) | γ-Fe-Ni (FCC) | 650-800 | γ' / γ'' (Ni₃Nb, D0_22 ordered BCT) | turbine disc, fastener, exhaust |

The poster-child is **Inconel 718** (Fe-Ni-based; despite the trade name "Inconel" suggesting Ni-based, IN 718 is Fe-Ni with γ'' precipitates of Ni₃Nb).

---

## §2 Inconel 718 — the volume superalloy

### §2.1 Composition (UNS N07718)

| Element | wt% |
|---------|-----|
| Ni | 50-55 |
| Cr | 17-21 |
| Fe | ~ 17 (balance) |
| Nb (Cb) + Ta | 4.75-5.50 |
| Mo | 2.8-3.3 |
| Ti | 0.65-1.15 |
| Al | 0.20-0.80 |
| C | ≤ 0.08 |
| B | ≤ 0.006 |

### §2.2 Heat-treatment schedule (AMS 5662)

The standard schedule:
1. **Solution treatment** at 925-1010 °C / 1 hr / WQ or AC (water quench / air cool) → dissolves γ' + γ''
2. **First age** at 720 °C / 8 hr / FC (furnace cool) to 620 °C
3. **Second age** at 620 °C / 8 hr / AC

This produces γ'' (BCT Ni₃(Nb,Al,Ti)) + minor γ' (FCC Ni₃Al) precipitates in the γ-FCC matrix. The γ'' precipitates are coherent disc-shaped, ~ 20-40 nm in diameter, with a strong order strengthening contribution.

### §2.3 Mechanical properties at temperature

| Property | Room T | 650 °C | 760 °C | Source |
|----------|--------|--------|--------|--------|
| 0.2% Yield strength (MPa) | 1100-1200 | 1000-1050 | 800-900 | ASM vol. 1 + Special Metals datasheet |
| Ultimate tensile (MPa) | 1300-1400 | 1100-1150 | 900-1000 | same |
| Elongation (%) | 12-15 | 15-18 | 25-30 | same |
| Stress-rupture at 1000 hr / 540 MPa (°C) | — | 650 °C reaches 1000 hr | — | ASM Special Metals stress-rupture chart |
| Creep at 540 MPa / 650 °C (10⁵ hr extrapolation) | — | ~1% strain | — | same |

### §2.4 The 650 °C ceiling

Above 650 °C, γ'' (BCT Ni₃Nb) coarsens and transforms to δ-phase (orthorhombic Ni₃Nb), losing the strengthening contribution. This sets the practical use-T ceiling for IN 718 at ~ 650 °C. For higher-T applications (turbine first-stage blades at 1000+ °C), **Ni-based γ'-strengthened alloys** (Inconel 738, René 80, CMSX-4 single-crystal) are used instead.

---

## §3 Single-crystal turbine blades — the apex superalloy

### §3.1 Why single-crystal

A polycrystalline turbine blade has **grain boundaries**. At high T and stress, grain boundaries are creep-vulnerable (Coble creep, grain-boundary sliding). Eliminating grain boundaries = eliminating these creep mechanisms = higher use-temperature.

The path:
- **Equiaxed casting** (1960s) — random orientation; grain-boundary creep at 950-1000 °C
- **Directionally solidified (DS)** (1970s) — columnar grains aligned with blade axis; transverse grain boundaries eliminated; use-T → 1050 °C
- **Single-crystal (SX)** (1980s+) — entire blade is one grain; all grain boundaries eliminated; use-T → 1100-1150 °C

### §3.2 SX casting process — Bridgman + seed selector

```
                           crystal seed (single-crystal Ni-Al-...
                                       oriented to <001>)
                                  ↓
                          [seed selector — a helical
                           channel that selects one grain
                           from the polycrystalline base]
                                  ↓
                          [withdrawal direction ←
                           furnace baffle, T gradient
                           ~ 30 K/cm]
                                  ↓
                        [blade-shape mold cavity, filled
                         with single-grain γ-Ni dendrites]

The "Bridgman" furnace pulls the mold down at ~ 1-5 mm/min through a
thermal gradient. Solidification proceeds upward; the seed crystal
constrains nucleation to a single orientation.
```

### §3.3 Modern SX alloys

| Alloy | Generation | Critical year | Use-T (°C) | Key element |
|-------|-----------|---------------|-------------|-------------|
| PWA 1480 | 1st-gen SX | ~1985 | 1050 | Ta-rich Ni-base |
| CMSX-4 | 2nd-gen SX | ~1992 | 1100 | 3% Re |
| CMSX-10 | 3rd-gen SX | ~1996 | 1130 | 6% Re |
| TMS-138 (Japan) | 4th-gen SX | ~2002 | 1150 | 5% Re + 2% Ru |
| TMS-238 (Japan) | 5th-gen SX | ~2010 | 1180 | 6% Re + 6% Ru |

The trend: rhenium content has crept up (Re is added for solid-solution strengthening of γ matrix; it slows γ' coarsening). Re is scarce (global production ~ 50 tons/year; cost ~$1500-3000/kg) — Re scarcity is a real economic constraint for next-gen SX blades. 5th-gen alloys add ruthenium (also scarce; ~$30k/kg) for additional substitution.

### §3.4 Manufacturing economics

A single CMSX-4 SX turbine blade for an aircraft engine (CFM56, GE90, Trent 1000):
- Mold + investment-casting setup: ~ $50k per blade design
- Casting (CMSX-4 alloy at $400/kg, ~ 1 kg per blade): ~ $400 raw material
- Bridgman pull (Howmet / PCC / Doncasters): ~ $5k per blade
- Machining + coating (TBC = thermal-barrier coating, YSZ on Pt-modified NiAlPt bondcoat): ~ $5k
- Total ~ **$10k per single-crystal blade**, ~ 1500-2000 blades per engine

Producers: **PCC Aerostructures, Howmet Aerospace, Doncasters Group** — small handful of certified casters.

### §3.5 (c) hand-off


---

## §4 Titanium grade-5 (Ti-6Al-4V) — the aerospace structural alloy

### §4.1 Composition (UNS R56400)

| Element | wt% |
|---------|-----|
| Ti | balance (~ 90) |
| Al | 5.5-6.75 |
| V | 3.5-4.5 |
| Fe | ≤ 0.3 |
| O | ≤ 0.2 |
| N | ≤ 0.05 |
| C | ≤ 0.08 |
| H | ≤ 0.0125 |

### §4.2 α-β microstructure

Ti has 2 crystal forms:
- α (HCP) — stable below 882 °C in pure Ti
- β (BCC) — stable above 882 °C in pure Ti

Ti-6Al-4V is an **α-β alloy**: Al stabilizes α; V stabilizes β. At room T, the alloy is ~ 90% α + 10% β. The α-β transition T (β-transus) is alloy-dependent: for Ti-6Al-4V it's ~ 995 °C.

The microstructure can be tailored:
- **Mill-annealed**: equiaxed α + intergranular β → moderate strength + ductility
- **Solution-treated + aged (STA)**: fine α' (martensitic HCP) + β → highest strength
- **β-annealed**: lamellar α/β colonies → best fatigue, lower strength

### §4.3 Mechanical properties

| Property | Mill-anneal | STA | Source |
|----------|-------------|-----|--------|
| 0.2% YS (MPa) | 830-920 | 1100-1200 | ASM vol. 2 + ATI datasheet |
| UTS (MPa) | 900-1000 | 1200-1350 | same |
| Elongation (%) | 14-18 | 8-12 | same |
| Modulus E (GPa) | 110-115 | 110-115 | same |
| Density (g/cm³) | 4.43 | 4.43 | NIST |
| β-transus (°C) | 995 ± 15 | — | ASM vol. 2 |

### §4.4 Why Ti-6Al-4V is everywhere

- Highest specific strength of common structural metals (σ_y / ρ ≈ 200 kN·m/kg)
- Excellent corrosion resistance (oxide film)
- Good biocompatibility → medical implants (hip, knee, dental)
- Aerospace structural: 50% of titanium consumption is aerospace
- 3D-printable (DMLS / EBM) — commercial production grade

Markets: aerospace (Boeing 787 wing-to-fuselage attach, F-22 / F-35 frame), medical (hip ball, dental implant), motorsport (suspension), marine (propulsion).

---

## §5 Steel TTT diagrams — austenite to martensite/bainite

### §5.1 The TTT (Time-Temperature-Transformation) diagram

For a fixed steel composition (e.g., AISI 1080 = 0.8% C plain-carbon eutectoid), the TTT diagram shows the phase decomposition of austenite (γ-Fe, FCC) over time at constant temperature:

```
   T (°C)
   800 ─────────────────────────────────  A1 = 727 °C eutectoid line
   |
   |              ← coarse pearlite
   700─┐   ●ⓘ
   |   │     ← fine pearlite
   600─┤   ●ⓘⓘ
   |   │
   500─┤   ←● upper bainite
   |   │ⓘⓘⓘ
   400─┤        ← lower bainite
   |   │
   300─┤
   |    Ms = 220 °C  martensite start (carbon-content sensitive)
   200 ─────────────────────────────────
   |
   100─┤
   0 ──┼───────────────────────────────────── log time
       1s  10s  100s  1000s  10000s

   "C-curve" nose at ~ 550 °C, ~ 0.5-1 s for 1080 steel
```

### §5.2 Phase descriptions

- **Austenite (γ-Fe)** — FCC, high-T phase, stable above 727 °C in eutectoid steel
- **Pearlite** — lamellar α-Fe (ferrite, BCC) + Fe₃C (cementite); forms at 600-727 °C; coarse at upper T, fine at lower
- **Bainite** — non-lamellar (acicular) α-Fe + Fe₃C; forms at 250-540 °C
- **Martensite (α')** — BCT (Body-Centered Tetragonal), carbon-supersaturated; forms below Ms by **diffusionless transformation**; very hard, very brittle

### §5.3 Quenching path — why it matters

To get martensite: cool **faster than the nose of the C-curve** → austenite skips the pearlite + bainite fields and transforms directly to martensite below Ms.

For 1080 steel, the critical cooling rate is ~ 1000 K/s — achievable by water-quench (oil for thicker sections, brine for thinnest).

A modern engineered steel (e.g., Maraging 18Ni-300 — VAR + maraging-aged):
- Quench from 820 °C → martensite (Ni-Fe martensite, not C-supersaturated)
- Age at 480-510 °C / 3-8 hr → precipitate Ni₃Mo + Ni₃Ti intermetallics
- Strength: 2000+ MPa with > 6% elongation

### §5.4 Hardenability — Jominy end-quench

The **Jominy end-quench** measures hardenability: a standard cylindrical specimen (100 mm long × 25 mm diameter) is heated to 845 °C, then water-quenched from one end. Hardness is measured along the length; the curve falls from the quenched-end peak (martensite) to the unquenched-end baseline (pearlite).

Different steel compositions produce different Jominy curves → quantifies hardenability. AISI 4340 (Ni-Cr-Mo) has very high hardenability — full martensitic through-section at > 50 mm cross-section.

---

## §6 Refractory metals — pushing T_m HARD wall

From `LIMIT_BREAKTHROUGH.md §L5`: HfC has T_m ~ 4201 K, TaC ~ 4258 K; Ta₄HfC₅ alloy reaches 4215 K (Cedillos-Barraza 2016).

| Refractory | T_m (K) | T_m (°C) | Use |
|------------|---------|----------|-----|
| W (tungsten) | 3695 | 3422 | filament, rocket nozzle, ITER divertor |
| Re (rhenium) | 3459 | 3186 | superalloy alloying, ion-thruster |
| Os | 3306 | 3033 | densest stable element (ρ = 22.59 g/cm³), L6 anchor |
| Ta | 3290 | 3017 | capacitor, chemical-process |
| Mo (molybdenum) | 2896 | 2623 | furnace heating element, alloy |
| Nb (niobium) | 2750 | 2477 | superconductor wire, superalloy |
| Hf | 2506 | 2233 | nuclear cladding, alloy |
| Zr | 2128 | 1855 | nuclear cladding |
| TaC | 4258 | 3985 | armor, refractory ceramic |
| HfC | 4201 | 3928 | hypersonic edge, rocket |
| Ta₄HfC₅ | 4215 | 3942 | hypersonic leading edge |

The **5000 K wall** (covalent-bond-energy theoretical ceiling, per L5 honest estimate) has not been crossed; ~ 4250 K is the engineered ceiling at present.

---

## §7 Cross-links

| Cross-ref | Type | Why |
|-----------|------|-----|
| `metallurgy/metallurgy.md` | spec doc | metal verb headline |
| `SWORDSMITHING.md` | upstream-canon chapter | 23 kB metallurgy anchor (steel + sword craft) |
| `silicon/silicon.md` | substrate | Si as alloy element (Al-Si, Fe-Si, Cu-Si) |
| `SILICON.md` | extended | Si-isotope separation, Si bandgap |
| `CERAMIC-ENGINEERING.md` | sister chapter | TBC (YSZ on NiCrAlY bondcoat) for turbine blade |
| `LIMIT_BREAKTHROUGH.md` | real-limits | L5 T_m / L6 ρ_max (Os) |
| `hexa-energy` | sister repo | gas turbine + power generation cross-link |
| `hexa-mobility` | sister repo | aerospace structural (Ti, Inconel) |

---

## §8 References

- **ASM Handbook vol. 1**: Properties and Selection: Irons, Steels, and High-Performance Alloys (ASM International 1990)
- **ASM Handbook vol. 2**: Properties and Selection: Nonferrous Alloys and Special-Purpose Materials (ASM 1990)
- **ASM Handbook vol. 4**: Heat Treating (ASM 1991)
- **Reed R.C.** (2006) *The Superalloys: Fundamentals and Applications*, Cambridge University Press
- **Donachie M.J. & Donachie S.J.** (2002) *Superalloys: A Technical Guide*, 2nd ed., ASM International
- **Sims C.T., Stoloff N.S., Hagel W.C.** (1987) *Superalloys II*, Wiley
- **Donachie M.J.** (1988) *Titanium: A Technical Guide*, ASM International
- **Boyer R., Welsch G., Collings E.W.** (1994) *Materials Properties Handbook: Titanium Alloys*, ASM
- **Krauss G.** (1990) *Steels: Heat Treatment and Processing Principles*, ASM
- **Bain E.C. & Davenport E.S.** (1930) *Trans. AIME* 90, 117 — the original isothermal transformation (TTT) diagram
- **Cedillos-Barraza O. et al.** (2016) *Sci. Rep.* 6, 37962 — TaHfC melting point ~ 4215 K (L5 HARD wall)
- **Special Metals Corporation datasheets**: Inconel 718 / IN-100 / IN-625 / Inconel X-750
- **ATI Specialty Alloys datasheets**: Ti-6Al-4V, Ti-6242, Ti-17, Ti-LCB
- **CRC Handbook**, 105th ed. (2024)
- **Ashby M.F.** (2017) *Materials Selection in Mechanical Design*, 5th ed.

---


- Inconel 718 / Ti-6Al-4V / single-crystal SX property data from ASM Handbook vols. 1-2 + manufacturer datasheets. **No values lattice-derived.**
- The Cedillos-Barraza 2016 melting point claim is **experimental measurement** (TaHfC quaternary at 4215 K via brightness pyrometry), the HARD wall L5 anchor.
- Cost figures for SX blades + Re / Ru market prices are 2024-2025 estimates; ranges given because spot prices vary 30-50% by region + order size.
- Manufacturing-economics figures (PCC / Howmet / Doncasters per-blade cost) are **rough industry estimates**, not vendor-disclosed. Real per-blade contracts are confidential.
- No n=6 lattice anchoring of any alloy parameter.

---

*Document authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase A elevation — metallurgy deep-dive chapter, complementing `metallurgy/metallurgy.md` + `SWORDSMITHING.md` with superalloy + Ti grade-5 + TTT-diagram + refractory metals content.*
