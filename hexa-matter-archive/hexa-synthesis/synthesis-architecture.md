<!-- @authored: 2026-05-13 -->
<!-- @phase: C — synthesis architectural overview -->

# synthesis-architecture — route taxonomy

> Architectural overview of forward synthesis. Companion to
> `MATERIAL-SYNTHESIS.md` (largest deep-dive root .md in repo).

## §1 The synthesis route hierarchy

```
                            GROUP_PRC synthesis
                                    |
        +---------+----------+------+------+----------+----------+
        |         |          |             |          |          |
   solid-state   liquid    vapor        gas-phase  bio-cat    additive
   (high-T,      (sol-gel,  (CVD,        (CVD       (synbio    manufacturing
    sintering,   hydro-    PVD, MBE,    epitaxy)    enzyme,    (FDM, SLS,
    fusion)     thermal,   sputtering)               microbial)  SLA, DLP,
                solution-                                      MJF, BJ, DED)
                process)


  solid-state
        |
   +----+-----+----+
   |    |     |    |
 hot-press sintering Czochralski FZ float-zone
 SPS       pressureless mono-crystal pull   (Si, GaAs, Ge)
 PHIP      (ceramics)   (Si, GaAs)
 HIP       solid-state
           reactive
           sintering

  liquid
        |
   +----+----+------+--------+--------+
   |    |    |      |        |        |
 sol-gel hydro melt  precip.  emulsion electro-
 (TEOS-  thermal solid (Stöber  polymer- chemistry
  H₂O,   (synthetic ization ization)  ization (anodization,
  Hench  quartz,                                electroplating)
  &West  ruby,
  1990)  zeolite,
         MOF)

  vapor
        |
   +----+----+--------+
   |    |    |        |
 CVD   PVD  MBE     ALD (atomic
 (Si    (PVD: sputter, atom by atom)
 epi,   evap,  layer
 GaN,   ion-plating)
 SiC,   thin film)
 graphene)
 LPCVD,
 PECVD,
 MOCVD,
 ALD)

  additive (printing)
        |
   +----+------+-------+-------+-------+-------+--------+
   |    |      |       |       |       |       |
 FDM  SLS    SLA     DLP    MJF    BJ    DED    EBM
 (fused (selective (stereolitho (DLP   (multi (binder (direct  (electron
  dep.   laser     graphy)     light   jet    jet)    energy   beam
  modeling sintering polymer)   process) fusion)        deposition) melting)
  (polymer (polymer + metal)
   filament)


  polymerization (POL forward)
        |
   +----+------+-------+
   |    |      |       |
 chain-  step-   ring-opening    polyaddition
 growth  growth  (PLA from lactide,
 (free-  (PA, PET, PA from caprolactam)
 radical, PU, epoxy)
 anionic,
 cationic,
 coordination)
```

## §2 Route-to-material map (representative)

| Route | Material example | Verb | Reference |
|-------|------------------|------|-----------|
| Siemens TCS distillation | poly-Si feedstock | silicon | SILICON.md |
| FBR fluid-bed reactor | poly-Si granules | silicon | SILICON.md |
| Czochralski (CZ) | mono-Si ingot | silicon | SILICON.md (Si-L3 ~600 mm crucible) |
| Float-zone (FZ) | mono-Si ingot (low [O_i]) | silicon | SILICON.md (Si-L4 ~200 mm rod) |
| PVT (physical vapor transport) | 4H-SiC boule | silicon, compound-semi | SILICON.md (Si-L11 SiC 3.26 eV) |
| Ammonothermal | bulk GaN (UNVERIFIED 6/8") | compound-semi | COMPOUND-SEMI.md |
| HVPE / MOCVD | GaN epitaxial film | compound-semi | COMPOUND-SEMI.md |
| Sintering (pressureless) | Al₂O₃, ZrO₂, MgO | ceramics | CERAMIC-ENGINEERING.md |
| HIP (Hot Isostatic Press) | Si₃N₄ (600-1200 MPa flexural) | ceramics, silicon | Si-L12 |
| Spark Plasma Sintering (SPS) | dense ceramic, fast densification | ceramics | CERAMIC-ENGINEERING.md |
| Sol-gel (TEOS hydrolysis) | fused silica, silica aerogel | glass, silicon | Hench & West 1990 |
| Hydrothermal | synthetic quartz, ruby, MOF | gemology, mof | MOF.md |
| Solvothermal | MOF (HKUST-1, ZIF-8, MIL-101) | mof | MOF.md |
| Float-process | window glass | glass | (Pilkington 1959) |
| Blow-mold | container glass | glass | (industrial) |
| Casting (sand, investment, die) | Al/Mg/Fe parts | metallurgy | METALLURGY-DEEP.md |
| Forging | steel, Al, Ti structural | metallurgy | METALLURGY-DEEP.md |
| VIM (vacuum induction melting) | superalloy ingot | superalloy | SUPERALLOY.md |
| VAR (vacuum arc remelting) | superalloy fatigue-grade | superalloy | SUPERALLOY.md |
| DS (directional solidification) | columnar grain alignment | superalloy | SUPERALLOY.md |
| SX (single-crystal pull) | CMSX-10 turbine blade | superalloy | SUPERALLOY.md |
| Free-radical polymerization | PE, PP, PS, PVC | polymer (microplastics, etc.) | POLYMER-CHEMISTRY.md |
| Coordination polymerization | HDPE, isotactic PP, EPDM (Ziegler-Natta) | polymer | POLYMER-CHEMISTRY.md |
| Step-growth polymerization | PA-6,6 (HMDA+adipic), PET (EG+TPA) | nylon, pet_film | POLYMER-CHEMISTRY.md |
| Anionic polymerization (living) | specialty PS, block copolymer | (specialty POL) | POLYMER-CHEMISTRY.md |
| Cationic polymerization | butyl rubber (IIR) | elastomer | ELASTOMER.md |
| Ring-opening polymerization (ROP) | PLA from lactide, PA-6 from caprolactam | biodegradable-plastics, nylon | BIODEGRADABLE-PLASTICS.md |
| FDM 3D printing | thermoplastic part (PLA, ABS, PETG) | printing | (ASTM F42) |
| SLS 3D printing | polyamide, polymer powder | printing | (ASTM F42) |
| SLA 3D printing | photopolymer (epoxy, acrylate, urethane) | printing | (ASTM F42) |
| DLP 3D printing | photopolymer (dental, jewelry, prototyping) | printing | (ASTM F42) |
| MJF (Multi Jet Fusion, HP) | polyamide (PA12 powder + fusing/detailing agents) | printing | (vendor: HP) |
| Binder Jet 3D printing | metal/ceramic powder + binder + sinter | printing, metallurgy, ceramics | (ASTM F42, ExOne, Desktop Metal) |
| DED (Directed Energy Dep) | metal feedstock + laser/arc, large part | printing, metallurgy | (ASTM F42) |
| EBM (Electron Beam Melting) | Ti-6Al-4V aerospace | printing, metallurgy | (ASTM F42, Arcam/GE) |
| Mechanical exfoliation | graphene (Geim & Novoselov 2004) | 2d-materials, carbon | 2D-MATERIALS.md |
| CVD graphene / hBN | wafer-scale 2D materials | 2d-materials | 2D-MATERIALS.md |

## §3 Real-limit map (from `LIMIT_BREAKTHROUGH.md`)

| # | Limit | Class | Value | Verb |
|---|-------|-------|-------|------|
| L11 | Kepler packing | HARD | 0.7405 (Hales 2017) | printing (powder-bed density); metallurgy (casting yield); ceramics (powder compact) |
| L12 | Entropy of mixing | HARD | -R·ln(2) at x=0.5 binary mix | (forward synthesis bypasses ΔS_mix; reverse recycle is bounded — see hexa-recycle/) |

L11 sets the HARD wall on powder-bed density. Multimodal size distributions
can approach 0.85-0.90 overall packing fraction but each monodisperse
component class is still bounded by 0.7405.

## §4 Cross-substrate (PRC-synthesis ↔ bio)

Bacterial / enzymatic synthesis crosses into `hexa-bio/`:
- PETase enzymatic PET breakdown (Carbios) — REVERSE (recycle), not forward
- Bio-isoprene fermentation (Goodyear / Genencor) — UNVERIFIED at production
- Bacterial indigo fermentation (Pivot Bio, Genencor)
- Bacterial cellulose (Komagataeibacter) — lab + niche commercial
- Bacterial PHA / PHB / PHBV (Danimer, Newlight) — production scale
- Spider silk recombinant (Bolt Threads, Spiber) — niche

These are PRC-synthesis BIO routes; substrate-crossover.

## §5 Cross-group interfaces

### §5.1 PRC-synthesis ↔ CER

Sintering, CVD, sol-gel, hydrothermal, PVT → forward routes for ceramics,
glass, silicon, compound-semi, perovskite, 2d-materials, MOF, carbon.

### §5.2 PRC-synthesis ↔ POL

Step-growth + chain-growth + ROP + anionic + cationic + radical
polymerization → forward routes for all POL verbs.

### §5.3 PRC-synthesis ↔ MET

Casting, forging, rolling, drawing, PM, AM → forward routes for metallurgy,
superalloy, magnetic-materials.

### §5.4 PRC-synthesis ↔ GEM

Hydrothermal, Verneuil (flame fusion), Czochralski, HPHT, CVD →
forward routes for synthetic gems (ruby, sapphire, emerald, diamond).

### §5.5 PRC-synthesis ↔ FIB

Spinning (melt, solution, wet, electrospin), pulping (kraft, sulfite,
mechanical), papermaking → forward routes for fiber, paper.

### §5.6 PRC-synthesis ↔ FAS

Wet-process dyeing IS itself a synthesis route — applies dye to substrate.
Lives at FAS but uses synthesis terminology.

### §5.7 PRC-synthesis ↔ PRC-recycle

The forward-vs-reverse asymmetry — synthesis BUILDS (entropy increase
allowed); recycle UN-BUILDS (entropy decrease against Gibbs floor L12).
Cross-link to `hexa-recycle/`.

## §6 Printing spotlight

Printing (additive manufacturing) does not have a dedicated CLI dispatcher
slot in `hexa.toml [verbs]` per `AXIS.md §0`. It is exposed via
`MATERIAL-SYNTHESIS.md` deep-dive.

| Process | Material | Resolution | Build rate | Application |
|---------|----------|------------|------------|-------------|
| FDM | thermoplastic filament | 100-300 µm | low | prototyping, hobby |
| SLS | polymer powder | 60-100 µm | medium | functional parts |
| SLA | photopolymer resin | 25-100 µm | medium | high-detail, dental |
| DLP | photopolymer resin | 25-75 µm | high | dental, jewelry |
| MJF (HP) | PA12 powder + agents | 80 µm | high | functional, low-volume |
| BJ (binder jet) | metal/ceramic powder + binder | 50-100 µm | high (large parts) | metal AM, ceramic AM |
| SLM / DMLS | metal powder + laser | 30-50 µm | medium | aerospace, medical |
| EBM | metal powder + e-beam | 50-100 µm | medium | Ti-6Al-4V aerospace |
| DED | metal feedstock (wire/powder) + laser/arc | 200-1000 µm | high (large parts) | repair, large parts |

Powder-bed processes (SLS, MJF, SLM, EBM, BJ) are bounded by L11 Hales
0.7405 in the powder layer density.

---

*Phase C synthesis architecture overview, authored 2026-05-13. The forward-
process counterpart to `hexa-recycle/`.*
