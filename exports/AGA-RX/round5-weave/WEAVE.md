# 🧶 AGA-RX · WEAVE axis (round-5) — self-assembling delivery cage

**Axis role:** `hexa-bio` WEAVE = capsid / protein-cage self-assembly (Caspar–Klug
quasi-equivalence + Zlotnick nucleation–elongation thermodynamics). In the
AGA-RX modality matrix WEAVE is the **delivery** modality: a self-assembling
icosahedral cage that encapsulates the Wnt-restorer payload and carries it down
the trans-follicular shunt to the dermal-papilla cells (DPCs).

**Goal:** build the self-assembling delivery cage for the AGA-RX Wnt-restorer
payload, **inheriting** the verified hexa-bio WEAVE sandbox (d19 — do not rebuild).

---

## 0. Inheritance (d19) — what was reused, not rebuilt

| inherited primitive | source (UNMODIFIED, imported) | what it gives |
|---|---|---|
| `caspar_klug_geometry(T)` | `hexa-bio/_python_bridge/module/capsid_assembly_modulator_sim.py` | exact T-number geometry: 60·T subunits = 12 pentamers + 10·(T−1) hexamers, Euler V−E+F=2 |
| `assembly_equilibrium(g)` | same module | Zlotnick mean-field per-subunit ΔG_net + pseudo-critical concentration c* |
| `assembled_fraction(c,c*)` | same module | Zlotnick-sharp cooperative assembled fraction (yield) |
| Zlotnick weak-contact band + kinetic-trap threshold | same module constants | the assembly-window guard rails (−4.5..−1.5 kcal/mol; trap ≤ −5.0) |
| follicular PK rate laws `t_lag=h²/(6D)`, `C(z)=C_surf·exp(−z/λ)` | AGA-RX `discover-frontier/FRONTIER.md` §3b (reused from TTR-LAC/A1,A3) | trans-follicular-shunt delivery model |

The imported module is the `:>` VIROCAPSID sub-axis of the WEAVE cage-assembly
ODE; it passes its **own 7/7 C1–C7 self-check** (Caspar–Klug exact · Zlotnick
weak-contact band · ΔG↔K round-trip · cooperative-fraction monotone · kinetic-trap
flag · determinism). It is the verified numerical sandbox the WEAVE tape
(`HEXA-WEAVE.tape` §1–§3, σ(6)=12 STRUCTURAL-EXACT, posterior 0.97) describes.

The round-5 design layer (`aga_weave_cage_design.py`) **adds only** AGA-RX-specific
arithmetic on top: cage diameter/volume sizing, payload-fit, and the
follicular-PK fit. Run: `python3 aga_weave_cage_design.py` → `__AGA_WEAVE_CAGE__ PASS`
(full transcript in `sim_output.txt`).

---

## 1. Cage architecture (Caspar–Klug T-number) sized to the payload

Payloads under consideration:

- **WAY-316606** — SFRP1 antagonist / Wnt restorer (PATH-A small molecule),
  MW 448 Da → molecular volume **≈ 0.54 nm³** (1.2 Å³/Da).
- **siRNA duplex** — RIBOZYME-axis arm, 21 bp A-form duplex (~14 kDa) →
  **5.9 nm long × 2.4 nm dia, ≈ 26.6 nm³** (cylinder).

Candidate cages (inherited Caspar–Klug geometry; diameter calibrated by √T
scaling on a literature T=1 anchor of 20 nm, shell 2.2 nm):

| T | subunits | pent | hex | D_out (nm) | D_in (nm) | V_in (nm³) | #WAY @10% fill | #siRNA @20% fill |
|---|---|---|---|---|---|---|---|---|
| **1** | 60 | 12 | 0 | 20.0 | 15.6 | 1 988 | ~370 | ~15 |
| 3 | 180 | 12 | 20 | 34.6 | 30.2 | 14 481 | ~2 694 | ~109 |
| 4 | 240 | 12 | 30 | 40.0 | 35.6 | 23 624 | ~4 394 | ~178 |

**Chosen architecture: T=1, 60-subunit icosahedral cage** (12 pentamers, 0
hexamers; the minimal closed Caspar–Klug shell).

- Internal volume **1 988 nm³** vs payload 0.54 nm³ (WAY-316606): the
  small-molecule payload is **>3 600×** smaller than the interior — encapsulation
  is volume-trivial; loading is set by surface/charge chemistry, not by volume.
  Capacity at a conservative 10 % interior fill ≈ **370 WAY-316606 copies / cage**.
- A single 21-bp siRNA rod (5.9 nm) also fits inside the 15.6 nm inner cavity, so
  T=1 can carry **one duplex**; for an siRNA-primary product the **T=3 (30 nm,
  14 500 nm³)** cage gives comfortable headroom (~100 duplexes) and is the
  recommended sibling spec for the RIBOZYME-axis variant.

> T-number quantization is a HARD geometric wall (only T = h²+hk+k²; T=2,5,6… are
> forbidden — `HEXA-WEAVE.tape @lim_t_quantization`). T=1/3/4 are all allowed; we
> are not free to pick an arbitrary subunit count.

---

## 2. Assembly numbers (inherited Zlotnick equilibrium, actual sim run)

Engineered inter-subunit interface tuned **inside** the Zlotnick weak-contact band
(error-correcting, not over-stabilized): **g_contact = −4.0 kcal/mol**
(the `mild_stabilizer` regime of the inherited panel).

| quantity | value | note |
|---|---|---|
| per-contact ΔG (engineered) | −4.0 kcal/mol | inside band [−1.5, −4.5]; trap if ≤ −5.0 |
| net per-subunit ΔG_net | −3.000 kcal/mol | (z/2)·g + entropy penalty |
| **pseudo-critical concentration c\*** | **7.674 × 10⁻³** | dimensionless, 1 M std-state |
| assembly constant K | 1.303 × 10² | = 1/c* |
| **kinetic-trap flag** | **False** | −4.0 > −5.0 → anneals to closed shell (error-correcting) |

Cooperative assembled fraction (yield) vs total subunit concentration:

| c_total | f_assembled (yield) |
|---|---|
| 0.5·c* | 0.0002 |
| 1·c* | 0.5000 (sharp midpoint) |
| 2·c* | 0.9998 |
| **5·c* (DEPLOY)** | **1.0000** |
| 10·c* | 1.0000 |

**Critical concentration c\* = 7.67 × 10⁻³, nucleation is error-correcting (no
kinetic trap), and at the deploy concentration 5·c* the assembled yield is ≈ 1.00.**
Zlotnick assembly–disassembly **hysteresis** (`HEXA-WEAVE.tape @z_hysteresis`) is
the deployment lever: assemble + load at high subunit flux, then the closed cage
**persists** when diluted below c* in the topical vehicle.

---

## 3. Delivery fit — trans-follicular shunt to the DPC (reused AGA-RX PK)

Reuses the AGA-RX follicular PK rate laws (FRONTIER §3b ← TTR-LAC/A1,A3):

- **SC-diffusion bound (the route the cage AVOIDS):** `t_lag = h²/(6D)` with
  h = 50 µm, D = 1×10⁻¹⁰ cm²/s → **t_lag ≈ 694 min (~12 h)**, and if the cage had
  to *cross* the inter-follicular stratum corneum the surviving fraction at a 3 mm
  depth would be ≈ 10⁻²² (i.e. essentially zero). This is the slow comparator.
- **Operative route — trans-follicular SHUNT:** the 20 nm cage travels the **open
  follicular lumen** (sebum-filled infundibulum) by Brownian + convective
  transport down to the **DPC bulb at ~3 mm**, **bypassing** the SC
  rate-limiting diffusion entirely. This is the AGA-RX delivery thesis: AGA is a
  follicle-targeted indication, so the shunt route *raises* effective delivery vs
  the inter-follicular SC model.
- **Size window:** nano-carriers accumulate preferentially in the follicle with an
  optimum near ~40 nm (<10 nm leak out, >100 nm are excluded). The **T=1 (20 nm)**
  and **T=3 (35 nm)** cages both sit **in-band**.

**Surface chemistry for follicular targeting:**
- Neutral / slightly-anionic **PEGylated exterior** → sebum-compatible, suppresses
  protein-corona aggregation while transiting the shunt.
- Exterior size tuned to the **20–40 nm** follicular-accumulation window (T=1→T=3).
- A **NANOBOT-axis aptamer-AND lock** on the cage seam (Douglas/Bachelet/Church
  2012 logic-gated DNA-origami cargo door — `HEXA-NANOBOT.tape @dna_origami_cargo`)
  keeps the door shut until a **DPC marker-AND condition** is met → no premature
  payload dump in transit.

---

## 4. Verdict — cage spec + NANOBOT pairing

**Cage spec (in-silico design feasibility):**

| field | value |
|---|---|
| architecture | **T=1 icosahedral, 60 subunits** (12 pentamers + 0 hexamers; Euler V−E+F=2 ✓) |
| outer diameter | **20 nm** |
| inner diameter / interior volume | 16 nm / **1 988 nm³** |
| payload | **WAY-316606** (MW 448, 0.54 nm³) — ~370 copies/cage @10% fill, or **1 siRNA duplex** |
| siRNA-primary sibling | **T=3, 30 nm, 14 500 nm³** (~100 duplexes) |
| assembly yield | **f ≈ 1.00** at c_total = 5·c* (c* = 7.67×10⁻³); **no kinetic trap** |
| delivery | trans-follicular shunt → DPC bulb (~3 mm), 20–40 nm follicular window, PEG exterior |

**How it pairs with NANOBOT (gated release) in the AGA-RX delivery stack:**

```
  [WEAVE cage]            [NANOBOT gate]                 [payload]
  T=1 60-mer    ──seam──  aptamer-AND lock (Douglas/   →  WAY-316606
  20 nm, PEG              Bachelet/Church 2012)            (Wnt restorer)
  encapsulates           opens ONLY at DPC marker-AND     or 1 siRNA duplex
  Wnt-restorer           (pH / enzyme / surface marker)
       │                        │
       └─ trans-follicular shunt ┘ → DPC bulb (~3 mm) → gated release → Wnt↑
```

- **WEAVE** supplies the *container* (self-assembling, error-correcting, ~100%
  yield, follicular-window-sized) and the *transit survival* (closed shell +
  hysteresis-stable in dilute topical vehicle).
- **NANOBOT** supplies the *trigger*: the aptamer-AND / pH / enzyme-gated seam so
  the payload is released **only at the dermal papilla**, not en route — closing
  the AGA-RX "topical → follicle → DPC → gated release → Wnt restoration"
  delivery loop. The DHT→DPC→Dkk1↑/SFRP1↑→Wnt↓ anchor pathway is attacked at the
  DPC with the Wnt-restorer delivered intact.

**Tier / honesty (d6 · g63):** the Zlotnick equilibrium + Caspar–Klug geometry
(c*, yield, subunit counts, Euler invariant) are the **inherited, self-verified**
primitives, run verbatim. The diameter calibration (√T scaling on a literature
T=1 anchor), payload molecular volumes (1.2 Å³/Da), capacity fill-fractions, and
the follicular-PK reuse are **new design-layer estimates** →
tier = **in-silico DESIGN FEASIBILITY**, NOT a wet-lab / structural / clinical
claim. The T=1 cage diameter and the ~100% assembled yield are consistent with
engineered-protein-cage literature magnitudes.

**Falsifiers carried (from `HEXA-WEAVE.tape`):** F-CAGE-MVP-1 (yield ≥ 0.95 across
3 independent calibrations — the inherited sandbox notes a 0.68 plateau under
stiff-ODE k_close; the mean-field equilibrium yield reported here is the
thermodynamic ceiling, not the kinetic-ODE plateau); the WEAVE σ(6)=12
STRUCTURAL-EXACT audit (posterior 0.97) is the geometric backbone.

---

### Reuse edges (NEXUS / d19)
- `AGA-RX/WEAVE ⟵ hexa-bio/WEAVE(VIROCAPSID sub-axis)` — `caspar_klug_geometry`,
  `assembly_equilibrium`, `assembled_fraction`, weak-contact band, kinetic-trap guard.
- `AGA-RX/WEAVE ⟵ AGA-RX/TTR-LAC A1,A3` — follicular PK rate laws.
- `AGA-RX/WEAVE → AGA-RX/NANOBOT` — provides the cage seam that NANOBOT gates.
- `AGA-RX/WEAVE → AGA-RX/RIBOZYME` — provides the T=3 siRNA-carrier sibling spec.

### Files
- `aga_weave_cage_design.py` — design-layer sim (imports the inherited sandbox).
- `sim_output.txt` — captured run transcript (`__AGA_WEAVE_CAGE__ PASS`).
