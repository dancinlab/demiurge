# 2026-05-22 — hexa-lang PR #276 bootstrap CI red — root cause diagnostic

**Scope**: AUDIT-ONLY (no fixes). Single-session diagnostic for
`hexa-lang` PR #276 (`regex-runtime-backend` · head `f90ba2f5`) — all
3 bootstrap jobs + grace-consent check FAIL.

**Verdict**: Hypothesis CONFIRMED. PR #276's 22-LOC `runtime.h` header
addition is **NOT** the cause. Bootstrap workflow has been red on
`main` and across all branches for **≥500 consecutive runs** (full
visible CI history; earliest `gh run list` window 2026-05-19, latest
2026-05-21). Stage 0 reliably fails locally on `main` with the same
linker-error family. This is **pre-existing infrastructure debt**.

PR #276 itself can be merged on the strength of its local 24/24 test
PASS once the bootstrap chain is independently unblocked — the bootstrap
failure mode is orthogonal to the regex backend work.

---

## 1. Hypothesis verification

### Local repro on `main` (worktree at `/Users/ghost/core/hexa-lang-pr276-diag`, HEAD `8ca06d5c`)

```
clang -O2 -std=gnu11 -D_GNU_SOURCE -Wno-trigraphs \
    -I self self/native/hexa_cc.c -o self/native/hexa_v2_local
```

Result: **66 undefined symbols** on arm64 macOS (identical family to CI
linker errors; CI log truncated to 18 unique). No PR #276 patch applied.
Conclusion: `main` reproduces. Bootstrap red is independent of PR #276.

### CI history evidence

```
gh run list --workflow=bootstrap --limit 500
  → total runs: 500   green count: 0   failure count: 500
  → earliest visible: 2026-05-19 21:49Z (SHA 041d659a)
  → latest:           2026-05-21 18:01Z
```

Branch-agnostic. Includes runs on `main`, on feature branches, on
re-runs after restore commits. Last known green bootstrap is outside
the 500-run window.

---

## 2. Failure family — full undefined-symbol set

Local link error from `clang ... hexa_cc.c -o hexa_v2_local`
(arm64 macOS · names without underscore prefix):

| Symbol                          | Expected origin                                        |
|---------------------------------|--------------------------------------------------------|
| `hexa_int`                      | `self/runtime_core.c:1236`                             |
| `hexa_bool`                     | `self/runtime_core.c:1238`                             |
| `hexa_void`                     | `self/runtime_core.c:1239`                             |
| `hexa_float`                    | `self/runtime_core.c:1237`                             |
| `hexa_str`                      | `self/runtime_core.c:1354`                             |
| `hexa_eq`                       | `self/runtime_core.c` (declared `runtime_core.c:770`)  |
| `hexa_truthy`                   | `self/runtime_core.c` (declared `runtime_core.c:764`)  |
| `hexa_array_new`                | `self/runtime_core.c:825` (declared) + body in `.c`    |
| `hexa_array_push` / `_free`     | `self/runtime_core.c`                                  |
| `hexa_len`                      | `self/runtime_core.c:2052+` (polymorphic)              |
| `hexa_cmp_lt/le/gt/ge`          | `self/runtime_core.c`                                  |
| `hexa_index_get/_set`           | `self/runtime_core.c`                                  |
| `hexa_to_string`                | `self/runtime_core.c`                                  |
| `hexa_str_chars/_join/_split/_substring/_replace/_contains/_index_of/_parse_int/_char_at` | `self/runtime.c` (5300-6700 region) |
| `hexa_struct_pack_map`          | `self/runtime.c:2155` (per runtime.h:97-99)            |
| `hexa_add_slow` / `_sub` / `_mul` / `_div` / `_mod` | `self/runtime.c:4731+` (was `static`, header note warns extern decl is wrong) |
| `__hexa_fn_arena_enter` / `_return` | `self/runtime.c` (per runtime.h:690)              |
| `__hexa_last_error`, `__hexa_try_cleanup/_push/_top` | `self/runtime.c` (try/catch lowering) |
| `__hx_to_double`                | `self/runtime.c` (per runtime.h:145, "was `static inline`") |
| `g_hexa_ic_hits`, `g_hexa_ic_stats_enabled` | `self/runtime_core.c` global vars        |
| `hexa_args`, `hexa_set_args`, `hexa_exit`, `hexa_throw`, `hexa_println`, `hexa_eprint_val`, `hexa_format_n`, `hexa_concat_many`, `hexa_contains_poly`, `hexa_iter_get`, `hexa_type_of`, `hexa_char_code`, `hexa_arena_reset`, `hexa_env_var`, `hexa_exec`, `hexa_map_new`, `hexa_map_set`, `hexa_map_get_ic_slow` | `self/runtime.c` (~12,514 LOC) + `self/runtime_core.c` (~6,741 LOC) |
| `rt_str_to_upper`, `rt_str_trim`, `rt_str_starts_with`, `rt_file_exists`, `rt_read_file`, `rt_write_file` | `stdlib/runtime/*.hexa` (transpiled → `ap_post.c` historically) |

### Root mechanism

`hexa_cc.c` is the transpiler-output (~23,128 LOC) for the
self-hosted compiler driver. Its top-of-file is literally just:

```c
// HEXA self-hosted compiler — regenerated via `hexa cc --regen`
#include "runtime.h"
```

`self/runtime.h` is a **declarations-only** header (374 `HexaVal …(…);`
prototypes + 14 `static inline` wrappers — first introduced as the
"replace `#include "runtime.c"` smoke speedup" in commit `5780ef97`).
The header itself acknowledges the problem (lines 16-18):

```
This header currently DECLARES `hexa_add_slow` as extern; running it
against an unpatched runtime.c yields a link error for `_hexa_add_slow`.
Apply the de-static patch (drop `static` on runtime.c:4731) before use.
```

The bootstrap workflow at `.github/workflows/bootstrap.yml:66-68`
compiles **only** `self/native/hexa_cc.c` — it never links
`self/runtime.c` or `self/runtime_core.c`. Hence the linker error.

For this to ever have been green, **either**:

(a) An older `hexa_cc.c` was self-contained (inlined runtime bodies), and
    later regenerations stopped emitting them. Inspection of latest
    `hexa_cc.c` shows no inlined `hexa_int` / `hexa_str` / etc.
    definitions (only call sites). PRIOR regenerations at commits
    `81efab36`, `f1a05742`, `ead5f862` all REPRODUCE the same Stage 0
    link error locally. So the break extends to at least cycle 66
    (`ead5f862`, "deploy: runtime cycle 66 exec fix").

(b) The bootstrap.yml step is missing `self/runtime.c self/runtime_core.c`
    in the compile-input list. The committed `self/native/hexa_v2`
    binary (committed at `dea25048`, 782 KB → currently 1.59 MB) **does**
    contain `T _hexa_int` and `T _hexa_array_new` (i.e., it was built
    against runtime.c bodies at some prior time, possibly by a
    bootstrapping path that no longer exists in `.github/workflows/`).

(b) is the more likely explanation: the CI was written presuming
self-contained `hexa_cc.c`, then regenerations broke that
self-containment, and **no CI run has been green since at least
2026-05-19** because no one re-greens the gate.

---

## 3. Codegen call sites

`self/codegen_c2.hexa` (transpiler codegen, the SSOT):

| Symbol                          | Emit site                                              |
|---------------------------------|--------------------------------------------------------|
| `hexa_int(...)`                 | `self/codegen_c2.hexa:2059`, `:2858`, `:1535`, `:1978` |
| `__hexa_fn_arena_enter()`       | `self/codegen_c2.hexa:1763` (fn-prologue)              |
| `__hexa_fn_arena_return(...)`   | `self/codegen_c2.hexa:1518`, `:1875`, `:1923`, `:1928`, `:2735`, `:2740` (every return statement) |
| `hexa_void()`                   | `self/codegen_c2.hexa:1928`, `:2740`                   |
| `hexa_array_new()` / `_push()`  | `compiler/codegen/arm64_darwin.hexa:1417,1423` ; `compiler/codegen/x86_64_linux.hexa:711-724` ; `compiler/codegen/thumbv7em_eabihf.hexa:238-243` |
| `#include "runtime.h"\n\n`      | `self/codegen_c2.hexa` (slot 1743 — emitted as the prelude of every transpiler-output C file) |

Every transpiled C file thus depends on `runtime.h` declaring symbols
whose **bodies** live in `runtime.c` / `runtime_core.c` — neither of
which is linked by the bootstrap workflow.

---

## 4. Bootstrap chain location — Stage 0 break

bootstrap.yml chain per runner:

1. **Stage 0** — `$CC self/native/hexa_cc.c -I self -o self/native/hexa_v2`
   — ← **FAILS HERE** on all 3 runners
2. Stage 1 — `./hexa_v2 self/main.hexa build/stage1/main.c`
3. Stage 1' — `$CC -I self build/stage1/main.c -o hexa`
4. Smoke — tiny .hexa → transpile → compile → run

CI job step output confirms only step #4 ("Stage 0 — compile
self-hosted transpiler (hexa_v2)") fails — Stages 1, 1', and Smoke
never execute.

---

## 5. Recent commits — suspect list

Wipe/restore pattern dominates. Per the existing in-tree audit
`inbox/notes/2026-05-22-wipe-governance-proposal.md` (hexa-lang),
**10 silent codegen/runtime wipes since 2026-05-01**. Top suspects
(by relevance to Stage 0 link gap):

| SHA        | Subject                                                                                        | Wipe-pattern |
|------------|------------------------------------------------------------------------------------------------|--------------|
| `724c38b3` | feat(gpu/RFC067): N127 warp specialization … (touched `hexa_cc.c` 5412 lines + 41 in `runtime.c`) | YES — wiped Step 5 #2/#4 builtins |
| `c4c721bc` | docs(perf scoreboard): N141 v3 APPENDIX … 54 deletions in guarded paths                          | YES — 2nd-wipe of just-restored builtins |
| `c39afbbe` | feat: project.tape SSOT + Spec Kit removal + AGENTS.tape → archive (274 dels)                    | YES — wiped runtime cycles 93-96 |
| `0d59c419` | feat(gpu/RFC067): N104 cuBLAS SASS-diff (241 dels)                                               | YES (per audit) |
| `e9c89904` | feat(gpu/RFC067): N88 K-unroll 2x REGRESSION (328 dels)                                          | YES (per audit) |
| `9367334e` | feat(gpu/RFC067): N76-retry ldmatrix HGEMM (521 dels)                                            | YES (per audit) |
| `61c7eb8d` | restore(compiler+SSOT): re-land Step 5 #2 + #4 after 724c38b3 wipe                                | restore #1   |
| `2b024282` | restore(compiler+SSOT): 3rd re-land Step 5 #2+#4 after c4c721bc wipe                              | restore #3   |
| `3a4282ec` | restore(stdlib/runtime): re-land cycles 93-96 wiped by c39afbbe deploy-regen                      | restore      |
| `034ec625` | restore(stdlib/sscb): structure.py — undo inadvertent deletion by 3a4282ec runtime restore       | restore-of-restore |
| `f1a05742` | feat(self/native): RUNTIME.md step 3 cycle 76 ACTIVATED — `hexa_cc.c` patched + `hexa_v2` rebuilt | candidate regen-without-runtime-link |
| `81efab36` | feat(compiler/codegen+runtime): true-logic `rt_len` via codegen-inline raw-length builtins        | wrote new builtins (`__str_raw_len` etc) that later wipes dropped |
| `a39988c9` | feat(compiler/codegen): RUNTIME.md Step 5 #4 SSOT — `__fd_write_bytes` codegen builtin            | wrote builtin that later got wiped |

**Mechanism (per existing wipe-governance audit):** stale-worktree-replace
in 8-session shared trees. Single-parent non-merge commits silently
drop new files/lines added since the stale worktree was checked out.
Identical pattern to demiurge's own
`feedback_worktree_merge_silent_filedrop` memory.

The current Stage 0 break is NOT one symbol wiped — it is the
cumulative outcome of regenerating `hexa_cc.c` against an evolving
runtime API where `runtime.h` declarations expanded faster than the
bootstrap workflow's link inputs.

---

## 6. Proposed patch direction — minimal fix recommendation

**NOT applied this session. DEFERRED to follow-on.**

Two viable directions (pick one in fix session):

### Option A — patch the workflow (smallest delta · est 3 LOC)

Edit `.github/workflows/bootstrap.yml` three Stage 0 invocations
to include `self/runtime.c self/runtime_core.c` as link inputs:

```diff
- clang ... -I self self/native/hexa_cc.c -o self/native/hexa_v2
+ clang ... -I self self/native/hexa_cc.c self/runtime.c -o self/native/hexa_v2
```

(`runtime.c` already `#include`s `runtime_core.c` at line 1211 —
single additional C input suffices.)

Caveat: Stage 1' (`gcc … build/stage1/main.c -o hexa`) likely has
the same issue and also needs `runtime.c` appended.

Risk: `runtime.c` itself may fail to compile cleanly under `-Wno-trigraphs
-std=gnu11 -D_GNU_SOURCE` if it contains warnings-as-errors candidates.
Need to test compile alone first.

### Option B — make `runtime.h` self-contained for bootstrap (est ~30-50 LOC)

Move the 5-10 hot constructors (`hexa_int`, `hexa_bool`, `hexa_void`,
`hexa_float`, `hexa_str`, `hexa_array_new`, `hexa_truthy`, `hexa_eq`,
`__hexa_fn_arena_enter`, `__hexa_fn_arena_return`) into `runtime.h`
as `static inline` definitions. This restores the original 7.75×
smoke-speedup model. But still leaves ~40 other extern symbols
unlinked — so Option B alone is insufficient unless paired with A
or a deeper "bootstrap-mini-runtime.h" approach.

### Recommended

**Option A.** Append `self/runtime.c` to both Stage 0 and Stage 1'
clang/gcc commands across all 3 bootstrap jobs. ~6 line workflow
edit. No source-code drift, no governance-flagged file touched.
Verify with a single push + CI re-run.

If Option A surfaces secondary breakage (e.g., `runtime.c` itself
won't compile under the bootstrap flags), fall back to Option C:
**rebuild and commit a fresh `self/native/hexa_v2` binary** the way
the original `dea25048` commit did, and treat the CI as a binary-
artifact gate rather than a true rebuild.

---

## 7. Anchors

- **PR**: https://github.com/dancinlab/hexa-lang/pull/276
- **Head SHA**: `f90ba2f503c6abec1f65ae20919badd4d8a45e17`
- **Branch**: `regex-runtime-backend`
- **Failed runs** (all 4): https://github.com/dancinlab/hexa-lang/actions/runs/26237360745
- **In-tree wipe audit**: `~/core/hexa-lang/inbox/notes/2026-05-22-wipe-governance-proposal.md`
- **RUNTIME roadmap**: `~/core/hexa-lang/RUNTIME.md` (4-step plan ↓ ~700-1300 cycles ↓ currently 7%)
- **Bootstrap workflow**: `~/core/hexa-lang/.github/workflows/bootstrap.yml`
- **Original runtime.h commit** (declarations-only intent): `5780ef97 feat(runtime.h): PHASE 1.2 first cut`
- **Original bootstrap.yml commit**: `8f18a3b6 feat(ci): 3-platform bootstrap matrix (M5 last-mile)` (2026-04-24)
- **Original committed hexa_v2 binary**: `dea25048 feat(self): P5 셀프컴파일`
- **Diagnostic worktree** (deleted at end of session): `/Users/ghost/core/hexa-lang-pr276-diag` @ `main` (HEAD `8ca06d5c`)
- **Demiurge audit commit**: see git log for `audit(hexa-lang): PR #276 bootstrap CI red`

---

## 8. Honest scope

**This audit DOES NOT fix the issue.**

- No commits to `hexa-lang` repo (`pr276-bootstrap-diagnostic-audit`
  worktree branch was created, read-only inspected, and deleted).
- No edits to `bootstrap.yml`, `runtime.h`, `runtime.c`, `hexa_cc.c`.
- No `hexa_v2` binary rebuild attempted.

Fix is **DEFERRED to a follow-on session**. Recommended pickup:

1. Apply Option A patch to `bootstrap.yml` on a fresh branch.
2. Push and verify CI green.
3. If green: rebase PR #276 onto the fixed main, expect CI green.
4. If Option A surfaces secondary errors: pivot to Option C
   (binary refresh) and document why.

**No RTSC κ D-block reservation needed** — this is hexa-lang
infrastructure debt, not RTSC track. The wipe-governance proposal
(in-tree at `2026-05-22-wipe-governance-proposal.md`) is the
sibling-repo governance lever; it stays in hexa-lang's ownership.

PR #276's own 22-LOC `runtime.h` header addition remains a valid
contribution — the bootstrap red is not the regex backend's debt
to discharge.
