# WOOD-CELLULOSE — Phase D candidate stub

> **Authored**: 2026-05-13 (Phase A elevation) · **Status**: STUB — Phase D roadmap marker
> **Author**: 박민우 <nerve011235@gmail.com>
> **Target group**: GROUP_FIB · **Phase D priority**: MEDIUM
>
> Stub placeholder for the Phase D `wood-cellulose` verb covering wood structure,
> lignocellulose, nanocellulose (CNC, CNF), engineered wood products.

---

## §1 Scope

Wood is a composite of:
- **Cellulose** (~ 40-50% of dry mass): β-1,4-linked D-glucose polymer; crystalline microfibrils (~ 3 nm wide)
- **Hemicellulose** (~ 20-30%): branched short-chain polysaccharides (xylan, glucomannan)
- **Lignin** (~ 20-30%): aromatic 3D polymer; primary load-bearing matrix
- **Extractives** (~ 1-5%): resins, tannins, terpenoids

The material substrate covers wood as engineered material (lumber, glulam, CLT) and its derivatives (nanocellulose CNC + CNF, regenerated cellulose film, paper — though paper has its own verb `paper/paper.md`).

---

## §2 Wood structure axes

| Anatomy | Description |
|---------|-------------|
| Softwood (gymnosperm; pine, spruce, fir) | tracheid cells; lower density (~ 0.3-0.5 g/cm³); long fiber (3-5 mm); paper pulp + construction |
| Hardwood (angiosperm; oak, maple, birch) | vessel + fiber cells; higher density (~ 0.4-1.1 g/cm³); shorter fiber (1-2 mm); furniture + flooring |
| Engineered wood (plywood, OSB, LVL, glulam, CLT) | adhesive-bonded laminates / strands | construction substitute for solid lumber |
| Mass timber (CLT — Cross-Laminated Timber) | layered + perpendicular grain | mid-rise building (10+ story wood construction 2020s) |

---

## §3 Nanocellulose (CNC + CNF)

**CNC (Cellulose Nanocrystal)** — short rod-shaped crystalline cellulose, typically 5-20 nm × 100-300 nm, produced by acid hydrolysis of pulp (typically H₂SO₄).

| Property | CNC | Source |
|----------|-----|--------|
| Tensile strength | 7.5 GPa (calc.) - 5 GPa (measured) | Saito et al. 2013 |
| Young's E | 100-150 GPa | Saito 2013 |
| Density | 1.6 g/cm³ | calculated |
| Specific E | 65-95 GN·m/kg | vs steel 25 |

**CNF (Cellulose Nanofibril)** — branched, longer (~ µm), softer, partial crystalline; produced by mechanical disintegration of pulp (TEMPO oxidation + high-pressure homogenization).

Production: BORREGAARD (Norway), CelluForce (Canada), FiberLean (UK), Sappi (South Africa). Combined commercial production ~ 1-5 kt/yr in 2024.

---

## §4 Wood mechanical properties (clear wood, parallel-to-grain)

| Species | ρ (g/cm³) | E (GPa) | σ_f (MPa) | Source |
|---------|-----------|---------|-----------|--------|
| Balsa | 0.16 | 3 | 18 | USDA Wood Handbook |
| Southern pine | 0.55 | 14 | 100 | USDA |
| Douglas fir | 0.48 | 14 | 88 | USDA |
| Oak (white) | 0.68 | 12 | 96 | USDA |
| Maple (sugar) | 0.63 | 12 | 95 | USDA |
| Birch (yellow) | 0.62 | 14 | 110 | USDA |
| Bamboo (Moso) | 0.6-0.9 | 15-20 | 100-200 | research lit. (technically grass, not wood) |
| Lignum vitae | 1.23 | 18 | 120 | USDA |

Compare specific strength σ_f / ρ:
- Balsa: 18 / 0.16 = 113 kN·m/kg
- Southern pine: 100 / 0.55 = 182 kN·m/kg
- Oak: 96 / 0.68 = 141 kN·m/kg
- Steel (mild): 400 / 7.8 = 51 kN·m/kg
- CFRP: 1500 / 1.6 = 940 kN·m/kg
- CNC (calc): 7500 / 1.6 = 4700 kN·m/kg

Wood has **better specific strength than steel** — a fact that drives the 2020s mass-timber construction trend.

---

## §5 Real-limit anchors (planned)

- L1 Frenkel σ_th — cellulose theoretical σ ~ 17 GPa; CNC measured 5 GPa → ~ 30% of theoretical
- L3 specific σ — CNC at 4700 kN·m/kg is in the same OOM as Kevlar (2500), UHMWPE (3700)
- L11 Kepler packing — cellulose microfibril packing density relevant for wood density limits

---

## §6 Cross-links (when expanded)

- `paper/paper.md` + `PAPER.md` — paper pulp processing
- `fabric/fabric.md` + `HEXA-FABRIC.md` — natural-fiber textile (cotton is cellulose; linen, hemp, jute are cellulosic)
- `POLYMER-CHEMISTRY.md` — cellulose as natural polymer
- `BIODEGRADABLE-PLASTICS.md` stub — cellulose acetate, regenerated cellulose
- `hexa-farm` — forestry, timber production
- `hexa-bio` — wood biology + lignin enzyme chemistry
- `hexa-earth` — carbon sequestration via mass timber

---

## §7 Honest C3

Phase D candidate. Stub-level. Mechanical property data cited from USDA Wood Handbook (USDA-FPL Madison WI) + Saito et al. nanocellulose literature. Nanocellulose commercial production figures cite BORREGAARD / CelluForce / FiberLean public statements. No lattice fit. Per `LATTICE_POLICY §1.2`.

---

*Stub authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase D roadmap marker.*
