# numerics_methodology — hexa-aura RSC verify surface, a reader's map

> Why are there 19 `verify/*.hexa` scripts and what do they collectively claim?
> This is the "reader's map" so a newcomer doesn't have to read 19 file headers.
> Companion of `hexa-cern/docs/numerics_methodology.md` and `hexa-ufo/docs/numerics_methodology.md`.
> Pattern SSOT: `~/core/bedrock/docs/runnable_surface_recipe.md` (RSC = Runnable Surface Construction).

## §1 — what `verify/*` PASS does and does not mean

`hexa run cli/hexa-aura.hexa verify all` runs 19 pure-hexa local audit scripts and
aggregates their exit codes. **PASS means**: (a) the n=6 invariant lattice
`σ(6)·φ(6) = n·τ(6) = J₂ = 24` (and `sopfr=5`, `μ=1`, `σ²=144`, `σ³=1728`, `n^τ=1296`,
`σ-φ=10`) holds consistently across the roadmap + 4 pillar docs + 5 atlas docs; (b) each
pillar's n=6-derived quantities are integer/exact-fraction consequences of that lattice;
(c) the closed-form numerics are internally consistent (sub-1e-9 where applicable); (d) the
design targets sit *relative to published references* exactly as the pillar docs claim.

**PASS does NOT mean**: a built device, an in-vivo result, the RT-SC material claim (→
`hexa-rtsc`), perceived percept quality, the decode ML stack (→ `hexa-mind`/`hexa-brain`),
SAR/thermal/MRI compliance testing, or any FDA/KFDA clearance. Those are T4 — `.roadmap.hexa_aura §A.6`,
out of RSC code-layer scope, all steps unstarted. **F-AURA-1/2/3/4 (15 sub-IDs) are all OPEN.**

## §2 — the 3-tier evidence ladder (T1 / T2 / T3 / T4)

Per recipe §3, each falsifier's *code-layer* closure is tracked across three tiers; a fourth
tier is explicitly outside this loop:

| tier | what it is | where it lives | closure pct contribution |
|---|---|---|---|
| **T1 — algebraic** | the n=6 derivation is integer/exact-fraction arithmetic | `verify/calc_<pillar>.hexa` on disk | 33% (n=1) |
| **T2 — closed-form numerics** | the design quantities re-derived with `math_pure` float math, internally consistent | `verify/numerics_<pillar>.hexa` on disk | 67% (n=2) |
| **T3 — published-reference parity** | the design targets compared against PUBLISHED device/standard numbers | `verify/numerics_<pillar>_parity.hexa` on disk | 100% (n=3) |
| **T4 — live hardware / clinical / regulatory** | a built device, in-vivo data, compliance tests, FDA/KFDA | `.roadmap.hexa_aura §A.6` (NOT a `.hexa` script) | out of scope |

`closure_pct(n) = {0→0, 1→33, 2→67, 3→100}`. At v1.0.0 all 4 falsifiers are at
T1 ✓ + T2 ✓ + T3 ✓ = **100% code-layer closure** (verified by `verify/falsifier_check.hexa`),
which is why `verify/saturation_check.hexa` emits `__HEXA_AURA_RSC_SATURATED__ STOP`.

## §3 — per-pillar mapping (4 falsifiers × 3 tiers + 3 cross-cutters + 3 meta; 19 green-gated, 33 verify/*.hexa files)

| Falsifier | Pillar | T1 | T2 | T3 (published refs) |
|---|---|---|---|---|
| **F-AURA-1** | clip (form-factor) | `calc_clip` — 3.6 g split, τ=4 anchor, sopfr=5 mm, J₂≤24 mm | `numerics_clip` — mass band [2.5,12] g, anchor pressure < capillary occlusion, bone-conduction insertion loss, rotational inertia | `numerics_clip_parity` — BTE hearing-aid 2.5–4 g / Shokz / AirPods-Pro 5.3 g / eyeglass-temple 3–6 g / Cochlear-N7 9 g / Google-Glass 38 g |
| **F-AURA-2** | coil (transducer) | `calc_coil` — σ²=144, J₂=24, n^τ=1296, σ³=1728, μ=1 μm, τ=4 phases | `numerics_coil` — channel ratios, low-f skin depth ≫ 5 mm, SQUID-stage-limited read SNR, near-field 1/r³ write focal contrast, σ³=1728-equiv beamforming gain | `numerics_coil_parity` — Neuralink-N1 1024 / Utah 96 / Stentrode 16 / Argus-Orion 60 / SQUID-MEG ~2–3 fT/√Hz / OPM-MEG ~7–15 fT/√Hz / TMS figure-8 ~70–150 V/m, ~70 mm |
| **F-AURA-3** | cortex (cortical I/O) | `calc_cortex` — σ=12 zones, τ=4 modes, τ=4 layers of n=6, φ=2, sopfr=5 ms, 18→φ=2 collapse | `numerics_cortex` — 144 vs 22-electrode cochlear / 1296 vs 60-electrode Argus / Shannon read-channel capacity ≫ keyboard/speech, zone-frame budget, honest-gap flags | `numerics_cortex_parity` — cochlear-implant 22 / Argus-II + Orion 60 / Flesher-2016 ICMS ~6 / BrainGate-handwriting 90 cpm / speech-BCI 62–78 wpm / cursor 4 bit/s / Wodlinger 7-DOF arm |
| **F-AURA-4** | safety (caps) | `calc_safety` — k≤1.5 = round-up(sopfr/τ), SAR≤φ=2, ΔT≤φ/τ=0.5, FAR≤μ=1 %, coating≥φ·σ=24 yr, τ=4 layers/tiers, λ=2, n=6 sensors — each ≤ its standard | `numerics_safety` — Shannon damage line at k=1.5/1.85, SAR = σ·E²·duty/(2ρ), Pennes-bioheat ΔT (tissue + clip-shell), watchdog ROC point, J₂ energy cutoff | `numerics_safety_parity` — ICNIRP-2020 (2 W/kg local, 0.08 whole-body) / IEEE-C95.1-2019 / Shannon-1992 (k≈1.85) / McCreery (~30 μC/cm²/phase) / CEM43 / Rossi-2009 (rTMS seizure <1/30000) / DBS-cochlear 10–25 yr / ASTM-F2503 + IEC-60601 / FDA class III PMA + KFDA class 3–4 |

Cross-cutters: `numerics_cross_pillar` (the same n=6-derived anchor — 3.6 g, σ²=144, J₂=24,
0.5 K, sopfr=5, σ-φ=10 — computed independently in each pillar resolves to the same float
value, < 1e-9), `numerics_lattice_arithmetic` (`math_pure` `sqrt_pure`/`pow_pure`/`log_pure`/
`exp_pure` reproduce the n=6 integer anchors — the precision floor every downstream numerics
rests on). Meta: `falsifier_check` (closure-pct ladder + 15-sub-ID intactness check),
`lint_numerics` (the 5 RSC invariants below + inventory-drift), `saturation_check` (the
self-stop signal). Cross-cutter T1: `lattice_check`, `cross_doc_audit`.

**T2 is 3-deep per pillar** (the T2 column above is a stack, not a single script):
`numerics_<p>` (lumped closed-form) → `numerics_<p>_solver` (Cycle 2 mini-ODE) →
`numerics_<p>_fem` (Cycle 3, §A.6.1 stage B — a spatially-discretized
field/structural/cable/bioheat solve whose discrete operator converges on the
analytic solution at O(h²) as the grid refines: the honest code-layer analogue
of an FEM solve) → `numerics_<p>_fem_parity` (Cycle 4 — the FEM-class numbers
compared, AS NUMBERS, against PUBLISHED references: Roark/Euler–Bernoulli &
Ti-6Al-4V; exact Biot–Savart loop & TMS/SQUID/OPM; Rall infinite-cable &
Mountcastle column; Pennes-1948 & CEM43/ICNIRP — per g3/f1 the n=6 lattice is
NOT imposed on those external invariants), all coupled by
`numerics_fem_cross_pillar` (the coil→cortex→safety→clip chain closes and the
4 FEM analytic anchors recomputed independently agree < 1e-9). The 9 Cycle-3/4
FEM-tier scripts are on disk + inventoried (`lint_numerics`
`NUMERICS_SCRIPTS`=23, `saturation_check` `REQUIRED`=31, `cli verify
numerics-{clip,coil,cortex,safety}-{fem,fem-parity}` + `numerics-fem-cross`,
`test_calculators` `CASES`=32) and hand-checked, but **green-gate deferred** —
they are NOT in
`verify/run_all.hexa`'s 19-script green core, because the authoring env has no
hexa runtime (cycles 0–2 likewise hand-checked, not executed) and the
orchestrator gate must stay monotone (never PASS→FAIL, §A.6.1). They add **T2
depth, NOT closure**: the 3-tier ladder, `saturation_check`'s
`__HEXA_AURA_RSC_SATURATED__ STOP`, and `falsifier_check`'s 15-sub-ID-OPEN /
100 % code-layer state are all unchanged. FEM-*class* = 1D analytic-parity, NOT
a 3D solver; T4 (in-vivo / FDA) stays `.roadmap §A.6`, out of RSC scope.

## §4 — the 5 invariants `lint_numerics.hexa` enforces

Every `verify/numerics_*.hexa` must:
1. `use "self/runtime/math_pure"` — no raw float math primitives;
2. carry a `__HEXA_AURA_<NAME>__` sentinel prefix + `__ PASS` suffix;
3. declare a `FALSIFIERS` list (the `F-AURA-*` IDs it bears on);
4. have `exit(0)` on its PASS path;
5. have `let mut RUN = 0` + `let mut FAIL = 0` counters.

Plus: the `NUMERICS_SCRIPTS` inventory array in `lint_numerics.hexa` must equal the on-disk
`verify/numerics_*.hexa` glob count (drift detector). The `calc_*.hexa` T1 scripts get a
lighter check (sentinel + `F-AURA-*` IDs present).

## §5 — saturation criteria (when the RSC loop self-terminates)

Per recipe §7.2/§7.3, the closure-depth-accumulation loop stops when **both**:
- **sat-1**: every falsifier at 100% code-layer closure (all 12 tier-scripts = 4 pillars × {calc, numerics, numerics-parity} on disk);
- **sat-2**: the §1 16-script inventory complete + `lint_numerics` PASS + ≥ 9 `numerics_*.hexa` on disk.

(sat-3 — sister cross-link health, e.g. `hexa-rtsc` reachable — is a soft advisory in §A.6.1
stage B.) When sat-1 ∧ sat-2, `saturation_check.hexa` emits `__HEXA_AURA_RSC_SATURATED__ STOP`:
the code layer is closed (T1+T2+T3), only T4 remains, and T4 is *not* closable by new `.hexa`.
Per recipe §9.1, post-saturation cron/loop firings run this health-check only — no forced chunks,
no "polish disguised as a chunk", no over-saturation `.github/workflows/*` invention.

## §6 — the test layer (5 tests)

`tests/test_selftest.hexa` (4 pillar + 5 atlas + roadmap presence + dispatcher sentinel),
`tests/test_lattice.hexa` (n=6 closure regression — direct guard + `verify/lattice_check.hexa`),
`tests/test_calculators.hexa` (the full RSC surface — 32 cases incl. the 9 green-gate-deferred
FEM-tier scripts, 300 s timeout each, SKIP-on-timeout = exit 124), `tests/test_cli_verify.hexa` (the CLI faithfully exposes the verify contract + the
4 pillar verbs — catches dispatcher refactors that silently skip a script), `tests/test_all.hexa`
(aggregator). Wired into `hexa.toml [test].files` (all 5 individually).

## §7 — build infrastructure

`build/Makefile` + `build/header.tex` — a pandoc + xelatex pipeline producing 5 spec PDFs
(`clip` / `coil` / `cortex` / `safety` / main atlas `neuro`). `make check` probes the
toolchain; `make all` builds the 5 PDFs into `build/out/` (gitignored); the header is
soft-guarded with `\IfFileExists{}` for `fontspec` / `xeCJK` (the Korean labels in the docs)
/ `titlesec` / `xcolor`, so a host without the optional packages still produces a clean
ASCII-fallback PDF. This is OPTIONAL — `hexa-aura` ships zero hard build deps.


`hexa-aura` v1.0.0 is a **4-pillar post-aural-BCI chip + form-factor substrate design spec**
+ a 5-doc atlas + a 33-file RSC verify surface (19 green-gated + 9 Cycle-3/4 FEM-tier
depth scripts green-gate-deferred + 4 honest-signal deferred + orchestrator). It is *not* a device, *not* in trials,
*not* cleared. `verify/*` PASS = the n=6 arithmetic closes everywhere, the per-pillar
derivations are integer consequences of the lattice, the closed-form numerics are internally
consistent, and the design targets sit relative to published references as claimed — which is
a *necessary, not sufficient* condition for a working, safe, cleared product. The RT-SC
ambient-operation claim that makes the whole thing fit in 3.6 g is deferred to `hexa-rtsc`;
if that is falsified, **F-AURA-2 is DEMOTED**. The 18→0 wearable collapse is a design claim
measured against the *perceptual* (not raw) bandwidth of the replaced devices, and the raw-
bandwidth gap is flagged honestly. **F-AURA-1/2/3/4 (15 sub-IDs) — all OPEN.**

## §9 — references (the published anchors `numerics_*_parity.hexa` use)

Clip: BTE hearing-aid mass (audiology practice); Shokz/AfterShokz bone-conduction; Apple
AirPods Pro (2nd gen); eyeglass titanium temple; Cochlear Nucleus 7; Google Glass; Landis 1930
(capillary-occlusion ~32 mmHg). — Coil: Neuralink N1 (1024 ch); Utah array / BrainGate
(96–100 ch); Synchron Stentrode (16 ch); Argus II / Orion (60 electrodes); MEGIN TRIUX
SQUID-MEG (~306 sensors, ~2–3 fT/√Hz); QuSpin OPM-MEG (~7–15 fT/√Hz); Magstim/MagVenture TMS
figure-8 (~70–150 V/m cortical, ~70 mm). — Cortex: Clark 1978 + Cochlear Nucleus series (22
electrodes, ~8 effective channels); Humayun et al. Argus II (60, 20/1260); Second Sight Orion;
Flesher et al. 2016 (S1 ICMS); Willett et al. 2021 (handwriting 90 cpm); Willett et al. 2023 /
Metzger et al. 2023 (speech BCI 62–78 wpm); Pandarinath et al. 2017 (cursor 4 bit/s);
Wodlinger et al. 2015 / Collinger et al. 2013 (7-DOF arm); earbud/AR-display/e-skin raw specs.
— Safety: ICNIRP 2020 RF EMF guidelines; IEEE C95.1-2019; Shannon 1992 + McCreery et al.
(charge-density damage / safe injection); CEM43 thermal-dose model; Rossi et al. 2009/2021
(TMS safety / seizure incidence); DBS lead + cochlear-implant in-service lifetimes; ASTM F2503;
IEC 60601-1; ISO 14971; FDA 21 CFR (PMA / De Novo); KFDA/MFDS class 3–4. — Lattice: OEIS
A000203 (σ), A000005 (τ), A000010 (φ), A001414 (sopfr); n=6 = third perfect number; J₂(6)=24
(Mathieu/Leech minimal-vector count). — Pattern: `~/core/bedrock/docs/runnable_surface_recipe.md`;
worked example `~/core/hexa-cern`.
