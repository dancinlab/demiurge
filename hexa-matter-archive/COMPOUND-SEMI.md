# COMPOUND-SEMI — Phase D candidate stub

> **Authored**: 2026-05-13 (Phase A elevation) · **Status**: STUB — Phase D roadmap marker
> **Author**: 박민우 <nerve011235@gmail.com>
> **Target group**: GROUP_CER · **Phase D priority**: HIGH (per `USER_ACTION_REQUIRED.md §2`)
>
> Stub placeholder for the Phase D `compound-semi` verb covering wide-bandgap
> + III-V semiconductors at the **material layer**. Device-level engineering
> (HEMTs, LEDs, lasers) stays in `hexa-chip`.

---

## §1 Scope

Compound semiconductors are crystalline III-V or II-VI binaries (or ternaries / quaternaries) with electronic / optoelectronic properties distinct from elemental Si. The material layer (bulk crystal growth, wafer prep, defect engineering) is in scope; the device design is `hexa-chip`.

---

## §2 Candidate workhorse compound semiconductors

| Material | Bandgap (eV) | Crystal structure | Use |
|----------|--------------|---------------------|-----|
| **GaN** | 3.4 (direct) | wurtzite + zinc-blende | blue/UV LED, RF power, EV inverter |
| **SiC** (4H polytype) | 3.26 (indirect) | hexagonal | EV inverter (Tesla), MOSFET power |
| **GaAs** | 1.42 (direct) | zinc-blende | RF / microwave, IR laser, HBT |
| **InP** | 1.34 (direct) | zinc-blende | telecom laser, photodetector |
| **AlN** | 6.2 (direct) | wurtzite | DUV LED, HEMT buffer |
| **InGaN** | 0.7-3.4 (tunable) | wurtzite | full-color LED, laser |
| **GaP** | 2.26 (indirect) | zinc-blende | red/yellow LED |
| **CdTe** | 1.45 (direct) | zinc-blende | thin-film PV (First Solar) |
| **CIGS** (Cu(In,Ga)Se₂) | 1.0-1.7 (tunable) | chalcopyrite | thin-film PV |

Cross-link: SiC is already in `silicon/silicon.md §1` and `CERAMIC-ENGINEERING.md §3`; this chapter would consolidate SiC's *device-material* side with the GaN / GaAs / InP family.

---

## §3 Production routes (target depth)

- **CZ pull** — GaAs, InP (similar physics to Si CZ; lower T_m, smaller wafer)
- **HVPE** (Hydride Vapor Phase Epitaxy) — GaN bulk crystal growth
- **PVT** (Physical Vapor Transport) — SiC bulk
- **Bridgman / LEC** — GaAs ingot growth (Liquid Encapsulated Czochralski with B₂O₃ cap)
- **MOCVD / MBE** — epitaxial layer growth on substrate

---

## §4 Real-limit anchors (planned)

- L7 Si bandgap 1.12 eV is the Si baseline; compound-semi bandgaps span 0.7-6.2 eV
- L9 SiC thermal k ~ 350-490 W/m·K (vs Si 150) — power device advantage
- Si-L11 SiC bandgap 3.26 eV (4H) anchor already in `silicon/silicon.md`

---

## §5 Cross-links (when expanded)

- `silicon/silicon.md` + `SILICON.md` — Si baseline + SiC wafer cross-link
- `ceramics/ceramics.md` + `CERAMIC-ENGINEERING.md` — SiC power-device ceramic
- `GRAPHENE-CARBON.md` — diamond as ultra-wide bandgap (5.45 eV) cousin
- `hexa-chip materials` — device + fab process
- `hexa-energy` — power electronics + inverter

---

## §6 Honest C3

Phase D candidate. Stub-level only. Vendor figures (Wolfspeed SiC, Coherent GaN, Sumitomo GaAs) will be cited at their published values, no lattice fit. Per `LATTICE_POLICY §1.2`.

---

*Stub authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase D roadmap marker.*
