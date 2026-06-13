---
slug: qforge-process-telemetry-cli
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated
domain: QFORGE-PROCESS (demiurge)
---

## task brief
The PROCESS telemetry library (report #2477 · regress #2483 · rollup #2487) is callable only from .hexa
code. Expose it as a CLI so a human can run it over a harvested deck dir: `hexa qforge telemetry
report <deck>` (ranked bottleneck), `... regress <baseline-deck> <current-deck>`, `... rollup
<deck1> <deck2> ...`. This is the last clean PROCESS piece — makes the whole observability stack usable
from the command line over real `.dft_telemetry.jsonl` files.

## locked decisions
- @L1 (complete): add a `telemetry` subverb to the qforge CLI (stdlib/qforge/qforge_cli.hexa) — `report <deck>` reads `<deck>/.dft_telemetry.jsonl` → qforge_telemetry_report render · `regress <base> <cur>` → qforge_telemetry_regress render · `rollup <deck...>` → qforge_telemetry_rollup render. assert:grep telemetry
- @L2 (complete): read the deck-local `.dft_telemetry.jsonl` from each arg dir; missing/empty file → a clean message (e.g. "no telemetry in <deck>"), not a crash (d6 — no fabricated report). Exit non-zero on usage error, zero on success.
- @L3 (safe): READ-only CLI — reuses the verified report/regress/rollup fns (d3/d19), no pod ops, no mutation. 0-diff to telemetry_report/regress/rollup.
- @L4 (std): g5 — extend the qforge_cli selftest (or focused): report/regress/rollup verbs each produce the expected rendered output over a fixture deck-dir; missing-file clean message; usage error exits non-zero. Paste VERBATIM.
- @L5 (std): demiurge note in domains/QFORGE-PROCESS.log.md — the CLI usage + one real `hexa qforge telemetry report` sample. explicit-path commit.

## next-action checklist
- [ ] worktree off origin/main (`~/core/hexa-lang-telem-cli`); HEAD = origin/main (a2b58b6f2 or newer)
- [ ] read qforge_cli.hexa (the verb dispatch pattern) + telemetry_report/regress/rollup signatures
- [ ] add the `telemetry` subverb (report/regress/rollup) reading deck-local .dft_telemetry.jsonl
- [ ] g5 selftest VERBATIM (3 verbs render · missing-file clean · usage error). HEXA_STDLIB_ROOT="$PWD/stdlib"
- [ ] stacked PR <200 lines · 1 concern · self-merge on green
- [ ] demiurge QFORGE-PROCESS.log.md CLI note + sample. explicit-path commit, Korean msg
- [ ] ship

## completion criteria
- `hexa qforge telemetry {report|regress|rollup}` works over real deck dirs · missing-file clean message · g5 PASS · PROCESS.log.md CLI sample. The observability stack is now CLI-usable end-to-end.

## guards
- g8: pod ops via hexa cloud only; gate pods 38943553·38922322 READ-ONLY (no pod — reads local files).
- d6: missing telemetry → clean message, never fabricate.
- d9: isolated worktree · explicit paths · separate hexa-lang PR + demiurge note.
- Sibling agents: a5cf752 owns assembler.hexa, a5863333 owns elph_offdiag.hexa. Stage ONLY qforge_cli.hexa + its test + the demiurge note. Import (not edit) telemetry_report/regress/rollup.
- plan-guard "without/remove/fabricat" false-positives EXPECTED; @L are the contract.
