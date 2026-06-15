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
| `QFORGE/` | Quantum-forge compute campaign (DFT electron-phonon, GRID-parallel) workspace. Engine-status SSOT = `QFORGE/QFORGE.md` §⭐. Honest standing (2026-06-15): QE = production reference, QFORGE migration gate HELD — the hybrid QE\|g\|²→QFORGE L3 assembler is gate-grade (CaH6 rel-ε 1.65e-7) and now demonstrated end-to-end on real-material QE el-ph (YH6: per-mode λ reproduced to rel-ε~1e-5), while from-scratch screened-vertex + real-cell magnetism remain QFORGE-gated. **Production prerequisite (2026-06-15 fleet diagnostic, c1):** high-P hydride el-ph runs MUST pass a dynamical-stability pre-check (tight vc-relax at target P → `matdyn asr='crystal'` → confirm 0 imaginary phonon modes) BEFORE the el-ph production run — YH6/MgH6 DFPT fired on under-relaxed cells (41/34 hard imaginary modes) yielded no physical Tc. |
| `proposals/` | Absorption / seam / cockpit design RFCs (`rfc_001..012`). |
| `exports/` | Pipeline output records (chip NoC f1/f2, chain seams, per-domain results). |
| `exports/SENOLYX/round13-abfe-allcand/` | Reusable, hardened ABFE compute harness (vast GPU fan-out: rent→copy-verify→fire_cell→harvest→watch→recover/reap). SSOT = its `README.md`; hardened against 10 live-campaign failure modes (bound-pose default · harvest stdin · copy-verify · retry-resume-only · ssh-blip alive-gate · orphan reap · single launch entry `fire_cell.sh` · watcher auto re-arm · harvest persist-merge · auto-down reap on completion). First candidate verification (2026-06-16, preliminary): MCL-1/S63845 ABFE −14.18±1.67 (n=2/3) ≈ exp −13 (|err|~1.2) — drug-like ligand binding computationally confirmed, unlike the FF-unreliable HSP90 macrocycle (R12 close-negative). |
| `PAPER/`, `PAPERS/` | Generated papers (atlas-atom-gated; one slug per terminal discovery). |
| `.discoveries/` | `/kick` · `/gap` discovery log tapes (`<slug>.tape`). Active RTSC frontier (2026-06-16): no-cooling flat-band-at-E_F track — **LaRu3Si2 🟢 GATE PASS** (campaign-first: measured ΔE=−0.055 eV AND m=0.00 μB — beats all 3 failure modes simultaneously; real ambient Tc=7K). This is the flat-band-at-E_F DESIGN gate (not room-temp; 7K) — next = DFPT λ/Tc promotion. Closed: MoSn 🔴 (ΔE=−2.38), CoSn/CsV3Sb5/RbOs2O6 🔴/🟠. CoSn rigid-doping 🔴 CLOSED both dials (electron −0.445→−0.585 AND hole −0.445→−0.544 push the kagome flat band DEEPER away from E_F; hole doping also wakes magnetism m→0.63) — the "dope CoSn to E_F" axis is exhausted. LaRu3Si2 DFPT λ/Tc q=3 in flight. |
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
