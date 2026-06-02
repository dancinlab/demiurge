<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_FIB architectural overview -->

# fiber-architecture — 1D fiber → 2D fabric → 3D structure

> Architectural overview of GROUP_FIB. Companion to `POLYMER-CHEMISTRY.md`
> (root, fiber-grade POL chemistry) and `GRAPHENE-CARBON.md` (carbon fiber).

## §1 The FIB assembly hierarchy

```
                              GROUP_FIB
                                 |
   +-----------------------------+----------------------------+
   |                             |                            |
 organic natural             organic synthetic           inorganic fiber
   |                             |                            |
   +-------+-------+             +-------+-------+        +-----+--------+
   |       |       |             |       |       |        |              |
 cotton  wool    silk         nylon-6   PET    aramid    carbon fiber   glass fiber
 cellulose protein  fibroin   nylon-66  fiber   PPTA     CFR / CFRP     E-glass
 (β-1,4-  (α-keratin)         polyamide polyester (Kevlar) PAN-precursor S-glass
  glucose) lignin-free                            Twaron                 fused silica
                              |                                          based
                              PP, PA fiber (rope, carpet)
                              UHMWPE (Dyneema, Spectra)
                              acrylic (PAN — Orlon)
                              spandex (PU — Lycra)

                              cellulose-derived
                              |
                  +-----------+----------+----------+
                  |           |          |          |
              rayon /     cellulose   nanocellulose  paper
              viscose     acetate     (CNF, CNC)    (kraft, sulfite,
              (regenerated (Eastman    (1-100 nm    mechanical,
               cellulose)  acetate     widths)      recycled)
                           film/fiber)
                                                    |
                                            +-------+-------+
                                            |               |
                                          wood-pulp     non-wood pulp
                                          (hardwood,    (bamboo, bagasse,
                                           softwood)     hemp, jute, kenaf)
                                          |
                                  +-------+-------+
                                  |               |
                              kraft pulp    mechanical pulp
                              (sulfate)     (TMP, CTMP)
                              high lignin   high yield
                              removal       low strength

                              engineered wood (Phase D wood-cellulose)
                              |
                +-------------+-------------+--------+--------+
                |             |             |        |        |
              CLT          glulam        LVL       PSL      OSB
              cross-laminated glue-lam laminated parallel  oriented
              timber       beam         veneer    strand   strand
              (50+ story    (Norway     lumber              board
               UNVERIFIED)  spruce)
```

## §2 Bond-character / mechanical envelope

| Fiber type | Backbone | Bonding | σ_tens (GPa) | E (GPa) | ρ (g/cm³) |
|-----------|----------|---------|--------------|---------|-----------|
| Cotton (cellulose I) | β-1,4-glucan | covalent + H-bond intra/inter | 0.3-0.8 | 6-10 | 1.55 |
| Wool (keratin α-helix) | protein | covalent + H-bond + disulfide | 0.1-0.2 | 2-4 | 1.31 |
| Silk (fibroin) | protein β-sheet | covalent + H-bond | 0.5-1.5 | 5-25 | 1.33 |
| Cellulose CNF | β-1,4-glucan | covalent + H-bond | 1-3 (single fiber) | 50-150 | 1.5 |
| Wood (softwood) | cellulose + lignin | mixed | 0.08-0.1 (clear wood σ_long) | 11-14 | 0.35-0.50 |
| Paper (kraft) | cellulose + residual lignin | H-bond network | 0.05-0.1 (sheet) | 1-10 | 0.8 |
| Aramid PPTA (Kevlar 49) | aromatic amide | covalent + amide H-bond | 3.6 | 124 | 1.44 |
| Nylon-6,6 fiber | aliphatic amide | covalent + amide H-bond | 0.6-0.8 | 3-5 | 1.14 |
| PET fiber | ester | covalent | 0.6-1.0 | 12-15 | 1.40 |
| UHMWPE (Dyneema SK99) | C-C | covalent | 3.9 | 130 | 0.97 |
| Acrylic (PAN — Orlon) | nitrile-pendant C-C | covalent | 0.2-0.4 | 3-7 | 1.18 |
| Carbon fiber (T700) | turbostratic sp² | covalent | 4.9 | 230 | 1.80 |
| Carbon fiber (IM7) | turbostratic sp² | covalent | 5.5 | 290 | 1.78 |
| Carbon fiber (T1100) | turbostratic sp² | covalent | 6.6 | 324 | 1.79 |
| CNT yarn (lab mm-scale) | sp² CNT | covalent | 80 (lab UNVERIFIED) | 100-300 | 1.3 |
| CNT yarn (commercial) | sp² CNT | covalent | 1-3 | 50-150 | 1.5 |
| Glass fiber (E-glass) | SiO₂ network | mixed ionic-covalent | 3.4 | 72 | 2.58 |
| Glass fiber (S-glass) | SiO₂ network | mixed | 4.6 | 86 | 2.50 |
| Ceramic fiber (Hi-Nicalon SiC) | SiC | covalent | 2.8 | 270 | 2.74 |

## §3 Real-limit map (from `LIMIT_BREAKTHROUGH.md`)

| # | Limit | Class | Value | Verb |
|---|-------|-------|-------|------|
| L1 | Frenkel σ_th = E/10 | HARD (theoretical) | ~150 GPa CNT theoretical (sp² C-C bond) | aramid, carbon, CNT |
| L2 | Practical tensile strength SOFT_WALL | SOFT | aramid ~3.6 GPa Kevlar 49; UHMWPE ~3.9 GPa Dyneema SK99; T1100 ~6.6 GPa; CNT yarn lab 80 GPa | aramid, carbon, fiber |

The Frenkel limit (L1) says σ_th ≈ E/10. For carbon (sp² in-plane C-C
bond, E ~1 TPa), σ_th ~100-150 GPa. Lab CNT yarn approaches this at
mm-scale but loses 10-100× at commercial yarn length (preserved verbatim
from `carbon/carbon.md`).

## §4 The 1D → 2D → 3D assembly axis

GROUP_FIB is defined by the *organization level*. The same chemistry can
be POL (chain) → FIB (1D fiber) → FAS (2D woven fabric, garment) or → CER
(0D/2D matrix composite) → MET (rebar / wire form-factor).

```
0D powder  →  1D fiber  →  2D fabric  →  3D structure
           |              |              |
      spinning/         weaving/      laminating/
      drawing           knitting      molding
      (POL/CER)         (FIB)         (composite)
```

This is why aramid lives across `hexa-polymer/` (chemistry) AND
`hexa-fiber/` (form-factor). The verb-spec lives in one place (`aramid/`)
but is referenced from both groups.

## §5 Cellulose family detail

Cellulose is the most abundant organic polymer on Earth (~1.5 × 10^12 t/yr
biosynthesis). It has multiple form-factors:

| Form | Composition | Length scale | Application |
|------|-------------|--------------|-------------|
| Cellulose I (native) | β-1,4-glucan, parallel chains | µm-mm | wood, cotton, plant cell wall |
| Cellulose II (regenerated) | antiparallel chains | µm-mm | rayon, viscose, lyocell |
| Cellulose III, IV (rare) | partially crystalline | varied | research |
| Cellulose nanofiber (CNF) | nano-scale fiber | 1-100 nm width, µm length | composite, hydrogel |
| Cellulose nanocrystal (CNC) | crystalline rod | 5-20 nm × 100-500 nm | reinforcement, optical |
| Cellulose acetate (CA) | acetate-substituted | µm | film, fiber, cigarette filter |
| Nitrocellulose | nitrate-substituted | µm | propellant, lacquer |
| Carboxymethyl cellulose (CMC) | -COO⁻ pendant | varied | food, paper sizing |
| Bacterial cellulose | high-crystallinity nano-fibril | µm | biomedical, audio diaphragm |

The `wood-cellulose/` (Phase D) verb covers engineered wood + nanocellulose
+ cellulose acetate; `paper/` covers pulping; `fabric/` covers cotton end-use.

## §6 Cross-group interfaces

### §6.1 FIB ↔ POL

aramid (PPTA), nylon-6,6 (textile), PET (textile/film), UHMWPE (Dyneema),
acrylic (PAN — Orlon), spandex (PU — Lycra) all sit at FIB form-factor of
POL chemistry. Cross-link: `hexa-polymer/`.

### §6.2 FIB ↔ CER

Glass fiber (SiO₂), carbon fiber (turbostratic sp² C), ceramic fiber
(SiC Hi-Nicalon, Al₂O₃ Nextel) sit at FIB form-factor of CER chemistry.
Cross-link: `hexa-ceramic/`, `hexa-silicon/`.

### §6.3 FIB ↔ FAS

Fabric → garment. Dyeing chemistry (reactive, vat, direct dye), mordant,
wet-process all live in `hexa-fashion/`. The boundary is between
*dry-mechanical* (FIB) and *wet-process / dye-uptake* (FAS).

### §6.4 FIB ↔ PRC

Pulping (kraft, sulfite, mechanical), spinning (melt, solution, wet-spin,
electrospin), papermaking (Fourdrinier, cylinder mold) all live in
`synthesis/` and the upstream `MATERIAL-SYNTHESIS.md`.

## §7 Wood-cellulose (Phase D) spotlight

The Phase D `wood-cellulose/` (280 lines, commit `99620b2`) covers:

1. **Engineered wood**: CLT, glulam, LVL, PSL, OSB — for low-carbon
   construction.
2. **Nanocellulose**: CNF (cellulose nano-fiber) and CNC (cellulose
   nano-crystal) as reinforcement, optical, hydrogel.
3. **Cellulose acetate (CA)**: film + fiber + cigarette filter.
4. **Transparent / densified wood**: lab-scale claims (Hu et al. 2016, Yano
   group); **UNVERIFIED at cost** at production.
5. **Mass-timber building 50+ story**: lab demos exist (Mjøsa Tower Norway
   18 floors; Ascent Milwaukee 25 floors); **50+ stories UNVERIFIED**.

Vendor: Stora Enso (Sweden), Binderholz (Austria), KLH Massivholz (Austria),
Structurlam (Canada).

## §8 Carbon fiber spotlight

PAN (polyacrylonitrile) precursor → oxidation 200-300 °C in air → carbonization
1000-1500 °C in N₂ → graphitization 2000-3000 °C optional → carbon fiber.

Grades (Toray nomenclature):
- T300: σ 3.5 GPa, E 230 GPa — workhorse industrial
- T700: σ 4.9 GPa, E 230 GPa — common automotive
- T800: σ 5.5 GPa, E 294 GPa
- T1000: σ 6.4 GPa, E 294 GPa
- T1100: σ 6.6 GPa, E 324 GPa — aerospace high-performance
- M40, M50, M60: ultra-high modulus (E up to 588 GPa, σ ~3.9 GPa)

CFR / CFRP composites: epoxy matrix (typical) + carbon fiber → Boeing 787,
Airbus A350, Toyota Lexus carbon-fiber body parts. Lives across FIB
(fiber) + POL (matrix epoxy) + composite cross-domain.

---

*Phase C fiber architecture overview, authored 2026-05-13.*
