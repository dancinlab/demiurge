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
