# numerics methodology — hexa-ufo v1.1.0-pre

> How the `verify/numerics_*.hexa` surface is structured, what each tier
> means, and what the closure pct in `verify/saturation_check.hexa`
> actually claims.

This document captures the convention behind the 20-script `verify/`
runnable surface as it stood after 22 build iterations on 2026-05-09
(closure-depth-accumulation loop sat-1 + sat-2 + sat-3 reached at
iter 15, post-saturation cross-cutters + tests + build through iter 22).

It is **descriptive**, not prescriptive — the canonical invariants live
in the scripts themselves.

---

## §1 Why a methodology doc

The runnable surface grew across 22 iterations from 4 to 20 verify
scripts (recipe `~/core/bedrock/docs/runnable_surface_recipe.md` §7
closure-depth-accumulation loop, sister of hexa-cern v1.1.0-pre 16-script
sweep).

A reader landing on the repo for the first time should be able to
understand "why are there 20 verify scripts and what do they
collectively claim?" without reading 20 file headers. This doc is that
reader's map.

The pattern is non-trivial:

- `verify/calc_*.hexa` — algebraic n=6 closure (integer arithmetic)
- `verify/numerics_*.hexa` — numerical SI solvers via `self/runtime/math_pure`
- `verify/numerics_*_parity.hexa` — published-data parity (T3 archival)
- `verify/lint_*.hexa` + `verify/saturation_check.hexa` — meta-checks
- `verify/cross_link_upstream.hexa` — Stage-1/2/3 sister CLI cross-link
- `verify/lattice_check.hexa` + `verify/stages_cross_doc.hexa` +
  `verify/stages_falsifier.hexa` — the original cross-cutters

---

## §2 The 3-tier evidence ladder

Every preregistered falsifier (13 total: F-WARP-{1..3}, F-WORM-{1..3},
F-DIM-{1..3}, F-USE-{1..4}, declared in `.roadmap.hexa_ufo §B`) closes
over three tiers of evidence:

| tier | name        | representative scripts                | what it shows |
|:-----|:------------|:--------------------------------------|:--------------|
| T1   | algebraic   | `calc_<pillar>.hexa`                  | n=6 closed-form derivation holds (integer arithmetic, no floats) + spec-doc anchor |
| T2   | numerical   | `numerics_<pillar>.hexa`              | math_pure SI re-derivation matches algebraic + physical-unit regimes |
| T3   | parity      | `numerics_<pillar>_parity.hexa`       | published-data parity vs peer-reviewed literature (Casimir, Pfenning-Ford, Hipparcos, …) |
| T4   | live        | (out of recipe)                       | benchtop hardware / live data feed — Stage-1+ Mk.V 2150+, see §9 of recipe |

Recipe §3 closure_pct():
```
closure_pct(t1, t2, t3):
  if t1 + t2 + t3 == 0: return 0
  if t1 + t2 + t3 == 1: return 33
  if t1 + t2 + t3 == 2: return 67
  if t1 + t2 + t3 == 3: return 100
```

T4 is **out of repo** — `verify/saturation_check.hexa` checks T1 + T2
+ T3 only. Hardware/operations layer awaits Mk.V 2150+ per recipe §9.

---

## §3 Per-pillar mapping (as of v1.1.0-pre)

| pillar         | T1 algebraic              | T2 numerical              | T3 parity                          | falsifiers |
|:---------------|:--------------------------|:--------------------------|:-----------------------------------|:-----------|
| Stage-4 warp   | `calc_warp.hexa`          | `numerics_warp.hexa`      | `numerics_warp_parity.hexa`        | F-WARP-{1..3} |
| Stage-5 wormhole | `calc_wormhole.hexa`    | `numerics_wormhole.hexa`  | `numerics_wormhole_parity.hexa`    | F-WORM-{1..3} |
| Stage-6 dimjump | `calc_dimjump.hexa`      | `numerics_dimjump.hexa`   | `numerics_dimjump_parity.hexa`     | F-DIM-{1..3} |
| Stage-7 dimuse | `calc_dimuse.hexa`        | `numerics_dimuse.hexa`    | `numerics_dimuse_parity.hexa`      | F-USE-{1..4} |

Stage-1 (Meissner) / Stage-2 (fusion) / Stage-3 (antimatter) are
**선행도메인** (precedent / upstream substrates) shipped as sister repos:

| stage | upstream sister CLI                   | wired by                          |
|:------|:--------------------------------------|:----------------------------------|
| Stage-1 | `~/core/hexa-rtsc/cli/hexa-rtsc.hexa`       | `verify/cross_link_upstream.hexa` |
| Stage-2 | `~/core/hexa-fusion/cli/hexa-fusion.hexa`   | `verify/cross_link_upstream.hexa` |
| Stage-3 | `~/core/hexa-antimatter/cli/hexa-antimatter.hexa` | `verify/cross_link_upstream.hexa` |

`cross_link_upstream.hexa` runs each upstream sister CLI's `selftest`
subcommand and confirms exit 0 + domain-signature token.

---

## §4 Five invariants enforced by `lint_numerics.hexa`

Every `verify/numerics_*.hexa` (T2 + T3) must satisfy:

1. `use "self/runtime/math_pure"` — no raw float math sneaks in
2. `__HEXA_UFO_<NAME>__` sentinel prefix + `__ PASS` suffix — CI-detectable
3. `FALSIFIERS` list declared — retract conditions explicit
4. `exit(0)` on PASS path — shell-friendly verdict
5. `let mut RUN = …` + `let mut FAIL = …` counters — per-section accounting

Plus the inventory drift detector: `NUMERICS_SCRIPTS` array length
== on-disk `verify/numerics_*.hexa` glob count. This catches silent
script additions that bypass the lint contract.

Run: `hexa run verify/lint_numerics.hexa`

---

## §5 Cross-cutters

Beyond per-pillar scripts, two cross-cutters audit the overall n=6
lattice consistency:

### `verify/numerics_lattice_arithmetic.hexa`
math_pure precision floor regression slot. Asserts `sqrt_pure(144)=12`,
`pow_pure(σ,3)=1728`, `exp_pure(log_pure(σ))=σ` round-trip, etc., all
to sub-1e-9 relative error. If math_pure drifts on the integer-equivalent
anchors, this script catches it BEFORE downstream pillar numerics get
contaminated.

### `verify/numerics_cross_pillar.hexa`
4-pillar shared-anchor consistency. Asserts:
- `c` and `ℓ_Pl` are identical SI values across all 4 pillars
- `σ-φ=10` shared by 4 anchors (worm trav / dim 10D / use warp / use dim_compress)
- composite decomposition: dimuse 100c = warp 10c × dimjump 10×
- Pfenning-Ford 1/τ=0.25 shared by warp QI + wormhole ANEC
- VDB σ²=144 shared by warp + dimuse

Catches recipe-wide drift where one pillar silently uses a different
n=6 anchor value than another.

---

## §6 Saturation criteria (`verify/saturation_check.hexa`)

The canonical RSC self-stop signal. PASS ⇒ emits
`__HEXA_UFO_RSC_SATURATED__ STOP` sentinel.

3 sat conditions:

- **sat-1** (per-pillar closure): each F-{WARP/WORM/DIM/USE} has
  T1 ✓ + T2 ≥ 1 + T3 ≥ 1
- **sat-2** (recipe-exhausted): numerics inventory ≥ 8 + lint_numerics passes
- **sat-3** (선행도메인): Stage-1/2/3 sister CLI cross-link reachable

Plus 10× required-scripts backbone presence.

If `saturation_check` passes, the closure-depth-accumulation loop should
terminate per recipe §7.5. Subsequent /loop firings should run this (or
`run_all`) as a health-check ONLY — no new chunks per recipe §9.1.

---

## §7 The test layer (`tests/test_*.hexa`)

The verify scripts are the **truth**; the test scripts are **CI-friendly
wrappers** that aggregate results and report sentinels for external
runners (GitHub Actions, etc.).

| test                          | wraps                                          |
|:------------------------------|:-----------------------------------------------|
| `test_atlas_consistency.hexa` | 10-verb atlas consistency check                |
| `test_stages_propulsion.hexa` | verify/run_all + selftest + lattice            |
| `test_calculators.hexa`       | 20× (filename, sentinel) regressions across full RSC surface |
| `test_lattice.hexa`           | verify/lattice_check (legacy 10/10 marker)     |
| `test_cli_verify.hexa`        | CLI surface: verify + status + lattice + selftest |
| `test_all.hexa`               | 5-test top-level aggregator                    |

Run: `hexa run tests/test_all.hexa` for the full sweep.

---

## §8 Build infrastructure (`build/Makefile`)

`make -C build all` regenerates 5 PDFs via pandoc + xelatex:
- `hexa-warp.pdf` (Stage-4)
- `hexa-wormhole.pdf` (Stage-5)
- `hexa-dimjump.pdf` (Stage-6)
- `hexa-dimuse.pdf` (Stage-7)
- `hexa-ufo.pdf` (main atlas, 1890 LOC)

`build/header.tex` is soft-guarded for fontspec / xeCJK / titlesec —
build host without optional packages produces clean ASCII-only PDF.

`make verify` cross-links to the verify pipeline as a regression gate
before publishing PDFs.

---


> **The verify surface validates the n=6 closed-form lattice + spec-doc
> anchors + published-data parity — it does NOT validate empirical
> Stage-4~7 hardware claims.**
>
> Alcubierre warp, Morris-Thorne wormhole, KK extra dimensions, and the
> composite τ=4 cycle remain academically UNPROVEN. The 13 falsifiers
> remain OPEN at v1.0.0. Sentinel PASS == "closed-form arithmetic +
> published-data anchor agreement." It does NOT mean "Mk.V 2150+ live
> hardware demonstrated."
>
> T4 (live hardware / external collab) is out of recipe scope per §9
> of `~/core/bedrock/docs/runnable_surface_recipe.md` and awaits Mk.V
> 2150+.

---

## §10 References

- Recipe SSOT: `~/core/bedrock/docs/runnable_surface_recipe.md`
- Worked example (sister): `~/core/hexa-cern/docs/numerics_methodology.md`
- Falsifier preregister: `.roadmap.hexa_ufo §A.4 + §B`
- Iteration log: `CHANGELOG.md` + `.roadmap.hexa_ufo §A.3`
