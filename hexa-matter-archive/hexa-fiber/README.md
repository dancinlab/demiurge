<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @phase: C — axis-prefixed depth directory for GROUP_FIB -->
---
depth_dir: hexa-fiber
axis_group: GROUP_FIB
verb_members:
  - aramid
  - fabric
  - paper
  - wood-cellulose
cross_link_members:
  - carbon (carbon fiber form-factor)
  - tire_cord
  - pet_film
  - nylon (textile fiber)
status: SPEC_FIRST · category-(a) 100% · (b) UNVERIFIED · (c) OUT-OF-REPO
---

# hexa-fiber — GROUP_FIB depth directory

> **Aggregates the fiber + paper + cellulose group.** Member verbs span
> covalent backbone (cellulose, lignin, aramid, polyester, carbon) with
> extensive H-bonding (cellulose) and mechanical anisotropy (fiber → fabric → 3D structure).

> **Honesty.** CNT yarn 80 GPa = lab mm-scale (commercial 1–3 GPa)
> per `carbon/carbon.md`. 50+ story mass-timber UNVERIFIED; transparent /
> densified wood UNVERIFIED at cost per `wood-cellulose/wood-cellulose.md`.

---

## §1 Scope

GROUP_FIB covers 3 dispatchable verbs (per `AXIS.md §0` post-Phase D), plus
explicit cross-link verbs that share fiber form-factor.

| Layer | Verbs | Backbone |
|-------|-------|----------|
| Core FIB | fabric, paper, wood-cellulose | cellulose (β-1,4-glucose), lignin, mixed POL fibers |
| Cross-link (POL fiber) | aramid, nylon, pet_film, tire_cord | amide / ester / mixed |
| Cross-link (CER fiber) | carbon (CFR, CNT), glass-fiber (SiO₂) | covalent sp²/sp³ / Si-O |

## §2 Member verbs

Core FIB:
- **fabric** → [`../fabric/fabric.md`](../fabric/fabric.md) — woven, knit, non-woven; cotton, wool, silk, synthetic blends
- **paper** → [`../paper/paper.md`](../paper/paper.md) — kraft, sulfite, mechanical, recycled; cellulose XRD crystallinity
- **wood-cellulose** (Phase D) → [`../wood-cellulose/wood-cellulose.md`](../wood-cellulose/wood-cellulose.md) — engineered wood (CLT, LVL, glulam), nanocellulose (CNF, CNC), cellulose acetate
- **aramid** → [`../aramid/aramid.md`](../aramid/aramid.md) — PPTA fiber (Kevlar 49, Twaron, Technora); fiber form-factor here, polymer chemistry in POL

Cross-linked (fiber form-factor of other groups):
- **carbon** (CER) → [`../carbon/carbon.md`](../carbon/carbon.md) — carbon fiber, CNT yarn, graphite fiber
- **tire_cord** → [`../tire_cord/tire_cord.md`](../tire_cord/tire_cord.md) — nylon/PET/aramid downstream
- **pet_film** → [`../pet_film/pet_film.md`](../pet_film/pet_film.md) — film not fiber but planar form
- **nylon, pet** (POL) → [`../nylon/nylon.md`](../nylon/nylon.md), [`../pet_film/pet_film.md`](../pet_film/pet_film.md) — textile fiber form

## §3 Cross-links to root deep-expansion docs

- [`../ARAMID.md`](../ARAMID.md) — aramid stub
- [`../GRAPHENE-CARBON.md`](../GRAPHENE-CARBON.md) — carbon fiber + CNT + graphene (353 lines)
- [`../WOOD-CELLULOSE.md`](../WOOD-CELLULOSE.md) — Phase D stub
- [`../PAPER.md`](../PAPER.md) — paper stub
- [`../POLYMER-CHEMISTRY.md`](../POLYMER-CHEMISTRY.md) — fiber-grade polymer (root, 439 lines)
- [`../LIMIT_BREAKTHROUGH.md`](../LIMIT_BREAKTHROUGH.md) — L1 Frenkel σ_th, L2 practical tensile

## §4 Group-level closure status

| Category | Status | Notes |
|----------|--------|-------|
| (a) | **100%** — 3 dispatchable + cross-link verbs spec-present | post-Phase D |
| (b) | **UNVERIFIED** — ~4 parity gates queued | Phase B |
| (c) | **OUT-OF-REPO** — natural-fiber harvest yields, mass-timber 50-story, pulp-mill pilot | vendor / supply chain |

## §5 UNPROVEN / UNVERIFIED markers (verbatim)

- **wood-cellulose** (Phase D) — 50+ story mass-timber UNVERIFIED; transparent/densified wood UNVERIFIED at cost
- **carbon** (cross-link) — CNT yarn 80 GPa = lab mm-scale (commercial 1-3 GPa); bulk lonsdaleite UNVERIFIED
- **aramid** — pilot synthesis OUT-OF-REPO (DuPont proprietary); Kevlar 49 σ 3.6 GPa is lab fiber, not bulk

## §6 Cross-group interface points

| Boundary | Interface | Reference |
|----------|-----------|-----------|
| FIB ↔ POL | aramid, nylon, polyester fiber form-factor | hexa-polymer/ |
| FIB ↔ CER | glass fiber (SiO₂), carbon fiber (covalent C), ceramic fiber (SiC) | hexa-ceramic/ |
| FIB ↔ FAS | textile fabric, dyeing, garment | hexa-fashion/ |
| FIB ↔ PRC | pulping (kraft, sulfite), spinning (melt, solution, wet), papermaking | hexa-synthesis/ |
| FIB ↔ MET | (negligible — reinforced concrete uses steel rebar not fiber) | n/a |

## §7 Files in this depth dir

- `README.md` (this file)
- [`fiber-architecture.md`](fiber-architecture.md) — assembly hierarchy: 1D fiber → 2D fabric → 3D structure
- [`fiber-data-anchors.md`](fiber-data-anchors.md) — ASM/ASTM/TAPPI/ISO anchor table
- [`fiber-closure-status.md`](fiber-closure-status.md) — (a)/(b)/(c) per-verb ledger

---

*Phase C depth-dir, authored 2026-05-13.*
