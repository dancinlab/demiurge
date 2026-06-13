# AGA-RX Round-4 SYNTHESIZE — Retrosynthesis + Synthesizability

date: 2026-06-03 · host: mini (macOS arm64) · domain: AGA-RX (SFRP1 inhibitor lead, in-silico R&D)
lead: **WAY-316606** (SFRP1 inhibitor, CID 16727102) · MW 448.5 · cLogP 2.57 · Kd ≈ 0.08 mM (weak mM groove binder, ΔG_bind ≈ −5.6 kcal/mol)
toolchain: rdkit 2026.03.2 (SA_Score contrib · BRICS retro-fragmentation). AiZynthFinder = **NOT installable here**
(requires Python <3.13; base env is 3.13, plus the policy/template model bundle is a multi-GB download absent on this host)
→ routes are **rules-based hand-designed** with named reactions; each step tagged **[LIT]** literature-precedented or **[NOVEL]** (d6 honesty).

The lead is a **1,2-bis-sulfonyl benzene** (a *central benzene* bearing an *ortho*-CF3, a *meta* primary-sulfonamide → piperidin-4-yl-amine,
and a *para*-to-the-sulfonamide aryl-sulfone → phenyl). The retrosynthesis is dominated by two robust disconnections:
**(D1) the sulfonamide S–N bond** and **(D2) the diaryl-sulfone Caryl–S bond**.

---

## 0. rdkit BRICS retro-fragmentation (deterministic disconnection check)

Each target was BRICS-decomposed to confirm the hand-designed disconnections are the natural fragmentation:

| target | BRICS fragments | interpretation |
|---|---|---|
| WAY-316606 | `[S(=O)(=O)-benzene(-SO2Ph)]` · `C1CCNCC1` (piperidine) · `N` (sulfonamide N) · `C(F)(F)F` | core + amine cap + S–N + CF3 → D1+D2 confirmed |
| A1 3-pyridyl | same core w/ `SO2-(3-pyridyl)` · piperidine · N · CF3 | only the distal aryl differs → late-stage swap |
| A2 4-aminoTHP | same core w/ `SO2Ph` · `C1CCOCC1` (tetrahydropyran) · N · CF3 | only the amine cap differs → reagent swap at D1 |
| A3 saccharin-bicycle | `[saccharin-3-one-1,1-dioxide bearing SO2Ph]` · `C1CCNCC1` | ring fuses S–N → single N-alkylation disconnect |

This confirms a **convergent 2–3 fragment assembly** for all four compounds; no fragment is exotic.

---

## 1. WAY-316606 (LEAD) — synthetic route

**Strategy: build the central benzene once with two orthogonal handles, install the distal sulfone first, then cap with the amine via sulfonamide coupling last (latest-stage = most diversifiable).**

Central building block: **2-(trifluoromethyl)benzene-1,4-... ** — practically, start from a commercially available *ortho*-CF3 aryl scaffold that already carries one sulfonyl-chloride handle and one thioether/halide handle.

| # | transform | named reaction / reagents | feasibility note | tag |
|---|---|---|---|---|
| S1 | 2-(trifluoromethyl)thioanisole → **5-bromo-2-(trifluoromethyl)thioanisole** (or use catalog 2-CF3-4-bromo-thioanisole directly) | electrophilic bromination (Br₂/AcOH or NBS) | regioselective *para* to SMe, *meta* to CF3; standard | [LIT] |
| S2 | aryl-SMe → **aryl-SO₂Cl** | oxidative chlorosulfonation: Cl₂ / AcOH-H₂O, or NCS/HCl, or H₂O₂ then SOCl₂ | classic thioether→sulfonyl chloride; well-precedented | [LIT] |
| S3 | aryl-Br (the other handle) + **PhSO₂Na** (sodium benzenesulfinate) → **diaryl sulfone** | Cu- or Pd-catalyzed C–S sulfonylation (Ullmann-type ArX + ArSO₂Na), or Pd/Xantphos | installs the distal phenyl-sulfone (D2); ArSO₂Na route is robust & cheap | [LIT] |
| S4 | aryl-SO₂Cl + **4-amino-piperidine** (Boc-protected: 4-amino-1-Boc-piperidine) → **sulfonamide** | sulfonamide coupling: SO₂Cl + R-NH₂, Et₃N or pyridine, DCM, 0 °C→rt | textbook; the central S–N bond (D1); use N-Boc amine to avoid bis-sulfonylation | [LIT] |
| S5 | Boc removal → **WAY-316606** | TFA/DCM (Boc deprotection) | quantitative; reveals the basic piperidine NH | [LIT] |

**Step count: 5 linear (4 if a catalog 4-bromo-2-CF3-arenesulfonyl chloride is sourced → skip S1).**
**Key disconnections:** D1 sulfonamide (S4) · D2 diaryl sulfone (S3).
**Convergence:** the amine cap (4-amino-piperidine) and the sulfinate (PhSO₂Na) are both bolt-on at the last two steps → ideal for analog libraries.

**Commercial SM availability (catalog items):**
- 4-amino-1-Boc-piperidine — **catalog** (Sigma/Enamine/Combi-Blocks, cheap).
- Sodium benzenesulfinate (PhSO₂Na) — **catalog** (commodity).
- 2-(trifluoromethyl)thioanisole / 4-bromo-2-(trifluoromethyl)thioanisole — **catalog** (fine-chemical).
- Even simpler: **4-bromo-2-(trifluoromethyl)benzenesulfonyl chloride** is a known catalog SM (Enamine/Fluorochem class) → starts the route at S3/S4 directly. **All SMs are commodity → cost class LOW.**

---

## 2. A1 — distal benzenesulfonyl phenyl → **3-pyridyl** (or N-Me-pyrazole)

Identical route to the lead **except S3**: the distal aryl is swapped at the sulfone-forming step.

| # | transform | reaction / reagents | note | tag |
|---|---|---|---|---|
| S1–S2 | (as lead) | bromination + thioether→SO₂Cl | — | [LIT] |
| **S3′** | aryl-Br + **sodium pyridine-3-sulfinate** → **3-pyridyl-aryl sulfone** | Cu/Pd C–S coupling with the heteroaryl sulfinate | het-sulfinate available or made from 3-bromopyridine→sulfinate; coupling is the design's "Suzuki-class" heteroaryl swap (here a sulfonylative coupling, the correct disconnect for a *sulfone*) | [LIT] |
| | **alt (true Suzuki path)** | if the distal link were a C–C biaryl: 4-bromo core + 3-pyridylboronic acid, Pd(PPh₃)₄/K₂CO₃ | only applies to a C–C analog, not the sulfone; listed for completeness | [LIT] |
| S4–S5 | (as lead) | sulfonamide coupling + Boc removal | — | [LIT] |

**Step count: 5.** SM swap only (pyridine-3-sulfinate / 3-bromopyridine). The N-Me-pyrazole variant uses **1-methyl-1H-pyrazole-4-sulfinate** at S3′ — also catalog/synthesizable. **Cost class LOW–MED** (heteroaryl sulfinate slightly pricier than PhSO₂Na).

---

## 3. A2 — cap basic piperidine → **4-aminotetrahydropyran** (or N-acyl)

Identical route to the lead **except S4**: the amine reagent is swapped — **no Boc/deprotection needed** for the THP variant (no basic N), so it is one step shorter.

| # | transform | reaction / reagents | note | tag |
|---|---|---|---|---|
| S1–S3 | (as lead) | core + distal PhSO₂ sulfone | — | [LIT] |
| **S4′** | aryl-SO₂Cl + **4-aminotetrahydropyran** → sulfonamide | SO₂Cl + R-NH₂, Et₃N/DCM | THP amine is non-basic → no protection, no S5 deprotection | [LIT] |
| | **N-acyl variant** | after lead S5, acylate the piperidine NH: R-COCl or R-CO₂H/HATU → **N-acyl-piperidine** | standard amide coupling; caps basicity while keeping the ring | [LIT] |

**Step count: 4 (THP variant) — the shortest route of the set** (skips Boc protect/deprotect). **Cost class LOW** (4-aminotetrahydropyran is a cheap catalog amine, Combi-Blocks/Enamine).

---

## 4. A3 — rigidify sulfonamide → **saccharin / benzosultam bicycle**, grow into W97/Y127 subpocket

SMILES used (rdkit-validated): `O=S1(=O)N(C2CCNCC2)C(=O)c2cc(S(=O)(=O)c3ccccc3)ccc21`
The acyclic SO₂–NH of the lead is fused into a **saccharin (1,2-benzisothiazol-3(2H)-one 1,1-dioxide)** bicycle; the ring **N** carries the piperidin-4-yl, and the rigid bicyclic face presents toward the **W97/Y127** subpocket (growth vector = ring C3/aromatic edge).

| # | transform | reaction / reagents | note | tag |
|---|---|---|---|---|
| S1 | **saccharin** (or 6-bromo-saccharin) as the bicyclic SM | commodity sweetener-grade building block | saccharin is dirt-cheap; 6-substituted saccharins are catalog | [LIT] |
| S2 | install distal **PhSO₂** on the saccharin benzo ring | from 6-bromo-saccharin: Cu/Pd C–S coupling with PhSO₂Na (as S3 above) | regiochemistry set by the bromo position | [LIT] |
| S3 | **N-alkylation of the saccharin nitrogen** with 4-(leaving-group)-1-Boc-piperidine (e.g. 4-bromo- or 4-OMs-1-Boc-piperidine), or **Mitsunobu** with 4-hydroxy-1-Boc-piperidine | N-alkylation (K₂CO₃/DMF) or Mitsunobu (DIAD/PPh₃) | saccharin N-H is acidic (pKa ~1.6) → clean N-alkylation; well-precedented for N-substituted saccharins | [LIT] |
| S4 | Boc removal → A3 | TFA/DCM | reveals piperidine NH | [LIT] |
| S3-grow | (optional) C-3 / benzo growth arm into W97/Y127 | Suzuki on a 4- or 5-bromo-saccharin (ArB(OH)₂, Pd) **before** N-alkylation | the "grow into subpocket" element; classic biaryl Suzuki | **[NOVEL]** as applied to this scaffold (each reaction is [LIT]; the *combination targeting W97/Y127* is the novel design hypothesis) |

**Step count: 4 (core route); +1 for the optional subpocket growth Suzuki.**
**Key disconnection:** saccharin N-alkylation (single bond, the only D1 needed because the S–N is pre-formed in the commercial bicycle).
**Commercial SM availability:** saccharin = **commodity (catalog, ~$/kg)**; 4-bromo/4-OMs-1-Boc-piperidine = catalog; PhSO₂Na = catalog; arylboronic acids for the grow arm = catalog. **Cost class LOW** for the core; **MED** if the regio-defined 6-bromo-saccharin + extra Suzuki is used.

---

## 5. Synthesizability scoring (rdkit SA_score)

SA_score: **1 = very easy … 10 = very hard.** Lower is easier. (raw: `sa_scores.txt`)

| rank | compound | SA | MW | cLogP | TPSA | HBD | HBA | RotB | QED | step count |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | **A2 4-aminoTHP cap** | **2.41** | 449.5 | 3.00 | 89.5 | 1 | 5 | 5 | 0.76 | **4 (shortest)** |
| 2 | WAY-316606 (lead) | 2.46 | 448.5 | 2.57 | 92.3 | 2 | 5 | 5 | 0.73 | 5 |
| 3 | A1 3-pyridyl swap | 2.64 | 449.5 | 1.96 | 105.2 | 2 | 6 | 5 | 0.72 | 5 |
| 4 | A3 saccharin-bicycle | 2.65 | 406.5 | 1.42 | 100.6 | 1 | 6 | 3 | **0.83** | 4 (+1 grow) |

**Notes:**
- All four are **highly synthesizable** (SA 2.4–2.7, well below the 3.5–4 "hard" threshold) — unsurprising for a flat sulfonyl-benzene chemotype.
- SA barely separates them; the practical tie-breaker is **step count + deprotection burden**, where **A2 wins** (4 steps, no Boc, non-basic amine).
- **A3 has the best QED (0.83) and lowest MW/cLogP** — the rigidification trims a rotatable bond (5→3) and improves drug-likeness; SA is marginally highest only because of the extra ring/regiochemistry, still trivially easy.
- A1 lowers cLogP (1.96) and raises TPSA — slightly worse passive permeability, relevant to the topical-flux argument in FORMULATION.md.

---

## 6. Route verdict

- **All 4 routes are 4–5 steps, fully convergent, last-step-diversifiable, and built from commodity catalog SMs** (4-amino-1-Boc-piperidine, PhSO₂Na, saccharin, 4-aminotetrahydropyran, het-sulfinates). **SM cost class = LOW** across the board (A1/A3-grow = LOW–MED).
- **Every elementary step is literature-precedented [LIT]** (thioether→sulfonyl chloride, Cu/Pd C–S sulfonylative coupling, sulfonamide coupling, saccharin N-alkylation, Boc chemistry, optional Suzuki). The only **[NOVEL]** element is the *design hypothesis* of growing the saccharin bicycle into the W97/Y127 subpocket — the chemistry to do it is standard Suzuki; the novelty is which fragment/where (d6: flagged honestly, not a synthesis risk).
- **Easiest to make: A2** (SA 2.41, 4 steps, no protection). **Best drug-likeness: A3** (QED 0.83). Combined synthesize-lane recommendation is carried into the final verdict (see FORMULATION.md §6).

artifacts: `sa_scores.txt` (raw rdkit output) · this file.
