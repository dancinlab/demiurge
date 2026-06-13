---
slug: demi-cli-hexa-native
mode: auto
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-05-29
decision: Swift DemiurgeCLI is being SCRAPPED — migrate the demiurge CLI to a hexa-native CLI (g1)
---

# demi-cli-hexa-native — plan

## task brief
The demiurge CLI is currently the Swift `cockpit/Sources/DemiurgeCLI/main.swift` (invoked via the
`bin/demiurge` bash wrapper → `swift run DemiurgeCLI`). Swift is being SCRAPPED. Migrate the demiurge
CLI to a **hexa-native CLI** (g1 — hexa-native first; the whole stack is hexa). Preserve the user-facing
`demiurge cli <verb>` surface + the `bin/demiurge` entry, swapping the Swift core for a hexa-lang
implementation. Discovery-first (enumerate the real Swift verb/flag surface), port verb-by-verb with
behavior PARITY, keep Swift until parity is reached, then retire it.

## locked decisions (AUTO 1:1:1:1)
- Q1 target: **hexa-native CLI** — reimplement the demiurge CLI verbs in hexa-lang (canonical hexa CLI pattern), NOT Swift. (Assumption flagged to user; "일반 CLI" interpreted as hexa-native per g1 + full hexa stack.)
- Q2 scope: DISCOVERY-FIRST — read `cockpit/Sources/DemiurgeCLI/main.swift` + `bin/demiurge`; enumerate every verb (e.g. discover · synth · action · analyze · llm · version · cli · …), its flags, error wording, exit codes. That surface is the parity spec.
- Q3 strategy: incremental, stacked PRs (g4 <200 lines each) — scaffold the hexa-native CLI skeleton + dispatcher first, then port verb-groups one PR at a time, each with parity. Keep the Swift CLI working (bin/demiurge routes to it) until the hexa CLI reaches parity; flip the wrapper + retire Swift in a FINAL PR. Do NOT delete Swift before parity.
- Q4 verify: `@ci_gate`/parity smoke — each ported verb parses + dispatches identically to the Swift one (same args → same routing/exit/error wording where it's behavior, not impl); `bin/demiurge cli <verb>` routes to the new hexa CLI. Paste verdicts VERBATIM.
- Q5 execution: hexa build/test on POOL ubu-1 (repo-hexa_v2 + clang workaround). The Mac demiurge tree is on `pr35-topbar-client` with unrelated changes — for demiurge-repo edits use a fresh worktree off origin/main (don't entangle pr35). Stacked PRs; Swift retirement is the last PR only after parity.

## next-action checklist
- [ ] DISCOVERY: read cockpit/Sources/DemiurgeCLI/main.swift + bin/demiurge → enumerate verbs/flags/exit-codes/error-wording = the parity spec (write it into the plan/report)
- [ ] decide the hexa-native CLI home (hexa-lang stdlib demiurge CLI module vs a demiurge-repo hexa entry) — pick the canonical hexa CLI pattern; note it
- [ ] PR1: scaffold hexa-native CLI skeleton + verb dispatcher (d4 generic dispatch, no per-verb hardcode in the generic layer) + `version`
- [ ] PR2..N: port verb-groups (discover/synth/action/analyze/llm/…) one PR each, parity smoke per verb
- [ ] PR-final: flip bin/demiurge to route to the hexa CLI; RETIRE Swift DemiurgeCLI (remove cockpit/Sources/DemiurgeCLI) only after full parity
- [ ] @ci_gate/parity smoke per PR; build+run on ubu-1; verdict verbatim
- [ ] ship each: explicit paths, Korean commit, gh pr create, verify MERGED, sidecar sync; fresh worktree off origin/main (don't touch pr35)

## completion criteria
- The demiurge CLI runs hexa-native (Swift DemiurgeCLI retired); `demiurge cli <verb>` preserves the
  prior behavior (parity smoke PASS per verb); `bin/demiurge` routes to the hexa CLI. Stacked PRs merged.
  Swift removed only after parity. If full migration exceeds one session, ship the scaffold + ported
  verbs + an honest "remaining verbs" list (do NOT retire Swift until parity is real).

## qa-results
