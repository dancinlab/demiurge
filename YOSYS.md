# YOSYS — rfc_006 §5 area-oracle parity (장기전 roadmap)

> **domain**: hexa-lang yosys absorption · §5 measurement gate
> **goal**: hexa-native synth 가 substrate yosys+SKY130 의 oracle area
> (router_d4 = 61,762.99 µm²) 를 ±5 % 안에서 재현 → `absorbed=true`
> **detail handoff**: `inbox/notes/rfc006-s5-area-oracle-parity-handoff.md`
> (entries (o)-(u) 누적, 측정-fact 적재 SSOT)
> **governance**: g3 — 측정 전엔 `CLOSED_MEASURED` flip 금지

## Status (snapshot 2026-05-21 KST, post-PR #247 SSA fix · selftest closed)

- `measurement_gate = OPEN`
- `absorbed = false`
- gate target area ∈ [58,675, 64,851] µm² (±5 % of oracle 61,762.99)
- both oracles bit-exact reproducible (d4 61,762.99 / d6 93,608.53 / ratio 1.5156×)
- **live mac-side measurement** (`hexa run stdlib/yosys/gate_record.hexa`):
  - `router_d4 area=0.0 µm² oracle=61763 µm² Δ=100.0% FAIL (±5%)`
  - `router_d6 area=0.0 µm² oracle=93608.5 µm² Δ=100.0% FAIL (±5%)`
  - measurement chain alive: proc → flatten → opt → proc_mux → clean_multidriver → techmap → dfflibmap → abc_map all `[OK]`
- **PR landing reality** (corrected after audit):
  - PR #242 (`cee28986`, our #4i mixed-block fallback) = **CLOSED** as superseded-by-#245 (2026-05-20 session)
  - PR #245 (`66a39a31`, sibling RFC 073 Phase 3e) = MERGED 2026-05-20T14:37:37Z
  - **PR #247** (`8dd1e677`, ABC comb-loop SSA fix) = **OPEN** — selftest 76/76 PASS (T73 added), pre-merge review
  - prior #4h-a/b/g + write_verilog wire/cell/$dff stack: all merged via earlier PRs

**closure path (per g3) — re-scoped after Phase 3e + PR #247**:
- ~~ABC comb-loop blocker~~ ← **SSA fix shipped in PR #247** (selftest 76/76 + SSA chain emit evidence in clean_multidriver log: `idx__ssa1..7`, `grant_out__ssa7`, `any_grant__ssa7` chains)
- ~~ABC binary detection blocker~~ ← **abc_map fix shipped in PR #247 second commit** (`f4c3c493`): `abc_binary_path()` 가 `which abc` (shell-meta-free) 사용으로 spawn fast path reachable. `HEXA_EXEC_NO_SHELL=1 hexa run stdlib/yosys/gate_record.hexa` → `[abc_map] binary=/opt/homebrew/bin/abc · exit=0 · abc_map: ok` for both d4/d6. chain end-to-end functional
- **새 blocker (별개 issue)**: `str(float)` 가 literal `(float)` 출력 → gate_record 의 area verdict line 이 `area=(float) µm²` 으로 emit. 실제 area numeric 값을 print 로 확인 불가 (in-process numeric comparison 은 여전히 가능). 별도 runtime/codegen fix 필요
- ~~comb-side share/freduce parity~~ ← **deferred** : meaningless while area=0.0
- closure 100% 까지: (a) PR #247 review/merge + (b) **exec runtime bug fix** ← new blocker, separate scope + (c) area > 0 측정 확인 + (d) ±5 % gate 진입 + (e) (가능하면) share/freduce comb-gap closure + (f) g3-conditional gate flip

**infra side-note (measurement 와 무관)**:
- `tool/ubu_bootstrap.sh` 는 `ecd4d042` (RFC 065 cycle) 에서 `archive_legacy_glue/` 로 옮겨짐. mac-side measurement 는 `hexa run stdlib/yosys/gate_record.hexa` 가 standalone 동작 (substrate ABC + SKY130 만 있으면) — bootstrap script 부재는 ssh-to-ubu2 remote rebuild 자동화의 부재일 뿐 measurement chain 차단 아님

## Checklist

### Done ✓

- [x] **#4j driver-link SEGFAULT root-caused + in-tree fixed** (handoff (o))
  - hexa-cc 가 `__hexa_strlit_init` 를 static-emit → multi-file link 시 외부 호출 불가
  - sed workaround: per-file rename + drop-static
- [x] **router_d4 RTLIL first-measured** (p): wires=119, cells=35, 0 sequential
- [x] **cell-name source-mapped** (r): 25 cells = generate-for L48-55, 10 cells = arbiter rotation
- [x] **oracle bit-exact 재현** (s): 61,762.985600 µm² via `synth` macro + flat_v2k + SKY130 tt
- [x] **parser-gap asymmetry 식별** (t): hexa-native canonical OK · yosys 0.65 flat_v2k OK · 서로 못 읽음
- [x] **2-line dispatch fix (parameter + initial)** (u): in-tree verified on ubu-2 worktree, selftest 54/54 PASS
  - flat_v2k 도 hexa-native 로 parse 가능 → direct gap measurement unlocked

### Next (priority-ordered)

- [x] **PR-A: 2-line read_verilog dispatch + T48/T49 selftest → hexa-lang origin/main** ✓ LANDED
  - PR #196 merged at `929e9ca2` (admin-merge, bootstrap CI still infra-failing)
  - branch: `rfc006-yosys-param-initial-dispatch`
  - measured: selftest **58/58 PASS** (base 56 + T48 + T49), regression 0
  - flat_v2k/router_d4.v now parses via hexa-native → §5 measurement chain unblocked on input side
- [x] **PR-B: hexa-cc `__hexa_strlit_init` unique-emit** ✓ LANDED (hexa-lang PR #208 `adbb9e3b`)
  - 4-site codegen edit (L1329 + L1389 + L7985 + L8021), within-TU caller+def rename together
  - emit form: `void __hexa_strlit_init__<TU>(void)` (non-static), TU = `_hexa_cert_module_name()`
  - chunk-internal `_<N>` helpers 그대로 static
  - **note**: binary rebuild (bootstrap chain) 필요 — effect 는 다음 build cycle 부터. 다음 hexa-cc binary 가 emit 시작하면 sed workaround 자동 제거
- [x] **#4g function-body preceding-stmts inline** ✓ LANDED (hexa-lang PR #202 `41c7b1fc`)
  - new helper `_rv_collapse_func_body_with_prefix` (~50 lines) — handles reg/integer/wire decls + begin/end wrap + blocking-assigns + SSA-style substitution into existing cascaded-if collapse
  - T50 selftest: route_xy-shaped body inlines to `$mux(S=$gt(h,0), A=0, B=1, Y=r)` — exact-count 1 × $gt + 1 × $mux
  - selftest 60/60 → 61/61 PASS, regression 0
  - call-site `grant_out = route_xy(...)` now inlines; emit unblocks once #4h bridges the LHS-indexing gap
- [x] **#4h sub-steps a + b + c + d** ✓ LANDED via combined work (PR #216, PR #220 + sibling RFC 073 Phase 2)
  - #4h-a: multi-LHS static-idx (PR #216 `2bcb8b72`)
  - #4h-b: multi-LHS dyn-idx (PR #220 `85bea9a5`)
  - #4h-c: for-in-always multi-stmt body — **discovered already in tree** at read_verilog.hexa L3576-3607 (sibling work; const-fold indexed-LHS handler in for-body inner-loop plain-assign path)
  - #4h-d: nested-if inside always-body — **discovered already in tree** at L3476+ (sibling RFC 073 Phase 2 implementation)
- [~] **#4i with-else top-level outer wrapper** — **SUPERSEDED by PR #245 (Phase 3e)**, our PR #242 still OPEN
  - our cee28986 approach: outer if-handler cells-count gated fallback + `_rv_emit_for_if_stmts` extension. multi-driver caveat 있음
  - Phase 3e (`66a39a31`) approach: `_rv_emit_body_v2` per-LHS D-wire emission + caller-side single $dff per LHS + `connect_cond` + `pass_proc_mux` fold. **multi-driver invariant preserved** across recursive arms — strictly superior
  - action: close PR #242 with "superseded by #245" comment, delete local branch
  - lesson (already captured in Phase 3d status note `Lessons` section): `git log --oneline origin/main -10 -- <file>` before starting work on a high-traffic file
- [x] **write_verilog chain via driver link** ✓ LANDED (PR #210 wire-emit + PR #212 cell-emit behavioural)
  - PR #210 `116d6799`: width prefix + escaped-identifier — substrate parse OK (wires=134, cells=55)
  - PR #212 `b0a800f3`: behavioural-form dispatch (16 binop + 3 unary + $mux) — substrate `synth` macro 가 hexa-native output 처리 가능
  - selftest 9/9 → 12/12 PASS, regression 0
  - 검증: end-to-end substrate chain (read_verilog → hierarchy → synth → dfflibmap → abc → stat) runs without errors on hexa-native router_d4 output
- [x] **ABC comb-loop SSA fix** ✓ **SHIPPED in PR #247** (`8dd1e677`)
  - 3 helpers + branch in `_rv_parse_always` for-handler (L4124): `_rv_signal_is_read_in_body` · `_rv_collect_blocking_lhs` · `_rv_ssa_rename_toks`. Token-level rewriting (no signature changes), filter to read-then-write LHS only (T58~T65 write-only path preserved)
  - selftest 75 → 76/76 PASS (T73 `F-RFC-RV-COMB-LOOP-SSA-ARBITER`), zero regression
  - IR-level evidence: `pass_proc_mux lowered 44 cond-tagged LHS-group(s)` for d6 (vs 3 pre-fix), `clean_multidriver` collapsing `idx__ssa1..7`, `grant_out__ssa7`, `any_grant__ssa7` chains last-wins
  - end-to-end area measurement blocked by separate `exec` runtime bug (see Status)
- [~] **exec runtime bug** — root cause narrowed (별개 scope, popen path 만 broken)
  - 진단 결과: `hexa_exec` 의 *popen* path 가 모든 cmd 에 빈 stdout 반환. *spawn* fast path (`HEXA_EXEC_NO_SHELL=1` 환경 + shell-meta-free cmd) 는 정상. 즉 `command -v abc 2>/dev/null || true` (meta 포함) 는 popen → broken; `which abc` (meta-free) + env set 은 spawn → works
  - **workaround landed in PR #247 second commit** (`f4c3c493`): `abc_map.hexa::abc_binary_path()` 가 `which abc` 사용. ABC chain end-to-end 통과 가능
  - **underlying popen bug 자체는 여전히 open** — `self/runtime_core.c:4607-4626` 의 popen + fread + pclose path 의 child→parent pipe 가 EOF early 또는 stdio state corruption. 별도 dtrace/perror instrumentation 필요. `inbox/notes/2026-05-21-hexa-exec-broken-pipe.md` 진단 (UPDATE entry) 참조
- [ ] **str(float) runtime bug** (new blocker, str(float) emits literal `(float)`)
  - 증상: gate_record 의 area verdict line 이 `area=(float) µm² oracle=(float) µm² Δ=(float)%` 으로 emit. numeric 값 print 자체가 broken
  - in-process numeric comparison 은 여전히 동작 가능 → workaround 또는 fix 둘 다 가능. 별도 runtime/codegen fix scope
- [ ] **share/freduce parity** (comb-side oracle gap, **deferred — area > 0 이후만 의미 있음**)
- [ ] **share/freduce parity** (comb-side oracle gap, **deferred — area > 0 이후만 의미 있음**)
  - oracle 의 12k 차이 = `synth` macro 의 logic-sharing optimizations
  - 옵션: hexa-native passes 가 자체 share/freduce 구현 · 또는 substrate yosys 에 defer
  - dependency: ABC comb-loop fix (✓ PR #247) + exec runtime fix → area > 0 → 측정-driven impl
- [ ] **re-measure router_d4 area** (chain runs, area still 0.0 due to exec runtime bug)
  - target: ∈ [58,675, 64,851] µm² (±5 % of 61,762.99) · current 0.0 µm² Δ=100%
  - dependency: exec runtime bug fix (ABC binary detection works) + PR #247 merged
  - alt: substrate-yosys-as-tail-pass (hexa-native frontend → substrate `synth` macro tail) — bridges share/freduce parity 자동
- [x] **router_d6 oracle bit-exact 재현** ✓: 93,608.528000 µm² · ratio 1.5156× (oracle 일치) — substrate measurement reference 완전 fixed
- [x] **cell-tally re-measure post-#4g** ✓ (handoff (x)): 35 → 55 cells (+20 comb), sequential still 0, gap 99.5%
- [x] **#4h-a multi-LHS body static-idx LHS** ✓ LANDED (PR #216 `2bcb8b72`, selftest 65/65 PASS) — first sequential emit primitive
- [x] **첫 sequential cells emit 확인** ✓: `test_4h_a.v` (multi-LHS no-else indexed-LHS) → 4 cells: 2×$mux + 2×$dff (handoff (aa) measurement)
- [x] **#4h-b multi-LHS body dyn-idx LHS** ✓ LANDED (PR #220 `85bea9a5`) — per-element ($eq+$and+$mux+$dff)×bound chain in multi-LHS context. T52 selftest: 4×$eq + 4×$and + 4×$mux + 4×$dff for 2 statements × bound=2
- [x] **write_verilog $dff behavioural emit** ✓ LANDED (PR #219 `c20b30b4`, selftest 13/13, conflict resolved + admin-merge) — substrate handoff complete for $dff sequential cells
- [ ] **§5 measurement_gate = CLOSED_MEASURED · absorbed=true** (g3 — only after measurement passes)

## Schedule (rough, post-Phase 3e re-scope)

| step                     | scope                                       | session-cost | dependency      |
|--------------------------|---------------------------------------------|--------------|-----------------|
| close PR #242            | comment + close + branch cleanup            | 10 min       | none            |
| ABC comb-loop SSA design | trace `any_grant` flow + design renaming    | 0.5-1        | Phase 3e read   |
| ABC comb-loop SSA impl   | `_rv_emit_body_v2` extension + selftest     | 1-2          | design          |
| re-measure (area > 0?)   | `hexa run stdlib/yosys/gate_record.hexa`    | 5 min        | impl            |
| share/freduce design     | substrate-tail vs hexa-native impl 결정      | 0.5-1        | area > 0        |
| share/freduce impl       | passes.hexa 확장 또는 tail wiring            | 1-3          | design          |
| gate flip                | g3-conditional ±5 % achieved → flip         | 10 min       | measurement     |

총 estimate (이전 6-12 → post-Phase 3e): **3-7 sessions** until gate close (ABC fix 가 single-session 안 풀리면 +2-3)

## Future Roadmap (brainstorm-pruned 2026-05-20)

FLOW pattern: 풀기 (84+ items generated) → 자르기 (delete 75 off-scope items, 89% prune) → 잡기 (each survivor with measurement protocol).

### Tier-1: §5 closure path (immediate, multi-session) — post-Phase 3e

- [~] ~~**#4i with-else outer wrapper**~~ — SUPERSEDED by PR #245 (Phase 3e). PR #242 close pending
- [ ] **ABC comb-loop SSA fix** ← real critical blocker (Phase 3e 가 명명)
  - signal: ABC stops reporting 'Network contains combinational loop' · first non-zero $dff cells in mapped BLIF · router_d4 area > 0
  - scope: per-iteration SSA renaming in `_rv_emit_for_if_stmts` (L1947) + `_rv_emit_body_v2` — `any_grant_i0/i1/...` per unroll index, fed to anti-dependency tree downstream
  - dependency: read of Phase 3e impl + understanding of unroll loop var binding
- [ ] **end-to-end router_d4 area measurement** (already runs, currently 0.0)
  - signal: `hexa run stdlib/yosys/gate_record.hexa` reports area > 0
  - dependency: ABC comb-loop SSA fix
- [ ] **router_d4 gate flip** (`measurement_gate = CLOSED_MEASURED`, `absorbed = true`)
  - signal: measured area ∈ [58,675, 64,851] µm² (±5 % of oracle 61,762.99)
  - dependency: end-to-end measurement passing; **g3-conditional only**
- [ ] **router_d6 parity** (oracle 93,608.53 µm²)
  - signal: measured area ∈ [88,928, 98,289] µm² (±5 %)
  - dependency: router_d4 gate close (same pipeline)
- [ ] **ratio 1.5156× verification** (d6/d4 from hexa-native chain)
  - signal: measured d6/d4 ratio ∈ [1.4399, 1.5914] (±5 %)
  - dependency: both d4 + d6 measured

### Tier-2: §5 post-closure expansion (week+ scope)

- [ ] **$adff / $sdff / $dffe write_verilog behavioural emit**
  - signal: T14/T15/T16 selftest covers `always @(posedge clk, posedge rst) if (rst) q <= 0; else q <= d;` round-trip
  - need: router-class designs with reset/enable variants
- [ ] **RTLIL Memory cell emission** ($memrd / $memwr for `fifo_mem[p][addr]` patterns)
  - signal: router_d4's `fifo_mem[pp][fifo_tail[pp][...]] <= in_data[pp]` lowers to actual memory cells
  - need: read_verilog packed-array 2-D LHS handler + write_verilog Memory emit + substrate `memory_dff` pass round-trip
- [ ] **share/freduce parity** (comb-side oracle gap closure — handoff (s) finding)
  - signal: hexa-native synth comb area within ±10 % of `synth` macro's 12,806 µm² comb portion (after share/freduce)
  - need: stdlib/kernels/logic_synth/passes.hexa 의 share + freduce 알고리즘 implementations
  - alt: substrate-yosys-as-tail-pass (hexa-native frontend → substrate `synth` tail)
- [ ] **formal equivalence check** (yosys `eq` command)
  - signal: `yosys -p "read_verilog hexa_native_out.v; read_verilog -lib oracle.v; equiv_make oracle hexa_native eq; equiv_simple; equiv_status"` reports `0 unproven`
  - need: §5 cross-verification — hexa-native RTLIL semantically equivalent to substrate's oracle RTLIL

### Tier-3: announcement + governance close

- [ ] **ABSORPTION.md final update**
  - signal: §178 Yosys absorption row flipped to `absorbed=true · measured area passes ±5 %`
  - dependency: Tier-1 all ✓
- [ ] **rfc_006 §5 closure announcement** (the goal of this multi-session work)
  - signal: `rfc_006/§5 measurement_gate = CLOSED_MEASURED · absorbed=true · 2026-MM-DD measured` adopted in ROADMAP + commit message
  - dependency: ABSORPTION.md updated

### Cycle exhaustion log

- generated 84 candidate items across 11 categories (synth-subset, sequential variants, multi-bit & RTLIL, read scope, opt parity, mapping, verification, reporting, infra, tool ecosystem, RFC absorption, docs, lattice/gov)
- pruned to 12 keepers (89 % delete rate, satisfies delete ≥ add)
- each keeper has 1-line measurement signal (FLOW 잡기 단계)

## Log

(append-only, latest 위에)

- 2026-05-21 KST — **PR #247 second commit `f4c3c493`** : `abc_map.hexa::abc_binary_path()` 가 `command -v abc 2>/dev/null || true` → `which abc` 으로 변경 (shell-meta-free → spawn fast path 진입 가능). root cause 진단 결과: `hexa_exec` 의 popen path 가 broken, spawn path (HEXA_EXEC_NO_SHELL=1 + meta-free cmd) 는 정상. ABC chain end-to-end 통과 확인 — `[abc_map] binary=/opt/homebrew/bin/abc · exit=0 · [OK] d4/d6 abc_map: ok`. 또 다른 별개 runtime bug 발견: `str(float)` 가 literal `(float)` 출력 → area verdict numeric 값 print 안 됨 (in-process comparison 은 가능)
- 2026-05-21 KST — **ABC comb-loop SSA fix landed in PR #247** (hexa-lang `8dd1e677`, OPEN). +393/-1 in `read_verilog.hexa`. 3 clean-room helpers (`_rv_signal_is_read_in_body` · `_rv_collect_blocking_lhs` · `_rv_ssa_rename_toks`) plumbed into `_rv_parse_always` for-handler at L4124. Per-iteration SSA versioning (`s__ssa0..ssaP`) of read-then-write blocking-LHS only — write-only filter preserves T58~T65 legacy path. T73 `F-RFC-RV-COMB-LOOP-SSA-ARBITER` selftest added (P=4 priority arbiter); 75/75 → 76/76 PASS, zero regression. IR-level evidence in `clean_multidriver` log: d6 의 `idx__ssa1..ssa7` + `grant_out__ssa7` + `any_grant__ssa7` chains collapsed last-wins, `pass_proc_mux` lowered 44 cond-tagged LHS-groups (vs 3 pre-fix)
- 2026-05-21 KST — PR #242 (#4i `cee28986`) **CLOSED** with "superseded by #245 Phase 3e" comment via `gh pr close --comment`. branch `rfc006-yosys-4i-with-else-mixed-block` 보존 (재검토 필요시)
- 2026-05-20 23:30 KST — **status g3-honest correction (audit)**: 이전 entry 들의 wrong claim 3건 정정:
  1. "PR #242 cee28986 admin-merge" → **PR #242 still OPEN**, `gh pr view 242 --json state` = `OPEN`. branch `rfc006-yosys-4i-with-else-mixed-block` 에만 존재. close 예정 ("superseded by #245")
  2. "ubu-2 측정 chain 막힘 · `tool/ubu_bootstrap.sh` 부재가 blocker" → wrong. measurement chain alive (mac-side `hexa run stdlib/yosys/gate_record.hexa` 라이브 동작). bootstrap script 부재는 ssh-to-ubu2 remote-build 자동화 부재일 뿐
  3. "next blocker = share/freduce comb gap (12k µm²)" → wrong. area=0.0 µm² (오라클 측정 라이브 확인) → share/freduce 가 의미 있으려면 area > 0 먼저
- 2026-05-20 23:30 KST — **sibling PR #245 (Phase 3e) `66a39a31`** MERGED 14:37:37Z. 3 named blockers CLOSED via `_rv_emit_body_v2` (per-LHS D-wire + caller-side single $dff + connect_cond + pass_proc_mux fold): #1 for-loop indexed-LHS, #2 with-else NON-MATCHING bodies (= 우리 #4i scope superseded), #3 nested-if in else-body. 부가: sized-literal lowering, BLIF `.latch` emission. new blocker layer 명명: ABC combinational-loop (`any_grant` blocking-assign + per-iter SSA renaming 필요)
- 2026-05-20 23:30 KST — **라이브 mac-side measurement** (gate_record.hexa): router_d4 area=0.0 oracle=61763 Δ=100% FAIL · router_d6 area=0.0 oracle=93608.5 Δ=100% FAIL. chain all `[OK]` (proc→flatten→opt→proc_mux→clean_multidriver→techmap→dfflibmap→abc_map). ABC exit=0 but 0 cells → comb-loop error path
- 2026-05-20 — **#4i landed**: hexa-lang PR #242 `cee28986` (outer with-else mixed-statement begin-block fallback in `_rv_parse_always` + `_rv_emit_for_if_stmts` 확장 [for-loop unroll + indexed-LHS plain-stmt] + T70 selftest). +208/-3 lines. selftest 70/73 PASS (T70 PASS, T65a/b/c origin/main pre-existing 회귀 — stash-baseline diff로 확인). rebased on origin/main `116cdbf7`. **infra discovery**: `tool/ubu_bootstrap.sh` origin/main에서 제거됨 (post `ecd4d042` RFC 065 cycle) — ubu-2 mac-side rebuild mechanism 부재. 다음 step blocker  *[NOTE 2026-05-20 23:30: 이 entry 의 "landed" claim 은 wrong, "infra blocker" claim 도 wrong — 위 정정 entry 참조]*
- 2026-05-20 — **cycle closure**: 9 PRs landed (all merged into hexa-lang origin/main) · 13 local branches deleted · 7 remote branches deleted · 13 demiurge handoff entries (o)-(aa) committed. All my work cycles closed. Remaining 3 ☐ items (#4i · measurement · gate flip) inherited as multi-session work for next dedicated session
- 2026-05-20 — PR #219 landed: hexa-lang `c20b30b4` (write_verilog $dff behavioural emit, sibling conflict resolved). **9 PRs cumulative**. substrate handoff complete for $dff sequential cells
- 2026-05-20 — #4h-b landed: hexa-lang PR #220 `85bea9a5` (multi-LHS body dyn-idx LHS + T52, per-element $eq+$and+$mux+$dff chain). 8 PRs cumulative
- 2026-05-20 — #4h-a landed: hexa-lang PR #216 `2bcb8b72` (multi-LHS body static-idx LHS + T51, selftest 65/65). First sequential emit primitive
- 2026-05-20 — sequential emit confirmed: test_4h_a.v (multi-LHS indexed-LHS) → 2×$mux + 2×$dff cells. milestone
- 2026-05-20 — PR #219 OPEN (write_verilog $dff behavioural emit, in-tree verified 13/13, merge conflict with sibling work on compiler/PLAN.md)
- 2026-05-20 — PR #212 landed: hexa-lang `b0a800f3` (write_verilog cell-emit behavioural form, 16 binop + 3 unary + $mux). substrate `synth` chain end-to-end functional. 단 hexa-native cells 모두 disconnected (always-body LHS-write 부재) → opt_clean removes → final cells=0
- 2026-05-20 — substrate handoff parse 동작 확인: yosys read_verilog(hexa-native output) → wires=134, cells=55, type 완전 일치. 다만 synth macro fail (cell-emit 가 behavioral 아닌 instance form)
- 2026-05-20 — PR #210 landed: hexa-lang `116d6799` (write_verilog wire-emit width prefix + escaped-identifier, selftest 9/9)
- 2026-05-20 — PR-B landed: hexa-lang PR #208 `adbb9e3b` (codegen_c2.hexa strlit-init unique-emit, 4-site within-TU rename). 효과는 bootstrap chain 후
- 2026-05-20 — cell-tally re-measure post-#4g: 35 → 55 cells (+57%), 20 new all-combinational (5×$and, 10×$logic_not, 5×$logic_and = always-body condition expressions). Sequential still 0. Gap to oracle 99.5%
- 2026-05-20 — #4g landed: hexa-lang PR #202 `41c7b1fc` (function-body preceding-stmt prefix + T50, selftest 61/61). route_xy inline 가능
- 2026-05-20 — router_d6 oracle 재현: 93,608.528 µm² (cited 일치, ratio 1.5156×) — d4+d6 양쪽 oracle reproducible
- 2026-05-20 — ternary `?:` support 가 sibling 으로 origin/main 에 land (43e1dcc0) — #4g 의 prerequisite 충족
- 2026-05-20 — PR-A landed: hexa-lang PR #196 `929e9ca2` (2-line dispatch + T48/T49, selftest 58/58)
- 2026-05-20 — 루트 YOSYS.md 생성, 체크리스트 + 일정 적재 (이번 세션 누적 측정-fact 기반)
- 2026-05-20 — 자세한 측정-fact 는 `inbox/notes/rfc006-s5-area-oracle-parity-handoff.md` (o)-(u)
- 이전 — rfc_006 §4 (7 yosys modules) absorbed, §5 measurement gate OPEN
