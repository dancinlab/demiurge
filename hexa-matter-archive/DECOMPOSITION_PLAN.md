# DECOMPOSITION_PLAN — hexa-matter material taxonomy decomposition

> **Created**: 2026-05-13 (Phase A elevation) · **Status**: Phase D IMPLEMENTED 2026-05-13
> **Sibling**: `AXIS.md` (7-group taxonomy) · `AXIS_CLOSURE_PLAN.md` (per-group closure)
>
> This document lays out how the 7 material groups decompose into the
> 17 v1.0.0 verbs and the 12 Phase D verbs (now **landed 2026-05-13**,
> bringing total to **29 verbs**). Phase B (selftest), C (depth dirs)
> remain queued; Phase D moved from PROPOSAL to IMPLEMENTED in this commit.

---

## §0 Decomposition strategy — why this and not alternatives

Materials science has at least 4 well-established taxonomies. We evaluated each before committing to the 7-group form:

| Taxonomy | Origin | Verb count if applied | Why we did or didn't adopt |
|----------|--------|------------------------|----------------------------|
| **Ashby material selection chart** | Ashby 1992; *Materials Selection in Mechanical Design* 5th ed. (2017) | ~6 super-classes (metals, polymers, ceramics, composites, natural, hybrid) | Adopted in spirit — our 7 groups overlap heavily with Ashby's 6, plus our split of CER vs GEM and FIB vs FAS. |
| **MatWeb taxonomy** | matweb.com industrial database | ~50 base classes (alloy steel, brass, glass-ceramic, etc.) | Too granular for v1.x scope. Phase F (research bridge) will likely consume MatWeb directly. |
| **CALPHAD thermodynamic** | Kaufman & Bernstein 1970; FactSage / Thermo-Calc | ~thousands of phase diagrams | Phase G (AlphaFold-class absorption) candidate; far beyond v1.x. |
| **ASM Handbook 23-volume** | ASM International | 23 volumes by application | Our verb names sometimes mirror ASM (`metallurgy.md` ≈ ASM vol. 1, `ceramics.md` ≈ vol. 21) but we cluster more aggressively. |

**What we picked**: a 7-group lattice that is *Ashby-like at the top level* (bond class + processing route) but with two engineering-driven splits:

1. **CER vs GEM split**: same chemistry (ionic + covalent), different application — CER is processed/sintered/grown, GEM is characterized non-destructively. Both touch corundum / silicate / diamond.
2. **FIB vs FAS split**: same fiber chemistry, different value-add axis — FIB is the dry-mechanical assembly (fabric, paper), FAS is the wet-process + dye-uptake side (industrial textile, dyeing).

Plus one bookkeeping group:

3. **PRC** (process) as orthogonal to the chemistry-based groups — synthesis, recycling, printing are processes that touch any chemistry; they earn their own group rather than being scattered.

---

## §1 Material hierarchy — element → product

The verb decomposition follows the standard materials-science hierarchy:

```
element                    silicon (Si), carbon (C), aluminum (Al), copper (Cu), iron (Fe)
   ↓
compound                   SiO₂, SiC, Si₃N₄, Al₂O₃, Fe₂O₃, CaSO₄
   ↓
mixture                    cement (CaO + SiO₂ + Al₂O₃ + Fe₂O₃ + SO₃ ...),
                           glass (SiO₂ + Na₂O + CaO), bronze (Cu + Sn)
   ↓
composite                  Kevlar/epoxy (aramid + epoxy), UHPC (cement + fiber + silica fume),
                           CFRP (carbon fiber + epoxy), TBC (ZrO₂ + Y₂O₃ on Ni superalloy)
   ↓
product                    tire-cord (aramid in nylon-rubber matrix), turbine blade
                           (Ni superalloy + TBC + cooling channels), PET film,
                           5G ceramic capacitor, Czochralski-pulled mono-Si wafer
```

Each of the 17 verbs sits somewhere on this ladder:

| Verb | Hierarchy level | One-line essence |
|------|------------------|------------------|
| silicon | element + compound | elemental Si (poly/mono) + SiO₂/SiC/SiN compounds + Si-O polymer (silicone) |
| ceramics | compound + mixture | sintered oxide/nitride/carbide ceramics |
| glass | mixture | vitreous SiO₂ + alkali/alkaline-earth modifier |
| concrete | mixture | cement (mixture) + aggregate + water |
| concrete_tech | composite | UHPC + fiber-reinforced + reactive powder |
| aramid | compound + product | PPTA polymer + Kevlar fiber product |
| nylon | compound + product | polyamide (nylon-6,6 / nylon-6) + fiber/resin product |
| pet_film | compound + product | PET polymer film |
| epoxy | compound | DGEBA + cross-linker resin system |
| tire_cord | composite + product | aramid/nylon in tire rubber matrix |
| microplastics | mixture | environmental fate of mixed polymer fragments |
| fabric | composite | woven/knitted/non-woven fiber assembly |
| paper | composite | cellulose pulp + filler + sizing |
| gemology | compound | mineral characterization (corundum, beryl, diamond, garnet) |
| metallurgy | element + compound + mixture | alloys, phase diagrams, heat treatment |
| lutherie | composite + product | alloy + wood + craft product (instrument) |
| synthesis | process | forward route — element → compound → mixture |
| recycle_n6 | process | reverse + n=6 lattice accounting |
| recycling | process | reverse route — product → compound → element |
| fashion-textile | composite + product | textile supply chain |
| textile-dyeing | process | wet-process dye uptake on fiber substrate |

---

## §2 The 17 verbs decompose into 7 groups (current state)

Per `AXIS.md §0`:

```
GROUP_CER (5): ceramics, concrete, concrete_tech, glass, silicon
GROUP_POL (5): aramid, epoxy, nylon, pet_film, microplastics  (tire_cord = downstream)
GROUP_FIB (2): fabric, paper
GROUP_MET (2): metallurgy, lutherie
GROUP_GEM (1): gemology
GROUP_PRC (3): synthesis, recycle_n6, recycling  (printing = future verb, currently inside synthesis)
GROUP_FAS (2): fashion-textile, textile-dyeing
```

**Why this exact mapping** (not some other clustering):
- **CER is densest** because silicate chemistry is the connective tissue from construction (concrete) through optics (glass) to semiconductors (silicon).
- **POL is second-densest** because the linkage-class diversity (amide, ester, epoxide, urea) is largest in the synthetic-polymer family.
- **MET is small (2)** because v1.x covers steel/alloy fundamentals via `metallurgy.md` (anchored on SWORDSMITHING.md upstream) — Phase D will expand to superalloy, refractory metal, light alloy as separate verbs.
- **GEM is single (1)** because the gemology spec covers all gem species in one chapter — Phase D may not need to expand.

---

## §3 Phase D — 12 new verbs **IMPLEMENTED 2026-05-13**

These are the Phase D verbs **now landed** (17 + 12 = **29 verbs**). Each spec lives at `<verb>/<verb>.md` and follows the silicon.md real-limits-first template (~ 250–310 lines per spec).

### §3.1 GROUP_CER expansion (Phase D — IMPLEMENTED)

| Verb | Why | Status |
|------|-----|--------|
| compound-semi | GaN, SiC (material side), GaAs, InP, AlN — wide-bandgap cluster | ✅ IMPLEMENTED `compound-semi/compound-semi.md` |
| perovskite | ABX₃ structure family (BaTiO₃, PZT, MAPbI₃ solar); LK-99 HARD_WALL UNPROVEN preserved | ✅ IMPLEMENTED `perovskite/perovskite.md` |
| 2d-materials | non-carbon 2D (MoS₂, WSe₂, h-BN, phosphorene, MXene); carbon 2D in `carbon/` | ✅ IMPLEMENTED `2d-materials/2d-materials.md` |
| mof | metal-organic frameworks (HKUST-1, ZIF-8, MOF-74, UiO-66, MIL-101, MOF-210); DAC economics UNPROVEN | ✅ IMPLEMENTED `mof/mof.md` |
| carbon | activated C, glassy C, pyrolytic graphite, carbon fiber, CNT, diamond, fullerene; graphene depth in GRAPHENE-CARBON.md | ✅ IMPLEMENTED `carbon/carbon.md` |

### §3.2 GROUP_POL expansion (Phase D — IMPLEMENTED)

| Verb | Why | Status |
|------|-----|--------|
| elastomer | NR, SBR, EPDM, NBR, silicone (VMQ), FKM/FFKM, TPU | ✅ IMPLEMENTED `elastomer/elastomer.md` |
| adhesive | PSA, structural (epoxy, PU), cyanoacrylate, anaerobic, hot-melt, silicone RTV; aerospace film (AF-555M) | ✅ IMPLEMENTED `adhesive/adhesive.md` |
| liquid-crystal | nematic + smectic + cholesteric + LCP (Vectran, PPTA dope); LCD/SLM scope | ✅ IMPLEMENTED `liquid-crystal/liquid-crystal.md` |
| biodegradable-plastics | PLA, PHA, PBS, PCL, starch blends, cellulose acetate; marine-biodegradable UNVERIFIED | ✅ IMPLEMENTED `biodegradable-plastics/biodegradable-plastics.md` |

### §3.3 GROUP_FIB expansion (Phase D — IMPLEMENTED)

| Verb | Why | Status |
|------|-----|--------|
| wood-cellulose | engineered wood (CLT, glulam, LVL), nanocellulose (CNC, CNF), regenerated cellulose, cellulose acetate | ✅ IMPLEMENTED `wood-cellulose/wood-cellulose.md` |

### §3.4 GROUP_MET expansion (Phase D — IMPLEMENTED)

| Verb | Why | Status |
|------|-----|--------|
| superalloy | Ni-based Inconel 718 / René / CMSX, Co-based Haynes, single-crystal turbine blade, TBC cross-link | ✅ IMPLEMENTED `superalloy/superalloy.md` |
| magnetic-materials | NdFeB / SmCo / AlNiCo / ferrite hard magnets + Si-Fe / permalloy / Metglas / Finemet soft magnets | ✅ IMPLEMENTED `magnetic-materials/magnetic-materials.md` |

### §3.5 GROUP_GEM expansion (Phase D)

(no new verbs landed; gemology covers the gem family. Single-crystal lab-grown diamond cross-links to `carbon/carbon.md`.)

### §3.6 GROUP_PRC expansion (Phase D)

`printing` verb was originally queued but **deferred** — printing remains exposed via MATERIAL-SYNTHESIS.md chapter. Reason: AM-process additive deserves its own verb but Phase D scope prioritized chemistry-class verbs.

**Phase D verb count**: **12 new verbs landed**. hexa-matter is now at **17 + 12 = 29 verbs**. The 7-group taxonomy is **unchanged** — we did NOT add `GROUP_2D` despite earlier consideration; 2d-materials stays in CER for simplicity (decision: dimensional reduction is an axis, not a separate group).

---


Per `LATTICE_POLICY.md §1.2 + §1.3`:

- The n=6 invariants (σ=12, τ=4, φ=2, J₂=24) are **arithmetic facts**, true for any integer n=6.
- They show up in `verify/lattice_arithmetic.hexa` as an arithmetic sanity gate (σ·φ = n·τ = 24 must hold).
- They do **NOT** determine the verb count (17 ≠ 12, 17 ≠ 24).
- They do **NOT** determine the group count (7 ≠ 6, 7 ≠ 12).
- They do **NOT** appear in any material-property claim in `LIMIT_BREAKTHROUGH.md` or in the per-verb spec docs.

**The real taxonomy follows physics + engineering**:
- Bond character (ionic, covalent, metallic, van der Waals, H-bond)
- Processing route (sinter, polymerize, cast, weave, dye)
- End-product class (component, composite, structure, consumable)

This discipline matches hexa-bio's stance (5-axis count locked by `.roadmap.axis_expansion_decision_2026_05_08`; not derived from n=6) and hexa-energy's (verb count driven by physics + engineering, lattice is aux).

### §4.1 What "lattice-tautology" means here

A *lattice-tautology* is a claim like "hexa-matter has 12 ceramic verbs because σ(6) = 12". That would be a tautology (true by construction of the lattice) masquerading as engineering insight. We do **not** do this. The 5 ceramic verbs (CER group) are 5 because that is what the engineering taxonomy demands (concrete, ceramics, concrete_tech, glass, silicon are 5 distinct verbs by bond class + processing route, *regardless* of what σ(6) equals).

---

## §5 Comparison — hexa-bio's decomposition style

hexa-bio took a **5-axis locked count** approach: QUANTUM / WEAVE / NANOBOT / RIBOZYME / VIROCAPSID. The count is locked by `.roadmap.axis_expansion_decision_2026_05_08`; each axis carries an *exact* σ(6)=12 STRUCTURAL claim (with Bayesian audit n=30 / n=60 corpus log_BF decisive).

hexa-matter takes a **7-group expandable count** approach: groups are loose clusters, verb count is engineering-driven (now 17, queued to ~29 after Phase D), no Bayesian σ-match audit.

The reason for the difference: **hexa-bio axes are theory commitments**; the σ(6)=12 STRUCTURAL claim is *load-bearing* (a counter-example would falsify the axis). **hexa-matter groups are engineering clusters**; no counter-example exists because material parameters (T_m, σ, ρ) are measured, not derived from n=6.

This is the right call. Trying to force hexa-bio-style σ(6)=12 claims onto material verbs (e.g., "ceramic has σ(6)=12 vertices on its cluster") would be a lattice-fit — exactly the anti-pattern `LATTICE_POLICY` was authored to prevent.

---

## §6 Phase ordering — A → B → C → D → E → F → G

| Phase | Scope | Status |
|-------|-------|--------|
| **A** | Infrastructure docs: AXIS · AXIS_CLOSURE_PLAN · CLOSURE_RESIDUAL_BACKLOG · DECOMPOSITION_PLAN · LESSONS · RELEASE_NOTES_v1.0.0 · RELEASE_NOTES_v1.1.0 · V1_2_0_HANDOFF · USER_ACTION_REQUIRED · IMPORTED_FROM_CANON | ✅ **COMPLETE 2026-05-13** |
| **C** | Per-group depth dirs (silicon/, microplastics/ already exist; phase C adds further depth on superalloy/ + 2d-materials/ chapters created by Phase D) | Partially overlapped with Phase D |
| **D** | New verbs (12 landed): compound-semi, perovskite, 2d-materials, elastomer, adhesive, biodegradable-plastics, wood-cellulose, superalloy, magnetic-materials, mof, liquid-crystal, carbon | ✅ **COMPLETE 2026-05-13** (17 → 29) |
| **E** | Python bridge `_python_bridge/module/` — Hales-anchored packing calc, Frenkel-anchored σ_th calc, mirror to hexa-bio pattern | Queued |
| **F** | Research bridge to live databases: MatWeb, NIST SRD, ASTM, SEMI, CRC | Queued |
| **G** | AlphaFold-class absorption: CALPHAD-class thermodynamic assessment, MatBench / Materials Project integration | Queued (long horizon) |

Phase A is **infrastructure only** — no code, no new verbs, no bridges. The next phase (B) will land per-verb selftest gates with the B-CER-1..B-FAS-2 parity infrastructure noted in `CLOSURE_RESIDUAL_BACKLOG.md §B`.

---

## §7 Risk / caveats

1. **Group boundaries are squishy in places** — `lutherie` straddles MET and culture-craft; `tire_cord` straddles POL and FIB; `microplastics` straddles POL and environmental-fate. We chose a single home for each verb but the boundary is not crisp. Phase D may move some verbs.

2. **Lattice-fit temptation** — when adding Phase D verbs (target 12 new = 17 + 12 = 29), there will be temptation to round to 24 or 36 for n=6 aesthetics. We will resist. Engineering count wins.


4. **The 6 vs 7 visibility issue** — we have **7 groups** but project name says **n=6**. This is intentional and is now explicit in `AXIS.md §9` and this doc. The lattice is auxiliary; engineering wins.

---

## §8 Honest C3

- This file is a *taxonomy proposal*, not a verification artifact.
- The 7-group split is one defensible decomposition; alternative groupings (e.g., 4-group Ashby super-class) would also work. We picked 7 for engineering granularity.
- The Phase D verb count (12) is a *target*, not a commitment. The actual count delivered will depend on user prioritization (see `USER_ACTION_REQUIRED.md`).
- No n=6 lattice anchoring of any verb count, group count, or material parameter (per LATTICE_POLICY §1.2).

---

*Document authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase A elevation. Taxonomic framework adapted from `hexa-bio/DECOMPOSITION_PLAN.md` (cycle-30++++++) with materials-science substitutions (Ashby/ASM/MatWeb instead of hexa-medic/hexa-bio biology splits).*
