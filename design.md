# hexa-arch — design decisions (audit trail)

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
  disclosure keeps hexa-arch on the established, defensible footing.
- Legally and governance safe: no IP infringement, no license/DRM
  circumvention; consistent with no-over-claim (g1·g2·g3) and
  hexa-native-only (g5).
- Closed-binary decompilation / trade-secret extraction is refused outright
  — excluded explicitly so the audit trail carries no gray area.

### Decision 2 — 별개, 타입드 인터페이스 (hexa-arch ↔ hexa-matter/hexa-bio)

**picked**: hexa-arch stays a *separate sibling* of hexa-matter and hexa-bio.
When a domain's verify/simulate step needs material properties it *calls*
hexa-matter; when it needs molecular/chemical modeling it *calls* hexa-bio —
both over a typed interface contract. Neither repo is absorbed into
hexa-arch. This mirrors the established family idiom where `comb` is a
*consumer* of hexa-arch[chip], not its absorber. (Rejected: B = absorb only
hexa-matter; C = absorb both.) To be reflected in CHARTER/HANDOFF as part of
the broader redesign deliverable.

**rationale**:
- Family architecture consistency — "siblings, decoupled by design" is the
  already-established idiom (CHARTER); making hexa-arch a consumer of
  matter/bio is isomorphic to the comb↔hexa-arch[chip] precedent, zero
  architectural contradiction.
- no-big-bang governance — hexa-matter (16-verb) and hexa-bio
  (WEAVE/NANOBOT) are mature large repos; absorbing them is a big-bang,
  violating HANDOFF §5 "incremental · measured · no big-bang".
- andrej-karpathy simplicity/surgical — hexa-arch needs only a typed
  interface contract to material/molecular properties, not their internals;
  minimum code, no swallowed scope.
- no-over-claim (g3) — hexa-arch does not claim material/molecular
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

**picked**: F1/F2 measurement records produced by hexa-arch[chip] live at
`~/core/hexa-arch/exports/chip/noc/f1f2/` (producer-owned). `comb` reads
by absolute path. Atlas promotion to `~/core/atlas/hexa-arch::chip::noc::
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
- D2 cleanliness — the interface is between *two* repos (hexa-arch ↔
  hexa-lang/comb). Atlas promotion now would invent fleet-wide
  responsibility that no third consumer has asked for (lattice-as-tool +
  andrej-karpathy simplicity).
- Audit chain `sim_commit_hash → emit_path → record` colocated inside
  hexa-arch git — zero cross-repo forensics needed when a measurement is
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
hexa-arch should cite `comb/RFC.md` + the operationalization files
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

### Decision 10 — hexa-arch scope = design-only; execution-parity is a gated non-goal

**picked**: hexa-arch proceeds **design-only** (user: "hexa-arch
설계만 진행"). The deliverable is the *design*: the 7-verb spine, the
absorption RFCs (rfc_001 / rfc_002 / rfc_003), the clean-room
hexa-native re-derivation modules (`stdlib/booksim/*.hexa` — 6 landed,
self-tested, provenanced, at `GATE_B_PINNED_MET`), the typed F1F2
interface + schema, the 14 domain maps, and the external-reference
measurement records that characterize comb T1A's inequality. **Full-
curve parity, §D, and the `absorbed=true` flip are an execution gate,
explicitly OUT of hexa-arch design scope** — not pursued under
hexa-arch unless the user re-opens it. Re-entry condition (faster
substrate / bounded per-flit DES) is preserved in rfc_003 §7 + the
agent reports.

**rationale**:
- Charter-consistent — hexa-arch is defined as a "technical-design
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
  ~1e4 ops/s) lives in hexa-lang, not hexa-arch — hexa-first principle
  says fix it there PR-only; chasing it under hexa-arch would
  mis-place the work and risk SKIP-mode pressure on g3.
- Reversible at zero cost — the rfc_003 §7 phased path + agent reports
  document the exact re-entry; re-opening the execution gate later
  needs no rework.
