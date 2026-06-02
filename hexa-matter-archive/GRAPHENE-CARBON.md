# GRAPHENE-CARBON — extended chapter (sp²/sp³ carbon family)

> **Authored**: 2026-05-13 (Phase A elevation)
> **Author**: 박민우 <nerve011235@gmail.com>
> **Scope**: carbon allotropes — graphene, graphite, CNT (single-walled +
> multi-walled), diamond (natural + CVD + HPHT), fullerenes (C₆₀, C₇₀, C₈₄,
> carbon onions), lonsdaleite.
> **Cross-link**: this is the seed chapter for Phase D `2d-materials/` verb;
> material aspect of carbon is in scope here, while device-level
> graphene FETs / nanotube transistors live in `hexa-chip`.
>
> conductivity ceilings cite Frenkel 1926, calculated values from primary
> literature. Lab-frontier numbers (Tsinghua / IBS CNT yarn σ = 80 GPa)
> are clearly labeled as lab-best vs commercial. Vendor figures (Element
> Six diamond, Coherent CNT) not lattice-fitted.

---

## §1 The carbon allotrope family

Carbon's electron configuration (1s² 2s² 2p²) allows three hybridization states with distinct geometric + bonding signatures:

| Hybridization | Geometry | Bond character | Example |
|--------------|----------|-----------------|---------|
| sp (linear) | 180° | 2 σ + 2 π | carbyne (theoretical), C₂ chain |
| sp² (trigonal planar) | 120° | 3 σ + 1 π (delocalized) | graphene, graphite, CNT, fullerene |
| sp³ (tetrahedral) | 109.5° | 4 σ | diamond, lonsdaleite |

This gives 4 production-relevant 3D structures (graphite, diamond, lonsdaleite, fullerene families) + a 2D structure (graphene) + a 1D structure (CNT).

---

## §2 Graphene — the 2D atomic sheet

### §2.1 Structure

A single atomic layer of sp²-bonded carbon, arranged in a hexagonal honeycomb lattice. Each C atom: 3 σ-bonds at 120° + 1 π-bond perpendicular to the sheet (with 1 electron in the π band, delocalized across the sheet).

| Property | Value | Source |
|----------|-------|--------|
| C-C bond length | 1.42 Å | Castro Neto et al. 2009 |
| Lattice constant a | 2.46 Å | same |
| Thickness | 1 atom (~ 0.335 nm interplanar in graphite) | same |
| Tensile strength (in-plane) | 130 GPa | Lee et al. 2008 *Science* 321, 385 — AFM nanoindentation |
| Young's modulus E (in-plane) | 1 TPa | same |
| Electron mobility (room T, suspended) | 200,000 cm²/V·s | Bolotin et al. 2008 |
| Thermal conductivity (in-plane, single-layer) | 5000 W/m·K | Balandin et al. 2008 *Nano Lett.* 8, 902 — L9 SOFT_WALL ceiling |
| Thermal conductivity (out-of-plane) | ~ 10 W/m·K | strongly anisotropic |
| Bandgap | 0 (Dirac semimetal — touches at K-points) | Castro Neto 2009 |
| Specific surface area | 2630 m²/g (theoretical) | calculated |

### §2.2 Production routes

| Method | Output | Quality | Status |
|--------|--------|---------|--------|
| Mechanical exfoliation (Scotch tape) | µm-scale flakes | high (single-crystal) | research; Nobel 2010 Geim + Novoselov |
| CVD on Cu foil | cm²-scale film | mid (polycrystalline domains) | commercial (Graphenea, ACS Material) |
| CVD on SiC | cm²-scale film | high (epitaxial) | research; Toshiba / Penn State |
| Liquid-phase exfoliation | bulk powder (few-layer flakes) | low (defective, many-layer) | mass-market industrial |
| Graphene oxide (Hummers method) + reduction | bulk; tunable functional groups | mid | mass-market |
| Bottom-up synthesis (PAH dehydrogenation) | sub-µm flake | very high (atom-precise) | research only |

### §2.3 CVD growth on Cu (the workhorse)

```
   CH₄ (g) + H₂ (g)  →  Cu foil (1000-1050 °C, 1 atm)
                       ↓ (CH₄ decomposes on Cu surface; C dissolves minimally; precipitates as graphene)
   Cu foil with monolayer graphene grown across top surface
                       ↓ (PMMA support coating, etch Cu in FeCl₃ or ammonium persulfate)
   Free-floating graphene + PMMA  →  transfer to target substrate (SiO₂/Si, glass, polymer)
                       ↓ (PMMA removed in acetone or 350 °C anneal)
   Graphene on target — cm² scale, polycrystalline (~10 µm domains)
```

The CVD-on-Cu process is "self-limiting" because Cu has very low C solubility — only a single graphene layer forms before further growth stops. CVD-on-Ni gives bulk (multilayer) graphene because Ni has higher C solubility.

Defect density (CVD-on-Cu, 2024 state-of-art):
- Domain boundary density: ~ 10² /mm² (every 10 µm)
- Point defects: ~ 10¹⁰-10¹² /cm² (Raman D-band)
- Sheet resistance: 100-1000 Ω/sq (untreated); 50-100 Ω/sq (chemical doping)

### §2.4 Transfer process challenges

The transfer step is what limits commercial graphene electronics scale-up:
- PMMA residue (causes mobility degradation 10× vs as-grown)
- Wrinkles + folds during PMMA removal (causes domain mis-orientation)
- Adhesion to target substrate (Si/SiO₂ vs polymer vs metal)

State-of-art transfer: 2024 dry-transfer techniques (hexagonal-BN encapsulation) achieve room-T mobility ~ 50,000 cm²/V·s on transferred CVD graphene (Wang et al. 2024).

### §2.5 Real-limits anchors (from `LIMIT_BREAKTHROUGH.md` §9)

- L2 practical tensile strength SOFT_WALL → graphene (in-plane) 130 GPa is the lab-AFM-nanoindentation value
- L3 specific strength → graphene specific σ ≈ 130 GPa / 2.27 g/cm³ ≈ 57 GN·m/kg theoretical (vs UHMWPE 3.7 GN·m/kg — 15× ahead)
- L9 thermal conductivity → graphene single-layer 5000 W/m·K (highest measured for any solid)

---

## §3 CNT (Carbon nanotubes)

### §3.1 Geometry

A graphene sheet rolled into a tube. Two parameters define the structure:
- **Chirality (n, m)**: integer vector along the graphene lattice describing how the tube is rolled
- **Diameter**: d = (a/π) · √(n² + nm + m²), a = 2.46 Å

Three classes by chirality:
- (n, n) **armchair** — always metallic
- (n, 0) **zigzag** — metallic iff n divisible by 3
- (n, m), m ≠ 0 ≠ n, **chiral** — metallic iff (n-m) divisible by 3

For random-chirality SWCNT: ~ 1/3 are metallic, 2/3 are semiconductor. This 1/3-2/3 mix is the source of intense engineering effort to get **chirality-pure** SWCNT (DNA-assisted separation, gel chromatography).

### §3.2 SWCNT vs MWCNT

| Property | SWCNT (single-walled) | MWCNT (multi-walled) |
|----------|------------------------|----------------------|
| Number of walls | 1 | 2-50 (10-30 typical) |
| Diameter | 0.7-2.5 nm | 5-50 nm (outer), 0.34 nm wall spacing |
| Wall structure | single rolled graphene | nested shells |
| Bandgap | tunable 0 to ~ 1 eV | metallic (effectively) |
| Tensile strength (single CNT) | 100-150 GPa | 60-100 GPa |
| Production cost | $100-500/g | $1-10/g |
| Use | electronics, sensor, biomedical | composite filler, conductive additive |

### §3.3 CNT yarn assembly — the σ ceiling

A single CNT has σ = 100+ GPa, but a *yarn* assembled from many CNTs has lower σ due to:
- Inter-tube slippage (van der Waals only)
- Defects + impurities (residual catalyst metal)
- Misalignment + tube-end gaps

Yarn σ progression:
- 2000s: 1-3 GPa (early commercial)
- 2010s: 3-7 GPa (Tsinghua, Cambridge, Rice)
- 2020s: 5-15 GPa (commercial, e.g., Nanocomp, Huntsman)
- Lab-best 2024: **80 GPa** (1 mm yarn, Tsinghua + IBS) per `LIMIT_BREAKTHROUGH.md` §4.1 — L2/L3 frontier

Theoretical ceiling per individual CNT: 100-150 GPa. Lab is now at ~ 60% of theoretical for short yarn samples.

### §3.4 Production routes

| Method | Output | Chirality control | Status |
|--------|--------|--------------------|--------|
| Arc discharge | g-scale SWCNT | mixed | research |
| CVD (HiPco process, fluidized-bed) | kg-scale SWCNT | mixed | commercial (Carbon Solutions, OCSiAl) |
| Floating-catalyst CVD (FCCVD) | continuous fiber | mixed | commercial (Huntsman Miralon) |
| DNA-assisted separation | high-purity per chirality | pure (single chirality) | research/specialty (Sigma) |

OCSiAl (Luxembourg) is the world's largest commercial SWCNT producer (~ 100 tons/year nameplate by 2024).

---

## §4 Diamond — sp³ carbon

### §4.1 Structure + properties

Cubic diamond: face-centered-cubic lattice of C with 4 nearest neighbors at 109.5°, forming an interpenetrating FCC sublattice (the "diamond cubic" structure).

| Property | Value | Source |
|----------|-------|--------|
| Mohs hardness | 10 (HARD_WALL, L4) | Mohs 1812 |
| Vickers (single crystal {100}) | 70-100 GPa | NIST + Brookes 2004 |
| Density (g/cm³) | 3.515 | CRC 105th ed. |
| Thermal conductivity (natural Ia type) | 2200 W/m·K | NIST |
| Thermal conductivity (¹²C isotope-enriched) | 3300 W/m·K (Wei 1993) — L9 frontier |
| Bandgap | 5.45 eV (indirect) | Knight 2007 |
| Refractive index n (visible) | 2.42 | Drosg 2009 |
| Specific heat (room T) | 0.52 J/g·K | NIST |
| Critical breakdown field | 10⁷ V/cm | Saddow 2004 |

### §4.2 Production — natural, HPHT, CVD

| Source | Stones/yr | Carat/yr | Notes |
|--------|-----------|----------|-------|
| Natural mining (DeBeers, Rio Tinto, Alrosa) | ~10⁸ stones | ~120M carat | declining since 2010s |
| HPHT (High Pressure High Temperature) | growing | ~10M carat | Element Six, Sumitomo |
| CVD (Chemical Vapor Deposition) | growing | ~5M carat | Element Six, Diamond Foundry, IIa Technologies |

HPHT process:
- Pressure 5-6 GPa, T 1300-1600 °C
- Graphite + Fe/Ni/Co solvent-catalyst → diamond crystals (growth on seed)
- Yields cuboctahedral single crystals (5-30 carat)
- Originally GE 1955; now mass-production by Element Six, Sumitomo

CVD process:
- Methane (1-3 % in H₂) + microwave plasma (or hot-filament)
- ~ 800-1100 °C substrate
- Carbon deposits on seed crystal at ~ 1-100 µm/hr
- Grown on flat Ir/SrTiO₃ or single-crystal HPHT seed
- Yields polycrystalline (tool grade) or single-crystal (electronic grade)
- Element Six PCD tools, IIa Technologies single-crystal lab diamonds

### §4.3 Lab-grown vs natural disambiguation

GIA (Gemological Institute of America) developed the gemological **DiamondView** + **iD100** to distinguish lab-grown from natural diamonds:
- DiamondView: 225 nm UV fluorescence — natural diamond shows "growth zoning"; CVD shows uniform fluorescence
- iD100: 415 nm absorption line (N3 center) — present in natural Type Ia; absent in CVD type IIa

Cross-domain note: this disambiguation work lives in `gemology/gemology.md` + `GEMOLOGY.md`; the production chemistry lives here.

---

## §5 Lonsdaleite — hexagonal diamond (calculated, not synthesized)

### §5.1 Structure + theoretical claim

Lonsdaleite is hexagonal-stacked sp³ carbon (the wurtzite arrangement of C; vs cubic diamond's zinc-blende arrangement). First identified in 1967 in Canyon Diablo (Meteor Crater Arizona) meteorite remnants.

Theoretical hardness: Pan et al. 2009 *PRL* 102, 055503 — DFT calculation predicts **lonsdaleite Vickers ~ 150 GPa**, ~ 2× cubic diamond.

### §5.2 The synthesis problem

Lonsdaleite has **NOT** been synthesized in **usable bulk form** in 60+ years of attempts since the original 1967 meteorite discovery. Bulk samples from:
- Meteorite shock waves (impact crater finds)
- Detonation synthesis (lab nanodiamond shocks)
- DAC (diamond anvil cell) compression of graphite

...are all nanocrystalline + intermixed with cubic diamond + amorphous carbon. The theoretical 150 GPa Vickers value remains a **calculation**, not a measurement.

Per `LIMIT_BREAKTHROUGH.md §4`: lonsdaleite is **NOT** in the top-3 breakthrough opportunities; it sits in the over-hyped column with "HARD_WALL until bulk synthesis is demonstrated."

---

## §6 Fullerenes — C₆₀, C₇₀, C₈₄, onions

### §6.1 C₆₀ — the buckyball

Discovered 1985 by Kroto, Curl, Smalley (Nobel 1996). Structure: truncated icosahedron (12 pentagons + 20 hexagons), 60 carbon atoms.

| Property | Value | Source |
|----------|-------|--------|
| Symmetry | I_h (icosahedral) | crystallographic |
| Diameter | 0.71 nm (van der Waals) | Krätschmer et al. 1990 |
| C-C bonds | 30 single (in 6-5 edges) + 30 double (in 6-6 edges) | same |
| Ionization potential | 7.6 eV | gas-phase mass spec |
| Electron affinity | 2.7 eV | same |
| FCC crystal lattice constant | 14.17 Å | Heiney 1991 |
| FCC density | 1.72 g/cm³ | calculated |

C₆₀ crystallizes as molecular FCC at room T; this gives the **Mott-Kondo insulator/superconductor** family when alkali-doped (K₃C₆₀ T_c ~ 18-20 K; Rb₃C₆₀ T_c ~ 30 K).

### §6.2 Higher fullerenes

- C₇₀ — egg-shaped, D_5h symmetry; ~ 10% of fullerene soot mass; characteristic UV-vis 470 + 380 nm absorption
- C₇₆, C₇₈, C₈₂, C₈₄ — higher fullerenes; chromatographically separable; rare
- "Endohedral" fullerenes — metals trapped inside (e.g., Sc@C₈₂, Gd@C₈₂, Sc₃N@C₈₀); medical / MRI contrast research

### §6.3 Carbon onions

Multi-shell concentric fullerenes (C₆₀ inside C₂₄₀ inside C₅₄₀ inside ...). Produced by electron-irradiation of graphite or by carbon-arc soot. Used as lubricants + electrochemical capacitor electrodes.

### §6.4 Production

- Krätschmer-Huffman arc-discharge (1990) — graphite electrodes in He atmosphere → C₆₀ in soot (~10% mass yield)
- Combustion synthesis (Mitsubishi process, 2000s) — benzene-O₂ flame → C₆₀ + C₇₀
- Commercial C₆₀ price: $50-200/g (Sigma, MTR, BuckyUSA); C₇₀ $300-800/g; higher fullerenes $10⁴+/g

---

## §7 Graphite — the layered sp² bulk

### §7.1 Structure

Stacked graphene layers with AB (Bernal) or ABC (rhombohedral) stacking. Interlayer spacing 0.335 nm; in-plane C-C 1.42 Å.

Properties:
- σ in-plane (graphite block): 100-200 MPa (defect-limited)
- σ out-of-plane: 5-15 MPa (interlayer slip)
- Density: 2.26 g/cm³
- Thermal conductivity in-plane: ~ 1000-2000 W/m·K (HOPG, highly-oriented pyrolytic graphite)
- Thermal conductivity out-of-plane: 5-20 W/m·K
- Electrical resistivity in-plane: 10⁻⁵ Ω·cm
- Electrical resistivity out-of-plane: 10⁻¹ Ω·cm

### §7.2 Production grades

| Grade | Source | Density (g/cm³) | Use |
|-------|--------|------------------|-----|
| Natural graphite (flake) | mining (Madagascar, China, Brazil) | 2.20-2.25 | Li-ion anode, refractory |
| Synthetic graphite | petroleum coke → graphitization at 2800-3000 °C | 1.5-1.85 | Li-ion anode, EAF electrode |
| Pyrolytic graphite (PG) | CVD from hydrocarbon | 2.10-2.22 | thermal management, rocket |
| HOPG (highly-oriented PG) | PG + 3500 °C annealing under stress | 2.26 | research substrate, AFM cleaving |

---

## §8 The 6-fold symmetry note (per LATTICE_POLICY)

Graphene's honeycomb lattice has **6-fold rotational symmetry** (point group D_6h for an infinite sheet). This is a *geometric fact* — graphene is hexagonal.

Per `LATTICE_POLICY.md §1.3`: this 6-fold symmetry is **auxiliary**, not load-bearing. The n=6 invariant lattice arithmetic (σ(6)=12, τ(6)=4, J₂(6)=24) does NOT predict graphene's properties (band structure, σ_f, mobility, k_thermal). Those are set by C-C bond strength + π-electron delocalization + phonon dispersion — *physics*, not lattice arithmetic.

We mention the 6-fold symmetry here for completeness; we do **NOT** claim that n=6 invariants govern carbon allotropes.

---

## §9 Cross-links

| Cross-ref | Type | Why |
|-----------|------|-----|
| `gemology/gemology.md` | substrate | diamond + lab-grown disambiguation |
| `GEMOLOGY.md` | upstream chapter | 24 kB |
| `ceramics/ceramics.md` | substrate | carbon-ceramic composites (C-C, C-SiC) |
| `CERAMIC-ENGINEERING.md` | sister chapter | SiC + Si₃N₄ ceramic context |
| `silicon/silicon.md` | substrate | SiC bandgap context |
| `SILICON.md` | sister chapter | SiC wafer growth |
| `LIMIT_BREAKTHROUGH.md` | real-limits | L2 σ / L3 specific σ / L4 Mohs / L9 k_thermal |
| `2D-MATERIALS.md` | Phase D stub | h-BN, MoS₂, WSe₂ as graphene-cousins |
| `hexa-chip` | sister repo | graphene FET + CNT transistor device level |
| `hexa-energy` | sister repo | Li-ion anode (graphite + Si composite) |

---

## §10 References

- **Kroto H.W., Heath J.R., O'Brien S.C., Curl R.F., Smalley R.E.** (1985) *Nature* 318, 162 — C₆₀ discovery
- **Krätschmer W., Lamb L.D., Fostiropoulos K., Huffman D.R.** (1990) *Nature* 347, 354 — C₆₀ mass-production via arc
- **Geim A.K. & Novoselov K.S.** (2007) *Nat. Mater.* 6, 183 — graphene Nobel review
- **Lee C., Wei X., Kysar J.W., Hone J.** (2008) *Science* 321, 385 — graphene σ = 130 GPa, E = 1 TPa AFM measurement
- **Castro Neto A.H. et al.** (2009) *Rev. Mod. Phys.* 81, 109 — graphene electronic structure
- **Balandin A.A. et al.** (2008) *Nano Lett.* 8, 902 — graphene thermal conductivity 5000 W/m·K
- **Bolotin K.I. et al.** (2008) *Solid State Commun.* 146, 351 — suspended graphene mobility 200k
- **Iijima S.** (1991) *Nature* 354, 56 — MWCNT discovery
- **Iijima S. & Ichihashi T.** (1993) *Nature* 363, 603 — SWCNT discovery
- **Heiney P.A. et al.** (1991) *Phys. Rev. Lett.* 66, 2911 — C₆₀ FCC crystal lattice
- **Wei L. et al.** (1993) *PRL* 70, 3764 — ¹²C diamond thermal k 3300 W/m·K
- **Pan Z. et al.** (2009) *PRL* 102, 055503 — lonsdaleite Vickers calculation
- **Brookes E.J.** (2004) *Diamond Relat. Mater.* 13, 1135 — diamond hardness measurement
- **Saddow S.E. & Agarwal A.** (2004) — SiC + diamond electronic comparison
- **Frenkel J.** (1926) *Z. Phys.* 37, 572 — theoretical σ = E/10 (L1 anchor)
- **Mohs F.** (1812) — Mohs hardness scale (L4 anchor)
- **NIST** — diamond + graphite thermal conductivity reference
- **Element Six product brochures** — CVD + HPHT diamond grades
- **OCSiAl SWCNT product datasheet (TUBALL grade)**
- **Huntsman Miralon CNT yarn datasheet**
- **CRC Handbook**, 105th ed. (2024)

---


- Graphene σ = 130 GPa is the Lee et al. 2008 AFM-nanoindentation measurement on suspended monolayer over a 1 µm hole. Macroscopic graphene films do not reach this value (defect-limited).
- CNT yarn σ = 80 GPa is the Tsinghua/IBS 2024 lab-best on a 1 mm sample. Commercial CNT yarn is ~ 5-15 GPa.
- Lonsdaleite Vickers = 150 GPa is **calculated** (Pan et al. 2009 DFT), NOT measured in bulk form. Per L4 HARD_WALL discipline, the practical Mohs-10 / diamond ceiling stands until lonsdaleite is bulk-synthesized.
- Diamond thermal k 3300 W/m·K is the ¹²C-isotope-enriched value (Wei 1993), not natural diamond. Natural Type Ia diamond is 2200 W/m·K.
- C₆₀ FCC crystal density (1.72 g/cm³) and Rb₃C₆₀ T_c 30 K are 1990s-era well-established values; not lattice predictions.
- 6-fold graphene symmetry is a *geometric fact* (point group D_6h), explicitly NOT a load-bearing n=6-lattice claim (per LATTICE_POLICY §1.3).
- No n=6 lattice anchoring of any carbon property.

---

*Document authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase A elevation — graphene/CNT/diamond/fullerene/lonsdaleite chapter, seed for Phase D `2d-materials/` verb. Cross-links into `CERAMIC-ENGINEERING.md` (SiC), `SILICON.md` (SiC wafer), `gemology/gemology.md` (diamond gemological side).*
