# RFC 002 — F1/F2 export interface (`hexa-arch[chip] → comb`)

> Status: **draft** · Created: 2026-05-18 · Source decisions: `design.md`
> Decision 1 (public-surface clean-room), Decision 2 (typed-interface,
> not absorb), Decision 5 (7-verb spine), Decision 7 (producer-owned
> export path).
> Pattern: producer-side RFC defining the typed-interface contract that
> `proposals/rfc_001_booksim2_noc_absorption.md` (the producer) emits,
> per HANDOFF §7 "one absorption-RFC per concept" (rfc_001 = producer,
> rfc_002 = contract).
> Authoring: drafted by Agent-2 (public-surface clean-room research per
> Decision 1); verbatim-leaning landing of the agent's design.

---

## 1. What `comb` actually consumes (F1/F2 inputs)

Source: `~/core/hexa-lang/comb/RFC.md` §5 (Falsifiers) + `comb/
T1_experiment.md` §F1/F2-operationalized + `comb/T1A_analytical.md` §3
("승리 부등식"). (RFC 057 location note: the canonical RFC lives at
`comb/RFC.md`, **not** under `hexa-lang/proposals/`; see `design.md`
post-D7 note.)

The question `comb` asks — given the two topologies pinned in T1A §1
(degree-4 2-D mesh on a k×k rectangular region vs degree-6 hex axial on a
hex region of radius R), does the *cost side* of the inequality

```
(D_mesh − D_hex) · Ē_hop   >   Δ_router + Δ_wire,diag
        ─── LHS ───              ─────── RHS ───────
   graph-constants fixed         process- / placement-dependent
   (T1-A complete)               (requires hexa-arch[chip] sim)
```

resolve in degree-6's favour at modern node, after EDA cost.

- **F1 falsified iff** ≤ 7 nm wire model yields net energy / latency
  gain ≤ 0 after router port-area cost is subtracted.
- **F2 falsified iff** hex P&R overhead at ≤ 7 nm ≥ the UC Davis VCL
  65 nm 2012 gain band (−17 ~ −21 % power / area / wire-distance).

What `comb` therefore needs from hexa-arch[chip] is the **RHS** of the
inequality, as measured quantities under a shared topology spec and the
synthetic load set comb pre-registered:

| input class | requirement | granularity |
|---|---|---|
| topology agreement | identical degree-4 mesh + degree-6 hex axial specs (coords, neighbours, boundary, routing) — comb supplies, hexa-arch consumes | per-run |
| wire-delay model parameters | per-link cycle latency from physical wire length × public-literature wire-delay-per-mm at named modern node | per-link |
| router cost model | port-area / port-energy as a function of degree d | per-degree |
| latency curve | avg packet latency vs injection rate (canonical NoC sweep) | per-(topology, traffic, node) |
| saturation throughput | the knee / saturation-injection-rate of the curve | scalar per run |
| Leighton oracle status | PASS / FAIL — sim's bisection / diameter satisfy Bhatt–Leighton bounds | gate boolean |
| F1/F2 verdict | derived: pass / fail / inconclusive (under "absorbed" measurement gate) | enum |

Three-tier mapping (HANDOFF §6): **T1** = this interface alone resolves
F1/F2; **T2** = same interface extended with workload traces (later RFC);
**T3** = extended again with tapeout-ready GDS handoff (later RFC). This
RFC covers T1 only.

---

## 2. What hexa-arch[chip] / rfc_001 produces

Source: `proposals/rfc_001_booksim2_noc_absorption.md` §3, §4, §7.1, §8.

| produced artifact | source module (planned) | shape |
|---|---|---|
| `anynet` topology echo-back | `stdlib/booksim/anynet.hexa` | typed topology record (nodes, edges with per-link length & latency) |
| 4-delay-knob IQ-router config | `stdlib/booksim/iq_router.hexa` | `(routing_delay, vc_alloc_delay, sw_alloc_delay, credit_delay)` |
| synthetic traffic injection | `stdlib/booksim/traffic.hexa` | enum `{uniform, transpose, tornado}` + rate sweep range |
| latency-vs-injection curve | `stdlib/booksim/sweep.hexa` | array of `(injection_rate, avg_packet_latency_cycles)` |
| saturation throughput point | `stdlib/booksim/sweep.hexa` | scalar (`injection_rate` at knee) |
| per-link wire-delay derivation | `stdlib/booksim/wire_delay.hexa` | per-link `(length_mm, latency_cycles)` + `(node, ps_per_mm)` source cite |
| Leighton oracle PASS/FAIL | `stdlib/booksim/leighton.hexa` | bool + `(bound_value, observed_value)` tuple per metric |
| measurement-gate status | (rfc_001 §8) | enum `{GATE_OPEN, GATE_CLOSED_MEASURED, GATE_FAILED}` |
| topology metadata | (rfc_001 §7.1) | `(kind, degree, node_count, region_shape, routing_policy)` |

Output integrity is enforced by the rfc_001 §7.3 exit codes (`0 / 1 / 2
/ 90 gate-not-satisfied / 91 oracle-violated`). A sim run that violates
the Leighton oracle exits 91 — the artifact **must not** be emitted as a
valid record.

---

## 3. Schema (v1.0 draft)

### Carrier format

**HXC v2 byte-canonical wire (machine side) + tape v1.2 (audit side).**
Both are forced by hexa-lang governance — not new policy:

- hexa-lang `CLAUDE.md` §3 `@D g_hxc`: "Machine-readable surfaces
  (JSON / JSONL / config-blob streams) emit / consume via HXC v2
  byte-canonical wire format." → the data artifact is HXC.
- hexa-lang `CLAUDE.md` §3 `@D g_arch_vs_log_split` + tape v1.2 grammar
  primer → the *event* of producing the artifact gets a `.log.tape`
  entry in both repos for the audit trail.

This satisfies CHARTER "hexa-native-only" / `design.md` D5 — no Python,
no shell-out, no third-party serializer.

### Schema (rendered as JSON for human read; wire form = HXC A1-A35 canonicalisation of the same key set)

```jsonc
// type: hexa-arch:chip:noc:F1F2-record  (interface name)
// schema_version: "1.0"  // see §6
{
  "interface": "hexa-arch:chip:noc:F1F2-record",
  "schema_version": "1.0",
  "record_id": "<content-hash of body, HXC A12-canon hex>",
  "produced_at_utc": "2026-05-18T00:00:00Z",

  // ─── topology (echo of consumer's request — verifiable round-trip) ─
  "topology": {
    "kind": "hex_axial",              // {"mesh_2d", "hex_axial"}
    "degree": 6,                       // 4 | 6
    "node_count": 169,                 // e.g. hex region R=7 → 3·49+3·7+1
    "region_shape": "hex_radius_7",    // {"k_by_k", "hex_radius_R"}
    "routing": "hex_dimension_order",
    "boundary": "brick_offset_rows",   // axis_b_topology.md
    "coord_kind": "axial_qr"           // {"xy", "axial_qr"}
  },

  // ─── per-link wire model (rfc_001 §4 — the load-bearing addition) ──
  "wire_delay_model": {
    "node": "7nm",                     // operationalised "modern node"
    "ps_per_mm": 500,                  // e.g. SMART (Krishna 2013) at 2 GHz
    "cycle_period_ps": 500,
    "rc_exponent": 2,                  // RC delay ∝ L²
    "source_citations": ["@x_smart_ispass17", "@x_smart_csail_2013"],
    "links": [
      // index aligned with topology edge list
      { "src": 0, "dst": 1,  "length_mm": 0.50, "latency_cycles": 1 },
      { "src": 0, "dst": 14, "length_mm": 0.87, "latency_cycles": 2 }
      // ... one entry per physical link
    ]
  },

  // ─── router cost model (degree-dependent) ─────────────────────────
  "router_cost": {
    "port_area_norm": 1.50,            // d=6/d=4 ≈ 1.5× (T1A §2)
    "port_energy_norm": 1.50,
    "iq_pipeline": {
      "routing_delay": 1,
      "vc_alloc_delay": 1,
      "sw_alloc_delay": 1,
      "credit_delay": 1
    },
    "source_citations": ["@x_dally_towles_2004", "@x_leighton_1992"]
  },

  // ─── measurement outputs (the actual sim products) ────────────────
  "traffic": "tornado",                // {"uniform", "transpose", "tornado"}
  "latency_curve": [
    { "injection_rate": 0.05, "avg_latency_cycles": 12.4 },
    { "injection_rate": 0.10, "avg_latency_cycles": 13.1 }
    // ...
  ],
  "saturation_throughput": {
    "injection_rate_at_knee": 0.32,
    "knee_definition": "3x_zero_load_latency"   // Dally & Towles 2004
  },

  // ─── Leighton oracle (rfc_001 §5 — the no-over-claim gate g3) ─────
  "leighton_oracle": {
    "status": "PASS",                  // {"PASS", "FAIL"}
    "bisection_bound": 13,
    "bisection_observed": 13,
    "diameter_bound": 14,
    "diameter_observed": 14,
    "source_citation": "@x_leighton_1992_doi_10.1007_BF01744433"
  },

  // ─── F1/F2 verdict (derived; comb consumes this directly) ─────────
  "verdict": {
    "f1": "INCONCLUSIVE",              // {"PASS", "FAIL", "INCONCLUSIVE"}
    "f2": "INCONCLUSIVE",
    "rationale": "single-topology record; comb composes a baseline+candidate pair to verdict"
  },

  // ─── provenance (no-over-claim — see §4) ──────────────────────────
  "provenance": { /* see §4 */ }
}
```

### Pair-record convention

A single record describes **one (topology, traffic, node) run**. F1/F2
verdict is derived by `comb` from **two records** sharing identical
`{ traffic, node, schema_version, wire_delay_model.node,
wire_delay_model.ps_per_mm }` but differing in `topology.degree`. The
schema reserves `verdict.f1/f2` to hold the *pair-level* verdict when an
aggregator writes a derived record (field `interface = "hexa-arch:chip:
noc:F1F2-pair-verdict"` for the aggregate; same provenance discipline).

### Concrete example — degree-6 hex region R=7, tornado, 7 nm

A worked example record is provided at `~/core/hexa-arch/exports/chip/
noc/f1f2/schema/v1_0.md` §B (the schema's own example block).

---

## 4. Provenance / no-over-claim required fields

All required, all checked by the producer before emitting the record
(rfc_001 §7.3 exit 90 if any missing):

| field | type | enforced by | purpose |
|---|---|---|---|
| `provenance.absorbed` | bool | rfc_001 §8 measurement gate | `true` only after BookSim2 reproduction of published 8×8 mesh curve within stated error AND degree-4/6 wire-delay-injected curves filed in `hexa-arch/PLAN.md`. Otherwise `false`. |
| `provenance.sim_engine` | string | producer | module path within hexa-arch (e.g. `hexa-arch:stdlib/booksim`) |
| `provenance.sim_commit_hash` | string | producer | git short-sha of hexa-arch HEAD that produced the record |
| `provenance.wire_delay_source` | object | rfc_001 §4 | `{doi_or_url, node_basis}`; extrapolation MUST be flagged in `node_basis` (e.g. "SMART 22nm extrapolated to 7nm") |
| `provenance.leighton_source` | object | rfc_001 §5 | Bhatt–Leighton DOI / Springer edition |
| `provenance.measurement_gate` | enum | rfc_001 §8 | `GATE_OPEN` (no claim) · `GATE_CLOSED_MEASURED` (parity reproduced) · `GATE_FAILED` |
| `provenance.gate_failures` | string[] | producer | list of specific gate failures if any (empty when GATE_OPEN with no errors, or GATE_CLOSED_MEASURED) |
| `provenance.consumer_target` | string | producer | e.g. `hexa-lang:comb:RFC_057:F1F2` — names the consumer this record is shaped for |
| `provenance.atlas_cite_block` | string | hexa-lang g6 mirror | `@cite`-style references comb's citation-enforced strict-lint stage 4 can validate |
| `leighton_oracle.status` | enum | rfc_001 §7.3 exit 91 | If `FAIL`, record MUST NOT be emitted as valid; producer exits 91 |

Repo-governance alignment:

- `design.md` D1 (public-surface clean-room) — every cited source in
  `provenance.*` MUST be a public-surface citation; closed-binary refs
  banned.
- `design.md` D2 (typed-interface, not absorption) — `consumer_target`
  is the explicit type carrier; one schema = one consumer contract.
- CHARTER non-goals — `provenance.absorbed: false` is the *default* shape
  until the measurement gate closes; SKIP-mode bait disallowed.
- hexa-lang `CLAUDE.md` g3 (verification-anchor-real-limit) — the
  Leighton bound is a *real-limit* anchor; `leighton_oracle.status` is
  the per-record embodiment of g3 for this interface.

---

## 5. Path convention (producer-owned per Decision 7)

```
~/core/hexa-arch/
  exports/
    chip/
      noc/
        f1f2/
          schema/
            v1_0.hxc            # HXC v2 canonical schema (machine)
            v1_0.md             # human-readable schema doc (this RFC §3)
          records/
            <record_id>.hxc     # one per (topology, traffic, node) run
          pair_verdicts/
            <pair_id>.hxc       # derived F1/F2 verdicts
          index.tape            # @L entries; one @N per record_id
```

Consumer side (comb) reads by absolute path; no symlink, no copy:

```
~/core/hexa-lang/comb/T1_experiment.md  ←  cites
   ~/core/hexa-arch/exports/chip/noc/f1f2/records/<id>.hxc
```

Atlas promotion (`~/core/atlas/hexa-arch::chip::noc::f1f2/`) is **deferred
until a second consumer beyond comb materializes** (e.g. cern / grid
wanting noc records). Until then, atlas promotion is speculative scope
banned by lattice-as-tool g1/g2/g3 + andrej-karpathy simplicity
(`design.md` D7 rationale).

---

## 6. Versioning

| component | rule |
|---|---|
| `schema_version` | semver MAJOR.MINOR (e.g. "1.0"); MAJOR = breaking, MINOR = additive. PATCH not used. |
| `record_id` | HXC A12 — content-addressed hex digest of body excluding `record_id` itself |
| `produced_at_utc` | ISO-8601 wall-time (informational; not used for equality) |
| `provenance.sim_commit_hash` | git short-sha; pairs the record to a *concrete* hexa-arch source commit |

Semver bump rules:

- **MAJOR** — field removal, rename, change of unit, change to the
  `verdict` enum's PASS/FAIL semantics. Breaks downstream readers.
- **MINOR** — additive field (e.g. new optional `power_curve` later), new
  enum value (e.g. `traffic = "bit_reverse"`). Old consumers keep working.
- **PATCH** — not used; document-level fixes go via comb's read-only
  consumption (it re-derives `record_id` and notices content change).

Compatibility window: producer emits at most one schema version per
record; producer maintains schema files for the last two MAJOR versions
in `exports/.../schema/` so in-flight consumers can pin.

---

## 7. Cross-repo landing path

### hexa-arch side (this repo — landed in this commit + adjacent)

1. `proposals/rfc_001_booksim2_noc_absorption.md` — add §11 pointer to
   this RFC. ✓ (landed alongside)
2. `proposals/rfc_002_f1f2_export_interface.md` — this file. ✓
3. `exports/chip/noc/f1f2/schema/v1_0.md` — human-readable schema doc. ✓
4. `exports/chip/noc/f1f2/schema/v1_0.hxc` — HXC v2 canonicalisation
   (deferred — generated when the hexa-arch HXC tool exists).
5. `PLAN.md` — appended progress-log entry.
6. `ARCH.tape` — appended `@D` entry for the typed-interface contract.

### hexa-lang side (separate repo — DEFERRED to a hexa-lang session)

Per `~/.claude/CLAUDE.md` cross-repo discipline, edits to `~/core/
hexa-lang/` must occur in a session under that repo's own AGENTS.md
governance. Pending list (citation-only updates — no governance change):

7. `comb/T1_experiment.md` — replace pseudocode interface block with a
   *cited reference* to this RFC's §3 schema doc.
8. `comb/T1A_analytical.md` — append §8 "T1-B input contract" pointing
   to the same schema doc.
9. `comb/sim/README.md` — append a *T1-B-full input expectation*
   subsection: comb's harness reads HXC records from the absolute path
   in §5.
10. `comb/COMB.tape` — `@X` external-citation entry pointing to the
    hexa-arch schema.
11. `comb/PLAN.md` — append entry when first F1/F2 pair-verdict record
    is read.

### Not touched

- `~/core/hexa-lang/proposals/` — no new `rfc_057_*` file. RFC 057's
  own header chose comb-local SSOT; this RFC respects that.
- `~/core/hexa-lang/CLAUDE.md` / `AGENTS.tape` — no governance change
  needed; `g_hxc` already covers machine-readable wire format and
  `g7 inbox-patches-pipeline` doesn't apply (sibling-read, not upstream
  edit).
- `~/core/hexa-chip` — distinct repo (HANDOFF §8); out of scope.
- `~/core/atlas/` — promotion deferred until a second consumer (§5).

---

## 8. Measurement-gate coupling (rfc_001 §8 ↔ this RFC)

`provenance.absorbed = false` until rfc_001 §8 measurement gate closes.
Records emitted before the gate closes are *capture-only*, **not**
"absorbed at measured parity" claims. The gate-closed flip is the single
atomic event that upgrades all prior-emitted records' `provenance.
absorbed` from `false` to `true` retroactively (via re-emission with the
same `record_id` content-hash if input unchanged; semver MAJOR-equivalent
event in audit terms).

---

## 9. Open / deferred

- HXC v2 generation tool inside hexa-arch (for emitting
  `schema/v1_0.hxc`) — deferred until the hexa-native re-derivation of
  rfc_001 §7 exists; until then the human-readable `v1_0.md` is the
  reference and consumers may parse the equivalent JSON.
- First worked-example record (degree-6 hex R=7 + degree-4 mesh 8×8,
  tornado, 7 nm) — pending Agent-1 rfc_001 §8 baseline measurement
  output (background; alone enough to populate the first records).
- hexa-lang-side citation patches (§7 items 7-11) — separate session.
