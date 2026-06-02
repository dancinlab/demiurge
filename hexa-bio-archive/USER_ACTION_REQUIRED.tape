#!/usr/bin/env tape

# ══════════════════════════════════════════════════════════════
# USER_ACTION_REQUIRED.tape — architecture-current (editable per v1.2)
# Event history → USER_ACTION_REQUIRED.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "user-action-required" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio meta/index — deferred external-action index"
  brief = "Single canonical index for deferred external items: Phase 1 wet-lab · Phase 2 IP · Phase 3+ clinical. Audience: repo owner."
  parent = "dancinlab/hexa-bio"
  sibling-md = "USER_ACTION_REQUIRED.md"
  sibling-log = "USER_ACTION_REQUIRED.log.tape"
  tape-class = "meta/index"
  rewritten-from = "USER_ACTION_REQUIRED.tape pre-2026-05-16 skeleton (no honesty contract) → honesty-lint compliance pass d=2026-05-16"
  methodology-cite = "AGENTS.tape g9_external_contact_defer + g10_no_proposal_for_deferred + f4 forbidden-pattern — deferral policy that this index exists to enforce"

# ── §0 Scope disclaimer ───────────────────────────────────────────────

@N scope_disclaimer := "user-action-required scope" :: note [required active]
  text = "This file is a META/INDEX tape — it indexes deferred external actions that the repo owner (user) must perform. It contains NO science claims, NO lattice derivations, and NO therapeutic/clinical/regulatory assertions. ALL items in this index are out-of-software-scope by definition: human decision-making, outreach, contracts, regulatory engagement, or capital allocation. Software side is ready; the gating constraint in every item is the external counterparty. Long-form prose: USER_ACTION_REQUIRED.md (see [@x_user_action_required_md])."
  constraint = "Agents must NOT propose items from this index as 'next steps' in end-of-turn summaries (AGENTS.tape g10 / f4). USER_ACTION_REQUIRED.md is the single human-readable index; this tape is the machine-readable governance mirror."

# ── §1 Deferred-action index (pointer entries) ───────────────────────
# Full text lives in USER_ACTION_REQUIRED.md. Each @N here is a
# machine-readable pointer with status and phase for agent lookups.

@N idx_1_1 := "hexa-medic sister repo decision (OBSOLETE)" :: note [deprecated d=2026-05-12]
  phase = "Phase 1 / §1.1"
  status = "OBSOLETE — hexa-medic decomposed + deleted 2026-05-12; verbs migrated to Floréa / hexa-matter / hexa-bio"
  owner = "user"
  ?> x_user_action_required_md

@N idx_1_2 := "wet-lab CRO candidate selection" :: note [active d=2026-05-12]
  phase = "Phase 1 / §1.2"
  status = "PENDING USER ACTION — 3-5 vendors to contact per axis (nanobot · ribozyme · virocapsid)"
  axes = [nanobot, ribozyme, virocapsid]
  owner = "user"
  ?> x_user_action_required_md

@N idx_1_3 := "patent counsel firm selection" :: note [active d=2026-05-12]
  phase = "Phase 2 / §1.3"
  status = "PENDING USER ACTION — 1st consultation meeting to schedule; NDA before disclosure"
  coverage = "DNA-origami actuation + ribozyme 12-nt cleavage geometry"
  owner = "user"
  ?> x_user_action_required_md

@N idx_1_4 := "quantum HW vendor decision" :: note [active d=2026-05-12]
  phase = "Long-horizon / §1.4"
  status = "DEFERRED — not needed until v3.0.0+ (>30 qubit workloads); qmirror covers all v1.x/v2.x requirements"
  owner = "user"
  ?> x_user_action_required_md

@N idx_2_1 := "CRO RFP outreach (per axis)" :: note [active d=2026-05-12]
  phase = "Phase 1 / §2.1"
  status = "PENDING USER ACTION — 9-15 RFPs (3 axes × 3-5 vendors); templates in USER_ACTION_REQUIRED.md §2.1"
  budget-estimate = "$50K-200K per axis (wet-lab pilot)"
  owner = "user"
  ?> x_user_action_required_md

@N idx_2_2 := "patent counsel 1st meeting" :: note [active d=2026-05-12]
  phase = "Phase 2 / §2.2"
  status = "PENDING USER ACTION — invention disclosure prep (~4 hrs) + provisional filing (~$5K-15K)"
  owner = "user"
  ?> x_user_action_required_md

@N idx_2_3 := "regulatory consultant contact (pre-IND)" :: note [active d=2026-05-12]
  phase = "Phase 3+ / §2.3"
  status = "DEFERRED — 1-2 years post wet-lab; MFDS or FDA pre-IND meeting (type B); 60-90 day lead time"
  owner = "user"
  ?> x_user_action_required_md

@N idx_3_funding := "funding / budgeting" :: note [active d=2026-05-12]
  phase = "Phase 1-3 / §3"
  status = "PENDING USER DECISION — Phase 1 total estimate $200K-800K; sources: KIAT · NRF · NIH SBIR/STTR · bio VC"
  owner = "user"
  ?> x_user_action_required_md

@N idx_4_docs := "documentation / legal (invention disclosure + CRO contracts + wetlab dirs)" :: note [active d=2026-05-12]
  phase = "Phase 1-2 / §4"
  status = "PENDING USER ACTION — §4.1 invention disclosures · §4.2 CRO MTAs · §4.3 wetlab dir structure (user decides top-level vs per-axis)"
  owner = "user"
  ?> x_user_action_required_md

# ── §2 Honesty contract (LATTICE_POLICY g1/g2/f1 — META tape, meta-mode) ──

@F f_lattice_fit := "lattice-fit-in-deferred-index-entries" :: governance [required deny:write]
  pattern = "Deriving any claim (efficacy / count / ratio / timeline / budget estimate) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) inside a deferred-action index entry."
  why = "This tape is an external-action deferral index. Its entries contain estimates sourced from industry standard CRO pricing, regulatory lead times, and IP filing costs — none of which derive from the n=6 lattice. Any lattice token appearing here would be a misapplication. The lattice is a computational scaffold tool, not an authority on CRO budgets or regulatory timelines."
  remedy = "All cost/timeline estimates must cite their real source (industry benchmarks, MFDS/FDA published lead times, BIO MTA templates, etc.), never the lattice. The lattice is declined here as a derivation tool."
  authority = "[@x_lattice_policy] g1/g2 · hexa-bio AGENTS.tape f1 · [@x_agents_tape] g9/g10/f4"

@N n6_honest_stance := "lattice observation-not-derivation stance for this index" :: note [required active]
  text = "Stated plainly and honestly: this tape indexes deferred human external-contact actions. The n=6 lattice (σ τ φ J₂) has no role in CRO selection, patent filing, regulatory timelines, or budget estimation. No lattice tokens appear in the index entries because none belong there. The cost/timeline figures in USER_ACTION_REQUIRED.md §3 are industry-standard estimates from CRO market research, IP filing norms, and published regulatory process timelines — not derived from any mathematical invariant. Per LATTICE_POLICY g1/g2: the lattice is a tool, not a constraint or derivation authority. Observation-not-derivation holds trivially here: there is nothing to observe."

# ── §3 External citations ─────────────────────────────────────────────

@X x_lattice_policy := "echoes/LATTICE_POLICY.md" :: governance [active]
  url = "https://github.com/dancinlab/echoes/blob/main/LATTICE_POLICY.md"
  scope = "real-limits-first · lattice-is-tool · observation-not-derivation — the cohort-wide governance authority this honesty contract enforces"

@X x_agents_tape := "hexa-bio AGENTS.tape" :: governance [active]
  path = "./AGENTS.tape"
  scope = "g9_external_contact_defer (agents defer all external-contact actions) · g10_no_proposal_for_deferred (no 'next steps' proposals for deferred items) · f4 forbidden-pattern (no deferred-action proposals in end-of-turn summaries) · g1 real-limits-first · g2 lattice-is-tool"
  note = "g9+g10 deferral policy is the governance reason this index exists: agents draft templates + STATUS markers; user owns the SEND/SIGN/PAY/MEET step."

@X x_user_action_required_md := "USER_ACTION_REQUIRED.md (long-form sibling)" :: doc [active]
  path = "./USER_ACTION_REQUIRED.md"
  scope = "Full prose index: §1 decisions · §2 outreach/procurement · §3 funding/budgeting · §4 documentation/legal · §5 honesty caveats. RFP templates, vendor lists, budget tables, per-axis deliverables all live here. This tape is the machine-readable governance mirror; the .md is the human-readable primary reference."
