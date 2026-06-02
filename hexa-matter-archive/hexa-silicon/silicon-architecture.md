<!-- @authored: 2026-05-13 -->
<!-- @phase: C — silicon cross-group architecture -->

# silicon-architecture — how Si interconnects CER, MET, PRC

> Architectural overview of silicon's bridge structure. Companion to
> `README.md` (this dir) and `../silicon/silicon.md` (verb spec).
> No content is duplicated — this file describes RELATIONSHIPS.

## §1 The Si material tree

```
                          elemental Si
                              |
            +-----------------+-----------------+
            |                                   |
       poly-Si (Siemens, FBR)            mono-Si (CZ, FZ)
        9N–11N purity                    < 100 cm⁻² disloc
            |                                   |
   +--------+--------+               +----------+----------+
   |                 |               |                     |
 solar (6-7N)   electronic (9N+)  wafer (CZ 300 mm)   wafer (FZ 200 mm)
                                  high [O_i]          low [O_i] < 0.1 ppma
                                  10-30 ppma          power-electronics
                                                      detector grade

           SiO₂ branch
            |
       +----+----+
       |         |
    quartz   fused silica
    (SRM)    (Heraeus, Corning)
                                          T_g ≈ 1473 K
                                          → glass/glass.md (verb)

           SiC / SiN / Si₃N₄ branch
            |
       +----+--------+
       |             |
    SiC ceramic   Si₃N₄ ceramic
    armor, brake   turbine, bearing
                                          flexural 600-1200 MPa
                                          → ceramics/ceramics.md

           SiC compound-semi branch
            |
       4H-SiC wafer (Wolfspeed)
       E_g = 3.26 eV (HARD)
                                          → compound-semi/compound-semi.md

           Si as alloy branch
            |
       +----+----+----+
       |    |    |    |
     Al-Si  Fe-Si Cu-Si
     casting electrical bronze
     ~7-12%  3-4% Si  ~3-4% Si
                                          → metallurgy/metallurgy.md
```

## §2 Bond-character map across the tree

| Form | Dominant bond | Bond character | Where it shows up |
|------|---------------|----------------|--------------------|
| Elemental Si | covalent (sp³ diamond cubic) | strong covalent network | wafer, semiconductor (device → hexa-chip) |
| SiO₂ | mixed ionic + covalent (Si-O-Si polar) | tetrahedral; T_g 1473 K | glass, fused silica, optical fiber |
| SiC | covalent (sp³) | wide-bandgap, hard, refractory | armor, power-electronics, abrasive |
| Si₃N₄ | covalent (sp³, mixed with N sp²) | refractory, high flexural σ | turbine, ball-bearing |
| Si in Al-Si | metallic (Si dissolved in fcc Al) | eutectic at 12.6 wt% Si | engine block, automotive casting |
| Si in Fe-Si | metallic (bcc Fe with Si solid sol.) | reduces hysteresis loss | transformer steel, motor laminations |
| Silicone (PDMS) | covalent Si-O-C | flexible chain, –C–Si–O–Si– | sealant, medical implant, breast implant |
| Silicene (2D) | covalent + buckled (mixed sp²/sp³) | buckled hexagonal sheet | research lab; Ag(111) substrate UNVERIFIED ambient |

## §3 Processing routes (Si as PRC anchor)

Per `synthesis/synthesis.md` and `MATERIAL-SYNTHESIS.md`:

| Route | Forward direction | Reverse / EoL |
|-------|-------------------|---------------|
| Siemens TCS distillation | SiHCl₃ → poly-Si rod (CVD on heated Si filament) | EoL: solar panel recycling (silicon recovery is hard; thin-film easier) |
| Fluid-Bed Reactor (FBR) | SiH₄ → poly-Si granules (lower energy than Siemens) | (same recycling channel) |
| Czochralski (CZ) | poly-Si melt → mono-Si ingot (rotating crystal pull) | wafer rejects → re-melt feedstock |
| Float-Zone (FZ) | poly-Si rod → mono-Si ingot (RF coil, no crucible) | very high purity; rejects rare |
| CVD epitaxy | gas-phase Si film growth on Si wafer | (device-layer; hexa-chip scope) |
| SiC seeded sublimation (PVT) | SiC powder → 4H-SiC boule at 2200-2400 °C | wafer slicing |
| Sol-gel SiO₂ | TEOS + H₂O hydrolysis → silica gel → fused silica | wet-process; recyclable solvent |

## §4 Cross-group interface points

### §4.1 CER ↔ MET (silicide formation)

Silicide phases (Fe₃Si, FeSi, FeSi₂, β-Fe₂Si, Cu₃Si, Mg₂Si) sit at the
ceramic-metal boundary. They are part of the Si-as-alloy story but also
have ceramic-class properties (high melting, refractory). The `metallurgy/`
verb owns alloy-aspect; the `ceramics/` verb owns refractory-ceramic-aspect.
Phase-diagram crossovers are in `METALLURGY-DEEP.md`.

### §4.2 CER ↔ PRC (Si as synthesis substrate)

Si is the synthesis-platform material for the entire semiconductor industry:
Siemens process feeds CZ, CZ feeds wafer fab, fab feeds device. The PRC
group's `synthesis/synthesis.md` is the entry point; `MATERIAL-SYNTHESIS.md`
deep-dive enumerates Siemens, FBR, modified Siemens variants.

### §4.3 CER ↔ FAS / FIB

Negligible. SiO₂ enters textile (fiberglass cloth, glass fiber reinforcement)
but that's downstream FIB / composite scope, not the silicon material layer.

### §4.4 CER ↔ POL (silicone)

Silicone (PDMS) is a Si-O-C polymer, sitting at the bridge between POL
(polymer backbone) and CER (Si-O ionic-covalent bond). Major vendors are
Dow Corning, Wacker Silicones, Shin-Etsu Silicones. No dedicated `silicone/`
verb yet — silicone fragments into adhesive (`adhesive/`), elastomer
(`elastomer/`), and biodegradable (medical implant context).

## §5 Real-limits map (Si-L1..Si-L12, from LIMIT_BREAKTHROUGH.md Wave M)

| # | Limit | Class | Value | Anchor |
|---|-------|-------|-------|--------|
| Si-L1 | electronic-grade poly-Si purity | SOFT (process + measurement) | 9N (99.9999999 %) | SEMI M1, GDMS/ICP-MS/SIMS floor |
| Si-L2 | solar-grade poly-Si purity floor | SOFT | 6N–7N | SEMI PV17 |
| Si-L3 | CZ crucible diameter | SOFT | ≈ 600 mm | Ferrotec / Heraeus crucible specs |
| Si-L4 | FZ ingot diameter | SOFT | ≈ 200 mm | Topsil / Siltronic FZ datasheets |
| Si-L5 | Si melting point | HARD | 1687 K (1414 °C) | NIST WebBook |
| Si-L6 | Si density (293 K) | HARD | 2.329 g/cm³ | CRC Handbook 105th ed. |
| Si-L7 | Si bandgap (indirect, 300 K) | HARD | 1.12 eV | NIST / Sze SM Physics |
| Si-L8 | Thermal donor concentration (CZ post-anneal) | SOFT | ≈ 10¹⁶ cm⁻³ at 450 °C | Kaiser-Frisch 1958; Bullis SEMI |
| Si-L9 | Interstitial oxygen [O_i] (CZ wafer) | SOFT | 10–30 ppma; FZ < 0.1 ppma | ASTM F121 / F1188 |
| Si-L10 | Dislocation density (mono-Si wafer) | SOFT | < 100 cm⁻² (production); 0 achievable | ASTM F47 |
| Si-L11 | SiC wide bandgap | HARD | 3.26 eV (4H-SiC) | Saddow & Agarwal 2004 |
| Si-L12 | Si₃N₄ flexural strength (HIP-densified) | SOFT | 600–1200 MPa | ASM Handbook vol. 21 |

None of Si-L1..Si-L12 derives from n=6 lattice arithmetic. Each is anchored

## §6 The hexa-matter ↔ hexa-chip boundary

The boundary is enforced in three places:

1. `silicon/silicon.md §7` — explicit boundary statement.
2. `hexa.toml [crosslink].chip` — pointer to sister substrate.
3. This file — silicon-architecture.md §6.

**What lives in hexa-matter/silicon**:
- 9N purity ceiling (Si-L1)
- CZ / FZ dimensional ceilings (Si-L3, Si-L4)
- Material parameters T_m, ρ, E_g (Si-L5, Si-L6, Si-L7)
- Vendor tonnage / purity grade (Wacker, GCL, Hemlock, OCI, REC)
- SiO₂ / SiC / SiN cross-link to ceramics/glass

**What lives in hexa-chip** (NOT here):
- Transistor / MOSFET / FinFET / GAA architecture
- Lithography (DUV, EUV, multi-patterning)
- Photoresist chemistry (CAR, MOR)
- Fab process flow (FEOL, BEOL, CMP, etch)
- Node naming (N5, N3, N2, A14, A10)
- Wafer-per-month capacity (TSMC, Samsung, Intel)

This separation is fundamental. Treating wafer fab as a "material" mistake
is what leads to lattice-fit-on-vendors errors. The discipline at the

## §7 Phase-D additions that touch Si

12 Phase D verbs (commit `99620b2`) add 5 verbs that cross-link to silicon:

| Verb | Si cross-link | Reference |
|------|---------------|-----------|
| compound-semi | SiC 4H 3.26 eV wafer (Wolfspeed) | compound-semi.md |
| perovskite | oxide perovskite SrTiO₃ uses SiO₂/Si feedstock indirectly | perovskite.md |
| 2d-materials | silicene (2D Si allotrope on Ag(111)) | 2d-materials.md |
| mof | (no direct Si cross-link) | mof.md |
| carbon | (parallel material; no direct Si cross-link, but SiC fiber is Si × C composite) | carbon.md |

Phase D doesn't change Si-L1..Si-L12 but adds 4H-SiC and silicene as
explicit cross-link targets.

---

*Phase C silicon architecture overview, authored 2026-05-13. Aux only —
real anchors are `LIMIT_BREAKTHROUGH.md` Si-L1..Si-L12 + `SILICON.md`.*
