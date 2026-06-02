<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — open-cell ultra-low-density solids (silica, carbon, polymer, graphene aerogels) -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; no lattice anchoring of aerogel-foam parameters -->
---
domain: aerogel-foam
requires: []
verb_group: ceramic_inorganic
status: SPEC_FIRST
verdict_basis: NIST + primary literature (Kistler / Hrubesh) + Aspen Aerogels / JIOS / Cabot vendor data; no lattice fit; cost honesty preserved (UNPROVEN at commodity price)
---

# Aerogel-Foam — n=6 소재 substrate, material verb (Phase D follow-on 32/33)

> **Material layer only.** Open-cell ultra-low-density solid materials
> made by **supercritical drying** (or ambient-pressure drying with
> surface modification) of a wet gel — silica aerogel (Kistler 1931),
> carbon aerogel (Pekala 1989 RF route), organic/polymer aerogel
> (resorcinol-formaldehyde, polyimide), and graphene aerogel.
> **Sub-100 kg/m³ density** (lower than most foams) with **mesoporous
> structure** (pore size 2–50 nm, BET 500–1500 m²/g typical).
> Distinct from `mof/` (which is *crystalline* nanoporous);
> aerogel is *amorphous-network* nanoporous.

> thermal conductivities, and BET surface areas are set by **sol-gel
> network connectivity + supercritical-drying schedule + post-treatment**
> — not by the n=6 lattice. Aspen Aerogels (Cryogel / Spaceloft) /
> Cabot (Lumira) / JIOS Aerogel / Enersens / Active Aerogels vendor
> figures cited verbatim with no lattice projection. **Cost-per-kg
> UNPROVEN at commodity price; cited at $20–100/kg insulation grade
> typical vs $500+/kg monolithic transparent grade.**

---

## §1 WHY — why aerogel-foam belongs in hexa-matter

Aerogel-foam occupies a unique corner of the materials envelope:
**ρ < 200 kg/m³**, **k_thermal < 20 mW/(m·K)** (lower than still air
at room T thanks to Knudsen effect), and **BET surface area
500–1500 m²/g** (silica) or up to **3000+ m²/g** (carbon, optimized).
The route is sol-gel chemistry + supercritical CO₂ drying (or
ambient-pressure drying after silylation surface treatment).

| Subclass | Network chemistry | Density (typical) | Signature property |
|----------|-------------------|---------------------|---------------------|
| Silica aerogel | Si-O-Si (sol-gel TEOS or TMOS) | 30–150 kg/m³ | k_thermal 12–17 mW/(m·K); transparent monolith blue-tint |
| Carbon aerogel | C-C network (RF aerogel pyrolysis) | 100–800 kg/m³ | Electrical-conductive; supercapacitor electrode |
| Polymer aerogel | RF resin / polyimide / polyurea | 100–500 kg/m³ | Mechanical flexibility; cryogenic insulation |
| Graphene aerogel | Stacked 2D graphene oxide → reduced | **0.16–10 kg/m³** | Lowest-density solid in 2013–2020 (Sun et al. 2013) |
| Metal-oxide aerogel | TiO₂, ZrO₂, Fe₂O₃ etc. via sol-gel | varies | Catalyst support; photocatalysis |
| Cellulose nanofibril (CNF) aerogel | bio-derived nanocellulose | 10–60 kg/m³ | Bio-based super-insulation R&D |

---

## §2 Real-limits-first — aerogel-foam's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| AG-L1 | Silica aerogel thermal conductivity (atm pressure, ambient T) | Physical / HARD | **12–17 mW/(m·K)** (lowest reported solid; lower than still air ≈ 26 mW/(m·K)) | Hrubesh 1998; NIST aerogel review |
| AG-L2 | Silica aerogel density (commercial Cabot Lumira translucent) | Engineering / SOFT | **70–150 kg/m³** | Cabot Lumira datasheet |
| AG-L3 | Silica aerogel density (laboratory record monoliths) | Physical / SOFT | **down to ≈ 1.0 kg/m³** | Hrubesh 1998; LLNL low-density work |
| AG-L4 | Graphene aerogel density (Sun et al. 2013 record) | Physical / SOFT | **0.16 kg/m³** (briefly held "lowest-density solid" record) | Sun et al. *Adv. Mater.* 25, 2554 (2013) |
| AG-L5 | Silica aerogel BET surface area | Physical / SOFT | **500–1000 m²/g** typical; up to 1500 m²/g | Hrubesh 1998 |
| AG-L6 | Carbon aerogel BET surface area | Physical / SOFT | up to **3000 m²/g** (activated) | Pekala 1989; Maxsorb-class activated-C overlap |
| AG-L7 | Silica aerogel transparency window | Physical / SOFT | 70–90 % vis transmission (3 mm sheet, low-ρ grade); Rayleigh-scattering blue tint | Hrubesh 1998 |
| AG-L8 | Silica aerogel max use-T (in air) | Engineering / SOFT | up to **500 °C continuous / 600 °C short** | Aspen / Cabot datasheet |
| AG-L9 | Aspen Spaceloft / Pyrogel max use-T | Engineering / SOFT | **−200 °C to +650 °C** (Pyrogel XTE) | Aspen Aerogels Pyrogel XTE datasheet |
| AG-L10 | Silica aerogel compressive σ (monolithic, low-ρ) | Engineering / SOFT | 0.1–1 MPa typical (fragile) | Hrubesh 1998 |
| AG-L11 | Aerogel blanket flexural σ (Aspen Spaceloft fiber-reinforced) | Engineering / SOFT | up to 1 MPa flexural | Aspen Spaceloft datasheet |
| AG-L12 | Aerogel cost-per-kg (commercial insulation blanket) | Engineering / **UNPROVEN** | **$20–100/kg** typical (insulation grade) vs **$500+/kg** monolithic transparent grade — vs polyurethane foam $2–5/kg | Vendor public estimates; UNVERIFIED at commodity-foam cost parity |
| AG-L13 | Knudsen-effect crossover pore size (silica) | Physical / HARD | mean free path λ_air ≈ 70 nm at STP; aerogel pores 5–50 nm → Knudsen regime suppresses gas-phase k | Knudsen 1909; Hrubesh review |
| AG-L14 | Supercritical CO₂ drying T/P | Engineering / SOFT | typically **40 °C / 80 bar** above CO₂ critical point (31 °C, 73.8 bar) | Kistler 1931; van Bommel review |
| AG-L15 | Ambient-pressure drying (APD) via silylation | Engineering / SOFT | TMCS or HMDSO surface treatment; replaces supercritical step at lower CapEx | Smith et al. 1995 (LLNL) |
| AG-L16 | Aerogel pore size range | Physical / HARD | **2–50 nm (mesoporous)** by IUPAC definition | IUPAC nomenclature |

**Note on AG-L1 (thermal conductivity below still-air).** Aerogel can
have lower k than still air because the **Knudsen effect** suppresses
gas-phase convection + conduction at pore sizes ≪ molecular mean free
path. The solid-network k is also low because the percolating network
is sparse (~ 5 % volume). NIST has measured 13 mW/(m·K) for monolithic
silica aerogel at standard conditions; vacuum-evacuated aerogel can
reach 5 mW/(m·K) (k_air → 0).

**Note on AG-L4 (graphene aerogel density record).** Sun et al. 2013
reported 0.16 kg/m³ graphene aerogel; this was the lowest-density
solid published as of that paper. Subsequent **Aerographite** (Mecklenburg
et al. 2012, 0.2 kg/m³) and metallic microlattice (Schaedler et al.
2011, 0.9 kg/m³) compete in this regime. **UNVERIFIED at production
scale** — these are research-only fabrications, not commercial products.

**Note on AG-L12 (cost — UNPROVEN at commodity price).** Aspen
Aerogels Spaceloft and Cabot Lumira are produced at commercial scale,
but cost-per-kg of $20–100 is **5–50× polyurethane foam at $2–5/kg**.
Transparent monolithic silica aerogel (research grade) is $500+/kg.
**No vendor has demonstrated parity with commodity foam at $2/kg** —
the "aerogel-as-commodity-insulation" Mk.IX claim is UNPROVEN at the
price tier needed for residential building retrofit at scale.

---


Global aerogel market is **niche**: ~ $700M–$1B/yr (industry estimates
~ 2024) vs polyurethane foam market ~ $80B/yr. Aerogel is concentrated
in oil/gas pipe insulation, cold-chain logistics, aerospace, and
specialty windows.

| Producer | Material focus | Reported deployment / scale | Source |
|----------|----------------|-------------------------------|--------|
| Aspen Aerogels (US) | Cryogel / Spaceloft / Pyrogel blanket | Dominant — pipe insulation oil/gas; recently EV battery thermal barrier | Aspen Aerogels 10-K filings |
| Cabot Corporation (US) | Lumira translucent silica aerogel | Daylighting + skylight market | Cabot IR |
| JIOS Aerogel (Singapore / KR) | silica aerogel granules + blanket | Industrial insulation | JIOS public |
| Enersens (FR) | KWARK silica aerogel blanket | Construction insulation | Enersens public |
| Active Aerogels (PT) | silica aerogel monolith + blanket | Specialty | Active Aerogels public |
| Aerogel Technologies (US) | Airloy structural aerogel composites | Research / niche | Aerogel Technologies public |
| Nano High-Tech (CN) | silica aerogel | Asian market | Nano High-Tech public |
| Guangdong Alison Hi-Tech (CN) | silica aerogel blanket | Asian market | Alison public |
| BASF (DE) | SLENTITE polyurethane aerogel | Discontinued / niche R&D | BASF public |

> **Honesty caveat (LATTICE_POLICY §3.3):** aerogel commercial scale
> is bounded by **supercritical-CO₂ autoclave throughput + sol-gel
> aging time (typically 1–7 days) + CapEx of drying line** — not by
> lattice arithmetic. No projection onto n=6. Cabot Lumira / Aspen
> Spaceloft / JIOS production volumes are reported in m³/yr, not
> derived from lattice.

---

## §4 STRUCT — aerogel-foam material flow

```
SILICA aerogel branch (Kistler 1931 + supercritical CO₂ APD):
   [TEOS or TMOS or water-glass + EtOH + water + acid/base catalyst]
        ↓ sol-gel hydrolysis + condensation
   [Wet alcogel — Si-O-Si network with EtOH/water in pores]
        ↓ solvent exchange to liquid CO₂ (24–72 h)
        ↓ supercritical CO₂ drying (40 °C / 80 bar, depressurize slowly)
   [Silica aerogel monolith]
        ↓ optional + fiber felt → impregnate
   [Aerogel blanket — Aspen Spaceloft / Pyrogel / Cryogel; Cabot Lumira granule]
        ↓
   [Application: pipe insulation, EV battery pack, building wall, daylighting]

CARBON aerogel branch (Pekala 1989 RF):
   [Resorcinol + formaldehyde + Na₂CO₃ catalyst + water]
        ↓ sol-gel + cure 80–95 °C × 7 d
   [RF (resorcinol-formaldehyde) hydrogel]
        ↓ solvent exchange + supercritical CO₂ dry
   [RF aerogel — organic, ρ 100–800 kg/m³]
        ↓ pyrolysis 800–1100 °C in inert atmosphere
   [Carbon aerogel]
        ↓ optional activation (steam/CO₂ 800 °C)
   [Activated carbon aerogel — BET > 2000 m²/g]
        ↓
   [Supercapacitor electrode / Li-ion anode research]

GRAPHENE aerogel branch (Sun et al. 2013):
   [Graphene oxide aqueous suspension]
        ↓ self-assembly + freeze-cast 3D scaffold
        ↓ freeze-dry
        ↓ reduce (thermal or hydrazine)
   [Reduced graphene oxide (rGO) aerogel — ρ 0.16–10 kg/m³]

Cellulose aerogel branch:
   [Cellulose nanofibril (CNF) aqueous gel]
        ↓ supercritical CO₂ or freeze-dry
   [CNF aerogel — bio-based, ρ 10–60 kg/m³]
```

---

## §5 FLOW — process aspects in scope

| Process step | Material-aspect concern (this repo) | Out-of-scope |
|--------------|-------------------------------------|--------------|
| Sol-gel precursor (TEOS / TMOS / RF / GO) | hydrolysis-condensation kinetics, gel time | precursor distillation → hexa-chip (silane) |
| Solvent exchange | EtOH → CO₂ exchange schedule | autoclave engineering |
| Supercritical drying (autoclave) | T-P trajectory, depressurize rate, structural collapse | autoclave hardware → out-of-repo |
| Ambient-pressure drying via silylation | TMCS/HMDSO surface modification chemistry | process line CapEx |
| Pyrolysis (carbon aerogel) | 800–1100 °C inert atmosphere ramp | furnace design |
| Fiber reinforcement (blanket) | aerogel-fiber adhesion, dust handling | end-product fabrication |
| Application integration (EV battery, pipe) | aerogel-substrate bonding | application-side thermal management → hexa-mobility, hexa-energy |

---

## §6 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | Kistler silica aerogel (1931, Stanford) | Foundational |
| Mk.II | Pekala RF + carbon aerogel (1989, LLNL) | Demonstrated |
| Mk.III | Hrubesh transparent monolith (1990s, LLNL) | Research / niche |
| Mk.IV | Aspen Cryogel + Spaceloft commercial (early 2000s) | Commercial |
| Mk.V | Cabot Lumira translucent (2003) | Commercial |
| Mk.VI | Sun et al. graphene aerogel 0.16 kg/m³ (2013) | Research record |
| Mk.VII | EV battery thermal barrier (Aspen post-2020 ramp) | Commercial — emerging |
| Mk.VIII | Cellulose nanofibril (bio) aerogel super-insulation | R&D |
| Mk.IX | Aerogel insulation at commodity-foam cost ($2–5/kg) | **UNPROVEN** — no vendor at parity |
| Mk.X | Self-healing aerogel | UNPROVEN |
| Mk.XI | Aerogel as space radiation shielding (Cassini-Stardust legacy comet-dust capture) | Demonstrated niche |

---

## §7 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| MOF (crystalline nanoporous — Yaghi 1999+) | `mof/mof.md` (sibling Phase D) |
| Activated carbon (random porous, not aerogel) | `carbon/carbon.md` (C-L15 BET overlap) |
| Polymer foam (closed-cell PU, EPS) | `elastomer/elastomer.md`, `POLYMER-CHEMISTRY.md` |
| Geopolymer foam (alkali-activated low-ρ) | `geopolymer/geopolymer.md` (sibling Phase D follow-on) |
| Silica glass + fused silica | `glass/hexa-glass.md`, `silicon/silicon.md` |
| Aerogel for spacecraft radiation / dust capture | `hexa-space` (sibling future) |
| EV battery thermal barrier (Aspen post-2020) | `hexa-mobility`, `hexa-energy` |
| Bio-derived nanocellulose | `wood-cellulose/wood-cellulose.md` |
| Daylighting / translucent insulation | `hexa-build` (sibling future) |
| Supercapacitor / Li-anode carbon aerogel | `hexa-energy` |

---

## §8 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| NIST aerogel k_thermal 13 mW/(m·K) | NIST aerogel review | AG-L1 sanity |
| Hrubesh aerogel review 1998 | *J. Non-Cryst. Solids* 225, 335 | AG-L1/L5/L7 sanity |
| Sun et al. graphene aerogel 0.16 kg/m³ | *Adv. Mater.* 25, 2554 (2013) | AG-L4 sanity |
| Pekala RF + carbon aerogel | *J. Mater. Sci.* 24, 3221 (1989) | carbon aerogel anchor |
| Kistler original silica aerogel | *Nature* 127, 741 (1931) | foundational |
| IUPAC mesoporous (2–50 nm) | IUPAC nomenclature | AG-L16 |
| Aspen Pyrogel XTE −200 to +650 °C | Aspen datasheet | AG-L9 sanity |
| Cabot Lumira datasheet | Cabot | AG-L2 sanity |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-AG-1 | Aerogel insulation at < $5/kg at commodity foam quality | OPEN |
| F-AG-2 | Aerogel monolith > 1 m² transparent pane at production yield | OPEN |
| F-AG-3 | Aerogel k_thermal < 5 mW/(m·K) at atm pressure (currently requires vacuum) | OPEN |
| F-AG-4 | Aerogel compressive σ > 10 MPa at < 100 kg/m³ density (no fiber reinforcement) | OPEN |
| F-AG-5 | Aerogel insulation in mass-market residential building retrofit | OPEN |
| F-AG-6 | Aerogel density < 0.1 kg/m³ reproducibly | OPEN |
| F-AG-7 | Self-healing aerogel preserving > 80 % σ_c after damage cycle | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "Silica aerogel k = 13 mW/(m·K) fits n=6 lattice null" — coincidence
- ✗ "Aspen Aerogels capacity tracks n=6" — they have not heard of it
- ✗ "Aerogel will displace polyurethane foam in residential at scale" —
  UNPROVEN at cost (Mk.IX); currently $20–100/kg vs $2–5/kg PU
- ✗ "Graphene aerogel 0.16 kg/m³ is a production material" — UNVERIFIED;
  research-only fabrication
- ✗ "Transparent monolithic silica aerogel is a commodity glazing" —
  UNPROVEN at large-pane production; <m² typical
- ✗ "Self-healing aerogel is production-ready" — UNPROVEN


---

## §9 Honest scope + caveats

1. **Material layer only.** Building-envelope thermal design, EV
   battery pack engineering, spacecraft thermal-control system —
   **not here.** Call sibling repos.

2. **Cost-per-kg UNPROVEN at commodity foam parity.** $20–100/kg
   insulation grade is 5–50× polyurethane foam at $2–5/kg. The
   "aerogel-replaces-PU-foam-in-residential" narrative remains
   UNPROVEN at scale (Mk.IX in §6).

3. **Density records UNVERIFIED at production scale.** Sun 2013
   graphene aerogel 0.16 kg/m³ and Aerographite 0.2 kg/m³ are
   research-only fabrications. Commercial silica aerogel is 70–150
   kg/m³ (Cabot, Aspen).

4. **Mechanical fragility.** Silica aerogel monolith σ_c < 1 MPa
   typical; commercial blankets (Aspen Spaceloft) use fiber felt
   reinforcement to gain mechanical handleability.

5. **Process CapEx + scale.** Supercritical CO₂ drying requires
   pressure-vessel autoclave; ambient-pressure drying (APD) via
   silylation lowers CapEx but adds chemistry steps. Both are slower
   than commodity foam blowing (PU foam: minutes; aerogel: days).

6. **Distinction from `mof/` (crystalline nanoporous).** MOFs (Yaghi,
   1999+) are **crystalline** with periodic pores; aerogels are
   **amorphous-network** with broad pore-size distribution. Both
   "nanoporous" but routing aerogel through `mof/` would erase the
   distinction (crystallographic order, BET regime, synthesis route).

7. **No lattice anchoring of vendor numbers.** Aspen / Cabot / JIOS
   / Enersens / Active / BASF figures cited verbatim; no projection
   onto n=6.

8. **SPEC_FIRST verdict.** All numbers from NIST / Hrubesh / Pekala /
   Sun / IUPAC / vendor public disclosures. Working `.hexa` numerical
   sandbox for aerogel-foam is TBD.

9. **Coincidence disclosure (LATTICE_POLICY §1.1).** Any apparent fit
   of aerogel numbers to n=6 (e.g., silica BET ≈ 1000 m²/g ≈ σ·τ × 83)
   is coincidence with verification power zero.

---

## §10 References

- Kistler S.S., "Coherent expanded aerogels and jellies," *Nature* 127,
  741 (1931) — foundational silica aerogel paper
- Pekala R.W., "Organic aerogels from the polycondensation of
  resorcinol with formaldehyde," *J. Mater. Sci.* 24, 3221 (1989) —
  RF + carbon aerogel
- Hrubesh L.W., "Aerogel applications," *J. Non-Cryst. Solids* 225,
  335 (1998) — canonical review
- Smith D.M., Stein D., Anderson J.M., Ackerman W., "Preparation of
  low-density xerogels at ambient pressure," *J. Non-Cryst. Solids*
  186, 104 (1995) — APD route
- Sun H., Xu Z., Gao C., "Multifunctional, ultra-flyweight, synergistically
  assembled carbon aerogels," *Adv. Mater.* 25, 2554 (2013) — graphene
  aerogel 0.16 kg/m³ density record
- Mecklenburg M., Schuchardt A., Mishra Y.K., Kaps S., Adelung R.,
  Lotnyk A., Kienle L., Schulte K., "Aerographite: ultra lightweight,
  flexible nanowall, carbon microtube material," *Adv. Mater.* 24,
  3486 (2012)
- Schaedler T.A., Jacobsen A.J., Torrents A., Sorensen A.E., Lian J.,
  Greer J.R., Valdevit L., Carter W.B., "Ultralight metallic
  microlattices," *Science* 334, 962 (2011)
- van Bommel M.J., de Haan A.B., "Drying of silica aerogel with
  supercritical CO₂," *J. Non-Cryst. Solids* 186, 78 (1995)
- IUPAC nomenclature — mesoporous (2–50 nm) definition
- **NIST** aerogel reference materials + thermal-conductivity values
- Aspen Aerogels — Cryogel / Spaceloft / Pyrogel XTE technical
  datasheets + 10-K filings
- Cabot Corporation — Lumira aerogel datasheet
- JIOS Aerogel — silica aerogel blanket datasheet
- Enersens — KWARK silica aerogel datasheet
- Active Aerogels — product literature
- BASF — SLENTITE polyurethane aerogel R&D record
- `LATTICE_POLICY.md` §1.2 + §1.3 (this repo)
- `LIMIT_BREAKTHROUGH.md` (this repo) — Wave M materials audit
- Cross-link siblings: `mof/mof.md`, `carbon/carbon.md`,
  `glass/hexa-glass.md`, `geopolymer/geopolymer.md`,
  `wood-cellulose/wood-cellulose.md`, `hexa-energy`, `hexa-mobility`

---

*Authored 2026-05-13 by 박민우. Material-layer spec for hexa-matter's
Phase D follow-on `aerogel-foam` verb (32 of 33). Real-limits-first
per LATTICE_POLICY.md §1.2; no lattice fit on aerogel-foam parameters
or Aspen/Cabot/JIOS/Enersens vendor capacities. Cost-per-kg UNPROVEN
at commodity-foam parity ($20–100/kg insulation grade vs $2–5/kg PU
foam); transparent monolith $500+/kg research grade. Graphene
aerogel 0.16 kg/m³ density record (Sun 2013) UNVERIFIED at production
scale. Building-envelope + EV-battery + spacecraft thermal-system
design out of scope.*

---

## Related NOVEL candidate

- `hxm-aero-polyimide-001` — see [NOVEL.md §4.D.12](../NOVEL.md): polyimide aerogel.

> SIM / proxy status is NOT a measurement and does NOT promote to `EXTERNAL-VERIFIED` without attributed external-lab evidence (NOVEL.md §7 · @F f2 / f5).
