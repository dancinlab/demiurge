<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_FIB data anchors -->

# fiber-data-anchors — ASM/ASTM/TAPPI/ISO/vendor anchor table

> Phase B `nist_anchor_audit.py` target.

## §1 Anchor table

| # | Source | Value | Applies to verbs | Limit / spec ID | Last verified |
|---|--------|-------|------------------|-----------------|---------------|
| 1 | ASM Handbook vol. 21 "Composites" | Kevlar 49 σ 3.6 GPa, E 124 GPa, ρ 1.44 g/cm³ | aramid | L2 | 2026-05-13 |
| 2 | DSM Dyneema SK99 datasheet | UHMWPE fiber σ 3.9 GPa | aramid (cross), fabric | L2 | 2026-05-13 |
| 3 | Toray T1100 datasheet | carbon fiber σ 6.6 GPa, E 324 GPa | carbon (cross-link from CER) | L2 | 2026-05-13 |
| 4 | Toray T700 datasheet | carbon fiber σ 4.9 GPa, E 230 GPa | carbon | L2 | 2026-05-13 |
| 5 | Hexcel IM7 datasheet | carbon fiber σ 5.5 GPa, E 290 GPa | carbon | L2 | 2026-05-13 |
| 6 | NIPPON CARBON Hi-Nicalon SiC fiber datasheet | SiC fiber σ 2.8 GPa, E 270 GPa | carbon, ceramics (cross) | (vendor) | 2026-05-13 |
| 7 | Owens Corning E-glass datasheet | E-glass σ 3.4 GPa, E 72 GPa | glass-fiber (cross to CER) | (vendor) | 2026-05-13 |
| 8 | AGY S-glass datasheet | S-glass σ 4.6 GPa, E 86 GPa | glass-fiber | (vendor) | 2026-05-13 |
| 9 | DuPont Kevlar 49 / Teijin Twaron datasheet | aramid PPTA (vendor) | aramid | (vendor) | 2026-05-13 |
| 10 | TAPPI T 271 | cellulose crystallinity XRD Segal index | paper, wood-cellulose | (standard) | 2026-05-13 |
| 11 | TAPPI T 494 | paper tensile measurement | paper | (standard) | 2026-05-13 |
| 12 | ISO 7211 | woven fabric thread count vs density | fabric | (standard) | 2026-05-13 |
| 13 | ISO 5626 | paper folding endurance | paper | (standard) | 2026-05-13 |
| 14 | TAPPI T 200 | pulp mechanical strength index | paper, wood-cellulose | (standard) | 2026-05-13 |
| 15 | ASTM D2256 | tensile properties of yarns by single-strand method | aramid, fabric | (standard) | 2026-05-13 |
| 16 | ASTM D5034 / D5035 | breaking strength of textile fabrics | fabric | (standard) | 2026-05-13 |
| 17 | Stora Enso (CLT vendor) datasheet | CLT specs (vendor) | wood-cellulose | (vendor) | 2026-05-13 |
| 18 | Binderholz / KLH Massivholz / Structurlam datasheets | engineered wood (CLT/glulam/LVL) specs (vendor) | wood-cellulose | (vendor) | 2026-05-13 |
| 19 | Eastman cellulose acetate datasheet | CA film/fiber specs (vendor) | wood-cellulose | (vendor) | 2026-05-13 |
| 20 | Hu et al. 2016 (transparent wood, Yano group) | lab-scale transparent wood | wood-cellulose | (literature; UNVERIFIED at cost) | 2026-05-13 |
| 21 | Mjøsa Tower Norway (18 floors mass-timber) | precedent | wood-cellulose | (commercial precedent; 50+ floors UNVERIFIED) | 2026-05-13 |
| 22 | Ascent Milwaukee (25 floors mass-timber) | precedent | wood-cellulose | (commercial precedent; 50+ floors UNVERIFIED) | 2026-05-13 |


- Vendor rows (2-9, 17-19, 21-22) carry vendor numbers AS-IS.
- Standard rows (10-16) are ASTM/TAPPI/ISO primary refs.
- UNVERIFIED stamps preserved:
  - Row 20: transparent wood — UNVERIFIED at cost
  - Rows 21-22: 18, 25 floor precedents exist; 50+ floors UNVERIFIED
  - Row 3 (and broader CNT yarn): commercial 1-3 GPa vs lab 80 GPa UNVERIFIED

## §3 (b) gates queued (Phase B targets)

- B-FIB-1 cellulose crystallinity XRD Segal index vs TAPPI T 271
- B-FIB-2 paper tensile vs TAPPI T 494
- B-FIB-3 aramid Kevlar 49 σ/E/ρ vs ASM vol. 21 (also POL B-POL-1)
- B-FIB-4 woven fabric thread count vs ISO 7211

## §4 (c) hand-offs (DEST list)

- C-FIB-1 DuPont/Teijin aramid pilot — DEST: proprietary
- C-FIB-2 pulp-mill chemical-pulping pilot — DEST: vendor (Stora Enso / IP)
- C-FIB-3 mass-timber 50+ story — DEST: no commercial precedent (UNVERIFIED)
- C-FIB-4 natural-fiber harvest yields (cotton, wool, silk, jute, hemp, ramie) — DEST: USDA / FAO statistics
- C-FIB-5 Toray T1100 production scale — DEST: Toray (vendor; lab vs production gap UNVERIFIED for σ_th L2 frontier)

## §5 Cross-anchor map

| Anchor | Other verbs that cite it |
|--------|--------------------------|
| ASM Handbook vol. 21 | aramid, UHMWPE, CFRP epoxy, ceramic fiber (cross to POL + CER) |
| TAPPI standards | paper, wood-cellulose ONLY |
| ASTM textile (D2256, D5034, D5035) | aramid, fabric |
| ISO 7211 | fabric ONLY |
| Toray datasheets | carbon (cross to CER); not POL |
| DuPont/Teijin aramid | aramid (cross to POL) |

---

*Phase C fiber data-anchors ledger, authored 2026-05-13.*
