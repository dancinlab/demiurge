<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — adhesive chemistry, cure mechanism, lap-shear + peel strength -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; no lattice anchoring of adhesion -->
---
domain: adhesive
requires: []
verb_group: polymer
status: SPEC_FIRST
verdict_basis: ASTM + vendor datasheets; no lattice fit
---

# Adhesive — n=6 소재 substrate, material verb (Phase D 22/29)

> **Material layer only.** Adhesive chemistry (PSA, structural epoxy +
> polyurethane, cyanoacrylate, anaerobic, hot-melt, silicone RTV) and
> performance metrics (lap-shear ASTM D1002, 180° peel ASTM D903, T_g,
> service temperature). **Aircraft / aerospace structural-bonding
> design** lives in `hexa-mobility`; tire RFL bonding in `tire_cord/`.

> ASTM-standardized substrate + surface-prep dependent; real
> qualified-flight values may differ. 3M / Henkel / Sika / Loctite
> figures cited verbatim with no lattice projection.

---

## §1 WHY — why adhesive belongs in hexa-matter

Adhesives bond two substrates via one or more of 5 adhesion mechanisms:

| Mechanism | Description | Example |
|-----------|-------------|---------|
| Mechanical interlock | adhesive penetrates substrate pores | wood glue, anchor-set epoxy |
| Diffusion | inter-diffusion of polymer chains | rubber-rubber, polymer welding |
| Adsorption (van der Waals + acid-base) | physical + chemical adsorption | most PSAs |
| Chemical (covalent) | reactive bond | silane coupling, isocyanate-polyol PU |
| Electrostatic | charge transfer | rare; gecko-foot biological inspiration |

The bond performance is bounded by **cohesive strength of the
adhesive** (usually limiting) or **adhesion to the substrate**
(failure-mode 2 — interfacial).

---

## §2 Real-limits-first — adhesive's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| Ad-L1 | Cyanoacrylate (CA) lap shear, Al-Al, ASTM D1002 | Engineering / SOFT | **20–25 MPa** | 3M / Loctite datasheet |
| Ad-L2 | Standard 2-part epoxy, room-T cure, lap shear | Engineering / SOFT | **20–35 MPa** | Loctite Hysol, 3M DP datasheet |
| Ad-L3 | High-T autoclave epoxy film, lap shear | Engineering / SOFT | **35–50 MPa** | 3M Scotch-Weld AF-555M |
| Ad-L4 | Polyurethane structural lap shear | Engineering / SOFT | **15–25 MPa** | Sika SikaForce datasheet |
| Ad-L5 | Acrylic structural (MMA + initiator), lap shear | Engineering / SOFT | **25–35 MPa** | Loctite AA / 3M Scotch-Weld |
| Ad-L6 | Anaerobic thread-lock, breakaway torque | Engineering / SOFT | M10 nut: 20–30 N·m (Loctite 271) | Loctite datasheet |
| Ad-L7 | PSA acrylic 180° peel, ASTM D903 | Engineering / SOFT | **0.5–10 N/cm** (depending on grade) | 3M VHB datasheet |
| Ad-L8 | Hot-melt EVA lap shear | Engineering / SOFT | **5–10 MPa** | Henkel TecBond, 3M Jet-Melt |
| Ad-L9 | Silicone RTV lap shear, room-T cure | Engineering / SOFT | **2–5 MPa** | Dow Corning 3140, Loctite 5366 |
| Ad-L10 | Epoxy T_g (DGEBA + amine, room-T cure) | Physical / HARD | **60–100 °C** (depends on cross-linker) | DSC, EPOXY.md |
| Ad-L11 | Aerospace high-T epoxy T_g (autoclave 175 °C cure) | Physical / HARD | **180–250 °C** | 3M AF-555M, Cytec Cycom 977-3 |
| Ad-L12 | Cyanoacrylate moisture-cure initiation | Physical / HARD | **trace H₂O sufficient** (anionic chain transfer) | Loctite Henkel technical |
| Ad-L13 | Aerospace film adhesive standard | Engineering / SOFT | AMS 3970 (epoxy film) + BMS 5-101 (Boeing) | AMS / Boeing |

**Note on lap-shear (Ad-L1 through Ad-L9).** All values use single-lap
shear test on Al-Al joint (ASTM D1002 standard geometry, 25 mm × 25
mm overlap, 1.6 mm Al adherend). **Surface prep**: typically
phosphoric acid anodize (PAA) for aerospace, mechanical abrasion +
solvent wipe for general use. **UNVERIFIED in this repo**: vendor
fixture geometry deviations; cited from datasheets.

**Note on the 35–50 MPa autoclave ceiling (Ad-L3).** Beyond this point
the failure mode shifts from adhesive cohesion to substrate yield
(Al adherend deforms). The 50 MPa is essentially a "test geometry
ceiling" for ASTM D1002 single-lap shear with Al — composite
adherends or thicker Al raise it modestly.

---


| Producer | Product family | Reported scale | Source |
|----------|----------------|----------------|--------|
| 3M (Minnesota) | Scotch-Weld + VHB + DP + AF-series | ~ $12 B Industrial Adhesives & Tapes (2024) | 3M IR |
| Henkel | Loctite (CA, anaerobic, structural) + Bondace + Technomelt + Hysol | ~ $11 B Adhesives Technologies (2024) | Henkel IR |
| Sika | construction + auto structural + sealant | ~ $11 B (2024) | Sika IR |
| H.B. Fuller | construction + hygiene + packaging | ~ $3.6 B (2024) | H.B. Fuller IR |
| Bostik (Arkema) | construction + auto + packaging | ~ $2.5 B (2024) | Arkema IR |
| Solvay (Cytec) | aerospace structural (Cycom, FM 300, Cybond) | not separately broken out | Solvay IR |
| Hexcel | aerospace + Redux 312/319 | aerospace composite + adhesive ~ $2 B | Hexcel IR |
| Dow Corning / Wacker / Shin-Etsu | silicone sealant + RTV | silicone total ~ $5 B/yr each | vendor IR |

> **Honesty caveat (LATTICE_POLICY §3.3):** these vendors operate at
> ~ $10 B revenue scale each; their capacity is bounded by reactor
> count + formulation throughput + packaging line. No projection to n=6.

---

## §4 STRUCT — adhesive material flow

```
Reactive 2-part epoxy:
   [DGEBA epoxy resin] + [amine cross-linker]
        ↓ mix + meter (1:1 to 100:30 by mass)
   [Mixed adhesive, pot life 5–60 min]
        ↓ apply + clamp + cure (room T or thermal)
   [Bonded joint, T_g 60–250 °C depending on system]

Cyanoacrylate:
   [Methyl/ethyl cyanoacrylate monomer + stabilizer (sulfone)]
        ↓ apply thin film + contact
   [Anionic polymerization initiated by trace water]
   [Bonded joint in seconds — but T_g 100–150 °C]

Polyurethane (PU) structural:
   [Isocyanate prepolymer] + [polyol]
        ↓ mix + apply
   [Cure 4–24 h, moisture-assisted or thermal]
   [Bonded joint with high toughness — Sika SikaForce]

PSA (Pressure-Sensitive Adhesive):
   [Acrylic monomer + tackifier + cross-linker (UV or thermal)]
        ↓ coating onto release liner
   [PSA tape — 3M VHB, Scotch]
   [No cure on application — adhesion via vdW + diffusion under pressure]

Aerospace film adhesive (e.g., 3M AF-555M):
   [Epoxy-novolac resin film, B-staged]
        ↓ ply layup + autoclave 175 °C, 6.2 bar, 90 min
   [Cured T_g ~ 200 °C — aircraft skin-to-spar bonding]
```

---

## §5 FLOW — process aspects in scope

| Process step | Material-aspect concern (this repo) | Out-of-scope |
|--------------|-------------------------------------|--------------|
| Surface prep | wettability, contamination, PAA anodize | bond-line inspection NDT |
| Mix + meter | stoichiometry, pot life, viscosity | dispense robotics |
| Cure (thermal / UV / moisture) | T_g development, cure kinetics | autoclave engineering |
| Lap-shear test | substrate / surface / overlap geometry | qualification testing |
| Peel test | 90° / 180° / T-peel mode | fracture mechanics G_Ic |
| Service envelope | T_g, T_max, swell in solvent | aircraft service life → hexa-mobility |

---

## §6 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | DGEBA epoxy + amine (Castan 1947) | Commodity |
| Mk.II | Cyanoacrylate (Coover 1958) | Commodity |
| Mk.III | Aerospace film epoxy (3M AF-3, 1960s) | Commodity |
| Mk.IV | Aerospace high-T epoxy (AF-555M, 250 °C T_g) | Commercial |
| Mk.V | Bio-based epoxy (cardanol / lignin-derived) | R&D — UNVERIFIED at aerospace cost |
| Mk.VI | Self-healing adhesive (Diels-Alder reversible) | R&D — UNVERIFIED at production |
| Mk.VII | Gecko-inspired dry adhesive (nano-pillar) | R&D — UNVERIFIED at industrial scale |

---

## §7 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| Epoxy resin chemistry baseline | `epoxy/epoxy.md`, EPOXY.md |
| Polyurethane elastomer cross-link | `elastomer/elastomer.md` |
| Aramid-epoxy prepreg (Kevlar) | `aramid/aramid.md`, ARAMID.md |
| Rubber-cord RFL dip adhesion | `tire_cord/tire-cord.md` |
| Silicone RTV / sealant | `silicon/silicon.md` (silicone note), `elastomer/elastomer.md` |
| Polymer linkage chemistries | POLYMER-CHEMISTRY.md |
| Aerospace structural bonding | `hexa-mobility` (aerospace) |
| Electronic packaging encapsulant | `hexa-chip` |

---

## §8 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| ASTM D1002 lap shear | ASTM | Ad-L1 through Ad-L5 sanity |
| ASTM D903 180° peel | ASTM | Ad-L7 sanity |
| 3M AF-555M datasheet | 3M | Ad-L3 / Ad-L11 sanity |
| Loctite 271 datasheet | Henkel | Ad-L6 sanity |
| 3M VHB datasheet | 3M | Ad-L7 sanity |
| AMS 3970 epoxy film standard | SAE | Ad-L13 sanity |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-Ad-1 | Bio-based aerospace structural adhesive AMS-qualified | OPEN |
| F-Ad-2 | Self-healing structural adhesive at autoclave qualified | OPEN |
| F-Ad-3 | Gecko-inspired dry adhesive > 30 MPa at production | OPEN |
| F-Ad-4 | Aerospace high-T epoxy T_g > 280 °C at autoclave qualified | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "Epoxy lap-shear 35 MPa equals σ·τ × 0.73" — coincidence
- ✗ "T_g 250 °C fits n=6 lattice" — coincidence; T_g is segmental
- ✗ "3M / Henkel / Sika capacity follows n=6" — they have not heard of it

---

## §9 Honest scope + caveats

1. **Material layer only.** Aircraft structural-bond design (Boeing
   787 wing skin), surface-prep qualification flow, NDT bond-line
   inspection — `hexa-mobility`.

2. **Vendor lap-shear values are datasheet-typical.** Real qualified-
   flight values may differ depending on surface prep, ply count,
   cure profile, and test fixture.

3. **Bio-based + self-healing + gecko-inspired adhesives UNVERIFIED
   at aerospace cost / qualification.** Mk.V–Mk.VII in §6 are R&D-
   only as of 2026.

4. **No lattice anchoring of vendor numbers.** 3M / Henkel / Sika /
   Loctite / Solvay / Hexcel / Dow / Wacker / Shin-Etsu / H.B. Fuller
   / Bostik capacities cited verbatim.

5. **SPEC_FIRST verdict.** All numbers from ASTM / AMS / Boeing /
   vendor public datasheets.

6. **Coincidence disclosure (LATTICE_POLICY §1.1).** Any apparent
   numerical fit to n=6 is coincidence.

---

## §10 References

- **ASTM D1002** — Single-Lap Shear Strength of Adhesives
- **ASTM D903** — Peel Strength of Adhesive Bonds
- **AMS 3970** — Adhesive, Film, Epoxy (autoclave cure)
- **AMS 3946** — Adhesive, Paste, Epoxy
- **MIL-A-25457** — Military adhesive standard
- **Boeing BMS 5-101** — Boeing material spec for epoxy film
- 3M — Scotch-Weld AF-555M, VHB, DP-series technical data
- Henkel — Loctite 271, 277, 638, Hysol EA 9696 datasheets
- Sika — SikaForce, SikaTack, Sikaflex datasheets
- Solvay (Cytec) — Cycom 977-3, FM 300, Cybond 4523
- Hexcel — Redux 312/319 epoxy film
- Dow Corning — 3140 silicone RTV datasheet
- Coover H.W., "Surgical Adhesives," *JAMA* 169, 1100 (1959) — cyanoacrylate origin
- Castan P., 1947 — DGEBA epoxy origin (Ciba-Geigy)
- `epoxy/epoxy.md` + EPOXY.md
- POLYMER-CHEMISTRY.md
- `LATTICE_POLICY.md` §1.2 + §1.3

---

*Authored 2026-05-13 by 박민우. Material-layer spec for Phase D
`adhesive` verb (22 of 29). Real-limits-first per LATTICE_POLICY.md
§1.2; no lattice fit on lap-shear / peel / T_g or vendor capacity.
Aircraft structural-bond design out of scope — `hexa-mobility`.*
