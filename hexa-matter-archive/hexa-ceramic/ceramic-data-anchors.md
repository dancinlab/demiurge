<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_CER data anchors -->

# ceramic-data-anchors — NIST/CRC/ASM/ACI/ASTM/SEMI anchor table

> One row per anchor used across CER verbs. Phase B `nist_anchor_audit.py`
> consumes this file. Last-verified date = file authoring date.

## §1 Anchor table

| # | Source | Value | Applies to verbs | Limit / spec ID | Last verified |
|---|--------|-------|------------------|-----------------|---------------|
| 1 | NIST WebBook | SiO₂ (α-quartz) T_m 1996 K | glass | (L7-adjacent) | 2026-05-13 |
| 2 | NIST SRM 1879b | α-quartz density and crystallographic standard | glass, silicon (SiO₂) | (NIST SRM) | 2026-05-13 |
| 3 | CRC Handbook 105th ed. | MgO T_m 3098 K, Al₂O₃ T_m 2345 K, ZrO₂ T_m 2988 K | ceramics | (L5-anchored) | 2026-05-13 |
| 4 | ASM Handbook vol. 21 "Composites" | Si₃N₄ flexural 600-1200 MPa (HIP) | ceramics, silicon | Si-L12 | 2026-05-13 |
| 5 | ASM Handbook vol. 4 | sintering kinetics, Frenkel theory | ceramics, synthesis | (no parity gate yet) | 2026-05-13 |
| 6 | ACI 318-19 | Concrete compressive strength acceptance criteria (28-day) | concrete, concrete_tech | L8 | 2026-05-13 |
| 7 | Ductal (Lafarge) datasheet | UHPC 200-800 MPa compressive | concrete_tech | L8 | 2026-05-13 |
| 8 | Cor-Tuf (US Army Corps) datasheet | UHPC compressive specs | concrete_tech | L8 | 2026-05-13 |
| 9 | NIST WebBook | Si T_m 1687 K, Si ρ 2.329 g/cm³, Si E_g 1.12 eV | silicon, compound-semi | Si-L5, Si-L6, Si-L7 | 2026-05-13 |
| 10 | Saddow & Agarwal 2004 | 4H-SiC bandgap 3.26 eV | silicon, compound-semi | Si-L11 | 2026-05-13 |
| 11 | Heraeus / Corning datasheet | Fused silica T_g ~1473 K | glass | L7 | 2026-05-13 |
| 12 | SEMI M1-0316 | Electronic-grade poly-Si 9N spec | silicon | Si-L1 | 2026-05-13 |
| 13 | SEMI PV17 | Solar-grade poly-Si 6N-7N spec | silicon | Si-L2 | 2026-05-13 |
| 14 | ASTM F121 / F1188 | [O_i] FTIR measurement in Si wafers | silicon | Si-L9 | 2026-05-13 |
| 15 | ASTM F47 | Dislocation density etch-pit count | silicon | Si-L10 | 2026-05-13 |
| 16 | Wolfspeed Inc. datasheet | 4H-SiC 200 mm wafer (commercial) | compound-semi, silicon | Si-L11 | 2026-05-13 |
| 17 | Lee, Kim, Auh 2023 (LK-99 claim) — NOT REPRODUCED | claimed room-T SC in Cu-doped lead apatite | perovskite | HARD_WALL (LIMIT_BREAKTHROUGH) | 2026-05-13 (NOT REPRODUCED stamp preserved) |
| 18 | NREL Best Research-Cell Efficiency Chart | perovskite PV PCE > 26% lab | perovskite | (efficiency record, vendor-published) | 2026-05-13 |
| 19 | Novoselov & Geim 2004 (graphene isolation) | mechanical exfoliation precedent | 2d-materials, carbon | (foundational) | 2026-05-13 |
| 20 | Saito, Dresselhaus & Dresselhaus 1998 "Physical Properties of Carbon Nanotubes" | CNT E ~1 TPa | carbon | (lab parameter) | 2026-05-13 |
| 21 | Furukawa, Cordova, O'Keeffe, Yaghi 2013 Science 341:1230444 | MOF design principles, surface area | mof | (UNVERIFIED dataset parity) | 2026-05-13 |
| 22 | Climeworks DAC published cost | $600-1000/t CO₂ amine-based | mof (DAC cross-link) | (vendor; MOF magic-$100/t UNPROVEN) | 2026-05-13 |
| 23 | Wacker Polysilicon AG | poly-Si purity grade specs (vendor) | silicon | (vendor) | 2026-05-13 |
| 24 | GCL Tech / Hemlock / OCI / REC | poly-Si production capacity (vendor) | silicon | (vendor) | 2026-05-13 |


- Rows 17-24 are vendor / lab / public-disclosure values. NO lattice fit applied.
- Rows 1-16 are NIST/CRC/SEMI/ASTM/ASM/ACI primary sources, anchored to
  `LIMIT_BREAKTHROUGH.md` Wave M classifications.
- Row 17 (LK-99) is preserved verbatim with NOT-REPRODUCED stamp;
  `perovskite/perovskite.md` enforces HARD_WALL.

## §3 (b) gates queued (Phase B `nist_anchor_audit.py` targets)

- B-CER-1 NIST SRM quartz refractive index vs `glass/glass.md`
- B-CER-2 Si density 2.329 g/cm³ CRC vs Si-L6
- B-CER-3 Si bandgap 1.12 eV NIST/Sze vs Si-L7
- B-CER-4 SiC bandgap 3.26 eV Saddow & Agarwal vs Si-L11
- B-CER-5 Si₃N₄ flexural 600-1200 MPa ASM vol. 21 vs Si-L12
- B-CER-6 Mohs 10 diamond vs `gemology/gemology.md` (cross-group with GEM)
- B-CER-7 fused silica T_g 1473 K Heraeus/Corning vs L7
- B-CER-8 UHPC compressive Ductal/Cor-Tuf vs L8
- B-CER-9 Al₂O₃ T_m 2345 K CRC vs ceramics
- B-CER-10 perovskite PCE NREL chart vs perovskite.md

## §4 (c) hand-offs (DEST list)

- C-CER-1 Wacker poly-Si batch trace — DEST: Wacker Polysilicon AG
- C-CER-2 Wolfspeed SiC wafer fab — DEST: Wolfspeed Inc.
- C-CER-3 LK-99 reproduction — DEST: no lab (2023 null reproduction; HARD_WALL)
- C-CER-4 Antiferroelectric perovskite growth — DEST: out-of-scope
- C-CER-5 Isotope-separated Si-28 — DEST: Int'l Avogadro / quantum compute
- C-CER-6 high-purity quartz mining — DEST: Sibelco (Spruce Pine NC)
- C-CER-7 ceramic armor production — DEST: Coorstek / CeramTec / Kyocera
- C-CER-8 UHPC pilot-pour benchmarking — DEST: Lafarge Ductal / Cor-Tuf
- C-CER-9 MOF DAC at $100/t — DEST: no commercial entity (Climeworks at $600-1000/t)

## §5 Selftest hooks (Phase B)

When `nist_anchor_audit.py` lands, it should:
1. For each row, regex-search the verb spec file for the value verbatim.
2. Cross-check `LIMIT_BREAKTHROUGH.md` for the same Limit ID.
3. Confirm vendor rows do NOT have lattice arithmetic applied.
4. Verify NOT-REPRODUCED stamp on Row 17 (LK-99) remains intact.

---

*Phase C ceramic data-anchors ledger, authored 2026-05-13.*
