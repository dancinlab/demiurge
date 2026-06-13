---
slug: parallel-fill-enforce
mode: auto
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-05-29
repo: hexa-lang
governance: project.tape d_parallel_fire (already correct — this makes it ENFORCED, not doc-only)
---

# parallel-fill-enforce — plan

## task brief
project.tape `d_parallel_fire` says: "fire N candidates on PARALLEL pods · ranks≤physcores/pod · one job
per slot · never single-pod sequential queue · split a stuck onstart.sh chain on sight." The RULE is
correct and even names onstart.sh. But it is DOC-ONLY — nothing enforces it at dispatch time, and the
actual deck-dispatch tooling (`run_chain.sh` / `onstart.sh`) emits a SEQUENTIAL per-pod chain (one ph.x
at a time). Evidence (2026-05-29): a 128-core vast pod (38095989) ran only 8 ranks (= 1 deck cabeh8)
while 8+ decks sat idle queued behind it — 15× core underutilization. Manually splitting the chain
(done this session) is fragile and regresses on the next fire. Close the gap with two tooling changes:
- **T1** — fix the deck-dispatch generator so it launches decks CONCURRENTLY up to the pod core budget
  (sum of per-job -np ≤ physcores, OMP/MKL=1), instead of a sequential for-loop. Parallel becomes the
  DEFAULT, no agent vigilance required.
- **T2** — add a guard/check that detects a d_parallel_fire violation (a pod with M queued decks but
  only 1 live ph.x AND spare cores) and reports it + suggests the split. Turns the rule into a gate.

## locked decisions (AUTO 1:1:1:1)
- Q1 scope: BOTH T1 (concurrent-fill dispatch generator) + T2 (violation guard).
- Q2 where: hexa-lang. T1 = the deck-dispatch / onstart-script generator (likely `stdlib/deck/gen.hexa`
  and/or the `hexa cloud dft-run` launch template — DISCOVER the canonical generator first). T2 = a
  `hexa cloud` check subcommand (pod-aware, co-located with dispatch), e.g. `cloud parallel-audit <pod>`.
- Q3 form: T1 — the generated launch plan/script starts decks concurrently (Σ -np ≤ physcores, each
  `mpirun … -np <slot> ph.x` backgrounded, OMP_NUM_THREADS=1), with a wall-time `timeout` cap per job;
  NO sequential `for deck; do …; wait; done` loop. T2 — given a pod's live state (physcores, live ph.x
  rank count, queued/idle deck count), return VIOLATION when (live_jobs==1 AND queued>0 AND
  spare_cores≥ranks_per_job) else OK; emit the concrete split suggestion.
- Q4 verify: `@ci_gate` selftest. T1: given a deck-set + a 128-core pod spec, assert the emitted plan has
  >1 concurrent job AND Σ-np ≤ physcores AND no job oversubscribes. T2: a mock pod (8 ranks / 128 cores /
  9 queued decks) → VIOLATION; a full pod (ranks==physcores) → OK; a single-deck-on-small-pod → OK.
  Paste verdicts VERBATIM (g5).
- Q5 execution: DISCOVERY-FIRST — locate the real `run_chain.sh`/`onstart.sh` generator before editing
  (stdlib/deck/gen.hexa vs hexa cloud dft-run vs hand-written campaign script). Build/test on POOL ubu-1.
  Separate PRs per concern (T1, T2) where they touch different files (g4, <200 lines each). If the
  generator turns out to be hand-written per-campaign (no canonical home), HONESTLY report that and ship
  T2 (the guard) + propose where T1 should live (don't fabricate a generator fix with no home).

## next-action checklist
- [ ] DISCOVERY: grep hexa-lang for the deck-dispatch / chain generator — `stdlib/deck/gen.hexa`, `hexa cloud dft-run`, run_chain.sh/onstart.sh emit sites. Identify the canonical home (or report none).
- [ ] T1: rewrite the launch emission to concurrent-fill (Σ-np ≤ physcores · OMP=1 · per-job timeout · background + record pids), replacing the sequential loop. d4 generic — driven by (physcores, decks, ranks-per-deck), no hardcoding.
- [ ] T1 @ci_gate selftest: 128-core + 9 decks → plan is concurrent (>1 job, Σnp≤cores, no oversub); tiny pod / 1 deck → still correct.
- [ ] T2: add `hexa cloud parallel-audit <pod>` (or equivalent) — detect single-slot-chain-with-spare-cores violation, print split suggestion. d4 generic.
- [ ] T2 @ci_gate selftest: mock(8/128/9-queued)→VIOLATION · full pod→OK · single-small→OK. Verbatim.
- [ ] build+run both selftests on ubu-1 (repo-hexa_v2 + clang workaround if installed hexa_v2 segfaults); paste verdicts.
- [ ] ship: separate PR(s) hexa-lang, <200 lines each, Korean commit, gh pr create, verify MERGED, sidecar sync.
- [ ] regression: existing deck/cloud selftests GREEN; no behavior change for already-parallel/full-pod paths.

## completion criteria
- T1: the deck-dispatch generator emits a CONCURRENT-fill launch (multiple ph.x up to physcores, OMP=1,
  per-job timeout) — the sequential per-pod chain is gone; selftest proves >1 concurrent job + no oversub.
- T2: a `hexa cloud` check flags the single-slot-chain-with-spare-cores violation + suggests the split;
  selftest proves VIOLATION vs OK on mock pod states.
- Both selftests PASS (verbatim). PR(s) merged. No regression. If T1 has no canonical generator home,
  that is reported honestly and T2 still ships.

## qa-results
