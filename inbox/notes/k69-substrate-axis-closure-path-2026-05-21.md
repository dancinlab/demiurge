# κ-69 chip §B substrate-axis closure path — post-(e) LANDED audit

> **status**: research-only · 2026-05-21 · untracked
>
> ARCH §12.1 (e) `fifo_mem` 2-D LHS Option A LANDED via hexa-lang
> `c4b35b13` + `a4a032af` (2026-05-21 14:32/15:27 KST · direct push).
> Tier-1 (f)..(i) 여전히 OPEN. 본 note 는 (e) own-scope CLOSED 직후의
> realistic 잔여 closure-path 평가. NO ARCH/PLAN/HANDOFF mutation —
> 조사 결과 직접 inbox 박제.

## § 0. Purpose

post-(e) LANDED 시점에 (f..i) `measurement_gate = CLOSED_MEASURED`
까지 가는 가장 짧은 honest path 를 식별 + 그 전에 측정해야 할
unknowns 를 surface.

## § 1. Status snapshot

**(e) actually delivered** (c4b35b13 + a4a032af 두 commit 합산):
- `_rv_emit_body_v2` L2828 `if has_idx2 == 1 { continue }` honest-skip
  제거 (frontend 가 2-D unpacked array LHS 를 silently drop 하지 않음)
- `_rv_parse_port_decl` L688-720 second unpacked range parse · `base[i][j]`
  P*D 개 wire emit · 폭 W
- 4 sub-case demux (const/dyn outer × const/dyn inner) `$eq + $and + $mux + $dff`
  per slot · v2 path 는 cond-tagged rows + tracked $dff (`_rv_emit_dff_for_tracked`)
- `_rv_array_bound2` 신규 helper · `_rv_array_bound` 는 2-D entry filter
- a4a032af follow-up: D-wire packed width mirror via `_rv_v2_wire_width(m, name)`
  (RTLIL width-mismatch latent fix · area delta NONE 왜냐면 abc_map BLIF emitter
  L304 `.latch d_net q_net re clk_net 2` 가 multi-bit cell 을 단일 `.latch`
  line 으로 emit하기 때문 — multi-bit 정보 ABC 진입 전 truncate)
- read_verilog 78/78 → **79/79 PASS** (+T76 minimum-shape 2-D N=M=2 falsifier)
- passes 35/35 · abc_map 7/7 · rtlil 11/11 · liberty 8/8 — zero regression

**Area numbers** (sky130_fd_sc_hd · ABC 2026-05-21 · mac-side
`HEXA_EXEC_NO_SHELL=1 hexa run stdlib/yosys/gate_record.hexa`):

| design | pre-(e) | post-(e) | oracle    | Δ (post-(e)) |
|--------|---------|----------|-----------|--------------|
| d4     | 559.286 | 1207.41  | 61762.99  | -98.05%      |
| d6     | 771.99  | 1677.86  | 93608.53  | -98.21%      |
| ratio  | 1.38×   | 1.39×    | 1.5156×   | -8.3%        |

가장 중요한 셀-카운트 단서는 c4b35b13 commit body 의 예측:
"per-element flat $dff is correct but ~10× substrate's `synth_memory_dff`-
consolidated count"

**hexa-native synth pipeline** (`stdlib/yosys/gate_record.hexa` L49-107):
read_verilog → hierarchy → proc → flatten → opt → proc_mux → clean_multidriver
→ techmap_sky130 → dfflibmap_sky130 → abc_map. **No memory consolidation
pass exists.** No `share`/`freduce` pass in `stdlib/kernels/logic_synth/passes.hexa`
(3613 lines · 25 `pass_*` functions surveyed · 0 hit).

**Session-cost spent so far on Tier-1** (handoff entries (o)..(bb) +
ARCH §12.1 (a)..(e)): 대략 7-9 sessions (PR #247 SSA · PR #251 exec
restore · PR #255 abc_map honesty · PR #261 cross-iter SSA · c4b35b13
2-D LHS · a4a032af width-aware · BLIF latch truncation discovery).

## § 2. Closure path candidates

| option | scope                                                          | feasibility | session-est | D80-alignment    |
|--------|----------------------------------------------------------------|-------------|-------------|------------------|
| C      | RTLIL `$memrd`/`$memwr` cells + module-level `$mem` (Option B 별명) | medium      | 3-6         | g3-honest        |
| D      | substrate-yosys-as-tail-pass (hexa frontend → substrate `synth`)   | high        | 0.5-1       | g3-violation     |
| E      | `share`/`freduce` impl in `passes.hexa` (comb logic-sharing)       | low         | 4-8         | g3-honest        |
| F      | Option A 그대로 + BLIF emit multi-bit `.latch` 확장 (a4a032af 후속) | medium-high | 1-2         | g3-honest 부분적 |

### Option C — RTLIL `$memrd`/`$memwr` + module-level `$mem`
substrate Yosys 가 actually 하는 일. patch `yosys-fifo-mem-2d-array-memwr-emit.md`
§"Option B" (= 본 표 의 C) 가 detail 보유:
- 1× `$mem` cell per Module (WIDTH=W · SIZE=P*DEPTH)
- 4-5× `$memwr` / `$memrd` per router (tens of cells 합산)
- "Plausibly within ±5% of oracle" (단, 측정 needed)

**숨은 cost**:
- `rtlil.hexa` 의 `Memory` struct (cells 와 분리된 별 collection)
- INIT bit-blob · `READ_PORTS` / `WRITE_PORTS` parameter handling
- write_verilog 가 `$memrd`/`$memwr` → behavioural `always` block 으로
  역-emit 할 수 있어야 round-trip 보존
- `memory_dff` pass 동형의 consolidation 이 ABC 진입 전 필요 (그렇지
  않으면 ABC 가 $mem cell 을 모름 → 같은 0 cell 결과)

### Option D — substrate-yosys-as-tail-pass
hexa-native frontend (read_verilog → proc → ... → opt) → substrate
`yosys -p "synth -top router; ..."` 가 area-critical tail. patch 의
"Option C" 와 동형 · 본 task description 의 "Option D".

**g3-violation**: ABSORPTION.md §178 yosys row 가 "absorbed=true" claim
정합성을 잃음 — back-end 가 substrate. wilson identity Principle 2
hexa-first ("when the constraint lives in hexa-lang itself, fix it
there") 와 직접 충돌. D80 endpoint ultimate-form spirit 와도 충돌.

장점 single 한 가지: oracle exact-match guaranteed (since pipeline IS oracle).
0.5-1 session land 가능.

### Option E — `share`/`freduce` impl in `passes.hexa`
handoff (s) entry 가 comb-side oracle gap ~12,806 µm² 를 `synth` macro 의
logic-sharing optimization 가 closure 한다고 cite. 단 (e) 가 mem-cell
경로를 unblock 했으므로, 잔여 98% 의 dominant 가 memory 인지 comb 인지가
아직 unknown. 본 path 는 (Option C 와 별도로) 필요할 수 있음.

### Option F — BLIF emit multi-bit `.latch` 확장
a4a032af 가 RTLIL width 를 올바르게 mirror 했지만, abc_map.hexa L304 의
BLIF emit 가 `.latch d_net q_net re clk_net 2` 한 줄 만 emit (multi-bit
collapse). Multi-bit width W 를 W 개 separate `.latch` lines 으로 expand
하면 `$dff(W=64)` 1 cell 이 64 single-bit `.latch` 로 ABC 에 도착 →
ABC 가 64× area 로 측정. 따라서 router_d4 의 1207.41 µm² 가 ~80,000 µm²
까지 갈 가능성 (단순 W=64 × 1207.41 = 77,275 — 좌측 oracle 61,763 의
±5% 위쪽이지만 abc remap 후 실제값은 측정해봐야 안다).

**가장 surgical** path: abc_map.hexa L300-310 의 `.latch` emit 만
변경. read_verilog/passes 미접촉. 단 width metadata 가 RTLIL `Cell`
까지 흘러가는지 확인 필요 (a4a032af 가 D-wire width 만 fix · `$dff`
cell parameter 까지 propagate 했는지 unverified).

## § 3. RECOMMENDED next step

**Option F first (1-2 sessions) · 그 결과 측정 후 Option C 또는 Option E**
— BLIF `.latch` expansion 이 가장 surgical 한 next step 이고 측정-fact
한 점 (multi-bit collapse 가 98% 잔존 gap 의 dominant fraction 인지)
을 cheap 하게 확보한다. 잔여 gap 이 작으면 (단, ±5% 안 들어가면) Option C
가 dominant; 잔여 gap 이 comb logic-sharing 이면 Option E.

## § 4. Missing measurements (run BEFORE deciding C/D/E/F)

1. **substrate `yosys -p "stat"` on (e)-emitted RTLIL** — hexa-native
   chain mid-stream 의 BLIF 또는 mapped Verilog 를 substrate 에 다시
   먹여 cell-type breakdown 확보 (`$dff` count · `$_AND_` count · etc.).
   예상 명령: `yosys -p "read_verilog /tmp/_hexa_yosys_gate_d4_in.v; stat"`.
2. **BLIF latch line count** — `/tmp/_hexa_yosys_gate_d4_in.blif` grep
   `^.latch` count vs substrate oracle 의 `synth_memory_dff` 후 flop
   count. 두 숫자 ratio 가 ~10× 예상 (commit body 단서).
3. **multi-bit width 의 RTLIL Cell 까지 propagation 확인** — a4a032af
   가 wire-level 만 fix 한 건지 Cell parameter `\WIDTH` 까지 갔는지
   `rtlil.hexa` Cell struct 점검 (read-only).
4. **comb-side oracle gap** — d4 의 `synth_memory_dff` 후 substrate
   stat 와 hexa-native stat 의 non-flop cell delta. handoff (s) 의
   ~12,806 µm² 수치가 (e) 후에도 그대로인지 재확인.
5. **ratio drift** — d6/d4 가 1.39× (oracle 1.5156×) 인데 (e) 후
   slightly 개선. d4/d6 의 fifo 비율 (5×4 vs 7×8) 와 1.39 cf 1.5156
   의 algebra · Option C 가 ratio 도 같이 회복하는지 모델 필요.

## § 5. Out-of-scope but worth noting (post-(e) re-prioritization)

- **Tier-2 `$adff`/`$sdff`/`$dffe` write_verilog** — router_d4 의
  `if (rst) ... else ...` outer 가 sync-reset $sdff 로 lower 가능
  하면 area model 가 좀 더 honest. 단 (e) 이후 dominant cost 가
  memory 인 한 deferred 정당.
- **Tier-2 share/freduce parity** — Option E 가 이걸 직접 land. handoff
  (s) 의 12,806 µm² estimate 가 stale 일 수 있음 (pre-(e)).
- **Tier-2 formal equivalence check** — `equiv_make oracle hexa_native eq;
  equiv_simple; equiv_status` 0-unproven 측정. measurement_gate flip
  의 sufficient condition 으로 격상시킬 수 있음 (현재는 ±5% area
  만으로 flip — area-equality 가 semantic equivalence 의 weak proxy).
- **detail SSOT drift** — `inbox/notes/rfc006-s5-area-oracle-parity-handoff.md`
  의 마지막 entry (bb) 가 2026-05-20-23:30 KST 시점 (`router_d4 area=0.0
  µm² FAIL` + exec runtime broken). 이후 (0) PR #251 MERGED · (a) PR #247
  MERGED · (b) PR #255 OPEN · (d) PR #261 MERGED · (e) c4b35b13 + a4a032af
  LANDED — **6 land events 가 SSOT 에 unrecorded**. 본 note 가 그
  drift 의 partial mitigation 이지만 정식 (cc) entry 가 detail-SSOT
  에도 필요. (drift 식별 만 · 본 task 가 NO HANDOFF mutation 이라 적용 X)
- **G31β 동시 진행**: hexa-lang isolated worktree 에서 G31β 가 sun-pos
  완성 work — 그쪽 land 가 c4b35b13 와 같은 main 에 들어왔다는 사실
  자체가 cross-repo discipline window 의 ARCH §12 narrative 와 정합.

## § 6. Open questions for user

1. **Option D (substrate-tail-pass) honest compromise 로 accept 가능?**
   D80 ultimate-form 의 chip §B specific 한 carve-out 으로 정당화
   가능한가? ABSORPTION.md §178 yosys row 를 "absorbed-frontend ·
   substrate-tail" 같은 hybrid 표기로 land 하면 1-session closure 가능.
   반대로 reject 면 Option C 가 3-6 session work.
2. **D80 ultimate-form 의 chip §B specific 강도** — sun-pos / energy /
   solar 의 substrate-parity (D95/D103 carve-out) 같은 패턴을 yosys
   에도 적용? 또는 yosys 만 ultimate-form 강제?
3. **measurement_gate flip 의 sufficient condition 강화** — 단순 ±5%
   area 가 아니라 formal equiv 도 require 할지? (Tier-2 work 격상).
4. **next session 시작 시 Option F 측정-step 먼저 1-session 갈지** —
   §4 missing measurements 의 1+2 를 한 session 으로 finish 가능.
   결과에 따라 Option C vs F 선택.

## Cross-link

- `~/core/demiurge/ARCH.md` §12.1 (e) `[x]` LANDED · (f..i) `[ ]` · Log entry 2026-05-21
- `~/core/demiurge/inbox/notes/rfc006-s5-area-oracle-parity-handoff.md`
  detail SSOT · last entry (bb) 2026-05-20-23:30 KST · post-(e) drift 식별 됨
- `~/core/hexa-lang/inbox/patches/yosys-fifo-mem-2d-array-memwr-emit.md`
  Option A landed · Option B(=본 note Option C) / Option C(=본 note D) detail
- hexa-lang `c4b35b13` (Option A · 2-D LHS demux) · `a4a032af` (width-aware)
- `~/core/hexa-lang/stdlib/yosys/gate_record.hexa` L49-107 pipeline · L227 trace
- `~/core/hexa-lang/stdlib/kernels/logic_synth/abc_map.hexa` L300-310 BLIF `.latch` emit
- `~/core/hexa-lang/stdlib/kernels/logic_synth/passes.hexa` 25 passes · share/freduce 없음

`measurement_gate = OPEN` · `absorbed = false` (substrate-axis, g3) 유지.
