# hexa-native connection plan — 2026-05-20

> **status**: PROMOTED to **RFC 013** (κ-67) on 2026-05-20 — the
> `κ-? RFC` placeholder below resolves to
> `proposals/rfc_013_hexa_native_parity_connection.md`. This note
> remains in place as the audit-trail SHAPE-pass; the RFC pins
> decisions, SHAs, and the 8-pilot rolling table.
> **original status**: open · proposed by κ-65 D80 g_hexa_only audit round
> **scope**: how each hexa-native kernel pilot wires INTO the demiurge
> record / registry layer once `HexaNativeParityRef` (or equivalent)
> lands. NO demiurge edits are proposed here — this is a SHAPE-only
> note, queued for a future κ-? RFC.
> **trees**: hexa-lang `stdlib/kernels/<id>/<kernel>.hexa` (substrate);
> demiurge `Sources/.../{UfoVerifyRecord, AuraVerifyRecord, ProducerRegistry, DomainCatalog}.swift`
> (consumer); demiurge `domains/PRODUCERS.demi` (declarative SSOT, D85).
> **upstream**: D80 g_hexa_only + D86 g_no_hardcoded_data + D72 2-layer
> STDLIB extraction + κ-60 (`hexaNativeParity`) + κ-62 (sibling-repo
> variant pattern).

---

## 1. Why this note

D80 (`@D g_hexa_only`) declares hexa-native as the ultimate substrate
form. The κ-65 audit round added four hexa-native kernel pilots on
hexa-lang `origin/main`:

| pilot # | hexa-lang path                                     | parity tier                    |
|--------:|----------------------------------------------------|--------------------------------|
| #1      | `stdlib/kernels/solar/solar_kernel.hexa`           | pvlib 0.13.0 ≤1e-13 rel (21/21)|
| #2      | `stdlib/kernels/mc_transport/mc_slab_demo.hexa`    | Beer-Lambert √N envelope (8/8) |
| #3      | `stdlib/kernels/signal_proc/dft_naive.hexa`        | analytic spectra ≤1e-12 (17/17)|
| #4      | `stdlib/kernels/noc_sim/event_queue.hexa`          | python-heapq exact (36/36)     |

Each pilot proves the PORT PATTERN but flips no demiurge cell. The
connection between (a) the substrate parity test landed on hexa-lang
and (b) the demiurge cell-record's `absorbed` flag is still missing
— this note draws the SHAPE so a future κ-? RFC can land it without
re-discovering the geometry from scratch.

Per **D80 + D86 governance**: this note proposes ZERO Swift edits,
ZERO DomainCatalog edits, ZERO hardcoded dict additions. The schema
shapes below are declarative — they will land via .demi-style
section additions on the appropriate SSOTs (PRODUCERS.demi extension,
or a new DEPENDENCIES.demi-style sibling).

---

## 2. Per-pilot connection sketch

### 2.1 Pilot #1 — solar (`solar_kernel.hexa`)

**Demiurge-side cells touched**:
- `energy + analyze` (Phoenix solar PV)
- `energy + verify` (Haurwitz clear-sky GHI cross-check)
- future `space + analyze` solar-flux preliminary sizing

**Connection shape**:
- Cell record schema's `hexaNativeParity: HexaNativeParityRef?`
  field (planned at κ-60) points at:
  - `kernel_path = "stdlib/kernels/solar/solar_kernel.hexa"` (hexa-lang
    repo-relative)
  - `parity_test = "stdlib/kernels/solar/solar_kernel_test.hexa"`
  - `parity_method = "substrate_to_substrate"` — both this kernel
    and the Python kernel implement the SAME closed-form Hughes
    1985 + Haurwitz 1945 algorithm; parity is "did the hexa port
    re-implement the same arithmetic correctly?", not "does the
    hexa port match an external measurement?".
  - `parity_tolerance = 1e-13` (relative; the kernel-side
    `solar_kernel_test.hexa` enforces this on 6 Phoenix samples).
  - `parity_status = "PASS-21/21"` as of hexa-lang
    `origin/main = <hexa-lang sha>`.
- Substrate-side adapter (`stdlib/energy/pvlib_clearsky.py`) gets a
  `--use-hexa-kernel` opt-in flag (later default-on). When opt-in,
  the adapter invokes the hexa kernel via `hexa run` and compares
  outputs to the existing pvlib path, recording the parity gap as a
  fact on the demiurge record. The pvlib path stays alive as the
  oracle until pvlib is fully absorbed.
- Registry-side: NO new producer entry. The existing solar
  producer keeps its `siblingRepoVariant` (κ-62) and gains the
  `hexaNativeParity` annotation. This is the "1 producer, 2
  parity-anchored paths" pattern.

**Provisional-marker discipline**:
- `provisional = true` on the hexa-kernel-driven path UNTIL a
  measured oracle wires in (pyranometer or satellite GHI, neither
  exists today for the Phoenix demo). The 1e-13 relative parity
  closes the substrate-to-substrate gap but not the substrate-to-
  measurement gap.

### 2.2 Pilot #2 — mc_transport (`mc_slab_demo.hexa`)

**Demiurge-side cells touched**:
- `energy + verify` (k-eff Monte Carlo) — when an MGXS port lands
- `fusion + verify` (TBR / blanket Monte Carlo) — same caveat
- `antimatter + verify` (Bethe-Bloch / particle stopping) — orthogonal
  algorithm; separate kernel slot

**Connection shape**:
- `hexaNativeParity = { kernel_path =
  "stdlib/kernels/mc_transport/mc_slab_demo.hexa", parity_test =
  "stdlib/kernels/mc_transport/mc_slab_demo_test.hexa", parity_method
  = "analytic_oracle + python_companion_seed_match", parity_status =
  "PASS-8/8" }`.
- The Beer-Lambert analytic oracle is THE oracle for the pilot
  test — but the cell-level oracle remains OpenMC (when installable)
  for measured-MGXS keff parity. The `mc_slab_demo` kernel is a
  pattern-proof, not an OpenMC replacement.
- Registry-side: a future `mc_transport` producer variant could
  register a `hexaNativeVariant` factory pointing at this kernel
  for the small-system pattern-proof case. Default producer
  remains the Python adapter wrapping OpenMC (track-D blocker
  resolved-or-bypassed).

**Provisional-marker discipline**:
- `provisional = true` ALWAYS for mc_slab_demo-driven cells —
  single-energy-group illustrative cross-sections are NOT real
  nuclide data. The cell can pin its illustrative-MC-only nature
  via a separate `gate_type = "illustrative-physics"` (NOT
  `hexa-native-absent`).

### 2.3 Pilot #3 — signal_proc DFT (`dft_naive.hexa`)

**Demiurge-side cells touched**:
- `aura + verify` (EEG PSD substrate-parity)
- `aura + analyze` (EEG band-power features)
- future `bot + analyze` vibration analysis, any cell that touches
  Welch-PSD-style spectral features

**Connection shape**:
- `hexaNativeParity = { kernel_path =
  "stdlib/kernels/signal_proc/dft_naive.hexa", parity_test =
  "stdlib/kernels/signal_proc/dft_naive_test.hexa", parity_method
  = "analytic_spectra + roundtrip_identity + parseval",
  parity_status = "PASS-17/17", parity_scope = "DFT primitive only;
  windowing / Welch averaging / band-power integration NOT yet
  ported" }`.
- The aura producer (`stdlib/aura/aura_mne.py`) currently calls
  `kernels/signal_proc/mne_psd_kernel.py`. A future hexa-native
  Welch PSD adapter would compose `dft_naive.hexa` with framing +
  windowing + averaging — that's a multi-round buildup. The
  connection plan defers cell-level wiring until the Welch layer
  is also hexa-native, since substrate-parity is per-pipeline-
  segment, not per-DFT-call.

**Provisional-marker discipline**:
- `provisional = true` while only the DFT layer is ported and the
  consumer-pipeline still calls MNE for windowing + averaging.
  Once the full Welch stack is hexa-native, the cell can pin to
  `hexaNativeParity` referring to the composite test.

### 2.4 Pilot #4 — noc_sim event_queue (`event_queue.hexa`)

**Demiurge-side cells touched**:
- NONE today (no cell currently uses event-driven NoC simulation;
  chip + verify uses the analytic mean-field path)
- FUTURE: any cell that grows event-driven flit-level packet
  tracking — this is the substrate primitive on which BookSim2
  absorption's event scheduler would sit.

**Connection shape**:
- No cell-record annotation today. The future producer would be
  something like `chip + verify (event_driven)` with
  `hexaNativeParity = { kernel_path =
  "stdlib/kernels/noc_sim/event_queue.hexa", parity_test =
  "stdlib/kernels/noc_sim/event_queue_test.hexa", parity_method =
  "python_heapq_oracle_exact + fifo_invariant", parity_status =
  "PASS-36/36" }`.
- Registry-side: a future event-driven NoC sim producer would be a
  new section in `PRODUCERS.demi`, NOT an edit to the existing
  analytic chip+verify producer.

**Provisional-marker discipline**:
- Same `provisional = true` discipline applies. The scheduler is a
  building block; cell-level `absorbed = true` only flips when a
  composed event-driven sim is parity-verified against an external
  DES oracle (BookSim2 packet trace, ns-3 trace).

---

## 3. For the heavy / nonportable buckets — `gate_type = "hexa-native-absent"`

The κ-65 audit (hexa-lang `domains/DEPENDENCIES.demi`) classifies
each kernel + producer with `portable_status ∈ {already-ported,
in-flight, portable-next, heavy-port, nonportable}`. The
`nonportable` bucket carries an obvious connection-plan implication:

### 3.1 Permanent nonportable kernels (10 entries on the audit)

- `bot/drake_verify.py` (pydrake — C++ MIT proprietary numerical stack)
- `cern/elegant_tracking.py` (xsuite — symplectic accelerator tracking)
- `cern/xsuite_optics.py` (xsuite Twiss / orbit)
- `component/calculix.py` (CalculiX Fortran binary — subprocess-only)
- `mobility/carla_scenario.py` (CARLA Unreal-Engine simulator)
- `rtsc/getdp_hts.py` (GetDP C++ FEM CLI)
- `rtsc/pyfemm_magnetics.py` (FEMM Windows-only proprietary)
- `space/gmat_basilisk.py` (Basilisk / GMAT spacecraft simulators)
- `sscb/femmt_sweep.py` (FEMMT ONELAB / GetDP wrapper)
- `antimatter/geant4_verify.py` (Geant4 — CERN's particle transport)

**Connection plan for each**:
- Cell record schema's `hexaNativeParity` is **explicitly null** —
  not "missing", but "permanently not applicable".
- New cell-record field (or new `gate_type` enum value):
  `gate_type = "hexa-native-absent"` — distinguishes "no hexa
  kernel exists" from "no kernel exists at all".
- The producer keeps its `siblingRepoVariant` (κ-62) pointing at
  the external Python/C++/binary substrate.
- The record's honesty caveat enumerates the upstream substrate
  name, version, license, and the multi-year-port reason for
  absence.
- No future κ-? cycle is expected to flip `gate_type =
  "hexa-native-absent"` to absent. Marking it permanent prevents
  recurring "why hasn't X been absorbed?" noise.

### 3.2 Heavy-port bucket (in-flight or queued)

These are NOT permanent absences — they have a multi-round port
horizon (FFT, sparse FEM linear-algebra, autodiff, MGXS):

- `kernels/wave_optics/poppy_kernel.py` — needs FFT (queued)
- `kernels/fem/skfem_kernel.py` — needs sparse linear-algebra
- `energy/openmc_keff.py` — needs MGXS table format + multi-region
  MC (mc_transport extension)
- `energy/pypsa_capacity.py` — needs HiGHS-equivalent LP solver
- `scope/openmdao_sizing.py`, `space/openmdao_mission.py` — need
  scipy.optimize + autodiff
- `mobility/road_network.py` — needs osmnx PBF parser

**Connection plan**: each gets a tracked `portable_status =
"heavy-port"` row in `DEPENDENCIES.demi`. The cell-record carries
`gate_type = "hexa-native-future"` (NOT `-absent`), so it's
visually distinct from the permanent bucket. The expected-port-
horizon is a free-text field on the .demi row, captured at audit
time so it can be revisited honestly.

---

## 4. Schema shapes for the future RFC

The future κ-? RFC that lands this connection plan needs to extend
or add three schema points:

### 4.1 `HexaNativeParityRef` (already planned at κ-60 follow-up)

```swift
// Sketch — Swift signature to be confirmed by the future RFC.
struct HexaNativeParityRef {
  let kernelPath:      String     // "stdlib/kernels/<id>/<x>.hexa"
  let parityTest:      String     // ".../<x>_test.hexa"
  let parityMethod:    ParityMethod
  // .substrate_to_substrate (1e-13 rel)
  // .analytic_oracle (closed-form algebra)
  // .python_companion_seed_match (stochastic, same-RNG)
  // .roundtrip_identity (idft∘dft == I)
  let parityTolerance: Double      // 1e-13 / 1e-12 / 5e-2 — pilot's tightest
  let parityStatus:    String      // "PASS-N/M" snapshot
  let hexaLangSHA:     String      // origin/main sha at landing
  let scopeNotes:      String?     // "DFT primitive only; Welch NOT ported"
}
```

### 4.2 `gate_type` enum extension

Add two cases (next to the existing `measurement_gate` /
`scope_caveats` vocabulary):

- `.hexa_native_absent` — permanent (drake / carla / geant4 / ...)
- `.hexa_native_future` — heavy-port (FFT / FEM / MGXS / ...)

### 4.3 `DEPENDENCIES.demi` extension (hexa-lang side)

The κ-65 audit landed this file at `domains/DEPENDENCIES.demi` on
hexa-lang `origin/main`. The connection plan above does NOT
require any cross-repo schema replication on the demiurge side —
demiurge's loaders read FROM hexa-lang's file when they need to
make a dispatch decision (per D86 g_no_hardcoded_data: no
duplicated dict). A `DEPENDENCIES.demi` row update on hexa-lang is
the SSOT for "this kernel is `portable_status = already-ported`
with `parity_status = PASS-N/M`" — demiurge consumes that fact at
producer-dispatch time.

---

## 5. What this note does NOT do

- **No Swift edits** are proposed. The `HexaNativeParityRef` sketch
  above is in a comment block, not on disk. (D80 + D86 governance:
  hexa-native-connection schema lands via .demi extension OR via a
  future κ-? RFC's reviewed Swift edit — not from a planning note.)
- **No DomainCatalog edits**. Per D61, substrate lives in
  `hexa-lang/stdlib/`, demiurge tracks connections.
- **No cell-record flips** (`absorbed=false` everywhere).
- **No `PRODUCERS.demi` edits**. The current sibling-repo dispatch
  is unchanged; the hexa-kernel parity ride is opt-in at the
  adapter layer (`stdlib/<domain>/<adapter>.py --use-hexa-kernel`),
  not a registry-layer producer swap, until the demiurge schema
  formally lands the parity-ref field.

---

## 6. Action queue for the future κ-? RFC

1. Land `HexaNativeParityRef` schema with the 8 fields above.
2. Land `gate_type ∈ {hexa-native-absent, hexa-native-future}` as
   first-class enum cases (replacing today's free-text marker if
   one exists).
3. For each of the 4 pilots, write the cell-record annotation —
   one PR per pilot, since each touches a different cell family
   (solar, mc_transport, signal_proc, noc_sim).
4. Wire the `dependencies.demi` consumer into ProducerRegistry's
   dispatch decision so a producer's `portable_status` is read at
   spawn time, not hardcoded.
5. For each `nonportable` kernel, pin `gate_type =
   "hexa-native-absent"` on every cell that uses it. One sweep PR,
   audited row-by-row.

---

## 7. Cross-references

- hexa-lang `domains/DEPENDENCIES.demi` (κ-65 audit SSOT)
- hexa-lang `inbox/notes/hexa-native-port-pattern-pilot.md`
  (extended with pilots #3 + #4 rows)
- demiurge `AGENTS.tape @D g_hexa_only` (D80)
- demiurge `AGENTS.tape @D g_no_hardcoded_data` (D86)
- demiurge `AGENTS.tape @D substrate_in_hexa_lang_only` (D61)
- demiurge `inbox/notes/hexa-native-port-pattern-pilot-mc-transport.md`
  (pilot #2 pattern detail)
- κ-60 `hexaNativeParity` field (planned schema follow-on)
- κ-62 `siblingRepoVariant` pattern (the κ-? above extends it)
- **PROMOTED-TO**: `proposals/rfc_013_hexa_native_parity_connection.md`
  (κ-67 — the `κ-? RFC` placeholder above resolves here; this RFC
  pins SHAs `5e9f6dea` (demiurge schema land), `a272c9c4` (hexa-lang
  codegen + wrap_pi), `4389da0c` (hexa-lang pilot reconcile), plus
  the 9-row pilot table).
