---
slug: pod-attribution-ownership-split
mode: auto (4-axis: complete forced)
status: done
auto-weights: complete=1 simple=0 safe=0 std=0
created: 2026-06-04
target-repos: hexa-lang (stdlib/cloud) + sidecar (registry/harness)
---

## task brief

Fix pod labeling/attribution so every rented pod is recorded with NO omission,
under a clean ownership split the user mandated:

- **hexa cloud (hexa-lang stdlib/cloud) = REAL POD OPERATIONS ONLY** — rent / ssh /
  exec / down on the provider. It must NOT own the attribution/label harness; it
  EMITS raw pod facts (pod-id · host · provider · state) and stops writing
  attribution metadata into the registry. "쓰기 금지" = hexa cloud is write-forbidden
  to the attribution/label fields.
- **sidecar = OWNS THE HARNESS** — attribution, labels, the active-pods registry
  SSOT. sidecar records {project/owner · candidate · lane/campaign · kind} for
  every pod with no omission + fallback defaults; sidecar is the writer.

Symptom that motivated this: RTSC vast gate anchors (39247634=CaH6 · 39291022=LaH10 ·
39291033=Li2MgH16 · 39309987=ScH9) launched via `hexa cloud dft-run` show as
"@unattributed / (hexa-cloud rent)" — the campaign/candidate label was never
recorded, so a human had to crack open each pod's deck (prefix=cah6…) to tell
which job is whose.

BOTH repos change (user: "둘 다 수정"), with the boundary: hexa cloud = facts,
sidecar = harness.

## locked decisions

- @L1 (complete): OWNERSHIP SPLIT — hexa cloud (hexa-lang stdlib/cloud) does pod-ops ONLY and is WRITE-FORBIDDEN to the attribution/label registry fields; sidecar OWNS the attribution + label + active-pods registry harness (the writer). BOTH repos modified · assert:grep "attribution"
- @L2 (complete): hexa-lang PR — rent / dft-run STOP stamping attribution into the registry; instead EMIT a machine-readable rent-result line (pod-id · host · provider · state · any caller-passed label/project/deck context) on stdout. The raw-facts emit is the ONLY registry-relevant output from hexa cloud. Existing pod-ops (rent/ssh/exec/down/dedup-by-id) unchanged · assert:grep "rent-result"
- @L3 (complete): sidecar PR — a sidecar registry recorder OWNS the attribution write: it captures the hexa cloud rent-result + caller context and records the registry entry with {project · candidate · lane · kind} populated with NO empty field; fallback chain when unspecified (explicit flag > derived: project=cwd git-repo basename · candidate=deck ph.in `prefix=` else deck dirname · kind="dft-run"/"rent" · lane=project). sidecar owns active-pods registry SSOT going forward · assert:grep "attribution"
- @L4 (complete): NO-OMISSION invariant — the sidecar recorder NEVER writes an entry with an empty project/candidate/kind; a genuinely underivable field gets an explicit sentinel (e.g. "unattributed") AND a logged warning, never a silent blank · assert:grep !"silent"
- @L5 (complete): each repo has a g5 `@ci_gate` selftest — hexa-lang: assert rent/dft-run EMITS rent-result facts AND does NOT write attribution fields itself (pod-ops-only); sidecar: assert the recorder fills project·candidate·kind·lane with no empty field + explicit-flag precedence + deck-prefix/cwd fallback + the no-omission warning fires on an underivable field. Paste verdicts VERBATIM, no LLM self-judge · assert:grep "selftest"
- @L6 (safe): NO running RTSC/ABFE job touched — vast pods 39247634 / 39291022 / 39291033 / 39309987 + summer ABFE are READ-ONLY-untouched; pure code + selftest against stubs / throwaway dirs. The 4 live pods' attribution BACKFILL is a SEPARATE, user-confirmed, metadata-only step AFTER merge (never in these PRs, never touches the running jobs) · assert:grep "selftest"
- @L7 (std): land as 2 PRs (one per repo), each off `origin/main` in an isolated worktree, <200 LOC, 1 concern, g5 selftest green, DRAFT, NO merge — user reviews. The boundary contract (rent-result schema) documented in both PR bodies so they compose · assert:grep "draft"

## next-action checklist

- [ ] RECON: locate both write paths. hexa-lang: `stdlib/cloud/cloud_cli.hexa` (`_rent_register_pods_json`, `pod_registry_record`, rent main path ~line 1145-1204) + `pod_registry.hexa` (active-pods.json writer) + the dft-run path. sidecar: find the sidecar SOURCE repo (NOT the ~/.claude/plugins/cache mirror) — try `~/core/sidecar`, `~/dancinlab/sidecar`, `git remote` of the sidecar marketplace; find where/if sidecar already touches active-pods.json or pod state. Map the rent-result emit point + the sidecar recorder seam.
- [ ] decide active-pods.json ownership transfer mechanics: simplest robust path that satisfies "sidecar owns the harness" without breaking hexa cloud's read-side pod-ops (down-guard/dedup READ active-pods.json). Likely: hexa cloud keeps READING it for pod-ops, but the ATTRIBUTION FIELDS are written only by sidecar's recorder. Document the chosen split in plan handoff.
- [ ] hexa-lang PR (raw-facts emit): make rent/dft-run print `rent-result pod=<id> host=<h> provider=<p> state=<s> [label=<l>] [project=<p>] [deck=<prefix>]` (machine-readable) and remove/neutralize the hexa-cloud-side attribution stamping (owner default "(hexa-cloud rent)") so it no longer fabricates a blank/owner label. Keep id/host/state pod-ops fields. selftest: rent-result emitted + no attribution write. <200 LOC
- [ ] sidecar PR (attribution harness): add the registry recorder that consumes rent-result + context → writes {project·candidate·lane·kind} no-omission + fallback + warning. selftest: all fields filled · flag precedence · deck-prefix/cwd fallback · underivable→sentinel+warn. <200 LOC
- [ ] regression: hexa-lang existing cloud selftests (rent_idempotent · pod_registry_atomic · registry_endpoint_resolve) green; sidecar existing tests green; hexa cloud pod-ops (read active-pods.json) unbroken
- [ ] each PR: build + selftest green (verbatim), Korean commit msg, push, `gh pr create --draft`; do NOT merge; `sidecar sync` after
- [ ] note PR#s back; the 4 live-pod backfill stays a post-merge user-confirmed metadata step (NOT done here)
- [ ] ship: report the 2-PR pair + verdicts VERBATIM + the boundary contract; NO force-push, NO merge

## completion criteria

- 2 PRs (hexa-lang raw-facts emit + sidecar attribution harness), each <200 LOC, draft, g5 @ci_gate selftest GREEN verbatim
- hexa cloud proven pod-ops-only (selftest: no attribution write) · sidecar proven no-omission recorder (selftest: all fields + fallback + warn)
- boundary contract (rent-result schema) documented in both PR bodies so they compose
- NO running RTSC/ABFE job perturbed · 4 live-pod backfill deferred to post-merge user-confirmed metadata-only step
- pushed (not merged) · reported with PR numbers
