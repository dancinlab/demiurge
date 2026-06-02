<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — carbon allotrope family (activated, glassy, graphite, fiber, CNT, diamond, fullerene) -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; graphene aspect cross-links GRAPHENE-CARBON.md -->
---
domain: carbon
requires: []
verb_group: ceramic_inorganic
status: SPEC_FIRST
verdict_basis: NIST + primary literature + Element Six + Toray; no lattice fit; lab-best vs commercial honestly distinguished
---

# Carbon — n=6 소재 substrate, material verb (Phase D 29/29)

> **Material layer only.** Carbon allotrope family — activated carbon
> (sorbent), glassy carbon (electrochemistry), pyrolytic graphite
> (HOPG, thermal), carbon fiber (Toray T700/T800/T1000 + competitor
> aerospace + automotive grades), CNT (SWCNT + MWCNT), diamond (HPHT
> + CVD + natural), fullerene (C₆₀, C₇₀, higher fullerenes).
> **Graphene depth** lives in `GRAPHENE-CARBON.md` (and is
> cross-linked from `2d-materials/`); this spec covers the bulk +
> fiber + nanostructure side.

> **Honesty (LATTICE_POLICY §1.2):** lab-record values
> (CNT yarn σ 80 GPa, graphene mobility 200k cm²/V·s) clearly
> distinguished from commercial values (T1100G ~ 7 GPa, large-area
> CVD graphene ~ 5000 cm²/V·s). Element Six / Toray / Mitsubishi
> Rayon / Hexcel / Cabot capacity figures cited verbatim. No lattice
> projection.

---

## §1 WHY — why carbon belongs in hexa-matter

Carbon's electron configuration (1s² 2s² 2p²) allows three
hybridization states with distinct geometric + bonding signatures:

| Hybridization | Geometry | Bond character | Allotrope |
|--------------|----------|-----------------|-----------|
| sp (linear) | 180° | 2 σ + 2 π | carbyne (theoretical), C₂ chain |
| sp² (trigonal planar) | 120° | 3 σ + 1 π delocalized | graphite, graphene, CNT, fullerene |
| sp³ (tetrahedral) | 109.5° | 4 σ | diamond, lonsdaleite |

This gives 4 production-relevant 3D structures (graphite, diamond,
lonsdaleite, fullerene families) + 2D graphene + 1D CNT. The
diversity makes carbon a verb in its own right rather than a single
material entry.

Cross-link rule: 2D graphene physics + heterostructures are covered in
the `GRAPHENE-CARBON.md` chapter and `2d-materials/2d-materials.md`
verb. This spec focuses on **bulk + fiber + nanotube + diamond +
fullerene + activated carbon**.

---

## §2 Real-limits-first — carbon's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| C-L1 | Diamond Vickers hardness | Physical / HARD | **70–100 GPa** (single-crystal natural, 100 face) | Brookes 1992 — Mohs 10 anchor |
| C-L2 | Diamond Young's E | Physical / HARD | **~ 1050–1220 GPa** | CRC 105th |
| C-L3 | Diamond k_th (room T, single-crystal) | Physical / HARD | **~ 2200 W/m·K** (highest of any bulk material) | Anthony et al. 1990 |
| C-L4 | Diamond bandgap | Physical / HARD | **5.45 eV (indirect)** — ultra-wide | Sze 3rd ed. |
| C-L5 | Diamond density | Physical / HARD | **3.515 g/cm³** | CRC |
| C-L6 | Graphite c-axis thermal k | Physical / HARD | ~ 10 W/m·K | CRC |
| C-L7 | Graphite in-plane thermal k (HOPG) | Physical / HARD | ~ 2000 W/m·K | CRC + HOPG datasheet |
| C-L8 | Carbon fiber (Toray T1100G) tensile σ | Engineering / SOFT | **~ 7 GPa** | Toray T1100G datasheet |
| C-L9 | Carbon fiber (T1100G) E | Engineering / SOFT | ~ 324 GPa | Toray |
| C-L10 | Carbon fiber (T700S, workhorse aerospace) | Engineering / SOFT | σ ~ 4.9 GPa, E ~ 230 GPa, ρ 1.8 g/cm³ | Toray T700S datasheet |
| C-L11 | Pitch-based carbon fiber E (Mitsubishi K13C2U) | Engineering / SOFT | E ~ 900 GPa, σ ~ 3.8 GPa | Mitsubishi Rayon datasheet |
| C-L12 | CNT individual nanotube σ (lab measured) | Physical / SOFT | **~ 100 GPa** (single SWCNT, AFM) | Yu et al. 2000 *Science* 287, 637 |
| C-L13 | CNT yarn lab record (Tsinghua / IBS) | Engineering / SOFT | **~ 80 GPa** (mm-scale sample) | Bai et al. 2018 + similar |
| C-L14 | CNT yarn commercial (Nanocomp, Huntsman) | Engineering / SOFT | ~ 1–3 GPa typical commercial yarn | Nanocomp public |
| C-L15 | Activated carbon BET surface area | Engineering / SOFT | **typically 500–3500 m²/g**; best ~ 4500 m²/g (Maxsorb) | Calgon / Kuraray / Maxsorb |
| C-L16 | Glassy carbon (sigradur) max use-T (inert) | Engineering / SOFT | up to ~ 3000 °C (inert atmosphere) | HTW Hochtemperatur datasheet |
| C-L17 | Diamond CVD growth rate (HF-CVD) | Engineering / SOFT | typically 1–20 µm/h | Element Six datasheet |
| C-L18 | Diamond CVD (HPHT) production wafer size | Engineering / SOFT | ~ 8-inch single-crystal R&D; production typically 5–10 mm pieces | Element Six / Sumitomo |
| C-L19 | Fullerene C₆₀ stability (air, room T, dark) | Physical / HARD | indefinite (years); photo-oxidizes under UV | research consensus |
| C-L20 | CNT theoretical σ (in-plane perfect) | Physical / HARD | **~ 150 GPa** | Frenkel σ_th + E ~ 1 TPa |

**Note on CNT yarn (C-L13/L14).** Single SWCNT measured ~ 100 GPa
(AFM, sub-µm sample). **Bulk yarn** drops 30–100× because of
inter-nanotube slippage. Tsinghua / IBS labs report mm-scale yarn at
~ 80 GPa under optimized aligned-array conditions; commercial yarn
typically 1–3 GPa. **Honest distinction preserved.**

**Note on carbon fiber (C-L8, C-L10).** Toray T700S is the workhorse
aerospace + sports + wind grade (~ 60 % of global commercial volume).
T1100G represents the highest-tensile commercial fiber. Pitch-based
K13C2U has highest E (~ 900 GPa) but lower σ — used for stiffness-
limited spacecraft + aero structures.

---

## §3 Industrial scale — vendor figures (NO lattice fit)

| Producer | Material focus | Reported scale | Source |
|----------|----------------|----------------|--------|
| Toray Industries | PAN-based carbon fiber (T-series) | ~ 50–60 kt/yr; dominant supplier | Toray IR |
| Mitsubishi Rayon (Mitsubishi Chemical Carbon Fiber) | PAN + pitch fiber | ~ 20 kt/yr | Mitsubishi public |
| Teijin (incl. Toho Tenax) | PAN carbon fiber | ~ 20 kt/yr | Teijin IR |
| Hexcel | carbon fiber + prepreg | ~ 17 kt/yr | Hexcel IR |
| SGL Carbon | carbon fiber + graphite electrode | major | SGL IR |
| Cabot Corporation | carbon black + activated carbon | ~ 2.5 Mt carbon black | Cabot IR |
| Birla Carbon | carbon black | ~ 2 Mt | Birla |
| Calgon Carbon (Kuraray) | activated carbon | major | Kuraray |
| Mersen | graphite + glassy carbon | major | Mersen IR |
| Element Six (De Beers Industrial) | CVD + HPHT industrial diamond | dominant industrial diamond | De Beers public |
| Sumitomo Electric | CVD diamond, industrial diamond | major | Sumitomo IR |
| Mitsubishi Materials | industrial diamond | major | Mitsubishi public |
| Asbury Carbons | natural + synthetic graphite | major | Asbury public |
| Nanocomp Technologies (Huntsman) | CNT yarn + sheet | commercial niche | Huntsman public |
| OCSiAl | SWCNT (TUBALL) | ~ 75–80 t/yr SWCNT | OCSiAl public |
| Cnano Technology | MWCNT | major MWCNT supplier | Cnano public |

> **Honesty caveat (LATTICE_POLICY §3.3):** vendor capacities span
> 50 kt/yr (carbon fiber) to ~ 80 t/yr (SWCNT) — vast scale
> heterogeneity. Capacity is bounded by PAN-precursor + oxidation/
> carbonization line throughput (fiber), or by CVD reactor count
> (CNT, diamond). No projection onto n=6.

---

## §4 STRUCT — carbon material flow

```
Carbon fiber branch (PAN):
   [Acrylonitrile + comonomer]
        ↓ free-radical polymerization (Toray, Mitsubishi)
   [PAN polymer fiber, wet-spin]
   [PAN white fiber, ~ 12 µm diameter]
        ↓ oxidation 200–300 °C in air, slow
   [Oxidized PAN (OPF), ladder-structure]
        ↓ carbonization 1300–1500 °C in N₂
   [Carbon fiber, T700S / T800S / T1100G grade]
        ↓ (optional) graphitization 2000–2500 °C for high-E pitch fiber
   [Pitch-based ultra-high-E fiber, K13C2U class]

Activated carbon branch:
   [Coconut shell / bituminous coal / wood]
        ↓ carbonization 500–700 °C
        ↓ steam or CO₂ activation 800–900 °C
   [Activated carbon, BET 500–3500 m²/g]
        ↓ granular / extruded / powdered
   [Sorbent — water treatment, gas mask, electrochem]

Industrial diamond branch:
   HPHT: [Graphite + Ni-Fe-Co catalyst, 5–6 GPa, 1300–1500 °C]
        → [HPHT diamond]
   CVD: [CH₄ + H₂ in microwave or hot-filament chamber]
        ↓
        [CVD diamond, single-crystal or polycrystalline]
   [→ cutting tool, heat spreader, optical window]

CNT branch:
   CVD: [Fe / Co / Ni catalyst + CH₄ or C₂H₂]
        ↓ 600–1100 °C
   [CNT forest or yarn]
   [→ research + Nanocomp yarn + OCSiAl SWCNT additive]

Fullerene branch:
   [Arc discharge of graphite electrodes in He]
        ↓
   [C₆₀ + C₇₀ + higher fullerenes + soot]
        ↓ solvent extraction (toluene)
   [Pure C₆₀ — research]

Glassy carbon:
   [Phenolic or furfuryl alcohol resin]
        ↓ controlled pyrolysis 1000–3000 °C
   [Glassy / vitreous carbon — electrode + crucible]
```

---

## §5 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | Activated carbon (1900s) | Commodity |
| Mk.II | PAN carbon fiber (1960s, Watt 1963) | Commodity |
| Mk.III | T700S workhorse aerospace fiber | Commodity |
| Mk.IV | T1100G high-tensile commercial fiber | Commercial |
| Mk.V | CVD diamond at wafer scale (Element Six) | Commercial niche |
| Mk.VI | Fullerene C₆₀ commercial (1990s) | Niche (Frontier Carbon) |
| Mk.VII | CNT yarn at lab record 80 GPa | R&D — UNVERIFIED at production |
| Mk.VIII | Diamond as semiconductor wafer | R&D — UNPROVEN at production yield |
| Mk.IX | Carbyne (sp linear) commercial isolation | R&D — UNVERIFIED |
| Mk.X | Lonsdaleite (hexagonal diamond) at bulk | UNPROVEN |

---

## §6 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| Graphene 2D physics + heterostructures | `2d-materials/2d-materials.md`, GRAPHENE-CARBON.md |
| Carbon fiber composite (CFRP) | `aramid/aramid.md` (aramid-CFRP overlap), `epoxy/epoxy.md` (resin matrix) |
| Carbon black in tire / rubber | `elastomer/elastomer.md`, `tire_cord/tire-cord.md`, `microplastics/microplastics.md` |
| Diamond as ultra-wide bandgap | `compound-semi/compound-semi.md` |
| Synthetic diamond / lab-grown gem | `gemology/gemology.md` |
| Activated-carbon in air-filter / sorbent | `hexa-bio` (medical), `hexa-earth` (water + air treatment) |
| Carbon fiber recycling (pyrolytic recovery) | `recycle_n6/`, `recycling/` |
| Carbon negative-emission via biochar | `hexa-earth` |
| CFRP aircraft + automotive | `hexa-mobility` |
| Battery anode (graphite, hard carbon) | `hexa-energy` |

---

## §7 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| Diamond Vickers 70–100 GPa | Brookes 1992 / Mohs 10 anchor | C-L1 sanity |
| Diamond k_th 2200 W/m·K | Anthony 1990 | C-L3 sanity |
| Diamond E_g 5.45 eV | Sze | C-L4 sanity |
| Toray T700S σ 4.9 GPa | Toray | C-L10 sanity |
| Toray T1100G σ ~ 7 GPa | Toray | C-L8 sanity |
| Mitsubishi K13C2U E ~ 900 GPa | Mitsubishi | C-L11 sanity |
| Yu et al. SWCNT σ 100 GPa | Yu 2000 *Science* | C-L12 sanity |
| Maxsorb activated-C BET ~ 4500 m²/g | Kansai Coke / Kuraray | C-L15 sanity |
| Element Six CVD diamond datasheet | Element Six | C-L17 / L18 sanity |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-C-1 | CNT yarn at > 50 GPa at meter-scale commercial yarn | OPEN |
| F-C-2 | Diamond semiconductor wafer > 4-inch at commercial yield | OPEN |
| F-C-3 | Carbon fiber σ_f > 10 GPa commercial production | OPEN |
| F-C-4 | Activated carbon BET > 6000 m²/g routine production | OPEN |
| F-C-5 | Bulk lonsdaleite synthesis (hexagonal diamond) at gram scale | OPEN |
| F-C-6 | Bulk carbyne isolation at peer-reviewed reproducibility | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "CNT yarn 80 GPa is production-ready" — lab mm-scale only
- ✗ "Diamond Vickers 100 GPa equals σ·τ × 2.08" — coincidence
- ✗ "Toray / Element Six revenue follows n=6" — they have not heard of it
- ✗ "Lonsdaleite is a routine bulk material" — UNPROVEN; w-BN
  cousin Vickers 85 GPa (calculated) also UNVERIFIED at bulk

---

## §8 Honest scope + caveats

1. **Material layer only.** CFRP aerospace structure design, EV
   battery anode optimization, diamond cutting-tool process — sibling
   repos (`hexa-mobility`, `hexa-energy`, `hexa-chip`).

2. **Lab-record vs commercial honest distinction.** CNT yarn lab 80
   GPa vs commercial 1–3 GPa; graphene mobility 200k cm²/V·s (low-T,
   suspended) vs CVD ~ 5000 cm²/V·s. Honest scaling preserved.

3. **Diamond semiconductor + bulk carbyne + bulk lonsdaleite all
   UNVERIFIED.** Mk.VIII–X in §5 are R&D-only as of 2026.

4. **No lattice anchoring of vendor numbers.** Toray / Mitsubishi /
   Teijin / Hexcel / SGL / Element Six / Sumitomo / Cabot / Calgon /
   Mersen / Asbury / Nanocomp / OCSiAl / Cnano capacities cited
   verbatim.

5. **SPEC_FIRST verdict.** All numbers from NIST / CRC / Sze /
   Anthony / Yu / vendor public datasheets.

6. **Coincidence disclosure (LATTICE_POLICY §1.1).** Any apparent fit
   to n=6 is coincidence. Diamond Mohs 10, k_th 2200 W/m·K, and
   E_g 5.45 eV are physical-chemistry parameters.

---

## §9 References

- Brookes E.J., "Hardness of diamond," in *Properties and Growth of Diamond* (INSPEC 1994)
- Anthony T.R., Banholzer W.F., Fleischer J.F., Wei L.-H., Kuo P.K., Thomas R.L., Pryor R.W., "Thermal diffusivity of isotopically enriched ¹²C diamond," *Phys. Rev. B* 42, 1104 (1990)
- Yu M.-F., Lourie O., Dyer M.J., Moloni K., Kelly T.F., Ruoff R.S., "Strength and Breaking Mechanism of Multiwalled Carbon Nanotubes Under Tensile Load," *Science* 287, 637 (2000)
- Bai Y., Zhang R., Ye X., Zhu Z., Xie H., Shen B., Cai D., Liu B., Zhang C., Jia Z., Zhang S., Li X., Wei F., "Carbon nanotube bundles with tensile strength over 80 GPa," *Nat. Nanotechnol.* 13, 589 (2018)
- Castro Neto A.H., Guinea F., Peres N.M.R., Novoselov K.S., Geim A.K., "The electronic properties of graphene," *Rev. Mod. Phys.* 81, 109 (2009) — cross-link to GRAPHENE-CARBON.md
- Sze S.M., Ng K.K., *Physics of Semiconductor Devices*, 3rd ed. (2007) — diamond E_g
- **CRC Handbook of Chemistry and Physics**, 105th ed. (2024)
- Watt W., Phillips L.N., Johnson W., "High-strength high-modulus carbon fibres," *The Engineer* 221, 815 (1966)
- Toray Industries — T700S / T800S / T1100G technical data sheets
- Mitsubishi Rayon — pitch-based K13C2U datasheet
- Teijin (Toho Tenax) — IM / HM-grade datasheets
- Hexcel — IM7 / IM10 carbon-fiber + prepreg datasheets
- SGL Carbon — graphite electrode + Sigrafil carbon fiber
- Cabot Corporation — carbon black + activated carbon catalog
- Element Six — CVD industrial diamond datasheets
- Sumitomo Electric — CVD diamond + cBN
- Nanocomp Technologies (Huntsman) — Miralon CNT yarn
- OCSiAl — TUBALL SWCNT datasheet
- Cnano Technology — MWCNT datasheet
- `2d-materials/2d-materials.md` — non-carbon 2D
- `GRAPHENE-CARBON.md` — graphene depth (this repo)
- `LATTICE_POLICY.md` §1.2 + §1.3
- `LIMIT_BREAKTHROUGH.md` (Wave M)

---

*Authored 2026-05-13 by 박민우. Material-layer spec for Phase D
`carbon` verb (29 of 29 — closes the Phase D set). Lab-record vs
commercial honestly distinguished. Diamond / CNT / fullerene
allotrope coverage; graphene depth in GRAPHENE-CARBON.md +
`2d-materials/`. No lattice fit.*
