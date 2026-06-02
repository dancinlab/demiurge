<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @phase: C — axis-prefixed depth directory for GROUP_MET -->
---
depth_dir: hexa-metal
axis_group: GROUP_MET
verb_members:
  - metallurgy
  - superalloy
  - magnetic-materials
cross_link_members:
  - lutherie (string alloy cross-link; culture overlap)
  - silicon (Si as alloy element)
status: SPEC_FIRST · category-(a) 100% · (b) UNVERIFIED · (c) OUT-OF-REPO
---

# hexa-metal — GROUP_MET depth directory

> **Aggregates the metallurgy group.** Member verbs cover ferrous + non-ferrous
> alloys, superalloys (Phase D), magnetic materials (Phase D). Root deep-expansion
> is `METALLURGY-DEEP.md` (308 lines) and `SUPERALLOY.md` + `MAGNETIC-MATERIALS.md`
> Phase D stubs.

> **Honesty.** L5 melting point ceiling 4215 K (Ta₄HfC₅) is HARD (bond
> energy). L6 density ceiling 22.59 g/cm³ (Os) is HARD (stable matter).
> Rare-earth-free magnet > 35 MGOe UNVERIFIED. Re-free 4th-gen SX superalloy
> at parity with Re-bearing UNVERIFIED. Tetrataenite / MnBi / Fe₁₆N₂ R&D only.

---

## §1 Scope

GROUP_MET covers 3 dispatchable verbs (per `AXIS.md §0` post-Phase D).
`lutherie/` is FIB-adjacent (culture overlap), kept as cross-link.

| Layer | Verbs | Class |
|-------|-------|-------|
| Core MET | metallurgy | ferrous + non-ferrous + casting + heat-treatment |
| Phase D | superalloy, magnetic-materials | Ni/Co/Fe-base; NdFeB/SmCo/ferrite |
| Cross-link | lutherie (string alloy); silicon (Si as alloy) | acoustic alloys + Si alloying |

## §2 Member verbs

Core MET:
- **metallurgy** → [`../metallurgy/metallurgy.md`](../metallurgy/metallurgy.md) — Fe-Fe₃C, Al-Si, Ti-6Al-4V, brass, bronze, austenite-martensite-bainite TTT
- **superalloy** (Phase D) → [`../superalloy/superalloy.md`](../superalloy/superalloy.md) — Ni-base Inconel 718 / single-crystal turbine blade CMSX-10 / Co-base / Fe-Ni-base
- **magnetic-materials** (Phase D) → [`../magnetic-materials/magnetic-materials.md`](../magnetic-materials/magnetic-materials.md) — NdFeB, SmCo, ferrite, Metglas (amorphous), Finemet (nanocrystalline)

Cross-linked:
- **lutherie** → [`../lutherie/lutherie.md`](../lutherie/lutherie.md) — bell brass, gong bronze, string alloy (steel, bronze, nylon-wound)
- **silicon** (cross-link to CER + MET) → [`../silicon/silicon.md`](../silicon/silicon.md) — Al-Si casting alloy, Fe-Si electrical steel, Cu-Si silicon-bronze

## §3 Cross-links to root deep-expansion docs

- [`../METALLURGY-DEEP.md`](../METALLURGY-DEEP.md) — root deep-dive (308 lines)
- [`../SUPERALLOY.md`](../SUPERALLOY.md) — Phase D stub
- [`../MAGNETIC-MATERIALS.md`](../MAGNETIC-MATERIALS.md) — Phase D stub
- [`../SWORDSMITHING.md`](../SWORDSMITHING.md) — alloy phase diagram + heat treatment crossover (culture)
- [`../LUTHERIE.md`](../LUTHERIE.md) — string alloy + bell brass + gong bronze
- [`../LIMIT_BREAKTHROUGH.md`](../LIMIT_BREAKTHROUGH.md) — L5 (melting point 4215 K), L6 (density 22.59 g/cm³), L9 (thermal conductivity Cu/Ag)

## §4 Group-level closure status

| Category | Status | Notes |
|----------|--------|-------|
| (a) | **100%** — 3 dispatchable MET verbs spec-present | post-Phase D (superalloy + magnetic-materials added) |
| (b) | **UNVERIFIED** — ~3 parity gates queued (B-MET-1..B-MET-3) | Phase B target |
| (c) | **OUT-OF-REPO** — single-crystal turbine blade casting; Ti-6Al-4V grade-5 wet-process; luthier studio | vendor / craft |

## §5 UNPROVEN / UNVERIFIED markers (verbatim)

- **superalloy** (Phase D) — Re-free 4th-gen SX at parity UNVERIFIED; Co-base SX commercial UNVERIFIED
- **magnetic-materials** (Phase D) — rare-earth-free > 35 MGOe UNVERIFIED; tetrataenite / MnBi / Fe₁₆N₂ R&D only

## §6 Cross-group interface points

| Boundary | Interface | Reference |
|----------|-----------|-----------|
| MET ↔ CER | silicide phases (Fe₃Si, FeSi₂); refractory carbides (WC, TaC, HfC); ceramic-coating | hexa-ceramic/ |
| MET ↔ POL | rubber-bonded metal mount; adhesive-bonded metal joint | hexa-polymer/ |
| MET ↔ FIB | (negligible — steel rebar is structural not fiber) | n/a |
| MET ↔ PRC | casting, forging, rolling, heat-treatment, 3D-printing | hexa-synthesis/ |
| MET ↔ GEM | gold/platinum mountings; chemistry overlap | hexa-gem/ |
| MET ↔ FAS | metallic thread (gold thread); zippers, snaps | hexa-fashion/ |

## §7 Files in this depth dir

- `README.md` (this file)
- [`metal-architecture.md`](metal-architecture.md) — alloy categories, processing routes, superalloy strengthening mechanisms
- [`metal-data-anchors.md`](metal-data-anchors.md) — ASM/CRC/NIST/vendor anchor table
- [`metal-closure-status.md`](metal-closure-status.md) — (a)/(b)/(c) per-verb ledger

---

*Phase C depth-dir, authored 2026-05-13.*
