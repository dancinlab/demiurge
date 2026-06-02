# SILICON — extended chapter (material layer)

> **Authored**: 2026-05-13 (Phase A elevation)
> **Author**: 박민우 <nerve011235@gmail.com>
> **Scope**: material layer of silicon (poly-Si, mono-Si wafer, SiO₂, SiC/SiN ceramics, silicone polymer).
> **Out of scope**: semiconductor *device + fab process* — that lives in `hexa-chip` (call `hexa-chip materials`).
>
> Hemlock, Wolfspeed, Shin-Etsu, SUMCO, etc.) are cited from each company's
> own published numbers. The n=6 invariant lattice does **NOT** predict any
> silicon parameter. Any apparent fit is coincidence.
>
> **Cross-ref**: `silicon/silicon.md` (the spec doc with the Si-L1..Si-L12
> limits table). This file goes deeper into physics + production economics.

---

## §1 Why silicon belongs in hexa-matter — the material-layer argument

Silicon is the second-most-abundant element in the Earth's crust (~27.7 % by mass, CRC Handbook 105th ed.). It is the **largest single material input by mass** to the global electronics industry. As a *material*, silicon decomposes into 5 distinct forms with distinct supply chains, distinct processing routes, and distinct end-uses:

| Form | Phase | Producers (top 5) | End-use sector |
|------|-------|-------------------|----------------|
| Metallurgical-grade Si (MG-Si, ~98% pure) | crystalline solid | Ferroglobe, Elkem, Wacker, Liasa, Mississippi Silicon | aluminum alloy, silicone feedstock, deoxidizer |
| Solar-grade poly-Si (SoG, 6N-7N) | granular / chunk | GCL, Daqo, Tongwei, Xinte, OCI | photovoltaic ingot |
| Electronic-grade poly-Si (EG, 9N+) | granular / chunk | Wacker, Hemlock, Tokuyama, OCI, REC | semiconductor ingot feedstock |
| Monocrystalline Si (mono-Si wafer, CZ or FZ pulled) | single crystal | Shin-Etsu, SUMCO, Siltronic, GlobalWafers, SK Siltron | semiconductor wafer, MEMS, image sensor |
| Compound forms (SiO₂, SiC, Si₃N₄, silicone) | various | Heraeus, Corning (SiO₂); Wolfspeed, Cree (SiC); Dow, Wacker, Shin-Etsu (silicone) | optics, ceramics, sealants, MOSFETs (SiC power) |

The semiconductor *device* (transistor, MOSFET, BJT, lithographically patterned) is downstream of the wafer; that downstream-device stack lives in `hexa-chip`. The wafer itself, the polysilicon that feeds the wafer, and the SiO₂/SiC ceramics that share silicon's chemistry — those live HERE.

---

## §2 Czochralski (CZ) pull — the workhorse for mono-Si

### §2.1 Geometry + physics

Czochralski's 1918 method (originally developed for measuring crystallization rates in metals; adapted by Teal & Buehler at Bell Labs in 1949-1950 for Si) is the dominant production route for mono-Si wafers used in semiconductor fabrication.

The geometry:

```
          ─── seed crystal (rotates ~ 5-20 rpm)
            |
            ↑  pull rate v_p ≈ 1-2 mm/min for 300mm class
            |
        ┌───┴───┐ ← solid-liquid interface (the meniscus)
        │       │
        │       │ ← solidifying ingot
        │       │
        │       │
        ├───────┤
        │ │ │ │ │ ← melt (Si at ~1685 K, just above T_m 1687 K)
        │ │ │ │ │
       /         \  ← fused-silica crucible (rotates ~ 5-15 rpm
      /           \    in opposite direction; "double rotation")
     /             \
    └───────────────┘
         heater zone (RF coil or resistance heater, holds T_melt)
```

### §2.2 Pull rate physics

The maximum stable pull rate v_p,max is set by **heat extraction from the solid-liquid interface**. The solidification releases latent heat ΔH_f ≈ 50.5 kJ/mol Si (~1.80 kJ/g). For a column of cross-section A and pull rate v_p:

$$q_{\text{latent}} = \rho_s \cdot v_p \cdot A \cdot \Delta H_f$$

This heat must be conducted up the ingot (length L) against the radial heat loss. Using Fourier conduction with axial gradient dT/dz at the interface and Si's thermal conductivity k_Si ≈ 22 W/m·K at 1685 K:

$$q_{\text{cond}} = k_{Si} \cdot A \cdot \frac{dT}{dz}\bigg|_{\text{interface}}$$

Balancing q_latent + q_radiation = q_cond gives v_p,max ≈ a few mm/min at 300 mm wafer diameter; ≈ 2-3 mm/min at 200 mm; pull faster and the interface destabilizes into a constitutional supercooling regime → polycrystalline growth or dislocation generation.

In production, **practical v_p ≈ 0.5-1.5 mm/min** for 300 mm ingots, giving ~ 50-100 hours per 1-meter-long ingot. The economics are heavily dominated by this cycle time × crucible-life × yield product.

### §2.3 CZ crucible — the dimensional bottleneck (Si-L3)

CZ pulls are constrained by the fused-silica crucible:
- Maximum diameter set by **fused-silica creep at 1500 °C** + **mechanical handling** during melt-down + **wall thinning** during pull (Si attacks the crucible at high T, dissolving ~1-3 mm per pull)
- Industrial ceiling: ~600 mm crucible diameter (32-inch class), capable of supporting 300 mm wafer pulls + (R&D) 450 mm wafer pulls
- Crucible life: typically 1 pull (consumed) for production-grade; recharge-pulls (multiple ingots per crucible) used for some advanced setups


### §2.4 Dopant + oxygen + carbon control

CZ-pulled Si inherits several "contaminants" from the crucible + ambient:

| Species | Origin | Typical level | Effect |
|---------|--------|---------------|--------|
| Interstitial O ([O_i]) | crucible SiO₂ dissolution | 10-30 ppma | thermal-donor formation at 450 °C; can be desirable (gettering) or undesirable |
| Substitutional C ([C_s]) | graphite heaters + ambient | < 0.5 ppma | precipitates as SiC; dislocation source |
| Boron (B) | intentional p-type dopant | 10¹⁴ - 10¹⁹ cm⁻³ | acceptor; controls resistivity |
| Phosphorus (P) | intentional n-type dopant | 10¹⁴ - 10¹⁹ cm⁻³ | donor |

The dopant is added to the melt directly (B or P metal pellets, or B₂O₃, or P-rich master alloy). Segregation coefficient k_B ≈ 0.8, k_P ≈ 0.35 — meaning the *first* part of the ingot accepts dopant less than the melt average, and the *last* part is enriched. This causes **axial resistivity variation** that limits usable ingot length to ~70-80% for tight-spec applications.

---

## §3 Float-zone (FZ) — for high-purity, niche use

### §3.1 Why FZ exists

Float-zone (FZ) is **crucible-free**: a polysilicon rod is partially melted by an RF coil, with the molten zone held in place by surface tension. The rod is moved axially through the coil; impurities segregate to one end. This avoids crucible contamination → **purer than CZ** for O, C, and metallic species.

Trade-offs:
- Maximum rod diameter ~200 mm (limited by surface-tension support of the molten zone)
- Higher cost than CZ (~$1500-3000/wafer vs ~$300/wafer for CZ 300mm)
- Limited dopant control (no melt addition; gas-phase doping or starting-rod doping only)

### §3.2 Use cases (niche but load-bearing)

- **High-voltage power devices** (IGBT, thyristor) — need very low O_i to avoid recombination centers
- **Particle / neutron detectors** — need ultra-low metallic impurities
- **Niche solar (high-efficiency PERC bifacial)** — minority carrier lifetime sensitive to O_i
- **Quantum computing isotope-Si-28 substrate** — see §7

### §3.3 Physics of the molten zone

The RF coil provides:
- Eddy-current heating of the melt
- Electromagnetic levitation force (supplements surface tension in supporting the zone)

The molten zone is stable when:

$$\rho_l \cdot g \cdot h_{\text{zone}} \lesssim \gamma_{lv} / r_{\text{rod}}$$

with γ_lv (Si liquid-vapor surface tension) ≈ 0.86 N/m and ρ_l (liquid Si density) ≈ 2.53 g/cm³. For r_rod = 100 mm (200 mm diameter), h_zone_max ≈ 25 mm — quite thin. At larger r_rod, the zone can't be supported and the melt drips.

This is why Si-L4 = 200 mm — surface tension hits a wall.

---

## §4 Donor concentration + defect engineering

### §4.1 Thermal donor formation in CZ Si (Si-L8)

CZ Si has 10-30 ppma interstitial O (Si-L9). Annealing at **450 °C** clusters O into thermal donor (TD) complexes: TD-1, TD-2, ..., TD-N, with TD-N having N+1 oxygen atoms and donating ~ 2 electrons. Concentration:

$$[TD]_{\text{max}} \sim 10^{16} \text{ cm}^{-3} \text{ at } 450°C, t = 60\text{ min}$$

Above 650 °C, TDs anneal out. Above 750 °C, "new" donors (also O-related but different) form. Wafer manufacturing typically uses a **donor-killer anneal** at ~ 650-700 °C for ~30 min before shipping.

References: Kaiser & Frisch 1958 *Phys. Rev.* 109, 1428; Bullis SEMI; Newman 2000 *J. Phys.: Condens. Matter* 12, R335.

### §4.2 Dislocation density (Si-L10)

A perfect Si crystal has **0 dislocations**. Modern CZ + FZ production routinely achieves < 100 cm⁻² etch-pit count (ASTM F47 method). The ceiling is **0 / achievable**, set by the dislocation-free pull condition (Dash necking — a thin neck at the seed where existing dislocations grow out of the crystal before the body widens, leaving a defect-free volume).

Wafer-scale dislocation density is the single biggest "yield" lever in mono-Si. A wafer with 10⁵ cm⁻² dislocations is usable only for low-performance silicon (early CMOS); 10² cm⁻² is acceptable for modern logic; < 10 cm⁻² is the spec for high-performance imaging sensors.

### §4.3 BMD (bulk micro-defect) — gettering engineering

Interstitial O in CZ Si is intentionally **precipitated** during high-T processing (~1100 °C) to form bulk micro-defects (BMDs) — typically SiO_x clusters of 10-100 nm. These BMDs serve as **gettering sinks** for metallic contaminants (Fe, Cu, Ni) during downstream device processing.

The gettering scheme:
1. Wafer is grown with [O_i] = ~ 25 ppma
2. Cz-Si donor-kill anneal (650 °C / 30 min) → removes thermal donors
3. Subsequent device processing (well anneal, oxide growth) → BMDs nucleate at oxide precipitate sites
4. Metallic impurities diffuse to BMDs (gettering) → active device region near wafer surface stays clean

This is why CZ Si is preferred over FZ for **CMOS logic** — the BMD gettering capability is load-bearing.

---

## §5 Etch-rate vs orientation — wafer surface engineering

Si has 4 commonly-used crystal orientations: (100), (110), (111), (113). Each has different chemistry:

| Orientation | Bond density | Etch rate in KOH (80°C, 30%) | Use |
|-------------|-------------|------------------------------|-----|
| (100) | 4 / unit cell | ~1.4 µm/min | CMOS logic, MEMS bulk-micromachining |
| (110) | 4 / unit cell | ~3.0 µm/min (highest) | trench-MEMS, deep RIE alternatives |
| (111) | 6 / unit cell | ~0.004 µm/min (slowest, ~250× slower than 100) | etch-stop layer in MEMS |
| (113) | 4 / unit cell | intermediate | niche photonics |

The (111) face is the **slow etch face** because it has the highest bond density (one dangling bond per surface atom; the other 3 bonds are into the bulk). This (111) etch-stop is what enables anisotropic wet etching of Si for MEMS structures (pyramids, V-grooves, cantilevers).

Reference: Seidel et al. 1990 *J. Electrochem. Soc.* 137, 3612.

---

## §6 Polished wafer flatness specs

A modern 300 mm CMOS-grade Si wafer must meet:

| Spec | Typical value | Why |
|------|---------------|-----|
| Diameter | 300.00 ± 0.20 mm | tooling fits |
| Thickness | 775 ± 25 µm | mechanical handling |
| Bow | < 25 µm | photolithography depth-of-focus |
| Warp | < 25 µm | photolithography flatness |
| Total Thickness Variation (TTV) | < 1.5 µm | front/back side flatness |
| Site Front Surface Referenced Local Range (SFQR) | < 30 nm over 25 mm × 25 mm site | EUV depth-of-focus < 100 nm |
| Surface roughness (Ra) | < 0.1 nm RMS | charge carrier mobility |
| Edge profile | SEMI M1 spec | wafer-handling robotic edge contact |

The 25 nm SFQR requirement is set by **EUV lithography depth-of-focus**: the EUV stepper images a chip pattern over a ~ 25-mm-square area; if the wafer is locally tilted by > 30 nm across that area, the pattern blurs.

This makes wafer flatness a **device-driven spec**, not a material-physics spec — but it's the spec the material has to hit to be usable. The polishing process (CMP — chemical-mechanical polishing) is what closes the spec.

---

## §7 Isotope-Si-28 — quantum-compute substrate

Natural Si is a mix of three isotopes:
- ²⁸Si: 92.23 % (spin-0, no nuclear magnetic moment)
- ²⁹Si: 4.67 % (spin-1/2)
- ³⁰Si: 3.10 % (spin-0)

For **silicon-based quantum compute** (spin qubits — Loss-DiVincenzo proposal, Kane proposal, modern Diraq + SQC implementations), the ~5% spin-1/2 ²⁹Si is a coherence-killing magnetic-noise source. Solution: **isotope-separated ²⁸Si**, with [²⁹Si] reduced from natural 4.67 % to < 50 ppm (a 1000× reduction).

### §7.1 Production routes

| Method | Cost (USD/g) | Throughput | Status |
|--------|--------------|------------|--------|
| Avogadro Project SiF₄ centrifuge | ~ 100 000 | g/year | Production proven (1 kg, single-crystal grown by Russian Avogadro effort in 2014) |
| Diraq Australia / NMI thermal diffusion | (research) | mg/year | Lab-scale |
| Wacker / Hemlock SiF₄ → SiH₄ → Si CVD | future | (unproven at commercial scale) | Not yet |

Reference: Becker et al. 2010 *Phys. Status Solidi A* 207, 49 (Avogadro production); Wolfowicz et al. 2013 *Nat. Nanotechnol.* 8, 561 (²⁸Si coherence times).

### §7.2 Cost ceiling — the real bottleneck

At ~$100k/g, even a 100 mg active region for a quantum chip costs $10k in raw substrate. Scaling to 1 cm² of isotope-pure Si layer (~ 0.5 g) at 100 nm thickness is ~ $50k of substrate alone. **HARD wall on cost** — this is what limits commercial Si-based quantum compute to research scale through 2030s.


---


### §8.1 Polysilicon production (electronic + solar combined)

Industry-published nameplate capacity, 2024-2025 reporting:

| Producer | Country | Capacity (kt/yr) | Source |
|----------|---------|------------------|--------|
| GCL Technology | China | ~480 | GCL annual report 2024 |
| Tongwei Solar | China | ~450 | Tongwei annual report 2024 |
| Daqo New Energy | China | ~210 | Daqo 2024 filings |
| Xinte Energy | China | ~200 | Xinte annual report 2024 |
| OCI Holdings (Malaysia + Korea) | KR/MY | ~50 | OCI 2024 |
| Wacker Polysilicon | Germany/USA | ~80 (electronic-grade dominated) | Wacker 2024 |
| Hemlock Semiconductor (Michigan) | USA | ~50 (electronic-grade) | Hemlock public statements |
| REC Silicon (USA — closed 2024) | USA | 0 (closed) | REC Silicon 2024 shutdown announcement |

**Trend 2015-2025**:
- 2015 total ~ 380 kt/yr; 2025 total ~ 1500 kt/yr
- ~4× growth driven by solar (China-dominated)
- Electronic-grade ~ 280-330 kt/yr (rough 2024 estimate; not all reported)
- China share: 2015 ~50% → 2025 ~85% of global polysilicon
- US production declined: REC closed 2024; Hemlock + Wacker Charleston remain

### §8.2 Mono-Si wafer production (300 mm equivalent)

| Producer | Country | Mono-Si wafer share | Note |
|----------|---------|---------------------|------|
| Shin-Etsu Handotai | Japan | ~28 % | World's largest |
| SUMCO | Japan | ~24 % | |
| GlobalWafers | Taiwan | ~17 % | (after acquisitions) |
| Siltronic | Germany | ~13 % | |
| SK Siltron | Korea | ~12 % | |
| Others | various | ~6 % | |

### §8.3 SiC wafer production (4H-SiC for power devices)

SiC is the **second material-revolution** in silicon's ecosystem (the first being mono-Si itself). Wolfspeed (formerly Cree) is the dominant 6-inch SiC wafer producer; II-VI (Coherent), STMicroelectronics + Soitec, and Resonac are also in the market. 8-inch SiC wafers entered production in 2022-2024.

Volume context: global SiC wafer production ~ 1.5M wafers/yr (4-6-inch) in 2024; projected ~ 6M wafers/yr by 2030 driven by EV / motor inverter demand.

### §8.4 Honest C3 disclaimer

Per `silicon/silicon.md §3`: "Numbers are vendor / market-research published; this spec **does not project these onto n=6 nor claim n=6 is implicated**."

The trends above are reported facts. No lattice fit applied to any number.

---

## §9 Post-2030 outlook

### §9.1 What is technologically certain (HARD constraints)

1. **Si bandgap is 1.12 eV** — no engineering can change this. Si remains the dominant logic platform because manufacturing maturity + cost dominate; no alternative competes at scale through 2040+.
2. **Si melts at 1687 K** — sets the thermal-process envelope for all back-end manufacturing.
3. **CZ crucible at ~600 mm** — physics-of-fused-silica limit; will not move > 30% absent a new crucible material.
4. **FZ rod at ~200 mm** — surface-tension limit; will not move without low-g (space-based) FZ pulls.

### §9.2 What is engineering-frontier (SOFT walls)

1. **Polysilicon purity** — 9N (Si-L1) → 11N achievable; cost barrier is the only ceiling.
2. **CZ pull rate** — currently 1-2 mm/min for 300mm; magnetic CZ (MCZ) and continuous CZ (CCZ) might push 2-3× by 2035.
3. **SiC wafer diameter** — 6 inch → 8 inch transition 2022-2024; 12 inch SiC by ~2030 is plausible.
4. **²⁸Si cost** — $100k/g → $10k/g by 2035-2040, driven by scale-up.

### §9.3 What is uncertain (research-frontier)

1. **Si photonics integration** — Si waveguides with III-V lasers; commercial scaling 2025-2030.
2. **Power-SiC vs power-GaN** — competition for medium-voltage power; both win different sub-markets.
3. **3D NAND / stacking limits** — mono-Si vs alternatives for cell architecture.
4. **Si-based quantum compute commercial viability** — Diraq / SQC trajectory through 2030s.

---

## §10 Cross-links

| Cross-ref | Type | Why |
|-----------|------|-----|
| `silicon/silicon.md` | spec doc | Si-L1..Si-L12 limits table |
| `glass/glass.md` | substrate | SiO₂ as fused silica / silicate glass component |
| `ceramics/ceramics.md` | substrate | SiC, Si₃N₄ ceramics |
| `metallurgy/metallurgy.md` | alloy element | Al-Si casting alloy, Fe-Si electrical steel, Cu-Si bronze |
| `MATERIAL-SYNTHESIS.md` | process | Siemens process for polysilicon |
| `hexa-chip` | sister repo | semiconductor device + fab process |
| `hexa-energy` | sister repo | photovoltaic device level (PV material flow is in hexa-matter; PV device design is in hexa-energy) |
| `LIMIT_BREAKTHROUGH.md` | real-limits anchor | L4 Mohs / L5 T_m / L7 T_g / L9 thermal k |

---

## §11 References (selected)

- **Czochralski J.** (1918). *Z. Phys. Chem.* 92, 219 — original method
- **Teal G.K. & Buehler E.** (1952). *Phys. Rev.* 87, 190 — Bell Labs Si CZ adaptation
- **Kaiser W. & Frisch H.L.** (1958). *Phys. Rev.* 109, 1428 — thermal donor formation
- **Dash W.C.** (1959). *J. Appl. Phys.* 30, 459 — Dash necking, dislocation-free pull
- **Seidel H. et al.** (1990). *J. Electrochem. Soc.* 137, 3612 — anisotropic Si etch in KOH
- **Becker P. et al.** (2010). *Phys. Status Solidi A* 207, 49 — Avogadro ²⁸Si production
- **Wolfowicz G. et al.** (2013). *Nat. Nanotechnol.* 8, 561 — ²⁸Si coherence times
- **Saddow S.E. & Agarwal A.** (2004). *Advances in Silicon Carbide Processing and Applications*. Artech House — SiC bandgap + crystal growth
- **Newman R.C.** (2000). *J. Phys.: Condens. Matter* 12, R335 — oxygen in Si review
- **SEMI M1** — Standard Specification for Polished Single-Crystal Si Wafers (most recent revision)
- **ASTM F121** — Standard Test Method for Interstitial Oxygen in Si by IR Absorption
- **ASTM F47** — Standard Test Method for Crystallographic Perfection by Etch-Pit Count
- **CRC Handbook of Chemistry and Physics**, 105th ed. (2024)
- **Hales T.C.** (2017). *Forum Math. Pi* 5, e2 — Kepler conjecture formal proof (touches Si packing as crystalline solid)

---


- Vendor tonnage figures in §8 cite each vendor's own annual report. **No lattice fit applied to any vendor capacity figure.**
- Si-L1..Si-L12 limits table is sourced from NIST WebBook, CRC Handbook 105th ed., ASM Handbook vol. 21, SEMI M1, ASTM F121/F1188/F47, and primary literature (Becker, Wolfowicz, Saddow, Kaiser, etc.). Each row has a citation.
- Forecasts in §9 are **engineering judgments**, not lattice predictions. The post-2030 outlook is conventional industry analysis (Siltronic / Siltronix annual outlooks; Wolfspeed earnings calls; ITRS 2030 roadmap).
- The n=6 invariant lattice does **NOT** appear in this chapter as a load-bearing predictor anywhere.
- Cross-links to sister-repo material (hexa-chip, hexa-energy) follow the "CLI integration over Python wrappers" sister-repo discipline (per `AGENTS.md` and `USER_ACTION_REQUIRED.md §6`).

---

*Document authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase A elevation — silicon deep-dive chapter, complementing `silicon/silicon.md` Si-L1..Si-L12 limits table with the production physics + economics + cross-link map.*
