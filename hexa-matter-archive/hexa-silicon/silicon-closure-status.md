<!-- @authored: 2026-05-13 -->
<!-- @phase: C — silicon closure status -->

# silicon-closure-status — Si verb (a)/(b)/(c) ledger

> Per `AXIS_CLOSURE_PLAN.md §0`. Silicon is one verb but it touches three
> AXIS groups (CER, MET, PRC). This file is its standalone closure ledger
> at depth-dir granularity.

## §1 Closure categories

| Category | Definition | Counts toward v1.x closure-grade? |
|----------|------------|-----------------------------------|
| (a) | in-repo software/spec | YES |
| (b) | NIST/CRC/SEMI/ASTM measured parity | NO (Phase B/F target) |
| (c) | wet-lab synthesis / vendor / fab | NO (OUT-OF-REPO) |

## §2 Silicon verb — closure table

| Aspect | (a) status | (b) status | (c) status |
|--------|-----------|-----------|-----------|
| Verb spec presence | ✅ `silicon/silicon.md` (350 lines, gold template) | n/a | n/a |
| Limit enumeration Si-L1..Si-L12 | ✅ in `SILICON.md` + spec | UNVERIFIED — Phase B `B-CER-1..B-CER-5` queued | OUT-OF-REPO — vendor numbers only, no contracts |
| 9N purity ceiling (Si-L1) | ✅ stated | UNVERIFIED — SEMI M1 parity gate | OUT-OF-REPO — Wacker, GCL, Hemlock batch trace |
| CZ ~600 mm crucible (Si-L3) | ✅ stated | UNVERIFIED — Ferrotec/Heraeus crucible spec parity | OUT-OF-REPO — vendor (Ferrotec / Heraeus) |
| FZ ~200 mm rod (Si-L4) | ✅ stated | UNVERIFIED — Topsil/Siltronic FZ datasheet parity | OUT-OF-REPO — vendor (Topsil / Siltronic) |
| Si T_m 1687 K (Si-L5) | ✅ stated | UNVERIFIED — NIST WebBook parity gate | n/a (physical constant) |
| Si ρ 2.329 g/cm³ (Si-L6) | ✅ stated | UNVERIFIED — CRC 105th ed. parity (B-CER-2) | n/a |
| Si E_g 1.12 eV (Si-L7) | ✅ stated | UNVERIFIED — NIST/Sze parity (B-CER-3) | n/a |
| [O_i] CZ wafer (Si-L9) | ✅ stated | UNVERIFIED — ASTM F121 measurement parity | OUT-OF-REPO — wafer lot trace |
| 4H-SiC E_g 3.26 eV (Si-L11) | ✅ stated | UNVERIFIED — Saddow & Agarwal parity (B-CER-4) | OUT-OF-REPO — Wolfspeed wafer |
| Si₃N₄ flexural 600-1200 MPa (Si-L12) | ✅ stated | UNVERIFIED — ASM vol. 21 parity (B-CER-5) | OUT-OF-REPO — Coorstek/Kyocera ceramic pilot |
| Silicene (2D allotrope) | ✅ stated in `2d-materials/2d-materials.md` | UNVERIFIED — peer-reviewed Ag(111) result parity | OUT-OF-REPO — no production silicene |
| Isotope-separated Si-28 | ✅ stated | UNVERIFIED — Avogadro Project data parity | OUT-OF-REPO — DEST: Int'l Avogadro / quantum-compute consortia |

## §3 Group-roll-up

| Group spanned | (a) % | (b) UNVERIFIED count | (c) OUT-OF-REPO count |
|---------------|-------|---------------------|-----------------------|
| CER (primary) | 100% | 5 gates (B-CER-1..B-CER-5) | 5 items (C-CER-1..C-CER-5) |
| MET (secondary, Si-as-alloy) | 100% — verb spec exists in `metallurgy/` | 0 dedicated Si-in-alloy gates yet | Si-in-Al-Si casting (vendor); Fe-Si electrical steel (vendor) |
| PRC (secondary, Si-as-substrate) | 100% — `synthesis/` covers Siemens/CZ/FZ | 0 dedicated Si-synthesis gates yet | Wacker poly-Si batch; FBR pilot |

## §4 v1.x → v1.1.x scope decision

- v1.x scope: (a) at 100% — DONE 2026-05-13 with `a239611` commit.
- v1.1.x stretch: (b) Phase B `B-CER-1..B-CER-5` selftest gates (~5 days of selftest work).
- v2 stretch: integration with Materials Project / GNoME / OMat24 for cross-validation of Si bandgap, Si density, SiC bandgap (Phase G).

## §5 Honest UNPROVEN / UNVERIFIED stamps (verbatim from spec)

From `silicon/silicon.md` and adjacent specs:

- "Wacker, GCL, Hemlock, OCI, REC use their own published figures" — vendor numbers are vendored AS-IS; the spec does NOT claim measurement verification.
- "9N is a process + measurement ceiling, not a physical impossibility" (Si-L1).
- "Float-zone refining can locally reach 11N for niche detector applications" — UNVERIFIED at production scale.
- From `compound-semi/compound-semi.md`: "6/8" bulk GaN ammonothermal UNVERIFIED; diamond-as-semi wafer UNPROVEN" — these are NOT Si claims but live in the compound-semi cross-link area.
- From `2d-materials/2d-materials.md`: "silicene ambient stability beyond Ag(111) substrate UNVERIFIED" — preserved verbatim.

## §6 Selftest hook

When `selftest/silicon_purity_audit.py` lands (Phase B), it should:

1. Parse `silicon/silicon.md §1` for the 9N purity claim.
2. Cross-check that the same 9N value appears in `LIMIT_BREAKTHROUGH.md` Si-L1.
3. Cross-check that `silicon-data-anchors.md §1 row 6` references SEMI M1.
4. Verify no lattice arithmetic is applied to the purity figure (regex audit).


---

*Phase C silicon closure ledger, authored 2026-05-13 by 박민우. (a) 100% reached;
(b) and (c) honest as-of-state per AXIS_CLOSURE_PLAN.md §3.*
