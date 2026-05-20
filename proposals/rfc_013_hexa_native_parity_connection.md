# RFC 013 — Hexa-native parity connection (D80 substrate ↔ demiurge cell-record wiring)

> Status: **PARTIAL-LAND** (schema half landed κ-66 by demiurge
> `5e9f6dea`; producer-side emit + live-mirror queued) · Created:
> 2026-05-20 · **κ phase: κ-67** (promotion of κ-65 connection-plan
> note to formal RFC).
> Promotes: `inbox/notes/hexa-native-connection-plan-2026-05-20.md`
> (the κ-65 audit-round SHAPE note). The note remains in place as
> audit trail; this RFC supersedes its `κ-? RFC` placeholder.
> Source decisions: `design.md` D61 (substrate in hexa-lang only),
> D72 (2-layer stdlib extraction), D80 (`g_hexa_only` ultimate-form),
> D86 (`g_no_hardcoded_data` declarative SSOT), D85 (PRODUCERS.demi).
> Earlier κ-history: κ-60 (`hexaNativeParity` field planned),
> κ-62 (sibling-repo variant pattern), κ-65 (44-row dependency audit
> + 4 D80 pilot landings + connection-plan note).
> Pattern mirror: hexa-lang's pilot rolling table at
> `inbox/notes/hexa-native-port-pattern-pilot.md` (9 pilot rows
> #1..#7 across `solar / mc_transport / neural / graph / urdf /
> plasma / orbital / signal_proc / noc_sim`).

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

Reads `hexa-lang/domains/DEPENDENCIES.demi` (the 44-row audit SSOT)
via `DemiParser` and projects to typed `DependencyEntry` with
`Weight / PortableStatus / Kind` enums mirroring the `.demi`
vocabulary.

**Honesty floor (D86):** missing SSOT → empty array + stderr warning.
**No hardcoded fallback dict.** Matches the `ProducerLoader` pattern.

Path resolver order:

1. `DEMIURGE_HEXA_LANG` env override (CI / sandbox)
2. `DEMIURGE_REPO/../hexa-lang` (sibling-checkout default)
3. `~/core/hexa-lang` (user-global wilson layout)

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
hexa-lang `inbox/notes/hexa-native-port-pattern-pilot.md`.

### 5.2 hexa-lang `a272c9c4` (same commit) — `stdlib/core/math/wrap_pi.hexa`

Net new stdlib primitive: `wrap_pi(angle: float) -> float`
(canonical `(-π, π]` reduction with closed-form `2π·round_half_even(x/2π)`).
56 LOC kernel + 88 LOC test. Used by the orbital Kepler kernel post-
fix and reusable by any cell that needs angle wrapping.

### 5.3 hexa-lang `4389da0c` — orbital pilot reconcile

> `docs(inbox/pilot-pattern): reconcile orbital Kepler #5b into rolling table`

Adds the #5b row into the rolling table (note §"Pilots landed"),
sequencing it after #5 (plasma) and before #6 (DFT). Pure doc; no
substrate change.

---

## 6. Follow-ons (queued, NOT in this RFC)

This RFC lands the **schema half**. Three follow-on rounds remain:

### 6.1 Producer-side emit

Today no producer writes the `hexaNativeParity` field on its emitted
record — the field is optional and starts nil. Each pilot consumer
gets a 1-PR change to the substrate adapter (`stdlib/<domain>/
<adapter>.py`) that records the kernel+test SHA + PASS-N/M from the
parity test output. Estimate: 5 PRs (#1 / #2 / #6 / #7 first;
#3 / #4 / #5 / #5b ride a second round when their cell carriers
land).

### 6.2 Live `DEPENDENCIES.demi` mirror in cockpit

`SkippedCellsDashboard` currently colors chips from the static
`GateType` enum. Wiring `DependenciesLoader` into the cockpit's
warm-start path makes `hexaNativeAbsent` / `hexaNativeFuture`
buckets *derived* from the 44-row audit at load time (per D86 — no
hardcoded mirror). One PR.

### 6.3 `gate_type = "illustrative-physics"` first-class

Pilot #2 (`mc_slab_demo`) needs a separate gate distinct from the
two hexa-native buckets. Adding the enum case + dashboard color is
trivial; the audit work is identifying which other cells (if any)
need this gate. Queued as a small follow-up.

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

- Source note: `inbox/notes/hexa-native-connection-plan-2026-05-20.md`
  (κ-65 audit-round SHAPE note — kept in place as audit trail).
- demiurge implementation: **`5e9f6dea`** (this RFC's §2 schema half).
- hexa-lang codegen fix: **`a272c9c4`** (this RFC's §5.1 + §5.2).
- hexa-lang reconcile: **`4389da0c`** (this RFC's §5.3).
- hexa-lang pilot pattern rolling table:
  `hexa-lang/inbox/notes/hexa-native-port-pattern-pilot.md`.
- hexa-lang audit SSOT: `hexa-lang/domains/DEPENDENCIES.demi`
  (44 sections).
- demiurge governance: `AGENTS.tape @D g_hexa_only` (D80),
  `@D g_no_hardcoded_data` (D86),
  `@D substrate_in_hexa_lang_only` (D61),
  `@D producers_demi_ssot` (D85).
- Prior κ history: κ-60 (`hexaNativeParity` field originally planned),
  κ-62 (`siblingRepoVariant` pattern this RFC extends),
  κ-65 (44-row audit + 4 D80 pilot landings + this RFC's source note).
