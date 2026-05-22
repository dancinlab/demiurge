# 2026-05-22 — hexa-lang chronic-silent-wipe audit + wipe-guard strengthening proposal

**Scope**: hexa-lang origin/main · 11 silent-wipes documented through 2026-05-22.
**Status**: AUDIT + PROPOSAL ONLY · no destructive change · no hexa-lang push.
**Author**: demiurge audit agent (worktree=main · single commit).
**Companion**: `~/core/hexa-lang/inbox/notes/2026-05-22-wipe-guard-strengthen-proposals.md` (hexa-lang side · file-only, not pushed).
**Pattern memory**: `project-hexa-lang-recurring-wipes` · `feedback_hexa_lang_concurrent_agents` · `feedback_hexa_lang_shared_worktree_branch_hazard`.

---

## §1 Pattern summary — 11 silent-wipes chronology

| # | Wipe SHA  | Wipe subject (truncated)                                                | Restore SHA  | Restore subject                                                          |
|--:|-----------|-------------------------------------------------------------------------|--------------|--------------------------------------------------------------------------|
| 1 | (pre-`bb166ecb`) | (cycle 47-54 hxlcl_* helpers · cycle 55 stderr/errno block) | `bb166ecb`   | fix(runtime): RECOVER cycle 47-54 hxlcl_* helpers + cycle 55 stderr/errno block (silent-wipe restoration) |
| 2 | (pre-`842d6565`) | (PTX_OP_SHFL_SYNC_BFLY_B32 const · N81)                     | `842d6565`   | fix(compiler/codegen/nvptx): restore PTX_OP_SHFL_SYNC_BFLY_B32 const (N81 silent-wipe fix) |
| 3 | `e8c2dc1c` | wip: compiler/stdlib follow-on (wiped Step 5 #2/#4 codegen builtins · 4th re-land) | `38b89c89`   | restore(compiler+SSOT): 4th re-land Step 5 codegen builtins after e8c2dc1c wipe |
| 4 | `bf406f08` | chore(governance): anchor wipe-guard keyword to commit-msg prefix — close e8c2dc1c blind spot (307 files / -82,597 LOC mass-delete) | `a2a17a0a` (PR #303) | restore(stdlib): undo bf406f08 307-file accidental wipe — _hexa_bridge + _python_bridge + _qiskit_bridge + _absorption_bridge + rtsc stragglers |
| 5 | `de1be840` (also #11) | test(fire/rfc067-philb): N149 Hilbert cross-host reproduction on ubu-2 (619 files / -106,424 LOC · gutted Tier 2+3 hook + bridges + matter + rtsc + numeric.hexa) | `c355e3dc` (PR #311) | restore(stdlib): undo de1be840 wipe #5 — bridges + matter + rtsc + hook gutting |
| 6 | (`bf406f08` regression of PR #295 iter-2b nvptx gate)                  | `a29086f4` (in PR #306) | fix(self/main): re-apply iter-2b nvptx gate — bootstrap regression (bf406f08 wipe reverted PR #295) |
| 7 | (`bf406f08` regression of PR #300 iter-2e Darwin guard)                | `32174aa6` (in PR #306) | fix(self/runtime): re-apply iter-2e Darwin guard narrow — linux-arm64 (bf406f08 wipe reverted PR #300) |
| 8 | (V's regression sweep wiped — referenced in PR #311 body)              | `71a2f3e0`   | test(runtime): broad regression sweep — ~121 ported fns post-10-wipe verification |
| 9 | `c25ef75e` | feat(stdlib/runtime): RUNTIME.md step-3 잔여 #7 IO 4 fns port (wiped `hxlcl_realloc` clamp from `b2ae2e9d`) | `15e8e66b`   | fix(runtime): re-restore hxlcl_realloc clamp — 9th silent-wipe (L2 found, c25ef75e wiped b2ae2e9d) |
|10 | `13e13695` (PR #319) | RFC 080 Phase L+M — auto-PR absorption + --target-absorb N (wiped `fileno()` shim from `ecc7ef54`) | `b5b91426`   | fix(runtime): re-restore fileno() shim — 10th silent-wipe (RFC 080 commit 13e13695) |
|11 | `de1be840` (-23 on `stdlib/runtime/numeric.hexa`) | (same commit as #5; later detected wipe of cycle 105 array allocator hexa ports) | `27370792`   | restore(stdlib/runtime): re-restore cycle 105 array allocator hexa ports — 11th silent-wipe (de1be840) |

Notes:
- Wipes #1-#2 are pre-counted by the project's own narration; specific wipe-SHAs not in current log (compressed by the 5-wipe-saga consolidation `e118396d`).
- Wipe #4 (`bf406f08`) is a fused governance-commit + tree wipe — the very commit message that anchored the wipe-guard keyword was itself the wiper.
- Wipe #5 (`de1be840`) is a fused measurement-commit + tree wipe + **hook gutting** (removed Tier 2 + Tier 3 from `.githooks/commit-msg`).
- Wipes #5, #6, #7, #11 are all the same SHA `de1be840` viewed under different lenses (campaign-scale removal; counted multiply in project narration).

Wipe-guard install/harden milestones:
- `b0a58149` install — pre-commit wipe-guard hook + project.tape @D entry.
- `bf406f08` — supposed to anchor keyword to prefix; turned out to BE the wipe.
- `6ce0e8f5` re-apply prefix-anchor fix (lost in bf406f08 rebase).
- `a4510b97` (PR #305) **Tier 2 + Tier 3 hardening** — supposed to close all-the-things.
- `de1be840` **GUTTED** Tier 2 + Tier 3 from the hook + retained only Tier 1.

---

## §2 Wipe-mechanism analysis (classification)

Categories per prompt's a/b/c/d framing:
- (a) force-push to main
- (b) PR merge with stale base
- (c) `--no-verify` bypass
- (d) worktree-state mismatch (concurrent agent commits stale tree)

Direct-push vs PR-merge inspection (`git log --format='%P'` parent-count):

| Wipe SHA   | parents | Class | Evidence |
|------------|--------:|-------|----------|
| `e8c2dc1c` | 1       | (d)   | single-parent direct commit, stale-tree (per existing `2026-05-22-wipe-governance-proposal.md` §2) |
| `bf406f08` | 1       | (d)   | single-parent direct commit; subject claims governance fix but tree carries pre-`a2a17a0a` state — stale rebase per PR #305 hardening commit msg |
| `c25ef75e` | 1       | (d)   | single-parent direct commit; wiped `hxlcl_realloc` clamp from `b2ae2e9d` (intervening commit not in committer's worktree) |
| `de1be840` | 1       | (d)   | single-parent direct commit; `git reflog show origin/main` line is `update by push` (not fetch/merge). Author's working tree was stale relative to PR #305 (a4510b97) — gutted Tier 2/3 because they didn't exist in the tree being pushed |
| `13e13695` | 1 (PR #319) | (b) | merge-via-squash (PR), but PR branch base was stale — merged with all 4 CI checks FAILURE, no required-status-checks setting |

`git reflog show origin/main` excerpt (most-recent first):

```
54d739ad fetch fast-forward
8bfde47f fetch fast-forward
27370792 update by push        ← restore #11 (direct push)
b5b91426 update by push        ← restore #10 (direct push)
13e13695 fetch fast-forward    ← wipe #10 (PR #319 squash)
4a7db601 update by push
…
```

No `forced-update` lines anywhere → category (a) ruled out for all wipes.
No `--no-verify` traces in commit-msg search → category (c) ruled out as primary mechanism.

**Distribution**: 10/11 wipes are class (d) stale-worktree-direct-push. 1/11 wipe (#10 = `13e13695`) is class (b) stale-base PR merge.

Co-mechanism (hook never fires locally): `git config core.hooksPath` returns `/Users/ghost/core/hexa-lang/.git/hooks`, which is EMPTY (only `.sample` files). The hardened `.githooks/commit-msg` is **NOT activated** because the documented opt-in (`git config core.hooksPath .githooks`) is per-clone and was not propagated. Every wipe-committing clone runs with the hook effectively disabled.

---

## §3 Wipe-guard #305 mechanism review

File: `.githooks/commit-msg` (212 lines as of PR #305 / `a4510b97`).
- **Tier 1** (narrow paths · ≥50 deleted lines in 7 globs): allow when subject prefix matches `runtime|stdlib|codegen|rt_|restore|re-land|recover` OR body contains `WIPE-OK:` trailer.
- **Tier 2** (tree-wide mass-delete · >50 files deleted entirely OR >5000 lines): allow when prefix matches `restore|revert|re-land|recover|wipe|sunset|attestation|deprecat|archive|remove|rm ` OR body contains one of the trailers.
- **Tier 3** (protected-subtree wholesale removal · all files under `stdlib/{bio,chem,matter,runtime,rtsc,chip}`, `compiler`, `self`): same intent markers as Tier 2.

Companion `.githooks/pre-commit` (49 lines): NON-blocking informational warning (commit-msg phase has stale `COMMIT_EDITMSG`, so block-decision lives in commit-msg hook).

### What it catches (given opt-in is active)
- Wipe #3 `e8c2dc1c` (Tier 1 would fire — would block "wip:" prefix on runtime-line deletions).
- Wipe #4 `bf406f08` (Tier 2 would fire — 307 files deleted; "chore:" prefix lacks restore/sunset marker).
- Wipe #5 `de1be840` first 619-file mass-delete (Tier 2 + Tier 3 — multiple protected subtrees wiped).

### What it MISSES — per the actual 11-wipe history

| Miss mode | Evidence | Cause |
|-----------|----------|-------|
| M1 · hook disabled per-clone | `git config core.hooksPath = .git/hooks` (empty dir) on the audited worktree | Opt-in is per-clone, not enforced by `core.hooksPath` server-side or via `git config --global init.templateDir` |
| M2 · hook gutted by a wipe | `de1be840` removed Tier 2+3 logic from `.githooks/commit-msg` itself | The hook is a tracked file; a stale tree push can revert the hook back to a less-strict version, then subsequent wipes go through |
| M3 · sub-threshold incremental wipes | `c25ef75e` (-1 line · `hxlcl_realloc` clamp) · `13e13695` (-8 lines · `fileno` shim) · `de1be840` (-23 lines on `stdlib/runtime/numeric.hexa`) | Each below Tier 1's ≥50 line floor; Tier 2's ≥50 files / ≥5000 lines floor; Tier 3's >5 files protected-subtree floor. Subtle wipes invisible by design |
| M4 · PR merge with stale base | `13e13695` (PR #319) — merged with 4/4 CI FAILURE | No `required_status_checks` on main; merge gate is non-existent |
| M5 · co-located legitimate large additions | Most measurement commits add 100s of files (perf scoreboards / fire artifacts) — mask the deleted lines from naive ratio detection | Tier 2 looks only at deletion absolutes, not adds-vs-dels ratio; a +20k/-100 commit shrinking core files looks legitimate |

**Net miss rate against the 11-wipe history (with hook activated as designed)**: ~6/11 (M1 dominated; M3 secondary; M4 PR-merge once). Without activation: 11/11.

---

## §4 Branch-protection state on `dancinlab/hexa-lang:main`

```
gh api repos/dancinlab/hexa-lang/branches/main/protection
```

Returns:
```json
{
  "required_signatures": {"enabled": false},
  "enforce_admins":      {"enabled": false},
  "required_linear_history": {"enabled": false},
  "allow_force_pushes":      {"enabled": false},
  "allow_deletions":         {"enabled": false},
  "required_conversation_resolution": {"enabled": false},
  "lock_branch":             {"enabled": false}
}
```

Plus `required_pull_request_reviews`:
```json
{"dismiss_stale_reviews": false,
 "require_code_owner_reviews": false,
 "require_last_push_approval": false,
 "required_approving_review_count": 1}
```

And `required_status_checks`: **404 Not Found** — required status checks **NOT enabled**.

Repo settings:
```json
{"allow_squash_merge": true,
 "allow_merge_commit": true,
 "allow_rebase_merge": true,
 "allow_auto_merge":   false,
 "delete_branch_on_merge": false}
```

### Gap summary (high-impact, ordered worst→best)
1. **`required_status_checks` missing** → bootstrap CI + grace-consent failing checks do NOT block merges. Direct evidence: PR #305 (the wipe-guard hardening PR itself) merged with **all 4 checks FAILURE**. PR #311 (URGENT restore) merged with **all 4 FAILURE**. PR #319 (which became wipe #10) merged with **all 4 FAILURE**.
2. **`enforce_admins: false`** → admin (sole maintainer `dancinlife`) bypasses protection by default — explains why direct-push wipes (de1be840, bf406f08, c25ef75e) succeeded despite the existing 1-review requirement.
3. **`required_linear_history: false`** → merge commits with arbitrary base allowed; combined with PR review bypass for admins, stale-base merges pass.
4. **`require_last_push_approval: false`** → reviewer's approval persists after the PR branch is force-pushed to a stale state.
5. **`allow_force_pushes: false`** is OK (no force-push class wipes observed), but does NOT block direct-push from admin to main since `enforce_admins: false`.

Collaborators: `['ckcks12', 'dancinlife']` — sole-maintainer scenario. Admin protection enforcement is essential here because no peer reviewer is structurally available.

---

## §5 Proposals — stack-ranked

Each proposal: mechanism · LOC/config cost · Principle I impact · which of the 11 wipes it would have prevented · risks.

### P1 (highest priority) — GitHub branch protection with required status checks + enforce-admins
- **Mechanism**: enable `required_status_checks` = `[bootstrap (macos-arm64), bootstrap (linux-arm64), bootstrap (linux-x86_64), check @grace consent trailers]` · `enforce_admins: true` · `required_linear_history: true` · `require_last_push_approval: true` · `requires_strict_status_checks: true` (rebase-before-merge).
- **Config cost**: ~12 lines via `gh api -X PUT repos/.../branches/main/protection -F ...` (one curl/gh call). Zero LOC.
- **Principle I impact**: NONE on code; only governance. Hexa stays compiled.
- **Prevents**: 10/11 wipes — every direct-push class (d) blocked because `enforce_admins:true` forces admins to go through PRs; every stale-base PR (b) blocked because `requires_strict_status_checks:true` forces rebase + green CI.
- **Misses**: only the M3 incremental sub-threshold wipes IF the PR branch was rebased onto fresh main but the committer's local IDE checkout itself was stale. But because CI must pass (bootstrap is the wipe's primary symptom: it goes red when the wipe lands), even those would be caught at merge time.
- **Risk**: requires GitHub Pro/Team for protection on private repos (verify); sole-maintainer workflow slows down (must self-approve in a peer-account or use `required_approving_review_count: 0` with status checks only — recommended in practice). Locks `dancinlife` out of emergency direct-push — design escape: temporarily disable protection via `gh api -X DELETE` + revert.
- **Owner**: admin-side (only `dancinlife` can flip branch protection).

### P2 — Stale-base detection added to `.githooks/commit-msg`
- **Mechanism**: before any commit, if `git rev-parse @{u}` exists and `git merge-base HEAD @{u}` ≠ `@{u}` (i.e. local branch is behind upstream), AND the commit deletes any file present in `@{u}` but absent in HEAD's tree, BLOCK with a clear "your branch is stale; `git fetch && git rebase origin/main` before commit" message. Independent of file-count thresholds.
- **LOC**: ~30 LOC bash inserted as Tier 0 (runs first) in `.githooks/commit-msg`.
- **Principle I impact**: NONE; pre-build governance hook.
- **Prevents**: 10/11 — all class (d) wipes (stale-worktree-direct-push) caught at commit time, before push.
- **Misses**: M1 (hook not activated) still applies; M2 (hook itself gutted by stale-tree commit) still applies — must be paired with `core.hooksPath` enforced via `git config --global init.templateDir`, or move enforcement to a server-side `pre-receive` (not available on GitHub.com — fall back to P1).
- **Owner**: developer (any contributor with write to `.githooks/`).

### P3 — Server-side pre-receive equivalent via GitHub Actions blocking workflow
- **Mechanism**: add `.github/workflows/wipe-block.yml` that runs on `push` events to `main`, computes Tier 2/Tier 3/stale-base predicates against the pushed range (`github.event.before` → `github.event.after`), and fails the workflow. Combined with `required_status_checks` (P1), the wipe would have to land but fail; THEN auto-revert via a follow-up workflow (`gh-cli` `gh api -X POST .../revert` if available, else open an auto-revert PR).
- **LOC**: ~80 LOC YAML + ~60 LOC bash check script.
- **Principle I impact**: NONE.
- **Prevents**: same class as P2 but enforced server-side; cannot be bypassed by hook gutting. **HOWEVER** — `on: push` workflows in GitHub Actions cannot retroactively block the push; they can only react. So they don't prevent the wipe, only signal it (and auto-revert).
- **Misses**: a brief window where origin/main is in wiped state before the auto-revert PR merges; downstream clones that fetch in the window will see the wipe.
- **Note**: Inferior to P1 for blocking; superior for forensics + auto-revert.
- **Owner**: developer.

### P4 — CODEOWNERS for critical paths
- **Mechanism**: add `.github/CODEOWNERS`:
  ```
  /self/runtime.c               @dancinlab/runtime-reviewers
  /self/runtime_core.c          @dancinlab/runtime-reviewers
  /self/codegen_c2.hexa         @dancinlab/runtime-reviewers
  /compiler/check/bind.hexa     @dancinlab/runtime-reviewers
  /stdlib/runtime/              @dancinlab/runtime-reviewers
  /stdlib/kernels/wind/         @dancinlab/wind-reviewers
  /.githooks/                   @dancinlab/governance-reviewers
  /.github/workflows/           @dancinlab/governance-reviewers
  ```
  Combined with `require_code_owner_reviews: true` (currently `false`).
- **LOC**: ~15 lines of CODEOWNERS + branch protection toggle.
- **Principle I impact**: NONE.
- **Prevents**: prevents 0/11 directly (still admin-bypassable when `enforce_admins:false`); becomes effective ONLY when P1 is also active. Then forces a second reviewer for runtime-line changes.
- **Risk**: sole-maintainer means the `@dancinlab/runtime-reviewers` team must be populated with a second human (or a self-account for "approval gate"). Otherwise this just adds friction without enforcement.
- **Owner**: admin.

### P5 — `pre-push` hook with `origin/main` fetch + diff sanity check
- **Mechanism**: before any `git push`, fetch `origin/main`, compute `git diff --shortstat origin/main..HEAD`, and if (deletions > 50 lines OR deleted-files > 5) AND ANY of those deletes touch a path that was MODIFIED on `origin/main` since the local branch forked, BLOCK with a stale-base error. Hook lives at `.githooks/pre-push`.
- **LOC**: ~50 LOC bash.
- **Principle I impact**: NONE.
- **Prevents**: catches class (d) wipes at push time even if commit-msg hook bypassed — but again opt-in. Useful as a defense-in-depth, not as primary block.
- **Misses**: M1 (per-clone activation) — same opt-in problem.
- **Owner**: developer.

### Stack ranking summary

| Rank | Proposal | Cost | Prevents wipes | Bypassable? |
|------|----------|------|----------------|-------------|
| 1    | P1 — branch protection + required status checks + enforce-admins + strict | ~12 line `gh api` | 10/11 (all class d + class b at merge) | No (admin must explicitly disable) |
| 2    | P2 — stale-base hook Tier 0    | ~30 LOC bash | 10/11 IF activated | Yes (M1 hook-disabled + M2 hook-gutted) |
| 3    | P3 — server-side action + auto-revert | ~140 LOC YAML+bash | 11/11 (signals all; auto-reverts) | No, but DOES NOT BLOCK PUSH |
| 4    | P4 — CODEOWNERS + require_code_owner_reviews | ~15 lines + admin toggle | 0/11 alone, ~9/11 paired with P1 | Yes (admin override unless enforce-admins) |
| 5    | P5 — pre-push hook | ~50 LOC bash | ~9/11 IF activated | Yes (per-clone opt-in) |

---

## §6 Recommended next action — land P1 FIRST

**Concrete first step** (admin-only · `dancinlife`):

```bash
gh api -X PUT repos/dancinlab/hexa-lang/branches/main/protection \
  --input - <<'JSON'
{
  "required_status_checks": {
    "strict": true,
    "checks": [
      {"context": "bootstrap (macos-arm64)"},
      {"context": "bootstrap (linux-arm64)"},
      {"context": "bootstrap (linux-x86_64)"},
      {"context": "check @grace consent trailers"}
    ]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 0,
    "require_code_owner_reviews": false,
    "require_last_push_approval": true,
    "dismiss_stale_reviews": true
  },
  "required_linear_history": true,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "restrictions": null
}
JSON
```

Notes for sole-maintainer ergonomics:
- `required_approving_review_count: 0` keeps the workflow self-merge-capable; the GATE is now CI-green + strict-rebase rather than peer-review.
- `require_last_push_approval: true` is moot when count=0 but harmless.
- `strict: true` forces the PR branch to be up-to-date with main before merge — kills the stale-base class (b) at merge time.
- `enforce_admins: true` is the critical bit: blocks all direct-push to main from admin clones, forcing every change through the PR pipeline.
- Emergency escape: `gh api -X PUT ... enforce_admins false` flips back temporarily; document this in `.github/EMERGENCY.md`.

After P1 lands and bootstrap CI is restored to green on main, layer in P2 (stale-base Tier 0 hook) as defense-in-depth; then P4 (CODEOWNERS) if a second reviewer becomes available.

P3 (server-side action) is recommended only after P1; otherwise P3's auto-revert mechanic creates noise without preventing the underlying class (d) push.

**Why P1 first, not the hook layer**: 11/11 wipes happened despite hook work because the hook layer is per-clone-opt-in and the hook itself is a tracked file (M1 + M2 mutually reinforce). Branch protection is the only mechanism that cannot be bypassed by a stale tree push, because the gate lives on GitHub's side, not in the repo content.

### Owner matrix
| Action | Owner | Who can do it |
|--------|-------|--------------|
| P1 branch protection | admin | `dancinlife` only |
| P2 stale-base hook   | developer | any committer with push to `.githooks/` |
| P3 server-side workflow | developer (admin for `required_status_checks` add) | any committer + admin |
| P4 CODEOWNERS        | admin | admin to enable `require_code_owner_reviews`, dev to land file |
| P5 pre-push hook     | developer | any committer |

---

## §7 Anchors

### Hook install / hardening lineage
- `b0a58149` install — `chore(governance): install pre-commit wipe-guard hook + project.tape @D entry`
- `bf406f08` (wipe #4) — `chore(governance): anchor wipe-guard keyword to commit-msg prefix — close e8c2dc1c blind spot` (the keyword anchor commit was itself a 307-file wipe — fused governance+wipe)
- `6ce0e8f5` — `chore(governance): re-apply wipe-guard prefix-anchor fix (lost in bf406f08 317-file rebase)`
- `a4510b97` (PR #305) — `chore(governance): harden wipe-guard hook — Tier 2 tree-wide + Tier 3 protected-subtree (post wipe #4 bf406f08)`
- `de1be840` (wipe #5) — GUTTED Tier 2 + Tier 3 from `.githooks/commit-msg`, fused with N149 Hilbert measurement commit
- `c355e3dc` (PR #311) — restore wipe #5 + restored hook

### Eleven wipe-restore pairs
| # | Wipe SHA | Restore SHA |
|--:|----------|-------------|
| 1 | (pre-bb166ecb · 5-wipe-saga era)        | `bb166ecb`   |
| 2 | (N81 PTX_OP_SHFL_SYNC_BFLY_B32 era)    | `842d6565`   |
| 3 | `e8c2dc1c`                              | `38b89c89`   |
| 4 | `bf406f08`                              | `a2a17a0a` (PR #303) |
| 5 | `de1be840` (bridges+matter+rtsc+hook)   | `c355e3dc` (PR #311) |
| 6 | `bf406f08` (PR #295 iter-2b regression) | `a29086f4` (in PR #306) |
| 7 | `bf406f08` (PR #300 iter-2e regression) | `32174aa6` (in PR #306) |
| 8 | (V's regression sweep wipe)             | `71a2f3e0`   |
| 9 | `c25ef75e` (hxlcl_realloc -1)           | `15e8e66b`   |
|10 | `13e13695` (PR #319, fileno -8)         | `b5b91426`   |
|11 | `de1be840` (numeric.hexa -23, cycle 105)| `27370792`   |

### PR merge-time CI status (selected evidence of "merge despite red CI")
- PR #305 (wipe-guard hardening) — bootstrap macos-arm64 FAILURE · bootstrap linux-arm64 FAILURE · bootstrap linux-x86_64 FAILURE · grace-consent FAILURE — merged anyway 2026-05-22T04:05:34Z.
- PR #311 (URGENT restore de1be840 wipe #5) — all 4 FAILURE — merged 2026-05-22T06:33:40Z.
- PR #319 (the commit that became wipe #10) — all 4 FAILURE — merged 2026-05-22T09:02:13Z.

### Memory anchors (project memory)
- `project-hexa-lang-recurring-wipes` (pattern)
- `feedback_hexa_lang_concurrent_agents` (shared worktree hazard · this audit confirms the mechanism)
- `feedback_hexa_lang_shared_worktree_branch_hazard`
- `feedback_runtime_c_deploy_regen_wipe`
- `feedback_worktree_merge_silent_filedrop`
- `feedback_subagent_worktree_leak_pattern`
- `feedback-no-impossibility-framing` (chronic ≠ impossible; P1 path proposed)
- `reference-hexa-is-compiled` (no proposal touches the compile/interpret boundary)

### Existing in-tree governance doc
- `~/core/hexa-lang/inbox/notes/2026-05-22-wipe-governance-proposal.md` (256 lines · Option D = hook layer · landed `b0a58149` + `267a04de`). This audit adds the missing layer: the hook can be bypassed; branch protection cannot.

### Companion deliverable
- `~/core/hexa-lang/inbox/notes/2026-05-22-wipe-guard-strengthen-proposals.md` (NEW · hexa-lang side · ready-to-implement patch for P1 + P2 + diff against current `.githooks/commit-msg` showing Tier 0 stale-base detection). File-only; not pushed (chronic CI red — push would inherit state).

### Honest gap
- This audit could NOT confirm wipes #1 and #2 by SHA (project narration consolidated them into the 5-wipe-saga commit `e118396d`). Their classification as (d) is by analogy (same author, same opt-in-gap era), not direct reflog evidence.
