---
slug: hexa-runtime-writetext
mode: auto
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-05-30
repo: hexa-lang
risk: HIGH — toolchain runtime regen; MUST NOT clobber the working hexa.real
---

# hexa-runtime-writetext — plan

## task brief
The hexa cloud binary (and any multi-module build using the `write_text` runtime helper) fails to link:
`clang ... use of undeclared identifier 'write_text'` at the transpiled cgen. Root: `build/self/runtime.c`
(the built C runtime artifact) is STALE — it predates the `write_text` builtin that current stdlib uses.
This is the SAME wall the parallel-fill agent hit on ubu-1, and it blocks `hexa cloud adopt --project`
from going live → which blocks pod-attribution tagging. Fix the toolchain so cloud_cli links. Also fix
`tool/build_hexa_cloud.sh` which calls a non-existent `self/native/hexat` (use the working `build/hexa_v2`
transpiler instead — verified: transpile then succeeds, cgen 596KB; the `_shq_local` flatten collision is
already fixed by PR #2099).

## locked decisions (AUTO 1:1:1:1)
- Q1 scope: resolve the `write_text` link wall so cloud_cli (+ other multi-module builds) link cleanly; fix `tool/build_hexa_cloud.sh` (`self/native/hexat` → `build/hexa_v2`, and the runtime.c path → `build/self/runtime.c` with `-I build/self`).
- Q2 root (DISCOVERY-FIRST): determine whether `write_text` exists in the `self/` runtime SOURCE (e.g. self/runtime.c.in / self/native/*.c / the codegen that emits runtime.c). If the SOURCE defines write_text and only the BUILT `build/self/runtime.c` artifact is stale → regenerate the artifact (SAFE-ish: re-run the runtime/codegen build). If write_text is NOT in any source → it is a genuinely missing builtin (DEEPER): report honestly + escalate (do NOT hand-hack a builtin into a generated file).
- Q3 safety (HARD): NEVER clobber the working installed `~/.hx/bin/hexa.real` (the live local hexa everything depends on). Build the regenerated runtime + cloud binary to a TEST path first. Verify BEFORE replacing anything: (a) cloud_cli links with no write_text error, (b) an existing hexa selftest still passes with the rebuilt runtime. Only after both pass may the new artifact replace the installed one — and keep a backup of the prior binary first. On ANY doubt, stop + report (do not gamble the toolchain).
- Q4 verify: cloud_cli links (no `write_text` undeclared) → the rebuilt `hexa-cloud adopt` usage shows `--project` → `adopt <id> --project anima --purpose X` persists project/purpose to a TEST registry copy (not the live ~/.hx/cloud/active-pods.json). Regression: an existing hexa selftest (e.g. a qforge or cloud selftest) still PASSES with the rebuilt runtime. Paste verdicts VERBATIM.
- Q5 execution: canonical root `~/core/hexa-lang` on the **Mac** (the working hexa.real lives here; ubu's build/ is equally stale). REQUIRES the local sign window (`! sidecar sign local`) active for Mac heavy builds — if the sign has expired, the Mac build is gated → report that wall (ask the user to re-sign) rather than routing to the equally-stale ubu. If write_text is source-missing → honest escalate, ship only the build_hexa_cloud.sh hexat→hexa_v2 fix (a real, safe improvement) as a PR. Separate PRs.

## next-action checklist
- [ ] DISCOVERY: grep self/ (runtime.c, runtime.c.in, native/*.c, codegen_*.hexa) for `write_text` — is it defined in SOURCE? Determine artifact-stale vs builtin-missing.
- [ ] confirm local sign active (Mac heavy build needs it); if expired → STOP + report (re-sign needed), don't fall back to stale ubu.
- [ ] if artifact-stale: regenerate `build/self/runtime.c` from source via the canonical runtime/codegen build; build cloud_cli (module_loader → build/hexa_v2 → clang with build/self/runtime.c) to a TEST binary.
- [ ] VERIFY (test binary, no clobber): cloud_cli links clean · `hexa-cloud adopt` shows --project · adopt persists to a TEST registry copy · existing hexa selftest still passes.
- [ ] fix tool/build_hexa_cloud.sh (hexat→hexa_v2, runtime path) — ship as PR regardless (safe improvement).
- [ ] only if ALL verify passes: install the rebuilt artifact (backup prior first). Else report + leave working hexa.real untouched.
- [ ] if builtin-missing (source has no write_text): honest escalate + ship only the build script fix.
- [ ] ship PR(s); Korean commit; sidecar sync; update handoff 2cf7a421 / f8f3d35b.

## completion criteria
- cloud_cli links with no `write_text` error AND `hexa cloud adopt --project` persists project/purpose
  (verified on a TEST registry) AND an existing hexa selftest still passes — THEN the working binary may
  be updated (with backup). The build_hexa_cloud.sh hexat→hexa_v2 fix ships as a PR either way.
- HARD: the live ~/.hx/bin/hexa.real is NEVER left broken. If the fix can't be verified safe, report the
  honest wall + breakthrough paths and leave the toolchain exactly as found (working).
- If write_text is a genuinely missing builtin (not just a stale artifact), that is reported + escalated,
  NOT hand-hacked.

## qa-results
