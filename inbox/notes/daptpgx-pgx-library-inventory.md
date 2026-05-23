---
title: DAPTPGX M11 — PGx 라이브러리/도구 통합 인벤토리 (handoff hub)
target_repo: hexa-lang
target_kind: stdlib-wrapper
status: open
source: demiurge/DAPTPGX (M11)
created: 2026-05-24
---

# DAPTPGX M11 — PGx 라이브러리/도구 통합 인벤토리

> demiurge `@goal: 한국인 PCI DAPT CYP2C19 PGx 결정맵` (M7 cube 27-cell) 을 실제 임상에 작동시키려면
> SSOT DB · caller · CDS · POC HW · NGS pipeline 5 layer 의 외부 도구를 `hexa-lang` stdlib + `atlas` SSOT 로 absorb 해야 함.
> 이 노트 = hub. 5개 카테고리별 세부 노트는 sister 파일 (`daptpgx-pgx-{ssot-databases,cyp-callers,pgx-cds-tools,pgx-poc-devices,pgx-ngs-pipelines}.md`).
> demiurge 는 pointer — 코드/wrapper 는 **모두** `hexa-lang` SSOT.

---

## §1. 5-layer 통합 도구 매트릭스

| Layer | 대표 도구 (n) | 핵심 가치 (M7 매핑) | hexa absorption 형태 |
|---|---|---|---|
| **A. SSOT DB** (`daptpgx-pgx-ssot-databases.md`) | PharmGKB · CPIC · PharmVar · DPWG · ClinPGx (5) | 가이드라인 ground-truth, M7 §3 권고 근거 | `atlas append-witness --kind P` (PGx) + `hexa-lang/stdlib/bio/pgx/db/` REST wrapper |
| **B. Caller** (`daptpgx-cyp-callers.md`) | PharmCAT · Aldy · Stargazer · PyPGx · ursaPGx (5) | VCF → `*N/*M` diplotype → CPIC phenotype | `hexa-lang/stdlib/bio/pgx/caller/{pharmcat,aldy,pypgx}.hexa` JNI/subprocess wrapper |
| **C. CDS** (`daptpgx-pgx-cds-tools.md`) | CPIC CDS Hooks · IGNITE · eMERGE · Mayo RIGHT · Vanderbilt PREDICT · 분당서울대 (6) | M7 §8 EMR 통합 — order-set alert | `hexa-lang/stdlib/bio/pgx/cds/` + sidecar plugin (cardio_pgx) |
| **D. POC device** (`daptpgx-pgx-poc-devices.md`) | Spartan RX · Genomadix Cube · Verigene · AutoGenomics INFINITI · ID-CHIP (5) | M7 §8.1 cath-lab 60-min TAT | `atlas append-witness --kind X` (HW ref) + manifest only |
| **E. NGS pipeline** (`daptpgx-pgx-ngs-pipelines.md`) | gnomAD PGx · KOVA · KRGDB · pgx-pop · DRAGEN PGx (5) | 한국인 allele freq · 신변이 발견 | `hexa-lang/stdlib/bio/pgx/pop/` + `atlas append-witness --kind P` (population) |

총 ~26 도구 · 한국 origin 3 (PyPGx · Stargazer · KOVA/KRGDB).

---

## §2. 한국 환경 적용 매트릭스

각 도구 × {한국인 데이터 · KFDA 승인 · 보험 수가 · 한글 지원 · 라이선스} 5축 평가.

| 도구 | 한국인 데이터 | KFDA | 보험 수가 | 한글 | 라이선스 | M7 적용 즉시성 |
|---|---|---|---|---|---|---|
| PharmGKB | ⚪ (간접: 1KGP EAS) | n/a (DB) | n/a | ✗ | Mozilla MPL 2.0 | 🟢 즉시 |
| CPIC | ⚪ (글로벌 가이드라인) | n/a | n/a | ✗ | CC-BY-SA 4.0 | 🟢 즉시 |
| PharmVar | ⚪ | n/a | n/a | ✗ | free, terms TBC | 🟢 즉시 |
| DPWG | ✗ (네덜란드 cohort) | n/a | n/a | ✗ | free guideline | 🟡 cross-ref |
| ClinPGx (FDA labels) | ✗ | n/a | n/a | ✗ | CC | 🟡 참조 |
| PharmCAT | ⚪ | ✗ | ✗ | ✗ | Mozilla MPL 2.0 | 🟢 즉시 (research) |
| Aldy | ⚪ | ✗ | ✗ | ✗ | non-commercial (paid commercial) ⚪ SPECULATION-FENCED | 🟠 license 확인 필요 |
| Stargazer | 🟢 한국 저자 (Lee SB, U Washington) | ✗ | ✗ | ✗ | Creative Commons (academic) | 🟡 |
| PyPGx | 🟢 한국 저자 (Lee SB, sbslee) | ✗ | ✗ | ✗ | MIT | 🟢 즉시 (선호) |
| CPIC CDS Hooks | ⚪ | ✗ | ✗ | ✗ | Apache 2.0 | 🟡 EMR 통합 필요 |
| IGNITE / eMERGE / Mayo RIGHT / Vanderbilt PREDICT | ✗ (미국) | ✗ | n/a | ✗ | mixed | 🟠 design pattern only |
| 분당서울대 PGx | 🟢 한국 LDT | ✗ (LDT) | 🟡 부분 | 🟢 | 비공개 | 🟢 (사례 study) |
| Spartan RX | ✗ (회사 청산) | ✗ | ✗ | ✗ | discontinued | 🔴 unavailable |
| Genomadix Cube | ⚪ | ✗ | ✗ | ✗ | FDA 510(k) | 🟡 import |
| Verigene CYP2C19 | ✗ (discontinued for CYP2C19) | ✗ | ✗ | ✗ | discontinued | 🔴 |
| ID-CHIP (KRIBB?) | 🟢 한국 | ⚪ | ⚪ | 🟢 | 🟠 SPECULATION-FENCED | ⚪ 확인 필요 |
| KOVA / KOVA2 | 🟢 1,896 WGS + 3,409 WES Korean | n/a | n/a | 🟢 | open (academic) | 🟢 즉시 (allele freq) |
| KRGDB | 🟢 1,722 Korean WGS | n/a | n/a | 🟢 | open | 🟢 즉시 |

⚪ = 직접 검증 안 됨, 🟢/🟡/🔴 = 적용 가능성.

---

## §3. handoff request (hexa-lang absorption plan)

### §3.1 신설 stdlib 경로 (proposed)

현재 `hexa-lang/stdlib/bio/` 에 `pgx/` 폴더 **없음** (greenfield).

```
hexa-lang/stdlib/bio/pgx/
├── pgx.ai.md                    # 진입 문서 — CYP2C19/clopidogrel 우선, 확장 27 genes
├── pgx.hexa                     # top-level module
├── cyp2c19.hexa                 # M7 cube 결정맵 1차 구현 (DAPT 도메인)
├── db/                          # category A — SSOT DB wrappers
│   ├── pharmgkb.hexa            # REST api.pharmgkb.org/v1
│   ├── cpic.hexa                # api.cpicpgx.org JSON
│   ├── pharmvar.hexa            # star-allele nomenclature (NIH lhcaws API)
│   └── dpwg.hexa                # KNMP guideline static table
├── caller/                      # category B — VCF→diplotype callers
│   ├── pharmcat.hexa            # JNI / subprocess (Mozilla MPL 2.0, hexa-compat)
│   ├── pypgx.hexa               # Python subprocess (MIT, 1차 권장)
│   └── aldy.hexa                # commercial flag-gated wrapper (license check 후)
├── cds/                         # category C — CDS Hooks emitter
│   ├── cds_hooks.hexa           # HL7 spec emitter (medication-prescribe hook)
│   └── kr_dapt_card.hexa        # M7 §8.3 환자 카드 한글 PDF generator
├── pop/                         # category E — population pipelines
│   ├── kova.hexa                # KOVA2 frequency lookup
│   ├── krgdb.hexa
│   └── gnomad_pgx.hexa
└── tests/
    ├── cyp2c19_get_rm_concordance.hexa   # 1KGP / GeT-RM benchmark
    └── m7_cube_cell_recall.hexa          # 27-cell decision recall
```

### §3.2 atlas SSOT 등록 (proposed K-prefix)

```
# SSOT DB (category A)
atlas append-witness --kind P --id PharmGKB.CYP2C19.allele.canonical
atlas append-witness --kind P --id CPIC.CYP2C19.clopidogrel.guideline.2022
atlas append-witness --kind P --id PharmVar.CYP2C19.starallele.v4
atlas append-witness --kind P --id DPWG.CYP2C19.clopidogrel.guideline.2024
atlas append-witness --kind P --id ClinPGx.CYP2C19.FDA.label

# Population freq (category E)
atlas append-witness --kind P --id KOVA2.CYP2C19.allele.freq.kr
atlas append-witness --kind P --id KRGDB.CYP2C19.allele.freq.kr.1722wgs

# HW reference (category D)
atlas append-witness --kind X --id Genomadix.Cube.CYP2C19.FDA510k.tat60min
atlas append-witness --kind X --id KRIBB.ID-CHIP.CYP2C19.kr   # ⚪ SPECULATION-FENCED

# Tool reference (category B)
atlas append-witness --kind X --id PyPGx.sbslee.MIT.v0
atlas append-witness --kind X --id PharmCAT.PharmGKB.MPL2.v3
```

### §3.3 sidecar plugin (proposed)

`dancinlab/sidecar` 에 `plugins/cardio_pgx/` 신설 — `/dapt-pgx-decide <patient.vcf>` 슬래시 커맨드 →
caller (PyPGx) → CPIC phenotype → M7 cube cell lookup → 한글 권고 출력.

---

## §4. license 호환성 (hexa-lang gate)

hexa-lang 자체 라이선스 = (확인 필요, presumably MIT/Apache 2.0).
strong copyleft (GPL) 는 stdlib 침투 금지. wrapper 는 subprocess 격리로 통과 가능.

| 도구 | 라이선스 | hexa stdlib 직접 통합 | subprocess wrapper |
|---|---|---|---|
| PyPGx | MIT | 🟢 (재배포 가능, 그러나 Python runtime 필요) | 🟢 권장 |
| PharmCAT | Mozilla MPL 2.0 | 🟡 (file-level copyleft) | 🟢 권장 (subprocess) |
| Aldy | non-commercial (paid commercial 별도) ⚪ SPECULATION-FENCED | 🔴 (academic만) | 🟡 (flag-gated) |
| Stargazer | CC-BY-NC (academic 추정) | 🔴 (commercial 불가) | 🟠 (flag-gated) |
| ursaPGx (R package) | (확인 필요) | 🔴 (R runtime 의존) | 🟡 |
| CPIC guidelines | CC-BY-SA 4.0 | 🟢 (share-alike 가능) | n/a (data) |
| PharmGKB | Mozilla MPL 2.0 (도구 자체) | 🟡 | 🟢 (REST API 사용 시 무관) |
| CDS Hooks spec | Apache 2.0 + CC-BY 4.0 | 🟢 | n/a |

→ **1차 stdlib 권장 = PyPGx (MIT) + PharmCAT subprocess (MPL2)** — Aldy/Stargazer 는 flag-gated.

---

## §5. handoff priority — 어느 것부터 absorb?

M7 cube 27-cell 의 실제 임상 작동 ordering:

1. **🟢 즉시 (Q3 2026)** — PyPGx wrapper + CPIC API + KOVA2 frequency lookup. M7 §8.1 POC 60min TAT 대안 = lab WGS + PyPGx (TAT 2-4h).
2. **🟢 즉시 (Q3 2026)** — atlas SSOT P-kind 5건 등록 (CPIC · PharmGKB · PharmVar · DPWG · ClinPGx) — `register --from-verify` 로 raw guideline ingest.
3. **🟡 Q4 2026** — CDS Hooks emitter + 한글 환자 카드 generator (M7 §8.3). sidecar plugin 통합.
4. **🟡 Q4 2026** — Genomadix Cube manifest (KFDA 도입 시) + ID-CHIP KRIBB 확인.
5. **🟠 Q1 2027** — PharmCAT subprocess wrapper (license review 후) + benchmark vs PyPGx on GeT-RM.
6. **🟠 Q1 2027** — Vanderbilt PREDICT / Mayo RIGHT design pattern 흡수 → 분당서울대/서울아산 한국 LDT 매핑.

---

## §6. ⚪ SPECULATION-FENCED 명시

직접 검증 안 한 항목:
- KRIBB ID-CHIP 의 CYP2C19 cover · KFDA 승인 · 한국 보급률 — 1차 source 미확보
- Aldy 4 의 정확한 license terms (non-commercial vs commercial paid)
- 분당서울대/서울아산 PGx 임상검사 보험수가 단가
- hexa-lang 본체 라이선스 확정값 (MIT 추정)
- 한국 NHIS (건강보험심사평가원) CYP2C19 검사 수가 코드

위 항목은 sister 노트에서 확인 시 update.

---

## §7. 핵심 통찰 (3 bullets)

- **한국 origin 도구 3개 (PyPGx · Stargazer · KOVA/KRGDB) 가 M7 cube 결정맵의 한국화 핵심** — caller (PyPGx, MIT) + 한국인 allele freq (KOVA2 1,896 WGS) 만으로 M7 §1 한국인 IM+PM 60% 분포의 evidence-base 가 완결됨. 외부 의존 ↓.
- **caller layer 는 PyPGx 단일 점핑 + PharmCAT 2차 검증 = best-of-breed** — F1 ~0.99 (PyPGx GeT-RM concordance ~100%) · Aldy 98.2% (8 genes) · PharmCAT 광범위 27-gene cover. M7 §8 POC 60min 의 lab 대안 (TAT 2-4h WGS) 으로 충분.
- **POC HW layer 가 가장 약함 — Spartan RX 회사 청산 + Verigene CYP2C19 discontinued** — Genomadix Cube 가 유일 FDA 510(k) 생존. M7 §8.1 의 60min TAT 약속이 hardware-side 에서 위협받는 중. 한국 ID-CHIP 검증이 시급 (KRIBB confirmation 필요).

---

## §8. cross-reference

- demiurge SSOT: `/Users/ghost/core/demiurge/DAPTPGX/M7_map.md` §8 (POC + EMR)
- demiurge SSOT: `/Users/ghost/core/demiurge/DAPTPGX/M1_allele.md` (한국인 allele 분포)
- sister 노트: `daptpgx-pgx-{ssot-databases,cyp-callers,pgx-cds-tools,pgx-poc-devices,pgx-ngs-pipelines}.md`
- hexa-lang target: `~/core/hexa-lang/stdlib/bio/pgx/` (greenfield, scaffold 필요)
- atlas target: `K=P` (pharmacogenomics witness) · `K=X` (tool/HW reference)
