---
slug: qforge-process-telemetry-report
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated
domain: QFORGE-PROCESS (demiurge domains/)
---

## task brief
PR#2474 made dft-run EMIT `.dft_telemetry.jsonl` (one line per stage transition · wall+rss).
Close the PROCESS loop: build the ANALYZER that INGESTS that JSONL and produces a per-stage
bottleneck report — wall + peak-RAM aggregated per stage, slowest stage flagged, so the
domain's @goal ("improvement levers are found") is met without manual eyeballing.

## locked decisions
- @L1 (complete): hexa-native analyzer `qforge_telemetry_report(jsonl_text) -> Report` in stdlib/qforge (e.g. telemetry_report.hexa) — parse the 6-key JSONL lines (ts·stage·event·wall_s·rss_kb·exit), pair start/done per stage, aggregate wall + peak rss per stage. assert:file stdlib/qforge/telemetry_report.hexa
- @L2 (complete): emit a ranked bottleneck table — stages sorted by wall descending, %-of-total per stage, the slowest flagged; peak-rss column with `null` passthrough (d6 — never fabricate a missing rss). cover the realistic stage set (relax · scf · ph:q1..qN · lambda).
- @L3 (safe): READ-only analyzer — pure function over JSONL text, NO pod ops, NO file mutation of the source. Reuse any existing hexa JSON/number helpers (d3/d19); 0-diff existing files.
- @L4 (std): match the existing qforge selftest idiom (@ci_gate `*_selftest.hexa`) — fixture JSONL string in the test, assert parsed wall/rank/total + a malformed-line guard + an unpaired-event guard.
- @L5 (complete): g5 — `qforge_telemetry_report_selftest` @ci_gate PASS: well-formed parse · per-stage wall sum · bottleneck = max-wall stage · rss null passthrough · malformed/unpaired guards. Paste verdict VERBATIM.
- @L6 (std): a tiny demiurge-side note in domains/QFORGE-PROCESS.log.md showing one real report rendered from the PR#2474 ingest row (closes emit→analyze loop end-to-end).

## next-action checklist
- [ ] isolated worktree off origin/main (`~/core/hexa-lang-telem-report`); confirm HEAD = origin/main (currently 40abe986a)
- [ ] build qforge_telemetry_report.hexa (parse → pair → aggregate → rank)
- [ ] g5 selftest VERBATIM (parse · sum · bottleneck · rss-null · guards) — use HEXA_STDLIB_ROOT="$PWD/stdlib" to test unmerged stdlib (known: hexa run resolves use from install root)
- [ ] stacked PR <200 lines · 1 concern · self-merge squash on g5 green
- [ ] demiurge: append a rendered report sample to domains/QFORGE-PROCESS.log.md (explicit-path commit, Korean msg)
- [ ] ship

## completion criteria
- qforge_telemetry_report lands + g5 PASS · ingests .dft_telemetry.jsonl → ranked per-stage wall/RAM bottleneck table · rss `null` passthrough (no fabrication) · PROCESS.log.md shows one rendered report.

## guards
- g8: pod ops via hexa cloud only; LIVE gate pods (current 38943553·38922322, NOT the stale 38704336/38773054) READ-ONLY — this task needs NO pod (fixture JSONL only).
- d9: isolated worktree · explicit paths · sequential commit. cross-repo hexa-lang PR + demiurge note = SEPARATE commits.
- d6: missing rss → `null` in the report, never a fabricated number.
- plan-guard "without/remove/fabricat" word-match false-positives EXPECTED; @L are the contract.
- Do NOT touch the sibling FEATURE agent's files (it owns stdlib/qforge/elph.hexa + metallic α²F path). Stage only telemetry_report.hexa + its test + the demiurge note.
