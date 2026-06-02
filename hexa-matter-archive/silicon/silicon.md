<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer only — semiconductor architecture lives in hexa-chip -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; no lattice anchoring of Si parameters -->
---
domain: silicon
requires: []
verb_group: ceramic_inorganic_extended
status: SPEC_FIRST
verdict_basis: vendor-published numbers + NIST/CRC; no lattice fit
---

# Silicon — n=6 소재 substrate, material verb (17/17)

> **Material layer only.** Elemental Si (polysilicon, mono-Si wafers), SiO₂
> (cross-link to `glass/`), SiC / SiN / Si₃N₄ ceramics (cross-link to
> `ceramics/`), silicone (Si-O polymer). **Czochralski / float-zone growth
> are referenced as material-aspect (purity, defect, dimensional ceiling),
> NOT as process-flow design — process-flow + device architecture live in
> `hexa-chip` (call `hexa-chip materials` directly).**

> (9N electronic-grade) and dimensional ceilings (CZ crucible ~600 mm,
> FZ rod ~200 mm) are **set by metallurgy, thermal physics, and vendor
> engineering** — not by the n=6 lattice. The n=6 lattice does NOT predict
> these numbers; any apparent fit is coincidence. External producers
> (Wacker, GCL, Hemlock, OCI, REC) use their own published figures.

---

## §1 WHY — why silicon belongs in hexa-matter

Silicon is the second-most-abundant crust element (≈27.7 % by mass, CRC
Handbook 105th ed.) and the largest single material input by mass to the
electronics industry. As a **material**, three distinct forms are in
scope here:

| Form | Description | Vendor / source examples |
|------|-------------|--------------------------|
| Polysilicon (poly-Si) | Granular / chunk feedstock; 6N–11N purity grades | Wacker Polysilicon · GCL Tech · Hemlock · OCI · REC Silicon |
| Monocrystalline Si (mono-Si) | CZ-pulled or FZ-grown single-crystal ingots/wafers | Shin-Etsu · SUMCO · Siltronic · GlobalWafers · SK Siltron |
| SiO₂ / silicate | Quartz, fused silica, silicate glass component (cross-link → `glass/`) | NIST SRM quartz; commercial fused silica from Heraeus, Corning |
| SiC / SiN / Si₃N₄ | Compound ceramics (cross-link → `ceramics/`) | Wolfspeed (SiC), Coorstek, Kyocera |
| Silicone (Si-O polymer) | PDMS and related; **distinct from elemental Si** | Dow Corning, Wacker Silicones, Shin-Etsu Silicones |

The semiconductor *device* — transistor, MOSFET, lithographic patterning,
EUV resist stack — is **out of scope here**; it lives in `hexa-chip`
(see §7 cross-link).

---

## §2 Real-limits-first — silicon's actual ceilings

Per `LATTICE_POLICY.md §1.2` and the project audit in
`LIMIT_BREAKTHROUGH.md` (Wave M), the relevant HARD/SOFT walls for
elemental Si and Si-compound materials:

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| Si-L1 | Electronic-grade poly-Si purity ceiling | Engineering / SOFT_WALL | **9N (99.9999999 %)** — total metallic impurities < 1 ppba | SEMI M1 / vendor specs (Wacker, Hemlock) |
| Si-L2 | Solar-grade poly-Si (SoG-Si) purity floor | Engineering / SOFT | 6N–7N (99.9999 %–99.99999 %) | SEMI PV17 |
| Si-L3 | CZ crucible diameter (production ceiling) | Engineering / SOFT | **≈ 600 mm** (32-inch fused-silica crucible class; supports 450 mm wafer pulls in R&D) | Ferrotec / Heraeus crucible specs |
| Si-L4 | FZ ingot diameter | Engineering / SOFT | **≈ 200 mm** (8-inch; RF-coil + surface-tension limited) | Topsil / Siltronic FZ datasheets |
| Si-L5 | Si melting point | Physical / HARD | **1687 K (1414 °C)** | NIST WebBook |
| Si-L6 | Si density (solid, 293 K) | Physical / HARD | **2.329 g/cm³** | CRC Handbook 105th ed. |
| Si-L7 | Si bandgap (indirect, 300 K) | Physical / HARD | **1.12 eV** (material parameter; device design lives in hexa-chip) | NIST / Sze SM Physics |
| Si-L8 | Thermal donor concentration (CZ Si, post-anneal) | Physical / SOFT | ≈ 10¹⁶ cm⁻³ at 450 °C interstitial-O cluster regime | Kaiser-Frisch 1958; Bullis SEMI |
| Si-L9 | Interstitial oxygen [O_i] in CZ wafer | Engineering / SOFT | 10–30 ppma (typical CZ); FZ < 0.1 ppma | ASTM F121 / F1188 |
| Si-L10 | Dislocation density (mono-Si wafer) | Engineering / SOFT | Production: < 100 cm⁻² etch-pit count; perfect crystal: 0 (achievable) | ASTM F47 |
| Si-L11 | SiC wide bandgap | Physical / HARD | **3.26 eV (4H-SiC)** | Saddow & Agarwal 2004 |
| Si-L12 | Si₃N₄ flexural strength (HIP-densified) | Engineering / SOFT | 600–1200 MPa | ASM Handbook vol. 21 |

**Note on the 9N ceiling (Si-L1).** 99.9999999 % electronic-grade is a
**process + measurement** ceiling: it represents the floor of what GDMS,
ICP-MS, and SIMS can routinely qualify against, combined with the limit
of Siemens-process trichlorosilane distillation column performance. It
is **not** a physical impossibility to go higher; it is the point at
which additional purification stops being worth the cost for transistor
operation. Float-zone refining can locally reach 11N for niche detector
applications.

**Note on dimensional ceilings (Si-L3 / Si-L4).** CZ crucible size is
bounded by fused-silica creep at 1500 °C + mechanical handling. FZ rod
diameter is bounded by surface-tension support of the molten zone +
RF-coil power coupling. Both are **engineering soft walls**, not
fundamental physics, but neither has moved more than ~30 % in 30 years
at production scale.

---


Polysilicon global production (electronic + solar grade combined), as of
the most recent public reporting. Numbers are vendor / market-research
published; this spec **does not project these onto n=6 nor claim n=6 is
implicated**.

| Producer | Country | Reported nameplate (kt/yr) | Source |
|----------|---------|---------------------------|--------|
| GCL Technology | CN | ~ 480 | GCL annual report |
| Tongwei (formerly Yongxiang) | CN | ~ 350 | Tongwei IR |
| Daqo New Energy | CN | ~ 300 | Daqo 20-F filing |
| Wacker Chemie | DE / US (TN) | ~ 80 | Wacker annual report |
| OCI Holdings | KR / MY | ~ 35 | OCI IR |
| Hemlock Semiconductor | US (MI) | ~ 30 (EG-Si focus) | company release |
| REC Silicon | US (WA) | ~ 18 (idled / restart) | REC IR |

Of this total, **electronic-grade (9N+) is roughly 50–80 kt/yr globally**
— dominated by Wacker + Hemlock + OCI. Solar-grade (6N–7N) is the
overwhelming majority of tonnage.

> **Honesty caveat (LATTICE_POLICY §3.3):** these producers have not
> heard of n=6. Do not χ²-fit their tonnage to σ·τ=48. Their capacity is
> bounded by Siemens-reactor count, chlorosilane feedstock, and
> electricity cost — not by lattice arithmetic.

---

## §4 STRUCT — the silicon material flow

```
                    [Quartz / silica sand]                            ← SiO₂ (cross-link: glass/)
                            ↓ carbothermic reduction (1900 °C, arc furnace)
                    [Metallurgical-grade Si (MG-Si, ≈ 98–99 %)]      ← cross-link: metallurgy/
                            ↓ HCl + Cu catalyst → trichlorosilane (TCS)
                    [Distilled TCS (SiHCl₃, electronic purity)]
                            ↓ Siemens / FBR process (CVD on hot rod)
        ┌───────────────────┴───────────────────┐
        ↓                                       ↓
[Polysilicon chunk/granule]              [Polysilicon, solar grade]
   (9N+ EG-Si)                              (6N–7N SoG-Si)
        ↓                                       ↓
   ┌────┴──────┐                          [PV ingot, multicrystalline]
   ↓           ↓                                ↓
 [CZ pull]  [FZ refine]                     [PV wafer cut]
 (crucible)  (no crucible,                       ↓
   ↓          O-free)                       (→ solar cell — NOT this repo)
[Mono-Si ingot, CZ]   [Mono-Si rod, FZ]
   ↓ wire-saw + lap + etch + polish (CMP)
[200/300/450 mm wafer]
   ↓
(→ device fab: hexa-chip 's domain — fab process, lithography, transistor)

Side branches (in scope for this spec, cross-link to other verbs):
  SiO₂ → fused silica, optical glass, silicate ceramics → `glass/`, `ceramics/`
  SiC → wide-bandgap ceramic / power-device substrate → `ceramics/` (material), hexa-chip (device)
  Si₃N₄ → structural ceramic, bearing balls, cutting tool → `ceramics/`
  Si-O-Si polymer (PDMS, silicones) → distinct from elemental Si; future polymer verb if expanded
```

---

## §5 FLOW — process aspects in scope

This spec covers the **material aspect** of silicon process — what
determines purity, dimensional, and defect ceilings. It does **not**
cover device-fab process design.

| Process step | Material-aspect concern (this repo) | Out-of-scope (→ hexa-chip) |
|--------------|-------------------------------------|----------------------------|
| Carbothermic reduction | MG-Si purity, Fe/Al/Ca residuals | — |
| TCS distillation | column performance, B/P removal | — |
| Siemens / FBR | poly-Si grain, hydrogen content | — |
| Czochralski pull | O_i, C, dopant uniformity, dislocation, **crucible size** | wafer-level deviceability metrics |
| Float-zone refine | resistivity uniformity, low-O, **rod diameter** | — |
| Wire-saw + CMP | TTV, bow, warp, edge profile | mask-aligner flatness specs |
| Wafer epi (Si on Si) | epi-defect density, slip | epitaxy as gate-stack prep → hexa-chip |
| SiC sublimation growth | 4H-SiC poly-type stability, micropipe density | SiC MOSFET design → hexa-chip |

---

## §6 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | 200 mm CZ + 9N EG-Si (Wacker / Hemlock 1990s) | Deployed / commodity |
| Mk.II | 300 mm CZ standard (early 2000s) | Deployed / commodity |
| Mk.III | 450 mm CZ wafer | R&D + paused (G450C industry consortium 2012–2017, paused) |
| Mk.IV | 11N FZ Si for radiation detectors (Topsil / Hamamatsu) | Niche commercial |
| Mk.V | 200 mm 4H-SiC wafers (Wolfspeed Mohawk Valley) | Ramping (2024–) |
| Mk.VI | Isotope-pure ²⁸Si for quantum-coherence / k_th boost | Lab scale (NMI, IKZ) |

These are **engineering frontiers**, not lattice tautologies. Each
moves on its own metallurgy/thermal-physics merits.

---

## §7 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| SiO₂ as glass / optical | `glass/hexa-glass.md` (this repo) |
| SiC / SiN / Si₃N₄ as structural ceramic | `ceramics/ceramics.md` (this repo) |
| MG-Si as carbothermic-reduction product | `metallurgy/swordsmithing.md` (this repo) — *metallurgy verb extends beyond steel* |
| Crystal-growth physics (CZ / FZ) — material aspect | this spec, §2 + §5 |
| **Crystal-growth process flow + fab integration** | **`hexa-chip materials`** (sibling CLI) |
| **Transistor / MOSFET / lithography / EUV resist** | **`hexa-chip`** |
| **Wafer-level fab capacity, ASML throughput, TSMC / Intel / Samsung** | **`hexa-chip` (terafab envelope, etc.)** |

Boundary rule: this spec ends at the **wafer leaving the polishing line**.
What happens after that — wafer in, die out — is `hexa-chip`'s domain.

---

## §8 VERIFY — anchors and falsifiers

Per `LATTICE_POLICY.md §1.3` rule 2, this verb's verification anchors
are **real engineering / physical limits**, not n=6 lattice fits.

| Anchor | Source | Used for |
|--------|--------|----------|
| Si T_m = 1687 K | NIST WebBook | melting-point sanity |
| Si ρ = 2.329 g/cm³ | CRC Handbook 105th | density sanity |
| Si E_g = 1.12 eV (300 K) | NIST / Sze | material-parameter sanity (NOT device claim) |
| SEMI M1 EG-Si grade definition | SEMI International | purity-spec sanity |
| ASTM F121 / F1188 (CZ wafer O / C) | ASTM | wafer-spec sanity |
| Wacker / Hemlock / GCL annual capacity | vendor IR | tonnage cross-check |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-Si-1 | Any peer-reviewed reproduction of routine 12N+ poly-Si at commercial volume → re-baseline Si-L1 | OPEN |
| F-Si-2 | Production 600 mm wafer pull at any vendor → re-baseline Si-L3 | OPEN |
| F-Si-3 | FZ rod diameter > 250 mm at production volume → re-baseline Si-L4 | OPEN |
| F-Si-4 | Sub-200 K E_g shift for bulk Si beyond literature → flag literature error (not a Si breakthrough) | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "Si purity 9N equals σ·sopfr·... = 9" — coincidence; do not write
- ✗ "Si CZ crucible 600 mm fits n=6 × 100" — coincidence; do not write
- ✗ "Si T_m 1687 K relates to σ·τ=48" — no; T_m is bond-energy + entropy
- ✗ "Wacker / GCL capacity follows n=6 lattice" — they have not heard of it



---

## §9 Honest scope + caveats

1. **Material layer only.** Semiconductor device, fab process,
   lithography, EUV resist — **not here.** Call `hexa-chip materials`
   for those. This repo's `[crosslink]` in `hexa.toml` is explicit.

2. **Silicone (Si-O polymer) is distinct from elemental Si.** PDMS and
   related silicones live in the polymer side of the materials tree; in
   this repo they are noted but not deeply specced (future polymer verb
   candidate if depth is needed).

3. **No lattice anchoring of vendor numbers.** Wacker / GCL / Hemlock /
   OCI / REC / Shin-Etsu / SUMCO / Siltronic / GlobalWafers / SK Siltron
   tonnages are their own published figures. This spec does not project
   any of them onto n=6.

4. **9N is an engineering soft wall.** Not a physical impossibility to
   exceed; an economic + measurement + process cliff. 11N FZ Si exists
   for radiation-detector niches. 12N+ remains a research-and-cost
   question, not a Si-the-atom question.

5. **SPEC_FIRST verdict.** No numbers in this file are MEASURED in
   this repo; all are cited from NIST / CRC / ASTM / SEMI / vendor
   public disclosures. Working `.hexa` numerical sandbox for Si is TBD
   (no F-Si-* gate is wired to a running sandbox yet).

6. **Coincidence disclosure (LATTICE_POLICY §1.1).** If any reader
   notices that, e.g., 200 mm wafer is "≈ σ·τ × 4" or 9N is "≈ n=6 + 3" —
   that is **coincidence, not predictive content**. The lattice did not
   predict these numbers; the numbers existed first and the lattice can
   only describe them after the fact, which has verification power zero.

---

## §10 References

- **NIST WebBook**, https://webbook.nist.gov/chemistry/ (Si T_m, ρ, E_g)
- **CRC Handbook of Chemistry and Physics**, 105th ed. (2024) — Si crust abundance, density
- **SEMI M1** — Specification for Polished Single Crystal Silicon Wafers
- **SEMI PV17** — Solar-grade Si feedstock specification
- **ASTM F121 / F1188** — Interstitial oxygen / carbon in CZ Si
- **ASTM F47** — Crystallographic perfection of Si by preferential etch
- Sze S.M., Ng K.K., *Physics of Semiconductor Devices*, 3rd ed. (2007) — material parameter sourcing for E_g (cross-verify only; device chapters are hexa-chip's reading)
- Saddow S.E., Agarwal A. (eds.), *Advances in Silicon Carbide Processing & Applications* (2004) — 4H-SiC bandgap
- Kaiser W., Frisch H.L., Reiss H., *Phys. Rev.* 112, 1546 (1958) — thermal donors in CZ Si
- Wacker Chemie AG — annual reports (poly-Si capacity)
- GCL Technology — annual reports
- Hemlock Semiconductor — public releases
- Topsil / Siltronic / SUMCO — FZ and CZ ingot datasheets
- Wolfspeed — 200 mm 4H-SiC wafer announcements (2022–2024)
- `LATTICE_POLICY.md` (this repo) — §1.2 real-limits table; §1.3 verification standard
- `LIMIT_BREAKTHROUGH.md` (this repo) — Wave M materials audit (Si fits the SOFT_WALL pattern of §3)
- Cross-link sibling: `dancinlab/hexa-chip` (semiconductor device + fab process layer)

---

*Authored 2026-05-13 by 박민우. Material-layer spec for hexa-matter's
17th verb. Real-limits-first per LATTICE_POLICY.md §1.2; no lattice fit
on Si purity / dimension / vendor tonnage. Semiconductor device + fab
process out of scope — see `hexa-chip` (sibling CLI).*

---

## Related NOVEL candidates

- `hxm-pv-tandem-002` — see [NOVEL.md §4.A.11](../NOVEL.md): perovskite/Si 4-terminal tandem (Si bottom-cell substrate, 1.12 eV E_g).
- `hxm-quantum-si-donor-001` — see [NOVEL.md §4.C.1](../NOVEL.md): Si donor-spin quantum-defect host.

> SIM / proxy status is NOT a measurement and does NOT promote to `EXTERNAL-VERIFIED` without attributed external-lab evidence (NOVEL.md §7 · @F f2 / f5).
