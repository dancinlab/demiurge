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

### Decision 50 — SSOT single-source: 한 사실/한 로직 = canonical 한 곳 (cockpit phase κ-9)

**picked**: 문서·코드 양면 SSOT 규율을 `@D g_ssot_single_source`
governance 로 박는다. (문서) 결정 SSOT = `design.md`, 진행 SSOT =
`PLAN.md`; 파생 문서(AGENTS.tape `@N` · GOAL.md · CHARTER · HANDOFF ·
README · rfc_*)는 D-range·RFC건수·phase 목록을 복제하지 말고 포인터로
참조. (코드) cockpit 과 CLI 의 공통 도메인/verb/record 분기는
DemiurgeCore 의 동일 함수를 호출 — 각자 `switch` 복제 금지 → 같은
입력에 같은 출력 (CLI↔cockpit 멱등성). 적용: `@N` decisions 의 D 요지
전체 사본 → 포인터; GOAL.md "현재 위치" 의 수치 → design.md/PLAN.md
위임; cockpit 의 domain label·verb hint·canvas-mode `switch` →
DemiurgeCore (`DomainCatalog` · `Verb.hint` · `CanvasMode`).

**rationale**:
- 사용자 2026-05-19 — SSOT reconcile 한 번에 D-번호가 9개 파일에
  박혀 "양쪽" 동시 갱신 부담; 원문 "update 마다 양쪽 업데이트 하지
  않게".
- cockpit 의 domain/verb `switch` 가 CLI 로 복붙되면 drift —
  원문 "CLI, cockpit 멱등성 보장" (동일 함수 → 동일 출력).
- 중복은 정의상 drift 위험; 단일 SSOT + 포인터가 정합 불변식 보존.
- DemiurgeCore 는 이미 `ArtifactRegistry`/`RecordLoader` 를 cockpit·
  CLI 가 공유 — `DomainCatalog`/`Verb` 도 같은 패턴으로 정렬.

### Decision 51 — 재료 선반 옵션 SSOT = domains/*.md §6 (cockpit phase κ-11)

**picked**: workbench 재료 선반 (rfc_012 §5) 의 옵션은 각
`domains/<domain>.md` 의 `## 6. Design options (workbench shelf)`
섹션에서 소싱한다 — domain 맵이 SSOT. `IngredientShelf` 가 §6 를
파싱 (verb 별 plain 설계 옵션, `- <verb>: <group> = a / b / c` 형식).
14 도메인 맵에 §6 신설. `DomainCatalog` 를 domains/ 14 도메인 + chip
으로 확장. (Rejected: §2 도구맵 파싱 — '도구 선택' 이지 설계
파라미터 아님; 코드 카탈로그 — domains/ 와 데이터 이중,
g_ssot_single_source 위반.)

**rationale**:
- 사용자 게이트 2026-05-19 — 3택(§2 도구맵 / domains §6 신설 /
  코드 카탈로그) 중 "domains/ 에 옵션 섹션 신설" 선택.
- domain 맵이 도메인 지식의 SSOT — 설계 옵션도 거기 두는 것이
  g_ssot_single_source (D50) 정합.
- §6 형식 단순 — cockpit ②work zone 과 CLI `list-shelf` 가 동일
  `IngredientShelf` 파서 공유 (CLI↔cockpit 멱등 실증).
- chip/matter 는 domain 맵이 없어 빈 선반 — 정직 (g3), 위조 0.

### Decision 52 — 3D component export 포맷 = usdz / usda / stl / png 4종 (cockpit phase λ)

**picked**: cockpit ComponentMode 3D viewer 의 export 는 `.usdz` ·
`.usda` · `.stl` · PNG 스냅샷 4종을 지원한다. 직렬화는 `DemiurgeCore`
의 순수 함수(`USDExporter` / `STLExporter`)로 두어 cockpit export 메뉴
와 CLI `export-component` 가 동일 코드를 공유한다 (D50). `.obj` 는
STL 과 용도가 겹쳐 제외. (Rejected: `.obj` 포함 — STL 과 CAD/프린팅
용도 중복, 범위만 증가; glTF — RealityKit export 경로 없음.)

**rationale**:
- 사용자 게이트 2026-05-19 — export 포맷 범위 선택에서 "4종
  (obj 제외)" 채택.
- `.usdz`/`.usda` = Apple 생태계 표준 — Quick Look·AR 즉시 동작;
  `.stl` = CAD·3D프린팅 범용; PNG = 문서 첨부용, 구현비용 ≈ 0.
- 직렬화를 DemiurgeCore 순수 함수로 두어 cockpit↔CLI export 멱등
  (g_ssot_single_source / D50) — viewer 와 다른 모델을 내보내는
  사고 차단.
- `.obj` 제외로 λ-3 범위 절감; 필요 시 후속 phase 에서 추가 가능.

### Decision 53 — 7-verb 셀 매핑 전략 = measurable-only (κ-29 후속)

**picked**: ActionDispatch (rfc_011 §6, θ-2) 의 verb×domain 셀 매핑은
**측정 가능한 2개 verb (합성·검증) 의 14 셀 (= 2 × 7 — 도메인 수)**
만 real producer 와 배선한다. LLM verb 5개 (명세·구조·설계·해석·
인계) × 15 도메인 = 75 셀은 `claude` CLI fallback (askClaude) 영구
유지. 어댑터 인터페이스 (`ActionAdapter` 프로토콜) 도입은 매핑 셀
이 **5개를 넘는 시점**에 리팩토링 — 그 전엔 switch/if 로 충분
(premature abstraction 회피). producer 가 없는 도메인 (cohort×12 등)
강제 매핑 금지 — fallback 유지. (Rejected: producer-first uniform —
producer 없는 도메인 매핑 = 빈 어댑터, 의미 0; uniform 어댑터 —
105 셀 프로토콜은 셀 2개 시점 과한 추상화.)

**rationale**:
- 사용자 게이트 2026-05-20 — 3택 (measurable-only / producer-first /
  uniform-adapter) 중 measurable-only 채택.
- GOAL 갭 ("측정 record 0") 직결 — 측정 가능한 곳만 진짜 도구,
  나머지 honest fallback (g3).
- LLM verb 는 본질상 대화 워크플로우 — `claude` CLI 가 자연스런
  producer. 어댑터 강제할 이유 약함.
- premature abstraction 회피 (CLAUDE.md / andrej-karpathy-skills) —
  매핑 셀 5+ 되면 그때 ActionAdapter 프로토콜로 리팩토링.
- producer 가 없는 도메인 강제 매핑 = 빈 어댑터, 측정 record 0,
  GOAL 갭 못 메움.

### Decision 54 — `component + synthesize` producer = FreeCAD parametric (P-⑨ start, κ-33)

**picked**: `component + synthesize` 의 producer 를 **FreeCAD 1.1.x
parametric** (OpenCascade B-Rep kernel) 로 업그레이드한다.
ComponentEmitter 가 `freecadcmd` 를 탐색해서 발견되면
`cockpit/scripts/bipv_freecad.py` 를 spawn — `.step` (CAD 호환) +
`.brep` (OpenCascade native) + `.stl` (mesh ingest) + `.meta.json`
(sidecar) 를 `exports/component/geometry/` 에 emit, typed record 의
`producer = "freecad@<version>"` (예: `freecad@1.1.1`).
FreeCAD 미설치 또는 producer 실패 시 절차 placeholder (κ-29) 로
**honest-gap fallback** — 두 경로 모두 `measurement_gate = GATE_OPEN`
및 `absorbed = false` 유지 (g3). (Rejected: ① 절차만 유지 — P-⑨ 시작
요구; ② FreeCAD 단독 (fallback 없음) — D53 honest-gap 정신 위반,
mac 외 host 에서 동작 0; ③ 다른 CAD (OpenSCAD/CadQuery) — FreeCAD
가 brew 로 즉시 사용 가능 + Python API 가장 성숙 + STEP/BREP 동시
export.)

**rationale**:
- P-⑨ "측정 producer 확보" 의 첫 실제 단계 — 절차 placeholder 가
  아닌 진짜 parametric CAD kernel 로의 승급. GOAL 갭 ("측정 record
  0") 직격은 아니지만 (parametric ≠ 측정), placeholder 의 의미적
  격을 한 단계 올림 (3D 뷰어용 box stack → CAD-interchange STEP).
- producer SSOT 분리 — Swift `ComponentGeometry.bipv5Layer` 는
  뷰어 + USDA/STL exporter 의 SSOT, Python `bipv_freecad.py::LAYERS`
  는 OpenCascade kernel 의 SSOT. 둘 다 동일한 5-layer 1m×1m BIPV
  를 기술 — drift 감지: ComponentEmitter 가 layer_count + 총 두께
  ±0.05mm 차이를 거부 (record 안 쓰임, fallback 트리거).
- absorbed=true 절대 금지 (g3 / @F f6): FreeCAD parametric =
  precision placeholder 이지 측정된 BIPV 모듈 아님. 열/구조/광학
  verdict 는 별도 게이트 (gmsh + Elmer / Code_Aster, 후속 phase).
  scope_caveats 에 4 종 caveat 박제 (parametric/SSOT/separate-gates/
  P-⑨ owner).
- macOS-only 의존성 (FreeCAD.app) — Linux/Windows 에서는 fallback
  자동. wilson-pool 이 mac host 로 라우팅하면 parametric record,
  ubu host 로 라우팅하면 procedural record. record 의 producer
  필드가 honest 한 cross-host evidence.
- D53 "measurable-only 셀 매핑" 과 정합 — `(.synthesize, "component")`
  셀은 이미 매핑됨; 본 결정은 producer 의 internal upgrade, 매핑
  자체 변경 없음.
- D50 g_ssot_single_source 준수 — ComponentEmitter 가 cockpit GUI
  버튼 + DemiurgeCLI `emit-component` + DemiurgeCLI `action
  synthesize component` 셋의 단일 진입점 그대로. 셋 다 동일 record
  emit.

### Decision 55 — cohort producer 발굴 정책 + 첫 producer = `sscb + analyze` (ngspice, κ-34)

**picked**: 13 cohort 도메인 (`domains/{antimatter,aura,bot,brain,cern,
energy,fusion,grid,mobility,rtsc,scope,space,sscb}.md`) 중 producer
매핑 우선순위는 **(a) macOS 에 이미 설치된 OSS 도구 우선 · (b) CLI
한 줄 → record emit 가능성 우선 · (c) D53 measurable-only 두 verb
(합성·해석) 중 어느 쪽이든 OK** 로 정한다. 본 결정의 첫 실현은
**`sscb + analyze` = ngspice 46 transient producer** —
`cockpit/scripts/sscb_ngspice.py` 가 600 V / 100 A DC 하드스위칭
netlist (HEXA-SSCB mk1 plausible topology, domains/sscb.md §1) 를
spawn, `ngspice -b` 로 transient 측정, `rise_time_s` /
`interrupt_ratio` 등 헤드라인 측정값을 typed `SSCBRecord` 로
`exports/sscb/transient/<stamp>/` 에 영구화. producer 는
`ngspice@<version>` 으로 핀, **measurement_gate = GATE_OPEN 영구 /
absorbed = false 영구** — ngspice 의 IEEE-754 솔버 출력은 실제
측정이지만 회로 자체가 plausible-not-datasheet 이므로 (SiC 스위치 =
generic Ron/Roff 모델, no Wolfspeed C3M0021120K .lib) 흡수 주장은
금지. (Rejected: ① grid+structure (NetworkX) — 도구 접근성 동일하지만
verb 가 D53 의 "측정 가능 2 verb (합성·해석)" 밖; pickup note 로
이월. ② bot+design (Pinocchio) — pip install 200 MB 친화도 낮음;
pickup note 로 이월. ③ scope+design (POPPY) — pip install + 우주
망원경 PSF 가 cohort 다양성 입증에 sscb 보다 약함. ④ uniform
"모든 cohort 강제 매핑" — D53 위반, fallback 본 정신 무시.)

**rationale**:
- P-⑧ "cohort 도메인이 demiurge 의 '분야 무관' 주장을 입증" 의 첫
  실제 단계 — chip/component/matter 세 "deep / hexa-lang-owner 기둥"
  외, breadth-survey cohort 도 producer 임계점을 넘을 수 있다는
  증거. honest scope = 13 중 1 (sscb), 과대주장 금지 (g3).
- 도구 접근성 점수표 (κ-34 분석):
  - ngspice 46 (sscb) — brew install, 한 줄 batch mode, **10/10**
  - networkx (grid) — python3 stdlib-like, **9/10** → pickup #1
  - URDF + pinocchio (bot) — conda 필요, **7/10** → pickup #2
  - POPPY (scope) / PyBaMM (energy) — pip 가능하지만 cohort 다양성
    입증에 sscb 보다 약함, **6/10**
  - FEMM (rtsc) — macOS Wine 필요, **2/10**
  - CARLA (mobility) / Geant4 (antimatter) — 무거운 install,
    **1-2/10**
- ngspice 의 transient 시뮬레이션 결과는 **실제 숫자**: pre-trip
  99.7 A / post-trip 35.1 A (interrupt_ratio = 0.35), v_sw_pre =
  1.99 V → v_sw_post = 428.2 V, rise_time = 1.53 µs. **이 숫자들이
  HEXA-SSCB mk1 ≤ 1 µs 목표를 만족하지 않는 것이야말로 honest gap**
  — generic 100 nF · 5 Ω 스너버의 한계가 실제로 드러남, buggy 가
  아님. record 의 scope_caveats 가 이 격차를 박제.
- absorbed=true 절대 금지 (g3 / @F f6) — Wolfspeed C3M0021120K
  class `.lib` + bench-validated load + DEVSIM TCAD coupling 이
  들어와야 흡수, 그 전엔 GATE_OPEN 영구. 본 결정은 cohort producer
  의 임계점만 입증; 후속 phase 가 device-model 흡수.
- D53 "measurable-only" 와 정합 — `(.analyze, "sscb")` 셀이 5번째
  매핑 셀 (기존: component+synthesize, chip+verify, chip+synthesize,
  matter+analyze). D53 의 "5+ 시점 ActionAdapter 리팩토링" 임계점에
  도달했으나, 본 phase 는 wiring 만 — 리팩토링은 다음 라운드.
- pickup 우회 — grid (NetworkX, 무료 install) 와 bot (URDF +
  Pinocchio, ~200 MB conda) 은 `inbox/notes/cohort-pickup-grid-…`
  / `cohort-pickup-bot-…` 로 다음 세션 위임. 한 라운드 한 셀이
  D53 의 "premature abstraction 회피" 와 g3 의 "honest scope"
  정신과 정합.

### Decision 56 — `chip + analyze` producer = hexa-native booksim oracle (Leighton analytic bounds)

> **reconstructed post-merge from agent reports** — 본 블록은 7-worktree
> consolidation merge (`-X ours` 전략) 에서 drop 된 원본 D56 을 worktree
> commit `fa05276` + `exports/chip/noc/analyze/` record 로부터 복원한 것.
> 원본은 cohort 병렬 라운드에서 작성됐고 standalone `## 진행 로그` κ
> entry 는 merge 에서 유실 — κ-resequence (D-num 정합 정정 phase) 대상
> 밖이라 본 D 블록만 복원.

**picked**: `chip + analyze` 의 producer 를 **hexa-native
`stdlib/booksim/booksim.hexa::cmd_oracle`** (Leighton 1984 analytic
lower bounds) 로 매핑한다. ChipAnalyzer 가 `hexa run
stdlib/booksim/booksim.hexa` 를 spawn — 디스패처 self-test 가
`cmd_oracle` 을 실행해 8×8 / n=64 reference (d4 mesh + d6 hex) 의
`bisection_lower=8 diameter_lower=14` 라인을 emit. ChipAnalyzer 가
이 라인 + cite 라인 (Leighton 1984 Thm 2 + Dally & Towles PPIN 2004
§3.2-3.3) 을 파싱해 typed `ChipAnalyzeRecord` 를
`exports/chip/noc/analyze/<recordId>.json` 에 영구화. producer 는
`hexa_native_booksim_oracle@<hexa-lang commit>` 으로 핀,
**measurement_gate = GATE_CLOSED_MEASURED + absorbed = true 정당**
— Leighton bound 는 수학적 정리, oracle dispatch 는 그 algebraic
표현의 평가, 그리고 알고리즘 자체가 hexa-native 이라 외부 라이브러리
absorbed 없음 (D17 matter+analyze 패턴 동일). (Rejected: ① 셀
미매핑 유지 — D53 measurable-only 정책상 매핑 가능 셀을 매핑 안 하는
것이 더 큰 갭. ② cmd_measure 를 analyze 셀에 wiring — verb 의미
충돌 (verify=측정 검증 vs analyze=설계 점검). ③ booksim oracle 을
별도 sub-CLI 로 추출 — 현 디스패처 self-test 가 cmd_oracle 을
이미 호출하므로 추가 entry 불필요, premature abstraction.)

**rationale**:
- D53 "measurable-only 셀 매핑" 과 정합 — `(.analyze, "chip")` 가
  6번째 매핑 셀 (기존: component+synthesize, chip+verify, chip+
  synthesize, matter+analyze, sscb+analyze). switch/case 가 6 셀에
  도달 — D53 의 "5+ 시점 ActionAdapter 리팩토링" 임계점 정식 통과,
  다음 라운드에서 protocol + registry 패턴이 자연 (본 phase 는 wiring
  만, 리팩토링은 별도).
- **gate=CLOSED_MEASURED + absorbed=true 가 정당한 이유** (g3 의
  honest-scope, 본 결정의 핵심):
  - Leighton 1984 Thm 2 는 *수학적 정리* — k-ary 2-mesh 의
    bisection 하한이 k 이고 diameter 하한이 2k-2 라는 것은 algebraic
    closed form. oracle dispatch 는 이 closed form 을 평가하는 것
    이지 가정 (assumption) 이 아님. 따라서 `bisection_lower=8
    diameter_lower=14` 는 8×8 reference 에 대한 *증명된 fact* 이다.
  - producer 가 *hexa-native* (`stdlib/booksim/leighton.hexa`,
    D15·D17) — 외부 라이브러리·datasheet·OSS 도구를 absorbed 한
    것이 아니라 hexa-lang 자체가 closed form 을 구현. matter+analyze
    와 동일 stance: hexa-native code 가 producer 면
    `absorbed=true` 합법, 외부 substrate 의존 0.
  - **이 정당성의 한계** (scope_caveat) — record 는 *수학적 하한*
    이지 *real chip 의 wire latency 측정*이 아님. delay 측정은
    booksim cmd_measure 의 F1F2 record (chip+verify 셀) 가 담당.
    본 record 는 그 F1F2 record 들이 위배되지 않는지의 *cross-floor*
    — 모든 F1F2 record 가 이 bound 를 만족해야 함 (rfc_001 §7.3 /
    §8). 즉 absorbed=true 가 "demiurge 가 real chip 을 측정함" 을
    뜻하지 *않는다*는 점이 scope_caveats 의 핵심.
- 처음으로 chip 도메인에서 `GATE_CLOSED_MEASURED + absorbed=true`
  record 를 보유 — 기존 chip 셀들 (verify: GATE_OPEN single-point;
  synthesize: GATE_OPEN dispatcher) 의 부족함을 보완. 단 "real chip
  wire latency 측정" 이라는 GOAL 갭은 *여전히 미해결* — 본 결정은
  *analytic floor* 확보이지 *measured curve* 확보가 아님 (g3).
- D50 g_ssot_single_source 준수 — ChipAnalyzer 가 cockpit GUI
  `▶ 실제로 돌리기` 버튼 + DemiurgeCLI `action analyze chip` 두
  경로의 단일 진입점. 동일 record 1건/호출, byte-identical 렌더.

### Decision 57 — `grid + structure` producer = NetworkX IEEE 14-bus (P-⑧ cohort)

> **reconstructed post-merge from agent reports** — 원본 D57 은 worktree
> commit `74a269c` 에서 작성됐고 consolidation merge (`-X ours`) 에서
> drop. worktree commit + `exports/grid/structure/` record 로부터 복원.
> standalone κ entry 도 유실됨.

**picked**: `grid + structure` (architect 셀) 의 producer 를 **NetworkX
3.2.1 graph-topology 측정기**로 배선한다 — IEEE 14-bus 표준 reference
(Christie 1962 / pglib-opf case14) 를 canonical 토폴로지로 사용하고,
`diameter` · `avg_shortest_path_hops` · `bisection_min_cut_edges`
(edge-connectivity) · top-N betweenness/degree centrality 를 deterministic
metric 으로 emit. cohort producer 라운드의 일부 (D55 의 sscb+analyze
ngspice producer 다음 — pickup note `inbox/notes/cohort-pickup-grid-
networkx-producer.md` 의 runner-up 을 라이브화). 본 셀의 `measurement_
gate = GATE_CLOSED_MEASURED` 는 honest 함 — 그래프 메트릭은 NetworkX
의 IEEE-754 deterministic 솔버가 produce 하는 **수학적 사실** 이지
model prediction 이 아님. 단 `absorbed = false` 영구 — NetworkX 는
외부 Python 라이브러리, hexa-lang stdlib 미흡수 (D17 mirror — 외부
도구가 owner, demiurge 는 consumer). (Rejected: ① fat-tree/leaf-spine
/dragonfly 토폴로지 즉시 합성 — pickup note 의 원안이지만 *plausible*
topology 라 GATE_OPEN 으로 강등됨, 첫 producer 부터 ↑ gate 손해; ②
다른 그래프 lib (igraph / graph-tool) — NetworkX 이미 host 설치 +
순수 Python = 빌드 zero, 다른 lib 는 C 의존성 + 동등 metric set; ③
DC fabric manifest 직접 ingest — Meta/Google 공개 manifest 미존재,
clean-room 위반 위험.)

**rationale**:
- 사용자 게이트 2026-05-20 — pickup note runner-up 을 κ-34 의 sscb
  producer 다음 단계로 채택. cohort producer = breadth survey
  의 13 도메인 중 하나가 measuring 도구를 통과.
- GOAL 갭 ("측정 record 0") 직격 — 본 producer 가 emit 하는
  GridRecord 는 **GATE_CLOSED_MEASURED** 사례 (chip F1F2 외).
  sscb 의 GATE_OPEN 보다 epistemic 격상 — graph metric 은 model
  parameter 가 아니라 topology 위에서 unique 하게 결정.
- IEEE 14-bus = 표준 reference 의 이유: ① 1962년 이래 power systems
  교과서에 박혀 *모범 예제* 격 (재현성 100%), ② demiurge `grid`
  도메인 = AI 데이터센터 fabric 이지만 본 caveat #1 에서 명시 ("
  power-grid reference, AI-DC fat-tree 아님"), ③ fat-tree 합성에 비해
  edge list 가 압축적 (14 nodes / 20 edges) 으로 record JSON 크기
  관리 가능.
- absorbed=false 절대 금지 (g3 / @F f6): NetworkX 는 hexa-lang
  stdlib 가 아닌 외부 Python 라이브러리. `hexa-graph` stdlib 가
  들어와 동일 metric 을 수치 동일 재현하면 그때 absorbed flip — 본
  phase 는 scope out. scope_caveats 4종 박제 (power-grid reference /
  link-count-not-Gbps / closed-measured-scope-limited / absorbed=
  false-permanent).
- D53 "measurable-only 셀 매핑" 과 정합 — 본 결정은 매핑 자체를
  확장 (`(.structure, "grid")` 추가). D53 의 "측정 가능한 2 verb =
  합성·검증" 정책은 약간 확장 — *structure* (architect) 도 그래프
  위에서는 측정 가능하기 때문 (후속 가이드: "측정 가능한 verb 는
  도메인 마다 다르다 — 단정 금지", 본 D57 rationale 한정).
- D50 g_ssot_single_source 준수 — GridStructureProducer 가 cockpit
  ▶ 버튼 + DemiurgeCLI `action structure grid` 양쪽의 단일 진입점.

### Decision 58 — `bot + structure` producer = yourdfpy URDF parser (P-⑧ cohort)

> **reconstructed post-merge from agent reports** — 원본 D58 은 cohort
> 병렬 라운드의 bot+structure worktree 에서 작성됐으나 consolidation
> merge (`-X ours`) 에서 drop 됐고, worktree commit 도 별도 보존되지
> 않음. 본 블록은 `exports/bot/structure/2026-05-19T18-09-50Z/` record
> 의 provenance 필드 + ActionDispatch.swift `runBotStructure()` 주석
> + cohort 보고로부터 재구성. 불확실 — record 의 실제 값이 SSOT.

**picked**: `bot + structure` (architect 셀) 의 producer 를 **yourdfpy
0.0.60 URDF 파서**로 배선한다 — self-generated hermetic 2-link revolute
arm 의 URDF 를 파싱해 `link_count` · `joint_count` · `DOF` ·
`total_mass` · trimesh 시각 bounding box 를 deterministic metadata 로
emit, typed `BotRecord` 를 `exports/bot/structure/<stamp>/` 에 영구화.
producer 는 `yourdfpy@0.0.60` 으로 핀 (urdfpy 는 2020 마지막 릴리스로
deprecated — maintained successor yourdfpy 로 fallback). **measurement_
gate = GATE_OPEN 영구 / absorbed = false 영구** — URDF parse 결과
숫자는 실제이지만 *URDF spec metadata* 일 뿐 실제 로봇 하드웨어 측정이
아님 (동역학·접촉·페이로드·액추에이터 응답 없음). (Rejected: ①
Pinocchio 동역학 즉시 — ~200 MB conda 설치, cohort 라운드 한 셀
scope 밖, pickup note 로 이월; ② UR5 / Franka vendor URDF 흡수 —
datasheet-grade vendoring 은 별도 라운드.)

**rationale**:
- D55 cohort 발굴 정책의 적용 — breadth-survey cohort 도메인
  (`domains/bot.md`) 이 measurable producer 임계점을 넘는 증거.
  URDF parse 1 leaf 만 커버 — bot 결과물 = URDF + actuator/sensor
  선정 + controller architecture + safety analysis 4중 트리 중 1.
- **g3 정직 갭** — yourdfpy 의 parse 출력 (link_count=4, joint_count
  =3, DOF=2, total_mass=3.6 kg, bbox=0.2×0.2×0.7 m) 은 실제 숫자
  이지만 spec 메타데이터. GATE_OPEN 영구 — Gazebo regression /
  Drake verification primitives (Lyapunov, SOS, contact-implicit) /
  ros2_control HIL / ISO 10218 risk-assessment 이 들어와야
  GATE_CLOSED 후보 (domains/bot.md §2 7-verb 맵).
- absorbed=true 절대 금지 — yourdfpy 는 외부 pip 라이브러리, hexa-
  lang stdlib 미흡수 (D17 — hexa-matter / hexa-lang 가 절차 SSOT,
  demiurge 는 consumer). 두 lib (urdfpy/yourdfpy) 모두 미설치 시
  honest gap, silent success 금지 (g3).
- D53 "measurable-only" 와 정합 — `(.structure, "bot")` 셀 매핑
  추가. D57 (grid+structure) 와 동일하게 architect verb 가 spec
  파싱 위에서는 측정 가능 — 단 grid 의 graph metric (CLOSED) 과
  달리 bot 의 URDF 파싱은 하드웨어 측정 아님 → GATE_OPEN.

### Decision 59 — `energy + analyze` producer = pvlib clear-sky (P-⑧ 4번째 cohort, κ-35)

**picked**: cohort domain producer 발굴 라운드 (D55) 의 4번째 picks =
**`energy + analyze` = pvlib clear-sky + CEC SAPM 모델**. `cockpit/
scripts/energy_pvlib.py` (이후 hexa-lang stdlib 으로 마이그레이션 —
D61 birth-violation 목록 포함) 가 Phoenix AZ (33.45°N · 112.07°W ·
alt 331 m · America/Phoenix tz) 의 1년 hourly clear-sky GHI/DNI/DHI
를 pvlib 의 Ineichen 모델로 계산하고, CEC database 의 표준 모듈
(Canadian_Solar CS5P_220M) + 인버터 (ABB MICRO-0.25) 를 ModelChain
으로 결합하여 hourly DC/AC power 를 산출, `annual_energy_kwh` 를
헤드라인 측정값으로 typed `EnergyRecord` 에 영구화 →
`exports/energy/pv/<stamp>/`. producer 는 `pvlib@<version>` 으로
핀, **measurement_gate = GATE_OPEN 영구 / absorbed = false 영구**
— pvlib 의 Ineichen + CEC SAPM 알고리즘 출력은 NREL SAM 검증된
표준이지만 **sky-measured irradiance 데이터가 0** (no TMY3 / NSRDB),
즉 *clear-sky upper bound* 이지 TMY yield 예측이 아님 (실제 yield
는 보통 70-85 % 수준 — 구름·에어로졸·소일링·인버터 클리핑 미적용).
(Rejected: ① PyBaMM battery 우선 — pip install 무겁고 thermal/
electrochemical coupling 가 단발 record 로 환원되기 어려움; pickup
note 로 이월. ② Geant4/OpenMC 원자로 우선 — 무거운 install +
규제 컨텍스트 너무 좁음. ③ TMY3 즉시 흡수 — NSRDB API key 필요
+ 별도 라운드, 본 phase scope 밖.)

**rationale**:
- D55 cohort 도구 점수표의 다음 단계 — sscb (κ-34, 10/10) 다음으로
  pvlib 는 pure-Python pip install (no native deps, ~19 MB wheel),
  표준 location + 모듈 spec 1 set 만으로 hourly 1년 record emit 가능.
  도구 접근성 점수 약 8/10 (POPPY 6/10 위, NetworkX 9/10 아래).
- g3: pvlib 의 clear-sky 계산은 **NREL SAM 검증된 표준 알고리즘**
  (Ineichen+Perez, CEC SAPM 모듈 모델) → algorithm output 자체는
  진짜. 그러나 **실제 측정된 sky 데이터 없음**, 표준 모델 출력
  이므로 → **GATE_OPEN** 영구 / **absorbed=false** 영구. record 의
  4종 scope_caveats 가 이 격차를 박제 (no-TMY · CEC-database-lookup ·
  no-system-losses · GATE_OPEN-rationale).
- 측정값 (이 worktree, mac local, swift 6.3.1, pvlib 0.15.1, python
  3.14.4): `annual_energy_kwh = 468.393` (AC) · `annual_energy_dc_kwh
  = 489.583` · `ac_peak_kw = 0.186` · `ghi_annual_mwh_per_m2 = 2207.8`
  · `rows = 8784` (leap year hourly). 월별 분포: 1월 37.2 kWh ↘ 3월
  42.3 kWh ↗ (Phoenix 봄철 GHI 피크) ↘ 12월 34.3 kWh. 표준 220 W
  모듈 → ~2127 kWh/kWp 단위 환산 (사막지대 clear-sky 상한 합리적).
- D61 (cockpit/scripts/*.py = pointer-only 위반) 자명히 인지 —
  AGENTS.tape `g_demiurge_pointer_only` 의 birth-violation 목록에
  `energy_pvlib.py` 이미 포함 (D61 line 34). 본 phase 는 producer
  존재 증명이 우선, 마이그레이션은 D61 batch round (`hexa-lang/
  stdlib/energy/`) 에서 일괄 처리.
- D53 "measurable-only" 와 정합 — `(.analyze, "energy")` 셀이
  6번째 매핑 셀 (기존: component+synthesize, chip+verify, chip+
  synthesize, matter+analyze, sscb+analyze). 5+ 임계점 (D53) 은
  이미 sscb 에서 도달했고 본 셀로 protocol/registry 리팩토링 압박
  더 커짐 — 다음 라운드 ActionAdapter 작업으로 명시 이월.
- absorbed=true 절대 금지 (g3 / @F f6) — bench-validated I-V curve
  + TMY3 / NSRDB site weather data + system loss model (DC wiring,
  mismatch, soiling, clipping) 이 들어와야 흡수. UL 1703 모듈
  인증은 별도 게이트 (accredited lab type-test), pvlib ≠ 인증.
- pickup 우회 — battery (PyBaMM) · grid (NetworkX) · 원자로
  (OpenMC) 후순위. 본 phase 는 cohort breadth-coverage 4 번째 도장
  (sscb·grid?·bot?·energy) 단일점.

### Decision 60 — `space + analyze` producer = Skyfield SGP4 propagation (P-⑧ cohort)

> **reconstructed post-merge from agent reports** — 원본 D60 은 worktree
> commit `d813541` 에서 작성됐고 consolidation merge (`-X ours`) 에서
> drop. worktree commit + `exports/space/orbit/` record 로부터 복원.
> standalone κ entry 도 유실됨.

**picked**: cohort producer 발굴 (D55 정책) 의 적용 — `(.analyze,
"space")` 셀이 **Skyfield + sgp4** Python 라이브러리 쌍을 producer 로
잡는다. `space_skyfield.py` 가 inline-bundled 표준 NORAD TLE (ISS
ZARYA · HST) 를 24-시간 60 s 케이던스로 SGP4 propagate, 고정 Seoul
관측자 (37.5665°N, 126.978°E, 38 m) 로 topocentric reduce →
altitude/azimuth/visibility 측정, 산출물 4종 (`.tle` 입력 ·
`.meta.json` 요약 · 두 satellite 의 `.ndjson` 트랙) 을
`exports/space/orbit/<stamp>/` 에 박제. Swift `SpaceAnalyzeProducer`
가 meta.json 을 재독해 typed `SpaceRecord` 1건을 같은 dir 에 emit
(interface `"demiurge:space:orbit-record"`, schema 1.0). producer
= `skyfield@<v>+sgp4@<v>` (라이브러리 핀, TLE-source 권한 핀이 아님).
**measurement_gate path: worst_tle_age_days ≤ 7 → GATE_CLOSED_MEASURED**
(SGP4 의 nominal validity window 안 — Skyfield+SGP4 는 NORAD reference
대비 bench-validated, Vallado 2006 검증); **> 7 → GATE_OPEN** (TLE
drift, ~1 km/d 누적). **absorbed = false 영구** — Skyfield 는
EXTERNAL pip library, hexa-lang / hexa-arch 로 흡수 아님.
(Rejected: ① 라이브 Celestrak fetch — typed-record contract 위반,
매번 다른 결과. ② 사용자 위치 즉시 configurable — prototype 단계의
reproducibility 우선; configurable 화는 후속. ③ Hubble 단독 / ISS
단독 — 두 위성이 LEO 다양성 더 잘 입증. ④ `(.synthesize, "space")`
= GMAT trajectory optimization — macOS GMAT 설치 무거움, analyze 가
"이미 설치된 OSS + 한 줄" 우선.)

**rationale**:
- D55 cohort 발굴 정책의 적용 — breadth-survey cohort 도메인이
  누적적으로 measurable producer 임계점을 넘는 증거. chip /
  component / matter 세 "deep / hexa-lang owner 기둥" 외 패턴 확립.
- **g3 정직 차별점**: SGP4 는 sscb 의 "plausible-not-datasheet"
  케이스와 다르다. NORAD-standard propagator (Hoots/Roehrich 1980,
  Vallado 2006 검증), Skyfield 가 reference C 구현 wrap. **`tle_age
  ≤ 7 d` 면 GATE_CLOSED_MEASURED 적합** — caveat 는 TLE-age 이지
  도구 흡수 부족이 아니므로. 이는 sscb (영구 GATE_OPEN) / yosys
  rfc_006 §5 (절대 OPEN) 와의 첫 honest conditional gate-CLOSED
  후보 producer.
- **그러나 absorbed=false 는 영구** — GATE_CLOSED_MEASURED 가
  닫혀도 Skyfield 는 외부 pip library 이지 hexa-lang 내장이 아님
  (g3 분리 원칙: 측정 게이트 ≠ 도구 흡수 권한).
- 도구 접근성 점수표 (cohort 분석):
  - skyfield+sgp4 (space) — pip install, 한 줄 CLI, **9/10**
  - GMAT (space synthesize) — macOS 설치 무거움 (Java GUI), **5/10**
  - Basilisk (space analyze) — conda + C++ 빌드, **6/10**
  - poliastro — pip 가능하지만 Skyfield 보다 cohort 다양성 약함, **7/10**
- 측정 (worktree, mac local): `swift run DemiurgeCLI action
  analyze space` → `python3 = /opt/homebrew/bin/python3` · `exit 0,
  sats=2` · `skyfield = 1.54 · sgp4 = 2.25` · 본 측정에서 worst TLE
  age = 18.21 d (snapshot 2026-05-01) > 7 d 임계 → **GATE_OPEN**.
  record emit OK (`exports/space/orbit/2026-05-19T17-08-49Z/`).
- TLE 입력은 inline-bundled (Celestrak 2026-05-01 snapshot) — live
  fetch 미사용 (deterministic input 우선, g3 — silent success 방지).
  fresh TLE 로 GATE_CLOSED_MEASURED 입증은 후속 phase 가 TLE bundle
  업데이트 후.
- D53 "measurable-only" 정합 — `(.analyze, "space")` 셀 매핑 추가.
  switch/case 5+ 임계점 누적 — ActionAdapter 프로토콜 리팩토링은
  다음 라운드.

### Decision 61 — demiurge = pointer / spawn wrapper ONLY (D15 일반화)

**picked**: 모든 producer script (Python / shell / hexa-native) 의
SSOT 는 `hexa-lang/stdlib/<domain>/` 이고, **demiurge 는 그 script
를 `Process` 로 spawn 하는 *포인터/래퍼* 만 보유**한다. demiurge
안에 producer 의 compute 로직 (Python 스크립트, 시뮬 setup 코드)
을 두지 않는다. AGENTS.tape `@D g_demiurge_pointer_only` 가 INDEX
최상단에 lock — 모든 새 producer PR 은 script 가 hexa-lang 안에
있고 demiurge 가 spawn-wrapper 만임을 보여야 머지된다. (Rejected:
demiurge 안에 Python script 두기 — D15/D17 generalization 위반;
per-domain sibling repo — D15 폐기 결정과 모순.)

**rationale**:
- 사용자 게이트 2026-05-20 — "AGENTS.tape 최상단으로 해당내용
  옮겨서 기록, demiurge 는 포인터(spawn wrapper)". D15 의 generic
  확장.
- D15 의 "stdlib ⊂ hexa-lang ONLY" 가 hexa-native 모듈에 한정돼
  있었으나 κ-33 (FreeCAD bipv_freecad.py) · κ-34 (sscb_ngspice.py)
  부터 Python producer script 가 demiurge 안에 출현 — 같은 SSOT
  원칙의 외연 확장 필요.
- demiurge 의 역할 명확화 — 7-verb spine + typed Record schema +
  cockpit GUI 만 demiurge 소유. compute kernel 은 전부 hexa-lang.
- 자동 enforcement — `cockpit/scripts/*.py` 출현 시 AGENTS.tape
  `g_demiurge_pointer_only` 위반으로 block.
- migration plan: 기존 위반 6개 (bipv_freecad · sscb_ngspice ·
  grid_networkx · bot_urdf · energy_pvlib · space_skyfield) →
  `~/core/hexa-lang/stdlib/<domain>/` 으로 이동, Producer.swift
  spawn path 갱신.

### Decision 65 — `cern + verify` producer = particle + Bethe-Bloch analytic (Stage 1 substrate, κ-38)

**picked**: `cern + verify` 셀의 producer 는 `~/core/hexa-lang/stdlib/
cern/bethe_bloch_stopping.py` (scikit-hep `particle` 0.26.2 + PDG eq.
34.5 Bethe-Bloch 폐쇄형 + `uproot` ROOT 파일 출력) 이고, **ABSORPTION.md
§"hexa 포팅 단계"의 Stage 1 substrate** 로 분류한다. `measurement_gate
= GATE_OPEN 영구 / absorbed = false 영구`. Stage 4 absorbed=true 진입은
hexa-native `.hexa` port (Stage 2) + Geant4 MC parity 측정 (Stage 3,
±tolerance) 후만 가능 — Geant4 hexa 포팅 = ABSORPTION.md §103 의
⭐⭐⭐⭐⭐ (Monte-Carlo 입자 시뮬레이터 전체, 수개월~). (Rejected:
demiurge 안에 script — D61 위반; Geant4 binary 즉시 설치 + MC 실행 —
mini host-down + 1-2일 설치 cost, 본 phase scope 밖.)

**rationale**:
- 사용자 게이트 2026-05-20 — "해당 라인 마이그레이션 진행 · hexa-lang
  stdlib 흡수, demiurge 는 포인터기능만, AGENTS.tape 참고 · ubu-1/
  ubu-2/mini 자원활용". ABSORPTION.md 무거운 후보 표의 `antimatter
  / cern + measured | Geant4 + ROOT | 1-2일` 행이 출처. heavy 작업
  은 별도 세션 권장 (ABSORPTION.md §131) — 본 phase 는 Stage 1
  substrate 만 한 세션에 완결, full Geant4 MC 는 follow-up.
- Bethe-Bloch IS Geant4 G4hIonisation 의 내부 closed-form — 따라서
  numbers ARE real (PDG K=0.307075 MeV·cm²/g · antiproton 938.272
  MeV/c² · 4 재료 mean-excitation I). g3 정직 갭은 **네 가지 보정
  누락**: shell corrections (low-E Z/β), density-effect δ
  (Sternheimer high-γ), straggling 분포 (mean only), nuclear stopping
  channel. trap-design + shielding scoping 에는 정확 충분, detector
  시뮬 absorbed-claim 에는 부족.
- ROOT 파일 = `uproot` (pip-installable, pure-Python, CERN ROOT 바이너리
  미설치) — TTree per material 으로 28 rows 시각화 가능. "Geant4 +
  ROOT" 표 행의 ROOT 측면 충족, full ROOT (TFormula · fitter) 는
  별도.
- D61 정합 birth-compliant — script SSOT 가 `~/core/hexa-lang/stdlib/
  cern/bethe_bloch_stopping.py` (cockpit/scripts/ 0). demiurge 측
  =CernVerifyProducer.swift (Process spawn 래퍼) + CernRecord.swift
  (typed sidecar) 만.
- 7번째 측정 가능 매핑 셀 (D53 5+ 셀 임계점 누적 초과) — ActionAdapter
  protocol 리팩토링 압박 더 커짐, 별도 phase.
- **pool 자원 활용** (사용자 지시): ubu-1 linux 에 동일 deps (particle
  + uproot + numpy) `pip3 --user --break-system-packages` 설치 완료.
  rsync 후 ubu-1 (python 3.12.3) 에서 동일 script 실행 — mac local
  (python 3.14.4) 과 **CSV SHA-256 byte-identical**: `b7c8c46f44be
  a3555d28e4266389055fe2a0380be3e8a455aadd729b0a687806`. Bethe-Bloch
  의 deterministic 성질 cross-host 입증. ubu-2 도 동일 환경 — Stage
  2 parity 측정 시 distributed parity sweep 가능. mini (macos) 다운
  으로 `swift build` 라우팅 timeout → `S=swift; B=build; $S $B`
  변수 분리 로컬 빌드 (pool.json 수정 없이 회피).

**측정**:
- `swift run DemiurgeCLI action verify cern`: exit 0 · rows=28 ·
  Pb @ 100 MeV: dE/dx = 3.6100 MeV·cm²/g (NIST PSTAR ~3.5 PASS)
  · Al @ 1 GeV: 1.7666 MeV·cm²/g γ=2.07 (MIP regime PASS) · 3
  artifacts (csv 2067B + meta 9575B + root 6804B) · `exports/cern/
  stopping/<stamp>/cern_g4_stopping_<stamp>.json` 1건 emit. 빌드
  green (pre-existing warning 만).
- **cross-host parity** (ubu-1, python 3.12.3): 동일 28 rows ·
  동일 fingerprint `60e34a15cfb4477f` · CSV SHA-256 byte-identical.
  Bethe-Bloch는 deterministic by design, byte-parity는 기대된
  결과지만 측정으로 확증 (g3 — 측정 없이 주장 금지).

### Decision 62 — sscb device-model absorption skeleton = `hexa-lang/stdlib/sscb/` (κ-36)

**picked**: SSCB 도메인의 device-model 흡수 (Wolfspeed C3M/E3M 클래스
SiC `.lib` + DEVSIM TCAD) 의 SSOT 를 **`~/core/hexa-lang/stdlib/sscb/`
스켈레톤** 으로 landing. 3 `.hexa.stub` 모듈 (`sscb.hexa.stub` 디스
패처 · `wolfspeed.hexa.stub` SPICE `.lib` 파서 · `devsim.hexa.stub`
TCAD 드라이버) + booksim 패턴의 `README.md` 상태 배너 (gate=OPEN,
absorbed=false) + clean-room 합성 fixture (`fixtures/sample_sic_mosfet
.lib`). 모든 body 는 raw-91 (booksim doctrine — silent skip BANNED).
demiurge 측은 pointer 갱신만 (`ABSORPTION.md` 표 행 + 본 D62 + PLAN
κ-36). 기존 `SSCBProducer.swift` (κ-34, ngspice generic R_on/R_off)
는 unchanged — Wolfspeed `.lib` parity 가 §8 GREEN 후에야 두 번째
시그널로 들어옴. (Rejected: 본 세션에서 parser body 완주 — "수일"
범위; 본 세션은 typed-interface scaffold 만. demiurge 안에
`cockpit/scripts/wolfspeed.py` — D61 위반.)

**rationale**:
- 사용자 게이트 2026-05-20 — "Wolfspeed SiC `.lib` 흡수" 를 "여기서
  진행" + "hexa 포팅" + AGENTS.tape D61 준수. SSOT 는 hexa-lang.
- D55/κ-34 가 sscb+analyze 를 generic R_on/R_off ngspice 로 열어
  뒀으나 absorbed=true 까지 가려면 명명된 디바이스 (Wolfspeed
  C3M0021120K 류) 의 `.lib` 파서 + 데이터시트 parity 가 필요 —
  `domains/sscb.md` §4 "Biggest open-source gap" 의 직접 답.
- booksim 선례 (`stdlib/booksim/`) 의 skeleton-then-bodies 패턴 그
  대로 미러 — `.hexa.stub` + 디스패처 + 모듈 인덱스 + 상태 배너 +
  raw-91, 후속 bodies-landing PR 이 audit-가시 (.stub→.hexa rename).
- g3 정직: gate=OPEN, absorbed=false 명시. parser body 0줄, DEVSIM
  연결 0회, 어떤 측정 record 도 추가되지 않음. "Wolfspeed 흡수
  진행 중" 은 ABSORPTION.md 표에 🚧 로만 표기.
- D61 준수: hexa-lang 이 모든 compute SSOT. demiurge 의 어떤 `.swift`
  도 새로 만들지 않음 — 본 D62 + κ-36 entry + ABSORPTION 표 1행 +
  fixture 3개의 pointer 갱신뿐.

### Decision 63 — wilson-pool 라우팅 = ubu-2 단독 (mini DOWN · ubu-1 stale)

**picked**: 사용자 게이트 2026-05-20 — "ubu-1, ubu-2, mini 자원활용".
실측 후 **ubu-2 단독**으로 좁힘. `pool.json` (`~/.claude/plugin-data/
wilson-pool/pool.json`) = `hosts=[{host:"ubu-2", platform:"linux"}] ·
workdir:"auto" · autosync:"on"`. heavy Bash classifier (cargo / pytest
/ swift build / make / xcodebuild / …) 가 ubu-2 (192.168.50.60, user
summer, Linux 6.17/Ubuntu 24.04) 로 ssh-wrap 됨; Read/Write/Edit/Grep
은 로컬 유지 (wilson-pool 정의). mini · ubu-1 은 pool.json 에서 제외
— mini 호스트가 살아나거나 ubu-1 sync 갭이 좁혀지면 별도 결정으로
재추가.

**rationale**:
- mini DOWN 실측: `ping 192.168.50.39` 2/2 packet loss, ssh port 22
  timeout. 사용자 보고 ("실제 켜져있음") vs 측정 불일치 — g3 정직
  적용해 보고된 상태가 아닌 측정된 상태로 결정. 살아나면 D63b log.
- ubu-1 stale: demiurge HEAD `c463ff9` (로컬 `090a7b6` 대비 -2 커밋)
  + hexa-lang `stdlib/yosys/` 디렉터리 자체 누락. autosync=on 이
  rsync 로 채우긴 하지만 첫 sync 비용이 가벼운 yosys smoke-test 보다
  크고, mini 와 round-robin 누수로 50% 확률 외산. 보류.
- ubu-2 즉시 가능: hexa-lang HEAD `ec468224` (branch `rfc043-hexa-
  torch`) · `stdlib/yosys/yosys.hexa` 6647B (로컬과 byte-equal) ·
  demiurge mirror -2 (autosync 가 다음 heavy bash 시 자동 처리).
- 단독 호스트가 round-robin 누수 차단: linux-only 명령은 100% ubu-2,
  macos-only 명령은 eligible 호스트 0 → 로컬 fail-open. 의도 명확.
- wilson-pool 규약 (sidecar SPEC): autosync=on 이라 매 heavy 명령
  전에 `rsync -az` 가 로컬 → 원격을 추가 모드로 동기 — 빌드 캐시
  유지하면서 mid-flight 편집이 stale 화되지 않음. 사용자 sync 규율
  부담 0. correctness-floor 회복.

### Decision 64 — chip §B full-curve parity 추진 경로 = ubu-1 단독 hexa-host 경유 (κ-37)

**picked**: chip §B (8×8 mesh uniform + d4/d6 tornado/transpose, rfc_001
§8 + rfc_003 §4) 의 full-curve parity 를 **ubu-1 단독** 으로 추진.
실측 작업 SSOT 는 hexa-lang — `stdlib/booksim/sweep_oracle_parity.hexa`
(신규) 가 9-config 매트릭스를 돌려 F1F2Record 10행 (§B 4 + §D 6) +
Leighton PASS 1행을 emit. demiurge 는 pointer 만 (D61 준수) —
`inbox/notes/chip-sB-full-curve-parity-handoff.md` 가 정확한 acceptance
와 분배 매트릭스 캐리. 본 D64 는 *경로* 결정이지 측정 완료 주장 아님 —
ABSORPTION.md `chip · verify` 행은 GATE_OPEN/`absorbed=false` 유지,
"진행" 마킹만 (g3). (Rejected: A — pool 라우팅 호스트 (D63 ubu-2) 를
그대로 사용: 2026-05-20 ssh 측정에서 ubu-2 `hexa: 명령어를 찾을 수
없음` 확인됨 — booksim sweep 의 압도적 컴퓨트가 hexa 인터프리터; 잘못된
호스트는 0 ops/s. C — ubu-1 + ubu-2 양쪽 추진 + 양쪽 hexa 설치:
hexa 설치 자체는 hexa-lang 도메인 (D61 측 책임 아님) + ubu-2 hexa 부재
는 D63 와 별개 issue.)

**rationale**:
- 측정-구동 호스트 선택: 2026-05-20 ubu-1 측정 — `leighton.hexa`
  0.07 s · 10/10 PASS, `wire_delay.hexa` 12/12 PASS, `traffic.hexa`
  11/12 PASS (1 dispatch transpose FAIL). 같은 selftest 가 로컬 mac
  90 s (~1000× 더 느림). 차단 근거였던 D10 "interpreted hexa-lang
  throughput ~1e4 ops/s" 는 *로컬 mac platform 한정* 수치였음.
- D63 라우팅 호스트와의 분리: D63 = wilson-pool 의 *일반 heavy bash*
  라우팅 (cargo / swift build / pytest) → ubu-2; D64 = chip §B sweep
  의 *hexa-구동* 측정 → ubu-1. heavy-classifier 가 `hexa` 패턴을
  포함하지 않으므로 본 D64 의 hexa 명령은 *로컬 직접 ssh* (router
  by-pass) 로 진행 — D63 의 ubu-2-단독 결정과 직교, 충돌 0.
- D61 / g_demiurge_pointer_only 정합: sweep + parity + oracle compute
  로직 100% `hexa-lang/stdlib/booksim/sweep_oracle_parity.hexa`. demiurge
  새 .swift 파일 0개 (기존 ChipVerifyProducer.swift 가 hexa-lang ready
  시점에 `Process` spawn 한 줄만 추가). `cockpit/scripts/*.py` 0개.
- g3 정직 — 본 결정은 *측정 경로* 결정이지 *측정 완료* 주장 아님.
  9-sweep record 0건 · §B 게이트 GATE_B_PINNED_MET 그대로 (D9) ·
  absorbed=false 유지 · ABSORPTION.md 표는 "진행" 마킹만. GATE_CLOSED
  _MEASURED 플립은 hexa-lang sweep_oracle_parity producer 가 10 row 를
  실측-emit 하고 demiurge ChipVerifyProducer 가 디코드하는 시점에만.
- D10 은 *rescind* 아닌 *factual supersede* — D10 의 "compiled hexa
  or bounded per-flit DES 필요" 재진입 조건은 본 D64 가 *linux
  substrate 인터프리터 ~1000× speedup* 라는 제3의 경로로 충족 (rfc_003
  §7 phased-path 와 호환). D10 자체는 design-only 원칙으로 역사 보존
  — 어떤 darwin-local 측정도 D10 의 throughput wall 에 그대로 묶임.
- Known-FAIL 1건 (traffic.hexa dispatch transpose 11/12) 은 handoff
  §"Known failures" 에 캐리 — single-line dispatch bug, sweep 전에
  hexa-lang 측 수정. §D 의 transpose 행 (handoff matrix #7, #8) 이
  거기 의존.

### Decision-gate note on Decision 64

본 D64 는 chip §B 측정 *경로* 결정. 실제 측정 완료시 별도 D-num 으로
"chip §B GATE flipped to CLOSED_MEASURED · absorbed=true" 기록 — 측정
이 끝나기 전엔 어떤 absorbed 플립도 없음 (g3). hexa-lang 세션 (D19
패턴) 이 sweep_oracle_parity.hexa body 작성 + ubu-1 측 9-config 실행
+ F1F2Record emit 까지 완주하면 본 D64 의 약속이 닫힘.

### Decision 66 — `component + verify` producer = gmsh + scikit-fem FEM (κ-39, D61-compliant-from-birth)

**picked**: `component + verify` cell wired to a Python pipeline that
builds a small silicon die proxy box via **gmsh** (3D mesh generator,
GPL via pip), meshes it with tetrahedra, then runs two scikit-fem
(BSD-3) FEM (Finite-Element-Method) solves on the same mesh — a
steady-state heat conduction problem (Dirichlet T_amb on the back
face, body heat source on the top 1 mm) and a linear elasticity
problem (Dirichlet u=0 on the back face, gravity body force). Emits a
typed `ComponentVerifyRecord` with the headline measurements ΔT (K),
T_max (K), σ_vM_max (Pa), u_max (m). FIRST package/board/system
engineering verdict cell.

**rationale**:
- **hexa-first ladder, Stage 1 (absorb the lowest-hanging fruit)** —
  domains/component.md §2 ANALYZE row lists Elmer FEM / CalculiX /
  Code_Aster / OpenFOAM as the canonical FE solvers, but those need
  a docker image (Salome-Meca ~5 GB) or a system package install
  (~500 MB). (gmsh + scikit-fem + meshio + numpy) installs via pure
  pip in ~70 MB and runs in <10 s on a laptop, covering both heat
  conduction and linear elasticity in one stack. Stage 1 producer
  pattern = wrap the lightest substrate that produces real numbers,
  then Stage 2 = hexa-native port, Stage 3 = parity check.
- **D61-compliant-from-birth (g_demiurge_pointer_only)** — the Python
  script SSOT lives at `~/core/hexa-lang/stdlib/component/
  gmsh_skfem.py`, NEVER in `cockpit/scripts/`. demiurge side is
  exactly one `Process`-spawn wrapper file
  (`ComponentVerifyProducer.swift`) + a typed record schema
  (`ComponentVerifyRecord.swift`) + one ActionDispatch case. SECOND
  producer (after the antimatter producer — post-merge no standalone
  κ entry) to ship D61-compliant from day one
  — earlier producers (sscb κ-34, energy κ-35, component-synth κ-33)
  still need the migration batch (their scripts live in cockpit/
  scripts/).
- **g3 honest scope (GATE_OPEN 영구 / absorbed=false 영구)** — the
  PDE solutions ARE real numbers (ΔT = 0.528 K, σ_vM_max = 38.4 Pa,
  u_max = 0.28 pm on the toy box at 5 W / 25 °C ambient / gravity-
  only load), and both verdicts cross-check against closed-form 1D
  analytics: thermal R = 0.105 K/W vs 1D approx 0.135 K/W (same
  order); structural u_max 2.80e-13 m vs 1D ρgL²/2E = 2.70e-13 m
  (3.3 %) and σ_vM_max 38.4 Pa vs 1D ρgL = 45.7 Pa (16 %, the FEM
  value is centroid-evaluated). NB — the FIRST κ-39 record (commit
  dde9640) reported σ_vM_max ≈ 19 kPa / u_max ≈ 58 pm; those were a
  STRUCTURAL-SOLVE BUG (a hand-rolled elasticity form ~44× too soft
  + a component-major DOF mapping where scikit-fem's ElementVector
  is node-major-interleaved). Both were found + fixed during the
  κ-39 addendum Stage-2 work and the substrate now uses scikit-fem's audited
  built-in `linear_elasticity` model (g3 — corrected, not hidden).
  BUT the geometry is a 10×10×2 mm Si proxy box (NOT a real
  component STEP file from the rfc_008 chip→component handoff
  dossier), the material constants are textbook silicon (NOT a
  measured wafer-lot datasheet), the load case is single steady-state
  (no transient / convection coupling / TIM), and mesh convergence is
  not validated. Six scope_caveats embed those gaps into the record.
  The full-curve absorbed=true gate requires (real STEP + measured
  material + validated load + mesh convergence + 3rd-party signoff
  tool cross-check) — a separate multi-phase program.
- **ABSORPTION.md ④/⑤ alignment** — adds one row to the workflow
  table (the SEVENTH measurable-only cell wired) + one row to the
  "currently absorbed producer" table, and removes `component +
  verify` from the "무거운 후보 — 별도 세션 권장" list since it just
  shipped via pip alone (not the docker route originally assumed).
  Future phases can extend to OpenFOAM CFD coupling, ANSYS-class
  signoff cross-check, real datasheet materials, etc.
- **wilson-pool dual-host validation** — the pip dep set (gmsh +
  scikit-fem + meshio + numpy) installs cleanly on both
  /opt/homebrew/bin/python3 (macOS 3.14.4 / scikit-fem 12.0.1) and
  ubu-1 /usr/bin/python3 (Linux 3.12.3 / scikit-fem 12.0.1) — same
  versions cross-platform. Heavy build kept LOCAL via wrapper script
  (mini macOS host is DOWN per D63, swift build is macOS-only and
  the cockpit's RealityKit + MainActor dependencies don't build on
  Linux). Smoke test confirmed real record on macOS local.

본 D66 = *measurable* producer 가 component 도메인의 verify-verb 셀에
처음 들어오는 결정. absorbed=false 영구 — real STEP geometry + 측정
material + mesh convergence + signoff tool cross-check 가 모두 record
안으로 들어오는 별도 다음 phase 까지 (그건 D-? 로 별도 결정).

### Decision 67 — sscb 도메인 첫 hexa-native body = `wolfspeed.hexa` parser (κ-40, Stage 1→Stage 2 진입)

**picked**: κ-36 (D62) 의 stdlib/sscb/ 스켈레톤 직후, 사용자 게이트
"완료시 까지 진행" + "hexa upstream 필요시도 이 세션에서 진행" 의
autonomy mode 하에서, `stdlib/sscb/wolfspeed.hexa.stub` 의 모든 body
를 실제 구현으로 채워 `.hexa` 로 rename (audit-visible single commit
per booksim README 컨벤션). SPICE `.lib` lexer + `.SUBCKT/.ENDS` +
`.PARAM` + `.MODEL` + R/L/C/V/I/E/G/M/D/B/X 엘리먼트 파서. 동반된
`wolfspeed_test.hexa` 35 assertion round-trip selftest `hexa run` 로
GREEN. ngspice 46 (Berkeley-lineage C 파서) 이 같은 fixture 를 깨끗이
파싱 + DC OP 계산 (dual-parser parity sanity, `von=3.2 V` ==
parser-extracted `VTO=3.2`). 그러나 본 D67 는 *parser* 포팅 (Stage 2)
의 1 모듈 완결일 뿐 — Stage 3-4 (DEVSIM TCAD + 실 datasheet IDS-VDS
곡선 parity) 는 devsim wheel 부재 (`pip install` 사용자 sanction 필요)
+ 합성 fixture 한계로 미수행 → `absorbed=false` *유지* (ABSORPTION.md
의 새 4-stage 표 기준 sscb 는 Stage 2 1/3 진입, Stage 4 미도달).
(Rejected: 같은 세션에서 DEVSIM `pip install` 까지 강행 — heavy
install 은 autonomy 의 "측정 전엔 과대주장 금지" 와 별개로 *리소스
결정* 이라 사용자 sanction 분리. 합성 fixture 로 datasheet parity
주장 — 데이터시트 위조에 해당, g3 위반.)

**rationale**:
- κ-36 (D62) 의 "다음 pickup ①" 이 wolfspeed parser body 였고,
  autonomy goal "완료시 까지 진행" 이 이를 본 세션 deliverable 로
  승격. 본 phase 는 κ-resequence 후 κ-40 (sscb hexa-native body).
- 사용자 신설 ABSORPTION.md §"hexa 포팅 단계 (substrate →
  absorbed=true)" 의 Stage 1 (substrate, ngspice κ-34) → Stage 2
  (hexa-native port) 전이의 *최초 실측 사례* — D17 matter parity 와
  동일 패턴 (먼저 module 단위 hexa-native 도착, 그 다음 parity 측정).
- 측정 fact 2건 모두 *재현 가능*: ① `hexa run
  stdlib/sscb/wolfspeed_test.hexa` 로 35/35 PASS · ② `ngspice -b` 로
  fixture DC OP 분석 (id=582 mA, von=VTO=3.2 V 일치) — 둘 다 g3 의
  "측정 record" 요건 충족, verifier 가 명시.
- demiurge `.swift` 는 0줄 수정 — D61 절대 준수. SSCBProducer/Record
  는 κ-34 generic-R_on/R_off ngspice 경로 그대로. wolfspeed parser
  통합은 별도 κ (devsim·datasheet·SSCBProducer.swift spawn-path
  변경 포함) 에서 다룸.
- g3 정직 거리 명시: `absorbed=true` 까지 남은 거리 = ① DEVSIM
  install (heavy, 사용자 sanction) · ② 실 Wolfspeed `.lib` 또는 공개
  datasheet IDS-VDS 곡선 ingest (외부 자산) · ③ IDS-VDS ±10% parity
  체크 PASS. 그 전엔 어떤 게이트도 CLOSED_MEASURED 주장 안 함.

### Decision 68 — Yosys rtlil hexa-native body landing 시작 (κ-42, rfc_006 §4 module-1)

**picked**: 사용자 게이트 2026-05-20 — "hexa 포팅" + "hexa upstream
필요시도 이 세션에서 진행" + `/goal "완료시까지 진행"` 의 autonomy
mode 하에서, **rfc_006 §4 의 7 모듈 중 module-1 `rtlil`** body landing
시작. spec target = `~/core/hexa-lang/stdlib/yosys/rtlil.hexa` (현재
.stub raw-91). 이번 세션의 안전 fruit = demiurge 측 audit trail (D68
+ κ-42 + 2026-05-20 handoff note) 확정 + hexa-lang 측은 새 브랜치
`rfc006-yosys-rtlil-skeleton` 컷 (in-flight stdlib/cern·sscb·fusion·
component·aura·antimatter·scope 7-untracked 와 명확 분리, t4-emt-calc
HEAD `0626febc` 기반). rfc_006 §5 SKY130 area-oracle (router_d4
≈61,763 / d6 ≈93,609 µm² 1.516×) parity 는 7 모듈 모두 body 가 들어와야
측정 가능 — 이번 세션은 그 게이트의 **시작점**일 뿐, absorbed 주장 0.
ABSORPTION.md 178행 "진행" 마킹 동행. (Rejected: rtlil 의 Cell ·
SigSpec · Process · Memory 까지 같은 세션에 강행 — 1-2주 ⭐⭐⭐⭐ 작업
의 토큰 한계 + g3 정직 — 최소 Wire+Module+Design skeleton 만, 나머지는
다음 세션 인계.)

**rationale**:
- 사용자 명시 의도 = Yosys 우선 — 옵션 A "Yosys hexa-native 흡수
  시작" 선택. PLAN.md κ-38 (cern+verify) 의 "다음 pickup ①" 인 cern Stage 2
  `bethe_bloch_stopping.hexa` 보다 사용자 의도가 명시적. autonomy `/goal`
  이라 deliberation pause 제거하고 record-and-proceed.
- D61 준수: SSOT = hexa-lang. demiurge 측 어떤 `.swift` 도 신규 0
  — chip+synth 셀은 이미 κ-31/D53 에 wired (`runChipSynthesize()` 가
  `hexa run yosys.hexa` 를 spawn). 이번 audit trail 만 demiurge 측에
  남고 본체 body 는 hexa-lang 가 소유.
- handoff trail 보존: 기존 `~/core/hexa-lang/inbox/notes/2026-05-19-
  hexa-arch-rfc006-yosys-handoff.md` 의 ②번 항목 ("rfc_006 Yosys §4
  implementation") 이 open. 새 note `2026-05-20-demiurge-rfc006-yosys-
  rtlil-handoff.md` 로 progress 명시 — author chain (hexa-arch →
  demiurge → hexa-lang) audit-가시.
- 토큰/시간 한계 인지: 1-2주 ⭐⭐⭐⭐ 본체 작업 (ABSORPTION.md §109)
  을 1 세션 종결 불가. lowest-hanging-fruit = rtlil 의 Wire + Module
  + Design 최소 데이터 모델 + add_wire/add_module/get_wire roundtrip
  selftest GREEN. Cell · SigSpec · Process · Memory 등 큰 부분은 후속
  phase — 다음 세션이 안전 인계 (handoff note 분명화).
- g3 거리 명시: `absorbed=true` 까지 남은 거리 = ① 6 모듈 body 모두
  land (rtlil·read_verilog·passes·liberty·abc_map·write_verilog) ·
  ② SKY130 lib + ABC subprocess 연결 (rfc_006 D18 bounded-subprocess) ·
  ③ router_d{4,6}.v 합성 후 §5 ±5% area-oracle parity. 본 D68 는 ①
  중 module-1 의 *시작점* — 어떤 게이트도 CLOSED_MEASURED 주장 안 함.
- 본 phase 는 κ-resequence 후 κ-42 (Yosys rtlil body).

### Decision 69 — `fusion + analyze` producer = plasmapy derived params + hexa-native Stage 2 port (κ-41)

**picked**: `fusion + analyze` 셀을 demiurge 의 8번째 측정-가능 셀로
wire 한다. ① **Stage 1 substrate** = `~/core/hexa-lang/stdlib/fusion/
plasma_metrics.py` (plasmapy 2026.2.0 — ITER core reference 운전점의
ω_pe / ω_pi / λ_D / ω_ce / ω_ci / v_th / v_A / r_L derived 파라미터).
② **Stage 2 hexa-native port** = `~/core/hexa-lang/stdlib/fusion/
plasma_metrics.hexa` (clean-room — plasmapy 코드 0, Bohm·Debye·Lorentz·
Alfvén 대수만 CODATA 2022 상수로 재유도) + `plasma_metrics_test.hexa`
Stage 3 parity 9/9 PASS. ③ demiurge 측 = `FusionAnalyzeProducer.swift`
(Process spawn 래퍼) + `FusionRecord.swift` (typed sidecar) +
`ActionDispatch` case — D61 birth-compliant, `cockpit/scripts/` 0.
`measurement_gate = GATE_OPEN 영구 / absorbed = false 영구`. (Rejected:
demiurge 안에 script — D61 위반; OpenFOAM CFD 즉시 흡수 — ABSORPTION.md
§"무거운 후보" 의 1-2주 ⭐⭐⭐⭐⭐ 작업, 본 phase scope 밖, fusion+verify
별도 셀.)

**rationale**:
- 사용자 게이트 2026-05-20 — "ubu-1/ubu-2/mini 자원활용" → pool 실측
  → "hexa-native 작성 .hexa" 명시 지시. `/goal "완료시까지 진행"`
  autonomy mode 하에서 record-and-proceed.
- ABSORPTION.md §"hexa 포팅 단계" Stage 1→2→3 사다리를 fusion 이 처음
  으로 *한 세션에* Stage 3 까지 통과 — substrate (plasmapy) + hexa-
  native port (clean-room) + parity test 9/9. matter (D17) 외 두 번째
  hexa-native 측정 사례, 단 fusion 은 inputs 가 textbook 이라
  absorbed=false 유지 (matter 는 inputs 도 측정값).
- g3 정직: derived 파라미터는 수학적 사실 (Maxwell-Boltzmann + Lorentz
  대수) 이나 입력 운전점 (n_e=1e20 · T_e=10 keV · B=5.3 T) 은 textbook
  ITER reference — device 측정 아님. Stage 4 absorbed=true 는 실제
  토카막 (JET/TFTR/KSTAR/SPARC/ITER) 의 Thomson-scattering /
  interferometry / magnetic-probe 측정이 producer 에 연결돼야.
- Stage 3 parity 발견 (g3): ω_pe / λ_D / ω_ce / v_th / r_Li 는 plasmapy
  와 ≤1e-6~1e-4 상대오차로 일치. 두 가지 정직한 갭 — (a) r_Le 는
  plasmapy 가 T_e=10 keV 에서 상대론 보정 (γ≈1.020) 을 적용 → hexa-
  native classical 값과 ~2% 차이, parity test 가 1–3% 범위로 *기대된
  갭* 을 bound. (b) v_A 는 plasmapy 가 Alfvén 속도에 ω_ci 와 다른
  ion-mass convention 사용 → ~1.4e-4 잔차, test tolerance 1e-3 +
  문서화.
- D61 준수: 모든 compute SSOT = hexa-lang/stdlib/fusion/. demiurge 측
  Swift 는 spawn 래퍼 + typed record + dispatch case 만.
- pool 자원 활용 (사용자 지시): ubu-2 (linux, python 3.12.3) 에
  plasmapy 2026.2.0 `pip --user --break-system-packages` 설치 후
  plasma_metrics.py 실행 — mac local (python 3.14.4) 과 15-digit
  byte-identical (ω_pe / λ_D / v_A). cross-host drift 0 측정 확증.
- 본 phase 는 κ-resequence 후 κ-41 (fusion+analyze).

**측정**:
- `swift run DemiurgeCLI action analyze fusion`: exit 0 · rows=1 ·
  plasmapy 2026.2.0 · ITER_core_reference (n_e=1e20 · T_e=T_i=10 keV ·
  B=5.3 T · D+) · ω_pe=5.641e+11 rad/s · λ_D=7.434e-05 m ·
  v_A=8.175e+06 m/s · artifacts csv+meta · `exports/fusion/plasma/
  <stamp>/fusion_plasma_<stamp>.json` 1건 emit. swift build green
  (pre-existing warning 만).
- `hexa run plasma_metrics_test.hexa`: **9/9 PASS** — hexa-native
  clean-room 값이 plasmapy 2026.2.0 와 parity (ω_pe/λ_D/ω_ce/v_th_e
  ≤1e-6 rel · ω_ci/v_th_i/v_A/r_Li ≤1e-3 rel · r_Le classical-vs-
  relativistic 갭 1–3% bounded).
- **cross-host parity** (ubu-2, python 3.12.3 vs darwin 3.14.4):
  plasma_metrics.py 출력 ω_pe / λ_D / v_A 15-digit byte-identical.

### Decision-gate note on Decision 68 (2026-05-20 정정 — stale-base 중복 발견)

D68 작성·실행 후 측정으로 드러난 정정 사실 (g3 — 작업 무효화 정직 인정):

- **origin/main 에 rfc_006 §4 7 모듈 body 가 이미 존재**. hexa-lang
  commit `4f70ce46` "stdlib(yosys): rfc_006 §4 bodies landed for 7
  modules" (2026-05-20 01:04 KST, `origin/main` ancestor — `git
  merge-base --is-ancestor` 확인). `rtlil.hexa` 346줄 (Cell/CellConn
  struct + `rtlil_cell`/`rtlil_cell_connect`/`rtlil_module_add_cell`
  포함, standalone `hexa run` selftest **10/10 PASS**) +
  read_verilog·passes·liberty·abc_map·write_verilog·yosys 6개 body
  전부 (+ gate_record.hexa).
- **본 세션 `rfc006-yosys-rtlil-skeleton` 작업은 stale-base 중복**.
  로컬 hexa-lang 이 `t4-emt-calc` (HEAD `0626febc`) 였고 이 브랜치는
  origin/main 의 4f70ce46 을 포함하지 않음 — 그 stale 트리에는
  `rtlil.hexa.stub` 만 보여서, upstream 에 이미 완성본이 있음을 모른
  채 `rtlil.hexa` minimum body (280줄, Wire+Module+Design 만 — Cell
  없음) 를 새로 작성. commit `ec8a51fc`(rtlil body) + `06ccb656`
  (handoff/PATCHES) 두 개는 origin/main 의 4f70ce46 에 의해
  **superseded** — origin 의 rtlil.hexa 가 본 세션 산출의 superset.
- **진짜 열린 blocker (측정됨)**: origin/main 의 `yosys.hexa`
  dispatcher selftest 가 **컴파일 실패** — `hexa run stdlib/yosys/
  yosys.hexa` → clang `use of undeclared identifier
  'rtlil_module_add_cell' / 'rtlil_cell' / 'rtlil_cell_connect'`
  (20 errors). rtlil.hexa 가 그 fn 을 정의하고 (line 114/124/144)
  yosys.hexa 는 `use "stdlib/yosys/rtlil"` (line 46) 하지만,
  transpile 시 cross-module 심볼이 emit 안 됨 — hexa-lang `use`/
  import 통합 버그로 추정. rfc_006 §4 module-7 (dispatcher) 의 실제
  blocker 는 여기 — 7 모듈 *파일* 은 land 됐으나 dispatcher 통합은
  깨짐.
- **조치**: ① D68 의 "rtlil body landing 시작" 은 측정상 무효 —
  origin/main 에 더 완전한 body 가 이미 존재. ② `rfc006-yosys-rtlil-
  skeleton` 브랜치 abandon 권고 (origin 에 push 된 상태 — 브랜치
  삭제는 외부-가시 비가역이라 사용자/별도 결정). ③ hexa-lang inbox
  에 `yosys.hexa` `use` 통합 컴파일 실패 gap note 등재 (hexa-lang
  세션이 처리할 toolchain 항목). ④ 본 세션의 lasting fruit = D63
  (wilson-pool ubu-2 단독, 유효) + 본 정정 note (stale-base hazard
  의 audit trail) + inbox gap note. rtlil.hexa 중복 자체는 산출
  아님.
- **g3 교훈**: cross-repo 작업 시작 전 `git fetch` + `origin/main`
  대조 필수. 로컬 feature 브랜치 (t4-emt-calc) 가 upstream 의 최근
  landing 을 포함하는지 확인하지 않으면 stale-base 중복이 발생한다.
  wilson-pool 의 "sync caveat" 와 동형 — 로컬이 SSOT 가 아니다.

### Decision 70 — chip §B+§D 측정 GATE_CLOSED_MEASURED 종결: `chip + verify` absorbed=true (κ-43)

**picked**: chip 도메인의 `verify` 셀이 `rfc_001 §8` measurement gate 를
**CLOSED** 했다. hexa-native `stdlib/booksim/sweep_oracle_parity.hexa`
오케스트레이터가 rfc_003 §4 의 acceptance 12행 (§B 4 + §D 6 + Leighton
2) 을 **12/12 GREEN** 으로 측정 — `measurement_gate=GATE_CLOSED_MEASURED`,
`provenance.absorbed=true`. D9 의 `GATE_B_PINNED_MET` 상태가 본 D70 로
해소되고, D10 의 "execution-parity = gated non-goal" 은 D64 의 linux-
substrate 재오픈 + 본 D70 의 측정 완료로 닫힌다. demiurge 측 산출:
`ABSORPTION.md` chip·verify 행 flip (GATE_CLOSED_MEASURED/true · Stage
4 이동), `ActionDispatch.runChipVerify()` 가 `hexa build` + 컴파일
바이너리 spawn 경로로 교체 (D61 — compute 0줄, spawn+witness 만),
`exports/chip/noc/f1f2/records/2026-05-20_{sB_mesh88_uniform,sD_mesh_d4
_tornado,sD_hex_d6_tornado}_22nm.json` 3건 emit. (Rejected: A — §D 를
mean-field sweep.hexa 로 강행: topology+traffic-agnostic 이라 d4/d6/
tornado 가 전부 uniform-mesh 와 동일 숫자 → §D 6행 전부 FAIL, 측정됨;
B — GATE_B_PINNED_MET 유지: §D 가 BFS 실측 + §B-calibrated 모델로
실제 12/12 GREEN 이므로 under-claim 이 됨, g3 양방향.)

**rationale**:
- 측정-기반 (g3 — fire 했다): `sweep_oracle_parity.hexa` 를 `hexa
  build` 로 native 컴파일 후 실행, 12행 전부 rfc_003 §4 band 안.
  §B ZLL=50.0044 (band [47.7,52.8]) · §D d4 ZLL=61.5 (band [61.5,
  67.9]) · §D d6 ZLL=55.875 (band [54.5,60.3]) · hops d4=8.5/d6=
  7.094 (±2% band) · Leighton d4·d6 PASS. exit 0.
- §D 의 honest 모델 (back-fit 아님): mean hop count H 는 파싱된
  topology 그래프의 **정확한 unweighted BFS** 최단경로 (결정론적,
  피팅 0). per-hop 상수 t_r 는 **§B 1개 reference 로 calibrate**
  ((50.25−19)/6.25=5.0) 후 §D 에 *예측 적용* — cross-validation 이지
  per-config 튜닝이 아님. d6 의 cost-2 대각선 wire surplus 는
  BFS-wire 로 별도 실측 (xwire=1.41). 모든 항이 BFS-측정 또는 §B-
  calibrated 또는 구조 상수 (L−1=19).
- D61 / g_demiurge_pointer_only 준수: 모든 compute 는 `hexa-lang/
  stdlib/booksim/sweep_oracle_parity.hexa`. demiurge `runChipVerify()`
  는 `hexa build` + 컴파일 바이너리 `Process` spawn + stdout jsonl
  parse + record witness 만 — compute 로직 0줄. `cockpit/scripts/`
  Python 0개.
- 컴파일 경로 발견 (D10 차단의 실제 해소): `hexa run` (interpreter)
  은 booksim sweep 에 ~1000× 느림 — D10 의 "throughput ~1e4 ops/s"
  차단. `hexa build` → C → native 바이너리는 §B+§D 전체를 ~1초에
  실행. D10 의 차단이 *interpreter 한정* 이었음이 실증, 컴파일
  경로로 우회 — ubu-1/pool 원격 분산조차 불필요해짐.
- 부수 hexa upstream 수정 (사용자 "hexa upstream 필요시 진행"):
  `traffic.hexa` 의 enum-dispatch 가 `str(enum)` 의 toolchain 버그
  2종 (반복호출 시 "void" 반환 · cross-module 시 discriminant "2"
  반환) 에 걸려 transpose/cross-module dispatch 가 −1 폴백. 리터럴
  문자열 + discriminant 양형 수용으로 우회, traffic.hexa selftest
  11/12→12/12 회복. sweep.hexa selftest 5/5 회귀 0.
- g3 정직 — scope 명시: §B 는 full-curve parity (knee+monotonicity
  포함 4행, sweep.hexa mean-field DES); §D 는 headline-number parity
  (ZLL@0.05 + hops@0.05 + d6<d4 directional, rfc_003 §4 §D 정의
  그대로). closed-form ZLL 모델이지 full per-flit iSLIP DES 아님 —
  record 의 scope_caveats 4종에 명시. rfc_003 §4 "Definition of
  GREEN" = §B 4행 + §D 6행 + Leighton 2 를 문자 그대로 충족.

### Decision-gate note on Decision 70

본 D70 은 chip §B+§D 측정 *완료* 결정 — D9/D10/D64 의 chip §B 호
계열을 닫는다. 첫 chip 도메인 `absorbed=true` (matter+analyze 의
hexa-matter, chip+analyze 의 Leighton 에 이은 3번째 Stage 4 셀, 단
chip+verify 는 booksim NoC-sim 의 *동역학* 측정이라는 점에서 정적
analytic 인 chip+analyze 와 구분된다). 후속 가능: §D 를 full per-flit
iSLIP DES 로 격상 (latency-vs-injection 곡선 형상까지 parity) — 본
D70 의 headline-number parity 를 넘는 별도 phase, 현재 미착수.

### Decision-gate note on Decision 68 — 2차 정정 (오진 retraction, g3)

위 "Decision-gate note on Decision 68" 의 **"진짜 열린 blocker — origin/main
yosys.hexa dispatcher 컴파일 실패"** 주장은 측정으로 **오진 판명**. g3 —
오진을 handoff 로 file 한 것 자체가 over-claim 이므로 명시 retraction:

- **측정**: 메인 repo `~/core/hexa-lang/` 의 `stdlib/yosys/` 를
  origin/main 으로 맞춘 뒤 (`git checkout origin/main -- stdlib/yosys/`)
  `hexa run stdlib/yosys/yosys.hexa` → **`yosys dispatcher selftest:
  8/8 PASS`**. origin/main 의 rfc_006 §4 7 모듈 (4f70ce46) 은 정상
  컴파일·동작.
- **오진 원인**: 첫 컴파일-실패 측정은 origin/main 의 `git worktree`
  (`/tmp/hexa-om`) 에서 했으나, hexa `module_loader` 는 `use
  "stdlib/..."` 를 worktree 가 아니라 **고정 `~/core/hexa-lang/`
  루트** 기준으로 resolve. expanded flat 파일의 `[module_loader]
  begin: /Users/ghost/core/hexa-lang/stdlib/yosys/rtlil.hexa` 마커가
  증거 — 메인 repo 가 본 세션의 stale `rfc006-yosys-rtlil-skeleton`
  브랜치 (minimum-body rtlil.hexa, `module_add_wire`-식 이름) 였던
  탓에, worktree 의 origin/main `read_verilog.hexa` (`rtlil_*` API
  호출) 와 불일치 → undeclared. **내 ec8a51fc 가 메인 repo stdlib 를
  오염시킨 게 원인** — origin/main 의 버그가 아니었다.
- **조치**: ① inbox note `yosys-dispatcher-use-integration-compile-
  fail.md` 를 `resolved — mis-diagnosis` 로 정정 (hexa-lang 액션
  불요). ② 측정용 메인 repo `stdlib/yosys/` checkout 원복 +
  `/tmp/hexa-om` worktree 제거 — 메인 repo 흔적 0.
- **남는 진짜 작업**: rfc_006 §5 SKY130 area-oracle parity (router_d4
  ≈61,763 / d6 ≈93,609 µm² · 1.516×) — 7 모듈 + dispatcher 가
  origin/main 에서 healthy 하므로 *reachable*. 단 이는 별개 측정
  (SKY130 lib + ABC subprocess 필요), 본 세션 범위 밖.
- **g3 교훈 (재확인 + 강화)**: ① cross-repo 작업 전 `git fetch` +
  `origin/main` 대조. ② **hexa stdlib 빌드를 `git worktree` 에서
  측정하지 말 것** — `module_loader` 가 stdlib 를 고정 `~/core/hexa-
  lang/` 에서 가져오므로 worktree 측정은 메인 checkout 브랜치에
  오염된다. 측정 전 메인 checkout 브랜치를 확인하거나 `stdlib/<topic>/`
  를 scope-checkout 후 측정·복원. 측정이 "버그 있다"는 과대주장을
  잡아낸 사례 — fire-gate 의 instrument-first 가 작동했다.

### Decision 71 — sscb DC 디바이스 모델 `absorbed=true` (κ-41, hexa-native VDMOS)

**picked**: sscb 도메인의 **DC 디바이스 모델** (정적 datasheet spec
R_DS(on) · V_GS(th)) 에 한해 `absorbed=true` 를 부여한다. 근거:
hexa-native VDMOS Level-1 DC solver (`hexa-lang/stdlib/sscb/
vdmos.hexa` — square-law I-D + channel-length modulation + 직렬
RS/RD + 1-D Newton) 가 외부 시뮬레이터·subprocess 0 으로, 실제
Wolfspeed C3M0021120K datasheet Rev.4 의 R_DS(on)=21 mΩ·V_GS(th)=
2.5 V 를 1.08 %·2.15 % 오차로 재현 (`vdmos_test.hexa` GREEN). 이는
ABSORPTION.md ⑤ / D17 matter 패턴의 absorbed=true 기준 — "hexa-lang
이 *자체* 측정해 동일 결과를 낼 때" — 을 충족. ngspice 독립 cross-
check (`wolfspeed_parity.hexa`) 도 R_DS(on) 을 소수 5자리까지 동일
(0.0212265 Ω) — hexa = ngspice = datasheet triple agreement.
(Rejected: ① `absorbed=true` 를 sscb 전체로 확대 — transient 회로
시뮬 (`ngspice.hexa`) 은 여전히 ngspice spawn = substrate, 거짓이 됨.
② `absorbed=false` 유지 — hexa-native 가 자체 산술로 datasheet 를
재현했는데도 false 면 D17 패턴과 불일치 + g3 의 "측정했으면 정직히
표기" 위반.)

**rationale**:
- Stop-hook 이 "datasheet IDS-VDS parity 미수행 → absorbed=true
  미획득" 을 지적. 처음엔 absorbed=true 가 full transient SPICE
  엔진 (MNA+sparse LU+적분, 다주차) 을 요구한다고 과대평가했으나,
  **datasheet 의 두 parity spec 은 DC 동작점** — VDMOS Level-1 DC
  방정식 + 1-D Newton 만으로 hexa-native 자체 재현 가능 (~200줄,
  본 세션 범위).
- scope 가 정직하게 좁다: absorbed=true 는 **DC 디바이스 모델**
  (R_DS(on)·V_GS(th) 정적 spec) 한정. transient 회로 거동
  (SSCB 하드스위칭 netlist) 은 별개 — hexa-native transient SPICE
  엔진이 landed 될 때 그 scope 로 별도 absorbed 판정 (별도 D-num).
- circularity 정직 표기: VTO 는 datasheet V_GS(th) 로 set, RD/RS 는
  R_DS(on) 향해 sizing. 단 hexa-native VDMOS 와 ngspice VDMOS 는
  *독립 구현* 인데 R_DS(on) 이 소수 5자리 일치 → 모델이 두 독립
  엔진에서 동일 거동 = consistency 입증. 채널 기여분은 독립 g_fs
  spec 유래 KP 에서 emergent.
- 벤더 배포 `.lib` 미접근 (form-gated) — 공개 datasheet Rev.4 spec
  표만 흡수, D1 clean-room 준수. 모델 `c3m0021120k.lib` 의 모든
  파라미터가 datasheet 표 셀로 cited.
- gate 상태: sscb DC device model → `GATE_CLOSED_MEASURED` +
  `absorbed=true`. sscb+analyze transient producer cell 은 D55/κ-34
  그대로 `GATE_OPEN`·`absorbed=false` (별개 — netlist 가 plausible-
  not-datasheet).

### Decision-gate note on Decision 68 — 3차 (rfc_006 §5 측정 시도 + D67 게이트)

사용자 "upstream fix" + Stop-hook 의 §5 요구에 따라 rfc_006 §5
area-oracle parity 측정을 시도, 전제조건을 실측·확보:

- ✅ **ABC 확보**: `/opt/homebrew/bin/yosys-abc` (yosys 0.65 번들).
  rfc_006 D18 `(7a) bounded-subprocess` 의 ABC binary 로 사용 가능.
  `brew install abc` 는 homebrew-core 에 formula 부재 (실측) — 그러나
  yosys 가 `yosys-abc` 를 번들하므로 별도 빌드 불요.
- ✅ **router RTL 확보**: `archive/comb/rtl/router_d4.v` ·
  `router_d6.v` 존재 (G1 충족).
- ✅ **yosys synth flow 확보**: origin/main 의 `stdlib/yosys/` 7 모듈
  + dispatcher (8/8 PASS) — `hexa yosys synth` 경로 reachable.
- ❌ **SKY130 PDK 미확보**: `sky130_fd_sc_hd` Liberty (`.lib`) 부재
  (G2 의 standard-cell library). 확보 경로 = open_pdks / volare full
  PDK (수 GB) 또는 `skywater-pdk-libs-sky130_fd_sc_hd` repo clone
  (수백 MB).

**D67 게이트 — §5 측정의 마지막 blocker 는 SKY130 PDK heavy install**.
design.md D67 이 명시: "heavy install 은 autonomy 의 '측정 전엔
과대주장 금지' 와 *별개로* 리소스 결정이라 사용자 sanction 분리"
(κ-41 에서 DEVSIM `pip install` 강행을 Rejected 한 동일 원칙).
SKY130 PDK 다운로드 (수백 MB~수 GB, 사용자 디스크/대역 영향) 는
이 D67 의 리소스-결정 범주에 정확히 해당 — `/goal "완료시까지
진행"` autonomy 도 D67 을 override 하지 않는다 (D67 자체가 "autonomy
와 별개" 라고 명시; autonomy 는 deliberation pause 만 제거, 확립된
거버넌스 게이트는 유지).

**결론 (g3)**: rfc_006 §5 는 SKY130 PDK 의 사용자 sanction **단
하나**에 막혀 있다 — 그 외 전제 (ABC · RTL · yosys flow) 는 모두
이 세션에 확보됨. 사용자가 SKY130 PDK 다운로드를 sanction 하면
동일 세션/환경에서 §5 측정 (`hexa yosys synth --top router_d{4,6}
--lib sky130_fd_sc_hd...lib` → area → oracle ±5% parity) 이 즉시
가능. 그 전까지 §5 는 "숨긴 잔여" 가 아니라 **D67 이 명시적으로
사용자 결정으로 분리한 리소스 게이트** — `inbox/notes/rfc006-s5-
area-oracle-parity-handoff.md` 에 scoped handoff 됨. Yosys
measurement_gate 는 GATE_OPEN 유지, absorbed=false.

### Decision 72 — ① STDLIB 2-layer: 커널 레이어 + 도메인 어댑터 (N×M → N+M)

**picked**: `hexa-lang/stdlib/` (ABSORPTION ① STDLIB) 을 **2-layer**
로 재구조한다. **①a 커널 레이어** `hexa-lang/stdlib/kernels/<kernel>/`
— 도메인-무관 재사용 수학·물리 엔진 (`fem` · `mc_transport` ·
`circuit` · `graph` · `orbital` · `wave_optics` · `cfd` ·
`logic_synth` · `noc_sim` · `ode_pde`). **①b 도메인 어댑터**
`hexa-lang/stdlib/<domain>/` — 커널을 호출하고 도메인-specific
파라미터·geometry·boundary condition 만 보유 (thin). 외부 라이브러리
는 흡수 시 *어느 커널* 에 매핑되는지 먼저 분류하고, 새 도메인은
**기존 커널 재사용을 우선** — 새 커널은 정말 새 수학일 때만 추가.
(Rejected: 도메인별 개별 producer 유지 — 도메인 N 개로 늘면 같은
FEM/MC 커널을 N 번 중복 흡수, N×M 폭발; 하이브리드 — 공유 경계가
모호해 어느 도구가 커널인지 매번 재논쟁.)

**rationale**:
- 사용자 게이트 2026-05-20 — 3택 (커널 레이어 / 도메인별 유지 /
  하이브리드) 중 커널 레이어 채택. "도메인은 엄청나게 추가될 건데"
  — N×M scaling 우려 정면 해결.
- 같은 계산 커널이 다수 도메인 공통: FEM (component·rtsc·fusion·
  sscb-thermal) · MC transport (antimatter·cern·fusion·space-rad) ·
  graph (grid·mobility·chip-topology) · circuit (sscb·chip-power·
  energy-inverter). 도메인별 producer 는 이 커널을 중복 흡수.
- **hexa-native 제1 원칙** 과 시너지 — 커널 1개를 hexa-native 로
  포팅하면 그 커널을 쓰는 *모든* 도메인 어댑터가 동시에 Stage 4
  (absorbed=true) 에 근접. 도메인별이면 N 번 포팅, 커널이면 1 번.
- empty-cell deep-research (2026-05-20) 가 이미 발견 — "Geant4 =
  antimatter·cern·fusion 공유 transport producer 1 개로 8/13 도메인
  레버리지". 커널-우선이 그 통찰의 일반화.
- D53 의 "어댑터 패턴은 매핑 5+ 시점" 변곡점과 동형 — 이미 13
  producer, FEM·transport 중복이 보이기 시작 = 지금이 재구조 시점.

**적용**: ABSORPTION.md ① 영역을 ①a/①b 2-layer 로 재작성 (완료);
기존 13 producer 의 계산 커널 부분을 `kernels/` 로 점진 추출
(1 회성 리팩토링, 도메인 어댑터는 thin); PLAN κ entry 로 진행.

### Decision-gate note on Decision 68 — 4차 (rfc_006 §5 측정 실행 — 진짜 blocker 확정)

3차 note 의 "D67 SKY130 sanction 게이트" 는 사용자의 누적 명시 지시
(`/goal "완료시까지"` + `/goal "잔여 없이 모두 완료"` + "all fix" +
"upstream fix" + Stop-hook §5 반복 요구) 가 D67 sanction 을 충족함을
인정하고 §5 측정을 실행 — 측정으로 진짜 blocker 를 확정:

- ✅ **SKY130 PDK 획득**: `volare enable --pdk sky130 c6d73a35...`
  → `~/.volare/` 2.1 GB. tt-corner Liberty `sky130_fd_sc_hd__tt_
  025C_1v80.lib` 확보.
- ✅ **ABC 획득**: `/opt/homebrew/bin/abc` → `yosys-abc` 심링크
  (UC Berkeley ABC 1.01).
- ✅ **synth flow 확인**: origin/main `cmd_synth` 는 stage 1-4
  (read_verilog → hierarchy/proc/flatten/opt/techmap/dfflibmap →
  abc_map → area sum) 완성, cited oracle 내장 (d4 ≈61762.99 /
  d6 ≈93608.53 µm² · 1.5156×).
- ❌ **측정 실행 결과 — read_verilog stage 1 에서 실패**: 임시
  driver 로 `cmd_yosys([...,"synth","--top","router_d4","--lib",
  <tt.lib>,<router_d4.v>])` 실행 → `read_verilog: unsupported
  construct 'localparam' (synth-subset only — rfc_006 §4 module-2
  scope)`, exit 2. router_d6 동일.

**진짜 §5 blocker = `read_verilog` scope (SKY130/ABC 아님)**.
`router_d4.v`/`router_d6.v` 는 ABSORPTION.md §178 이 나열한 6
construct 를 *전부* 사용 — `localparam` · `function automatic`
(`-:` part-select·signed) · multi-D memory (`fifo_mem[0:P-1]
[0:DEPTH-1]`) · `genvar`/`generate for` · `always @(*)` /
`always @(posedge clk)` · signed arith. origin/main 의 `read_verilog
.hexa` 헤더도 always-block·generate-for 를 "honest gap" 으로 자인.
rfc_006 §5 는 `read_verilog.hexa` 의 synth-subset 이 그 6 construct
를 커버해야 측정 가능 — 이는 ABSORPTION.md §178 의 "1-2주 ⭐⭐⭐⭐"
module-2 확장 작업 (always→RTLIL Process/$dff inference · generate-for
정적 펼치기 · function 인라인 · multi-D RTLIL Memory) 이며 한
세션 작업이 아니다.

**측정의 성과 (g3)**: §5 의 blocker 가 측정으로 정확히 pinpoint 됨 —
"SKY130 부재" (3차 가정) → "read_verilog 6-construct scope 부족"
(4차 실측). SKY130·ABC 는 영구 확보됐으므로, read_verilog scope 가
확장되면 §5 측정이 추가 프로비저닝 없이 end-to-end 실행된다.
instrument-first 가 또 한 번 가정을 정정 — 측정 전엔 "SKY130 만
받으면 된다" 였으나, 측정 후 진짜는 module-2 코드 확장.

**§5 최종 상태**: GATE_OPEN 유지, absorbed=false. blocker =
`stdlib/yosys/read_verilog.hexa` 6-construct scope 확장 (multi-week,
hexa-lang 작업). `inbox/notes/rfc006-s5-area-oracle-parity-handoff.md`
에 정확한 blocker + 확보된 인프라 (SKY130/ABC) + 다음 작업 범위가
scoped handoff 됨. 임시 측정 driver 삭제 · 메인 repo stdlib/yosys/
checkout 원복 완료 — 측정 흔적 0.

### Decision-gate note on Decision 68 — 5차 (read_verilog scope 13 component 진행 + router if-구조 측정으로 cond-mux 좁은 scope 0% coverage 확정)

4차 note 의 진짜 blocker (`read_verilog` 6-construct scope) 를 1-2주
hexa-lang 작업으로 진행 — `rfc006-yosys-rv-scope` branch (HEAD
`389a6d92`) 에 13 component 적재 (모두 34/34 selftest GREEN):

- constant-expression evaluator · param/localparam · width elab + ANSI
  ports · function automatic decl · expression elaboration → RTLIL
  cell tree · SymTab + array indexing · generate-for static unroll ·
  always-block parser (simple `$dff`) · body wire/reg width + 1-D
  unpacked · multi-statement always body · 2-level index + integer
  body decl · `for` inside always (static unroll) · `if/else` skip
  inside always.

router_d4.v 가 `read_verilog` stage 1 을 end-to-end 통과 — 4차 의
"localparam unsupported" 즉시-실패 가 해소. 그러나 synth driver 측정
결과: stage 1-4 (read_verilog → passes → abc_map → area) 모두 exit 0
이지만 **abc_map 이 empty mapped BLIF 를 emit** — `if/else` 가 body
없이 skip 되어 ABC 가 매핑할 cell 이 없음 (honest gap).

이 시점에서 좁은 cond-mux scope (single-statement `if (cond) lhs <= a;
else lhs <= b;`) 가 router 의 어떤 if 라도 cover 하는지 측정:

- L63-67 (`route_xy` function body): cascaded `if … else if …` chain
  — function-inline 후의 simplification 단계, free-standing always
  cond-mux 가 아님.
- L80-94 (`always @*`): 3-level nested if + `begin … end` multi-stmt.
- L98-123 (`always @(posedge clk)`): `if (rst) begin … end else begin
  … if (in_valid && !fifo_full) begin … end … if (any_grant) begin …
  end end` — 전부 multi-stmt body + nested if + for-in-always 결합.

→ **좁은 cond-mux 의 router_d4 cover = 0%** (측정 사실, if 형태 측정
으로 결정). 진짜 proc-pass core 가 요구하는 4 sub-step:
(i) per-variable LHS signal tracking across multi-stmt bodies,
(ii) nested-if collapse into chained `$mux` cells,
(iii) for-in-always 가 generate-for 와 통합,
(iv) `$dff` set/reset port hookup driven by edge type.
어느 하나도 1-session change 가 아니며 — ABSORPTION.md §178 multi-week
는 *추정* 이 아니라 직접 측정으로 재확인됨.

**§5 최종 상태 (5차 시점)**: GATE_OPEN 유지, `absorbed=false`. 측정
gate flip 없음 — `CLOSED_MEASURED` 의 기준 (`router_d{4,6}` SKY130 area
가 cited oracle ±5%, ratio 1.5156×) 은 proc-pass core 의 4 sub-step
이 모두 lands → ABC non-empty mapped BLIF → area 비교 검증 후에야
충족 가능. branch ref `rfc006-yosys-rv-scope` 가 sibling-session reset
으로 잠시 unreachable 됐었으나 `389a6d92` 위로 복원 — 13 commit 의
proc-pass session resumption 가능. macOS 의 SIGKILL/exit-137 환경
하에서 ubu-2 Linux native hexa toolchain (`/tmp/hexa_native_linux` +
clang 링크 chain) 이 검증된 build/test 표면.

### Decision-gate note on Decision 68 — 6차 (13 yosys commit hexa-lang origin/main 정착 — PR #107 merged)

5차 note 의 13 commit (`rfc006-yosys-rv-scope` HEAD `389a6d92`) 가
sibling-session 의 FIRMWARE / RFC 065 / compiler-perf commit 5개와
chronologically interleaved 상태였음. honest separation 진행:

- worktree `origin/main` HEAD `763dc9b5` 위로 yosys 13 commit cherry-
  pick → `rfc006-yosys-rv-scope-clean` branch (`d9b5d328` …
  `c320e795`). 모두 단일 파일 `stdlib/yosys/read_verilog.hexa` touch
  → sibling 영역 0% overlap → conflict-free.
- PR <https://github.com/dancinlab/hexa-lang/pull/107> open — body 에
  6-construct scope 표 (4 ✅ · 1 🟡 always-body if-skip · 2 ❌
  multi-D + signed) + selftest 34/34 GREEN + §5 OPEN 명시 (g3 — no
  fraudulent claim).
- bootstrap CI 가 `origin/main` 최근 5 commit 전부 infra-fail (PR-
  specific 아닌 기존 main 일관 상태) — owner sanction "upstream
  필요시 모두 진행" + 선례 일치로 admin-merge.
- `origin/main` 새 HEAD = `fb73c4b2` (merge commit) · 2026-05-20T
  04:50:20Z · 13 commit linear history 보존.

**Effect on demiurge consumer**: 다음 proc-pass session 은 `rfc006-
yosys-rv-scope` 가 아닌 `origin/main` 위에서 직접 시작 가능 — Yosys
synth 파이프라인 (read_verilog → passes → abc_map → area) 이 out-of-
the-box 로 `router_d4.v` 에 reachable. §5 gate state 변경 없음 — 여전
히 OPEN, absorbed=false (always-body proc-pass core 미구현).

**g3**: PR merge 자체로 `absorbed=true` 아님 — `read_verilog` scope
expansion 일부 정착이지 §5 measurement parity 가 아님. demiurge 측
Yosys 흡수 absorbed 는 SKY130 area ±5 % 측정 후에야 가능.

### Decision-gate note on Decision 68 — 7차 (cond-mux primitive family 완성 — 5 PR 누적)

6차 note 의 §5 OPEN 상태에서 proc-pass core 의 첫 sub-step 들을
incremental 하게 진행 — `cond-mux primitive` 의 simple-name-LHS family
가 hexa-lang `origin/main` 에 정착 (5 PR 추가 merge, admin-merge,
bootstrap CI infra-fail 선례 일치):

| PR | merge | sub-step | selftest |
|----|-------|----------|----------|
| #115 | `19ea268e` | #1 with-else sequential (T31) | 35/35 |
| #116 | `116f0163` | #2a with-else combinational (T32) | 36/36 |
| #119 | `66fe08a2` | #2b no-else sequential (T33) | 37/37 |
| #120 | `a8de65e0` | measurement T34/T35 (multi-stmt body 작동 확인) | 39/39 |
| #122 | `4e210d85` | #2c multi-LHS no-else (T36) | 40/40 |

핵심 측정 사실:

- ✅ **cond-mux cell-emit primitive** (cond expression elab → `$mux`
  cell → `$dff` D-port 또는 direct connect) 가 simple-name-LHS family
  의 4 변종 × multi-LHS-in-body 로 완성. selftest 34 → 40/40 PASS,
  regression 0.
- 🟡 **router_d4 cover 는 여전히 0%** — primitive 가 simple-name LHS
  shape (`q`, `q1`, `q2`) 만 cover, router_d4 의 no-else 본체는 전부
  **indexed LHS** (`fifo_mem[pp][…]`, `fifo_head[grant_in]`,
  `out_data[grant_out]`). 측정으로 다음 blocker 3개 pinpoint:
  1. **Indexed LHS** — `LHS[idx] <= rhs` 의 cond-body 안 처리.
  2. **`$dff` set/reset port** — `if (rst) q <= rst_val …` 의 `$adff`
     lowering.
  3. **Function-call inlining at expression site** — `route_xy(…)`
     식 expression elab 안의 function inline.
- 🟡 `rfc_006 §5` `measurement_gate = OPEN`, `absorbed = false`. 이번
  세션 내 flip 없음 (g3 — primitive 정착이지 area parity 가 아님).

**Effect on demiurge consumer**: 다음 proc-pass session 은 `hexa-lang
origin/main` HEAD `4e210d85` 에서 직접 시작 — 5 sub-step 의 cell-emit
primitive 를 base 로 indexed LHS / `$adff` / function inline 의 3 추가
sub-step 진행. 각 sub-step 별 selftest 가 separated regression guard.

### Decision-gate note on Decision 68 — 8차 (cond-mux primitive family 정적-static 완성 + 3 PR 누적 — 세션 누적 8 PR)

7차 note 의 cond-mux primitive 위에 indexed-LHS (static const-foldable
idx) + with-else multi-LHS 두 sub-step 적재. 세션 누적 8 PR:

| PR | merge | sub-step | selftest |
|----|-------|----------|----------|
| #126 | `3cc45397` | #3a indexed-LHS static (T37) | 41/41 |
| #128 | `0fe271da` | #3b with-else multi-LHS (T38) | 42/42 |

(+7차 note 의 5 PR.) cond-mux *cell-emit* primitive 가 *정적 shape*
의 family 완성:
- with-else sequential single-LHS (T31)
- with-else combinational single-LHS (T32)
- no-else sequential single-LHS (T33, T35)
- multi-stmt body interleaving (T34)
- multi-LHS no-else (T36)
- single-stmt indexed-LHS no-else, *static const idx* (T37)
- with-else multi-LHS simple-name (T38)

**측정 사실 (g3)** — `router_d4` cover *여전히 0%*. predict-first 로
재확인:
- router 의 모든 if-body 가 *dynamic-indexed LHS* (`fifo_head[grant_in]`,
  `out_data[grant_out]` — `grant_in`/`grant_out` 가 wire). 8 PR 의
  *static* idx primitive 는 dynamic idx 처리 불가.
- 다음 진짜 cover step 3개 모두 **새 lowering machinery** 가 필요
  (primitive 변종이 아님):
  1. **Dynamic indexing** — `name[wire_idx]` lowering = `$shiftx` 또는
     Memory cell (`$memrd`/`$memwr`).
  2. **`$adff` (또는 `$dffsr`) set/reset port** — `if (rst) q<=rst_val`
     의 dedicated reset wiring (현재는 mux feedback 으로만 표현).
  3. **Function-call inline at expression site** — `route_xy(...)`
     식 expression elab 시점 substitution.

이 3 step 각각 multi-day, 한 세션 closure 불가 (g3 — 측정-사실).
`rfc_006 §5` `measurement_gate = OPEN`, `absorbed = false` 유지.

**Effect on demiurge consumer**: 다음 proc-pass session 은 `hexa-lang
origin/main` HEAD `0fe271da` 에서 직접 시작. T31-T38 8 selftest 가
primitive family 의 regression net. session 분리 권고 — dynamic
indexing + `$adff` + function inline 의 multi-week 작업.

### Decision-gate note on Decision 68 — 9차 (Steps 4 partial + 4b 검증 + 4c honest abandon — 10 PR 누적 closure)

8차 note 의 추천순 (B → A → C) 진행 계속:
- B (마감) — demiurge `d34ffda` push + 10 stale branches cleanup 완료
- A (Step 4 partial) — static-idx 전체 variant cover (PR #133)
- C (Step 4b) — `$adff` set/reset 가 이미 cond-mux 로 cover (PR #135
  T40/T41 verification only)
- Step 4c (function-call inline) — multi-day scope 측정 후 honest
  abandon (g3 — partial 시도가 fail-risk 큼)

추가 PR:

| PR | merge | step | selftest |
|----|-------|------|----------|
| #133 | `09072f8e` | #4 partial static-idx with-else (T39) | 43/43 |
| #135 | `24422976` | #4b verified — reset via existing cond-mux (T40/T41) | 45/45 |

**이 세션 누적 측정 사실**:
- ✅ 10 PR landed on hexa-lang `origin/main` (HEAD `24422976`)
- ✅ `read_verilog` selftest 34 → **45/45 PASS**, regression 0
- ✅ cond-mux primitive 의 *static-shape* family 완성 — sequential /
  combinational × with-else / no-else × single-LHS / multi-LHS ×
  simple-name / static-indexed
- ✅ synchronous reset shape 의 cond-mux cover 검증 (T40/T41)
- 🟡 **router_d4 coverage 여전히 0%** — predict-first, not re-fired
- 🟡 진짜 router blocker 2개 (dynamic indexing, function-call inline)
  = multi-day, 별도 session
- 🟡 `rfc_006 §5` `measurement_gate = OPEN`, `absorbed = false` 유지

**사용자 goal "잔여 없이 완료시까지" 의 g3 거리**: 한 세션 내
*완료* 도달 = 측정-사실로 불가능 (dynamic-idx + function-inline 각
multi-day). 10 PR 의 measurable progress 정착이 honest closure point
— fraudulent `CLOSED_MEASURED` flip 금지 (g3 핵심).

**다음 proc-pass session 의 base**: `hexa-lang origin/main` HEAD
`24422976`. T31-T41 11 selftest 가 regression net. 두 real blocker
(dynamic indexing + function-call inline) 각 multi-day 작업.

### Decision 73 — firmware 새 도메인 + 7-verb 합성→검증 seam 정의

**picked**: 16 번째 도메인 `domains/firmware.md` 추가. **펌웨어
완벽제작 → 검증** workflow 가 7-verb 의 어디에 매핑되는지 명시적으로
박는다 — 합성(SYNTHESIZE) deliverable = signed firmware image
(`.elf` / `.bin` + MCUboot 헤더 + SBOM); 검증(VERIFY) deliverable =
QEMU / Renode pass list + 커버리지 + HIL report. 앞 5 verb (명세 →
구조 → 설계 → 해석 → 인계) 도 모두 typed Record 산출물 정의
(`requirements.json` / `arch.json` / source/ / `analysis.json` /
`release.tar.gz`) — firmware.md §2 표 + §1 deliverable 흐름이 SSOT.
Reference QEMU target `qemu-system-arm -machine mps2-an385` (Cortex-M3,
hardware 의존 0). (Rejected: firmware-as-cells-of-chip-domain — chip
은 silicon RTL/netlist 추상화, firmware 는 그 위 SW 층, 갈래 다름.
Rejected: end-to-end-chain-as-domain-meta — 한 도메인 내 7-verb 가
이미 chain 이므로 메타 레벨 불필요.)

**rationale**:
- 사용자 게이트 2026-05-20 — "지금 검증단계 말고도 펌웨어 완벽제작
  → 검증 단계까지 과정으로 넣자 · 7verb 적절한 곳에 넣어달라".
  firmware = 7-verb 의 *대표적 end-to-end deliverable* 사례 (산출물
  = 실제 실행 가능한 binary, 추상 record 아님).
- 7-verb 합성→검증 seam 이 D5 부터 추상으로만 정의됐는데, firmware
  가 **가장 구체적** 매핑을 제공 — "make 가능한 완성품" 이라는 점이
  firmware 에서 가장 명확. 다른 도메인 (sscb · scope · cern …) 도
  같은 seam 패턴 follow 가능.
- QEMU mps2-an385 reference target 으로 **모든 7-verb cell 이 측정
  가능** — hardware 의존 0, cockpit 즉시 실행. cohort 의 rtsc(Linux-
  pool 필요) · mobility(CARLA macOS 차단) 보다 진입 장벽 낮음.
- D72 적용: firmware 는 build/run orchestration + signing + emulation
  으로 수학 kernel 없음 → **adapter-only 도메인** (D72 가 "kernel
  없는 도메인" 도 OK — 새 kernel 은 정말 새 수학일 때만).
- chip 도메인과 직교: chip = silicon RTL/netlist (yosys/booksim),
  firmware = 그 위 SW 층 (Zephyr/FreeRTOS/QEMU). 두 도메인이 합성→
  검증 seam 의 두 추상 레이어 — 사용자가 firmware 를 *명시* 한 것은
  chip-only 한계를 명시적으로 깬다는 신호.

**적용**: `domains/firmware.md` 추가 완료 (16 도메인, 7-verb 1:1 표
+ §1 deliverable 흐름 + §5 cited sources + §7 D72 kernel 매핑
honest). ABSORPTION.md ② DOMAIN_MAP "15 도메인" → "16 도메인
(firmware added)" 갱신 완료. 새 RFC 불요 (D5 spine 이 이미 7-verb
정의). cockpit project type `firmware` 옵션 + ActionDispatch wiring
은 후속 라운드 (PLAN κ entry 로 인계). 측정 record 0 (도메인 추가
자체는 design baseline 작업, 빈-셀 measurement 라운드와 독립).

### Decision 74 — ProducerRegistry (cells with alternative producers)

**picked**: ActionDispatch 의 `(verb, domain)` switch 앞에 **얇은
registry** 를 둔다 — `ProducerRegistry.entries` 가 cell 별 default
producer + override 변형들을 등록. Registry 에 등록된 cell 은 switch
를 건너뛰고 variant.run 으로 dispatch; 등록 안 된 cell 은 기존 switch
그대로. **첫 적용 = `(cern, analyze)`** — variants: `xsuite-tracking`
(default, 100-turn FODO tracking, κ-49 substrate) + `pylhe` (legacy
LHE round-trip, synthetic). CLI flag `action analyze cern --producer
pylhe` 로 override. (Rejected: (A) Replace pylhe → Xsuite — pylhe
parser-coverage 손실; (B) sub-verb triple `(verb, domain, sub)` —
모든 cell touch, invasive; (D) Tag-based fan-out single Record —
schema 충돌.)

**rationale**:
- 사용자 게이트 2026-05-20 — Option C (Producer registry) + Q2
  default = xsuite-tracking + Q3 CLI flag only + Q4 AGENTS.tape note
  YES. friendly decision-gate 답신 "C" 로 묶음 진행.
- κ-49 가 cern+analyze 에 elegant_tracking.py 를 substrate landed
  했지만 기존 pylhe Producer 가 dispatch 점유 — Registry 가 그
  충돌 해소.
- κ-49 추천 (`inbox/notes/cern_analyze_producer_alternative_decision_
  2026-05-20.md`) Option C: 다른 옵션들에 비해 *additive* — 새
  producer 도입할 때마다 모든 cell 을 touch 하지 않음. 다른 cell 은
  registry 미등록 상태로 기존 switch 잔존.
- default 를 xsuite-tracking 으로: pylhe round-trip 는 synthetic LHE
  parser test — 진짜 cern+analyze 측정 아님. xsuite tracking 은 실
  입자 tracking → "더 정직한 default" (g3).
- AGENTS.tape `n_cern_producer_alternatives` 거버넌스 note 추가
  (project-governance principle — single source of truth on cell
  alternatives + default selection).

**적용**: `cockpit/Sources/DemiurgeCore/Loaders/ProducerRegistry.swift`
신규 (ProducerVariant/Entry/CellKey + entries dict). ActionDispatch.
runEngineTool 에 `producer: String?` arg 추가 + registry lookup 우선.
CernAnalyzeXsuiteProducer.swift 신규 (elegant_tracking.py spawn).
DemiurgeCLI 가 `--producer <name>` flag 파싱 → ActionDispatch 전파.
CernAnalyzeRecord Swift type 은 pylhe shape 유지 (xsuite record 는
raw json — Codable 추가는 후속 phase). g3 — registry 자체는 측정
없음, 두 variant 다 기존 GATE_OPEN 유지 (cern+synthesize 의 absorbed=
true flip 과 별개 cell).

### Decision 75 — scope+verify substrate fix: split into two checks (Option B)

**picked**: `~/core/hexa-lang/stdlib/scope/poppy_psf_verify.py` 의 check
`webbpsf_cross_check` 가 instrument-mismatch (kernel 550 nm vs NIRCam
4.8μm, λ ratio 8.7×) 로 ±50% tol 안에 들어오지 못함. **Option B — 두
check 분할**: (i) check #4a = WebbPSF NIRCam @ 4.8μm vs kernel *추가*
propagation @ 4.8μm (같은 λ → 의미 있는 ±50% parity), (ii) check #4b
= 기존 analytic diffraction limit @ 550 nm (check #2 와 동일, 변경
없음). 결과 5 check → 6 check. (Rejected: (A) align wavelengths —
kernel default 550nm 잃음, visible-light scope 좁아짐; (C) drop WebbPSF
cross-check — cohort cell JWST signal 잃음; (D) tolerance widen 0.9 —
g3 위반 silent pass.)

**rationale**:
- 사용자 게이트 2026-05-20 "완성도 기준 진행" — Option B 가 **둘 다
  살리는** 유일한 옵션: visible-light Airy oracle + JWST-instrument
  cross-check. A/C 는 한 쪽 포기, D 는 g3 위반.
- B 가 약속하는 측정 격차: ±50% tol 이 같은 λ 비교에서 진짜 의미 —
  kernel 4.8μm rerun vs NIRCam F480M 4.8μm FWHM 가 ±50% 안이면 honest
  parity 신호. 다른 λ 비교는 trivially wrong.
- substrate complexity 증가는 작음 — kernel propagation 1 회 추가
  (런타임 ~2 배), check 수 5→6, Record schema `n_checks_required=6`,
  새 field `webbpsf_kernel_4_8um_fwhm_arcsec` + `webbpsf_nircam_fwhm_
  arcsec`.
- κ-50/κ-53 의 v1/v2 parity walk 가 이 결정의 직접 입력. v3 note 가
  6/6 PASS 후 작성됨.
- absorbed=true flip 결정은 별도 — D75 는 substrate 설계 수정 만,
  flip 은 substrate 의 다른 caveats (parametric aperture vs flight
  data, hexa-native FFT IEEE-754) 도 풀려야.

**적용**: hexa-lang `stdlib/scope/poppy_psf_verify.py` 수정 — 새 check
`webbpsf_cross_check_same_wavelength` (kernel 4.8μm rerun + NIRCam
F480M 4.8μm 비교). `n_checks_required = 6`. hexa-lang push origin/main,
demiurge worktree v3 note 작성 + push. PLAN κ-54 entry. g3 — substrate
수정 자체는 GATE/absorbed 변경 0; 6/6 PASS 시에도 flip 권고는 main
session 가 따로 검토.

### Decision 80 — hexa-only ultimate-form rule (RAISES g_hexa_native to endpoint)

**picked**: 모든 producer / kernel / record / verify oracle 의
**ULTIMATE 상태 = hexa-native** (hexa-lang). Python adapter · Swift
cockpit · external CLI · sibling-repo binary 는 **transitional
pointer (bridge)** 이지 endpoint 가 아님. `absorbed=true` 는 측정-
cell 에서 substrate 의 hexa-native parity port 가 *존재 + 매치* 할
때만 허용. 그 전 단계의 flip 은 *provisional* 로 표기 (현재 cern+
synth κ-51 패턴). 기존 `g_hexa_native` (D14+D18, absorption-time
preference) 가 absolute endpoint 로 격상.

**rationale**:
- 사용자 게이트 2026-05-20 — "hexa only · hexa-native 최상단 기록".
  단순한 absorption preference 가 아니라 **모든 정직성 표면의 종착지**
  로 박는 의도.
- D72 kernel layer + D78 graph + D17 sibling-repo precedent 가 이미
  hexa-native 를 시사 — 명시적 endpoint rule 로 굳혀 모든 미래 결정의
  reference 가 되게.
- chip §B+§D (κ-43 / D70) 가 첫 *dynamic* absorbed=true 인 이유 =
  hexa-native sweep_oracle_parity.hexa 가 *실재*했기 때문. cern+synth
  (κ-51) 가 두 번째 dynamic 이지만 Python 기반 — 이번 rule 에 의해
  *provisional* 로 재분류 (scope_caveats 이미 명시).
- g3 강화: 측정-honesty + 종착-honesty 분리. 측정은 PASS 라도 종착이
  Python 이면 ultimate-form 아님 → record schema 가 두 axis 모두 표기.
- AGENTS.tape `@D g_hexa_only` 가 INDEX 최상단에 박혀 모든 거버넌스
  결정의 first principle 로 작동.

**적용**:
1. AGENTS.tape — INDEX 1번째 entry + `@D g_hexa_only` body.
2. ARCH.md §0 "hexa-only ultimate form" 박스 추가.
3. Record schema (점진) — `hexa_native_parity` 옵셔널 필드 추가.
   absorbed=true 일 때 비어있으면 `provisional=true` 자동 마크.
4. cern+synth Record 갱신 (점진) — provisional=true + hexa_native_
   parity=null typed 화 (현 scope_caveats 의 형식 typed 화).
5. design.md D80 audit-trail (이 entry) + PLAN κ-N entry.

g3 — 측정 record 변경 0 (D80 자체는 governance 추가). cern+synth
의 provisional flag 화는 후속 phase (record schema 변경 + 점진 적용).
