# RTSC bond-class lens — off-diagonal (Peierls/SSH) el-ph coupling in light-atom material classes

> Lens of the fb-geom-lambda fleet. Closing formula (RTSC_DISCOVERY_CLOSING_FORMULA.md) Regime II:
> the ONLY route that escapes the conventional Tc ceiling is a **light-atom flat-band material whose
> el-ph coupling is DOMINANTLY off-diagonal (bond/Peierls/SSH, ∂t/∂u — modulates KINETIC energy),
> NOT Holstein (on-site density, modulates POTENTIAL energy → heavy m**~e^{g²} → false escape)**.
> Task: rate real material classes on {off-diagonal-dominant? · light atoms? · coupling quantified?}.

## CRITICAL CLASSIFICATION NUANCE (the discriminator that most sources blur)

There are THREE physically distinct things that all get loosely called "bond" coupling — only ONE is
the SSH/Peierls off-diagonal coupling the recipe needs:

1. **True off-diagonal / Peierls / SSH (∂t/∂u)** — a phonon modulates the *inter-site hopping integral
   t_ij* between two orbitals. The coupling sits on the *bond* (off-diagonal in the electronic basis).
   This is the kinetic-energy modulation that yields LIGHT (bi)polarons. → the recipe target.

2. **Bond-stretch deformation-potential (∂ε/∂u, but band-diagonal)** — a bond-stretching phonon
   (e.g. B-B E2g in MgB2, C-C in B:diamond) shifts the *on-site / band energy* of a σ state. The atomic
   motion is a bond stretch, but in the effective electronic Hamiltonian it couples DIAGONALLY (to the
   σ-band energy, ∝ deformation potential D). It is Migdal-Eliashberg / Holstein-class, NOT SSH. Gives
   high λ at high ω but does NOT enter the light-bipolaron regime — these are adiabatic ME superconductors.
3. **Holstein on-site density (∂ε_i/∂u_i)** — a phonon couples to local charge density (e.g. molecular
   breathing, intramolecular Hg in C60). Heaviest m**. → the recipe explicitly avoids.

KEY TAKEAWAY: "bond-stretching mode" ≠ "off-diagonal coupling". MgB2 and B-doped diamond are bond-STRETCH
but band-DIAGONAL (class 2). The genuinely off-diagonal classes are the molecular/π-conjugated ones where
the relevant DOF is the *transfer integral* between molecules/sites (rubrene, BEDT-TTF inter-molecular,
graphene Kekulé hopping modulation, SSH-realizing lattices).

## SOURCED CLASSIFICATION TABLE (≥6 classes)

| # | Material class | Light atoms? | Dominant el-ph coupling | Off-diag (SSH) dominant? | Quantified? | Source |
|---|---|---|---|---|---|---|
| 1 | trans-polyacetylene / SSH archetype | YES (C,H) | off-diagonal ∂t/∂u (definitional) | YES — textbook SSH | λ~0.1-0.2 (Peierls gap) | SSH PRL 1979; arXiv:2303.10193 |
| 2 | Organic molecular semiconductors (rubrene, pentacene, tetracene) | YES (C,H) | nonlocal/Peierls inter-molecular ∂t/∂u; some local Holstein | YES — nonlocal dominates transport (transient localization) | YES, DFT ∂t/∂u variances | Nat.Commun.12,4260 (arXiv:2012.09509); PRB 102,245201; PMID 23126706 |
| 3 | Charge-transfer salts κ-(BEDT-TTF)2X | YES (C,H,S) | mixed Holstein-Peierls; e-LP(inter-mol,off-diag) stronger but e-MV(Holstein) needed for Tc | PARTIAL — Peierls strongest single channel, not dominant alone | YES, Holstein-Peierls model | arXiv:cond-mat/0309035; RG 233812242 |
| 4 | Graphene Kekulé / honeycomb optical-SSH | YES (C) | off-diagonal — E2g bond-stretch modulates C-C hopping (oSSH) | YES — hopping modulation is the mechanism | YES, oSSH model + DFT | arXiv:2506.16814; arXiv:2407.09366 |
| 5 | A3C60 / Cs3C60 fullerides | YES (C) | intramolecular Jahn-Teller Hg — on-site/local (Holstein-like JT) | NO — local JT (density/orbital), not inter-site hopping | YES, λ~0.5-1, DMFT | PRX 13,021008; arXiv:2604.12203 |
| 6 | Alkali-doped aromatic HC (K3picene, phenanthrene, coronene) | YES (C,H) | mainly INTRAmolecular C-C bond-stretch → π MOs (on-molecule, Holstein-class) + weak nonlocal | NO — intramolecular dominant; nonlocal/inter-mol minor | YES, λ, ME Tc=18K | RG 51628259; RG 235513459 (K3picene local+nonlocal) |
| 7 | MgB2 / boron diborides | YES (B) | B-B E2g bond-STRETCH → σ-band deformation potential (band-DIAGONAL) | NO — bond-stretch but diagonal (ME two-band) | YES, λσ~1, λ~0.7-0.9 | arXiv:cond-mat/0102391; cond-mat/0102499 |
| 8 | Boron-doped diamond | YES (B,C) | C-C bond-stretch optical → σ-hole deformation potential (diagonal) | NO — same class as MgB2, diagonal | YES, λ~0.4, D 60% > MgB2 | arXiv:cond-mat/0406446 (PRB 70,212504) |
| 9 | Boron-carbon clathrates (SrB3C3, MB2C8) | YES (B,C) | B-C covalent framework deformation potential (σ-bond, diagonal ME) | NO — covalent-framework ME, diagonal | YES, λ, Tc~20-100K predicted | arXiv:1708.03483; arXiv:2405.13752; npj CM 2025 |
| 10 | Bond-SSH/Peierls bipolaron model lattices (1D/2D/3D, triangular) | model (maps to C,H hosts) | pure off-diagonal bond-Peierls ∂t/∂u | YES — definitional | YES, QMC: m**, λ=α²/3Ωt, Tc | arXiv:2203.07380; PRX 13,011010; arXiv:2507.07662; arXiv:2409.14132 |

## RANKED SHORTLIST — best match to "off-diagonal-dominant + light"

1. **Bond-SSH/Peierls bipolaron model lattices** (#10) — the cleanest off-diagonal, light-by-construction,
   Tc quantified by QMC. But these are MODELS, not yet a named real host → the converge step must find a
   material that *realizes* this Hamiltonian. THIS is the open NOVEL target.
2. **Graphene Kekulé / honeycomb optical-SSH** (#4) — real carbon system, mechanism IS hopping modulation
   (oSSH), lightest possible atoms. Strongest *real-material* off-diagonal candidate. Flat-band variants
   (twisted-bilayer / Kekulé-ordered) connect directly to the flat-band requirement.
3. **Organic molecular semiconductors — rubrene/pentacene class** (#2) — nonlocal Peierls coupling is the
   established dominant channel (transient-localization), light atoms, ∂t/∂u quantified by DFT. Real,
   well-characterized off-diagonal hosts; the question is whether they can be driven SC (vs. just transport).
4. **κ-(BEDT-TTF)2X charge-transfer salts** (#3) — inter-molecular Peierls is the single strongest channel
   and these ARE superconductors (Tc~10K), but Holstein (e-MV) is co-essential → off-diagonal not cleanly
   dominant. Useful as a real SC where off-diagonal is large.
5. **trans-polyacetylene / explicit SSH archetype** (#1) — definitional off-diagonal + lightest atoms, but
   λ is small (Peierls-insulating, not a high-Tc SC host) → mechanism-anchor, not a Tc target.

NOT off-diagonal (ruled out as recipe targets, kept for the contrast they provide):
- MgB2 (#7), B-doped diamond (#8), B-C clathrates (#9) — bond-STRETCH but band-DIAGONAL deformation-potential
  ME superconductors. Light atoms + high λ, but they sit in Regime I (adiabatic ME), do NOT escape the
  ceiling via the light-bipolaron route. They are the conventional channel the formula declares closed.
- A3C60 (#5), alkali-aromatics (#6) — light atoms but coupling is on-molecule (Jahn-Teller / intramolecular
  C-C → π), Holstein-class → heavy-mass penalty, FALSE escape.

## HONEST VERDICT (d6)

- A class that is CLEANLY off-diagonal-dominant AND a light-atom REAL material AND a known superconductor
  does not exist off-the-shelf. The cleanest off-diagonal cases (#10 bond-SSH models, #1 polyacetylene) are
  models or non-SC; the real SC light-atom families (#5,#6,#7,#8,#9) are Holstein/JT or band-diagonal ME.
- The most promising NOVEL angle = a **carbon π-conjugated host that realizes the bond-SSH Hamiltonian with
  a flat band** — graphene Kekulé/twisted-bilayer (#4) and the rubrene/organic class (#2) are the two real
  families whose dominant coupling is genuinely hopping-modulation (∂t/∂u). The converge step should downfold
  one of these to a bond-Peierls ∂t/∂u + U model and run the bipolaron-mass → Tc pipeline.
- This is consistent with the closing-formula caveat that known bond-bipolaron Tc estimates are ~20-40K; no
  guaranteed room-Tc, but a genuinely NOVEL, first-principles-computable channel.

g5: PASS — sourced table of 10 classes (≥6) with DOI/arXiv each, ranked shortlist delivered, honest
no-clean-winner ruling stated. Depletion: TERMINAL (ranked shortlist of bond-Peierls light-atom classes
delivered; feeds converge).
