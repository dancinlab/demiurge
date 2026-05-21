# 2026-05-22 — hexa-lang bootstrap Option A fix attempt log

**Scope**: Apply Track 9 audit's recommended Option A patch to
`.github/workflows/bootstrap.yml` — append `self/runtime.c` as link
input to resolve the 500/500 CI red streak. Single-session execute.

**Outcome**: **β (partial progress, not regression)**.

- macOS arm64: Stage 0 **RED → GREEN**. Now fails in Stage 1' on a
  different (latent) failure surfaced for the first time.
- Linux x86_64 / arm64: Stage 0 still RED, but on a **different
  runtime.c source bug** (missing `<stdarg.h>` include) that was
  previously masked by Stage 0 never linking runtime.c at all.

PR: https://github.com/dancinlab/hexa-lang/pull/288
Branch: `bootstrap-runtime-link-fix-2026-05-22`
Commit: `e3938aec` (in hexa-lang origin)

---

## 1. Edit applied

`.github/workflows/bootstrap.yml`: +18/-9 LOC across 9 link sites
(3 jobs × {Stage 0, Stage 1', Smoke}). Pure append of
`self/runtime.c` as a compile input — no other change.

`runtime.c` already `#include`s `runtime_core.c` at line 1211, so a
single extra source file resolves all 66 undefined symbols.

## 2. Local verification (arm64 macOS clang 17)

```
clang -O2 -std=gnu11 -D_GNU_SOURCE -Wno-trigraphs \
    -I self self/native/hexa_cc.c self/runtime.c \
    -o /tmp/hexa_v2_test
```

→ **PASS**: builds with warnings only (no errors). Produced binary
runs: `./hexa_v2_test hi.hexa hi.c` → `OK: hi.c`. Smoke compile
of `hi.c` with `self/runtime.c` linked → builds, runs, prints "ok".

`/tmp/hexa_v2_test self/main.hexa build/stage1/main.c` → transpiles
fine. `clang ... build/stage1/main.c self/runtime.c -o hexa` →
**FAIL** with 6 undefined symbols: `lex`, `parse`, `lower`,
`lower_hir`, `codegen_emit_ptx_for_sm`, `static_atlas`. These are
defined in `compiler/lex/lexer.hexa`, `compiler/parse/parser.hexa`,
`compiler/lower/ast_to_hir.hexa`, `compiler/lower/hir_to_mir.hexa`,
`compiler/codegen/nvptx_target.hexa`, `compiler/atlas/static_index.hexa`
— pulled in via `use` directives at top of `self/main.hexa` (lines
10-16), but the transpiler is not inlining their bodies into
`build/stage1/main.c`. This is a separate transpiler /
`use`-directive resolution issue. Recorded as iteration-2 work
(see `2026-05-22-bootstrap-fix-iteration-2.md`).

## 3. CI outcome (PR #288, run 26244746182)

| Job                       | Time  | Status | Stage reached | New failure mode |
|---------------------------|-------|--------|---------------|------------------|
| bootstrap (macos-arm64)   | 37s   | FAIL   | **Stage 1'** | `lex/parse/lower/...` undefined symbols (transpiler `use` gap) |
| bootstrap (linux-x86_64)  | 42s   | FAIL   | Stage 0       | `runtime.c:395+` GCC parse error (missing `<stdarg.h>`) |
| bootstrap (linux-arm64)   | 1m17s | FAIL   | Stage 0       | same as linux-x86_64 |
| check @grace consent      | 12s   | FAIL   | n/a           | orthogonal (config check, not bootstrap) |

### macOS Stage 0 GREEN evidence

Stage 0 step on macos-arm64 ran 1.5s (clang) → 2 warnings about
nested `/*` comments in `runtime.h` (line 349-350) + macro-redefine
warnings for `strcat`/`bzero`/`memcpy`/etc. (line 1145-1162) +
discards-qualifiers warnings in `runtime_core.c` → **no errors**.
`hexa_v2` binary built. Stage 1' fail occurred at link time of
`build/stage1/main.c self/runtime.c -o hexa` with `Undefined symbols
for architecture arm64: _codegen_emit_ptx_for_sm, _lex, _lower,
_lower_hir, _parse, _static_atlas`.

### Linux Stage 0 new bug

GCC reports starting at `self/runtime.c:395:50`:

```
error: expected expression before 'int'
   prec = va_arg(ap, int);  fmt++;  ...
```

Cause: `self/runtime.c` is missing `#include <stdarg.h>`. Lines 6-22
include `<stdio.h>`, `<stdlib.h>`, `<string.h>`, `<stdint.h>` etc.,
but **not** `<stdarg.h>`. On macOS clang this works transitively
through SDK headers; on GCC/glibc the `va_arg`/`va_list`/`va_start`
macros are not defined and the parser fails on `va_arg(ap, int)`
syntax. This is a runtime.c bug that was dormant for all 500
previous CI runs because `runtime.c` was never compiled by CI.

## 4. Honest gap

Option A as scoped (workflow-only edit, no source modification)
**unblocks Stage 0 on macOS only**. Linux Stage 0 + all platforms'
Stage 1' surface latent bugs that were masked by the original
break. The audit's expectation ("Stage 1' likely has the same
issue and also needs runtime.c appended") was correct in
direction but understated the scope of latent breakage.

**Why this is still β, not γ**:
- The fix is correct (it does what it was designed to do).
- The new failures are PRE-EXISTING bugs in `runtime.c` and the
  transpiler that were always there, never observed because Stage
  0 always failed first. The diagnostic count "500/500 CI red"
  remains accurate but the root cause is now understood to be
  layered (Stage 0 missing link → masked → Linux source bug →
  masked → Stage 1' transpiler gap).
- No regression: nothing that used to work now doesn't. macOS
  Stage 0 moved RED→GREEN. Linux Stage 0 changed failure mode
  (linker errors → parser errors) but stayed RED. Stage 1' was
  never reached before; now it's reached on macOS and reveals its
  own pre-existing breakage.

## 5. Demiurge bookkeeping

- Demiurge audit commit (Track 9 root-cause): `36fade5` (per briefing)
- Demiurge attempt commit (this note): to follow
- hexa-lang PR #288: opened, CI ran, 3/4 bootstrap jobs red on new
  failure modes (1/4 grace-consent red is orthogonal)
- hexa-lang worktree: `/Users/ghost/core/hexa-lang-bootstrap-fix`
  retained (no delete) for iteration-2 follow-up

## 6. Next pickup (iteration 2)

Two parallel sub-tracks. See `2026-05-22-bootstrap-fix-iteration-2.md`
for full spec; summary here:

### 6a. Linux Stage 0 — add `#include <stdarg.h>` to runtime.c

Smallest possible additional fix. ~1 LOC at top of `self/runtime.c`
after the existing `#include <stdint.h>`. Crosses the "don't touch
runtime.c" line of this session's scope, so deferred. Wipe-governance
audit's concern about silently-dropped restores applies — this
change MUST land in a commit that does not regenerate other files.

### 6b. macOS Stage 1' — transpiler `use` resolution

Bigger problem. `use "compiler/lex/lexer"` at top of `self/main.hexa`
should pull `compiler/lex/lexer.hexa`'s `fn lex(...)` into the
transpilation unit. The current `build/stage1/main.c` does NOT
contain a body for `lex` — only call sites. Either:
- the transpiler isn't following `use` paths into `compiler/`, or
- it follows them but they're being suppressed.

This is a transpiler-internals problem and likely sits with a
hexa-lang compiler-team cohort, not a CI plumbing session.

### Sequencing

Iteration 2a (`<stdarg.h>` add) is a 1-line, safe, can be done
immediately by anyone with hexa-lang push access. Iteration 2b
(transpiler `use` gap) is deeper and may be a multi-session arc.
Both can run in parallel; neither blocks the other.

## 7. PR #276 impact

PR #276's own 22-LOC `runtime.h` header addition remains a valid
contribution. With Stage 0 GREEN on macOS, PR #276's logic IS now
testable in CI (Stage 1' regression check is just whether the new
runtime.h breaks anything on macOS — it doesn't, per the equivalent
local test). PR #276 can be reviewed/merged on macOS-only CI signal
once iteration 2a lands Linux Stage 0 green; full 3-platform
green awaits iteration 2b.

## 8. Anchors

- PR: https://github.com/dancinlab/hexa-lang/pull/288
- Run: https://github.com/dancinlab/hexa-lang/actions/runs/26244746182
- Diagnostic: `~/core/demiurge/inbox/notes/2026-05-22-pr276-bootstrap-ci-diagnostic.md`
- Iteration 2 spec: `~/core/demiurge/inbox/notes/2026-05-22-bootstrap-fix-iteration-2.md`
- Branch: `bootstrap-runtime-link-fix-2026-05-22` (hexa-lang)
- Commit: `e3938aec`
- Worktree retained: `/Users/ghost/core/hexa-lang-bootstrap-fix`
