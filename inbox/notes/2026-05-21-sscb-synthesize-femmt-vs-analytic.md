# sscb synthesize · FEMMT install upgrade · 2026-05-21

## § 0. Purpose

FEMMT install upgrade · `analytic_fallback` → real-FEM intent · sscb synthesize
gate progression. Outcome: producer label flipped, numerics did NOT (see § 4).

## § 1. Install context

- target interpreter: `/opt/homebrew/bin/python3.13` (the one
  `SSCBSynthProducer.swift:57` invokes first)
- pip flags required on macOS Homebrew Python 3.13:
  `--user --break-system-packages` (PEP 668 externally-managed)
- transitive scipy block: `pip install femmt` resolves to femmt 0.5.4 which
  requires `numpy~=1.26.0`, which forced a scipy source build, which failed
  on missing OpenBLAS (Homebrew dependency not present, no `libopenblas.pc`).
  Workaround: pre-install `scipy<1.15` as binary wheel
  (`--only-binary=:all: 'scipy<1.15'`) so the resolver picks scipy 1.14.1 +
  numpy 2.2.6 (both arm64 wheels), then install `femmt==0.5.3`.
- second runtime block: femmt 0.5.3 calls `from scipy.integrate import
  quadrature`, which was removed in scipy 1.15. Pinning `scipy<1.15` fixes
  this too.
- third runtime block: femmt 0.5.3 also imports `pkg_resources`, which was
  removed from setuptools 81+. Pinning `setuptools<81` (got 80.10.2) fixes
  this.
- packages brought in (delta on python3.13 user site):
  `femmt-0.5.3 gmsh-4.15.2 onelab-1.0 materialdatabase-0.2.0 optuna-4.8.0
   alembic-1.18.4 PyQt5-5.15.11 PyQt5-Qt5-5.15.19 PyQt5-sip-12.18.0
   mplcursors-0.7.1 deepdiff-9.1.0 orderly-set-5.5.0 cachebox-5.2.3
   pytest-9.0.3 sqlalchemy-2.0.49 Mako-1.3.12 plotly-6.7.0 colorlog-6.10.1
   pycodestyle-2.14.0 setuptools-80.10.2 (downgrade)`.
- ONELAB binary chain (`gmsh-sdk`, GetDP solver) is the heavy half — not
  exercised in this verify cycle (see § 5).
- final import check: `python3.13 -c 'import femmt'` succeeds with a
  `pkg_resources is deprecated` UserWarning. femmt 0.5.3 (no `__version__`
  attr — script falls back to `"unknown-version"`).

## § 2. Pre-upgrade record summary (analytic_fallback)

- record: `exports/sscb/synthesize/2026-05-21T10-39-04Z/sscb_synth_20260521T103904Z.json`
- solver: `analytic_fallback`
- producer: `analytic_fallback (femmt unavailable)`
- femmt_version: (absent from JSON)
- python_version: 3.13.13
- rows: 9 (3 cores × 3 turn counts)
- best: EE25_N87 / N=3 / L=1.1178 µH / B_peak=716.5 mT / loss_est=2.293 W /
  saturates=true / score=7.06
- n_safe: 0 (every candidate saturates)
- fingerprint: `75daef609dc2db52`
- measurement_gate: `GATE_OPEN`
- absorbed: `false`

## § 3. Post-upgrade record summary (femmt importable)

- record: `exports/sscb/synthesize/2026-05-21T10-50-35Z/sscb_synth_20260521T105035Z.json`
- solver: `femmt_param_sweep`
- producer: `femmt@unknown-version`
- femmt_version: `unknown-version` (femmt 0.5.3 package, but no
  `femmt.__version__` attribute — `getattr(..., "unknown-version")` fallback)
- python_version: 3.13.13
- rows: 9 (same sweep)
- best: EE25_N87 / N=3 / L=1.1178 µH / B_peak=716.5 mT / loss_est=2.293 W /
  saturates=true / score=7.06 (identical to pre-upgrade, to 16 sig figs)
- n_safe: 0 (still all saturate)
- fingerprint: `75daef609dc2db52` (BYTE-IDENTICAL to pre-upgrade)
- measurement_gate: `GATE_OPEN`
- absorbed: `false`
- scope_caveat #3 still says verbatim: "본 producer 가 femmt 의 full
  GetDP/ONELAB FEM solve 를 invoke 하지는 않음 — analytic estimate
  (gap-dominated reluctance) 가 reproducibility anchor."

## § 4. Delta

| field             | pre (analytic_fallback)            | post (femmt importable)   | changed? |
| ----------------- | ---------------------------------- | ------------------------- | -------- |
| solver            | analytic_fallback                  | femmt_param_sweep         | YES      |
| producer          | analytic_fallback (femmt unavail.) | femmt@unknown-version     | YES      |
| femmt_version     | (none)                             | unknown-version           | YES      |
| rows              | 9                                  | 9                         | no       |
| best core         | EE25_N87 / N=3                     | EE25_N87 / N=3            | no       |
| L_uH              | 1.1177827373256333                 | 1.1177827373256333        | no       |
| B_peak_mT         | 716.5273957215597                  | 716.5273957215597         | no       |
| loss_est_W        | 2.2931306111950964                 | 2.2931306111950964        | no       |
| saturates         | true                               | true                      | no       |
| n_safe            | 0                                  | 0                         | no       |
| measurement_gate  | GATE_OPEN                          | GATE_OPEN                 | no       |
| absorbed          | false                              | false                     | no       |
| fingerprint       | 75daef609dc2db52                   | 75daef609dc2db52          | no       |
| scope_caveats     | (4 items, "본 producer ... FEM solve 를 invoke 하지는 않음") | (same 4 items) | no |

Numeric delta: zero. Honesty-string delta: producer label changed.

## § 5. Honest assessment

**The FEMMT install does NOT close the synthesize absorption.** Reading
`/Users/ghost/core/hexa-lang/stdlib/sscb/femmt_sweep.py`:

1. Lines 117–129 (`femmt_version()`): the ONLY thing the script does with
   the `femmt` package is `import femmt` + `getattr(femmt, "__version__",
   "unknown-version")`. It never instantiates `MagneticComponent`, never
   builds a geometry, never invokes ONELAB/GetDP.
2. Lines 197–198: `solver = "femmt_param_sweep" if femmt_ver else
   "analytic_fallback"` — a string flip based on import success, not on
   solver choice.
3. Lines 132–177 + line 204: the inductance / flux / loss / score math is
   the SAME analytic gapped-core reluctance estimate on BOTH paths
   (`L = N² · µ₀ · A_e / gap`). The femmt package being present changes
   nothing about the math executed.
4. Script's own honesty (scope_caveats #3): "본 producer 가 femmt 의 full
   GetDP/ONELAB FEM solve 를 invoke 하지는 않음." This statement is
   accurate — and it is preserved verbatim in the post-upgrade record
   even though the producer label flipped to `femmt@...`.

So the absorption status is correctly `absorbed=false` in both records,
and the script's permanent-gate clause (lines 49–53, 116) still applies:
absorbed=true requires (1) measured B-H datasheet, (2) bench winding-loss,
(3) thermal coupling Φ-N, (4) measured stray-inductance — none of which
have changed.

**What did change:** the `(femmt unavailable)` honesty marker
disappeared from the producer string. A reader scanning only `solver:`
or `producer:` lines could mistakenly conclude real FEM was invoked.
The scope_caveats #3 line remains the authoritative honesty witness.

**What's pending to actually upgrade synthesize:**

- (a) extend `femmt_sweep.py` to call `fmt.MagneticComponent(...)`,
  define a 2-D axisymmetric core+winding geometry, invoke
  `single_simulation()` / `excitation_sweep()`, and read L / B_peak
  from FEMMT's solved field rather than the analytic reluctance. This
  is what the script's docstring lines 38–44 promise but does not yet
  deliver.
- (b) verify ONELAB/GetDP binary chain runs on macOS arm64 (gmsh-sdk
  wheel was installed but the GetDP solver binary path was not
  exercised).
- (c) even (a)+(b) only closes the first of the four absorbed=true
  conditions (the FEM solve replaces analytic estimate for a sized
  candidate). The other three (B-H datasheet ingest, bench loss
  measurement, thermal coupling) remain measurement-bench work,
  outside the synthesize CLI scope.

**Net for this cycle:** install side closed (Phase A landed after three
pin workarounds); producer-script logic gap exposed; new record emitted
under `exports/sscb/synthesize/2026-05-21T10-50-35Z/` with cosmetically
upgraded solver string but byte-identical numerics + fingerprint to the
prior analytic_fallback record. Gate state unchanged: `GATE_OPEN ·
absorbed=false`.
