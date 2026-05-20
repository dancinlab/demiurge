# YOSYS — rfc_006 §5 area-oracle parity (장기전 roadmap)

> **domain**: hexa-lang yosys absorption · §5 measurement gate
> **goal**: hexa-native synth 가 substrate yosys+SKY130 의 oracle area
> (router_d4 = 61,762.99 µm²) 를 ±5 % 안에서 재현 → `absorbed=true`
> **detail handoff**: `inbox/notes/rfc006-s5-area-oracle-parity-handoff.md`
> (entries (o)-(u) 누적, 측정-fact 적재 SSOT)
> **governance**: g3 — 측정 전엔 `CLOSED_MEASURED` flip 금지

## Status (snapshot 2026-05-20, post-(x))

- `measurement_gate = OPEN`
- `absorbed = false`
- gate target area ∈ [58,675, 64,851] µm² (±5 % of oracle 61,762.99)
- both oracles bit-exact reproducible (d4 61,762.99 / d6 93,608.53 / ratio 1.5156×)
- hexa-native cell-tally on flat_v2k/router_d4.v:
  - post-#4g landing: **55 cells (was 35), all combinational, 0 sequential**
  - gap to substrate: **12,050 cells (99.5 %)**, 100 % of sequential gap remains

**closure path (per g3):** measurement_gate 는 hexa-native end-to-end
synth → area 가 [58,675, 64,851] µm² 안에 들어와야 close. 현재
hexa-native 는 sequential cells = 0, 즉 cell-emit 의 ~21 % 만 도달
(comb-only 부분 일부). 100 % closure 까지 multi-day work — 다음
sub-steps 가 incremental gap 축소.

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
- [ ] **#4h multi-LHS body dyn-idx emit** (router L99-100 reset-cascade의 indexed LHS)
  - signal: sequential cells > 0 (always@posedge body 시작)
  - sub-steps:
    - **#4h-a**: multi-LHS path 에 indexed-LHS (static const idx) 인식 (~50 line, L3074 honest gap 메우기)
    - **#4h-b**: dyn-idx LHS (wire-indexed) multi-LHS — PR #174 single-stmt 의 multi-LHS context 확장
    - **#4h-c**: for-in-always static unroll (router L101+L108+L115 의 `for (pp=0; pp<P; pp=pp+1)` 처리)
    - **#4h-d**: nested-if inside always-body multi-stmt (router L109 `if (in_valid[pp] && !fifo_full[pp])`)
- [ ] **#4i with-else dyn-idx emit** (L98-123 with-else reset structure)
  - signal: sequential cells ≈ N × P (P-fold sequential emit)
  - dependency: #4h sub-steps all landed first
- [~] **write_verilog chain via driver link** — wire-emit ✓ landed (PR #210), cell-emit ✗ blocker
  - PR #210 (admin-merge `116d6799`): width prefix `[W-1:0]` + IEEE 1364 escaped-ident `\name<ws>` emit
  - substrate yosys 0.65 가 hexa-native 출력 **parse 완전 동작** (wires=134, cells=55, type distribution 완전 일치)
  - **다음 blocker**: yosys `synth` macro 가 RTLIL-internal cell types (`$and`, `$mux`, `$eq` 등) 를 unknown module 로 봄 — write_verilog 가 cell instance form (`$and name(.A,.B,.Y)`) 대신 **behavioral Verilog (`assign y = a + b;` 등)** 로 emit 해야 함
  - multi-day fix: stdlib/kernels/logic_synth/write_verilog.hexa 의 `_wv_emit_cell` 를 cell-type-dispatch (각 RTLIL primitive 의 behavioral 표현) 으로 rewrite
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

## Log

(append-only, latest 위에)

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
