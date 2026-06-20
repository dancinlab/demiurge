# host-optimize — sourced real DFT-grade parameters

All numbers used in `probe.py` PART A, with citations. (d18 lit grounding · c2 sourced ≥1 host.)

## sp2C N-Lieb COF (the R2 best host)

- **Inter-site (ligand) hopping t₁ = 0.1 eV** — the VB1 flat-band hopping of sp2C-COF,
  from first-principles + tight-binding fit. The flat band is built from corner-ligand
  molecular orbitals with this small inter-site hopping.
  - *A Lieb-like lattice in a covalent-organic framework and its Stoner ferromagnetism*,
    Nat. Commun. 10, 2541 (2019), s41467-019-10094-3. https://www.nature.com/articles/s41467-019-10094-3
  - companion Lieb-COF: Nat. Commun. 10, 4633 (2019), s41467-019-13794-y.
  - arXiv:2311.16858 (tunable Lieb-lattice COF topology).
- **Bond phonon Ω ≈ 100–196 meV** — sp2-carbon C=C / C–N intra-ligand bond-stretch
  optical mode. Central value taken as **118 meV** from the biphenylene-network ω_log
  anchor (below); scanned 80–196 meV.
- **M = m_C/2 = 6.0 amu** — C–C bond-stretch reduced mass.

## biphenylene network (carbon-net phonon anchor)

- **ω_log = 1369 K ≈ 118 meV** — exceptionally large log-averaged phonon frequency from
  high-frequency carbon-derived phonons in monolayer biphenylene; moderate λ, weak-coupling
  phonon-mediated SC. Used as the central COF bond-phonon scale.
  - cf. Phys. Rev. B 104, 235422 (Type-II Dirac cones + el-ph in monolayer biphenylene);
    arXiv:2408.14006 family (biphenylene network el-ph / stability).

## graphene-Kekulé

- **NN π hopping t = 2.7 eV** — standard graphene tight-binding value (DFT/ARPES range
  2.5–2.9 eV; representative values −2.7, −2.84, −2.59 eV).
  - arXiv:0907.4264 (TB parameters for graphene); PRB 87,195450 (MLWF π-band TB).
- **El-ph Grüneisen scaling α = ∂t/∂u = C·t, C = 1.49817 Å⁻¹** — the bond-resolved el-ph
  interaction strength scales LINEARLY with the electronic hopping; α = Ct with this C.
  → α = 1.498 × 2.7 = **4.04 eV/Å**.
  - *Electron-phonon coupling in Kekulé-ordered graphene*, arXiv:2506.16814 (PRB 2025,
    10.1103/6cst-xp7s), Eq. (11). https://arxiv.org/abs/2506.16814
- **E2g Γ optical (bond-stretch) phonon ℏω = 196 meV (≈1580 cm⁻¹)**.
  - Piscanec et al., Optical phonons of graphene and nanotubes (EPJ 2007); standard Raman G-band.
- **Hubbard U: onsite U₀₀ = 9.3 eV (cRPA), NN U₀₁ = 5.5 eV**.
  - Wehling et al., *Strength of effective Coulomb interactions in graphene and graphite*,
    Phys. Rev. Lett. 106, 236805 (2011); arXiv:1101.4007.

## how these enter the model

SSH dimensionless coupling g/Ω = α·l_zp / Ω,  l_zp = √(ℏ/2MΩ) (bond zero-point amplitude).
- graphene-Kekulé: α=4.04 eV/Å, M=6 amu, Ω=196 meV → l_zp, g/Ω computed in PART A.
- sp2C COF: t/Ω DFT-pinned ≈ 0.85 (t=0.1, Ω=0.118 eV) — the compact-light SSH window.
  g/Ω scanned around the sourced estimate (weak inter-ligand α vs stiff local C=C α).
- U: on-site U is an inter-site-pair (bond bipolaron) pair-breaking knob; large U/t raises
  |Δb| for the compact bond pair rather than dissociating it (it suppresses the rival
  on-site/Holstein channel). Not a Tc-lifting lever for the SSH bond pair → not optimized over.
