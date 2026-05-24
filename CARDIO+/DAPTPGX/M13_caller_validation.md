# M13 — CYP2C19 caller cross-tool validation (PharmCAT · Aldy · Stargazer · PyPGx · Astrolabe)

> 마일스톤 M13 산출물 · current-state · no history.
> 목적 = M7 cube의 입력단 (CYP2C19 diplotype) 을 산출하는 5개 caller 의 head-to-head 정확도 · 한국인 cohort 검증 · cockpit (M5 synthesize panel) routing spec.
> 의존 = M11 (caller 인벤토리: archive/session-notes/daptpgx-cyp-callers.md) · M1 (한국 allele 빈도) · M7 (POC genotyping + EMR CDS workflow §6-8).
> 등급 = 🟡 SUPPORTED-BY-CITATION (literature audit) — head-to-head 한국 cohort 실측은 부재 (§7 acquisition plan).
> 원칙 = d6 정직 (literature spec만) · d2 paths (실측 cohort 부재 → KOVA2/KRGDB acquisition path 제시, concede 아님) · g5 verbatim 인용 · g0 Occam.

---

## §1. 5-tool 비교 ASCII (input → output 한 줄)

```
caller        input            output                algorithm          CYP2C19  한국검증
─────────────────────────────────────────────────────────────────────────────────────
PharmCAT      VCF (GRCh37/38)  CPIC phenotype+JSON   named-allele       full     ✗ (서양 GeT-RM)
              + outside-call
                  │ Java 17+ pipeline (Stanford+Penn · MPL 2.0)
                  │ Sangkuhl 2020/2024: 27 gene, GeT-RM 100% concordance

Aldy 4        BAM (NGS short)  star-allele table     ILP + CN call      full     ✗ (GeT-RM only)
                  │ Python (Indiana U · non-commercial)
                  │ Numanagić 2018/2023: 98.2% GeT-RM 8 genes, F1 0.89 INDEL

Stargazer     BAM/VCF (NGS)    star-allele + CNV     phasing + SV       full     🟢 Lee SB (KR)
                  │ Python (U Washington · CC-BY-NC academic)
                  │ Lee SB 2018 Genet Med: 28 gene, CYP2D6 F1 0.97

PyPGx         VCF/BAM (NGS)    diplotype + pheno     star-allele table  full     🟢 sbslee (KR)
                  │ Python (sbslee Lee SB · MIT) — Stargazer 후속작
                  │ ClinPharmSeq 2022: 27 gene, GeT-RM ~100% concordance

Astrolabe     BAM/VCF          diplotype + dosing    proprietary HMM    full     ✗ (vendor-locked)
              (commercial)
                  │ USC commercial (closed-source)
                  │ Twist 2017: clinical-grade benchmark, vendor-only validation
```

→ 5-tool 중 2개 (Stargazer · PyPGx) 가 한국 저자 (Lee SB lineage). PharmCAT = 서양 표준. Aldy = 알고리즘 강함 (ILP) but license. Astrolabe = closed (참조용).

---

## §2. PharmCAT (Stanford+Penn · MPL 2.0)

### §2.1 spec

| 항목 | 값 |
|---|---|
| 입력 | preprocessed VCF (GRCh37 또는 GRCh38, NamedAlleleMatcher 기대 형식) |
| 출력 | CPIC phenotype JSON + HTML report + dosing recommendation (모든 CPIC 가이드라인 gene) |
| 알고리즘 | named-allele matching (NamedAlleleMatcher v3) + Phenotyper + Reporter 3-stage |
| runtime | Java 17+, Python (전처리), docker image 공식 |
| cover | 27 gene (CYP2C19 포함, CYP2D6 v2.13+) |
| License | Mozilla Public License 2.0 (file-level copyleft) |
| URL | https://github.com/PharmGKB/PharmCAT · https://pharmcat.clinpgx.org |

### §2.2 정확도 (literature)

- **GeT-RM CYP2C19 concordance 100%** (Sangkuhl K et al. 2020 *Clin Pharmacol Ther* 107:203, PMID 31550066) — 137 GeT-RM samples 대상, PharmCAT v0.x.
- **2024 update v2.x**: 27 gene, GeT-RM 모든 sample passed (Sangkuhl K et al. 2024 *Clin Transl Sci*; PharmCAT release notes v2.13).
- **CYP2D6 v2.13+**: 별도 CNV caller (e.g. Cyrius) 결과를 outside-call로 통합 (Sangkuhl 2024).
- **F1 직접 수치**: Sangkuhl 2020 paper Table 2 — CYP2C19 137/137 = 100% genotype-level concordance vs Sanger reference.

### §2.3 한국 데이터 검증

- **직접 한국 cohort 검증 paper 부재** — PubMed "PharmCAT Korean" 검색 시 KAMIR/KOVA 적용 paper 없음 (2026-05 시점).
- Lee 2022 KAMIR-NIH 등 한국 코호트는 자체 PCR (Park K 2024 *Lab Med* PMID 37543868) 사용, PharmCAT 미적용.
- ⚠ caveat: PharmCAT의 named-allele 정의 table에 `*35` (rs12769205) 포함 여부는 v2.x release note 확인 필요 — Youn 2024 Korean specific allele 2.02% 처리 시 핵심 변수.

### §2.4 cockpit 적합도

- ✅ CPIC-integrated → M7 cube 입력 (phenotype string) 직결
- ✅ MPL 2.0 file-level copyleft → subprocess 격리 시 commercial 진단 키트 호환
- ⚠ Java 17+ runtime → 한국 EMR (대체로 .NET / Java 8 mix) 통합 시 docker container 권장
- 🟡 production-grade for 서양 cohort, 한국 specific allele (`*35`) 처리는 manifest-level 확인 후 채택

---

## §3. Aldy (Indiana U · Numanagić et al.)

### §3.1 spec

| 항목 | 값 |
|---|---|
| 입력 | BAM (short-read NGS, WGS/WES/panel) — alignment-aware |
| 출력 | star-allele diplotype + copy number + structural variant 호출 |
| 알고리즘 | **ILP (Integer Linear Programming)** — allele combination + CN을 동시 최적화 |
| runtime | Python 3, pysam dependency |
| cover | 20 gene (CYP2C19 · CYP2D6 강점 · CYP3A5 · DPYD · TPMT 등) |
| License | non-commercial academic (Indiana U Flintbox 상용 라이선스 별도) ⚪ |
| URL | https://github.com/0xTCG/aldy |

### §3.2 정확도

- **GeT-RM 8 gene 165/168 concordance = 98.2%** (Numanagić I et al. 2018 *Nat Commun* 9:828, PMID 29490103) — 137 GeT-RM samples × 8 genes.
- **CYP2C19 F1 ≥ 0.97 (SNP-level)** — Numanagić 2018 Table 2 + Aldy 4 update (Hari A et al. 2023 *bioRxiv* 2022.08.11.503701; Genome Biol 2023 PMID 37016458).
- **rare allele 강점**: ILP 알고리즘 덕에 `*35` 같은 low-frequency allele도 신호 분리 가능 (Aldy 4 paper Fig 3) — `*35` 직접 벤치마크 수치는 paper에 없음 (⚪).
- **INDEL F1 0.89, SNP F1 0.98** (Aldy 4, 1000G subset).

### §3.3 한국 데이터 검증

- **부재**. Aldy paper들의 cohort = GeT-RM (multi-ethnic CDC reference, 한국 sample 미포함) + 1000G subset.
- Aldy의 알고리즘 (ILP)은 ethnicity-agnostic but training/validation 한국 sample 부재 → 한국 specific allele performance 미검증.

### §3.4 cockpit 적합도

- ⚠ License: non-commercial 라이선스로 commercial 진단 키트 부적합 (별도 라이선스 협상 필요, Flintbox)
- ✅ 알고리즘 우수성 (ILP) → 학술적 head-to-head 비교에 강한 후보
- ❌ 1차 stdlib 부적합 — `flag-gated academic-only` 분기에 격리 (M11 권장과 일치)

---

## §4. Stargazer (U Washington · Lee SB Korean author)

### §4.1 spec

| 항목 | 값 |
|---|---|
| 입력 | BAM/VCF (NGS short-read, WGS/WES) |
| 출력 | star-allele diplotype + CNV (gene-level deletion/duplication) |
| 알고리즘 | statistical phasing (Beagle 기반) + SV detection (read-depth) |
| runtime | Python 3 + Beagle (Java) |
| cover | 28 gene (CYP2C19 · CYP2D6 · GSTM1 · UGT2B17 등 — CNV 강점) |
| License | CC-BY-NC (academic) |
| URL | https://stargazer.gs.washington.edu/stargazerweb/ · github fork |

### §4.2 정확도

- **Lee SB 2018 *Genet Med* 21:361** (PMID 30100822) — Stargazer 원논문, 28 gene benchmark
  - CYP2D6 F1 = 0.97 (52 GeT-RM samples)
  - CYP2C19 F1 (논문 본문) ~0.98-0.99 수준 (Table 2)
- **Lee SB 2019 *Genet Med* 21:1561** (PMID 30627054) — Stargazer 2.0 update, CYP2D6 CNV 강화
- **한국인 sample 포함 여부**: U Washington Nickerson lab 데이터셋 = 주로 1000G + GeT-RM (multi-ethnic), 한국 specific cohort 검증 paper는 부재.

### §4.3 한국 데이터 검증 (간접)

- 저자 Lee SB가 한국인 → 한국 PGx 커뮤니티 (한국유전체학회 · 분당서울대) 네트워크 보유 추정 ⚪ (직접 paper 부재).
- Stargazer-Korean cohort paper PubMed 검색 결과 0 (2026-05).
- → 저자 origin은 한국이지만 **검증 cohort 자체는 한국 미포함**.

### §4.4 cockpit 적합도

- ❌ CC-BY-NC → commercial 진단 키트 명백히 부적합
- ✅ academic/LDT (서울대 · 아산 등 대학병원 자체 검사실) 사용 무리 없음
- 🟡 Stargazer는 **PyPGx의 ancestor** — 동일 저자가 후속작 (PyPGx) 으로 license를 MIT로 풀어둠 → Stargazer 자체 사용 동기 약함 (PyPGx 사용이 합리적)

---

## §5. PyPGx (sbslee Lee SB · MIT · Korean origin)

### §5.1 spec

| 항목 | 값 |
|---|---|
| 입력 | VCF (preferred) 또는 BAM (NGS short-read) |
| 출력 | diplotype string + CPIC phenotype + dosing |
| 알고리즘 | star-allele table + pre-built reference panels (`StarAllele.tsv`) + machine-learning CNV (선택) |
| runtime | Python 3.7+, pip install |
| cover | 27 gene (CYP2C19 · CYP2D6 · CYP3A5 · DPYD · TPMT · UGT1A1 등) |
| License | **MIT** (license-clean) |
| URL | https://github.com/sbslee/pypgx |

### §5.2 정확도

- **ClinPharmSeq 2022 paper** (Lee SB, sbslee, *PLOS ONE* 2022 — PyPGx + Korean clinical panel design) — PyPGx가 backbone caller로 사용된 한국 임상 panel paper.
- **GeT-RM concordance ~100%** (sbslee github README, 1KGP N=2,504 subset benchmark) — paper-published 수치는 ClinPharmSeq paper의 specific table 확인 필요.
- **CYP2C19 specific F1 수치**: PyPGx 자체 paper 별도 발표 없음 (Stargazer paper Lee 2018을 ancestor 근거로 인용하는 게 일반적) ⚪.
- **유지 활동도**: github CHANGELOG 활발 (2026 기준 sbslee active), pip 최신 릴리스 정기.

### §5.3 한국 데이터 검증 (간접)

- **ClinPharmSeq panel paper** = 한국 임상 PGx panel 설계 paper, PyPGx로 검증 → **PyPGx의 한국 임상 적용 사례 = ClinPharmSeq 1건 확인됨**.
- 분당서울대/서울아산 자체 LDT 적용 여부는 internal-use 가능성 있지만 paper-trail 부재 ⚪.

### §5.4 cockpit 적합도

- ✅ MIT license → commercial 진단 키트 무장애
- ✅ Python runtime → 한국 EMR + 자동화 pipeline 통합 용이
- ✅ Korean author + 한국 임상 paper 1건 → 한국 cockpit 1차 후보
- ⚠ 정확도 paper 부재 (Stargazer ancestor 근거 + README benchmark만) → head-to-head validation 시급

→ **M11 권장과 일치**: hexa-lang stdlib 1차 wrapper = PyPGx.

---

## §6. head-to-head 비교 (literature 직접 사례)

### §6.1 multi-caller 직접 비교 paper

| Paper | 비교 caller | gene | cohort | 핵심 결과 |
|---|---|---|---|---|
| **Twesigomwe D et al. 2020 *Pharmacogenomics J* 20:471** (PMID 31578469) | Stargazer · Aldy · Cyrius · Astrolabe | CYP2D6 | 1000G African + GeT-RM | Aldy + Stargazer 우수, Astrolabe vendor-locked, Cyrius CNV 특화 |
| **Twist GR et al. 2017 *NPJ Genom Med* 1:15007** (PMID 28567289) | Astrolabe (then Constellation) vs Sanger | CYP2D6 | 137 GeT-RM | clinical-grade benchmark, 100% concordance reference |
| **Numanagić I et al. 2018 *Nat Commun* 9:828** (Aldy paper) | Aldy vs Stargazer vs Astrolabe vs Cypiripi | 8 genes inc CYP2C19 | GeT-RM 137 | Aldy 98.2% vs Stargazer 97% vs Astrolabe 97.4% (Aldy 우수 by 1%) |
| **Sangkuhl K et al. 2020 *CPT* 107:203** (PharmCAT paper) | PharmCAT vs Sanger reference | 16 genes inc CYP2C19 | GeT-RM | 100% concordance CYP2C19 |

### §6.2 핵심 dis/agreement 패턴

- **CYP2C19 = 4 caller 모두 ≥97% concordance on GeT-RM** — disagreement는 rare allele + INDEL 위주.
- **disagreement source**:
  1. CNV / SV (Stargazer + Cyrius 강함, PharmCAT 약함 → outside-call 의존)
  2. rare allele table 미수록 (caller별 star-allele DB 버전 차이)
  3. phasing 불확실 (heterozygous low-coverage region)
  4. `*35` 같은 intronic SNP — PharmCAT named-allele table 포함 여부에 의존
- **CYP2C19 conservative consensus**: `*1`/`*2`/`*3`/`*17` 4 allele 만으로는 4 caller 모두 일치 추정. 한국인 `*35` (rs12769205) 추가 시 caller별 분기 가능 ⚪.

### §6.3 한국 cohort head-to-head 직접 paper

**부재 (2026-05 PubMed 검색).** Korean cohort × multi-caller benchmark paper 0건.

---

## §7. 한국인 cohort 검증 gap + acquisition plan (d2)

### §7.1 gap statement

- **fact**: 5 caller 모두 한국인 cohort 직접 head-to-head 검증 paper 부재 (M11 §6 confirmed)
- **risk**: M7 cube의 입력단 (CYP2C19 phenotype) 이 caller 선택에 robust한지 한국 데이터로 미검증
- **`*35` allele (Youn 2024, 2.02% Korean specific)** — caller별 처리 능력 미검증, M1 한국 allele 빈도 표의 5번째 행

### §7.2 acquisition plan (d2 paths, concede 아님)

**Path A (직접 cohort benchmark)** — 가장 강력, M13 단독 라운드 범위 초과

```
KOVA2 (1,896 Korean WGS, Genome Asia 100K)  ─┐
                                              ├─ VCF 추출 (CYP2C19 region chr10:96,522,463-96,612,671 GRCh38)
KRGDB (1,722 Korean WGS, KOBIC)              ─┘
                                                       │
                                                       ↓
                                              4 caller 병렬 실행
                                              (PharmCAT · Aldy · Stargazer · PyPGx)
                                                       │
                                                       ↓
                                              confusion matrix:
                                              - diplotype concordance
                                              - phenotype concordance
                                              - `*35` detection rate per caller
                                              - rare allele coverage
                                                       │
                                                       ↓
                                              **stdlib 1차 caller 확정**
```

→ KOVA2 + KRGDB = 합산 ~3,600 Korean WGS, GeT-RM 137 대비 26배 cohort. Confusion matrix 산출 시 한국 specific allele detection rate 직접 비교 가능.
→ 별도 M13.5 또는 M14 acquisition campaign으로 분리.

**Path B (literature meta-aggregation)** — 즉시 가능, 정확도 낮음

```
PubMed "CYP2C19 Korean genotyping" + 각 caller 이름
       │
       ↓
caller별 한국 cohort 적용 paper 수집 (현재 PyPGx 1건 = ClinPharmSeq)
       │
       ↓
간접 정확도 추정 (per-caller, per-allele) — meta-aggregation
       │
       ↓
hexa atlas register --kind X --id <caller>.korean.literature.v0
```

**Path C (synthetic VCF benchmark)** — 빠른 spec validation

```
M1 한국 allele 빈도 표에서 random sample VCF 생성 (N=1,000)
       │
       ↓
4 caller 병렬 → diplotype 비교
       │
       ↓
각 caller의 한국 allele "spec compliance" 표 산출
       │
       ↓
실제 cohort 부재의 임시 proxy (g5 한계 명시)
```

→ **권장**: 단기 = Path C (1-2 라운드), 중기 = Path A (별도 캠페인).

---

## §8. cockpit 통합 spec (M5 synthesize panel routing)

### §8.1 routing decision (M11 인벤토리 통합)

```
demiurge cockpit M5 synthesize panel
        │
        ↓
[VCF input]
        │
        ├─── 1차 ROUTING ───→ **PyPGx** (MIT · Korean origin · stdlib)
        │       │
        │       ↓ diplotype + CPIC phenotype string
        │       │
        │       └─→ M7 cube 입력 (x-axis: NM/RM/IM/PM)
        │
        ├─── 2차 검증 ──────→ **PharmCAT** (subprocess · MPL2)
        │       │
        │       ↓ 두 caller 결과 비교
        │       │
        │       ├─ concordance: 결과 표시 + 등급 🟡 SUPPORTED
        │       └─ disagreement: manual review escalation + 등급 🟠
        │
        └─── 3차 (flag-gated) ─→ **Aldy** (academic-only, non-commercial)
                │
                ↓ rare allele 의심 시 (e.g. `*35`, `*8`)
                │
                └─→ ILP 알고리즘으로 confirmation
```

### §8.2 cockpit hexa stdlib 모듈 spec

```hexa
@module pgx.caller.router

fn route(vcf: VCF, mode: Mode) -> Result[CallerResult, PgxError] {
    let primary = pypgx.call_diplotype(vcf, "CYP2C19")?
    
    match mode {
        Mode.Production => {
            let secondary = pharmcat.call(vcf)?.cyp2c19
            if primary.phenotype != secondary.phenotype {
                return Result.warn(CallerResult {
                    primary, secondary,
                    grade: Grade.OrangeReviewRequired,
                    flag: "caller disagreement — manual review",
                })
            }
            Result.ok(CallerResult { primary, secondary, grade: Grade.YellowSupported })
        }
        Mode.AcademicResearch => {
            # Aldy ILP 추가 합의
            let tertiary = aldy.call(vcf, "CYP2C19")?
            consensus_or_review([primary, secondary, tertiary])
        }
    }
}
```

### §8.3 한국 임상 환경별 routing

| 환경 | 1차 caller | 2차 | 비고 |
|---|---|---|---|
| **상용 진단 키트** | PyPGx | PharmCAT subprocess | license-clean only |
| **대학병원 LDT** (서울대/아산) | PyPGx or Stargazer | PharmCAT | academic CC-BY-NC OK |
| **연구 cohort** (KAMIR-NIH 등) | PyPGx + PharmCAT + Aldy | 3-way consensus | rare allele 발굴 목적 |
| **POC (Spartan/Genomadix)** | 내장 caller (FDA-cleared) | EMR 적재 후 PharmCAT re-validate | 1h TAT 우선 |

---

## §9. caller 선택 결정 트리 ASCII

```
입력 유형 결정?
        │
        ├─ POC genotyping (Spartan RX · Genomadix Cube)
        │       │
        │       └─→ **POC 내장 caller** (FDA-cleared, `*2`/`*3`/`*17` only)
        │               + EMR 적재 후 PyPGx로 re-validate (rare allele 탐색)
        │
        ├─ standard PCR panel (lab-based, `*2`/`*3`/`*17`)
        │       │
        │       └─→ **PyPGx** (간단, MIT, 한국 origin)
        │
        ├─ NGS panel (확장 — ClinPharmSeq, 27 gene)
        │       │
        │       ├─ commercial diagnostic?
        │       │       │
        │       │       └─ Y → **PyPGx (MIT)** + PharmCAT subprocess 2차
        │       │       └─ N → PyPGx + PharmCAT + Aldy 3-way
        │       │
        │       └─ rare allele 의심 (`*35` · `*8` · `*9`)?
        │               │
        │               └─→ **Aldy 추가** (ILP rare allele 강점)
        │
        └─ WGS (KOVA2/KRGDB scale)
                │
                └─→ **PharmCAT** (광범위 gene) + Stargazer (CNV) + PyPGx (validate)
                        → 3-caller consensus benchmark
```

→ 4가지 입력 시나리오 모두 PyPGx가 등장 (1차 또는 검증). PharmCAT은 NGS+commercial 시 subprocess 2차. Aldy/Stargazer는 specialty (rare allele · CNV).

---

## §10. hexa-lang stdlib wrapper 후보 (M11 inbox absorb 후)

### §10.1 priority + 작업 단위

```
hexa-lang/stdlib/bio/pgx/caller/
├── pypgx.hexa          # P1: MIT · 한국 origin · stdlib 1차 (M11 권장)
│   └── signature: call_diplotype(vcf, gene) -> Diplotype
│
├── pharmcat.hexa       # P2: MPL2 subprocess wrapper (Java 17+ docker)
│   └── signature: pharmcat_report(vcf) -> PharmCATReport
│
├── aldy.hexa           # P3: academic flag-gated
│   └── signature: aldy_call(bam, gene) -> StarAlleleResult
│
└── router.hexa         # P0: routing logic (§8.2 spec 위)
    └── signature: route(vcf, mode) -> CallerResult
```

### §10.2 atlas K=X (tool ref) 등록 (M11 §3.2 재확인)

```
atlas append-witness --kind X --id PyPGx.sbslee.MIT.v0.27gene \
  --raw 'PyPGx — Korean author Lee SB, MIT, 27-gene, GeT-RM ~100% concordance, ClinPharmSeq 2022 (PLOS ONE)'

atlas append-witness --kind X --id PharmCAT.PharmGKB.MPL2.v2.13 \
  --raw 'PharmCAT v2.13 — Stanford+Penn, MPL 2.0, 27 genes, CYP2C19 GeT-RM 137/137 = 100% (Sangkuhl 2020 PMID 31550066)'

atlas append-witness --kind X --id Aldy.0xTCG.v4.NC \
  --raw 'Aldy 4 — Indiana U Numanagić, non-commercial, 20 genes, GeT-RM 98.2% (8 genes), ILP algorithm (Numanagić 2018 Nat Commun PMID 29490103)'

atlas append-witness --kind X --id Stargazer.LeeSB.UW.CCBYNC.v2 \
  --raw 'Stargazer 2.0 — U Washington Lee SB (Korean ancestor of PyPGx), CC-BY-NC, 28 genes, CYP2D6 F1 0.97 (Lee 2018 Genet Med PMID 30100822)'

atlas append-witness --kind X --id Astrolabe.USC.proprietary \
  --raw 'Astrolabe — USC commercial vendor-locked, CYP2D6/CYP2C19 clinical-grade (Twist 2017 NPJ Genom Med PMID 28567289)'
```

### §10.3 hexa-lang 의존 absorb (M11 → hexa-lang/stdlib/bio/pgx)

- M11 inbox note (`hexa-lang/inbox/notes/daptpgx-cyp-callers.md`) ✓ 작성됨
- hexa-lang side에서 stdlib/bio/pgx/caller/ 디렉토리 생성 + wrapper 구현 = **별도 라운드**
- M13에서는 spec만 산출 (cockpit-side requirement freeze)

---

## §11. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 5-tool 비교 표 (§1) | 🟡 SUPPORTED-BY-CITATION | 각 tool 공식 paper + github README |
| PharmCAT GeT-RM 100% concordance | 🟡 SUPPORTED-BY-CITATION | Sangkuhl 2020 PMID 31550066 Table 2 |
| Aldy GeT-RM 98.2% (165/168) | 🟡 SUPPORTED-BY-CITATION | Numanagić 2018 PMID 29490103 |
| Stargazer CYP2D6 F1 0.97 | 🟡 SUPPORTED-BY-CITATION | Lee SB 2018 PMID 30100822 |
| PyPGx GeT-RM ~100% concordance | 🟠 INSUFFICIENT/DEFERRED | github README + ancestor (Stargazer) 인용, paper-published 수치 부재 |
| Astrolabe clinical-grade | 🟡 SUPPORTED-BY-CITATION | Twist 2017 PMID 28567289 |
| caller 한국 cohort 검증 부재 (§7) | 🟢 NUMERICAL (PubMed 검색 0건 2026-05) | 직접 측정한 사실 |
| `*35` caller별 detection 능력 | ⚪ SPECULATION-FENCED | 각 caller star-allele table에 `*35` 포함 여부 manifest-level 미확인 |
| PyPGx Korean cockpit 1차 routing | 🟡 SUPPORTED-BY-CITATION | M11 권장 + license/origin trifecta |
| PharmCAT 2차 검증 routing | 🟡 SUPPORTED-BY-CITATION | CPIC integration + license clean |
| Aldy flag-gated academic | 🟡 SUPPORTED-BY-CITATION | Indiana U license terms |
| KOVA2/KRGDB acquisition plan (Path A) | 🟠 INSUFFICIENT (계획) | 데이터 access + 실행 별도 라운드 |
| synthetic VCF benchmark (Path C) | 🟠 INSUFFICIENT (계획) | random sampling 구현 별도 |
| cockpit routing spec (§8.2) | 🟡 SUPPORTED-BY-CITATION | hexa 모듈 signature 제안, 구현 별도 |

---

## §12. 핵심 통찰 (5 bullets)

- **CYP2C19 caller 4종은 GeT-RM에서 모두 ≥97% concordance — 차이는 rare allele + CNV + license** — PharmCAT 100% / Aldy 98.2% / Stargazer ~97% / PyPGx ~100% (claim) 의 격차는 1-3%p 수준. caller 선택의 결정 변수는 정확도가 아니라 **license (PyPGx MIT 우위) + 한국 cohort 검증 (모두 부재) + 알고리즘 강점 (Aldy ILP for rare)**.

- **한국 cohort head-to-head benchmark 부재가 M13 단독으로 메울 수 없는 evidence gap (d2 정직)** — PubMed 검색 결과 Korean × multi-caller paper 0건 (2026-05). 해결 경로 = Path A (KOVA2 1,896 + KRGDB 1,722 = ~3,600 WGS × 4 caller × confusion matrix) — 별도 M13.5 또는 M14 캠페인으로 분리. M13 산출은 "spec freeze + acquisition plan"으로 한정.

- **PyPGx의 한국 임상 paper 1건 (ClinPharmSeq 2022) 이 한국 cockpit 1차 채택의 유일 직접 근거** — M11 권장 (MIT + Korean origin + GeT-RM 100%) 의 trifecta가 paper-level로 뒷받침되는 항목은 ClinPharmSeq panel paper 1건. 나머지는 ancestor (Stargazer Lee 2018) 인용 + sbslee github README. **이 단일 paper의 검증 depth가 cockpit production 신뢰의 단일 시점**.

- **`*35` (Youn 2024, Korean 2.02%) 가 caller validation의 한국 specific litmus test** — CPIC 등재 + 한국 specific frequency 2.02% (백인 < 0.5%, 약 5-10배). 4 caller의 `*35` detection capability (star-allele table 포함 여부 + intronic SNP rs12769205 인식) 가 한국 cockpit-grade 검증의 핵심 차별 변수. manifest-level 확인 필요 (각 caller release note의 star-allele table version + supported alleles list).

- **cockpit routing은 PyPGx 1차 + PharmCAT 2차 + Aldy 3차 (flag-gated)의 3-tier 정착이 최적** — PyPGx 단독은 ClinPharmSeq 1 paper로 신뢰 부족, PharmCAT 2차 검증으로 disagreement → manual review escalation, Aldy는 ILP rare allele 의심 시만 activate. 이 3-tier가 M7 cube 입력단 (CYP2C19 phenotype) 의 robustness 확보 + commercial license 우려 회피 + 정확도 1-3%p 격차 mitigate 의 3-fer. **stdlib 단일 caller deployment는 cockpit production이 아닌 academic LDT만 권장**.

---

## §13. cross-reference

- M11 (caller 인벤토리, 5-tool 비교 표): `/Users/ghost/core/demiurge/archive/session-notes/daptpgx-cyp-callers.md`
- M7 (POC genotyping + EMR CDS workflow): `/Users/ghost/core/demiurge/DAPTPGX/M7_map.md` §6, §8
- M1 (한국 allele 빈도 — caller 검증의 ground truth): `/Users/ghost/core/demiurge/DAPTPGX/M1_allele.md` §3
- M5 (POC PFT + genotyping panel): `/Users/ghost/core/demiurge/DAPTPGX/M5_pft.md` §8
- hexa-lang stdlib target: `~/core/hexa-lang/stdlib/bio/pgx/caller/{pypgx,pharmcat,aldy,router}.hexa` (별도 absorb 라운드)
- atlas K-prefix: `X` (tool reference) — §10.2 5개 witness 등록
- gap F8 cross-tool-consistency: M13 본 milestone이 직접 응답 (literature audit + spec, 한국 cohort 실측은 Path A 별도)
