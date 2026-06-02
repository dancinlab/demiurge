<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_CER closure status -->

# ceramic-closure-status — (a)/(b)/(c) per-verb ledger

> Mirror of `AXIS_CLOSURE_PLAN.md §3` at group depth. (a) is in-repo software
> closure (counts to v1.x grade). (b) is NIST/CRC parity — **✅ CLOSED 2026-05-13** by Phase H + I.1 + I.2 parity gates (`tests/cer_b*_parity.py`).
> (c) is wet-lab / vendor / fab (OUT-OF-REPO by design).

## §1 Per-verb closure table (10 verbs spanning GROUP_CER)

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| ceramics | 100% | Vickers/Knoop hardness map (Si₃N₄ 600-1200 MPa flexural) parity vs ASM vol. 21 measured | ceramic-armor production (Coorstek, CeramTec, Kyocera); Wolfspeed SiC wafer volumes |
| concrete | 100% | UHPC compressive 200-800 MPa parity vs Ductal/Cor-Tuf | UHPC pilot-pour cost/m³ benchmarking |
| concrete_tech | 100% | Curing thermal model parity vs ACI 318 measured | accelerated-curing kiln pilot |
| glass | 100% | Heraeus/Corning fused silica T_g 1473 K parity vs L7 | high-purity quartz mining (Spruce Pine NC dominance) |
| silicon | 100% | Si-L1..Si-L12 vs SEMI M1 / ASTM F121/F1188/F47 measured parity | Wacker batch lot purity audit, Wolfspeed SiC fab, isotope Si-28 |
| compound-semi (Phase D) | 100% | 4H-SiC bandgap 3.26 eV vs Saddow & Agarwal; GaN bandgap 3.4 eV vs literature | 6/8" bulk GaN ammonothermal **UNVERIFIED at production**; diamond-as-semi **UNPROVEN** |
| perovskite (Phase D) | 100% | PV PCE > 26% vs NREL chart parity; oxide perovskite T_c parity | LK-99 **NOT REPRODUCED** (HARD_WALL); large-area + 25-yr lifetime UNVERIFIED |
| 2d-materials (Phase D) | 100% | MoS₂ mobility lab parity; hBN gap 5.9 eV parity | wafer-scale mobility 10-100× lab loss UNVERIFIED; phosphorene ambient UNVERIFIED; 2D-magnet T_c > 300 K UNVERIFIED |
| mof (Phase D) | 100% | HKUST-1 surface area 1500-2200 m²/g parity; UiO-66 thermal stability parity | magic-MOF-DAC $100/t CO₂ **UNPROVEN** (Climeworks amine $600-1000/t) |
| carbon (Phase D) | 100% | diamond Mohs 10 vs L4; CNT E ~1 TPa parity | CNT yarn 80 GPa = lab mm-scale (commercial 1-3 GPa); lonsdaleite + carbyne + diamond-semi **UNVERIFIED** |

## §2 Group roll-up

| Category | Count | Status |
|----------|-------|--------|
| Verbs in GROUP_CER (post-Phase D) | 10 | ✅ all spec-present |
| (a) verb spec presence | 10/10 | 100% |
| (b) parity gates closed | 9 (B-CER-1..B-CER-9) | ✅ CLOSED 2026-05-13 — Phase H + I.1 + I.2 (`tests/cer_b*_parity.py`) |
| (c) OUT-OF-REPO items | 9+ | DEST list enumerated |
| UNPROVEN / UNVERIFIED markers preserved | 9 | verbatim, see §3 |

## §3 UNPROVEN / UNVERIFIED markers (verbatim)

| Verb | Marker | Source line in verb spec |
|------|--------|--------------------------|
| compound-semi | "6/8" bulk GaN ammonothermal UNVERIFIED at production; diamond-as-semi wafer UNPROVEN" | compound-semi.md |
| perovskite | "LK-99 NOT REPRODUCED (HARD_WALL); large-area + 25-yr lifetime UNVERIFIED" | perovskite.md |
| 2d-materials | "wafer-scale 2D mobility 10-100× loss vs lab; phosphorene ambient + 2D-magnet T_c > 300 K UNVERIFIED" | 2d-materials.md |
| mof | "magic-MOF-DAC $100/t CO₂ UNPROVEN (Climeworks amine $600-1000/t)" | mof.md |
| carbon | "CNT yarn 80 GPa = lab mm-scale (commercial 1-3 GPa); bulk lonsdaleite + carbyne + diamond-semi UNVERIFIED" | carbon.md |
| silicon | "Wacker batch 9N lot trace UNVERIFIED; isotope-separated Si-28 commercial scale UNVERIFIED" | silicon.md |
| ceramics | "ceramic-armor production scale (c)-out-of-repo" | ceramics.md |
| glass | "high-purity quartz mining (Spruce Pine NC dominance) — vendor concentration risk" | glass.md / GROUP_CER roll-up |
| concrete_tech | "UHPC pilot-pour cost/m³ benchmarking (c)-out-of-repo" | concrete_tech.md / AXIS_CLOSURE_PLAN §3 |

## §4 v1.x / v1.1.x / v2 scope

| Scope | Items | Effort |
|-------|-------|--------|
| v1.x (a) | 10/10 verb specs | DONE 2026-05-13 (commit `99620b2` for Phase D, `a239611` for silicon) |
| v1.1.x stretch (b) | ~10 parity gates | Phase B selftest implementation (weeks) |
| v2 stretch (b+G) | Materials Project / GNoME / OMat24 cross-validation | Phase G external absorption |
| v∞ (c) | wet-lab synthesis, vendor partnerships, fab capacity | external counterparty (out-of-scope) |

## §5 Selftest hook (Phase B)

When `selftest/ceramic_thermal_shock.py` and `selftest/silicon_purity_audit.py`
land:
1. Parse each verb spec for stated CER limits.
2. Cross-check with `ceramic-data-anchors.md §1` row values.
3. Verify UNPROVEN/UNVERIFIED stamps in `§3` of this file appear verbatim in
   the spec files (regex grep on verb dir).
4. Verify no n=6 lattice arithmetic in any of the CER limit derivations.

Pass criterion: 10/10 verbs consistent, all 9 UNVERIFIED stamps grep-verifiable.

---

*Phase C ceramic closure ledger, authored 2026-05-13 by 박민우. (a) 100%
reached for GROUP_CER post-Phase D commit `99620b2`.*
