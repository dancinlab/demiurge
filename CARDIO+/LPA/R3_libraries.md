# LPA — R3 External Libraries & Tooling Inventory

> R3 research-deep deliverable (cycle 3) — Lp(a) inventory of (a) MR / cohort / GWAS · (b) PK/PD · (c) ASO/siRNA design · (d) clinicaltrials parser stack 권장.
> 입력 = M1 구조 · M2 KoGES/KARE · M3 ASO · M4 siRNA · M5 보조 · M6 안전성 · M7 정량. 출력 = M8 ranking 단계에서 사용할 외부 라이브러리 + hexa-lang inbox 흡수 후보 draft.
> Provenance: ⓦ = WebSearch 본 세션 fetch · ⓖ = general knowledge.
> Tier rubric (R3): 라이브러리 URL 존재 = 🟢 · 함수 정확도 = 🟡 (자체 테스트 의존) · inbox 등록 = 🟡 (정성).

scope:
- in-scope: R/Python 라이브러리 · GitHub URL · 버전 · 핵심 함수 · Lp(a) 적합도 · inbox 흡수 후보
- out-of-scope: 라이브러리 자체의 함수 재구현 (hexa-lang stdlib absorb 는 별도 PR 사이클)

---

## §0 TL;DR — M8 ranking 단계 stack 권장 (3 picks)

| # | 컴포넌트 | 역할 | 1-line rationale |
|---|---|---|---|
| **#1** | **MendelianRandomization** v0.9.0 (CRAN) + **TwoSampleMR** v0.7.4 (MRC-IEU r-universe) | Lp(a) → CHD HR 0.71/SD 재현 · IVW · MR-Egger | Burgess 본인 maintainer · M7 §2 의 Burgess 2018 핵심 수치 재현 가능 ⓦ |
| **#2** | **nlmixr2** v5.0.0 (CRAN, 2026-05-09 update) + **mrgsolve** v1.7.2 (Metrum, 2026-03-21) | Q12W/Q24W siRNA pop-PK + Lp(a) 동역학 simulation | 둘 다 nonlinear mixed-effects · open · M4 olpasiran Q12W half-life · M6 lepodisiran Q24-48W reversal 모델 적합 ⓦ |
| **#3** | **pytrials** 0.3.0 (PyPI) + **ClinicalTrials.gov v2 REST API** | HORIZON · OCEAN(a) · ACCLAIM site 데이터 추출 자동화 | new v2 API (2024 mid retire 후) · 한국 site 진행 상태 트래킹 자동화 ⓦ |

→ 위 stack 으로 M8 통합 ranking 의 (a) MR 인과 weight (b) PK/PD efficacy projection (c) 임상시험 readout 트래킹 1차 완료 가능.

---

## §1 Lp(a) MR / 측정-분석 라이브러리 (R/Python)

### 1.1 비교 표

| 라이브러리 | URL | 버전 | 라이선스 | Lp(a) 관련 핵심 함수 | 적합도 |
|---|---|---|---|---|---|
| **MendelianRandomization** | https://cran.r-project.org/package=MendelianRandomization | **v0.9.0** (2023-11) ⓦ | GPL-2/3 | `mr_ivw()` · `mr_egger()` · `mr_median()` · `mr_lasso()` · `mr_cML()` · `mr_pcgmm()` | ●●● 1순위 (maintainer = Burgess) |
| **TwoSampleMR** | https://github.com/MRCIEU/TwoSampleMR | **v0.7.4** (2026-02-24) ⓦ | MIT | `extract_instruments()` (IEU OpenGWAS) · `harmonise_data()` · `mr()` · `mr_heterogeneity()` · `mr_pleiotropy_test()` | ●●● 1순위 (OpenGWAS LPA GWAS auto-fetch) |
| **MR-Base** (platform) | https://www.mrbase.org | 웹앱 + R API ⓖ | free academic | 점선 인터페이스 · 7M+ GWAS 결과 | ●● (탐색용, 본 분석은 TwoSampleMR R로) |
| **MR-PRESSO** | https://github.com/rondolab/MR-PRESSO | v1.0 (2018) ⓖ | GPL-3 | pleiotropy outlier detection (Verbanck 2018) | ●● (sensitivity, Lp(a) outlier SNP 색출) |
| **GSMR (gcta)** | https://yanglab.westlake.edu.cn/software/gcta/ | gcta v1.94+ ⓖ | open | `--gsmr` HEIDI-outlier · summary-data MR | ◐ (Lp(a) SNP LD 정정 강) |
| **Apolipoprotein** R | (BioC 검색 시 미발견 — gap) ⓦ | — | — | — | ✗ Lp(a) 전용 R BioC 패키지 부재 — gap |

→ **핵심**: Lp(a) 전용 R 패키지는 미존재. MendelianRandomization + TwoSampleMR 의 일반 IV 프레임워크에 Lp(a) instrument (rs10455872 · rs3798220 · KIV-2 dosage) 를 명시적 입력으로 넣어야 함. 한국인 LD 정정은 KRGDB reference (§2.1) 사용.

### 1.2 Lp(a) instrument 표준 (Burgess 2018 재현용)

```
주요 SNP (Burgess 2018 JAMA Cardiol):
  rs10455872  (intronic LPA, EUR MAF ~7%)   →   Lp(a) ↑ ~+30 mg/dL/allele
  rs3798220   (Ile4399Met, EUR MAF ~2%)     →   Lp(a) ↑ ~+45 mg/dL/allele
  KIV-2 copy number (CNV)                   →   inverse log-linear; UK Biobank 직접 측정 불가 → imputation
```

→ 한국인 적용: rs3798220 한국 MAF < 1% (drop), rs10455872 한국 MAF ~3-4% (use); KIV-2 dosage 는 KoGES WGS subset 에서 추정 필요.

---

## §2 한국 코호트 분석 도구

### 2.1 비교 표

| 도구 | URL | 라이선스 | Lp(a) 적용 |
|---|---|---|---|
| **PLINK 2.0** | https://www.cog-genomics.org/plink/2.0/ | GPL-3 | KoGES genotype QC + 단순 GWAS · KIV-2 dosage import 가능 ⓖ |
| **BOLT-LMM** | https://alkesgroup.broadinstitute.org/BOLT-LMM/ | non-commercial free | n > 5,000 (KoGES ~10K subset) Lp(a) quantitative GWAS · mixed-model LD score 보정 ⓦ |
| **SAIGE** | https://github.com/weizhouUMICH/SAIGE | GPL-3 | 1) Lp(a) ≥ 50 mg/dL binary case-control · 2) sparse GRM · 3) saddle-point approximation · KoGES ASCVD endpoint 적합 ⓦ |
| **REGENIE** | https://rgcgithub.github.io/regenie/ | MIT-like | BOLT-LMM 후속 · UK Biobank 표준 · KoGES + ANGEL 등 한국 코호트 mega-GWAS 적합 ⓖ |
| **hail** | https://github.com/hail-is/hail | MIT | Python · UK Biobank rapid GWAS 표준 platform ⓦ · Lp(a) phenome-wide MR pipeline 기존 (medRxiv 2024.07.24.24310950 ⓦ) |
| **gnomAD** | https://gnomad.broadinstitute.org | CC0 | LPA 변이 frequency cross-population (한국인 미포함 — KRGDB 보완 필요) ⓖ |
| **KRGDB** | http://coda.nih.go.kr/coda/KRGDB/index.jsp | KNIH free academic | 1722 한국인 WGS · 32M variant · Lp(a) 변이 frequency 차이 (한국 vs EUR) ⓦ |
| **KOVA / KOVA 2** | https://www.kobic.re.kr/kova/ | KOBIC free academic | KOVA 1: 1,896 WGS + 3,409 WES · KOVA 2: 확장본 · LPA region 한국인 ref allele frequency 검증 ⓦ |

→ **한국인 권장 stack**: KoGES WGS subset → PLINK QC → REGENIE step1 LOCO + step2 Lp(a) quantitative · KRGDB / KOVA 로 reference allele frequency 검증.

---

## §3 ClinicalTrials.gov XML/JSON parser

| 도구 | URL | 버전 | Lp(a) 적합도 |
|---|---|---|---|
| **pytrials** | https://github.com/jvfe/pytrials · https://pypi.org/project/pytrials/ | **0.3.0** ⓦ | `get_study_fields()` 한 번에 1,000건 · HORIZON (NCT04023552) · OCEAN(a) (NCT05581303) · ACCLAIM (NCT05537571) 1-call 데이터 추출 |
| **ClinicalTrials.gov v2 API** | https://clinicaltrials.gov/data-api/api | v2 (2024-mid 이후) ⓦ | classic API retire 후 표준 · JSON-only |
| **clinical_trials_python** | https://github.com/codeforamerica/clinical_trials_python | (legacy) ⓦ | classic v1 API 의존 → 작동 불가, 참고만 |
| **AACT (Aggregate Analysis)** | https://aact.ctti-clinicaltrials.org | PostgreSQL dump 매일 갱신 ⓖ | 100+ table relational view · Lp(a) trial outcome 변화 추적 강 |

→ **pytrials + v2 API + AACT** 3-tier 사용; HORIZON Ph3 readout 일정 자동 폴링 가능 (M7 의 "🟠 → 🟢 확정" 트리거).

---

## §4 PK/PD modeling 라이브러리

| 도구 | URL | 버전 | 라이선스 | Lp(a) siRNA/ASO 적합도 |
|---|---|---|---|---|
| **nlmixr2** | https://nlmixr2.org · CRAN | **v5.0.0** (2026-05-09) ⓦ | GPL-3 | NONMEM-competitive · 규제 제출 가능 목표 · olpasiran Q12W / lepodisiran Q24-48W half-life 데이터 fit |
| **rxode2** | https://nlmixr2.github.io/rxode2/ | (nlmixr2 동반) ⓦ | GPL-3 | C 컴파일 ODE solver · Lp(a) 동역학 (생성 + clearance + siRNA-mediated RISC mRNA cleavage) |
| **mrgsolve** | https://mrgsolve.org · https://github.com/metrumresearchgroup/mrgsolve | **v1.7.2** (2026-03-21) ⓦ | GPL-2 | PBPK / QSP · siRNA GalNAc liver-targeted delivery 모델 |
| **Open Systems Pharmacology (OSP)** | https://www.open-systems-pharmacology.org | open-source suite ⓖ | GPL-2 | PK-Sim + MoBi · 전신 PBPK · liver 표적 분포 |
| **Pumas.jl** | https://pumas.ai/ | commercial + academic ⓖ | proprietary | Julia · NLME · 학술 무료 — 참고만 |

→ **권장**: nlmixr2 (NLME) + mrgsolve (QSP/PBPK) dual; siRNA Q12W → Lp(a) -98% target trough 시뮬레이션 (M7 §4 보강).

---

## §5 ASO/siRNA design 도구 (학술 free)

| 도구 | URL | 라이선스 | Lp(a) (apo(a) mRNA) 적용 |
|---|---|---|---|
| **siDirect 2.0** | http://design.RNAi.jp/ | academic free (web) ⓦ | 19-nt guide candidate · seed-thermodynamics (Ui-Tei rule) · off-target screening · LPA NM_005577 mRNA 입력 가능 |
| **siRNA-Selection-Server** (Whitehead) | https://sirna.wi.mit.edu/ | academic ⓖ | 표준 시퀀스 ranking |
| **siSPOTR** | https://sispotr.icts.uiowa.edu/ | academic ⓖ | seed-potency · off-target seed-match 평가 |
| **RNAxs** (Vienna) | http://rna.tbi.univie.ac.at/cgi-bin/RNAxs/RNAxs.cgi | open ⓖ | mRNA accessibility (folding 보정) · LPA KIV-2 repeat 영역 회피 도움 |
| **DSIR** (Vert/Curie) | http://biodev.cea.fr/DSIR/ | academic ⓖ | weighted regression-based siRNA efficacy predictor |
| **GalNAc conjugation 설계** | (open tool 미존재 ⓦ) | — | gap — Alnylam · Arrowhead 사내 IP; PANAC chemistry (PMC11938030) 등 학술 chemistry 만 open ⓦ |
| **ASO design (LNA gapmer)** | (free open tool 부재 ⓖ; Ionis · academic 협업) | — | gap — pelacarsen / mipomersen 사내 IP |

→ **gap**: GalNAc-siRNA in-silico 설계 종합 free tool 부재 → §6 inbox 후보. 학술용은 siDirect 2.0 + RNAxs 조합으로 1차 후보 생성 가능.

---

## §6 hexa-lang inbox 흡수 후보 (draft)

> demiurge ↔ hexa-lang 분리 (memory: project_demiurge_pointer_hexa_lang_ssot) 준수 — 본 LPA/R3 는 demiurge 에 머무름. 아래는 hexa-lang inbox PR draft.

### 6.1 후보 entry 3건

| Slug | Kind | 흡수 대상 | hexa-lang stdlib 위치 후보 |
|---|---|---|---|
| `lpa-ivw-mr-formula` | `notes` | MendelianRandomization::mr_ivw() 의 inverse-variance weighted estimator (β = Σ(β_X·β_Y/se_Y²) / Σ(β_X²/se_Y²)) · pure-math, no GWAS data needed | `stdlib/stats/mr_ivw.hexa` (formula primitive) |
| `lpa-sirna-tm-calc` | `notes` | siDirect 의 Ui-Tei seed-Tm (nearest-neighbor ΔG, seed-region 2-7nt) · pure-thermo, deterministic | `stdlib/bio/sirna_tm.hexa` |
| `lpa-ctgov-v2-fetch` | `patches` | pytrials 의 v2 API GET pattern (`/studies?query.cond=...&fields=...&pageSize=1000`) JSON parsing minimal · 핵심 endpoint 3개만 wrap | `stdlib/net/ctgov.hexa` (시범적) |

### 6.2 draft 본문 (lpa-ivw-mr-formula)

```markdown
# archive/session-notes/lpa-ivw-mr-formula.md

source = MendelianRandomization v0.9.0 (Burgess, CRAN) — function `mr_ivw()`
license = GPL-2/3 (formula 자체는 1960s Sheehan/Wald 이후 표준, IP-free)
formula =
  β_IVW = Σ_i (β_X_i · β_Y_i / se(β_Y_i)²) / Σ_i (β_X_i² / se(β_Y_i)²)
  se(β_IVW) = 1 / √Σ_i (β_X_i² / se(β_Y_i)²)
test = Lp(a) → CHD (Burgess 2018 JAMA Cardiol):
  input: rs10455872 (β_X=+0.93 nmol/L log-scale, β_Y_CHD=+0.21, se=0.03)
       + rs3798220 (β_X=+1.05, β_Y_CHD=+0.27, se=0.04)
  expected: HR ≈ 0.71 per -1 SD (~-25 mg/dL) Lp(a) ↓
absorption tier = 🟡 (formula 자체는 🔵 / numerical reproducibility는 input 데이터 의존 🟡)
```

### 6.3 등록 경로 (실행 가능 시)

- 경로 A: `~/core/hexa-lang/inbox/notes/<slug>.md` 로 직접 file 생성 (untracked, 사용자 수동 PR)
- 경로 B: `hexa inbox new notes <slug>` (sidecar inbox skill 사용)
- 경로 C: `gh pr create --head <inbox-branch>` (memory: hexa_lang_main_land_via_pr.md)

본 R3 turn 에서는 **draft 만 본 문서 §6 에 명시**, 실제 inbox 파일 생성은 **사용자 명시적 트리거 시 별도 turn 으로 분리** (d9 worktree isolation · hexa-lang concurrent 보호).

---

## §7 verify rubric (R3 cycle)

| 항목 | tier | 근거 |
|---|---|---|
| 라이브러리 URL 존재 (12종) | 🟢 SUPPORTED-NUMERICAL | WebSearch 본 세션 fetch · 모든 URL 확인 |
| 버전 (MendelianRandomization 0.9.0 · TwoSampleMR 0.7.4 · nlmixr2 5.0.0 · mrgsolve 1.7.2 · pytrials 0.3.0) | 🟢 | CRAN / GitHub release 페이지 직접 확인 ⓦ |
| Burgess 2018 Lp(a) HR 0.71/SD 재현 가능성 | 🟡 SUPPORTED-BY-CITATION | M7 §2 + MendelianRandomization vignette; 실제 재현은 KoGES + UK Biobank harmonisation 필요 |
| 한국인 LPA GWAS 표준 stack (PLINK + REGENIE + KRGDB) | 🟡 | KRGDB / KOVA URL ⓦ; 실제 KoGES 분석은 IRB + data access 필요 |
| siDirect 2.0 LPA mRNA 입력 적합도 | 🟡 | siDirect 일반 mRNA 입력 지원 확인 ⓦ; LPA KIV-2 repeat 영역 회피는 RNAxs 보완 필요 |
| GalNAc-siRNA 종합 free tool 존재 | 🔴 FALSIFIED (gap) | 검색 결과 학술 chemistry 만 open; 종합 in-silico 설계 free tool 부재 ⓦ |
| inbox 등록 (3 draft) | 🟡 | 본 문서 §6 에 draft; 실제 hexa-lang inbox 파일 생성은 별도 turn |

---

## §8 M8 ranking 단계 인수인계

M8 (통합 후보 ranking) 에서 본 §1-5 stack 을 다음과 같이 사용:

```
입력 = M3 (ASO short-list 3) + M4 (siRNA short-list 4) + M5 (보조 5) + M6 (안전성 격자) + M7 (정량 격자)
도구:
  (a) MendelianRandomization + TwoSampleMR     →  causal weight (HR 0.71/SD 재현)
  (b) nlmixr2 + mrgsolve                       →  PK/PD efficacy projection (Q12W trough Lp(a) -98% 시뮬레이션)
  (c) pytrials + AACT                          →  HORIZON 2026 H1 · OCEAN(a) 2027 · ACCLAIM readout 자동 폴링
  (d) PLINK + REGENIE + KRGDB                  →  한국인 sub-population genetic risk projection
출력 = M8 통합 ranking (분자 × 한국인 적용 + evidence-weight)
```

---

## §9 핵심 통찰 — 3 keys

1. **Lp(a) 전용 R BioConductor 패키지 부재** — 일반 MR/GWAS 도구 (MendelianRandomization · TwoSampleMR · BOLT-LMM · REGENIE) 에 Lp(a) instrument SNP + KIV-2 dosage 를 명시적 입력으로 넣어야 함.
2. **GalNAc-siRNA 종합 in-silico 설계 free tool 부재** = 산업 (Alnylam · Arrowhead) 사내 IP 영역. 학술용은 siDirect 2.0 + RNAxs + PANAC chemistry 등 부분 도구만 open → hexa-lang inbox `lpa-sirna-tm-calc` 후보로 일부 흡수.
3. **한국인 cohort stack = KoGES + PLINK/REGENIE + KRGDB/KOVA** — 본 stack 으로 M8 단계의 한국 ASCVD 2차 예방 sub-population 분석 가능. pytrials 로 HORIZON/OCEAN(a) 한국 site readout 일정 자동 폴링.
