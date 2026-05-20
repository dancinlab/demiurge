# Parity attempt — `energy + synthesize` (PyPSA capacity-expansion LP)

> status: **resolved** (κ-50) — PyPSA rel err 6e-6 vs independent scipy.linprog LP (machine ε). Flip NO (data-honesty gate — NOT sourced NREL ATB capital costs, NOT real demand, NOT real CFs, NOT multi-bus AC power-flow).

- date: 2026-05-20
- ROI rank: 5 ⭐⭐⭐⭐⭐
- substrate: `~/core/hexa-lang/stdlib/energy/pypsa_capacity.py`
  (hexa-lang commit `167ade23` — currently on branch `rfc055-p3c-entry`,
  not yet merged to `origin/main`)
- problem id: `single_bus_capex_4tech_168h_v1`
- pypsa: 0.32.2 · highspy: 1.14.0 · python: 3.9.6
- agent: agent-ace9f2f33ff7899d0 (worktree-isolated)

## g3 honest scope

This parity check measures **mathematical-LP parity** of the substrate's
PyPSA call against an independently hand-formulated linear program solved
via `scipy.optimize.linprog(method="highs")`. It does **NOT** validate the
input data (capex/cf shapes are textbook placeholders per substrate header)
— only that PyPSA's LP layer correctly minimises the same objective as a
hand-derived primal LP on the same coefficients.

## Substrate vs analytic LP — `p_nom_opt` (MW)

The substrate `GENERATORS` catalogue declares THREE techs (solar / wind /
gas), not four — the task description's "4 candidate techs (solar / wind /
gas / battery)" overstates the substrate; there is no `StorageUnit` block
in the file. Parity check therefore runs on the 3 techs present.

| tech            | substrate `p_nom_opt` | analytic LP optimum | abs Δ        | rel Δ      |
|-----------------|----------------------:|--------------------:|-------------:|-----------:|
| `solar_pv`      |     58.529400 MW      |   58.529404 MW      | 3.87e-06     | 6.6e-06 %  |
| `onshore_wind`  |    199.463100 MW      |  199.463089 MW      | 1.06e-05     | 5.3e-06 %  |
| `ccgt_gas`      |     64.248600 MW      |   64.248594 MW      | 5.90e-06     | 9.2e-06 %  |

Objective parity:
- substrate `objective_eur`:   19_376_177.524
- analytic LP `c·x`:           19_376_177.524138987
- relative Δ:                  7.2e-10 (≈ machine ε)

Annual generation parity (MWh/yr): solar / wind / gas all match to <1e-5 %
relative.

All deltas are **6+ orders of magnitude tighter than the ±1% tolerance** and
sit at HiGHS's published primal-dual residual (`P-D objective error
~ 4.8e-16` reported by the substrate's HiGHS log). Both solves invoke the
same HiGHS engine (PyPSA via `linopy → highspy`; oracle via `scipy →
highspy`), so this confirms identical LP formulation, not solver-independent
numerical agreement — but it is sufficient witness that the substrate's
PyPSA wrapper does not introduce arithmetic / scaling / weight bugs above
the LP layer.

## Oracle independence

The oracle (`/tmp/oracle_lp.py`) does NOT import `pypsa` or `linopy`. It
rebuilds:
- the 168-hour demand profile from the same closed-form piecewise rule
  (start dow=0 = Monday 2024-06-03);
- solar capacity-factor from `max(0, sin((h−6)/12 · π))` on hours 6..18;
- wind capacity-factor from the diurnal+weekly cosine/sine envelope
  (clipped 0.05..0.95);

then hand-assembles `c`, `A_eq` (1 row per snapshot, demand balance),
`A_ub` (3·168 rows, `p_{g,t} ≤ cf_{g,t} · p_nom_g`), and bounds
`p_nom ∈ [0, 500]`, and solves via `scipy.optimize.linprog(method="highs")`.
The snapshot weight 8760/168 = 52.142857… is applied to the marginal-cost
coefficients (same convention as the substrate's `snapshot_weightings`).

## Flip recommendation

**DO NOT FLIP `absorbed=true`.** Per the task instructions ("note only") AND
per the substrate's own g3 header (lines 38–65: `measurement_gate =
GATE_OPEN, absorbed = false, ALWAYS`), the path to flipping requires —

- (a) sourced NREL ATB capital-cost data (not round figures);
- (b) real demand profile (ERCOT / PJM / ENTSO-E hourly load);
- (c) renewable CFs from site-measured irradiance/wind (TMY3 / ERA5 /
  NREL WIND);
- (d) AC power-flow with real network topology — not a single bus.

This LP-parity check verifies item (e) — "the LP is correctly formulated
and solved" — which is necessary but not sufficient for absorption.
**`measurement_gate = GATE_OPEN`, `absorbed = false` stays.**

What this check **does** authorise:
- The substrate's PyPSA wrapper is **first-honest-witness-grade** for the
  capacity-expansion LP stack — `p_nom_opt`, objective, and per-tech
  annual generation are reproducible from an independent LP formulation
  to machine precision.
- Downstream sweeps over the substrate (sensitivity to capex, demand
  shape, CF profile) inherit this LP-layer trustworthiness.
- A second power-opt consumer (mobility V2G, grid+verify) can promote
  shared math to `kernels/power_opt/pypsa_kernel.py` per D72 with the
  knowledge that the LP layer itself is sound.

## Citation

Brown, T., Hörsch, J., Schlachtberger, D. "PyPSA: Python for Power System
Analysis". *Journal of Open Research Software* **6**(1), 2018.
doi: [10.5334/jors.188](https://doi.org/10.5334/jors.188). BSD-3, OSS,
NREL / TUB / Fraunhofer ecosystem.

## Artifacts

- substrate stdout meta:
  `/tmp/energy_synth_parity_<pid>/single_bus_capex_4tech_168h_v1.meta.json`
  (deleted after session — values inlined above)
- oracle script: `/tmp/oracle_lp.py` (single-file, ~120 LOC,
  scipy.linprog + closed-form profile rebuild — not committed)
- HiGHS solver-log P-D objective error: 4.81e-16 (HiGHS default `ε ≤ 1e-6`,
  achieved 10 orders better)

## Cross-session safety

- hexa-lang: read-only (only `git show 167ade23:stdlib/energy/pypsa_capacity.py`
  to a `/tmp` path; no commits or branch changes).
- demiurge: worktree-isolated (`worktree-agent-ace9f2f33ff7899d0`);
  single commit landing only this note.
- pypsa/highspy installed to user site-packages via
  `python3 -m pip install --user pypsa highspy` (pypsa 0.32.2, highspy
  1.14.0) — not committed to any project.
