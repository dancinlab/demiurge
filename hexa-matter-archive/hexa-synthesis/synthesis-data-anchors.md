<!-- @authored: 2026-05-13 -->
<!-- @phase: C — synthesis data anchors -->

# synthesis-data-anchors — NIST/ASTM/vendor anchor table

> Phase B `nist_anchor_audit.py` target.

## §1 Anchor table

| # | Source | Value | Applies to verbs | Limit / spec ID | Last verified |
|---|--------|-------|------------------|-----------------|---------------|
| 1 | Hales 2017 (Forum of Math Pi) | Kepler conjecture FCC/HCP packing 0.74048... | printing, synthesis, recycle_n6 | L11 | 2026-05-13 |
| 2 | Hench & West 1990 "The sol-gel process" Chem Rev 90:33 | TEOS hydrolysis kinetics for sol-gel SiO₂ | synthesis, glass | (foundational) | 2026-05-13 |
| 3 | Stöber Fink Bohn 1968 | Stöber silica spheres synthesis | synthesis | (foundational) | 2026-05-13 |
| 4 | ASTM F42 (formerly F2792) | additive manufacturing terminology | printing | (standard) | 2026-05-13 |
| 5 | ASTM F3122 | mechanical testing of AM-produced metal parts | printing | (standard) | 2026-05-13 |
| 6 | ISO/ASTM 52900 | AM general principles | printing | (standard) | 2026-05-13 |
| 7 | Ziegler & Natta 1955 (Nobel Prize 1963) | coordination polymerization foundational | polymer (cross to POL) | (foundational) | 2026-05-13 |
| 8 | Flory 1942 / Stockmayer 1942 | step-growth gel point theory | polymer (epoxy thermoset cure) | (foundational) | 2026-05-13 |
| 9 | Pilkington 1959 float-process patent | window glass float-process foundational | glass | (foundational) | 2026-05-13 |
| 10 | Bridgman 1923 / Czochralski 1916 / Kyropoulos 1926 | crystal-pull foundational | silicon, compound-semi, gemology | (foundational) | 2026-05-13 |
| 11 | Verneuil 1902 | flame-fusion synthetic ruby/sapphire foundational | gemology, synthesis | (foundational) | 2026-05-13 |
| 12 | EOS / 3D Systems / Stratasys datasheets | AM machine specs (vendor) | printing | (vendor) | 2026-05-13 |
| 13 | HP MJF (Multi Jet Fusion) datasheet | PA12 powder + agents, 80 µm res | printing | (vendor) | 2026-05-13 |
| 14 | ExOne / Desktop Metal binder-jet datasheet | metal/ceramic binder-jet specs | printing | (vendor) | 2026-05-13 |
| 15 | Arcam EBM (GE Additive) datasheet | Ti-6Al-4V EBM aerospace | printing | (vendor) | 2026-05-13 |
| 16 | Wacker Polysilicon datasheet | Siemens TCS distillation specs | silicon | (vendor) | 2026-05-13 |
| 17 | Hemlock Semiconductor / OCI / REC datasheets | poly-Si production (vendor) | silicon | (vendor) | 2026-05-13 |
| 18 | Shin-Etsu / SUMCO / Siltronic / GlobalWafers / SK Siltron | mono-Si wafer (CZ, FZ) | silicon | (vendor) | 2026-05-13 |
| 19 | Cannon-Muskegon CMSX-10 datasheet | single-crystal Ni superalloy SX | superalloy | (vendor) | 2026-05-13 |
| 20 | Howmet / PCC Aerostructures | turbine blade casting (single-crystal pull) | superalloy | (vendor) | 2026-05-13 |
| 21 | NREL Best Research-Cell Efficiency Chart | perovskite PV PCE record | perovskite | (industry record) | 2026-05-13 |
| 22 | Carbios PETase pilot 50 tpa (Clermont-Ferrand) | enzymatic depolymerization | synthesis (cross to recycle, bio) | (vendor) | 2026-05-13 |
| 23 | Danimer / Newlight bacterial PHA datasheet | microbial polyester synthesis | biodegradable-plastics (cross to bio) | (vendor) | 2026-05-13 |
| 24 | NOAA / EPA — synthesis-to-environment flow | (forward synthesis side; reverse is microplastics) | synthesis | (regulator; cross to microplastics) | 2026-05-13 |


- Vendor rows (12-23) carry vendor / industry numbers AS-IS. No lattice fit.
- Foundational rows (1-3, 7-11) are primary references for synthesis routes.
- Standards rows (4-6) are ASTM / ISO terminology + testing.
- UNVERIFIED stamps preserved:
  - Row 21: NREL perovskite PCE 26%+ is lab cell; 25-yr stability + large-area UNVERIFIED
  - Row 22: Carbios 50 tpa is pilot; commercial scale UNVERIFIED
  - Row 23: marine biodegradability UNVERIFIED most grades (cross from biodegradable-plastics)

## §3 (b) gates queued

- B-PRC-1 Hales packing 0.7405 (FCC/HCP) simulation parity
- B-PRC-2 Gibbs ΔS_mix for polymer recycling vs ISO 14040 LCA (in hexa-recycle/, not here)
- B-PRC-3 sol-gel TEOS hydrolysis rate vs Hench & West 1990 parity
- B-PRC-4 FDM/SLS/SLA mechanical-property vs ASTM F42 parity

## §4 (c) hand-offs

- C-PRC-1 chemical recycling pilot — DEST: Eastman / Loop / Carbios (see hexa-recycle/)
- C-PRC-2 powder-bed printing pilot — DEST: EOS / 3D Systems / Stratasys (vendor)
- C-PRC-3 hydrothermal synthesis pilot — DEST: research (perovskite, MOF, gemology)
- C-PRC-4 bacterial PHA / PHB production — DEST: Danimer Scientific, Newlight Technologies (vendor)

## §5 Cross-anchor map

| Anchor | Other verbs |
|--------|------------|
| L11 Hales packing | printing, metallurgy (casting), ceramics (powder), recycle_n6 |
| Hench & West 1990 | glass (sol-gel), silicon (SiO₂), synthesis |
| ASTM F42 / ISO 52900 | printing ONLY |
| Czochralski 1916 / FZ | silicon, compound-semi, gemology (synthetic gem CZ) |
| Verneuil 1902 | gemology (synthetic ruby/sapphire) |
| Cannon-Muskegon CMSX-10 | superalloy ONLY |
| EOS / 3D Systems / Stratasys | printing ONLY (vendor) |

---

*Phase C synthesis data-anchors ledger, authored 2026-05-13.*
