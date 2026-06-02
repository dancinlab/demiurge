<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — elastomer chemistry, vulcanization, filler reinforcement -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; no lattice anchoring of elastomer parameters -->
---
domain: elastomer
requires: []
verb_group: polymer
status: SPEC_FIRST
verdict_basis: vendor-published numbers + ASTM/ISO; no lattice fit
---

# Elastomer — n=6 소재 substrate, material verb (Phase D 18/29)

> **Material layer only.** Elastomeric polymers with low T_g + cross-linked
> long-chain backbone giving reversible elastic deformation (typical
> strain-to-fail 200–1000 % at near-zero permanent set). Covers natural
> rubber, SBR, EPDM, NBR, silicone, FKM (Viton), TPU, fluorosilicone.
> Tire **product** chemistry (cord + matrix + RFL dip) cross-links to
> `tire_cord/`; biomedical implant PDMS cross-links to `hexa-bio`.

> (durometer, σ_f, ozone resistance, swell index) are set by
> cross-link density, filler chemistry, and process — **not by the n=6
> lattice**. ExxonMobil / Lanxess / Wacker / Dow / Shin-Etsu vendor
> figures cited verbatim with no lattice projection.

---

## §1 WHY — why elastomer belongs in hexa-matter

Elastomers occupy a distinct corner of the polymer envelope: T_g far
below room T + cross-linked network → entropic-elastic response (not
enthalpic-elastic like glassy/crystalline polymers). The five workhorse
classes span the entire industrial-rubber market (~ 30 Mt/yr natural
rubber + ~ 17 Mt/yr synthetic rubber, IRSG 2024).

| Class | Backbone | Cross-link | Industrial signature |
|-------|----------|-----------|----------------------|
| Diene (NR, SBR, BR, IR) | polyisoprene / polybutadiene | sulfur vulcanization | tire, mount, glove |
| EPDM | ethylene-propylene-diene | sulfur or peroxide | weatherstrip, roofing, hose |
| Nitrile (NBR, HNBR) | acrylonitrile-butadiene | sulfur | oil-resistant seal |
| Fluoroelastomer (FKM/FFKM) | fluorinated diene | bisphenol AF or peroxide | aerospace + chemical seal |
| Silicone (VMQ, FVMQ) | poly-dimethylsiloxane | peroxide or Pt-Si-H + Si-vinyl | implant, sealant, high-T cable |
| TPU | polyurethane block | physical (urethane H-bond) | wheel, conveyor, biomedical |

---

## §2 Real-limits-first — elastomer's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| El-L1 | NR tensile strength (gum, strain-crystallized) | Engineering / SOFT | **20–30 MPa** | ASTM D412; Mark *Science and Technology of Rubber* 4th ed. |
| El-L2 | SBR tensile (filled, carbon black N330) | Engineering / SOFT | 18–25 MPa | Lanxess / Goodyear datasheets |
| El-L3 | EPDM tensile (filled) | Engineering / SOFT | 7–20 MPa | Lanxess Keltan datasheet |
| El-L4 | FKM (Viton A) max use-T | Engineering / SOFT | **205 °C continuous / 230 °C intermittent** | Chemours Viton datasheet |
| El-L5 | Silicone (VMQ) operating range | Engineering / SOFT | **−55 °C to +200 °C** (sustained) | Wacker Elastosil / Shin-Etsu KE-series |
| El-L6 | NR T_g | Physical / HARD | **−70 °C (203 K)** | DSC, CRC Handbook 105th ed. |
| El-L7 | PDMS T_g | Physical / HARD | **−125 °C (148 K)** | DSC, Mark *Physical Properties of Polymers* |
| El-L8 | Shore A range (commercial rubbers) | Engineering / SOFT | 20A (very soft) – 95A (semi-rigid) | ASTM D2240 |
| El-L9 | Shore D range (TPU, hard elastomers) | Engineering / SOFT | 40D – 80D | ASTM D2240 |
| El-L10 | Ozone cracking resistance (ASTM D1149, 50 pphm O₃, 40 °C) | Engineering / SOFT | NR fails < 24 h (unprotected); EPDM > 100 h; FKM > 1000 h | ASTM D1149 |
| El-L11 | Abrasion loss (DIN 53516, NR tire tread) | Engineering / SOFT | 80–150 mm³ (filled NR/SBR tire compound) | DIN 53516 |
| El-L12 | Swell index in toluene (NBR 33 % ACN) | Engineering / SOFT | < 10 % (after 70 h, 23 °C) — vs NR ~ 200 % | ASTM D471 |
| El-L13 | Fluoroelastomer (FFKM) max use-T | Engineering / SOFT | **315 °C continuous** (Chemours Kalrez 6375) | Chemours Kalrez datasheet |

**Note on NR's 20–30 MPa anomaly.** Natural rubber's unusually high gum
strength comes from **strain-induced crystallization (SIC)** — at high
extension, the isotactic cis-polyisoprene chains crystallize, forming
in-situ reinforcement. Synthetic SBR + EPDM lack SIC and require carbon
black or silica filler to reach similar σ_f.

**Note on FKM/FFKM service ceilings.** The 205 °C (Viton A) and 315 °C
(Kalrez 6375) ceilings are continuous-service limits — short-burst
ceilings are 30–50 °C higher but compromise sealing life. **UNVERIFIED
in this repo**: vendor lifetime curves at end-use temperature; cited
verbatim from datasheets.

---


Global synthetic rubber + natural rubber production, most recent
reporting (IRSG / vendor IR). No projection onto n=6.

| Producer / source | Class | Reported nameplate / output (kt/yr) | Source |
|----|----|----|----|
| Natural rubber (global) | NR | ~ 13,800 (2023) | IRSG 2024 |
| Sinopec | SBR / BR / NBR | ~ 1,800 | Sinopec IR |
| ExxonMobil Chemical | butyl + halobutyl (tire inner liner) | ~ 800 | ExxonMobil annual report |
| Lanxess (Keltan EPDM, Krynac NBR, Buna BR) | EPDM / NBR / BR | ~ 1,000 | Lanxess IR |
| Goodyear / Bridgestone / Michelin in-house | tire-compound rubber | not separately reported | OEM annual reports |
| Chemours (Viton FKM, Kalrez FFKM) | fluoroelastomer | ~ 7 (FKM) | Chemours public |
| Wacker Silicones (Elastosil) | silicone elastomer | ~ 200 (silicone total) | Wacker annual report |
| Shin-Etsu Silicones (KE series) | silicone elastomer | ~ 150 (silicone total) | Shin-Etsu IR |
| Dow Silastic | silicone elastomer | ~ 100 (silicone total) | Dow IR |

> **Honesty caveat (LATTICE_POLICY §3.3):** these vendors do not anchor
> capacity to n=6. Do not χ²-fit to σ·τ=48. Capacity is bounded by
> butadiene / isoprene / siloxane feedstock + polymerization-reactor
> count + cure-line throughput — not by lattice arithmetic.

---

## §4 STRUCT — elastomer material flow

```
[Hevea brasiliensis latex]                  [Petrochemical butadiene + isoprene + styrene]
       ↓ acetic acid coagulation                     ↓ Ziegler-Natta or anionic polymerization
[Natural rubber TSR / RSS bale]              [SBR / BR / IR / NBR emulsion or solution]
       ↓                                              ↓
       └─────────────┬────────────────────────────────┘
                     ↓ masticate
              [Raw rubber master batch]
                     ↓ + carbon black / silica filler + plasticizer + cure system (sulfur + accelerator OR peroxide)
              [Compounded rubber]
                     ↓ extrude / mold / calender
              [Green (uncured) part]
                     ↓ vulcanization (150–180 °C, 5–30 min, autoclave or press)
              [Cured elastomer part]
                     ↓
       ┌─────────────┼─────────────┬─────────────┐
       ↓             ↓             ↓             ↓
   [Tire]        [Seal/O-ring]  [Hose/belt]  [Sole/grip]
   (→ tire_cord/)                              (→ FAS group)

Side: silicone has distinct Pt-catalyzed hydrosilylation cure or peroxide cure
      → biomedical-grade PDMS (Dow Silastic Q7, Wacker SilMix RTV) cross-links to hexa-bio
```

---

## §5 FLOW — process aspects in scope

| Process step | Material-aspect concern (this repo) | Out-of-scope |
|--------------|-------------------------------------|--------------|
| Latex tapping + coagulation | TSR purity, natural-rubber Mooney viscosity | rubber plantation agronomy → hexa-farm |
| Emulsion / solution polymerization | molecular weight, vinyl/cis ratio, branching | reactor design |
| Compounding | filler dispersion, cross-link density target | mixer engineering |
| Vulcanization | t90 cure time, modulus development | autoclave physics |
| Filler reinforcement | Payne effect, hydrodynamic + occluded volume | tire pattern → hexa-mobility |
| RFL adhesion (rubber-cord) | resorcinol-formaldehyde-latex dip chem | tire construction → tire_cord/ |

---

## §6 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | Sulfur vulcanization (Goodyear 1839) | Commodity |
| Mk.II | Carbon black reinforcement (1904) | Commodity |
| Mk.III | Silica reinforcement w/ silane coupling (Michelin "green tire" 1992) | Commodity |
| Mk.IV | FFKM perfluoro for 315 °C (Kalrez 6375) | Commercial niche |
| Mk.V | Self-healing rubber (supramolecular H-bond) | R&D — UNPROVEN at tire-scale |
| Mk.VI | Bio-isoprene from microbial fermentation (Genencor / Goodyear 2008) | R&D — UNVERIFIED at industrial cost |

---

## §7 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| Aramid/nylon cord in rubber matrix | `tire_cord/tire-cord.md` |
| Rubber-microplastic (tire wear) | `microplastics/microplastics.md` |
| Silicone polymer chemistry (Si-O backbone) | `silicon/silicon.md` (note on silicone) + POLYMER-CHEMISTRY.md |
| Biomedical implant PDMS | `hexa-bio` (sibling CLI) |
| Tire engineering / pattern / wear | `hexa-mobility` (sibling CLI) |
| Adhesives (rubber-rubber, RFL) | `adhesive/adhesive.md` |

---

## §8 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| NR T_g = 203 K | CRC Handbook 105th | El-L6 sanity |
| PDMS T_g = 148 K | Mark *Physical Properties of Polymers* | El-L7 sanity |
| ASTM D412 tensile | ASTM | σ_f sanity |
| ASTM D2240 durometer | ASTM | hardness sanity |
| ASTM D1149 ozone | ASTM | ozone-cracking sanity |
| DIN 53516 abrasion | DIN | tread-wear sanity |
| Chemours Viton / Kalrez datasheets | vendor | FKM/FFKM service-T |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-El-1 | Bio-isoprene displacing > 5 % of global isoprene at commercial cost | OPEN |
| F-El-2 | Self-healing elastomer reaching tire-grade abrasion + tensile in production | OPEN |
| F-El-3 | NR strain-crystallization model failing at high strain rate (> 1000 /s) — re-baseline El-L1 | OPEN |
| F-El-4 | FFKM continuous-service ceiling moving > 350 °C with documented lifetime — re-baseline El-L13 | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "NR σ_f 25 MPa equals σ·τ × 0.52" — coincidence; do not write
- ✗ "FKM 205 °C use-T fits n=6 lattice" — coincidence; do not write
- ✗ "Shore A 50 equals n=6 lattice modular term" — no; durometer is a probe geometry/load definition

---

## §9 Honest scope + caveats

1. **Material layer only.** Tire construction, motor mount design, seal
   gland geometry — **not here.** Call `tire_cord/`, `hexa-mobility`,
   or the seal-application chapter of `hexa-energy`.

2. **Self-healing + bio-isoprene are UNVERIFIED at production.**
   Mk.V and Mk.VI in §6 are R&D-only as of 2026; honest caveat per
   LATTICE_POLICY §1.2.

3. **No lattice anchoring of vendor numbers.** ExxonMobil / Lanxess /
   Chemours / Wacker / Shin-Etsu / Dow capacities are their own
   published figures; this spec does not project any onto n=6.

4. **SPEC_FIRST verdict.** No numbers in this file are MEASURED in this
   repo; all are cited from ASTM / ISO / CRC / Mark / vendor public
   disclosures. Working `.hexa` numerical sandbox for elastomer is TBD.

5. **Coincidence disclosure (LATTICE_POLICY §1.1).** Any apparent fit
   of elastomer numbers to n=6 (e.g., FKM 205 °C ≈ σ·τ × 4.27) is
   coincidence with verification power zero.

---

## §10 References

- **ASTM D412** — Vulcanized Rubber and Thermoplastic Elastomer Tension
- **ASTM D2240** — Rubber Property — Durometer Hardness
- **ASTM D1149** — Rubber Deterioration — Cracking in Ozone Atmosphere
- **ASTM D471** — Rubber Property — Effect of Liquids
- **DIN 53516** — Abrasion resistance of vulcanized rubber
- **CRC Handbook of Chemistry and Physics**, 105th ed. (2024)
- Mark J.E., Erman B., Roland C.M. (eds.), *Science and Technology of Rubber*, 4th ed. (Academic 2013)
- Chemours — Viton / Kalrez technical bulletins
- Wacker Chemie AG — Elastosil silicone-elastomer datasheets
- Shin-Etsu Silicones — KE-series datasheets
- Lanxess — Keltan EPDM, Krynac NBR datasheets
- ExxonMobil Chemical — butyl + halobutyl annual reports
- IRSG (International Rubber Study Group) 2024 statistics
- `LATTICE_POLICY.md` §1.2 + §1.3
- `LIMIT_BREAKTHROUGH.md` (Wave M)
- Cross-link sibling: `tire_cord/tire-cord.md`, `microplastics/microplastics.md`, `hexa-bio`, `hexa-mobility`

---

*Authored 2026-05-13 by 박민우. Material-layer spec for hexa-matter's
Phase D `elastomer` verb (18 of 29). Real-limits-first per
LATTICE_POLICY.md §1.2; no lattice fit on elastomer parameters or
vendor capacity. Tire-system design out of scope.*
