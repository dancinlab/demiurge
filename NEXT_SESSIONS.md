# NEXT_SESSIONS — copy-paste session-pickup prompts

> 2026-05-19 · demiurge repo at `d4c22bf`+ (4-Phase design-complete).
> Three forward-handoff prompts, one per session — each is
> **0-context cold-readable** (a fresh Claude Code session reads it
> and has enough). Pick whichever to start; they are independent.
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

## P-⑤ — macOS Swift cockpit build session (rfc_009 implementation)

**Use this when:** you start building the macOS Swift app. Per D22
the build is OUT of scope of demiurge's design session — this is
the dedicated downstream build session that works against
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

## Cross-cutting notes (apply to all 3)

- demiurge decisions D1–D22 are committed; do not re-litigate them
  in a session. Cite them. New session-specific decisions go into
  that session's repo's design.md / decision SSOT.
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
