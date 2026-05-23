---
title: DAPTPGX M11 — CYP star-allele callers (PharmCAT · Aldy · Stargazer · PyPGx · ursaPGx)
target_repo: hexa-lang
target_kind: stdlib-wrapper
status: open
source: demiurge/DAPTPGX (M11)
created: 2026-05-24
---

# §0. 한 줄 요약

M7 cube 결정맵의 입력 = `CYP2C19 *N/*M` diplotype. 환자 VCF (POC 또는 NGS panel) → diplotype 변환은 5개 caller (PharmCAT · Aldy · Stargazer · PyPGx · ursaPGx) 가 경쟁 중 — **PyPGx (sbslee, MIT, 한국 저자) 가 license + GeT-RM 정확도 + 한국 origin 3-fer 로 hexa-lang stdlib 1차 권장**.

---

## §1. 도구 비교 표

| Name | Maintainer | License | 한국 데이터/저자 | F1/concordance | URL |
|---|---|---|---|---|---|
| **PharmCAT** | Stanford+Penn (PharmGKB) | Mozilla MPL 2.0 | ✗ | 27-gene cover, 100% concordance on GeT-RM CYP2C19 (Sangkuhl 2024) | https://github.com/PharmGKB/PharmCAT · https://pharmcat.clinpgx.org |
| **Aldy 4** | Indiana U (Numanagić et al.) | non-commercial (paid commercial) ⚪ SPECULATION-FENCED | ✗ | 98.2% concordance GeT-RM 8 genes (165/168) · F1 0.89 INDEL · 0.98 SNP | https://github.com/0xTCG/aldy |
| **Stargazer** | U Washington (Lee SB, **한국 저자**) | CC-BY-NC (academic) | 🟢 Lee SB (Korean) | 28-gene cover, CYP2D6 F1 0.97 (Lee 2018/2019) | https://github.com/Wilsonjsjunior/stargazer (fork) |
| **PyPGx** | sbslee (**Lee SB**, Korean, post-Stargazer) | **MIT** | 🟢 Korean origin | ~100% GeT-RM concordance (1KGP N=2,504, ClinPharmSeq paper) · 27 genes | https://github.com/sbslee/pypgx |
| **ursaPGx** | (R package, 2023) | (확인 필요) | ✗ | phased WGS-only, 1000G benchmark | https://github.com/coriell-research/ursaPGx (추정) |
| (참조) Astrolabe | USC commercial | proprietary | ✗ | clinical-grade, vendor-locked | n/a (closed) |
| (참조) Cyrius | Illumina | (확인 필요) | ✗ | CYP2D6-specialized, WGS | https://github.com/Illumina/Cyrius |
| (참조) StellarPGx | (R package) | (확인) | ✗ | benchmark control in Aldy paper | n/a |

→ 한국 저자 1명이 도구 2개 (Stargazer → PyPGx) 의 lineage 를 가짐. PyPGx 가 MIT 라이선스로 license-clean.

---

## §2. M7 cube 매핑 — caller 출력 → CPIC phenotype

| Caller output | CPIC phenotype | M7 cube x-axis |
|---|---|---|
| `*1/*1` | NM (Normal Metabolizer) | NM/RM 행 |
| `*1/*17` · `*17/*17` | RM/UM (Rapid/Ultra) | NM/RM 행 (RM 1%) |
| `*1/*2` · `*1/*3` | IM (Intermediate) | IM 행 (~45%) |
| `*2/*2` · `*2/*3` · `*3/*3` | PM (Poor) | PM 행 (~15%) |

→ 5 caller 모두 위 변환을 자동 수행 (CPIC 통합), 출력은 phenotype string + dosing recommendation 텍스트.

---

## §3. handoff request

### §3.1 hexa-lang stdlib wrapper (priority order)

```
hexa-lang/stdlib/bio/pgx/caller/
├── pypgx.hexa        # 1차 (MIT, 한국 저자, GeT-RM ~100%)
├── pharmcat.hexa     # 2차 (MPL2, 광범위, 검증용)
└── aldy.hexa         # 3차 (license review 후, flag-gated)
```

PyPGx wrapper signature (제안):

```hexa
import "stdlib/sys/subprocess"

@module pypgx

fn call_diplotype(vcf_path: str, gene: str) -> Result[Diplotype, PgxError] {
    let result = subprocess.run([
        "pypgx", "run-ngs-pipeline",
        gene, vcf_path,
        "--output-dir", tmp_dir(),
    ])
    parse_pypgx_output(result.stdout)
}

struct Diplotype {
    gene: str,           # "CYP2C19"
    allele_a: str,       # "*2"
    allele_b: str,       # "*2"
    phenotype: str,      # "Poor Metabolizer"
    cpic_activity: float,# 0.0
}
```

PharmCAT wrapper (JNI 또는 subprocess):

```hexa
fn pharmcat_report(vcf_path: str) -> Result[PharmCATReport, PgxError] {
    # PharmCAT v3.x Java 17+ 필요, jar/docker
    subprocess.run([
        "java", "-jar", "pharmcat-pipeline.jar",
        "-vcf", vcf_path,
        "-reporterJson",
    ])
}
```

### §3.2 atlas K=X (tool ref) 등록

```
atlas append-witness --kind X --id PyPGx.sbslee.MIT.v0.27gene \
  --raw 'PyPGx — Korean author Lee SB, MIT license, 27-gene support, GeT-RM 100% concordance'

atlas append-witness --kind X --id PharmCAT.PharmGKB.MPL2.v3 \
  --raw 'PharmCAT v3 — Stanford+Penn, MPL 2.0, 27 genes, CPIC-integrated'

atlas append-witness --kind X --id Aldy.0xTCG.v4 \
  --raw 'Aldy 4 — Indiana U, license non-commercial, 20-gene support, 98.2% GeT-RM concordance'

atlas append-witness --kind X --id Stargazer.LeeSB.UW.CCBYNC \
  --raw 'Stargazer — U Washington Lee SB (Korean), CC-BY-NC, 28-gene, PyPGx 의 ancestor'
```

### §3.3 benchmark plan

DAPTPGX M7 cube 의 27-cell 권고가 caller 선택에 invariant 함을 보장:

```hexa
# hexa-lang/stdlib/bio/pgx/tests/cyp2c19_get_rm_concordance.hexa
@test
fn caller_consensus_on_get_rm() {
    let samples = load_get_rm_samples()  # 88 1000G samples
    for s in samples {
        let py = pypgx.call_diplotype(s.vcf, "CYP2C19")
        let pc = pharmcat_report(s.vcf).cyp2c19
        assert_eq(py.phenotype, pc.phenotype, msg: s.id)
    }
}
```

→ 통과 시 PyPGx 단독 deployment 의 정당성 확보.

---

## §4. 한국 환경 적용 가능성

- **PyPGx** — 한국 저자 + MIT + 27-gene + sbslee 활동 중 (CHANGELOG 활발) → **한국 임상 첫 번째 선택**. ClinPharmSeq paper (PLOS ONE 2022) 가 한국 패널 설계 backbone.
- **Stargazer** — Lee SB 의 PhD work (U Washington Nickerson lab, 2018). 한국 저자지만 academic CC-BY-NC 로 commercial deployment 제약 → 분당서울대/서울아산 LDT 에는 활용 가능, 상용 진단 키트에는 부적합.
- **PharmCAT** — license clean (MPL2 file-level), 한국 적용 무장애. Java 17+ runtime 요구가 일부 한국 EMR 환경에서 마찰 가능.
- **Aldy** — academic 무료, commercial 시 별도 라이선스 (Indiana U Flintbox 페이지) ⚪ SPECULATION-FENCED. 한국 임상 import 시 license counsel.
- **ursaPGx** — R package → 한국 EMR 시스템 (대체로 Java/.NET) 과 통합 마찰. subprocess 만 권장.

---

## §5. license 호환성 (hexa-lang stdlib gate)

| Caller | License | hexa stdlib 포함 | subprocess wrapper | commercial 진단 키트 |
|---|---|---|---|---|
| PyPGx | MIT | 🟢 (직접 통합 가능) | 🟢 | 🟢 |
| PharmCAT | MPL 2.0 | 🟡 (file-level copyleft, subprocess 권장) | 🟢 | 🟢 (file 추가 변경 시 share-back) |
| Aldy | non-commercial ⚪ | 🔴 (academic만) | 🟡 flag-gated | 🔴 (별도 라이선스) |
| Stargazer | CC-BY-NC | 🔴 (commercial 불가) | 🟡 (academic flag) | 🔴 |
| ursaPGx | (확인) | 🟠 (R runtime 의존) | 🟡 | (license 확인) |

→ **stdlib 1차 = PyPGx 단독, PharmCAT subprocess 2차 검증** — 나머지는 flag-gated.

---

## §6. ⚪ SPECULATION-FENCED

- Aldy 4 의 정확한 commercial license fee (Indiana U Flintbox)
- ursaPGx 의 license (R package CRAN/Bioconductor 표준 추정)
- PyPGx 의 한국 임상 실제 사용 사례 (논문은 ClinPharmSeq panel 만 확인됨)
- 5 caller 의 head-to-head accuracy on Korean CYP2C19 cohort (KOVA 매핑 benchmark 부재)

---

## §7. 핵심 통찰 (3 bullets)

- **PyPGx 가 license + 정확도 + 한국 origin 의 trifecta — hexa-lang stdlib 1차 caller 의 default 결정** — MIT (clean) + GeT-RM ~100% concordance + sbslee (Lee SB) 한국 저자. M7 cube 의 입력단을 단일 도구로 stdlib-grade 안정화 가능.
- **PharmCAT 가 2차 검증 도구로 best** — 27 gene cover (CYP2C19 + 26 추가), CPIC 가이드라인 직결, MPL2 file-level copyleft 만 신경 쓰면 subprocess 격리로 무해. PyPGx-vs-PharmCAT disagreement 가 발생하는 cell 은 manual review escalation.
- **caller layer 의 한국 cohort benchmark 부재가 evidence gap** — KOVA2 1,896 WGS + KRGDB 1,722 WGS 데이터를 5 caller 에 돌려 head-to-head F1 표를 만드는 게 stdlib 채택의 final validation. 이 benchmark 자체가 DAPTPGX M12+ 의 캠페인 후보.

---

## §8. cross-reference

- PMID: PMC10699732 (PharmCAT review), Lee 2018 Genet Med (Stargazer), bioRxiv 2022.08.11.503701 (Aldy 4)
- ClinPharmSeq paper: PLOS ONE 2022 (PyPGx + Korean clinical panel)
- M7 매핑: `/Users/ghost/core/demiurge/DAPTPGX/M7_map.md` §8.1 (POC 60min 대안 lab caller)
- hexa-lang target: `~/core/hexa-lang/stdlib/bio/pgx/caller/{pypgx,pharmcat,aldy}.hexa`
- atlas K-prefix: `X` (tool reference)
