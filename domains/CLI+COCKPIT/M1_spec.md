# M1 — `spec` verb · CLI + cockpit 등가 surface 설계

> 마일스톤 M1 산출물 · current-state · no history.
> CLI+COCKPIT domain · 7-verb pipeline 의 첫 verb `spec` 을 두 surface (CLI · cockpit TUI) 에서 동일 입력 → 동일 출력 보장하는 설계.
> @D d3 — implementation 은 hexa-lang 에 거주, 본 문서는 설계 only.

---

## 1. 개요

`spec` verb = 7-verb pipeline 의 진입점. 도메인 정체성 · 목적 · governance · scale axis 를 받아 **canonical spec packet** (JSON-shaped) 을 산출하여 다음 verb (`structure`) 로 인계. CLI 와 cockpit TUI 는 같은 packet 을 만드는 두 입력 surface 이며 representation 은 단일 (single generic dispatch · @D d4).

---

## 2. 입력 스키마

| 필드 | 타입 | 필수 | 설명 |
|---|---|---|---|
| `domain` | string (UPPERCASE · `[A-Z][A-Z0-9_+\-]*`) | ✅ | 도메인 식별자 (예: `RTSC` · `DAPTPGX` · `TTR-MN`). `+` 은 meta-domain composition. |
| `goal` | string (한 줄) | ✅ | `@goal:` 최종 목표. 측정가능 종착점 표현 권장. |
| `milestones` | list\<string\> | ✅ (≥1) | 진행 마일스톤 (`- [ ]` 항목). 순서 = 수행 순서. |
| `governance` | list\<`@D` entry\> | optional | 도메인-국지 governance rule (do · dont 쌍). commons `@D` 는 상속. |
| `external_deps` | list\<{name, kind, version?}\> | optional | sibling repo · external SSOT · 데이터셋 · 측정 oracle. `kind ∈ {sibling, dataset, oracle, paper}`. |
| `scale_axis` | enum | ✅ | `materials` · `chip` · `component` · `system` 중 1개. 7-verb pipeline routing 신호. |
| `language` | enum | optional | `ko` (default) · `en` · `mixed`. prose 언어, code 식별자는 항상 english. |
| `verify_tier_target` | enum | optional | 목표 verdict (`🔵` · `🟢` · `🟡` · `🟠`). M-끝 게이트에서 비교. |

검증 규칙:
- `domain` 이 이미 SSOT 에 존재 → `--force` 없으면 reject.
- `milestones` 빈 list → reject (lint warning 이 아닌 hard fail).
- `scale_axis` 누락 → reject (routing 불능).

---

## 3. 출력 스키마 — spec packet (→ structure verb 입력)

```json
{
  "schema_version": "1.0",
  "verb": "spec",
  "domain": "CLI+COCKPIT",
  "goal": "drive demiurge 7-verb pipeline across CLI + cockpit TUI equivalently",
  "milestones": [
    {"id": "M1", "title": "spec verb 양 surface 설계", "done": false},
    {"id": "M2", "title": "structure verb 양 surface 설계", "done": false}
  ],
  "governance": [
    {"id": "local-1", "do": "...", "dont": "..."}
  ],
  "external_deps": [
    {"name": "hexa-lang", "kind": "sibling", "version": "main"}
  ],
  "scale_axis": "component",
  "language": "ko",
  "verify_tier_target": "🟢",
  "provenance": {
    "surface": "cli | cockpit",
    "invoked_at": "2026-05-24T12:00:00Z",
    "operator": "mk55992@proton.me",
    "input_hash": "blake3:..."
  },
  "next_verb": "structure"
}
```

| 필드 | 타입 | 설명 |
|---|---|---|
| `schema_version` | semver | packet schema 버전 (forward-compat) |
| `verb` | const `"spec"` | 산출 verb 표식 |
| `provenance.surface` | enum | `cli` 또는 `cockpit` — 등가성 audit 용 |
| `provenance.input_hash` | string | 정규화 입력의 hash, 양 surface 동일 입력 → 동일 hash |
| `next_verb` | const `"structure"` | pipeline 다음 단계 hint |

핵심: **`provenance.surface` 만 다르고 그 외 모든 필드 byte-identical** 일 때 등가성 PASS.

---

## 4. CLI 시그니처

```
hexa spec <DOMAIN> \
  --goal "<final goal one-liner>" \
  --milestone "<m1>" [--milestone "<m2>" ...] \
  --scale <materials|chip|component|system> \
  [--governance-do "<do>" --governance-dont "<dont>"]... \
  [--dep <name>:<kind>[:<version>]]... \
  [--language ko|en|mixed] \
  [--verify-target 🔵|🟢|🟡|🟠] \
  [--force] \
  [--out <path>.json | --stdout]
```

| 플래그 | 타입 | 필수 | 매핑 |
|---|---|---|---|
| `<DOMAIN>` (positional) | string | ✅ | `domain` |
| `--goal` | string | ✅ | `goal` |
| `--milestone` (repeatable) | string | ✅ ≥1 | `milestones[]` |
| `--scale` | enum | ✅ | `scale_axis` |
| `--governance-do` / `--governance-dont` | string pair | optional | `governance[]` |
| `--dep` | `name:kind[:version]` | optional, repeatable | `external_deps[]` |
| `--language` | enum | optional | `language` |
| `--verify-target` | enum | optional | `verify_tier_target` |
| `--force` | flag | optional | 기존 도메인 덮어쓰기 허용 |
| `--out` / `--stdout` | path / flag | optional | packet 출력 위치 (default = SSOT 경로) |

비-tty 환경 (script · CI) 에서는 CLI 가 default surface. 모든 flag 누락 시 stdin JSON 수용 (`hexa spec --stdin < spec.json`).

---

## 5. cockpit TUI 와이어프레임

```
┌─ demiurge cockpit · verb: spec ─────────────────────────────────────────────┐
│                                                                              │
│  Domain        [ CLI+COCKPIT_________________ ]  (UPPERCASE · A-Z 0-9 _ + -) │
│  Scale axis    ( ) materials  ( ) chip  (•) component  ( ) system            │
│  Language      (•) ko   ( ) en   ( ) mixed                                   │
│  Verify target ( ) 🔵   (•) 🟢   ( ) 🟡   ( ) 🟠                              │
│                                                                              │
│  Goal (한 줄)                                                                │
│  ┌──────────────────────────────────────────────────────────────────────┐    │
│  │ drive demiurge 7-verb pipeline across CLI + cockpit TUI equivalently │    │
│  └──────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
│  Milestones                                              [+ add]  [− remove] │
│  ┌──────────────────────────────────────────────────────────────────────┐    │
│  │ M1  spec verb 양 surface 설계                                        │    │
│  │ M2  structure verb 양 surface 설계                                   │    │
│  │ M3  …                                                                │    │
│  └──────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
│  Governance @D (local)                                   [+ add]             │
│  ┌──────────────────────────────────────────────────────────────────────┐    │
│  │ do   :  …                                                            │    │
│  │ dont :  …                                                            │    │
│  └──────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
│  External deps                                            [+ add]            │
│  ┌──────────────────────────────────────────────────────────────────────┐    │
│  │ hexa-lang   sibling   main                                           │    │
│  └──────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
│  [ ⌃P  preview packet ]  [ ⌃S  emit → structure ]  [ ⌃X  cancel ]            │
└──────────────────────────────────────────────────────────────────────────────┘
 status: input_hash blake3:9f2c… · ready · surface=cockpit
```

키바인딩: `Tab` 필드 이동 · `Space` radio toggle · `⌃P` packet preview (JSON) · `⌃S` 제출 (structure verb 로 dispatch) · `⌃X` 취소.

---

## 6. 두 surface 등가성

| cockpit 필드 | CLI flag | packet 필드 |
|---|---|---|
| `Domain` 입력 | `<DOMAIN>` positional | `domain` |
| `Goal` 한 줄 박스 | `--goal` | `goal` |
| `Milestones` list | `--milestone` (반복) | `milestones[].title` |
| `Scale axis` radio | `--scale` | `scale_axis` |
| `Language` radio | `--language` | `language` |
| `Verify target` radio | `--verify-target` | `verify_tier_target` |
| `Governance @D` rows | `--governance-do` / `--governance-dont` pair | `governance[]` |
| `External deps` rows | `--dep name:kind[:version]` | `external_deps[]` |
| `⌃P preview packet` | `--stdout` (no emit) | — (dry-run) |
| `⌃S emit → structure` | (없음 · default emit) | `next_verb="structure"` dispatch |

**등가성 보장 (single generic dispatch · @D d4):**

1. 두 surface 모두 동일 `normalize(input) → canonical_form` 거침 (whitespace trim · enum lowercase · milestone reorder X).
2. `provenance.input_hash = blake3(canonical_form)` — surface 만 다르고 hash 동일.
3. cockpit `⌃P preview` = CLI `--stdout` = 같은 JSON byte-stream.
4. 회귀 테스트: 동일 fixture → cockpit headless run · CLI run → packet diff = `provenance.surface` 1줄만.

CLI ↔ cockpit 분기 코드 = surface adapter 1개 (입력 수집) + 공통 emitter (검증 · 정규화 · hash · 출력). hardcoded domain branch 없음.

---

## 7. 다음 verb handoff

`spec` packet (§3 JSON) = **canonical spec representation**. `structure` verb 는 동일 schema 의 packet 을 입력으로 받아 `topology / task tree / inventory` 를 산출 → `structure` packet 으로 emit. handoff 채널 = 파일 (`<SSOT>/spec.packet.json`) 또는 stdin pipe (`hexa spec ... --stdout | hexa structure --stdin`).
