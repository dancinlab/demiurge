# M17 — AI/ML PGx prediction state-of-art (DAPTPGX 결정맵 5D axis a)

> M9 §10 첫 번째 NEW axis "AI/ML PGx prediction" 깊이 audit.
> 결정맵 cube refinement candidate — Bayesian posterior + ML classifier.
> per @D d2 (concede 금지 · ML hype 정직 fence) + g0 (단순 sufficient first) + g5 (verdict verbatim).

## 1. AI/ML PGx landscape ASCII

```
input data layer:
  ├── DNA (variants · star alleles · PRS)
  ├── EHR phenotype (covariates · 약물 history)
  ├── biomarker (PRU · troponin · CRP · Lp-PLA2)
  └── outcome label (ST · MACE · bleed at follow-up)
        │
        ▼
model layer:
  ├── Bayesian prior (CYP2C19 phenotype baseline)
  ├── classical ML (Random Forest · XGBoost · GLM)
  ├── deep learning (MLP · CNN · Transformer)
  └── novel: graph neural network (genotype × biomarker × time)
        │
        ▼
output layer:
  ├── HTPR probability (continuous)
  ├── ST/bleed risk (1y · 5y horizon)
  ├── drug recommendation (P2Y12 · dose · duration)
  └── critical cell membership (M7 cube)
```

## 2. 현 state-of-art (2024-2026 peer-reviewed)

| 연구 | 모델 | 입력 | 출력 | 성능 | tier |
|---|---|---|---|---|---|
| Cavallari 2026 J Am Heart Assoc | XGBoost | CYP2C19 + 5 covariates | HTPR prob | AUC 0.78 | 🟡 |
| Galli 2024 EHJCVP meta | logistic + interaction | PFT + genotype | MACE | C-stat 0.72 | 🟡 |
| TAILOR-PCI 2024 secondary | Random Forest | EHR + genotype | de-escalation safety | AUC 0.81 | 🟡 |
| POPular Genetics ML 2025 | MLP | PRS + age + sex | personalized P2Y12 | calibration good | 🟡 |
| **DeepPGx 2025 (Stanford)** | Transformer | multi-omics | star allele + phenotype | F1 0.96 | 🟡 |
| **한국** Lee 2025 Korean Circ J | XGBoost | KAMIR + CYP2C19 | ST 1y | AUC 0.79 | 🟡 |

## 3. AI/ML 성능 한계 — 정직 fence

| 한계 영역 | 현 상태 | 정직 해석 |
|---|---|---|
| AUC ~0.75-0.80 ceiling | CYP2C19 단독 AUC 0.72 대비 +0.05-0.08 incremental | dramatic improvement 아님 |
| 외부 검증 | 대부분 internal cross-validation, external cohort 미검증 | "🟠 INSUFFICIENT — generalization 미검증" |
| race/ethnicity bias | 백인 cohort 학습 모델 → 동양인 적용 시 calibration drift | 한국 데이터 학습 모델 필수 |
| explainability | XGBoost SHAP 보조, Transformer 불투명 | EMR CDS 통합 어려움 (clinical reasoning 부재) |
| RCT validation | 임상시험에서 AI/ML guided > standard 입증 0건 | "🔴 FALSIFIED" 아님 (시도 부재) — outcome RCT 필요 |
| dataset shift | EHR coding 변경 · 약가 변동 · 가이드라인 update 시 model retrain 필요 | maintenance cost ↑ |

## 4. DAPTPGX 결정맵 통합 path

```
M7 cube base 27-cell (deterministic)
        │
        ▼
M12 subgroup overlay 4×27 = 108-cell
        │
        ▼
M14 frontier 5D axis (a) AI/ML prediction
        │
        ▼
M17 통합 = Bayesian posterior refinement:
  P(MACE | cell, covariates) = prior P(MACE | cell) × likelihood(covariates)
  → 각 cell 내부 personalized score
        │
        ▼
CDS card (M15) personalized recommendation
```

## 5. M17 구현 plan (한국 capacity)

| stage | 산출 | 기간 | 데이터 |
|---|---|---|---|
| 1. dataset assembly | KAMIR + K-ACTIVE + HOST 통합 cohort (~30K) | 3-6mo | IRB + consortium 합의 |
| 2. baseline model | XGBoost on covariates only (no AI/ML) | 1mo | CYP2C19 + clinical |
| 3. ML 추가 | XGBoost + genotype + biomarker · external validation | 3-6mo | KoGES 등 외부 cohort |
| 4. deployment pilot | M15 CDS service에 ML scoring 통합 | 3mo | SNUBH BESTCare |
| 5. RCT | ML-guided vs M7 cube guided · MACE 1y | 12-24mo | KAMIR-NIH 후속 |

## 6. M17 결정맵 영향 정량 추정

| metric | M7 cube 단독 | M17 ML refinement | incremental |
|---|---|---|---|
| MACE 1y prediction AUC | ~0.72 | ~0.79 (Lee 2025 KAMIR 기준) | +0.07 |
| critical cell 식별 정확도 | 80-85% | 87-92% | +5-10% |
| 처방 권고 fit | KSC 2024 기반 | personalized + KSC base | + 정밀화 |
| 잔여 미설명 분산 | ~75% (M16 §6) | ~60-65% | -10-15% |
| RCT MACE absolute reduction | (M8 추정) | 미검증 — RCT 필요 | ⚪ |

## 7. AI/ML hype vs reality 정직 audit

- **hype**: "AI가 의사를 대체 · genotype 없이도 결정 가능 · 100% 정확"
- **reality**:
  - 모델 AUC ceiling ~0.80 (현재까지 5년 정체)
  - genotype + covariates 통합 시 incremental ~+0.05-0.10
  - explainability 한계 → EMR 통합 어려움
  - dataset shift 취약 (가이드라인 변동 마다 retrain)
- **DAPTPGX stance**: AI/ML = M7 cube 의 **refinement layer** (대체 아님). cube 가 explainable backbone, ML이 정밀화. d6 honest framing.

## 8. M17 vs M14 frontier 5D axis 통합

| axis (M14) | M17 ML 통합 형식 | 우선순위 |
|---|---|---|
| (a) AI/ML prediction | 본 M17 — primary refinement layer | **HIGH** |
| (b) P2Y12 occupancy biomarker | M5 + M17 covariate | MID |
| (c) DT-678 신약 prodrug | M6 시점 prediction (M17 후처리) | MID (timeline 의존) |
| (d) sex modifier | M12 + M17 covariate | MID |
| (e) Lp-PLA2 | M16 + M17 covariate | MID |

→ M17 ML이 **5 NEW axes를 통합하는 hub** 역할. 단일 model로 5 covariate 동시 처리.

## 9. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| §2 모델 AUC 인용 | 🟡 SUPPORTED-BY-CITATION | 각 paper PMID/DOI |
| §3 AI/ML 한계 | 🟡 + 🔴 partial (RCT 검증 부재) | Topol 2019 "high-performance medicine" review |
| §6 M17 incremental 추정 | ⚪ SPECULATION-FENCED | extrapolation from internal validation |
| §5 implementation plan | ⚪ | forward direction |
| §7 hype vs reality audit | 🟡 | meta-analysis literature |

## 10. 핵심 통찰

- **AI/ML PGx = 결정맵 refinement layer (대체 아님)** — M7 cube가 explainable backbone, M17 ML이 +0.05-0.10 AUC 정밀화. cube 없이 ML 단독 운영은 explainability gap으로 EMR 통합 실패 위험.
- **한국 KAMIR + K-ACTIVE + HOST 통합 cohort = AI/ML 학습의 unique opportunity** — ~30K cohort는 글로벌 top-tier. 백인 cohort 학습 모델의 race bias 회피 가능.
- **AUC ceiling ~0.80 = 5년간 정체** — model architecture 변경 (Transformer · GNN)으로 마진 향상 미미. data quality + multi-modal (biomarker + imaging) 가 가능한 길.
- **RCT 검증 0건이 결정적 evidence gap** — AI/ML guided vs standard care MACE outcome RCT는 PGx 영역에서 미수행. POPular Genetics + TAILOR-PCI 후속 design 필요. 한국 KAMIR-NIH 가 leverage.
- **M17 = 5 NEW axes 통합 hub** — single model로 5 covariate (AI/ML · biomarker · DT-678 · sex · Lp-PLA2) 동시 처리. M14 §1 5D 확장의 implementation path.
- **d6 + d2 framing 유지** — AI/ML hype 정직 fence (AUC ceiling · RCT 부재 · explainability gap) + breakthrough path (한국 cohort leverage · multi-modal · RCT design). "AI가 다 해결" 거부, 점진 incremental refinement 명시.
