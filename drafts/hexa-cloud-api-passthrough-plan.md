---
slug: hexa-cloud-api-passthrough
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated
domain: cloud substrate — universal provider CLI+API passthrough through the guarded path
---

## task brief
cloud-guard (commons g8) blocks the raw `vastai` CLI, forcing everything through
`hexa cloud`. But `hexa cloud` only exposes a fixed verb set (rent/down/list/alive/…),
so any provider operation NOT yet wrapped is unreachable — this session twice hit that
(no `alive` in the installed binary; needed `reconcile` as a fallback). Add a UNIVERSAL
passthrough so `hexa cloud` FULLY substitutes for the provider CLI + REST API: no raw
vastai, no per-op new verb ever needed again.

## locked decisions (@L)
- @L1 (core primitive): `hexa cloud api <provider> <METHOD> <endpoint> [--data JSON] [--json]`
  — an AUTHENTICATED raw REST passthrough to the provider (vast.ai + runpod). METHOD ∈
  GET|POST|PUT|DELETE. Prints the response body; `--json` for machine surface. This one
  verb expresses alive/list/rent/destroy at the API layer → API fully replaced.
- @L2 (cli proxy): `hexa cloud provider-cli <provider> -- <args...>` — proxy the provider's
  OWN cli (vastai / runpodctl) with credentials injected, behind the guard, so CLI-only
  conveniences stay reachable without un-guarded raw `vastai`. (If a provider CLI binary is
  absent, report MISSING-CLI honestly, do not fake.)
- @L3 (auth d19/d3): reuse the EXISTING key resolution (`_vast_api_key`,
  `cloud_runpod_api_key`) + existing HTTP client the cloud module already uses for
  rent/down/alive. NO new HTTP stack, NO new cred path. Missing key → MISSING-CRED + exit 255.
- @L4 (SAFETY — the reason cloud-guard exists): read/diagnostic calls (GET / list / show)
  pass freely. A REGISTRY-MUTATING call (instance create/destroy via api or provider-cli)
  must NOT silently drift the M5 registry: either (a) refuse + redirect to the registry-aware
  verb (rent/rm) — preferred, or (b) auto-run `cloud reconcile` immediately after so the
  registry re-syncs. Document the chosen rule in --help. Default to REFUSE-mutating-with-redirect
  unless an explicit `--allow-mutate` flag + a post-call reconcile.
- @L5 (g5 + honesty d6): selftest with MOCKED HTTP fixtures (vast + runpod) covering
  GET success, auth-header injection, non-2xx → surfaced verbatim (not swallowed),
  empty-key → MISSING-CRED, and the mutating-call refusal/redirect path. Paste verdict
  VERBATIM. API errors surface raw; never fabricate a success. g4 <200 lines/concern, stacked PR.

## guards
- d9 worktree off origin/main HEAD; do NOT touch ~/.hx/src. Run via HEXA_STDLIB_ROOT=worktree.
- Compose with the just-shipped `alive` (#2498) + existing cloud_cli/cloud_commands modules
  (register verb row + dispatch + help-drift test, like #2498 did). No clobber.
- This IS the canonical guarded path (verb lives in hexa cloud) — g8 satisfied; the point is
  to make the guard COMPLETE, not bypass it.
- SHIP: self-merge PR(s). demiurge: append QFORGE-FEATURE.log.md row (commit only, no push, d9).

## final report
PR#(s), verb names as shipped, g5 verdict VERBATIM, the mutating-call safety rule chosen,
a live demo (`hexa cloud api vast GET <instances-endpoint> --json | head` if a key resolves,
else honest MISSING-CRED), demiurge commit sha.
