# demiurge

demiurge is a universal, hexa-native technical-design architecture program: it drives any engineering system through one 7-verb pipeline (spec → structure → design → analyze ⟲ → synthesize → verify → handoff), with each field plugged in as a manifest-only domain. It exposes a Next.js web GUI (the human surface) and a hexa-native CLI (the AI-agent surface) over the same generic dispatch, and consumes reusable implementation from the sibling `hexa-lang` repo (it never owns stdlib itself).

> The full governance source of truth is **`project.tape`** (the `@D d*` directive family). This file is the harness-standard summary + structure map; `project.tape` is authoritative.

## Structure

```
demiurge/
├─ bin/demiurge        — hx package entry point; headless / AI-agent CLI shim → cli/
├─ cli/                — hexa-native CLI driver (demiurge_cli.hexa); the 7-verb command surface
├─ web/                — Next.js web GUI (human surface, deployed to Cloud Run)
├─ cockpit/            — Swift DemiurgeCLI + DemiurgeCore library + transient exports/references
├─ stdlib/             — local discover shims (canonical reusable code lives in hexa-lang, d3)
├─ domains/            — manifest-only domain maps (<DOMAIN>.md + .log.md + .demi decks)
├─ decks/              — concrete compute input decks (DFT / QE el-ph cells)
├─ sim/                — simulation drivers / readout watchers (.hexa)
├─ QFORGE/             — quantum-forge DFT electron-phonon compute campaign workspace
├─ proposals/          — absorption / seam / cockpit design RFCs (rfc_001..012)
├─ exports/            — pipeline output records (chip NoC f1/f2, chain seams, per-domain)
├─ PAPER/ · PAPERS/    — generated papers (atlas-atom-gated, one slug per terminal discovery)
├─ .discoveries/       — /kick · /gap discovery log tapes (<slug>.tape)
├─ .verdicts/          — verify-gate verdict records
├─ .harness/           — repo-local harness rule configs (enforcement / keywords / severity)
├─ .harness-engine/    — dancinlab/harness engine, pinned as a git submodule (harness-hardcore)
├─ project.tape        — governance SSOT (@D d* directive family)
├─ ARCHITECTURE.md     — architecture SSOT (update-in-place)
└─ CHANGELOG.md        — append-only change log
```

## Governance (summary)

Authoritative directives live in `project.tape` (`@D d*`). The load-bearing ones:

- **`d3` / `d15` / `d17`** — implementation lives in one canonical home (`hexa-lang`); demiurge is a typed-interface *consumer*, never duplicates stdlib.
- **`d4`** — single generic dispatch; every variant / domain is a manifest, never a hardcoded name in the generic layer.
- **`d1` / `d5` / `d19`** — drive every non-wet-lab step to completed-form; `absorbed=true` ⇔ all non-wet-lab gates PASS.
- **`d17` / `d_deploy`** — validated decks fire compute campaigns autonomously (no user cost-gate); web-GUI deploy stays user-approval-gated.
- **`d_parallel_first` / `d_qforge_parallel`** — parallel-first; GRID-parallel compute to the walltime floor.
- **Single-doc discipline** — architecture goes in `ARCHITECTURE.md` (update-in-place); history in `CHANGELOG.md` (append-only); scratch under `scripts/scratch/`.

## Harness

This repo is governed by the **`dancinlab/harness`** engine, pinned as a git submodule at `.harness-engine` (branch `harness-hardcore`).

Activate the submodule after cloning:

```bash
git submodule update --init --recursive
```

Run any harness command via the bundled wrapper:

```bash
bash .harness-engine/bin/harness <cmd>
#   docs check     single-doc discipline (ARCHITECTURE.md SSOT + CHANGELOG.md log + quickref)
#   docs status    CLAUDE-MD discipline + scatter/quickref counts
#   lint           staged-L0 + freshness + changelog convergence
#   audit          6-axis self-scorecard
```

Config lives in **`harness.config.json`** (profile `hardcore`):
- `lockdown.files` — core source files that emit an L0-edit reminder on change.
- `lint.changelog` — staged code changes require `CHANGELOG.md` to be staged too.
- `lint.protectedBranches` — `main` / `master` (no direct commits).
- `docs` — `architecture=ARCHITECTURE.md`, `log=CHANGELOG.md`, `scratchDir=scripts/scratch`, and `scopeDirs:[""]` (scatter/quickref discipline applies to repo-root `.md` only, so the large research / domain document corpus under subdirectories is exempt).

The harness hooks are wired into `.claude/settings.json` (PreToolUse / PostToolUse / UserPromptSubmit / SessionStart), each guarded with `[ -x .harness-engine/bin/harness ] && … || true` so the repo stays usable when the submodule is uninitialized.

## Quick reference

- Architecture SSOT — [ARCHITECTURE.md](ARCHITECTURE.md)
- Governance SSOT (tape) — [project.tape](project.tape)
- Project overview — [README.md](README.md)
- Change log — [CHANGELOG.md](CHANGELOG.md)
