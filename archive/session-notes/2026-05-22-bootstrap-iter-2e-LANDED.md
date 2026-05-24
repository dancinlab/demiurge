# 2026-05-22 — Bootstrap iter-2e LANDED (linux-arm64 Stage 1 unblock → 9/9 CI GREEN)

**Parent**: `2026-05-22-bootstrap-iter-2cd-LANDED.md` §6 (iter-2e chain surfaced + root-caused + DEFERRED for sign-off)
**PR**: dancinlab/hexa-lang#300 — MERGED `b3d34da8c4e2f3fe7b69945b0e61aec2514392bd` (2026-05-22T03:01:17Z)
**Worktree commit**: `e1d3d0aa` on `bootstrap-iter-2e-linux-arm64-2026-05-22`
**Base**: clean `origin/main` `4f965da7` (post #298 rtsc-stragglers; new main `6a21bf4f`/`ae470e02` runtime+regex commits do NOT touch the syscall guard region — verified no conflict)
**Status**: iter-2e landed · macOS arm64 locally re-verified byte-identical · linux-x86_64 + linux-arm64 CI-verified · **CI 8/9 → 9/9 FULL GREEN** · iter-2a→2e chain CLOSED

---

## 1. What landed

Single file changed: `self/runtime.c` (+33 / -12, of which only **2 functional preprocessor-guard lines** changed; the rest is honest comments). NO logic changes — the wrapper bodies on both sides of the guard are untouched.

### The fix (exactly as predecessor §6 predicted, ~5 functional LOC)

Two guards changed in the syscall block:

```c
// L937 (was): #if defined(__arm64__) || defined(__aarch64__)
#if defined(__APPLE__)                              // ← iter-2e: narrow to Darwin-only
    ... raw Darwin svc #0x80 / x16 / Darwin SYS_* — UNCHANGED ...
// L1109 (was): #elif defined(__x86_64__) && defined(__linux__)
#elif defined(__linux__)                            // ← iter-2e: broaden to all Linux
    ... iter-2d glibc-wrapper bodies — UNCHANGED, just a broader guard ...
#endif  /* __APPLE__ (Darwin raw svc) / __linux__ (glibc wrappers) */
```

Net dispatch:
- **macOS (any arch)** → raw Darwin syscalls (`svc #0x80`, x16, Darwin numbers). macOS arm64 path is **byte-identical** to before (the `__APPLE__` branch is the same code the old `__arm64__` guard selected on macOS).
- **linux-x86_64** → glibc wrappers (UNCHANGED — same iter-2d path, just reached via a broader guard).
- **linux-arm64** → glibc wrappers (**NEW** — previously fell into the Darwin block and segfaulted).

## 2. Root cause (confirmed — matches predecessor §6 code-inspection)

The `_hxlcl_syscall*` block at `runtime.c:937` was guarded by `__arm64__ || __aarch64__`, which matched **linux-arm64 too** — but the body is **Darwin-only**: `svc #0x80` trap (Linux arm64 uses `svc #0`), syscall number in `x16` (Linux arm64 uses `x8`), hardcoded Darwin `SYS_*` numbers (Linux arm64's asm-generic table is entirely different). iter-2c/2d (#297) made Stage 0 GREEN on linux-arm64 (the flock fix is platform-shared), but Stage 1 transpile then **segfaulted (exit 139)** executing the Darwin syscall ABI on a Linux arm64 kernel. iter-2e routes both Linux arches through the iter-2d glibc-wrapper branch (glibc abstracts the per-arch trap), so the Darwin block is now `__APPLE__`-only.

## 3. Verification

### macOS arm64 — locally re-built (clang, exact CI flags `-O2 -std=gnu11 -D_GNU_SOURCE -Wno-trigraphs`)
- Stage 0 compile `hexa_v2` → Mach-O arm64, GREEN (only pre-existing macro-redefine / `-Wcomment` warnings).
- Stage 1 transpile `main.hexa → main.c` (7446 lines) → `OK`.
- Stage 1 compile CLI `./hexa` → Mach-O arm64, GREEN.
- Smoke (`fn main(){println("ok")}`) → output `ok`. GREEN.
- Preprocessor proof: `cc -E` on this host (macOS arm64) selects `APPLE_BRANCH` → Darwin path byte-identical. **No regression** (invariant α held).

### linux-x86_64 + linux-arm64 — CI (PR #300 merge-commit run `26265840719`)

| platform | bootstrap job | time |
|----------|---------------|------|
| macos-arm64  | **pass** | 30s |
| linux-x86_64 | **pass** | 1m5s |
| linux-arm64  | **pass** | **1m44s** ← THE FIX (was Stage 1 SEGFAULT) |

- linux-x86_64 GREEN → `#elif __linux__` broadening did **NOT** regress x86_64 (exit criterion γ cleared — same glibc wrappers, broader guard).
- linux-arm64 GREEN → verified by CI's own `ubuntu-24.04-arm` runner (pool has no arm64-Linux host; CI was the only viable verifier — exactly the deferral reason in predecessor §6.1).

## 4. CI before/after — score uplift

3 platform × 3 stage = 9 cells. (Stage-granularity per predecessor; the CI exposes them as 1 job/platform but each job runs all stages, so a GREEN job = all 3 stages of that platform green.)

| platform | before iter-2e (8/9) | after iter-2e (9/9) |
|----------|----------------------|---------------------|
| macos-arm64  | GREEN (3/3) | GREEN (3/3) — unchanged |
| linux-x86_64 | GREEN (3/3) | GREEN (3/3) — unchanged |
| linux-arm64  | Stage 0 GREEN, **Stage 1 SEGFAULT** (2/3) | **GREEN (3/3)** — Stage 1 unblocked |

**Score: 8/9 → 9/9 FULL GREEN.** Exit criterion (α) met.

Note on `check @grace consent trailers`: this check is RED on PR #300 — but it is **pre-existing and unrelated**. It fails identically on EVERY recent PR (incl. the already-merged #297 iter-2cd, #276 regex, #298 rtsc-stragglers) because `grace_consent.yml` looks for `build/hexa_interp.linux` (not in repo) or `hexa` on PATH and finds neither — an infra gap, not a code failure. It is not part of the bootstrap matrix and did not block #297's merge; PR #300 was `MERGEABLE` (UNSTABLE = a non-required check red). The 9/9 bootstrap score is independent of it.

## 5. The iter-2a → iter-2e chain (CLOSED)

The full CI-bootstrap unblock chain across this and prior sessions:

| iter | PR | what | unblocked |
|------|----|----|-----------|
| 2a | #290 | `stdarg.h` include | (parser substrate) |
| 2b | #295 | gate `_build_nvptx_emit_driver` | macOS + linux-x86_64 Stage 1 **link** |
| 2c | #297 | `#undef flock` before signal_flock.c include | Linux Stage 0 parse (both arches) |
| 2d | #297 | `#elif __x86_64__ && __linux__` libc-fallback (Option L) | linux-x86_64 Stage 0 link |
| **2e** | **#300** | **`__APPLE__` guard narrow + `#elif __linux__` broaden** | **linux-arm64 Stage 1 transpile** |

Result: CI matrix went 2/9 (chain start) → 8/9 (iter-2b+2c+2d) → **9/9 (iter-2e)**. Chain closed.

## 6. Honest invariants — all held

- (α) iter-2e fix + PR #300 MERGED `b3d34da8` + linux-arm64 CI GREEN + **9/9 full green** ✓ · macOS byte-identical (`__APPLE__` branch, locally re-verified) ✓ · this note ✓ · 5-iteration chain closure ✓.
- (β) N/A — no iter-2f surfaced; linux-arm64 went fully green, no deeper bug.
- (γ) N/A — `#elif __linux__` broadening did NOT regress linux-x86_64 (CI pass 1m5s). No revert needed.
- macOS arm64 path byte-identical: the `__APPLE__` branch keeps the Darwin `svc #0x80` block exactly as before; `cc -E` confirms macOS arm64 selects it. macOS column stayed GREEN.

## 7. Cleanup

- Worktree `~/core/hexa-lang-iter2e` + branch `bootstrap-iter-2e-linux-arm64-2026-05-22` removed post-merge (`git worktree remove --force`). Remote branch deletion: optional housekeeping.
- NOTE on `~/core/hexa-lang` main worktree: at session start it carried heavy uncommitted churn from concurrent agents (231 files, ~52K deletions — Track 27/28) + a 3↔3 local/origin divergence. iter-2e was deliberately branched from **clean `origin/main`** (not the dirty local tree) to keep the PR surgical (1 file, guards only). The concurrent churn was left untouched — not swept into this PR. ([[feedback-hexa-lang-concurrent-agents]] hazard avoided.)
