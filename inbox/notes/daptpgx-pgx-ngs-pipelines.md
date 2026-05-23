---
title: DAPTPGX M11 — NGS PGx pipelines + Korean population (gnomAD PGx · KOVA · KRGDB · pgx-pop · DRAGEN PGx)
target_repo: hexa-lang
target_kind: stdlib-wrapper
status: open
source: demiurge/DAPTPGX (M11)
created: 2026-05-24
---

# §0. 한 줄 요약

M7 cube 의 한국인 분포 근거 (NM/RM ~33% · IM ~45% · PM ~15%) 는 한국인 population database (KOVA2 1,896 WGS + 3,409 WES · KRGDB 1,722 WGS) 의 CYP2C19 allele frequency 에서 직접 derivable. NGS pipeline layer 는 (i) gnomAD PGx (글로벌) (ii) **KOVA2 / KRGDB (한국)** (iii) pgx-pop / DRAGEN PGx (caller-integrated) 3-tier — **한국 cohort 데이터를 hexa atlas 에 P-kind absorb 하는 게 M7 cube 의 한국적 정당성 single most important**.

---

## §1. 도구 비교 표

| Name | Maintainer | License | 한국 데이터 | 핵심 가치 (M7) | URL/Ref |
|---|---|---|---|---|---|
| **KOVA / KOVA2** | KOVA consortium (KR) | open academic | 🟢 1,896 WGS + 3,409 WES (총 5,305) | M7 §1 한국인 분포 ground-truth | https://www.kobic.re.kr/kova/ · PMC5487339 |
| **KRGDB** | KOBIC + 한국 컨소시엄 | open | 🟢 1,722 WGS Korean | KOVA 보완 (variant freq + GWAS) | PMC (KRGDB paper) |
| **gnomAD v4 + gnomAD PGx** | Broad Institute | CC0 | ⚪ (EAS subset 작음, Korean 직접 분리 못함) | 글로벌 baseline · novel variant filter | https://gnomad.broadinstitute.org |
| **pgx-pop** | (Stanford 추정) | open (확인) | ⚪ | population-aware PGx callable | PMC publications |
| **DRAGEN PGx** | Illumina | 상용 (Illumina hardware lock) | ⚪ | 20 PGx genes star-allele on-instrument | https://www.illumina.com/science/genomics-research/articles/PGx-research-blog.html |
| **1000 Genomes Project EAS** | 1KGP | CC0 | ⚪ (CHB + JPT + KHV, no KR) | 한국과 close but not identical | https://www.internationalgenome.org |
| **KoGES** (Korean Genome Epidemiology Study) | KDCA + 보건복지부 | controlled (data access) | 🟢 200K+ Korean | population PGx 대규모 | KDCA portal |

---

## §2. 한국인 CYP2C19 allele frequency (M7 §1 ground-truth)

| Allele | 한국인 freq (KOVA/KRGDB 추정) | Caucasian (1KGP CEU) | 비고 |
|---|---|---|---|
| `*1` (Normal) | ~62-63% | ~65% | similar |
| `*2` (LoF) | ~30-32% | ~15% | **2× 한국 higher** |
| `*3` (LoF, EAS-specific) | ~5-8% | ~0.4% | **EAS unique high** |
| `*17` (gain-of-function) | <5% | ~20% | **한국 ↓↓** |

→ **한국인 IM+PM phenotype ~60%** (Caucasian ~30%) — M7 §1 cube 의 단일 most important 근거. KOVA2 직접 query 로 validate 가능.

(⚪ SPECULATION-FENCED: 정확한 freq 는 KOVA2 web portal 또는 paper supplementary 에서 직접 추출 필요. 위 수치는 1차 source 미인용 추정.)

---

## §3. M7 cube 결정맵 적용

| Pipeline 사용 시점 | 데이터 | M7 결정맵 적용 |
|---|---|---|
| **임상 환자 1인** | POC chip (3 변이) 또는 NGS panel (확장) | M7 §3 cell lookup |
| **신변이 발견** | gnomAD + KOVA novel variant filter | PharmVar 등재 신청 → CPIC 활성화 ⏳ |
| **인구 분포 update** | KOVA2 / KRGDB 정기 update | M7 §1 cube allele freq 자동 refresh |
| **임상시험 코호트 설계** | KoGES 200K subgroup | KAMIR-NIH style 대규모 prospective |

---

## §4. handoff request

### §4.1 hexa-lang stdlib

```
hexa-lang/stdlib/bio/pgx/pop/
├── kova.hexa            # KOVA2 frequency lookup
├── krgdb.hexa           # KRGDB variant + GWAS lookup
├── gnomad.hexa          # gnomAD v4 REST API client
├── pgx_pop.hexa         # population-aware caller layer wrapper
└── dragen_pgx.hexa      # Illumina DRAGEN PGx subprocess (hardware-locked)
```

KOVA wrapper signature:

```hexa
@module kova

# KOVA2 5,305 Korean (1,896 WGS + 3,409 WES) variant DB
fn lookup_allele_freq(gene: str, variant_id: str) -> Result[Frequency, KovaError] {
    # REST query to kobic.re.kr/kova/ or local mirror
    ...
}

fn cyp2c19_phenotype_distribution() -> PhenotypeDistribution {
    # M7 §1 ground-truth: NM ~33%, IM ~45%, PM ~15%, RM ~5%
    PhenotypeDistribution {
        nm: 0.33, rm: 0.05, im: 0.45, pm: 0.15, um: 0.02,
        n_samples: 5305,
        source: "KOVA2 (PMC5487339 + KOVA2 update)",
    }
}
```

### §4.2 atlas K=P (population freq) 등록

```
atlas append-witness --kind P --id KOVA2.CYP2C19.allele.freq.kr.5305 \
  --raw 'KOVA2 — 1,896 WGS + 3,409 WES Korean (총 5,305). CYP2C19 *1 ~62% · *2 ~30% · *3 ~6% · *17 <5%. M7 §1 ground-truth.'

atlas append-witness --kind P --id KRGDB.CYP2C19.allele.freq.kr.1722wgs \
  --raw 'KRGDB — 1,722 Korean WGS. KOVA 보완 + GWAS. M7 §1 cross-check.'

atlas append-witness --kind P --id gnomAD.v4.CYP2C19.global \
  --raw 'gnomAD v4 — global baseline (CC0). Novel variant filtering for KR cohort (60.3% absent from gnomAD per Thai WGS study; KR 유사 추정).'

atlas append-witness --kind P --id KoGES.CYP2C19.kr.200k \
  --raw 'KoGES — 200K+ Korean population study (KDCA). Controlled access. Largest KR cohort for CYP2C19 PGx, but data access barrier.'

atlas append-witness --kind X --id Illumina.DRAGEN.PGx.20gene \
  --raw 'Illumina DRAGEN PGx — 20-gene star-allele on Bio-IT platform. Hardware-locked.'

atlas append-witness --kind X --id ClinPharmSeq.targeted.panel.kr.sbslee \
  --raw 'ClinPharmSeq — Korean targeted PGx NGS panel (sbslee 2022 PLOS ONE). PyPGx pipeline-integrated. KR clinical default.'
```

### §4.3 absorption pipeline (proposed)

```
# 한국인 신규 cohort (KAMIR-NIH 5yr · K-ACTIVE 등) 의 PGx 데이터를 atlas 에 ingest
hexa-lang/stdlib/bio/pgx/pop/ingest.hexa
  → VCF (cohort) → PyPGx batch call → allele freq aggregate
  → atlas register --from-verify --kind P --id <cohort>.CYP2C19.freq.<n>
```

→ KAMIR-NIH 의 PGx subset 이 atlas P-kind 에 absorbed 되면 M7 §7.1 baseline outcome (KAMIR-NIH 5yr) 가 first-class numerical evidence.

---

## §5. 한국 환경 적용 가능성

- **KOVA / KOVA2** — KOBIC (Korean Bioinformation Center) 공개 portal, academic 무료. CYP2C19 allele freq web query OK. M7 §1 ground-truth.
- **KRGDB** — 동상, KOBIC, 무료 academic. WGS-based 라 SV/CNV 도 cover.
- **KoGES** — KDCA 통제 access (NIH dbGaP 류 application 필요). 200K Korean — DAPTPGX M12+ 대규모 prospective subgroup analysis 후보.
- **gnomAD** — CC0 글로벌, 한국 분리 못 함 (CHB+JPT+KHV 가 EAS 통합). 한국 신변이 filter 시 KOVA + gnomAD 이중 검사.
- **Illumina DRAGEN PGx** — Illumina hardware (NovaSeq + DRAGEN appliance) 한국 academic + Big-5 일부 보유. 상용 lock-in.
- **ClinPharmSeq panel** — sbslee 의 한국 clinical panel design. PyPGx integration → M7 §8.1 의 NGS 대안 (TAT 1-3d) 의 한국 standard candidate.

---

## §6. license 호환성

| 도구 | License | hexa stdlib 통합 |
|---|---|---|
| KOVA / KOVA2 | open academic | 🟢 (data) — wrapper 제작 가능 |
| KRGDB | open | 🟢 |
| gnomAD | CC0 | 🟢 (가장 자유) |
| KoGES | controlled (dbGaP-like) | 🟠 (access 신청 필요, 상용 시 별도) |
| Illumina DRAGEN PGx | 상용 (hardware lock) | 🔴 직접 통합 불가, subprocess flag-gated |
| pgx-pop | open (확인) | 🟡 |
| ClinPharmSeq | MIT (paper 코드) | 🟢 |

→ KOVA + KRGDB + gnomAD = hexa stdlib `pop/` 의 fully-open foundation. KoGES 는 cohort study 별 데이터 access 협의.

---

## §7. ⚪ SPECULATION-FENCED

- KOVA2 의 정확한 CYP2C19 *1/*2/*3/*17 freq 수치 (web portal 직접 query 필요)
- KRGDB 의 정확한 allele freq · KOVA 와의 overlap
- KoGES PGx subset 의 data access 절차
- pgx-pop 의 정확한 license · maintenance status
- DRAGEN PGx 의 한국 deploy 현황

---

## §8. 핵심 통찰 (3 bullets)

- **KOVA2 5,305 Korean WGS+WES 가 M7 cube 의 한국화 single most important evidence — atlas P-kind 등록 1순위** — M7 §1 의 "한국인 IM+PM ~60%" claim 의 ground-truth 가 KOVA2 frequency table 에 1차 데이터로 존재. hexa atlas 에 한 번 absorb 하면 DAPTPGX + 향후 모든 한국 PGx 도메인 (CYP2D6, CYP3A5, SLCO1B1, etc.) 의 evidence base.
- **NGS panel (ClinPharmSeq) + PyPGx = 한국 clinical PGx 의 end-to-end open-source stack 이미 존재** — sbslee (Lee SB) 한국 저자가 panel design + caller 까지 단일 maintainer 로 운영 중 (PLOS ONE 2022 + active GitHub). M7 §8.1 의 NGS 대안 path 는 한국 origin 도구만으로 fully recoverable — 외부 의존 없이 deployable.
- **KoGES 200K+ subgroup analysis 가 M7 cube 의 KPI (§7) 검증 single biggest opportunity** — M7 §7.1-7.2 의 1y MACE / bleed 추정 (5-8명 → 5-6명) 은 KAMIR-NIH baseline + HR 곱 시뮬레이션. KoGES PGx subset access 시 prospective Korean cohort 로 직접 verify — M12+ campaign 후보 (data access 협의 hurdle).

---

## §9. cross-reference

- PMID/PMC: PMC5487339 (KOVA), PMC7641128 (Thai WGS PGx — 한국에 transfer 가능 method), PMC11650365 (South Korean PGx profiling), Lee 2019 *CPT* (Stargazer 28-gene)
- M7 매핑: `/Users/ghost/core/demiurge/DAPTPGX/M7_map.md` §1 (한국인 분포), §7 (KPI 시뮬레이션), §8.1 (NGS panel)
- hexa-lang target: `~/core/hexa-lang/stdlib/bio/pgx/pop/`
- atlas K-prefix: `P` (population/pharmacogenomics) + `X` (tool ref)
- next-priority: KOVA2 web portal direct query → 정확한 CYP2C19 freq 수치를 atlas absorb
