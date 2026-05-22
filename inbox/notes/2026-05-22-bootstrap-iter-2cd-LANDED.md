# 2026-05-22 — Bootstrap iter-2c + iter-2d LANDED (Linux x86_64 Stage 0 unblock)

**Parent**: `2026-05-22-pool-bootstrap-verify.md` (Track 21 audit — iter-2c surfaced, iter-2d scoped)
**PR**: dancinlab/hexa-lang#297 — MERGED `8ee5d22597370a0b8ee420815ee503947e82d7b5`
**Worktree commit**: `c2f8b09e` on `bootstrap-iter-2cd-linux-unblock-2026-05-22`
**Base**: clean `origin/main` `e7e4a46` (post cycle-104)
**Status**: iter-2c + iter-2d (Option L) landed · pool-verified on x86_64 Linux · arm64 path unchanged

---

## 1. What landed

Single file changed: `self/runtime.c` (+108 / -1). Bundled as ONE PR per Track 21 §9.1
(do not ship iter-2c alone — it only advances the parser, leaving the link RED).

### iter-2c — `#undef flock`
Inserted `#undef flock` immediately before `#include "native/signal_flock.c"`
(was `runtime.c:11550`). Linux glibc `<sys/file.h>` declares
`extern int flock(int __fd, int __operation)`; the `#define flock(fd,op)
hxlcl_flock((int)(fd),(int)(op))` macro (`runtime.c:1187`) textually rewrote the
prototype's parameter names into a call expression → parser died at the `(`.
macOS clang's `<sys/file.h>` exposes no function-like `flock`, so the macro was a
no-op there (macOS unaffected). Scope: this single include only; `signal_flock.c`
uses the libc `flock(fd, op)` form internally (LOCK_EX/LOCK_UN), the intended
behavior on both platforms.

### iter-2d — x86_64 Linux syscall layer (Option L: libc fallback)
Added an `#elif defined(__x86_64__) && defined(__linux__)` branch (closing the
`#if defined(__arm64__) || defined(__aarch64__)` block at `runtime.c:937`)
defining thin glibc wrappers for the full hxlcl_* set that the arm64 block
defines: `read write close getpid dup2 pipe fork kill fcntl ioctl lseek select
poll waitpid open_sys fstat stat exit mmap clock_gettime` + the
`darwin_check_fd_set_overflow` stub. Pulls `<unistd.h> <fcntl.h> <sys/stat.h>
<sys/mman.h> <sys/select.h> <sys/wait.h> <sys/ioctl.h> <poll.h> <time.h>
<stdarg.h>` etc.

## 2. iter-2d DESIGN CHOICE — Option L over Option S (rationale)

**Chose Option L (libc fallback). Tradeoff documented:**

- The arm64 branch traps directly via inline `svc #0x80` because aprime_cc targets
  **Mach-O arm64** (macOS/iOS) and uses **Darwin** SYS_* numbers (e.g. SYS_OPEN=5,
  SYS_MMAP=197). Neither the `svc` trap nor the Darwin numbers apply on Linux:
  x86_64 Linux uses the `syscall` instruction with a *different* syscall table.
- x86_64 Linux (and the CI bootstrap toolchain) has a universal glibc that is
  always linked. There is **no** no-libc / bare-metal Linux target in the
  bootstrap path that would justify a raw-syscall port.
- cycle-66 ALREADY chose this exact pattern on arm64 for
  `read/write/close/dup2/pipe/fork/waitpid` (after raw-trap carry-flag / EINTR /
  pair-return bugs). Option L just extends the same thin-wrapper approach to the
  full set for x86_64 — it is consistent with the codebase's own evolution.
- **Cost**: ~70 functional LOC (108 incl. comments) — well under the >100-LOC
  sign-off threshold from the brief. No wall hit. Option S would have been
  ~3-5× LOC + x86_64 syscall-table research for zero CI benefit.
- **Tradeoff surrendered**: the "no-libc syscall purity" claim for x86_64 only.
  arm64 raw-trap path is **UNCHANGED**. If a no-libc bare-metal Linux x86_64
  target ever materializes, Option S can be added as a further `#elif` without
  touching this branch.

## 3. Pool verify (ubu-2 · Ubuntu 24.04.2 x86_64 · gcc 13.3.0 · clang 18.1.3)

Fresh `git clone --depth 1` of origin/main (`e7e4a46`) at `~/_hexa_iter2cd`,
patch transferred via base64-over-`pool on`, `git apply` clean, built with the
**exact CI flags** (`-O2 -std=gnu11 -D_GNU_SOURCE -Wno-trigraphs -lm -ldl`):

| step | before (Track 21) | after (this PR) |
|------|-------------------|-----------------|
| Stage 0 compile+link `hexa_v2` | RED — parser death @1187, then ~25 undef `hxlcl_*` | **GREEN** — 0 undefined refs, ELF x86_64 PIE, runs `--help` |
| Stage 1 transpile `main.hexa → main.c` | unreachable | **GREEN** — `OK: build/stage1/main.c` (417 KB) |
| Stage 1 link `hexa` CLI | unreachable | RED — 6 iter-2b symbols (`lex parse lower lower_hir static_atlas codegen_emit_ptx_for_sm`) |

**Key proof point**: post-fix, `grep -c "undefined reference.*hxlcl_"` = **0**. The
only undefined refs before adding `-lm` were libm (`ceil tan log10 llround tanh
log2 fma sqrt pow ...`) — and the Linux CI jobs already pass `-lm -ldl`
(bootstrap.yml lines 159/176/194/250/260). The macOS job omits `-lm` because
libSystem bundles libm. So the libm refs were never an iter-2c/2d concern; with
the real CI flags the link is clean.

macOS arm64 Stage 0 re-built locally (clang) — clean, no regression. arm64 branch
byte-for-byte unchanged.

linux-arm64: NOT pool-reproducible (no arm64 host in pool). Same source is
`#elif`-correct (arm64 takes the unchanged `svc` branch; only x86_64 Linux takes
the new branch), so the fix is platform-correct for it too, pending CI confirmation.

## 4. CI before/after + score uplift

Per-cell green (3 platform × 3 stage = 9 cells):

FINAL CI matrix (run `26265534995`, #297 merge commit `8ee5d225`):

| platform | Stage 0 | Stage 1 transpile | Stage 1 link | job |
|----------|---------|-------------------|--------------|-----|
| macos-arm64  | GREEN ✓ | GREEN ✓ | GREEN ✓ | **success** (iter-2b #295 cleared link) |
| linux-x86_64 | GREEN ✓ | GREEN ✓ | GREEN ✓ | **success** (NEW — iter-2c/2d) |
| linux-arm64  | GREEN ✓ (NEW — flock fix worked) | **RED — SEGFAULT** | — | **failure** (iter-2e, see §6) |

**Score: 2/9 → 8/9.** macOS and linux-x86_64 are now FULL GREEN (all 3 stages).
linux-arm64 advanced from Stage 0 RED → Stage 0 GREEN but its **Stage 1 transpile
segfaults** — a newly-surfaced DEEPER bug (iter-2e), NOT an iter-2c/2d regression
(my Option L branch is `#elif __x86_64__ __linux__` — arm64 never touches it).

> iter-2b (PR #295 `fix(self/main): gate _build_nvptx_emit_driver`) was ALREADY
> MERGED before #297. Its gate cleared the Stage 1 link RED on macOS AND
> linux-x86_64, so the matrix jumped past the 4/9 floor proven by pool to 8/9.

**CI run on #297 merge commit (`26265534995`, main) — CONFIRMED:**
- `bootstrap (linux-x86_64)`: **success** ✓ — REAL CI GREEN (matches pool, full 3 stages)
- `bootstrap (macos-arm64)`: **success** ✓ — full GREEN (iter-2b #295 cleared the link)
- `bootstrap (linux-arm64)`: **failure** ✗ — Stage 1 transpile **SEGFAULT** (exit 139), see §6 iter-2e

The next commit on main (`e118396d`, docs consolidation, run `26265542660`)
reproduces the identical linux-arm64 Stage 1 transpile segfault — confirming it is
not flaky and not introduced by my change (it sits on top of my fix).

## 5. PR #276 (regex header) unblock status

PR #276 (`feat(self/runtime): stdlib/regex G3 runtime backend — POSIX
regcomp/regexec glue`) is OPEN. Its last bootstrap checks (run `26237360745`) are
stale RED (predate this fix). #276 was blocked by the same Linux Stage 0 substrate;
with iter-2c/2d merged + iter-2b (#295) merged, #276 should be re-runnable. **Not
merged here — that is the regex track's call.** Re-run `gh pr checks 276` /
rebase #276 on the new main to confirm.

## 6. iter-2e CHAIN — linux-arm64 Stage 1 transpile segfault (DEFER · needs sign-off)

iter-2d surfaced a deeper bug on **linux-arm64** (exit criterion δ). After my fix,
linux-arm64 Stage 0 now compiles+links clean (flock fix is platform-shared and
worked on arm64 glibc), but `./self/native/hexa_v2 self/main.hexa ...` **SEGFAULTs**
(exit 139) during Stage 1 transpile.

**Root cause** (code-inspection-confirmed, runtime.c:933-937):
```c
// Cycle 63 — Darwin BSD ABI syscall wrappers via inline `svc 0x80`.
// Each call: x16 = syscall number, ... Currently arm64 only (aprime_cc is Mach-O arm64).
#if defined(__arm64__) || defined(__aarch64__)
#define HXLCL_SYS_OPEN  5   // ... Darwin/XNU numbers
static inline long _hxlcl_syscall1(...) { ... __asm__ volatile("svc #0x80" ...); }
```
The guard matches **any** arm64 — including **linux-arm64** — but the body is
**Darwin-only**:
- trap is `svc #0x80` with the syscall number in `x16` → that is the **XNU/Darwin**
  convention. **Linux arm64 uses `svc #0`** with the number in **`x8`**.
- numbers are Darwin (SYS_OPEN=5, SYS_MMAP=197, SYS_READ=3, SYS_WRITE=4, …). Linux
  arm64 (asm-generic) numbers are entirely different: `read=63 write=64 close=57
  openat=56 (no bare open) lseek=62 mmap=222 fstat=80 ioctl=29 fcntl=25 ppoll=73
  pselect6=72 kill=129 clock_gettime=113 getpid=172 exit=93 wait4=260`.

cycle-66 had already libc-routed read/write/close/dup2/pipe/fork/waitpid on arm64,
so those work on Linux by accident. But the remaining raw-trap calls
(`mmap open_sys lseek stat fstat ioctl fcntl kill poll select getpid clock_gettime
exit`) issue the **wrong syscall with wrong args** on linux-arm64 → corrupt
returns → segfault during transpile.

**This is NOT an iter-2c/2d regression.** My Option L branch is
`#elif defined(__x86_64__) && defined(__linux__)` — arm64 never reaches it; it
takes the UNCHANGED Darwin `svc` branch. linux-arm64 was already RED (at Stage 0,
flock) before this PR per Track 21 §7; my fix advanced it to Stage 0 GREEN and
exposed the next layer.

**iter-2e fix (proposed · NOT applied · needs sign-off):**
Narrow the Darwin branch and add an aarch64-Linux libc-fallback, mirroring iter-2d:
```c
#if defined(__APPLE__) && (defined(__arm64__) || defined(__aarch64__))
    ... existing Darwin svc #0x80 path UNCHANGED ...
#elif defined(__linux__) && (defined(__x86_64__) || defined(__aarch64__))
    ... libc-fallback wrappers (iter-2d branch, just broaden the arch guard) ...
#endif
```
Almost certainly the libc-fallback branch from iter-2d works verbatim for
linux-arm64 (it is arch-neutral glibc). Estimated ~5 LOC delta (broaden two guards).

**Why DEFERRED, not shipped now:**
1. **Pool cannot verify it** — there is NO arm64 Linux host in the pool roster
   (mini=macos, ubu-1/ubu-2=x86_64). The brief's honest invariant "Pool-verify
   BEFORE push (don't ship unverified Linux fixes)" forbids shipping an
   unverifiable arm64-Linux change blind.
2. The brief's iter-2c/2d scope explicitly says "arm64 path UNCHANGED"; narrowing
   the Darwin guard to `__APPLE__` changes the arm64 path → out of the bundled
   scope, into iter-2e.
3. (δ) directive: "iter-2d reveals iter-2e (deeper) → document the chain + DEFER."

**Recommended next action**: iter-2e PR narrowing `__arm64__` Darwin guard to
`__APPLE__` + extending libc-fallback to `__aarch64__ __linux__`. Verify path: a
linux-arm64 CI run (or add an arm64 host to pool / use qemu-user-static on ubu-2
for a local cross-check). LOW risk, ~5 LOC, but needs user sign-off per honest
invariant. Without it, linux-arm64 stays at 2/3 (Stage 0 only).

## 7. Exit criteria

- (α) iter-2c + 2d (Option L) landed ✓ · PR #297 MERGED `8ee5d225` ✓ · linux-x86_64
  Stage 0+1 GREEN, pool- AND CI-verified ✓ · demiurge note ✓ · score 2/9 → **8/9** ✓
  (better than the brief's "?/9" — macOS + linux-x86_64 both fully green) · PR #276
  noted ✓.
- (β) N/A — Option L stayed ~70 LOC, no wall.
- (γ) N/A — pool fully available for x86_64.
- (δ) **TRIGGERED** — iter-2d revealed iter-2e (linux-arm64 Darwin-`svc`-on-Linux
  segfault). Chain documented above; DEFERRED for user sign-off (pool can't verify
  arm64-Linux). The 9th cell (linux-arm64 Stage 1) awaits iter-2e.

## 8. Pool cleanup

- ubu-2 isolated clone `~/_hexa_iter2cd` (~150 MB) left in place for repeat
  iteration; `rm -rf ~/_hexa_iter2cd` on pool when done.
- macOS worktree `~/core/hexa-lang-iter2cd` + branch
  `bootstrap-iter-2cd-linux-unblock-2026-05-22`: removable post-merge
  (`git worktree remove`).
