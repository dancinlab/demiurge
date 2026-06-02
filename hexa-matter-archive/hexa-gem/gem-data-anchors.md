<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_GEM data anchors -->

# gem-data-anchors — NIST/GIA/IGI/Mohs anchor table

> Phase B `nist_anchor_audit.py` target.

## §1 Anchor table

| # | Source | Value | Applies to verbs | Limit / spec ID | Last verified |
|---|--------|-------|------------------|-----------------|---------------|
| 1 | Mohs 1812 scale | diamond Mohs 10 (HARD ceiling) | gemology, carbon | L4 | 2026-05-13 |
| 2 | CRC Handbook 105th ed. | diamond density 3.52 g/cm³, RI 2.417 | gemology, carbon | (CRC) | 2026-05-13 |
| 3 | CRC Handbook 105th ed. | corundum (Al₂O₃) RI 1.762-1.770, SG 4.00, Mohs 9 | gemology, ceramics | (CRC) | 2026-05-13 |
| 4 | NIST SRM 1879b | α-quartz crystallographic standard | gemology, glass | (NIST SRM) | 2026-05-13 |
| 5 | GIA color-grading scale | D-Z for diamond | gemology | (industry standard) | 2026-05-13 |
| 6 | GIA clarity scale | FL/IF/VVS₁/VVS₂/VS₁/VS₂/SI₁/SI₂/I₁/I₂/I₃ | gemology | (industry standard) | 2026-05-13 |
| 7 | GIA cut grading | Excellent/VG/Good/Fair/Poor | gemology | (industry standard) | 2026-05-13 |
| 8 | Liddicoat 1957 "Handbook of Gem Identification" | reference for RI, SG, dichroism, dispersion | gemology | (foundational) | 2026-05-13 |
| 9 | Webster & Read 1994 "Gems: Their Sources, Descriptions and Identification" | reference monograph | gemology | (foundational) | 2026-05-13 |
| 10 | Sumitomo / De Beers Element Six CVD diamond datasheet | synthetic diamond properties | gemology, carbon | (vendor) | 2026-05-13 |
| 11 | NIST WebBook | ruby Cr³⁺ fluorescence λ_max 694.3 nm (R-line) | gemology | (NIST) | 2026-05-13 |
| 12 | GIA / IGI / GCAL grading certificates | per-stone provenance + treatment disclosure | gemology | (industry) | 2026-05-13 |
| 13 | Verneuil 1902 flame fusion patent | synthetic ruby/sapphire foundational | gemology | (foundational) | 2026-05-13 |
| 14 | Chatham flux-grown emerald reference | synthetic emerald | gemology | (vendor) | 2026-05-13 |
| 15 | International Mineralogical Association (IMA) approved species list | mineral nomenclature SSOT | gemology | (foundational) | 2026-05-13 |


- Vendor rows (10, 14): synthetic diamond / emerald specs vendored AS-IS.
- GIA / IGI / GCAL grading (rows 5-7, 12): industry-standard scales, not
  primary measurement — they ARE the measurement protocol.
- UNVERIFIED stamps: carbon allotrope lonsdaleite + carbyne (bulk
  synthesis UNVERIFIED) preserved from carbon.md cross-link.

## §3 (b) gates queued

- B-GEM-1 corundum RI 1.762-1.770 vs CRC + NIST
- B-GEM-2 ruby Cr³⁺ fluorescence 694.3 nm vs NIST
- B-GEM-3 diamond Mohs 10 vs Mohs 1812 (cross to carbon)
- B-GEM-4 diamond RI 2.417 + density 3.52 g/cm³ vs CRC

## §4 (c) hand-offs

- C-GEM-1 lab-grown diamond CVD/HPHT bench — DEST: Element Six / Sumitomo / WD Lab Grown (vendor)
- C-GEM-2 GIA / IGI / GCAL treatment audit — DEST: GIA Carlsbad (foundation; not in repo)
- C-GEM-3 Chatham / Gilson synthetic emerald — DEST: vendor
- C-GEM-4 Verneuil ruby/sapphire — DEST: industrial supply

## §5 Cross-anchor map

| Anchor | Other verbs |
|--------|------------|
| CRC Handbook | ceramics (Al₂O₃, SiO₂ cross), carbon (diamond), gemology |
| NIST WebBook | every CER verb + gemology |
| GIA scales | gemology ONLY (industry-specific) |
| Mohs scale | gemology + carbon (diamond + abrasive) |

---

*Phase C gem data-anchors ledger, authored 2026-05-13.*
