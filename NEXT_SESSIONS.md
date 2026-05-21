# NEXT_SESSIONS — copy-paste session-pickup prompts

> 2026-05-21 · demiurge origin/main `8b46c95` (κ-68 closure +
> κ-69 opening + ARCH §12 신설 + G31a wrapper half landed) ·
> hexa-lang PR #263 OPEN (`740964a0` · G31a wrapper · κ-69 first
> cross-repo partial-land). 4-Phase design-complete,
> macOS cockpit workbench built (rfc_012 IMPLEMENTED), κ-47..κ-49
> swept ROI 1→18 (17 cell dispatch · 잔여=0 substrate side), κ-51
> cern+synth absorbed=true, **κ-66 D80 sweep closed at 13 hexa-native
> pilots / 339 cumulative parity assertions** + 5 `.demi` SSOTs
> (`domains/INDEX · DEPENDENCIES · PRODUCERS · PILOTS · SUBSTRATE_
> LINKS`) DemiParser-loaded, **κ-67 RFC 013 PARTIAL-LAND** (schema
> half 5e9f6dea · producer-emit + live-mirror queued). Forward-handoff
> prompts below — each **0-context cold-readable**. Pick whichever;
> they are independent.
>
> **P-* (design / build sessions)** — P-⑤ ✅ DONE; P-②③ / P-④ cross-
> repo / heavy; P-⑥ closed; P-⑦ workbench follow-ups; P-⑧ / P-⑨
> post-completion / producer; **P-⑩ (κ-68 per-cell measured-oracle
> parity round, RFC 013 §6.11) — CLOSED 2026-05-21** (G27..G30
> 4-fold full land · first cell `absorbed=true` legitimate flip ·
> historical reference); **P-⑪ (bio D80 pilot full sweep · T3
> in-progress)**, **P-⑫ (Q3 advisory cross-cohort follow-up +
> chem substrate seed watch)**; **P-⑬ (κ-69 hexa-native ultimate-
> form parity + next-cell round, ARCH §11.4 Round 8 G31..G34)** ←
> κ-69 opening 2026-05-21 · G31a wrapper half landed (hexa-lang
> PR #263 OPEN) · G31b / G32 / G33 / G34 open.
>
> **H-* (heavy-substrate measurement sessions, new 2026-05-20)** —
> H-1 unblocks all (hexa-lang live-tree re-align); H-2..H-7 each
> install one heavy substrate (Geant4 / OpenMC / CARLA / Drake /
> CalculiX+GetDP / firmware-QEMU) and run the parity round κ-49
> honest-skipped. H-2 first Geant4 substrate record landed
> (`exports/antimatter/verify/20260520T083856Z/`, κ-50); H-6 rtsc
> substrate landed (κ-48); H-3 OpenMC blocked (osx-arm64 + Linux
> pool unreachable, `inbox/notes/openmc-install-blocker-2026-05-20.md`).
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

## P-⑩ — κ-68 per-cell measured-oracle parity round (RFC 013 §6.11 follow-on · post-κ-67)

**κ-67 close (2026-05-20)**: ① producer-emit (LANDED · `efa4afe` D94),
② live mirror (LANDED · `47bf504` D96 + `e451037` D100), ③
illustrative-physics gate (LANDED · `f9a9a90` D106). RFC 013
PARTIAL-LAND → MOSTLY-LANDED (`943a5b8` D105) → κ-67 closure
(`eea2804` D108). **Remaining queued = RFC 013 §6.11 only — per-cell
measured-oracle parity round (κ-68).**

**Use this when:** every D80 / RFC 013 §6.1..§6.10 / §6.12 follow-on
has landed; stored `absorbed: Bool` 의 첫 legitimate flip 을 cell-
side measured oracle 로 트리거하는 round 가 queued. ARCH.md §11.4
Round 7 (G27..G30) scaffold 가 `[ ]` placeholder 로 박힘 — 본 prompt
가 그 4 항목을 `[x]` 로 가져간다. cell pick = Energy/solar
(`inbox/notes/k68-cell-pick-2026-05-21.md` · 5 open sub-decisions
queued).

```
demiurge κ-68 per-cell measured-oracle parity round session.
Repo: ~/core/demiurge · branch from origin/main. Read first:
  - ARCH.md §11.4 Round 7 (G27..G30 placeholder `[ ]`)
  - proposals/rfc_013_hexa_native_parity_connection.md §6.11
    (per-cell measured-oracle round queued · MOSTLY-LANDED 상태)
  - inbox/notes/k68-cell-pick-2026-05-21.md (cell = Energy/solar,
    NREL MIDC pyranometer GHI direction · 5 sub-decisions open)
  - design.md D80 (g_hexa_only) · D86 (no hardcoded data) · D95
    (computed projection 격리) · D103 (dimension-separation) ·
    D106 (illustrative-physics gate) · D108 (κ-67 closure) — DO
    NOT re-litigate
  - domains/PILOTS.demi `[pilot-solar]` (21 PASS · 8 sub-kernel ·
    hexa-lang `stdlib/kernels/solar/`)

Four jobs (do them in order — G27 → G28 → G29 → G30):

G27. Cell + measured-oracle source decision (pre-code gate).
   Cell = Energy/solar (이미 결정 · k68-cell-pick anchor). Oracle
   direction = NREL MIDC pyranometer GHI (단일 clear-sky day ·
   SRRL Golden CO 후보). 5 open sub-decisions (station / window /
   bridge trust / PASS criterion / D-number = D109 후보) 답한 뒤
   design.md 에 단일 D-block 박제 — cell + oracle dataset + PASS
   기준 + 회피 후보 rationale. Code 변경 0 (decision-only).

G28. Producer wire — substrate adapter emits measured-oracle field
   into cell record. Cell record schema 확장 — typed
   `MeasuredOracleRef` (measured · reference · rel_err · threshold ·
   oracleSource). `hexa_native_parity` 와 별도 axis 의 새 field
   set. `absorbed: Bool` 미flip (D103 separation — schema half 만
   land). XCTest ≥ 1 · `EnergyVerifyRecord` 의 field 1개 추가 ·
   exports/ 에 PASS record JSON ≥ 1 land.

G29. First cell `absorbed: true` legitimate flip — NOT D95 computed
   projection. Cell record writer (producer 또는 cockpit producer
   adapter) 가 measured-oracle PASS 조건에서 stored `absorbed: Bool`
   을 true 로 명시적 set. D95 computed `isHexaNativeAbsorbed` 재사용
   금지 — stored field 와 computed field 는 별도 set path 유지.
   단일 cell 만 (Energy/solar). PLAN.md κ-68 entry + design.md
   D-block.

G30. Governance gate — absorbed-vs-measured invariant typed
   enforcement. AGENTS.tape `@D g_absorbed_needs_measured_oracle`
   (이름 후보 · G27 D-block 단계에서 finalize) 1 row + cockpit
   XCTest 가 "measured field 부재 시 absorbed=true 면 FAIL"
   invariant enforce. D106 illustrative-physics case 는 invariant
   에서 제외 (anti-conflation 유지). 기존 cell record 회귀 0.

Gate (g3 — REQUIRED):
   - G27 land = design.md D-block 박제 만 (code 0).
   - G28 land = cell record schema 확장 + producer wire + XCTest;
     `absorbed: Bool` 은 여전히 false 유지.
   - G29 land = 단일 cell 의 stored `absorbed: Bool` true · measured
     oracle PASS 근거 record 안에 cite · 다른 cell 회귀 0.
   - G30 land = invariant XCTest PASS + `.specify/memory/constitution.md` governance row;
     기존 illustrative-physics cell (Fusion 등) 회귀 0.

NOT (g3 — non-negotiable):
   - Do NOT trigger `absorbed=true` from D95 computed projection
     (이전 round 의 자동-flip path 재사용 금지). stored `absorbed:
     Bool` 은 항상 명시적 writer-set (D103 separation).
   - Do NOT include illustrative-physics cells (Fusion mc_transport
     등) 을 본 round 의 flip 대상에 포함 — D106 anti-conflation.
   - Do NOT hardcode oracle dataset path in producer adapter —
     D86 no-hardcoded-data floor 유지.
   - Do NOT touch chip §B path (YOSYS.md 다른 세션 작업 중) —
     ChipAnalyze cell 은 본 round 의 flip 대상에서 명시 제외.
   - Do NOT extend the round to multiple cells in one session —
     단일 cell (Energy/solar) 의 honest land 가 우선; 다중 cell
     은 후속 round.

Exit criterion (any one ends honestly):
   (a) G27..G30 모두 `[x]` + RFC 013 §6.11 LANDED + 단일 cell 의
       stored `absorbed: true` 가 measured oracle PASS 근거로 land
       + PLAN.md κ-68 entry + design.md D-block, OR
   (b) G27 만 land (D-block 박제 · code 0) + G28..G30 deferred +
       honest next-pickup note + RFC 013 §6.11 unchanged, OR
   (c) Scope-bounded sub-progress (예: G27+G28 만) + RFC 013 §6.11
       unchanged + next-pickup note in this P-⑩ section.
```

> **κ-68 closure (2026-05-21)**: G27..G30 4-fold full land — D109
> + D110 + G28a `4a1a087` + G28b PR #248 STUB MERGED + G29 hexa-lang
> PR #259 `b8d35920` REAL MERGED (first cell `absorbed=true` legitimate
> flip · mean rel_err 0.0499 vs 0.05) + G30 Stage 1 `fee34cc` XCTest
> invariant + κ-68 closure commit `80a1664`. RFC 013 `MOSTLY-LANDED`
> → `LANDED`. P-⑩ 본문은 historical reference 로 박제 — κ-69 horizon
> (G31..G34 · G29-β ultimate-form + 두번째 cell mirror + Stage 2)
> 는 **P-⑬** 참조.

---

## P-⑬ — κ-69 hexa-native ultimate-form parity + next-cell round (ARCH §11.4 Round 8 · post-κ-68)

**κ-69 opening (2026-05-21 · 같은 cycle as κ-68 closure)**: ARCH
§11.4 Round 8 scaffold (G31..G34) pre-code 박힘 + ARCH §12 신설
(chip §B substrate-axis 잔여 로드맵 이관 from rm'd YOSYS.md) +
**G31a wrapper half landed** (hexa-lang PR #263 OPEN · `740964a0` ·
κ-69 first cross-repo partial-land). Remaining queued: G31b producer
integration · G32 cell pick · G33 flip · G34 constitution.md Stage 2.

**Use this when:** you continue κ-69 R8 work. ARCH.md §11.4 Round 8
는 G31..G34 의 full scope (scope · deps · est · exit criterion ·
avoid) 를 가지고 있다 — 본 prompt 는 그 narrative 를 *next-session
pickup* 형태로 framing 만; **detail 은 ARCH §11.4 G31..G34 + §12.1
참조**, 본문 중복 금지.

```
demiurge κ-69 Round 8 session pickup.
Repo: ~/core/demiurge · branch from origin/main. Read first:
  - ARCH.md §11.4 Round 8 (G31..G34 full scope · est · exit
    criterion) — 본 prompt 의 detail SSOT
  - ARCH.md §12.1 (chip §B substrate-axis Tier-1/2/3 잔여 ·
    landing-axis distinction 명시 · §11.4 G-round 와 별 axis)
  - PLAN.md κ-69 opening entry (2026-05-21 · scaffold + §12 신설
    + G31a partial-land 박제)
  - proposals/rfc_013_hexa_native_parity_connection.md §6.11
    (LANDED · κ-69 는 ultimate-form parity follow-on)
  - design.md D109/D110 (κ-68 cell pick + first flip · κ-69
    pattern source) · D80 (`g_hexa_only` endpoint rule)
  - inbox/notes/rfc006-s5-area-oracle-parity-handoff.md (chip §B
    detail SSOT · 1754 line · sibling repo 측 entry-by-entry fact)

Open axes (pick whichever is honest for this session — they are
independent gates):

(a) G31b — Energy/solar producer integration (κ-69 first close)
    deps: hexa-lang PR #263 merged. swap
    `stdlib/energy/nrel_midc_pyranometer.py` `_compute_modeled()`
    의 `loc.get_solarposition(times)` → subprocess `hexa run
    _solar_position_cli.hexa` · 480-sample mean rel_err 유지 verify
    · `bridgeStack` 표기 `"hexa_native_solar_position + pvlib
    Ineichen"` 갱신 · `EnergyVerifyRecord` `provisional=true` 강등
    risk 제거. ARCH §11.4 G31 `[~]` → `[x]` flip.
    est: 1-2 session. cross-repo: hexa-lang merge gate (PR #263) +
    demiurge producer wire.

(b) G32 — 다음 cell pick + measured-oracle source decision (κ-69
    R8 pre-code decision gate). G27 (κ-68) 와 동형 — 5-fold lock-in
    (cell · external oracle · bridge stack · hexa-native scope ·
    PASS criterion) decision-only · code 0. 후보 cluster (ARCH
    §11.4 G32 참조): Aura (PhysioNet) · Ufo non-illustrative stage
    (plasma diagnostic) · Energy `wind` sub-cell. avoid: D106
    illustrative-physics gate cell · D95 computed-projection only
    cell. design.md D111 record + exit criterion 박제.
    est: 0.3-0.5 session. code 0.

(c) G33 — G32 cell 의 첫 `absorbed=true` legitimate flip
    (κ-68 G29 mirror · 두번째 cell measurement-parity land).
    `MeasuredOracleRef` schema 재사용 + 새 record type (e.g.
    `AuraVerifyRecord`) 에 field instantiate + 외부 dataset fetch
    + PASS criterion 측정 + g3-honest flip. G30 Stage 1 XCTest
    invariant 가 새 cell 에도 확장 적용 audit.
    deps: G32 (decision) · G28 (schema 재사용) · G30 Stage 1
    (invariant pattern).
    est: 2-4 session.

(d) G34 — G30 Stage 2 constitution.md governance row
    (`.specify/memory/constitution.md` populate 후 · κ-69 closure
    block). `absorbed=true ⇔ measuredOracle.isMeasuredOraclePASS=
    true` invariant 의 narrative governance row + D110 + G30
    Stage 1 cross-link + D106 carve-out 명시.
    deps: constitution.md populate (별 work) · G30 Stage 1
    (`fee34cc`) · G33 (두번째 cell row 갱신).
    est: 0.3-0.5 session.

Gate (g3 — REQUIRED):
  - G31b land = NREL MIDC 480-sample mean rel_err drift ≤ ε
    + `bridgeStack` field update audit + hexa-lang PR #263
    merged (hexa-lang session 측 별 axis · 본 세션은 그 후 swap).
  - G32 land = design.md D111 박제 (5-fold sub-decision · code 0).
  - G33 land = stored `absorbed: Bool` true · measured oracle PASS
    근거 record cite · 다른 cell 회귀 0.
  - G34 land = constitution.md governance row populate + XCTest
    invariant cross-link audit.

NOT (g3 — non-negotiable):
  - Do NOT touch hexa-lang sibling repo 의 §12.1 (e) fifo_mem
    RTLIL Memory emit axis — 다른 agent 가 active 작업 중
    (`inbox/PATCHES.yaml` 504-line WIP). 본 세션은 chip §B
    substrate-axis 미접촉.
  - Do NOT trigger `absorbed=true` from D95 computed projection —
    κ-68 D103 separation 유지.
  - Do NOT include illustrative-physics cells in G32/G33 — D106.
  - Do NOT hardcode oracle dataset path — D86 floor.
  - Do NOT bundle G31b + G33 in one session if both require
    cross-repo merge — multi-repo discipline (κ-68 G28 pattern).

Exit criterion (any one ends honestly):
  (α) G31b LANDED + ARCH §11.4 G31 `[x]` flip + PLAN.md κ-69
      G31 close entry + hexa-lang PR #263 merged, OR
  (β) G32 LANDED (D111 박제 · code 0) + scope-bounded next-pickup
      note + ARCH §11.4 G32 `[x]` flip, OR
  (γ) G31b + G32 묶음 land + next-pickup pointer to G33/G34, OR
  (δ) Scope-bounded sub-progress + honest next-pickup note in
      this P-⑬ section + ARCH §11.4 partial flag (`[~]`) update.
```

> **Cross-repo coordination note (κ-69)**: G31a wrapper half 는
> isolated worktree `~/core/hexa-lang-g31` 에서 작업됨 (shared
> `~/core/hexa-lang` 의 다른 axis = §12.1 (e) fifo_mem 작업 중
> 다른 agent 회피 · `feedback_hexa_lang_concurrent_agents.md`
> memory pattern). G31b 후속은 같은 worktree 유지 가능 (PR #263
> branch 그대로) — `~/core/hexa-lang` main worktree 와 commit
> 충돌 회피.

---

## P-⑪ — bio domain D80 pilot full sweep (T3 in-progress · sibling-only)

**Use this when:** you continue the bio D80 pilot work. As of
`f28c1b0`, bio is the ONE demiurge domain still mid-port —
`domains/bio.md` records substrate at `~/core/hexa-bio/` sibling
(T3 `.py → .hexa` port in progress per `hexa-lang/stdlib/PLAN.md`),
with no `stdlib/bio/` subtree yet. D100 (`14 non-sibling narrative`
sweep) explicitly carved bio as "D80 pilot WEAVE" — meaning bio is
neither a born-hexa-native subtree (firmware/component pattern) nor
a substrate-fully-extracted sibling (5-sibling pattern), it sits in
the WEAVE state until the T3 port finishes.

```
demiurge bio D80 pilot full-sweep session.
Repo: ~/core/demiurge (record + audit only) + ~/core/hexa-bio
(producer) + ~/core/hexa-lang (port destination). Read first:
  - domains/bio.md (substrate narrative · `hexa-bio` sibling)
  - domains/SUBSTRATE_LINKS.demi (bio NOT YET in this SSOT — gate
    on T3 completion; opens the row when sibling is link-ready)
  - hexa-lang/stdlib/PLAN.md (the T3 .py→.hexa port roadmap —
    canonical source of which bio kernels are next)
  - proposals/rfc_013 §4 (the pilot-port pattern: pick the
    substrate not the adapter; capture parity from Python at
    ≥12 digits; mirror the API surface line-by-line)
  - design.md D17 (sibling-repo precedent) + D80 (g_hexa_only)
  - existing 13-pilot rolling table in PILOTS.demi (the pattern
    every new bio pilot must mirror)

Two jobs (do them in order; ① may be partial-shippable):

① Continue T3 .py → .hexa port for one bounded bio kernel.
   Pick ONE kernel from hexa-bio T3 roadmap (smallest first —
   sequence-alignment Needleman-Wunsch / simple FASTA parse /
   exact bp-pair count are good candidates; molecular-dynamics is
   NOT — defer until matter/chem cluster pilots first). The kernel
   lives in `~/core/hexa-lang/stdlib/kernels/bio/<id>_kernel.hexa`
   with companion `<id>_kernel_test.hexa`. Mirror the established
   13-pilot pattern: pure hexa-native (no FFI), parity test against
   Python substrate (biopython / scikit-bio) at ≥12 digits or
   bit-exact for combinatorial cases.

② File the demiurge-side audit + pilot row.
   When ① lands on hexa-lang origin/main: append a row to
   `domains/PILOTS.demi` (8-field schema per D90) — kernel_path /
   parity_test / parity_method / parity_tolerance / parity_status /
   hexa_lang_sha / algorithm_ref / scope_notes — and a matching row
   to `domains/DEPENDENCIES.demi` with `portable_status` flipped to
   `already-ported` for the kernel. If this is the FIRST bio kernel
   landed, also add bio to `domains/SUBSTRATE_LINKS.demi` (sibling_
   path / identity_key / advisory_prereqs / notes — Tier ①/②/③
   verifier per D97) and add a `**Sibling sub-domains**` narrative
   line to `domains/bio.md` (D96 pattern).

Gate (g3 — REQUIRED):
   Pilot lands ONLY when the parity test PASSes at the documented
   tolerance and the row in PILOTS.demi cites the hexa-lang
   origin/main SHA. Partial port (e.g. forward-pass only, no
   reverse) is acceptable — record it honestly in scope_notes per
   the pilot-#11 `autodiff_dual_forward` precedent (forward-mode
   only, scalar I/O, no Jacobians).

NOT (g3 — non-negotiable):
   - Do NOT add bio to SUBSTRATE_LINKS.demi until the sibling repo
     has at least one substrate file `~/core/hexa-bio/` actually
     references — empty sibling = Tier ① fail.
   - Do NOT claim "bio domain absorbed" — even after the first
     pilot lands, this is one substrate kernel of N. bio stays in
     "D80 pilot WEAVE" status in D100 narrative until ALL T3
     kernels port (this is multi-round / multi-month).
   - Do NOT skip the test scaffolding — every pilot MUST carry the
     `pass_count / total_count / check / rel_err` pattern from
     RFC 013 §4.
   - Do NOT touch `domains/chem.md` substrate narrative — chem is
     separately gated (P-⑫).

Exit criterion (any one ends honestly):
   (a) One bio pilot kernel + test PASS + PILOTS.demi row +
       DEPENDENCIES.demi flip + κ-N PLAN.md entry, OR
   (b) Bounded port progress + honest "next pickup" note in
       hexa-lang `inbox/notes/hexa-native-port-pattern-pilot.md`,
       no demiurge-side commit (the SSOT only updates when the
       hexa-lang side lands).
```

---

## P-⑫ — Q3 advisory cross-cohort follow-up + chem substrate growth

**Use this when:** D97 Tier ③ (`advisory_prereqs` cross-cohort
coverage) becomes load-bearing — currently it is warn-only with
zero drift, but the `advisory_prereqs` arrays in `SUBSTRATE_LINKS.
demi` (5 rows · rtsc/cern/antimatter/fusion/ufo) declare cross-
cohort claims that have NO automatic enforcement beyond Tier ③ warn.
Also use this when the chem substrate gate transitions from seed
to D80 pilot (chem `stdlib/kernels/chem/arrhenius_kernel` seed
landed 2026-05-20 hexa-lang `78aee88d` / demiurge `3215cea`; the
sibling `~/core/hexa-chem/` repo per D17 precedent is still planned,
and PILOTS.demi has NO chem row yet — pilot row + Tier ① link-
integrity entry will follow when chem substrate grows beyond the
arrhenius seed).

```
demiurge Q3 advisory + chem substrate seed watch session.
Repo: ~/core/demiurge. Read first:
  - design.md D97 (3-tier substrate link-integrity verifier;
    Q3 = A picked — Tier ③ advisory cross-cohort = warn-only)
  - domains/SUBSTRATE_LINKS.demi (5 row · advisory_prereqs arrays)
  - cockpit/Tests/DemiurgeCoreTests/SubstrateLinkIntegrityTests
    .swift (the warn-only Tier ③ test — `testTier3Advisory
    PrereqCoverage`)
  - domains/chem.md (NOT YET substrate narrative · D100; planned
    via D17 sibling-repo precedent, reuses matter/{mol,crystal})
  - design.md D77 (chem + bio domains added) + D17 (sibling-repo
    precedent) + ABSORPTION.md `kernels/<id>` 2nd-consumer rule

Two independent jobs — both gate-watching, neither forces a flip:

① Q3 advisory cross-cohort follow-up.
   Today Tier ③ advisory drift = 0 (per design.md D97 §적용 ④ —
   `SUBSTRATE_LINKS.demi` advisory_prereqs perfectly match
   `INDEX.demi` transitive closure). If a future PR introduces
   drift (e.g. a new sibling cohort claims a prereq not in the
   INDEX DAG, OR INDEX gets reshaped and SUBSTRATE_LINKS goes
   stale), Tier ③ warn fires but XCTest still passes. THIS session
   reviews each warn and decides per-row:
     (a) drift is real → patch SUBSTRATE_LINKS.demi advisory_
         prereqs to re-align with INDEX (D86 — declarative SSOT),
     (b) drift is intentional (sibling-side captures cross-cluster
         dependency invisible to demiurge's DAG) → keep + document
         in `notes` field with the rationale,
     (c) INDEX DAG itself needs editing (rare — D78 lock applies).
   The session does NOT auto-resolve; it produces a decision +
   record per drift row, and (if any (a) applies) a single PR
   restoring drift=0.

② chem substrate growth — first pilot row.
   `domains/chem.md` records substrate as `stdlib/kernels/chem/`
   seed (arrhenius_kernel landed hexa-lang `78aee88d` 2026-05-20,
   6/6 test PASS) but NO chem row in PILOTS.demi yet. THIS session
   adds the first pilot row + matching DEPENDENCIES.demi audit row
   when arrhenius_kernel is verified against a Python substrate
   (e.g. SciPy / cantera / openchem closed-form Arrhenius) at the
   D80 pilot pattern (≥12 digits parity OR exact for closed-form).
   Also inspects:
     (a) the 2nd-consumer rule (ABSORPTION.md `kernels/<id>`) —
         arrhenius_kernel currently has 1 consumer (chem domain);
         if a 2nd appears (bio reaction-rate / matter phase-
         transition), promote to `kernels/<id>` proper (D72-N+M).
     (b) Whether `~/core/hexa-chem/` sibling needs seeding for the
         larger molecular-scale substrate (RDKit-parity QM,
         AiZynthFinder retrosynthesis) — IF yes, file a seed-
         proposal note in `inbox/notes/` proposing the chem sibling
         creation path (D17 precedent).
     (c) If sibling seeds: add chem to `SUBSTRATE_LINKS.demi`
         (Tier ①/②/③ verifier per D97) + `**Sibling sub-domains**`
         narrative line on `domains/chem.md` (D96 pattern).

Gate (g3 — REQUIRED):
   ① touches only `SUBSTRATE_LINKS.demi` `advisory_prereqs` /
   `notes` fields. SSOT change MUST be one declarative `.demi`
   diff — Swift type / loader unchanged.
   ② adds at most ONE pilot row to `PILOTS.demi` + matching
   DEPENDENCIES.demi audit + (if sibling seeds) SUBSTRATE_LINKS.
   demi row. Each `.demi` edit follows the 8-field schema (D90) —
   no Swift type / loader changes.

NOT (g3 — non-negotiable):
   - Do NOT flip Tier ③ from warn-only to XCTFail without a Q1
     re-decision (Q1 = 'two SSOTs independent', design.md D97).
     If drift becomes systematic, propose a new Q via design.md,
     do NOT silently tighten.
   - Do NOT seed `~/core/hexa-chem/` sibling from this session
     unilaterally — it's an upstream-substrate decision (D17
     precedent). File a seed-proposal note + wait for the
     hexa-chem session.
   - Do NOT add chem to `SUBSTRATE_LINKS.demi` until the sibling
     repo exists AND has at least one substrate file (empty
     sibling = Tier ① fail; identical floor as bio in P-⑪).
   - Do NOT widen Tier ① / Tier ② scope here — those are
     fail-loud already; this session is the advisory/warn band
     only.

Exit criterion (any one ends honestly):
   (a) Tier ③ drift survey complete + per-row decision recorded +
       (if needed) SUBSTRATE_LINKS.demi patch landed; AND/OR
   (b) chem arrhenius_kernel pilot row landed in PILOTS.demi +
       DEPENDENCIES.demi audit row + κ-N PLAN.md entry; AND/OR
   (c) chem 2nd-consumer survey complete + (if 2nd found OR
       sibling needed) seed-proposal note filed in `inbox/notes/`,
       OR honest "no drift / no 2nd consumer / sibling not needed
       — re-watch at next sweep" note if all gates stay closed.
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

State summary at branch-out (2026-05-20 — refreshed post-κ-66/κ-67):
- demiurge origin/main = `3215cea` (κ-66 D80 sweep close + κ-67
  RFC 013 promotion + D80 pilot #11 land + chem substrate seed
  narrative)
- hexa-lang origin/main = `170f74af` (D80 pilot #11
  `autodiff/dual_forward_kernel.hexa` land — extends the 13-pilot
  rolling table) + `78aee88d` (chem `arrhenius_kernel` seed,
  6/6 PASS — chem substrate now `stdlib/kernels/chem/`)
- 17 cells dispatch-able (ROI 1→18); cern+synth + chip §B+§D are
  the only `absorbed=true` cells. Everything else = substrate stage
  (Stage 1 in ABSORPTION.md §"hexa 포팅 단계") with `GATE_OPEN +
  absorbed=false` install-gated skip records.
- **H-2 first measured substrate record landed** —
  `exports/antimatter/verify/20260520T083856Z/antimatter_verify
  _20260520T083856Z.json` (Geant4 substrate-stage, κ-50). H-6 rtsc
  substrate landed (`exports/rtsc/analyze/2026-05-20T08-26-07Z/`,
  pyfemm + xvfb on Linux pool, κ-48). H-3 BLOCKED (osx-arm64 +
  Linux pool unreachable — see `inbox/notes/openmc-install-
  blocker-2026-05-20.md`).
- Live blocker for the remaining H-*: `~/core/hexa-lang` live tree
  is still owned by concurrent compiler-perf sessions
  (`s1-step2-codegen-perf` family). demiurge's
  `ActionDispatch.runEngineTool` spawns python from the live tree,
  not from origin/main — so any H-N that wants to drive substrate
  measurement must first land H-1's tree-realign or accept that
  its substrate spawns will hit the concurrent-session view of
  stdlib/.

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
- 2026-05-20 — **κ-66/κ-67 close + P-⑩/P-⑪/P-⑫ added**. D80
  `g_hexa_only` ultimate-form sweep closed at **13 hexa-native
  pilots / 339 cumulative parity assertions** (PILOTS.demi 13 rows
  · #1..#11 + concurrent-branch entries) across `solar · mc_
  transport · neural_lif · graph_bfs · urdf_fk_2link · plasma_
  metrics · orbital_kepler · dft_naive · event_queue · transport_
  kinematics · breaker_trace_reduce · fem_bar1d_subset · autodiff_
  dual_forward`. Five `.demi` SSOTs consolidated under `domains/`
  (`INDEX · DEPENDENCIES · PRODUCERS · PILOTS · SUBSTRATE_LINKS`)
  — every kernel / producer / dependency / pilot / cross-substrate
  link reads from declarative SSOT via DemiParser loaders (D86
  `g_no_hardcoded_data` 정합). Decision sweep D87..D100 audited the
  consolidation: `.demi` location (D87) · DEPENDENCIES.demi move
  (D88) · `allHardcoded` fallback removal (D89) · PILOTS.demi
  8-field schema (D90) · row=kernel granularity (D91) · flat dir
  layout (D92) · pattern-pilot ↔ PILOTS dual-source (D93) ·
  parity_ref = PilotLoader.find (D94) · `isHexaNativeAbsorbed`
  computed (D95) · sibling sub-domain narrative (D96) · 3-tier
  link-integrity verifier (D97 / Q3 = A) · DEPENDENCIES ↔ PILOTS
  dual-source CI (D98) · cockpit HexaNativeParityChip (D99) ·
  non-sibling narrative reverse (D100). **RFC 013 PARTIAL-LAND**
  (`proposals/rfc_013_hexa_native_parity_connection.md`, κ-67) —
  schema half (demiurge `5e9f6dea`) wires `HexaNativeParityRef` +
  5 cell-record carriers + `GateType.hexaNativeFuture` + Dependencies
  Loader; producer-side emit + live `DEPENDENCIES.demi` mirror +
  `illustrative-physics` gate first-class are queued as §6
  follow-on (covered by P-⑩ below). Header refreshed (origin/main
  `f28c1b0` · hexa-lang `170f74af`). State summary at H-* branch-
  out refreshed — H-2 / H-6 first substrate records cited, H-3
  blocked note added. Three new prompts:
  * **P-⑩** — *originally* κ-67 producer-emit + live mirror (RFC 013
    §6) — three sub-jobs all LANDED (① producer-emit `efa4afe`,
    ② live mirror `47bf504`/`e451037`, ③ `.illustrativePhysics`
    gate `f9a9a90`). κ-67 closure `eea2804` D108. **Refreshed
    (post-κ-67) to κ-68 — per-cell measured-oracle parity round
    (RFC 013 §6.11)** · four steps G27..G30 (ARCH §11.4 Round 7
    scaffold). cell = Energy/solar (`inbox/notes/k68-cell-pick-
    2026-05-21.md`). g3 floor: stored `absorbed: Bool` 의 첫
    legitimate flip 은 cell-side measured oracle PASS 근거로만 —
    D95 computed projection 재사용 금지 (D103 separation).
  * **P-⑪** — bio domain D80 pilot full sweep. bio is the ONE
    demiurge domain still mid-port (D100 "D80 pilot WEAVE"
    narrative) — T3 `.py → .hexa` per `hexa-lang/stdlib/PLAN.md`;
    sibling `~/core/hexa-bio/` only, no `stdlib/bio/` subtree yet.
    Session ports one bounded kernel (Needleman-Wunsch / FASTA
    parse — molecular-dynamics NOT) + files PILOTS.demi row +
    optionally seeds bio into SUBSTRATE_LINKS.demi once link-ready.
  * **P-⑫** — Q3 advisory cross-cohort follow-up + chem substrate
    growth. D97 Tier ③ (`advisory_prereqs` cross-cohort) is
    currently warn-only with drift=0; session inspects future
    drift + decides per-row (patch / document / re-design). chem
    substrate seed (`stdlib/kernels/chem/arrhenius_kernel`,
    hexa-lang `78aee88d` 6/6 PASS · demiurge `3215cea` narrative
    update) landed but PILOTS.demi has no chem row yet — session
    files the first chem pilot row + watches 2nd-consumer rule +
    sibling-seed gate. Both sub-jobs are gate-watching — neither
    flips `absorbed=true` from substrate-parity alone.
- 2026-05-21 — **κ-68 close + κ-69 opening · P-⑩ historical-marked
  + P-⑬ added**. κ-68 (per-cell measured-oracle parity round)
  4-fold full land 이 한 사이클로 마감 (`80a1664` closure commit · RFC
  013 §6.11 `MOSTLY-LANDED` → `LANDED` · Energy/solar 첫 cell
  `absorbed=true` legitimate flip · D110 · hexa-lang `b8d35920`
  PR #259 MERGED · mean rel_err 0.0499 vs 0.05 PASS · 480 clear-sky
  samples NREL MIDC SRRL Golden CO · G30 Stage 1 `fee34cc` XCTest
  invariant LANDED). P-⑩ 본문은 **historical reference** (κ-68
  closure marker block 추가) — κ-69 horizon 은 새 P-⑬ 로 분리.
  같은 cycle 에 κ-69 opening 이 함께 land — ARCH §11.4 Round 8
  scaffold (G31..G34) pre-code 박힘 (`5897572`) + ARCH §12 신설
  (chip §B substrate-axis 잔여 로드맵 이관 from rm'd YOSYS.md ·
  `e7371be` · Tier-1/2/3 · 8-16 session est · detail SSOT =
  `inbox/notes/rfc006-s5-area-oracle-parity-handoff.md`) + §12.1
  PR state drift 정정 (`984c2d4` · cross-repo audit triggered ·
  PR #260→#261 first area>0 + PR #255 OPEN not MERGED + PR #256
  inbox patch 정정) + **G31a wrapper half landed** (`8b46c95` ·
  κ-69 first cross-repo partial-land · hexa-lang PR #263 OPEN ·
  `740964a0` · `stdlib/energy/_solar_position_cli.hexa` 64-line
  CLI · parity Δ≈0.002° vs pvlib 0.13.0 noon Phoenix · isolated
  worktree `~/core/hexa-lang-g31` pattern). P-⑬ 4 open axes:
  * **(a) G31b** — Energy/solar producer integration (1-2 session ·
    hexa-lang PR #263 merge gate · `nrel_midc_pyranometer.py` swap +
    480-sample mean rel_err 유지 verify + `bridgeStack` 갱신). 본
    update 시점에서 isolated worktree 측 background 진행 중.
  * **(b) G32** — 다음 cell pick + measured-oracle source 5-fold
    decision (design.md D111 · 0.3-0.5 session · code 0 ·
    Aura / Ufo non-illustrative / Energy `wind` 후보).
  * **(c) G33** — G32 cell 첫 `absorbed=true` legitimate flip
    (2-4 session · `MeasuredOracleRef` schema 재사용).
  * **(d) G34** — G30 Stage 2 constitution.md governance row
    (`.specify/memory/constitution.md` populate 후 · 0.3-0.5 session).
  κ-69 별 axis: chip §B substrate-axis (§12.1 (e) fifo_mem RTLIL
  Memory emit) 은 hexa-lang sibling repo 측에 **다른 agent 가 활성
  작업 중** — 본 세션은 이 axis 미접촉. landing-axis distinction
  (D80 §0 endpoint rule) 으로 §11.4 G-round (measurement-parity)
  ↔ §12 substrate-axis 가 별 gate.
