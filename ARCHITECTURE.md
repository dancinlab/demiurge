# demiurge — Architecture (SSOT · update-in-place)

> This file is the single source of truth for demiurge's architecture.
> **Update it in place** (overwrite) — it is not an append log. History and
> dated decisions live in `CHANGELOG.md` (append-only) and `DESIGN.log.md`.
> Governance directives are in `CLAUDE.md` / `project.tape`.

## Overview

demiurge is a **universal, hexa-native technical-design architecture program**:
it takes any engineering system through one 7-verb pipeline —
**spec → structure → design → analyze ⟲ → synthesize → verify → handoff** —
where each engineering field is plugged in as a **manifest-only domain**
(no per-domain code, single generic dispatch · governance `d4`). It is the
**meta-conductor**: a single design studio in which chip, accelerator,
superconductor, spacecraft, and BCI "desks" all live in one building.

Two surfaces sit on top of the same pipeline:
- **Web GUI** (`web/`, Next.js · Cloud Run, `demiurge.dancinlab.org`) — the
  human surface.
- **CLI** (`bin/demiurge` → `cli/`) — the AI-agent + web-bridge surface
  (`demiurge cli <verb>`), installed via the `hx` package manager.

Reusable implementation (stdlib, tools, absorptions) is owned by the sibling
repo **`hexa-lang`** (governance `d3`/`d15`/`d17`); demiurge is a
**typed-interface consumer**, not an absorber. Topical folders here hold
docs / manifests / records only — never duplicated implementation.

```
            demiurge (umbrella · meta-conductor)
   ┌───────────────────────────────────────────────────────┐
   │ spec → structure → design → analyze ⟲ → synthesize     │  7-verb generic pipeline
   │      → verify → handoff                                 │  (manifest-driven, d4)
   └───────────────────────────────────────────────────────┘
   Meta-conductor chain:  materials ──▶ chip ──▶ component
                          (typed seam contracts between passes)

   + cohort domains: cern · antimatter · rtsc · space · energy · brain ·
                     fusion · scope · sscb · mobility · bot · grid · aura · …

   hexa-lang  ── sole SSOT for stdlib / tools / absorptions (consumed only)
```

## Component map

| Path | Role |
|------|------|
| `bin/demiurge` | `hx` package entry point — headless / AI-agent shim dispatching to `cli/` (Swift `DemiurgeCLI` legacy fallback). |
| `cli/` | hexa-native CLI driver (`demiurge_cli.hexa`) — the 7-verb command surface. |
| `web/` | Next.js web GUI (the human surface, deployed to Cloud Run). Domain-plugin UI over the pipeline. |
| `cockpit/` | Swift `DemiurgeCLI` + `DemiurgeCore` library + transient exports/references (macOS SwiftUI cockpit GUI scrapped 2026-05-27). |
| `stdlib/` | Local discover shims; canonical reusable implementation lives in `hexa-lang` (d3). |
| `domains/` | Manifest-only domain maps (`<DOMAIN>.md` snapshot + `<DOMAIN>.log.md` log + `.demi` decks) — one file per pluggable engineering field. |
| `decks/` | Concrete compute input decks (e.g. DFT / QE el-ph cells: `mgb2_pure`, `nb3al`, `h3br_pscan`, …). |
| `sim/` | Simulation drivers / readout watchers (`.hexa`). |
| `QFORGE/` | Quantum-forge compute campaign (DFT electron-phonon, GRID-parallel) workspace. |
| `proposals/` | Absorption / seam / cockpit design RFCs (`rfc_001..012`). |
| `exports/` | Pipeline output records (chip NoC f1/f2, chain seams, per-domain results). |
| `PAPER/`, `PAPERS/` | Generated papers (atlas-atom-gated; one slug per terminal discovery). |
| `.discoveries/` | `/kick` · `/gap` discovery log tapes (`<slug>.tape`). |
| `.verdicts/` | Verify-gate verdict records. |
| `.harness/` | Repo-local harness rule configs (enforcement / keywords / severity). |
| `.harness-engine/` | The `dancinlab/harness` engine, pinned as a git submodule (branch `harness-hardcore`). |
| `archive/` | Historical session notes + superseded tape revisions. |

## Data flow

```
manifest (domains/<DOMAIN>.md · decks/<cell>)
        │
        ▼
  demiurge cli <verb>  ──▶  generic 7-verb dispatch  (d4: no name hardcoding)
        │                         │
        │                  spec → structure → design → analyze ⟲ →
        │                  synthesize → verify → handoff
        ▼                         │
   web/ GUI  ◀── same pipeline ───┘
        │                         │
        ▼                         ▼
  exports/ · .verdicts/ records   atlas atom (hexa verify pass · direct fold)
        │                         │
        └──────────▶  PAPER(S)/<slug>  (gated: terminal verdict + significance)
```

1. **Input** = a domain manifest (`domains/<DOMAIN>.md`) and/or a compute deck
   (`decks/<cell>`). Adding/renaming/removing a variant is manifest-only.
2. **Pipeline** = the generic 7-verb dispatch, driven from `cli/` (CLI surface)
   or `web/` (GUI surface) — both traverse the *same* path.
3. **Verification** = `hexa verify` gates; a passing result is folded directly
   into the atlas atom (`embedded.gen.hexa`, the audit SSOT — no intermediate
   ledger files, governance `d_atlas_as_audit_ssot`).
4. **Output** = records under `exports/` / `.verdicts/`; a *terminal* verified
   discovery becomes a paper under `PAPER(S)/<slug>`.

## Governance & verification

Governance directives live in `CLAUDE.md` / `project.tape` (the `d*` family),
the most load-bearing being:

- **`d3` / `d15` / `d17`** — implementation lives in one canonical home
  (`hexa-lang`); demiurge consumes only.
- **`d4`** — single generic dispatch; instances are manifests, never hardcoded
  names in the generic layer.
- **`d1` / `d5` / `d19`** — drive every non-wet-lab step to completed-form;
  `absorbed=true` ⇔ all non-wet-lab gates PASS.
- **`d17`** — validated decks fire compute campaigns autonomously (no user gate
  on cost-bearing rent); web-GUI deploy stays user-approval-gated (`d_deploy`).
- **`d_parallel_first` / `d_qforge_parallel`** — parallel-first; GRID-parallel
  compute to the walltime floor.

**Verification & harness enforcement** is provided by the `.harness-engine`
submodule (`dancinlab/harness`, branch `harness-hardcore`):

```
bash .harness-engine/bin/harness <cmd>
  docs check     # single-doc discipline: ARCHITECTURE.md (SSOT) + CHANGELOG.md (log)
  docs status    # CLAUDE-MD discipline + quickref/scatter counts
  lint           # staged-L0 + freshness + changelog convergence
  audit          # 6-axis self-scorecard
```

Config: `harness.config.json` (profile `hardcore`; `docs.scopeDirs:[""]` scopes
scatter/quickref discipline to repo-root `.md` only, excluding the research /
domain document corpus; protected branches `main`/`master`).
