# TTR-MN M10-v3 — measured-oracle PASS endpoint (4.5개월 + 격일 floor)

> milestone: TTR-MN.md "TTR-MN v3 measured-oracle PASS — 4.5개월 timeline absorbed=true (FDA endpoint 정확화)"
> driver: @goal v3 (주 1회 × 4.5mo) + v4 (격일 × 2mo physical floor) 双 path
> base: M10-MN v1 (`TTR/research/m10_mn_measured_oracle.md`) 위 v3 endpoint 정확화

## TL;DR

absorbed=true 조건 v3 — **4-component MeasuredOracleRef** 의 endpoint 정확화 (v1 30일×3cycle → v3 주1회×19cycle 또는 격일×15cycle). FDA pre-IND meeting Type B 자료 v3 — **dose escalation arm 분기** (v3 주1회 arm + v4 격일 arm). IND filing timeline v1 22-24mo → v3 **12mo** (M9 v2 12mo timeline 정합). Phase 1 비용 비슷 ($200-400k).

## §1 v3 measured-oracle 4-component (재정의)

### ① efficacy PASS (v3 endpoint 정확화)

| sub-endpoint | v1 gate | **v3 gate** | 측정 |
|---|---|---|---|
| Removal % cumulative | ≥ 80% (90일 × 3cycle) | **≥ 90% (133일 × 19cycle, 주1회)** | digital RGB + OCT + histology |
| Per-cycle x (mean) | N/A | **10-14%** (synergy 검증) | per-cycle 측정 |
| Cycle 4 (1mo) removal | N/A | ≥ 40% (mid-treatment) | RGB |
| Cycle 9 (2mo) removal | N/A | ≥ 70% | RGB + OCT |
| Cycle 13 (3mo) removal | N/A | ≥ 81% | RGB |
| Cycle 19 (4.5mo) FINAL | ≥ 90% mandatory | **≥ 90% mandatory** | full panel |

⇒ Tier 2b mini-pig pass cohort (M9 v2)

### ② safety PASS (5-tier · v3 정합)

| tier | v1 | v3 |
|---|---|---|
| 1 (immediate) | local 자극 ≤ 1 | 동일 |
| 2 (24-72h PK) | aromatic amine < 10 ng/mL peak | **< 15 ng/mL peak** (격일 시 누적 허용) |
| 3 (Day 7-28) | 콜라겐 ≤ 5% loss · 멜라닌 ≤ 5% (FZ I-III) | 동일 |
| 3 (Day 7-28) | TEWL normal | **TEWL ≤ 10% above baseline** (격일 누적) |
| 3 (Day 7-28) | Macrophage M0/M2 | **M1 ratio ≤ 2× baseline** (cascade-induced) |
| 4 (Day 30-90) | scar within 10% | 동일 |
| 5 (long-term registry) | 멜라노마 ≤ 1.5× | 동일 |

### ③ GMP PASS (CMC v2 release)

v1 spec + v2 추가:
- v2 array (density 1000/cm² · L 1200 · tip 8 μm) dimensional QC within ± 5%
- Triple cascade payload (AzoR + DyP + CeO₂) potency assay each ± 10%
- Trehalose + ascorbate + NADPH lot release
- Sterility USP <71> · endotoxin USP <85>
- **새 spec**: cascade synergy lot-to-lot reproducibility (per-cycle x ± 1.5%)

### ④ regulatory PASS (FDA IND v3/v4)

| step | v1 | v3 |
|---|---|---|
| Pre-IND meeting (Type B) | dev plan agreed | **dose escalation v3/v4 arm 합의** |
| IND Module 5 | Phase 1 protocol single arm | **dose escalation 4 arm (low/mid/high · v3 vs v4)** |
| 30-day FDA review | clinical hold gate | 동일 |
| Phase 1 trial start | clinical site IRB | **dose escalation enrollment 추가** |

## §2 Phase 1 design v3 (dose escalation arm)

| arm | dose | frequency | n | duration |
|---|---|---|---|---|
| **A1 (low · v3)** | 1 cm² × 1 patch | 주 1회 | 6 | 19 cycle (4.5mo) |
| **A2 (mid · v3)** | 1 cm² × 3 patch concurrent | 주 1회 | 6 | 19 cycle (4.5mo) |
| **A3 (high · v3)** | 5 cm² × 1 patch | 주 1회 | 6 | 19 cycle (4.5mo) |
| **B1 (low · v4 floor)** | 1 cm² × 1 patch | **격일** | 6 | 15 cycle (2mo) |
| **B2 (mid · v4)** | 1 cm² × 3 patch | 격일 | 6 | 15 cycle (2mo) |
| **Placebo** | HA-only patch | 주 1회 | 4 | 19 cycle |

⇒ n=34 healthy volunteer · 6 arm · primary endpoint safety + tolerability · secondary efficacy

### 새 endpoint (Phase 1)

- per-cycle RGB delta (real-time efficacy)
- TEWL serial (격일 SC barrier)
- Serum aromatic amine kinetic (Cmax · AUC)
- IgE anti-AzoR / anti-DyP (immunogenicity)
- Optional: 5-year melanoma registry consent

## §3 timeline (M9 v2 → IND → Phase 1)

```
   M9 v2 Tier 2 start (Tier 2a/b/c parallel)
        │
        ▼
   12 mo  Tier 2 결과 + GMP CMC release
        │
        ▼
   13 mo  Pre-IND Type B meeting (FDA · dose escalation 합의)
        │
        ▼
   15 mo  IND filing (Module 1-5 · dose escalation arm 포함)
        │
        ▼
   16 mo  30-day FDA review (clinical hold check)
        │
        ▼
   17 mo  Phase 1 IRB + site setup
        │
        ▼
   18 mo  Phase 1 enrollment start
        │
        ▼
   24 mo  Phase 1 dose escalation 완료
        │
        ▼
   27 mo  ★ absorbed=true (Phase 1 결과 + safety registry)
```

⇒ v1 22-24mo → **v3 18mo IND + 24mo Phase 1** (M9 v2 단축 효과)

## §4 비용 (v3 추가)

| item | v1 | v3 추가 | total |
|---|---|---|---|
| Pre-IND consulting | $30k | +$15k (dose escalation 자료) | $45k |
| IND filing | $50k | +$20k (v3/v4 dual arm) | $70k |
| GMP precursor v2 lot | $80k | +$40k (v2 array + cascade) | $120k |
| Phase 1 (n=34 vs n=24) | $200-400k | +$80k | $280-480k |
| IRB + sites | $50k | 동일 | $50k |
| Statistical (dual arm) | $40k | +$15k | $55k |
| **합계 (IND → Phase 1)** | **$450-650k** | **+$170k** | **$620-820k** |

## §5 atlas absorption v3

```
hexa atlas register --from-measured-oracle \
  --domain TTR-MN \
  --version v3 \
  --record path/to/v3_measured_oracle.json \
  --auto-pr
```

record 내용:
- isMeasuredOraclePASS=true
- v3 timeline 정합 (Tier 2b efficacy ≥ 90% @ 4.5mo)
- v4 floor data (Tier 2c efficacy ≥ 85% @ 2mo · safety wall PASS or fail)
- Phase 1 dose escalation result
- 5-tier safety stacking all PASS
- GMP v2 CMC release evidence

## §6 v3 vs v4 분기 결정 logic (Phase 1 후)

| Phase 1 outcome | post-Phase 2 path |
|---|---|
| A1 (low v3) PASS · B1 (low v4 floor) PASS | **Both arms** to Phase 2 (consumer choice) |
| A1 PASS · B1 fail | **v3 only** to Phase 2 |
| A1 fail · B1 PASS | v3 dose increase 또는 abandon |
| Both fail | reconsider M3 cascade synergy |

→ post-marketing launch: dual-track product
- TTR-MN-Standard (v3 주1회 · 4.5mo)
- TTR-MN-Express (v4 격일 · 2mo · 만약 PASS)

## §7 honest unknowns

- Tier 2c (v4 격일) PASS likelihood 50/50 (SC barrier wall risk)
- Phase 1 dose escalation enrollment (어두운 피부 모집 challenge)
- FDA dose escalation arm 의 IRB ethics review (placebo arm acceptable)
- 5-year melanoma registry funding (post-market commitment)
- Manufacturing v2 yields lot-to-lot reproducibility

## §8 TTR-MN v3 @goal 정확화 (post-Phase 1 시)

```
@goal v3 final (post-clinical 정확화 candidate):
  "self-applied microneedle patch (density 1000/cm² + triple cascade AzoR+DyP+CeO₂)
   로 주 1회 × 4.5개월 누적 잉크 90%+ 제거 — 흉터 없음 · OTC OR Rx combination product
   · measured-oracle PASS (efficacy ≥ 90% · safety 5-tier · GMP · IND accepted)"
```

(post-clinical PASS 시 absorbed=true)

## §9 진행 상태

- ✅ Measured-oracle 4-component v3 endpoint 정확화 (efficacy 4.5mo · safety v3 정합 · GMP v2 · regulatory dual-arm)
- ✅ Phase 1 design v3 (n=34 · 6 arm dose escalation · v3/v4 분기)
- ✅ Timeline v1 22-24mo → v3 18mo IND + 24mo Phase 1
- ✅ 비용 v1 $450-650k → v3 $620-820k
- ✅ Atlas absorption record v3 schema
- ✅ v3 vs v4 분기 결정 logic (post-Phase 1)
- **TTR-MN v3 path 모든 5 milestone design completed (M7-v2 · M3-v2 · M8-v2 · M9-v2 · M10-v3)**
- next (별 작업): 실제 lab/CRO execution funding · FDA pre-IND filing
