# NOVEL_ROADMAP — brainstorming ledger for future NOVEL.md rounds

> **Companion to**: [`NOVEL.md`](NOVEL.md) — this is the *think-tank* doc.
> **Status**: 🧠 BRAINSTORM (none authored into NOVEL.md until a future
> round; this doc enumerates the design space, not the ledger).
> **Created**: 2026-05-13 · **Author**: 박민우

## 0. Mission

Catalog the candidate design space hexa-matter could populate in future
NOVEL.md rounds. Each row is a *slot* — a class + target + hypothesis
sketch + a falsifier template — not yet a registered candidate. Future
rounds promote selected slots to `hxm-<class>-<target>-<NNN>` entries in
NOVEL.md with full SPEC_FIRST + DESIGN-status + quantitative-falsifier

## 0.1 What "exhaustion" means here

Brainstorming exhaustion = the union of (a) every material innovation
frontier with a published peer-reviewed activity ledger in 2024-2026,
(b) every cross-class hybrid that two existing NOVEL.md classes obviously
permit, and (c) every commercially-active vendor / lab / consortium that
has named a target with a quantitative threshold. This file is dense by
design; it is a *menu*, not a roadmap to ship.

## 0.2 Honesty rails (verbatim)

- Every candidate slot must start at `status: DESIGN` when promoted to
  NOVEL.md. Never `VERIFIED` / `EXTERNAL-VERIFIED` without external lab
- Every slot must have a *quantitative* falsifier template (number +
  condition + pass/fail boundary) — qualitative claims rejected.
- Anti-claims preserved verbatim: LK-99 NOT REPRODUCED · metallic-H at
  ambient UNPROVEN · CNT yarn 80 GPa lab-mm only · magic-MOF DAC $100/t
  UNPROVEN · Re-free SX UNVERIFIED · marine-biodegradable PHA UNVERIFIED ·
  GNoME predicted-not-synthesized · LK-99 / room-T SC HARD_WALL.
- Sister boundary discipline (per CROSS_LINK.md): material-layer slots
  only; device/cell/fab work belongs to hexa-chip / hexa-energy / hexa-rtsc.
- LATTICE_POLICY §1.2/§1.3 — real-limits-first; n=6 lattice is auxiliary.

## 0.3 Existing NOVEL.md inventory (12 candidates, 11 distinct classes)

| § | class-tag | candidate | status |
|---|-----------|-----------|--------|
| 3.13 | bmg | `hxm-bmg-zr-001` | DESIGN |
| 3.14 | aero | `hxm-aero-graphene-001` | DESIGN |
| 3.15 | mxene | `hxm-mxene-ti3c2-001` · `hxm-mxene-mo2c-001` | DESIGN |
| 3.16 | bio | `hxm-bio-pha-marine-001` | DESIGN |
| 3.17 | liq | `hxm-liq-gain-001` | DESIGN |
| 3.18 | anode | `hxm-anode-sigr-001` | DESIGN |
| 3.19 | cat | `hxm-cat-fenc-001` | DESIGN |
| 3.20 | ferro | `hxm-ferro-hzo-001` | DESIGN |
| 3.21 | thermo | `hxm-thermo-snse-001` | DESIGN |
| 3.22 | membrane | `hxm-membrane-zif8-001` | DESIGN |
| 3.23 | quantum | `hxm-quantum-sicvv-001` | DESIGN |

NOVEL.md class-tag table reserves additionally: `sc`, `cath`, `se`, `pv`,
`hea`, `mof`, `2d`, `pero`, `mag`, `ela`, `adh`, `pol`, `cer`, `cnt`,
`meta`, `top`, `pcm`, `piezo`, `spin`, `photovoltaic` (alias of pv).
This roadmap proposes additional class-tags (see §3 introduction).

---

## 1. Selection-criteria rubric

When promoting a slot to NOVEL.md, judge against:

| Axis | High | Medium | Low |
|------|------|--------|-----|
| Falsifier *quantitative*? | yes, ≤ 2 numbers | one number | none |
| Falsifier *condition*-specified? | T, P, atm, t, n | partial | absent |
| Independent benchmark exists? | NIST / CRC / NREL / certified | journal+vendor | only one paper |
| Cross-class hybrid? | yes (interesting) | no | n/a |
| HARD_WALL adjacency? | far from wall | near (caution) | over the wall (REJECT) |
| Sister-domain confusion? | clean material-layer | needs annotation | wrong domain |

A slot scores 6/6 "High" is a Tier-1 promotion candidate. 4/6+ is Tier-2.
< 4/6 stays in this roadmap for further refinement.

## 1.1 What makes a slot ineligible

- Already canonical in NIST / MP / OMat24 (these are *known*, not novel)
- HARD_WALL claim (e.g., room-T atmospheric-pressure superconductor without
  ARPES + Meissner + transport simultaneously)
- Falsifier reduces to "if synthesis succeeds → success" (no rigor)
- Pure device claim (belongs to a sister repo)

---

## 2. Proposed new class-tags

For roadmap coverage, the following class-tags are proposed (some are
extensions of existing tags):

| tag | domain |
|-----|--------|
| `bat-anode-li` | Li-metal anode |
| `bat-anode-na` | Na-ion hard-carbon anode |
| `bat-cath-drx` | disordered-rocksalt cathode |
| `bat-cath-lis` | Li-S cathode |
| `bat-cath-naion` | Na-ion cathode (Prussian-blue analog) |
| `bat-flow` | redox-flow active material |
| `pv-tandem` | perovskite-Si tandem stack |
| `pv-csts` | kesterite Cu₂ZnSnS₄ thin-film |
| `pv-organic` | Y6-class organic photovoltaic |
| `fc-sofc` | intermediate-T SOFC cathode |
| `fc-aem` | anion-exchange membrane |
| `h2-store` | hydrogen storage |
| `h2-elec` | water-electrolysis electrode |
| `co2-red` | CO₂ reduction electrocatalyst |
| `co2-cap` | DAC sorbent |
| `n2-red` | N₂ reduction (NH₃ synthesis) |
| `te-half` | half-Heusler thermoelectric |
| `te-skutt` | skutterudite thermoelectric |
| `mcal` | magnetocaloric |
| `magnon` | spin-wave / YIG |
| `skyrm` | skyrmion-bearing magnetic |
| `armag` | antiferromagnetic memory |
| `display-led` | LED emitter (micro-LED / OLED / Per-LED) |
| `display-lc` | display LC |
| `cf` | carbon-fiber precursor |
| `uhtc` | ultra-high-temp ceramic |
| `cement` | low-CO₂ cement |
| `armor` | transparent / energy-absorbing armor |
| `vitrimer` | dynamic-covalent thermoset |
| `selfheal` | self-healing material |
| `sma` | shape-memory alloy / polymer |
| `bone` | bone-scaffold biomaterial |
| `implant` | dental / orthopedic implant material |
| `eskin` | electronic-skin sensor |
| `am-alloy` | additive-manufacturing alloy |
| `am-resin` | DLP/SLA photopolymer |
| `am-ceram` | binder-jet / vat-photopol ceramic |
| `rram` | resistive switching memory |
| `neuromorph` | memristive synapse |
| `h2o-harv` | atmospheric water harvesting |
| `desal` | desalination membrane |
| `recycle-cat` | depolymerization catalyst |
| `ec-glass` | electrochromic glass |
| `bipv` | building-integrated PV glass |
| `rcc` | radiative-cooling coating |
| `acoustic` | acoustic metamaterial |
| `cryo` | cryogenic structural alloy |
| `radshield` | radiation shield |
| `detector` | photon / particle detector |
| `dna-storage` | DNA digital storage substrate |
| `holo` | holographic storage substrate |
| `weyl` | Weyl semimetal |
| `flatband` | magic-angle-graphene-class flat band |
| `tdmeta` | time-domain metamaterial |
| `mycel` | mycelium-based composite |
| `algae` | algae-derived plastic |
| `bio-electron` | biodegradable electronics |
| `softrobotics` | soft-robotics actuator |

---

## 3. Per-class slot menu (~140 slots over ~30 classes)

Each slot below: ID stub · hypothesis (1 sentence) · falsifier prototype
(quantitative) · risk-flags. None of these are NOVEL.md entries; they are
*slots* awaiting promotion + full hxm-* numbering + ledger review.

### 3.A — Energy storage & power

#### 3.A.1 Cathodes (`bat-cath-*`)
- `bat-cath-drx-001` Li-Mn-Nb-Ti disordered rock-salt cathode. **F**: specific
  capacity < 280 mAh/g @ 0.1C OR average voltage < 3.4 V vs Li/Li⁺ in 1M LiPF₆
  EC/DMC → FAIL. **Risks**: oxygen-loss HARD_WALL on 1st cycle; Mn dissolution.
- `bat-cath-lis-001` Sulfurized polyacrylonitrile (S-PAN) cathode. **F**:
  cycle 1 → cycle 500 retention < 70% @ 1C OR areal capacity < 4 mAh/cm² →
  FAIL. **Risks**: shuttle effect SOFT_WALL; Li-metal-anode coupling.
- `bat-cath-naion-001` Prussian-blue-analog Na₂FeFe(CN)₆ for Na-ion. **F**:
  capacity @ -20 °C < 80% RT capacity OR self-discharge > 5%/mo → FAIL.
  **Risks**: water-content sensitivity; vacancy formation.
- `bat-cath-kion-001` K-Mn-Fe Prussian-blue cathode for K-ion. **F**: capacity
  < 140 mAh/g @ 0.1C OR cycle-100 retention < 80% → FAIL. **Risks**: K⁺ ionic
  radius vs Mn-Fe lattice spacing; humidity stability.

#### 3.A.2 Anodes (`bat-anode-*`)
- `bat-anode-li-metal-001` Pressed Li-metal foil 50 μm on 3D Cu current
  collector. **F**: Coulombic efficiency < 99.5% after 500 cycles in
  carbonate electrolyte OR dendrite penetration to separator → FAIL.
  **Risks**: SEI instability HARD_WALL; commercial cell engineering belongs
  to hexa-energy (CROSS_LINK §3.3).
- `bat-anode-na-hardcarbon-001` Sucrose-derived hard carbon, 1300 °C
  pyrolysis. **F**: reversible capacity < 300 mAh/g @ 0.1C OR ICE < 80% →
  FAIL. **Risks**: precursor purity drift; Na+ insertion plateau width.
- `bat-anode-nbo-001` Wadsley-Roth TiNb₂O₇ anode for fast charge. **F**:
  10C rate retention < 85% OR voltage hysteresis > 50 mV → FAIL. **Risks**:
  electronic conductivity HARD_WALL; titanium reduction.

#### 3.A.3 Solid electrolytes (`se`)
- `se-li10gps-001` Li₁₀GeP₂S₁₂ (LGPS) thiophosphate. **F**: σ_ionic @ 25 °C
  < 6 mS/cm OR electrochemical window < 4.5 V vs Li/Li+ → FAIL. **Risks**:
  H₂S evolution on air contact HARD_WALL; Ge cost.
- `se-argyrodite-001` Li₆PS₅Cl argyrodite. **F**: σ_ionic < 4 mS/cm @ RT
  OR Li-metal stripping current density < 1 mA/cm² → FAIL. **Risks**:
  H₂S; cathode oxidation interface.
- `se-halide-001` Li₃YCl₆ halide SE. **F**: σ < 1 mS/cm OR oxidation onset
  < 4.2 V vs Li → FAIL. **Risks**: Li-metal compatibility UNVERIFIED.

#### 3.A.4 Photovoltaic (`pv-*`)
- `pv-tandem-001` Perovskite-Si 2T tandem (1.68 eV / 1.12 eV). **F**:
  certified-aperture PCE < 32% OR T80 < 1000 h @ ISOS-L1 → FAIL. **Risks**:
  perovskite Br/I segregation; SAM contact ageing.
- `pv-allper-001` All-perovskite 4T tandem (1.78 / 1.25 eV). **F**: certified
  PCE < 29% OR T80 < 800 h → FAIL. **Risks**: Sn²⁺ → Sn⁴⁺ oxidation HARD_WALL.
- `pv-csts-001` Cu₂ZnSn(S,Se)₄ kesterite thin-film. **F**: certified PCE < 13%
  OR open-circuit-voltage deficit > 0.5 V → FAIL. **Risks**: Cu/Zn antisite
  disorder HARD_WALL.
- `pv-organic-001` Y6-class small-molecule OPV. **F**: certified PCE < 19%
  OR T80 (1-sun, AM1.5) < 5000 h → FAIL. **Risks**: morphology drift; encap
  required for >5 yr operation.
- `pv-thinfilm-cdte-001` CdTe with selenium grading, NREL-style. **F**:
  certified PCE < 23% → FAIL. **Risks**: Cd regulatory headwinds.

#### 3.A.5 Fuel cells (`fc-*`)
- `fc-sofc-bscf-001` (Ba,Sr)(Co,Fe)O₃ SOFC cathode @ 600 °C. **F**:
  Area-specific resistance > 0.15 Ω·cm² @ 600 °C OR Cr poisoning loss
  > 30% over 1000 h → FAIL. **Risks**: chromium poisoning HARD_WALL;
  thermal-cycling.
- `fc-aem-pap-tp-85-001` Poly(arylpiperidinium) AEM. **F**: σ_OH⁻ < 0.1 S/cm
  @ 60 °C OR durability < 1000 h @ 200 mA/cm² → FAIL. **Risks**: cationic
  group degradation in alkaline; carbonate uptake.

#### 3.A.6 Redox flow (`bat-flow-*`)
- `bat-flow-org-001` 2,6-DHAQ + methyl viologen organic flow. **F**: energy
  density < 30 Wh/L OR capacity fade > 0.05%/day → FAIL. **Risks**: organic
  active-material crossover; pH window.

#### 3.A.7 Supercapacitors (`cap-*`)
- `cap-mxene-001` Ti₃C₂T_x MXene supercap electrode. **F**: gravimetric
  capacitance < 350 F/g @ 1 A/g in 1 M H₂SO₄ OR cycle-10k retention < 90% →
  FAIL. **Risks**: oxidation in ambient; flake-restacking.

### 3.B — Catalysis & energy conversion

#### 3.B.1 Non-PGM ORR catalysts (`cat-*`)
- `cat-sac-fe-001` Fe single-atom catalyst on N-doped graphene (extends
  `hxm-cat-fenc-001`). **F**: E₁/₂ < 0.80 V vs RHE in 0.5 M H₂SO₄ → FAIL.
  **Risks**: Fe leaching; Fe-N₄ vs Fe-N₃-C coordination uncertainty.
- `cat-mof-mn-001` Mn-based MOF derived ORR catalyst. **F**: alkaline E₁/₂
  < 0.85 V vs RHE OR 100 h durability loss > 20 mV → FAIL.

#### 3.B.2 CO₂ reduction (`co2-red-*`)
- `co2-red-cu-001` Cu nanocube selective for C₂H₄. **F**: Faradaic efficiency
  toward C₂H₄ < 60% @ -1.0 V vs RHE OR partial current density < 250 mA/cm² →
  FAIL. **Risks**: surface reconstruction; HER competition.
- `co2-red-ag-sn-001` Ag-Sn alloy for HCOO⁻. **F**: FE_HCOO < 90% OR
  potential window < 200 mV → FAIL.

#### 3.B.3 H₂ evolution (`h2-elec-*`)
- `h2-elec-nimo-001` NiMo HER cathode in alkaline AEM cell. **F**: overpotential
  @ 100 mA/cm² > 100 mV vs RHE OR stability < 2000 h → FAIL. **Risks**: Mo
  leaching; Ni coarsening.
- `h2-elec-iro2-doped-001` Ir-Ru oxide OER anode. **F**: η @ 10 mA/cm² > 250 mV
  OR Ir loading > 1 mg/cm² for commodity scale → FAIL. **Risks**: Ir scarcity
  HARD_WALL.

#### 3.B.4 N₂ reduction (`n2-red-*`)
- `n2-red-ru-cluster-001` Ru subnano-cluster N₂RR. **F**: FE_NH₃ < 20% @ -0.3 V
  vs RHE OR NH₃ yield rate < 50 μg/h·mg → FAIL. **Risks**: contamination from
  ambient NH₃ HARD_WALL; isotopic-labeling required.

#### 3.B.5 Photocatalysts
- `cat-photo-cds-sb-001` CdS-Sb₂S₃ tandem photocatalyst for water splitting.
  **F**: solar-to-hydrogen efficiency < 5% (10 sun, simulated) OR durability
  < 100 h → FAIL. **Risks**: Cd toxicity regulatory.

### 3.C — Thermal management

#### 3.C.1 Thermoelectrics (`te-*`)
- `te-half-zrnisn-001` ZrNiSn-based half-Heusler. **F**: ZT @ 800 K < 1.5 OR
  thermal stability at 1000 K < 100 h → FAIL.
- `te-skutt-cosb3-001` Filled CoSb₃ skutterudite. **F**: ZT @ 500 K < 1.4 OR
  contact resistance > 5 μΩ·cm² → FAIL.
- `te-bisbte-001` Nanostructured BiSbTe @ 300 K. **F**: ZT @ RT < 1.2 OR
  mechanical strength σ < 30 MPa → FAIL.
- `te-org-pedot-001` PEDOT:PSS-based organic TE. **F**: power factor < 100
  μW/(m·K²) @ 300 K OR film thickness uniformity > 10% → FAIL.

#### 3.C.2 Phase-change materials (`pcm-*`)
- `pcm-salt-cacl-001` CaCl₂·6H₂O thermal-energy storage. **F**: latent heat
  < 180 J/g OR cycle-1000 retention < 85% → FAIL. **Risks**: incongruent
  melting; subcooling.
- `pcm-sugar-erythritol-001` Erythritol PCM for medium-T storage. **F**: T_m
  outside 117 ± 3 °C OR thermal cycling > 500 cycles fail → FAIL.

#### 3.C.3 Radiative cooling (`rcc-*`)
- `rcc-paint-baso4-001` BaSO₄-acrylic paint, sub-ambient daytime cooling. **F**:
  net cooling power < 60 W/m² at noon on a clear day, AM1.5 OR solar
  reflectance < 95% → FAIL. **Risks**: dirt accumulation degradation.

#### 3.C.4 Insulation (`insul-*`)
- `insul-vip-001` Vacuum insulated panel with fumed silica core. **F**:
  thermal conductivity k > 0.005 W/(m·K) OR vacuum lifetime < 20 yr → FAIL.

### 3.D — Quantum, spintronics, sensing

#### 3.D.1 Quantum-defect hosts (`quantum`)
- `quantum-si-donor-001` Si:P donor qubit, isotopically purified ²⁸Si. **F**:
  T₂ < 10 s @ 100 mK OR readout fidelity < 99% → FAIL. **Risks**: ²⁸Si
  enrichment cost HARD_WALL until International Avogadro Project pricing
  drops.
- `quantum-2d-hbn-vb-001` hBN VB⁻ color center. **F**: ODMR contrast < 1% @
  300 K OR coherence T₂ < 100 ns → FAIL.
- `quantum-mol-vopc-001` Vanadyl-phthalocyanine molecular qubit. **F**:
  T₁ < 1 ms @ 5 K OR ensemble coherence < 100 μs → FAIL.

#### 3.D.2 Skyrmions / antiferromagnetic memory
- `skyrm-mnptsn-001` Mn₁.₄PtSn skyrmion bearing material. **F**: skyrmion
  lattice stable above 300 K → false → FAIL. **Risks**: skyrmion size HARD_WALL.
- `armag-mn3sn-001` Mn₃Sn antiferromagnetic spin-Hall memory. **F**:
  spin-Hall angle < 0.1 OR coercive switching > 100 mA/cm² → FAIL.

#### 3.D.3 Magnonics
- `magnon-yig-001` Y₃Fe₅O₁₂ low-damping film. **F**: Gilbert damping α > 1e-5
  OR film thickness uniformity > 5% across 4-inch wafer → FAIL. **Risks**:
  Gd substrate epitaxy.

#### 3.D.4 Magnetocaloric
- `mcal-lafesi-001` LaFeSi room-T magnetocaloric. **F**: adiabatic ΔT < 4 K
  @ 2 T near 290 K OR hysteresis > 0.5 K → FAIL.

#### 3.D.5 Piezoelectric (Pb-free)
- `piezo-knn-001` (K,Na)NbO₃ Pb-free. **F**: d₃₃ < 400 pC/N @ 25 °C OR Curie
  point T_c < 350 °C → FAIL.
- `piezo-bnt-bt-001` (Bi,Na)TiO₃-BaTiO₃. **F**: d₃₃ < 300 pC/N OR depolarization
  T_d < 150 °C → FAIL.

#### 3.D.6 Topological & Weyl
- `top-bi2se3-001` Bi₂Se₃ topological insulator surface. **F**: ARPES Dirac
  cone gap > 30 meV OR surface state mobility < 5000 cm²/(V·s) → FAIL.
- `weyl-tas-001` TaAs Weyl semimetal. **F**: Berry curvature signature absent
  in Hall measurement → FAIL.

#### 3.D.7 Flat-band / time-domain metamaterials
- `flatband-tbg-001` Magic-angle twisted bilayer graphene. **F**: superconducting
  T_c < 1.5 K OR twist-angle precision worse than 0.1° → FAIL.
- `tdmeta-photonic-001` Time-domain photonic metamaterial. **F**: frequency
  conversion efficiency < 10% OR modulation rate < 100 GHz → FAIL.

### 3.E — Optics, photonics, displays

#### 3.E.1 LED / OLED / display (`display-led`)
- `display-led-perled-001` Perovskite LED (3D + 2D). **F**: external QE < 20%
  OR T50 lifetime < 10⁴ h @ 100 cd/m² → FAIL. **Risks**: Pb halide migration;
  encapsulation HARD_WALL.
- `display-led-blueoled-001` TADF blue OLED. **F**: EQE < 30% OR BT.2020 blue
  coverage < 80% → FAIL.
- `display-led-microled-001` InGaN red micro-LED @ < 10 μm. **F**: EQE < 5%
  OR sidewall non-radiative loss > 30% → FAIL.
- `display-led-uvc-001` AlN deep-UV LED @ 265 nm. **F**: wall-plug efficiency
  < 10% OR L50 < 1000 h → FAIL.

#### 3.E.2 LC (`display-lc`)
- `display-lc-bluephase-001` Polymer-stabilized blue-phase LC. **F**: switching
  > 1 ms OR temperature range < 30 °C → FAIL. **Risks**: birefringence; cell-gap
  uniformity.

#### 3.E.3 Quantum-dot
- `display-qd-cdfree-001` InP/ZnSe Cd-free quantum-dot emitter. **F**: FWHM
  > 25 nm OR quantum yield < 90% → FAIL. **Risks**: In supply chain.

#### 3.E.4 Electrochromic
- `ec-glass-niowo3-001` NiO/WO₃ electrochromic. **F**: cycle life < 10⁶ OR
  visible-light contrast Δτ < 0.6 → FAIL.

#### 3.E.5 Nonlinear optical
- `nlo-knbo3-001` KNbO₃ nonlinear crystal for UV-VIS. **F**: d_eff < 10 pm/V
  OR damage threshold < 100 GW/cm² → FAIL.

### 3.F — Structural & aerospace

#### 3.F.1 Titanium alloys (`ti-*`)
- `ti-beta-15-3-001` Ti-15V-3Cr-3Sn-3Al beta-Ti. **F**: σ_y < 1300 MPa OR
  Young modulus > 80 GPa (medical-implant target) → FAIL.
- `ti-gamma-tial-001` γ-TiAl intermetallic. **F**: ductile-to-brittle
  transition > 600 °C OR creep @ 800 °C / 250 MPa < 100 h → FAIL.

#### 3.F.2 Nickel superalloys (`ni-*`)
- `ni-4gen-re-free-001` 4th-gen Ni single-crystal without Re. **F**: creep
  life @ 1050 °C / 137 MPa < 400 h OR oxidation rate > 0.1 mg/cm²/h →
  FAIL. **Risks**: Re-free SX UNVERIFIED at production parity.
- `ni-am-in939-001` LPBF IN939 post-HIP. **F**: density < 99.9% OR creep
  life @ 800 °C / 200 MPa anisotropic by > 30% → FAIL.

#### 3.F.3 Carbon fiber precursors (`cf-*`)
- `cf-t1100-001` T1100-class PAN carbon fiber. **F**: tensile σ < 7 GPa OR
  modulus < 320 GPa → FAIL.
- `cf-lignin-001` Lignin-derived CF (Oak Ridge route). **F**: tensile σ <
  1.5 GPa OR cost > $5/lb at pilot scale → FAIL. **Risks**: feedstock variability.

#### 3.F.4 UHTC (`uhtc`)
- `uhtc-zrbsi-001` ZrB₂-20vol%SiC. **F**: oxidation rate @ 2000 °C / 1 atm air
  > 5 μm/min OR thermal-shock retention < 70% → FAIL.
- `uhtc-tac-hfc-001` TaC-HfC solid solution. **F**: T_m < 4200 °C OR
  hardness @ RT < 22 GPa → FAIL.

#### 3.F.5 MAX phase
- `cer-maxphase-cr2alc-001` Cr₂AlC MAX phase. **F**: oxidation rate @ 1300 °C
  / 1 atm > 1 μm/h OR fracture toughness < 8 MPa·m^0.5 → FAIL.

#### 3.F.6 Cements (`cement`)
- `cement-mgo-co2neg-001` MgO-based carbon-negative cement. **F**: net CO₂
  emission per m³ of cured concrete > -0.1 t OR 28-day σ_c < 30 MPa → FAIL.
  **Risks**: MgO source carbon-footprint accounting; durability UNVERIFIED.
- `cement-ccs-cured-001` CO₂-cured concrete (Solidia-class). **F**: 28-day
  σ_c < 40 MPa OR CO₂ uptake < 100 kg/m³ → FAIL.

#### 3.F.7 Foams & armor
- `foam-tpms-001` TPMS-lattice Inconel foam, energy absorption. **F**: specific
  energy absorption < 30 J/g @ 50% strain rate quasi-static → FAIL.
- `armor-alon-001` AlON transparent armor. **F**: V50 (10 mm thickness,
  7.62×51 AP) < 1500 m/s OR optical transmission < 80% → FAIL.

### 3.G — Polymers & soft matter

#### 3.G.1 Vitrimers (recyclable thermoset, `vitrimer`)
- `vitrimer-da-001` Diels-Alder vitrimer. **F**: relaxation T_v < 100 °C OR
  recyclability > 50% strength after 5 cycles → FAIL.
- `vitrimer-ester-001` Transesterification vitrimer. **F**: T_g < 60 °C OR
  100% strength retention after 10 reflow cycles fails → FAIL.

#### 3.G.2 Self-healing (`selfheal`)
- `selfheal-pdms-urea-001` PDMS-urea self-healing elastomer. **F**: tensile
  strength recovery < 80% @ 24 h, 25 °C OR strain-to-break < 5× original →
  FAIL.
- `selfheal-iono-001` Ionogel self-healing electrolyte. **F**: σ_ionic
  recovery < 95% in 1 h OR mechanical recovery < 90% in 6 h → FAIL.

#### 3.G.3 Shape memory (`sma`)
- `sma-niti-hf-001` Ni-Ti-Hf high-T SMA, A_f > 100 °C. **F**: A_f outside
  100-150 °C OR recoverable strain < 4% → FAIL.
- `sma-polymer-smp-001` Thermoset SMP, T_g 90 °C. **F**: recoverable strain
  < 100% OR recovery temperature drift > 5 °C → FAIL.

#### 3.G.4 Conductive polymers
- `polymer-pedot-001` PEDOT:PSS, post-treatment for >5000 S/cm. **F**:
  σ < 5000 S/cm @ 25 °C OR humidity stability < 90% retention after 1000 h
  @ 85% RH → FAIL.

#### 3.G.5 Aerogels (extends `aero`)
- `aero-polyimide-001` Polyimide aerogel for aerospace insulation. **F**: T
  service > 350 °C OR thermal conductivity > 0.018 W/(m·K) → FAIL.
- `aero-cellulose-001` Nanocellulose aerogel for biodegradable insulation.
  **F**: density > 50 mg/cm³ OR thermal conductivity > 0.025 W/(m·K) → FAIL.
  **Risks**: hygroscopic stability HARD_WALL.

#### 3.G.6 MOFs (extends `mof`)
- `mof-h2o-stable-uio66-001` UiO-66 in liquid water 1000 h. **F**: BET surface
  area retention < 80% OR crystallinity loss > 20% → FAIL.
- `mof-dac-mqm-001` MOF for DAC at 400 ppm. **F**: capacity < 2 mmol/g
  @ 400 ppm 25 °C, 50% RH OR regeneration energy > 2 MJ/kg-CO₂ → FAIL.
  **Risks**: magic-MOF DAC $100/t UNPROVEN preserved (Climeworks amine
  $600-1000/t).
- `mof-conductive-001` Ni₃(HITP)₂ conductive MOF. **F**: σ < 40 S/cm OR
  air stability < 30 days → FAIL.

#### 3.G.7 High-strength fibers
- `fiber-m5-001` M5/PIPD pyrrolic fiber. **F**: σ < 5.5 GPa OR modulus
  < 270 GPa → FAIL.

### 3.H — Biomaterials & implants

#### 3.H.1 Bone-scaffold (`bone`)
- `bone-bioglass-001` 45S5 bioglass scaffold, porosity 80%. **F**: compressive
  σ < 2 MPa OR new-bone ingrowth (rat femur model) < 30% in 8 wk → FAIL.
- `bone-ha-pcl-001` Hydroxyapatite-PCL composite. **F**: degradation rate >
  20%/wk OR osteoblast viability < 90% → FAIL.

#### 3.H.2 Implants (`implant`)
- `implant-peek-001` PEEK spinal implant. **F**: fatigue 10⁷ cycles failure
  @ σ_max 35 MPa OR creep > 0.1%/yr → FAIL.
- `implant-y-tzp-001` Y-stabilized ZrO₂ dental crown. **F**: flexural σ <
  900 MPa OR LTD-aging cracking @ 134 °C, 2 atm, 100 h → FAIL. **Risks**:
  low-temperature degradation (LTD) HARD_WALL.
- `implant-mg-re-001` Mg-Y-Nd dissolvable orthopedic. **F**: resorption
  > 12 mo OR gas-evolution > 10 mL/cm³/wk → FAIL.

#### 3.H.3 E-skin (`eskin`)
- `eskin-graphene-001` Graphene-on-PDMS strain sensor. **F**: gauge factor
  < 200 OR cycle 10⁴ retention < 80% → FAIL.
- `eskin-pvdf-001` PVDF piezo pressure-sensor array. **F**: pressure
  sensitivity < 0.01 kPa⁻¹ OR temperature stability over -20–60 °C drift
  > 20% → FAIL.

### 3.I — Manufacturing-enabled (process-defined)

#### 3.I.1 AM alloys (`am-alloy`)
- `am-alloy-in939-001` LPBF IN939 + post-HIP (extends ni-am-in939-001 above).
- `am-alloy-cocrmo-001` LPBF Co-Cr-Mo for medical. **F**: density < 99.7%
  OR fatigue 10⁷ @ 800 MPa fails → FAIL.

#### 3.I.2 AM resins (`am-resin`)
- `am-resin-dlp-engineering-001` DLP engineering-grade resin. **F**: tensile
  σ < 50 MPa OR HDT < 80 °C → FAIL.
- `am-resin-bio-001` DLP biocompatible resin. **F**: ISO 10993 cytotoxicity
  > grade-1 OR shrinkage > 2% → FAIL.

#### 3.I.3 AM ceramics (`am-ceram`)
- `am-ceram-zro2-001` DLP zirconia ceramic via slurry. **F**: σ_flexural <
  1 GPa OR shrinkage anisotropy > 5% → FAIL.

#### 3.I.4 Continuous-process
- `roll2roll-graphene-001` CVD graphene roll, > 100 m continuous. **F**:
  sheet resistance > 200 Ω/sq OR carrier mobility < 1000 cm²/(V·s) →
  FAIL. **Risks**: grain-boundary scattering; PMMA transfer artifacts.

### 3.J — Electronics

#### 3.J.1 2D semiconductors (`2d`)
- `2d-mos2-wafer-001` 8-inch wafer-scale CVD MoS₂. **F**: field-effect mobility
  < 50 cm²/(V·s) OR uniformity > 15% over wafer → FAIL.
- `2d-phosphorene-passivated-001` Air-stable encapsulated phosphorene. **F**:
  ambient lifetime < 6 mo OR mobility < 200 cm²/(V·s) → FAIL. **Risks**:
  phosphorene ambient HARD_WALL.

#### 3.J.2 Organic semiconductors
- `organic-dpp-001` DPP-thieno copolymer OFET. **F**: hole mobility < 5
  cm²/(V·s) OR contact resistance > 1 kΩ·cm → FAIL.

#### 3.J.3 PCM memory (`pcm` memory)
- `pcm-gst-001` Ge₂Sb₂Te₅ phase-change memory cell. **F**: set/reset endurance
  < 10¹⁰ cycles OR retention < 10 yr @ 85 °C → FAIL.

#### 3.J.4 RRAM (`rram`)
- `rram-hfox-001` HfO_x bipolar valence-change RRAM. **F**: retention < 10 yr
  @ 125 °C OR endurance < 10⁹ cycles → FAIL.
- `rram-tao-001` TaO_x multibit RRAM. **F**: distinct levels < 16 OR write
  energy > 100 fJ/bit → FAIL.

#### 3.J.5 Neuromorphic (`neuromorph`)
- `neuromorph-ion-mem-001` Ionic memristor for analog synapse. **F**: linearity
  drift > 5%/yr OR cycle-life < 10⁹ → FAIL.

#### 3.J.6 Magnetic
- `mag-fefsi-001` FeBSi amorphous core. **F**: core loss > 50 mW/cm³ @ 50 Hz,
  1.5 T OR coercivity > 2 A/m → FAIL.
- `mag-mnbi-001` MnBi permanent magnet (RE-free). **F**: (BH)_max < 15 MGOe
  @ 25 °C OR Curie T < 350 °C → FAIL.

### 3.K — Environmental & sustainability

#### 3.K.1 DAC sorbents (`co2-cap`)
- `co2-cap-mof-mfm-001` Functionalized MOF for DAC. **F**: capacity @ 400 ppm
  < 1.5 mmol/g OR regeneration energy > 2 MJ/kg-CO₂ → FAIL. **Risks**:
  magic-MOF DAC $100/t UNPROVEN preserved.
- `co2-cap-amine-002` Tetraethylenepentamine-grafted silica. **F**: CO₂ capacity
  < 2 mmol/g OR amine oxidation > 5%/cycle → FAIL.

#### 3.K.2 H₂ storage (`h2-store`)
- `h2-store-mghn-001` MgH₂ nanocomposite. **F**: kinetic absorption rate <
  6 wt%/h @ 200 °C OR cycle-100 capacity retention < 95% → FAIL.
- `h2-store-lohc-dbt-001` LOHC dibenzyltoluene. **F**: hydrogen capacity <
  6.2 wt% OR catalytic dehydrogenation T > 320 °C for 95% release → FAIL.
- `h2-store-nh3-cracker-001` Ru-Cs/CNT ammonia cracker for green-H₂
  decentralized release. **F**: H₂ purity < 99.97% OR conversion @ 450 °C
  < 95% → FAIL.

#### 3.K.3 Desalination (`desal`)
- `desal-go-rom-001` Graphene-oxide RO membrane. **F**: NaCl rejection
  < 99% OR flux < 5 L/(m²·h·bar) → FAIL.
- `desal-mos2-001` MoS₂-nanopore desalination membrane. **F**: salt rejection
  < 99.5% OR flux < 10 L/(m²·h·bar) → FAIL.

#### 3.K.4 Soil & water
- `soilrem-biochar-001` High-surface biochar from pyrolysis. **F**: heavy-metal
  Pb²⁺ sorption < 80 mg/g OR humid-soil stability < 5 yr → FAIL.
- `h2o-harv-mof-303-001` MOF-303 atmospheric water harvesting. **F**: water
  capacity < 0.4 L/kg-MOF/day @ 25 °C, 30% RH → FAIL.
- `h2o-harv-salvinia-001` Salvinia-inspired hydrophilic-hydrophobic fog
  collector. **F**: water yield < 5 L/m²·d on coastal-fog night → FAIL.

#### 3.K.5 Plastic recycling (`recycle-cat`)
- `recycle-pet-petase-001` Engineered PETase variant for PET. **F**: PET
  depolymerization < 90% in 48 h @ 50 °C OR enzyme cost > $1/kg-PET → FAIL.

#### 3.K.6 Mineralization
- `co2-mineral-basalt-001` Basalt accelerated weathering for CO₂
  sequestration. **F**: CO₂ uptake @ 1 yr / m³ < 50 kg → FAIL. **Risks**:
  geochemistry HARD_WALL (basalt grain-size kinetics).

### 3.L — Architectural / construction

- `bipv-glass-001` Building-integrated PV glass laminate. **F**: certified PCE
  < 15% OR visible transmission < 40% → FAIL.
- `coat-selfclean-tio2-001` TiO₂ photocatalytic self-cleaning. **F**:
  durability < 5 yr OR contact angle drift > 30° → FAIL.
- `coat-antiice-slips-001` Slippery liquid-infused anti-ice surface. **F**:
  ice adhesion > 10 kPa OR oil depletion > 50% in 1 yr → FAIL.
- `paint-anticorr-graphene-001` Graphene-modified epoxy. **F**: salt-spray
  ASTM B117 < 2000 h to base-metal blister → FAIL.

### 3.M — Special-function & smart materials

- `anti-bact-ag-zeolite-001` Silver-zeolite antibacterial textile. **F**:
  log-3 reduction in 24 h fails OR > 10% silver loss after 50 washes → FAIL.
- `anti-foul-fluoro-pdms-001` Fluoropolymer-PDMS antifouling marine. **F**:
  barnacle settlement > 30% / cm² over 30 days → FAIL.
- `trigger-pnipam-001` pH-responsive PNIPAm. **F**: LCST drift outside 31-33 °C →
  FAIL.

### 3.N — Acoustic & sound (`acoustic`)

- `acoustic-meta-helmholtz-001` Sub-λ Helmholtz-resonator acoustic absorber.
  **F**: absorption coefficient < 0.9 @ 250 Hz for 5 cm panel → FAIL.
- `acoustic-locres-001` Locally-resonant phononic crystal. **F**: bandgap
  < 100 Hz wide OR transmission > -20 dB in bandgap → FAIL.

### 3.O — Cryogenic & radiation (`cryo`, `radshield`)

- `cryo-cu-001` OFHC copper for 4 K stage of dilution refrigerator. **F**:
  RRR < 200 OR thermal conductivity < 500 W/(m·K) @ 4 K → FAIL.
- `cryo-ti64-lh2-001` LH₂-tank Ti-6Al-4V variant. **F**: Charpy V-notch @
  -253 °C < 25 J OR hydrogen-embrittlement crack growth > 1e-7 m/s → FAIL.
- `radshield-bnh-001` Boron-loaded polyethylene neutron shield. **F**:
  thermal-neutron attenuation < 50% per 5 cm OR PE softening @ 60 °C → FAIL.
- `radshield-w-001` Tungsten gamma shield for radiotherapy collimator. **F**:
  density < 18.5 g/cm³ OR machinability HRC > 35 → FAIL.

### 3.P — Detectors (`detector`)

- `detector-cdznte-001` CZT for room-T gamma spectroscopy. **F**: energy
  resolution > 1% @ 662 keV OR drift > 5%/h on Cs-137 source → FAIL.
- `detector-perovx-001` MAPbBr₃ perovskite X-ray scintillator. **F**: light
  yield < 30,000 ph/MeV OR decay > 100 ns OR lifetime < 1 yr → FAIL.
- `detector-2dphoto-001` MoS₂ photodetector for SWIR. **F**: D* < 1e10
  Jones @ 1300 nm OR response time > 100 μs → FAIL.

### 3.Q — Information storage

- `dna-storage-001` DNA digital storage substrate. **F**: density < 100 PB/g
  OR retrieval error rate > 1e-4 → FAIL.
- `holo-storage-001` Photopolymer holographic. **F**: dynamic range M# < 20
  OR shelf life < 50 yr → FAIL.
- `glass-storage-001` 5D silica glass storage. **F**: data density < 360 TB
  per cubic inch OR thermal stability < 500 °C → FAIL.

### 3.R — Frontier / speculative

- `weyl-tas-001` TaAs Weyl semimetal (duplicate of 3.D.6, kept for completeness).
- `topological-bi2te3-001` Bi₂Te₃ topological insulator. **F**: surface
  conductivity outside Dirac cone < 1 mS/cm OR bulk gap < 100 meV → FAIL.
- `time-crystal-trivial-001` Driven-Floquet time crystal (Norman/Choi class).
  **F**: subharmonic peak < 10× noise OR coherence < 100 ms → FAIL. **Risks**:
  trivial-time-crystal vs many-body-localization distinction.

### 3.S — Bio-inspired (`mycel`, `algae`, `bio-electron`)

- `mycel-composite-001` Mycelium-substrate building insulation. **F**:
  thermal conductivity > 0.06 W/(m·K) OR moisture absorption > 30% → FAIL.
- `algae-plastic-001` Algae-derived bioplastic (PHA fermentation). **F**:
  tensile σ < 30 MPa OR commercial cost > $5/kg → FAIL.
- `bio-electron-pla-pcl-001` PLA-PCL biodegradable transient electronics
  substrate. **F**: degradation < 50% over 6 mo in PBS / 37 °C OR resistivity
  < 10⁶ Ω·cm → FAIL.
- `softrobotics-pneumatic-001` PDMS pneumatic actuator soft robot. **F**:
  cycle life < 10⁵ OR fatigue strain < 50% → FAIL.

### 3.T — Sports / textile / consumer

- `sports-vibration-damper-001` Polyurea-coated bat vibration damper. **F**:
  loss tangent < 0.3 @ 200 Hz OR thermal degradation @ 80 °C / 1000 h
  > 30% → FAIL.
- `textile-pcm-fabric-001` Microencapsulated PCM thermal-regulating fabric.
  **F**: thermal buffering capacity < 25 J/g OR wash-50 retention < 70% →
  FAIL.

### 3.U — Negative thermal expansion / anomalous

- `nte-zwo3-001` ZrW₂O₈ negative-thermal-expansion ceramic. **F**: linear CTE
  outside -8 to -10 × 10⁻⁶ K⁻¹ over 20-1000 K → FAIL.
- `auxetic-001` Auxetic foam (Poisson ratio negative). **F**: ν > -0.5 OR
  cyclic 10³ stability < 90% → FAIL.

---

## 4. Cross-class hybrids (interesting but tracked separately)

Cross-class combinations worth a NOVEL.md slot:

| ID stub | A × B | hypothesis |
|---------|-------|-----------|
| `cross-hea-bmg-001` | HEA + BMG | CoCrFeMnNi-class with > 5 mm glass-forming D_c |
| `cross-mof-2d-001` | MOF + 2D | 2D MOF (Ni₃(HITP)₂) electrocatalysis |
| `cross-pero-halide-se-001` | perovskite + halide SE | mixed-anion perovskite electrolyte |
| `cross-mxene-pcm-001` | MXene + PCM | conductive MXene-paraffin PCM |
| `cross-aero-pcm-001` | aero + PCM | aerogel-confined PCM, suppressed leakage |
| `cross-quantum-2d-001` | quantum + 2D | hBN-graphene heterostructure qubit host |
| `cross-cat-photo-001` | cat + photo | dye-sensitized molecular photocatalyst |
| `cross-piezo-eskin-001` | piezo + eskin | flexible piezo e-skin for wearable |

---

## 5. Priority tier ranking

**Tier 1** (highest-impact, tractable, falsifier-rigorous; promote first):
- `pv-tandem-001` (29-32% PCE — closest to commodity disruption)
- `bat-cath-drx-001`, `bat-anode-li-metal-001` (battery-grade impact)
- `co2-cap-mof-mfm-001` (DAC at scale — climate-policy adjacent)
- `te-half-zrnisn-001` (TE ZT > 1.5 — power scavenging)
- `cement-mgo-co2neg-001` (carbon-negative cement)
- `h2-elec-iro2-doped-001` (Ir-Ru OER for AEM cell)

**Tier 2** (high-impact but speculative):
- `quantum-si-donor-001`, `quantum-2d-hbn-vb-001` (quantum-computing payoff)
- `weyl-tas-001`, `flatband-tbg-001` (fundamental physics, indirect impact)
- `mycel-composite-001`, `algae-plastic-001` (sustainability)

**Tier 3** (interesting but lower-confidence):
- `time-crystal-trivial-001` (frontier; classification disputes)
- `tdmeta-photonic-001` (time-domain metamaterials — exploratory)

---

## 6. Brainstorming exhaustion log

What's covered: 30+ classes, ~140 slot stubs across batteries (cath ×4,
anode ×3, SE ×3, flow ×1, cap ×1), PV (5), fuel cells (2), catalysis
(ORR, CO₂RR, HER, OER, N₂RR, photocat — 8), thermal (TE ×4, PCM ×2,
RCC, insul — 8), quantum/spintronic (qubit ×3, skyrm/AFM ×2, magnon,
mcal, piezo ×2, topological ×2, flat band, td-metamaterial), optics
(LED ×4, LC, QD, EC, NLO — 8), structural (Ti ×2, Ni ×2, CF ×2, UHTC
×2, MAX phase, cement ×2, foam, armor — 12), polymers (vitrimer ×2,
selfheal ×2, SMA ×2, conductive, aerogel ×2, MOF ×3, fiber — 13),
biomaterials (bone ×2, implant ×3, eskin ×2 — 7), manufacturing
(AM alloy ×2, AM resin ×2, AM ceram, R2R — 6), electronics (2D ×2,
organic, PCM-mem, RRAM ×2, neuromorph, magnetic ×2 — 9), environmental
(DAC ×2, H₂store ×3, desal ×2, soil/water ×3, recycle, mineralize —
12), architectural (4), special-function (4), acoustic (2), cryo /
rad (4), detectors (3), info storage (3), frontier (3), bio-inspired
(4), sports/textile (2), negative-expansion/auxetic (2).

What's *not* covered (residual unknown): trans-uranic / radioactive
materials (regulatory-out-of-scope); biological-living substrates
(out-of-domain — hexa-bio); fluid-dynamic structures (out-of-domain —
hexa-mobility); pure mathematical-frontier (out-of-domain —
hexa-millennium).

Stop signal: every major IUPAC / TMS / MRS / ACS materials division
2024-2026 has at least one slot covered. Additional new classes after
this point would require user input on whether they fit hexa-matter
scope or another sister.

---

## 7. Promotion criteria (DESIGN-only)

Slot → NOVEL.md entry when ALL pass:

1. Falsifier is *one falsifier line* (number + condition + pass/fail boundary).
   Multi-criterion falsifiers OK, but each must be quantitative.
2. Anchor citation present (peer-reviewed paper / vendor datasheet / standards
3. Status `DESIGN` — never claim VERIFIED / EXTERNAL-VERIFIED in this repo
   (requires external lab + sample-ID).
4. Risk-flags listed — at minimum: synthesis-feasibility, regulatory,
   sister-domain-boundary.
5. Cross-link to relevant `<verb>/<verb>.md` or `LIMIT_BREAKTHROUGH.md` row.
6. UNPROVEN markers (when relevant) preserved verbatim (LK-99, magic-MOF
   DAC, CNT yarn, marine-PHA, Re-free SX, etc.).

---


- This roadmap is a *hypothesis menu* — promotion to NOVEL.md is gated by
  the user and ledger review, not by this doc's listing.
- Slot existence here is NOT a hexa-matter endorsement; it is a "design
  space worth thinking about" tag.
- Every Tier-1+2 slot has an active commercial or academic actor (named
  in the candidate body) — slots without such an actor stay in this doc
  and are not promoted.

---

## 9. Sister-domain hand-offs

When a slot reads like a device / cell / fab claim rather than a material
claim, it belongs to a sister:

- battery cell engineering → `hexa-energy` (per CROSS_LINK §3.3)
- semiconductor device + lithography → `hexa-chip` (per CROSS_LINK §3.2)
- bio-substrate / drug-target → `hexa-bio` / `hexa-medic`
- aerospace airframe + propulsion → `hexa-aero` (FUTURE / not yet created)
- mobility / autonomy / safety → `hexa-mobility`
- room-T superconductor *device* → `hexa-rtsc` (hxm-sc-* in NOVEL.md are
  hypothesis only, NOT RT-SC claims)

If a slot drifts into a sister's domain, the slot needs splitting: keep
the material-layer claim in NOVEL.md, refer the device claim out.
