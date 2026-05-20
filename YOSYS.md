# YOSYS — rfc_006 §5 area-oracle parity (장기전 roadmap)

> **domain**: hexa-lang yosys absorption · §5 measurement gate
> **goal**: hexa-native synth 가 substrate yosys+SKY130 의 oracle area
> (router_d4 = 61,762.99 µm²) 를 ±5 % 안에서 재현 → `absorbed=true`
> **detail handoff**: `inbox/notes/rfc006-s5-area-oracle-parity-handoff.md`
> (entries (o)-(u) 누적, 측정-fact 적재 SSOT)
> **governance**: g3 — 측정 전엔 `CLOSED_MEASURED` flip 금지

## Status (snapshot 2026-05-21 KST · post-audit correction)

- `measurement_gate = OPEN`
- `absorbed = false`
- gate target area ∈ [58,675, 64,851] µm² (±5 % of oracle 61,762.99)
- both oracles bit-exact reproducible (d4 61,762.99 / d6 93,608.53 / ratio 1.5156×)
- **live mac-side measurement** (`HEXA_EXEC_NO_SHELL=1 hexa run stdlib/yosys/gate_record.hexa` + cleared `/tmp/_hexa_yosys_gate_*_out.blif`):
  - `router_d4 area=0.0 µm² oracle=61763 µm² Δ=100.0% FAIL (±5%)` — but verdict-derived
  - `router_d6 area=0.0 µm² oracle=93608.5 µm² Δ=100.0% FAIL (±5%)` — but verdict-derived
  - chain reports `[OK] abc_map` but this is a **false positive** — see audit below
- **PR landing reality**:
  - PR #242 (`cee28986`, our #4i mixed-block fallback) = **CLOSED** as superseded-by-#245 (2026-05-20 session)
  - PR #245 (`66a39a31`, sibling RFC 073 Phase 3e) = MERGED 2026-05-20T14:37:37Z
  - **PR #247** (`8dd1e677` SSA fix + `f4c3c493` abc_map binary fix) = **OPEN** — selftest 76/76 PASS, mergeStateStatus=UNSTABLE (bootstrap CI pre-existing infra-fail), no reviewer assigned

**post-audit closure path (per g3, honest)** — 2026-05-21 measurement-verified:

0. **#0 underlying blocker (NEW, supersedes everything below)**: `exec()` runtime broken in current `origin/main` (`9f2da3f6`). `exec("echo hello")` returns "" — both popen and posix_spawnp paths. Bisect points at libc-unhook cycles 61-65 (`f1487c14` … `54970996`). All subprocess-dependent stdlib is gated by this. inbox patch filed at `hexa-lang/inbox/patches/yosys-exec-runtime-regression-cycles-61-64.md`. **Until this is fixed, NO yosys measurement is real** — every gate_record run reports stale-file false positives or empty-binary fail-loud.
1. ~~ABC binary detection blocker~~ ← **fixed in PR #247 `f4c3c493`** (`which abc` instead of meta-bearing `command -v abc 2>/dev/null || true`). Workaround was correct for the cycle 60 era, but cycles 61-65 broke even the meta-free `which abc` path
2. ~~ABC comb-loop SSA blocker (idx / grant_out / any_grant)~~ ← **fixed in PR #247 `8dd1e677`** (per-iter SSA renaming). IR-level evidence in clean_multidriver log
3. **measured-but-currently-unreachable blocker** (manually verified with substrate `abc -c`): ABC `read_blif` rejects both d4 and d6 with `Network "router_d{4,6}" contains combinational loop!` — cycle terminating at CO `rr_ptr__d`. Path traverses `n272..n608..n272` (d4) and `n372..n830..n372` (d6). Confirmed by manual invocation:
   ```
   abc -c "read_lib <sky130.lib> ; read_blif <hexa-emit.blif>"
   → Constant-0 drivers added to 40 (d4) / 52 (d6) non-driven nets: fifo_mem[0..3], …
   → Network contains a combinational loop · Reading network from file has failed
   ```
   Two distinct sub-issues identified:
   - **3a · `fifo_mem[*]` undriven**: 2-D packed-array memory writes (`fifo_mem[pp][...] <= in_data[pp]`) emit no .gate/.latch — ABC ties them to const-0 as a recovery hack. These are stale carryover from "RTLIL Memory cell emission" item (Tier-2 list)
   - **3b · `rr_ptr__d` comb cycle**: round-robin pointer next-state logic forms a feedback loop through combinational gates without being broken by a flop. SSA fix renamed the *blocking-assign* chain (already-fixed in #247) but the *cross-iteration arbiter state* still loops back through unrolled mux/and gates
4. ~~`exec` runtime bug~~ — **reframed**: popen path still broken (`HEXA_EXEC_NO_SHELL=1` + meta-free required), but this is NOT what was blocking gate measurement. The chain reports `[OK] abc_map` even when ABC fails because `abc_emit_blif()` write succeeds + stale `_out.blif` from prior runs satisfies `read_file(blif_out)` non-empty check
5. ~~`str(float)` runtime bug~~ — **NOT reproducible** in current build. `area=0.0` / `oracle=61763` / `Δ=100.0%` all print fine. Reframe: anima `train_s185_psicouple.hexa` blocker filed at `hexa-lang/inbox/patches/stdlib-print-float-emits-type-tag-not-value.md` may be build-state-specific (not yosys-blocker)
6. ~~comb-side share/freduce parity~~ ← **deferred** : meaningless while area=0.0

**closure 100% needs** (revised after deeper audit):
- (0) **`exec()` runtime restore** (hexa-lang RUNTIME.md cycle 61-65 regression) — gates everything else. Targeted revert (option 1 in inbox patch) is the smallest path
- (a) ~~PR #247 review/merge~~ ✓ merged 2026-05-21 as `cdfa8d46`
- (b) abc_map.hexa: detect stale `_out.blif` → fail-loud (currently false-positive)
- (c) ~~abc_map.hexa: reorder script to `read_lib` BEFORE `read_blif`~~ ✓ already in PR #247 (logic_synth/abc_map.hexa L478-486)
- (d) fix `rr_ptr__d` comb-loop OR detect ABC's "combinational loop" error in stdout (latter is a 1-line addition)
- (e) emit `fifo_mem[*]` as RTLIL Memory cells (was Tier-2, now reframed as Tier-1 blocker for area > 0 on these designs)
- (f) re-measure: area > 0 → ±5 % gate → g3-conditional flip

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
  - **note (2026-05-21 audit)**: fixes the *intra-iteration* blocking-LHS comb-loop class, but a *cross-iteration arbiter-state* comb-loop terminating at `rr_ptr__d` remains — see new blocker below
- [ ] **abc_map false-positive (stale `_out.blif`)** ← NEW (audit 2026-05-21)
  - `abc_map.hexa::abc_map()` checks `read_file(blif_out) != ""` as success heuristic. If `exec(abc_cmd)` silently fails (popen broken or ABC errors), the stale `_out.blif` from a prior run is read → false `abc_map: ok` + `area=0.0` (stale BLIF cells don't match current oracle target)
  - fix: `exec` 호출 직전 `write_file(blif_out, "")` (truncate) 또는 `delete_file(blif_out)` (if available) + post-exec mtime/size check + parse ABC stdout for "combinational loop" / "Error:" / "failed"
- [ ] **abc_map script order: read_lib BEFORE read_blif** ← NEW (audit 2026-05-21)
  - emitted BLIF has `.gate sky130_fd_sc_hd__buf_1 ...` at line 4. ABC's `read_blif` rejects `.gate` references when no library is loaded ("The current library is not available")
  - current script: `read_blif … ; strash ; read_lib … ; map ; write_blif …` → fails at line 4 (= first .gate line of BLIF)
  - fix: reorder to `read_lib … ; read_blif … ; strash ; map ; write_blif …`. Manual verify (2026-05-21): with reorder, lib loads (334 cells) and read_blif proceeds until comb-loop check
- [ ] **`rr_ptr__d` cross-iteration comb-loop** ← NEW critical (audit 2026-05-21)
  - manual ABC re-run with corrected script order: `Network "router_d{4,6}" contains combinational loop · Node "n272" (d4) / "n372" (d6) encountered twice on path to CO "rr_ptr__d"` (~15 hop d4 / ~30 hop d6)
  - root: round-robin arbiter's *next-state* logic uses unrolled mux/and cascade that re-reads `rr_ptr` value combinationally without breaking at the flop boundary. PR #247 SSA fix did intra-iteration blocking-assign chain (`idx__ssa*`, `grant_out__ssa*`, `any_grant__ssa*`); this is a different comb feedback layer
  - investigation needed: emit signature inspection of `rr_ptr` and its mux-cascade fan-in; possibly per-iteration `rr_ptr__ssa*` chain or proper $dff-D wire isolation
- [ ] **`fifo_mem[*]` undriven (RTLIL Memory cells)** ← reframed Tier-1 (was Tier-2)
  - manual ABC re-run: `Constant-0 drivers added to 40 (d4) / 52 (d6) non-driven nets: fifo_mem[0], fifo_mem[1], ...`. 2-D packed-array `fifo_mem[pp][...] <= in_data[pp]` writes silently dropped at frontend
  - dependency: read_verilog 2-D packed-array LHS handler + write_verilog `$memrd`/`$memwr` emit + substrate `memory_dff` parity
- [~] **exec runtime bug** — reframed (was claimed gate blocker, isn't)
  - popen path still broken (`hexa_exec` 모든 cmd 에 빈 stdout). spawn fast path (`HEXA_EXEC_NO_SHELL=1` + meta-free) 정상
  - **2026-05-21 audit**: not the gate blocker. `[abc_map] exit=0` 는 stdout 미캡쳐로 인한 false positive (Error: 패턴 매치 실패). 진짜 gate 막힘은 above 3 items (script order + comb-loop + memory cells)
  - underlying popen bug 자체는 여전히 open — `self/runtime_core.c:4607-4626` 의 popen + fread + pclose path. 별도 dtrace/perror instrumentation 필요. `inbox/notes/2026-05-21-hexa-exec-broken-pipe.md` 진단 참조
- [~] **`str(float)` runtime bug** — NOT reproducible 2026-05-21
  - 현 build 에서 `area=0.0`, `oracle=61763`, `Δ=100.0%` 모두 정상 print. 이전 claim 은 다른 build-state 였을 가능성
  - anima `train_s185_psicouple.hexa` 의 동일 증상은 별개 inbox patch: `hexa-lang/inbox/patches/stdlib-print-float-emits-type-tag-not-value.md` (anima 가 보는 build 만 broken 가능성)
  - YOSYS gate measurement 와 무관 — 이전 우선순위 격하
- [ ] **share/freduce parity** (comb-side oracle gap, **deferred — area > 0 이후만 의미 있음**)
  - oracle 의 12k 차이 = `synth` macro 의 logic-sharing optimizations
  - 옵션: hexa-native passes 가 자체 share/freduce 구현 · 또는 substrate yosys 에 defer
  - dependency: ABC comb-loop fix + memory cell emit → area > 0 → 측정-driven impl
- [ ] **re-measure router_d4 area** (chain reports OK but doesn't actually measure)
  - target: ∈ [58,675, 64,851] µm² (±5 % of 61,762.99) · current 0.0 µm² Δ=100%
  - dependency: above 3 new blockers (script order + rr_ptr loop + fifo_mem cells)
  - alt: substrate-yosys-as-tail-pass (hexa-native frontend → substrate `synth` macro tail) — bridges share/freduce parity AND fifo_mem auto, but defeats the purpose of hexa-native absorption
- [x] **router_d6 oracle bit-exact 재현** ✓: 93,608.528000 µm² · ratio 1.5156× (oracle 일치) — substrate measurement reference 완전 fixed
- [x] **cell-tally re-measure post-#4g** ✓ (handoff (x)): 35 → 55 cells (+20 comb), sequential still 0, gap 99.5%
- [x] **#4h-a multi-LHS body static-idx LHS** ✓ LANDED (PR #216 `2bcb8b72`, selftest 65/65 PASS) — first sequential emit primitive
- [x] **첫 sequential cells emit 확인** ✓: `test_4h_a.v` (multi-LHS no-else indexed-LHS) → 4 cells: 2×$mux + 2×$dff (handoff (aa) measurement)
- [x] **#4h-b multi-LHS body dyn-idx LHS** ✓ LANDED (PR #220 `85bea9a5`) — per-element ($eq+$and+$mux+$dff)×bound chain in multi-LHS context. T52 selftest: 4×$eq + 4×$and + 4×$mux + 4×$dff for 2 statements × bound=2
- [x] **write_verilog $dff behavioural emit** ✓ LANDED (PR #219 `c20b30b4`, selftest 13/13, conflict resolved + admin-merge) — substrate handoff complete for $dff sequential cells
- [ ] **§5 measurement_gate = CLOSED_MEASURED · absorbed=true** (g3 — only after measurement passes)

## Schedule (rough, post-2026-05-21 audit re-scope)

| step                          | scope                                                                | session-cost | dependency             |
|-------------------------------|----------------------------------------------------------------------|--------------|------------------------|
| abc_map script reorder        | `read_lib` 먼저, `read_blif` 뒤로 + T74 selftest                       | 0.3-0.5      | none                   |
| abc_map false-positive guard  | `_out.blif` truncate-before-exec + stdout `combinational loop`/`Error:`/`failed` 매칭 | 0.3-0.5      | none                   |
| re-measure (true area > 0?)   | `HEXA_EXEC_NO_SHELL=1 hexa run …gate_record.hexa` after both fixes   | 5 min        | above two              |
| rr_ptr__d comb-loop trace     | emit-side dump · 어디서 unrolled mux 가 self-feedback 인지 식별        | 1-2          | re-measure (loop 확인) |
| rr_ptr cross-iter SSA / D-iso | per-iteration rr_ptr renaming OR D-wire isolation (PR #245 패턴 응용) | 2-4          | trace                  |
| fifo_mem RTLIL Memory emit    | 2-D packed-array LHS + `$memrd`/`$memwr` write_verilog + memory_dff round-trip | 3-5          | rr_ptr fix             |
| share/freduce design          | substrate-tail vs hexa-native impl 결정                                | 0.5-1        | area > 0               |
| share/freduce impl            | passes.hexa 확장 또는 tail wiring                                      | 1-3          | design                 |
| gate flip                     | g3-conditional ±5 % achieved → flip                                  | 10 min       | measurement            |

총 estimate (이전 3-7 → post-2026-05-21 audit): **8-16 sessions** until gate close. Audit 결과: abc_map false-positive 이 measurement 진척의 실제 진실을 가렸었음 — 실제 closure 까지 fifo_mem (RTLIL Memory) emit + rr_ptr cross-iter loop 2개의 큰 work 남아있음

## Future Roadmap (brainstorm-pruned 2026-05-20)

FLOW pattern: 풀기 (84+ items generated) → 자르기 (delete 75 off-scope items, 89% prune) → 잡기 (each survivor with measurement protocol).

### Tier-1: §5 closure path (immediate, multi-session) — post-audit 2026-05-21

- [x] ~~**#4i with-else outer wrapper**~~ — SUPERSEDED by PR #245 (Phase 3e), PR #242 closed
- [x] ~~**ABC comb-loop SSA fix (intra-iteration blocking-LHS)**~~ — SHIPPED PR #247 `8dd1e677`
- [ ] **abc_map script reorder (`read_lib` → `read_blif`)** ← new Tier-1 (audit)
  - signal: ABC stops reporting 'The current library is not available' on first `.gate` line of emit-BLIF
  - scope: `stdlib/yosys/abc_map.hexa` L282 — script string concat 순서 변경
- [ ] **abc_map false-positive guard** ← new Tier-1 (audit)
  - signal: stale `_out.blif` 환경에서 `abc_map` 가 fail-loud, 또는 ABC stdout 의 'combinational loop'/'failed' 패턴 매칭
  - scope: `abc_map.hexa::abc_map()` — `exec` 전 truncate + stdout error pattern 확장
- [ ] **`rr_ptr__d` cross-iteration comb-loop** ← new Tier-1 critical (audit)
  - signal: ABC stops reporting `Network contains a combinational loop · Node "n_XXX" encountered twice on path to CO "rr_ptr__d"`
  - scope: rr_ptr 의 next-state mux-cascade 가 unrolled iteration 간 self-feedback 형성. 후보 fix: per-iteration `rr_ptr__ssa*` 또는 D-wire isolation (PR #245 패턴 응용)
  - dependency: script reorder + false-positive guard (정확한 측정 보장)
- [ ] **`fifo_mem[*]` RTLIL Memory emit** ← reframed Tier-1 (was Tier-2)
  - signal: ABC stops adding 'Constant-0 drivers to 40 (d4) / 52 (d6) non-driven nets'
  - scope: read_verilog 2-D packed-array LHS handler + write_verilog `$memrd`/`$memwr` + substrate `memory_dff` round-trip
- [ ] **end-to-end router_d4 area > 0 (real measurement)**
  - signal: `HEXA_EXEC_NO_SHELL=1 hexa run stdlib/yosys/gate_record.hexa` reports area > 0 with fresh `_out.blif`
  - dependency: 위 4개 Tier-1 blocker 클리어
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

- 2026-05-21 KST — **deeper audit · `exec()` runtime regression 이 진짜 #1 blocker**. PR #247 (`cdfa8d46`) 가 main 에 squash-merged. 새 branch (`rfc006-yosys-abc-map-script-order`) 에서 `gate_record.hexa` 재측정 시도:
  1. `[abc_map] binary=` empty — `abc_binary_path()` 의 `exec("which abc")` 가 "" 반환
  2. 격리 테스트 `exec("echo hi")` 도 "" 반환 — popen 뿐 아니라 spawn 도 broken
  3. `HEXA_EXEC_NO_SHELL=1` + meta-free cmd 도 같은 증상 — earlier session 의 "spawn fast path works" claim 도 더 이상 유효 안 함
  4. Bisect: `f1487c14` (RUNTIME.md cycle 61, "net+exec+pty 17 stubs") 가 popen/execve/posix_spawn 을 aprime_cc 용 noop stub 으로 바꿈 — 의도는 compile-time 용 이었으나 `hexa run` runtime 까지 영향. 이후 `f7dbd931` (cycles 63+64, "Darwin syscall via svc 0x80") + `54970996` (cycle 65, ACCEPTANCE 137→5) 가 _read/_write/_pipe/_dup2 를 svc 0x80 syscall 로 교체 — pipe stdio 부정합 가능성
  5. earlier session 의 `[abc_map] binary=/opt/homebrew/bin/abc · exit=0` 성공 로그는 cycle 61 직후 + cycles 63-65 직전 의 narrow window 였을 가능성
  6. inbox patch 정식 제출: `hexa-lang/inbox/patches/yosys-exec-runtime-regression-cycles-61-64.md` (수정 후보 3 path: 타깃 revert · 직접 svc 0x80 popen 구현 · per-binary unhook)
  - 결론: PR #247 SSA fix 는 unchanged-correct, 그러나 `exec` runtime 자체가 broken 인 한 어떤 측정도 honest 하지 않음. **#1 blocker = exec runtime revert/restore** (yosys 코드 변경이 아닌 hexa-lang runtime 작업)
  - earlier audit 의 "script order 가 blocker" / "stale _out.blif 가 blocker" 는 **2-3순위 issue** — exec 가 작동하지 않으면 그 어느 것도 reachable 하지 않음
- 2026-05-21 KST — **g3-honest audit · gate measurement chain false-positive 발각**. 측정 절차:
  1. `/tmp/_hexa_yosys_gate_d{4,6}_out.blif` 가 어제 (2026-05-20 23:48) 의 stale 파일임을 확인
  2. 제거 후 `HEXA_EXEC_NO_SHELL=1 hexa run stdlib/yosys/gate_record.hexa` 재실행 → `[FAIL] d6:abc_map — ABC produced no mapped BLIF (output file empty)` · `_out.blif` 생성 안 됨
  3. 즉 어제까지의 "abc_map: ok · area=0.0" 는 **stale BLIF 재읽기**로 인한 false positive 였음 (실제로 ABC 가 그동안 한 번도 실행 성공한 적 없음)
  4. 수동 진단: `abc -c "read_lib SKY130 ; read_blif d4_in.blif"` 시도 → `Library has 334 cells … Network "router_d4" contains combinational loop! · Node "n272" encountered twice on path to CO "rr_ptr__d"`
  5. 두 가지 새 blocker 확인: **(A)** abc_map.hexa script 가 `read_blif` 를 `read_lib` 보다 먼저 호출 (BLIF 의 `.gate sky130_*` 라인이 lib 미로드 상태에서 거부됨) **(B)** script 순서 고쳐도 d4 의 `rr_ptr__d` 종단 comb-loop 가 잔존 (PR #247 SSA fix 는 *intra-iteration* blocking-LHS chain 만 끊음 — *cross-iteration* arbiter-state feedback 은 별개)
  6. 부가 발견: **(C)** `fifo_mem[0..3]` 등이 undriven (ABC 가 const-0 으로 tie) — 2-D packed-array LHS 가 frontend 에서 drop. Tier-2 의 RTLIL Memory cell emit 가 실제로는 Tier-1 area>0 의 전제조건
  7. 기존 claim 정정: ~~`str(float)` 가 yosys blocker~~ → 현 build 에서 재현 안 됨 (`area=0.0`, `Δ=100.0%` 모두 정상 print). anima trainer 의 동일 증상은 별개 inbox patch.
  - 결론: §5 closure 까지의 실제 work 가 이전 estimate 보다 2-3x 큼 (8-16 sessions). 그러나 honest baseline 확보 — 다음 PR 가 진짜 측정 가능
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
