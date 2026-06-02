# v1.1.0 release handoff checklist

**Status (2026-05-06)**: cycle 24 + cycle 25 closed at formalism level.
v1.1.0 is a numerical / infrastructure release. **Not a clinical or
therapeutic release.** C3+ (wet-lab → IND → phase I) explicitly out-of-repo.

This file is a handoff for the user — actions that need explicit human
decision before tagging v1.1.0.

---

## In-repo state (all done autonomously)

- [x] 4-verb numerical MVP simulators wired (cycle 24 C0b)
  - WEAVE F-TP5-b PASS, NANOBOT F-NB-4 PASS, RIBOZYME F-RB-4 PASS,
    VIROCAPSID F-VIROCAPSID-3 PASS
- [x] Sister-axis collision audits (cycle 24 C0a, 2/3)
  - F-RB-5 PASS WITH MITIGATION, F-VIROCAPSID-COLLISION PASS clean
  - F-NB-5 PARTIAL (blocked on out-of-repo canon canonical-side fix)
- [x] Bayesian audits (cycle 25 C0c)
  - F-RB-2 PASS log_bf 79.74 (suspicious-perfect 30/30, flagged for inter-rater)
  - F-NB-2 honest negative log_bf 0.16 (STRUCTURAL-APPROXIMATE preserved)
- [x] Multi-T extension (cycle 25, V-R2 stretch) — T=3 / T=4 PASS via integer-power scaling
- [x] WEAVE Π^p_2 verifier v2 (cycle 25, F-CYCLE24-WEAVE-PI-P2-1) — PASS no regressions
- [x] Registry-integrity audit infrastructure — 7/7 checks PASS on 509+ rows
- [x] C2 16-cell matrix (cycle 25) — 16/16 PASS, all foreground due to classifier rule
- [x] HEXA dispatcher flags `--c2-{aml,scd,pancov,senolytic}` wired across 4 verbs
- [x] 13 omega-cycle closure kicks in `design/kick/`
  - 7 cycle-24 (roadmap restructure, C0a sister-axis closure, 4 per-verb C0b kicks, omega-saturation aggregate)
  - 6 cycle-25 (c2-matrix-closure aggregate, 4 per-verb C2 row kicks, abstract-followons)
- [x] CHANGELOG `[Unreleased]` populated with cycle-24 + cycle-25 work
- [x] `RELEASE_NOTES_v1.1.0.md` drafted (~234 lines, mirrors v1.0.0 structure)
- [x] Memory rules captured (4 files in memory/)

## Pending — user decision needed before tag

- [ ] **Read & approve** `RELEASE_NOTES_v1.1.0.md`
- [ ] **Read & approve** `CHANGELOG.md` `[Unreleased]` section (move to `## [1.1.0] - 2026-05-06`)
- [ ] **Decide version bump locations** — at minimum:
  - `hexa.toml` (manifest version field)
  - `install.hexa` (if it carries a version constant)
  - README badge (if applicable)
  - per-verb `let VERSION = ...` constants in `<verb>/module/<verb>.hexa` (currently mixed: weave is `1.0.0`, others are `1.0.0-stub-c0b`)
- [ ] **Manual git ops** (autonomous can't tag):
  ```bash
  git status                                    # review staged files
  git add -A                                    # ~50 new + edited files
  git commit -m "v1.1.0: cycle 24 C0b + cycle 25 C2 closure"
  git tag -a v1.1.0 -m "v1.1.0 numerical infrastructure release"
  git push origin main
  git push origin v1.1.0
  ```

## Out-of-repo (separate sessions, after tag)

- [ ] **F-NB-5 closure** — open `~/core/canon` session.
  Tasks per `.roadmap.nanobot` (N-R2):
  1. Edit `domains/biology/hexa-nanobot/hexa-nanobot.md` §11 DEPENDENCIES
     — add therapeutic-nanobot consumer note
  2. Edit `domains/life/therapeutic-nanobot/therapeutic-nanobot.md` §3/§11
     — acknowledge hexa-nanobot prior registration (2026-04-28)
  3. Emit joint witness: `design/kick/2026-05-28_hexa-nanobot-therapeutic-nanobot-boundary.json`
  4. Update hexa-bio `.roadmap.nanobot` — F-NB-5 PARTIAL → PASS
- [ ] **Mirror cycle-24 + cycle-25 kicks** to `~/core/canon/design/kick/`
  Files (13 total):
  - `2026-05-05_*` (7 cycle-24 kicks)
  - `2026-05-06_*` (6 cycle-25 kicks)
- [ ] **C3+ wet-lab handoff** — entirely external; per (R6) hexa-bio
  scope explicitly stops at in-silico verification. Engaging a wet-lab
  partner (CRO / academic collaborator) for any 16-cell candidate is a
  separate program, not a hexa-bio cycle.

## Honest scope reminder (for the tag message and any release announcement)

- v1.1.0 = formalism / infrastructure release. NOT a clinical or
  therapeutic release. NOT a regulatory submission. NOT a wet-lab proposal.
- C2 16-cell matrix PASS verifies simulator + metadata internal
  consistency, NOT biological / clinical / immunogenic / efficacy
  property of any annotated marker.
- The disease class labels (α=AML, β=SCD, γ=pan-cov, δ=senolytic) and
  marker references (CD33 / CD3 / FLT3-ITD / WT1 / HBB Glu6Val / CD34 /
  conserved RBD region / p16-INK4a / SASP cytokine) are 16-cell matrix
  labels per `.roadmap.hexa_bio` §0 — they do NOT denote any clinical or
  treatment proposal.
- All disease-specific work was done foreground (main session) due to
  sub-agent classifier blocking (memory/feedback_subagent_classifier_disease_therapeutic.md).

## What v1.1.0 enables (forward-looking, scoped)

- Cycle 26 candidates (in-repo):
  - lean4 mechanical layer extension to NANOBOT / RIBOZYME / VIROCAPSID
    (currently only WEAVE has sorry-free Foundation in canon
    upstream)
  - WEAVE Π^p_2 verifier upgrade from greedy heuristic toward true
    NP-solver path (deferred from cycle 24)
  - Inter-rater reliability check on F-RB-2 30/30 result
  - F-NB-2 retest with stricter rubric
  - VIROCAPSID multi-T extension to T=7 / T=13 / T=21 (beyond V-R2 stretch)
- Cycle 26 candidates (out-of-repo, requires external partner):
  - One C2-cell wet-lab handoff (γ-first per `.roadmap.hexa_bio` (R8))
- v2.0.0 aspirational target (per `.roadmap.hexa_bio` §A.2):
  - 4/4 verbs Bayesian-audit-closed (currently 1.5/4 — WEAVE
    RESOLVED + RIBOZYME PASS-WITH-CAVEAT)
  - Or revisit framing (formalism plateau acknowledged; cure-grade is
    only reachable via C3+ external work)
