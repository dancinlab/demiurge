# TTR-MN M5 — 잉크-활성분자 반응 MD/QM 시뮬레이션 design

> 출처: `m3_mn_candidates.md` (Top-3 candidate) + `arxiv_deep_research.md` (CeO₂ DFT · ink-as-catalyst · Cu-Pc TD-DFT) + `m3_mn_candidates.md §M5 handoff`
> milestone: TTR-MN.md "M5-MN 잉크-활성분자 반응 MD/QM"
> scope: simulation design doc (실제 실행은 hexa cloud, @D d7 — GPU pod)

## TL;DR

Top-3 candidate × top pigment target × phagolysosome / dermis pH = **시뮬레이션 매트릭스 12 cell**. 도구 stack: Vina docking + GROMACS + CHARMM36m (효소) + OPLS-AA (small molecule) + ReaxFF (NP bond-making) + ωB97X-D/def2-TZVP (transition state). MN-tip plume (반경 30-100 μm) 농도/확산 정합. **GPU pod 예산 ~$300-500** (laptop CPU docking + GPU MD/DFT 분리).

## 시뮬레이션 매트릭스 (12 cell)

| candidate | target pigment | pH | method | output | 우선순위 |
|---|---|---|---|---|---|
| CeO₂ NP (Ce₄₂O₈₀ cluster) | Azo monomer | 4.5 (lyso) | DFT cluster opt + ReaxFF MD | ΔG · Ea · ROS yield | ★★★ |
| CeO₂ NP | Azo monomer | 7.4 (dermis) | 동상 | ΔG (≈ 0 expected, 잠금 검증) | ★★★ |
| CeO₂ NP | Fe₂O₃ surface | 4.5 | ReaxFF MD 50 ns | surface chemistry · ink-as-catalyst | ★★ |
| CeO₂ NP | Cu-Pc unit | 4.5 | DFT + TD-DFT | electron transfer · macrocycle ring-open | ★★ |
| DyP peroxidase (PDB lookup) | Azo + Compound I | 4.0 | Vina docking + 50 ns MD CHARMM36m | binding mode · K_cat reasoning | ★★★ |
| DyP peroxidase | Cu-Pc | 4.0 | docking + MD | Q-band 위에 enzyme 인접성 · 가능성 평가 | ★★ |
| AzoR (PDB 1V4B) | Azo + FMNH⁻ | 7.0 | docking + 50 ns MD | NADPH 의존 cycle · 위치 | ★★★ |
| AzoR | aromatic amine product | 7.0 | follow-up MD | 부산물 enzyme dissociation kinetics | ★ |
| DFO | Fe₂O₃ surface | 7.4 | QM cluster + chelation ΔG | log K computed | ★★ |
| DFO | Cr₂O₃ surface | 7.4 | QM cluster | log K(Cr³⁺) · surface coordination | ★★ |
| Ascorbate | Azo radical reduction | 7.0 | DFT electron transfer | ΔG · 부산물 quench | ★ |
| TiO₂ NP + UV-A | Cr₂O₃ excited state | 7.0 | TD-DFT both NP | band-gap excited overlap · photo-Fenton | ★★ |

## Force field / QM method stack

| layer | method | 적용 |
|---|---|---|
| docking (정적) | AutoDock Vina (Apache-2) | enzyme-substrate first pose · 1h CPU |
| docking rescore | GNINA (CNN-rescore) | top pose 정합 confirm |
| MD (classical) | GROMACS + CHARMM36m | 단백질 효소 (DyP · AzoR · laccase) · 50-100 ns |
| MD (small molecule) | OPLS-AA force field | 작은 분자 (ascorbate · DFO) |
| MD (NP bond-making) | LAMMPS + ReaxFF | CeO₂ · TiO₂ · Cu_xFe_{3-x}O_4 |
| QM (DFT) | ωB97X-D / def2-TZVP (NWChem · ORCA · Q-Chem) | transition state · activation energy |
| QM (TD-DFT) | ωB97X-D / def2-TZVP excited states | Cu-Pc Q-band 670 nm · Cr₂O₃ band gap 3.4 eV · Ce³⁺/Ce⁴⁺ d-f transition |
| QM (high accuracy) | DLPNO-CCSD(T) / cc-pVTZ | benchmark check · 일부 transition state |
| Free energy | Umbrella sampling · WHAM · MetaD (Plumed) | chelation ΔG · enzyme cycle |
| Water model | TIP3P (CHARMM 정합) · SPC/E (OPLS) | 250 mM ionic 정합 (NaCl) |

## Workflow (ASCII)

```
   [M3 산출물 — 12 cell]
            │
            ▼
   ┌──────────────────────────────┐
   │ 1. Structure prep             │ ← PubChem / UniProt / PDB / AlphaFold fetch
   │    candidate SMILES → 3D       │   (per m3_mn_candidates §external lib plan)
   │    enzyme PDB → minimize       │
   │    NP cluster → build          │
   └──────────────────────────────┘
            │
            ▼
   ┌──────────────────────────────┐
   │ 2. Docking (laptop CPU)       │ ← Vina + GNINA rescore
   │    enzyme-substrate · NP-pigment │   1h/pair · top 5 pose
   └──────────────────────────────┘
            │
            ▼
   ┌──────────────────────────────┐
   │ 3. MD (GPU pod A100)          │ ← GROMACS / LAMMPS
   │    50-100 ns per system         │   24h/system
   │    pH 4.5 vs 7.4 dual           │
   └──────────────────────────────┘
            │
            ▼
   ┌──────────────────────────────┐
   │ 4. QM transition state         │ ← ωB97X-D / def2-TZVP
   │    NEB / climbing image         │   12h/reaction
   │    TD-DFT for photo (Cu-Pc · Cr₂O₃) │
   └──────────────────────────────┘
            │
            ▼
   ┌──────────────────────────────┐
   │ 5. Output → M3 ranking validate │ ← ΔG · Ea · ROS yield · 부산물
   │    M7 합성/제형 input            │   confidence interval
   └──────────────────────────────┘
```

## Compute budget (per @D d7)

| step | hardware | per system | system 수 | 총 비용 |
|---|---|---|---|---|
| Docking (Vina + GNINA) | laptop CPU (m1 ubu-1) | 1h | 12 | 12 CPU-hr · $0 (pool) |
| MD 50 ns CHARMM36m | RunPod / Vast.ai A100 24GB | 24h | 6 (효소 systems) | 144 GPU-hr · ~$150 |
| MD 50 ns ReaxFF (NP) | A100 24GB | 24h | 4 (NP systems) | 96 GPU-hr · ~$100 |
| DFT cluster opt | A100 24GB · NWChem | 12h | 8 | 96 GPU-hr · ~$100 |
| TD-DFT Q-band | A100 24GB | 8h | 4 | 32 GPU-hr · ~$35 |
| **합계** | — | — | — | **~$400** (A100 spot $1/hr 기준) |

⇒ per @D d7: small cluster (4-7 atom DFT cell) = pool 가능 · 큰 system (≥ 20 atom + dense k) = GPU pod. CeO₂ Ce₄₂O₈₀ cluster (122 atoms) = GPU pod 필수. DyP/AzoR enzyme (3-5k atom) = MD GPU pod.

## Pigment / molecule 구조 source

| target | source | identifier |
|---|---|---|
| Azo monomer (model) | PubChem CID 2169 (Methyl Orange model) | reasonable proxy |
| Phthalocyanine (model) | PubChem CID 5485 | parent ring |
| Cu-Pc | PubChem CID 14570 | macrocycle |
| Fe₂O₃ (hematite) | ICSD 22505 | unit cell |
| Cr₂O₃ | ICSD 9450 | unit cell |
| CeO₂ NP cluster | Materials Project mp-20194 + NP build | 5-10 nm cluster |
| AzoR | PDB 1V4B (E. coli) | 결정구조 있음 |
| DyP-type peroxidase | PDB 4G2C (B. adusta) / 2D3Q (A. auricula) | 둘 다 후보 |
| Laccase (Trametes versicolor) | PDB 1KYA | 결정구조 |
| HRP | PDB 1ATJ | parent |

## Expected outputs (per cell)

각 시뮬 결과:
- **ΔG (반응 자유에너지)**: kcal/mol · pH-dependent
- **Ea (활성화 에너지)**: kcal/mol · transition state
- **ROS yield**: ¹O₂ / •OH / H₂O₂ ratio (Cu-Pc · Cr₂O₃ photo cell)
- **부산물 prediction**: aromatic amine list (AzoR cell · M6 toxicokinetics 표적)
- **Binding affinity ΔG_bind**: kcal/mol (docking + MM-PBSA)
- **K_cat 추산**: TST + barrier crossing
- **확신도 구간**: 95% CI · force field sensitivity

## Wall-region (Cu-Pc · Cr₂O₃) 정량

| pigment | strategy | 시뮬 검증 | 임계치 |
|---|---|---|---|
| Cu-Pc | TD-DFT Q-band · enzyme docking | Φ(¹O₂) 정량 · DyP 인접성 | Φ > 0.05 = 의미있음 |
| Cr₂O₃ | TD-DFT band gap · DFO chelation | UV-A 365 nm photon → e⁻/h⁺ · log K(Cr³⁺) | log K > 25 = 효과적 |

⇒ arxiv:2405.11122 (Cr₂O₃ 3.4 eV 정량) + 2104.10994 (CeO₂ pH-switch) 기반 시뮬 정합 확인.

## Validation checkpoints

| step | gate criterion | next |
|---|---|---|
| Docking | ΔG_bind < -7 kcal/mol (drug-like) | MD 진입 |
| MD equilibration | RMSD plateau < 0.3 nm · density 1.00 g/mL | production MD |
| MD production | substrate 결합 stable > 30 ns of 50 ns | analysis |
| DFT TS | imaginary frequency 1개 · IRC connects | Ea report |
| TD-DFT | excitation energy 측정 ±0.2 eV | publish |
| 부산물 | aromatic amine MS spectra prediction | M6 reconcile |

## M7-MN handoff

다음 milestone (M7-MN: MN array engineering) 이 받는 입력:
- candidate stability profile (MD 결과 → lyophilization 안정성 추정)
- candidate concentration window (Ea → 효과적 농도 + safety 정합)
- payload encapsulation 제약 (CeO₂ NP 50 nm · DyP 50 kDa · AzoR 23 kDa · DFO 656 Da)
- 시뮬-기반 dissolution kinetics 예측 (Fick + diffusion + 반응 시상수)

## Honest unknowns

- **ReaxFF Ce-O parameter** 정확도 — open-source variant vs commercial · cross-check 필요
- **DyP PDB ID 확정** — Roberts 2011 / Liers 2013 specific variant 확인 (M3-MN unknowns 와 동일)
- **CeO₂ NP cluster size dependence** — 5 nm vs 50 nm 거동 차이 (시뮬 cluster 크기 한계)
- **Cu-Pc TD-DFT functional choice sensitivity** — ωB97X-D vs CAM-B3LYP vs SAOP, Q-band 시 ~0.3 eV scatter
- **pH-explicit MD** — constant pH MD scheme (CpHMD) implementation vs fixed pH
- **수렴 보장** — CeO₂ cluster DFT 가 large system · self-consistency 어려움 (M5 시 실제 시도)
- **Force field 이중-검증** — 다른 force field cross-check (CHARMM vs Amber) 필요할 수도
- **시뮬 vs 실험** — M5 결과가 wet-lab 데이터 없이 absorbed=false 유지 (@D d5 invariant)

## 진행 상태

- ✅ 12-cell simulation 매트릭스 · force field stack · compute budget 정의
- ✅ source structure ID 매핑 · workflow ASCII · validation gate
- ✅ wall-region (Cu-Pc · Cr₂O₃) 정량 path 명시
- ✅ M7-MN handoff input list
- ⏳ 실제 simulation 실행은 별 작업 (hexa cloud A100 pod · ~$400 예산) — design completed
- next: M7-MN MN array engineering design (needle 재료 · payload encapsulation · 분해성 polymer)
