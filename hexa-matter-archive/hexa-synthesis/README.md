<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @phase: C — axis-prefixed depth directory for PRC (synthesis subset) -->
---
depth_dir: hexa-synthesis
axis_group: GROUP_PRC (synthesis subset)
verb_members:
  - synthesis
  - printing
cross_link_members:
  - silicon (CZ, FZ, Siemens — Si-as-substrate synthesis)
  - ceramics (sol-gel, sintering, CVD)
  - metallurgy (casting, forging, PM)
  - polymer (step-growth + chain-growth)
status: SPEC_FIRST · category-(a) 100% · (b) UNVERIFIED · (c) OUT-OF-REPO
---

# hexa-synthesis — GROUP_PRC (synthesis subset) depth directory

> **Aggregates the forward-process synthesis verbs.** `synthesis/` is the
> general-purpose synthesis verb (the most-line-count root .md in the
> repo: `MATERIAL-SYNTHESIS.md` ~1083 lines of text). `printing/` covers
> additive manufacturing (FDM, SLS, SLA, DLP, MJF, binder-jet).

> **Honesty.** Hales packing 0.7405 (Kepler conjecture, FCC/HCP) is the
> HARD wall on powder-bed printing density and casting yield (L11 in
> `LIMIT_BREAKTHROUGH.md`). Per `AXIS.md §0`, printing is exposed via
> `MATERIAL-SYNTHESIS.md` but has no dedicated CLI dispatcher slot in
> `hexa.toml [verbs]` — it's a sub-process within synthesis.

---

## §1 Scope

GROUP_PRC splits across this dir (`hexa-synthesis/`) and `hexa-recycle/`.
Synthesis covers forward/build; recycle covers reverse/un-build.

| Layer | Verbs | Direction |
|-------|-------|-----------|
| Synthesis | synthesis, printing | forward (build) |
| Recycle (separate dir) | recycling, recycle_n6 | reverse (un-build) |

## §2 Member verbs

- **synthesis** → [`../synthesis/synthesis.md`](../synthesis/synthesis.md) — high-T solid-state, hydrothermal, sol-gel, CVD, melt processing, polymerization
- **printing** → [`../printing/printing.md`](../printing/printing.md) — FDM, SLS, SLA, DLP, MJF, binder-jet, DED (Directed Energy Deposition)

Cross-linked (synthesis routes specific to other groups):
- **silicon** — Siemens TCS distillation, FBR, CZ ingot pull, FZ refining, CVD epitaxy → see [`../hexa-silicon/`](../hexa-silicon/)
- **ceramics** — sintering (high-T solid-state), sol-gel, CVD, hot-pressing → see [`../hexa-ceramic/`](../hexa-ceramic/)
- **glass** — sol-gel (TEOS hydrolysis), float-process, blow-mold → see [`../hexa-ceramic/`](../hexa-ceramic/)
- **metallurgy** — casting, forging, rolling, drawing, PM, AM → see [`../hexa-metal/`](../hexa-metal/)
- **polymer** — step-growth (PA, PET, PU), chain-growth (PE, PP, PS, PVC) → see [`../hexa-polymer/`](../hexa-polymer/)
- **perovskite** — solution-process, vacuum deposition (halide PV); sol-gel (oxide perovskite) → see [`../perovskite/`](../perovskite/)
- **2d-materials** — mechanical exfoliation, CVD, MBE → see [`../2d-materials/`](../2d-materials/)
- **mof** — solvothermal synthesis → see [`../mof/`](../mof/)

## §3 Cross-links to root deep-expansion docs

- [`../MATERIAL-SYNTHESIS.md`](../MATERIAL-SYNTHESIS.md) — largest deep-dive root .md in the repo (~1083 lines region)
- [`../SILICON.md`](../SILICON.md) — Si synthesis routes (Siemens, CZ, FZ)
- [`../CERAMIC-ENGINEERING.md`](../CERAMIC-ENGINEERING.md) — sintering, CVD, sol-gel (299 lines)
- [`../METALLURGY-DEEP.md`](../METALLURGY-DEEP.md) — metal processing (308 lines)
- [`../POLYMER-CHEMISTRY.md`](../POLYMER-CHEMISTRY.md) — polymerization (439 lines)
- [`../LIMIT_BREAKTHROUGH.md`](../LIMIT_BREAKTHROUGH.md) — L11 Hales packing 0.7405 (HARD)

## §4 Group-level closure status

| Category | Status | Notes |
|----------|--------|-------|
| (a) | **100%** — synthesis verb spec-present; printing exposed via MATERIAL-SYNTHESIS.md | per AXIS_CLOSURE_PLAN.md §8 |
| (b) | **UNVERIFIED** — 2 parity gates queued (B-PRC-1, B-PRC-2) | Phase B |
| (c) | **OUT-OF-REPO** — hydrothermal synthesis pilot; powder-bed printing pilot | vendor (EOS / 3D Systems / Stratasys) |

## §5 UNPROVEN / UNVERIFIED markers

(Synthesis verbs are SPEC_FIRST. UNVERIFIED items are mostly (c) vendor-pilot.)

- printing — FDM/SLS/SLA mechanical-property vs ASTM F42 UNVERIFIED dataset parity
- synthesis — sol-gel TEOS hydrolysis kinetics vs Hench & West 1990 UNVERIFIED parity (Phase B target)
- Cross-link: 6/8" bulk GaN ammonothermal UNVERIFIED at production (compound-semi)
- Cross-link: silicene CVD on Ag(111) ambient-stability UNVERIFIED beyond substrate (2d-materials)
- Cross-link: marine-biodegradable plastic synthesis UNVERIFIED most grades (biodegradable-plastics)

## §6 The L11 Hales packing floor (HARD wall)

Per `LIMIT_BREAKTHROUGH.md` L11 (Hales 2017 Kepler conjecture proof):

```
FCC / HCP packing density = π / (3√2) ≈ 0.74048
                          → 74.0480489693...%
```

This is the densest possible packing of equal-radius spheres in 3D
(formally proven by Hales 2017 after Hilbert 18th-problem listing
in 1900). It is the HARD wall on:
- Powder-bed printing density (SLS, SLM, MJF, binder-jet)
- Random close packing (~0.64 for monodisperse spheres; below Hales)
- Random loose packing (~0.55)
- Investment casting yield (powder mold)
- Particle-filled composite (max filler fraction in monodisperse)

L11 is a HARD wall because it's a mathematical theorem on Euclidean space.
NO process can exceed it for equal-radius spheres. Bimodal/multimodal
size distributions can approach 0.85-0.90 but each component class is
still ≤ 0.7405.

## §7 Cross-group interface points

| Boundary | Interface | Reference |
|----------|-----------|-----------|
| PRC-synthesis ↔ CER | sintering, CVD, sol-gel, hydrothermal | hexa-ceramic/, hexa-silicon/ |
| PRC-synthesis ↔ POL | step-growth + chain-growth polymerization | hexa-polymer/ |
| PRC-synthesis ↔ MET | casting, forging, PM, AM | hexa-metal/ |
| PRC-synthesis ↔ FIB | spinning (melt, solution, wet, electrospin); papermaking; pulping | hexa-fiber/ |
| PRC-synthesis ↔ GEM | hydrothermal, Verneuil, HPHT, CVD synthetic gems | hexa-gem/ |
| PRC-synthesis ↔ PRC-recycle | forward-vs-reverse asymmetry; L12 ΔS_mix floor on recycle | hexa-recycle/ |

## §8 Files in this depth dir

- `README.md` (this file)
- [`synthesis-architecture.md`](synthesis-architecture.md) — route taxonomy (high-T, sol-gel, CVD, hydrothermal, melt, polymerization, AM)
- [`synthesis-data-anchors.md`](synthesis-data-anchors.md) — NIST/ASTM/vendor anchor table
- [`synthesis-closure-status.md`](synthesis-closure-status.md) — (a)/(b)/(c) per-verb ledger

---

*Phase C depth-dir, authored 2026-05-13. The forward-process counterpart
to `hexa-recycle/`.*
