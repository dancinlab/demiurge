# M3 — `design` verb · CLI + cockpit 등가 surface 설계

> 마일스톤 M3 산출물 · current-state · no history.
> CLI+COCKPIT domain · 7-verb pipeline 의 세 번째 verb `design` 을 양 surface (CLI · cockpit TUI) 에서 동일 입력 → 동일 출력 보장하는 설계.
> @D d3 — implementation 은 hexa-lang 에 거주, 본 문서는 설계 only.
> @D d4 — single generic dispatch · 도메인 hardcoding 없음 · structure packet 으로부터 generic design body attach.

---

## 1. 개요

`design` verb = 7-verb pipeline 의 3단계. M2 의 `structure.packet.json` 을 입력으로 받아 각 milestone node 에 **(a) `design.md` SSOT 의 D-number reservation** + **(b) design body (markdown 본문)** + **(c) rationale / tradeoff (Pat/Anti)** 를 attach 한 `design.packet.json` 을 산출 → 다음 verb (`analyze`) 로 인계.

```
spec → structure → [DESIGN] → analyze ⟲ → synthesize → verify → handoff
                       ↑
                    M3 (본 문서)
```

핵심 명제: structure packet 의 `nodes[]` (milestone kind) + `edges[]` 만으로 **generic** 하게 design body 슬롯 + D-number reservation slot 을 생성 (도메인 분기 X · @D d4). D-number 실제 값은 demiurge SSOT (`DESIGN.log.md`) grep 으로 cascade-safely 획득.

---

## 2. 입력 — M2 structure packet 매핑

`design` verb 가 structure packet 에서 읽는 필드:

| structure packet 필드 | design 사용처 | 변환 규칙 |
|---|---|---|
| `domain` | `design.packet.domain` | 그대로 carry (identity) |
| `nodes[]` (kind=`milestone`) | `design_bodies[]` row 1개씩 | 각 milestone → 1 design body slot (id + reserved_d_number + body + rationale) |
| `nodes[].id` / `.label` / `.state` | design body header | `## D### — <label>` 생성 시 사용 |
| `edges[]` (rel=`depends_on`) | tradeoff `Anti` 후보 hint | upstream dependency = anti-pattern fallback 시 영향 표면화 |
| `edges[].governance_ref` | rationale 의 governance citation | `@D <id>` 인용 자동 부착 |
| `scale_layers[]` | design body 의 scale 컨텍스트 라인 | 각 body 머리에 `scale: <layer>` 메타 |
| `provenance.input_hash` | `design.packet.provenance.parent_hash` | 추적성 — 동일 structure → 동일 design |
| `next_verb` | reject if ≠ `"design"` | pipeline 위치 mismatch 차단 |

검증 규칙:
- structure packet 의 `next_verb` 가 `"design"` 가 아니면 reject (pipeline 위치 mismatch).
- `schema_version` 이 미지원 → reject (forward-compat 명시).
- `nodes[]` 에 `kind="milestone"` 이 0개 → reject (design 대상 0 · M2 에서 이미 막혔어야 함 · double gate).

---

## 3. 출력 — `design.packet.json` 스키마

### 3.1 JSON shape

```json
{
  "schema_version": "1.0",
  "verb": "design",
  "domain": "CLI+COCKPIT",
  "goal": "drive demiurge 7-verb pipeline across CLI + cockpit TUI equivalently",
  "claimed_d_numbers": {
    "ssot_path": "DESIGN.log.md",
    "grep_at": "2026-05-24T12:10:00Z",
    "ssot_max_at_grep": 122,
    "reservation_strategy": "ssot_max + 1 .. ssot_max + N (tentative · race-resolved at PR-land)",
    "tentative_block": {"first": 123, "last": 129, "count": 7},
    "binding": "tentative",
    "cascade_note": "actual numbers may shift if concurrent agent lands a Decision block first; final binding via PR-land race"
  },
  "design_bodies": [
    {
      "node_id": "M1",
      "reserved_d_number": "D123",
      "scale": "component",
      "title": "spec verb 양 surface 설계",
      "body_md": "<markdown body — purpose · contract · two-surface mapping · acceptance>",
      "rationale": {
        "pat": ["spec packet 의 7 field 가 두 surface 모두 동일 normalize 후 blake3 hash 등가"],
        "anti": ["surface 별 별도 packet schema → 등가성 검증 불가 (per @D d4 위반)"]
      },
      "governance_refs": ["@D d3", "@D d4"]
    }
  ],
  "tradeoffs_global": [
    {"pat": "single generic dispatch (one derive_design fn)", "anti": "per-surface design emitter (분기 코드 폭증)"}
  ],
  "provenance": {
    "surface": "cli | cockpit",
    "invoked_at": "2026-05-24T12:10:00Z",
    "operator": "mk55992@proton.me",
    "parent_hash": "blake3:<structure.input_hash>",
    "input_hash":  "blake3:<canonical(this packet sans surface, sans cockpit-local annotations)>"
  },
  "next_verb": "analyze"
}
```

### 3.2 필드 명세

| 필드 | 타입 | 설명 |
|---|---|---|
| `claimed_d_numbers.ssot_path` | string | demiurge D-number SSOT (`DESIGN.log.md`) 위치 |
| `claimed_d_numbers.grep_at` | ISO-8601 | grep 수행 시각 — race window 측정 |
| `claimed_d_numbers.ssot_max_at_grep` | int | grep 시점의 SSOT 최대 Decision N (예: 122) |
| `claimed_d_numbers.tentative_block` | `{first, last, count}` | tentative 예약 구간 (= ssot_max+1 .. ssot_max+count) |
| `claimed_d_numbers.binding` | enum | `tentative` (PR-land 전) · `bound` (PR merge 후 ssot 와 일치 확인) |
| `design_bodies[].node_id` | string | structure packet `nodes[].id` (예: `M1`) |
| `design_bodies[].reserved_d_number` | `D\d{3}` | tentative reservation — DESIGN.log.md PR-land 시점에 실제 binding |
| `design_bodies[].body_md` | markdown string | milestone 별 design 본문 (purpose · contract · acceptance) |
| `design_bodies[].rationale.pat` / `.anti` | list\<string\> | 채택 (Pat) / 거부 (Anti) 사유 — 각 ≥ 1 row 권장 |
| `design_bodies[].governance_refs` | list\<`@D <id>`\> | 인용 governance rule id |
| `tradeoffs_global[]` | list | packet 단위 design 차원 tradeoff (per-body tradeoff 와 별도) |
| `next_verb` | const `"analyze"` | pipeline 다음 hint |

### 3.3 cockpit-local annotation firewall

cockpit 의 panel-local UI state 는 **packet 외부** 로 격리:

| cockpit-local annotation | 보관 위치 | packet 영향 |
|---|---|---|
| design body editor 의 expand/collapse | cockpit session state | ❌ (view-only) |
| cursor / 선택된 body row | cockpit session state | ❌ (view-only) |
| `claimed_d_numbers` 상태 패널 색상 (warn/ok) | cockpit session state | ❌ (view-only) |
| 미리보기 markdown 렌더 (heading 접기 등) | cockpit session state | ❌ (view-only) |

`provenance.input_hash` 산정 시 `canonical(packet sans surface, sans cockpit-local annotations)` — 즉 cockpit-local 이 packet 에 1바이트라도 leak 되면 등가성 PASS 불가 → 명시적 firewall (M2 §6.3 mirror).

### 3.4 representation 선택 근거 (Occam · @D g0)

| 후보 | 채택 여부 | 사유 |
|---|---|---|
| **design_bodies[] (list of dict) + claimed_d_numbers block** | ✅ | structure.nodes[] 와 1:1 평행 · D-number 예약 메타 분리 · diff-able |
| design body 를 structure.nodes[] 에 inline mutate | ❌ | structure packet 불변성 깨짐 · pipeline 추적성 손실 (parent_hash chain break) |
| D-number 를 design body 본문 markdown 내부에만 매장 | ❌ | grep 불가 · cascade-safety 메타 (`grep_at`, `binding`) 둘 곳 없음 |
| 별도 `d_number_reservation.json` 파일 분리 | ❌ | packet 다중-blob → pipe handoff (`--stdout`) 깨짐 · @D g0 (Occam) 위반 |

→ **single JSON blob 안에 `claimed_d_numbers` (예약 메타) + `design_bodies[]` (body+rationale)** 가 최소 충분.

---

## 4. CLI 시그니처

```
hexa design [<DOMAIN>] \
  [--in <structure.packet.json> | --stdin] \
  [--ssot-design-log <path>] \
  [--reserve <N> | --reserve-from-structure] \
  [--body-template <path>] \
  [--render bodies|reservation|json] \
  [--out <path>.json | --stdout] \
  [--force]
```

| 플래그 | 타입 | 필수 | 매핑 / 동작 |
|---|---|---|---|
| `<DOMAIN>` (positional) | string | optional | 명시 시 SSOT 의 `<DOMAIN>/structure.packet.json` 자동 로드 |
| `--in` | path | optional (XOR `--stdin`) | structure packet 파일 경로 |
| `--stdin` | flag | optional (XOR `--in`) | stdin 으로 structure packet JSON 수용 |
| `--ssot-design-log` | path | optional | D-number SSOT 위치 override (default = `DESIGN.log.md`) |
| `--reserve` | int | optional | 명시 N 개 reservation (default = structure 의 milestone node 수) |
| `--reserve-from-structure` | flag | optional (default 동작) | milestone node 수 = reservation 수 (1:1) |
| `--body-template` | path | optional | design body markdown 템플릿 파일 (기본 = built-in skeleton) |
| `--render` | enum | optional | 추가 시각 출력 (`bodies` = §3.1 bodies 만 · `reservation` = §3.1 D-number block 만 · `json` = packet 전체 · default = `json`) |
| `--out` | path | optional | design packet 출력 위치 (default = `<SSOT>/design.packet.json`) |
| `--stdout` | flag | optional | stdout 으로 packet 출력 (pipe handoff 용) |
| `--force` | flag | optional | 기존 `design.packet.json` 덮어쓰기 허용 |

**입력 우선순위**: `--stdin` > `--in` > `<DOMAIN>` positional auto-load. 셋 다 없으면 reject.

**D-number grep 동작**: `--ssot-design-log` 의 마지막 `### Decision N` 라인을 grep → `N+1 .. N+count` 를 `claimed_d_numbers.tentative_block` 으로 emit. binding = `tentative`. PR-land 후 별도 `hexa design bind --in <design.packet.json>` 으로 binding 갱신 (본 spec 범위 외 · 후속 verb 로 연결).

### 4.1 invocation 샘플

```
# (a) 기본 — SSOT 자동 로드 (1:1 reservation)
hexa design CLI+COCKPIT
  → reads  <SSOT>/CLI+COCKPIT/structure.packet.json
  → greps  <SSOT>/DESIGN.log.md  (latest "### Decision N")
  → writes <SSOT>/CLI+COCKPIT/design.packet.json
  → bodies render to stdout

# (b) pipe handoff (structure → design → analyze)
hexa structure CLI+COCKPIT --stdout \
  | hexa design --stdin --stdout \
  | hexa analyze --stdin

# (c) reservation only — body skeleton X
hexa design CLI+COCKPIT --render reservation --stdout
```

비-tty 환경 (script · CI) 에서는 CLI 가 default surface. cockpit 비활성 시에도 packet/render byte-identical.

---

## 5. cockpit TUI 와이어프레임

```
┌─ demiurge cockpit · verb: design ──────────────────────────────────────────┐
│ Domain: CLI+COCKPIT     structure.input_hash: blake3:7d1a…   parent ✓      │
│ SSOT: DESIGN.log.md     greppped_at: 12:10:00Z   ssot_max: 122             │
├─────────────────────────────────────────────────────────────────────────────┤
│ ┌─ Structure tree ─────────────┐  ┌─ Design body editor ─────────────────┐ │
│ │ ▾ root  drive 7-verb …       │  │ # D123 — spec verb 양 surface 설계   │ │
│ │   ▸ M1 spec      [D123]      │  │                                       │ │
│ │   • M2 structure [D124]      │  │ ## purpose                            │ │
│ │   • M3 design    [D125] ◀──  │  │ <markdown body editor>                │ │
│ │   • M4 analyze   [D126]      │  │                                       │ │
│ │   • M5 synth     [D127]      │  │ ## contract                           │ │
│ │   • M6 verify    [D128]      │  │ - input : structure.packet.json       │ │
│ │   • M7 handoff   [D129]      │  │ - output: design.packet.json          │ │
│ │ ▾ external                   │  │                                       │ │
│ │   • hexa-lang  [sibling]     │  │ ## rationale (Pat / Anti)             │ │
│ │                              │  │ Pat : single generic dispatch         │ │
│ │                              │  │ Anti: per-surface emitter             │ │
│ └──────────────────────────────┘  └───────────────────────────────────────┘ │
│                                                                             │
│ ┌─ D-number reservation 상태 ─────────────────────────────────────────────┐│
│ │ SSOT grep: ### Decision 122  (DESIGN.log.md L6336)        ⌃G re-grep    ││
│ │ Tentative block: D123 .. D129  (count=7)  binding=tentative             ││
│ │ Race window: 0:00:14 since grep   ⚠ stale > 5min: re-grep 권장          ││
│ │ Cascade check: ❌ none detected · grep 후 변동 0                        ││
│ └─────────────────────────────────────────────────────────────────────────┘│
│                                                                             │
│ [ ⌃P preview packet ] [ ⌃S emit → analyze ] [ ⌃G re-grep ] [ ⌃X cancel ]   │
└─────────────────────────────────────────────────────────────────────────────┘
 status: design.input_hash blake3:c0fe… · ready · surface=cockpit
```

키바인딩: `↑/↓` structure tree 노드 이동 · `Enter` 선택 노드의 design body editor 진입 · `⌃G` SSOT re-grep (race window 갱신) · `⌃P` packet preview (JSON) · `⌃S` 제출 (analyze verb 로 dispatch) · `⌃X` 취소.

cockpit panel 책무:
- **structure tree (left)** = M2 packet 의 milestone nodes projection + tentative D-number 라벨 부착
- **design body editor (right)** = 선택 milestone 의 markdown body 편집 (purpose · contract · rationale · acceptance)
- **D-number reservation 상태 패널 (bottom)** = grep 시각 · tentative block · race window · cascade 변동 감지

---

## 6. D-number cascade-safety

multi-agent same-day work 에서 D-number 는 **cascade-stale 위험이 매우 큰** identifier (memory note [[d_number_stale_in_handoff]]). 본 verb 의 cascade-safety mechanism:

### 6.1 SSOT 단일 원칙 (per ARCH.md §11.4)

- `DESIGN.log.md` 의 `### Decision N` 라인이 **유일한 authoritative reservation** (ARCH.md §11.4 `exit criterion: design.md D###` 형식).
- inbox notes · 본 `design.packet.json` 의 `claimed_d_numbers` 모두 **tentative** — authoritative 가 아님.
- 본 design packet 은 `binding=tentative` 로만 emit · `bound` 전환은 PR-land 후 별도 단계.

### 6.2 grep-before-assignment (cascade-safe acquisition)

```
1. hexa design 호출 시점에 `grep -nE "^### Decision [0-9]+" DESIGN.log.md | tail -1`
2. 마지막 N 추출 → `ssot_max_at_grep`
3. tentative block = (N+1) .. (N + milestone_count)
4. grep 시각 (`grep_at`) packet 에 기록 → race window 측정 가능
```

design verb 가 SSOT 를 mutate 하지 않음 — read-only grep. 실제 `### Decision N` 블록 추가는 **PR 단계** 에서만 (single-writer discipline · @D d9 mirror).

### 6.3 race window mitigation

| 위험 | 완화 |
|---|---|
| grep 후 다른 agent 가 `### Decision N+k` 를 먼저 land → tentative block 가 stale | cockpit `⌃G re-grep` · CLI `hexa design --in <existing>.json --re-grep` (별도 verb 미정 · forward-compat) |
| 같은 worktree 의 동시 design emit → 동일 tentative block 충돌 | @D d9 (sequential commit on main) 적용 — 한 번에 한 agent 의 design packet 만 stage/commit |
| PR-land 시점 ssot_max 가 tentative block 첫 번째 ≥ → shift 필요 | PR review 단계에서 D-number renumber · 본 packet 의 `binding` 은 그때까지 `tentative` 고정 |
| inbox note 가 D-number 를 "예약" 한 것처럼 기술 → 후속 agent 가 신뢰 | inbox note 는 authoritative 아님 (본 §6.1) · 본 spec 이 명시 firewall — packet `binding` 만이 단계 표식 |

### 6.4 cascade 감지 (cockpit 보조)

cockpit `D-number reservation 상태 패널` 은 `grep_at` 이후 경과 시간 표시 + 임계치 (예: 5 min) 초과 시 ⚠ re-grep 권장. CLI 는 `--re-grep` 미옵션 시 stale 가능성을 stdout warn 라인으로 표면화 (`# WARN: grep_at 5m23s ago — consider re-grep`).

---

## 7. 두 surface 등가성

### 7.1 control mapping

| cockpit 동작 | CLI flag | design packet 영향 |
|---|---|---|
| structure packet 자동 로드 (domain 컨텍스트) | `<DOMAIN>` positional 또는 `--in` | input 채널 (packet 동일) |
| `⌃G re-grep` | (없음 · CLI 는 매 호출이 fresh grep) | `claimed_d_numbers.grep_at` 갱신 |
| design body editor 입력 | `--body-template` + 표준 fill (또는 stdin 으로 미리 만든 packet 의 body_md 그대로) | `design_bodies[].body_md` |
| structure tree expand/collapse | (없음 · view-only) | — (cockpit-local) |
| design body editor expand/collapse | (없음 · view-only) | — (cockpit-local) |
| `⌃P preview packet` | `--stdout` (no write) | dry-run 동등 |
| `⌃S emit → analyze` | (default emit) | `next_verb="analyze"` dispatch |
| `--render bodies/reservation/json` | (cockpit 은 항상 모두 표시) | render 형식만 (packet 동일) |

### 7.2 등가성 보장 (single generic dispatch · @D d4)

1. 두 surface 모두 동일 `derive_design(structure_packet, ssot_grep_state) → canonical_design` 함수 거침.
2. `provenance.parent_hash = structure.provenance.input_hash` — 동일 structure → 동일 parent_hash.
3. `provenance.input_hash = blake3(canonical(design_packet sans surface, sans cockpit-local annotations))` — surface 만 다르고 hash 동일.
4. cockpit `⌃P preview` = CLI `--stdout` = 같은 JSON byte-stream (단, `grep_at` 가 동일 시각이어야 하므로 등가성 회귀 테스트는 grep_at 고정 fixture 로 수행).
5. 회귀 테스트: 동일 structure packet fixture + 동일 SSOT grep snapshot → cockpit headless run · CLI run → design packet diff = `provenance.surface` 1줄만.

### 7.3 view state 분리 원칙 (firewall 재확인)

cockpit 의 tree expand state · body editor cursor · reservation 패널 색상 · 미리보기 markdown 렌더는 모두 **packet 외부** (cockpit-local UI state). packet 에 leak 시 등가성 PASS 불가 → §3.3 firewall 강제.

---

## 8. M4 analyze ⟲ 로의 handoff

`design.packet.json` (§3 JSON) = canonical design representation. **`analyze` verb 는 동일 schema 의 design packet 을 입력으로 받아** 각 design body 의 rationale (Pat/Anti) 와 dependency edge 를 합성·반복 (`⟲`) 하여 수렴 신호 (예: contradiction 0 · tradeoff 모두 resolve · acceptance criteria 모두 명시) 를 산출. handoff 채널 = 파일 (`<SSOT>/design.packet.json`) 또는 stdin pipe (`hexa design --stdout | hexa analyze --stdin`). 수렴 기대 신호 = `design_bodies[].rationale.pat`/`anti` 가 모순 0 + `governance_refs` 미인용 design body 0 + `claimed_d_numbers.binding` 의 PR-land race 가 닫힘.
