---
slug: qforge-process-harvest-autowire
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated
domain: QFORGE-PROCESS (demiurge)
---

## task brief
PROCESS has the library (emit #2474 · analyze #2477 · regress #2483 · rollup #2487) but it is invoked
by hand. Close the loop into the LIVE pipeline: when dft-run reaches a terminal stage (harvest path),
auto-run the analyzer over the deck's `.dft_telemetry.jsonl` and write a `.dft_bottleneck.txt`
(ranked per-stage wall/RSS) next to it — so every campaign run self-surfaces its bottleneck with no
manual call.

## locked decisions
- @L1 (complete): in stdlib/cloud/dft_dispatch.hexa, at the terminal/harvest point (where the chain finishes a deck), call qforge_telemetry_report over the deck's `.dft_telemetry.jsonl` (if present) and write the rendered ranked bottleneck table to `<deck>/.dft_bottleneck.txt`. assert:grep dft_bottleneck
- @L2 (complete): ADDITIVE + guarded — if `.dft_telemetry.jsonl` is absent/empty (pre-#2474 runs), emit nothing + no error (skip cleanly). Existing dispatch behavior byte-identical otherwise; `.dft_stage` + the chain untouched (regression-pinned).
- @L3 (safe): no pod ops in THIS task beyond the in-pod write that the existing chain already does on the remote; no live-pod touch from the agent side. Reuse qforge_telemetry_report (#2477, d3/d19), 0-diff to telemetry_report/regress/rollup.
- @L4 (std): g5 — extend dft_dispatch_test (or focused selftest): terminal-with-telemetry → .dft_bottleneck.txt written w/ correct ranked content · terminal-without-telemetry → no file, no error · existing chain 0-diff regression. Paste VERBATIM.
- @L5 (std): demiurge note in domains/QFORGE-PROCESS.log.md — the auto-wire described + a sample auto-generated .dft_bottleneck.txt. explicit-path commit.

## next-action checklist
- [ ] worktree off origin/main (`~/core/hexa-lang-harvest-autowire`); HEAD = origin/main (7e5fbb02b or newer)
- [ ] locate the dft_dispatch.hexa terminal/harvest site (where a deck chain finishes) + how it writes deck-local files
- [ ] wire qforge_telemetry_report over .dft_telemetry.jsonl → .dft_bottleneck.txt (guarded skip if absent)
- [ ] g5: terminal-with/without-telemetry + chain 0-diff regression. VERBATIM. HEXA_STDLIB_ROOT="$PWD/stdlib"
- [ ] stacked PR <200 lines · 1 concern · self-merge on green
- [ ] demiurge QFORGE-PROCESS.log.md note + sample. explicit-path commit, Korean msg
- [ ] ship

## completion criteria
- dft-run auto-writes `.dft_bottleneck.txt` (ranked per-stage) on terminal when telemetry exists, cleanly skips when absent · g5 PASS · chain byte-identical · PROCESS.log.md note + sample. The PROCESS library is now LIVE-wired (no manual call).

## guards
- g8: pod ops via hexa cloud only; live gate pods 38943553·38922322 READ-ONLY. The auto-wire only adds a deck-local file write inside the existing remote chain (no new pod, no teardown).
- d6: missing telemetry → skip + emit nothing, never fabricate a report.
- d9: isolated worktree · explicit paths · separate hexa-lang PR + demiurge note.
- Sibling agents: a5cf752 owns assembler.hexa (GPU bench), ab8d905 owns realcell_qmesh.hexa. dft_dispatch.hexa is FREE. Stage ONLY dft_dispatch.hexa + its test + the demiurge note. Import (not edit) telemetry_report.hexa.
- plan-guard "without/remove/fabricat" false-positives EXPECTED; @L are the contract.
