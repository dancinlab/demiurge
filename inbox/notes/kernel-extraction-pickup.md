# Pickup — STDLIB ①a kernel extraction (design.md D72 2-layer)

date: 2026-05-20 · status: graph kernel DONE, remainder staged

## What D72 mandates

ABSORPTION.md ① is now 2-layer:
- **①a** `hexa-lang/stdlib/kernels/<kernel>/` — domain-agnostic
  reusable compute kernels.
- **①b** `hexa-lang/stdlib/<domain>/` — thin domain adapters that
  call a kernel + hold only domain geometry/parameters/caveats.

Goal: stop re-absorbing the same FEM/MC/graph kernel per domain
(N×M -> N+M). When a kernel goes hexa-native, `absorbed=true` flips
once in ①a instead of in every ①b adapter.

## DONE this round — `graph` kernel

`stdlib/kernels/graph/networkx_kernel.py` extracted. Shared math:
`topology_metrics(graph, top_n)` (connectivity, diameter, radius,
density, clustering, edge-connectivity bisection surrogate, top-N
betweenness/degree centrality), `edges_sha256_16`, `networkx_version`.

Two ①b adapters reduced to thin (own only domain topology + caveats):
- `stdlib/grid/networkx_basics.py` — IEEE 14-bus power-grid topology.
- `stdlib/mobility/road_network.py` — synthetic Manhattan road grid.
  osmnx.basic_stats stays in the adapter (osmnx-specific road stat,
  not a generic graph metric); only connectivity/diameter delegated.

Adapters locate the kernel via path relative to `__file__`
(`../kernels/graph/`) since the demiurge `python3 <script> <out_dir>`
spawn uses an arbitrary cwd. No `<Domain>Producer.swift` change
needed — script filenames/locations unchanged.

Verified: `swift run DemiurgeCLI action structure grid` and
`action analyze mobility` both emit records with byte-identical
values (grid 14/20/diam5/bisection1; mobility 100/360/k_avg7.2/
diam18). g3: structural relocation, 0 measurement change.

## Remainder — staged, NOT done (honest)

13 producer scripts total; only the 2 graph ones extracted. The
rest are single-domain today — low priority, structure-only until
a second consumer appears. Per ABSORPTION.md ① kernel table:

| kernel        | domains today        | extraction priority |
|---------------|----------------------|---------------------|
| `circuit`     | sscb (ngspice)       | med — FEMMT/energy may join |
| `fem`         | component, rtsc, fusion, sscb-verify | HIGH — already multi-domain in design, biggest N×M win |
| `mc_transport`| cern, antimatter     | med — 2 domains, clear share |
| `orbital`     | space (skyfield)     | low — single domain, dir only |
| `wave_optics` | scope (POPPY)        | low — single domain |
| `cfd`         | fusion               | low — single domain |
| `logic_synth` | chip (yosys)         | low — chip §B work in flux |
| `noc_sim`     | chip (booksim)       | low — chip work in flux |

Recommended next: **`fem`** — design.md already lists 4 domains
(`component+verify`, `rtsc+analyze`, `fusion+analyze`, `sscb+verify`)
as fem consumers, so it is the largest N×M collapse. But the fem
producers are heavier (CalculiX/gmsh spawn) — budget a full session.

Single-domain kernels: just `mkdir stdlib/kernels/<kernel>/` and
move the producer in as the sole ①b adapter when convenient; no
math to factor out until a 2nd consumer lands. Do NOT force it.
