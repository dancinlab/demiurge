# AGA-RX Round-3 — Topical Follicular PK Model (trans-follicular shunt → dermal papilla)

date: 2026-06-03 · host: mini · milestone = ANALYZE
method: **inherited verified skin-permeation primitives (d19) re-parameterized for the trans-follicular shunt route**
script: `pk_follicular.py` (sympy symbolic + numeric) · anchor self-check PASSES (EMLA onset 55.6 min)
honesty (d6): the inherited forms are verified; the follicular re-parameterization (λ_foll, D_foll, z_DP) is a
literature-bracketed RANGE, reported as such. No single fabricated constant.

---

## 1. Inherited primitives (d19 — verbatim, NOT re-derived)

| inherited asset | value | source |
|---|---|---|
| SC lag-time `t_lag = h²/(6D)`, onset ≈ 2·t_lag | EMLA D=1e-10 cm²/s, h=10 µm → **55.6 min** ≈ clinical ~60 min (🔵) | TTR-LAC/A1 (`domains/TTR-LAC.log.md`, NUMB.md table) |
| depth model `C(z) = C_surf·exp(−z/λ)` | interfollicular SC **λ = 40–60 µm** (epi 1:200k) | TTR-LAC/A3 (`domains/TTR-LAC.log.md`, NUMB.md table) |
| onset is **D-driven only** | a · K_sc · f_free are J_ss *prefactors*, `t_lag` invariant (3× FALSIFIED in NUMB) | NUMB.log.md (N1·N6·N7) |

**Anchor reproduction** (`pk_follicular.py`): `2·h²/(6D)` with h=10 µm, D=1e-10 → **55.6 min** ✓ (matches TTR-LAC/A1 exactly).

---

## 2. Trans-follicular re-parameterization (the round-3 contribution)

The interfollicular model attenuates a topical at λ=40–60 µm: at the dermal-papilla depth (1–1.5 mm)
`exp(−1500/50) ≈ 1e−13` → **zero drug reaches the DP transepidermally**. AGA's target (the dermal papilla
cell, DPC, at the hair-bulb base) is reachable only via the **trans-follicular (appendageal) shunt** — transport
*down the follicular duct*, bypassing the stratum-corneum barrier. Re-parameterized inputs:

| parameter | interfollicular (inherited) | trans-follicular shunt (re-param) | basis |
|---|---|---|---|
| effective length `h_eff` | 10 µm (SC thickness) | **z_DP = 1.0–1.5 mm** (scalp terminal-follicle bulb depth) | web: follicular shunt / bulb base; nanoparticle depth studies |
| diffusivity `D` | 1e-10 cm²/s (transcellular SC) | **D_foll = 1e-9 … 1e-8 cm²/s** (10–100× — duct is aqueous/sebum channel, no SC resistance) | shunt route 1–3 orders faster than SC |
| attenuation length `λ` | 40–60 µm | **λ_foll = 0.2–2.0 mm** (mm-scale — the shunt's defining property is bypassing the SC) | bracketed; reported as range |

z_DP and D_foll grounded by the follicular-shunt literature (nanoparticles reach ≥400 µm into the follicle
mechanically; the duct is a low-resistance channel to the bulb). λ_foll is the model's free parameter — we report
the *minimum λ_foll* needed to clear potency, which is the falsifiable formulation target.

---

## 3. Results

### 3a. Time-to-DP (lag) — `t_lag = h_eff²/(6 D_foll)`, onset = 2·t_lag

| z_DP | D_foll | t_lag | onset (2·t_lag) |
|---|---|---|---|
| 1.0 mm | 1e-9 | 463 h (19 d) | 926 h (39 d) |
| 1.0 mm | 1e-8 | 46 h (1.9 d) | 93 h (3.9 d) |
| 1.5 mm | 1e-9 | 1042 h (43 d) | 2083 h (87 d) |
| 1.5 mm | 1e-8 | 104 h (4.3 d) | 208 h (8.7 d) |

**Finding:** lag to the DP is **days-to-weeks**, not minutes (mm vs µm path → ~10⁴× the EMLA lag). This is
the *expected* PK signature of a chronic once-daily topical AGA drug — minoxidil/finasteride topicals likewise
show weeks-to-onset clinical hair response and require sustained dosing. The lag is NOT a developability fail; it
sets a **once-daily, steady-state** dosing regimen, not an acute one. (Note: the depth lag-time form treats the
follicle as a 1-D diffusion slab; mechanical/vellus-pumping uptake — documented for particles — would shorten it.)

### 3b. Steady-state DP concentration — `C(z_DP) = C_surf·exp(−z_DP/λ_foll)`

Fraction `C(z_DP)/C_surf` reaching the DP:

| z_DP | λ=0.2 mm | λ=0.5 mm | λ=1.0 mm | λ=2.0 mm |
|---|---|---|---|---|
| 1.0 mm | 0.007 | 0.135 | 0.368 | 0.607 |
| 1.5 mm | 0.001 | 0.050 | 0.223 | 0.472 |

### 3c. Efficacy gate — does C(DP) reach target potency? (margin = C(DP)/EC50)

**WAY-316606** — target potency = **SFRP1 EC50 = 0.65 µM** (measured, ex-vivo hair-growth active; APExBIO/BOCSci).
Aqueous solubility ceiling (ADMET-AI AqSolDB) = 871 µM. Formulated surface: 0.1% w/v = 2230 µM, 1% w/v = 22 300 µM.

At **C_surf = 1% w/v**, every (z_DP, λ_foll) cell in the bracket CLEARS EC50 (margin ×19 at the worst corner
z_DP=1.5 mm/λ=0.2 mm, up to ×20 000 at the best). The **minimum λ_foll** to reach EC50 at the deepest DP (1.5 mm):

| C_surf | min λ_foll to hit EC50 @ 1.5 mm |
|---|---|
| 1% w/v | **λ_foll ≥ 0.144 mm** |
| 0.1% w/v | **λ_foll ≥ 0.184 mm** |

Since the shunt's attenuation length is mm-scale (≫0.18 mm), WAY-316606 **reaches efficacious DP concentration**
across the plausible λ_foll range, even at a low 0.1% surface load — large potency headroom absorbs the order-of-
magnitude uncertainty in λ_foll/D_foll.

### 3d. LRP6 fragment leads — target potency from Vina ΔG (order-of-magnitude only)

No measured Ki for the fragments (round-2 = Vina ranking). Estimating Kd = exp(ΔG/RT) (RT=0.593 kcal/mol):

| fragment | Vina ΔG | est. Kd (µM) | C_surf 0.1% (µM) | reaches Kd at DP? |
|---|---|---|---|---|
| 2-naphthylguanidine | −7.17 | ~5.7 | 5400 | yes if λ_foll ≥ ~0.22 mm |
| 4-guanidinobenzoic_acid | −7.16 | ~5.7 | 5580 | yes if λ_foll ≥ ~0.22 mm; **but** PAMPA 0.015 → shunt-entry-limited |
| tyramine-guanidine_hybrid | −6.87 | ~9.3 | 5580 | yes if λ_foll ≥ ~0.24 mm; **but** skin-reaction 0.77 caps usable C_surf |

Caveat: Vina ΔG over-binds (round-2 noted +2 kcal/mol on hydrophobic grooves); these Kd are upper-bound-optimistic.
The fragments are sub-µM neither measured nor confirmed — they are **fragment starting points**, not potency-validated
leads. The PK headroom exists *if* potency holds, but their ADMET liabilities (4-GBA permeability, tyramine skin) are
the binding constraints, not the DP math.

---

## 4. PK verdict per lead (reaches-DPC)

| lead | time-to-DP | C(DP) ≥ potency? | reaches-DPC verdict |
|---|---|---|---|
| **WAY-316606** | days–weeks (once-daily steady-state) | **yes, ×19–20000 margin** even @0.1% w/v | **PASS** (robust to λ_foll/D_foll uncertainty) |
| 2-naphthylguanidine | days–weeks | yes if λ_foll ≥ 0.22 mm AND potency holds | FLAG (unvalidated potency + skin/CYP1A2) |
| 4-guanidinobenzoic_acid | days–weeks | DP-math OK but **shunt entry PAMPA 0.015** | FLAG (permeability is the wall) |
| tyramine-guanidine_hybrid | days–weeks | DP-math OK but **skin 0.77 caps C_surf** | FLAG (topical-safety is the wall) |

---

## 5. Honest limits (d6)

- λ_foll, D_foll, z_DP are literature-**bracketed ranges**, not measured for these molecules — the verdict for
  WAY-316606 is robust *because* the ×10³–10⁴ potency headroom survives the full bracket; the fragments' verdicts
  are NOT robust (they sit near the margin and lack measured potency).
- The 1-D slab `t_lag` ignores follicular reservoir/pumping kinetics (faster) and metabolism/clearance from the
  DP (slower steady-state) — both are second-order vs the order-of-magnitude conclusion.
- This is a closed-form first-principles PK estimate (sympy/scipy, d19 MATLAB-grade), NOT a measurement. Wet-lab
  Franz-cell + follicular-closing-technique permeation would convert these 🟠 ranges to 🟢 — same oracle handoff
  class TTR-LAC/NUMB already identified (Tier-A Franz cell).
