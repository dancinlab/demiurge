# NON-FERMI-LIQUID / STRANGE-METAL PAIRING — can pairing *without a quasiparticle pole* escape the master conservation?

🧪 **RTSC** · roomt-discover lane · `state/fb-geom-lambda/roomt-discover/non_fermi_liquid_pairing.md`
artifacts: `non_fermi_liquid_pairing.py` · `non_fermi_liquid_pairing_results.json` (FREE local numpy/scipy; NO billing pod).
Date: 2026-06-20 · Provenance: **γ-model (Abanov–Chubukov) upper-bound EVALUATION** of the published rigorous bound
(arXiv:2512.20009, Dec 2025) + Planckian/superfluid-stiffness estimate + **real-material empirical anchor** (the ambient
cuprate record HgBa₂Ca₂Cu₃O₈₊δ ~134–138 K). NEVER fabricated. Summer QE 7.5 confirmed live — but a band/DFT calc cannot
adjudicate a *Planckian-pairing* question (there is no quasiparticle to compute), so the decisive object is the kernel
bound, not a DFT number; no pod was warranted.

> **The angle (the ONE residual of a DIFFERENT family).** Every prior closure — L9 (same-band g↔Ω), L13
> (STIFFNESS-Tc-CEILING, Tc≲0.04 ε_F), L14 (two-band Franck-Condon transfer-lock), L15 (Stoner/SDW pre-emption) — assumed
> a **well-defined QUASIPARTICLE pairing eigenvalue λ_pair** competing against an instability (Uχ, CDW, Stoner). The
> untested mechanism is **PAIRING WITHOUT A QUASIPARTICLE POLE**: marginal-Fermi-liquid / strange-metal / SYK-Yukawa /
> Planckian pairing, where the self-energy is singular (Σ ~ ω^{1−γ/2}), there is **no coherent particle-hole pole to
> diverge into a competing order**, and there is **no ε_F-defined quasiparticle** for the L13 ceiling to bite. So the
> λ-vs-Uχ competition that closed L15, and the ε_F ceiling that closed L13, **may not exist**. This is the genuine
> residual: *is the master conservation a quasiparticle artifact, or does it survive the loss of the pole?*

---

## THE CANDIDATE MECHANISM (task #1, stated precisely)

The strange-metal / marginal-FL / SYK-Yukawa / loop-current pairing channels all reduce to **one** pairing kernel — the
**γ-model** (Abanov–Chubukov critical glue; Yukawa-SYK is its spatially-disordered realization, PRL **133**, 186502 /
arXiv:2406.07608):

    χ(Ω_m) ~ (g / |Ω_m|)^γ        (critical boson glue, NO Migdal cutoff, NO quasiparticle pole)

- **γ = 1** is the **marginal-FL / Planckian** point — linear-in-T resistivity, the cuprate strange metal.
- **γ = 1/2** ≈ AFM-QCP spin-fluctuation; **γ → 2** restores Migdal/FL.
- **loop-current (Varma)** pairing is the γ-model with the critical boson = the orbital-magnetic order parameter; same kernel.

Because Σ ~ ω^{1−γ/2} is singular, **there is no quasiparticle pole** and **no ε_F** — the L13 derivation (Tc ≲ 0.04 ε_F)
and the L15 λ-vs-Uχ pole competition **do not apply as derived**. The angle is *correct* that the prior locks are
quasiparticle constructions.

## TASK 1 — is the γ-model Tc UNBOUNDED (escape), or bounded by the only scale g (5th realization)?

A **rigorous upper bound** was proven last December (arXiv:2512.20009):

    τ_c = 2π Tc / g  ≤  τ_up(γ),     τ_up^γ = Σ_{n≥0} (1/2)^{2n} ζ(γ+2n+1)   (converges ∀ γ>0; → 4/3 as γ→∞)

| γ | τ_up | **Tc/g = τ_up/2π** | regime |
|---|---|---|---|
| 0.50 | 8.875 | 1.413 | AFM-QCP-ish strange |
| 0.75 | 3.076 | 0.490 | MFL-ish strange |
| **1.00** | **2.000** | **0.318** | **marginal-FL / Planckian** |
| 1.50 | 1.418 | 0.226 | FL-like (Migdal restoring) |
| 2.00 | 1.243 | 0.198 | FL-like |

> **Tc is bounded by a FIXED O(0.2–1) fraction of g — the *single microscopic energy scale* of the kernel.** There is no
> quasiparticle pole, but there is **still a ceiling**: Tc ≲ (τ_up/2π)·g. "No ε_F" does **not** mean "no ceiling" — it
> means the ceiling is set by the **critical-glue scale g** instead of ε_F. This is **L13's pole-free cousin**.

**Realistic-g test (γ=1).** Room-T needs k_B·293 K = 25.3 meV, so Tc=293 K at γ=1 requires only **g ≈ 79 meV**. Real
cuprate glue g ~ J ~ 130 meV gives a γ-model bound of **~480 K**. **So the bound PREFACTOR is LOOSE** — it does *not* by
itself forbid 293 K. The wall is **not** the bound prefactor; it is Tasks 2a + 2b + the empirical fact that the real
ambient record **saturates far below the prefactor**.

## TASK 2 — the decisive depletion test (why the loose prefactor still closes)

### 2a — PLANCKIAN / superfluid-stiffness cap (the pole-free L13)
In a strange metal the pairing glue **g** and the Planckian dissipation **ħ/τ = α k_B T** (α~1) share **one scale**. The
Yukawa-SYK solution (PRL 133,186502) finds **Tc monotonic in the linear-T resistivity slope** — *the same g that pairs
also dissipates*. So the condensate is **stiffness (phase-coherence) limited**, not pairing-limited: k_B Tc ≲ 0.9 ρ_s
(Uemura/BKT). The decisive trade:

    Tc ≲ 0.2 g          ← pairing wants LARGE critical glue g
    g large  ⇔  boson critical/soft  ⇔  AT the QCP of a competing order
    Tc ≲ 0.9 ρ_s        ← coherence wants LARGE stiffness = dense, light carriers = AWAY from the correlated QCP

The **g-maximizing point (the QCP)** is the **ρ_s-minimizing point** (strong correlation, dilute condensate). They are
inversely locked — the *same* inverse lock as L13, re-expressed without a pole.

### 2b — the strange metal is a PRECURSOR (competing order is REQUIRED, not optional)
The critical glue χ ~ (g/|Ω|)^γ **exists only because a boson is critical** — i.e. at the **QCP endpoint of an ordered
phase** (AFM / CDW / loop-current). The glue's very existence *requires* the nearby order. So the strange metal is
**intrinsically a precursor**: it is capped where that order sets in. This is **L15's claim recovered in the pole-free
language** — there is no sharp p-h *pole* to diverge, but the *order that produces the glue* is still there, and it caps Tc.

## 🔴 VERDICT — CLOSED-NEGATIVE: the **5th realization of the master conservation**

The pole-free strange-metal route **does** escape the *quasiparticle* ceilings as literally derived (no ε_F for L13, no
λ-vs-Uχ *pole* for L15 — the angle is genuinely correct on that point). **But it substitutes three pole-free caps that
reproduce the same physics:**

> **(i)** a rigorous γ-model **g-scale ceiling** Tc ≲ (τ_up/2π)·g (arXiv:2512.20009) — the only energy scale is the
> critical-glue g; **(ii)** a **stiffness trade** (2a): the g-maximizing QCP is the ρ_s-minimizing dilute-condensate point;
> **(iii)** a **precursor requirement** (2b): the glue exists only at the QCP of a competing order, which caps Tc where
> that order sets in.

**Honest caveat (d6).** The γ-model *prefactor* (Tc≲0.2g) is **loose** — at g~130 meV it permits ~480 K, so it does **not**
alone forbid 293 K. The closure does **not** rest on the prefactor number. It rests on **(2a)+(2b) + the empirical fact
that the actual ambient strange-metal record SATURATES at ~134–138 K, not at the ~480 K the prefactor would allow.** The
bound tells you the *scale is g*; the trade and the precursor tell you *g cannot be pushed* without the order it borders
pre-empting and the condensate de-stiffening. That gap (134 K realized vs 480 K permitted by the loose prefactor) **is**
the master conservation acting.

### THE KEY HONEST NOTE — why does the strange-metal record cap at ~134–138 K @ 1 atm?
**The highest REAL ambient Tc known — HgBa₂Ca₂Cu₃O₈₊δ, ~134–138 K — IS a strange metal** (its normal state is the textbook
linear-in-T Planckian metal). If the strange-metal route were unbounded it should already exceed 293 K. It does not. The
reason is exactly the 5th realization:
- **g cannot grow past J ~ 130 meV** without the **AFM/CDW/pseudogap order it borders** pre-empting (2b) — push the glue
  harder and you fall *into* the ordered dome, not a higher-Tc SC.
- the **dilute, strongly-correlated condensate keeps ρ_s low** (2a) — the Uemura line; cuprate Tc tracks ρ_s, and ρ_s is
  small precisely *because* you are near the correlated QCP that makes the glue.

**The ambient cuprate record is the master conservation's ceiling already realized at 1 atm: ~134 K, not 293 K.** No 1-atm
strange-metal route (cuprate, heavy-fermion CeCoIn5 ~2 K, magic-angle TBG ~1.7–3 K) exceeds it — and the two non-cuprate
strange metals are *far* lower, confirming that the cuprate value is near the structural ceiling, not a fluke low point.

## EMPIRICAL ANCHOR (d6) — the real highest-ambient-Tc strange metals

| host | Tc (K, ambient) | strange-metal? | competing order it borders |
|---|---|---|---|
| **HgBa₂Ca₂Cu₃O₈₊δ** | **134–138** (record) | YES (T-linear ρ) | pseudogap / CDW dome below |
| Tl₂Ba₂Ca₂Cu₃O₁₀ | 125–128 | YES | pseudogap / CDW |
| Bi₂Sr₂Ca₂Cu₃O₁₀ | ~110 | YES | pseudogap / CDW |
| optimally-doped YBCO | 92–93 | YES (ρ linear → 600 K) | pseudogap / CDW |
| CeCoIn₅ (heavy-fermion QCP) | ~2.3 | YES (Planckian) | AFM QCP |
| magic-angle TBG | ~1.7–3 | YES | correlated insulator / IVC |

**Best tractable real host = the cuprate strange metal (HgBaCaCuO).** It is the *decisive* one: the highest-Tc embodiment
of the mechanism, at 1 atm, **already saturates at ~134–138 K** — and it *is* a strange metal, so this is the route's own
record, not an outside comparison. No DFT was fired (a band calc cannot compute a pole-free Tc; the γ-model bound + the
empirical record close it).

## NOVELTY GATE (d_novel_only · MANDATORY · inline · arxiv+web)

**VERDICT: mechanism-pieces heavily PUBLISHED · the "room-T-ambient via strange-metal/marginal-FL, framed as a 5th
realization of a master conservation" is NOVEL · this is a CLOSED-NEGATIVE ruling, NOT a discovery.**

| sub-claim | verdict | competing ids |
|---|---|---|
| γ-model is the strange-metal/MFL/SYK-Yukawa pairing kernel (no quasiparticle pole) | **PUBLISHED** | Abanov–Chubukov γ-model; Yukawa-SYK PRL **133**,186502 / arXiv:2406.07608 |
| rigorous γ-model **upper bound** Tc ≤ (τ_up/2π) g | **PUBLISHED (the bound we use)** | arXiv:2512.20009 (Dec 2025); earlier Kiessling et al. |
| Tc monotonic in linear-T resistivity slope (pairing↔dissipation share g) | **PUBLISHED** | Yukawa-SYK PRL **133**,186502 |
| strange metal is a precursor above a pseudogap/CDW dome (cap ~100 K) | **PUBLISHED** | cuprate phase-diagram literature; arXiv:2511.07726 (Hubbard pseudogap+strange metal) |
| loop-current (Varma) pairing in the same channel | **PUBLISHED** | PhysRevResearch 3,013127; PMC11177937 ("SC due to fluctuating loop currents") |
| **strange-metal/marginal-FL → AMBIENT ROOM-T (293 K), as a pole-free escape of the quasiparticle ceiling** | **NOVEL (framing)** | NONE — no paper claims room-T-ambient via a pole-free strange-metal kernel |
| **the γ-g-ceiling + stiffness-trade + precursor CLOSE the pole-free room-T route as the 5th realization of one master conservation** | **NOVEL (closure)** | NONE — this lane's synthesis (pole-free cap maps onto L13/L15) is the campaign's own |

**Closest competitors**: arXiv:2512.20009 (proves the γ-model Tc bound, but does not connect it to a room-T-ambient
closure nor to a quasiparticle-vs-pole-free master law) and the Yukawa-SYK PRL (pairing↔dissipation monotonicity, but no
room-T claim). **No paper makes — nor closes — the room-T-ambient strange-metal framing.** Per d_novel_only this is a
**framing-NOVEL candidate-class ruled out by a novel, literature-anchored closure** — NOT a discovery.

## ROOMT g5 GATE (d_roomt_ambient)
- (1) thermodynamic stability — N/A (no surviving host; route closed on the kernel)
- (2) dynamical stability — N/A (route closed before a candidate host)
- (3) **metallic carrier** — the strange metal IS metallic ✓ BUT (a) its glue g caps Tc via the γ-bound and (b) the
  dilute correlated condensate caps ρ_s ✗
- (4) **Tc ≥ 293 K** — **FAIL** (real ambient strange-metal record 134–138 K; γ-bound scale is g, and g cannot be pushed
  past the precursor/stiffness trade)
- (5) **magnetic/CDW non-preemption** — **FAIL = 2b** (the glue *requires* the bordering AFM/CDW/loop-current order; pole-free
  recovery of L15)
- (6) novelty — framing-NOVEL, closure-novel ✓ (but it is a closed-negative, not a discovery)
→ **g5 NOT passed; route closed-negative. Not a room-T candidate.**

## DEPLETION TEST — does the MECHANISM family deplete?
**YES — depleted.** This was the ONE residual of a *different family* (pole-free pairing) after the two-band family closed
on four angles. It is genuinely the only mechanism with **no quasiparticle pole**, so it deserved a round. The result: the
master conservation **is NOT a quasiparticle artifact** — it survives the loss of the pole, re-expressed as the γ-model
**g-scale ceiling + stiffness trade + precursor requirement**. **This is the 5th independent realization:**

1. `multiband-assist` — kinetic transfer lock (`|Δb|·t*≈const`)
2. bond-chemistry — super-linear-g ⟷ Peierls/CDW instability
3. `two_band_decouple` — Franck-Condon interband-transfer lock (`V_AB_req > V_AB_max`)
4. `incipient_band_resonance` — Stoner/SDW particle-hole pre-emption (`U·χ ≥ λ_pair`)
5. **`non_fermi_liquid_pairing` — γ-model g-scale ceiling + stiffness trade + precursor (POLE-FREE: Tc ≲ 0.2 g, glue
   exists only at a competing-order QCP)**

> **Master conservation, now a near-complete meta-theorem (honest assessment):** *any glue strong enough to pair at
> room-T at 1 atm is, by the same coupling, strong enough to do something else first* — **localize** (Franck-Condon, L14),
> **fail to transfer** (kinetic lock, L9/multiband), **magnetically/charge order** (Stoner/SDW/CDW pre-emption, L15/incipient),
> or — **even with no quasiparticle pole** — be **bounded by its own critical-glue scale g while requiring the very order
> whose QCP makes it** (this lane). The quasiparticle *and* non-quasiparticle branches both close on the same physics.
> **Assessment: the conventional + bond-bipolaron + strange-metal ambient room-T space is now closed on FIVE independent
> angles spanning BOTH the quasiparticle and pole-free regimes.** The remaining logical escapes are not new *mechanisms*
> but qualitatively different *substrates* (see NEXT ROUND) — the mechanism-family axis is depleted.

### NEXT ROUND (named, with its depletion test)
The mechanism family is closed; the residuals are now **substrate/topology** classes, not pairing kernels:
1. **`flat-band-quantum-geometry-stiffness`** — the ONE place the stiffness trade (2a) is structurally evaded: in an
   *isolated flat band* the superfluid stiffness comes from the **quantum metric** (Peotta–Törmä, ρ_s ∝ ∫ g_quantum),
   NOT from band kinetics — so ρ_s need *not* collapse with the glue. **Depletion test**: does a real 1-atm flat-band host
   give ρ_s(quantum-metric) AND λ both ≥ room-T *simultaneously*, or does the campaign's own **Welch bound** (Q_geom ≥
   1/N_band, MASTER_CLOSING_FORMULA §2) cap the quantum metric so the stiffness escape closes too? (adverse prior: the
   fb-geom lane already found Q_geom pinned near the 1/N floor → likely a 6th realization, but it is the one *substrate*
   that targets cap 2a directly).
2. **`topological-surface-flat-band-replica` (rhombohedral graphite / Bernal)** — a 1-atm carbon flat band with NO heavy
   correlations; tests whether removing the correlated-QCP precursor (2b) by using a *non-interacting* flat band escapes,
   or whether the flatness itself reintroduces the geometry cap.

## RESIDUAL HONESTY (d6)
- **Grade**: γ-model upper-bound **evaluation** of a *published rigorous bound* (arXiv:2512.20009) + a Planckian/stiffness
  *estimate* + an *empirical* ambient-record anchor. NOT from-scratch Eliashberg/QMC. The Tc *magnitudes* from the
  prefactor are loose (the bound permits ~480 K at g~130 meV); **the closure does NOT rest on the prefactor number** — it
  rests on the three-leg synthesis (g-scale ceiling + stiffness trade + precursor) **plus the empirical saturation of the
  real ambient record at ~134–138 K, far below the loose prefactor.**
- **Honest tension stated**: a critic could say "the γ-bound alone permits 293 K, so you have not *proven* a wall." Correct
  — the wall is not the prefactor; it is that the only known way to push g (go to the QCP) **lowers ρ_s and invites the
  bordering order**, and **the empirical record confirms the net effect caps at ~134 K, not ~480 K.** The closure is
  empirically-anchored + structural, not a single inequality. This is recorded as a closed-negative ruling, not a theorem.
- **No pod used.** A DFT/band calc cannot compute a pole-free Tc (there is no quasiparticle to put on a k-grid); the
  decisive objects are the kernel bound and the empirical record. Summer QE 7.5 remains the resume target only if a future
  *substrate* lane (flat-band quantum-geometry) produces a candidate host that passes a model screen.
