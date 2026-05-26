# TTR-MN M9-v2 — in-vivo 격일 cohort protocol (physical floor v4 검증)

> milestone: TTR-MN.md "M9-MN v2 — in-vivo 격일 cohort 별 prerequisite (physical floor v4 검증 · safety 누적 wall)"
> driver: @goal v3 (4.5개월) + v4 (격일 2개월 physical floor) 검증
> base: M9-MN v1 (`TTR/research/m9_mn_in_vivo_protocol.md`) 위 v2 격일 cohort 추가

## TL;DR

3-arm cohort 추가 — Tier 2 mini-pig (M9 v1 baseline) + **Tier 2b 격일 cohort** (v4 floor 검증) + **Tier 2c v3 주1회 cohort** (4.5mo timeline 검증). 격일 cycle 의 SC barrier 누적 손상 · macrophage cycle saturation · aromatic amine clearance 정량. 비용 v2 추가 ~$200k (총 v1+v2 = $550k). Phase 1 dose escalation arm v3/v4 분기 prerequisite.

## §1 3-arm cohort design (v1 + v2 추가)

| arm | frequency | duration | n | timeline | physical 검증 |
|---|---|---|---|---|---|
| **Tier 2a** (v1) | 30일 1회 × 3 cycle | 90일 | 6 | M9-v1 baseline | (이미 design) |
| **Tier 2b** ★ NEW (v3) | 주 1회 × 19 cycle | 133일 (4.5mo) | 6 | v3 timeline 검증 | per-cycle x ≈ 12% |
| **Tier 2c** ★ NEW (v4) | 격일 (3-4일) × 15 cycle | 60일 (2mo) | 6 | v4 physical floor | SC + macrophage + amine clearance |
| **Sham** | HA-only patch (v2 array) | matched | 4 | control | baseline |
| **Untreated** | no patch | matched | 4 | control | natural fade |

⇒ 총 26 mini-pigs (Yucatan) · 4 cohort.

## §2 v2 endpoint 추가 (Tier 2b/c)

### Tier 2b (v3 주 1회 · 133일)

| timepoint | endpoint |
|---|---|
| Day 7 (cycle 1) | RGB delta · per-cycle x measurement |
| Day 30 (cycle 4) | RGB · IHC biopsy · LC-MS aromatic amine |
| Day 60 (cycle 9) | mid-treatment safety · IHC mel/col |
| Day 90 (cycle 13) | RGB · 누적 ~81% target |
| Day 133 (cycle 19) | ★ FINAL: RGB · histology · multiphoton SHG · cutometer · 누적 ≥ 90% |

### Tier 2c (v4 격일 · 60일)

| timepoint | endpoint |
|---|---|
| Day 4 (cycle 1) | per-cycle x |
| Day 14 (cycle 4) | SC barrier 누적 손상 모니터링 (TEWL · 전기저항) |
| Day 28 (cycle 8) | macrophage saturation 검증 (IHC F4/80 · CD68 cycling) |
| Day 42 (cycle 12) | aromatic amine serum 누적 (LC-MS Cmax) |
| Day 60 (cycle 15) | ★ FINAL: 누적 ≥ 90% · SC TEWL · 면역세포 정상 |

## §3 격일 (v4) safety 누적 검증 — 핵심 wall

### SC barrier 누적 손상

```
   measurement: TEWL (transepidermal water loss · g/h/m²)
   baseline: 5-10 g/h/m² (healthy)
   single MN puncture: 15-20 g/h/m² (24h) → 회복 5-7 g/h/m² (72h)
   격일 cycle (cycle interval = 72-96h):
     - 누적 시 baseline 위 5-10% 상승 허용 (정상 회복)
     - > 50% 상승 시 fail-fast (격일 too frequent)
```

### Macrophage cycle saturation

```
   marker: F4/80 (mouse · IHC) + CD68 (human-like)
   baseline: M0 polarization
   single cycle: M2 anti-inflammatory (ink uptake)
   누적: M1 ↑ (inflammation) — over-frequent 시
   gate: M1 marker ≤ 2× baseline at Day 60
```

### Aromatic amine clearance

```
   serum LC-MS Cmax + AUC
   single cycle peak: ~5 ng/mL @ 24h
   격일: Cmax 누적 ≤ 15 ng/mL · clearance OK
   fail: > 50 ng/mL (M6 toxicokinetics red flag)
```

## §4 success / fail gate (M10 v3 진입 조건)

### Tier 2b (v3 4.5mo) gate

| metric | gate | fail |
|---|---|---|
| 누적 removal % (Day 133) | ≥ 90% | < 80% |
| Per-cycle x mean | 10-14% | < 7% (synergy 약함) |
| SC TEWL Day 133 | normal | > 30% above baseline |
| 멜라닌 (Fontana-Masson) | ≤ 5% loss | ≥ 15% |
| 콜라겐 (SHG · cutometer) | within 10% | scar/atrophy 감지 |
| 부산물 serum 누적 | OK | aromatic amine > 50 ng/mL |

### Tier 2c (v4 2mo physical floor) gate

| metric | gate | fail |
|---|---|---|
| 누적 removal % (Day 60) | ≥ 85% | < 70% |
| SC TEWL 누적 | ≤ 10% above baseline | > 30% |
| Macrophage M1 ratio | ≤ 2× baseline | ≥ 3× (over-inflammation) |
| Aromatic amine Cmax | ≤ 15 ng/mL | > 50 ng/mL |
| **Tier 2c PASS** | → v4 viable | v4 abandon · v3 only |

### Stop-go (M10 v3 IND filing)

- **Tier 2b PASS + 2c PASS** → both v3 and v4 path (dose escalation arm)
- **Tier 2b PASS only** → v3 only IND (v4 별 R&D)
- **Tier 2b fail + 2c PASS** → reconsider (cascade synergy 문제)
- **Tier 2b fail + 2c fail** → revisit M7/M3 v2 design

## §5 비용 (v2 추가)

| 항목 | $ |
|---|---|
| 12 추가 mini-pig (Tier 2b/c) + housing extended | 50,000 |
| v2 MN patches (~700 patches · GMP) | 25,000 |
| Triple cascade payload (lot release) | 18,000 |
| TEWL device + SHG + cutometer | 15,000 |
| LC-MS multi-timepoint × 12 pigs | 30,000 |
| IHC + Fontana-Masson + F4/80 | 25,000 |
| CRO management v2 | 35,000 |
| **v2 추가 비용** | **~$198,000** |
| **v1 + v2 in-vivo 합계** | **~$548,000** |

(M9 v1 = $350k · v2 추가 = $198k)

## §6 timeline (실제 lab 실행)

| step | duration |
|---|---|
| IACUC v2 amendment (3 arm 추가) | 2 mo |
| GMP batch (v2 patches + lot release) | 3 mo |
| Tier 2a + 2b + 2c parallel run | 4.5 mo (v3) + 2 mo (v4) |
| Histology · LC-MS · SHG analysis | 3 mo |
| **합계 (M10 진입까지)** | **~12 mo** (v1 baseline 18mo 대비 단축) |

## §7 risks + mitigations (v2 specific)

| risk | likelihood | mitigation |
|---|---|---|
| 격일 SC TEWL 누적 wall | high | Tier 2c interim 종료 (Day 28 mid-check) · early stop |
| Macrophage M1 inflammation 누적 | mid-high | imiquimod anti-counter (TLR7 modulator 추가) · 별 R&D |
| Aromatic amine serum 누적 (격일) | mid | ascorbate intra-patch boost · scavenger 적층 |
| Triple cascade in vivo 안정성 | mid | M5-MN v2 GPU MD (cascade ternary · 검증 별 cohort) |
| Mini-pig species translation | low | allometric scaling + human dermis 비교 별 |
| GMP batch failure | low-mid | back-up lot · CDMO Vaxxas dual source |

## §8 M10 v3 handoff

다음 milestone (TTR-MN v3 measured-oracle PASS) 가 받는 입력:
- Tier 2b efficacy data (v3 4.5mo 검증)
- Tier 2c efficacy + safety data (v4 floor 검증)
- 5-tier safety stacking 결과 (immediate · 24-72h · Day 7-28 · Day 30-90 · 5yr registry)
- GMP CMC release · IND Module 3 (Quality)
- FDA pre-IND meeting 자료 (dose escalation arm v3/v4 분기)

## §9 honest unknowns

- Macrophage M1/M2 in vivo cycling (격일 frequency)
- TEWL 정확 누적 threshold (50% 추정)
- Aromatic amine 50 ng/mL 안전 cutoff 정확화 (FDA precedent 부족)
- v4 격일 mini-pig acceptance (handling stress)
- Compressed timeline (4.5mo Tier 2b vs human 5+ yr) translation factor

## §10 진행 상태

- ✅ 3-arm cohort design (Tier 2a/2b/2c) · 26 mini-pigs
- ✅ v3 timeline 검증 (Tier 2b · 4.5mo · 19 cycle)
- ✅ v4 physical floor 검증 (Tier 2c · 2mo · 15 cycle 격일)
- ✅ Safety 누적 wall 검증 (TEWL · macrophage M1 · aromatic amine)
- ✅ Stop-go matrix (v3 only / v3+v4 / abandon)
- ✅ 비용 +$198k · M9 합 $548k · timeline 12mo
- ✅ M10 v3 handoff
- next: TTR-MN v3 measured-oracle PASS endpoint (FDA pre-IND v3/v4 분기)
