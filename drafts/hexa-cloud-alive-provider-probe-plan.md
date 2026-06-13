---
slug: hexa-cloud-alive-provider-probe
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated
domain: QFORGE-FEATURE adjacent (cloud substrate) — the unreachable-vs-dead disambiguator
---

## task brief
Add a `hexa cloud` verb that determines a pod's TRUE liveness via the PROVIDER API
(vast.ai + runpod), with NO SSH — solving the gap hit live this session: 3 gate
anchors went SSH-unreachable and we could not distinguish "vast transport outage
(pod alive)" from "pod reclaimed/dead". cloud-guard blocks the raw `vastai` CLI, so
this must live inside `hexa cloud`. CLI + API (exit-code + --json) both usable.

## locked decisions (@L)
- @L1 (scope): new verb `hexa cloud alive <id...>` (alias `probe`) — for each pod id,
  query the provider API (NOT ssh) and report real instance state. Reuse the SAME
  provider API client `hexa cloud rent`/`down` already use (d19/d3 — no new HTTP stack).
- @L2 (states): map provider response → {RUNNING, STOPPED, GONE, UNKNOWN, MISSING-CRED}.
  GONE = id not found in the provider's instance list (reclaimed/destroyed). STOPPED =
  exists but not running. UNKNOWN = API reachable-but-ambiguous. MISSING-CRED = no api key.
- @L3 (api surface): exit code for script/API consumers — 0=RUNNING · 3=STOPPED ·
  4=GONE · 255=API/cred failure. `--json` emits {id,provider,state,raw} per id. Human
  table without --json.
- @L4 (honesty d6): NEVER infer liveness from cached pods.json or from an SSH probe.
  If the api key is absent → MISSING-CRED + exit 255, do NOT guess RUNNING. If the API
  errors → UNKNOWN, do NOT default to GONE (a GONE ruling tears down real compute).
- @L5 (g5 std): selftest with mocked provider-list JSON fixtures (vast + runpod) →
  classify each state correctly incl. the not-in-list→GONE and empty-key→MISSING-CRED
  edge cases. Paste verdict VERBATIM. g4 <200 lines, 1 concern, stacked PR.
- @L6 (no-clobber): a branch `fix/cloud-poll-unreachable-vs-dead` already exists in
  ~/.hx/src with ~25 uncommitted files tackling THIS gap. INSPECT it FIRST (git log /
  diff on that branch). If it already implements an equivalent verb → finish/land it
  instead of a parallel one (g0 no-duplication). If stalled/divergent → build `alive`
  fresh on a worktree off origin/main and note the relationship. Do NOT clobber the
  25 dirty files / force-resync ~/.hx/src.

## guards
- d9 worktree isolation off origin/main HEAD; do NOT touch ~/.hx/src (dirty other-agent branch).
  Run with HEXA_STDLIB_ROOT pointing at the worktree.
- g8: this IS the canonical-cloud path (the verb lives in hexa cloud) — fine.
- No pod ops, no rent, no teardown — read-only provider query only.
- SHIP: self-merge PR(s). demiurge side: append a QFORGE-FEATURE.log.md / cloud note row
  (commit only, no push). Stage explicit paths (d9).

## final report
PR#(s), the verb name as shipped, g5 verdict VERBATIM, the relationship to
fix/cloud-poll-unreachable-vs-dead (landed-it / built-fresh), and a live demo line
(`hexa cloud alive 38704336` output) if a provider key is present — else honest
MISSING-CRED note.
