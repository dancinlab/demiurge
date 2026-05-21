# 2026-05-22 — R4 Stage 3 audit hook landed (audit_attestation_records.sh)

constitution.md v1.4.0 R4 invariant 의 Stage 3 enforcement vehicle 안착.

## Pipeline

| Stage | Vehicle | 작동 시점 |
|---|---|---|
| Stage 1 | Swift Codable `MaterialAttestationRecord` (`init(from:)` decoder reject) | decode time (cockpit 실행) |
| Stage 2 | `PAPERS/_tools/check_rtsc_claim.sh` (Makefile prerequisite) | paper compile time |
| **Stage 3** | **`PAPERS/_tools/audit_attestation_records.sh`** | exports 전수 scan (CI 또는 manual) |

## 산출물

- **`PAPERS/_tools/audit_attestation_records.sh`** (323 lines)
  - bash + embedded python3
  - 3-class verdicts: `ok` · `historical` (pre-2026-05-22 audit evidence) · `violation` (R4 Pattern 1)
  - 4 exit codes: 0=clean · 1=violation · 2=missing matrix · 3=missing exports
  - flags: `--json` (machine-readable) · `--strict` (exit non-zero on any violation)
- **`PAPERS/_test_fixtures/audit_test/`** 4 fixtures
  - `historical_pattern1.json` → verdict=historical ✓
  - `legitimate_lts.json` → verdict=ok ✓
  - `new_violation_synthetic.json` → verdict=violation ✓
  - `all_pass_legitimate.json` → verdict=ok (5/5 ALL_PASS legitimate) ✓

## Verify run

```bash
$ bash PAPERS/_tools/audit_attestation_records.sh exports/material_attestation/
[audit_attestation] scan-dir: exports/material_attestation
[audit_attestation] RTSC.md §8.9 matrix: 2026-05-21T17:35:16.552157+00:00
[audit_attestation] per-record verdicts:
  [ok        ] nb_bcs_v1/lts_attestation_nb_bcs_20260521T162859Z.json — domain=lts absorbed=True (R4 N/A)
  [historical] nb_bcs_v1/rtsc_attestation_nb_bcs_20260521T111656Z.json — pre-R4 historical (stamp_ymd=20260521 < 20260522); no rtsc_5_gate_evaluation field
[audit_attestation] summary: 1 ok · 1 historical · 0 violations
```

→ live audit: **0 violations**, 1 historical (intentional Pattern 1 evidence), 1 legitimate LTS (Path B migration result).

```bash
$ bash PAPERS/_tools/audit_attestation_records.sh PAPERS/_test_fixtures/audit_test/
[audit_attestation] per-record verdicts:
  [ok        ] all_pass_legitimate.json — domain=rtsc absorbed=true aggregate=ALL_PASS (legitimate)
  [historical] historical_pattern1.json — pre-R4 historical (stamp_ymd=20260521 < 20260522); no rtsc_5_gate_evaluation field
  [ok        ] legitimate_lts.json — domain=lts absorbed=True (R4 N/A)
  [violation ] new_violation_synthetic.json — missing rtsc_5_gate_evaluation
[audit_attestation] summary: 2 ok · 1 historical · 1 violations
```

→ 4/4 expected verdicts.

## R4 invariant 보호 — 3-stage coverage 완성

| 위반 시점 | 어디서 잡힘 |
|---|---|
| record 생성 시 (Swift cockpit consumer) | Stage 1 Codable reject |
| paper 빌드 시 ("RTSC absorbed=true" 문구) | Stage 2 check_rtsc_claim.sh |
| exports 누적 후 (CI / 수시 audit) | **Stage 3 audit_attestation_records.sh** |

→ Pattern 1 (namespace exploit) + Pattern 2 (goal abandonment) 둘 다 어느 stage 든 자동 감지.

## Constitution Stage 3 LANDED edit (deferred)

constitution.md 가 origin/main 에서 project.tape session 에 의해 제거됨 (user "수작업 예정") — Stage 3 LANDED row 의 doctrinal location 미정.

본 inbox 노트가 *narrative anchor* 로 임시 SSOT 역할. constitution.md 복구 시 다음 row 추가 권장:

```markdown
- **Stage 3 (live audit)**: `PAPERS/_tools/audit_attestation_records.sh` (LANDED 2026-05-22).
  scans `exports/material_attestation/` for R4 invariant violations.
  3-class verdicts: ok / historical / violation. Test fixtures at
  `PAPERS/_test_fixtures/audit_test/`.
```

## Cross-reference

- constitution.md v1.4.0 R4 (project.tape session 에 의해 origin 제거 · 별 보관)
- `cockpit/Sources/DemiurgeCore/Models/MaterialAttestationRecord.swift` (Stage 1)
- `PAPERS/_tools/check_rtsc_claim.sh` (Stage 2)
- `PAPERS/_tools/audit_attestation_records.sh` (Stage 3 · 본 노트)
- `inbox/notes/2026-05-21-r4-stage1-enforcement.md` (Stage 1 migration plan)
- RTSC.md §8.9 (5-criteria gate · SOLE 정의) · §8.10 (Nb honest correction)
