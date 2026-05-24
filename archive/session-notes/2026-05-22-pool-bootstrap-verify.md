# 2026-05-22 — Pool-based hexa-lang bootstrap Linux verify (iter-2c surface)

**Parent**: `2026-05-22-bootstrap-fix-iteration-2.md`, `2026-05-22-bootstrap-iter-2b-audit.md`
**Predecessor PRs (MERGED)**:
- iter-1: dancinlab/hexa-lang#288 `e3938aec` → merge `45ee2018`
- iter-2a: dancinlab/hexa-lang#290 `b78e1c71` → merge `5ce47830`
**hexa-lang main HEAD at verify**: `f7af4cd0` (post-#290 merge + 2 forward commits)
**Status**: Pool environment GREEN · PR #290 ALREADY MERGED · Linux Stage 0 RED (iter-2c+ surface) · NO push action taken

---

## 1. Pool CLI invocation pattern (canonical)

- **Binary**: `/Users/ghost/.hx/bin/pool`
- **Roster** (`pool list`):
  - `mini`   → macos · sudo enabled
  - `ubu-1`  → linux · sudo (Ubuntu 24.04.2 x86_64 · `aiden-B650M-K` · GCC 13.3.0)
  - `ubu-2`  → linux · sudo (Ubuntu 24.04.2 x86_64 · `summer-B650M-K` · GCC 13.3.0 · clang 18.1.3)
- **Status probe**: `pool status` (all 3 hosts OK)
- **Remote exec**: `pool on <name> '<cmd>'` (ssh wrapper · runs as `summer` on ubu-2)
- **State file**: `~/.pool/pool.json` (override with `POOL_STATE=…`)

All 3 hosts are x86_64. **No linux-arm64 in pool** — CI's `linux-arm64` job cannot be reproduced on pool; only `linux-x86_64` is locally testable.

State sync: ubu-2 already has `~/core/hexa-lang` (dirty + behind by ~22 commits as of 2026-05-22 04:30). For this verify I used an isolated clone at `~/_hexa_pool_verify/hexa-lang` (depth-1 fresh from origin/main `d0b2dc03`). All pool work confined there.

## 2. Discovery: PR #290 already MERGED — Bootstrap CI STILL RED

State of the world (gh):
- PR #288 MERGED 2026-05-21T18:51:48Z as `45ee2018`
- PR #290 MERGED 2026-05-21T18:50:58Z as `5ce47830` (note: #290 actually merged 50s BEFORE #288 — both fast-forward landed)
- Bootstrap CI run on PR #290's merge commit (`26246438163`): **3/3 RED** — Stage 0 fails on macOS, linux-x86_64, linux-arm64.
- Latest bootstrap CI on main (`26248049267`, HEAD `82748da6`): **macOS 1/2 GREEN** (Stage 0 + Stage 1 transpile green, Stage 1' compile red) · **linux-x86_64 Stage 0 RED** · **linux-arm64 Stage 0 RED**.

**Net score** (Stage 0 across {macOS-arm64, linux-x86_64, linux-arm64}): **1/3 green** (matches Track 14 baseline of "macOS Stage 0 green only"). PR #290's stdarg fix did NOT unblock Linux Stage 0 because there is a more proximate macro/preprocessor bug (iter-2c) that fires first.

## 3. Linux Stage 0 RED root cause — iter-2c (flock macro replacement inside <sys/file.h>)

Reproducer on ubu-2 (clean clone of f7af4cd0):
```bash
pool on ubu-2 'cd ~/_hexa_pool_verify/hexa-lang && \
  gcc -O2 -std=gnu11 -D_GNU_SOURCE -Wno-trigraphs \
  -I self self/native/hexa_cc.c self/runtime.c -o self/native/hexa_v2'
```

Errors:
```
self/runtime.c:1187:40: error: expected declaration specifiers or '...' before '(' token
 1187 | #define flock(fd,op)       hxlcl_flock((int)(fd), (int)(op))
       |                                        ^
self/runtime.c:1187:51: error: expected declaration specifiers or '...' before '(' token
```

**Mechanism**:
1. `self/runtime.c:1187` defines `#define flock(fd,op) hxlcl_flock(...)`.
2. `self/runtime.c:11530` `#include "native/signal_flock.c"`.
3. `signal_flock.c:48` `#include <sys/file.h>`.
4. Glibc's `<sys/file.h>` declares `extern int flock (int __fd, int __operation) ...;`.
5. The user-defined `flock(fd,op)` macro replaces the prototype's parameters into a call expression → parser sees `extern int hxlcl_flock((int)(__fd), (int)(__operation));` and chokes on the `(` at column 40.
6. macOS clang/libSystem `<sys/file.h>` does NOT declare a function-like `flock(fd, op)` (it routes through unistd.h or is conditioned out under Apple's _POSIX_C_SOURCE feature gates), so the macro replacement is a no-op there → macOS Stage 0 passes.

**Affects both linux-x86_64 AND linux-arm64** (same glibc, same `<sys/file.h>` shape). PR #290's `<stdarg.h>` fix is correct but the build never reaches va_arg processing because the parser dies on line 1187 first.

## 4. Candidate iter-2c fix (NOT pushed · pool-verified intermediate state)

Minimal patch (tested on ubu-2 clone):

```diff
--- a/self/runtime.c
+++ b/self/runtime.c
@@ -11529,6 +11529,7 @@
  * ═════════════════════════════════════════════════════════════════ */
+#undef flock  /* iter-2c: avoid macro replacement of param names inside <sys/file.h> on Linux glibc */
 #include "native/signal_flock.c"
```

Equivalent variants (any of the below would also work — undef restores macro-replacement after the include if needed):

- `#undef flock` immediately before `#include "native/signal_flock.c"` (line 11530).
- Wrap `#define flock(fd,op) ...` with `#ifndef __linux__` or `#ifndef __GLIBC__` — but this risks losing the wrap on Linux (downstream code that uses `flock(fd, LOCK_EX)` would then call libc directly, which is probably fine since signal_flock.c uses the libc form internally already).
- Reorder: place all `#define <stdio/string>` macros AFTER the `#include "native/signal_flock.c"` block (line 11530).

Recommendation: option 1 (`#undef flock` line) — minimal, surgical, preserves the macro for any earlier expansion paths.

## 5. iter-2d surface — x86_64 Linux: hxlcl_* syscall layer is aarch64-only

With the iter-2c patch above applied on pool, Stage 0 progresses past the parser but fails at link:

```
runtime.c: undefined reference to `hxlcl_open_sys`
runtime.c: undefined reference to `hxlcl_write`
runtime.c: undefined reference to `hxlcl_mmap`
runtime.c: undefined reference to `hxlcl_fcntl`
runtime.c: undefined reference to `hxlcl_clock_gettime`
runtime.c: undefined reference to `hxlcl_getpid`
runtime.c: undefined reference to `hxlcl_ioctl`
runtime.c: undefined reference to `hxlcl_close`
runtime.c: undefined reference to `hxlcl_pipe`
runtime.c: undefined reference to `hxlcl_kill`
runtime.c: undefined reference to `hxlcl_waitpid`
…
```

Root cause: `self/runtime.c:937` guards the entire `_hxlcl_syscall1/2/3/4/6` block (and all the `hxlcl_read/write/close/fcntl/ioctl/lseek/pipe/kill/waitpid/fstat/stat/exit/mmap/clock_gettime/getpid/dup2/fork/open_sys/select/poll/getpid` wrappers built on it) with:

```c
#if defined(__arm64__) || defined(__aarch64__)
```

This is **macOS-arm64 + linux-arm64 only**. On x86_64 Linux, these symbols are forward-declared at lines 66-85 but never defined.

The earlier Linux CI logs we read confirm: lines like `self/runtime.c:66:13: warning: 'hxlcl_read' used but never defined` came from GCC's `-Wunused-function`-adjacent diagnostic for `static` decls without definitions. They are now hard linker errors after the parser passes.

This is **iter-2d** (or a re-naming of "linux-x86_64 fundamentally unsupported below the syscall layer until x86_64 inline asm + syscall numbers are added"). It is a much bigger surface than iter-2a/2c — likely requires:
- Adding `#elif defined(__x86_64__) || defined(__amd64__)` branch with the x86_64 syscall ABI (`int 0x80` is 32-bit; need `syscall` instruction + the linux x86_64 syscall numbers, which DIFFER from Darwin numbers; HXLCL_SYS_* table needs platform fork).
- OR providing libc-call fallbacks (extern read/write/close/...) for x86_64 like the `extern long read/write` paths already do for cycle 66 fixes at lines 1001-1042.

Honest read: option B (libc-call fallback) is the closest to what `read/write/close/pipe/dup2/fork` already do (lines 1001-1042) — extending the same pattern to `getpid/kill/fcntl/ioctl/lseek/poll/select/waitpid/fstat/stat/open_sys/exit/mmap/clock_gettime` would unblock linux-x86_64 without rewriting the syscall layer. This is **likely the minimum-viable iter-2d patch** but needs sign-off because:
1. It abandons the "no-libc" purity claim of the syscall layer for x86_64.
2. It may diverge x86_64 behavior from arm64 in subtle ways (Darwin SYS_* vs Linux SYS_* number translation is moot if we just call libc).

**Recommendation**: do NOT attempt iter-2d in this session. Open an audit-only follow-up note + GitHub Issue to scope the choice between (a) full x86_64 syscall port and (b) libc-fallback extension. Discuss with user — this is design-level not just code.

## 6. iter-2b informational cross-link (macOS Stage 1' transpiler `use`-directive gap)

Pool is x86_64 Linux, so iter-2b's macOS-specific transpile chain cannot be fully reproduced. However, the latest CI run (`26248049267`) on main HEAD confirms iter-2b unchanged from Track 19's audit:

```
Undefined symbols for architecture arm64:
  _codegen_emit_ptx_for_sm, _lex, _lower, _lower_hir, _parse, _static_atlas
referenced from: __build_nvptx_emit_driver in main-…o
```

This is **exactly** Track 19's reproducer (`2026-05-22-bootstrap-iter-2b-audit.md` §2). No new information from pool side. Track 19 audit remains authoritative for iter-2b.

The fact that macOS Stage 0 + Stage 1 transpile are now consistently GREEN (1/3 → 2/3 at the per-stage level for macOS alone) means: once iter-2c + iter-2d are fixed for Linux, AND iter-2b is fixed for macOS Stage 1', the bootstrap matrix will be 3-platform × 3-stage = 9 cells, currently 2 green (macOS Stage 0, macOS Stage 1 transpile).

## 7. Honest score table (post-#288 + #290 merge)

| platform     | Stage 0 (compile hexa_v2) | Stage 1 transpile | Stage 1 link (./hexa) |
|--------------|---------------------------|-------------------|-----------------------|
| macos-arm64  | GREEN ✓                   | GREEN ✓           | RED (iter-2b)         |
| linux-x86_64 | RED (iter-2c · flock)     | —                 | —                     |
| linux-arm64  | RED (iter-2c · flock)     | —                 | —                     |

Per-cell green: **2/9** (not "1/9 → ?/9" as task brief assumed — both macOS Stage 0 AND Stage 1 transpile are passing; the Stage 1 LINK is what fails on macOS). The Stage 0 cell jumped from 0/3 to 1/3, but the brief's "1/9" was already counting Stage 0 macOS, so net delta from PR #288+#290 land: +1 cell (macOS Stage 1 transpile, which now runs because Stage 0 produces a usable hexa_v2 transpiler).

## 8. Exit criteria evaluation

- (α) Pool env audited ✓ · PR #290 verify completed ✓ · CI score reported ✓ · audit note landed (this file).
- (β/γ) N/A — pool was fully available.

PR #290 was already merged before this session started; no push action was needed or taken. iter-2c candidate fix is documented but NOT pushed pending design choice for the bigger iter-2d question.

## 9. Recommended next actions

1. **iter-2c PR** (single-line `#undef flock` before signal_flock.c include) — safe to push immediately on its own, but it only unblocks **parser** stage; Linux Stage 0 will then fail at link. Push only if user wants to advance iter-2c independently. Better: bundle iter-2c+iter-2d as a "Linux Stage 0 unblock" PR.
2. **iter-2d design choice** — full x86_64 syscall port vs. libc-fallback extension. Surface as separate issue/RFC.
3. **iter-2b** — Track 19 audit in progress, separate session.
4. **CI matrix**: consider disabling linux-x86_64 + linux-arm64 jobs (or marking them `continue-on-error`) until iter-2d lands, to avoid false-red noise on every push. The bootstrap.yml Option A change in #288 already moved toward selective enable; consider one more step.

## 10. Worktree cleanup

- macOS-side worktree `~/core/hexa-lang-pool-verify` created during this session. Will be removed at end (`git worktree remove --force` + `git branch -D pool-verify-2026-05-22`).
- ubu-2 working tree `~/_hexa_pool_verify/hexa-lang` (~150 MB) — left in place for repeat iteration; user can `rm -rf ~/_hexa_pool_verify` on pool when done.
- ubu-2's pre-existing dirty `~/core/hexa-lang` — UNTOUCHED.

## 11. Demiurge commit

This note + cleanup will be committed in a single demiurge commit at session end.
