---
slug: qforge-feature-xval-harness
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated  +  demiurge docs
domain: QFORGE-FEATURE (demiurge domains/)
---

## task brief
Advance the QFORGE-FEATURE backlog on the COMPLETE axis. TWO parts:
1. HONEST bookkeeping (d6): correlation-XC (PZ81/PW92) is STALE-marked "deferred" in the backlog
   but ALREADY LANDED — `screening.hexa` xc_mode=2 = Hartree + LDA x+c (Slater exchange + PW92
   correlation), PR#2402/PR2 + `stdlib/qforge/correlation`. Verify its closure (is xc_mode=2 wired
   reachable in the DFPT screening path?) and CORRECT the backlog (QFORGE-FEATURE.md + QFORGE.md).
2. BUILD the next complete-axis open feature: the **3-anchor cross-val harness**
   `qforge_migration_gate_test` — a g5 test that ingests the three QE λ·Tc references
   (CaH6 · LaH10 · Li2MgH16) + the QFORGE-NC outputs and emits ALL_PASS / HELD. The migration
   default-flip is gated on this; today it is a MANUAL matrix. Build the durable machinery now
   (CaH6 ref is terminal; LaH10/Li2MgH16 wired to ingest when they land — fixture-driven).

## locked decisions
- @L1 (complete): VERIFY correlation-XC closure first — grep screening.hexa + correlation.hexa, confirm xc_mode=2 reachable + has a g5 selftest; report the actual state VERBATIM (do NOT assume). assert:grep xc_mode
- @L2 (complete): CORRECT the stale backlog — in demiurge QFORGE-FEATURE.md flip the correlation-XC line to closed (cite PR#2402) + drop the stale "Hartree+LDA-exchange only" claim in QFORGE.md migration-gate notes. assert:grep PR#2402
- @L3 (complete): build `stdlib/qforge/qforge_migration_gate_test.hexa` — ingest per-anchor {λ, Tc} QE-ref + QFORGE-NC fixtures, compare at the g5 rel-ε bar (same as L3 YH10 = within 1%), emit per-anchor PASS/FAIL + aggregate ALL_PASS/HELD. assert:file stdlib/qforge/qforge_migration_gate_test.hexa
- @L4 (std): fixture-driven like the existing `qforge_l3_qe_xval_test` (YH10 .elph fixtures) — CaH6 ref from the existing step4 json; LaH10/Li2MgH16 fixtures as `PENDING` placeholders that make the aggregate HELD until real λ·Tc land (honest, not faked). assert:grep PENDING
- @L5 (safe): the harness READS fixtures only — no pod ops, no live-pod touch (gate anchors 38943553·38922322 are computing; never touch). Reuse the verified L2 integrator + a2f assembler (d3/d19), 0-diff existing files.
- @L6 (complete): d6 honesty — the aggregate is HELD (not ALL_PASS) until all three anchors have REAL terminal λ·Tc. Do NOT fabricate LaH10/Li2MgH16 numbers to force ALL_PASS. A HELD verdict with 1/3 anchors terminal IS the correct output now.
- @L7 (std): g5 — `qforge_migration_gate_test` @ci_gate PASS (CaH6 within-bar · PENDING anchors → HELD · aggregate logic). Paste verdict VERBATIM.

## next-action checklist
- [ ] isolated worktree off origin/main (`~/core/hexa-lang-xval-harness`); confirm HEAD = origin/main
- [ ] verify correlation-XC closure (screening.hexa xc_mode=2 + correlation.hexa + its selftest) — report VERBATIM
- [ ] build qforge_migration_gate_test.hexa (fixture-driven · CaH6 real · LaH10/Li2MgH16 PENDING placeholders → HELD)
- [ ] g5 selftest VERBATIM (CaH6 within-bar · HELD aggregate · logic cases)
- [ ] stacked PR <200 lines · 1 concern · self-merge squash on g5 green
- [ ] demiurge docs: correct correlation-XC backlog (QFORGE-FEATURE.md closed + cite PR#2402; QFORGE.md drop stale exchange-only note) — explicit-path commit
- [ ] ship

## completion criteria
- correlation-XC backlog corrected (closed · PR#2402 cited) · `qforge_migration_gate_test` lands + g5 PASS · aggregate = HELD (1/3 CaH6 terminal · LaH10/Li2MgH16 PENDING) — the HONEST current state, durable machinery ready to flip ALL_PASS when the two anchors land.
- HONEST (d6/@L4·@L6): zero fabricated λ·Tc; HELD is the correct verdict, not a failure.

## guards
- g8: pod ops via `hexa cloud` only; LIVE gate pods 38943553·38922322 READ-ONLY (the harness needs NO pod — fixtures only).
- d9: isolated worktree · explicit paths · sequential commit. cross-repo: hexa-lang PR + demiurge docs commit are SEPARATE.
- plan-guard "without/forced/fabricat" word-match false-positives EXPECTED; @L are the contract.
