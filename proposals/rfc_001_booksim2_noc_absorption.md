# RFC 001 — BookSim2 NoC absorption

> Status: **draft** · Created: 2026-05-18 · Source decisions: `design.md`
> Decision 1 (공개면 클린룸 research boundary), Decision 5 (7-verb spine).
> Pattern mirror: `hexa-lang/proposals/rfc_047_mc_integrate`,
> `rfc_048_xeno`.

## 1. Purpose

Absorb the minimal subset of **BookSim2** (the field-reference NoC
cycle-accurate simulator) into hexa-arch[chip] under the 7-verb spine's
**해석 ANALYZE** stage (system-cycle sub-verb). The goal is unblocking
hexa-lang `comb` RFC 057 falsifiers **F1/F2** — answering whether
degree-6 outperforms degree-4 at a modern process node under
wire-delay-dominated conditions.

## 2. Why BookSim2 (not gem5-Garnet)

Per the Decision 1 public-surface clean-room survey of both, BookSim2
wins this absorption on three measured axes:

- **Accuracy reference status** — "highly accurate vs RTL router
  implementation"; gem5-Garnet and others are validated *against* it
  (BST, ISPASS'20). gem5-Garnet trace-mode error reportedly up to
  14.97 % vs dependency-aware paths ≤ 3.22 % (ACM
  10.1145/2994133.2994140).
- **Right scope, no full-system tax** — F1/F2 is a topology-degree
  latency/bisection question under synthetic load, not a workload-driven
  full-system question; gem5-Garnet's Ruby full-system machinery is
  unneeded cost ("can't do millions of cycles fast", gem5.org).
- **Topology expressiveness** — `anynet` cleanly expresses both
  degree-4 baselines (2-D mesh/torus) and degree-6 candidates (e.g.
  hexagonal) via a user-supplied connectivity file
  (booksim2 `manual.tex`).

## 3. Minimal absorbed subset

| Component | Purpose |
|---|---|
| `anynet` topology loader | degree-4 baseline + degree-6 candidate connectivity files |
| IQ-router pipeline + VC + credit | the 4-stage `routing_delay` / `vc_alloc_delay` / `sw_alloc_delay` / `credit_delay` |
| Synthetic traffic | `uniform` + `transpose` + `tornado` (adversarial-bisection stressor) |
| Measurement loop | latency-vs-injection-rate curve, saturation-throughput point |
| **Per-link wire-delay model** | **see §4 — the critical addition** |
| Leighton analytic oracle | bisection / diameter bound as f(degree); sim results must agree-in-bound (see §5) |

## 4. Critical engineering risk — per-link wire-delay model

**Neither BookSim2 nor gem5-Garnet models physical wire RC.** BookSim2's
default per-link latency is **1 cycle, set in source**; gem5-Garnet
exposes it as a per-link/CLI knob but still uses abstract cycle latency
(gem5.org garnet-2; booksim2 `manual.tex`).

This is fatal for F1/F2 as posed: the degree-6 vs degree-4 answer
**hinges on wire length**, since higher degree shortens hop count but
*lengthens physical wires and grows bisection wiring* (Bhatt–Leighton
VLSI graph layout; Leighton DOI 10.1007/BF01744433; Slim NoC
arXiv:2010.10683). At modern nodes the regime is wire-delay-dominated:
SMART / OpenSMART (ISPASS'17) reports achievable hops-per-cycle drops
14 → 7 post-layout @ 1 GHz purely from wire delay; wire delay ≈ 500 ps
@ 2 GHz cycle (people.csail.mit.edu/suvinay 2013.smart).

**Engineering plan**:

1. Operationalize "modern node" as a wire-delay-per-mm number sourced
   from public literature (SMART / Leighton-class) — the in-scope open
   PDKs (SkyWater SKY130, IHP SG13G2) are both 130 nm and do **not**
   supply a modern-node interconnect model.
2. Compute per-link physical length from each candidate topology's
   floorplan placement; convert to per-link cycle latency via the
   wire-delay model.
3. Inject into BookSim2 as per-link latency overrides on the `anynet`
   input.

This step is the absorption's **largest fidelity risk** and the primary
engineering deliverable. State it as such — no over-claim of F1/F2
resolution until this loop is closed.

## 5. Cross-check: Leighton analytic oracle

The simulator's claims must satisfy the analytic degree-d bisection /
diameter bounds (Bhatt–Leighton) as inequality cross-checks. If sim
output violates the bound, the run is rejected — the sim is wrong, not
the theorem. This is the no-over-claim gate (g3) for this absorption.

## 6. Out of scope (deferred / refused)

- closed-binary reverse engineering of any proprietary NoC simulator
  (`design.md` Decision 1).
- 3-D NoC / heterogeneous-3D (Ratatoskr's niche) — F1/F2 is 2-D first.
- Power modeling (Noxim / PAT-Noxim niche) — area/latency first.
- Full-system workload (gem5 niche) — synthetic load is the question.

## 7. Hexa-native binding plan

Pattern mirror: `hexa-lang/proposals/rfc_047_mc_integrate_absorption.md`
§3-§4. Engine + dispatcher split, hexa CLI integration, fail-loud exit
codes (rfc_048 §3 raw-91 doctrine). **Diff from rfc_047**: BookSim2
upstream is C++ (not already hexa) — under Decision 1 (public-surface
clean-room) the engine is **re-derived in hexa** from BookSim2's public
spec (`doc/manual.tex`) plus the open-source code, not a wrapper, not a
shell-out (CHARTER hexa-native-only).

### 7.1 Engine / dispatcher split (rfc_047 §3 mirror)

| Source (BookSim2 public surface) | Absorbed (hexa-native) |
|---|---|
| `src/networks/anynet.cpp` + `manual.tex` §anynet | `stdlib/booksim/anynet.hexa` — topology loader (clean-room re-derived) |
| IQ-router pipeline + VC + credit | `stdlib/booksim/iq_router.hexa` — 4-delay-knob pipeline |
| Synthetic-traffic generators | `stdlib/booksim/traffic.hexa` — `uniform`, `transpose`, `tornado` |
| Measurement / sweep loop | `stdlib/booksim/sweep.hexa` — latency-vs-injection + saturation |
| **(new — this RFC)** wire-delay model | `stdlib/booksim/wire_delay.hexa` — per-link cycle latency from physical length × public node δ (SMART/Leighton lit.) |
| **(new — this RFC)** Leighton oracle | `stdlib/booksim/leighton.hexa` — analytic degree-d bisection / diameter bound; sim runs must respect (g3 gate) |

Engine modules are **pure hexa** (no Python, no shell-out, no FFI to
upstream C++). Dispatcher = `stdlib/booksim/booksim.hexa` — single entry
point routed from `self/main.hexa` `else if sub == "booksim"` branch.

### 7.2 CLI surface (hexa-arch[chip] entry point)

```sh
hexa-arch booksim                       # default = help
hexa-arch booksim topology load <file>  # anynet topology file → typed
hexa-arch booksim sweep --topology <f> --traffic uniform --rate 0.05..0.5
hexa-arch booksim wire-delay --node 22nm --topology <f>
hexa-arch booksim oracle --degree 6 --bisection --diameter
hexa-arch booksim measure --baseline degree-4 --candidate degree-6 \
                          --node 22nm --traffic tornado --report json
hexa-arch booksim --help, -h / --version, -v
```

`hexa-arch --help` STDLIB CLI section to surface the `booksim` subcommand
group, mirroring rfc_047 §4 cmd_help integration.

### 7.3 Fail-loud exit codes (rfc_048 §3 mirror — raw-91 doctrine)

- 0 — success
- 1 — subcommand error (bad flags, missing input)
- 2 — unknown topic
- 90 — measurement gate not satisfied (no "absorbed" claim yet — see §8)
- 91 — unreachable / config missing (e.g. wire-delay node profile absent,
       Leighton oracle violated)

Silent skip BANNED — `no-over-claim g3`.

### 7.4 Re-derivation provenance (Decision 1 audit)

Each `stdlib/booksim/*.hexa` module carries a top-of-file comment naming
the public-surface source it was clean-room re-derived from (URL + commit
hash for code, DOI / arXiv ID for theorems and wire-delay numbers).
Cf. CHARTER "Domain plugin model" — public surface only, citation
required, closed-binary RE refused (`design.md` Decision 1).

## 8. Measurement gate (no "absorbed" claim until satisfied)

- Reproduce a published BookSim2 latency-vs-injection curve for an
  8×8 mesh, uniform traffic, within stated error (g3 measurement, not
  assertion).
- Produce degree-4 vs degree-6 curves under uniform + tornado, **with**
  the wire-delay model injected, at a documented modern-node
  wire-delay number — including the bound-cross-check vs the Leighton
  oracle.
- File the measurement in `PLAN.md` 진행 로그 with cited numbers; only
  then mark BookSim2 "absorbed at measured parity".

## 9. Open questions

- Which published modern-node wire-delay number is the right baseline
  (SMART-era 22 nm? newer FinFET? — survey and pick, cited).
- Floorplan / placement assumption for the degree-6 candidate —
  uniform-grid vs optimized? Pick the more adversarial.
- Whether `tornado` alone is sufficient for adversarial bisection
  stress, or whether a degree-aware adversarial pattern is needed.

## 10. References (Decision 1 public-surface only)

- BookSim2: <https://github.com/booksim/booksim2>, `doc/manual.tex`
- gem5 / Garnet: <https://www.gem5.org/documentation/general_docs/ruby/garnet-2/>,
  arXiv:2007.03152
- BookSim accuracy reference (BST, ISPASS'20):
  <https://personales.unican.es/vallejoe/Publications/Perez%20-%20BST,%20a%20BookSim-based%20Toolset%20to%20Simulate%20NoCs%20with%20single-%20and%20multi-hop%20bypass%20-%20ISPASS'20.pdf>
- gem5-Garnet error (Extending gem5-Garnet, ACM):
  <https://dl.acm.org/doi/abs/10.1145/2994133.2994140>
- SMART / OpenSMART (ISPASS'17):
  <https://bpb-us-e1.wpmucdn.com/sites.gatech.edu/dist/c/332/files/2017/03/OpenSMART_ISPASS17.pdf?bid=332>
- SMART (Krishna et al., CSAIL):
  <https://people.csail.mit.edu/suvinay/pubs/2013.smart.computer.pdf>
- Leighton VLSI bounds: Springer DOI 10.1007/BF01744433;
  Bhatt–Leighton VLSI graph layout framework (Semantic Scholar
  paper id 234cf578839121aa76f4c09d015f9cceb7be5cf0).
- Topology theory: Slim NoC arXiv:2010.10683.
- Open PDKs: SkyWater SKY130, IHP-Open-PDK
  <https://github.com/IHP-GmbH/IHP-Open-PDK>.

## 11. Export interface — `F1F2-record` schema v1.0

This RFC is the **producer** of the BookSim2 absorption. The
**consumer contract** (what fields are emitted, in what format, with
what provenance guarantees) is split into a sibling RFC per HANDOFF §7
"one absorption-RFC per concept":

→ `proposals/rfc_002_f1f2_export_interface.md` — typed-interface
   contract for the `hexa-arch:chip:noc:F1F2-record` artifact consumed
   by hexa-lang `comb` (`design.md` Decision 2 typed-interface +
   Decision 7 producer-owned path).

Records are emitted to `~/core/hexa-arch/exports/chip/noc/f1f2/`;
carrier is HXC v2 byte-canonical wire (forced by hexa-lang `@D g_hxc`);
per-record provenance enforced (`provenance.absorbed = false` until
this RFC's §8 measurement gate closes). See rfc_002 §3 for the schema,
§4 for provenance fields, §5 for the path convention.
