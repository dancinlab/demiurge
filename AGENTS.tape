#!/usr/bin/env tape
# AGENTS.tape — Demiurge project governance (SSOT for load-bearing rules)
# tape v1.2. Decision audit trail = design.md (D1..). This file = the
# enforced governance an agent must obey in this repo.

@V := "tape" :: spec [active]
  version = "1.2"

## INDEX (curated pointer table — keep in sync if you add or remove a top-level entry)
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
# the entries themselves are SSOT; this index is a derived pointer table per @D g_ssot_single_source / D50.

@D g_demiurge_pointer_only := "demiurge = pointer / spawn wrapper ONLY" :: governance [required d=2026-05-20 active]
  rule = "demiurge is a pointer / spawn-wrapper ONLY for every external-tool producer script (Python / shell / hexa-native). The script SSOT lives in `hexa-lang/stdlib/<domain>/`, NEVER in `demiurge/`. demiurge's Swift `*Producer.swift` files only `Process`-spawn the hexa-lang-owned script; they hold no compute logic."
  demiurge_role = "spawn wrapper + typed Record decoder. NEVER author or own a producer script. NEVER carry `cockpit/scripts/*.py` (generalizes g_stdlib_ownership from hexa-native wrappers to ALL producer scripts including Python/shell)."
  user_directive = "2026-05-20 — 'AGENTS.tape 최상단으로 해당내용 옮겨서 기록, demiurge 는 포인터 (spawn wrapper)'. Generalizes D15/g_stdlib_ownership to producer-side scripts (Python ngspice/pvlib/skyfield/urdfpy/networkx/freecad wrappers etc.) — not only hexa-native modules."
  examples_correct = "`MatterAnalyzer.swift` spawns `hexa run ~/core/hexa-matter/verify/run_all.hexa` — hexa-lang owns the script. Future `SSCBProducer.swift` correctly spawns `~/core/hexa-lang/stdlib/sscb/ngspice.py`."
  examples_violated_at_birth_must_migrate = "`cockpit/scripts/bipv_freecad.py` (κ-33) · `sscb_ngspice.py` (κ-34) · `grid_networkx.py` / `bot_urdf.py` / `energy_pvlib.py` / `space_skyfield.py` (κ-35..κ-39 in-flight) — all violations; migration round moves each to `hexa-lang/stdlib/<domain>/`, updates demiurge Producer.swift spawn path."
  enforcement = "every new producer's PR must show the script lives under `~/core/hexa-lang/stdlib/<domain>/` and demiurge carries only a `*Producer.swift` `Process` spawn wrapper. Any `cockpit/scripts/*.py` = automatic block."
  see_also = "D15 (stdlib ⊂ hexa-lang) · D17 (matter parity precedent: SSOT=hexa-lang, demiurge=consumer-pointer) · D61 (this decision, design.md) · ABSORPTION.md ① STDLIB"

@D g_stdlib_ownership := "stdlib ⊂ hexa-lang ONLY" :: governance [required d=2026-05-18 active]
  rule = "The `stdlib/` namespace belongs EXCLUSIVELY to hexa-lang. demiurge is a *consumer* of hexa-lang stdlib — it MUST NOT own or carry a `stdlib/` tree."
  demiurge_role = "가져다 쓰는 쪽 (consumer). Absorbed/re-derived reusable hexa-native modules belong in hexa-lang/stdlib/ (rfc_047/048 precedent), referenced from demiurge."
  user_directive = "2026-05-18 — 'stdlib 은 오로지 hexa-lang 이 보유 · demiurge 는 가져다쓸분' · 2026-05-19 REAFFIRMED — 'hexa-lang = SSOT, demiurge = pointer; 모든 stdlib 는 hexa-lang 소유' · 2026-05-19 강화 — 'hexa-lang 이 유일 SSOT: 재사용 가능한 stdlib · 도구 · 흡수는 전부 hexa-lang 소유; demiurge 는 도메인 설계 기획 · 소비만' · 2026-05-19 정정 — '~/core/hexa-<id> sibling repo 패턴은 폐기; 모든 도메인의 stdlib · 도구는 hexa-lang 안 (예: hexa-lang/component, hexa-lang/stdlib/booksim) — 별도 sibling repo 가 SSOT 가 아님'"
  general_principle = "hexa-lang is the SSOT of ALL stdlib AND every reusable absorbed module. demiurge is a consumer / pointer ONLY — it references the SSOT, never owns it. This generalizes beyond `stdlib/`: any reusable hexa-native module re-derived during an absorption (rfc_003/006 pattern) lands in hexa-lang, and demiurge carries a typed-interface pointer (the D17 hexa-matter precedent — SSOT=hexa-lang, demiurge=consumer-pointer)."
  kernel_layer = "D72 (2026-05-20): hexa-lang/stdlib/ is 2-layer — ①a `kernels/<kernel>/` (domain-agnostic reusable math/physics engines: fem · mc_transport · circuit · graph · orbital · wave_optics · cfd · logic_synth · noc_sim · ode_pde) + ①b `<domain>/` (thin adapter — kernel call + domain params/geometry only). ABSORPTION RULE: when absorbing an external tool, classify WHICH kernel it belongs to FIRST; a new domain MUST reuse an existing kernel before a new kernel is added (a new kernel only for genuinely new math). Prevents N×M producer explosion → N+M. SSOT = design.md D72; see ABSORPTION.md ①."
  violation_resolved = "design.md D15 applied 2026-05-18: the 6 modules + .stubs migrated to hexa-lang/stdlib/booksim/ (committed hexa-lang d5a63a82, self-tests re-verified GREEN there); 2026-05-19 — d5a63a82 PUSHED to origin/rfc043-hexa-torch (verified via git branch -r --contains). demiurge/stdlib/ git-rm'd. demiurge now carries NO stdlib/ tree — rule satisfied. rfc_003 references the hexa-lang location. (Yosys §4 modules in hexa-lang/stdlib/yosys/ are still .hexa.stub only — impl pending a hexa-lang session, NEXT_SESSIONS P-②③.)"

@D g3_no_over_claim := "no-over-claim — RETAINED" :: governance [required d=2026-05-18 active]
  rule = "Never assert unmeasured/unproven results. 'absorbed'/'parity'/'resolved' only at a measured gate, filed with cited numbers. SKIP-mode regression banned."
  status = "User requested g3 removal (2026-05-18) — DECLINED (honesty floor, inherited from user identity SSOT). RETAINED per design.md D12."

@D g_clean_room := "public-surface clean-room (D1)" :: governance [required d=2026-05-18 active]
  rule = "External prior art absorbed from public surface only (OSS/arxiv/patents/standards/datasheets/vendor public docs). No closed-binary RE, no license/DRM circumvention."

@D g_decouple := "typed-interface decoupling (D2/D11)" :: governance [d=2026-05-18 active]
  rule = "hexa-bio + comb + hexa-matter ALL typed-interface-consumed (decoupled). hexa-matter's absorption SSOT = hexa-lang (already 완전 이관; D17 supersedes the D12 demiurge-absorb — domains/matter/ is a pointer, not a copy). comb SSOT stays hexa-lang; archive/comb = non-SSOT mirror."

@D g_scope := "scope (D10 rescinded → full)" :: governance [d=2026-05-18 active]
  rule = "design-only (D10) RESCINDED per user (D12) — full scope incl. execution/absorption. Still: no-big-bang incremental, hexa-first."

@D g_absorption := "absorption pattern" :: governance [d=2026-05-18 active]
  rule = "Per absorbed tool/repo: one proposals/rfc_0NN_*.md (rfc_047/048 mirror). Clean-room, measured gate, tombstone (archive_ rename + local delete) ONLY after measured-GREEN + dependents + explicit per-step go. Anti-data-loss: push origin before any delete."

@D g_hexa_native := "hexa-native-only (g5)" :: governance [d=2026-05-18 active]
  rule = "Absorb into hexa intrinsics, never shell out — EXCEPT the rfc_048-precedented bounded exception: verbatim-preserved foreign substrate invoked as a documented subprocess, fail-loud. Re-derivation to hexa-native is the scheduled follow-on. Precedents (cited): D14 (hexa-matter python shim, now moot per D17), D18 (Yosys flow re-derived hexa-native + ABC tech-mapping invoked as bounded subprocess; rfc_006 §7)."

@D g_swift_native := "swift = native + canonical patterns first" :: governance [required d=2026-05-19 active]
  rule = "When implementing Swift (rfc_009 macOS cockpit, D22 downstream — and any future Swift inside Demiurge's product-surface boundary): prefer SwiftUI / Foundation / AppKit native idioms and Apple-canonical patterns FIRST. Third-party libraries, custom DSLs, or non-canonical structures require an explicit justification noted in the producing PR — they are NOT default."
  reason = "rfc_009 cockpit is the product surface for honesty-as-feature (D22, g3); applying g5's hexa-native spirit to the Swift dialect = prefer Apple-canonical Swift idiom over bespoke abstractions. Reduces review surface, keeps build/runtime obvious, aligns with rfc_009 §5's g5-unpressured boundary, and matches the andrej-karpathy minimum-new-structure principle."
  applies_to = "rfc_009 cockpit (planned build, D22 downstream session) + any future Swift inside Demiurge's product-surface boundary; precedent reusable for other native-dialect product surfaces if they appear."
  user_directive = "2026-05-19 — 'swift 작성시 구현시 native, canonical 방식 우선 => AGENTS.tape 등록'"
  decision_ref = "design.md D26"

@D g_cockpit_isolation := "cockpit/ logical-boundary isolation (D27 + D41)" :: governance [required d=2026-05-19 active]
  rule = "The Swift cockpit lives in `cockpit/` (monorepo, D27) but is logically OUTSIDE Demiurge's governance boundary per rfc_009 §5. Enforcement: (a-records) cockpit/CLI code reads RECORDS ONLY from `../exports/**` (typed records — D2 typed-interface contract); runtime-checked by `RecordLoader.load(url:)` returning `pathOutsideExports` for any URL outside `RecordLoader.exportsRoot`. (a-docs) cockpit/CLI MAY additionally read project metadata documents READ-ONLY (`../design.md`, `../proposals/`, `../domains/`, `../inbox/`, `../archive/`, `../README.md`, `../CHARTER.md`, `../HANDOFF.md`, `../GOAL.md`, `../PLAN.md`, `../ARCH.tape`, `../AGENTS.tape`, `../cockpit/references/`) for sidebar navigation + inspector context (D41); these reads NEVER inform a `measurement_gate` / `absorbed` / `parity` claim. (b) cockpit code MUST NOT import or invoke `hexa-lang/stdlib/*` nor any demiurge hexa-native module. (c) cockpit build artifacts (`.build/`, `DerivedData/`, `*.xcodeproj/xcuserdata/`, `.swiftpm/`) MUST stay in `.gitignore` — never enter records SSOT. (d) edit-direction is one-way: cockpit reads exports + reads navigation docs, neither exports nor docs ever read cockpit. (e) the cockpit MAY write its OWN app-state — project manifests, settings (rfc_012 workbench, D45) — under `~/Library/Application Support/lab.dancin.demiurge/`; this is macOS app-data, NOT `exports/` and NOT a record, so the records-honesty boundary is untouched. Project-produced records still go to `exports/` via the AI agent (@D g_ai_agent_action_surface), never written by the cockpit directly."
  reason = "rfc_009 §5 architecture diagram draws a governance boundary so g5 (hexa-native-only) stays unpressured. D27 picks monorepo placement (B) — the boundary becomes **logical** (consumption-direction + no-import + .gitignore) rather than **physical** (separate repo). This rule makes the logical boundary auditable: any PR that violates (a)/(b)/(c)/(d) is rejected on the same grounds a separate-repo violation would be."
  applies_to = "every commit landing in `cockpit/` subdir + every PR touching the exports/cockpit boundary"
  decision_ref = "design.md D27 (monorepo placement) · rfc_009 §5 (boundary semantics) · D2 (typed-interface decoupling) · D26 (g_swift_native sister rule)"
  enforcement_check = "pre-commit grep: `grep -rE 'import.*hexa|import.*stdlib' cockpit/` MUST return 0 matches; CI smoke: `git ls-files cockpit/ | xargs grep -l 'exports/' | head` shows consumer paths read from `exports/` only."

@D g_ai_agent_action_surface := "cockpit/CLI may invoke AI agent for actual work" :: governance [required d=2026-05-19 active]
  rule = "cockpit GUI's LEFT Chat tab AND demiurge CLI may invoke an AI agent (D38: Claude Code CLI + API) to perform actual synthesis / measurement / analysis / verification. The agent acts as a producer (D7) — it executes engine tools (Yosys / OpenROAD / hexa-matter / Elmer / openEMS / …) and writes new records to `../exports/**`. The cockpit GUI / CLI itself NEVER mutates `exports/` directly; @D g_cockpit_isolation (d) remains intact."
  reason = "Read-only cockpit (rfc_009 §5) is correct for the user-facing surface, but the user (2026-05-19) requires real engineering work triggerable from the same surface. Inserting an AI agent as the mutation intermediary preserves: (a) cockpit_isolation (d) edit-direction one-way; (b) D7 producer-owned exports; (c) g3 measured-gate-bound discipline — agent actions emit records that carry full provenance/gate/citations."
  applies_to = "any cockpit toolbar action / CLI subcommand / LEFT Chat tab message that initiates work beyond pure display"
  user_directive = "2026-05-19 — '실제 합성 등 여기서 진행할수 있는거야???? cli 도 함께 만들자, ai agent 이용해서, 작업도 가능하게, AGENTS.tape 에도 기록'"
  decision_ref = "design.md D34"

@D g_ai_agent_chat_surface := "cockpit LEFT Chat tab via Claude Code CLI + API" :: governance [required d=2026-05-19 active]
  rule = "cockpit's LEFT sidebar 1st tab (Chat, D37) routes user messages through an intent classifier to either Claude Code API (conversational, streaming, low-latency Q&A on existing records / citations / caveats) or Claude Code CLI (action-bearing, subprocess with tool-permissions, long-running synth/measure/verify). All action results MUST render their full provenance / measurement_gate / atlas_cite_block / scope_caveats VERBATIM in the chat reply (honesty-as-feature applied to chat — rfc_009 §4); replies that assert measurement/parity/absorption without a backing record render a red REJECTED banner (the @F f2 / f4 mirror in chat)."
  reason = "User (2026-05-19) wants in-cockpit conversational + action capability ('레이아웃 안에 AI 대화형 진행도 가능해야해 / LLM 대화형 / claude code cli & claude code api'). Dual dispatch (API for Q&A, CLI for action) matches the two natural modalities. Honesty-banner-in-chat is the contract that keeps g3 alive when the AI is the surface."
  applies_to = "all input through the cockpit LEFT Chat tab (D37)"
  dispatch = "v0: slash-command heuristic (/synth /measure /verify /analyze -> CLI; otherwise -> API). Phase ι: LLM-based intent classifier with explicit dispatch reasoning logged in chat."
  decision_ref = "design.md D37 (location) · D38 (backend) · D39 (RIGHT inspector for verbatim provenance display)"

@D g_cockpit_reinstall := "cockpit edit → hx-install reinstall" :: governance [required d=2026-05-19 active]
  rule = "Whenever cockpit/ source changes land (commit), re-run the install — `demiurge install` (= `bash cockpit/install.sh`: release build → app-icon → .app reassembly → /Applications/demiurge.app) — so the installed app stays in sync with the repo. The agent runs this as the last step of any cockpit-touching change set, before reporting done."
  reason = "The cockpit is hx-installed as /Applications/demiurge.app (a copied release binary, NOT a live `swift run`). Without a reinstall, the installed app silently lags the repo — the user would be running stale code. Re-running install keeps measured-green build == what is installed."
  applies_to = "any commit that modifies cockpit/Sources/** or cockpit/Package.swift or cockpit/install.sh or cockpit/AppIcon/*"
  user_directive = "2026-05-19 — '수정완료시 에는 항상 hx install 통해서 재설치를 해줘 <= AGENTS.tape 등록'"

@F forbidden := "hard denies" :: governance [required d=2026-05-18 active]
  f1 = "creating/extending a `stdlib/` tree under demiurge (g_stdlib_ownership)"
  f2 = "over-claim — asserting unmeasured 'absorbed/parity/resolved' (g3)"
  f3 = "closed-binary RE / license circumvention (g_clean_room)"
  f4 = "silent skip / SKIP-mode regression (g3)"
  f5 = "tombstone (repo rename / local delete) before measured-GREEN + dependents + explicit go"
  f6 = "AI agent chat reply asserting measured outcome without backing record having provenance.measurement_gate ∈ {GATE_B_PINNED_MET, GATE_CLOSED_MEASURED} (g_ai_agent_chat_surface; rfc_009 §4 mirror)"

@D g_ssot_single_source := "one fact / one logic — one canonical home" :: governance [required d=2026-05-19 active]
  rule = "한 사실·한 로직은 canonical 한 곳에만 산다. (1) 문서 — 결정(D-번호·요지) SSOT = design.md, 진행(cockpit phase·측정 수치·건수) SSOT = PLAN.md; 파생 문서(AGENTS.tape @N · GOAL.md · CHARTER · HANDOFF · README · rfc_*)는 D-range·RFC건수·phase 목록을 복제하지 말고 포인터로 참조한다. (2) 코드 — CLI 와 cockpit 의 공통 도메인/verb/record 분기는 DemiurgeCore 의 동일 함수를 호출한다 (DomainCatalog · Verb · ArtifactRegistry · RecordLoader); 각자 switch 를 복제하지 않는다 → 같은 입력에 같은 출력 (CLI↔cockpit 멱등성/parity)."
  why = "사용자 2026-05-19 — SSOT reconcile 한 번에 D-번호가 9개 파일, RFC 건수가 3곳에 박혀 매번 '양쪽'을 동시 갱신해야 했고, cockpit 의 domain/verb switch 가 CLI 로 복붙되면 drift 한다. 사용자 지시 원문: 'update 마다 양쪽 업데이트 하지 않게 / CLI, cockpit 멱등성 보장'."
  enforcement = "결정/phase 추가 시 canonical 파일(design.md · PLAN.md)만 edit — 파생 문서가 숫자 동시갱신을 요구하면 그 자체가 위반 신호. cockpit 과 CLI 가 같은 도메인/verb 로직을 두 번 구현하면 위반 — DemiurgeCore 공용 함수로 통일."
  decision_ref = "design.md D50"
  applies_to = "every doc edit touching D-numbers / counts / phase lists; every cockpit or CLI feature carrying domain / verb / record logic"

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
