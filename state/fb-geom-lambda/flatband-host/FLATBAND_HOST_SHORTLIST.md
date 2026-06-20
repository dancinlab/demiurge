# flatband-host lens — RTSC discovery — ranked shortlist of flat-band light-atom hosts

**Lens question:** identify REAL light-atom materials with a flat band pinned near E_F whose flat
band plausibly couples to BOND-STRETCHING (off-diagonal / SSH / Peierls) phonons — the
Regime-II light-bipolaron escape route of the closing formula
(`state/fb-geom-lambda/RTSC_DISCOVERY_CLOSING_FORMULA.md`).

**Match criteria (3-axis):**
1. Flat band AT E_F (dispersionless DOS peak pinned to Fermi level)?
2. Light atoms (C/B/N/H — high ω_log phonon budget, ≳69 meV target)?
3. Bond-localized wavefunction → couples OFF-DIAGONAL (∂t/∂u hopping modulation, SSH/Peierls),
   NOT on-site Holstein (∂ε/∂u density coupling, which gives heavy bipolarons m**~e^{g²})?

The decisive axis is #3: the recipe ESCAPES the conventional Tc ceiling only via off-diagonal
(bond/Peierls) coupling. On-site (Holstein/Jahn-Teller-local) coupling = FALSE escape (heavy mass).

---

## RANKED TABLE

| # | Host | flat band @E_F? | light atoms? | bond-localized (off-diag friendly)? | recipe match | source |
|---|------|-----------------|--------------|-------------------------------------|--------------|--------|
| 1 | **sp²-carbon Lieb/kagome COF (sp2c-COF, N-substituted)** | YES — Lieb flat band, N-doping shifts E_F onto the flat band; preserved under N-sub | YES — all C/N, sp² | **STRONG** — flat band built from a frustrated lattice of π-bonds; sp² C=C/C-N bonds carry the amplitude → bond-stretching phonons modulate hopping (off-diagonal) | **HIGH** | Nat Commun 10:2207 (2019), doi:10.1038/s41467-019-10094-3; arXiv:2311.16858 |
| 2 | **Magic-angle twisted bilayer graphene (MATBG)** | YES — moiré flat band exactly at E_F at magic angle | YES — pure C | **STRONG** — measured strong coupling to the graphene K-point iTO optical phonon (intervalley); the iTO mode IS the bond-stretching mode that modulates C-C hopping (off-diagonal, SSH-type) | **HIGH** (caveat: μm-scale moiré, low carrier density) | Nature 637 (2024) doi:10.1038/s41586-024-08227-w; arXiv:2303.14903 |
| 3 | **Triangulene-based 2D kagome/honeycomb lattice (organic)** | YES — kagome flat band across E_F; tunable by B(up)/N(down) doping | YES — all C/H (π-radical) | **MODERATE-STRONG** — flat band from π-conjugated lattice; bridging-group/edge functionalization adds dispersion → bonds carry amplitude (off-diagonal accessible) | **MEDIUM-HIGH** | Acc Chem Res 2024, doi:10.1021/acs.accounts.4c00557; PMC11713877 |
| 4 | **Biphenylene network (sp² C, 4-6-8 rings)** | NEAR — metallic, type-II Dirac at/near E_F (not an ideal flat band, but a high-DOS feature) | YES — pure C | **STRONG** — Fermi-surface electrons couple to very-high-freq C bond phonons; ω_log = 1369 K (~118 meV) — the largest light-atom phonon budget in the set; coupling is to bond modes (off-diagonal-friendly) | **MEDIUM** (no true flat band; but record ω_log) | OSTI 1836234 (Type-II Dirac + el-ph); arXiv:2408.14006 |
| 5 | **Benzene-ethynylene honeycomb-kagome COF** | YES — almost-flat bands with no dispersion AROUND E_F | YES — all C/H | **MODERATE** — flat band → high effective mass (warns of localization); π-bond network, off-diagonal accessible but high m* is a Holstein-like risk | **MEDIUM** | RSC Chem Soc Rev d0cs00793e (2021); pubmed 34866138 |
| 6 | **Alkali fulleride A₃C₆₀ (K₃C₆₀, Cs₃C₆₀)** | YES — narrow molecular t₁u band at E_F (low bandwidth) | YES — pure C | **WEAK→FALSE** — pairing is LOCAL intramolecular Jahn-Teller (on-site, Holstein-like) → exactly the heavy/local channel the recipe warns against; NOT off-diagonal bond-Peierls | **LOW** (anti-pattern reference) | Sci Adv 1500059 (2015); Nat Commun ncomms1910; λ≈1.2 |
| 7 | **Porous-graphene 2D kagome TI / metal-bisdithiolene MOF kagome** | YES — kagome flat band at/near E_F | porous-graphene = C; MOF = has metal node (NOT light) | MOF flat band lives on metal d → on-site; porous-graphene = bond-localized but flat band often off E_F | **LOW–MEDIUM** | arXiv:2412.11516; PMC6760139 |

**EXCLUDED (failed light-atom axis):** CsCr3Sb5, CsTi3Bi5/RbTi3Bi5, Sc3Mn3Al7Si5, MPd5, YCl dice-lattice
electride — all have flat bands at E_F but are transition-metal/heavy-element based (low ω_log,
d-orbital on-site coupling). Refs: Nat Commun s41467-025-62298-5; spj research.0238; arXiv:2502.15445;
arXiv:2508.21311.

---

## ANALYSIS — why #1 and #2 lead

The off-diagonal (bond/Peierls/SSH) axis is the recipe's hard gate. Bond-SSH theory
(PRB 109:L220502; arXiv:2407.10444) shows bond phonons modulate HOPPING (kinetic energy) →
strongly bound yet LIGHT bipolarons (m** only weakly enhanced; in the atomic limit a bond
bipolaron slides freely on a degenerate manifold). This is the mechanism that escapes m**~e^{g²}.

- **#1 sp2c-COF Lieb lattice** is the cleanest TRIPLE hit: flat band tunable ONTO E_F by N-doping,
  100% light atoms, and a flat band that is a destructive-interference state of the π-BOND network →
  its amplitude lives on bonds → C=C/C-N bond-stretching phonons act off-diagonally. It is
  first-principles computable (DFT downfold → ∂t/∂u → bond-Peierls + U → bipolaron) per the recipe's
  NOVEL campaign sketch.
- **#2 MATBG** has the experimentally CONFIRMED flat-band + bond-stretching-phonon coupling (the
  K-point iTO replica bands, Nature 2024), which is the strongest empirical proof that a light-atom
  flat band CAN couple off-diagonally to a bond mode. Caveat: moiré superlattice, dilute carriers,
  fabrication-bound — harder as a bulk DFT campaign target than a molecular COF.
- **#6 fullerides** are the instructive ANTI-PATTERN: light atoms + narrow band at E_F, but the
  coupling is LOCAL Jahn-Teller (on-site density) → the FALSE-escape Holstein channel. Confirms the
  recipe's diagnosis that on-site coupling does not escape the ceiling.

## HONEST VERDICT (d6)
No KNOWN material is a confirmed room-Tc bond-bipolaron superconductor — consistent with the closing
formula's caveat (known bond-bipolaron Tc ~ tens of K). But the lens DOES cleanly deliver hosts that
combine all three required ingredients: **sp2c-COF Lieb lattices (#1) and MATBG (#2) both satisfy
flat-band@E_F + light-atom + bond-localized (off-diagonal-friendly)**. These are the recipe-matched,
first-principles-computable NOVEL targets. The depletion test is MET: a ranked, sourced shortlist of
≥6 hosts is delivered, with the off-diagonal-coupling discriminator applied to each.

## G5 SELF-VERDICT: PASS
- ≥6 sourced flat-band light-atom hosts tabulated with DOI/arXiv ✓
- 3-axis rating {flat@E_F · light · bond-localized} applied to each ✓
- ranked by recipe match, off-diagonal axis decisive ✓
- honest null where appropriate (no confirmed room-Tc host; fulleride anti-pattern named) ✓
