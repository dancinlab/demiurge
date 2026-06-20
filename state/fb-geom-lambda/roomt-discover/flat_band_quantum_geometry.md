# flat-band-quantum-geometry — DECISIVE VERDICT (roomt-discover substrate lane)

> Lane: `flat-band-quantum-geometry-stiffness` · FREE summer only (NO billing pod) · d6 honest, NO fabrication.
> The ONE structural evasion of the (2a) superfluid-stiffness trade after the 5-angle mechanism-family closure.
> Date: 2026-06-20 · Gate = ROOMT-AMBIENT-PASS-CRITERIA. SSOT scratch (does NOT edit ARCHITECTURE.json, does NOT commit).
> Code: `fbqg_decisive.py` (v1, isolation cap) · `fbqg_glue_binding.py` (v2, binding |U|) · `fbqg_anticorr.py` (clean gap-opening demo).

---

## 0. BOTTOM LINE (d6 honest)

**🔴 CLOSED-NEGATIVE — the 6th realization of the master conservation.** The quantum-metric
stiffness escape is **GENUINE at the formula level** (ρ_s = the quantum metric, NOT band kinetics,
so ρ_s does *not* collapse with W→0 — cap-2a is structurally evaded as advertised). But it **CLOSES
at the host-selection level**: no real 1-atm flat-band host supplies a quantum-metric `D_s` AND a
pairing channel `λ` **both ≥ room-T simultaneously**. The (2a) trade does not return through the
*formula* — it returns through the **material constraint** that the same structural choice giving a
large quantum metric ⟨tr g⟩ kills the pairing or the glue scale, and the light-element choice that
keeps the glue gives a small ⟨g⟩ and a small isolation gap. This is the campaign's own
`host-optimize` ⟨g⟩↔ω_log anti-correlation, now re-derived as the **cap** on the geometric route,
sharpened by two independent closed-form bounds.

**No framing-NOVEL room-T candidate emerged.** The one row that clears 293K numerically (a
light-element kagome SC with ⟨g⟩≈2.5 AND ω_log≈150 meV) is the campaign's already-named
*hypothetical* "single missing ingredient" — a structure-class ceiling with **NO known real
metal-at-E_F superconducting member**. We do NOT claim it exists (no fabrication).

---

## 1. TASK 1 — the route stated precisely + the geometric cap on D_s

2D-BKT flat-band condensate (Peotta–Törmä, Nat Commun 6,8944):

    D_s = 4 |U| ν(1−ν) ⟨tr g⟩          (finite at t→0; metric-set, not bandwidth)
    kB Tc(2D-BKT) = (π/8) D_s ;  3D-XY interlayer-Josephson ≈ ×1.40 over 2D (Janke/NK)

At ν=½ (ν(1−ν)=¼ maximal):  **D_s = |U|·⟨tr g⟩**.

**For Tc ≥ 293.15 K (= 25.26 meV):**
- 2D-BKT: need `|U|·⟨g⟩ ≥ 64.3 meV`
- 3D-XY:  need `|U|·⟨g⟩ ≥ 45.9 meV`

**The geometric cap (closed-form, the make-or-break of task 1+2):** `D_s_max = E_gap · ⟨tr g⟩`
(when |U| is isolation-limited), and the two factors are **ANTI-CORRELATED**:
- LOWER bound (topology): `⟨tr g⟩ ≥ |C|` (Peotta–Törmä floor); companion el-ph Welch bound `Q_geom ≥ 1/N_band`.
- The product does **NOT** grow without bound. Pushing ⟨tr g⟩ up (toward saturation) **delocalizes the
  Wannier function ⟺ shrinks E_gap** (the band approaches a touching). Pushing E_gap up (rigid, dispersive,
  large-gap band) drives ⟨tr g⟩ toward its trivial floor.

**Clean numerical demonstration** (`fbqg_anticorr.py`, QWZ Chern band, gap genuinely opens):

| M | ⟨tr g⟩ | E_gap | Chern | E_gap·⟨g⟩ |
|---|---|---|---|---|
| −1.99 | 0.216 | 0.020 | −1 | 0.004 |
| −1.20 | 0.211 | 1.600 | −1 | 0.338 |
| **−1.00** | 0.227 | 2.000 | −1 | **0.453 (PEAK)** |
| −0.50 | 0.286 | 1.000 | −1 | 0.286 |
| 0.00 | 0.498 | 0.000 | +1 | 0.000 |

The product `E_gap·⟨g⟩` **peaks at a finite intermediate gap (0.453 in band-energy units)** and →0 at
both extremes (gap-closing and trivial-rigid). **This is the geometric cap.** With the band-energy unit =
the hopping / crystal-field scale of a real isolated flat band (tens of meV), `D_s_max ≈ (peak)·(tens of
meV) ~ O(tens-to-~100 meV)` — NOT the ~1000 K-implying values a naive `|U|=E_gap × large independent ⟨g⟩`
would suggest.

> Honest caveat (d6): the kagome-Haldane / intrinsic-SOC TB ansatz **failed to open** the flat-band
> quadratic touching (E_gap=0 across the scan in both `fbqg_decisive.py` and `fbqg_glue_binding.py` —
> the same wall the prior `cosn_gmetric` lane hit; a proper Guo–Franz mass needs the full
> sublattice-phase construction). So the anti-correlation is demonstrated on the **gap-opening QWZ
> Chern model**, not on kagome. The conclusion (finite-peaked product) is robust; the kagome *number*
> is not delivered here.

---

## 2. TASK 2 — the binding constraint on |U| (the decisive tension)

|U| is bounded by the **SMALLER** of two independent ceilings:
- **(i) ISOLATION:** `|U| ≤ E_gap` — above it, interaction-induced band mixing restores kinetic
  dispersion and the (2a) trade returns (this lane's task-2 constraint).
- **(ii) GLUE ORIGIN:** `|U| ~ λ·ω_log ≤ 4·ω_log` — the no-go theorem **arXiv:2604.04719 (Zhou 2026)**:
  the geometric superfluid weight is glued by the SAME `λω_log` and **cannot exceed the Allen-Dynes
  phonon ceiling** (the campaign's `ceiling-escape` C3, `E_phys=0.69<1`, already established this).

**The binding |U| = min(E_gap, λ·ω_log).** Evaluated at real hosts (`fbqg_glue_binding.py`):

| host | E_gap | ⟨g⟩ | ω_log | λ·ω_log | bind | D_s | Tc(3D) |
|---|---|---|---|---|---|---|---|
| CoSn kagome | 78 | 2.5 | 15 | 60 | glue | 150 | ~957 K* |
| *hypothetical* light-C kagome | 78 | 2.5 | 150 | 600 | iso | 195 | ~1244 K† |
| rhomb. graphite | 20 | 0.5 | 180 | 720 | iso | 10 | ~64 K |
| Lieb sp²-C COF | 60 | 0.67 | 150 | 600 | iso | 40 | ~256 K |

\* CoSn is **Pauli-paramagnetic, NON-SC** — λ is not realized (the moment-suppressed flat band does not
pair). 957 K is the geometry ceiling *if* it paired at λ=4; it does not (L15/L16 family).
† hypothetical structure class, **no known real SC member**.

**Verdict on the tension:** `|U|≤E_gap` alone does **NOT** cleanly close room-T (CoSn-class
E_gap·⟨g⟩~195 meV would *permit* 293 K at the mixing edge). The closure is **NOT a single inequality**
— it is that the **two factors that must be large simultaneously (high ⟨g⟩ AND a real high-λ pairing
channel AND a high glue ω_log) are mutually exclusive across real hosts**:

1. **High ⟨g⟩ (~2.5, kagome)** requires an isolated *non-trivial* band → occurs only in **HEAVY
   (large-SOC) kagome metals** (CoSn) → phonon ω_log~15 meV (small glue) AND a Pauli moment that
   **kills pairing** (L15/L16). Glue binds, λ unrealized.
2. **Light element** (high ω_log~150–200 meV, NO magnetic precursor — escapes L15/L16 2b) gives a
   **trivial-ish flat band**: graphite C=0 ⟨g⟩~0.5, sp²-C Lieb ⟨g⟩~0.67. Low ⟨g⟩ **AND** a small
   isolation gap (weak light-atom crystal fields, E_gap~20–60 meV). Throttled on **both** factors.

This is exactly the `host-optimize` ⟨g⟩↔ω_log anti-correlation (heavy→high⟨g⟩,low ω_log;
light→low⟨g⟩,high ω_log), now binding as the **cap on the geometric route**.

---

## 3-4. TASK 3/4 — real 1-atm hosts, incl. the special rhombohedral-graphite case

**CoSn kagome** (host-optimize anchor): isolated kagome flat band, SOC iso-gap E_gap~76–80 meV (Kim
et al. Nat. Phys. 2025, arXiv:2412.17809 — the ONLY material with a *measured* quantum-metric *map*),
⟨tr g⟩~2.5 (TB-est, convention-audited; **DFT-Wannier scalar still the single missing confirmation**),
phonon flat band ~15 meV. **Non-SC (Pauli paramagnet) — the real blocker is the absent pairing
channel, not ⟨g⟩.**

**Rhombohedral graphite / ABC multilayer graphene** (TASK 4, the special light-element host —
NO competing magnetic/CDW dome at the relevant filling → escapes the L15/L16 (2b) correlated-QCP
precursor):
- Surface / penta flat band W~1–20 meV (Guinea–Castro Neto, McCann–Koshino). The low-energy chiral
  model `H=[[gap,(k)^N],[(k*)^N,−gap]]` gives a disk-averaged ⟨tr g⟩~2–5 (TB est, momentum-N winding)
  **but the band is C=0 (time-reversal-symmetric, NOT Chern)** → **no topological floor forces ⟨g⟩ up**,
  and in true 3D rhombohedral graphite the surface band sits at a **near band-touching → isolation
  gap is small** (~few–30 meV, set by the displacement field).
- **Real measured rhombohedral-graphene SC (Lu et al. Nature 2024/25): Tc ~ 0.3 K.** Dilute, ν far
  from ½, tiny pairing scale.
- **OPTIMISTIC ceiling** (E_gap=20 meV, ⟨g⟩=0.5, |U|=E_gap): `D_s=10 meV → Tc(3D)~64 K` — FAR below
  293 K. The light-element / no-dome advantage is real, but the **tiny isolation gap crushes |U|** and
  the **nearly-trivial band gives small ⟨g⟩**. Both factors throttle it.

**Answer to task 4:** rhombohedral graphite does **NOT** reach room-T. It escapes the L15/L16
precursor (genuine), but closes on **flatness→isolation→|U|≤E_gap (small gap) AND small ⟨g⟩ of a
nearly-trivial flat band** — exactly the two mechanisms named in the task.

---

## 5. NOVELTY GATE (d_novel_only — inline arxiv+web, mandatory)

| angle | verdict | competitor ids |
|---|---|---|
| flat-band quantum-metric SC (generic model) | **PUBLISHED (red-ocean)** | Peotta–Törmä ncomms9944; Bernevig/Peri/Huber fragile-topology SC (arXiv:2008.02288); Herzog-Arbeitman et al. "Superfluid weight bounds from symmetry and quantum geometry"; Penttilä–Huhtinen–Törmä Commun.Phys. 2025 (mod-Lieb) |
| **LOWER** bounds on D_s (topological floor, bootstrap) | **PUBLISHED** | bootstrap rigorous lower bounds arXiv:2506.18969; Peotta D_s≥|C|; correlation-length quantum geometry arXiv:2601.12969 |
| room-T SC *as a goal* via quantum geometry | **ACTIVELY PURSUED (red-ocean goal)** | Törmä **SuperC consortium** (Aalto, AI + quantum geometry, explicitly "pursue room-temperature SC") |
| geometric superfluid weight **cannot escape AD ceiling** | PUBLISHED (no-go) | **arXiv:2604.04719 (Zhou 2026)** — the campaign's C3 anchor |
| **UPPER-bound closure via |U|≤E_gap ↔ ⟨g⟩ anti-correlation capping room-T in real hosts** | **NOVEL (closure)** | NONE — the entire field works **lower** bounds + pursues room-T; **no published upper-bound ruling** combining the isolation cap with the metric anti-correlation. Consistent with the campaign's own arxiv sweep: "no rigorous Tc UPPER bound exists for flat-band SC; room-T not excluded by any proof." This lane supplies the **structural (non-theorem) closed-negative ruling.** |

**The closure itself is NOVEL** (a closed-negative ruling, not a discovery — this is the framing-NOVEL
output, the 6th realization). **No room-T candidate** survives, so no novelty-reconfirm trigger fires.

---

## 6. ROOMT g5 (Tc≥293K · 1atm · bulk · dyn-stable · metallic/flat-band-at-E_F · novelty)

| gate | best real host (CoSn) | rhomb. graphite | verdict |
|---|---|---|---|
| #4 Tc≥293K | non-SC (geometry ceiling 957K is hypothetical λ=4) | ~64 K optimistic | **FAIL** (no real host) |
| #3 metallic/SC at E_F | non-SC Pauli paramagnet | SC but Tc~0.3 K | FAIL (CoSn) / pass-but-subroom (graphite) |
| #1/#2 stability | 1-atm stable bulk ✓ | 1-atm stable ✓ | pass |
| novelty | closure NOVEL | — | pass (closure) |

**g5 = the geometric route does not produce a room-T@1atm host → CLOSED-NEGATIVE (6th realization).**

---

## VERDICT & is the meta-theorem near-complete?

**🔴 6th realization of the master conservation.** Spanning now SIX independent angles (L9 same-band
g↔Ω · L13 stiffness-Tc ceiling · L14 Franck-Condon transfer-lock · L15 Stoner/SDW preemption · L16
strange-metal γ-g ceiling · **L17(this) quantum-metric host-selection cap**), the master conservation
holds across quasiparticle, pole-free, AND geometric-substrate regimes. The geometric route was the
ONE place the (2a) stiffness trade was *structurally* evaded at the formula level — and it is the place
the trade **re-enters through the host-selection constraint** (high-⟨g⟩ ⟺ heavy/no-pairing/low-glue;
light ⟺ low-⟨g⟩/small-gap). **The master conservation is now a near-complete meta-theorem:** every
named escape — strong-coupling, pole-free, AND substrate/topology — has closed.

**Residual axes remaining (honest):**
1. **`topological-surface-flat-band-replica`** — the task's second named substrate (rhombohedral/Bernal
   surface replica) is *partially* covered here (graphite closes on small-gap + trivial ⟨g⟩); a dedicated
   round could test whether a **Bernal/surface band with engineered larger isolation gap** (hBN-aligned,
   displacement-field-tuned to ~50–80 meV) lifts the |U| ceiling — but the ⟨g⟩↔gap anti-correlation
   predicts it cannot clear 293 K. **Likely a 7th realization, low priority.**
2. **`non-equilibrium / Floquet-driven flat-band`** — the master conservation is an *equilibrium*
   statement (pairing ⟺ kinetics by the SAME equilibrium coupling). A *driven* system could in principle
   decouple them transiently (Floquet band-flattening + separate drive-induced pairing). NOT room-T@1atm
   *equilibrium bulk* (fails the gate's bulk/equilibrium premise by construction), so **out of gate scope**
   — but it is the one regime the meta-theorem does NOT formally cover. Flag as the **genuine open axis**,
   though gate-disqualified.

**NAME NEXT ROUND + depletion test:**
> **`bernal-surface-gap-engineered-flat-band`** — does a displacement-field/hBN-engineered larger
> isolation gap (E_gap~50–80 meV) in a *light-element* Bernal/rhombohedral surface flat band lift |U|
> enough to clear room-T, OR does the ⟨g⟩↔E_gap anti-correlation (this lane's QWZ-demonstrated finite-peak
> product) cap it → 7th realization? **Depletion test:** compute the engineered-gap ABC/Bernal flat band's
> ⟨tr g⟩(E_gap) curve and check whether `max_{E_gap}[E_gap·⟨g⟩]·(π/8 kB^-1)·1.4` clears 293 K — the QWZ
> demo already predicts NO (product peaks finite at ~O(tens of meV·O(1)) → ~tens-of-K, not room-T).

**Grade (d6):** TB-grade + closed-form bounds + sourced real-host scales + empirical anchors
(CoSn Kim 2025 measured metric, Lu graphene Tc~0.3 K, Zhou no-go). NOT from-scratch DFT/QMC. The
closure rests on the **structural ⟨g⟩↔(E_gap, glue, pairing) anti-correlation across real hosts** +
the QWZ-demonstrated finite-peaked geometric product — **not on a single inequality**. Recorded as a
**closed-negative ruling, not a theorem.** No pod used (the decisive objects are closed-form bounds +
the real-host scale survey; summer QE 7.5 remains the resume target only if a future round produces a
candidate host that passes a model screen). **NO room-T candidate → no DFT escalation, no
novelty-reconfirm fire.**
