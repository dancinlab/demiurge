# Release Notes — hexa-matter v1.1.0

**Release date**: 2026-05-13
**Status**: SPEC_FIRST · **17 verbs** · 4/4 verify PASS · CLOSED
**Author**: 박민우 <nerve011235@gmail.com>
**Tag**: `v1.1.0` (silicon addition + Phase A infrastructure)
**Commit**: `a239611 feat(silicon): add silicon material spec — 17/17 verbs (Si wafer, polysilicon, mono-Si, SiO₂ cross-link)`

---

## Summary

hexa-matter v1.1.0 adds **silicon** as the 17th verb — closing the gap surfaced by the Wave M `LIMIT_BREAKTHROUGH.md` audit (no Si-shaped row in the limits table for v1.0.0). Silicon is the **material layer** of Si (poly-Si, mono-Si wafer, SiO₂, SiC, SiN, silicone), with the chip-grade *device + fab process* discipline preserved (those stay in `hexa-chip`).

This release also lands the Wave K LATTICE_POLICY and Wave M LIMIT_BREAKTHROUGH infrastructure (both technically completed during the v1.0.0 → v1.1.0 window), the microplastics absorption from hexa-medic, and the Phase A infrastructure docs (AXIS, AXIS_CLOSURE_PLAN, CLOSURE_RESIDUAL_BACKLOG, DECOMPOSITION_PLAN, LESSONS, USER_ACTION_REQUIRED, V1_2_0_HANDOFF).

---

## Headline change — silicon (the 17th verb)

### What was added

| File | Lines | Provenance |
|------|-------|------------|
| `silicon/silicon.md` | ~300 | **Authored in-repo 2026-05-13** (no canon source) — 박민우 <nerve011235@gmail.com> |

### Why

`LIMIT_BREAKTHROUGH.md` Wave M (2026-05-12) enumerated 12 material limits (L1..L12) for steel/aramid/UHPC/diamond/Os/etc. The audit was clean structurally but had **no rows for silicon**: poly-Si purity ceiling, mono-Si wafer dimensions, SiC bandgap, Si₃N₄ flexural strength were absent. This was a gap.

Investigating the gap: silicon material parameters did not live in any other hexa-* repo at the right granularity. `hexa-chip` owns the *device + fab process* (lithography, EUV resist, transistor architecture), not the material parameters. So we added Si material to hexa-matter as the 17th verb.

### What silicon covers

| Form | In-scope here | Out-of-scope (lives elsewhere) |
|------|---------------|----------------------------------|
| Polysilicon (poly-Si, 6N-11N grades) | ✅ yes — material layer | — |
| Monocrystalline Si (CZ-pulled, FZ-grown) | ✅ yes — material layer | — |
| SiO₂ (quartz, fused silica, silicate glass) | ✅ yes — cross-link to `glass/` | — |
| SiC / SiN / Si₃N₄ ceramics | ✅ yes — cross-link to `ceramics/` | — |
| Silicone (Si-O polymer, PDMS) | ✅ yes — Si-O polymer (silicone ≠ silicon) | — |
| Semiconductor device (transistor, MOSFET) | ❌ no | `hexa-chip` (call `hexa-chip materials`) |
| Lithography, EUV resist, fab capacity | ❌ no | `hexa-chip` |
| Photovoltaic device design | ❌ no (PV material flow IS in scope; device design isn't) | hexa-energy / hexa-chip |

### Real-limits added (Si-L1..Si-L12)

From `silicon/silicon.md §2`:

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| Si-L1 | Electronic-grade poly-Si purity | Engineering / SOFT | **9N (99.9999999 %)** | SEMI M1 + vendor (Wacker, Hemlock) |
| Si-L2 | Solar-grade poly-Si floor | Engineering / SOFT | 6N–7N | SEMI PV17 |
| Si-L3 | CZ crucible diameter | Engineering / SOFT | ~600 mm | Ferrotec / Heraeus |
| Si-L4 | FZ ingot diameter | Engineering / SOFT | ~200 mm | Topsil / Siltronic |
| Si-L5 | Si melting point | Physical / HARD | **1687 K (1414 °C)** | NIST WebBook |
| Si-L6 | Si density (293 K) | Physical / HARD | **2.329 g/cm³** | CRC 105th ed. |
| Si-L7 | Si bandgap (indirect, 300 K) | Physical / HARD | **1.12 eV** | NIST / Sze SM Physics |
| Si-L8 | Thermal donor concentration | Physical / SOFT | ~10¹⁶ cm⁻³ | Kaiser-Frisch 1958 |
| Si-L9 | Interstitial oxygen [O_i] | Engineering / SOFT | 10–30 ppma (CZ); <0.1 ppma (FZ) | ASTM F121/F1188 |
| Si-L10 | Dislocation density | Engineering / SOFT | <100 cm⁻² production; 0 achievable | ASTM F47 |
| Si-L11 | SiC bandgap (4H) | Physical / HARD | **3.26 eV** | Saddow & Agarwal 2004 |
| Si-L12 | Si₃N₄ flexural strength (HIP) | Engineering / SOFT | 600–1200 MPa | ASM Handbook vol. 21 |

### Honest C3 — no lattice fit on external entities


> Polysilicon global production (electronic + solar grade combined), as of
> the most recent public reporting. Numbers are vendor / market-research
> published; this spec **does not project these onto n=6 nor claim n=6 is
> implicated**.

Vendor tonnage table includes GCL Technology, Wacker, Hemlock, OCI, REC Silicon, Tongwei — all with explicit vendor-source citations and **no lattice fit**.

### Cross-links from silicon

- `silicon/` ↔ `glass/` (SiO₂ shared substrate)
- `silicon/` ↔ `ceramics/` (SiC, Si₃N₄ shared substrate)
- `silicon/` ↔ `metallurgy/` (Si as alloy element: Al-Si casting alloy, Fe-Si electrical steel, Cu-Si bronze)
- `silicon/` ↔ `synthesis/` (CZ pull, FZ float zone, Siemens process, FBR fluidized-bed reactor)
- `silicon/` → `hexa-chip materials` (device + fab process boundary)

---

## Other changes in v1.1.0

### Wave K — LATTICE_POLICY adoption (2026-05-12)

Commits:
- `042232f docs(policy): adopt LATTICE_POLICY.md — verify against real math/physics limits, not n=6 lattice`
- `e7b1859 docs(agents): register LATTICE_POLICY.md in AGENTS.md (Wave K2)`
- `919dc36 docs(agents): confirm LIMIT_BREAKTHROUGH.md in AGENTS.md (Wave K3)`


### Wave M — LIMIT_BREAKTHROUGH audit (2026-05-12)

Commit:
- `3d2421a docs(limits): LIMIT_BREAKTHROUGH.md — real-limits audit (Wave M)`

Effect: 12-row real-limits table (L1..L12) anchored on NIST/CRC/ASM/Ashby/Hales/Frenkel. Gap detection surfaced the silicon-shaped hole in the substrate.

### Microplastics absorbed (2026-05-12)

Commit:
- `7bf9b61 chore(verb): import microplastics from hexa-medic`

Effect: hexa-medic decomposition (per `hexa-bio/DECOMPOSITION_PLAN.md §1`) moved `microplastics` to hexa-matter. Fit cleanly into GROUP_POL.

### Verify scoreboard reached 4/4 PASS

Commit:
- `91981d4 chore(closure): drive hexa-matter to 100% spec-first verify closure (4/4)`

Effect: all 4 verify scripts (spec_presence, lattice_arithmetic, real_limits_anchor, closure_consistency) PASS. `hexa.toml [verify].verdict = "CLOSED"`.

### Phase A infrastructure docs (2026-05-13)

This release.

Added (10 files):
- `AXIS.md` — 7-group material taxonomy
- `AXIS_CLOSURE_PLAN.md` — per-group (a)/(b)/(c) closure roadmap
- `CLOSURE_RESIDUAL_BACKLOG.md` — per-row (b)/(c) deferral ledger
- `DECOMPOSITION_PLAN.md` — taxonomy decomposition: 7 groups → 17 verbs → 12+ Phase D candidates
- `LESSONS.md` — v1.0.0 → v1.1.0 construction journal
- `RELEASE_NOTES_v1.0.0.md` — retroactive v1.0.0 release notes
- `RELEASE_NOTES_v1.1.0.md` — this file
- `V1_2_0_HANDOFF.md` — Phase B-G roadmap summary
- `USER_ACTION_REQUIRED.md` — active asks for the user
- `IMPORTED_FROM_CANON.md` — updated provenance ledger

Plus N expansion docs (UPPERCASE.md, ~300+ lines each):
- `SILICON.md` — silicon deep dive (CZ pull-rate physics, FZ floating zone, donor concentration, etch-rate vs orientation, isotope-separated Si-28 cost ceiling)
- `CERAMIC-ENGINEERING.md` — ceramic engineering depth (Si₃N₄ turbocharger blade, SiC armor, ZTA, Vickers/Knoop hardness map)
- `METALLURGY-DEEP.md` — superalloy + heat-treatment depth (Inconel 718, single-crystal turbine blade, Ti-6Al-4V, TTT diagrams)
- `POLYMER-CHEMISTRY.md` — polymer chemistry depth (chain-growth vs step-growth, MW distribution, Tg/Tm, biodegradable PLA/PHA/PBS)
- `GRAPHENE-CARBON.md` — graphene / CNT / diamond / fullerene chapter (CVD growth, transfer process, defect density vs sheet resistance, HPHT)

Plus Phase D candidate stubs (UPPERCASE.md, ~50 lines each):
- `ELASTOMER.md` — natural rubber, SBR, EPDM, silicone elastomer
- `COMPOUND-SEMI.md` — GaN, SiC (device side), GaAs, InP, AlN
- `PEROVSKITE.md` — ABO₃ family + LK-99 status + MAPbI₃
- `2D-MATERIALS.md` — graphene, h-BN, MoS₂, WSe₂, phosphorene
- `ADHESIVE.md` — adhesion mechanisms, cyanoacrylate, polyurethane
- `MAGNETIC-MATERIALS.md` — NdFeB, SmCo, ferrite, electrical steel
- `MOF.md` — metal-organic frameworks (HKUST-1, ZIF-8)
- `LIQUID-CRYSTAL.md` — nematic, smectic, cholesteric phases
- `SUPERALLOY.md` — Ni-based + single-crystal turbine blade overview stub
- `BIODEGRADABLE-PLASTICS.md` — PLA, PHA, PBS, PHB
- `WOOD-CELLULOSE.md` — wood, lignocellulose, nanocellulose (CNC/CNF)

---

## Verdict (v1.1.0)

```toml
[closure]
verbs_total = 17
groups_total = 7
verbs_wired = 0
verbs_spec = 17
verdict = "SPEC_FIRST"
extracted_from = "canon/domains/materials/ @ 47c70cbf (+ silicon authored 2026-05-13 in-repo, not extracted)"

[verify]
scripts_total = 4
scripts_passed = 4
verdict = "CLOSED"  # 17/17 verbs spec-present · 4/4 verify scripts PASS
```

---

## Cross-link policy update (v1.1.0)

Per `hexa.toml [crosslink].chip` (updated to disambiguate silicon material vs silicon device):

```toml
chip = "dancinlab/hexa-chip (semiconductor device + fab process — call
       `hexa-chip materials` for the device/lithography/EUV-resist stack;
       silicon AS MATERIAL lives here under silicon/)"
```

The boundary is now explicit:
- `hexa-matter/silicon/` ← material layer (purity, dimensions, vendor tonnage, SiO₂/SiC cross-links)
- `hexa-chip materials` ← device + fab process (lithography, transistor, EUV)

---

## Honest C3 — what didn't change

- **(b) parity gates** — none of the 29 (b) parity gates queued in `CLOSURE_RESIDUAL_BACKLOG.md §B` are closed in v1.1.0. They are queued for Phase B/F.
- **(c) wet-lab / fab** — none of the 15 (c) items are closed; they cannot be closed in software by definition.
- **No new code shipped** — Phase A is infrastructure docs only. No new `_python_bridge/module/` scripts, no new selftest gates, no MatWeb research bridge.
- **CLI dispatcher unchanged in shape** — `cli/hexa-matter.hexa` adds `silicon` as a dispatch row, but does not become a wired numerical implementation. SPEC_FIRST verdict preserved.

---

## Known gaps at v1.1.0 (queued for v1.2.x / v2.x)

1. **Phase B not started** — per-verb selftest gates (B-CER-1..B-FAS-2 parity tests) deferred.
2. **Phase C not started** — per-group depth dirs (superalloy/, 2d-materials/, etc.) deferred.
3. **Phase D not started** — 12+ new verbs (compound-semi, perovskite, 2d-materials, elastomer, etc.) deferred.
4. **Python bridge (Phase E) not started** — `_python_bridge/module/` empty.
5. **Research bridge (Phase F) not started** — no MatWeb / NIST SRD / ASTM / SEMI live database integration.
6. **AlphaFold-class absorption (Phase G) not started** — long horizon.

See `V1_2_0_HANDOFF.md` for the Phase B-G roadmap summary.

---

## Acknowledgments

- canon authors at `canon@47c70cbf` for the 16-verb materials catalog (v1.0.0 base)
- hexa-bio team for the AXIS / AXIS_CLOSURE_PLAN / CLOSURE_RESIDUAL_BACKLOG / DECOMPOSITION_PLAN / LESSONS pattern (cycle-30, 2026-05-12)
- Wave K LATTICE_POLICY (dancinlab-wide, 2026-05-12) for the n=6-as-tool discipline
- Wave M LIMIT_BREAKTHROUGH audit for surfacing the silicon gap

---

*Release notes authored 2026-05-13 by 박민우 <nerve011235@gmail.com>.*
