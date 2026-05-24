# Bootstrap CI regression — iter-2b + iter-2e re-applied (wipe reverted) · LANDED

> Date: 2026-05-22
> Trigger: infra check found hexa-lang CI regressed 9/9 → fail (macOS + linux-x86_64 + linux-arm64) after the iter-2a→2e chain had reached 9/9 green at `b3d34da8`.
> Resolution: PR #306 (`c972e655` MERGED) re-applies iter-2b + iter-2e gates → 9/9 restored.

## Root cause — `bf406f08` 317-file wipe reverted TWO landed fixes

The `bf406f08` governance-rebase incident (317-file accidental wipe · restored by `a2a17a0a` #303) reverted both:

1. **iter-2b** (PR #295 · `self/main.hexa`) — `_build_nvptx_emit_driver` gate. Revert brought back 6 undefined symbols at Stage 1 link (`lex` / `parse` / `static_atlas` / `lower` / `lower_hir` / `codegen_emit_ptx_for_sm` — bodies in `compiler/` modules not linked by bootstrap.yml Stage 1). Broke macOS + linux-x86_64 Stage 1 link.
2. **iter-2e** (PR #300 · `self/runtime.c`) — Darwin syscall guard narrow. Revert restored `#if defined(__arm64__) || defined(__aarch64__)` at L937 which matches Linux arm64 but the body is Darwin-only (`svc #0x80` + x16 + Darwin SYS_*). Broke linux-arm64 (Stage 1 segfault). (iter-2d's libc-fallback block at L1109 survived; only iter-2e's guard-broadening was reverted.)

This is [[project-hexa-lang-recurring-wipes]] in action — hard-won fixes silently reverted by a stale-tree governance rebase. The 9/9 green at `b3d34da8` was real but transient.

## Diagnosis method — ubu-2 (user directive "ubu-2 에서 진행")

pool:ubu-1 was auth-broken (Permission denied · QE host) so used **pool:ubu-2** (Ubuntu 24.04 x86_64 · gcc 13.3.0):
1. Fresh `origin/main` clone → ran full bootstrap (Stage 0 → Stage 1 transpile → Stage 1 compile → smoke) with exact CI commands.
2. Isolated the break: Stage 1 compile fails with the 6 iter-2b symbols (after correcting two of my own reproduction errors: missing `-lm -ldl` continuation, missing `mkdir -p build/stage1`).
3. Confirmed iter-2b gate gone from `self/main.hexa::_build_nvptx_emit_driver` (live `codegen_emit_ptx_for_sm` call at L1903).

## Fix (PR #306 · 2 commits)

- **iter-2b regate** (`a29086f4` · `self/main.hexa`) — gated live MIR pipeline (commented · `return 1` + `[nvptx] GATED` message). **ASCII-only println** — first re-apply attempt used multi-byte UTF-8 (`—` `·`) in the string literal and `hexa_v2` transpiler **silently failed** (exit 0 · no output · no "OK"). ASCII-only fixed it. ⚠️ **NEW transpiler limitation finding**: hexa_v2 lexer chokes on multi-byte UTF-8 inside string literals (comments are fine).
- **iter-2e regate** (`32174aa6` · `self/runtime.c`) — L937 `(__arm64__||__aarch64__)` → `__APPLE__` · L1109 `(__x86_64__ && __linux__)` → `__linux__`. Identical to merged PR #300.

## Verification

- **ubu-2 (linux-x86_64)**: full bootstrap GREEN — Stage 0 + Stage 1 transpile (7453 lines · 6 calls gated) + Stage 1 compile (hexa binary) + `./hexa version` (0.1.0-dispatch) + smoke "ok".
- **CI (PR #306)**: bootstrap **3/3 PASS** (linux-arm64 + linux-x86_64 + macos-arm64). Merge `c972e655`.
- (linux-arm64 verified by CI's own arm64 runner — pool has no arm64-Linux host.)

## Residual

- `check @grace consent trailers` STILL red on every PR — pre-existing infra gap (missing `build/hexa_interp.linux`) · separate from bootstrap matrix · NOT addressed here (deferred · see next-session list).
- **pool:ubu-1 auth-broken** — §9.12 hydride DFT (QE 7.5 on ubu-1) blocked until key restored (user-side action).
- **Re-wipe risk**: wipe-guard hardened post-bf406f08 (#305 Tier 2 tree-wide + Tier 3 protected-subtree). If iter-2b/2e revert AGAIN, re-apply from this note (the 3 guard changes: main.hexa gate · runtime.c L937 + L1109).

## Anchors

- hexa-lang PR #306 (`c972e655` MERGED · iter-2b + iter-2e regate)
- PR #295 (original iter-2b) · PR #300 (original iter-2e) · `bf406f08` (the wipe) · `a2a17a0a`/#303 (restore) · #305 (wipe-guard harden)
- [[project-hexa-lang-recurring-wipes]] · [[feedback-hexa-lang-main-land-via-pr]]
- pool:ubu-2 fresh-clone reproduction (gcc 13.3.0 · exact CI commands)
