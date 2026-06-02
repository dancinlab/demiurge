<!-- @authored: 2026-05-13 -->
<!-- @phase: C — synthesis closure status -->

# synthesis-closure-status — (a)/(b)/(c) per-verb ledger

> Mirror of `AXIS_CLOSURE_PLAN.md §8` at group depth (synthesis subset).

## §1 Per-verb closure table

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| synthesis | 100% | sol-gel TEOS hydrolysis rate vs Hench & West 1990 (B-PRC-3) | hydrothermal synthesis pilot |
| printing | 100% (exposed via MATERIAL-SYNTHESIS.md; no dedicated CLI slot per AXIS.md §0) | FDM/SLS/SLA mechanical-property vs ASTM F42 (B-PRC-4); Hales packing 0.7405 simulation (B-PRC-1) | EOS / 3D Systems / Stratasys vendor pilot |

## §2 Group roll-up

| Category | Count | Status |
|----------|-------|--------|
| Synthesis verbs (forward subset of PRC) | 2 (synthesis, printing) | ✅ |
| (a) verb spec presence | 2/2 (printing via MATERIAL-SYNTHESIS.md) | 100% |
| (b) parity gates queued | 3 (B-PRC-1, B-PRC-3, B-PRC-4) | UNVERIFIED — Phase B |
| (c) OUT-OF-REPO items | 4 | DEST list enumerated |
| UNPROVEN / UNVERIFIED markers preserved | (cross-link to D verbs) | verbatim |

## §3 UNPROVEN / UNVERIFIED markers (cross-link from D verbs touching synthesis)

| Cross-link verb | Marker | Source line |
|-----------------|--------|-------------|
| compound-semi | "6/8" bulk GaN ammonothermal UNVERIFIED at production; diamond-as-semi wafer UNPROVEN" | compound-semi/compound-semi.md |
| perovskite | "LK-99 NOT REPRODUCED (HARD_WALL); large-area + 25-yr-lifetime UNVERIFIED" | perovskite/perovskite.md |
| 2d-materials | "wafer-scale 2D mobility 10-100× loss vs lab; phosphorene ambient + 2D-magnet T_c > 300 K UNVERIFIED" | 2d-materials/2d-materials.md |
| biodegradable-plastics | "marine-biodegradability UNVERIFIED most grades; cost parity to PE UNVERIFIED" | biodegradable-plastics/biodegradable-plastics.md |
| mof | "magic-MOF-DAC $100/t CO₂ UNPROVEN (Climeworks amine $600-1000/t)" | mof/mof.md |
| superalloy | "Re-free 4th-gen SX at parity UNVERIFIED; Co-base SX commercial UNVERIFIED" | superalloy/superalloy.md |
| magnetic-materials | "rare-earth-free > 35 MGOe UNVERIFIED; tetrataenite/MnBi/Fe₁₆N₂ R&D only" | magnetic-materials/magnetic-materials.md |
| wood-cellulose | "50+ story mass-timber UNVERIFIED; transparent/densified wood UNVERIFIED at cost" | wood-cellulose/wood-cellulose.md |
| carbon | "CNT yarn 80 GPa = lab mm-scale (commercial 1-3 GPa); bulk lonsdaleite + carbyne + diamond-semi UNVERIFIED" | carbon/carbon.md |
| elastomer | "self-healing rubber + bio-isoprene UNVERIFIED at production" | elastomer/elastomer.md |
| adhesive | "bio-based + self-healing + gecko-inspired aerospace UNVERIFIED" | adhesive/adhesive.md |
| liquid-crystal | "polymer-stabilized blue-phase commercial display UNVERIFIED" | liquid-crystal/liquid-crystal.md |

These are not synthesis-verb UNVERIFIED stamps directly — they are
SYNTHESIS-ROUTE UNVERIFIED items that the corresponding Phase D verbs carry.
The synthesis verb itself simply documents the route taxonomy.

## §4 v1.x / v1.1.x / v2 scope

| Scope | Items | Effort |
|-------|-------|--------|
| v1.x (a) | 2/2 synthesis verbs (synthesis + printing via deep-dive) | DONE pre-2026-05-13 |
| v1.1.x stretch (b) | 3 parity gates | Phase B selftest |
| v2 stretch (b+G) | NREL perovskite PCE chart, Materials Project sintering data integration | Phase G external |
| v∞ (c) | AM machine pilot, hydrothermal synthesis pilot | external (EOS, vendor research) |

## §5 Selftest hook (Phase B)

When `selftest/synthesis_route_audit.py` lands:
1. Parse `synthesis/synthesis.md` (or `MATERIAL-SYNTHESIS.md`) for route taxonomy.
2. Cross-check that each Phase D verb's synthesis route is documented.
3. For powder-bed printing, verify L11 Hales 0.7405 is referenced as HARD wall.

When `selftest/hales_packing_regression.py` lands (Phase B):
1. Numerical FCC/HCP packing fraction → 0.7405 ± 1e-6.
2. Random close packing → 0.64.
3. Random loose packing → 0.55.
4. Confirm these are NOT lattice-arithmetic-derived.

Pass criterion: 2/2 verbs consistent; aux discipline preserved.

## §6 The printing slot decision

Per `AXIS.md §0`: "printing exposed via MATERIAL-SYNTHESIS.md; no
dispatcher slot yet". This means:
- printing has a verb directory (`printing/printing.md` exists)
- printing has root deep-dive (`MATERIAL-SYNTHESIS.md` covers it)
- printing is NOT in `hexa.toml [verbs]` CLI dispatch (so `hexa-matter status`
  shows 29 verbs not 30)
- printing IS in this depth-dir for architectural completeness

This is intentional — Phase D had room to add 12 verbs and chose 12
material-class verbs over a process-class printing dispatcher slot.
Phase D2 or beyond could elevate printing.

---

*Phase C synthesis closure ledger, authored 2026-05-13.*
