# TTR-MN M8 — ex-vivo 돼지 피부 PoC protocol design

> 출처: `m7_mn_array_engineering.md` (MN array spec) + `m3_mn_candidates.md` (Top-3 payload) + `arxiv_deep_research.md §11` (ex-vivo pig skin precedent · arxiv:2105.12288 photoacoustic)
> milestone: TTR-MN.md "M8-MN ex-vivo 돼지 피부 PoC"
> scope: ex-vivo protocol design (실제 lab 실행은 외주/in-house lab — design completed)

## TL;DR

Ex-vivo 돼지 귀 피부 (porcine ear skin, full-thickness) 에서 인공 잉크 주입 → MN patch 도포 → 24/72 hr 후 잉크 제거율 측정. 3 payload × 3 잉크 클래스 = 9 cell + 1 negative control (HA-only patch). Endpoint: digital photo (RGB delta) + histology (Masson trichrome · IHC) + LC-MS (분해 산물). 제거율 ≥ **50% goal** (TTR-MN.md M8 explicit), 통과 시 M9 in-vivo 진입. 비용 ~$3-5k.

## 모델 선택 — 돼지 귀 피부

| 모델 | 장점 | 단점 | 본 PoC 적합 |
|---|---|---|---|
| **Porcine ear (돼지 귀)** | 인간 피부 가장 유사 (SC 두께 · 모낭 밀도) · 부산물로 풍부 · 비용 저 | 사후 변화 (24 hr 이내 사용) | ★★★ primary |
| Porcine flank | 큰 면적 (large tattoo) | 사후 빨라짐 | ★★ |
| Human skin (절제 후) | 인간 직접 | IRB · 비용 高 · 가용성 ↓ | ★ (phase later) |
| Reconstructed skin (EpiSkin · Phenion) | reproducible | 진피 없음 (표피 only) — 본 작업 부적합 | ✗ |
| Mouse skin | 비용 ↓ · 통제 | SC 두께 인간 1/10 · 종간 차이 大 | ✗ (translation 문제) |

⇒ porcine ear · full-thickness biopsy (3 cm × 3 cm punch).

## 잉크 모델 (시장 representative)

| ink class | 모델 잉크 | 표적 candidate |
|---|---|---|
| **Carbon black** (시장 60-70%) | Tattoo India ink (carbon black) | DyP F5 (M2 wall · 일부 cleavable) · CeO₂ ROS |
| **Organic color (azo)** | Methyl orange · Sudan I (CI 11920 모델) | AzoR + ascorbate · DyP |
| **Iron oxide red** | Fe₂O₃ commercial pigment | DFO chelation + CeO₂ Fenton |

(Cu-Pc + Cr₂O₃ 는 wall 후속 평가 — phase 2 별 cohort)

## Experimental matrix (9 + 1 cell)

| cell | payload | ink | n (replicate) | timepoint |
|---|---|---|---|---|
| C1 | CeO₂ NP MN | carbon black | 3 | 24h · 72h |
| C2 | CeO₂ NP MN | azo | 3 | 24h · 72h |
| C3 | CeO₂ NP MN | Fe₂O₃ | 3 | 24h · 72h |
| C4 | DyP+DFO MN | carbon black | 3 | 24h · 72h |
| C5 | DyP+DFO MN | azo | 3 | 24h · 72h |
| C6 | DyP+DFO MN | Fe₂O₃ | 3 | 24h · 72h |
| C7 | AzoR+ascorbate MN | carbon black | 3 | 24h · 72h |
| C8 | AzoR+ascorbate MN | azo | 3 | 24h · 72h |
| C9 | AzoR+ascorbate MN | Fe₂O₃ | 3 | 24h · 72h |
| Neg | HA-only MN (no payload) | mixed | 3 | 24h · 72h |

⇒ 30 patches · 60 timepoints · 3 candidate × 3 ink × 2 time × 3 replicate + 6 negative

## Procedure (단계별)

### Day 0 — preparation
1. **돼지 귀 acquisition** (도축장 · ≤ 4 hr postmortem · 4°C transport)
2. **Skin prep**: 3×3 cm punch biopsy · subcutaneous fat trim · PBS rinse
3. **Mount**: Franz cell or static culture chamber (DMEM + antibiotic · 37°C · 100% humidity)

### Day 1 — ink injection (simulating tattoo)
4. **Ink injection**: tattoo machine (60 Hz · 5-needle) · depth 800-1200 μm (dermal) · 1×1 cm 영역
5. **Wait 24h** (잉크 안정화 · macrophage uptake 시작)
6. **Pre-photo**: digital camera (calibrated · ColorChecker) · OCT (optional)

### Day 2 — MN patch application
7. **MN patch application**: thumb-press 30 sec · 5 min dissolution wait
8. **Patch removal** (HA matrix 완전 분해 확인)
9. **24h post-application** (T1)

### Day 3 — first timepoint
10. **T1 measurement**:
    - **Digital photo**: RGB intensity delta from Day 0
    - **OCT**: ink layer thickness change
    - **Skin biopsy 1/2** (24h cell): histology FFPE
11. **Reapply** if extended cohort (some cells)

### Day 5 — second timepoint
12. **T2 measurement (72h)**:
    - Digital photo · OCT · biopsy 2/2

## Endpoint measurement (3 axis)

### Axis 1 — Digital photo (RGB delta)

```
   ΔRGB = √[(R0-R1)² + (G0-G1)² + (B0-B1)²]
   removal % = ΔRGB(payload) / ΔRGB(max possible)
```

- ColorChecker calibration mandatory
- 조명 표준 (D65 · 5500K · diffuse)
- ROI = injection 영역 1×1 cm

### Axis 2 — Histology (Masson trichrome + IHC)

- **Masson trichrome**: 콜라겐 손상 · ink particle distribution
- **IHC**: F4/80 (macrophage) · 콜라겐 I (off-target) · KI-67 (cell proliferation)
- depth-resolved ink particle count (epidermis vs dermis layer)

### Axis 3 — LC-MS (분해 산물)

- Skin lysate · methanol extraction · LC-MS/MS
- 표적 분석:
  - Azo cleavage: aromatic amine (aniline · sulfanilic acid)
  - DFO-Fe complex: ferrioxamine
  - CeO₂ → Ce³⁺ leaching
  - 부산물 toxicokinetics (M6 cross-ref)

## Statistical analysis

- ANOVA (payload × ink × time)
- Tukey HSD post-hoc
- removal % 95% CI
- n=3 → preliminary · 통계 power = M9 in-vivo 확장 시 boost (n=8-12)

## Success criteria (gate)

| metric | M8 goal (TTR-MN.md) | M8 fail-fast | M9 진입 조건 |
|---|---|---|---|
| Removal % (Azo · DyP/AzoR) | ≥ 50% (24h) | < 30% (24h) | ≥ 50% in 2/3 candidate × 2/3 ink |
| Removal % (Carbon black) | ≥ 30% | < 20% | partial OK (M9 multi-cycle) |
| Removal % (Fe₂O₃) | ≥ 50% (DFO) | < 30% | DFO mandatory pass |
| Collagen 손상 (Masson) | minimal | severe (≥ 20% damage) | minimal mandatory |
| Aromatic amine 잔류 | < 100 ng/cm² | > 500 ng/cm² | M6 toxicokinetics OK |
| HA dissolution | complete < 60 min | residual > 24 hr | complete mandatory |

## Risks · mitigation

| risk | likelihood | mitigation |
|---|---|---|
| 사후 skin viability ↓ | high | < 6h postmortem · DMEM culture |
| Ink injection 깊이 변동 | mid | tattoo machine 표준 settings · 사전 calibration |
| MN patch 적용 force 불일치 | mid | calibrated press device · 4 N · 30 sec |
| Inter-donor variability | mid-high | n=3 minimum · matched control |
| Macrophage 활성 ex-vivo 낮음 | mid | 짧은 timepoint (24/72h) · M9 in-vivo 검증 |

## 비용 추정

| 항목 | $ |
|---|---|
| 돼지 귀 acquisition (10 ear · 도축장) | 200 |
| MN patches (30 unit · CDMO small batch) | 1500 |
| Histology + IHC (60 slide · contract lab) | 1200 |
| LC-MS (60 sample · contract lab) | 1500 |
| OCT rental | 500 |
| 인건비 / Franz cell · DMEM | 1000 |
| **합계** | **~$5,900** |

## M9 handoff — in-vivo 진입 조건

다음 milestone (M9-MN: in-vivo) 가 받는 입력:
- ex-vivo PoC pass cell list (어느 payload × ink 조합이 ≥ 50%)
- 부작용 신호 (collagen 손상 · aromatic amine 잔류) — 안전성 priority
- patch lot · payload lot 정합 (GMP precursor)
- M9 in-vivo dose 추산 (ex-vivo PK 외삽)

## Honest unknowns

- **ex-vivo macrophage activity 부족**: live macrophage 가 잉크 흡수 + payload 반응 trigger — 사후 활성 낮을 수 있음
- **사후 SC barrier 변화**: 12-24 hr 사이 lipid 재정렬 · permeability 변동
- **잉크 macrophage uptake 시상수**: in-vivo는 1-2주, ex-vivo는 24h 가속 → 정확 비교 안 됨
- **timepoint 부족**: 24h/72h만 — long-term (2주) 효과 별 cohort
- **n=3 통계 power**: preliminary · M9 시 n=8-12
- **잉크 lot variability**: India ink · methyl orange 등 모델 vs commercial tattoo ink 차이

## 진행 상태

- ✅ ex-vivo porcine ear 모델 선택 · 3 잉크 × 3 payload 매트릭스
- ✅ procedure (Day 0-5) · endpoint 3 axis (photo · histology · LC-MS)
- ✅ success gate (removal % ≥ 50% · collagen 손상 minimal · aromatic amine < 100 ng)
- ✅ 비용 ~$5.9k · M9 handoff input
- design completed (per @D d1) — 실제 lab 실행은 외주 (porcine source + histology + LC-MS)
- next: M9-MN in-vivo 동물 효능 protocol
