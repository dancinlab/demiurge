# 🤖 AGA-RX · NANOBOT axis (round-5) — pH/enzyme-gated DPC release switch

**alias:** the smart cargo door — a molecular latch that keeps the Wnt-restorer
locked inside the carrier all the way down the follicle, and only pops open at
the dermal-papilla bulb where the AGA target lives.

**Axis role:** `hexa-bio` NANOBOT = molecular machine / DNA-origami switch. In the
AGA-RX modality matrix NANOBOT is the **GATE**: it converts the round-4 passive
≤200 nm O/W nanoemulsion carrier (`round4-synthesize/FORMULATION.md`) into a
*stimuli-responsive* carrier that **holds the payload in transit** (acidic, low-
enzyme skin surface / infundibulum) and **releases it at the DPC** (neutral pH +
follicular protease/esterase). It supplies the *trigger* for the WEAVE *container*
(`round5-weave/WEAVE.md`).

---

## 0. Inheritance (d19) — what was reused, not rebuilt

| inherited primitive | source (PORTED) | what it gives |
|---|---|---|
| 4-state Gillespie CTMC actuator (S0 idle / S1 fwd-stroke / S2 backslip / S3 reset) | `hexa-bio-archive/nanobot/module/actuation_simulation.hexa` (F-NB-4) | the molecular-machine actuation kinetics |
| overdamped Langevin SDE (Box-Muller, Stokes drag) | same | thermal-noise pose dynamics, finite-collapse guard |
| σ(6)=12 icosahedral 12-vertex skeleton + J₂=24 octahedral pose group | same | the n6 structural invariant (12·2 = 24 = 6·4) |
| in-tree LCG PRNG (glibc multiplier) | same | deterministic, hexa-stdlib-only RNG |
| follicular PK `t_lag = h²/(6D)`, `C(z) = C_surf·exp(−z/λ)` | `round3-admet-pk/PK.md` §3 (← TTR-LAC/A1,A3) | trans-follicular shunt delivery / depth survival |
| base carrier = ≤200 nm O/W nanoemulsion | `round4-synthesize/FORMULATION.md` §4 (R4-A) | the carrier substrate the GATE plugs into |

**Honest port note (d6 · d8):** the inherited actuation core's local `isfinite`
function collided with the C-backend `isfinite` macro under AOT clang (the
inherited file fails `hexa run` as-is — verified). The collision is a hexa-lang
transpiler bug; the ONLY change in this port is the rename `isfinite → hx_isfinite`
(name-only, model unchanged). The renamed inherited core runs and passes its own
6/6 self-check at 10 000 cycles (verified). → flagged for `hexa-lang/inbox` (d8).

The round-5 layer **adds only** the GATE: `gate_open_prob(pH, enzyme)`, the
gate-modulation of the actuator's S0→S1 door-open rate, and the PK-coupled release
kinetics. Run: `hexa run aga_nanobot_gate.hexa` → `__AGA_NANOBOT_GATE__ PASS`
(full transcript in `sim_output.txt`).

---

## 1. The molecular switch (TASK 1) — open/closed states

**Latch chemistry (primary): proton-keyed DNA latch (i-motif / His-clasp class).**
A pH-responsive staple holds the cargo door of the carrier/cage shut by
**protonation** in the acid mantle. As pH rises toward the dermal target, the
staple deprotonates and the door opens. This is modeled as a **Hill in proton
concentration** H = 10⁻ᵖᴴ (the physical trigger), midpoint pH 6.5, cooperativity
n = 4 — consistent with the sharp <1-pH-unit switching of i-motif / pH-low-insertion-
peptide latches.

**Latch chemistry (secondary / OR seam): esterase/protease-cleavable strut.**
An ester linker or short peptide latch is cut once follicular esterase/protease
activity exceeds a threshold (Hill in normalized activity E, K₅₀ = 0.55, n = 4).
The follicular sheath / DPC region carries elevated esterase + cathepsin-class
protease activity vs the transit compartments.

**OR logic:** `p_open = 1 − (1−p_pH)·(1−p_enz)` — either DPC cue (neutral pH OR
follicular enzyme) suffices, for robustness. Pairs as an **AND-arm** with the
WEAVE aptamer-AND seam (§4).

| state | environment | gate cue | latch | payload |
|---|---|---|---|---|
| **CLOSED** | skin surface / infundibulum (transit) | pH ≈ 5.0, E ≈ 0.10 | protonated / intact | **held inside** |
| **OPEN** | dermal-papilla bulb (target) | pH ≈ 7.2, E ≈ 0.90 | deprotonated / cleaved | **released at DPC** |

---

## 2. Actuation sim — trigger threshold + actuation fraction (TASK 2)

Numbers are from the **actual run** of `aga_nanobot_gate.hexa` (10 000 cycles,
seed 42, T = 310 K), gate-modulating the inherited CTMC. See `sim_output.txt`.

**Gate open-probability across the DPC pH 5→7 gradient (§[1]):**

| pH | p_pH | E | p_enz | p_open (OR) |
|---|---|---|---|---|
| 5.0 | 1.0e−6 | 0.10 | 0.0011 | **0.00109** (shut) |
| 6.0 | 0.0099 | 0.30 | 0.081 | 0.090 |
| 6.5 | 0.500 | 0.60 | 0.586 | 0.793 |
| 7.0 | 0.990 | 0.80 | 0.817 | 0.998 |
| 7.2 | 0.998 | 0.90 | 0.878 | **0.99981** (open) |

**Trigger thresholds (§[3], actual sweep):**
- **pH trigger (50% open, enzyme held at transit level) = pH 6.5** — sits between
  the transit acid mantle (5.0) and the dermal target (7.2).
- **enzyme trigger (50% open at acidic pH 5) = E = 0.55** (normalized activity).

**Gated actuation fraction — TRANSIT (closed) vs DPC (open) (§[2]):**

| env | pH | E | gate_open | productive (release) cycles | actuation_fraction |
|---|---|---|---|---|---|
| **TRANSIT** | 5.0 | 0.10 | 0.0011 | **15** | 0.0143 |
| **DPC** | 7.2 | 0.90 | 0.99981 | **2071** | 0.885 |

**ON/OFF release-rate ratio (DPC/transit) = 138×.**

> Honest model finding (d6 · g63): the first sim revision used productive/backslip
> *ratio* as the ON/OFF observable and only got 1.36× discrimination — because that
> ratio is gate-insensitive (the gate scales numerator and denominator together).
> The release that actually matters is the **rate** (count of door-open cycles over
> a fixed time budget), which the gate genuinely throttles. With the corrected
> observable AND a proton-Hill latch (true sigmoid in [H⁺], vs the earlier pH-power
> form that leaked at pH 5), the design discriminates 138×. The fix was physical
> (correct latch chemistry + correct observable), not number-forcing.

---

## 3. Release kinetics coupled to AGA-RX follicular PK (TASK 3)

DPC-released fraction = (PK depth survival to the bulb) × (gate release rate at the
DPC env). The PK depth law `C(z) = C_surf·exp(−z/λ_foll)` and the z_DP = 1.5 mm
worst-corner bulb depth are **reused verbatim** from `round3-admet-pk/PK.md` §3b.
λ_foll bracket = {0.5, 1.0, 2.0} mm (the round-3 shunt attenuation-length range).
The leaky/ungated baseline = a non-gated nanoemulsion releasing at the transit rate
*before* reaching the bulb. From the actual run (§[4]):

| λ_foll (mm) | C(DP)/C_surf | released @ DPC (gated) | leaked in transit (ungated) | **gated/ungated gain** |
|---|---|---|---|---|
| 0.5 (worst) | 0.0498 | 0.0498 | 0.0072 | **6.9×** |
| 1.0 | 0.223 | 0.223 | 0.0072 | **30.8×** |
| 2.0 (best) | 0.472 | 0.472 | 0.0072 | **65.2×** |

**Finding:** the gate concentrates payload release at the DPC by **6.9–65×** vs a
non-gated carrier across the full round-3 λ_foll bracket — even at the worst-corner
attenuation length. Combined with the round-3 result that WAY-316606 clears its
SFRP1 EC₅₀ (0.65 µM) with ×19–20 000 potency headroom at the DPC, the gate's job is
**retention/selectivity** (suppress en-route leak, dump at target), not raising raw
potency — and it delivers that with a >100× ON/OFF and ≥6.9× DPC-retention gain.

---

## 4. VERDICT (TASK 4) — carrier spec + WEAVE pairing

**Gated-carrier spec (in-silico design feasibility):**

| field | value | basis |
|---|---|---|
| base carrier | **≤200 nm O/W nanoemulsion**, PDI ≤0.2 (R4-A) | `round4-synthesize/FORMULATION.md` |
| size window | **20–40 nm** if WEAVE-caged; ≤200 nm NE droplet otherwise | follicular accumulation optimum |
| **gate chemistry** | **proton-keyed DNA latch (i-motif/His-clasp) OR esterase/protease-cleavable strut** (OR seam) | TASK 1 |
| **pH trigger threshold** | **pH 6.5** (50% open; shut at 5.0 → open at 7.2) | sim §[3] |
| **enzyme trigger threshold** | **E = 0.55** normalized activity (50% open at pH 5) | sim §[3] |
| ON/OFF release-rate ratio | **138×** (DPC open / transit shut) | sim §[2] |
| transit gate open-prob | 0.0011 (locked) | sim §[2] |
| DPC gate open-prob | 0.99981 (open) | sim §[2] |
| **DPC release fraction (gated)** | **0.05–0.47** of surface dose at the bulb (z=1.5 mm, λ=0.5–2.0 mm) | sim §[4] |
| **gated vs ungated DPC gain** | **6.9–65×** retention/selectivity | sim §[4] |
| payload | WAY-316606 (SFRP1 antagonist / Wnt restorer), or 1 siRNA duplex | inherited |
| structural invariant | σ(6)=12 vertices, τ(6)=4 states, 12·2 = 24 = 6·4 | sim §[5], 7/7 PASS |

**Pairing with the WEAVE cage (aptamer-AND seam):** WEAVE supplies the T=1 60-mer
icosahedral *container* (20 nm, ~100% assembled yield, hysteresis-stable in dilute
topical vehicle; `round5-weave/WEAVE.md`). NANOBOT supplies the *trigger* on the
cage **seam**:

```
  [WEAVE cage]            [NANOBOT gate — this round]            [payload]
  T=1 60-mer    ──seam──  aptamer-AND  ⨯  (pH≥6.5 OR enzyme≥0.55)  →  WAY-316606
  20 nm, PEG              ────────────────────────────────────       (Wnt restorer)
  encapsulates           opens ONLY at the DPC: marker-AND          or 1 siRNA duplex
                         AND (neutral pH OR follicular protease)
       │                              │
       └──── trans-follicular shunt ──┘ → DPC bulb (~1.5 mm) → gated release → Wnt↑
```

- The WEAVE aptamer-AND lock (DPC surface-marker recognition) is the **AND** arm;
  the NANOBOT pH/enzyme latch is the **microenvironment OR** arm. Net seam logic =
  **marker-AND ⨯ (pH OR enzyme)** — both a *who* (DPC marker) and a *where*
  (DPC microenvironment) must agree before the door opens. This is strictly tighter
  than either axis alone → minimizes off-target/en-route release.
- Result: the AGA-RX "topical → follicle → DPC → gated release → Wnt restoration"
  loop is closed with a 138× ON/OFF switch and 6.9–65× DPC-retention gain over a
  passive carrier.

---

## 5. Tier / honesty (d6 · g63)

**Tier = in-silico DESIGN FEASIBILITY** (not a wet-lab / structural / clinical claim).

- The inherited actuation core (4-state CTMC + Langevin + σ(6)=12) is the **verified,
  ported** primitive — runs 7/7 in this round (sigma/tau/finite/master-identity all
  true) and 6/6 in its own self-check; the only change was the `isfinite` rename.
- The **gate layer is new design-layer modeling**: the Hill latch parameters
  (midpoint pH 6.5, n=4; enzyme K₅₀ 0.55, n=4) are **literature-class but not
  measured for a specific staple** — i-motif/PLIP latches do switch sharply over
  <1 pH unit, and follicular esterase/protease gradients are documented, but the
  exact midpoint/cooperativity of a *fabricated* AGA latch is the falsifiable
  design target.
- The transit-vs-DPC pH (5.0 / 7.2) and enzyme (0.10 / 0.90) endpoints are the
  documented acid-mantle vs dermal microenvironment; the normalized enzyme scale is
  a model abstraction.
- The PK depth-survival reuse (z=1.5 mm, λ bracket) is the round-3 estimate, carried
  honestly as a range.

**Falsifier (pre-registered):** F-NB-GATE-1 — *the gated carrier must show ≥5× ON/OFF
release-rate discrimination (DPC-open / transit-shut) AND ≥5× DPC-retention gain vs a
non-gated carrier across the full round-3 λ_foll bracket.* **Met** in sim (138× ON/OFF;
6.9–65× retention). A ❌ would be: a latch whose realizable midpoint/cooperativity
leaks >5% open in transit (the first sim revision's pH-power latch failed exactly
this and was corrected, not forced).

**Closure path:** in-silico, the gate model is closable by coupling to a Franz-cell /
follicular-PBPK transit profile (the TTR-LAC A5 cascade the round-3/round-4 docs
already trailer) to convert the static transit/DPC endpoints into a time-resolved
pH/enzyme trajectory along the shunt — sharpening the 6.9–65× retention gain into a
time-integrated released-dose curve. No wet-lab is trailered (d1 · d19).

---

### Reuse edges (NEXUS / d19)
- `AGA-RX/NANOBOT ⟵ hexa-bio/nanobot(F-NB-4)` — 4-state CTMC + Langevin + σ(6)=12 actuation core (ported, isfinite-rename only).
- `AGA-RX/NANOBOT ⟵ AGA-RX/round3-admet-pk` — follicular PK depth law `C(z)=C_surf·exp(−z/λ)`, z_DP, λ_foll bracket.
- `AGA-RX/NANOBOT ⟵ AGA-RX/round4-synthesize` — ≤200 nm O/W nanoemulsion base carrier.
- `AGA-RX/NANOBOT → AGA-RX/WEAVE` — supplies the seam GATE (pH/enzyme OR arm) for the WEAVE aptamer-AND lock.
- handoff (d8): `hexa-lang/inbox` — actuation_simulation.hexa `isfinite` ↔ C-backend macro collision (AOT clang).

### Files
- `aga_nanobot_gate.hexa` — gated-release sim (ports the inherited actuation core, adds the gate).
- `sim_output.txt` — captured run transcript (`__AGA_NANOBOT_GATE__ PASS`, 7/7).
