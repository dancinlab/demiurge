# Release notes — hexa-aura v1.0.0 (2026-05-10)

> **hexa-aura v1.0.0 — n=6 post-aural BCI chip substrate, full design.**
> 측두골 클립 한 쌍이 스마트폰 + 18개 웨어러블을 0개로 수렴 — 4 pillars
> (clip / coil / cortex / safety) + 5-doc atlas + 19-script RSC verify surface.

## What this release is

`hexa-aura` graduates from a thin 5-doc bundle (`v0.1.0`, `BUNDLE_FIRST`) to a complete
post-aural BCI **chip + form-factor substrate** at the `hexa-cern` / `hexa-chip` / `hexa-ufo`
level: a 4-pillar spec set, each pillar pinned to the n=6 invariant lattice
`σ(6)·φ(6) = n·τ(6) = J₂ = 24` and each carrying a preregistered falsifier with a 3-tier
Runnable-Surface-Construction closure ladder (T1 algebraic / T2 closed-form numerics / T3
published-reference parity).

### The 4 pillars

| Pillar | What it pins | Falsifier (all OPEN) |
|---|---|---|
| **clip** — HEXA-MASTOID-CLIP | *where the device lives*: φ=2 BTE clips on the mastoid, σ·n/10 = 3.6 g/side (7.2 g pair), τ=4 passive anchor, sopfr=5 mm bone window, hair-hidden, mass split 1/3+1/3+1/6+1/6 = 1 | F-AURA-1 (1a/1b/1c) |
| **coil** — HEXA-RT-SC-NANOCOIL | *the transducer*: μ=1 μm litho pitch, σ²=144 ch/tile, J₂=24 ch/macro, n^τ=6⁴=1296-ch hex lattice (Neuralink-N1 parity·+), σ³=1728-equiv beamforming, RT-SC @ ambient (→ `hexa-rtsc`), τ=4 multiplex phases ≤ 5 ms → 200 Hz read frame | F-AURA-2 (2a/2b/2c) |
| **cortex** — HEXA-CORTICAL-IF | *which zones, which directions, which modes*: σ=12 cortical target zones (A1/V1~V6/S1/M1/PFC/…), φ=2 read+write, τ=4 operating modes, sopfr=5 ms latency / ≤5 HB zones, σ·τ=48 K-class px, and the **18 wearables → φ=2 clips** collapse | F-AURA-3 (3a/3b/3c/3d) |
| **safety** — HEXA-CORTICAL-SAFETY | *the caps everything lives under*: Shannon k ≤ 1.5, SAR ≤ φ = 2 W/kg (ICNIRP-2020 / IEEE-C95.1), ΔT ≤ φ/τ = 0.5 K (CEM43), τ=4-tier EEG-watchdog FAR ≤ μ = 1 %, coating life ≥ φ·σ = 24 yr, MRI-conditional, no-craniotomy / external-only, λ=2 single-fault tolerance | F-AURA-4 (4a/4b/4c/4d/4e) |

### The RSC verify surface (19 pure-hexa scripts)

`hexa run cli/hexa-aura.hexa verify all` runs all 19 and aggregates exit codes:

- **T1 algebraic (6)** — `lattice_check` (n=6 closure across roadmap + 4 pillars + 5 atlas), `cross_doc_audit` (cross-pillar anchor agreement), `calc_{clip,coil,cortex,safety}` (per-pillar n=6 derivations).
- **T2 closed-form numerics (4)** — `numerics_{clip,coil,cortex,safety}` (`math_pure` re-derivations: mass band / anchor pressure; array factor / skin depth / read SNR / write focal contrast; channel-count comparisons / Shannon read-channel capacity; Shannon damage line / SAR / Pennes-bioheat ΔT / watchdog ROC).
- **T3 published-reference parity (4)** — `numerics_{clip,coil,cortex,safety}_parity` (BTE/Shokz/AirPods/Cochlear/Glass; SQUID-MEG/OPM-MEG/TMS/Neuralink/Utah/Stentrode/Argus-Orion; cochlear/Argus-II/Orion/Flesher-2016/BrainGate/speech-BCI/Wodlinger; ICNIRP-2020/IEEE-C95.1/Shannon-1992/McCreery/CEM43/Rossi-2009/ASTM-F2503/IEC-60601/FDA-KFDA).
- **cross-cutters (2)** — `numerics_cross_pillar` (shared anchors resolve identically across pillars), `numerics_lattice_arithmetic` (`math_pure` float↔int precision floor).
- **meta (3)** — `falsifier_check` (F-AURA-1/2/3/4 closure-pct ladder), `lint_numerics` (5 RSC invariants + inventory drift), `saturation_check` (sat-1 ∧ sat-2 → `__HEXA_AURA_RSC_SATURATED__ STOP`).

Plus `tests/test_all.hexa` rolls up `test_selftest` + `test_lattice` + `test_calculators` + `test_cli_verify`.


`verify/*` sentinel PASS validates **arithmetic and token consistency**, not hardware. It does **not** demonstrate:

- a built mastoid clip / RT-SC nano-coil tile / cortical-I/F device (Stage-1+, `.roadmap.hexa_aura §A.6` — all steps unstarted);
- the **RT-SC ambient-operation material claim** — deferred to `hexa-rtsc`; if that is falsified, **F-AURA-2 is DEMOTED**;
- in-vivo / cadaver-skull / NHP / first-in-human results;
- perceived audio intelligibility / AR image quality / haptic realism (**F-AURA-3a/3b/3c stay OPEN**);
- the decode ML stack (intent→text/cursor, percept→injection) — that is `hexa-mind` / `hexa-codex` / `hexa-brain`;
- any **FDA / KFDA regulatory clearance** — NOT cleared, NOT in trials (§A.6 step 5);
- MRI-conditional bench tests / biocompatibility assays / SAR-thermal compliance measurement.

The n=6 safety design targets *happen to land on, or conservatively inside, the established
human-exposure standards* — the safety claim rests on the **standards**, not the arithmetic.
The 18→0 wearable collapse is a *design* claim measured against the **perceptual** bandwidth
of the replaced devices, whose **raw** bandwidth exceeds any demonstrated cortical write rate
(the honest gap is flagged in `verify/numerics_cortex.hexa` and `cortex/doc/cortical-interface.md §2`).

**F-AURA-1 / F-AURA-2 / F-AURA-3 / F-AURA-4 (15 sub-IDs) — all OPEN.** Monotone:
`OPEN → CONFIRMED` or `OPEN → DEMOTED`. Silent retract forbidden.

## Scope discipline

`hexa-aura` is the CHIP + FORM-FACTOR substrate. Cognitive verbs + BCI ML stack → `hexa-mind`
(pending). Sensory verbs → `hexa-senses` (pending). Working EEG/BMI pipeline → `hexa-brain`
(sister). RT-SC dependency → `hexa-rtsc` (sister). Decoder serving → `hexa-codex` CLI.
Neuromorphic silicon → `hexa-chip` CLI. 5G/6G uplink → `hexa-grid` CLI. Do NOT proxy through `hexa-aura`.

## Install

```bash
hx install hexa-aura            # or: git clone https://github.com/dancinlab/hexa-aura.git ~/.hexa-aura
hexa-aura --version             # → 1.0.0
hexa-aura status                # 4-pillar + 5-atlas table + caveats
hexa-aura verify                # 19 RSC audits
```

## Next

- v1.1.0 (~2026-09): `coil` ↔ `hexa-rtsc` RT-SC critical-current cross-verify; `cortex` ↔ `hexa-brain` working-pipeline cross-verify.
- v1.2.0 (~2026-12): `safety` regulatory-pathway expansion (FDA/KFDA pre-submission skeleton); EEG-watchdog ROC numerics.
- v2.0.0 (~2027-Q3, aspirational): Stage-1+ bench prototype (RT-SC coil tile + phantom-skull rig) raw-data fit — out of RSC code-layer scope.

— MIT licensed. See `LICENSE`, `CHANGELOG.md`, `.roadmap.hexa_aura`.
