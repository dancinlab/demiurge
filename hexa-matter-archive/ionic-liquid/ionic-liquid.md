<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — room-T molten salts (imidazolium, pyridinium, ammonium, phosphonium) + deep eutectic solvent (DES) distinction -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; no lattice anchoring of ionic-liquid parameters -->
---
domain: ionic-liquid
requires: []
verb_group: polymer
status: SPEC_FIRST
verdict_basis: ILTHERMO (NIST database) + primary literature (Walden 1914 / Wilkes 1992 / Welton 1999 review) + IoLiTec / Solvionic / BASF vendor data; no lattice fit; DES distinction preserved
---

# Ionic-Liquid — n=6 소재 substrate, material verb (Phase D follow-on 33/33)

> **Material layer only.** Salts that are **liquid at < 100 °C** (the
> IUPAC threshold), typically with a bulky organic cation
> (1-alkyl-3-methylimidazolium, pyridinium, quaternary ammonium,
> phosphonium) paired with an inorganic or fluorinated anion ([BF₄]⁻,
> [PF₆]⁻, [NTf₂]⁻ = [Tf₂N]⁻, [OTf]⁻, [DCA]⁻, halide). Distinct from
> **deep eutectic solvents (DES)** — a related but distinct class
> (e.g., choline chloride + urea = reline) which are *molecular*
> hydrogen-bond complexes, not pure salts. Industrial use: green
> solvent, electrolyte (Li-ion / supercapacitor), cellulose dissolution
> (BASF Basionics), CO₂ capture (Bayer / BASF), tribological lubricant.

> (melting point, viscosity, ionic conductivity, water tolerance,
> hydrolytic stability) are set by **cation/anion pair chemistry,
> alkyl-chain length, hydrogen-bond network** — not by the n=6 lattice.
> IoLiTec / Solvionic / BASF / Merck KGaA / Sigma-Aldrich vendor and
> NIST ILTHERMO database figures cited verbatim with no lattice
> projection. **"Green solvent" claim UNVERIFIED** at full-LCA basis
> (synthesis route emits halogenated waste; recyclability claims
> UNPROVEN for many cation-anion combinations).

---

## §1 WHY — why ionic-liquid belongs in hexa-matter

Ionic liquids occupy a unique slot in the materials envelope:
- **Liquid at room T** (a salt!), with **negligible vapor pressure**
  (< 10⁻¹⁰ Pa at 25 °C for [BMIM][NTf₂]) — distinct from molecular
  solvents which evaporate (VOC concern).
- **Wide electrochemical window** (4–6 V for imidazolium-NTf₂; vs ~ 1.2 V
  for water) → battery + supercapacitor electrolyte.
- **Tunable solvent properties** — change cation alkyl chain length or
  anion identity → tune viscosity, hydrophobicity, polarity. The
  "designer solvent" framing (Welton 1999) is the canonical motivation.
- **Cellulose dissolution** ([EMIM][OAc] dissolves cellulose at 80 °C;
  basis for BASF Basionics Cellulose Acetate route). Cross-link to
  `wood-cellulose/`.

| Subclass | Cation family | Typical anions | Industrial signature |
|----------|---------------|----------------|----------------------|
| Imidazolium IL | [RMIM]⁺ (1-alkyl-3-methylimidazolium) | [BF₄]⁻, [PF₆]⁻, [NTf₂]⁻, [Cl]⁻, [OAc]⁻ | Most studied; BASF BASIL process; cellulose dissolution |
| Pyridinium IL | N-alkylpyridinium | [BF₄]⁻, [NTf₂]⁻ | Electrochemistry; corrosion inhibitor |
| Ammonium IL | quaternary ammonium [N1888]⁺ etc. | [NTf₂]⁻, [OTf]⁻, [DCA]⁻ | Lubricant additives; biocompatible variants |
| Phosphonium IL | quaternary phosphonium [P66614]⁺ (Cyphos series) | [Cl]⁻, [Br]⁻, [NTf₂]⁻ | High thermal stability (> 350 °C); Cytec Cyphos commercial |
| Deep Eutectic Solvent (DES) | choline chloride + urea/glycerol/etc. | (not a salt — H-bond complex) | "Reline" — cheaper green solvent; **distinct from IL** |
| Protic IL (PIL) | proton-transfer cation, e.g. [EAN]⁺ ethylammonium nitrate | [NO₃]⁻ | Walden 1914 original IL; fuel-cell electrolyte |

**Distinction from DES is load-bearing.** Deep eutectic solvents
(Abbott et al. 2003) are **hydrogen-bond complexes** between a halide
salt (typically choline chloride, ChCl) and a hydrogen-bond donor
(urea, ethylene glycol, glycerol). They are **not** pure ionic liquids
— the eutectic mixture has lower melting point than either component,
but it is a molecular complex, not a salt. ILs are pure salts that
happen to melt below 100 °C. Routing DES through `ionic-liquid/` is
acceptable IFF the distinction is preserved (this spec §1).

---

## §2 Real-limits-first — ionic-liquid's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| IL-L1 | IUPAC ionic-liquid melting-point definition | Convention / HARD | **T_m < 100 °C (373 K)** by IUPAC convention; **room-T IL** = T_m < 25 °C | IUPAC Gold Book; Welton 1999 |
| IL-L2 | [BMIM][NTf₂] (workhorse) T_m | Physical / HARD | **−4 °C (269 K)** | NIST ILTHERMO; Tokuda et al. 2005 |
| IL-L3 | [BMIM][NTf₂] viscosity at 25 °C | Physical / SOFT | **52 mPa·s** (vs water 0.89 mPa·s; vs ethylene glycol 16 mPa·s) | NIST ILTHERMO |
| IL-L4 | [EMIM][NTf₂] ionic conductivity at 25 °C | Physical / SOFT | **8.4 mS/cm** (high for an IL; comparable to 0.5 M aq KCl) | Tokuda et al. 2005; NIST ILTHERMO |
| IL-L5 | Imidazolium IL vapor pressure at 25 °C | Physical / HARD | **< 10⁻¹⁰ Pa** (effectively zero) | Earle et al. *Nature* 439, 831 (2006) |
| IL-L6 | Imidazolium IL electrochemical window | Physical / SOFT | 4.0–4.5 V (Pt working electrode); up to **6 V** with phosphonium-NTf₂ | Hapiot & Lagrost 2008 review |
| IL-L7 | Phosphonium IL thermal decomposition T | Physical / HARD | **350–450 °C** (Cyphos series; T_d > imidazolium) | Cytec Cyphos technical |
| IL-L8 | [PF₆]⁻ hydrolytic instability | Chemistry / HARD | **HF release on hydrolysis** — UNVERIFIED purity-stable in long-term water contact | Swatloski et al. 2003 |
| IL-L9 | [BMIM][Cl] toxicity (Daphnia magna EC50) | Toxicology / SOFT | EC50 ~ 5–10 mg/L (moderate — similar to xylene); **NOT "non-toxic"** | Pretti et al. 2009 |
| IL-L10 | [EMIM][OAc] cellulose dissolution capacity | Engineering / SOFT | up to **25 wt-%** cellulose at 80 °C | Swatloski et al. 2002 *JACS* 124, 4974 |
| IL-L11 | IL synthesis cost per kg (research grade) | Engineering / **UNPROVEN** | $500–5000/kg (research grade vendor pricing); **commodity-grade $10–50/kg disputed** | Sigma-Aldrich / IoLiTec catalog; UNVERIFIED at commodity scale |
| IL-L12 | Imidazolium IL biodegradability (OECD 301) | Toxicology / SOFT | **typically poor**; designed-biodegradable ILs are R&D | Stolte et al. 2008; Bubalo et al. 2014 |
| IL-L13 | DES (reline = ChCl + urea 1:2) melting point | Physical / HARD | **12 °C (285 K)** (vs ChCl 302 °C / urea 133 °C alone) | Abbott et al. 2003 *Chem. Commun.* |
| IL-L14 | ILTHERMO database coverage (NIST) | Engineering / SOFT | > 12,000 ionic-liquid entries (T_m, ρ, η, κ, etc.) | NIST ILTHERMO |
| IL-L15 | IL service-T range (room-T to upper limit) | Engineering / SOFT | 0 °C – 250 °C typical for imidazolium-NTf₂; up to 350 °C for phosphonium-NTf₂ | NIST ILTHERMO + Cyphos |

**Note on "green solvent" claim — UNVERIFIED at full LCA.** The
near-zero vapor pressure (IL-L5) is real and gives ILs a VOC advantage
over molecular solvents. However:
- **Synthesis route generates halogenated waste** (alkyl halide
  quaternization step uses chlorobutane / bromobutane / iodomethane).
- **Recyclability claims** require demonstrated recycling-loop closure;
  most ILs in industry are single-use or partial-recycle.
- **Toxicity is non-negligible** (IL-L9: imidazolium EC50 ~ 5 mg/L is
  similar to BTEX aromatics).
- **Biodegradability is typically poor** (IL-L12); designed-biodegradable
  ILs (with ester linkers, choline cation) exist but are R&D.

Verdict: ILs are **lower-VOC** than molecular solvents, but "green
solvent" is **UNVERIFIED at full life-cycle accounting**. Honest
phrasing: "lower vapor-pressure solvent class with significant
toxicity + biodegradability concerns at scale."

**Note on cost — UNPROVEN at commodity scale (IL-L11).** Research-grade
[BMIM][NTf₂] is $500–2000/kg at Sigma-Aldrich. The [NTf₂]⁻ anion
contributes most of the cost (LiNTf₂ at ~ $200–400/kg). For mass-market
deployment as Li-ion electrolyte, cost must drop 10–100×. Commodity-
grade IL at $10–50/kg is **disputed** in industry — no public vendor
catalog at sub-$50/kg for [NTf₂]⁻ ILs as of 2024.

---


Global ionic-liquid market is **niche specialty chemicals**: ~ $50M–$200M/yr
estimates (industry reports 2024) vs $100B+/yr solvent market. Largest
single deployment is BASF BASIL (Biphasic Acid Scavenging utilising
Ionic Liquids) ~ 1300 t/yr scale for HCl scavenging in
alkoxyphenylphosphine synthesis.

| Producer | Material focus | Reported deployment / scale | Source |
|----------|----------------|-------------------------------|--------|
| BASF SE | BASIL process (1-methylimidazole acts as HCl scavenger, IL is byproduct); Basionics CO₂ capture R&D | BASIL: ~ 1300 t/yr — first industrial-scale IL process (2002) | BASF public; Maase 2007 |
| IoLiTec (DE) | Imidazolium / pyridinium / phosphonium IL catalog | Major specialty supplier | IoLiTec catalog |
| Solvionic (FR) | High-purity IL for electrochemistry | Battery electrolyte research market | Solvionic public |
| Sigma-Aldrich (Merck KGaA) | Research-grade IL catalog | Lab-scale dominant | Merck KGaA catalog |
| Cytec Industries / Solvay (now Syensqo) | Cyphos phosphonium IL | Tribology + metal-extraction niche | Cyphos technical literature |
| Eastman Chemical | Cellulose-IL process R&D | Acetylation alternative — UNVERIFIED at scale | Eastman public |
| Wako (Fujifilm) | Research-grade IL | Japanese market | Wako catalog |
| Strem Chemicals | Specialty IL | Research market | Strem catalog |
| Yangzhou Lan Tian (China) | Imidazolium IL bulk | Asian commodity supply attempt | Lan Tian public |

> **Honesty caveat (LATTICE_POLICY §3.3):** IL commercial scale is
> bounded by **quaternization step throughput (alkyl halide + N-base) +
> anion-exchange step + purification cost** — not by lattice arithmetic.
> BASF BASIL 1300 t/yr is a **single-process** deployment (HCl
> scavenger), not a "commodity IL solvent" deployment. No projection
> onto n=6.

---

## §4 STRUCT — ionic-liquid material flow

```
[N-alkylimidazole or N-alkylpyridine or trialkylamine or trialkylphosphine] (base)
        ↓ + alkyl halide R-X (chlorobutane, bromobutane, iodomethane)
        ↓ Menshutkin quaternization, 60–80 °C, neat or in toluene, 24–72 h
[Quaternary ammonium/imidazolium/phosphonium halide salt — [Cat]⁺[X]⁻]
        ↓ anion exchange (typically via Ag-salt metathesis or direct ion exchange)
        ↓ e.g. + LiNTf₂ in water → [Cat][NTf₂] (hydrophobic, phase-separates)
[Ionic liquid — [Cat]⁺[A]⁻]
        ↓ wash + vacuum dry (water content < 50 ppm by Karl Fischer)
[Purified IL]
        ↓
   ┌────┴──────────────┬───────────────────┬─────────────────────────┐
   ↓                   ↓                   ↓                         ↓
[Green solvent]    [Battery electrolyte]  [Cellulose dissolution]  [CO₂ capture]
(BASIL process)    (Li-ion + supercap)    ([EMIM][OAc] → fiber)    (Basionics R&D)
                                          → wood-cellulose/

Deep Eutectic Solvent (DES) branch (Abbott 2003) — distinct:
[Choline chloride (or other Q-NR₄X salt)]  +  [Urea or glycerol or ethylene glycol]
        ↓ mix + warm to dissolve (no chemistry, just H-bond formation)
[Deep Eutectic Solvent — eutectic mixture, T_m well below either component]
   (Reline = ChCl:urea 1:2, T_m 12 °C)
```

---

## §5 FLOW — process aspects in scope

| Process step | Material-aspect concern (this repo) | Out-of-scope |
|--------------|-------------------------------------|--------------|
| Quaternization (Menshutkin) | T, time, neat vs solvent, halide byproduct disposal | reactor engineering |
| Anion exchange | metathesis chemistry, Ag-salt cost, ion-exchange resin | column design |
| Purification (water + halide removal) | Karl-Fischer water content, halide ppm assay | distillation engineering |
| Electrochemical-window measurement | reference electrode in IL, decomposition product ID | electrochemistry → hexa-energy |
| Cellulose dissolution ([EMIM][OAc]) | dissolution capacity vs T, regeneration | fiber-spinning → wood-cellulose, fabric |
| CO₂ capture (BASIL / amine-functionalized IL) | absorption capacity, regeneration energy | DAC system engineering → hexa-earth, mof/ |
| DES preparation | H-bond donor/acceptor ratio, viscosity-T curve | (distinct chemistry; see §1 distinction) |

---

## §6 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | Walden ethylammonium nitrate (1914) — first IL | Historical |
| Mk.II | Wilkes [EMIM][AlCl₄] (1982 / 1992) — first air-stable IL | Foundational |
| Mk.III | Welton "designer solvent" framing (1999 *Chem. Rev.* review) | Foundational concept |
| Mk.IV | BASF BASIL process (2002, 1300 t/yr commercial) | Commercial niche (single-process) |
| Mk.V | [EMIM][OAc] cellulose dissolution (Swatloski 2002 JACS) | Commercial niche (BASF, Eastman R&D) |
| Mk.VI | Cyphos phosphonium IL (Cytec; thermal stability > 350 °C) | Commercial niche |
| Mk.VII | DES "reline" (Abbott 2003) — cheap green solvent alternative | Commercial niche |
| Mk.VIII | IL as Li-ion battery electrolyte at commodity scale | R&D — UNVERIFIED at < $50/kg |
| Mk.IX | Designed-biodegradable IL (choline + ester linker) | R&D — UNVERIFIED at commercial |
| Mk.X | IL CO₂ capture at < $100/t CO₂ commercial | R&D — UNPROVEN (vs Climeworks amine $600–1000/t) |
| Mk.XI | IL displacing molecular VOC solvents at industrial scale | UNPROVEN — toxicity + cost barriers persist |

---

## §7 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| Cellulose dissolution ([EMIM][OAc]) | `wood-cellulose/wood-cellulose.md` |
| Li-ion electrolyte (LiPF₆ + carbonate; IL alternative) | `hexa-energy` (sibling — battery) |
| CO₂ capture economics (Climeworks amine baseline) | `mof/mof.md` (DAC overlap; sibling Phase D) |
| MOF (crystalline nanoporous — different mechanism) | `mof/mof.md` |
| Aerogel (porous, but non-liquid) | `aerogel-foam/aerogel-foam.md` (sibling Phase D follow-on) |
| Green-chemistry LCA + biodegradability | `hexa-earth` (sibling — climate / LCA) |
| Polymer chemistry (covalent vs ionic-bonded liquids) | `POLYMER-CHEMISTRY.md` |
| Lubricant tribology (phosphonium IL) | `hexa-mobility` (sibling — engine/tribology) |
| Pharmaceutical IL (API ionic-liquid formulation) | `hexa-bio` (sibling — drug delivery) |

---

## §8 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| NIST ILTHERMO database | NIST | IL-L2/L3/L4/L14 sanity |
| Walden 1914 ethylammonium nitrate | *Bull. Acad. Imp. Sci. St.-Pétersbourg* | foundational |
| Wilkes & Zaworotko 1992 [EMIM][BF₄] | *J. Chem. Soc. Chem. Commun.* 965 | foundational air-stable IL |
| Welton 1999 review | *Chem. Rev.* 99, 2071 | "designer solvent" framing |
| Earle et al. 2006 *Nature* | *Nature* 439, 831 | IL-L5 vapor pressure < 10⁻¹⁰ Pa |
| Tokuda et al. 2005 PCCP | viscosity + conductivity dataset | IL-L3/L4 sanity |
| Swatloski et al. 2002 cellulose dissolution | *JACS* 124, 4974 | IL-L10 sanity |
| Abbott et al. 2003 DES | *Chem. Commun.* 70 | IL-L13 (DES distinction) |
| BASF BASIL process | Maase 2007 ACS book chapter | first commercial IL |
| Cytec / Solvay Cyphos | vendor datasheet | phosphonium thermal-stability anchor |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-IL-1 | IL-based Li-ion electrolyte at commercial cell production with > 1000 cycle life at IL price < $50/kg | OPEN |
| F-IL-2 | IL CO₂ capture at < $100/t CO₂ commercial scale (vs Climeworks amine $600–1000/t) | OPEN |
| F-IL-3 | Designed-biodegradable IL passing OECD 301 + matching imidazolium-class performance | OPEN |
| F-IL-4 | IL replacing > 1 % of global molecular VOC solvent volume | OPEN |
| F-IL-5 | Vendor offering [BMIM][NTf₂] at < $50/kg in 1-ton lots | OPEN |
| F-IL-6 | Cellulose-IL fiber-spinning at lyocell-cost parity (Eastman / BASF) | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "[BMIM][NTf₂] T_m = −4 °C fits n=6 lattice null" — coincidence
- ✗ "BASIL 1300 t/yr equals σ·τ × 27" — coincidence
- ✗ "IoLiTec / BASF / Cytec capacity tracks n=6" — they have not heard of it
- ✗ "Ionic liquids are non-toxic green solvents" — UNVERIFIED;
  EC50 ~ 5 mg/L is similar to BTEX aromatics
- ✗ "Ionic liquids will replace VOC solvents at scale" — UNPROVEN at
  cost + toxicity tradeoff
- ✗ "DES = IL" — false; DES is H-bond complex, IL is pure salt
- ✗ "IL CO₂ capture at $100/t commercial" — UNPROVEN (Climeworks amine
  baseline $600–1000/t; mof/ DAC also UNPROVEN at $100/t)

---

## §9 Honest scope + caveats

1. **Material layer only.** Battery cell engineering, CO₂-capture
   system design, cellulose-fiber spinning line, pharmaceutical
   formulation — **not here.** Call sibling repos.

2. **"Green solvent" framing UNVERIFIED at full LCA.** Near-zero vapor
   pressure is real but: synthesis emits halogenated waste, toxicity
   is non-negligible (EC50 5 mg/L typical), biodegradability is poor,
   recyclability requires demonstration. Honest phrasing: "lower-VOC
   solvent class with significant LCA caveats."

3. **Cost UNPROVEN at commodity scale.** $500–5000/kg research grade
   typical. Commodity-grade < $50/kg disputed for [NTf₂]⁻ anions
   (LiNTf₂ contributes most cost). Mk.VIII Li-ion electrolyte
   deployment hinges on this.

4. **DES distinction load-bearing.** Deep eutectic solvents (Abbott
   2003) are H-bond molecular complexes, **not** salts. Lumping DES
   under "ionic liquid" erases real chemistry distinction. This spec
   §1 preserves the distinction.

5. **PF₆⁻ hydrolytic instability is real (IL-L8).** [BMIM][PF₆] is
   widely used as "model IL" in early literature but releases HF on
   hydrolysis. Modern preference is [NTf₂]⁻ (fluorinated but
   hydrolysis-stable) or halide for non-fluorinated chemistry.

6. **Toxicity is real (IL-L9).** Imidazolium-Cl EC50 ~ 5–10 mg/L
   (moderate, similar to BTEX aromatics). "Non-toxic green solvent"
   marketing is not supported by ecotox data; designed-biodegradable
   ILs are R&D.

7. **No lattice anchoring of vendor numbers.** BASF / IoLiTec /
   Solvionic / Cytec / Sigma-Aldrich figures cited verbatim; no
   projection onto n=6.

8. **SPEC_FIRST verdict.** All numbers from NIST ILTHERMO + peer-
   reviewed literature + vendor catalog. Working `.hexa` numerical
   sandbox for ionic-liquid is TBD.

9. **Coincidence disclosure (LATTICE_POLICY §1.1).** Any apparent fit
   of IL numbers to n=6 (e.g., BMIM viscosity 52 mPa·s ≈ σ·4.33) is
   coincidence with verification power zero.

---

## §10 References

- Walden P., "Ueber die Molekulargrösse und elektrische Leitfähigkeit
  einiger geschmolzenen Salze," *Bull. Acad. Imp. Sci. St.-Pétersbourg*,
  405 (1914) — ethylammonium nitrate, first IL
- Wilkes J.S., Zaworotko M.J., "Air and water stable
  1-ethyl-3-methylimidazolium based ionic liquids," *J. Chem. Soc.
  Chem. Commun.* 13, 965 (1992) — air-stable IL breakthrough
- Welton T., "Room-temperature ionic liquids. Solvents for synthesis
  and catalysis," *Chem. Rev.* 99, 2071 (1999) — "designer solvent"
  review
- Earle M.J., Esperança J.M.S.S., Gilea M.A., Lopes J.N.C., Rebelo
  L.P.N., Magee J.W., Seddon K.R., Widegren J.A., "The distillation
  and volatility of ionic liquids," *Nature* 439, 831 (2006) —
  vapor-pressure measurement
- Swatloski R.P., Spear S.K., Holbrey J.D., Rogers R.D., "Dissolution
  of cellulose with ionic liquids," *JACS* 124, 4974 (2002) — cellulose
  dissolution chemistry
- Tokuda H., Hayamizu K., Ishii K., Susan M.A.B.H., Watanabe M.,
  "Physicochemical properties and structures of room temperature ionic
  liquids," *J. Phys. Chem. B* 108, 16593 (2004) + 109, 6103 (2005) —
  viscosity, conductivity, T_g
- Hapiot P., Lagrost C., "Electrochemical reactivity in
  room-temperature ionic liquids," *Chem. Rev.* 108, 2238 (2008) —
  electrochemical window
- Swatloski R.P., Holbrey J.D., Rogers R.D., "Ionic liquids are not
  always green: hydrolysis of 1-butyl-3-methylimidazolium
  hexafluorophosphate," *Green Chem.* 5, 361 (2003) — PF₆⁻ instability
- Maase M., "Industrial applications of ionic liquids," in Wasserscheid
  & Welton (eds.), *Ionic Liquids in Synthesis*, 2nd ed. (Wiley-VCH
  2007) — BASIL process
- Pretti C., Renzi M., Ettore Focardi S., Giovani A., Monni G., Melai
  B., Rajamani S., Chiappe C., "Acute toxicity and biodegradability of
  N-alkyl-N-methylmorpholinium and N-alkyl-DABCO based ionic liquids,"
  *Ecotoxicol. Environ. Saf.* 74, 748 (2011) — toxicity
- Stolte S., Steudte S., Igartua A., Stepnowski P., "The biodegradation
  of ionic liquids — the view from a chemical structure perspective,"
  *Curr. Org. Chem.* 15, 1946 (2011)
- Abbott A.P., Capper G., Davies D.L., Rasheed R.K., Tambyrajah V.,
  "Novel solvent properties of choline chloride/urea mixtures," *Chem.
  Commun.* 70 (2003) — DES original paper
- IUPAC Gold Book — ionic liquid definition (T_m < 100 °C)
- **NIST ILTHERMO** — Ionic Liquids Thermodynamics Database, > 12,000
  entries
- BASF SE — BASIL process public material; Basionics CO₂ R&D
- IoLiTec — Ionic Liquids Technologies catalog (Heilbronn)
- Solvionic — high-purity IL catalog (Toulouse)
- Sigma-Aldrich (Merck KGaA) — IL catalog
- Cytec / Solvay Syensqo — Cyphos phosphonium IL datasheets
- Eastman Chemical — cellulose-IL process R&D
- `LATTICE_POLICY.md` §1.2 + §1.3 (this repo)
- `LIMIT_BREAKTHROUGH.md` (this repo) — Wave M materials audit
- Cross-link siblings: `wood-cellulose/wood-cellulose.md`, `mof/mof.md`,
  `aerogel-foam/aerogel-foam.md`, `POLYMER-CHEMISTRY.md`, `hexa-energy`
  (battery), `hexa-earth` (LCA), `hexa-bio` (pharma)

---

*Authored 2026-05-13 by 박민우. Material-layer spec for hexa-matter's
Phase D follow-on `ionic-liquid` verb (33 of 33 — closes the Phase D
follow-on set). Real-limits-first per LATTICE_POLICY.md §1.2; no
lattice fit on IL parameters or BASF/IoLiTec/Solvionic/Cytec/Merck
vendor capacities. "Green solvent" claim UNVERIFIED at full LCA;
commodity-grade cost < $50/kg UNPROVEN; DES distinction preserved
(H-bond complex, not pure salt). Battery cell engineering, CO₂-capture
system design, cellulose-fiber spinning out of scope.*
