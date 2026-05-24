# cern + analyze — producer-alternative mechanism decision (2026-05-20)

> status: **resolved** (κ-51 / D74) — Option C ProducerRegistry adopted; default = xsuite-tracking, override = pylhe via `--producer pylhe`. AGENTS.tape `@N n_cern_producer_alternatives` carries the governance note.

## Context

The `cern + analyze` cell in `ActionDispatch.swift` currently routes to
exactly one producer: `CernAnalyzeProducer` → `pylhe@<v>` round-trip
(`~/core/hexa-lang/stdlib/cern/lhe_stats.py`, D61-compliant-from-birth).
This cell was filled in the cohort round (post-merge reconstructed; no
standalone PLAN κ / D-block).

κ-49 (PLAN.md @ commit `275781e7`) landed a SECOND substrate for the
same cell — `~/core/hexa-lang/stdlib/cern/elegant_tracking.py` — an
Xsuite 6-D tracking / dynamic-aperture producer (ROI 14). κ-49
explicitly **deferred the Swift wiring** with this note:

> "substrate only, Swift wiring defer — 기존 cern+analyze pylhe 가
>  이미 dispatch 점유, producer-alternative 메커니즘 후속 라운드"

ActionDispatch routes by `(verb, domain)` tuple only (see lines
146–230 of `cockpit/Sources/DemiurgeCore/Loaders/ActionDispatch.swift`)
— one producer per cell. We now need a decision on the mechanism by
which a domain can carry MORE THAN ONE alternative producer.

This document presents options + a recommendation. **No dispatch /
producer wiring is changed by this commit** — note only. The user
will gate the final pick in a follow-up session.

## Honest-scope framing (g3)

Both substrates emit honest `GATE_OPEN / absorbed=false` records:

- **pylhe** (existing): LHE round-trip on a synthetic e+e- → Z → mu+mu-
  sample. Numbers are real (parser end-to-end), but input events are
  synthetic kinematics (NOT MadGraph/POWHEG/Sherpa output, NOT LHC
  data). `absorbed=true` requires tuned generator card + detector
  simulation — out of scope here.
- **Xsuite elegant_tracking** (new κ-49): single-particle 100-turn
  tracking on a FODO cell (same lattice as `cern + synthesize`). Real
  DA scan = thousands of particles × tens-of-thousands of turns ×
  radiation damping — out of scope here.

Both produce REAL substrate numbers; neither produces an absorbed
physics claim. So the choice between them (or both) is about
**substrate coverage**, not honesty hierarchy.

Notably: cern domain already has 4/4 cells filled
(analyze=pylhe · synthesize=xsuite_optics · verify=bethe_bloch ·
the κ-49 "complete cern 4/4" note in `elegant_tracking.py` header is a
status statement, not a wiring change). Adding Xsuite to `+analyze`
would make cern the FIRST domain with two distinct substrates in a
single (verb, domain) cell. The mechanism we pick here will be reused
for any future cell that wants alternative substrates.

---

## Options

### (A) Replace pylhe → Xsuite — drop pylhe wiring, route to elegant_tracking

Pylhe substrate file stays on disk (no deletion) but is no longer
dispatchable. ActionDispatch's `(verb=.analyze, domain="cern")` case
returns an `Xsuite-tracking`-backed `CernAnalyzeRecord` (Record struct
needs schema migration: `pylhe_version` → e.g. `xsuite_version` or
a producer-agnostic `substrate_version` map).

**Pros**:
- Smallest dispatch surface — still one-producer-per-cell, mechanism
  unchanged.
- Xsuite tracking is closer to a "real accelerator measurement" feel
  than LHE round-trip — beam-physics rather than file-format echo.
- Pylhe had zero `absorbed=true` claim — drop loses nothing real.

**Cons**:
- Loses LHE-parser coverage (the one thing pylhe actually witnesses —
  pylhe IS a real measurement of its own parser end-to-end on
  standards-compliant LHE v3).
- `CernAnalyzeRecord` schema migration touches existing `exports/cern/
  lhe/` record consumers (cockpit pretty-print, RecordLoader, CLI).
- Pre-existing records on disk become orphaned / require a translation
  layer or a schema-version-2 split.
- Loses information per @D `g_ssot_single_source` — pylhe substrate
  becomes dead code with no caller (substrate SSOT in hexa-lang
  without a demiurge consumer is fine, but it complicates the "every
  demiurge cell has 1:1 substrate" picture).

### (B) Sub-verb in ActionDispatch — `(verb, domain, sub)` triple

Extend the dispatch tuple. E.g. `(.analyze, "cern", "lhe")` →
CernAnalyzeProducer; `(.analyze, "cern", "tracking")` →
CernTrackingProducer. UI surfaces sub-verb as a third selector. CLI
accepts `demiurge action analyze cern lhe`.

**Pros**:
- Explicit + visible: user can choose, no hidden default.
- Each substrate gets its own Record type — no schema collision.
- Cleanly extensible — any future cell can fan out.

**Cons**:
- **Invasive — touches every cell**. The 35+ existing dispatch arms
  all become tuple-3 patterns. `Verb` enum stays as-is, but
  `runEngineTool(verb:, domain:)` becomes `runEngineTool(verb:,
  domain:, sub:)` and every call site needs the new param (UI button,
  CLI subcommand, chat backend, rfc_011 §6 action prompt).
- Confuses the n6 grid story (rfc_011): the cell IS `(verb, domain)`;
  sub-verb implies the cell has internal structure, which forks the
  measurement-gate accounting per sub (do we track separate gates per
  sub-substrate? probably yes — schema spreads).
- Every record-ID parser + cockpit pretty-print needs the sub
  embedded — D50 byte-identical CLI ↔ cockpit guarantee gets harder.
- Premature generalization for ONE pair of substrates.

### (C) Producer registry — domain has multiple producers; dispatch picks default + user override

Introduce a `ProducerRegistry` indexed by `(verb, domain)` →
`[ProducerHandle]` (ordered, first = default). `runEngineTool`
becomes a two-step:
1. lookup `registry[(verb, domain)]`
2. invoke the default OR pass-through an optional `producer:` override
   from caller (cockpit dropdown, CLI flag `--producer xsuite`).

Each ProducerHandle holds an ID string + a closure returning
`(text, newRecordID?, ok)`.

**Pros**:
- One central place to add alternatives — no `switch` churn beyond a
  single registry-init block.
- Mechanism scales to N producers per cell without further dispatch
  refactor.
- Caller (cockpit / CLI) decides whether to surface the override or
  always take default — UI complexity is opt-in.
- Default-first keeps backwards compat (existing button still hits
  pylhe — no schema migration today).
- Aligns with @D `ai-native` (deterministic routing-by-key, not
  LLM-guess) and `domain-meta-domain` (registry is a self-describing
  list per cell).

**Cons**:
- Touches `runEngineTool` signature OR adds a parallel entry point
  `runEngineToolWithOverride(verb:, domain:, producer:)`.
- Each producer still needs its own Record type (Xsuite tracking
  numbers don't fit `CernAnalyzeRecord`'s LHE-stats shape) — so a
  registry entry binds `(producer-id → record-type)` and downstream
  record consumers need to dispatch on producer-id (UI / CLI
  pretty-print).
- "Default" picks a winner — which substrate is "first"? Needs a
  policy (probably: alphabetical OR first-landed OR explicit-pin in
  domain governance).

### (D) Tag-based — both substrates emit the SAME Record shape, distinguished by `kind` string

Both producers spawn, both append a record with a `kind` field
(`"lhe-roundtrip"` vs `"xsuite-tracking"`). One dispatch call →
multiple records (concatenated output).

**Pros**:
- No dispatch refactor — one cell still maps to one Producer; the
  Producer internally fan-outs to N substrates.
- User sees both substrates' numbers in one shot — convenient.

**Cons**:
- Forces the two Record shapes into one struct — `CernAnalyzeRecord`
  would have to carry BOTH LHE stats AND Xsuite tracking fields, most
  of which are nil-per-run. Worst of both worlds for schema clarity.
- Every run pays the cost of every substrate — no user choice to
  skip the heavy one. Xsuite installs on macOS but isn't free; future
  alternatives like elegant (heavy container) would block the cell
  entirely.
- Failure semantics get murky: if pylhe passes and Xsuite fails, is
  `engineToolSucceeded = true OR false`? rfc_011 §6's
  `ActionResult.engineToolSucceeded` is a single bool — fan-out
  breaks it.
- @D `ai-native` principle (one fact, one canonical file) erodes —
  one Record file now mixes two unrelated measurements.

---

## Recommendation: **Option (C) — Producer registry, default + override**

Rationale:

- **It's the only option that scales past one pair**. (A) loses
  substrate coverage; (B) invasively rewrites every cell for a
  problem that today affects exactly one cell; (D) collapses two
  honest measurements into one schema-confused record. (C) adds the
  mechanism once + leaves all OTHER cells untouched (their registry
  entry is just `[singleProducer]`).
- **It preserves the existing pylhe wiring** (default stays pylhe →
  zero schema migration, zero risk to live `exports/cern/lhe/*.json`
  records, zero churn for cockpit pretty-print). The Xsuite Swift
  wiring lands incrementally as `CernTrackingProducer` + a new
  `CernTrackingRecord` type, registered as the second handle under
  `(.analyze, "cern")`. Surface-area decision (button dropdown?
  hidden CLI flag?) is deferred — registry alone unblocks the
  substrate.
- **It aligns with the @D principles** (`ai-native` =
  deterministic-routing-by-key over guesswork; `hexa-first` =
  substrate SSOT in hexa-lang already exists, demiurge just adds the
  Swift-side handle; `andrej-karpathy-skills` = minimum code, every
  changed line traces to "one cell has two substrates now"). The
  invasive sub-verb refactor (B) violates karpathy-skills surgical-
  change criterion.
- **Honest scope stays clean** (g3): both substrates remain
  `GATE_OPEN / absorbed=false`; the registry doesn't change gate
  arithmetic — each producer emits its own record with its own
  scope_caveats list. The cockpit/CLI surfaces an explicit "Producer:
  pylhe / Xsuite" indicator so the user can't conflate the two
  measurements.
- **Backwards compat**: existing `(verb, domain)` dispatch is a
  one-line lookup `registry.default(for: (verb, domain))` —
  `runEngineTool`'s existing public signature can stay unchanged;
  the override entry point is additive.

### Suggested phased rollout (post-decision, separate session)

1. Introduce `ProducerRegistry` (single file, ~50 LoC) with one entry
   per existing cell, all `[singleProducer]`. `runEngineTool` becomes
   a registry lookup. No behavior change.
2. Add `CernTrackingRecord` + `CernTrackingProducer` (Swift). Register
   as second handle under `(.analyze, "cern")`.
3. Decide UI surface — recommend: CLI flag `--producer <id>` first
   (cheap), cockpit dropdown deferred until 2nd cell with alternatives
   appears.
4. Update rfc_011 §6 to mention the registry + the alternatives
   discoverability ("`demiurge action analyze cern --list-producers`").

---

## Cross-references

- `cockpit/Sources/DemiurgeCore/Loaders/ActionDispatch.swift` — the
  `(verb, domain)` switch (lines 146–230) that this decision targets.
- `cockpit/Sources/DemiurgeCore/Loaders/CernAnalyzeProducer.swift` —
  the existing pylhe-backed producer.
- `cockpit/Sources/DemiurgeCore/Models/CernAnalyzeRecord.swift` —
  the LHE-shaped record that recommendation (C) leaves untouched.
- `~/core/hexa-lang/stdlib/cern/lhe_stats.py` — existing pylhe
  substrate.
- `~/core/hexa-lang/stdlib/cern/elegant_tracking.py` — new κ-49
  Xsuite substrate awaiting Swift wiring.
- `PLAN.md` @ κ-49 entry (lines 3689–3716) — the defer note that
  produced this decision request.
- `inbox/notes/absorption-empty-cells-research-2026-05-20.md` — ROI
  ranking that placed Xsuite tracking at rank 14 ("cern+analyze —
  elegant/Xsuite, container, ⭐⭐⭐, elegant heavier").

## Open questions for the user gate

1. Confirm Option (C) — or pick (A) / (B) / (D)?
2. If (C): default = pylhe (recommended) or default = xsuite-tracking?
3. UI surface — CLI-flag-only (recommended), or cockpit dropdown too?
4. Do we add a `cern.governance` line to AGENTS.md `## Governance`
   noting "domain cern carries alternative producers; default = pylhe"
   per @D `project-governance`?
