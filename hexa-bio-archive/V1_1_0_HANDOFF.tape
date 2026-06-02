#!/usr/bin/env tape

# ══════════════════════════════════════════════════════════════
# V1_1_0_HANDOFF.tape — architecture-current (editable per v1.2)
# Event history → V1_1_0_HANDOFF.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "v1-1-0-handoff" :: identity-claim [d=2026-05-14 active]
  kind = "v1.1.0 release handoff checklist"
  brief = "Status (2026-05-06): cycle 24 + cycle 25 closed at formalism level. v1.1.0 is a numerical / infrastructure release. NOT clinical or therapeutic. C3+ (wet-lab → IND → phase I) explicitly out-of-repo."
  parent = "dancinlab/hexa-bio"
  sibling-md = "V1_1_0_HANDOFF.md"
  sibling-log = "V1_1_0_HANDOFF.log.tape"
  sibling-release-notes = "RELEASE_NOTES_v1.1.0.md"
  tape-class = "meta/handoff"
  rewritten-from = "V1_1_0_HANDOFF.tape pre-2026-05-16 (plain log scaffold → honesty-lint meta-mode compliance)"

# ── §0 Honesty preamble (LATTICE_POLICY g1/g2/f1 — META tape, meta-mode opt-in) ──
# This is a release handoff checklist for v1.1.0. It carries the lattice-honesty
# contract in meta-mode per AGENTS.tape g_meta_mode_optin (d=2026-05-16).
# Meta-mode widens clause 3 (grounding) to accept @X :: governance entries —
# guard (1) and stance (2) remain identical to standard tapes.

@F f_lattice_fit := "lattice-fit-in-handoff-entries" :: governance [required deny:write]
  pattern = "Deriving any claim (efficacy / count / ratio / closure-grade) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) inside a handoff entry — e.g. asserting 'closure = X% because σ·φ/2' or 'cycle count = φ·τ' as derivation."
  why = "This is a release handoff checklist. Any lattice tokens that appear in checklist entries are DESCRIPTIVE PROVENANCE (literal names of shipped artifacts such as the J₂=24 pose-equivalence speedup in NANOBOT, or historical gate labels) — not derivations. Recording that work shipped with a feature named after a lattice token is history; deriving science from the lattice is the forbidden anti-pattern."
  remedy = "Checklist entries are preserved verbatim — true history is not rewritten to dodge a linter. Any new entry must cite the real underlying engineering/science (commit hash + sister-repo gate + real source), never the lattice as a derivation. Lattice mentions remain coincidental artifact-name provenance only."
  authority = "[@x_lattice_policy] g1/g2 · hexa-bio AGENTS.tape f1 · [@x_agents_tape]"

@N n6_honest_stance := "handoff lattice mentions are provenance, not derivation" :: note [required]
  text = "Stated plainly and honestly: this is the v1.1.0 release handoff checklist. The n=6 tokens (σ τ φ J₂) that may appear in the checklist entries below are the NAMES of shipped artifacts and the SUBJECT of landed work — historical context — never a derivation of any claim FROM the lattice. The NANOBOT C0b entry references 'J₂=24 pose-equivalence speedup' — that is the artifact name (provenance). The ribozyme entry references k_cat / K_M — that is a real measured kinetic parameter, not a lattice token. Per LATTICE_POLICY g1/g2, the lattice is declined here as a derivation tool; observation-not-derivation. The handoff asserts no science from the lattice. This preamble is meta-mode compliance per AGENTS.tape g_meta_mode_optin."

@N scope_disclaimer := "v1.1.0 honest scope — in-silico only" :: note [required]
  text = "v1.1.0 is a FORMALISM / INFRASTRUCTURE release. NOT clinical, biomedical, regulatory, or efficacy release. C2 16-cell matrix PASS verifies SIMULATOR + METADATA internal consistency only — NOT biological / clinical / immunogenic / efficacy property of any annotated marker. The disease class labels (α=AML, β=SCD, γ=pan-cov, δ=senolytic) and marker references (CD33, CD3, FLT3-ITD, WT1, HBB Glu6Val, CD34, conserved RBD region, p16-INK4a, SASP cytokine) are 16-cell matrix labels per .roadmap.hexa_bio §0 — they do NOT denote any clinical or treatment proposal. C3+ (wet-lab → IND → phase I) is explicitly out-of-repo."
  authority = "[@x_handoff_md] §Honest scope reminder · [@x_release_notes] §Honest scope"

# ── §1 In-repo state (all done autonomously, reproduced from sibling-md) ─────

@D in_repo_c0b := "C0b 4-verb numerical MVP simulators wired" :: checklist [ok d=2026-05-05]
  status = "DONE"
  items = [
    "WEAVE F-TP5-b PASS",
    "NANOBOT F-NB-4 PASS",
    "RIBOZYME F-RB-4 PASS",
    "VIROCAPSID F-VIROCAPSID-3 PASS"
  ]
  note = "All 4 verbs have Python stdlib-only numerical MVP simulators wired under _python_bridge/module/ that emit witness rows to state/discovery_absorption/registry.jsonl."

@D in_repo_c0a := "Sister-axis collision audits" :: checklist [partial d=2026-05-05]
  status = "2 PASS + 1 PARTIAL"
  items = [
    "F-RB-5 PASS WITH MITIGATION",
    "F-VIROCAPSID-COLLISION PASS clean",
    "F-NB-5 PARTIAL — blocked on out-of-repo canon canonical-side fix"
  ]

@D in_repo_bayesian := "Bayesian audits (cycle 25 C0c)" :: checklist [ok d=2026-05-06]
  status = "DONE"
  items = [
    "F-RB-2 PASS log_bf 79.74 — suspicious-perfect 30/30, flagged for inter-rater",
    "F-NB-2 honest negative log_bf 0.16 — STRUCTURAL-APPROXIMATE preserved"
  ]

@D in_repo_misc := "Cycle-25 follow-ons and infrastructure" :: checklist [ok d=2026-05-06]
  status = "DONE"
  items = [
    "Multi-T extension (V-R2 stretch) — T=3 / T=4 PASS via integer-power scaling",
    "WEAVE Π^p_2 verifier v2 — PASS no regressions",
    "Registry-integrity audit infrastructure — 7/7 checks PASS on 509+ rows",
    "C2 16-cell matrix — 16/16 PASS, all foreground due to classifier rule",
    "HEXA dispatcher flags --c2-{aml,scd,pancov,senolytic} wired across 4 verbs",
    "13 omega-cycle closure kicks in design/kick/ (7 cycle-24 + 6 cycle-25)",
    "CHANGELOG [Unreleased] populated with cycle-24 + cycle-25 work",
    "RELEASE_NOTES_v1.1.0.md drafted (~234 lines, mirrors v1.0.0 structure)",
    "Memory rules captured (4 files in memory/)"
  ]

# ── §2 Pending — user decision needed before tag ─────────────────────────────

@D pending_approve := "Read & approve release artifacts" :: checklist [draft]
  status = "PENDING — user decision"
  items = [
    "Read & approve RELEASE_NOTES_v1.1.0.md",
    "Read & approve CHANGELOG.md [Unreleased] section (move to ## [1.1.0] - 2026-05-06)"
  ]

@D pending_version_bump := "Decide version bump locations" :: checklist [draft]
  status = "PENDING — user decision"
  items = [
    "hexa.toml (manifest version field)",
    "install.hexa (if it carries a version constant)",
    "README badge (if applicable)",
    "per-verb let VERSION = ... constants in <verb>/module/<verb>.hexa (currently mixed: weave is 1.0.0, others are 1.0.0-stub-c0b)"
  ]

@D pending_git_ops := "Manual git ops (autonomous cannot tag)" :: checklist [draft]
  status = "PENDING — user action"
  note = "Autonomous agent cannot execute git tag / push. User owns these steps."
  commands = [
    "git status",
    "git add -A",
    "git commit -m 'v1.1.0: cycle 24 C0b + cycle 25 C2 closure'",
    "git tag -a v1.1.0 -m 'v1.1.0 numerical infrastructure release'",
    "git push origin main",
    "git push origin v1.1.0"
  ]

# ── §3 Out-of-repo items (separate sessions, after tag) ──────────────────────

@D out_of_repo_nb5 := "F-NB-5 closure — canon session" :: checklist [draft]
  status = "PENDING — out-of-repo"
  tasks = [
    "Edit domains/biology/hexa-nanobot/hexa-nanobot.md §11 DEPENDENCIES — add therapeutic-nanobot consumer note",
    "Edit domains/life/therapeutic-nanobot/therapeutic-nanobot.md §3/§11 — acknowledge hexa-nanobot prior registration (2026-04-28)",
    "Emit joint witness: design/kick/2026-05-28_hexa-nanobot-therapeutic-nanobot-boundary.json",
    "Update hexa-bio .roadmap.nanobot — F-NB-5 PARTIAL → PASS"
  ]

@D out_of_repo_kicks := "Mirror cycle-24 + cycle-25 kicks to canon" :: checklist [draft]
  status = "PENDING — out-of-repo"
  files = [
    "2026-05-05_* (7 cycle-24 kicks)",
    "2026-05-06_* (6 cycle-25 kicks)"
  ]
  destination = "~/core/canon/design/kick/"

@D out_of_repo_c3 := "C3+ wet-lab handoff — entirely external" :: checklist [draft]
  status = "PENDING — external; per (R6) hexa-bio scope stops at in-silico"
  note = "Engaging a wet-lab partner (CRO / academic collaborator) for any 16-cell candidate is a separate program, not a hexa-bio cycle. USER_ACTION_REQUIRED.md is the canonical index."

# ── §4 What v1.1.0 enables (forward-looking, scoped) ────────────────────────

@N n_cycle26_candidates := "cycle 26 candidates (scoped)" :: note [optional]
  in-repo = [
    "lean4 mechanical layer extension to NANOBOT / RIBOZYME / VIROCAPSID (currently only WEAVE has sorry-free Foundation in canon upstream)",
    "WEAVE Π^p_2 verifier upgrade from greedy heuristic toward true NP-solver path (deferred from cycle 24)",
    "Inter-rater reliability check on F-RB-2 30/30 result",
    "F-NB-2 retest with stricter rubric",
    "VIROCAPSID multi-T extension to T=7 / T=13 / T=21 (beyond V-R2 stretch)"
  ]
  out-of-repo = [
    "One C2-cell wet-lab handoff (γ-first per .roadmap.hexa_bio (R8)) — requires external partner"
  ]

# ── §5 External citations ────────────────────────────────────────────────────

@X x_lattice_policy := "echoes/LATTICE_POLICY.md" :: governance [active]
  url = "https://github.com/dancinlab/echoes/blob/main/LATTICE_POLICY.md"
  scope = "real-limits-first · lattice-is-tool · observation-not-derivation — the governance authority this preamble enforces"

@X x_agents_tape := "hexa-bio AGENTS.tape" :: governance [active]
  path = "./AGENTS.tape"
  scope = "g_meta_mode_optin (meta-tape opt-in, d=2026-05-16) · g1 real-limits-first · g2 lattice-is-tool · f1 lattice-fit-on-external-entity · g8 in-silico-only-claim-scope · g_arch_vs_log_split"

@X x_handoff_md := "V1_1_0_HANDOFF.md" :: doc [active]
  path = "./V1_1_0_HANDOFF.md"
  scope = "long-form sibling — full prose checklist, honest scope reminder, out-of-repo steps, forward-looking candidates"

@X x_release_notes := "RELEASE_NOTES_v1.1.0.md" :: doc [active]
  path = "./RELEASE_NOTES_v1.1.0.md"
  scope = "v1.1.0 release notes — highlights, what's wired, honest scope, provenance, Apache-2.0"
