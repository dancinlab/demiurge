<!-- @authored: 2026-05-13 -->
<!-- @phase: C — recycle data anchors -->

# recycle-data-anchors — ISO 14040 / vendor / regulator anchor table

> Phase B `nist_anchor_audit.py` target.

## §1 Anchor table

| # | Source | Value | Applies to verbs | Limit / spec ID | Last verified |
|---|--------|-------|------------------|-----------------|---------------|
| 1 | ISO 14040 / ISO 14044 | LCA methodology — life cycle assessment | recycling, recycle_n6 | (standard) | 2026-05-13 |
| 2 | Gibbs ΔS_mix = -R·ln(2) per mol at x=0.5 | entropy of mixing floor (HARD wall) | recycling, recycle_n6 | L12 | 2026-05-13 |
| 3 | Eastman Chemical glycolysis (PET-to-monomer) pilot | PET-glycolysis route, BHET intermediate | recycling | (vendor) | 2026-05-13 |
| 4 | Loop Industries methanolysis | PET to DMT + EG, virgin-grade output | recycling | (vendor) | 2026-05-13 |
| 5 | Carbios PETase enzymatic | enzymatic PET breakdown, Clermont-Ferrand pilot 50 tpa | recycling | (vendor) | 2026-05-13 |
| 6 | Plastic Energy pyrolysis | thermal decomp mixed PE/PP/PS | recycling | (vendor) | 2026-05-13 |
| 7 | BASF / Fraunhofer CreaSolv | solvolysis (PS, EPS, XPS) | recycling | (vendor) | 2026-05-13 |
| 8 | EU Waste Framework Directive 2008/98/EC | recycling targets and definitions | recycling | (regulator) | 2026-05-13 |
| 9 | EPA WARM model | waste-reduction GHG emissions tool | recycling | (regulator) | 2026-05-13 |
| 10 | Worldsteel / IISI | steel recycle rate ~85% global | recycling | (industry) | 2026-05-13 |
| 11 | International Aluminum Institute | Al recycle rate ~75% | recycling | (industry) | 2026-05-13 |
| 12 | International Copper Association | Cu recycle ~65% | recycling | (industry) | 2026-05-13 |
| 13 | World Gold Council | Au recycle ~85% | recycling | (industry) | 2026-05-13 |
| 14 | International Lead Association | Pb recycle ~95% (battery) | recycling | (industry) | 2026-05-13 |
| 15 | International Platinum Group Metals Association | Pt recycle ~50% (catalyst converters) | recycling | (industry) | 2026-05-13 |
| 16 | Hales 2017 sphere-packing proof | FCC/HCP packing 0.7405 (Kepler conjecture) | recycle_n6 (packing density), printing | L11 | 2026-05-13 |
| 17 | Schulz 1939 / Flory 1942 polymer MW theory | step-growth polydispersity Đ → 2 at high conversion | recycling | (foundational) | 2026-05-13 |
| 18 | NOAA Marine Debris Program | microplastics fate when recycle fails | recycling (cross to POL) | (regulator) | 2026-05-13 |


- Vendor rows (3-7): chemical recycling pilots vendored AS-IS. No lattice fit.
- Industry rows (10-15): recycle rates from trade associations.
- Foundational rows (2, 16, 17): Gibbs thermodynamics + Hales geometry +
  Flory polymer theory — primary refs.
- UNVERIFIED stamps:
  - Carbios 50 tpa pilot = real but commercial scale UNVERIFIED
  - "Infinite recycle" / cradle-to-cradle: UNPROVEN at L12 thermodynamic limit
  - Rare-earth-from-NdFeB recycling > 5% UNVERIFIED

## §3 (b) gates queued

- B-PRC-1 Hales packing 0.7405 (FCC/HCP) simulation parity
- B-PRC-2 Gibbs ΔS_mix for polymer recycling vs ISO 14040 LCA

## §4 (c) hand-offs

- C-PRC-1 chemical recycling pilot — DEST: Eastman / Loop Industries / Carbios (vendor)
- C-PRC-2 alloy entropy-separation pilot — DEST: research (no commercial)
- C-PRC-3 rare-earth-from-NdFeB > 5% recycling — DEST: research (no commercial)

## §5 Cross-anchor map

| Anchor | Other verbs |
|--------|------------|
| ISO 14040 | recycling + biodegradable-plastics (Phase D) |
| L12 Gibbs ΔS_mix | recycling, recycle_n6 |
| Worldsteel / IAI / ICA | metallurgy (cross-link) |
| EPA WARM | recycling ONLY |
| Hales 2017 | recycle_n6, printing (both PRC) |

---

*Phase C recycle data-anchors ledger, authored 2026-05-13.*
