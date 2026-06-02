# ADHESIVE — Phase D candidate stub

> **Authored**: 2026-05-13 (Phase A elevation) · **Status**: STUB — Phase D roadmap marker
> **Author**: 박민우 <nerve011235@gmail.com>
> **Target group**: GROUP_POL · **Phase D priority**: MEDIUM
>
> Stub placeholder for the Phase D `adhesive` verb covering adhesion mechanisms,
> structural adhesives, and the aerospace adhesive standards.

---

## §1 Scope

Adhesives bond two substrates via one (or more) of 5 adhesion mechanisms:

| Mechanism | Description | Example |
|-----------|-------------|---------|
| Mechanical interlock | adhesive penetrates substrate pores | wood glue, anchor-set epoxy |
| Diffusion | inter-diffusion of polymer chains | rubber-rubber bond, polymer welding |
| Adsorption (van der Waals) | physical adsorption | most pressure-sensitive adhesives |
| Chemical (covalent) | reactive bond | silane coupling, isocyanate-polyol PU |
| Electrostatic | charge transfer | rare; gecko-foot biological |

---

## §2 Workhorse adhesives

| Adhesive | Chemistry | Cure | Use |
|----------|-----------|------|-----|
| Cyanoacrylate (Krazy Glue) | anionic poly addition of methyl/ethyl cyanoacrylate | moisture-initiated | rapid bond, paper to medical |
| Epoxy 2-part (Araldite, Loctite Hysol) | DGEBA + amine | thermal | structural (aerospace, marine) |
| Polyurethane (Gorilla Glue, 3M 3500) | isocyanate + polyol | moisture-cure | wood, foam, marine |
| Acrylic (Loctite AA, methacrylate) | radical polymerization | UV or anaerobic | medical device, electronic |
| Silicone (RTV, Dow Corning 3140) | Si-O cross-link via Pt catalysis or condensation | room T or thermal | electronic encapsulant, sealant |
| Hot-melt (EVA-based) | ethylene-vinyl acetate copolymer | thermal | packaging, bookbinding |
| Anaerobic (Loctite 271/680) | dimethacrylate + Cu catalysis | absence of oxygen | thread-locking |
| PSA (pressure-sensitive) | acrylic / rubber + tackifier | pressure | tape (Scotch, masking) |
| Aerospace structural (3M AF-555, Cytec FM 300) | epoxy or epoxy-novolac film | autoclave 175 °C | aircraft skin-to-spar |

---

## §3 Lap-shear strength benchmarks

ASTM D1002 single-lap shear test on Al-Al joint, 25 mm × 25 mm overlap:

| Adhesive | σ_shear (MPa) | Source |
|----------|---------------|--------|
| Cyanoacrylate | 20-25 | 3M datasheet |
| Standard epoxy (2-part, room-T cure) | 20-35 | Loctite Hysol |
| High-T epoxy (autoclave) | 35-50 | 3M Scotch-Weld AF-555 |
| Polyurethane structural | 15-25 | Sika datasheet |
| Acrylic structural | 25-35 | Loctite AA |
| Anaerobic | 20-30 | Loctite 271 |
| Hot-melt (EVA) | 5-10 | Henkel TecBond |
| PSA acrylic | 0.5-2 | 3M VHB |

---

## §4 Aerospace adhesive standards

- AMS 3970 (epoxy film adhesive, autoclave cure)
- AMS 3946 (epoxy paste adhesive)
- MIL-A-25457 (military standard)
- Boeing BMS 5-101 (Boeing material spec for epoxy film)

The Hexcel Redux 312, Solvay Cybond 4523, 3M AF-555M, Henkel Hysol EA 9696 are the canonical aerospace film adhesives.

---

## §5 Real-limit anchors (planned)

- L1 Frenkel σ_th — adhesive joint shear is generally cohesion-limited (within the adhesive layer), not adhesion-limited; σ_th ratio applies
- L12 entropy of mixing — adhesion to polymer substrate depends on diffusion-energy bookkeeping (Voyutskii)

---

## §6 Cross-links (when expanded)

- `epoxy/epoxy.md` + `EPOXY.md` — epoxy chemistry baseline
- `POLYMER-CHEMISTRY.md` — adhesive linkage chemistries
- `aramid/aramid.md` — aramid-epoxy composite (Kevlar prepreg)
- `tire_cord/tire_cord.md` — rubber-cord adhesion via RFL dip
- `hexa-mobility` — aerospace structural bonding

---

## §7 Honest C3

Phase D candidate. Stub-level. Vendor lap-shear values are typical-grade datasheet figures; real qualified-flight values may be higher or lower depending on surface prep. No lattice fit. Per `LATTICE_POLICY §1.2`.

---

*Stub authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase D roadmap marker.*
