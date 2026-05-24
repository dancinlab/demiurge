---
title: hexa atlas — PGx atom 등록 promoter 버그 + K-kind 의미 명시
target_repo: hexa-lang
target_kind: atlas-spec-extension (promoter parser 수정 + 9개 K kind documentation)
status: open
source: demiurge/DAPTPGX V2 formal-identity push
created: 2026-05-24
related: [[hexa-lang-stdlib-bio-stats]]
---

# §0. 한 줄 요약

`hexa atlas append-witness --kind P --id <id> --raw '<body>' --dir /tmp/...` 는 정상 staging shard를 만들지만, 후속 `hexa atlas pr --staging <file>` 가 **0 promoted (seen=0 new=0 merged=0)** — promoter parser가 `append-witness` emitter format을 인식 못함. 동일 증상이 `n6/atlas.append.witness-*.n6` (기존 landed shard) 들에도 재현 → DAPTPGX V2 시도 4개 staged shard가 atlas binary로 흡수 못 됨 → `hexa verify CYP2C19.kor.PM.freq` 가 🟠 INSUFFICIENT 잔류.

---

# §1. 재현 증상

```bash
# step 1 — staging shard 생성 OK
$ hexa atlas append-witness --kind P --id CYP2C19.kor.PM.freq \
    --raw '0.1521 = (0.31 + 0.08)^2 — Hardy-Weinberg closed-form' \
    --dir /tmp/daptpgx-staging
/tmp/daptpgx-staging/atlas.append.witness-1779575080000-CYP2C19-kor-PM-freq.n6

# step 2 — shard content 정상
$ cat /tmp/daptpgx-staging/atlas.append.witness-*-CYP2C19-kor-PM-freq.n6
// witness shard — hexa atlas append-witness
// emitter: manual
// kind: P
// id: CYP2C19.kor.PM.freq
// timestamp_ms: 1779575080000

@P CYP2C19.kor.PM.freq
  "0.1521 = (0.31 + 0.08)^2 — Hardy-Weinberg closed-form"

// EOF — hexa atlas append-witness

# step 3 — promoter 0 parse
$ cd ~/core/hexa-lang && hexa atlas pr --staging /tmp/daptpgx-staging/atlas.append.witness-*-CYP2C19-kor-PM-freq.n6
promote_to_atlas: seen=0 new=0 merged=0 rejected=0
promote_to_atlas: manifest=/tmp/_promote_manifest.2026-05-23.txt
hexa atlas pr: nothing promoted — no append shard at ./atlas.append.2026-05-23.n6
  (the staging file produced 0 new/merged nodes; see the promote manifest above).

# step 4 — round-trip verify 도 fail
$ hexa verify CYP2C19.kor.PM.freq
verify CYP2C19.kor.PM.freq
  tier   = 🟠 INSUFFICIENT
  reason = binary built-in atlas (dist/atlas.hxc) empty/absent
```

→ **하지만 동일 promoter가 기존 landed shard (`n6/atlas.append.witness-1779574445000-ivw-lpa-burgess2018.n6`) 에도 0 promoted 반환** — `append-witness` emitter가 만든 모든 shard가 promote 못 됨. 다른 emitter (예: anima-historical-absorption)가 만든 shard만 promote 성공해온 듯.

---

# §2. 근본 원인 후보 (1-3)

1. **promoter expected format mismatch** — `tool/atlas_cli.hexa pr --staging` 의 promote_to_atlas 함수가 기대하는 shard format이 `append-witness` emitter format과 다름. `append-witness` 가 만든 `@P <id>\n  "<raw>"` 형태를 promoter가 partial parse → 0 proposals.
2. **default --dir vs --staging flag 불일치** — `append-witness --dir /tmp/...` 가 staging shard를 임의 경로에 두지만, `atlas pr` 는 `./atlas.append.<date>.n6` 만 인식 (manifest의 "no append shard at ./atlas.append.2026-05-23.n6").
3. **embedded.gen.hexa 의존** — `register --from-verify` 는 directly compiler/atlas/embedded.gen.hexa 를 수정하지만, `append-witness` shard는 별도 promote 단계 필요. 두 path가 sync 안 됨.

---

# §3. 권장 fix

### §3.1 `atlas pr --staging` 가 임의 경로 shard 를 직접 promote

```hexa
fn cmd_pr_staging(staging_path: str) {
    // 현: ./atlas.append.<date>.n6 만 인식
    // 제안: --staging <file> 로 받은 임의 .n6 path 직접 parse + promote
    let shard = parse_n6(staging_path)
    if shard.is_witness_format() {
        promote_witness_shard(shard) // ← append-witness 의 @P/L/F 1-line format
    } else if shard.is_dated_append_format() {
        promote_dated_append(shard)   // ← anima-historical-absorption 등 기존 format
    }
}
```

### §3.2 promoter parser에 witness format 추가

`append-witness` 가 만든 minimal format:
```
@<K> <id>
  "<raw single line>"
```

이를 1 proposal로 parse — kind / id / raw / timestamp_ms (comment) 4-tuple 으로 절단.

### §3.3 9개 K kind documentation

현 stats 출력 (P/C/L/E/F/R/S/X/Q) 중 spec 문서가 partial. 각 kind의 의도된 semantic 명시:

| K | name | example |
|---|---|---|
| P | primitive | particle/物質的 basic constants |
| C | constant | measured numerical constants (NHIS price, drug catalog) |
| L | law | conservation/identity laws (HW, ICER sign) |
| E | experiment | RCT, lab measurement |
| F | formula | derived closed-form (HW phenotype freq) |
| R | relation | cross-domain mapping |
| S | symmetry | group-theoretic invariants |
| X | crossing | tool reference (PyPGx/PharmCAT 등) |
| Q | open question | undecidable/forward |

→ DAPTPGX inbox/notes/daptpgx-cyp-callers.md 의 `--kind X` (tool ref) 가 `append-witness --kind X` 미지원 (only P|C|L|E)인 게 명세 vs impl 갭. `--kind X|F|R|S|Q` 도 enable 필요.

---

# §4. DAPTPGX 의 4 staged shard (본 patch 흡수 시 promote 대상)

```
/tmp/daptpgx-staging/atlas.append.witness-1779575080000-CYP2C19-kor-PM-freq.n6              (P)
/tmp/daptpgx-staging/atlas.append.witness-1779575093000-CYP2C19-kor-IM_plus_PM-freq.n6      (P)
/tmp/daptpgx-staging/atlas.append.witness-1779575093000-CYP2C19-kor-diplotype-star2_star2-freq.n6  (P)
/tmp/daptpgx-staging/atlas.append.witness-1779575093000-HardyWeinberg-identity-binomial.n6  (L)
```

→ promoter fix 이후 `cd ~/core/hexa-lang && hexa atlas pr --staging /tmp/daptpgx-staging/<shard>.n6` 가 1 proposal seen → 1 promoted → binary 흡수 → `hexa verify CYP2C19.kor.PM.freq` 가 🔵 SUPPORTED-FORMAL 반환 예상.

---

# §5. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 증상 재현 | 🟢 SUPPORTED-NUMERICAL | stdout VERBATIM (§1) |
| 원인 후보 1-3 | 🟠 DEFERRED | promoter source 코드 grep 필요 |
| `--kind X|F|R|S|Q` 미지원 | 🟢 | `--help` VERBATIM ("--kind <P|C|L|E>") |
| 흡수 후 효과 | 🟢 | 4 shard → 4 atom round-trip 🔵 (예상) |

---

# §6. 후속

- 본 patch 흡수 후 `/tmp/daptpgx-staging/*.n6` 4개를 hexa-lang PR 로 promote → DAPTPGX V4 ledger의 🔵 카운트 0 → 4 escalation
- HERPES · LPA · 다른 약물-유전자 도메인의 PGx atom 도 동일 흡수 path
- `--kind X` (tool ref) enable 시 `daptpgx-cyp-callers.md` 의 5 caller (PyPGx · PharmCAT · Aldy · Stargazer · ursaPGx) 도 atlas X-kind atom으로 등록 가능
