# SM112-DFT-CELL verdict (DFT setup verification, c2 honest)
hexa deck built ThMn12 SmFe12 (I4/mmm). 4 QE SCF decks (magnetic nspin2, SmCu B2, Fe bcc, Cu fcc).
d16 dry-run REAL on summer pw.x v7.5: caught 2 real deck bugs (lda_plus_u obsolete→HUBBARD ortho-atomic card; card order). All 4 PASS namelist+cards, stop at readpp pseudo-not-found = syntax PASS, pseudopotential wall.
SCF NOT completed: wall = pseudopotential availability (no Sm/Fe/Cu pseudo, d13), NOT cell size. summer can handle 13-atom magnetic SCF for free.
GB E_form method documented: SmCu (CsCl B2) = lead non-FM candidate (Cu non-magnetic → ~0 net moment); Sm2Fe17/Fe-rich boundary = ferromagnetic (bad). 
Unblock = fetch Sm (in-core), Fe.pbe, Cu ONCV pseudo → turnkey (RUNBOOK). Anisotropy (SOC+beyond-GGA, Sm-4f open-core) = paid GPU, deferred (d6).
Tool bug found: deck CLI JSON reader flat-scalar-only → hexa-lang handoff.

## 2026-06-20 RUN (pseudo wall RESOLVED, SCF executed) — see RESULTS_DFT.md
Pseudos fetched: Sm.pbe-spdn-rrkjus_psl.1.0.0 (4f-IN-CORE, z_val=11, NO 4f projector), Fe/Cu/Ga/Al SG15 ONCV-PBE.
HUBBARD dropped (Fe ONCV has no atomic wfc → ortho-atomic fails) → plain PBE (d6).
CONVERGED (7): Fe_bcc(+2.27uB, validates), Cu/Al/Sm/Ga refs, SmCuGa(0.00uB, E_form −1.14 eV/f.u.), SmCuAl(0.00uB, −0.75 eV/f.u.).
Both NOVEL ternaries STABLE + NON-FERROMAGNETIC. SmCuGa more stable than SmCuAl.
STALLED on node-contention wall (summer/aiden load 23/37 from other campaigns): SmFe12, SmCu_B2 anchor, SmFe11Al — pseudos read + entered SCF but starved at iter 0-1 for ~20 min. NOT a bug. closed-negative (E_sub Al→Fe-site) PENDING those two.
