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
