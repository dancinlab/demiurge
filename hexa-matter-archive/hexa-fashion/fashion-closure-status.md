<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_FAS closure status -->

# fashion-closure-status — (a)/(b)/(c) per-verb ledger

> Mirror of `AXIS_CLOSURE_PLAN.md §9` at group depth.

## §1 Per-verb closure table

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| fashion-textile | 100% | textile supply chain audit (cotton, wool, silk yields) — none yet | global supply chain transparency (USDA / FAO; OEKO-TEX / GOTS / Bluesign certification) |
| textile-dyeing | 100% | reactive-dye covalent yield vs ISO 105 (B-FAS-1); K/S Kubelka-Munk for mordant dyeing (B-FAS-2) | wet-process dye-house pilot; natural-dye (indigo fermentation) cross-domain |

## §2 Group roll-up

| Category | Count | Status |
|----------|-------|--------|
| FAS verbs | 2 (fashion-textile, textile-dyeing) | ✅ |
| (a) verb spec presence | 2/2 | 100% |
| (b) parity gates closed | 2 (B-FAS-1, B-FAS-2) | ✅ CLOSED 2026-05-13 — Phase I.1 (`tests/fas_b1_reactive_dye_yield_parity.py`) + Phase I.2 (`tests/fas_b2_kubelka_munk_parity.py`) |
| (c) OUT-OF-REPO items | 4 | DEST list enumerated |
| UNPROVEN / UNVERIFIED markers preserved | (none Phase D added) | — |

## §3 UNPROVEN / UNVERIFIED markers

GROUP_FAS has no Phase D verbs; UNVERIFIED is mostly (c) supply-chain
trace + bacterial-indigo lab-scale items.

- Bacterial indigo fermentation (Genencor / Pivot Bio): UNVERIFIED at
  commercial scale (cross-substrate to `hexa-bio/`).
- Global cotton supply transparency (per USDA/FAO): UNVERIFIED end-to-end
  trace (per Higg MSI methodology gaps).
- Reactive-dye covalent yield at industrial scale (vs ISO 105): UNVERIFIED
  parity gate — ✅ CLOSED 2026-05-13 by Phase I.1 + I.2.

## §4 v1.x / v1.1.x / v2 scope

| Scope | Items | Effort |
|-------|-------|--------|
| v1.x (a) | 2/2 FAS verb specs | DONE pre-2026-05-13 |
| v1.1.x stretch (b) | 2 parity gates | Phase B selftest |
| v2 stretch (b+G) | OEKO-TEX / Higg MSI cross-validation integration | Phase G external |
| v∞ (c) | dye-house pilots, bio-indigo at scale | external |

## §5 Selftest hook (Phase B)

When `selftest/textile_dyeing_iso105_audit.py` lands:
1. Parse `textile-dyeing/textile-dyeing.md` for reactive-dye fastness claims.
2. Cross-check against `fashion-data-anchors.md §1` rows 1-8 for ISO 105 / AATCC.
3. Confirm no n=6 lattice arithmetic in K/S Kubelka-Munk formula or dye-uptake
   derivations.

## §6 AXIS.md §12 weakness note

Per `AXIS.md §12`, GROUP_FAS vs GROUP_FIB boundary is *squishy*. Phase C
does NOT resolve this — both groups exist as separate depth dirs. The
weakness is preserved honestly: FAS is wet-process / dye-uptake side; FIB
is dry-mechanical / fiber-assembly side; textile finishing (wet but
mechanical) leaks across.

A future Phase D2 candidate is pigment chemistry, mordant-dyeing detail,
natural-dye revival (indigo fermentation crossover) — but not in this
Phase C.

---

*Phase C fashion closure ledger, authored 2026-05-13. Thinnest group; the
weakness is honest, not hidden.*
