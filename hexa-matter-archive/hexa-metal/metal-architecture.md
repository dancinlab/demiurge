<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_MET architectural overview -->

# metal-architecture — alloy categories, processing routes, superalloy strengthening

> Architectural overview of GROUP_MET. Companion to `METALLURGY-DEEP.md`
> (root, 308 lines) and `SUPERALLOY.md` + `MAGNETIC-MATERIALS.md`.

## §1 The MET alloy hierarchy

```
                                  GROUP_MET
                                     |
              +----------------------+----------------------+
              |                                             |
           ferrous                                     non-ferrous
              |                                             |
   +----------+----------+              +-----------+-------+-------+
   |          |          |              |           |               |
 plain     stainless   tool         Al alloy    Cu alloy        Ti alloy
 carbon    (304,316,   (D2, M2,     (1xxx-7xxx, brass (Cu-Zn)   (CP, α-β,
 steel     17-4PH,     H13)          Al-Cu, Al- bronze (Cu-Sn,    β)
 (1018,    duplex)                   Si, Al-Mg, Cu-Si silicon-
 1045,                              Al-Zn-Mg)   bronze)         Ti-6Al-4V
 1080,                                                          (grade 5)
 4140)
                                                                 |
                                      Mg alloy  Ni alloy        +---+
                                      (AZ31,    (Inconel,        |
                                       ZK60)    Hastelloy)   refractory
                                                              metal
                                                              (W, Mo, Ta,
                                                               Re, Os, Ir)

                                                              precious metal
                                                              (Au, Ag, Pt,
                                                               Pd, Rh)

       superalloy (Phase D)                          magnetic (Phase D)
              |                                            |
   +----------+----------+                  +---+----+--------+-----+
   |          |          |                  |        |        |      |
 Ni-base   Co-base    Fe-Ni-base       hard mag   soft mag  amorphous
 (Inconel  (Mar-M     (A286)           NdFeB     ferrite   Metglas
  718,      247)                       (~35-55   (Mn-Zn,    (Fe-Si-B
  Waspaloy, single-                     MGOe)    Ni-Zn)     2705M)
  Rene 41) crystal                     SmCo     soft Fe     nanocrystalline
           (CMSX-10,                   (SmCo₅,  electrical  Finemet
           CMSX-4)                      Sm₂Co₁₇) steel      (FeCuNbSiB)
           Re-bearing                           (Fe-3% Si  tetrataenite
           (4-6 wt% Re)                          GO)       (UNVERIFIED bulk)
           Re-free                                          MnBi (UNVERIFIED)
           UNVERIFIED                                       Fe₁₆N₂ (UNVERIFIED)
```

## §2 Bond + crystal-structure map

| Alloy class | Crystal structure | Bond character | T_m (K) | ρ (g/cm³) | Industrial signature |
|-------------|-------------------|----------------|---------|-----------|----------------------|
| Plain carbon steel | bcc α-Fe (room T), fcc γ-Fe (T_α↔γ ~1183 K) | metallic | 1808 (pure Fe) | 7.87 | structural, automotive |
| Stainless 304 | fcc austenite | metallic | ~1700 | 8.00 | corrosion-resistant |
| Tool steel D2 | bcc + carbides | metallic + covalent C | ~1700 | 7.70 | dies, knives |
| Al alloy 6061 | fcc | metallic | 925 | 2.70 | aerospace, automotive |
| Al alloy 7075 | fcc | metallic | 908 | 2.81 | aircraft structural |
| Cu (annealed) | fcc | metallic | 1358 | 8.94 | electrical, plumbing |
| Brass (Cu-30Zn) | fcc α + bcc β | metallic | 1198 | 8.40 | bell metal (lutherie cross), valves |
| Bronze (Cu-12Sn) | fcc + bcc | metallic | 1283 | 8.80 | gong, bearing |
| Cu-Si bronze | fcc | metallic | 1300 | 8.50 | propeller, fastener (Si as alloy element — silicon cross-link) |
| Ti CP grade 2 | hcp α | metallic | 1941 | 4.51 | corrosion, medical |
| Ti-6Al-4V | α + β | metallic | 1933 | 4.42 | aerospace, biomedical |
| Mg AZ31 | hcp | metallic | 905 | 1.77 | lightweight structural |
| Inconel 718 (Ni-base superalloy) | fcc γ + γ' / γ" precip | metallic + ordered intermetallic | ~1573 | 8.19 | turbine disk |
| CMSX-10 (single-crystal Ni-base SX) | fcc γ + 60-70% γ' | metallic + ordered | ~1543 | 9.05 | turbine blade |
| Mar-M 247 (Co-base) | fcc γ + carbides | metallic | ~1633 | 8.55 | turbine vane |
| W (refractory) | bcc | metallic | 3695 | 19.30 | filament, electrode |
| Re | hcp | metallic | 3459 | 21.02 | superalloy additive |
| Os | hcp | metallic | 3306 | 22.59 | densest stable element (L6 HARD) |
| Ta₄HfC₅ (refractory carbide) | various | covalent + metallic | 4215 (L5 HARD) | ~14 | refractory ceramic-metal boundary |
| NdFeB (N52) | tetragonal (Nd₂Fe₁₄B) | metallic + ordered | ~1583 | 7.55 | hard magnet 52 MGOe |
| SmCo₅ | hexagonal | metallic + ordered | ~1373 | 8.40 | hard magnet (high T_c) |
| Fe-3% Si GO (grain-oriented) | bcc | metallic | ~1773 | 7.65 | electrical steel (transformer) |
| Metglas 2705M (Fe-Si-B amorphous) | amorphous | metallic | n/a | 7.30 | soft magnet, transformer |
| Finemet (FeCuNbSiB nanocrystal) | nanocrystalline | metallic | n/a | 7.30 | soft magnet, EMI |

## §3 Real-limit map (from `LIMIT_BREAKTHROUGH.md`)

| # | Limit | Class | Value | Verb |
|---|-------|-------|-------|------|
| L5 | Melting point ceiling | HARD | 4215 K (Ta₄HfC₅) | metallurgy (refractory + carbide boundary) |
| L6 | Density ceiling (stable matter) | HARD | 22.59 g/cm³ (Os) | metallurgy |
| L9 | Thermal conductivity (electron + phonon) | SOFT | Cu 401 W/m·K, Ag 429 W/m·K | metallurgy |

Refractory metals (W 3695 K, Re 3459 K, Ta 3290 K, Os 3306 K, Mo 2896 K)
approach L5 from the elemental side. Refractory carbides (TaC, HfC, Ta₄HfC₅)
reach L5 via covalent bond character — they are CER-MET boundary objects.

## §4 Processing routes (MET)

| Route | Forward | Verb |
|-------|---------|------|
| Casting (sand, investment, die) | molten metal → mold → solidified part | metallurgy |
| Forging (open, closed-die, isothermal) | hot metal billet → die press | metallurgy |
| Rolling (hot, cold) | ingot → plate/sheet/strip | metallurgy |
| Drawing (wire, tube) | rod → thinner wire/tube | metallurgy |
| Heat treatment | quench + temper, anneal, normalize, age | metallurgy, superalloy |
| TTT diagram operation | austenite → martensite (fast quench) / bainite (medium) / pearlite (slow) | metallurgy |
| Vacuum induction melting (VIM) | high-purity Ni superalloy ingot | superalloy |
| Vacuum arc remelting (VAR) | refine VIM ingot for fatigue grade | superalloy |
| Electroslag remelting (ESR) | similar refining | superalloy |
| Directional solidification (DS) | columnar grain alignment along [001] | superalloy |
| Single-crystal pull | seed-pull single crystal turbine blade | superalloy (CMSX-10, Rene N6) |
| Powder bed AM (DMLS, SLM, EBM) | metal powder → laser/electron beam → part | metallurgy (cross to PRC) |
| Spark plasma sintering | pressure + DC pulse, fast densification | metallurgy, superalloy |
| Sintering (PM) | metal powder → die-compact → sinter | metallurgy |
| Strip-cast / melt-spinning | amorphous ribbon (Metglas) | magnetic-materials |
| Hot-deformed magnet press | NdFeB anisotropic magnet | magnetic-materials |

## §5 Superalloy strengthening mechanisms (Phase D spotlight)

Per `superalloy/superalloy.md`, Ni-base superalloys derive high-T strength
from four mechanisms operating simultaneously:

1. **Solid-solution strengthening** — Co, Cr, W, Mo, Re dissolved in γ (fcc Ni)
   matrix. Re (3-6 wt% in 4th-gen) is the strongest solute against creep.
2. **γ' precipitation** — Ni₃(Al,Ti) L1₂ ordered phase, coherent with γ.
   Volume fraction 60-70% in single-crystal blades. Aging temperature
   ~1100 °C.
3. **Grain-boundary strengthening** — B, C, Zr at grain boundaries +
   carbide pinning (M₂₃C₆, MC). For SX blade: NO grain boundaries (single
   crystal eliminates GB creep failure).
4. **Solid-solution + γ' interaction (rafting)** — under stress + T, γ'
   precipitates "raft" perpendicular to applied stress — provides
   high-T creep resistance.

Re-bearing (4-6 wt%): CMSX-10, Rene N6, EPM-102. Re-free attempts: T-3,
CMSX-7 — at-parity claim **UNVERIFIED** (preserved verbatim).

## §6 Magnetic materials (Phase D spotlight)

Per `magnetic-materials/magnetic-materials.md`:

| Class | Example | (BH)_max (MGOe) | T_c (K) | Application |
|-------|---------|-----------------|---------|-------------|
| NdFeB (sintered) | Nd₂Fe₁₄B (N52) | 50-52 | 583 | EV motor, wind turbine, HDD |
| NdFeB (bonded) | Nd₂Fe₁₄B with Dy / Tb | 5-15 | varies | small motor |
| SmCo₅ | SmCo₅ | 16-25 | 1023 | high-T, aerospace |
| Sm₂Co₁₇ | Sm₂Co₁₇ | 25-32 | 1100 | high-T |
| Alnico | Al-Ni-Co-Fe | 5-9 | 1163 | guitar pickup, sensor |
| Ferrite (hard) | BaFe₁₂O₁₉ / SrFe₁₂O₁₉ | 3-5 | 723 | low-cost magnet |
| Soft ferrite | Mn-Zn, Ni-Zn | n/a (B_sat 0.4-0.5 T) | varies | inductor, transformer |
| Fe-3% Si GO | electrical steel | n/a (B_sat 2.0 T) | n/a | transformer (50/60 Hz) |
| Metglas 2605SA1 | Fe-Si-B amorphous | n/a (B_sat 1.56 T) | n/a | distribution transformer (low loss) |
| Finemet FT-3 | FeCuNbSiB nanocrystal | n/a (B_sat 1.23 T) | n/a | high-freq inductor |

Rare-earth-free > 35 MGOe **UNVERIFIED**. Tetrataenite (L1₀-FeNi), MnBi,
Fe₁₆N₂ are R&D candidates only — preserved verbatim.

## §7 Cross-group interfaces

### §7.1 MET ↔ CER

- Silicide phases: Fe₃Si, FeSi₂, β-Fe₂Si (covalent), MoSi₂, WSi₂. Live at
  the metal-ceramic boundary.
- Refractory carbides: WC (tool), TaC, HfC, Ta₄HfC₅ (L5 HARD wall).
- Ceramic coatings: TBC (thermal barrier coating, YSZ on Ni superalloy
  blade) — at hexa-metal ↔ hexa-ceramic interface.

### §7.2 MET ↔ POL

- Adhesive-bonded metal joint: Henkel/3M/Loctite epoxy / structural acrylic.
- Rubber-bonded metal: engine mount (NR or NR-IR blend).
- Conformal coating: polyimide (Kapton) over PCB metal traces.

### §7.3 MET ↔ FIB

Negligible. Steel rebar in reinforced concrete is structural, not "fiber"
in the FIB sense. Wire-strand cable (cable-stayed bridge) is fiber-like
in form-factor but MET in chemistry.

### §7.4 MET ↔ PRC

Casting, forging, rolling, heat-treatment, PM, AM all live in `synthesis/`
and `MATERIAL-SYNTHESIS.md`.

### §7.5 MET ↔ GEM

Gold/platinum/palladium/rhodium for jewelry mountings. Metal chemistry
+ gem application = boundary verb (lives in `gemology/` mounting context).

## §8 Lutherie cross-link (culture overlap)

`lutherie/` covers string-alloy materials:
- Steel string (high carbon 0.78-0.95% C, wire-drawn)
- Bronze-wound string (80/20 bronze, 90/10 phosphor bronze)
- Brass for bell, gong, cymbal (Zildjian B20 = 80% Cu / 20% Sn)
- Nickel-silver wound string (no-Ag, Cu-Ni-Zn)

This is fundamentally a metallurgy sub-verb but lives in `lutherie/` because
the *acoustic* application is culture-domain. Phase C does not merge it back —
it sits as cross-link from `hexa-metal/`.

---

*Phase C metal architecture overview, authored 2026-05-13.*
