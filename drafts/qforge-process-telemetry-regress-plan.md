---
slug: qforge-process-telemetry-regress
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated
domain: QFORGE-PROCESS (demiurge domains/)
---

## task brief
PROCESS emits (.dft_telemetry.jsonl, #2474) and analyzes per-stage bottlenecks (#2477). Add the
cross-run REGRESSION detector: given a baseline run's telemetry and a current run's telemetry,
flag any stage whose wall (or peak RSS) grew beyond a threshold — the "improvement lever" signal
the domain's @goal calls for (catch a slowdown the moment a deck/engine change introduces it).

## locked decisions
- @L1 (complete): build `qforge_telemetry_regress(baseline_jsonl, current_jsonl, pct_threshold) -> RegressReport` in stdlib/qforge/telemetry_regress.hexa — parse both via the existing qforge_telemetry_report (#2477, import/reuse), join per stage, compute Δwall %/Δrss %, flag stages over threshold as REGRESSED (and surface IMPROVED). assert:file stdlib/qforge/telemetry_regress.hexa
- @L2 (complete): handle the real edge cases — a stage present in current but absent in baseline (NEW) · absent in current (DROPPED) · rss null on either side (skip rss-Δ, keep wall-Δ, d6 no fabrication) · zero-baseline-wall guard (no divide-by-zero). Rank regressions by Δ% desc.
- @L3 (safe): READ-only pure function over two JSONL texts — no pod ops, no file mutation, reuse qforge_telemetry_report (d3/d19), 0-diff existing files (separate new module, does NOT edit telemetry_report.hexa).
- @L4 (std): @ci_gate `*_selftest.hexa` idiom — fixture baseline+current JSONL pair, assert: a >threshold stage flagged REGRESSED · a sub-threshold stage NOT flagged · NEW/DROPPED handling · rss-null skip · zero-baseline guard. Paste verdict VERBATIM.
- @L5 (std): demiurge note in domains/QFORGE-PROCESS.log.md — one rendered regression report sample (a baseline vs a slower current) showing the flagged stage. explicit-path commit.

## next-action checklist
- [ ] isolated worktree off origin/main (`~/core/hexa-lang-telem-regress`); HEAD = origin/main (055dd0fb5 or newer, includes #2477)
- [ ] read telemetry_report.hexa (#2477) for the Report shape + its parser to reuse
- [ ] build telemetry_regress.hexa (parse both → join per stage → Δ% → flag → rank)
- [ ] g5 selftest VERBATIM (flagged · not-flagged · NEW/DROPPED · rss-null · zero-guard). HEXA_STDLIB_ROOT="$PWD/stdlib"; keep fixtures small (0.1.0-dispatch alloc ceiling)
- [ ] stacked PR <200 lines · 1 concern · self-merge squash on green
- [ ] demiurge QFORGE-PROCESS.log.md: rendered regression sample. explicit-path commit, Korean msg
- [ ] ship

## completion criteria
- qforge_telemetry_regress lands + g5 PASS · flags a >threshold stage, ignores sub-threshold, handles NEW/DROPPED + rss-null (no fabrication) · PROCESS.log.md shows one rendered regression sample.

## guards
- g8: pod ops via hexa cloud only; gate pods 38943553·38922322 READ-ONLY (this task needs NO pod — fixture JSONL only).
- d6: rss null on either side → skip rss-Δ for that stage, render `null`, never fabricate.
- d9: isolated worktree · explicit paths · sequential commit; hexa-lang PR + demiurge note SEPARATE.
- Sibling FEATURE agent owns stdlib/qforge/realcell_phonon.hexa + the CaH6 path — do NOT touch. Stage only telemetry_regress.hexa + its test + the demiurge note.
- plan-guard "without/remove/fabricat" false-positives EXPECTED; @L are the contract.
