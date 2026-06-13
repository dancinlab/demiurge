---
slug: qforge-process-stage-telemetry
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated
domain: QFORGE-PROCESS (demiurge domains/)
---

## task brief
Make the QFORGE-PROCESS domain REAL: dft-run currently exposes only a coarse `.dft_stage`
single-string marker, so pipeline observability is manual pod-probe. Add STRUCTURED per-stage
telemetry — one JSONL line per stage transition carrying wall-seconds + peak RAM — that the
QFORGE-PROCESS domain can ingest to find perf/resource/speed bottlenecks (the domain's @goal).

## locked decisions
- @L1 (complete): emit a JSONL stage-transition log on the pod — `<deck>/.dft_telemetry.jsonl`,
  one line per transition `{"ts":<unix>,"stage":"relax|scf|ph:q<N>","event":"start|done","wall_s":<n>,"rss_kb":<n>,"exit":<code>}` · assert:grep dft_telemetry
- @L2 (complete): cover ALL stages — vc-relax · scf · each ph q-point · final lambda/Tc — not just the coarse `.dft_stage` string. wall = monotonic clock delta; rss = /proc self peak or `ps -o rss`.
- @L3 (safe): ADDITIVE only — keep `.dft_stage` byte-identical (existing watchers read it); telemetry is a NEW sibling file, opt-in, no behavior change to the relax/scf/ph chain. assert:grep !remove
- @L4 (std): match the existing dft_dispatch emit idiom (the same shell-heredoc that writes `.dft_stage` / detach logs) — no new dependency, hexa-native string assembly.
- @L5 (complete): a `copy-from` harvest of `.dft_telemetry.jsonl` + a tiny demiurge-side ingest note in QFORGE-PROCESS.log.md showing one real parsed stage row (proves the loop closes).
- @L6 (std): g5 — extend `dft_dispatch_test` (or add a focused selftest) covering: telemetry line well-formed JSON · all stages present in a simulated chain · `.dft_stage` regression byte-identical. Paste verdict VERBATIM.

## next-action checklist
- [ ] isolated worktree off origin/main (`~/core/hexa-lang-proc-telemetry`); confirm HEAD = origin/main
- [ ] locate the dft_dispatch.hexa stage-write sites (where `.dft_stage` is written per stage)
- [ ] add the JSONL telemetry emit alongside each stage write (start+done, wall+rss)
- [ ] g5 selftest — JSON well-formed · all stages · `.dft_stage` 0-diff regression — VERBATIM
- [ ] stacked PR <200 lines · 1 concern · self-merge squash on g5 green
- [ ] hx install (sync), then on a LIVE gate pod (38943553/38922322, READ-ONLY) confirm `.dft_telemetry.jsonl` appears on the NEXT stage transition (do NOT --resume/--detach a running pod)
- [ ] demiurge: append one real parsed telemetry row to domains/QFORGE-PROCESS.log.md (closes the ingest loop)
- [ ] ship

## completion criteria
- dft-run emits `.dft_telemetry.jsonl` (1 line/stage transition · wall+rss) · g5 PASS · `.dft_stage` byte-identical · QFORGE-PROCESS.log.md shows one real ingested row.
- HONEST scope (d6): if peak-RSS is unavailable on a stage, emit `rss_kb:null` rather than fabricate. Live-pod confirmation may be deferred if no transition fires this window — note it, don't fake it.

## guards
- g8: all pod ops via `hexa cloud` (never raw ssh/scp). LIVE gate pods 38943553·38922322 are READ-ONLY — never --resume/--detach/down them.
- d9: isolated worktree · stage explicit paths only · sequential commit.
- plan-guard advisory false-positives on "without/remove/fabricate" word-match are EXPECTED; this plan's @L are the contract.
