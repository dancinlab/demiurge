# Pickup — STDLIB ①a kernel extraction (design.md D72 2-layer)

date: 2026-05-20 · status: **DONE — 13 kernels landed on hexa-lang
`origin/main` `7332e162`** (graph·fem·mc_transport·orbital·
wave_optics·noc_sim·logic_synth·circuit·plasma·neural·signal_proc·
urdf·solar). Every ①b adapter is now thin. Round closed by demiurge
session 2026-05-20 (κ-45). Next item = empty-cell producer
measurement (sscb·scope·cern·component synth/verify per
`absorption-empty-cells-research-2026-05-20.md`), gated by
`~/core/hexa-lang` live-tree cross-session alignment to `7332e162`
— outside this note's scope.

> Sections below preserved as the in-flight record for the first 2
> extractions (graph + fem). The remaining 11 followed the same
> pattern; summary lives in `PLAN.md` κ-45.

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

## DONE this round — `fem` kernel

`stdlib/kernels/fem/skfem_kernel.py` extracted (graph pattern
mirrored). Domain-agnostic API: `mesh_box(out_dir, L, W, T,
mesh_size, name)` + `mesh_from_step(out_dir, step_path, mesh_size,
name)` (gmsh meshing), `solve_thermal(mesh, conductivity,
body_source, dirichlet_select, dirichlet_value_k)` (steady-state
heat conduction), `solve_elastic(mesh, E, nu, body_force,
dirichlet_select)` (linear elasticity), `von_mises_max_p1`,
`gmsh_version` / `skfem_version`. Returns field min/max + mesh
stats + solver meta — knows nothing of any domain.

①b adapter reduced to thin: `stdlib/component/gmsh_skfem.py` now
owns only the die-proxy geometry (10×10×2 mm box), silicon material
constants, the load case (5 W top slab + gravity) and the 6 honesty
caveats — all FEM math delegated to the kernel. The Stage-2 hexa
ports (`heat_conduction.hexa`, `linear_elasticity.hexa`) stay
beside the adapter; when they reach parity, `absorbed` flips in
the kernel — once.

Adapter locates the kernel via `__file__`-relative path
(`../kernels/fem/`); `ComponentVerifyProducer.swift` unchanged
(script filename/location unchanged).

Verified: `swift run DemiurgeCLI action verify component` emits a
record with byte-identical values — geometry/material/load/
measurements all IDENTICAL vs the pre-refactor record, fingerprint
`6fbb071a873b1784` unchanged (686 nodes / 2232 tetrahedra, ΔT
0.528 K, σ_vM_max 38.37 Pa, u_max 2.796e-13 m, GATE_OPEN /
absorbed=false). Pre/post CSV byte-identical, meta.json identical
modulo timestamp. g3: structural relocation, 0 measurement change.

## Remainder — staged, NOT done (honest)

13 producer scripts total; the 2 graph + 1 fem (component) ones
extracted. The rtsc / fusion / sscb-verify fem consumers have NO
fem producer yet (empty cells / plasma params) — when those land
they reuse `kernels/fem/` directly, no second extraction. The rest
are single-domain today — low priority, structure-only until a
second consumer appears. Per ABSORPTION.md ① kernel table:

| kernel        | domains today        | extraction priority |
|---------------|----------------------|---------------------|
| `circuit`     | sscb (ngspice)       | med — FEMMT/energy may join |
| `fem`         | component (live); rtsc, fusion, sscb-verify slated | DONE — kernel extracted, awaits the 3 other adapters when their cells get fem producers |
| `mc_transport`| cern, antimatter     | med — 2 domains, clear share |
| `orbital`     | space (skyfield)     | low — single domain, dir only |
| `wave_optics` | scope (POPPY)        | low — single domain |
| `cfd`         | fusion               | low — single domain |
| `logic_synth` | chip (yosys)         | low — chip §B work in flux |
| `noc_sim`     | chip (booksim)       | low — chip work in flux |

Recommended next: **`mc_transport`** — 2 real domains (cern,
antimatter) with a clear shared Monte-Carlo particle-transport
kernel, the next-largest N×M collapse after fem.

Single-domain kernels: just `mkdir stdlib/kernels/<kernel>/` and
move the producer in as the sole ①b adapter when convenient; no
math to factor out until a 2nd consumer lands. Do NOT force it.
