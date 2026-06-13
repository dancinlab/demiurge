---
slug: system-lab-mirror-cleanup
mode: auto:safety
status: shipped
auto-weights: complete=1, simple=1, safety=2, std=1
created: 2026-05-30
repo: sidecar (~/core/sidecar)
---

## task brief

Finish the `system → lab` skill rename so the deprecated `system` skill stops
DOUBLE-surfacing in the Claude Code TUI.

DIAGNOSIS (done): `lab@1.3.2` is the only INSTALLED plugin (installed_plugins.json)
and the only non-orphaned cache version; ALL `~/.claude/plugins/cache/sidecar/system/*`
carry `.orphaned_at` (since ~2026-05-28). `lab` already keeps `/system` + 관제탑 +
mission-control + control-tower + campaign-status as DEPRECATED ALIASES in its own
triggers, so routing works. THE BUG: `sidecar mirror` (runs every `/ij`) STILL
regenerates `~/.claude/commands/system.md` (timestamp matches the lab.md write) from
the orphaned `system` plugin, so the TUI shows a SECOND `/system` entry rendering the
OLD short 0.4–0.6-era description (no progress/mirror/tick/pursue) — and a direct
bare `/system` invocation could run that stale prose instead of lab.

## locked decisions

- @L1 (safety): ROOT FIX is DOUBLE — (a) remove the stale `system` remnant from the
  mirror SOURCE (sidecar marketplace.json entry and/or leftover plugin dir the mirror
  enumerates), AND (b) add a defensive guard in the `sidecar mirror` code so a
  fully-orphaned / superseded plugin is NEVER command-mirrored again (future renames
  won't recur) · assert:grep orphan (mirror source references an orphaned-skip)
- @L2 (simple): do NOT delete the orphaned `system` cache tree (history); only stop it
  being mirrored + remove the generated `~/.claude/commands/system.md` · assert:!file ~/.claude/commands/system.md
- @L3 (std): after the fix, running `sidecar mirror` must leave `~/.claude/commands/lab.md`
  PRESENT and `~/.claude/commands/system.md` ABSENT · assert:file ~/.claude/commands/lab.md
- @L4 (safety): the `/system` (+관제탑·mission control·control tower·campaign status)
  DEPRECATED ALIAS INSIDE lab's triggers stays INTACT — typing `/system` must still
  resolve to lab (lossless muscle memory). Do NOT touch lab's SKILL.md trigger list · assert:grep system
- @L5 (std): single small PR on the sidecar repo, version surfaces bumped per sidecar's
  convention (plugin.json · marketplace.json · README · CHANGELOG lockstep, g22)

## next-action checklist

- [ ] cd ~/core/sidecar · `git fetch origin` · create worktree
      `~/core/sidecar-syslab-cleanup` off origin/main (NOT /tmp); push branch
- [ ] INVESTIGATE root cause FIRST: read the `sidecar mirror` implementation +
      `marketplace.json` — find WHY `system` is still emitted (stale marketplace
      entry? leftover plugin dir? mirror enumerates cache incl. orphaned?). Report
      the exact root before editing.
- [ ] FIX (a): remove the stale `system` source remnant (marketplace.json entry /
      leftover dir) — keep `lab` intact
- [ ] FIX (b): add an orphaned/superseded-skip guard in the mirror code so a plugin
      whose only cache versions are `.orphaned_at` (or absent from installed set) is
      never written to `~/.claude/commands/`
- [ ] remove the already-generated `~/.claude/commands/system.md`
- [ ] VERIFY: run `sidecar mirror` → assert `~/.claude/commands/system.md` ABSENT,
      `lab.md` PRESENT; grep lab SKILL.md confirms `/system` alias still listed
- [ ] bump version surfaces (plugin.json · marketplace.json · README · CHANGELOG)
- [ ] ship — commit (Korean body) · push · `gh pr create` · report PR URL

## completion criteria

- `sidecar mirror` (and therefore `/ij`) no longer creates `~/.claude/commands/system.md`.
- A future fully-orphaned/renamed plugin is also skipped (defensive guard present).
- `~/.claude/commands/lab.md` still present; `/system` still resolves to lab via the
  deprecated alias (no broken muscle memory).
- PR landed on sidecar; version surfaces bumped lockstep.
- The orphaned `system` cache tree is left untouched (history preserved).
