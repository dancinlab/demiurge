# NEXT_SESSIONS — copy-paste session-pickup prompts

> 2026-05-19 · demiurge repo at `c1805fe`+ — 4-Phase design-complete
> AND the macOS cockpit workbench built (rfc_012 IMPLEMENTED, cockpit
> phases κ-1..κ-10; live progress = PLAN.md, decisions = design.md).
> Forward-handoff prompts below — each **0-context cold-readable**.
> Pick whichever; they are independent. P-⑤ is ✅ DONE; P-②③ / P-④
> are cross-repo / heavy sessions; P-⑥ closed; P-⑦ is the open
> demiurge-only workbench follow-ups.
>
> g3 discipline carried into each prompt: every gate is named; every
> "absorbed/parity/resolved" claim is explicitly forbidden until a
> cited measurement; what NOT to do is stated, not implied.

---

## P-②③ — hexa-lang session (Yosys modules + booksim push)

**Use this when:** you open `~/core/hexa-lang` to do the D19 work +
push `d5a63a82`. An inbox handoff is **already filed** in hexa-lang:
`inbox/notes/2026-05-19-demiurge-rfc006-yosys-handoff.md` +
`inbox/PATCHES.yaml` entries `stdlib-booksim-rederive-from-hexa-
arch-rfc003` (pending) and `comb-cite-demiurge-rfc002-f1f2`
(applied — corrects the earlier mis-statement that this was
unpushed). Read that note first; the prompt below cold-starts the
session.

```
hexa-lang session — actuate the demiurge handoff (D19 + booksim push).
Repo: ~/core/hexa-lang · branch: rfc043-hexa-torch (ahead 18,
unpushed). Read `inbox/notes/2026-05-19-demiurge-rfc006-yosys-
handoff.md` first — it carries the full context.

Two jobs (do them in order):

① PUSH the booksim absorb commit.
   - SHA `d5a63a82` `feat(stdlib/booksim): absorb NoC-sim re-
     derivation modules from demiurge (rfc_003)` — 14 files,
     +4005, pure stdlib/booksim/ (leaf, transpile-only).
   - Already tracked: PATCHES.yaml id
     `stdlib-booksim-rederive-from-demiurge-rfc003` status `pending`.
   - Review the diff vs demiurge/proposals/rfc_003 + D15 (stdlib ⊂
     hexa-lang ONLY). Push the branch.
   - Run `hexa tool/inbox_sync.hexa` — the entry should flip toward
     `applied` once the push lands and source_files verify.

② IMPLEMENT rfc_006 §4 Yosys modules into stdlib/yosys/.
   - Read `~/core/demiurge/proposals/rfc_006_yosys_absorption.md`
     §4 (module list) and §5 (measured gate). Do NOT re-litigate
     decisions D15/D18/D19 — they are committed, cited.
   - 7 modules, clean-room, hexa-native, into hexa-lang/stdlib/yosys/:
     `rtlil`, `read_verilog`, `passes`, `liberty`, `abc_map`,
     `write_verilog`, `yosys` (dispatcher). Each: `#!hexa strict`,
     clean-room provenance header, per-fn `// CLEAN-ROOM`,
     `fn main()` self-test, `exit(91)` fail-loud (rfc_003 idiom).
   - **ABC path: D18 = (7a) bounded-subprocess.** Re-derive the
     Yosys flow hexa-native; invoke ABC as a documented absorbed-
     substrate subprocess with fail-loud (rfc_048/D14 hybrid g5
     exception, AGENTS.tape g_hexa_native-sanctioned). Do NOT
     attempt a full ABC clean-room re-derivation (7b was explicitly
     rejected — ≫10× rfc_003, would stall everything).
   - Toolchain limits to expect (rfc_003 finding): no `match`,
     enum-equality broken, no tuples — use int/struct idioms +
     dispatcher.

Gate (g3 — REQUIRED, cannot be skipped):
   "Yosys absorbed" may be claimed ONLY when the flow synthesizes
   comb router_d4.v + router_d6.v against SKY130 `sky130_fd_sc_hd`
   and reproduces the cited area oracle within ±5%:
     d4 ≈ 61,762.99 µm² · d6 ≈ 93,608.53 µm² · ratio 1.5156×
   Filed in PLAN.md with cited numbers, with `provenance.absorbed`
   flip recorded. Until then: GATE_OPEN, no "absorbed" anywhere.

NOT:
   - Do not claim Yosys absorbed before the gate. Do not assert
     parity from partial coverage. Do not silent-skip a failing
     case (`@F f4`).
   - Do not carry stdlib under demiurge (`@F f1` — D15).
   - Do not start ABC full re-derivation in this session (D18=7a).

Exit criterion (any one suffices to end the session honestly):
   (a) modules + selftests landed + gate PASS filed, OR
   (b) modules + selftests landed + gate result honestly recorded
       (PASS / partial / FAIL with diff numbers — never silent), OR
   (c) scope-bounded progress + honest "next pickup" note appended
       to the same inbox handoff (lifecycle pattern).
```

---

## P-④ — chip measurement session (`GATE_B_PINNED_MET` → measured)

**Use this when:** you have ubu-pool resources + time + explicit
authorization for a large gated execution. The previous §9 sweep +
OpenROAD attempts were rate-limit-killed twice (session history) —
this session needs to be planned for that risk.

```
demiurge chip measurement session — close GATE_B_PINNED_MET to
measured parity for the NoC §B full-curve and (if scoped) §D.
Repo: ~/core/demiurge (records land here, D7 producer-owned).
Implementation: ~/core/hexa-lang/stdlib/booksim/ (D15 — modules in
hexa-lang, demiurge consumes/records).

Current state (do not over-claim — measured by Agent-1 baseline only):
   chip §B = GATE_B_PINNED_MET (pinned baseline only, model-simplified):
   d6 hex beats d4 mesh at a SINGLE point (4 GHz, 22 nm, axial-hex
   square placement). full-curve parity NOT measured. §D NOT done.
   provenance.absorbed = false everywhere. rfc_001 §9 has 3 open
   questions live. (Source: rfc_001 §8, design.md D9.)

Job (scope-as-you-can, honest staging):
   (a) Expand the §B sweep beyond the pinned point — multi-frequency
       (1..6 GHz), multi-node (7nm/22nm), additional traffic patterns,
       d4 mesh vs d6 hex pairs. Land each as a F1F2 record under
       `exports/chip/noc/f1f2/pair_verdicts/` (rfc_002 v1.0 schema)
       with full provenance block + GATE state + citations.
   (b) When (a) reproduces the regime claim across the curve (or
       refutes it — equally valuable, g3), flip §B to
       GATE_CLOSED_MEASURED in PLAN.md with cited record IDs.
   (c) §D = the unique-to-hex case (e.g., axial-coordinate-only
       benefit invisible to mesh) — separate scope, separate gate;
       optional this session.

Resources / risk (read before starting):
   - ubu pool: summer@ubu-2 (linux). Heavy bash auto-routes there.
     Pool does NOT sync filesystems — local file edits are not
     visible on ubu until the user syncs. Plan around this.
   - Rate-limit history: the §9 sweep + OpenROAD/T3 were each
     killed by rate-limits twice in prior sessions. Use detached
     nohup runners for long sweeps; checkpoint after every N
     records; do NOT run a single 100-record sweep in one agent
     call.
   - OpenROAD binary is on ubu-1 (built earlier). If you need §D
     post-P&R records, run there.

NOT (g3 — non-negotiable):
   - Do not claim provenance.absorbed = true on any record without
     a measured gate filed + cited.
   - Do not skip a failing config silently. A failure IS a finding;
     record it.
   - Do not fabricate records or extrapolate "the curve continues
     this way" without measurement.
   - Do not declare "regime" from a small N. State the N you have.
   - Do not edit chip §B's GATE state in PLAN/design.md until the
     curve is in.

Exit criterion (any one ends the session honestly):
   (a) §B full-curve measured + GATE flipped + records cited, OR
   (b) Bounded sub-sweep landed + honest gap stated + next pickup
       note appended to PLAN.md.
```

---

## P-⑤ — macOS Swift cockpit build session (rfc_009) — ✅ DONE

**Status:** executed. `cockpit/` is a built SwiftPM package — the
rfc_009 viewer AND the rfc_012 workbench (phases κ-1..κ-10) are
measured-green and installed as `/Applications/demiurge.app`. Live
progress = PLAN.md κ-phase log. The original build prompt is kept
below for history.

**Original prompt (history — rfc_009 viewer build):** Per D22 the
build was OUT of scope of demiurge's design session — this was the
dedicated downstream build session against
`proposals/rfc_009_product_surface_macos_cockpit.md` §2–§6.

```
demiurge macOS Swift cockpit build session — implement rfc_009.
Spec: ~/core/demiurge/proposals/rfc_009_product_surface_macos_
cockpit.md (read §2–§6, decisions D16/D22).

Where the app lives (you decide first, then commit to it):
   Recommended: a NEW sibling repo `~/core/demiurge-cockpit/`
   (clean separation — rfc_009 §5 places the app OUTSIDE demiurge's
   governance boundary so g5 stays unpressured). Alternatives:
   a top-level `cockpit/` dir in demiurge (also fine; the boundary
   is governance-defined, not directory-defined). Decide and record
   the choice as a design.md decision before writing code.

The job (read rfc_009 §2..§7; this prompt restates the anchors):
   - Pure SwiftUI macOS app. Codable structs 1:1 with rfc_002 (F1F2),
     rfc_007 (mat→chip seam v0), rfc_008 (chip→component seam v0).
     `null` in JSON -> Swift Optional.
   - Read-only from `~/core/demiurge/exports/**` (Files-app picker
     or a recorded path). NO net, NO auth, NO DB, NO server.
   - 7-verb workflow as the spine (rfc_009 §3 ASCII): SPECIFY -> ...
     -> HANDOFF with ANALYZE as a visible iterate-back loop. Domain
     picker (15 domains, plugin model). Chain canvas (rfc_004 §4).
   - HONESTY = the product feature (rfc_009 §4 — this is the
     differentiator, not decoration). Every output cell renders,
     VERBATIM from the producer's provenance block:
       absorbed (true/false) · measurement_gate (GATE_OPEN /
       GATE_B_PINNED_MET / GATE_CLOSED_MEASURED) · citations.
     Missing provenance => red REJECTED card (mirrors AGENTS.tape
     @F f4 fail-loud).
   - Forward-compat: pin schema_version per artifact; unknown extra
     keys IGNORED (rfc_002 §6 idiom); v0 seams display a "DRAFT
     v0 — upstream unpinned" badge.

HXC v2 wire form:
   The schemas note `v*.hxc` will be generated when the demiurge
   HXC tool lands. Until then the app reads JSON. Do NOT block the
   build on HXC; design the Codable layer for either.

NOT (g3 — non-negotiable):
   - The app NEVER upgrades a measurement_gate / absorbed claim.
     It renders the producer's claim verbatim. No optimistic UI
     shortcuts.
   - The app NEVER mutates exports/. Strict read-only.
   - Do NOT embed a web stack (WKWebView for HTML chrome, etc.) —
     SwiftUI native only (rfc_009 §5: g5 boundary unpressured).
   - Do NOT claim "cockpit complete / Yosys absorbed / chain wired"
     in commit messages until the underlying gates are actually
     flipped in demiurge's PLAN.md.

Exit criterion:
   A built .app that opens a local demiurge checkout's exports/,
   renders the F1F2 records with provenance/gate banners visible,
   and renders the two v0 seams as DRAFT contract-only edges
   (empty records honestly shown — NOT faked). Anything beyond is
   bonus; the honest minimum IS the differentiator.
```

---

## P-⑥ — cockpit remaining phases (η-2 / θ / ι / γ-2 / δ-2)

▎ When: cockpit/ is built (phases α/α-2/α-3/β/γ/δ/η-1 measured-green
▎ as of commit 56f900a). This handoff closes the phases that this
▎ session could NOT close measured-green because they need an
▎ external dependency or downstream data. They are NOT incomplete
▎ work to "finish now" — each is genuinely gated.

demiurge cockpit session — finish the rfc_011 phase plan.
Repo: ~/core/demiurge · cockpit/ is a SwiftPM package (CockpitApp
GUI + DemiurgeCLI + DemiurgeCore library). Read `proposals/
rfc_011_cockpit_control_surface.md` §4/§6/§9/§10 first; the phase
plan is §10.

State as of 50e9a41 (all measured-green, swift run verified):
  α    NavigationSplitView 3-pane shell
  α-2  4-zone tabbed (LEFT/RIGHT TabView + TOP toolbar)
  α-3  DemiurgeCLI + DemiurgeCore library extraction
  β    Artifacts tab populated (50 records · 41 D · 11 RFC · 15 dom)
  γ    Decision-block extraction in CENTER
  δ    Inspector sub-tabs (Provenance + Raw JSON for F1F2)
  η-1  Chat tab UI
  θ    chat → Claude Code CLI subprocess dispatch

CLOSURE STATUS (2026-05-19, goal "NEXT_SESSIONS.md 100% closure") —
the five P-⑥ items, each now in a definite state:

① η-2 — Claude Code API conversational backend.
   CLOSED (merged into θ). The `claude` binary is on PATH, and the
   Claude Code CLI serves conversational prompts too — so D38's
   dual-dispatch (API + CLI) collapses onto the single CLI backend.
   No ANTHROPIC_API_KEY needed; a separate API path is redundant.

② θ — chat → Claude Code CLI dispatch.
   CLOSED — measured-green, commit 50e9a41. sendChat() spawns
   `/usr/bin/env claude -p "<guarded-prompt>"` via Process; the
   read-only prompt prefix + no inherited `--dangerously-skip-
   permissions` + print-mode-cannot-answer-permission keep the
   cockpit a trigger+viewer (no silent synthesis — g3 / @F f6).
   REMAINING as θ-2 (a real future session): scoped-tool-permission
   action dispatch where the agent actually emits a record to
   ../exports/** and the chat renders its provenance banner. θ-2
   carries the rate-limit / detached-runner discipline of P-④.

③ ι — RealityKit 3D viewer (ComponentMode).
   viewer SHELL: CLOSED — measured-green. `ComponentView3D`
   (RealityKit `ARView` + procedural 5-layer exploded box stack +
   mouse-drag orbit, D35) renders when `$DOM:component` is selected.
   It is explicitly labelled PLACEHOLDER geometry (g3). AR/visionOS
   portability recorded — `AGENTS.tape @N n_cockpit_ar_target`.
   REMAINING as ι-2: load a REAL USDZ/STL — gated on downstream
   DATA, since `../exports/**` holds zero geometry records; the
   `component` domain (D21) producer (FreeCAD / KiCad / StepUp
   chain) must emit one first. Aesthetic target on file:
   `cockpit/references/bipv-module-exploded-isometric.jpg`.

④ γ-2 — full per-kind Artifact protocol cards.
   RESOLVED — not pursued. γ's kind-aware MarkdownView (Decision-
   block extraction + whole-file for RFC/Domain) already provides
   functional per-kind rendering. A separate `Artifact` protocol +
   DecisionCard/RFCCard/DomainCard structs (rfc_011 §5.1 sketch)
   is premature abstraction (andrej-karpathy minimum-new-structure).
   γ is final; revisit only if a concrete need appears.

⑤ δ-2 — Inspector Data / Citations / DEPENDENCIES sub-tabs.
   RESOLVED (scope-reduced). Data = redundant with the CENTER
   RecordView; Citations = `provenance.atlas_cite_block` is already
   rendered verbatim by ProvenanceBanner in the δ Provenance
   sub-tab. Only DEPENDENCIES (citation-graph cross-ref scanner)
   remains genuinely unbuilt — folded into phase ζ (rfc_010
   filters/deps), not a δ-2 of its own.

NET: P-⑥ (viewer phases) is closed. SINCE THEN the cockpit became a
project workbench — rfc_012 IMPLEMENTED, phases κ-1..κ-10 (3-column
workbench · manifest persistence · ingredient shelf · verb progress ·
chat↔verb · θ-2 action skeleton · §4.2 REJECTED guard · canvas mode ·
UX polish · SSOT single-source · CLI↔Project parity). θ-2's mechanism
skeleton landed (κ-5, D49) — it reports "no engine tool" honestly
(g3). Genuinely-open cockpit work now = P-⑦ below (demiurge-only
workbench follow-ups) + ι (3D data gate) + the engine-tool gap
(P-②③). See PLAN.md for the live κ-phase log.

---

## P-⑦ — workbench follow-ups (demiurge-only, no external dependency)

**Use this when:** you continue the cockpit workbench. These are the
demiurge-only follow-ups left after κ-1..κ-10 — each builds in this
repo; no cross-repo, no engine tool needed.

```
demiurge cockpit workbench follow-up session.
Repo: ~/core/demiurge · cockpit/ SwiftPM package. Read
proposals/rfc_012_project_workbench.md (IMPLEMENTED) + PLAN.md
κ-phase log first. design.md D42..D50 are committed — cite, do
not re-litigate.

Open follow-ups — closed (κ-11..κ-16, 2026-05-19):
  ✅ ingredient shelf real data — κ-11 (domains/*.md §6 SSOT +
     DomainCatalog 14 + chip + matter)
  ✅ REJECTED guard hardening — κ-12 (overclaims = mentionsClaim +
     !hasMeasuredBacking against real exports/ gate)
  ✅ expert-mode depth — κ-13 (ProvenanceBanner / RecordView expertMode
     + MeasurementGate plainLabel / plainGlyph in DemiurgeCore)
  ✅ phase ζ — κ-14 record gate filter (dependency-graph half
     deferred — workbench value vs UI cost unclear; reopen on a
     concrete use)
  ✅ + CLI θ action — κ-15 (ActionDispatch in DemiurgeCore;
     `demiurge cli action <verb>` byte-identical to cockpit
     "▶ 실제로 돌리기")
  ✅ + sibling-repo awareness — κ-16 (Domain.siblingRepoPath /
     siblingRepoExists; NewProjectSheet + `cli show-project` surface
     `~/core/hexa-<domain>` existence — P-⑧ groundwork)

Honesty (g3 — non-negotiable):
  - the workbench frame is live but carries ZERO measured records
    (no engine tool); do NOT add UI that implies measurement.
  - every cockpit edit: `swift run CockpitApp` measured-green
    before commit; reinstall via `demiurge install`
    (@D g_cockpit_reinstall).
  - cockpit and CLI share DemiurgeCore functions — no duplicated
    switch (@D g_ssot_single_source / D50).

Exit criterion: a follow-up landed measured-green + PLAN.md log +
reinstall, OR an honest "next pickup" note.
```

---

## P-⑧ — hexa-* 검증 라이브러리 (workbench 완성 후)

**Use this when:** the workbench + a real engine tool are in place,
so genuine 7-verb measurements can run.

**User intent (2026-05-19):** once the demiurge workbench is
complete, take **hexa-rtsc · hexa-antimatter · hexa-cern · hexa-ufo**
through demiurge for *real verification runs* (producing measured
records) and turn them into a baseline library.

**hexa-* = sibling repos** — `~/core/hexa-rtsc` ·
`~/core/hexa-antimatter` · `~/core/hexa-cern` · `~/core/hexa-ufo`
(cross-repo, like hexa-lang / hexa-matter). demiurge's `domains/`
has `rtsc` / `antimatter` / `cern` maps; `ufo` has no demiurge
domain map yet. So P-⑧ is a CROSS-REPO verification session — run
each sibling repo's design through demiurge's 7-verb spine and
record the measured result.

**Working definition (provisional — confirm or adjust):**
- "기본 라이브러리" = each `hexa-*` sibling repo's design is run
  through demiurge workbench's 7-verb spine, producing one baseline
  F1F2 record per measured stage; the resulting set lives in
  `exports/<domain>/baseline/` and serves as the demiurge-bundled
  proof that the workbench measures real engineering designs (not
  toys). The set itself is the "library". Adjust this definition any
  time — it is provisional, not locked.

g3: none of the four may be called "verified" until a real 7-verb
measurement record + gate exists — this depends on an engine tool
(the same gap as P-②③ / P-④), so P-⑧ is a *post-completion* session.

---

## Cross-cutting notes (apply to all sessions)

- demiurge decisions are committed (design.md = the decision SSOT;
  do NOT copy the D-range into a session prompt — @D
  g_ssot_single_source / D50). Cite them; do not re-litigate. New
  session-specific decisions go into that session's repo's
  design.md / decision SSOT.
- The repo's append-only PLAN.md / `## 진행 로그` is the progress
  SSOT — every meaningful step gets a dated entry.
- `AGENTS.tape` carries the enforced governance — `g3_no_over_claim`
  is RETAINED (the user declined removal); `@F f1..f5` denies are
  hard.
- If a session ends without hitting its exit criterion, append a
  "next pickup" note to the same handoff path (or this file's `##
  Log`). Don't lose the thread.

## Log

- 2026-05-19 — created. 3 forward-handoff prompts (P-②③ hexa-lang
  yosys+push, P-④ chip measurement, P-⑤ Swift cockpit build).
  Each is 0-context cold-readable, names its gate, and forbids the
  matching over-claim path. Companion to `HANDOFF.md` §10 RESUME
  (which is the *demiurge session* pickup; this file is for the
  three downstream sessions demiurge's 4-Phase design enables).
- 2026-05-19 — **P-⑤ partially executed + P-⑥ added.** The cockpit
  build session (P-⑤) was actually run this session: cockpit/ is a
  built SwiftPM package — phases α / α-2 / α-3 / β / γ / δ / η-1 all
  measured-green (`swift run` verified, commits e601e5b → 56f900a).
  The remaining phases were handed off as **P-⑥**.
- 2026-05-19 — **P-⑧ added** (user intent). Once the workbench is
  complete, hexa-rtsc / hexa-antimatter / hexa-cern / hexa-ufo are to
  be run through demiurge for real verification → a baseline library.
  Recorded as a post-completion handoff.
- 2026-05-19 — **P-⑧ updated** — user confirmed the four are sibling
  repos under `~/core/hexa-*` (cross-repo, like hexa-lang). `hexa-ufo`
  TBD resolved (sibling repo, no demiurge domain map yet). One TBD
  remains: the exact form of "기본 라이브러리".
- 2026-05-19 — **P-⑦ all closed** (κ-11..κ-16). Open follow-ups
  marked ✅; the ζ dependency-graph half stays deferred (workbench
  value unclear). sibling-repo awareness added as κ-16 —
  `Domain.siblingRepoPath` / `siblingRepoExists` in DemiurgeCore, and
  NewProjectSheet + `cli show-project` surface the `~/core/hexa-
  <domain>` pointer (P-⑧ groundwork). **P-⑧ working definition** for
  "기본 라이브러리" landed (`hexa-*` × 7-verb → `exports/<domain>/
  baseline/`) — provisional, awaiting user confirm. D / E / F
  unchanged: `d5a63a82` still unpushed (hexa-lang session), chip §B
  still GATE_B_PINNED_MET, exports/ holds zero USDZ.
- 2026-05-19 — **cockpit workbench built (κ-1..κ-10) + P-⑦ added.**
  After P-⑥ closed, rfc_012 (project workbench) was discussed,
  locked (design.md D42..D50), and built as cockpit phases
  κ-1..κ-10 — all measured-green, `/Applications/demiurge.app`
  installed. Header / P-⑤ / P-⑥ NET updated to reflect this; P-⑦
  added for the demiurge-only workbench follow-ups (ingredient-shelf
  real data, REJECTED-guard hardening, expert-mode depth, phase ζ).
  Cross-cutting D-range note pointer-ized per @D g_ssot_single_source.
- 2026-05-19 — **P-⑥ CLOSED** (goal "NEXT_SESSIONS.md 100% closure").
  θ landed measured-green (commit `50e9a41` — chat → `claude -p`
  subprocess dispatch). The other four P-⑥ items reached a definite
  state: η-2 merged into θ (the `claude` CLI covers conversational
  prompts — no separate API path needed); γ-2 resolved (γ's
  kind-aware MarkdownView is functional; a full Artifact protocol is
  premature abstraction — not pursued); δ-2 resolved scope-reduced
  (Data redundant, Citations already in ProvenanceBanner,
  DEPENDENCIES → phase ζ); ι held open on a downstream-DATA gate
  (zero USDZ/STL records in exports/ — opens when a component-domain
  producer emits geometry). NET: every P-* in this file is now in a
  definite terminal state — P-②③ / P-④ are cross-repo / heavy
  sessions correctly handed to their own sessions; P-⑤ executed;
  P-⑥ closed. Genuinely-open cockpit work = θ-2 (scoped-tool action
  dispatch) + ι (3D data) + ζ (filters/dep-graph), each with a
  definite gate. Nothing silently unfinished.
