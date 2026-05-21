# Generic verb-cell dispatch migration design

## § 0. Purpose

Generic verb-cell dispatch migration design · 46-producer audit + `.demi`
manifest format draft + `sscb.demi` proof-of-concept. Demiurge-side companion
research running concurrently with the hexa-lang scaffold agent
(`stdlib/cockpit/cellrun.hexa` dispatcher). NO commits — research artifact only.

---

## § 1. Inventory snapshot — 46 `*Producer.swift` files

### 1.1 Top-level shape

| dimension                        | count / value                                |
|----------------------------------|----------------------------------------------|
| total `*Producer.swift` files    | **46**                                       |
| `ActionDispatch.swift` switch cases | 42 wired `(verb, domain)` pairs           |
| inline (no `*Producer.swift`)    | `matter+analyze` (MatterAnalyzer), `chip+analyze/verify/synthesize` (ChipAnalyzer + inline) — handled in dispatcher body, not the 46 |
| substrate distribution           | python3: **39** · hexa (`hexa run *.hexa`): **1** (sscb+analyze) · freecadcmd: **1** (component+synthesize via FreeCADBIPV) · scan-only (no spawn): **5** (bio/brain/chem/grid+verify, antimatter+verify uses geant4 but spawn is python wrapper) |
| script SSOT dir                  | `~/core/hexa-lang/stdlib/<domain>/` for **45/46** · `cockpit/scripts/bipv_freecad.py` for **1** (FreeCADBIPV — only remaining D61 violator) |
| output dir convention            | `exports/<domain>/<verb>/<UTC-stamp>/` for **43/46** · variants: `exports/sscb/transient/` (not `analyze/`), `exports/cern/analyze/xsuite/` (sub-keyed), `exports/material/verify/<stamp>/{4 sub-dirs}` (aggregator) |
| record schema                    | each producer has dedicated `<Name>Result` struct (Sendable; `ok`, `lines`, `newRecordID`) — **46/46** uniform |
| line-count distribution          | min 54 · median ~110 · max 619 (ComponentVerifyProducer) · 13,101 total across 46 files + 1,385 dispatcher = **14,486 LoC** under audit |

### 1.2 46-producer table (substrate · script · output · pattern)

Group A — **simple python3-spawn, full pipeline (~50-100 lines, stub-shape)**
13 files · pattern = locate script → spawn `python3 <script> <outDir>` → scan for `*.json` → emit `<Name>Result(ok, lines, recordID)`. Pure D72/D73 cohort cells.

| #  | producer                          | substrate | script (`~/core/hexa-lang/stdlib/`)      | output dir                  | LoC |
|----|-----------------------------------|-----------|------------------------------------------|-----------------------------|-----|
|  1 | AntimatterVerifyProducer          | python3   | `antimatter/geant4_verify.py`            | `antimatter/verify/`        |  55 |
|  2 | BotVerifyProducer                 | python3   | `bot/drake_verify.py`                    | `bot/verify/`               |  54 |
|  3 | CernAnalyzeXsuiteProducer         | python3   | `cern/elegant_tracking.py`               | `cern/analyze/xsuite/`      |  75 |
|  4 | CernSynthProducer                 | python3   | `cern/xsuite_optics.py`                  | `cern/synthesize/`          |  76 |
|  5 | ComponentAnalyzeProducer          | python3   | `component/calculix.py`                  | `component/analyze/`        |  79 |
|  6 | EnergyVerifyProducer              | python3   | `energy/openmc_keff.py`                  | `energy/verify/`            | 107 |
|  7 | FusionVerifyProducer              | python3   | `fusion/openmc_tbr.py`                   | `fusion/verify/`            | 106 |
|  8 | MobilityVerifyProducer            | python3   | `mobility/carla_scenario.py`             | `mobility/verify/`          |  54 |
|  9 | RtscAnalyzeProducer               | python3   | `rtsc/pyfemm_magnetics.py`               | `rtsc/analyze/`             |  78 |
| 10 | RtscVerifyProducer                | python3   | `rtsc/getdp_hts.py`                      | `rtsc/verify/`              |  58 |
| 11 | SpaceVerifyProducer               | python3   | `space/gmat_basilisk.py`                 | `space/verify/`             |  54 |
| 12 | FirmwareAnalyzeProducer           | python3   | `firmware/analyze.py`                    | `firmware/analyze/`         |  57 |
| 13 | FirmwareDesignProducer            | python3   | `firmware/design.py`                     | `firmware/design/`          |  57 |

Group A-cont (firmware 4 more, same stub-shape — D73 16th domain rollout):

| #  | producer                       | substrate | script                          | output                | LoC |
|----|--------------------------------|-----------|---------------------------------|-----------------------|-----|
| 14 | FirmwareSpecifyProducer        | python3   | `firmware/specify.py`           | `firmware/specify/`   |  58 |
| 15 | FirmwareStructureProducer      | python3   | `firmware/structure.py`         | `firmware/structure/` |  57 |
| 16 | FirmwareSynthesizeProducer     | python3   | `firmware/synthesize.py`        | `firmware/synthesize/`|  58 |
| 17 | FirmwareHandoffProducer        | python3   | `firmware/handoff.py`           | `firmware/handoff/`   |  58 |
| 18 | FirmwareVerifyProducer         | python3   | `firmware/verify.py`            | `firmware/verify/`    | 123 |

Group B — **python3-spawn, full record-typing producers (~300-500 lines)**
17 files · pattern = locate script + locate python (homebrew candidates) → spawn → parse `<DOMAIN>_<TOOL>_RESULT <json>` summary line → verify artifacts on disk → decode `meta.json` → build typed record with scope_caveats → write `<recordId>.json`.

| #  | producer                          | substrate | script                                       | output                  | LoC |
|----|-----------------------------------|-----------|----------------------------------------------|-------------------------|-----|
| 19 | AntimatterAnalyzeProducer         | python3   | `antimatter/pdg_lookup.py`                   | `antimatter/analyze/`   | 453 |
| 20 | AuraAnalyzeProducer               | python3   | `aura/aura_mne.py`                           | `aura/analyze/`         | 397 |
| 21 | BotStructureProducer              | python3   | `bot/urdfpy_basics.py`                       | `bot/structure/`        | 371 |
| 22 | BotSynthProducer                  | python3   | `bot/pinocchio_rbd.py`                       | `bot/synthesize/`       | 452 |
| 23 | BrainAnalyzeProducer              | python3   | `brain/lif_brian2.py`                        | `brain/analyze/`        | 374 |
| 24 | CernAnalyzeProducer (pylhe)       | python3   | `cern/lhe_stats.py`                          | `cern/analyze/`         | 413 |
| 25 | CernVerifyProducer                | python3   | `cern/bethe_bloch_stopping.py`               | `cern/verify/`          | 487 |
| 26 | ComponentVerifyProducer           | python3   | `component/gmsh_skfem.py`                    | `component/verify/`     | 619 |
| 27 | EnergyAnalyzeProducer             | python3   | `energy/pvlib_clearsky.py`                   | `energy/analyze/`       | 414 |
| 28 | EnergySynthProducer               | python3   | `energy/pypsa_capacity.py`                   | `energy/synthesize/`    | 550 |
| 29 | FusionAnalyzeProducer             | python3   | `fusion/plasma_metrics.py`                   | `fusion/analyze/`       | 436 |
| 30 | GridStructureProducer             | python3   | `grid/networkx_basics.py`                    | `grid/structure/`       | 370 |
| 31 | MobilityAnalyzeProducer           | python3   | `mobility/road_network.py`                   | `mobility/analyze/`     | 420 |
| 32 | ScopeAnalyzeProducer              | python3   | `scope/scope_poppy.py`                       | `scope/analyze/`        | 382 |
| 33 | ScopeSynthProducer                | python3   | `scope/openmdao_sizing.py`                   | `scope/synthesize/`     | 527 |
| 34 | ScopeVerifyProducer               | python3   | `scope/poppy_psf_verify.py`                  | `scope/verify/`         | 515 |
| 35 | SpaceAnalyzeProducer              | python3   | `space/skyfield_sgp4.py`                     | `space/analyze/`        | 428 |
| 36 | SpaceSynthProducer                | python3   | `space/openmdao_mission.py`                  | `space/synthesize/`     | 423 |
| 37 | SSCBSynthProducer                 | python3   | `sscb/femmt_sweep.py`                        | `sscb/synthesize/`      | 441 |
| 38 | SSCBVerifyProducer                | python3   | `sscb/ngspice_breaking.py`                   | `sscb/verify/`          | 437 |

(Group B is 20 rows — corrected count below.)

Group C — **scan-only / consumer-witness (no spawn)**
5 files · pattern = look at `exports/<domain>/<verb>/<stamp>/*.json` written by foreign producer (anima-physics-bridge for bio, hexa-matter for others) → witness latest → return result with foreign provenance.

| #  | producer            | substrate            | output scanned                           | LoC |
|----|---------------------|----------------------|------------------------------------------|-----|
| 39 | BioVerifyProducer   | anima-physics bridge | `exports/bio/verify/<UTC>Z/anima_*.json` |  98 |
| 40 | BrainVerifyProducer | (foreign drop)       | `exports/brain/verify/`                  | 116 |
| 41 | ChemVerifyProducer  | (foreign drop)       | `exports/chem/verify/`                   |  99 |
| 42 | GridVerifyProducer  | (foreign drop)       | `exports/grid/verify/`                   | 104 |
| 43 | AuraVerifyProducer  | (foreign drop)       | `exports/aura/verify/`                   | 134 |

Group D — **idiosyncratic / non-conforming (5 producers)**

| #  | producer                  | shape                                                                  | LoC |
|----|---------------------------|------------------------------------------------------------------------|-----|
| 44 | SSCBProducer (sscb+analyze) | **hexa-substrate** (`hexa run sscb/ngspice.hexa <outDir>`) — only non-python spawn in the 46. Locate `ngspice` binary AND locate `.hexa` script (two-step preflight). Output dir is `sscb/transient/` (not `sscb/analyze/`). | 353 |
| 45 | FreeCADBIPVProducer       | **freecadcmd substrate** (only one) · script lives in `cockpit/scripts/bipv_freecad.py` (only D61 violator: not in hexa-lang/stdlib) · emits multi-artifact: `.step` + `.brep` + `.stl` + `.meta.json` (only non-JSON-primary output) · invoked indirectly via ComponentEmitter inside dispatcher's `runComponentSynthesize()` — not a direct producer. | 310 |
| 46 | MaterialVerifyProducer    | **aggregator** — spawns 4 python sub-producers (`sim_adapter`, `cube_producer`, `hexa_rtsc_crosslink`, `mp_query`) under one `<stamp>/`. Per-sub-producer wall-time budget (60s SIGTERM for cube). Returns `[String]` of record IDs, not a single one. Skips `mp_query` when `MP_API_KEY` env-var absent. | 329 |

Two more idiosyncratic patterns inside the python3-Group-B:
- **SSCBSynthProducer**: dual-substrate (femmt-or-analytic-fallback) — script self-degrades; producer label flips between `femmt@<v>` and `analytic_fallback (femmt unavailable)`.
- **CernAnalyzeProducer + CernAnalyzeXsuiteProducer**: same `(verb, domain) = (.analyze, "cern")` cell with **two registered variants** (pylhe + xsuite-tracking), selected via `ProducerRegistry`. Dispatcher early-returns from registry before switch hits.

**Recount**: 18 (Group A) + 20 (Group B) + 5 (Group C) + 3 (Group D = SSCB analyze, FreeCAD, MaterialVerify) = 46. ✓

---

## § 2. Common-shape extraction

### 2.1 Fits-simple-pattern percentages

- **single python3 spawn → JSON record emit** (Groups A + B, minus dual-substrate sweetspot): **36 / 46 = 78 %**
- **scan-only (no spawn)**: 5 / 46 = 11 %
- **fallback-substrate**: 1 / 46 (SSCBSynth femmt→analytic; **NOT** RtscAnalyze contrary to expectation — that one's a pure single-script that internally degrades inside Python)
- **multi-stage spawn**: 1 / 46 (MaterialVerify aggregator with 4 sub-producers)
- **non-JSON artifacts**: 1 / 46 (FreeCADBIPV: STEP/BREP/STL + meta.json — note STL is mesh, STEP/BREP are CAD)
- **non-python substrate**: 2 / 46 (SSCB+analyze = hexa, FreeCAD = freecadcmd)

### 2.2 Top idiosyncrats (priority to flag during dispatcher port)

1. **MaterialVerifyProducer** (aggregator) — 1→N record IDs; per-sub-producer timeout; env-var-gated skip (`MP_API_KEY`). Generic dispatcher needs `composite_of: [sub1, sub2, ...]` shape OR remain Swift-side only.
2. **FreeCADBIPVProducer** — only non-python, non-hexa substrate; only multi-artifact non-JSON output; only D61-violator script location (`cockpit/scripts/` not `hexa-lang/stdlib/`). Honest porting requires script-relocate + producer-shape decision.
3. **SSCBProducer (analyze)** — only `hexa run` invocation. Two-step preflight (locate `ngspice` AND locate `.hexa`). Output dir is `sscb/transient/` (not `sscb/analyze/`). Sets template for hexa-native production-substrate path.
4. **CernAnalyze variants (pylhe + xsuite)** — one (verb,domain) pair with 2 producer variants registered via `ProducerRegistry` selectable by `--producer <name>` flag. Dispatcher needs `variant:` keyword.
5. **SSCBSynthProducer** — dual-substrate via python-side self-degradation (femmt OR analytic). Producer label flips honestly. Generic dispatcher fine; honesty constraint = surface `solver:` field from substrate, not infer.

### 2.3 Shared-substructure that the generic dispatcher SHOULD absorb

- locate-python-3 (homebrew candidates → `which python3` fallback): **39 producers duplicate this** — generic should provide once.
- ISO8601 stamp + replace `:` with `-` + `mkdir -p exports/<d>/<v>/<stamp>/`: **44 producers duplicate** — generic provides.
- `proc.executableURL = "/usr/bin/env"` + `arguments = ["python3", script, outDir.path]` + Pipe capture + waitUntilExit + exit-code-check: **39 producers identical** — generic provides.
- Scan `<outDir>/*.json` with optional prefix filter + return basename(s) as recordID: **18 producers duplicate** (the simple ones; Group B's full-typed records have their own scan-meta path).
- `GATE_OPEN / absorbed=false` honesty banner appended to `lines`: **44 producers duplicate** — generic provides as default, override per cell.

---

## § 3. `.demi` manifest format spec (draft v0)

### 3.1 File shape

**One file per domain** holding multiple cells (verbs as top-level sections). Rationale: 7 verbs × ~10-20 lines = ~80-120 lines per file; matches existing `domains/<domain>.md` ergonomic shape; cross-cell shared keys (e.g. domain-wide python-version pin) live once at top.

```
# <domain>.demi — verb-cell manifest for <domain>
# Generic dispatcher: stdlib/cockpit/cellrun.hexa
# Demiurge witness: ActionDispatch.runGenericCell(domain, verb)

domain: <domain>
shared:
  python_candidates: [...]   # optional — override default

[<verb>]
  ...keys...

[<verb>]
  ...keys...
```

(Format: simple key-value with `[section]` headers, INI-ish; or TOML if hexa-lang has a TOML parser. Hexa-native preference: minimal — flat `domain.verb.key = value` lines also acceptable.)

### 3.2 Required keys (per cell)

| key            | type   | description                                                              |
|----------------|--------|--------------------------------------------------------------------------|
| `substrate`    | enum   | `python3` / `hexa` / `freecadcmd` / `scan_only` / `composite`            |
| `script`       | string | path relative to `~/core/hexa-lang/stdlib/` (e.g. `sscb/ngspice.hexa`); absent for `scan_only` |
| `record_kind`  | string | Codable struct name on Swift side (e.g. `SSCBRecord`); also used as substrate's `<DOMAIN>_<TOOL>_RESULT <json>` marker prefix derivation |
| `output_dir`   | string | path relative to `exports/` (e.g. `sscb/transient`); `<stamp>/` appended automatically |

### 3.3 Optional keys

| key                    | type     | default       | purpose                                              |
|------------------------|----------|---------------|------------------------------------------------------|
| `required_deps`        | [string] | []            | binary/import preflight (`ngspice`, `freecadcmd`, py imports `["numpy","femmt?"]`) |
| `gate_default`         | enum     | `GATE_OPEN`   | `GATE_OPEN` / `GATE_CLOSED` / `GATE_PARTIAL`         |
| `absorbed_default`     | bool     | `false`       | g3 — almost always false                             |
| `scope_caveats`        | [string] | []            | append to record (substrate may add more)            |
| `fallback`             | object   | nil           | `{ when: "<dep>_unavailable", producer_label: "analytic_fallback (<dep> unavailable)" }` |
| `post_process`         | string   | nil           | hexa-lang function name to call on `meta.json` before recording (e.g. for SSCBSynth's candidate ranking) |
| `artifacts_expected`   | [string] | [`meta`]      | extension list to verify on disk before declaring ok (e.g. `["netlist","log","raw","meta"]`) |
| `marker_prefix`        | string   | auto          | summary-line marker (`SSCB_NGSPICE_RESULT`); auto from `record_kind` if absent |
| `summary_stream`       | enum     | `stderr`      | which stream the marker line goes on (`stdout` / `stderr` / `merged`) |
| `wall_budget_s`        | int      | nil           | SIGTERM the spawned process after N seconds (MaterialVerify cube=60) |
| `env_gates`            | [string] | []            | env-var names required (e.g. `["MP_API_KEY"]`); skip-with-honest-record if absent |
| `variants`             | [object] | nil           | for multi-producer cells (CernAnalyze) — each variant has its own `script` + `record_kind` |
| `composite_of`         | [string] | nil           | for aggregator cells (MaterialVerify) — list of sub-cell IDs |

### 3.4 Multi-cell file shape

**Decision: one `.demi` per domain (multi-cell).** Top-level `domain:` key + repeated `[verb]` sections. Avoids 46×N files (would be 7×18 = 126 files for full Tier-1). Keeps domain-wide shared context (e.g. citation list shared across analyze + synthesize + verify) co-located.

**Tradeoff**: when a single cell has heavy parametrization (BotSynth has 50+ lines of caveats + citations + meta-schema), the per-domain file gets long. Mitigation: extract caveats/citations to `shared.caveats:` blocks referenced by `caveats_ref: shared.foo`.

### 3.5 Extensibility — Tier-2 keys

The format MUST allow forward-compatible additions. Two patterns:

1. **Reserved namespace `x_<vendor>_<key>`** — anything starting with `x_` is producer-specific extension (cf. JSON Schema convention). Dispatcher passes through unchanged.
2. **`tier2:` block** — sub-table for in-flight keys that haven't landed in v1 spec yet. Dispatcher consults `cellrun.hexa`'s `_tier2_handler(key)` registry; unknown keys log-and-skip rather than fail.

Anticipated Tier-2 additions:
- `pre_check`: hexa function name run before spawn (e.g. `ngspice_version_ge_42`)
- `post_emit_hook`: hexa function name run after record write (e.g. `notify_kosmos_anchor`)
- `cross_domain_dep`: list of `(domain, verb)` cell IDs this cell consumes (e.g. `sscb+synthesize` consumes `sscb+analyze` for geometry_id parity)
- `cache_key`: deterministic-fingerprint key for skip-if-already-done semantics
- `provenance.ssot_branch`: commit-ish of substrate when record was produced (already in some meta.json — formalize)

---

## § 4. sscb.demi proof-of-concept

Full 7-verb manifest for the sscb domain. Wired: analyze (ngspice transient), synthesize (femmt+fallback), verify (ngspice breaking). Unwired: specify, structure, design, handoff (firmware-stub-style scaffolds — honest-skip default).

```ini
# sscb.demi — verb-cell manifest for the sscb (Solid-State Circuit Breaker) domain
# SSOT scripts in ~/core/hexa-lang/stdlib/sscb/
# Generic dispatcher: ~/core/hexa-lang/stdlib/cockpit/cellrun.hexa
# Demiurge witness: ActionDispatch.runGenericCell("sscb", verb)

domain: sscb
shared:
  python_candidates:
    - /opt/homebrew/bin/python3.13
    - /opt/homebrew/bin/python3.12
    - /opt/homebrew/bin/python3
    - /usr/local/bin/python3
    - /usr/bin/python3
  citations:
    - "DEVSIM JOSS doi:10.21105/joss.03898 (Sanchez 2022) — TCAD anchor"
    - "FEMMT (upb-lea/FEM_Magnetics_Toolbox, GPL-3) — cited synthesis instrument"
    - "OpenMagnetics catalogue — analytic A_L fallback reference"
    - "Hagedorn, Magnetic Components §7.4 (gapped-core reluctance)"
  domain_caveats:
    - "HEXA-SSCB mk1 topology only — Wolfspeed-class .lib absorption + bench-validated load + DEVSIM TCAD coupling 不在 (D17/g3)."

# --- WIRED: analyze (κ-34 / D55 first cohort producer) -----------------------
[analyze]
substrate     = hexa
script        = sscb/ngspice.hexa
record_kind   = SSCBRecord
output_dir    = sscb/transient        # historically /transient/ not /analyze/
required_deps = [ngspice]
artifacts_expected = [netlist, log, raw, meta]
marker_prefix = SSCB_NGSPICE_RESULT
summary_stream = merged
gate_default     = GATE_OPEN
absorbed_default = false
scope_caveats:
  - "ngspice transient — generic Ron/Roff SiC switch, datasheet 흡수 아님 (g3)."
  - "snubber (100 nF · 5 Ω) generic-not-engineered — interrupt_ratio ~0.35 at 1.5 µs not buggy, honest gap."
  - "measurement_gate = GATE_OPEN 영구 (단일점 sim, device model 미흡수). UL 489I 별도 게이트."

# --- WIRED: synthesize (κ-N ROI rank 1 / dual-substrate) ---------------------
[synthesize]
substrate     = python3
script        = sscb/femmt_sweep.py
record_kind   = SSCBSynthRecord
output_dir    = sscb/synthesize
required_deps = [python3, numpy]      # femmt OPTIONAL — fallback path
artifacts_expected = [csv, meta]
marker_prefix = SSCB_FEMMT_RESULT
summary_stream = merged
gate_default     = GATE_OPEN
absorbed_default = false
fallback:
  when           = femmt_unavailable
  producer_label = "analytic_fallback (femmt unavailable)"
scope_caveats:
  - "FEMMT 또는 analytic-fallback (gapped-core reluctance, Hagedorn §7.4)."
  - "B-H curve = N87 textbook ref. lot-drift / DC-bias permeability 0 종 적용."
  - "Full GetDP/ONELAB FEM solve NOT invoked — analytic estimate = reproducibility anchor."
  - "absorbed=true 4종 동시 필요: datasheet B-H + bench winding-loss + thermal coupling + measured stray-inductance."
citations_ref: shared.citations

# --- WIRED: verify (κ-N ROI rank 2 / breaking-capacity bolted-fault) ---------
[verify]
substrate     = python3
script        = sscb/ngspice_breaking.py
record_kind   = SSCBVerifyRecord
output_dir    = sscb/verify
required_deps = [python3]              # script uses only stdlib + ngspice
artifacts_expected = [netlist, log, data, meta]
marker_prefix = SSCB_BREAKING_RESULT
summary_stream = merged
gate_default     = GATE_OPEN
absorbed_default = false
scope_caveats:
  - "ngspice bolted-fault — generic Ron/Roff SiC, R_fault = 0.01 Ω generic short."
  - "OpenFOAM thermal-margin INTENTIONALLY skipped (heavy → handoff note); no silent thermal claim."
  - "UL 489I = accredited-lab type-test, NOT SPICE. Verdict = first honest witness, NOT regulatory verify."
  - "Stage 4 absorbed=true requires C3M0021120K .lib + bench load + DEVSIM + measured stray-L + OpenFOAM + UL 489I — none here."

# --- UNWIRED: specify (template scaffold per firmware-stub pattern) ----------
[specify]
substrate     = python3
script        = sscb/specify.py       # NOT YET PRESENT — honest-skip
record_kind   = SSCBSpecifyRecord
output_dir    = sscb/specify
gate_default     = GATE_OPEN
absorbed_default = false
unwired       = true                  # tier-2 key — substrate missing OK; emit honest-gap message
honest_skip_message: "sscb + specify scaffold pending — requirements.json template producer 미작성. domains/sscb.md §1 (HEXA-SSCB mk1 spec) 가 SSOT 후보 — Python wrapper 가 그것을 record JSON 으로 변환하면 됨 (~50 line firmware-stub-style)."

# --- UNWIRED: structure --------------------------------------------------------
[structure]
substrate     = python3
script        = sscb/structure.py
record_kind   = SSCBStructureRecord
output_dir    = sscb/structure
gate_default     = GATE_OPEN
absorbed_default = false
unwired       = true
honest_skip_message: "sscb + structure pending — BOM tree (SiC switch · gate driver · snubber · busbar · enclosure) producer 미작성. networkx component-graph가 candidate (GridStructure 패턴 reuse)."

# --- UNWIRED: design ----------------------------------------------------------
[design]
substrate     = python3
script        = sscb/design.py
record_kind   = SSCBDesignRecord
output_dir    = sscb/design
gate_default     = GATE_OPEN
absorbed_default = false
unwired       = true
honest_skip_message: "sscb + design pending — 게이트 드라이버 sizing + busbar layout + thermal margin tradeoff producer 미작성. Synth (femmt magnetics) + Verify (breaking) 사이의 design-space exploration loop가 자연스러운 위치."

# --- UNWIRED: handoff ---------------------------------------------------------
[handoff]
substrate     = python3
script        = sscb/handoff.py
record_kind   = SSCBHandoffRecord
output_dir    = sscb/handoff
gate_default     = GATE_OPEN
absorbed_default = false
unwired       = true
honest_skip_message: "sscb + handoff pending — bench-test plan (bolted-fault rig instrumentation, scope channels, UL 489I lab booking checklist) producer 미작성. firmware/handoff.py 패턴 reuse."
```

(File length: 121 lines including comments and blank-line separators — at the
upper end of the §C estimate. Could be tightened by extracting honest_skip_message
templates to shared but keeping inline preserves the per-cell narrative for the
human reviewer.)

---

## § 5. Migration cost estimate

### 5.1 Per-producer cost (build dispatcher exists)

| pattern               | count | per-producer port cost | total       |
|-----------------------|-------|------------------------|-------------|
| Group A stub (~50 LoC)| 18    | 3-5 min (mechanical)   |  60-90 min  |
| Group B full (~400)   | 20    | 10-15 min (caveats + record_kind mapping is the slow part) | 200-300 min |
| Group C scan-only     |  5    | 5-8 min (scan_only substrate; new dispatcher path) |  25-40 min  |
| Group D idiosyncratic |  3    | 30-60 min each         |  90-180 min |
| **Total**             | 46    | min 6 · median 12 · max 60 | **6.3 - 10.2 h** |

Assumes: dispatcher (`cellrun.hexa`) already absorbs `locate_python` + `spawn_python` + `mkdir_stamp` + `scan_record_ids` + `apply_honest_banner`. If those are still ad-hoc per-producer, double the cost.

Session-time bucket: **2-3 sessions of focused work** (one for Groups A+C — the easy 23, one for Group B — the typed-record 20, one for Group D + reconciliation with hexa-lang scaffold). With reviewer/PR overhead: 4-6 sessions.

### 5.2 What the cost is NOT capturing

- **Codable record-struct stays Swift-side** — even after dispatcher generification, each domain still owns its `<Name>Record` Swift type for compile-time-safe consumption. The cost line above assumes those structs are untouched; if the migration also flattens them to a generic `DemiRecord<T: Decodable>`, add another 5-15 min per domain.
- **XCTest invariants** — there are XCTest harnesses per producer (verify spawn returns ok=true when substrate present). Generic dispatcher needs new XCTests that drive `.demi` files end-to-end. Estimate: ~2 h test scaffold + ~1 h per idiosyncratic case = ~5 h tests.
- **D67 hexa-native migration cross-cut** — SSCBProducer was migrated from `cockpit/scripts/sscb_ngspice.py` to `hexa-lang/stdlib/sscb/ngspice.hexa` per κ-41. If the dispatcher migration triggers further `.py → .hexa` ports, that's a separate cost line entirely (estimate: 4-8 h per script).

---

## § 6. Risk + non-trivial migrations

### 6.1 Top-5 risk producers (most-careful port)

1. **MaterialVerifyProducer** (Group D · 329 LoC) — composite/aggregator shape is the structural test for the `.demi` format. If the dispatcher can't express `composite_of: [sub1, sub2, sub3, sub4]` with per-sub `wall_budget_s` + `env_gates`, this producer either stays Swift-side or forces format extension. **Recommend: stay Swift-side initially**; iterate format after the 43 simpler producers land.
2. **FreeCADBIPVProducer** (Group D · 310 LoC) — three blockers in one: (a) non-python/non-hexa substrate; (b) D61-violator script location (must relocate to `hexa-lang/stdlib/freecad/bipv.py`); (c) multi-artifact non-JSON output (STEP/BREP/STL). Generic format needs `substrate=freecadcmd` + `artifacts_expected=[step, brep, stl, meta]` extensions.
3. **CernAnalyze (two variants)** — registered via `ProducerRegistry` with selectable variants. The `.demi` `variants:` block design is untested. Risk: format ambiguity on default-variant selection rule.
4. **SSCBProducer (analyze)** — only `hexa run` invocation. The substrate=`hexa` path needs hexa-vs-python dispatch convergence inside `cellrun.hexa`. Trivial in principle, hasn't been exercised at scale yet.
5. **SSCBSynthProducer fallback** — dual-substrate (femmt OR analytic). Honest record requires producer-label flip surfaced from substrate's `solver:` meta field. Generic dispatcher must pass through this dynamically — can't be static `.demi` config.

### 6.2 Less-risky-but-easy-to-mis-port

- **Record-schema reuse** — each Group B producer has a per-cell `<Name>ProducerMeta: Decodable` private struct with snake_case → camelCase remapping. Generic dispatcher CAN'T parse arbitrary meta.json into typed struct without per-domain Swift code. **The dispatcher cell handles the Process spawn + artifact verification + record write; the typed-record build stays per-domain Swift.** Be explicit in the `.demi` README that `record_kind:` is a Swift symbol, not a generic schema.
- **Stamp-dir convention drift** — historically `sscb/transient/` (analyze) vs `sscb/verify/` (verify) — output_dir is NOT a mechanical `<domain>/<verb>/` rule. Each producer's existing convention must be preserved (else existing record-loaders break).
- **Honesty banner drift** — every producer ends with a 1-3 line "GATE_OPEN · absorbed=false · why" message. The generic dispatcher should provide a default but each cell has earned per-cell phrasing that the user values. Strong recommend: per-cell `scope_caveats:` stays opt-in-override.

### 6.3 Dep version constraints (unresolved)

None of the 46 producers PIN dependency versions in their `required_deps` — they accept any homebrew python3 + opportunistically check version inside the script. The `.demi` format reserves `required_deps: [name]` (no version) for v1; version-pinning is a Tier-2 extension.

---

## § 7. Open questions for user

1. **One `.demi` per domain vs one per cell?** — This note assumes one-per-domain (sscb.demi has all 7 verbs). Rationale: shared caveats/citations colocate, file count stays ≤18. Counter: cell-level git blame is muddier. **Recommend per-domain unless sibling scaffold agent goes the other way.**
2. **`<Name>Record` Swift types — keep per-cell, or generify to `DemiRecord<T>`?** — Keeping them per-cell preserves compile-time safety on consumers (cockpit chat, CLI, XCTest invariants). Generifying saves ~46 Codable structs but loses type-safety. **Recommend: keep per-cell; `.demi` `record_kind:` is just a Swift symbol pointer.**
3. **MaterialVerify (composite)** — port at all, or leave Swift-side? Format extension cost is non-trivial; only 1/46 needs it. **Recommend: leave Swift-side, revisit in Tier-2.**
4. **FreeCADBIPV** — the D61-violator script location should be fixed at port time. Move `cockpit/scripts/bipv_freecad.py` → `~/core/hexa-lang/stdlib/freecad/bipv.py` as part of the migration, or as a precondition?
5. **CernAnalyze variants** — port time is the right moment to decide if the `.demi` format formalizes multi-variant cells, or if `ProducerRegistry` stays Swift-side as the variant-selector layer above the generic dispatcher.
6. **Unwired cells (28 of 46×7=126 possible cells are wired; 98 unwired)** — does the `.demi` format describe ONLY wired cells, or also list unwired-with-honest-skip-message (as sscb.demi PoC does)? Listing all 7 keeps the manifest a complete per-domain spec; listing only wired keeps the file shorter. **Recommend: list all 7 with `unwired = true` for empties** — preserves the "stage gates" narrative.
7. **`.demi` format precedence** — if the sibling scaffold agent's draft diverges, whose version wins? Suggested rule: dispatcher-side (hexa-lang `cellrun.hexa`) is SSOT for parser behavior; demiurge-side (this note) is SSOT for which cells need which keys. Reconcile via Tier-1 sync at PR time.
8. **D74 `ProducerRegistry` interaction** — registry-based variants (CernAnalyze pylhe + xsuite) early-return BEFORE the switch hits. Generic dispatcher must respect that ordering, or fold variant selection into `.demi`.
9. **Honest-skip vs hard-skip for unwired** — current firmware-stub pattern returns `ok = false` with a "script not found" message. The unwired-cell sscb.demi rows above use `unwired = true` to surface a richer "scaffold pending — here's what would go here" message. Format question: is `unwired = true` formalized, or just convention?

---

*End — research note for κ-cycle generic-cellrun migration · paired with concurrent
hexa-lang scaffold agent · NO commit, untracked, untracked-research-artifact
pattern (per memory: `.tape` format not actively enforced; XCTest is the real gate).*
