---
slug: deck-parallel-separate-pods
mode: auto
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-05-30
repo: hexa-lang
risk: MEDIUM — deck-gen default orchestration change; must not break existing deck emit / selftest
---

# deck-parallel-separate-pods — plan

## task brief
The RTSC deck generator (hexa-lang `stdlib/deck/rtsc.hexa`, wired to `stdlib/cloud/fill_plan.hexa`
via #2110) emits a CONCURRENT-FILL launch block by default — `dft_fill_plan_disk(...)` packs
MULTIPLE decks onto ONE pod (core+disk budgeted). That is the d_parallel_fire FALLBACK ("split a
stuck single-pod chain onto concurrent slots"), NOT the PRIMARY directive. project.tape
d_parallel_fire's 1순위 is explicit: "fire N candidates on PARALLEL pods" + "split a chain onto
parallel pods on sight" + dont "queue a candidate behind another when fresh parallel capacity is
rentable (d17)". So the deck-gen default embodies the half-fix: it cured the worst case (sequential
`for deck; do run; wait` chain) but stops at one-pod-multi-deck instead of separate-pods-per-candidate.
Promote separate-pods to the DEFAULT; demote fill_plan concurrent-fill to an EXPLICIT opt-in fallback
(only when fresh capacity is genuinely not rentable / operator forces pod-sharing).

## locked decisions (AUTO 1:1:1:1)
- Q1 scope: the deck-gen DEFAULT runbook/launch emission = one-candidate-per-pod (each candidate its
  own pod, ONE el-ph job/pod, ranks=physcores, OMP=MKL=1, scratch isolated). fill_plan multi-deck
  concurrent-fill stays in-tree but becomes EXPLICIT opt-in (spec flag e.g. `pack_one_pod=true`, or
  a clearly-labeled "FALLBACK — only when you cannot rent fresh pods" runbook section). Do NOT delete
  fill_plan — it's the correct tool for the genuine can't-rent-more case.
- Q2 root home (DISCOVERY-FIRST): grep rtsc.hexa + dft_dispatch.hexa + fill_plan.hexa to find exactly
  where the one-pod-multi-deck default is decided. If the orchestration choice lives in the DISPATCH
  layer (dft_dispatch.hexa) → fix the default there. If it's only the RUNBOOK text in rtsc.hexa → fix
  the emitted runbook to lead with separate-pods + governance note citing d_parallel_fire, with the
  fill_plan block moved under an explicit fallback heading. Likely BOTH (runbook wording + a default flag).
- Q3 safety: keep the §4c resume-aware + real-terminal per-deck driver (#2113) UNCHANGED — it's per
  candidate and correct. Keep the disk-aware fill_plan_disk math UNCHANGED. The change is which path
  is DEFAULT vs opt-in, plus runbook framing — not the per-deck content. An existing deck-gen selftest
  must still pass; add a selftest asserting the default emit is separate-pods (single-job-per-pod) and
  that the fill_plan path is reachable only via the explicit flag.
- Q4 verify: `hexa run` the deck-gen selftest (or a focused emit test) — default emit shows one job per
  pod (no DECKS=(...) multi-deck loop in the default path) AND the fill_plan opt-in still emits the
  concurrent-fill when the flag is set. Paste the selftest verdict VERBATIM (g5). Regression: a normal
  `/deck rtsc <slug> '<spec>'` still produces vc-relax/scf/ph + the resume driver unchanged.
- Q5 execution: canonical root `~/core/hexa-lang`. git fetch origin first; branch off origin/main
  (shared worktree — 30+ agents, land via `gh pr create --head`, never local FF). Korean commit body,
  English code. Stay <200 LOC, 1 logical change (g4). `sidecar sync` after push. If a Mac heavy
  rebuild is needed for the selftest, note the sign-gate; if the change is pure stdlib `.hexa` that
  `hexa run` can selftest without a full rebuild, just run it.

## next-action checklist
- [ ] DISCOVERY: grep `stdlib/deck/rtsc.hexa` + `stdlib/cloud/dft_dispatch.hexa` + `stdlib/cloud/fill_plan.hexa`
      for where one-pod-multi-deck is the default; identify the minimal change site.
- [ ] make separate-pods (one candidate = one pod, single job) the DEFAULT emit/runbook path.
- [ ] demote fill_plan concurrent-fill to EXPLICIT opt-in (spec flag `pack_one_pod` or fallback section),
      with a runbook note citing d_parallel_fire (1순위 = parallel pods; pack-one-pod = fallback only).
- [ ] add/extend a selftest: default emit = single-job-per-pod; opt-in flag = fill_plan concurrent block.
- [ ] `hexa run` the selftest → paste verdict VERBATIM (g5). Regression: normal deck emit unchanged.
- [ ] ship PR (hexa-lang, `gh pr create --head`, Korean commit, English code, <200 LOC, sidecar sync).
- [ ] update sidecar handoff if a follow-up (e.g. dispatcher auto-rent-N-pods) is deferred.

## qa-results
- PR: https://github.com/dancinlab/hexa-lang/pull/2125 — MERGED (origin/main 845d56782).
- change site: `stdlib/deck/rtsc.hexa` `_rtsc_fill_launch_block` → `pack_one_pod` 플래그 디스패처.
  기본(false) `_rtsc_separate_pods_block` (PRIMARY, §4b SEPARATE-PODS) · opt-in(true)
  `_rtsc_pack_one_pod_block` (FALLBACK, §4b-fallback CONCURRENT-FILL, fill_plan_disk 그대로).
- selftest: `test/deck_orchestration_selftest.hexa` (new). `hexa run` verdict VERBATIM:
  ```
  ## DEFAULT emit (no flag) — expect SEPARATE-PODS (d_parallel_fire 1순위)
    PASS  §4b header = SEPARATE-PODS
    PASS  cites d_parallel_fire 1순위
    PASS  후보 1개 = pod 1개 contract present
    PASS  NO multi-deck DECKS=( loop in default path
    PASS  default does NOT emit the CONCURRENT-FILL fallback heading
    PASS  §4c run_resume.sh driver UNREGRESSED (#2113)
  ## OPT-IN emit (pack_one_pod=true) — expect CONCURRENT-FILL FALLBACK
    PASS  §4b-fallback CONCURRENT-FILL heading present
    PASS  labeled FALLBACK
    PASS  fill_plan multi-deck DECKS=( loop IS emitted
    PASS  opt-in does NOT emit the separate-pods header
    PASS  §4c run_resume.sh driver still present in opt-in path
  __DECK_ORCHESTRATION_SELFTEST__ PASS
  ```
- regression: `hexa run test/deck_gen_smoke.hexa` → `__DECK_GEN_SMOKE__ DONE` (4 RTSC prototype
  + 5 domain emit clean). vc-relax/scf/ph emitter 미변경 · §4c resume driver + fill_plan disk math 그대로.
- deferred: 디스패처 auto-rent-N-pods → sidecar handoff `22486f26` (hexa-lang).

## completion criteria
- deck-gen DEFAULT emits one-candidate-per-pod (single el-ph job/pod, ranks=physcores, scratch isolated)
  AND fill_plan multi-deck concurrent-fill is reachable only via an explicit opt-in flag/section AND a
  deck-gen selftest PASSES (pasted verbatim) AND a normal deck emit is unregressed. PR landed on hexa-lang.
- HARD: do not delete fill_plan (valid fallback). Do not touch the §4c resume driver or the disk math.
  If the proper fix needs a dispatcher auto-rent-N-pods feature beyond a <200 LOC change, ship the
  deck-gen-default + runbook part now and file the dispatcher piece as a sidecar handoff.
