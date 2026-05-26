# M7 handoff — handoff packet emitter (next-stage 입력)

> 7-verb pipeline의 마지막 verb. handoff = verify 통과 산출을 다음 stage repo의 SSOT로 전달.
> per @D d3 (impl code → canonical home) + d9 (sequential commit on main).

## 1. 7-verb pipeline 위치

```
spec → structure → design → analyze ⟲ → synthesize → verify → [HANDOFF]
                                                                    ↑
                                                                 M7 (본 문서)
```

handoff 입력 = verify의 verdict-attached 산출. 출력 = (a) cross-project inbox patch (b) atlas register shard (c) PR-only landing.

## 2. handoff 채널 (3 routes)

```
                  verified artifact
                        │
        ┌───────────────┼───────────────────┐
        ▼               ▼                   ▼
  inbox handoff   atlas register        PR landing
  (cross-project) (P-kind atom)        (canonical SSOT)
        │               │                   │
        ▼               ▼                   ▼
  archive/session-notes/    atlas append-witness   gh pr create
  archive/session-notes/patches/  + verify <id>          --base <previous-layer>
        │               │                   │
        ▼               ▼                   ▼
  target_repo:    atlas growth          stacked PR per g4
  hexa-lang etc.   (verified eq         (≤200 lines · 1 logical)
                    tape 흡수)
```

## 3. CLI 명령 패턴

| handoff 유형 | 명령 |
|---|---|
| inbox note (idea/design) | `cp archive/session-notes/<slug>.md ~/core/<target>/inbox/notes/<slug>-<date>.md` |
| inbox patch (code/spec) | `cp archive/session-notes/patches/<slug>.md ~/core/<target>/inbox/patches/<slug>-<date>.md` |
| atlas atom register | `hexa atlas append-witness --kind P --id <id> --from-file <shard.n6>` |
| PR landing (stacked) | `gh pr create --base <previous-layer> --title "<terse>" --body "<HEREDOC>"` |
| atlas PR | `hexa atlas pr --staging <file.n6>` |

## 4. 살아있는 사례 ① — DAPTPGX M11 inbox (PGx 도구 인벤토리)

**input**: 6 inbox notes (PGx libraries / databases / callers / CDS / POC / NGS)

**handoff route**: cross-project to hexa-lang
```bash
ls /Users/ghost/core/demiurge/archive/session-notes/daptpgx-pgx-*.md
# → 6 notes 작성 (M11 agent)
```

**frontmatter convention** (PR-only landing 기다리며):
```yaml
---
title: <한글 제목>
target_repo: hexa-lang
target_kind: stdlib-wrapper (또는 atlas-ssot-registration · cds-integration · hw-ref)
status: open    # open / absorbed / superseded
source: demiurge/DAPTPGX (M11)
created: 2026-05-24
---
```

cockpit display: `target_repo` + `status` 필드를 dashboard에 표시 — 어느 노트가 absorb 대기 중인지 즉각 파악.

## 5. 살아있는 사례 ② — DAPTPGX V2 inbox patches (toolchain extension)

**input**: 2 inbox patches
- `hexa-lang-stdlib-bio-stats.md` (Hardy-Weinberg / Wilson / Markov 함수 추가 request)
- `hexa-atlas-pgx-kind-extension.md` (P-kind PGx atom 등록 spec)

**handoff route**: cross-project to hexa-lang (CLI 실제 실행):
```bash
cp /Users/ghost/core/demiurge/archive/session-notes/patches/hexa-lang-stdlib-bio-stats.md \
   ~/core/hexa-lang/inbox/patches/daptpgx-stdlib-bio-stats-2026-05-25.md
cp /Users/ghost/core/demiurge/archive/session-notes/patches/hexa-atlas-pgx-kind-extension.md \
   ~/core/hexa-lang/inbox/patches/daptpgx-atlas-pgx-kind-2026-05-25.md
ls ~/core/hexa-lang/inbox/patches/daptpgx-*
# → 2 patches landed in hexa-lang/inbox/patches/
```

**효과**: hexa-lang 측에서 absorb 사이클 통과 시 → V2-bis 라운드 trigger → V2 staged 4 shards 🔵 promote 가능.

## 6. 살아있는 사례 ③ — DAPTPGX atlas register (handoff to atlas SSOT)

**input**: 4 staged shards `/tmp/daptpgx-staging/atlas.append.witness-*.n6`

**handoff route**: hexa atlas append-witness + verify round-trip
```bash
hexa atlas append-witness --kind P --id CYP2C19.kor.PM.freq --from-file <shard>
hexa verify CYP2C19.kor.PM.freq    # round-trip → 🔵
```

**현 상태**: blocked (promoter 0-proposal bug per V2 §3-4) → staged 유지. hexa-lang `daptpgx-atlas-pgx-kind-2026-05-25.md` patch 흡수 후 unblock.

## 7. handoff packet 표준 형식

```yaml
# handoff_packet.yaml — M7 emitter output (proposed standard)
source:
  domain: DAPTPGX
  repo: demiurge
  pipeline_stage: verify
  verify_session_id: <commit-sha>
artifact:
  type: inbox-note | inbox-patch | atlas-shard | stacked-pr
  path: <abs-path>
  tier: 🔵 | 🟢 | 🟡 | 🟠 | ⚪ | 🔴
  verbatim: <stdout-of-hexa-verify>
target:
  repo: hexa-lang | atlas | <sibling>
  kind: stdlib-wrapper | atlas-ssot | cds-integration | hw-ref | code
  status: open | absorbed | superseded
trace:
  parent_verify: V1 | V2 | V3 | V3.5 | V4
  related: [<other-packet-ids>]
```

## 8. d9 commit discipline (handoff 부수효과)

- handoff는 multi-file 산출 — **explicit file list로만 stage**
- 다른 도메인 concurrent agent의 index 누출 회피 위해 `git add <file1> <file2> ...` 명시
- `git add -A` / `git add .` 금지
- log entry는 도메인 sister log 파일에 newest-on-top

## 9. cockpit 패널 spec

```
┌────────────────────────────────────────────────────────────┐
│ M7 handoff panel                                            │
├────────────────────────────────────────────────────────────┤
│ Verified artifact: V3_numerical_recompute.md (tier 🟢)     │
│ Route options:                                              │
│   [ ] inbox note → hexa-lang/inbox/notes/                   │
│   [x] inbox patch → hexa-lang/inbox/patches/                │
│   [ ] atlas shard → /tmp/staging/                           │
│   [ ] stacked PR → gh pr create --base <prev>               │
│ Target status: 2 absorbed · 4 open · 0 superseded           │
│ Last handoff: 5 min ago (V2 patches → hexa-lang)            │
└────────────────────────────────────────────────────────────┘
```

cockpit 책무:
- handoff packet 표준화 (§7 yaml 자동 emit)
- target repo absorb 상태 polling + dashboard
- staged shard 모니터링 (atlas promoter health)
- PR-only landing 검증 (atlas는 `--auto-pr` per @D g_atlas_binary_builtin)

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| §4 M11 inbox 6 notes | 🟡 SUPPORTED-BY-CITATION | DAPTPGX M11 본문 |
| §5 V2 inbox patches 2 cp 실행 | 🟢 SUPPORTED-NUMERICAL | `cp` + `ls ~/core/hexa-lang/inbox/patches/daptpgx-*` 직접 확인 |
| §6 atlas register staged | 🟠 INSUFFICIENT (promoter bug) | DAPTPGX V2 §3-4 stdout verbatim |
| §7 packet yaml spec | 🟠 INSUFFICIENT (제안 단계) | 디자인 spec, 구현 미완 |

## 11. 핵심 통찰

- **3-channel handoff (inbox / atlas / PR) = SSOT 일관성 보존 mechanism** — cross-project 변화는 cp/append-witness/PR을 통해서만, 직접 cross-repo 편집 금지.
- **inbox patch는 demiurge cli upstream cycle의 1st-class artifact** — V2 patches 2개가 cp 한 줄로 hexa-lang에 land. 그 후 hexa-lang 측에서 absorb → demiurge V2-bis 자동 trigger 가능 (양방향 cycle).
- **promoter health = handoff의 hidden gate** — atlas append-witness 자체가 syntactic 성공해도 promoter가 0-proposal로 reject 시 atom unregistered. cockpit이 promoter 상태 모니터링 필수.
- **packet yaml 표준화가 미래 cockpit core** — §7 spec이 채택되면 cockpit dashboard가 모든 cross-project handoff를 통일 view로 표시.
- **stacked PR 규율 (g4)** — handoff 산출이 1 PR (< 200 lines · 1 logical)로 분할 — cockpit이 PR base 선택 + size 경고 + 1-logical 검증.
