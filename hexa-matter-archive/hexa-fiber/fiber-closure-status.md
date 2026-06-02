<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_FIB closure status -->

# fiber-closure-status — (a)/(b)/(c) per-verb ledger

> Mirror of `AXIS_CLOSURE_PLAN.md §5` at group depth.

## §1 Per-verb closure table

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| fabric | 100% | woven-fabric thread count vs density parity (ISO 7211); breaking strength D5034 | textile-mill supply chain (cotton, wool, silk yields per USDA/FAO) |
| paper | 100% | cellulose-crystallinity XRD Segal parity vs TAPPI T 271 (B-FIB-1); tensile T 494 (B-FIB-2) | pulp-mill (chemical pulping pilot) — Stora Enso / IP |
| wood-cellulose (Phase D) | 100% | CNF/CNC mechanical parity; engineered wood specs vs Stora Enso/Binderholz datasheets | 50+ story mass-timber **UNVERIFIED**; transparent/densified wood **UNVERIFIED at cost** |
| aramid (cross-link from POL) | 100% | Kevlar 49 σ 3.6 GPa / E 124 GPa / ρ 1.44 g/cm³ vs ASM vol. 21 (B-FIB-3) | DuPont para-aramid synthesis (proprietary) |
| carbon (cross-link from CER, fiber form-factor) | 100% | T700/T1100 carbon fiber σ/E vs Toray datasheets | CNT yarn 80 GPa = lab mm-scale (commercial 1-3 GPa) **UNVERIFIED**; lonsdaleite bulk **UNVERIFIED** |

## §2 Group roll-up

| Category | Count | Status |
|----------|-------|--------|
| Dispatchable FIB verbs | 3 (fabric, paper, wood-cellulose) | ✅ |
| Cross-link verbs (POL/CER fiber form) | 2+ (aramid, carbon) | ✅ |
| (a) verb spec presence | 3/3 + 2 cross-link | 100% |
| (b) parity gates queued | 4 (B-FIB-1..B-FIB-4) | UNVERIFIED — Phase B |
| (c) OUT-OF-REPO items | 5 | DEST list enumerated |
| UNPROVEN / UNVERIFIED markers preserved | 3 | verbatim, see §3 |

## §3 UNPROVEN / UNVERIFIED markers (verbatim)

| Verb | Marker | Source line in verb spec |
|------|--------|--------------------------|
| wood-cellulose | "50+ story mass-timber UNVERIFIED; transparent/densified wood UNVERIFIED at cost" | wood-cellulose/wood-cellulose.md |
| carbon (cross-link) | "CNT yarn 80 GPa = lab mm-scale (commercial 1-3 GPa); bulk lonsdaleite + carbyne + diamond-semi UNVERIFIED" | carbon/carbon.md |
| aramid (cross-link) | "DuPont para-aramid synthesis (proprietary)" — (c)-out-of-repo by IP | AXIS_CLOSURE_PLAN.md §4 |

## §4 v1.x / v1.1.x / v2 scope

| Scope | Items | Effort |
|-------|-------|--------|
| v1.x (a) | 3/3 dispatchable FIB verbs spec-present | DONE 2026-05-13 (wood-cellulose Phase D commit `99620b2`) |
| v1.1.x stretch (b) | 4 parity gates | Phase B selftest |
| v2 stretch (b+G) | natural-fiber harvest-yield database integration | external (USDA, FAO) |
| v∞ (c) | mass-timber 50-story | external — no commercial precedent yet |

## §5 Selftest hook (Phase B)

When `selftest/cellulose_crystallinity_audit.py` lands:
1. Parse `paper/paper.md` for cellulose crystallinity Segal-index claim.
2. Cross-check against `fiber-data-anchors.md §1 row 10` (TAPPI T 271).
3. Confirm `wood-cellulose/wood-cellulose.md` UNVERIFIED stamps present.
4. Verify no n=6 lattice arithmetic in fiber σ_tens derivations.

---

*Phase C fiber closure ledger, authored 2026-05-13.*
