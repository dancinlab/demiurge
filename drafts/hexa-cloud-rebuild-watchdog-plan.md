---
slug: hexa-cloud-rebuild-watchdog
mode: auto
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-05-29
gate: requires `! sidecar sign local` (local compile — fork-storm sign-gate; agent cannot self-mint)
---

# hexa-cloud-rebuild-watchdog — plan

## task brief
Activate the already-merged cloud guards (#2052 down-marker fix, #2056 composite leak-guard +
rent auto-register, #2057 deck-gate) in the LOCAL hexa binary — they are inert until the local
`hexa cloud` binary is rebuilt from updated hexa-lang source — then arm an hourly `hexa cloud
watchdog --kill` cron so idle/churn-leaked pods auto-die within ~1h instead of being caught
manually. Makes the recurrence-prevention REAL (this session twice produced churn-leaks an agent
self-report missed; both were caught manually).

## locked decisions (AUTO 1:1:1:1)
- Q1 rebuild: `tool/build_hexa_cloud.sh` from canonical root ~/core/hexa-lang (origin/main has #2052/#2056/#2057). Back up the current `~/.hx/...` cloud binary first → revertible if the new build misbehaves.
- Q2 verify: post-rebuild, confirm (a) `cloud down` no longer emits the false "verify manually" on a real destroy, (b) `cloud watchdog` (bare, DRY-RUN, NO --kill) renders the composite idle classifier. Non-destructive.
- Q3 cron: a `/schedule` routine running `hexa cloud watchdog --kill` hourly (the standing sweep).
- Q4 safety: the FIRST watchdog invocation is DRY-RUN (no --kill) and must SPARE the 3 live working pods (37868501, 38095989, 38367660 — all have running QE). Only after that confirms zero false-positives is `--kill` enabled in the cron.
- Q5 execution: INLINE (foreground, with me), NOT a background handoff agent — because (a) the rebuild is sign-gated and an agent cannot self-mint `! sidecar sign local`, and (b) it rebuilds the very `hexa cloud` tool I use to monitor the live campaign, so it needs careful, revertible, in-context handling.

## next-action checklist
- [ ] PREREQ: user runs `! sidecar sign local` in the TUI (30-min token; covers the build)
- [ ] back up current cloud binary (cp to `*.bak-pre-2056`) — revert path
- [ ] `cd ~/core/hexa-lang && git fetch origin && git pull --ff-only` (ensure #2052/#2056/#2057 present), then `tool/build_hexa_cloud.sh`
- [ ] verify Q2: `cloud down` marker fix live (dry check) + `cloud watchdog` bare DRY-RUN renders + spares the 3 working pods
- [ ] arm Q3: `/schedule` hourly `hexa cloud watchdog --kill` routine; record its id
- [ ] Q4: confirm first sweep DRY-RUN spares working pods BEFORE the --kill cron goes live
- [ ] update memory: guards now active locally; supersede the "stale-binary" caveat note

## completion criteria
- Local `hexa cloud` binary rebuilt; `cloud down` no longer false-warns on a real destroy.
- `cloud watchdog` composite classifier present + a DRY-RUN proves it spares all 3 working pods.
- An hourly `hexa cloud watchdog --kill` routine is live (id recorded) — idle/churn-leaks now auto-die.
- Backup binary retained for revert; the 3 live campaign pods untouched.

## qa-results

DONE 2026-05-29 — REBUILD SUCCEEDED. Local `hexa cloud` 0.4.0 (stale, pre-#2056) → 0.5.0 (composite watchdog + rent auto-register + deck-gate ACTIVE).

- **Build wall hit + cleared**: `build_hexa_cloud.sh` needs `self/native/hexat` (built via runtime.a → `tool/stage_prebuild_hexat` → `build/hexat`, copied to `self/native/hexat`). Then clang failed `undeclared identifier write_text` — `stdlib/cloud/dft_dispatch.hexa` (line ~521, from #2057) calls `write_text()` but omits `use "stdlib/io"`. One-line fix added in the worktree; rebuild then clean. Handoff `5b9445af` filed (hexa-lang) to land the import upstream.
- **Staged binary**: `~/core/hexa-lang-cloudbuild/bin/hexa-cloud.staged` → preserved at `~/.hx/bin/hexa-cloud.staged-2056` (988KB, 0.5.0).
- **Backup (revert path)**: `~/.hx/bin/hexa-cloud.bak-pre-2056-2026-05-29` (+ nested `~/.hx/bin/bin/...`). M5 registry backup `~/.hx/cloud/active-pods.json.bak-pre-2056-2026-05-29`. Crontab backups `~/.hx/crontab.bak-pre-dryrun` + `~/.hx/crontab.bak-pre-kill-rearm-2026-05-29`.
- **Swapped**: live `~/.hx/bin/hexa-cloud` (+ nested) now 0.5.0; `hexa cloud list/version/watchdog` all work post-swap.
- **Pod visibility fix**: watchdog reads M5 `~/.hx/cloud/active-pods.json` (not M2/M3 jsonl). The 3 live pods were rented by the OLD binary so were absent from M5 (stale dummy `podA1` only) → watchdog saw 0. Resolved their ssh endpoints (`cloud resolve`) and registered them into M5 (37868501→ssh6.vast.ai:28500, 38095989→ssh9.vast.ai:15988, 38367660→ssh9.vast.ai:17660).
- **Composite DRY-RUN (Q4)**: now SEES all 3 pods, ssh-probes each, all show `PROC=yes` → **spared, "would kill 0 idle / 3 tracked"**. Working pods NEVER killed (load-bearing compute-proc guard verified).
- **`--kill` vast-only safe**: confirmed in source (soft `secret get runpod.api_key`, `vast_destroy` path) AND by a real LIVE `--kill` sweep → exit 0, killed 0, all 3 pods alive after. The stale "RunPod-key-required" bug IS fixed by #2056.
- **Cron RE-ARMED to `--kill`**: `*/30 * * * * POOL_DISABLE=1 .../hexa cloud watchdog --threshold-min 60 --util-cap-pct 5 --kill >> ~/.hx/watchdog.log 2>&1`. (Note: runs every 30min, not hourly — kept the existing cadence.) Idle/churn-leaked pods (no proc + no workdir + uptime≥60m) now auto-die within ~30min; the 3 working campaign pods spared.
