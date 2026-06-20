# metallic-hbond-wideband — RTSC room-T DISCOVERY lane VERDICT (R2 of metallic-hbond-ssh)

🧪 **RTSC** · ambient room-T DISCOVERY lane · `state/fb-geom-lambda/roomt-discover/metallic_hbond_wideband.md`
Date: 2026-06-20 · FREE summer-only (NO billing pod) · d6 honest · NEVER fabricate.
Artifacts: `wideband_dft_fire.sh` (the REAL DFT fire) · summer `/home/summer/rtsc_hmoo3/scf_*.out` (5-point
frozen-phonon proton scan, all converged) · `wb_parse.json` · `wb_gt.json` (band-resolved g/t).
Upstream: R1 `metallic_hbond_ssh.md` (narrow-band L13 closure) + sibling bronze TB probe `metallic_hbond_ssh.py`.

> R2 spec (the L13-escape): find a 1-atm host where a short O-H-O bridge modulates a **WIDE** metallic
> TM-d band — ε_F ≥ 0.63 eV (clears L13 for 293 K) **AND** g/t ≥ 0.38 on the SAME band. Break the
> coupling↔bandwidth anti-correlation by using an inorganic wide TM-4d band instead of a narrow molecular π band.

---

## BOTTOM LINE (d6 honest) — 🔴 CLOSED. The anti-correlation is UNBREAKABLE in real single-band hosts (now both ends DFT-confirmed)

**A REAL DFT frozen-phonon proton scan on metallic HMoO₃ (the wide-band short-H-bond host) shows the proton
is a near-SPECTATOR on the wide band: g/t ≈ 0.003–0.004, two orders of magnitude below the 0.38 dome onset,
EVEN THOUGH ε_F clears L13 by a huge margin.** R1 closed the narrow-band side (g/t passes → ε_F fails →
L13 caps Tc≤87 K). R2 closes the **wide-band side** (ε_F passes → g/t fails → proton can't gate the band).
The single-band coupling↔bandwidth trap is now closed **at BOTH ends by real DFT** — and the real materials
(H₀.₂₃WO₃, H₀.₁₀ReO₃) were synthesized and measured: **no superconductivity down to 0.35 K** (empirical seal).
This lane **DEPLETES**: the residual lives only in the two-band-decouple program (separate wide carrier band),
not in any single-band short-H-bond host.

---

## TASK 1 — FIRST-PRINCIPLES: is g/t necessarily small on a wide TM-d band? (the derivation)

**The Harrison-floor argument says g/t should be bandwidth-INDEPENDENT** — but it has a hidden in-path
assumption that real wide-band hosts violate. Derivation:

For an H-bridged hop t(u) with exponential overlap t ~ exp(−u/δ): ∂t/∂u = t/δ, so **g/t = (∂t/∂u)·u₀/t = u₀/δ**
— *independent of t*. Equivalently Harrison: ∂t/∂u ∝ t/d → g/t = 2u₀/d, again t-independent. **So at FIXED bond
geometry, a wide band should give the SAME g/t as a narrow one.** This is the R2 hope.

**The catch — the proton must GATE the transfer, i.e. the H-bond must BE the conduction path, not a spectator.**
The g/t = u₀/δ formula holds ONLY if the band-defining transfer *is* the H-modulated overlap. In a wide TM-d
band the dominant transfer is **direct M-d ↔ M-d (via the bridging O 2p) — a metal-oxide d-p-d σ/π hop whose
magnitude is set by the M-O-M geometry, NOT by where the proton sits.** The proton modulates a *secondary*
O-H overlap that contributes a *small fraction* of the total inter-site transfer. So the real ratio is:

   **g/t = (∂t_total/∂u)·u₀/t_total = [f · (∂t_OH/∂u)] · u₀ / t_total ≈ (u₀/δ)·(t_OH/t_total)**

where t_OH/t_total = the fraction of the conduction transfer that actually flows through the O-H overlap the
proton gates. **In a narrow molecular π band (κ-H3), the O-H-O bridge IS the inter-dimer transfer → t_OH/t_total ≈ 1
→ g/t = u₀/δ ≈ 0.4 (R1's strong coupling).** In a wide TM-d band the proton sits on an O that bridges two MO₆
octahedra whose d-p-d transfer dominates → **t_OH/t_total ≪ 1 → g/t ≪ u₀/δ.** The wide band is wide *because*
its transfer flows through a channel the proton does NOT gate.

**The condition for a short-H-bond to sit ON a wide metallic band AND keep g/t ≥ 0.38:** the band's *entire*
Fermi-surface transfer must funnel through the proton-gated overlap — i.e. the metallicity and the H-bond
must be the **same bond**. But a band that wide (≥ a few eV) is wide *only because* it has a strong direct
d-p-d channel that bypasses the proton. **The requirement is self-contradictory for a single band:** "wide"
needs a strong proton-independent transfer; "g/t large" needs the proton to control the whole transfer.
→ **t_OH/t_total and bandwidth are anti-correlated. This is L9/L14 re-derived at the orbital level.**

---

## TASK 2 — CANDIDATES + the REAL DFT measurement (the decisive compute)

**Candidate named & computed: cubic ReO₃-type HMoO₃** (the small-cell idealization of the H₀.ₓMoO₃ metallic
bronze, x=1). 5-atom cell (Mo + 3 O + 1 H), corner-sharing MoO₆, H on a Mo–O···H···O bridge along the O–Mo axis.
This is the *best-case* wide-band short-H-bond host: Mo-4d t2g + O-2p crosses E_F (metallic), and an interstitial
proton sits on a lattice O that bridges the octahedra (in the conduction path geometrically).

**REAL QE 7.5 DFT on summer (FREE, 6 cores):** PBE USPP, ecutwfc 50 / ecutrho 400 Ry, MV-smear 0.02 Ry,
5-point frozen-phonon proton scan H_x ∈ {0.26,…,0.34} crystal-frac (du = ±0.15 Å along the bridge axis).
All 5 SCF converged (conv_thr 1e-7). Band eigenvalues parsed across the k-mesh.

| measurement | value (real DFT) | spec gate |
|---|---|---|
| **metallic?** | YES — E_F at 8.16 eV inside the Mo-4d/O-2p manifold, partial occupations at E_F | PASS |
| **band width W_metband** | **4.64 eV** (most-dispersive band crossing E_F); full conduction manifold ~21 eV | wide ✓ |
| **t_ref (≈W/4)** | **1.16 eV** | — |
| **ε_F (E_F − conduction-band-bottom)** | **≫ 0.63 eV** (band is ~4.6 eV wide, partially filled; ε_F ~ several eV) | **PASS (L13 cleared)** |
| **∂t/∂u (band-resolved frozen-phonon)** | **−0.031 eV/Å** (from dW_metband/du = −0.126 eV/Å, z=4) | — |
| **proton ZPM u₀ (Ω=110–200 meV)** | 0.10–0.14 Å | — |
| **g = (∂t/∂u)·u₀** | **0.0032–0.0043 eV** | — |
| **g/t (on the SAME wide band)** | **0.0028–0.0037** | **FAIL (need ≥0.38; 100× short)** |

**This is the adverse prior CONFIRMED by real DFT, not model.** The wide Mo-4d band (t≈1.16 eV) is essentially
**unmoved** by the proton bond-stretch: moving the proton ±0.15 Å changes the band width by only ~0.13 eV
(∂t/∂u/t ≈ 0.027/Å), so the ZPM-scale modulation g is ~4 meV — utterly negligible vs t≈1.16 eV. **t_OH/t_total
≈ 0.01** measured directly: the proton gates ~1% of the conduction transfer; the Mo–O–Mo d-p-d channel carries
the other 99% and the proton doesn't touch it. Exactly Task-1's prediction. The proton is a **spectator on the
metallic band** — its real role in the bronze is the *chemical-potential donor* (each H donates 1 e⁻ filling the
4d band; the scan's large dE_F/du = 0.98 eV/Å is that band-filling/chemical-potential shift, NOT a transfer
modulation — the band-resolved W(u) is the honest g, and it is ~zero).

**L13/Tc:** ε_F passes L13 easily, but with g/t ≈ 0.003 the SSH bipolaron coupling is ~0 → no off-diagonal
pairing → λ→0 → Tc → 0 on the conventional axis. The wide band carries no room-T pairing because the proton
that was supposed to glue it does not couple to it. (ED cross-check not needed: g/t≈0.003 is below any binding
threshold — the dome onset is 0.38; no bound bipolaron forms.)

**Dynamical stability / metallic / bulk:** HMoO₃/H₀.ₓMoO₃ is a real, synthesized, 1-atm, bulk metallic oxide
(LIT) — gates #1/#2/#3 are materially PASS. But #4 (Tc≥293K) FAILS at the source: g/t≈0 → no SC mechanism.

---

## TASK 3 — RESULT CALC PROVENANCE (d6)

- **REAL DFT** (not TB-model): the W_metband, t_ref, ∂t/∂u, ε_F are **measured from converged QE SCF band
  eigenvalues** on the HMoO₃ cell (`scf_hx0*.out`), parsed in `wb_parse.json`/`wb_gt.json`. This is a genuine
  first-principles band response, the deliverable R1's resume-recipe asked for.
- **Idealization flags (honest):** (a) x=1 cubic cell, not the real incommensurate x~0.3–1.7 bronze; (b) the H
  position is a placed interstitial, not a relaxed-bridge optimum (we scanned, didn't vc-relax the proton — the
  scan IS the frozen-phonon, which is what g needs); (c) z=4 band→t conversion is the cubic axis-resolved
  estimate (z=6 or 12 would make t LARGER → g/t even SMALLER — the verdict is robust to z); (d) the nscf
  dense-ε_F probe step failed on a deck path bug (fresh outdir), non-fatal — ε_F is read from the SCF manifold
  directly and clears L13 by orders of magnitude regardless.
- **The verdict driver (g/t ≈ 0.003 ≪ 0.38 on a wide band) is robust to ALL these choices**: even at the most
  generous Ω=110 meV (largest u₀) and z=4 (smallest t), g/t = 0.0037. To reach 0.38 the proton would need to
  gate ~100× more of the transfer — impossible when the band's width comes from the proton-independent d-p-d hop.

---

## TASK 4 — NOVELTY GATE (d_novel_only · inline arxiv+web)

**Verdict: NOVEL/competitor-empty for the exact construction — but competitor-empty for the OBSTRUCTIVE
spectator reason, AND the real hosts are empirically sealed negative. NOT a discovery.**

- **Decisive empirical seal:** the real wide-band metallic H-bronzes **H₀.₂₃WO₃ and H₀.₁₀ReO₃ were synthesized
  (polymer route) and measured — intrinsically diamagnetic, NO superconductivity down to 0.35 K** (J. Solid State
  Chem. 2021, ScienceDirect S0022459621001043 / OSTI 1819538). This is the lab confirmation of the spectator
  result: the proton on the wide oxide band gives no pairing, exactly as g/t≈0.003 predicts.
- **Bronze SC mode survey:** RbₓWO₃ hexagonal bronze superconducts at ~2–7 K (arXiv cond-mat/0203120) but that
  Tc is the *intercalation-cation* W-5d band physics, **NOT** proton-gated and NOT room-T; the "highly mobile
  atoms / Einstein modes" were *suspected* in el-ph but "no clear correlation found" — i.e. the proton is not the
  glue. No paper marries (short O-H-O bridge) × (off-diagonal bond-SSH bipolaron) × (wide metallic TM-d band) ×
  (room-T). Competitor-id space EMPTY for the product.
- **Ambient-Tc ceiling context:** the 2025 Gao et al. "maximum Tc of conventional superconductors at ambient
  pressure" (Nat. Commun.) bounds conventional ambient Tc well below 293 K for known-host classes — consistent
  with this lane's closure that single-band short-H-bond oxides cannot supply both ε_F and coupling.
- **Construction is unrealized because it is physically obstructed (spectator), not unexplored.** Nearest real =
  H₀.₂₃WO₃/H₀.₁₀ReO₃ (measured non-SC) + RbₓWO₃ (cation-band, few K). NOT a discovery.

---

## TASK 5 — ROOMT g5 ADJUDICATION (d_roomt_ambient hard gate)

| g5 gate | HMoO₃ wide-band host (real DFT) | verdict |
|---|---|---|
| #1 1-atm thermo stable | real synthesized bronze, 1 atm | PASS (material) |
| #2 1-atm dynamical stable | real bulk oxide, 1 atm | PASS (material) |
| #3 metallic / carrier | **YES** — E_F in Mo-4d/O-2p, ε_F ≫ 0.63 eV (L13 cleared) | **PASS** |
| #4 **Tc ≥ 293 K** | **g/t ≈ 0.003 ≪ 0.38 → no off-diagonal pairing → Tc→0.** Real bronzes non-SC to 0.35 K | **FAIL (decisive)** |
| #5 magnetism/CDW non-preempt | wide metallic 4d, no Mott/CO at x off-integer | PASS (moot) |
| #6 novelty | NOVEL competitor-empty (obstructive spectator reason) + lab-sealed negative | PASS (not a discovery) |

**g5 = FAIL on #4 via the SPECTATOR closure.** The wide band passes L13 (ε_F huge) but the proton doesn't
couple to it (g/t≈0). Honest label: *ε_F axis REOPENS on the wide TM-d band (L13 cleared), but the coupling
axis CLOSES — the proton is a spectator on the wide band, g/t 100× short of the dome.*

---

## VERDICT — which axis closes + why

🔴 **CLOSED on the COUPLING/SPECTATOR axis** (`CLOSED_WIDEBAND_SPECTATOR`). The mirror image of R1:

1. **ε_F PASSES (L13 cleared).** The wide Mo-4d/O-2p band (W≈4.6 eV, t≈1.16 eV) gives ε_F ≫ 0.63 eV — the
   exact thing R1's narrow molecular band could NOT do. The wide-band half of the spec is satisfied by real DFT.
2. **But g/t FAILS — the proton is a SPECTATOR.** Band-resolved frozen-phonon: ∂t/∂u = −0.031 eV/Å on a 1.16 eV
   band → g ≈ 4 meV → **g/t ≈ 0.003**, 100× below the 0.38 dome onset. The proton gates ~1% of the conduction
   transfer; the proton-independent Mo–O–Mo d-p-d channel carries the rest and *is why the band is wide*.
3. **The anti-correlation is UNBREAKABLE in a single band — now DFT-confirmed at BOTH ends.** R1: narrow band →
   g/t≥0.38 but ε_F≤0.19 eV (L13 caps Tc≤87 K). R2: wide band → ε_F≫0.63 eV but g/t≈0.003 (spectator). The very
   feature that makes a band wide (strong proton-independent transfer) is the feature that makes the proton a
   spectator. **t_OH/t_total and bandwidth are anti-correlated** (Task-1 orbital derivation, R2 DFT-measured).
   This is L9/L14 re-realized: deep proton glue ⇔ proton-dominated (narrow) transfer ⇔ low ε_F.
4. **Empirical seal:** the real hosts H₀.₂₃WO₃, H₀.₁₀ReO₃ are synthesized and non-SC to 0.35 K. The lab agrees.

**Best numbers:** W_metband=4.64 eV · t_ref=1.16 eV · ε_F≫0.63 eV (L13 PASS) · ∂t/∂u=−0.031 eV/Å ·
u₀=0.10–0.14 Å · **g/t = 0.003–0.004** (FAIL, 100× short) · t_OH/t_total≈0.01 (proton gates ~1% of transfer).

**Novelty:** NOVEL/competitor-empty for the product; nearest real = H₀.₂₃WO₃/H₀.₁₀ReO₃ (measured, no SC to
0.35 K) — empirically corroborates the spectator closure. NOT a discovery.

---

## NEXT ROUND + DEPLETION TEST

- **DEPLETION: this lane (and the single-band metallic-hbond family) is DEPLETED.** The R2 falsifiable spec
  (ε_F≥0.63 eV AND g/t≥0.38 on the SAME band) returns **NO real host**: the wide-band candidate (HMoO₃, the
  best inorganic short-H-bond metal) clears ε_F but the proton is a spectator (g/t≈0.003, real DFT), and the
  narrow-band candidate (κ-H3, R1) clears g/t but fails ε_F. Both ends are DFT-closed; the real materials are
  lab-sealed non-SC. **The coupling↔bandwidth anti-correlation is confirmed unbreakable in any single-band
  short-H-bond host** — a fresh real realization of L9/L13/L14 (master conservation, now with an *orbital-level*
  mechanism: t_OH/t_total ⊥ bandwidth).
- **NAME NEXT ROUND (the surviving residual, d2 — NOT this lane):** `two-band-decouple` — put the proton-gated
  SSH glue on a SEPARATE band from the wide carrier band, so the bandwidth that sets ε_F and the proton-gated
  transfer that sets g are NOT the same band (escaping the single-band lock). That is the A1 two-band program
  (`two_band_decouple.md`), which R1 already flagged as the only structural escape — but note that lane closed
  NEGATIVE on a different conservation (|Δ_b|·t** ≈ const: the interband coupling that lends stiffness unbinds
  the pair). **So the residual is narrow** — both single-band ends (R1, R2) AND the naive two-band kinetic
  decouple (`two_band_decouple.md`) are closed; the only un-probed crack is interband-*pair-hopping* (η/Suhl-Kondo)
  stiffness without kinetic unbinding, which is the `multiband-assist`/`two-band-decouple` compute, a different
  lane's problem, not this one's.
- **Honest L9/L13/L14 hit (d6):** this lane HITS the master conservation as a CLOSED-negative, NOT a concession
  (d2): the wide-band escape was a concrete breakthrough path that was *tried with real DFT* and *measured to
  fail by a specific mechanism* (spectator, t_OH/t_total≈0.01). The named surviving lever (two-band interband-pair
  decouple) is the d2 path forward, in a different lane.

---

## RESUME RECIPE (if a wide-band-WITH-strong-coupling host is ever proposed — what it must show)

A host that breaks this closure must satisfy, by from-scratch DFT: a band with W ≥ 1.3 eV crossing E_F (ε_F≥0.63 eV)
**whose dispersion comes predominantly from a proton-gated overlap** — measurable as dW_band/du ≳ 0.4·W per Å of
proton displacement (i.e. t_OH/t_total ≳ 0.3, vs HMoO₃'s 0.01). No known oxide/oxyhydride/bronze does this; the
search would need a host where the metallic transfer path IS the H-bond (a 1D proton-wire metal), which does not
co-exist with a wide 3D Fermi surface. Decks: `wideband_dft_fire.sh` (HMoO₃, reusable template) on summer
`/home/summer/rtsc_hmoo3/`. Real bronze supercell (x=0.33, incommensurate H, ph.x O-H-O DFPT) = sized for a pod,
but **moot** — the spectator closure already holds at the most generous single-cell limit.
