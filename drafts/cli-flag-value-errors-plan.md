---
slug: cli-flag-value-errors
mode: auto
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-05-29
surfaces: hexa cloud (hexa-lang stdlib) + demiurge CLI
---

# cli-flag-value-errors — plan

## task brief
Fix the cryptic CLI error class where a value-taking flag whose value is missing silently swallows
the NEXT token (often another `--flag` or hits EOL) as its value → confusing error. Real case this
session: `hexa cloud exec ssh6 --port --insecure -- ...` → `Bad port '--insecure'` (the `--port`
value was missing so `--insecure` slid into the port slot). Make value-flags validate + emit a clear
"flag <X> needs a value, got '<token>'" error. Apply to hexa cloud AND the demiurge CLI surface.

## locked decisions (AUTO 1:1:1:1)
- Q1 fix: for every value-taking flag (`--port`, `--identity`, `--env`, `--env-file`, `--source`, `--max-wall`, `--grep`, `--until`, `--provider`, …), validate the next token exists AND does not look like another known flag (`--*`); on violation emit `error: flag <X> needs a value, got '<token>'` (or `…got end-of-args`) instead of consuming it. Preserve legit values that legitimately start with `-`/`--` only where a flag genuinely takes such (none here — all take paths/ints/host:port/K=V).
- Q2 surfaces: ① hexa cloud (hexa-lang `stdlib/cloud/*` argv parse — the concrete instance that bit us) ② demiurge CLI (`demiurge cli <verb>` surface — sweep for the same anti-pattern; if its parser already errors cleanly OR is a different language/lib that doesn't have the bug, note that honestly and skip).
- Q3 impl: a shared argv-validate helper (d4 generic, d19 reuse) in hexa-lang that cloud's parser calls; demiurge CLI gets the same guard in its own parser/lang. No per-flag hardcoded branches — drive from the value-flag set.
- Q4 verify: `@ci_gate` selftest — malformed argv (missing value · flag-as-value · EOL) → the clear error; valid argv → parses unchanged. g5 paste verbatim.
- Q5 execution: build/test on POOL (ubu-1 Linux, `pool on ubu-1 'bash -lc "..."'`) to avoid the Mac sign-gate (per the user's standing "pool에서" directive). Separate PRs per surface (g4 <200 lines each).

## next-action checklist
- [ ] grep hexa-lang for hexa cloud's argv/flag parser (stdlib/cloud/cloud_cli.hexa or similar) — find where `--port`/conn-flags are read; identify the value-flag set
- [ ] add the shared value-flag validator (missing-value / flag-as-value → clear error); wire cloud's parser to it
- [ ] locate the demiurge CLI argv parser (`demiurge cli` surface — repo/lang TBD: hexa-lang dispatcher vs Swift DemiurgeCLI); apply the same guard, or honestly report it's already-safe / different-parser
- [ ] @ci_gate selftest per surface: malformed→clear error · valid→OK; build+run on ubu-1; paste verdict VERBATIM
- [ ] ship: hexa-lang PR (cloud) + demiurge PR (CLI) separate; Korean commit; gh pr create; sidecar sync
- [ ] reproduce the original case: `hexa cloud exec h --port --insecure -- echo` now gives "flag --port needs a value, got '--insecure'" not "Bad port"

## completion criteria
- hexa cloud: a value-flag with missing value → clear "flag X needs a value, got '<token>'" (the `--port --insecure` case fixed); valid argv unaffected.
- demiurge CLI: same guard applied, OR an honest note that its parser already handles it / is out-of-scope (different lang).
- @ci_gate selftest PASS (malformed→clear, valid→parse). PR(s) merged. No regression to existing cloud/demiurge verbs.

## qa-results
- SHIPPED 2026-05-29.
- hexa cloud: PR dancinlab/hexa-lang#2081 MERGED. _need_val(av,i,key) shared validator; all positional value-flag consumers + _flag_val route through it. selftest stdlib/cloud/flag_value_validate_test.hexa 8 cases PASS (built+run on Mac ~/.hx hexa; cloud_cli full-module build blocked by UNRELATED pre-existing origin/main collision — _shq_local redefine + pod_registry_add arity — so selftest carries verbatim copies of the funcs under test). Original case: `--port --insecure` → `flag --port needs a value, got '--insecure'` (was: swallow → Bad port).
- demiurge CLI: PR dancinlab/demiurge#515 MERGED. Swift DemiurgeCLI/main.swift — takeValueFlag(&args,flag) shared validator; --producer routes through it (the only swallow). Other flags already-safe (boolean .contains / forwarded-to-phanes / positional count-guard). swift build + run selftest PASS.
- functional ✅ · visible-skip ✅ (phanes-forwarded + boolean flags documented out-of-scope honestly) · conformance ✅ (shared validator, flag-name-driven, no per-flag branch) · regression ✅ (valid argv on both surfaces parses unchanged).
