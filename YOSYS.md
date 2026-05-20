# YOSYS — rfc_006 §5 area-oracle parity (장기전 roadmap)

> **domain**: hexa-lang yosys absorption · §5 measurement gate
> **goal**: hexa-native synth 가 substrate yosys+SKY130 의 oracle area
> (router_d4 = 61,762.99 µm²) 를 ±5 % 안에서 재현 → `absorbed=true`
> **detail handoff**: `inbox/notes/rfc006-s5-area-oracle-parity-handoff.md`
> (entries (o)-(u) 누적, 측정-fact 적재 SSOT)
> **governance**: g3 — 측정 전엔 `CLOSED_MEASURED` flip 금지

## Status (snapshot 2026-05-20)

- `measurement_gate = OPEN`
- `absorbed = false`
- gate target area ∈ [58,675, 64,851] µm² (±5 % of oracle 61,762.99)
- oracle 재현 procedure pinned (substrate yosys 0.65 `synth` macro +
  flat_v2k/router_d4.v + SKY130 tt-corner Liberty)
- hexa-native vs substrate gap on same input file = **12,070 cells (99.7 %)**
  — 거의 다 sequential (DFF + MUX)

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
- [ ] **PR-B: hexa-cc `__hexa_strlit_init` unique-emit (`__hexa_strlit_init__<TU>`)**
  - file: `self/codegen_c2.hexa` L1278 + L1338 + L7899 + L7935
  - effect: sed workaround 제거, multi-file driver pattern 기본 지원
  - signal: 기존 1500+ selftest 영향 0 (within-TU rename), 새 multi-file link 가 sed 없이 동작
- [x] **#4g function-body preceding-stmts inline** ✓ LANDED (hexa-lang PR #202 `41c7b1fc`)
  - new helper `_rv_collapse_func_body_with_prefix` (~50 lines) — handles reg/integer/wire decls + begin/end wrap + blocking-assigns + SSA-style substitution into existing cascaded-if collapse
  - T50 selftest: route_xy-shaped body inlines to `$mux(S=$gt(h,0), A=0, B=1, Y=r)` — exact-count 1 × $gt + 1 × $mux
  - selftest 60/60 → 61/61 PASS, regression 0
  - call-site `grant_out = route_xy(...)` now inlines; emit unblocks once #4h bridges the LHS-indexing gap
- [ ] **#4h multi-LHS body dyn-idx emit** (router L99-100 reset-cascade의 indexed LHS)
  - signal: sequential cells > 0 (always@posedge body 시작)
- [ ] **#4i with-else dyn-idx emit** (L98-123 with-else reset structure)
  - signal: sequential cells ≈ N × P (P-fold sequential emit)
- [ ] **write_verilog chain via yosys.c dispatcher link**
  - 3-file static collision 패턴 (rv + rtlil + yosys + write_verilog) 모두 sed-rename
  - signal: hexa-native 의 RTLIL → substrate yosys 가 read 가능한 Verilog
- [ ] **share/freduce 또는 ABC -dff 옵션 통합** (comb-side oracle parity)
  - oracle 의 12k 차이 = `synth` macro 의 logic-sharing optimizations
  - 옵션: hexa-native passes 가 자체 share/freduce 구현 · 또는 substrate yosys 에 defer
- [ ] **re-measure router_d4 area on flat_v2k via hexa-native end-to-end**
  - target: ∈ [58,675, 64,851] µm² (±5 % of 61,762.99)
- [x] **router_d6 oracle bit-exact 재현** ✓: 93,608.528000 µm² · ratio 1.5156× (oracle 일치) — substrate measurement reference 완전 fixed
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

- 2026-05-20 — cell-tally re-measure post-#4g: 35 → 55 cells (+57%), 20 new all-combinational (5×$and, 10×$logic_not, 5×$logic_and = always-body condition expressions). Sequential still 0. Gap to oracle 99.5%
- 2026-05-20 — #4g landed: hexa-lang PR #202 `41c7b1fc` (function-body preceding-stmt prefix + T50, selftest 61/61). route_xy inline 가능
- 2026-05-20 — router_d6 oracle 재현: 93,608.528 µm² (cited 일치, ratio 1.5156×) — d4+d6 양쪽 oracle reproducible
- 2026-05-20 — ternary `?:` support 가 sibling 으로 origin/main 에 land (43e1dcc0) — #4g 의 prerequisite 충족
- 2026-05-20 — PR-A landed: hexa-lang PR #196 `929e9ca2` (2-line dispatch + T48/T49, selftest 58/58)
- 2026-05-20 — 루트 YOSYS.md 생성, 체크리스트 + 일정 적재 (이번 세션 누적 측정-fact 기반)
- 2026-05-20 — 자세한 측정-fact 는 `inbox/notes/rfc006-s5-area-oracle-parity-handoff.md` (o)-(u)
- 이전 — rfc_006 §4 (7 yosys modules) absorbed, §5 measurement gate OPEN
