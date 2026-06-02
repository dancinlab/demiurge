# POLYMER-CHEMISTRY — extended chapter (GROUP_POL deep dive)

> **Authored**: 2026-05-13 (Phase A elevation)
> **Author**: 박민우 <nerve011235@gmail.com>
> **Scope**: polymer chemistry — chain-growth vs step-growth, MW distribution,
> Tg/Tm vs cross-linking, ester/amide/imide/urea linkages, biodegradable
> PLA/PHA/PBS chemistry.
> **Companion verbs**: aramid, epoxy, nylon, pet_film, microplastics, tire_cord;
> companion upstream-canon chapters: ARAMID.md, EPOXY.md, NYLON.md, PET-FILM.md.
>
> from CRC Handbook 105th ed., ASM Handbook vol. 21 (composites with polymer
> matrix), Mark's Encyclopedia of Polymer Science 4th ed., and manufacturer
> datasheets (DuPont, BASF, Toray, DSM Dyneema, Hexcel). Vendor values are
> not lattice-fitted.

---

## §1 The two polymerization mechanisms

All synthetic polymers come from one of two reaction families:

### §1.1 Chain-growth (addition) polymerization

Mechanism: an initiator (radical, anion, cation, coordination) opens a vinyl monomer's π-bond and propagates:

```
   I•  +   CH₂=CHR  →  I-CH₂-•CHR
                       ↓ (each step adds one monomer)
   I-CH₂-CHR-CH₂-•CHR  →  ... →  I-(CH₂-CHR)ₙ-CH₂-•CHR  →  ... termination
```

Examples:
- **PE** (polyethylene) — radical or Ziegler-Natta from ethylene
- **PP** (polypropylene) — Ziegler-Natta or metallocene from propylene
- **PS** (polystyrene) — radical from styrene
- **PVC** (polyvinyl chloride) — radical from vinyl chloride
- **PMMA** (polymethyl methacrylate) — radical from methyl methacrylate
- **PTFE** (polytetrafluoroethylene) — radical from tetrafluoroethylene

Kinetics: rate ∝ [monomer]^1 × [initiator]^(1/2) for radical; high MW (~ 10⁵ to 10⁶ g/mol) achievable in seconds-to-minutes; **polydispersity (Đ = Mw/Mn) typically 1.5-3.0** for radical, < 1.2 for living anionic.

### §1.2 Step-growth (condensation) polymerization

Mechanism: bifunctional monomers react step-wise; each step releases a small molecule (H₂O, HCl, methanol). The polymer grows by AA-BB or A-B mechanism:

```
   HOOC-R-COOH  +  H₂N-R'-NH₂  →  HOOC-R-CO-NH-R'-NH₂  +  H₂O
                                                       ↓ (each step joins two oligomers)
                                  ...HOOC-R-CO-NH-R'-NH-CO-R-COOH...  +  many H₂O
                                                       ↓
                                  (statistical, all functional groups react)
```

Examples:
- **Nylon-6,6** — adipic acid + hexamethylene diamine
- **Nylon-6** — caprolactam (ring-opening, technically chain-growth but classified as step-growth-like)
- **PET** — terephthalic acid + ethylene glycol → poly(ethylene terephthalate) + H₂O
- **PBT** — terephthalic acid + 1,4-butanediol
- **Aramid (Kevlar / Nomex)** — terephthaloyl chloride + p-phenylenediamine → PPTA + HCl
- **Epoxy** — DGEBA (bisphenol-A diglycidyl ether) + diamine cure → epoxide ring-opening cross-link
- **Polyimide (Kapton)** — pyromellitic dianhydride + 4,4'-oxydianiline → polyamic acid → imidized polyimide

Kinetics: Carothers equation gives degree of polymerization n_avg = 1/(1-p) where p = extent of reaction. To reach n_avg = 100, p must equal 0.99. To reach n_avg = 1000, p = 0.999. **Step-growth polymerization is extremely sensitive to monomer stoichiometry and to side reactions**; large industrial reactors run for hours to drive p > 0.998.

Polydispersity: most-probable distribution Đ = 1 + p; at p=0.99, Đ = 1.99 (≈ 2.0).

### §1.3 Mechanism comparison table

| Axis | Chain-growth | Step-growth |
|------|--------------|-------------|
| Mechanism | initiator propagation | bifunctional condensation |
| Active species | radical / ion at chain end | both ends of every oligomer |
| MW growth | rapid (s-min); reaches high MW early | slow (hrs); MW rises only near p→1 |
| Dispersity Đ | 1.5-3 (radical), 1.05 (living anionic) | ~ 2.0 (most-probable) |
| Byproduct | none | H₂O, HCl, methanol |
| Equilibrium | typically irreversible | typically reversible (need byproduct removal) |
| Industrial example | LDPE, HDPE, PP, PS, PVC | nylon, PET, polycarbonate, polyimide |

---

## §2 Molecular weight distribution + measurement

### §2.1 The averages

For a polymer sample with mole fraction x_i of n-mer:

| Average | Definition | Sensitive to |
|---------|-----------|--------------|
| Mn (number-average) | Σ x_i M_i / Σ x_i | low-MW tail |
| Mw (weight-average) | Σ x_i M_i² / Σ x_i M_i | high-MW tail |
| Mz | Σ x_i M_i³ / Σ x_i M_i² | extreme high-MW tail |
| Mv (viscosity-average) | ((Σ x_i M_i^(1+a)) / Σ x_i M_i)^(1/a), a = Mark-Houwink exponent | mid-range, closest to Mw |

Polydispersity index: **Đ = Mw / Mn**. Đ = 1.0 is monodisperse (only achievable for biological polymers like proteins, DNA); Đ = 2.0 is the most-probable (step-growth ideal); Đ > 3 is broad.

### §2.2 Industrial measurement — SEC / GPC

Size-Exclusion Chromatography (SEC, also called Gel Permeation Chromatography GPC):
- Packed column with porous beads
- Higher-MW polymer elutes earlier (excludes from small pores)
- Detector: refractive index, UV, multi-angle laser light scattering (MALLS)
- Calibration: narrow-PDI polystyrene standards (5k, 20k, 100k, 500k g/mol)
- Output: Mn, Mw, Đ for the sample

Reference standards: NIST SRM 706 / 705 / 1483 (polystyrene narrow standards, Mw = 27.6k, 17.5k, 32k respectively).

### §2.3 Why Đ matters

| Đ | Effect | Example |
|---|--------|---------|
| 1.05 | Sharp Tg, narrow rheology, predictable processing | living-anionic PS |
| 2.0 | Standard industrial; good processing window | nylon, PET |
| 3.5-5 | Broad processing window; LCB (long-chain branching) common | LDPE |
| > 5 | Very broad; bimodal common | UHMWPE (Mw > 3 × 10⁶ g/mol) |

For Kevlar 49 (Mw ~ 10⁶ g/mol, Đ ~ 1.5-2): the high MW gives σ_f ~ 3.6 GPa via chain-extension-fully-extended (the *liquid crystalline* nature of PPTA dope in sulfuric acid).

---

## §3 Tg, Tm, and crystallinity

### §3.1 Glass transition Tg

Tg is the temperature where amorphous polymer transitions from glassy (rigid, brittle) to rubbery (compliant, viscoelastic). Operationally:
- DSC (differential scanning calorimetry): step in heat capacity Cp by ~ 0.3 J/g/K
- DMA (dynamic mechanical analysis): peak in tan δ
- Dilatometry: change in thermal-expansion coefficient α

Tg depends on:
- Backbone flexibility (low Tg = flexible: aliphatic C-C; high Tg = rigid: aromatic, conjugated)
- Side-group bulk (bulky side group → high Tg, e.g., PMMA)
- Cohesive energy (H-bonding, polar groups → high Tg)
- Cross-link density (more cross-links → higher Tg)
- MW (Fox-Flory: Tg = Tg(∞) - K/Mn for Mn > critical)

| Polymer | Tg (°C) | Reason |
|---------|---------|--------|
| Silicone (PDMS) | -125 | flexible Si-O backbone, low cohesive |
| Polybutadiene (cis) | -100 | flexible C=C backbone |
| Polyethylene (HDPE) | -120 | flexible, low cohesive |
| Polypropylene | -10 | methyl side group adds slight rigidity |
| Polystyrene | 100 | bulky phenyl + low MW dispersion |
| PVC | 80 | dipole-dipole interactions |
| PMMA | 105 | bulky -CO-O-CH₃ side group |
| PET | 70-80 | aromatic + ester |
| Nylon-6 | 50 | H-bond + aliphatic |
| Nylon-6,6 | 50-65 | H-bond stronger than nylon-6 |
| Polycarbonate (BPA-PC) | 145 | bulky aromatic |
| PEEK | 143 | rigid aromatic with ether/ketone |
| Polyimide (Kapton) | 360-400 | rigid imide-aromatic |
| PPTA (aramid) | — (no Tg; thermal decomposition at ~ 770 K precedes any glass transition) | very rigid aromatic, fully extended chain |

### §3.2 Melting point Tm

Tm is the temperature at which the crystalline phase melts. Only semicrystalline polymers have Tm (fully amorphous polymers have only Tg).

For semicrystalline polymers, **Tm > Tg always** (typically Tm ≈ 1.4 × Tg in Kelvin, by Boyer-Kauzmann rule of thumb).

| Polymer | Tg (°C) | Tm (°C) | Crystallinity (typ.) |
|---------|---------|---------|----------------------|
| LDPE | -120 | 105-115 | 50-60% |
| HDPE | -120 | 130-135 | 70-90% |
| UHMWPE | -120 | 132-138 | 70-85% |
| PP (isotactic) | -10 | 165-175 | 50-70% |
| PET | 70-80 | 250-260 | 30-40% (oriented) |
| Nylon-6 | 50 | 220 | 30-40% |
| Nylon-6,6 | 50-65 | 265 | 35-45% |
| PEEK | 143 | 343 | 30% |
| PVDF (poly vinylidene fluoride) | -35 | 175 | 50-70% |

### §3.3 Cross-link density → high Tg, no Tm

A thermoset (cross-linked polymer) has no Tm — heating decomposes the network. Tg is shifted up:

- Epoxy (DGEBA + DETA): Tg ~ 100 °C (low-cross-link); Tg ~ 200 °C (high-cross-link)
- Phenolic (bakelite): Tg ~ 130-180 °C
- Polyurethane elastomer: Tg ~ -60 °C (soft segment); Tg ~ 100 °C (hard segment) → 2-phase
- Vulcanized rubber: Tg ~ -60 °C (NR), -50 °C (SBR); Tm absent

Cross-link density (mol crosslinks per g) determines:
- Tg increase rate ≈ kT² × (cross-link density) — Couchman-Karasz
- Equilibrium modulus E (rubbery plateau): E = 3 ρ R T / Mc, where Mc = molecular weight between cross-links
- Swelling in solvent (Flory-Rehner): Q ∝ (1 / (Mc^(1/3)))

---

## §4 Linkage chemistry — the 4 workhorse classes

### §4.1 Ester linkage (-CO-O-)

- Hydrolyzable (sensitive to water + acid/base)
- PET, PBT, PC (polycarbonate), PLA (biodegradable)

PET hydrolysis kinetics (acidic, 85 °C): k = 10⁻⁶ to 10⁻⁵ /s; activation energy E_a ≈ 80-100 kJ/mol (Marshall et al. 1988). This is why PET bottles slowly hydrolyze over decades in landfill, but PET films can be chemically depolymerized via methanolysis → DMT + EG (industrial recycling).

### §4.2 Amide linkage (-CO-NH-)

- Strong H-bonding (between C=O of one chain and N-H of another)
- Higher Tm than ester (nylon-6,6 Tm 265 °C vs PET 255 °C)
- Aromatic amide (-CO-NH-phenyl-) is extremely rigid → aramid

Hydrolysis is slow at room T (nylon stockings last decades), but rapid at high T + strong acid (HCl boil dissolves nylon in minutes; this is why aramid + concrete fire-protection works).

### §4.3 Imide linkage (-CO-N(R)-CO-)

- Rigid cyclic 5-membered imide group between two aromatic units
- Polyimide (Kapton, Vespel) Tg 360-400 °C; UL94 V-0 fire rating; aerospace use
- Synthesis: dianhydride + diamine → polyamic acid → cure (imidize) at 250-350 °C

Use: flexible PCB substrate (Kapton), aerospace insulation, MEMS sacrificial layer.

### §4.4 Urea linkage (-NH-CO-NH-)

- Two N-H per group → strong bidentate H-bonding
- Polyurea, polyurethane (PU; -NH-CO-O-) hybrid systems
- Mass-market: spray-on PU coatings, rigid PU foam (insulation), flexible PU foam (cushion)

PU 2-component systems:
- A side: polyisocyanate (MDI or TDI)
- B side: polyol (polyether or polyester polyol) + catalyst + blowing agent

Rapid reaction (minutes); cast or RIM molded; tunable from foam to elastomer to thermoplastic.

### §4.5 Other notable linkages

- Ether (-O-): polyacetal (POM); polyethylene oxide (PEO/PEG)
- Carbonate (-O-CO-O-): polycarbonate
- Sulfone (-SO₂-): polyethersulfone (PES); polysulfone (PSU)
- Siloxane (-Si-O-): silicone rubber (PDMS)
- Phenolic (phenol-CH₂-phenol-...): bakelite

---

## §5 Biodegradable polymers — PLA, PHA, PBS

### §5.1 PLA (Polylactic acid)

- Monomer: lactic acid (or its dimer lactide)
- Source: fermentation of corn starch / sugarcane (cross-domain: hexa-bio/fermentation)
- Linkage: ester
- Tg: 60-65 °C
- Tm: 155-180 °C (depending on D/L ratio)
- Crystallinity: 30-40% (PLLA, isotactic L)
- Biodegradation: industrial compost (50-60 °C, humid, microbial) → CO₂ + H₂O in 30-90 days; home compost insufficient (PLA needs > 50 °C industrial composter)

Producers: NatureWorks (Cargill), Total Corbion, Sulzer Chemtech. Global production: ~ 300 kt/yr in 2024.

Use: 3D-printing filament, packaging film, single-use cutlery, biomedical sutures (PLA bioabsorbs over months).

### §5.2 PHA (Polyhydroxyalkanoate)

- Microbially produced inside bacteria (intracellular storage granules); cross-domain hexa-bio fermentation
- Linkage: ester (β-hydroxy ester)
- Family: PHB (poly-3-hydroxybutyrate; Tm 175 °C, Tg 5 °C); PHBV (with valerate co-monomer; tunable Tm + flex)
- Biodegradation: marine + soil compostable → CO₂ + H₂O in 6-12 months
- Cost: 3-5× PLA cost; smaller market

Producers: Danimer Scientific, RWDC, Mango Materials, BASF (in venture). Global production: < 50 kt/yr in 2024.

### §5.3 PBS (Polybutylene succinate)

- Step-growth from succinic acid + 1,4-butanediol (both can be bio-sourced via fermentation)
- Tg: -32 °C
- Tm: 114 °C
- More flexible than PLA, similar to LDPE in handling
- Biodegradable: industrial compost-similar to PLA

Producers: Showa Denko, Mitsubishi Chemical, PTT MCC Biochem. Global: ~ 50 kt/yr.

### §5.4 Cross-link to hexa-bio fermentation

Per `USER_ACTION_REQUIRED.md §6` and `AGENTS.md` sister-repo discipline: biodegradable-plastics depth chapter (Phase D candidate, see `BIODEGRADABLE-PLASTICS.md` stub) will use **CLI integration over Python wrappers** to call `hexa-bio fermentation` for the microbial-production side. Don't reimplement bio fermentation in-tree.

---

## §6 Aramid (PPTA) — the high-σ champion

### §6.1 Synthesis

DuPont's Kwolek process (1965, polyparaphenylene terephthalamide):

```
   p-phenylenediamine   +  terephthaloyl chloride
   H₂N-C₆H₄-NH₂              ClCO-C₆H₄-COCl
              ↓ (anhydrous HMPA or DMAc/CaCl₂ solvent, < 10 °C)
   -NH-C₆H₄-NH-CO-C₆H₄-CO- ... + 2HCl    (PPTA)
              ↓ (spin from concentrated sulfuric acid, > 18 wt%)
   liquid-crystalline nematic dope → wet-spun fiber → heat-treated → Kevlar/Twaron
```

The **liquid-crystalline** (nematic) state of PPTA in conc. H₂SO₄ is what enables fully-extended chains in the fiber → ultra-high σ_f.

### §6.2 Mechanical properties (Kevlar 49)

| Property | Value | Source |
|----------|-------|--------|
| σ_f (tensile strength) | 3.6 GPa | DuPont datasheet |
| E (modulus) | 124 GPa | DuPont |
| ρ (density) | 1.44 g/cm³ | DuPont |
| Specific σ | 2500 kN·m/kg | calculated |
| Tm | — (decomposition ~ 770 K before melting) | DuPont |
| Tg | — (none observed) | DuPont |

Compare to L1 (Frenkel σ_th ~ E/10 = 12.4 GPa) — Kevlar 49 is ~ 3.6 / 12.4 = 30% of theoretical. The other 70% is defect-limited (chain-end voids, oriented-domain misalignment, MW dispersion).

### §6.3 Use

Body armor (NIJ III-A vests, helmet), ballistic windows, fiber-reinforced composites (aircraft propeller blade, F1 chassis), rope (yacht standing rigging), tire cord (Kevlar belt + carcass), aerospace honeycomb core.

---

## §7 Epoxy — the thermoset workhorse

### §7.1 Chemistry

Bisphenol-A diglycidyl ether (DGEBA) + diamine hardener:

```
   bisphenol-A → DGEBA (2 epoxide rings)
                   ↓ (mixed with DETA or DDM diamine, R.T. or 80-120 °C cure)
   epoxide ring + N-H → β-hydroxy amine + new N-H
                   ↓ (each diamine has 4 N-H; each DGEBA has 2 epoxide)
   3D cross-linked network → cured epoxy thermoset
```

Stoichiometry: DGEBA equivalents = diamine N-H equivalents. Off-stoichiometry → residual unreacted; reduces Tg and σ.

### §7.2 Property tuning

| Composition | Tg (°C) | σ_f (MPa) | Use |
|-------------|---------|-----------|-----|
| DGEBA + DETA (aliphatic amine) | 80-100 | 50-70 | adhesive, hobby |
| DGEBA + DDM (aromatic amine MDA) | 120-150 | 70-90 | structural |
| TGMDA + DDS (aerospace MDA-tetra) | 180-220 | 100-130 | aerospace prepreg |
| Epoxy novolac + DDS | 200-250 | 100-150 | high-T electronic |

Aerospace prepregs (Hexcel HexPly 8552, Toray T800S/3900-2): TGMDA epoxy + DDS aromatic amine; Tg ~ 200 °C; σ ~ 100-130 MPa; cured under autoclave at 175-180 °C / 8 bar / 2 hr.

---

## §8 Microplastics — POL group environmental fate

### §8.1 What microplastics are

Polymer fragments < 5 mm (size convention: "microplastic" 1 µm - 5 mm; "nanoplastic" < 1 µm). Composition mirrors the macro-plastic mix in waste streams:
- Polyethylene (PE, mostly LDPE) — 33%
- Polypropylene (PP) — 24%
- Polystyrene (PS) — 13%
- PET — 8%
- PVC — 7%
- Polyamide / nylon — 6%
- PMMA, PUR, ABS, others — 9%

Source: Jambeck et al. 2015 *Science* 347, 768 — global mismanaged plastic waste mass-balance estimate.

### §8.2 Environmental fate axes

- **Partition coefficient** K_d — sorption of POPs (persistent organic pollutants like PCBs, PAHs, DDT) onto microplastic surface. Larger for hydrophobic surfaces (PE > PS > PET).
- **Biofilm colonization** — microbial biofilm forms on microplastic in days (Zettler et al. 2013 *Environ. Sci. Technol.* 47, 7137); the "plastisphere"
- **Trophic transfer** — copepod → fish → human; microplastic detected in human blood (Leslie et al. 2022 *Environ. Int.* 163, 107199)
- **Atmospheric transport** — microplastic in remote Arctic snow, Pyrenees mountain rainfall (Allen et al. 2019 *Nat. Geosci.* 12, 339)

### §8.3 Cross-link to hexa-earth

Per `USER_ACTION_REQUIRED.md §6`: microplastics chapter cross-links to `hexa-earth` (when authored) for the **planetary-fate** side. The chemistry (POL group) stays here; the global mass-balance lives in hexa-earth.

---

## §9 The recycling × entropy connection (cross-link to recycling verb)

From `LIMIT_BREAKTHROUGH.md §L12`: polymer recycling has a **Gibbs ΔS_mix HARD wall**. Mixed-polymer (e.g., PE/PP/PS curbside bale) recycling requires:

$$\Delta S_{mix} = k_B \sum n_i \ln(x_i)$$

This is the thermodynamic floor: separation energy per mole is bounded below by RT · |ΔS_mix|. For a 3-polymer mix at 33% each: |ΔS_mix| / R = 1.10; at room T (298 K): minimum 2.7 kJ/mol to separate. Real-world is 100-1000× this floor due to engineering inefficiency.

This is why mechanical recycling tops out at ~ 30-50% effective yield (per stream), and chemical recycling (depolymerization to monomer + repolymerization) is needed for higher yield but uses MORE energy.

---

## §10 Cross-links

| Cross-ref | Type | Why |
|-----------|------|-----|
| `aramid/aramid.md` | spec doc | aramid verb headline |
| `ARAMID.md` | upstream chapter | 19 kB |
| `epoxy/epoxy.md` | spec doc | epoxy verb |
| `EPOXY.md` | upstream chapter | 19 kB |
| `nylon/nylon.md` | spec doc | nylon verb |
| `NYLON.md` | upstream chapter | 20 kB |
| `pet_film/pet_film.md` | spec doc | PET verb |
| `PET-FILM.md` | upstream chapter | 19 kB |
| `microplastics/microplastics.md` | spec doc | microplastics verb (absorbed from hexa-medic 2026-05-12) |
| `recycling/recycling.md` | substrate | polymer recycling Gibbs floor |
| `RECYCLING.md` | upstream chapter | 81 kB |
| `LIMIT_BREAKTHROUGH.md` | real-limits | L1 Frenkel σ_th / L2 practical σ / L12 ΔS_mix |
| `hexa-bio` | sister repo | biodegradable-plastics (PLA, PHA, PBS) fermentation side |
| `hexa-earth` | sister repo | microplastics planetary-fate side |

---

## §11 References

- **Mark H.F. et al.** (eds.) (2004) *Encyclopedia of Polymer Science and Technology*, 4th ed., Wiley — the canonical polymer reference
- **Painter P.C. & Coleman M.M.** (2008) *Essentials of Polymer Science and Engineering*, DEStech Publications
- **Sperling L.H.** (2005) *Introduction to Physical Polymer Science*, 4th ed., Wiley
- **Carothers W.H.** (1929) *J. Am. Chem. Soc.* 51, 2548 — step-growth polymerization, Carothers equation
- **Flory P.J.** (1953) *Principles of Polymer Chemistry*, Cornell University Press — the foundation
- **Kwolek S.L.** (1972) U.S. Patent 3,671,542 — PPTA / Kevlar synthesis
- **Frenkel J.** (1926) *Z. Phys.* 37, 572 — theoretical strength σ_th = E/10
- **Marshall I.A., Petrov A.A. & Kalinin A.M.** (1988) — PET hydrolysis kinetics
- **Couchman P.R. & Karasz F.E.** (1978) *Macromolecules* 11, 117 — Tg of blends + cross-linked systems
- **Jambeck J.R. et al.** (2015) *Science* 347, 768 — global plastic waste mass-balance
- **Zettler E.R., Mincer T.J. & Amaral-Zettler L.A.** (2013) *Environ. Sci. Technol.* 47, 7137 — plastisphere biofilm
- **Leslie H.A. et al.** (2022) *Environ. Int.* 163, 107199 — microplastic in human blood
- **Allen S. et al.** (2019) *Nat. Geosci.* 12, 339 — atmospheric microplastic in Pyrenees
- **DuPont Kevlar 49 product bulletin**
- **DSM Dyneema SK99 product bulletin**
- **Toray Carbon Fiber T1100G datasheet**
- **Hexcel HexPly 8552 prepreg datasheet**
- **NatureWorks Ingeo PLA grades catalog**
- **CRC Handbook**, 105th ed. (2024)
- **ASM Handbook vol. 21** Composites (ASM International 2001)

---


- Polymer property data from CRC Handbook, ASM Handbook vol. 21, Mark's Encyclopedia, and manufacturer datasheets (DuPont, BASF, Toray, DSM, NatureWorks). **No values lattice-derived.**
- Aramid Kevlar 49 σ_f = 3.6 GPa is DuPont's published spec; not a lattice prediction.
- Biodegradable-polymer production volumes (PLA 300 kt/yr, PHA < 50 kt/yr, PBS ~ 50 kt/yr) are 2024 market estimates; vary 20-30% by source.
- Cross-domain microplastics fate (atmospheric, marine, human blood) cites primary literature with explicit citations.
- The Frenkel σ_th = E/10 ratio (L1 HARD wall) is theoretical (Frenkel 1926); Kevlar 49 reaching 30% of theoretical is the *engineering-frontier* observation, not a lattice prediction.
- No n=6 lattice anchoring of any polymer parameter.

---

*Document authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase A elevation — polymer chemistry deep-dive chapter, complementing the existing per-verb POL group chapters (ARAMID, EPOXY, NYLON, PET-FILM) with chain-vs-step-growth + Tg/Tm + linkage chemistry + biodegradable polymers + microplastics environmental fate.*
