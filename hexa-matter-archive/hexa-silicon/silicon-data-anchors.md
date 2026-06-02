<!-- @authored: 2026-05-13 -->
<!-- @phase: C — silicon data anchors -->

# silicon-data-anchors — NIST/CRC/SEMI/ASTM/vendor table

> Anchored values used across silicon + cross-linked verbs. Each row
> is one source ↔ verb mapping. This is the Phase B `nist_anchor_audit.py`
> selftest gate target. Last verified column reflects this file's authoring date.

## §1 Anchor table

| # | Source | Value | Applies to verbs | Limit ID | Last verified |
|---|--------|-------|------------------|----------|---------------|
| 1 | NIST WebBook | Si melting point 1687 K | silicon | Si-L5 | 2026-05-13 |
| 2 | CRC Handbook 105th ed. | Si density 2.329 g/cm³ (293 K) | silicon | Si-L6 | 2026-05-13 |
| 3 | NIST / Sze "Physics of Semiconductor Devices" 3rd ed. | Si bandgap 1.12 eV (indirect, 300 K) | silicon, compound-semi | Si-L7 | 2026-05-13 |
| 4 | Saddow & Agarwal 2004 "Advances in Silicon Carbide Processing" | 4H-SiC bandgap 3.26 eV | silicon, compound-semi | Si-L11 | 2026-05-13 |
| 5 | ASM Handbook vol. 21 "Composites" | Si₃N₄ flexural 600–1200 MPa (HIP-densified) | silicon, ceramics | Si-L12 | 2026-05-13 |
| 6 | SEMI M1-0316 | electronic-grade poly-Si specification 9N total metals | silicon | Si-L1 | 2026-05-13 |
| 7 | SEMI PV17 | solar-grade poly-Si specification 6N-7N | silicon | Si-L2 | 2026-05-13 |
| 8 | ASTM F121 / F1188 | Interstitial oxygen [O_i] measurement (FTIR) in Si wafers | silicon | Si-L9 | 2026-05-13 |
| 9 | ASTM F47 | Dislocation density etch-pit count standard | silicon | Si-L10 | 2026-05-13 |
| 10 | Kaiser & Frisch 1958 Phys Rev 112:1546 | Thermal donor formation in CZ Si at 450 °C | silicon | Si-L8 | 2026-05-13 |
| 11 | Wacker Polysilicon AG datasheet | poly-Si purity grade specs (no lattice fit applied) | silicon | (vendor) | 2026-05-13 |
| 12 | GCL Tech (China) public disclosures | poly-Si production capacity (tonnage; vendor figure) | silicon | (vendor) | 2026-05-13 |
| 13 | Hemlock Semiconductor public disclosures | poly-Si production capacity (vendor figure) | silicon | (vendor) | 2026-05-13 |
| 14 | OCI Co. Ltd. public disclosures | poly-Si production capacity (vendor figure) | silicon | (vendor) | 2026-05-13 |
| 15 | REC Silicon ASA public disclosures | FBR poly-Si production capacity (vendor figure) | silicon | (vendor) | 2026-05-13 |
| 16 | Shin-Etsu / SUMCO / Siltronic / GlobalWafers / SK Siltron datasheets | Mono-Si wafer specs (CZ/FZ, diameter, grade) | silicon | Si-L3, Si-L4 | 2026-05-13 |
| 17 | Wolfspeed Inc. datasheet | 4H-SiC wafer (200 mm) specs | compound-semi, silicon | Si-L11 | 2026-05-13 |
| 18 | Heraeus / Corning datasheet | Fused silica T_g ~1473 K | glass, silicon | (L7 in glass) | 2026-05-13 |
| 19 | Ferrotec / Heraeus crucible specs | CZ fused-silica crucible ~600 mm | silicon | Si-L3 | 2026-05-13 |
| 20 | Topsil / Siltronic FZ datasheets | FZ rod ~200 mm | silicon | Si-L4 | 2026-05-13 |


- **No lattice fit on any vendor figure** (rows 11-17, 19-20). Vendor numbers
  are vendored as-is; no n=6 lattice arithmetic is applied.
- **NIST/CRC/SEMI/ASTM/published literature** rows (1-10) are primary-source
  anchors. Si-L1..Si-L12 derive from these, not from lattice identity.
- **UNVERIFIED rows** (Phase B `nist_anchor_audit.py` targets):
  - Row 1 — Si T_m 1687 K vs NIST WebBook digit-by-digit (UNVERIFIED; will be Phase B `B-CER-3` or similar selftest gate)
  - Row 2 — Si ρ 2.329 g/cm³ vs CRC 105th ed. (UNVERIFIED, Phase B)
  - Row 3 — Si E_g 1.12 eV vs NIST/Sze digit-by-digit (UNVERIFIED, Phase B)
  - Row 4 — 4H-SiC E_g 3.26 eV vs Saddow & Agarwal (UNVERIFIED, Phase B)
  - Row 5 — Si₃N₄ flexural range vs ASM vol. 21 (UNVERIFIED, Phase B)

## §3 Selftest hooks (Phase B targets)

When `selftest/nist_anchor_audit.py` lands (Phase B), it will read this
file as the authoritative ledger and check:

1. Each row's value appears verbatim in the corresponding verb spec file.
2. Each row's source is a primary source (NIST/CRC/SEMI/ASTM/peer-reviewed),
   except rows marked `(vendor)` which are explicitly vendor-only.
4. Last-verified date is within `selftest_freshness_days` (TBD; default 365 days).

## §4 Cross-anchor map (where else these anchors are used)

| Anchor | Other verbs that cite it |
|--------|--------------------------|
| NIST WebBook (general) | every CER verb, compound-semi, perovskite, mof |
| CRC Handbook | every verb that cites density/T_m/T_g |
| SEMI standards | silicon, compound-semi, 2d-materials |
| ASTM F-series | silicon, ceramics, compound-semi |
| ASM Handbook | metallurgy, superalloy, ceramics, lutherie |
| Wacker datasheet | silicon only (cross-link to adhesive/elastomer for silicone) |
| Wolfspeed datasheet | silicon, compound-semi |

---

*Phase C silicon data-anchors ledger, authored 2026-05-13. Last verified
all rows: 2026-05-13. Phase B `nist_anchor_audit.py` will consume this file.*
