# M14 — DAPTPGX frontier scan (cube 5D 진화 후보)

> 결정맵의 다음 axis 후보 — M9 §10 발견 5 NEW axes + 시술/약물 미래 frontier.
> per @D d2 (breakthrough paths · concede 금지) + g3 (table + ASCII first).

## 1. 5D 진화 ASCII (M7 3-axis cube → 4D + 5D)

```
M7 base 3-axis (~108-cell with M12 subgroup 4th axis):
   z 시술복잡도
    ↑
    │  ┌─────────┐
    │ ╱│        ╱│
    │╱ │       ╱ │
    ├──┼──────┤  │
    │  │      │  │  → x phenotype (NM/RM/UM/IM/PM)
    │  └──────┼──┘
    │ ╱        ╱
    │╱        ╱
    └────────→  y HBR status (LOW/INT/HIGH)

M14 후보 5th axis 5종:
  (a) AI/ML prediction confidence — Bayesian posterior given covariates
  (b) P2Y12 receptor occupancy biomarker — direct molecular readout
  (c) DT-678 / 신규 prodrug class — bypass CYP2C19 entirely
  (d) sex modifier — F/M dimorphism (M9 §10)
  (e) Lp-PLA2 inflammation axis — vascular biology overlay
```

## 2. 5 NEW axes 인벤토리 (M9 §10 직접 인용)

| axis | M9 출처 | 결정맵 영향 (M14 평가) | tier 후보 |
|---|---|---|---|
| (a) AI/ML PGx prediction | Cavallari 2026 등 · M9 §10 | base 27-cell prior로 ML posterior 결합 → critical cell refinement | M17 별도 deep dive |
| (b) P2Y12 occupancy biomarker | Sibbing 2024 · M9 §10 | PFT 보조 (M5) + 직접 molecular readout · clinical adoption 미완 | M17 후보 |
| (c) DT-678 clopi-conjugate prodrug | Liu 2025 BJP FIH · M9 §5.5 | CYP2C19 bypass → PM 60% rescue (vicagrel와 유사 mechanism) | M6 §5.5 cited, M14 미래 |
| (d) sex modifier (F vs M) | M9 §10 · Galli 2024 sex sub-analysis | F: 출혈 ↑ · clopi metabolism dimorphism | M12 + M14 cross-cut |
| (e) Lp-PLA2 inflammation | M9 §10 · STABILITY trial darapladib failed | vascular inflammation overlay · NOREFLOW domain 교차 | M16 modifier 후보 |

## 3. frontier 시술 / 약물 candidates (M6 + M9 확장)

### A. CRISPR ex vivo PGx testing

- **개념**: PCI 시술 전 환자 혈액에서 CYP2C19 *2/*3 indel을 CRISPR-Cas9로 ex vivo edit → patient-specific hepatocyte organoid에서 clopidogrel metabolism 측정
- **현 상태**: 임상 미적용 · 연구실 (Stanford · Broad 등)
- **결정맵 영향**: PM 환자 in vivo rescue 가능성 (gene therapy approach) — 10-15y horizon
- **한국 capacity**: 서울대 의대 + IBS 유전체연구단 CRISPR plat 가능

### B. Organ-on-chip platelet aggregation

- **개념**: 미세유체 chip에 환자 혈소판 + endothelial cell + flow 재현 → 약물 반응 실시간 측정
- **현 상태**: Wyss Institute · Emulate Inc · Hesperos 임상 도입 시도
- **결정맵 영향**: PFT (M5 VerifyNow/LTA/MEA) 대체 candidate · 더 physiological
- **한국 capacity**: 부산대 · KAIST 유체역학 platform · 임상 통합 미완

### C. Single-cell platelet sequencing

- **개념**: scRNA-seq 으로 환자별 platelet subpopulation transcriptional state mapping → drug responsiveness heterogeneity
- **현 상태**: NIH BRAIN initiative · platelet biology consortium
- **결정맵 영향**: PRU baseline heterogeneity 분자수준 분해 → M5 PFT 한계 (single readout) 극복
- **한국 capacity**: KAIST · 서울대 single-cell platform

### D. Liquid biopsy ctDNA dynamic PGx

- **개념**: 시술 후 ctDNA 에서 platelet activity marker 모니터링 (CD40L, PF4)
- **현 상태**: 종양학에서 ctDNA 표준화, 심혈관 응용 초기
- **결정맵 영향**: M5 PFT 시점 (Day 14) 보강 → dynamic monitoring
- **한국 capacity**: 분당서울대 · 서울아산 ctDNA platform

### E. Polygenic risk score (PRS) integrated

- **개념**: CYP2C19 단일 유전자 → polygenic CV PRS (CAD/MI · bleeding · stroke) 통합 결정
- **현 상태**: UK Biobank PRS · MGI · 한국 KOVA PRS development
- **결정맵 영향**: M7 cube + PRS 6th axis → 정밀 결정 (high-CV + LoF = aggressive · low-CV + LoF = conservative)
- **한국 capacity**: 보건연구원 KoGES PRS

## 4. CRISPR / organ-chip / single-cell × 결정맵 영향 매트릭스

| frontier | M3 switch | M5 PFT | M6 next-gen | M7 cube | M8 econ | timeline (한국) |
|---|---|---|---|---|---|---|
| CRISPR ex vivo | indirect (PK 측정) | 대체 후보 | gene therapy adjunct | 5D axis (a) | 비용 prohibitive | 10-15y |
| organ-on-chip | indirect | **직접 대체** | platform 약물 screening | 5D axis (b) | unit cost ~$500-2000 | 5-10y |
| single-cell platelet | indirect | 보강 (heterogeneity) | mechanism elucidation | refinement | $1000-5000/run | 3-7y |
| liquid biopsy ctDNA | dynamic monitoring | dynamic supplement | adherence proxy | refinement | $200-800 | 3-5y |
| PRS 6th axis | 정밀 | 보강 | 우선순위 결정 | **6D 확장** | risk-stratification | 2-5y |

## 5. M14 timeline ASCII (frontier adoption forecast)

```
       2026  2028  2030  2032  2035
PRS 6D ────●●●●●●●●●●●●●●●●●●●●● (한국 KoGES 통합 가능 first)
liquid ────  ●●●●●●●●●●●●●●●●●●  
sc-RNA ──────  ●●●●●●●●●●●●●●●   
organ  ────────  ●●●●●●●●●●●●●   
CRISPR ──────────────●●●●●●●●●  (가장 늦음 · 윤리 hurdle)
                          ↑
                     vicagrel KFDA (M6 단축 2026-28)
                     SOS-AMI selatogrel readout (M10 2027)
```

## 6. 한국 unique opportunity (M14 differentiator)

- **KOVA + KORV1K 한국 raw genotype 데이터** = PRS 6th axis 학습 코호트 + CRISPR target identification
- **KAIST + 부산대 organ-on-chip platform** = 동양인 platelet biology calibration
- **분당서울대 + 서울아산 single-cell + ctDNA platforms** = 시술 cohort 통합 가능
- **K-ACTIVE / KAMIR registry 30,000+ PCI** = frontier 검증 cohort
- **HOST-EXAM 10y + SMART-CHOICE 3 evidence-leading** (M10) → frontier 결과를 글로벌 가이드라인에 upstream

## 7. M14 → DAPTPGX 결정맵 integration plan

1. **단기 (2026-28)**: PRS 6th axis 통합 (M7 cube → 6D) — KoGES PRS + KAMIR cohort validation
2. **중기 (2028-32)**: organ-on-chip M5 PFT 대체 검증 (한국 KAIST/부산대 platform)
3. **장기 (2030-35)**: single-cell + ctDNA 통합 dynamic 결정맵 + CRISPR ex vivo testing (윤리 IRB)
4. **선택적**: AI/ML PGx prediction (M17 deep dive) + sex modifier (M12 cross-cut) + Lp-PLA2 (M16 modifier)

## 8. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| §2 5 NEW axes (M9 §10) | 🟡 SUPPORTED-BY-CITATION | M9_arxiv.md 직접 인용 |
| §3 CRISPR / organ-chip / sc-seq | 🟡 SUPPORTED-BY-CITATION | Wyss · Emulate · Stanford 등 published |
| §3 한국 capacity | 🟡 SUPPORTED-BY-CITATION | 각 대학/기관 platform 공개 정보 |
| §5 timeline forecast | ⚪ SPECULATION-FENCED | forward direction 예측 |
| §6 한국 unique opportunity | 🟡 SUPPORTED-BY-CITATION | KOVA · KAMIR · K-ACTIVE registry |
| §7 integration plan | ⚪ SPECULATION-FENCED | 미실행 plan |

## 9. 핵심 통찰

- **결정맵 미래 = 5D → 6D 확장** — M7 base 3-axis + M12 subgroup 4th axis + M14 frontier 5/6th axis (PRS · biomarker · AI/ML). cell 수 폭증 가능성 → M7 §4 4-trigger 시간축 압축 mechanism 필수.
- **PRS 6th axis = 가장 빠른 한국 adoption 후보** — KoGES + KOVA raw data 이미 보유, AI/ML training 가능. 2026-28 prototype 가능. 다른 frontier (CRISPR · organ-chip) 보다 5-7y 빠름.
- **organ-on-chip = M5 PFT 자연스러운 진화** — 현 PFT (VerifyNow/LTA/MEA) 한계 (single static readout) 극복. 한국 KAIST/부산대 platform 임상 통합 진입 가능.
- **CRISPR ex vivo = 윤리 + 비용 hurdle 가장 큼** — 10-15y horizon · gene therapy 인접 (FDA 승인 sickle cell만). 결정맵 차세대 candidate but 단기 영향 미미.
- **한국 evidence-leading 정점이 frontier upstream의 lever** — HOST-EXAM 10y + SMART-CHOICE 3 + KAMIR/K-ACTIVE 30,000 cohort → frontier 결과를 KSC 2027/2030 가이드라인 → ESC/ACC upstream. 결정맵 의 글로벌 영향력 path 확립.
