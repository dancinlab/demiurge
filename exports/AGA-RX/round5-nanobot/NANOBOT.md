# AGA-RX Round-5 NANOBOT — DPC trigger-release nanocarrier (gated actuation)

date: 2026-06-03 · domain: AGA-RX · axis: NANOBOT (hexa-bio 5-axis · molecular machine / DNA-origami switch)
goal: add the **trigger-release GATE** to the round-4 ≤200 nm O/W nanoemulsion so the AGA-RX Wnt-restorer
payload is **held during follicular transit and released AT the dermal papilla cell (DPC)**.
reuse (d19): **inherited hexa-bio NANOBOT sandbox** (`hexa-lang/stdlib/bio/nanobot/`) — F-NB-4 4-state
12-vertex DNA-origami actuator (σ6=12 / τ6=4 / φ6=2 / J₂=24); **round4-synthesize FORMULATION.md** (≤200 nm
nanoemulsion base + LA+EtOH CPE); **round3-admet-pk PK.md** (follicular C(z), z_DP, λ_foll, t_lag);
**round5-weave WEAVE.md** (T=1 20 nm icosahedral cage, pairing).
honesty (d6/g63): every actuation number below is **actual hexa sim output** (`sim_out.txt`); every PK
carry-fraction is the **inherited** round-3 C(z)/C_surf. No fabricated constant.

---

## 1. Trigger design — φ(6)=2 open/closed clamp keyed to the DPC microenvironment

The inherited actuator's **φ(6)=2 invariant = bound vs unbound (open/closed clamp)**. Round-5 keys that clamp
to the scalp-follicle stimulus gradient, so the **S0→S1 forward-stroke = payload-RELEASE channel** is gated:

| stimulus axis (d4, manifest-selected) | gate chemistry | CLOSED state (transit) | OPEN state (DPC) | gate fn |
|---|---|---|---|---|
| **pH** (follicle duct→bulb gradient **5→7**) | pH-sensitive **ionizable lipid** (imidazole / DOPE-class), **pKa 6.0**, Hill n=1.5 | protonated + latched at pH 5 (duct) | neutral + released at pH 7 (bulb/DPC) | θ_pH = 1/(1+10^{n(pKa−pH)}) |
| **esterase** (follicle/sebaceous **carboxyl-/cholesterol-esterase**) | **ester-cleavable lipid anchor**, Km, Hill n=2 | intact ester = clamped during transit | cleaved anchor = released at DPC | θ_E = [E]ⁿ/(Kmⁿ+[E]ⁿ) |

Gate mechanism: the latch raises the **effective release barrier** `ΔE_{S0→S1}^eff = 1.0 kT (base) + LATCH·(1−θ)`,
LATCH = 6 kT. Closed latch (θ→0) adds the full 6 kT → release suppressed; open latch (θ→1) restores the
inherited 1 kT barrier → inherited power-stroke fires. **σ6=12 skeleton, τ6=4 motor states, J₂=24 pose quotient,
and the 50 kT/cycle work (≥10 kT Brownian floor) are all inherited UNCHANGED** — the gate touches only the
forward-rate barrier, preserving the verified F-NB-4 physics.

---

## 2. Actuation sim — ACTUAL run (`gated_actuation.hexa`, 4000 cycles, seed 42, 310 K)

Run: `HEXA_LANG=… hexa run exports/AGA-RX/round5-nanobot/gated_actuation.hexa --cycles 4000 --seed 42`
(exit 0; full output in `sim_out.txt`). **actuation fraction = productive / (productive + back-slip) cycles.**

**pH gate** (pKa 6.0, Hill 1.5):

| pH | θ (open) | ΔE_eff (kT) | productive | back-slip | **actuation frac** | work/cycle |
|---|---|---|---|---|---|---|
| 5.0 (duct) | 0.031 | 6.82 | 14 | 401 | **0.034** | 50 kT |
| 5.5 | 0.151 | 6.09 | 17 | 408 | 0.040 | 50 kT |
| 6.0 (pKa) | 0.500 | 4.00 | 153 | 361 | 0.298 | 50 kT |
| 6.5 | 0.849 | 1.91 | 633 | 181 | 0.778 | 50 kT |
| **7.0 (DPC)** | 0.969 | 1.18 | 820 | 101 | **0.890** | 50 kT |

**Esterase gate** (Km, Hill 2.0):

| [E] (×Km) | θ (open) | ΔE_eff (kT) | productive | back-slip | **actuation frac** | work/cycle |
|---|---|---|---|---|---|---|
| 0.1 (transit) | 0.010 | 6.94 | 8 | 399 | **0.020** | 50 kT |
| 0.3 | 0.083 | 6.50 | 13 | 407 | 0.031 | 50 kT |
| 1.0 (Km) | 0.500 | 4.00 | 151 | 358 | 0.297 | 50 kT |
| 3.0 | 0.900 | 1.60 | 749 | 152 | 0.831 | 50 kT |
| **10.0 (DPC)** | 0.990 | 1.06 | 834 | 97 | **0.896** | 50 kT |

**Reference:** CLOSED (θ=0) act_frac **0.0265** vs OPEN (θ=1, = inherited ungated) act_frac **0.891**.

**Trigger threshold + actuation result (actual):**
- **Threshold = the gate midpoint** — pH gate switches at **pKa 6.0** (θ=0.5), esterase at **[E]=Km** (θ=0.5);
  actuation rises from ~3–4 % below threshold to ~78–83 % one half-unit above. Sharp, monotone, finite-OK at all points.
- **Gating ratio (OPEN/CLOSED) = 33.6×** (0.891 / 0.0265). pH gate full-range contrast pH5→pH7 = **26×**;
  esterase 0.1×→10× = **46×**.
- **Work-per-cycle held at 50 kT for every θ** → the gate suppresses *whether* the stroke fires, not its work
  output; the inherited ≥10 kT Brownian-floor margin is preserved (no thermal-collapse, `finite_ok=true` throughout).

---

## 3. Release kinetics — coupled to the inherited follicular PK (gated vs ungated)

Couple the actuation fractions to the inherited round-3 PK (`pk_coupling.py`, output `pk_coupling_out.txt`).
Two-compartment pass: payload descends the follicular **duct** (transit, low stimulus) then arrives at the **DPC**
(high stimulus). Per-pass release propensity = the **actual** act_frac; carry-fraction to DPC depth =
inherited `C(z_DP)/C_surf` (round3-admet-pk 3b).

**DPC-released payload (gated vs ungated), central PK bracket z_DP=1.0 mm / λ_foll=1.0 mm (carry 0.368):**

| gate | en-route leak (duct) | DPC-released (gated) | DPC-released (ungated) | **gated/ungated** |
|---|---|---|---|---|
| pH | 3.4 % | **31.7 %** | 3.6 % | **8.9×** |
| esterase | 2.0 % | **32.3 %** | 3.6 % | **9.1×** |

(at shallow λ=2.0 mm: gated 52–53 %; at deep z_DP=1.5 mm: gated 19–20 % — all ≈9× over ungated.)

**DPC-targeting fidelity = released-at-DPC / total-released:**

| gate | gated fidelity | ungated fidelity | lift |
|---|---|---|---|
| pH | **90.4 %** | 3.8 % | 23.5× |
| esterase | **94.3 %** | 3.8 % | 24.5× |

**Finding:** an **ungated** ≤200 nm nanoemulsion leaks ~89 % of its payload en-route (the OPEN propensity
applies everywhere), so only **3.8 %** of all release lands at the DPC. The **gated** carrier holds payload through
the acidic/low-esterase duct (≤3.4 % leak) and fires at the DPC → **90–94 % of release is DPC-targeted**, a
**~9× lift in DPC-delivered payload** and **~24× lift in targeting fidelity**. Combined with the inherited
once-daily steady-state PK (t_lag days–weeks; the chronic-topical regime), the gate converts the passive
follicular reservoir into a **DPC-selective release depot**.

---

## 4. VERDICT — nanocarrier spec + WEAVE pairing

**NANOBOT trigger-release nanocarrier (AGA-RX):**

| spec | value | source |
|---|---|---|
| base carrier | O/W nanoemulsion, **droplet z-avg ≤ 200 nm, PDI ≤ 0.2** (≥50 % 6 h follicular retention) | round4-synthesize (inherited) |
| **gate chemistry** | **pH-sensitive ionizable lipid (pKa 6.0)** primary · **esterase-cleavable lipid anchor** alt | round-5 (this work) |
| actuator invariant | φ6=2 open/closed clamp on inherited 4-state / 12-vertex / 50 kT power-stroke | inherited F-NB-4 |
| **trigger threshold** | pH gate midpoint **pKa 6.0** (fires pH 6.5→7.0) · esterase midpoint **[E]=Km** (fires ≥3×Km) | sim (actual) |
| gating ratio (OPEN/CLOSED) | **33.6×** (act_frac 0.891 vs 0.0265) | sim (actual) |
| **DPC-targeted release fraction** | **90–94 % targeting fidelity** · ~32 % of payload released at DPC (central bracket) | PK coupling (actual + inherited) |
| en-route leak (duct) | **≤3.4 %** (vs ~89 % ungated) | PK coupling |
| dosing regimen | once-daily steady-state (t_lag days–weeks, chronic topical — minoxidil-class) | round3 PK (inherited) |
| payload | WAY-316606 / analog A2 (SFRP1 inhibitor, Wnt-restorer); siRNA via esterase arm | round4 / round3 |

**Pairing with the WEAVE cage (round5-weave):** the WEAVE **T=1 60-subunit 20 nm icosahedral cage**
(~370 WAY-316606 copies/cage, in the 20–40 nm follicular-accumulation window) is the **structured-shell upgrade**
of the nanoemulsion droplet. The NANOBOT gate plugs onto either substrate identically — **decorate the cage
pentamer vertices (or the droplet surface) with the pH-/esterase-cleavable lipid latch**. The cage adds payload
protection + defined size; the gate adds the **DPC-conditional release**. Recommended product stack:
**nanoemulsion + pH-gate (near-term, robust, cheap)** as primary; **WEAVE T=1 cage + esterase-gate** as the
protected-payload / siRNA line-extension.

**Honesty / open verify items (d6/g63):**
- The actuation engine is a **minimal faithful PORT** of the inherited `actuation_simulation.hexa`, NOT a `use`
  import: the canonical stdlib module fails to compile under the current selfhost codegen — its helper
  `fn isfinite(...)` collides with C `<math.h>`'s `isfinite` macro (10 clang errors). That is a **hexa-lang
  compiler bug → d8 handoff** (`hexa-lang/inbox/patches/`), not a domain defect; the port reproduces the exact
  energy ladder, Stokes drag, CTMC, Langevin SDE, and 50 kT/cycle physics, renaming only the helper to `is_finite_v`.
- **Tier: 🟠 in-silico estimate.** The Hill gate parameters (pKa 6.0, Km, Hill n) and the LATCH 6 kT are
  **design choices bracketing the follicle pH/esterase literature**, not measured for a specific lipid; the PK
  carry-fractions are the inherited round-3 **bracketed ranges**. The *contrast* (33.6× gating, 24× fidelity lift)
  is robust across the bracket because it derives from the monotone Hill switch, not a single tuned constant.
- Closure path (in-silico, d19): titrate a named ionizable-lipid pKa (MD pKa shift) + couple to a Franz-cell /
  follicular-PBPK release model (round-4 verify-lane milestone) to convert the 🟠 bracket to 🟢.

artifacts: this file · `gated_actuation.hexa` (sim source) · `sim_out.txt` (actual sim output) ·
`pk_coupling.py` + `pk_coupling_out.txt` (PK coupling). Inherited: `hexa-lang/stdlib/bio/nanobot/module/actuation_simulation.hexa`.
