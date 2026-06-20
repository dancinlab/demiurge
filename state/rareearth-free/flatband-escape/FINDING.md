# FLAT-BAND ORBITAL UN-QUENCHING — L20 RE-free magnet escape probe

GOAL (L20): test whether an E_F-tuned flat-band 3d-only lattice (kagome/CoSn-type, W→0)
un-quenches the orbital moment so MAE rises toward RE-class WITHOUT 4f.
FALSIFIER (pre-registered, d6): does ANY flat-band 3d-only lattice yield DFT
magnetocrystalline K1 >= 3 MJ/m^3 WITH a restored (un-quenched) orbital moment <L>?
3 MJ/m^3 = threshold between MnBi-tier (uninteresting) and approaching Nd2Fe14B (4.9).

================================================================================
(1) NOVELTY VERDICT (d18 / d_novel_only — run INLINE, FIRST)  →  PUBLISHED (low-K1)
================================================================================
The flat-band-PMA mechanism in a 3d-only kagome magnet is PUBLISHED, and crucially
it is published at LOW anisotropy — well below the falsifier threshold:

  PRIMARY: Ishida et al., "Room-temperature perpendicular-anisotropic ferrimagnet
  Co3Mo mediated by cobalt-kagome flat band," Communications Materials (2026)
  doi:10.1038/s43246-026-01131-y
    - Co3Mo (D0_19-type, Co-kagome), Co-kagome flat bands sit near E_F.
    - Mechanism stated VERBATIM: "magnetocrystalline anisotropy via spin-orbit
      interaction" arising from "interplay between ORBITAL MOMENTS and quadrupole
      moments of Co 3d electrons" — i.e. EXACTLY the L20 orbital-moment hypothesis,
      already proposed and measured.
    - REPORTED ANISOTROPY: Kueff ~= 2e5 J/m^3 = 0.2 MJ/m^3 (x=0.17, 300 K).
      Authors note this is "one order of magnitude SMALLER than the largest Kueff
      of 7e6 J/m^3 [7 MJ/m^3] for FePt bulk."
    - Ms ~= 2.1 uB / 2 f.u.;  anisotropy field mu0*HA ~= 1.2 T; Pt-substitution
      (Co3Mo1-xPtx) enhances PMA via 5d(Pt) SOC — i.e. the boost comes from ADDING
      a heavy 5d SOC center, NOT from 3d orbital un-quenching alone.

  SUPPORTING (orbital-moment-on-flat-band, all 3d-only, all SUB-threshold or non-FM):
    - Meier/Yin et al., "Flat-Band-Induced Anomalous Anisotropic Charge Transport
      and Orbital Magnetism in Kagome Metal CoSn," PRL 128, 096601 (2022) — CoSn
      flat-band orbital magnetism, but CoSn is PARAMAGNETIC (no FM order; no K1).
    - Fe3Sn2 strain-engineered MAE, ACS Nano (2025) doi:10.1021/acsnano.4c16603 —
      SOC-driven MAE enhanced by strain but stays small-moment kagome FM; no >=3
      MJ/m^3 K1 claim.
    - Co3Sn2S2 (arXiv:2508.11140) — Berry-curvature orbital magnetization on the
      topological flat band; orbital > spin contribution reported, but this is a
      transport/Berry orbital magnetization, NOT a >=3 MJ/m^3 magnetocrystalline K1.
    - Mn-kagome metals (Nat. Commun. 2024, s41467-024-49674-3) — flat bands +
      FM fluctuations via orbital-selective correlations; no RE-class K1.

  VERDICT: PUBLISHED — the flat-band 3d orbital-moment-PMA idea is NOT novel
  (Co3Mo 2026 owns it), AND it is published at 0.2 MJ/m^3, ~15x below the 3 MJ/m^3
  falsifier line and even below the 1-2 MJ/m^3 MnBi-tier. No group reports a
  flat-band 3d-only K1 >= 3 MJ/m^3 with a restored <L>. The literature already
  answers the falsifier in the NEGATIVE direction.

================================================================================
(2) CANDIDATE + DECK + d16 DRY-RUN
================================================================================
Candidate chosen (most tractable, RT-PMA, published flat band): Co3Mo (D0_19, hP8,
6 Co + 2 Mo). Deck staged via `hexa deck` (d_deck_always):
  exports/material/decks/co3mo_mae/  (POSCAR/xyz/cif geometry only)

d16 FREE dry-run RESULT (the deciding infrastructure fact):
  - `hexa deck material ...` is an HONEST TODO STUB — emits geometry (POSCAR/cif/xyz)
    but NO SCF/MAE runbook (empty lattice, no run.sh). The MAE deck (noncollinear
    SOC, two-orientation E(001)-E(100), force-theorem or self-consistent SOC) has
    NO builder in this repo.
  - ENGINE GAP (decisive): magnetocrystalline anisotropy energy = E(001)-E(100)
    requires NONCOLLINEAR SPIN-ORBIT self-consistent DFT. QFORGE (hexa-native)
    has NO SOC / NO noncollinear / NO MAE path anywhere in stdlib — grep confirms
    the only SOC mentions are comments "we do NOT add SOC" (pb_fcc_elph_xval).
    QFORGE mode (d) nspin=2 moment SCF is itself COMPUTE-WALLED for TM-3d PW cost
    (memory: qforge-cosn-co3d-pw-compute-wall). So the falsifier quantity cannot
    be produced QFORGE-native, and thus cannot be routed to summer GPU davidson
    (the davidson hot-path has no noncollinear-SOC MAE assembler to accelerate).
  - summer (RTX 5070, free) has hexa installed but NO QE binary (no pw.x) and only
    a Si pseudopotential — no noncollinear Co/Mo FR pseudos. `use free` forbids
    renting a vast/runpod GPU pod, which is the only path that could host a
    noncollinear-SOC Co-3d MAE run.

================================================================================
(3) K1 + <L> NUMBERS
================================================================================
  - COMPUTED in-house this round: NONE (compute-blocked, see above — honest, d6;
    no fabricated K1, no tune-to-green).
  - PUBLISHED anchor (the real, citable number that settles the falsifier):
    Co3Mo flat-band Kueff = 0.2 MJ/m^3 (Comm. Mater. 2026). Orbital moment is
    invoked as the mechanism but NOT restored to RE-class magnitude — the PMA
    boost in Co3Mo1-xPtx comes from adding 5d(Pt) SOC, confirming the bare 3d
    orbital moment stays effectively quenched at the MAE level.

================================================================================
(4) VERDICT:  CLOSED-NEGATIVE  (deciding number: 0.2 MJ/m^3 << 3 MJ/m^3)
================================================================================
The single un-depleted physics escape (flat-band orbital un-quenching) does NOT
break the RE-free magnet P1 anisotropy ceiling:
  - The best-published flat-band 3d-only magnet (Co3Mo, RT, the very candidate the
    brief named) delivers Kueff = 0.2 MJ/m^3 — 15x below the 3 MJ/m^3 falsifier and
    below even MnBi-tier (1-2). Flat-band W->0 alone does NOT un-quench <L> enough
    to lift K1 to RE-class; where Co-kagome PMA IS enhanced, the lever is heavy-5d
    SOC doping (Pt), i.e. NOT a 4f-free, 3d-only escape.
  - Secondary support: CoSn flat-band orbital magnetism exists but is paramagnetic
    (no K1); Fe3Sn2/Mn-kagome stay small-moment, sub-threshold.
  - In-house DFT confirmation is COMPUTE-BLOCKED honestly: no SOC/noncollinear MAE
    engine (QFORGE-native absent + QE not installed on summer + Co-3d PW wall + 2x
    noncollinear cost), and `use free` forbids the GPU-pod that could host it. The
    compute wall is real BUT does not change the verdict — the published 0.2 MJ/m^3
    already decides the falsifier in the negative.

  => L20 escape CLOSED-NEGATIVE. The 3d ligand-field-quenched-orbital MAE ceiling
     (~1-2 MJ/m^3) stands as a TRUE physics wall for 4f-free magnets; flat-band
     un-quenching is ruled out as the escape. RAREEARTH-FREE magnet P1 stamped HARD.
  (Sub-classification: published-negative + compute-blocked-confirmation. NOT a
   WALL-BROKEN. The deciding evidence is literature, not a fabricated DFT number.)

================================================================================
NEXT ROUND + DEPLETION TEST
================================================================================
NEXT-ROUND candidate (if a future round wants the in-house DFT confirmation despite
the published negative):
  - If a free SOC-MAE engine appears: smallest viable cell = CoSn (hP6, kagome,
    fewer 3d than Co3Mo's 6 Co) for a force-theorem MAE on summer; route the
    noncollinear two-orientation SCF only AFTER a free QE/elk install + FR pseudos.
  - Heavy-SOC-doped angle (Co3Mo1-xPtx) is OUTSIDE L20 scope (it is 5d, not 3d-only)
    and is therefore NOT a valid escape candidate — note for any follow-up.

DEPLETION TEST for the RE-free magnet P1 anisotropy ceiling:
  CEILING STANDS / fully depleted when ALL of:
    (a) flat-band 3d-only un-quenching  -> CLOSED-NEGATIVE  [THIS ROUND, done]
    (b) Has any OTHER named 4f-free physics lever (interstitial-N D0_19, strain,
        epitaxial tetragonal distortion, high-entropy 3d alloying) been shown to
        exceed 3 MJ/m^3 at RT in DFT+experiment?  -> if all NO, P1 ceiling is a
        depleted TRUE wall for 3d-only magnets.
  This round closes lever (a). Lever (b) survey = the next depletion probe.

ARTIFACTS:
  - this file
  - exports/material/decks/co3mo_mae/ (geometry deck; MAE runbook = engine-absent)
  - verdict JSON: state/rareearth-free/flatband-escape/verdict.json
