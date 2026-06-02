<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @phase: C — axis-prefixed depth directory for GROUP_CER -->
---
depth_dir: hexa-ceramic
axis_group: GROUP_CER
verb_members:
  - ceramics
  - concrete
  - concrete_tech
  - glass
cross_link_members:
  - silicon (SiO₂, SiC, Si₃N₄ → CER overlap)
  - compound-semi (SiC wide-bandgap ceramic semi)
  - perovskite (ABO₃ oxide ceramic class)
  - 2d-materials (hBN as ceramic 2D)
  - mof (porous coordination polymer — frame-ceramic class)
  - carbon (diamond, glassy carbon ceramic class)
status: SPEC_FIRST · category-(a) 100% · (b) UNVERIFIED · (c) OUT-OF-REPO
---

# hexa-ceramic — GROUP_CER depth directory

> **Aggregates the ceramic / inorganic / silicate group.** Member verbs +
> cross-link verbs that touch ceramic bond character (ionic + covalent +
> vdW). The root deep-expansion is `CERAMIC-ENGINEERING.md` (299 lines);
> this directory bridges that to per-verb specs.

> **Honesty.** Mohs 10 (diamond) ceiling, T_m 4215 K (Ta₄HfC₅) ceiling,
> fused silica T_g ~1473 K, UHPC compressive 800 MPa, theoretical concrete
> 2 GPa — these are ASM/NIST/CRC/ACI anchors. The n=6 lattice does not
> predict them. LK-99 remains NOT REPRODUCED (HARD_WALL per
> `LIMIT_BREAKTHROUGH.md`).

---

## §1 Scope

GROUP_CER covers four "core" verbs from v1.0.0 plus 5 Phase D ceramic-adjacent
additions that cross-link in:

| Layer | Verbs | Bond character |
|-------|-------|----------------|
| Core CER | ceramics, concrete, concrete_tech, glass | ionic + covalent (silicate, aluminate, oxide) |
| Si cross-link | silicon (SiO₂, SiC, Si₃N₄) | covalent (Si-O, Si-C, Si-N) |
| Phase D CER | compound-semi (SiC, GaN), perovskite (ABO₃), 2d-materials (hBN), mof, carbon | mixed; refractory, wide-bandgap, porous, allotropic |

## §2 Member verbs

Core CER verbs:
- **ceramics** → [`../ceramics/ceramics.md`](../ceramics/ceramics.md) — Si₃N₄, Al₂O₃, ZrO₂, SiC, BeO, B₄C engineering ceramic class
- **concrete** → [`../concrete/concrete.md`](../concrete/concrete.md) — Portland cement, aluminosilicate hydrate
- **concrete_tech** → [`../concrete_tech/concrete_tech.md`](../concrete_tech/concrete_tech.md) — UHPC, fiber-reinforced, curing thermal model
- **glass** → [`../glass/glass.md`](../glass/glass.md) — fused silica, soda-lime, borosilicate, lead crystal

Cross-link members (Phase D + Si cross-link):
- **silicon** (SiO₂/SiC/SiN cross-link) → [`../silicon/silicon.md`](../silicon/silicon.md) + [`../hexa-silicon/`](../hexa-silicon/)
- **compound-semi** → [`../compound-semi/compound-semi.md`](../compound-semi/compound-semi.md) — SiC, GaN, GaAs, InP wide-bandgap wafers
- **perovskite** → [`../perovskite/perovskite.md`](../perovskite/perovskite.md) — ABX₃ PV + oxide perovskite (SrTiO₃, BaTiO₃, antiferroelectric)
- **2d-materials** → [`../2d-materials/2d-materials.md`](../2d-materials/2d-materials.md) — hBN as 2D ceramic, MoS₂, WS₂, MXene
- **mof** → [`../mof/mof.md`](../mof/mof.md) — HKUST-1, MOF-5, ZIF-8, MIL-101, UiO-66
- **carbon** → [`../carbon/carbon.md`](../carbon/carbon.md) — diamond, glassy carbon, pyrolytic, CNT, fullerene

## §3 Cross-links to root deep-expansion docs

- [`../CERAMIC-ENGINEERING.md`](../CERAMIC-ENGINEERING.md) — root deep-dive (299 lines): bond character, sintering, sol-gel, processing
- [`../SILICON.md`](../SILICON.md) — Si-as-ceramic (SiO₂, SiC, Si₃N₄ cross-link)
- [`../COMPOUND-SEMI.md`](../COMPOUND-SEMI.md) — wide-bandgap ceramic semi stub
- [`../PEROVSKITE.md`](../PEROVSKITE.md) — perovskite stub
- [`../2D-MATERIALS.md`](../2D-MATERIALS.md) — 2D ceramic / 2D semi stub
- [`../MOF.md`](../MOF.md) — porous coordination polymer stub
- [`../GRAPHENE-CARBON.md`](../GRAPHENE-CARBON.md) — carbon allotrope deep-dive (353 lines)
- [`../LIMIT_BREAKTHROUGH.md`](../LIMIT_BREAKTHROUGH.md) — L4 (Mohs 10), L5 (T_m 4215 K), L7 (T_g), L8 (concrete σ_c)

## §4 Group-level closure status

| Category | Status | Notes |
|----------|--------|-------|
| (a) | **100%** — 10/10 CER verbs spec-present | post-Phase D (5 + silicon + 4 D verbs) |
| (b) | ✅ **CLOSED 2026-05-13** — 9/9 CER parity gates landed (B-CER-1..B-CER-9) under `tests/cer_b*_parity.py`; sweeps by `selftest/parity_gates_smoke.sh` | Phase H + I.1 + I.2 (all closed) |
| (c) | **OUT-OF-REPO** — LK-99 reproduction, antiferroelectric perovskite growth, Wolfspeed SiC fab, Wacker poly-Si batch | vendor numbers only |

Per `AXIS_CLOSURE_PLAN.md §3`, GROUP_CER sequencing is FIRST for (b) closure
because Si-L1..Si-L12 (added 2026-05-13) are the freshest entries.

## §5 UNPROVEN / UNVERIFIED markers (verbatim from verb specs)

From Phase D verb specs + core specs:

- **compound-semi**: 6/8" bulk GaN ammonothermal UNVERIFIED at production; diamond-as-semi wafer UNPROVEN
- **perovskite**: LK-99 NOT REPRODUCED (HARD_WALL per LIMIT_BREAKTHROUGH); large-area + 25-yr-lifetime UNVERIFIED
- **2d-materials**: wafer-scale 2D mobility 10–100× loss vs lab; phosphorene ambient + 2D-magnet T_c > 300 K UNVERIFIED
- **mof**: magic-MOF-DAC $100/t CO₂ UNPROVEN (Climeworks amine $600–1000/t)
- **carbon**: CNT yarn 80 GPa = lab mm-scale (commercial 1–3 GPa); bulk lonsdaleite + carbyne + diamond-semi UNVERIFIED
- **silicon** (cross-link): Wacker batch 9N lot trace UNVERIFIED; isotope-separated Si-28 commercial scale UNVERIFIED
- **glass**: high-purity quartz mining (Spruce Pine NC dominance) (c)-out-of-repo
- **ceramics**: ceramic-armor production scale (c)-out-of-repo
- **concrete_tech**: UHPC pilot-pour cost/m³ (c)-out-of-repo

## §6 Cross-group interface points

| Boundary | Interface | Reference |
|----------|-----------|-----------|
| CER ↔ MET | silicide phases (Fe₃Si, FeSi₂, β-Fe₂Si); refractory metal carbides (TaC, HfC, WC) | hexa-metal/ + ceramics.md |
| CER ↔ POL | composite matrix (carbon fiber in epoxy → ceramic-matrix composite CMC); silicone (Si-O-C) | hexa-polymer/ + epoxy.md |
| CER ↔ FIB | fiberglass (SiO₂ glass fiber); ceramic-fiber composites; carbon fiber | hexa-fiber/ + glass.md + carbon.md |
| CER ↔ PRC | sintering (high-T solid-state); CVD (SiC, GaN); sol-gel (SiO₂); CZ/FZ (Si) | hexa-synthesis/ + synthesis.md |
| CER ↔ GEM | corundum (Al₂O₃) sapphire/ruby; diamond (C); spinel (MgAl₂O₄) | hexa-gem/ + gemology.md |
| CER ↔ FAS | (negligible — fiberglass cloth in composite scope) | n/a |

## §7 Files in this depth dir

- `README.md` (this file)
- [`ceramic-architecture.md`](ceramic-architecture.md) — bond character, processing routes, ceramic-glass continuum
- [`ceramic-data-anchors.md`](ceramic-data-anchors.md) — NIST/CRC/ASM/ACI/ASTM anchor table
- [`ceramic-closure-status.md`](ceramic-closure-status.md) — (a)/(b)/(c) per-verb ledger

---

*Phase C depth-dir, authored 2026-05-13. Real anchors are CRC/NIST/ASM/ACI; no
n=6 lattice arithmetic applied to ceramic parameters per `LATTICE_POLICY §1.2`.*
