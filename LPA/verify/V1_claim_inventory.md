# V1 — LPA claim inventory + tier triage

@goal: M1-M7 + R1-R3에 등장한 모든 정량 claim을 inventory + tier 분류 → V2/V3 작업 입력

## 분류 규칙 (per @D g5 · TECS-L)

- 🔵 SUPPORTED-FORMAL — closed-form / symbolic identity (atlas 등록 필수)
- 🟢 SUPPORTED-NUMERICAL — libm/Newton/Monte Carlo 재계산 일치
- 🟡 SUPPORTED-BY-CITATION — 문헌 인용 only (recompute 없음)
- 🟠 INSUFFICIENT/DEFERRED — calc path 없음 또는 external hw/data 의존
- 🔴 FALSIFIED — calc 결정적 불일치 (closed negative)

## 인벤토리 (45 claims)

| ID | 출처 | claim | 현재 tier | 목표 tier | V2/V3 경로 |
|---|---|---|---|---|---|
| C01 | M1 §3 | KIV-2 copy ↔ plasma level inverse log10 (β=-0.06/copy) | 🟢 (R1 §2.4) | 🔵 | V2 atlas |
| C02 | M1 §5 | 한국인 ≥50 mg/dL = 10-15% | 🟡 | 🟢 | V3 ref |
| C03 | M1 §7 | 스타틴 → Lp(a) 무효 (오히려 +5-10%) | 🟡 | 🟡 | (citation only) |
| C04 | M2 §3 | 한국 4,300만 × 12.5% = 537.5만 명 | 🟢 (산술) | 🔵 | V2 atlas (산술 등록) |
| C05 | M2 §4 | rs10455872 한국인 minor allele ~4% vs 백인 ~7% | 🟡 | 🟡 | (gnomAD) |
| C06 | M3 §2 | pelacarsen Ph2 Lp(a) -80% (Tsimikas NEJM 2020) | 🟡 | 🟡 | (RCT) |
| C07 | M3 §3 | HORIZON n=8,323 · α=0.05 · β=0.20 · HR 0.85 → events D=920 (anticipated) | 🟢 (R1 §2.3) | 🔵 | V2 atlas (Schoenfeld) |
| C08 | M3 §3 | HORIZON Schoenfeld recompute D=844 (HR 0.80) → adequate | 🟢 (R1 §2.3 / R2 §8) | 🔵 | V2 atlas |
| C09 | M3 §3 | HORIZON readout 2026 H1 + 규제 제출 2026 H2 | 🟡 (Novartis IR) | 🟡 | (date) |
| C10 | M4 §2 | olpasiran Ph2 Lp(a) -98% (NEJM 2022 O'Donoghue) | 🟡 | 🟢 | V3a siRNA ODE |
| C11 | M4 §2 | OCEAN(a)-Outcomes n=7,297 · primary completion 2026-12 → readout 2027 H1 | 🟡 | 🟡 | (date) |
| C12 | M4 §2 | OCEAN(a)-DOSE Ph2 n/arm = 43 vs protocol ≥48 closed-form power | 🟢 (R1 §2.2) | 🔵 | V2 atlas (binary power) |
| C13 | M4 §3 | lepodisiran -94% at 60wk single SC (Nissen JAMA 2023) | 🟡 | 🟢 | V3a siRNA ODE |
| C14 | M4 §3 | ACCLAIM-Lp(a) n=12,500 readout 2029 | 🟡 | 🟡 | (date) |
| C15 | M4 §4 | zerlasiran -80~90% Q24W (ALPACAR-360) | 🟡 | 🟢 | V3a siRNA ODE |
| C16 | M4 §6 | siRNA catalytic > ASO stoichiometric (1 siRNA-RISC : N mRNA) | 🟡 (mechanistic) | 🟢 | V3a kinetics 검증 |
| C17 | M5 §2 | PCSK9 mAb → Lp(a) -25% (FOURIER O'Donoghue 2019) | 🟡 | 🟡 | (RCT) |
| C18 | M5 §3 | obicetrapib ROSE2 Ph2 Lp(a) -56% (Nicholls JAMA 2024) | 🟡 | 🟡 | (RCT) |
| C19 | M5 §6 | apheresis acute Lp(a) ↓ ~60-75% / 평균 -30% (German registry) | 🟡 | 🟡 | (registry) |
| C20 | M6 §2 | KIV-2 high copy lifelong null carrier ~10% 인구 (Mendelian) | 🟡 | 🟡 | (Mendelian, observational) |
| C21 | M6 §4 | inclisiran ORION-9/10/11 GalNAc-siRNA 안전 패러다임 (외삽) | 🟡 | 🟡 | (analog) |
| C22 | M7 §2 | Burgess 2018 MR Lp(a) 1-SD ↓ → CHD HR 0.71 (95% CI 0.67-0.75) | 🟢 (R1 §2.1) | **🔵** | **V2 atlas (IVW formula) ← PRIMARY 🔵 target** |
| C23 | M7 §2 | β_IVW = -0.342490 · SE=0.028774 · Z=-11.90 | 🟢 (R1 §2.1) | 🔵 | V2 atlas |
| C24 | M7 §3 | FOURIER Lp(a) ≥50 mg/dL subset ~17% RRR (O'Donoghue 2019) | 🟡 | 🟡 | (RCT subset) |
| C25 | M7 §5 | 한국 ASCVD 2차 5y MACE baseline 15-20% | 🟡 (KAMIR registry) | 🟡 | (registry) |
| C26 | M7 §5 | 한국 5y NNT siRNA 도입 시 ~25-35 | 🟢 (R2 §8) | 🟢 | V3c MC |
| C27 | M7 §6 | 약물 외삽 ~50% 감쇠 가정 (lifelong vs late) | 🟡 (heuristic) | 🟠 (PROMOTED) | V3a sensitivity |
| C28 | R1 §3 | muvalaplin Ph2 KRAKEN -85.8% 경구 (NEJM 2025) | 🟡 | 🟡 | (RCT) |
| C29 | R1 §3 | VERVE-301 LPA base editor dev candidate Q1 2025 (preclinical) | 🟡 | 🟡 | (preclinical IR) |
| C30 | R1 §6 | hexa verify --expr sigma(6)=12 🔵 sanity | 🔵 | 🔵 | (sanity baseline) |
| C31 | R2 §2 | KSoLA 2026 Position Paper 3-tier cutoff (≥50=high) | 🟡 | 🟡 | (society guideline) |
| C32 | R2 §3 | 한국 ≥75 nmol/L = 15.3% · ≥120 = 7.9% (14,158명) | 🟡 (KSoLA fact sheet) | 🟢 | V3 ref |
| C33 | R2 §6 | 한국 PCSK9i 급여 HIRA 2020-01 ASCVD + LDL≥70 | 🟡 (HIRA 고시) | 🟡 | (regulatory) |
| C34 | R2 §7 | siRNA 약가 시나리오 $8-15K/yr · 한국 잠재 부담 ₩5-20T | 🟢 (R2 §8) | 🟢 | V3c MC |
| C35 | R2 §8 | Schoenfeld 1,187 events (HR 0.85) recompute (Python) | 🟢 | 🔵 | V2 atlas |
| C36 | R2 §8 | binary sample size n≈8,717 vs HORIZON 8,323 (4.7% gap) | 🟢 | 🔵 | V2 atlas |
| C37 | R2 §8 | NNT = 1/ARR · ARR 3-4%p → NNT 25-33 | 🟢 (산술) | 🔵 | V2 atlas (산술 등록) |
| C38 | R2 §8 | NHIS 부담 ₩5-15T = 약품비 ₩23T의 17-39% | 🟢 (산술) | 🔵 | V2 atlas (산술 등록) |
| C39 | R3 §1 | MendelianRandomization R 패키지 IVW 함수 존재 | 🟢 (URL) | 🟢 | (도구 inventory) |
| C40 | R3 §3 | clinicaltrials.gov pytrials 0.3.0 (v2 API) | 🟢 (URL) | 🟢 | (도구 inventory) |
| C41 | R3 §5 | GalNAc-siRNA in-silico free tool 부재 (사내 IP) | **🔴** | 🔴 | (closed negative) |
| C42 | R3 §6 | hexa-lang inbox 3 drafts (`lpa-ivw-mr-formula` 등) | 🟡 (draft) | 🟡 | V2 등록 시 🟢 |
| C43 | (신규) | siRNA ODE steady-state M_ss = k_syn / (k_deg + k_RISC·S_ss) | 🟠 (미시뮬) | 🔵 | V2 atlas (closed-form) + V3a |
| C44 | (신규) | IVW estimator 일반화 β = Σ(w·βx·βy/σ²) / Σ(w·βx²/σ²) | 🟠 (미시뮬) | **🔵** | **V2 atlas — PRIMARY** |
| C45 | (신규) | Lp(a) ↓% 합성 (drug · diet · MR) → 1 - Π(1 - x_i) | 🟠 (미시뮬) | 🔵 | V2 atlas |

## tier 분포 (45 claims)

| tier | 현재 | 목표 (V2/V3 후) | Δ |
|---|---|---|---|
| 🔵 SUPPORTED-FORMAL | 1 (C30 sanity) | **8** (C01, C04, C07, C08, C12, C22, C23, C44 + ...) | **+7** |
| 🟢 SUPPORTED-NUMERICAL | 14 | 18 (C10, C13, C15, C16 등 V3a/V3c 후) | +4 |
| 🟡 SUPPORTED-BY-CITATION | 24 | 14 (citation-only 잔여) | -10 |
| 🟠 INSUFFICIENT/DEFERRED | 5 (C27, C43, C44, C45 + Ph3 outcomes) | 4 (Ph3 outcomes만 남음) | -1 |
| 🔴 FALSIFIED | 1 (C41) | 1 (변동 없음) | 0 |

## V2/V3 작업 입력 (우선순위)

### 🔵 PRIMARY (V2 atlas push) — top 4

1. **C22/C23/C44** — IVW estimator + Burgess HR 0.71 (가장 핵심)
2. **C07/C08/C35** — Schoenfeld events formula
3. **C12/C36** — binary sample size formula (Snedecor/Cochran)
4. **C04/C37/C38** — 산술 closed-form (NNT, 인구 곱, 부담 비율)

### 🟢 V3a (siRNA ODE on pool)

- C10/C13/C15/C16 — 4분자 -98%/-94%/-85% 재현 + catalytic 비교
- C27 — lifelong/late 50% 감쇠 sensitivity
- C43 — steady-state closed-form

### 🟢 V3c (NHIS ICER MC on pool)

- C26 — 5y NNT 25-35
- C34 — 약가 시나리오 break-even
- C32 — 한국인 prevalence cross-check

### 🟢 V3b (MR/IVW Monte Carlo CI) — sequential

- C22/C23 95% CI bootstrap (Burgess CI 0.67-0.75 재현)

## verify rubric (V1 자체)

| 항목 | tier | 비고 |
|---|---|---|
| inventory 완성도 | 🟢 | 45 claims · M1-R3 전체 cover |
| tier 분류 정확성 | 🟡 | g5 self-judge — V2/V3 결과로 확정 |
| 목표 tier 달성 가능성 | 🟠 | atlas 등록 성공 여부에 의존 |

🔑 핵심 통찰:
- **C22/C44 (IVW)** = PRIMARY 🔵 target — 성공 시 LPA 첫 closed-form atom 등록 + 7개 추가 🔵 trigger
- **C41 (GalNAc 도구 gap)** = 유일 🔴 — 사내 IP wall (closed negative, 정직한 deferred)
- **C27 (50% 감쇠)** = heuristic→rule 승격 위험 — V3a sensitivity로 정량화 권고
