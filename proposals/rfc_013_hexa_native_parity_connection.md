# RFC 013 — Hexa-native parity connection (D80 substrate ↔ demiurge cell-record wiring)

> Status: **LANDED** (schema half κ-66 `5e9f6dea` · producer wire T7
> `efa4afe` · D95 computed cell-flip `a5d12d2` · D99 chip UI
> `f036f6f` · D96+D100 19/19 narrative `47bf504` + `e451037` · D97
> 3-tier link-integrity `74a1b92` · D98 cross-ref CI `384101b` ·
> D101 env-fallback deprecation `8fc0862` · D103 dimension-separation
> docstring `105315e` · D102 chem first PILOTS row `a033def` · D106
> illustrative-physics gate first-class · **D109 cell pick + 5 default
> lock-in** (Energy/solar + NREL MIDC SRRL Golden CO · κ-68 G27) ·
> **D110 first cell legitimate `absorbed=true` flip** (Energy/solar
> 2024-06-15 · mean_rel_err 0.04988 vs 0.05 threshold · PASS ·
> hexa-lang `b8d35920` real producer + demiurge `exports/energy/
> verify/2026-05-21T03-07-39Z/` record · κ-68 G29) · G30 Stage 1
> XCTest invariant `fee34cc`). Created: 2026-05-20 · Last status
> refresh: 2026-05-21 (κ-68 closure) · **κ phase: κ-68** (per-cell
> measured-oracle parity round — G27 land D109, G28 schema-half
> `4a1a087` + STUB PR #248, G29 first legitimate flip D110 + REAL
> PR #259, G30 Stage 1 invariant `fee34cc`; only G30 Stage 2
> constitution.md row deferred until populate decision).
> Promotes: `archive/session-notes/hexa-native-connection-plan-2026-05-20.md`
> (the κ-65 audit-round SHAPE note). The note remains in place as
> audit trail; this RFC supersedes its `κ-? RFC` placeholder.
> Source decisions: `design.md` D61 (substrate in hexa-lang only),
> D72 (2-layer stdlib extraction), D80 (`g_hexa_only` ultimate-form),
> D86 (`g_no_hardcoded_data` declarative SSOT), D85 (PRODUCERS.demi),
> D94 (Producer T7 wire), D95 (cell absorbed = computed over PILOTS),
> D96 / D100 (19/19 domain narrative), D97 (3-tier link-integrity),
> D98 (DEPENDENCIES↔PILOTS cross-ref CI), D99 (HexaNativeParityChip),
> D101 (`DEMIURGE_HEXA_LANG` env-var deprecation), D102 (chem first
> PILOTS row), D103 (2-orthogonal-dimension docstring).
> Earlier κ-history: κ-60 (`hexaNativeParity` field planned),
> κ-62 (sibling-repo variant pattern), κ-65 (44-row dependency audit
> + 4 D80 pilot landings + connection-plan note).
> Pattern mirror: hexa-lang's pilot rolling table at
> `archive/session-notes/hexa-native-port-pattern-pilot.md` (15 pilot rows
> #1..#12 across `solar / mc_transport / neural / graph / urdf /
> plasma / orbital / signal_proc / noc_sim / transport_kinematics /
> breaker_trace_reduce / fem_bar1d / autodiff_dual / bio_align_nw /
> chem_arrhenius`; 375 cumulative assertions).

---

## 1. Purpose

D80 (`@D g_hexa_only`) declares **hexa-native** (`stdlib/kernels/<id>/
<kernel>.hexa`) as the ultimate substrate form. The κ-65 audit round
landed (a) a **44-row `DEPENDENCIES.demi` audit SSOT** on hexa-lang
classifying every substrate by `portable_status ∈ {already-ported,
in-flight, portable-next, heavy-port, nonportable}` and (b) **8
hexa-native kernel pilots** proving the port pattern. But until this
RFC, no demiurge-side schema connected the substrate parity facts to
the cell-record `absorbed` flag.

This RFC defines the **connection schema** so a hexa-lang substrate
parity result (e.g. `solar_kernel_test.hexa` PASS 21/21 at 1e-13 rel)
can be carried as a typed annotation on the demiurge cell record —
without duplicating the audit dict in Swift (per D86) and without
flipping `absorbed=true` on substrate-parity alone (substrate-parity
≠ measurement-parity; the cell-record honesty floor is preserved).

---

## 2. What's already landed (κ-66 schema half)

Implementation commit: demiurge **`5e9f6dea`** (`feat(cockpit/D80):
HexaNativeParityRef schema + DependenciesLoader land`).

### 2.1 `HexaNativeParityRef` (Models/UfoVerifyRecord.swift)

Replaces the prior 3-field sketch (`ref / relErr / tolerance`) with
the 8-field shape from the note §4.1:

```swift
struct HexaNativeParityRef {
  let kernelPath:      String         // "stdlib/kernels/<id>/<kernel>.hexa"
  let parityTest:      String         // ".../<kernel>_test.hexa"
  let parityMethod:    ParityMethod   // 7-case enum (see §3.2)
  let parityTolerance: Double?        // optional — null for non-numeric oracles
  let parityStatus:    String         // "PASS-N/M" snapshot
  let hexaLangSHA:     String         // hexa-lang origin/main SHA at landing
  let scopeNotes:      String?        // "DFT primitive only; Welch NOT ported"
  let relErr:          Double?        // tightest observed rel-err on the
                                      // parity test (null for exact / non-numeric)
}
```

Optional field on each cell-verify record (so a record with no
hexa-native port today carries `hexaNativeParity = nil` honestly).

### 2.2 Cell-record carriers (5)

Five carriers compile against the new 8-field shape:

- `UfoVerifyRecord`        — pre-existing field, schema upgraded inline.
- `EnergyVerifyRecord`     — pilot #1 consumer (solar / `pvlib_clearsky`).
- `FusionVerifyRecord`     — pilot #2 consumer (mc_transport illustrative).
- `AuraVerifyRecord`       — pilot #6 consumer (`dft_naive`).
- `ChipAnalyzeRecord`      — pilot #7 future consumer (`event_queue`).

D80 g_hexa_only — every record family that can theoretically host a
hexa-native parity ride carries the field. No-op when nil.

### 2.3 `GateType` extension (Models/GateType.swift)

Two new cases:

- `hexaNativeAbsent` — **permanent** (nonportable substrate: drake /
  carla / geant4 / xsuite / calculix / femm / basilisk / femmt /
  getdp / elegant — 10 rows of the 44-row audit).
- `hexaNativeFuture` — **heavy-port** (multi-year-port substrate:
  poppy / skfem / openmc / pypsa / openmdao / osmnx).

Predicate `GateType.hexaNativeBlocked` covers both. SkippedCells
dashboard color map:

| GateType            | Chip color | Semantics                             |
|---------------------|-----------|---------------------------------------|
| `hexaNativeAbsent`  | orange    | permanent — no future κ-? expected    |
| `hexaNativeFuture`  | yellow    | heavy-port queue — revisit-able       |

### 2.4 `DependenciesLoader` (Loaders/DependenciesLoader.swift)

Reads `demiurge/domains/DEPENDENCIES.demi` (the 44-row audit SSOT —
relocated to demiurge by D88, formerly under hexa-lang) via
`DemiParser` and projects to typed `DependencyEntry` with
`Weight / PortableStatus / Kind` enums mirroring the `.demi`
vocabulary.

**Honesty floor (D86):** missing SSOT → empty array + stderr warning.
**No hardcoded fallback dict.** Matches the `ProducerLoader` pattern.

Path resolver order (post-D88 + D101 — demiurge-local only, no
cross-repo `hexa-lang` env-var fallback):

1. `$DEMIURGE_REPO/domains/DEPENDENCIES.demi` (CI / sandbox override)
2. `$PWD/domains/DEPENDENCIES.demi` (invocation-from-repo default)
3. `~/core/demiurge/domains/DEPENDENCIES.demi` (user-global wilson layout)

Inference helper `inferGateType(for:)` implements the §3.1 / §3.2
contract — see §3 below. Tests: 3 cover loader OK / loader-missing-
file-empty / portable-status-to-gate-type mapping.

---

## 3. Gate-type inference contract

`DependenciesLoader.inferGateType(for: kernelId) -> GateType?` is the
single source for the D80-related buckets:

### 3.1 `portable_status = "nonportable"` → `.hexaNativeAbsent`

Permanent absence — the substrate is provably out of multi-year
porting horizon (proprietary, CERN-scale, vendor-binary). 10 audit
rows fall here today:

| audit row                        | substrate reason                                    |
|----------------------------------|-----------------------------------------------------|
| `bot/drake_verify.py`            | pydrake — C++ MIT proprietary numerical stack       |
| `cern/elegant_tracking.py`       | xsuite — symplectic accelerator tracking            |
| `cern/xsuite_optics.py`          | xsuite Twiss / orbit                                |
| `component/calculix.py`          | CalculiX Fortran binary — subprocess-only           |
| `mobility/carla_scenario.py`     | CARLA Unreal-Engine simulator                       |
| `rtsc/getdp_hts.py`              | GetDP C++ FEM CLI                                   |
| `rtsc/pyfemm_magnetics.py`       | FEMM Windows-only proprietary                       |
| `space/gmat_basilisk.py`         | Basilisk / GMAT spacecraft simulators               |
| `sscb/femmt_sweep.py`            | FEMMT ONELAB / GetDP wrapper                        |
| `antimatter/geant4_verify.py`    | Geant4 — CERN's particle transport (~M LOC C++)     |

Cells consuming these carry `hexaNativeParity = nil` *forever* and
`gate_type = .hexaNativeAbsent`. The honesty caveat enumerates
upstream substrate name, version, license, multi-year-port reason.

### 3.2 `portable_status ∈ {heavy-port, in-flight}` → `.hexaNativeFuture`

Multi-round-port horizon — NOT a permanent absence:

| audit row                          | port driver needed                          |
|------------------------------------|---------------------------------------------|
| `kernels/wave_optics/poppy_kernel.py` | FFT primitive (queued)                   |
| `kernels/fem/skfem_kernel.py`         | sparse linear-algebra solver             |
| `energy/openmc_keff.py`               | MGXS table format + multi-region MC      |
| `energy/pypsa_capacity.py`            | HiGHS-equivalent LP solver               |
| `scope/openmdao_sizing.py`            | scipy.optimize + autodiff                |
| `space/openmdao_mission.py`           | scipy.optimize + autodiff                |
| `mobility/road_network.py`            | osmnx PBF parser                         |

Cells gate `.hexaNativeFuture` (yellow chip) — revisit-able when the
underlying primitive lands.

### 3.3 `portable_status = "already-ported"` → existing `.absorbed`

The 9 D80 pilots (see §5) flip `portable_status = "already-ported"`
on the audit row. Cells can OPT-IN to the hexa-native ride via the
adapter's `--use-hexa-kernel` flag (§4.2). The cell-record honesty
floor — `absorbed=true` requires measurement-parity, not just
substrate-parity — is preserved by leaving `absorbed` orthogonal to
`hexaNativeParity` presence (a record can carry a PASS-21/21 parity
ref AND still have `absorbed=false` if the cell oracle is a measured
external quantity that hasn't wired in yet).

---

## 4. Per-pilot connection sketch (mirror of note §2)

The note §2 details solar / mc_transport / dft / event_queue. This
RFC pins the SHAs and extends to all 9 rows of the hexa-lang rolling
table (note: pilots #5 and #5b are sibling closed-form ports under
the same κ-65 fan-out and are listed for completeness; #3b graph is
the concurrent BFS+Kahn branch).

### 4.1 8-pilot rolling table (hexa-lang `origin/main` SHAs)

| pilot # | kernel                                            | landing SHA   | parity tier                                        |
|--------:|---------------------------------------------------|---------------|----------------------------------------------------|
| #1      | `stdlib/kernels/solar/solar_kernel.hexa`          | `122620de`    | pvlib 0.13.0 substrate parity 21/21 ≤1e-13 rel     |
| #2      | `stdlib/kernels/mc_transport/mc_slab_demo.hexa`   | `dd3dad19`    | python-companion (same LCG) + √N envelope 8/8      |
| #3      | `stdlib/kernels/neural/lif_kernel.hexa`           | `299db935`    | numpy 2.x substrate reference 23/23 ≤2e-15 rel     |
| #3b     | `stdlib/kernels/graph/` (BFS+Kahn)                | `8db56f5a`    | networkx companion parity (concurrent branch)      |
| #4      | `stdlib/kernels/urdf/` (2-link FK)                | `fc270b6c`    | yourdfpy companion parity (SE(3) transform)        |
| #5      | `stdlib/kernels/plasma/plasma_metrics_kernel.hexa`| `c668702b`    | NRL Formulary closed-form 41/41 rel_err=0          |
| #5b     | `stdlib/kernels/orbital/kepler_2body_kernel.hexa` | `2ffe3620`    | Vallado §2.2 / Curtis §3.6 closed-form 27/27       |
| #6      | `stdlib/kernels/signal_proc/dft_naive.hexa`       | `f8cd27c8`    | analytic spectra + Parseval + round-trip 17/17     |
| #7      | `stdlib/kernels/noc_sim/event_queue.hexa`         | `f8cd27c8`    | python-companion `heapq` + FIFO 36/36 exact        |

All 9 rows ride the same port pattern (note §"Pattern" — pick the
substrate not the adapter; capture parity from the Python substrate
at ≥12 digits; mirror the API surface line-by-line; reuse the
`pass_count / total_count / check / rel_err` test scaffolding).

### 4.2 Demiurge-side wiring per pilot

- **Pilot #1 / #6 / #7 — direct cell consumers** carry the
  `hexaNativeParity` ref pointed at the kernel + test SHA today.
  Producer-side emit (the adapter actually writing the ref into the
  record JSON) is the §6 producer-emit follow-on.
- **Pilot #2 — illustrative-physics gate** — `mc_slab_demo` is a
  pattern-proof, NOT an OpenMC replacement. Cell-level oracle remains
  OpenMC for measured-MGXS keff parity. Records carrying
  `mc_slab_demo`-driven verify pin a separate
  `gate_type = "illustrative-physics"` (NOT `.hexaNativeFuture`).
- **Pilot #3 (LIF) / #3b (graph) / #4 (urdf) / #5 (plasma) / #5b
  (orbital)** — same shape; carriers (FusionVerifyRecord /
  BotVerifyRecord / SpaceVerifyRecord) are added in the §6
  producer-emit round as cells start writing these fields.

### 4.3 Provisional-marker discipline

Every cell-record consuming a hexa-native pilot carries
`provisional = true` UNTIL a measured oracle wires in. Substrate-
parity (hexa↔Python) closes the *port* gap, NOT the substrate-to-
measurement gap. This RFC does NOT relax that floor; it just adds
the typed annotation.

---

## 5. Side-effects in hexa-lang (codegen + stdlib)

The κ-65 pilot fan-out exposed a parser/codegen issue blocking
pilot #5b (orbital Kepler), now fixed:

### 5.1 hexa-lang `a272c9c4` — codegen param-shadow auto-wrap fix

> `fix(compiler): local scope shadows stdlib fn-globals in fn-ref auto-wrap`

Param `e: float` (or any name colliding with stdlib top-level fns
like `e() / pi() / tau()`) used to emit `hexa_fn_new((void*)e, 0)` at
5 auto-wrap sites in `self/codegen_c2.hexa` — broken C, clang error.
Orbital Kepler pilot (`2ffe3620`) had to rename `e` → `ecc` to land;
this fix retires the rename workaround. Centralized predicate
consults current-fn params/lets before treating an identifier as a
fn-global. Discovery #5b recorded in
hexa-lang `archive/session-notes/hexa-native-port-pattern-pilot.md`.

### 5.2 hexa-lang `a272c9c4` (same commit) — `stdlib/core/math/wrap_pi.hexa`

Net new stdlib primitive: `wrap_pi(angle: float) -> float`
(canonical `(-π, π]` reduction with closed-form `2π·round_half_even(x/2π)`).
56 LOC kernel + 88 LOC test. Used by the orbital Kepler kernel post-
fix and reusable by any cell that needs angle wrapping.

### 5.3 hexa-lang `4389da0c` — orbital pilot reconcile

> `docs(archive/session-notes/pilot-pattern): reconcile orbital Kepler #5b into rolling table`

Adds the #5b row into the rolling table (note §"Pilots landed"),
sequencing it after #5 (plasma) and before #6 (DFT). Pure doc; no
substrate change.

---

## 6. Follow-ons — sweep progress (κ-67 PARTIAL-LAND → MOSTLY-LANDED)

This RFC originally landed the **schema half** at κ-66 (`5e9f6dea`)
and listed three follow-on rounds. The post-`cea3c66` sweep
(2026-05-20) collapsed most of §6.1 and §6.2 into landed state.
Current status:

### 6.1 Producer-side emit — LANDED (T7 wire)

**Landed**: demiurge `efa4afe` (D94 — `feat(cockpit/T7): Producer ↦
PilotLoader.find(id:) auto-lookup wire`). 4 producer cells now emit
`hexaNativeParity` automatically by `PilotLoader.find(id:)` lookup
against `domains/PILOTS.demi` — no hardcoded SHA mirrors in Swift
(D86 honesty floor preserved). The optional field defaults to nil
for cells with no PILOTS row.

### 6.2 Cell-flip = computed property — LANDED (D95)

**Landed**: demiurge `a5d12d2` (D95 — cell `isHexaNativeAbsorbed`
computed property over `PILOTS.demi parity_status`). NOT a stored
flip — the substrate-parity dimension is *projected* from the
declarative SSOT, so the cell-record honesty floor (g3 — stored
`absorbed: Bool` requires a measured oracle) is preserved while
substrate-side PASS is visible to the cockpit.

### 6.3 Cockpit chip UI — LANDED (D99)

**Landed**: demiurge `f036f6f` (D99 — `HexaNativeParityChip`
3-case visualize cell parity ref). The chip renders Stage-1 / Stage-2
/ Stage-3 hexa-native parity state from the computed property; no
static `GateType` colors duplicated.

### 6.4 19/19 substrate narrative — LANDED (D96 + D100)

**Landed**: demiurge `47bf504` (D96 — 5 sibling-bearing domains'
`domains/<id>.md` carry a substrate narrative line) +
`e451037` (D100 — 14 non-sibling domains close the Q2 reverse loop;
every demiurge domain now states where its substrate lives).

### 6.5 3-tier link-integrity verifier — LANDED (D97 / Q3=A)

**Landed**: demiurge `74a1b92` (D97 — 3-tier substrate link-
integrity verifier covers Tier ① sibling repo presence / Tier ②
`SUBSTRATE_LINKS.demi` ↔ filesystem agreement / Tier ③
`DEPENDENCIES.demi` ↔ `PILOTS.demi` cross-ref).

### 6.6 DEPENDENCIES ↔ PILOTS cross-ref CI — LANDED (D98)

**Landed**: demiurge `384101b` (D98 — `DependenciesPilotsCrossRef
Tests` 3 XCTest method · Phase F · cross-ref CI test). Single-source
discrepancy between the 44-row audit and the rolling pilot table is
now a CI gate.

### 6.7 `DEMIURGE_HEXA_LANG` env-var deprecation — LANDED (D101)

**Landed**: demiurge `8fc0862` (D101 — `DependenciesLoader` and
`PilotLoader` no longer fall back to `$DEMIURGE_HEXA_LANG` for
cross-repo path; D88 already relocated `DEPENDENCIES.demi` into
demiurge so the env-var is redundant). §2.4 resolver order updated.

### 6.8 Dimension-separation docstring — LANDED (D103)

**Landed**: demiurge `105315e` (D103 — 5 cell records' stored
`absorbed: Bool` and computed `isHexaNativeAbsorbed: Bool` are
documented as 2 orthogonal dimensions; producer-emit author cannot
auto-conflate measured-oracle PASS with substrate-parity PASS).

### 6.9 Chem domain seed + first PILOTS row — LANDED (D102)

**Landed**: demiurge `3215cea` (chem `domains/chem.md` substrate
line: NOT YET → `stdlib/kernels/chem/` seed) + `a033def` (D102 —
`[pilot-chem_arrhenius]` 14th PILOTS row · Stage-0 scaffolding · no
external oracle yet — formula IS the algorithm).

### 6.10 D80 pilot #12 = `bio_align_nw` — LANDED

**Landed**: demiurge `a2fcb1b` (`domains/bio.md` — D80 pilot #12
`needleman_wunsch_kernel` landed at hexa-lang `d73a2cbf`). Cumulative
`domains/PILOTS.demi` = 15 rows (13 D80 pilots + `pilot-chem_arrhenius`
Stage-0 seed + `pilot-mc_transport` illustrative-physics gate; 375
cumulative assertions across rows that carry parity tests).

### 6.11 LANDED 2026-05-21 — per-cell measured-oracle parity (κ-68)

The κ-68 per-cell measured-oracle parity round is LANDED. cell pick
+ decision gate at D109 (`5392213`) — Energy/solar + NREL MIDC SRRL
Golden CO pyranometer GHI + single clear-sky day · 1-min cadence +
pvlib clearsky trusted bridge + mean rel_err ≤ 5% PASS criterion.
G28 schema-half land at `4a1a087` (demiurge `MeasuredOracleRef.swift`
+ `EnergyVerifyRecord.measuredOracle` field + 7 XCTest) + PR #248
STUB producer. G29 first cell legitimate `absorbed=true` flip at
D110 — hexa-lang `b8d35920` (PR #259) REAL producer fetches NREL
MIDC BMS data for 2024-06-15, applies clearsky filter, computes
`mean_rel_err = 0.04988` over 480 samples vs `threshold = 0.05` →
PASS (marginal · ~24 bp under). The producer EXPLICITLY sets
`absorbed=true` (NOT via D95 computed projection · D103 separation
preserved). Record at `exports/energy/verify/2026-05-21T03-07-39Z/
energy_verify_20260520T190739Z_nrel_midc_pyranometer.json` (demiurge).
G30 Stage 1 XCTest invariant at `fee34cc` enforces (absorbed=true ⇒
measured_oracle PASS OR D106 illustrative exempt). G30 Stage 2
constitution.md row deferred until `.specify/memory/constitution.md`
populate (separate decision · κ-68 G30 scope 밖).

### 6.12 `gate_type = "illustrative-physics"` first-class — LANDED (D106)

`GateType.illustrativePhysics` (raw value `"illustrative-physics"`)
added as a peer enum case alongside `.hexaNativeAbsent` /
`.hexaNativeFuture`. Anti-conflation predicates: the new case is
INTENTIONALLY excluded from `hexaNativeBlocked` (the port is landed
and parity-passing; only the cell-level measured oracle is gated)
and surfaces via a dedicated `isIllustrativePhysics` predicate. The
`SkippedCellsAggregator` heuristic fallback also classifies records
whose `skipped_reason` mentions `illustrative` / `pattern-proof` /
`mc_slab_demo` tokens, so the dashboard surfaces the 4th tone even
before producers explicitly emit the typed `gate_type`. Cockpit
`SkippedCellsDashboard` paints `.cyan` (NOT green absorbed, NOT
yellow heavy-port) — RFC §6.3 anti-conflation enforced at the UI
layer. 8 new XCTest cases cover rawValue round-trip, allCases
membership, `hexaNativeBlocked` exclusion, predicate, label, and
both aggregator branches. D86 g_no_hardcoded_data preserved (typed
enum extension, no new stored data).

---

## 7. Architectural boundaries (D61 / D80 / D86 floor)

- **No substrate in demiurge** (D61). Every hexa-native kernel lives
  in hexa-lang's `stdlib/kernels/`. Demiurge only carries the typed
  parity-ref *annotation*.
- **No hardcoded data dict in Swift** (D86). The 44-row audit
  classification is read FROM hexa-lang's `DEPENDENCIES.demi` at
  load time via `DependenciesLoader`. Adding a new kernel = append
  one `.demi` section on hexa-lang, NOT a Swift code edit.
- **Substrate-parity ≠ measurement-parity** (g3 honesty floor).
  `absorbed=true` still requires a measured external oracle. The
  `hexaNativeParity` annotation is a *port-pattern* fact, not an
  absorption fact.

---

## 8. Cross-references

- Source note: `archive/session-notes/hexa-native-connection-plan-2026-05-20.md`
  (κ-65 audit-round SHAPE note — kept in place as audit trail).
- demiurge κ-66 schema half: **`5e9f6dea`** (this RFC's §2).
- demiurge κ-67 RFC publication: **`cea3c66`** (PARTIAL-LAND).
- demiurge post-κ-67 sweep (PARTIAL-LAND → MOSTLY-LANDED · 2026-05-20):
  - **`efa4afe`** — D94 · Producer T7 wire (4 cells emit `hexaNativeParity`).
  - **`a5d12d2`** — D95 · cell absorbed flip = computed property over `PILOTS.demi`.
  - **`f036f6f`** — D99 · `HexaNativeParityChip` 3-case visualize cell parity ref.
  - **`47bf504`** — D96 · sibling sub-domain narrative on 5 `domains/<id>.md`.
  - **`e451037`** — D100 · substrate narrative line on 14 non-sibling `domains/<id>.md` (Q2 reverse).
  - **`74a1b92`** — D97 · 3-tier substrate link-integrity verifier (Q3 = A).
  - **`384101b`** — D98 · `DEPENDENCIES.demi` ↔ `PILOTS.demi` cross-ref CI test.
  - **`8fc0862`** — D101 · `DEMIURGE_HEXA_LANG` env fallback deprecation.
  - **`105315e`** — D103 · cell `absorbed` vs `isHexaNativeAbsorbed` = 2 orthogonal dimensions (docstring).
  - **`3215cea`** — chem domain substrate narrative (NOT YET → `stdlib/kernels/chem/` seed).
  - **`a033def`** — D102 · chem first `PILOTS.demi` row `[pilot-chem_arrhenius]`.
  - **`a2fcb1b`** — D80 pilot #12 · `needleman_wunsch_kernel` landed (hexa-lang `d73a2cbf`).
- hexa-lang codegen fix: **`a272c9c4`** (this RFC's §5.1 + §5.2).
- hexa-lang reconcile: **`4389da0c`** (this RFC's §5.3).
- hexa-lang pilot pattern rolling table:
  `hexa-lang/inbox/notes/hexa-native-port-pattern-pilot.md`.
- audit SSOT: `demiurge/domains/DEPENDENCIES.demi`
  (44 sections — relocated from `hexa-lang/` to `demiurge/` by D88).
- pilot SSOT: `demiurge/domains/PILOTS.demi` (15 rows · 13 D80 pilots
  + 1 Stage-0 chem seed + 1 illustrative-physics gate · D90 8-field
  schema · 375 cumulative assertions).
- demiurge governance: `AGENTS.tape @D g_hexa_only` (D80),
  `@D g_no_hardcoded_data` (D86),
  `@D substrate_in_hexa_lang_only` (D61),
  `@D producers_demi_ssot` (D85).
- Prior κ history: κ-60 (`hexaNativeParity` field originally planned),
  κ-62 (`siblingRepoVariant` pattern this RFC extends),
  κ-65 (44-row audit + 4 D80 pilot landings + this RFC's source note),
  κ-66 (schema half landed `5e9f6dea`),
  κ-67 (PARTIAL-LAND `cea3c66` → MOSTLY-LANDED via D94..D103 sweep).

---

## 9. Log

- **2026-05-20** — RFC published (κ-67 PARTIAL-LAND, `cea3c66`).
- **2026-05-20** — Post-κ-67 sweep land (D94..D103 · 12 commits):
  Producer T7 wire (`efa4afe`), D95 cell-flip computed (`a5d12d2`),
  D99 chip UI (`f036f6f`), D96+D100 19/19 narrative
  (`47bf504` + `e451037`), D97 3-tier link-integrity (`74a1b92`),
  D98 cross-ref CI (`384101b`), D101 env-deprecation (`8fc0862`),
  D103 dimension docstring (`105315e`), chem seed (`3215cea`) +
  D102 chem first PILOTS row (`a033def`), D80 pilot #12 bio_align
  (`a2fcb1b`). Status: PARTIAL-LAND → MOSTLY-LANDED. Only remaining
  follow-on = per-cell measured-oracle parity round (P-⑩ ①).
- **2026-05-20** — D105 status refresh (this entry · header / §6 /
  §8 cross-references / §9 log reconciled to current sweep state).
- **2026-05-20** — D106 §6.12 illustrative-physics gate first-class
  LANDED (`GateType.illustrativePhysics` peer case + 8 new XCTest +
  `SkippedCellsDashboard` 4th-tone color · P-⑩ ③ exit criterion met).
  Remaining queued follow-on = §6.11 only (per-cell measured-oracle).
