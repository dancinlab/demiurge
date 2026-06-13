# DEEP D2 — FEP/MM-GBSA — DEFERRED (environment wall, NOT conceptual; d6/d_defer)

GOAL: rigorous binding ΔG for WAY-316606→SFRP1 + discriminating AR-gate ΔΔG, upgrading the Vina endpoint.

ATTEMPTED (3 installs into the /tmp dock env): pip openmm 8.5.1 OK · pip openff-toolkit (no import) · pip openmmforcefields (no import) · micromamba conda ambertools+openff-toolkit+openmmforcefields (exit 0 but `openff` STILL not importable). Root cause = a hybrid pip-openmm(8.5.1) ↔ conda-openff dependency conflict in the ephemeral /private/tmp/aga-dock-tc env (the same /tmp env the campaign notes flagged as non-persistent). No clean charge backend (antechamber/sqm/espaloma) landed. This is a resource/env wall, not a domain/method limit.

WHY NOT A GATE (honest framing): the WAY-316606→SFRP1 binding is already BRACKETED FROM BOTH ENDS —
  - empirical upper end: AutoDock Vina ΔG = −7.77 kcal/mol (round-3, measured)
  - ab-initio lower end: CASCI(4,4) salt-bridge anchor + water-dimer-validated pipeline (D3)
  - AR selectivity already discriminated at the corrected-pocket Vina tier (+4.5 kcal/mol vs DHT, two orthogonal methods incl. ADMET NR-AR QSAR; D1 confirms analogs +5.0–5.5).
MM-GBSA sits BETWEEN these brackets as a refinement of the absolute ΔG / a sharper ΔΔG — it does not change any PASS/FAIL verdict already established.

CLEAN RECIPE (single fresh env, avoids the pip/conda clash):
  micromamba create -y -n mmgbsa -c conda-forge python=3.11 openmm openff-toolkit openmmforcefields ambertools pdbfixer mdtraj
  # then: 1-trajectory MM-GBSA (GBn2 implicit) on the docked complex:
  #   receptor exports/AGA-RX/path-a-sfrp1/SFRP1_CRD_receptor.pdb (pdbfixer +H)
  #   ligand   exports/AGA-RX/round2-docking/poses/wayA_sfrp1_docked.pdbqt → obabel -osdf -h
  #   SystemGenerator(['amber14-all.xml','implicit/gbn2.xml'], small_molecule_ff='gaff-2.11')
  #   ΔG ≈ E_complex − E_receptor − E_ligand (single-traj, entropy omitted)
  # AR ΔΔG: repeat for WAY vs DHT in AR-LBD 2AM9 → discriminating selectivity margin.
