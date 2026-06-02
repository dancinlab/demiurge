<!-- @authored: 2026-05-13 -->
<!-- @author: 박민우 <nerve011235@gmail.com> -->
<!-- @scope: material layer — lithography photopolymers (g-/i-line DNQ-novolac, KrF PHS CAR, ArF acrylate/COMA/PHS-ester, EUV CAR + MOR, photopolymer dry films). Device + lithography process belongs to hexa-chip; this verb owns the material chemistry only. -->
<!-- @policy: real-limits-first per LATTICE_POLICY.md §1.2; no lattice anchoring of photoresist parameters -->
---
domain: photoresist
requires: []
verb_group: polymer
status: SPEC_FIRST
verdict_basis: vendor-published numbers (JSR / TOK / Shin-Etsu / Sumitomo Chemical / Fujifilm Electronic Materials / Dow / Inpria for EUV MOR; Hitachi DuPont for dry film) + SEMI standards + IEEE/SPIE primary literature; no lattice fit
---

# Photoresist — n=6 소재 substrate, material verb (Phase D'' 35/36)

> **Material layer only — device + lithography process belongs to
> `hexa-chip`.** Photopolymer films patterned by UV / DUV / EUV /
> e-beam exposure (and subsequent develop) that constitute the
> intermediate masking material in semiconductor + PCB + MEMS + display
> manufacturing. Covers the four canonical chemical-platform
> generations — g/i-line DNQ-novolac, KrF chemically-amplified
> polyhydroxystyrene (PHS), ArF acrylate / COMA / PHS-ester (193 nm,
> with and without immersion + multipatterning), EUV chemically-
> amplified PHS variants + metal-oxide-resist (MOR; Inpria Sn-oxide
> class) — plus photopolymer dry-film resist for PCB (Hitachi DuPont,
> Asahi Kasei). **The lithography process itself (ASML scanner, mask,
> overlay, throughput, CD-SEM metrology, defect inspection) lives in
> `hexa-chip`; this verb owns the resist *as material* only —
> chemistry, sensitivity, contrast, LER, etch resistance.**

> photoresist material properties (sensitivity in mJ/cm² at the
> exposure wavelength, contrast γ, LER/LWR in nm, etch resistance,
> outgassing) are set by **polymer chemistry + photoacid generator
> (PAG) + protecting-group acid lability + quencher concentration +
> base resin Mw and dispersity** — not by the n=6 lattice. JSR / TOK /
> Shin-Etsu / Sumitomo / Fujifilm / Dow / Inpria vendor figures cited
> verbatim with no lattice projection. **EUV photon-shot-noise vs
> LER trade-off NOT FULLY RESOLVED** at the material level —
> stochastic-defect floor at < 8 nm half-pitch is an open research
> frontier per IRDS 2023 lithography chapter.

---

## §1 WHY — why photoresist belongs in hexa-matter

The semiconductor industry's resolution roadmap (193 nm dry → 193 nm
immersion → multi-patterning → EUV 13.5 nm → high-NA EUV) is enabled
**only by the resist material being able to record the optical image
at the relevant exposure dose with sufficient contrast + acceptable
LER**. Lithography hardware (ASML EUV scanner, sub-nm overlay, mask
inspection) is necessary but not sufficient — the resist film is the
recording medium.

Because the discipline cleanly separates *the material* (this verb)
from *the lithography process* (hexa-chip), photoresist deserves its
own verb-slot in hexa-matter — distinct from the broader `epoxy/` or
`adhesive/` polymer verbs, and distinct from `liquid-crystal/` (no
crystallization role).

| Subclass | Exposure platform | Resin / chemistry | Industrial signature |
|----------|-------------------|--------------------|----------------------|
| g/i-line DNQ-novolac (positive) | 436 nm / 365 nm Hg lamp | novolac + diazonaphthoquinone (DNQ) PAC | Workhorse for ≥ 0.35 µm node; PCB; MEMS |
| KrF chemically-amplified resist (CAR) | 248 nm | poly(4-hydroxystyrene) (PHS) protected with t-BOC + PAG | First CAR generation (Ito, Willson, Fréchet 1982); 250–130 nm node |
| ArF CAR (193 nm) | 193 nm ArF excimer | (meth)acrylate / cyclic-olefin-maleic-anhydride (COMA) / PHS-ester with PAG | 130 nm to 28 nm node (dry); to 7 nm with immersion + multipatterning |
| ArF immersion (193i) | 193 nm + water-immersion | same as ArF + immersion-defect mitigation; top-coat | 45 nm → 14 nm via multi-patterning (SADP / SAQP / LELE) |
| EUV CAR | 13.5 nm | PHS-acrylate hybrid CAR + PAG + low-out-of-band absorption | 7 nm and below; production from N7+ (TSMC) / Samsung 7LPP / Intel 18A |
| EUV metal-oxide resist (MOR) | 13.5 nm | Sn-oxo-cluster (Inpria) — direct absorption + high etch resistance | 5 nm node and below; Inpria YESR / commercial 2020+ |
| Photopolymer dry-film (PCB) | broadband UV (i-line) | acrylate dry film with PI/quencher | PCB pattern transfer; Hitachi Chemical DuPont leader |
| Negative-tone-develop (NTD) | 193i / EUV | metal-acrylate or fluorinated PHS — solvent-develop | High-resolution holes / contact patterning |
| e-beam resist (EBL) | 100 kV electron beam | PMMA (positive) / HSQ / ZEP (negative) | Mask-making + research |

---

## §2 Real-limits-first — photoresist's actual ceilings

| # | Limit | Class | Value | Source |
|---|-------|-------|-------|--------|
| PR-L1 | g-line / i-line DNQ-novolac sensitivity | Engineering / SOFT | **20–100 mJ/cm²** at 365 / 436 nm | Mack *Field Guide to Optical Lithography* SPIE 2006 |
| PR-L2 | KrF CAR sensitivity (production grade) | Engineering / SOFT | **10–30 mJ/cm²** at 248 nm | JSR / Shin-Etsu / TOK KrF resist datasheets |
| PR-L3 | ArF dry CAR sensitivity | Engineering / SOFT | **20–40 mJ/cm²** at 193 nm | Vendor datasheet; SPIE Photomask conference |
| PR-L4 | ArF immersion CAR sensitivity | Engineering / SOFT | **20–40 mJ/cm²** at 193 nm (in water) | SPIE Adv. Lith. proceedings |
| PR-L5 | EUV CAR sensitivity | Engineering / SOFT | **20–40 mJ/cm²** at 13.5 nm (production); R&D 10–20 mJ/cm² | IMEC EUV roadmap; SPIE EUV resist proceedings |
| PR-L6 | EUV MOR (Inpria Sn-oxo) sensitivity | Engineering / SOFT | **30–50 mJ/cm²** at 13.5 nm with high etch resistance | Inpria YESR datasheet; Cardineau et al. SPIE 2014 |
| PR-L7 | Stochastic defect-density floor at < 32 nm pitch (EUV CAR) | Physical / **UNVERIFIED** | photon-shot-noise + acid-shot-noise + polymer-fluctuation — **NOT FULLY RESOLVED**; defect density 1–10 / cm² at 32 nm pitch | De Bisschop *J. Micro/Nanolith. MEMS MOEMS* 2017; IRDS 2023 lithography |
| PR-L8 | EUV LWR (line-width roughness) target | Engineering / SOFT | **< 3.5 nm 3σ** for 16 nm pitch (IRDS 2023); production typically 2.5–4 nm | IRDS 2023 lithography chapter |
| PR-L9 | RLS (resolution + LER + sensitivity) trade-off — Z-factor | Physical / **HARD** | Z ≈ LER² · Resolution³ · Dose is a fundamental floor; lower-dose → higher LER | Wallow et al. SPIE 2007 |
| PR-L10 | KrF CAR T_g (PHS-based) | Physical / SOFT | typically 80–120 °C; post-exposure bake (PEB) tuned 90–130 °C | vendor datasheets; Reichmanis & Thompson *Chem. Rev.* 1989 |
| PR-L11 | ArF CAR T_g | Physical / SOFT | 110–150 °C; PEB tuned 100–140 °C | SPIE Adv. Lith. proceedings |
| PR-L12 | ArF acrylate etch-resistance (Ohnishi parameter) | Engineering / SOFT | typically 4.0–4.5 (vs novolac ~ 3.0); modulated by adamantyl / norbornyl side groups | Ohnishi et al. 1983; Allen et al. *Proc. SPIE* 2000 |
| PR-L13 | EUV resist film thickness | Engineering / HARD | **20–35 nm** typical (thinner than ArF 80–120 nm) — limited by aspect ratio + photon absorption depth | IMEC EUV roadmap |
| PR-L14 | Outgassing limit (EUV resist, for scanner protection) | Engineering / HARD | ≤ ~ 1 × 10¹³ molecules/cm² per exposure (SEMI E162 / ASML spec) | SEMI E162; ASML EUV scanner outgassing test |
| PR-L15 | PCB dry-film resist resolution | Engineering / SOFT | typical 25–50 µm line/space; advanced 15 µm | Hitachi DuPont Riston datasheet; Asahi Sunfortes datasheet |
| PR-L16 | e-beam PMMA resolution | Engineering / SOFT | ~ 10 nm half-pitch (lab); HSQ ~ 7 nm | Vieu et al. *Appl. Surf. Sci.* 2000 |
| PR-L17 | Resist storage shelf-life (refrigerated, sealed) | Engineering / SOFT | 6–12 months typical (4–8 °C) | vendor MSDS / technical |
| PR-L18 | Stannane / Sn-oxo MOR LER | Engineering / SOFT | typical 3–4 nm 3σ at 22 nm pitch (Inpria reported) | Cardineau SPIE 2014; Inpria YESR datasheet |

**Note on EUV stochastic defects (PR-L7) — NOT FULLY RESOLVED.** At
half-pitch < 16 nm, the number of EUV photons absorbed per resist
pixel is small enough that photon-shot-noise (Poisson) directly
translates into acid-distribution noise, which becomes line-edge
noise, which becomes a stochastic-defect floor (microbridges, broken
lines, missing contacts). Increasing dose lowers stochastic noise but
increases LWR via the RLS trade-off (PR-L9). This is a **material-
physics open problem** as of 2026 — IRDS 2023 lists it as the leading
EUV resist research priority. Several mitigation routes exist (MOR
metal-oxide direct-absorption, photo-decomposable quencher, low-Z
underlayer, secondary-electron-engineered backbone) but none has
clearly resolved the trade-off to < 1 defect/cm² at 16 nm pitch
production. UNVERIFIED at full commodity scale.

**Note on metal-oxide resist (PR-L6).** Inpria (acquired by JSR in
2021) commercialized tin-oxo-cluster MOR with direct EUV absorption
+ much higher etch resistance than CAR — extending pattern-transfer
budget. MOR is in production at leading-edge nodes (Samsung 3LPE,
TSMC N3) for select critical layers. Production yield UNVERIFIED at
full commodity scale.

---


Global photoresist market is ~ $5–6 B/yr (2024 industry estimates).
Concentrated supply: > 80 % from Japan (JSR / TOK / Shin-Etsu /
Sumitomo Chemical / Fujifilm). EUV resist is a particularly
concentrated subset — JSR (incl. Inpria), TOK, Shin-Etsu, Fujifilm
+ Dow (now DDP Specialty Products / DuPont) are the only producers
qualified on leading-edge EUV scanners (TSMC / Samsung / Intel).

| Producer | Material focus | Reported deployment / scale | Source |
|----------|----------------|-------------------------------|--------|
| JSR (JP) | ArF + KrF + EUV CAR; **Inpria MOR (acquired 2021)** | Top-3 globally; #1 in EUV CAR; ~ ¥130B+ EM revenue 2023 | JSR IR; Inpria acquisition press release 2021 |
| Tokyo Ohka Kogyo (TOK, JP) | ArF + KrF + EUV CAR + photopolymer thinner | Top-3 globally; ~ ¥100B+ revenue 2023 | TOK IR |
| Shin-Etsu Chemical (JP) | KrF + ArF + EUV CAR + photoresist ancillaries (anti-reflective coating) | Top-3 globally; ~ ¥200B+ EM segment 2023 | Shin-Etsu IR |
| Sumitomo Chemical (JP) | g/i-line + KrF + ArF + EUV CAR | Top-5 globally; long history (DNQ pioneer) | Sumitomo Chemical IR; *Sumitomo Kagaku* technical journal |
| Fujifilm Electronic Materials (JP) | ArF + KrF + EUV CAR + e-beam mask resist | Top-5 globally; mask-resist incumbent | Fujifilm IR |
| Dow (now DDP Specialty Products / DuPont, US) | KrF + ArF + EUV CAR | Western leader; major in dry-film PCB | DuPont IR |
| Hitachi Chemical DuPont (JV, JP) | photopolymer dry-film resist (Riston / Pentec) | Dominant PCB dry-film supplier | Hitachi Chemical DuPont datasheet |
| Asahi Kasei (JP) | photopolymer dry-film (Sunfortes / Sunfort) | Major PCB dry-film | Asahi Kasei IR |
| Inpria (now JSR subsidiary, US) | **EUV metal-oxide resist (Sn-oxo cluster)** — YESR series | Leading EUV MOR supplier; commercial 2020+ | Inpria YESR datasheet; Cardineau SPIE 2014 |
| MicroChem / Kayaku Advanced Materials (US/JP) | SU-8 negative epoxy + PMMA + HSQ for research | MEMS / academic / mask-making | Kayaku catalog |
| AZ Electronic Materials / Merck KGaA (DE) | KrF / ArF / i-line + dry-film | European leader (Merck acquired AZ EM 2014) | Merck KGaA IR |
| ChangXin / Yongsan (CN/KR) | i-line + KrF (catching-up) | Emerging Asian regional supplier | vendor public |

> **Honesty caveat (LATTICE_POLICY §3.3):** photoresist capacity is
> bounded by **monomer + PAG + quencher synthesis throughput +
> ultra-high-purity (sub-ppt metals) filtration line capacity + EUV
> qualification cycle at scanner customer** — not by lattice
> arithmetic. JSR ~ ¥130B EM revenue and TOK ~ ¥100B reflect chemical-
> plant + clean-room QC throughput, not lattice-derived. EUV resist
> production volumes are < 100 kg/yr per qualified-product SKU
> (vs g/i-line PCB resist in tons/yr).

---

## §4 STRUCT — photoresist material flow

```
[Polymer synthesis: novolac (phenol + formaldehyde) for g/i-line;
 PHS (radical polymerization of vinylphenol) for KrF;
 (meth)acrylate / COMA / norbornyl-fluorinated for ArF;
 PHS-acrylate hybrid for EUV CAR; tin-oxo-cluster for EUV MOR]
        ↓ protecting-group installation (t-BOC, t-butyl ester, acetal) for CAR
[Acid-labile protected polymer resin]
        ↓ + photoacid generator (PAG: sulfonium / iodonium / N-hydroxysuccinimide-OTf)
        ↓ + base quencher (TEA / DBN / photodecomposable amine)
        ↓ + adhesion promoter / surfactant / solvent (PGMEA, ethyl lactate)
[Formulated resist — sub-ppt metal contamination, ≤ 30 ppm Na/K/Fe each]
        ↓ ultrafiltration + ion exchange + bottle fill
[Production resist in vendor-supplied bottle (~250 mL to 4 L typical)]
        ↓ spin-coat on Si wafer / glass / PCB (resist thickness 20–800 nm)
[Resist film]
        ↓ post-apply bake (PAB) 90–130 °C (solvent removal + density)
[Stable resist film ready for exposure]
        ↓ EXPOSE (g/i/KrF/ArF/EUV photon, e-beam electron)  ← lithography process → hexa-chip
[Latent image — acid generated in exposed area for CAR; DNQ→ICA for novolac]
        ↓ post-exposure bake (PEB) — drives acid-catalyzed deprotection (CAR) or cross-link (negative)
[Patterned latent image after chemical amplification]
        ↓ develop in TMAH 2.38 wt-% aqueous (positive) or organic solvent (NTD)
[Patterned resist relief on wafer]
        ↓ pattern transfer by plasma etch / ion implant / lift-off  ← also hexa-chip process
        ↓ strip resist (O₂ plasma ash + wet clean)
[Patterned target layer (poly-Si / metal / dielectric)]
```

---

## §5 FLOW — process aspects in scope

| Process step | Material-aspect concern (this repo) | Out-of-scope (→ hexa-chip) |
|--------------|-------------------------------------|----------------------------|
| Resin + monomer synthesis | polymer chemistry, Mw, dispersity, side-group tuning | scale-up engineering |
| PAG selection | acid generation quantum yield, acid pKa, acid diffusion length | exposure tool integration |
| Quencher selection | base concentration, photodecomposable quencher acid-quench equilibrium | dose linearity at scanner |
| Formulation | resin/PAG/quencher ratio, solvent, surfactant | bottle-handling logistics |
| Filtration + purification | sub-ppt metals filtration, particle ≤ 30 nm count | clean-room class 1 supply chain |
| Spin-coat / PAB | film thickness uniformity, edge bead, T_g | spin-coat tool — track integration → hexa-chip |
| **Exposure** | resist sensitivity, contrast, photon-shot-noise | **scanner + optics + reticle → hexa-chip** |
| PEB | acid diffusion length, T_PEB window | hot-plate uniformity → hexa-chip |
| Develop | TMAH dissolution rate, NTD solvent selectivity, swelling | develop track → hexa-chip |
| **Pattern transfer** | etch-resistance Ohnishi parameter, ion-implant blocking budget | **plasma etch / implanter → hexa-chip** |
| Strip + clean | O₂ ash residue, wet-clean compatibility | strip/clean tool → hexa-chip |

---

## §6 EVOLVE — material-frontier candidates

| Mk | Frontier | Status |
|----|----------|--------|
| Mk.I | DNQ-novolac positive resist (Sus 1944; Süs / Renoir / Steppan) | Commodity (legacy) |
| Mk.II | Chemically-amplified resist for KrF (Ito, Willson, Fréchet 1982) | Foundational (IBM SU-8 origin) |
| Mk.III | ArF (193 nm) acrylate CAR (early 2000s) | Commodity at sub-130 nm node |
| Mk.IV | ArF immersion (193i) with hydrophobic top-coat | Production at 45–14 nm via multi-patterning |
| Mk.V | EUV CAR (PHS-acrylate hybrid) (TSMC N7+ from 2019) | Production at 7/5/3 nm |
| Mk.VI | EUV metal-oxide resist Inpria YESR | Production at 5/3 nm node |
| Mk.VII | Photodecomposable quencher for stochastic-defect mitigation | Production deployment partial — UNVERIFIED at full-density floor |
| Mk.VIII | High-NA EUV (NA 0.55) resist (ASML EXE:5000 era) | R&D — UNVERIFIED at production yield |
| Mk.IX | DSA (directed self-assembly) block copolymer post-pattern | R&D / production niche |
| Mk.X | Stochastic-defect-floor < 1 defect/cm² at < 16 nm pitch | UNPROVEN — research frontier |
| Mk.XI | Sub-7 nm e-beam HSQ for mask + research | Lab-only |

---

## §7 Cross-link — sibling verbs and sibling repos

| Concern | Where it lives |
|---------|----------------|
| **Semiconductor device + fab process** (lithography scanner, mask, overlay, etch, ion-implant, yield) | **`hexa-chip` (sibling — devices + fab process; material here is resist only)** |
| Polymer chemistry foundation (chain vs step growth, Mw distribution) | `POLYMER-CHEMISTRY.md`; `epoxy/epoxy.md` for cross-link prototype |
| Silicon wafer + SiO₂ + SiC + poly-Si | `silicon/silicon.md` (the material the resist patterns) |
| Compound-semiconductor wafer (GaN / SiC / GaAs / InP) | `compound-semi/compound-semi.md` |
| Negative epoxy SU-8 photopolymer for MEMS | `epoxy/epoxy.md` (cross-link to SU-8) + MEMS sibling |
| Display photoresist (color filter, BM, PI alignment) | (informational — display industry uses derivatives of i-line + KrF; flat-panel sibling — informational) |
| PCB photopolymer dry-film | (PCB sibling — out-of-repo at industry level; dry-film material lives here) |
| Polymer recycling (resist is consumed; near-zero post-use recovery) | `recycling/recycling.md` (informational only — used resist is hazardous waste) |

---

## §8 VERIFY — anchors and falsifiers

| Anchor | Source | Used for |
|--------|--------|----------|
| SEMI E162 | SEMI | PR-L14 — EUV resist outgassing |
| SEMI standards (resist chemical contamination class) | SEMI | sub-ppt metals discipline |
| IRDS 2023 lithography chapter | IEEE | PR-L7 / PR-L8 — EUV LWR + stochastic floor |
| Reichmanis & Thompson *Chem. Rev.* 89, 1273 (1989) | journal | KrF CAR foundational |
| Ito, Willson, Fréchet — *Macromolecules* 16, 510 (1983) | journal | t-BOC chemical amplification |
| Cardineau et al. — *Microelectron. Eng.* 127, 44 (2014); SPIE Adv. Lith. (2014) | journal + SPIE | EUV MOR (Inpria Sn-oxo) |
| Wallow et al. *Proc. SPIE* 6520 (2007) | SPIE | RLS Z-factor (PR-L9) |
| Mack — *Field Guide to Optical Lithography* (SPIE 2006) | textbook | PR-L1 sanity |
| Ohnishi et al. *J. Vac. Sci. Tech.* B1, 70 (1983) | journal | Ohnishi etch-resistance parameter |
| De Bisschop *J. Micro/Nanolith. MEMS MOEMS* 16, 041013 (2017) | journal | EUV stochastic defects |
| ASML EUV scanner outgassing test protocol | vendor | PR-L14 sanity |
| JSR / TOK / Shin-Etsu / Sumitomo / Fujifilm / Dow vendor datasheets | vendor | PR-L2/L3/L5/L6 sanity |
| Inpria YESR datasheet | vendor | PR-L6 / PR-L18 sanity |

**Falsifiers (engineering thresholds, NOT lattice):**

| F-ID | Trigger | Verdict |
|------|---------|---------|
| F-PR-1 | EUV resist stochastic defect-density < 1 defect/cm² at 16 nm half-pitch production yield | OPEN |
| F-PR-2 | EUV resist sensitivity < 10 mJ/cm² with LWR ≤ 2.5 nm 3σ at 16 nm pitch (RLS break) | OPEN |
| F-PR-3 | High-NA EUV (NA 0.55) resist qualified at production yield at < 12 nm half-pitch | OPEN |
| F-PR-4 | DSA block-copolymer at < 10 nm pitch in production, replacing EUV multi-patterning | OPEN |
| F-PR-5 | Sub-5 nm half-pitch e-beam resist with ≤ 1 nm LWR + commercial mask-write throughput | OPEN |
| F-PR-6 | Resist supply diversification — Western non-Japanese vendor at > 15 % EUV market share | OPEN |
| F-PR-7 | Aqueous-develop-only NTD eliminating organic-solvent develop step at production scale | OPEN |

**Anti-falsifiers (claims NOT to make):**

- ✗ "ArF 193 nm sensitivity 30 mJ/cm² fits σ·τ × 2.5" — coincidence; do not write
- ✗ "JSR / TOK / Shin-Etsu market share tracks n=6" — they have not heard of it
- ✗ "EUV stochastic defect problem is solved" — UNVERIFIED; IRDS 2023 lists it as
  the leading EUV resist research priority (PR-L7)
- ✗ "Photoresist physically determines node resolution" — false; resist + scanner +
  mask + process integration co-determine resolution. CD-SEM defect inspection
  (in hexa-chip), overlay accuracy (in hexa-chip), and mask quality (in hexa-chip)
  are equally load-bearing.
- ✗ "Photoresist owns the lithography process" — **false; this verb owns the
  MATERIAL, not the process. ASML scanner + reticle + CD-SEM live in hexa-chip
  per CROSS_LINK §3.2.**
- ✗ "EUV MOR has replaced CAR" — UNVERIFIED at full-product scope; CAR remains
  the production volume majority; MOR is critical-layer niche
- ✗ "TSMC EUV throughput is set by resist" — false; throughput is set by scanner
  source power + reticle defect inspection cycle + clean-room logistics. Resist
  sensitivity contributes but does not determine throughput.

---

## §9 Honest scope + caveats

1. **Material layer only. Device + lithography process belongs to
   `hexa-chip` per CROSS_LINK.md §3.2 — this verb owns photoresist as
   MATERIAL chemistry only.** ASML scanner throughput, TSMC yield,
   Samsung HBM-DRAM stack, reticle / CD-SEM / overlay — those are
   `hexa-chip` device-process claims; **not here**.

2. **EUV resist photon-shot-noise vs LER trade-off NOT FULLY RESOLVED
   (PR-L7, PR-L9).** This is the leading EUV resist research priority
   per IRDS 2023. Several mitigation routes exist (MOR direct
   absorption, photodecomposable quencher, secondary-electron-
   engineered backbone) but none has resolved the trade-off to < 1
   defect/cm² at 16 nm pitch production. UNVERIFIED at full commodity
   scale.

3. **MOR (Inpria Sn-oxo) yield UNVERIFIED at full commodity scale.**
   Production at TSMC / Samsung leading-edge nodes is real (2020+)
   but limited to critical layers; full-product scope deployment
   UNVERIFIED.

4. **Resist supply concentration is real.** > 80 % of qualified
   photoresist (especially EUV-grade) comes from Japan. This is a
   structural supply-chain reality, not a material-property claim;
   F-PR-6 tracks Western non-Japanese vendor market share as an
   open falsifier.

5. **Resist is consumed material — recycling near-zero.** Used
   resist is a hazardous-waste stream (TMAH developer, organic
   solvent, plasma-ashed organic). Effectively unrecyclable; circular-
   economy framing is not applicable at the photoresist level.

6. **High-NA EUV resist (NA 0.55) is UNVERIFIED at production yield.**
   ASML EXE:5000 high-NA EUV scanner is at customer install (Intel /
   imec) but resist qualification at production yield is OPEN per
   F-PR-3 (2026 status).

7. **No lattice anchoring of vendor numbers.** JSR / TOK / Shin-Etsu /
   Sumitomo / Fujifilm / Dow / Inpria capacities cited verbatim; no
   projection onto n=6.

8. **SPEC_FIRST verdict.** No numbers in this file are MEASURED in
   this repo; all from SEMI / IRDS / SPIE / vendor / peer-reviewed
   literature. Working `.hexa` numerical sandbox for photoresist is
   TBD.

9. **Coincidence disclosure (LATTICE_POLICY §1.1).** Any apparent fit
   of photoresist numbers to n=6 (e.g., ArF dose 24 mJ/cm² ≈ J₂(6))
   is coincidence with verification power zero.

---

## §10 References

- Sus O. *Justus Liebigs Ann. Chem.* 556, 65 (1944) — DNQ photochemistry origin
- Reichmanis E., Thompson L.F., "Polymer materials for microlithography,"
  *Chem. Rev.* 89, 1273 (1989) — KrF CAR foundational review
- Ito H., Willson C.G., Fréchet J.M.J., "Positive resist systems based
  on PHS protected with t-BOC and a photogenerated acid," *Macromolecules*
  16, 510 (1983) — chemical amplification founding paper
- Ohnishi Y., Itoh H., Kashiwagi K., Suzuki K., "Postdevelopment
  resist heat treatment for plasma etching durability," *J. Vac. Sci.
  Technol.* B1, 70 (1983) — Ohnishi etch-resistance parameter
- Allen R.D., Wallow T.I., Hougham G.G., Wallraff G., Sundberg L.K.,
  Sooriyakumaran R., "Materials for 193nm lithography," *Proc. SPIE*
  3999 (2000) — ArF acrylate platform review
- Cardineau B., Del Re R., Marnell M., Al-Mashat H., Vockenhuber M.,
  Ekinci Y., Sortland M., Whittaker J., Neisser M., Freedman D.A.,
  Brainard R.L., "Photolithographic properties of tin-oxo clusters
  using EUV light at 13.5 nm," *Microelectron. Eng.* 127, 44 (2014) —
  Inpria MOR foundational
- Wallow T., Higgins C., Brainard R., Petrillo K., Montgomery W.,
  Koay C.-S., Denbeaux G., Wood O., Wei Y., "Evaluation of EUV resist
  materials for use at the 32 nm half-pitch node," *Proc. SPIE* 6921,
  69211F (2008) — RLS Z-factor
- De Bisschop P., "Stochastic effects in EUV lithography: random,
  local CD variability, and printing failures," *J. Micro/Nanolith.
  MEMS MOEMS* 16, 041013 (2017) — stochastic-defect physics
- Vieu C., Carcenac F., Pépin A., Chen Y., Mejias M., Lebib A.,
  Manin-Ferlazzo L., Couraud L., Launois H., "Electron beam
  lithography: resolution limits and applications," *Appl. Surf. Sci.*
  164, 111 (2000)
- IRDS 2023 — Lithography chapter (IEEE / IRDS public release)
- Mack C.A., *Field Guide to Optical Lithography* (SPIE Press 2006) —
  textbook PR-L1
- Levinson H.J., *Principles of Lithography*, 3rd ed. (SPIE Press 2010)
- Wagner C., Harned N., "EUV lithography: lithography gets extreme,"
  *Nat. Photonics* 4, 24 (2010)
- **SEMI E162** — Test method for outgassing of resist on EUV scanner
- **SEMI** — chemical contamination class for resist
- JSR Corporation — KrF / ArF / EUV resist technical brochures; IR
  2023; Inpria acquisition press release 2021
- Tokyo Ohka Kogyo (TOK) — KrF / ArF / EUV resist technical brochures;
  IR 2023
- Shin-Etsu Chemical — KrF / ArF / EUV resist + ARC technical
  brochures; IR 2023
- Sumitomo Chemical — i-line / KrF / ArF / EUV resist + *Sumitomo
  Kagaku* technical journal
- Fujifilm Electronic Materials — ArF / EUV CAR + e-beam mask resist
- DDP Specialty Products / DuPont (formerly Dow) — KrF / ArF / EUV
  resist
- Inpria (JSR subsidiary) — YESR EUV metal-oxide resist datasheet
- Hitachi Chemical DuPont — Riston / Pentec photopolymer dry-film
- Asahi Kasei — Sunfortes / Sunfort photopolymer dry-film
- Merck KGaA / AZ Electronic Materials — KrF / ArF resist
- Kayaku Advanced Materials (formerly MicroChem) — SU-8 / PMMA / HSQ
- ASML — EUV scanner outgassing test protocol; high-NA EUV roadmap
  (EXE:5000)
- `LATTICE_POLICY.md` §1.2 + §1.3 (this repo)
- `LIMIT_BREAKTHROUGH.md` (this repo) — Wave M materials audit
- `CROSS_LINK.md` §3.2 (this repo) — hexa-chip boundary
- Cross-link siblings: `silicon/silicon.md`,
  `compound-semi/compound-semi.md`, `epoxy/epoxy.md`,
  `POLYMER-CHEMISTRY.md`, `hexa-chip` (device + lithography process)

---

*Authored 2026-05-13 by 박민우. Material-layer spec for hexa-matter's
Phase D'' `photoresist` verb (35 of 36). Real-limits-first per
LATTICE_POLICY.md §1.2; no lattice fit on photoresist parameters or
JSR / TOK / Shin-Etsu / Sumitomo / Fujifilm / Dow / Inpria vendor
capacities. **EUV resist photon-shot-noise vs LER trade-off NOT
FULLY RESOLVED** (PR-L7 + IRDS 2023). MOR full-commodity yield
UNVERIFIED. High-NA EUV resist at production UNVERIFIED. Device +
lithography process (scanner, mask, overlay, etch, CD-SEM) belongs to
`hexa-chip` per CROSS_LINK §3.2 — this verb owns the MATERIAL only.*
