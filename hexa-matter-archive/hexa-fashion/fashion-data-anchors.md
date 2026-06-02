<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_FAS data anchors -->

# fashion-data-anchors — ISO 105 / AATCC / supply chain anchor table

> Phase B `nist_anchor_audit.py` target.

## §1 Anchor table

| # | Source | Value | Applies to verbs | Limit / spec ID | Last verified |
|---|--------|-------|------------------|-----------------|---------------|
| 1 | ISO 105-C06 | colorfastness to washing (40 °C / 50 °C / 60 °C / 95 °C) | textile-dyeing | (standard) | 2026-05-13 |
| 2 | ISO 105-A02 | grey scale for color change | textile-dyeing | (standard) | 2026-05-13 |
| 3 | ISO 105-B02 | colorfastness to artificial light (xenon-arc) | textile-dyeing | (standard) | 2026-05-13 |
| 4 | ISO 105-E04 | colorfastness to perspiration | textile-dyeing | (standard) | 2026-05-13 |
| 5 | ISO 105-X12 | colorfastness to rubbing (crocking) | textile-dyeing | (standard) | 2026-05-13 |
| 6 | AATCC TM 61 | colorfastness to laundering | textile-dyeing | (standard) | 2026-05-13 |
| 7 | AATCC TM 16 | colorfastness to light | textile-dyeing | (standard) | 2026-05-13 |
| 8 | AATCC TM 8 | colorfastness to crocking | textile-dyeing | (standard) | 2026-05-13 |
| 9 | Kubelka-Munk theory (1931) | K/S = (1 − R)² / 2R; reflectance to dye-strength | textile-dyeing | (foundational) | 2026-05-13 |
| 10 | ICI 1956 Procion patent | reactive dye foundational | textile-dyeing | (foundational) | 2026-05-13 |
| 11 | Indigo natural / synthetic (BASF 1897 synthesis) | indigo C₁₆H₁₀N₂O₂ | textile-dyeing | (foundational) | 2026-05-13 |
| 12 | OEKO-TEX Standard 100 | textile substance restriction list | fashion-textile, textile-dyeing | (industry) | 2026-05-13 |
| 13 | GOTS (Global Organic Textile Standard) | organic textile certification | fashion-textile | (industry) | 2026-05-13 |
| 14 | Bluesign | wet-process chemical management | textile-dyeing | (industry) | 2026-05-13 |
| 15 | Higg Materials Sustainability Index (MSI) | environmental impact score | fashion-textile | (industry) | 2026-05-13 |
| 16 | USDA / FAO cotton production statistics | global cotton supply (mt/yr per country) | fashion-textile | (vendor / regulator) | 2026-05-13 |
| 17 | Woolmark (IWTO) | wool certification | fashion-textile | (industry) | 2026-05-13 |
| 18 | International Sericultural Commission silk statistics | silk production | fashion-textile | (regulator) | 2026-05-13 |
| 19 | DyStar / Huntsman Textile Effects / Archroma dye datasheets | dye-grade specs | textile-dyeing | (vendor) | 2026-05-13 |
| 20 | Genencor / Pivot Bio bacterial indigo lab refs | bio-fermented indigo | textile-dyeing (cross to bio) | (vendor / lab) | 2026-05-13 |


- ISO / AATCC rows (1-8) are industry test standards (the protocol IS the
  measurement).
- Industry certifications (rows 12-15, 17): no lattice fit; vendor figures.
- Supply chain (rows 16, 18): USDA / FAO / regulator statistics.
- Genencor bio-indigo (row 20): cross-substrate to `hexa-bio/`; UNVERIFIED
  at commercial scale.

## §3 (b) gates queued

- B-FAS-1 reactive-dye covalent yield ISO 105 parity
- B-FAS-2 K/S (Kubelka-Munk) for mordant dyeing parity

## §4 (c) hand-offs

- C-FAS-1 dye-house pilot — DEST: DyStar / Huntsman / Archroma (vendor)
- C-FAS-2 indigo fermentation — DEST: Genencor / Pivot Bio (lab; cross to bio)
- C-FAS-3 global cotton supply transparency — DEST: USDA / FAO (regulator)
- C-FAS-4 OEKO-TEX certification — DEST: industry test labs

## §5 Cross-anchor map

| Anchor | Other verbs |
|--------|------------|
| ISO 105 series | textile-dyeing ONLY |
| AATCC test methods | textile-dyeing ONLY |
| Kubelka-Munk | textile-dyeing (color science fundamental) |
| OEKO-TEX / GOTS / Bluesign | fashion-textile + textile-dyeing |
| USDA / FAO statistics | fashion-textile (supply chain transparency) |

---

*Phase C fashion data-anchors ledger, authored 2026-05-13.*
