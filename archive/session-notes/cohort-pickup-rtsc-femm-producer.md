# incoming note: cohort-pickup-rtsc-femm-producer — fourth cohort producer candidate (post κ-35 aura + scope)

> **id**: `cohort-pickup-rtsc-femm-producer` · **opened**: 2026-05-20 KST · **status**: `pickup — BLOCKED by toolchain availability (honest g3 gap)`
> **source**: κ-35 (P-⑧ cohort sweep — aura+scope picked). rtsc was the third cohort triple but the FEMM toolchain has no clean pip one-liner on macOS, so it's deferred with an honest-gap explanation rather than force-mapped.
> **scope**: ONE cell of rtsc.md — `rtsc + analyze` (= ANALYZE⟲) — wired to a 2-D axisymmetric magnetics solver. NOT the full 7-verb rtsc stack.

---

## Why rtsc is the deferred candidate (NOT picked κ-35)

From `domains/rtsc.md` §2 tool map, the OSS column lists:

- **FEMM** — 2-D / axisymmetric magnetics (the canonical OSS choice for the DESIGN verb). **macOS gap**: FEMM is **Windows-native** (Delphi binary, runs under Wine on macOS / Linux). No homebrew formula, no PyPI wheel. The `pyfemm` Python binding still requires the FEMM binary to be installed.
- **FEM Magnetics Toolbox** (`femmt` on PyPI) — Python wrapper for FEMM specifically aimed at power-electronic magnetics. Same FEMM dependency → same macOS gap.
- **HTS Modelling Workgroup shared model files** — *.pro / *.geo files for GetDP, not a runnable producer by themselves.
- **GetDP / Elmer** — open FEM solvers, brew-installable but require a `.pro` problem definition + a `.geo` mesh; not a one-line pip producer.

Score comparison (post κ-35 aura + scope):

| factor | rtsc (FEMM via Wine) | aura (MNE — picked κ-35) | scope (POPPY — picked κ-35) |
|---|---|---|---|
| 도구 설치 | Wine + FEMM .exe (manual) | `pip install mne` — one line | `pip install poppy` — one line |
| macOS native | ✗ (Wine emulation) | ✓ (Apple Silicon native) | ✓ (Apple Silicon native) |
| CLI 한 줄 | `wine femm.exe ...` (GUI-first, scripting via Lua) | `python3 aura_mne.py <dir>` | `python3 scope_poppy.py <dir>` |
| 측정 명확도 | Bz field map (real numbers) | Welch PSD band-power | Strehl + FWHM + encircled-E |
| 가벼움 | FEMM ≈ 50 MB + Wine 500+ MB | mne ≈ 100 MB (+numpy) | poppy ≈ 20 MB (+astropy, ~150 MB) |
| 정직한 D61 SSOT | ⚠ Wine 의존은 hexa-lang/stdlib 의 hermetic 원칙 위반 (subprocess to Wine emulation layer) | ✓ pure Python | ✓ pure Python |

**Verdict (g3)**: rtsc has the **largest tooling gap** of the cohort domains for "lowest-hanging fruit" mapping. Force-mapping it would either:
1. Require Wine installation as a producer dep — clean-room violation + 500 MB tax for a single 2-D Bz field.
2. Or use GetDP/Elmer directly — but those need a per-coil `.pro` + `.geo` written by hand; not a deterministic in-script generator like ngspice netlists or POPPY apertures.

`domains/rtsc.md` §4 itself flags this: *"Biggest open-source gap: 3-D coupled EM–thermal–mechanical quench / AC-loss simulation for REBCO / Bi-2212 coils (open tooling is 2-D-limited)."* — the gap is real and intrinsic.

## The producer skeleton (for a later agent — if/when GetDP path matures)

**Path 1 — GetDP CLI** (preferred long-term; requires `.pro` template):
- `~/core/hexa-lang/stdlib/rtsc/rtsc_getdp.py` (D61 SSOT) — Python that writes a parametric solenoid `.pro` problem file (radius, height, turns, current, conductor cross-section), invokes `getdp <pro> -solve EleSta_v -pos Map`, parses the field-map output, computes `B_max_T`, `B_center_T`, `inductance_H` (energy-method), reports stored-energy.
- Reuse the SSCBProducer / AuraAnalyzeProducer / ScopeAnalyzeProducer harness pattern exactly (locate binary, spawn, parse `RTSC_GETDP_RESULT <json>`, verify artifacts, emit typed `RtscRecord`).
- `~/core/demiurge/cockpit/Sources/DemiurgeCore/Models/RtscRecord.swift` + `Loaders/RtscAnalyzeProducer.swift` — mirror SSCB/Aura/Scope.
- `ActionDispatch.swift` add `case (.analyze, "rtsc")` → `runRtscAnalyze()`.

**Path 2 — pure-Python analytic** (lighter, less ambitious):
- Use `scipy.special.ellipk` / `ellipe` for the closed-form on-axis B-field of a finite solenoid (the textbook Wheeler formula). This avoids FEMM entirely but the *scope* of measurement is small (B on-axis only, no saturation, no shielding currents).
- Honest g3: this would be `producer = "scipy@<v> · closed_form_solenoid"`, gate=OPEN, absorbed=false (analytic, not measured). Even narrower than POPPY's parametric PSF.

**Measurements** (deterministic):
- `radius_m`, `height_m`, `turns`, `current_A`
- `B_center_T` (closed-form or solver output)
- `B_max_T` (peak on-axis, near the coil ends)
- `inductance_H` (from energy method or analytic)
- `stored_energy_J`

**Scope caveats** (record these in provenance):
1. GetDP / closed-form ≠ real superconductor — neither model captures critical-state (E-J power-law, n-value) or quench dynamics; the HTS Modelling Workgroup workflow (`htsmodelling.com` cited in domains/rtsc.md §5) is what'd be needed for actual REBCO/Bi-2212 verdict.
2. 2-D axisymmetric assumption — real coils have leads, support structure, return paths; 3-D effects (AC loss, end-region screening) absent.
3. measurement_gate = GATE_OPEN — solver IS the instrument but the *coil* is parametric, not a wound prototype with measured Bz vs current.
4. absorbed=true 금지 — domains/rtsc.md §4 "3-D coupled EM-thermal-mechanical quench" is the real gap; one 2-D B-field pass is the first verb of a long chain.

## Effort estimate

- Path 1 (GetDP): brew install gmsh + getdp (already brew-available), write parametric `.pro` template — **1 day** (mostly `.pro` debugging).
- Path 2 (scipy closed-form): script ~50 lines, Swift wrappers 30 min — **half day**.

## Status

Not implemented. **The κ-35 round picked aura (MNE) + scope (POPPY) over rtsc** because the latter's two viable paths each have a real drag:
- FEMM via Wine: clean-room + macOS-native violation.
- GetDP: per-problem `.pro` template authoring is real work, not a one-line pip install.
- scipy closed-form: too narrow — single B value isn't much of a "design verdict", and the rtsc.md §4 honest gap (3-D coupled multiphysics) is barely scratched.

Pickup priority: AFTER the next "easy" cohort (likely energy via PyBaMM for battery, or fusion via OpenMC for neutron transport — both have clean pip paths).

## Cross-reference

- `domains/rtsc.md` §2 + §4 — the canonical tool map + gap statement.
- κ-35 commits (aura MNE + scope POPPY) — the new templates to copy.
- D55 (sscb ngspice) — first cohort producer; established the pattern.
- D67 / D68 (κ-35 — aura + scope) — second/third cohort producers (this round).
- D61 — producer SSOT = `~/core/hexa-lang/stdlib/<domain>/<tool>.py` (the policy that makes Wine-based FEMM a non-starter for κ-3X).
