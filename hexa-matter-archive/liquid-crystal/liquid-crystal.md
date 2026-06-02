<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — thermotropic + lyotropic LC, LCP, display physics + SLM application boundary -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; OLED displacement of LCD honestly captured -->
---
domain: liquid-crystal
requires: []
verb_group: polymer
status: SPEC_FIRST
verdict_basis: Merck KGaA datasheets + IDTechEx market data + Reinitzer original; no lattice fit
---

# Liquid Crystal — n=6 소재 substrate, material verb (Phase D 25/29)

> **Material layer only.** Thermotropic LC (nematic, smectic A/C,
> cholesteric N*, discotic, blue phase) + lyotropic LC + LCP (liquid-
> crystalline polymer: Kevlar / aramid dope, Vectra, Xydar, Vectran).
> **Application boundary: LCD-class displays + spatial light
> modulators (SLM).** Display device design + TFT backplane integration
> live in `hexa-chip`.

> Chisso LC mixture properties are vendor-published with engineered
> compositions. OLED displacement of LCD in premium displays (2020s
> trend) honestly captured. No lattice projection.

---

## §1 WHY — why liquid-crystal belongs in hexa-matter

A **liquid crystal (LC)** is a phase of matter with orientational
order (like a solid) but positional fluidity (like a liquid).
Distinct phases:

| Phase | Order parameter | Example |
|-------|------------------|---------|
| Nematic (N) | molecules align along common axis ("director") | 5CB, MBBA, Merck ZLI-4792 |
| Smectic A (Sm-A) | director + 1D positional (layered); director ⊥ layer | 8CB |
| Smectic C (Sm-C / Sm-C*) | layered, director tilted; ferroelectric in chiral Sm-C* | chiral SmC* mixtures |
| Cholesteric (N* / chiral nematic) | helical twist; reflects circular-polarized light at pitch wavelength | cholesteryl benzoate (Reinitzer 1888) |
| Discotic | disc molecules stack into columns | triphenylene derivatives |
| Blue phase (BP) | 3D lattice of double-twist cylinders; narrow T range | usually 1–2 °C, polymer-stabilized BP wider |

LC is a phase of matter; LCP is a class of polymers where the
mesogenic unit is built into the backbone (lyotropic = LC in solution;
thermotropic = LC in melt).

---

## §2 Real-limits-first — liquid-crystal's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| LC-L1 | 5CB (4-cyano-4'-pentylbiphenyl) T_NI clearing point | Physical / HARD | **35 °C (308 K)** | Gray-Harrison 1973 |
| LC-L2 | MBBA T_NI | Physical / HARD | **47 °C (320 K)** | Kelker-Scheurle 1969 |
| LC-L3 | Merck ZLI-4792 (TN-LCD mixture) T_NI | Engineering / SOFT | **~ 92 °C** | Merck KGaA datasheet |
| LC-L4 | Nematic birefringence Δn (typical commercial mixtures) | Engineering / SOFT | **0.06–0.22** (depends on mesogenic unit) | Merck datasheets |
| LC-L5 | Rotational viscosity γ₁ (Merck nematic mixtures, room T) | Engineering / SOFT | **70–250 mPa·s** | Merck datasheets |
| LC-L6 | Response time of TN-LCD pixel (room T) | Engineering / SOFT | **~ 10–25 ms** (decay limited by γ₁ / Δε / E²) | display industry standard |
| LC-L7 | IPS / VA-LCD response time | Engineering / SOFT | **~ 5–10 ms** typical | LG / Samsung public |
| LC-L8 | LCP Vectran fiber tensile σ | Engineering / SOFT | **~ 3 GPa** | Kuraray Vectran datasheet |
| LC-L9 | LCP Vectran Young's modulus E | Engineering / SOFT | **~ 75 GPa** | Kuraray |
| LC-L10 | Thermotropic LCP Vectra (Celanese) | Engineering / SOFT | high-aspect-ratio injection moldable, T_m ~ 280 °C | Celanese Vectra datasheet |
| LC-L11 | Blue-phase native temperature range | Physical / HARD | **~ 1–2 °C** (unstabilized) | Coles-Pivnenko 2005 *Nature* 436, 997 |
| LC-L12 | Polymer-stabilized blue-phase (PSBP) T range | Engineering / SOFT | **~ 60 °C** (with polymer stabilizer) | Kikuchi 2002 *Nat. Mater.* 1, 64 |
| LC-L13 | LCD vs OLED market crossover in premium displays | Engineering / SOFT | OLED captured ~ 100 % of premium smartphone display by 2024; ~ 30 % of TV; LCD remains for monitor + tablet | IDTechEx 2024 |

**Note on LCP Vectran (LC-L8/L9).** σ/E ratio for Vectran ≈ 3/75 ≈
0.04 — about 0.4× of the L1 Frenkel theoretical ratio (~ 0.1).
Defect-limited like all engineering polymers. Cross-link to
ARAMID.md (Kevlar 49: σ ~ 3.6 GPa, E ~ 130 GPa; PPTA in sulfuric
acid is the canonical lyotropic LCP).

**Note on display market (LC-L13).** OLED has captured premium
smartphone market entirely; LCD remains for monitor, TV, tablet,
laptop. **UNVERIFIED in this repo**: per-segment market share by
quarter; cited from IDTechEx 2024 trend report.

---

## §3 Display physics — LC modes in scope

| Mode | Director state (rest) | Switching | Used in |
|------|------------------------|-----------|---------|
| TN (Twisted Nematic) | 90° helical twist | field aligns LC perpendicular | original 1970s LC display, calculator, low-end LCD |
| IPS (In-Plane Switching) | parallel to glass | field rotates LC in-plane | iPhone Retina, LG monitor |
| VA (Vertical Alignment) | perpendicular to glass | field tilts | Samsung QLED, high-contrast TV |
| FFS (Fringe-Field Switching) | parallel, with comb electrodes | enhanced viewing angle | tablet, mobile |
| Cholesteric reflective | helical twist with sub-µm pitch | bistable reflection (no backlight needed) | Kent Display, e-reader |
| Ferroelectric LC (SmC*) | tilted | µs-scale switching | high-speed shutter, SLM |
| Blue phase (polymer-stab.) | 3D double-twist | sub-ms switching | next-gen display research |

**SLM (Spatial Light Modulator) application boundary.** LC-on-Silicon
(LCoS) SLMs use parallel-aligned nematic LC on top of a CMOS
backplane. Used for: holographic display, phase-modulation beam
steering, wavefront shaping. Distinct from emissive display
(OLED, microLED, QLED — `hexa-chip` domain).

---


| Producer | LC focus | Reported scale | Source |
|----------|----------|----------------|--------|
| Merck KGaA Performance Materials | nematic mixtures for TFT-LCD (MLC-, ZLI-, MBBA-series) | dominant global LC supplier (~ 50 %+ market share) | Merck Performance Materials IR |
| DIC Corporation (Dainippon Ink) | LC mixtures + RM (reactive mesogen) | major supplier | DIC IR |
| JNC Corporation (formerly Chisso) | LC mixtures | major Japanese supplier | JNC public |
| Kuraray | Vectran fiber (LCP) | specialty fiber | Kuraray IR |
| Celanese (Ticona) | Vectra thermotropic LCP | engineering plastic | Celanese IR |
| Solvay (formerly Amoco) | Xydar thermotropic LCP | engineering plastic | Solvay IR |
| Sumitomo Chemical | Sumikasuper LCP | engineering plastic | Sumitomo IR |

> **Honesty caveat:** Merck KGaA Performance Materials reported ~ €1.5 B
> in LC + OLED materials (2023); LC business declining as OLED rises.
> Vectran fiber is ~ kt/yr-scale (specialty). LCP injection-grade
> ~ 100 kt/yr global (Vectra + Xydar + Sumikasuper combined). No
> projection onto n=6.

---

## §5 STRUCT — liquid-crystal material flow

```
Small-molecule LC for display:
   [Mesogenic precursor (biphenyl, cyclohexyl-aryl, fluorinated ester)]
        ↓ multi-step synthesis (alkylation, esterification, etc.)
   [Pure mesogen (5CB, MBBA, ZLI-class building blocks)]
        ↓ formulation into multi-component mixture (8–15 mesogens + chiral dopant)
   [Commercial LC mixture, e.g., Merck ZLI-4792]
        ↓ fill into LCD cell via vacuum / one-drop-fill (ODF)
   [TFT-LCD pixel array — display device design → hexa-chip]

LCP fiber (Vectran):
   [Hydroxybenzoate + hydroxynaphthoate copolyester]
        ↓ melt polymerization
   [Thermotropic LCP melt]
        ↓ melt-spin through spinneret
   [Vectran fiber, chain-aligned]
        ↓ heat treatment (annealing)
   [High-modulus LCP fiber → sail, ballistic, tether]

LCP injection-grade (Vectra):
   [Random aromatic ester]
        ↓ melt polymerization
   [Pellet]
        ↓ injection molding (high-aspect-ratio mold)
   [Molded electronic-connector / MEMS package]

Lyotropic LCP (Kevlar dope):
   [PPTA polymer + concentrated H₂SO₄]
        ↓ lyotropic LC dope at ~ 20 % polymer
   [Spin into water bath]
   [Kevlar / Twaron fiber — cross-link to aramid/aramid.md + ARAMID.md]
```

---

## §6 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | Cholesteryl benzoate (Reinitzer 1888) | Origin of LC science |
| Mk.II | MBBA / 5CB room-T nematic (Gray 1973) | Foundation for TN-LCD |
| Mk.III | TN-LCD (Schadt-Helfrich 1971; commercial 1970s) | Commodity |
| Mk.IV | Merck ZLI / MLC fluorinated mixtures for TFT-LCD | Commodity, declining |
| Mk.V | Polymer-stabilized blue-phase (Kikuchi 2002) | R&D — UNVERIFIED at commercial display |
| Mk.VI | LC-on-Si SLM for holographic display | Commercial niche (Holoeye, Jasper, Forth Dimension) |
| Mk.VII | OLED displacement of LCD | Mature trend 2020s |

---

## §7 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| Lyotropic LCP — PPTA / Kevlar in dope | `aramid/aramid.md`, ARAMID.md, POLYMER-CHEMISTRY.md §6 |
| Flex display substrate | `pet_film/pet-film.md` |
| TFT backplane (a-Si, IGZO, LTPS) | `compound-semi/compound-semi.md`, `hexa-chip` |
| OLED emissive layer | `hexa-chip` |
| MicroLED | `compound-semi/`, `hexa-chip` |
| Holographic display + AR/VR | `hexa-chip`, `hexa-medic` |

---

## §8 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| 5CB T_NI 35 °C | Gray-Harrison 1973 | LC-L1 sanity |
| MBBA T_NI 47 °C | Kelker-Scheurle 1969 | LC-L2 sanity |
| Vectran σ_f 3 GPa | Kuraray datasheet | LC-L8 sanity |
| Vectran E 75 GPa | Kuraray | LC-L9 sanity |
| Blue-phase native T range | Coles-Pivnenko 2005 | LC-L11 sanity |
| OLED smartphone market share | IDTechEx 2024 | LC-L13 sanity |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-LC-1 | Polymer-stabilized blue-phase commercial display at consumer scale | OPEN |
| F-LC-2 | LCP fiber σ > 6 GPa at production yield | OPEN |
| F-LC-3 | Sub-ms LC response time at TV-scale pixel | OPEN |
| F-LC-4 | LCD reclaiming premium smartphone share from OLED | UNLIKELY but OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "5CB T_NI 35 °C equals σ·τ × 0.73" — coincidence
- ✗ "Vectran E 75 GPa fits n=6 × c" — coincidence
- ✗ "Merck Performance Materials revenue follows n=6" — no

---

## §9 Honest scope + caveats

1. **Material layer only.** TFT backplane integration, OLED stack
   design, microLED transfer printing — `hexa-chip`.

2. **OLED displacement of LCD is the 2020s industry trend.**
   Premium smartphone display ~ 100 % OLED; TV ~ 30 % OLED;
   monitor + tablet remain LCD. Honest distinction preserved.

3. **Blue-phase commercial display UNVERIFIED.** Mk.V in §6
   remains R&D-only as of 2026.

4. **No lattice anchoring of vendor numbers.** Merck KGaA / DIC /
   JNC / Kuraray / Celanese / Solvay / Sumitomo figures cited
   verbatim.

5. **SPEC_FIRST verdict.** All numbers from primary literature,
   vendor datasheets, or IDTechEx public market data.

6. **Coincidence disclosure (LATTICE_POLICY §1.1).** Any apparent
   fit to n=6 is coincidence.

---

## §10 References

- Reinitzer F., "Beiträge zur Kenntniss des Cholesterins," *Monatshefte für Chemie* 9, 421 (1888) — discovery of LC
- Gray G.W., Harrison K.J., Nash J.A., "New family of nematic liquid crystals for displays," *Electron. Lett.* 9, 130 (1973) — 5CB
- Kelker H., Scheurle B., "A Liquid-crystalline (Nematic) Phase with a Particularly Low Solidification Point," *Angew. Chem.* 8, 884 (1969) — MBBA
- Schadt M., Helfrich W., "Voltage-dependent optical activity of a twisted nematic liquid crystal," *Appl. Phys. Lett.* 18, 127 (1971) — TN-LCD
- Coles H.J., Pivnenko M.N., "Liquid crystal 'blue phases' with a wide temperature range," *Nature* 436, 997 (2005)
- Kikuchi H., Yokota M., Hisakado Y., Yang H., Kajiyama T., "Polymer-stabilized liquid crystal blue phases," *Nat. Mater.* 1, 64 (2002)
- Merck KGaA Performance Materials — LC mixture datasheets (MLC-, ZLI-series)
- Kuraray — Vectran technical datasheet
- Celanese — Vectra LCP datasheet
- Solvay — Xydar LCP datasheet
- IDTechEx — display market reports 2024
- `aramid/aramid.md`, ARAMID.md, POLYMER-CHEMISTRY.md §6
- `LATTICE_POLICY.md` §1.2 + §1.3

---

*Authored 2026-05-13 by 박민우. Material-layer spec for Phase D
`liquid-crystal` verb (25 of 29). Application boundary: LCD-class
display + LCoS SLM. Display device design + OLED out-of-scope —
`hexa-chip`. No lattice fit.*
