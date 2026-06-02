<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_POL architectural overview -->

# polymer-architecture — chain-growth vs step-growth, MW distribution, Tg/Tm domains

> Architectural overview of how POL verbs interconnect. Companion to
> `POLYMER-CHEMISTRY.md` (root, 439 lines).

## §1 The POL material hierarchy

```
                                    GROUP_POL
                                       |
                +----------------------+----------------------+
                |                                             |
         chain-growth                                  step-growth
         (free radical, anionic,                       (condensation,
          cationic, coordination)                      addition)
                |                                             |
   +------------+-------------+              +----------------+----------------+
   |            |             |              |                |                |
  PE / PP    PS / PMMA   PVC / PVDF      nylon-6,6      PET / PBT       epoxy / phenolic
   (HDPE)    PMMA = acrylic                 amide        ester              thermoset
                                            (DuPont       (Toray Lumirror)   (DGEBA/DETA)
                                             Zytel,
                                             BASF Ultramid)
                |
            elastomer
            (Phase D)
                |
   +------------+-------------+-------------+
   |            |             |             |
  NR (natural) SBR (styrene)  EPDM       silicone (PDMS, Si-O-C cross-link to CER)
  cis-1,4      butadiene      ethylene-
  isoprene     50/50          propylene
                              diene

                                       step-growth (continued)
                                            |
                       +--------------------+------------------+
                       |                                       |
                  PU (urethane)                          aramid (PPTA)
                  rigid foam, soft foam,                 Kevlar / Twaron / Technora
                  TPU, elastomeric                       aromatic amide
                                                        (decomp ~770 K, no T_g)

                       biodegradable                         liquid-crystal (Phase D)
                            |                                     |
              +-------------+-------------+               +-------+--------+
              |             |             |               |                |
            PLA           PHA          PBS              thermotropic    lyotropic
            lactic-acid   poly-hydroxy-  poly-          (small-mol     (Kevlar-PPTA
            polyester     alkanoate     butylene-       LC display)    spinning dope)
                          (bacterial)   succinate

                       adhesive (Phase D)
                            |
        +-------------------+--------------------+
        |                   |                    |
      PSA              structural            CA / anaerobic / hot-melt
      acrylic, SBR     epoxy, urethane,      cyanoacrylate (instant)
                       MMA                    Loctite anaerobic
                                              EVA hot-melt
```

## §2 Linkage / bond character

| Verb | Linkage | T_g (K) | T_m (K) | σ_tens (GPa typical) | Industrial signature |
|------|---------|---------|---------|----------------------|----------------------|
| aramid (PPTA, Kevlar 49) | aromatic amide | none (decomp ~770 K) | n/a (decomp) | 3.6 (fiber) | ballistic, aerospace |
| nylon-6,6 | aliphatic amide | 323 | 538 | 0.6-0.8 | tire-cord, textile |
| nylon-6 | aliphatic amide | 313 | 493 | 0.5-0.7 | engineering plastic |
| PET (pet_film) | ester | 343 | 533 | 0.06-0.08 (film) | packaging, MRI tape |
| epoxy (DGEBA cured) | epoxide network | 393-473 | thermoset; n/a | 0.04-0.09 (matrix) | aerospace composite |
| PE (HDPE) | C-C | 153 | 408 | 0.025-0.040 | bag, bottle |
| PP (isotactic) | C-C | 263-273 | 438 | 0.030-0.040 | container, fiber |
| PS | C-C | 373 | (amorphous) | 0.045 | foam, optical |
| PMMA | C-C ester pendant | 378 | (amorphous) | 0.075 | acrylic glass |
| NR (natural rubber) | C=C cis | 200 | (amorphous) | 0.030 (unvulcanized → 0.03 vulc.) | tire, glove |
| SBR | C-C/C=C | 213 | (amorphous) | 0.025 vulc. | tire tread |
| EPDM | C-C/C=C | 219 | (amorphous) | 0.020 vulc. | seal, weatherstrip |
| silicone (PDMS) | Si-O-C | 150 | (amorphous) | 0.005 unfilled → 0.010 filled | sealant, implant |
| PU (rigid) | urethane | 373-473 | (thermoset) | 0.040-0.080 | rigid foam, adhesive |
| PU (TPU) | urethane | 233-253 | 408-453 | 0.030-0.060 | flexible, automotive |
| fluoroelastomer (Viton) | C-F | 240-260 | (amorphous) | 0.015 | fuel hose, O-ring |
| PLA | ester | 333-358 | 423-453 | 0.060 | 3D-print, food container |
| PHA (PHB) | ester | 278-288 | 448-453 | 0.030-0.040 | medical implant, packaging |
| PBS | ester | 240 | 388-393 | 0.030-0.040 | bag, mulch film |
| MOF (HKUST-1) | coord polymer | n/a (porous) | decomp 350-700 K | n/a (porous) | gas storage, DAC |
| LCP (Vectra) | thermotropic LC | 383-393 | 553 | 0.150-0.200 | high-temp connector |

## §3 Real-limit map (from `LIMIT_BREAKTHROUGH.md`)

| # | Limit | Class | Value | Verb |
|---|-------|-------|-------|------|
| L1 | Frenkel σ_th = E/10 | HARD (theoretical) | polymer cap ~30 GPa for ideal CNT yarn; ~150 GPa CNT theoretical | aramid, carbon (cross-link), CNT-fiber |
| L2 | Practical tensile strength SOFT_WALL | SOFT | aramid ~3.6 GPa Kevlar 49; UHMWPE ~3.9 GPa Dyneema SK99; CNT yarn lab 80 GPa | aramid, polymer-fiber |
| L12 | Entropy of mixing (Gibbs) | HARD | polymer recycling Gibbs floor → mixed-PE/PP separation impossible without chemical recycling | recycling, recycle_n6, biodegradable-plastics |

## §4 Processing routes (POL)

### §4.1 Chain-growth (radical, anionic, cationic, coordination)

- Free-radical (most commodity): PE, PP, PS, PVC, PMMA, SBR
- Anionic: living polymerization for narrow MW distribution (specialty)
- Cationic: butyl rubber (IIR), polyacetals
- Coordination (Ziegler-Natta, metallocene): isotactic PP, HDPE, EPDM

### §4.2 Step-growth (condensation, addition)

- Polyamide (nylon-6,6 from HMDA + adipic acid; nylon-6 from caprolactam ring-open)
- Polyester (PET from EG + TPA; PBT from BDO + TPA; PLA from lactide ROP)
- Polyurethane (urethane from diisocyanate + polyol)
- Epoxide (DGEBA from bisphenol-A + epichlorohydrin; cure with amine or anhydride)
- Aramid (PPTA from PPD + TPC; H₂SO₄ spinning dope, lyotropic LC phase)

### §4.3 Crosslinking / vulcanization

- Sulfur vulcanization (NR, SBR, EPDM): Goodyear 1839
- Peroxide cure (silicone, EPDM): high-temp service
- UV cure (acrylic PSA, dental composite): photoinitiator
- E-beam cure (rubber, packaging): industrial scale

### §4.4 Spinning / film extrusion / molding

- Melt spinning (nylon, PET, PP fiber): T > T_m
- Solution spinning (aramid in H₂SO₄, UHMWPE in decalin): lyotropic LC phase critical
- Biaxial film stretching (BOPET, BOPP): orientation hardens
- Injection molding (everything thermoplastic): primary mass-production route
- Thermoforming (PET food container, ABS automotive panel)

## §5 MW distribution + glass transition domain

The Flory-Schulz distribution (step-growth) and Schulz-Zimm distribution
(chain-growth) bracket the achievable Đ (polydispersity index, Đ = Mw/Mn):

| Polymerization | Đ typical | Verb examples |
|----------------|-----------|---------------|
| Living anionic (specialty) | 1.02-1.10 | specialty PS, block copolymer |
| Coordination (metallocene) | 2.0-2.5 | HDPE, isotactic PP |
| Free-radical | 2.0-5.0 | LDPE, PVC, PMMA |
| Step-growth at high conversion | 2.0 (Flory limit) | nylon, PET, PU |
| Branched / crosslinked | n/a (gel point) | epoxy thermoset, vulcanized rubber |

T_g domain map (per `POLYMER-CHEMISTRY.md §3`):

```
   T_g [K]
     ↑
  500 ┼  PMMA(378) PS(373) PU rigid(373-473)
      │
  400 ┼  PET(343) PLA(333-358) PA-6,6(323)
      │
  300 ┼  PA-6(313) — room temperature ~298 K —
      │  PU TPU(233-253)
  200 ┼  NR(200) SBR(213) EPDM(219) PHA(278-288)
      │
  100 ┼  silicone(150) PE(153)
      │
      └─────────────────────────────────────→
                Chain stiffness / aromaticity
```

## §6 Cross-group interfaces

### §6.1 POL ↔ FIB

Fiber form-factor of POL chemistry:
- aramid (PPTA fiber)
- nylon-6,6 fiber (textile, tire-cord, carpet)
- PET fiber (textile, bottle-grade)
- PP fiber (rope, carpet, geotextile)
- UHMWPE fiber (Dyneema, Spectra; ballistic)

Lives across `hexa-polymer/` (chemistry) + `hexa-fiber/` (form-factor).

### §6.2 POL ↔ CER

- Composite matrix (epoxy in CFRP, vinyl-ester in GFRP)
- Silicone (PDMS, Si-O-C — Si-O bond crosses POL/CER)
- MOF (coordination polymer — metal node + organic linker; crosses POL/CER)
- Liquid-crystal (LCP Vectra, Sumitomo Zenite — mesogen with rigid aromatic core)

### §6.3 POL ↔ FAS

Textile-grade polymers:
- nylon (Nylon 6 / 6,6 textile)
- polyester (PET fiber)
- spandex (PU elastomeric fiber — Lycra)
- acrylic fiber (PAN — Orlon)

Lives across `hexa-polymer/` (chemistry) + `hexa-fashion/` (textile end-use).

### §6.4 POL ↔ MET

- Rubber-bonded metal (engine mount, vibration isolator)
- Adhesive-bonded metal joint (epoxy in aerospace primary structure)
- Elastomer over-mold on metal (over-molded grip)
- Conformal coating (polyimide, parylene over PCB)

### §6.5 POL ↔ PRC

- Step-growth + chain-growth polymerization (`synthesis/`)
- Chemical recycling (depolymerization to monomer): `recycling/`, `recycle_n6/`
- The Gibbs ΔS_mix entropy floor (L12) is the polymer-recycling HARD wall —
  mixed-PE/PP can't be cleanly separated without breaking back to monomer.

## §7 The microplastics spotlight

`microplastics/` (v1.0.0) is the *environmental* polymer verb. It does NOT
represent a new bond class but a downstream-fate axis: size partition,
leaching, biofilm colonization, K_d partition coefficient.

Cross-link: NOAA Marine Debris Program / 5 Gyres Institute / Algalita
publish field measurements; the verb spec stores these as vendor-class

## §8 The biodegradable-plastics spotlight (Phase D)

Marine-biodegradability claims are particularly fraught:
- ASTM D7081 (marine biodegradability) certifies only certain PHA grades
- "biodegradable" labels on PLA / starch blend / oxo-degradable plastic are
  often only industrial-compost-degradable, NOT marine-biodegradable
- The verb spec preserves this verbatim as **UNVERIFIED for most grades**

Cost parity to PE is also UNVERIFIED (PLA ~2-3x PE; PHA ~5-10x).

---

*Phase C polymer architecture overview, authored 2026-05-13. Real anchors
are `POLYMER-CHEMISTRY.md` (root) and `LIMIT_BREAKTHROUGH.md` L1/L2/L12.*
