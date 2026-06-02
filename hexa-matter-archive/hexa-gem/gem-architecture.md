<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_GEM architectural overview -->

# gem-architecture — species, RI, dispersion, hardness, treatment

> Architectural overview of GROUP_GEM. Companion to `GEMOLOGY.md` (root)
> and `GRAPHENE-CARBON.md` (diamond cross-link).

## §1 The GEM species hierarchy

```
                              GROUP_GEM
                                 |
                +----------------+----------------+
                |                                 |
            single-mineral                    aggregate / rock
            gem species                       (lapis lazuli, jade,
                |                              chalcedony group)
                |
   +------------+------------+------------+
   |            |            |            |
 carbon       oxide       silicate     phosphate / borate
 group        group       group        group
   |            |            |            |
 diamond     corundum     beryl        turquoise
 (cubic C    (α-Al₂O₃)     (Be₃Al₂Si₆O₁₈) (CuAl₆(PO₄)₄(OH)₈·4H₂O)
  Mohs 10,   ruby (Cr³⁺)   emerald (Cr³⁺)   spodumene (kunzite, hiddenite)
  RI 2.42)   sapphire     aquamarine (Fe²⁺/³⁺)
             (Ti⁴⁺/Fe³⁺,  heliodor (Fe³⁺)
              Fe²⁺/Ti⁴⁺)  morganite (Mn²⁺)
                          goshenite (pure)
             spinel
             (MgAl₂O₄)    garnet group
                          (almandine, pyrope, spessartine,
                           grossular, andradite, uvarovite)

             chrysoberyl    topaz (Al₂(SiO₄)(F,OH)₂)
             (BeAl₂O₄)
             alexandrite    tourmaline group
             (Cr-doped)     (Na/Ca-Mg-Al borosilicate, schorl/elbaite/dravite)

                            quartz family
                            (α-SiO₂ — amethyst, citrine, rock crystal,
                             smoky, rose; chalcedony, agate, jasper)

                            peridot (olivine, (Mg,Fe)₂SiO₄)

                            zircon (ZrSiO₄)

                            tanzanite (Ca₂Al₃(SiO₄)(Si₂O₇)O(OH))
                            (Tsavorite green grossular variety)
```

## §2 GEM species characterization table

| Species | Formula | Mohs | RI | Birefringence | SG | Dispersion | Notable |
|---------|---------|------|-----|---------------|----|----|---------|
| Diamond | C (cubic) | 10 | 2.417 | 0 (isotropic) | 3.52 | 0.044 | L4 hardness ceiling; CVD/HPHT lab-grown audit |
| Corundum (ruby) | α-Al₂O₃ + Cr³⁺ | 9 | 1.762-1.770 | 0.008 | 4.00 | 0.018 | fluorescence λ_max 694.3 nm |
| Corundum (sapphire) | α-Al₂O₃ + Ti⁴⁺/Fe³⁺ | 9 | 1.762-1.770 | 0.008 | 4.00 | 0.018 | color-change, padparadscha varieties |
| Beryl (emerald) | Be₃Al₂Si₆O₁₈ + Cr³⁺ | 7.5-8 | 1.566-1.602 | 0.005-0.009 | 2.69-2.80 | 0.014 | "jardin" inclusions characteristic |
| Beryl (aquamarine) | Be₃Al₂Si₆O₁₈ + Fe²⁺ | 7.5-8 | 1.566-1.602 | 0.005-0.009 | 2.69-2.80 | 0.014 | heat-treated for blue |
| Spinel (red) | MgAl₂O₄ + Cr³⁺ | 8 | 1.715-1.720 | 0 (isotropic) | 3.58-3.61 | 0.020 | confused with ruby historically (Black Prince's Ruby = spinel) |
| Topaz | Al₂(SiO₄)(F,OH)₂ | 8 | 1.610-1.630 | 0.008-0.010 | 3.49-3.57 | 0.014 | imperial topaz; cleavage perfect |
| Chrysoberyl (alexandrite) | BeAl₂O₄ + Cr³⁺ | 8.5 | 1.745-1.755 | 0.008-0.011 | 3.71-3.75 | 0.015 | color-change red-green |
| Quartz (amethyst, citrine) | α-SiO₂ + Fe (heat→citrine) | 7 | 1.544-1.553 | 0.009 | 2.65 | 0.013 | piezoelectric (cross-link to compound-semi) |
| Garnet (almandine) | Fe₃Al₂(SiO₄)₃ | 7-7.5 | 1.785-1.830 | 0 | 4.05 | 0.027 | abundant; abrasive use |
| Garnet (pyrope) | Mg₃Al₂(SiO₄)₃ | 7-7.5 | 1.730-1.750 | 0 | 3.65-3.80 | 0.022 | "blood-red" rhodolite variety |
| Garnet (tsavorite) | Ca₃Al₂(SiO₄)₃ + V/Cr | 7-7.5 | 1.738-1.745 | 0 | 3.60-3.68 | 0.028 | bright green |
| Tourmaline | Na(Li,Al)₃Al₆(BO₃)₃Si₆O₁₈(OH)₄ | 7-7.5 | 1.620-1.640 | 0.014-0.024 | 3.06 | 0.017 | pleochroic strong; paraiba (Cu) |
| Zircon | ZrSiO₄ | 7.5 | 1.810-2.024 | 0.039-0.059 | 4.65-4.80 | 0.039 | high dispersion (rivals diamond); blue heat-treated |
| Tanzanite | Ca₂Al₃(SiO₄)(Si₂O₇)O(OH) | 6.5-7 | 1.691-1.700 | 0.009 | 3.35 | 0.019 | trichroic, blue-violet |
| Peridot | (Mg,Fe)₂SiO₄ | 6.5-7 | 1.654-1.690 | 0.036 | 3.34 | 0.020 | one of the few green gems untreated |
| Lapis lazuli | (Na,Ca)₈(AlSiO₄)₆(SO₄,S,Cl)₂ aggregate | 5-6 | (aggregate) | n/a | 2.7-2.9 | n/a | rock not single crystal |

## §3 The four-C trade-quality axes

| C | Axis | Diamond | Colored stones |
|---|------|---------|----------------|
| Carat | weight (1 ct = 0.200 g) | discrete jumps in price by 0.5 / 1 / 2 / 3 ct | linear |
| Cut | proportion + symmetry + polish (GIA Excellent/VG/Good/Fair/Poor) | shape preference varies |
| Color | D-Z (colorless to yellow) for diamond | hue + saturation + tone (GIA system) |
| Clarity | FL/IF/VVS/VS/SI/I (GIA scale) | varies by species (emerald "garden" expected) |

## §4 Real-limit map (from `LIMIT_BREAKTHROUGH.md`)

| # | Limit | Class | Value | Verb |
|---|-------|-------|-------|------|
| L4 | Mohs hardness ceiling | HARD | 10 (diamond, cubic C) | gemology, carbon |

Lonsdaleite (hexagonal diamond, calc Vickers 150 GPa) and w-BN (calc
Vickers 85 GPa) remain non-synthesized in bulk. **UNVERIFIED** — preserved
verbatim from `carbon/carbon.md`.

## §5 Treatment + synthetic disclosure (GIA discipline)

Common treatments (require GIA disclosure):

| Treatment | Species affected | Disclosure status |
|-----------|------------------|-------------------|
| Heat | corundum (Be-diffusion sapphire), zircon (blue), citrine (from amethyst), tanzanite | "H" |
| Irradiation | diamond (blue irradiated), topaz (blue), pearl | "I" |
| Fracture filling | emerald (oil, Opticon), diamond | "F" |
| Lattice diffusion | corundum (Be-diffusion) | "D" |
| HPHT (high-pressure high-temperature) | diamond color enhancement | "HPHT" |
| Coating | tanzanite, diamond | "C" |
| Bleaching + dyeing | jade, pearl | "B+D" |
| Impregnation | turquoise, opal | "P" |

Synthetic disclosure:
- CVD diamond: chemical vapor deposition; lab-grown, fully diamond
- HPHT diamond: high-pressure high-temperature; lab-grown
- Verneuil (flame fusion) ruby/sapphire: Auguste Verneuil 1902
- Czochralski synthetic: ruby, garnet (YAG), tanzanite
- Hydrothermal synthetic: quartz, ruby, emerald
- Flux growth: emerald, ruby (Chatham, Gilson methods)

## §6 Cross-group interfaces

### §6.1 GEM ↔ CER

Same material, different application:
- α-Al₂O₃: corundum (gem) ↔ alumina (engineering ceramic, Coorstek)
- C (cubic diamond): gem ↔ diamond abrasive (industrial)
- MgAl₂O₄ spinel: gem ↔ transparent armor (PCO Coorstek)
- α-SiO₂ quartz: gem (amethyst, citrine) ↔ NIST SRM 1879b (crystallographic standard)

### §6.2 GEM ↔ MET

Gold, platinum, palladium, rhodium, silver for mountings:
- 24k Au = pure (Mohs 2.5, too soft for setting)
- 18k Au (75% Au alloy) = standard fine jewelry (yellow / white / rose)
- 14k Au (58.5% Au) = US standard fine jewelry
- 950 Pt (95% Pt) = standard high-end
- Rh-plated white gold = bright white

### §6.3 GEM ↔ PRC

Synthetic routes (hydrothermal, Verneuil, CVD, HPHT, flux, Czochralski)
live in `synthesis/` and `MATERIAL-SYNTHESIS.md`.

---

*Phase C gem architecture overview, authored 2026-05-13.*
