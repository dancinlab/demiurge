---
slug: qforge-process-telemetry-rollup
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated
domain: QFORGE-PROCESS (demiurge)
---

## task brief
PROCESS has emit (#2474) → analyze (#2477) → regress (#2483). Add the campaign-wide ROLLUP:
ingest MULTIPLE decks' .dft_telemetry.jsonl at once and produce a cross-deck bottleneck dashboard —
which STAGE (relax/scf/ph:qN/lambda) dominates wall across the whole campaign, and which DECK is the
slowest, so the campaign-level improvement lever is visible (not just per-deck).

## locked decisions
- @L1 (complete): build `qforge_telemetry_rollup(deck_jsonls: list of (deck_name, jsonl_text)) -> RollupReport` in stdlib/qforge/telemetry_rollup.hexa — reuse qforge_telemetry_report (#2477) per deck, aggregate: per-STAGE total wall across all decks (which stage class dominates campaign-wide) + per-DECK total wall (slowest deck) + grand total. assert:file stdlib/qforge/telemetry_rollup.hexa
- @L2 (complete): render two ranked tables — (1) stage-class rollup (scf vs ph vs relax vs lambda, %-of-campaign-wall, slowest flagged), (2) per-deck rollup (slowest deck flagged). rss aggregated where present; `null` passthrough (d6 no fabrication). Handle a deck with malformed/empty telemetry (skip + count, no crash).
- @L3 (safe): READ-only pure function over a list of JSONL texts — no pod ops, reuse qforge_telemetry_report (d3/d19), 0-diff existing files (separate NEW module, does NOT edit telemetry_report/regress).
- @L4 (std): @ci_gate `*_selftest.hexa` — fixture of 3 decks' JSONL, assert: stage-class rollup sums correct + dominant stage flagged · per-deck rollup + slowest deck flagged · malformed-deck skipped + counted · empty list → 0 rows. Paste VERBATIM.
- @L5 (std): demiurge note in domains/QFORGE-PROCESS.log.md — one rendered rollup sample over ≥2 deck fixtures. explicit-path commit.

## next-action checklist
- [ ] worktree off origin/main (`~/core/hexa-lang-telem-rollup`); HEAD = origin/main (includes #2477)
- [ ] read telemetry_report.hexa (#2477) Report shape + parser to reuse
- [ ] build telemetry_rollup.hexa (per-deck report → stage-class agg + per-deck agg + rank)
- [ ] g5 selftest VERBATIM (stage rollup · per-deck rollup · malformed skip · empty). HEXA_STDLIB_ROOT="$PWD/stdlib"; small fixtures (0.1.0-dispatch alloc ceiling)
- [ ] stacked PR <200 lines · 1 concern · self-merge on green
- [ ] demiurge QFORGE-PROCESS.log.md rollup sample. explicit-path commit, Korean msg
- [ ] ship

## completion criteria
- qforge_telemetry_rollup lands + g5 PASS · cross-deck stage + per-deck bottleneck tables · rss null passthrough · malformed-deck skip · PROCESS.log.md shows a rendered rollup over ≥2 decks.

## guards
- g8: pod ops via hexa cloud only; gate pods 38943553·38922322 READ-ONLY (no pod — fixture JSONL only).
- d6: rss null → passthrough, never fabricate.
- d9: isolated worktree · explicit paths · separate hexa-lang PR + demiurge note.
- Sibling agents: a5cf752 owns assembler.hexa; the FEATURE agent owns realcell_qmesh.hexa. Stage ONLY telemetry_rollup.hexa + its test + the demiurge note. Do NOT edit telemetry_report/regress (import them).
- plan-guard "without/remove/fabricat" false-positives EXPECTED; @L are the contract.
