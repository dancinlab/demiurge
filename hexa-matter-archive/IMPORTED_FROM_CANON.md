# IMPORTED_FROM_CANON — hexa-matter provenance ledger

> **Last updated**: 2026-05-13 (Phase A elevation)
> **Companion**: `tools/inject_provenance.hexa` (header injection) ·
> `tools/check_drift.hexa` (drift detector)
>
> This file is the single-source provenance ledger for hexa-matter — every
> file (or directory family) has a row stating whether it was extracted from
> canon at a known SHA, absorbed from a sister repo, or authored in-repo.

---

## §1 Extracted from canon (16 verb spec docs + ancillary)

Source: `dancinlab/canon` at `canon@47c70cbf` (2026-05-09 snapshot for the 16-verb migration; canon RETIRED 2026-05-11).

### Per-verb depth dirs (16 of the 17 v1.1.0 verbs)

| Local path | Canon source | Migration commit |
|------------|--------------|------------------|
| `aramid/aramid.md` | `canon/domains/materials/aramid/aramid.md` @ `47c70cbf` | `3819abb feat: initial hexa-matter v1.0.0 — 16-verb 소재 substrate ⚛️` |
| `ceramics/ceramics.md` | `canon/domains/materials/ceramics/ceramics.md` @ `47c70cbf` | `3819abb` |
| `concrete/concrete.md` | `canon/domains/materials/concrete/concrete.md` @ `47c70cbf` | `3819abb` |
| `concrete_tech/concrete_tech.md` | `canon/domains/materials/concrete_tech/concrete_tech.md` @ `47c70cbf` | `3819abb` |
| `epoxy/epoxy.md` | `canon/domains/materials/epoxy/epoxy.md` @ `47c70cbf` | `3819abb` |
| `fabric/fabric.md` | `canon/domains/materials/fabric/fabric.md` @ `47c70cbf` | `3819abb` |
| `fashion-textile/fashion-textile.md` | `canon/domains/materials/fashion-textile/fashion-textile.md` @ `47c70cbf` | `bae2426 feat(import): add 4 canon specs (MOVE migration)` |
| `gemology/gemology.md` | `canon/domains/materials/gemology/gemology.md` @ `47c70cbf` | `3819abb` |
| `glass/glass.md` | `canon/domains/materials/glass/glass.md` @ `47c70cbf` | `3819abb` |
| `lutherie/lutherie.md` | `canon/domains/materials/lutherie/lutherie.md` @ `47c70cbf` | `bae2426` |
| `metallurgy/metallurgy.md` | `canon/domains/materials/metallurgy/metallurgy.md` @ `47c70cbf` | `3819abb` |
| `nylon/nylon.md` | `canon/domains/materials/nylon/nylon.md` @ `47c70cbf` | `3819abb` |
| `paper/paper.md` | `canon/domains/materials/paper/paper.md` @ `47c70cbf` | `3819abb` |
| `pet_film/pet_film.md` | `canon/domains/materials/pet_film/pet_film.md` @ `47c70cbf` | `3819abb` |
| `recycle_n6/recycle_n6.md` | `canon/domains/materials/recycle_n6/recycle_n6.md` @ `47c70cbf` | `3819abb` |
| `recycling/recycling.md` | `canon/domains/materials/recycling/recycling.md` @ `47c70cbf` | `3819abb` |
| `synthesis/synthesis.md` | `canon/domains/materials/synthesis/synthesis.md` @ `47c70cbf` | `3819abb` |
| `textile-dyeing/textile-dyeing.md` | `canon/domains/materials/textile-dyeing/textile-dyeing.md` @ `47c70cbf` | `bae2426` |
| `tire_cord/tire_cord.md` | `canon/domains/materials/tire_cord/tire_cord.md` @ `47c70cbf` | `3819abb` |

Each file carries a `@canonical:` header line pointing to its canon source. Drift is checked by `tools/check_drift.hexa`.

### Root-level UPPERCASE.md domain expansion docs (from canon mk1)

Source: `dancinlab/canon` at canon mk1 (the pre-`47c70cbf` snapshot; absorbed 2026-05-12 commit `43a14dd docs: import 19 canon mk1 leaf docs as root UPPERCASE.md`).

| Local path | Canon mk1 source | Note |
|------------|------------------|------|
| `ARAMID.md` | `canon-mk1/domains/materials/aramid/ARAMID.md` | per-domain expansion doc (~19 kB) |
| `CERAMICS.md` | `canon-mk1/domains/materials/ceramics/CERAMICS.md` | ~37 kB |
| `CONCRETE.md` | `canon-mk1/domains/materials/concrete/CONCRETE.md` | ~19 kB |
| `CONCRETE-TECHNOLOGY.md` | `canon-mk1/domains/materials/concrete_tech/CONCRETE-TECHNOLOGY.md` | ~19 kB |
| `EPOXY.md` | `canon-mk1/domains/materials/epoxy/EPOXY.md` | ~19 kB |
| `FASHION-TEXTILE.md` | `canon-mk1/domains/materials/fashion-textile/FASHION-TEXTILE.md` | ~25 kB |
| `GEMOLOGY.md` | `canon-mk1/domains/materials/gemology/GEMOLOGY.md` | ~24 kB |
| `HEXA-FABRIC.md` | `canon-mk1/domains/materials/fabric/HEXA-FABRIC.md` | ~39 kB |
| `HEXA-GLASS.md` | `canon-mk1/domains/materials/glass/HEXA-GLASS.md` | ~50 kB |
| `HEXA-RECYCLE.md` | `canon-mk1/domains/materials/recycle_n6/HEXA-RECYCLE.md` | ~19 kB |
| `LUTHERIE.md` | `canon-mk1/domains/materials/lutherie/LUTHERIE.md` | ~34 kB |
| `MATERIAL-SYNTHESIS.md` | `canon-mk1/domains/materials/synthesis/MATERIAL-SYNTHESIS.md` | ~1.08 MB (largest single file) |
| `NYLON.md` | `canon-mk1/domains/materials/nylon/NYLON.md` | ~20 kB |
| `PAPER.md` | `canon-mk1/domains/materials/paper/PAPER.md` | ~2.6 MB (largest after MATERIAL-SYNTHESIS) |
| `PET-FILM.md` | `canon-mk1/domains/materials/pet_film/PET-FILM.md` | ~19 kB |
| `RECYCLING.md` | `canon-mk1/domains/materials/recycling/RECYCLING.md` | ~81 kB |
| `SWORDSMITHING.md` | `canon-mk1/domains/materials/metallurgy/SWORDSMITHING.md` | ~23 kB (metallurgy anchor) |
| `TEXTILE-DYEING.md` | `canon-mk1/domains/materials/textile-dyeing/TEXTILE-DYEING.md` | ~31 kB |
| `TIRE-CORD.md` | `canon-mk1/domains/materials/tire_cord/TIRE-CORD.md` | ~19 kB |

### Ancillary (papers + origins tools)

From canon @ `a86ca143` (2026-05-10 snapshot, residue migration):

#### papers/ — from canon `papers/`

- `papers/n6-carbon-capture-paper.md`
- `papers/n6-chemistry-paper.md`
- `papers/n6-polymer-engineering-paper.md`
- `papers/n6-textile-engineering-paper.md`

Migration: `fa27c0b feat(import): residue from canon@a86ca143 — 4 papers / 0 proofs / 2 origins tools`

#### origins/ — from canon `bridge/origins/` (calculator/DSE tools)

- `origins/carbon-capture-calc/`
- `origins/material-dse/`

Same migration commit.

#### breakthroughs/ — from canon `breakthroughs/` (Wave 5 import)

- `breakthroughs/bt-1388_ionic_octahedral/` (ionic-octahedral breakthrough)

Migration: `692257e feat(import): bt-1388 ionic-octahedral breakthrough — Wave 5`

---

## §2 Absorbed from sister repo (hexa-medic)

Migration: `7bf9b61 chore(verb): import microplastics from hexa-medic` (2026-05-12)

Per `hexa-bio/DECOMPOSITION_PLAN.md §1`, the `hexa-medic` repo was decomposed and `microplastics` moved to hexa-matter as part of GROUP_POL.

| Local path | Sister-repo source | Note |
|------------|---------------------|------|
| `microplastics/microplastics.md` | `dancinlab/hexa-medic` → moved 2026-05-12 | originally canon-derived; lineage preserved via @canonical: annotation |

The `microplastics.md` file retains its canon-lineage annotation (originally from `canon@<earlier-SHA>:domains/medical/microplastics/`) — preserving the pre-hexa-medic provenance even after the cross-repo move.

---

## §3 Authored in-repo (no canon source)

### v1.1.0 silicon (2026-05-13)

| Local path | Author | Note |
|------------|--------|------|
| `silicon/silicon.md` | 박민우 <nerve011235@gmail.com> @ 2026-05-13 | The 17th verb — added under Wave M LIMIT_BREAKTHROUGH gap-detection (no upstream canon source for silicon at the material layer). |

Carries `@authored: 2026-05-13` + `@author: 박민우 <nerve011235@gmail.com>` headers (NOT `@canonical:`).

Authored commit: `a239611 feat(silicon): add silicon material spec — 17/17 verbs (Si wafer, polysilicon, mono-Si, SiO₂ cross-link)`.

### Phase A infrastructure docs (2026-05-13)

| Local path | Author | Note |
|------------|--------|------|
| `AXIS.md` | 박민우 @ 2026-05-13 | 7-group material taxonomy |
| `AXIS_CLOSURE_PLAN.md` | 박민우 @ 2026-05-13 | per-group closure roadmap |
| `CLOSURE_RESIDUAL_BACKLOG.md` | 박민우 @ 2026-05-13 | (b)/(c) deferral ledger |
| `DECOMPOSITION_PLAN.md` | 박민우 @ 2026-05-13 | taxonomy decomposition |
| `LESSONS.md` | 박민우 @ 2026-05-13 | v1.0.0 → v1.1.0 construction journal |
| `RELEASE_NOTES_v1.0.0.md` | 박민우 @ 2026-05-13 | retroactive v1.0.0 notes |
| `RELEASE_NOTES_v1.1.0.md` | 박민우 @ 2026-05-13 | v1.1.0 notes (silicon + Phase A) |
| `V1_2_0_HANDOFF.md` | 박민우 @ 2026-05-13 | Phase B-G roadmap |
| `USER_ACTION_REQUIRED.md` | 박민우 @ 2026-05-13 | active asks for the user |
| `IMPORTED_FROM_CANON.md` (this file) | 박민우 @ 2026-05-13 | updated provenance ledger |

### v1.1.0 expansion docs (Phase A, 2026-05-13)

| Local path | Author | Note |
|------------|--------|------|
| `SILICON.md` | 박민우 @ 2026-05-13 | silicon deep dive (CZ pull-rate physics, FZ, donor concentration, isotope-Si-28) |
| `CERAMIC-ENGINEERING.md` | 박민우 @ 2026-05-13 | ceramic engineering depth (Si₃N₄ turbocharger, SiC armor, ZTA, Vickers/Knoop map) |
| `METALLURGY-DEEP.md` | 박민우 @ 2026-05-13 | superalloy + heat-treatment (Inconel 718, single-crystal, Ti-6Al-4V, TTT) |
| `POLYMER-CHEMISTRY.md` | 박민우 @ 2026-05-13 | polymer chemistry (chain-growth, MW, Tg/Tm, biodegradable) |
| `GRAPHENE-CARBON.md` | 박민우 @ 2026-05-13 | graphene / CNT / diamond / fullerene |

### v1.1.0 Phase D candidate stubs (Phase A, 2026-05-13)

| Local path | Author | Note |
|------------|--------|------|
| `ELASTOMER.md` | 박민우 @ 2026-05-13 | stub (~50 lines), Phase D roadmap marker |
| `COMPOUND-SEMI.md` | 박민우 @ 2026-05-13 | stub |
| `PEROVSKITE.md` | 박민우 @ 2026-05-13 | stub |
| `2D-MATERIALS.md` | 박민우 @ 2026-05-13 | stub |
| `ADHESIVE.md` | 박민우 @ 2026-05-13 | stub |
| `MAGNETIC-MATERIALS.md` | 박민우 @ 2026-05-13 | stub |
| `MOF.md` | 박민우 @ 2026-05-13 | stub |
| `LIQUID-CRYSTAL.md` | 박민우 @ 2026-05-13 | stub |
| `SUPERALLOY.md` | 박민우 @ 2026-05-13 | stub |
| `BIODEGRADABLE-PLASTICS.md` | 박민우 @ 2026-05-13 | stub |
| `WOOD-CELLULOSE.md` | 박민우 @ 2026-05-13 | stub |

---

## §4 Repo policies (Wave K + M + project-level)

These files were authored under the dancinlab-wide LATTICE_POLICY rollout, with hexa-matter-specific instantiation:

| Local path | Origin | Note |
|------------|--------|------|
| `LATTICE_POLICY.md` | Wave K (2026-05-12, dancinlab-wide) | `042232f docs(policy): adopt LATTICE_POLICY.md` |
| `LIMIT_BREAKTHROUGH.md` | Wave M (2026-05-12, project-specific) | `3d2421a docs(limits): LIMIT_BREAKTHROUGH.md — real-limits audit (Wave M)` |
| `AGENTS.md` | Wave K2 (2026-05-12) | `e7b1859 docs(agents): register LATTICE_POLICY.md in AGENTS.md (Wave K2)` |
| `README.md` | initial + iterated | release-cycle hardened |
| `hexa.toml` | initial + iterated | scoreboard SSOT |

---

## §5 Tooling (provenance + drift detection)

- `tools/inject_provenance.hexa` — injects `@canonical:` headers on canon-imported files
- `tools/check_drift.hexa` — flags files where the local content has drifted from the canon-source SHA without a provenance pointer bump

---

## §6 Honest C3

- This file is the **single-source provenance ledger** for hexa-matter. Every shipping file (or file family) has a row stating its origin.
- The split between **extracted** (canon source SHA known) and **authored** (in-repo, with `@authored:` header) is load-bearing — the drift checker uses it.
- Cross-repo absorption (microplastics from hexa-medic) preserves the *original* canon lineage in the file's frontmatter, plus an explicit `imported-via: hexa-medic 2026-05-12` annotation.
- No n=6 lattice anchoring of any provenance claim (per LATTICE_POLICY §1.2).

---

*Document updated 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase A elevation. Previous version (2026-05-10) covered only papers/ + origins/ residue; expanded to full ledger.*
