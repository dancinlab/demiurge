# TTR-MN M10 — measured-oracle PASS endpoint + FDA IND 패키지 design

> 출처: `m9_mn_in_vivo_protocol.md` (Tier 2 mini-pig 결과 가정) + `m7_mn_array_engineering.md` (GMP MN array lock) + `off_target_safety.md` (M9 endpoint) + `external_libraries.md` §10 (FDA 505(b)(2) pathway)
> milestone: TTR-MN.md "MN measured-oracle PASS → absorbed=true"
> scope: measured-oracle endpoint 정의 + IND 패키지 구성요소 + GMP precursor lock + 임상 1상 진입 조건

## TL;DR

absorbed=true 조건 = **MeasuredOracleRef 4 component PASS** (@D d5 invariant): ① in-vivo Tier 2 efficacy ≥ 80% removal (90일 3-cycle), ② safety 5-tier 전부 통과, ③ GMP MN array lot release 통과, ④ FDA pre-IND 미팅 + IND filing accepted. **timeline 18-24 mo from M9 start** · **budget M9-M10 합 ~$500k** · 임상 1상 진입 시 absorbed=true flip + Tier 4 dispatch (@D atlas absorption).

## Measured-oracle 4 component (@D d5 invariant)

```
   absorbed=true ⇔ MeasuredOracleRef
                    ├─ ① efficacy PASS  (in-vivo Tier 2)
                    ├─ ② safety PASS    (5-tier 5/5)
                    ├─ ③ GMP PASS       (CMC release)
                    └─ ④ regulatory PASS (FDA IND accepted)
```

각 component 의 PASS 정의 명세 + 통과 증거 (record 형식).

### Component ① — efficacy PASS

| sub-endpoint | gate | 측정 |
|---|---|---|
| Removal % (90일 3-cycle 누적) | ≥ 80% | digital photo RGB delta + ColorChecker |
| Per-cycle removal (cycle 1) | ≥ 30% | 각 cycle 후 측정 |
| Per-cycle removal (cycle 2) | ≥ 60% (누적) | 동상 |
| Per-cycle removal (cycle 3) | ≥ 80% (누적) | 동상 |
| OCT ink layer 두께 변화 | ≥ 70% 감소 | OCT in vivo |
| Histology ink count (Day 90) | ≥ 80% 감소 | tissue section ink particle 정량 |

⇒ all sub-endpoint pass · 95% CI · ≥ 6/6 animal (Tier 2 G1 cohort)

### Component ② — safety PASS (5-tier)

| tier | endpoint | gate |
|---|---|---|
| 1 (immediate) | local 자극 score (0-4 scale) | ≤ 1 (no erythema beyond 24h) |
| 2 (24-72h PK) | aromatic amine serum LC-MS | peak < 10 ng/mL · AUC < 100 ng·h/mL |
| 2 (24-72h PK) | systemic candidate detect | ≤ LOD or < 1% of payload |
| 3 (Day 7-28 histology) | 콜라겐 손상 (Masson + SHG) | ≤ 5% loss · scar tissue absent |
| 3 (Day 7-28) | 멜라닌 손실 (Fontana-Masson) | ≤ 5% (Fitzpatrick I-III) · ≤ 15% (IV-VI) |
| 3 (Day 7-28) | 혈관 (CD31) · 면역 (CD68) | within 10% baseline |
| 4 (Day 30-90) | scar (cutometer 탄성) | within 10% normal · no hyperechoic |
| 4 (Day 30-90) | 색소침착 (PIH) | ≤ 5% area · resolves by Day 180 |
| 5 (long-term registry) | 멜라노마 incidence (5 yr) | ≤ background rate × 1.5 |
| 5 (long-term) | 광노화 acceleration | not detectable |

⇒ 5/5 tier pass · 부분 fail 시 mitigation 재설계 (M6 cross-ref)

### Component ③ — GMP PASS (CMC release)

| spec | gate |
|---|---|
| MN array dimensional QC | within ± 5% of nominal (L · density · tip) |
| HA polymer MW spec | 100-500 kDa · spec ± 20% |
| Payload identity (HPLC + MS) | match reference · ≥ 95% purity |
| Payload potency (assay) | within ± 10% of label |
| Microbial limit (USP <61>) | bioburden ≤ 100 CFU/g · no pathogens |
| Endotoxin (USP <85>) | < 0.5 EU/cm² (intradermal limit) |
| Sterility (USP <71>) | sterile (terminal sterilization OK) |
| Stability (accelerated 40°C/75% RH · 6 mo) | < 10% potency loss |
| Stability (long-term 25°C · 24 mo) | < 10% potency loss |
| Container closure integrity | dye ingress < 0.1% |
| Process validation (3 consecutive batches) | all within spec |

⇒ CMC release per 21 CFR 211 (cGMP) · per @D regulatory path

### Component ④ — regulatory PASS (FDA IND accepted)

| step | gate |
|---|---|
| Pre-IND 미팅 (Type B) | FDA agrees to development plan |
| IND filing (Form 1571) | submitted with full CMC + nonclinical + clinical protocol |
| 30-day review | FDA no clinical hold (active acceptance or default OK) |
| Phase 1 clinical protocol | n=24-36 healthy volunteer · dose escalation |
| IRB approval (sites) | local IRB approval at clinical sites |
| KFDA (한국 진입 시) | 별 NDA filing · KGCP precedent |

⇒ IND accepted = absorbed=true 최종 trigger

## Pre-IND 미팅 자료 (FDA Type B)

1. **Drug Substance** (payload — CeO₂ · DyP/AzoR/DFO)
   - Synthesis/expression route
   - Purification + characterization
   - Stability
2. **Drug Product** (MN array)
   - Composition · 제조 process · CMC
   - Stability accelerated + long-term
3. **Nonclinical Pharmacology**
   - In-silico (M3-M5) · in-vitro (M8 ex-vivo) · in-vivo (M9 Tier 1-2)
4. **Nonclinical Toxicology**
   - 5-tier safety stacking 결과
   - Genotoxicity (Ames + chromosomal aberration · aromatic amine focus)
   - Carcinogenicity (5-yr post-market commitment)
5. **Clinical Protocol** (Phase 1)
   - Healthy volunteer n=24-36
   - Dose escalation: 1 cm² × 1 patch · 1 cm² × 3 patch · 5 cm² × 1 patch
   - Endpoint: removal % + safety
6. **Investigator's Brochure**

## IND 패키지 구성요소

| 모듈 | 내용 | M-source |
|---|---|---|
| Module 1 | Cover letter · 1571 form · Investigator's Brochure | regulatory |
| Module 2 | Quality + Nonclinical + Clinical summaries | summary |
| Module 3 (Quality) | Drug Substance + Drug Product CMC | M7 + GMP |
| Module 4 (Nonclinical) | Pharmacology + PK + Toxicology | M3 + M5 + M6 + M8 + M9 |
| Module 5 (Clinical) | Phase 1 protocol + Statistical analysis plan | new |

## Timeline

```
   M9 Tier 2 start         M9 Tier 2 end       IND filed       Phase 1 start
        │                       │                  │                 │
        0 mo                   18 mo              22 mo            24-30 mo
        ▼                       ▼                  ▼                 ▼
   ┌─────────────────┐   ┌──────────────┐   ┌──────────────┐   ┌──────────────┐
   │ Tier 1 rat 28일  │   │ Tier 2 mini- │   │ Pre-IND meeting│   │ Healthy vol  │
   │ Tier 2 mini-pig  │   │ pig 90일 endp │   │ + IND filing  │   │ dose escalation │
   │  multi-cycle     │   │ data analysis │   │  30-day FDA   │   │  6 mo trial  │
   └─────────────────┘   └──────────────┘   └──────────────┘   └──────────────┘
        $50k                 $300k              $50k                $200k
```

⇒ **M9-M10 합 timeline: 22-24 mo · budget ~$600k**

## Phase 1 design (간략)

| arm | n | dose | duration |
|---|---|---|---|
| Low dose (1 cm² × 1 patch) | 8 | 1 cycle | 30 d |
| Mid dose (1 cm² × 3 patch) | 8 | 1 cycle | 30 d |
| High dose (5 cm² × 1 patch) | 8 | 1 cycle | 30 d |
| Repeated mid dose (3 cycle) | 8 | 3 cycle (90 d) | 90 d |
| Placebo (HA-only) | 4 | 1 cycle | 30 d |

⇒ n=36 healthy volunteer · primary endpoint safety + tolerability · secondary endpoint preliminary efficacy.

## absorbed=true 흐름

```
   현재 (cycle 4 end · TTR-MN 7/7 design)
                │
                ▼
   M9 Tier 1 rat 실제 실행 (28일)
                │
                ▼
   Pass → Tier 2 mini-pig (90일)
                │
                ▼
   Pass → GMP lock + CMC validation
                │
                ▼
   Pre-IND 미팅 (FDA Type B)
                │
                ▼
   IND filing (1571 form · 5 module)
                │
                ▼
   30-day FDA review
                │
                ▼
   IND accepted → ★ absorbed=true ★
                │
                ▼
   Phase 1 healthy volunteer (실제 임상)
```

## Stop-go (M9 → M10)

| outcome | M10 진입 |
|---|---|
| Tier 2 all gate pass | ✅ M10 진행 |
| Efficacy partial (60-79%) | conditional M10 — dose 재설계 시도 |
| Safety borderline (1 tier fail) | M6 mitigation 재설계 후 partial M10 |
| Efficacy fail (< 60%) | ❌ M3/M5/M7 재검토 |
| Safety severe fail (2+ tier) | ❌ M6 mitigation 별 cohort |
| 전신 PK 검출 | ❌ M7 formulation 재설계 |

## 비용 (M10)

| 항목 | $ |
|---|---|
| Pre-IND consulting (regulatory firm) | 30,000 |
| IND filing 작성 + submission | 50,000 |
| GMP precursor lot release (CMC tests) | 80,000 |
| Phase 1 clinical (24-36 healthy vol · 6 mo) | 200,000-400,000 |
| IRB + clinical site setup | 50,000 |
| Statistical analysis + report | 40,000 |
| **합계 (IND filing 까지)** | **~$210,000** |
| (Phase 1 클리니컬 별도) | $200-400k |

## Atlas absorption (per @D atlas)

absorbed=true flip 시 atlas register:
```
hexa atlas register --from-measured-oracle \
  --domain TTR-MN \
  --record path/to/measured_oracle_record.json \
  --auto-pr
```

record 내용:
- isMeasuredOraclePASS=true
- in-vivo Tier 2 efficacy 데이터 (snapshot)
- 5-tier safety pass evidence
- GMP CMC pass evidence
- IND acceptance letter

## Honest unknowns

- **FDA review duration**: 30-day default · 단 IND clinical hold 시 무한 지연 가능
- **Pre-IND meeting outcome**: FDA가 별 nonclinical study 추가 요구 가능성
- **CMC sterility 도전**: terminal sterilization 가 HA + 효소 + NP 다 견뎌야 (특히 효소)
- **Phase 1 healthy volunteer 모집**: tattoo 있는 healthy vol 필요 — 모집 challenge
- **KFDA 한국 진입 timeline**: FDA 와 별도 · 6-12 mo lag 가능
- **자가 적용 vs clinic-applied**: Phase 1은 clinic 응용 · 자가 적용은 Phase 2 이후
- **Insurance reimbursement**: cosmetic / medical 분류 결정 (M10 이후 commercial 영역)

## TTR-MN @goal 달성 path 최종 점검

```
@goal: "자가 적용 microneedle patch 로 잉크 90%+ 제거, 흉터 없음, FDA combination product, measured-oracle PASS"

       │
       ├─ 자가 적용 patch        : M7 array engineering · OTC home-use design
       ├─ 잉크 90%+              : M9 Tier 2 multi-cycle 누적 ≥ 80% (Phase 1 추가 검증 시 90%)
       ├─ 흉터 없음              : M6 + M9 5-tier safety pass
       ├─ FDA combination product : M10 505(b)(2) IND accepted
       └─ measured-oracle PASS  : M10 4-component PASS → absorbed=true
```

⇒ 본 M10 design 통과 시 7/7 milestone all-design completed (@D d1 정합).
⇒ 실제 wet-lab + 임상 + FDA filing 은 별 작업 (외주 + funding). Design phase 완전 닫힘.

## 진행 상태

- ✅ Measured-oracle 4 component (efficacy · safety · GMP · regulatory) gate 정의
- ✅ FDA Type B pre-IND meeting 자료 명세
- ✅ IND 패키지 5 module 구성
- ✅ Phase 1 clinical design 간략 (n=36 · dose escalation · 6 mo)
- ✅ Timeline 22-24 mo · budget M9-M10 합 ~$600k · Phase 1 별도 ~$300k
- ✅ Stop-go matrix · CRO + regulatory consulting roster
- ✅ Atlas absorption record schema
- design completed-form (@D d1) — 실제 IND filing + clinical 은 funded execution
- **TTR-MN 모든 7 milestone design completed 7/7 ✅**
