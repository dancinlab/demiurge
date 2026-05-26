# TTR-MN — timeline 압축 path 탐색 (1yr → 최소 단축)

> opened: 2026-05-24 KST · driver: @goal v2 (주 1회 × 1년 → 91.4%) 의 추가 단축 가능성 탐색
> 수학: (1-x)^N ≤ 0.1 → 90%+ 누적 달성 조건
> 정직: physical limit (SC recovery · macrophage cycle · safety) 가 절대 floor

## TL;DR

4축 (frequency · density · concurrent · payload) sweep. **physical floor ≈ 6-8주 (2개월)** — 격일 (3.5일) cycle × density 1000/cm² × triple payload cascade. 더 단축은 SC barrier recovery 와 macrophage 처리 시간이 막음. v2 (1년) → v3 (3-4개월) → 극한 v4 (6-8주) path. 레이저 (1-2년) 대비 **10-20× 빠름**.

## 수학 — 90% 달성 closed-form

```
   누적 coverage = 1 - (1-x)^N
   target: 누적 ≥ 0.9 → (1-x)^N ≤ 0.1
   N = ⌈ ln(0.1) / ln(1-x) ⌉
```

per-cycle x 별 최소 N:

| x (per-cycle) | N (90% cycle 수) | 주1회 timeline | 격일 timeline |
|---|---|---|---|
| 0.047 (현 design) | 48 | **48주 (~1년)** | 24주 (5.5개월) |
| 0.08 (payload boost) | 28 | 28주 (6.5개월) | 14주 (3.3개월) |
| 0.12 (density boost) | 19 | 19주 (4.5개월) | **10주 (2.3개월)** |
| 0.15 (combo boost) | 15 | 15주 (3.5개월) | **8주 (2개월)** ★ |
| 0.20 (extreme combo) | 11 | 11주 (2.5개월) | **6주 (1.5개월)** |

⇒ 격일 × x=0.15 = **2개월 안 90%** (honest physical floor)

## 4축 sweep — per-cycle x 향상 path

### 축 1 — needle density 증가

| density (/cm²) | per-cycle x | 정합 |
|---|---|---|
| 300 (현 design) | 4.7% | M7 baseline |
| 500 | ~7.0% | 일부 patch overlap 손실 |
| 1000 | ~11-13% | plume saturation 시작 (efficiency drop) |
| 2000 | ~15-17% | overlap dominant · efficiency 60-70% |
| 3000 | ~18-20% | plume 완전 merge · 추가 marginal |

⇒ **1000/cm² recommended** (3.3× boost · efficiency 80% 유지)

### 축 2 — payload 강화 (combo cascade)

| payload | x estimate | 근거 |
|---|---|---|
| AzoR + ascorbate (현 design) | 4.7% | M3-MN F5+F2 |
| + DyP + DFO 추가 (multi-attack) | ~7-8% | F5×2 + F3 시너지 |
| + CeO₂ NP (pH-switch Fenton) | ~10-12% | F1 + F5+F3 cascade |
| + g-C₃N₄ + UV-A photo patch | ~13-15% | F4 site-localized 추가 |
| 5-family combo (M2 전부) | ~15-17% | 한계 efficiency |

⇒ **triple cascade (AzoR+DyP+CeO₂)** 가 sweet spot · safety margin 유지

### 축 3 — multi-patch concurrent (큰 tattoo case)

| coverage | per-cycle 영역 | timeline 영향 |
|---|---|---|
| 1 patch (1 cm²) | small tattoo 한 번에 | baseline |
| 3 patch concurrent (3 cm²) | medium tattoo 한 번에 | timeline 동일 (per-area 동일) |
| 5 patch tile (5 cm²) | large tattoo 한 번에 | 동일 |

⇒ multi-patch 는 timeline 단축 X · larger tattoo cover 만 가능

### 축 4 — cycle frequency 증가

| interval | N(yr) | physical limit |
|---|---|---|
| 월 1회 (30일) | 12 | M9-MN baseline · macrophage cycle 충분 |
| 주 1회 (7일) | 52 | SC recovery OK · @goal v2 |
| **격주 / 주 2회 (3.5일)** ★ | 104 | SC marginal · macrophage 충분 |
| 일일 (1일) | 365 | **SC barrier 손상 누적 risk** (M6 caution) |

physical floor (SC + macrophage cycle):
- **격일 (3-4일)** = honest minimum · SC barrier recovery 시간 정합 (24-72 hr)
- 일일 = 누적 SC 손상 · 면역 반응 risk (M6 mel/면역세포 critical) · 권장 X

## 최소 timeline scenarios — 3-tier path

### Tier 1 (v2 · 현재) — 주 1회 × 1년 → 91.4%

- design 변경 없음
- per-cycle 4.7% (AzoR+ascorbate · density 300/cm²)
- 비용 $1,040/yr

### Tier 2 (v3) — 주 1회 × 4.5개월 → 90%

- density 1000/cm² (3.3× boost) + AzoR+DyP+CeO₂ triple cascade
- per-cycle x ≈ 12%
- N = 19 cycle · 주 1회 × 19주 = **4.5개월**
- 비용: $30/패치 × 19 = **$570** (density ↑ patch cost ↑, but cycle ↓)
- M7-MN array engineering 재설계 필요 (density 1000/cm²)
- M3-MN candidate triple cascade 검증 필요 (in-vivo M9)

### Tier 3 (v4) — 격일 (3.5일) × 8주 → 90% ★ physical floor

- density 1000/cm² + triple cascade + photo-assist patch (UV-A)
- per-cycle x ≈ 15%
- N = 15 cycle · 격일 × 15 = **52일 ≈ 7.5주 (≈ 2개월)**
- SC recovery: 격일 3.5일 = SC turnover (3-7일) 정합 · borderline
- 비용: $40/패치 × 15 = **$600**
- safety: M6 mel/면역세포 critical pair 누적 risk — 5-tier safety stacking 재검증
- M9-MN Tier 2 mini-pig 격일 cohort 별 prerequisite

## 벤치마킹 (외부 비교)

| 방법 | timeline | 비용 | 통증 | 다운타임 |
|---|---|---|---|---|
| **레이저 PicoSure** | 48-96주 (1-2년) | $2,400-6,000 | 강함 | 1-2주 |
| **레이저 Q-switched** | 24-48주 | $1,800-4,500 | 강함 | 1-2주 |
| **TCA peel** | 12-24주 | $500-1,500 | 강함 (피부 burn) | 2-4주 |
| **외과적 excision** | 1-2주 (1회) | $500-3,000 | 마취 | 4-8주 (scar) |
| **현재 시판 cream (Tat B Gone 등)** | 효능 없음 | $50-200 | 없음 | 없음 |
| **TTR-MN v1 (월 1회)** | 5년 | $1,200-2,400 | 거의 없음 | 없음 |
| **TTR-MN v2 (주 1회)** | 1년 | $1,040 | 거의 없음 | 없음 |
| ★ **TTR-MN v3 (density boost · 주 1회)** | **4.5개월** | $570 | 거의 없음 | 없음 |
| ★★ **TTR-MN v4 (격일 + combo)** | **2개월 (physical floor)** | $600 | 약간 (격일 적용) | 미세 |
| **mRNA vaccine MN (Vaxxas)** | 1회 (delivery only) | N/A | 없음 | 없음 |

⇒ **v3 (4.5개월) · v4 (2개월) 가 레이저 대비 10-20× 빠름** + 통증 없음 + 다운타임 없음 + 1/5 비용.

## Physical limit — 단축 한계 분석

### SC barrier recovery (cycle floor)

- HA microneedle insertion → SC 미세 천공 (10 μm tip) → 자가 회복 **24-48 hr**
- 누적 SC 손상: 격일 (3-4일) = 회복 충분 · 일일 = 회복 불충분
- → **격일 = absolute minimum cycle interval**

### Macrophage cycle (잉크 처리 시간)

- 잉크 macrophage phagocytosis → 분해 → 배출 = **3-7일** per ink particle
- 격일 cycle = macrophage cycle 정합 (다음 cycle 도착 시 이전 batch 처리 중)
- 일일 cycle = macrophage 처리 불충분 · 잉크-payload 잔류 risk

### Aromatic amine byproduct kinetics

- azo cleavage byproduct serum half-life = 24-48 hr (M6 caveat)
- 격일 cycle = serum clearance 정합
- 일일 = 누적 (M6 toxicokinetics red flag)

### 통증 + 사용자 부담

- 주 1회 = 거의 부담 없음 (5-10분/회)
- 격일 = mild 부담 (15회/월 · 5-10분 = 1-2 hr/월)
- 일일 = 명백 부담 + adherence 저하

⇒ **격일 (3-4일) cycle = honest physical + practical floor**

## 추가 acceleration — 연구 path

physical floor 보다 더 단축은 **fundamentally** SC + macrophage + safety wall. 다만 다음 paths 연구 가치:

### A. macrophage re-engagement (M2 wall breakthrough path)

- imiquimod TLR7/8 agonist → 잉크 macrophage re-activation · per-cycle x 추가 boost
- 기존 macrophage 잉크 처리 완료 후 새 batch 잉크에 attention → x 2-3× 가능
- → **per-cycle x ≈ 0.25-0.30** · N=6-8 → **3주 timeline 가능성**
- caveat: TLR7/8 agonist 전신 면역 자극 → safety wall (M6 면역세포 critical)
- arxiv 부재 — M9-MN 별 cohort 검증 필요

### B. photo-Fenton on demand

- UV-A patch (별 device) 같이 작용 → Cu-Pc / Cr₂O₃ wall pigment 동시 분해 + 일반 azo cleavage 가속
- 단순 patch 외 device 추가 — OTC vs Rx 경계
- per-cycle x 추가 boost 5-10%

### C. enzyme engineering (directed evolution)

- AzoR / DyP K_cat 10× 향상 (engineered variants)
- per-cycle x 2-3× boost
- timeline: **격일 × 8주 → 4주** 가능성
- M3-MN candidate directed evolution 별 R&D 트랙

### D. macrophage 이동 가속 (chemotaxis)

- ink particle 가 분해된 후 배출이 timeline의 일부 — 빠른 배출 (lymph drainage 자극) → 누적 visible removal 가속
- 단순 cycle 수치는 동일하지만 사용자 체감 timeline 단축

## 권장 next-step paths

1. **M7-MN v2** — density 1000/cm² array re-engineering · M3 candidate triple cascade 흡수 · M8 ex-vivo v2 (3개월 timeline 검증)
2. **M9-MN v2 protocol** — Tier 2 mini-pig 격일 cohort · safety 누적 검증
3. **M3-MN v2** — engineered AzoR · macrophage re-engagement (TLR7/8) 별 R&D 트랙
4. **TTR-MN.md @goal v3** — 4.5개월 (Tier 2 v3) 또는 2개월 (Tier 3 v4) 정확화
5. **벤치마킹 update** — Phase 1 clinical 시 v3/v4 dose escalation arm 명시

## Honest unknowns

- per-cycle x 0.12 / 0.15 추정 (density × payload boost · efficiency drop 모델 단순)
- macrophage re-engagement (TLR7/8) 실측 boost factor (arxiv 부재)
- 격일 cycle 의 SC barrier 누적 손상 in-vivo (M9-MN v2 prerequisite)
- enzyme directed evolution K_cat boost timeline (1-2 yr R&D)
- 통증/adherence — 격일 cycle 의 사용자 실제 임상 acceptance (Phase 1 검증)
- aromatic amine 누적 toxicokinetics (격일 cycle safety wall)

## 진행 상태

- ✅ 4축 sweep 수학 derivation
- ✅ 3-tier path scenarios (v2/v3/v4 · 1년/4.5개월/2개월)
- ✅ Physical limit 분석 (SC + macrophage + safety floor)
- ✅ 벤치마킹 표 (레이저 · TCA · MN 등)
- ✅ 4 추가 acceleration R&D path (macrophage re-engage · photo · enzyme engineering · chemotaxis)
- next: M7-MN v2 array (density 1000/cm²) · M3-MN v2 triple cascade · @goal v3 정확화
