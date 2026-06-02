<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — non-carbon 2D layered crystals (MoS₂, WSe₂, h-BN, phosphorene, MXene) -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; carbon 2D in carbon/ + GRAPHENE-CARBON.md -->
---
domain: 2d-materials
requires: []
verb_group: ceramic_inorganic
status: SPEC_FIRST
verdict_basis: primary literature + vendor; no lattice fit
---

# 2D Materials — n=6 소재 substrate, material verb (Phase D 21/29)

> **Material layer only.** Non-carbon atomically-thin layered crystals:
> TMDCs (MoS₂, WS₂, WSe₂, MoSe₂), hexagonal boron nitride (h-BN),
> phosphorene (black P), silicene/germanene/stanene, MXenes (Ti₃C₂,
> V₂C, Nb₂C), 2D perovskites. **Carbon-side 2D materials (graphene,
> graphite, CNT, fullerene)** live in `carbon/carbon.md` + the
> `GRAPHENE-CARBON.md` chapter — this spec cross-links there.

> σ_f, k_th measured at sub-µm sample scale; scale-up to wafer-scale
> typically loses 10–100× performance. Honest distinction preserved.
> No lattice fit on 2D-material parameters.

---

## §1 WHY — why 2D-materials belongs in hexa-matter

A **2D material** is a layered crystal that can be mechanically or
chemically exfoliated to single-layer or few-layer sheets, where
in-plane bonds are strong (covalent or ionic) and out-of-plane bonds
are weak (van der Waals). The dimensional reduction creates physics
distinct from any bulk crystal — direct/indirect bandgap crossover,
valley polarization, moiré superlattices, single-photon emission.

| Family | Representative | Symmetry | Use |
|--------|----------------|----------|-----|
| TMDC | MoS₂, WS₂, WSe₂, MoSe₂ | hexagonal 1H/2H | FET, photodetector, catalyst (HER) |
| Hexagonal sp²-BN | h-BN | hexagonal | substrate / encapsulant for graphene, UV emitter |
| Group V puckered | phosphorene (black P), antimonene | puckered orthorhombic | FET, anisotropic conductor |
| Group IV xene | silicene, germanene, stanene | buckled hexagonal | research; topological insulator candidate |
| MXene (TM carbide/nitride) | Ti₃C₂T_x, V₂CT_x | hexagonal | supercapacitor, EMI shielding, catalyst |
| 2D perovskite (Ruddlesden-Popper) | (BA)₂PbI₄ family | layered ABX₃ | LED, solar |
| 2D magnet | CrI₃, Fe₃GeTe₂, CrSBr | layered van der Waals magnet | research / spintronic |

Carbon-side (graphene, graphite, CNT, diamond, fullerene) lives in
`carbon/carbon.md` and the `GRAPHENE-CARBON.md` chapter.

---

## §2 Real-limits-first — 2D materials' actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| 2D-L1 | h-BN bandgap (single-layer) | Physical / HARD | **5.97 eV** (direct/indirect mixed assignment, mostly indirect) | Cassabois et al. 2016 *Nat. Photonics* 10, 262 |
| 2D-L2 | MoS₂ bandgap (single-layer 1H) | Physical / HARD | **1.8 eV (direct)** | Splendiani et al. 2010 *Nano Lett.* 10, 1271 |
| 2D-L3 | MoS₂ bandgap (bulk 2H) | Physical / HARD | **1.2 eV (indirect)** | Mak et al. 2010 *Phys. Rev. Lett.* 105, 136805 |
| 2D-L4 | WSe₂ bandgap (single-layer) | Physical / HARD | **1.65 eV (direct)** | Zhao et al. 2013 *ACS Nano* 7, 791 |
| 2D-L5 | WS₂ bandgap (single-layer) | Physical / HARD | **2.05 eV (direct)** | Zhao 2013 |
| 2D-L6 | Phosphorene bandgap (1–5 layers) | Physical / HARD | **0.3–2.0 eV (tunable, direct)** | Liu et al. 2014 *ACS Nano* 8, 4033 |
| 2D-L7 | MoS₂ field-effect mobility (best, hBN-encapsulated) | Engineering / SOFT | **~ 100 cm²/V·s (room T); ~ 30,000 cm²/V·s at low T** | Cui et al. 2015 *Nat. Nanotechnol.* 10, 534 |
| 2D-L8 | MoS₂ FET on/off ratio | Engineering / SOFT | **10⁸–10¹⁰** (well above Si FET) | Radisavljevic et al. 2011 *Nat. Nanotechnol.* 6, 147 |
| 2D-L9 | h-BN in-plane thermal conductivity (single-layer) | Physical / HARD | **~ 700–2000 W/m·K** (calculation + few-layer measurement) | Lindsay & Broido 2011; experimental scatter |
| 2D-L10 | Mechanical exfoliation flake size (Scotch-tape) | Engineering / SOFT | **~ 1–100 µm typical**; not wafer-scale | Geim & Novoselov tradition |
| 2D-L11 | CVD MoS₂ wafer-scale single-crystal film | Engineering / SOFT | **2-inch wafer demonstrated** (multiple groups 2020–24); not yet 6/8-inch | Zhang et al. 2018; Liu 2024 |
| 2D-L12 | hBN single-crystal area (mm-scale flake) | Engineering / SOFT | **~ mm² (Watanabe-Taniguchi NIMS) high-purity** | NIMS Watanabe-Taniguchi h-BN reference |
| 2D-L13 | MXene Ti₃C₂T_x electrical conductivity | Engineering / SOFT | **~ 9000–15000 S/cm** (best film) | Lipatov et al. 2018 |
| 2D-L14 | "Magic-angle" twisted bilayer graphene SC T_c | Physical / SOFT | **~ 1.7 K** at 1.1° twist | Cao et al. 2018 *Nature* 556, 43 — graphene cross-link |

**Note on lab-record vs production scale (2D-L7, 2D-L10).** Most
"2D record" mobility / σ_f values are from sub-µm samples
encapsulated in hBN. **Wafer-scale CVD films lose 10–100× mobility**
(typical CVD MoS₂ ~ 1–30 cm²/V·s). Honest distinction preserved.

**Note on h-BN (2D-L12).** NIMS Watanabe-Taniguchi h-BN is the de
facto reference; bulk single-crystal mm² flakes via high-pressure
synthesis. Most academic 2D-FET papers depend on this single
external source. **UNVERIFIED in this repo**: scale-up to wafer-area
h-BN at NIMS quality.

---


| Producer / source | Material focus | Reported scale | Source |
|----|----|----|----|
| 2D Carbon (Changzhou) | CVD graphene film | wafer-area sales | company release |
| Graphenea | CVD graphene + h-BN | wafer-area sales | Graphenea catalog |
| HQ Graphene | TMDCs, h-BN bulk | mg–g per flake | HQ Graphene catalog |
| 2D Semiconductors | TMDC bulk crystals | mg–g per sample | 2D Semiconductors catalog |
| NIMS (Watanabe-Taniguchi) | h-BN reference crystal | research sample | NIMS public |
| Ossila | TMDCs + perovskite precursors | research sample | Ossila catalog |
| Murata via MXene-related licensee | MXene supercap research | early commercial | Murata public |
| BlueShift Materials | MXene-related | early commercial | BlueShift public |

> **Honesty caveat:** 2D-material vendors operate at mg–g scale; the
> industrial-tonnage market does not yet exist in 2026. CVD wafer-area
> sales are research-grade. Capacity is bounded by CVD reactor count
> and CMP wafer area — not by n=6.

---

## §4 STRUCT — 2D material flow

```
[Bulk TMDC crystal, e.g., MoS₂]                  [h-BN bulk, NIMS-grade]
        ↓ mechanical exfoliation                       ↓ exfoliation
   [Few-layer flake on substrate]               [h-BN encapsulation layer]
        ↓ optical id + AFM                            ↓
   [Verified monolayer]                  ┌───────────┘
        ↓                                ↓
        └────────[vdW heterostack assembly]
                        ↓ dry-transfer (PDMS / PC stamp)
                  [Encapsulated 2D-FET device candidate]
                        ↓
                  (→ hexa-chip: device design)

Wafer-scale branch:
   [Mo/W foil substrate + S/Se gas precursor]
        ↓ CVD 700–1100 °C
   [Wafer-scale TMDC film] — 2-inch demonstrated; 6/8-inch UNVERIFIED
        ↓
   [Transferred onto target substrate]
        ↓
   (→ hexa-chip)

MXene branch:
   [Ti₃AlC₂ (MAX phase) powder]
        ↓ HF etch (selective Al removal)
   [Ti₃C₂T_x MXene flakes]
        ↓ filtration + drying
   [MXene film for supercapacitor / EMI shield]
```

---

## §5 Heterostructures — vdW stacking (Geim-Novoselov Lego model)

The signature engineering of 2D materials: **stack different 2D
crystals** (graphene / h-BN / MoS₂ / WSe₂ / CrI₃) into multi-layer
heterostructures with atomically clean interfaces.

| Stack | Effect | Reference |
|-------|--------|-----------|
| Graphene + h-BN encapsulation | mobility 100k+ cm²/V·s (near ballistic) | Wang et al. 2013 *Science* 342, 614 |
| MoS₂ / WSe₂ vertical p-n | atomic-scale photodetector | Britnell et al. 2013 |
| Twisted bilayer graphene at 1.1° "magic angle" | flat bands, T_c ~ 1.7 K SC | Cao et al. 2018 *Nature* 556, 43 (graphene cross-link) |
| CrI₃ multilayer | layer-dependent ferromagnetism | Huang et al. 2017 *Nature* 546, 270 |

---

## §6 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | mechanical exfoliation (Geim-Novoselov 2004) | Research commodity |
| Mk.II | CVD graphene on Cu (Ruoff 2009) | Commercial (cross-link: GRAPHENE-CARBON.md) |
| Mk.III | NIMS h-BN reference crystal | Niche commercial |
| Mk.IV | 2-inch wafer-scale CVD MoS₂ single-crystal | Demonstrated 2020–24 |
| Mk.V | 6/8-inch CVD TMDC at FET-grade mobility | R&D — UNVERIFIED |
| Mk.VI | Phosphorene FET at long-term ambient stability | R&D — phosphorene oxidizes in air, UNVERIFIED for production |
| Mk.VII | MXene supercapacitor at commercial cycle life | R&D — early commercial 2024–25 |
| Mk.VIII | 2D magnetic spintronic device | R&D — UNPROVEN at room T (most 2D magnets T_c < 200 K) |

---

## §7 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| Carbon-side 2D (graphene, CNT, fullerene) | `carbon/carbon.md`, GRAPHENE-CARBON.md |
| TMDC as semiconductor | `compound-semi/compound-semi.md` |
| h-BN as ceramic / sintered powder | `ceramics/ceramics.md` |
| 2D-perovskite (Ruddlesden-Popper) | `perovskite/perovskite.md` |
| 2D magnetic crystals (CrI₃, Fe₃GeTe₂) | `magnetic-materials/magnetic-materials.md` |
| Silicene / germanene (Si/Ge xene) | `silicon/silicon.md` (silicene cross-link) |
| 2D-FET device + fab | `hexa-chip materials` |
| MXene supercapacitor application | `hexa-energy` |

---

## §8 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| MoS₂ direct E_g 1.8 eV (mono) | Splendiani 2010, Mak 2010 | 2D-L2 sanity |
| h-BN E_g 5.97 eV | Cassabois 2016 | 2D-L1 sanity |
| Magic-angle TBG T_c 1.7 K | Cao 2018 | 2D-L14 sanity |
| NIMS Watanabe-Taniguchi h-BN reference | NIMS public | 2D-L12 sanity |
| MoS₂ FET on/off 10⁸–10¹⁰ | Radisavljevic 2011 | 2D-L8 sanity |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-2D-1 | 8-inch wafer-scale single-crystal MoS₂ at > 100 cm²/V·s | OPEN |
| F-2D-2 | Phosphorene ambient stability > 6 months without encapsulation | OPEN |
| F-2D-3 | 2D magnet T_c > 300 K in pure (un-strained, un-gated) form | OPEN |
| F-2D-4 | h-BN wafer-area at NIMS quality outside NIMS | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "MoS₂ mobility 30,000 cm²/V·s is production-ready" — low-T sub-µm only
- ✗ "Wafer-scale 2D matches lab record" — typically 10–100× loss
- ✗ "h-BN E_g 5.97 eV equals n=6 × c" — coincidence; do not write
- ✗ "Magic-angle 1.1° fits n=6" — coincidence; geometry-derived

---

## §9 Honest scope + caveats

1. **Material layer only.** 2D-FET device design, photonic
   integration, valley logic — `hexa-chip`.

2. **Lab-record mobility is sub-µm + low-T.** Production wafer-scale
   loses 10–100×. Honest distinction preserved.

3. **Phosphorene oxidizes in air; 2D magnets have T_c far below 300
   K.** Both UNVERIFIED for production deployment.

4. **NIMS h-BN dependency.** Most academic 2D-FET literature uses
   NIMS reference h-BN; supply scaling is UNVERIFIED.

5. **No lattice anchoring of 2D parameters or vendor scale.**
   Graphenea / HQ Graphene / 2D Semiconductors / NIMS / Ossila
   figures cited verbatim.

6. **SPEC_FIRST verdict.** All numbers from primary literature
   (Splendiani / Mak / Cao / Cassabois / Cui / Liu / Huang /
   Lipatov) or vendor catalogs.



---

## §10 References

- Geim A.K., Novoselov K.S., "The rise of graphene," *Nat. Mater.* 6, 183 (2007)
- Splendiani A. et al., "Emerging Photoluminescence in Monolayer MoS₂," *Nano Lett.* 10, 1271 (2010)
- Mak K.F., Lee C., Hone J., Shan J., Heinz T.F., "Atomically Thin MoS₂: A New Direct-Gap Semiconductor," *Phys. Rev. Lett.* 105, 136805 (2010)
- Radisavljevic B. et al., "Single-layer MoS₂ transistors," *Nat. Nanotechnol.* 6, 147 (2011)
- Cao Y. et al., "Unconventional superconductivity in magic-angle graphene superlattices," *Nature* 556, 43 (2018)
- Cassabois G., Valvin P., Gil B., "Hexagonal boron nitride is an indirect bandgap semiconductor," *Nat. Photonics* 10, 262 (2016)
- Liu H. et al., "Phosphorene: An Unexplored 2D Semiconductor with a High Hole Mobility," *ACS Nano* 8, 4033 (2014)
- Cui X. et al., "Multi-terminal transport measurements of MoS₂ using a van der Waals heterostructure device platform," *Nat. Nanotechnol.* 10, 534 (2015)
- Huang B. et al., "Layer-dependent ferromagnetism in a van der Waals crystal down to the monolayer limit," *Nature* 546, 270 (2017)
- Lipatov A. et al., "Effect of Synthesis on Quality, Electronic Properties and Environmental Stability of Individual MXene Ti₃C₂T_x Flakes," *Adv. Electron. Mater.* 2, 1600255 (2016)
- Watanabe K., Taniguchi T., NIMS h-BN reference protocol
- Graphenea, HQ Graphene, 2D Semiconductors, Ossila — catalog references
- `carbon/carbon.md`, `GRAPHENE-CARBON.md` — carbon-side 2D
- `LATTICE_POLICY.md` §1.2 + §1.3
- `LIMIT_BREAKTHROUGH.md` (Wave M)

---

*Authored 2026-05-13 by 박민우. Material-layer spec for Phase D
`2d-materials` verb (21 of 29). Non-carbon 2D crystals; carbon-side
in `carbon/`. Lab-record vs production scale honestly distinguished.
No lattice fit.*

---

## Related NOVEL candidates

- `hxm-quantum-hbn-vb-001` — see [NOVEL.md §4.C.1](../NOVEL.md): hBN boron-vacancy (V_B) quantum-defect host.
- `hxm-flatband-tbg-001` — see [NOVEL.md §4.C.4](../NOVEL.md): twisted-bilayer-graphene flat-band system.

> SIM / proxy status is NOT a measurement and does NOT promote to `EXTERNAL-VERIFIED` without attributed external-lab evidence (NOVEL.md §7 · @F f2 / f5).
