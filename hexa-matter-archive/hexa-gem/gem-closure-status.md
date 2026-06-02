<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_GEM closure status -->

# gem-closure-status — (a)/(b)/(c) per-verb ledger

> Mirror of `AXIS_CLOSURE_PLAN.md §7` at group depth.

## §1 Per-verb closure table

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| gemology | 100% | corundum RI 1.762-1.770 vs CRC/NIST (B-GEM-1); ruby Cr³⁺ 694.3 nm fluorescence (B-GEM-2); diamond Mohs 10 (B-GEM-3); diamond RI 2.417 + ρ 3.52 g/cm³ (B-GEM-4) | lab-grown diamond CVD/HPHT bench; GIA treatment audit; synthetic emerald (Chatham, Gilson) |

## §2 Group roll-up

| Category | Count | Status |
|----------|-------|--------|
| GEM verbs | 1 (gemology) | ✅ |
| Cross-link from CER | 2 (carbon diamond, ceramics Al₂O₃) | ✅ |
| (a) verb spec presence | 1/1 | 100% |
| (b) parity gates queued | 4 (B-GEM-1..B-GEM-4) | UNVERIFIED — Phase B |
| (c) OUT-OF-REPO items | 4 | DEST list enumerated |
| UNPROVEN / UNVERIFIED markers preserved | 1 (carbon cross-link) | verbatim |

## §3 UNPROVEN / UNVERIFIED markers (verbatim)

| Verb | Marker | Source line |
|------|--------|-------------|
| carbon (cross-link) | "bulk lonsdaleite + carbyne + diamond-semi UNVERIFIED" | carbon/carbon.md |

(Diamond gem properties themselves are well-characterized; UNVERIFIED applies
to the lonsdaleite/carbyne *bulk-synthesis* claims, not to the
characterization of crystalline diamond.)

## §4 v1.x / v1.1.x / v2 scope

| Scope | Items | Effort |
|-------|-------|--------|
| v1.x (a) | 1/1 GEM verb spec-present | DONE 2026-05-13 |
| v1.1.x stretch (b) | 4 parity gates | Phase B selftest |
| v2 stretch (b+G) | hyperspectral imaging cross-validation for treatment audit | Phase G external (GIA) |
| v∞ (c) | CVD/HPHT lab-grown diamond identification methodology | external (GIA, IGI, GCAL) |

## §5 Selftest hook (Phase B)

When `selftest/gemology_ri_audit.py` lands:
1. Parse `gemology/gemology.md` for diamond RI 2.417, corundum RI 1.762-1.770,
   ruby fluorescence λ_max 694.3 nm.
2. Cross-check against `gem-data-anchors.md §1` rows 2-3, 11.
3. Verify no n=6 lattice arithmetic in RI / Mohs hardness derivations.
4. Confirm carbon cross-link UNVERIFIED stamps appear in `carbon/carbon.md`
   for lonsdaleite / carbyne (cross-link to gem dir).

Pass criterion: 1/1 verb consistent; 1 cross-link UNVERIFIED stamp grep-verifiable.

---

*Phase C gem closure ledger, authored 2026-05-13. Single-verb group, narrow
scope but real-limit anchor (L4 Mohs 10) preserved.*
