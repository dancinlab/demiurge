<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — controlled-crystallization glass-ceramic family (LAS, MAS, Pyroceram, Macor, Zerodur, transparent armor) -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; no lattice anchoring of glass-ceramic parameters -->
---
domain: glass-ceramic
requires: []
verb_group: ceramic_inorganic
status: SPEC_FIRST
verdict_basis: vendor-published numbers (Corning, Schott, Eurokera, Owens-Illinois) + NIST/CRC + ASTM C1525; no lattice fit
---

# Glass-ceramic — n=6 소재 substrate, material verb (Phase D follow-on 30/33)

> **Material layer only.** Polycrystalline solids formed by **controlled
> thermal crystallization** of a parent glass — sit between the `glass/`
> verb (vitreous, amorphous) and the `ceramics/` verb (sintered crystalline).
> Covers Li₂O-Al₂O₃-SiO₂ (LAS, near-zero CTE cooktops + Zerodur mirror
> blanks), MgO-Al₂O₃-SiO₂ (MAS, Macor machinable), Pyroceram (cordierite +
> nucleation-controlled), transparent armor glass-ceramics, and Li-disilicate
> dental restorations (IPS e.max). Optical-glass parent stock cross-links
> to `glass/`; structural-ceramic post-process cross-links to `ceramics/`.

> (near-zero CTE in LAS, machinability in MAS, transparency window in
> mullite glass-ceramic) are set by **nucleation-and-growth kinetics +
> residual-glass composition** — **not by the n=6 lattice**.
> Corning / Schott / Eurokera / Ivoclar Vivadent vendor figures cited
> verbatim with no lattice projection.

---

## §1 WHY — why glass-ceramic belongs in hexa-matter

A glass-ceramic is not a sintered ceramic, not a glass — it is a
controlled-crystallization product. Parent glass is melted + formed by
standard glass-forming routes (float, press, blow), then **ceramed**
through a two-stage heat treatment: nucleation at T_n (just above T_g)
followed by crystal growth at T_g (well below T_m). Final microstructure
is typically 50–95 vol-% crystallites (50 nm – 5 µm) embedded in
residual glass matrix.

This route gives a unique property envelope: **near-zero CTE** (β-quartz
ss + β-spodumene ss in LAS → α ≈ ±0.5 × 10⁻⁶ /K), high mechanical
strength (vs parent glass), thermal-shock resistance > 500 °C ΔT,
machinability (Macor mica platelet structure), or transparency at
crystallite sizes < visible-light wavelength.

| Subclass | Composition | Crystal phase | Signature property |
|----------|-------------|---------------|---------------------|
| LAS (lithium-aluminosilicate) | Li₂O-Al₂O₃-SiO₂ + TiO₂/ZrO₂ nucleant | β-quartz ss → β-spodumene ss | Near-zero CTE; Zerodur, NEXTREMA, CookTop |
| MAS (Macor) | MgO-Al₂O₃-SiO₂-B₂O₃-K₂O-F | Fluorophlogopite mica | Machinable with carbide tooling |
| Pyroceram (cordierite) | MgO-Al₂O₃-SiO₂ | Cordierite + cristobalite | Missile radomes; CTE ≈ 1.5 × 10⁻⁶ /K |
| Li-disilicate dental | Li₂O-SiO₂ + nucleant | Li₂Si₂O₅ | Flexural σ_f 360–500 MPa, esthetic dental |
| Transparent armor glass-ceramic | various MgAl₂O₄ spinel + LAS | spinel or β-quartz ss | Vis transparency + ballistic |

---

## §2 Real-limits-first — glass-ceramic's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| GC-L1 | Zerodur CTE (Schott LAS mirror blank, 0–50 °C) | Engineering / HARD | **0 ± 0.007 × 10⁻⁶ /K** (Class 0 grade) | Schott Zerodur datasheet |
| GC-L2 | NEXTREMA / CERAN cooktop CTE (Eurokera LAS) | Engineering / SOFT | **≈ 0 × 10⁻⁶ /K** (in 20–700 °C range) | Eurokera / Schott CERAN datasheet |
| GC-L3 | LAS cooktop maximum service-T | Engineering / SOFT | **700 °C continuous / 950 °C short** | Schott CERAN technical bulletin |
| GC-L4 | Macor flexural strength | Engineering / SOFT | **94 MPa** | Corning Macor datasheet |
| GC-L5 | Macor max use-T (continuous) | Engineering / SOFT | **800 °C** (1000 °C short) | Corning Macor datasheet |
| GC-L6 | Macor CTE (25–600 °C) | Engineering / SOFT | 9.4 × 10⁻⁶ /K | Corning Macor |
| GC-L7 | IPS e.max Li-disilicate flexural σ | Engineering / SOFT | **360–500 MPa** (pressed) | Ivoclar Vivadent datasheet; ISO 6872 |
| GC-L8 | Pyroceram 9606 (cordierite) flexural σ | Engineering / SOFT | 240 MPa | Corning Pyroceram 9606 |
| GC-L9 | Pyroceram dielectric constant (radome) | Engineering / SOFT | ε_r ~ 5.6 @ 8.6 GHz | Corning Pyroceram 9606 |
| GC-L10 | Transparent armor glass-ceramic (ALON+spinel composites) areal density vs equivalent ballistic glass | Engineering / SOFT | **~ 1/2 to 1/3 areal density** at NIJ III ballistic level | Surmet ALON; MgAl₂O₄ spinel literature |
| GC-L11 | Glass-ceramic crystallite size for visible transparency | Physical / HARD | < **40–50 nm** typical (≤ λ/10) | Hopper 1985; Beall 2008 review |
| GC-L12 | Thermal-shock ΔT (CookTop LAS) | Engineering / SOFT | > 700 °C (water-quench survives flame-to-tap) | ASTM C1525 / Eurokera |
| GC-L13 | Li-disilicate dental hardness (Vickers) | Engineering / SOFT | 5.5–5.8 GPa | Ivoclar / Höland & Beall 2012 |
| GC-L14 | Ceram-to-glass crystallinity range | Engineering / SOFT | **50–95 vol-% crystalline** (vs glass < 1 %; sintered ceramic > 99 %) | Höland & Beall 2012 |
| GC-L15 | Two-stage cycle: nucleation T_n | Engineering / SOFT | T_g + (10–30 K) | Beall 1992 |
| GC-L16 | Two-stage cycle: crystal growth T_g | Engineering / SOFT | typically 0.65–0.85 × T_m of crystalline phase | Beall 1992 |

**Note on Zerodur's "Class 0" CTE (GC-L1).** Schott measures Class 0
Zerodur at α = (0 ± 0.007) × 10⁻⁶ /K in the 0–50 °C range — this is
the EXPANSION NEAR-ZERO ANCHOR for ELT, VLT, GTC, and all sub-arcsecond
optical-mirror programs of the last 40 years. The mechanism: β-quartz
solid solution has **negative** CTE; residual glass has positive CTE;
crystallinity is tuned so the volume-weighted average cancels. UNVERIFIED
in this repo at the Class 0 level; cited verbatim from Schott Zerodur
TIE-43 datasheet.

**Note on transparent armor (GC-L10).** Surmet ALON, MgAl₂O₄ spinel, and
LAS-class transparent armor glass-ceramics achieve visible transparency
through grain-size control (GC-L11). Areal-density advantage vs
laminated glass-polycarbonate is real but UNPROVEN at scale beyond
military niche orders; commercial flat-pane transparent armor remains
sub-1 m² typical.

---


Global glass-ceramic production focuses on cookware (CERAN/EuroKera),
optical (Zerodur, NEXTREMA), and dental restorations (IPS e.max).
Tonnage is small relative to commodity glass; price-per-kg is high.

| Producer | Subclass | Reported focus / scale | Source |
|----------|----------|------------------------|--------|
| Schott AG | Zerodur (mirror), NEXTREMA, CERAN | Cooktop CERAN ~ 5 M units/yr; Zerodur Class 0 niche optical | Schott IR + product datasheets |
| Eurokera (Saint-Gobain + Corning JV) | LAS cooktop | Dominant European cooktop GC supplier | Eurokera public |
| Corning | Macor, Pyroceram, Vision cookware (legacy), missile radomes | Macor: ~ kt/yr machinable GC; Pyroceram 9606 niche aerospace | Corning IR; product datasheets |
| Owens-Illinois (legacy) | early Pyroceram / cookware GC | Historical | Beall/Hopper review |
| Ivoclar Vivadent | IPS e.max Li-disilicate dental | Dominant dental GC; ~ M restorations/yr | Ivoclar Vivadent annual report |
| Ohara Inc. | LAS optical (CLEARCERAM-Z) | Niche optical (used for advanced lithography mirror blanks) | Ohara product datasheet |
| Surmet | ALON transparent armor (related ceramic, distinct from GC strictly) | Niche military | Surmet public |
| NEG (Nippon Electric Glass) | LAS substrate | Display/optical niche | NEG IR |

> **Honesty caveat (LATTICE_POLICY §3.3):** glass-ceramic producers
> bound capacity by **two-stage ceram-cycle line throughput + parent-
> glass melt-tank size** — not by lattice arithmetic. No projection
> onto n=6. Class 0 Zerodur output is reported in cubic meters / month,
> not lattice-derived.

---

## §4 STRUCT — glass-ceramic material flow

```
[Raw-batch oxides: SiO₂, Al₂O₃, Li₂CO₃, MgO + nucleant TiO₂/ZrO₂/P₂O₅ + fining agent]
        ↓ melt 1500–1650 °C in refractory tank
[Parent glass melt, homogenized]
        ↓ form (float / press / blow / rod-pull / cast)
[Parent glass article — same shape as final GC product, with stresses removed by anneal]
        ↓ STAGE 1: nucleation hold at T_n (= T_g + 10–30 K), 0.5–6 h
[Nucleated parent glass — invisible 5–20 nm nuclei from TiO₂/ZrO₂ phase-separation]
        ↓ STAGE 2: crystal growth hold at T_growth (0.65–0.85 × T_m of target crystal), 1–10 h
[Glass-ceramic — 50–95 vol-% crystalline; residual glass matrix tunes net CTE]
        ↓ optional: surface treatment (HF etch, ion-exchange strengthen)
        ↓
   ┌────┴───────┬───────────────────┬──────────────────────┐
   ↓            ↓                   ↓                      ↓
[Cooktop]   [Mirror blank Zerodur]  [Macor machinable]  [Dental IPS e.max]
            (→ astronomy/space)     (→ vacuum + lab)    (→ hexa-bio dental)

Transparent armor branch:
[Mg-Al-spinel batch] or [LAS w/ grain < 50 nm]
   ↓ hot-press or HIP (for spinel) / cerammed two-stage (for LAS armor)
   ↓
[Transparent armor pane] — ballistic + IR window
```

---

## §5 FLOW — process aspects in scope

| Process step | Material-aspect concern (this repo) | Out-of-scope |
|--------------|-------------------------------------|--------------|
| Batch + melt | parent-glass homogeneity, nucleant + fining agent | melt-tank refractory engineering → ceramics/, glass/ |
| Form (float/press/blow) | parent-glass dimensional fidelity | press/blow/float-line design → glass/ |
| Anneal | residual-stress relief in parent glass | annealer thermal profile → glass/ |
| Nucleation hold (T_n) | nuclei density, nucleant phase-separation | reactor furnace design |
| Crystal growth (T_growth) | crystalline phase identity, vol-% crystallinity, residual-glass composition | furnace ramp profiling |
| Net-CTE tuning | β-quartz ss negative CTE balance vs residual glass | end-product CTE qualification → vendor |
| Surface strengthening | optional ion-exchange or thermal-tempering | tempering line → glass/ |

---

## §6 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | Pyroceram 9606 cookware (Corning 1957, Stookey) | Commodity (legacy) |
| Mk.II | Vision cookware (Corning) | Commodity (legacy) |
| Mk.III | Zerodur Class 0 mirror blank (Schott 1968+) | Commercial niche (astronomy + lithography) |
| Mk.IV | CERAN / EuroKera induction-cooktop | Commodity |
| Mk.V | Macor machinable GC (Corning 1972) | Commercial |
| Mk.VI | IPS e.max Li-disilicate dental (Ivoclar 2005) | Commercial |
| Mk.VII | Transparent armor LAS / spinel | R&D + niche military — UNVERIFIED at large-pane production |
| Mk.VIII | Bioactive glass-ceramic (Apatite-Wollastonite Cerabone) | Niche bio (Kokubo) |
| Mk.IX | Sub-ppb metallic-contamination GC for EUV mirror substrate | R&D — UNPROVEN at production yield |
| Mk.X | Self-healing glass-ceramic | UNPROVEN |

---

## §7 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| Vitreous SiO₂ + parent-glass routes (float, press) | `glass/hexa-glass.md` |
| Sintered crystalline ceramic (Si₃N₄, ZrO₂, Al₂O₃) | `ceramics/ceramics.md` |
| Geopolymer (alkali-activated aluminosilicate cement) | `geopolymer/geopolymer.md` (sibling Phase D follow-on) |
| Bioactive glass-ceramic (Cerabone, Bioglass) | `hexa-bio` (sibling CLI — implant chemistry) |
| Transparent armor in vehicle / military | `hexa-mobility` (sibling) |
| Zerodur for telescope optics | `hexa-optics` (future sibling) |
| Dental restoration IPS e.max | `hexa-bio` (sibling — dental/maxillofacial) |
| Glass-ceramic recycling (cooktop end-of-life) | `recycling/recycling.md` |

---

## §8 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| Zerodur Class 0 α = 0 ± 0.007 × 10⁻⁶ /K | Schott TIE-43 | GC-L1 sanity |
| CERAN cooktop 700 °C service | Schott CERAN datasheet | GC-L3 sanity |
| Macor 94 MPa flexural | Corning Macor datasheet | GC-L4 sanity |
| IPS e.max 360–500 MPa | Ivoclar; ISO 6872 | GC-L7 sanity |
| Pyroceram 9606 ε_r ~ 5.6 | Corning Pyroceram 9606 datasheet | GC-L9 sanity |
| ASTM C1525 thermal-shock test | ASTM | GC-L12 sanity |
| Höland & Beall *Glass-Ceramic Technology* 2nd ed. (Wiley 2012) | textbook | crystallinity range + nucleation kinetics |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-GC-1 | Class 0+ Zerodur (α < 0.005 × 10⁻⁶ /K class) reproducibly at multi-vendor — re-baseline GC-L1 | OPEN |
| F-GC-2 | LAS cooktop sustained 1000 °C continuous-service vendor-warranted | OPEN |
| F-GC-3 | Transparent armor glass-ceramic > 2 m² pane at production yield | OPEN |
| F-GC-4 | Li-disilicate dental σ_f > 700 MPa reproducible across labs | OPEN |
| F-GC-5 | Self-healing glass-ceramic at room-T healing > 50 % strength recovery | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "Zerodur α = 0 fits n=6 lattice null term" — coincidence; do not write
- ✗ "Macor 94 MPa equals σ·τ × 1.96" — coincidence; do not write
- ✗ "Schott / Corning / Eurokera capacity tracks n=6" — they have not heard of it
- ✗ "Transparent armor LAS is a routine commercial pane" — UNVERIFIED at scale
- ✗ "Self-healing GC is production-ready" — UNPROVEN

---

## §9 Honest scope + caveats

1. **Material layer only.** Cookware product design, telescope mirror
   figure + polish, ballistic vehicle integration — **not here.** Call
   sibling repos.

2. **Class 0 Zerodur is a vendor-asserted grade.** UNVERIFIED at the
   Class 0 sub-7×10⁻⁹ /K level in-repo; cited verbatim from Schott.
   Verification belongs to gravimetric-dilatometry interferometry at
   NIST / PTB.

3. **Transparent armor + self-healing GC remain UNVERIFIED at
   production scale.** Mk.VII / Mk.X in §6 are R&D-only as of 2026.

4. **Glass-ceramic vs glass vs sintered ceramic distinction is
   load-bearing.** GC is **not** a glass (it is 50–95 vol-% crystalline)
   and **not** a sintered ceramic (it is formed from a parent glass via
   ceram cycle, not from powder pressed and densified). Routing this
   verb to `glass/` or `ceramics/` would erase the distinction.

5. **No lattice anchoring of vendor numbers.** Schott / Corning /
   Eurokera / Ivoclar / Ohara / NEG / Surmet capacities cited verbatim;
   no projection onto n=6.

6. **SPEC_FIRST verdict.** No numbers in this file are MEASURED in
   this repo; all from ASTM / ISO / CRC / Höland-Beall textbook /
   vendor public disclosures. Working `.hexa` numerical sandbox for
   glass-ceramic is TBD.

7. **Coincidence disclosure (LATTICE_POLICY §1.1).** Any apparent fit
   of glass-ceramic numbers to n=6 (e.g., Pyroceram ε_r = 5.6 ≈ n - 0.4)
   is coincidence with verification power zero.

---

## §10 References

- **ASTM C1525** — Thermal Shock Resistance of Advanced Ceramics by
  Water Quenching
- **ISO 6872** — Dentistry — Ceramic materials (Li-disilicate σ_f spec)
- **CRC Handbook of Chemistry and Physics**, 105th ed. (2024)
- Stookey S.D., "Catalyzed crystallization of glass in theory and
  practice," *Ind. Eng. Chem.* 51, 805 (1959) — Corning Pyroceram
  founding paper
- Beall G.H., "Design and Properties of Glass-Ceramics," *Annu. Rev.
  Mater. Sci.* 22, 91 (1992)
- Beall G.H., Pinckney L.R., "Nanophase glass-ceramics," *J. Am.
  Ceram. Soc.* 82, 5 (1999)
- Höland W., Beall G.H., *Glass-Ceramic Technology*, 2nd ed. (Wiley
  2012) — canonical reference
- Hopper R.W., "Stochastic theory of scattering from idealized spinodal
  structures," *J. Non-Cryst. Solids* 70, 111 (1985) — transparent
  GC crystallite-size criterion
- Kokubo T. (ed.), *Bioceramics and Their Clinical Applications*
  (Woodhead 2008) — Cerabone A-W bioactive GC
- Schott AG — Zerodur TIE-43 datasheet; CERAN technical bulletin;
  NEXTREMA product datasheet
- Corning Inc. — Macor, Pyroceram 9606 datasheets
- Eurokera — cooktop GC datasheet
- Ivoclar Vivadent — IPS e.max Press / CAD technical brochures
- Ohara Inc. — CLEARCERAM-Z datasheet
- Surmet — ALON transparent armor public material
- `LATTICE_POLICY.md` §1.2 + §1.3 (this repo)
- `LIMIT_BREAKTHROUGH.md` (this repo) — Wave M materials audit
- Cross-link siblings: `glass/hexa-glass.md`, `ceramics/ceramics.md`,
  `geopolymer/geopolymer.md`, `hexa-bio` (dental, bioactive),
  `hexa-optics` (future)

---

*Authored 2026-05-13 by 박민우. Material-layer spec for hexa-matter's
Phase D follow-on `glass-ceramic` verb (30 of 33). Real-limits-first
per LATTICE_POLICY.md §1.2; no lattice fit on glass-ceramic parameters
or Schott/Corning/Eurokera/Ivoclar vendor capacities. Cookware product
design, telescope-mirror finishing, and ballistic-vehicle integration
out of scope — see sibling repos.*
