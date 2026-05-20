# YOSYS — rfc_006 §5 area-oracle parity (장기전 roadmap)

> **domain**: hexa-lang yosys absorption · §5 measurement gate
> **goal**: hexa-native synth 가 substrate yosys+SKY130 의 oracle area
> (router_d4 = 61,762.99 µm²) 를 ±5 % 안에서 재현 → `absorbed=true`
> **detail handoff**: `inbox/notes/rfc006-s5-area-oracle-parity-handoff.md`
> (entries (o)-(u) 누적, 측정-fact 적재 SSOT)
> **governance**: g3 — 측정 전엔 `CLOSED_MEASURED` flip 금지

## Status (snapshot 2026-05-20, post-PR #220 + PR #219)

- `measurement_gate = OPEN`
- `absorbed = false`
- gate target area ∈ [58,675, 64,851] µm² (±5 % of oracle 61,762.99)
- both oracles bit-exact reproducible (d4 61,762.99 / d6 93,608.53 / ratio 1.5156×)
- **9 PRs landed cumulative** this session sequence
- hexa-native sequential emit primitives 모두 landed (#4h-a static-idx, #4h-b dyn-idx, write_verilog $dff behavioural)
- substrate handoff full functional (comb + $dff round-trip verified)

**closure path (per g3) — refined after code-review discovery**:
- #4h sub-steps a/b/c/d ALL landed (a/b in our PRs, c/d in sibling work)
- **single critical blocker = #4i** (outer with-else top-level wrapper)
- ubu-2 측정 chain rebuild (hexa-cc binary outdated by sibling
  codegen feature) — separate infra fix
- closure 100% 까지: (a) #4i land + (b) ubu-2 chain rebuild +
  (c) router_d4 area ±5 % 측정 + (d) g3-conditional gate flip

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
- [ ] **#4i with-else top-level outer wrapper (begin-block mixed-stmt body)** — **the single critical blocker** for router_d4 always-body emit
  - router_d4 L98-123: outer `if (rst) begin scalar; for(...) ...; end else begin for(...) ...; for(...) ...; if(any_grant) begin ...; end; end`
  - **scope refinement (code-review)**: with-else cond-mux (PR #115) 와 multi-LHS with-else (sibling) 가 *single-statement* 또는 *uniform-statement-sequence* both-branch 만 처리. router_d4 의 outer 는 **mixed-statement begin-block** (scalar + for-loop + nested-if 섞임) in both branches — 별도 처리 필요
  - implementation: always-parser 의 if-handler 가 begin-block body 를 statement-by-statement walk + 각 statement 의 individual emit (scalar/indexed assign / for-loop / nested-if) dispatch. ~150-200 line scope (always-parser 의 outer entry extension)
  - signal: router_d4 cell-tally 첫 sequential cells (predicted ~64 cells: 4 scalar $dff + bound×3 indexed $mux+$dff for reset branch + similar for else branch)
- [x] **write_verilog chain via driver link** ✓ LANDED (PR #210 wire-emit + PR #212 cell-emit behavioural)
  - PR #210 `116d6799`: width prefix + escaped-identifier — substrate parse OK (wires=134, cells=55)
  - PR #212 `b0a800f3`: behavioural-form dispatch (16 binop + 3 unary + $mux) — substrate `synth` macro 가 hexa-native output 처리 가능
  - selftest 9/9 → 12/12 PASS, regression 0
  - 검증: end-to-end substrate chain (read_verilog → hierarchy → synth → dfflibmap → abc → stat) runs without errors on hexa-native router_d4 output
- [ ] **share/freduce 또는 ABC -dff 옵션 통합** (comb-side oracle parity)
  - oracle 의 12k 차이 = `synth` macro 의 logic-sharing optimizations
  - 옵션: hexa-native passes 가 자체 share/freduce 구현 · 또는 substrate yosys 에 defer
  - dependency: #4h/#4i landed + write_verilog wire emit fix (substrate handoff 가능해야 함)
- [ ] **re-measure router_d4 area on flat_v2k via hexa-native end-to-end**
  - target: ∈ [58,675, 64,851] µm² (±5 % of 61,762.99)
  - dependency: all above. multi-day work — 위 sub-steps 들 landed 후만 가능
  - alt: substrate-yosys-as-tail-pass (hexa-native frontend → substrate `synth` macro tail) — bridges share/freduce parity 자동
- [x] **router_d6 oracle bit-exact 재현** ✓: 93,608.528000 µm² · ratio 1.5156× (oracle 일치) — substrate measurement reference 완전 fixed
- [x] **cell-tally re-measure post-#4g** ✓ (handoff (x)): 35 → 55 cells (+20 comb), sequential still 0, gap 99.5%
- [x] **#4h-a multi-LHS body static-idx LHS** ✓ LANDED (PR #216 `2bcb8b72`, selftest 65/65 PASS) — first sequential emit primitive
- [x] **첫 sequential cells emit 확인** ✓: `test_4h_a.v` (multi-LHS no-else indexed-LHS) → 4 cells: 2×$mux + 2×$dff (handoff (aa) measurement)
- [x] **#4h-b multi-LHS body dyn-idx LHS** ✓ LANDED (PR #220 `85bea9a5`) — per-element ($eq+$and+$mux+$dff)×bound chain in multi-LHS context. T52 selftest: 4×$eq + 4×$and + 4×$mux + 4×$dff for 2 statements × bound=2
- [x] **write_verilog $dff behavioural emit** ✓ LANDED (PR #219 `c20b30b4`, selftest 13/13, conflict resolved + admin-merge) — substrate handoff complete for $dff sequential cells
- [ ] **§5 measurement_gate = CLOSED_MEASURED · absorbed=true** (g3 — only after measurement passes)

## Schedule (rough)

| step       | scope        | session-cost | dependency |
|------------|--------------|--------------|------------|
| PR-A       | 1-file edit + 2 selftests + push | 30-60 min | dirty tree 정리 |
| PR-B       | codegen change + bootstrap rebuild + 1500+ selftest | 2-4 sessions | none |
| #4g        | read_verilog.hexa 확장 + T-test | 1-2 sessions | PR-A landed |
| #4h        | always-body dyn-idx emit | 1-2 sessions | #4g |
| #4i        | with-else dyn-idx + reset | 1-2 sessions | #4h |
| write_verilog chain | 3-file link + driver | 1 session | PR-B (or sed) |
| share/freduce | passes.hexa 확장 | 1-2 sessions | #4i |
| measurement | flat_v2k synth → area | 30 min | 위 모두 |

총 estimate: **6-12 sessions** until gate close

## Future Roadmap (brainstorm-pruned 2026-05-20)

FLOW pattern: 풀기 (84+ items generated) → 자르기 (delete 75 off-scope items, 89% prune) → 잡기 (each survivor with measurement protocol).

### Tier-1: §5 closure path (immediate, multi-session)

- [ ] **#4i with-else outer wrapper** (mixed-statement begin-block in both branches of `if (rst) ... else ...`)
  - signal: router_d4 cell-tally 첫 sequential cells (≥1 × `$dff` emit from hexa-native always-body)
  - scope: ~200 line always-parser if-handler extension at read_verilog.hexa L2256-2268
  - dependency: none (purely hexa-lang code)
- [ ] **ubu-2 hexa-cc binary rebuild** (resolve sibling struct-constructor codegen mismatch)
  - signal: `clang -o /tmp/rv_X /tmp/rv.c /tmp/passes.c ... ` link 성공 (no undefined `Module`/`Design` references)
  - scope: bootstrap chain — self/main.hexa compile → new binary → re-link
  - dependency: external (offline, multi-hour)
- [ ] **end-to-end router_d4 area measurement** (hexa-native → write_verilog → substrate yosys synth → stat)
  - signal: `yosys -p "synth -top router_d4; ... stat -liberty ..."` 결과 reports non-zero Chip area
  - dependency: #4i landed + ubu-2 chain rebuilt
- [ ] **router_d4 gate flip** (`measurement_gate = CLOSED_MEASURED`, `absorbed = true`)
  - signal: measured area ∈ [58,675, 64,851] µm² (±5 % of oracle 61,762.99)
  - dependency: end-to-end measurement passing; **g3-conditional only** (no flip without measurement)
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
