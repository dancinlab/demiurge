# Changelog — hexa-aura

All notable changes to `hexa-aura` will be documented in this file.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/);
versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] — 2026-05-11 — RSC priority-6: 4 solver scripts (2nd T2 stack per pillar)

Closure-depth accumulation, recipe §7.4 priority 6 — adds a mini-ODE solver per
pillar (the 2nd T2 rung for each falsifier), so the verify surface goes 19 → 23
scripts and each falsifier now has T2 ×2. After this the recipe inventory is
exhausted: sat-1 (all falsifiers 100% closure) ∧ sat-2 (full §1+ inventory +
`lint_numerics` PASS + ≥9 `numerics_*.hexa`) → `saturation_check` emits
`__HEXA_AURA_RSC_SATURATED__ STOP`. Post-saturation cron/loop firings run the
health-check only (recipe §9.1) — no forced chunks.

### Added — 4 solver scripts (`verify/numerics_*_solver.hexa`)
- `numerics_clip_solver.hexa` — clip-anchor wobble: damped torsional oscillator
  `I·θ'' + b·θ' + κ·θ = M_jaw(t)` with `I = (1/3)·(σ·n/10)·(J₂)²`, leapfrog (KDK)
  over one τ=4-phase chew cycle. PASS = peak wobble |θ_max| < 0.05 rad (clip stays
  seated), ω0 ≫ chewing band, closing energy bounded (no integrator blow-up). [F-AURA-1, 1a]
- `numerics_coil_solver.hexa` — RT-SC drive-loop RL ODE `L·dI/dt = V − R·I`
  (L = 1 μH nano-coil, ~10 μs write pulse), two cases: R = 0 (SC loop) and
  R = 50 mΩ (parasitic lead). PASS = SC current ramps to ~mA then HOLDS (R=0 ⇒
  persistent, 0 dissipation), parasitic-lead avg power (energy/frame × 200 Hz) ≪ 50 mW
  driver budget. [F-AURA-2, 2c]
- `numerics_cortex_solver.hexa` — leaky-integrate-and-fire neuron under the
  injected write field `τ_m·dV/dt = −(V − V_rest) + R_m·I_inj(t)`, injection ON 60 ms
  / OFF 40 ms. PASS = fires under injection, first-spike latency within the sopfr=5 ms
  regime, NO spurious off-phase firing (write loop stable), percept-band rate, V relaxes
  to V_rest. [F-AURA-3, 3a/3b/3c]
- `numerics_safety_solver.hexa` — transient 1-node Pennes bioheat
  `ρc·dT/dt = q_gen − w_b·ρ_b·c_b·(T − T_a)` (q_gen = SAR·ρ at the design SAR),
  forward-Euler to 5·τ_th. PASS = monotone, NO overshoot, steady-state ΔT ≤ φ/τ = 0.5 K
  (matches `numerics_safety` closed-form), ΔT(3·τ_th) ≈ 0.95·ΔT_ss, Euler ≈ analytic
  within 1 %. [F-AURA-4, 4c]

### Changed — wiring
- `cli/hexa-aura.hexa`: `VERIFY_SUBS` + `_verify_script()` + `_print_verify_help()` + `cmd_help()` add
  `numerics-{clip,coil,cortex,safety}-solver` (23 verify subs total).
- `verify/lint_numerics.hexa`: `NUMERICS_SCRIPTS` → 14 entries (the solvers match the `numerics_*.hexa` glob).
- `tests/test_calculators.hexa`: `CASES` → 23 cases.
- `verify/saturation_check.hexa`: `REQUIRED` → 22 scripts (recipe §1 inventory now includes the per-pillar solvers).

- 0 `.py` added. The solver scripts are closed-form internal consistency (deterministic
  mini-ODE integrators) — NOT physical experiments. The cortex LIF stub's firing rate is
  super-physiological (artifact of a simple LIF + strong drive); the check only requires the
  loop be *stable* and *latency-bounded*, not biologically calibrated. F-AURA-1/2/3/4 (15 sub-IDs)
  remain **all OPEN**; code-layer 3-tier closure stays 100% (the solvers add T2 *depth*, not closure).
  NOTE: `hexa` runtime still unavailable in the authoring environment — solvers hand-checked, not executed.

## [1.0.0] — 2026-05-10 — full design (4 pillars + RSC verify surface)

`hexa-aura` brought up to the `hexa-cern` / `hexa-chip` / `hexa-ufo` level — a complete
post-aural BCI **chip + form-factor substrate** with a 4-pillar spec set, a 5-doc atlas, a
19-script RSC (Runnable Surface Construction) verify surface, a CLI `verify [<sub>]`
dispatcher, a 5-test suite, a PDF build pipeline, and a numerics-methodology reader's map.

### Added — 4 pillar spec docs (n=6 substrate)
- `clip/doc/mastoid-clip.md` — **HEXA-MASTOID-CLIP** (form-factor): φ=2 clips, σ·n/10 = 3.6 g/side
  (7.2 g pair, AirPods-Pro 5.4 g class), τ=4-point passive anchor (helix root · mastoid tip ·
  ear-canal entry · concha cymba), sopfr=5 mm temporal-bone window, hair-hidden (visibility 0),
  bone-conduction back-channel, mass split 1/3+1/3+1/6+1/6 = 1. Falsifier **F-AURA-1** (1a/1b/1c).
- `coil/doc/rt-sc-nanocoil.md` — **HEXA-RT-SC-NANOCOIL** (transducer): μ=1 μm litho pitch,
  σ²=144 ch/tile, J₂=24 ch/macro-tile (6 micro-tiles → 1 macro, 36:1 read-mux), n^τ=6⁴=1296-ch
  hexagonal cortical-column lattice (Neuralink-N1 1024-ch parity·+), σ³=1728-electrode-equivalent
  beamforming, τ=4 multiplex phases ≤ sopfr=5 ms → 200 Hz read frame, φ=2 directions/channel
  (read pick-up loop / write drive loop), RT-SC @ ambient (cross-link `hexa-rtsc`). Falsifier
  **F-AURA-2** (2a/2b/2c).
- `cortex/doc/cortical-interface.md` — **HEXA-CORTICAL-IF** (cortical I/O): σ=12 cortical
  target zones (A1·A2·V1·V2·V4·V5·V6·S1·S2·M1·PFC·hipp-relay), τ=4 operating modes (sense·inject·
  sync·sleep), τ=4 cortex layers tapped of n=6, φ=2 directions, sopfr=5 ms latency / ≤5 simultaneous
  HB zones, σ·τ=48 K-class virtual-retina px budget, and the **18 wearables → φ=2 clips** collapse
  map (earbuds→A1, AR glasses→V1~V6, e-skin→S1, exoskeleton→M1, …). Falsifier **F-AURA-3** (3a/3b/3c/3d).
- `safety/doc/cortical-safety.md` — **HEXA-CORTICAL-SAFETY** (caps): Shannon charge-density
  k ≤ 1.5 (= round-up of sopfr/τ = 1.25; damage line k ≈ 1.85), local 10 g-avg SAR ≤ φ = 2 W/kg
  (ICNIRP-2020 / IEEE-C95.1-2019), steady-state heating ΔT ≤ φ/τ = 0.5 K (CEM43), τ=4-tier
  EEG-watchdog with μ=1 → 1 % false-alarm floor, τ=4-layer biocompatible coating with φ·σ = 24-yr
  design life, no-craniotomy / external-only (≥ μ=1 mm skin clearance, 0 implanted material),
  MRI-conditional (IEC 60601-1 / ASTM F2503), λ=2 single-fault-tolerant redundancy lanes, n=6
  thermal-sensor ring, J₂-scaled sliding-window energy cutoff. Falsifier **F-AURA-4** (4a/4b/4c/4d/4e).

### Added — RSC verify surface (19 scripts, T1 + T2 + T3 + cross-cutters + meta)
- `verify/lattice_check.hexa` — n=6 invariant lattice audit across roadmap + 4 pillars + 5 atlas docs (T1 cross-cutter).
- `verify/cross_doc_audit.hexa` — cross-pillar anchor agreement: shared mass/channel/cap tokens, falsifier IDs, published-reference names, cross-links (T1 cross-cutter).
- `verify/calc_clip.hexa` / `calc_coil.hexa` / `calc_cortex.hexa` / `calc_safety.hexa` — per-pillar n=6 algebraic derivations (T1 ×4).
- `verify/numerics_clip.hexa` (mass band / anchor pressure / bone-conduction loss / inertia) ·
  `numerics_coil.hexa` (channel ratios / low-f skin depth / SQUID-stage-limited read SNR / write focal contrast / array factor) ·
  `numerics_cortex.hexa` (channel-count comparisons / Shannon read-channel capacity / pixel budget / zone-frame budget / honest-gap flags) ·
  `numerics_safety.hexa` (Shannon damage line / SAR form / Pennes-bioheat ΔT / watchdog ROC / J₂ energy cutoff) — `math_pure` closed-form re-derivations (T2 ×4).
- `verify/numerics_clip_parity.hexa` (BTE hearing-aid / Shokz / AirPods-Pro / eyeglass-temple / Cochlear-N7 / Google-Glass) ·
  `numerics_coil_parity.hexa` (SQUID-MEG / OPM-MEG / TMS figure-8 / Neuralink-N1 / Utah / Stentrode / Argus-Orion) ·
  `numerics_cortex_parity.hexa` (cochlear-implant / Argus-II + Orion / Flesher-2016 ICMS / BrainGate-handwriting / speech-BCI WPM / Wodlinger arm) ·
  `numerics_safety_parity.hexa` (ICNIRP-2020 / IEEE-C95.1-2019 / Shannon-1992 / McCreery / CEM43 / Rossi-2009 / ASTM-F2503 / IEC-60601 / FDA-KFDA pathway) — published-reference parity (T3 ×4).
- `verify/numerics_cross_pillar.hexa` — shared n=6-derived anchors resolve to the same float value across all 4 pillars (T2 cross-cutter).
- `verify/numerics_lattice_arithmetic.hexa` — `math_pure` float↔int precision floor (sqrt/pow/log/exp reproduce the n=6 integer anchors).
- `verify/falsifier_check.hexa` — F-AURA-1/2/3/4 closure-pct tracker (3-tier ladder; verifies all 12 tier-scripts on disk + 15 sub-IDs intact in roadmap §B).
- `verify/lint_numerics.hexa` — meta-lint: every `numerics_*.hexa` follows the 5 RSC invariants (`math_pure` import, sentinel, `FALSIFIERS` list, `exit(0)`, `RUN`/`FAIL` counters) + inventory-drift detector.
- `verify/saturation_check.hexa` — RSC sat-1 (all falsifiers 100% closure) ∧ sat-2 (16-script inventory + ≥9 numerics) → `__HEXA_AURA_RSC_SATURATED__ STOP`.

### Added — CLI, tests, build, methodology
- `cli/hexa-aura.hexa` rewritten — 4 pillar verbs (`clip`/`coil`/`cortex`/`safety`) + 5 atlas verbs + `status` + `selftest` (4 pillar + 5 atlas presence + n=6 lattice sanity) + `verify [<sub>]` (19-runner aggregator, matching the `hexa-cern` pattern). `__HEXA_AURA_SELFTEST__ PASS` / `__HEXA_AURA_<VERB>__ PASS` sentinels.
- `tests/test_selftest.hexa` updated to 4 pillar + 5 atlas + roadmap; `tests/test_lattice.hexa` (n=6 closure regression); `tests/test_calculators.hexa` (full 19-script RSC surface, SKIP-on-timeout); `tests/test_cli_verify.hexa` (CLI surface faithfully exposes the verify contract); `tests/test_all.hexa` (aggregator). Wired into `hexa.toml [test].files` (5 tests).
- `build/Makefile` + `build/header.tex` — pandoc + xelatex pipeline for 5 spec PDFs (4 pillars + main atlas `neuro`); `make check` toolchain probe; `build/out/` gitignored.
- `docs/numerics_methodology.md` — reader's map of the 19-script verify surface (3-tier evidence ladder, per-pillar mapping, the 5 lint invariants, cross-cutters, saturation criteria, test layer, honest-C3 disclaimer).

### Added — repo-level
- `.roadmap.hexa_aura` — SSOT: §0 terminal goal, §A.1 invariant lattice (n=6), §A.2 release cadence, §A.3 cycle history, §A.4 + §B falsifier preregister (F-AURA-1/2/3/4 + 15 sub-IDs, all OPEN, monotone), §A.5 pending decisions, §A.6 Stage-1+ hardware path (out of RSC code-layer scope; all steps unstarted).
- `CHANGELOG.md` (this file), `RELEASE_NOTES_v1.0.0.md`.
- `hexa.toml` expanded — `[verbs]` 4 pillars + 5 atlas, `[modules]` full file manifest, `[crosslink]` 9 sister repos, `[closure]` (`verdict = SPEC_FIRST_RSC`, 100% code-layer T1+T2+T3), `[scope]` honest-C3 disclaimer.

### Changed
- `verdict` `BUNDLE_FIRST` → `SPEC_FIRST_RSC`. Version `0.1.0` → `1.0.0`.
- `README.md` rewritten: 4-pillar table, atlas table, scope-discipline matrix, RSC verify-surface table, falsifier preregister, honest-C3 status section, architecture tree, cadence.
- `TODO.md` §3 (the v1.0.0 author plan) marked done; new §6 added for v1.1.0+ cross-verify and §A.6 hardware path.

- 0 `.py` added — all new runnable code is `.hexa`.
- `verify/*` sentinel PASS = n=6 lattice + token consistency + published-reference parity *arithmetic* — NOT in-vivo validation, NOT a built device, NOT regulatory clearance.
- F-AURA-1 / F-AURA-2 / F-AURA-3 / F-AURA-4 (15 sub-IDs) — **all OPEN**. Code-layer 3-tier closure 100%; T4 (Stage-1+ in-vivo / regulatory) = `.roadmap.hexa_aura §A.6`, out of RSC scope, all steps unstarted.
- The 2 ✦ KR atlas docs (`neuro`, `brain-computer-interface`) carry intentional drift vs current canon paths (historical restoration; `TODO.md` §1).

## [0.1.0] — 2026-05-10 — 5-doc CHIP-substrate bundle (superseded by v1.0.0)

- `BUNDLE_FIRST`: 5-doc bundle (neuro / brain-computer-interface / hexa-neuromorphic / l9-field-photon-neuro / neuroscience) from `canon@5458b7d1` + 2 historical SHAs; thin CLI dispatcher; placeholder selftest. Commits `3824ef2` / `526ee8d` / `0366afb`.

## [0.1.0-pre] — 2026-05-09 — 11-doc bundle (superseded)

- 11-doc bundle with cognitive + sensory verbs co-located; split out per `canon/domains/cognitive/_standalone_repos.md` (cognitive → `hexa-mind`, sensory → `hexa-senses`).
