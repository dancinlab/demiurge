# TTR-MN v4 measured-oracle PASS — 2개월 timeline endpoint

> milestone: TTR-MN.md "TTR-MN v4 measured-oracle PASS — 2개월 timeline absorbed=true (Phase 1 B arm dose escalation)"
> driver: v4 floor (격일 × 2개월) Phase 1 → absorbed=true 최종 trigger
> base: M10-MN v3 (`m10_mn_v3_measured_oracle.md`) 위 v4 dual-arm path

## TL;DR

absorbed=true v4 = **4-component MeasuredOracleRef** (v3 endpoint + v4 격일 추가). Phase 1 dose escalation **dual-track** (v3 A arm + **v4 B arm**) · 격일 cycle 의 SC barrier + 면역 + amine clearance 누적 safety + 2개월 timeline efficacy. post-marketing dual-track product (Standard 4.5mo + Express 2mo). 추가 비용 ~$1M (v4 B arm Phase 1). 총 v3+v4 IND budget ~$1.5-2M.

## §1 v4 measured-oracle 4-component

### ① efficacy PASS (v4 endpoint)

| sub-endpoint | v3 gate | **v4 gate** |
|---|---|---|
| Removal % cumulative | ≥ 90% (4.5mo) | **≥ 90% (2mo · 15 cycle 격일)** |
| Per-cycle x (mean) | 10-14% | **12-16%** (cascade × density × photo × TLR7/8) |
| Cycle 4 removal (14일) | 40% | ≥ 45% |
| Cycle 8 removal (28일) | 65% | ≥ 65% |
| Cycle 15 FINAL (52일) | — | **≥ 90% mandatory** |

### ② safety PASS (5-tier + v4 추가 axis)

| tier | v3 | v4 추가 |
|---|---|---|
| 1 immediate | 자극 ≤ 1 | LED 광열 멜라닌 손상 (Fitzpatrick IV-VI) check |
| 2 24-72h | aromatic amine < 15 ng/mL | **Cmax 격일 누적 ≤ 15 ng/mL** (M9-v4 verified) |
| 3 Day 7-28 | 콜라겐/멜라닌/TEWL | **TEWL 격일 누적 ≤ 10% above baseline** |
| 3 추가 | — | **M1/M2 ratio ≤ 2.5× baseline (TLR7/8 effect)** |
| 3 추가 | — | **IFN-α serum < 10 pg/mL · IgE < 2× · ANA negative** |
| 4 Day 30-90 | scar/색소 | 동일 |
| 5 long-term (5yr) | 멜라노마/광노화 | **autoimmune incidence (post-TLR7/8 commit)** |

### ③ GMP PASS (CMC v4 release)

v3 spec + v4 추가:
- v4 array (1500/cm² · L 1200 · tip 6 μm · base 120 μm) dimensional ± 5%
- Quad payload (AzoR + DyP + CeO₂ + TLR7/8) potency assay each ± 10%
- TLR7/8 (imiquimod-grade) lot release (pharma-grade · USP)
- UV-A LED patch QC (365 nm ± 3 nm · 1 mW/cm² ± 10%)
- **새 spec**: photo+cascade lot reproducibility (per-cycle x ± 2%)
- Sterility + endotoxin USP <71>/<85>

### ④ regulatory PASS (FDA v3/v4 dual-arm)

| step | v3 | **v4** |
|---|---|---|
| Pre-IND meeting | dev plan | dose escalation v3/v4 합의 |
| IND Module 5 | Phase 1 protocol | **dose escalation 6 arm (A1-A3 v3 + B1-B4 v4)** |
| FDA 30-day review | clinical hold | dual-arm v3 PASS only · v4 conditional |
| Phase 1 dual-track | n=24 (v3) | n=24 (v3) + **n=26 (v4 B arm)** = **50 total** |
| Special: 5-yr registry | melanoma | + **autoimmune** (TLR7/8 commitment) |

## §2 Phase 1 dual-track design

| arm | dose | freq | n | duration | per-cycle target |
|---|---|---|---|---|---|
| **A1 (v3 low)** | 1 cm² × 1 patch | 주 1회 | 6 | 19 cycle (4.5mo) | ≥ 8% |
| **A2 (v3 mid)** | 1 cm² × 3 concurrent | 주 1회 | 6 | 19 cycle | ≥ 10% |
| **A3 (v3 high)** | 5 cm² × 1 | 주 1회 | 6 | 19 cycle | ≥ 10% |
| **B1 (v4 low)** | 1 cm² × 1 + LED | 격일 | 6 | 15 cycle (2mo) | ≥ 8% |
| **B2 (v4 mid)** | 1 cm² × 3 + LED | 격일 | 6 | 15 cycle | ≥ 12% |
| **B3 (v4 full)** ★ | 1 cm² × 3 + LED + TLR7/8 | 격일 | 8 | 15 cycle | **≥ 14%** |
| **B4 (v4 high)** | 5 cm² × 1 + LED + TLR7/8 | 격일 | 6 | 15 cycle | ≥ 14% |
| **Placebo (A0)** | HA-only patch | 주 1회 | 4 | 19 cycle | ~0% |
| **Placebo (B0)** | HA-only + LED | 격일 | 4 | 15 cycle | ~0% (LED alone) |

⇒ **n=52 healthy volunteer** · 8 arm · primary safety/tolerability · secondary efficacy

### Phase 1 endpoint (dual-track)

- Daily user log (자가 적용 시 통증 · 만족도)
- Weekly RGB delta + OCT
- Bi-weekly serum (aromatic amine · IFN-α · IgE)
- Day 0/14/28/52 (B arm) · Day 0/19/38/57/76/95/114/133 (A arm) biopsy
- 5-yr melanoma + autoimmune registry (post-market commitment)

## §3 timeline (v3 + v4 dual-track)

```
   M9-v3 Tier 2 + M9-v4 dedicated cohort (parallel)
        │
        ▼
   12 mo  efficacy + safety + dual-arm 데이터
        │
        ▼
   13 mo  Pre-IND Type B (dual-arm 합의)
        │
        ▼
   15 mo  IND filing (Module 1-5 · 6-arm dose escalation)
        │
        ▼
   16 mo  FDA 30-day review
        │
        ▼
   17 mo  Phase 1 IRB + sites (n=52)
        │
        ▼
   18 mo  Phase 1 enrollment start
        │
        ▼
   24 mo  ★ v3 A arm 완료 (4.5mo treatment + 1.5mo follow-up)
        │
        ▼
   23 mo  ★ v4 B arm 완료 (2mo treatment + 4mo follow-up · 빠른 readout)
        │
        ▼
   27 mo  ★ absorbed=true v3 + v4 (Phase 1 dual-track PASS)
```

⇒ v3 27mo + **v4 동일** (B arm faster readout · 같은 timing)

## §4 비용 (v3 → v3+v4 dual)

| item | v3 only | **v3+v4 dual** |
|---|---|---|
| Pre-IND consulting | $45k | $50k (+11%) |
| IND filing | $70k | $90k (+29% · dual-arm 자료) |
| GMP precursor v3+v4 lots | $120k | **$200k** (+67%) |
| Phase 1 n=24 (v3) | $280-480k | $400k baseline |
| Phase 1 추가 n=26 (v4 B arm) | — | **+$520k** |
| Phase 1 LED patches (60 reusable) | — | +$10k |
| IRB + sites (8 arm) | $50k | $80k |
| Statistical (8-arm) | $55k | $85k (+55% · dual-arm) |
| **합계 (IND → Phase 1)** | **$620-820k** | **~$1.4M** |

(v3 only $620-820k · v4 추가 +$580k · 합계 ~$1.4M)

## §5 atlas absorption v3+v4

```
hexa atlas register --from-measured-oracle \
  --domain TTR-MN \
  --version v4 \
  --record path/to/v4_measured_oracle.json \
  --auto-pr
```

record 내용:
- isMeasuredOraclePASS=true (dual)
- v3 A arm timeline 정합 (efficacy ≥ 90% @ 4.5mo)
- v4 B arm timeline 정합 (efficacy ≥ 90% @ 2mo)
- Phase 1 dose escalation result
- 5-tier safety stacking all PASS (+ v4 6-axis: TEWL · M1 · IFN · IgE · ANA · amine)
- GMP v3+v4 CMC release evidence

## §6 post-marketing dual-track product

| Product | Track | Indication |
|---|---|---|
| **TTR-MN Standard** | v3 주 1회 × 4.5mo | OTC · cosmetic clinic · 일반 시술 |
| **TTR-MN Express** | v4 격일 × 2mo + LED + TLR7/8 | premium · 빠른 결과 · 비용 ↑ |
| **TTR-MN Color** | v3 색상 잉크 특화 (AzoR-rich) | OTC · 색상 이상 시술 |
| **TTR-MN Wall** | v4 + UV-A LED 강화 (Cu-Pc/Cr₂O₃) | Rx · 어려운 잉크 |

⇒ Phase 2 사용자 선택지 다양화 (의료/cosmetic + 시간/비용 trade-off)

## §7 stop-go decision (v4 launch)

| Phase 1 outcome | Phase 2 path |
|---|---|
| A1+A3 PASS + B3 PASS | **v3 + v4 dual launch** (Standard + Express) |
| A1 PASS · B3 fail (safety) | v3 only (v4 abandon) |
| B3 PASS · A3 fail | v4 only (v3 abandon · less likely) |
| Both partial | dose 재설계 · re-trial |
| Both fail | reconsider Cascade · density · TLR7/8 |

## §8 honest unknowns

- Phase 1 healthy volunteer 모집 (어두운 피부 · 격일 schedule adherence)
- TLR7/8 micro-dose 누적 면역 (Phase 1 시 새 finding 가능성)
- LED 365 nm Fitzpatrick IV-VI 광열 손상 (Phase 1 별 cohort)
- FDA dual-arm IND 첫 시도 (regulatory precedent 부족)
- 5-yr autoimmune incidence (TLR7/8 long-term commitment)
- Phase 1 enrollment 50 = 큰 cohort (recruiting challenge)

## §9 진행 상태

- ✅ v4 measured-oracle 4-component endpoint (efficacy 2mo · safety 6-axis · GMP v4 · regulatory dual-arm)
- ✅ Phase 1 dual-track 8-arm design (v3 A1-A3 + v4 B1-B4 + Placebo A0/B0 · n=52)
- ✅ Timeline 27mo · 비용 ~$1.4M (v3+v4 dual)
- ✅ Atlas absorption v3+v4 dual record schema
- ✅ Post-marketing dual-track product (Standard + Express + Color + Wall SKU)
- ✅ Stop-go matrix (v3 only / v4 only / dual / both fail)
- **TTR-MN v4 path 6/6 milestone all design completed**
- next (별 작업): 실제 lab/CRO execution + funding · FDA pre-IND meeting
