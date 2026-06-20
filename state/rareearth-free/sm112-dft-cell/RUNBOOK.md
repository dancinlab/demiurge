# Sm(Fe,Co)12 ThMn12 + Sm-rich GB phase — DFT deck set & run plan

## What this is
First-principles deck set for (a) the ThMn12 SmFe12 magnet phase (Fe-sublattice
moments, formation energy) and (b) candidate Fe-lean Sm-X grain-boundary phases
vs the ferromagnetic Fe-rich native boundary. Targets the lit gap (L13): no
DFT/CALPHAD map of an ideal non-ferromagnetic Sm-rich GB phase.

## Structure (built via `hexa deck material`, d_deck_always)
- exports/material/decks/SmFe12_ThMn12/{POSCAR,structure.cif,structure.xyz}
  ThMn12 I4/mmm (SG139), a=8.50 c=4.80 Å, conventional cell Z=2 (2 Sm + 24 Fe).
  Sm @ 2a; Fe @ 8f/8i/8j (x_8i≈0.36, x_8j≈0.28 nominal — relax before production).

## QE SCF decks (this dir)
- scf_SmFe12_magnetic.in — PRIMITIVE bct (ibrav=7, 13 atoms = 1 Sm + 12 Fe),
  nspin=2, MV smearing degauss=0.02, mixing_beta=0.3, maxstep=400 (d15 aids),
  HUBBARD (ortho-atomic) U Fe-3d 1.0 (QE v7.5 card syntax). Yields Fe-sublattice
  moments + total E for E_form.
- scf_SmCu_B2.in — candidate non-FM Sm-rich GB phase (CsCl B2, Pm-3m), nspin=2,
  Cu non-magnetic → expected ~zero net 3d moment.
- scf_Fe_bcc.in — ferromagnetic Fe reference / Fe-rich-boundary proxy (~2.2 μB).
- scf_Cu_fcc.in — fcc Cu reference (for SmCu formation energy).
- (deferred) Sm2Fe17 Th2Zn17 rhombohedral — 2nd Fe-bearing GB competitor; build
  next via material builder once a Sm pseudo lands.

## d16 dry-run status (REAL, on summer ~/micromamba/envs/qe pw.x v7.5)
ALL FOUR decks parse cleanly through namelists + cards and stop ONLY at readpp
(missing pseudo). Two real deck bugs were caught & fixed during dry-run:
  1. lda_plus_u/Hubbard_U(i) obsolete in v7.5 → migrated to HUBBARD card.
  2. HUBBARD card must follow ATOMIC_SPECIES → reordered.
Endpoint: "file ./pseudo/<El>.UPF not found" = clean syntax PASS, pseudo wall.

## d13 element-coverage WALL (the blocker)
No Sm, Fe(PBE), or Cu pseudopotential exists on mini or summer. Present locally:
Ca/Co/H/La/Mo/Ru/Si/Sn ONCV-PBE-sr; summer has a scattered pslibrary PBE set
(Sc/Sr/Au/S/Se/Ga/Nb) but NO Sm/Fe/Cu. No SSSP/pslibrary install.
→ To run: fetch (a) Sm with 4f IN CORE or open-core (e.g. pslibrary Sm.GGA-PBE
  *-in-core, or an SG15/Dojo Sm) — Sm 4f valence DFT is unstable/incorrect for
  magnetism; (b) Fe.pbe-spn ONCV or pslibrary; (c) Cu ONCV-PBE.

## Formation / interface energetics method
E_form(SmCu) = E(SmCu) − E(Sm_bulk) − E(Cu_fcc)   [per f.u.]
E_form(Sm2Fe17), E_form(SmFe12) likewise vs elemental Sm/Fe references.
Selection rule (the deliverable): the Sm-X GB candidate with the LOWEST E_form
AND ~zero net Fe/3d moment (non-ferromagnetic) is the magnetically-decoupling
boundary. SmCu (Cu non-magnetic) is the lead non-FM candidate; Sm2Fe17/Fe-rich
boundary carry large Fe moments (ferromagnetic = bad for coercivity).

## Honest scope (d6)
ACHIEVABLE free (once pseudos land, on summer 12-core CPU): Fe-sublattice moments,
relative E_form ranking of GB phases. NOT achievable here: magnetocrystalline
anisotropy (needs SOC + beyond-GGA, and Sm 4f open-core treatment caps anisotropy
fidelity). Anisotropy is flagged as paid-GPU / beyond-GGA downstream work.
