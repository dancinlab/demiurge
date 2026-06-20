# PRESS-ALL-SUMRULE — the campaign's deepest synthesis: is the master conservation ONE sum rule, or SEPARABLE trade-offs?

🧪 **RTSC** · roomt-discover META/SYNTHESIS lane · `state/fb-geom-lambda/roomt-discover/press_all_sumrule.md`
Date: 2026-06-20 · FREE summer/local only (NO billing pod) · d6 honest · NEVER fabricate · TB/analytic-grade.
artifacts: `press_all_sumrule.py` (joint scan A vs B) · `press_all_analytic.py` (clean identity) · `press_all_strong.py` (honest strong-binding optimum) · `press_all_feasible.py` (feasibility map + host translation).
Upstream SSOT: `MASTER_CLOSING_FORMULA.md` · `RTSC_DISCOVERY_CLOSING_FORMULA.md` · the four face-closures `two_band_decouple.md` (L14) · `metallic_hbond_ssh.md` (L13) · `incipient_band_resonance.md` (L15) · multiband-assist (L9).

> **The user's insight ("모두 누르면" — press ALL the relief valves at once).** Each prior closure
> routed the *pressure* of strong binding into a DIFFERENT relief channel: L9 (same-band g↔Ω
> anticorrelation), L13 (Tc≲0.04ε_F stiffness ceiling), L14 (Franck-Condon self-trapping transfer
> lock), L15 (Stoner/SDW pre-emption). The balloon: press one side, another bulges. **The decisive
> question: is the master conservation ONE conserved quantity (a stiffness SUM RULE / no-go), or a
> set of SEPARABLE pairwise trade-offs with a feasible interior point = the room-T candidate?**

---

## BOTTOM LINE (d6 honest) — 🟡 SEPARABLE, with a NARROW feasible seam — NOT a clean no-go

**The four faces are NOT one rigid sum rule that forbids ambient room-T. They are SEPARABLE
multiplicative trade-offs on a common superfluid stiffness `D_s`, and the joint feasible region
(Tc ≥ 293 K @ 1 atm) is NON-EMPTY — but the entire feasible region collapses onto ONE seam: the
ANTI-ADIABATIC light-bond corner `Ω ≳ t`.** This is not a new escape — it is the campaign's own
Regime-II (`RTSC_DISCOVERY_CLOSING_FORMULA.md`), now *derived* as the unique survivor of the
four-channel optimization, with explicit coordinates and the binding wall on each side named.

Honest framing: the result is a **conditional feasibility theorem**, not a clean ≥293K material:
- **the no-go form FAILS** — pressing all channels does leave a feasible region (so the campaign does
  NOT close with a clean "ambient room-T forbidden" meta-theorem);
- **but the feasible region is a thin seam** (`Ω ≳ t`, `W0 ≳ 2 eV`, `g/t ≈ 0.6–0.9`, paramagnetic),
  reachable ONLY by light elements (H/B/C/N phonons ~150–400 meV) on a narrow-but-not-tiny carrier
  band (`t ≈ 100–200 meV`). No EXISTING real material is confirmed to sit in it.

---

## TASK 1 — the four faces on a COMMON variable, and the candidate single functional `D_s`

Common variables: carrier hopping `t`, off-diagonal coupling `g/t`, bond phonon `Ω`, Fermi energy
`ε_F`, paired fraction / pair size `ξ_pair`, Stoner factor `Uχ`, and the candidate conserved quantity
the **superfluid stiffness** `D_s` (superfluid weight). The link to Tc is the stiffness law:

    kB·Tc = (π/2)·D_s      (2D-BKT, Nelson–Kosterlitz universal jump)
    kB·Tc ≈ 2.2·D_s        (3D-XY; use as the generous upper case)

**Each face is an inequality on a SEPARATE multiplicative factor of `D_s` — they are NOT the same
inequality:**

| face | law name | inequality (common variables) | what it caps |
|---|---|---|---|
| **L9**  | STIFF-BOND-WEAK-SSH-BINDING | `g·Ω ≤ B9` (soft bond⇒big g, small Ω; stiff⇒small g) | the binding *budget* feeding D_s |
| **L13** | STIFFNESS-TC-CEILING | `D_s ≤ α13·ε_F`, α13 = 0.04/(π/2) = 0.0255 | the stiffness *ceiling* from carrier ε_F |
| **L14** | FRANCK-CONDON TRANSFER-LOCK | `D_s_eff = D_s·Z_FC`, `Z_FC = exp(−g²/2Ω²)` | the dressing/transfer *survival factor* |
| **L15** | STONER/SDW PRE-EMPTION | `D_s_avail = D_s·(1−Uχ)`, order at `Uχ=1` | the paramagnetic *availability* |

**These do NOT collapse to one sum rule.** A true single conserved quantity (e.g. an
optical-spectral-weight / FGT f-sum rule) would give ONE bound `D_s ≤ D_s^total` that all four merely
re-express. Here L13 bounds D_s *from above by ε_F*, while L14 and L15 are *multiplicative attenuations*
of whatever D_s the binding produces, and L9 bounds the *binding input*. They are **algebraically
independent factors of a product**, not projections of one conserved scalar:

    kB·Tc ≤ (π/2)·[α13·ε_F^dressed(g,Ω)] · Z_FC(g,Ω) · (1−Uχ) · f_pair(g)

This is the synthesis functional. It is a **product of independently-bounded factors** — the hallmark
of SEPARABLE trade-offs, not a sum rule. **So the answer to the decisive test is: SEPARABLE.**

The ONE place they couple is through `ε_F^dressed`: the same `(g,Ω)` that the binding wants large
also *narrows* the dressed carrier band (polaron narrowing `ε_F^dressed = ½W0·exp(−g²/Ω²)`), which is
the L9↔L13 lock seen empirically in κ-H3. This coupling is what makes the optimization non-trivial —
but it is a *shared variable*, not a *shared conserved quantity*. (Scan A treats ε_F as a free wide
band; scan B imposes the L9 narrowing coupling. **Both give the same max Tc** — the coupling does not
change the answer, confirming the faces are genuinely separable, `press_all_sumrule.py`.)

---

## TASK 2 — Tc_max under all constraints simultaneously: is the interior point ≥293K?

**The clean identity (`press_all_analytic.py`).** The two `(g,Ω)`-dependent factors combine:

    ε_F^dressed · Z_FC = ½·W0 · exp(−g²/Ω²) · exp(−g²/2Ω²) = ½·W0 · exp(−1.5·(g/t)²/(Ω/t)²)

This is **monotone decreasing in `g/t` and monotone increasing in `Ω/t`**. The entire four-channel
optimization reduces to ONE dimensionless ratio `Ω/t` (the adiabaticity) traded against the binding
requirement `g/t`. The feasibility condition for Tc = 293 K (3D, generous, paramagnetic Uχ=0, at honest
binding `g/t = 0.68` where paired fraction `f_pair ≈ 0.63`):

| `Ω/t` | narrowing×FC factor | min bare W0 for 293K | physical (W0≤10eV)? |
|---|---|---|---|
| 0.3 (deep adiabatic) | 4.5e-4 | **2004 eV** | NO |
| 0.5 | 6.2e-2 | 14.4 eV | marginal |
| 0.7 | 0.24 | 3.7 eV | YES |
| 1.0 (Ω = t) | 0.50 | 1.8 eV | YES |
| 1.5 | 0.73 | 1.2 eV | YES |
| 2.0–4.0 (anti-adiabatic) | 0.84–0.96 | 1.1–0.9 eV | YES |

**The feasibility verdict (`press_all_strong.py`, `press_all_feasible.py`):**
- In the **adiabatic / Migdal-valid corner `Ω/t ≲ 0.7`** (where Allen–Dynes/Eliashberg holds), the
  required bare bandwidth **explodes (>14 eV, →2000 eV)** — this is a **clean NO-GO**. The L14
  Franck-Condon dressing wall (`Z_FC`) binds: strong glue at small Ω self-traps the pair, collapsing
  `ε_F·Z_FC`. **This is exactly why every adiabatic-regime closure (L9/L13/L14 in the molecular/κ-H3
  hosts) capped at tens-of-K.**
- In the **anti-adiabatic corner `Ω/t ≳ 0.8–1.0`** (Ω at least comparable to the hopping — Migdal
  BROKEN, Regime II), the FC and narrowing factors relax toward 1, and the only surviving wall is
  **L13** (`D_s ≤ 0.04 ε_F`), which a bare bandwidth `W0 ≳ 2 eV` satisfies. **822 feasible ≥293K
  points exist** in this corner.

**Tc_max is therefore NOT a fixed ceiling below 293K.** Pressing all channels at once, the master
structure permits Tc ≥ 293 K **iff** the system is anti-adiabatic (`Ω ≳ t`). The relief valves are
real but they are NOT a closed balloon — there is a **seam** where pressing all four simultaneously
leaves a feasible interior point.

**Which inequality binds at the optimum** (the decisive "which wall" question):
- adiabatic side of the seam: **L14 (Franck-Condon) binds** — the self-trapping/transfer lock.
- anti-adiabatic side: **L13 (stiffness ceiling) binds** — Tc capped by ε_F alone.
- the seam itself (`Ω ≈ t`) is the saddle where the two walls cross; that is the optimization's
  unique escape gate. (L9 and L15 never bind at the optimum — L9 is subsumed into the narrowing
  coupling, and L15 only matters if the host is magnetic, which the seam forbids.)

---

## TASK 3 — the feasible point: coordinates, nearest real host, 1-atm realizability

**The threading candidate coordinates (the "pressed-everywhere" point):**

    t  ≈ 100–200 meV      (narrow-but-metallic carrier band)
    Ω  ≈ 200–400 meV      (LIGHT-element bond phonon; the HARD requirement Ω ≳ t)
    g/t ≈ 0.6–0.9         (strong off-diagonal binding, paired fraction ~0.5–0.8)
    W0 ≈ 2–8 eV bare      (wide bare band so dressed ε_F clears the 0.45–0.63 eV L13 floor)
    Uχ low (paramagnetic, no SDW/CDW pre-emption) · 3D · ξ_pair small (compact bipolaron)

**The single residual inequality (the seam condition):**

    room-T feasible  ⇔  Ω ≳ t   AND   ½·W0·exp(−1.5(g/t)²/(Ω/t)²) ≳ 0.45 eV   with g/t ≳ 0.6

**Nearest real-material design target.** The seam demands a **light-element covalent metal where the
same bond that carries current is the one that vibrates** (bond-stretch modulates the hopping =
off-diagonal/SSH), with the phonon comparable to or above the (narrow) electronic hopping:

- **MgB₂-class σ-band** — B–B Ω ~ 70–90 meV but `t` ~ 2–3 eV ⇒ `Ω/t ≪ 1`, deep adiabatic ⇒ **FAILS
  the Ω≳t seam** (this is why MgB₂ is 39 K, not room-T — it is on the wrong side of the seam).
- **B-doped diamond / covalent boron** — C–C/B Ω ~ 150 meV but wide bands ⇒ borderline-adiabatic.
- **★ boron / BC kagome / B-cage (sodalite-type) framework** — light-B bond phonons Ω ~ 150–200 meV
  on an intrinsically NARROW flat-band-adjacent metallic manifold `t ~ 100–200 meV` ⇒ **`Ω/t ≈ 1`, IN
  the seam**. This is the nearest 1-atm-realizable target. It coincides with the campaign's existing
  `hP8-B boron kagome` design spec (`CANDIDATE_FINAL_MATRIX.md`) — the synthesis independently
  re-derives that exact target as the unique feasible host class.
- **anti-adiabatic light-bipolaron molecular crystal** (Ω ≳ t by construction) — sits in the seam on
  the `Ω/t` axis but the L13 ε_F wall returns (narrow molecular band), so it lands back at tens-of-K
  (κ-H3 lesson). **Borderline — fails on ε_F, not on Ω/t.**

**1-atm realizability of the seam host.** The seam is realizable at 1 atm precisely because it needs
NO pressure — it needs *light elements* (for Ω ≳ 200 meV) and a *narrow-but-not-localized* band (for
`Ω ≳ t` AND `ε_F ≳ 0.5 eV` after dressing). The HARD obstruction is the simultaneous demand: `Ω ≳ t`
pushes `t` down (narrow band), but the L13 floor pushes the *dressed* `ε_F = ½W0·exp(−narrow)` up
(wide band). Both hold only in a thin window for light elements — which is why no existing material is
confirmed in it, and why this is a DESIGN TARGET, not a found material.

---

## TASK 4 — NOVELTY GATE (d_novel_only · MANDATORY · inline arxiv+web)

**VERDICT: the individual faces are PUBLISHED; the FOUR-CHANNEL SYNTHESIS as one D_s-depletion
structure with a single anti-adiabatic escape seam is NOVEL (competitor-empty). This is a SYNTHESIS /
conditional-feasibility finding, not a found material — reportable as a framing-NOVEL meta-result.**

| sub-claim | verdict | competing ids |
|---|---|---|
| L13 face: Tc ≲ 0.04 ε_F upper bound (strong-coupling e-boson) | **PUBLISHED** | **arXiv:2505.02894** (Gnezdilov–Boyack, PRB 112 L180504 2025) |
| upper bound on Tc / stiffness, multiband, any-dim | **PUBLISHED** | **PRX 9,031049** (Hazra–Verma–Randeria 2019); npj QM s41535-022-00491-1 (Hazra 2022) |
| rigorous LOWER bound on flat-band stiffness | **PUBLISHED (2026)** | **arXiv:2506.18969** (bootstrap stiffness bounds) |
| anti-adiabatic SSH Tc grows unbounded with λ (Ω→∞) | **PUBLISHED** | **arXiv:2308.06222**; 2203.07380 (Berciu, bipolaronic HT-SC); 2605.16625 |
| Tc ≤ phase stiffness (Emery–Kivelson) | **PUBLISHED** | Emery–Kivelson Nature 374,434 (1995) |
| L14 Franck-Condon transfer-lock closure (off-diag glue ⊕ wide carrier) | **NOVEL (this campaign)** | NONE (`two_band_decouple.md`) |
| L15 Stoner pre-emption closure (incipient-band ambient) | **NOVEL (this campaign)** | NONE (`incipient_band_resonance.md`) |
| **all four faces = ONE product of independently-bounded D_s factors, with the anti-adiabatic Ω≳t seam as the UNIQUE four-channel escape** | **NOVEL (framing, competitor-empty)** | NONE — no paper unifies self-trapping ⊕ band-narrowing ⊕ stiffness-ceiling ⊕ Stoner as one multiplicative-D_s structure, nor derives the Ω≳t seam as their joint feasible region |

**Closest competitors & honest separation:** arXiv:2505.02894 supplies the L13 factor but treats it
in isolation (no multi-channel product). PRX 9,031049 / arXiv:2506.18969 bound D_s but do not couple
the bound to off-diagonal self-trapping (L14) or Stoner pre-emption (L15). The SSH-anti-adiabatic
papers (2308.06222, 2203.07380, 2605.16625) confirm the Ω≳t escape on the *binding* axis — and thus
**independently corroborate my feasible seam** — but none assembles the four-channel product or shows
that the seam is the UNIQUE survivor of pressing all four valves. **The synthesis (the product
functional + the seam = unique joint-feasible region + the binding-wall map L14↔L13 across the seam)
is competitor-empty.** It is a CONDITIONAL-FEASIBILITY meta-finding, not a discovery of a material
(d6: no ≥293K material is produced — the seam is a design target).

---

## TASK 5 — ROOMT g5 framing

Per `ROOMT_AMBIENT_PASS_CRITERIA.md`, this lane is a **TIER-1 #4 (coupling/Tc) META-analysis** — it
does NOT itself clear any candidate, it characterizes the *structure* of the #4 bottleneck:

- **g5 framing:** the synthesis is a TB/analytic-grade *conditional theorem* — `kB·Tc ≤
  (π/2)·α13·ε_F^dressed(g,Ω)·Z_FC(g,Ω)·(1−Uχ)·f_pair(g)` with feasible region `{Ω ≳ t, W0 ≳ 2 eV,
  paramagnetic}`. It is **falsifiable**: a DFT/DFPT computation of any seam-candidate (★boron kagome
  hP8-B) that returns `Ω/t < 0.8` OR dressed `ε_F < 0.45 eV` OR `Uχ ≥ 1` falsifies that host's
  feasibility; a host with `Ω/t ≳ 1`, dressed `ε_F ≳ 0.5 eV`, paramagnetic, and `g/t ≳ 0.6` would be
  the room-T candidate.
- **honest tier:** this is **🟠→🟢 framing**, NOT a 🟢 GATE_CLOSED_MEASURED material. The campaign
  does NOT close with a clean no-go theorem (the no-go FAILS — a feasible seam exists). It closes the
  *meta-question* with: **SEPARABLE, one seam, anti-adiabatic light-bond corner, binding wall L14
  (adiabatic) ↔ L13 (anti-adiabatic), nearest host = boron-kagome class.** Either branch was a strong
  finding; this is the SEPARABLE branch with a derived candidate region.

---

## NAME NEXT ROUND + depletion test

**NEXT ROUND — `seam-dft-boron-kagome`:** the synthesis hands a single concrete compute. The feasible
seam is now a *quantitative DFT test*, not an open question: take ★hP8-B (or a BC/B-cage light kagome)
and compute the three seam coordinates from first principles —
1. `Ω/t` from DFPT phonon (B-bond Ω) vs Wannier hopping `t` — is `Ω/t ≳ 0.8`? (the make-or-break seam axis);
2. dressed `ε_F = ½W0·exp(−g²/Ω²)` from the Wannier bandwidth + el-ph `g` — is it `≳ 0.45 eV`? (L13 floor);
3. `Uχ` from an RPA/Stoner scan — is the ground state paramagnetic? (L15 non-preemption).
A green on all three = the first real material *inside* the four-channel feasible seam (Tier-1 #4 PASS
candidate); a red on any = that host is falsified and the seam tightens. FREE on summer QE 7.5
(`/home/summer/miniforge3/envs/qe/bin/pw.x`, confirmed live) — `hexa deck` + DFPT, no billing pod.

**DEPLETION TEST (when does the roomt-discover lane close?):** the lane depletes when the seam-DFT
returns either (a) a real material with all three seam coordinates green @ 1 atm = the room-T candidate
(→ `/paper`, Tier-1 #4 PASS, escalate to wet-lab Tier-2), OR (b) a falsification showing the seam is
EMPTY for all light-element candidates — i.e. `Ω ≳ t` and dressed `ε_F ≳ 0.45 eV` are NEVER
simultaneously satisfiable at 1 atm (which WOULD convert this SEPARABLE result into the clean no-go).
Until one of those lands, the lane is **OPEN at the seam** — the master conservation is separable, the
escape is the anti-adiabatic light-bond corner, and the only undischarged question is whether a real
material sits in it.
