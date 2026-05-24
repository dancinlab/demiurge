# 2026-05-22 — PR #276 regex runtime backend: rebase + unblock + MERGED

**PR**: dancinlab/hexa-lang#276 — `feat(self/runtime): stdlib/regex G3 runtime backend — POSIX regcomp/regexec glue`
**Branch**: `regex-runtime-backend` (`f90ba2f5` → rebased `ad7fd677`)
**Merge commit**: MERGED `ae470e028a26ce2944932f799b30fb3faac99799` (squash) at 2026-05-22T02:59:48Z
**Base at rebase**: `origin/main` `4f965da7` (main advanced to `f221d2ba`+ during session — high-velocity)
**Status**: rebased clean · CI green on linux-x86_64 + macOS · merged · regex backend now AVAILABLE for future consumers

---

## 1. The blocker (recap)

PR #276 was a 22-LOC `self/runtime.h` header addition declaring the 6
`hexa_regex_*` builtins. The *implementations* already lived in
`self/runtime.c` (POSIX ERE via libc `regcomp`/`regexec`, `(?i)` inline-flag
stripping → `REG_ICASE`); they were just never *declared* in the header, so
clang implicit-decl'd them on every build touching `stdlib/regex`.

PR #276 was NOT blocked by its own changes — it was blocked by the bootstrap
CI substrate being 0/9 → red on every PR. That substrate was fixed this
session via iter-2a/2b/2c/2d (PRs #290 / #295 / #297 merged → 8/9 green).
PR #276's red checks were stale (ran 2026-05-21T15:57 on the pre-fix SHA
`f90ba2f5`) and its `mergeStateStatus` was DIRTY (merge conflict vs new main).

## 2. Rebase — clean, matmul commits auto-dropped

The `regex-runtime-backend` branch carried 3 commits ahead of its old
merge-base (`034ec625`):

1. `7f3448aa` — RFC 071 P5+ nvptx matmul codegen
2. `f2770d6e` — gpu_matmul HIR→MIR synthesis
3. `f90ba2f5` — the regex runtime.h header (the actual PR content)

Commits (1) and (2) were already in `origin/main` by content (landed
separately as `b5edd41a` / `261bfb29` etc. with different SHAs).
`git rebase origin/main` **auto-skipped both as "previously applied"**
(patch-id match) and replayed only the regex commit:

```
warning: skipped previously applied commit 7f3448aa
warning: skipped previously applied commit f2770d6e
Rebasing (1/1) Successfully rebased and updated refs/heads/regex-runtime-backend.
```

Result: rebased branch = **exactly 1 commit** (`ad7fd677`) on top of
`4f965da7`, touching ONLY `self/runtime.h` (+22 / 1 file).

### Conflict resolution: NONE required
The regex commit appends its 22 lines immediately before the closing
`#endif /* HEXA_RUNTIME_H */`. That tail region was **byte-identical**
between merge-base `034ec625` and `origin/main` — all of main's
runtime.h deltas (iter-2a/b/c/d + others) landed in *earlier* parts of
the file (around L253, L284, L309, L341). So the append hunk applied with
zero conflict. Faithful: iter-2a/b/c/d changes preserved, regex extern
decls additive-only, no matmul changes re-introduced.

Push: `git push --force-with-lease origin regex-runtime-backend`
(`f90ba2f5...ad7fd677 forced update`). force-with-lease ONLY on the PR
feature branch — never main (per safety protocol, the one acceptable
force-push case: updating a PR after rebase).

### Decl/impl consistency verified
All 6 header decls match runtime.c impl signatures exactly:
- `hexa_regex_match` / `_match_full` / `_search` / `_findall` / `_split` — `(HexaVal, HexaVal)`
- `hexa_regex_replace` — `(HexaVal, HexaVal, HexaVal)`
(impls at `self/runtime.c:10320-10435` in current main; briefing's
10202-10374 was pre-advance — impls intact, just shifted.)

## 3. CI result (post-rebase, SHA `ad7fd677`)

| Check | Result | Note |
|---|---|---|
| bootstrap (macos-arm64) | ✅ **PASS** | verified-green platform |
| bootstrap (linux-x86_64) | ✅ **PASS** | verified-green platform |
| bootstrap (linux-arm64) | ❌ FAIL | iter-2e parallel track (NOT PR #276's blocker) — OK to merge over |
| grace-consent | ❌ FAIL | **repo-wide infra breakage** (NOT a regex regression) — see below |

**linux-x86_64 + macOS both GREEN** → the briefing's merge bar is met.

### grace-consent FAIL is pre-existing infra, not a #276 regression
The `grace-consent` job failed at its first step ("Locate hexa
interpreter") with `no hexa interpreter found (expected
build/hexa_interp.linux or PATH:hexa)`. That binary is **not tracked in
either the regex branch OR origin/main** (`git ls-files` / `git ls-tree`
both empty; last referenced in rename `e075b3e8` but the artifact itself
is absent). Confirmed failing on EVERY recent PR repo-wide (rtsc-eliashberg,
stdlib-rtsc-stragglers, bootstrap-iter-2cd, stdlib-bio-b5, …all `failure`).
It is the known "1/9" red — orthogonal to PR #276, and the regex commit
touches no `.hexa` `@grace(HX…)` site (only the C header), so it could not
have triggered a real consent violation. `required_status_checks` on main
branch protection = `null`, so neither grace-consent nor bootstrap is a
hard GitHub merge gate.

## 4. Merge decision + rationale → MERGED

**Decision: MERGED** (exit criterion α). Rationale:
- Both *verified-green* platforms (linux-x86_64 + macOS) PASS — regex did
  not regress them.
- Clean header fix: impl already present in main's runtime.c, 24/24 local
  regex test PASS, decl/impl signatures verified consistent.
- linux-arm64 red is the iter-2e parallel track (Track 26), not PR #276's
  responsibility — briefing explicitly authorizes merging over it.
- grace-consent red is repo-wide missing-binary infra, not a regex fault.
- `git merge-tree` against latest main showed no conflict (regex append
  region stays isolated even as main advanced 4 commits during the session).
- Squash-merged to keep main's history clean (single regex commit).

regex backend is "nice-to-have" today (RTSC Phase 4 #2 already LANDED via
hand-rolled char-scan tokenizer in `composition.hexa` — no regex needed,
no rework). But it's genuinely useful for FUTURE consumers (bio/chem
formula parsers, general string ops), so landing the clean header fix
banks the capability with no downside.

## 5. Cross-link to RTSC Phase 4 #2

RTSC.md §9.9.1 Phase 4 #2 row updated: noted regex backend now AVAILABLE
(merge `ae470e02`). Phase 4 #2 (C3 `parse_formula_elements` + C4
`classify_composition_domain`) bypassed regex via hand-roll
(`_is_upper`/`_scan_count`/`_expand_all_parens`, 32/32 parity PASS) and
needs no rework — but future formula-parser / general-string consumers can
now `use stdlib/regex` directly (POSIX ERE, `(?i)` case-insensitive,
fail-soft on bad patterns). Surface: `regex_test` / `regex_full_match` /
`regex_find` / `regex_find_all` / `regex_split` / `regex_replace`
(wrappers in `stdlib/regex/mod.hexa` over the 6 runtime builtins).

## 6. Worktree discipline

Reused the existing `~/core/hexa-lang-regex` worktree (already on
`regex-runtime-backend`) instead of creating a new one; rebased there,
pushed, then `git worktree remove --force` after merge. No main-worktree
contamination. Ran alongside Track 26 iter-2e + Track 28 κ-71 (3 parallel
agents, within cap).
