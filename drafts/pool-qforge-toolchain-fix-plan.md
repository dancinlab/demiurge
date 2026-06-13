---
slug: pool-qforge-toolchain-fix
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) for any codegen/transpiler fix · pool hosts via `sidecar pool on`
target: make qforge RUN on the free pool linux hosts (summer · aiden) so QFORGE validation is free, no rent
---

## task brief
This session found the pool linux hosts cannot run qforge — so "validate QFORGE pieces on
the free pool" (the user's strategy) is blocked, forcing mini-only. Fix the toolchain so
summer + aiden can run a qforge selftest. Two DISTINCT failures:
- **summer**: JIT C-build fails on glibc `malloc.h`.
- **aiden**: `hexa_v2` transpiler SEGFAULTs on multi-module qforge ("compiled module_loader not found").

## locked decisions (@L)
- @L1 (summer): diagnose the JIT C-build failure. Most likely the hexa C-codegen emits a
  deprecated `#include <malloc.h>` (removed/relocated on modern glibc) where it should use
  `<stdlib.h>` (or guard with `#if __has_include`). If it's a codegen bug → fix in hexa-lang
  (the C-emit path) — a real PR (d8). If it's a missing host dev-header/toolchain → install the
  needed package on summer via `sidecar pool on summer '<cmd>'` (build-essential / libc-dev).
  Determine WHICH by reading the actual build error verbatim first.
- @L2 (aiden): diagnose the hexa_v2 transpiler SEGV on multi-module qforge. First suspect:
  aiden's `~/.hx` install is STALE (prior session memory flagged a stale ~/.hx/src). Try a clean
  resync + rebuild of hexa on aiden (`hx install` / the repo's bootstrap). If a freshly-built
  toolchain STILL SEGVs on multi-module qforge → it is a real transpiler bug → minimal repro +
  hexa-lang PR/inbox (d8). Do NOT paper over a real SEGV.
- @L3 (verify): after each fix, prove it via `sidecar pool on <host> '<run a qforge selftest>'`
  (e.g. a small qforge stdlib selftest that exercises multi-module load + the C-JIT path). Paste
  the PASS verdict VERBATIM per host. The success criterion = qforge selftest PASS on summer AND aiden
  (or, per host, an HONEST "blocked by <exact reason>" if a host genuinely can't be fixed cheaply).
- @L4 (safe/scope): g9 — pool access ONLY via `sidecar pool on <host>` (never raw ssh). Do NOT
  touch the live gate pods (38943553/38922322/38704336) or the running background agents
  (ac71837 QE-recover, a3e1d69 Al-validate). pi5-akida (ARM) + ghost (macOS) are out of scope —
  qforge targets are the x86 linux hosts summer + aiden. Per-host env changes are reversible
  (package installs / a clean ~/.hx rebuild); a hexa-lang codegen fix is a normal PR.
- @L5 (std/d8): any fix that belongs in the toolchain (malloc.h codegen, transpiler SEGV) lands
  as a hexa-lang PR (self-merge, worktree off origin/main, ~/.hx/src untouched) + the pool-host
  side re-pulls/rebuilds. g5 selftest. Paste verdicts verbatim. g4 <200 lines/concern.

## guards
- HONEST (d6): if a host can't be fixed within reasonable effort, report the EXACT blocker
  (verbatim error + what was tried) — do NOT fake a PASS or claim the pool works when it doesn't.
- d8: a hexa-lang-level bug → `sidecar handoff add hexa-lang` and/or a PR; do not bake a per-host
  workaround that hides an upstream toolchain bug.

## final report
per host (summer, aiden): the diagnosed root cause (verbatim error), the fix applied
(host package install / clean ~/.hx rebuild / hexa-lang PR#), the verify verdict VERBATIM
(`sidecar pool on <host>` qforge selftest PASS or honest blocked-by), any hexa-lang PR# / handoff id,
demiurge commit sha (QFORGE-PERF.log.md or QFORGE-PROCESS.log.md row, commit-only no push).
