# M2 — `structure` verb · CLI + cockpit 등가 surface 설계

> 마일스톤 M2 산출물 · current-state · no history.
> CLI+COCKPIT domain · 7-verb pipeline 의 두 번째 verb `structure` 를 양 surface (CLI · cockpit TUI) 에서 동일 입력 → 동일 출력 보장하는 설계.
> @D d3 — implementation 은 hexa-lang 에 거주, 본 문서는 설계 only.
> @D d4 — single generic dispatch · 도메인 hardcoding 없음 · spec packet 으로부터 generic 추론.

---

## 1. 개요

`structure` verb = 7-verb pipeline 의 2단계. M1 의 `spec.packet.json` 을 입력으로 받아 도메인의 **구조 분해** (dependency graph + hierarchy + scale-layer) 를 `structure.packet.json` 으로 산출 → 다음 verb (`design`) 로 인계.

```
spec → [STRUCTURE] → design → analyze ⟲ → synthesize → verify → handoff
            ↑
         M2 (본 문서)
```

핵심 명제: spec packet 의 `milestones[]` 순서 + `scale_axis` 만으로 **generic** 하게 nodes/edges/layers 추론 (도메인 분기 X · @D d4).

---

## 2. 입력 — M1 spec packet 매핑

`structure` verb 가 spec packet 에서 읽는 필드:

| spec packet 필드 | structure 사용처 | 변환 규칙 |
|---|---|---|
| `domain` | `structure.packet.domain` | 그대로 carry (identity) |
| `goal` | root node label | nodes[0].label (= 최종 goal) |
| `milestones[].id` / `.title` | child node id / label | 각 milestone 1 node, 순서 = topological order seed |
| `milestones[].done` | node `state` | `done ? "completed" : "open"` |
| `scale_axis` | `structure.packet.scale_layers` initial layer | `materials / chip / component / system` 4-layer template 중 entry layer 결정 |
| `external_deps[]` | external nodes (kind=`external`) | sibling/dataset/oracle/paper → node + edge to root |
| `governance[]` | constraint edges (decoration) | nodes 에는 unattached, edges 의 `governance_ref` 로 부착 |
| `provenance.input_hash` | `structure.packet.provenance.parent_hash` | 추적성 — 동일 spec → 동일 structure |

검증 규칙:
- spec packet 의 `next_verb` 가 `"structure"` 가 아니면 reject (pipeline 위치 mismatch).
- `schema_version` 이 미지원 → reject (forward-compat 명시).
- `milestones[]` 빈 list → reject (구조 분해 대상 0 · M1 에서 이미 막혔어야 함 · double gate).

---

## 3. 출력 — `structure.packet.json` 스키마

### 3.1 JSON shape

```json
{
  "schema_version": "1.0",
  "verb": "structure",
  "domain": "CLI+COCKPIT",
  "goal": "drive demiurge 7-verb pipeline across CLI + cockpit TUI equivalently",
  "nodes": [
    {"id": "root", "kind": "goal", "label": "<goal one-liner>", "state": "open"},
    {"id": "M1", "kind": "milestone", "label": "spec verb 양 surface 설계", "state": "open", "layer": "component"},
    {"id": "M2", "kind": "milestone", "label": "structure verb 양 surface 설계", "state": "open", "layer": "component"},
    {"id": "dep:hexa-lang", "kind": "external", "label": "hexa-lang", "ext_kind": "sibling", "version": "main"}
  ],
  "edges": [
    {"from": "M1", "to": "root", "rel": "contributes_to"},
    {"from": "M2", "to": "M1",   "rel": "depends_on", "governance_ref": null},
    {"from": "M2", "to": "dep:hexa-lang", "rel": "uses_external"}
  ],
  "scale_layers": [
    {"id": "materials", "members": []},
    {"id": "chip",      "members": []},
    {"id": "component", "members": ["M1", "M2"]},
    {"id": "system",    "members": ["root"]}
  ],
  "provenance": {
    "surface": "cli | cockpit",
    "invoked_at": "2026-05-24T12:05:00Z",
    "operator": "mk55992@proton.me",
    "parent_hash": "blake3:<spec.input_hash>",
    "input_hash":  "blake3:<canonical(this packet sans surface)>"
  },
  "next_verb": "design"
}
```

### 3.2 필드 명세

| 필드 | 타입 | 설명 |
|---|---|---|
| `nodes[].kind` | enum | `goal` · `milestone` · `external` · `subtask` (later expansion) |
| `nodes[].state` | enum | `open` · `completed` · `blocked` |
| `nodes[].layer` | enum? | scale_layer membership (root 만 `system`, 나머지 default = spec.scale_axis) |
| `edges[].rel` | enum | `contributes_to` · `depends_on` · `uses_external` · `constrained_by` |
| `edges[].governance_ref` | id? | `@D` rule id (예: `local-1`) 시 constraint decoration |
| `scale_layers[]` | ordered list | `materials → chip → component → system` (고정 order, 비어있는 layer 도 자리 보존) |
| `next_verb` | const `"design"` | pipeline 다음 hint |

### 3.3 representation 선택 근거 (Occam · @D g0)

| 후보 | 채택 여부 | 사유 |
|---|---|---|
| **nodes + edges (list of dict)** | ✅ | JSON-native · streaming-friendly · 두 surface 동등 직렬화 · diff-able |
| adjacency matrix | ❌ | sparse graph → 낭비 · 도메인 크기 변동 시 reshape · diff 불가 |
| nested tree (only) | ❌ | DAG (M2 → external + M2 → M1 등 multi-parent) 표현 불가 |
| GraphML / dot | ❌ | 외부 schema 의존 → @D g1 (canonical first) 위반 |

→ **nodes + edges + scale_layers (3 평행 array)** 가 최소 충분 (Occam).

### 3.4 ASCII 렌더 예시

```
CLI+COCKPIT (goal · system)
└─ root: drive demiurge 7-verb pipeline ...
   │
   ├── M1  spec verb 양 surface 설계               [open · component]
   ├── M2  structure verb 양 surface 설계          [open · component]
   │    └─→ depends_on: M1
   │    └─→ uses_external: hexa-lang (sibling@main)
   ├── M3  design …                                [open · component]
   ├── M4  analyze …                               [open · component]
   ├── M5  synthesize …                            [open · component]
   ├── M6  verify …                                [open · component]
   └── M7  handoff …                               [open · component]

scale_layers (entry=component)
  materials [ ]
  chip      [ ]
  component [M1 M2 M3 M4 M5 M6 M7]
  system    [root]
```

dependency graph (edges only):

```
  root
   ▲
   │ contributes_to
   ├── M1 ◀── depends_on ─── M2 ◀── depends_on ─── M3
   │                          │
   │                          └── uses_external ──▶ hexa-lang
   └── (M3..M7 동일 패턴)
```

---

## 4. CLI 시그니처

```
hexa structure [<DOMAIN>] \
  [--in <spec.packet.json> | --stdin] \
  [--scale <materials|chip|component|system>] \
  [--render tree|graph|json] \
  [--out <path>.json | --stdout] \
  [--force]
```

| 플래그 | 타입 | 필수 | 매핑 / 동작 |
|---|---|---|---|
| `<DOMAIN>` (positional) | string | optional | 명시 시 SSOT 의 `<DOMAIN>/spec.packet.json` 자동 로드 |
| `--in` | path | optional (XOR `--stdin`) | spec packet 파일 경로 |
| `--stdin` | flag | optional (XOR `--in`) | stdin 으로 spec packet JSON 수용 |
| `--scale` | enum | optional | spec packet `scale_axis` override (debug) |
| `--render` | enum | optional | 추가 시각 출력 (`tree` = §3.4 ASCII · `graph` = edges box · `json` = packet only · default = `json`) |
| `--out` | path | optional | structure packet 출력 위치 (default = `<SSOT>/structure.packet.json`) |
| `--stdout` | flag | optional | stdout 으로 packet 출력 (pipe handoff 용) |
| `--force` | flag | optional | 기존 `structure.packet.json` 덮어쓰기 허용 |

**입력 우선순위**: `--stdin` > `--in` > `<DOMAIN>` positional auto-load. 셋 다 없으면 reject.

### 4.1 invocation 샘플

```
# (a) 기본 — SSOT 자동 로드
hexa structure CLI+COCKPIT
  → reads  <SSOT>/CLI+COCKPIT/spec.packet.json
  → writes <SSOT>/CLI+COCKPIT/structure.packet.json
  → tree render to stdout

# (b) pipe handoff (spec → structure → design)
hexa spec CLI+COCKPIT --goal "..." --milestone "..." --scale component --stdout \
  | hexa structure --stdin --stdout \
  | hexa design   --stdin

# (c) render only — packet 재생성 X
hexa structure CLI+COCKPIT --render tree --stdout
```

비-tty 환경 (script · CI) 에서는 CLI 가 default surface. cockpit 비활성 시에도 packet/render byte-identical.

---

## 5. cockpit TUI 와이어프레임

```
┌─ demiurge cockpit · verb: structure ────────────────────────────────────────┐
│ Domain: CLI+COCKPIT     spec.input_hash: blake3:9f2c…    parent: spec ✓     │
│ Scale axis: ( ) materials  ( ) chip  (•) component  ( ) system  [edit ⌃E]   │
├──────────────────────────────────────────────────────────────────────────────┤
│ ┌─ Tree view ────────────────┐  ┌─ Edge inspector ───────────────────────┐  │
│ │ ▾ root  drive 7-verb …     │  │ selected: M2                            │  │
│ │   • M1 spec  [open]        │  │   from   : M2                           │  │
│ │   ▸ M2 structure [open] ◀──┼──┤   to     : M1                           │  │
│ │   • M3 design  [open]      │  │   rel    : depends_on                   │  │
│ │   • M4 analyze [open]      │  │   gov    : (none)                       │  │
│ │   • M5 synth   [open]      │  │   ────                                  │  │
│ │   • M6 verify  [open]      │  │   from   : M2                           │  │
│ │   • M7 handoff [open]      │  │   to     : dep:hexa-lang                │  │
│ │ ▾ external                 │  │   rel    : uses_external                │  │
│ │   • hexa-lang  [sibling]   │  │                                         │  │
│ └────────────────────────────┘  └─────────────────────────────────────────┘  │
│                                                                              │
│ ┌─ Scale-layer toggle ───────────────────────────────────────────────────┐  │
│ │ [x] materials (0)   [x] chip (0)   [x] component (7)   [x] system (1)  │  │
│ │ filter: visible nodes follow toggled layers (cockpit-local view state) │  │
│ └────────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
│ [ ⌃P preview packet ]  [ ⌃S emit → design ]  [ ⌃R re-render ]  [ ⌃X cancel ]│
└──────────────────────────────────────────────────────────────────────────────┘
 status: structure.input_hash blake3:7d1a… · ready · surface=cockpit
```

키바인딩: `↑/↓` tree 노드 이동 · `→/←` expand/collapse · `Space` edge inspector 토글 · `⌃E` scale_axis override · `⌃P` packet preview (JSON) · `⌃S` 제출 (design verb 로 dispatch) · `⌃R` 재렌더 · `⌃X` 취소.

cockpit panel 책무:
- **tree view** = nodes 의 hierarchical projection (root → milestones → externals)
- **edge inspector** = 선택 노드의 in/out edges + governance_ref decoration
- **scale-layer toggle** = view filter (cockpit-local 상태 · packet 에 영향 X · 등가성 보존)

---

## 6. 두 surface 등가성

### 6.1 control mapping

| cockpit 동작 | CLI flag | structure packet 영향 |
|---|---|---|
| spec packet 자동 로드 (domain 컨텍스트) | `<DOMAIN>` positional 또는 `--in` | input 채널 (packet 동일) |
| `⌃E scale_axis override` | `--scale` | `nodes[].layer` 재배치 |
| tree expand/collapse | (없음 · view-only) | — (cockpit-local) |
| scale-layer 토글 | (없음 · view-only) | — (cockpit-local) |
| `⌃P preview packet` | `--stdout` (no write) | dry-run 동등 |
| `⌃S emit → design` | (default emit) | `next_verb="design"` dispatch |
| `⌃R re-render` | `--render tree/graph` | render 형식 (packet 동일) |

### 6.2 등가성 보장 (single generic dispatch · @D d4)

1. 두 surface 모두 동일 `derive_structure(spec_packet) → canonical_structure` 함수 거침.
2. `provenance.parent_hash = spec.provenance.input_hash` — 동일 spec → 동일 parent_hash.
3. `provenance.input_hash = blake3(canonical(structure_packet sans surface))` — surface 만 다르고 hash 동일.
4. cockpit `⌃P preview` = CLI `--stdout` = 같은 JSON byte-stream.
5. 회귀 테스트: 동일 spec packet fixture → cockpit headless run · CLI run → structure packet diff = `provenance.surface` 1줄만.

### 6.3 view state 분리 원칙

cockpit 의 tree expand state · scale-layer toggle · 선택 노드는 모두 **packet 외부** (cockpit-local UI state). packet 에 leak 시 등가성 PASS 불가 → 명시적 firewall.

---

## 7. M3 design 으로의 handoff

`structure.packet.json` (§3 JSON) = canonical structure representation. **`design` verb 는 동일 schema 의 structure packet 을 입력으로 받아** 각 milestone node 에 D-number reserve + design body 를 attach 한 `design.packet.json` 을 산출 (next_verb=`analyze`). handoff 채널 = 파일 (`<SSOT>/structure.packet.json`) 또는 stdin pipe (`hexa structure ... --stdout | hexa design --stdin`).

---

## 8. Cross-domain validation 사례

### 8.1 NOREFLOW — 2-tier hierarchy (base 12 + verify 4)

CLI+COCKPIT.md cross-domain 표에서 NOREFLOW 의 generic learning:

> **M2 structure** — M1-M12 / V1-V4 의존 graph (verify schema 가 M10/M11/M12 native 구현) · 2-tier (base 12 + verify 4) hierarchy = scalable

→ structure verb 의 살아있는 instance. NOREFLOW spec packet (16 milestone: M1-M12 + V1-V4) → structure packet:

```
nodes  = 1 goal + 16 milestone + N externals
edges  = M1→root, M2→M1, ..., V1→{M10,M11,M12} (verify cross-cuts base)
layers = component (M1-M12) · system (V1-V4 verify cross-cuts)
```

verify (V1-V4) milestone 이 base milestone 에 `depends_on` multi-edge → adjacency matrix / nested tree 가 표현 불가했던 이유 (§3.3 근거 강화).

### 8.2 DAPTPGX — 14/14 milestone + external dep multiplicity

DAPTPGX 14 milestone (M1-M11 + V1-V4) + external deps (hexa-lang stdlib-bio-stats · atlas pgx-kind) 가 structure packet 의 `external` node + `uses_external` edge 의 대표 인스턴스. V2 atlas push 4 shards = `subtask` kind expansion 후보 (현 schema 는 milestone level 까지만, subtask 는 forward-compat).

→ 두 도메인 모두 단일 `derive_structure` generic 함수로 처리 가능 (@D d4 입증).

---

## 9. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| §3 packet schema | 🟠 INSUFFICIENT (디자인 명세) | spec 단계, 구현 미완 |
| §3.4 ASCII 렌더 형식 | 🔵 SUPPORTED-FORMAL | nodes/edges → tree 투영은 결정적 (한 representation, 한 출력) |
| §4 CLI 시그니처 | 🟠 INSUFFICIENT (디자인 명세) | hexa-lang impl 후 verify 가능 |
| §5 cockpit 와이어 | 🟠 INSUFFICIENT (디자인 명세) | TUI impl 후 verify 가능 |
| §6 등가성 보장 (hash) | 🔵 SUPPORTED-FORMAL | blake3 (canonical) 결정성은 closed-form |
| §8.1 NOREFLOW 사례 | 🟡 SUPPORTED-BY-CITATION | CLI+COCKPIT.md cross-domain 표 인용 |
| §8.2 DAPTPGX 사례 | 🟡 SUPPORTED-BY-CITATION | CLI+COCKPIT.md cross-domain 표 인용 |

---

## 10. 핵심 통찰

- **representation = nodes+edges+scale_layers (3 평행 array)** — adjacency matrix (sparse 낭비) · nested tree (multi-parent 표현 불가) · GraphML (canonical 위반) 모두 탈락. Occam 결과 JSON-native 3-array.
- **view state firewall** — cockpit 의 tree expand · layer toggle · 선택 노드는 packet 외부. firewall 안 두면 surface 등가성 PASS 불가 → 설계 단계 필수 분리.
- **`derive_structure` 는 generic** — spec packet 의 milestones[] + scale_axis 만으로 추론. 도메인 이름 분기 0 (@D d4). NOREFLOW · DAPTPGX 양쪽이 동일 함수로 처리됨이 cross-domain 입증.
- **`parent_hash` chain 이 pipeline 추적성** — 각 verb packet 이 직전 packet 의 input_hash 를 `parent_hash` 로 carry → spec → structure → design → ... 전 체인이 hash-linked. verify/handoff 단계에서 source-of-truth 추적 즉시.
- **V1-V4 verify cross-cut = subtask kind expansion trigger** — NOREFLOW 사례에서 verify schema 가 base milestone 에 다중-edge 로 부착됨 → 현 schema (milestone level) 너머 subtask 노드 도입이 차기 forward-compat 후보.
