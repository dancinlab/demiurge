# 4-agent parallel rate-limit cascade — 2026-05-22

> 4 background agents launched in parallel · ALL rate-limited within ~3.5 min (server-side "temporarily limiting requests · not your usage limit"). 1 of 4 had committed work before kill · 3 of 4 lost.

## Tracks (rate-limit cascade)

| Track | Subject | Tool uses | Duration (s) | Outcome | Salvaged |
|---|---|---|---|---|---|
| 17 | κ-70 G37 Ufo/plasma first-flip | 46 | 213 | killed | ❌ no commit (branch base SHA only) |
| 18 | Bootstrap iter-2a stdarg.h fix | 21 | 172 | killed | ✅ commit `b78e1c71` PR #290 open (pre-kill push) |
| 19 | Bootstrap iter-2b transpiler use audit | 29 | 145 | killed | ❌ no audit note |
| 20 | κ-70 G38 governance row | 28 | 115 | killed | ❌ no commit (demiurge worktree auto-cleaned) |

Total: 124 tool uses / ~10.8 min CPU before all 4 died. Server returned `API Error: Server is temporarily limiting requests (not your usage limit) · Rate limited` for each.

## Salvage actions taken

- **Track 18**: branch + commit `b78e1c71` were already pushed before kill. PR #290 already opened. Verified state · attempted merge but CI red because PR #290 was based on main BEFORE PR #288 (bootstrap.yml Option A) was merged. Therefore stdarg.h fix alone insufficient.
  - Action taken: merged PR #288 first (`45ee2018`). PR #290 needs rebase/refresh to pick up new main; the user can then re-trigger CI to verify Linux Stage 0 GREEN uplift.
- **Track 17 / 19 / 20**: branches + worktrees cleaned up (empty work, no commits worth preserving).

## Lessons (memory candidates)

1. **4-agent parallelism is too much for current server capacity**: prior session ran 3 agents successfully (Tracks 14/15/16 · all completed). 4 simultaneous = consistent rate-limit kill within ~3-4 min.
2. **Recommended pattern**: cap at 2-3 parallel agents · or sequential execution for non-time-critical work.
3. **Pre-kill commit salvage**: Track 18 succeeded because agent committed early (within 21 tool uses · ~2.5 min). Recommend agents commit small atomic units rather than holding work in working tree.

## Re-launch plan (next session)

Sequential (not parallel) re-runs:
- κ-70 G37 first-flip (heaviest · multi-repo)
- Bootstrap iter-2b audit (transpiler use-directive · audit-only)
- κ-70 G38 governance row (code 0)

Each can be a single-track agent run with full 5-min budget.

PR #290 (stdarg.h iter-2a) status check before re-runs: should be GREEN on Linux Stage 0 after PR #288 main rebase. If still RED, file iter-2c issue.

## Anchors

- PR #288 (`e3938aec` → merge commit `45ee2018`) — bootstrap.yml Option A LANDED
- PR #290 — stdarg.h fix · pending rebase onto post-#288 main
- `~/core/demiurge/inbox/notes/2026-05-22-bootstrap-option-a-fix-attempt.md` — Track 14 attempt log
- `~/core/demiurge/inbox/notes/2026-05-22-bootstrap-fix-iteration-2.md` — iter-2a + 2b spec
- `[[feedback-hexa-lang-main-land-via-pr]]` memory — workflow rule
