---
slug: stale-base-guard
mode: auto
status: done
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-05-30
revised: 2026-05-30 (BLOCK → silent AUTO-SYNC per user steer "사용자 무인지 뒤에서 해결")
---

# stale-base-guard — plan (silent auto-sync)

## task brief
Prevent the stale-base governance accident (2026-05-30: local demiurge repo 28
commits behind origin/main → an agent edited a STALE project.tape whose blind
landing would have REVERTED origin governance work). The fix must resolve
SILENTLY in the background so the user/agent never has to notice or act — NOT a
hard block that forces a manual refresh. Mechanism = safe ff-only auto-sync:
keep the repo fresh proactively, and transparently fast-forward a governance
file onto origin at edit-time if it is still stale. Surface ONLY when a real
conflict makes auto-resolve unsafe.

## locked decisions
- @L1 (enforcement): SILENT auto-resolve, NOT block — stale → auto ff to origin, no prompt · assert:grep ff-only
- @L2 (proactive sync): SessionStart (+ bounded periodic) auto `git fetch && git pull --ff-only` when tree clean & ff-possible; upgrade the existing non-blocking "N commits behind" notice into an auto-ff-pull · assert:grep "pull --ff-only"
- @L3 (reactive guard): sign-guard PreToolUse — before a gated-file edit, if `origin/<branch>:<file>` ≠ HEAD:<file> and the file is clean, transparently fetch + `git checkout origin/<branch> -- <file>` (ff that one file) then let the edit apply · assert:grep sign-guard
- @L4 (safety rails): ff-only (NEVER merge-commit/rebase/force); ONLY when working tree clean for the path; SKIP on detached HEAD / mid-rebase / mid-merge / no-origin / untracked · assert:grep !--force
- @L5 (surface budget): happy-path emits NOTHING; surface a single concise line ONLY on a true conflict / non-ff divergence (the rare case auto-resolve can't handle safely) · assert:grep conflict

## next-action checklist
- [ ] Locate sidecar source: the sign-guard PreToolUse hook (emits `sign-guard: ... SIGN-GATED`) AND the SessionStart hook that emits the "로컬 main가 origin/main보다 N커밋 뒤처짐" notice. Probe `sidecar paths`, `~/.claude/plugins/cache/sidecar/`, grep `SIGN-GATED` / `커밋 뒤처짐` / `ff-only`. Find their git repo for the PR.
- [ ] Read both hooks fully. Identify (a) the SessionStart staleness-notice emit point, (b) the sign-guard allow/deny decision point for a gated file.
- [ ] Implement a shared helper `safe_ff_sync(repo, [path])`: resolve default branch + origin; SKIP if no origin / detached / mid-rebase|merge (`.git/rebase-*`, `MERGE_HEAD`); `git fetch origin <branch>` only if FETCH_HEAD older than ~5 min; if working tree clean (or `<path>` clean) AND local is strictly behind (ff-possible) → `git merge --ff-only origin/<branch>` (whole-repo) or `git checkout origin/<branch> -- <path>` (single file); return {synced|skipped|conflict}.
- [ ] Wire PROACTIVE: SessionStart hook calls `safe_ff_sync(repo)` whole-repo (silent on success; the old warning becomes a fallback line ONLY when sync returns conflict/skipped-dirty).
- [ ] Wire REACTIVE: sign-guard, before allowing a gated-file (commons.tape/project.tape) edit, calls `safe_ff_sync(repo, <file>)`; on `synced` proceed silently, on `conflict` emit ONE line + still allow the edit (don't hard-block — but warn it's on a divergent base so the agent re-checks).
- [ ] False-positive guard: never block/sync outside a git repo, no origin, untracked file, or dirty path (dirty path → skip sync, no surface — the user has live edits).
- [ ] Test (sidecar test convention): (a) clean + behind → auto ff, file matches origin, no output; (b) gated-file edit on stale clean base → file ff'd silently then edit applies; (c) dirty divergence / non-ff → single conflict line, no force; (d) no-origin/detached → skip cleanly. Run, paste PASS.
- [ ] Bump sign-guard (+ SessionStart hook) plugin version surfaces (plugin.json · marketplace.json · CHANGELOG) per g22.
- [ ] ship: explicit paths · Korean commit body · `gh pr create` to the sidecar repo · `sidecar sync` after merge

## completion criteria
A stale-but-clean local repo silently fast-forwards to origin at session start and
at governance-edit time, with ZERO user-facing output on the happy path; ff-only +
clean-only + no-force safety rails hold; a genuine non-ff conflict surfaces exactly
one concise line and never force-resolves. Test green. PR merged to the sidecar
repo. `sidecar sync` run so the guard is live next session.
