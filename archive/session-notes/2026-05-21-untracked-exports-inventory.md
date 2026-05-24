# Untracked `exports/` inventory · post-f4defee

## § 0. Purpose

Post-`f4defee` inventory of what's still untracked in `exports/` · for batch-commit OR `.gitignore` decision in a future cycle. READ-ONLY characterization · no files modified, no commits, no `git add`.

Snapshot: `git status` at 2026-05-21 evening · main · 13 untracked top-level `exports/<domain>/` subdomains (40 untracked dir entries when timestamped subfolders are counted individually).

---

## § 1. Inventory table

Per top-level domain — each row enumerates the untracked timestamp subdirs plus a sample provenance pulled from a verify-record JSON inside.

| Domain      | Verb(s)           | Untracked dirs | File count (approx) | Earliest → Latest stamp     | Sample provenance (axis · producer · gate) |
|-------------|-------------------|----------------|---------------------|-----------------------------|---------------------------------------------|
| antimatter  | verify            | 7              | 14 files (~60K)     | 2026-05-21T06-26 → 09-13    | `geant4_antiproton_stopping` · `geant4@absent` · GATE_OPEN, install-gated skip, cites PDG RPP 2024 §34 |
| aura        | verify            | 1              | 4 files (~48K, incl. `.fif`) | 2026-05-21T08-33      | `demiurge:aura:quality-record` · `anima-aura-stub-bridge` · GATE_OPEN, "anima-physics has NO aura substrate", stub |
| bio         | verify            | 1              | 1 file (~4K)        | 2026-05-21T08-33            | `demiurge:bio:synapse-plasticity-record` · `anima-bio-hippocampus-memristor-bridge` · GATE_OPEN, hexa-lang reference sim |
| bot         | verify            | 7              | 10 files (~40K)     | 2026-05-21T06-27 → 09-14    | `drake_lyapunov_demo` · `pydrake@absent` · GATE_OPEN, install-gated skip |
| brain       | verify            | 1              | 1 file (~4K)        | 2026-05-21T08-22            | `demiurge:brain:kuramoto-record` · `anima-kuramoto-loihi-akida-bridge` · GATE_OPEN, numpy reference (not silicon spike) |
| cern        | stopping          | 7              | 47 files (~480K incl. `.root`) | 2026-05-21T06-27 → 09-14 | `demiurge:cern:stopping-power-record` · Geant4 antiproton on Al/Cu/W/Pb · csv+root+meta artifacts |
| chem        | verify            | 1              | 1 file (~4K)        | 2026-05-21T08-33            | `demiurge:chem:entropy-record` · `anima-chem-langevin-thermodynamic-bridge` · GATE_OPEN, double-well Langevin, "no real molecular species" |
| component   | verify            | 10             | 63 files (~12M incl. mesh `.msh`/`.stl`) | 2026-05-21T06-24 → 09-29 | `demiurge:component:gmsh-skfem-verify-record` · gmsh 4.15.2 + skfem · `die_proxy_box_v1` (Si die proxy) + `upduino_cover_lvl*` |
| energy      | verify            | 7              | 14 files (~50K, but `pv/` is older tracked 432K csv) | 2026-05-21T03-07 → 09-14 | `openmc_keff_criticality` · `openmc@absent` · GATE_OPEN, install-gated, hexa-native parity 21/21 PASS @1e-13 |
| firmware    | verify            | 10             | 21 files (~84K)     | 2026-05-21T06-24 → 09-10    | `qemu_mps2_an385_boot` · `firmware_verify@absent` · GATE_OPEN, smoke-boot (≤2s), qemu missing |
| fusion      | verify (+plasma)  | 1+ (plasma tracked) | 17 files (~68K)  | 2026-05-21T09-10 → 09-14    | `openmc_tbr_neutronics` · `openmc@absent` · GATE_OPEN, kernel_reuse `mc_transport/` (2nd consumer) |
| grid        | verify            | 1              | 7 files (3 timestamped runs) | 2026-05-21T08-33      | `demiurge:grid:resilience-record` · `anima-grid-kuramoto-powergrid-bridge` · GATE_OPEN, Filatrella 2008 mapping |
| mobility    | verify            | 1+             | 13 files (~60K)     | 2026-05-21T06-29 → 09-12    | `carla_scenariorunner` · `carla@macos-blocked` · GATE_OPEN, platform-gated hard-block |

Total: ~213 untracked files across 13 top-level domains, ~13MB on disk (dominated by `component/` mesh files: 4 ×`.msh` between 380K–4.6M).

---

## § 2. Pattern analysis

### 2.1 Three distinct file families

**Family A · "16-domain hardware-verify cycle" (anima-* bridges)** · 6 subdirs at exactly `2026-05-21T08-33-18Z` (aura, bio, chem, grid) or `T08-22-26Z` (brain). Each is a *single* JSON written by an `anima-*-bridge` producer with `interface: demiurge:<domain>:<kind>-record` + `provenance.atlas_cite_block` citing `demiurge_hw_verify_2026_05_21 §2.2 (<domain> no-producer gap)`. Pattern: domain producer-gap fill via anima-physics substrate bridge. These are *new schemas* (not in prior tracked exports/).

**Family B · "install-gated verify spam"** · ~7 timestamped runs per domain dated `2026-05-21T06–09Z`, all hitting the install-gated cohort (antimatter geant4, bot drake, energy openmc, fusion openmc, firmware qemu, mobility carla, plus cern/component which DO produce real artifacts). The `T06-27`, `T09-04`, `T09-05`, `T09-07`, `T09-10`, `T09-12`, `T09-14` cluster looks like a single sweep (or two — `06` first then `09-04..09-14` second) running `cockpit verify --all-domains` and emitting per-run JSON whether the producer is present or not.

**Family C · "real-artifact verify (cern stopping + component gmsh/skfem)"** · same timestamp cluster as Family B but with non-trivial substrate artifacts (`.root`, `.msh`, `.csv` 2–5 MB). cern/stopping is the κ-68 G29 NREL-MIDC-equivalent for antimatter substrate (D72 mc_transport kernel · 4th consumer). component/verify is the BIPV gmsh+skfem real-physics path producing `die_proxy_box_v1` meshes.

### 2.2 Producer-side trace

Cross-referencing `git status` shows 5 new untracked producers under `cockpit/Sources/DemiurgeCore/Loaders/`:

- `AuraVerifyProducer.swift`
- `BioVerifyProducer.swift`
- `BrainVerifyProducer.swift`
- `ChemVerifyProducer.swift`
- `GridVerifyProducer.swift`

Plus modified `ActionDispatch.swift` + `ProducerRegistry.swift`. This **directly explains Family A**: the producers that emitted those 5 single-JSON records are themselves untracked. The exports + producers are a coherent pair — committing the exports without the producers would orphan them, and vice versa.

### 2.3 Not RTSC / not G29-MIDC / not material-falsifier

- No `exports/rtsc/verify/` in this untracked set (RTSC working tree is per "unstaged RTSC working tree" caveat).
- No `exports/energy/verify/2026-05-21T03-07-39Z/energy_verify_20260520T190739Z_nrel_midc_pyranometer.json` … wait, there IS one (G29-MIDC ride-along · landed in `80a1664` but a stray re-run timestamp survives untracked). Worth a closer look in commit cycle.
- No `material_falsifier` / claim-only RT-SC paths — that family landed clean in `f4defee` (the original `exports/falsifier/<historic-claim>_v1/` directory was deleted 2026-05-22 in the aggressive scrub pass — see `inbox/notes/2026-05-22-lk99-final-scrub.md`).

### 2.4 Naming convention drift

Already-tracked timestamp format: `20260520T083856Z` (compact). All untracked timestamps: `2026-05-21T06-26-18Z` (ISO with dashes). This is a *producer-emit format change* somewhere on 2026-05-21 — possibly in the new dispatch path. Worth verifying that the new format is intentional before mass-committing (otherwise we lock-in inconsistency).

---

## § 3. Recommendation per subdir

| Domain                  | Recommendation | ARCH narrative / rationale |
|-------------------------|----------------|---------------------------|
| aura/verify (08-33)     | **commit** with `AuraVerifyProducer.swift` · ARCH §2 16-domain producer-gap fill (anima-bridge family) |
| bio/verify (08-33)      | **commit** with `BioVerifyProducer.swift` · same anima-bridge family |
| brain/verify (08-22)    | **commit** with `BrainVerifyProducer.swift` · same |
| chem/verify (08-33)     | **commit** with `ChemVerifyProducer.swift` · same |
| grid/verify (08-33)     | **commit** with `GridVerifyProducer.swift` · same |
| cern/stopping (×7 runs) | **clarify** · is this a "keep all 7 runs" (history-of-substrate) or "keep latest only" decision? Prior tracked pattern (5 dirs in `git ls-files exports/cern/stopping/`) suggests we DO commit per-run. Recommend committing the latest 1–2 (e.g. `T09-12-10Z` + `T09-14-02Z`) and `.gitignore`-ing the rest with `exports/*/verify/*/` per-run pattern. |
| component/verify (×10)  | **clarify + lean gitignore** · 12M of `.msh`/`.stl` mesh per timestamped run × 10 = bloat risk. The mesh files reproduce deterministically from gmsh 4.15.2 + the same geometry input. Recommend `.gitignore exports/component/verify/2026-05-*/` and commit ONLY the verify-record JSONs (or the latest run only). |
| antimatter/verify (×7)  | **gitignore most + commit 1–2 latest** · install-gated GATE_OPEN records carry no measurement payload — they're "we tried, geant4 absent" sentinels. Recommend keep the latest run as the install-gated witness, ignore the rest. |
| bot/verify (×7)         | **gitignore most + commit 1 latest** · same logic (pydrake@absent) |
| firmware/verify (×10)   | **gitignore most + commit 1 latest** · same logic (qemu missing) |
| fusion/verify (1)       | **commit** · openmc@absent witness, kernel_reuse `mc_transport/` 2nd consumer · valuable evidence (D72 N+M payoff visible) |
| energy/verify (×7)      | **commit 1 (hexa-parity witness) + clarify** · the openmc@absent record with `hexa_native_parity: 21/21 PASS @1e-13` is the substrate-vs-kernel parity witness — at least one should land. The `T03-07-39Z` NREL-MIDC stray needs separate disposition (κ-68 G29 ride-along leftover). |
| mobility/verify (1)     | **commit 1 latest** · platform-gated (macOS hard-block) witness |

**Tally**: 5 clean-commit recommendations (anima-bridge family, paired with their 5 untracked producers), 5 commit-latest-only + gitignore-rest (install-gated witnesses), 2 clarify (cern, component — bulk artifact bloat question), 1 split (energy hexa-parity vs MIDC stray).

### 3.1 Suggested `.gitignore` patterns (for the clarify-to-gitignore portion)

```
# Install-gated re-run sentinels (low signal · 10× verify spam)
exports/antimatter/verify/2026-*/
exports/bot/verify/2026-*/
exports/firmware/verify/2026-*/
exports/mobility/verify/2026-*/

# Large mesh artifacts (reproducible from gmsh + geometry input)
exports/component/verify/2026-*/*.msh
exports/component/verify/2026-*/*.stl

# Optional: bulk cern stopping re-runs
# exports/cern/stopping/2026-05-21T*/  (keep latest one tracked instead)
```

These patterns preserve the *first* time-format directory (`20260520T083856Z` style, no dashes) while ignoring the new dash-style (`2026-05-21T…`) sweep output.

---

## § 4. Unresolved unknowns (user decision required)

1. **Latest-run vs all-runs policy for verify sentinels** · Should install-gated GATE_OPEN JSONs (which contain no measurement) accumulate per-run forever in git, or do we keep only the most recent witness per (domain, kind) pair? Current tracked pattern is "commit every run" — does that scale?

2. **Mesh artifact policy** · Should `.msh` / `.stl` / `.root` outputs be committed (audit trail + bit-for-bit replay) or `.gitignore`-d (reproducible from sources + git bloat)? cern stopping has `.root` files; component has `.msh` files; this is a recurring decision point as more substrate-running producers come online.

3. **Timestamp format normalization** · The `20260520T…` (compact) vs `2026-05-21T…` (dashes) format split — is the dashed format intentional going forward, or accidental drift from one of the new producers? If accidental, fixing the producer before locking in 213 files is cheaper.

4. **anima-bridge family commit pairing** · The 5 anima-bridge producers (`AuraVerifyProducer.swift` etc.) + their 5 single-JSON exports should land together. Should this be one commit ("D80+1 · 5-domain anima-bridge fill" or similar) or 5 per-domain commits matching the existing `feat(exports)` style?

5. **`exports/energy/verify/2026-05-21T03-07-39Z/energy_verify_20260520T190739Z_nrel_midc_pyranometer.json`** · stray κ-68 G29 NREL-MIDC ride-along that landed in `80a1664` but appears to have a duplicate untracked re-run. Confirm whether to absorb or drop.

6. **Concurrent agent collision risk** · `cockpit/Sources/DemiurgeCore/Loaders/*.swift` modifications are mid-flight (ARCH/INDEX rider audit + G33 schema worktree). The 5 new producer .swift files are untracked but referenced from `ProducerRegistry.swift` (modified). Coordinate landing order so the rider audit doesn't strand them.

---

End of inventory. Note path: `inbox/notes/2026-05-21-untracked-exports-inventory.md` · ~180 lines · matches `2026-05-21-pool-gate_v3-abc-diagnosis.md` research-note pattern (untracked, user reviews + decides next cycle).
