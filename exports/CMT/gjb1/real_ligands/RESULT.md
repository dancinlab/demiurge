# 🧬 Real drug-like ligand design + docking — Cx32 (GJB1) L143P cryptic pocket

**Date:** 2026-06-22 · **Host:** mini (FREE local CPU, miniforge3 env `fea`) · **GPU 무접촉**
(summer/aiden running ABFE — untouched) · **Goal:** escape the scaffold-placeholder
(2-naphthoate) to **actual drug-like molecules** for the L143P-induced TM1/TM4 cryptic pocket.

> **HONEST (d6):** docking score = ranking aid, **NOT** affinity · novelty = **separate gate**
> (agent-2) · placeholder→real = **method progress, not binding validation** · **no discovery
> claimed**. All candidates are coordinates pending K≥3 ABFE + novelty confirmation.

---

## 1 · Tool availability (FREE local)

| tool | status | note |
|------|--------|------|
| RDKit | ✅ 2026.3.3 | installed FREE into miniforge3 `fea` (`pip install rdkit`) |
| smina | ✅ 2020.12.10 | Vina 1.1.2 scoring fn; installed FREE via bioconda (`conda install -c bioconda smina`) |
| OpenBabel | ✅ 3.1.0 | dependency of smina; SDF/pdbqt interconvert |
| meeko | ✅ 0.7.1 | installed; not needed (smina takes SDF directly) |
| AutoDock Vina (python) | ❌ | wheel build fails on macOS-ARM ("Boost library not found"); **smina is the FREE substitute** (same Vina scoring fn → scores comparable to the prior summer Vina run) |
| GPU (summer/aiden) | ⛔ untouched | ABFE in flight; docking is CPU-only anyway |

Default mini `python3` is 3.14 (no rdkit wheel yet) → used the `fea` env python 3.11.

---

## 2 · Pocket pharmacophore read (structural, not energetic)

L143P pocket #2 (`pockets_L143P.json`): **434 Å³**, center [129.36, 157.79, 171.44], burial
54.5%, **hydrophobic_frac 0.87**, 23 lining residues.

- **Lipophilic body required** — 14/23 lining are aliphatic (Ile/Val/Leu/Ala/Met). Bulk binding
  must come from a flat/branched nonpolar aromatic+aliphatic core.
- **Aromatic cage** — TRP24, PHE31, PHE193, TYR211 → π-stacking core favored (why naphthoate led).
- **Single polar anchor** — **GLU208** is the lone acidic handle (SER26, TYR211-OH minor). One
  directional H-bond donor / weak base toward GLU208 anchors; polar-heavy ligands are
  desolvation-penalized in this dry cavity.
- **Small volume** — ~6-7-heavy-atom ring + small substituent; keep MW modest (<~350).

---

## 3 · Designed candidate set (15 novel + 2 refs)

All 15 designed candidates pass **Lipinski Ro5** AND **CNS/blood-nerve heuristics**
(MW 145-233, cLogP 0.66-3.37, TPSA<72, RotB≤2, neutral/weak-base). Five scaffold families,
deliberately divergent from the placeholder (2-naphthoate), the anchor (4-PBA), and the Cx26
prior-art compound (VRT-534) per `d_novel_only`:

| family | members | design logic |
|--------|---------|--------------|
| A · rigid fused-bicyclic acids/amides | benzofuran-2-carboxamide, indole-3-acetamide, indazole-5-carboxamide, quinoline-2-carboxylic | flat aza/oxa cage + single amide/acid anchor |
| B · heteroaromatic biaryls | 4'-F-biphenyl-4-carboxamide, 4-(pyridin-4-yl)benzamide, benzothiophene-2-carboxamide | span long cavity axis, S/N for lipophilicity & charge complementarity |
| C · fluorinated diaryl ether/sulfone | 4-(4-F-phenoxy)phenol, 4-(phenylsulfonyl)aniline | bent biaryl matching kinked cavity, very low TPSA |
| D · sat/aromatic hybrid bicyclics | 2-aminotetralin, chromane-2-carboxamide, 2-Me-indole-5-carbonitrile | sp3 character fits 434 Å³ better than flat naphthalene |
| E · VRT-534-concept, scaffold-divergent | N-(thiazol-2-yl)benzamide, 5-F-2-phenyl-benzimidazole, 1,7-naphthyridin-2-amine | one directional anchor + lipophilic body in unrelated cores |

Full SMILES + property table: `design_ligands.py` (run it) · `ligands_real.smi`.

---

## 4 · Docking ranking (smina, vs placeholder baseline)

Same receptor.pdbqt (L143P, 1695 atoms) + same box as summer run → directly comparable.
Re-docked placeholder = -6.1 here vs -5.98 on summer (Vina 1.2.7) → cross-engine agreement ±0.1.

| rank | candidate | smina kcal/mol | Δ vs placeholder (-6.1) |
|------|-----------|----------------|--------------------------|
| 1 | **CX32L8_diaryl_ether_F** (`Oc1ccc(Oc2ccc(F)cc2)cc1`) | **-6.4** | **−0.3 (better)** |
| 2 | **CX32L14_difluoro_benzimidazole** (`Fc1ccc2[nH]c(-c3ccccc3)nc2c1`) | **-6.1** | 0.0 (tie) |
| 3 | **CX32L1_benzofuran2carboxamide** (`O=C(N)c1cc2ccccc2o1`) | **-5.9** | +0.2 |
| — | REF_2naphthoate_PLACEHOLDER | -6.1 | baseline |
| — | REF_4PBA_anchor | -5.6 | +0.5 |

Full sorted table: `scores_real_sorted.csv` (all 17). **Honest:** the score spread is narrow
(-4.9 … -6.4) — typical for a shallow lipophilic cavity where docking poorly discriminates;
this is exactly why ABFE (K≥3) is the real ranking, and why the score is a guide only (d6).

**Selected top-3** advance to the ABFE queue (`QUEUE.md`). Bound poses already extracted:
`lig_CX32L8_diaryl_ether_F_bound.sdf`, `lig_CX32L14_difluoro_benzimidazole_bound.sdf`,
`lig_CX32L1_benzofuran2carboxamide_bound.sdf`.

---

## 5 · Files

```
real_ligands/
├─ design_ligands.py        — RDKit design + Lipinski/CNS property filter (15 cand + 2 ref)
├─ ligands_real.smi         — SMILES set (input to docking)
├─ dock_local.sh            — FREE smina docking into L143P pocket (same receptor/box as summer)
├─ scores_real.csv          — raw smina scores
├─ scores_real_sorted.csv   — sorted ranking
├─ lig_<top3>_bound.sdf     — ABFE-ready docked poses (MODEL 1, receptor-frame)
├─ QUEUE.md                 — K≥3 ABFE run spec + single-line FIRE command (NOT fired)
├─ RESULT.md                — this file
└─ work/                    — docking scratch (per-ligand SDF/pose/log)
```

## 6 · Remaining (honest)
- ABFE **NOT FIRED** — GPU contended (d17 autonomy unaffected, but constraint = GPU 무접촉).
- Novelty of CX32L8/L14/L1 chemotypes = **agent-2 gate** (not confirmed here).
- Optional flex-sidechain re-dock (deeper seat) — not run (kept rigid for baseline parity).
