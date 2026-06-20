# FB-GEOM-LAMBDA — ceiling-escape lane

## Question
Does the Tc-ceiling **`Tc_ceiling = 0.364 · ω_log(W*)`** (bound by λ≲4, derived in
`fb-ceiling/CEILING_DERIVATION.md`) have a **mathematical escape** — a regime where
Tc can EXCEED `0.364·ω_log(W*)`?

## Answer (one line)
**YES — one genuine escape exists.** Three of four candidates FAIL (the ceiling holds /
they only optimize its *value*); the fourth, **bipolaron / BEC-crossover Tc in the
light-bipolaron (SSH/bond) regime, provably exceeds the ceiling** because it exits the
Allen-Dynes/Migdal regime the ceiling was derived in. The ceiling is therefore **NOT a
universal hard bound — it is the bound of the Migdal-Eliashberg phonon channel only**, and
the closing formula gains an **escape term gated by the Migdal-validity boundary**.

---

## The ceiling and its four load-bearing premises
`Tc_ceiling = 0.182·√λ_cap·ω_log(W*) = 0.364·ω_log(W*)` rests on:

| premise | statement | candidate that breaks it |
|---|---|---|
| **P1** | Allen-Dynes/Eliashberg phonon pairing, **Migdal valid** | C3, C4 |
| **P2** | harmonic phonons soften as band flattens, `ω_log=ω0(W/W0)^p`, `p≥0` | C1, C2 |
| **P3** | single λ-weighted thermodynamic `ω_log` | C2 |
| **P4** | the pairing scale IS `ω_log` (no separate condensation scale) | C4 |

Escape metric per candidate: `E = Tc_candidate / (0.364·ω_log(W*))`. `E>1` = escape.

---

## Per-candidate escape test (g5 PASS)

### C1 — anharmonic ω_log hardening — **FAILS (ceiling holds), E_max=1.000**
Quantum/anharmonic (SSCHA) renormalization HARDENS phonons (effective `p<0`). Scanned
`p∈[−1,+1]`. **Structural result:** the coefficient `0.364 = 0.182·√4` is fixed by the
λ-cap, NOT by `ω_log`. Hardening RAISES `ω_log(W*)` — so the ceiling *value* rides UP with
it — but the **ratio `E=Tc/(0.364 ω_log(W*))` is reparametrization-invariant ⇒ `E≤1` for
every `p`**. Anharmonic hardening is a *ceiling-raising material lever* (sourced bound
~≤20% optical hardening, SSCHA — Nature Comm Phys s42005-024-01643-4,
npj s41524-025-01816-x), **not an escape above the ceiling.**

### C2 — gapped-acoustic / all-optical spectrum — **FAILS (ceiling holds), E_max=1.000**
fb-ceiling R2 showed the SOFT acoustic branch self-asserts (`ω_log→ω_acoustic` at small W).
Re-examined the OPPOSITE extreme: a **phonon-gapped, all-optical** spectrum (`p=0`, stiff
W-independent optical manifold — clathrate/hydride H-cage modes). Then `ω_log=ω_optical` is
the STIFFEST possible scale and the geometric lowering `Q^{p/(1+2p)}→1`. This is the
**ceiling-OPTIMAL spectrum** (R2's soft case = worst, this = best), but Tc at the cap is
still exactly `0.364·ω_log` ⇒ `E≤1`. **Optimizes the ceiling value; does not exceed it.**

### C3 — geometric superfluid weight / BKT — **FAILS (ceiling holds), E_phys=0.69**
Flat-band intraband superfluid weight vanishes; phase stiffness comes from the quantum
metric, `D_s ~ C_g·λ·ω_log·ḡ` (Peotta-Törmä), and in 2D `T_BKT=(π/8)D_s`. This breaks P1
(BKT, not Allen-Dynes) but is **glued by the SAME `λ·ω_log`** ⇒ it inherits the `ω_log`
scale. Escape would require geometric prefactor `C_g·ḡ > 0.232`; the physical Peotta-Törmä
mean-field coefficient is `C_g=1/(2π)=0.159` with `ḡ≤1`, giving `C_g·ḡ≤0.159 < 0.232` ⇒
`E_physical=0.69 < 1`. **Confirmed by the sourced quantum-metric NO-GO theorem
(arXiv:2604.04719, Zhou 2026): the geometric superfluid weight CANNOT escape the
Allen-Dynes ceiling.** (Only *unphysical* `C_g>1/(2π)` cross E>1 in the scan — excluded.)
The geometric channel is a **separate, generally LOWER** (phase-stiffness) bound, not an
escape above `ω_log`.

### C4 — bipolaron / BEC-crossover Tc — **ESCAPE, E=3.4–5.0 (light bipolaron)** ✅
In the strong-coupling corner flat bands actually reach (`λ~4`, and `E_F~W→0` so the Migdal
parameter `λω/E_F` is NOT small), **Migdal-Eliashberg breaks down**. Electrons bind into
real-space bipolarons; Tc is set by **bipolaron condensation** `Tc ≈ a3·t**` (`t**` =
bipolaron hopping `~ t0/(m**/m0)`), governed by the bipolaron **MASS**, not `0.182 ω_log√λ`.

| bipolaron type | m**/m0 | Tc (K) | ceiling (K) | E | escapes |
|---|---|---|---|---|---|
| Holstein (heavy) | e²≈7.4 | 276 | 338 | 0.82 | no |
| Holstein (v.heavy) | e⁴≈55 | 37 | 338 | 0.11 | no |
| **SSH/bond (light)** | 1.8 | 1135 | 338 | **3.36** | **YES** |
| **SSH/bond (v.light)** | 1.2 | 1702 | 338 | **5.04** | **YES** |

**Holstein** (density-coupled) bipolarons are exponentially heavy (`m**~e^{g²}`) ⇒ Tc
collapses BELOW the ceiling (false escape). **SSH/bond (Peierls, hopping-modulated)**
bipolarons are LIGHT and small ⇒ `Tc~O(ω_log)` itself ⇒ `E>1`. **Sourced verbatim**
(PRX 13, 011010 / arXiv:2210.14236, Zhang–Sous–Berciu–Millis–Sangiovanni): bond-bipolaron
Tc *"generically and significantly exceeds the Migdal-Eliashberg upper bound,"* `Tc→O(Ω)`,
exponentially larger than Holstein. The Allen-Dynes ceiling is a **Migdal-valid** statement;
flat bands violate Migdal, exiting into the regime where the bound does not apply.

---

## Depletion declaration

**(a) An escape provably exceeding the ceiling IS found → it becomes the closing formula's
escape term (terminal, breakthrough).**

The ceiling `Tc ≤ 0.364·ω_log(W*)` is **FINAL within the Allen-Dynes/Migdal phonon channel**
(C1, C2, C3 all confirm it there — anharmonicity and all-optical only raise/optimize its
*value*; the geometric/BKT channel obeys the no-go theorem and stays below it). But it is
**NOT a universal bound on Tc**. The closing formula must read:

```
            ┌────────────────────────────────────────────────────────────────┐
  Tc  <=    │  0.364 . w_log(W*)             for   lam*w_log/E_F << 1 (Migdal)│   PHONON CEILING
            │  a3 . t**(m**)  ~  O(w_log)    for   lam*w_log/E_F >~ 1 (bipol.)│   ESCAPE TERM
            └────────────────────────────────────────────────────────────────┘
  escape gate = the Migdal-validity boundary E_F ~ W -> 0 (which flat bands force);
  escape lever = LIGHT bipolarons (SSH/bond/Peierls hopping-modulation), NOT Holstein density.
```

- **C1 anharmonic hardening** — raises the ceiling *value* (≤~20%), `E≤1`. Material lever, not escape.
- **C2 all-optical / gapped-acoustic** — optimizes the ceiling *value* (stiffest `ω_log`, no
  geometric lowering), `E≤1`. The ceiling-OPTIMAL phonon design.
- **C3 geometric superfluid-weight/BKT** — `E_phys=0.69<1`, closed by the sourced no-go theorem.
- **C4 light bipolaron / BEC-crossover** — `E=3.4–5.0` — **THE ESCAPE.** Terminal breakthrough.

**g5 = PASS.** Escapes found = 1 of 4 (C4). Ceiling is FINAL for the phonon (Migdal) channel,
escaped by the bipolaron channel. The discovery payoff: to beat `0.364·ω_log(W*)`, a flat-band
material must enter the **light-bipolaron** regime — favor **bond/Peierls (off-diagonal)
electron-phonon coupling over Holstein (on-site density) coupling**, so the heavy-mass
penalty `m**~e^{g²}` is avoided.

## Assumptions / honesty (d6)
- C4 uses transparent lattice-BEC estimates (`Tc~a3·t**`, `t0~ω_log`, `n_b~0.1`); the
  *direction and order of magnitude* (light SSH bipolaron Tc ~ O(ω_log) >> 0.364 ω_log) is the
  sourced PRX result, not a fitted number. The escape is the **existence of a regime above the
  ceiling**, not a specific Tc value.
- The escape is gated by Migdal breakdown (`E_F~W→0`), which is exactly the flat-band limit
  that makes the *ceiling derivation's own* λ→cap divergence physical — so the escape lives at
  the same corner the ceiling was about. This is a regime change, not a contradiction.
- C3's no-go closure relies on the 2026 arXiv:2604.04719 result; the analytic crossover
  `C_g·ḡ>0.232` vs physical `C_g=1/(2π)` is the independent check that reproduces it.

## Sources
- Ceiling λ-cap: arXiv:2407.12922 (fundamental λ limit).
- C1 anharmonicity: Nature Comm Phys s42005-024-01643-4; npj s41524-025-01816-x; SSCHA (arXiv:2103.03973).
- C3 no-go: arXiv:2604.04719 (Zhou 2026, quantum-metric no-go); phase-stiffness bound npj QM s41535-018-0133-0 / s41535-022-00491-1; Peotta-Törmä Nat Commun ncomms9944.
- C4 escape: PRX 13, 011010 / arXiv:2210.14236 (Zhang–Sous–Berciu–Millis–Sangiovanni, bipolaronic high-Tc); npj QM s41535-022-00491-1 (heuristic bounds & how to exceed them).
