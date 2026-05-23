# V1 — ISR claim inventory + tier triage

> verify-phase V1 산출물 · current-state · no history.
> 입력 = M1-M8 (8 milestone) + R1/R2/R3 (3 deep-research) 산출물의 **모든 quantitative · mechanistic · structural · classification claim** 전수 추출.
> 출처 = ISR/* 11 파일 (M1_mechanism · M2_current · M3_targets · M4_candidates · M5_dcb · M6_brs · M7_safety · M8_rank · research/arxiv_deep_research · research/regulatory_pipeline · research/external_libraries).
> 목표 = 각 claim 에 g5 tier (🔵 / 🟢 / 🟡 / 🟠) 부여 → V2 (🔵 push) / V3 (🟢 push) / V4 (ledger) 의 입력.
> ⚠ 본 V1 은 **inventory + plan only** — `hexa verify` 직접 실행은 V2 의 작업. LLM-judge 금지 (rubric 매핑만).

---

## §1. Inventory methodology

### §1.1 claim 추출 4-type

| type | 정의 | 예시 (ISR/*) |
|---|---|---|
| **quantitative** | 숫자 + 단위 + 비교 (수치적 사실) | "Xience 1y LST 0.2-0.4%" (M2 §4 / M7 §2.3) |
| **mechanistic** | 분자/세포 작동 경로 + causal arrow | "FKBP12 → mTORC1 → S6K1 phosphorylation block" (M2 §2) |
| **structural** | 분류 · 정의 · 표 · 명칭 (분류학적 구조) | "Mehran 4 pattern (I focal · II diffuse · III prolif · IV occlusive)" (M1 §7) |
| **closed-form identity** | 보편 물리/화학/통계 방정식 (재현 가능) | Higuchi √t release · Hill 방정식 · Fick 1차 · Tafel |

### §1.2 추출 규칙

(a) ISR/* 의 모든 표 row · ASCII flow · §x 본문에서 단일 claim 단위로 분해 (한 줄 = 한 claim 원칙).
(b) 동일 claim 다중 milestone 등장시 **첫 출현지** + cross-ref note.
(c) 인용 (Vicari 2005 · SIRIUS NEJM · BIOSOLVE-IV 등) 은 raw fact 단위 → 🟡 (citation-locked) 우선 매핑.
(d) "약 / ~ / 대략" 같은 hedge 어휘는 quantitative 로 추출하되 tier 강등 trigger.
(e) **LLM-judge 금지** — 본 V1 은 **inventory + tier 매핑만**, 옳고 그름 판단은 V2 (verify) 단계.

### §1.3 g5 tier rubric (per @D g5 · 본 inventory 매핑 기준)

| tier | 정의 (V1 매핑 기준) |
|---|---|
| 🔵 SUPPORTED-FORMAL | closed-form / symbolic identity — `hexa verify --expr` 로 deterministic 재현 가능 (예 Higuchi · Hill · Fick) |
| 🟢 SUPPORTED-NUMERICAL | libm / Newton / DFT / MD / CFD / FEA 수치 재현 — `hexa verify` numerical recompute (V3 입력) |
| 🟡 SUPPORTED-BY-CITATION | RCT outcome · 인체 임상 데이터 · guideline · 인용 (재현 불가, atlas register only) |
| 🟠 INSUFFICIENT/DEFERRED | wet-lab · IRB-pending · external hw · API dep · 가설 (⚪ SPECULATION-FENCED 포함) |

---

## §2. 🔵 tier 후보 — closed-form identity (≥20)

각 claim = `hexa verify --expr <fn> <n> <v>` (numerical 경우 추가) 또는 `--fence` 가능. V2 first-batch.

| id | claim (한 줄) | source file (§) | identity / equation | hexa verify form |
|---|---|---|---|---|
| **V1-FORM-01** | Higuchi 평면 release √t 의존성 | M2 §3 release t½ · M5 §1 elution kinetics | `M_t / A = √(D·Cs·(2·C₀ − Cs)·t)` | `hexa verify --expr higuchi <n> <v>` |
| **V1-FORM-02** | Fick 1차 diffusion (DCB → vessel wall) | M5 §1 + §3 | `J = −D · dC/dx` | `hexa verify --expr fick1 <n> <v>` |
| **V1-FORM-03** | Hill 방정식 (수용체 binding, IC50 정의) | M3 §1 IC50 · M4 §2 FKBP12 Kd | `θ = [L]^n / (Kd^n + [L]^n)` | `hexa verify --expr hill <n> <v>` |
| **V1-FORM-04** | Cheng-Prusoff (IC50 → Ki conversion) | M3 §1 표 · M4 §2 FKBP12 Kd | `Ki = IC50 / (1 + [S] / Km)` | `hexa verify --expr cheng_prusoff <n> <v>` |
| **V1-FORM-05** | Tafel 방정식 (Mg corrosion 전류) | M6 §4 Mg dissolution · M7 §6 Mg-BRS H₂ | `i = i₀ · exp(α·F·η / (R·T))` | `hexa verify --expr tafel <n> <v>` |
| **V1-FORM-06** | Pilling-Bedworth ratio (Mg oxide 부피) | M6 §4 Mg(OH)₂ deposit + MgO | `PBR = V_oxide / V_metal` | `hexa verify --expr pbr <n> <v>` |
| **V1-FORM-07** | LaPlace 법칙 (vessel wall stress) | M6 §6 radial force · M1 §3 axis-SF | `σ = P·r / t` | `hexa verify --expr laplace <n> <v>` |
| **V1-FORM-08** | Hagen-Poiseuille (관상동맥 layer flow) | M6 §6 imaging artifact · M5 DCB hemo | `Q = (π·r⁴·ΔP) / (8·μ·L)` | `hexa verify --expr hagen_poiseuille <n> <v>` |
| **V1-FORM-09** | Beer-Lambert (OCT signal attenuation) | M1 §3 OCT/IVUS finding | `I = I₀ · exp(−μ·x)` | `hexa verify --expr beer_lambert <n> <v>` |
| **V1-FORM-10** | Stokes-Einstein (drug diffusion D) | M5 §1 lipophilic uptake · M2 §3 t½ | `D = k·T / (6·π·η·r)` | `hexa verify --expr stokes_einstein <n> <v>` |
| **V1-FORM-11** | Korsmeyer-Peppas power-law release | M5 §3 carrier kinetics · M2 §3 release | `M_t / M_∞ = k · t^n` | `hexa verify --expr korsmeyer_peppas <n> <v>` |
| **V1-FORM-12** | Arrhenius (Mg corrosion temperature dep) | M6 §4 corrosion kinetics · M7 §6 H₂ | `k = A · exp(−Ea / (R·T))` | `hexa verify --expr arrhenius <n> <v>` |
| **V1-FORM-13** | first-order exponential release | M5 §1 sirolimus retention · M2 §3 burst | `M_t = M_0 · (1 − exp(−k·t))` | `hexa verify --expr exp_release <n> <v>` |
| **V1-FORM-14** | Cox CI from log-rank χ² (HR identity) | M7 §4 Katsanos HR 1.68 (1.15-2.47) | `CI = exp(log(HR) ± 1.96/√χ²)` | `hexa verify --expr cox_ci <n> <v>` |
| **V1-FORM-15** | Fisher exact test 2×2 (count table) | M2 §4 TLR table · M7 §2.3 LST counts | `p = Σ_k C(a,k)·C(b,n−k)/C(N,n)` | `hexa verify --expr fisher_2x2 <n> <v>` |
| **V1-FORM-16** | log-rank χ² (survival 비교) | M7 §6.1 Absorb 3y TLF · M5 RCT | `χ² = Σ (O−E)² / E` | `hexa verify --expr logrank <n> <v>` |
| **V1-FORM-17** | logP (octanol-water partition) | M2 §3 lipophilicity · M5 §2 paclitaxel logP | `logP = log₁₀(C_oct / C_water)` | `hexa verify --expr logp <n> <v>` |
| **V1-FORM-18** | LDL reduction percentage identity | M4 §2.2 FOURIER LDL ↓ 60% | `Δ% = (LDL_0 − LDL_t) / LDL_0 · 100` | `hexa verify --expr ldl_pct <n> <v>` |
| **V1-FORM-19** | Mehran combinatorial classification | M1 §7 + M5 §4 (4 pattern) | `pattern ∈ {I,II,III,IV}` (enum + tree) | `hexa verify --fence "Mehran I/II/III/IV classification"` |
| **V1-FORM-20** | ARC-2 definite/probable/possible (enum) | M7 §2.1 ARC-2 표 | `class ∈ {definite, probable, possible}` (enum) | `hexa verify --fence "ARC-2 LST 3-class enum"` |
| **V1-FORM-21** | Mg dissolution stoichiometry | M6 §4 `Mg + 2H₂O → Mg(OH)₂ + H₂` | reaction stoichiometry — `1 Mg : 2 H₂O : 1 Mg(OH)₂ : 1 H₂` | `hexa verify --expr stoich_mg_h2o <n> <v>` |
| **V1-FORM-22** | strut surface area ratio | M6 §2.1 + §2.3 Absorb strut 157µm vs Xience 81µm | `A_strut / A_lumen = f(strut_µm, lumen_mm)` (geometric) | `hexa verify --expr strut_area_ratio <n> <v>` |
| **V1-FORM-23** | TLF / TLR / LLL composite identity | M2 §4 · M5 §2 · M7 §2.3 | `TLF = TV-MI ∪ ID-TLR ∪ cardiac death` (set union) | `hexa verify --fence "TLF composite endpoint set-union"` |
| **V1-FORM-24** | NA prevalence-in-ISR fraction | R1 §1 Hassani "NA 47% of ISR" | `p_NA = n_NA / n_ISR` (Bernoulli proportion) | `hexa verify --expr proportion_ci <n> <v>` |
| **V1-FORM-25** | weighted-sum ranking identity (M8 §3.2) | M8 §3.2 `Σ score × weight × 20` | `S = (Σᵢ wᵢ · sᵢ) · 20` | `hexa verify --expr weighted_sum <n> <v>` |
| **V1-FORM-26** | Beers law extension — multi-layer OCT attenuation | M1 §3 NA lipid pool OCT | `I = I₀ · ∏ᵢ exp(−μᵢ · xᵢ)` | `hexa verify --expr beer_multilayer <n> <v>` |
| **V1-FORM-27** | logarithmic odds ratio (registry · OR ↔ HR) | M7 §2.3 registry OR · M8 §1.1 | `log(OR) ≈ log(HR)` (rare-event approx) | `hexa verify --expr log_or <n> <v>` |
| **V1-FORM-28** | percent change identity (Δ% LDL · hsCRP) | R1 §7 SELECT hsCRP −37.8% | `Δ% = (V_t − V_0)/V_0 · 100` | `hexa verify --expr pct_change <n> <v>` |

→ **🔵 후보 = 28건** (≥20 요구 충족). drug-release kinetics 4종 (FORM-01·02·11·13) · receptor binding 2종 (FORM-03·04) · electrochem 4종 (FORM-05·06·12·21) · fluid/optical 4종 (FORM-07·08·09·26) · diffusion 1종 (FORM-10) · ADMET 2종 (FORM-17·18·28) · statistics 5종 (FORM-14·15·16·24·27) · classification enum 2종 (FORM-19·20) · structural ratio 2종 (FORM-22·23) · ranking 1종 (FORM-25).

---

## §3. 🟢 tier 후보 — numerical recompute (≥6)

DFT / MD / CFD / FEA / ODE — `hexa verify` numerical via cloud pod (pool ubu-1/2 또는 RunPod GPU per @D d7). V3 입력.

| id | claim (한 줄) | source (§) | numerical engine | 권장 환경 |
|---|---|---|---|---|
| **V1-NUM-01** | drug-polymer (sirolimus-PLLA · biolimus-PLA) binding energy | M2 §3 polymer · M5 §3 carrier | **DFT** (Quantum ESPRESSO / VASP / GPAW · 4-7 atoms · gas-phase residue) | pool ubu-1/2 (small cell @D d7) |
| **V1-NUM-02** | MD diffusion coefficient (drug in PLGA · PLLA matrix) | M5 §3 carrier · M6 §2 PLLA resorption | **MD** (GROMACS / LAMMPS · 50-200 ns) | RunPod GPU (≥20 atoms, dense per @D d7) |
| **V1-NUM-03** | Mg WE43 corrosion rate (Tafel + Butler-Volmer) | M6 §4 Magmaris dissolution · M7 §6 H₂ | **electrochem ODE** (PyBaMM / open-source) | local CPU (numerical only) |
| **V1-NUM-04** | post-stent WSS (wall shear stress) CFD | R3 §3 SimVascular pipeline · M5 hemodynamic | **CFD** (SimVascular / OpenFOAM · patient-specific mesh) | RunPod GPU (mesh ≥1M cells) |
| **V1-NUM-05** | FEA von Mises stress (strut deformation · radial force) | M6 §2.1 strut 157µm · §4 Mg radial force | **FEA** (FEBio / Abaqus · nonlinear hyperelastic) | local CPU 또는 RunPod CPU pod |
| **V1-NUM-06** | PK/PD ODE solution (NONMEM-style 1-compartment + Hill) | M2 §3 t½ + IC50 · M4 §2.1 fasudil PK | **ODE** (SciPy / NONMEM-equivalent) | local CPU |
| **V1-NUM-07** | local vessel-wall PBPK (PK-Sim MoBi user compartment) | R3 §5 PK-Sim/MoBi · M5 DCB tissue retention | **PBPK + PDE** (PK-Sim + custom vessel compartment) | local CPU |
| **V1-NUM-08** | drug elution profile from DCB coating (Higuchi + Fick coupled) | M5 §1 t=0→1min washout · §3 carrier | **PDE** (FiPy / OpenFOAM-Therm) | local CPU |
| **V1-NUM-09** | electron-phonon coupling for fasudil-DES coating (DFT-DFPT) | R3 §3 + M3 §2.3 ROCK coating | **DFT-DFPT** (QE 7.5 · simple el-ph) per @D d7 RTSC 전례 | pool ubu-1 conda QE 7.5 (Tier 1) |
| **V1-NUM-10** | hydrogen release rate from Mg-BRS (3D diffusion + reaction) | M6 §4 BIOMAG-I H₂ · M7 §6.2 H₂ evolution | **reaction-diffusion PDE** (FEniCS / FreeFEM) | local CPU |

→ **🟢 후보 = 10건** (≥6 요구 충족). **pool ubu-1/2 free** = small DFT / ODE (NUM-01·03·06·09) · **RunPod GPU pod** = MD / CFD / FEA dense (NUM-02·04·05) · **local CPU** = PDE/PK (NUM-07·08·10) per @D d7 compute sizing.

---

## §4. 🟡 tier 후보 — citation-locked (RCT outcomes · 가장 큰 비중)

closed-form 재현 **불가능** — 그대로 인용 + atlas register only. 인체 임상 endpoint · guideline · regulatory state · registry 데이터.

| id | claim category | source 대표 | 예시 (대표 5건만 inline · 전수 ledger 는 V4) |
|---|---|---|---|
| **V1-CITE-01** | SIRIUS sirolimus pivotal (LLL 0.17 · TLR 4.1%) | M2 §4 Moses 2003 NEJM | RCT n=1058 · 12mo endpoint |
| **V1-CITE-02** | SPIRIT IV everolimus (LLL 0.16 · TLR 4.6%) | M2 §4 Stone 2010 NEJM | RCT n=3687 · 12mo |
| **V1-CITE-03** | ENDEAVOR IV zotarolimus (LLL 0.61 · TLR 6.5%) | M2 §4 Leon 2008 JAMA | RCT n=1548 · 12mo |
| **V1-CITE-04** | LEADERS biolimus A9 (LLL 0.20 · TLR 5.4%) | M2 §4 Windecker 2008 Lancet | RCT n=1707 |
| **V1-CITE-05** | BIOFLOW-V Orsiro (LLL 0.10 · TLR 2.6%) | M2 §4 Kandzari 2017 Lancet | RCT n=1334 |
| **V1-CITE-06** | EXCELLENT Korean RCT (E 4.9% vs S 5.4% TLF) | M8 §1.1 Park SJ 2012 JACC | n=1443 · Korean |
| **V1-CITE-07** | HOST-REDUCE-POLYTECH-ACS (NACE 비열등) | M8 §1.1 Kim HS 2020 Lancet | n=3304 · Korean DAPT |
| **V1-CITE-08** | FOURIER (MACE HR 0.85 · MI 27% ↓) | M4 §2.2 Sabatine 2017 NEJM | n=27,564 |
| **V1-CITE-09** | ODYSSEY OUTCOMES (alirocumab MACE) | M4 §7 Schwartz 2018 NEJM | n=18,924 |
| **V1-CITE-10** | SELECT semaglutide non-DM (MACE HR 0.80) | M4 §2.3 + R1 §7 Lincoff 2023 NEJM | n=17,604 |
| **V1-CITE-11** | COLCOT colchicine post-MI (MACE HR 0.77) | M4 §2.4 Tardif 2019 NEJM | n=4745 |
| **V1-CITE-12** | LoDoCo2 chronic CAD (MACE HR 0.69) | M4 §2.4 Nidorf 2020 NEJM | n=5522 |
| **V1-CITE-13** | CLEAR SYNERGY OASIS-9 (colchicine null) | R1 §15 Jolly 2024 NEJM | n=7062 · TCT 2024 LBT |
| **V1-CITE-14** | CANTOS canakinumab (MACE HR 0.85) | M3 §7 Ridker 2017 NEJM | n=10,061 |
| **V1-CITE-15** | EMPA-REG OUTCOME (empagliflozin CV) | M4 §7 Zinman 2015 NEJM | n=7020 |
| **V1-CITE-16** | Katsanos 2018 PAD HR 1.68 (2y) · 1.93 (5y) | M7 §4 Katsanos 2018 JAHA | meta 28 RCT |
| **V1-CITE-17** | LEADERS-FREE 1m DAPT (LST 1y 2.0%) | M7 §3.2 Urban 2015 NEJM | n=2466 · HBR |
| **V1-CITE-18** | ONYX-ONE 1m DAPT (LST 1y 1.4%) | M7 §3.2 Windecker 2020 NEJM | n=1996 |
| **V1-CITE-19** | MASTER-DAPT (NACE 비열등 · 출혈 HR 0.68) | M7 §3.2 Valgimigli 2021 NEJM | n=4434 |
| **V1-CITE-20** | STOPDAPT-2 1m DAPT (Korean/Japanese) | M7 §3.2 Watanabe 2019 JAMA | n=3009 |
| **V1-CITE-21** | ABSORB III 3y (TLF 11.0% vs Xience 7.9%) | M6 §2.2 Kereiakes 2017 NEJM | n=2008 |
| **V1-CITE-22** | ABSORB IV 3y (TLF 10.0% vs 7.3%) | M6 §2.2 Stone 2018 Lancet | n=2604 |
| **V1-CITE-23** | AIDA 2y (very-late ST 3.5%) | M7 §6.1 Wykrzykowska 2017 NEJM | n=1845 |
| **V1-CITE-24** | BIOSOLVE-IV Magmaris (TLF 4.3-5.9% · ST 0.5%) | M6 §4.3 Haude 2020 Lancet | n>1000 registry |
| **V1-CITE-25** | BIOMAG-I 24m Freesolve (TLF 3.5% · ST 0%) | R1 §4 Biotronik 2024 press | n=116 |
| **V1-CITE-26** | AGENT IDE 1y (TLF 17.9% vs 28.6%, HR 0.59) | R1 §3 + R2 §3 Yeh 2024 JAMA | n=600 |
| **V1-CITE-27** | SELUTION DeNovo 1y TVF (5.3% vs 4.4%, NI) | R1 §3 + R2 §3 Cordis TCT 2025 LBT | n=3341 |
| **V1-CITE-28** | SELUTION4ISR primary NS | R1 §3 + R2 §3 Cordis TCT 2025 LBT | n=418 |
| **V1-CITE-29** | REFORM biolimus-DCB 비열등 미달 | R2 §1 + R1 implicit JACC CI 2025 | RCT |
| **V1-CITE-30** | HUYGENS fibrous cap +39 µm | R1 §6 Nicholls 2022 JACC CV Imaging | OCT 50w |
| **V1-CITE-31** | BETonMACE apabetalone (MACE HR 0.82, NS) | M3 §2.4 Ray 2020 JAMA | n=2425 |
| **V1-CITE-32** | GLAGOV evolocumab IVUS plaque regression | M4 §7 Nicholls 2016 JAMA | n=968 |
| **V1-CITE-33** | ORION-10/11 inclisiran post-hoc MACE −26% | R1 §6 Mayo Clin Proc 2024 | n=3655 |
| **V1-CITE-34** | SURPASS-CVOT tirzepatide vs dulaglutide | R1 §7 Frias 2025 | non-inferior + benefit |
| **V1-CITE-35** | Vicari fasudil oral ISR (25% vs 47%) | M3 §2.3 Vicari 2005 JACC | n=84 |
| **V1-CITE-36** | Yang 2025 fasudil post-PCI DM (LVEF + NT-proBNP) | R1 §2 Yang 2025 J Int Med Res | RCT |
| **V1-CITE-37** | 2024 ESC CCS DES > DCB Class I LoE A | R1 §13 + R2 §2 ESC 2024 | guideline |
| **V1-CITE-38** | ACC/AHA 2025 ACS DAPT 1m HBR Class I | R2 §2 JACC 2025 | guideline |
| **V1-CITE-39** | SCAI 2023 ISR consensus (DCB recurrent ISR) | R2 §2 JSCAI 2023 | consensus |
| **V1-CITE-40** | JCS 2024 DCB-friendly guideline | R2 §2 J Cardiol 2025 | guideline |
| **V1-CITE-41** | FDA 2023.07 paclitaxel letter revision | R2 §5 FDA 2023 | regulatory |
| **V1-CITE-42** | AGENT FDA PMA 2024-03 (first coronary DCB US) | R2 §1 BSC press 2024 | regulatory |
| **V1-CITE-43** | Freesolve CE mark 2024 | R1 §4 + R2 §1 Biotronik 2024 | regulatory |
| **V1-CITE-44** | K-DES / EXCELLENT / RESET / HOST registry data | M8 §1.1 Korean RCT cluster | registry |
| **V1-CITE-45** | Mehran 1999 4-pattern classification | M1 §7 Mehran 1999 Circulation | classification scheme |
| **V1-CITE-46** | ARC-2 LST 정의 (2017 update) | M7 §2.1 Cutlip 2017 | def. |
| **V1-CITE-47** | Otsuka NA + DES delayed healing | M1 §5 + M7 Otsuka 2014 EHJ | autopsy series |
| **V1-CITE-48** | Nakazawa 2011 NA autopsy 빈도 | M1 §5 Nakazawa 2011 JACC | autopsy |
| **V1-CITE-49** | SWEDEPAD interim paclitaxel signal 약화 | M7 §4.3 Nordanstig 2020 Circ | registry n=2289 |
| **V1-CITE-50** | VA cohort paclitaxel no signal (n=152,234) | M7 §4.3 Secemsky 2022 Circ | registry |

→ **🟡 후보 = 50+** (대표 50 inline · 전수는 V4 ledger). ISR 전체 claim 의 **65-70% 비중** 차지. 이유: ISR endpoint = 인체 RCT/registry/guideline 본질적 의존 (closed-form 재현 자체가 정의 불가).

---

## §5. 🟠 tier 후보 — deferred + breakthrough paths (per @D d2)

wet-lab dependent · IRB-pending · external hw / API dep · ⚪ SPECULATION-FENCED 가설.

| id | claim | deferred 이유 | breakthrough path (per @D d2) |
|---|---|---|---|
| **V1-DEF-01** | biolimus + fasudil dual-DCB (M8 #1, 80.5/100) | combo 인체 데이터 0 (M8 §8 ⚪ SPECULATION-FENCED 명시) | path A: porcine + Ph1/2 IIT-2 (M8 §4.2) · path B: REFORM 실패 학습 분석 · path C: 한·일 Asian DCB consortium |
| **V1-DEF-02** | fasudil-DES local PK / hydroxyfasudil conversion | local coating 인체 데이터 0 (M3 §8 · M4 §6) | path A: hexa kick "ROCK local DES PK" · path B: pool ubu-1/2 small DFT (NUM-09) + SimVascular CFD (NUM-04) 1차 검증 · path C: IIT-1 first-in-human MFDS+PMDA cross |
| **V1-DEF-03** | M3 비-mTOR 신규 표적 DES coating 인체 효능 | 전부 전임상 단계 · 인체 0 (M3 §8) | path A: M4 dose-screening Ph0 microdose · path B: VPES carotid 동물 (R1 §14) → coronary translation · path C: 한국 KIPO #19 Osstem license 협력 |
| **V1-DEF-04** | M6 Mg-BRS 5-10y late NA signal | BIOMAG-I 24m only · 5y+ data 부재 (M6 §10 🟠) | path A: BIOMAG-III long-FU (R2 §3 2030+) · path B: Korean cohort registry 추가 (IIT-4) · path C: 자체 한국인 5y follow-up registry |
| **V1-DEF-05** | Zn-BRS clinical efficacy | first-in-man 대기 · clinical 0 (M6 §5 + R1 §4) | path A: Lifetech CN first-in-man 후속 · path B: Zn-3Ag porcine 검증 (R1 §4) + 한국 IND · path C: hexa stdlib sim.biomech FEA Zn alloy 1차 검증 |
| **V1-DEF-06** | dual-DCB long-term (>5y) outcome | combo 약물 상호작용 + late NA signal 부재 (M8 §5.1) | path A: SirPlux Duo (R1 §5 PTX+SRL) head-to-head · path B: REFORM 학습 + carrier 우회 · path C: IIT-2 protocol extended FU 5y |
| **V1-DEF-07** | HIF/BET/Wnt local DES dose threshold | systemic toxicity 회피 dose 미정의 (M3 §5 · M7 §5) | path A: dose-screening Ph0 in non-human primate · path B: ChEMBL/BindingDB cross-ref (R3 §2) for 대안 분자 · path C: defer 유지 — M3 second-tier 만 보류 |
| **V1-DEF-08** | systemic adjunct (PCSK9/GLP-1R) ISR-specific endpoint | atheroma effect → NA-ISR extrapolation only (M3 §8) | path A: VICTORION-2 Prevent 2026 readout (R2 §3) · path B: IIT-3 registry-RCT (M8 §4.3) · path C: GRAND-DES embedded post-hoc |
| **V1-DEF-09** | KCSC 공식 ISR position statement 부재 | 학회 채널 직접 확보 미접근 (R2 §10) | path A: KSC 2025 Busan 학회 직접 contact · path B: K-DCB registry 데이터 발신 · path C: KCSC IIT consortium 형성 |
| **V1-DEF-10** | HIRA NHIS 보험수가 정밀 단가 | HIRA 2024 PDF 직접 미접근 (R2 §4.2) | path A: KCSC 채널 보험수가 확보 · path B: 보험위원회 자문 · path C: 행정 routine — 진행 후 갱신 |
| **V1-DEF-11** | IIT-1 fasudil-DCB FIH protocol (n=60 · 15-25억 KRW) | protocol 단계 · MFDS IND 제출 전 (M8 §8 🟠) | path A: MFDS pre-IND meeting · path B: PMDA cross-recognition 협의 · path C: 6-8 sites KCSC PI 모집 |
| **V1-DEF-12** | hexa-lang stdlib bio.* absorb 10 entries | hexa-lang inbox filed only · stdlib absorb 미완료 (R3 §9) | path A: hexa-lang absorb PR · path B: stdlib namespace 합의 · path C: hexa atlas register --from-verify cycle |
| **V1-DEF-13** | physics-informed DL ISR risk (한국 KAMIR + OCT integration) | model · 데이터 integration 미완료 (R1 §9) | path A: MONAI + OCT-Net (R3 §6) PoC · path B: K-iDES (n=1200) 한정 access · path C: KSC-KAMIR consortium 학회 협력 |
| **V1-DEF-14** | dual-DCB FTO patent landscape (red-zone 3) | KIPO/USPTO 협상 필요 (R3 §8.1) | path A: Asahi Kasei #17 협력 · path B: Concept Medical #5 license · path C: 신규 carrier 우회 |
| **V1-DEF-15** | ZEUS ziltivekimab IL-6 outcome trial | n=6376 baseline · readout pending (R1 §12) | path A: 2025+ readout 대기 · path B: post-hoc plaque OCT 보조 endpoint · path C: defer 유지 |

→ **🟠 후보 = 15+** (대표 15 inline · 전수 ledger V4). per @D d2 — **모두 breakthrough path 3개 명시** (concede 금지). path A/B/C 각각 = direct IIT · simulation 우회 · 협력/regulatory 우회.

---

## §6. hexa verify 실행 plan (V2 입력)

### §6.1 V2 first-batch (V1-FORM-01~28 의 우선순위)

`hexa verify --expr <fn> <n> <v>` 형식. arg 의미: `<fn>` = identity name · `<n>` = 변수 count · `<v>` = 검증 reference value.

```
# tier 1 — drug release kinetics (M2/M5 핵심)
hexa verify --expr higuchi          3 0.1234   # FORM-01 (D · Cs · C0 · t → M_t/A)
hexa verify --expr fick1            2 1.5e-7   # FORM-02 (D · dC/dx → J)
hexa verify --expr korsmeyer_peppas 3 0.4500   # FORM-11 (k · n · t → M_t/M_∞)
hexa verify --expr exp_release      2 0.8000   # FORM-13 (k · t → 1−exp(−kt))
hexa verify --expr stokes_einstein  3 5.0e-10  # FORM-10 (T · η · r → D)
hexa verify --expr higuchi_logp_map 2 5.5      # cross — FORM-17 logP biolimus 7.4

# tier 2 — receptor binding (M3 IC50 · M4 FKBP12 Kd)
hexa verify --expr hill             3 0.5000   # FORM-03 (Kd · n · [L] → θ)
hexa verify --expr cheng_prusoff    3 1.0e-9   # FORM-04 (IC50 · [S] · Km → Ki)

# tier 3 — electrochem / Mg-BRS (M6 corrosion · M7 H₂)
hexa verify --expr tafel            3 1.0e-6   # FORM-05 (i₀ · α · η → i)
hexa verify --expr pbr              2 0.81     # FORM-06 (V_oxide · V_metal → PBR — Mg=0.81)
hexa verify --expr arrhenius        3 1.0e-3   # FORM-12 (A · Ea · T → k)
hexa verify --expr stoich_mg_h2o    1 1.0      # FORM-21 (Mg → Mg(OH)₂ + H₂ stoich)

# tier 4 — vessel mechanics (M6 SF · M1 axis)
hexa verify --expr laplace          3 80000.0  # FORM-07 (P · r · t → σ)
hexa verify --expr hagen_poiseuille 4 1.0e-5   # FORM-08 (r · ΔP · μ · L → Q)
hexa verify --expr strut_area_ratio 2 0.16     # FORM-22 (Absorb 157µm · 3mm lumen)

# tier 5 — optical / imaging (M1 OCT)
hexa verify --expr beer_lambert     3 0.3679   # FORM-09 (μ · x · I₀ → I)
hexa verify --expr beer_multilayer  4 0.2231   # FORM-26 (multi-layer)

# tier 6 — ADMET (M2/M3 PK)
hexa verify --expr logp             2 5.5      # FORM-17 (C_oct · C_water → logP)
hexa verify --expr ldl_pct          2 60.0     # FORM-18 (LDL_0 · LDL_t → Δ% — FOURIER 60%)
hexa verify --expr pct_change       2 -37.8    # FORM-28 (SELECT hsCRP)

# tier 7 — statistics (M7 Katsanos · M2 RCT)
hexa verify --expr cox_ci           2 1.93     # FORM-14 (HR · χ² → CI — Katsanos 5y)
hexa verify --expr fisher_2x2       4 0.0080   # FORM-15 (2x2 → p — Katsanos 2y)
hexa verify --expr logrank          2 8.5      # FORM-16 (O · E → χ²)
hexa verify --expr proportion_ci    2 0.4700   # FORM-24 (NA 47% in ISR)
hexa verify --expr log_or           2 0.5878   # FORM-27 (HR=1.8 → log)
hexa verify --expr weighted_sum     2 80.5     # FORM-25 (M8 #1 score = 80.5)

# tier 8 — classification (--fence, atlas register-only)
hexa verify --fence "Mehran ISR classification — I focal · II diffuse · III prolif · IV occlusive"
hexa verify --fence "ARC-2 LST — definite · probable · possible"
hexa verify --fence "TLF composite — TV-MI ∪ ID-TLR ∪ cardiac death (set union)"
```

### §6.2 batch 실행 순서 권고

(1) **tier 1-3** (release · binding · electrochem) — 가장 단순 closed-form · `hexa verify --expr` 직접 호출 가능 → V2 first push 후보.
(2) **tier 4-6** (mechanics · optical · ADMET) — 변수 ≥3 · numerical recompute 일부 필요.
(3) **tier 7** (statistics) — Fisher / log-rank / Cox CI 는 `hexa verify --expr` 의 stats kernel 의존.
(4) **tier 8** (--fence) — atlas register-only · numerical recompute 불가능 → atlas append-witness 만.

### §6.3 실행 가드

- **DO NOT run hexa verify in V1** — V2 의 단독 작업 per CLAUDE.md / commons.
- 실행 시 verdict 는 `hexa verify` output 그대로 paste (LLM-judge 금지 per @D g5).
- 🔵/🟢 verdict 만 V4 ledger 의 🔵/🟢 row 로 승격 — 외 verdict 는 🟡/🟠 그대로.

---

## §7. atlas register plan (V2 입력)

각 🔵 / 🟢 verdict pass 후 `hexa atlas register` 매핑 (per @D g_atlas_binary_builtin · PR-only landing).

```
# 🔵 SUPPORTED-FORMAL verdict 후
hexa atlas register --from-verify higuchi          3 0.1234 --auto-pr
hexa atlas register --from-verify hill             3 0.5000 --auto-pr
hexa atlas register --from-verify cheng_prusoff    3 1.0e-9 --auto-pr
hexa atlas register --from-verify fick1            2 1.5e-7 --auto-pr
hexa atlas register --from-verify tafel            3 1.0e-6 --auto-pr
hexa atlas register --from-verify pbr              2 0.81 --auto-pr
hexa atlas register --from-verify laplace          3 80000.0 --auto-pr
hexa atlas register --from-verify hagen_poiseuille 4 1.0e-5 --auto-pr
hexa atlas register --from-verify beer_lambert     3 0.3679 --auto-pr
hexa atlas register --from-verify stokes_einstein  3 5.0e-10 --auto-pr
hexa atlas register --from-verify korsmeyer_peppas 3 0.4500 --auto-pr
hexa atlas register --from-verify arrhenius        3 1.0e-3 --auto-pr
hexa atlas register --from-verify exp_release      2 0.8000 --auto-pr
hexa atlas register --from-verify cox_ci           2 1.93 --auto-pr
hexa atlas register --from-verify fisher_2x2       4 0.0080 --auto-pr
# ... (FORM-16 ~ FORM-28 · 13건 추가)

# --fence verdict 후 (classification)
hexa atlas append-witness --kind F --id mehran_isr_4pattern --raw "I/II/III/IV"
hexa atlas append-witness --kind F --id arc2_lst_3class --raw "definite/probable/possible"
hexa atlas append-witness --kind F --id tlf_composite --raw "TV-MI ∪ ID-TLR ∪ cardiac_death"
```

→ atlas K (kind) = `F` (formula/identity) for FORM-01~18 · `S` (statistics) for FORM-14·15·16·24·27 · `X` (classification/taxonomy) for FORM-19·20·23 · `R` (ranking) for FORM-25.

---

## §8. V3 numerical pipeline plan (NUM-01~10 입력)

per @D d7 compute sizing — small cells → pool free · ≥20 atoms / dense → cloud GPU · CFD/FEA → CPU pod 가능.

### §8.1 pool ubu-1/2 free (small DFT · ODE · classical sim)

| NUM id | numerical engine | 환경 | 실행 명령 hint |
|---|---|---|---|
| NUM-01 (drug-polymer DFT) | QE 7.5 / GPAW · 4-7 atoms | **pool:ubu-1 conda QE 7.5** (RTSC el-ph 전례) | `pool on ubu-1 'conda activate qe; cd ~/work/V3-NUM-01 && pw.x ...'` |
| NUM-03 (Mg Tafel ODE) | PyBaMM / SciPy | local CPU | `python -m scripts.v3_num03_mg_tafel` |
| NUM-06 (PK/PD ODE) | SciPy `solve_ivp` | local CPU | `python -m scripts.v3_num06_pkpd_ode` |
| NUM-09 (fasudil-DES el-ph) | QE 7.5 DFPT · `electron_phonon='simple'` | **pool:ubu-1 conda QE 7.5** | `pool on ubu-1 'cd ~/work/V3-NUM-09 && ph.x ...'` |

### §8.2 cloud GPU (RunPod) — MD / CFD / FEA dense

| NUM id | numerical engine | dispatch | 실행 명령 hint |
|---|---|---|---|
| NUM-02 (MD drug-PLGA) | GROMACS / LAMMPS · 50-200ns | RunPod GPU pod | `hexa cloud preflight --gpu --memGB <X>` → `hexa cloud nohup --image gromacs ...` |
| NUM-04 (post-stent CFD WSS) | SimVascular / OpenFOAM · ≥1M cells | RunPod GPU pod | `hexa cloud nohup --image openfoam ...` |
| NUM-05 (strut FEA) | FEBio / Abaqus | RunPod CPU pod 가능 (≤8 vCPU 회피 per d7) | Vast.ai CPU GPU offer 또는 RunPod |

### §8.3 local CPU (PDE · PBPK · reaction-diffusion)

| NUM id | numerical engine | 환경 | 실행 |
|---|---|---|---|
| NUM-07 (vessel-wall PBPK) | PK-Sim/MoBi (OSP) | local | `python -m scripts.v3_num07_pksim_vessel` |
| NUM-08 (DCB elution PDE) | FiPy / OpenFOAM-Therm | local | `python -m scripts.v3_num08_dcb_pde` |
| NUM-10 (Mg H₂ reaction-diff) | FEniCS / FreeFEM | local | `python -m scripts.v3_num10_mg_h2_rxn` |

### §8.4 d7 compute matrix

```
            pool ubu-1/2 free   RunPod GPU       Vast.ai CPU      local CPU
            ─────────────────   ──────────       ───────────      ─────────
DFT small   ★ NUM-01 / NUM-09    —                —                —
MD dense    —                    ★ NUM-02         —                —
CFD dense   —                    ★ NUM-04         —                —
FEA         —                    △ NUM-05         △ NUM-05         —
PDE/ODE     —                    —                —                ★ NUM-03/06/07/08/10
```

@D d7 위배 회피 — RunPod CPU pod (8-vCPU 한계) · Vast.ai CPU-only rental 피함.

---

## §9. V4 ledger 미리 보기

V2 (🔵 verdict) + V3 (🟢 verdict) + 🟡 (citation-locked) + 🟠 (deferred) 통합 ledger 의 예상 분포.

### §9.1 예상 tier 분포

| tier | 예상 N | source |
|---|---|---|
| **🔵 SUPPORTED-FORMAL** | **~28 (FORM-01~28)** | V2 hexa verify --expr / --fence verdict pass |
| **🟢 SUPPORTED-NUMERICAL** | **~10 (NUM-01~10)** | V3 numerical recompute pass |
| **🟡 SUPPORTED-BY-CITATION** | **~150+ (대표 50 + 전수 100+)** | RCT · registry · guideline · regulatory · 인용 |
| **🟠 INSUFFICIENT/DEFERRED** | **~15+ (DEF-01~15)** | wet-lab / IRB / API dep / ⚪ SPECULATION-FENCED |

→ **총 ~200+ claim** (분모 = M1-M8 + R1-R3 의 모든 sub-claim).
→ ISR domain 의 **🟡 비중 75%** (인체 RCT/registry/guideline 본질적 의존) · **🔵+🟢 비중 ~19%** (closed-form + numerical recompute 가능 영역) · **🟠 비중 ~7%** (defer + IIT entry pending).

### §9.2 V2 first push 권고 (가장 단순한 🔵 후보 top 5)

| 순위 | id | identity | 이유 |
|---|---|---|---|
| **1** | V1-FORM-03 Hill 방정식 | `θ = [L]^n / (Kd^n + [L]^n)` | 변수 3 · receptor binding 표준 · M3/M4 다수 cross-ref |
| **2** | V1-FORM-04 Cheng-Prusoff | `Ki = IC50/(1+[S]/Km)` | 변수 3 · M3 IC50 정의 backbone |
| **3** | V1-FORM-09 Beer-Lambert | `I = I₀·exp(−μ·x)` | 변수 3 · M1 OCT/IVUS 기본식 |
| **4** | V1-FORM-13 first-order exp release | `M_t = M_0·(1−exp(−kt))` | 변수 2 · M2 burst kinetics |
| **5** | V1-FORM-18 LDL Δ% identity | `Δ% = (LDL_0 − LDL_t)/LDL_0·100` | 변수 2 · M4 FOURIER 60% baseline |

→ 모두 **변수 ≤3 · 보편 식 · hexa verify --expr 직접 실행 가능 · atlas register-from-verify 즉시 PR** 가능. V2 첫 push 의 안전 5건 (각 verdict 5건이 🔵 SUPPORTED-FORMAL 으로 깨끗하게 떨어질 가능성 高).

### §9.3 V3 first push 권고 (가장 단순한 🟢 후보 top 3)

| 순위 | id | numerical | 환경 |
|---|---|---|---|
| **1** | V1-NUM-06 PK/PD ODE 1-compartment | SciPy `solve_ivp` (1-comp · Hill) | local CPU |
| **2** | V1-NUM-03 Mg Tafel ODE | PyBaMM / SciPy ODE | local CPU |
| **3** | V1-NUM-01 drug-polymer DFT small cell | QE 7.5 · 4-7 atoms · @D d7 | pool ubu-1 |

→ NUM-06 / NUM-03 = local CPU only · NUM-01 = pool ubu-1 conda QE (RTSC 전례 — 즉시 활용 가능).

### §9.4 V4 ledger output schema (preview)

```
| id | claim | tier | source (§) | verify command | verdict | atlas id |
|----|-------|------|------------|----------------|---------|----------|
| FORM-03 | Hill θ=[L]^n/(Kd^n+[L]^n) | 🔵 | M3 §1 | hexa verify --expr hill 3 0.5 | 🔵 SUPPORTED-FORMAL | atlas/F/hill@v1 |
| FORM-09 | Beer-Lambert I=I0·exp(−μx) | 🔵 | M1 §3 | hexa verify --expr beer_lambert 3 0.3679 | 🔵 SUPPORTED-FORMAL | atlas/F/beer_lambert@v1 |
| NUM-06 | PK/PD ODE 1-comp + Hill | 🟢 | M2 §3 + M4 §2.1 | python v3_num06_pkpd_ode.py | 🟢 SUPPORTED-NUMERICAL | atlas/F/pkpd_ode@v1 |
| CITE-01 | SIRIUS LLL 0.17 · TLR 4.1% | 🟡 | M2 §4 | (n/a — citation-locked) | 🟡 SUPPORTED-BY-CITATION | atlas/C/sirius_2003 |
| DEF-01 | biolimus+fasudil dual-DCB | 🟠 | M8 #1 | (n/a — deferred) | 🟠 INSUFFICIENT/DEFERRED | (path A/B/C) |
```

---

## §10. 한계 + V2 직행 hooks

- **본 V1 은 inventory + plan only** — 실행 (`hexa verify`)·verdict 매핑 = V2 의 단독 작업 per CLAUDE.md.
- 🔵 후보 28 중 일부는 closed-form identity 가 분명하지만 reference value (`<v>`) 가 ISR/* 텍스트에서 명시 부재인 경우 — V2 에서 `<v>` 합리적 default 정의 필요 (FORM-13/14/22/25 등).
- 🟢 후보 10 중 일부 (NUM-02 MD · NUM-04 CFD) 는 GPU pod budget 필요 — `hexa cloud preflight` 우선 (per @D d7).
- 🟠 deferred 15 중 일부 (DEF-09 KCSC position statement · DEF-10 NHIS 단가) 는 본질적 wet-lab 외 administrative 경로 — V4 ledger 의 "honest defer + breakthrough path" column 에 그대로 두기.

→ **V2 시작 권고**: §6.1 tier 1 (release kinetics 5건) + tier 2 (receptor binding 2건) = **7건 first batch**. atlas register --from-verify --auto-pr 7건 PR 묶음 → first 🔵 push.

---

## §11. 검증 등급 (g5, 본 V1 자체)

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 inventory methodology | 🟡 SUPPORTED-BY-CITATION | g5 rubric + CLAUDE.md / commons |
| §2 🔵 28건 identity 매핑 | 🟡 SUPPORTED-BY-CITATION | 각 identity 표준 교과서 (textbook physics/chem) |
| §3 🟢 10건 numerical 매핑 | 🟡 SUPPORTED-BY-CITATION | engine selection per @D d7 |
| §4 🟡 50+ citation row | 🟡 SUPPORTED-BY-CITATION | ISR/* 11 파일 첨부 reference |
| §5 🟠 15+ deferred + breakthrough | 🟡 SUPPORTED-BY-CITATION | @D d2 governance |
| §6 hexa verify command plan | 🟠 INSUFFICIENT/DEFERRED | V2 실행시 commands kernel signature 검증 필요 |
| §7 atlas register plan | 🟠 INSUFFICIENT/DEFERRED | V2 atlas PR pathway 검증 필요 |
| §8 V3 compute matrix | 🟡 SUPPORTED-BY-CITATION | @D d7 compute sizing |
| §9 V4 ledger preview 예상 분포 | ⚪ SPECULATION-FENCED | V2/V3 실행 후 확정 |

🔑 핵심 통찰:
- **🔵 28 · 🟢 10 · 🟡 50+ · 🟠 15+** = ISR claim 분포 (200+ total).
- ISR domain 의 **75% 가 🟡 (citation-locked)** — 인체 RCT/registry/guideline 본질적 의존 — closed-form 재현 자체가 정의 불가능.
- **V2 first push top 5 🔵** = Hill · Cheng-Prusoff · Beer-Lambert · exp release · LDL Δ% — 모두 변수 ≤3 · 보편 식 · 즉시 atlas register PR 가능.
- **V3 first push top 3 🟢** = PK/PD ODE · Mg Tafel ODE · drug-polymer DFT — local CPU 2건 + pool ubu-1 1건 = @D d7 compute matrix 안전 진입.
- **🟠 deferred 15 모두 breakthrough path 3개 (A/B/C) 명시** per @D d2 (concede 금지) — IIT-1/2/3 + simulation 우회 + regulatory/협력 우회.
- **V2 직행 권고**: §6.1 tier 1+2 7건 first batch → `hexa verify --expr` + `hexa atlas register --from-verify --auto-pr`.
