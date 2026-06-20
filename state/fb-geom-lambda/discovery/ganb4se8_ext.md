# GaM4X8 lacunar-spinel cluster-Mott family — bond-Peierls SC extension

🧲 **RTSC FB-GEOM discovery lane** · 2026-06-19 · `state/fb-geom-lambda/discovery/`
Question: can a GaM4X8 family member / doping / pressure push the bond-phonon Tc
meaningfully **above** the Ge-doped GaNb4Se8 onset-45K — a concrete NOVEL prediction
— or is 45K near the family cap (closed-negative)?

Model: validated SSH bond-bipolaron exact-diag solver
(`../bond-bipolaron/solver.py`) + bond-phonon Ω(M-X) reduced-mass trend
(`ganb4se8_family_model.py`, results `ganb4se8_family_results.json`).

---

## 0. Why this family is the FB-GEOM empirical anchor (mechanism is sourced)

The lacunar spinels GaM4X8 (A=Ga/Al/Ge; M=V,Nb,Mo,Ta; X=S,Se,Te) are **cluster-Mott
insulators**: M4 tetrahedral clusters in a pyrochlore network, one unpaired electron
per cluster in the molecular **t2** orbital (S=1/2). Under pressure they go
Mott → metal → superconductor. The pairing glue is explicitly a **bond phonon**:

> "the occurrence of superconductivity is connected with a pressure-induced
> decrease of the MX6 octahedral distortion and **simultaneous softening of the
> phonon associated with M–X bonds**" — Abd-Elmeguid et al. (JACS ja050243x;
> high-P XRD/Raman on GaNb4S8/GaNb4Se8/GaTa4Se8).

A **softening bond phonon that modulates the M–X (hence cluster–cluster) hopping**
is the textbook **off-diagonal / SSH (Peierls, ∂t/∂u)** electron-phonon coupling —
precisely the LIGHT-bipolaron escape channel identified in our closing formula
(`RTSC_DISCOVERY_CLOSING_FORMULA.md`, Regime II). The Ge:GaNb4Se8 45K result then
adds the second ingredient: **filling control** — Ge→Ga donates one electron into
the t2 orbital (n: 1 → 1+x per cluster), destabilizing the half-filled Mott state
and putting dilute carriers into the SSH band where they can bond-bipolaron condense.
This is the first real, family-validated realization of FB-GEOM Regime II.

---

## 1. Family map (sourced Tc / pressure / mechanism)

| Compound | M (d-shell) | X | Ground state | SC? Tc / route | Source |
|---|---|---|---|---|---|
| **GaNb4Se8** | Nb (4d) | Se | nonmagnetic cluster-Mott, TQ=50K quadrupolar | **2.9 K @ 13 GPa** (pressure) | Abd-Elmeguid PRL 2004 / ja050243x |
| **GaNb4Se8 + Ge** | Nb | Se | doped-Mott | **onset 45 K, zero-R ~25 K** (electron doping, Ga0.9Ge0.2Nb4Se8) | arXiv:2510.12452 (2025) |
| **GaTa4Se8** | Ta (5d, strong SOC, jeff=3/2) | Se | spin–orbit Mott | **5.8 K @ 11.5 GPa**; "topological", spin-2 pairs | npj Quantum Mater. 2020 / arXiv:2006.04782 |
| **GaNb4S8** | Nb | S | cluster-Mott, structural+magnetic transitions | **~4 K @ 23 GPa** (pressure) | ja050243x |
| **GaTa4S8** | Ta | S | SO Mott | pressure SC reported (lacunar family) | family refs |
| **GaV4S8** | V (3d) | S | **FM Mott**, orbital order @44K, skyrmion lattice <13K | no clean SC — magnetism dominates | Chem. Mater. 2015 |
| **GaMo4S8 / GaMo4Se8** | Mo (4d) | S/Se | polar, itinerant-e magnetism, skyrmions | no SC reported — magnetic | Chem. Mater. 2021 |
| **GaTa4Se(8-x)Te(x)** | Ta | Se/Te | narrow-gap Mott, avalanche breakdown | bandwidth-tuned IMT | Nat. Commun. 2735 |

**Reading of the map.**
- The **superconducting branch is the nonmagnetic Nb/Ta selenides/sulfides** (Nb4, Ta4
  clusters, jeff/J cluster moments that go nonmagnetic). Pressure (undoped) gives
  2.9–5.8 K; **electron doping (Ge) gives the 45K jump.**
- The **V and Mo members are magnetic** (FM order, orbital order, skyrmion lattices)
  — magnetism pre-empts SC. They are the **cap side** of the family, not the lever.
- The **45K jump driver** = filling control off the n=1 half-filled cluster Mott
  point (Ge adds an electron to t2), NOT a change of phonon. Same bond-phonon glue,
  but the carriers are now itinerant in the narrow SSH band → bond-bipolaron channel
  opens at ambient pressure.

### ⚠️ Honesty on the 45K anchor (this matters for the verdict)
The 45K is **a single batch, zero-resistance-only**: no Meissner / diamagnetic
shielding fraction; full zero-R only at ~25K; **NbSe2 impurity present** in XRD;
**signal vanishes within days** (samples decompose to parent GaNb4Se8). The authors
themselves label it "possible" and "tentative, pending magnetic susceptibility."
So 45K is a **provisional, unconfirmed** anchor — the family's *demonstrated* bulk
SC is still the 2.9–5.8 K pressure branch. The extension below is anchored to 45K
but the relative trend is the load-bearing result, not the absolute number.

---

## 2. The NOVEL lever the literature has not pushed

Three independent knobs raise the bond-bipolaron Tc; literature has only worked one.

| Lever | Direction | Status in literature | FB-GEOM expectation |
|---|---|---|---|
| **Filling (Ge / electron doping)** | off n=1 Mott → dilute SSH carriers | DONE (Ge:GaNb4Se8 → 45K) — only Se done | already the 45K driver; optimize x |
| **Lighter X (S vs Se vs Te)** | S → higher bond Ω → higher Tc prefactor | **NOT doped** — only pressure-SC of undoped sulfide known (4K) | **the open lever** |
| **Lighter M (Nb vs Ta)** | Nb (4d) lighter than Ta (5d) → higher Ω, weaker SOC | Nb already the SC champion | favors Nb over Ta |

**Bond-phonon Ω(M–X) trend** (Ω ∝ √(k/μ), μ = M–X reduced mass, k transferable;
anchored to Nb–Se ≈ 35 meV soft mode):

```
  M       S      Se     Te   (meV)
  Nb    46.8    35.0   31.2
  Ta    43.8    30.8   26.4
  V     51.6    41.1   37.9   (but V = magnetic)
```

→ **Nb–S ≈ 47 meV vs Nb–Se ≈ 35 meV** = a **1.34× higher bond-phonon prefactor**,
SAME nonmagnetic cluster-Mott chemistry, SAME SSH glue, SAME Ge filling-control trick.
**The single NOVEL lever = electron-dope the SULFIDE: Ge:GaNb4S8** (and its Te-free,
nonmagnetic cousins). The 45K experiment used Se only; the sulfide-doped member has
never been made. (V-sulfide has even higher Ω=52 meV but is ruled out by magnetism.)

---

## 3. Model Tc ceiling for the top member

SSH bond-bipolaron exact diagonalization (L=6, Nb=8 phonons, n=0.1 dilute pairs),
swept over family-realistic (t/Ω, g/Ω). **Tc/Ω is dimensionless = the mechanism;**
multiply by Ω(M–X) and anchor to the 45K point.

```
  t/Ω  g/Ω   bind/t   m**/mf   Tc/Ω    bound
  0.7  1.0   -2.16    1.52    0.072    yes
  1.0  1.0   -1.47    1.48    0.105    yes
  1.3  1.0   -1.10    1.42    0.142    yes   <- lighter/faster pairs, higher Tc/Ω
```

Pairs are **bound AND light** (m**/mf ≈ 1.4–1.5, NOT the e^{g²} Holstein blow-up) —
confirms the SSH/Peierls light-bipolaron regime across the whole family-realistic box.
Representative family value: **Tc/Ω ≈ 0.10** at t/Ω = g/Ω = 1.

Anchoring Tc/Ω·Ω(Nb–Se) to the 45K onset (SCALE folds in all prefactor uncertainty):

| Member | Ω (meV) | **Tc ceiling (K)** | note |
|---|---|---|---|
| Ge:GaNb4Se8 | 35.0 | **45** | empirical anchor (single batch, unconfirmed) |
| Ge:GaNb4Te8 | 31.2 | 40 | heavier X |
| Ge:GaTa4Se8 | 30.8 | 40 | 5d, strong SOC |
| **Ge:GaNb4S8** | **46.8** | **≈ 60** | **NOVEL: sulfide + same Nb cluster** |
| Ge:GaV4S8 | 51.6 | (66) | highest Ω but **magnetic → likely killed** |

**Top plausible (nonmagnetic) member: Ge-doped GaNb4S8 → Tc ceiling ≈ 60 K**
(1.34× the 45K Se anchor, the ratio is exactly Ω(Nb–S)/Ω(Nb–Se)). If the
filling-optimization also lands closer to the t/Ω≈1.3 sweet spot (Tc/Ω≈0.14 vs
0.10), the model headroom extends to **~70–85 K**, but that requires the doping
to be tuned, not just the anion swapped.

---

## 4. Honest verdict (d6)

**A concrete NOVEL prediction, WITH explicit assumptions — NOT room-Tc, NOT closed.**

**PREDICTION:** Electron-doped **GaNb4S8 (e.g. Ga1-xGexNb4S8)** should superconduct
with a bond-phonon Tc **above the 45K Se value, ceiling ≈ 60 K** (≈ 70–85 K only if
the doping level also hits the t/Ω≈1.3 light-pair sweet spot). The lever is the
**lighter anion (S over Se) raising the M–X bond-phonon Ω by ~1.34×**, applied to
the **same nonmagnetic Nb4 cluster-Mott host** and the **same Ge filling-control**
trick that produced the 45K Se result — a single-substitution, never-attempted member.

**Assumptions (all falsifiable):**
1. The bond-phonon stays the SC-relevant soft mode in the sulfide and scales as
   √(1/μ) (k transferable Nb–S↔Nb–Se). If S stiffens the lattice enough to *raise*
   t out of the t/Ω≈1 window, the bipolaron unbinds — model shows binding survives
   to t/Ω=1.3, so there is margin, but not unlimited.
2. GaNb4S8 stays **nonmagnetic** under Ge doping (the V/Mo members do NOT — magnetism
   is the family cap). Nb4 (4d) is the safe, nonmagnetic cluster; this is why Nb–S,
   not the higher-Ω V–S, is the pick.
3. Ge actually dopes the S analog (the Se experiment was barely controllable;
   GeS volatility may be worse/better — synthesis risk, not a physics cap).

**Where the cap is (the honest ceiling):** the family is bounded by **(a) magnetism**
on the V/Mo side (kills SC outright) and **(b) the light-atom phonon budget** —
the lightest *nonmagnetic* cluster anion is S, so Ω tops out around 45–50 meV →
Regime-II bond-bipolaron Tc tops out around **60–85 K**, NOT room-Tc. There is **no
hydrogen here**; you cannot reach the H-phonon budget (Regime I, ~69 meV) in a
metal-chalcogenide cluster. So this family is a **bounded high-Tc lever, not a
room-Tc route** — fully consistent with `RTSC_DISCOVERY_CLOSING_FORMULA.md`
(Regime II light-bipolaron escape gives tens-of-K, not 300K).

### The single deciding experiment / calc
**Synthesize Ga1-xGexNb4S8 and measure Tc with a Meissner (diamagnetic shielding
fraction) confirmation — not zero-R alone.** Two outcomes, both decisive:
- Tc(S) > Tc(Se) → bond-phonon Ω trend confirmed, FB-GEOM Regime-II validated, and
  the ~60K prediction stands → push x-optimization next.
- Tc(S) ≤ Tc(Se) → the Tc is NOT set by the M–X bond-phonon Ω (it's the cluster
  electronic structure / DOS at the doped filling), closing the lighter-X lever and
  capping the family near 45K.

**The cheaper computational proxy** (do this first, free on mini/summer): DFPT/QFORGE
electron-phonon on doped (rigid-band or VCA, n=1+x) **GaNb4S8 vs GaNb4Se8** — compare
the M–X soft-mode frequency and the **off-diagonal (SSH) deformation potential ∂t/∂u**.
If ∂t/∂u·Ω is larger for the sulfide, the 60K prediction is computationally backed
before any furnace is lit. (Pre-check: matdyn dynamic stability of the doped cell,
d6, before any el-ph fire.)

---

## Provenance
- 45K anchor: arXiv:2510.12452 "Possible high-Tc superconductivity at 45 K in the
  Ge-doped cluster Mott insulator GaNb4Se8" (Yuan, Ren et al., IOP CAS, 2025).
  **Unconfirmed: single batch, zero-R only, NbSe2 impurity, decays in days.**
- Bond-phonon SC mechanism + pressure Tc: JACS ja050243x (Abd-Elmeguid et al.);
  GaTa4Se8 npj Quantum Mater. 2020 / arXiv:2006.04782; GaNb4S8 ~4K @ 23 GPa.
- Magnetic family members (cap): GaV4S8 Chem. Mater. 2015; GaMo4Se8 Chem. Mater. 2021.
- Mechanism formula: `RTSC_DISCOVERY_CLOSING_FORMULA.md` (Regime II), solver
  `../bond-bipolaron/solver.py` (validated SSH bond-bipolaron, light m**/mf≈1.5).
- Model + numbers: `ganb4se8_family_model.py` → `ganb4se8_family_results.json`.
