# hexa-arch PLAN — progress / measured-distance SSOT

> Head (editable) + `## 진행 로그` (append-only, chronological).
> Architecture/why SSOT = `CHARTER.md` + `HANDOFF.md`. No over-claim:
> scaffold is scaffold, distances measured not asserted.

## 헤드

- 정체: 📐 hexa-arch — 모든 기술설계의 hexa-native 메타프레임워크.
  **7-verb pipeline** = 명세→구조→설계→해석⟲→합성→검증→인계 (cited, 9
  라이프사이클; `design.md` D5). standalone `~/core/hexa-arch`.
- 가족: hexa-matter(물질) · hexa-bio(분자) 와 **형제, typed-interface 소비**
  (흡수 X — `design.md` D2).
- 명시 코호트 (D3 하이브리드): chip 깊이 + cern · antimatter · rtsc · space ·
  energy · brain 얕은 공개면 맵. 첫 소비자: hexa-lang `comb` (n=6 fabric).
- 조사 경계: **공개면 클린룸** (D1) — OSS+arxiv+특허+표준+상용툴 공개문서.
  closed-binary RE 금지.
- 상태: **SCAFFOLD + redesign-applied** — 문서 6개 (+`design.md`) +
  첫 RFC 골격. 코드 0.
- 다음: HANDOFF §9 step1 — `proposals/rfc_001_booksim2_noc_absorption.md`
  (BookSim2 + per-link wire-delay 모델 + Leighton oracle) → comb RFC 057
  F1/F2 해소 (측정 게이트 통과 시에만).
- 거버넌스: hexa-native-only · no-fab · **no-closed-binary-RE (D1)** ·
  no-over-claim(측정만) · 흡수-RFC 패턴.
- SSOT: arch/why = `CHARTER.md` + `HANDOFF.md`; progress = `PLAN.md`;
  결정 감사추적 = `design.md`.

## 진행 로그

- 2026-05-18 — repo 생성 (standalone `~/core/hexa-arch`, git init).
  스캐폴드 5문서 작성. scope 확정: 범용 기술설계 메타프레임워크 (실리콘 전용
  아님 — chip 은 도메인 1개; space/mech 등 후속). comb 와 분리 (comb=소비자).
  외부 EDA 매핑 전수 HANDOFF §5 에 고정. 코드 미착수.
- 2026-05-18 — GitHub 발행: `dancinlab/hexa-arch` PUBLIC, scaffold push.
  형제 6개와 컨벤션 일치 (`dancinlab/*` · PUBLIC).
- 2026-05-18 — **전면 재설계 (Decisions 1–5, design.md 신설)**:
  D1 공개면 클린룸 (open-source-only → 공개면 전체 + clean-room) ·
  D2 hexa-matter/bio 별개·typed-interface 소비 (흡수 X) ·
  D3 코호트 하이브리드 = chip 깊이 + 6 도메인 얕은 공개면 맵 ·
  D4 5-verb 가설화, 조사-우선 ·
  D5 **7-verb spine 확정** (명세→구조→설계→해석⟲→합성→검증→인계 —
  9 라이프사이클 cited, ISO-15288·V-model·NASA·FDA·EDA·MBSE·PLM·가속기·
  spacecraft).
  조사 3종 (Agent-1 pipeline · Agent-2 chip 깊이 · Agent-3 6 얕은) 완료,
  strawman 5-verb 의 3가지 결함 cross-confirmed (SPECIFY 누락 · 계산
  종단 오류 · HANDOFF 누락). HANDOFF · CHARTER · README · ARCH.tape ·
  PLAN 일제 7-verb 갱신. `proposals/rfc_001_booksim2_noc_absorption.md`
  골격 작성 (BookSim2 — gem5 아님 — + per-link wire-delay 모델 +
  Leighton oracle, 측정 게이트 명시). 코드 미착수.
- 2026-05-18 — **D6 코호트 2 확정** (7 repos: fusion · scope · sscb ·
  mobility · bot · grid · aura) — Cohort-1 사이즈(7) 동형, seed 4/5 cover,
  4 산출물 클래스(물리계기·전력전자·차량/로봇·네트워크/웨어러블)
  스트레스. 7개 shallow public-surface map 작성 = background Agent
  진행 중 (RFC 057 location 정정 포함: hexa-lang/proposals/ 아닌
  hexa-lang/comb/RFC.md 가 canonical).
- 2026-05-18 — **D7 F1/F2 export artifact 위치 확정 = producer-owned**
  (`~/core/hexa-arch/exports/chip/noc/f1f2/`); atlas 승격은 2nd consumer
  등장 시 deferred. 신설:
    · `proposals/rfc_002_f1f2_export_interface.md` — typed-interface
      contract (rfc_001 = producer, rfc_002 = contract; HANDOFF §7
      "one absorption-RFC per concept").
    · `exports/chip/noc/f1f2/schema/v1_0.md` — human-readable schema
      reference doc (HXC v2 carrier — 강제: hexa-lang `@D g_hxc`).
    · rfc_001 §11 = rfc_002 포인터.
  사용자측 9 파일 (~/core/hexa-lang/comb/T1_experiment ·
  T1A_analytical · sim/README · COMB.tape · PLAN.md) = citation-only
  패치, cross-repo 규율상 별 hexa-lang 세션에서 처리 예정.
- 2026-05-18 — Background agents 상태 스냅: Agent-1 (rfc_001 §8 측정
  게이트 baseline — BookSim2 build/run + wire-delay + Leighton)
  진행 중; Agent-4 (Cohort 2의 7 도메인 shallow map) 진행 중.
  완료 시 자동 알림 후 결과 검토 → 커밋 분할 판단.

- 2026-05-18 — Agent-4 완료: Cohort 2 7개 shallow map 작성
  (`domains/{fusion,scope,sscb,mobility,bot,grid,aura}.md`).
  `domains/README.md` 업데이트: Cohort 2 파일 목록 + Agent-4 cross-cohort
  insight 3개 ((a) MC-transport+FEM 재사용 5/6 → **8/13**; (b) `bot` =
  all-open reference 도메인 (proprietary 갭이 *capability*가 아니라 throughput
  + regulatory에만 있음); (c) **새 공유 패턴 = regulatory-verify proprietary
  lock-in** — Cohort 1의 `brain`(Sim4Life MDDT) 1건이 Cohort 2에서 `mobility`
  (ANSYS medini, ISO 26262/21448), `sscb`(UL 489I 1st-ed 2025-10-22),
  `aura`(Sim4Life lower-bar) 3건 더 cross-confirmed; 알고리즘으로 못 닫고
  *regulatory qualification 캠페인*으로만 닫힘 → 새 README synthesis bullet).

- 2026-05-18 — **Agent-1 완료: rfc_001 §8 외부-reference baseline 측정**
  (BookSim2 commit `28f43299`, BSD-2-Clause, 빌드 = Apple clang 21.0;
  `/tmp/hexa-arch-rfc001-measurement/`).

  Provenance (D1 공개면 클린룸 audit):
  · 시뮬: BookSim2 `28f43299` (github.com/booksim/booksim2, BSD-2-Clause)
  · Wire-delay: SMART 22 nm, δ = **90 ps/mm** (Krishna CSAIL 2013 ·
    Kwon & Krishna OpenSMART ISPASS 2017)
  · Analytic oracle: Leighton VLSI bounds (Springer DOI 10.1007/BF01744433);
    Dally & Towles PPIN 2004 §3.2-3.3 mesh closed-forms

  §B 8×8 mesh uniform: saturation **0.42 flits/node/cycle** — Jiang
  ISPASS'13 Fig 7 + Dally PPIN Fig 25.2 publish-band 0.35–0.45 안
  (band-membership ✓; 픽셀-정밀 overlay는 후속). zero-load 패킷 latency
  50.2 cy @ inj 0.05. RNG stability 5.8 % (seed 1 vs 42 @ inj 0.35).

  §D Tornado (22 nm, 4 GHz, 20 mm × 20 mm 정사각형 die, 8×8 grid,
  a = 2.5 mm tile pitch; mesh links = 1 cy, hex cardinal = 1 cy, hex
  diagonal = 2 cy):

  | topology      | zero-load lat | avg hops | saturation (tornado) |
  |---------------|--------------:|---------:|---------------------:|
  | d=4 2-D mesh  |      64.70 cy |     8.49 | ~0.155 flits/node/cy |
  | d=6 axial hex |      57.40 cy |     7.14 | ~0.195 flits/node/cy |
  | 비율 d6/d4    |        0.887× |   0.841× |          **1.26×**   |

  → **d=6 hex 가 d=4 mesh를 양 축에서 outperform** 한 단일 (4 GHz · 22 nm ·
  axial-hex 정사각형 placement) 점. **regime 주장 아님** — 클럭 sweep,
  d=6 uniform, 대체 hex placement, wire-delay-number sensitivity 미수행.

  §E Leighton oracle (g3): **6/6 부등식 cross-check PASS** (bisection
  floor · tornado throughput ceiling · zero-load latency floor 양쪽 ·
  uniform hop-count analytic · tornado hop-count analytic). 시뮬이 이론
  한계 위반 없음 → run accepted.

  §F 정직한 게이트 평가: rfc_001 §8 (1) 재현 band-membership ✓ ·
  (2) d=4 vs d=6 wire-delay-injected curve + Leighton 교차 ✓ · (3)
  "absorbed at measured parity"는 **아직** — §7 hexa-native 재구현이
  이 §B/§D 숫자를 재현할 때 비로소. 본 run은 *외부 reference target
  생성*까지.

  새 산출물: `exports/chip/noc/f1f2/records/{d4_mesh,d6_hex}_tornado_
  22nm_4ghz.json` (2 records) + `pair_verdicts/d4_vs_d6_tornado_22nm_
  4ghz.json` (1 derived). 전부 `provenance.absorbed = false` ·
  `measurement_gate = GATE_OPEN` (no over-claim, g3).

  3개 살아있는 open questions (rfc_001 §9 refined): (i) axial-hex on
  square grid same-sign diameter = mesh와 동일 → 대체 placement 평가
  필요; (ii) 4 GHz는 첫 정수-cycle 경계 — 클럭 sweep 없으면 regime claim
  X; (iii) newer-FinFET 문헌 sensitivity 미수행.

  다음 = §7 hexa-native 재구현 (`stdlib/booksim/{anynet, iq_router,
  traffic, sweep, wire_delay, leighton}.hexa`) → §B/§D 재현 시 측정
  게이트 GREEN → `provenance.absorbed = true` 일괄 flip.

- 2026-05-18 — Background batch 2 (4 agents): **Agent-5 ✅** —
  `proposals/rfc_003_booksim_native_rederivation_plan.md` + `stdlib/
  booksim/README.md` + 7 `*.hexa.stub` (6 모듈 + dispatcher; 시그니처만,
  TBD 바디, clean-room provenance). 위치 = **hexa-arch 로컬 추천**
  (BookSim2 = domain-bound + F1F2-record producer → audit chain
  colocated); hexa-lang 흡수는 2nd consumer 시 deferred. **Agent-7 ✅** —
  comb 5개 citation patch draft (`/tmp/hexa-arch-comb-patches-2026-05-18/`;
  hexa-lang `AGENTS.tape` governance deny 충돌 0; g7 해석 게이트 1개
  플래그 = inbox-route vs sibling-read carve-out). **Agent-8 ✅** —
  Cohort 3 인벤토리 (잔여 14 repo; os/earth/cosmos 추천 + never-cohort 7
  + defer 4). **Agent-6 ❌** — rfc_001 §9 sweep (clock/king-move/FinFET)
  API rate-limit 으로 57 tool-calls 후 중단, records 미생성 — 재발사 필요.
- 2026-05-18 — **D8: Cohort 3 보류(deferred)**. 네임드 코호트 =
  Cohort 1 (7) + Cohort 2 (7) = 14 유지. Agent-8 survey 는 향후 재개용
  입력으로 보존; `domains/{os,earth,cosmos}.md` 미작성.
- 2026-05-18 — rfc_001 §9 open-questions closure (relaunch #2; BookSim2
  28f43299 external-reference, tornado, 8x8/20mm/2.5mm-pitch, IQ-iSLIP
  VC8/buf8/pkt20). Emitted 46 records + 48 pair-verdicts to
  exports/chip/noc/f1f2/ (4 placements x 2 nodes x 6 clocks); all
  absorbed=false, GATE_OPEN, Leighton PASS, verdict INCONCLUSIVE.
  §9(i) hex-placement CLOSED — king-move d=8 beats axial-hex on every
  axis (22nm/4GHz: lat 0.778 vs 0.887, thr 1.81 vs 1.26 cand/base);
  axial-hex-diameter=mesh-diameter is a placement artifact, not a
  degree ceiling; brick-hex (hop-diam 11) also strictly better.
  §9(ii) clock-sweep CLOSED — d=6 latency win clock-robust 1-6 GHz
  (ratio 0.85-0.89, never flips); throughput win conditional (clean
  at 4-6 GHz, coarse-grid-noisy elsewhere). §9(iii) FinFET δ PARTLY
  OPEN — no direct public 7nm ps/mm number; used δ_7nm=162 ps/mm
  EXTRAPOLATED from Georgia Tech RC scaling (+21.8% 22->11nm, +48%
  11->7nm, SemiEngineering "Interconnect Challenges"); d=6 advantage
  survives at 7nm. comb oracle: F1 low-load sign reproduced (no flip);
  SKY130 1.516x port-area applied to all d=6 records; D_hex/D_mesh
  1/sqrt(3) is a continuum limit, not reproduced as a discrete-lattice
  hop ratio (flagged definitional, not drift). Refined open Qs:
  absolute FinFET ps/mm, finer throughput-knee grid, d=8 router
  silicon cost, adaptive routing.
- 2026-05-18 — OpenROAD build (ubu pool) **BLOCKED on host availability**.
  ORFS (OpenROAD-flow-scripts, BSD/Apache OSS) cloned `--recursive` to
  ubu-2 `~/core/OpenROAD-flow-scripts` (5.2 GB, all submodules incl.
  yosys). `etc/DependencyInstaller.sh -all` ran ~50 min then failed
  (wilson-pool autosync rsync dropped, exit 255); ubu-2 then went fully
  unreachable (SSH banner timeout — overload/thrash; ubu-1 + macOS host
  already off-roster → pool empty). No `openroad` binary produced.
  comb T3 (P&R) NOT reached — but comb T3 inputs CONFIRMED present on
  ubu-2 (`comb/` sync OK; artifacts are not the blocker; blocker = absent
  binary). **ORACLE CROSS-CHECK PASS** (no P&R needed): comb yosys SKY130
  area d4 = 61,762.99 µm² · d6 = 93,608.53 µm² → ratio 1.5156x, matches
  comb HANDOFF §4 oracle 1.516x exactly. Post-P&R area = pending build.
  T3 caveat: `comb/rtl/pnr_run.tcl` line 22 hardcodes liberty path
  `/tmp/sky130/.../sky130_fd_sc_hd__tt_025C_1v80.lib` — must
  `git clone efabless/skywater-pdk-libs-sky130_fd_sc_hd` on the build
  host first. wilson-pool routing gotcha: bare `git clone` /
  `DependencyInstaller.sh` don't keyword-match → need a `cmake`-token
  nudge to route to the pool. Resume = ubu-2 back on roster → installer
  → build → `openroad -version` → T3. comb coordination (HANDOFF §5):
  openroad landed on Linux = NO.
- 2026-05-18 — consumer back-pointer (NOT a transfer; Decision 2 keeps
  comb↔hexa-arch decoupled): comb consumed the `hexa-arch:chip:noc:F1F2`
  typed interface (rfc_002 v1.0) and **DELIVERED its T3 design-only**
  milestone — comb commit `2abe76c4`, doc `comb/T3_DESIGN_FINAL.md`
  (comb SSOT; stays comb-side, NOT ingested into hexa-arch). Part D
  (NoC architectural design) = COMPLETE via rfc_001 §8 baseline + §9
  46-record sweep; Part E (routed GDS) = comb-side execution gate.
  Substantive cross-check: comb's standalone N=7 cycle-accurate fabric
  had F1 *FALSIFIED* (d4 mesh wins, single-issue 1-cycle LL sink),
  while hexa-arch's N=64 IQ-iSLIP §9 sweep shows d6 LEAN-PASS
  (lat+thr, clock-robust). comb reconciles these as **orthogonal
  effects** (small-N + weak-router center-concentration vs N=64 VC +
  input-speedup relieving it) — comb's pre-registered reversal caveat
  empirically vindicated. **No contradiction with hexa-arch records**:
  both sides stay INCONCLUSIVE · GATE_OPEN · absorbed=false (g3
  no-over-claim intact); this is an independent characterization
  cross-check, not a regime claim. Synth-area oracle also mutually
  consistent (comb yosys d6/d4 = 1.5156x ≡ hexa-arch records'
  router_port_area_norm 1.516).
- 2026-05-18 — **Part E (routed GDS) COMPLETE on ubu-1** — the
  long-blocked execution gate is closed. Host story: macOS abandoned
  (3-patch dead-end + 부하) → ubu-2 thrash/unreachable ×N → background
  agent API rate-limit ×2 → ubu-2 down → **ubu-1 recovered** →
  OpenROAD prebuilt clean on ubu-1 (`build_openroad.sh --local`,
  MAKEFLAGS=-j8 to avoid thrash; openroad `26Q2-1164-g08f67ee5ec`,
  ORFS HEAD `2f6e9c9bd`; comb HANDOFF §1's 3 macOS-arm64 patches NOT
  needed on Linux — confirmed) → detached ORFS T3 for both designs:
  `router_d4` make OK ~4 min, `router_d6` ~6 min, `6_final.gds`
  9.5M / 16M produced. **comb HANDOFF §5 coordination: openroad
  landed on Linux = YES** (was NO).

  Post-P&R measured (ORFS `6_report.json`, sky130hd, first-pass):
  · instance area d4 = 95,541.6 µm² · d6 = 154,984 µm² →
    **ratio 1.6222×** (vs comb synth oracle 1.516× = **+7.0%**;
    the P&R-stage EDA cost = timing-repair buffers + clock tree +
    routing — NOT a contradiction of the synth oracle, a different
    stage)
  · power d4 0.158 W · d6 0.555 W → **3.507×** (degree-6 power
    penalty far exceeds the area penalty)
  · timing: BOTH fail the comb 5 ns / 200 MHz SDC — d4 WNS
    −4.98 ns (696 viol, fmax ≈ 100 MHz), d6 WNS −8.52 ns (951 viol,
    fmax ≈ 74 MHz). First-pass ORFS, not optimized — honest.

  Significance: this supplies the **measured physical EDA-cost RHS**
  of comb T1A's 승리 부등식. The degree-6 NoC-latency benefit (LHS,
  rfc_001 §9: lat 0.78–0.89×, thr up to 1.81×) must clear area
  1.62× + power 3.5× + degraded timing. Both sides now quantified;
  still **INCONCLUSIVE** as a regime claim (single PDK/SDC/util
  point, timing not closed, g3, GATE_OPEN).

  Emitted: `exports/chip/noc/f1f2/records/2026-05-18_router_d{4,6}_
  pnr_sky130hd.json` + `pair_verdicts/2026-05-18_d4_vs_d6_post_pnr_
  sky130hd.json` (interface `hexa-arch:chip:pnr:T3-record`,
  distinct from the NoC-sim interface; `provenance.absorbed=false` —
  external OpenROAD, hexa-native rfc_003 re-derivation still pending).
  comb T3_DESIGN_FINAL.md §4 "Part E = execution gate" re-entry
  condition is now satisfied producer-side (comb-side doc update is
  comb's own SSOT call, not transferred — Decision 2).
- 2026-05-18 — **rfc_003 Phase B, slice 1: `stdlib/booksim/anynet.hexa`
  landed** (first real hexa-native re-derivation module; .hexa.stub
  left intact as historical skeleton). 662 LoC, clean-room from
  BookSim2 `anynet.cpp:60-126` + `:324-430` (commit 28f43299,
  BSD-2-Clause; manual.tex format vocab only; no upstream code copied,
  7 `// CLEAN-ROOM` markers). Compiles + runs under the hexa toolchain
  (`hexa parse` clean, `hexa run` exit 0); **14/14 self-test PASS** —
  d4 8×8 mesh routers=64 edges=224(=112 undir) **B=8 D=14** maxdeg=4,
  d6 8×8 axial-hex routers=64 edges=322 D=14 maxdeg=6, emit→parse
  round-trip identity. The B=8/D=14 structural output **matches the
  committed Leighton-oracle values** in
  `exports/.../records/2026-05-18_d4_mesh_tornado_*.json`
  (`bisection_observed:8`, `diameter_observed:14`) — producer
  re-derivation structurally consistent with the emitted records.
  De-risking: **rfc_003 §6's flagged hexa-lang parser-gap did NOT
  materialize** — toolchain handled structs / `[Struct]` arrays /
  `core/parse` / `read_file` / `exit(91)` / `fn main()` self-test;
  the ~50-LoC inline anynet parser per §6.1 sufficed, no upstream
  hexa-lang change forced. One bug found+fixed in-agent (bisection
  `/2` double-count). `provenance.absorbed` stays **false** — this is
  1 of 6 modules; the rfc_001 §8 measurement gate closes only when
  iq_router + traffic + sweep + wire_delay + leighton also land and
  reproduce §B/§D. Next: those 5 modules as separate rate-limit-safe
  scoped agents.
- 2026-05-18 — **rfc_003 Phase B, slices 2-5: iq_router / traffic /
  wire_delay / leighton .hexa landed** (4 parallel rate-limit-safe
  scoped agents, ~14-31 tool-calls each; .stubs left intact).
  Independently re-verified by re-running `hexa run` locally
  (toolchain `hexa 0.1.0-dispatch`):
  · `iq_router.hexa` 595 L — PASS 17/17. 4-stage pipeline + VC +
    credit; knob defaults (routing 0 / vc_alloc 1 / sw_alloc 1 /
    credit 2 / vc 8 / buf 8) match the committed records'
    router_cost.iq_pipeline; min-lat 7 cyc (spec 6). Clean-room
    BookSim2 iq_router.cpp:50-100/:213-285/:320-330 (28f43299,
    BSD-2; iSLIP allocator internals deliberately not re-derived,
    rfc_003 §3.2 scope).
  · `traffic.hexa` 426 L — PASS 12/12. uniform/transpose/tornado;
    tornado(0,0)→27 (7,7)→18 for k=8, bijection, matches the
    committed `coord_kind:xy` `i*k+j` tornado runs. Clean-room
    BookSim2 traffic.cpp:48-396 + Dally&Towles PPIN §3.2 shift
    constant (NOT-BookSim2-marked).
  · `wire_delay.hexa` 439 L — PASS 12/12. 22nm δ=90 → 2.5mm 1c /
    3.536mm 2c; 7nm δ=162 EXTRAPOLATION → 2c / 3c — reproduces the
    committed records exactly. NOT BookSim2-derived (no wire model
    upstream); SMART/OpenSMART + Naeemi/GT Cu-RC scaling cited.
  · `leighton.hexa` 376 L — PASS 10/10. mesh_bounds(8)=(8,14)
    (= anynet output + committed bisection_bound:8/diameter_bound:14),
    leighton_floor(64)=8, oracle_check g3 reject-gate (exit 91 on
    bound violation). Pure theory clean-room (Leighton 1984 DOI
    10.1007/BF01744433 + Bhatt-Leighton + Dally&Towles); no BookSim2
    path (it IS the analytic oracle).

  **hexa-lang toolchain gaps found (independently confirmed across
  multiple agents; all worked around, none blocking)** — recorded for
  a future hexa-lang upstream PR per the hexa-first principle
  (constraint lives in hexa-lang → fix there PR-only; hexa-lang's own
  SSOT call, not actioned from hexa-arch):
  1. no `match` statement (parse error; `match{ -> }` mis-dispatches)
     → if-chains.
  2. enum-variant `==` broken — `x==S.A` returns false, `int(enum)`
     collapses to 0 (no working discriminant). Confirmed independently
     by the traffic AND iq_router agents (iq_router's first draft
     infinite-looped on it). → `str(enum)` string-compare, or plain
     int constants (the enum-free idiom anynet.hexa already uses).
  3. no tuple support (`-> (int,int)`, `(a,b)` literal, `let (a,b)=`
     destructuring all fail) → struct return (matches stub idiom).
  rfc_003 §6's *predicted* parser-gap did not materialize; the real
  gaps are the 3 above. The hexa-native path is preserved (int/struct
  idioms, no language change forced).

  `provenance.absorbed` still **false** — 5 of 6 modules now land
  (anynet committed + these 4); the integrator `sweep.hexa` remains,
  and the rfc_001 §8 measurement gate closes only once sweep ties
  anynet+iq_router+traffic+wire_delay together and **reproduces the
  §B baseline (8×8 mesh uniform saturation ≈ 0.42 flits/node/cy)** and
  §D, cross-checked by leighton. Next: `sweep.hexa` (Phase B
  integrator) → run the §B reproduction.
- 2026-05-18 — **rfc_003 Phase B, slice 6 (final): `sweep.hexa`
  landed — §B gate result is HONEST PARTIAL, `absorbed` stays
  false.** 683 L integrator (ties anynet+iq_router+traffic+wire_delay,
  leighton-oracle-checked); clean-room BookSim2 trafficmanager.cpp
  :954-1010/:1417-1556/:1611-1690 + Dally&Towles PPIN §16/§25
  (28f43299, BSD-2). All 6 rfc_003 modules now exist + self-test.
  Independently re-verified (`hexa run`, PASS 5/5):
  · §B rfc_003 §4 PINNED acceptance — **4/4 rows + Leighton oracle
    PASS**: ZLL@0.05 = 50.00 cy vs ref 50.25 (**−0.5%**, structurally
    earned not back-fitted), avg hops 6.263 (ref 6.25), knee_rate
    0.30 ∈ [0.30,0.45], pre-knee monotone; Leighton B=8≥8 D=14≥14.
  · **HONEST caveats (g3 — not fudged)**: mid-curve 0.20–0.40
    deviates UPWARD vs the BookSim2 reference (inj 0.40: mine 923 vs
    ref 270 ≈ 3.4× off); knee 0.30 is the band's LOWER EDGE (ref
    crossing ≈ 0.37) — a band-edge pass, not centre-of-band. Model
    simplifications, both documented in-file: (1) aggregate
    mean-field cycle-stepped queueing DES + PPIN §25 closed-form
    L=T0/(1−ρ), NOT a per-flit DES — the per-flit attempt blew up
    (>5 min CPU, >6 GB RAM) on the interpreted toolchain (~1e4
    ops/s); (2) scaled convergence window (4000×(2+4) vs committed
    10000×(3+8)).
  · §D NOT done — sweep currently exercises **uniform only**;
    tornado/transpose + `wire_delay_into_anynet` heterogeneous
    per-link latency + the d4-vs-d6 directional inequality are all
    pending (rfc_003 Phases E/F).
  Binding constraint identified: **interpreted hexa-lang toolchain
  throughput (~1e4 ops/s)** forces the aggregate model over a
  per-flit DES — the most material gap for §D / full-curve parity.
  **`provenance.absorbed` remains `false`**: the §B *pinned* metrics
  are met under a documented simplified model, but full-curve
  parity + §D are NOT demonstrated; flipping absorbed=true here
  would over-claim (g3). The §B-pinned-met status is a *partial
  milestone*, recorded as such — its exact formalization
  (plain-false vs an explicit partial-gate marker) is a decision
  gate (see design.md).
