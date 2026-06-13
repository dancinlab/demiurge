---
slug: system-to-lab-redesign
mode: auto
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-05-29
repo: ~/core/sidecar (plugin — system skill → lab)
---

# system-to-lab-redesign — plan

## task brief
Rename the `system` campaign control-tower skill/plugin to `lab` (research-lab metaphor),
keeping `/system` + Korean triggers as lossless deprecated aliases. Add a `lab progress`
campaign-ARC progress subcommand (distinct from the live-job `status`). Plan a coherent
lab-lifecycle subcommand set and create the two explicitly requested (`progress`, `mirror`),
stubbing the rest. Integrate the "mirror room" by delegating `lab mirror` to the existing
mirror-loop skill (no duplication). Ship as stacked PRs in ~/core/sidecar.

## locked decisions (AUTO-picked 1:1:1:1)
- Q1 rename: dir/command/skill → `lab`; keep `system`, `관제탑`, `mission control`, `control tower` as deprecated trigger aliases spliced into the new skill (lossless, no broken muscle memory).
- Q2 verb preservation: ALL 11 existing verbs (status · tick · watch · harvest · next · auto · drive · pursue · stop · cost · queue · upstream) preserved verbatim — the rename is additive; bin/system_harness.hexa logic untouched (rename file only if cheap, else keep + reference).
- Q3 progress subcommand: `lab progress` = campaign-ARC view — verdicts closed (🟢/🔵/🔴 counts from exports/*/ledger.json + .verdicts/), papers shipped (PAPER.tape), atlas atom growth (hexa atlas stats), domain milestones (DOMAINS.tape) — a "where is the whole research program" 10-cell bar. DISTINCT from `status` (live per-job dashboard).
- Q4 subcommand set: CREATE `progress` + `mirror` now; PLAN + stub `notebook` (append-only lab journal / decision log), `bench` (micro-experiment sweep → wraps /micro-exp), `review` (verdict-matrix audit). Document the full set in the SKILL.md verb table.
- Q5 mirror room: `lab mirror` delegates to the mirror-loop skill (mining→kick→atlas self-evolution) — d4 single-dispatch reuse, NOT a reimplementation.
- Q6 ship scope: stacked PRs (g4, <200 lines each) — PR1 rename+alias, PR2 `lab progress`, PR3 `lab mirror` + the subcommand-plan section. Single worktree branch-swap (`git reset --hard origin/main && git checkout -b feat/<n>` per layer — 5-10× faster than N worktrees).
- Q7 repo: ~/core/sidecar; g22 version-bump lockstep (plugin.json · marketplace.json · README · CHANGELOG) on each PR; `/ship`-style commit + `sidecar sync`.

## next-action checklist
- [ ] read ~/core/sidecar/skills/system/{SKILL.md,.claude-plugin/plugin.json,commands/*,bin/system_harness.hexa} to map the rename surface
- [ ] grep the sidecar repo for cross-references to the `system` skill/command (marketplace.json, other skills' triggers, docs) so the rename is lossless
- [ ] PR1: rename skills/system → skills/lab (dir + plugin.json name + command file + SKILL.md title); add `system`/`관제탑`/`mission control`/`control tower` as deprecated aliases; bump versions; ship + sidecar sync
- [ ] PR2: add `lab progress` verb — campaign-ARC bar (verdicts/papers/atlas/milestones), read-only; document in verb table; bump + ship
- [ ] PR3: add `lab mirror` verb (delegate to mirror-loop) + a `## planned subcommands` section documenting notebook/bench/review (stubbed); bump + ship
- [ ] ship (explicit paths · Korean commit msg · sidecar sync after each push · gh pr create --head)

## completion criteria
- `/lab` resolves to the renamed skill; `/system` still works (deprecated alias) — no broken trigger.
- `lab progress` renders a campaign-ARC 10-cell bar from real sources (ledger/PAPER.tape/atlas stats/DOMAINS.tape).
- `lab mirror` invokes the mirror-loop flow (delegation, not duplication).
- SKILL.md verb table lists all created + planned subcommands.
- 3 stacked PRs opened/merged in ~/core/sidecar; versions bumped in lockstep; marketplace cross-refs updated.

## qa-results

AUTO-QA 4-axis (run 2026-05-29 against merged origin/main `ebfb304`) — ALL PASS.

- **functional ✅** — skill resolves as `lab` @ 1.2.0; command mirrored to `~/.claude/commands/lab.md` (sidecar sync HEAD `ebfb304`, retired `system` pruned). All 14 verb-table entries present (11 original status·tick·watch·harvest·next·auto·drive·pursue·stop·cost·queue·upstream + new progress + mirror). Harness referenced 4× at `${CLAUDE_PLUGIN_ROOT}/bin/system_harness.hexa` (file moved with dir, path resolves). `allowed-tools` += `Skill` for the mirror delegation. All JSON (plugin.json·marketplace.json·profiles.json) parses.
- **visible ✅** — new `/lab` command surface live (`~/.claude/commands/lab.md`); new triggers present (`/lab`·`랩`·`연구실`·`lab progress`·`연구 진척도`·`lab mirror`·`거울방`).
- **conformance ✅** — diff ↔ locked decisions: Q1 rename+alias (skills/system→skills/lab, `/system`+관제탑+mission control+control tower+campaign status kept as deprecated aliases) · Q2 11 verbs verbatim + `bin/system_harness.hexa` filename/logic untouched (cheaper option taken) · Q3 `lab progress` 4-source ARC bar (verdicts/papers/atlas/milestones) distinct from `status`, graceful degrade · Q4 progress+mirror created, notebook/bench/review documented as planned stubs · Q5 `lab mirror` delegates to mirror-loop (d4, no reimpl) · Q6 3 stacked PRs each <200 lines, single concern · Q7 g22 lockstep (plugin.json·marketplace·profiles·CHANGELOG) + sidecar sync after each push.
- **regression ✅** — 11 original verbs + their triggers still parse; `/system` deprecated alias preserved (still resolves to lab); version lockstep plugin.json==marketplace==1.2.0; profiles.json `lab:personal` present, `system` key absent; no `skills/system` leftover on disk; marketplace has exactly 1 `lab` entry / 0 `system` / 83 total (no plugin lost). Only residual `/system` refs are in `hooks/pods-route/` docs describing pods-route as a CONSUMER of the `/system` SSOT — NOT broken (the `/system` alias still works), so no revert needed.

### PR ledger
| PR | branch | version | scope | state |
|---|---|---|---|---|
| #249 | feat/lab-1 | 1.0.0 | rename system→lab + deprecated aliases | MERGED |
| #250 | feat/lab-2 | 1.1.0 | `lab progress` read-only ARC bar | MERGED |
| #251 | feat/lab-3 | 1.2.0 | `lab mirror` (→mirror-loop) + planned stubs | MERGED |

verdict: SHIP — no regression, no revert. origin/main `ebfb304`.
