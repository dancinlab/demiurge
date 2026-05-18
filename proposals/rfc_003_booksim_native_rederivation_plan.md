# RFC 003 — BookSim2 hexa-native re-derivation plan

> Status: **draft** · Created: 2026-05-18 · Source decisions: `design.md`
> Decision 1 (public-surface clean-room), Decision 5 (7-verb spine),
> Decision 7 (producer-owned exports).
> Implements: `proposals/rfc_001_booksim2_noc_absorption.md` §7
> (hexa-native binding plan) so §8 (measurement gate) can close.
> Pattern mirror: `~/core/hexa-lang/proposals/rfc_047_mc_integrate_absorption.md`
> (engine + dispatcher split) and `rfc_048_xeno_absorption.md` (raw-91
> fail-loud doctrine).
> Co-author: Agent (Claude Opus 4.7 · 1M ctx).

---

## 1. Purpose + scope

This RFC is the **implementation plan** for the hexa-native re-derivation
that closes rfc_001 §8's measurement gate. rfc_001 defined *what* must
land (six modules under `stdlib/booksim/`) and *why* (CHARTER
hexa-native-only + Decision 1 clean-room). This RFC defines *how* — per
the andrej-karpathy "think before coding" skill — so that the subsequent
landing session has zero new design questions to resolve.

**In scope (this RFC)**:

1. Location decision (hexa-arch local vs hexa-lang absorption) — §2.
2. Per-module interface design (six modules + dispatcher) — §3.
3. Numerical acceptance criterion vs Agent-1's BookSim2 reference run
   under `/tmp/hexa-arch-rfc001-measurement/runs/` — §4.
4. Clean-room provenance map — every re-derived line cites a BookSim2
   source line-range + commit hash, plus the analytic theorem (Leighton,
   SMART) any number is anchored on — §5.
5. Hexa-lang facilities survey — what `stdlib/` already gives us
   (collections · io · math · qrng) vs what is **missing** (notably an
   anynet-style key=value parser; arena allocators for the discrete-event
   queue) — §6.
6. Phased landing plan to GREEN-gate the rfc_001 §8 reproduction — §7.
7. Open questions for the user's D8/D9 decision gate — §8.

**Out of scope (deferred)**:

- Actual function-body implementation. This RFC + the
  `stdlib/booksim/*.hexa.stub` skeletons (sibling deliverable) define
  signatures only; bodies land in a follow-up RFC under the chosen
  location.
- The HXC v2 tool that emits the `F1F2-record` artifact for rfc_002 §3.
  rfc_002 §9 already flags that tool as deferred; this RFC inherits the
  defer.
- F2 (place-and-route overhead) — covered by a later RFC. F1 (wire-delay
  net gain) is the immediate target.
- Full BookSim2 surface. This RFC absorbs only the rfc_001 §3 minimal
  subset (`anynet · iq_router · {uniform,transpose,tornado} · sweep`).
  cmesh, fattree, dragonfly, etc. are *refused* until a second consumer
  beyond comb materializes (lattice-as-tool g1/g2 + simplicity).

---

## 2. Location decision (hexa-arch local vs hexa-lang absorption)

The question: does `stdlib/booksim/` land in **hexa-arch** itself, or
get absorbed upstream into **hexa-lang/stdlib/booksim/** the way qrng /
mc_integrate / xeno were (rfc_044 / rfc_047 / rfc_048)?

### Precedent analysis

| absorbed module | original repo | landed at | rationale |
|---|---|---|---|
| qrng (rfc_044) | `~/core/qrng/` | `hexa-lang/stdlib/qrng/` | already hexa-source library; multi-consumer (mc-integrate · hexa-bio · wilson); randomness is a *language-level* primitive class |
| mc_integrate (rfc_047) | `~/core/mc-integrate/` | `hexa-lang/stdlib/mc_integrate/` | Monte-Carlo integration is a *numerical-method* primitive that any domain repo may need; explicit cross-reference from qrng |
| xeno (rfc_048) | `~/core/xeno/` | `hexa-lang/stdlib/xeno/` | exotic-compute substrate SSOT, no other natural home in the family |

Pattern: **hexa-lang absorbs when the module is domain-neutral and at
least plausibly multi-consumer**. Each of qrng / mc_integrate / xeno is
not specifically about chips, accelerators, biology, or any one cohort
domain — they sit at the *substrate* layer.

### BookSim2 is different in two ways

1. **Domain-bound by construction.** BookSim2 is a NoC (network-on-chip)
   cycle-accurate simulator. It is the chip-domain absorption that
   rfc_001 explicitly scopes to hexa-arch[chip] first. Nothing in the
   surveyed Cohort 1 (cern · antimatter · rtsc · space · energy · brain)
   or Cohort 2 (fusion · scope · sscb · mobility · bot · grid · aura)
   has filed a request for NoC sim.
2. **Producer-of-exports, not language-level primitive.** Per Decision
   7, hexa-arch[chip] is the *producer* of the F1F2-record artifact
   consumed by comb. The producer naturally co-locates with the records
   it emits (`~/core/hexa-arch/exports/chip/noc/f1f2/`), and the sim
   engine that produces those records ought to live in the same repo to
   keep the audit chain `sim_commit_hash → emit_path → record` colocated
   inside one git history (rfc_002 §5 rationale).

### Recommendation: **A — land in hexa-arch local `stdlib/booksim/`**

The skeleton stubs in this RFC are written to
`~/core/hexa-arch/stdlib/booksim/`. This:

- honors Decision 7's producer-owned discipline (sim engine colocated
  with records);
- avoids cross-repo discipline friction (per `~/.claude/CLAUDE.md`
  edits to `~/core/hexa-lang/` must occur under that repo's own
  session) — no inbox-patches indirection needed;
- preserves the **promotion-when-second-consumer-appears** trigger that
  rfc_002 §5 already established for the export artifact. If `cern` or
  `grid` later asks for NoC sim, *both* the records *and* the engine
  promote upward — the absorption story stays consistent.

### Promotion criterion (deferred to a D8 gate the user owns)

Promote `stdlib/booksim/` from `hexa-arch/` to `hexa-lang/stdlib/booksim/`
when **either** of:

- a second consumer outside `comb` requests NoC sim (e.g. cern packet
  routing, grid mesh comms);
- a hexa-lang core change (e.g. discrete-event queue stdlib) makes the
  upstream home strictly cheaper.

Until then: hexa-arch local. **The user's D8 decision gate at landing
time pins this** (see §8 Q1).

### Rejected: B — absorb directly into hexa-lang now

Two reasons:

- it would invent the same fleet-wide responsibility that rfc_002 §5
  refused for the export artifact, on weaker grounds (no second
  consumer);
- it would force the entire absorption through hexa-lang's
  `inbox/patches/` pipeline (`hexa-lang/AGENTS.tape` g7), adding a
  multi-PR ceremony for code that exactly one consumer (comb) will
  exercise — andrej-karpathy simplicity violation.

---

## 3. Per-module interface design (6 modules + dispatcher)

All signatures use the hexa-lang conventions surveyed in
`stdlib/qrng/source.hexa` (struct shapes + `fn name_action(...)` style)
and `stdlib/mc_integrate/engine.hexa` (long-form engine modules). Error
discipline is rfc_048 raw-91: `ok: int` field on result structs (0/1) +
fatal `exit(91)` from the dispatcher when an unreachable/config-missing
condition is hit. **Silent skip is BANNED**.

### 3.1 `stdlib/booksim/anynet.hexa` — topology loader

Re-derives BookSim2 `src/networks/anynet.cpp:80-207` (the `_ComputeSize`
+ `_BuildNet` flow) + `doc/manual.tex §anynet` (file-format syntax). The
anynet file format is line-oriented:

```
router <id> [node <node_id>] [router <neighbor_id> <latency_cycles>]*
```

Per-line: declare one router, optionally connect a CPU/memory node,
optionally list outgoing router-to-router edges with per-edge latency in
cycles. Reverse-edge latencies are declared on the neighbor's own line.

```hexa
struct AnynetEdge {
    src:            int,      // router id
    dst:            int,      // router id
    latency_cycles: int,      // per-edge directional latency
}

struct AnynetNodeBind {
    router_id: int,
    node_id:   int,            // -1 if unbound
}

struct AnynetTopology {
    ok:          int,
    n_routers:   int,
    edges:       [AnynetEdge],
    nodes:       [AnynetNodeBind],
    max_degree:  int,           // observed; for cross-check vs config
    message:     str,
}

// Parse anynet file content (string) into a typed topology.
// Returns AnynetTopology{ok=0, message=...} on parse failure.
// CLEAN-ROOM: re-derives anynet.cpp:39-78 (read_config_file) +
//             anynet.cpp:80-131 (_ComputeSize line-parse).
fn anynet_parse(text: str) -> AnynetTopology { /* TBD */ }

// Load anynet file from path (calls stdlib/io::read_text + anynet_parse).
// Hard-exit 91 on file-not-found or parse-fail (raw-91 doctrine).
fn anynet_load(path: str) -> AnynetTopology { /* TBD */ }

// Echo back as a normalized line stream (for diff vs upstream output).
fn anynet_emit(t: AnynetTopology) -> str { /* TBD */ }
```

### 3.2 `stdlib/booksim/iq_router.hexa` — IQ-router pipeline

Re-derives `src/routers/iq_router.cpp:50-220` (constructor + 4-knob
delay configuration + `AddOutputChannel`'s `min_latency` formula at
line 214) and the pipeline phases at lines 219-300 (`ReadInputs`,
`_InternalStep`, `WriteOutputs`).

**Scope discipline**: we re-derive only the *delay model* and the
*input-queued switching abstraction*, not the iSLIP allocator
internals — for F1/F2 the iSLIP details are below the noise floor of a
wire-delay-dominated comparison. iSLIP is treated as a 1-cycle credit
that already lives inside `vc_alloc_delay + sw_alloc_delay`.

```hexa
struct IQRouterConfig {
    num_vcs:          int,      // canonical 8
    vc_buf_size:      int,      // canonical 8
    routing_delay:    int,      // canonical 0
    vc_alloc_delay:   int,      // canonical 1
    sw_alloc_delay:   int,      // canonical 1
    credit_delay:     int,      // canonical 2
    input_speedup:    int,      // canonical 2
    output_speedup:   int,      // canonical 1
    wait_for_tail_credit: int,  // canonical 1
}

// Zero-load min-latency per hop, given the pipeline knobs + channel
// latency. Re-derives iq_router.cpp:213-214 verbatim:
//   alloc_delay = vc_alloc_delay + sw_alloc_delay   // non-speculative path
//   min_latency = 1 + crossbar_delay + chan_lat + routing_delay
//               + alloc_delay + backchannel_lat + credit_delay
fn iq_router_min_latency_per_hop(
    cfg: IQRouterConfig, chan_lat: int, backchan_lat: int,
    crossbar_delay: int
) -> int { /* TBD */ }

// Default canonical IQRouterConfig as used in mesh88_uniform.cfg.
fn iq_router_default_config() -> IQRouterConfig { /* TBD */ }
```

### 3.3 `stdlib/booksim/traffic.hexa` — synthetic-traffic generators

Re-derives `src/traffic.cpp:380-396` (uniform), 230-250 (transpose),
289-308 (tornado).

```hexa
enum TrafficKind { UNIFORM, TRANSPOSE, TORNADO }

struct TrafficSpec {
    kind:  TrafficKind,
    k:     int,         // radix per dimension (e.g. 8 for an 8x8 mesh)
    n:     int,         // dimension count (e.g. 2 for a 2-D mesh)
    xr:    int,         // concentration; 1 unless cmesh
    seed:  int,         // RNG seed for uniform's per-call choice
}

// Pure functions: given source node id, return destination node id.
// Re-derives traffic.cpp:295-308 (tornado), 244-250 (transpose),
// 386-396 (uniform — wraps RandomInt = stdlib/qrng or LCG).
fn traffic_dest_uniform  (spec: TrafficSpec, source: int) -> int { /* TBD */ }
fn traffic_dest_transpose(spec: TrafficSpec, source: int) -> int { /* TBD */ }
fn traffic_dest_tornado  (spec: TrafficSpec, source: int) -> int { /* TBD */ }

// Generic dispatch — re-derives traffic.cpp:48-194 TrafficPattern::New.
fn traffic_dest(spec: TrafficSpec, source: int) -> int { /* TBD */ }
```

### 3.4 `stdlib/booksim/sweep.hexa` — latency-vs-injection + saturation

Re-derives `src/trafficmanager.cpp:1417-1610` (`_SingleSim` +
`Run` + the warmup/sample_period/max_samples convergence loop) and
the `Overall Traffic Statistics` aggregation block in the same file.

The discrete-event queue itself (event injection at each cycle, the
flit-and-credit packet circulation) is the load-bearing computation;
this RFC defines only the *control surface* of the sweep loop. The
event-queue inner loop lands in a sibling private helper module
`stdlib/booksim/_sim_step.hexa` in the bodies-landing RFC (deferred).

```hexa
struct SweepConfig {
    topology:        AnynetTopology,
    router_cfg:      IQRouterConfig,
    traffic:         TrafficSpec,
    packet_size:     int,            // canonical 20
    sample_period:   int,            // canonical 10000
    warmup_periods:  int,            // canonical 3
    max_samples:     int,            // canonical 8
    seed:            int,            // canonical 1
}

struct SweepPoint {
    injection_rate:     float,
    avg_packet_latency: float,       // cycles
    avg_network_latency:float,
    avg_flit_latency:   float,
    accepted_rate:      float,       // flits/node/cycle
    avg_hops:           float,
    saturated:          int,         // 0/1; 1 if 'Simulation unstable'
}

struct SweepCurve {
    ok:               int,
    points:           [SweepPoint],
    knee_rate:        float,          // saturation injection rate (3x ZLL)
    zero_load_lat:    float,          // ZLL from the lowest unsaturated point
    message:          str,
}

// Run one (topology, traffic, rate) — re-derives trafficmanager.cpp:1417
// _SingleSim convergence loop.
fn sweep_single_point(c: SweepConfig, rate: float) -> SweepPoint { /* TBD */ }

// Sweep an array of injection rates; classify knee as
//   first rate where avg_packet_latency >= 3 * zero-load
// per Dally & Towles, PPIN §25 (saturation definition).
fn sweep_curve(c: SweepConfig, rates: [float]) -> SweepCurve { /* TBD */ }
```

### 3.5 `stdlib/booksim/wire_delay.hexa` — per-link cycle latency

**New module — not a BookSim2 re-derivation, it is the rfc_001 §4
critical engineering addition.** BookSim2's default is 1 cycle per
link and BookSim2 itself has no wire-delay model. The model anchors on
SMART / OpenSMART literature, *not* on BookSim2 source.

```hexa
struct WireDelayProfile {
    node:          str,        // "22nm" | "7nm" | ...
    ps_per_mm:     float,      // e.g. 90.0 (SMART 22 nm)
    clk_ghz:       float,      // e.g. 4.0
    rc_exponent:   int,        // 1 (linear, repeated buffers) or 2 (raw RC)
    source_url:    str,
    source_doi:    str,
    extrapolation: str,        // "" if at-node, else basis like "SMART 22nm extrapolated to 7nm"
}

struct WireLink {
    src_router: int,
    dst_router: int,
    length_mm:  float,
}

struct WireLinkLatency {
    src_router:     int,
    dst_router:     int,
    length_mm:      float,
    latency_cycles: int,        // ceil(length_mm * ps_per_mm / T_ps), >=1
}

// Wire-delay rule: cycles = max(1, ceil( L * delta / T )).
// Re-derives the math from Krishna et al. 2013 SMART §3 and
// Kwon & Krishna 2017 OpenSMART §IV — NOT BookSim2.
fn wire_delay_link(p: WireDelayProfile, len_mm: float) -> int { /* TBD */ }

// Annotate a flat physical-link list with per-link cycle latency.
fn wire_delay_apply(
    p: WireDelayProfile, links: [WireLink]
) -> [WireLinkLatency] { /* TBD */ }

// Stitch back into an AnynetTopology so the sim consumes one typed bundle.
fn wire_delay_into_anynet(
    t: AnynetTopology, ll: [WireLinkLatency]
) -> AnynetTopology { /* TBD */ }

// Lookup a profile by canonical node name. Hard-exit 91 if unknown
// (rfc_001 §7.3 — missing wire-delay profile is unreachable, not silent skip).
fn wire_delay_profile_lookup(node: str) -> WireDelayProfile { /* TBD */ }
```

### 3.6 `stdlib/booksim/leighton.hexa` — analytic oracle

**New module — not BookSim2 re-derivation.** Re-derives the
Bhatt–Leighton bisection / diameter lower bounds for degree-d graphs
in a k×k or hex-axial layout from Leighton (1984) Thm 2 (DOI
10.1007/BF01744433) and Bhatt–Leighton (VLSI graph layout framework,
Semantic Scholar paper id 234cf578839121aa76f4c09d015f9cceb7be5cf0).

```hexa
enum RegionShape { K_BY_K, HEX_AXIAL_R }

struct LeightonInput {
    degree:       int,        // d (4, 6, ...)
    n_nodes:      int,
    region:       RegionShape,
    region_param: int,        // k for K_BY_K, R for HEX_AXIAL_R
}

struct LeightonBound {
    bisection_lower: int,     // analytic Bhatt-Leighton bisection lb
    diameter_lower:  int,     // analytic diameter lb
    derivation_cite: str,     // "Leighton 1984 Thm 2 (DOI ...) + Bhatt-Leighton ..."
}

struct LeightonOracle {
    ok:                int,
    pass:              int,   // 0/1 — observed satisfies bound
    bisection_bound:   int,
    bisection_observed:int,
    diameter_bound:    int,
    diameter_observed: int,
    message:           str,
}

// Compute analytic bounds.
// CLEAN-ROOM: Leighton 1984 Thm 2 + Bhatt-Leighton; NOT from BookSim2.
fn leighton_bounds(input: LeightonInput) -> LeightonBound { /* TBD */ }

// Compare observed sim metrics against bounds.
// Returns LeightonOracle{pass=0} on violation; caller exits 91 per
// rfc_001 §7.3 ("Leighton oracle violated — record MUST NOT be emitted").
fn leighton_check(
    input: LeightonInput, observed_bisection: int, observed_diameter: int
) -> LeightonOracle { /* TBD */ }
```

### 3.7 `stdlib/booksim/booksim.hexa` — dispatcher (entry point)

Single entry routed from `self/main.hexa else if sub == "booksim"`. CLI
surface mirrors rfc_001 §7.2 verbatim. Exit code policy: rfc_001 §7.3
(0 / 1 / 2 / 90 / 91).

```hexa
// hexa-arch booksim <subcmd> [...]
fn cmd_booksim(argv: [str]) -> int { /* TBD — dispatch table */ }

// subcommands:
//   topology load <file>
//   sweep --topology <file> --traffic <kind> --rate <a..b>
//   wire-delay --node <name> --topology <file>
//   oracle --degree <d> --bisection --diameter
//   measure --baseline degree-4 --candidate degree-6 --node <n> --traffic <t> --report <fmt>
//   --help, -h / --version, -v
//
// Each subcommand assembles the typed pipeline:
//   anynet_load -> wire_delay_apply -> sweep_curve -> leighton_check -> (emit)
```

---

## 4. Acceptance criterion (rfc_001 §8 reproduction target)

Agent-1's BookSim2 runs at `/tmp/hexa-arch-rfc001-measurement/runs/`
are the **reference output** the hexa-native re-derivation must
reproduce. The numerical tolerances below are stated as **absolute**
bands because the underlying RNG seed and floating math differ between
upstream C++ and the hexa re-derivation (different LCG state shape,
different round-trip on `accepted_rate`).

### §B target — 8×8 mesh uniform saturation ≈ 0.42

Reference: `runs/mesh88_uniform.out` — last unsaturated rate is
`0.40 → pkt_lat 269.66`, `0.45 → SATURATED`. The zero-load latency is
`~50.25` cycles (point at 0.05). Saturation knee per Dally & Towles
PPIN §25 = injection rate where `avg_packet_latency ≥ 3 × zero_load`
i.e. `≥ 150.75 cycles`. That occurs between 0.35 (141.0) and 0.40
(269.7).

**Acceptance**:

| metric | upstream | re-derivation must |
|---|---|---|
| zero-load latency @ rate=0.05 | 50.25 cyc | **within ±5%** (i.e. 47.7–52.8) |
| avg hops (~6.25 over all rates) | 6.25 | **within ±2%** (graph-deterministic) |
| saturation knee (3× ZLL crossing) | between 0.35 and 0.40 | **knee_rate ∈ [0.30, 0.45]** |
| pre-knee curve monotonicity | strictly increasing | **strictly increasing** (g3 sanity) |

### §D target — d=4 vs d=6 tornado headline numbers

Reference: `runs/d4_tornado.out` + `runs/d6_tornado.out`.

| topology | rate 0.05 pkt_lat | last unsat rate | hops @ 0.05 |
|---|---|---|---|
| d=4 mesh (`mesh_d4_anynet`) | 64.70 | 0.15 (400.99 → next sat) | 8.49 |
| d=6 hex (`hex_d6_anynet`)   | 57.40 | 0.19 (137.29)            | 7.14 |

**Acceptance**:

| metric | upstream | re-derivation must |
|---|---|---|
| d=4 zero-load @ 0.05 | 64.70 cyc | **within ±5%** (61.5–67.9) |
| d=6 zero-load @ 0.05 | 57.40 cyc | **within ±5%** (54.5–60.3) |
| d=6 saturates *later* than d=4 | last-unsat 0.19 vs 0.15 | **qualitative: d=6 last_unsat > d=4 last_unsat** (this is the rfc_001 F1 directional signal) |
| d=6 ZLL < d=4 ZLL @ 0.05, tornado | 57.4 < 64.7 (8.85 cyc gap, 13.7%) | **gap_cycles ≥ 5 cyc** (the directional inequality is the load-bearing claim, not the exact magnitude) |
| d=4 avg hops @ 0.05 | 8.49 | **within ±2%** |
| d=6 avg hops @ 0.05 | 7.14 | **within ±2%** |

### Leighton oracle PASS gate (rfc_001 §5)

For both topologies under both traffic patterns, `leighton_check` must
return `pass=1` — the analytic bisection / diameter lower bounds
must hold. If `pass=0`, the producer exits 91 and emits no record
(rfc_001 §7.3, rfc_002 §4 last row).

### Why these tolerances

- ±5% on latency: floating ops in cycle counting plus RNG-seed drift
  in `uniform` traffic give ~3-4% jitter even between two upstream
  re-runs at different `seed`. Doubling for cross-implementation
  margin = 5%.
- ±2% on hops: hops is a graph-shortest-path quantity, deterministic
  once routing is min-DOR. The remaining 2% covers any
  warmup-vs-steady-state weighting subtlety.
- Directional inequalities (`d=6 last_unsat > d=4 last_unsat`,
  `d=6 ZLL < d=4 ZLL`) are *qualitative gates*: the F1 falsifier in
  rfc_002 §1 depends on *direction*, not magnitude.

### Definition of GREEN

GREEN = **all four rows of §B + all six rows of §D + Leighton PASS for
both topologies**. Anything less = GATE_OPEN (`provenance.absorbed =
false` per rfc_002 §4). GATE_FAILED if any directional inequality
inverts (e.g. d=6 saturates *earlier* than d=4 — strong evidence the
re-derivation is wrong, not the theorem).

---

## 5. Clean-room provenance map

**Discipline (Decision 1)**: every re-derived line cites the BookSim2
file + line range it was derived from, by inspection only; no
copy-paste of upstream code, no transliteration of upstream identifiers
beyond what the spec (manual.tex) standardizes. License: BookSim2 is
BSD-2-Clause (Stanford 2007-2015) — see
`/tmp/hexa-arch-rfc001-measurement/booksim2/LICENSE.md`. Commit at
time of re-derivation = `28f43299f1706a3160ffac721ca461d74eb6e618`.

| module | re-derives from (BookSim2 path:lines) | cites (theorem / paper) |
|---|---|---|
| `anynet.hexa` | `src/networks/anynet.cpp:39-78` (config-file read), `:80-131` (`_ComputeSize`), `:133-207` (`_BuildNet`); `doc/manual.tex §anynet` (file-format BNF) | — (file-format spec only) |
| `iq_router.hexa` | `src/routers/iq_router.cpp:50-220` (constructor + 4 delay knobs + `AddOutputChannel:213-214` min-latency formula), `:219-300` (pipeline phase entry points); `doc/manual.tex §router_architecture` | Dally & Towles, *Principles and Practices of Interconnection Networks* (PPIN), Morgan Kaufmann 2004 §16 (IQ router definition), §25 (saturation) |
| `traffic.hexa` | `src/traffic.cpp:380-396` (uniform), `:230-250` (transpose), `:289-308` (tornado), `:48-194` (`TrafficPattern::New` dispatch) | Dally & Towles PPIN §3 (traffic-pattern taxonomy); tornado: Singh et al., "Goal" (2003) cited in BookSim2 manual |
| `sweep.hexa` | `src/trafficmanager.cpp:1417-1610` (`_SingleSim`, `Run`, convergence), `:954+` (`_Step`), overall-statistics aggregation block | Dally & Towles PPIN §25 ("3× zero-load latency" knee definition) |
| `wire_delay.hexa` | **NOT BookSim2 — BookSim2 has no wire-delay model.** Re-derives the cycles formula from external literature. | Krishna et al., "SMART: Single-cycle Multihop Asynchronous Repeated Traversal", CSAIL 2013 §3 (90 ps/mm @ 22 nm); Kwon & Krishna, "OpenSMART", ISPASS 2017 §IV (replicated number); generalization: `cycles = max(1, ceil(L * δ / T))` |
| `leighton.hexa` | **NOT BookSim2.** | Leighton, F. T., "New lower bound techniques for VLSI", *Math. Sys. Theory* 17 (1984), DOI [10.1007/BF01744433](https://doi.org/10.1007/BF01744433) Thm 2 (bisection lower bound for graphs in planar layout); Bhatt & Leighton, "A framework for solving VLSI graph layout problems" *J. Comp. Sys. Sci.* 28 (1984) (Semantic Scholar paper id `234cf578839121aa76f4c09d015f9cceb7be5cf0`); diameter bound: Moore graph argument, standard graph-theory result |
| `booksim.hexa` (dispatcher) | rfc_001 §7.2 CLI surface (this RFC family's own spec); rfc_047 §4 dispatcher pattern | — (governance citation only) |

Each `.hexa.stub` file (sibling deliverable) carries the same citation
table inline at top-of-file plus per-function `// CLEAN-ROOM` comments
keyed to the line range.

---

## 6. Hexa-lang facilities required — survey vs gap

Surveyed `~/core/hexa-lang/stdlib/` 2026-05-18:

| facility | exists? | path | suitable for our use? |
|---|---|---|---|
| dynamic arrays `[T]` | ✅ | language builtin | yes |
| maps / dicts | ✅ partial | `stdlib/collections.hexa` | yes for small maps; large topology adjacency may want better |
| structs + enums | ✅ | language builtin (see `stdlib/qrng/source.hexa`) | yes |
| integer / float math | ✅ | `stdlib/math.hexa`, `stdlib/core/math/` | yes |
| text file IO | ✅ | `stdlib/io.hexa` (`read_text`, `write_text`, `write_text_atomic`) | yes |
| line-oriented string split | ✅ | `stdlib/string.hexa` + `str.split` builtin | yes for anynet parser |
| integer parse | ✅ | `stdlib/core/parse.hexa` | yes |
| RNG (LCG / urandom) | ✅ | `stdlib/qrng/` (RFC 044) | yes — `traffic_dest_uniform` consumes `qrng_route_collect` or LCG seeded from `seed` |
| Monte Carlo / numerics | ✅ | `stdlib/mc_integrate/` (RFC 047) | not required for F1/F2 directly, but the `engine.hexa` is the structural template for `sweep.hexa` |
| JSON / YAML | ✅ partial | `stdlib/json.hexa`, `stdlib/yaml.hexa` | yes for report emission (machine-readable surfaces → eventually HXC per `g_hxc`) |
| HXC v2 wire codec | ✗ in hexa-arch | hexa-lang has it (`compiler/atlas/hxc_loader.hexa`) | **GAP for record emission** — see §8 Q3 |
| anynet key=value file parser | ✗ | — | **GAP — small ad-hoc parser inside `anynet.hexa`** (~50 LoC, line+space tokenized; not generic enough to promote upstream) |
| arena / pool allocator for discrete-event queue | ✗ in stdlib (allocators exist under `stdlib/alloc/` but not surveyed for fit) | `stdlib/alloc/` | **POSSIBLE GAP — needs spike** in the bodies-landing RFC to confirm the existing arenas are adequate for the per-flit pool |
| priority queue / min-heap | ✗ | — | **GAP — small inline heap inside `_sim_step.hexa`** (or stdlib promotion if a second user emerges) |
| time / monotonic clock | ✅ | `stdlib/time/` | yes (for wall-time only, not sim-cycle) |

### Gaps to flag explicitly

1. **Anynet parser** — file-format-specific. Embed in `anynet.hexa`,
   ~50 LoC. Do **not** promote to a generic `stdlib/parse/anynet`
   — single consumer = anti-promotion.
2. **HXC v2 emitter inside hexa-arch** — already deferred by rfc_002
   §9. Pre-GREEN: emit `F1F2-record` as JSON via `stdlib/json.hexa`
   and let `comb` parse JSON; flip to HXC when the tool lands (§8 Q3).
3. **Min-heap for the discrete-event queue** — embed inside the
   private `_sim_step.hexa` helper. Promotion to `stdlib/heap` happens
   when the second user appears.
4. **Allocator fit for per-flit pool** — needs a 1-day spike during
   bodies landing; if existing `stdlib/alloc/` doesn't fit, fall back
   to plain `[Flit]` arrays with a free-list `[int]` (no language
   change required).

**Net assessment**: no hexa-lang core/language change is forced by this
absorption. Everything we need either already exists in `stdlib/`,
embeds privately inside `stdlib/booksim/`, or is a deferred (rfc_002
§9) tool.

---

## 7. Phased landing plan — minimum-viable path to GREEN

Phases land as separate commits / RFCs under the chosen location (§2:
recommend hexa-arch local). Each phase has its own falsifier set in
the rfc_001 §7.3 exit-code style; a phase passes only when all
falsifiers return 0.

### Phase A — skeleton (this RFC)

- Land this RFC.
- Land `stdlib/booksim/{anynet,iq_router,traffic,sweep,wire_delay,leighton,booksim}.hexa.stub`
  (sibling deliverable — signatures only, TBD bodies that `exit(91)`
  per raw-91 doctrine).
- Land `stdlib/booksim/README.md` module index.
- **Falsifier A1**: every stub `--help` returns exit 91 with a
  TBD-body sentinel. (proves the dispatcher routes, but no claims.)

### Phase B — anynet + iq_router + uniform-traffic + sweep ("8×8 mesh uniform")

- Implement `anynet_parse` / `anynet_load` body.
- Implement `iq_router_min_latency_per_hop` body (closed-form, no
  simulation needed — exercises rfc_001 §B partially).
- Implement `traffic_dest_uniform` body (depends on `stdlib/qrng` or
  LCG — pick deterministic seed path).
- Implement `sweep_single_point` + `sweep_curve` bodies, with the
  discrete-event inner step in a private `_sim_step.hexa` helper.
- **Falsifier B1**: load `runs/mesh_d4_anynet`, parse, echo back
  byte-identical (modulo whitespace) — proves anynet round-trip.
- **Falsifier B2 (the §B gate)**: sweep `mesh88_uniform` at rates
  [0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45, 0.50] and
  satisfy all four rows of §4 §B acceptance.

### Phase C — wire_delay (the rfc_001 §4 critical addition)

- Implement `wire_delay_link`, `wire_delay_apply`, `wire_delay_into_anynet`.
- Implement `wire_delay_profile_lookup` with at least two profiles:
  `22nm` (SMART) + `7nm` (extrapolated, flagged in `extrapolation`).
- **Falsifier C1**: reproduce `gen_topologies.py` numerics — at
  `δ=90 ps/mm`, `T=250 ps @ 4 GHz`, `length=2.5 mm`: cycles=1; at
  `length=3.536 mm`: cycles=2.

### Phase D — leighton oracle

- Implement `leighton_bounds` + `leighton_check`.
- **Falsifier D1**: for 8×8 mesh degree-4, the bisection bound must be
  consistent with the standard k=8 mesh bisection (= 8). The d=6 hex
  region has a tabulated bound that must be reproduced from the cited
  formula.

### Phase E — tornado + sweep validation ("d=4 vs d=6 tornado")

- Implement `traffic_dest_tornado` + `traffic_dest_transpose` bodies.
- Wire the `measure` dispatcher subcommand end-to-end (anynet →
  wire_delay → sweep → leighton_check → JSON report).
- **Falsifier E1 (the §D gate)**: reproduce `d4_tornado.out` +
  `d6_tornado.out` within §4 §D tolerance bands.

### Phase F — F1F2-record emission

- Implement the dispatcher's `measure --report json` path emitting the
  rfc_002 §3 schema as JSON (HXC deferred, §8 Q3).
- Write the first record into `~/core/hexa-arch/exports/chip/noc/f1f2/
  records/`.
- Flip `provenance.absorbed = true` retroactively for prior records
  per rfc_002 §8.
- **Falsifier F1**: emitted record validates against `exports/chip/
  noc/f1f2/schema/v1_0.md` schema (all required fields present,
  enums in range).

### Phase G — `comb` consumption (cross-repo, separate session)

Deferred to a hexa-lang session (`~/.claude/CLAUDE.md` cross-repo
discipline). Out of scope here.

### Critical path

A → B → C → E → F is the **GREEN-gate critical path** (5 phases). D
(leighton oracle) runs in parallel with C/E and only gates F (record
emission won't fire without Leighton PASS). Total: 5 sequential
phase-landings, each smaller than the qrng / mc_integrate absorptions
that succeeded under rfc_044/rfc_047.

---

## 8. Open questions (D8/D9 user-decision-gate)

### Q1 — landing location (decision gate)

This RFC recommends **hexa-arch local `stdlib/booksim/`** (§2). The
alternative (absorb into `hexa-lang/stdlib/booksim/` immediately) is
viable but loses Decision 7 colocation and forces the
`hexa-lang/inbox/patches/` pipeline. **User picks at landing time.**

### Q2 — HXC tool prerequisite

rfc_002 §9 defers the HXC v2 emitter tool inside hexa-arch "until the
hexa-native re-derivation of rfc_001 §7 exists". This RFC *is* that
re-derivation. So: should Phase F's JSON-only path be a permanent
fallback, or is the HXC tool gated to land before Phase F (blocking)
or after (additive MINOR semver bump)?

**Recommendation**: JSON-only for Phase F (un-blocking); HXC emitter
lands as the first **post-GREEN** scope-extension RFC. The schema's
HXC canonicalisation deterministically derives from the JSON shape per
HXC A1-A12; consumers re-derive `record_id` identically either way.

### Q3 — second-consumer promotion trigger (parallel to rfc_002 §5)

When (if ever) a second consumer beyond comb appears, both the
**records** (per rfc_002 §5) and **the engine** (this RFC §2) promote
upward together. Recommend documenting this dual-promotion in
`ARCH.tape` as a `@D` decision when the trigger event happens, not
preemptively.

### Q4 — discrete-event queue substrate

This RFC defers the inner-loop substrate decision (private
`_sim_step.hexa` with embedded min-heap + per-flit pool) to the bodies
RFC. The spike at Phase B start needs ~1 day to confirm `stdlib/alloc/`
fits or to settle on a free-list-array fallback. **Not a blocker for
this RFC's landing.**

### Q5 — F2 (place-and-route overhead) scope

This RFC closes F1 (wire-delay net gain). F2 (P&R overhead at ≤7 nm
≥ UC Davis VCL 65 nm 2012 band) needs a *physical-design* absorption
(OpenROAD or comparable) that is far outside BookSim2's reach. **Out
of scope; will be a separate rfc_004 once F1 lands.**

---

## 9. References (Decision 1 public-surface only)

- BookSim2: <https://github.com/booksim/booksim2>, commit
  `28f43299f1706a3160ffac721ca461d74eb6e618`,
  BSD-2-Clause (Stanford 2007-2015).
- `doc/manual.tex` (BookSim2 manual) — §anynet, §router_architecture.
- Dally, W. J. & Towles, B., *Principles and Practices of
  Interconnection Networks*, Morgan Kaufmann 2004 (PPIN).
- Krishna, T. et al., "SMART: A Single-Cycle Reconfigurable NoC for
  SoC Applications", CSAIL 2013 — wire-delay 90 ps/mm @ 22 nm.
- Kwon, H. & Krishna, T., "OpenSMART", ISPASS 2017.
- Leighton, F. T., "New lower bound techniques for VLSI", *Math.
  Systems Theory* 17 (1984), DOI [10.1007/BF01744433](https://doi.org/10.1007/BF01744433).
- Bhatt, S. N. & Leighton, F. T., "A framework for solving VLSI graph
  layout problems", *J. Comp. Sys. Sci.* 28 (1984).
- hexa-lang governance: `~/core/hexa-lang/AGENTS.tape` §3 g_hxc,
  g_inbox_dual_track; rfc_047 (mc_integrate absorption), rfc_048
  (xeno absorption — raw-91 doctrine).
- hexa-arch governance: `CHARTER.md`, `design.md` D1/D5/D7,
  `proposals/rfc_001_booksim2_noc_absorption.md`,
  `proposals/rfc_002_f1f2_export_interface.md`.

---

**Co-author**: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
