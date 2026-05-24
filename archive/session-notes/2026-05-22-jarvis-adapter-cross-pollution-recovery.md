# JARVIS adapter cross-pollution recovery note

> Date: 2026-05-22
> Trigger: Phase 2 ext follow-on JARVIS-OPTIMADE adapter agent (`a7fc44a7ae15ea31c`) completed Exit α. demiurge side LANDED (`c2ccd17a`). **hexa-lang side cross-polluted** — commit `a68d3ac1` landed on `dfflibmap-sky130-reset-flop-variants-2026-05-22` branch (concurrent agent's branch) instead of `main`.

## What happened

1. Agent committed JARVIS adapter to isolated worktree `~/core/hexa-lang-jarvis` on branch `phase2-jarvis-adapter-2026-05-22` at commit `d3a3f8e8`.
2. Worktree + branch cleanup ran successfully via `git worktree remove` + `git branch -D`.
3. Cherry-pick attempted from `~/core/hexa-lang` main worktree using `git cherry-pick d3a3f8e8`.
4. **Main worktree's HEAD had been silently switched** to `dfflibmap-sky130-reset-flop-variants-2026-05-22` branch (by a concurrent agent · matches the `feedback_hexa_lang_concurrent_agents` memory pattern).
5. Cherry-pick produced new commit `a68d3ac1` ON THAT branch (NOT main). The content (JARVIS adapter +143/-4 in `stdlib/material/cross_code_dft.py`) is correct, only the branch parent is wrong.
6. Recovery via `git checkout main` failed: `fatal: 'main' is already used by worktree at '/Users/ghost/core/hexa-lang/.claude/worktrees/agent-afeb2bb7643b71ee6'`. That locked worktree has main at `f618bb96` with **10+ staged `A` files** (concurrent agent's mid-commit speckit work).
7. Per `[[feedback-hexa-lang-concurrent-agents]]` memory rule, don't fix someone else's branch. File this note instead.

## State at recovery-note land

| Repo | State |
|---|---|
| demiurge main | `c2ccd17a` LANDED — RTSC.md §9.9.1 Phase progress table row says Phase 2 ext follow-on ✅ LANDED + audit note `2026-05-22-rtsc-9-phase2-jarvis-rerun.md` cites 20/20 PASS |
| hexa-lang main | `f618bb96` — **JARVIS adapter NOT here** |
| hexa-lang `dfflibmap-sky130-reset-flop-variants-2026-05-22` | `a68d3ac1` (= cherry-pick of `d3a3f8e8`) — JARVIS adapter HERE, but wrong-branch |
| hexa-lang `agent-afeb2bb7643b71ee6` worktree | main at `f618bb96` with 10+ A-staged speckit files (concurrent agent mid-commit) |

## Cross-check: demiurge side claim vs hexa-lang reality

The demiurge audit note `2026-05-22-rtsc-9-phase2-jarvis-rerun.md` cites the hexa-lang adapter at SHA `d3a3f8e8` (which exists as ancestor of `a68d3ac1` in the orphan branch). The 20-cell rerun records at `/tmp/phase2-jarvis-rerun/` were emitted by the adapter via the isolated worktree run, so the 20/20 PASS claim is empirically valid — but the adapter code is **not yet on hexa-lang main**.

R4 invariant: 0/20 records absorbed=true confirmed during rerun. Cross-pollution does NOT affect record-level honesty.

## Recovery path for next session

When the locked `agent-afeb2bb7643b71ee6` worktree is released (concurrent agent finishes their speckit commit OR worktree is force-removed after they're idle):

```
# Option A: cherry-pick a68d3ac1 to main
cd /Users/ghost/core/hexa-lang   # or wherever main becomes available
git checkout main
git cherry-pick a68d3ac1

# Option B: if a68d3ac1 has drifted (other agent rebased the dfflibmap branch),
# pull the commit content via SHA → git cat-file -e a68d3ac1 first to verify it still exists

# Option C: re-run the adapter agent on a fresh branch from current main
# (simplest if a68d3ac1 is gone)
```

After cherry-pick lands on hexa-lang main, demiurge needs no follow-up — `c2ccd17a` already documents the state.

## Recommendation for the dfflibmap branch owner

The `dfflibmap-sky130-reset-flop-variants-2026-05-22` branch owner (some concurrent agent doing RFC 006 §5 Path-c dffe variant work) will see `a68d3ac1` appear in their branch. They have two options:
- Keep it (JARVIS adapter is additive, no conflict expected with dfflibmap work)
- Rebase it out via `git rebase -i` to drop `a68d3ac1` from their branch (cleaner separation)

Either way, this note serves as the audit record explaining how `a68d3ac1` landed there.

## Why this happened (root cause)

The hexa-lang main worktree at `/Users/ghost/core/hexa-lang` is shared with concurrent automated agents who switch branches and stage files during normal work. The branch switch from `main` → `dfflibmap-sky130-reset-flop-variants-2026-05-22` happened between the time I read `git status` (which showed main) and the time I executed the cherry-pick. No way to atomically prevent this without holding a lock the harness doesn't provide.

Per memory rule: combine `git add && git commit` to avoid wrong-branch landings. The same hazard applies to `git checkout main && git cherry-pick` sequences. Recommended pattern for future sessions: explicit `git -C <isolated-worktree-path>` for ALL operations, never operate in the shared main worktree.

## Anchors

- demiurge commit `c2ccd17a` (audit + RTSC row flip · 20/20 PASS empirical claim)
- demiurge audit note `2026-05-22-rtsc-9-phase2-jarvis-rerun.md` (5×4 matrix detail)
- hexa-lang commit `a68d3ac1` (orphan on dfflibmap branch · JARVIS adapter content)
- `~/.claude/projects/-Users-ghost-core-demiurge/memory/feedback_hexa_lang_concurrent_agents.md` (memory rule)
- `/tmp/phase2-jarvis-rerun/` (20-cell empirical records)

## Closure (2026-05-22)

RESOLVED — hexa-lang main now has JARVIS adapter at `513bed75` (merged into `main` via PR #287, merge commit `c6c6e9a3` on `origin/main`). Cross-pollution gap closed. **Plan B used** (fresh worktree `~/core/hexa-lang-jarvis-rescue` from `main@0a5a5e7f` + `git cherry-pick a68d3ac1` → `513bed75` · clean, no conflicts).

Why Plan B over Plan A: shared `~/core/hexa-lang` main worktree was STILL on `dfflibmap-sky130-reset-flop-variants-2026-05-22` (not released) and `main` is checked out across many locked agent worktrees, so direct `git checkout main` in the shared worktree was blocked. Fresh dedicated worktree isolated the operation.

Why PR (not local FF): local `git push . HEAD:main` rejected (`receive.denyCurrentBranch` — main is checked out in locked agent worktrees). Per safety protocol cannot modify git config. Routed the FF via `origin/main` instead — `gh pr merge --merge` produced merge commit `c6c6e9a3` on remote main. Local `refs/heads/main` (currently `0a5a5e7f` in the shared repo) will FF on next `git fetch && git merge --ff-only origin/main` when the locked worktrees release.

Equivalence verification: `git diff a68d3ac1 513bed75 -- stdlib/material/cross_code_dft.py` showed only two pre-existing main-side docstring example-formula differences (`Pb10Cu(PO4)6O` → `Ca10(PO4)6F2`); the JARVIS adapter code itself is byte-identical to the orphan.

Smoke (rescue worktree):
- `YBa2Cu3O7` → `gate_type=simulation-only-prediction`, n=3 (mp_cache, oqmd, **jarvis**), consensus = -2.0849 ± 0.0289 eV/at
- `H3S` → `gate_type=simulation-only-prediction`, n=3 (mp_cache, oqmd, **jarvis**), consensus = 0.0221 ± 0.1775 eV/at
- `absorbed=false` on both (R4 invariant intact)

Honest audit trail preserved. The `dfflibmap-sky130-reset-flop-variants-2026-05-22` branch (original orphan location) was not touched — per owner-of-branch rule.
