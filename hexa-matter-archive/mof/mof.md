<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — metal-organic framework structure + BET + thermal/hydrothermal stability -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; DAC economics UNPROVEN preserved -->
---
domain: mof
requires: []
verb_group: ceramic_inorganic
status: SPEC_FIRST
verdict_basis: primary literature + BASF Basolite + Yaghi group; no lattice fit; DAC-at-cost UNPROVEN preserved
---

# MOF — n=6 소재 substrate, material verb (Phase D 24/29)

> **Material layer only.** Metal-Organic Frameworks (MOFs) — coordination
> polymers with metal-ion / metal-cluster nodes + organic linkers and
> high porosity (often > 1000 m²/g BET surface area). Workhorse families:
> HKUST-1 (Cu-BTC), MOF-5 (Zn-BDC), MOF-74 / CPO-27, ZIF-8 / ZIF-67,
> UiO-66 / UiO-67, MIL-101, NU-1101, MOF-210. **Industrial-scale CO₂
> direct air capture (DAC) economics UNPROVEN.**

> values cite primary literature (Yaghi group MOF-210; Hupp NU-1101).
> BASF Basolite production figures cite BASF technical bulletins. **No
> claim of lattice-anchored MOF property.** Magic-MOF-DAC-economics
> claim preserved as **UNPROVEN**.

---

## §1 WHY — why MOF belongs in hexa-matter

A **Metal-Organic Framework (MOF)** is a crystalline coordination
polymer with:
- Metal-ion or metal-cluster nodes (Zn₄O, Cu₂ paddlewheel, Zr₆O₈, Cr₃O, etc.)
- Organic linker ligands (BDC, BTC, dobdc, MeIM, pyrene-tetracarboxylate)
- Highly porous structure (often > 1000 m²/g BET; some > 6000 m²/g)

MOFs are a **CER ∩ POL hybrid** — covalent organic skeleton bonded to
an inorganic metal-ion node. Crystalline ordering is closer to CER
(ABX framework); synthesis is closer to POL (solvothermal, ligand
exchange). For taxonomy we place this verb in GROUP_CER.

---

## §2 Real-limits-first — MOF's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| MOF-L1 | HKUST-1 (Cu-BTC) BET surface area | Engineering / SOFT | **1500–1700 m²/g** | Chui et al. 1999 *Science* 283, 1148 |
| MOF-L2 | MOF-5 (IRMOF-1, Zn₄O-BDC) BET surface area | Engineering / SOFT | **2900–3800 m²/g** | Eddaoudi-Yaghi 2002 *Science* 295, 469 |
| MOF-L3 | MOF-74 (M-CPO-27) BET, M=Mg | Engineering / SOFT | **1300–1900 m²/g** | Caskey-Long 2008 *J. Am. Chem. Soc.* 130, 10870 |
| MOF-L4 | ZIF-8 (Zn-MeIM) BET | Engineering / SOFT | **1500–1800 m²/g** | Park-Yaghi 2006 *PNAS* 103, 10186 |
| MOF-L5 | UiO-66 (Zr₆O₈-BDC) BET | Engineering / SOFT | **1100–1400 m²/g** | Cavka-Lillerud 2008 *J. Am. Chem. Soc.* 130, 13850 |
| MOF-L6 | UiO-67 (Zr₆O₈-BPDC) BET | Engineering / SOFT | **2300–2600 m²/g** | Cavka 2008 |
| MOF-L7 | MIL-101(Cr or Fe) BET | Engineering / SOFT | **3000–4500 m²/g** | Férey 2005 *Science* 309, 2040 |
| MOF-L8 | NU-1101 (Zr-pyrene) BET | Engineering / SOFT | **~ 5500 m²/g** | Hupp/Farha 2012 |
| MOF-L9 | MOF-210 (Be₄O-terphenyl) BET | Engineering / SOFT | **~ 6240 m²/g** | Furukawa-Yaghi 2010 *Science* 329, 424 |
| MOF-L10 | Theoretical BET ceiling (defect-free hypothetical MOF) | Physical / HARD | **~ 7000–8000 m²/g** (calculation) | Düren-Snurr 2008 |
| MOF-L11 | ZIF-8 hydrothermal stability | Physical / HARD | stable to **~ 300 °C** in dry air; degrades in liquid water at high T | Park-Yaghi 2006 |
| MOF-L12 | UiO-66 water stability | Physical / HARD | stable in boiling water (rare for MOF) | Cavka 2008 |
| MOF-L13 | MOF-74 (Mg) CO₂ capture capacity (1 atm, dry) | Engineering / SOFT | **5.8 mmol/g (25 °C, 0.15 atm CO₂)** | Caskey 2008 |
| MOF-L14 | MOF-177 H₂ uptake at 77 K, 70 bar | Engineering / SOFT | **75 mg/g** (early MOF record) | Furukawa 2007 |
| MOF-L15 | Pore size range (commercial MOFs) | Engineering / SOFT | **0.3 nm (ZIF-8) – 4.7 nm (MOF-210 cage)** | various |

**Note on the 6000–8000 m²/g BET ceiling (MOF-L8/L9/L10).** NU-1101
+ MOF-210 hold the practical ~ 6000–6500 m²/g BET ceiling — close to
the theoretical maximum (~ 7000 m²/g for hypothetical defect-free
graphene; ~ 8000 m²/g for hypothetical optimal MOF per Düren-Snurr
2008 calculations). Beyond this, the framework would not have enough
atomic surface to expose.

**Note on water stability (MOF-L11, L12).** Most MOFs are
**moisture-sensitive** (HKUST-1, MOF-5) and decompose in humid air.
The Zr-based UiO-66 / UiO-67 family + ZIF-8 are the exception
(water-stable), which is why they dominate practical-application
literature. **UNVERIFIED in this repo**: long-term cycle stability
under full industrial conditions.

---

## §3 Direct air capture (DAC) of CO₂ — UNPROVEN at economics

The popular claim that MOFs will enable cost-effective direct air
capture of CO₂ at gigatonne scale:

**Verdict per `LIMIT_BREAKTHROUGH.md §4` and this spec: UNPROVEN at
industrial economics.**

Status as of 2026:
- MOF-74 (Mg) demonstrates 5.8 mmol/g CO₂ at 0.15 atm (Caskey 2008) — laboratory benchmark, not industrial
- Climeworks (Switzerland) operates DAC at ~ 4–10 kt CO₂/yr scale using **solid amine sorbent**, NOT MOF — current ~ $600–1000/t CO₂ cost
- Carbon Engineering (Canada) uses **liquid KOH absorption**, NOT MOF — projected $100–250/t at GW scale (not yet demonstrated)
- MOF-based DAC remains research-stage; no published gigatonne-scale demonstration

The 2 °C climate-target cost target (often cited ~ $100/t CO₂) is
**a target, not a demonstrated MOF achievement**. Honest distinction
preserved.

**Anti-claim:** do NOT write "MOF makes DAC viable at $100/t" — this
is UNVERIFIED at industrial scale.

---

## §4 Real-limits-first table (continued)

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| MOF-L16 | DAC economics with MOF sorbent | UNPROVEN | **target $100/t; demonstrated $600–1000/t (Climeworks, amine-based, not MOF)** | Climeworks IR 2024 |
| MOF-L17 | Methane storage (ANG) MOF capacity, room T, 35 bar | Engineering / SOFT | best MOF ~ 200–230 cm³(STP)/cm³ | Gándara-Yaghi 2014 |

---


| Producer | MOF focus | Reported scale | Source |
|----------|-----------|----------------|--------|
| BASF (Basolite series) | C 300 (HKUST-1), Z 1200 (ZIF-8), F 300 (Fe-BTC), A 100 (MOF-5) | first commercial MOF (2008–); kg–t scale | BASF Basolite technical bulletin |
| Mitsubishi Chemical | MOF / coordination polymer research-scale | kg scale | Mitsubishi public |
| MOFapps / NuMat | gas storage cylinders (ION-X for electronic-grade gas) | commercial | NuMat public |
| Promethean Particles | nano-MOF synthesis | research / pilot | company public |
| H2MOF (Hong Kong) | H₂ storage MOF | research / pilot | H2MOF public |
| Atomis | MOF coatings + sorbent | research / pilot | Atomis public |
| Cambridge Crystallographic Data Centre (CCDC) | MOF structure database | open | CCDC public |

> **Honesty caveat (LATTICE_POLICY §3.3):** BASF Basolite production
> tonnage is t-scale, not kt-scale. Industrial MOF market is in early
> commercial maturation. Capacity is bounded by solvothermal reactor
> count + ligand cost (BDC, BTC, MeIM precursor synthesis) — not by
> n=6.

---

## §6 STRUCT — MOF material flow

```
[Metal salt (Cu(NO₃)₂, Zn(NO₃)₂, ZrCl₄)]    [Organic linker (BDC, BTC, MeIM)]
        ↓                                            ↓
        └────────[DMF or DEF solvent, 80–150 °C]────┘
                       ↓ solvothermal, 12–72 h
                  [MOF crystal suspension]
                       ↓ filter + wash + dry + activate (vacuum / supercritical CO₂)
                  [Activated MOF powder, surface area developed]
                       ↓
       ┌───────────────┼───────────────┬─────────────┐
       ↓               ↓               ↓             ↓
   [Pellet / granule for fixed-bed sorbent]
   [Slurry for membrane / coating]
   [Nano-MOF for catalysis or drug delivery]
   [Composite — MOF + polymer (MMM = Mixed Matrix Membrane)]

COF (Covalent-Organic Framework) parallel branch:
   [Aromatic boronic acid + diol] OR [aromatic amine + aldehyde]
        ↓ reflux in dioxane / mesitylene
   [COF — TpPa-1, COF-5, etc.]
   — all-organic skeleton (no metal node), higher hydrolytic stability
```

---

## §7 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | MOF-5 / HKUST-1 (1999–2002) | Research → BASF commercial (2008) |
| Mk.II | ZIF-8 + UiO-66 water-stable (2006–08) | Commercial workhorse |
| Mk.III | MOF-210 ultra-high BET 6240 m²/g (2010) | Research |
| Mk.IV | MOF-74 CO₂ capture at low partial pressure | Research / DAC R&D |
| Mk.V | MOF-based DAC at $100/t target | UNPROVEN at gigatonne scale |
| Mk.VI | COF as all-organic alternative | Research |
| Mk.VII | MOF drug-delivery (porous-Fe-MIL-100 for cancer therapy) | Pre-clinical |
| Mk.VIII | MOF-based H₂ storage > 6 wt % at 77 K, 70 bar | UNVERIFIED at room T |

---

## §8 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| Metal-node ceramic side | `ceramics/ceramics.md`, CERAMIC-ENGINEERING.md |
| Organic linker chemistry | POLYMER-CHEMISTRY.md |
| Solvothermal synthesis | `synthesis/material-synthesis.md`, MATERIAL-SYNTHESIS.md |
| MOF drug delivery | `hexa-bio` |
| MOF-DAC for CO₂ | `hexa-earth` (climate) — UNPROVEN at industrial scale |
| MOF H₂ storage | `hexa-energy` |
| Zeolite + porous-ceramic cousin | `ceramics/ceramics.md` |

---

## §9 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| MOF-210 BET 6240 m²/g | Furukawa-Yaghi 2010 | MOF-L9 sanity |
| MOF-74 (Mg) CO₂ 5.8 mmol/g | Caskey-Long 2008 | MOF-L13 sanity |
| UiO-66 water stability | Cavka-Lillerud 2008 | MOF-L12 sanity |
| Düren-Snurr theoretical BET ceiling | Düren 2008 | MOF-L10 sanity |
| BASF Basolite catalog | BASF technical bulletin | scale sanity |
| Climeworks DAC cost $600–1000/t | Climeworks IR 2024 | MOF-L16 / DAC anti-claim |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-MOF-1 | Commercial MOF BET > 7000 m²/g at production yield | OPEN |
| F-MOF-2 | MOF-based DAC at < $100/t at Mt-scale demonstrated | OPEN |
| F-MOF-3 | MOF H₂ storage > 6 wt % at 298 K, 100 bar | OPEN |
| F-MOF-4 | MOF drug-delivery FDA approval (Phase III) | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "MOF makes DAC viable at $100/t" — UNPROVEN at gigatonne
- ✗ "MOF-210 BET 6240 m²/g equals σ·φ × 260" — coincidence
- ✗ "ZIF-8 pore size 0.34 nm fits n=6 lattice" — coincidence
- ✗ "BASF Basolite tonnage follows n=6" — no



---

## §10 Honest scope + caveats

1. **Material layer only.** DAC plant engineering, drug-delivery
   clinical trials, H₂ storage tank design — `hexa-earth` /
   `hexa-bio` / `hexa-energy`.

2. **DAC at $100/t with MOF is UNPROVEN.** Climeworks ~ $600–1000/t
   uses amine, not MOF. Honest distinction preserved.

3. **Most MOFs are moisture-sensitive.** Water-stable subset (UiO,
   ZIF) is the practical workhorse; do not over-generalize.

4. **No lattice anchoring of vendor numbers or BET values.** BASF
   Basolite / NuMat / Promethean / H2MOF / Atomis tonnage cited
   verbatim.

5. **SPEC_FIRST verdict.** All numbers from primary literature
   (Yaghi / Hupp / Férey / Cavka / Lillerud / Caskey / Long /
   Düren / Snurr) or vendor technical bulletins.

6. **Coincidence disclosure (LATTICE_POLICY §1.1).** Any apparent
   numerical fit to n=6 is coincidence.

---

## §11 References

- Chui S.S.-Y., Lo S.M.-F., Charmant J.P.H., Orpen A.G., Williams I.D., "A chemically functionalizable nanoporous material [Cu₃(TMA)₂(H₂O)₃]_n," *Science* 283, 1148 (1999) — HKUST-1
- Eddaoudi M., Kim J., Rosi N., Vodak D., Wachter J., O'Keeffe M., Yaghi O.M., "Systematic Design of Pore Size and Functionality in Isoreticular MOFs," *Science* 295, 469 (2002) — MOF-5
- Park K.S., Ni Z., Côté A.P., Choi J.Y., Huang R., Uribe-Romo F.J., Chae H.K., O'Keeffe M., Yaghi O.M., "Exceptional chemical and thermal stability of zeolitic imidazolate frameworks," *PNAS* 103, 10186 (2006) — ZIF-8
- Cavka J.H., Jakobsen S., Olsbye U., Guillou N., Lamberti C., Bordiga S., Lillerud K.P., "A new zirconium inorganic building brick forming MOFs with exceptional stability," *J. Am. Chem. Soc.* 130, 13850 (2008) — UiO-66
- Caskey S.R., Wong-Foy A.G., Matzger A.J., "Dramatic Tuning of Carbon Dioxide Uptake via Metal Substitution in a Coordination Polymer with Cylindrical Pores," *J. Am. Chem. Soc.* 130, 10870 (2008) — MOF-74
- Férey G., Mellot-Draznieks C., Serre C., Millange F., Dutour J., Surblé S., Margiolaki I., "A Chromium Terephthalate-Based Solid with Unusually Large Pore Volumes and Surface Area," *Science* 309, 2040 (2005) — MIL-101
- Furukawa H., Ko N., Go Y.B., Aratani N., Choi S.B., Choi E., Yazaydin A.Ö., Snurr R.Q., O'Keeffe M., Kim J., Yaghi O.M., "Ultrahigh Porosity in Metal-Organic Frameworks," *Science* 329, 424 (2010) — MOF-210
- Düren T., Bae Y.-S., Snurr R.Q., "Using molecular simulation to characterise metal-organic frameworks for adsorption applications," *Chem. Soc. Rev.* 38, 1237 (2009) — theoretical BET ceiling
- BASF — Basolite technical bulletin (C 300, Z 1200, F 300, A 100)
- Climeworks — annual report 2024 (DAC cost benchmark, amine-based)
- `LIMIT_BREAKTHROUGH.md` (Wave M)
- `LATTICE_POLICY.md` §1.2 + §1.3
- Cross-link: `ceramics/`, `synthesis/`, `hexa-bio`, `hexa-earth`, `hexa-energy`

---

*Authored 2026-05-13 by 박민우. Material-layer spec for Phase D
`mof` verb (24 of 29). Magic-MOF-DAC-economics UNPROVEN preserved.
No lattice fit on BET / pore size / capacity / vendor scale.*

---

## Related NOVEL candidates

- `hxm-co2-cap-mof-mfm-002` — see [NOVEL.md §4.F.1](../NOVEL.md): MOF direct-air-capture sorbent.
- `hxm-mof-h2o-stable-uio66-001` — see [NOVEL.md §4.D.13](../NOVEL.md): water-stable UiO-66 MOF.

> SIM / proxy status is NOT a measurement and does NOT promote to `EXTERNAL-VERIFIED` without attributed external-lab evidence (NOVEL.md §7 · @F f2 / f5).
