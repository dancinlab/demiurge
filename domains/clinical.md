# domain — clinical (human drug development · trials · pharmacogenomics)

> Status: 신규 도메인 (2026-05-25 · CLI+COCKPIT cross-domain induce).
> Boundary: human clinical surface (in-silico ceiling · wet-lab/RCT mandatory).
> Pipeline = 7-verb spine. Substrate SSOT: UPPERCASE.md at repo root
> (`NOREFLOW.md · ISR.md · DAPTPGX.md · LPA.md · TTR.md · TTR-CREAM.md
> TTR-MN.md · HERPES.md`) managed by domain skill.

**Substrate** (where the verb-cells run): demiurge own + UPPERCASE.md +
`<DOMAIN>/Mx_*.md` per-milestone artefacts. No separate `hexa-clinical/`
sibling repo (clinical work is inherently demiurge design-doc surface +
hexa-lang verify/atlas for formal checks).

## 1. Members (current snapshot 2026-05-25)

| domain | @goal short | status | tier-A 산출 |
|---|---|---|---|
| **ISR** | in-stent restenosis · 비-mTOR 후보 short-list + DCB/BRS | M1-M8 ✅ · R1-R3 ✅ · V1 ✅ · V2-V4 in progress | biolimus+fasudil dual-DCB 80.5/100 · IIT-1 fasudil-DCB FIH (n=60) |
| **NOREFLOW** | PCI no-reflow / slow-flow · IRI 보호 + MVO 후보 | M1-M12 + V1-V4 ✅ | Tier-A 3약물 · NICORADENO-MVO IIT |
| **DAPTPGX** | CYP2C19 한국인 LoF DAPT 맞춤 | M1-M11 ✅ · V1-V4 in progress | 한국인 LoF 60% · prasugrel/ticagrelor escalation |
| **LPA** | Lp(a) 잔여 위험 · siRNA/ASO short-list | M1-M8 + R1-R3 + S1-S3 + V1 ✅ | pelacarsen · olpasiran · zerlasiran |
| **TTR** | 타투제거 (base + cream + microneedle) | M1-M10 + V1-V4 in progress | dissolving MN 우승 · cream wall 정직 |
| **TTR-CREAM** | rub-on cream OTC-grade | M1-M9 in progress | SC barrier breakthrough 3-path |
| **TTR-MN** | dissolving microneedle patch | M1-M9 + measured-oracle ✅ | FDA combination product |
| **HERPES** | HSV-1/2 sterilizing cure | M1-M10 + V1-V3 ✅ | CRISPR · block-and-lock · mRNA vaccine combo |

## 2. 7-verb cell 매핑

| verb | cell 내용 | 산출 위치 |
|---|---|---|
| specify | UPPERCASE.md @goal + milestone scaffold | repo root |
| structure | V1 claim inventory + tier triage (🔵/🟢/🟡/🟠) | `<DOMAIN>/verify/V1_*.md` |
| design | M3 표적 + M4 후보 short-list | `<DOMAIN>/M3_*.md` · M4 |
| analyze ⟲ | R1 arxiv · R2 regulatory · R3 libraries · `/gap` sweep | `<DOMAIN>/research/*.md` |
| synthesize | V3 numerical (demiurge 자산 — pool · cloud) | `<DOMAIN>/verify/V3_*.md` |
| verify | V2 🔵 closed-form (hexa verify --expr) + V4 ledger | `<DOMAIN>/verify/V2_*.md` · V4 |
| handoff | 한국 발 IIT protocol + cross-domain feed | `<DOMAIN>/M8_rank.md` |

## 3. Honest ceiling

- in-silico **PASS ≠ wet-lab evidence** — V1-V3 모두 demiurge-grade attestation.
- absorbed=true는 사람-임상 measured-oracle PASS 시만 가능 (FDA IND/IDE PMA · MFDS approval · ESC/AHA Class I guideline · KCSC concord).
- 75% 의 claim 은 본질적으로 🟡 SUPPORTED-BY-CITATION (RCT primary data 비재현) — honest floor.
- 25% 만 🔵/🟢 가능: bio-physical math (PK/PD · diffusion · electrochem · receptor binding · stat identities · classification combinatorial).

## 4. 현재 wall + breakthrough paths (per @D d2)

| wall | scope | breakthrough path |
|---|---|---|
| `hexa verify --expr` bio kernel 부재 | 6 도메인 × 5-15 identity ≈ 50-90 🔵 lock | `hexa-lang/inbox/patches/bio-verify-kernel-extension-2026-05-25.md` |
| `pool list` compile error | demiurge cli M5 surface | `hexa-lang/inbox/patches/pool-cli-compile-errors-2026-05-25.md` |
| clinical RCT primary data 비재현 | 모든 도메인 75% 🟡 floor | not a wall — honest floor (per d6 first-principles 한계 + d1 wet-lab 정의) |
| 한국인 IIT funding/site coordination | ISR-1 · NOREFLOW Trial-A · HERPES sterilizing | KCSC consortium + MFDS 협력 (M8 handoff packet에 명시) |

## 5. Cross-domain cross-feed map

```
DAPTPGX (CYP2C19 LoF)  ───→  ISR IIT-3 (DAPT arm 설계 입력)
LPA (Lp(a) ranking)    ───→  ISR IIT-3 (systemic adjunct arm)
NOREFLOW (3약물 rank)  ───→  ISR M5 (DCB combo with adenosine/nicorandil)
ISR (DCB carrier)      ───→  TTR-MN (polymer dissolution patterns)
HERPES (CRISPR off-target) ───→  ISR (M3 gene-therapy 잠재 표적)
TTR-MN (FDA combination) ───→  ISR DCB (regulatory pathway template)
```

## 6. Demiurge CLI integration

`demiurge cli action <verb> clinical` 으로 6 멤버 도메인 일괄 dispatch (cellrun
표준 dispatch + honest-skip for wet-lab cells). 개별 도메인 dispatch는
UPPERCASE.md 직접 편집 + `/cycle` skill 으로 진행.

본 도메인 등록은 [[CLI+COCKPIT]] M3 (design surface) + M7 (handoff surface)
의 upstream 기여로 induce — `demiurge cli list-domains` 가 clinical 인식.
