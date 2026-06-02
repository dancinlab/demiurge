<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — hard + soft magnetic materials, BHmax, coercivity, Curie T -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; rare-earth supply data not lattice-fitted -->
---
domain: magnetic-materials
requires: []
verb_group: metal
status: SPEC_FIRST
verdict_basis: vendor datasheets + USGS Mineral Commodity Summaries; no lattice fit
---

# Magnetic Materials — n=6 소재 substrate, material verb (Phase D 23/29)

> **Material layer only.** Hard (permanent) magnets — NdFeB sintered +
> bonded, SmCo, AlNiCo, Sr/Ba ferrite. Soft (low-loss) magnets — Si-Fe
> electrical steel, permalloy, Mn-Zn / Ni-Zn ferrite, amorphous
> Metglas, nanocrystalline Finemet. **EV motor design**, **wind
> turbine generator design**, **MRI magnet engineering** live in
> `hexa-energy` / `hexa-mobility`.

> coercivity values cite manufacturer datasheets (Hitachi Metals,
> TDK, Shin-Etsu Chemical, Arnold Magnetic Technologies,
> Vacuumschmelze, Magnequench). Rare-earth supply tonnage cites USGS
> Mineral Commodity Summaries. No lattice projection.

---

## §1 WHY — why magnetic-materials belongs in hexa-matter

Magnetic materials split into two operational classes by coercivity:

| Class | Coercivity H_c | M_s | Use |
|-------|---------------|-----|-----|
| **Hard (permanent)** | high (1–2000 kA/m) | moderate–high | motor, sensor, MRI, speaker |
| **Soft (low-loss)** | low (< 1 kA/m) | high | transformer, inductor, motor stator |

The (BH)_max energy product is the canonical figure of merit for
permanent magnets — it sets the volume / mass needed to deliver a
given air-gap flux density in motors.

---

## §2 Real-limits-first — magnetic materials' actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| MM-L1 | Nd₂Fe₁₄B (N52) (BH)_max | Engineering / SOFT | **52 MGOe (414 kJ/m³)** commercial best | Hitachi Metals / TDK datasheet |
| MM-L2 | Nd-Fe-B theoretical (BH)_max ceiling | Physical / HARD | **~ 64 MGOe (510 kJ/m³)** Stoner-Wohlfarth + Nd₂Fe₁₄B M_s | Coey *Magnetism and Magnetic Materials* 2010 |
| MM-L3 | SmCo₅ (BH)_max | Engineering / SOFT | 22–28 MGOe | Arnold Magnetic Tech datasheet |
| MM-L4 | Sm₂Co₁₇ (BH)_max | Engineering / SOFT | 32–35 MGOe | Arnold / Vacuumschmelze Vacomax |
| MM-L5 | NdFeB T_curie | Physical / HARD | **583 K (310 °C)** | CRC Handbook 105th |
| MM-L6 | SmCo T_curie | Physical / HARD | **~ 1000 K (727 °C)** SmCo₅; ~ 1100 K Sm₂Co₁₇ | Coey |
| MM-L7 | NdFeB max continuous operating T (N52 grade) | Engineering / SOFT | ~ 80 °C; with Dy/Tb doping (UH/EH grade) up to **200 °C** | Hitachi Metals NMX series |
| MM-L8 | SmCo max continuous operating T | Engineering / SOFT | **~ 300 °C** | Arnold Magnetic Tech |
| MM-L9 | Sr-ferrite (BH)_max | Engineering / SOFT | 4.3 MGOe | TDK datasheet |
| MM-L10 | Si-Fe electrical steel (3.25 % Si, M-19 grade) | Engineering / SOFT | core loss ~ 2 W/kg at 1.5 T, 50 Hz | AK Steel / Nippon Steel M-19 |
| MM-L11 | Si-Fe Hi-B grain-oriented core loss | Engineering / SOFT | ~ 0.85 W/kg at 1.5 T, 50 Hz | JFE Steel Hi-B datasheet |
| MM-L12 | Metglas 2605SA1 (Fe-Si-B amorphous) core loss | Engineering / SOFT | ~ 0.2 W/kg at 1.4 T, 50 Hz | Hitachi Metals / Metglas |
| MM-L13 | Finemet FT-3M (Fe-Cu-Nb-Si-B nanocrystalline) μ_r | Engineering / SOFT | **~ 100,000–600,000** initial permeability | Hitachi Metals Finemet |
| MM-L14 | Permalloy (Ni80Fe20) μ_r | Engineering / SOFT | 50,000–100,000 | Vacuumschmelze Mumetall |
| MM-L15 | Mn-Zn ferrite power loss (TDK PC95 grade) | Engineering / SOFT | ~ 350 kW/m³ at 100 kHz, 100 mT, 100 °C | TDK PC95 datasheet |

**Note on (BH)_max ceiling (MM-L2).** The 64 MGOe theoretical ceiling
for Nd-Fe-B is from Stoner-Wohlfarth + measured M_s ≈ 1.6 T. Lab-best
~ 56 MGOe with HRE (Dy/Tb) substitution. **UNVERIFIED**: routine
production beyond ~ 56 MGOe; ceiling stands.

**Note on operating temperature ceilings (MM-L7, MM-L8).** NdFeB has
a much higher (BH)_max than SmCo but a much lower operating
temperature ceiling (Curie 310 °C vs 800–1000 °C; thermal
demagnetization 80–200 °C vs 300 °C). For high-T aerospace + motor
applications above 200 °C, SmCo wins despite lower energy product.

---


| Producer / data | Material focus | Reported scale | Source |
|----|----|----|----|
| Hitachi Metals (Proterial) | NdFeB sintered, NMX series | not separately reported | Hitachi IR |
| TDK Corporation | NdFeB + ferrite | NEOREC + FB series | TDK IR |
| Shin-Etsu Chemical | NdFeB sintered | rare-earth magnet div ~ JPY 100 B/yr | Shin-Etsu IR |
| Vacuumschmelze | SmCo (Vacomax) + amorphous (Vitrovac) | specialty | VAC IR |
| Arnold Magnetic Technologies | SmCo + AlNiCo + bonded NdFeB | specialty | Arnold public |
| Magnequench (Neo Performance) | bonded NdFeB (MQP powder) | major bonded NdFeB supplier | Neo Performance IR |
| JFE Steel / Nippon Steel | Si-Fe electrical steel | ~ 8–10 Mt/yr combined | JFE / Nippon Steel IR |
| AK Steel / Cleveland-Cliffs | Si-Fe electrical steel | ~ 1 Mt/yr | Cleveland-Cliffs IR |
| Metglas (Hitachi Metals) | amorphous Fe-Si-B | distribution transformer market | Metglas public |
| Hitachi Metals Finemet | nanocrystalline | RF + power inductor | Hitachi public |

**Rare-earth supply (USGS Mineral Commodity Summaries 2024):**

| Element | Global production 2023 (t/yr) | China share | Use |
|---------|-------------------------------|-------------|-----|
| Nd (in REO basis) | ~ 220,000 (REO total) | ~ 70 % mining, > 85 % refining | NdFeB |
| Pr | ~ 30,000 (REO basis) | similar | NdFeB |
| Dy (heavy rare earth) | ~ 1,500 | ~ 90 % | NdFeB HRE substitution |
| Tb (heavy rare earth) | ~ 250 | ~ 90 % | NdFeB HRE substitution |
| Sm | ~ 1,500 | ~ 80 % | SmCo |

> **Honesty caveat (LATTICE_POLICY §3.3):** these vendors and the USGS
> rare-earth tonnage do not anchor to n=6. NdFeB capacity is bounded
> by HREO supply (Dy/Tb), strip-casting capacity, and sinter-press
> count — not by lattice.

**Demand examples (vendor-published, no projection):**
- Tesla Model 3 PMSM motor: ~ 0.5–1 kg NdFeB per motor
- 1 MW wind turbine direct-drive generator: ~ 600 kg NdFeB
- 3T MRI permanent magnet array: ~ 1–2 t NdFeB

---

## §4 STRUCT — magnetic-material flow

```
Hard magnet (NdFeB sintered) branch:
   [Nd + Fe + B + Dy/Tb HRE]
        ↓ strip-casting (Suzuki / Less Common Metals tech)
   [Nd₂Fe₁₄B alloy strip]
        ↓ HD (hydrogen decrepitation) + jet-mill
   [Powder, 3–5 µm]
        ↓ press in magnetic field 1–2 T
   [Green compact, c-axis aligned]
        ↓ sinter 1080 °C + post-anneal
   [Sintered NdFeB block]
        ↓ machining + magnetizing (3–5 T pulse)
   [Finished magnet — motor, MRI, speaker]

Soft magnet (Si-Fe electrical steel) branch:
   [Pig iron + 3.25 % Si]
        ↓ continuous-casting
   [Si-Fe ingot]
        ↓ hot rolling + cold rolling (multi-pass)
   [Cold-rolled strip]
        ↓ decarburization + secondary recrystallization (HiB grade)
   [Grain-oriented Si-Fe sheet] — transformer core
        ↓ slit + stack + lamination
   [Transformer / motor stator core]

Amorphous (Metglas):
   [Fe + Si + B melt]
        ↓ planar-flow casting on Cu wheel @ 10⁶ K/s
   [Amorphous ribbon, ~ 25 µm thick]
        ↓ annealing for permeability
   [Distribution transformer core]
```

---

## §5 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | AlNiCo (1930s) | Commodity / declining |
| Mk.II | Sr-ferrite (1950s) | Commodity |
| Mk.III | SmCo₅ (1970s) | Commercial |
| Mk.IV | NdFeB sintered (Sagawa / Croat 1984) | Commodity workhorse |
| Mk.V | NdFeB with grain-boundary diffusion of Dy/Tb (Hitachi NMX, ~2010) | Commercial |
| Mk.VI | Rare-earth-free permanent magnet (FeNi L1₀ tetrataenite, MnBi, Fe₁₆N₂) | R&D — UNVERIFIED at NdFeB-class (BH)_max |
| Mk.VII | Bulk amorphous magnet for motor | R&D — UNVERIFIED at production cost |
| Mk.VIII | Cobalt-free electrical steel | R&D — UNVERIFIED |

---

## §6 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| Fe-based alloy baseline | `metallurgy/swordsmithing.md`, METALLURGY-DEEP.md |
| Ferrite ceramic processing | `ceramics/ceramics.md`, CERAMIC-ENGINEERING.md |
| Si-Fe electrical steel Si side | `silicon/silicon.md` (alloy element note) |
| Rare-earth recovery (NdFeB recycle) | `recycle_n6/`, `recycling/` |
| 2D magnet (CrI₃, Fe₃GeTe₂) | `2d-materials/2d-materials.md` |
| Perovskite multiferroic (BiFeO₃) | `perovskite/perovskite.md` |
| EV motor / wind turbine generator | `hexa-energy`, `hexa-mobility` |
| MRI scanner engineering | `hexa-medic` |

---

## §7 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| NdFeB T_curie 583 K | CRC Handbook 105th | MM-L5 sanity |
| NdFeB (BH)_max 52 MGOe (N52) | Hitachi Metals | MM-L1 sanity |
| Stoner-Wohlfarth 64 MGOe ceiling | Coey 2010 | MM-L2 sanity |
| M-19 / Hi-B core loss | AK Steel / JFE | MM-L10 / L11 sanity |
| Metglas 2605SA1 core loss | Metglas | MM-L12 sanity |
| USGS Mineral Commodity Summaries 2024 | USGS public | REE tonnage sanity |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-MM-1 | Rare-earth-free permanent magnet > 35 MGOe at production cost | OPEN |
| F-MM-2 | NdFeB routine production > 56 MGOe at industrial yield | OPEN |
| F-MM-3 | Nanocrystalline soft magnet displacing Si-Fe in distribution transformer | OPEN |
| F-MM-4 | Tetrataenite (FeNi L1₀) bulk synthesis at NdFeB-class energy | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "NdFeB N52 BHmax 52 MGOe equals σ·τ × 1.08" — coincidence
- ✗ "Curie T 583 K fits n=6 lattice" — coincidence; Heisenberg exchange
- ✗ "REE tonnage from USGS follows n=6" — USGS does not use n=6

---

## §8 Honest scope + caveats

1. **Material layer only.** EV motor design (PMSM, IPM topology, slot
   geometry), wind turbine generator (direct-drive vs gearbox), MRI
   magnet engineering — `hexa-energy` / `hexa-mobility` / `hexa-medic`.

2. **(BH)_max ceiling honestly capped.** Theoretical ~ 64 MGOe; lab
   best ~ 56 MGOe with HRE; commercial ceiling N52 ~ 52 MGOe.

3. **Rare-earth supply concentration is real.** China ≥ 70 % of REE
   mining and ≥ 85 % of refining as of 2024; this is a strategic
   supply concern but is NOT n=6 lattice content.

4. **Rare-earth-free permanent magnet substitutes UNVERIFIED.**
   Tetrataenite, MnBi, Fe₁₆N₂ are R&D-only as of 2026; no
   commercial NdFeB-class energy product.

5. **No lattice anchoring of vendor numbers or REE tonnage.** Hitachi
   / TDK / Shin-Etsu / Arnold / Vacuumschmelze / Magnequench /
   JFE / Nippon Steel / AK Steel / Metglas + USGS figures cited
   verbatim.

6. **SPEC_FIRST verdict.** All numbers from vendor datasheets, CRC,
   Coey textbook, or USGS public.

---

## §9 References

- Coey J.M.D., *Magnetism and Magnetic Materials* (Cambridge 2010)
- Sagawa M., Fujimura S., Togawa N., Yamamoto H., Matsuura Y., "New material for permanent magnets on a base of Nd and Fe," *J. Appl. Phys.* 55, 2083 (1984)
- Croat J.J., Herbst J.F., Lee R.W., Pinkerton F.E., "Pr-Fe and Nd-Fe-based materials: A new class of high-performance permanent magnets," *J. Appl. Phys.* 55, 2078 (1984)
- **CRC Handbook of Chemistry and Physics**, 105th ed. (2024)
- Hitachi Metals (now Proterial) — NMX-series NdFeB datasheets
- TDK Corporation — NEOREC + FB ferrite datasheets
- Shin-Etsu Chemical — Magnetic Materials Division catalogs
- Vacuumschmelze — Vacomax SmCo + Vitrovac + Mumetall datasheets
- Arnold Magnetic Technologies — SmCo + AlNiCo + bonded NdFeB datasheets
- Magnequench (Neo Performance) — MQP bonded NdFeB powder
- AK Steel — M-19 electrical steel datasheet
- JFE Steel — Hi-B grain-oriented electrical steel
- Nippon Steel — Hi-B grain-oriented electrical steel
- Metglas (Hitachi Metals) — 2605SA1 amorphous ribbon
- Finemet (Hitachi Metals) — FT-3M nanocrystalline datasheet
- USGS Mineral Commodity Summaries 2024 (rare earths)
- `LATTICE_POLICY.md` §1.2 + §1.3
- `LIMIT_BREAKTHROUGH.md` (Wave M)

---

*Authored 2026-05-13 by 박민우. Material-layer spec for Phase D
`magnetic-materials` verb (23 of 29). Real-limits-first per
LATTICE_POLICY.md §1.2; no lattice fit on (BH)_max / Curie T /
core loss or USGS rare-earth tonnage.*

---

## Related NOVEL candidates

REE-free permanent-magnet candidates — see [NOVEL.md §3.5](../NOVEL.md). Status as of 2026-05-18:

- `hxm-mag-refree-001` — Fe₁₆N₂ thin-film (SIM-DFT, MP mp-555)
- `hxm-mag-mnbi-001` — MnBi LTP (DESIGN)
- `hxm-mag-tetra-001` — tetrataenite L1₀ FeNi (SIM-DFT, MP mp-2213)
- `hxm-mag-boride-001` — (FeCoNiMnCr)₂B C16 boride (SIM-NNP, CHGNet relax of (FeCoNiMn)₂B ordered approximant)
- `hxm-mag-mn2sb-001` — Mn₂Sb tetragonal (SIM-DFT, MP mp-20664)
- `hxm-mag-mnalc-001` — MnAl τ-phase (SIM-DFT, MP mp-771)
- `hxm-mag-ferrhd-001` — SrFe₁₂O₁₉ Co/La-doped (DESIGN)
- `hxm-mag-lowdy-001` — (Nd,Ce,La)₂Fe₁₄B low-Dy/Tb (SIM-DFT, MP mp-5182)
- `hxm-mag-aifound-001` — FeCo₂Ge Heusler (SIM-DFT, MP mp-22300)
- `hxm-mag-gfcs-001` — Ga₃Fe₄Co₈Si (SIM-DFT, MP mp-1225352)
- `hxm-mag-znfe-001` — ZnFe tetragonal (DESIGN)

> SIM-DFT = MP DFT structural cross-reference (E_hull ≤ 0.01); SIM-NNP = real universal-FF (CHGNet) computation — both are simulations, NOT measurements. Tc / (BH)max / Hc / K₁ remain UNVERIFIED: per Coey 2010 (*Magnetism and Magnetic Materials*, Cambridge) the magnetic-physics ceilings are anchored, but these candidates' values are unmeasured. `EXTERNAL-VERIFIED` requires attributed external-lab evidence (NOVEL.md §7 · @F f2 / f5). Bulk-synthesis handoff: `CLOSURE_RESIDUAL_BACKLOG.md` §C-MET (C-MET-3 ~ C-MET-13).
