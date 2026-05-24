---
title: DAPTPGX M11 — PGx Clinical Decision Support (CPIC CDS Hooks · IGNITE · eMERGE · Mayo RIGHT · Vanderbilt PREDICT · 분당서울대)
target_repo: hexa-lang
target_kind: cds-integration
status: open
source: demiurge/DAPTPGX (M11)
created: 2026-05-24
---

# §0. 한 줄 요약

M7 §8.2 EMR auto-trigger + CDS alert workflow 는 미국 4대 사이트 (Vanderbilt PREDICT · Mayo RIGHT · eMERGE · IGNITE) 가 ~15년 운영한 design pattern 위에 서야 함. HL7 표준 = **CDS Hooks (Apache 2.0) + FHIR** — `hexa-lang/stdlib/bio/pgx/cds/` 에 emitter 신설 + sidecar `cardio_pgx` plugin 으로 한국 EMR 환경 (OCS · OpenEMR · Maven) 에 brokered delivery.

---

## §1. 도구/프로그램 비교 표

| Name | Org | Type | EHR | License | URL/Ref |
|---|---|---|---|---|---|
| **CPIC CDS Hooks** | HL7 + CPIC | open spec | EHR-agnostic | Apache 2.0 (spec) + CC-BY 4.0 (content) | https://cds-hooks.org · https://github.com/HL7/cds-hooks · https://sandbox.cds-hooks.org |
| **IGNITE Network** | NHGRI (IGNITE I/II) | implementation consortium | mixed (Epic/Cerner) | mixed (gov funded) | https://ignite-genomics.org |
| **eMERGE** | NHGRI (eMERGE I-IV) | research network | mixed | mixed (gov) | https://emerge-network.org |
| **Mayo RIGHT 10K** | Mayo Clinic + Baylor (2017-2022) | preemptive sequencing | Epic | research (mixed) | PMC9272414 (Genetics in Medicine 2022) |
| **Vanderbilt PREDICT** | VUMC (2010-current, 16 DGI) | clinical PGx CDS production | Epic + Cerner Helix | institutional | PMC7902340 (tutorial) · pharmacogenomics.mc.vanderbilt.edu |
| **분당서울대 PGx** ⚪ SPECULATION-FENCED | SNUBH | hospital LDT | OCS (한국 내수) | 비공개 | 직접 confirmation 필요 |
| **서울아산 PGx** ⚪ SPECULATION-FENCED | AMC | hospital LDT | OCS | 비공개 | 직접 confirmation 필요 |
| **PillHarmonics** | (open-source, 2024) | CDS micro-service | FHIR | open (확인) | PMC11098593 |
| **Elimu PGx CDS** | Boston Children's (Open-source) | CDS service | FHIR | open | https://elimu.io |

---

## §2. design pattern 5종 (M7 §8.2 매핑)

| Pattern | 출처 | M7 §8.2 적용 cell |
|---|---|---|
| **preemptive panel + EHR auto-deposit** | Mayo RIGHT (10,077 환자, 77 genes, 13 DGI) | 일반화 어려움 — cost 부담, 한국 보험 미적용 |
| **reactive (cath-lab triggered)** | Vanderbilt PREDICT (clopi-CYP2C19 = first DGI 2010) | 🟢 M7 §8.2 1차 패턴 — PCI admit → POC genotype → cell lookup |
| **CDS Hooks medication-prescribe** | HL7 spec, IGNITE 적용 | 🟢 M7 §8.2 order-set 단계 — 표준 hook 호출 |
| **FHIR Genomics module** | Epic Genomic Module (2024 Frontiers) | 🟡 한국 EMR 호환성 불확실 |
| **patient wallet card** | M7 §8.3 자체 design | 🟢 — hexa stdlib generator 필요 |

→ M7 §8.2 의 cath-lab auto-trigger 흐름은 **Vanderbilt PREDICT pattern + CDS Hooks medication-prescribe hook** 의 hybrid.

---

## §3. handoff request

### §3.1 hexa-lang stdlib

```
hexa-lang/stdlib/bio/pgx/cds/
├── cds_hooks.hexa            # HL7 CDS Hooks v1.1 emitter (medication-prescribe)
├── fhir_genomics.hexa        # FHIR R4 Genomics Reporting IG (Observation/MolecularSequence)
├── kr_dapt_card.hexa         # M7 §8.3 한글 wallet card PDF generator
├── m7_cube_lookup.hexa       # M7 cube 27-cell decision lookup (CYP2C19 × HBR × 시술복잡도)
└── kr_emr_adapters/
    ├── ocs_kr.hexa           # 한국 hospital OCS (proprietary) adapter
    └── openemr_kr.hexa       # OpenEMR Korean fork adapter
```

CDS Hooks emitter signature:

```hexa
@module cds_hooks

# CDS Hooks v1.1 — medication-prescribe hook
fn emit_dapt_recommendation(
    patient_id: str,
    cyp2c19_phenotype: str,    # "PM" | "IM" | "NM" | "RM"
    hbr_class: str,             # "HIGH" | "INT" | "LOW"
    procedure_complexity: str,  # "simple" | "complex" | "stemi"
) -> CdsHooksResponse {
    let cell = m7_cube_lookup.lookup(cyp2c19_phenotype, hbr_class, procedure_complexity)
    cards: [
        Card {
            summary: cell.summary,            # "PM × HBR-HIGH × complex → clopi 600 LD + PFT D14"
            indicator: cell.severity,         # "warning" | "info"
            source: { label: "CPIC 2022 + KSC 2024", url: "..." },
            suggestions: [cell.order_set],    # 약제 + dose + DAPT 기간 + PFT 예약
            overrideReasons: [...],
        }
    ]
}
```

### §3.2 sidecar plugin — `cardio_pgx`

```
dancinlab/sidecar/plugins/cardio_pgx/
├── plugin.tape
├── commands/
│   ├── dapt-pgx-decide.tape      # /dapt-pgx-decide <patient.vcf>
│   └── dapt-pgx-card.tape        # /dapt-pgx-card <patient_id> → 한글 PDF
└── README.md
```

slash command 흐름:

```
/dapt-pgx-decide patient.vcf
  → pypgx.call_diplotype(vcf, "CYP2C19")           # caller layer
  → cpic.phenotype_recommendation("CYP2C19", "PM", "clopidogrel")  # SSOT layer
  → ARC-HBR auto-calc (Hb/Cr/age from prompt or EMR JSON)
  → m7_cube_lookup → cell + 권고
  → CDS Hooks card (또는 한글 plaintext)
```

### §3.3 atlas K=R (recipe) 등록

```
atlas append-witness --kind R --id M7.cube.27cell.lookup.v1 \
  --raw 'M7 cube CYP2C19 × HBR × 시술복잡도 27-cell decision lookup recipe'

atlas append-witness --kind R --id KR.DAPT.wallet.card.template.v1 \
  --raw 'KR DAPT 환자 카드 한글 generator template (M7 §8.3)'
```

---

## §4. 한국 환경 적용 가능성

- **분당서울대 / 서울아산 PGx 임상 검사** ⚪ SPECULATION-FENCED — 두 기관 모두 PGx LDT 보유 추정, 그러나 본 검색에서 직접 confirmation 못 함. **next action**: SNUBH 약물유전체학 클리닉 (이동건 교수 그룹?) · AMC 정밀의료센터 직접 query.
- **한국 EMR 환경** — 대형 (Big-5) 병원은 OCS in-house build, 중소병원은 EMRone/Stoll/Maven 등 다양. CDS Hooks 표준 채택 ~제한적. **hexa-lang sidecar plugin 의 path 가 가장 실용적** (병원 IT 부담 ↓).
- **KFDA 의료기기 등급** — SaMD (Software as a Medical Device) 로 CDS engine 분류 시 KFDA 2/3등급. 본격 임상 deployment 전 적합성 인증 필요.
- **NHIS 보험 수가** — CYP2C19 유전자 검사 자체 수가 코드 존재 (HIRA 표 확인 필요), CDS 자체는 별도 수가 부재 → hospital cost-center 부담.
- **한글 지원** — CDS Hooks card 의 summary/detail 은 한글 UTF-8 OK. M7 §8.3 환자 카드는 hexa stdlib 측에서 처음부터 한글로 generate (no translation layer).

---

## §5. license 호환성

| 도구 | License | hexa stdlib 통합 |
|---|---|---|
| CDS Hooks spec | Apache 2.0 (code) + CC-BY 4.0 (docs) | 🟢 |
| FHIR R4 | Creative Commons "no rights reserved" | 🟢 |
| Mayo RIGHT design | research paper only | n/a (pattern 차용) |
| Vanderbilt PREDICT | institutional | n/a (pattern 차용) |
| eMERGE/IGNITE rules | mixed (gov-funded, mostly public) | 🟡 case-by-case |
| PillHarmonics | open (확인 필요) | 🟡 |
| Elimu PGx CDS | open | 🟢 |

→ CDS Hooks + FHIR 표준 = hexa-lang stdlib 통합에 license 무장애.

---

## §6. ⚪ SPECULATION-FENCED

- 분당서울대 PGx 임상 검사 program 운영 여부 · 검사 항목 · 보험 적용 범위 (직접 confirmation 필요)
- 서울아산 PGx 임상 검사 동상
- 한국 OCS (Big-5 in-house) 의 CDS Hooks 표준 채택률
- KFDA SaMD 등급 산정 (CDS engine 의 자율도 수준 의존)
- PillHarmonics / Elimu PGx CDS 의 production 사용 현황

---

## §7. 핵심 통찰 (3 bullets)

- **Vanderbilt PREDICT 가 16-DGI 14년 운영 사례 — 한국 도입의 single best blueprint** — 첫 DGI 가 정확히 `clopi-CYP2C19` (2010), 본 도메인 DAPTPGX 와 일치. PREDICT 의 reactive cath-lab triggered pattern + CDS Hooks 표준화가 M7 §8.2 의 production 경로.
- **한국 EMR 환경에서 CDS Hooks 채택률이 미지수 — sidecar plugin 이 우회 path** — 대형 병원 in-house OCS 가 HL7 표준에 부분 호환. hexa-lang `cardio_pgx` sidecar plugin (slash command + 한글 PDF generator) 가 IT 통합 부담 없이 의사 desktop 에서 즉시 작동 가능 — M7 §8.2 의 light-weight 변형.
- **CDS layer 의 한국화는 M7 §8.3 환자 카드부터 — 즉시 가치** — CDS Hooks emitter (Epic/Cerner 통합) 는 장기 (~2-3년), 그러나 한글 wallet card PDF generator 는 hexa-lang stdlib 만으로 immediate. 환자가 다음 병원 방문 시 once-in-lifetime CYP2C19 결과를 휴대 → re-test 비용 회피 + decision continuity 확보.

---

## §8. cross-reference

- PMID/PMC: PMC7902340 (Vanderbilt PREDICT 10-year tutorial), PMC9272414 (Mayo RIGHT 10K), PMC11098593 (PillHarmonics), PMC9291515 (PGx CDS review)
- M7 매핑: `/Users/ghost/core/demiurge/DAPTPGX/M7_map.md` §8.2 (EMR CDS workflow), §8.3 (환자 카드)
- hexa-lang target: `~/core/hexa-lang/stdlib/bio/pgx/cds/`
- sidecar target: `~/core/sidecar/plugins/cardio_pgx/`
- atlas K-prefix: `R` (recipe/decision)
