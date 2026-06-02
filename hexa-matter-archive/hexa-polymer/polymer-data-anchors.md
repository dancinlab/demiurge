<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_POL data anchors -->

# polymer-data-anchors — CRC/ASTM/ISO/vendor anchor table

> Phase B `nist_anchor_audit.py` target. One row per anchor used across POL.

## §1 Anchor table

| # | Source | Value | Applies to verbs | Limit / spec ID | Last verified |
|---|--------|-------|------------------|-----------------|---------------|
| 1 | CRC Handbook 105th ed. | nylon-6,6 T_g 323 K, T_m 538 K, ρ 1.14 g/cm³ | nylon | (CRC anchor) | 2026-05-13 |
| 2 | CRC Handbook 105th ed. | PET T_g 343 K, T_m 533 K, ρ 1.40 g/cm³ | pet_film | (CRC anchor) | 2026-05-13 |
| 3 | CRC Handbook 105th ed. | PE T_g 153 K, T_m 408 K (HDPE); PP T_g 263-273 K, T_m 438 K | microplastics, biodegradable-plastics | (CRC anchor) | 2026-05-13 |
| 4 | ASM Handbook vol. 21 "Composites" | Kevlar 49 σ 3.6 GPa, E 124 GPa, ρ 1.44 g/cm³ | aramid | L2 | 2026-05-13 |
| 5 | ASM Handbook vol. 21 | UHMWPE σ 3.9 GPa (Dyneema SK99 datasheet) | (cross to FIB) | L2 | 2026-05-13 |
| 6 | DuPont Zytel datasheet | nylon-6,6 grade specs (vendor) | nylon | (vendor) | 2026-05-13 |
| 7 | BASF Ultramid datasheet | nylon grade specs (vendor) | nylon | (vendor) | 2026-05-13 |
| 8 | Toray Lumirror / DuPont Mylar datasheet | BOPET film specs (vendor) | pet_film | (vendor) | 2026-05-13 |
| 9 | Hexcel / Henkel datasheet | DGEBA/DETA prepreg cure-cycle (vendor) | epoxy | (vendor) | 2026-05-13 |
| 10 | Marshall et al. 1988 | PET hydrolysis activation energy E_a | pet_film | (literature) | 2026-05-13 |
| 11 | NOAA Marine Debris Program | microplastics K_d for PE/PP/PS | microplastics | (regulatory) | 2026-05-13 |
| 12 | EPA microplastics study | partition coefficient, biofilm rate | microplastics | (regulatory) | 2026-05-13 |
| 13 | Goodyear 1839 (sulfur vulcanization patent) | sulfur cure foundational reference | elastomer | (foundational) | 2026-05-13 |
| 14 | NatureWorks Ingeo datasheet | PLA grade specs (vendor) | biodegradable-plastics | (vendor) | 2026-05-13 |
| 15 | Danimer Scientific PHA datasheet | PHB / PHBV grade specs (vendor) | biodegradable-plastics | (vendor) | 2026-05-13 |
| 16 | ASTM D7081 | marine biodegradability standard | biodegradable-plastics | (standard) | 2026-05-13 |
| 17 | ISO 14040 | LCA methodology for polymer recycling | recycling, recycle_n6 | (standard) | 2026-05-13 |
| 18 | Loctite Henkel datasheet | cyanoacrylate, anaerobic adhesive specs | adhesive | (vendor) | 2026-05-13 |
| 19 | 3M VHB tape datasheet | PSA acrylic foam specs | adhesive | (vendor) | 2026-05-13 |
| 20 | Sumitomo Zenite / Vectra LCP datasheet | thermotropic LC polymer specs | liquid-crystal | (vendor) | 2026-05-13 |
| 21 | DuPont/Teijin Twaron / Kevlar datasheet | aramid fiber specs (cross to FIB) | aramid | L2 | 2026-05-13 |
| 22 | Wacker Silicones / Dow Corning datasheet | PDMS silicone specs (cross to CER) | adhesive, elastomer | (vendor) | 2026-05-13 |
| 23 | Furukawa, Cordova, O'Keeffe, Yaghi 2013 | MOF design principles (cross to CER) | mof | (foundational) | 2026-05-13 |
| 24 | Climeworks public DAC cost | $600-1000/t CO₂ amine-based | mof (DAC) | (vendor; magic-$100/t UNPROVEN) | 2026-05-13 |


- Vendor rows (6-9, 14-15, 18-22, 24) carry vendor numbers AS-IS. No lattice fit.
- CRC / ASM / ASTM / ISO rows (1-5, 10-13, 16-17, 23) are primary or standard refs.
- UNVERIFIED stamps preserved:
  - Row 11/12: NOAA/EPA microplastics K_d — UNVERIFIED dataset parity (Phase B)
  - Row 16: ASTM D7081 marine biodegradability — only certain PHA grades pass; most "biodegradable" plastics UNVERIFIED for marine
  - Row 24: Climeworks $600-1000/t CO₂ = vendor; MOF magic-$100/t = UNPROVEN

## §3 (b) gates — ✅ CLOSED 2026-05-13 (Phase H + I.1 + I.2)

- B-POL-1 aramid Kevlar 49 σ/E/ρ vs ASM vol. 21
- B-POL-2 PET hydrolysis E_a vs Marshall 1988
- B-POL-3 microplastics K_d for PE/PP/PS vs NOAA Marine Debris
- B-POL-4 nylon-6,6 T_g 323 K / T_m 538 K vs CRC parity
- B-POL-5 PET T_g 343 K / T_m 533 K vs CRC parity
- B-POL-6 PLA T_g 333-358 K / T_m 423-453 K vs NatureWorks datasheet
- B-POL-7 EPDM T_g 219 K vs CRC
- B-POL-8 silicone PDMS T_g 150 K vs CRC
- B-POL-9 LCP (Vectra) T_g 383-393 K / T_m 553 K vs Sumitomo Zenite datasheet

## §4 (c) hand-offs (DEST list)

- C-POL-1 DuPont/BASF/Toray batch trace — DEST: vendor partnerships (none active)
- C-POL-2 microplastics field mass-balance — DEST: 5 Gyres / Algalita / NOAA
- C-POL-3 aramid pilot synthesis — DEST: DuPont para-aramid (proprietary)
- C-POL-4 marine biodegradability certification — DEST: ASTM D7081 test labs
- C-POL-5 MOF DAC at $100/t — DEST: no commercial entity (Climeworks at $600-1000/t)
- C-POL-6 elastomer bio-isoprene — DEST: Goodyear / Genencor (vendor; UNVERIFIED at production)
- C-POL-7 adhesive aerospace primary structure pilot — DEST: Henkel / 3M (proprietary)

## §5 Cross-anchor map

| Anchor | Other verbs that cite it |
|--------|--------------------------|
| CRC Handbook | every POL verb (T_g, T_m, ρ) |
| ASM Handbook vol. 21 | aramid, UHMWPE, CFRP epoxy (cross to FIB + CER) |
| ASTM D7081 | biodegradable-plastics ONLY (marine biodeg) |
| ISO 14040 | recycling, recycle_n6 (LCA) |
| NOAA Marine Debris | microplastics ONLY |
| Wacker Silicones | adhesive, elastomer (cross to CER) |
| DuPont (Kevlar/Zytel/Mylar) | aramid, nylon, pet_film |

---

*Phase C polymer data-anchors ledger, authored 2026-05-13.*
