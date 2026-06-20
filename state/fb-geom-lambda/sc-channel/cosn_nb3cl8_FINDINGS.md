# SC-channel verification — CoSn & Nb3Cl8 (FB-GEOM-LAMBDA)

> 🎯 The flat-band geometric-stiffness route gives high ⟨g⟩ / high BKT-Tc projections
> (CoSn 128K, Nb3Cl8 99K), but those Tc projections assume a *mobile* SC condensate.
> Both materials are NON-SC today. This file verifies HONESTLY (d6, c2) whether a
> bond-Peierls (off-diagonal, ∂t/∂u) bipolaron SC channel can physically exist, and
> WHY it is absent today — and whether high-⟨g⟩ flat-band localization is *self-defeating*.

verified: 2026-06-19 · method: WebSearch (arxiv/Nature/PRL/PRR) + physics reasoning · NO pod/compute.

---

## CRUX (read first)

The FB-GEOM ⟨g⟩ projection rewards flat-band localization (high DOS, large ∂t/∂u). The
question is whether that *same* localization that boosts ⟨g⟩ also pins the pairs in place
and kills the condensate. The answer is **mechanism-dependent**, and this is the honest split:

- **Holstein (on-site, diagonal) e-ph in a flat band → SELF-DEFEATING.** Strong on-site
  coupling at flat-band DOS gives exponentially heavy polaron/bipolaron mass → immobile →
  no superfluid stiffness. High ⟨g⟩ here = a self-trapped CDW/Peierls insulator, not SC.
- **Bond-SSH/Peierls (off-diagonal, ∂t/∂u) e-ph → NOT automatically self-defeating.**
  The pair binds by *kinetic-energy* (coherent pair-hopping between bonds), so it stays
  **light** even at strong coupling [PRL 121.247001; arXiv:1805.06109; arXiv:2605.16625].
  This is the one channel that can give a *mobile* condensate out of a flat band — it is
  exactly the right channel for FB-GEOM. BUT it carries two hard conditions (below) that
  CoSn and Nb3Cl8 each fail differently.

The two hard conditions for the bond-Peierls channel to actually condense:
1. **Antiadiabaticity:** peak Tc at t/Ω ≈ 1–2 (phonon ≳ effective bandwidth). In a *too*-flat
   band the bare bandwidth → 0, so t/Ω can be fine — but then carriers must reach the band.
2. **Carriers must be AT E_F and itinerant** (the flat band must be partially filled and
   *not* gapped by Mott/CDW). A bond-SSH bipolaron still needs a host band to live in; a
   Mott gap or a fully-off-E_F flat band leaves it with no carriers to pair.

→ For BOTH materials the verdict turns on condition (2), not on the ⟨g⟩ value. The ⟨g⟩ is
real; the *carriers* are missing. That is a doping/pressure problem (tunable), NOT a
fundamental block of the bond-Peierls mechanism. Hence both verdicts below are **UNKNOWN /
PLAUSIBLE-via-named-route**, not BLOCKED — with one important asymmetry (Nb3Cl8's gap is
the more stubborn obstacle).

---

## CoSn — kagome Pauli paramagnet

### 1. Why non-SC today
- **No SC down to 0.1 K, no phase transition to 0.4 K** in pure CoSn at ambient pressure
  [arXiv:2102.08979, Sales et al.]. It is a **Pauli paramagnet** with textbook kagome bands.
- **The flat band sits ~80–100 meV BELOW E_F** [arXiv:2102.08979]. So the high-DOS flat
  band — the thing FB-GEOM exploits for ⟨g⟩ — is *not at the Fermi level*. E_F sits on the
  dispersive bands; the flat-band carriers are filled/inert and do not participate in
  pairing. This is the dominant reason there is no SC: **the pairing-active DOS is off E_F.**
- CoSn does have real, strong e-ph coupling to kagome phonons (giant fermion-boson
  interaction reported), but with the flat band off E_F there is no large DOS at E_F to
  convert that coupling into a pairing instability. The itinerant paramagnetism is weak
  (Pauli), so unlike FeSn/Co3Sn2S2 it is *not* an intrinsic-magnetism block — it is a
  band-alignment + weak-glue-at-E_F block.

### 2. Known route to induce SC
- **Hole doping (Fe, In) shifts the flat band UP toward E_F** (rigid-band) [arXiv:2102.08979].
  This is the canonical, published lever to bring the high-DOS flat band to the Fermi level.
- ⚠ **But the published attempt found a trap:** Fe and In doping *also drive CoSn toward
  magnetism* — Fe-doped Co(1-x)Fe(x)Sn (0.02<x<0.27) forms a **spin glass**. So the naive
  "dope to put the flat band at E_F" route induces magnetic order/disorder that competes with
  SC instead of producing it. Ni doping suppresses magnetism but is *electron* doping → moves
  the flat band *further from* E_F (wrong way). No published report of SC in any doped CoSn.
- No pressure-induced SC reported for CoSn (search returns none; pressure not the studied lever).
- Theory predicts *other* 1:1 MSn kagome metals (M = Mo, Hf, Nb, Ta, W, Ti) are intrinsic
  SC + topological [arXiv:2605.24822] — i.e. the kagome lattice CAN host SC, but CoSn
  specifically is on the wrong (magnetism-prone, flat-band-off-E_F) side.

### 3. Does the bond-Peierls channel survive?
- **The mechanism is not fundamentally blocked, but it has no carriers to act on today.**
  The bond-SSH bipolaron stays light (kinetic-energy binding) and would in principle give a
  mobile condensate even from a flat band [arXiv:1805.06109; 2605.16625] — so flat-band
  localization is NOT self-defeating for *this* channel in CoSn. The problem is upstream of
  the mechanism: the flat band is 80–100 meV off E_F, so there is no partially-filled flat
  band for the bipolarons to form in.
- The honest tension: the *only* way to put the flat band at E_F (hole doping) is the *same*
  knob that triggers spin-glass magnetism. So the realistic obstacle for CoSn is **a magnetic
  instability that pre-empts the flat band at E_F**, not self-trapping. If a hole-doping route
  could reach the flat band at E_F *without* tipping into spin-glass (e.g. isovalent chemical
  pressure, gating a thin flake rather than chemical substitution), the bond-Peierls channel
  has a clean shot.

### 4. Verdict — CoSn
- **SC-channel = UNKNOWN (leaning PLAUSIBLE-via-gating).** Not BLOCKED: the bond-Peierls
  bipolaron is mobile-by-construction and flat-band localization is not self-defeating here.
  The block today is band alignment (flat band off E_F) + a magnetic competitor that the
  obvious chemical-doping lever triggers.
- **Deciding experiment / calc:** *Electrostatic gating of a CoSn thin flake* (or isovalent
  chemical-pressure tuning) to sweep E_F onto the flat band **without chemical substitution**,
  i.e. add carriers without adding magnetic Fe/In sites. Measure (a) does the flat band reach
  E_F, (b) does magnetism appear first, (c) does a SC transition emerge. In silico: a
  rigid-band + DFPT λ(E_F) scan as the flat band crosses E_F, plus a Stoner check at each
  filling to see whether the magnetic instability pre-empts the SC instability. If magnetism
  always wins before the flat band reaches E_F → flips to BLOCKED-by-magnetism. If a window
  exists where flat-band-at-E_F precedes magnetic order → PLAUSIBLE confirmed.

---

## Nb3Cl8 — breathing-kagome cluster-Mott insulator

### 1. Why non-SC today
- Nb trimerization opens a **single half-filled isolated flat band at E_F**, which the
  on-site Hubbard U then **splits into a Mott gap of ~1.5–1.6 eV** [npj Quantum Materials
  s41535-024-00619-5; arXiv:2408.00145]. So unlike CoSn, the flat band IS at E_F — but it is
  **Mott-localized**: one electron per Nb3 trimer cluster, frozen by U. **No itinerant
  carriers** → insulator, no SC.
- Below ~100 K a structural transition (layer dimerization) takes it to a **non-magnetic
  singlet** (spin-paired trimers) [arXiv:2503.12903 NMR; 2408.00145]. So at low T it is a
  band/singlet insulator; strong local AFM correlations suppress susceptibility above the
  transition. Either way the half-filled flat band is gapped — this is the deepest block:
  **the high-⟨g⟩ flat band is the SAME band that is Mott-gapped.**
- This is the textbook self-defeating worry made concrete: the flat band that gives huge DOS
  / huge ⟨g⟩ is exactly the band whose narrowness made U/W ≫ 1, opening the Mott gap.
  **Flat-band localization here IS doing the localizing.**

### 2. Known route to induce SC
- **Pressure:** Mott state suppressed gradually; **fully metallic only above ~70 GPa** with a
  structural transition + band reconstruction [Materials Today Physics 38, 101267 (2023)].
  **But: NO SC observed down to 1.5 K up to ~100 GPa** in Nb3Cl8 itself. And the Mott state
  is *resilient* — survives high pressure / local symmetry breaking [arXiv:2507.07624]. So
  the obvious "squeeze it metallic" route metallizes but does NOT superconduct (so far).
- **Family analogue — STRONG positive precedent:** sibling *cluster*-Mott insulators
  GaNb4Se8 and GaTa4Se8 (same physics: one S=1/2 electron hopping among widely separated
  metal clusters) **DO become SC under pressure** — Tc = 2.9 K @ 13 GPa and 5.8 K @ 11.5 GPa,
  driven by **softening of the M–Se bond phonon** as cluster distortion is relieved
  [JACS 10.1021/ja050243x; Abd-Elmeguid PRL]. GaTa4Se8 even shows pressure-induced
  *topological* SC [npj QM s41535-020-0246-0]. And **Ge-doping** GaNb4Se8 gives a possible
  **Tc ≈ 45 K** onset (zero resistance) — SC from *electron doping* a cluster-Mott insulator
  [arXiv:2510.12452, 2025]. → The cluster-Mott → SC transition is a REAL, published pathway
  for this material *family*; the SC there is bond-phonon driven, which is precisely the
  bond-Peierls / off-diagonal ∂t/∂u channel FB-GEOM targets.

### 3. Does the bond-Peierls channel survive?
- **The mechanism is alive in the family, and the SC glue in GaNb4Se8/GaTa4Se8 is literally
  a bond-phonon (M–Se bond softening)** — i.e. off-diagonal el-ph. That is direct empirical
  evidence that a bond-Peierls-type channel can survive cluster-Mott physics and condense,
  AS LONG AS carriers are liberated (Mott gap closed by pressure/doping bandwidth control).
- **For Nb3Cl8 specifically, the obstacle is sharper than the family average:** its Mott gap
  is large (~1.5 eV) and *resilient* — pressure to 100 GPa metallizes the band but **the Mott
  correlations persist and SC has not appeared**. So the same flat-band narrowness that gives
  high ⟨g⟩ also gives the largest, most stubborn U/W, and simple compression has not yet
  produced a mobile pair condensate. This is the honest worst case for "self-defeating":
  **in Nb3Cl8 the localization is winning the tug-of-war against mobility harder than in its
  SC siblings.** Bandwidth control (pressure alone) is insufficient *for Nb3Cl8 as measured*.
- The escape is *filling control* (doping the half-filled trimer off n=1), which is what put
  Tc≈45K into Ge-doped GaNb4Se8. Doping Nb3Cl8 away from the half-filled trimer would move it
  off the Mott point and give itinerant carriers in the high-⟨g⟩ band → the bond-Peierls
  channel would then have both the glue (bond phonons) and the carriers. **Untested for
  Nb3Cl8.** So the channel is plausibly survivable by *doping*, not by pressure alone.

### 4. Verdict — Nb3Cl8
- **SC-channel = UNKNOWN (leaning PLAUSIBLE-via-doping; BLOCKED-via-pressure-alone).**
  - Pressure-alone route: effectively BLOCKED as measured (metallizes @70 GPa, but resilient
    Mott + no SC to 100 GPa / 1.5 K). The flat-band localization is genuinely self-defeating
    against the *pressure* lever.
  - Doping route (off half-filling): PLAUSIBLE and *family-validated* — GaNb4Se8/GaTa4Se8
    (bond-phonon SC under pressure) and Ge-doped GaNb4Se8 (Tc≈45K) prove a cluster-Mott flat
    band CAN host bond-phonon SC once carriers are liberated. Not yet tried on Nb3Cl8.
- **Deciding experiment / calc:** *Electron/hole-dope Nb3Cl8 off the half-filled trimer*
  (Ge-style chemical doping, intercalation, or ionic-liquid gating of a monolayer) and check
  for a metal→SC transition — directly mirroring the Ge-doped GaNb4Se8 result. In silico:
  DFT+U (or DFT+DMFT) at fractional trimer filling to confirm the Mott gap collapses and the
  flat band becomes itinerant at E_F, then DFPT of the bond-modulating (breathing-kagome /
  trimer-stretch) phonon to get the off-diagonal ∂t/∂u λ at that filling. If the gap stays
  open or λ_bond is negligible at all reachable fillings → flips to BLOCKED. If a filling
  exists with itinerant high-DOS flat band + finite bond-phonon λ → PLAUSIBLE confirmed.

---

## Summary table

| Material | Why non-SC today | Induce-SC route (published) | Bond-Peierls channel survives? | Verdict |
|---|---|---|---|---|
| **CoSn** | Flat band 80–100 meV BELOW E_F (carriers not at flat band); weak Pauli glue at E_F; hole-doping to reach flat band triggers spin glass | Hole-dope (Fe/In) shifts flat band to E_F [2102.08979] — but induces magnetism (spin glass); **no SC reported** in any doped CoSn | YES in principle (light kinetic-energy bipolaron, not self-trapped) — but **no carriers in flat band today**; obstacle is band alignment + magnetic competitor, not self-trapping | **UNKNOWN → PLAUSIBLE-via-gating.** Decide: gate a flake to sweep E_F onto flat band w/o chemical substitution; Stoner-vs-SC race per filling |
| **Nb3Cl8** | Half-filled trimer flat band Mott-gapped (~1.5 eV); same flat-band narrowness that gives high ⟨g⟩ opens the resilient Mott gap → no itinerant carriers | Pressure metallizes @~70 GPa but **no SC to 100 GPa/1.5 K**, Mott resilient. Family analogues SC: GaNb4Se8 2.9K/GaTa4Se8 5.8K under P (bond-phonon glue); Ge-doped GaNb4Se8 Tc≈45K | Mechanism alive in family (SC glue IS the M-bond phonon = off-diagonal el-ph) — but in Nb3Cl8 localization beats the *pressure* lever (self-defeating vs P). Survives plausibly only via **doping off half-filling** (untested) | **UNKNOWN. Pressure-alone ≈ BLOCKED (measured). Doping ≈ PLAUSIBLE (family-validated, untested on Nb3Cl8).** Decide: Ge-style dope off n=1 → DFT+U gap collapse + DFPT bond-phonon λ; look for metal→SC |

## Honest bottom line (no overclaim)
- **High ⟨g⟩ from flat-band localization is NOT automatically self-defeating** — IF the channel
  is the off-diagonal bond-Peierls one (kinetic-energy-bound, light bipolaron). That is the
  whole point of choosing the ∂t/∂u channel over Holstein, and it is the correct physics for
  FB-GEOM. The bond-phonon SC seen in GaNb4Se8/GaTa4Se8 is empirical proof the channel can
  condense out of cluster-flat-band physics.
- **BUT in both candidates the carriers are missing at the flat band today**, for different
  reasons (CoSn: flat band off E_F + magnetic doping trap; Nb3Cl8: flat band Mott-gapped,
  resilient against pressure). **Neither is a verified SC; neither's SC channel is verified
  open.** The ⟨g⟩ value alone does NOT establish a mobile condensate — it establishes only
  the glue strength, not that there are carriers to glue.
- **Neither material is a confirmed FB-GEOM SC at this gate.** Both are **UNKNOWN with a named,
  testable route** (CoSn: gate flat band to E_F sans magnetism; Nb3Cl8: dope off the
  half-filled trimer), and Nb3Cl8's pressure-alone route is empirically near-BLOCKED. Honest
  status: candidates are NOT rejected, NOT confirmed — they are gated on a carrier-liberation
  experiment that has not been done. Do not report 128K/99K as established SC Tc; they are
  glue-side projections contingent on an unverified carrier channel.

## Sources
- CoSn flat band / doping / spin glass: arXiv:2102.08979 (Sales et al., "Tuning the flat bands of the kagome metal CoSn with Fe, In, or Ni doping")
- CoSn no SC to 0.1 K: same + osti.gov/2324792
- 1:1 MSn kagome SC prediction (CoSn on wrong side): arXiv:2605.24822
- Nb3Cl8 Mott / flat band / gap: npj Quantum Materials s41535-024-00619-5; arXiv:2408.00145
- Nb3Cl8 pressure metallization (no SC to 100 GPa): Materials Today Physics 38, 101267 (2023), ScienceDirect S2542529323003036
- Nb3Cl8 resilient Mott under pressure: arXiv:2507.07624
- Nb3Cl8 NMR / AFM fluctuations / structural transition: arXiv:2503.12903
- Cluster-Mott → SC family (bond-phonon glue): JACS 10.1021/ja050243x; Abd-Elmeguid PRL (PubMed 15447289); npj QM s41535-020-0246-0 (GaTa4Se8 topological SC)
- Ge-doped GaNb4Se8 Tc≈45K: arXiv:2510.12452
- Light bond-SSH/Peierls bipolarons (mobile, kinetic-binding): PRL 121.247001 / arXiv:1805.06109; arXiv:2605.16625 (perspective); arXiv:2407.10444 (bond bipolaron superfluid 2D BKT)
- SSH self-trapping / antiadiabatic condition: arXiv:1703.01696 (Nature Sci Rep s41598-017-01228-y)
- Flat-band SC quantum geometry (superfluid weight from geometry): Nature s41586-022-05576-2; arXiv:2403.04270
