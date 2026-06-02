# 2D-MATERIALS — Phase D candidate stub

> **Authored**: 2026-05-13 (Phase A elevation) · **Status**: STUB — Phase D roadmap marker
> **Author**: 박민우 <nerve011235@gmail.com>
> **Target group**: new **GROUP_2D** (proposed) · **Phase D priority**: HIGH
>
> Stub placeholder for the Phase D `2d-materials` verb covering atomically-thin
> non-carbon 2D crystals. Graphene + lonsdaleite + diamond are in `GRAPHENE-CARBON.md`;
> this chapter focuses on h-BN, MoS₂, WSe₂, phosphorene, MXenes.

---

## §1 Scope

A **2D material** is a layered crystal that can be exfoliated to atomically thin (single-layer or few-layer) sheets, where the in-plane bonds are strong (covalent or ionic) and the out-of-plane bonds are weak (van der Waals).

Distinguish from "thin film" (which can be any composition deposited thinly). 2D-materials are *intrinsically* layered at the crystal level.

Adding 2d-materials as a Phase D verb may justify adding a new **GROUP_2D** to the AXIS taxonomy, since the dimensional reduction is structurally distinct from CER / POL / MET / etc.

---

## §2 Workhorse 2D materials

| Material | Structure | Bandgap (eV) | Use |
|----------|-----------|--------------|-----|
| Graphene | hexagonal sp² C | 0 (Dirac semimetal) | (`GRAPHENE-CARBON.md` chapter) — see there |
| h-BN | hexagonal sp² B-N | 5.97 (insulating, direct/indirect mixed) | substrate for graphene electronics; UV emitter |
| MoS₂ (1H polytype) | hexagonal | 1.8 (direct, monolayer) / 1.2 (indirect, bulk) | FET, photodetector, catalyst (HER) |
| WSe₂ | hexagonal | 1.65 (direct, monolayer) | FET, valleytronic |
| MoSe₂ | hexagonal | 1.55 (direct) | FET, photodetector |
| WS₂ | hexagonal | 2.05 (direct, monolayer) | FET, sensor |
| Phosphorene (black P) | puckered orthorhombic | 0.3-2.0 (layer-tunable, direct) | FET, anisotropic conductor |
| Silicene | hexagonal Si | 0 (Dirac, theoretical for free-standing) | substrate-dependent; bandgap on substrate |
| Germanene | hexagonal Ge | 0 | research |
| Stanene | hexagonal Sn | 0 | topological-insulator candidate |
| MXenes (Ti₃C₂, V₂C, etc.) | layered transition-metal carbide/nitride | metallic | supercapacitor, EMI shielding |
| Antimonene | hexagonal Sb | 2.28 (monolayer, indirect) | research |
| 2D perovskite (Ruddlesden-Popper) | layered ABX₃ | tunable | LED, solar |

---

## §3 Production routes

- **Mechanical exfoliation** (Scotch tape) — research-grade flakes
- **Liquid-phase exfoliation** — bulk powder of few-layer flakes
- **CVD on Cu / sapphire / SiO₂** — cm² scale films
- **MBE (Molecular Beam Epitaxy)** — high-quality epitaxial films
- **Top-down + transfer** — h-BN-encapsulated heterostructures (van der Waals stacking)

---

## §4 Heterostructures — vdW stacking

The signature engineering of 2D materials: **stack different 2D crystals** (graphene / h-BN / MoS₂ / WSe₂) into multi-layer heterostructures with atomically clean interfaces. This is the Geim-Novoselov "Lego" model.

Use cases:
- h-BN encapsulation of graphene → reaches 100k+ cm²/V·s mobility (vs 200k theoretical)
- MoS₂ / WSe₂ vertical p-n junction → atomic-scale photodetector
- Moiré superlattices (twisted bilayer graphene at "magic angle" 1.1°) → flat bands, superconductivity (Cao et al. 2018 *Nature* 556, 43)

---

## §5 Real-limit anchors (planned)

- L2 σ_f — h-BN measured ~ 100-200 GPa (similar to graphene)
- L9 thermal k — h-BN in-plane ~ 1700 W/m·K (calculated), 2000+ measured for single-layer
- Bandgap mapping: MoS₂ 1.8 (direct, mono) vs 1.2 (indirect, bulk) — the "direct-to-indirect" transition is a uniquely 2D-materials phenomenon

---

## §6 Cross-links (when expanded)

- `GRAPHENE-CARBON.md` — carbon-side 2D materials
- `silicon/silicon.md` + `SILICON.md` — silicene + silicene-on-substrate
- `compound-semi/` (Phase D) — MoS₂ et al. as semiconductor
- `magnetic-materials/` (Phase D stub) — 2D magnets (CrI₃, Fe₃GeTe₂)
- `LIMIT_BREAKTHROUGH.md` — L2 σ / L9 k
- `hexa-chip` — 2D FET device + fab

---

## §7 Honest C3

Phase D candidate. Stub-level. Most "2D-material lab record" values (mobility, σ_f, k) are from sub-µm sample sizes; scale-up to wafer-scale loses 10-100× performance. Honest distinction will be preserved when chapter is authored. No lattice fit. Per `LATTICE_POLICY §1.2`.

---

*Stub authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase D roadmap marker.*
