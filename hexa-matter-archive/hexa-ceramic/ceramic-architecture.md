<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_CER architectural overview -->

# ceramic-architecture — bond character, processing routes, ceramic-glass continuum

> Architectural overview of how CER verbs interconnect. Companion to
> `CERAMIC-ENGINEERING.md` (root, 299 lines) and per-verb specs.

## §1 The CER material hierarchy

```
                              GROUP_CER
                                 |
       +-------------------------+---------------------------+
       |                         |                           |
   silicate                  oxide ceramic              non-oxide ceramic
       |                         |                           |
  +----+----+              +-----+------+              +-----+------+
  |    |    |              |     |      |              |     |      |
glass concrete  cement   Al₂O₃ ZrO₂  perovskite      SiC   Si₃N₄   B₄C / BeO
SiO₂  CaO·SiO₂          ruby/   YSZ   ABX₃ / ABO₃    armor turbine refractory
fused  Portland         sapphire dental    PV/oxide
silica                                                 |
                                                  compound-semi
                                                  (SiC wafer, GaN wafer)

       2D ceramic                    porous ceramic            allotropic C
            |                              |                         |
       +----+----+                    +----+----+                +---+---+----+
       |    |    |                    |         |                |   |   |    |
      hBN MoS₂ WS₂                 mof zeolite                diamond CNT fullerene
      MXene phosphorene             HKUST-1, MOF-5            glassy carbon
                                                              pyrolytic
```

## §2 Bond-character spectrum

CER groups along a continuum of bond character:

| Sub-class | Dominant bond | Example | T_m (K) | Bond energy (kJ/mol) |
|-----------|---------------|---------|---------|----------------------|
| Pure ionic | Mg²⁺-O²⁻ | MgO | 3098 | ~3795 (lattice energy) |
| Mixed ionic-covalent (silicate) | Si-O-Si | SiO₂ (fused silica) | 1996 | ~798 (Si-O bond) |
| Mixed ionic-covalent (perovskite) | Ti-O / Sr-O / Pb-O | SrTiO₃, BaTiO₃ | 2353 (SrTiO₃) | varies |
| Strong covalent | Si-C / Si-N | SiC, Si₃N₄ | 3003 / 2173 (dec.) | ~451 / ~439 |
| Strong covalent (sp³ network) | C-C | diamond | 4300 sublim. | ~711 |
| vdW + covalent (2D) | in-plane covalent + out-of-plane vdW | hBN, MoS₂ | (decomposes) | varies |
| Coordination polymer | metal-organic linker | HKUST-1, MOF-5 | (decomposes < 700 K) | weak; ~100-200 |

## §3 Ceramic ↔ glass continuum

Glass is amorphous ceramic; the same SiO₂ network forms either:
- Crystalline quartz (slow cool) → density 2.65 g/cm³
- Amorphous fused silica (fast cool, T_g ~1473 K) → density 2.20 g/cm³

The continuum:

```
Pure crystalline → polycrystalline → glass-ceramic → vitreous glass → amorphous
       |                                  |                |               |
   quartz SRM 1879b              Pyroceram / Schott    soda-lime     gel-derived silica
   (NIST)                        Zerodur                window glass  (sol-gel TEOS)
                                 (low-CTE)              float process  Hench & West 1990
```

This continuum is why `glass/` and `ceramics/` are distinct verbs but
share NIST/SEMI SRM lineage. The `glass-ceramic` class (Schott Zerodur,
Pyroceram) sits at the boundary — partially crystallized by controlled
nucleation, exhibits near-zero CTE for telescope mirror substrates.

## §4 Processing routes

| Route | Forward | Verbs touched | Real-limit anchor |
|-------|---------|---------------|-------------------|
| Sintering (high-T solid-state) | green body → densified ceramic | ceramics, silicon (Si₃N₄), 2d-materials (hBN bulk) | Frenkel sintering kinetics (UNVERIFIED dataset parity) |
| Sol-gel | metal alkoxide + H₂O → gel → xerogel/aerogel/glass | glass, silicon (SiO₂), perovskite, mof | Hench & West 1990 TEOS hydrolysis rate ✅ CLOSED 2026-05-13 (gate `tests/prc_b3_solgel_teos_parity.py`) |
| CVD (chemical vapor deposition) | gas precursor → film on substrate | silicon (poly-Si, epi-Si), compound-semi (SiC, GaN), 2d-materials (CVD graphene/hBN) | reactor capacity (vendor); no lattice fit |
| CZ / FZ pull | Si melt + seed → mono-crystal ingot | silicon | Si-L3 (CZ ~600 mm), Si-L4 (FZ ~200 mm) |
| PVT (physical vapor transport) | SiC powder → SiC boule at 2200-2400 °C | compound-semi (SiC) | Si-L11 4H-SiC E_g 3.26 eV |
| Hydrothermal | aqueous metal salts + alkali → crystalline product | perovskite, zeolite (mof-adjacent), gemology (synthetic quartz, ruby, sapphire) | NIST hydrothermal stability data (varies) |
| Cement hydration | cement + H₂O → C-S-H + Ca(OH)₂ | concrete, concrete_tech | ACI 318 curing model |
| Mechanical exfoliation | bulk crystal → 2D flake | 2d-materials (graphene, MoS₂, hBN) | (lab-scale only; commercial CVD instead) |

## §5 Real-limit map (from `LIMIT_BREAKTHROUGH.md`)

| # | Limit | Class | Value | Verb |
|---|-------|-------|-------|------|
| L4 | Mohs hardness ceiling | HARD | 10 (diamond) | gemology, carbon |
| L5 | Refractory melting point ceiling | HARD | 4215 K (Ta₄HfC₅) | ceramics |
| L7 | Glass T_g | SOFT (compositional) | ~1473 K (fused silica) | glass |
| L8 | Concrete compressive σ_c | SOFT | 30 MPa ord. → 800 MPa UHPC → 2 GPa theoretical | concrete, concrete_tech |
| Si-L5 | Si T_m | HARD | 1687 K | silicon |
| Si-L7 | Si E_g | HARD | 1.12 eV | silicon, compound-semi |
| Si-L11 | 4H-SiC E_g | HARD | 3.26 eV | compound-semi, silicon |
| Si-L12 | Si₃N₄ flexural | SOFT | 600-1200 MPa | ceramics, silicon |

## §6 Cross-group interfaces

### §6.1 CER ↔ MET (silicide, carbide, refractory metals)

- Tungsten carbide (WC) is ceramic by bond, metallurgical by application
  (cutting tools, dies). Lives in `metallurgy/` for the tool angle and
  `ceramics/` for the bond angle.
- Refractory metal carbides (TaC, HfC, Ta₄HfC₅) define L5 melting-point
  ceiling at 4215 K.

### §6.2 CER ↔ POL (ceramic-matrix composite, silicone)

- Ceramic-matrix composite (CMC): SiC fiber in SiC matrix (turbine blade
  application; GE F414, Rolls-Royce Trent XWB). Lives in `ceramics/` +
  `epoxy/` (matrix) + composite-cross-domain.
- Silicone (PDMS): Si-O-C polymer. Lives across `adhesive/`, `elastomer/`,
  and CER (Si-O bond).

### §6.3 CER ↔ FIB (fiberglass, carbon fiber)

- Fiberglass: SiO₂-based glass fiber. CER bond, FIB form factor.
- Carbon fiber: graphite-precursor fiber. CER bond (covalent C-C),
  FIB form factor. The `carbon/` verb covers the bond + allotrope
  side; `fabric/` covers the fabric form.

### §6.4 CER ↔ PRC (synthesis routes)

- Sol-gel, CVD, sintering, hydrothermal all live in `synthesis/` and
  `MATERIAL-SYNTHESIS.md`. The CER verbs reference the routes; the
  PRC verbs own the route specs.

## §7 The perovskite spotlight (Phase D entrant, multi-headed)

Perovskite (ABX₃) is one verb with two distinct application clusters:

| Cluster | Composition class | Application | Status |
|---------|-------------------|-------------|--------|
| Halide perovskite | MAPbI₃, CsPbBr₃, FAPbI₃ | photovoltaic (PCE > 26% lab) | UNVERIFIED at 25-yr lifetime + large area |
| Oxide perovskite | SrTiO₃, BaTiO₃, LaAlO₃, (La,Sr)MnO₃ | piezo, dielectric, ferroelectric, multiferroic | mature (manufacturing) |

The LK-99 claim (Lee, Kim & Auh 2023) for room-T superconductivity is in
the oxide perovskite-adjacent (Cu-doped lead apatite) space. It is **NOT
REPRODUCED** (HARD_WALL per `LIMIT_BREAKTHROUGH.md` Wave M); preserved
verbatim in `perovskite/perovskite.md` and in this dir's `README.md` §5.

## §8 The carbon spotlight (allotrope spread)

Carbon has the most allotropic spread of any CER-adjacent element:

| Allotrope | Bond | Hardness | Application |
|-----------|------|----------|-------------|
| Diamond (sp³ cubic) | strong covalent | Mohs 10 (L4 ceiling) | abrasive, gem, heat-spreader |
| Graphite (sp² hexagonal layered) | covalent in-plane, vdW out-of-plane | soft (Mohs 1-2) | electrode, lubricant, pencil |
| Graphene (2D sp²) | covalent in-plane only | n/a (2D) | (no commercial bulk; foil scale UNVERIFIED) |
| CNT (1D rolled graphene) | covalent | E ~1 TPa lab | yarn 80 GPa lab UNVERIFIED at commercial scale |
| Fullerene (C₆₀, C₇₀ molecular) | covalent (cage) | n/a (molecular) | research (lab-grown C₆₀) |
| Glassy carbon | amorphous sp²/sp³ mix | hard, isotropic | electrode, crucible |
| Pyrolytic carbon | sp² oriented | hard, smooth | medical implant, valve |
| Activated carbon | porous amorphous | n/a (high SSA) | filter, adsorbent |
| Carbon fiber | turbostratic sp² | E ~230-900 GPa | aerospace structure |
| Lonsdaleite (hexagonal diamond) | sp³ hexagonal | calc 150 GPa (UNVERIFIED bulk) | UNVERIFIED at production |
| Carbyne (linear C chain) | sp¹ alkyne/cumulene | calc 60 GPa (UNVERIFIED) | research only |

The `carbon/` verb (Phase D, 304 lines) covers all 11 allotropes with
honest UNVERIFIED stamps on lonsdaleite, carbyne, diamond-as-semi.

---

*Phase C ceramic architecture overview, authored 2026-05-13. Auxiliary
overview; real anchors are `CERAMIC-ENGINEERING.md` (root) and
`LIMIT_BREAKTHROUGH.md` Wave M.*
