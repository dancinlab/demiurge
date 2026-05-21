# D111 Phase B Bug #2 — `Verb.canonical` Korean drift vs `cellrun.hexa` English

> **Status**: design-decision OPEN · 3 options ranked · awaiting user pick.
> **Untracked inbox note** — not staged, not committed. User reviews and
> ratifies the chosen option via `design.md` D-block (D111 follow-on).

---

## § 0. Purpose

Bug #2 design decision: `Verb.canonical` returns Korean engineering labels
(`명세 / 구조 / 설계 / 해석⟲ / 합성 / 검증 / 인계`) but `cellrun.hexa` and
all `.demi` manifests use English section keys (`[cell.analyze]` etc.).
Phase B `CellrunDispatch.swift` works around this with a private
`englishName(Verb) -> String` switch. This note lays out three options
(`α` Swift / `β` hexa / `γ` keep-helper) and recommends one — NOT a
unilateral fix.

---

## § 1. Bug manifestation (Phase B workaround context)

In `~/core/demiurge-phaseb/cockpit/Sources/DemiurgeCore/Loaders/CellrunDispatch.swift`
(branch `d111-phaseb-sscb-migration@deffc92`), lines 150–165:

```swift
/// Map a Swift `Verb` to the english identifier expected in the
/// `[cell.<verb>]` manifest section header. The Project.swift Verb
/// enum's `canonical` property returns the Korean engineering term
/// (해석⟲ / 합성 / 검증) — the manifest dialect uses the english
/// enum-case name, so we surface that here instead.
public static func englishName(_ verb: Verb) -> String {
    switch verb {
    case .specify:    return "specify"
    case .structure:  return "structure"
    case .design:     return "design"
    case .analyze:    return "analyze"
    case .synthesize: return "synthesize"
    case .verify:     return "verify"
    case .handoff:    return "handoff"
    }
}
```

Used at line 203:
```swift
proc.arguments = ["run", cellrun, domain, englishName(verb)]
```

The hexa side (`~/core/hexa-lang-cellrun/stdlib/cockpit/cellrun.hexa`)
takes the verb arg verbatim and substitutes it into the manifest
section lookup (`let target_header = "[cell." + verb + "]"`, line 310).
Every `.demi` manifest on disk (e.g. `domains/sscb.demi` §
`[cell.analyze] / [cell.synthesize] / [cell.verify] / ...`) uses the
English section keys. So the SSOT-on-disk dialect is already English.

The drift exists only inside the Swift `Verb.canonical` getter and
flows through anywhere that property is interpolated into a string
that crosses an identifier boundary.

---

## § 2. `Verb.canonical` caller audit

Source: `grep -rn '\.canonical' cockpit/Sources/ cockpit/Tests/`,
filtered to Verb-related call sites. **17 call sites total in Sources,
0 in Tests.** Categorized by what the caller expects:

| File:line | Context | Expected role |
|---|---|---|
| `CockpitApp.swift:269` | `"\(verb.plain)(\(verb.canonical)) 입니다. \(verb.hint)"` | display string (Korean OK) |
| `CockpitApp.swift:287` | `"▶ \(verb.plain)(\(verb.canonical)) 단계 실제로 돌리기"` | display string (Korean OK) |
| `CockpitApp.swift:433` | `"\(verb.rawValue + 1)/7 \(verb.canonical)(\(verb.plain))."` | display string (Korean OK) |
| `CockpitApp.swift:470` | `Text(expertMode ? verb.canonical : verb.plain)` | UI label (Korean OK) |
| `CockpitApp.swift:534` | `Text(expertMode ? project.currentVerb.canonical : project.currentVerb.plain)` | UI label (Korean OK) |
| `CockpitApp.swift:558` | `Text(expertMode ? verb.canonical : verb.plain)` | UI label (Korean OK) |
| `CockpitApp.swift:562` | `Text(verb.canonical)` | UI label (Korean OK) |
| `CockpitApp.swift:618` | `"\(project.currentVerb.plain)(\(project.currentVerb.canonical)) 단계 실제로 돌리기"` | display string (Korean OK) |
| `CockpitApp.swift:696` | `"1단계 \(Verb.specify.plain)(\(Verb.specify.canonical))부터 "` | display string (Korean OK) |
| `DemiurgeCLI/main.swift:161` | `"  \(p.name)  —  \(domain.label) · \(verb.rawValue + 1)/7 \(verb.canonical)"` | CLI label (Korean OK) |
| `DemiurgeCLI/main.swift:188` | `"  \(verb.rawValue + 1). \(verb.canonical) (\(verb.plain))  \(mark)"` | CLI label (Korean OK) |
| `DemiurgeCLI/main.swift:203` | `"  \(verb.rawValue + 1). \(verb.canonical):"` | CLI label (Korean OK) |
| `DemiurgeCLI/main.swift:254` | `"action: \(verb.canonical) (\(verb.plain)) · domain=\(domain) ..."` | CLI label (Korean OK) |
| `Models/Ingredient.swift:50` | `guard verb.canonical.hasPrefix(lineVerb) else { continue }` | **string-match against `domains/<domain>.md` §6** (Korean "해석" prefix) |
| `Loaders/ActionDispatch.swift:118` | `"... \(verb.canonical) stage of a demiurge project ..."` | LLM prompt text (either OK — would prefer English if asking an LLM, but Korean works) |
| `Loaders/ActionDispatch.swift:161` | `"unknown producer ... for \(verb.canonical) + \(domain). Available: ..."` | honest-fail banner (either OK) |
| (Phase B) `Loaders/CellrunDispatch.swift:203` | `proc.arguments = ["run", cellrun, domain, englishName(verb)]` | **identifier — must be English** |

### Audit summary

- **15 / 17** callers want Korean (UI / CLI / chat-banner display).
- **1 / 17** (`Ingredient.swift:50`) does a *string-match against a
  Korean header* in `domains/<domain>.md` §6. The comment explicitly
  says: `// §6 writes the verb short ("해석"); Verb.canonical is "해석⟲".`
  This caller would break if `canonical` flipped to English — would
  need a parallel `koreanLabel` getter.
- **1 / 17** (Phase B `CellrunDispatch.swift`) wants English — the
  bug-#2 site, currently handled with the `englishName(_:)` helper.
- **0 / 17** in Tests — flipping `canonical` would not break any
  XCTest assertion as of `main@06a8428`.

### Architectural note

- Swift `Verb` enum case names ARE English (`case specify, structure,
  design, analyze, synthesize, verify, handoff`). `String(describing:
  Verb.specify)` returns `"specify"` — i.e. the English identifier is
  already trivially derivable from the enum without a switch.
- No existing `englishName` / `wireName` / `rawName` getter on `Verb`.
- ARCH §3 (lines 246–259) renders the spine as `명세 (specify) →
  architecture spec ...` — Korean leads, English follows in parens.
  The current `// canonical = engineering term` doc-comment in
  `Project.swift:14-15` is consistent with that.

---

## § 3. Option α — Swift change: `Verb.canonical` → English

Modify `cockpit/Sources/DemiurgeCore/Models/Project.swift::Verb.canonical`
to return English (`"analyze"`) and introduce a new computed property
`koreanLabel` (or rename `canonical` → `displayLabel` and add a fresh
`canonical: String` that returns the wire identifier).

### Pros

- `cellrun.hexa` stays English-pure (matches existing `.demi` manifest
  dialect + hexa stdlib convention of ASCII identifiers).
- `englishName(_:)` helper in `CellrunDispatch.swift` deletes; future
  Swift→cellrun dispatchers (action result emitters, etc.) just use
  `verb.canonical` and Just Work.
- The word *canonical* in software typically means *wire identifier*,
  not *display label* — current naming inverts that idiom.

### Cons

- **15 display call sites must migrate** from `verb.canonical` to
  `verb.koreanLabel` (or whatever new name). Mechanical sed across
  `CockpitApp.swift / DemiurgeCLI/main.swift`, but every site is a
  visible UI string — needs visual QA pass.
- `Ingredient.swift:50` (the §6 string-match) must switch to the
  Korean-label getter, AND the comment that explains the §6 dialect
  needs an update.
- ARCH §3 narrative (and the existing `// canonical is the engineering
  term` doc-comment on the enum itself) must clarify the new policy:
  **"English = internal identifier; Korean = display"**. Not a huge
  doc lift but it inverts a 6-month convention.
- 2 LLM-prompt sites (`ActionDispatch.swift:118, 161`) currently
  surface Korean in LLM messages; flipping to English changes the
  prompt's tone slightly (probably fine; LLMs are bilingual).

### Cost / risk

- LOC delta: ~20 (enum body) + ~17 (call-site renames) = ~40 lines
  touched across 3 files.
- Session est: 45–75 min including visual QA and ARCH §3 doc update.
- Risk: medium — a missed call-site silently flips an English string
  into the UI. Searchable via the compiler if `canonical` is renamed
  (rather than repurposed), so a *rename* is safer than a *flip*.

---

## § 4. Option β — `cellrun.hexa` accepts both English AND Korean

Modify `~/core/hexa-lang/stdlib/cockpit/cellrun.hexa::cell_run_with_roots`
to normalize the `verb` arg before the `[cell.<verb>]` lookup:

```hexa
fn normalize_verb(v: string) -> string {
    if v == "해석⟲" or v == "해석" { return "analyze" }
    if v == "합성" { return "synthesize" }
    if v == "검증" { return "verify" }
    if v == "명세" { return "specify" }
    if v == "구조" { return "structure" }
    if v == "설계" { return "design" }
    if v == "인계" { return "handoff" }
    return v   // already English (or pass-through)
}
```

### Pros

- Zero Swift caller breakage: every existing `verb.canonical` site
  continues to work; the Phase B `englishName(_:)` helper still
  becomes deletable.
- Centralizes the translation in *one* place (the dispatch boundary
  on the hexa side), which is plausibly the right architectural
  layer: "hexa-lang's cellrun is a bilingual public API."

### Cons

- Hexa stdlib convention is ASCII identifiers. Pollutes
  `cellrun.hexa` with a UTF-8 hard-coded Korean table — every other
  stdlib utility stays English. Sets a precedent.
- UTF-8 string equality in hexa-lang stdlib is *believed* to work
  for `==`, but multi-byte slicing / `.hasPrefix(...)` / etc. on
  Korean strings hasn't been broadly exercised — could surface
  hexa-lang stdlib bugs (κ-68 / κ-XX absorption cycle adjacent).
- The translation table becomes a hexa-lang concern, which means
  every future verb rename (extremely unlikely, but) requires a
  hexa-lang PR rather than a Swift PR.
- Couples hexa-lang to demiurge's specific Korean naming choices.
  hexa-lang is supposed to be a domain-agnostic stdlib (ARCH §0
  hexa-only ultimate form); embedding `해석⟲ → analyze` there
  leaks demiurge naming upward.

### Cost / risk

- LOC delta: ~12 (one normalize fn) in `cellrun.hexa` only. Plus
  hexa-lang PR review (separate cycle).
- Session est: 20–30 min (Swift side stays untouched — but a
  hexa-lang PR adds review-cycle latency).
- Risk: low-to-medium — depends on UTF-8 hardening of hexa-lang
  stdlib `==` operator for Korean strings. Concurrent agent on
  bug #3 (Python candidates) is already touching `cellrun.hexa`;
  merge-coordination cost is real.

---

## § 5. Option γ — Keep Swift-side `englishName(Verb)` helper (current shape)

Make the Phase B workaround permanent. Optionally promote it from
private to public on `CellrunDispatch` (or move to a thin extension
`Verb.wireName` in `DemiurgeCore`).

### Pros

- Already shipped on Phase B branch. Zero new work needed to lock
  in.
- Decision boundary is clean: *Swift owns its display dialect, and
  serializes to English right before dispatch.* Mirrors how
  `RecordLoader` etc. centralize JSON-encoding decisions at the
  edge.
- No risk to existing call sites; no hexa-lang PR coupling.
- Doc-comment on `Verb.canonical` ("engineering term") stays
  honest.

### Cons

- Every *future* Swift→hexa dispatcher must remember to call
  `englishName(_:)` (or whatever centralized helper). Forgetting it
  is a *silent bug* — `cellrun.hexa` would say `[cellrun] manifest
  cell.해석⟲ not found in sscb.demi` rather than corrupting data,
  but it's still a debugging dead-end for whoever ships the new
  dispatcher.
- Two sources of truth for "what is the wire name of `Verb.analyze`":
  - implicit: the enum case name `analyze` (i.e. `String(describing:
    verb)`)
  - explicit: the `englishName(_:)` switch
  Drift risk is low (both are static & co-located) but nonzero.
- If we keep this, the helper should be **promoted to a `Verb`
  extension property** (`verb.wireName` or `verb.englishName`) so
  it's discoverable via dot-completion — leaving it as a private
  static on `CellrunDispatch` makes it un-findable from new code.

### Cost / risk

- LOC delta: ~0–15 (depending on whether we promote the helper to a
  Verb extension or leave it where Phase B put it).
- Session est: 0–15 min.
- Risk: low (status quo); steady-state cost is "future-dispatcher-
  authors must remember the helper exists" — mitigated by promoting
  to extension property.

---

## § 6. RECOMMENDED option

### Recommendation: **Option α** (with a rename, not a repurpose)

Rationale (3 sentences):

1. The word *canonical* in software universally means *wire identifier
   / serialized form*, and the `.demi` manifest SSOT on disk + the
   hexa-lang stdlib + the Swift enum case names ALL already use the
   English form — so English is what's *actually* canonical;
   `Verb.canonical = "해석⟲"` is misnamed today.
2. Doing this as a **rename** (`canonical` → `koreanLabel` /
   `displayLabel`, and add a new `canonical: String` that returns the
   wire identifier — or use `String(describing: self)` directly) gets
   the compiler to flag every call-site, eliminating the silent-flip
   risk and turning Option α from a *visual-QA exercise* into a
   *mechanical compiler-driven migration*.
3. Option β leaks demiurge's Korean dialect into hexa-lang (which is
   architecturally domain-agnostic), and Option γ leaves a foot-gun
   for every future Swift→hexa dispatcher.

### Ranking

1. **α** (Swift rename) — best long-term shape, ~45–75 min.
2. **γ** (keep helper, promote to Verb extension) — pragmatic
   compromise if α is judged too disruptive mid-Phase-B; ~15 min.
3. **β** (hexa-side bilingual) — works, but leaks dialect upward and
   couples to UTF-8 hexa-stdlib hardening that hasn't been exercised.

---

## § 7. Open questions for user

1. **Naming after the flip**: if we go α, what should the two getters
   be called? Options:
   - `canonical` (English wire) + `koreanLabel` (display) — clearest
     intent, follows software convention.
   - `wireName` (English) + `canonical` (Korean, kept for ARCH §3
     fidelity) — minimum churn on ARCH narrative.
   - `englishName` + `koreanName` — symmetric, no ambiguity.
2. **ARCH §3 narrative**: §3 currently presents the spine as
   `명세 (specify) → ...` (Korean lead). Should the doc shift to
   `specify (명세) → ...` to mirror the new "English is canonical"
   policy, or keep §3's Korean-lead display while documenting the
   internal-vs-display distinction in §3a / a footnote?
3. **Backward-compat boundary**: any `.demi` files or persisted
   `Project.json` manifests on disk that key off `verb.canonical`'s
   *current* Korean string? (`Verb` is `Int`-backed in `Project`'s
   `Codable`, so `Project.json` should be safe — but worth a
   `grep -rn '해석⟲\|합성\|검증' exports/ inbox/` audit before
   landing.)
4. **Phase B branch interaction**: the Phase B branch already ships
   the `englishName(_:)` helper. If we land α on `main` *before*
   Phase B merges, do we surgical-remove `englishName(_:)` in the
   Phase B PR's final pass? Or land α as a Phase B precursor commit?
5. **`Ingredient.swift:50` §6 prefix-match**: if α renames
   `canonical` → `koreanLabel`, the `verb.canonical.hasPrefix(lineVerb)`
   line trivially switches to `verb.koreanLabel.hasPrefix(lineVerb)`.
   But the upstream `domains/<domain>.md` §6 dialect is *Korean-only*
   — confirming that's intentional and not also drifting toward
   English would be honest.

---

## § 8. Migration cost per option

| Option | LOC delta | Files touched | Session est | Risk | Doc lift |
|---|---|---|---|---|---|
| α — Swift rename | ~40 | 3 (Project.swift + 2 callers in CockpitApp/CLI) + tests if any | 45–75 min | medium (UI strings — mitigated by *rename* getting compiler help) | ARCH §3 narrative footnote |
| β — hexa bilingual | ~12 | 1 (cellrun.hexa) + hexa-lang PR cycle | 20–30 min Swift, +1 review cycle hexa | low-medium (UTF-8 stdlib coverage) | hexa-lang PR description |
| γ — keep helper | ~0–15 | 0–1 (optional promote to Verb extension) | 0–15 min | low | doc-comment on Verb |

---

## § 9. References

- `~/core/demiurge/cockpit/Sources/DemiurgeCore/Models/Project.swift:16-32`
  — `Verb` enum + `canonical` getter (current Korean output).
- `~/core/demiurge-phaseb/cockpit/Sources/DemiurgeCore/Loaders/CellrunDispatch.swift:150-165,203`
  — Phase B `englishName(_:)` workaround.
- `~/core/hexa-lang-cellrun/stdlib/cockpit/cellrun.hexa:282-310,669-784`
  — manifest section lookup using `verb` arg verbatim.
- `~/core/demiurge/domains/sscb.demi` (and all other `.demi`) —
  English-only `[cell.<verb>]` section keys on disk.
- `~/core/demiurge/ARCH.md:246-259` — §3 7-verb spine narrative
  (Korean lead, English in parens).
- `~/core/demiurge/cockpit/Sources/DemiurgeCore/Models/Ingredient.swift:49-50`
  — the one non-display `verb.canonical` caller (string-match against
  `domains/<domain>.md` §6 Korean prefix).
