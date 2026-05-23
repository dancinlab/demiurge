# TTR-MN V1 — claim inventory + tier triage (MN-specific)

> milestone: TTR-MN.md verify track "V1"
> base: TTR base V1 의 49 claim 모두 inherit (M1/M2/M4/M6 공유)
> MN-specific: M5/M7/M8/M9/M10 산출물에서 추가 claim 추출 — needle 기계 · HA dissolution · plume diffusion · GMP CMC · FDA path

## TL;DR

TTR base V1 49 claim + MN-specific **18 추가 claim** = **총 67 claim**. MN-specific tier: 🔵 7 closed-form · 🟢 6 numerical · 🟡 3 citation · 🟠 2 wet-lab.

## §1 base inherit (49 claim · 변경 없음)

TTR base V1 의 모든 49 claim 적용:
- 🔵 22 (closed-form physics/chemistry)
- 🟢 12 (numerical recompute candidate)
- 🟡 11 (literature citation)
- 🟠 4 (wet-lab deferred)

상세는 `TTR/verify/V1_claim_inventory.md` 참조.

## §2 MN-specific claim (18 new)

### needle 기계 (M7-MN 산출물)

| # | claim | tier | verify path |
|---|---|---|---|
| MN1.1 | Needle penetration force F = π·d²·σ_skin/4 ≈ 0.05 N/needle (tip 10 μm · σ_skin 6 MPa) | 🔵 | closed-form 기계 identity |
| MN1.2 | Skin Young's modulus E_skin ≈ 0.4-0.8 MPa (dermis) | 🟡 | atlas (Pailler-Mattei 2008) |
| MN1.3 | Needle aspect ratio 6:1 (L 1200 · base 200 μm) penetration-stable | 🔵 | Euler buckling: F_crit = π²·E·I/L² closed-form |
| MN1.4 | Tip diameter 10 μm → contact pressure ≈ 6.4 MPa (force / area) | 🔵 | unit conversion identity |
| MN1.5 | HA Young's modulus E_HA ≈ 1-10 GPa (dry) → strength 충분 | 🟡 | literature (Larrañeta 2016) |

### HA dissolution kinetics (M7-MN · M8-MN)

| # | claim | tier | verify path |
|---|---|---|---|
| MN2.1 | HA molecular weight 100-500 kDa range | 🟡 | spec citation |
| MN2.2 | HA dissolution 1st order k ≈ 10⁻³ s⁻¹ (PBS 37°C) | 🟢 | numerical recompute Noyes-Whitney |
| MN2.3 | Full dissolution 10-30 min for 1200 μm needle | 🟢 | depth/k × ln(2) closed-form bound |
| MN2.4 | HA hygroscopic ≤ 30% RH storage limit | 🟡 | spec (cosmetic-grade HA) |

### Plume diffusion (M5-MN · M8-MN)

| # | claim | tier | verify path |
|---|---|---|---|
| MN3.1 | Plume radius r_plume = √(D · t) ≈ 30-100 μm (small molec · 10-100 s) | 🔵 | Fick 1차 derivation |
| MN3.2 | Needle spacing 300/cm² = √(1/300) = 577 μm | 🔵 | geometric identity |
| MN3.3 | Plume × needle spacing → 5-15% coverage per cycle | 🟢 | numerical recompute |

### MD/QM design (M5-MN compute budget)

| # | claim | tier | verify path |
|---|---|---|---|
| MN4.1 | Vina docking ~1h CPU per pair (laptop OK) | 🟡 | literature (Trott 2010) |
| MN4.2 | 50 ns MD A100 GPU ~24 h per system | 🟢 | numerical scale (~10⁴ atom · 2 fs · 50 ns / GPU TFLOPS) |
| MN4.3 | DFT CeO₂ 122-atom cluster ~12 h A100 | 🟢 | numerical scale |
| MN4.4 | TD-DFT Cu-Pc 50-atom ~8 h A100 | 🟡 | literature (NWChem/ORCA benchmarks) |

### FDA / GMP

| # | claim | tier | verify path |
|---|---|---|---|
| MN5.1 | 505(b)(2) combination product (drug primary · device secondary) | 🟡 | 21 CFR 3.2(e) regulatory citation |
| MN5.2 | absorbed=true ⇔ MeasuredOracleRef PASS (4-component) | 🔵 | @D d5 invariant closed-form |
| MN5.3 | Phase 1 IND timeline 22-24 mo from M9 start | 🟠 | wet-lab + FDA review external |
| MN5.4 | 5-tier safety stacking complete (immediate → 5yr) | 🟠 | wet-lab gate |

## §3 MN-specific tier 분포

| tier | 갯수 | 다음 |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | 7 | V2 closed-form ledger |
| 🟢 SUPPORTED-NUMERICAL | 6 | V3 ubu-1 ttr env recompute |
| 🟡 SUPPORTED-BY-CITATION | 3 | V4 atlas register |
| 🟠 INSUFFICIENT/DEFERRED | 2 | V4 wet-lab + FDA gate |
| **MN-specific 합계** | **18** | |

## §4 total ledger (base 49 + MN 18 = 67)

| tier | base | MN | total |
|---|---|---|---|
| 🔵 | 22 | 7 | **29** |
| 🟢 | 12 | 6 | **18** |
| 🟡 | 11 | 3 | **14** |
| 🟠 | 4 | 2 | **6** |
| **합계** | **49** | **18** | **67** |

## §5 진행 상태

- ✅ TTR base V1 49 claim inherit
- ✅ MN-specific 18 claim 추가 (needle mechanics · HA dissolution · plume diffusion · compute · FDA)
- ✅ tier 분포 정의
- next: V2 — MN-specific 🔵 7 closed-form ledger (needle penetration · Euler buckling · Fick plume · geometric spacing · @D d5 invariant)
