---
slug: drill-surface-candidates
mode: auto
status: done
auto-weights: complete=1, simple=0, safe=0, std=0
created: 2026-06-01
---

# drill-surface-candidates — plan

## task brief
Improve `hexa kick`/`hexa drill` so a material / non-math discovery run SURFACES
its concrete candidates instead of silently pooling them. Scoped finding:
`compiler/drill/drill.hexa` returns `VerifierVerdict { verdict: "skip" }`
(drill.hexa:208, also :98) whenever NO verifier is installed (`verifier_cmd == ""`).
The Mk.IX chain still GENERATES candidates (the overlay pool — "the discovery
candidate array", drill.hexa:142 — e.g. 517 overlay lines) but they are written
to the pool and NEVER emitted to stdout. So a materials seed (RTSC ambient
high-λ candidates) produces hundreds of ideas the user never sees. Fix is
completeness-driven and staged into two g4-compliant stacked PRs.

## locked decisions
- @L1 (PR구조): stacked 2 PR — PR1 surface, PR2 verifier hook · assert:grep stacked
- @L2 (surface수): default top-8 emit on skip + `--top N` override · assert:grep "--top"
- @L3 (tier): surfaced candidates tagged ⚪ proposal / to-validate, NOT a verdict · assert:grep proposal
- @L4 (랭킹): reuse existing ranking signal (no new scorer) · assert:grep conf
  - NOTE (verified vs code 2026-06-01): drill's `DiscoveryCandidate` (compiler/smash/candidate.hexa)
    has NO field literally named `impact`/`novelty`. The existing per-candidate ranking signal IS
    `conf` (heuristic confidence ∈ [0,1]). @L4 intent ("reuse the existing signal, invent no new
    scorer") is honored by ranking on `conf` (axiom>derived tiebreak). The original `grep impact`
    assert assumed a field name that does not exist → corrected to `grep conf`.
- @L5 (verifier계약): `--verifier <cmd>` consumes the overlay candidate array (drill.hexa:142 contract) · assert:grep "--verifier"
- @L6 (honesty): NO fabricated grading — g6/g63, surfaced = hypotheses only · assert:grep !SUPPORTED

## next-action checklist
- [x] step 1: confirmed the skip path + overlay-pool + `_verifier_parse_verdict`. Finding refined: drill.hexa already had a verifier hook (`--verifier-cmd`, `_verifier_run`); the real gaps were (a) discoveries never reach stdout on skip [PR1], (b) the payload `_verifier_payload` explicitly EXCLUDED the candidate array [PR2]. Confirmed cold-run measure: 1-round Li2MgH16 → overlay 343 lines, 0 surfaced.
- [x] step 2 (PR1, core, +106/-3 in drill.hexa): skip path emits top-N ranked candidates as `⚪ proposal`, ranked by existing `conf` signal, `--top N` (default 8) + `--top 0` legacy. → #2384 (MERGED).
- [x] step 3: PR1 selftest compiler/drill/surface_test.hexa — 6/6 PASS (N>0, --top 5/3/0 honored, ⚪ proposal tier, no verified-tier token).
- [x] step 4 (PR2, core, +94/-18 in drill.hexa): payload gains `"candidates":[{id,conf,axiom,src,expr}]` (cap `verifier_cand_cap` default 64) fed to `--verifier <cmd>`; verdict parsed by existing `_verifier_parse_verdict`. → #2389 (MERGED, base=main since PR1 landed first).
- [x] step 5: PR2 selftest compiler/drill/verifier_hook_test.hexa — 5/5 PASS (stub invoked, received populated candidate array 13276 bytes, strict pass halted loop, verdict reported verbatim).
- [x] step 6: g5 — selftest verdicts pasted VERBATIM into both PR bodies. No LLM self-judge.
- [x] ship: 2 PRs shipped. Korean commit bodies / English titles. Explicit `git add <files>` only (d9). PR2 done in an ISOLATED worktree (`hexa-lang-drillpr2` off origin/main) after a concurrent agent stashed shared-worktree WIP — d9 isolation hazard hit + recovered. `sidecar sync` ran post-merge.

## completion criteria
- PR1 merged-or-open: drill skip path emits top-N ⚪ proposal candidates to stdout; selftest green.
- PR2 merged-or-open (stacked): `--verifier <cmd>` consulted with the overlay array; selftest green.
- Both PRs <200 LOC, 1 logical thing each (g4); selftests pass; g5 verdicts pasted verbatim.
- Honesty gate held (g6/g63): surfaced candidates are ⚪ proposals, never a SUPPORTED/GATE verdict.

## qa-results

### 2026-06-01 — ship complete (both PRs MERGED)

PRs: #2384 (surface-on-skip, MERGED) · #2389 (verifier candidate-array, MERGED). Both in origin/main.
LOC (core drill.hexa): PR1 +106/-3 · PR2 +94/-18 — each < 200, one logical thing (g4 ✓).
`sidecar sync`: RAN post-merge (107 plugins cached · 58 commands mirrored).

4-axis auto-QA:
- **functional** — PASS. Cold-scratch selftests (built fresh, no warm cache leak):
  surface_test.hexa **6/6 PASS** · verifier_hook_test.hexa **5/5 PASS**. Verbatim verdicts in both PR bodies.
  End-to-end: 1-round Li2MgH16 skip run now surfaces ⚪ proposals to stdout (was: 343 overlay lines, 0 shown).
- **visible** — PASS. The user-visible behavior is the deliverable: a materials seed now PRINTS its top-N
  candidates (`⚪ proposal #k [conf=…] <id> (<src>): <expr>`) instead of silent pooling. `--top N` controls count.
- **conformance** — PASS w/ 1 corrected contract. @L1/@L2/@L3/@L5/@L6 honored. @L4 corrected:
  drill has no `impact`/`novelty` field; the existing ranking signal IS `conf` (per-candidate confidence).
  Ranked on `conf` (axiom>derived tiebreak) — reuses existing signal, no new scorer. plan @L4 updated to `grep conf`.
  Honesty (g6/g63): surfaced rows carry literal `⚪ proposal` tier; selftest asserts ZERO SUPPORTED/GATE/formal/pass token.
- **regression** — PASS. PR2's payload change does not break PR1's surface path (surface_test 6/6 still green on PR2 branch).
  Back-compat: `--top 0` = legacy silence; `verifier_cmd==""` path byte-behavior preserved (verdict "skip").
  Note: a test-determinism flake (cold-build first-run swallows stdout) was found + fixed with a warm-up invocation
  in both selftests (3rd PR2 commit) — NOT faked; root cause is the same build-harness behavior that truncates the
  legacy /tmp-HOME drill_test.

Process note (d9): the shared main worktree had its branch switched + my PR2 WIP stashed by a concurrent agent
mid-task. Recovered by re-applying PR2 in a dedicated isolated worktree off origin/main (edit→commit→push fast per
the durable-worktree rule). No work lost; no force-push.
