<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @phase: C — axis-prefixed depth directory for PRC (recycle subset) -->
---
depth_dir: hexa-recycle
axis_group: GROUP_PRC (recycle subset)
verb_members:
  - recycling
  - recycle_n6
cross_link_members:
  - microplastics (POL; recycling escape route)
  - biodegradable-plastics (POL; alt to recycle)
  - metallurgy (alloy entropy separation)
  - synthesis (forward process; reverse of recycle)
status: SPEC_FIRST · category-(a) 100% · (b) UNVERIFIED · (c) OUT-OF-REPO
---

# hexa-recycle — GROUP_PRC (recycle subset) depth directory

> **Aggregates the reverse-process / recycle verbs.** `recycling/` is the
> general-purpose recycle verb; `recycle_n6/` is the n=6 lattice arithmetic
> aux verb (auxiliary self-consistency only, per `LATTICE_POLICY §1.3`).

> **Honesty.** The Gibbs ΔS_mix entropy floor (L12 in `LIMIT_BREAKTHROUGH.md`)
> is a HARD wall on separation energy. **Infinite recycle is UNPROVEN** —
> mixed-PE/PP cannot be cleanly separated without breaking back to monomer.
> Chemical recycling (depolymerization) is the route, but at energy cost
> above the Gibbs floor.

---

## §1 Scope

GROUP_PRC splits across this dir (`hexa-recycle/`) and `hexa-synthesis/`.
Recycle covers reverse/un-build; synthesis covers forward/build.

| Layer | Verbs | Direction |
|-------|-------|-----------|
| Recycle | recycling, recycle_n6 | reverse (un-build) |
| Synthesis (separate dir) | synthesis, printing | forward (build) |

## §2 Member verbs

- **recycling** → [`../recycling/recycling.md`](../recycling/recycling.md) — mechanical, chemical, dissolution recycling of polymers, metals, glass
- **recycle_n6** → [`../recycle_n6/recycle_n6.md`](../recycle_n6/recycle_n6.md) — n=6 lattice arithmetic auxiliary verb (in-software only)

Cross-linked:
- **microplastics** (POL) → [`../microplastics/microplastics.md`](../microplastics/microplastics.md) — environmental fate when recycling fails
- **biodegradable-plastics** (POL Phase D) — alternative end-of-life route to recycling
- **metallurgy** (MET) — alloy recycling (steel scrap, Cu scrap, Al scrap)
- **synthesis** (PRC forward) — see `hexa-synthesis/`

## §3 Cross-links to root deep-expansion docs

- [`../RECYCLING.md`](../RECYCLING.md) — recycling root stub
- [`../HEXA-RECYCLE.md`](../HEXA-RECYCLE.md) — recycle root stub (n=6 aux)
- [`../LIMIT_BREAKTHROUGH.md`](../LIMIT_BREAKTHROUGH.md) — L12 ΔS_mix entropy floor (HARD wall)
- [`../POLYMER-CHEMISTRY.md`](../POLYMER-CHEMISTRY.md) — chemical recycling routes (root, 439 lines)
- [`../MATERIAL-SYNTHESIS.md`](../MATERIAL-SYNTHESIS.md) — forward-side cross-link (largest deep-dive)

## §4 Group-level closure status

| Category | Status | Notes |
|----------|--------|-------|
| (a) | **100%** — 2/2 recycle verbs spec-present | per AXIS_CLOSURE_PLAN.md §8 |
| (b) | **UNVERIFIED** — 1 parity gate queued (B-PRC-2) | Phase B |
| (c) | **OUT-OF-REPO** — polymer chemical-recycling pilot; alloy entropy-separation pilot | vendor (Eastman / Loop Industries) |

## §5 UNPROVEN / UNVERIFIED markers (verbatim)

- **recycle_n6** — "n=6 lattice arithmetic (aux); in-software only" per AXIS_CLOSURE_PLAN.md §8.1 — does NOT predict any recycling efficiency.
- **biodegradable-plastics** (cross-link) — marine-biodegradability UNVERIFIED most grades; cost parity to PE UNVERIFIED
- Infinite-recycle / cradle-to-cradle: UNPROVEN given L12 entropy floor

## §6 The L12 entropy floor (HARD wall)

Per `LIMIT_BREAKTHROUGH.md` L12:

```
ΔS_mix = -R Σ x_i ln(x_i)
       per mole of binary mix
       = +R ln 2 ≈ 5.76 J/(mol·K) per mole at x=0.5

T·ΔS_mix at 300 K ≈ 1.73 kJ/mol entropy contribution
                    against separation
```

For polymer recycling: mixed-PE/PP at 50/50 has ΔS_mix ≈ 5.76 J/(mol·K) of
disorder; separating them requires reversing this entropy gain. Mechanical
sorting (NIR spectroscopy, density flotation, FTIR-based) can separate
discrete bottles but cannot separate molecularly mixed grade. Chemical
recycling (depolymerization to monomer) bypasses L12 by breaking the
polymer back to monomer (where entropy bookkeeping resets).

## §7 Cross-group interface points

| Boundary | Interface | Reference |
|----------|-----------|-----------|
| PRC ↔ POL | polymer chemical recycling; depolymerization | hexa-polymer/ |
| PRC ↔ MET | alloy scrap recycling (steel, Cu, Al, Au) | hexa-metal/ |
| PRC ↔ CER | glass recycling (cullet); ceramic recycling (difficult) | hexa-ceramic/ |
| PRC ↔ bio | biodegradation as alt route; composting | hexa-bio/ |
| PRC ↔ environmental | microplastics fate when recycle fails | microplastics.md |

## §8 Files in this depth dir

- `README.md` (this file)
- [`recycle-architecture.md`](recycle-architecture.md) — mechanical vs chemical vs dissolution; Gibbs ΔS_mix floor
- [`recycle-data-anchors.md`](recycle-data-anchors.md) — ISO 14040 / vendor anchor table
- [`recycle-closure-status.md`](recycle-closure-status.md) — (a)/(b)/(c) per-verb ledger

---

*Phase C depth-dir, authored 2026-05-13.*
