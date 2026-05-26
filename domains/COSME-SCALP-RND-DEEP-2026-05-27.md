# 💆 COSME-SCALP — R&D Deep (외부 arxiv/web research 기반) — 2026-05-27

> **순차 1번째 도메인 외부 자원 활용**: arxiv + WebSearch + WebFetch
> **이전**: SPEC-DEEP·STRUCTURE-DESIGN-2026-05-27 (knowledge 기반 매트릭스)
> **이번**: 한국 식약처 가이드 + arxiv 모낭주기/Wnt 모델 + 시판 cell efficacy 결손 발견

---

## 1. 🔬 외부 research 핵심 발견 5건

### 1-1. 한국 cell efficacy SOP **부재** (R&D 차별 진입장벽)

| 항목 | 현황 |
|---|---|
| 미백·주름 | cell efficacy + 인체적용시험 두 가지 가이드라인 |
| **탈모완화** | **인체적용시험만** 있음 · cell 기준 없음 (cosinkorea 2024 칼럼) |
| 권고 평가 | 모근 세포 활성·증식·세포사 억제 (3축) |
| 차별 진입장벽 | **자체 cell efficacy SOP 수립** → 신규 성분 진입 시 데이터 무기 |

→ R&D 전략 변경: 단순 6대 정량이 아닌 **자체 cell efficacy 시험 + 자체 임상 24주**가 진입장벽 moat 형성

### 1-2. 식약처 인체적용시험 가이드라인 (2022.10 개정)

- KCIA 공지 #14937 — 식약처 탈모완화 화장품 인체적용시험 가이드라인 개정안 의견 수렴 (2022-10-20 마감)
- 자료 면제 6대 자동허가 후 신규 효능 클레임 시 가이드 적용
- 의견 수렴 후 최종 개정안 = 시판 기능성 화장품 24주 임상 표준

### 1-3. 모낭주기 first-principles 수학 모델 (arxiv 2502.15035, Dobreva 2025)

| AGA (남성 androgenetic alopecia) | AA (autoimmune alopecia) | Control |
|---|---|---|
| growth phase 길이 **uncertainty 큼** | growth phase 길이 짧음 (확정적) | 정상 |
| DPC ↔ MK 신호 weak | DPC ↔ MK 신호 매우 weak | 정상 |
| MK 증식 normal | MK 증식 inhibition strong | 정상 |
| MK apoptosis 영향 < AA | **MK apoptosis 핵심** (growth length 결정) | — |

→ **AGA R&D target = DPC↔MK 신호 강화 + MK 증식 활성** (apoptosis 억제는 AA target, AGA에는 sub-target)

### 1-4. Wnt/β-catenin · Dkk1 음성 피드백 회로 (arxiv 1010.5758, Pedersen 2010)

- Dkk1 = Wnt 신호 **음성 조절자**
- AGA에서 DHT → DPC의 Dkk1 발현 ↑ → Wnt ↓ → 모낭 retreat → 탈모
- **R&D 보조 성분 후보**: Dkk1 발현 억제 (식물 추출물 — Procapil 일부, 자생 식물 추출물 일부)
- 정량화 가능: Western blot Dkk1 단백질 발현 (DPC in vitro)

### 1-5. OCT 모낭 침투 측정 (arxiv 1802.01341, 1802.01455)

| 기기 | 측정 지표 | 우리 처방 검증 |
|---|---|---|
| OCT (Optical Coherence Tomography) | 모낭 침투 깊이·표피 두께 | 나노에멀젼 80nm vs 일반 처방 head-to-head |
| 금나노쉘 (GNS) 대비 | 침투 0.64±0.17mm 평균, max 1.20mm (armpit) | 두피 침투 추정 가능 |
| UHR-OCT (3μm 해상도) | DEJ 경계·진피 papilla·vellus hair | 처방 효과 정량 |

→ **OCT 도입 시 in vivo 침투 정량화 가능** (Franz cell + OCT 이중 검증)

---

## 2. 🧬 R&D target 재정의 (first-principles 기반)

```
이전 (knowledge 기반):
  6대 자동허가 + 보조 시너지 (카페인·펩타이드·엑소좀) → 24주 모근 +15%
       ↓
이번 (research 기반):
  ① 자동허가 6대 (의무) — 진입 자동허가
  ② DPC↔MK 신호 보강 (Wnt/β-catenin 회로 강화 · Dkk1 억제)
  ③ MK 증식 활성 + apoptosis 억제 (cell efficacy 자체 SOP)
  ④ 모낭 침투 (80nm 나노에멀젼 · OCT 검증)
       ↓
  자체 cell efficacy SOP + 자체 임상 24주 = 진입장벽 moat
       ↓
  24주 TrichoScan 모근 +15% (시판 +5%p~+10%p 우위) + DPC 증식 정량 (Western blot)
```

---

## 3. 🧪 자체 cell efficacy SOP 후보 (한국 최초 시도)

| 시험 | 표적 | 측정 |
|---|---|---|
| 모유두세포 (DPC) 증식 assay | DPC 활성 | MTT/CCK-8 흡광도 (cell viability +20% 목표) |
| 모낭 케라티노사이트 (MK) 증식 | MK 활성 | EdU/Ki-67 positive cell % (proliferation +30%) |
| MK apoptosis 억제 | MK 보호 | Annexin V FACS (apoptosis -50%) |
| 5α-환원효소 (Type I/II) 활성 억제 | DHT 생성 차단 | radio-enzyme assay (효소 활성 -30%) |
| Wnt/β-catenin 발현 (DPC) | 신호 회복 | Western blot β-catenin/Dkk1 발현 비율 |
| 모낭 organoid 배양 시험 | 통합 효능 | hair shaft 성장 길이 (mm/2주) |

각 시험 자체 SOP 수립 — 한국 시판 제품 대비 차별 데이터 무기 (식약처 권고에 부합)

---

## 4. 🎯 통합 처방 후보 — Pilot D (외부 research 반영 신규)

기존 Pilot A/B/C (knowledge 기반) 외 **Pilot D — research 정합**:

| 성분 | 농도 | 역할 (first-principles) | 측정 가능 USP |
|---|---|---|---|
| 6대 조합② (자동허가 정량) | 정량 | 진입 자동허가 | 자료 면제 |
| 카페인 | 0.5% | 5α-환원효소 보조 차단 + 혈류 | 효소 활성 -30% (cell SOP) |
| 펩타이드 (Procapil 또는 Capixyl) | 3% | DPC Wnt 보강 + Dkk1 억제 | β-catenin 발현 +30%, Dkk1 -40% |
| 식물 엑소좀 (당귀·인삼 자생식물) | 10⁹/mL | DPC 증식 + MK apoptosis 억제 | MTT +20%, Annexin V -50% |
| **나노에멀젼 80nm** | — | 모낭 침투 (OCT 검증) | 모낭/표피 비율 2배↑ |

### 24주 임상 가설 (Pilot D)

```
시판 6대 단독: +5% 모근 밀도 baseline
        ↓
6대 + 카페인 + 펩타이드 (knowledge 기반 Pilot B): +10% (+5%p)
        ↓
6대 + 카페인 + 펩타이드 + 엑소좀 (Pilot C): +13% (+8%p)
        ↓
Pilot D (+ 자체 cell SOP + OCT 검증 + 나노에멀젼): +15-18% (+10-13%p)
```

---

## 5. 🛠 외부 라이브러리 포팅 후보 (next step)

| 라이브러리 | 활용 |
|---|---|
| **RDKit** (분자 구조) | 활성성분 SMILES → 분자 특성 (logP·MW·H-bond) 정량 |
| **OpenMM** (분자동역학) | 5α-환원효소 + 활성성분 docking + binding affinity 계산 |
| **AutoDock Vina** (docking) | 5αR Type II + 카페인·펩타이드 docking 점수 → in vitro 시험 전 in silico screening |
| **Cell models (q-bio.CB)** | Dobreva 2025 (arxiv 2502.15035) 모낭주기 모델 적용 → 자체 처방 시뮬 |
| **OCT 분석 (skimage)** | OCT 이미지 → 모낭 침투 깊이 자동 측정 |
| **TrichoScan-like (OpenCV)** | 모발 카운트·두께 자동 분석 (24주 임상 cost↓) |

→ R&D 정공법: in silico screening (RDKit·Vina) → in vitro cell SOP → in vivo 24주 임상

---

## 6. 🚀 진입 정공법 재정의 (이번 research 반영)

```
Phase 1 (1-3개월·자동허가)
  Pilot A 출시 (6대 자동허가 BASIC) — 즉시 매출

Phase 2 (병행 R&D, 3-6개월·1,000-3,000만원)
  ① in silico screening (RDKit·Vina) — 카페인/펩타이드 5αR binding 정량
  ② 자체 cell efficacy SOP 수립 (DPC·MK·5αR·Wnt 6 시험)
  ③ OCT 침투 시험 (Franz cell + UHR-OCT)
  → Pilot D 처방 lock-down

Phase 3 (6-12개월·7,000-15,000만원)
  24주 인체적용시험 (TrichoScan + 두피 16S + 자체 cell SOP 결과 보강)
  → 차별 클레임 데이터 무기 확보

Phase 4 (12개월+)
  Pilot D 출시 (프리미엄 라인) + Phase 3 데이터 광고 (식약처 가이드 부합)
```

## 출처

- [cosinkorea — 신규 기능성 화장품 '탈모증상완화' 효능 성분 평가법 제언](https://www.cosinkorea.com/news/article.html?no=31625)
- [KCIA 공지 #14937 — 탈모완화 화장품 인체적용시험 가이드라인 개정안 의견 수렴](https://kcia.or.kr/home/notice/notice.php?type=view&no=14937)
- [arxiv 2502.15035 — Dobreva 2025 · Hair growth duration uncertainty/sensitivity in alopecia conditions](https://arxiv.org/pdf/2502.15035v1)
- [arxiv 1010.5758 — Pedersen 2010 · Dickkopf1 Wnt pathway negative feedback model](https://arxiv.org/pdf/1010.5758v1)
- [arxiv 1802.01341 — Mogensen 2018 · OCT 금나노쉘 모낭 침투 측정](https://arxiv.org/pdf/1802.01341v1)
- [arxiv 1802.01455 — Israelsen 2018 · UHR-OCT dermal papilla 측정](https://arxiv.org/pdf/1802.01455v1)
- [경향신문 — 식약처 기능성 탈모샴푸 가이드라인 비판 (2022.08)](https://www.khan.co.kr/article/202208180748011)
- [biotimes — 탈모 완화 천연 원료 (한국콜마 고삼뿌리 추출물 2024)](https://www.biotimes.co.kr/news/articleView.html?idxno=15851)
- [TrichoScan validation — ICC 0.91-0.97](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3002414/)
