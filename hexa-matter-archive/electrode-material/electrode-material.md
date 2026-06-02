<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — battery + electrocatalysis + electrochemical electrodes (LFP / NMC811 / LCO / graphite / Si anode / Li-metal / Pt-ORR / IrO2-OER / MnO2). Cell engineering belongs to hexa-energy; this verb owns the active material only. -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; no lattice anchoring of electrode-material parameters -->
---
domain: electrode-material
requires: []
verb_group: ceramic_inorganic
status: SPEC_FIRST
verdict_basis: vendor-published numbers (Umicore, POSCO Future M, CATL, BYD, LG Energy Solution, Samsung SDI, Sumitomo Metal Mining, Tanaka Holdings) + NIST + ASTM/IEC battery standards + primary literature (Goodenough/Padhi/Yoshino/Whittingham); no lattice fit
---

# Electrode-Material — n=6 소재 substrate, material verb (Phase D'' 36/36)

> **Material layer only — cell engineering belongs to `hexa-energy`.**
> Active materials that store / release charge by reversible
> intercalation, alloying, conversion, or plating reactions in
> rechargeable batteries (Li-ion, Na-ion, primary Li, Pb-acid), and
> active sites for electrocatalysis (ORR for fuel cells, OER for
> water electrolysis, HER for hydrogen evolution). Covers cathode
> materials (LFP LiFePO₄, NMC811 LiNi₀.₈Mn₀.₁Co₀.₁O₂, NCA, LCO LiCoO₂,
> LMO LiMn₂O₄, sulfur), anode materials (graphite, hard carbon,
> Si / SiO_x, Li-titanate LTO, Li metal), and electrocatalyst
> materials (Pt/C and Pt-alloys for ORR; IrO₂ + RuO₂ for OER; Ni-Fe
> oxide for alkaline OER; MnO₂ for primary alkaline cathode).
> **Cell engineering (electrode-coating + calendering + stacking +
> winding + electrolyte filling + formation + BMS) lives in
> `hexa-energy`; this verb owns the active material only — crystal
> structure, capacity-per-gram, voltage-vs-Li, cycle stability of
> the material itself.**

> electrode-material performance (specific capacity in mAh/g, average
> voltage vs Li/Li⁺ or vs RHE, redox plateau, structural stability on
> de/lithiation, electrocatalytic activity in mA/cm²) is set by
> **crystal structure + transition-metal redox couple + Li-diffusion
> pathway + surface chemistry + particle morphology** — not by the
> n=6 lattice. Umicore / POSCO Future M / CATL / BYD / LG Energy
> Solution / Samsung SDI / Sumitomo Metal Mining / Tanaka Holdings
> vendor figures cited verbatim with no lattice projection.
> **Si-anode 500-cycle 1C 70 % retention UNVERIFIED at full commodity
> scale**; **Li-metal anode dendrite suppression UNVERIFIED for ≥ 500
> deep cycles**.

---

## §1 WHY — why electrode-material belongs in hexa-matter

The lithium-ion battery's energy density floor is set by the
thermodynamic + structural ceiling of its electrode chemistry —
LiCoO₂ at 4.2 V cut-off, LiFePO₄ at 3.4 V flat plateau, graphite at
0.1 V de/lithiation, Si at 0.4 V alloying with > 3 × volume change.
The cell engineering (electrode coating thickness, calendering
density, electrolyte salt + solvent + additive, separator porosity,
formation cycle) operates *on top of* the active-material envelope —
but it cannot exceed the active material's capacity / voltage limit.

For electrocatalysis, the same logic: Pt mass-activity for ORR is
limited by Pt's d-band center; IrO₂ OER overpotential is bound by
scaling relations; Ni-Fe alkaline OER is bound by Sabatier optimum.
The material's intrinsic activity is the substrate; the
device (membrane-electrode assembly, gas diffusion layer, flow
field) wraps the material.

Both battery + electrocatalysis sit in `hexa-matter` at the material
layer, with the device + cell engineering ceded to `hexa-energy`.

| Subclass | Composition | Capacity / activity | Industrial signature |
|----------|-------------|----------------------|----------------------|
| LFP cathode | LiFePO₄ (olivine) | 160–170 mAh/g; ~ 3.4 V flat | CATL Blade / BYD Blade; EV mass-market + ESS dominant by 2024 |
| NMC811 cathode | LiNi₀.₈Mn₀.₁Co₀.₁O₂ (layered) | 200–210 mAh/g; ~ 3.85 V avg | Tesla 4680 / LG Energy / Samsung SDI premium EV |
| NMC622 cathode | LiNi₀.₆Mn₀.₂Co₀.₂O₂ | 175–190 mAh/g | Legacy / mid-Ni EV |
| NCA cathode | LiNi₀.₈Co₀.₁₅Al₀.₀₅O₂ | 200 mAh/g; ~ 3.7 V avg | Panasonic / Tesla 2170 |
| LCO cathode | LiCoO₂ (layered) | 140–160 mAh/g; ~ 3.9 V | Consumer electronics dominant (phone / laptop) |
| LMO cathode | LiMn₂O₄ (spinel) | 100–120 mAh/g; ~ 4.1 V | Power tool / e-bike (legacy) |
| Sulfur cathode | S₈ (conversion) | 1675 mAh/g theoretical; 600–1000 mAh/g practical | R&D — UNVERIFIED at long cycle |
| Graphite anode | natural / synthetic graphite | 350–370 mAh/g (vs 372 theoretical) | Workhorse — ~ 95 % of Li-ion anode |
| Hard carbon anode | non-graphitizable carbon | 250–350 mAh/g; flat voltage profile | Na-ion + some Li-ion |
| Silicon anode | Si or SiO_x in C composite | 1000–4200 mAh/g theoretical; **300–800 mAh/g practical in graphite/Si composite** | Premium EV blends (Tesla 4680) — full Si UNVERIFIED at commodity |
| Li-titanate anode (LTO) | Li₄Ti₅O₁₂ (spinel) | 175 mAh/g; ~ 1.55 V; zero-strain | Long-cycle ESS niche |
| Li-metal anode | Li⁰ plate | 3860 mAh/g theoretical | R&D — **dendrite suppression UNVERIFIED for ≥ 500 deep cycles** |
| Pt-ORR catalyst | Pt/C (Pt nanoparticles on Vulcan XC-72) | 0.10–0.45 A/mg_Pt mass activity @ 0.9 V vs RHE | PEMFC cathode (Toyota Mirai / Hyundai Nexo / NEXTEL) |
| IrO₂-OER catalyst | IrO₂ or Ir-oxide composite | 1.5–1.7 V vs RHE @ 10 mA/cm² (PEM electrolyzer) | PEM water electrolysis (Siemens / Cummins / ITM) |
| Ni-Fe alkaline OER | NiFeO_xHy / NiFe-LDH | 1.5–1.6 V vs RHE @ 10 mA/cm² | Alkaline electrolysis (nel ASA / thyssenkrupp Nucera) |
| MnO₂ primary cathode | electrolytic MnO₂ (EMD) / γ-MnO₂ | 285 mAh/g theoretical | Alkaline AA primary (Duracell / Energizer) |
| Pb-acid + Ni-MH (legacy) | PbO₂ / NiOOH | low specific, high recyclability | Auto SLI + hybrid (legacy) |

---

## §2 Real-limits-first — electrode-material's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| EM-L1 | LFP (LiFePO₄) specific capacity (theoretical / practical) | Physical / HARD (theoretical) | **170 mAh/g theoretical; 160–165 mAh/g practical** at 3.4 V plateau | Padhi, Goodenough et al. *J. Electrochem. Soc.* 144, 1188 (1997) |
| EM-L2 | LCO (LiCoO₂) reversible capacity at 4.2 V cut-off | Physical / SOFT | **140–155 mAh/g** (full 274 mAh/g theoretical needs > 4.5 V → degradation) | Mizushima, Goodenough et al. *Mater. Res. Bull.* 15, 783 (1980) |
| EM-L3 | NMC811 specific capacity | Physical / SOFT | **200–210 mAh/g** at 4.3 V cut-off; 220 mAh/g at 4.4 V (degradation risk) | Manthiram *Nat. Commun.* 2020 review; Sun Yang-Kook *JES* 2017 |
| EM-L4 | Graphite anode theoretical capacity (LiC₆) | Physical / HARD | **372 mAh/g** | Whittingham *Chem. Rev.* 104, 4271 (2004) |
| EM-L5 | Silicon anode theoretical capacity (Li₁₅Si₄ alloy) | Physical / HARD | **3579 mAh/g** (room-T phase); 4200 mAh/g at 415 °C (Li₂₂Si₅) | Obrovac & Christensen *Electrochem. Solid-State Lett.* 7, A93 (2004) |
| EM-L6 | Silicon volume expansion on full lithiation | Physical / HARD | **~ 300 %** (V_LiSi/V_Si ≈ 3.75) — root cause of pulverization + SEI breakdown | Beaulieu et al. *J. Electrochem. Soc.* 150, A1457 (2003) |
| EM-L7 | Li-metal anode theoretical capacity | Physical / HARD | **3860 mAh/g** (Li/Li⁺ at −3.04 V vs SHE) | CRC Handbook |
| EM-L8 | Sulfur cathode theoretical capacity (S₈ → Li₂S conversion) | Physical / HARD | **1675 mAh/g** | Manthiram *Chem. Rev.* 114, 11751 (2014) |
| EM-L9 | LFP cycle life (vendor-warranted) | Engineering / SOFT | **3000–6000+ cycles** to 80 % capacity at 1C/1C, 25 °C; CATL Blade 12,000-cycle claim | CATL Blade datasheet; BYD Blade public |
| EM-L10 | NMC811 cycle life (vendor-warranted) | Engineering / SOFT | **1500–2500 cycles** to 80 % at 1C/1C, 25 °C (high-Ni accelerates degradation) | LG Energy Solution + Samsung SDI premium EV datasheet |
| EM-L11 | Silicon-anode 500-cycle 1C 70 % retention at full commodity | Engineering / **UNVERIFIED** | **UNVERIFIED at commodity scale**; lab + blended Si-graphite at premium-EV scale; **full Si-only UNVERIFIED** | Sila Nano + Group14 + Amprius datasheet — all blended / niche as of 2024 |
| EM-L12 | Li-metal anode dendrite suppression for ≥ 500 deep cycles | Engineering / **UNVERIFIED** | **UNVERIFIED**; QuantumScape, SES, Solid Power, Cuberg, Sion Power show partial progress; commercial > 500 deep cycles UNVERIFIED | QuantumScape SPAC 2020+ disclosures; Sion Power public |
| EM-L13 | Pt-ORR mass activity (US DOE 2025 target) | Engineering / SOFT | DOE target **0.44 A/mg_Pt** at 0.9 V vs RHE; production typically **0.10–0.30 A/mg_Pt** | US DOE Hydrogen Program 2025 milestones |
| EM-L14 | Pt loading (cathode) for PEMFC commercial | Engineering / SOFT | **0.1–0.4 mg_Pt/cm²** cathode; Toyota Mirai-2 ~ 0.12 mg/cm² | Toyota Mirai-2 technical disclosure |
| EM-L15 | IrO₂-OER overpotential at 10 mA/cm² (PEM electrolyzer) | Engineering / SOFT | η ~ 300–400 mV (cell at 1.5–1.7 V vs RHE) | Reier et al. *J. Phys. Chem. Lett.* 5, 12 (2014) |
| EM-L16 | Pt + Ir loading reduction roadmap (PEMFC + PEMEL) | Engineering / UNPROVEN | DOE target ≤ 0.1 g_Pt/kW PEMFC + ≤ 0.5 g_Ir/kW PEMEL — UNVERIFIED at production lifetime | DOE 2025 / IEA hydrogen roadmap |
| EM-L17 | EMD (electrolytic MnO₂) practical capacity in alkaline AA | Engineering / SOFT | **220–260 mAh/g** practical (vs 285 mAh/g theoretical) | Duracell / Energizer technical |
| EM-L18 | LFP Ah-level energy density (cell, vendor-warranted) | Engineering / SOFT | **150–180 Wh/kg cell**; CATL Blade ~ 160 Wh/kg | CATL public; **note: cell-level claim — cell engineering owned by hexa-energy** |
| EM-L19 | NMC811 Ah-level energy density (cell, vendor-warranted) | Engineering / SOFT | **240–280 Wh/kg cell** | LG Energy + Samsung SDI **(cell-level claim — hexa-energy)** |
| EM-L20 | Co supply concentration (DRC mining) | Geopolitical / HARD | **≥ 70 % global Co from DRC** as of 2023; ethical-supply pressure → Co-free chemistry adoption | USGS Mineral Commodity Summaries 2024 |
| EM-L21 | LFP Co-free + Ni-free chemistry advantage | Engineering / SOFT | LFP eliminates Co + Ni — only Fe + P (commodity) — supply-chain resilience drives 2023+ adoption | CATL + BYD strategic statements |

**Note on Si-anode 500-cycle UNVERIFIED at commodity (EM-L11).**
Premium-EV cells (Tesla 4680, Mercedes EQS premium pack) use
graphite-Si blended anode with 5–10 % Si by capacity contribution.
Pure or high-Si (> 50 %) anode at 500-cycle 70 % retention 1C/1C is
reported by Sila Nano (Mercedes), Group14, Amprius at lab + niche
production, but **NOT at full commodity scale** as of 2024. The
challenge is reconciling Si's 300 % volume expansion (EM-L6) with
binder + SEI + Si-particle-architecture stability over 500+ deep
cycles at 1C.

**Note on Li-metal anode dendrite suppression UNVERIFIED ≥ 500
cycles (EM-L12).** Li-metal anode promises ~ 10× anode capacity
(EM-L7) and enables Li-air / Li-S high-energy systems. But Li⁰
plating tends to nucleate dendrites, which short-circuit the cell,
or "dead Li" accumulates and irreversibly consumes capacity.
Mitigation: solid-electrolyte (sulfide / oxide / polymer),
pressurized stack (5–10 MPa), anode-free designs. QuantumScape,
SES, Solid Power, Cuberg, Sion Power all report progress but
**commercial cells with > 500 deep cycles at production yield are
UNVERIFIED** as of 2024-2026. Adjacent: Toyota's "by 2027/2028"
solid-state EV target is anchored on this material breakthrough
and remains in the OPEN falsifier set per F-EM-3.

**Note on the cell-level metrics EM-L18 / L19.** These are vendor-
published *cell-level* numbers and are cited here only as boundary
context — cell engineering (electrode coating, calendering,
formation, BMS) belongs to **hexa-energy** per CROSS_LINK §3.3.

---


Global Li-ion battery-grade cathode active-material (CAM) production
is ~ 2.0+ Mt/yr (2023, BloombergNEF), of which LFP > 60 % by 2024.
China dominates LFP (CATL, BYD, Hunan Yuneng, Shenzhen Dynanonic).
NMC supply concentrated in S. Korea (Posco Future M, EcoPro BM,
L&F) + China (Ronbay, Easpring). Anode-material market ~ 1.5 Mt/yr
dominated by graphite (Shanshan, BTR, POSCO, Mitsubishi Chemical,
Hitachi Chemical). Electrocatalyst (Pt + Ir) market is a
specialty-metals + catalyst-formulation hybrid (Tanaka, Heraeus,
Johnson Matthey, Umicore).

| Producer | Material focus | Reported deployment / scale | Source |
|----------|----------------|-------------------------------|--------|
| Umicore (BE) | NMC + NCA + LCO cathode | EU cathode leader; ~ 100 kt/yr CAM | Umicore IR |
| POSCO Future M (KR; formerly POSCO Chemical) | NMC + NCA + natural-graphite anode | ~ 150+ kt/yr CAM target; LG Energy + Samsung SDI supplier | POSCO Future M IR |
| EcoPro BM (KR) | NCA + NMC | ~ 200 kt/yr CAM target; Samsung SDI supplier | EcoPro BM IR |
| L&F (KR) | high-Ni NMC | ~ 100 kt/yr CAM; LG Energy supplier | L&F IR |
| CATL (CN) | **LFP + NMC; CATL Blade LFP dominant** | World #1 Li-ion cell maker; ~ 350 GWh/yr capacity 2024 (cell, not material) | CATL IR 2023 |
| BYD (CN) | **LFP (BYD Blade)** | World #2 Li-ion cell maker; vertically integrated mining → cell | BYD IR 2023 |
| Hunan Yuneng (CN) | LFP CAM | World largest LFP CAM ~ 700 kt/yr (2023) | Yuneng public |
| Shenzhen Dynanonic (CN) | LFP CAM | China LFP CAM top-5 | Dynanonic public |
| Ronbay (CN) | NMC + NCA CAM | China NMC top-5 | Ronbay public |
| Easpring (CN) | NMC + NCA CAM | China NMC top-5 | Easpring public |
| LG Energy Solution (KR) | (cell maker, not CAM directly) | World #2 in NMC cell market | LG Energy IR |
| Samsung SDI (KR) | (cell maker; SDI also has CAM thru subsidiaries) | World top-3 cell | Samsung SDI IR |
| Sumitomo Metal Mining (JP) | NCA CAM | Tesla / Panasonic supplier | SMM IR |
| Mitsubishi Chemical / BTR / Shanshan (JP/CN) | natural + synthetic graphite anode | Major anode-material suppliers | vendor IR |
| Hitachi Chemical / Showa Denko (now Resonac, JP) | synthetic graphite anode | Major anode-material supplier | Resonac IR |
| Sila Nano / Group14 / Amprius (US) | **silicon anode** | Premium / niche commercial; Mercedes EQ Si-anode 2025 (Sila) | vendor press; Mercedes 2025 disclosure |
| QuantumScape (US) | **Li-metal solid-state separator** | R&D + sample shipments to OEMs; commercial **UNVERIFIED at ≥ 500 cycles** | QuantumScape IR |
| SES AI (US) | hybrid Li-metal | OEM A-sample 2023; commercial UNVERIFIED | SES IR |
| Solid Power (US) | sulfide solid-electrolyte + Li-metal | A-sample 2024; commercial UNVERIFIED | Solid Power IR |
| Tanaka Holdings (JP) | **Pt + Pd + Ir / Ru catalyst** (PEMFC + PEMEL) | Premium catalyst metal recycling + formulation | Tanaka IR |
| Heraeus (DE) | Pt + Pd + Ir catalyst | EU catalyst major | Heraeus IR |
| Johnson Matthey (UK) | Pt + Ir catalyst for fuel cell + electrolyzer | UK catalyst major | Johnson Matthey IR |
| Duracell / Energizer | EMD (electrolytic MnO₂) primary alkaline cathode | ~ M units / day AA alkaline | Duracell / Energizer technical |
| Tronox / Erachem / Tosoh | EMD supply for primary alkaline | ~ 200 kt/yr global EMD | vendor public |

> **Honesty caveat (LATTICE_POLICY §3.3):** electrode-material capacity
> is bounded by **CAM precursor sourcing (Li / Co / Ni / Mn / Fe-P /
> graphite vein-flake) + co-precipitation reactor throughput +
> calcination kiln capacity + downstream cell-maker qualification**
> — not by lattice arithmetic. Hunan Yuneng 700 kt/yr LFP and POSCO
> Future M 150 kt/yr NMC reflect plant + raw-material logistics, not
> lattice-derived. No projection onto n=6.

---

## §4 STRUCT — electrode-material material flow

```
[Raw inputs]
   LFP path:       Li₂CO₃ + Fe(NO₃)₃·9H₂O + (NH₄)₂HPO₄ + carbon source
   NMC path:       Li₂CO₃ or LiOH·H₂O + NiSO₄·6H₂O + MnSO₄·H₂O + CoSO₄·7H₂O
   Graphite path:  natural-flake graphite OR petcoke / pitch → 2800–3000 °C graphitization
   Silicon path:   Si-NP from CVD silane → SiO_x or Si@C composite
   Pt/C path:      H₂PtCl₆ aqueous + Vulcan XC-72 → impregnation + reduction
        ↓
   ┌────┴───────────────────┬────────────────────────┬────────────────────────┐
   ↓ LFP                    ↓ NMC                    ↓ graphite               ↓ Pt/C
[Co-precipitate            [Mixed-hydroxide          [Graphitize at            [Pt impregnation
 carbothermic at            precursor                  2800 °C]                 + H₂ reduction]
 700–900 °C]                Ni_aMn_bCo_c(OH)₂]
        ↓                       ↓                       ↓                       ↓
[LFP-C / LFP-Mn-doped]   [Mix with Li source +     [Synthetic graphite          [Pt/C (20–60 wt-% Pt)]
                          calcine 700–850 °C]       (300–370 mAh/g)]
        ↓                       ↓                       ↓                       ↓
[NMC811 / NMC622 / NCA   [Coat / surface-engineer  [Particle classify          [Catalyst with surface
 layered oxide]            with Al₂O₃ / LiNbO₃ /     d50 ~ 10–25 µm]           area 50–200 m²/g]
                            polymer]                                                ↓ to MEA (PEMFC)
        ↓                       ↓                       ↓
[Cathode active material — passed to hexa-energy for electrode coating / cell build]
[Anode active material  — passed to hexa-energy for electrode coating / cell build]
[Catalyst active material — passed to hexa-energy for MEA / GDL assembly]

           ↓ hexa-energy cell-engineering boundary (CROSS_LINK §3.3) ↓
                 (electrode coat + calender + stack + electrolyte
                  + formation cycle + BMS + cell test/qualification)
```

---

## §5 FLOW — process aspects in scope

| Process step | Material-aspect concern (this repo) | Out-of-scope (→ hexa-energy) |
|--------------|-------------------------------------|------------------------------|
| Raw-material sourcing | Li / Co / Ni / Mn / Fe / P / Pt / Ir purity grade | mining supply chain → hexa-earth |
| Precursor co-precipitation | hydroxide-precursor d50, sphericity, stoichiometry | reactor engineering |
| Calcination / sintering | phase purity (XRD), Li/M ratio, oxygen activity in kiln | kiln-line engineering |
| Surface coating / doping | Al₂O₃ / LiNbO₃ / Li₃PO₄ surface layer; cation doping | coating process engineering |
| Si particle architecture | C-shell, void space, particle size, % Si in graphite blend | composite assembly |
| Catalyst impregnation | Pt nanoparticle size 2–5 nm, support choice, dispersion | MEA assembly → hexa-energy |
| **Electrode coating** | (active material slurry rheology — informational) | **electrode coater + dryer + calendar → hexa-energy** |
| **Cell assembly + electrolyte fill** | (electrolyte SEI chemistry — informational) | **stacking / winding / formation → hexa-energy** |
| **Cycle testing / BMS** | (material cycle stability vs cell cycle stability — distinction load-bearing) | **cell + pack cycle life, BMS → hexa-energy** |
| End-of-life recovery | active-material recovery yield (Li / Co / Ni / Mn / Pt) | recycling plant engineering → recycling/ + hexa-earth |

---

## §6 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | LiCoO₂ cathode (Goodenough/Mizushima 1980) | Commodity (consumer electronics) |
| Mk.II | LiMn₂O₄ spinel cathode (Thackeray 1983) | Commercial niche |
| Mk.III | LiFePO₄ olivine cathode (Padhi/Goodenough 1997) | **Dominant 2024+ (CATL Blade, BYD Blade, ESS)** |
| Mk.IV | NMC family (LiNi_aMn_bCo_cO₂; Liu 1999+; high-Ni 2010s) | Commercial (premium EV) |
| Mk.V | NCA family (LiNi_aCo_bAl_cO₂; Sumitomo 1999+) | Commercial (Tesla 2170 / Panasonic) |
| Mk.VI | Graphite anode (Yoshino 1985 prototype; commercial 1991 Sony) | Commodity (workhorse anode) |
| Mk.VII | Hard-carbon anode (Na-ion + Li-ion) | Commercial (Na-ion 2023+) |
| Mk.VIII | Silicon-graphite blended anode (5–10 % Si) | Commercial (Tesla 4680, Mercedes EQ) — **full Si UNVERIFIED at commodity (F-EM-1)** |
| Mk.IX | Li-metal anode w/ solid electrolyte | R&D — **dendrite suppression ≥ 500 cycles UNVERIFIED (F-EM-3)** |
| Mk.X | Li-S cathode (1675 mAh/g theoretical) | R&D — polysulfide shuttle UNVERIFIED at long cycle |
| Mk.XI | Pt-Co / Pt-Ni alloy ORR catalyst (Pt-loading reduction) | Commercial PEMFC (Toyota Mirai-2) — DOE 0.44 A/mg_Pt target UNVERIFIED |
| Mk.XII | Pt-free ORR (Fe-N-C single-atom catalyst) | R&D — UNVERIFIED at PEMFC durability |
| Mk.XIII | IrO₂-free PEM-OER catalyst (cost reduction) | R&D — UNVERIFIED |
| Mk.XIV | Anion-exchange-membrane (AEM) electrolyzer with Pt/Ir-free catalyst | R&D — UNVERIFIED at long durability |
| Mk.XV | Sustainable-Co + cobalt-free chemistry (LFP / LMFP / Mn-rich) | Commercial (LFP dominant; LMFP emerging) |
| Mk.XVI | Cathode-active-material direct recycling (vs hydromet smelter) | R&D — UNVERIFIED at industrial yield |

---

## §7 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| **Cell + pack engineering** (coating, calendering, stacking, formation, BMS, cycle test, thermal mgmt) | **`hexa-energy` (sibling — battery + pack + grid integration)** |
| Battery recycling (hydromet / pyromet / direct) | `recycling/recycling.md`; sibling `hexa-energy` |
| Mining supply (Li / Co / Ni / Mn brine + ore) | `hexa-earth` (climate + minerals); informational only |
| Compound-semiconductor (SiC for power electronics in BMS) | `compound-semi/compound-semi.md` |
| Carbon anode (graphite + hard carbon + CNT-supported) | `carbon/carbon.md` (cross-link to anode allotropy) |
| Silicon anode raw material (Si-NP, Si from CVD silane) | `silicon/silicon.md` |
| MOF as battery / catalyst support (research) | `mof/mof.md` |
| Perovskite as fuel-cell cathode (LSM / LSCF) | `perovskite/perovskite.md` |
| Magnetic materials for motor (separate from electrode) | `magnetic-materials/magnetic-materials.md`; sibling `hexa-mobility` |
| Pt + Ir mining and recycling | `recycling/recycling.md` (informational) |
| Coolant chemistry for battery pack thermal mgmt | `polymer-chemistry` informational; sibling `hexa-grid` (datacenter coolant) |

---

## §8 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| NIST Electrochemistry Reference Database SRD 17 | NIST | thermodynamic anchors (E°, ΔG_f for Li compounds) |
| Padhi, Nanjundaswamy, Goodenough *JES* 144, 1188 (1997) | journal | LFP EM-L1 sanity |
| Mizushima, Goodenough et al. *Mater. Res. Bull.* 15, 783 (1980) | journal | LCO EM-L2 founding |
| Sun Yang-Kook — NMC-Ni-rich review *JES* 2017 | journal | NMC811 EM-L3 sanity |
| Whittingham *Chem. Rev.* 104, 4271 (2004) | journal | Intercalation electrochemistry founding |
| Yoshino — 2019 Nobel Lecture | journal/lecture | Li-ion battery founding |
| Obrovac & Christensen *Electrochem. Solid-State Lett.* 7, A93 (2004) | journal | Si EM-L5/L6 |
| Beaulieu et al. *JES* 150, A1457 (2003) | journal | Si EM-L6 volume |
| Manthiram *Nat. Commun.* 11, 1550 (2020) | journal | Ni-rich review |
| Manthiram *Chem. Rev.* 114, 11751 (2014) | journal | Li-S EM-L8 |
| Reier et al. *J. Phys. Chem. Lett.* 5, 12 (2014) | journal | IrO₂ OER EM-L15 |
| US DOE Hydrogen Program 2025 milestones | DOE | EM-L13/L14/L16 sanity |
| **IEC 62660** — secondary Li-ion cells for propulsion of EVs | IEC | cell test (informational; hexa-energy owns) |
| **IEC 61960** — secondary Li-ion for portable applications | IEC | cell test (informational) |
| **ASTM E1019** — instrumental analysis of C / S / N / O in metals | ASTM | precursor purity |
| USGS Mineral Commodity Summaries 2024 | USGS | EM-L20 Co supply concentration |
| CATL Blade / BYD Blade public datasheets | vendor | EM-L9 / EM-L18 sanity |
| Umicore / POSCO Future M / EcoPro BM / Sumitomo Metal Mining datasheets | vendor | NMC + NCA CAM anchors |
| QuantumScape / Solid Power / SES IR | vendor | EM-L12 UNVERIFIED bracket |
| Tanaka Holdings / Heraeus / Johnson Matthey catalyst public | vendor | Pt-ORR + IrO₂-OER anchors |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-EM-1 | Silicon-anode (Si > 50 % by capacity) at 500-cycle 1C 70 % retention at full commodity production (not premium / niche) | OPEN |
| F-EM-2 | LFP cycle life > 12,000 cycles independently reproduced at multi-vendor cell production | OPEN (CATL Blade claim; multi-vendor confirmation pending) |
| F-EM-3 | Li-metal anode + solid-electrolyte at ≥ 500 deep cycles 70 % retention at commercial production yield | OPEN |
| F-EM-4 | Pt-free ORR catalyst at PEMFC commercial durability (> 30,000 hr equivalent) | OPEN |
| F-EM-5 | Pt mass-activity ≥ 0.44 A/mg_Pt at 0.9 V vs RHE at PEMFC commercial loading (DOE 2025 target) | OPEN |
| F-EM-6 | Li-S cathode cycle life > 1000 cycles 70 % retention at > 4 mAh/cm² areal capacity production | OPEN |
| F-EM-7 | NMC-cathode direct (vs hydromet) recycling at > 95 % cathode-material recovery industrial | OPEN |
| F-EM-8 | LMFP (lithium-manganese-iron-phosphate) at commercial parity with LFP energy density at scale | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "LFP 170 mAh/g fits σ·τ × 14.2" — coincidence; do not write
- ✗ "CATL / BYD / POSCO Future M / Umicore capacity tracks n=6" — they have not heard of it
- ✗ "Si-anode at 4200 mAh/g is a production reality" — UNVERIFIED at commodity scale (F-EM-1)
- ✗ "Li-metal solid-state batteries are commercial-ready" — UNVERIFIED at ≥ 500 deep cycles (F-EM-3)
- ✗ "Electrode material owns cell cycle life" — **false; cell cycle life is set by
  electrolyte SEI + separator + electrode-coating + formation + temperature. The
  active material caps the upper bound; cell engineering (in hexa-energy) determines
  realized cycle life per CROSS_LINK §3.3.**
- ✗ "Battery cell engineering belongs to hexa-matter" — **false; CROSS_LINK §3.3
  cedes cell + pack to hexa-energy. This verb owns the ACTIVE MATERIAL only.**
- ✗ "Cobalt is irreplaceable" — false; LFP demonstrates Co-free chemistry at
  commercial scale; LMFP / Mn-rich extend the envelope
- ✗ "Pt mass-activity is at DOE target in production" — UNVERIFIED at 0.44 A/mg_Pt;
  production typically 0.10–0.30 A/mg_Pt
- ✗ "Energy density of cell can be claimed at the material level" — cell-level Wh/kg
  (EM-L18 / EM-L19) is vendor-published context; the cell engineering claim belongs
  to hexa-energy. This verb's primary metric is mAh/g of active material.

**Related NOVEL candidates** (Tier-1 hypotheses, status as of 2026-05-13):
`hxm-bat-cath-drx-001` — see [NOVEL.md §4.A.1](../NOVEL.md) (Li-Mn-Nb-Ti DRX
rock-salt cathode); `hxm-bat-anode-li-metal-001` — see [NOVEL.md §4.A.5](../NOVEL.md)
(50 µm Li-foil anode on 3D Cu host); `hxm-h2-elec-iro2-doped-001` — see
[NOVEL.md §4.B.1](../NOVEL.md) (Ir-Ru oxide OER PEM electrocatalyst,
proxy prediction (if SIM-NNP-PROXY) is NOT measurement and does NOT promote to
EXTERNAL-VERIFIED. This verb is the material-layer authority for all three
chemistries; cell engineering boundary → `hexa-energy` per CROSS_LINK §3.3.

**Related NOVEL candidate** (Tier-2): `hxm-bat-cath-naion-001` — see
[NOVEL.md §4.A.3](../NOVEL.md) (vacancy-controlled Na-PBA Prussian-blue
cathode). SIM / proxy status is NOT a measurement and does NOT promote to
`EXTERNAL-VERIFIED` without attributed external-lab evidence.


---

## §9 Honest scope + caveats

1. **Material layer only. Cell engineering belongs to `hexa-energy`
   per CROSS_LINK.md §3.3 — this verb owns active material only.**
   Electrode coating, calendering, stacking/winding, electrolyte
   filling, formation cycling, BMS, cell-level Wh/kg + cycle life
   under cell-engineering conditions — those are `hexa-energy`
   cell-engineering claims; **not here**.

2. **Si-anode 500-cycle 1C 70 % retention UNVERIFIED at full
   commodity (EM-L11, F-EM-1).** Blended Si-graphite (5–10 % Si by
   capacity) is commercial (Tesla 4680, Mercedes EQ Si). Pure or
   high-Si (> 50 %) at commodity scale is **UNVERIFIED** as of 2024.
   Sila Nano (Mercedes 2025), Group14, Amprius report lab + niche
   production progress.

3. **Li-metal anode dendrite suppression UNVERIFIED for ≥ 500 deep
   cycles (EM-L12, F-EM-3).** QuantumScape, SES, Solid Power, Cuberg,
   Sion Power all show R&D progress; commercial cells at > 500 deep
   cycles at production yield are **UNVERIFIED**. Toyota's 2027/2028
   solid-state EV target is anchored on this material breakthrough.

4. **CATL Blade 12,000-cycle LFP claim — multi-vendor reproduction
   pending (F-EM-2).** LFP cycle life > 6000 is well-replicated;
   12,000-cycle CATL claim is single-vendor as of 2024.

5. **Pt loading reduction roadmap UNVERIFIED at production lifetime
   (EM-L16).** DOE 2025 targets (0.1 g_Pt/kW PEMFC; 0.5 g_Ir/kW
   PEMEL) at commercial durability not yet met at scale.

6. **Co supply concentration is a real geopolitical risk (EM-L20).**
   > 70 % Co from DRC drives LFP / LMFP / Mn-rich adoption beyond
   pure electrochemistry merit. Supply-chain resilience is a
   material-strategy fact, not a chemistry claim.

7. **No lattice anchoring of vendor numbers.** Umicore / POSCO
   Future M / CATL / BYD / LG Energy Solution / Samsung SDI /
   Sumitomo Metal Mining / Tanaka Holdings capacities cited verbatim;
   no projection onto n=6.

8. **SPEC_FIRST verdict.** No numbers in this file are MEASURED in
   this repo; all from NIST / DOE / IEC / ASTM / USGS / peer-
   reviewed literature / vendor public disclosures. Working `.hexa`
   numerical sandbox for electrode-material is TBD.

9. **Coincidence disclosure (LATTICE_POLICY §1.1).** Any apparent
   fit of electrode-material numbers to n=6 (e.g., graphite
   372 mAh/g ≈ J₂(6) × 15.5) is coincidence with verification power
   zero.

---

## §10 References

- Mizushima K., Jones P.C., Wiseman P.J., Goodenough J.B., "Li_xCoO₂
  (0 < x ≤ 1): a new cathode material for batteries of high energy
  density," *Mater. Res. Bull.* 15, 783 (1980) — LCO founding
- Padhi A.K., Nanjundaswamy K.S., Goodenough J.B., "Phospho-olivines
  as positive-electrode materials for rechargeable lithium batteries,"
  *J. Electrochem. Soc.* 144, 1188 (1997) — LFP founding paper
- Yoshino A., "The birth of the lithium-ion battery," *Angew. Chem.
  Int. Ed.* 51, 5798 (2012); 2019 Nobel Lecture
- Whittingham M.S., "Lithium batteries and cathode materials," *Chem.
  Rev.* 104, 4271 (2004) — intercalation electrochemistry
- Thackeray M.M., David W.I.F., Bruce P.G., Goodenough J.B., "Lithium
  insertion into manganese spinels," *Mater. Res. Bull.* 18, 461
  (1983) — LMO founding
- Sun Yang-Kook et al., "Nickel-rich and lithium-rich layered oxide
  cathodes," *Adv. Energy Mater.* 6, 1501010 (2016); *JES* 2017 review
- Manthiram A., "An outlook on lithium ion battery technology," *ACS
  Cent. Sci.* 3, 1063 (2017); *Nat. Commun.* 11, 1550 (2020) — Ni-rich
- Manthiram A., Fu Y., Chung S.-H., Zu C., Su Y.-S., "Rechargeable
  lithium-sulfur batteries," *Chem. Rev.* 114, 11751 (2014) — Li-S
- Obrovac M.N., Christensen L., "Structural changes in silicon anodes
  during lithium insertion/extraction," *Electrochem. Solid-State
  Lett.* 7, A93 (2004) — Si lithiation chemistry
- Beaulieu L.Y., Hatchard T.D., Bonakdarpour A., Fleischauer M.D.,
  Dahn J.R., "Reaction of Li with alloy thin films studied by in situ
  AFM," *J. Electrochem. Soc.* 150, A1457 (2003) — Si volume change
- Reier T., Oezaslan M., Strasser P., "Electrocatalytic oxygen
  evolution reaction (OER) on Ru, Ir, and Pt catalysts: a comparative
  study of nanoparticles and bulk materials," *ACS Catal.* 2, 1765
  (2012); *J. Phys. Chem. Lett.* 5, 12 (2014) — OER overpotential
- Greeley J., Stephens I.E.L., Bondarenko A.S., Johansson T.P.,
  Hansen H.A., Jaramillo T.F., Rossmeisl J., Chorkendorff I., Nørskov
  J.K., "Alloys of platinum and early transition metals as oxygen
  reduction electrocatalysts," *Nat. Chem.* 1, 552 (2009) — Pt-ORR
- Stephens I.E.L., Bondarenko A.S., Grønbjerg U., Rossmeisl J.,
  Chorkendorff I., "Understanding the electrocatalysis of oxygen
  reduction on platinum and its alloys," *Energy Environ. Sci.* 5,
  6744 (2012)
- US DOE Hydrogen Program 2025 milestones — Pt mass activity + Pt + Ir
  loading targets
- **IEC 62660-1/2/3** — Secondary lithium-ion cells for the propulsion
  of EVs (cell test — note: cell-level test, hexa-energy domain)
- **IEC 61960** — Secondary lithium-ion cells for portable applications
- **ASTM E1019** — Standard test methods for determination of carbon,
  sulfur, nitrogen, and oxygen in steel, iron, nickel and cobalt alloys
- **USGS Mineral Commodity Summaries 2024** — Co / Li / Ni / Mn /
  graphite / Pt-group metals supply
- **NIST SRD 17** — Electrochemical thermodynamics
- Umicore — NMC + NCA + LCO technical brochures; IR 2023
- POSCO Future M — NMC + NCA + graphite IR 2023
- EcoPro BM / L&F / Ronbay / Easpring — NMC + NCA CAM IR
- CATL — Blade LFP technical disclosure; IR 2023; 12,000-cycle claim
- BYD — Blade LFP technical disclosure; IR 2023
- Hunan Yuneng — LFP capacity disclosure 2023
- LG Energy Solution / Samsung SDI / Panasonic — cell IR
- Sumitomo Metal Mining — NCA technical brochure
- Mitsubishi Chemical / BTR / Shanshan / Resonac / Hitachi Chemical —
  graphite anode technical brochures
- Sila Nano (Mercedes 2025) / Group14 / Amprius — Si-anode public
- QuantumScape / SES AI / Solid Power / Cuberg / Sion Power — Li-metal
  + solid-state IR
- Tanaka Holdings / Heraeus / Johnson Matthey — Pt + Ir catalyst
- Duracell / Energizer / Tronox / Erachem / Tosoh — EMD (MnO₂) public
- `LATTICE_POLICY.md` §1.2 + §1.3 (this repo)
- `LIMIT_BREAKTHROUGH.md` (this repo) — Wave M materials audit
- `CROSS_LINK.md` §3.3 (this repo) — hexa-energy boundary
- Cross-link siblings: `silicon/silicon.md`, `carbon/carbon.md`,
  `compound-semi/compound-semi.md`, `mof/mof.md`,
  `perovskite/perovskite.md`, `magnetic-materials/magnetic-materials.md`,
  `recycling/recycling.md`, `hexa-energy` (battery + cell + pack
  engineering), `hexa-earth` (mineral mining / climate)

---

*Authored 2026-05-13 by 박민우. Material-layer spec for hexa-matter's
Phase D'' `electrode-material` verb (36 of 36 — closes the 33→36
expansion). Real-limits-first per LATTICE_POLICY.md §1.2; no lattice
fit on electrode-material parameters or Umicore / POSCO Future M /
CATL / BYD / LG Energy Solution / Samsung SDI / Sumitomo Metal Mining
/ Tanaka Holdings vendor capacities. **Si-anode 500-cycle 1C 70 %
retention UNVERIFIED at full commodity scale** (F-EM-1). **Li-metal
anode dendrite suppression UNVERIFIED for ≥ 500 deep cycles** (F-EM-3).
Pt-loading reduction roadmap UNVERIFIED at production durability.
Cell engineering (coating, calendering, stacking, formation, BMS,
cell + pack cycle life) belongs to `hexa-energy` per CROSS_LINK §3.3
— this verb owns the ACTIVE MATERIAL only.*
