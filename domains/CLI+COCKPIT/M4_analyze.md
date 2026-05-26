# M4 — `analyze ⟲` verb · CLI + cockpit 등가 surface 설계

> 마일스톤 M4 산출물 · current-state · no history.
> CLI+COCKPIT domain · 7-verb pipeline 의 네 번째 verb `analyze ⟲` 를 양 surface (CLI · cockpit TUI) 에서 동일 입력 → 동일 수렴 verdict 보장하는 설계.
> @D d3 — implementation 은 hexa-lang 에 거주, 본 문서는 설계 only.
> @D d4 — single generic dispatch · 도메인 hardcoding 없음 · design packet 으로부터 generic loop.
> @D g0 — Occam · 단순한 수렴 룰 (signal-set 4종 · default cap = 5).
> M3 design 은 병렬 sister-agent 가 작성 중 — 본 문서는 `design.packet.json` 의 가정 필드를 `[assumed M3]` 표식으로 명시 → reconciliation pass 가 양측 조정.

---

## 1. 개요

`analyze ⟲` verb = 7-verb pipeline 의 4단계. M3 의 `design.packet.json` 을 입력으로 받아 **수렴할 때까지 반복** (open issue 소진 + gap report fixpoint 도달) 한 뒤 `analyze.packet.json` 으로 산출 → 다음 verb (`synthesize`) 로 인계. ⟲ 글리프 = LOOP 표식 (다른 verb 와 구별되는 유일 verb).

```
spec → structure → design → [ANALYZE ⟲] → synthesize → verify → handoff
                                ↑   ↺ round 1,2,...,N
                             M4 (본 문서)
```

핵심 명제: design packet 의 milestone node + open `- [ ]` issue list 만으로 **generic** loop driver 가 round-by-round delta 측정 → 수렴 signal fixpoint 도달 시 정지 (도메인 분기 X · @D d4).

---

## 2. 입력 — M3 design packet 매핑

`analyze` verb 가 design packet 에서 읽는 필드 (M3 가 병렬 설계 중 → `[assumed M3]` 표식이 reconciliation 핸들).

| design packet 필드 | analyze 사용처 | 변환 규칙 |
|---|---|---|
| `domain` | `analyze.packet.domain` | 그대로 carry (identity) |
| `goal` | loop 종착 컨텍스트 (수렴 기준 X · 표시용) | string carry |
| `nodes[]` (milestone / subtask) `[assumed M3]` | round 시작 시 open issue 집합 seed | `state ∈ {open, blocked}` 인 노드만 |
| `nodes[].open_checklist[]` `[assumed M3]` | round-by-round delta 측정 대상 | `- [ ]` 항목 list, round 종료 시 재카운트 |
| `nodes[].d_number` `[assumed M3]` | residue 보고 시 D-number 인용 | M3 가 design body 에 reserve 한 식별자 |
| `design_body_md` `[assumed M3]` | gap-skill 입력 컨텍스트 | markdown blob, /gap 40 lens 가 스캔 |
| `rationale` / `tradeoffs` `[assumed M3]` | DIVERGED 판정 시 oscillation 후보 컨텍스트 | optional, 보조 신호 |
| `provenance.input_hash` | `analyze.packet.provenance.parent_hash` | 추적성 (parent_hash chain) |
| `next_verb` (= `"analyze"`) | pipeline 위치 검증 | mismatch → reject |

검증 규칙:
- design packet 의 `next_verb` 가 `"analyze"` 가 아니면 reject (pipeline 위치 mismatch).
- `schema_version` 미지원 → reject (forward-compat).
- `nodes[]` 에 open issue 0건 → 즉시 `CONVERGED` (round 0, no-op loop · double gate).
- `[assumed M3]` 필드명이 M3 reconciliation 후 변경 → analyze 측 adapter 1개 수정 (단일 generic loop 본체 무변경).

---

## 3. 출력 — `analyze.packet.json` 스키마

### 3.1 JSON shape

```json
{
  "schema_version": "1.0",
  "verb": "analyze",
  "domain": "CLI+COCKPIT",
  "goal": "drive demiurge 7-verb pipeline across CLI + cockpit TUI equivalently",
  "iteration_ledger": {
    "rounds_executed": 3,
    "max_rounds": 5,
    "rounds": [
      {
        "round": 1,
        "open_checklist_count": 12,
        "gap_report_size": 7,
        "cycle_next_list_size": 6,
        "delta_vs_prev": null,
        "fixpoint_signals": []
      },
      {
        "round": 2,
        "open_checklist_count": 8,
        "gap_report_size": 5,
        "cycle_next_list_size": 3,
        "delta_vs_prev": {"open": -4, "gap": -2, "next": -3},
        "fixpoint_signals": []
      },
      {
        "round": 3,
        "open_checklist_count": 8,
        "gap_report_size": 5,
        "cycle_next_list_size": 0,
        "delta_vs_prev": {"open": 0, "gap": 0, "next": -3},
        "fixpoint_signals": ["open_delta_zero", "gap_delta_zero", "cycle_next_empty"]
      }
    ]
  },
  "convergence": {
    "verdict": "CONVERGED",
    "stopped_on_round": 3,
    "stop_reason": "fixpoint: open_delta_zero ∧ gap_delta_zero ∧ cycle_next_empty",
    "elapsed_seconds": 412
  },
  "residue": [
    {"node_id": "M9", "d_number": "D142", "open_items": ["wet-lab calibration"], "category": "external_dep"}
  ],
  "provenance": {
    "surface": "cli | cockpit",
    "invoked_at": "2026-05-24T12:30:00Z",
    "operator": "mk55992@proton.me",
    "parent_hash": "blake3:<design.input_hash>",
    "input_hash":  "blake3:<canonical(this packet sans surface)>"
  },
  "next_verb": "synthesize"
}
```

### 3.2 필드 명세

| 필드 | 타입 | 설명 |
|---|---|---|
| `iteration_ledger.rounds_executed` | int | 실제 수행 round 수 (1-indexed; 0 = no-op fast-path) |
| `iteration_ledger.max_rounds` | int | cap (default 5 · §4 참조) |
| `iteration_ledger.rounds[].open_checklist_count` | int | round 종료 시 open `- [ ]` 잔량 |
| `iteration_ledger.rounds[].gap_report_size` | int | /gap 40 lens 결과 candidate gap 수 |
| `iteration_ledger.rounds[].cycle_next_list_size` | int | /cycle next-list 항목 수 (다음 round 후보) |
| `iteration_ledger.rounds[].delta_vs_prev` | dict\|null | (open, gap, next) 직전 round 대비 변화량 · round 1 = null |
| `iteration_ledger.rounds[].fixpoint_signals` | list\<enum\> | `open_delta_zero` · `gap_delta_zero` · `cycle_next_empty` · `gap_fixpoint` |
| `convergence.verdict` | enum | `CONVERGED` · `DIVERGED` · `CAPPED` · `STUCK` (§4.4) |
| `convergence.stopped_on_round` | int | verdict 산정 시점 round |
| `convergence.stop_reason` | string | signal 조합 또는 escape hatch 사유 (사람이 읽음) |
| `residue[]` | list | 수렴 후에도 남은 open issue (synthesize 가 skip / handoff 가 인용) |
| `residue[].category` | enum | `external_dep` · `wet_lab_blocked` · `tier_oranged` · `out_of_scope` |
| `next_verb` | const `"synthesize"` | pipeline 다음 hint (단, CONVERGED 일 때만 dispatch · §8) |

### 3.3 representation 선택 근거 (Occam · @D g0)

| 후보 | 채택 여부 | 사유 |
|---|---|---|
| **ledger (rounds[]) + verdict + residue 3-필드** | ✅ | JSON-native · round 별 delta 즉시 diff · 등가성 hash 가능 |
| trace event stream (per-action log) | ❌ | round-level 결정에 불필요 · packet 비대 · 등가성 검증 노이즈 |
| convergence boolean only | ❌ | DIVERGED / CAPPED / STUCK 4-verdict 표현 불가 · residue 누락 |
| per-tool sub-packet (cycle vs gap 분리) | ❌ | @D d4 위반 (tool-specific 분기) · loop driver generic 위반 |

→ **ledger + verdict + residue (3 평행 섹션)** 가 최소 충분.

---

## 4. 수렴 판정 알고리즘 (Convergence judgment)

`analyze ⟲` 의 핵심 — round-by-round signal 측정 + fixpoint 도달 시 정지. M3 design packet 의 어떤 도메인이든 동일 알고리즘 적용 (@D d4).

### 4.1 round 1회 sequence

```
round N:
  1. /cycle  next-list 계산           → cycle_next_list_size
  2. /cycle  배치 실행 (open 소진 시도) → open_checklist 갱신
  3. /gap    40 lens 스캔             → gap_report_size + gap_report_set
  4. delta_vs_prev 계산 (round ≥ 2)   → {open: Δopen, gap: Δgap, next: Δnext}
  5. fixpoint_signals 평가            → §4.2 신호 집합
  6. verdict 평가                     → §4.4 4-verdict 판정
  7. verdict ≠ CONVERGED ∧ round < max → round N+1 계속
```

### 4.2 fixpoint signals (4종 · Occam g0)

| signal id | 조건 | 의미 |
|---|---|---|
| `open_delta_zero` | `delta_vs_prev.open == 0` | 직전 round 대비 open `- [ ]` 변화 0 → cycle 더 진행해도 소진 안 됨 |
| `gap_delta_zero` | `delta_vs_prev.gap == 0` ∧ `gap_report_set` 동일 | /gap 40 lens 결과 stable → 새 gap 출현 X |
| `cycle_next_empty` | `cycle_next_list_size == 0` | /cycle 이 다음 round 후보 0 (스스로 정지) |
| `gap_fixpoint` | 연속 2 round `gap_report_set` byte-identical | gap 결과 완전 fixed-point (delta_zero 보다 엄격) |

### 4.3 cap (default = 5 · 정당화 per @D g0)

| 후보 cap | 채택 | 근거 |
|---|---|---|
| **5** | ✅ | NOREFLOW cross-domain 실증: cycle 5 iteration 완료, leak 0 (CLI+COCKPIT.md 헤더 인용). 5 round 안에 대부분 도메인 fixpoint 도달. Occam-단순. |
| 8 | ❌ | brainstorm skill 의 depletion cap (8) 과 동일치이나 analyze 는 ideation 이 아닌 convergence — 8 은 over-budget. |
| 무제한 | ❌ | DIVERGED / STUCK 시 무한 loop · time/cost 보호 없음 · @D g0 위반 |
| 3 | ❌ | NOREFLOW 5-round 실증 미만 → under-converge 위험 |

`--max-rounds N` 으로 사용자 override 가능 (예: 대형 도메인 8 · 디버그 1).

### 4.4 verdict 4종 (decision matrix)

| verdict | 조건 | 의미 | handoff |
|---|---|---|---|
| **CONVERGED** | `open_delta_zero` ∧ (`gap_delta_zero` ∨ `gap_fixpoint`) ∧ `cycle_next_empty` | 모든 signal fixpoint | synthesize 진행 ✅ |
| **CAPPED** | `rounds_executed == max_rounds` ∧ ¬CONVERGED | round budget 소진, 일부 signal 미수렴 | synthesize 대신 escalation (cap 늘리거나 design rework) |
| **DIVERGED** | 연속 2 round `delta.open > 0` (open 증가) ∨ residue 카운트 증가 | 진행할수록 issue 늘어남 → design 결함 | M3 design 으로 rollback handoff |
| **STUCK** | oscillation 감지 (round k 와 round k-2 의 signal-tuple 동일) | 진동 — 한 lens 가 새 gap 만들고 다른 lens 가 close | manual STOP + 사용자 개입 escalation |

verdict 우선순위: `DIVERGED` > `STUCK` > `CAPPED` > `CONVERGED` (안전 우선 — 부정 verdict 가 긍정 verdict 보다 먼저 evaluate).

### 4.5 escape hatches

| hatch | trigger | 동작 |
|---|---|---|
| manual STOP | CLI: SIGINT (Ctrl-C) · cockpit: `⌃X` | 진행 중 round 완료 후 정지 · verdict = `STUCK` (사용자 사유) |
| oscillation detection | §4.4 STUCK 조건 | 자동 정지 · 직전 2 round signal-tuple 첨부 |
| time budget | `--time-budget <sec>` 초과 | 진행 중 round 완료 후 정지 · verdict = `CAPPED` (time 사유) |
| empty-input fast-path | input open issue 0건 | round 0 즉시 종료 · verdict = `CONVERGED` (no-op) |

---

## 5. CLI 시그니처

```
hexa analyze [<DOMAIN>] \
  [--in <design.packet.json> | --stdin] \
  [--max-rounds <int>] \
  [--converge-on <signal>[,<signal>...]] \
  [--time-budget <seconds>] \
  [--dry-run] \
  [--render ledger|verdict|json] \
  [--out <path>.json | --stdout] \
  [--force]
```

| 플래그 | 타입 | 필수 | 매핑 / 동작 |
|---|---|---|---|
| `<DOMAIN>` (positional) | string | optional | SSOT 의 `<DOMAIN>/design.packet.json` 자동 로드 |
| `--in` | path | optional (XOR `--stdin`) | design packet 파일 경로 |
| `--stdin` | flag | optional (XOR `--in`) | stdin 으로 design packet JSON 수용 |
| `--max-rounds` | int | optional | cap override (default 5 · §4.3) |
| `--converge-on` | enum csv | optional | 수렴 signal 부분집합 (default = 4종 모두 · §4.2) |
| `--time-budget` | int (sec) | optional | escape hatch (§4.5) |
| `--dry-run` | flag | optional | round 0 시뮬레이션 (delta 계산만, /cycle · /gap 미실행) |
| `--render` | enum | optional | `ledger` (round 표) · `verdict` (verdict only) · `json` (packet) · default `ledger` |
| `--out` | path | optional | analyze packet 출력 위치 (default = `<SSOT>/analyze.packet.json`) |
| `--stdout` | flag | optional | stdout pipe handoff |
| `--force` | flag | optional | 기존 `analyze.packet.json` 덮어쓰기 |

### 5.1 invocation 샘플

```
# (a) 기본 — SSOT 자동 로드, default cap=5
hexa analyze CLI+COCKPIT
  → reads  <SSOT>/CLI+COCKPIT/design.packet.json
  → writes <SSOT>/CLI+COCKPIT/analyze.packet.json
  → ledger render to stdout

# (b) pipe handoff (design → analyze → synthesize, CONVERGED 일 때만)
hexa design CLI+COCKPIT --stdout \
  | hexa analyze --stdin --max-rounds 8 --stdout \
  | hexa synthesize --stdin   # synthesize 가 verdict 검사 후 진행

# (c) 부분 수렴 signal — gap_fixpoint 만 필수
hexa analyze RTSC --converge-on gap_fixpoint --max-rounds 3

# (d) dry-run — 1 round signal 측정만
hexa analyze NOREFLOW --dry-run --render verdict
```

비-tty 환경 (script · CI) 에서는 CLI 가 default surface. cockpit 비활성 시에도 packet/ledger byte-identical.

---

## 6. cockpit TUI 와이어프레임

```
┌─ demiurge cockpit · verb: analyze ⟲ ────────────────────────────────────────┐
│ Domain: CLI+COCKPIT   design.input_hash: blake3:7d1a…   parent: design ✓    │
│ max-rounds: [5]   converge-on: [open,gap,next,fixpoint]   budget: [—]       │
├──────────────────────────────────────────────────────────────────────────────┤
│ ┌─ Round ledger ───────────┐ ┌─ Current open issues ──┐ ┌─ Convergence ──┐ │
│ │ R# │open│gap│next│Δo│Δg│ │ │ ▾ M9  D142             │ │                 │ │
│ │ ───┼────┼───┼────┼──┼──┤ │ │   • wet-lab calibrate  │ │   verdict       │ │
│ │  1 │ 12 │ 7 │  6 │ — │ —│ │ │ ▾ M11 D158             │ │   ┌──────────┐ │ │
│ │  2 │  8 │ 5 │  3 │-4│-2│ │ │   • oracle dep         │ │   │CONVERGED │ │ │
│ │ ▸3 │  8 │ 5 │  0 │ 0│ 0│ │ │   (none in scope)      │ │   └──────────┘ │ │
│ │    │    │   │    │  │  │ │ │                        │ │   stopped: R3  │ │
│ │ signals: open=0 gap=0   │ │ residue (carry → M5):   │ │   reason:      │ │
│ │          next-empty ✓   │ │   M9·wet-lab (ext_dep) │ │   fixpoint     │ │
│ │          gap-fixpoint ✓ │ │   M11·oracle (ext_dep) │ │   (open∧gap    │ │
│ │                          │ │                        │ │    ∧next-empty)│ │
│ └──────────────────────────┘ └────────────────────────┘ └────────────────┘ │
│                                                                              │
│ Progress: ▓▓▓░░ R3/5 · 60% · elapsed 412s                                    │
│                                                                              │
│ [ ⌃R run next round ] [ ⌃A auto until stop ] [ ⌃P preview packet ]           │
│ [ ⌃S emit → synthesize ] [ ⌃X manual STOP ]                                  │
└──────────────────────────────────────────────────────────────────────────────┘
 status: analyze.input_hash blake3:c4b1… · verdict=CONVERGED · surface=cockpit
```

키바인딩: `↑/↓` round 선택 · `→` round 상세 expand · `⌃R` 다음 round 1회 실행 · `⌃A` cap/STOP 까지 자동 · `⌃P` packet preview (JSON) · `⌃S` synthesize 로 dispatch (CONVERGED 일 때만 활성) · `⌃X` manual STOP (verdict=STUCK).

cockpit panel 책무:
- **round ledger (좌)** = `iteration_ledger.rounds[]` 표 투영 · 현재 round `▸` 표식 · delta 컬럼 즉시 가독.
- **open issues (중)** = `nodes` 중 `open_checklist[]` 비어있지 않은 노드 트리 · 수렴 후 → residue 표시.
- **convergence badge (우)** = verdict + stopped_on_round + stop_reason 단독 박스 (g5 — self-judge 금지, packet 의 verdict 그대로 표시).
- **progress bar** = `rounds_executed / max_rounds` 비주얼 (UPPERCASE.md 의 `▓▓▓░░ NN%` 양식 재사용).

---

## 7. 두 surface 등가성

### 7.1 control mapping

| cockpit 동작 | CLI flag | analyze packet 영향 |
|---|---|---|
| design packet 자동 로드 (domain 컨텍스트) | `<DOMAIN>` positional 또는 `--in` | input 채널 (packet 동일) |
| `max-rounds` 입력 박스 | `--max-rounds <int>` | `iteration_ledger.max_rounds` |
| `converge-on` 멀티-선택 | `--converge-on <csv>` | signal 집합 (verdict 산정 시 사용) |
| `budget` 입력 박스 | `--time-budget <sec>` | escape hatch 임계 |
| `⌃R run next round` | (없음 · CLI 는 atomic full-run) | 1 round 진행 (UI affordance 만, packet 결과 동일) |
| `⌃A auto until stop` | (default CLI 동작) | cap/STOP 까지 자동 |
| `⌃P preview packet` | `--stdout` (no write) | dry-run 동등 |
| `⌃S emit → synthesize` | (default emit) | `next_verb="synthesize"` dispatch · verdict 검사 |
| `⌃X manual STOP` | SIGINT | verdict = `STUCK` (manual 사유) |
| round ledger 셀 expand | (없음 · view-only) | — (cockpit-local view state) |

### 7.2 등가성 보장 (single generic dispatch · @D d4)

1. 두 surface 모두 동일 `run_analyze_loop(design_packet, max_rounds, signal_set) → analyze_packet` 함수 거침.
2. `provenance.parent_hash = design.provenance.input_hash` — 동일 design → 동일 parent_hash.
3. `provenance.input_hash = blake3(canonical(analyze_packet sans surface))` — surface 만 다르고 hash 동일.
4. **결정성 보장 노트**: SAME design.packet + SAME max-rounds + SAME signal threshold + SAME tool versions (/cycle · /gap) → SAME convergence verdict + SAME ledger byte-identical. cockpit `⌃A` = CLI default run = 같은 ledger.
5. 회귀 테스트: 동일 design packet fixture → cockpit headless run · CLI run → analyze packet diff = `provenance.surface` 1줄만.

### 7.3 view state firewall

cockpit 의 round 선택 · expand state · 진행 표시 애니메이션은 모두 **packet 외부** (cockpit-local UI state). packet 에 leak 시 등가성 PASS 불가 → 명시적 firewall (M2 §6.3 패턴 재사용).

---

## 8. M5 synthesize 으로의 handoff

`analyze.packet.json` (§3 JSON) = canonical analyze representation. **`synthesize` verb 는 동일 schema 의 analyze packet 을 입력으로 받되, `convergence.verdict == "CONVERGED"` 일 때만 진행** — 그 외 verdict 는 분기 처리:

| verdict | synthesize 동작 |
|---|---|
| `CONVERGED` | 정상 진행 · `next_verb="synthesize"` dispatch (M5 §2 routing 결정 트리 진입) |
| `CAPPED` | 정지 + 사용자 escalation prompt (`--max-rounds` 증가 또는 design rework) |
| `DIVERGED` | M3 design rollback handoff (`hexa design <DOMAIN> --rework --from analyze.packet.json`) |
| `STUCK` | manual review queue (residue + oscillation 신호 첨부, 사람 결정 대기) |

handoff 채널 = 파일 (`<SSOT>/analyze.packet.json`) 또는 stdin pipe (`hexa analyze ... --stdout | hexa synthesize --stdin`).

---

## 9. 살아있는 예시 — NOREFLOW cross-domain (cycle 5 iteration + gap 40 lens)

CLI+COCKPIT.md cross-domain 표 (M4 행):

> **M4 analyze** — `/cycle` skill × 5 iteration + `/gap` skill × 40 lens (F2/F4/F8 hot) · convergence = open `- [ ]` 소진 + gap report fixpoint

→ analyze verb 의 살아있는 instance. NOREFLOW design packet (12 base + V1-V4 verify, total 16 milestone) → analyze loop:

```
round 1: open=N₁  gap=7 (F2/F4/F8 family hot)  next=많음    Δ=—
round 2: open<N₁ gap=6                          next=감소    Δ_open<0
round 3: open<…  gap=5                          next=감소    Δ_open<0
round 4: open<…  gap=5 (fixpoint 진입)          next=소수    Δ_gap=0
round 5: open=0  gap=5 (set 동일)               next=0      → CONVERGED
                                                              (open_delta_zero ∧
                                                               gap_fixpoint ∧
                                                               cycle_next_empty)
```

- **수렴 signal 3종 동시 발화** → CONVERGED · `stopped_on_round=5` · `stop_reason="fixpoint: open + gap + next"`.
- **gap family F2/F4/F8 hot** → 40 lens 중 3 family 가 candidate gap 생성, 나머지 37 lens 는 빈 결과 → `gap_report_set` 결정성 확보 (등가성 hash 안정).
- **leak 0** = residue 중 wet-lab/oracle 외부 의존만 잔여 → category `external_dep` 로 분류, synthesize 가 skip 처리.
- **cap=5 정당화 cross-domain 실증** (§4.3) — 본 도메인이 default cap 결정 근거.

→ NOREFLOW + (DAPTPGX 14 milestone · ISR V1-V4) 모두 동일 `run_analyze_loop` generic 함수로 처리 가능 (@D d4 입증).

---

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| §3 packet schema | 🟠 INSUFFICIENT (디자인 명세) | spec 단계, hexa-lang impl 후 verify |
| §4.2 fixpoint signal set | 🔵 SUPPORTED-FORMAL | 4 signal 정의가 design packet 필드의 결정적 함수 |
| §4.3 cap=5 정당화 | 🟡 SUPPORTED-BY-CITATION | NOREFLOW cycle 5 iteration 완료 인용 (CLI+COCKPIT.md) |
| §4.4 verdict decision matrix | 🔵 SUPPORTED-FORMAL | 우선순위 + 조건 closed-form |
| §5 CLI 시그니처 | 🟠 INSUFFICIENT (디자인 명세) | hexa-lang impl 후 verify |
| §6 cockpit 와이어 | 🟠 INSUFFICIENT (디자인 명세) | TUI impl 후 verify |
| §7.2 등가성 보장 (hash) | 🔵 SUPPORTED-FORMAL | blake3 (canonical) 결정성은 closed-form |
| §9 NOREFLOW 사례 | 🟡 SUPPORTED-BY-CITATION | CLI+COCKPIT.md cross-domain 표 인용 |

---

## 11. 핵심 통찰

- **signal 4종 (open · gap · next · fixpoint) Occam 채택** — 더 많은 signal 은 noise · 더 적으면 verdict resolution 부족. NOREFLOW 실증이 3 signal 동시 발화 = CONVERGED 패턴 확인 → 4 signal 이 충분-필요 둘 다 만족.
- **cap=5 = NOREFLOW 5-iteration 실증값** — 8 (brainstorm 양식) · 3 (under) · ∞ (g0 위반) 모두 탈락. cross-domain 입증된 cap.
- **verdict 우선순위 = 부정 verdict 먼저** — DIVERGED > STUCK > CAPPED > CONVERGED. 안전-우선 (잘못된 CONVERGED 가 synthesize 진입 후 wet-lab 까지 새면 비용 큼).
- **CONVERGED 만 synthesize dispatch** — 다른 3 verdict 는 design rollback / cap 확장 / manual review 로 분기. 자동화 가능한 분기 + 사람 개입 분기 명확 분리.
- **`[assumed M3]` 표식 = reconciliation 핸들** — M3 가 병렬 설계 중인 design packet 필드 (open_checklist · d_number · design_body_md 등 7개) 가 가정값. M3 land 시 양측 1 commit 으로 동기화 가능 (adapter 1개 위치).
- **`parent_hash` chain 계속** — spec → structure → design → analyze 까지 hash-linked carry. verify/handoff 단계에서 source-of-truth 추적성 유지.
- **gap fixpoint = 가장 엄격한 signal** — set byte-identical 요구는 delta_zero 보다 강함 (count 같아도 멤버 다르면 fail). 진동 (oscillation) 탐지 핵심.
