#!/usr/bin/env tape
# AGENTS.tape — Demiurge project governance (SSOT for load-bearing rules)
# tape v1.2. Decision audit trail = design.md (D1..). This file = the
# enforced governance an agent must obey in this repo.

@V := "tape" :: spec [active]
  version = "1.2"

@D g_stdlib_ownership := "stdlib ⊂ hexa-lang ONLY" :: governance [required d=2026-05-18 active]
  rule = "The `stdlib/` namespace belongs EXCLUSIVELY to hexa-lang. demiurge is a *consumer* of hexa-lang stdlib — it MUST NOT own or carry a `stdlib/` tree."
  demiurge_role = "가져다 쓰는 쪽 (consumer). Absorbed/re-derived reusable hexa-native modules belong in hexa-lang/stdlib/ (rfc_047/048 precedent), referenced from demiurge."
  user_directive = "2026-05-18 — 'stdlib 은 오로지 hexa-lang 이 보유 · demiurge 는 가져다쓸분' · 2026-05-19 REAFFIRMED — 'hexa-lang = SSOT, demiurge = pointer; 모든 stdlib 는 hexa-lang 소유'"
  general_principle = "hexa-lang is the SSOT of ALL stdlib AND every reusable absorbed module. demiurge is a consumer / pointer ONLY — it references the SSOT, never owns it. This generalizes beyond `stdlib/`: any reusable hexa-native module re-derived during an absorption (rfc_003/006 pattern) lands in hexa-lang, and demiurge carries a typed-interface pointer (the D17 hexa-matter precedent — SSOT=hexa-lang, demiurge=consumer-pointer)."
  violation_resolved = "design.md D15 applied 2026-05-18: the 6 modules + .stubs migrated to hexa-lang/stdlib/booksim/ (committed hexa-lang d5a63a82, self-tests re-verified GREEN there, unpushed pending hexa-lang review); demiurge/stdlib/ git-rm'd. demiurge now carries NO stdlib/ tree — rule satisfied. rfc_003 references the hexa-lang location."

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

@N ssot := "where governance + decisions live" :: note [d=2026-05-19 active]
  governance = "this AGENTS.tape (enforced rules + @F denies)"
  decisions = "design.md D1..D41 (gated decision audit trail; D15 stdlib ownership, D16 macOS Swift surface, D17 hexa-matter SSOT=hexa-lang, D18 Yosys ABC bounded-subprocess, D19 yosys impl belongs to hexa-lang session, D20 materials→chip seam rfc_007, D21 component = new top-level domain, D22 Phase-4 cockpit spec rfc_009 — build OOS, D23 brand mark = Demiurge / 데미우르지 (paired with Phanes), D24 rename scope = mass replace excl. records, D25 GitHub repo = in-place rename to dancinlab/demiurge, D26 swift = native + canonical patterns first, D27 cockpit lives in cockpit/ subdir of demiurge — logical boundary not physical, D28 cockpit bootstrap = SwiftPM Package.swift only — measured-green, D29 first feature slice = F1F2 viewer + ProvenanceBanner — measured-green compile + data-flow + user-side render proof, D30 file picker = NSOpenPanel pinned to f1f2RecordsRoot + Loader runtime invariant a, D31 rfc_010 cockpit-architecture spec, D32 artifact token format = sequential per type ($R<n>/$D<n>/$RFC<n>/$DOM:<name>), D33 LEFT tree grouping = by type, D34 control surface mutation scope = split (cockpit GUI 직접 + CLI = AI-agent surface) enforced by @D g_ai_agent_action_surface, D35 3D viewer framework = RealityKit (mouse-drag rotate only), D36 hexa-bio cockpit treatment = sibling repo seam record consumer view only (no internal Bio mode), D37 Chat panel location = LEFT 1st tab (LEFT TabView), D38 AI agent backend = Claude Code CLI + API dual dispatch enforced by @D g_ai_agent_chat_surface, D39 RIGHT 1st tab = Inspector / Provenance verbatim, D40 layout shape = 4-zone tabbed (TOP toolbar + LEFT TabView + CENTER canvas + RIGHT TabView), D41 boundary read scope clarification — records strict (a-records) + navigation docs read-only (a-docs), D42 cockpit = project workbench 3-column layout (rfc_012 §5), D43 + button = top toolbar project-creation flow, D44 'what to design' = free text → AI infers domain → user confirms, D45 project data model = manifest in App Support + records via AI agent (g_cockpit_isolation gains app-state clause e), D46 plain-language layer + expert toggle, D47 project↔records = own-only + reference view, D48 verb develop = conversation-default + θ-2 for real runs; rfc_011 = control surface spec (D32..D40), rfc_012 = project workbench spec (D42..D48))"
  arch_why = "CHARTER.md + HANDOFF.md (reconciled to D22 on 2026-05-19)"
  goal = "GOAL.md (한 문장 north-star + 정직한 현 위치)"
  progress = "PLAN.md (append-only log)"
  index = "ARCH.tape"

@N n_cockpit_ar_target := "cockpit 3D viewer targets AR / visionOS portability" :: note [d=2026-05-19 active]
  text = "The cockpit's 3D viewer (phase ι — `ComponentView3D`, the exploded-isometric ComponentMode) uses RealityKit (D35) specifically so it can port to AR / visionOS spatial rendering. RealityKit was picked over SceneKit for exactly this forward path — visionOS is RealityKit-native. On macOS the cockpit runs a plain virtual `ARView` viewport with mouse-drag orbit (v0, measured-green); AR / visionOS spatial is the stated future target — new platform surfaces reuse the same RealityKit scene graph."
  decision_ref = "design.md D35 · rfc_011 §9"
  user_directive = "2026-05-19 — 'AR/visionOS 지원 목표로 하자 AGENTS.tape 기록'"
