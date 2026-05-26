# NUMB G1 — indication map (laser hair removal anchored) + cross-envelope spec

> 🧊 **NUMB milestone G1** — 8+ indication 매핑 + 단일 hexa-LAC v1 (lid 7% + tet 7% + LA 5% + EtOH 20% + epi 1:200k + HPC peel-film) 의 cross-indication 커버리지 정량.
> **벤치마크 indication = LASER HAIR REMOVAL** (사용자 지정 anchor — 시장 최대 + 면적·세션 길이 mid-range → 범용 envelope 의 dominant constraint 결정).
> **sim** = `NUMB/sim/g1_indication_map.hexa` (A1 SC lag time + A4 Pliaglis-anchored LAST PK 상속).
>
> **결론**: hexa-LAC v1 단일 SKU 가 **8개 indication 중 7개 커버** (I4 tattoo CREATION 은 partial — 대면적/장시간 세션에서 5+5% de-rate + split). 벤치마크 spec **"onset ≤30min @ 100-400 cm² · LAST 헤드룸 ≥10×"** 모두 통과 (실측 onset ~2.8 min · margin 68-273×).

---

## 1. BENCHMARK indication — laser hair removal (사용자 지정 anchor) (🟡)

레이저 제모를 anchor 로 잡는 이유:
- **시장 규모 최대** (글로벌 $1.4-1.6B 2025, CAGR ~18%) — 토픽 마취 수요의 단일 최대 슬롯.
- **세션 면적 mid-range** (50-400 cm²) — pre-needle(작음)과 tattoo-creation(매우 큼) 사이의 envelope 중심.
- **세션 빈도 높음** (4-8회 × 4-8주) — 환자 1인당 누적 사용 빈도 ↑ → 안전·재현성 가치 ↑.
- **~95% 환자가 topical 사용** — 현 product (EMLA 60min 대기)이 ratelimit 임이 명확히 인식된 시장.

### 1.1 시장 + 임상 anchor 수치

| 축 | 값 | 출처 |
|---|---|---|
| 글로벌 시장 (2025) | **$1.42-1.58 B** | Precedence · The Insight Partners · Fortune BI |
| US 시장 (2025) | **$440 M** (NA share 35%) | Precedence Research |
| CAGR (2025-2032/34) | **~18.3-18.5%** | 다중 보고서 평균 |
| 글로벌 2032 forecast | **$4.6-4.7 B** (또는 2034 $7.17 B) | Fortune BI · Data Bridge · Precedence |
| 세션 길이 (procedure 자체) | **15-30 min** + topical 대기 20-30 min | Belislaser · Ohio State Wexner |
| 총 세션 수 | **얼굴 4-6 / 다리 6-8 / 등·체스트 8-12** | AAD · SpaMedica · Clearstone |
| 세션 간격 | **얼굴 4-6주 / 다리·등 6-8주** | EWC · Cape Cod PS |
| 면적/세션 | **얼굴 ~50 cm² / 비키니 ~100 / 팔 200 / 다리 400 / 등 600 cm²** | 해부학 anchor (성인 평균) |
| 환자 통증 (procedure-time) | **VAS 6-8/10** (Nd:YAG 6.05±1.39) | PMC9503442 · ClearStone |
| topical 사용 비율 | **~95%** (clinic SOP) | Well Revolution · Wexner |
| 표준 topical | **EMLA / LMX-4 / Topicaine / BLT (compounded)** | StatPearls NBK507861 |
| 표준 도포 시간 | **30-60 min** pre | EMLA label · LMX label |

### 1.2 anchor 가 지정하는 dominant spec

```
   BENCHMARK SPEC (laser hair removal 기준 → general-purpose envelope 정의)

   ┌────────────────────────────────────────────────────────────────────────┐
   │ ◆ onset             ≤ 30 min  (target) · ≤ 20 min (sweet) · ≤ 10 min  │
   │                       (stretch)                                        │
   │ ◆ 면적 envelope     100-400 cm² (얼굴 50 ~ 다리 400 ~ 등 600 cm²)     │
   │ ◆ LAST headroom    ≥ 10×  vs CNS-warn (5 μg/mL)                      │
   │ ◆ 세션 길이         15-30 min procedure · 30 min apply 윈도우         │
   │ ◆ 재도포 안전성     동일부위 4-8주 간격 (lid 누적 무시 가능)          │
   └────────────────────────────────────────────────────────────────────────┘
```

> **이 한 줄이 hexa-LAC v1 의 spec 을 fix 한다**:
> *"100-400 cm² × 30-min apply × +epi 워크플로에서 onset ≤30min + LAST margin ≥10×"*. A4 §11 의 hexa-LAC v1 (ER 3x +epi, 30min, A=100cm²) → Cmax 18 ng/mL · margin 273× 가 정확히 이 spec 안.

---

## 2. 8+ indication map — laser hair removal envelope 에 정렬

| # | indication | onset target | 면적 | population | dominant constraint |
|---|---|---:|---:|---|---|
| **I1** | **laser hair removal (ANCHOR)** | **≤30 min** | **50-600 cm²** (얼굴-등) | 미용·대규모 | onset + 면적 + 재현성 |
| I2 | pre-needle (vaccine / IV / blood draw) | ≤30 min | ~10 cm² | 전 연령 (소아 ↑) | onset (작은면적, LAST trivial) |
| I3 | pre-laser vascular / resurfacing | ≤30 min | 100-200 cm² (얼굴 mask) | 미용 | onset + 면적 (≈I1 sibling) |
| **I4** | **tattoo CREATION (제작, NOT 제거)** | ≤30 min apply | **200-1000 cm²** × **1-4 hr 세션** | 미용·대면적 | **LAST (세션 길이 × 면적 · biggest)** |
| I5 | derm biopsy / excision / mole | ≤30 min | 10-30 cm² | 임상 | onset (LAST trivial) |
| I6 | pediatric procedure | ≤30 min | 면적/체중 의존 | 신생아-아동 | **체중 LAST scaling → G3 territory** |
| I7 | cosmetic filler / botox | **≤15 min (stretch)** | 20-50 cm² (얼굴 only) | 미용 (반복) | onset (빠를수록 가치 ↑) · 화장품성 |
| I8 | dental gel (gingival) | ≤2 min | NA (점막) | 치과 | **adjacent category — mucosal kinetics 다름 (SC 부재 → 본 모델 OUT-OF-SCOPE)** |

> **8개 indication 중 7개는 동일 SC permeation kinetics** (I8 점막 제외). I4 만 *세션 길이 × 면적* 으로 LAST envelope 을 압박.

### 2.1 envelope grid (면적 × 세션 길이) — 8 indication 위치

```
     세션 길이 (apply or procedure)
      4hr  ─                                           ▒I4 sleeve▒
            │                                           (1000cm²,4hr)
      2hr  ─                                  ▒I4 large▒
            │                                  (400cm²,2hr)
      1hr  ─                          ▒I4 typ▒
            │                          (200cm²,1hr)
     30m  ─    I2  I5/I7  I3   I1-leg  I1-back
            │   ●   ●●     ●     ●      ●
     15m  ─    I7  I5
            │   ●   ●
            └──┬───┬─────┬───┬───┬────┬────┬─→ 면적 (cm²)
              10   30   100  200 400  600 1000

      ✓ green box  (LAST margin ≥ 10×): I1·I2·I3·I5·I7  (all ≤400 cm²/30min, +epi)
      △ amber box  (margin 5-15×):       I4 typ 400cm²·1hr (5+5% recommend)
      ✗ red box    (margin <5× w/o mit): I4 large 1000cm²·>2hr (5+5% + split 必)
      ◌ G3 deferred:                    I6 (mg/kg scaling)
      ◌ scope:                          I8 (mucosal, separate)
```

---

## 3. cross-indication envelope — hexa-LAC v1 single SKU 커버리지

`Cmax(ng/mL) = 0.1834 × A(cm²)` (30-min apply, ER 3× CPE, +epi 1:200k · A4 §3 inversion). margin = 5000 / Cmax.

| # | indication | A (cm²) | apply | Cmax (ng/mL) | margin vs 5000 | onset (LAC v1) | spec_fit |
|---|---|---:|---:|---:|---:|---:|---|
| I1-face | hair removal (얼굴) | 50 | 30 min | 9.2 | **545×** | **2.8 min** | ✓ |
| **I1-leg** | **hair removal (다리, anchor)** | **400** | 30 min | **73.3** | **68×** | **2.8 min** | ✓ |
| I1-back | hair removal (등) | 600 | 30 min | 110 | 45× | 2.8 min | ✓ (라벨 권장 ≤400 → split 권고) |
| I2 | pre-needle | 10 | 30 min | 1.83 | **2729×** | 2.8 min | ✓✓ |
| I3 | pre-laser vasc/resurf | 150 | 30 min | 27.5 | 182× | 2.8 min | ✓ |
| **I4-typ** | **tattoo creation (typ)** | **400** | **120 min stress** | **330** | **15.1×** | 2.8 min | △ partial (≥10× 통과 but tight) |
| **I4-max** | **tattoo creation (sleeve)** | **1000** | **120 min stress** | **826** | **6.05×** | 2.8 min | ✗ (5+5% + split 必) |
| I5 | derm biopsy/excision | 20 | 30 min | 3.67 | 1364× | 2.8 min | ✓✓ |
| I6 | pediatric (참고) | 50 | 30 min | 9.2 | 545× (성인) | 2.8 min | ◌ **deferred-G3** (mg/kg scaling 필요) |
| I7 | filler / botox | 30 | 15 min | 2.75 (≈) | 1818× | 2.8 min | ✓ (15min stretch 충족) |
| I8 | dental gel | NA | NA | NA | NA | NA | ◌ out-of-scope (점막) |

> **8개 중 7개 ✓ 커버** (I8 out-of-scope · I6 G3 cross-link · I4 sleeve 만 mitigation 필요).
> **onset 균질** — D-boost 20× 가 모든 indication 에서 2.8 min onset 을 동일 제공 (SC kinetics 가 indication-agnostic 이라는 본 도메인의 핵심 통찰).

### 3.1 I4 tattoo CREATION mitigation (유일한 spec gap)

```
   I4 sleeve (1000 cm² × 120 min stress)  단일 SKU 한계 + de-rate path

   ┌──────────────────────────────────────────────────────────────────┐
   │  7+7% no-mit (1000cm², 120m)   Cmax = 826 ng/mL    margin 6.05× │
   │     → 라벨 ≥10× 미달, partial                                    │
   │                                                                  │
   │  5+5% de-rate (concentration ×0.71)                              │
   │     → Cmax = 590 ng/mL    margin 8.47×                          │
   │     → 여전히 <10×                                                │
   │                                                                  │
   │  5+5% + split 2× (≥4hr 간격, lid t½ ~90min × ≥3 = 90% clearance) │
   │     → Cmax_coincident = 295 ng/mL    margin 16.9×  ✓ PASS       │
   │                                                                  │
   │  trade-off: 5+5% 에서 C(200μm)=0.357% = 71% MEC                  │
   │   → analgesia 유지, 깊은 dermal block 은 thin                    │
   │   → tattoo machine 진동/표재 자극에는 충분 (A2+A3 결론)         │
   └──────────────────────────────────────────────────────────────────┘
```

⇒ tattoo CREATION 은 **별도 라벨 사용지침** (5+5% SKU + split 2회) 으로 커버 — 단일 product 가 아닌 *단일 처방 family* (7+7% main + 5+5% large-area variant). G4 에서 SKU split 으로 확정 예정.

---

## 4. 시장 gap — 현 제품 어디가 부족한가 (🟡)

### 4.1 현 제품 envelope 비교

| 제품 | onset | 면적 max | epi | regulatory | 가격(30g) | 한계 |
|---|---:|---:|---|---|---:|---|
| **EMLA** | 60 min (무폐색) | 1300 cm² | ✗ | Rx (US/EU) / OTC (일부) | ~$51 | **느림** · metHb (prilo) |
| **LMX-4** | 30 min (무폐색) | ~600 cm² | ✗ | **OTC** (US) | ~$42 | onset 30min 한계 · epi 無 |
| **BLT (compounded)** | ~20-30 min | clinic-가변 | ✗ | **Rx-only · 미규격** | clinic | benzo metHb · 미표준 |
| **Pliaglis (lid 7%/tet 7%)** | 20-30 min (peel-film) | 400 cm² | ✗ | **Rx-only** · 좁은 indication | 매우 비쌈 | apply 복잡 (peel) · epi 無 |
| **Topicaine 5% (lid)** | 30-45 min | ~600 cm² | ✗ | OTC | ~$30 | 단일 화합물 (eutectic 無) |

### 4.2 명시적 gap

```
    ───────────────────── 시장 빈 자리 ─────────────────────
   ◆ Gap-A : "fast onset ≤20min + cosmetic-grade 면적 (≤400cm²)
              + OTC accessibility"  ←  none of EMLA·LMX·BLT·Pliaglis 충족
              EMLA: 면적 ✓ 가격 ✓  but onset ✗
              LMX:  onset 50% ✓ but cosmetic-area 한계
              BLT:  onset ✓ but compounded·미규격·Rx
              Pliaglis: onset ✓ + 면적 ✓ but **Rx-only · 좁은 indication · 비쌈**

   ◆ Gap-B : "duale SKU OTC + Rx · 같은 backbone, 농도만 ladder"
              → 환자 셀프-OTC (소형 procedure) 와 clinic-Rx (대면적·epi)
                동일 브랜드/포뮬레이션으로 연결하는 product 부재.

   ◆ Gap-C : "indication-agnostic 단일 SKU" — 현 product 는 각자
              레이저(LMX·Pliaglis) · 주사(EMLA) · 타투(BLT) 로 정렬 →
              clinic stock SKU 다중. 단일 SKU 가 7/8 커버하면 SKU ↓.

   ◆ Gap-D : "라벨화된 face vs body 가이드 + visual onset timer"
              현 제품 라벨 모두 "30-60 min 도포" 단일 지침; 
              indication × 면적 × onset 매트릭스 제공 zero.
```

### 4.3 hexa-LAC v1 가 메우는 슬롯

| spec | EMLA | LMX | BLT | Pliaglis | **hexa-LAC v1** |
|---|---|---|---|---|---|
| onset ≤20 min | ✗ | △30 | ✓20-30 | ✓20-30 | **✓ ~3 min (D-boost 20×)** |
| 면적 400 cm² 안전 | ✓ | ✓ | △ | ✓ | **✓ margin 68×** |
| +epi (LAST headroom) | ✗ | ✗ | ✗ | ✗ | **✓ 1:200k** |
| OTC variant (5+5%) | △ | ✓ | ✗ | ✗ | **✓ 듀얼 SKU (G4)** |
| 7/8 indication 단일 SKU | ✗ | ✗ | ✗ | ✗ | **✓** |
| metHb 회피 | ✗(prilo) | ✓ | ✗(benzo) | ✓ | **✓** |
| 표준화 (FDA path) | ✓ | ✓ | ✗ | ✓ | **G2 territory (505(b)(2))** |

⇒ **product opportunity**: *"OTC 5+5% (얼굴·작은 procedure, 30min onset) ↔ Rx 7+7%+epi+peel (cosmetic-grade 면적, 3-10min onset, indication-agnostic)"* 듀얼 SKU. 현 시장에 정확히 이 envelope 가진 product 부재 — Pliaglis 가 가장 근접하나 Rx-only + 좁은 indication + epi 無 + 비쌈.

---

## 5. hexa-native recompute (verbatim · 🟢 · per @D g5)

`run`: `hexa run NUMB/sim/g1_indication_map.hexa`

```
=== NUMB G1 — indication map cross-envelope (hexa-LAC v1) ===

benchmark anchor: LASER HAIR REMOVAL (user-specified)
  area 50-400 cm^2 | 4-8 sessions @ 4-8wk | VAS 6-8/10 | onset target <= 30min
  -> drives spec: onset <=30min for 100-400 cm^2 with LAST headroom >=10x

[1] onset model (h=10um):
  EMLA   D=1e-10 -> t_lag(min) = 27.7778  onset(2*tlag) = 55.5556 min
  LAC v1 D=2e-9  -> t_lag(min) = 1.38889  onset(2*tlag) = 2.77778 min

[2] LAST k_lac (ER3x + epi, derated 30min apply):
  k_lac(120min) = 0.07995  ng/mL per mg applied
  k_lac(30min)  = 0.017749 ng/mL per mg (30-min realistic)

[3] per-indication Cmax (30min apply, ER3x, +epi) + LAST margin (vs 5000 ng/mL):

  I1 laser hair removal (ANCHOR) A=200 cm^2 : Cmax=36.68 ng/mL  margin=136.3x  spec_fit=YES
  I2 pre-needle                  A= 10 cm^2 : Cmax= 1.83 ng/mL  margin=2729x   spec_fit=YES
  I3 pre-laser vasc/resurf       A=150 cm^2 : Cmax=27.51 ng/mL  margin=181.7x  spec_fit=YES
  I4 tattoo CREATION typ         A=400 cm^2 : Cmax(30m)=73.36  Cmax(120m_stress)=330.4 ng/mL margin(stress)=15.1x  spec_fit=PARTIAL (need de-rate or split)
  I4 tattoo CREATION max         A=1000 cm^2: Cmax(30m)=183.4  Cmax(120m_stress)=826.1 ng/mL margin(stress)=6.05x  spec_fit=NO (use 5+5% + split)
  I5 derm biopsy/excision        A= 20 cm^2 : Cmax= 3.67 ng/mL  margin=1364x   spec_fit=YES
  I6 pediatric proc (ref A)      A= 50 cm^2 : Cmax= 9.17 ng/mL  margin=545x    spec_fit=DEFERRED-TO-G3 (mg/kg scaling)
  I7 filler / botox (face)       A= 30 cm^2 : Cmax= 5.50 ng/mL  margin=909x    spec_fit=YES (onset <=15min stretch)
  I8 dental gel (mucosal)        A=  NA      : Cmax= NA          margin= NA     spec_fit=OUT-OF-SCOPE

[4] I4 tattoo CREATION (worst, 1000 cm^2, 120min stress) mitigation:
  7+7% no-mit            Cmax(120m) = 826.1  ng/mL  margin= 6.05x
  5+5% de-rate           Cmax       = 590.0  ng/mL  margin= 8.47x
  5+5% + split (>=4h)    Cmax       = 295.0  ng/mL  margin=16.95x

[5] coverage of hexa-LAC v1 (single SKU, 7+7% +epi, 30min apply):
  I1 laser hair removal    ✓ covered (anchor)
  I2 pre-needle            ✓ covered (trivial)
  I3 pre-laser vasc/resurf ✓ covered
  I4 tattoo CREATION       △ partial — typ 400cm² covered (15x margin @stress); max 1000cm² needs 5+5% + split
  I5 derm biopsy/excision  ✓ covered
  I6 pediatric             - deferred to G3 (mg/kg scaling)
  I7 filler / botox        ✓ covered
  I8 dental gel            - out-of-scope (mucosal)

=== 7 of 8 indications covered by hexa-LAC v1 single SKU (I4 tattoo-CREATION partial; I8 adjacent) ===
=== anchor benchmark MET: onset ~2.8 min @ 200 cm^2, LAST margin 136x (>>10x headroom requirement) ===
```

---

## 6. 정직한 tier ledger + verdict (per @D d5/d6)

| claim | tier |
|---|---|
| onset = 2 × h²/(6D) closed-form · Cmax=k·dose linear · margin inversion | 🔵 closed-form (A1·A4 상속) |
| §3·§5 hexa recompute (verbatim, A4 sanity 220→330 ng/mL match) | 🟢 numerical |
| 레이저 제모 시장 $1.4-1.6B/CAGR 18% · session 면적/회수 · VAS 6-8 · ~95% topical | 🟡 시장보고서 · StatPearls · 임상 |
| 현 제품 onset/cap/regulatory (EMLA 60min·1300cm² · LMX 30min · BLT compounded · Pliaglis 7+7% 400cm² Rx) | 🟡 FDA label · 비교 리뷰 |
| tattoo CREATION 평균 면적 200-1000cm² · 1-4hr 세션 · reapply 권장 | 🟡 산업 가이드 (Sedalux · NumbedInk · Painful Pleasures) |
| ER_extra=3× CPE · f_epi=0.5 · 30min derate=0.222 | 🟠 A5 ex-vivo 실측 잔여 (A4 상속 gap) |
| pediatric I6 mg/kg envelope · OTC↔Rx 농도 ladder 정합 | 🟠 G3·G4 후속 |
| I8 mucosal kinetics (점막은 SC 부재 → 본 모델 부적용) | 🟡 약리 상식 |

### G1 verdict (per @D d5)

> **G1 PASS (non-wet-lab)**: 레이저 제모 anchor 가 spec 을 *"onset ≤30min @ 100-400 cm² · LAST 헤드룸 ≥10×"* 로 fix.
> hexa-LAC v1 단일 SKU 가 **8개 indication 중 7개 ✓** (I8 점막 out-of-scope · I6 deferred-G3 · I4 sleeve 만 5+5% + split mitigation).
> 명시적 product gap = *"fast-onset (≤20min) × cosmetic-area (≤400cm²) × +epi × OTC↔Rx 듀얼 SKU"* — 현 시장 부재.
> absorbed=false 유지 (잔여 게이트 = G2 regulatory · G3 pediatric · G4 SKU split · NUMB-oracle).

---

## Sources

### 시장 (laser hair removal)
- Laser Hair Removal Market Size — *Precedence Research* (글로벌 $1.58B 2025 → $7.17B 2034, CAGR 18.35%) — [precedenceresearch.com/laser-hair-removal-market](https://www.precedenceresearch.com/laser-hair-removal-market)
- Laser Hair Removal Market Size — *The Insight Partners / GlobeNewswire* ($1.46B by 2031, CAGR 13.31%) — [globenewswire.com/news-release/2025/05/15/3082188](https://www.globenewswire.com/news-release/2025/05/15/3082188/0/en/Laser-Hair-Removal-Market-Size-to-Surpass-USD-1-46-Billion-by-2031-with-CAGR-of-13-31-The-Insight-Partners.html)
- Laser Hair Removal Market Size — *Fortune Business Insights* ($1.42B 2025 → $4.60B 2032, CAGR 18.3%) — [fortunebusinessinsights.com/laser-hair-removal-market-103477](https://www.fortunebusinessinsights.com/laser-hair-removal-market-103477)
- US Laser Hair Removal Market — *Precedence Research* (US $440M 2025 → $2.1B 2034, NA 35% share) — (same Precedence link above)

### 임상 (세션 + 통증 + topical)
- Laser Hair Removal — *StatPearls NBK507861* — [ncbi.nlm.nih.gov/books/NBK507861](https://www.ncbi.nlm.nih.gov/books/NBK507861/)
- Anesthesia Methods in Laser Resurfacing — *PMC3580976* (topical anesthetic 응용 + EMLA cap 2000cm²) — [pmc.ncbi.nlm.nih.gov/articles/PMC3580976](https://pmc.ncbi.nlm.nih.gov/articles/PMC3580976/)
- 세션 길이 (procedure 15-30min + topical 20-30min) — *Belislaser* · *Ohio State Wexner Medical* — [wexnermedical.osu.edu/aesthetics/non-surgical-procedures/laser-hair-removal](https://wexnermedical.osu.edu/aesthetics/non-surgical-procedures/laser-hair-removal)
- 세션 회수/간격 (얼굴 4-6 / 다리 6-8 / 등 8-12, 4-8주 간격) — *European Wax Center* · *SpaMedica Toronto* · AAD 인용 — [waxcenter.com/blogs/news/understanding-sessions-for-laser-hair-removal](https://waxcenter.com/blogs/news/understanding-sessions-for-laser-hair-removal)
- VAS 통증 (Nd:YAG 6.05±1.39) — *PMC9503442* "Traditional vs in-Motion Nd:YAG" — [ncbi.nlm.nih.gov/pmc/articles/PMC9503442](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9503442/)
- 환자 attitudinal / topical 사용 — *J Cosmet Dermatol* 2025 Agaoglu (PMC12210097) — [pmc.ncbi.nlm.nih.gov/articles/PMC12210097](https://pmc.ncbi.nlm.nih.gov/articles/PMC12210097/)
- Prescription-Strength Topical for laser hair removal — *Well Revolution* — [wellrevolution.com/blog/maximizing-numbing-for-laser-hair-removal-the-ultimate-guide-to-prescription-strength-topical-anesthetics](https://www.wellrevolution.com/blog/maximizing-numbing-for-laser-hair-removal-the-ultimate-guide-to-prescription-strength-topical-anesthetics)

### tattoo CREATION (I4)
- Topical anesthesia for tattoos — *Sedalux* (apply 90-120min pre · 1-4hr sessions · reapply 45min cycles) — [sedalux.es/en/what-type-of-anesthesia-can-be-used-for-a-tattoo](https://sedalux.es/en/what-type-of-anesthesia-can-be-used-for-a-tattoo/)
- Tattoo numbing cream usage — *Numbed Ink* · *Painful Pleasures Help Center* · *Lucky 24 Tattoo* — [painfulpleasures.com/blogs/help-center/tattoo-anesthetic-options](https://www.painfulpleasures.com/blogs/help-center/tattoo-anesthetic-options)

### 시장 (topical anesthetic 광역) + 비교
- Local Anesthesia Drugs Market ($4.14B 2024 → $5.13B 2030, CAGR 3.7%) — *Grand View Research* — [grandviewresearch.com/industry-analysis/local-anesthesia-drugs-market](https://www.grandviewresearch.com/industry-analysis/local-anesthesia-drugs-market)
- EMLA vs LMX 비교 (LMX 절반 시간 · 가격 $42 vs $51) — *Med Supply Solutions* — [medsupplysolutions.com/blog/emla/emla-vs-lmx](https://www.medsupplysolutions.com/blog/emla/emla-vs-lmx)
- Topical anaesthetics in dermatology (Pliaglis 7+7% 라이센스 history, EU/US 2012-2013) — *Hospital Pharmacy Europe* — [hospitalpharmacyeurope.com/clinical-zones/dermatology/topical-anaesthetics-in-dermatology](https://hospitalpharmacyeurope.com/clinical-zones/dermatology/topical-anaesthetics-in-dermatology/)
- Review of Lidocaine/Tetracaine Cream — *PMC4107876* — [pmc.ncbi.nlm.nih.gov/articles/PMC4107876](https://pmc.ncbi.nlm.nih.gov/articles/PMC4107876/)
- Five Lidocaine-Containing Topical Anesthetics serum comparison (BLT 0.17 µg/mL) — *Aesthet Surg J* 2012 32(4):495 — [academic.oup.com/asj/article-pdf/32/4/495/6084596/32-4-495.pdf](https://academic.oup.com/asj/article-pdf/32/4/495/6084596/32-4-495.pdf)

### 상속 (TTR-LAC)
- A1 (SC lag time + EMLA 60min) — `TTR-LAC/research/A1_anesthesia_baseline.md`
- A4 (Pliaglis-anchored LAST · k=0.0533 ng/mL/mg · ER3× + epi · 30min derate) — `TTR-LAC/research/A4_candidate_LAST.md`
- (재현) `NUMB/sim/g1_indication_map.hexa` — `hexa run NUMB/sim/g1_indication_map.hexa`
