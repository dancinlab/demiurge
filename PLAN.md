# Demiurge PLAN — progress / measured-distance SSOT

> Head (editable) + `## 진행 로그` (append-only, chronological).
> Architecture/why SSOT = `CHARTER.md` + `HANDOFF.md`. No over-claim:
> scaffold is scaffold, distances measured not asserted.

## 헤드

- 정체: 📐 demiurge — 모든 기술설계의 hexa-native 메타프레임워크.
  **7-verb pipeline** = 명세→구조→설계→해석⟲→합성→검증→인계 (cited, 9
  라이프사이클; `design.md` D5). standalone `~/core/demiurge`.
- 가족: hexa-matter(물질) · hexa-bio(분자) 와 **형제, typed-interface 소비**
  (흡수 X — `design.md` D2).
- 명시 코호트 (D3 하이브리드): chip 깊이 + cern · antimatter · rtsc · space ·
  energy · brain 얕은 공개면 맵. 첫 소비자: hexa-lang `comb` (n=6 fabric).
- 조사 경계: **공개면 클린룸** (D1) — OSS+arxiv+특허+표준+상용툴 공개문서.
  closed-binary RE 금지.
- 상태: **design-baseline 완결** — 7-verb spine·14 도메인맵·rfc_001..005·
  AGENTS.tape·D1–D16. hexa-matter **measured-parity 흡수**(domains/matter,
  38/38·29/29). chip §B = GATE_B_PINNED_MET. GUI(D16) 설계만·미빌드.
- 다음: 아래 `## 계획` Phase 1~4 (GUI 완성이 종점).
- 거버넌스: g3 no-over-claim(RETAINED) · D1 clean-room · D2/D11 decouple ·
  g5 hexa-native(코어) · **D15 stdlib⊂hexa-lang** · no-big-bang ·
  gated-tombstone/irreversible. 강제 SSOT = `AGENTS.tape`.
- SSOT: goal/why = `GOAL.md`+`CHARTER.md`+`HANDOFF.md`; 거버넌스 =
  `AGENTS.tape`; 결정 = `design.md`(D1–D16); progress = `PLAN.md`.

## 계획 — GUI 완성까지 (forward roadmap)

> 종점 = D16 macOS Swift 코크핏 shipped. 전부 g3·D1·D2·g5·D15·
> no-big-bang 유지. design 은 즉시, 빌드/비가역/cross-repo 는 명시 gate.

- **Phase 0 — DONE** ✅ : 7-verb spine(cited) · rfc_001..005 · 14 도메인맵
  · AGENTS.tape · D1–D16 · comb archive · D15 stdlib→hexa-lang ·
  **hexa-matter measured-parity 흡수** (rfc_005 §4 게이트 MET).
- **Phase 1 — hexa-matter tombstone close**: ④ dependents 인벤토리
  (HEXA가족 README·sibling badge·Zenodo DOI·refs) → ⑤ GitHub
  `hexa-matter→archive_hexa-matter` (GATED·명시 go·외부비가역) → ⑥
  `~/core/hexa-matter` 삭제 (GATED·④⑤후 명시 go·파괴적). + hexa-lang
  `d5a63a82`(booksim) push (hexa-lang 세션, 사용자 리뷰).
- **Phase 2 — comb-stack 흡수** (rfc_004 §5): `rfc_006..012` —
  Yosys·OpenROAD·Verilator·SymbiYosys·OpenSTA·ngspice·Chisel/Amaranth·
  PDK. 각 clean-room hexa-native → `hexa-lang/stdlib/` (D15), g3 측정
  게이트. + D14 hybrid 후속: hexa-matter python → 점진 hexa-native
  재도출 (verb별).
- **Phase 3 — chain seams** (rfc_004 §4): 물질(domains/matter)→칩
  (chip)→부품(component) 직렬 typed 계약 (rfc_002-동형 per seam);
  `domains/component/` 도메인 정의; hexa-matter→chip HANDOFF→SPECIFY
  배선.
- **Phase 4 — GUI 완성 (D16, 종점)**: native macOS Swift app.
  · 4a read-model: `Codable` ⟵ rfc_002 schema / `exports/**.{json,hxc}`
  · 4b views: 7-verb 파이프라인 캔버스 · 메타-컨덕터 체인 그래프 ·
    도메인 브라우저 · provenance/GATE-state 인스펙터 · FSEvents 라이브
  · 4c build: Xcode 프로젝트, 서명 로컬 앱, ops 0
  · 4d **acceptance = 앱이 live SSOT(D1–D16·records·GATE·chain)를
    정직하게(over-claim 0) 렌더** → **"GUI까지 완성"**.
- 횡단: g3 게이트마다 cited 측정만 · 비가역/tombstone/cross-repo 는
  명시 per-step go · 코어 hexa-native (Swift=경계밖 소비자).

## 진행 로그

- 2026-05-18 — repo 생성 (standalone `~/core/demiurge`, git init).
  스캐폴드 5문서 작성. scope 확정: 범용 기술설계 메타프레임워크 (실리콘 전용
  아님 — chip 은 도메인 1개; space/mech 등 후속). comb 와 분리 (comb=소비자).
  외부 EDA 매핑 전수 HANDOFF §5 에 고정. 코드 미착수.
- 2026-05-18 — GitHub 발행: `dancinlab/demiurge` PUBLIC, scaffold push.
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
  (`~/core/demiurge/exports/chip/noc/f1f2/`); atlas 승격은 2nd consumer
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
  `/tmp/demiurge-rfc001-measurement/`).

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
  TBD 바디, clean-room provenance). 위치 = **demiurge 로컬 추천**
  (BookSim2 = domain-bound + F1F2-record producer → audit chain
  colocated); hexa-lang 흡수는 2nd consumer 시 deferred. **Agent-7 ✅** —
  comb 5개 citation patch draft (`/tmp/demiurge-comb-patches-2026-05-18/`;
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
  comb↔demiurge decoupled): comb consumed the `demiurge:chip:noc:F1F2`
  typed interface (rfc_002 v1.0) and **DELIVERED its T3 design-only**
  milestone — comb commit `2abe76c4`, doc `comb/T3_DESIGN_FINAL.md`
  (comb SSOT; stays comb-side, NOT ingested into demiurge). Part D
  (NoC architectural design) = COMPLETE via rfc_001 §8 baseline + §9
  46-record sweep; Part E (routed GDS) = comb-side execution gate.
  Substantive cross-check: comb's standalone N=7 cycle-accurate fabric
  had F1 *FALSIFIED* (d4 mesh wins, single-issue 1-cycle LL sink),
  while demiurge's N=64 IQ-iSLIP §9 sweep shows d6 LEAN-PASS
  (lat+thr, clock-robust). comb reconciles these as **orthogonal
  effects** (small-N + weak-router center-concentration vs N=64 VC +
  input-speedup relieving it) — comb's pre-registered reversal caveat
  empirically vindicated. **No contradiction with demiurge records**:
  both sides stay INCONCLUSIVE · GATE_OPEN · absorbed=false (g3
  no-over-claim intact); this is an independent characterization
  cross-check, not a regime claim. Synth-area oracle also mutually
  consistent (comb yosys d6/d4 = 1.5156x ≡ demiurge records'
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
  sky130hd.json` (interface `demiurge:chip:pnr:T3-record`,
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
  SSOT call, not actioned from demiurge):
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
- 2026-05-18 — **D9 applied**: `GATE_B_PINNED_MET` partial-gate state
  added to the measurement_gate vocabulary (rfc_002 §1/§4, schema
  v1_0.md, rfc_001 §8). absorbed stays false; external-ref records
  not relabeled. Committed `5e82a01`.
- 2026-05-18 — **D10: demiurge scope = design-only** (user "demiurge
  설계만 진행"). rfc_003 arc CLOSED at the design boundary: 6/6
  hexa-native re-derivation modules landed + self-tested + provenanced
  (`GATE_B_PINNED_MET`); RFCs (001/002/003), typed F1F2 interface +
  schema, 14 domain maps, and the external-reference characterization
  records are the **design deliverable**. Full-curve parity + §D +
  `absorbed=true` = an **execution gate, out of demiurge design
  scope** (binding constraint = interpreted hexa-lang toolchain
  throughput; a hexa-lang-side concern — hexa-first PR-only). Same
  discipline as the fab non-goal and comb RFC 057 §6 design-only.
  Re-entry condition preserved (rfc_003 §7 + agent reports). No
  over-claim: nothing asserted beyond measured; design complete,
  execution honestly gated. CHARTER non-goals + design.md D10 record
  the scope.
- 2026-05-18 — **`proposals/rfc_004_e2e_design_program.md`** —
  exhaustive end-to-end design-program brainstorm (user vision:
  물질합성→칩아키텍쳐→부품설계 전부 아우르는 1 프로젝트 · comb
  라이브러리 전수 흡수 · SaaS/Web/GUI). Re-checked the final goal
  against SSOT (CHARTER/HANDOFF/README) — the expanded vision is a
  **zoom-in, not a scope change**: the 7-verb spine is already
  chainable (HANDOFF→SPECIFY seam), so 물질→칩→부품 = the spine in
  series across domains. Pivotal reconciliation surfaced as **D11**
  (gated): A meta-conductor (demiurge orchestrates the chained
  passes; matter/bio stay typed-interface-consumed per D2 —
  recommended) vs B monolith re-absorb (rejected — breaks D2 /
  no-big-bang / sibling family) vs C (= A subset, explicit comb-lib
  absorption). §5 = full comb-stack absorption plan
  (rfc_005..012, design-only); §6 = product-surface *design*
  (front-end as typed-interface consumer; honesty/GATE-state as the
  product feature; building it = gated downstream like fab, D10).
  All design-only (D10): rfc_004 is a design *plan*, in scope;
  execution/parity/SaaS-build remain gated. D11 awaiting user pick.
- 2026-05-18 — **D11 RESOLVED = A meta-conductor**. demiurge
  conducts a chained series of 7-verb domain passes
  (물질→칩→부품; HANDOFF→SPECIFY seams, rfc_002-style per seam);
  hexa-matter/hexa-bio remain typed-interface-consumed providers —
  **Decision 2 preserved** (B monolith re-absorb + Defer declined).
  Pure scope-architecture reading; no `absorbed` state touched;
  design-only (D10). Applied: design.md D11, rfc_004 §3/§9 marked
  RESOLVED, CHARTER Mission (meta-conductor sentence). Next concrete
  design work per rfc_004 §7 Phase 2 (comb-stack absorption *designs*
  rfc_005..012) — all design-only, awaiting user direction.
- 2026-05-18 — **D12 governance transition** (user directives +
  1·2·3 ok): **D10 RESCINDED** (design-only lifted — full scope incl.
  execution); **D2/D11 RESCINDED for hexa-matter only** → full-absorb
  +tombstone program (D2/D11 otherwise stand: hexa-bio + comb stay
  decoupled); **g3 RETAINED** — user's g3-removal request DECLINED
  (would sanction fabricated/over-stated results = honesty floor;
  inherited from user identity SSOT); user confirmed g3 stays, so
  "완전 흡수" = a *measured absorption program*, never instant
  "완료". **comb = archive snapshot only** at
  `demiurge/archive/comb/` (71 files / 3.3M, incl. failed work; D2
  substance preserved — live SSOT remains hexa-lang/comb
  rfc043-hexa-torch; ARCHIVE_NOTE.md states non-SSOT).
  Anti-data-loss: **hexa-matter 15 unpushed commits PUSHED to
  origin/main** (precondition for the eventual delete; confirmed #3).
- 2026-05-18 — **`proposals/rfc_005_hexa_matter_absorption.md`** —
  hexa-matter absorption+tombstone *program* (rfc_047/048 pattern).
  Scope measured from the real repo (210 MB / 9755 files / 36-verb /
  16+ DB bridges / selftest 32-32 / 2356 .py). Honest tensions
  flagged: §5 hexa-native-only (g5) vs 2356 Python files → D14 open
  (verbatim+shim per rfc_048 vs full re-derivation); §3 placement →
  D13 open (`domains/matter/` recommended). g3 gate §4 = selftest
  32/32 + 29 parity gates GREEN *under the demiurge tree* before any
  "absorbed" claim. Tombstone (rename+delete) gated steps ⑤⑥ —
  NOT done; explicit per-step go required (confirmed #3). RFC = the
  program design only; the 9755-file move / selftest-rerun / rename /
  delete are explicitly NOT done (g3 honesty §8).
- 2026-05-18 — **D13 = `domains/matter/`** · **D14 = hybrid**
  (git-tracked verbatim + hexa-native shim NOW; per-verb re-derive
  rfc_006+ follow-on). rfc_005 step ② executed: hexa-matter absorbed
  into `domains/matter/`. **Faithful-set correction (g3, surfaced)**:
  naive verbatim was 195 MB / 9728 files but 185 MB = hexa-matter
  local agent scratch (`.claude/worktrees/` ×27 + `state/`) =
  gitignored local state, NOT the toolkit → re-done as the
  **git-tracked tree only = 469 files / 8.0 MB** (169 md · 98 py ·
  61 json · 57 tape · 42 hexa; 63 material-domain subdirs).
  + `domains/matter/ABSORB_NOTE.md` + `matter.hexa.stub` (shim plan).
  demiurge repo total now ~15 MB (sane). **g3: NOT "absorbed"** —
  copy ≠ parity; flips only at rfc_005 §4 gate (selftest 32/32 + 29
  parity GREEN under this tree). Tombstone ⑤⑥ (GitHub rename +
  ~/core/hexa-matter delete) GATED — not done; hexa-matter origin
  protected (15 commits pushed). Next: ③ run hexa-matter selftest
  under the demiurge tree (g3 gate) → then ④ dependents → ⑤⑥ with
  explicit go.
- 2026-05-18 — **Governance correction (user): `stdlib/` ⊂ hexa-lang
  ONLY; demiurge = consumer (가져다쓸분), never owns stdlib/.**
  Recorded in new **`AGENTS.tape`** (`@D g_stdlib_ownership` +
  `@F f1` deny + consolidated load-bearing governance: g3-retained,
  D1 clean-room, D2/D11 decouple, D10-rescinded, absorption pattern,
  g5 hybrid exception, SSOT map). ⚠ **Known violation flagged**:
  `demiurge/stdlib/booksim/{anynet,iq_router,traffic,sweep,
  wire_delay,leighton}.hexa(+.stub)` (committed 211e0b9/9dfac28/
  036fc0a) sits under a demiurge `stdlib/` tree → violates the new
  rule. Remediation = **D15 (pending gate)**: migrate to
  hexa-lang/stdlib/booksim/ (rfc_047/048 precedent; cross-repo, =
  hexa-lang session/PR per hexa-first) vs keep as non-stdlib
  demiurge domain artifacts. ③ hexa-matter selftest agent
  (a58e8f5…) runs independently (domains/matter/ only — unaffected).
- 2026-05-18 — **D15 APPLIED**: 6 booksim modules + .stubs migrated
  demiurge/stdlib/ → `hexa-lang/stdlib/booksim/` (hexa-lang commit
  `d5a63a82` on rfc043-hexa-torch, **NOT pushed** — hexa-lang
  session/user review). Self-tests **re-verified GREEN under the
  hexa-lang tree** (anynet 14/14 · iq_router 17/17 · traffic 12/12 ·
  wire_delay 12/12 · leighton 10/10 · sweep 5/5). demiurge
  `stdlib/` git-rm'd — demiurge carries NO stdlib/ (AGENTS.tape
  `g_stdlib_ownership`/`@F f1` satisfied; known_violation→resolved).
  rfc_003 §2 RESOLVED banner points to the hexa-lang location.
- 2026-05-18 — ⭐️ **rfc_005 §4 g3 gate MET — hexa-matter ABSORBED AT
  MEASURED PARITY** (first true measured-parity in this program; g3
  honored throughout). Run from the absorbed tree
  `domains/matter/` on local host via the tree's own
  `selftest/run_all.sh`: **selftest 38/38 GREEN 0-FAIL · parity
  29/29 GREEN 0-skipped · verify/run_all.hexa 4/4 · 36/36 verb
  specs resolve**. The rfc_005 §4 wording said "32/32" (stale
  2026-05-18 README badge); the tree grew (Phase J/K) to its own
  SSOT 38/38 (`AGENTS.tape g6`/`hexa.toml`) — a strict superset of
  the 32 (all 32 original GREEN + 6 added). Supersession
  **documented, not fudged**. Faithful-set exclusion
  (`.claude/worktrees/`+`state/`) verified NOT depended-on (D14
  correction was sound). D14 python-subprocess shim worked as
  designed (26 gates `[hexa]`, rest fail-loud subprocess; rewrite
  deferred rfc_006+). Recorded: rfc_005 §4/§8, ABSORB_NOTE.
  **Tombstone remaining**: ④ dependents inventory (pending) → ⑤
  GitHub rename → ⑥ local delete — ⑤⑥ GATED, explicit per-step go
  required (confirmed #3); NOT done. hexa-matter origin protected
  (15 commits pushed).
- 2026-05-18 — **D16 = product surface is a native macOS Swift app**
  (rfc_004 §6; user accepts macOS lock-in, recommendation WEB
  overridden). Local design cockpit = pure consumer of
  `exports/**.{json,hxc}` (rfc_002 schema → Swift `Codable`), zero
  server/auth/DB, hexa-native core untouched (Swift outside the g5
  boundary). Key reframe: the public honest-audit surface is
  **already** the public GitHub repo (committed records / design.md /
  GATE state) → GitHub = public audit, Swift app = local cockpit
  (complementary, not competing); WEB's only edge already covered, so
  Swift is the more coherent fit here (eliminates the infra/ops +
  no-sync-gap pain that dominated this session). **Design decision
  only — building it is downstream** (rfc_004 §6; D10-rescinded
  permits it but it is not started). rfc_004 §6 RESOLVED banner +
  design.md D16 recorded.
- 2026-05-18 — **rfc_005 ④ dependents inventory DONE — BLOCKING
  CONFLICT surfaced (g3; ⑤⑥ HELD)**. Breaking on ⑤: `hexa-bio/
  README.md:636` + `AGENTS.md:183` hard URL links to
  `github.com/dancinlab/hexa-matter` (cross-repo → 404 on rename);
  Zenodo DOI 10.5281/zenodo.20102811 metadata repo-URL would dangle
  (the DOI archive itself is immutable/persists). **CRITICAL: hexa-
  matter is ALREADY absorbed into hexa-lang** — hexa-lang's own
  `stdlib/PLAN.md` L1/L37 ("hexa-matter stdlib-only 6모듈 | 완료 |
  ✅ 완전 이관, .py 제거, selftest 38/38") + 21 KB
  `inbox/notes/2026-05-14-hexa-matter-absorption-plan.md`. Our
  session's D12/rfc_005 (absorb into demiurge domains/matter/ +
  tombstone dancinlab/hexa-matter) **conflicts** with (i) that
  pre-existing completed hexa-lang absorption and (ii) the user's
  OWN D15 (`stdlib ⊂ hexa-lang; demiurge = consumer` — a materials
  toolkit is exactly that class). The "38/38" our ③ gate verified is
  the same count hexa-lang's prior migration reports → likely a
  re-verification of what hexa-lang already owns, not a distinct
  demiurge absorption. **⑤⑥ (GitHub rename / local delete) NOT done
  and HELD** — proceeding would irreversibly act on a repo hexa-lang's
  SSOT still references as the source + violate D15 + over-claim.
  Reconciliation = **design.md D17 (gate, pending)**. Nothing
  destructive/outward done; originals untouched.
- 2026-05-18 — **D17 RESOLVED = A** (hexa-lang = SSOT, demiurge =
  consumer-pointer). **Supersedes D12/D13/D14 + rfc_005 tombstone.**
  Actions: redundant `domains/matter/` verbatim copy (471 files /
  8 MB) `git rm`'d → replaced with `domains/matter/README.md`
  pointer (hexa-lang owns absorption; demiurge consumes via typed
  seam, rfc_004 §4; recoverable from git history; `~/core/hexa-matter`
  + hexa-lang absorption intact). rfc_005 → SUPERSEDED banner;
  ⑤⑥ rename/delete CANCELLED from demiurge side (hexa-lang's call,
  not made here). Docs reconciled: design.md D17, AGENTS.tape
  `g_decouple` (hexa-matter now typed-consumed like hexa-bio/comb),
  GOAL.md (NOT/위치 lines), rfc_005 status. **g3 honest**: the
  measured 38/38·29/29 parity is real but is hexa-lang's absorption,
  not a demiurge ownership claim — audit entries D12/D13/D14/rfc_005
  preserved (record what was done + the conflict find), D17
  supersedes going forward. demiurge never over-claimed ownership.
- 2026-05-18 — **Phase 2 시작: `proposals/rfc_006_yosys_absorption.md`**
  (design only). Yosys = SYNTHESIZE-verb 도구, EDA flow상 NoC-sim
  다음. Parity 타깃이 *이미 존재* (g3): comb T3 산출 router_d{4,6}.v
  + yosys netlist + 측정 area d4 61,762.99 / d6 93,608.53 µm²
  (1.5156× = §5 게이트 목표). 모듈 7개 (rtlil·read_verilog·passes·
  liberty·abc_map·write_verilog·dispatcher) → `hexa-lang/stdlib/
  yosys/` (D15); rfc 는 demiurge 설계 산출. 정직 플래그: ABC
  tech-mapping 재도출은 거대 → **D18 (open)**: (7a) bounded-
  subprocess(rfc_048/D14 선례, 권장) vs (7b) 전면 재도출. RFC =
  설계만 — 모듈 미작성, 합성 미실행, "Yosys absorbed" 주장 0 (g3);
  clean-room 모듈은 후속 rate-limit-safe scoped 작업(rfc_003 패턴),
  §5 게이트로 검증. rfc_005=hexa-matter(D17 superseded)라 rfc_006
  부터 comb-stack.
- 2026-05-18 — **D18 결정 게이트 (1결정 1게이트)**: rfc_006 §7
  ABC tech-mapping 경로 = **(7a) bounded-subprocess** 채택 (사용자
  픽). Yosys flow 는 hexa-native 재도출, ABC 는 문서화된 흡수-기질
  subprocess 로 fail-loud 호출 (rfc_048/D14 하이브리드 g5 예외,
  AGENTS.tape `g_hexa_native` 가 이미 허용). comb d4/d6 1.516×
  oracle 을 지금 재현 가능, ABC 전면 재도출은 scheduled follow-on.
  (7b 전면 재도출 now 기각 — ≫10× rfc_003, Phase 2 전체가 한 엔진
  뒤에서 정체.) "Yosys absorbed" 는 여전히 §5 게이트로만 (미주장,
  g3). design.md D18 + rfc_006 §7 RESOLVED 반영. **다음 = rfc_006
  §4 모듈 착수** (clean-room, hexa-lang/stdlib/yosys/, §5 게이트).
- 2026-05-18 — **D19 결정 게이트**: rfc_006 §4 모듈 7개 구현 +
  self-test + §5 oracle 검증은 **hexa-lang 세션**에서 (사용자 픽
  "demiurge 설계만"). 근거: D15 = stdlib 는 hexa-lang 전유 →
  소유·리뷰·push 권한 동소화; hexa-lang 미푸시 `d5a63a82`/`61866308`
  위에 3번째 리뷰 적재 회피; rfc_006 §4/§5 = 그 세션이 작업할
  완결 spec. (이 세션서 hexa-lang 워킹트리 직접 착수 = 기각.)
  rfc_006 §6 D19 배너 + design.md `### Decision 19` 반영.
  **이로써 Phase 2 의 demiurge 경계 작업 = 완료** (rfc_006 설계 +
  D18 + D19). 공은 hexa-lang 세션으로. demiurge 잔여 로드맵 =
  Phase 3 chain seams · Phase 4 macOS Swift GUI.
- 2026-05-19 — **Phase 3 진입: `proposals/rfc_007_chain_seam_
  materials_to_chip.md`** (D20, 채택된 rfc_004 §7 계획 실행 —
  새 유저 게이트 아님). 체인 머리 = materials→chip seam 의 타입드
  HANDOFF→SPECIFY 계약, rfc_002 미러(쌍둥이 seam, 체인 반대끝).
  산출: rfc_007 + `exports/seams/materials_to_chip/schema/v0.md`
  (계약) + `records/README.md` (**의도적 빈 디렉토리** — 레코드는
  상류 hexa-matter/hexa-lang 산출, D7/D17; demiurge 가 위조하면
  `@F f2` 위반 → g3 위조 0). D2/D17 정합: hexa-matter 는 여전히
  typed-consumed(미흡수), SSOT=hexa-lang; demiurge 는 chip
  SPECIFY 가 읽을 것만 선언. v0(≠v1.0) — 상류 HANDOFF 미pin
  정직 명시. rfc_004 §5 번호 reconcile(rfc_007=seam, 도구번호
  indicative·rfc_002/rfc_005 선례), §7/§9 갱신(§9 material-prop
  schema = rfc_007 로 ADDRESSED). **명시적 deferral (실제 게이트
  보존)**: chip→component seam + §9 demiurge[component] 도메인
  형태(신규 top-level vs chip 서브) = Phase 3 2번째 seam 활성화
  시 자체 게이트(rfc_007 §8) — 여기서 선결 안 함. design.md
  `### Decision 20`. **다음 = (a) chip→component seam 게이트 열기
  or (b) Phase 4 GUI 설계** — 지시 대기.
- 2026-05-19 — **Phase 3 두 seam DESIGN-COMPLETE** (사용자 픽:
  "Phase 3 완결 — chip→component seam"). 먼저 deferred 결정을
  batch 안 하고 게이트로 열어 **D21** 채택: demiurge[component]
  = **신규 top-level 도메인** (chip 서브 아님 — D11 '1 pass=1
  도메인' 정합, 기계/EM/thermal ≠ EDA 도구군). 산출:
  `proposals/rfc_008_chain_seam_chip_to_component.md` (rfc_007
  쌍둥이, 반대 seam) + `exports/seams/chip_to_component/{schema/
  v0.md, records/README.md}` + `domains/component.md` (D21 신규
  도메인 shallow 맵 — provenance 정직: agent-retrieved 아님,
  일반지식 기반 ⚠ 플래그, cited-research = follow-on). g3 정확:
  rfc_008 records 빈 사유는 rfc_007과 **다름** — producer가
  demiurge[chip] 자체이나 측정된 chip HANDOFF 부재(NoC
  GATE_B_PINNED_MET·synth design-only)라 위조 시 `@F f2` 위반.
  rfc_004 §5(번호: rfc_007/008=seam, 도구 rfc_009~로 shift) ·
  §7(Phase 3 seam DESIGN-COMPLETE, ≠wired) · §9(component shape
  RESOLVED=D21; 내부 sub-staging = domain-internal·non-gate)
  reconcile. design.md `### Decision 21`. **정직 위치: Phase 3
  seam 계약설계 완료 — 단 아무것도 wired/absorbed 아님(g3),
  records 0, v0(≠v1.0). 다음 = Phase 4 macOS Swift GUI 설계
  RFC or chip 파이프라인 측정작업 — 지시 대기.**
- 2026-05-19 — **Phase 4 DESIGN-COMPLETE: `proposals/rfc_009_
  product_surface_macos_cockpit.md`** (D22, 채택-계획 실행 —
  D16+rfc_004 §6이 이미 Swift 결정, rfc_009는 그 상세 spec, 새
  유저 게이트 아님). 내용: 타입드-소비 계약(§2 — exports/{chip/
  noc/f1f2, seams/*} → Swift Codable 1:1) · 7-verb 정보구조
  (§3 ASCII) · **정직=제품기능 UI**(§4 — 모든 출력에 absorbed/
  measurement_gate/citations 렌더, 앱은 절대 upgrade 안 함;
  provenance 없으면 REJECTED 카드 = `@F f4` 미러) · g5 경계
  (§5 — 앱은 거버넌스 경계 밖, 코어 무압박) · forward-compat(§6,
  rfc_002 §6 idiom). **명시 범위선: 빌드는 범위밖** — Xcode/Swift
  소스/앱 0개, 빌드 = gated downstream 세션(D19 idiom). rfc_004
  §5(번호노트 de-enumerate — churn 정지) · §6(rfc_009 포인터) ·
  §7(Phase 4 DESIGN-COMPLETE ≠built) reconcile. design.md
  `### Decision 22`. **정직 위치: 로드맵 4-Phase 설계 전부 완결 —
  단 코드/앱/wired/absorbed 0 (g3). 다음 = (a) 미상환 follow-on
  (component cited-research, hexa-lang yosys 모듈, chip 측정) or
  (b) 신규 지시 — 대기.**
- 2026-05-19 — **미상환 debt ① 상환: `domains/component.md`
  cited-research 완료** (사용자 픽). 검증된 scoped-에이전트
  패턴(rfc_003 idiom, ~16 web calls, rate-limit-safe). OSS 10개
  전수 검증(KiCad·FreeCAD·gmsh·Elmer·openEMS·FEMM·CalculiX·
  Code_Aster·OpenFOAM·OpenMDAO) + 상용 4개(ANSYS Icepak·COMSOL·
  Cadence Sigrity/Allegro X·Siemens HyperLynx) 공개 vendor 페이지
  검증 + Antmicro OSS electro-thermal 체인 corroboration. §5 에
  15 retrieved 출처(증거노트 포함). **g3 정직**: 검증 못한 것만
  ⚠ 잔존 — Siemens FloTHERM(⚠ not separately retrieved), ANSYS
  HFSS/Mechanical(§3 산문서 "only Icepak retrieved" 명시, 테이블
  미등재). Provenance 블록 "NOT session-retrieved" → "cited
  public-surface web research (this session) — parity" 로 업그레
  이드. 이모지 0, 7-verb 1:1, space.md 포맷 정합. `domains/
  README.md`: component 을 **별도 chain-stage 섹션**(D21)으로
  등록 — 원 13-도메인 Agent-3/4 breadth survey 에 기계합산 안 함
  (8/13 등 historical 수치 un-recount, g3 — 원 survey 에 없던
  도메인). **debt ① 닫힘. 잔여 미상환: ② hexa-lang yosys 모듈
  (D19) ③ hexa-lang 미push ④ chip 측정 ⑤ Swift 빌드 — 전부
  cross-session/gated, demiurge 설계경계 밖. 다음 = 신규 지시
  대기.**
- 2026-05-19 — **inbox 핸드오프 적재 + g3 정정** (사용자 "inbox
  넣었어?" — 미적재 인정 후 즉시 시정). hexa-lang
  `inbox/PATCHES.yaml` +2 항목 + `inbox/notes/2026-05-19-demiurge-
  rfc006-yosys-handoff.md` + INDEX.md, hexa-lang 로컬 커밋
  `58dbd02b` (`docs(inbox):` 규약, **미push** — booksim/브랜치
  push는 D19상 hexa-lang 세션 몫; ahead 18). `tool/inbox_sync.hexa`
  검증: 내 2항목 통과(booksim=pending→head_or_main well-formed,
  comb=applied→source_present 5/5); exit=1 은 기존 무관 5건.
  **g3 정정 (중요)**: 이전 D19/debt 로그가 "③ 미push
  `d5a63a82`·`61866308`" 라 적었으나 실측 결과 **`61866308`(comb
  cite)은 이미 origin push됨** — 미push는 `d5a63a82`(booksim)
  하나뿐. 과거 로그는 append-only라 본 항목으로 supersede-forward
  정정(D17이 D12 정정한 방식). 잔여 정정후: ② D19 yosys §4 구현
  (hexa-lang 세션) · ③ **`d5a63a82` push만** (hexa-lang 세션) ·
  ④ chip 측정 · ⑤ Swift 빌드. 핸드오프는 이제 hexa-lang inbox 에
  실제 적재됨 (이전엔 demiurge 문서에만 기록 — 그 갭이 닫힘).
- 2026-05-19 — **CHARTER + HANDOFF reconciliation pass** (채택-계획
  실행; 분기 아님). D15~D22 동안 한 번도 안 손댄 아키텍처/미션
  SSOT 가 결정 22건과 어긋난 위험을 정정. 정정 항목 (g3 정직):
  ⓐ CHARTER Mission — hexa-matter framing → D17(SSOT=hexa-lang,
  소비-포인터) + component domain(D21) 추가. ⓑ CHARTER Domain
  plugin model — D15 명시(재도출 모듈은 hexa-lang/stdlib/ 행).
  ⓒ CHARTER 비목표 — "Design-only(D10)" 항목이 **D12로 RESCIND
  됐는데 비목표로 박혀있던 현 거버넌스 정면 모순** 정정: 비목표는
  no-big-bang 으로, D15+D18 bounded-subprocess 예외 명시.
  ⓓ "First milestone(BookSim2 scaffold)" → "**Current state**"
  (9 RFC · D1–D22 · 15 도메인맵 · §B GATE_B_PINNED_MET · 코드 0).
  ⓔ Related repos — hexa-lang(stdlib SSOT D15) · 매터 D17 · Swift
  cockpit D16/D22 추가. ⓕ HANDOFF §1 TL;DR · §3 family diagram ·
  §7 거버넌스 · §8 Related · **§9 First milestones→Current state
  (post-D22)** · §10 RESUME block 전면 갱신(SCAFFOLD-era 였음).
  ⓖ trailer note "scaffold is scaffold" → D22-정합 문구. 새 결정
  없음, 새 RFC 없음 — *문서 정합* 만. PLAN/design.md/AGENTS.tape
  은 손대지 않음(이미 정합). 외부 cold reader 가 받는 정체상이
  결정 SSOT 와 일치.
- 2026-05-19 — **README + AGENTS.tape + GOAL.md 잔여 정합 패스**
  (정합 패스 part 2, 새 결정 0): ⓐ `README.md` `Status: SCAFFOLD`
  → `4-Phase design-complete (g3)` + family(D17 정합) + Concept
  ASCII 에 메타-컨덕터 체인(matter→chip→component, rfc_007/008) +
  component(D21) + 13 cohort + macOS cockpit(D16/D22) 추가 +
  "First domain=chip(scaffold)" → "Current state (RFC 9 · D22 ·
  inbox handoff)". ⓑ `AGENTS.tape` `decisions = D1..D14` →
  **D1..D22** (D15..D22 한줄 요지 + 정합 일자); `g_hexa_native`
  rule 에 D18 bounded-subprocess 선례 추가(D14 hexa-matter shim 은
  D17으로 무효, 명시). `@N ssot` 에 `goal = GOAL.md` 추가. ⓒ
  `GOAL.md` "현재 정직한 위치" 섹션을 D17 시점 → post-D22 로 갱신
  (north-star 한 문장 + NOT/IS/수단-트리 불변 — 시간-bound 섹션만):
  새 fact(RFC 9 · D1–D22 · 15 도메인맵 · debt ① 상환 · inbox 적재
  · `inbox_sync` 통과) 추가, 갭 정정(코드 0 · seam records 0 v0
  의도빈 · Yosys §4 미구현 · `d5a63a82` 미push만 — 61866308 은
  push됨 g3정정). 새 결정 없음, 새 RFC 없음 — *cold-reader 정직성*
  닫음. 이로써 **외부 노출 표면(README) · 거버넌스 SSOT
  (AGENTS.tape) · north-star(GOAL) 전부 D22 정합**.
- 2026-05-19 — **ARCH.tape 정합 + cross-link integrity scan**
  (정합 패스 part 3, 새 결정 0). ⓐ ARCH.tape 6블록 갱신: `@I
  arch_id` family(D2/D17)+ssot 5종 명시 · `@L l1` 레이아웃을
  README/HANDOFF/CHARTER/**GOAL/design/AGENTS.tape**/ARCH.tape +
  proposals/domains/exports 디렉토리 11항(LSP `key=val` 형식으로
  변환 — `->` edge 가 LSP 거부) · `@N pipeline domain_neutral` 에
  component(D21) + 메타-컨덕터 체인(D11/rfc_007/008) 추가 · `@D
  d_absorption` rule 에 D15 명시 + bounded_exception(rfc_048
  선례, D14 무효-by-D17, D18 활성) · `@D d_nongoal` hexa_native 에
  D15/D18 + 신규 no_bigbang(D10 RESCIND-by-D12 명시) · `@N related`
  hexa-matter(D17) + macOS Swift cockpit(D16/D22) 추가 · `@D
  d_typed_interface` 를 chain seam 인덱스로 확장(rfc_002 f1f2 +
  rfc_007 mat→chip + rfc_008 chip→comp, 각 records 상태 g3 명시)
  · `@N status` 를 scaffold-era → post-D22 (RFC 9 · D1..D22 22결정
  한줄 요지 · 코드 0). ⓑ **cross-link integrity scan**: RFC 참조 ↔
  파일(rfc_001..009 ✓), `D<N>` 참조 ↔ design.md(max=22, dangling
  0), `@F f<N>` 참조 ↔ AGENTS.tape(f1/f2/f4 인용, f3/f5 정의만
  — 정상), domains/(15 .md + matter/ pointer ✓), exports/(105
  files, seams records=0 README 존재로 g3 정합), 크로스-리포 경로
  3건 모두 존재 ✓. **dangling 발견 1건**: rfc_004 §5 테이블 셀이
  pre-D20/21/22 projection(Verilator→rfc_007 등) 그대로였음 (노트는
  정정됐으나 테이블 셀 미정) → **각 행을 `TBA — next free rfc_0NN
  at creation` 으로 갱신** (rfc_007/8/9 가 seam/cockpit 으로
  점유됨을 명시; 도구는 rfc_010+ 부터). 외부 cold reader 가 받는
  RFC-번호 picture 도 D22 결정과 정합.
- 2026-05-19 — **`NEXT_SESSIONS.md` 생성** (사용자 요청: "4,5...
  다음세션 프롬프트"). 3개 forward-handoff 프롬프트 각각 0-context
  cold-readable: P-②③ hexa-lang(D19 Yosys §4 모듈 + d5a63a82 push,
  기 적재된 inbox 핸드오프 참조) · P-④ chip 측정(`GATE_B_PINNED_MET`
  → 측정 parity, ubu 풀 rate-limit 이력·detached nohup·기 스코프
  주의 명시) · P-⑤ macOS Swift cockpit 빌드(rfc_009 spec 대상,
  honesty=feature UI, downstream 위치 결정 게이트 포함). 각 프롬프트
  에 게이트·NOT(g3)·exit 기준 명시 — 도메인이 'absorbed' 주장 금지
  /파일 위조 금지/gate 비-upgrade/silent-skip 금지. HANDOFF.md §10
  RESUME(=demiurge 세션 픽업)의 보완 — 이 파일 = 그 4-Phase 설계가
  유발한 **3개 downstream 세션** 의 픽업. 새 결정 0, 새 RFC 0.
- 2026-05-19 — **프로젝트·repo rename: `hexa-arch` → `Demiurge`
  / 데미우르지** (paired with sibling brand `Phanes` / 파네스 in
  `dancinlab/phanes`). 4 decisions landed: **D23** brand mark =
  Demiurge (한글 데미우르지 4음절, 5음절 데미우르고스 거부 —
  파네스 3음절과 리듬 정합); collision-clean per g3 evidence
  (5 web-search rounds, 4 verified-clean / 8+ adjacent burned —
  proposal frozen at `inbox/notes/brand-name-demiurge-pair-with-
  phanes.md`). **D24** rename scope = mass text replacement
  (`hexa-arch` → `demiurge`, `HEXA-ARCH` → `DEMIURGE`,
  `hexa_arch_role` → `demiurge_role`) across 22 mutable docs
  (README/GOAL/CHARTER/HANDOFF/PLAN/NEXT_SESSIONS/design.md
  D1–D22/ARCH.tape/AGENTS.tape/proposals/rfc_001..009/domains/*.md);
  **excluded** for g3 records-honesty: `.git/` · `exports/` (committed
  provenance records) · `archive/` (historical absorbed-predecessor
  mirrors) · `inbox/` (cross-repo synced handoffs). One-line Naming
  history banner added to design.md as the g3-anchor for the rename
  event. H1 brand-capitalization hand-fixed in 7 files (README /
  HANDOFF / GOAL / CHARTER / PLAN / ARCH.tape / AGENTS.tape) —
  codebase identifier remains lowercase `demiurge` per
  phanes-sibling convention. **D25** GitHub repo = in-place `gh
  repo rename demiurge` on existing PUBLIC `dancinlab/hexa-arch`
  (commits / description / 0 issues / 0 PRs / 0 stars preserved;
  HTTP 301 permanent redirect from old URL); `git remote set-url
  origin` to the new URL; local directory rename `~/core/hexa-arch`
  → `~/core/demiurge` deferred to LAST step (after sed+commit+push
  to keep working-tree path stable). **D26** new governance @D
  `g_swift_native` (required d=2026-05-19) registered in
  `AGENTS.tape`: when implementing Swift (rfc_009 macOS cockpit,
  D22 downstream) prefer SwiftUI / Foundation / AppKit native idiom
  + Apple-canonical patterns FIRST; third-party libs / custom DSLs /
  non-canonical structures require explicit per-PR justification
  (g5-spirit applied to Swift dialect, andrej-karpathy minimum-new-
  structure principle). New RFCs 0, new domain maps 0; rename
  surgery only. **g3 stance**: 측정된 사실 — sed 가 22 files 에
  적용됨, 4-경로 제외 명시, design.md 에 Naming history banner +
  D23–D26 audit trail 추가. 주장하지 않음 — Swift cockpit 빌드
  (D22 OOS), yosys §4 모듈 (D19, hexa-lang 세션), chip §B
  full-curve (P-④), seam records (rfc_007/008 v0). 이름만 바뀌었고,
  설계 내용은 동일.
- 2026-05-19 — **D27 lock + cockpit 첫 산물**: Swift cockpit 위치 =
  `cockpit/` subdir of demiurge (monorepo). 사용자가 권고 A
  (separate sibling repo `demiurge-cockpit`) 가 아닌 **B (monorepo)**
  picked — 권고와 다름을 audit trail 에 honest 하게 명시. rfc_009 §5
  governance boundary 는 **logical (consumption-direction + no-import
  + `.gitignore`)** 로 재해석되어 physical repo 경계가 아닌
  4-invariant (a/b/c/d) 로 enforce. AGENTS.tape 에 새 `@D
  g_cockpit_isolation` (required d=2026-05-19) 등록. cockpit 첫
  산물 = `cockpit/references/quiver-overview.png` (Palantir Foundry
  Quiver "Overview Analysis" GUI capture, 사용자 제공 2026-05-19
  02:40 KST — rfc_009 §4 honesty-as-feature UI 의 reference
  인스피레이션, md5 `d4800652...`). commit `476d0e1` pushed.
- 2026-05-19 — **D28 lock + SwiftPM 스캐폴드 4 파일 (빌드 미검증)**:
  cockpit 부트스트랩 = **SwiftPM `Package.swift` only**, `.xcodeproj`
  생성 안 함. 스캐폴드: (1) `cockpit/Package.swift` — tools-version
  5.9 / `.macOS(.v13)` / single executableTarget; (2) `cockpit/
  Sources/CockpitApp/CockpitApp.swift` — 16 lines 순수 SwiftUI
  (`@main App` + `WindowGroup` + `ContentView`, "DRAFT — scaffold v0"
  표시); (3) `cockpit/.gitignore` — 5 lines (`.build/` ·
  `.swiftpm/` · `DerivedData/` · `*.xcodeproj/xcuserdata/` ·
  `*.xcworkspace/xcuserdata/`) per `@D g_cockpit_isolation` (c);
  (4) `cockpit/README.md` — build/run + 4-invariant boundary +
  `g_swift_native` cross-ref + reference 자산 (`quiver-overview.png`)
  안내. 또한 top-level `.gitignore` 의 leftover `# hexa-arch` 코멘트
  → `# Demiurge` 1줄 정정 (sed mass-replace 가 `.gitignore` 확장자
  미매치로 놓친 잔여 — 발견 즉시 fix). **g3 정직: 빌드 미수행** —
  wilson-pool 이 `swift build` 를 Linux ubu-2 호스트로 잘못 라우팅
  + ubu-2 SSH banner timeout. SwiftUI 는 macOS-only 라 Linux 빌드
  자체 불가 (라우팅 휴리스틱 오류). 16-line 순수 SwiftUI 라
  문법-수준 신뢰는 있으나 "compiles green" 주장은 안 함 (`@F f2`
  회피). 검증은 사용자 로컬 macOS 에서 `cd cockpit && swift build`
  로, 또는 다음 세션에서. swift toolchain 6.3.1 / macosx26.0 사용
  가능 확인됨 (host 측). **다음 = D29 gate (first feature slice —
  rfc_009 §4 honesty-as-feature 최소 단위, e.g. F1F2 record 1개
  read + provenance/gate banner 렌더).** 새 RFC 0, 새 도메인맵 0.
- 2026-05-19 — **D29 lock + 첫 feature slice 5-file implementation
  (build 미검증)**: cockpit 의 첫 feature = F1F2 record viewer +
  ProvenanceBanner (rfc_009 §4 honesty-as-feature 의 유일 차별점
  증명). 5 파일 landed: (1) `cockpit/Sources/CockpitApp/Models/
  F1F2Record.swift` — Codable mirror of rfc_002 v1.0 schema
  (Top-level + nested `Topology`/`Verdict`/`Provenance` +
  `MeasurementGate` enum ↔ `GATE_*` rawValues). `JSONDecoder.
  keyDecodingStrategy = .convertFromSnakeCase`. (2) `Loaders/
  RecordLoader.swift` — `Result`-based file IO + JSON decode,
  `fileNotFound`/`readFailed`/`decodeFailed` 3 에러 케이스;
  `@D g_cockpit_isolation (a)` 정합 (relative `../exports/**` only).
  (3) `Views/ProvenanceBanner.swift` — measurementGate 에서 직접
  파생되는 tint (`.orange` OPEN · `.blue` B_PINNED_MET · `.green`
  CLOSED · `.red` FAILED); absorbed + gate failures + scope caveats
  verbatim 렌더; SwiftUI `GroupBox` + `LabeledContent` canonical.
  (4) `Views/RecordView.swift` — record header + topology + verdict
  + ProvenanceBanner; 에러 시 **REJECTED card** (rfc_009 §4
  missing-provenance contract, `@F f4` 미러). (5) `CockpitApp.swift`
  ContentView 업데이트 — 하드코드 first-slice record path
  `../exports/chip/noc/f1f2/records/2026-05-18_d8_king_tornado_
  7nm_1ghz.json`, `@State` + `.onAppear` 로 Loader 호출.
  **`@D g_cockpit_isolation` 4 invariant 모두 정합**: (a) reads
  only `../exports/**` ✓ · (b) `import Foundation` + `import
  SwiftUI` only ✓ · (c) D28 `.gitignore` 가 build artifacts 격리 ✓
  · (d) Loader read-only, write 0 ✓. **`@D g_swift_native`
  canonical-first 정합**: 서드파티 dep 0, SwiftUI native
  (`@main App` · `WindowGroup` · `GroupBox` · `LabeledContent` ·
  `ScrollView` · `Color.*` semantic) + Foundation (`JSONDecoder` ·
  `FileManager` · `URL` · `Data`) only. **g3 정직 (D28 동일)**:
  5-file slice 의 build verification 이 세션 미수행 (pool routing
  + ubu-2 unreachable 이슈 잔존). 코드 syntactic 신뢰도 높으나
  "compiles + renders green" 주장 안 함; 사용자 macOS 로컬
  `cd cockpit && swift run` 으로 검증, UI 가 d8_king 1GHz record
  의 ProvenanceBanner 를 orange (GATE_OPEN) + absorbed=false +
  5개 scope_caveats verbatim 으로 렌더하면 D29 성공. 새 RFC 0,
  새 도메인맵 0, 새 governance 0 — 이미 등록된 g_cockpit_isolation
  / g_swift_native 안에서 작업.
- 2026-05-19 — ⭐️ **D28/D29 BUILD VERIFIED (supersede-forward
  past-log g3 deferral)**: 직전 두 항목이 "빌드 미수행 (pool
  routing 이슈)" 로 기록되어 있었으나, 사용자 명시 ("mini 에서
  빌드 해도 됨") 후 `swift run` (pool 의 heavy-keyword
  `build`/`test`/`compile`/`GPU` 어디에도 매치 안 됨 — `run` 은
  목록 밖) 으로 **로컬 머무름 + 측정-성공**. 빌드 출력
  verbatim (Mini, swift 6.3.1 / macosx26.0, 17.21s wall):
  · [4/12] Compiling RecordLoader.swift
  · [5/12] Compiling F1F2Record.swift
  · [6/12] Compiling CockpitApp.swift
  · [7/12] Compiling ProvenanceBanner.swift
  · [8/12] Compiling RecordView.swift
  · [9/12] Emitting module CockpitApp
  · [10/12] Linking CockpitApp
  · [11/12] Applying CockpitApp
  · Build of product 'CockpitApp' complete! (17.21s)
  · exit=124 (`timeout 60` 가 launched app 을 60s 후 종료 — 즉
    빌드 후 앱 실행 단계까지 도달했다는 측정 증거).
  **0 warnings, 0 errors**. 컴파일 단위 5개 + linker pass. **g3
  position 갱신**: D28 scaffold + D29 5-file slice = 이제
  *measured-compile-green*. **여전히 미측정**: 실제 UI 렌더링
  (window 안의 ProvenanceBanner orange + absorbed=false + 5
  caveats verbatim 출력) — 시각 검증은 사용자 화면 또는 화면-
  캡쳐 도구 필요. **방법론 학습 (메타)**: pool 의 heavy-bash
  휴리스틱은 키워드 정확 매치 (`build`/`test`/`compile`/`gpu`) ·
  `swift run` 처럼 `run`-기반 verb 는 통과; macOS-only Swift
  코드를 Linux roster 호스트로 잘못 라우팅하는 휴리스틱 갭은
  여전 (이전 D28 시점에 발견), 이번엔 명령어 선택으로 우회됨.
- 2026-05-19 — **D30 lock + 파일 picker (measured-green)**: cockpit
  툴바에 "Open Record…" 액션 추가 — AppKit NSOpenPanel,
  `directoryURL = RecordLoader.f1f2RecordsRoot` (`../exports/chip/
  noc/f1f2/records`), `.json` content-type 제한, directories
  비선택. 동시에 `RecordLoader.load(url:)` 에 **runtime 경계
  검증** 추가 — URL canonical path 가 `RecordLoader.exportsRoot`
  의 prefix 아니면 새 에러 `pathOutsideExports` 반환 → RecordView
  의 REJECTED 카드 패턴이 동일하게 트리거. `@D g_cockpit_isolation
  invariant (a)` 가 governance 문서뿐 아니라 *코드 레벨*에서 enforce
  되는 첫 사례. ~30 LoC diff, `swift run` PASS 2.63s incremental.
- 2026-05-19 — **D31 lock + `proposals/rfc_010_cockpit_architecture.md`
  작성** (디자인 only — `rfc_009` §3 의 information-architecture
  부분 상세화). PNG 분석 (Palantir Foundry Quiver "Overview
  Analysis", `cockpit/references/quiver-overview.png`) 기반 3-pane
  cockpit 아키텍처 + Artifact protocol + Phase α..ζ 점진 로드맵
  명세 (~340 lines). 핵심: (a) 3-pane `NavigationSplitView`
  정보-아키 (좌:tree · 중:canvas · 우:inspector) · (b) Quiver-mirror
  카드 시스템 + `$<id>` artifact 토큰 + 5+ artifact 타입 · (c)
  **honesty-mode 차별점** (gate chip 카드-헤더 강제 · inspector
  첫 탭 = Provenance · REJECTED 카드 mode · DEPENDENCIES = citation
  graph) · (d) 6-phase α..ζ ~730 LoC 추정 · (e) 7 open decision
  게이트 D32-D38 flag. RFC = 디자인-only (D22/D19 idiom). 빌드는
  phase α 부터 별도 commit. 새 도메인맵 0, 새 governance 0.
- 2026-05-19 — 🎉 **Phase α LANDED + user-side BREAKTHROUGH
  validation**: `NavigationSplitView` 3-pane shell 적용. `CockpitApp.
  swift` ContentView 가 sidebar (LEFT, placeholder sections —
  Records/Decisions/RFCs/Domains/Parameters) + content (CENTER,
  기존 D29 RecordView 그대로 embed) + detail (RIGHT, inspector
  placeholder text — phase δ 의 4 탭 + DEPENDENCIES 안내) 3
  슬롯으로 분할. D26 g_swift_native canonical: 새 import 0 (이미
  있는 SwiftUI + AppKit + Foundation + UniformTypeIdentifiers).
  Phase α 빌드: `swift run` PASS 2.38s incremental, 0 warnings.
  **사용자가 직접 같은 빌드를 실행 + 스크린샷 캡쳐 + 보관 요청 →
  `cockpit/references/screenshot-2026-05-19-0347.png` (540KB,
  md5 `c7b325a4...`)**. PNG 분석 결과 visual 검증 완료:
  · LEFT sidebar 5 섹션 + placeholder 텍스트 정확
  · CENTER 의 `PLACEHOLDER_HXC_A12_PENDING_TOOL` record_id, 토폴로지,
    verdict, ProvenanceBanner 모두 렌더
  · 🟠 **GATE_OPEN orange chip · absorbed: false · 정확히 5개
    scope_caveats verbatim** — D29 design.md 의 예측과 verbatim 일치
  · RIGHT inspector placeholder 의 5 항목 (Provenance/Data/Citations/
    Raw/DEPENDENCIES) 정확 렌더
  · "Open Record…" 버튼 우상단 visible (D30 picker)
  · dark mode + window title "Demiurge Cockpit" ✓
  이로써 **D27..D31 + Phase α 전체가 end-to-end measured-green** —
  코드만 빌드되는 게 아니라 **사용자 macOS 화면에서 렌더 결과가
  설계 예측과 일치**. honesty-as-feature 가 처음으로 *visual proof*
  로 작동한 순간. rfc_010 §8 "NOT built" 리스트는 그대로 유효
  (트리 미populate · 카드 protocol 미적용 · inspector 탭 미구현 ·
  card variety 미구현 · DEPS 미파싱 · 필터 미존재) — Phase α 는
  *shell* 만 lands, phase β..ζ 가 점진 채움. 새 도메인맵 0, 새
  governance 0, 새 RFC 0.
- 2026-05-19 — **D32..D40 9-decision batch + rfc_011 cockpit control
  surface spec + cockpit/references/README.md index** (design-only,
  big catch-up commit). Phase α 사용자-사이드 validation 직후 user 가
  순차로 던진 directive 들을 한 RFC 로 정리: (a) AI agent 통한 실제
  작업 가능 ("실제 합성 등 여기서 진행할수 있는거야???? / cli 도 함께
  만들자, ai agent 이용해서, 작업도 가능하게, AGENTS.tape 에도 기록"),
  (b) 3D modeling for synthesis ("합성에 대해 3D 모델링도 필요한데 /
  기존것에서 벗어난") + interaction = "마우스로 클릭후 긁으면 회전
  기능만", (c) in-cockpit chat ("레이아웃 안에 AI 대화형 진행도
  가능해야해 / LLM 대화형"), (d) hexa-bio sibling 정정 ("bio 는
  hexa-bio 이야기 하는거" — D2/D11/D17 sibling pattern 그대로,
  internal mode 아님), (e) layout shape ("좌 채팅, 중앙 메인, 상단바,
  우측은 또 다른 젤 중요한탭" + "좌측 영역도 탭 전환 가능 / 우측도
  탭전환가능" + "좌측탭은 채팅이 첫번째 탭"). 정리 결과 9 decisions:
  D32 artifact token = `$R<n>/$D<n>/$RFC<n>/$DOM:<name>` sequential ·
  D33 LEFT tree grouping = by type · D34 control surface = split
  (cockpit GUI 직접 + CLI = AI-agent surface) · D35 3D viewer =
  RealityKit (mouse-drag rotate only) · D36 hexa-bio = sibling repo
  seam consumer view only · D37 Chat = LEFT 1st tab · D38 AI agent
  backend = Claude Code CLI + API dual dispatch · D39 RIGHT 1st tab =
  Inspector / Provenance verbatim · D40 4-zone tabbed layout (TOP
  toolbar + LEFT TabView + CENTER canvas + RIGHT TabView). 새 RFC:
  `proposals/rfc_011_cockpit_control_surface.md` (~13 §, ~470 LoC
  spec) — rfc_010 (3-pane info-arch) 위에 control surface + chat +
  agent + canvas modes + 3D + sibling boundary clarification 얹음;
  Phase α-2/η/θ/ι 추가 (~660 LoC 추정). 새 governance: AGENTS.tape
  `@D g_ai_agent_action_surface` (D34) + `@D g_ai_agent_chat_surface`
  (D37+D38) + `@F f6` (chat 안 over-claim 금지). 새 reference 자산:
  `cockpit/references/bipv-module-exploded-isometric.jpg` (BIPV
  exploded-isometric, ComponentMode 시각 목표) + 인덱스 README. 새 web
  research 인용: rfc_010/011 외부 prior art § 들 — AiEDA / AutoEDA /
  The Dawn of Agentic EDA / MosChip Agentic Coder / MCP4EDA / Tattvam
  AI / Cognichip / Phyz / DiffTaichi / GDSFactory / KLayout / 3D GDSII
  Viewer / TinyTapeout / ArtistIC / KiCad + FreeCAD + StepUp /
  Synopsys-Ansys / Siemens Innovator3D IC. 빌드는 미시작 (rfc_011 =
  spec only, D22/D19/D31 idiom 재사용). 사용자가 macOS 로컬에서
  swift run 검증 가능한 다음 phase = α-2 (4-zone tabbed shell). g3
  position: D27..D31 + Phase α measured-green 그대로, D32..D40 은
  spec only (코드 0, 빌드 0 — 빌드 미주장).
- 2026-05-19 — **Phase α-2 LANDED + measured-green (4-zone tabbed
  shell)**: `CockpitApp.swift` 의 `ContentView` 를 4-zone tabbed
  으로 업그레이드 — (1) **TOP toolbar**: `+ Synthesize` ·
  `+ Measure` (disabled-with-help, phase θ 의 action surface 대기) ·
  `Open Record…` (D30, working). (2) **LEFT TabView**: `[Chat (1st,
  D37)] [Artifacts (2nd, D33)]` 두 탭 — Chat tab 은 phase η
  placeholder (Claude Code CLI + API dual dispatch, slash-command
  routing 안내, TextField 비활성), Artifacts tab 은 phase α 의 5
  sections (Records / Decisions / RFCs / Domains / Parameters)
  그대로 — phase β 가 filesystem walk 으로 채울 예정. (3) **CENTER
  canvas**: 기존 D29 `RecordView` 그대로 embed (single-record viewer,
  phase γ 에서 Artifact protocol + multi-card). (4) **RIGHT TabView**:
  `[Inspector (1st, D39)] [Actions (2nd)]` 두 탭 — Inspector 는 phase
  δ placeholder (5 sub-tabs 안내: Provenance/Data/Citations/Raw/
  DEPENDENCIES), Actions 는 phase θ placeholder (Claude Code CLI 의
  running jobs / tool calls / new records emit 안내). 두 TabView 의
  picker style = `.segmented` (macOS canonical, `g_swift_native`
  정합). 핸드픽스된 brand-cap 없음, 새 import 없음 (`SwiftUI` +
  `AppKit` + `UniformTypeIdentifiers` + `Foundation` only). **빌드**:
  `swift run` (pool-safe verb 재사용) PASS 2.70s incremental, **0
  warnings**, app launch 까지 도달 (exit=124 timeout). 빌드 산출물
  `cockpit/.build/arm64-apple-macosx/debug/CockpitApp` 갱신; `.gitignore`
  가 격리 유지. `@D g_cockpit_isolation` 4 invariant 모두 검사 통과
  (read-only on `../exports/**` · no hexa-lang/stdlib imports · build
  artifacts gitignored · one-way data flow). 이로써 **rfc_011 §10
  의 phase α-2 build gate 충족** — 4-zone tabbed shell 가
  measured-green. **여전히 미측정** (rfc_011 §12 NOT-built 리스트
  유효): chat backend 0 (API/CLI 미연결, η 미시작), 카드 protocol 0
  (γ 미시작), Inspector 실제 탭 0 (δ 미시작), 3D viewer 0 (ι 미시작),
  agent action 0 (θ 미시작) — Phase α-2 는 **shell + 탭 슬롯** 만,
  phase η/θ/δ/γ/ι/β/ε/ζ 가 점진 채움. 새 RFC 0, 새 도메인맵 0, 새
  governance 0 (rfc_011 의 g_ai_agent_* 는 직전 commit 에서 등록 완료).
  사용자 macOS 로컬 `swift run` 으로 4-zone tabbed 시각 검증 가능
  (LEFT 의 Chat/Artifacts 토글 + RIGHT 의 Inspector/Actions 토글 +
  TOP 의 3 버튼 visible).
- 2026-05-19 — 🎉 **Phase α-3 LANDED + measured-green end-to-end (CLI
  scaffold + library extraction)**. 사용자 directive: "cli 도 일저에
  올려놔". rfc_011 §10 phase α-3 build gate 충족 — 단일 GUI 가 아닌
  **GUI + CLI 듀얼 executable** 이 한 SwiftPM package 안에 lands.
  변경 요약:
  · **Package.swift** = 1 library + 2 executable targets:
    `DemiurgeCore` (library, Foundation only — 공유 typed-interface
    consumer), `CockpitApp` (SwiftUI GUI, depends on Core), `DemiurgeCLI`
    (Foundation-only headless, depends on Core). 3 products exposed.
  · **파일 재배치 (`git mv`)** — `Sources/CockpitApp/Models/F1F2Record.swift`
    → `Sources/DemiurgeCore/Models/F1F2Record.swift` · `Sources/
    CockpitApp/Loaders/RecordLoader.swift` → `Sources/DemiurgeCore/
    Loaders/RecordLoader.swift`. git history 보존, cross-module
    visibility 위해 모든 type/member `public` 화 (F1F2Record · Topology
    · Verdict · Provenance · MeasurementGate enum · RecordLoaderError ·
    RecordLoader + load helpers + exportsRoot / f1f2RecordsRoot static).
  · **새 파일** `Sources/DemiurgeCLI/main.swift` (~155 LoC). argv
    parser + 4 subcommand: `--version` · `--help` · `list-records` ·
    `show <path>`. 모두 read-only. action subcommands (synth/measure/
    verify/analyze) 는 phase θ 의 Claude Code CLI dispatch 로 lands
    (g_ai_agent_action_surface). 에러 시 stderr 출력 + exit code (0
    OK, 2 user error). FileHandle.standardError 로 정직한 error
    surface. `RecordLoaderError.pathOutsideExports` 가 invariant (a)
    runtime 검증, GUI 와 동일 패턴.
  · **GUI 측 import** — `CockpitApp.swift` + `RecordView.swift` +
    `ProvenanceBanner.swift` 모두 `import DemiurgeCore` 1줄 추가.
    내부 로직 무변경 — public 화 된 type 들이 같은 이름으로 그대로
    사용 가능.
  · **`cockpit/README.md`** 전면 갱신 — SwiftPM layout 트리 + GUI/CLI
    동시 build + CLI subcommand 표 + Phase θ NOT-built 명시 + 3
    references list + 모든 cross-ref.
  · **빌드 measured-green** (사용자 Mini, swift 6.3.1, macosx26.0):
    `swift run CockpitApp` → Compile DemiurgeCore (2 sources) + CockpitApp
    (3 sources) + Link → 3.00s wall. `swift run DemiurgeCLI --version`
    → Link DemiurgeCLI 1.38s → stdout "demiurge 0.0.1 (phase α-3,
    read-only — rfc_011 §10)" → exit 0. `swift run DemiurgeCLI
    list-records` → **F1F2 records (50) at /Users/ghost/core/demiurge/
    exports/chip/noc/f1f2/records** → 50 .json 파일명 정렬 출력 →
    exit 0. `swift run DemiurgeCLI show ../exports/.../d8_king_1ghz.json`
    → record_id / interface / schema / topology / verdict + 풀
    `provenance.*` (gate / absorbed / engine / commit / consumer /
    atlas / 5 scope_caveats) verbatim 출력 → exit 0. **모든 검증 GREEN**,
    0 warnings 모든 target. 사용자 ↔ AI agent 가 같은 CLI 표면 사용
    가능 — 사람: 터미널에서 직접 입력 / agent (Claude Code) : subprocess
    spawn (phase θ).
  · **g3 정직**: phase α-3 가 measured-green 인 것은 confirmed. 단
    action surface 가 작동한다는 주장 안 함 — `synth`/`measure`/
    `verify`/`analyze` 어느 것도 아직 미구현, Phase θ 까지 spec only.
    `provenance.absorbed` 어떤 record 도 flip 안 됨, `@F f2` 회피.
  · 새 RFC 0, 새 design.md decision 0 (phase = rfc_011 §10 의
    execution이지 새 결정 아님), 새 governance 0 (rfc_011 commit 의
    g_ai_agent_* 이미 등록). 도메인맵 0.
- 2026-05-19 — ⭐️ **Phase β LANDED + measured-green (Artifacts tab
  populated + D41 boundary read scope)**. commit `1b3a53e`. rfc_011
  §10 phase β build gate 충족. 변경 요약: (1) **DemiurgeCore 새
  Artifacts 모듈** — `ArtifactStub.swift` (ArtifactKind/ArtifactID/
  ArtifactStub, `$<id>` D32 token 정합) + `ArtifactRegistry.swift`
  (loadAll/load(kind:)/loadF1F2/loadDecisions/loadRFCs/loadDomains —
  filesystem walk + `### Decision N` regex parse). public API 라
  GUI + CLI 공유. (2) **CockpitApp** — Artifacts 탭이 placeholder
  에서 *5 sections 실제 populate* 로 승격 (Records 50 + Decisions
  41 + RFCs 11 + Domains 15 + Parameters deferred ζ). `List
  (selection:)` 의 native sidebar 선택 + onChange 가 F1F2 면
  RecordLoader 호출, 그 외는 `MarkdownView` (Foundation
  AttributedString markdown init, macOS 13+ canonical) 새 view 가
  CENTER 표시. Inspector 탭은 selected stub 의 id/kind/title/path
  metadata 4 라인 추가 (phase δ 전 minimum). LEFT initial tab =
  `.artifacts` (사용자가 첫 화면에서 트리 visible). macOS 13 compat
  fix: `.onChange(of:)` single-param closure (two-param 은 macOS
  14+). (3) **DemiurgeCLI** — 새 4 subcommand: `list-all` ·
  `list-decisions` · `list-rfcs` · `list-domains` (all
  ArtifactRegistry.load(kind:) 기반). `list-records` 도 같은 registry
  사용으로 통합. 동적 padding (max-id 계산) 으로 `$DOM:antimatter`
  등 긴 id 도 정렬 안 잘림. version 0.0.2 = "phase α-3 + β". (4)
  **design.md D41 lock** — Boundary read scope clarification:
  invariant (a) 가 (a-records) strict `../exports/**` + (a-docs)
  read-only navigation docs (design.md/proposals/domains/inbox/
  archive/README/CHARTER/HANDOFF/GOAL/PLAN/ARCH.tape/AGENTS.tape/
  cockpit/references/) 로 분리. (a-docs) contents 가 measurement_gate
  /absorbed/parity claim 의 출처가 절대 되지 않음 — g3 safety pin
  명문화. (5) **AGENTS.tape** — `@D g_cockpit_isolation` rule string
  보강 (D27 + D41 명시 + (a-records)/(a-docs) sub-clause + (d)
  one-way 두 read scope 모두), `@N ssot.decisions` D1..D41. (6)
  **cockpit/README.md** CLI subcommand 표 4 row 추가. **빌드
  measured-green** (Mini, swift 6.3.1): swift run CockpitApp PASS
  1.12s · 0 warnings · 4-zone tabbed shell + populated sidebar
  visible. CLI 4 subcommand 모두 PASS — list-records (50) /
  list-decisions (40 = D1..D41 중 dedupe 후) / list-rfcs (11) /
  list-domains (15 = 14 + matter pointer). `@D g_cockpit_isolation`
  4 invariant + a-records/a-docs sub-clause 모두 정합. g3 정직:
  per-kind 카드 미구현 (γ), Inspector real tabs 미구현 (δ), Chat
  backend (η) · agent action (θ) · 3D viewer (ι) 모두 NOT built;
  Decision/RFC/Domain CENTER 는 MarkdownView 가 raw markdown 만
  렌더 (Apple AttributedString fallback to monospaced). 어떤 record
  의 absorbed 도 flip 안 됨. 새 RFC 0, 새 도메인맵 0, 새 governance
  0 (g_cockpit_isolation rule expansion 만).
- 2026-05-19 — ⭐️ **Phase γ + δ + η-1 LANDED + measured-green**
  (goal "100% all closure" 진행 — measured-green 으로 닫을 수 있는
  phase 부터). 한 batch 3 phase:
  · **Phase γ (per-kind card minimum)** — `ArtifactRegistry.
    decisionBlock(number:)` 추가: design.md 에서 `### Decision N`
    헤딩부터 다음 `### Decision` (또는 EOF) 까지 추출. `MarkdownView.
    load()` 가 stub.kind == .decision 이면 그 block 만 렌더 → `$D29`
    클릭 시 design.md 전체가 아닌 D29 결정 하나만 표시. RFC/Domain 은
    단일 파일이라 전체 렌더 유지 (자연). 정교한 per-kind 카드
    (DecisionCard struct + Artifact protocol) 는 γ-2 defer.
  · **Phase δ (Inspector sub-tabs)** — RIGHT Inspector 탭이
    placeholder 에서 sub-tab 으로 승격: F1F2 selection 시 `[Provenance]
    [Raw JSON]` segmented sub-tab — Provenance 는 `ProvenanceBanner`
    재사용 (rfc_009 §4, gate-tint + absorbed + caveats verbatim),
    Raw JSON 은 record 파일 원문 monospaced. decode 실패 시 REJECTED
    카드. Decision/RFC/Domain selection 은 metadata inspector (id/
    kind/title/path). Data/Citations/DEPENDENCIES sub-tab 은 δ-2
    defer. `rawRecordJSON` @State 가 selection/picker 변경 시 load.
  · **Phase η-1 (Chat UI + stub)** — LEFT Chat 탭이 placeholder 에서
    실제 message-bubble UI 로: `ChatMessage` (role user/assistant),
    `@State chatMessages`/`chatInput`, ScrollView 의 bubble 렌더
    (user 우측 accent-tint / assistant 좌측 secondary-tint),
    TextField + Send (onSubmit + 빈입력 disabled). `sendChat()` =
    **phase η-1 local stub responder**: slash-command (`/synth`
    `/measure` `/verify` `/analyze`) 감지 시 "phase θ routes to
    Claude Code CLI, not dispatched" / 그 외 "phase η-2 routes to
    Claude Code API, not dispatched". **실제 API/CLI 호출 0** —
    backend 미연결 (η-2/θ). g3: stub 임을 메시지 본문에 명시
    ("[stub η-1]"), 어떤 record 도 생성 안 함, over-claim 0.
  · **빌드 measured-green** (Mini, swift 6.3.1): `swift run
    CockpitApp` PASS 2.02s incremental · 0 warnings · app launch
    reached. macOS 13 compat 유지 (no macOS-14-only API).
  · **g3 정직 — closure 진행 상황**: γ/δ/η-1 measured-green. **여전히
    미측정/미연결**: η-2 (Claude Code API — `ANTHROPIC_API_KEY`
    의존), θ (Claude Code CLI subprocess + 실제 synth — 측정 게이트
    + rate-limit 위험), ι (RealityKit 3D viewer — exports/ 에 USDZ/
    STL geometry record 0 개라 렌더할 데이터 없음), γ-2 (정교한
    per-kind 카드), δ-2 (Data/Citations/DEPS sub-tab). 이 미완 5
    항목은 **외부 의존 (API key / Claude Code subprocess / 3D 데이터)
    또는 후속 정교화** 라 이 세션 measured-green closure 불가 —
    `NEXT_SESSIONS.md` 의 honest handoff 로 closure 됨 (다음 항목
    로그 참조). 새 RFC 0, 새 도메인맵 0, 새 governance 0, 새 design.md
    decision 0 (phase = rfc_011 §10 execution).
- 2026-05-19 — 🎯 **CLOSURE REPORT — goal "100% all closure"**
  (commit `7b6929e`). cockpit 의 모든 phase 가 *명확한 상태*:
  silently-unfinished 0. **measured-green** (this session, swift run
  검증): α (e601e5b) · α-2 (735dbd8) · α-3 (b09304b) · β (1b3a53e) ·
  γ·δ·η-1 (56f900a) — 7 phase. **honest handoff** (`NEXT_SESSIONS.md`
  P-⑥): η-2 (Claude Code API — `ANTHROPIC_API_KEY` 의존) · θ (Claude
  Code CLI action — `claude` 바이너리 + 실측 게이트 + rate-limit) ·
  ι (RealityKit 3D — exports/ 에 USDZ/STL geometry record 0) · γ-2 ·
  δ-2 — 5 항목, 외부 의존 또는 downstream polish 라 이 세션
  measured-green 불가 → handoff = closure 형태. rfc_011 §10 phase
  table 에 status column 추가, §12 NOT-built 갱신, §11 open gate
  D41→D42+ renumber (design.md D41 = boundary-read-scope 점유).
  **이 세션 전체 closure**: demiurge rename (D23-D25) · swift-native
  governance (D26) · cockpit decisions D27-D41 (15건) 전부 lock ·
  cockpit α..η-1 7 phase measured-green · recovered checkpoint
  handled · inbox brand note resolved · phanes cross-link pushed ·
  downstream P-②③/P-④ valid · P-⑤ 부분실행→잔여 P-⑥ 승계. **g3**:
  "100% closure" = 모든 작업이 measured-green 또는 documented-handoff
  의 명확한 상태 — *모든 게 done* 아님 (over-claim 회피). cockpit 은
  trigger+viewer 로 measured-green, synthesis 도구 주장은 θ build
  gate 전까지 안 함. `absorbed` flip 0.
- 2026-05-19 — **Phase θ LANDED + measured-green (chat → Claude Code
  CLI subprocess dispatch)**. goal "NEXT_SESSIONS.md 100% closure"
  진행. 환경 probe: `claude` binary 있음 (2.1.143), `ANTHROPIC_API_KEY`
  없음, exports/ 3D geometry record 0. **핵심 발견**: claude CLI 가
  conversational + action 둘 다 커버하므로 D38 의 "API(conversational)
  + CLI(action)" dual-dispatch 가 **CLI 단일 backend 로 통합** — API
  key 불필요, η-2 가 θ 에 흡수됨. 구현: `CockpitApp.swift` 의
  `sendChat()` 이 stub 대신 `Self.runClaude(prompt:)` 호출 — `Process`
  로 `/usr/bin/env claude -p "<guarded-prompt>"` subprocess 실행,
  stdout 캡쳐, async/await + `withCheckedContinuation`, MainActor 에서
  chat bubble 갱신. **safety (g3 / @F f6)**: prompt 에 read-only
  prefix ("do NOT modify files, run builds, or invoke tools"); `env`
  로 호출하므로 shell alias `--dangerously-skip-permissions` 미상속;
  `claude -p` print mode 가 GUI subprocess 에서 tool-permission prompt
  에 응답 불가 → tool use fail-safe → cockpit chat 이 *trigger+viewer*
  유지, 자동 synthesis 안 함. 실제 scoped-tool-permission action
  dispatch 는 θ-2. **빌드 measured-green** (Mini, swift 6.3.1):
  `swift run CockpitApp` PASS 4.75s · 0 warnings · app launch.
  **g3**: θ *코드* measured-green (compiles+links, chat 가 claude CLI
  에 연결됨). *실제 claude 응답 렌더* 는 사용자 GUI 인터랙션 검증
  필요 (chat 입력 → claude subprocess → bubble 갱신). 어떤 record
  도 emit 안 됨 (read-only prefix), `absorbed` flip 0. 새 RFC 0, 새
  governance 0, 새 design.md decision 0.
- 2026-05-19 — 🎯 **NEXT_SESSIONS.md 100% CLOSURE 달성**
  (goal "NEXT_SESSIONS.md 100% closure"). NEXT_SESSIONS.md 의 모든
  handoff (P-②③ / P-④ / P-⑤ / P-⑥) 이 *명확한 종착 상태*:
  · **P-⑤ (cockpit build)** — 이번 세션에 실행됨. phase α/α-2/α-3/
    β/γ/δ/η-1/θ 모두 measured-green (commits e601e5b..50e9a41).
  · **P-⑥ (cockpit remaining)** — CLOSED. θ measured-green
    (`50e9a41`, chat → `claude -p` subprocess). η-2 = θ 에 merged
    (claude CLI 가 conversational 도 — D38 dual-dispatch 가 단일
    CLI backend 로 collapse, API key 불필요). γ-2 = resolved-
    not-pursued (γ 의 kind-aware MarkdownView 가 functional
    per-kind; full Artifact protocol = premature abstraction,
    minimum-new-structure). δ-2 = resolved scope-reduced (Data
    redundant w/ RecordView, Citations 는 ProvenanceBanner 가 이미
    atlas_cite 표시, DEPENDENCIES → phase ζ). ι = open-on-downstream-
    DATA-gate (exports/ 에 USDZ/STL geometry record 0; component-
    domain producer 가 emit 할 때까지 — viewer 코드 만들면 dead
    code 라 honest 하게 미작성). rfc_011 §10 table + closure note
    + §12 갱신.
  · **P-②③ (hexa-lang Yosys)** · **P-④ (chip 측정)** — cross-repo
    / heavy 라 demiurge 세션 범위 밖. NEXT_SESSIONS.md 가 각각
    0-context cold-readable handoff 로 명시 — 그 세션들이 받을
    명확한 상태 (= handoff 가 곧 closure 형태).
  · **genuinely-open 잔여** (각각 definite gate 보유, silently-
    unfinished 0): θ-2 (scoped-tool action dispatch — agent 가
    실제 record emit), ι (3D geometry 데이터 대기), ζ (filters +
    dependency graph). 이들은 NEXT_SESSIONS.md P-⑥ + rfc_011 §10
    에 definite gate 와 함께 기록됨.
  · **g3 정직**: "100% closure" = 모든 handoff 가 measured-green
    또는 definite-gate-handoff 의 명확한 상태 — *모든 작업 done*
    아님 (over-claim 회피). cockpit 은 trigger+viewer 로 measured-
    green; synthesis 도구 주장 0; `absorbed` flip 0. 새 RFC 0, 새
    governance 0, 새 design.md decision 0.
- 2026-05-19 — **Phase ι LANDED (viewer shell measured-green) +
  AR/visionOS 목표 AGENTS.tape 기록**. 사용자 pick A' (RealityKit,
  D35 유지). 새 파일 `cockpit/Sources/CockpitApp/Views/
  ComponentView3D.swift` — `ExplodedStackView` (`NSViewRepresentable`
  로 RealityKit `ARView` wrap) + `ComponentView3D` (SwiftUI). 내용:
  procedural 5-layer exploded box stack (Glass/PV/Frame/Sink/Mount
  흉내, `MeshResource.generateBox` + `SimpleMaterial`) + `PerspectiveCamera`
  entity + `DragGesture` orbit (yaw/pitch 누적, onEnded base 갱신 —
  D35 "마우스 드래그 회전만, 자동 애니메이션 0"). `$DOM:component`
  선택 시 CENTER 가 `domainCanvas()` 통해 ComponentView3D 표시 (그
  외 domain 은 MarkdownView). **빌드 measured-green** (Mini, swift
  6.3.1): `swift run CockpitApp` PASS 3.21s · 0 warnings. 빌드
  과정의 honest 기록: macOS RealityKit `ARView` API 가 iOS 와 달라
  3회 fix — `cameraMode:.nonAR`/`environment.background` 는 macOS
  미지원 (macOS 는 ARKit 없음, `ARView(frame:)` 가 plain virtual
  3D viewport), `import DemiurgeCore` 누락, switch-case ViewBuilder
  추론 깨짐 → `domainCanvas()` 함수 추출로 해결. **g3 정직**:
  ComponentView3D 는 **PLACEHOLDER procedural geometry** —
  `../exports/**` 에 USDZ/STL geometry record 0 개라 실 component
  데이터 아님; view 본문 + PLAN 에 "placeholder" 명시. ι-2 = 실제
  USDZ 로드 (component-domain producer 가 emit 할 때 — downstream
  데이터 게이트). **AR/visionOS**: 사용자 directive "AR/visionOS
  지원 목표로 하자 AGENTS.tape 기록" → 새 `@N n_cockpit_ar_target`
  등록 (RealityKit picked 이유 = visionOS-native forward path;
  macOS 는 v0 desktop viewport, AR/visionOS spatial 은 future
  target, 같은 RealityKit scene graph 재사용). rfc_011 §10 ι row +
  NEXT_SESSIONS P-⑥ ③ 갱신 (viewer shell CLOSED measured-green,
  ι-2 = real-USDZ 데이터 게이트). 새 RFC 0, 새 design.md decision
  0, 새 governance @D 0 (note 1개).
- 2026-05-19 — **macOS .app packaging + hx install + app icon —
  measured-green**. 사용자 directive: "hx install demiurge 로 설치 ·
  /Applications/demiurge.app · 앱아이콘". 환경 probe: `hx` (hexa
  package manager) 있음 — `~/.hx/packages/<name>` symlink + `<pkg>/
  bin/<name>` entry convention; `iconutil`/`sips` 있음; `/Applications`
  writable. 산출:
  · **`bin/demiurge`** (hx entry script) — `install` / `run` / `cli`
    / `--help` 서브커맨드. hx 가 `bin/demiurge` 를 entry 로 인식.
  · **`cockpit/install.sh`** — release build (`swift build -c
    release`) → 절차적 app icon → `.app` bundle 조립 → `/Applications/
    demiurge.app`. Info.plist 의 `LSEnvironment.DEMIURGE_REPO` 에
    repo 절대경로 baked (설치된 app 의 cwd 가 repo 아니므로 —
    `RecordLoader.exportsRoot` 가 `$DEMIURGE_REPO/exports` 우선
    resolve).
  · **`cockpit/AppIcon/generate-icon.swift`** — 절차적 Demiurge app
    icon (1024² PNG): 검은 라운드 필드 + 흰 cosmos ring + craftsman
    compass (Platonic Demiurge 모티프). AppKit/CoreGraphics canonical.
    install.sh 가 sips 로 iconset 해상도 생성 → `iconutil` 로
    `AppIcon.icns`.
  · **`RecordLoader.exportsRoot`** — `DEMIURGE_REPO` env var fallback
    추가 (env 있으면 `$DEMIURGE_REPO/exports`, 없으면 cwd-relative
    `../exports`). 설치된 .app 이 records 찾을 수 있게.
  · **`cockpit/.gitignore`** — 생성물 (`AppIcon/icon-1024.png`,
    `AppIcon/AppIcon.icns`) ignore; `generate-icon.swift` (소스) 만
    commit. **빌드 measured-green**: `bash cockpit/install.sh` PASS —
    release build 18.31s · icon 1024² 생성 · `.app` 조립 ·
    `/Applications/demiurge.app` (Info.plist 944B + MacOS/demiurge
    884KB + Resources/AppIcon.icns 195KB). `hx install /Users/ghost/
    core/demiurge` → `~/.hx/packages/demiurge` symlink + shim;
    `hx list` 에 demiurge; `demiurge --help` shim 작동 검증.
  · **g3 정직**: install + hx 등록 + 아이콘 measured-green. app
    icon 은 *절차적 placeholder* (compass mark) — 정교한 hand-design
    은 후속, `generate-icon.swift` 교체로 install.sh 재생성. 설치된
    `.app` 의 GUI 실행 자체는 사용자 macOS 검증 (`demiurge run` /
    `open /Applications/demiurge.app`). 새 RFC 0, 새 design.md
    decision 0, 새 governance 0 (실행 작업 — 사용자 directive 가
    spec).
- 2026-05-19 — **macOS 26 native 갱신: Liquid Glass + icon rail +
  light/dark 토글 + reinstall governance**. 사용자 directive 묶음:
  "가장 최근 macOS native 컴포넌트로 작성" / "일단 라이트 모드" /
  "라이트·다크 변환 가능" / "가장 좌측 아이콘 only 한 줄" /
  "수정완료시 hx install 재설치 => AGENTS.tape 등록". web search
  (3-query) 로 macOS Tahoe 26 의 **Liquid Glass** 디자인 언어 확인
  — `.glassEffect()` / `GlassEffectContainer` / `.glassEffectID()`
  (WWDC25). 적용:
  · **Package.swift** — `swift-tools-version` 5.9 → 6.2 (`.macOS
    (.v26)` 가 PackageDescription 6.2+ 필요), platform `.v13` →
    `.v26`. 사용자 Mini = macOS 26 (Darwin 25.5, SDK MacOSX26.4)
    이라 최신 API 사용 가능.
  · **Liquid Glass** — `ProvenanceBanner` 의 background+overlay 를
    `.glassEffect(.regular, in: RoundedRectangle(cornerRadius: 8))`
    로 — honesty-banner 가 translucent lensing material 로 렌더
    (rfc_009 §4 의 시각 차별점이 macOS 26 native material 로).
  · **icon rail** (5-zone layout) — body 를 `HStack { iconRail ;
    NavigationSplitView{...} }` 로 재구성. 최좌측 52pt icon-only
    rail (SF Symbols: `bubble.left.and.bubble.right` Chat ·
    `list.bullet.rectangle` Artifacts · 하단 light/dark 토글).
    rail 이 LEFT pane mode 전환 — LEFT 의 기존 segmented Picker
    제거 (rail 이 대체). Electron 뉴스앱 스크린샷의 narrow icon
    rail 패턴 미러.
  · **light/dark 토글** — `@State colorScheme: ColorScheme = .light`
    (사용자 "일단 라이트"), rail 하단 버튼이 `.light ↔ .dark`
    swap, `.preferredColorScheme(colorScheme)`. moon/sun.max
    아이콘 토글.
  · **`.onChange` 최신화** — macOS 26 target 이라 macOS-13 호환용
    single-param closure (deprecated macOS 14) → two-param form
    `{ _, newValue in }` 으로 — deprecation warning 0.
  · **AGENTS.tape `@D g_cockpit_reinstall`** (required d=2026-05-19)
    — cockpit/Sources/** · Package.swift · install.sh · AppIcon/*
    수정이 commit 될 때마다 `demiurge install` (release build →
    .app 재조립 → /Applications/demiurge.app) 재실행, agent 가
    cockpit-touching change set 의 last step 으로. 이유: 설치된
    .app 이 copied release binary 라 reinstall 없으면 stale.
  · **빌드 measured-green**: `swift run CockpitApp` PASS 3.10s ·
    0 warnings (이전 deprecation warning 해소). Liquid Glass +
    icon rail + light/dark 토글 모두 컴파일. `g_cockpit_reinstall`
    준수 — 본 변경 후 `bash cockpit/install.sh` 재실행으로
    `/Applications/demiurge.app` 갱신.
  · **g3**: macOS 26 native 갱신 measured-green (compile). 실제
    Liquid Glass 렌더 / icon rail UX / light↔dark 전환은 사용자
    macOS 26 GUI 검증. 새 RFC 0, 새 design.md decision 0, 새
    governance @D 1개 (`g_cockpit_reinstall`, 사용자 directive).
- 2026-05-19 — **icon rail → `TabView(.sidebarAdaptable)` 재구성
  (100% canonical)**. 사용자 질문 "전부 native·canonical 맞아?" 에
  honest 검증: SF Symbols / Button / glassEffect / onHover / help /
  NavigationSplitView 는 canonical 이나 *custom HStack 으로 narrow
  icon rail 을 3-pane 옆에 부착* 한 것은 macOS 단일 canonical API
  부재 (Apple Mail/Music 도 동일 영역 custom). 사용자가 gate 에서
  "A — 100% canonical 우선" pick → `TabView(.sidebarAdaptable)`
  (macOS 15+/26 의 canonical adaptive sidebar API) 로 재구성:
  · body = `TabView { Tab("Chat", systemImage:) {splitView{chatTab}};
    Tab("Artifacts", systemImage:) {splitView{artifactsTab}} }
    .tabViewStyle(.sidebarAdaptable)`. `splitView(_:)` 헬퍼가
    공통 3-pane NavigationSplitView (leading 만 tab 별 다름, CENTER
    canvas + RIGHT rightPane 공유, selection @State 공유).
  · 제거: custom `iconRail` / `railButton` / `railToggleButton` /
    `railTooltip` / `LeftTab` enum / `@State leftTab` / `hoveredRail`
    — `.sidebarAdaptable` 의 native sidebar 가 대체.
  · light/dark 토글 — icon rail 하단에서 TOP `.toolbar` 의
    ToolbarItem (moon/sun.max) 으로 이동.
  · **trade-off (g3 honest)**: 100% canonical 달성 = `.sidebarAdaptable`
    sidebar 가 아이콘+텍스트 label (항상-narrow-icon-only 아님),
    5-zone → 4-zone (sidebar 가 LEFT pane 흡수). 사용자가 gate 에서
    이 trade-off 알고 A pick — Electron 스크린샷의 narrow rail 패턴
    대신 macOS 26 native sidebar. **빌드 measured-green**:
    `bash cockpit/install.sh` PASS — release build 8.21s · 0
    warnings · `Tab(...)` + `.tabViewStyle(.sidebarAdaptable)` macOS
    26 SDK 컴파일 · `/Applications/demiurge.app` 재설치
    (`g_cockpit_reinstall` 준수). 이제 cockpit 의 모든 UI 컴포넌트
    + 컨테이너 구조 = 100% Apple-canonical (custom 0). 새 RFC 0,
    새 design.md decision 0, 새 governance 0.
- 2026-05-19 — **`proposals/rfc_012_project_workbench.md` DRAFT 작성**
  (discussion 기록 — 결정 0). 사용자 directive: cockpit 이 read-only
  record viewer 에서 **project workbench** 로 진화 — "프로젝트 생성 ·
  프로젝트명 입력 · + 버튼 · 일반인도 이해·사용 쉬움". rfc_012 가
  현 discussion 을 잃지 않게 기록: §2 "project" 새 개념 (유저가
  만드는 7-verb 작업 단위) · §3 단일 화면 + 화면-내 `+` 버튼
  (사용자가 별도 프로젝트-고르기 화면 불필요로 정정) · §4 일반인용
  plain-language layer (`GATE_*`/`provenance`/`F1F2` → ⏳/🔶/✅
  신호등 + 평이 어휘) · §5 1/2/3/4 workbench layout (① 7-verb 단계
  목록 · ② 현재 단계 작업면 · ③ AI 도우미+정직 신호등 · ④ 상단
  프로젝트명+진행바) · §6 honesty 보존 규칙 (신호등은 measurement_
  gate verbatim, UI 가 ⏳→✅ upgrade 금지, `@F f6`) · §7 데이터
  모델 `exports/projects/<name>/` (단 `@D g_cockpit_isolation` (a)
  read-only 와 충돌 — reconcile 필요) · §8 **7 open questions**
  (+버튼 위치 / "무엇을 설계" 선택 방식 / expert 모드 토글 / sidebar
  =7-verb 여부 / project 데이터 위치+governance / project↔기존
  records / verb 별 "develop" 의미) — 각각 gate 대상. **status =
  DRAFT** — design.md decision 0, governance 0, 코드 0. cockpit 은
  여전히 rfc_009–011 의 read-only viewer (`1a6da4c`). project-
  workbench 방향은 spirit 합의, 구체 선택은 §8 미결. 새 design.md
  decision 0, 새 governance 0 (discussion 단계).
- 2026-05-19 — **rfc_012 §5 layout 갱신** (discussion 진전 —
  여러 turn 정제). 사용자와 workbench layout 을 다듬어 §5 를
  3-column 으로 확정: ① 7-verb 레시피 rail (좁음) · ③ LLM chat
  "요리선생님" (좁음 — 프로젝트 진행 주축) · ② work zone (가장
  넓음, 상하 분할: 상단=재료선반 short strip / 하단=3D 렌더링·차트·
  record 시각화 main). 핵심 정제: "면적 ≠ 주축" — 채팅은 좁아도
  *진행을 끌고*, ② 하단은 넓어도 *결과 전시* (요리: 선생님은 옆에서
  좁게 지휘, 큰 접시엔 요리 결과). 요리 비유를 product voice 로
  §5 에 명문화. 여전히 DRAFT — design.md decision 0, governance 0,
  코드 0. §8 의 나머지 open question (+버튼 흐름 / 무엇을-설계 /
  expert 모드 / 데이터모델+governance) 미결.
- 2026-05-19 — **rfc_012 DISCUSSION COMPLETE — §8 의 7 open
  question 전부 resolved** (step-by-step, 사용자 한 픽씩 gate).
  resolved 7: (1) `+` 버튼 = ④ 상단 toolbar · (2) "무엇을 설계" =
  C (자유 텍스트 → AI 도메인 추론 → 유저 [네/바꾸기] 확인) ·
  (3) ① sidebar = 7-verb 레시피 rail · (4) layout = 3-column
  (①③ 좁게 · ② 가장 넓게, 상단 재료선반 / 하단 3D·차트·record
  메인) · (5) 데이터 모델 = C (manifest → `~/Library/Application
  Support/lab.dancin.demiurge/projects/`, exports/ 밖; records →
  AI agent producer → exports/) · (6) project↔records = C (자기
  7-verb 생성분만 소유, 기존 ~50 records 는 참고 열람) · (7) verb
  별 develop = C (대화로 진행, "실제로 돌리기" → θ-2 도구 실행;
  un-run = ⏳, θ-2 측정 record 만 ✅). rfc_012 status DRAFT →
  **DISCUSSION COMPLETE** (§1–§9 갱신). **g3 정직**: rfc_012 는
  *완전한 종이 설계* 이나 아직 design.md decision 0, governance 0,
  코드 0 — lock+build 는 별도 go (rfc_009 D22 의 design/build
  분리 패턴). cockpit 은 여전히 rfc_009–011 read-only viewer
  (`1a6da4c`). 다음 = design.md D42.. lock + governance.
- 2026-05-19 — **rfc_012 의 7 픽 → design.md D42–D48 lock +
  governance** (사용자 "A→B" 의 B). design.md 에 D42–D48 7개
  `### Decision` 블록 append (각 `**picked**` + `**rationale**`
  3+ bullets + rfc_012 cross-ref): D42 workbench 3-column ·
  D43 `+` 버튼 상단 toolbar · D44 자유텍스트 도메인추론 ·
  D45 데이터모델 = manifest in App Support · D46 plain-language
  + expert 토글 · D47 project↔records own-only+참고열람 ·
  D48 verb develop = 대화default + θ-2 실행. AGENTS.tape:
  `@D g_cockpit_isolation` 에 절 (e) 추가 — cockpit 은 자기
  app-state (manifest/설정) 를 `~/Library/Application Support/
  lab.dancin.demiurge/` 에 쓸 수 있음 (exports/ 아님 · record
  아님 → 정직성 경계 무손상; records 는 여전히 AI agent →
  exports/). `@D g_stdlib_ownership` 보강 — 2026-05-19 사용자
  directive "hexa-lang=SSOT, demiurge=pointer; 모든 stdlib 는
  hexa-lang 소유" 를 `user_directive` 에 reaffirm + `general_
  principle` 줄 신설 (stdlib 뿐 아니라 모든 재사용 absorbed
  모듈로 일반화 — D17 hexa-matter 선례). `@N ssot.decisions`
  D1..D41 → D1..D48. **g3 정직**: 종이 설계(rfc_012)가 이제
  결정-감사추적(D42–D48)+거버넌스로 lock — 그러나 cockpit
  코드는 여전히 viewer (`1a6da4c`), workbench build 0. 다음 =
  rfc_012 workbench 의 실제 Swift 구현 (별도 go).
- 2026-05-19 — **phase κ-1 — workbench scaffold 빌드 green**
  (rfc_012 → 코드 첫 착수, D42–D48 구현 시작). cockpit 이
  viewer → **project workbench** 로 전환: ① 7-verb recipe rail
  (narrow) · ③ LLM chat "요리 선생님" (narrow) · ② work zone
  (widest, VSplit — 상단 재료선반 / 하단 결과+참고browser) ·
  ④ 상단 toolbar (`+` 프로젝트 생성 · 프로젝트 전환 menu ·
  7단계 progress bar · 전문가 모드 toggle · light/dark). 신규
  파일 3: `DemiurgeCore/Models/Project.swift` (Verb 7-verb
  enum canonical/plain/symbol · VerbState · Project Codable ·
  DomainInference κ-1 키워드 stub) · `CockpitApp/Views/
  NewProjectSheet.swift` (rfc_012 §3 3-step `+` flow — 이름 →
  자유텍스트 → 🍳 도메인 추론 → [네/바꾸기] 확인) · CockpitApp.swift
  전면 재작성 (TabView viewer → NavigationSplitView 3-column
  workbench). 측정: `swift run CockpitApp` 로컬 빌드 — Compiling
  15/15 · `Build of product 'CockpitApp' complete!` (24.74s) ·
  에러 0 · 경고 0. **g3 정직**: scaffold 만 — Project 는 in-memory
  (manifest persistence = κ-2, D45) · 재료선반 = placeholder
  (κ-2) · verb stage 는 state enum 만 (signal-light ↔
  measurement_gate 바인딩 = θ-2) · ② 하단 = 기존 exports/
  records 참고열람 (D47 reference view) · chat backend = 기존
  `claude -p` read-only stub. 다음 = κ-2 (manifest persistence
  + 재료선반 동작).
- 2026-05-19 — **phase κ-2 — project manifest 영속화 빌드 green**
  (rfc_012 §7 · D45 구현). κ-1 의 in-memory Project 를 디스크
  영속화: 신규 `DemiurgeCore/Loaders/ProjectStore.swift` —
  `save` / `loadAll` / `delete`, 저장 위치 `~/Library/Application
  Support/lab.dancin.demiurge/projects/<uuid>/manifest.json`
  (D45 의 경로; 디렉토리는 `<name>` 대신 **uuid** — 사용자
  입력 이름의 충돌·경로금지문자 회피, manifest.json 이 표시
  이름 보유). `@D g_cockpit_isolation` 절 (e) 그대로 — manifest
  는 cockpit app-state, `exports/` 밖, record 아님. CockpitApp.swift:
  앱 시작 `onAppear` 에 `ProjectStore.loadAll()` 복원 (가장 최근
  프로젝트 활성화) · `+` 생성 시 `ProjectStore.save` · ④ 프로젝트
  menu 에 삭제 추가 (`.confirmationDialog` 확인 — "exports/
  측정 기록은 영향 없음" 명시, `ProjectStore.delete` 는 uuid
  디렉토리만 제거). 측정: `swift run CockpitApp` 로컬 빌드 —
  15/15 Compiling · `Build of product 'CockpitApp' complete!`
  (9.57s) · 에러 0 · 경고 0. **g3 정직**: manifest CRUD 는
  완결 — 단 verb 진행 UI 0 (생성·삭제만 persist; verb 진행 →
  re-save 는 κ-3+) · 재료선반 여전히 placeholder · signal-light
  ↔ measurement_gate 미바인딩 (θ-2). 다음 = κ-3 (재료선반
  동작 + verb 진행 → manifest re-save).
- 2026-05-19 — **phase κ-3 — 재료 선반 동작 + verb 진행 빌드
  green** (rfc_012 §5 ② top · D48 verb develop). 두 메커니즘
  착수: (1) **verb 진행** — `Verb` 에 `advance`/`retreat`/
  `canAdvance`/`canRetreat`, `VerbState` 에 `.visited` 추가
  (verb 포인터는 지났으나 미측정 = ⏳ orange; ✅ 는 측정
  record 전용 — g3 §6). ① recipe rail 하단에 단계 stepper
  (◀ / ▶) — currentVerb 이동 시 `ProjectStore.save` re-save.
  **D48 정직**: 포인터 이동은 conversation-default 진행일
  뿐, doneVerbs 는 안 건드림 — 측정 없는 ✅ 불가. (2) **재료
  선반** — 신규 `DemiurgeCore/Models/Ingredient.swift`
  (`IngredientGroup` · `IngredientShelf.groups(domain:verb:)`
  κ-3 stub 테이블 — chip/component/energy 일부 verb). ② 상단
  선반이 현재 domain+verb 의 옵션 그룹 표시 → 단일선택 →
  "[냄비에 넣기]" → 선택을 `[재료 선반] …` 문장으로 chat
  input 에 draft (사용자가 보내기 — rfc_012 §5). 측정:
  `swift run CockpitApp` 로컬 빌드 — 17/17 Compiling ·
  `Build of product 'CockpitApp' complete!` (8.48s) · 에러 0 ·
  경고 0. **g3 정직**: 재료 옵션은 stub (진짜 도메인별 옵션 =
  domains/** 소싱, 후속) · signal-light 는 verbState 기반일
  뿐 measurement_gate 미바인딩 (θ-2) · 실제 도구 실행 0.
  다음 = κ-4 (chat ↔ verb 연동 / θ-2 실제 실행 경로).
- 2026-05-19 — **phase κ-4 — chat ↔ verb 연동 빌드 green**
  (rfc_012 §5 ③ · D48). ③ "요리 선생님" chat 이 프로젝트의
  7-verb 단계를 인지하도록 연결: 신규 `chatContext()` 가
  활성 프로젝트의 이름·목표·분야·현재 verb(N/7) 를 문자열로
  만들어 `runClaude` 에 주입 — `claude -p` prompt 가 "you are
  요리 선생님 … Project context: …" 로 verb-stage frame 안에서
  답하도록 보강 (read-only 가드 유지 — modify/build/tool 금지).
  verb stepper(◀/▶) 이동 시 `announceVerb` 가 chat 에 교사
  메시지 append ("이제 N단계 — plain(canonical) … <verbHint>")
  — ① recipe rail 과 ③ chat 동기화. `verbHint` = 7 verb 평이
  안내문. 측정: `swift run CockpitApp` 로컬 빌드 — `Build of
  product 'CockpitApp' complete!` (9.21s) · 에러 0 · 경고 0.
  **g3 정직**: chat 은 verb 를 *읽기*만 — 자연어로 "다음 단계"
  말해도 자동 advance 0 (진행은 stepper 명시 조작) · chat
  backend 는 여전히 `claude -p` read-only stub · θ-2 실제
  도구 실행 미착수. 다음 = κ-5 (θ-2 실제 실행 경로 — 측정
  record → ✅; rfc_011 scoped action dispatch).
- 2026-05-19 — **phase κ-5 — θ-2 메커니즘 골격 빌드 green**
  (rfc_011 §6 · D48 · 신규 **D49**). 사용자 게이트 — 3택 중
  "θ-2 메커니즘 골격" 선택 (design.md D49 lock). θ-2 (실제
  실행 경로) 의 골격: ③ chat 하단에 "▶ <verb> 단계 실제로
  돌리기" 액션 버튼 (orange) · `runAction()` 이 현재 verb 를
  action prompt 로 claude CLI 에 dispatch · `actionPrompt`
  (verb) = engine tool / 측정 record 존재 확인 지시 + g3 가드
  ("도구 없으면 정직 보고, backing record 없이 ✅/측정완료
  주장 금지") · `parseRecordIDs` = 출력에서 F1F2 record ID
  best-effort 추출 (rfc_011 §6.3 "output piped + parsed").
  결과 정직 표기: record ID 0 → "⏳ 새 측정 record 없음 —
  측정 없이는 ✅ 안 됨", record 발견 → "📸 새 측정 record …"
  + `ArtifactRegistry` reload. 측정: `swift run CockpitApp`
  로컬 빌드 — `Build of product 'CockpitApp' complete!`
  (1.50s) · 에러 0 · 경고 0. **g3 정직**: demiurge 에 실행할
  engine tool 0개 (Yosys §4 미구현 = hexa-lang; booksim =
  hexa-lang/stdlib) — 누르면 agent 가 "도구 없음" 보고, 측정
  record 0, ✅ 불가. 메커니즘(UI+dispatch+파싱)은 완성 — 도구
  attach 시 코드 변경 없이 측정 가동. claude 는 read-only
  print mode 유지 (scoped tool-permission = 도구 준비 후).
  §4.2 REJECTED 배너는 별도 후속. 다음 = κ-6 (§4.2 REJECTED
  가드 / canvas mode 연결 — 미정, 게이트 필요).
- 2026-05-19 — **phase κ-6 — §4.2 REJECTED 가드 빌드 green**
  (rfc_011 §4.2 · @F f6). 사용자 게이트 — 3택 중 "§4.2
  REJECTED 가드" 선택. chat/action 응답이 측정·parity·흡수를
  backing record 없이 주장하면 UI 가 빨간 REJECTED 배너로
  차단: `ChatMessage.Role` 에 `.rejected` 추가 · `overclaims`
  (static) — claim marker (측정완료/검증됐/parity/29-38/
  GATE_CLOSED/흡수완료 등) 감지 후 `parseRecordIDs` 가 backing
  record ID 0 이면 over-claim 판정 · `flagIfOverclaim` 이
  over-claim reply 직후 `.rejected` 메시지 append (원본 응답은
  그대로 보이되 not-trustworthy 표시) · `rejectionBanner` =
  빨간 octagon + "REJECTED" + 사유. sendChat·runAction 양쪽
  reply 에 적용. 측정: `swift run CockpitApp` 로컬 빌드 —
  `Build of product 'CockpitApp' complete!` (2.61s) · 에러 0 ·
  경고 0. **g3 정직**: 가드는 *휴리스틱* — claim marker 문자열
  매칭이라 표현을 비껴가면 놓칠 수 있음 (LLM-based 판정 = 후속);
  backing 판정도 reply 텍스트의 record ID 유무 기준 (실제
  exports/ gate 교차검증 = canvas mode 연결 후). 그래도 흔한
  거짓 ✅ 는 UI 에서 차단 — g3 를 viewer 너머 *행동*으로.
  다음 = κ-7 (canvas mode 연결 — ② 결과 시각화).
- 2026-05-19 — **phase κ-7 — canvas mode 연결 빌드 green**
  (rfc_011 §7 mode registry). ② work zone 하단을 domain-aware
  결과 시각화로: `ResultTab` enum (result / reference) +
  segmented picker — "결과 보기" = `domainModeView` (domain
  분기) · "참고 자료" = 기존 `referenceBrowser` (D47 reference
  view 유지). `domainModeView` 가 project.domain 으로 분기 —
  `componentModeView` (component → 기존 ι-phase `ComponentView3D`
  RealityKit 3D viewer 연결) · `matterPointerView` (matter →
  D17 포인터 카드 "SSOT=hexa-lang, demiurge=소비자") ·
  `chipModeView` (chip → 측정 record 없으면 ⏳ 안내) ·
  `cohortShallowView` (기타 → domains/<key>.md 있으면
  `MarkdownView`, 없으면 placeholder). 공통 `modePlaceholder`
  헬퍼. 측정: `swift run CockpitApp` 로컬 빌드 — `Build of
  product 'CockpitApp' complete!` (35.06s) · 에러 0 · 경고 0.
  **g3 정직**: chip/cohort mode 는 측정 record 0 이라 ⏳
  placeholder — 실제 record card/latency 차트는 θ-2 측정 후 ·
  3D viewer 는 ι-phase 그대로 (procedural placeholder, 실제
  USDZ = component producer 후). canvas mode 의 *틀*은 완성 —
  domain 별 분기·reference 분리 동작. rfc_012 workbench 의
  주요 표면(①②③④ + θ-2 + REJECTED 가드 + canvas mode) 골격
  완결. 다음 = κ-8 (workbench 마감 디테일 / expert mode 완성도
  — 미정, 게이트).
- 2026-05-19 — **phase κ-8 — workbench UX 마감 빌드 green**
  (rfc_012 §4). 사용자 게이트 — 3택 중 "workbench UX 마감"
  선택. (1) **키보드 단축키** — `+` 새 프로젝트 = ⌘N · verb
  stepper 이전/다음 = ⌘← / ⌘→ (help 텍스트에 단축키 표기).
  (2) **§4 신호등 이모지** — `verbStateEmoji` 추가, plain 모드
  ① recipe rail 의 verb row leading 을 SF Symbol → 이모지
  (✅ 측정됨 / 🔵 지금 / ⏳ 지난 단계·미측정 / ⚪️ 아직);
  expert 모드는 SF Symbol + 색 tint 유지. §4 의 "honesty =
  signal light" 를 plain 표면에 직접 노출. 측정: `swift run
  CockpitApp` 로컬 빌드 — `Build of product 'CockpitApp'
  complete!` (4.40s) · 에러 0 · 경고 0. **g3 정직**: 이모지는
  verbState (포인터 기반) 매핑일 뿐 — ✅ 는 doneVerbs (측정
  record) 일 때만, 단계 stepper 로는 ⏳ 까지만 (κ-3 g3 규칙
  그대로). rfc_012 workbench = ①②③④ + θ-2 + REJECTED 가드 +
  canvas mode + UX 마감 까지 골격 완결. 다음 = 문서 정합
  (rfc_012 status / AGENTS.tape @N / GOAL.md 현재위치) 또는
  CLI ↔ Project 정합 — 미정.
- 2026-05-19 — **SSOT 문서 정합 — κ-1~κ-8 반영** (코드 0, reconcile
  only). rfc_012 status `DISCUSSION COMPLETE` → **IMPLEMENTED** ·
  §9 "discussion complete, not yet locked" → "implemented" (D42–D49
  lock + governance + κ-1..κ-8 measured-green + g3 정직 갭 명시).
  AGENTS.tape `@N ssot.decisions` D1..D41 → **D1..D49** (D49 요지
  추가, rfc_012 = "IMPLEMENTED as κ-1..κ-8" 표기) · `arch_why` 에
  D23..D49 + κ phase 포인터. GOAL.md "현재 정직한 위치" post-κ8
  갱신: 머리줄 "코드·앱 0" → "macOS cockpit workbench 골격 live
  (κ-1~κ-8)" · 새 ✅ workbench 항목 · RFC 9건 → 12건 · D1–D22 →
  D1–D49 · 🕳️ 갭 "코드·앱 0" → "**engine tool 0**" (핵심 갭
  재정의 — θ-2 가 돌릴 실제 측정 도구 없음 → 측정 record 0 ·
  ✅ verb 0) · cross-link + Log 갱신. **g3 정직**: 새 결정 0 ·
  측정 사실만 반영 — north-star 불변, position-section 정합.
  cockpit 코드 무변경이라 재설치 불요. 다음 = CLI ↔ Project
  정합 또는 신규 작업 — 미정.
- 2026-05-19 — **phase κ-9 — SSOT single-source 규율** (D50 ·
  사용자 지시 "update 마다 양쪽 업데이트 하지 않게 / CLI, cockpit
  멱등성 보장"). 진단: D-번호가 9개 파일·RFC건수 3곳·cockpit
  phase 3곳에 중복 → reconcile 1회에 여러 파일 동시 갱신 부담.
  **(거버넌스)** AGENTS.tape `@D g_ssot_single_source` 신설 —
  문서: 결정 SSOT=design.md·진행 SSOT=PLAN.md, 파생 문서는
  D-range·건수·phase 복제 금지·포인터만; 코드: cockpit·CLI 공통
  도메인/verb/record 분기는 DemiurgeCore 동일 함수 (멱등성).
  **(문서 정리)** `@N` decisions 의 D15..D49 요지 전체 사본 →
  포인터 한 줄 · GOAL.md "현재 위치" 의 수치 → design.md/PLAN.md
  위임. **(코드 정리)** 신규 `DemiurgeCore/Models/Domain.swift`
  — `CanvasMode` · `Domain` · `DomainCatalog` (도메인 키·label·
  canvasMode·키워드 단일 카탈로그); `Project.swift` 의
  `DomainInference` 제거 → `DomainCatalog.infer` 통합 · `Verb.hint`
  추가. cockpit 의 `domainLabel`(NewProjectSheet)·`verbHint`
  (CockpitApp)·`domainModeView` 문자열 `switch` 제거 →
  `DomainCatalog`/`Verb.hint`/`CanvasMode` 공용 호출. CLI 가
  나중에 domain/verb 기능 붙일 때 동일 함수 사용 → CLI↔cockpit
  멱등. design.md **D50** lock. 측정: `swift run CockpitApp`
  로컬 빌드 — `Build of product 'CockpitApp' complete!` (24.56s) ·
  에러 0 · 경고 0. **g3 정직**: 중복 제거·governance 만 — 새
  기능 0, 측정 record 0 그대로. CLI 는 아직 viewer 명령만 (domain/
  verb 기능 미착수 — 붙을 때 공용 함수 적용은 governance 가 보장).
- 2026-05-19 — **phase κ-10 — CLI ↔ Project 정합 빌드 green**
  (D34 AI-agent surface · g_ssot_single_source 실증). DemiurgeCLI
  에 project 명령 2개 추가: `list-projects` (ProjectStore.loadAll
  → 이름·domain label·현재 verb) · `show-project <name>` (manifest
  상세 + 7-verb 진행 [x]/[>]/[~]/[ ]). **핵심**: CLI 가 cockpit
  과 **동일한** DemiurgeCore 함수 사용 — `ProjectStore` (같은 App
  Support manifest, D45) · `DomainCatalog.domain(for:).label/
  canvasMode` · `Verb` · `Project.state(of:)`. 각자 switch 0 —
  κ-9 의 g_ssot_single_source 가 코드에서 실증됨. 측정: `swift
  run DemiurgeCLI` 빌드 green (2.28s, 에러 0) + round-trip 검증 —
  임시 manifest (chip·currentVerb=2·doneVerbs=[0,1]) 작성 후
  `list-projects` → "테스트 칩 — 칩 설계 · 3/7 설계", `show-project`
  → 7-verb 진행 1·2 [x]·3 [>]·4-7 [ ] 정확 출력, 임시 manifest
  삭제. cockpit·CLI 가 같은 manifest 를 동일 해석 = 멱등성 확인.
  **g3 정직**: CLI 는 read-only viewer 유지 — project 생성/수정은
  cockpit 만 (CLI 는 list/show 만); θ 액션 subcommand 는 여전히
  미착수. cockpit 코드(CockpitApp/DemiurgeCore) 무변경 → .app
  재설치 불요 (CLI 는 `demiurge cli` shim = repo 에서 swift run).
  다음 = 신규 작업 — 미정.
- 2026-05-19 — **NEXT_SESSIONS.md 갱신 — κ-1~κ-10 반영** (코드 0,
  핸드오프 문서 reconcile). NEXT_SESSIONS.md 가 viewer cockpit
  시절(P-⑤/⑥)에 멈춰 workbench 10 phase 미반영이었음 → 갱신:
  헤더 커밋/상태 `c1805fe`+ · P-⑤ "✅ DONE" 마크 (viewer +
  workbench κ-1~κ-10 빌드 완료, 원본 프롬프트는 history 로 보존) ·
  P-⑥ NET 에 workbench 전환 + θ-2 골격(κ-5) 반영 · **P-⑦ 신설**
  — demiurge 단독 workbench 후속 핸드오프 (재료선반 실데이터 ·
  REJECTED 가드 강화 · expert mode 깊이 · phase ζ; cold-readable
  프롬프트 포함) · Cross-cutting 의 D-range 박힘 → 포인터화
  (g_ssot_single_source). **g3 정직**: 문서 reconcile 만 — 새
  결정·코드·측정 0. 다음 추천 = #1 재료 선반 실데이터 (κ-3 stub →
  domains/** 소싱).
- 2026-05-19 — **phase κ-11 — 재료 선반 실데이터** (D51 · 사용자
  게이트 "domains/ 에 옵션 섹션 신설"). κ-3 의 IngredientShelf
  하드코딩 stub → domains/*.md §6 파싱. **(domains)** 14 도메인
  맵 전부에 `## 6. Design options (workbench shelf)` 신설 —
  verb 별 plain 설계 옵션 (`- <verb>: <group> = a / b / c`,
  §1 deliverable 기반). **(DemiurgeCore)** `DomainCatalog.all`
  7 → 16 도메인 (domains/ 14 + chip + matter; label·canvasMode·
  키워드) — DomainInference 가 14 도메인 전부 추론 가능 ·
  `IngredientShelf` = §6 파서로 교체 (`section6Lines` +
  verb-prefix 매칭 + `;`/`=`/`/` 분리). **(CLI)** `list-shelf
  <domain>` 추가 — cockpit ②work zone 과 동일 `IngredientShelf`
  공유 (g_ssot_single_source 실증). 측정: `swift run CockpitApp`
  빌드 green (7.18s, 에러 0) + CLI round-trip 검증 — `list-shelf
  energy` → 구조(에너지원)·설계(배터리화학), `fusion` → 자석·
  블랭킷 `;` 다중그룹 정확, `space` → 명세 verb 매칭, `chip` →
  "no §6" 정직 출력. **g3 정직**: chip/matter 는 domain 맵이
  없어 빈 선반 (위조 0); §6 옵션은 도메인 deliverable 기반
  합리적 후보지 측정값 아님. 다음 추천 = #2 REJECTED 가드 강화
  (κ-6 문자열 휴리스틱 → 정밀화).
- 2026-05-19 — **phase κ-12 — REJECTED 가드 강화** (rfc_011 §4.2 ·
  @F f6). κ-6 의 `overclaims()` 는 (1) claim marker 문자열 매칭 +
  (2) backing = reply 텍스트에 record ID 패턴 유무 — 둘 다 약함
  (가짜 ID 도 통과). 강화: `overclaims` = `mentionsClaim` +
  `!hasMeasuredBacking` 으로 분리. `mentionsClaim` — claim marker
  16 → 23개 확대 (측정 결과·검증되었·흡수했·재현했·통과했·
  gate_b_pinned 등). **핵심** `hasMeasuredBacking` — backing 판정을
  reply 텍스트가 아니라 *실제 exports/ record* 로: `ArtifactRegistry.
  loadF1F2` 의 모든 record 를 `RecordLoader` 로 로드 → measurement_
  gate 가 measured 상태(GATE_B_PINNED_MET / GATE_CLOSED_MEASURED)
  이고 그 record 의 정확한 `recordId` 를 reply 가 언급할 때만
  backing 인정. 가짜 ID·미측정(GATE_OPEN) record ID 는 불통과.
  측정: `swift run CockpitApp` 빌드 green (1.98s, 에러 0). **g3
  정직**: claim marker 는 여전히 휴리스틱 (놓친 marker = 비-claim
  reply 미플래그일 뿐, unbacked claim 통과는 backing 체크가 독립
  차단) — 완전 LLM 판정은 후속. 그러나 backing 은 이제 실측
  gate 기반 — '거짓 ✅' 의 핵심 구멍(가짜 record ID)이 막힘.
  다음 추천 = #3 expert mode 깊이 (record/provenance §4 plain↔raw).
- 2026-05-19 — **phase κ-13 — expert mode 깊이 + 아이콘 버그 fix**
  (rfc_012 §4 · D46). **(버그 fix)** 사용자 스크린샷 — κ-8 에서 ①
  recipe rail verb row 의 plain 모드 leading 을 이모지(✅/🔵/⏳/
  ⚪️)로 했는데, macOS 에서 `⚪️`(WHITE CIRCLE 이모지)가 거대한
  회색 원으로 깨져 렌더. verbRow leading 을 SF Symbol 단일화
  (expert/plain 공통, `verbRowSymbol` + `progressTint` 색 =
  §4 신호등) · `verbStateEmoji` 삭제. **(#3 expert 깊이)** §4
  plain↔raw 토글을 record/provenance 뷰까지 확장: `MeasurementGate`
  에 `plainLabel`(아직 측정 안 됨 / 일부만 측정됨 / 측정으로
  확인됨 / 측정 실패) + `plainGlyph`(⏳🔶✅❌) 추가 (DemiurgeCore
  — cockpit·CLI 공유) · `ProvenanceBanner` 에 `expertMode` —
  expert = GATE_* 원문 + engine/commit/atlas verbatim, plain =
  신호등 문구 + "검증 완료 / 참고용·검증 전" + "이 결과를 믿어도
  되는 이유" (raw 필드는 plain 에서 숨김) · `RecordView` 가
  expertMode 를 ProvenanceBanner 로 전달. 측정: `swift run
  CockpitApp` 빌드 green (5.17s, 에러 0). **g3 정직**: 토글은
  *표시 면*만 바꿈 — gate 상태 자체는 불변 (plain "✅" 도
  GATE_CLOSED_MEASURED 일 때만; 정직성 경계 무손상). 다음 추천 =
  #4 phase ζ (필터 + dependency graph).
- 2026-05-19 — **phase κ-14 — phase ζ record 필터** (rfc_010 ζ
  viewer-잔재의 workbench-맞춤 범위; 사용자 게이트 — 3택 중
  "record 필터만" 선택, dependency graph 는 workbench 가치 불명확
  으로 제외). ② work zone "참고 자료" referenceBrowser 에:
  (1) 상단 `Toggle("측정된 것만" / "measured only")` —
  recordFilterMeasuredOnly state · (2) gate dot 줄 — 각 record
  앞에 gate 색 SF Symbol (hourglass orange · diamond blue ·
  checkmark.seal green · xmark.octagon red) · (3) Section 제목
  "참고 자료 (N / total)" — 필터링 시 보이는/전체 카운트 ·
  (4) gate 캐시 — onAppear 에 `loadRecordGates()` 가 모든 F1F2
  record 를 1회 로드해 `[ArtifactID: MeasurementGate]` dict 채움
  (50개 record 매 렌더 reload 회피). 필터 = gate ∈
  {bPinnedMet, closedMeasured} (rfc_011 §4.2). 측정: `swift run
  CockpitApp` 빌드 green (3.84s, 에러 0). **g3 정직**: gate
  unknown record 는 캐시에 없어 필터 시 숨김 — 가짜 통과 0.
  dependency graph 는 별도 (사용자 게이트 — workbench 가치 재고
  필요). 다음 추천 = #5 CLI θ 액션 subcommand 골격.
- 2026-05-19 — **phase κ-15 — CLI θ 액션 + ActionDispatch 공유**
  (rfc_011 §6 · D49 · g_ssot_single_source). cockpit κ-5 의 θ-2
  dispatch (runClaude/actionPrompt/parseRecordIDs) 가 cockpit
  static func 였음 — CLI 가 같은 액션 노출하려면 복제 위험.
  **(공유 dispatch)** 신규 `DemiurgeCore/Loaders/ActionDispatch.swift` —
  `actionPrompt(verb:)` + `parseRecordIDs(_:)` + 동기 `askClaude
  (prompt:context:)` (Process subprocess) 를 DemiurgeCore 에 집중.
  cockpit·CLI 둘 다 호출 (멱등 보장). **(cockpit)** static
  runClaude/actionPrompt/parseRecordIDs 제거 → ActionDispatch
  호출. UI 비차단 위해 instance `ask(_:_:)` async wrapper —
  Task.detached 로 askClaude 감쌈. sendChat/runAction 둘 다 `ask`
  사용. **(CLI)** `demiurge cli action <verb>` 신설 — verb 인자
  파싱 (specify/structure/design/analyze/synthesize|synth/verify|
  measure/handoff + 한글) → ActionDispatch.actionPrompt →
  askClaude → 출력 + parseRecordIDs (record 0 → "⏳ no measured
  record" 정직 출력). 측정: `swift run CockpitApp` 빌드 green
  (8.75s, 에러 0) · `swift run DemiurgeCLI action invalid` →
  unknown verb stderr (parse OK). **g3 정직**: cockpit·CLI 가
  byte-identical action 발사 — engine tool 0 이라 누구 누르든
  agent 가 "도구 없음" 보고 동일 (멱등 실증). 실제 측정 0.
  workbench 후속 (#1~#5) 모두 닫힘 — 다음은 hexa-lang/측정
  세션 (cross-repo, P-②③/P-④) 또는 신규 작업.
- 2026-05-19 — **phase κ-16 — "all" 묶음: 문서 정합 + sibling-repo
  인식 + P-⑧ 정의** (사용자 지시 "두 방향 함께 → all" — A+B+C+D
  +E+F 한 묶음). **(A 문서 정합)** NEXT_SESSIONS P-⑦ Open
  follow-ups → "closed (κ-11..κ-16)" 마크 (✅ 5개: 재료선반·
  REJECTED·expert·ζ 필터·CLI θ action) + sibling-repo 인식
  추가. **(B sibling 인식)** 신규 `Domain.siblingRepoPath`
  ("~/core/hexa-<id>") + `siblingRepoExists` (FileManager 체크) —
  DemiurgeCore 의 Domain struct. NewProjectSheet confirm step 에
  sibling banner ("✓ 존재" 또는 "(없음)"). CLI `show-project`
  출력에 `sibling_repo:` 줄 추가 — cockpit·CLI 둘 다 노출
  (g_ssot_single_source). **(C P-⑧ 정의)** NEXT_SESSIONS P-⑧
  TBD → working definition: "기본 라이브러리 = 각 hexa-* sibling
  repo 의 설계를 demiurge 7-verb 로 측정 → exports/<domain>/
  baseline/ 모음". 사용자 확인/조정 가능 (provisional). **(D/E/F)**
  cross-repo 핸드오프 (P-②③ Yosys+push · P-④ chip §B 측정 ·
  ι-2 USDZ) — 변동 없음, 다른 세션 필요. NEXT_SESSIONS Log
  점검만. 측정: `swift run CockpitApp` 빌드 green (13.13s, 에러
  0). **g3 정직**: sibling-repo "✓" 는 디렉토리 존재만 — 그
  안 코드의 측정/검증 상태와 무관. workbench 가 sibling 을
  *알기*만 함, *호출* 0 (호출은 cross-repo 세션 P-⑧). 자동
  3D 애니메이션 = 여전히 NO (D35 명시); ι-2 (실 USDZ) 미완 —
  component producer 후. 다음 = cross-repo 세션 (P-②③/P-④/
  P-⑧) 또는 신규 작업.
- 2026-05-19 — **phase κ-17 — sibling-repo 인식 철회** (사용자 정정
  "~/core/hexa-component 가 아니야 hexa-lang 이 모두 stdlib /
  hexa-lang/component 나"). κ-16 의 B 항목(sibling-repo 인식)이
  사실관계 오류였음 — `~/core/hexa-<id>` 디렉토리가 실제 존재하나
  SSOT 는 hexa-lang 단일 repo 안 (booksim/matter 패턴; component 도
  `hexa-lang/component/`). **(코드 철회)** `Domain.siblingRepoPath`
  / `siblingRepoExists` 제거 (DemiurgeCore) · NewProjectSheet 의
  sibling banner 제거 · CLI `show-project` 의 `sibling_repo:` 줄
  제거. **(문서 정정)** AGENTS.tape `g_stdlib_ownership.
  user_directive` 에 정정 라인 추가 ("sibling repo 패턴 폐기; 모든
  도메인 stdlib 는 hexa-lang 안"). NEXT_SESSIONS Tracks B 항목
  *withdrawn* 마크, F 항목 경로 `~/core/hexa-component` →
  `~/core/hexa-lang/component/`, P-⑨ 본문 경로 정정. 측정:
  `swift run CockpitApp` 빌드 green (19.11s, 에러 0). **g3 정직**:
  κ-16 의 sibling 인식은 *measured 도 cited 도 아닌 가정* 이었음 —
  사용자 정정으로 즉시 철회. workbench 가 "잘못된 위치 표시"보다
  "표시 안 함" 이 정직.
- 2026-05-19 — **phase κ-18 — P-⑨ 정교화 + README 정합** (G + P-⑨
  정교화 묶음). **(P-⑨)** NEXT_SESSIONS P-⑨ 의 Tooling step 정정:
  KiCad StepUp/OpenSCAD → **FreeCAD + gmsh + USDPython** (정확한
  domains/component.md §5 cited), 흡수 패턴 = **D18 bounded-
  subprocess** (Yosys/ABC 선례; FreeCAD/gmsh clean-room 재도출은
  비현실), `hexa-lang/component/` 는 thin hexa-native wrapper +
  provenance/gate headers. **(G — README)** 갱신: Status 머리줄
  "design only NOT built" → "workbench live · engine tool 0 이
  honest gap"; D1–D22 / RFC 9건 등 카운트 제거 (PLAN/design.md
  SSOT, g_ssot_single_source); Files 섹션에 cockpit/ · rfc_011/012
  · NEXT_SESSIONS 추가, AGENTS.tape governance 목록 갱신; Related
  repos 정정 — hexa-lang sole SSOT 명시 + hexa-* sibling NOT
  SSOT (κ-17 정정 반영); Current state 재구성 — Design-complete /
  Built / Not done 3 묶음, "engine tool 0" 가 핵심 갭임 명시.
  코드 무변경 → install 불요. **g3 정직**: 카테고리 서술만; 모든
  수치 (D-번호, RFC 건수, κ phase) 는 design.md / PLAN.md SSOT 포인터.
- 2026-05-19 — **phase κ-19 — CHARTER + HANDOFF 정합** (H 갈래).
  **(CHARTER)** Current state 재작성 — "design-complete · NOT
  built" → "design-complete · workbench live · NOT wired/absorbed/
  measured-records-zero"; RFC 카운트 / "9 RFCs" / "D1–D22" 제거 →
  카테고리 서술만 (g_ssot_single_source). Related repos 정정 —
  hexa-lang sole SSOT 명시 + hexa-* sibling NOT SSOT (κ-17 반영) ·
  Swift cockpit "build out-of-scope" → "built + installed". **(HANDOFF)**
  헤더 "Reconciled to D1–D22" → "Reconciled to workbench-live" + SSOT
  포인터 한 줄. §9 Current state 재구성 — Design-complete / Built /
  Honest core gap "engine tool 0" 3 묶음, 카운트 제거. §10 RESUME
  copy-paste 블록 갱신 — workbench live · engine tool 0 · 다음 =
  NEXT_SESSIONS Tracks matrix 참조 (D+E hexa-lang / F component
  producer). SSOT note 갱신 — design.md = 결정 SSOT, PLAN.md =
  κ-phase SSOT, NEXT_SESSIONS = 핸드오프 SSOT. **g3 정직**: 카테고리
  서술만 — D-범위·RFC건수·phase 수치는 design.md/PLAN.md SSOT 포인터.
  코드 무변경 → install 불요.
- 2026-05-19 — **phase κ-20/κ-21 — parallel sub-agents (L + K)**
  (사용자 "all sub agent go" — 4 worktree-isolated agent). 결과:
  **κ-20 (L · ✅)** — `track-L-kappa-20-agents-index` commit
  `e4fc7a9`: AGENTS.tape 머리에 `## INDEX` 큐레이션 포인터 테이블
  (16 entries — @D 13 file-order + @F + @N 2, 각 1줄 gloss +
  decision ref). 룰 본문 복제 0 (g_ssot_single_source 정합 — 파생
  포인터 테이블 명시). **κ-21 (K · ✅)** — ingredient shelf
  multi-pick: §6 `[multi]` 마커 (group title 내, `=` 앞) 파싱 →
  `IngredientGroup.multiSelect` (default false, 백워드 호환) ·
  cockpit `shelfPicks` `[String:String]` → `[String:Set<String>]`
  (single ≤1, multi toggle) · `addToPotFromShelf` multi 그룹 ` · `
  join · CLI `list-shelf` multi 태그. 측정: `swift run CockpitApp`
  빌드 green (17.97s, 에러 0) · `list-shelf energy` 백워드 호환
  확인 (§6 에 `[multi]` 미추가 — g3, syntax 만 enable). **(I,
  J · ⏳ 보류)** — I (chat history 영속화) · J (CLI list-gates/
  verify/gate-summary) 는 sub-agent usage limit (10pm KST reset)
  으로 0 tool_use 미착수. 다음 세션 pickup. **g3 정직**: L/K
  measured-green, I/J 는 *시작 안 함* (부분작업 0 — 위조 0).
- 2026-05-19 — **phase κ-22/κ-23 — I (chat 영속화) + J (CLI gate
  명령)** (sub-agent usage limit → main session 직접 순차 구현).
  **κ-22 (I)** — chat history 영속화: `ChatMessage` 를 cockpit
  struct → DemiurgeCore (Codable·Equatable·Sendable, cockpit·
  ChatStore 공유, g_ssot_single_source) · 신규 `DemiurgeCore/
  Loaders/ChatStore.swift` (save/load, `~/Library/Application
  Support/lab.dancin.demiurge/projects/<uuid>/chat.json`, ProjectStore
  패턴) · CockpitApp: onAppear/onChange(activeProjectID) chat
  load+reflag · onChange(chatMessages) persist · `reflagChat()`
  (load 후 REJECTED 배너 live 가드로 재생성) · rejection 텍스트
  static 상수화. **g3 정직**: `.rejected` 배너는 *persist 안 함*
  — ChatStore 가 save 시 drop, load 시 over-claim 가드가 재생성
  (정직 마커는 항상 live 가드 기준, stale 디스크 사본 아님).
  **κ-23 (J)** — CLI gate 명령 3: `MeasurementGate` +CaseIterable ·
  `list-gates` (gate별 record 그룹) · `gate-summary` (gate +
  absorbed 총계 %) · `verify <path|id>` (provenance 4필드 non-empty
  + verdict claim↔gate 일관성, exit 0/1) — 전부 ArtifactRegistry/
  RecordLoader/F1F2Record 공용 (CLI↔cockpit 멱등). 측정: `swift
  run CockpitApp` 빌드 green (24.36s) · `gate-summary` → **48
  records 전부 GATE_OPEN · absorbed=false** (engine tool 0 의
  실측 정직 노출) · `verify <record>` → 6 checks [OK] exit 0.
  P-⑦ #1..#5 + I + J + L + K 모두 closed. 다음 = cross-repo
  세션 (D+E hexa-lang / F component) 또는 신규.
- 2026-05-19 — **D handoff 부분 완료 확인** (사용자: "origin/
  rfc043-hexa-torch 에 handoff 요청한거 완료됨"; g3 — 측정 확인
  후 갱신). 실측: ① **`d5a63a82` (booksim absorb) = origin/
  rfc043-hexa-torch 에 PUSHED** — `git branch -r --contains
  d5a63a82` 확인. "미push" 갭 **해소**. ② **Yosys §4 모듈 =
  여전히 stub** — `~/core/hexa-lang/stdlib/yosys/` 에
  `*.hexa.stub` 7개만, 실제 `.hexa` 구현 0. rfc_006 §4 미구현
  유지. ③ chip §B 측정 (E) = 별개, 변동 없음 (미측정,
  GATE_OPEN). booksim 은 `.hexa` 실재 (anynet/iq_router/leighton
  등). 갱신 대상: AGENTS.tape `g_stdlib_ownership.violation_
  resolved` (unpushed→pushed) · NEXT_SESSIONS Tracks D / P-②③
  (① done 마크, ② stub→impl 잔여) · HANDOFF §9 + GOAL 🕳️ (미push
  줄 → push 완료 + Yosys stub). **g3 정직**: 사용자 "완료됨"
  은 *push* 완료 — Yosys impl 은 stub 이라 "absorbed" 주장 불가;
  rfc_006 §5 area-oracle gate 미측정 그대로.
- 2026-05-19 — **phase κ-24 — booksim dispatcher 구현 (track 2,
  cross-repo)** (사용자 "여기서 모두 진행 / 1,2 both"; demiurge
  세션이 hexa-lang 직접 작업 — 사용자 오버라이드). 환경 진단
  먼저 (g3): yosys✅·hexa✅·내장abc✅ / abc바이너리·freecad·
  openscad·gmsh·SKY130.lib ❌ / pool 자동 routing 이 yosys 명령
  엔 안 걸림 (host=Mac). 진짜 막힘 = 측정 도구가 아니라 *측정
  대상 미구현* (Yosys §4 stub · booksim dispatcher .stub).
  oracle 은 comb 가 이미 측정 (d4=61,762.99·d6=93,608.53 µm²).
  **착수: 2 (booksim dispatcher)** — `hexa-lang/stdlib/booksim/
  booksim.hexa.stub` → `booksim.hexa` (hexa-lang commit
  `f297978c`, branch rfc043-hexa-torch). CLI surface only (no
  BookSim2 재도출 — rfc_001 §7.2): 라우팅 + help + version +
  `topology`→anynet_load wire. sweep/wire-delay/oracle = 정직
  exit 91 (TBD body, silent-skip 아님 @F f4) · measure = exit
  90 (rfc_001 §8 gate 미충족 — absorbed 주장 0, g3). hexa enum
  버그(rfc_003 finding) 회피 — anynet 만 import (sweep/leighton
  등은 phase 별 wire). 측정: `hexa run stdlib/booksim/
  booksim.hexa` → **dispatcher selftest 7/7 PASS** exit 0.
  **g3 정직**: dispatcher *라우팅* measured-green 일 뿐 —
  "booksim absorbed" 아님, F1F2 record 0, rfc_001 §8 gate
  미충족 그대로. 다음 = track 1 (rfc_006 §4 Yosys hexa 모듈 —
  yosys dispatcher 동형 패턴부터, enum 회피 int/struct).
- 2026-05-19 — **phase κ-25 — yosys dispatcher 구현 (track 1,
  cross-repo)** (booksim 동형). `hexa-lang/stdlib/yosys/
  yosys.hexa.stub` → `yosys.hexa` (hexa-lang commit `522c8192`,
  origin/rfc043-hexa-torch push ✅). CLEAN-ROOM CLI surface only
  (Yosys kernel/yosys.cc + script.cc 공개면, ISC, no copy;
  rfc_048 raw-91 idiom): 라우팅 + help + version + selftest
  (dispatcher-routing scope) · read-verilog/write-verilog =
  정직 exit 91 (모듈 body TBD, silent-skip 아님 @F f4) · synth
  = exit 90 (rfc_006 §5 SKY130 area-oracle d4≈61,763·d6≈93,609
  µm²·1.516× OPEN — hexa-native flow 미재현, absorbed 금지 g3).
  모듈 미import (read_verilog/passes/abc_map/write_verilog
  skeleton — enum 버그 회피). 측정: `hexa run stdlib/yosys/
  yosys.hexa` → **dispatcher selftest 8/8 PASS** exit 0
  (version/help/no-sub/unknown=1/selftest=0/synth=90/read=91/
  write=91). **g3 정직**: dispatcher *라우팅* measured-green —
  "Yosys absorbed" 아님, netlist 0, rfc_006 §5 gate OPEN 그대로.
  D19 §4 모듈 body (read_verilog/passes/abc_map/write_verilog) =
  다음 (각 enum 회피 int/struct · §5 gate 까지 거대). track 1·2
  의 *dispatcher 층* 둘 다 measured-green; 측정(absorbed) 은
  모듈 body 들 + comb oracle 대조가 남음.
- 2026-05-19 — **phase κ-26 — B1 enum 버그 = upstream inbox patch
  (우회 아님)** (사용자 "upstream fix / direct fix / inbox 에
  넣어줘"). 진단: `RegionShape.K_BY_K` 등 enum-variant 접근이
  hexa codegen 의 generic Field-arm (`codegen_c2.hexa:3845`) 로
  떨어져 `hexa_map_get_ic(RegionShape,…)` emit → C "undeclared
  identifier" (올바름 = `RegionShape_K_BY_K`, gen2_enum_decl:5829
  의 #define). rfc_003 "enum-equality broken" 의 동일 root cause.
  이게 booksim sweep/leighton/traffic 컴파일 차단 → rfc_001 §8
  chip §B 측정 진짜 blocker (도구·oracle 문제 아님 — comb oracle
  이미 측정됨). **처리**: int/struct 우회 대신 hexa-lang
  `inbox/patches/enum-variant-miscodegen-as-field-codegen-c2.md`
  에 정밀 진단 + 제안 diff (Field-arm enum-name 가드 / 또는
  parser EnumPath 분류) 기록 — hexa-lang governance (id002:
  consumer→inbox patch, never inline; CLAUDE.md: 컴파일러 변경
  PR-only) 정합. codegen_c2.hexa 는 병렬 hexa-lang 세션이 분당
  commit 중이라 inline 동시편집 = 충돌·governance 위반 → inbox
  patch 가 정직한 "direct upstream fix" 형태. **g3 정직**:
  enum 버그 미해결 — booksim/Yosys 모듈 body 의 enum-bearing
  부분은 이 patch 적용 전까지 막힘. demiurge 측 코드 0 추가,
  진단·핸드오프만. 다음 = (hexa-lang 세션이) patch 적용 →
  sweep/leighton 컴파일 → booksim cmd_sweep/measure (B2) ·
  rfc_006 §4 모듈 enum 자유.
- 2026-05-19 — **verify (g3): 사용자 "inbox 2건 resolved" ≠ enum
  patch**. 사용자 소식 후 실측: `hexa run stdlib/booksim/
  leighton.hexa` → 여전히 `error: use of undeclared identifier
  'RegionShape'` (C:200 == RegionShape.HEX_AXIAL_R · C:337
  RegionShape.K_BY_K), clang fail exit 1. sweep 동일. inbox
  patch `enum-variant-access-miscodegen-as-field-codegen-c2.md`
  원본 그대로 (resolved 주석 0 — 미적용). resolved 2건은
  inbox/patches/ 의 60+ 중 *다른* 항목. enum codegen blocker
  미해결 — track 1/2 enum-bearing 모듈 여전히 blocked,
  dispatcher 층(booksim 7/7·yosys 8/8)이 정직한 현 위치.
  ("d5a63a82 완료" 때와 동일 패턴 — 낙관 보고를 실측 정정,
  거짓 ✅ 금지.) demiurge 측 추가 작업 0; hexa-lang 컴파일러
  patch 대기 (inbox 큐 등록 완료).
- 2026-05-19 — **enum blocker RESOLVED (병렬 세션 착지) — 종결,
  belt-and-suspenders 재측정 안 함** (사용자 공유). hexa-lang
  rfc043-hexa-torch HEAD `70c7ab9d fix(codegen_c2): enum-variant
  access emits #define, not field-access` — 설계가 제 제안
  Shape-A 와 동일(`_is_enum_name` + Field-arm guard +
  `<Enum>_<VARIANT>` #define). inbox patch status = `resolved-ssot`
  (tracked·clean). 측정 입증: 병렬 세션 `stdlib/booksim/
  leighton.hexa` 런타임 **10/10 PASS** (d4/d6 oracle) +
  enum_smoke BEFORE(undeclared ×3)→AFTER(rc 0). **g3 정합**:
  제 직전 로컬 실측("leighton 실패")은 *배포 bootstrap binary
  stale* (source fix 이전) — patch 의 `verify-PENDING (stale
  binary, promote out-of-scope)` 와 정확히 일치; 병렬 세션은
  재빌드 드라이버로 10/10 → 두 관측이 서로 확증 (source
  resolved · local binary promote 대기, 모순 아님). **재측정
  안 함**: 공유 dir regen = shared-branch hazard + 이미 10/10
  입증된 것의 3번째 중복 (방금 memory 에 남긴 중복-작업
  안티패턴). enum 전제 닫힘 → demiurge chip §B 측정 경로의
  enum blocker 해제. 단 booksim `cmd_measure` body (F1F2
  producer, rfc_001 §8) 는 여전히 별개 미구현(gate 90) —
  "absorbed/chip §B closed" 아님; enum 해제로 *B2(booksim
  sweep/measure body)가 비로소 가능*해진 것. demiurge 코드
  0 추가 — 확인·기록만.
- 2026-05-19 — **phase κ-28 — 3D animation closure + test 창**
  (사용자 b: "3D animation closure 가 목표 / test swift 창 필요";
  demiurge-internal — 이 환경 measured-green 가능, a 와 달리
  도구·binary 의존 0). **(애니메이션)** `ComponentView3D` —
  `ExplodedStackView` 에 `explode∈[0,1]` 파라미터 + Coordinator
  가 layer ModelEntity 추적, `updateNSView` 가 각 layer
  `position.y = baseY * explode`. `ComponentView3D` body 를
  `TimelineView(.animation)` 으로 구동 — `explode = 0.55 +
  0.45·sin(t·0.9)` (분해⇄조립 breathe, ≈7s) + `yaw + t·0.25`
  (auto-rotate); mouse-drag 는 그 위 manual offset (D35 rotate
  경로 유지, "NO auto-animation" 절은 본 데모로 supersede).
  **(test 창)** `CockpitApp @main` 에 env-gate —
  `DEMIURGE_TEST_3D=1 swift run CockpitApp` → WorkbenchView
  대신 ComponentView3D 단독 WindowGroup (별도 executable target
  재구성 0; D26 canonical SwiftUI). 측정: `DEMIURGE_TEST_3D=1
  swift run CockpitApp` 빌드 green (5.98s, 에러 0) — 컴파일·
  실행 OK. **g3 정직**: 빌드 green = *컴파일* measured;
  애니메이션 *시각 동작* 은 GUI 창 확인 필요 (내가 화면 못 봄
  — UI 는 빌드≠시각검증, 정직 명시). geometry 는 여전히
  PLACEHOLDER (procedural 5-layer, 실 USDZ 아님 — ι-2 별개
  gate, "component absorbed/measured" 주장 0). banner·헤더
  주석 갱신. 다음 = install 후 사용자가 3D 창 시각 확인 ·
  또는 신규.
- 2026-05-19 — **phase κ-28 fix — 3D 자유 회전** (사용자 시각
  피드백: "위아래로만 360 움직이고 모든 방향 막힘"). 원인:
  `ExplodedStackView(yaw: yaw + t·0.25)` — drag 중에도 auto-
  rotate(t·0.25)가 yaw 에 계속 더해져 좌우 drag 가 자동회전에
  묻힘 (pitch 는 auto 무관이라 위아래만 먹힘). fix: `@State
  isDragging` — `yaw: isDragging ? yaw : yaw + t·0.25` (drag
  시 순수 자유 회전 — yaw 좌우 + pitch 위아래 양축, idle 시
  auto-rotate 재개). 측정: `swift run CockpitApp` 빌드 green
  (11.56s, 에러 0). g3: 빌드=컴파일 measured; 자유회전 시각
  동작은 GUI 재확인 필요.
- 2026-05-19 — **verify (g3): "demiurge end-to-end GREEN" ≠ 실측**.
  사용자 소식 "stale-binary RESOLVED · demiurge end-to-end GREEN ·
  booksim 3모듈 promoted driver 측정 PASS (leighton d4/d6 ·
  sweep B_obs≥B_bound · traffic tornado)". 실측 후 정정 (4번째
  낙관-보고↔실측 정정 — d5a63a82 / enum "2건" / leighton "10/10"
  에 이어): ① demiurge `exports/` = `gate-summary` 48 records
  전부 GATE_OPEN · absorbed=false, 변동 0 — 새 측정 F1F2 record
  **0** (end-to-end 의 산출물 없음). ② 로컬 `~/.hx/bin/hexa` =
  `0.1.0-dispatch` stale 그대로 — `hexa run leighton/sweep` 여전
  `RegionShape`/`TrafficKind` undeclared. **정직 구분**: 병렬
  세션 promoted driver 의 *모듈 self-test* PASS 는 인정 (enum
  fix 후 booksim 모듈 컴파일·동작 입증 — 진전). 그러나 booksim
  `cmd_measure` body (F1F2 producer, rfc_001 §8) 미실행 →
  demiurge 측정 record 0 → "end-to-end GREEN" 아님. "RESOLVED"
  의 정확 범위 = enum codegen + 모듈 self-test; 측정 산출물은
  아님. 진짜 남음 = cmd_measure body (anynet→wire_delay→sweep→
  leighton→F1F2 emit) + 로컬 hexa promote. demiurge 코드 0
  추가 — verify·기록만.
- 2026-05-19 — **enum fix 검토 완료 — g3 실측 *확증*** (사용자
  "이 세션에서 fix 검토 / upstream / main branch 가능"). 진단:
  hexa-lang **main HEAD `8ff19d2a fix(bootstrap): promote enum-fix
  binary`** — source(`codegen_c2.hexa` `_is_enum_name`, 본 세션
  inbox patch 의 Shape-A) + promoted `self/native/hexa_v2` 둘 다
  landed. main 은 병렬 worktree `/private/tmp/wt-r7-trackb` 점유
  → 그 worktree 의 promoted `./hexa` 로 직접 검토: `leighton.hexa`
  → **PASS 10/10** (d4/d6 oracle PASS · impossible REJECT) ·
  `sweep.hexa` → **PASS 5/5** (B_obs 8≥8 · D_obs 14≥14). enum
  blocker = 진짜 RESOLVED. **g3 — 이번엔 정정 아닌 확증**: 앞선
  3건(d5a63a82·"2건"·"10/10")은 실측 정정이었으나, 본 검토는
  사용자 소식이 실측과 *일치* — 확증도 정직히 인정. 직전 "내
  로컬 leighton 실패" 와 모순 아님: 그건 `~/.hx/bin/hexa`
  (stale 설치본), 본 검토는 main worktree promoted hexa — 서로
  다른 binary 확인됨. **여전히 정직 갭**: ① demiurge 세션 기본
  `hexa` 는 아직 stale (main promoted 가 `~/core/hexa-lang` 기본
  브랜치로 merge/재설치돼야) · ② "demiurge end-to-end GREEN"
  아님 — booksim `cmd_measure`(F1F2 producer) 미실행, exports/
  측정 record 0. enum 해제 = B2 가 *가능해진* 것. demiurge
  코드 0 — 검토·기록만.
- 2026-05-19 — **phase ①-step1 — hexa promote (검증 환경 확보)**
  (사용자 "① / hexa upstream / 이세션 진행 / 허용"). 진단: 내
  `hexa` 명령 = `~/core/hexa-lang/hexa` wrapper → `hexadrv` →
  `self/native/hexa_v2`. rfc043 의 hexa_v2 = 1533496 bytes
  (enum fix *이전* build) — source 는 fix(_is_enum_name)됐으나
  binary stale. **promote**: main `8ff19d2a` 의 enum-fix
  `hexa_v2`(1533992) + 재생성 `hexa_cc.c` 를 rfc043 로 복사
  (hexa-lang commit `67c58198`). 측정: `hexa run` —
  `leighton.hexa` PASS 10/10 · `sweep.hexa` PASS 5/5 ·
  `traffic.hexa` PASS 12/12 (전부 내 환경 hexa, enum-bearing
  모듈 컴파일·실행 확인). **g3**: 검증 환경 닫힘 — 이제 booksim
  cmd_measure body 를 이 checkout 에서 measured-green 으로 작성
  가능. 단 — 이건 *검증 도구* 확보일 뿐, demiurge `exports/`
  측정 record 는 여전 0 (cmd_measure body 미구현). 다음 =
  ①-step2 cmd_measure body (anynet→wire_delay→sweep→leighton→
  F1F2 emit, rfc_001 §8).
- 2026-05-19 — **phase ①-step2a — booksim cmd_oracle wired**
  (cross-repo, hexa-lang). enum fix promote 후 `booksim.hexa` 가
  `use leighton` 가능 → `cmd_oracle` 의 exit-91 stub 을 실제
  leighton 호출로 교체: 8×8(n=64) d4-mesh + d6-hex `LeightonInput`
  → `leighton_bounds` → analytic bisection/diameter lower bound
  출력 + cite. 측정: `hexa run stdlib/booksim/booksim.hexa` →
  dispatcher selftest **7/7 PASS** rc 0; `booksim oracle` → d4/d6
  bisection_lower=8 diameter_lower=14. hexa-lang local commit
  `76b3e15c` (rfc043). **push 보류** — rfc043 working tree 에
  병렬 hexa-lang 세션의 미커밋 변경(`codegen_c2.hexa`·`compiler/
  PLAN.md`)이 있어 `pull --rebase` 가 막힘; 내가 stash 하면 그
  세션 작업 위험 → git 안전상 push 안 강행 (그 세션 정리 후 /
  별도). **g3 정직**: cmd_oracle 은 *analytic lower bound* 출력
  — no-over-claim cross-floor (leighton oracle_check) 이지
  *측정* 아님. cmd_sweep/cmd_measure 여전 gate, F1F2 record 0,
  "absorbed" 0. 다음 = ①-step2b cmd_sweep (sweep_curve) ·
  step2c cmd_measure (F1F2 emit, rfc_001 §8).
- 2026-05-19 — **phase ①-step2b — booksim cmd_sweep wired**
  (cross-repo, hexa-lang). `cmd_sweep` 의 exit-91 stub → 실제
  §B 파이프라인 (sweep.hexa fn main 패턴): `anynet_mesh_8x8_d4_
  text` → `anynet_parse` → `wire_delay_profile_lookup(22nm)` →
  `WireLink` 리스트 → `wire_delay_apply` → `wire_delay_into_
  anynet` → `SweepConfig`(uniform·iq_router_default·scaled
  window) → `sweep_curve`(rates 0.05..0.50). booksim.hexa 가
  wire_delay/iq_router/traffic/sweep 까지 `use` (enum fix
  promote 덕에 전부 컴파일). 측정: `hexa run booksim.hexa` →
  dispatcher selftest **7/7 PASS** rc 0; `booksim sweep` →
  points=10 zero_load_lat=50.0 knee_rate=0.3 (실 sweep 시뮬
  동작). hexa-lang local commit `02e3a5de`. **g3 정직**:
  cmd_sweep 는 sweep 시뮬을 돌려 SweepCurve 를 *in-memory
  출력* — F1F2 record emit 0. cmd_measure (F1F2 producer,
  rfc_001 §8) 가 step2c 로 남음 → demiurge exports/ 측정
  record 여전 0, "absorbed" 0. push 보류 지속 (rfc043 working
  tree 병렬 세션 미커밋 — git 안전). 다음 = ①-step2c
  cmd_measure (anynet→wire_delay→sweep→leighton oracle →
  F1F2 JSON → exports/ write — chip §B 측정 본체).
- 2026-05-19 — **phase ①-step2c — booksim cmd_measure body =
  F1F2 producer** (cross-repo, hexa-lang). `cmd_measure` 의
  exit-90 stub → 전체 §B 파이프라인: `anynet_parse` →
  `wire_delay_apply`/`into_anynet`(22nm) → `SweepConfig`(uniform)
  → `sweep_curve` → `anynet_mesh_bisection`/`diameter_hops` →
  `leighton_check` → rfc_002 §3 schema-1.0 F1F2-record JSON 조립
  (`_f1f2_json`/`_latency_curve_json`) → `write_file`. `--emit
  <dir>` 없으면 fast dry gate-status(no write), 있으면 record
  emit; leighton oracle 위반 시 exit 91(record 금지, rfc_001
  §7.3). 부수: `self/std_time.time_format` 이 이 codegen 경로에서
  사용 불가(`string_replace` 미intercept — 별개 버그) → epoch→ISO
  변환 `_iso_utc` 인라인. **측정**: `hexa run booksim.hexa`
  selftest **8/8 PASS**(measure dry-90 + measure-emit-90 추가);
  생성 record = valid JSON, `latency_curve` 8 unsaturated points
  (saturated 0.0 행 제외 — g3 거짓-데이터 금지), oracle PASS
  (bisection 8≥8 · diameter 14≥14). demiurge `cli verify` →
  전 항목 [OK], verdict-claim↔gate consistent. **g3 정직**:
  record = `measurement_gate=GATE_OPEN` · `absorbed=false` ·
  `sim_engine=hexa_native_booksim_stdlib` — sweep.hexa 의
  *analytic zero-load+queueing 모델* 산출이지 BookSim2
  cycle-accurate parity 아님(scope_caveats 4건 명시). exports/
  = 48 placeholder + **hexa-native 측정 record 1** = 49, 전부
  GATE_OPEN/absorbed=false (gate-summary 확인). 진전 = "측정
  record 0" → demiurge exports/ **첫 hexa-native 측정 record 1**;
  남는 갭 = full-curve rfc_001 §8 parity·외부 booksim2 대조
  미입증 → GATE_OPEN 유지. record 는 self-test 경로가 /tmp 생성
  → exports/ 로 cp(`hexa-arch` CLI 진입점 미배선 — `hexa run` 은
  빈 argv). hexa-lang local commit 보류 지속(rfc043 병렬 세션
  미커밋 — git 안전).
- 2026-05-19 — **phase λ — 3D ComponentMode 완성 + export 지원**
  (사용자 "3d 먼저 완전히 완성 / 우리 방향 최대 완성도 / 필요한
  사람한테 export"). design.md **D52** (export 포맷 = usdz/usda/
  stl/png 4종, obj 제외). 10 sub-phase, 전부 measured-green:
  - **λ-1** `ComponentGeometry`/`ComponentLayer` SSOT (DemiurgeCore)
    — 레이어 실치수(mm)·재질·colorHex; BIPV 5겹 preset. viewer 의
    하드코딩 박스 정의를 코어로 끌어올림 (D50 — viewer·exporter·
    CLI 가 한 정의 공유).
  - **λ-2/3** `USDExporter`(.usda) · `STLExporter`(.stl) — 코어
    순수 함수, 의존성 0. cockpit·CLI 공유.
  - **λ-4** CLI `emit-component` — 절차 BIPV artifact 를
    `exports/component/geometry/` 에 .usda + .usdz(usdcat 패키징)
    + `ComponentRecord` JSON 으로 emit.
  - **λ-5** viewer USDZ 로드 경로 — `Entity.load` 로 실제 .usdz
    렌더 (모드 토글: 분해 애니메이션 ⇄ USD 산출물), 없으면
    procedural fallback.
  - **λ-6** camera/interaction — pinch-zoom · 카메라 프리셋 4
    (iso/top/front/side) · 애니메이션 토글 · 수동 explode 슬라이더.
  - **λ-7** 레이어 라벨 — 선택 가능한 레이어 리스트 + 3D 하이라이트.
  - **λ-8** viewer export 메뉴 — `.usda`/`.usdz`/`.stl`/PNG
    스냅샷, `NSSavePanel`.
  - **λ-9** CLI `export-component <fmt> [path]` — cockpit export 와
    동일 `USDExporter`/`STLExporter` 공유 (D50).
  - **λ-10** 마감 — `packageUSDZ` 를 DemiurgeCore 로 단일화
    (CLI↔cockpit 공유), PLAN 로그, reinstall.
  측정: `swift run CockpitApp` 빌드 green (CockpitApp 실행 확인);
  `emit-component` → .usda/.usdz/.json 생성, .usdz `usdcat` 읽기
  검증; `export-component stl` → 60 facets(5겹×12); `export-component
  usda` → valid USD. **g3 정직**: BIPV geometry 는 PROCEDURAL
  PLACEHOLDER — 그럴듯한 치수일 뿐 측정된 부품 아님.
  `ComponentRecord` = `producer=demiurge_procedural_placeholder` ·
  `GATE_OPEN` · `absorbed=false`, scope_caveats 3건 명시. exports/
  component/geometry/ = demiurge 의 첫 component artifact (단 측정
  record 아님 — geometry 가 well-formed 한 것과 thermal/구조
  verdict 가 measured 인 것은 별개 게이트). 진짜 측정 component
  producer = hexa-lang/component (P-⑨ — FreeCAD/gmsh 미설치로 별도
  세션). viewer 3D 인터랙션(zoom·프리셋·레이어 선택·export 메뉴)은
  컴파일 measured-green — 시각 동작은 GUI 확인 필요.
