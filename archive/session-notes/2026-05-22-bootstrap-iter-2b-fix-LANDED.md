# 2026-05-22 — hexa-lang bootstrap iter-2b — Path A gate LANDED (macOS Stage 1 link GREEN)

**Parent audit**: `2026-05-22-bootstrap-iter-2b-audit.md` (root cause + Path A spec)
**Parent iteration map**: `2026-05-22-bootstrap-fix-iteration-2.md` (9-gate matrix)
**Predecessor (iter-2a, MERGED)**: dancinlab/hexa-lang#290 `5ce47830`
**This PR (iter-2b)**: dancinlab/hexa-lang#295 — **MERGED** · merge commit `316faf29`
**hexa-lang main HEAD at fix**: `e7e4a460` (audit base was `38b89c89`; function still at L1842)
**Status**: LANDED · 1 hexa-lang commit (`67347549`) · 1 demiurge note commit

---

## 1. What landed

Path A gate of `self/main.hexa::_build_nvptx_emit_driver` (single file, +51/-20).
The live RFC 071 P3 Path B MIR pipeline (lex → parse → static_atlas → lower →
lower_hir → codegen_emit_ptx_for_sm) was replaced with a **reversible stub**:
early `return 1` + a `[nvptx]` gate message pointing callers at the standalone
`compiler/cli/build_nvptx.hexa::build_nvptx_emit_driver`. The 6 `use`d-symbol
call sites are removed; the live pipeline is preserved verbatim in a commented
block with restore instructions in the function header.

Net effect: the 6 `extern HexaVal …(…)` forward-decls remain in
`build/stage1/main.c` (lines 13/88/174/221/223/295) as harmless dead code
(unused externs are not link errors), and there are **zero call sites** to
`lex/parse/lower/lower_hir/static_atlas/codegen_emit_ptx_for_sm` in the
generated C — so the macOS Stage 1' link succeeds.

## 2. Root cause (confirmed, per audit §4)

Stage 0 transpiler (`hexa_cc.c::_resolve_use_emit`) emits **extern forward-decls
only** for `use "compiler/…"` symbols (header-only `use` semantics). `bootstrap.yml`
links only `build/stage1/main.c + self/runtime.c` — never the `compiler/*.hexa`
module bodies. The recently-added P3 Path B driver was the first `self/main.hexa`
consumer of cross-TU symbols → 6 undefined symbols at macOS Stage 1' link.

## 3. Local verification (macOS arm64 · 1:1 with CI)

```
Stage 0   clang … hexa_cc.c runtime.c -o hexa_v2          PASS
Stage 1   ./hexa_v2 self/main.hexa build/stage1/main.c    PASS (7446 lines)
   grep   6 symbols at call sites in main.c                0 (extern decls only;
                                                            sole match = heredoc literal)
Stage 1'  clang … build/stage1/main.c runtime.c -o hexa   GREEN (was RED)
   smoke  ./hexa runs; --target=nvptx64-… prints gate msg  OK
```

## 4. CI before / after — macOS Stage 1 link

| metric | before (run 26248049267 / 26244746182) | after (run 26265434340) |
|--------|------------------------------------------|--------------------------|
| macOS Stage 0 (compile hexa_v2)          | GREEN | GREEN |
| macOS Stage 1 transpile                  | GREEN | GREEN |
| **macOS Stage 1' link (CLI driver)**     | **RED** (6 undefined symbols) | **GREEN** |
| macOS Smoke (transpile/compile/run)      | unreached | GREEN |
| Linux x64 / arm64 Stage 0                | RED   | RED (different cause — see §6) |

macOS job (after): https://github.com/dancinlab/hexa-lang/actions/runs/26265434340/job/77307572209 — all steps `success`.

## 5. Score uplift — 9-gate matrix (3 stages × 3 platforms)

| Stage     | macOS | Linux x64 | Linux arm64 |
|-----------|-------|-----------|-------------|
| Stage 0   | GREEN | RED       | RED         |
| Stage 1'  | **GREEN (was RED)** | unreached | unreached |
| Smoke     | **GREEN (was unreached)** | unreached | unreached |

**2/9 → 3/9 GREEN.** The macOS column went from 1/3 (Stage 0 only) to **3/3 full
green** — net +2 cells (macOS Stage 1' + macOS Smoke), the entire iter-2b
deliverable. The remaining 6/9 (both Linux platforms × 3 stages) are blocked at
Stage 0 by a single Linux-only cause on the separate iter-2c/2d track (§6).

(Note: the iter-2 parent note's projection of "3/9 after iter-2a, all 3 Stage 0"
assumed iter-2a fixed Linux Stage 0; CI shows Linux Stage 0 is still RED on the
flock-macro cause, which is iter-2c, not iter-2a. So the realized count is the
macOS column 3/3 + Linux Stage 0 still 0/2.)

## 6. Out-of-scope confirmation — Linux failure is iter-2c, not this change

Linux x86_64 Stage 0 fails at **"Stage 0 — compile self-hosted transpiler
(hexa_v2)"** (Stage 1 steps skipped), with:

```
self/runtime.c:1187:40: error: expected declaration specifiers or '...' before '(' token
 1187 | #define flock(fd,op)       hxlcl_flock((int)(fd), (int)(op))
```

This is the **iter-2c flock-macro** collision with the Linux system `flock()`
declaration — exactly the separate Linux track named in the briefing (iter-2c
flock + iter-2d x86_64 syscall). It is NOT introduced by the iter-2b gate: macOS
(same `self/main.hexa`) is fully green, proving the gate is correct; the Linux
break is a pre-`self/main.hexa` Stage-0 C-compile failure on a Linux-only macro.

## 7. Exit-criteria assessment

**(α) achieved** — gate landed (`67347549`) + PR #295 merged (`316faf29`) +
macOS Stage 1 link CI verified RED→GREEN (macOS column 3/3) + this note with
score uplift. The only residual is the Linux iter-2c/2d track, which was always
a separate sub-track per the briefing and is unaffected by this fix.

## 8. Honest notes

- **Duplication confirmed (audit §8)**: `compiler/cli/build_nvptx.hexa` already
  provides `build_nvptx_source_module` + `build_nvptx_emit_driver` — the in-`main`
  copy is a near-duplicate. Per honest invariant, I gated (did NOT refactor) and
  the gate message now cross-references the standalone driver. The RFC 071 P3
  functional question (which driver should be canonical) is deferred to the
  compiler/self-host cohort.
- **Reversibility**: the live pipeline is preserved verbatim (commented) with a
  restore recipe in the function header. Re-enabling requires Path B (link
  `compiler/*.hexa` .o) or Path C (transpiler `use`-body inline) so the 6 bodies
  are present at link time. Trivial git-revert once either lands.
- The `@grace consent trailers` PR check fails on this branch — but it fails on
  EVERY PR branch (verified across iter-2a #290, multiple unrelated PRs); it
  errors at "Locate hexa interpreter" (no `build/hexa_interp.linux` / PATH:hexa
  in that workflow env). Pre-existing infra failure, not a merge blocker, not
  caused by this change.

## 9. Anchors

- PR (iter-2b, MERGED): https://github.com/dancinlab/hexa-lang/pull/295 · commit `67347549` · merge `316faf29`
- CI run (after fix): https://github.com/dancinlab/hexa-lang/actions/runs/26265434340
  - macOS-arm64 (GREEN, all stages): job 77307572209
  - linux-x86_64 (RED, iter-2c flock): job 77307572192
  - linux-arm64 (RED, iter-2c flock): job 77307572190
- CI run (before, macOS Stage 1' RED): https://github.com/dancinlab/hexa-lang/actions/runs/26248049267 · job 77251462180
- File anchor: `self/main.hexa:1842-1900` — gated `_build_nvptx_emit_driver` (post-fix)
- Worktree: `~/core/hexa-lang-iter2b-fix` (branch `bootstrap-iter-2b-nvptx-gate-2026-05-22`)
