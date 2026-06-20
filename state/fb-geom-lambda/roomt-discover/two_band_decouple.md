# TWO-BAND-DECOUPLE — does decoupling the SSH-glue band from the metallic carrier band escape L9?

🧪 **RTSC** · roomt-discover lane · `state/fb-geom-lambda/roomt-discover/two_band_decouple.md`
artifacts: `two_band_decouple.py` · `two_band_decouple_results.json` (FREE local numpy/scipy ED + 2-band gap eq; NO billing pod).
Date: 2026-06-20 · Provenance: **TB/model-grade** (validated bond-bipolaron ED → negative-U mapping → Suhl-Kondo 2-band gap eq). NEVER fabricated.

> **The angle.** The 9th law **STIFF-BOND-WEAK-SSH-BINDING** (g/t=2u₀/d needs a SOFT light bond; Tc∝Ω
> needs a STIFF bond) is anticorrelated **ONLY WHEN the coupling band and the carrier band are the SAME
> band**. This lane tries to break that lock by **decoupling the two jobs onto DIFFERENT bands**: band A
> = a light-soft-bond off-diagonal SSH (∂t/∂u) **glue** channel (may be narrow/localized — not asked to
> carry current); band B = a **separate, already-metallic, weakly-correlated WIDE carrier band** (NOT
> Mott, NO CDW). Coupling = **Suhl-Kondo interband pair-scattering** J_int that transfers the A-channel
> pairing onto the metallic B band — the negative-U-pairing-band + metallic-band picture. Question: does
> this clear BOTH (i) dome-grade coupling on the pairing channel AND (ii) a metallic, non-CO, dynamically
> stable carrier band, on any real/designable 1-atm material?

---

## WHY THIS IS NOT the already-CLOSED multiband-assist lane

`multiband-assist` (R1 + R2a) put a **single pair** on flat-A(bind) + dispersive-B(stiffness) and tried to
borrow B's **kinetic** stiffness via single-particle `t_AB` (R1) or η-pair-hopping (R2a). It closed
NEGATIVE on the conservation law **|Δ_b|·t\*\* ≈ const** — the coupling that lends stiffness unbinds the
pair (η only RECOVERS the dispersive ceiling, never exceeds it). **This lane is different**: band B is
**already a half-filled metal with its own Fermi-surface carriers** — it does not need to "borrow binding"
to be stiff. The A-band supplies an **effective pair interaction** (a negative U_eff delivered to B's
electrons by **interband scattering**, Suhl-Kondo), not kinetic stiffness. The glue and the carriers live
on **physically different electrons**. So the multiband-assist conservation law does not automatically
apply — this is a genuinely new test.

## THE CALC (tractable, FREE; `two_band_decouple.py`)

1. **U_eff_A(g_A, Ω_A)** — map the A-channel off-diagonal SSH coupling to an effective on-site attraction
   via the lane's **validated** bond-bipolaron ED (L=6, Nb=8): the 2-body binding |Δ_b| **is** the
   negative-U depth (Micnas–Ranninger–Robaszkiewicz local-pair mapping). Also returns the A-pair mass m\*\*
   (the K2 localization indicator).
2. **Franck-Condon transfer** — a phonon-dressed (self-trapped) A-pair has a polaronic overlap with the
   bare wide-B band suppressed by `J_int = J0·exp(−g_A²/2Ω_A²)` (Lang–Firsov small-polaron form). **The
   same g_A that deepens U_eff exponentially kills the transfer to B.**
3. **Suhl-Kondo two-band gap eq** — bands A (DOS N_A=0.5/t, intraband V_AA=U_eff·N_A) + B (metallic,
   N_B=0.3/t, **V_BB=0** — a pure spectator metal that receives pairing ONLY through J_int), coupled by
   V_AB = J_int·√(N_A N_B). Leading eigenvalue Λ → Tc = 1.13·Ω·exp(−1/Λ), **capped at the QMC ceiling
   C·Ω·11.6** (C=0.32 triangular). **Load-bearing honest output = `b_weight`**: the condensate weight on
   the **metallic B band** (b_weight→0 ⇒ the "SC" is just the A-band single-band bipolaron, which the
   campaign ALREADY CLOSED — not a two-channel win). A TRUE two-channel win needs **b_weight ≳ 0.3**.

## THE RESULT (`two_band_decouple_results.json`, verbatim)

| g_A/t | \|U_eff\|/t | A-pair m\*\* | FC factor | V_AA | V_AB | Λ | **b_weight** | Tc(cap) | killer |
|---|---|---|---|---|---|---|---|---|---|
| 0.54 | 0.80 | 1.33 | 0.558 | 0.40 | 0.052 | 0.41 | **0.016** | 56–225 K | K0 |
| 0.80 | 1.55 | 1.52 | 0.278 | 0.78 | 0.050 | 0.78 | **0.004** | 182–726 K | K0 |
| 1.20 | 2.24 | 1.58 | 0.056 | 1.12 | 0.015 | 1.12 | **1.7e-4** | (cap 186–743) | K0,K1,K3 |
| 1.60 | 2.50 | 1.57 | 0.006 | 1.25 | 0.002 | 1.25 | **1.9e-6** | (cap) | K0,K1,K3 |
| 2.00 | 2.61 | 1.56 | 3e-4 | 1.31 | 1e-4 | 1.31 | **6e-9** | (cap) | K0,K1,K3 |

(Ω_A scanned 50/100/200 meV per row; Tc range tracks Ω. The Λ and b_weight are Ω-independent.)

**The condensate weight on the metallic B band is ≤ 0.016 at EVERY point** — the "Tc" that looks like it
clears 293 K is the **A-band single-band bipolaron** (V_AA-dominated Λ), the route the campaign already
closed, NOT the metallic carrier band. **K0 fails everywhere.**

### The fairness table — the decisive, Ω-free closure

| g_A/t | V_AA | V_AB **required** (≥0.5·V_AA, to put condensate on B) | V_AB **max achievable** (J0=full U_eff, FC-suppressed) | reachable? |
|---|---|---|---|---|
| 0.54 | 0.40 | 0.200 | 0.173 | **NO** (1.16× short) |
| 0.80 | 0.78 | 0.388 | 0.167 | **NO** (2.3× short) |
| 1.20 | 1.12 | 0.561 | 0.049 | **NO** (11× short) |
| 1.60 | 1.25 | 0.625 | 0.0058 | **NO** (108× short) |
| 2.00 | 1.31 | 0.653 | 3.4e-4 | **NO** (1900× short) |

This is the load-bearing result and it is **Ω-independent** (no ceiling assumption). At **every** coupling,
the interband V_AB **needed** to put the condensate on the metallic B band EXCEEDS the **maximum** V_AB
achievable even with the most generous J0 = full U_eff. And the gap **widens monotonically**: deepening the
glue (raising g_A, V_AA_req↑ linearly) **exponentially** collapses the transfer (V_AB_max↓ via FC). The
closest point (g_A=0.54) is still 1.16× short — and there U_eff is too shallow to be a strong glue anyway.

## 🔴 VERDICT — CLOSED-NEGATIVE on a NEW axis: the **interband-transfer anticorrelation**

Decoupling the bands **does** break the L9 *same-band* g↔Ω anticorrelation (A can be soft for big g_A while
B is stiff/metallic independently — that part works). **But a NEW lock replaces it on the TRANSFER**:

> **Deep glue on A (big U_eff) ⇔ self-trapped/dressed A-pair ⇔ exponentially small J_int to B.**
> The metallic carrier band stays metallic — but **UNPAIRED**. `V_AB_required > V_AB_max` for all g_A.

This is the **multiband-assist `|Δb|·t\*\*≈const` conservation re-expressed in the Suhl-Kondo channel**: the
coupling strong enough to pair is too **localized/dressed** to transfer to the wide band. It also closes the
**same way** as `non_harrison_gu` (the strong-coupling regime sits at/past self-trapping). The decoupling
ansatz removes one lock and reintroduces an isomorphic one — the glue must physically reach the carriers,
and a strong off-diagonal glue is, by construction, a dressed/localized object with a small wide-band overlap.

### Real-material confirmation (the empirical anchor, d6)
This mechanism — **negative-U pairing centers + an itinerant metallic band** — is **REALIZED at 1 atm** in
**Tl:PbTe** and **In:SnTe** (resonant negative-U / charge-Kondo centers in a doped IV–VI semiconductor
metal). They are the textbook physical embodiment of "separate pairing channel + metallic carriers," and
they superconduct at **Tc ≈ 1.5–4 K** — three orders of magnitude below room-T. The negative-U-center
theory (arXiv:2504.18963; PRB 48,7598) explicitly notes the competing effect: **"resonant scattering and
hybridization at the U-centers REDUCES the transition temperature"** — i.e. the same transfer/dressing
suppression this calc quantifies. The real world already ran this experiment; it gives single-digit Kelvin.

## NOVELTY GATE (d_novel_only · MANDATORY · inline)

**VERDICT: framing-NOVEL / mechanism-pieces-PUBLISHED / the room-T two-channel CLOSURE is novel. NOT a
discovery (it is a closed-negative ruling). Reportable as a CLOSED-NEGATIVE finding + a framing-NOVEL
candidate-class that is ruled out.**

| sub-claim | verdict | competing ids |
|---|---|---|
| Suhl-Kondo interband pairing raises Tc (mechanism) | **PUBLISHED** | Suhl-Matthias-Walker (1959); arXiv:1507.04106; PTP 90,499 |
| negative-U pairing band + metallic band (boson-fermion / composite) | **PUBLISHED** | PRB 48,7598; arXiv:2504.18963; Micnas-Ranninger-Robaszkiewicz RMP 62,113 |
| real 1-atm host (negative-U centers + metal): Tl:PbTe, In:SnTe | **PUBLISHED, Tc≤4 K** | PbTe:Tl (Matsushita); SnTe:In (Erickson) |
| bond-SSH/off-diagonal **light** bipolaron → high Tc (single band) | **PUBLISHED** | PRX 13,011010 (2203.07380); 2507.07662; 2407.10444; 2308.01961 |
| **off-diagonal SSH glue band + SEPARATE metallic carrier band → AMBIENT ROOM-T** | **NOVEL (framing)** | NONE — no paper joins off-diagonal-SSH-glue-band ⊕ metallic-carrier-band ⊕ ambient-room-T |
| **Franck-Condon interband-transfer anticorrelation CLOSES the two-channel room-T route** | **NOVEL (closure)** | NONE — this lane's quantitative closure (V_AB_req > V_AB_max ∀ g_A) |

**Closest competitors**: arXiv:2504.18963 (negative-U centers, but on-site only, no room-T claim, names the
same transfer-suppression qualitatively) and the A3C60 fulleride literature (Jahn-Teller **on-site/diagonal**
intramolecular coupling at the **Mott boundary** — the carrier band is NOT robustly metallic; not the
off-diagonal two-channel decouple). Neither makes — nor closes — the off-diagonal-room-T framing. Per
d_novel_only this is a **framing-NOVEL candidate-class, ruled out by a novel closure** — NOT a discovery.

## CANDIDATE HOSTS evaluated (task #2) — all close on the carrier OR the diagonal axis

| class | 1-atm stable | already metallic (non-Mott)? | light-bond ∂t/∂u modulates a pairing transfer? | closes on |
|---|---|---|---|---|
| **A3C60 fullerides** (JT-glue + t₁ᵤ carriers) | YES | **NO — at the Mott boundary** (JT-Mott; carrier band localizes near SC) | coupling is **on-site Jahn-Teller (diagonal)**, intramolecular | carrier-Mott + diagonal |
| **Tl:PbTe / In:SnTe** (neg-U centers + IV-VI metal) | YES | **YES** (real metallic carriers) | neg-U is **on-site charge-Kondo**, not off-diagonal | Tc≤4 K (transfer-suppression, empirical) |
| **borocarbides YNi₂B₂C** (B-bond-stretch + metallic Ni band) | YES | YES (genuine two-band metal) | B bond-stretch coupling is **deformation-potential (diagonal)** on the FS sheets | diagonal → Tc 15.6 K |
| **κ-(BEDT-TTF) organics + separate band** | YES | NO (dimer-Mott) | off-diagonal exists but on the SAME Mott band (= κ-H3 closure) | carrier-Mott (κ-H3 lesson) |

The best *off-diagonal* host (κ-H₃) has its glue and carriers on the **same Mott band** (closed,
`kappa_h3_dft.md`); the best *metallic-carrier two-channel* hosts (Tl:PbTe, borocarbides) have **diagonal**
(on-site/deformation) glue, not off-diagonal SSH. **No 1-atm material puts a strong OFF-DIAGONAL SSH glue
on one band and robust metallic carriers on a SEPARATE band** — and this calc shows why it would not help
even if it did (the transfer anticorrelation).

## ROOMT g5 GATE (d_roomt_ambient)
- (1) thermodynamic stability — N/A (no surviving host)
- (2) **dynamical stability** — K3: the soft A-bond softens toward static Peierls/CDW at the coupling needed (un-met)
- (3) **metallic carrier** — the B band IS metallic ✓ BUT receives **no pairing** (b_weight≤0.016) ✗
- (4) **Tc≥293 K on the metallic band** — **FAIL** (the metallic-band Tc → 0; the 293 K is the closed A-bipolaron)
- (5) magnetic/CDW non-preemption — K1: A-band bipolaron-CDW/phase-sep at U_eff·N_A>1
- (6) novelty — framing-NOVEL, closure-novel ✓ (but it is a closed-negative, not a discovery)
→ **g5 NOT passed; route closed-negative. Not a room-T candidate.**

## DEPLETION TEST — does this lane deplete?
**YES — depleted by a demonstrated two-axis wall (a NEW closure axis), not a surviving candidate.** The
two-channel decouple removes the L9 same-band lock but reintroduces an **isomorphic interband-transfer
lock** (`V_AB_required > V_AB_max ∀ g_A`, Ω-free), confirmed empirically by real negative-U-center metals
(Tc≤4 K). All three killers fire (K0 transfer everywhere; K1/K3 at strong coupling). This is the **third
independent realization** of the campaign's master conservation (`|Δb|·t\*\*≈const` kinetic ·
super-linear-g↔instability bond-chemistry · now Franck-Condon transfer) — the strong glue and the carrier
mobility/transfer are inversely locked **regardless of whether they share a band**. The ambient room-T
conventional/bond-bipolaron space is closed on the same physics from a third angle.

### NEXT ROUND (named, with its depletion test)
**`pair-density-wave-assist` / `incipient-band-resonance`** — the ONE residual the two-band closures have
NOT directly tested: an **incipient (just-above/below-E_F) narrow band** (Kuroki/Yamaji flat-incipient-band
mechanism, arXiv:1711.00592) where the pairing enhancement comes from the **band-edge DOS singularity**
rather than a deep negative-U — so the glue is **NOT a self-trapped dressed pair** (evades the Franck-Condon
transfer lock K0/K2) and the carriers stay on the wide band. **Depletion test for that round**: does the
incipient-band Tc enhancement, at a 1-atm dynamically-stable metallic host, clear 293 K *without* the
band-edge being a CDW/nesting instability (the incipient band's own K1)? If the incipient enhancement is
also capped by the nesting/CDW that produces the band edge — as the lane's flat-band closures suggest — the
two-band escape closes completely (4th realization). If it genuinely evades the dressing lock, it is the
first surviving two-channel candidate → DFT host hunt. **Expected (adverse prior)**: closes on K1
(band-edge = nesting/CDW), but it is the one untested mechanism and worth the one round.

## RESIDUAL HONESTY (d6)
- The U_eff mapping uses an L=6 ED ring (over-binds; absolute |U_eff| is an upper bound — which makes the
  V_AA_req side **generous to the candidate**, strengthening the closure). The Franck-Condon form is the
  standard Lang-Firsov factor (a model, not a from-scratch DFT overlap), but its **sign and exponential**
  dependence on g_A are robust and isomorphic to the validated multiband-assist conservation.
- The Suhl-Kondo gap eq is BCS-linearized; the Tc magnitudes past Λ≳0.5 are not quantitative (hence the
  C·Ω ceiling cap). **The closure does NOT rest on a Tc number** — it rests on the Ω-free, coupling-strength
  `V_AB_req > V_AB_max` inequality and the b_weight≤0.016 (the condensate is not on the metallic band), both
  of which are structural, plus the empirical Tl:PbTe/In:SnTe ≤4 K anchor.
- No pod used; QE 7.5 confirmed live at `/home/summer/miniforge3/envs/qe/bin/pw.x` (summer-FREE) and is the
  resume target IF the next-round incipient-band candidate survives the model screen and needs a real-host DFT.
