---
slug: hexa-cloud-fixes
mode: auto
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-05-29
repo: hexa-lang (stdlib/cloud)
---

# hexa-cloud-fixes — plan

## task brief
Fix the concrete `hexa cloud` bugs surfaced this session: (1) `cloud adopt --help` is misparsed — it
treats `--help` as a pod-id and "adopts" a pod literally named `--help` instead of printing usage;
(2) numeric pod-id → stale direct-IP resolution times out (a deep-read agent had to fall back to the
`sshN.vast.ai` proxy hostname — `cloud exec <numeric-id>` should resolve to the live proxy host, not a
stale `2.65.x` direct IP); (3) `cloud adopt --project/--purpose` did not persist attribution to the
registry this session (suspected stale compiled `hexa` binary — verify whether it's a code bug or purely
a rebuild issue, and fix the code part if any). Discovery-first; fix only the real code bugs.

## locked decisions (AUTO 1:1:1:1)
- Q1 fix: adopt help-guard (a leading `--help`/`-h` prints usage, never adopted as a pod-id) · numeric-id→proxy-host resolution in `cloud exec`/resolve (prefer the live proxy hostname over a stale direct IP) · adopt --project/--purpose persistence (confirm code writes the fields; if the source is correct and only the installed binary is stale, report rebuild-needed honestly, don't fake a code change).
- Q2 where: hexa-lang `stdlib/cloud/*`. DISCOVERY-FIRST — locate the adopt arg-parse, the id→host resolver, and the registry-write path.
- Q3 collision: `stdlib/cloud/cloud_cli.hexa` is being edited concurrently by the parallel-fill-enforce agent (aa928c92). AVOID concurrent edit (d9) — branch off FRESH origin/main AFTER that PR merges (git fetch first; if its files already on main, fine), or touch only cloud files it doesn't. Confirm your squash adds only your files.
- Q4 verify: `@ci_gate` selftest — `adopt --help` → usage text + exit 0, NO pod registered · a numeric-id resolves to the proxy host (mock/unit) not a stale IP · a malformed adopt (missing value) → clear error. Paste verdicts VERBATIM (g5).
- Q5 execution: build/test on POOL ubu-1 (repo-hexa_v2 + clang workaround if installed hexa_v2 segfaults). Separate PR(s), <200 lines each (g4). The known cloud_cli full-module build-break (handoff f8f3d35b: `_shq_local`/`pod_registry_add` collision) + the stale-binary rebuild issue are OUT OF SCOPE — report honestly, don't fix here.

## next-action checklist
- [ ] wait/branch so as not to collide with aa928c92 on cloud_cli.hexa (fetch origin; branch off fresh main)
- [ ] DISCOVERY: grep stdlib/cloud for adopt arg-parse, `--help` handling, numeric-id→host resolve, registry project/purpose write
- [ ] FIX adopt help-guard: leading `--help`/`-h` → usage, exit 0, no adopt
- [ ] FIX numeric-id resolution: resolve to live proxy host (sshN.vast.ai:port) not stale direct IP; cloud exec uses it
- [ ] CHECK adopt --project/--purpose write path; fix if code bug, else honest "needs rebuilt binary"
- [ ] @ci_gate selftest per fix; build+run on ubu-1; verdict verbatim
- [ ] ship: separate PR(s) hexa-lang, Korean commit, gh pr create, verify MERGED, sidecar sync
- [ ] regression: existing cloud verbs (list/exec/rent/down) unchanged

## completion criteria
- `cloud adopt --help` prints usage + exits 0 (no `--help` pod). numeric pod-id resolves to the live
  proxy host (no stale-IP timeout). adopt --project/--purpose persists (or honest rebuild-needed note).
  Selftests PASS verbatim. PR(s) merged. No regression. Out-of-scope items (build-break, stale binary)
  reported honestly, not faked.

## qa-results
