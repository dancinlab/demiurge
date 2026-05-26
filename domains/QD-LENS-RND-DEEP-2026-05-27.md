# 👁 QD-LENS — R&D Deep (외부 web/arxiv research 기반) — 2026-05-27

> **순차 2번째 도메인 외부 자원 활용**: WebSearch + WebFetch + arxiv
> **이전**: SPEC-DEEP·STRUCTURE-DESIGN-2026-05-27 (knowledge 기반)
> **이번**: 시판 약점 발견 (Acanthamoeba) + 증발 저항 시험 + 신규 MPS 개발 방법론 + 컬러렌즈 화이트스페이스 확정

---

## 1. 🔬 외부 research 핵심 발견 5건

### 1-1. 시판 보존제 공통 약점 — **Acanthamoeba 살균력**

| 보존제 | 박테리아 | 곰팡이 | **Acanthamoeba** | 비고 |
|---|---|---|---|---|
| PQ-1 | ✓ | △ | **✗** | Alcon 옵티프리 |
| PHMB | ✓ | △ | **✗** | B+L 리뉴 |
| H₂O₂ (3%) | ✓ | ✓ | △ (중화 시 ↓) | 에이오셉 (별도 케이스) |
| P-I (povidone-iodine) | ✓ | ✓ | △ | 일부 유럽 |

→ **R&D 화이트스페이스**: 시판 4종 모두 Acanthamoeba 살균력 약함 — 자체 처방으로 Acanthamoeba 살균 강화 시 강력 USP (각막염 예방)

### 1-2. PHMB + PQ-1 듀얼 보존제 (Alcon US 특허)

- US 6,930,077 + 7,105,473 — "sub-PPM combinations of polyquaternium-1 and high molecular weight PHMB"
- 동시 사용 시 부작용 증가 보고 없음 (clspectrum 2024)
- 우회 방안: **농도·분자량 변경** 또는 **제3 보조 (예: myristamidopropyl dimethylamine)** 첨가
- 또는 **PQ-1 단독 + 비특허 보조성분** 전략

### 1-3. ISO 14729 살균력 시험 표준 (정밀)

| 균주 | log reduction 기준 |
|---|---|
| *Pseudomonas aeruginosa* | ≥ 3-log (5min stand-alone) |
| *Serratia marcescens* | ≥ 3-log |
| *Staphylococcus aureus* | ≥ 3-log |
| *Candida albicans* | ≥ 1-log |
| *Fusarium solani* | ≥ 1-log |
| **Acanthamoeba castellanii** | 별도 자체 시험 (시판 표준 미흡) |

추가 시험: **증발 저항** (2× · 4× 농축) — 실제 lens case 환경에서 살균력 유지 여부

### 1-4. 신규 MPS 개발 방법론 (PMC 3974296)

| 단계 | 시험 | 표준 |
|---|---|---|
| **Microbiological** | ISO 14729 stand-alone + regimen + 증발 저항 | 6 균주 |
| **Biological** | L929 마우스 fibroblast 세포독성 | USP / ISO 10993-5 |
| **Clinical** | **3개월 double-masked (n=270, 5 lens types)** | 각막 staining + adverse events + comfort + cleanliness |

신규 MPS 사례 (PMC 3974296):
- adverse events **2.8% vs 시판 11.8%** (4배 ↓)
- L929 cytotoxicity grade 1 (slight) vs 시판 grade 3 (severe)
- 와의 비교: 시판 대비 안전성 head-to-head 우위 입증 가능

### 1-5. 컬러렌즈 색소 보호 — 학계 자료 부재 (블루오션 확정)

- WebSearch 결과: TiO2 컬러렌즈 색소 + MPS 호환성 학계 자료 미공개
- 한국 컬러렌즈 USD 3.4억 시장 + 자료 부재 → **자체 시험 SOP 수립이 시장 표준 정의**
- 차별 측정: 사용 30회 후 색차 ΔE ≤2.0 (육안 인식 X 기준)

---

## 2. 🧬 R&D target 재정의

```
이전 (knowledge 기반):
  PHMB + 폴락사머 + 히알루론산 + 색소 보호제 → 각막 세포독성 IC50 2배↑
       ↓
이번 (research 기반):
  ① PHMB 0.0001% + 폴락사머 + 히알루론산 (기본)
  ② Acanthamoeba 살균 보조 — 식물 추출 알칼로이드 OR 마이리스타미도프로필 디메틸아민
  ③ 증발 저항 보조 — 안정화제 (사용 후기 살균력 유지)
  ④ 컬러렌즈 색소 보호 — EDTA + 토코페롤 + 시트르산 완충
  ⑤ L929 cytotoxicity grade 1 (시판 grade 3 vs)
       ↓
  ISO 14729 + 자체 Acanthamoeba 시험 + 증발 저항 + L929 + 3개월 임상
       ↓
  adverse events ≤3% (시판 12% 대비 4배 ↓) + Acanthamoeba 살균 ≥3-log
```

---

## 3. 🧪 자체 시험 SOP (시판 약점 보강)

### 3-1. Acanthamoeba castellanii 살균력 시험 (시판 X)

| 항목 | 표준 |
|---|---|
| 균주 | A. castellanii ATCC 30010 + 30234 (trophozoite + cyst) |
| 시간 | 5min · 6h · 24h |
| 기준 | trophozoite ≥3-log · cyst ≥1-log (자체 목표) |
| 견적 | 200-400만원 (KCL·KTR) |

### 3-2. 증발 저항 시험 (시판 X)

| 항목 | 표준 |
|---|---|
| 조건 | 25°C 50% RH · 7일 미밀폐 |
| 농축 | 2× · 4× → ISO 14729 재시험 |
| 기준 | 살균력 ≥80% 유지 |

### 3-3. 컬러렌즈 색소 보호 시험 (시판 X — 블루오션)

| 항목 | 표준 (자체) |
|---|---|
| 컬러렌즈 | 한국 시판 TOP 3 (오렌즈·올렌즈·렌즈샵) |
| 침지 회수 | 30회 (30일 반복) |
| 측정 | 색차계 ΔE (CIELAB) |
| 기준 | ΔE ≤2.0 (육안 인식 한도) |

---

## 4. 🎯 통합 처방 — Pilot D (research 정합)

| 성분 | 농도 | 역할 (시판 약점 보강) | 측정 가능 USP |
|---|---|---|---|
| PHMB | 0.0001% | 박테리아·곰팡이 (기본) | ISO 14729 ≥3-log |
| 폴락사머 407 | 1% | 세척 + 점도 | 단백질 세척 |
| **마이리스타미도프로필 디메틸아민** | 0.0005% | **Acanthamoeba 보조 살균** ★ | trophozoite ≥3-log |
| 히알루론산 | 0.05% | 보습 + 점막 친화 | 안구 자극↓ |
| EDTA | 0.05% | TiO2 안정 + Fe 킬레이션 | 색소 보호 ΔE↓ |
| 토코페롤 (α-) | 0.01% | 항산화 (색소 산화 방지) | 색소 유지 |
| 시트르산 완충 | — | pH 7.2 안정 | 안구 호환 |

### 차별 매트릭스

| 시험 | 시판 평균 | Pilot D 목표 |
|---|---|---|
| ISO 14729 박테리아 3종 | 3-log | ≥3-log (동등) |
| ISO 14729 곰팡이 2종 | 1-log | ≥1-log (동등) |
| **Acanthamoeba** | **시험 안 함** | ★ trophozoite ≥3-log |
| L929 cytotoxicity | grade 3 | **grade 1** ★ |
| **증발 저항 (4× 농축)** | **미공개** | ★ 살균력 80% 유지 |
| **컬러렌즈 색차 (30회)** | **미공개** | ★ ΔE ≤2.0 |
| **3개월 임상 adverse events** | 11.8% | ★ ≤3% |

---

## 5. 🛠 외부 라이브러리 포팅 후보

| 라이브러리 | 활용 |
|---|---|
| **scikit-image** | 컬러렌즈 색차 자동 측정 (이미지 분석) |
| **OpenCV** | 색차계 ΔE 계산·CIELAB 변환 |
| **scipy.optimize** | PHMB·MPDA 농도 최적화 (multi-objective: 살균력 vs 자극↓) |
| **GROMACS / OpenMM** | PHMB-각막세포막 분자동역학 시뮬 (자극성 예측) |
| **RDKit** | 마이리스타미도프로필 디메틸아민 분자 특성 |
| **statsmodels** | 3개월 임상 통계 (시판 vs Pilot D head-to-head) |

---

## 6. 🚀 진입 정공법 재정의

```
Phase 1 (3-4개월·1,000-2,000만원)
  ISO 14729 6 균주 + Acanthamoeba 자체 시험 + L929 + Franz
  → Pilot D 처방 lock-down

Phase 2 (2-3개월·1,000-2,000만원)
  컬러렌즈 색소 보호 자체 시험 (한국 시판 TOP 3 × 30회 침지)
  → 블루오션 데이터 무기 확보

Phase 3 (3-6개월·5,000-10,000만원)
  3개월 double-masked 임상 (n=270, 5 lens types)
  → adverse events ≤3% 입증 (시판 12% vs 4배↓)

Phase 4 (3-4개월·1,000-2,000만원)
  의약외품 품목허가 (식약처 MFDS 27295 자료집 기준) + 양산
  → 쿠팡·다이소·컬러렌즈 브랜드 묶음 출시

총: 11-17개월 · 8,000-16,000만원
```

## 출처

- [WebSearch — Contact lens MPS preservatives review](https://pmc.ncbi.nlm.nih.gov/articles/PMC8434857/)
- [WebSearch — Polyquaternium-1 + PHMB US patent 6,930,077](https://image-ppubs.uspto.gov/dirsearch-public/print/downloadPdf/6930077)
- [WebSearch — sub-PPM PQ-1 + high MW PHMB US 7,105,473](https://image-ppubs.uspto.gov/dirsearch-public/print/downloadPdf/7105473)
- [PMC 3974296 — New MPS comparative analysis (microbiological·biological·clinical)](https://pmc.ncbi.nlm.nih.gov/articles/PMC3974296/)
- [Contact Lens Spectrum 2024/11-12 — Science behind lens care](https://www.clspectrum.com/issues/2024/novemberdecember/the-science-behind-lens-care/)
- [Systematic Review on MPS Ingredients (researchgate)](https://www.researchgate.net/publication/377058993)
- [MFDS 27295 — 콘택트렌즈 관리용품 살균력 시험 자료집](https://www.mfds.go.kr/brd/m_218/view.do?seq=27295)
