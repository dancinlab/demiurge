<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — ABX₃ perovskite structure family, oxide + halide -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; LK-99 HARD_WALL preserved -->
---
domain: perovskite
requires: []
verb_group: ceramic_inorganic
status: SPEC_FIRST
verdict_basis: NIST + primary literature + vendor datasheets; no lattice fit; LK-99 UNPROVEN preserved
---

# Perovskite — n=6 소재 substrate, material verb (Phase D 20/29)

> **Material layer only.** ABX₃ structure family — oxide perovskite
> (BaTiO₃, SrTiO₃, PZT, BiFeO₃), halide / hybrid perovskite (MAPbI₃,
> FAPbI₃, CsPbI₃ + Sn / Bi substitutions), antiperovskite (Cu₃N,
> Mn₃Cu). LK-99 status preserved as **HARD_WALL UNPROVEN**.

> (bandgap, d₃₃, ε_r, T_curie) are physical-chemistry parameters, NOT
> n=6 lattice outputs. LK-99 reproduction status preserved at **null
> per multiple peer-reviewed attempts**. Cell-record efficiency
> (~ 26 %) cited from NREL chart; no lattice projection.

---

## §1 WHY — why perovskite belongs in hexa-matter

The perovskite structure (ABX₃: large A in cuboctahedron, small B in
octahedron, X at corners) is a single structure type spanning 4
distinct material families with very different applications.

| Family | Composition | Property highlight | Use |
|--------|-------------|--------------------|-----|
| Oxide ferroelectric/piezoelectric | BaTiO₃, PZT (Pb(Zr,Ti)O₃), PMN-PT | ε_r 10³–10⁵; d₃₃ 200–2500 pC/N | MLCC capacitor, actuator, ultrasonic |
| Oxide multiferroic | BiFeO₃, BiMnO₃ | ferroelectric + (anti)ferromagnetic at 300 K | research |
| Oxide superconductor (high-T_c) | YBa₂Cu₃O₇ (related structure) | T_c 92 K | research / commercial cryo |
| Halide / hybrid PV absorber | MAPbI₃, FAPbI₃, CsPbI₃ | direct E_g 1.48–1.55 eV, μ ~ 60 cm²/V·s | PV cell, LED, X-ray detector |
| Antiperovskite | Cu₃N, Mn₃Cu, Mn₃GaC | tunable magnetism, NTE thermal expansion | research |

---

## §2 Real-limits-first — perovskite's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| Pv-L1 | BaTiO₃ ε_r (multilayer ceramic capacitor grade) | Engineering / SOFT | **10³–10⁵** (composition + microstructure dependent) | Murata MLCC datasheet |
| Pv-L2 | PZT d₃₃ (soft PZT-5H) | Engineering / SOFT | **600 pC/N** | TRS Ceramics datasheet |
| Pv-L3 | PMN-0.32PT single-crystal d₃₃ | Engineering / SOFT | **2500 pC/N** | TRS / Park & Shrout 1997 |
| Pv-L4 | BaTiO₃ T_curie | Physical / HARD | **393 K (120 °C)** | CRC Handbook 105th ed. |
| Pv-L5 | PZT (rhombohedral) T_curie | Physical / HARD | 600–650 K | ASM Handbook vol. 4A |
| Pv-L6 | MAPbI₃ bandgap (300 K) | Physical / HARD | **1.55 eV (direct)** | Saliba et al. 2018 *Energy Environ. Sci.* 11, 277 |
| Pv-L7 | FAPbI₃ bandgap | Physical / HARD | **1.48 eV (direct)** | Saliba 2018 |
| Pv-L8 | CsPbI₃ (γ-phase) bandgap | Physical / HARD | **1.73 eV** | Eperon et al. 2015 |
| Pv-L9 | Perovskite single-junction PV record efficiency (certified) | Engineering / SOFT | **~ 26.1 %** (NREL Best Research-Cell Chart, 2024) | NREL chart |
| Pv-L10 | Perovskite/Si tandem PV record (certified) | Engineering / SOFT | **~ 33–34 %** (Longi / KAUST 2024) | NREL chart |
| Pv-L11 | YBa₂Cu₃O₇ T_c (cuprate, related structure) | Physical / HARD | **92 K** | Bednorz-Müller 1986 / Wu 1987 |
| Pv-L12 | Long-term stability under continuous illumination (max-power-point tracking, encapsulated) | Engineering / SOFT | **~ 1000–10000 h** for best lab cells (T80 lifetime) — far below 25-yr Si target | IEC 61215 + ISOS-L protocols |
| Pv-L13 | Lead-free perovskite (Sn²⁺-based) efficiency | Engineering / SOFT | **~ 14 % (Sn-Pb mixed)**; pure Sn ~ 10 % — UNVERIFIED for stability | NREL chart |

**Note on the 26 % efficiency record (Pv-L9).** This is small-area
(~ 0.05–1 cm²) certified single-junction. Large-area (> 100 cm²) and
mini-module efficiency is 5–8 percentage points lower. **UNPROVEN**:
large-area perovskite at certified Si-equivalent efficiency over
25-year service life.

**Note on Pv-L12 stability.** Perovskite stability under combined
heat + light + humidity (T85/85, ISOS-L-3) remains the central
commercial barrier. Best lab encapsulated cells reach ~ 1000 h T80;
industry target for Si parity is ~ 100,000 h T80. **The gap is the
HARD UNVERIFIED of the perovskite industry as of 2026.**

---

## §3 LK-99 status — HARD_WALL preserved

LK-99 (Lee, Kim, Kwon, July 2023): Cu-doped lead-apatite
"Pb₁₀₋ₓCu_x(PO₄)₆O" claimed as **room-T ambient-pressure
superconductor**.

Reproduction attempts through 2024 (Stanford, Princeton, IIT-Bombay,
Beihang, USTC, multiple PRC groups, Argonne):

- Resistance drop near 110 °C identified as **Cu₂S impurity-phase
  transition**, not superconductivity (Cu₂S exhibits structural
  transition with resistivity change in similar geometry)
- No persistent supercurrent observed
- No flux exclusion (full Meissner) observed in pure phase

**Verdict per `LIMIT_BREAKTHROUGH.md §4` and this spec:**
LK-99 room-T SC **NOT REPRODUCED** — HARD_WALL stands until peer-
reviewed reproduction. The original July 2023 preprint remains
the singleton claim; multiple Nature/Science correspondence notes
through 2024 confirm null replication.

**Structure note:** the LK-99 lead-apatite structure is **hexagonal,
NOT perovskite proper** — the original misclassification confused
the structural assignment in early commentary. The antiperovskite
family (Cu₃N etc.) is structurally distinct.

---

## §4 Real-limits-first table (continued)

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| Pv-L14 | LK-99 SC reproduction | HARD_WALL UNPROVEN | **null** at 300 K, 1 atm — multiple peer reproductions failed | LIMIT_BREAKTHROUGH.md §4 |
| Pv-L15 | Pb content in MAPbI₃-class cells (PV) | Engineering / SOFT | ~ 0.5–1 g Pb / m² module — regulatory concern in EU + JP | RoHS / WEEE policy |
| Pv-L16 | BiFeO₃ multiferroic T (room-T ferroelectric + antiferromagnetic) | Physical / HARD | T_C(ferro) ~ 1100 K, T_N(antiferro) ~ 640 K | Catalan & Scott 2009 *Adv. Mater.* 21, 2463 |

---


| Producer / source | Material focus | Reported scale | Source |
|----|----|----|----|
| Murata Manufacturing | BaTiO₃ MLCC capacitor | ~ trillion pieces/yr | Murata IR |
| TDK | BaTiO₃ MLCC + PZT actuator | not broken out | TDK IR |
| TRS Ceramics | PZT, PMN-PT single-crystal | specialty volume | company release |
| Saint-Gobain CeramTec | PZT actuator | not broken out | annual report |
| Oxford PV | perovskite/Si tandem PV | ~ 100 MW/yr nameplate (Brandenburg fab, 2024–25) | Oxford PV public |
| Saule Technologies | flexible perovskite PV | pilot scale | Saule public |
| Microquanta | perovskite PV | ~ 100 MW pilot (Quzhou, CN, 2024) | Microquanta public |
| Cambridge Photon Technology | perovskite LED | research-scale | CPT public |

> **Honesty caveat:** Murata + TDK MLCC tonnage and Oxford PV/Saule
> nameplate are vendor disclosures; capacity is bounded by feedstock
> chemistry + sintering / spin-coating throughput — not by n=6.

---

## §6 STRUCT — perovskite material flow

```
Oxide branch:
   [TiO₂ + BaCO₃ powders]      [PbO + ZrO₂ + TiO₂]
        ↓ solid-state           ↓ solid-state
        calcination 1100–1300°C  calcination
   [BaTiO₃ powder]            [PZT powder]
        ↓ ball-mill + binder       ↓ press / tape-cast
   [Green tape]                [Sintered ceramic]
        ↓ stack + co-fire           ↓ poling
   [MLCC chip]                 [PZT actuator]

Halide branch:
   [PbI₂ + MAI (or FAI)]
        ↓ solvent (DMF + DMSO) spin-coat
   [Wet film on TiO₂ / SnO₂ ETL]
        ↓ anti-solvent drop + anneal 100 °C
   [MAPbI₃ / FAPbI₃ thin film]
        ↓ HTL (spiro-OMeTAD or PTAA) + Au contact
   [Perovskite PV cell — research → Oxford PV / Microquanta production]

Antiperovskite branch:
   [Cu + N₂ at 250–350 °C]
        ↓ thin-film deposition
   [Cu₃N antiperovskite — research]
```

---

## §7 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| Oxide ceramic processing (sintering, MLCC) | `ceramics/ceramics.md`, CERAMIC-ENGINEERING.md |
| Halide perovskite as compound semiconductor | `compound-semi/compound-semi.md` |
| Lead in halide perovskite | `microplastics/microplastics.md` (environmental Pb), RoHS policy |
| Perovskite magnetism + multiferroic | `magnetic-materials/magnetic-materials.md` |
| Cuprate high-T_c SC + LK-99 status | `LIMIT_BREAKTHROUGH.md §4` |
| Perovskite PV device + tandem | `hexa-energy` (PV device level) |
| LED + photonic device | `hexa-chip` |

---

## §8 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| BaTiO₃ T_curie 393 K | CRC Handbook | Pv-L4 sanity |
| MAPbI₃ E_g 1.55 eV | Saliba 2018 | Pv-L6 sanity |
| YBCO T_c 92 K | Wu 1987 | Pv-L11 sanity |
| NREL Best Research-Cell Chart | NREL public | Pv-L9/L10 sanity |
| LK-99 null reproduction | multi-group 2023–24 peer reports | Pv-L14 sanity |
| Catalan-Scott BiFeO₃ review 2009 | *Adv. Mater.* | Pv-L16 sanity |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-Pv-1 | Perovskite single-junction PV > 28 % certified at > 100 cm² | OPEN |
| F-Pv-2 | Encapsulated perovskite T80 lifetime > 50,000 h documented | OPEN |
| F-Pv-3 | Lead-free perovskite (Sn or Bi) > 20 % certified | OPEN |
| F-Pv-4 | LK-99 peer-reviewed reproduction of zero-resistance at 300 K, 1 atm — re-baseline Pv-L14 | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "LK-99 is a true superconductor" — NOT REPRODUCED; do not write
- ✗ "26 % perovskite efficiency at large area" — small-area cell record only
- ✗ "MAPbI₃ E_g 1.55 eV fits n=6 lattice" — coincidence; do not write
- ✗ "BaTiO₃ T_curie 393 K equals σ·τ × 8.2" — coincidence; do not write


---

## §9 Honest scope + caveats

1. **Material layer only.** PV module engineering, tandem stack
   optical design, LED internal efficiency — `hexa-energy` /
   `hexa-chip`.

2. **LK-99 SC status: NOT REPRODUCED.** Preserved as HARD_WALL
   UNPROVEN per LIMIT_BREAKTHROUGH.md §4. The original July 2023
   preprint is the singleton claim; null replications in multiple
   peer-reviewed venues stand.

3. **Large-area perovskite stability is UNPROVEN.** Best encapsulated
   T80 ~ 1000 h vs Si target ~ 100,000 h. The gap is the central
   industry barrier; do not claim Si-parity lifetime.

4. **Lead-content regulatory risk preserved.** RoHS / WEEE pressure
   on MAPbI₃-class cells continues; lead-free Sn or Bi substitutions
   remain UNVERIFIED at certified efficiency + stability.

5. **No lattice anchoring of vendor numbers.** Murata / TDK / Oxford
   PV / Microquanta capacities are their published figures; this
   spec does not project onto n=6.

6. **SPEC_FIRST verdict.** All numbers cited from NREL / Saliba /
   Eperon / Wu / Catalan-Scott / vendor public disclosures.

---

## §10 References

- Saliba M., Correa-Baena J.-P., Grätzel M., Hagfeldt A., Abate A., "Perovskite Solar Cells: From the Atomic Level to Film Quality and Device Performance," *Angew. Chem.* 57, 2554 (2018) — also *Energy Environ. Sci.* 11, 277 (2018)
- Eperon G.E., Stranks S.D., Menelaou C., Johnston M.B., Herz L.M., Snaith H.J., "Formamidinium lead trihalide," *Energy Environ. Sci.* 7, 982 (2014)
- Catalan G., Scott J.F., "Physics and Applications of Bismuth Ferrite," *Adv. Mater.* 21, 2463 (2009)
- Park S.-E., Shrout T.R., "Ultrahigh strain and piezoelectric behavior in relaxor based ferroelectric single crystals," *J. Appl. Phys.* 82, 1804 (1997)
- Bednorz J.G., Müller K.A., "Possible high T_c superconductivity in the Ba–La–Cu–O system," *Z. Phys. B* 64, 189 (1986)
- Wu M.K. et al., "Superconductivity at 93 K in a new mixed-phase Y-Ba-Cu-O compound system," *Phys. Rev. Lett.* 58, 908 (1987)
- NREL — Best Research-Cell Efficiency Chart (perovskite single-junction + tandem)
- Multi-group LK-99 reproduction notes 2023–2024 (Korea Society of Superconductivity replication panel)
- Murata Manufacturing — MLCC catalog + technical bulletins
- TRS Ceramics — PZT-5H + PMN-PT datasheets
- Oxford PV — perovskite/Si tandem public statements (Brandenburg 2024)
- `LIMIT_BREAKTHROUGH.md` §4 (LK-99 HARD_WALL)
- `LATTICE_POLICY.md` §1.2 + §1.3
- Cross-link: `compound-semi/`, `ceramics/`, `magnetic-materials/`, `hexa-energy`, `hexa-chip`

---

*Authored 2026-05-13 by 박민우. Material-layer spec for Phase D
`perovskite` verb (20 of 29). LK-99 HARD_WALL UNPROVEN preserved.
No lattice fit on bandgap / efficiency / T_curie / vendor capacity.*

---

## Related NOVEL candidate

- `hxm-pv-tandem-002` — see [NOVEL.md §4.A.11](../NOVEL.md): perovskite/Si 4-terminal tandem absorber (top-cell perovskite material layer).

> SIM / proxy status is NOT a measurement and does NOT promote to `EXTERNAL-VERIFIED` without attributed external-lab evidence (NOVEL.md §7 · @F f2 / f5).
