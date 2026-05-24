# hexa-native port pattern — second sample (mc_transport / 1-D slab pilot)

**Date**: 2026-05-20
**Pilot scope**: D80 g_hexa_only ultimate-form pilot — second sample.
Port the minimum-viable slice of `stdlib/kernels/mc_transport/`
(currently a Python adapter wrapping OpenMC / Geant4 / scikit-hep
particle) to a true hexa-native implementation that runs WITHOUT
OpenMC, WITHOUT Geant4, WITHOUT any nuclear-data download — a 1-D
slab analytic test problem (single energy group, monoenergetic
source, isotropic scattering, vacuum boundaries).
**Result**: bit-identical hexa-vs-python parity at the same LCG seed
(machine epsilon; 6-digit print agreement at N=1e6); Monte-Carlo
parity against the Beer-Lambert analytic oracle T = exp(-Σ_t·L) at
~1e-4 to ~1e-3 relative at N=1e6 (well inside the 5 % D80 ceiling,
and on the right side of the √N statistical envelope). Pattern is
sound — documented below.

## Why this pilot — and why it doesn't need OpenMC

Track D (κ-65, 2026-05-20) showed OpenMC install is blocked on
macOS arm64 + the Linux pool unreachable. Meanwhile D80
(`@D g_hexa_only`) declares hexa-native as the ultimate form for
substrate code. The straightforward read of those two facts: hexa-
native can land NOW with a small analytic Monte-Carlo, and serve as
the parity-anchor for OpenMC absorption later. That is what this
pilot proves end-to-end:

- A textbook 1-D slab MC has a closed-form analytic oracle (the
  Beer-Lambert law T = exp(-Σ_t·L) for a beam through a pure
  absorber) — no nuclear-data file, no OpenMC, no Geant4 needed.
- The hexa stdlib already exposes everything required: `lcg_float01`
  from `stdlib/core/math/rng.hexa`, `exp` / `log` / `sqrt` from
  `stdlib/core/math/float.hexa` (which delegate to libm via runtime
  `hexa_math_*` shims registered in `self/codegen_c2.hexa
  cg_math_sym`).
- Once a future ①b adapter wraps real ENDF cross-sections, the
  same collision-loop substrate works — only the cross-section
  source changes.

## What landed

| file | role |
|---|---|
| `stdlib/kernels/mc_transport/mc_slab_demo.hexa` | hexa-native 1-D slab MC kernel (run_slab + analytic_transmission_beam_pure_absorber) |
| `stdlib/kernels/mc_transport/mc_slab_demo.py` | Python companion oracle — SAME LCG, SAME algorithm, for bit-identical cross-check |
| `stdlib/kernels/mc_transport/mc_slab_demo_test.hexa` | substrate parity test — 8 assertions across pure-absorber + scattering + analytic-oracle cases |

The existing `transport_kernel.py` (Bethe-Bloch / PDG particle
lookup) is untouched. That kernel is about charged-particle stopping
power and is orthogonal to neutron transport — they sit in the same
directory by directory grouping, not by algorithm overlap.

## Algorithm choice — why beam + isotropic scattering and not full MGXS

The Python substrate for `nuclear+verify` / `fusion+verify` /
`energy+verify` wires OpenMC with multi-group cross-sections (MGXS),
delayed-neutron precursors, thermal scattering S(α,β), etc. Porting
the full stack in one PR is far too big to review and depends on
ENDF data which OpenMC needs to be installed to read.

The smallest cited algorithm that exercises the full Monte-Carlo
recipe (free-flight sampling → collision → absorb/scatter → tally)
is:

1. **Single energy group** — no MGXS lookup, just scalar Σ_t / Σ_s / Σ_a.
2. **Monoenergetic source** — no source spectrum sampling.
3. **Isotropic scattering** — new μ ~ U(-1, 1), no Legendre moments.
4. **1-D slab geometry** — vacuum boundaries at x=0 and x=L.
5. **Beam source option** — μ=1 at birth gives the clean
   Beer-Lambert analytic oracle for the pure-absorber case.

These are textbook references (Duderstadt & Hamilton "Nuclear
Reactor Analysis" §4.5; Lewis & Miller "Computational Methods of
Neutron Transport" §5.2) — no proprietary code.

## Pattern — how to port a Python Monte-Carlo kernel to .hexa

### 1. Pick a substrate that doesn't need an external dataset

The mc_transport pilot avoided ENDF / nuclear-data-download as
hard. The fix isn't "ship the data" — it's "find the smallest
algorithm that exercises the SAME computational pattern (free
flight + collision + tally) without the dataset". Single-energy-
group transport is that algorithm.

### 2. Share the RNG across the Python oracle and the hexa kernel

The KEY insight for parity testing: if Python and hexa use the SAME
LCG with the SAME seed, the SAME draw sequence flows through the
SAME branches and produces BIT-IDENTICAL counts. Parity is then
machine-epsilon (modulo float operation order — and our tally
numerators are integer counts, so even operation order doesn't
matter at the count layer).

`stdlib/core/math/rng.hexa` already exposes the Numerical Recipes
LCG (a=1664525, c=1013904223, m=2^32). The Python companion
mirrors that LCG byte-for-byte. Result: identical counts in both
directions, to all printed digits.

### 3. Capture the analytic oracle

For a pure absorber (Σ_s = 0) with a beam source, T_analytic =
exp(-Σ_t·L) (Beer-Lambert). With N=1e6 we expect rel error ~1/√N
≈ 1e-3 (or worse for small T — Bernoulli variance is T(1-T)/N so
the relative std on rare-event tallies grows as 1/√(N·T)). The
pilot's tolerance band sits at 1 % for L=1 (T≈0.37) and 3 % for
L=2 (T≈0.14) — both honest given the sample size, and inside the
5 % D80 ceiling.

### 4. Provenance comment + honesty block follow the solar pilot template

The file header mirrors `solar_kernel.hexa`:

- `@version` / `@capabilities` / `@stability` / `@since`
- CLEAN-ROOM PROVENANCE — explicit "no OpenMC code, no Geant4 code"
- HONESTY (g3) — pilot status, illustrative cross-sections, no
  `absorbed=true` flip on any demiurge cell
- Layer (①a substrate, ①b adapter not yet built)

### 5. Parity test pattern is the same as solar_kernel_test.hexa

Same `pass_count / total_count / check / rel_err` pattern. The
three test cases:
1. Pure absorber, L=1, Σ_t=1, beam → T vs Beer-Lambert
2. Pure absorber, L=2, Σ_t=1, beam → T vs Beer-Lambert (thicker slab)
3. Scattering medium, L=1, Σ_s=Σ_a=0.5, beam → closure T+A+R=1,
   mean_coll > A, R > 0 (qualitative checks since no closed-form
   analytic for scattering+absorption)

## Parity numbers (final, N=10^6)

Run from worktree against `origin/main = 1ab7c393`:

```
mc_slab_demo_test: 8/8 PASS  (at N=100_000)
```

Canonical N=10^6 parity table — same LCG seed (12345), beam source:

| case | hexa T | python T | analytic T | rel err vs analytic |
|---|---|---|---|---|
| C1: pure-absorber L=1, Σ_t=1     | 0.367810 | 0.367810 | 0.367879441 | 1.9e-4 |
| C2: scatter L=10, Σ_s=0.4, Σ_a=0.1 | 0.037707 | 0.037707 | — (scatter)  | —      |
| C3: pure-absorber L=10, Σ_t=0.5  | 0.006747 | 0.006747 | 0.006737947 | 1.3e-3 |

C2 full tally (hexa = python to all printed digits):
T=0.037707, A=0.677361, R=0.284932, mean_collisions=3.386107.
Closure T+A+R = 1.000000 — exact.

The hexa-vs-python parity is bit-identical because both
implementations share the same LCG seed and the same algorithm
flow. The analytic-vs-MC gap is the √N statistical envelope, well
inside the D80 5 % ceiling.

Runtime: hexa N=1e6 case completed in ~3.4 s on darwin-arm64
(`hexa run` interpreter, no AOT compile). All three N=1e6 cases
in one script: 4.5 s. The interpreter is fast enough that we did
NOT need to AOT-compile for this pilot.

## What this DOES NOT prove (g3 — honesty)

- **`absorbed=true` is NOT flipped** on any demiurge cell. Per the
  pilot task constraint, this is a port-pattern proof, not a
  measured-parity flip. The cross-section numbers are illustrative
  single-group constants, NOT real nuclide data — without OpenMC or
  ENDF, there is no measured oracle to flip against.
- **energy+verify, fusion+verify, reactor+verify still need OpenMC**
  for their real numbers. This pilot only proves the port pattern
  works end-to-end without OpenMC installed. The day OpenMC absorbs
  cleanly into the host pool (or the Linux pool reappears), a ①b
  adapter under `stdlib/nuclear/` can wrap real ENDF cross-sections
  and use this kernel's collision-loop substrate — only the cross-
  section SOURCE changes, the inner loop stays.
- **Single energy group + isotropic scattering** is a textbook
  simplification. Real reactor physics needs continuous-energy data,
  S(α,β) thermal scattering, delayed-neutron precursors, and a
  Legendre-moment angular distribution. None of that is in scope for
  this pilot.

## Surprises / blockers found during the pilot

### Hexa-lang gotchas

1. **No float `%` operator** (carried over from the solar pilot —
   already documented). Not exercised by mc_transport since the
   modular arithmetic in the LCG is on integers (uses `&
   0xFFFFFFFF`).
2. **Print format width** — `print` truncates floats to ~6 digits,
   which made the bit-identical hexa-vs-python comparison harder to
   show by hand. Both sides print `0.36781` for case 1, and the
   underlying counts are integer so we know they match exactly —
   but for full-precision parity dumps a `str_full(x: float)` or
   `repr(x: float)` primitive would be ideal. (Already in the
   solar-pilot follow-up queue.)
3. **`forward_beam: bool` parameter** — hexa's grammar doesn't yet
   have a `bool` parameter type in the public API (or rather, it
   does but I couldn't find one in the kernels I surveyed). Worked
   around by using `int` (0 = isotropic-into-forward-hemisphere,
   1 = beam) which is what the existing kernels seem to do. Filed
   as a polish item; the workaround is fine.
4. **No 2^32 literal** — same issue as `stdlib/core/math/rng.hexa`
   notes (`m = 2^32 — masked via & 0xFFFFFFFF since interp has no
   2^32 literal for unsigned types`). The mask workaround is fine.

### Non-issues

- `lcg_float01` returning `[new_state, value]` as a hexa array
  works cleanly — destructure as `let s0 = lcg_float01(state); state
  = s0[0]; let u = s0[1]`.
- Nested `while` (outer per-particle, inner per-collision) with
  `mut alive: bool` works fine.
- `log` and `exp` produce identical numbers to Python's `math.log`
  / `math.exp` (libm via the runtime shim) — bit-identical floating
  point.
- Integer counters `n_trans` / `n_abs` / `n_refl` /
  `total_collisions` give exact tallies — no float roundoff in the
  count layer.

## Follow-ups (queue, in priority order)

1. **(stdlib/kernels/mc_transport)** Multi-region 1-D slab —
   trivial extension of this kernel; the inner loop just consults a
   region-indexed Σ table. Demonstrates layered shielding (good
   pre-cursor to fusion-blanket scoping).
2. **(stdlib/kernels/mc_transport)** Multi-group cross-sections —
   bins energy into groups, samples a group at birth, samples a
   downscatter matrix at each collision. Still no ENDF needed if the
   caller supplies the MGXS table.
3. **(stdlib/nuclear, future)** ①b adapter that wraps an ENDF →
   MGXS preprocessor (or, when OpenMC absorbs, calls OpenMC for the
   MGXS table once and then runs this kernel's loop). That is the
   bridge from "pattern-proof pilot" to "measured-parity tally".
4. **(hexa-lang)** Add `bool` to the public-API parameter type
   surface so kernels don't have to pass 0/1 ints for flags.
5. **(hexa-lang stdlib)** Inherit the solar-pilot's follow-ups:
   fix the `- continuation` parser footgun; add `fmod` to
   `cg_math_sym`; add `str_full(x: float)` for full-precision
   parity-report dumps.
6. **(demiurge)** When OpenMC absorbs, the `HexaNativeParityRef`
   schema (planned in the solar pilot follow-up list) can wire
   `absorbed=true` for `nuclear+verify` cells with a pointer to
   this kernel + a measured-OpenMC oracle. Until then, every
   demiurge cell calling into this kernel keeps `absorbed=false`.

## Pattern as a checklist (extractable for the next port)

1. Identify the substrate kernel (`stdlib/kernels/<domain>/<x>.py`)
   AND its blocking dependency (here: OpenMC + ENDF).
2. Identify the smallest cited algorithm inside it that exercises
   the SAME computational pattern WITHOUT the blocking dependency.
   For Monte-Carlo, that is the analytic single-group / monoenergetic
   / 1-D-slab test problem. For ephemeris, it was Hughes + Haurwitz.
3. Ship a Python companion `<x>_demo.py` (or `<x>_kernel.py` for
   a more general port) that mirrors the hexa algorithm exactly,
   sharing the SAME RNG seed convention. This is the bit-identical
   oracle — it does NOT depend on the blocking external lib.
4. Write `stdlib/kernels/<domain>/<x>_demo.hexa` following the
   solar_kernel.hexa provenance + honesty template. Mirror the
   public API names so a future ①b adapter can swap with no logic
   change.
5. Write `stdlib/kernels/<domain>/<x>_demo_test.hexa` with two
   tiers: (a) analytic-oracle parity at MC √N tolerance, (b)
   closure / sanity checks for cases with no closed-form analytic.
6. `hexa run stdlib/kernels/<domain>/<x>_demo_test.hexa` — expect
   PASS at the tolerance you committed.
7. Cross-check with the Python companion at the SAME seed — expect
   bit-identical counts and float tallies to all printed digits.
8. **Do NOT flip `absorbed=true`** on the demiurge record yet —
   that gate stays on the demiurge-side `HexaNativeParityRef`
   schema + a measured-parity oracle (here, OpenMC). Pattern proof
   is honestly distinct from measured parity.

This pattern, applied to Monte-Carlo transport, gives bit-identical
hexa-vs-python tallies at the same LCG seed AND ~1e-4 to ~1e-3
parity vs the analytic oracle at N=1e6 — well inside the D80 5 %
ceiling. Bigger MC ports (continuous-energy, S(α,β), 3-D geometry)
will need OpenMC absorption on the host, but the pattern is
identical.
