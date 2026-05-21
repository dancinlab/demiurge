# 2026-05-22 — hexa-lang bootstrap iter-2b — macOS Stage 1' transpiler `use`-directive resolution gap (AUDIT-ONLY)

**Parent**: `2026-05-22-bootstrap-fix-iteration-2.md` (sub-track 2b spec)
**Predecessor PR (iter-1, MERGED)**: dancinlab/hexa-lang#288 `e3938aec` → main `45ee2018`
**Predecessor PR (iter-2a, OPEN)**: dancinlab/hexa-lang#290 `b78e1c71`
**hexa-lang main HEAD**: `38b89c89` (audit base)
**Audit branch**: `iter-2b-audit-v2` worktree at `~/core/hexa-lang-iter2b-audit-v2` (read-only · removed at end)
**Status**: AUDIT-ONLY · 0 hexa-lang commits · 1 demiurge note commit

---

## 1. Reproducer (local · macOS arm64 · 1:1 with CI)

Stage 0 + Stage 1' from current bootstrap.yml against current `self/native/hexa_cc.c`:

```bash
cd ~/core/hexa-lang
git fetch origin && git checkout 38b89c89

mkdir -p self/native build/stage1
clang -O2 -std=gnu11 -D_GNU_SOURCE -Wno-trigraphs \
    -I self self/native/hexa_cc.c self/runtime.c \
    -o self/native/hexa_v2                     # Stage 0 PASS (matches CI)

./self/native/hexa_v2 self/main.hexa build/stage1/main.c
# → OK: build/stage1/main.c · 7455 lines · Stage 1 transpile PASS

clang -O2 -std=gnu11 -D_GNU_SOURCE -Wno-trigraphs \
    -I self build/stage1/main.c self/runtime.c \
    -o hexa                                    # Stage 1' FAIL — 6 undefined symbols
```

Confirmed identical to CI run `26248049267` macOS job `77251462180`: Stage 0 GREEN, Stage 1 transpile GREEN, Stage 1' link RED. Reproducer is exact.

## 2. Symbol list — 6 undefined symbols at Stage 1' link

```
Undefined symbols for architecture arm64:
  "_codegen_emit_ptx_for_sm", referenced from: __build_nvptx_emit_driver in main-…o
  "_lex",                     referenced from: __build_nvptx_emit_driver in main-…o
  "_lower",                   referenced from: __build_nvptx_emit_driver in main-…o
  "_lower_hir",               referenced from: __build_nvptx_emit_driver in main-…o
  "_parse",                   referenced from: __build_nvptx_emit_driver in main-…o
  "_static_atlas",            referenced from: __build_nvptx_emit_driver in main-…o
ld: symbol(s) not found for architecture arm64
```

Every reference is from `_build_nvptx_emit_driver` only (self/main.hexa:1842-1868). No other call sites in the whole stage1 main.c.

## 3. `use` directive trace

`self/main.hexa` lines 10-16:

```hexa
use "compiler/lex/lexer"             // → compiler/lex/lexer.hexa:106     pub fn lex(source, file) -> [Token]
use "compiler/parse/parser"          // → compiler/parse/parser.hexa:2191 pub fn parse(tokens, file) -> Module
use "compiler/lower/ast_to_hir"      // → compiler/lower/ast_to_hir.hexa:2222 pub fn lower(module, atlas) -> HModule
use "compiler/lower/hir_to_mir"      // → compiler/lower/hir_to_mir.hexa:2895 pub fn lower_hir(module) -> MModule
use "compiler/atlas/static_index"    // → compiler/atlas/static_index.hexa:88 pub fn static_atlas() -> AtlasIndex
use "compiler/ir/mir"                // (types only · no fn symbol consumed)
use "compiler/codegen/nvptx_target"  // → compiler/codegen/nvptx_target.hexa:2815 pub fn codegen_emit_ptx_for_sm(module, sm) -> string
```

Every undefined symbol maps 1:1 to a `pub fn` in the file pointed to by a `use` directive. Sources exist · paths resolve · names match. The breakage is purely link-time absence of function bodies.

## 4. Stage 0 transpiler audit — `hexa_cc.c` `use`-directive handling (root cause finding)

Three relevant functions in `self/native/hexa_cc.c`:

- `_resolve_use_path(name)` at line **15411** — resolves a `use "x/y"` literal to an on-disk `.hexa` file. Tries:
  - `<caller_dir>/x/y.hexa`
  - `$HEXALIB/x/y.hexa` (and `$HEXALIB/x/y.hexa` w/o slash variant)
  - `x/y.hexa` (cwd-relative)
  - `<self/>x/y.hexa`
- `_resolve_use_register_names(name)` at line **15660** — opens that .hexa, scans line-by-line for `pub fn`/`fn`/`struct`/`record` signatures, adds the bare names to `_known_fn_globals` + `_known_nonlocal_names` so the codegen's identifier-classification step doesn't flag them as unbound.
- `_resolve_use_emit(name)` at line **15704** — opens that .hexa, scans signatures, emits ONLY `extern HexaVal foo(HexaVal, HexaVal);` forward-declarations into the generated C. The string literal at line 11814 confirms the prefix is verbatim `"extern HexaVal "`.

The emit loop (lines 15730-15752) extracts the function name from each `fn` line via `_resolve_parse_fn_sig`, calls `_resolve_emit_extern_fn(rec)` to produce the `extern` prototype, and appends it to `out`. **It never reads or emits the function bodies.** It never recurses into the imported file's `use` chain at body-emit time (it only registers names from the *direct* import).

This is consistent with the comment header on every `/* use: … */` block emitted into the transpiled `build/stage1/main.c` (e.g. lines 4, 14, 90, 175, 222, 235, 236) — followed by extern decls only, never definitions.

**Conclusion**: the Stage 0 transpiler's `use` semantics are **header-only**. `use "x/y"` is treated as `#include <x/y.h>` (extern forward decls) — NOT as `#include "x/y.c"` (inline-body). The bodies are expected to be linked in by the caller.

## 5. Hypothesis — root cause classification

From the briefing's a/b/c/d menu:

- (a) Stage 0 doesn't expand `use` — **FALSE**. It does expand, but only to extern decls (verified by reading `_resolve_use_emit`).
- (b) Stage 0 expands `use` to a different target than Stage 1' expects — **TRUE-ish**. Stage 0 produces extern decls that need separate-TU bodies; the CI link step doesn't supply them.
- (c) `use` paths wrong — **FALSE**. All 6 paths resolve to existing `.hexa` files with `pub fn` defs at expected names.
- (d) Something else — partly. The deeper truth is that `_build_nvptx_emit_driver` was added (RFC 071 P3 Path B probe per the file comment at self/main.hexa:1834-1841) and committed without wiring the necessary compiler-module bodies into any link step. The transpiler's `use` model has been "header-only" all along; this is the first time `self/main.hexa` consumes symbols that don't live in the same TU.

**Root cause (most precise statement)**: hexa_cc.c emits extern declarations for `use`d functions but never their bodies. `bootstrap.yml` links only `build/stage1/main.c + self/runtime.c`. The 6 functions `lex/parse/lower/lower_hir/static_atlas/codegen_emit_ptx_for_sm` have neither a Stage 0–emitted body in main.c nor a separately-linked .o. Until either the transpiler is taught to inline bodies, or the CI link line gains the missing TUs, Stage 1' will stay red.

## 6. Proposed fix paths (ranked)

### Path A — gate `_build_nvptx_emit_driver` (lowest LOC · CI-fix-only)

**Scope**: 1 file (`self/main.hexa`) · ~5-10 LOC · 0 transpiler changes
**Mechanism**: wrap the body of `_build_nvptx_emit_driver` (self/main.hexa:1842-1868) in a feature-flag check (e.g. `env_get("HEXA_NVPTX_DRIVER") == "1"`) and have the non-flagged path `return 0` immediately. With no live references to `lex/parse/lower/lower_hir/static_atlas/codegen_emit_ptx_for_sm`, the link succeeds. The 6 extern decls remain in main.c (unused externs are not link errors).

Wait — extern decls themselves do **not** force linkage. The link error is because the function is *called* from the body of `_build_nvptx_emit_driver`. If we make the body a stub that never calls those symbols, the extern decls become dead code and the link succeeds.

Cleanest variant: replace the body with just `return 1` (always-fail "driver not built into this hexa-cc") plus a `println` explaining how to enable. The pre-PR-#288 codebase effectively had this posture (driver was never reached because Stage 1' wasn't built).

**Trade-off**: temporarily disables RFC 071 P3 Path B nvptx emit driver. Restoring it requires Path B or C below. Best for unblocking CI in 1 session.

**LOC estimate**: ~15-20 LOC (replace body + add gating comment + add restore-instructions).
**Risk**: very low — disables an unused-by-default CI codepath that nothing else depends on.

### Path B — link compiler/*.hexa transpiled .o files (medium LOC · CI-fix-only)

**Scope**: 1 file (`.github/workflows/bootstrap.yml`) · ~30-50 LOC · 0 transpiler changes
**Mechanism**: for each `use "compiler/foo/bar"`, add a Stage 1.5 step that runs `./self/native/hexa_v2 compiler/foo/bar.hexa build/stage1/foo_bar.c` for each of the 6+ files, then link all `.c` files at Stage 1' link. Must also do this transitively (e.g., `compiler/atlas/static_index.hexa` has its own `use` chain to parser/merger/overlay/prefix_index/hxc_loader — likely 15-25 transitive .c files total).

Per the briefing's iter-2 note ("Workaround #2 — Brittle and large surface; not recommended"), this is the path the original author already deemed brittle. Additional risk: duplicate symbol definitions if any compiler module's `use` chain re-imports something already in main.c (e.g., `compiler/atlas/parser` shares a `parser` namespace with `compiler/parse/parser` — earlier comment at self/main.hexa:5-9 explicitly warned about this exact collision class).

**LOC estimate**: ~40-80 LOC in bootstrap.yml + ~1-2 transpile fixes for duplicate-symbol collisions.
**Risk**: medium — high collision potential per existing duplicate-typedef warning in self/main.hexa comment block.

### Path C — teach Stage 0 transpiler to inline `use`d bodies (highest LOC · transpiler internals)

**Scope**: `self/native/hexa_cc.c` (~23k LOC C) + `self/codegen_c2.hexa` source · 100+ LOC · regen of hexa_cc.c
**Mechanism**: change `_resolve_use_emit` from emit-extern-decls to emit-full-body. Requires: textual splice of imported .hexa file (with own use-chain expansion), dedup against already-emitted modules (`_resolved_modules` is already tracked at line 15715), recursive resolve of nested `use`s, AST-level merge to avoid duplicate typedefs. Effectively turning `use` from `#include "x.h"` semantics into `#include "x.c"` semantics with proper guards.

This is the architecturally-right fix but conflicts with the existing codebase intent: the duplicate-typedef warning at self/main.hexa:5-9 (and the resulting "import to project-root rather than absolute" convention) implies the team has *intentionally* kept `use` as header-only to keep one-TU compilation tractable.

**LOC estimate**: 150-300 LOC of transpiler logic + regen ripple + likely multi-session debug.
**Risk**: high — touches the compiler/self-host cohort surface; not safe for 1-session land.

## 7. Recommendation

**Path A** (gate `_build_nvptx_emit_driver`). Best 1-session land. Restores the CI invariant from before PR #288 surfaced this (1/9 → 9/9 green once iter-2a #290 also lands). RFC 071 P3 Path B nvptx-emit-driver lives outside the bootstrap-CI invariant and can be exercised from a dedicated test workflow or a `compiler/cli/build_nvptx.hexa` standalone driver (which the comment at self/main.hexa:1849 already cross-references — `compiler/cli/build_nvptx.hexa::_build_nvptx_source_module`). If that standalone driver already has its own link wiring, the in-`main.hexa` copy is duplicate scope.

Path A is also reversible: once Path C lands (proper `use` semantics), the gating revert is a trivial git revert.

**Estimated LOC for fix (Path A)**: ~15-20 LOC in self/main.hexa, single file, single commit.

## 8. Honest gaps

- I did NOT verify whether `compiler/cli/build_nvptx.hexa` provides an equivalent driver and link path. If it does, Path A is even cleaner (the in-`main.hexa` driver is pure duplication of an external one). If it doesn't, Path A loses functionality until Path C lands. Either way, Path A unblocks CI — but the RFC 071 P3 functional question should be re-asked of the compiler/self-host cohort.
- I did NOT enumerate the transitive `use` graph beyond depth 1. Path B's true LOC could be 50 or 200 depending on the closure. A separate inventory pass would be needed before pursuing B.
- I did NOT investigate whether `_resolve_use_emit`'s extern-decl emission is currently emitting *correct* signatures (return type is always `HexaVal`, args are `HexaVal, …`) — if any compiler module returns or accepts a non-`HexaVal` type, that's a separate latent ABI bug. Probably fine in practice because hexa transpiles everything to `HexaVal`, but flagging as an audit-gap.

## 9. Anchors

- iter-1 PR (MERGED, Option A runtime link): https://github.com/dancinlab/hexa-lang/pull/288 · `e3938aec` · main merge `45ee2018`
- iter-2a PR (OPEN, `<stdarg.h>`): https://github.com/dancinlab/hexa-lang/pull/290 · `b78e1c71`
- CI run reproduced (macOS Stage 1' red): https://github.com/dancinlab/hexa-lang/actions/runs/26248049267 · job `77251462180`
- main HEAD at audit: `38b89c89`
- Parent audit notes:
  - `~/core/demiurge/inbox/notes/2026-05-22-pr276-bootstrap-ci-diagnostic.md`
  - `~/core/demiurge/inbox/notes/2026-05-22-bootstrap-option-a-fix-attempt.md`
  - `~/core/demiurge/inbox/notes/2026-05-22-bootstrap-fix-iteration-2.md`
- File anchors (hexa-lang `38b89c89`):
  - `self/main.hexa:10-16` — `use` directives
  - `self/main.hexa:1834-1868` — `_build_nvptx_emit_driver` (failure site)
  - `self/native/hexa_cc.c:15411-15455` — `_resolve_use_path`
  - `self/native/hexa_cc.c:15660-15701` — `_resolve_use_register_names`
  - `self/native/hexa_cc.c:15704-15755` — `_resolve_use_emit` (extern-decl emission)
  - `self/native/hexa_cc.c:11814` — `"extern HexaVal "` string literal (proof of extern-only emission)
  - `build/stage1/main.c:4-236` — `/* use: … */` blocks + extern decls in transpiled output
  - `build/stage1/main.c:4619-4645` — `_build_nvptx_emit_driver` body in transpiled output
  - `.github/workflows/bootstrap.yml@38b89c89` — Stage 0 + Stage 1' link command (links only `runtime.c`)
- Worktree cleanup: `git worktree remove ~/core/hexa-lang-iter2b-audit-v2 --force && git branch -D iter-2b-audit-v2` (executed at end of audit session).
