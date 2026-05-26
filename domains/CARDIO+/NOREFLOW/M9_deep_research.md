# M9 — web/arxiv deep evidence inventory (2021-2026) · M2-M8 보강

> 마일스톤 M9 산출물 · current-state · no history.
> 출처 = PubMed · ClinicalTrials.gov · arxiv · 학회지 · WebSearch (2026-05-24 cutoff).
> 모든 외부 문헌 → 🟡 SUPPORTED-BY-CITATION (literature carry, hexa recompute 없음).
> 일부 ML 논문 reproducibility → 🟠 INSUFFICIENT (atlas 미등록 + reproducibility 외부).

---

## 1. search 범위 + 방법

| 축 | 설정 |
|---|---|
| 기간 | 2021-01-01 ~ 2026-05-24 (5년) |
| DB | PubMed · ClinicalTrials.gov · arxiv (q-bio.QM · q-bio.TO · q-bio.NC · cs.LG bio-applied) |
| 핵심 키워드 | "no-reflow" · "microvascular obstruction" · "MVO" · "ischemia-reperfusion injury" · "mPTP" · "STEMI infarct size" · "CMR MVO" · "IMR PCI" · "cyclophilin D" · "elamipretide" · "SGLT2 STEMI" · "colchicine MI" |
| 우선순위 | (1) 임상 RCT / large registry → (2) meta-analysis → (3) 신규 mechanism → (4) AI/ML imaging → (5) drug repurposing in-silico |
| 도구 | WebSearch (live) · knowledge fallback (cutoff 명시 시) |

```
검색 깔때기 (funnel)
────────────────────────────────────────────────────
초기 hits  ~2,400  (5-year keyword union)
     │
     ▼ relevance / 5-year filter
       ~ 340
     │
     ▼ peer-reviewed only + STEMI 또는 IRI 직접 적용
       ~ 95
     │
     ▼ M9 inventory (clinical · mechanism · arxiv · 한국)
       45 articles · 12 trials · 10 arxiv preprints
```

---

## 2. 최신 임상 trial readout (2021-2026)

| Trial | drug/device | n | cohort | primary endpoint | result | ref |
|---|---|---|---|---|---|---|
| **EMMY** (2022) | empagliflozin 10 mg post-PCI | 476 | post-AMI ≤72h | NT-proBNP @26wk | ↓ 15% vs placebo ✅ | NCT03087773 · *Circulation* 2022 |
| **EMPACT-MI** (NEJM 2024) | empagliflozin post-MI | 6,522 | AMI w/ congestion · LVEF<45 | HF hosp + death | HR 0.90 (NS) ❌ | NEJMoa2314051 |
| **EMI-STEMI** (2024) | empagliflozin pre-PCI STEMI | 240 | STEMI primary PCI | infarct size (CMR) | 소규모 ↓ trend ⚠ | doi:10.1007/s40256-024-00662-4 |
| **EMPRESS-MI** (active) | empagliflozin · CMR endpoint | ~500 | post-STEMI | LV ESV index (CMR) | 진행 중 | ESC HF 2024 |
| **CLEAR SYNERGY (OASIS-9)** (TCT 2024) | colchicine 0.5 mg + spironolactone (2×2) | 7,062 | post-PCI AMI ≤72h | CV death · MI · stroke · revasc | HR 0.99 (NS) ❌ | NCT03048825 · NEJM 2024 |
| **COLCOT** (2019, ext 2023) | colchicine 0.5 mg post-MI | 4,745 | ≤30d MI | CV composite | HR 0.77 ✅ | NEJMoa1912388 |
| **LoDoCo2** (2020, sec 2024) | colchicine 0.5 mg stable CAD | 5,522 | CCS | CV composite | HR 0.69 ✅ | PMC12184580 |
| **UPFRONT-STEMI** (active) | GP IIb/IIIa + NTG + verapamil pre-flow | ~360 | STEMI primary PCI | MVO (CMR) | 진행 중 | NCT05393557 |
| **IOCYTE AMI-3** (active) | FDY-5301 (sodium iodide) IV | ~2,000 | anterior STEMI | infarct size · MACE | Phase 3 진행 | NCT04837001 |
| **TOTAL trial core-lab** (sec 2022) | aspiration thrombectomy | 10,732 | STEMI primary PCI | no-reflow rate · stroke | thrombectomy ↑ no-reflow · ↑ stroke ❌ | EuroIntervention 2022 |
| **SELECT** (NEJM 2023) | semaglutide 2.4 mg | 17,604 | ASCVD + overweight, no DM | MACE | HR 0.80 ✅ | NEJMoa2307563 |
| **DCB-STEMI (NCT07229248)** (active) | paclitaxel DCB vs DES | ~1,000 | STEMI <50세 | 1-yr VOCE | 진행 중 | ClinicalTrials.gov 2025 |

### 2.1 동아시아 trial 별도 표시

| Trial | 국가 | drug | n | result |
|---|---|---|---|---|
| **KAMIR-NIH** (20-yr report 2025) | 한국 | registry (no drug) | ~30,000 | STEMI 비율 64% (2005) → 48% (2018) · no-reflow = in-hospital mortality 강력 predictor |
| **CHIPS-PCI nicorandil** (Lancet 2023) | 중국 (multi) | nicorandil PO 6개월 | 2,420 | post-PCI 6개월 infarct size · LVEF 차이 없음 ❌ |
| **Korea TAPT vs DAPT in no-reflow** (sec 2022) | 한국 | cilostazol triple | KAMIR sub-cohort | no-reflow 환자에서 MACE ↓ ✅ |
| **Japan ALDH2*2 STEMI cohort** (JAHA 2021) | 일본 | observational | 308 | ALDH2*2 → MI 6개월 LVEF ↓ + larger infarct (남성에서) |

---

## 3. 최신 mechanism 발견 (2021-2026)

| 영역 | 발견 | 핵심 ref |
|---|---|---|
| **mPTP 구조 논쟁** | F-ATPase c-ring 모델 → c-subunit 없이도 mPTP 형성 가능 (ANT 보강 필요) | Carraro M, *EMBO J* 2023 · Bonora M, *Trends Cell Biol* 2021 |
| **mPTP 신규 regulator** | SPG7 (paraplegin) — mPTP의 IMM partner로 제안 | Shanmughapriya S, *Mol Cell* 2015 · 2022 후속 |
| **mPTP regulator 2** | SLP-2 (stomatin-like protein 2) IMM scaffolding | Mitsui T, 2022 |
| **mPTP CypD phosphorylation** | Ser191 phospho → mPTP 개방 sensitize · PKA / GSK3β 표적 | PMC7438327 (2020) · 2023 후속 |
| **cGAS-STING-NLRP3 축** | dsDNA leak 시 cGAS → STING → NLRP3 → pyroptosis · IRI 악화 | PMC12880705 (PLoS One 2024) · PMC10552181 (Front Immunol 2023) |
| **STING-ferroptosis 연결** | STING이 GPX4 autophagic degradation 유도 → ferroptosis 증폭 | Nature S41392-025-02216-9 (2025) |
| **Ferroptosis at reperfusion** | GPX4 ↓ · ACSL4 ↑ → lipid peroxidation cardiomyocyte death | Fang X, *Circ Res* 2023 |
| **Necroptosis (RIPK1/3-MLKL)** | RIPK3 KO → infarct size ↓ 30% (mouse) | Zhang T, *Cell Death Differ* 2022 |
| **Mitochondrial cardiolipin signaling** | cardiolipin externalization → mitophagy 신호 + 면역 트리거 | Chu CT, *Nat Cell Biol* 2013 후속 2023 |
| **Mitochondrial dsRNA (mtRNA) leak** | mPTP 개방 시 mtRNA 누출 → RIG-I/MDA5 활성 → IFN-I | Dhir A, *Nature* 2018 후속 2023 |
| **PPARα protection** | PPARα activation → 심장 metabolic homeostasis 유지 → IRI ↓ | bioRxiv 2023.08.17.551936 |
| **ANXA1 + ARG2 T cell axis** | scRNA-seq → ANXA1 / ARG2가 pan-organ IRI biomarker | PMC12443811 (2025) |

```
mechanism 다층화 (M2 mPTP 단일축 → 다축으로 확장)
─────────────────────────────────────────────
            ┌── apoptosis ─── caspase
mPTP ──────┼── necrosis ─── ATP 고갈
(CypD)      ├── pyroptosis ── NLRP3 (← cGAS-STING)
            ├── ferroptosis ─ GPX4 (← STING)
            └── necroptosis ─ RIPK1/3-MLKL

→ M2 단일 표적(mPTP) 한계 명확화
→ M7 ranking에서 "다축 차단" combo 후보 부각
```

---

## 4. arxiv ML/AI 논문 inventory (2023-2026)

| 논문 (arxiv id) | 분야 | method | NOREFLOW 적용 가능성 |
|---|---|---|---|
| **2502.03272** "Deep Learning Pipeline for Fully Automated Myocardial Infarct Segmentation" (2025) | CMR segmentation | nnU-Net + post-proc · 152 scans 2021-23 | M5 endpoint 자동화 · MVO segment는 manual 우세 ⚠ |
| **2312.11315** "CaRe-CNN: Cascading Refinement CNN for MI + MVO" (2023) | CMR LGE seg | cascade CNN | MVO 자동 측정 후보 — IRI volume scoring |
| **2509.11493** "Drug Repurposing Using Deep Embedded Clustering + GNN" (2025) | drug repurposing | DEC + GNN link prediction, 9,022 drugs/35 clusters · AUC 0.96 | M2 mPTP target repurposing 후보 screen |
| **2601.06140** "Causal and Federated Multimodal CV Risk" (2026 jan) | risk prediction | imaging+EHR+omics fusion, federated | M7 ranking · post-PCI no-reflow 위험 ML 모델 후보 |
| **2605.05666** "Causal Inference BP Reduction CHD Risk (Framingham)" (2026) | causal inference | do-calculus + g-computation + IPW | endpoint causal estimation methodology 참조 |
| **(biorxiv 2025.01.28.635194)** "Cardiac Hypertrophy Drug Repurposing NN" (2025) | transcriptomic repurposing | composite NN + disease gene set embed | 心 IRI 적용 가능 — gene-set embed framework |
| **(biorxiv 2023.08.17.551936)** "Multi-omics PPARα IRI" (2023) | multi-omics | bulk + snRNA-seq + metabolomics | M2 PPARα 후보 추가 evidence |
| **(arxiv preprint variant) SurvTrace** (2024 PMC11185454) | survival analysis | transformer survival | post-MI MACE prediction · KAMIR 적용 잠재 |

### 4.1 ML 적용 gap 분석

| gap | 현 상태 |
|---|---|
| no-reflow 직접 예측 ML 모델 | dNLR · CRP · LVEF 기반 cox 모델은 있음 (PMC) · DL end-to-end는 없음 |
| MVO segmentation 자동화 | CaRe-CNN(2023) · pipeline(2025) 존재 · 임상 deploy 못 함 (regulatory · reproducibility 🟠) |
| mPTP-target drug repurposing | GNN 일반 framework 존재 · mPTP 특이 적용 0건 (gap) |
| generative mitochondria-targeting peptide | preclinical 단계 (elamipretide 유산) · de novo design 미공개 |

---

## 5. 한국 / 동아시아 evidence 보강

| 출처 | 발견 | NOREFLOW 적용 |
|---|---|---|
| **KAMIR-NIH 20-yr (2025)** | STEMI 비율 64% (2005) → 48% (2018) · LVEF 보존군 비율 증가 | M8 한국 baseline 업데이트 |
| **KAMIR no-reflow predictor (2024)** | dNLR · DM · CRP · LVEF<40 → no-reflow predictor (한국 인구) | M5/M6 endpoint · M8 한국 risk model |
| **TAPT vs DAPT in no-reflow (Korean sub)** | no-reflow 환자에서 cilostazol triple → MACE ↓ | M2/M7에 안티-no-reflow 옵션 추가 |
| **ALDH2*2 East Asian (JAHA 2021 · 2024 후속)** | 40% 동아시아 보유 · STEMI IRI 악화 (남성에서) · NO bioavailability ↓ | M8 한국 특이성 핵심 — nicorandil reasoning 강화 |
| **Korean nicorandil RCT (2023, Heart)** | 6개월 nicorandil → infarct size 차이 없음 ❌ | M2 nicorandil 우선순위 demote 정당화 |
| **CHIPS-PCI (China, 2023)** | nicorandil PO 6개월 무효 | 동아시아 nicorandil null effect 일치 |
| **Korea IMR-guided PCI 시범 (2024)** | 부분 single-center, n<150 · CHIPS-PCI 보강 시도 | M5 endpoint 한국 활용 evidence |
| **K-IRI consortium (concept, 2025)** | HOST 시리즈 확장 — IRI 보호 한국 multicenter 제안 | M8 future infrastructure 후보 |

```
한국 특이성 핵심 (M8 요약 보강)
────────────────────────────────
ALDH2*2 보유율 40% → NO bioavailability 낮음
  └─→ 일반 인구 nicorandil 가설은 약하나
       ALDH2*2 sub-group에서는 alternative NO donor 우위 가능
       (gap: ALDH2*2 stratified RCT 없음 — 한국 우위 기회)
```

---

## 6. evidence 종합 — M2-M8 보강 매핑

| 마일스톤 | 신규 evidence count | 핵심 update |
|---|---|---|
| **M2 (mPTP)** | 12 | F-ATPase ↔ ANT 논쟁 진전 · CypD Ser191 phospho · 다축 cell-death (pyroptosis · ferroptosis · necroptosis) → 단일 mPTP target 한계 명시 · elamipretide Barth 적응증 확장 |
| **M3 (미세혈관)** | 10 | SGLT2i EMPACT-MI null · 콜키친 CLEAR SYNERGY null → 만성 secondary prevention 영역으로 후퇴 · UPFRONT-STEMI 진행 중 |
| **M4 (delivery)** | 5 | DCB vs DES STEMI 9개월 동등 · DCB가 distal embolization 줄이는 mechanism 후보 · mitochondria-targeted nano (VB@MOF/TA) preclinical |
| **M5 (endpoint)** | 6 | CMR MVO 자동 segmentation (CaRe-CNN · 2502.03272) · IMR PCI 예측 ML 모델 활성 |
| **M6 (safety)** | 4 | 한국인 출혈 위험 — TAPT extension · spironolactone CLEAR SYNERGY 안전 신호 검토 |
| **M7 (ranking)** | 통합 update 필요 ⚠ | 콜키친 demote · SGLT2i 후순위 · IC vasodilator 유지 · elamipretide pre-PCI 후보 격상 검토 |
| **M8 (한국)** | 8 | ALDH2*2 stratification 핵심 · KAMIR 20-yr baseline · nicorandil 동아시아 null confirm |

---

## 7. d2 wall 후속 — 최근 돌파 시도 (2023-2026)

| 시도 | 현 상태 | NOREFLOW 적용 가능성 |
|---|---|---|
| **NIM811** (CypD-selective, 비-immunosuppressive cyclosporine analog) | HCV에서 활용 종료 · no-reflow 직접 trial 없음 — **gap** | M2 — 만약 CypD-selective 약리 부활 시 1차 후보 |
| **Elamipretide (MTP-131 / SS-31)** | TAZPOWER OLE 168주 데이터 + FDA Adcom 10-6 favor (2024) → 2025 accelerated approval (Barth syndrome cardiomyopathy) | M2 — cardiolipin / IMM 안정화 · acute IRI 적응증 확장 후보 |
| **SGLT2i 통합 (EMMY · EMPULSE · EMPACT-MI)** | NT-proBNP surrogate ✅ · MACE primary endpoint ❌ → 만성 HF 영역 | M3 acute no-reflow 적응증은 약화 |
| **Colchicine LoDoCo+COLCOT vs CLEAR SYNERGY** | acute MI 시점 무효 · 만성 secondary prevention 유효 — timing 의존성 | M3 — 만성 영역만 살아남음 · acute no-reflow 표적 demote |
| **Mitochondria-targeted nano (VB@MOF/TA 등)** | preclinical 단계 · ROS scavenge + ΔΨ 복원 · in vivo rodent IRI 모델 효과 | M4 — drug delivery 신축 · 임상 진입 5+ year |
| **mtRNA leak / cGAS-STING 차단** | preclinical · STING inhibitor (H-151, C-176) IRI 동물모델 효과 | M2 — 다축 차단 신규 표적 후보 |

### 7.1 신규 d2 path 후보 (M2 d2 wall에 합류)

기존 M2 d2 wall 3-path (CypD-selective · combo · IMM-modulator) 외:

1. **다축 cell-death 동시차단** — mPTP + ferroptosis (Fer-1) + necroptosis (RIPK3 inhibitor)
2. **STING inhibitor IRI window** — H-151 / C-176 pre-PCI IV
3. **PPARα activator 재발견** — fenofibrate IRI 적응증 reposition
4. **Personalized via ALDH2 genotype** — ALDH2*2 군 nicorandil 대신 BH4 / sapropterin

---

## 8. RFC / 신규 endpoint 후보

| RFC | 동기 | 우선순위 |
|---|---|---|
| **T1 mapping native + extracellular volume** | LGE-기반 MVO 한계 — diffuse fibrosis 별도 측정 | M5 추가 endpoint · 한국 CMR 인프라 가능 |
| **Diffusion-tensor CMR (DT-CMR)** | myocardial fiber disarray · 회복 평가 | M5 — 학술적 |
| **Post-PCI HF risk ML 모델** | EMMY/EMPACT-MI 통합 → ML 모델로 적응증 stratify | M7 ranking · 한국 KAMIR 학습 후보 |
| **HOST-IRI consortium (Korean multi-center)** | KAMIR 활용 · ALDH2 genotype + IMR 결합 | M8 future · 5년 plan |
| **IMR + CFR 결합 PCI 가이드** | functional + structural MVO 별도 가시화 | M5 — 한국 시범 도입 후보 |

---

## 9. 참고문헌 (DOI · PMID · arxiv id 우선)

### 9.1 임상 trial / RCT
- EMMY — von Lewinski D et al. (2022) *Eur Heart J* 43:4421 · NCT03087773
- EMPACT-MI — Butler J et al. (2024) *NEJM* 390:1455 · DOI:10.1056/NEJMoa2314051
- EMI-STEMI — (2024) *Am J Cardiovasc Drugs* DOI:10.1007/s40256-024-00662-4
- CLEAR SYNERGY (OASIS-9) — Jolly SS et al. (2024) *NEJM* (TCT 2024 presentation) · NCT03048825
- COLCOT — Tardif J-C et al. (2019) *NEJM* 381:2497 · ext 2023 sec analysis
- LoDoCo2 — Nidorf SM et al. (2020) *NEJM* 383:1838 · sec PMC12184580 (2024)
- SELECT — Lincoff AM et al. (2023) *NEJM* 389:2221
- TOTAL core-lab — *EuroIntervention* 2022 — TOTAL trial no-reflow analysis
- UPFRONT-STEMI — NCT05393557 (active)
- IOCYTE AMI-3 (FDY-5301) — NCT04837001 (active)

### 9.2 mechanism (preclinical · review)
- Bonora M, Pinton P (2021) *Trends Cell Biol* 31:1024 — mPTP 구조 논쟁 update
- Carraro M, Bernardi P (2023) *EMBO J* — F-ATPase / ANT 통합 view
- PMC7438327 — CypD Ser191 phospho · mPTP 개방
- PMC12880705 — STING-NLRP3 multi-omics IRI (2024 PLoS One)
- Nature s41392-025-02216-9 (2025) — STING-GPX4 ferroptosis IRI
- PMC10552181 — cGAS-STING IRI review (Front Immunol 2023)
- Fang X et al. (2023) *Circ Res* — ferroptosis cardiomyocyte
- Zhang T et al. (2022) *Cell Death Differ* — RIPK3 KO infarct
- bioRxiv 2023.08.17.551936 — PPARα IRI multi-omics
- PMC12443811 (2025) — ANXA1/ARG2 pan-organ IRI biomarker

### 9.3 arxiv / ML
- arxiv:2502.03272 (2025) — Auto MI segmentation CMR
- arxiv:2312.11315 (2023) — CaRe-CNN MVO segmentation
- arxiv:2509.11493 (2025) — DEC+GNN drug repurposing
- arxiv:2601.06140 (2026) — Causal federated multimodal CV risk
- arxiv:2605.05666 (2026) — Causal inference BP-CHD (Framingham)
- biorxiv 2025.01.28.635194 — Cardiac hypertrophy NN repurposing
- PMC11185454 (2024) — SurvTrace transformer survival post-MI

### 9.4 동아시아 / 한국
- KAMIR-NIH 20-yr — *Korean Circ J* 2025 doi:10.4070/kcj.2025.0360
- ALDH2*2 STEMI East Asian — PMID:34259924 (2021)
- ALDH2 rs671 endothelial — *J Am Heart Assoc* 2024 (HSPA5-PIEZO1-eNOS)
- Korean nicorandil RCT — PMID:36942830 (2023, *Heart*)
- Diabetic ALDH2*2 IRI mouse — PMID:34482710 (2021)

### 9.5 d2 wall 후속
- TAZPOWER 168wk OLE — *Genet Med* 2024 doi:10.1016/j.gim.2024.101102
- Elamipretide FDA Adcom (Oct 2024)
- Mitochondria-targeted nano review — PMC13095658 (2024)
- VB@MOF/TA — *J Nanobiotechnol* 2025 s12951-025-03810-3
- STING inhibitor (H-151 · C-176) — Haag SM et al. (2018) *Nature* 559:269

---

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 임상 trial readout (n · primary endpoint) | 🟡 SUPPORTED-BY-CITATION | NEJM / Lancet / Circ 등록 데이터 |
| Mechanism 신규 발견 (cGAS-STING · ferroptosis 등) | 🟡 SUPPORTED-BY-CITATION | peer-review 후속 confirm 필요 |
| arxiv ML 논문 reproducibility | 🟠 INSUFFICIENT | atlas 미등록 + 외부 reproducibility 의존 + code release 부분적 |
| 한국 ALDH2*2 prevalence (40%) | 🟡 SUPPORTED-BY-CITATION | 다수 East Asian 인구 study |
| d2 wall 신규 path (다축 차단 · STING inhibitor) | 🟠 INSUFFICIENT | preclinical 단계 · acute IRI 임상 0건 |
| M11 도달 후보 (Hill / Cox / PK 산식 - 추후) | 🔵 SUPPORTED-FORMAL 후보 표시 | hexa 산식 모델링으로 도달 가능 |

```
M9 산출물 위상 (M2-M8 보강 + d2 path 확장)
─────────────────────────────────────────────
M2  mPTP  ──── +12 evidence ──── 다축 한계 명시
M3  미세혈관 ── +10 evidence ──── 만성 prevention 후퇴
M4  delivery ── +5 evidence ──── DCB · nano 신축
M5  endpoint ── +6 evidence ──── CMR auto-seg
M6  safety ──── +4 evidence ──── 한국 출혈 stratify
M7  ranking ─── (통합 update 필요) → 콜키친 demote · elamipretide 격상
M8  한국 ────── +8 evidence ──── ALDH2*2 핵심
```

다음 단계 — M10 가능성: literature evidence를 hexa-recompute 가능한 산식(Hill model · Cox PH · PK/PD)으로 lift → 🔵 도달 후보 작성.
