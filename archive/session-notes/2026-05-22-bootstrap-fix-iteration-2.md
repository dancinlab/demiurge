# 2026-05-22 — hexa-lang bootstrap fix iteration 2 — gap log

**Parent**: `2026-05-22-bootstrap-option-a-fix-attempt.md`
**PR (iteration 1)**: https://github.com/dancinlab/hexa-lang/pull/288
**Status**: Iteration 1 (Option A) landed but surfaced two latent
failure modes previously masked by the Stage 0 link break.

---

## Sub-track 2a — Linux Stage 0 `<stdarg.h>` missing

### Symptom

On `ubuntu-latest` (GCC) and `ubuntu-24.04-arm` (GCC), Stage 0
compile of `self/runtime.c` fails at line 395:

```
self/runtime.c:395:50: error: expected expression before 'int'
   if (*fmt == '*') { prec = va_arg(ap, int); fmt++; ... }
```

…cascading through ~25 similar errors at every `va_arg(ap, TYPE)`
call site (lines 395, 405, 407, 418-420, 428-430, 435-438, 449,
1186, 1525, …) and `va_list ap` declarations.

### Root cause

`self/runtime.c` includes `<stdio.h>` (line 6), `<stdlib.h>` (7),
`<string.h>` (8), `<stdint.h>` (9), etc. — but **does not include
`<stdarg.h>`**. On macOS clang + Xcode SDK, `<stdio.h>` transitively
exposes the va-arg machinery; on Linux glibc, it does not.

This bug was dormant for all 500 prior CI runs because `runtime.c`
was never compiled by the bootstrap workflow at all. Iteration 1's
fix surfaces it for the first time.

### Smallest fix

Add one line to `self/runtime.c` (after line 9 `#include <stdint.h>`):

```c
#include <stdarg.h>     // va_list / va_arg — explicit for GCC/glibc
```

ETA: 1 minute. Trivially testable on a Linux runner. No
behavioural change on macOS (already included transitively).

### Scope constraint

Out of scope for the iteration-1 session (briefing forbade
modifications to `runtime.c`). Either:
- A follow-up PR from someone with hexa-lang push access, or
- An iteration-2 session that explicitly authorizes the
  `runtime.c` touch.

### Wipe-governance concern

Per the in-tree `2026-05-22-wipe-governance-proposal.md`, isolated
single-line edits in `runtime.c` are safe; the dangerous pattern is
**batch regenerations of `hexa_cc.c` together with `runtime.c`**
where a stale worktree replace silently drops one of them. This
fix is a pure `#include` add — minimal regen surface.

---

## Sub-track 2b — macOS Stage 1' `use` directive resolution

### Symptom

On `macos-latest`, Stage 0 PASSES (proving iteration 1's fix
works on macOS). Stage 1' then fails at link time:

```
Undefined symbols for architecture arm64:
  "_codegen_emit_ptx_for_sm", referenced from:
      __build_nvptx_emit_driver in main-…o
  "_lex", referenced from: __build_nvptx_emit_driver
  "_lower", referenced from: __build_nvptx_emit_driver
  "_lower_hir", referenced from: __build_nvptx_emit_driver
  "_parse", referenced from: __build_nvptx_emit_driver
  "_static_atlas", referenced from: __build_nvptx_emit_driver
```

### Root cause

`self/main.hexa` top of file (lines 10-16):

```hexa
use "compiler/lex/lexer"
use "compiler/parse/parser"
use "compiler/lower/ast_to_hir"
use "compiler/lower/hir_to_mir"
use "compiler/atlas/static_index"
use "compiler/ir/mir"
use "compiler/codegen/nvptx_target"
```

These imports are supposed to bring the `lex`, `parse`, `lower`,
`lower_hir`, `static_atlas`, `codegen_emit_ptx_for_sm` symbols
into the compilation unit emitted by the transpiler. Examination
of `build/stage1/main.c` (the transpiled output) shows:
- `_build_nvptx_emit_driver` body is present and **calls** these
  symbols (at line 4619 of the 7455-line transpiled file)
- but **no function bodies** for `lex`, `parse`, `lower`,
  `lower_hir`, `codegen_emit_ptx_for_sm`, `static_atlas` are
  emitted into the same `main.c`.

The `.hexa` source files exist:
- `compiler/lex/lexer.hexa:106` `pub fn lex(source, file) -> [Token]`
- `compiler/parse/parser.hexa:2191` `pub fn parse(tokens, file) -> Module`
- `compiler/lower/ast_to_hir.hexa:2222` `pub fn lower(module, atlas) -> HModule`
- `compiler/lower/hir_to_mir.hexa:2895` `pub fn lower_hir(module) -> MModule`
- `compiler/atlas/static_index.hexa:88` `pub fn static_atlas() -> AtlasIndex`
- `compiler/codegen/nvptx_target.hexa:2815` `pub fn codegen_emit_ptx_for_sm(module, sm) -> string`

So the source is there, the call sites are wired correctly, but
the transpiler is not inlining the `use`-imported bodies.

Possibilities:
1. The current `hexa_cc.c` (transpiler) drops `use` directives
   silently or doesn't follow `compiler/` paths (`self/main.hexa`'s
   other `use` references inside `self/` may be inlined, while
   `compiler/` may be unreachable from `self/main.hexa`'s
   import-resolution path).
2. The transpiler emits separate `.c` files per module and CI is
   expected to compile/link all of them — in which case bootstrap.yml
   needs more `.c` files in the link line.
3. The `_build_nvptx_emit_driver` body was supposed to be guarded
   by a feature flag and CI is now exercising a codepath that
   the transpiler doesn't expect to be wired through.

### Required investigation

Examine `self/codegen_c2.hexa` and/or `self/native/hexa_cc.c`
around its `use`-directive handling. Find whether (a) `use` is
honored for `compiler/` paths or (b) `compiler/*.hexa` files are
expected to be transpiled separately and linked.

### Scope

This is **transpiler internals work** — beyond CI plumbing. Likely
sits with the compiler / self-host cohort. Out of scope for
bootstrap-CI fix sessions.

### Workaround (if iteration 2b is blocked)

Two options to make CI green without fixing the transpiler:

1. **Skip Stage 1' / 1-Smoke on macOS** until 2b lands — keep
   Stage 0 as the only enforced gate. This was the implicit
   posture for the original `dea25048` "commit hexa_v2 binary"
   approach. Workflow edit: wrap Stages 1-Smoke in
   `if: env.STAGE1_ENABLED == 'true'` or split into separate
   workflow `bootstrap-stage1.yml` marked as `continue-on-error`.

2. **Add the `compiler/*.hexa` files** to the transpile inputs
   manually — run `hexa_v2 compiler/lex/lexer.hexa
   build/stage1/lex.c`, etc., then link all `.c` files together.
   Brittle and large surface; not recommended.

### Recommended posture

Document the gap, keep the iteration-1 PR open, get the `<stdarg.h>`
fix from sub-track 2a landed to unblock Linux. Then the bootstrap
matrix is 1/3 green (macOS Stage 0) + 2/3 RED on different bugs.
Better than 0/3 RED on the same bug. PR #276 can land on macOS
signal alone, with a maintainer-discretion override on Linux red.

---

## Aggregate state

| Stage     | macOS | Linux x64 | Linux arm64 | Iteration to fix |
|-----------|-------|-----------|-------------|------------------|
| Stage 0   | GREEN | RED       | RED         | 2a (stdarg.h)    |
| Stage 1'  | RED   | unreached | unreached   | 2b (use dirs)    |
| Smoke     | unreached | unreached | unreached | 2b               |

Pre-fix: 0/9 (all stages, all platforms) RED on 1 cause.
Post-fix iter 1: 1/9 GREEN, 8/9 RED on 2 causes.
Post-fix iter 2a: would be 3/9 GREEN (all 3 Stage 0), 6/9 RED on 1 cause.
Post-fix iter 2a+2b: would be 9/9 GREEN.

## Anchors

- Parent attempt log: `2026-05-22-bootstrap-option-a-fix-attempt.md`
- Original audit: `2026-05-22-pr276-bootstrap-ci-diagnostic.md`
- PR (iter 1): https://github.com/dancinlab/hexa-lang/pull/288
- CI run: https://github.com/dancinlab/hexa-lang/actions/runs/26244746182
- macOS Stage 1' job: https://github.com/dancinlab/hexa-lang/actions/runs/26244746182/job/77240061312
- Linux x86_64 job: https://github.com/dancinlab/hexa-lang/actions/runs/26244746182/job/77240061396
- Linux arm64 job: https://github.com/dancinlab/hexa-lang/actions/runs/26244746182/job/77240061266
