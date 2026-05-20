# hexa-lang branch consolidation — 2026-05-20

> status: **pickup-blocked** (cross-session) — concurrent session occupies the `~/core/hexa-lang` live tree on a non-origin/main branch. demiurge-session-autonomous resolution would lose concurrent uncommitted work — see NEXT_SESSIONS H-1.

Cross-session consolidation of divergent `~/core/hexa-lang` branches so demiurge's
16 producers spawn stdlib scripts that work on any branch. g3-safe: no force, no
rewrite, no uncommitted-change loss.

## Branch diagnostic table

| branch | HEAD | ahead/behind origin/main | uncommitted | carries | action |
|---|---|---|---|---|---|
| `origin/main` (was) | `10f8815d` | — | — | no kernels, no D72 | **merge target** |
| `t4-emt-calc` | `ddcac584` | +23 / −16 | (not checked out — no risk) | D72 graph+fem kernels, `stdlib/kernels/`, `stdlib/component/`, D63 mobility producer | **cherry-picked → main** |
| `rfc006-yosys-rv-scope` | `b8e1d5dd` (live, cwd) | +2 / −2 (now behind) | `compiler/lower/hir_to_mir.hexa` modified + 9 untracked `stdlib/*` dirs | yosys read_verilog work | **left untouched — active session** |
| `compiler-native-codegen` | `f5265232` | +23 / −36 | n/a | native-codegen docs, sscb κ-41 VDMOS, `gmsh_skfem.py df33aace` | **left untouched — active session** |
| `rfc006-yosys-rtlil-skeleton` | `502570ad` | +23 / −29 | n/a | yosys rtlil skeleton, DEVSIM TCAD bridge, `gmsh_skfem.py df33aace` | **left untouched — active session** |

## Integrated into origin/main

New `origin/main` HEAD: **`ba1d8b8c`** (was `10f8815d`).

Three commits cherry-picked in a fresh worktree off `origin/main` (`/tmp/hexa-consolidate`,
since removed), all conflict-free, then pushed:

1. `d46d0dcc` ← `0626febc` — `stdlib/mobility/road_network.py` (D63/κ-41 osmnx
   producer). Pure new-file add; required because the graph-kernel commit refactors
   this file and origin/main did not have it yet.
2. `9b06f175` ← `259e5788` — D72 graph kernel: `stdlib/kernels/graph/networkx_kernel.py`
   + `grid/networkx_basics.py` + `mobility/road_network.py` reduced to ①b adapters.
3. `ba1d8b8c` ← `ddcac584` — D72 fem kernel: `stdlib/kernels/fem/skfem_kernel.py`
   + `stdlib/component/gmsh_skfem.py` (①b adapter) + `heat_conduction.hexa` /
   `linear_elasticity.hexa` Stage-2 ports.

All 5 Python files `py_compile`-clean. Adapters resolve the kernel via a
`__file__`-relative path, so the demiurge `python3 <script> <out_dir>` spawn works
from any cwd — no Producer.swift change needed.

### `gmsh_skfem.py df33aace` — resolved, NOT separately needed

`df33aace` (the κ-44 structural FEM bug fix: `linear_elasticity`/`lame_parameters`
builtin + `get_dofs`/`nodal_dofs` interleaved-DOF fix) is the 508-line *pre-extraction*
monolith. The fem-kernel commit `ddcac584` is the 362-line *post-extraction* adapter
and **already contains all the df33aace fixes** (verified: `skfem_kernel.py` carries
`linear_elasticity`, `lame_parameters`, `get_dofs`, `nodal_dofs`; adapter preserves
the post-fix values σ_vM 38.37 Pa / u_max 2.796e-13 m, fingerprint `6fbb071a873b1784`).
So cherry-picking the two kernel commits is sufficient — df33aace is superseded, no
duplicate landed.

## Held back — active concurrent sessions (do NOT touch)

- `rfc006-yosys-rv-scope` — live working branch, has uncommitted changes. Left exactly
  as found.
- `compiler-native-codegen`, `rfc006-yosys-rtlil-skeleton` — actively occupied by other
  Claude Code sessions; +23/−29..36 vs main, large diffs (compiler/sscb/yosys). Merging
  these is a cross-session operation and unsafe to force from here.

Recommendation: each owning session pushes its own work, then **one** session merges
`compiler-native-codegen` and the yosys branches into `origin/main` (or opens PRs).
Both yosys branches and `compiler-native-codegen` independently carry `df33aace`'s
`gmsh_skfem.py`; once they rebase/merge onto the new `ba1d8b8c` main, git will see the
adapter version as already-current (kernel extraction wins) — expect a trivial
content-identical resolution there, not a real conflict.

## Recommendation for demiurge

Point `~/core/hexa-lang` at **`origin/main` (`ba1d8b8c`)** for producer spawns. It now
has `stdlib/kernels/{graph,fem}/`, `stdlib/component/`, `stdlib/grid/networkx_basics.py`,
and `stdlib/mobility/road_network.py` — the full D72 2-layer kernel set the producers
need — and none of the in-flight branch churn. The repo working copy is currently on
`rfc006-yosys-rv-scope` (a session owns it); demiurge should spawn from a clean checkout
or worktree pinned to `origin/main`, not from that live working tree.
