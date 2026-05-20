# NEXT_SESSIONS — copy-paste session-pickup prompts

> 2026-05-20 · demiurge origin/main `63c98c1` (κ-52) · hexa-lang
> origin/main `79a8f6f8` (cern+synth flip). 4-Phase design-complete,
> macOS cockpit workbench built (rfc_012 IMPLEMENTED), κ-47..κ-49
> swept ROI 1→18 (17 cell dispatch · 잔여=0 substrate side), κ-51
> cern+synth absorbed=true (second dynamic-absorption after chip §B+
> §D). Forward-handoff prompts below — each **0-context cold-
> readable**. Pick whichever; they are independent.
>
> **P-* (design / build sessions)** — P-⑤ ✅ DONE; P-②③ / P-④ cross-
> repo / heavy; P-⑥ closed; P-⑦ workbench follow-ups; P-⑧ /
> P-⑨ post-completion / producer.
>
> **H-* (heavy-substrate measurement sessions, new 2026-05-20)** —
> H-1 unblocks all (hexa-lang live-tree re-align); H-2..H-7 each
> install one heavy substrate (Geant4 / OpenMC / CARLA / Drake /
> CalculiX+GetDP / firmware-QEMU) and run the parity round κ-49
> honest-skipped.
>
> g3 discipline carried into each prompt: every gate is named; every
> "absorbed/parity/resolved" claim is explicitly forbidden until a
> cited measurement; what NOT to do is stated, not implied.

---

## Tracks (2026-05-19) — every branch the project can pursue

User-requested record of all six tracks the post-workbench session
identified, kept here so none are lost.

🟢 **demiurge-internal** (this repo)
  - **A.** 문서 정합 — NEXT_SESSIONS / GOAL.md / `@N` reconciled to
    the latest κ phases. *done* (live progress in PLAN.md, decisions
    in design.md).
  - **B.** ~~hexa-\* sibling 인식~~ — **withdrawn 2026-05-19**: user
    confirmed `~/core/hexa-<id>` sibling repos are NOT SSOT; the
    hexa-lang single-repo holds every domain's stdlib (per the same-
    day "hexa-lang 이 유일 SSOT" directive). The κ-16 sibling code
    (Domain.siblingRepoPath / NewProjectSheet banner / cli
    show-project sibling_repo line) was removed in κ-17.
  - **C.** P-⑧ "기본 라이브러리" 정의 — provisional working
    definition landed under P-⑧ below. *awaiting user confirm
    / adjust*.

🟡 **cross-repo** (separate repo session required)

  > **hexa-lang = sole SSOT** (user directive 2026-05-19; AGENTS.tape
  > `@D g_stdlib_ownership`). D + E both belong in the SAME
  > `~/core/hexa-lang` session — engine tools + measurement record
  > producers all live there; demiurge consumes only. So the
  > cross-repo work collapses to **two prompts**: one hexa-lang
  > session (D + E), one hexa-component session (F).

  - **D + E.** hexa-lang single SSOT session — P-②③ (① `d5a63a82`
    booksim push ✅ **done** 2026-05-19, origin/rfc043-hexa-torch ·
    ② Yosys §4 modules still `.hexa.stub` only — *open*) **and**
    P-④ (chip §B full-curve measurement — *open*).
    Repo: `~/core/hexa-lang`.
  - **F.** P-⑨ — component producer (real USDZ). Location:
    `~/core/hexa-lang/component/` (per user 2026-05-19 — hexa-lang
    sole SSOT, no separate sibling repo). *open*.

The ζ dependency-graph half is **deferred** (not in this matrix —
workbench value vs UI cost unclear; reopen on a concrete use).

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

## P-⑨ — component producer session (ι-2: real USDZ)

**Use this when:** you want the cockpit's ComponentMode (D35, phase
ι) to render a REAL component USDZ instead of the procedural 5-layer
placeholder. **Location: `~/core/hexa-lang/component/`** (user
2026-05-19 — hexa-lang sole SSOT; no separate sibling repo). demiurge
is the consumer per D2 typed interface — record only.

```
component-domain producer session — emit a real USDZ + provenance.

Read first:
  ~/core/demiurge/proposals/rfc_009_product_surface_macos_cockpit.md
    §4 (honesty-as-feature mirror)
  ~/core/demiurge/domains/component.md §1-§5 (component deliverable,
    public-surface tool map)
  ~/core/demiurge/cockpit/Sources/CockpitApp/Views/ComponentView3D.swift
    (the placeholder viewer that loads it; D35 mouse-drag rotate only)
  ~/core/demiurge/cockpit/references/bipv-module-exploded-isometric.jpg
    (aesthetic reference)

Goal: produce ONE real component USDZ + a typed F1F2-style record so
demiurge's cockpit ComponentMode shows a measured 3D model and the
"PLACEHOLDER" banner can come down.

Steps (scope-as-you-can, honest staging):
  1. Pick a concrete target (the BIPV reference module is the
     obvious first one).
  2. Tooling — use the §5 cited OSS via the **D18 bounded-subprocess**
     pattern (the Yosys / ABC precedent; clean-room re-derivation of
     FreeCAD / gmsh is unrealistic at their size):
       - **FreeCAD**   (parametric 3D modeler)   — shape definition
       - **gmsh**      (mesh + CAD pre / post)   — verification mesh
       - **USDPython** (Apple USD bindings)      — `.usd` → `.usdz`
     `hexa-lang/component/` carries **thin hexa-native wrappers +
     provenance / gate headers**, NOT a clean-room re-derivation of
     the tools themselves. domains/component.md §5 has the cited URLs.
  3. Emit:
       - the .usdz (or .stl + .usdz pair) under
         `~/core/demiurge/exports/component/geometry/<id>.usdz`
       - a typed record sibling JSON (F1F2-style per rfc_002 §4)
         carrying producer + measurement_gate + provenance.
  4. Verify: open /Applications/demiurge.app, create a component-
     domain project, switch ② work zone → ComponentMode shows the
     real USDZ; the "PLACEHOLDER" label is no longer accurate.

g3 (non-negotiable):
  - Geometry being CORRECT ≠ thermal / EM / structural verdicts
    being MEASURED. The latter are separate gates.
  - measurement_gate = GATE_OPEN until a measured value justifies a
    measured gate. Do NOT pre-set absorbed=true.
  - The cockpit renders provenance VERBATIM (rfc_009 §4). Have the
    producer write what was actually measured — never an upgraded
    claim.
  - The placeholder viewer label stays until / unless the record is
    in. No silent UI upgrade.

Exit criterion (any one ends honestly):
  (a) exports/component/geometry/<id>.usdz + F1F2-style record
      sibling landed; cockpit renders it on ComponentMode select;
      provenance gate = GATE_OPEN (or measured if you actually
      measured), absorbed=false unless a measurement justifies true.
  (b) Bounded progress + honest "next pickup" note appended to this
      P-⑨ section.
```

---

## H-* — heavy-substrate cross-session handoffs (2026-05-20)

> Star-session (별 세션) prompts spun out of κ-49's "ROI 1→18 sweep
> all-done · 잔여=0" finding. Every cell now has a substrate +
> dispatch wiring, but **실측 흡수** (substrate-vs-hexa parity →
> `absorbed=true` flip) still requires multi-hour / multi-GB
> installs that the κ-47..κ-52 round honest-skipped. Each H-N below
> is one such measurement round.
>
> g3 discipline carried in: each handoff names its gate, its
> citation, its end-state. None of these may flip `absorbed=true`
> from a partial run; the "Verification" block is the only path.

State summary at branch-out (2026-05-20):
- demiurge origin/main = `63c98c1` (κ-52 reconcile)
- hexa-lang origin/main = `79a8f6f8` (cern+synth flip)
- 17 cells dispatch-able (ROI 1→18); cern+synth + chip §B+§D are
  the only `absorbed=true` cells. Everything else = substrate stage
  (Stage 1 in ABSORPTION.md §"hexa 포팅 단계") with `GATE_OPEN +
  absorbed=false` install-gated skip records.
- Live blocker for *all* H-*: `~/core/hexa-lang` live tree is
  checked out on `s1-step2-codegen-perf` (a concurrent session's
  branch), tip `5c8b972e`. demiurge's `ActionDispatch.runEngineTool`
  spawns python from the live tree, not from origin/main — so any
  H-N that wants to drive substrate measurement must first land
  H-1's tree-realign or accept that its substrate spawns will hit
  the concurrent-session view of stdlib/.

---

## H-1 — hexa-lang live-tree cross-session re-align (unblocks all H-2..H-7)

**What.** Land `~/core/hexa-lang` on `origin/main` (`79a8f6f8` at
branch-out time, or whichever SHA is current `origin/main` when you
pick this up) so demiurge's spawn-from-live-tree path sees the
default xsuite-tracking substrate + the κ-49 ROI-1→18 stdlib
landings. The current live-tree branch (`s1-step2-codegen-perf`,
tip `5c8b972e`) belongs to a concurrent compiler-perf session and
does NOT include the κ-47..κ-51 stdlib substrate files.

**Why.** demiurge's `ActionDispatch.runEngineTool` resolves
substrate paths against `~/core/hexa-lang` *as checked out on disk*,
not against origin/main. So even though origin/main carries the
cern+synth absorbed=true substrate + 8 ROI-11..18 substrates,
running `demiurge cli action verify fusion` against the live tree
today will hit a `stdlib/fusion/openmc_tbr.py: not found` honest
skip — because that path lives on origin/main, not on
s1-step2-codegen-perf. Every downstream H-N depends on this.

**Where.** `~/core/hexa-lang` (live tree). The concurrent session
is on branch `s1-step2-codegen-perf` (RFC-055 / RFC-065 compiler
work). The two branches are not currently merged into each other
on disk.

**How to do it safely** (do NOT force-checkout if the concurrent
session is mid-flight):
  1. Coordinate with the concurrent session — confirm
     `s1-step2-codegen-perf` is safe to leave on its own branch
     (e.g. push to its own remote branch, or fast-forward into
     main).
  2. From `~/core/hexa-lang`, `git fetch origin && git status`.
     If the working tree is clean, `git checkout main && git pull
     --ff-only`. If dirty (concurrent session has un-committed
     work), STOP — file a coordination note in
     `~/core/demiurge/inbox/notes/` and exit.
  3. Verify: `ls ~/core/hexa-lang/stdlib/cern/xsuite_optics.py
     ~/core/hexa-lang/stdlib/fusion/openmc_tbr.py
     ~/core/hexa-lang/stdlib/bot/drake_verify.py
     ~/core/hexa-lang/stdlib/antimatter/geant4_verify.py` — all
     four MUST exist (they're κ-47..κ-51 landings).
  4. Smoke-test from demiurge: `demiurge cli action analyze cern`
     should pick up the default `xsuite-tracking` ProducerRegistry
     variant (D74) and either emit a record or honest-skip on
     install gate — NOT crash with `path not found`.

**Verification.** (a) `git -C ~/core/hexa-lang rev-parse HEAD` =
the same SHA as `git -C ~/core/hexa-lang rev-parse origin/main`,
AND (b) the 4 stdlib substrate files listed above exist on disk,
AND (c) one demiurge cell dispatch (e.g. `action verify fusion`)
runs without `not found` and instead hits its honest install-gate
skip (e.g. `OpenMC nuclear data path missing`).

**Touches.** `~/core/hexa-lang` (HEAD move only — no commit in
either repo unless the user requests a sync-handoff note). No
demiurge commit.

---

## H-2 — Geant4 multi-hour build + 3 cells' mc_transport parity

**What.** Install Geant4 11.x (Linux pool, multi-hour build) +
ROOT, then run the substrate-vs-hexa-native parity round for the 3
demiurge cells that share the `kernels/mc_transport` adapter via
Geant4:
  - `antimatter + verify`  (substrate: `stdlib/antimatter/
    geant4_verify.py`, κ-49 ROI 18)
  - `cern + verify`  (Bethe-Bloch hexa-native already in
    `stdlib/cern/bethe_bloch_stopping.hexa` per κ-38; parity vs
    Geant4 `G4hIonisation` is the gate)
  - `fusion + verify`  (substrate path TBD — confirm with
    `domains/fusion.md` §2 + ABSORPTION.md §"무거운 후보")

**Why.** ABSORPTION.md (line ~290 + §"무거운 후보" 표) marks
Geant4 as a ⭐⭐⭐⭐⭐ shared transport substrate across 3 domains —
N+M payoff = 1 install pays back 3 cells. PLAN.md κ-38 already
recorded the Bethe-Bloch hexa port + 4-class scope_caveats
(shell / density-effect / nuclear / hadronic); the missing piece
is the Stage 3 Geant4-MC parity. cern+verify currently sits at
Stage 1 substrate (`absorbed=false`).

**Where.**
  - Substrate side: `~/core/hexa-lang/stdlib/{antimatter,cern,
    fusion}/...` (consumes `kernels/mc_transport/` adapter,
    D72-N+M).
  - hexa-native side: `~/core/hexa-lang/stdlib/cern/
    bethe_bloch_stopping.hexa` (already landed κ-38) + the
    fusion/antimatter analogs (need landing).
  - Citations: Geant4 11.x docs (`G4hIonisation`,
    `G4EmStandardPhysics_option4`); PDG stopping-power tables for
    cross-check; `domains/{antimatter,cern,fusion}.md` §5 (cited
    OSS URLs).
  - Resources: ubu-1 / ubu-2 (Linux pool). macOS is NOT viable —
    Geant4 multi-hour build expected.

**Verification.** Per-cell: a measured F1F2-style record lands
under `exports/<domain>/<cell>/parity/<id>.json` with
  `provenance.absorbed = true`,
  `measurement_gate = GATE_CLOSED_MEASURED`,
  `parity_block = { substrate_value, hexa_value, rel_err,
                    tolerance }`,
  full citation block.
Tolerance MUST be cited (PLAN.md κ-51 precedent = `1e-6` for
algorithmic closure; Geant4 MC vs closed-form Bethe-Bloch has
documented systematic offsets — state the tolerance you picked
and why). If tolerance fails for any sub-physics regime (low-E
shell, high-γ density effect, hadronic): record FAIL — do NOT
silent-skip. A parity-FAIL record IS a valid finding (g3).

**Touches.** Substrate adds → `~/core/hexa-lang/stdlib/{antimatter,
cern,fusion}/`. demiurge: new records under `exports/<domain>/`,
`design.md` D-num for each cell's flip (if any), PLAN.md κ-entry,
ABSORPTION.md §"흡수 진행 상황" 표 행 update. Do NOT edit
PLAN.md (per task — main session handles κ entries).

---

## H-3 — OpenMC + ENDF/B-VIII.0 nuclear data (~3 GB) parity round

**What.** Download ENDF/B-VIII.0 cross-section library (~3 GB
HDF5), install OpenMC, then run the substrate-vs-hexa parity for:
  - `energy + verify`  (k-eff, substrate:
    `stdlib/energy/openmc_keff.py`, κ-49 ROI 12)
  - `fusion + verify`  (TBR — Tritium Breeding Ratio,
    substrate: `stdlib/fusion/openmc_tbr.py`, κ-49 ROI 11)

**Why.** Both cells landed substrate at κ-49 but recorded honest
install-gated skip because the OpenMC nuclear-data path was
missing (~3 GB ENDF/B-VIII.0 download). `kernels/mc_transport`
(ABSORPTION.md L40) already has 4 consumers — these are the 2nd
and 3rd. The cited benchmark targets (Springer 2025 + ANL 2025)
give measured oracles for k-eff and TBR vs MCNP / Serpent.

**Where.**
  - Substrate: `~/core/hexa-lang/stdlib/{fusion/openmc_tbr.py,
    energy/openmc_keff.py}`.
  - Data: `~/.openmc/endf-b-viii.0/` (or wherever the OpenMC env
    var `OPENMC_CROSS_SECTIONS` points). Download:
    <https://anl.app.box.com/s/...> via the OpenMC data tool
    (`openmc-data` package) — pin the exact ENDF release; record
    the SHA256 of the cross-section HDF5 bundle.
  - Citations:
    `domains/fusion.md` L52-L53 (OpenMC ANL 2025 workshop +
    Springer 2025 TBR benchmark);
    `domains/energy.md` L42-L45 (OpenMC docs + Serpent
    benchmark).
  - Resources: ubu-pool preferred (3 GB download + multi-GB run
    intermediates). macOS viable for OpenMC itself but data
    transfer is the bottleneck.

**Verification.** Two records:
  - `exports/fusion/verify/tbr_<id>.json` with measured TBR vs
    Springer-2025 oracle, rel err < cited benchmark spread (state
    the spread).
  - `exports/energy/verify/keff_<id>.json` with measured k-eff vs
    OpenMC-vs-Serpent benchmark oracle.
Each: `absorbed = true`, `measurement_gate =
GATE_CLOSED_MEASURED`, ENDF release SHA256 in
`provenance.data_pin`. If either fails: record FAIL with diff,
do NOT flip.

**Touches.** `exports/{fusion,energy}/verify/`, ABSORPTION.md
parity table row update. design.md = new D-num per flip. Hexa
port (Stage 2) optional — substrate parity alone keeps
`absorbed=false` per ABSORPTION.md §"hexa 포팅 단계" (Stage 1 →
Stage 4 requires hexa-native re-derivation). State the stage
honestly.

---

## H-4 — CARLA + Unreal Engine install + mobility+verify scenario round

**What.** Install CARLA 0.9.15+ + Unreal Engine 4.26 / 5.x on a
Linux box; run ScenarioRunner with at least one OpenSCENARIO
file; emit an F1F2-style record for `mobility + verify`
(substrate `stdlib/mobility/carla_scenario.py`, κ-49 ROI 17).

**Why.** mobility+verify substrate landed at κ-49 as a
*platform-gated skip* — CARLA has no macOS build, ABSORPTION.md
L316 explicitly flags it Linux-only. The cited regression target
is `OpenSCENARIO scenario regression in CARLA` per
`domains/mobility.md` §2 (검증 row). Until a Linux-pool session
runs the actual scenario, mobility+verify cannot leave
`GATE_OPEN / absorbed=false`.

**Where.**
  - Substrate: `~/core/hexa-lang/stdlib/mobility/
    carla_scenario.py`.
  - Citations: `domains/mobility.md` L56 (CARLA repo +
    carla.org), L26 (CARLA — MIT code + CC-BY assets + Unreal
    Engine + ASAM OpenDRIVE), L28 (OpenSCENARIO ScenarioRunner).
  - Resources: ubu-2 (Linux, GPU helpful but headless CPU mode
    documented). Unreal Engine is the multi-GB / multi-hour part
    — budget similarly to H-2 (Geant4).
  - macOS = HARD BLOCK. Do NOT attempt; record the platform-gate
    citation in `provenance.platform_gate` instead.

**Verification.** Record at `exports/mobility/verify/
scenario_<id>.json` with:
  - measured pass/fail per OpenSCENARIO assertion,
  - scenario SHA256 + CARLA version + Unreal version pinned in
    `provenance.tool_pins`,
  - `absorbed = false` (CARLA substrate measurement ≠ hexa-native
    absorbed — ABSORPTION.md §"substrate vs absorbed 구분"),
  - `measurement_gate = GATE_CLOSED_MEASURED (substrate)` —
    matches the Yosys §5 precedent (chip-synth row in
    ABSORPTION.md table).

**Touches.** `exports/mobility/verify/`, ABSORPTION.md table row
("mobility+verify substrate-measured"), design.md new D-num.

---

## H-5 — Drake multi-GB install + bot+verify Lyapunov / SOS

**What.** Install Drake (pip `pydrake` or build-from-source) on a
multi-GB-budget machine, then run Drake's verification primitives
(Lyapunov certificates + SOS optimization + contact-implicit
verification) against at least one canonical bot example
(double-pendulum balance or cart-pole LQR + ROA estimate). Emit
an F1F2-style record for `bot + verify` (substrate
`stdlib/bot/drake_verify.py`, κ-49 ROI 13).

**Why.** bot+verify substrate landed at κ-49 as a honest
install-gated skip (Drake pydrake import unavailable). The cited
verification primitives (Lyapunov, SOS, contact-implicit) per
`domains/bot.md` L29 are Drake's distinguishing capability over
Gazebo. Until a session actually runs one, bot+verify cannot
leave `GATE_OPEN`.

**Where.**
  - Substrate: `~/core/hexa-lang/stdlib/bot/drake_verify.py`.
  - Citations: `domains/bot.md` L29 (Drake's verification
    primitives row), L57 (Drake MIT / TRI URL).
  - Resources: ubu-pool (Drake pip wheel is multi-GB; from-source
    build is hours). macOS is feasible per Drake docs but pip
    wheel is large — confirm version pins.
  - Cross-cell: bot+synth (κ-49) used a different substrate;
    coordinate if a shared `kernels/control` adapter emerges as
    a D72-N+M candidate.

**Verification.** Record at `exports/bot/verify/<id>.json` with:
  - canonical example name (e.g. `cart_pole_lqr_roa`),
  - Drake-reported certificate (Lyapunov V(x) coefficients, SOS
    cert dual, or contact-implicit success flag),
  - cited textbook oracle (e.g. Tedrake's underactuated.csail.mit.
    edu notes give analytic ROA bounds for simple cases) — state
    the oracle, state the rel err, state the tolerance.
  - `absorbed = false` (Drake substrate; hexa-native control-
    theory port not in scope this session).

**Touches.** `exports/bot/verify/`, ABSORPTION.md table row,
design.md new D-num.

---

## H-6 — CalculiX + GetDP install + 2 component-stack parity rounds

**What.** Install CalculiX (3D structural FEA) + GetDP (open
EM FEM solver), then run two parity rounds:
  - `component + analyze`  (CalculiX 3D structural — extends the
    κ-43 gmsh+skfem 2-D thermal substrate to 3-D structural;
    cited in domains/component.md §2 ANALYZE row + ABSORPTION.md
    L290 "CalculiX ⭐⭐⭐⭐ component-analyze 후속")
  - `rtsc + verify`  (GetDP HTS solver — H-formulation or
    A-φ formulation for REBCO tape-stack magnetization;
    substrate `stdlib/rtsc/getdp_hts.py`, κ-49 ROI 16)

**Why.** Both cells landed substrate but recorded honest
install-gated skip (CalculiX/GetDP binaries missing). rtsc+verify
is *especially* high-leverage: rtsc had ZERO producer before κ-49
(ABSORPTION.md L307 "rtsc 는 producer 0 — 최고 레버리지 빈
도메인"), and pyfemm+GetDP = the 2nd rtsc-EM consumer →
em-kernel-promotion D72-N+M candidate.

**Where.**
  - Substrate: `~/core/hexa-lang/stdlib/component/calculix.py`
    (TBD — confirm path via ROI 6 κ-49 entry) +
    `~/core/hexa-lang/stdlib/rtsc/getdp_hts.py` (κ-49 ROI 16).
  - Citations:
    `domains/component.md` L63 (CalculiX URL), L52 (FreeCAD →
    gmsh → CalculiX → ParaView open chain), L71 (Antmicro 2025
    PCB-thermal precedent);
    `domains/rtsc.md` L22 (GetDP / Elmer EM FEM row); arxiv
    2311.09177 (FiQuS / GetDP HTS reference) cited in
    ABSORPTION.md L307.
  - Resources: ubu-pool. Both tools are <1 GB build but require
    a working CGAL / PETSc toolchain; budget hours not days.

**Verification.** Two records:
  - `exports/component/analyze/calculix_<id>.json` with
    structural-stress eigenvalues vs textbook plate-bending
    closed-form (cite Timoshenko or NAFEMS benchmark),
    `absorbed = false` (substrate-stage only).
  - `exports/rtsc/verify/getdp_<id>.json` with HTS magnetization
    loss vs cited FiQuS reference, `absorbed = false`.
If GetDP H-/A-φ formulation parity passes, this also unlocks the
em-kernel-promotion D72-N+M candidate (2nd consumer rule per
ABSORPTION.md `kernels/em`).

**Touches.** `exports/{component,rtsc}/`, ABSORPTION.md kernels
table (em promotion candidate row), design.md new D-num per
flip.

---

## H-7 — firmware (D73) QEMU mps2-an385 + Zephyr west install + 7-verb measurement

**What.** Install QEMU 9.x with `qemu-system-arm -machine
mps2-an385` (Cortex-M3 reference target) + Zephyr SDK + `west`
toolchain, then run the 7-verb spine end-to-end against a
canonical Zephyr sample (e.g. `samples/hello_world` or
`samples/synchronization`). Emit one record per verb:
  명세→구조→설계→합성→해석→검증→인계 (firmware.md §2 table).

**Why.** firmware (D73, κ-46, 16th domain) was added explicitly
as the *end-to-end exemplar* of demiurge's 7-verb spine
(design.md D73: "firmware 에서 가장 명확"). κ-49 wired dispatch
for all 7 cells but ZERO real measurement landed — every cell
honest-skips on install gate. Until one Zephyr+QEMU round runs
end-to-end, the D73 spine-exemplar claim is unmeasured.

**Where.**
  - Substrate: `~/core/hexa-lang/stdlib/firmware/...` (TBD per
    κ-46 landing).
  - Citations: `domains/firmware.md` §2 (7-verb 1:1 OSS table —
    명세 IETF/AUTOSAR · 구조 Zephyr/FreeRTOS · 설계 GCC/west ·
    합성 signed firmware image · 해석 static analysis (clang-
    tidy / sparse / coverity-community) · 검증 QEMU/Renode/Unity
    · 인계 TUF/SBOM/IEC 61508).
  - Reference target: `qemu-system-arm -machine mps2-an385`
    (Cortex-M3, hardware 의존 0) — design.md D73 explicitly
    picks this as the spine-measurement target.
  - Resources: ubu-pool preferred; macOS also fine (QEMU + Zephyr
    SDK both have macOS builds). Budget: hours not days.

**Verification.** 7 records under `exports/firmware/<verb>/
<id>.json` covering the full chain for ONE Zephyr sample. The
key gate is `firmware + verify` measuring QEMU pass-list +
coverage against the Zephyr sample's `prj.conf` expectations.
Each verb's record carries the same `sample_id` in
`provenance.chain_id` so the cockpit chain-canvas can render
the full 7-verb arc end-to-end (rfc_004 §4 / rfc_011 spine).

Scope-bound (g3): this session is **Track A dispatch wiring**
+ first end-to-end *measurement* — it is NOT the "firmware
substrate Stage 2 hexa-native port" round. `absorbed = false`
on all 7 records (substrate-stage). Hexa-native port = follow-up.

**Touches.** `exports/firmware/*/`, ABSORPTION.md (new firmware
row under §"흡수 진행 상황"), design.md new D-num (D75+ for
firmware first end-to-end). PLAN.md κ-entry handled by main
session per task.

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
- 2026-05-19 — **κ-17 — sibling-repo 인식 철회 (user correction
  "hexa-lang 이 모두 stdlib / hexa-lang/component 나")**. The κ-16
  B-track sibling code was a wrong assumption — `~/core/hexa-<id>`
  directories exist on disk but are NOT SSOT; the single hexa-lang
  repo holds every domain's stdlib (booksim/matter pattern; component
  belongs at `~/core/hexa-lang/component/`). Removed
  Domain.siblingRepoPath / siblingRepoExists, NewProjectSheet
  sibling banner, cli show-project sibling_repo line. NEXT_SESSIONS
  Tracks B withdrawn, F path corrected, P-⑨ heading corrected.
  AGENTS.tape user_directive carries the 정정 line.
- 2026-05-19 — **hexa-lang = sole SSOT (user directive)** + **two-
  prompt collapse**. AGENTS.tape `g_stdlib_ownership.user_directive`
  gains the 2026-05-19 강화 line. The cross-repo tracks collapse to
  two prompts: D + E live in the SAME `~/core/hexa-lang` session
  (engine tools + measurement producers all there), F is the
  `~/core/hexa-component` session (P-⑨). Tracks matrix updated.
- 2026-05-19 — **P-⑨ added** (user "각각 프롬프트줘"). The F track
  (ι-2 component USDZ) now has its own cold-readable handoff prompt
  at P-⑨. D track is P-②③, E track is P-④ (both already present).
- 2026-05-19 — **Tracks matrix added** (user "갈래 모두 기록"). All
  six tracks A/B/C/D/E/F catalogued under "Tracks" at the top of
  this file, classified 🟢 demiurge-internal vs 🟡 cross-repo, with
  current state per track.
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
- 2026-05-20 — **H-1..H-7 added** (Track E: cross-session star-
  session handoffs). After κ-49 swept ROI 1→18 (잔여=0 substrate
  side) + κ-51 cern+synth absorbed=true flip + κ-52 SSOT reconcile,
  the *next* gating step is the heavy install + measurement parity
  rounds that κ-47..κ-49 honest-skipped. 7 cold-readable handoffs
  filed: H-1 hexa-lang live-tree re-align (unblocks all others) ·
  H-2 Geant4 (3-cell mc_transport parity) · H-3 OpenMC + ENDF/B-
  VIII.0 (energy+verify / fusion+verify) · H-4 CARLA + Unreal
  (mobility+verify, Linux-only) · H-5 Drake (bot+verify Lyapunov/
  SOS) · H-6 CalculiX + GetDP (component+analyze / rtsc+verify) ·
  H-7 firmware D73 7-verb QEMU mps2-an385 first end-to-end. Each
  carries Verification + Touches; none may flip `absorbed=true`
  without a cited parity record. Companion to existing P-* (which
  remain unchanged — design / build sessions, not measurement
  sessions).
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
