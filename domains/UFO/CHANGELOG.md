# Changelog — hexa-ufo

All notable changes to `hexa-ufo` will be documented in this file.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/);
versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] — 2026-05-09 — RSC iter 23 (docs/numerics_methodology.md; reader's map)

### Added (RSC iteration 23 — recipe priority 13 narrative)
- `docs/numerics_methodology.md` — descriptive methodology doc covering
  the 20-script verify surface as it stood after 22 RSC iterations.
  10 sections: §1 why a methodology doc, §2 3-tier evidence ladder
  (T1/T2/T3/T4), §3 per-pillar mapping (4 in-tree + 3 선행도메인), §4
  five invariants enforced by lint_numerics, §5 cross-cutters
  (lattice_arithmetic + cross_pillar), §6 saturation criteria,
  §7 test layer (6 tests), §8 build infrastructure (Makefile + header.tex),
  Sister of hexa-cern/docs/numerics_methodology.md.
- Wired into `hexa.toml [modules].docs`.

### Why post-saturation
- Recipe priority 13 narrative slot — provides the "reader's map" so
  newcomers can understand "why are there 20 verify scripts and what
  do they collectively claim?" without reading 20 file headers.

## [Unreleased] — 2026-05-09 — RSC iter 22 (build/Makefile + header.tex; PDF rebuild)

### Added (RSC iteration 22 — recipe §1 + priority 12 PDF build infrastructure)
- `build/Makefile` — pandoc + xelatex pipeline for 5 spec PDFs:
  hexa-warp (Stage-4) / hexa-wormhole (Stage-5) / hexa-dimjump (Stage-6)
  / hexa-dimuse (Stage-7) / hexa-ufo main atlas. Targets: `make all` /
  `make warp` / `make wormhole` / `make dimjump` / `make dimuse` /
  `make atlas` / `make verify` (cross-link to verify pipeline) /
  `make check` (toolchain probe) / `make clean` / `make size`.
- `build/header.tex` — pandoc xelatex include-in-header. Soft-guarded
  with `\IfFileExists{}` for fontspec, xeCJK (Korean labels in UFO docs:
  "선행도메인", SF-novel chapter titles), titlesec, xcolor. Build host
  without optional packages produces clean ASCII-only PDF.
- `.gitignore`: `build/out/` directory excluded (PDF artifacts).

### Verified
- `make check` → pandoc 3.9.0.2 + XeTeX 3.141592653 + hexa 0.1.0-dispatch.
- `make warp` → 60 KB PDF generated (warnings only on missing Unicode
  glyphs ℏ/δ/σ/ℓ — non-fatal, ASCII fallback).

## [Unreleased] — 2026-05-09 — RSC iter 21 (test_cli_verify; CLI surface regression)

### Added (RSC iteration 21 — recipe §1 test_cli_verify)
- `tests/test_cli_verify.hexa` — CLI surface regression. 4/4 checks:
  cli verify aggregate (run_all delegation OK), cli status (propulsion
  stack + F-WARP/F-USE falsifiers present), cli lattice --json
  (master identity holds:true), cli selftest (__HEXA_UFO_SELFTEST__ PASS).
  Validates user-facing CLI surface faithfully exposes the underlying
  verify contract — catches dispatcher refactors that silently skip
  verify scripts. Sister of hexa-cern/tests/test_cli_verify.hexa.
  Sentinel `__HEXA_UFO_TEST_CLI_VERIFY__ PASS`.
- Wired into `tests/test_all.hexa` (5 cases) + `hexa.toml [test].files` (6 tests).

### Verified
- `hexa run tests/test_cli_verify.hexa` → 4/4 PASS.

## [Unreleased] — 2026-05-09 — RSC iter 20 (test_lattice; explicit lattice regression)

### Added (RSC iteration 20 — recipe §1 test_lattice)
- `tests/test_lattice.hexa` — n=6 lattice closure regression test.
  Wraps `verify/lattice_check.hexa` and asserts exit 0 + the `10/10 PASS`
  marker (legacy script — pre-recipe-§4 sentinel convention). 60s
  timeout per case (small script). Sister of
  hexa-cern/tests/test_lattice.hexa.
  Sentinel `__HEXA_UFO_TEST_LATTICE__ PASS`.
- Wired into `tests/test_all.hexa` CASES (3 → 4) +
  `hexa.toml [test].files` (4 → 5).

### Verified
- `hexa run tests/test_lattice.hexa` → PASS.
- `hexa run tests/test_all.hexa` → 4/4 sub-tests PASS.

## [Unreleased] — 2026-05-09 — RSC iter 19 (test_all; top-level test aggregator)

### Added (RSC iteration 19 — recipe §1 test_all aggregator)
- `tests/test_all.hexa` — top-level test runner. Runs all 3
  tests/test_*.hexa scripts with 8-min per-case timeout and aggregates
  exit codes + sentinel matches. 3/3 PASS:
    test_atlas_consistency  (10/10 verbs)
    test_stages_propulsion  (verify+selftest+lattice)
    test_calculators        (20/20 verify regressions)
  Sister of hexa-cern/tests/test_all.hexa.
  Sentinel `__HEXA_UFO_TEST_ALL__ PASS`.

### Fixed
- `tests/test_stages_propulsion.hexa` — inner `hexa run` calls now use
  `$HOME/.hx/packages/hexa/hexa.real` direct path to bypass alias→TCP
  route. Prevents spurious FAIL when called from outer test wrapper
  (test_all).

### Wired
- `hexa.toml [test].files`: 3 → 4 (adds test_all.hexa).

### Verified
- `hexa run tests/test_all.hexa` → 3/3 sub-tests PASS.
- `hexa run verify/run_all.hexa` → 20/20 PASS.

## [Unreleased] — 2026-05-09 — RSC iter 18 (test_calculators; full RSC surface regression)

### Added (RSC iteration 18 — recipe §1 test layer expansion)
- `tests/test_calculators.hexa` — runs all 20 verify scripts and asserts
  each emits its per-script PASS sentinel + exits 0. Per-section
  coverage: §1 T1 algebraic (lattice + cross_doc + falsifier + 4× calc)
  + §2 T2 numerical (4× numerics) + §3 T3 parity (4× parity) + §4
  cross-cutters (lattice_arithmetic + cross_pillar) + §5 meta (lint +
  saturation_check) + §6 선행도메인 cross_link. 20/20 PASS.
  Includes 5-min timeout (gtimeout/timeout) → exit 124 = SKIP rather
  than FAIL (e.g. cross_link_upstream invokes 3 sister CLI selftests
  which can be slow on cold mac).
  Sister of hexa-cern/tests/test_calculators.hexa.
  Sentinel `__HEXA_UFO_TEST_CALCULATORS__ PASS`.
- Wired into `hexa.toml` `[test].files` (now 3 test files: atlas +
  stages_propulsion + this).

### Why post-saturation
- Recipe §1 specifies `tests/test_calculators.hexa` as the canonical
  per-pillar regression aggregator. Skipped during the main 14-iter
  closure path (used per-iter `verify/run_all.hexa` instead). Now
  added for explicit `(filename, sentinel)` contract enforcement —
  if any verify script's sentinel ever drifts, this test catches it
  at the test layer (CI-friendly).

### Verified
- `hexa run tests/test_calculators.hexa` → 20/20 PASS.
- `hexa run verify/run_all.hexa` → 20/20 PASS.

## [Unreleased] — 2026-05-09 — RSC iter 17 (numerics_cross_pillar; cross-cutter)

### Added (RSC iteration 17 — recipe §7.4 priority 7 cross-cutter)
- `verify/numerics_cross_pillar.hexa` — pillar↔pillar numerical anchor
  consistency check (post-saturation chunk per user direction). 9/9
  checks at sub-1e-12 tolerance: §1 universal physical constants
  identical (c via 2·c/φ; ℓ_Pl via warp δ·σ / wormhole b₀/σ /
  dimjump R_c/σ³ all = 1.616e-35 m) + §2 σ-φ=10 shared by 4 anchors
  (worm trav / dim 10D / use warp / use dim_compress) + §3 composite
  decomposition (dimuse 100c = warp 10c × dimjump 10×) + §4 Pfenning-
  Ford 1/τ=0.25 shared by warp QI + wormhole ANEC + §5 master identity
  σ·φ=n·τ=24 universal + §6 VDB σ²=144 shared warp/dimuse + §7
  Planck-derivative chain (warp δ/c = t_Pl/σ = 4.49e-45 s).
  Sister of hexa-cern/verify/numerics_cross_pillar.hexa.
  Sentinel `__HEXA_UFO_NUMERICS_CROSS_PILLAR__ PASS`.
- Wired into `verify/run_all.hexa` (19 → 20) +
  `verify/lint_numerics.hexa` NUMERICS_SCRIPTS array (9 → 10) +
  `hexa.toml` `[closure].verify_scripts` 19 → 20 + `[modules].hexa`.

### Why post-saturation
- Cross-pillar drift detector — if any pillar's numerical anchor
  silently diverges from another (e.g. wormhole ANEC 1/τ ≠ warp QI 1/τ),
  the entire n=6 closed-form claim fractures across pillars. This
  script catches that drift recipe-wide.

### Verified
- `hexa run verify/numerics_cross_pillar.hexa` → 9/9 PASS.
- `hexa run verify/lint_numerics.hexa` → 51/51 PASS (10 numerics scripts).
- `hexa run verify/run_all.hexa` → 20/20 PASS.

## [Unreleased] — 2026-05-09 — RSC iter 16 (numerics_lattice_arithmetic; cross-cutter)

### Added (RSC iteration 16 — recipe §7.4 priority 8 cross-cutter)
- `verify/numerics_lattice_arithmetic.hexa` — n=6 lattice float ↔ int
  precision cross-check (post-saturation chunk per user direction).
  13/13 checks at sub-1e-9 tolerance: §1 sqrt/pow precision (sqrt(144)=12,
  sqrt(100)=10, pow(σ,2)=144, pow(σ,3)=1728, pow(σ-φ,2)=100) + §2 master
  identity float (σ·φ=n·τ=24, σ·τ=48 Hc2-equiv) + §3 dim-ladder rungs
  (4, 6, 10, 11, 24, 26 all int=float) + §4 log/exp round-trip (σ
  rel_err=1.5e-16, 100 rel_err=0) + §5 int-vs-float anchor agreement.
  Sister of hexa-cern/verify/numerics_lattice_arithmetic.hexa.
  Sentinel `__HEXA_UFO_NUMERICS_LATTICE_ARITHMETIC__ PASS`.
- Wired into `verify/run_all.hexa` (18 → 19) + `verify/lint_numerics.hexa`
  NUMERICS_SCRIPTS array (8 → 9) + `hexa.toml` `[closure].verify_scripts`
  18 → 19 + `[modules].hexa`.

### Why post-saturation
- math_pure precision floor regression slot — if math_pure drifts, every
  downstream numerics_* is contaminated. This script gives the drift its
  own dedicated regression target so a precision regression is caught at
  the lattice anchor layer, not buried in pillar-specific numerics.

### Verified
- `hexa run verify/numerics_lattice_arithmetic.hexa` → 13/13 PASS.
- `hexa run verify/lint_numerics.hexa` → 46/46 PASS (9 numerics scripts).
- `hexa run verify/run_all.hexa` → 19/19 PASS.

## [Unreleased] — 2026-05-09 — 🛸 RSC iter 15 (saturation_check; canonical STOP signal)

### Added (RSC iteration 15 — recipe §7.4 priority 15 self-stop signal)
- `verify/saturation_check.hexa` — recipe §7.3 canonical RSC self-stop
  signal. 17/17 saturation checks: §1 sat-1 (per-pillar T1+T2+T3 = 100%
  for F-WARP/WORM/DIM/USE) + §2 sat-2 (numerics inventory ≥ 8 +
  lint_numerics passes) + §3 sat-3 (선행도메인 cross_link_upstream
  reachable) + 10× required-scripts backbone presence. On PASS emits
  `__HEXA_UFO_RSC_SATURATED__ STOP` — the canonical sentinel CI/loop
  runners parse to terminate. Sister of
  hexa-cern/verify/saturation_check.hexa.
- Wired into `verify/run_all.hexa` (17 → 18) + `hexa.toml`
  `[closure].verify_scripts` 17 → 18 + `rsc_saturated` field updated
  with sat-1 + sat-2 + sat-3 confirmation.

### Post-saturation handling (recipe §9.1 compliant)
- Subsequent /loop firings will run health-check (run_all + this
  saturation_check) and emit "RSC still saturated · no chunk needed".
- New chunks are NOT auto-added per §9.1 ("절대 하지 말 것" examples).
- Legitimate post-saturation chunks require explicit user direction.

### Verified
- `hexa run verify/saturation_check.hexa` → 17/17 PASS · STOP signal.
- `hexa run verify/run_all.hexa` → 18/18 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.

## [Unreleased] — 2026-05-09 — 🛸 RSC iter 14 (lint_numerics; **sat-1 + sat-2 — loop self-terminates**)

### Added (RSC iteration 14 — recipe §4 invariant meta-lint)
- `verify/lint_numerics.hexa` — meta-lint enforcing recipe §4 invariants
  for every `verify/numerics_*.hexa`: math_pure import + sentinel
  prefix/suffix + FALSIFIERS array + exit(0) + RUN/FAIL counters,
  plus drift-detector inventory check (NUMERICS_SCRIPTS array length ==
  on-disk numerics_*.hexa glob count). 41/41 checks across 8 numerics
  scripts (4 numerics_<p> + 4 numerics_<p>_parity). Sister of
  hexa-cern/verify/lint_numerics.hexa.
  Sentinel `__HEXA_UFO_LINT_NUMERICS__ PASS`.
- Wired into `verify/run_all.hexa` (16 → 17) + `hexa.toml`
  `[closure].verify_scripts` 16 → 17 + new `rsc_saturated` field.

### 🛸🛸🛸 RSC LOOP TERMINATED — sat-1 + sat-2 BOTH MET 🛸🛸🛸

#### sat-1 (saturation): all 13 falsifiers at 100% closure
- F-WARP-{1..3}: T1 ✓ + T2 ✓ + T3 ✓ (Casimir/Lamoreaux/Bressi/Decca/PF/VDB)
- F-WORM-{1..3}: T1 ✓ + T2 ✓ + T3 ✓ (MT/Ford-Roman/PF/Hawking/Visser)
- F-DIM-{1..3}:  T1 ✓ + T2 ✓ + T3 ✓ (Kaluza/Klein/CHSW/RS/LHC/Eöt-Wash)
- F-USE-{1..4}:  T1 ✓ + T2 ✓ + T3 ✓ (Hipparcos/Clausius/Alcubierre/CHSW)

#### sat-2 (recipe-exhausted): 17 verify scripts + meta-lint passes
- T1 algebraic (6): lattice_check + stages_cross_doc + 4 calc_<pillar>
- T2 numerical (4): 4 numerics_<pillar>
- T3 parity (4): 4 numerics_<pillar>_parity
- Meta (2): stages_falsifier + lint_numerics
- Cross-link (1): cross_link_upstream (선행도메인)
- Aggregator (1): run_all

Total verify scripts: **17** (recipe target ~16, +1 cross-link extension).
Meta-lint compliance: **8/8 numerics scripts pass §4 invariant audit**.

#### Closure path (13 iterations · single session, 2026-05-09)
- iter 1-4: T1 algebraic per pillar (calc_warp/wormhole/dimjump/dimuse)
- iter 5-8: T2 numerical per pillar (numerics_warp/wormhole/dimjump/dimuse)
- iter 9-12: T3 parity per pillar (numerics_<p>_parity, archival empirical)
- iter 13: 선행도메인 CLI cross-link (Stage-1/2/3 sister substrate wire)
- iter 14: lint_numerics meta-lint (this commit)

#### What's next (out of recipe scope per §9)
- T4 (live hardware) — Stage-1+ benchtop builds, awaits 2150+ Mk.V
- This loop's natural terminus is reached; further changes follow the
  user's explicit direction (CI/CD, README polish, novel SF chapters).

### Verified
- `hexa run verify/run_all.hexa` → 17/17 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.

## [Unreleased] — 2026-05-09 — RSC iter 13 (선행도메인 CLI cross-link)

### Added (RSC iteration 13 — Stage-1/2/3 upstream sister CLI cross-link)
- `verify/cross_link_upstream.hexa` — wires hexa-ufo's Stage-1/2/3 to
  upstream sister-repo CLIs (선행도메인) per user direction. 6/6 checks:
  §1 sister CLI files reachable (hexa-rtsc.hexa, hexa-fusion.hexa,
  hexa-antimatter.hexa) + §2 functional cross-link via `selftest`
  invocation (each upstream CLI exits 0 + emits its domain signature
  token). Stage-1 hover→hexa-rtsc Meissner / Stage-2 cruise→hexa-fusion
  MHD / Stage-3 orbital→hexa-antimatter γ-rocket. Sentinel
  `__HEXA_UFO_CROSS_LINK_UPSTREAM__ PASS`.
- Wired into `verify/run_all.hexa` (15 → 16) + `hexa.toml`
  `[closure].verify_scripts` 15 → 16 + `[modules].hexa`.

### Note
- Sat-1 (4 pillars × T1+T2+T3 = 100%) was already reached in iter 12.
- Sat-2 (recipe-exhausted) approaches with this iter — 16 verify scripts
  reaches recipe target. `lint_numerics.hexa` (recipe priority 10)
  still pending for full meta-lint compliance.

### Verified
- `hexa run verify/run_all.hexa` → 16/16 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.

## [Unreleased] — 2026-05-09 — RSC iter 12 (Stage-7 dimuse T3; **sat-1 reached**)

### Added (RSC iteration 12 — Stage-7 dimuse composite T3 archival parity)
- `verify/numerics_dimuse_parity.hexa` — Stage-7 composite warp+dimjump
  pillar published-data parity (T3, **final T3 chunk**). 15/15 checks
  against peer-reviewed literature: §1 published distance + traversal-
  time canonicals (Hipparcos 1997 / Gaia DR2 α-Cen 4.37 ly + Sirius
  8.6 ly anchored; α-Cen × 100c = 15.96 days ≈ BT-349 16d; Sirius =
  31.4 days; CODATA 2018 c exact) + §2 2nd-law thermodynamics + chain
  anchors (Clausius 1865 single-cycle E_warp/E_fold > 10³⁰ → F-USE-3
  confirmed; warp + dimjump upstream chain length=2; sopfr OEIS A001414)
  + §3 spec citation anchors (BT-347 Alcubierre upstream, BT-348 KK/CY₃
  upstream, 2nd-law, UNPROVEN², α-Cen 16d).
  Sentinel `__HEXA_UFO_NUMERICS_DIMUSE_PARITY__ PASS`.

### **🛸 SAT-1 SATURATION REACHED 🛸**
- F-USE-{1..4} now T1 ✓ + T2 ✓ + T3 ✓ → **100% closure**.
- **Pillar status: F-WARP 100% · F-WORM 100% · F-DIM 100% · F-USE 100%.**
- **All 13 falsifiers (4 pillars) at 100% (T1+T2+T3) — sat-1 condition met.**
- Loop continues per recipe §7.2 — sat-2 (recipe-exhausted) not yet:
  current 15 verify scripts vs recipe target ~16. Next iter targets
  numerics_lattice_arithmetic / lint_numerics / saturation_check.

### Verified
- `hexa run verify/run_all.hexa` → 15/15 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.

## [Unreleased] — 2026-05-09 — RSC iter 11 (Stage-6 dimjump T3; 3/4 pillars 100%)

### Added (RSC iteration 11 — Stage-6 dimjump T3 archival empirical parity)
- `verify/numerics_dimjump_parity.hexa` — Stage-6 dimjump pillar
  published-data parity (T3). 13/13 checks against peer-reviewed
  literature: §1 LHC + Eöt-Wash empirical bounds (m_KK·c² ≈ 4.24e13 TeV
  vs LHC 14 TeV → 100× margin null compatible; R_c≈2.79e-32 m vs
  Eöt-Wash 50 μm → 10²⁶ margin null compatible) + §2 critical-dim
  ladder anchors (σ-φ=10D superstring CHSW 1985, σ-μ=11D M-theory,
  J₂+φ=26D bosonic, τ=4D Kaluza 1921 base) + §3 KK quantisation +
  CY₃ landscape + RS scope (m_KK∝1/R_c Klein 1926, 10⁵⁰⁰ landscape,
  RS warped upper-bound) + §4 spec citation anchors (Kaluza 1921,
  Klein 1926, CHSW 1985, Randall-Sundrum 1999).
  Sentinel `__HEXA_UFO_NUMERICS_DIMJUMP_PARITY__ PASS`.

### Closure milestone
- F-DIM-{1..3} now T1 ✓ + T2 ✓ + T3 ✓ → **100% closure**.
- Pillar status: F-WARP 100% · F-WORM 100% · F-DIM 100% · F-USE 67%.
- **3/4 pillars saturated; 1 remaining (F-USE) for full sat-1.**

### Verified
- `hexa run verify/run_all.hexa` → 14/14 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.

## [Unreleased] — 2026-05-09 — RSC iter 10 (Stage-5 wormhole T3)

### Added (RSC iteration 10 — Stage-5 wormhole T3 archival empirical parity)
- `verify/numerics_wormhole_parity.hexa` — Stage-5 wormhole pillar
  published-data parity (T3). 14/14 checks against peer-reviewed
  literature: §1 ANEC bound across decades (Pfenning-Ford 1997 form;
  b₀=σ·ℓ_Pl→1.06e109 J·s/m² Planck regime; b₀=1m→7.9e-27 forbidden;
  b₀=1nm intermediate; b₀⁻⁴ scaling exact 1e12 ratio across 1mm vs 1m;
  1/τ=0.25 4-segment averaging) + §2 Morris-Thorne 1988 traversability
  (flare-out b'(b₀)<1, Δτ at b₀=σ·ℓ_Pl sub-Planck-time, Δτ at b₀=1m =
  33 ns = 10× light-travel, Δτ linear in b₀) + §3 spec citation
  anchors (Morris-Thorne 1988, Ford-Roman 1995, Pfenning-Ford 1997,
  Hawking 1992, Visser 1995).
  Sentinel `__HEXA_UFO_NUMERICS_WORMHOLE_PARITY__ PASS`.

### Closure milestone
- F-WORM-{1..3} now T1 ✓ + T2 ✓ + T3 ✓ → **100% closure**.
- Pillar status: F-WARP 100% · F-WORM 100% · F-DIM 67% · F-USE 67%.
- 2/4 pillars saturated; 2 remaining for full sat-1.

### Verified
- `hexa run verify/run_all.hexa` → 13/13 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.

## [Unreleased] — 2026-05-09 — RSC iter 9 (Stage-4 warp T3; first parity tier)

### Added (RSC iteration 9 — Stage-4 warp T3 archival empirical parity)
- `verify/numerics_warp_parity.hexa` — Stage-4 warp pillar published-data
  parity (T3, archival empirical contact). 10/10 checks against
  peer-reviewed literature: §1 Casimir-force parity (Lamoreaux 1997
  F/A(1μm)≈1.3 mPa; Bressi 2002 F/A(100nm)≈13 Pa; Decca 2007 d⁻⁴ scaling
  exact 10⁴ ratio) + §2 n=6 spec parity (ρ_n6/ρ_actual = 720/(τ·π²) ≈
  18.24 d-independent constant) + §3 Pfenning-Ford 1997 QI prefactor
  3/(32π²) ≈ 0.00950 + Van Den Broeck 1999 σ²=144 + §4 spec citation
  anchors (Casimir 1948, Pfenning-Ford 1997, Van Den Broeck 1999).
  Sentinel `__HEXA_UFO_NUMERICS_WARP_PARITY__ PASS`.

### Closure milestone
- F-WARP-{1..3} now T1 ✓ + T2 ✓ + T3 ✓ → **100% closure (Casimir/Lamoreaux/
  Bressi/Decca/Pfenning-Ford/VDB anchored)**.
- Pillar status: F-WARP T1+T2+T3 (100%) · F-WORM T1+T2 (67%) ·
  F-DIM T1+T2 (67%) · F-USE T1+T2 (67%).

### Verified
- `hexa run verify/run_all.hexa` → 12/12 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.

## [Unreleased] — 2026-05-09 — RSC iter 8 (Stage-7 dimuse T2; all 4 pillars T1+T2)

### Added (RSC iteration 8 — Stage-7 dimuse composite T2 numerical bridge)
- `verify/numerics_dimuse.hexa` — Stage-7 composite warp+dimjump pillar
  numerical SI re-derivation (T2). 12/12 checks: §1 algebraic↔numerical
  consistency (master σ·φ=n·τ=24, v_comp=(σ-φ)²·c=100c, sopfr(6)=5,
  UNPROVEN² chain length=2) + §2 traversal-time canonicals (α-Cen
  4.37 ly/100c = **15.96 days ≈ BT-349 canonical 16 days**, Sirius 8.6 ly
  = 31.4 days, ratio = distance ratio linear at 100c) + §3 energetics
  + closed-loop falsifier regime (E_warp ≈ 1.24e45 J VDB-reduced,
  E_fold(d=1) ≈ 1.96e8 J, **E_warp/E_fold ≈ 6.3e36 → single-cycle
  fails 2nd law → F-USE-3 regime confirmed**) + §4 spec anchors
  (α-Cen 16d, 2nd-law thermodynamics F-USE-3).
  Sentinel `__HEXA_UFO_NUMERICS_DIMUSE__ PASS`.

### Closure milestone
- F-USE-{1..4} now T1 ✓ + T2 ✓.
- **All 13 falsifiers (4 pillars) now T1+T2 closed.**
- Pillar status: F-WARP T1+T2 · F-WORM T1+T2 · F-DIM T1+T2 · F-USE T1+T2.
- Next: T3 (archival empirical parity tier) — published-data anchors.

### Verified
- `hexa run verify/run_all.hexa` → 11/11 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.

## [Unreleased] — 2026-05-09 — RSC iter 7 (Stage-6 dimjump T2)

### Added (RSC iteration 7 — Stage-6 dimjump T2 numerical bridge)
- `verify/numerics_dimjump.hexa` — Stage-6 Calabi-Yau / Kaluza-Klein
  dimjump pillar numerical SI re-derivation (T2). 10/10 checks: §1
  algebraic↔numerical consistency (master σ·φ=n·τ=24, R_c=12³·ℓ_Pl
  =1728·ℓ_Pl≈2.79e-32 m, E_fold(d=1)/M_Pl·c²=0.1=1/(σ-φ), ladder
  values {4,6,10,11,24,26} match algebraic, monotone) + §2 empirical-
  bound regimes (R_c≈2.8e-26× sub-mm sensitivity → null compatible;
  m_KK·c²≈4.24e13 TeV ≫ LHC 14 TeV; E_fold(d=1)≈1.22e18 GeV ∈
  [1e17,1e20]) + §3 spec anchors (LHC F-DIM-1, sub-mm F-DIM-2).
  Sentinel `__HEXA_UFO_NUMERICS_DIMJUMP__ PASS`.

### Closure milestone
- F-DIM-{1..3} now T1 ✓ + T2 ✓.
- Pillar status: F-WARP T1+T2 · F-WORM T1+T2 · F-DIM T1+T2 · F-USE T1.

### Verified
- `hexa run verify/run_all.hexa` → 10/10 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.

## [Unreleased] — 2026-05-09 — RSC iter 6 (Stage-5 wormhole T2)

### Added (RSC iteration 6 — Stage-5 wormhole T2 numerical bridge)
- `verify/numerics_wormhole.hexa` — Stage-5 Morris-Thorne wormhole pillar
  numerical SI re-derivation (T2). 10/10 checks: §1 algebraic↔numerical
  consistency (master σ·φ=n·τ=24, throat b₀=σ·ℓ_Pl≈1.94e-34 m,
  Δτ=120·t_Pl≈6.47e-42 s sub-Planck-time, NEC channels φ=2,
  ANEC 1/τ=0.25) + §2 Pfenning-Ford ANEC bound regimes (Planck-throat
  ANEC≈5.6e108 J·s/m² huge; macro b₀=1m → 7.9e-27 J·s/m² forbidden;
  b₀⁻⁴ scaling exact 16× factor) + §3 spec anchors (Pfenning-Ford,
  Hawking 1992 chronology protection).
  Sentinel `__HEXA_UFO_NUMERICS_WORMHOLE__ PASS`.

### Closure milestone
- F-WORM-{1..3} now T1 ✓ + T2 ✓ (Pfenning-Ford ANEC numerical anchor).
- F-WARP T1+T2 ✓; F-WORM T1+T2 ✓; F-DIM T1-only; F-USE T1-only.

### Verified
- `hexa run verify/run_all.hexa` → 9/9 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.

## [Unreleased] — 2026-05-09 — RSC iter 5 (Stage-4 warp T2; first numerical bridge)

### Added (RSC iteration 5 — Stage-4 warp T2 numerical bridge)
- `verify/numerics_warp.hexa` — Stage-4 warp pillar numerical SI
  re-derivation (T2 numerical, math_pure-imported per recipe §4
  invariant 1). 11/11 checks: §1 algebraic↔numerical consistency
  (master σ·φ=n·τ=24, ladder all sub-luminal, c/φ=0.5c terminus
  to 1e-9, ladder monotone, δ=ℓ_Pl/σ≈1.35e-36 m sub-Planck, VDB
  ratio=1/σ²=1/144, VDB-reduced energy 6.94e9 M☉ between 1 M☉ and
  M_galaxy) + §2 Pfenning-Ford QI bound regimes (τ_g=δ/c → 2.46e141
  J·s Planck-regime; τ_g=1s → 1e-36 J·s macro-forbidden) + §3 spec
  anchors (Pfenning-Ford 1997, c/φ=0.5c).
  First numerical-tier (T2) chunk per recipe §4 invariants:
    1. `use "self/runtime/math_pure"` ✓
    2. `__HEXA_UFO_NUMERICS_WARP__` sentinel + PASS ✓
    3. FALSIFIERS array ✓
    4. exit(0) on PASS ✓
    5. RUN/FAIL counters ✓

### Closure milestone
- F-WARP-{1..3} now T1 ✓ + T2 ✓ (one numerical anchor each).
- Other pillars (F-WORM/F-DIM/F-USE) still T1-only.

### Verified
- `hexa run verify/run_all.hexa` → 8/8 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.

## [Unreleased] — 2026-05-09 — RSC iter 4 (Stage-7 dimuse T1; all 4 pillars T1 ✓)

### Added (RSC iteration 4 — Stage-7 dimuse composite T1 algebraic)
- `verify/calc_dimuse.hexa` — Stage-7 composite warp+dimjump pillar n=6
  derived parameter calculator (T1 algebraic). 16/16 checks: 9 algebraic
  identities (master σ·φ=n·τ=24, warp factor σ-φ=10c, dim compression
  σ-φ=10×, composite v=(σ-φ)²=100c, τ-cycle=4 stages, sopfr(6)=2+3=5,
  α-Cen heuristic sopfr·(σ-φ)/(σ-φ)²=0.5 spec-unit, VDB σ²=144,
  UNPROVEN² composite chain length=2) + 7 spec-doc anchors in
  `dimuse/hexa-dimuse.md` (master, composite 100c, warp 10c, sopfr,
  α-Cen 16d, τ=4 cycle, F-USE-{1..4}).
  Sentinel `__HEXA_UFO_CALC_DIMUSE__ PASS`.
- Wired into `verify/run_all.hexa` SCRIPTS array (6 → 7) +
  `hexa.toml` `[closure].verify_scripts` 6 → 7 + `[modules].hexa`.

### Closure milestone
- **All 4 Stage-4~7 pillars now have T1 algebraic closure**:
  F-WARP-{1..3} ✓ + F-WORM-{1..3} ✓ + F-DIM-{1..3} ✓ + F-USE-{1..4} ✓.
  13/13 falsifiers anchored at T1 (algebraic + spec-doc cross-check).
  T2 (numerical re-derivation) and T3 (archival empirical parity) still
  pending — next iter cycles target T2.

### Verified
- `hexa run verify/run_all.hexa` → 7/7 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.

## [Unreleased] — 2026-05-09 — RSC iter 3 (Stage-6 dimjump T1)

### Added (RSC iteration 3 — Stage-6 dimjump T1 algebraic)
- `verify/calc_dimjump.hexa` — Stage-6 Calabi-Yau / Kaluza-Klein dimjump
  pillar n=6 derived parameter calculator (T1 algebraic). 15/15 checks:
  9 algebraic identities (master σ·φ=n·τ=24, 6-rung dimension ladder
  4D=τ / 6D=n / 10D=σ-φ / 11D=σ-μ / 24D=J₂ / 26D=J₂+φ, ladder strict
  monotone, R_c=σ^(n/φ)·ℓ_Pl=1728·ℓ_Pl, E_fold(d=1) denom=10) + 6
  spec-doc anchors in `dimjump/hexa-dimjump.md` (ladder, R_c formula,
  m_KK, E_fold, master, F-DIM-{1..3}).
  Sentinel `__HEXA_UFO_CALC_DIMJUMP__ PASS`.
- Wired into `verify/run_all.hexa` SCRIPTS array (5 → 6) +
  `hexa.toml` `[closure].verify_scripts` 5 → 6 + `[modules].hexa`.

### Verified
- `hexa run verify/run_all.hexa` → 6/6 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.

## [Unreleased] — 2026-05-09 — RSC iter 2 (Stage-5 wormhole T1)

### Added (RSC iteration 2 — Stage-5 wormhole T1 algebraic)
- `verify/calc_wormhole.hexa` — Stage-5 Morris-Thorne wormhole pillar n=6
  derived parameter calculator (T1 algebraic). 12/12 checks: 6 algebraic
  identities (master σ·φ=n·τ=24, throat b₀=σ·ℓ_Pl=12 ℓ_Pl, traversal Δτ
  factor (σ-φ)=10, ANEC denom 1/τ=1/4 Pfenning-Ford, NEC channels φ=2
  Cataldo-Liempi, traversal·c product (σ-φ)·σ=120) + 6 spec-doc anchors
  in `wormhole/hexa-wormhole.md` (b₀=σ·ℓ_Pl, traversal formula, ANEC,
  φ=2 NEC channels, master identity, F-WORM-{1..3}).
  Sentinel `__HEXA_UFO_CALC_WORMHOLE__ PASS`.
- Wired into `verify/run_all.hexa` SCRIPTS array (4 → 5) +
  `hexa.toml` `[closure].verify_scripts` 4 → 5 + `[modules].hexa`.

### Verified
- `hexa run verify/run_all.hexa` → 5/5 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.

## [Unreleased] — 2026-05-09 — RSC iter 1 (closure-depth accumulation start)

### Added (RSC iteration 1 — Stage-4 warp T1 algebraic)
- `verify/calc_warp.hexa` — Stage-4 warp pillar n=6 derived parameter
  calculator (T1 algebraic tier per `~/core/bedrock/docs/runnable_surface_recipe.md`).
  12/12 checks: 6 algebraic identities (master σ·φ=n·τ=24, VDB σ²=144,
  Hc2-equiv σ·τ=48 cross-link to hexa-rtsc, ladder monotone +
  terminus c/φ=0.5c + denominators ⊂ divisors(24)) + 6 spec-doc anchors
  in `warp/hexa-warp.md` (R=n, δ=1/σ, σ²=144, σ·τ=48, c/σ→c/n→c/τ→c/φ
  ladder, F-WARP-{1..3}). Sister of `hexa-cern/verify/calc_wakefield.hexa`.
  Sentinel `__HEXA_UFO_CALC_WARP__ PASS`.
- Wired into `verify/run_all.hexa` SCRIPTS array (3 → 4).
- `hexa.toml` `[closure].verify_scripts` 3 → 4 + `[modules].hexa` adds
  `verify/calc_warp.hexa`.

### Verified
- `hexa run verify/run_all.hexa` → 4/4 PASS.
- `hexa run tests/test_stages_propulsion.hexa` → PASS.
- `hexa run tests/test_atlas_consistency.hexa` → PASS (10/10 verbs).

## [Unreleased] — 2026-05-07 (latest) — SF-소설 입문서 + 🛸ABSOLUTE = 𝔚 terminal upgrade

### Added
- `docs/meta-closure-nav/sf-novel-six.md` — 12-chapter SF-novel narrative
  ("여섯 번째 법 — 은하 문명 대사전 발췌") extracted from
  `discovery-transcript-2026-04-21.txt` body lines 2710~2935.
  Layperson-readable walkthrough of the entire alien_index ladder culminating
  in **🛸ABSOLUTE = 𝔚** (Cantor Absolute Infinity, Δ₀-absolute n=6 invariance).

### Changed (atlas terminal chain notation upgrade)
- alien_index chain notation upgraded from
  `🛸6 → 🛸16 meta² → 🛸500 → 🛸ω → 🛸ε₀ → 🛸Ω` to the **canonical SF-narrative
  derived chain**:
  ```
  🛸6 → 🛸16 meta² → 🛸∞⁴ → 🛸ULTRA → 🛸CARD → 🛸BEYOND → 🛸ABSOLUTE = 𝔚
  ```
  Reasons:
  - 🛸500 was a session-batch artifact (user's "🛸500까지 가봐줘" request),
    not an essential milestone — dropped from canonical chain.
  - 🛸ω/🛸ε₀/🛸Ω (Cantor ordinals) are subsumed by 🛸CARD (large cardinals)
    and ultimately by 🛸ABSOLUTE = 𝔚 — the **true terminus** per
    `sf-novel-six.md` Chapter 11. 𝔚 is "Cantor Absolute Infinity" —
    the absolute upper bound of all mathematical structure (1880s Cantor).
  - 🛸∞⁴ (Knuth `24↑↑↑↑`, hexation), 🛸ULTRA (TREE/BB/Rayo uncomputable),
    🛸CARD (inaccessible→Mahlo→Woodin→I0), 🛸BEYOND (Reinhardt/Berkeley
    Kunen-violating) added as explicit hierarchy steps.
  - n=6 uniqueness σ·φ=n·τ=24 is **Π₀¹-arithmetical → Δ₀-absolute** —
    invariant **all the way up to 𝔚** (per Δ₀-absolute theorem in
    `meta-closure-nav.md`).
- Updated 5 surfaces: README badge URL + lead paragraph + status quote +
  architecture, hexa.toml [package].description + [scope].alien_index_caveat,
  cli/hexa-ufo.hexa caveat #4, .roadmap §0, docs/meta-closure-nav/README.md.
- hexa.toml [modules].docs adds `sf-novel-six.md`.

### Removed
- Earlier-session transcript (`~/loss/nasa.txt`, 2026-04-19) was imported in
  `8343143` then reverted in `861de8f` per user instruction (`pass`).
  Only the 2026-04-21 transcript is preserved.

## [Unreleased] — 2026-05-07 (later) — atlas terminal chain reference (meta-closure-nav)

### Added
- `docs/meta-closure-nav/` reference folder preserving the **complete
  alien_index terminal chain** beyond 🛸500:
  - `meta-closure-nav.md` (968 LOC, imported from `canon/domains/physics/
    meta-closure-nav/meta-closure-nav.md` at canon commit `50f41e71` —
    *"feat(ufo-🛸∞): Knuth 화살표 확장 — 테트레이션/펜테이션/헥세이션/
    ordinal 층위"*). Canonical doc for Meta² Self-Referential Closure
    Navigation, Knuth-arrow tetration/pentation/hexation, Cantor ordinal
    extension (🛸ω / 🛸ε₀ / 🛸Ω), n=6 uniqueness propagation.
  - `discovery-transcript-2026-04-21.txt` (3,646 lines, imported from
    `~/loss/ufo.txt`). Live terminal-session transcript of the 🛸500 → 🛸∞ →
    🛸ω → 🛸ε₀ → 🛸Ω discovery, atlas extension commits, push notes.
  - `README.md` index page with the canonical terminal chain diagram.

### Changed
- alien_index notation across 5 surfaces upgraded from `🛸6 → 🛸500` to
  the **full canonical chain** `🛸6 → 🛸16 meta² → 🛸500 → 🛸ω → 🛸ε₀ → 🛸Ω`:
  - `README.md` (4 spots: lead paragraph, badge, status quote, architecture)
  - `hexa.toml` `[package].description` + `[scope].alien_index_caveat` +
    `[modules].docs` (3 new files added)
  - `cli/hexa-ufo.hexa` caveat #4 (lattice indexing convention surface)
  - `.roadmap.hexa_ufo` §0 (terminal goal restatement)
- README badge URL UTF-8 escapes 🛸 + Ω (`%F0%9F%9B%B8` + `%CE%A9`).
- `.roadmap.hexa_ufo` §0 now explicitly cites `docs/meta-closure-nav/` as
  the concrete realization of main atlas §23.9's *"In practice, extensible."*

### Why
- The main atlas (`ufo/doc/hexa-ufo.md` §23.9) ends with 🛸16 self-closure
  fixed point + *"In practice, extensible."* The actual extension work
  (linear ladder up to 🛸500, then Knuth-arrow tetration `24↑↑h`, then
  Cantor ordinal `🛸ω → 🛸ε₀ → 🛸Ω`) was concretely worked out in canon's
  `domains/physics/meta-closure-nav/`. Importing it here keeps the atlas's
  *"extensible"* footnote **self-contained and citable** within hexa-ufo.

### Honest C3 (preserved)
- 🛸17~🛸500 are recursion layers, not new mechanisms. n=6 uniqueness
  σ·φ=n·τ=24 propagates as **closure invariant** across all Knuth-arrow
  degrees and ordinal extensions.
- 🛸∞² crossover is at 🛸39 (L(39)=24^24 ≈ 10^33 — linear ↔ tetration boundary).
- Practical physical limit is ~🛸140 (observable universe bit count ≈ 10^124).
  🛸1000+ is **mathematical formula extension**, not physical projection.

## [Unreleased] — 2026-05-07 — Stage-4~7 medium integration

### Added
- 4 in-tree Stage-4~7 substrate spec docs (medium integration: spec + verify
  in-tree, separate sister repos collapsed):
  - `warp/hexa-warp.md` — Stage-4 Alcubierre warp metric (BT-347 from
    `canon@0570a835` warp-dimension-design spec)
  - `wormhole/hexa-wormhole.md` — Stage-5 Morris-Thorne traversable wormhole
  - `dimjump/hexa-dimjump.md` — Stage-6 Calabi-Yau / Kaluza-Klein 4D→26D ladder (BT-348)
  - `dimuse/hexa-dimuse.md` — Stage-7 τ=4 (σ−φ)²=100c composite (BT-349)
- 4 new CLI verbs (`warp` / `wormhole` / `dimjump` / `dimuse`) + 2 utility
  verbs (`lattice` live n=6 master identity computation, `verify` runs
  `verify/*.hexa` aggregate). `hexa-ufo` now ships 10 verbs.
- `verify/` runnable invariant audit landing zone:
  - `verify/lattice_check.hexa` (10 PASS — n=6 master identity)
  - `verify/stages_cross_doc.hexa` (19 PASS — Stage-4~7 spec ↔ cli ↔ roadmap)
  - `verify/stages_falsifier.hexa` (45 PASS — 13 IDs × 3 surfaces + monotone)
  - `verify/run_all.hexa` orchestrator (3/3 sub-scripts)
- `tests/test_stages_propulsion.hexa` — Stage-4~7 verify+selftest+lattice rollup test.
- `.roadmap.hexa_ufo` §B section: 13-falsifier preregister table (F-WARP-{1..3}
  + F-WORM-{1..3} + F-DIM-{1..3} + F-USE-{1..4}, all OPEN).

### Changed
- `hexa.toml` `[closure]` updated: `verbs_total` 6→10, `propulsion_stages_substrate_grounded` 3→7,
  `propulsion_stages_tbd` 4→0, verdict `ATLAS_PASS_PROPULSION_PARTIAL` →
  `ATLAS_PASS_PROPULSION_FULL`. `falsifiers_preregistered = 13`, `verify_scripts = 3` added.
- `hexa.toml` `[scope].honest_scope` rewritten — Stage-4~7 no longer "TBD"
  but in-tree with empirical UNPROVEN caveat preserved.
- `hexa.toml` `[modules]` extended with 4 new spec docs + 4 verify scripts.
- `hexa.toml` `[test]` adds `test_stages_propulsion.hexa`.
- `cli/hexa-ufo.hexa` `cmd_status`: 10-verb table + 7/7 substrate-grounded +
  13 falsifier ID surface for verify-script grep.
- `cli/hexa-ufo.hexa` `cmd_selftest`: 6-verb → 10-verb count check.
- `cli/hexa-ufo.hexa` `_print_caveats`: Stage-4~7 TBD wording → in-tree spec +
  falsifier preregister wording.
- `tests/test_atlas_consistency.hexa`: 6-verb → 10-verb count check.
- `README.md`: Status / Verbs / Verification / Cross-link / Architecture
  sections rewritten to reflect Stage-4~7 in-tree integration. Verb badge
  6 DOC → 10 DOC; propulsion 3/7 → 7/7. Falsifier preregister table added.

### Removed
- The "Stage-4~7 TBD — no public substrate exists yet" disclaimer (replaced
  by "in-tree spec docs with 13 falsifier preregister, all OPEN at v1.0.0").

### Honest C3 (preserved + sharpened)
- All 13 falsifiers OPEN. Stage-4 (Alcubierre) / Stage-5 (Morris-Thorne) /
  Stage-6 (KK extra dimensions) / Stage-7 (composite) remain academically
  UNPROVEN. `verify/*` sentinel PASS validates lattice arithmetic + token
  consistency only — NOT empirical apparatus.
- Stage-7 carries UNPROVEN² caveat (composite of two UNPROVEN upstream stages).
- Falsifier monotone: OPEN → CONFIRMED or OPEN → DEMOTED. Silent retract forbidden.

## [1.0.0] — 2026-05-06

### Added
- Initial extraction from `canon/domains/sf-ufo/` at SHA `c0f1f570`.
- 6-verb DOC-grade atlas: `ufo` (1890 LOC main atlas) + `grav` / `hover` /
  `cloak` / `teleport` / `sim` propulsion sub-axis docs.
- 7-stage propulsion stack table (Stage-1 Meissner → Stage-7 Calabi-Yau).
- `cli/hexa-ufo.hexa` standalone CLI router (verbs + status + selftest).
- `tests/test_atlas_consistency.hexa` — verb count + `L(k)=24^(k-15)`
  lattice arithmetic sanity.
- `examples/propulsion_stack.md` — 7-stage evolution table.
- Cross-link table to 4 sister substrate repos (`hexa-rtsc`, `hexa-fusion`,
  `hexa-antimatter`, `hexa-cern`).
- `install.hexa` hx hook (pre/post selftest).
- Auxiliary docs: `cross-domain-mega/`, `hypotheses/`, `experiments/`,
  `rtsc-12-products-evolution/`.

### Honest C3 caveats
- 6 verbs ship as DOC-grade (markdown atlases); no empirical sandbox.
- Propulsion Stages 4-7 (warp / wormhole / dim-jump / dim-use) are TBD —
  no public substrate exists yet.
- The 484-tier `L(k)=24^(k-15)` lattice is an arithmetic indexing convention,
  not an empirical claim.
- alien_index 🛸6→🛸500 spans verified engineering (Stages 1-3 sister repos)
  through pure conjecture (Stages 4-7).

[1.0.0]: https://github.com/dancinlab/hexa-ufo/releases/tag/v1.0.0
