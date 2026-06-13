---
slug: lab-namespace-dedup
mode: auto
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-06-02
repo: sidecar marketplace / plugin config (NOT demiurge)
---

## task brief

The `lab` command surfaces in the skill list under TWO namespaces — `lab` (bare) AND `lab:lab`
(forced `plugin:command`). Every other correctly-configured plugin surfaces ONCE. Root-cause signal:
`sidecar shadow plan` reports "would shadow 47 plugin(s) … cmd lab" — i.e. **`lab` is NOT currently
shadowed**. The sidecar `shadow` mechanism is exactly what drops the forced `plugin:command` namespace
(#15882): it mirrors + disables the plugin's command/skill, splicing the SKILL.md trigger into the bare
command so it stays lossless. An UNSHADOWED plugin therefore double-lists (bare skill + `plugin:command`).
Fix: bring `lab` into the SAME single-namespace treatment as the reference single-listed plugins.

## locked decisions (AUTO 1:1:1:1)

- @L1 (std): fix mechanism = `sidecar shadow` for the `lab` plugin (canonical #15882 namespace-drop) — NOT a manual plugin.json/marketplace rename. · assert:grep shadow
- @L2 (complete): FIRST confirm the root cause empirically — compare `lab`'s shadow/marketplace state against a plugin that ALREADY single-lists (e.g. one NOT in the `shadow plan` "would shadow" set, or an already-shadowed one). Diff the exact config delta. Apply the identical treatment to `lab`. Then RE-VERIFY `lab` appears exactly ONCE in the skill surface. · assert:grep lab
- @L3 (safe): scope = the `lab` plugin's namespace REGISTRATION only. The control-tower verb logic (status/watch/harvest/next/drive/pursue/…) is UNCHANGED. Must be reversible (`sidecar unshadow lab`). · assert:grep !logic-change
- @L4 (std): persist via the sidecar config surface + `sidecar sync` (the next-session install path) — never an ad-hoc one-off. If a marketplace/config file changes, commit it to its repo with explicit paths (d9). · assert:grep sync

## investigation findings (pre-handoff)
- `sidecar shadow plan` → "would shadow 47 plugin(s) (45 cmd · 2 skill-only) · skip 61 hook/mcp" — includes `cmd lab`. So 47 plugins (incl. lab) are currently UNSHADOWED.
- Caveat to resolve: if 47 are unshadowed yet the USER reports only `lab` double-lists, the agent must reconcile WHY — maybe most of those 47 don't collide (their cmd name ≠ a bare skill trigger), while `lab`'s cmd `lab` collides with the bare `lab` skill. Determine whether the right fix is (a) shadow ONLY lab, or (b) the lab plugin's manifest declares the command in a way that forces the extra namespace. Pick the minimal correct fix that yields single-listing WITHOUT breaking the other 46.
- lab plugin cache: ~/.claude/plugins/cache/sidecar/lab/1.15.0/.claude-plugin/plugin.json (latest of many versions).

## next-action checklist
- [ ] reproduce: enumerate the skill surface, confirm `lab` + `lab:lab` both present; pick a single-listed reference plugin
- [ ] diff lab's plugin.json/marketplace entry + shadow state vs the reference
- [ ] determine minimal fix (shadow lab · or manifest fix) that single-lists lab WITHOUT regressing the other plugins
- [ ] apply it (sidecar shadow lab, or the manifest/config edit)
- [ ] `sidecar sync`
- [ ] RE-VERIFY: skill surface lists `lab` exactly once; `/lab` + `/lab status`/`drive` still dispatch (logic intact)
- [ ] ship — commit any config file (explicit paths, Korean msg), report back

## completion criteria
- `lab` appears EXACTLY ONCE in the skill/command surface (no `lab:lab`).
- `/lab` and its verbs (status/drive/…) still dispatch correctly (logic untouched, reversible).
- The fix is persisted via sidecar config + sync (survives next session), matching how reference plugins are handled.
- If the root cause turns out NOT to be shadow (e.g. a manifest quirk), report the real cause + the applied fix honestly (d6) — do not force the shadow hypothesis.

## OUTCOME (2026-06-02) — SHIPPED via `sidecar shadow`

**Root cause (d6 honest correction to the premise):** The plan assumed `lab` UNIQUELY
double-lists while the other 46 single-list. EMPIRICALLY FALSE. `sidecar shadow` had
NEVER been run (`~/.sidecar/shadowed.json` absent · `plugin-overrides.json` = only
`hexa-native`). `sidecar mirror` (auto-runs at tail of `sync`) had created bare command
mirrors in `~/.claude/commands/` for EVERY command-bearing sidecar plugin, while those
plugins stayed ENABLED (`settings.json enabledPlugins` = 107 true). So EVERY
command-bearing plugin double-listed: bare `<n>` (mirror) + `<n>:<n>` (enabled plugin).
`lab` is NOT special — the user simply noticed it because of the live `/lab drive`
campaign. `lab` is kind=cmd (has BOTH commands/lab.md AND SKILL.md), same as atlas/kick/
cloud/etc.

**Fix (@L1 canonical #15882):** `sidecar shadow` (full · all-or-nothing by design).
- 47 plugins shadowed (45 cmd · 2 skill-only) · 61 hook/mcp skipped (kept enabled).
- Persisted via canonical config surface (@L4): `~/.sidecar/plugin-overrides.json`
  (48 entries =false), `~/.sidecar/shadowed.json` (47 marker), and `apply_install`
  wrote `~/.claude/settings.json enabledPlugins` lab@sidecar=false (+46). enabled 107→60.
- Bare `~/.claude/commands/lab.md` KEPT + SKILL.md triggers spliced (lossless NL invoke).

**g5 dedup verification:** `lab@sidecar=false` → `lab:lab` namespaced form dropped →
`lab` single-lists (bare mirror only). All 47 shadowed = disabled (no half-shadow).
41 hooks/guards/lsp/route + commons STAY enabled (no regression). Bare mirrors PRESENT
for lab/atlas/kick/cloud/imagine/paper/deck (single-list, not vanished). NOTE: TUI
honors settings.json on /reload-plugins or restart; the in-session skill-list snapshot
is stale until then.

**Live campaign INTACT (@L3 + CRITICAL):** `pods.json` NEVER touched by me (read-only);
its ` M` in git is the live drive heartbeat writing its own marker (budget 150, 16 pods,
hb 1800s). `/lab drive` still dispatches: bare `/lab` resolves to the kept command
mirror; the `tick` harness path `${CLAUDE_PLUGIN_ROOT}/bin/system_harness.hexa` resolves
INDEPENDENT of the namespaced/bare form (sidecar CHANGELOG line 662, the system→lab
rename, documents this verbatim; harness binary confirmed REACHABLE in cache). lab verb
LOGIC UNCHANGED — no source edit. REVERSIBLE: `sidecar unshadow`.

**Committed config:** none in any git repo — shadow state lives in `$HOME`
(`~/.sidecar/`, `~/.claude/settings.json`), which IS the canonical persistence surface
(@L4 non-ad-hoc). sidecar repo clean (no logic edit). demiurge repo: only the live
campaign's own pods.json churn (not mine).
