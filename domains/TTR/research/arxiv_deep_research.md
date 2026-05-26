# TTR — arxiv deep research (M3 in-silico screening prerequisite feed)

@scope: 11-topic arxiv 검색 sweep · M2 의 62 candidate handles 가 M3 ranking 으로 진입하기 전 학계 prior-art 매핑 · M3 의 default 5 family 추천이 실제 학계 best practice 와 정합/충돌 확인
@status: 🟡 SUPPORTED-BY-CITATION (arxiv 메타데이터 + abstract 만; full-text 미확인) · 1차 sweep 2026-05-24
@input: 11 topic × 평균 2-4 query · 약 60 arxiv API call · arxiv API totalResults + abstract
@output: 5-line TL;DR · 11 topical table · 5 numerical M3 입력 · M2/M6 정합/충돌 · honest unknowns
@convention: 인용은 arxiv ID 단독 ([2104.10994] 형식) · arxiv 부재 토픽은 "arxiv hit 없음 — PubMed 권장" 명시

---

## §0. TL;DR — 가장 강한 4 발견 (학계 ↔ M2/M3 정합)

1. **arxiv 자체가 TTR 연구의 1차 코퍼스가 아니다.** 11 topic × 60 query 중 *진정한* TTR-relevant hit ≈ 22편 (대부분 1편/query). 효소·약물·임상 우선 토픽 (azoreductase · DyP · laccase · DFO · imiquimod · porcine tattoo model) 은 **arxiv totalResults = 0** [verified: q2a/q2b/q3a/q3b/q4b/q4c/q9a/q9c/q10a/q11a-c]. → M3 의 1차 SSOT 는 PubMed/Web of Science 이며 arxiv 는 *물리·재료·CV 보조 입력* 으로 한정.

2. **CeO₂ nanozyme 의 pH-switchable redox 가 M3 의 강력한 selectivity 핸들로 부상.** 기저 (pH 7.4) 에서 antioxidant (SOD/catalase mimic), 산성 (pH 4-5, lysosome) 에서 prooxidant — biomedicine 의 cancer-targeting nanozyme 패러다임을 TTR 의 macrophage phagolysosome 표적 chemistry 로 재이식 가능 [arxiv:2104.10994, 2309.13981, 2511.04693, 2404.17091, 2603.16892, 2305.10179]. M3 의 F1/F4 의 *spatial+pH selectivity* 문제 (M6 Col×Ox 🔴 TI≈10⁻⁹ 의 핵심 mitigation) 에 직접 해법.

3. **Cu-doped magnetite (Cu_xFe_{3-x}O_4) 가 heterogeneous Fenton catalyst 로 검증** — Cu 도핑이 Fe²⁺/Fe³⁺ ratio 와 ROS 생성 활성을 정량적으로 조절 [arxiv:2402.15338]. → **target ink 자체가 catalyst 가 되는 path A 의 first-principles 강화**: M1 §3 의 Cu-Pc + Fe oxide 혼합 잉크 (시장 검정 잉크 흔한 조성) 가 *외부 ROS 추가 없이* in-situ Fenton 가동 가능. M2 F1 의 default ranking 이 자기촉매적 ink-as-catalyst 로 시프트.

4. **Photoacoustic-monitored laser tattoo removal 의 ex-vivo 돼지 피부 feasibility (real-time feedback)** [arxiv:2105.12288]. → M8 의 ex-vivo 돼지 피부 protocol 의 *measurement endpoint* 가 단순 색측정 (CIE L*a*b*) 이 아니라 photoacoustic depth-resolved imaging 으로 진화 가능. Q-switched laser 시술의 operator-dependent variability 문제도 통계적으로 정량화됨 [arxiv:2105.09065 — Homeboy Industries 데이터].

5. **시판 타투 잉크의 Cr / Cu / Pb 가 EU ResAP(2008)1 한도 초과** — Sy-XRF + AAS + Raman 정량 [arxiv:1708.07376]. → M1 §6.4 "FDA pre-market gap" + M6 §6.6 lot variability caveat 의 *유일한* arxiv 수준 1차 측정 데이터. TTR 의 표적 잉크 *실제* 화학 조성 가정 시 inventory data 출처.

---

## §1. Topical tattoo ink removal — recent attempts (2015+)

queries: `all:"tattoo ink removal"` (0) · `all:"tattoo removal"` (4) · `all:"tattoo fading"` (0) · `all:tattoo+AND+all:ink` (4) · `all:"tattoo ink"+AND+all:safety` (1)

| arxiv ID | year | title (truncated) | 핵심 finding | TTR relevance | M-hook |
|---|---|---|---|---|---|
| [2105.12288] | 2021 | Photoacoustic-monitored laser tattoo removal feasibility | photoacoustic imaging real-time feedback · ex-vivo pig skin phantom 검증 | M8 ex-vivo measurement endpoint 진화 | M8 |
| [2105.09065] | 2021 | Statistical Learning for Best Practices in Tattoo Removal | Homeboy Industries 대규모 데이터 · 합병증 correlation 분석 (Q-switched laser session count · ink color · skin type) | "한 튜브 30일 1회" 임상 outcome benchmark 부재 데이터 | M9 |
| [2202.05297] | 2022 | Face Beneath the Ink: Synthetic Data and Tattoo Removal (CV) | DL 기반 *image-level* 타투 제거 (not chemical) | — (이미지 처리, 화학 무관) | n/a |
| [2108.03466] | 2021 | Unsupervised Portrait Shadow Removal w/ tattoo extension (CV) | StyleGAN2 prior 기반 image inpainting | — (이미지 처리) | n/a |
| [1811.00510] | 2018 | High speed imaging of solid needle and liquid micro-jet injections | 고속카메라로 tattooing 시 needle 진입 동역학 측정 + micro-jet injector 대안 | M4 transdermal delivery 의 needle physics 입력 | M4 |
| [1708.07376] | 2017 | Toxic metals and hazardous substances in tattoo inks (Sy-XRF, AAS, Raman) | top brand 잉크의 Cr, Cu, Pb > EU ResAP(2008)1 한도 · 정량 데이터 + Raman 분자 ID | M1 §6 lot variability + M6 §6.6 inventory data 의 1차 출처 | M1, M6 |

**§1 verdict**: arxiv 에 *화학적* topical tattoo removal 시도는 0편. *physical*/*image* removal (laser, photoacoustic, DL) 은 있음. **PubMed 권장** for 화학 기반 표적-잉크-cleavage 임상 연구.

---

## §2. Azoreductase + skin / topical / dermal

queries: `all:azoreductase+AND+all:skin` (0) · `all:azoreductase+AND+all:azo+AND+all:dye` (0) · `all:azoreductase` (0)

| arxiv ID | year | title | 핵심 finding | TTR relevance | M-hook |
|---|---|---|---|---|---|
| — | — | **arxiv hit 없음 — totalResults = 0** | azoreductase 는 arxiv 표지자 영역(physics·cs·math·q-bio) 밖 — 효소학·미생물학 저널 (J Bacteriol · Appl Environ Microbiol · Biochem J) 영역 | M3 F5 1순위 enzyme handle 의 K_cat / NADH dependence / 면역원성 데이터는 **PubMed 만** | M3, M5 |

**§2 verdict**: arxiv 검색 결과 없음 → **PubMed 권장** (검색 권장: "azoreductase AND skin", "AzoR AND topical", "FMN-dependent azoreductase", "Phragmites azoreductase phytoremediation"). M2 §2.2 표의 K_cat 수치는 arxiv 검증 불가.

---

## §3. Dye-decolorizing peroxidase (DyP) — engineering, dermal use

queries: `all:"dye decolorizing peroxidase"` (0) · `all:"DyP-type peroxidase"` (0) · `all:dye+AND+all:decolorizing+AND+all:peroxidase` (0)

| arxiv ID | year | title | 핵심 finding | TTR relevance | M-hook |
|---|---|---|---|---|---|
| — | — | **arxiv hit 없음 — totalResults = 0** | DyP family enzyme 는 efense biotechnology / lignin valorization 저널 (Appl Microbiol Biotechnol · Biochem · ChemBioChem) 영역 | M2 F5 의 Cu-Pc 우회 path (Roberts 2011 / Liers 2013 引用) 은 PubMed/Web of Science 만 | M3, M5, M7 |

**§3 verdict**: arxiv 검색 결과 없음 → **PubMed 권장** ("DyP peroxidase Auricularia", "engineered DyP phthalocyanine", "directed evolution DyP"). M2 wall-breakthrough Path D 의 timeline 추산 (2-3 yr enzyme engineering) 검증 불가.

---

## §4. Laccase / cytochrome P450 — phenol oxidation, ink chemistry

queries: `all:laccase+AND+all:phenol+AND+all:oxidation` (1) · `all:laccase+AND+all:azo+AND+all:dye` (0) · `all:laccase+AND+all:cosmetic` (0)

| arxiv ID | year | title | 핵심 finding | TTR relevance | M-hook |
|---|---|---|---|---|---|
| [0801.3337] | 2008 | Banana skin: a novel material for a low-cost production of laccase | 백색부후균 + banana skin substrate → 저비용 laccase 생산 + ascorbic acid 가 박테리아 contamination 억제 + dye decolorization 활성 검증 | M3 F5 cost-of-goods · M7 합성 path (lab-scale 효소 공급) | M3, M7 |

**§4 verdict**: 1 hit. laccase 의 *분자 메커니즘* (4-Cu site · O₂ → H₂O · phenol 1-e⁻ 산화) 데이터는 arxiv 영역 밖 → **PubMed 권장** ("Trametes laccase azo dye", "laccase mediator system phthalocyanine", "laccase TEMPO mediator").

---

## §5. Microneedle enzyme / protein delivery

queries: `all:microneedle+AND+all:enzyme` (0) · `all:microneedle+AND+all:protein+AND+all:delivery` (0) · `all:"dissolving microneedle"` (0) · `all:microneedle+AND+all:protein` (1) · `all:microneedle+AND+all:dermis` (0) · `all:microneedle+AND+all:vaccine` (0)

| arxiv ID | year | title | 핵심 finding | TTR relevance | M-hook |
|---|---|---|---|---|---|
| [2407.16734] | 2024 | Real time detection of C-reactive protein in interstitial fluid using EIS microneedle | dissolving microneedle 가 ISF 까지 도달 + 실시간 단백질 농도 측정 → microneedle 의 진피 도달 + 단백질 transit feasibility 검증 | M4 microneedle 우승 design 의 *protein-payload* 측정 검증 | M4 |

**§5 verdict**: 1 hit (협의의 ISF 측정). microneedle protein delivery 의 *분해 안정성*, MW limit, payload retention 의 핵심 데이터는 arxiv 영역 밖 → **PubMed 권장** ("dissolving microneedle protein delivery", "microneedle vaccine clinical trial", "MN BSA antibody payload retention").

---

## §6. Photo-Fenton in biological / skin / safe

queries: `all:"photo-Fenton"+AND+all:skin` (0) · `all:"photo-Fenton"+AND+all:biological` (0) · `all:Fenton+AND+all:dermal` (0) · `all:Fenton+AND+all:reaction+AND+all:cancer` (1) · `all:"Fenton reaction"+AND+all:biomedical` (0)

| arxiv ID | year | title | 핵심 finding | TTR relevance | M-hook |
|---|---|---|---|---|---|
| [2104.10994] | 2021 | DFT Investigation of pH-Driven Multi-Enzyme Biomimetic Behavior in CeO2 | CeO₂ NP 의 *pH switch* 가 first-principles (DFT) 로 검증 — basic pH = antioxidant (Ce³⁺ rich), acidic pH = prooxidant (Ce⁴⁺ rich · Fenton-like) | **M3 F1 의 spatial+pH selectivity 핵심 핸들** — macrophage phagolysosome (pH 4-5) 에서만 ROS 가동, 진피 collagen (pH 7.4) 보호 | **M3, M6** |
| [2402.15338] | 2024 | Heterogeneous Fenton-like activity of Cu_xFe_{3-x}O_4 nanoparticles | Cu doping 이 Fe²⁺/Fe³⁺ ratio + ROS 생성률 정량 조절 (Fe²⁺/Fe ≈ 0.33 undoped) | **target ink (Fe oxide PR101 + Cu-Pc PB15 혼합) 이 자기 Fenton catalyst → 외부 ROS 추가 없이 cleavage 시작** | **M3 (자기촉매 path A)** |
| [2504.20087] | 2025 | Magnetically Enhanced Fenton-Like by MnFe2O4 nanofibers (tetracycline degradation in pig manure) | heterogeneous Fenton catalyst 의 wastewater scale-up · OH radical 정량 | M3 Fenton starter (FeSO4 + H2O2) 의 *지지체 매트릭스* (electrospun nanofiber) 응용 가능성 | M7 formulation |

**§6 verdict**: photo-Fenton "in skin" 0편이나 *biocatalytic ROS NP* 의 pH-switchable selectivity 가 arxiv 영역에서 강하게 확립. M3 F1 ranking 의 default candidate 가 단순 H₂O₂/FeSO₄ → **CeO2 NP (pH-switchable) 가 새 후보 등재**.

---

## §7. Cu-phthalocyanine degradation pathways

queries: `all:"copper phthalocyanine"+AND+all:degradation` (2) · `all:phthalocyanine+AND+all:photocatalytic` (0) · `all:phthalocyanine+AND+all:degradation` (0) · `all:phthalocyanine+AND+all:photodegradation` (0) · `all:phthalocyanine+AND+all:cancer+AND+all:PDT` (0) · `all:"copper phthalocyanine"+AND+all:"singlet oxygen"` (0)

| arxiv ID | year | title | 핵심 finding | TTR relevance | M-hook |
|---|---|---|---|---|---|
| [2504.20990] | 2025 | Scattering mechanisms in bilayer graphene proximity to molecular thin film (CuPc) | CuPc thin film 의 *전기적* proximity effect — *분해/광촉매와 무관* | — | n/a |
| [1205.2438] | 2012 | Spin valves in organic semiconductors (CuPc) | spintronics 응용 | — | n/a |

**§7 verdict**: arxiv 에서 CuPc 는 *materials physics / spintronics* 가 압도. **chemical degradation pathway 0편** → **PubMed/ACS journals 권장** (검색: "copper phthalocyanine photo degradation quantum yield", "Cu-Pc ring-opening DyP", "Cu-Pc Q-band PDT singlet oxygen"). M2 §7.1 Path A 의 Cu-Pc photo-Fenton φ_¹O₂ ≈ 0.1 추산은 arxiv 검증 불가.

---

## §8. Chromium oxide environmental remediation

queries: `all:Cr2O3+AND+all:reduction` (5) · `all:Cr2O3+AND+all:photocatalysis` (0) · `all:chromium+AND+all:bioremediation` (0) · `all:chromium+AND+all:remediation` (0)

| arxiv ID | year | title | 핵심 finding | TTR relevance | M-hook |
|---|---|---|---|---|---|
| [2512.11264] | 2025 | Cr2O3/β-Ga2O3 heterojunction diodes | 전자소자 — *재료물리* | — | n/a |
| [2405.11122] | 2024 | Voltage and Boron doping spin reversal in Cr2O3 thin films | spintronics — band gap shift (~3.4 eV → B-doping with TN > 400 K) | M2 §7.1 의 Cr₂O₃ band gap 3.4 eV photo-excite path 의 *분광학적 근거*; B-doping 은 TTR 무관 | M5 (band gap) |
| [2307.11956] | 2023 | Light-induced electronic polarization in AFM Cr2O3 | symmetry-breaking 광응답 | — | n/a |
| [1812.11579] | 2018 | Dynamics of Magnetoelectric Reversal of AFM Domain | — | — | n/a |
| [1611.07027] | 2016 | Purely AFM Magnetoelectric RAM | — | — | n/a |

**§8 verdict**: arxiv 의 Cr₂O₃ 는 전부 *반강자성·자기전기효과·전자소자*. **chemical reduction / bioremediation 0편** → **PubMed/Environ Sci journals 권장** ("Cr2O3 dissolution acidic", "Cr3+ chelation kinetics ligand exchange", "chromium 6+ formation skin"). M6 §9.2 의 Cr⁶⁺ 형성 risk 추산 검증 불가.

---

## §9. Macrophage re-activation / re-engagement

queries: `all:macrophage+AND+all:tattoo` (0) · `all:macrophage+AND+all:phagocytosis+AND+all:reactivation` (0) · `all:imiquimod+AND+all:tattoo` (0) · `all:imiquimod` (0) · `all:"carbon black"+AND+all:macrophage` (0)

| arxiv ID | year | title | 핵심 finding | TTR relevance | M-hook |
|---|---|---|---|---|---|
| — | — | **arxiv hit 없음 — totalResults = 0** | 면역학·약리학 저널 (Sci Adv · Cell · Nat Immunol · J Invest Dermatol) 영역 | M2 §7.3 Path C (TLR7/8 agonist · HMGB1 · β-glucan · α-GalCer) 의 모든 candidate 데이터 → **PubMed only** | M3, M9 |

**§9 verdict**: arxiv 검색 결과 없음 → **PubMed 권장** (인용 핵심 후보: Baranska 2018 Sci Adv "macrophage tattoo pigment turnover", "imiquimod tattoo case report"). M2 의 가장 중요한 wall-breakthrough path (Path B/C) 의 검증은 PubMed 의존.

---

## §10. Iron chelation — dermal / topical

queries: `all:deferoxamine+AND+all:topical` (0) · `all:deferoxamine` (0) · `all:siderophore+AND+all:skin` (0) · `all:"iron chelation"+AND+all:wound` (0)

| arxiv ID | year | title | 핵심 finding | TTR relevance | M-hook |
|---|---|---|---|---|---|
| — | — | **arxiv hit 없음 — totalResults = 0** | DFO / deferiprone / siderophore 약리 데이터는 임상의학·약학 저널 (Blood · NEJM · Br J Haematol · J Drug Target) 영역 | M3 F3 1순위 (DFO log K=30.6 · k_1 ≈ 5×10⁶ M⁻¹s⁻¹) 의 검증 → **PubMed only** | M3 |

**§10 verdict**: arxiv 검색 결과 없음 → **PubMed 권장** ("deferoxamine topical microneedle", "DFO dermal pharmacokinetics", "DOTAM siderophore mimetic"). M2 §3.3 의 DFO Sigma D9533 추천은 약물학 베이스라인 가정.

---

## §11. Ex-vivo pig skin tattoo / dye model

queries: `all:"pig skin"+AND+all:tattoo` (0) · `all:porcine+AND+all:skin+AND+all:ink` (0) · `all:"ex vivo"+AND+all:"porcine skin"` (0) · `all:porcine+AND+all:skin+AND+all:dye` (0)

| arxiv ID | year | title | 핵심 finding | TTR relevance | M-hook |
|---|---|---|---|---|---|
| [2105.12288] | 2021 | Photoacoustic-monitored laser treatment for tattoo removal: feasibility (**ex-vivo pig skin**) | phantom + ex-vivo porcine skin 에 잉크 주입 후 Q-switched laser + photoacoustic depth imaging | **M8 의 직접 protocol prototype** — ex-vivo pig skin 잉크 주입 + 측정 endpoint (photoacoustic depth + visual color) | **M8** |

**§11 verdict**: 1 hit. arxiv 의 다른 검색은 0. M8 protocol 의 표준 protocol 문헌 (피부 thickness · tattooing depth · ink 농도 · 측정 endpoint 표준화) 은 → **PubMed/IEEE EMBS** (검색 권장: "porcine skin tattoo model in vitro", "ex vivo pig skin permeation Franz cell").

---

## §12. M3 핵심 입력 5 (numerical · 인용)

| # | 핵심 number | source | M3 적용 |
|---|---|---|---|
| 1 | **CeO₂ NP pH switch — basic pH antioxidant, acidic pH Fenton-like prooxidant** (Ce³⁺/Ce⁴⁺ ratio shift, DFT-confirmed) | [arxiv:2104.10994] + [arxiv:2309.13981] | F1 default candidate 에 CeO2 NP 등재 · macrophage phagolysosome (pH 4-5) 표적 selectivity · 진피 collagen (pH 7.4) 보호 |
| 2 | **Cu_xFe_{3-x}O_4 Fe²⁺/Fe ratio ≈ 0.33 (undoped magnetite)** — Cu doping 이 Fenton 활성을 정량 조절 | [arxiv:2402.15338] | M1 §3 ink mixture (Fe oxide + Cu-Pc) 가 in-situ Fenton catalyst — 외부 oxidant 없이 cleavage 시작. F1 strategy 가 "ink-as-catalyst" 로 시프트 |
| 3 | **Cr₂O₃ band gap 3.4 eV (= λ 365 nm UV-A 정합)**, B-doping 으로 TN > 400 K 입증 | [arxiv:2405.11122] | M2 §7.1 Path A (UV-A 365 nm + Cr₂O₃) 의 *광에너지 매칭* arxiv 수준 검증 |
| 4 | **Praseodymia (PrOx) nanozyme Km < 0.026 mM oxidase-like activity** — 기존 인공효소 대비 K_M 약 10² 배 낮음 (≈ 효율 ↑) | [arxiv:2402.02505] | M3 F5 의 *enzyme mimic* category (non-protein) 신설 — 면역원성 회피 |
| 5 | **시판 tattoo ink Cr/Cu/Pb 가 EU ResAP(2008)1 한도 초과** — Sy-XRF + AAS + Raman 정량 | [arxiv:1708.07376] | M1 §6 의 lot variability 의 1차 실측 데이터 · M6 §6.6 caveat 인증 |

---

## §13. 비교 vs M2 default 5 family 추천 — 학계 정합/충돌

| M2 family | M2 default top candidate | 학계 (arxiv-from-this-sweep) 시사점 | 정합/충돌 | 조정 권고 |
|---|---|---|---|---|
| **F1 Oxidation** | 3% H₂O₂ + FeSO₄ Fenton | CeO₂ NP pH-switchable Fenton 이 selectivity-superior [2104.10994, 2309.13981] · Cu_xFe_{3-x}O_4 자기촉매 ink [2402.15338] | **CONFLICT** — naive Fenton 의 TI≈10⁻⁵ (M6) 가 CeO₂ NP 의 pH-gating 으로 TI↑↑ 잠재력. naive Fenton 의 M3 1순위 지위 약화. | **CeO₂ NP 를 F1 새 1순위로 등재**, FeSO₄+H₂O₂ 는 *역사적 baseline* 으로 강등 |
| **F2 Reductive** | Ascorbate + recombinant AzoR | arxiv hit 0편 — PubMed 영역 검증 | NEUTRAL — arxiv 미정보 | M3 ranking 시 PubMed-derived K_cat 데이터를 ⚠ 표시 |
| **F3 Chelation** | DFO (log K 30.6) | arxiv hit 0편 — DFO 약리 검증 PubMed | NEUTRAL — arxiv 미정보 | M3 ranking 동일 |
| **F4 Photo** | UV-A 365 nm + TiO₂ NP / riboflavin | Cr₂O₃ band gap 3.4 eV / λ 365 nm 매칭 [2405.11122] · CeO₂ NP photoexcite 보조 | **ALIGNED** — Cr₂O₃ 광흡수 cutoff 의 arxiv-수준 첫 검증 | M2 §7.1 Path A 수치 신뢰도 ↑ |
| **F5 Enzymatic** | Recombinant AzoR / Plant azoreductase | arxiv hit 0편 *생물효소*; 반대로 *비단백질 nanozyme* (CeO₂, PrOx) 가 arxiv 영역에서 강세 [2402.02505] | **EXPAND** — 단백질 효소 옆에 *inorganic nanozyme* 카테고리 신설 | M3 F5 를 F5a (protein enzyme) + F5b (nanozyme) 로 분리 |

→ **2 핵심 조정**: (a) F1 의 1순위가 *CeO₂ NP* 로 진화, (b) F5 가 enzyme + nanozyme 의 binary subcategory 로 분기.

→ M2 Path A (photo-Fenton hybrid) 의 *new strongest version*: **CeO₂ NP + UV-A 365 nm + ink-as-catalyst (Cu_xFe_{3-x}O_4 native)** — 셋 모두 arxiv-supported.

---

## §14. Honest unknowns / 부재 / 모순 / replication 안 된 영역

1. **azoreductase K_cat 의 실제 in-skin 활성** — arxiv 미수록 → M2 §2.2 의 ~10² s⁻¹ 추산은 *시험관* 표준 조건. 진피 pH 5.5 + protein-rich 환경의 실측 데이터 부재 (PubMed 검색 필수).

2. **DyP-type peroxidase 의 Cu-Pc 활성** — Roberts 2011 / Liers 2013 인용은 M2 §7.4 Path D 의 핵심이나 arxiv 0편 → 원문 PubMed 검증 + replication study 존재 여부 미확인.

3. **DFO topical pharmacokinetic** — arxiv 0편 → PubMed 의 microneedle DFO 연구 (Duscher 2015 J Control Release 류) 인용 검증 필요. 진피 잔류 시간 + Cu off-target chelation 데이터 missing.

4. **Cu-Pc photo-Fenton φ_¹O₂ 실측** — M2 §7.1 의 추산 (~0.1) 은 arxiv 영역에서 0편. PubMed (J Photochem Photobiol · Photochem Photobiol Sci) 검증 필수.

5. **Cr₂O₃ photoexcitation 의 in-skin 실효 quantum yield** — arxiv 의 Cr₂O₃ band gap 3.4 eV [2405.11122] 은 *single crystal/thin film* 데이터 → 진피 plume 의 100 nm NP 의 effective band-gap shift 미확정.

6. **CeO₂ NP 의 melanocyte off-target** — arxiv [2404.17091] 가 cytotoxicity polymer-encapsulation 으로 완화 보고하나, *멜라닌세포 phenol/catechol* 와의 직접 상호작용 데이터 부재. M6 Mel×Ox 🔴 의 CeO₂ NP 대체 시 새 risk re-evaluation 필요.

7. **macrophage re-engagement (Path C) arxiv 0편** — TLR7/8 agonist · HMGB1 · β-glucan 모두 PubMed 영역. M2 의 가장 ambitious wall-breakthrough path 가 arxiv-수준 first-principles 검증 없음. M3 진입 전 PubMed sweep 필수.

8. **ex-vivo 돼지 피부 standard protocol** — arxiv 의 [2105.12288] 1편만 photoacoustic 측정 검증. ink 주입 깊이 / 농도 / 측정 endpoint 표준화는 부재 — M8 design 시 자체 protocol 구축 필요.

9. **arxiv ↔ PubMed 검색결과 mismatch 의 systemic gap** — TTR 의 1차 corpus 가 *생물·임상·약학 저널* 인 동시에 arxiv 가 *물리·재료* 영역인 점에서 자생적 mismatch. M3 의 검증은 *necessarily* PubMed/Web of Science 기반.

10. **데이트 분포 skew** — 11 topic × 약 60 query 의 hit 분포가 2021-2025 가 압도. 2015-2020 의 *historical* TTR 시도 (DFO microneedle Tang 2018 류) arxiv 미수록 → PubMed sweep 필수.

---

## §15. arxiv 검색 자체 caveats (방법론)

- API: `https://export.arxiv.org/api/query?search_query=<all:term1+AND+all:term2>&max_results=10&sortBy=submittedDate`
- Rate limit: HTTP 429 가 50-100 req 후 trigger → 본 sweep 은 60s pre-sleep + 15-20s 간 spacing 으로 우회
- 검색 syntax: phrase 검색은 `%22...%22` URL encoding · AND/OR 는 명시 필요 (default 는 AND)
- 결과 검증: `<opensearch:totalResults>` 가 0 인 경우 *진정한* 0 (rate-limited 와 구분)
- arxiv 의 categorization: q-bio.\* (생물학) 가 있으나 *임상의학·약학·미생물 효소학* 은 거의 부재 — TTR 의 1차 영역 대부분이 arxiv 밖

## §16. Cross-reference

- M1: [`ink_classes.md`](./ink_classes.md) — §13 의 ink composition lot variability 데이터의 1차 출처는 [arxiv:1708.07376]
- M2: [`moa_shortlist.md`](./moa_shortlist.md) — §13 의 F1/F5 default ranking 조정, §7.1 Path A 의 Cr₂O₃ band gap 신뢰도 ↑
- M4: [`transdermal_delivery.md`](./transdermal_delivery.md) — §5 microneedle protein delivery [arxiv:2407.16734] · §11 needle physics [arxiv:1811.00510]
- M6: [`off_target_safety.md`](./off_target_safety.md) — §6.6 lot variability + §6.3 Col×Ox TI 의 CeO₂ NP mitigation (§13 conflict row)
- M8 (예정 ex-vivo 돼지 피부): [arxiv:2105.12288] photoacoustic protocol 의 직접 입력
- @D d3 (구현 코드 위치) — 본 문서는 design doc, 코드는 hexa-* sibling
- @D d6 (first-principles physics) — arxiv 의 DFT data ([2104.10994, 2309.13981, 2402.15338]) 가 BDE/E°/log K 외 *first-principles 추가 입력* 으로 등재

---

→ 본 문서 = M3 in-silico screening 의 *학계 prior-art 인벤토리* (1차 sweep 완료). M3 진입 전 후속 작업: **PubMed/Web of Science sweep** (특히 azoreductase · DyP · DFO · imiquimod · porcine ex-vivo · Cu-Pc photodegradation 6 영역) — 본 sweep 의 honest gap.
