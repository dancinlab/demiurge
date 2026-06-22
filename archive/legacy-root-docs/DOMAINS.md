# DOMAINS — demiurge 기본 제공 도메인 catalog (범용 연구영역)

> demiurge 신규 설치 / 프로젝트가 즉시 시연 가능한 "starter inventory" SSOT.
> demo-video shot 02 (20-tile 그리드) + production `/api/domains` default seed의 출처.
>
> **선정 원칙** — 특정 타사 브랜드 제품(`CASGEVY` · `OZEMPIC` · `TESLA-4680` · `LOIHI-2` …)이 아니라 **범용 연구영역/패러다임/타겟** (`NEUROMORPHIC` 스타일).
> 남의 회사 제품에 얹혀가지 않고, 어떤 팀이든 자기 후보를 그 영역 안에서 시작할 수 있는 일반 명칭.
> 도구·기법 단독(`CRISPR`)이 아니라 측정 클레임을 갖는 연구영역(`GENE-EDIT`)으로 표기.
>
> **네이밍** — `<NAME>.md` 도메인 SSOT 규칙 (UPPERCASE · 0-9 · `-` · `+`). 그리드 가독성 위해 12자 이내.

## 5축 × 20 우선 도메인 (demo-video 등재)

### 🔬 원자/물리 (4)

| 이름 | 연구영역 | 측정 클레임 예 |
|---|---|---|
| `RTSC` | 상온 초전도체 | Tc > 293K @ 1 atm · Meissner |
| `FUSION` | 자기/관성 핵융합 | Q ≥ 1 · 점화 7-gate |
| `ANTIMATTER` | antihydrogen 정밀 분광 | 1S-2S vs CODATA · g-factor |
| `QUBIT` | trapped-ion/초전도 큐비트 | 2-qubit fidelity · T1/T2 |

### 🧱 물질/소재 (4)

| 이름 | 연구영역 | 측정 클레임 예 |
|---|---|---|
| `PEROVSKITE` | metal-halide 광전 소재 | PCE @ AM1.5G · 24h 안정성 |
| `GRAPHENE` | 2D van der Waals 소재 | carrier mobility · 마법각 강상관 |
| `METAMATERIAL` | sub-λ 인공구조 | negative index · cloak |
| `AEROGEL` | 초저밀도 nanoporous | density · 열전도도 · BET |

### 🪪 칩/반도체 (4)

| 이름 | 연구영역 | 측정 클레임 예 |
|---|---|---|
| `NEUROMORPHIC` | spiking neural 실리콘 | TOPS/W · spike latency |
| `PHOTONIC` | photonic IC / optical compute | insertion loss · MZI precision |
| `MEMRISTOR` | in-memory compute crossbar | On/Off · endurance · VMM linearity |
| `SPINTRONIC` | spin-based MRAM / spin-orbit | TMR ratio · switching current |

### 🧬 바이오 (4)

| 이름 | 연구영역 | 측정 클레임 예 |
|---|---|---|
| `GENE-EDIT` | programmable genome editing | on/off-target · indel spectrum |
| `RNA-THERAPY` | mRNA/siRNA/ASO 치료 | LNP 전달 · 발현 · 안정성 |
| `ORGANOID` | 3D 줄기세포 모델 | maturation · vascularization |
| `PROTEIN-FOLD` | 구조 예측 / de novo 설계 | RMSD · binding affinity |

### ⚗️ 화학 (4)

| 이름 | 연구영역 | 측정 클레임 예 |
|---|---|---|
| `ELECTROCAT` | electrocatalysis (HER/OER/CO2RR) | overpotential · Tafel · FE |
| `PHOTOREDOX` | visible-light photoredox | 양자수율 · TON · 선택성 |
| `CO2-CAPTURE` | CO2 흡착 sorbent | uptake @ 298K · 재생 cycle |
| `GREEN-NH3` | 녹색 암모니아 합성 | NH3 yield rate · FE · N2 활성화 |

---

## 선정 알고리즘

20개 선정 기준 (각 축 4개):
1. **범용성** — 타사 브랜드 제품 ❌ · 연구영역/패러다임 ✓ (`NEUROMORPHIC` 스타일)
2. **측정 가능성** — 8-verb pipeline `verify` 단계에서 closed-form / numerical / citation 가능
3. **인지도** — 일반인/심사위원이 이름 들으면 "들어본 적 있다"
4. **시각화** — promo 영상에서 텍스트 + 색상 + 도형으로 표현 가능
5. **글자수** — 12자 이내 (그리드 가독성)

### Category-OK vs 회피 대조

| 축 | ✓ 범용 연구영역 | ❌ 회피 |
|---|---|---|
| 원자 | RTSC · QUBIT | (특정 후보 LK-99 · H3S 단독) |
| 물질 | PEROVSKITE · GRAPHENE | TESLA-4680 · CATL-QILIN (타사 제품) |
| 칩 | NEUROMORPHIC · MEMRISTOR | LOIHI-2 · AKIDA (타사 제품) |
| 바이오 | GENE-EDIT · RNA-THERAPY | CASGEVY · OZEMPIC (타사 제품) · CRISPR (도구 단독) |
| 화학 | ELECTROCAT · CO2-CAPTURE | MOF-5 · ZIF-8 (특정 framework 단독) |

---

## Full brainstorm inventory (8 rounds → depletion)

> seed = "demo-video 홍보용 demiurge 범용 연구영역 후보 · 원자/물질/칩/바이오/화학 5축 · 타사 브랜드 제외 · 8-round depletion"

| Round | 원자 | 물질 | 칩 | 바이오 | 화학 |
|---|---|---|---|---|---|
| 1 mainstream | RTSC · FUSION · ANTIMATTER · QUBIT | PEROVSKITE · GRAPHENE · AEROGEL · SUPERALLOY | NEUROMORPHIC · PHOTONIC · MEMRISTOR · SPINTRONIC | GENE-EDIT · RNA-THERAPY · ORGANOID · PROTEIN-FOLD | ELECTROCAT · PHOTOREDOX · CO2-CAPTURE · GREEN-NH3 |
| 2 hot-2026 | HYDRIDE-SC · TOPOLOGICAL · BEC · KAGOME | METAMATERIAL · MULTIFERROIC · SKYRMION · HIGH-ENTROPY | IN-MEMORY · RESERVOIR · CRYO-CMOS · THERMOELEC | SENOLYTIC · IMMUNOTHER · MICROBIOME · NEUROPROSTH | WATER-SPLIT · FLOW-CHEM · ASYMMETRIC · BIOCATAL |
| 3 frontier | MUON-CATAL · ATOM-INTER · NEUTRINO · DARK-MATTER | TWISTRONIC · FLAT-BAND · LIQUID-METAL · PROGRAM-MAT | PHOTONIC-NN · QUANTUM-DOT · NV-CENTER · ISING-MACH | AGING-CLOCK · GENE-CIRCUIT · SYNTH-BIO · BIOPRINT | SINGLE-ATOM · FRUSTRATED · MECHANOCHEM · ORGANOCAT |
| 4 niche | HYPERFINE · RYDBERG · OPTICAL-CLK · SPIN-SQUEEZE | 2D-MATERIAL · METAL-GLASS · PIEZO · AUXETIC | SPIN-HALL · FERROELEC · TFET · DNA-STORAGE | PHAGE-THER · CELL-FREE · BIOSENSOR · OPTOGENET | SUPRAMOLEC · IONIC-LIQ · RADICAL · ENZYME-DESIGN |
| 5 energy | SOLAR-FUEL · THORIUM · ICF · MAGNET-CONF | SOLID-BATT · NA-ION · REDOX-FLOW · THERMAL-PCM | ENERGY-HARV · LOW-POWER · EDGE-AI · IN-SENSOR | BIOFUEL · CARBON-FIX · NITROGEN-FIX · ALGAE | METHANOL-SYN · ELECTROFUEL · H2-STORAGE · CO-VALORIZE |
| 6 quantum/info | ION-TRAP · NEUTRAL-ATOM · TOPOLOG-Q · MAJORANA | QUANTUM-MAT · WEYL-SEMIM · MOTT-INS · CHARGE-ORDER | QPU · ANNEALER · PHOTONIC-Q · SPIN-QUBIT | QUANTUM-BIO · PHOTOSYNTH · MAGNETORECEPT · NEURAL-CODE | QUANTUM-CHEM · SPIN-CHEM · ELECTRON-TRANS · EXCITON |
| 7 exotic | AXION · GRAV-WAVE · STRANGE-MAT · TIME-CRYSTAL | ACTIVE-MAT · SELF-HEAL · SHAPE-MEM · COLLOIDAL | PROBABILISTIC · STOCHASTIC · CNT-FET · ATOMIC-MEM | CELL-REPROG · EPIGENET · XENO-ORGAN · LIVING-MAT | PLASMA-CHEM · DIRECT-AIR · ATOM-ECONOMY · CLICK-CHEM |
| 8 saturation | — | — | — | — | — |

**Depletion** at Round 7 (Round 8 후보는 모두 1-7 변종으로 흡수 — 예: `ION-TRAP` ⊂ `QUBIT`, `SOLID-BATT` ⊂ 물질 battery). 총 고유 후보 ≈ 135.

---

## 활용 위치 (SSOT 다운스트림)

| 위치 | 용도 |
|---|---|
| `domains/<NAME>.md` + `<NAME>.log.md` | starter 도메인 스캐폴드 (`DOMAINS.tape` 등재) |
| `demo-video/src/XprizeDemo.tsx::Domains02` | 20-tile 그리드 콘텐츠 |
| `demo-video/src/content/narration.json` | shot 02 capture 지시문 |
| (향후) `demiurge cli list-domains --starter` | 신규 프로젝트 부트스트랩 시 default seed 후보 |
| (향후) `web/lib/domains.ts` | /api/domains 빈 결과일 때 fallback inventory |
| Devpost narrative | "20 research domains across atom · matter · chip · bio · chem" |

---

## 비-목표

- ❌ 본 20에 없다고 demiurge가 그 영역을 못 다룬다는 의미 아님 — promo 시연에 가장 효과적인 sampler일 뿐
- ❌ 회사 내부 프로젝트(`CARDIO+` · `AURA` · `MONDALOY` · `DAPTPGX` 등)은 운영 도메인으로 정상 진행 — 단지 대중 promo에 적합도 낮아 demo-video 그리드에서 제외
- ❌ 특정 타사 브랜드 제품(`CASGEVY` · `OZEMPIC` · `TESLA-4680` 등) — 상표 연관성/얹혀가기 회피, 범용 연구영역으로만 표기

---

## 변경 절차

20 후보를 늘리거나 바꾸려면:
1. 본 파일에 후보 + 5축 + 범용성/측정/인지도/시각화/글자수 평가표 추가
2. `domains/<NAME>.md` + `<NAME>.log.md` 스캐폴드 생성 + `DOMAINS.tape`에 등재
3. `demo-video/src/XprizeDemo.tsx::Domains02::tiles` 배열 수정
4. 재렌더 (`npm run render`) + 영상 검수
5. 별도 PR (g4 stacked)
