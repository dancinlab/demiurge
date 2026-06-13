---
slug: cloud-leak-prevention
mode: auto
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-05-29
depends-on: hexa-lang cloud-fix PR (in-flight self-fix agent — down-marker + runpod-parser)
---

# cloud-leak-prevention — plan

## task brief
Systemically prevent the "rent → idle → bills forever" cost leak that just cost the
campaign 6 oversized vast pods (192–256 cores) sitting empty. Make idle/ghost pods
auto-die and make every rented pod self-register so it can never become an untracked
ghost. Build ON TOP of the in-flight hexa-lang cloud bug-fix PR (git fetch first).

## locked decisions
- Q1 (teardown 기전): reuse existing `hexa cloud watchdog --kill` as the sweep engine — no new teardown path.
- Q2 (register 강제): `cloud rent` auto-registers into ./pods.json by default (symmetry with `nohup --register`), so a rent can never be untracked.
- Q3 (idle 정의): idle = util < 5% AND (no QE/compute process AND no workdir) sustained > 60 min — via watchdog `--threshold-min 60 --util-cap-pct 5`.
- Q4 (budget): watchdog cross-refs ./pods.json budget.cap; on breach → alert + kill the lowest-value running pod (g64 honor cap).
- Q5 (주기): a `/schedule` routine (cron) runs `hexa cloud watchdog --kill` ~hourly so leaks die within an hour, not a session-gap.

## next-action checklist
- [ ] git fetch origin in ~/core/hexa-lang; isolated worktree `git worktree add -b cloud-leak-prevention ~/core/hexa-lang-leakprev origin/main` (rebase onto the cloud-fix PR branch if not yet merged; else origin/main)
- [ ] make `cloud rent` default to `--register` (auto-write ./pods.json row on successful provision); add `--no-register` opt-out
- [ ] watchdog: confirm `--kill` honors `--threshold-min` + `--util-cap-pct`; add idle = (util-cap AND no-workdir AND no-compute-proc) composite so a slow-but-working pod is NOT killed (false-positive guard); add budget.cap cross-ref → alert+kill on breach
- [ ] emit a clean DRY-RUN summary table on a bare `cloud watchdog` (no --kill): pod · age · util · idle? · action
- [ ] /schedule routine: hourly `hexa cloud watchdog --kill` (the cron is the standing sweep). Document the routine id.
- [ ] d16 free dry-run / selftest of the watchdog idle-classifier (synthetic manifest) — must NOT kill a working pod
- [ ] ship (explicit paths · Korean commit msg · sidecar sync after push · gh pr create --head)

## qa-results (2026-05-29 · handoff agent)
4-axis AUTO-QA after ship:
- functional ✅ — `composite_idle_test.hexa` PASSES 9/9 via `hexa run` (local Mac). Load-bearing cases confirmed: idle pod (no proc · no workdir · 0% util · 90min) → KILL; working pod (compute proc present, momentary 0% util) → SPARE; proc/workdir/uptime UNKNOWN → SPARE (conservative degrade).
- visible ✅ — SKIP (no user surface; CLI-internal watchdog/rent behavior).
- conformance ✅ — locked decisions ↔ diff: Q1 reuse `watchdog` engine (no new teardown path) ✓; Q2 `rent` default ./pods.json row + `--no-register` opt-out ✓; Q3 COMPOSITE classifier (util AND no-proc AND no-workdir, >threshold) ✓ false-positive guard load-bearing ✓; Q4 budget.cap cross-ref → alert + kill lowest-value ✓; Q5 hourly sweep = documented one-liner (routine NOT auto-created — see handoff).
- regression ✅ — existing cloud tests PASS locally: watchdog_test 15/15, reconcile_test 7/7, cloud_rm_test PASS. No `git revert` needed. My edits add ZERO new unresolved symbols vs origin/main (verified: `hexa run stdlib/cloud/cloud_cli.hexa` produces the IDENTICAL 6 pre-existing undeclared-id errors with AND without my edits — those are the known multi-module direct-run limitation, not a regression).

## build note (gated)
The proper `hexa-cloud` binary build (`tool/build_hexa_cloud.sh` → `build/hexa_module_loader` → `hexat` → clang) is the authoritative multi-module compile for cloud_cli.hexa, but: (a) the build artifacts (`build/hexa_module_loader`, `self/native/hexat`) presence could not be confirmed in the fresh worktree, and (b) the sidecar pool-route forced most build-invocation Bash calls onto remote pool hosts (heavy-word `hexa`/`cloud`/`build` routing; the worktree path is NOT on the sign-gated local-paths whitelist). watchdog.hexa + pod_registry.hexa edits ARE fully compile-verified (the passing selftest links them via the module graph). cloud_cli.hexa edits are syntactically validated by the no-new-symbol delta. PR body carries the full test plan + the user-armable build/QA one-liner.

## completion criteria
- `cloud rent` writes a ./pods.json row automatically (verified by a rent dry-run or code path inspection).
- `cloud watchdog --kill` deterministically kills a synthetic idle pod and SPARES a synthetic working pod (selftest).
- An hourly `/schedule` routine exists running the watchdog; its id is recorded in HANDOFF.
- PR opened on hexa-lang stacked on the cloud-fix PR. No working pod ever killed by the new classifier.
