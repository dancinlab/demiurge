<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — Ni-based / Co-based / Fe-Ni-based superalloys, stress-rupture, γ' fraction, SX casting -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; depth content cross-links METALLURGY-DEEP.md -->
---
domain: superalloy
requires: []
verb_group: metal
status: SPEC_FIRST
verdict_basis: ASM Handbook + Special Metals + Haynes + ATI vendor datasheets; no lattice fit
---

# Superalloy — n=6 소재 substrate, material verb (Phase D 26/29)

> **Material layer only.** Ni-based (Inconel 718, René 80, CMSX-4,
> Mar-M-247), Co-based (Stellite, Haynes 188, L-605), Fe-Ni-based
> (Incoloy 800, A-286) superalloys for hot-section turbine components,
> nuclear reactor primary loop, exhaust valves, chemical-process
> reactor. **Gas turbine engineering** (cooling channel design,
> blade-to-disc attachment, single-crystal solidification scheduling)
> lives in `hexa-energy`. Depth content cross-links to METALLURGY-DEEP.md.

> γ' fraction, fatigue lives cite ASM Handbook vol. 1 + 2 + Special
> Metals (Huntington Alloys) + Haynes International + ATI Specialty
> Alloys datasheets. No lattice projection of vendor capacity.

---

## §1 WHY — why superalloy belongs in hexa-matter

A separate `superalloy/` verb (vs the existing `metallurgy/` verb) is
justified because:
- Superalloy chemistry is distinct (γ' / γ'' precipitation, MC / M₂₃C₆
  carbides, complex Cr-Co-Mo-W-Ta-Re multinary)
- Production routes are specialized (VAR/ESR ingot, Bridgman SX,
  powder + HIP, additive manufacturing)
- Industrial customers (aerospace, energy, nuclear, oil&gas) treat
  superalloy as a distinct product category
- ASM Handbook devotes vol. 1 chapters specifically to superalloy

| Family | Matrix | Strengthening | Industrial signature |
|--------|--------|---------------|----------------------|
| **Ni-based** | γ (FCC Ni) | γ' (Ni₃Al/Ti), γ'' (Ni₃Nb) precipitate + solid-solution | turbine blade + disc, aero engine hot section |
| **Co-based** | γ (FCC Co) or HCP Co | M₇C₃ / M₂₃C₆ carbide + solid-solution | exhaust valve, vane, weld overlay |
| **Fe-Ni-based** | γ (FCC) | γ' / γ'' | lower-cost substitute, gas-turbine ring + casing |

---

## §2 Real-limits-first — superalloy's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| SA-L1 | Inconel 718 stress-rupture at 650 °C, 100 h | Engineering / SOFT | **~ 700 MPa** | ASM Handbook vol. 1 / Special Metals datasheet |
| SA-L2 | Inconel 718 stress-rupture at 760 °C, 100 h | Engineering / SOFT | ~ 350 MPa | Special Metals datasheet |
| SA-L3 | CMSX-4 stress-rupture at 980 °C, 100 h | Engineering / SOFT | **~ 350 MPa** | ASM Handbook vol. 1 / Cannon-Muskegon datasheet |
| SA-L4 | CMSX-10 (3rd gen SX) stress-rupture at 1100 °C, 100 h | Engineering / SOFT | **~ 200 MPa** | Cannon-Muskegon datasheet |
| SA-L5 | Mar-M-247 (equiaxed cast) stress-rupture at 980 °C, 100 h | Engineering / SOFT | ~ 280 MPa | Howmet datasheet |
| SA-L6 | γ' volume fraction in modern SX Ni superalloy | Engineering / SOFT | **70–75 vol %** | Reed *The Superalloys: Fundamentals and Applications* (Cambridge 2006) |
| SA-L7 | Ni T_m (matrix) | Physical / HARD | **1728 K (1455 °C)** | NIST WebBook |
| SA-L8 | Service-T / T_m ratio (SX blade, modern engine) | Engineering / SOFT | **0.79–0.85** (1100 °C / 1728 K ≈ 0.79) | Reed 2006 |
| SA-L9 | Inconel 718 max use-T | Engineering / SOFT | ~ 650 °C continuous (γ'' over-aging above) | Special Metals |
| SA-L10 | Single-crystal blade dislocation / boundary content | Engineering / SOFT | **0 high-angle grain boundaries by design** (vs equiaxed ~ 50 µm grain) | Reed 2006 |
| SA-L11 | Re content in 3rd-generation SX (CMSX-10) | Engineering / SOFT | **3–6 wt %** | Cannon-Muskegon CMSX-10 datasheet |
| SA-L12 | Haynes 188 Co-base max-T capability | Engineering / SOFT | ~ 1095 °C continuous | Haynes International datasheet |
| SA-L13 | Powder superalloy (René 95, Astroloy) Astroloy SAGBO | Engineering / SOFT | sub-µm grain via VIM + atomization + HIP | ASM Handbook vol. 1 |
| SA-L14 | AM (LPB-LF) Inconel 718 mechanical property vs wrought | Engineering / SOFT | typically **5–15 % lower** stress-rupture without HIP post-process | NIST AM-Bench |
| SA-L15 | TBC (YSZ 7-8 wt % Y₂O₃) thermal protection | Engineering / SOFT | ~ 100–200 °C blade-temperature reduction at TBC thickness 250 µm | ASM Handbook vol. 5A |

**Note on stress-rupture (SA-L1 through L5).** Stress-rupture is the
canonical figure of merit — 100 h at fixed T tells you how much stress
the alloy can carry without creep failure. Modern engines push 980–
1100 °C metal temperatures, requiring SX (single-crystal) blades with
Re or Ru additions.

**Note on service-T/T_m ratio (SA-L8).** The 0.79–0.85 ratio is what
makes superalloy unique — most metals fail by creep at T/T_m > 0.4.
Superalloys reach 0.85 because γ' precipitation pins dislocations and
the SX architecture eliminates grain-boundary creep.

---


| Producer | Material focus | Reported scale | Source |
|----------|----------------|----------------|--------|
| Special Metals (Huntington Alloys, Precision Castparts / Berkshire Hathaway) | Inconel 718, 625, 738; Nimonic; Monel | dominant US Ni-alloy producer | PCC IR via Berkshire |
| Haynes International | Haynes 188, 230, 282 + Hastelloy | ~ $500 M revenue (2024) | Haynes IR |
| ATI (Allegheny Technologies) | superalloy + Ti grade-5 | ~ $4 B revenue (2024) | ATI IR |
| Cannon-Muskegon | CMSX-2/-4/-10 SX alloys, MAR-M | major SX alloy supplier | Cannon-Muskegon public |
| Doncasters Group | aerospace SX + equiaxed casting | major investment casting | Doncasters public |
| Howmet Aerospace | aerospace investment casting + AM | ~ $7 B revenue (2024) | Howmet IR |
| Fushun Special Steel | Chinese superalloy producer | major | Fushun public |
| Aubert & Duval (Eramet) | aerospace forging + powder | major | Eramet IR |
| ATI + Carpenter Technology | nickel + cobalt alloy | major US producers | ATI / CRS IR |

**Global market sizing:** superalloy + nickel-base alloy market ~ $6–7 B/yr (2024).
End-use: **aerospace ~ 60 %** (engine + airframe), **industrial gas turbine ~ 25 %**, others ~ 15 %.

> **Honesty caveat (LATTICE_POLICY §3.3):** these vendors operate at
> $0.5–7 B revenue scale each; capacity bounded by VAR/ESR furnace
> count, investment-casting cluster size, and powder-atomizer
> throughput — not by n=6 lattice.

---

## §4 STRUCT — superalloy material flow

```
Wrought (e.g., Inconel 718) branch:
   [Pure Ni + Cr + Fe + Nb + Mo + Al + Ti charge]
        ↓ VIM (Vacuum Induction Melting)
   [VIM ingot]
        ↓ VAR / ESR remelt for cleanliness
   [VAR / ESR ingot, low S + low O]
        ↓ homogenize + hot work (forge / roll)
   [Wrought billet / bar]
        ↓ solution anneal + age (γ'' precipitation)
   [Finished forging — turbine disc, casing, ring]

Single-crystal (SX) cast (e.g., CMSX-4) branch:
   [SX alloy ingot]
        ↓ vacuum induction remelt
   [Molten superalloy]
        ↓ Bridgman directional solidification w/ helical grain selector
   [SX blade — one grain, c-axis aligned]
        ↓ solution + multi-step age
   [Heat-treated SX blade]
        ↓ EB-PVD or APS TBC coating (YSZ, 7-8 wt % Y₂O₃)
   [Coated SX blade — turbine hot section]

Powder + HIP (e.g., René 95) branch:
   [Master heat]
        ↓ VIM melt
        ↓ argon-gas atomization
   [Powder, sieved 53–150 µm]
        ↓ HIP consolidation 1100–1200 °C, 100–200 MPa
   [Fully dense powder billet]
        ↓ isothermal forging
   [Turbine disc — René 95, Astroloy, Udimet 720]

Additive (LPB-LF) branch:
   [Pre-alloyed powder, IN718]
        ↓ laser powder-bed fusion
   [Near-net-shape part]
        ↓ HIP + heat treat (~ 1150 °C, 100 MPa)
   [AM superalloy part — fuel nozzle (GE LEAP), bracket]
```

---

## §5 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | Nimonic 80A (first Ni-base creep alloy, Whittle engine 1940s) | Historical |
| Mk.II | Inconel 718 (1960s, age-hardened) | Workhorse commodity |
| Mk.III | René 80 + Mar-M-247 equiaxed cast | Commodity |
| Mk.IV | CMSX-2 SX (Cannon-Muskegon 1980) | Commercial |
| Mk.V | CMSX-4 / -10 with Re/Ru additions | Commercial |
| Mk.VI | TMS-138 / 162 4th-gen SX with Ru | Commercial niche |
| Mk.VII | EBM (Electron Beam Melting) + LPB-LF Inconel | Commercial ramp |
| Mk.VIII | Co-base SX | R&D — UNVERIFIED commercial |
| Mk.IX | Re-free 4th-gen SX (Re supply concern) | R&D — UNVERIFIED at performance parity |

---

## §6 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| General Fe-alloy metallurgy + heat treatment | `metallurgy/swordsmithing.md`, **METALLURGY-DEEP.md §1-§3** (depth content) |
| TBC ceramic (YSZ) | `ceramics/ceramics.md`, CERAMIC-ENGINEERING.md |
| Refractory metal (W, Mo, Re, Ta) | METALLURGY-DEEP.md |
| Powder atomization process | `synthesis/material-synthesis.md`, MATERIAL-SYNTHESIS.md |
| AM (additive manufacturing) | MATERIAL-SYNTHESIS.md (printing section) |
| Magnetic Co-base + Cr alloy | `magnetic-materials/magnetic-materials.md` |
| **Gas turbine engineering** | **`hexa-energy`** |
| **Aerospace engine system** | **`hexa-mobility`** |
| Recycling — superalloy scrap stream | `recycle_n6/`, `recycling/` |

Cross-link rule: this spec ends at the **finished part leaving heat
treatment / TBC**. Engine integration is `hexa-energy` / `hexa-mobility`.

---

## §7 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| Ni T_m 1728 K | NIST WebBook | SA-L7 sanity |
| Inconel 718 SR @ 650 °C, 100 h | ASM Handbook vol. 1 | SA-L1 sanity |
| CMSX-4 SR @ 980 °C, 100 h | Cannon-Muskegon datasheet | SA-L3 sanity |
| γ' volume fraction 70–75 % | Reed 2006 | SA-L6 sanity |
| Service-T/T_m 0.79–0.85 | Reed 2006 | SA-L8 sanity |
| YSZ TBC composition | ASM Handbook vol. 5A | SA-L15 sanity |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-SA-1 | Re-free SX matching CMSX-10 stress-rupture at production | OPEN |
| F-SA-2 | AM Inconel matching wrought SR within 5 % without HIP | OPEN |
| F-SA-3 | Co-base SX commercial deployment in engine | OPEN |
| F-SA-4 | TBC enabling > 1300 °C metal temperature in production | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "γ' 75 vol % equals σ·φ × 3.13" — coincidence
- ✗ "CMSX-4 SR 350 MPa fits n=6 lattice" — coincidence
- ✗ "Special Metals / Haynes / ATI revenue follows n=6" — they have not heard of it
- ✗ "Re content 3-6 wt % equals n=6 / 2" — coincidence


---

## §8 Honest scope + caveats

1. **Material layer only.** Engine architecture, cooling channel
   design, blade-to-disc attachment, turbine stage matching —
   `hexa-energy` / `hexa-mobility`.

2. **Re-free 4th-gen SX UNVERIFIED at performance parity.** Re supply
   concern (90 %+ Chile + Kazakhstan + Chile + USA Phelps Dodge);
   substitution remains R&D.

3. **AM superalloy mechanical-property gap.** AM Inconel typically 5–
   15 % lower SR than wrought without HIP; honest distinction
   preserved.

4. **No lattice anchoring of vendor numbers.** Special Metals / Haynes
   / ATI / Cannon-Muskegon / Doncasters / Howmet / Fushun / Aubert &
   Duval / Carpenter capacities cited verbatim.

5. **SPEC_FIRST verdict.** All numbers from ASM Handbook vol. 1 + 5A,
   Reed 2006 textbook, vendor datasheets, NIST.

6. **Coincidence disclosure (LATTICE_POLICY §1.1).** Any apparent fit
   of γ' fraction / SR / T_m to n=6 is coincidence.

---

## §9 References

- Reed R.C., *The Superalloys: Fundamentals and Applications* (Cambridge 2006)
- Sims C.T., Stoloff N.S., Hagel W.C. (eds.), *Superalloys II* (Wiley 1987)
- **ASM Handbook vol. 1** — Properties and Selection: Irons, Steels, and High-Performance Alloys
- **ASM Handbook vol. 5A** — Thermal Spray Technology (YSZ TBC)
- **NIST WebBook** — Ni T_m, Co T_m
- **AMS 5662** — Inconel 718 forging spec
- Special Metals (Huntington Alloys) — Inconel 718, 625, 738, Nimonic, Monel datasheets
- Haynes International — Haynes 188, 230, 282, Hastelloy datasheets
- ATI Specialty Alloys — superalloy + Ti datasheets
- Cannon-Muskegon — CMSX-2, CMSX-4, CMSX-10 datasheets
- Howmet Aerospace — investment casting + AM superalloy
- NIST AM-Bench — additive manufacturing superalloy benchmark
- **METALLURGY-DEEP.md** (this repo) — §1-§3 superalloy depth
- `metallurgy/swordsmithing.md` — general metallurgy
- `LATTICE_POLICY.md` §1.2 + §1.3
- `LIMIT_BREAKTHROUGH.md` (Wave M)
- Cross-link sibling: `hexa-energy` (gas turbine), `hexa-mobility` (aero engine)

---

*Authored 2026-05-13 by 박민우. Material-layer spec for Phase D
`superalloy` verb (26 of 29). Depth content cross-links
METALLURGY-DEEP.md §1-§3. Engine architecture out of scope —
`hexa-energy` / `hexa-mobility`. No lattice fit.*

---

## Related NOVEL candidate

- `hxm-ni-4gen-re-free-001` — see [NOVEL.md §4.D.2](../NOVEL.md): Re-free 4th-generation Ni-base single-crystal superalloy.

> SIM / proxy status is NOT a measurement and does NOT promote to `EXTERNAL-VERIFIED` without attributed external-lab evidence (NOVEL.md §7 · @F f2 / f5).
