# LIQUID-CRYSTAL — Phase D candidate stub

> **Authored**: 2026-05-13 (Phase A elevation) · **Status**: STUB — Phase D roadmap marker
> **Author**: 박민우 <nerve011235@gmail.com>
> **Target group**: GROUP_POL · **Phase D priority**: LOW
>
> Stub placeholder for the Phase D `liquid-crystal` verb covering nematic /
> smectic / cholesteric LC phases + LCP (liquid-crystalline polymer) like
> Kevlar in dope state.

---

## §1 Scope

A **liquid crystal (LC)** is a phase of matter with orientational order (like a solid) but positional fluidity (like a liquid). Three main phases:

| Phase | Order parameter | Example |
|-------|------------------|---------|
| **Nematic (N)** | molecules align along common axis ("director"); no positional order | 5CB (4-cyano-4'-pentylbiphenyl), MBBA |
| **Smectic A (Sm-A)** | molecules align AND organize into layers (1D positional order); director perpendicular to layers | 8CB |
| **Smectic C (Sm-C)** | layered like Sm-A, but director tilted from layer normal | various chiral SmC* (ferroelectric LC) |
| **Cholesteric / Chiral nematic (N*)** | nematic with helical twist (handed); reflects circularly polarized light at the pitch wavelength | cholesteryl benzoate (Reinitzer 1888), chiral dopants in nematic |
| **Discotic** | disc-shaped molecules stack into columns | triphenylene derivatives |
| **Blue phase** | 3D lattice of double-twist cylinders; narrow T range; fast electro-optic switching | 1-2 °C range without polymer stabilization |

---

## §2 Workhorse small-molecule LCs (display industry)

| Compound | T_N-I (°C) | Use |
|----------|-------------|-----|
| 5CB (4-cyano-4'-pentylbiphenyl) | 35 | research, original commercial LC display |
| 8CB | 41 (N-Sm A 32, Sm A-I 41) | Sm-A research |
| MBBA | 47 (N-I) | original 1969 commercial LC |
| ZLI-4792 (Merck) | mixture; T_N-I 92 | TN-LCD |
| MLC-6608 series (Merck) | mixtures | VA-LCD (vertical alignment) |
| Various commercial fluorinated mixtures | engineered | TFT-LCD pixels (Samsung, LG, AUO, BOE) |

Industrial LC production: Merck KGaA Performance Materials is the dominant supplier; Chisso (Japan), Dainippon Ink (DIC) also significant.

---

## §3 LCP (Liquid-Crystalline Polymer) — the cross-link to aramid

When the mesogenic (LC-forming) unit is built into a polymer backbone, you get an **LCP** that retains LC ordering in melt or solution.

- **Lyotropic LCP** — LC in solution; e.g., PPTA (Kevlar) in concentrated sulfuric acid; spun fiber retains chain alignment (cross-link to `aramid/aramid.md` + `ARAMID.md` + `POLYMER-CHEMISTRY.md §6`)
- **Thermotropic LCP** — LC in melt; e.g., Vectra (Ticona/Celanese, hydroxybenzoate-hydroxynaphthoate copolymer), Xydar (Solvay) — used for ultra-high-aspect-ratio molded parts (electronic connector, MEMS)

LCP fiber: Vectran (Kuraray) — σ ~ 3 GPa, E ~ 75 GPa, ρ ~ 1.4 g/cm³. Used in ballistic + sail material.

---

## §4 Display physics — TN, IPS, VA, OLED context

Most LCs are used in displays via field-induced reorientation:

- **TN (Twisted Nematic)** — 90° helical twist in unstrained state; field aligns LC perpendicular → light blocked. Original 1970s LC display.
- **IPS (In-Plane Switching)** — field rotates LC in-plane; better viewing angle. iPhone Retina, LG MicroLED preview.
- **VA (Vertical Alignment)** — LC perpendicular to glass at rest; field tilts. High contrast, Samsung QLED.
- **OLED replaces LC** for emissive displays — no LC needed; cross-link to `hexa-chip` device level.

---

## §5 Real-limit anchors (planned)

- L1/L2 σ_f — LCP Vectran 3 GPa, ratio to E (~ 75 GPa) gives σ/E ~ 0.04 (~ 0.4× of L1 theoretical Frenkel ratio of 0.1; defect-limited)
- Sm-A layered ordering — Hales 0.7405 packing not directly applicable (LC is fluid)

---

## §6 Cross-links (when expanded)

- `aramid/aramid.md` + `ARAMID.md` + `POLYMER-CHEMISTRY.md §6` — PPTA / Kevlar as lyotropic LCP
- `pet_film/pet_film.md` — substrate for flex display
- `compound-semi/` (Phase D) — display backplane TFT
- `hexa-chip materials` — TFT-LCD + OLED device-level cross-link

---

## §7 Honest C3

Phase D candidate. Stub-level. Most LC content has matured in 1990s-2000s; OLED displacement of LCD is the 2020s industry trend. Phase D priority is LOW because the chemistry is mature and OLED + microLED are absorbing share. No lattice fit. Per `LATTICE_POLICY §1.2`.

---

*Stub authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase D roadmap marker.*
