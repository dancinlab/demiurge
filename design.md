# demiurge — design decisions (audit trail)

> Step-by-step decision gate. One block per decision, appended in order.
> Architecture/why SSOT = `CHARTER.md` + `HANDOFF.md` · progress SSOT =
> `PLAN.md`. This file = the decision audit trail that ships with the work.

### Decision 1 — 공개면 클린룸 (public-surface clean-room research boundary)

**picked**: The redesign proceeds under a *public-surface clean-room*
research boundary — neither open-source-only nor closed-binary
reverse-engineering. In scope: OSS code/specs · arxiv & papers (deep
research) · patents (= public reverse-engineering disclosure) · standards ·
datasheets · proprietary tools' *public documentation* (capability/gap
mapping + clean-room re-derivation only). Refused / out of scope:
closed-binary decompilation · license/DRM circumvention · trade-secret
extraction. CHARTER governance updated accordingly; domain rollout = chip
first to measured parity, then incremental expansion.

**rationale**:
- The legitimate substance of "역설계" is fully reachable from the public
  surface — patents are by definition published reverse-engineering
  material, and arxiv/standards/datasheets reconstruct proprietary-tool
  capability and gaps without touching any closed binary.
- Same pattern the family already uses legitimately (hexa-bio ⟵ *published*
  AlphaFold; hexa-matter ⟵ ASE/pymatgen) — clean-room from public
  disclosure keeps demiurge on the established, defensible footing.
- Legally and governance safe: no IP infringement, no license/DRM
  circumvention; consistent with no-over-claim (g1·g2·g3) and
  hexa-native-only (g5).
- Closed-binary decompilation / trade-secret extraction is refused outright
  — excluded explicitly so the audit trail carries no gray area.

### Decision 2 — 별개, 타입드 인터페이스 (demiurge ↔ hexa-matter/hexa-bio)

**picked**: demiurge stays a *separate sibling* of hexa-matter and hexa-bio.
When a domain's verify/simulate step needs material properties it *calls*
hexa-matter; when it needs molecular/chemical modeling it *calls* hexa-bio —
both over a typed interface contract. Neither repo is absorbed into
demiurge. This mirrors the established family idiom where `comb` is a
*consumer* of demiurge[chip], not its absorber. (Rejected: B = absorb only
hexa-matter; C = absorb both.) To be reflected in CHARTER/HANDOFF as part of
the broader redesign deliverable.

**rationale**:
- Family architecture consistency — "siblings, decoupled by design" is the
  already-established idiom (CHARTER); making demiurge a consumer of
  matter/bio is isomorphic to the comb↔demiurge[chip] precedent, zero
  architectural contradiction.
- no-big-bang governance — hexa-matter (16-verb) and hexa-bio
  (WEAVE/NANOBOT) are mature large repos; absorbing them is a big-bang,
  violating HANDOFF §5 "incremental · measured · no big-bang".
- andrej-karpathy simplicity/surgical — demiurge needs only a typed
  interface contract to material/molecular properties, not their internals;
  minimum code, no swallowed scope.
- no-over-claim (g3) — demiurge does not claim material/molecular
  capability it did not measure; it delegates to the repos that did.

### Decision 3 — 하이브리드 시퀀싱 (chip 깊이-우선 + 공개면 맵 병렬)

**picked**: Named cohort = `chip · cern · antimatter · rtsc · space ·
energy · brain` (7). Sequencing = hybrid (option C): chip is taken
*depth-first* as the domain-map template-proving spike (per HANDOFF §9 —
`rfc_001` NoC-sim absorption first), while a *shallow public-surface map*
(Decision 1 scope) runs in parallel across the other 6 cohort domains.
Depth and "absorbed" claims apply to chip only (measured); the other 6 are
mapping, not capability claims. Remaining ~27 repos = later cohorts.
(Rejected: A = chip-only then later; B = all-7 shallow in parallel.)

**rationale**:
- Aligns with Decisions 1 & 2 — public-surface survey is already authorized
  and cheap; chip's depth path is already pinned by HANDOFF §9 (NoC sim
  first), so the two run without conflict.
- Satisfies the user's exhaustive-panorama intent *and* no-over-claim at
  once — the 6 get a shallow public-surface map (mapping, not claims);
  depth/"absorbed" is measured on chip only.
- andrej-karpathy goal-driven/surgical — proving the domain-map template on
  one domain (chip) before replicating minimizes rework risk across the
  other 6; zero big-bang.

### Decision 4 — 파이프라인 verb 는 가설; 조사-우선 (research-first)

**picked**: The 5 verbs `설계(model)→쌓기(synthesize)→적층(layer)→
검증(verify)→계산(simulate)` are treated as an *unvalidated hypothesis*,
not an SSOT — the user stated they were improvised. Proceed research-first:
run the Decision-1 public-surface survey across the named cohort, brainstorm
the actual domain-neutral spine from evidence, then return a *recommended*
pipeline + domain-map. The former structure-template choice (flat-5 vs
flat-7 vs two-layer) is deferred until the spine is evidence-validated;
deciding table shape before the spine would faithfully instantiate an
unvalidated SSOT.

**rationale**:
- The user explicitly flagged the verbs as off-the-cuff — locking a table
  structure (former Decision 4 option A) onto an unvalidated spine would
  build fidelity to a strawman.
- Already authorized — Decision 1 (public-surface clean-room) and Decision 3
  (hybrid: chip deep + 6 shallow) pre-cleared exactly this survey; this is
  execution, not new scope.
- andrej-karpathy think-before-coding — validate the load-bearing
  assumption (the spine) with cited evidence before committing structure;
  prevents downstream rework across all 7 domains.
- no-over-claim — the recommended spine will be grounded in cited public
  prior art (EDA flow, ISO-15288/V-model, MBSE, PLM, domain lifecycles),
  not asserted.

### Decision 5 — canonical 7-verb pipeline spine (evidence-grounded)

**picked**: The domain-neutral pipeline spine is the cited 7-verb form,
replacing the improvised 5-verb strawman:

  명세 SPECIFY → 구조 ARCHITECT → 설계 DESIGN → 해석 ANALYZE →
  합성 SYNTHESIZE → 검증 VERIFY (VALIDATE bound into the gate) →
  인계 HANDOFF

ANALYZE iterates back into DESIGN/SYNTHESIZE (gate, not terminal). Rejected:
B = minimal 5-verb repair (re-conflates ARCHITECT into DESIGN); C = 9-verb
full ISO-15288 (over-grained for a universal spine). Domain-map structure
follows the previously-recommended option A *generalized to 7 verbs*
(one row per verb + per-domain tool bindings + cross-cutting resources
separated + absorption-order annotation) — this is now evidence-forced
(Agent-3: "treat the recurring stages as universal, specialize per-domain
bindings"), so it is applied as a consequence of this decision rather than
re-gated; user retains veto.

**rationale**:
- Evidence across all 9 surveyed lifecycles (ISO/IEC/IEEE 15288, V-model,
  NASA SE, FDA design controls, EDA RTL→GDSII, MBSE/OOSEM, PLM, accelerator,
  spacecraft): SPECIFY is a mandatory entry gate and VERIFY/VALIDATE the
  closing gate — the strawman omitted SPECIFY and placed simulate terminal.
- Reconciles the domain-tool reality (Agent-3: model→synthesize→verify→
  simulate recurs across all 6 surveyed domains) — that core is preserved
  inside the 7-verb form; only entry/exit invariants and ANALYZE position
  are corrected.
- Drops the un-transferable 적층/"layer" metal-stack metaphor for
  ARCHITECT/INTEGRATE-class verbs that hold across all 7 named domains
  (Agent-1: "layer" does not survive transfer to accelerator/spacecraft).
- Right altitude — 7 ≈ NASA Phase A–F / PED-4.0 natural phase granularity;
  C(9) over-grained, B(5) re-conflates; no-over-claim: grounded, cited,
  not asserted.

### Decision 6 — Cohort 2 composition (7 repos, size-matched to Cohort 1)

**picked**: Cohort 2 = `hexa-fusion · hexa-scope · hexa-sscb · hexa-mobility
· hexa-bot · hexa-grid · hexa-aura` (7 repos). Selected from the 27
remaining hexa-* repos under github.com/dancinlab (Agent-3 survey output,
2026-05-18). Cohort 1 (chip-deep + 6 shallow per Decision 3) remains the
depth/template cohort; Cohort 2 gets the same shallow public-surface map
treatment per the D3 hybrid pattern, replicating Cohort 1's
`domains/<name>.md` shape. (Rejected: B = 3-repo HEP-narrow {fusion +
scope + cosmos}; C = 3-repo industrial {sscb + mobility + grid}; D =
5-repo seed-verbatim {fusion + scope + cosmos + sscb + mobility}.)

**rationale**:
- Size matches Cohort 1 (7) — proven no-big-bang cadence; no governance
  recalibration needed.
- Covers 4 of 5 user seed-hints (fusion · scope · sscb · mobility); drops
  only borderline `cosmos` (theory-leaning per its own description; low
  engineering-blueprint affinity).
- Spans 4 deliverable classes simultaneously — physics-instrument
  (fusion / scope) · power-electronics (sscb) · vehicle / robot
  (mobility / bot) · network / wearable (grid / aura) — maximum
  stress-test of the 7-verb spine's universality across non-physics
  engineering (Agent-3 flagged SPECIFY / ARCHITECT / HANDOFF as the
  under-evidenced slots in Cohort 1's cross-domain synthesis).
- All 7 named artifacts are concrete engineering deliverables in their
  own GitHub public description (no "maybe"s); no over-claim risk on
  inclusion grounds.

### Decision 7 — F1/F2 export artifact location: producer-owned

**picked**: F1/F2 measurement records produced by demiurge[chip] live at
`~/core/demiurge/exports/chip/noc/f1f2/` (producer-owned). `comb` reads
by absolute path. Atlas promotion to `~/core/atlas/demiurge::chip::noc::
f1f2/` is **deferred** until a *second* consumer beyond comb materializes
(e.g. cern / grid wanting noc records). (Rejected: B = atlas-registered
now — invents fleet-wide responsibility no third consumer has asked for;
violates lattice-as-tool + andrej-karpathy simplicity.)

Agent-2-defaulted sub-choices (cited governance — no separate user gate
needed; recorded here for transparency):
- Carrier = **HXC v2 byte-canonical wire** + tape v1.2 audit sibling
  (forced by hexa-lang `CLAUDE.md` `@D g_hxc`).
- RFC structure = **split** into new `proposals/rfc_002_f1f2_export_
  interface.md` (HANDOFF §7 "one absorption-RFC per concept"); rfc_001
  receives only a §11 pointer.
- Schema status = **draft v1.0**; frozen only after first measured record
  (`provenance.absorbed = true`) per no-over-claim g3.

**rationale**:
- D2 cleanliness — the interface is between *two* repos (demiurge ↔
  hexa-lang/comb). Atlas promotion now would invent fleet-wide
  responsibility that no third consumer has asked for (lattice-as-tool +
  andrej-karpathy simplicity).
- Audit chain `sim_commit_hash → emit_path → record` colocated inside
  demiurge git — zero cross-repo forensics needed when a measurement is
  later questioned.
- Cross-repo friendliness preserved — absolute path + HXC byte-canonical
  payload means any consumer clone reads identically; no registry server
  required.
- Atlas promotion trigger explicit and recorded — when a second consumer
  appears (e.g. cern, grid), promote then; until then speculative-scope
  is banned (lattice-as-tool g1/g2/g3, no-over-claim).

### Decision 8 — Cohort 3 deferred

**picked**: Cohort 3 is **deferred** — not composed now. Named cohorts
remain Cohort 1 (Decision 3, 7 domains) + Cohort 2 (Decision 6, 7 domains)
= 14 shallow/deep maps plus chip. Agent-8's Cohort-3 survey (recommended
os · earth · cosmos; 14 residual hexa-* repos inventoried by
design-blueprint affinity; 7 never-cohort + 4 defer candidates identified)
is retained in the task record as input for a future re-opening. No
`domains/{os,earth,cosmos}.md` files written.

**rationale**:
- User elected to pass — focus stays on the existing 14-domain surface and
  the in-flight chip-deep work (rfc_001 §8 measurement, rfc_003
  re-derivation) rather than widening domain count now.
- no-big-bang / andrej-karpathy simplicity — not every family repo needs a
  cohort; deferring keeps scope matched to what is actively worked.
- Reversible at zero cost — Agent-8's affinity inventory (Y/maybe/N per
  repo) is preserved, so re-opening Cohort 3 later needs no re-survey.
- The never-cohort list (7 orthogonal substrates) + defer list (4) from
  Agent-8 §4 are NOT recorded as governance yet — available to land
  separately if the user later wants the 35/35 audit-completeness artifact.

### Decision-gate note on Agent-2 location finding

Agent-2 discovered `rfc_057` does **not** exist under `~/core/hexa-lang/
proposals/`. The canonical "RFC 057" lives at `~/core/hexa-lang/comb/
RFC.md` (its own SSOT per flame/forge precedent). Recorded here so the
audit trail does not assume `proposals/rfc_057_*`; cross-references in
demiurge should cite `comb/RFC.md` + the operationalization files
(`comb/T1_experiment.md`, `comb/T1A_analytical.md`,
`comb/sim/f1_parametric.hexa`).

### Decision 9 — §B partial-gate marker (`GATE_B_PINNED_MET`)

**picked**: Introduce an explicit intermediate measurement-gate state
**`GATE_B_PINNED_MET`** between `GATE_OPEN` and `GATE_CLOSED_MEASURED`.
`provenance.absorbed` stays **false**. Meaning: the hexa-native
re-derivation (`stdlib/booksim/sweep.hexa` integrating the 6 modules)
reproduced the rfc_003 §4 *pinned* §B acceptance criteria (4/4 rows +
Leighton oracle PASS; ZLL −0.5%) **under a documented model
simplification** (aggregate mean-field DES + PPIN §25 closed form, not
per-flit; scaled convergence window) and with the mid-curve / §D NOT
yet matched. Added to the `measurement_gate` enum in
`proposals/rfc_002_f1f2_export_interface.md` (§1 table, §4 provenance
table), `exports/chip/noc/f1f2/schema/v1_0.md`, and noted in
`proposals/rfc_001_booksim2_noc_absorption.md` §8. Existing external-
reference NoC-sim records are NOT relabeled (they are BookSim2-external,
not the hexa-native parity demonstration); the marker applies to the
hexa-native re-derivation status (PLAN.md + future Phase-F hexa-native
record). (Rejected: B = plain false, prose-only — loses the
machine-readable partial-progress signal for the comb consumer;
C = flip absorbed=true — over-claims, g3 violation, since full-curve
parity + §D are not demonstrated.)

**rationale**:
- g3 no-over-claim preserved both ways — `absorbed` stays false (full
  parity NOT demonstrated: mid-curve deviates ≈3.4× @0.40, knee
  band-edge, §D undone, model simplified) so no over-claim; the real
  pinned-criteria pass is not erased either, so no under-claim.
- Machine-readable honest signal for the consumer — comb consumes the
  F1F2 interface; `GATE_B_PINNED_MET` tells comb "hexa-native
  re-derivation reproduces §B pinned metrics under documented
  simplification", actionably distinct from both `GATE_OPEN` (nothing
  demonstrated) and `GATE_CLOSED_MEASURED` (full parity).
- Audit precision — design.md + schema fields record EXACTLY what was
  and was not demonstrated; matches measured-not-asserted discipline
  (lattice-as-tool g1·g2·g3).
- Minimal, reversible schema surface — one enum value, scoped to the
  hexa-native re-derivation status; existing records untouched (no
  mislabeling of external-reference records).

### Decision 10 — demiurge scope = design-only; execution-parity is a gated non-goal

**picked**: demiurge proceeds **design-only** (user: "demiurge
설계만 진행"). The deliverable is the *design*: the 7-verb spine, the
absorption RFCs (rfc_001 / rfc_002 / rfc_003), the clean-room
hexa-native re-derivation modules (`stdlib/booksim/*.hexa` — 6 landed,
self-tested, provenanced, at `GATE_B_PINNED_MET`), the typed F1F2
interface + schema, the 14 domain maps, and the external-reference
measurement records that characterize comb T1A's inequality. **Full-
curve parity, §D, and the `absorbed=true` flip are an execution gate,
explicitly OUT of demiurge design scope** — not pursued under
demiurge unless the user re-opens it. Re-entry condition (faster
substrate / bounded per-flit DES) is preserved in rfc_003 §7 + the
agent reports.

**rationale**:
- Charter-consistent — demiurge is defined as a "technical-design
  architecture program"; "design complete, execution gated" is the
  same discipline already applied to fab (CHARTER non-goal:
  tapeout-ready *design* only) and to comb's own T3 (RFC 057 §6:
  design-only, fab/execution a non-goal). Extending it to
  measurement-parity is coherent closure, not a retreat.
- no-over-claim honored at closure — `GATE_B_PINNED_MET` +
  `absorbed=false` stand; nothing asserted beyond what was measured.
  The design artifacts (RFCs, re-derivation modules, schema, records)
  are real, self-tested, and shipped.
- The binding blocker (interpreted hexa-lang toolchain throughput
  ~1e4 ops/s) lives in hexa-lang, not demiurge — hexa-first principle
  says fix it there PR-only; chasing it under demiurge would
  mis-place the work and risk SKIP-mode pressure on g3.
- Reversible at zero cost — the rfc_003 §7 phased path + agent reports
  document the exact re-entry; re-opening the execution gate later
  needs no rework.

### Decision 11 — "전부 아우르는" = meta-conductor (D2 preserved)

**picked**: demiurge is the **meta-conductor** of a *chained series*
of 7-verb domain passes (`rfc_004` §3 option A). 물질합성 → 칩아키텍쳐
→ 부품설계 is the cited spine applied in series: each pass's HANDOFF
feeds the next pass's SPECIFY via a typed inter-stage contract
(rfc_002-style per seam). demiurge owns the chain/orchestration, the
seam contracts, and the per-domain *tooling* absorption (EDA stack
etc., rfc_005..012 §5). hexa-matter / hexa-bio remain **typed-
interface-consumed providers, NOT absorbed** — Decision 2 stands,
unre-litigated. (Rejected: B monolith re-absorb — breaks D2 /
no-big-bang / the HEXA sibling-family architecture, unbounded scope;
Defer — declined, user picked A.) Does not touch any `absorbed`
state; pure scope-architecture reading. Design-only (D10) — rfc_004
is the *plan*; building/execution stays gated.

**rationale**:
- Delivers the user's "물질합성부터 부품설계까지 전부 아우르는 1
  프로젝트" literally — one program conducts the whole chain — without
  breaking the constraint that has held all session (D2 decoupled
  siblings, no-big-bang, sibling family).
- No new mechanism — the cited 7-verb spine is already chainable
  (HANDOFF→SPECIFY seam); meta-conductor = wiring existing passes in
  series. andrej-karpathy: minimum new structure.
- Honest scope split — demiurge absorbs *tooling* it can clean-room +
  measure; it *consumes* mature science siblings via typed contracts
  it cannot honestly re-derive. g3 no-over-claim intact.
- Incremental & reversible — each chain seam / library is its own
  absorption-RFC; the program grows per-domain, never big-bang;
  re-opening B later would still be possible but is explicitly not
  chosen.

### Decision 12 — governance transition: D10 rescinded · D2/D11 rescinded-for-hexa-matter · g3 RETAINED

Triggered by user directives ("design only 규율 아님.. 제거" · "hexa-matter
완전 흡수 후 archive_hexa-matter 리네임 + 로컬 삭제" · "comb 들고와
demiurge/archive 보관") + confirmations (1·2·3 ok).

**picked**:
- **D10 RESCINDED** — design-only scope lifted (user directive). demiurge
  resumes full scope incl. execution/absorption. Legitimate scope reversal
  (user owns scope); no integrity impact.
- **D2 / D11 RESCINDED *for hexa-matter only*** — hexa-matter moves from
  typed-interface-consumed to **full-absorb-then-tombstone** (rfc_005,
  rfc_047/048 pattern). D2/D11 OTHERWISE STAND: hexa-bio stays
  typed-interface-consumed; comb stays the decoupled consumer; the
  meta-conductor framing (D11) is unchanged except hexa-matter becomes an
  *absorbed in-tree domain* instead of a consumed sibling.
- **g3 (no-over-claim) RETAINED** — the user's g3-removal request was
  **declined** (removing it would sanction asserting unmeasured/over-stated
  results = fabricated progress; it is the project's honesty floor and is
  inherited from the user's own identity SSOT). User confirmed #2: g3
  stays. Consequence: "완전 흡수" is recorded as a *measured absorption
  program* (rfc_005, with a selftest/parity GREEN gate), NOT an instant
  "흡수 완료".
- **comb = archive snapshot only** — frozen non-SSOT mirror at
  `demiurge/archive/comb/` (incl. failed work, "실패한거라도"). D2
  substance preserved: comb's live SSOT remains `~/core/hexa-lang/comb`
  (rfc043-hexa-torch); no ownership/absorb, no edits there.

**sequencing (confirmed #3 — irreversible/outward steps GATED)**:
absorb → verify (hexa-matter selftest GREEN under demiurge tree) →
push demiurge → dependents check → GitHub `hexa-matter →
archive_hexa-matter` rename → THEN delete `~/core/hexa-matter`.
hexa-matter origin already protected (15 unpushed commits pushed
2026-05-18). Rename + local delete are NOT done now; gated on rfc_005
program completion + verification.

**rationale**:
- Scope (D10) and sibling-ownership (D2/D11-for-hexa-matter) are the
  user's calls — reversed deliberately and recorded, not silently, so the
  audit trail never self-contradicts (g3-adjacent integrity).
- g3 is not negotiable — it is the anti-fabrication floor; "absorbed"
  without measured parity is exactly what it forbids. Declining its
  removal while complying with the legitimate scope/ownership reversals
  is the correct split.
- Irreversible/outward actions (public-repo rename, local delete of a
  9755-file sibling) require the verify+push+dependents preconditions —
  confirmed by the user (#3); enforced by rfc_005's gated sequence.
- comb-as-archive-snapshot satisfies "보관" without violating D2 (no SSOT
  move) — the honest minimal interpretation.

### Decision 13 — hexa-matter placement = `domains/matter/`

**picked**: absorbed hexa-matter lands at `demiurge/domains/matter/`
— the materials-synthesis stage of the meta-conductor chain (rfc_004
§4 / D11: `domains/matter/` HANDOFF → chip SPECIFY seam). User did not
veto the recommendation. (Rejected: `stdlib/matter/` — it is a chain
*domain*, not a language stdlib module; verbatim-untyped-tree — needs
the `domains/` placement to participate in the chain.)

**rationale**: consistent with the 14 existing Cohort domain maps +
rfc_004 §4 chain seam; minimal new structure; reversible (a move).

### Decision 14 — hexa-matter absorption = hybrid (git-tracked verbatim + shim, progressive re-derive)

**picked**: (hybrid) — the **git-tracked toolkit tree** is preserved
verbatim NOW under `domains/matter/` + a hexa-native dispatcher shim
(rfc_048_xeno pattern; python invoked as a documented
absorbed-substrate subprocess, fail-loud — a bounded g5 exception
with rfc_048 precedent). Per-verb hexa-native re-derivation is the
progressive follow-on (rfc_006+). (Rejected: (5a) full re-derive now
— ~10× rfc_003 scale, months, rate-limit-prone; (5b) pure
verbatim+shim with no re-derive roadmap — leaves g5 debt unscheduled.
Hybrid = (5b) executed now + (5a) scheduled.)

**Faithful-set correction (g3 — surfaced, not papered)**: the naive
"verbatim everything" copy was 195 MB / 9728 files, but **185 MB of
that was hexa-matter's local agent scratch**
(`.claude/worktrees/` × 27 throwaway clones) + `state/` 2.2 MB —
hexa-matter's own gitignored local state, the analog of `.git`, NOT
the toolkit. Re-done as the **git-tracked tree only = 469 files /
8.0 MB** (169 md · 98 py · 61 json · 57 tape · 42 hexa · …). This is
the honest reading of "verbatim" (the project as its repo defines
it). Recorded because "look before you absorb; if what you find
contradicts the description, surface it".

**g3 status**: a verbatim copy is **NOT** an "absorbed" claim.
`absorbed` flips only at the rfc_005 §4 gate (hexa-matter selftest
32/32 + 29 parity gates GREEN *under the demiurge tree*, filed in
PLAN with cited numbers). Current state = **program-in-progress, not
absorbed**. Tombstone (GitHub rename + `~/core/hexa-matter` delete) =
rfc_005 §6 ⑤⑥, GATED on ③ selftest-GREEN + ④ dependents + explicit
per-step go (confirmed #3). hexa-matter origin already protected
(15 commits pushed).

**rationale**:
- Delivers the user's "완전 흡수 후 tombstone" path on the rfc_048
  precedent (fast, loss-free) while scheduling the g5 debt instead of
  hiding it.
- Faithful-set correction keeps the absorption honest + the repo
  sane (8 MB toolkit, not 195 MB of transient worktree duplicates) —
  g3 / no-fake-progress.
- Tombstone stays gated — irreversible/outward steps need measured
  verification first (g3 + confirmed #3); nothing destructive done.

### Decision 15 — `demiurge/stdlib/booksim/` → migrate to `hexa-lang/stdlib/booksim/`

**picked**: A — the rfc_003 re-derivation modules (anynet, iq_router,
traffic, sweep, wire_delay, leighton + dispatcher/README + .stubs)
migrate to **`hexa-lang/stdlib/booksim/`**; demiurge carries NO
`stdlib/` tree (AGENTS.tape `g_stdlib_ownership` / `@F f1`); rfc_003
is updated to *reference* the hexa-lang location (demiurge =
consumer). Cross-repo write done in hexa-lang context, committed in
hexa-lang, **not pushed** (user reviews/pushes in a hexa-lang
session — comb-patch precedent). Modules re-verified under the
hexa-lang tree post-move (g3 — migration not claimed OK without
re-running the self-tests). (Rejected: B keep-in-demiurge
non-stdlib path — contradicts "reusable hexa-native ⊂ hexa-lang
stdlib"; C remove-now-defer — orphans 6 verified modules from the
working tree.)

**rationale**:
- rfc_047/048 precedent exactly — absorbed reusable hexa-native
  modules live in hexa-lang/stdlib/ (qrng/mc-integrate/xeno);
  booksim (NoC-sim re-derivation) is that same class.
- Honors `g_stdlib_ownership` literally — demiurge owns zero
  stdlib/; the verified modules keep a real home (not history-only).
- demiurge becomes the clean consumer ("가져다쓸분") — rfc_003
  references hexa-lang/stdlib/booksim/; resolves the AGENTS.tape
  known_violation.
- Safe/incremental — hexa-lang commit unpushed (user review);
  demiurge `git rm stdlib/` is reversible via history; g3 honored
  by re-verifying self-tests in the new tree.

### Decision 16 — product surface = macOS Swift GUI (rfc_004 §6)

**picked**: the demiurge product surface (rfc_004 §6) is a **native
macOS Swift app** — user accepts macOS lock-in ("macos 락인은 무방").
Local design cockpit: a pure consumer of the typed exports
(`exports/**.{json,hxc}` via `Codable`), zero server/auth/DB; the
hexa-native core is untouched (Swift sits outside the governance
boundary, g5 unpressured). Design decision only — building it is
downstream (rfc_004 §6). (Rejected: WEB static-first — my original
recommendation; B/defer.) Key reframe that makes this *more*
coherent than WEB here: the **public-audit value I had attributed
only to WEB is already delivered by the public GitHub repo**
(`dancinlab/demiurge` — records, design.md, GATE state are publicly
committed/auditable). So GitHub = the public honest-audit surface,
the Swift app = the local cockpit — complementary, not competing;
WEB's sole advantage is already covered.

**rationale**:
- ops elimination — ~80% of this session's pain was infrastructure
  (host thrash, unreachable pool, rate-limits, the no-sync gap that
  broke OpenROAD/T3). A native local app has zero hosting/auth/DB/
  deploy surface. hexa-first / minimal.
- minimal coupling + no sync gap — reads the typed records straight
  off local disk (rfc_002 schema → Swift structs 1:1); SSOT/exports/
  domains/ already live on this macOS box; Read/Write are LOCAL in
  the pool model, so a local GUI is the native fit.
- public audit already solved by GitHub — the one real WEB-only
  benefit (shareable, auditable honesty/GATE state) is already a
  property of the public repo; the GUI need not carry it. Honest
  reframe, not over-sell (g3): the residual loss is non-macOS user
  reach, which the user explicitly accepted.
- core integrity preserved — Swift front is a decoupled consumer
  (D2 pattern); no embedded web stack pressuring the hexa-native
  boundary (g5).

### Decision 17 — hexa-matter: hexa-lang = SSOT, demiurge = consumer-pointer (supersedes D12/D13/D14 + rfc_005 tombstone)

**picked**: A — the materials toolkit's absorption SSOT is
**hexa-lang** (already complete: hexa-lang's own `stdlib/PLAN.md`
"hexa-matter stdlib-only 6모듈 | 완료 | 완전 이관, .py 제거, selftest
38/38" + `inbox/notes/2026-05-14-hexa-matter-absorption-plan.md`).
demiurge does **not** own a copy. **Supersedes D12** (demiurge-as-
absorption-home), **D13** (`domains/matter/` placement), **D14**
(verbatim+shim), and the **rfc_005 tombstone** (⑤⑥ rename/delete
CANCELLED from demiurge's side — `dancinlab/hexa-matter`'s
disposition belongs to hexa-lang, not decided here). The redundant
verbatim copy (471 files / 8 MB) was `git rm`'d; `domains/matter/`
is now a pointer README. (Rejected: B dual-existence — needless
duplicate; C proceed-D12-tombstone — violates D15, duplicates
hexa-lang's completed absorption, irreversibly destroys a repo
hexa-lang's SSOT references.)

**g3 reconciliation (honest, audit-preserved)**: D12/D14 + rfc_005 §4
happened — the measured selftest **38/38 · parity 29/29** is *real*,
but the ④ inventory revealed it re-verifies **hexa-lang's**
absorption, not a distinct demiurge one. The audit entries
(D12/D13/D14, rfc_005) are NOT deleted (they record what was done +
the conflict discovery); D17 supersedes them going forward and the
docs are reconciled. Nothing over-claimed: demiurge never owned the
absorption; the parity belongs to hexa-lang.

**rationale**:
- Honors the user's own latest governance D15 (`stdlib ⊂ hexa-lang;
  demiurge = consumer`) — a materials toolkit is exactly that class;
  hexa-lang already did it.
- Matches discovered ground truth (hexa-lang `stdlib/PLAN.md` =
  완전 이관 완료) — proceeding otherwise = duplicate + contradiction.
- D2/D11 consistent — demiurge is the meta-conductor that *consumes*
  the materials stage via a typed seam (rfc_004 §4), not an owner of
  the toolkit. hexa-matter rejoins hexa-bio/comb as typed-consumed.
- Avoids an irreversible mistake — ⑤⑥ would have renamed/deleted a
  repo hexa-lang's SSOT still references as the absorption source;
  cancelled (g3 + look-before-you-absorb).

### Decision 18 — Yosys absorption: ABC tech-mapping via bounded-subprocess (rfc_006 §7, 7a)

**picked**: in the rfc_006 Yosys absorption (Phase 2, SYNTHESIZE
verb), the **Yosys flow is re-derived hexa-native** (rtlil /
read_verilog / passes / liberty / write_verilog) but **ABC** (the
Berkeley logic-synthesis engine Yosys shells to for technology
mapping, `abc -liberty`) is invoked as a **documented
absorbed-substrate subprocess, fail-loud** — the rfc_048/D14 hybrid
g5 exception, not a clean-room ABC re-derivation. This reproduces
comb's measured `router_d{4,6}` 1.516× SKY130 area oracle now and
schedules per-pass ABC re-derivation as the follow-on. (Rejected:
7b full ABC re-derivation now — ≫10× rfc_003 scale, months,
rate-limit-prone, would stall all of Phase 2 behind one engine.)
g3: this is a *bounded* g5 exception (AGENTS.tape `g_hexa_native`
already permits the rfc_048-precedented form); "Yosys absorbed" is
still gated by rfc_006 §5 (reproduce the cited oracle within
tolerance), not asserted here.

**rationale**:
- precedent parity — AGENTS.tape `g_hexa_native` + D14 already
  sanction exactly this shape (verbatim foreign substrate as a
  documented fail-loud subprocess, re-derivation = scheduled
  follow-on); choosing 7a keeps Phase 2 consistent with the
  established rfc_048 idiom rather than inventing a new posture.
- unblocks the measured gate now — 7a can hit rfc_006 §5 (reproduce
  the real comb d4/d6 area oracle) in bounded scoped work; g3 is
  satisfied by *measuring against the oracle*, not by how ABC's
  internals are implemented.
- risk containment — ABC re-derivation is the single largest effort
  driver in the whole comb-stack (≫ BookSim2); gating all of Phase
  2 (rfc_007..012) behind it = the exact "session stalls on one
  engine" failure mode 7b warns of. 7a isolates it as an
  independent scheduled follow-on.
- honest scope — the residual is explicit and recorded (ABC stays
  foreign substrate until its own re-derivation lands); no
  over-claim, the boundary is named in rfc_006 §7 and here.

### Decision 19 — rfc_006 §4 module implementation belongs to a hexa-lang session (demiurge stops at the design boundary)

**picked**: this demiurge session delivers the rfc_006 **design**
(spec §1–§9 + D18) and stops at the repo boundary. The actual §4
clean-room module implementation + self-tests + §5 oracle
verification happen in a **hexa-lang session**, because per D15 the
7 modules (`rtlil / read_verilog / passes / liberty / abc_map /
write_verilog / yosys`) physically land in `hexa-lang/stdlib/yosys/`
— hexa-lang's tree, hexa-lang's review. demiurge consumes the
result via a typed reference (D2 pattern). rfc_006 §4/§5 *is* the
implementation spec the hexa-lang session works against. (Rejected:
implement now into the hexa-lang working tree from this session —
would grow hexa-lang's unpushed pile to 3 stacked commits
[`d5a63a82` booksim, `61866308` comb patches, + yosys] under an
already-pending "user reviews in hexa-lang session" agreement,
blurring the session/review boundary.)

**rationale**:
- D15 single-source — stdlib is hexa-lang's exclusively; writing the
  modules from a demiurge session still puts them in hexa-lang's
  tree, so the owning session *should* be hexa-lang's (review +
  push authority co-located with ownership).
- no unpushed-pile entanglement — `d5a63a82` + `61866308` already
  await the user's hexa-lang-session review; stacking yosys on top
  from here couples three independent reviews and risks the same
  cross-repo no-sync class of failure seen this session.
- clean boundary, no work lost — rfc_006 §4/§5 is a complete,
  cited, g3-gated spec; the hexa-lang session implements against it
  with zero re-derivation of intent. demiurge's deliverable
  (design + decisions D18/D19) is whole and committed.
- g3 — nothing is claimed "absorbed"; this only relocates *where*
  the gated implementation happens, not whether the gate exists.

### Decision 20 — Phase 3 entry = materials→chip seam (rfc_007); chip→component + component-domain-shape deferred to a gated follow-on

**picked**: Phase 3 (chain seam contracts) enters at the **chain
head — the materials→chip seam**, specified by **rfc_007**
(`demiurge:seam:materials->chip:matprop-record`, v0 draft +
`exports/seams/materials_to_chip/` contract spec, records empty by
design). This is **executing the already-accepted plan**, not a new
user branch: rfc_004 §7 (D11-accepted) already fixes Phase 3 as
"material-property contract from hexa-matter, mirroring rfc_002",
and rfc_004 §9 lists exactly this as the open schema. The **second
seam (chip→component)** and rfc_004 §9's *"demiurge[component] = new
top-level domain vs chip sub-domain"* + chain-stage-granularity
questions are a **real branch point** — **explicitly deferred to
their own decision gate** when Phase 3's second seam is active
(rfc_007 §8), NOT pre-decided here. (Rejected: doing chip→component
first — it is blocked on the undecided component-domain shape;
materials→chip is the unambiguous, dependency-free chain head.)

**rationale**:
- accepted-plan execution, not a manufactured gate — rfc_004 §7/§9
  (under the D11 meta-conductor decision the user already accepted)
  names this seam as the Phase-3 entry; gating it again would be
  ceremony. The genuine branch (component-domain shape) IS preserved
  as a future gate (rfc_007 §8) — gate discipline honored, not
  diluted.
- D2/D17-clean — the seam is a pure *consumption contract*:
  hexa-matter stays typed-interface-consumed (D2), its absorption
  SSOT stays hexa-lang (D17); demiurge declares only what chip
  SPECIFY reads. No re-litigation of D2/D17.
- g3 honest scope — `exports/seams/.../records/` is **empty by
  design** with a README; demiurge ships the contract, never
  fabricates material records (that is the over-claim `@F f2`
  forbids). v0 (not v1.0) because the upstream hexa-lang HANDOFF
  shape is unpinned — stated, not hidden.
- minimum new structure (andrej-karpathy) — rfc_007 mirrors rfc_002
  exactly (twin seam, opposite chain end); no new mechanism
  invented, the cited 7-verb HANDOFF→SPECIFY edge already supports
  it. RFC-number reconciliation noted honestly in rfc_004 §5.

### Decision 21 — demiurge[component] = a NEW top-level domain (not a chip sub-domain); resolves rfc_004 §9 / rfc_007 §8

**picked**: the chain's 3rd pass — **component / package / system
design (FEM / EM / thermal)** — is a **new top-level domain**
(`domains/component.md`, sibling to chip), its own 7-verb pass, fed
by the **chip→component typed seam** (rfc_008). It is **not** folded
into the chip domain. This resolves the rfc_004 §9 / rfc_007 §8
deferred branch (the gate that had to open before the chip→component
seam contract could fix its producer/consumer boundary). Sub-point —
**chain-stage granularity** (does "부품설계" split into package vs
system sub-passes?) is declared a **domain-internal** matter, **not
a seam blocker and not gated now**: the seam treats component as one
consumer; any internal sub-staging is decided inside the component
domain later (deferred as non-gate, honest scope). (Rejected: B
chip sub-domain — conflates two disciplines/tool-classes under one
domain and breaks the D11 "1 pass = 1 domain" chain model.)

**rationale**:
- D11 meta-conductor consistency — the chain is materials→chip→
  component = 3 serial 7-verb passes; under D11 each pass = one
  domain. Merging component into chip would make one domain carry
  two passes, breaking the conductor model the user accepted.
- discipline / tool-class separation — component design is
  mechanical/EM/thermal FEM (Elmer, openEMS, FEMM, CalculiX,
  FreeCAD…), a different absorbed tool-class than chip EDA
  (Yosys/OpenROAD); domains/* already maps these as distinct
  classes. One domain = one coherent tool-class is cleaner.
- domain-pluggable architecture — GOAL.md frames chip as *domain 1*
  of a cohort; component as another top-level domain is the same
  pattern as the 14 Cohort maps, not a special case.
- coupling already expressed by the seam — chip-package co-design
  tightness (the only argument for B) is already modelled by the
  rfc_008 typed seam (same as materials↔chip via rfc_007); no need
  to merge domains to express it. g3: nothing absorbed/wired by
  this decision — it only fixes *where the domain lives*.

### Decision 22 — Phase 4 entry = rfc_009 product-surface spec (macOS Swift cockpit); build explicitly out-of-scope

**picked**: Phase 4 (product surface) enters with **rfc_009** — the
detailed design spec for the **macOS Swift cockpit**: a read-only
typed-consumer of `exports/{chip/noc/f1f2, seams/materials_to_chip,
seams/chip_to_component}`, with honesty-as-feature UI (every output
renders `absorbed` / `measurement_gate` / citations, never upgraded)
and a g5-unpressured boundary (app outside the governance line). This
is **accepted-plan execution**, not a new user branch: D16 already
fixed surface = native macOS Swift (lock-in accepted) and rfc_004 §6
framed it; rfc_009 only *details* what §6 pointed to (like rfc_002/
007/008 detail their seams). The one explicit scope line drawn here:
**the build is OUT of scope** — no Xcode project / Swift source /
app — reusing the D19 idiom (implementation belongs to a dedicated
downstream session that works against rfc_009 §2–§6); building =
gated execution (D10, rfc_004 §6). (Rejected: scoping the build into
this RFC — violates D10 and the D19 design/impl-session boundary,
and would invite an over-claim of a "working cockpit" g3 forbids.)

**rationale**:
- accepted-plan execution, not a manufactured gate — D16 + rfc_004
  §6/§7 already decided the surface (Swift, local, consumer,
  design-only); re-gating it would be ceremony. The genuine scope
  line (build in vs out) IS recorded, not skipped.
- D2/g5 integrity — the cockpit's *only* coupling is the committed
  typed exports; it embeds no web stack and cannot mutate gate
  state, so the hexa-native-only boundary (g5) stays unpressured —
  consistent with the D16 reframe (GitHub = public audit, app =
  local cockpit).
- honesty = the product thesis (g3 as a feature) — rfc_009 §4 makes
  `absorbed`/`measurement_gate`/citations the *visible*
  differentiator vs Cadence/Synopsys/COMSOL black boxes; this is
  GOAL.md's "honesty is the product feature" rendered, not new
  scope.
- minimum new structure — rfc_009 invents no new mechanism: Codable
  structs 1:1 with the existing rfc_002/007/008 schemas, the 7-verb
  spine as the workflow, the rfc_004 §4 chain as the canvas;
  forward-compat via the rfc_002 §6 unknown-key idiom. Build
  deferred honestly (D19 precedent), nothing claimed built (g3).

---

## Naming history (2026-05-19 banner)

This repo was created on 2026-05-18 under the name **`hexa-arch`** and
renamed to **`Demiurge` / 데미우르지** on 2026-05-19 per Decisions 23–25
below. The text replacement was applied across all mutable docs (README /
GOAL / CHARTER / HANDOFF / PLAN / NEXT_SESSIONS / `design.md` D1–D22 / RFC
bodies / `domains/` / `AGENTS.tape` / `ARCH.tape`) — `hexa-arch` →
`demiurge` (lowercase as codebase id) and `HEXA-ARCH` → `DEMIURGE`.
**Excluded** (g3 history-honesty floor): `exports/` (committed provenance
records), `archive/` (historical absorbed-predecessor mirrors), `inbox/`
(cross-repo synced handoffs), `.git/` (history). In those excluded paths
the literal string `hexa-arch` is preserved verbatim as the historical
identity at that moment — a reader can recover the rename event from
this banner + D23/D24/D25, and verify the original artifacts where they
were filed. Internal codebase identifiers (`demiurge[component]`, tape
`@I` values, paths) settle to lowercase `demiurge` per the
phanes-sibling convention. The brand mark in prose may render
**`Demiurge`** (proper noun) — a typographic polish applied to H1 lines
and prominent brand mentions, deliberately NOT as a sed pass.

### Decision 23 — brand mark = `Demiurge` (한글: 데미우르지); paired with `Phanes`

**picked**: project's public-facing brand mark = **`Demiurge`** (한글:
**데미우르지**, 4-syl); codebase identifier (filesystem path, repo
name, tape `@I` values, code identifiers) settles to lowercase
**`demiurge`**. Lore: Platonic *Timaeus* craftsman who shapes
pre-existing matter according to eternal Forms (eidos) — the
meta-conductor (D11) that consumes typed forms (hexa-matter,
hexa-bio) and shapes them through the 7-verb pipeline (명세→구조→
설계→해석⟲→합성→검증→인계) into designed reality across chip · cern
· antimatter · rtsc · space · brain · energy · component · …. Paired
with sibling SaaS brand **`Phanes`** / 파네스 (`dancinlab/phanes`) —
Phanes reveals Forms, Demiurge shapes matter to them; two dancinlab
brands, one continuous cosmology. Provenance: full inbox proposal at
`inbox/notes/brand-name-demiurge-pair-with-phanes.md` (5 web-search
rounds, collision-clean per g3 evidence-not-assumption — 4
verified-clean survivors, 8+ adjacent candidates burned).
(Rejected alts: `Architekton`, `Konstrukt`, `Poiesis` — clean but no
mythic pairing with Phanes; burned candidates `Daedalus` / `Talos` /
`Hephaestus` / `Vulcan` / `Eidos` / `Bauplan` / `Tekton` / `Techne`
all collision-flagged.) (Rejected Korean form 데미우르고스 (5-syl):
syllable count breaks rhythm-symmetry with 파네스 (3-syl); modern
관용 표기 가독성 우세.)

**rationale**:
- mythic pairing is classically grounded, not retrofitted — Phanes
  (Orphic primordial revealer of Forms) and Demiurge (Platonic
  shaper-to-Forms) are sibling cosmological figures in the same
  lineage; the dancinlab cosmos becomes legible at one glance
  rather than two unrelated tokens.
- 1:1 semantic fit to the stated role — GOAL.md and D11 already
  named the project "meta-conductor that consumes typed forms";
  Demiurge *is* that figure verbatim from Plato's *Timaeus*. The
  brand reads like the manual.
- collision-evidenced per g3 — 5 web-search rounds on 2026-05-19
  surfaced no AI/SW collision in adjacent space, while burning 8+
  adjacent candidates (Daedalus / Hephaestus / Eidos / Bauplan /
  Tekton / Techne / Talos / Vulcan); evidence-not-assumption was
  the standard, not vibes.
- 한글 가독 — 데미우르지 (4음절) 는 파네스 (3음절) 와 1음절 차로
  자매-브랜드 리듬 유지; 5음절 변종은 classical 충실하나 입맛에
  떨어지고 자매 token 과 음절 균형이 깨짐.

### Decision 24 — rename scope = mass text replacement (`hexa-arch` → `demiurge`); records-honesty preserved

**picked**: D23 의 rename 을 **mutable 문서 22개에 대한 mass text
replacement** 으로 실행 (`hexa-arch` → `demiurge` · `HEXA-ARCH` →
`DEMIURGE` · `hexa_arch_role` → `demiurge_role`). 적용 대상: README /
GOAL / CHARTER / HANDOFF / PLAN / NEXT_SESSIONS / `design.md` (D1–D22
본문 포함) / `ARCH.tape` / `AGENTS.tape` / `proposals/rfc_001–009` /
`domains/*.md`. **제외 (g3 records-honesty floor)**: `.git/` (git
내부) · `exports/` (committed provenance records — `absorbed`/`gate`
/`cited` fields 와 record ID 는 측정-역사의 일부) · `archive/`
(역사적 흡수-선행본 미러; `archive/comb/*`) · `inbox/` (cross-repo
동기 핸드오프 — 받는 SSOT 의 사본과 바이트-동일성 유지 필요). 한 줄
"Naming history" banner (이 절 상단) 가 rename 사건 자체의 g3-anchor
역할; 결정-블록별 literal-old-name 보존은 거부됨 (사용자가 "차수
철저" picked). (Rejected: 전방-only — D1–D22 literal 텍스트는
보존되나 paragraph 마다 dual-naming 영구 존속; user 가 aggressive
picked.) (Rejected: literal-only brand+path+URL — 본문 자기참조가
mismatched.)

**rationale**:
- user-explicit picked authority — "프로젝트명, repo명 변경 · 차수
  철저" 로 사용자가 직접 picked; D24 는 그 trade-off (history-in-
  prose 가 rewrite 됨) 를 명시된 4-경로 제외 리스트로 honest 하게
  기록 — 비밀스러운 rewrite 가 아니다.
- g3 는 record-level 에서 유지 (prose-level 이 아니라) — `exports/`
  · `archive/` · `inbox/` · `.git/` 4 경로가 측정-역사를 carry; 산문
  자기참조의 uniformity 는 별개 축이며 brand 결정에 종속.
- minimum-new-structure (andrej-karpathy) — 새 file 발명 0, 새
  mechanism 0; 정의된 file set 에 대한 sed + 4-경로 제외 만으로
  완결. 각 제외 경로는 기존 honesty constraint (records / mirrors /
  cross-repo sync / git-internals) 로 정당화됨.
- post-rename grep 표면 깨끗 — 실행 후 작업트리 텍스트에 남은
  `hexa-arch` 는 모두 명시된 제외 경로 안이거나 follow-on commit
  에서 고칠 버그; `grep -rl 'hexa-arch' .` 가 검증 게이트.

### Decision 25 — GitHub repo = `gh repo rename` in-place to `dancinlab/demiurge` (PUBLIC retained)

**picked**: 기존 `dancinlab/hexa-arch` (PUBLIC) 에 대해 **in-place
`gh repo rename demiurge`** 실행 → commit graph · description · 이슈
(0) · PR (0) · star (0) 모두 보존, 옛 URL `github.com/dancinlab/
hexa-arch` 는 GitHub 정책상 `github.com/dancinlab/demiurge` 로 영구
HTTP 301 redirect (동일 이름의 새 repo 가 `dancinlab/hexa-arch` 에
다시 만들어지지 않는 한 — D24 의 제외-경로 외 어디서도 hexa-arch
이름이 나오지 않으니 안전). 로컬에서는 `git remote set-url origin
git@github.com:dancinlab/demiurge.git` 한 줄 갱신. visibility = PUBLIC
유지. 로컬 디렉토리 `~/core/hexa-arch` → `~/core/demiurge` 는 sed +
commit + push 모두 끝난 **마지막** 에 적용 (작업트리 path-bearing
명령들이 편집 단계 동안 안정되게 유지). (Rejected: new repo +
archive — 같은 아티팩트를 둘로 split, redirect 체인 깨짐.)
(Rejected: new repo + delete — git-history rewrite 는 아니나 snapshot
없이 irreversible; 1-day-old repo 에 불필요한 리스크.)

**rationale**:
- GitHub redirect semantics 가 이미 일을 해줌 — in-place rename 은
  commit graph 전체 보존, redirect 가 영구 (HTTP 301) 로 web 과
  `git`/`gh` clone URL 양쪽 모두 작동; 외부 참조자 (phanes/README
  의 cross-link, 오늘 아침 `NEXT_SESSIONS.md` publication, HANDOFF
  reconcile commit log `e13a7d3`/`49b5a67`/`e999e13`/`c425ed7`/
  `13a57d3`) 가 사용자 개입 없이 계속 resolve.
- 자매 브랜드와 대칭 — `dancinlab/phanes` repo 이름 = `phanes`
  브랜드 verbatim; `dancinlab/demiurge` 가 같은 패턴 (Phanes ⇄
  Demiurge, 둘 다 lowercase repo, 둘 다 brand-named).
- 역사 손실 0 — D1–D22 commit history, 오늘 아침 HANDOFF reconcile
  commits, inbox sync invariant 모두 git layer 에서 untouched. 오직
  prose 가 rewrite 됨 (D24 기록).
- ordering hygiene — 로컬 `mv` 가 textual sed + commit + push 다음
  으로 미뤄져 path-bearing CLI 호출들이 편집 단계 내내 안정.
  `~/core/demiurge/` 가 생긴 후 wilson-checkpoint state dir
  (`~/.claude/projects/-Users-ghost-core-hexa-arch/`) 는 다음
  세션에서 `-Users-ghost-core-demiurge/` 로 auto-reseed 될 것 —
  이 결정은 그 migration 을 flag 만 하고 gate 하지는 않음.

### Decision 26 — Swift implementation = native + canonical patterns first (rfc_009 cockpit governance, `@D g_swift_native`)

**picked**: rfc_009 의 macOS Swift cockpit 구현 (D22 downstream
session) 및 Demiurge product-surface 안에서 작성되는 **그 어떤
future Swift code 도 SwiftUI / Foundation / AppKit native idiom +
Apple-canonical pattern 을 first** 으로 사용한다. 서드파티
라이브러리, 커스텀 DSL, non-canonical 구조는 *default 가 아니며*,
producing PR 에 명시적 정당화를 첨부할 때만 허용된다. AGENTS.tape
`@D g_swift_native` (required d=2026-05-19) 로 등록되어 거버넌스로
enforce 됨. (Rejected: no-rule default — 외부 prior art 흡수 없이
cockpit 부터 third-party lib 의 잡탕화는 D22 의 "honesty=feature"
thesis 와 g5 hexa-native 정신 양쪽 모두 압박; D26 이 그 default 를
명문화.)

**rationale**:
- g5 hexa-native 정신의 Swift-방언 적용 — Demiurge 코어 (구
  hexa-arch) 의 g5 가 "absorb intrinsics, never shell out" 이라면,
  그것의 product surface (Swift cockpit) 도 같은 정신의 Swift-쪽
  등가물 = "Apple-canonical idiom, never reinvent" 가 자연 인보크.
  rfc_009 §5 의 g5-unpressured boundary 와 정합.
- minimum-new-structure (andrej-karpathy) 의 Swift 적용 — 새
  abstraction 만들기 전에 SwiftUI 표준 view-modifier / `Codable` /
  `ObservableObject` / `@StateObject` 처럼 이미 canonical 한 것 부터.
  rfc_009 §3 의 Codable 1:1 매핑은 그 자체로 canonical-first 예시.
- review surface 축소 — 서드파티 도입은 license 검토 / 빌드
  reproducibility / dep upgrade burden 을 동반; canonical 만 쓰면
  Xcode + macOS SDK 가 빌드 reproducibility 의 그라운드.
- user-explicit picked authority — 2026-05-19 user 가 "swift
  작성시 구현시 native, canonical 방식 우선 => AGENTS.tape 등록"
  으로 직접 picked; D26 이 그 picked 를 audit trail 에 남기고
  AGENTS.tape `@D g_swift_native` 가 enforce. exception 은 PR-단
  documented-justification 으로 escape hatch (g5 의 rfc_048
  bounded-exception 패턴 미러).

### Decision 27 — Swift cockpit lives in `cockpit/` subdir of demiurge (monorepo; logical boundary not physical)

**picked**: rfc_009 macOS Swift cockpit 의 구현체가 살 위치는
**demiurge repo 안의 새로운 top-level `cockpit/` subdir** (monorepo).
별도 sibling repo `demiurge-cockpit` 옵션은 거부됨. rfc_009 §5 의
governance boundary 는 **logical typed-interface 경계** (`exports/**`
가 유일 coupling 점, D2) 로 유지되며 — repo 경계가 아니라 import-
direction 경계 임을 명시. Swift 코드는 `cockpit/` 안에서 `../exports/`
만 읽고 hexa-lang/stdlib/* 와 demiurge 의 hexa-native core 어떤 것도
import 하지 않음으로써 g5 (D26 `g_swift_native`) 와 D2 typed-
decoupling 을 보존. `.gitignore` 가 Xcode build artifacts (`.build/`,
`DerivedData/`, `*.xcodeproj/xcuserdata/` 등) 을 records SSOT 에서
격리. AGENTS.tape 에 새 `@D g_cockpit_isolation` 이 logical 경계를
거버넌스로 명문화 (D27 enforcement 부산물). (Rejected: NEW sibling
repo `demiurge-cockpit` — cross-repo PR pairing overhead, schema
drift 즉시-검출 어려움, 별도 origin/AGENTS.tape/design.md/README
스캐폴딩 비용, sibling 대칭은 brand 단위이지 tooling 단위 아님.)

**rationale**:
- user-explicit picked authority — 2026-05-19 user 가 D27 에서 B
  picked (1-clone 의 product-surface 직관 우선). 사용자의 trade-off
  가중치를 audit trail 에 honest 하게 기록 — 권고 A 와 달랐음을 명시.
- governance boundary 는 logical 이지 physical 아님 — rfc_009 §5
  diagram 이 의도하는 본질은 **consumption direction** (Swift →
  `exports/**` only) 와 **no engine import** (Swift !import hexa-
  native core). 두 invariant 는 directory layout 과 무관 — code-
  review + `.gitignore` + `@D g_cockpit_isolation` 으로 enforce
  가능. boundary 가 무너지는 건 *위치* 가 아니라 *의존 방향* 이
  깨질 때.
- schema drift 즉시-검출 (monorepo 장점) — rfc_002/007/008 JSON
  schemas 의 Codable mirror struct 가 같은 repo 에 사니까,
  producer (records 생성기) 와 consumer (Swift Codable) 의 schema
  update 가 같은 PR / 같은 commit 에서 동기. 별도 repo 라면 cross-
  repo PR pair 가 필요해 friction + drift 윈도우 발생.
- minimum-new-structure (andrej-karpathy) — 새 GitHub repo · 새
  origin · 새 AGENTS.tape · 새 design.md · 새 README 5종 스캐폴딩
  비용 대비, monorepo 에 `cockpit/` 1개 디렉토리 추가 + `.gitignore`
  +1 line + `@D g_cockpit_isolation` 1개가 절대적으로 경량.
- brand-cosmology 단순화 — Phanes ⇄ Demiurge 의 sibling 대칭은
  **brand 단위** 이지 **tooling 단위** 가 아님. cockpit 은 별개
  brand 가 아닌 Demiurge 의 *cockpit* (즉 Demiurge 의 일부). 별도
  repo 분리 시 외부 reader 가 "Demiurge-cockpit 이 또 다른 brand
  인가?" 라는 의문 발생; monorepo 가 이를 disambiguate.

### Decision 28 — Cockpit bootstrap = SwiftPM `Package.swift` only (no .xcodeproj)

**picked**: cockpit 의 부트스트랩 형식 = **SwiftPM `Package.swift`
only**. `.xcodeproj` 는 생성하지 않음. 4-파일 스캐폴드 적용:
`cockpit/Package.swift` (tools-version 5.9, `.macOS(.v13)`, single
`executableTarget("CockpitApp", path: "Sources/CockpitApp")`) +
`cockpit/Sources/CockpitApp/CockpitApp.swift` (16 lines, 순수
SwiftUI: `@main struct CockpitApp: App` + `WindowGroup` +
`ContentView` 가 "DRAFT — scaffold v0" 텍스트 표시) +
`cockpit/.gitignore` (5 lines: `.build/` · `.swiftpm/` ·
`DerivedData/` · `*.xcodeproj/xcuserdata/` · `*.xcworkspace/
xcuserdata/`) + `cockpit/README.md` (build/run + 4-invariant
boundary + g_swift_native + cross-refs). 참고 자산
`cockpit/references/quiver-overview.png` 는 D27 commit `476d0e1`
에 이미 인-place. **빌드 검증은 g3 정직: 이 세션에서 미수행** —
wilson-pool 이 `swift build` 를 Linux ubu-2 호스트로 잘못
라우팅 + ubu-2 SSH banner timeout 으로 실행 실패. SwiftUI 는
macOS-only 라 Linux 빌드 자체 불가; 사용자가 로컬 macOS 에서
`cd cockpit && swift build` 로 검증 필요. (Rejected: `.xcodeproj`
only — `.pbxproj` XML 의 merge-hostile, Apple 자체 sample 도
SwiftPM 이동 추세.) (Rejected: 둘 다 — dual SoT 동기 부담,
cockpit 초기 단계엔 과잉조직.)

**rationale**:
- user-explicit picked authority — 2026-05-19 user 가 SwiftPM
  picked; 권고 A 와 일치, 빠른 컨버지.
- Apple-canonical 의 modern 해석 — Xcode 15+ 가 `Package.swift` 를
  native open 으로 처리 (Previews / Instruments / debug / scheme
  모두 작동). Apple 자체 sample (Swift Concurrency, SwiftUI Apple
  Tutorials) 도 점차 SwiftPM 으로 이동. D26 `g_swift_native` 의
  "canonical first" 와 정합.
- git-friendly text manifest — `Package.swift` 가 Swift 코드라서
  PR diff 가 의미 있게 읽힘; `.pbxproj` XML 의 merge conflict
  지옥 회피. monorepo (D27) 의 schema-drift 즉시-검출 장점이
  manifest 변경에도 적용.
- minimum-new-structure (andrej-karpathy) — 4-파일 스캐폴드
  (manifest + 1 `.swift` + `.gitignore` + README) 가 동작하는
  최소 SwiftUI App. signing / notarization 필요해지면 SwiftPM
  위에 schemes 추가만으로 P5 대응 — 지금은 D28 scope 밖.
- g3 정직 — 스캐폴드는 작성됐으나 **빌드 자체는 이 세션에서
  측정-미검증**. pool routing 실패 + ubu-2 unreachable.
  16-line 순수 SwiftUI 라 문법적 신뢰는 있으나 "compiles green"
  주장은 안 함; 측정 부재를 명시 (사용자 macOS 로컬 검증 또는
  follow-on 세션). 빌드 미검증 상태에서 "scaffold works" 주장은
  `@F f2` 위반이라 회피.

### Decision 29 — First feature slice = F1F2 record viewer + ProvenanceBanner (rfc_009 §4 honesty-as-feature minimum)

**picked**: cockpit 의 첫 feature slice = **F1F2 record viewer +
ProvenanceBanner**. 5-file 구현 landed:
(1) `cockpit/Sources/CockpitApp/Models/F1F2Record.swift` — Codable
mirror of rfc_002 v1.0 schema (top-level + nested `Topology` /
`Verdict` / `Provenance` + `MeasurementGate` enum
`{open|bPinnedMet|closedMeasured|failed}` ↔ `GATE_*` rawValues).
`JSONDecoder.keyDecodingStrategy = .convertFromSnakeCase` 로 JSON
snake_case 자동 매핑; rfc_002 §6 unknown-key idiom 은 Swift
Codable default 가 그대로 만족 (extra keys ignored).
(2) `Loaders/RecordLoader.swift` — Foundation `URL` + `Data` +
`JSONDecoder`, `Result<F1F2Record, RecordLoaderError>` API,
`fileNotFound` / `readFailed` / `decodeFailed` 세 에러 케이스.
`@D g_cockpit_isolation (a)` 정합: read-only from `../exports/**`.
(3) `Views/ProvenanceBanner.swift` — **rfc_009 §4 honesty-as-feature
의 유일한 visual contract**. `measurementGate` 에서 직접 파생되는
tint color (`.orange` GATE_OPEN · `.blue` GATE_B_PINNED_MET ·
`.green` GATE_CLOSED_MEASURED · `.red` GATE_FAILED) — 앱이 *선택*
하지 않음, 측정-사실을 *반영* 만; `absorbed` flag verbatim
(green if true, secondary if false); gate failures + scope
caveats list verbatim. SwiftUI canonical: `GroupBox` +
`LabeledContent` + system fonts + `Color.*` semantic tokens.
(4) `Views/RecordView.swift` — record header (recordId / interface /
schemaVersion / producedAtUtc) + topology summary + verdict +
ProvenanceBanner 조합. 에러 경로 = **REJECTED card** (rfc_009 §4
"missing provenance → REJECTED card", `@F f4` 미러 — 정직성이
happy path 뿐 아니라 fail path 에서도 visible).
(5) `CockpitApp.swift` ContentView 업데이트 — 하드코드 first-slice
record path `../exports/chip/noc/f1f2/records/2026-05-18_d8_king_
tornado_7nm_1ghz.json` (file picker = next slice). `@State` +
`.onAppear` 로 Loader 호출 → `Result` 분기 → `RecordView`.

`@D g_cockpit_isolation` 4 invariant 모두 정합: (a) reads only
`../exports/**` ✓ — Loader 가 relative path only · (b) only
`import Foundation` + `import SwiftUI` ✓ — no demiurge/hexa-lang
imports · (c) build artifacts `.gitignore`'d ✓ — D28 에서 처리
· (d) one-way read ✓ — Loader 는 read 만, write 0. `@D
g_swift_native` canonical-first 정합: 서드파티 dep 0, SwiftUI
native (`@main App`, `WindowGroup`, `GroupBox`, `LabeledContent`,
`ScrollView`, `LazyVStack` 부재 — 첫 slice 는 단일 record 라
plain `VStack`) + Foundation (`JSONDecoder`, `FileManager`,
`URL`, `Data`) only. (Rejected: B Domain picker — honesty-as-
feature 미증명, cockpit 의 유일 차별점 다음으로 미룸.)
(Rejected: C 7-verb spine 정적 페이지 — 데이터 binding 없음,
cockpit-as-typed-consumer 철학 미증명.)

**rationale**:
- user-explicit picked authority — 2026-05-19 user 가 A picked,
  권고와 일치.
- rfc_009 §4 honesty-as-feature 는 cockpit 의 *유일한 차별점* —
  가장 작은 단위에서 즉시 증명하는 것이 minimum-viable. 만약
  ProvenanceBanner 가 첫 slice 에서 빠진다면 cockpit 은 generic
  JSON viewer 와 구분 불가. 차별점 first.
- monorepo (D27) schema-drift 즉시-검출 장점이 곧장 작동 —
  rfc_002 v1.0 schema 변경 시 `F1F2Record.swift` 의 Codable struct
  변경이 같은 PR / 같은 commit 에서 일어남. cross-repo 였으면
  friction 발생 + drift window. monorepo trade-off 가 첫 slice
  부터 가치 만들어냄.
- minimum-new-structure (andrej-karpathy) — 5 파일 모두 SRP 명확
  (Model / Loader / Banner / RecordView / App entry); 추가 추상화
  층 없음. file picker / 다중 record 지원 / 다른 record 타입
  (rfc_007/008 seam records) 는 후속 slice 에서 같은 패턴 반복.
- rejected card (rfc_009 §4) 도 같은 slice 에 포함 — 정직성이
  happy path 뿐 아니라 fail path 에서도 visible. `@F f4`
  (silent-skip) 의 product-surface 미러; missing provenance =
  앱이 분석가 대신 claim 못 함.
- g3 정직 (D28 동일): 5-file slice 의 build verification 이 세션
  미수행 (pool routing 이슈 잔존). 코드 syntactic 신뢰도 높으나
  "compiles + renders green" 주장 안 함. 사용자 macOS 로컬
  `cd cockpit && swift run` 으로 검증; UI 가 d8_king 1GHz record
  의 ProvenanceBanner 를 orange (GATE_OPEN) + absorbed=false +
  5개 scope_caveats verbatim 으로 렌더하면 D29 성공.
  **(supersede-forward 2026-05-19)**: `swift run` 로컬-머무름 +
  17.21s build PASS + data-flow verbatim verify 완료 — PLAN 로그
  `D28/D29 BUILD VERIFIED` 참조. 이제 measured-green.

### Decision 30 — File picker = NSOpenPanel pinned to `RecordLoader.f1f2RecordsRoot` + Loader runtime invariant (a)

**picked**: cockpit 에 "Open Record…" 툴바 액션 추가 — **AppKit
NSOpenPanel** 사용, `directoryURL = RecordLoader.f1f2RecordsRoot`
(`../exports/chip/noc/f1f2/records`), `allowedContentTypes = [.json]`,
`canChooseDirectories = false`. 동시에 `RecordLoader.load(url:)`
에 **runtime 경계 검증** 추가 — `url.standardizedFileURL.path` 이
`RecordLoader.exportsRoot.path` (`../exports/` 표준화된 절대경로)
의 prefix 가 아니면 새 에러 `pathOutsideExports` 반환. UI 측에서는
RecordView 의 REJECTED 카드가 자동 동일 패턴으로 표시 — 사용자가
picker 로 outside-of-exports 파일을 선택하면 시각적 거부됨. 또한
ContentView 의 `currentDisplayPath` 가 좌측 navigation 툴바 슬롯에
표시되어 현재 보고있는 record 의 출처를 항상 visible. (Rejected:
SwiftUI `.fileImporter` only — initial directory 지정 API 부재,
canonical-first 의 directory-pinning 요구 미만족. Rejected: 좌측
트리 navigation 만 + picker 없음 — 그건 phase β 영역, D30 은 그
전의 즉시-가능 UX 잠금해제.)

**rationale**:
- user-explicit 직접 안 picked 했으나 D29 의 hardcoded path 가
  UX 잠금이라 zhen 다음 자연 단계로 권고 후 "next go" 받은 흐름.
  audit trail 에 그 픽 경로 honest 기록.
- `@D g_cockpit_isolation (a)` 의 코드-레벨 강화 — invariant 가
  governance 문서에만 있을 때와 runtime 가 검증할 때는 보장
  수준이 다름. NSOpenPanel 의 `directoryURL` 디폴트 + Loader 의
  `pathOutsideExports` 가 defense-in-depth.
- `@D g_swift_native` canonical 정합 — AppKit `NSOpenPanel` 은
  macOS 의 *the* canonical 파일 선택 API; SwiftUI `.fileImporter`
  는 sandbox 환경에서 더 적합하나 directory-pinning 미지원 →
  AppKit 가 더 알맞음 (g_swift_native rule 의 SwiftUI/Foundation/
  **AppKit** native idiom 정합).
- minimum-new-structure — 새 파일 0; `CockpitApp.swift` 의
  ContentView 에 `presentPicker()` 한 함수 + 툴바 2 item 추가, +
  Loader 에 `exportsRoot` / `f1f2RecordsRoot` static 2개 + 새 에러
  case 1개. 총 ~30 lines diff.
- build measured-green — `swift run` (pool 우회 verb) 로 2.63s
  incremental rebuild PASS, 0 warnings, app launch까지 도달.
  이번 결정은 *unmeasured-claim* 단계 없이 처음부터 measured-fact.

### Decision 31 — `proposals/rfc_010_cockpit_architecture.md` = Quiver-mirror cockpit spec (Phase α..ζ 로드맵)

**picked**: Palantir Foundry Quiver "Overview Analysis" 의 캡쳐
(`cockpit/references/quiver-overview.png`, D27 commit) 를 reference
로 한 **Quiver-mirror 3-pane cockpit architecture** 를 새 RFC
`rfc_010_cockpit_architecture.md` 로 정합. rfc_009 가 §3 에서
"7-verb information architecture" 골격만 그렸다면 (그리고 §5 에서
경계 + g5 만 명시), **rfc_010 은 그 §3 의 구체적 카드-시스템
설계 + Phase α..ζ 실행 계획 + open decision 게이트 식별**. 핵심
contribution: (a) 3-pane SplitView 정보 아키텍처 (Quiver-mirror) ·
(b) Artifact protocol + card type 다양성 (Record/Decision/RFC/
Domain/Chart/Table) · (c) `$<id>` artifact 토큰 시스템 · (d)
honesty-mode 차별점 (gate chip 카드-헤더 강제 · inspector 첫 탭이
Provenance · REJECTED 카드 mode) · (e) 6 phase α..ζ 점진 슬라이스
계획 (~730 LoC 추정). **빌드는 phase 별로 진행** — rfc_010 자체는
설계만 (D22/D19 idiom). (Rejected: 단일 거대 D31 결정 — 카드 시스템
+ 정보 아키 + phase plan 을 한 결정에 묶으면 다음 phase 마다 미세
결정이 필요할 때 audit trail 어색. rfc 가 spec 본가 + design.md 가
gate 인 분할이 정합.) (Rejected: rfc_009 안에 §3.x 로 추가 — 이미
PUBLISHED RFC 의 in-place 확장은 시간 흐름 흐림; 새 rfc_010 이
타임라인 명확.)

**rationale**:
- "참고 PNG 분석 + 레이아웃 + 기능구현 어떻게" 가 즉시 디자인
  레벨 작업 (사용자 directive 2026-05-19). 디자인 산출 = RFC 가
  관례 (rfc_001..009 pattern); coding 들어가기 전 명세화가 g3
  과 minimum-new-structure 양쪽 정합.
- Quiver-mirror 는 *형태* 만 빌림, *honesty-mode* 는 demiurge
  고유 — gate chip / 강제 provenance / REJECTED 카드 / cross-ref
  dependency 자동 추적 = rfc_009 §4 의 자연 visual 확장. Quiver
  를 그대로 베끼지 않음을 RFC §3 에서 명시 (디자인-자체-차별점,
  G3 의 메타).
- Phase α..ζ 가 점진 commit 가능한 단위 — α (shell 50 LoC) /
  β (tree 150) / γ (card 80) / δ (inspector 100) / ε (variety 200)
  / ζ (filter+deps 150). 각 phase commit 별 build verify 가능, big
  bang 회피 (`@D g_scope.no_bigbang`).
- open decision 게이트 식별이 RFC 본문의 가장 큰 가치 — D32+
  으로 분기 가능 결정들 (예: artifact id 토큰 형식, persistence,
  search syntax, dependency graph rendering 등) 을 spec 안에서
  미리 flag 해두면 phase 진행시 zhuyao 결정-순서 충돌 안 남.
- 빌드 미시작 (rfc_010 자체는 spec) — D22/D19 idiom 재사용, "RFC
  설계 ≠ 빌드된 cockpit" 분리. phase α 부터 가 실행, 별도 commit
  시퀀스.

### Decision 32 — Artifact `$<id>` token format = sequential per type (`$R<n>` / `$D<n>` / `$RFC<n>` / `$DOM:<name>`)

**picked**: cockpit 가 사용하는 artifact 식별 토큰 = **type-prefixed
sequential** — `$R1` `$R2` … (Records), `$D29` `$D30` … (Decisions —
번호는 design.md 의 D-번호 따라감), `$RFC9` `$RFC10` … (RFCs —
proposals/rfc_NNN_*.md 의 NNN), `$DOM:chip` `$DOM:component` …
(Domains — name-keyed). 토큰은 `ArtifactRegistry` 가 load 시 할당,
session 내 stable, 다음 load 에서 record 추가/제거 시 재할당
허용. (Rejected: B path-derived — verbose, dependency-list 공간
차지; C stable hash — opaque, debug 어려움.) rfc_010 §7 의 D32
slot 채움.

**rationale**:
- Quiver-mirror 정합 — `$G` `$AR` `$AK` 토큰 패턴이 그대로 mirror,
  외부 reader (이미 Quiver 경험 있는 사용자) 가 즉시 인지.
- 짧음 + 타이핑 쉬움 — chat 안에서 "show $R1 caveats" 같은 명령이
  자연스럽고 입력 부담 적음. token-economy 측면에서 path 형보다
  cheap.
- type-namespace 분리 — `$R` `$D` `$RFC` `$DOM:` 가 자동으로 artifact
  type 을 시각적으로 disambiguate; cross-ref 가 명확.
- load-order 재할당 가능성 = trade-off — Decisions/RFCs 는 design.md
  의 D-번호 / proposals 의 rfc-번호 그대로 따라가 stable, Records 만
  load-order-bound (수용 가능; record_id 가 별도 stable identifier
  로 항상 있음).

### Decision 33 — LEFT tree grouping = by type (Records / Decisions / RFCs / Domains / Parameters)

**picked**: cockpit LEFT 의 `Artifacts` 탭 (D37 의 sibling tab) 의
트리 그룹핑 = **by artifact type**: Records / Decisions / RFCs /
Domains / Parameters 5 sections. Phase α 의 placeholder 5 sections
가 그대로 production grouping. (Rejected: B by-domain — chip 편향
risk, 14+ 도메인 모두 모이면 chip 외 도메인 records 0 으로 빈
section 다수; C by-7-verb — record 가 어느 verb 에 속하는지 추가
modelling 필요, phase β 범위 초과.) rfc_010 §7 의 D33 slot 채움.

**rationale**:
- 가장 단순 + 가장 직접 — rfc_010 §4 의 LEFT 레이아웃 그대로,
  phase β filesystem walk 가 그대로 각 section 채움. 새 modelling
  비용 0.
- artifact type 이 사용자 mental model 의 1차 분류 — "F1F2 record
  어디 봤지?" → Records 클릭이 즉답. "그때 그 결정?" → Decisions.
- 도메인 / 7-verb 그룹핑은 *향후 secondary filter* 로 추가 가능 —
  D37 의 Parameters 섹션 (필터 바인딩) 이 이를 cover, exclusive
  grouping 으로 lock 할 필요 없음.

### Decision 34 — Control surface mutation scope = split (cockpit GUI 직접 사용 + CLI = AI-agent surface)

**picked**: cockpit 의 mutation scope 는 **둘로 분리** — (1) **cockpit
GUI** = 사용자가 직접 사용 (browsing + viewing + LEFT Chat tab 에서
대화 + RIGHT Inspector 에서 detail 확인). GUI 자체는 read-only on
`../exports/**`, 단 LEFT Chat tab 에서 AI agent 호출 가능 (이는
*directly mutating* 아님; agent 가 작업하고 records 생성). (2) **demiurge
CLI** = AI agent 의 invocation surface — `claude --headless -p …`
같은 헤드리스 호출이 CLI 명령으로 들어와 작업 실행. **인간이 GUI
없이 CLI 만으로 작업 가능 (스크립트화) + AI agent 가 CLI 로 자기를
호출 가능** (recursive / 자동화). `@D g_cockpit_isolation` (d)
edit-direction one-way 유지 (cockpit/CLI 직접 exports/ write X). 새
`@D g_ai_agent_action_surface` 가 AGENTS.tape 에 등록되어 enforce.
(Rejected: A stay read-only — 사용자의 "작업도 가능하게" 요구
미충족; B 양쪽 다 mutating — 거버넌스 부담 + agent 우회 가능성;
D direct mutation — invariant (d) 명시적 폐기 + g3 위반 risk.)

**rationale**:
- user-explicit picked authority — 2026-05-19 user 가 "유저가 cockpit
  직접사용 & ai agent 용 cli" 로 직접 picked.
- invariant (d) 유지 + D7 producer-owned exports 유지 — AI agent 가
  producer, cockpit/CLI 는 trigger. 기존 governance 무변경, 새 @D
  추가만으로 cover.
- 분리의 가치 — GUI 는 사람-시간 비싸 보이는 visual 작업에 최적,
  CLI 는 agent-시간 cheap 한 자동화에 최적. 두 표면이 다른 사용
  패턴을 자연 분담.
- 향후 federation 가능성 보존 — 다른 hexa-* repo 들도 자체 CLI 를
  가지면 federated agent 환경 가능 (D45 deferred).

### Decision 35 — 3D viewer framework = RealityKit (mouse-drag rotate only)

**picked**: cockpit 의 3D 모델 viewer 구현 = **RealityKit** (macOS 13+,
Apple-canonical modern). interaction = **마우스 클릭 + 드래그 회전만**
(orbit camera), **자동 애니메이션 / 키프레임 / ambient camera path
0**. 로드 포맷: USDZ (Apple-native, 1순위) · STL (FreeCAD/KiCad export,
2순위) · glTF (RealityKit bridge 가능 시). ComponentMode (rfc_011 §7)
의 BIPV-style exploded-isometric 렌더링이 1차 use case. (Rejected:
SceneKit — `allowsCameraControl = true` 한 줄로 같은 효과 + LoC
적지만 SceneKit 가 Apple 의 maintenance focus 가 약화된 framework,
RealityKit 가 visionOS 까지 미래 보장; SwiftUI 3D + Metal direct —
LoC 폭증, canonical 보너스 없음.)

**rationale**:
- D26 `g_swift_native` canonical-first 의 modern 해석 — Apple 이
  지금 투자하는 framework 가 canonical. SceneKit 가 더 짧지만 future-
  proof 측면에서 RealityKit.
- mouse-drag rotate only 가 user-explicit picked — 자동 애니메이션은
  *attention 분산*, manual orbit 은 *focus 유지*. honesty-as-feature
  의 시각 표현 (gate chip 변하지 않음, scope_caveats 가 안 사라짐)
  과 정합.
- USDZ 우선 — FreeCAD 가 최근 USDZ export 추가, KiCad 가 STEP → USDZ
  변환 가능 (StepUp + FreeCAD chain). exports/ 가 USDZ 직접 들고
  있을 수 있는 미래 보장.
- ~30 LoC orbit-camera setup — D26 minimum-new-structure 정합.

### Decision 36 — hexa-bio cockpit treatment = A (sibling repo, seam record consumer view only)

**picked**: `hexa-bio` 는 demiurge 의 sibling repo 임 (`@D g_decouple`
D2, 매터 처럼 typed-interface-consumed; D17 패턴과 동형). cockpit 은
**hexa-bio 의 내부 데이터** (분자 3D / sequence / binding) 를 **직접
렌더하지 않음** — 오직 `seams/bio_to_chip/` 와 `seams/bio_to_component/`
records 가 emit 됐을 때 `SeamConsumerMode` (rfc_011 §7) 의 카드로만
표시. (Rejected: B "demiurge cockpit owns BioMode" — D2/D11/D17
sibling 패턴 위반; C federated cockpit shell — P5+ 범위, 거버넌스
미정 deferred D45.)

**rationale**:
- D2/D11/D17 일관 — `hexa-matter` 가 D17 후 hexa-lang absorbed,
  demiurge 는 pointer 만. `hexa-bio` 는 absorb 안 됨 (D2 raw 그대로),
  demiurge 는 typed-consumer. cockpit 가 절대 *흡수* 안 함.
- 미래의 `hexa-bio-cockpit` sibling repo 여지 보존 — Phanes ⇄
  Demiurge 의 sibling 패턴이 hexa-bio 측에도 적용 가능, 그 결정은
  hexa-bio 측 자체 SSOT.
- minimum-new-structure — bio-native rendering 코드 0; `SeamConsumerMode`
  하나가 모든 seam 타입 (matter→chip, chip→component, bio→chip, …) 의
  consumer view 통합.

### Decision 37 — Chat panel location = LEFT 1st tab (LEFT TabView 의 첫 탭)

**picked**: cockpit 의 LLM 대화 UI 가 살 곳 = **LEFT sidebar 의 첫
번째 탭 `Chat`**. LEFT sidebar 가 *single-list* 가 아니라 *TabView*
가 되어 [Chat][Artifacts][History][Search] 같은 multi-tab 구조 (Xcode
navigator pattern). Chat 이 항상 1st tab (default). Artifacts (rfc_010
§4 의 트리) 가 2nd tab — 사용자 picks 흐름이 chat-first 임을 우선.
(Rejected: BOTTOM drawer — 좁아짐; 4th column — 4-column 가독성
trade-off; inspector 5번째 탭 — chat 이 selection-bound 이 아니라
session-wide 인데 inspector 안에 두면 selection 변경 시 chat history
혼동; overlay — 항상-on 가 아니라 sporadic, "작업도 가능하게" 의
실시간 chat 요구 미충족.)

**rationale**:
- user-explicit picked authority — "좌측탭에 채팅" + "좌측탭은 채팅이
  첫번째 탭".
- 항상 visible — chat 이 핵심 control surface 이 되려면 (D34) 항상
  접근 가능해야 함. tab 의 active state 가 유지되므로 toggle 없이
  바로 입력 가능.
- LEFT 의 폭이 좁지만 충분 — Slack DM panel, Xcode console panel 등
  220-320px 너비가 chat 에 적절. 긴 응답은 message-bubble 내 scroll
  + canvas 의 새 record card 와 hyperlink 로 detail expand.
- Xcode-pattern 정합 — Apple 사용자는 navigator tab bar (project /
  source-control / issues / tests / debug …) 패턴에 익숙. demiurge
  의 LEFT TabView 가 같은 idiom.

### Decision 38 — AI agent backend = Claude Code CLI + Claude Code API (dual dispatch)

**picked**: cockpit Chat tab 의 backend = **Claude Code CLI + Claude
Code API 동시 사용**. dispatcher 가 사용자 입력 의도를 분류하여
적절한 backend 로 라우팅 — (A) **conversational** (Q&A, 해설, 검색)
→ **Claude Code API** (streaming, low-latency); (B) **action-bearing**
(synth / measure / analyze / verify, file I/O 동반) → **Claude Code
CLI** (`claude --headless -p "<prompt>" --allowedTools …` subprocess,
tool use 가능, long-running). v0 dispatcher = slash-command 휴리스틱
(`/synth` `/measure` `/verify` 등 → CLI; 그 외 → API). 향후 LLM 기반
classifier 가능. (Rejected: API only — action 못 함; CLI only —
대화 latency 큼; OpenAI / Gemini / 기타 LLM — D26 g_swift_native
정신의 사용자 own toolchain 우선 (Claude Code 는 사용자가 이미 채택
한 agent), 또한 demiurge 의 honesty contract 와 Claude Code 의 tool-
use audit 가 정합.)

**rationale**:
- user-explicit picked authority — "claude code cli & claude code api".
- 두 modal 정합 — API 는 사용자가 "이 caveats 의미?" 같은 Q&A 에
  즉답, CLI 는 "synth 돌려" 같은 actual work 에 적합. *같은 agent
  family* 두 호출 modal.
- Claude Code 의 tool use audit = honesty-as-feature 와 정합 — Claude
  Code CLI 가 어떤 tool 호출했는지 (e.g., `Bash("yosys -p '…'")`,
  `Write("exports/.../record.json")`) 모두 log; 그게 chat reply 의
  provenance banner 출처. agent 의 action 이 측정-게이트로 link
  가능.
- 사용자 own toolchain 우선 — wilson 등 다른 agent 도 향후 plug-in
  가능 (D45 federation 와 연결); 1st-class backend 는 Claude Code 로
  fix.

### Decision 39 — RIGHT 1st tab = Inspector / Provenance verbatim

**picked**: cockpit RIGHT pane 의 first tab = **Inspector / Provenance
verbatim**. RIGHT 역시 LEFT 처럼 TabView 가 되어 [Inspector][Action
queue][7-verb][Chain][Atlas] 5 탭, Inspector 가 default. Inspector
내부에 sub-tabs (Provenance / Data / Citations / Raw JSON /
DEPENDENCIES) — Provenance 가 sub-tab 의 1st (rfc_009 §4 thesis).
selection-bound: canvas 에서 카드 클릭 or LEFT Artifacts tree row
클릭 → Inspector 에 그 artifact 의 full detail. (Rejected: Action
queue 1st — useful 하나 product thesis 가 honesty 라 verbatim
provenance 가 먼저; 7-verb tracker 1st — workflow visible 좋으나 매
artifact 마다 보고 싶은 게 아님; Chain mini-map 1st — context 적은
artifact 에는 noise.)

**rationale**:
- user-explicit picked authority — RIGHT 1st 후보 4 중 A picked.
- product thesis 와 정합 — demiurge 의 차별점이 honesty-as-feature
  이고, RIGHT pane 의 1st 가 그걸 verbatim 으로 펼치는 것이
  자연스러운 product 메시지.
- chat (LEFT) 와 honesty (RIGHT) 의 대칭 — 두 가장 중요 tab 이
  side mirror 처럼 양측에 배치. chat 이 trigger surface, inspector
  가 verification surface — 같은 product DNA 의 2 면.
- Quiver 와의 *차별점 강조* — Quiver Inspector default = `Data`,
  demiurge default = `Provenance`. 같은 패턴, 다른 첫 화면. mirror
  + override.

### Decision 40 — Layout shape = 4-zone tabbed (TOP toolbar + LEFT TabView + CENTER canvas + RIGHT TabView)

**picked**: cockpit 의 최종 레이아웃 shape = **4-zone tabbed** —
(1) TOP toolbar (file/help, `+Synthesize` `+Measure` `Open` 등
action buttons, search field), (2) LEFT TabView (D37 Chat 1st +
D33 Artifacts 2nd + History/Search 향후), (3) CENTER canvas (record
cards · 3D viewer per ComponentMode · chain canvas · latency curves
— rfc_011 §7 canvas modes), (4) RIGHT TabView (D39 Inspector 1st +
Action queue / 7-verb / Chain / Atlas 향후). rfc_010 의 3-pane
`NavigationSplitView` 는 base shell 유지, LEFT/RIGHT 가 각각 `TabView`
로 wrap. (Rejected: rfc_010 의 plain 3-pane 그대로 — chat 자리 없음;
single-window without toolbar — `+Synth` 같은 session-wide action
의 home 없음; floating panels — Apple-canonical Mac app idiom
아님.)

**rationale**:
- user-explicit picked authority — "좌측 영역도 탭 전환 가능 / 우측도
  탭전환가능" + "좌측탭은 채팅이 첫번째 탭".
- Xcode-canonical idiom — Xcode 의 navigator (LEFT tab bar) + inspector
  (RIGHT tab bar) + editor (CENTER) + toolbar (TOP) 와 정확히 동형;
  Mac 사용자 mental model 즉시 정합. D26 `g_swift_native` 가 의도하는
  "Apple-canonical first" 의 layout level.
- 3-pane → 4-zone 의 cost 작음 — `NavigationSplitView` 의 sidebar /
  detail slot 안에 `TabView` 넣는 것은 SwiftUI 1-step composition.
  rfc_010 Phase α 의 shell 이 변하지 않음 — slot 만 채워짐.
- 미래 확장 여유 — TabView 라 새 탭 추가가 layout 깨지 않음 (History,
  Search, Action queue, 7-verb tracker 모두 점진 lands). Phase
  α-2 → η → θ → ι 의 점진 addition 가 그대로.

### Decision 41 — Cockpit boundary read scope clarification (records strict + navigation docs read-only)

**picked**: phase β 의 LEFT Artifacts tab 이 design.md / proposals/ /
domains/ 같은 project metadata 를 sidebar 채우기 위해 읽어야 하는데,
기존 `@D g_cockpit_isolation` invariant (a) 의 rule string ("reads
ONLY ../exports/**") 그대로 narrow 해석하면 docs 도 못 읽음. 그래서
invariant (a) 를 **두 sub-clause 로 명료화** — (a-records) records 는
*strict* 하게 `../exports/**` 에서만 읽고, `RecordLoader` 의 runtime
check (`pathOutsideExports` 에러) 로 enforce. (a-docs) **navigation
documents** (`../design.md`, `../proposals/`, `../domains/`, `../inbox/`,
`../archive/`, `../README.md`, `../CHARTER.md`, `../HANDOFF.md`,
`../GOAL.md`, `../PLAN.md`, `../ARCH.tape`, `../AGENTS.tape`,
`../cockpit/references/`) 는 cockpit/CLI 가 **read-only navigation
metadata** 로 읽어도 됨. 단 (a-docs) 의 contents 는 NEVER measurement-
gate / absorbed / parity claim 으로 인용되지 않음 — 즉 docs 는 *카드
표시 + 트리 navigation* 용도이며 *측정 사실의 출처* 가 아님. (b/c/d)
invariant 들 그대로 유지. AGENTS.tape `@D g_cockpit_isolation` 의
rule 이 이 명료화를 반영하도록 수정. (Rejected: invariant (a) 를
records-only 로 strict 유지 — sidebar 가 자기 repo 의 docs 조차 못
읽으면 product surface 가 navigable 안 됨, rfc_010 §4 / rfc_011 §3
부터 모순.) (Rejected: 전부 broad scope 으로 — invariant 의 g3
record-honesty 안전핀 약화.)

**rationale**:
- phase β 의 implementation forcing function — `ArtifactRegistry.
  loadDecisions/loadRFCs/loadDomains` 가 `../design.md`/`../proposals/`
  /`../domains/` 를 읽어야 sidebar 구현 가능. invariant (a) 가
  명료화 안 되면 거버넌스 위반 우려.
- *records* 와 *navigation docs* 의 자연 분리 — records 는 producer
  가 honest-gate 와 함께 emit, docs 는 governance / design / human-
  readable. 둘 invariant scope 가 자연 다름.
- (a-docs) 의 안전핀 — docs contents 가 measurement_gate 주장으로
  인용 금지. 즉 cockpit 이 design.md 의 D29 본문에서 "measured-
  green" 라 적은 prose 를 봤다고, 그 자체로 새 record 의 gate 를
  upgrade 못 함. 모든 gate claim 은 *records* 에서만.
- 새 governance 안 추가, 기존 `@D g_cockpit_isolation` rule 의 1
  field 만 보강 — minimum-new-structure (andrej-karpathy) 정합.
- ArtifactRegistry 의 read path 가 RecordLoader 의 invariant-a
  runtime check 우회하는데 — 그건 의도. records 가 아니므로 runtime
  check 대상 아님. docs read 가 `String(contentsOf:)` 같은 일반 IO
  로 일어남, fail 시 sidebar 가 (empty) 표시 그대로.

### Decision 42 — Cockpit = project workbench, 3-column layout (rfc_012 §5)

**picked**: cockpit 을 read-only record viewer 에서 **project
workbench** 로 진화 — 단일 화면 3-column: **① 7-verb 레시피 rail**
(좁음) · **③ LLM chat "요리선생님"** (좁음, 프로젝트 진행 주축) ·
**② work zone** (가장 넓음 — 상단 재료선반 strip + 하단 3D·차트·
record 시각화 메인) + **④ 상단 toolbar**. rfc_012 §5 가 SSOT.
(Rejected: 기존 D40 4-zone tabbed 유지 — 프로젝트 생성/workbench
개념 미수용; 5-zone narrow-icon-rail — D40 `.sidebarAdaptable` 와
구조 충돌.)

**rationale**:
- user directive (2026-05-19) "프로젝트 생성 · 일반인도 이해·사용
  쉬움" — read-only viewer 로는 미충족, workbench 필요.
- "면적 ≠ 주축" — chat 은 좁아도 프로젝트를 *끌고*, ② 는 넓어
  *결과 전시*; demiurge 의 meta-conductor (지휘) 정신과 정합.
- 사용자가 layout 을 여러 turn 의 gate 로 직접 picked (1·3·2 →
  재료선반=메인창 상단 → ② widest + 상하분할).

### Decision 43 — `+` button = ④ top toolbar; project-creation flow (rfc_012 §3)

**picked**: 프로젝트 생성 진입 = **④ 상단 toolbar 의 `+` 버튼**.
별도 "프로젝트 고르기" 화면 없음 (단일 화면). flow: `+` → 프로젝트명
입력 → "무엇을 만들고 싶으세요?" 자유 입력 → AI 도메인 추론+유저
확인 → ② workbench 가 verb 1 (명세) 부터 진입. (Rejected: 별도
프로젝트-고르기 화면 — 사용자가 불필요로 정정; `+` 를 ① rail 에 —
toolbar 가 session-wide action 의 canonical home.)

**rationale**:
- 사용자 directive — "+ 버튼 필요 · 프로젝트명 입력받아 생성".
- 단일 화면 + 화면-내 `+` = 사용자 명시 ("화면 A 불필요, 화면 B
  에서 + 운용").
- ④ toolbar 는 macOS 에서 new-document 류 action 의 canonical
  위치 (D40 toolbar 와 일관).

### Decision 44 — "무엇을 설계" = free text → AI infers domain → user confirms (rfc_012 §3, option C)

**picked**: 프로젝트 생성 시 "무엇을 설계" 입력 = **자유 텍스트 →
LLM 이 도메인 추론 → 유저 [네/바꾸기] 확인** (rfc_012 option C).
유저는 15 도메인명 (`cern`/`rtsc`/…) 을 몰라도 평소 말로 목표 기술;
AI 가 도메인 매핑, 유저가 ratify. (Rejected: A 15-도메인 메뉴 —
일반인이 도메인명 모름; B 자유텍스트 only — 시스템이 도메인 못
정하면 stall.)

**rationale**:
- 사용자 directive "일반인도 이해·사용 쉬움" 직접 정합 — 전문
  도메인명 노출 0.
- demiurge 의 분야-무관 meta-conductor thesis — AI 가 분야 추론이
  7-verb spine 정신과 맞음.
- g3 — AI 는 *추론* 하되 *확정* 안 함; 유저 확인 step 이 human
  authority 보존.

### Decision 45 — Project data model = manifest in App Support, records via AI agent (rfc_012 §7, option C)

**picked**: 두 데이터 종류 분리 — **🗄 project manifest** (이름·
무엇을설계·7-verb 진행상태 = cockpit 의 작업 상태) 는 `~/Library/
Application Support/lab.dancin.demiurge/projects/<name>/` (exports/
밖); **📸 project 가 생성한 records** 는 AI agent (Claude Code CLI,
θ) 가 producer 로서 `exports/` 에 emit (`@D g_ai_agent_action_
surface` D34). cockpit 은 trigger, 직접 exports/ write 0. `@D
g_cockpit_isolation` 에 cockpit-app-state 절 추가 (본 결정의
governance 부산물). (Rejected: A cockpit 이 exports/ 직접 write —
invariant (d) 폐기 + g3 위험; B manifest 도 agent 경유 — trivial
write 에 subprocess 과잉.)

**rationale**:
- manifest = cockpit 작업 상태, records honesty 경계 (exports/)
  와 별개 범주 — App Support 가 macOS 앱 데이터 canonical 위치.
- records 는 D7 producer-owned + D34 agent-mediated 유지 — g3
  measurement gate 보존.
- `@D g_cockpit_isolation` 의 records-honesty 경계 무손상; D41 의
  a-records/a-docs 분리와 같은 패턴으로 app-state 절 1개 추가.

### Decision 46 — Plain-language layer + expert toggle (rfc_012 §4/§6, option B)

**picked**: 일반인용 **plain-language layer** — `GATE_*`/`provenance`/
`F1F2` 등 전문어를 ⏳(아직 측정 안 됨)/🔶(일부만)/✅(측정 확인됨)
신호등 + 평이 어휘로. **expert toggle** (④ toolbar, 기본 OFF) 켜면
raw 값 verbatim 표시. (Rejected: A plain-only — 전문가 provenance
검증 차단, g3 공개감사 약화; C 항상 둘 다 — 화면 복잡, 일반인
산만.)

**rationale**:
- 사용자 directive "일반인도 쉬움" — 평이 신호등이 디폴트.
- g3 honesty 보존 — 신호등은 `measurement_gate` verbatim 소스,
  UI 가 ⏳→✅ upgrade 금지; expert 토글이 raw 검증 가능성 유지.
- toggle 기본 OFF — 일반인은 존재 몰라도 무해, 전문가만 켬.

### Decision 47 — Project ↔ existing records = own-only + reference view (rfc_012 §7, option C)

**picked**: 프로젝트는 **자기 7-verb run 이 생성한 records 만 소유**;
기존 ~50 `exports/` records (rfc_001–003 NoC 측정) 는 ② work zone
에서 **참고 열람** 가능하나 프로젝트에 *편입 안 됨*. provenance
1:1 (각 record ↔ 정확히 한 producing project). (Rejected: A
own-only + 참고뷰 없음 — 측정 자산 사장; B 기존 records 자동 편입
— 경계 모호, g3 provenance 추적 흐림.)

**rationale**:
- provenance 1:1 추적 — 어느 record 가 어느 프로젝트 산물인지
  명확, g3 정합.
- cockpit 의 원래 viewer 역할 (rfc_009–011) 유지 — 기존 records
  참고 열람은 그 기능.
- 일반인 — "내 프로젝트" 가 백지에서 시작 (명확), 막히면 기존
  측정 참고 (도움).

### Decision 48 — Verb "develop" = conversation-default, θ-2 for real runs (rfc_012 §8, option C)

**picked**: 7-verb 각 단계의 진행 = **기본 대화/계획** (LLM chat);
측정 verb (해석/합성/검증) 에서 **"실제로 돌리기"** 액션 → **θ-2**
(rfc_011 의 scoped AI-agent action dispatch) 가 실제 도구 (Yosys/
OpenROAD/…) 실행. un-run 단계 = ⏳, θ-2 measured record 가 있는
단계만 ✅ (§6 신호등, g3). (Rejected: A design-only — 측정 0,
GOAL 의 "설계 자체를 계산·검증" 미충족; B 항상 자동 실행 — verb
진입마다 도구 호출, rate-limit 폭발 (P-④ 교훈).)

**rationale**:
- GOAL 의 "*설계 자체를 계산·검증*" — 측정 verb 의 실제 도구
  실행 필요; A 는 계획서 작성기로 전락.
- B 의 rate-limit 위험 회피 — 사용자가 *언제* 측정할지 명시
  트리거.
- rfc_011 θ-2 (scoped-tool action dispatch) 와 정확히 정합 —
  θ-2 가 "실제로 돌리기" 의 backend.

### Decision 49 — θ-2 구현 = 메커니즘 골격 우선, 실제 engine tool 은 후속 (cockpit phase κ-5, rfc_011 §6)

**picked**: κ-5 = θ-2 (실제 실행 경로) 의 **메커니즘 골격만** —
"▶ 실제로 돌리기" 액션 버튼 + claude CLI dispatch 경로 + 출력
record-ID 파싱. demiurge 에 실행할 engine tool 이 현재 0개 (Yosys §4
미구현 = hexa-lang 세션 소관; booksim = hexa-lang/stdlib 이전) 이므로,
누르면 agent 가 "실행할 도구 없음" 을 정직 보고하고 측정 record 0 을
유지 — g3 상 ✅ 불가. 도구가 attach 되면 동일 경로로 즉시 측정 가능.
(Rejected: 실제 tool-permission claude 호출 — 돌릴 도구가 없어 무의미
+ GUI subprocess 는 permission prompt 응답 불가; §4.2 REJECTED 배너
우선 — 별도 후속 phase 로.)

**rationale**:
- g3 — 측정 도구 없이 θ-2 를 "완성" 주장 불가; 골격은 골격으로
  정직 표기 (누르면 "도구 없음" 보고, 측정 record 0).
- 메커니즘(UI + dispatch + 파싱)은 engine tool 과 독립 — 미리
  완성해두면 도구 attach 시 코드 변경 없이 측정 경로 가동.
- rfc_011 §6.3 θ phase 정의 (CLI subprocess + 출력 파싱으로 새
  record ID 추출) 를 그대로 구현.
- 사용자 게이트 2026-05-19 — 3택(메커니즘 골격 / §4.2 REJECTED
  가드 / workbench 마감) 중 "θ-2 메커니즘 골격" 선택.
