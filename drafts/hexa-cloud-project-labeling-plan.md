---
slug: hexa-cloud-project-labeling
mode: auto
status: done
auto-weights: complete=1, simple=0, safe=0, std=0
created: 2026-06-08
---

# hexa-cloud-project-labeling — plan

## task brief
`hexa cloud rent` should auto-capture the ACTIVE project (@domain from
DOMAINS.tape) + a task purpose/description and persist them so `hexa cloud list`
shows, per pod: project · purpose alongside id/provider/status/cost/age. The
labeling concept already exists in `stdlib/cloud/` (down_confirm surfaces
"project·purpose"; pod_registry stores records) but is not wired through the
rent→registry→list path end-to-end (pods rented via raw `vastai` show only a
manual label like `r12d-aagc`). Restore/complete it. Repo = hexa-lang
(`~/.hx/src`), NOT demiurge.

## locked decisions
- @L1 (schema): registry record carries project + purpose + created + status + dph · assert:grep purpose
- @L2 (source): project ← the REPO/FOLDER/PROJECT NAME (git repo basename of the cwd, e.g. cwd `/Users/mini/dancinlab/demiurge` → project `@demiurge`), NOT the DOMAINS.tape domain. Resolve via `git rev-parse --show-toplevel` basename (fallback: cwd basename). purpose ← `--desc`/`--purpose` flag, fallback "unspecified" · assert:grep "desc"
- @L3 (storage): persist to ~/.hx/cloud/active-pods.json registry AND pass a provider `--label` (project-purpose slug) on create · assert:grep "active-pods"
- @L4 (list): `hexa cloud list` renders columns id · provider · project · purpose · status · dph · age · assert:grep "project"
- @L5 (scope+test): implement in stdlib/cloud (rent + list + pod_registry); add/extend a *_test.hexa covering schema round-trip + list render · assert:file stdlib/cloud/pod_registry.hexa

## next-action checklist
- [ ] locate the rent path: `stdlib/cloud/cloud.hexa` + `provider_cli.hexa` + `pod_registry.hexa` + `cloud_commands.hexa`; read how a record is written today and what `cloud list` (or `cloud pods`) renders
- [ ] identify WHY project/purpose is missing in practice (rent verb not capturing active @domain? list renderer not showing the field? field absent from the registry schema?)
- [ ] active-domain resolver: read the active row from the repo's DOMAINS.tape (the ★ active domain) — reuse existing domain-plugin convention; if none active, project="(none)"
- [ ] schema: ensure the pod registry record (active-pods.json) has `project` + `purpose` + `created` + `status` + `dph`; migrate old records gracefully (missing fields → "(legacy)")
- [ ] rent verb: accept `--desc`/`--purpose <text>`; auto-fill project from active domain; write both to the registry AND to the provider create `--label` as a slug
- [ ] list verb: render the columns (@L4); keep machine `--json`/`--raw` output intact
- [ ] tests: extend stdlib/cloud/*_test.hexa — schema round-trip + list render shows project·purpose; `hexa test` green
- [ ] ship (explicit paths · Korean commit msg · push · `sidecar sync`); reinstall not required unless the user runs hexa cloud from the release binary (note it)

## completion criteria
`hexa cloud rent` (or the canonical rent verb) writes project(@domain)+purpose
to active-pods.json + provider label; `hexa cloud list` shows them per pod;
new/extended cloud test passes under `hexa test`; landed via PR in hexa-lang
with a Korean commit message; report the verb syntax (e.g. `hexa cloud rent
... --desc "<text>"`) back so the user can use it for the next R12-GOLD rent.
