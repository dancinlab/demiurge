<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_POL closure status -->

# polymer-closure-status — (a)/(b)/(c) per-verb ledger

> Mirror of `AXIS_CLOSURE_PLAN.md §4` at group depth.

## §1 Per-verb closure table (9 dispatchable POL verbs + 2 cross-link)

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| aramid | 100% | Kevlar 49 σ 3.6 GPa / E 124 GPa / ρ 1.44 g/cm³ vs ASM vol. 21 parity (B-POL-1) | DuPont para-aramid synthesis (proprietary) |
| epoxy | 100% | DGEBA/DETA cure-cycle T_g range parity vs Hexcel/Henkel datasheet | aerospace prepreg pilot |
| nylon | 100% | nylon-6,6 T_g 323 K / T_m 538 K / σ 0.6-0.8 GPa parity vs CRC (B-POL-4) | DuPont Zytel / BASF Ultramid batch trace |
| pet_film | 100% | PET T_g 343 K / T_m 533 K / haze-vs-thickness parity vs Toray/DuPont (B-POL-5) | MRI-grade PET film yield audit |
| tire_cord | 100% | nylon-66 / PET / aramid composite parity vs vendor | tire manufacturer batch trace |
| microplastics | 100% | partition coefficient K_d, biofilm colonization rate parity vs EPA/NOAA (B-POL-3) | open-ocean field mass-balance (5 gyres data) |
| elastomer (Phase D) | 100% | NR cis-1,4 polyisoprene 99%+ vs Goodyear; SBR 23% styrene CRC; EPDM ENB ~4-9% | bio-isoprene production **UNVERIFIED**; self-healing rubber production **UNVERIFIED** |
| adhesive (Phase D) | 100% | PSA peel strength ASTM D903; structural lap-shear ASTM D1002 | bio-based + self-healing + gecko-inspired aerospace **UNVERIFIED** |
| biodegradable-plastics (Phase D) | 100% | PLA T_g 333-358 K / T_m 423-453 K vs NatureWorks Ingeo (B-POL-6) | marine-biodegradability **UNVERIFIED most grades** (only certain PHA D7081); cost parity to PE **UNVERIFIED** |
| liquid-crystal (Phase D) | 100% | LCP Vectra T_g 383-393 K / T_m 553 K vs Sumitomo Zenite (B-POL-9) | polymer-stabilized blue-phase commercial display **UNVERIFIED** |
| mof (cross-link, primary CER) | 100% | HKUST-1 surface area 1500-2200 m²/g | MOF DAC $100/t **UNPROVEN** (Climeworks amine $600-1000/t) |

## §2 Group roll-up

| Category | Count | Status |
|----------|-------|--------|
| Dispatchable POL verbs (post Phase D) | 9 | aramid (FIB-hosted but POL chemistry), epoxy, nylon, pet_film, tire_cord, microplastics, elastomer, adhesive, biodegradable-plastics, liquid-crystal |
| (a) verb spec presence | 9/9 | 100% |
| (b) parity gates queued | 9+ (B-POL-1..B-POL-9) | UNVERIFIED — Phase B |
| (c) OUT-OF-REPO items | 7+ | DEST list enumerated |
| UNPROVEN / UNVERIFIED markers preserved | 4 (Phase D verbs) | verbatim, see §3 |

## §3 UNPROVEN / UNVERIFIED markers (verbatim)

| Verb | Marker | Source line in verb spec |
|------|--------|--------------------------|
| elastomer | "self-healing rubber + bio-isoprene UNVERIFIED at production" | elastomer/elastomer.md |
| adhesive | "bio-based + self-healing + gecko-inspired aerospace UNVERIFIED" | adhesive/adhesive.md |
| liquid-crystal | "polymer-stabilized blue-phase commercial display UNVERIFIED" | liquid-crystal/liquid-crystal.md |
| biodegradable-plastics | "marine-biodegradability UNVERIFIED most grades (only certain PHA D7081); cost parity to PE UNVERIFIED" | biodegradable-plastics/biodegradable-plastics.md |
| mof (cross-link) | "magic-MOF-DAC $100/t CO₂ UNPROVEN (Climeworks amine $600-1000/t)" | mof/mof.md |

## §4 v1.x / v1.1.x / v2 scope

| Scope | Items | Effort |
|-------|-------|--------|
| v1.x (a) | 9/9 POL verb specs | DONE 2026-05-13 (Phase D commit `99620b2`) |
| v1.1.x stretch (b) | ~9 parity gates | Phase B selftest |
| v2 stretch (b+G) | polymer thermal stability calc cross-validation (Phase G) | external compute bridges |
| v∞ (c) | vendor partnerships, field campaigns | external counterparty |

## §5 Selftest hook (Phase B)

When `selftest/polymer_thermal_stability.py` lands:
1. Parse each POL verb spec for stated T_g / T_m / decomposition temperature.
2. Cross-check against `polymer-data-anchors.md §1` rows for the CRC/ASM/ISO source.
3. Verify UNVERIFIED stamps from §3 above appear in each Phase D verb spec.
4. Confirm no n=6 lattice arithmetic in T_g/T_m derivations.

Pass criterion: 9/9 verbs consistent; 4 Phase D UNVERIFIED stamps grep-verifiable.

---

*Phase C polymer closure ledger, authored 2026-05-13.*
