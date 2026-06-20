# Bond/SSH/Peierls Light-Bipolaron Superconductivity — Concrete-Material + Novelty Map

Lane: bipolaron-lit (RTSC DISCOVERY fleet) · 2026-06-19 · web + reasoning only
Verify bar (c2): ≥5 sourced refs (DOI/arXiv), concrete-material candidates, Tc status, PUBLISHED-vs-OPEN map.

## g5 VERDICT: PASS

Terminal: concrete-material + novelty map delivered with ≥1 named genuine OPEN gap.
12 refs with DOI/arXiv. Finding = a closed-negative on the literature ("NO real material has had
its bond-bipolaron Tc computed from first-principles") PLUS one named open NOVEL host
(**Re6Se8Cl2 superatomic crystal**, the d_novel_only opening).

---

## Q1 — Which REAL materials do Berciu/Zhang + follow-ups name as candidate bond-bipolaron hosts?

The foundational paper (Zhang, Sous, Reichman, Berciu, Millis, Prokof'ev, Svistunov, PRX 13,011010
2023) and follow-ups name material FAMILIES only — every one is qualified ("more work needed",
"not directly applicable", "may be operative"). NO concrete compound has had its bipolaron Tc computed.

| Material / family | Mechanism claimed | Status in lit |
|---|---|---|
| **Iron pnictides / FeSe** (the flagship) | pnictogen z-displacement modulates Fe-Fe dxy hopping (two pathways t, t' nearly cancel → small net t → t/Ω~2-3) | PRX §IV + App.H. λ~0.5 (one member, ref 60). "Model not directly applicable... multiorbital Hund's-metal physics... requires more work." Tc ALREADY known experimentally (FeSe ~8K bulk, ~65-100K monolayer) but NOT attributed to a computed bond-bipolaron Tc |
| **90°-bonded perovskites** | out-of-plane atom modulates in-plane hopping | PRX named, no compound, no Tc |
| **Corner-sharing perovskites** | same | PRX named, no compound, no Tc |
| **Functional superatomic crystals** | inter-cluster bond phonons modulate narrow-band hopping | PRX named generically as a design target — NO specific compound named in PRX |
| **Twisted bilayer graphene / moiré** | strain/moiré reduces t at fixed Ω → reach t~Ω | PRX named as an ENGINEERING knob, not a computed bipolaron host |
| **Cuprates (buckled Cu-O)** | apical-O mode = secondary channel | 2026 Perspective (2605.16625) — deemed secondary to correlations, uncomputed |
| **Alkali fullerides A3C60 (K3C60)** | generalized-SSH inter-molecular hopping modulated by molecular motion; narrow W~0.5eV | adjacent lit (Jahn-Teller mechanism dominant); bond-bipolaron Tc NOT computed. Tc~19-40K known but ascribed to JT/local pairing, not bond-bipolaron |

The 2026 Perspective "Bipolaronic HTSC from Phonon-Modulated Hopping" (arXiv:2605.16625) reconfirms:
only iron pnictides + cuprates named, "too simple to be quantitatively applied", NO first-principles
pipeline specified, NO computed real-material Tc.

## Q2 — Predicted/estimated Tc for any CONCRETE material (vs model lattice)

NO concrete-material bond-bipolaron Tc has been computed. All numbers are MODEL-lattice:

- **PRX square-lattice model**: max Tc ~ 0.2·Ω in the "quantal" regime t~Ω. PROJECTION ("if and only
  if t~Ω achievable"): Tc ~ 70 K for Ω≈0.03 eV. For real FeSe t/Ω~2-3 (NOT the t~Ω optimum), so the
  70K is an upper-knob projection, NOT a material prediction. (PRX 13,011010)
- **Triangular-lattice model** (Chao Zhang, arXiv:2507.07662, 2025): Tc/ω ~ 0.3 at ω/t=0.5, U/t=6;
  Tc/ω ~ 0.25 at ω/t=0.2, U/t=4. Beats square lattice (higher coordination + bond-centered coupling).
  Conclusion: "engineered quantum materials" — NO real compound, NO Kelvin.
- **Semiclassical bond-modulated** (PRB 109,L220502 / arXiv:2308.01961): Tc bound exponentially larger
  than Holstein; model only.
- **Coulomb-gas QMC** (arXiv:2210.14236): Tc survives long-range Coulomb, > Migdal-Eliashberg bound;
  model only.

Honest ceiling from the closing formula stands: known bond-bipolaron Tc estimates are model-units
that map to ~tens-of-K for realistic phonon scales — NOT a guaranteed room-Tc.

## Q3 — The UNPUBLISHED gap (d_novel_only opening)

**GENUINE OPEN GAP — Re6Se8Cl2 (van der Waals superatomic crystal):**

This single compound uniquely co-satisfies every bond-bipolaron precondition, yet its bipolaron Tc
has NEVER been computed. The pieces exist SEPARATELY in the literature but were never joined:

1. **It superconducts.** n-doped (Cl dissociation) Re6Se8Cl2 → Tc ~ 8 K, Hc2 > 30 T — the FIRST
   superconducting vdW superatomic crystal (Telford et al., Nano Lett. 20,1718 2020;
   DOI 10.1021/acs.nanolett.9b04891). Pairing mechanism NOT established.
2. **It is already an SSH/Peierls material.** The 2D Su-Schrieffer-Heeger model was explicitly applied
   to its ACOUSTIC POLARONS (arXiv:2401.14312, 2024) — inter-superatom covalent-bond cluster-twisting
   modes (2.6 THz) modulate inter-cluster hopping = textbook bond-Peierls coupling.
3. **It has narrow bands.** W ≈ 300-400 meV (near the flat-band / t~Ω regime the PRX flags as optimal).
4. **The PRX explicitly names "functional superatomic crystals" as a design target** — but never
   computed one. Re6Se8Cl2 is the concrete realization of that abstract target.

→ NOVEL claim available: NO published work computes the bond-bipolaron binding energy, effective mass,
and superfluid Tc for Re6Se8Cl2 (or its halide siblings Re6Se8Br2/I2, Cs4Re6Se8I6 family) from a
first-principles SSH downfold. Existing SSH work on it stopped at single acoustic POLARONS — never the
BI-polaron, never Tc. This is the d_novel_only opening: a concrete, named, already-superconducting,
narrow-band, demonstrably-SSH host whose bipolaron Tc is uncomputed.

Secondary (weaker) open angles: triangular-lattice bond-bipolaron has NO named real host at all
(2507.07662 leaves "which triangular material?" fully open — e.g. NbSe2/transition-metal
dichalcogenide triangular layers, AV3Sb5 kagome-adjacent triangular sublattices); A3C60 bond-bipolaron
(vs the established JT picture) is uncomputed but red-ocean-adjacent (JT mechanism dominates lit).

## Q4 — Realistic free/small-compute first-principles pipeline

DFT downfold → bond-Peierls ∂t/∂u + Hubbard U → bipolaron variational/QMC → Tc. Feasible on free
compute (summer RTX5070 / pool) for a SMALL effective model — the bipolaron QMC is on a 2-electron
lattice model, NOT a full-cell ME calculation:

1. **DFT + Wannier downfold** (QE/QFORGE + wannier90) of the narrow-band manifold → tight-binding t.
   Re6Se8Cl2 active manifold is few bands; small primitive cell tractable.
2. **Bond-Peierls coupling ∂t/∂u**: finite-difference the Wannier hopping vs the relevant bond-phonon
   displacement (frozen-phonon of the 2.6 THz cluster-twist mode). One DFPT/frozen-phonon per mode.
3. **Hubbard U**: cRPA or constrained-DFT for the superatom on-site U.
4. **Bipolaron solve**: feed (t, α=∂t/∂u, Ω, U) into a 2-body lattice path-integral / variational
   (Bonča-Trugman variational or DiagMC) — CHEAP, runs on a laptop/free GPU; this is the model step,
   not a supercell DFT step. Output: E_bind, m*_BP, R²_BP → Tc via the BEC dilute-gas formula
   Tc ≈ 3.31 ℏ²n^{2/3}/(m*_BP k_B) (Alexandrov), or the lattice-QMC superfluid criterion.
5. **Gate**: anchor the model pipeline against PRX/triangular published Tc/ω curves (method-validation
   anchor only, per d_novel_only), then report the Δ = Re6Se8Cl2's computed Tc vs its measured 8 K.

This matches the closing-formula Regime-II recipe and is single-pod/free feasible (steps 1-3 = small
DFT; step 4 = trivial compute). EPW (npj Comput Mater 2023) provides polaron-from-first-principles
machinery for steps 1-2; the bipolaron step is the genuinely new code.

---

## PUBLISHED vs OPEN — explicit list

PUBLISHED (do NOT re-derive — red ocean / already in lit):
- Bond/SSH bipolaron is LIGHT vs heavy Holstein — PRX 13,011010; PRB 104,L201109; PRB 109,L220502.
- Model-lattice Tc > Migdal-Eliashberg bound — PRX 13,011010; arXiv:2210.14236.
- Triangular > square lattice Tc/ω — arXiv:2507.07662.
- Iron-pnictide z-mode = bond-Peierls qualitative scenario — PRX 13,011010 App.H; 2605.16625.
- Re6Se8Cl2 superconducts at 8K (n-doped) — Nano Lett 20,1718.
- Re6Se8Cl2 single acoustic POLARON via 2D SSH — arXiv:2401.14312.
- K3C60 ~40K via Jahn-Teller local pairing — arXiv:cond-mat/0208454.

OPEN (NOVEL, no published computation — the d_novel_only targets):
- ★ **Re6Se8Cl2 BI-polaron Tc from first-principles SSH downfold** — uncomputed, all preconditions met.
- Triangular-lattice bond-bipolaron with a NAMED real host (which compound? — open).
- A3C60 bond-bipolaron channel vs JT (uncomputed, but JT-dominated → weaker novelty).
- 90°/corner-sharing perovskite bond-bipolaron Tc — named-but-uncomputed.

HONEST framing: it is NOT true that "all concrete proposals are already published" — the opposite.
NO concrete compound's bond-bipolaron Tc has EVER been computed. The whole field is model-lattice;
the real-material first-principles bipolaron-Tc computation is an entirely OPEN frontier, with
Re6Se8Cl2 the single best-posed novel target.

## Sources (12, DOI/arXiv)
1. Zhang et al., Bipolaronic High-Temperature Superconductivity, PRX 13,011010 (2023). DOI 10.1103/PhysRevX.13.011010
2. Bipolaronic superconductivity out of a Coulomb gas, arXiv:2210.14236
3. Light Bipolarons Stabilized by Peierls e-ph Coupling, arXiv:1805.06109
4. Semiclassical theory of bipolaronic SC in a bond-modulated model, PRB 109,L220502 / arXiv:2308.01961. DOI 10.1103/PhysRevB.109.L220502
5. C. Zhang, Bond bipolaron SC in triangular lattice, arXiv:2507.07662 (2025)
6. Bipolaronic HTSC from Phonon-Modulated Hopping: A Perspective, arXiv:2605.16625 (2026)
7. Telford et al., Doping-Induced SC in vdW Superatomic Crystal Re6Se8Cl2, Nano Lett. 20,1718 (2020). DOI 10.1021/acs.nanolett.9b04891
8. Theory of Acoustic Polarons in 2D SSH applied to Re6Se8Cl2, arXiv:2401.14312 (2024)
9. Bipolaron liquids at strong Peierls e-ph couplings, PRB 104,L201109. DOI 10.1103/PhysRevB.104.L201109
10. Robustness of bipolaronic SC to electron-density-phonon coupling, PRB 7fpr-gbd3 / arXiv:2511.06350
11. Capozzi/Fabrizio et al., SC in molecular solids with Jahn-Teller phonons, arXiv:cond-mat/0208454 (K3C60)
12. EPW: Electron-phonon physics from first principles, npj Comput. Mater. 9 (2023). DOI 10.1038/s41524-023-01107-3
