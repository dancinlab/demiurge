---
title: DAPTPGX M11 — PGx SSOT 데이터베이스 (PharmGKB · CPIC · PharmVar · DPWG · ClinPGx)
target_repo: hexa-lang
target_kind: atlas-ssot-registration
status: open
source: demiurge/DAPTPGX (M11)
created: 2026-05-24
---

# §0. 한 줄 요약

M7 cube 27-cell 결정맵의 ground-truth 가이드라인은 5개 글로벌 SSOT (PharmGKB · CPIC · PharmVar · DPWG · ClinPGx) 에 분산되어 있음 — 각각 REST API + JSON 다운로드를 제공하므로 `atlas append-witness --kind P` 로 hexa SSOT에 한 번 흡수하면 cross-project (DAPTPGX · 향후 다른 약물-유전자 도메인) 재사용 가능.

---

## §1. 도구 비교 표

| Name | Maintainer | License | 한국 데이터 | API/Download | URL |
|---|---|---|---|---|---|
| **PharmGKB** | Stanford (Klein lab, NHGRI U24HG010615) | Mozilla MPL 2.0 (도구) · CC for content | ⚪ 간접 (1KGP EAS, KOVA 매핑 없음) | REST JSON `api.pharmgkb.org/v1` + 정기 dump | https://www.pharmgkb.org · https://api.pharmgkb.org/openapi.json |
| **CPIC** | Stanford+Penn (NHGRI U24HG013077) | CC-BY-SA 4.0 (가이드라인) | ⚪ (글로벌, EAS subgroup 명시) | REST JSON `api.cpicpgx.org` · `cpicpgx/cpic-data` GitHub | https://cpicpgx.org · https://api.cpicpgx.org · https://github.com/cpicpgx/cpic-data |
| **PharmVar** | Pharmacogene Variation Consortium (Gaedigk et al.) | free, terms TBC (academic) | ⚪ | REST API (NIH LForms `lforms-service.lhcaws.nlm.nih.gov`) + 정기 download | https://www.pharmvar.org · https://www.pharmvar.org/download |
| **DPWG** | KNMP (네덜란드 약사회) | free guideline (CC 추정) | ✗ | PDF/web table (programmatic API 부재) | https://www.knmp.nl/dossiers/farmacogenetica |
| **ClinPGx** | merger of PharmGKB + CPIC + ClinGen PGx (~2023) | CC | ⚪ | 통합 web view, API는 PharmGKB와 공유 | https://www.clinpgx.org |

---

## §2. CYP2C19 / clopidogrel 핵심 statement (M7 매핑)

| Source | Statement (요약) | M7 cube 적용 cell |
|---|---|---|
| CPIC 2022 update (PMC9287492) | PM/IM → prasugrel/ticagrelor 권장 (NM은 clopi 유지) — `Strong` evidence | 모든 PM/IM cell |
| PharmGKB | 한국인 *2 ~30% · *17 <5% (1KGP EAS subset; KOVA 직접 absorb 안 됨) | M1 한국인 분포 cross-check |
| PharmVar | CYP2C19 *1-*35 (2017 transition 이후 35개 haplotype) | M1 allele 목록 ground-truth |
| DPWG 2024 (NL) | PCI IM 환자에 clopi 150 mg/day (off-label) OR 대체 약제 | M7 §2 IM cell 의 한국 가이드라인과 분기 (한국은 5mg prasugrel) |
| ClinPGx (FDA label) | clopi (Plavix) USPI: PM 환자에 effectiveness 저하 — 2010 black box 잔존 | M7 §3 PM cell 의 regulatory cover |

→ **5 source consensus = PM/IM은 clopi 회피** — 한국은 prasugrel **5mg** (PRASFIT) 가 unique 분기.

---

## §3. handoff request

### §3.1 atlas K=P (pharmacogenomics) 등록

```
atlas append-witness --kind P --id PharmGKB.CYP2C19.allele.canonical \
  --raw 'PharmGKB CYP2C19 canonical allele/diplotype/phenotype table — 2026 snapshot'

atlas append-witness --kind P --id CPIC.CYP2C19.clopidogrel.guideline.2022 \
  --raw 'CPIC 2022 update (PMC9287492) — PM/IM avoid clopi (Strong evidence)'

atlas append-witness --kind P --id PharmVar.CYP2C19.starallele.v4 \
  --raw 'PharmVar CYP2C19 *1-*35 haplotype catalog (post-2017 consortium)'

atlas append-witness --kind P --id DPWG.CYP2C19.clopidogrel.guideline.2024 \
  --raw 'DPWG KNMP — IM 150mg/day OR alternative (NL; KR diverges to prasug 5mg)'

atlas append-witness --kind P --id ClinPGx.FDA.clopidogrel.label.PMboxedwarning \
  --raw 'FDA Plavix USPI 2010 black-box — reduced effectiveness in CYP2C19 PM'
```

### §3.2 hexa-lang stdlib wrapper

```
hexa-lang/stdlib/bio/pgx/db/
├── pharmgkb.hexa     # REST client — getDrugGuideline(drug, gene) → JSON
├── cpic.hexa         # REST client — getRecommendation(gene, phenotype, drug)
├── pharmvar.hexa     # haplotype lookup — getStarAlleleVariants(gene, "*2")
├── dpwg.hexa         # static table (web scrape 1회/quarter, cached JSON)
└── clinpgx.hexa      # merged-view alias (PharmGKB API 위임)
```

각 wrapper signature 예시:

```hexa
fn pharmgkb_guideline(drug: str, gene: str) -> Result[GuidelineJson, PgxError]
fn cpic_phenotype_to_recommendation(gene: str, phenotype: str, drug: str) -> Recommendation
fn pharmvar_alleles(gene: str) -> Vec[StarAllele]
```

→ DAPTPGX M7 §3 의 cell-by-cell 권고는 위 4 wrapper 만으로 fully recoverable.

---

## §4. 한국 환경 적용 가능성

- **PharmGKB / CPIC / PharmVar / ClinPGx** — 한국 환자에 직접 적용 OK (글로벌 권고), 단 **한국인 *2 freq ~30%** (vs caucasian ~15%) 의 강도가 가이드라인 권고의 net benefit 을 확대. M7 §1 cube 의 evidence base.
- **DPWG** — 네덜란드 보험 / 약가 시스템 기반 권고 (clopi 150mg 증량) → **한국에서는 off-label + 보험 비급여**. 한국은 prasugrel 5mg PRASFIT 가 표준 분기.
- **KFDA · NHIS 수가** — 위 5 SSOT 모두 한국 규제기관 인증 외부. 한국 임상은 `CYP2C19 유전자검사 (코드 N0017?)` ⚪ SPECULATION-FENCED — HIRA 수가표 직접 확인 필요.
- **한글 지원** — 5개 모두 영어. M7 §8.3 환자 카드는 hexa-lang 측에서 한글 generator 필요 (`stdlib/bio/pgx/cds/kr_dapt_card.hexa`).

---

## §5. license 호환성

| 도구 | license | hexa-lang stdlib 포함 가능 | 주의 |
|---|---|---|---|
| PharmGKB | MPL 2.0 (도구) | 🟢 file-level copyleft만 (subprocess OK) | content는 CC, REST API 사용 시 무관 |
| CPIC | CC-BY-SA 4.0 (guideline) | 🟢 (share-alike, hexa-lang stdlib 도 OSS 면 호환) | derivative 도 SA 의무 |
| PharmVar | "free" (academic) | 🟡 commercial 사용 시 contact 필요 | terms 명시 부재 |
| DPWG | free guideline | 🟢 | scraping 시 robots.txt 확인 |
| ClinPGx | CC | 🟢 | PharmGKB와 동일 정책 |

→ hexa-lang 본체가 MIT/Apache 2.0 이라면 CC-BY-SA 의 share-alike 가 derived stdlib 모듈에 미치는 영향 = OSS 라면 무해, 그러나 향후 commercial fork 시 주의.

---

## §6. ⚪ SPECULATION-FENCED

- ClinPGx 의 정확한 launch 일자 (2023 추정) · governance 구조
- DPWG 의 next 2026 업데이트 일정
- PharmVar API 의 rate-limit · authentication 요구사항
- 한국 HIRA CYP2C19 검사 수가 코드 (실제 청구 가능 여부)

---

## §7. 핵심 통찰 (2 bullets)

- **5 SSOT 의 권고가 PM/IM 회피로 수렴 — 그러나 한국 분기 (prasug 5mg) 는 cross-reference 부재** — M7 cube 의 한국화 (한국 5mg PRASFIT) 는 글로벌 SSOT 어디에도 등재 안 됨. hexa atlas 에 `K=P` `id=KR.CYP2C19.PRASFIT.prasug5mg` 신설하여 한국 사례 SSOT 를 hexa-lang 이 호스팅하는 게 evidence completeness.
- **PharmGKB + CPIC REST API 만으로 M7 cube 27-cell 의 ground-truth recoverability ≈ 100%** — DPWG/ClinPGx 는 cross-ref 만 필요, PharmVar 는 caller layer (B) 에 위임 가능. 즉 SSOT layer 의 hexa absorption 우선순위는 **PharmGKB > CPIC > 나머지 3**.

---

## §8. cross-reference

- PMID/PMC: PMC9287492 (CPIC 2022 CYP2C19 clopidogrel update) · PMC7769975 (PharmVar GeneFocus CYP2C19)
- M7 매핑: `/Users/ghost/core/demiurge/DAPTPGX/M7_map.md` §3 (deep-dive cell의 RCT 인용)
- atlas K-prefix: `P` (pharmacogenomics)
