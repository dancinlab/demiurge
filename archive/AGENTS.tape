#!/usr/bin/env tape
# AGENTS.tape — Demiurge project governance (SSOT for load-bearing rules)
# tape v1.2. Decision audit trail = design.md (D1..). This file = the
# enforced governance an agent must obey in this repo.

@V := "tape" :: spec [active]
  version = "1.2"

## INDEX (curated pointer table — keep in sync if you add or remove a top-level entry)
# @D g_hexa_only              — ULTIMATE FORM = hexa-native; Python/Swift/external CLI/sibling-repo binary are TRANSITIONAL POINTERS, not endpoints; absorbed=true requires hexa-native parity port (D80)
# @D g_no_hardcoded_data      — 데이터는 declarative SSOT (.demi/.tape/.md/INDEX.*), 코드는 type + loader; hardcoded list/dict in Swift = violation (D86)
# @D g_demiurge_pointer_only  — demiurge = pointer / spawn wrapper ONLY; every producer script lives in hexa-lang/stdlib/  (D61)
# @D g_stdlib_ownership       — stdlib/ namespace belongs EXCLUSIVELY to hexa-lang; demiurge is consumer only   (D15)
# @D g3_no_over_claim         — never assert unmeasured/unproven results; SKIP-mode regression banned           (D12)
# @D g_clean_room             — prior art absorbed from public surface only; no closed-binary RE / DRM bypass   (D1)
# @D g_decouple               — hexa-bio + comb + hexa-matter all typed-interface-consumed (decoupled)          (D2+D11)
# @D g_scope                  — design-only rescinded; full scope incl. execution/absorption, no-big-bang       (D10+D12)
# @D g_absorption             — per absorbed tool: one rfc_0NN, clean-room, measured gate, guarded tombstone    (-)
# @D g_hexa_native            — absorb into hexa intrinsics, never shell out (bounded rfc_048 exception)        (D14+D18)
# @D g_swift_native           — Swift work prefers SwiftUI/Foundation/AppKit + Apple-canonical patterns first   (D26)
# @D g_cockpit_isolation      — cockpit/ logically outside governance boundary; reads exports/docs one-way only (D27+D41)
# @D g_ai_agent_action_surface — cockpit/CLI may invoke AI agent as mutation intermediary; agent writes exports (D34)
# @D g_ai_agent_chat_surface  — LEFT Chat tab routes to Claude Code API/CLI; honesty-banner on action replies   (D37+D38)
# @D g_cockpit_reinstall      — on cockpit/ source change, re-run demiurge install so installed app stays sync  (-)
# @D g_ssot_single_source     — one fact / one logic lives in one canonical home; derived docs are pointers     (D50)
# @F forbidden                — hard denies f1..f6 (stdlib tree, over-claim, RE, silent-skip, early-tombstone, chat-claim)
# @N ssot                     — pointer map: where governance + decisions + arch + progress live
# @N n_cockpit_ar_target      — cockpit 3D viewer uses RealityKit to port to AR / visionOS spatial rendering    (D35)
# @N n_cern_producer_alternatives — cern + analyze first ProducerRegistry user; default xsuite-tracking         (D74)
# @N n_d80_sweep_closure      — D80 g_hexa_only 12-pilot sweep 종결 + 5 .demi SSOT 통합 + D87..D100             (D80+D87..D100)
# @N n_rfc_013_kappa_67       — RFC 013 hexa-native parity connection (κ-67, PARTIAL-LAND, demiurge 5e9f6dea)   (D80)
# the entries themselves are SSOT; this index is a derived pointer table per @D g_ssot_single_source / D50.

@D g_hexa_only := "ultimate form = hexa-native" :: governance [required d=2026-05-20 active]
  do   = "absorbed=true 시 record 에 hexa_native_parity{ref·rel_err·tolerance} 필수 · Python/Swift/외부 CLI = transitional pointer 만"
  dont = "hexa-native parity port 없이 absorbed=true (GATE_OPEN cap) · transitional substrate 를 endpoint 취급"
  @> CLAUDE.md

@D g_no_hardcoded_data := "데이터 = declarative SSOT, 코드 = type+loader" :: governance [required d=2026-05-20 active]
  do   = "list/dict/table/record = .demi/.tape/.md/INDEX.* 에 declarative · Swift 는 type+loader+dev-fallback 만"
  dont = "Swift 에 hardcoded literal array/dict (Swift function ref 는 예외)"
  @> CLAUDE.md

@D g_demiurge_pointer_only := "demiurge = pointer/spawn-wrapper" :: governance [required d=2026-05-20 active]
  do   = "producer script SSOT = ~/core/hexa-lang/stdlib/<domain>/ · demiurge 는 Process-spawn + Record decode 만"
  dont = "demiurge 가 producer script 소유 · cockpit/scripts/*.py 신규 · spawn wrapper 안에 compute logic"
  @> CLAUDE.md

@D g_stdlib_ownership := "stdlib ⊂ hexa-lang" :: governance [required d=2026-05-18 active]
  do   = "stdlib SSOT = hexa-lang 단독 (2-layer: kernels/ + <domain>/ adapter) · demiurge = consumer-pointer"
  dont = "demiurge/stdlib/ tree · sibling ~/core/hexa-<id> 를 SSOT · 새 kernel 우선 (existing 재사용 first)"
  @> CLAUDE.md

@D g3_no_over_claim := "no over-claim" :: governance [required d=2026-05-18 active]
  do   = "absorbed/parity/resolved 는 측정 gate + 인용 수치 동반 시에만"
  dont = "측정 없이 결과 단언 · SKIP-mode regression"
  @> CLAUDE.md

@D g_clean_room := "public-surface clean-room" :: governance [required d=2026-05-18 active]
  do   = "prior art = OSS/arxiv/patent/standard/datasheet/vendor public doc 에서만 흡수"
  dont = "closed-binary RE · license/DRM 회피"
  @> CLAUDE.md

@D g_decouple := "typed-interface decoupling" :: governance [d=2026-05-18 active]
  do   = "hexa-bio + comb + hexa-matter = typed-interface 소비 · domains/matter/ = pointer (SSOT=hexa-lang)"
  dont = "demiurge 안에 sibling-repo copy · D17 후 demiurge-absorb 패턴 carry"
  @> CLAUDE.md

@D g_scope := "scope (full)" :: governance [d=2026-05-18 active]
  do   = "execution + absorption 포함 full scope · no-big-bang incremental · hexa-first"
  dont = "design-only carry (D10 rescinded) · 대형 일괄 land"
  @> CLAUDE.md

@D g_absorption := "absorption pattern" :: governance [d=2026-05-18 active]
  do   = "absorbed tool 당 proposals/rfc_0NN_*.md 1개 · clean-room · measured gate · push origin 후 tombstone"
  dont = "tombstone before measured-GREEN + dependents + 명시적 per-step go · 측정 없는 archive rename"
  @> CLAUDE.md

@D g_hexa_native := "hexa-native-only" :: governance [d=2026-05-18 active]
  do   = "hexa intrinsics 흡수 · rfc_048-precedent bounded exception 시 fail-loud documented subprocess · 재유도 = scheduled follow-on"
  dont = "기본 shell-out · unbounded foreign substrate carry"
  @> CLAUDE.md

@D g_swift_native := "swift = canonical first" :: governance [required d=2026-05-19 active]
  do   = "Swift 작성 = SwiftUI/Foundation/AppKit native idiom + Apple-canonical pattern 우선"
  dont = "3rd-party lib · custom DSL · 비-canonical 구조 (명시적 justification 없으면)"
  @> CLAUDE.md

@D g_cockpit_isolation := "cockpit logical boundary" :: governance [required d=2026-05-19]
  do   = "cockpit/CLI = exports/** record + metadata doc read · app-state = Library/Application Support/demiurge/"
  dont = "exports/ 직접 mutate · hexa-lang/stdlib/* import · build artifact commit · metadata = measurement 근거"
  @> CLAUDE.md

@D g_ai_agent_action_surface := "AI agent = producer" :: governance [required d=2026-05-19 active]
  do   = "synth/measure/verify = AI agent (Claude CLI+API) 가 producer · agent 가 exports/** record 생성 (D7)"
  dont = "cockpit GUI/CLI 가 exports/ 직접 mutate · agent action 의 provenance/gate/citation 누락"
  @> CLAUDE.md

@D g_ai_agent_chat_surface := "LEFT Chat = CLI+API dispatch" :: governance [required d=2026-05-19 active]
  do   = "LEFT Chat → intent classifier → API(Q&A)/CLI(action) · action reply 는 provenance/gate/cite/caveats VERBATIM"
  dont = "backing record 없이 measurement/parity 주장 (red REJECTED · @F f2/f4)"
  @> CLAUDE.md

@D g_cockpit_reinstall := "cockpit edit → reinstall" :: governance [required d=2026-05-19 active]
  do   = "cockpit/Sources·Package.swift·install.sh·AppIcon 변경 commit 후 `demiurge install` (cockpit/install.sh) 즉시 실행"
  dont = "/Applications/demiurge.app 이 repo 보다 stale 상태 carry · reinstall 누락하고 done 보고"
  @> CLAUDE.md

@F forbidden := "hard denies" :: governance [required d=2026-05-18 active]
  f1 = "creating/extending a `stdlib/` tree under demiurge (g_stdlib_ownership)"
  f2 = "over-claim — asserting unmeasured 'absorbed/parity/resolved' (g3)"
  f3 = "closed-binary RE / license circumvention (g_clean_room)"
  f4 = "silent skip / SKIP-mode regression (g3)"
  f5 = "tombstone (repo rename / local delete) before measured-GREEN + dependents + explicit go"
  f6 = "AI agent chat reply asserting measured outcome without backing record having provenance.measurement_gate ∈ {GATE_B_PINNED_MET, GATE_CLOSED_MEASURED} (g_ai_agent_chat_surface; rfc_009 §4 mirror)"

@D g_ssot_single_source := "one fact = one canonical home" :: governance [required d=2026-05-19 active]
  do   = "결정 SSOT=design.md · 진행 SSOT=PLAN.md · 파생 doc 은 pointer · CLI+cockpit 공통 logic 은 DemiurgeCore 동일 함수 호출"
  dont = "D-번호/RFC건수/phase 를 파생 doc 에 복제 · cockpit/CLI 가 같은 switch 두 번 구현 (drift)"
  @> CLAUDE.md

@N ssot := "where governance + decisions live" :: note [d=2026-05-19 active]
  governance = "this AGENTS.tape (enforced rules + @F denies)"
  decisions = "design.md — gated decision audit trail (SSOT). 개별 결정 번호·요지·D-range 는 design.md 만 보유한다 — 본 @N 은 복제하지 않는다 (g_ssot_single_source). cockpit spec = rfc_009/010/011/012; cockpit 구현 진행 = PLAN.md."
  arch_why = "CHARTER.md + HANDOFF.md (reconciled to D22 on 2026-05-19; D23..D49 + cockpit κ-1..κ-8 land in PLAN.md / design.md)"
  goal = "GOAL.md (한 문장 north-star + 정직한 현 위치)"
  progress = "PLAN.md (append-only log)"
  index = "ARCH.tape"

@N n_cockpit_ar_target := "cockpit 3D viewer targets AR / visionOS portability" :: note [d=2026-05-19 active]
  text = "The cockpit's 3D viewer (phase ι — `ComponentView3D`, the exploded-isometric ComponentMode) uses RealityKit (D35) specifically so it can port to AR / visionOS spatial rendering. RealityKit was picked over SceneKit for exactly this forward path — visionOS is RealityKit-native. On macOS the cockpit runs a plain virtual `ARView` viewport with mouse-drag orbit (v0, measured-green); AR / visionOS spatial is the stated future target — new platform surfaces reuse the same RealityKit scene graph."
  decision_ref = "design.md D35 · rfc_011 §9"
  user_directive = "2026-05-19 — 'AR/visionOS 지원 목표로 하자 AGENTS.tape 기록'"

@N n_cern_producer_alternatives := "cern + analyze carries alternative producers" :: note [d=2026-05-20 active]
  text = "Cell (cern, analyze) is the FIRST cell to use ProducerRegistry (cockpit/Sources/DemiurgeCore/Loaders/ProducerRegistry.swift). Variants: `xsuite-tracking` (default, Xsuite 100-turn FODO tracking — real physics, κ-49 substrate) and `pylhe` (legacy LHE round-trip — synthetic, kept for parser-coverage). CLI override: `action analyze cern --producer pylhe`. Other cells stay on the hardcoded ActionDispatch switch — registry is additive, joined only when a cell actually carries alternatives. Same-shape Record decode TBD per consumer."
  default_producer = "xsuite-tracking — promotes the κ-49 substrate (real Xsuite particle tracking) over the legacy pylhe round-trip toy, per user gate 2026-05-20."
  decision_ref = "design.md D74 · archive/session-notes/cern_analyze_producer_alternative_decision_2026-05-20.md"
  user_directive = "2026-05-20 — 'Option C — ProducerRegistry; defaults Q2 xsuite-tracking, Q3 CLI-only, Q4 governance line YES'"

@N n_d80_sweep_closure := "D80 g_hexa_only 12-pilot sweep 종결 + 5 .demi SSOT 통합" :: note [d=2026-05-20 active]
  text = "D80 g_hexa_only ultimate-form sweep closed at 12 hexa-native kernel pilots / 291 cumulative parity assertions across `solar · mc_transport · neural_lif · graph_bfs · urdf_fk_2link · plasma_metrics · orbital_kepler · dft_naive · event_queue · transport_kinematics · breaker_trace_reduce · fem_bar1d_subset`. Declarative SSOT layer consolidated to 5 `.demi` files under `domains/` (INDEX · DEPENDENCIES · PRODUCERS · PILOTS · SUBSTRATE_LINKS) — every kernel · producer · dependency · pilot · cross-substrate link now reads from declarative SSOT via DemiParser loaders (D86 g_no_hardcoded_data 정합). Audit trail: design.md D87..D100 — `.demi` location (D87) · DEPENDENCIES.demi move (D88) · allHardcoded fallback removal (D89) · PILOTS.demi 8-field schema (D90) · row=kernel granularity (D91) · flat dir layout (D92) · pattern-pilot ↔ PILOTS dual-source (D93) · parity_ref = PilotLoader.find (D94) · isHexaNativeAbsorbed computed (D95) · sibling sub-domain narrative (D96) · 3-tier link-integrity verifier (D97) · DEPENDENCIES ↔ PILOTS dual-source CI (D98) · cockpit HexaNativeParityChip (D99) · non-sibling narrative reverse (D100). cell-level absorbed-flip round is queued (κ-67 RFC 013) — pilots are substrate-side measured fact; demiurge cells still ride `gate=hexaNativeFuture` until per-cell parity records emit."
  measured_fact = "12 pilots · 291 assertions · all PASS (rel_err ranging 0.0 IEEE-754 bit-exact through ≤1e-12). 5 .demi SSOTs DemiParser-loaded by demiurge (PilotLoader · DependenciesLoader · ProducerRegistry · DomainCatalog · SubstrateLinkLoader). hexa-lang tip: `a272c9c4` (sweep close commit on origin/main per PLAN κ-66)."
  decision_ref = "design.md D80 · D87..D100 · PLAN κ-66"
  user_directive = "2026-05-20 — 'D80 sweep 종결 박제' (κ-66 consolidation gate)"

@N n_rfc_013_kappa_67 := "RFC 013 hexa-native parity connection (κ-67, PARTIAL-LAND)" :: note [d=2026-05-20 active]
  text = "RFC 013 (`proposals/rfc_013_hexa_native_parity_connection.md`) formalises the substrate ↔ demiurge cell-record wiring promised by D80. Status: PARTIAL-LAND — schema half landed by demiurge `5e9f6dea` (HexaNativeParityRef 8-field + 5 cell-record carriers Ufo + Energy + Fusion + Aura + ChipAnalyze + DependenciesLoader + GateType.hexaNativeFuture); producer-side emit + live-mirror queued (per-cell `parity_ref = PilotLoader.find(kernelPath:)` injection, D94 T7 phase). Promotes the κ-65 connection-plan inbox note into a formal RFC; the note remains in place as audit trail. κ phase: κ-67 (pilot-driven demiurge cell absorbed-flip round)."
  source_decisions = "D61 (substrate in hexa-lang only) · D72 (2-layer stdlib extraction) · D80 (g_hexa_only ultimate-form) · D85 (PRODUCERS.demi) · D86 (g_no_hardcoded_data)"
  decision_ref = "proposals/rfc_013_hexa_native_parity_connection.md · design.md D80 / D94 · PLAN κ-65..κ-67"
  user_directive = "2026-05-20 — 'D80 sweep 종결 마일스톤 entry 추가' (κ-67 RFC promotion)"
