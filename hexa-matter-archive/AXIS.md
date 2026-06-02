# AXIS — hexa-matter 7-group material taxonomy

> **Created**: 2026-05-13 (Phase A elevation, post-silicon close at 17/17 + 4/4)
> **Updated**: 2026-05-13 (Phase D, 29/29 + 4/4 — 12 new verbs added across CER/POL/FIB/MET)
> **Updated**: 2026-05-13 (Phase D follow-on, 33/33 + 4/4 — 4 new verbs: glass-ceramic, geopolymer, aerogel-foam (CER) + ionic-liquid (POL))
> **Updated**: 2026-05-13 (Phase D'', 36/36 + 4/4 — 3 new verbs: refractory + electrode-material (CER) + photoresist (POL))
> **Status**: infrastructure doc · groups material verbs into the 7-group lattice
> **Sibling**: `AXIS_CLOSURE_PLAN.md` (per-group closure roadmap with (a)/(b)/(c) categories)
> **Companion**: `LIMIT_BREAKTHROUGH.md` (Wave M real-limits audit)
>
> into 7 material groups. The n=6 invariant lattice is **auxiliary** here —
> the real grouping criteria are bond character, processing route, and
> end-product class (ASM/Ashby/MatWeb tradition). Per `LATTICE_POLICY.md
> §1.3`, lattice-arithmetic identities are auxiliary self-consistency
> only; they do NOT define the group boundaries.

---

## §0 The 7 groups (one-line each, post Phase D'')

| # | Group ID  | Verbs                                                     | Bond class            | Processing axis        |
|---|-----------|-----------------------------------------------------------|-----------------------|------------------------|
| 1 | GROUP_CER | ceramics · concrete · concrete_tech · glass · silicon · compound-semi · perovskite · 2d-materials · mof · carbon · glass-ceramic · geopolymer · aerogel-foam · **refractory · electrode-material** | Ionic + covalent + vdW | High-T sintering / sol-gel / CVD / CZ-FZ pull / exfoliation / supercritical drying / alkali-activation / co-precipitation+calcine |
| 2 | GROUP_POL | aramid · epoxy · nylon · pet_film · tire_cord · microplastics · elastomer · adhesive · liquid-crystal · biodegradable-plastics · ionic-liquid · **photoresist** | Covalent C-C / amide / ester / urea / ionic-organic / acid-labile-protected | Polymerization (step / chain) / quaternization / photochemical-amplification |
| 3 | GROUP_FIB | fabric · paper · **wood-cellulose**                        | Covalent + H-bond     | Spinning / weaving / pulping |
| 4 | GROUP_MET | metallurgy · lutherie · **superalloy · magnetic-materials** | Metallic              | Casting / forging / heat-treatment |
| 5 | GROUP_GEM | gemology                                                  | Ionic + covalent      | Crystal habit / cut / polish |
| 6 | GROUP_PRC | synthesis · recycling · recycle_n6 · printing             | (any)                 | Process-and-reverse routes |
| 7 | GROUP_FAS | fashion-textile · textile-dyeing                          | Covalent + dye-substrate | Wet-process / dye-uptake |

**Phase D (2026-05-13) verb expansion** (12 new verbs):
- CER +5: compound-semi, perovskite, 2d-materials, mof, carbon
- POL +4: elastomer, adhesive, liquid-crystal, biodegradable-plastics
- FIB +1: wood-cellulose
- MET +2: superalloy, magnetic-materials

**Phase D follow-on (2026-05-13) verb expansion** (4 new verbs, 29→33):
- CER +3: glass-ceramic (controlled-crystallization), geopolymer
  (alkali-activated aluminosilicate, low-CO₂ cement alternative),
  aerogel-foam (silica/carbon/polymer/graphene aerogel)
- POL +1: ionic-liquid (room-T molten salts; placed in POL as
  organic/soft-matter extension though formally not a polymer —
  spec §1 preserves the distinction including DES separation)

**Phase D'' (2026-05-13) verb expansion** (3 new verbs, 33→36):
- CER +2: refractory (high-T ≥ 1000 °C service materials —
  firebrick/Al₂O₃/MgO/ZrO₂/mag-C/SiC/carbon; distinct from `ceramics/`
  which is general advanced ceramics; this verb owns the high-T-service
  envelope discipline), electrode-material (battery cathode/anode +
  electrocatalyst — LFP/NMC/Si-anode/Li-metal/Pt-ORR/IrO₂-OER; material
  layer only — cell engineering belongs to hexa-energy per
  CROSS_LINK §3.3)
- POL +1: photoresist (lithography photopolymer chemistry —
  g/i-line DNQ-novolac / KrF CAR / ArF CAR / EUV CAR + MOR; material
  layer only — lithography process belongs to hexa-chip per
  CROSS_LINK §3.2)

**Verb count audit (post Phase D'')**: CER(15) + POL(12) + FIB(3) + MET(4 incl. lutherie) + GEM(1) + PRC(4) + FAS(2) = **41 verb-slots**, but the **36 ship-grade dispatchable verbs** map as follows:

- CER: ceramics, concrete, concrete_tech, glass, silicon, compound-semi, perovskite, 2d-materials, mof, carbon, glass-ceramic, geopolymer, aerogel-foam, refractory, electrode-material → **15**
- POL: aramid, epoxy, nylon, pet_film, tire_cord, elastomer, adhesive, liquid-crystal, biodegradable-plastics, ionic-liquid, photoresist → **11**
- FIB: fabric, paper, wood-cellulose → **3**
- MET: metallurgy, superalloy, magnetic-materials → **3** (lutherie not in CLI dispatch; sits in culture overlap)
- GEM: gemology → **1**
- PRC: synthesis, recycle_n6, recycling → **3** (printing exposed via MATERIAL-SYNTHESIS.md; no dispatcher slot yet)
- FAS: fashion-textile, textile-dyeing → not in 36-verb CLI dispatch (industrial-textile lineage separately tracked)

That gives **36 dispatchable verbs** in `hexa.toml [verbs]`:
- ceramic_inorganic (15), polymer (11), fiber_paper (3), gem_mineral (1), metal (3), synthesis (1), recycle (2) = 36

The 17 ship-grade verbs of v1.0.0 + 12 Phase D verbs + 4 Phase D follow-on verbs + 3 Phase D'' verbs = 36 verbs total. `hexa.toml [verbs]` is the authoritative scoreboard. The 7 groups are unchanged in count (no new group added; CER continues to absorb hybrid silicate / nanoporous / amorphous-network / refractory / battery-cathode-oxide materials).

---

## §1 GROUP_CER — ceramic / inorganic / silicate

**Verbs**: ceramics, concrete, concrete_tech, glass, **silicon** (just added 2026-05-13).

**Bond character**: ionic + covalent (CaO·SiO₂ in cement, SiO₂ in glass / fused silica, SiC / Si₃N₄ in advanced ceramics, elemental Si in poly/mono wafer).

**Why this is the "spine"**: 4 of the 17 verbs sit here (ceramics, concrete, concrete_tech, glass). Adding silicon on 2026-05-13 brought this group to **5**, making it the densest single group in the substrate. The reason is structural: silicate chemistry is the connective tissue between (a) construction materials (concrete = aluminosilicate hydrate), (b) optical/electronic materials (glass = vitreous SiO₂), (c) ceramic engineering (Si₃N₄ turbine blade, SiC armor), and (d) the semiconductor material layer (poly-Si feedstock, mono-Si wafer). Every one of those routes starts from SiO₂-bearing precursors.

**Real limits anchored** (from `LIMIT_BREAKTHROUGH.md`):
- L4 Mohs ceiling 10 (diamond) — applies to gem/ceramic boundary
- L5 melting point ceiling 4215 K (Ta₄HfC₅ alloy) — covalent-bond-energy hard wall
- L7 glass T_g (~1473 K for fused silica) — soft-wall, compositional
- L8 concrete compressive strength 30 MPa ord. → 800 MPa UHPC → 2 GPa theoretical
- **Si-L1..Si-L12** (silicon-specific) — 9N purity ceiling, 600 mm CZ crucible, 200 mm FZ rod, 1687 K T_m, 2.329 g/cm³, 1.12 eV bandgap, etc. (see SILICON.md)

**Cross-link rule**: chip-grade semiconductor *device + fab process* (lithography, EUV resist, transistor architecture) lives in `hexa-chip`. silicon HERE = material aspect only.

---

## §2 GROUP_POL — polymer

**Verbs**: aramid, epoxy, nylon, pet_film, microplastics (+ tire_cord as downstream).

**Bond character**: covalent backbone, with linkage-class diversity — amide (nylon, aramid), ester (PET), epoxide (epoxy), C-C (PE/PP via microplastics chapter).

**Why grouped**: same processing axis (step- vs chain-growth polymerization) and same dominant failure modes (chain scission, hydrolytic degradation, photo-oxidation, glass transition). The 5 verbs span the full polymer-engineering tradition:

| Verb | Linkage | T_g (K) | T_m (K) | Industrial signature |
|------|---------|---------|---------|----------------------|
| aramid (PPTA) | aromatic amide | — (no T_g, decomp ~770 K) | decomp | Kevlar 49 σ ≈ 3.6 GPa, ballistic |
| nylon-6,6 | aliphatic amide | 323 | 538 | tire-cord, textile, gear |
| pet_film | ester | 343 | 533 | packaging, MRI tape |
| epoxy | epoxide cross-link | 393–473 | (thermoset, no T_m) | adhesive, composite matrix |
| microplastics | mixed | (varies) | (varies) | environmental fate, partition |

**Real limits anchored**:
- L1 Frenkel σ_th = E/10 → polymer cap ~30 GPa for ideal CNT yarn; aramid lab ~5 GPa, theoretical CNT ~150 GPa
- L2 practical tensile strength SOFT_WALL → polymer fiber assembly frontier
- L12 entropy of mixing → polymer recycling HARD floor (`recycle_n6` + `recycling` verbs reference this)

**Microplastics** (added 2026-05-13 via the hexa-medic absorption) is the *environmental* polymer verb — it does not represent a new bond class but rather a downstream-fate axis (size partition, leaching, biofilm colonization).

---

## §3 GROUP_FIB — fiber + paper

**Verbs**: fabric, paper.

**Bond character**: covalent backbone (cellulose, lignin in paper; PET / cotton / aramid / wool / silk in fabric) + extensive intra- and inter-fiber H-bonding (cellulose: -OH···O=; aramid: -CO···HN-).

**Why a separate group from POL**: the *organization* level matters. POL covers the chain/network; FIB covers the **assembly into 1D filament → 2D fabric → 3D structure**. Same chemistry, different abstraction.

This group will likely expand in Phase D — natural-fiber subverbs (cotton, wool, silk, jute, hemp, ramie, kenaf) are roadmap stubs but not yet verbs.

---

## §4 GROUP_MET — metal

**Verbs**: metallurgy, lutherie.

**Bond character**: metallic (electron sea + ion cores).

**Why include lutherie**: instrument craft (luthier work on stringed instruments) is metallurgy-adjacent because the *sound-bearing components* (string alloys, bell brass, gong bronze, valve materials) are alloy-engineering — the `LUTHERIE.md` chapter and `SWORDSMITHING.md` (the upstream-canon-anchored metallurgy spec) overlap heavily on alloy phase diagrams.

**Real limits anchored**:
- L5 melting point ceiling (refractory metals: W 3695 K, Re 3459 K)
- L6 density ceiling 22.59 g/cm³ (Os) — HARD wall on stable matter
- L9 thermal conductivity (Cu 401, Ag 429 W/m·K) — phonon + electron hybrid

**Future expansion** (Phase D): superalloy (Ni-based Inconel, single-crystal turbine blade casting, Ti-6Al-4V, austenite-martensite-bainite TTT diagrams) — see `METALLURGY-DEEP.md` for the planned chapter.

---

## §5 GROUP_GEM — gem / mineral

**Verbs**: gemology.

**Bond character**: ionic + covalent (corundum Al₂O₃, beryl Be₃Al₂Si₆O₁₈, garnet group, diamond C).

**Why a separate group from CER**: the *application axis* is different — gemology is **non-destructive characterization** (refractive index, dispersion, dichroism, inclusions, fluorescence) rather than processing. The same Al₂O₃ that lives in a corundum gem also lives in alumina ceramic; the verb separation is about which face of the material you care about.

**Real limit**: Mohs 10 = diamond is the practical hardness HARD wall (L4 in LIMIT_BREAKTHROUGH.md). Lonsdaleite + w-BN (calculated 150 / 85 GPa Vickers) remain non-synthesized in bulk despite 60+ years of attempts.

---

## §6 GROUP_PRC — process

**Verbs**: synthesis, recycling, recycle_n6, printing.

**Bond character**: (any) — this group is defined by **process** not chemistry.

| Verb | Process axis | Forward / reverse |
|------|-------------|---------------------|
| synthesis | high-T solid-state, hydrothermal, sol-gel, CVD | forward (build) |
| recycling | mechanical / chemical / dissolution | reverse (un-build) |
| recycle_n6 | thermodynamic accounting of recycle loops | reverse (un-build, with entropy bookkeeping) |
| printing | additive manufacturing (FDM, SLS, SLA, DLP, MJF, binder-jet) | forward (build) |

**Real limits anchored**:
- L11 Kepler packing 0.7405 (Hales 2017) — limits powder-bed printing density and casting yield
- L12 entropy of mixing → recycling Gibbs floor (HARD wall on separation energy)

This group is where the *material flow* (extraction → product → end-of-life → re-extraction) is bookkept. The `MATERIAL-SYNTHESIS.md` chapter is the largest root .md in the repo by line count (1083 kLoC region of text) because it absorbed the entire upstream `canon/domains/materials/synthesis/` tree.

---

## §7 GROUP_FAS — fashion / textile

**Verbs**: fashion-textile, textile-dyeing.

**Bond character**: covalent fiber backbone + dye-substrate interactions (reactive dye covalent bond, direct dye Van der Waals + H-bond, vat dye redox-cycle).

**Why a separate group from FIB**: the *value-add axis* is different — FAS covers the **industrial-textile and dyeing** lineage (the part where chemistry meets supply chain and fashion economics). FIB covers the structural fiber/paper assembly. Both groups touch fabric, but FAS is the wet-process and dye-uptake side, FIB is the dry-mechanical side.

Phase D candidates: pigment chemistry, mordant-dyeing, natural-dye revival, indigo fermentation crossover into the bio domain.

---

## §8 The cross-link case study — silicon

**Silicon is the first verb in hexa-matter that explicitly cross-links 3 groups**:

| Group | Si's contribution | Cross-link target |
|-------|-------------------|---------------------|
| GROUP_CER | poly-Si feedstock (Siemens process), mono-Si wafer (CZ/FZ), SiO₂ → fused silica → glass, SiC / SiN / Si₃N₄ ceramics | ceramics, glass |
| GROUP_MET | Si as alloy element (Al-Si casting alloy, Fe-Si electrical steel, Cu-Si bronze) | metallurgy |
| GROUP_PRC | Si as the synthesis-platform substrate for the entire semiconductor industry (Siemens, FBR, FZ, CZ, epitaxy) | synthesis |

The reason silicon was the **17th** rather than the 5th verb is that for most of v1.0.0's gestation, silicon was assumed to live entirely in `hexa-chip`. The 2026-05-13 audit (LIMIT_BREAKTHROUGH Wave M follow-up) surfaced that the *material layer* of Si — purity ceiling, ingot dimension, vendor tonnage, SiO₂ cross-link to glass, SiC cross-link to ceramics — has no natural home in the chip-design substrate. So it was added here.


- `hexa-chip` owns the device + fab process (lithography, transistor, EUV resist, fab capacity)
- `hexa-matter/silicon/` owns the material aspect (purity grades, dimensional ceilings, vendor tonnage, SiO₂/SiC/SiN cross-links)
- the line is enforced by `hexa.toml [crosslink].chip` pointer + `silicon/silicon.md` §7 explicit boundary statement

---

## §9 Auxiliary lattice arithmetic (per LATTICE_POLICY §1.3)

> **HONEST**: the lattice identities below are AUXILIARY self-consistency only.
> They do NOT define group boundaries. The real boundaries are bond character +
> processing route (ASM/Ashby tradition).

n=6 substrate invariants:
- σ(6) = 1+2+3+6 = **12** (sum of divisors)
- τ(6) = 4 (number of divisors: 1, 2, 3, 6)
- φ(6) = 2 (Euler totient: {1, 5} coprime to 6)
- J₂(6) = 24 (Jordan totient: |S_4| = 4! = 24)

Master identity: σ·φ = 12·2 = 24 = 6·4 = n·τ ✓

**How this surfaces in hexa-matter**:
- 7 groups (we use 7, not 6) — *intentional* mismatch; the lattice is auxiliary, real engineering wins
- 29 verbs post-Phase-D (not 24, not 36) — same; we ship what the engineering taxonomy demands
- `verify/lattice_arithmetic.hexa` checks σ·φ = n·τ as an arithmetic sanity gate; it does NOT certify any verb count

Per `LATTICE_POLICY.md §1.2`, the substrate's REAL ceilings live in `LIMIT_BREAKTHROUGH.md` (NIST WebBook · CRC Handbook · ASM Handbook · Ashby · Hales · Frenkel · Stefan-Boltzmann). The lattice is permitted as a *tool* — never as a *constraint*.

---

## §10 What "axis" means in hexa-matter vs hexa-bio

Sibling-repo `hexa-bio` uses "5-axis" to mean a small, structurally-locked set (QUANTUM / WEAVE / NANOBOT / RIBOZYME / VIROCAPSID; count locked per `.roadmap.axis_expansion_decision_2026_05_08`).

hexa-matter uses **"7-group"** for a more relaxed taxonomic clustering. The difference is intentional:

- hexa-bio axes are *theory commitments* (a Bayesian audit pins σ(6)=12 to each axis)
- hexa-matter groups are *engineering clusters* (bond class + processing route + product class)

We do not run Bayesian σ-match audits on the 7 groups. Material parameters (T_m, ρ, σ_th, Vickers, T_g) are pulled from NIST / CRC / ASM directly — that's the real anchor.

---

## §11 Phase B-G preview (queued, NOT in this Phase A doc set)

- **Phase C** — per-group depth dirs (`silicon/`, `microplastics/` already exist; phase C adds `superalloy/`, `2d-materials/`, etc.)
- **Phase D** — new verbs: elastomer, compound-semi (GaN, SiC, GaAs full chapter), perovskite, 2D-materials, adhesive, magnetic-materials, MOF, liquid-crystal, biodegradable-plastics, wood-cellulose
- **Phase E** — Python bridge `_python_bridge/module/` (Hales-anchored packing calculator, Frenkel-anchored σ_th calculator)
- **Phase F** — research bridge to live databases (MatWeb, NIST SRD, ASTM, SEMI)
- **Phase G** — AlphaFold-class absorption: parameter prediction at material scale (CALPHAD-class thermodynamic assessment, MatBench / Materials Project integration)

Phase A (this commit) is **infrastructure docs only** — no new verbs, no new code, no new bridges.

---

## §12 Self-evaluation — honest mode

### What this AXIS.md does well
- Real boundary criteria (bond class + processing) are named explicitly
- The lattice is declared auxiliary up-front (per LATTICE_POLICY)
- The 7-group taxonomy maps cleanly onto the 17 verbs without forcing a 6 or 24
- The silicon cross-link case is documented (CER ∩ MET ∩ PRC)

### Weaknesses
1. **GROUP_FAS vs GROUP_FIB boundary is squishy.** Both touch fabric. We separated on the wet-process / dry-mechanical axis but there is leakage (e.g., textile finishing is wet but mechanical).
2. **printing** is in GROUP_PRC but has no root .md yet. It is a verb-slot held by `synthesis` + the upcoming Phase C `printing/` dir.
3. **No quantitative test** distinguishes "group" from "cluster" yet — we rely on ASM/Ashby tradition. A clustering metric (e.g., bond-class entropy + processing-route Hamming distance) would harden the taxonomy.
4. **Lutherie** sits half in MET and half in the culture domain. This will get worse as the culture domain matures; we may move lutherie to a future `hexa-craft` or similar.

### What the hexa-bio reference taught us
- The Bayesian axis-match audit machinery (n=30/n=60 corpus, log_BF decisive) does not natively apply here — material parameters are *real*, measurable, anchored. We do not need σ-match; we need NIST/CRC/ASM citation discipline. That's what `LIMIT_BREAKTHROUGH.md` does.
- The (a)/(b)/(c) closure-category framework DOES apply — see `AXIS_CLOSURE_PLAN.md`.

---

*Document authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as part of the Phase A elevation of hexa-matter to hexa-bio architectural maturity. No claim of n=6 lattice anchoring on any material parameter (per LATTICE_POLICY §1.2).*
