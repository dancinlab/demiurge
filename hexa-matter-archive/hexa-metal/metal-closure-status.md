<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_MET closure status -->

# metal-closure-status — (a)/(b)/(c) per-verb ledger

> Mirror of `AXIS_CLOSURE_PLAN.md §6` at group depth.

## §1 Per-verb closure table

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| metallurgy | 100% | Inconel 718 creep @ 650 °C vs ASM vol. 1 (B-MET-1); Ti-6Al-4V α-β transition 1268 K vs ASM vol. 2 (B-MET-2); TTT for AISI 1080 (B-MET-3) | single-crystal turbine blade casting pilot |
| superalloy (Phase D) | 100% | CMSX-10 creep / γ' volume fraction parity vs Cannon-Muskegon datasheet | Re-free 4th-gen SX at parity **UNVERIFIED**; Co-base SX commercial **UNVERIFIED** |
| magnetic-materials (Phase D) | 100% | NdFeB N52 (BH)_max 50-52 MGOe vs Hitachi (B-MET-4); Metglas B_sat (B-MET-5) | rare-earth-free > 35 MGOe **UNVERIFIED**; tetrataenite/MnBi/Fe₁₆N₂ R&D only |
| lutherie (cross-link, culture) | 100% | bell-bronze (78Cu/22Sn) acoustic-resonance frequency vs measured | luthier-studio craft pilot |

## §2 Group roll-up

| Category | Count | Status |
|----------|-------|--------|
| Dispatchable MET verbs (post-Phase D) | 3 (metallurgy, superalloy, magnetic-materials) | ✅ |
| Cross-link (culture) | 1 (lutherie) | ✅ |
| (a) verb spec presence | 3/3 + lutherie | 100% |
| (b) parity gates queued | 5 (B-MET-1..B-MET-5) | UNVERIFIED — Phase B |
| (c) OUT-OF-REPO items | 5 | DEST list enumerated |
| UNPROVEN / UNVERIFIED markers preserved | 2 (Phase D) | verbatim, see §3 |

## §3 UNPROVEN / UNVERIFIED markers (verbatim)

| Verb | Marker | Source line in verb spec |
|------|--------|--------------------------|
| superalloy | "Re-free 4th-gen SX at parity UNVERIFIED; Co-base SX commercial UNVERIFIED" | superalloy/superalloy.md |
| magnetic-materials | "rare-earth-free > 35 MGOe UNVERIFIED; tetrataenite / MnBi / Fe₁₆N₂ R&D only" | magnetic-materials/magnetic-materials.md |

## §4 v1.x / v1.1.x / v2 scope

| Scope | Items | Effort |
|-------|-------|--------|
| v1.x (a) | 3/3 dispatchable MET verbs spec-present | DONE 2026-05-13 (Phase D commit `99620b2`) |
| v1.1.x stretch (b) | 5 parity gates | Phase B selftest |
| v2 stretch (b+G) | superalloy thermal-creep cross-validation (MatBench) | Phase G external compute bridges |
| v∞ (c) | turbine blade casting, NdFeB supply chain | external counterparty (Howmet/PCC, MP Materials) |

## §5 Selftest hook (Phase B)

When `selftest/metallurgy_alloy_classification.py` lands:
1. Parse `metallurgy/metallurgy.md` for Fe-Fe₃C T_α↔γ, Ti α-β transition,
   austenite-martensite TTT.
2. Cross-check against `metal-data-anchors.md §1` rows for ASM/CRC source.
3. For `superalloy/superalloy.md`, confirm Re-free UNVERIFIED stamp present.
4. For `magnetic-materials/magnetic-materials.md`, confirm rare-earth-free
   UNVERIFIED stamp present.
5. Confirm no n=6 lattice arithmetic in T_m / T_α↔γ / (BH)_max derivations.

Pass criterion: 3/3 verbs consistent; 2 Phase D UNVERIFIED stamps grep-verifiable.

---

*Phase C metal closure ledger, authored 2026-05-13.*
