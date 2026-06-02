<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — wood structure, engineered wood (CLT/glulam/LVL), nanocellulose (CNF/CNC), regenerated cellulose -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; USDA Wood Handbook anchored -->
---
domain: wood-cellulose
requires: []
verb_group: fiber_paper
status: SPEC_FIRST
verdict_basis: USDA Wood Handbook (FPL Madison) + TAPPI + nanocellulose primary literature + vendor; no lattice fit
---

# Wood / Cellulose — n=6 소재 substrate, material verb (Phase D 28/29)

> **Material layer only.** Wood structure (softwood / hardwood),
> engineered wood (plywood, LVL, glulam, CLT — mass timber),
> nanocellulose (CNF cellulose nanofibril + CNC cellulose nanocrystal),
> regenerated cellulose (viscose / lyocell), cellulose acetate.
> **Forestry agronomy + timber yield** lives in `hexa-farm`; **building
> construction** in `hexa-arch` or downstream verbs.

> data from USDA Wood Handbook (USDA-FPL Madison WI) + Saito et al.
> nanocellulose literature. Stora Enso / UPM / Daicel / BORREGAARD /
> CelluForce / FiberLean vendor figures cited verbatim. No lattice
> projection.

---

## §1 WHY — why wood-cellulose belongs in hexa-matter

Wood is a composite material:
- **Cellulose** (~ 40–50 % of dry mass): β-1,4-linked D-glucose polymer; crystalline microfibrils (~ 3 nm wide × ~ µm long)
- **Hemicellulose** (~ 20–30 %): branched short-chain polysaccharides (xylan, glucomannan)
- **Lignin** (~ 20–30 %): aromatic 3D phenolic polymer; primary load-bearing matrix
- **Extractives** (~ 1–5 %): resins, tannins, terpenoids

The material substrate covers wood as engineered material + its
derivatives (nanocellulose, regenerated cellulose, cellulose acetate).
Paper has its own verb `paper/paper.md` and is referenced from here.

---

## §2 Real-limits-first — wood/cellulose's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| WC-L1 | Cellulose crystalline density | Physical / HARD | **1.59 g/cm³** (Iα + Iβ allomorph) | French 2014 *Cellulose* 21, 885 |
| WC-L2 | Cellulose theoretical tensile σ (per Frenkel L1) | Physical / SOFT | **~ 17 GPa** | Saito et al. 2013 |
| WC-L3 | CNC measured tensile σ_f | Engineering / SOFT | **~ 5 GPa** (single-crystal) | Saito 2013 |
| WC-L4 | CNC Young's modulus E | Engineering / SOFT | **100–150 GPa** | Saito 2013 |
| WC-L5 | CNF (cellulose nanofibril) σ_f | Engineering / SOFT | 2–4 GPa | Saito 2013 |
| WC-L6 | Softwood (southern pine, clear) | Engineering / SOFT | ρ 0.55 g/cm³, E 14 GPa, σ_f 100 MPa (parallel-to-grain) | USDA Wood Handbook 2010 |
| WC-L7 | Hardwood (oak white, clear) | Engineering / SOFT | ρ 0.68, E 12 GPa, σ_f 96 MPa | USDA Wood Handbook |
| WC-L8 | Balsa | Engineering / SOFT | ρ 0.16, E 3 GPa, σ_f 18 MPa | USDA |
| WC-L9 | Bamboo (Moso, technically grass) | Engineering / SOFT | ρ 0.6–0.9, E 15–20 GPa, σ_f 100–200 MPa | Research lit. |
| WC-L10 | CLT (Cross-Laminated Timber) panel rolling shear | Engineering / SOFT | 1.0–1.5 MPa | ANSI/APA PRG 320 |
| WC-L11 | Glulam (glued-laminated timber) MOE class | Engineering / SOFT | 8–13 GPa (varies by lamstock + grade) | APA / EN 14080 |
| WC-L12 | Cellulose crystallinity index (CrI, native cotton vs wood pulp) | Engineering / SOFT | cotton ~ 80 %; wood pulp 60–70 %; tunicate ~ 90 % | TAPPI T 271 |
| WC-L13 | Fire rating w/ flame retardant (CLT or treated wood) | Engineering / SOFT | up to 2 h fire-resistance with FRT (fire-retardant treatment) per ASTM E119 + char depth 0.6–0.8 mm/min | ASTM E119, AWC |
| WC-L14 | Mass-timber max building height (engineered) | Engineering / SOFT | **~ 25 stories** (Ascent MKE Milwaukee, 86 m, 2022) | International Building Code 2021 + Ascent project |
| WC-L15 | Specific σ_f / ρ for wood | Engineering / SOFT | southern pine ~ 182 kN·m/kg vs steel mild ~ 51 — wood beats steel | USDA + Ashby tradition |
| WC-L16 | Wood moisture-content equilibrium (interior) | Engineering / SOFT | 6–12 % MC (12 % at 65 % RH, 20 °C) | USDA Wood Handbook |

**Note on cellulose theoretical σ (WC-L2/L3).** Cellulose's calculated
theoretical strength ~ 17 GPa (per Frenkel σ_th = E/10 with E ~ 150
GPa for the chain). Measured CNC reaches ~ 5 GPa — about 30 % of
theoretical, defect-limited. Same Frenkel pattern as all engineering
materials (LIMIT_BREAKTHROUGH.md L1).

**Note on specific σ (WC-L15).** Wood (southern pine specific σ_f /
ρ ≈ 182 kN·m/kg) **beats mild steel** (51 kN·m/kg) on
strength-to-weight. This drives the 2020s mass-timber construction
trend (CLT, mass plywood panel MPP, glulam).

**Note on mass-timber height (WC-L14).** Ascent MKE (Milwaukee, 86 m,
25 stories, 2022) is the current world's tallest mass-timber building
as of 2026. IBC 2021 allows wood construction up to 18 stories under
Type IV-A. **UNVERIFIED in this repo**: 50+ story mass-timber
building feasibility.

---


| Producer | Material focus | Reported scale | Source |
|----------|----------------|----------------|--------|
| Stora Enso | engineered wood (CLT, LVL, glulam) + pulp + paperboard | ~ €11 B revenue (2024) | Stora Enso IR |
| UPM (UPM-Kymmene) | engineered wood + pulp + paper | ~ €11 B (2024) | UPM IR |
| SmartLam (USA) | CLT mass-timber panel | ~ 50,000 m³/yr | SmartLam public |
| KLH Massivholz (Austria) | CLT | major | KLH public |
| Boise Cascade | OSB + LVL + glulam | ~ $7 B (2024) | Boise Cascade IR |
| Weyerhaeuser | engineered wood + lumber | ~ $7 B (2024) | Weyerhaeuser IR |
| West Fraser | OSB + lumber + LVL | major NA producer | West Fraser IR |
| Daicel Corporation | cellulose acetate + cellulose ester | major | Daicel IR |
| Eastman Chemical | cellulose acetate (Eastman) | ~ 200 kt CA | Eastman IR |
| Celanese (Acetate Filament) | cellulose acetate | ~ 100 kt | Celanese IR |
| BORREGAARD (Norway) | CNF, lignin, vanillin | CNF ~ 1–2 kt | BORREGAARD IR |
| CelluForce (Canada) | CNC | pilot scale | CelluForce public |
| FiberLean (UK) | nanocellulose (MFC) | commercial | FiberLean public |
| Sappi | dissolving pulp + CNF | major | Sappi IR |
| Lenzing AG | viscose + lyocell (Tencel) | ~ 1 Mt fiber | Lenzing IR |

> **Honesty caveat (LATTICE_POLICY §3.3):** Stora Enso / UPM / Sappi /
> Lenzing capacities are in Mt/yr (pulp + commodity); engineered-wood
> capacity in 10 kt–100 kt-m³/yr range. Nanocellulose still at kt-scale
> commercial. No projection onto n=6.

---

## §4 STRUCT — wood/cellulose material flow

```
[Standing tree — softwood (pine/spruce/fir) or hardwood (oak/maple/birch)]
        ↓ harvest + skid + transport (→ hexa-farm out-of-scope)
[Saw log]
        ↓ sawmill (live-sawn / quarter-sawn / flat-sawn)
[Lumber, kiln-dried to 12 % MC]
        ↓
        ┌────────────┬───────────────┬───────────────┐
        ↓            ↓               ↓               ↓
   [Solid lumber] [Veneer]        [Strand]        [Chip]
                     ↓               ↓               ↓
                 [Plywood / LVL]  [OSB]          [Pulping] (→ paper/, viscose, etc.)
                     ↓               ↓
                 [Engineered      [Mass-timber
                  beams,           panel (CLT, MPP)]
                  rails]
                     ↓               ↓
                  [Construction — IBC 2021 Type IV-A allows 18-story]

Nanocellulose branch:
   [Wood pulp or cotton linters]
        ↓ acid hydrolysis (H₂SO₄ 64 %, 45 °C) for CNC
   [CNC suspension, 5–20 nm × 100–300 nm rods]
        ↓
   [Spray-dry or freeze-dry → CNC powder]
        ↓ application: barrier coating, hydrogel, reinforcement

   [Wood pulp]
        ↓ TEMPO oxidation + high-pressure homogenization for CNF
   [CNF suspension, branched, µm-long]
        ↓
   [Wet film or aerogel → CNF product]

Regenerated cellulose (viscose / lyocell):
   [Dissolving pulp]
        ↓ NaOH + CS₂ (viscose) or NMMO (lyocell / Tencel)
   [Solubilized cellulose dope]
        ↓ wet-spinning through spinneret
   [Regenerated cellulose fiber] → textile

Cellulose acetate:
   [Dissolving pulp]
        ↓ acetic anhydride esterification
   [Cellulose acetate flake]
        ↓ dry-spin or melt-extrude
   [Cigarette filter, fiber, eyewear frame]
```

---

## §5 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | Glulam (1860s Otto Hetzer patent) | Commodity |
| Mk.II | Plywood (1905+) | Commodity |
| Mk.III | LVL + OSB (1970s) | Commodity |
| Mk.IV | CLT (Cross-Laminated Timber, 1990s Austria) | Commercial 2010s+ |
| Mk.V | Mass-plywood panel (MPP, Freres Lumber 2018+) | Commercial |
| Mk.VI | 25-story mass-timber building (Ascent MKE 2022) | Demonstrated |
| Mk.VII | CNC commercial film coating / barrier | Commercial niche |
| Mk.VIII | Transparent wood (lignin-removed + polymer-infiltrated) | R&D — UNVERIFIED at production cost |
| Mk.IX | Densified wood matching steel σ (Hu et al. 2018) | R&D — UNVERIFIED at construction scale |
| Mk.X | 50+ story mass-timber | UNVERIFIED |

---

## §6 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| Paper pulp processing | `paper/paper.md`, PAPER.md |
| Natural-fiber textile (cotton, linen, hemp, jute) | `fabric/hexa-fabric.md`, HEXA-FABRIC.md |
| Cellulose-derived bioplastic (CA, regenerated cellulose) | `biodegradable-plastics/biodegradable-plastics.md` |
| Polymer chemistry | POLYMER-CHEMISTRY.md |
| Forestry agronomy + timber yield | `hexa-farm` |
| Lignin enzyme chemistry (white-rot fungi) | `hexa-bio` |
| Carbon sequestration via mass timber | `hexa-earth` |
| Building construction code (IBC) | `hexa-arch` (or downstream) |
| Recycling of wood-product waste | `recycle_n6/`, `recycling/` |

---

## §7 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| USDA Wood Handbook 2010 | USDA-FPL | WC-L6 / L7 / L8 / L15 / L16 sanity |
| Cellulose Iβ density 1.59 g/cm³ | French 2014 | WC-L1 sanity |
| CNC σ_f 5 GPa | Saito 2013 | WC-L3 sanity |
| CNC E 100–150 GPa | Saito 2013 | WC-L4 sanity |
| ANSI/APA PRG 320 (CLT) | APA | WC-L10 sanity |
| ASTM E119 fire test | ASTM | WC-L13 sanity |
| TAPPI T 271 crystallinity | TAPPI | WC-L12 sanity |
| Ascent MKE 25-story | International Mass Timber Conference 2022 | WC-L14 sanity |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-WC-1 | 50-story mass-timber building completed | OPEN |
| F-WC-2 | Densified wood at production scale matching steel σ_f | OPEN |
| F-WC-3 | Transparent wood window market deployment | OPEN |
| F-WC-4 | CNC at < $5/kg at Mt-scale | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "CNC σ_f 5 GPa equals σ·τ × 0.104" — coincidence
- ✗ "Cellulose density 1.59 g/cm³ fits n=6" — coincidence
- ✗ "Stora Enso / UPM revenue follows n=6" — they have not heard of it
- ✗ "Wood replaces all steel" — only mass-timber narrow niche

---

## §8 Honest scope + caveats

1. **Material layer only.** Forestry agronomy (rotation period, yield
   per hectare), timber harvesting equipment, supply-chain logistics
   — `hexa-farm`. Building structural design and IBC code compliance
   — `hexa-arch` or downstream.

2. **Mass-timber height UNVERIFIED beyond ~ 25 stories.** Ascent MKE
   (86 m) is the current world's tallest; 50+ story remains R&D.

3. **Transparent wood + densified wood UNVERIFIED at production
   scale.** Mk.VIII–IX in §5 are R&D-only as of 2026.

4. **Nanocellulose still at kt-scale commercial.** BORREGAARD +
   CelluForce + FiberLean combined ~ 1–5 kt/yr in 2024 — far from
   commodity scale.

5. **No lattice anchoring of vendor numbers or USDA Wood Handbook
   values.** Stora Enso / UPM / Sappi / Lenzing / Eastman / Celanese
   / Daicel / BORREGAARD / CelluForce / FiberLean capacities cited
   verbatim.

6. **SPEC_FIRST verdict.** All numbers from USDA Wood Handbook 2010,
   French 2014, Saito 2013, TAPPI / ANSI / APA / ASTM standards, and
   vendor public disclosures.


---

## §9 References

- USDA Forest Products Laboratory, *Wood Handbook: Wood as an Engineering Material*, FPL-GTR-190 (2010 edition)
- French A.D., "Idealized powder diffraction patterns for cellulose polymorphs," *Cellulose* 21, 885 (2014)
- Saito T. et al., "Self-Aligned Integration of Native Cellulose Nanofibrils Towards Producing Diverse Bulk Materials," *Soft Matter* 7, 8804 (2011); Saito 2013 nanocellulose property review
- Klemm D., Heublein B., Fink H.-P., Bohn A., "Cellulose: Fascinating Biopolymer and Sustainable Raw Material," *Angew. Chem.* 44, 3358 (2005)
- Hu L., Song J., et al., "Processing bulk natural wood into a high-performance structural material," *Nature* 554, 224 (2018)
- ANSI/APA PRG 320 — Standard for Performance-Rated Cross-Laminated Timber
- ASTM E119 — Fire Tests of Building Construction and Materials
- TAPPI T 271 — Crystallinity index by XRD
- International Building Code 2021 — Type IV-A mass-timber provisions
- Stora Enso / UPM / Sappi / Lenzing — annual reports
- BORREGAARD / CelluForce / FiberLean — nanocellulose public statements
- Eastman / Celanese / Daicel — cellulose acetate datasheets
- `paper/paper.md` + PAPER.md
- `fabric/hexa-fabric.md` + HEXA-FABRIC.md
- `biodegradable-plastics/biodegradable-plastics.md`
- `LATTICE_POLICY.md` §1.2 + §1.3
- `LIMIT_BREAKTHROUGH.md` (Wave M)

---

*Authored 2026-05-13 by 박민우. Material-layer spec for Phase D
`wood-cellulose` verb (28 of 29). USDA Wood Handbook anchored.
No lattice fit on wood properties / CNC properties / vendor capacity.
Forestry agronomy + building code out of scope.*

---

## Related NOVEL candidate

- `hxm-mycel-composite-001` — see [NOVEL.md §4.F.13](../NOVEL.md): mycelium-bound biocomposite.

> SIM / proxy status is NOT a measurement and does NOT promote to `EXTERNAL-VERIFIED` without attributed external-lab evidence (NOVEL.md §7 · @F f2 / f5).
