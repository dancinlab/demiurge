# TTR — External Libraries & Industry Inventory (M3 prerequisite)

> M3 (활성성분 in-silico screening) 의 **prerequisite-research deliverable** — not a TTR.md milestone.
> 입력 = M1 ink_classes.md (8 표적 카테고리) · M2 moa_shortlist.md (5 family · 62 handle) · M4 transdermal_delivery.md (microneedle 우승) · M6 off-target_safety.md (molecule X constraint).
> 출력 = (a) DB · 효소 · tool stack 권장 · (b) 산업 negative-precedent inventory · (c) 외부 검증 수치.
> 본 문서는 web research (WebSearch/WebFetch) 로 직접 fetch 한 사실 + first-principles 해석 — 🟡 SUPPORTED-BY-CITATION (URL provenance verbatim).
> Provenance 표기: ⓦ = WebSearch/WebFetch 로 본 세션에서 fetch · ⓖ = general knowledge / 미fetch.

scope:
- in-scope: DB · API · tool · 효소 lookup · 산업 negative history · microneedle 공급망 · 규제 경로 · 시장 수치 · honest unknowns
- out-of-scope: M3 의 candidate ranking 자체 (본 문서가 입력) · 합성 (M7) · in-vivo (M8-9) · IND 패키지 작성 (M10)

---

## 0. TL;DR — M3 stack 권장 (3 picks)

| 우선순위 | 컴포넌트 | 역할 | 1-line rationale |
|---|---|---|---|
| **#1** | **PubChem (PUG-REST)** + **ChEMBL** (REST) | 분자 lookup · bioactivity · structure search | PubChem 347M cpd ⓦ + ChEMBL ~2M cpd / 14M bioactivity ⓦ — F1-F3 의 12-13 handle 모두 CAS/CID 로 즉시 매칭. open · API 안정. |
| **#2** | **BRENDA** (web · 5M data · 90K enzyme) + **UniProt** | F5 효소 family 의 K_cat / K_M · PDB 링크 | F5 의 12 효소 handle 의 EC 번호 → UniProt accession → K_cat 차수 확인 (e.g., AzoR P41407 ⓦ). |
| **#3** | **RDKit** + **AutoDock Vina** + **OpenMM** | docking · QSAR · MD (M5 입력) | 세 도구 모두 open-source · CPU/GPU dual · M3 in-silico screening 의 default tool chain ⓦ. |

→ 위 stack 으로 M3 의 G1 (thermodynamic) + G2 (kinetic) gate 1차 평가 완료 가능. G3 (selectivity off-target) 은 §3.4 의 DiffDock/GNINA 추가.

---

## 1. Small-molecule databases — M3 입력 검색용

### 1.1 비교 표

| DB | URL | Open? | Cpd 수 | API | M3 search verb | M3 적합도 |
|---|---|---|---|---|---|---|
| **PubChem** | https://pubchem.ncbi.nlm.nih.gov | ✅ public | **347 M** (May 2026) ⓦ | PUG-REST · PUG-View · 5 req/s | CID · SMILES · synonym · substructure · similarity | ●●● 1순위 |
| **ChEMBL** | https://www.ebi.ac.uk/chembl | ✅ public CC-BY-SA | ~2.4 M (v34+) ⓖ / 14M bioactivity (v22 1.6M ⓦ) | REST · download · MariaDB dump | structure · target · bioactivity · ADMET · 임상 phase | ●●● 1순위 (bioactivity 강) |
| **DrugBank** | https://go.drugbank.com | ◐ academic free (CC BY-NC) / paid commercial | ~10K approved + invest. ⓦ | Academic download (재개대기 ⓦ) · paid API | drug name · target · interaction · ADMET | ●● (FDA-approved precedent 가중치 위해) |
| **DrugBank Open Data** | https://go.drugbank.com/releases/latest | ✅ CC0 (subset) | smaller subset ⓦ | flat-file download | 같은 subset | ●● commercial use 가능 |
| **ZINC22** | https://cartblanche22.docking.org | ✅ public | **37 B make-on-demand** ⓦ (총 enumerated 4.5 T ⓦ) | tranches · Globus · AWS · OCI | docking-ready 3D · SMILES · vendor | ●●● docking screen 의 default |
| **ZINC15** | https://zinc15.docking.org | ✅ public | 531 M ⓦ (terminal version) | REST · download | tranches · 3D · vendor | ◐ (ZINC22 가 후속) |
| **ChemSpider** | https://www.chemspider.com | ✅ free (RSC) | ~120 M ⓖ | REST (API key) | name · synonym · structure | ●● cross-reference 보강 |
| **COCONUT** | https://coconut.naturalproducts.net | ✅ public | 426K (no-stereo) / 746K (with-stereo) ⓦ ; 63 NP source 통합 ⓦ | SDF · CSV · DB dump · search UI | structure · substructure · similarity · taxonomy | ●●● 천연물 (curcumin · hypericin · catechin · enterobactin) |
| **SureChEMBL** | https://www.surechembl.org | ✅ public | ~17 M (patent extracted) ⓖ | download · search | patent · structure · date | ◐ IP landscape (M10) |
| **GDB-17** | https://gdb.unibe.ch/downloads | ✅ public | **166.4 B** enumerated (≤17 atoms C/N/O/S/halogen) ⓦ | flat-file | exhaustive enum | ◐ (M3 default 아님; 신규 chemotype generative 용) |
| **GDB-20** | 위와 동일 | ✅ public | 12.09 B unique molecule ⓦ | flat-file | ≤20 atoms | ◐ |
| **GDBChEMBL** | https://gdb.unibe.ch | ✅ public | 10 M (ChEMBL-likeness 필터) ⓦ | flat-file | drug-likeness | ●● novelty + 합성가능성 균형 |

### 1.2 M3 default 매칭 (62 handle → DB)

```
F1 oxidation (12 handle):
  ├─ H₂O₂ · FeSO₄ · KMnO₄ · NaClO · benzoyl peroxide  →  PubChem CID · ChEMBL bioactivity
  ├─ methylene blue · rose bengal · 5-ALA           →  ChEMBL (PDT 임상 데이터)
  └─ riboflavin · TiO₂ NP                           →  PubChem + COCONUT (riboflavin natural)

F2 reductive (12): ascorbate · GSH · TCEP · cysteine · NADH ─→  PubChem + ChEMBL (cofactor 다수)
F3 chelation (13): DFO · deferiprone · DTPA · EDTA · catechin · DOPA · enterobactin
                                                    →  PubChem (CAS) + ChEMBL (DFO=CHEMBL556) + COCONUT (catechin · enterobactin natural)
F4 photo (13):    sensitizer 12 + LED device 1     →  ChEMBL (PDT) + DrugBank (Levulan/5-ALA approved)
F5 enzymatic (12): 효소 12 handle                   →  BRENDA + UniProt (§2 참조; small-mol DB 아님)
```

→ 62 handle 중 60 개 (효소 family 5 제외) 가 **PubChem + ChEMBL + COCONUT 3-stack** 으로 1-step 매칭. ZINC22 는 docking screen (M5 pre-MD 의 conformer source).

---

## 2. Enzyme / protein databases — F5 우선순위

### 2.1 비교 표

| DB | URL | 콘텐츠 | M3 query verb |
|---|---|---|---|
| **BRENDA** | https://www.brenda-enzymes.org | EC 분류 · K_cat · K_M · 90K enzyme / 13K organism / 5M data point ⓦ ; ELIXIR core data resource ⓦ | EC · UniProt · organism · substrate · inhibitor · pH/T profile |
| **UniProt** | https://www.uniprot.org | sequence · function · GO · structure link · variant | accession · keyword · taxonomy ; API at uniprot.org/api-documentation ⓦ |
| **KEGG** | https://www.kegg.jp | pathway · reaction map · KO/EC orthology | EC · pathway · organism ; REST: rest.kegg.jp ⓖ |
| **ExPASy ENZYME** | https://enzyme.expasy.org | 가벼운 EC 분류 + name + reaction | EC · accepted name |
| **AlphaFold DB** | https://alphafold.ebi.ac.uk | **241 M+ predicted structure** (v6, sync UniProt 2025_03) ⓦ | UniProt accession · API at alphafold.com/api-docs ⓦ |
| **PDB / RCSB** | https://www.rcsb.org | experimental structure | PDB ID · UniProt · ligand · resolution |

### 2.2 F5 12 효소 handle → BRENDA / UniProt lookup

| 효소 | EC | UniProt (대표) | 출처 organism | M2 의 K_cat 차수 | 비고 |
|---|---|---|---|---|---|
| **AzoR (E. coli)** | 1.7.1.17 (BRENDA 카탈로그) / M2 표기 1.7.1.6 (legacy) | **P41407** ⓦ | E. coli K-12 | ~10² s⁻¹ | FMN+NADH, homodimer, ping-pong; M2 의 1순위 azo cleavage 효소 ⓦ |
| NQO1 (human) | 1.6.5.2 | P15559 ⓖ | Homo sapiens | ~10² | drug detox + quinone reductase |
| AzrA / AzrB | 1.7.1.6 | Q5W6T2 (AzrA Bacillus sp.) ⓖ | Bacillus | ~10¹ | textile azo |
| Lignin peroxidase (LiP) | 1.11.1.14 | P06181 ⓖ | Phanerochaete chrysosporium | ~10¹ | heme · H₂O₂ |
| Manganese peroxidase (MnP) | 1.11.1.13 | Q02567 ⓖ | P. chrysosporium | ~10¹ | heme · Mn²⁺ mediator |
| Laccase | 1.10.3.2 | Q12717 (Trametes) ⓖ ; BRENDA full page available ⓦ | Trametes versicolor | ~10¹ | 4× Cu T1/T2/T3 site |
| Horseradish peroxidase (HRP) | 1.11.1.7 | P00433 ⓖ | Armoracia rusticana | ~10² | research grade Sigma P8125 |
| Myeloperoxidase (MPO) | 1.11.2.2 | P05164 ⓖ | Homo sapiens (호중구) | ~10² | HClO 생성 |
| **DyP-type peroxidase** | 1.11.1.19 | D1A807 (TcDyP Thermomonospora curvata) ⓦ ; K7N5M8 (AmyDyP2) ⓦ ; K9TRM8 (subclass I2) ⓦ | 박테리아/곰팡이 다수 | ~10² | anthraquinone · 일부 Pc 산화 보고 |
| Tyrosinase (mushroom) | 1.14.18.1 | O42713 (Agaricus bisporus) ⓖ | Agaricus | ~10² | 2× Cu, catechol→quinone |
| Cyt P450 BM3 | 1.14.14.1 | P14779 ⓖ | Bacillus megaterium | ~10⁰-10¹ | engineered broad oxidative |
| Glucose oxidase (GOx) | 1.1.3.4 | P13006 ⓖ | Aspergillus niger | ~10² | in situ H₂O₂ (Fenton 보조) |

→ 위 12 항목 모두 BRENDA + UniProt + AlphaFold DB 의 3-stack 으로 in-silico 평가 가능 (structure → docking site → substrate fit).

**fetch 직접 검증**: AzoR P41407 BRENDA 페이지 = `https://www.brenda-enzymes.org/enzyme.php?ecno=1.7.1.6&UniProtAcc=P41407&OrganismID=2026` (검색 결과 페이지에서 직접 확인) ⓦ.

---

## 3. In-silico screening tools — open-source default

### 3.1 도구 stack

| Tool | URL | License | 역할 | CPU/GPU | 설치 |
|---|---|---|---|---|---|
| **RDKit** | https://www.rdkit.org | BSD-3 ⓖ | cheminformatics base · conformer gen · descriptor · SMARTS | CPU (laptop OK) | `conda install -c conda-forge rdkit` |
| **Open Babel** | https://openbabel.org | GPL-2 ⓖ | format conversion (SMILES↔SDF↔PDB↔mol2) | CPU | `brew install open-babel` / `apt install openbabel` |
| **AutoDock Vina** | https://autodock-vina.readthedocs.io | Apache-2 ⓦ | docking (rigid receptor + flex ligand) | CPU + opt GPU (CUDA) ⓦ | `conda install -c conda-forge vina` |
| **GNINA** | https://github.com/gnina/gnina | GPL ⓦ | Vina fork + CNN scoring | **GPU 권장** (CUDA) ⓦ | docker / source build |
| **DiffDock** | https://github.com/gcorso/DiffDock | MIT ⓖ | diffusion-model docking (blind) | GPU 필수 (≥16GB VRAM) ⓖ | conda env + torch |
| **DeepDock** | https://github.com/OptiMaL-PSE-Lab/DeepDock | MIT ⓖ | pose prediction · binding score | GPU | source build |
| **OpenFF (toolkit)** | https://openforcefield.org | MIT ⓖ | small-mol forcefield (SMIRNOFF) | CPU | `conda install -c conda-forge openff-toolkit` |
| **OpenMM** | https://github.com/openmm/openmm | MIT + LGPL ⓦ | MD engine (CUDA / OpenCL / Metal / CPU) ⓦ | **GPU 강력** (CUDA 4.0+ ⓦ) | `conda install -c conda-forge openmm` |
| **GROMACS** | https://manual.gromacs.org | LGPL ⓖ ; GROMACS 2026.2 ⓦ | MD engine · biomolecular default · v4.6+ GPU ⓦ | GPU (CUDA backend) ⓦ | pkg manager / source |
| **PyMOL** (OS) | https://pymol.org | BSD ⓖ | viz · alignment · ligand site visual | CPU | conda |

### 3.2 M3 work-flow (62 handle × 8 target)

```
┌───────────────────┐   PubChem  ┌─────────────────┐   RDKit/OBabel  ┌────────────────┐
│  62 handle SMILES │ ─────────► │  SDF/MOL2 batch │ ─────────────► │ 3D conformer   │
└───────────────────┘            └─────────────────┘                 └────────┬───────┘
                                                                              │
                                          AlphaFold DB / PDB                  ▼
                                   ┌──────────────────────────┐    ┌────────────────────┐
                                   │ target receptor (8 cat.) │ ──►│  Vina docking      │
                                   │  · azo (mock model)      │    │  + GNINA rescore   │
                                   │  · Fe oxide surface NP   │    │  → top-N per cat.  │
                                   │  · Cu-Pc · etc.          │    └────────┬───────────┘
                                   └──────────────────────────┘             │
                                                                            ▼
                                                           ┌────────────────────────┐
                                                           │ G1-G5 gate scoring     │
                                                           │ → M3 ranking + M5 in   │
                                                           └────────────────────────┘
```

**laptop vs GPU 분기**:
- Laptop CPU (M1/M2/M3 Mac): RDKit · Vina · OpenFF · OpenMM (Metal backend ⓖ) — 62 handle × 8 target 의 1차 dock screen 가능 (~수 시간 batch)
- GPU pod (CLAUDE.md @D d7): GNINA · DiffDock · GROMACS (≥20 atom MD) — wall path A/B 의 photo-Fenton + macrocycle MD 필요시 dispatch

→ M3 의 default 은 laptop 으로 충분 (small molecule × small-target binding); M5 (MD/QM recompute) 에서 GPU pod (~24h) 로 확장.

### 3.3 M3 의 핵심 search verb

| Verb | Tool | M3 사용처 |
|---|---|---|
| substructure | PubChem · ChEMBL · COCONUT | 같은 chemotype (catechol · siderophore · porphyrin) 의 모든 변종 enumeration |
| similarity (Tanimoto) | RDKit + ChEMBL | DFO analog · imiquimod analog 탐색 |
| SMARTS pattern | RDKit | "1,2-dihydroxyphenyl" (catechol Fe³⁺ binder) 일괄 query |
| pharmacophore | RDKit + Phase (commercial) | azoreductase active site 의 FMN + NADH + azo triad |
| docking | Vina · GNINA · DiffDock | binding pose score 차원 |
| ADMET | ChEMBL + admetSAR ⓖ | skin permeation · topical toxicity 예측 |
| similarity 3D shape | ROCS ⓖ (commercial) / RDKit shape Tanimoto | scaffold-hopping |

---

## 4. 산업 — Topical tattoo removal 시도 history (M3 negative precedent)

### 4.1 시판 cream / kit (모두 FDA non-approved)

| 제품 | 주장 활성성분 (라벨) | 효능 데이터 | 규제 status | 진단 (M1/M2/M6 적용 시) |
|---|---|---|---|---|
| **Tattoo Vanish** ⓦ | natural ingredient 비공개 mix · TCA 의심 ⓖ | RCT 부재 · before/after 사진만 | FDA 미승인 ⓦ | TCA-기반 시 표피 박피만 → 진피 ink 미접촉 (M1 §0 의 "잉크는 진피 0.5-2mm" 와 충돌) |
| **Tat B Gone** ⓦ (Amazon ⓦ) | hydroquinone · 산성 박피 ⓖ | 효능 임상 데이터 부재 ⓦ | FDA 미승인 ⓦ | hydroquinone = chemical leukoderma 위험 (M6 §6.2.2 Mel × Chel critical) — 즉 *멜라닌 표적, 잉크 표적 아님* |
| **Wrecking Balm** ⓖ | TCA + 박피 + 마이크로더마브레이젼 키트 ⓖ | 효능 부재 · 흉터/색소이상 사례 다수 ⓖ | FDA 미승인 ⓖ | 기계적 표피 박피 — same: 진피 ink 미접촉 |
| **Tat Off** ⓖ | 산성 박피 ⓖ | 미공개 | FDA 미승인 ⓖ | same |
| **Inked Up** ⓖ | natural extract claim ⓖ | 미공개 | FDA 미승인 ⓖ | 박피 효과만 — 진피 미도달 |
| **"Lactic acid" peel products** ⓦ | lactic acid 5-10% ⓦ | 표면 fade slight only ⓦ | OTC 화장품 ⓦ | TCA 보다 약함 + 같은 표피 한정 ⓦ |
| **TCA peels (in-office)** ⓦ | trichloroacetic acid (clinic-only) ⓦ | partial fade · 흉터 위험 ⓦ | FDA in-office only ⓦ | 박피 → 표피 한정 — 진피 미접촉 |

**FDA 공식 입장 (ⓦ)**: "The FDA has not approved tattoo removal ointments and creams or DIY tattoo removal kits. No tattoo removal cream currently on the market has been approved by the FDA. The FDA is not aware of any evidence that they are safe or effective for tattoo removal. These products may cause skin rashes, burns, or scars." (https://www.fda.gov/consumers/consumer-updates/tattoo-removal-options-and-results ⓦ)

**FDA enforcement 사례**: Tattoo Numbing Cream Co. (warning letter 672467, 2024-03-25) — *numbing* 제품 (제거 아님) 의 unapproved drug claim 으로 적발 ⓦ.

### 4.2 학술 시도 — imiquimod 등

| 후보 | 결과 | 출처 |
|---|---|---|
| **Imiquimod 5% (Aldara)** — TLR7 agonist topical | (a) Ricotti et al. 2007: laser + imiquimod RCT (n=20, 6 session) — *combination* fade 약간 ↑ (single-blinded) ⓦ | PMID 17760599 ⓦ |
| Imiquimod **animal study** | 동물 모델에서 imiquimod 단독으로도 fade 보고 ⓦ ; combo > laser-only ⓦ | PMID 17338690 ⓦ |
| **Microneedle-DFO** (학술 단계) | concept paper · ex-vivo iron mobilization ⓖ | (미fetch) |
| ClinicalTrials.gov "imiquimod tattoo" | 활성 NCT 미확인 (search 결과 0 ⓦ) — 종결/미등록 | clinicaltrials.gov ⓦ |
| ClinicalTrials.gov "tattoo removal device" | NCT00409162 — safety/efficacy of new device (legacy laser ⓦ) | https://clinicaltrials.gov/study/NCT00409162 ⓦ |

→ **학술 active 진행 trial 거의 부재** (laser 보조 시도가 대부분). **TTR 의 "한 튜브 90% 제거" 가 학술/임상에도 빈 자리**.

### 4.3 왜 다 실패했나 — first-principles 진단

**한 줄 진단**: *진피 0.5–2 mm 에 박힌 잉크 입자에 활성분자가 도달하지 못한다 — 시판 cream 은 모두 표피 박피로 우회 → 진피 ink 무접촉.*

```
┌────────────────────────────────────────────────────────────────┐
│  현 시판 cream / kit  ─── 표적 표피 (SC 10-20 μm + vEp 50-100 μm)│
│  (산성 박피 · TCA · lactic acid · hydroquinone)                 │
│                                                                │
│         ┃ 박피로 표피만 제거                                    │
│         ┃ → 잉크 잔류 (진피 입자 무손상)                        │
│         ▼                                                      │
│  진피 ink 입자  ✗ 미접촉  ❌ ─── 표적 진피 (0.5-2 mm)          │
│                                                                │
│  부작용:                                                       │
│  · hydroquinone → chemical leukoderma                          │
│  · TCA → 흉터 + 색소이상                                       │
│  · 무규제 → lot 변동성 + carcinogenic 부산물 가능              │
└────────────────────────────────────────────────────────────────┘
```

**M1/M2/M6 결과로 본 fail 5축**:

| Fail axis | 시판 제품의 실패 메커니즘 | TTR breakthrough (Path B/A) |
|---|---|---|
| **F-1 침투 깊이** | 표피 한정 (SC 10-20 μm) — 진피 ink 미접촉 (M4 §4.1 wall) | microneedle L=1000-1500 μm 가 진피 직접 deposition (M4) |
| **F-2 잘못된 표적** | hydroquinone = 멜라닌 표적 (M6 Mel × Chel 🔴) — ink 화학과 무관 | molecule X 가 ink chemistry 표적 (azo N=N · Fe³⁺ · Cu-Pc · 등) — M3 ranking |
| **F-3 first-principles 불일치** | 무차별 산성 박피 — ink BDE/E°/log K 무시 | M2 의 8 표적 × 5 family 매트릭스 — 표적별 chemistry 매칭 |
| **F-4 부작용 격자** | TCA/hydroquinone → 흉터 + leukoderma | M6 의 24-cell off-target matrix 로 사전 차단 |
| **F-5 무규제 lot variability** | 라벨/실제 조성 불일치 ⓖ | M7 의 GMP formulation lock + M10 의 IND 패키지 |

→ **시판 시도 0건이 첫 번째 wall (침투) 도 통과 못함** = TTR 의 5개 wall (M4 침투 · M3 표적 화학 · M6 안전 · M7 GMP · M10 IND) 중 *오직 M4 만이라도* 풀면 *상위 90%* 까지 이동. TTR.md @goal 의 differentiator = microneedle delivery (M4) × chemistry-rational molecule X (M3).

---

## 5. Microneedle 공급망 — M4 deployment 외주 후보

### 5.1 1차 supplier / CDMO

| 회사 | 플랫폼 | IP / clinical 단계 | M4 적합도 |
|---|---|---|---|
| **Vaxxas (AU/US)** | **HD-MAP** (high-density microarray patch, ~3000 needles/cm²) ⓦ | HD-MAP COVID/influenza phase I/II ⓦ ; HD-MAP 가 IM 의 1/6 dose 균등 면역 ⓦ | ●●● 진피 표적 array (M4 dissolving 변형 가능) |
| **Kindeva Drug Delivery (US/UK)** | **CDMO** (former 3M DDS) ⓦ ; 흡입 · transdermal · microneedle · injectable 통합 ⓦ ; Emervax 협업 mRNA microneedle 2026 임상 진입 ⓦ | full-service cGMP MN array patches ⓦ | ●●● TTR scale-up 직접 외주 가능 |
| **Micron Biomedical (US)** | dissolving MN · pediatric vaccine MN patch ⓦ ; large-scale manufacturing 정렬 ⓦ | clinical trial phase ⓦ | ●●● dissolving polymer 직접 platform |
| **Corium (US)** | proprietary MN architecture · vaccine-delivery 임상 관계 ⓦ | clinical pipeline ⓦ | ●● topical/transdermal 경험 |
| **NanoPass MicronJet (IL/US)** | **hollow MN** (intradermal injection 600 μm ⓦ) ; FDA cleared 2021-06 ⓦ ; >30K injection / 7500 patient / 70 trial ⓦ | FDA 510(k) ⓦ + CE mark ⓦ | ●● hollow type — payload 가 *액상* 일 때만 적합 (dissolving 아님) |
| **Zosano Pharma (US)** | sumatriptan MN patch (M207) ⓖ — 2022 파산/자산매각 ⓖ | NDA 시도 → 실패 (formulation 이슈) ⓖ | ◐ legacy IP only |
| **Innopharma** ⓖ | small CDMO ⓖ | varied | ◐ |
| **3M (now Kindeva)** | sMTS · hMTS — solid · hollow MTS ⓦ | (Kindeva 로 spinoff) ⓦ | (Kindeva 와 통합) |
| **Raphas (KR)** ⓦ | dissolving MN · 화장품·약물 ⓦ | KFDA 등록 cosmetic MN ⓦ | ●●● Korea 시장 진입시 우선 (KFDA 가까움) |
| **QuadMedicine (KR)** ⓦ | dissolving MN ⓦ | clinical/cosmetic ⓦ | ●● KR 동남아 |
| **SNvia / Endoderma (KR)** ⓦ | dissolving MN ⓦ | cosmetic-grade ⓦ | ◐ |
| **TheraJect / Microdermics / Valeritas / Nitto Denko / Small Lab** ⓦ | varied MN ⓦ | varied ⓦ | ◐ 후보 inventory |

### 5.2 학술 그룹 (IP holder · 컨설팅 가능)

| Group | 기관 | 특기 |
|---|---|---|
| **Mark Prausnitz** ⓦ | Georgia Tech (ChBE) ; Regents' Professor ⓦ ; 1998 MN 1호 paper ⓦ ; **10 spinoff 회사** ⓦ | poke-and-patch · coat-and-poke · dissolving · hollow MN 전 platform · vaccine MN (CDC/Emory 협업) ⓦ |
| **Ryan Donnelly** ⓖ | Queen's University Belfast (Pharmacy) | hydrogel-forming MN · drug delivery |
| **Jung-Hwan Park / Hyungil Jung** ⓖ | Seoul National Univ / Yonsei (KR) | dissolving MN polymer 합성 + 산업화 |
| **Tarl Prow** ⓖ | UniSA (AU) | MN imaging + sampling |
| **Xianqing Yang / Chien-Yu Lin** ⓖ | varied | MN for cosmetic |

### 5.3 Polymer 후보 (분해성 MN body)

| Polymer | 분해 속도 | TTR molecule X payload 호환성 | 출처 |
|---|---|---|---|
| **PVP** (polyvinylpyrrolidone) | 빠름 (수분 안에 수 분 ⓦ) | hydrophilic small mol · protein OK ⓦ | dissolving MN 표준 ⓦ |
| **PVA** (polyvinyl alcohol) | 빠름 ⓦ | small mol · protein OK ⓦ | PVA + sorbitol 흔함 |
| **HA** (hyaluronic acid) | 빠름 (효소 분해 hyaluronidase) ⓦ | 친수성 / 단백질 stabilize ⓦ | natural biocompatible ⓦ |
| **CMC** (carboxymethyl cellulose) | 중간 ⓦ | hydrophilic ⓦ | standard ⓦ |
| **PLGA** (poly(lactic-co-glycolic acid)) | 느림 (수일~수주) ⓦ | sustained-release depot (microparticle 형식) ⓦ | sustained MN 용 ⓦ |
| **PLA** (polylactic acid) | 느림 ⓦ | sustained ⓦ | bone scaffold precedent |
| **Maltose** ⓖ | 매우 빠름 (수 분) | small mol only ; protein 잘 안됨 (높은 melt T) | early MN 연구 |
| **Trehalose** ⓖ | 빠름 | protein stabilizer 강 (lyo-protectant) | enzyme MN 적합 |
| **Sugar/sorbitol blends** ⓖ | 빠름 | small mol | cost-low |

→ **TTR M4 default**: **PVP / HA + PLGA microparticle depot** (PVP/HA = fast-release F1-F3 layer; PLGA depot = sustained F5 enzymatic). 학술 precedent ⓦ (https://www.sciencedirect.com/science/article/abs/pii/S0378517325004909 — dissolving MN + PLGA microparticle depot ⓦ).

### 5.4 cGMP scale-up route

```
Lab scale (M7)
   │ master mold (PDMS) · centrifugal casting · vacuum molding
   ▼
Pilot (M8-M9 IND-enabling)
   │ Kindeva / Micron Biomedical / Vaxxas (US 외주) — cGMP run
   │ Raphas / QuadMedicine (KR 외주) — KFDA 등록 가까움
   ▼
Commercial (M10)
   │ Kindeva 가 가장 풀-스택 (drug-device combo · cGMP · 미국+영국) ⓦ
```

---

## 6. Regulatory pathway — FDA / KFDA

### 6.1 FDA route (combination product)

**TTR = drug-device combination** (molecule X = drug · microneedle = device).

| Pathway | 적용 조건 | TTR fit |
|---|---|---|
| **NDA 505(b)(1)** | 완전 신규 drug · 자체 임상 데이터 | ●● molecule X 가 신규 (F1-F4 multi-active) → applicable |
| **NDA 505(b)(2)** | 자체 임상 + *공개 문헌* 또는 *타사 NDA* 의 데이터 활용 ⓦ ; PMOA 기반 center 할당 ⓦ | ●●● **default 권장** — H₂O₂ · ascorbate · DFO · EDTA · 5-ALA · imiquimod 등 모두 *기존 FDA approved* → 데이터 reuse 가능 ⓦ |
| **ANDA (generic)** | 기존 approved drug 의 generic | ✗ (TTR 신규 combo) |
| **De Novo (device)** | 신규 medium-risk device · predicate 부재 | ◐ (microneedle device 단독으로) — NanoPass MicronJet 가 510(k) ⓦ → predicate 가능성 |
| **510(k) (device)** | predicate device 동등성 | ●● MN device part — Vaxxas/MicronJet/Corium predicate ⓦ |
| **PMA (device class III)** | high-risk device | ✗ (MN 은 class II) |
| **IND (clinical 1상)** | drug 임상 전제 | ●●● **필수** — M10 입력 |

**PMOA (Primary Mode of Action) 판단**: TTR 의 PMOA = *drug* (분자 분해 화학) — device 는 delivery vehicle. → CDER (Center for Drug Evaluation and Research) 가 lead center; CDRH (device) 와 협력 ⓦ.

**cGMP 제형 요건**: 21 CFR 210/211 (drug) + 21 CFR 820 (device QSR) — combination 은 **둘 다** ⓦ. Kindeva 등 CDMO 가 이미 cGMP combination 정렬됨.

### 6.2 KFDA (Korean MFDS) route

| 분류 | 적용 |
|---|---|
| 일반의약품 (OTC) | ✗ — molecule X 가 신규 multi-active |
| 전문의약품 (Rx) | ●●● 신약 임상시험 IND 신청 (MFDS) |
| 의료기기 (Class II) | MN device part — KGMP |
| 의약품-의료기기 combination | KFDA 가이드라인 별도 (combination product) ⓖ |
| 화장품 (기능성) | ✗ — 의약품 효능 주장 (잉크 제거) 으로 화장품 분류 불가 |

→ **KR 진입 sequence**: 일반의약품 X · 화장품 X — 의약품 IND 만이 정직 경로. Raphas/QuadMedicine 의 cosmetic MN 은 *delivery vehicle* 으로만 활용 가능 (활성성분 없음 / very mild 보조제).

### 6.3 임상 1상 IND 패키지 구성요소 (M10 입력)

```
IND application (FDA 21 CFR 312.23)
├─ Cover sheet (1571 form)
├─ Table of contents
├─ Introductory statement + general investigational plan
├─ [§7 below] Investigator's brochure
├─ Protocol(s) — phase 1 dose escalation
├─ Chemistry, Manufacturing, Controls (CMC) — molecule X 합성 + GMP 제형 + MN device QSR
├─ Pharmacology + toxicology — animal study (M8-M9 산출물)
├─ Previous human experience — N/A 또는 published 인용
├─ Other (if any)
└─ Environmental assessment (대부분 categorical exclusion)
```

### 6.4 비교 timeline (precedent)

| Precedent product | Pathway | Lab → approval |
|---|---|---|
| **Levulan (5-ALA + PDT)** ⓖ | NDA 505(b)(1) + device 같이 | ~10 년 |
| **Imiquimod (Aldara) topical** ⓖ | NDA 505(b)(1) | ~8 년 |
| **Sumatriptan MN (Zosano M207)** ⓖ | NDA 505(b)(2) → CRL 후 회사 fail | ~10 년 (실패) |
| **NanoPass MicronJet (intradermal device)** ⓦ | 510(k) | ~5 년 |
| **Vaxxas HD-MAP** ⓦ | phase I/II 진행중 ⓦ | ~10 년 추정 |
| **TTR 예상 (M3→M10)** | 505(b)(2) + 510(k) component | ~7-10 년 (FDA 평균 NDA 시간 기준) |

---

## 7. 외부 검증 수치 (M3 / 시장 정합성)

### 7.1 글로벌 tattoo removal 시장

| Metric | 수치 | 출처 ⓦ |
|---|---|---|
| 2026 시장 규모 | **USD 0.79 B (360iResearch) – 1.49 B (Fortune)** ⓦ | (estimate 분산 = 정의 차이) |
| CAGR | **6.5 % – 16 %** ⓦ (mid: ~14 %) | 다수 firm |
| 2032/2034 예상 | USD 3-4 B (Allied · Fortune) ⓦ | |
| Tattoo *ink* 시장 (별개) | USD 560 M (2024) → 773 M (2032) ⓦ | market.us / verifiedmarketresearch ⓦ |

### 7.2 미국 laser session 가격 (per session)

| Tattoo size | 가격 (USD) |
|---|---|
| Small (<2 in) | 150 – 300 ⓦ |
| Medium (2-6 in) | 300 – 450 ⓦ |
| Large (6-10 in) | 450 – 700 ⓦ |
| XL (>10 in) | 700+ ⓦ |
| **평균 (ASPS)** | **697** ⓦ |
| **평균 (CareCredit)** | **353** (272-659) ⓦ |
| Geographic premium | NYC/LA/SF 500-1000+ (대비 Midwest/South 30-50% ↓) ⓦ |
| Full removal | 6-12 session × 위 = **USD 1.2K – 12K+** ⓦ |

→ TTR 한 튜브 sample 가격 가설: **USD 50-200 per 1 month 1-tube** (의약품 prescription markup 미정), 3 cycle 총 **USD 150-600** → laser 의 **5-20%** 비용. *cost-competitive 압도적*.

### 7.3 한국 가격 (참고 — 미fetch ⓖ)

- 대학병원 피부과: 1회 ₩100K-300K ⓖ
- 강남 피부과: 1회 ₩200K-500K ⓖ
- 전체 6-10회: ₩1.5M-5M ⓖ
- TTR 한국 가격 가설: 1 cycle ₩50K-200K (3 cycle ₩150K-600K) → 5-15% 비용 비교

### 7.4 잉크 시장 분율 (색별 · 화학별)

| 분율 축 | 수치 | 출처 ⓦ |
|---|---|---|
| **black ink share** | **48.6 %** (2024) ⓦ | market.us ⓦ |
| **organic pigment share** | **42.1 %** (2024) ⓦ | market.us ⓦ |
| Black & grey CAGR | 5.5 % (2024-2030) ⓦ | future market |

→ M1 §7 의 시장분율 추산 (azo+Fe ox+QA 60-70%; carbon 20-30%; Cu-Pc+Cr 10-15%) 와 **정합** — black ~50% + organic 42% ≈ TTR 의 cleavable 분율과 일치.

### 7.5 cost-of-goods 비교 (TTR 1 튜브 추정)

| 컴포넌트 | 추정 cost (per tube) | 비고 |
|---|---|---|
| Active F1 (H₂O₂ + Fe²⁺) | < $0.10 ⓖ | 화학 commodity |
| Active F2 (ascorbate) | < $0.10 ⓖ | OTC vit C |
| Active F3 (DFO 1-2%) | $2-5 ⓖ | API 비교적 비쌈 |
| Active F4 (TiO₂ NP + riboflavin) | < $0.50 ⓖ | sunscreen-grade |
| Active F5 (recombinant AzoR option) | $5-20 ⓖ | enzyme 단가 |
| MN array (dissolving polymer) | $1-5 ⓖ (학술 manufacturing cost ⓖ) | scale 에 따라 |
| Carrier · packaging | $1-3 ⓖ | |
| **Total COGS** | **$10-35 per tube** ⓖ | |
| Retail markup (Rx pricing) | 3-10× ⓖ | |
| **Expected retail** | **$30-300 per cycle** ⓖ | |

→ laser (per session $350-700 ⓦ) 의 10-20% — **첫 1-cycle 의 가격 우위 확실**. 3-cycle 누적도 laser 6-12 session 의 절반 이하.

---

## 8. Honest unknowns — web 으로도 못 채운 칸

| # | Unknown | 왜 못 채웠나 | M3-M10 어디서 풀리나 |
|---|---|---|---|
| 1 | **ChEMBL 2026 cpd count** | EBI 공식 페이지 미fetch — search snippet 은 v22 (1.6M) 만 ⓦ | ChEMBL homepage 직접 fetch (다음 turn) |
| 2 | **DrugBank academic download 재개일** | "Temporarily paused while they update" ⓦ — 재개일 미공개 | DrugBank Open Data (CC0 subset) 로 우회 가능 ⓦ |
| 3 | **EC 1.7.1.6 vs 1.7.1.17 (AzoR 정식 EC)** | BRENDA 페이지 자체에서 두 표기 혼재 ⓦ ; M2 의 EC 1.7.1.6 표기는 legacy ⓦ | M3 work 시 BRENDA + UniProt P41407 cross-check |
| 4 | **DiffDock open-source license/VRAM 정확 사양** | search 결과에 미포함 — GitHub README 미fetch | GitHub 직접 fetch (M3 GPU dispatch 전) |
| 5 | **KEGG REST API endpoint detail** | search 결과 부재 ⓦ | KEGG 공식 docs 직접 fetch |
| 6 | **ChemSpider 정확 cpd count + API key 요건** | search 결과 부재 ⓦ | RSC 공식 페이지 fetch |
| 7 | **Cu-Pc photo-Fenton Φ_¹O₂ in dermal** | 학술 paywall 우려 + first-principles 만 ⓖ | M5 (MD/QM) 또는 M8 (ex-vivo) 측정 |
| 8 | **Tattoo Vanish / Wrecking Balm 정확 ingredient list** | 제조사 미공개 ⓦ | reverse-engineer 또는 INCI 등록 검색 (별도 turn) |
| 9 | **Korean MFDS combination product 가이드라인 정확 문서명** | 한글 공식 fetch 미수행 ⓖ | MFDS 한국어 페이지 직접 fetch |
| 10 | **microneedle CDMO 단가 (per patch)** | 회사 공개 가격표 부재 ⓦ | Kindeva/Vaxxas/Micron 직접 견적 (M7-M8) |
| 11 | **Tattoo 시장 segment-color CAGR (black vs color 별도)** | 일부 mix 만 fetch — color 별 분해 데이터 부재 ⓦ | Maximize/Fortune full-report (paid) |
| 12 | **Imiquimod tattoo NCT active 0 의 이유** | search 결과 0 — *실제 종결/미등록/검색어 부재* 구분 불가 ⓦ | clinicaltrials.gov 직접 advanced search |
| 13 | **AlphaFold DB API 사양 (sunset 2026-06-25 이후)** | sunset 만 확인 ⓦ — 신규 endpoint 미확정 | EBI 직접 fetch (M3 시점) |
| 14 | **방향족 아민 (azo cleavage 산물) 진피→혈류 이동률** | 학술 paywall + first-principles 만 ⓖ | M5 + M6 toxicokinetic 모델링 |
| 15 | **Industry topical tattoo removal patent landscape** | SureChEMBL 직접 query 미수행 ⓦ | SureChEMBL + USPTO 직접 (M10) |

---

## 9. M3 directly-actionable handoff

### 9.1 M3 의 1st-day workflow

```
Day 1:
  1. PubChem PUG-REST batch → 62 handle CAS → CID → SMILES → SDF
  2. ChEMBL REST batch → bioactivity record (E°/log K 가용 시)
  3. BRENDA web → F5 12 효소 의 K_cat / K_M (EC + organism)
  4. COCONUT → 천연물 chelator (catechin · enterobactin · curcumin · hypericin) SMILES

Day 2-3:
  5. RDKit + OpenFF → 3D conformer 생성 (62 × top-3 conformer)
  6. AlphaFold DB → F5 효소 12 structure 다운로드
  7. PDB → ink target proxy (azo small-mol model · Fe oxide cluster · Cu-Pc crystal)
  8. AutoDock Vina batch dock (laptop 가능)

Day 4-5:
  9. GNINA rescore (GPU pod ~1-2 hr · CLAUDE.md d7 호환)
 10. G1-G5 gate score per candidate
 11. Top-N per family ranking → M3 산출물 ttr/research/m3_*.md
 12. M5 입력 (MD/QM recompute 후보 ≤ 20)
```

### 9.2 M3 산출물 형식 (predicted)

```yaml
# M3 output schema
candidate_id: F2_001_ascorbate
family: F2_reductive
target_match: [azo_NN, FeIII_lattice]
sources:
  pubchem_cid: 54670067   # ⓦ
  chembl_id: CHEMBL196
  cas: 50-81-7
  smiles: "[H]OC([H])(C([H])([H])O[H])C1=C(O[H])C(=O)OC1=O"
g1_thermodynamic:
  e_standard: -0.17   # V vs SHE (radical/ascorbate)
  passes: true        # vs target threshold
g2_kinetic:
  k_estimate: 1e-3    # s⁻¹ (laptop docking + MD M5 refine 필요)
  passes: tentative
g3_selectivity:
  vs_collagen: 0.05
  vs_melanin: 0.20
  passes: true
g4_availability:
  sigma_catalog: A4544
  cost_per_g_usd: 0.50
  passes: true
g5_regulatory:
  fda_status: OTC-cosmetic
  precedent: vitamin C topical (Cellex-C 등)
  passes: true
total_score: 4.5/5
m5_input: true
```

### 9.3 M3 → M4 (microneedle) handoff 변수

| Variable | M3 가 결정 | M4 가 결정 |
|---|---|---|
| molecule X MW | 분자 list → MW 분포 | MN polymer + dissolving rate |
| logP | log P range | carrier (water-sol vs lipid layer) |
| 농도 (per layer) | binding affinity | 폴리머 loading 한계 |
| 5-layer recipe | F1+F2+F3+F4+F5 ratio | bilayer / tri-layer MN 디자인 |
| photo trigger 동시 필요? | F4 양 | LED patch 부가 device |

---

## 10. Cross-reference

- M1: `~/core/demiurge/TTR/research/ink_classes.md` — 8 표적 카테고리 · BDE / log K / E°
- M2: `~/core/demiurge/TTR/research/moa_shortlist.md` — 5 family × 62 handle · §7 wall breakthrough Paths A-D
- M4: `~/core/demiurge/TTR/research/transdermal_delivery.md` — MN L=1000-1500 μm · payload plume 30-100 μm · M3 이 활성분자 결정시 M4 가 carrier 결정
- M6: `~/core/demiurge/TTR/research/off_target_safety.md` — 24-cell off-target risk matrix · molecule X constraint (MW>60kDa 또는 ink-surface affinity)
- TTR.md @goal — 한 튜브 30일 1회 90% 제거 · FDA-grade
- CLAUDE.md @D d1 — non-wet-lab 완료형 (본 문서는 first-principles + verified URLs)
- CLAUDE.md @D d2 — wall breakthrough — TTR.md M3 prerequisite 가 본 문서 (외부 inventory 가 M3 의 1차 entry point)
- CLAUDE.md @D d3 — design docs only — 본 문서는 .md only, 코드 없음
- CLAUDE.md @D d6 — first-principles physics — BDE / E° / log K + verified industrial fact

---

## 11. 결론

본 inventory 가 TTR M3 의 **prerequisite-research deliverable**.

- **DB stack (default 3)**: PubChem + ChEMBL + BRENDA — 62 handle 의 60 개 1-step 매칭 · F5 12 효소 의 K_cat 직접 lookup · 라이선스 open + API 안정
- **Tool stack (default 3)**: RDKit + AutoDock Vina + OpenMM — laptop CPU 로 1차 ranking · GPU pod 로 wall path A 의 photo-Fenton MD 확장 (M5)
- **Microneedle supplier (default 3)**: Kindeva (cGMP CDMO) + Micron Biomedical (dissolving platform) + Vaxxas (HD-MAP IP) — TTR M8-M10 의 외주 sequence
- **산업 fail history headline**: **현 시판 cream 0건이 진피 0.5-2mm wall 통과 못함** (모두 표피 박피로 우회 — TCA · hydroquinone · lactic acid) → TTR 의 differentiator = MN delivery × chemistry-rational molecule X
- **시장 우위 수치**: laser session $350-700 ⓦ × 6-12 회 = $1.2K-12K ⓦ vs TTR 추정 $30-300/cycle × 3 = $90-900 (laser 의 5-15%)

M3 가 본 inventory 의 입력으로 work 를 시작 — 다음 산출물은 `m3_ranking.md` (62 handle × G1-G5 gate score).

---
