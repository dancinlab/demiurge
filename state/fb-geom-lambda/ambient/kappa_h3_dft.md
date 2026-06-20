# κ-H₃(Cat-EDT-TTF)₂ — TERMINAL H-SSH DFT (the reopened H-corner's terminal compute)

🧪 **RTSC** · ambient lane · `state/fb-geom-lambda/ambient/kappa_h3_dft.md`
artifacts: `kappa_h3_dome_eval.py` · `kappa_h3_dome_eval_results.json` · decks `exports/rtsc/decks/kappa_h3/`.
Date: 2026-06-20 · Provenance: **TB-grade on published geometry** (from-scratch crystal DFPT PENDING).

> The genuine novel frontier of the reopened H-corner: compute the real-host numbers for the ONE
> 1-atm-stable off-diagonal H-SSH host the host-search found (`h_ssh_host_search.md` #1) and decide
> **candidate vs closed**. Upstream: PIN-GSTAR pinned the BEC-valid dome g\*/t≈0.54 → H-Ω\*≈104 meV →
> Tc grazes 293 K; the residual was a **HOST**. This is that host's terminal compute.

---

## TARGET (sharp)
κ-H₃(Cat-EDT-TTF)₂ — single-component H-bonded dimer-Mott **QSL** (published as a quantum spin liquid,
NOT a SC). Two Cat-EDT-TTF π-conductors bridged by a **symmetric [O···H···O]⁻** H-bond whose proton
position **gates the inter-π electron transfer t** → genuine off-diagonal **∂t/∂u (SSH / bond-Peierls)**.
Proposing it as an H-SSH superconductor is the **framing-NOVEL** angle (no SC ever reported on it).

## REAL STRUCTURE (sourced — arXiv:1408.3162 = PRB 92,035102; Shimozawa Nat Commun arXiv:1703.00324; PCCP c6cp05414e)
| quantity | value | provenance |
|---|---|---|
| space group / cell | **C2/c**, a=29.43 b=8.36 c=11.13 Å, β=100.92° (50 K), Z=4 | LIT |
| atoms / cell | **~220** (f.u. C₂₄H₁₅O₄S₁₂ = 55 atoms × Z=4) | LIT/derived |
| **O···O** (H-bond) | **2.45 Å** (short strong); O–H = 1.23/1.22 Å (**centered single-well**, H) | LIT |
| proton barrier | ~69 meV (≈800 K) isolated; **flattened to anharmonic single-well in-crystal** (H) | LIT |
| inter-dimer transfers | b1=241 (intra), **b2=75, p=40 meV (inter-dimer = SSH t)**, W=312 meV, t′/t≈1.25 | LIT (DFT 4-band) |
| magnetism | gapless QSL, J≈80–100 K, no order to 50 mK | LIT |
| Mott depth | **deep dimer-Mott** (deeper than κ-(BEDT-TTF)₂Cu₂(CN)₃; explicit U/t not published) | LIT |
| ⚠ pressure response | **→ charge-ordered INSULATOR**, never metal/SC (≤1.6–2.0 GPa); D freezes CO <185 K | LIT |
| SC ever reported? | **NO** — zero hits 2024–2025 → proposing SC is **NOVEL** | LIT |

## TRACTABILITY (d11) — why full DFPT is PENDING, not skipped
~220 atoms/cell, 12 S (heavy), dispersion-bound molecular solid → full vc-relax + ph.x DFPT on the
O-H-O mode = **days / OOM-risk on a shared free box**. NOT a one-run free-box job (d7/d11). The
tractable substitute is the **published-geometry t(proton) frozen-phonon** (done TB-grade here); the
from-scratch crystal decks are the **resume recipe** in `exports/rtsc/decks/kappa_h3/` for a sized pod.

## THE COMPUTE (TB-grade, validated machinery; `kappa_h3_dome_eval.py`)
Reuses the lane's **validated** machinery — `pin_gstar.py` dome (`g_over_t_at`, `tc_ceiling_K`) +
`bond-bipolaron/solver.py` (validated 2-body SSH ED). Inputs = the **published** O-H-O geometry + t.

**1 — Ω(O-H-O):** the proton-transfer mode of the centered single-well H-bond sits in the **75–200 meV**
band (broad strong-bond proton band; the soft off-center mode, not a stiff 3000 cm⁻¹ terminal O-H).
Central **Ω ≈ 120 meV** (in-band for the 100–300 meV target). Proton ZPM amplitude u₀ = 0.131 Å.

**2 — ∂t/∂u (off-diagonal SSH coupling):** the H-bond-bridged transfer is an **exponential** overlap,
t(u)~exp(−u/δ), so ∂t/∂u = −t/δ — super-linear over the Harrison −2t/d baseline by **S = d/(2δ)**.
With δ (H-bridge overlap decay length) ≈ 0.30–0.50 Å and d=2.45 Å → **S ≈ 2.5–4.1×**.
- Harrison floor (S=1): g/t = 2u₀/d = **0.107** (far below dome).
- H-bridge exponential overlap: **g/t ≈ 0.26–0.44** → **reaches the QMC dome onset g\*/t=0.38** (at δ≤0.35 Å).
- ED cross-check (validated solver, t/Ω=0.33): bound (Δ_b<0), compact (r_pair 1.39a), light (m\*\*≈1.03) at g/t≈0.54.

**3 — real-host Tc via the dome:** Tc-ceiling = C·Ω·11.6 at Ω=120 meV → **278 K (C=0.20) – 446 K (C=0.32)**.
So IF the metallic doped band existed at g/t on the dome, the **coupling+Ω would graze/clear 293 K**.

## THE VERDICT — split, honest (d6)
| axis | result | basis |
|---|---|---|
| **off-diagonal coupling** | **candidate PASS** | O-H-O exp-overlap ∂t/∂u → g/t≈0.26–0.44 (dome onset), Ω≈120 meV in-band, Tc-ceiling 278–446 K |
| **carrier / Mott→metal** | **CLOSES (empirical)** | pressure → **charge-ordered INSULATOR**, never metal (Shimozawa NatComm; RSC Adv C9RA02833A); deep U/t; D freezes CO <185 K |
| **1-atm dynamical stability (doped)** | unmet on record | the CO instability IS the bandwidth-perturbation response; ROOMT g5 #2 not shown for a doped metal |
| **novelty** | **framing-NOVEL** | no SC ever reported on this host; H-SSH-SC framing not in print (host-search novelty gate) |

### 🟠→🔴 κ-H₃(Cat-EDT-TTF)₂ = REAL off-diagonal H-SSH host, **carrier-gate CLOSED on the empirical record** — NOT a room-T discovery
The host is **genuinely** the rare off-diagonal case the corner needed: the O-H-O proton **does** gate
the inter-π transfer (real ∂t/∂u), the coupling **does** reach the dome onset, Ω **is** in-band, and
the Tc-ceiling **would** clear 293 K. **But the carrier axis closes empirically**: the only demonstrated
response of this Mott insulator to a bandwidth perturbation (pressure) is a **charge-ordered INSULATOR**,
not a metal — and that CO **is** the proton localization that produces the off-diagonal coupling. This is
the lane's own **super-linear-∂t/∂u ↔ instability lock** (`non_harrison_gu.md`) realized in a **real
1-atm host**: the same proton coupling that gives S>1 is the proton freezing that gaps the band. The
metallic half-filled SSH band the bipolaron needs is **not reachable on this host by pressure**.

## THE ONE SURVIVING LEVER (untested, novel — d2 breakthrough path, NOT a concession)
**Carrier doping (not pressure) to ν~½ by a non-CO-triggering route** — chemical / field-effect /
electrostatic doping that adds carriers *without* localizing the bridge proton. No literature tests
this; it is a genuinely open novel angle. **Adverse prior**: every demonstrated perturbation (pressure,
deuteration) drives proton localization → CO, so doping would have to defeat that tendency. The
mechanistic discriminator for an experiment: does ν≠1 doping keep the O-H-O proton **delocalized**
(metallic SSH band) or trigger CO (insulator)? That is the single falsifiable question.

## NOVELTY + EXPERIMENTAL HANDOFF (since coupling-axis is a candidate)
- **신규성: framing-NOVEL / mechanism-PUBLISHED** (d_novel_only). The H-SSH-SC framing of κ-H₃ is not in
  print (material published as QSL dimer-Mott; bond-SSH bipolaron mechanism published — PRX 13,011010
  / 2203.07380, 2507.07662, 2605.16625). **NOT a discovery** — the carrier gate closes; report only as a
  framing-NOVEL target with a CLOSED carrier axis + one untested lever.
- **Experimental handoff (the falsifiable test):** electrostatic / chemical light doping of
  κ-H₃(Cat-EDT-TTF)₂ off ν=1; measure whether the inter-π band metallizes (ρ→metal, proton stays
  delocalized via NMR/neutron) **OR** charge-orders (insulator). Metal-without-CO = the H-SSH bipolaron
  door opens (re-confirm novelty + ROOMT g5 #2/#4); CO = the corner closes on this host too.

## DEPLETION TEST (the H-corner's terminal compute)
- O-H-O **Ω ≈ 120 meV** (75–200 meV band, in-band) ✓
- **∂t/∂u** super-linear S≈2.5–4.1× (exp-overlap); **g/t ≈ 0.26–0.44** (reaches dome onset) ✓ TB-grade
- real-host **Tc-ceiling 278–446 K** (would graze/clear 293 K **if metallic**) ✓
- **verdict: candidate-coupling / CLOSED-carrier** — REAL off-diag H-SSH host, framing-NOVEL, but the
  Mott→metal gate closes on the empirical record (pressure→CO insulator). **NOT a room-T discovery.**
- from-scratch **crystal DFPT pending** (resume recipe `exports/rtsc/decks/kappa_h3/`) — it would sharpen
  g/t but **cannot flip** the carrier gate (an empirical, not a coupling, closure).
- one surviving novel lever = **non-CO-triggering carrier doping** → experimental handoff (falsifiable).

## RESIDUAL HONESTY
- TB-grade, not from-scratch crystal DFPT: Ω≈120 meV (75–200 band) and δ≈0.3–0.5 Å (→ g/t≈0.26–0.44)
  are **physically-anchored estimates**, not this-host DFPT numbers. The from-scratch number (decks
  staged) would tighten g/t but the verdict driver is the **empirical CO-insulator** carrier closure,
  which DFPT does not change.
- the dome (C·Ω, g\*/t≈0.54) is the lane's validated QMC-anchored estimator; the Tc-ceiling is an
  upper bound contingent on a metallic doped band that this host does not empirically provide.
