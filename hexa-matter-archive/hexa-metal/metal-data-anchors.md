<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_MET data anchors -->

# metal-data-anchors — ASM/CRC/NIST/vendor anchor table

> Phase B `nist_anchor_audit.py` target.

## §1 Anchor table

| # | Source | Value | Applies to verbs | Limit / spec ID | Last verified |
|---|--------|-------|------------------|-----------------|---------------|
| 1 | ASM Handbook vol. 1 "Properties and Selection: Irons, Steels" | Fe T_α↔γ 1183 K, Fe-Fe₃C phase diagram | metallurgy | (foundational) | 2026-05-13 |
| 2 | ASM Handbook vol. 2 "Properties and Selection: Nonferrous Alloys" | Ti-6Al-4V α-β transition 1268 K | metallurgy | (foundational) | 2026-05-13 |
| 3 | ASM Handbook vol. 1 | Inconel 718 creep at 650 °C / 100 ksi rupture life | superalloy | (foundational) | 2026-05-13 |
| 4 | ASM Handbook vol. 4 "Heat Treating" | TTT diagram austenite-martensite-bainite for AISI 1080 | metallurgy | (foundational) | 2026-05-13 |
| 5 | CRC Handbook 105th ed. | Cu T_m 1358 K, ρ 8.94 g/cm³ | metallurgy, lutherie | L9 (k=401 W/m·K) | 2026-05-13 |
| 6 | CRC Handbook 105th ed. | Ag T_m 1235 K, ρ 10.49 g/cm³, k=429 W/m·K | metallurgy | L9 | 2026-05-13 |
| 7 | CRC Handbook 105th ed. | W T_m 3695 K, ρ 19.30 g/cm³ | metallurgy (refractory) | L5-adjacent | 2026-05-13 |
| 8 | CRC Handbook 105th ed. | Os T_m 3306 K, ρ 22.59 g/cm³ | metallurgy | L6 | 2026-05-13 |
| 9 | NIST WebBook | Fe T_m 1808 K, Al T_m 933 K, Ti T_m 1941 K | metallurgy | (NIST) | 2026-05-13 |
| 10 | Special Metals Inconel 718 datasheet | nominal composition + properties (vendor) | superalloy | (vendor) | 2026-05-13 |
| 11 | Cannon-Muskegon CMSX-10 datasheet | single-crystal Ni-base composition + creep | superalloy | (vendor) | 2026-05-13 |
| 12 | Cannon-Muskegon CMSX-4 datasheet | 2nd-gen SX, 3 wt% Re | superalloy | (vendor) | 2026-05-13 |
| 13 | Rolls-Royce / GE / P&W public turbine specs | turbine inlet T (~1700 °C class), blade alloy choice | superalloy | (vendor) | 2026-05-13 |
| 14 | Hitachi Metals / Magnequench NdFeB datasheet | N52 (BH)_max 50-52 MGOe | magnetic-materials | (vendor) | 2026-05-13 |
| 15 | Vacuumschmelze SmCo datasheet | SmCo₅ + Sm₂Co₁₇ specs | magnetic-materials | (vendor) | 2026-05-13 |
| 16 | TDK / Ferroxcube ferrite datasheet | Mn-Zn / Ni-Zn ferrite specs | magnetic-materials | (vendor) | 2026-05-13 |
| 17 | Metglas (Hitachi) 2605SA1 datasheet | Fe-Si-B amorphous, B_sat 1.56 T | magnetic-materials | (vendor) | 2026-05-13 |
| 18 | Hitachi Finemet FT-3 datasheet | nanocrystalline, B_sat 1.23 T | magnetic-materials | (vendor) | 2026-05-13 |
| 19 | Zildjian B20 cymbal alloy reference | 80% Cu / 20% Sn bronze | lutherie | (vendor) | 2026-05-13 |
| 20 | D'Addario / Ernie Ball string-gauge ref | steel string composition / winding | lutherie | (vendor) | 2026-05-13 |
| 21 | Howmet / PCC Aerostructures | single-crystal turbine blade casting (vendor) | superalloy | (vendor) | 2026-05-13 |
| 22 | Lavoisier Antoine 1789 | element list (foundational; no longer load-bearing per modern NIST) | metallurgy | (historical) | 2026-05-13 |
| 23 | Bain & Davenport TTT (1930) | austenite transformation kinetics foundational | metallurgy | (foundational) | 2026-05-13 |


- Vendor rows (10-21) carry vendor numbers AS-IS. No lattice fit.
- ASM / CRC / NIST primary refs are load-bearing for L5 / L6 / L9.
- UNVERIFIED stamps preserved:
  - Row 11/12: SX superalloy Re-free at-parity UNVERIFIED
  - Row 14: rare-earth-free > 35 MGOe UNVERIFIED (no commercial product)
  - Tetrataenite, MnBi, Fe₁₆N₂ are R&D — not in this anchor table by design

## §3 (b) gates queued (Phase B targets)

- B-MET-1 Inconel 718 creep at 650 °C vs ASM vol. 1
- B-MET-2 Ti-6Al-4V α-β transformation 1268 K vs ASM vol. 2
- B-MET-3 TTT (time-temperature-transformation) for AISI 1080 vs Bain & Davenport
- B-MET-4 NdFeB N52 (BH)_max 50-52 MGOe vs Hitachi Metals datasheet
- B-MET-5 Metglas 2605SA1 B_sat 1.56 T vs vendor datasheet

## §4 (c) hand-offs (DEST list)

- C-MET-1 single-crystal turbine blade casting — DEST: Howmet / PCC Aerostructures (no contract)
- C-MET-2 luthier studio (Stradivari method) — DEST: out-of-scope (culture)
- C-MET-3 NdFeB rare-earth supply chain — DEST: Lynas / MP Materials / Iluka (vendor)
- C-MET-4 SmCo aerospace supply — DEST: Vacuumschmelze
- C-MET-5 isotope-separated Si-28 for Fe-Si analog — DEST: cross-link to silicon

## §5 Cross-anchor map

| Anchor | Other verbs |
|--------|------------|
| ASM Handbook vol. 1 | metallurgy, superalloy (steel + Ni-base) |
| ASM Handbook vol. 2 | metallurgy (non-ferrous) |
| ASM Handbook vol. 4 | metallurgy (heat-treatment) |
| CRC Handbook (T_m, ρ, k) | every MET verb |
| NIST WebBook | every MET verb (cross-check) |
| Special Metals / Cannon-Muskegon | superalloy ONLY |
| Hitachi Metals / Magnequench / Vacuumschmelze | magnetic-materials ONLY |

---

*Phase C metal data-anchors ledger, authored 2026-05-13.*
