# YOSYS — historical log

Spec at [`./YOSYS.md`](./YOSYS.md). Entries below preserve the
multi-session §5 area-oracle parity campaign in time order; the spec
file holds only the current confirmed state. Detail-level
measurement-by-measurement narrative remains in
`archive/session-notes/rfc006-s5-area-oracle-parity-handoff.md` (1754-line
entry-by-entry log).

## Log

### 2026-05-22 KST — multi-session §5 measurement progression snapshot

| stage | d4 area (µm²) | Δ vs 61,763 | gap to ±5 % |
|-------|--------------:|-------------:|-------------:|
| campaign start (pre-Option-A) | 559 | 99.10 % | n/a |
| Option A+I (2-D LHS demux + BLIF per-bit `.latch`) | 32,829 | 46.85 % | n/a |
| per-bit connect buffer | 45,492 | 26.34 % | n/a |
| Piece 1 (`$dffe` + `edfxtp_1`) | 49,092 | 20.52 % | n/a |
| Path-a richer elab | 50,256 | 18.63 % | n/a |
| `.inputs/.outputs` per-bit shadow | 55,060 | 10.85 % | 3,694 |
| abc dedup + multi-bit `$eq` + SSA width | **55,546** | **10.07 %** | **3,208** |
| T79c post-paren bracket-select (post route_xy) | — pending measurement — | — | — |

**Cumulative: 559 → 55,546 µm² (99.4× area, Δ 99.10 % → 10.07 %, 89.0 pp
reduction).** §5 ±5 % gate target [58,754 ; 64,939] still **OPEN**.

### 2026-05-22 — mini measurement-host OOM regression (T79c)

`gate_record` process on mini (16 GB physical) jetsam-killed at ~50 GB
compressed VM, before reaching `:techmap`. Kernel evidence: 5 kills in
10 min (`memorystatus: killing largest compressed process … 49,818 MB`).
Selftest 87/87 PASS — frontend integrity intact; the route_xy inline
(`80839dd7`) + T79c post-paren bracket-select (`7f2d897e`) expanded the
SSA / multi-driver graph beyond mini's headroom. Suspected OOM site:
`pass_clean_multidriver` accumulation (`pass_proc_mux` →
`pass_clean_multidriver` window). **mini cannot remeasure the
integration branch HEAD until this is profiled/fixed.** Mini back online
2026-05-22 20:07 after 7+h crash.

### 2026-05-22 — ubu-2 Linux x86_64 substrate-host landings (PR #297/#322)

5 layer fixes unblocked ubu-2 self-host through `dfflibmap_sky130`:
1. `hexa_pipe_buf_enlarge_kernel` fake-FILE* `fileno` decode (parse)
2. `pthread_t → void*` cast for Linux glibc (outer build)
3. Linux `-Wl,--allow-multiple-definition` (link)
4. retired-shim bridge for stale dist hexa_v2 transpiler (April 2026)
5. `HEXA_MEM_CAP_MB=0` on Linux module_loader spawn (flatten unblock)

Result: full §5 d4 hexa-native pipeline runs end-to-end on ubu-2 through
`dfflibmap_sky130`. Final ABC `read_blif` fails on multi-output
`sky130_fd_sc_hd__fa_1` cell — substrate ABC version drift (ubu-2
yosys-abc 0.65 stricter than mini standalone abc). Substrate yosys 0.33
reference on ubu-2: **98,247.98 µm²** (`comb/rtl/flat_v2k/router_d6.v`
sv2v-flat, d6/d4 ratio = 1.528; cited 1.5156 differs +0.8 % due to
packing/abc-script recipe).

### 2026-05-21 KST — d6 measurement infrastructure unblock

`pass_cut_and_remap` O(n³) → O(n) hashmap (commit `7691133b`) +
`_passes_fuse_complex_cells` index (`6a5cadb6`) — memory 19 GB → 256 MB
on mini. d6 measurement now feasible at 68,696 µm² (Δ 26.61 %) post
Piece-1 era; integration branch d6 follow-on pending.

### 2026-05-21 KST — §B substrate-axis · yosys -p stat measurement note

κ-69 ChipAnalyze cell-type breakdown via substrate `yosys -p stat`.
research-only, untracked. Note:
`archive/session-notes/k69-substrate-axis-yosys-stat-measurement-2026-05-21.md`
(276 lines).

### 2026-05-21 — Tier-1 closure path land sequence

- [x] (0) **exec runtime restore** — upstream PR #251 MERGED
  (`8ea4b75e`); popen/spawn stubs 복구 → `hexa exec` chain testable
- [x] (a) **PR #247 SSA fix** (`8dd1e677` + `f4c3c493`) MERGED —
  `_rv_parse_always` for-handler 의 intra-iteration blocking-LHS chain
  per-iter SSA renaming (3 helper + read-then-write filter · T73 selftest)
- [x] (b) **PR #255 abc_map honesty** MERGED `e4f79e26` — `abc_map.hexa`
  truncate-before-exec + `combinational loop` stdout pattern + T9/T10
  selftest. stale `_out.blif` false-positive load-bearing guard ·
  post-Option-I rebase clean · selftest 10/10 PASS · zero regression
- [x] (c) **abc_map script reorder** (`read_lib` → `read_blif`) — already
  in PR #247 `logic_synth/abc_map.hexa` L478-486
- [x] (d) **`rr_ptr__d` cross-iter comb-loop** — hexa-lang PR #261
  (`0ca0994f`) MERGED 2026-05-20T19:26:33Z (RFC 073 Phase 3g · SSA
  pre-loop init redirect); `_rv_parse_always` for-handler 의 SSA chain
  pre-loop alias (`connect(s__ssa0, s)`) + post-loop publish
  (`connect(s, s__ssaP)`) 결합으로 발생한 `s__ssa0 = s = s__ssaP` comb
  cycle 을 `connect_lhs[]` 역방향 scan + pre-loop driver rhs 직접 seed 로
  해체. T74c rewrite + T74d regression guard 추가. read_verilog selftest
  77/77 · round_trip 12/12 · abc_map 7/7 (zero regression). **note**:
  PR #260 (`rfc006-yosys-ssa-seed-fix` branch) 는 같은 (d) target 의
  parallel attempt — superseded by PR #261 · still OPEN
- [x] (e) **`fifo_mem[*]` 2-D LHS flat `$dff` demux** — hexa-lang
  `c4b35b13` LANDED (Option A · 2-D unpacked array LHS → per-slot
  `$eq + $and + $mux + $dff` demux · 4 sub-cases). Selftest 78/78 →
  **79/79 PASS** (+T76). ABC accepts cleanly. Measured: router_d4 =
  1207.41 µm² (was 559.286 · +2.16×) · oracle 61,762.99 · still ~98%
  under. router_d6 = 1677.86 µm² (was 771.99 · +2.17×). Follow-up
  width-aware fix `a4a032af` · 79/79 PASS preserved.

### 2026-05-20 KST — yosys-dispatcher-use-integration-compile-fail RESOLVED

Reported "yosys.hexa dispatcher compile failure" was a **measurement
artifact**, not an upstream bug. origin/main's rfc_006 §4 yosys modules
healthy. Note: `archive/session-notes/yosys-dispatcher-use-integration-compile-fail.md`
(47 lines).

### 2026-05-21 — root YOSYS.md previous removal

Predecessor root `YOSYS.md` was rm'd at `06a8428`; its inherited
Tier-1/2/3 roadmap was migrated to `ARCH.md` §12.1. The present file is
a 2026-05-22 reconstruction promoting `proposals/rfc_006_yosys_absorption.md`
§1-9 to spec and §10 → this log.

### 2026-05-18 — rfc_006 opened as design RFC

Initial design at `proposals/rfc_006_yosys_absorption.md` — clean-room
re-derivation pattern mirror of rfc_003 (BookSim2). 7-module scope, ABC
bounded-subprocess (D18) decision documented.
