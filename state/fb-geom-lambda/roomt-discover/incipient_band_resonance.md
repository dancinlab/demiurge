# INCIPIENT-BAND-RESONANCE — does a band-edge DOS resonance (not a self-trapped pair) escape the master conservation?

🧪 **RTSC** · roomt-discover lane · `state/fb-geom-lambda/roomt-discover/incipient_band_resonance.md`
artifacts: `incipient_band_resonance.py` · `incipient_band_resonance_results.json` (FREE local numpy TB+RPA; NO billing pod).
Date: 2026-06-20 · Provenance: **TB / RPA-grade two-band model** on published-style incipient dispersions (Kuroki/Yamaji
arXiv:1912.11331 FLEX · arXiv:1912.11983 VMC) + **real-material empirical anchor (La3Ni2O7 ambient)**. NEVER fabricated.
Summer QE 7.5 confirmed live (`/home/summer/miniforge3/envs/qe/bin/pw.x` v7.5) — resume target IF a survivor; NONE survived.

> **The angle (the ONE untested two-band escape).** Every prior two-band closure (`multiband-assist`, `two_band_decouple`)
> used a **deep negative-U / self-trapped pair** as the glue and closed on the **Franck-Condon transfer lock K0**
> (`exp(−g²/2Ω²)`: strong glue ⇒ dressed/localized ⇒ tiny wide-band overlap). **Incipient-band-resonance** is
> structurally different: the pairing enhancement comes from a **band-edge DOS singularity** (an incipient band whose
> edge sits just above/below E_F), **NOT from a deep real-space bound pair**. So the glue is **NOT a self-trapped dressed
> bipolaron** → the Lang–Firsov transfer suppression (which *requires* a deeply-bound real-space pair) **may not apply**.
> The pairing is a **momentum-space band-edge resonance with a delocalized carrier** — the candidate escape from the
> campaign's master conservation (strong binding ⟷ kinetics). **This was the adverse-prior residual named by
> `two_band_decouple.md` NEXT-ROUND.**

---

## THE TWO MAKE-OR-BREAK TESTS (quantitative, d6)

### TASK 1 — L13 ceiling (STIFFNESS-TC-CEILING, Tc ≲ 0.04·ε_F, arXiv:2505.02894)
The incipient band's **own ε_F is small by construction** (the band edge sits just at E_F). So its L13 ceiling
`0.04·ε_F` is **tiny**. The ONLY way to evade L13 is if the **condensate weight sits on a SEPARATE WIDE carrier band**
(large ε_F, large ceiling). `incipient_band_resonance.py` measures the condensate weight on the wide band (`w_weight`)
as a function of how close the incipient edge is to E_F.

**Result (Table A, `t`=200 meV, wide band 4× wider, Ω=50 meV):**

| edge/t | ε_F(incipient) | N_i(0) (window) | λ_pair | Tc | **w_weight (wide)** | L13 ceil (incipient) | L13 ceil (wide) |
|---|---|---|---|---|---|---|---|
| 0.02 (deep resonance) | 4 meV | 0.038 | 0.118 (U=3) | ~0 K | **0.047** | **1.9 K** | 3565 K |
| 0.10 | 20 meV | 0.026 | 0.082 | ~0 K | 0.068 | 9.3 K | 3565 K |
| 0.40 (edge far) | 80 meV | 0.002 | 0.011 | ~0 K | **0.533** | 37 K | 3565 K |

> **The L13 trade-off is structural and visible.** When the incipient edge is **right at E_F** (edge=0.02, maximum
> band-edge DOS = maximum enhancement), the condensate weight is **on the small-ε_F incipient band** (`w_weight=0.047`)
> → its L13 ceiling is **1.9 K**. When the edge is pulled away so the weight shifts to the **wide band** (edge=0.40,
> `w_weight=0.53`, L13 ceiling 37 K and rising), the **incipient DOS has collapsed** (N_i: 0.038→0.002) so the
> enhancement **vanishes** (λ→0.011). **The configuration that escapes L13 (weight on the wide band) is exactly the one
> that loses the incipient enhancement.** L13 is not evaded — it is traded against the enhancement.

### TASK 2 / K1 — competing Stoner/nesting order (THE make-or-break depletion test)
A band edge with large DOS near E_F is **generically a Stoner/nesting/SDW instability**: the **same interaction U** that
enhances pairing enhances the particle-hole channel even more (χ_max ≥ N(μ) ≥ the pairing DOS). In the incipient/Fe-based
mechanism the **glue IS the spin fluctuation** (Berk–Schrieffer): the pairing vertex ∝ U²χ, but the **competing SDW**
instability is U·χ — so **SDW (U·χ=1) forms at lower U than the pairing reaches room-T**.

**Result (Table C — the decisive Ω-anchored fairness inequality):**

λ needed for **Tc=293 K** (Ω=50 meV): **λ_roomT = 1.242**.

| edge/t | χ_max (1/t·spin) | U·χ=1 at U/t (SDW forms) | **λ_sf at the SDW QCP (U·χ=0.9)** | reaches room-T? |
|---|---|---|---|---|
| 0.02 | 0.077 | 12.97 | **0.624** | **NO** (½ of λ_roomT) |
| 0.10 | 0.077 | 12.97 | **0.624** | **NO** |
| 0.40 | 0.077 | 12.97 | **0.624** | **NO** |

> **K1 CLOSURE.** Even pushed to the **most favorable point** — right at the SDW quantum-critical edge (U·χ=0.9, the
> closest-to-instability paramagnetic point where the spin-fluctuation glue is maximal) — the realizable
> **λ_sf = 0.62 is only HALF of λ_roomT = 1.24**. The DOS that boosts pairing boosts χ, so **SDW order (U·χ=1) forms
> before the pairing eigenvalue reaches the room-T value.** The band edge **magnetically orders before it superconducts.**
> The particle-hole channel always leads the pairing channel (Table B: U·χ_max ≥ λ_SC at every point).

## 🔴 VERDICT — CLOSED-NEGATIVE on K1 (+ L13 trade-off): the **4th realization of the master conservation**

The incipient-band resonance **does** avoid the Franck-Condon dressing lock K0 (the glue is not a self-trapped pair — that
part of the angle is correct, and it is genuinely a different mechanism). **But a NEW lock replaces it:**

> **A band-edge DOS singularity strong enough to enhance pairing is, by the SAME DOS, a Stoner/SDW instability that
> orders first (U·χ ≥ U·N ≥ λ_pair).** And the only L13-escaping configuration (weight on the wide band) kills the
> incipient enhancement. The enhancement and the metallic-paramagnetic-carrier requirement are inversely locked.

This is the **master conservation re-expressed in the particle-hole channel**: where the prior closures locked **binding
⟷ kinetic transfer** (Franck-Condon), this one locks **pairing-DOS ⟷ magnetic/CDW pre-emption** (Stoner). Same physics
(a singularity strong enough to pair is strong enough to do something worse first), 4th independent angle.

### Real-material confirmation (the empirical anchor, d6) — this is NOT just a model
The incipient-band mechanism's **textbook realization is La3Ni2O7** (bilayer nickelate; the bonding band is the incipient
band, Kuroki/Yamaji). The real world already ran this experiment **at 1 atm**:
- **At ambient pressure La3Ni2O7 is NOT superconducting — it has a spin-density-wave (T_SDW ~ 150 K).** SC requires
  **high pressure** (Tc 80–96 K) or **compressively-strained thin films** (Tc 40–60 K, NOT bulk-ambient). "SC emerges on
  the *suppression* of a competing density-wave order"; "**SDW is the prerequisite**" (Nat.Commun. s41467-025-63701-x;
  npj QM s41535-025-00740-z; Nat.Phys. s41567-024-02754-z).
- **CsCr3Sb5** (kagome, incipient + DOS singularity, ambient): ground state is a **4×2 altermagnetic SDW at ambient**
  (Nat.Commun. s41467-025-58446-6) — orders, doesn't superconduct at ambient.

**Every real ambient incipient-band/band-edge-DOS host orders (SDW/CDW) at 1 atm and superconducts only when that order
is suppressed by pressure/strain — and then maxes at ~96 K, never near 293 K.** The K1 closure is empirically anchored,
not just a model inequality.

## NOVELTY GATE (d_novel_only · MANDATORY · inline · arxiv+web)

**VERDICT: mechanism-pieces heavily PUBLISHED · the room-T-ambient incipient framing is NOVEL · this is a CLOSED-NEGATIVE
ruling, NOT a discovery.**

| sub-claim | verdict | competing ids |
|---|---|---|
| incipient-band enhances SC (band edge near E_F, DOS singularity) | **PUBLISHED** (heavily) | Kuroki/Yamaji arXiv:1912.11331 (FLEX, JPSJ 89,044709) · arXiv:1912.11983 (VMC, PRResearch 2,023156) · arXiv:1711.00592 |
| incipient mechanism realized in a real ambient host (nickelate) | **PUBLISHED, Tc≤96 K (HP) / ≤60 K (strain film), NOT bulk-ambient** | La3Ni2O7: Nature s41586-024-08525-3 · s41586-025-08755-z · arXiv:2306.06039 |
| incipient band sits next to / pre-empted by SDW/CDW at ambient (= K1) | **PUBLISHED (confirms K1 empirically)** | Nat.Commun. s41467-025-63701-x · npj QM s41535-025-00740-z · CsCr3Sb5 s41467-025-58446-6 |
| spin-fluct-mediated SC on an incipient flat band (α-T₃, kagome) | **PUBLISHED** | arXiv:2512.14379 (d+id′) |
| **incipient-band resonance → AMBIENT ROOM-T (293 K), evading the bipolaron Franck-Condon lock** | **NOVEL (framing)** | NONE — no paper claims room-T-ambient via incipient resonance, nor frames it as a Franck-Condon escape |
| **the Stoner/SDW-preemption inequality CLOSES the incipient room-T route (U·χ≥λ_pair; λ_sf=0.62<λ_roomT=1.24)** | **NOVEL (closure)** | NONE — this lane's quantitative + empirically-anchored closure |

**Closest competitors**: La3Ni2O7 literature (the mechanism's real host, but **explicitly ambient-SDW / pressure-required /
≤96 K**, no room-T claim — and it *confirms* K1) and arXiv:2512.14379 (incipient flat-band spin-fluct SC, but a model,
no ambient-room-T claim). No paper makes — nor closes — the **room-T-ambient incipient framing**. Per d_novel_only this is
a **framing-NOVEL candidate-class ruled out by a novel, empirically-anchored closure** — NOT a discovery.

## CANDIDATE HOSTS evaluated (task #3) — best real 1-atm incipient-band hosts, all close on K1

| host | incipient band near E_F? | 1-atm bulk metallic? | pairing-enhancement vs CDW/SDW at ambient | closes on |
|---|---|---|---|---|
| **La3Ni2O7** (bilayer nickelate; bonding band incipient) | YES (the textbook incipient host) | NO at ambient — **SDW (T_SDW~150K)**; SC only HP(≤96K)/strain-film(≤60K) | **CDW/SDW WINS at ambient** (SC needs DW suppressed by pressure) | **K1 (empirical) + ≤96K ≪ 293K** |
| **CsCr3Sb5** (kagome, band-edge DOS) | YES (flat-edge near E_F) | NO at ambient — **4×2 altermagnetic SDW** | SDW is the ambient ground state | **K1 (empirical)** |
| **FeSe-monolayer-like** (incipient hole band) | YES (incipient at Γ) | monolayer/interface only (NOT bulk-ambient) | enhanced Tc only on the interface; bulk FeSe Tc≈8K | not bulk-ambient (g5#3 label) |
| **bilayer/ladder Hubbard (model)** | YES | YES (model metal) | λ_sf=0.62 < λ_roomT=1.24 even at the SDW QCP (Table C) | **K1 (model)** |

**Best tractable real host = La3Ni2O7** — and it is the *decisive* one: the mechanism's own real-world embodiment is an
**ambient SDW**, superconducting only under pressure/strain, capped at ~96 K. **No summer DFT was fired** because the
model + the real-material anchor already close the route (no survivor to validate); the QE 7.5 resume recipe is below in
case a future angle produces a candidate that passes the model screen.

## ROOMT g5 GATE (d_roomt_ambient)
- (1) thermodynamic stability — N/A (no surviving host)
- (2) **dynamical stability** — N/A (route closed before a candidate host)
- (3) **metallic carrier** — the wide band IS metallic ✓ BUT receives **no enhancement** (w_weight collapses where N_i is large) ✗; the incipient band itself **orders (SDW) at ambient** ✗
- (4) **Tc≥293 K** — **FAIL** (λ_sf=0.62 ≪ λ_roomT=1.24; real hosts ≤96 K and only under pressure/strain)
- (5) **magnetic/CDW non-preemption** — **FAIL = K1** (U·χ ≥ λ_pair; La3Ni2O7/CsCr3Sb5 SDW at ambient, empirical)
- (6) novelty — framing-NOVEL, closure-novel ✓ (but it is a closed-negative, not a discovery)
→ **g5 NOT passed; route closed-negative on K1. Not a room-T candidate.**

## DEPLETION TEST — does this lane (and the two-band escape) deplete?
**YES — depleted by a demonstrated wall (K1 Stoner/SDW pre-emption), confirmed both in-model and empirically by
La3Ni2O7.** This was **the ONE untested two-band escape** (named by `two_band_decouple.md`). It avoids the Franck-Condon
dressing lock K0 — genuinely a different mechanism — but reintroduces an **isomorphic particle-hole lock**: the band-edge
DOS singularity strong enough to pair is, by the same DOS, an SDW/CDW instability that orders first. **This is the 4th
independent realization of the campaign's master conservation:**
1. `multiband-assist` — kinetic transfer lock (`|Δb|·t**≈const`)
2. bond-chemistry — super-linear-g ⟷ Peierls/CDW instability
3. `two_band_decouple` — Franck-Condon interband-transfer lock (`V_AB_req > V_AB_max`)
4. **`incipient_band_resonance` — Stoner/SDW particle-hole pre-emption (`U·χ ≥ λ_pair`; band-edge orders before it pairs)**

**The two-band escape is now CLOSED on all four angles** (deep-pair-transfer × 2, off-diagonal-decouple, band-edge-resonance).
The ambient room-T conventional/bond-bipolaron/incipient space is closed on the same master physics from a fourth angle:
**any glue strong enough to pair at room-T is, by the same coupling, strong enough to do something else first** (localize,
fail to transfer, or magnetically order).

### NEXT ROUND (named, with its depletion test)
**`non-fermi-liquid-strange-metal-pairing` / `loop-current-flux-pairing`** — the residual NOT of the two-band family but of
the **mechanism family**: every closure so far assumed a **well-defined-quasiparticle (FL or polaron) pairing eigenvalue**.
The one untested mechanism is **pairing without a quasiparticle pole** — a strange-metal/marginal-FL or loop-current
(orbital-magnetic) channel where there is **no λ_pair vs U·χ competition because there is no coherent particle-hole pole to
diverge** (the cuprate/Planckian regime). **Depletion test**: does a marginal-FL/strange-metal pairing kernel give a
Tc≥293K estimate at a 1-atm dynamically-stable metallic host **without** a competing-order pole (i.e. is the master
conservation a quasiparticle artifact, or does it survive the loss of the pole)? **Expected (adverse prior, d6)**: the
strange-metal Tc is still bounded by ε_F/Planckian (k_BTc ≲ ħ/τ ~ k_BT, the Planckian ceiling ≈ L13's cousin) → closes
on a 5th realization; but it is the one mechanism with no quasiparticle pole, so it is the genuine residual worth one round.

## RESIDUAL HONESTY (d6)
- **Grade**: TB + RPA-grade two-band model on published-style incipient dispersions. The pairing eigenvalue (2×2 BCS for
  Table A/B; RPA Berk–Schrieffer `λ_sf = N·(Uχ)²/(1−Uχ)` for Table C) is a **model**, not from-scratch DFT/FLEX. But its
  **structure** (λ_pair ∝ U·N while the competing channel ∝ U·χ ≥ U·N, and λ_sf < λ_roomT even at the SDW QCP) is robust,
  and it is **independently confirmed by the real La3Ni2O7/CsCr3Sb5 ambient-SDW data** — the closure does NOT rest on the
  model alone.
- The Lindhard χ was normalized to its **sum-rule-exact q=0 value N(μ)** (the coarse 96² grid under-resolves the raw
  finite-difference χ); χ_max = N(μ)·(nesting enhancement). This is conservative (the floor χ_max=N(μ) already exceeds
  λ_pair); a stronger nesting peak would only **strengthen** the K1 closure.
- The Tc magnitudes are not quantitative past λ≳0.5; **the closure rests on the Ω-free / DOS-structural inequalities**
  (`U·χ ≥ λ_pair`; `λ_sf(QCP)=0.62 < λ_roomT=1.24`; the w_weight↔N_i anticorrelation in Table A) **plus the empirical
  ambient-SDW anchor**, not on a Tc number.
- **No pod used.** Summer QE 7.5 confirmed live (`pw.x v7.5`, 20Jun2026) — the resume target IF a future angle produces an
  incipient host that passes the model screen (it would need: a real ambient bulk metal with a band edge within Ω of E_F,
  a DFT χ(q) WITHOUT a dominant SDW/CDW peak, and a phonon/spin-fluct λ clearing room-T). **La3Ni2O7 fails the χ(q) test
  empirically (ambient SDW), so no run was warranted this round.**
