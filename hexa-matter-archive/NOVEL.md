# NOVEL.md — Novel material candidates (신소재)

> **Working ledger** of de-novo-designed novel material candidates from
> hexa-matter, modeled on `hexa-bio/.roadmap.novel_drugs` pattern. Tracks
> candidates that are **not in canonical material databases** (NIST WebBook
> / CRC / Materials Project / GNoME / OMat24) at design time.
>
> **SPEC_FIRST**: entries are design hypotheses, not measurements. Per
> [`LATTICE_POLICY.md`](LATTICE_POLICY.md) §1.2/§1.3, real-limits-first.
> producers use their own metrics.
>
> Created 2026-05-13 (Wave M + Phase A-G elevation). Sister-of-pattern:
> [`hexa-bio/.roadmap.novel_drugs`](https://github.com/dancinlab/hexa-bio/blob/main/.roadmap.novel_drugs).

---

## 0. Scope boundary

**In scope**:
- De-novo-designed material *candidates* not present in MP / GNoME / OMat24
  databases at design time
- Cross-class hybrids (HEA + amorphous, MOF + 2D, perovskite + halide-SE, …)
- Targeted falsifier per candidate
- Status tracking through DESIGN → SIM → SYNTH-ROUTE → (EXTERNAL VERIFICATION)

**Out of scope** (preserved per closure framework):
- Per-verb canonical specs — these live in `<verb>/<verb>.md` (see
  [`AXIS.md`](AXIS.md) for the 29-verb taxonomy)
- Deep material chapters — see [`SILICON.md`](SILICON.md),
  [`CERAMIC-ENGINEERING.md`](CERAMIC-ENGINEERING.md),
  [`METALLURGY-DEEP.md`](METALLURGY-DEEP.md),
  [`POLYMER-CHEMISTRY.md`](POLYMER-CHEMISTRY.md),
  [`GRAPHENE-CARBON.md`](GRAPHENE-CARBON.md)
- Wet-lab synthesis + measurement — Category (c) per
  [`AXIS_CLOSURE_PLAN.md`](AXIS_CLOSURE_PLAN.md), **out-of-repo by design**
  (Wacker poly-Si / Wolfspeed SiC / Stora Enso wood / Hitachi Metals NdFeB
  carry their own measurement layer)
- Anti-claims (preserved as HARD_WALL): LK-99 room-T SC, metallic
  hydrogen at ambient, infinite-recycle, magic-MOF DAC at $100/t — see
  [`LIMIT_BREAKTHROUGH.md`](LIMIT_BREAKTHROUGH.md)

---

## 1. Naming convention

```
hxm-<class>-<target>-<NNN>
```

| Component   | Values                                                                |
|-------------|-----------------------------------------------------------------------|
| prefix      | `hxm-` (hexa-matter)                                                  |
| class-tag   | `sc` (superconductor) · `cath` (cathode) · `anode` · `se` (solid electrolyte) · `pv` (photovoltaic) · `hea` (high-entropy alloy) · `bmg` (bulk metallic glass) · `mof` · `2d` · `pero` (perovskite) · `mag` (magnetic) · `ela` (elastomer) · `adh` (adhesive) · `pol` (polymer) · `cer` (ceramic) · `cnt` (carbon nanotube) · `bio` (biodegradable polymer) · `mxene` · `meta` (metamaterial) · `top` (topological) · `aero` (aerogel) · `pcm` (phase-change material) · `liq` (liquid metal) · `cat` (catalyst) · `ferro` (ferroelectric) · `thermo` (thermoelectric) · `membrane` (gas-separation / desalination membrane) · `piezo` (piezoelectric) · `spin` (spintronic) · `quantum` (quantum-defect host) · `photovoltaic` (alias of `pv` for tandem / multi-junction stacks) |
| target-tag  | 3-6 char target identifier (composition / property goal)              |
| NNN         | 3-digit serial number per (class, target)                             |

Examples:
- `hxm-sc-cuprate-001` = hexa-matter superconductor, cuprate family, candidate #001
- `hxm-cath-licmf-001` = Li-Cu-Mn-F cathode, candidate #001
- `hxm-pv-pb-free-001` = lead-free perovskite photovoltaic
- `hxm-hea-refrac-001` = refractory HEA
- `hxm-mof-dac-001` = MOF designed for direct-air-capture
- `hxm-mag-refree-001` = rare-earth-free permanent magnet
- `hxm-bmg-zr-001` = Zr-based bulk metallic glass
- `hxm-aero-graphene-001` = graphene aerogel
- `hxm-meta-eg-001` = electromagnetic metamaterial
- `hxm-top-bisn-001` = topological insulator Bi-Sn family

---

## 2. Status pipeline

```
DESIGN  →  SIM  →  SYNTH-ROUTE  →  (EXTERNAL VERIFICATION)
   │        │           │                    │
   │        │           │                    └─ out-of-repo (Category c)
   │        │           └──────────────────── retrosynthesis sketch + step-count
   │        └───────────────────────────────── DFT / MD / FEA / MACE-OMat NNP / …
   │                                                via _python_bridge or _absorption_bridge
   └─────────────────────────────────────────── written spec in NOVEL.md
                                                + falsifier defined
```

Status tags:

| Tag                  | Meaning                                                                       |
|----------------------|-------------------------------------------------------------------------------|
| `DESIGN`             | Composition + intended phase + target property written                        |
| `SIM-DFT`            | DFT-level band structure / formation energy via pymatgen + MP comparison     |
| `SIM-MD`             | MD relaxation (ASE / LAMMPS-handle) — structural stability check            |
| `SYNTH-ROUTE`        | Retrosynthesis path proposed (literature precedent or de-novo path)          |
| `UNVERIFIED`         | Default state — Category (c) wet-lab verification not performed              |
| `WET-LAB-PROPOSED`   | Synthesis bench parameters drafted; awaiting external partner                |
| `EXTERNAL-VERIFIED`  | Out-of-repo measurement received — REQUIRES vendor / lab attribution         |
| `FALSIFIED`          | Sim or external measurement contradicts design hypothesis — keep on disk     |

(a) a real `_absorption_bridge` adapter call result hash, or (b) explicit
external lab / vendor citation. A `hxm-*` entry CANNOT claim
`EXTERNAL-VERIFIED` without an attributed measurement. Per
[`LATTICE_POLICY.md`](LATTICE_POLICY.md), the n=6 lattice MUST NOT serve
as evidence for property claims — it is an organizing tool only.

---

## 3. Candidate ledger

Format: `ID | class | target | brief | status | sim handle | falsifier`

### 3.1 Superconductors

LK-99 family **NOT REPRODUCED** (HARD_WALL per
[`LIMIT_BREAKTHROUGH.md`](LIMIT_BREAKTHROUGH.md); see
[`perovskite/perovskite.md`](perovskite/perovskite.md) anti-claim row).
Cuprate-derivative candidates remain open as **research hypotheses**, NOT
claims of working RT-SC. Real-world record (low-T): YBa₂Cu₃O₇ Tc ≈ 92 K
(LN-cooled). High-pressure H₃S Tc ≈ 203 K (Drozdov et al. 2015, but 155
GPa).

| ID                    | class | target              | brief                          | status        | falsifier                             |
|-----------------------|-------|---------------------|--------------------------------|---------------|---------------------------------------|
| `hxm-sc-cuprate-001`  | sc    | Tc > 100 K @ 1 atm  | (PLACEHOLDER — design TBD)     | DESIGN        | F-SC-1: Tc < 92 K → FALSIFIED         |
| `hxm-sc-pnictide-001` | sc    | Fe-As high-Tc       | (PLACEHOLDER — design TBD)     | DESIGN        | F-SC-1: Tc < 55 K → FALSIFIED         |
| `hxm-sc-h3s-derived-001` | sc | low-pressure H-rich | (PLACEHOLDER — design TBD)     | DESIGN        | F-SC-2: P_critical > 50 GPa → FALSIFIED |

All `hxm-sc-*` candidates currently UNVERIFIED. Real RT-SC remains
academically unproven; per [`hexa-rtsc`](https://github.com/dancinlab/hexa-rtsc)
sister substrate, this is a SPEC catalog only.

### 3.2 Battery cathodes

| ID                    | class | target              | brief                          | status        | falsifier                             |
|-----------------------|-------|---------------------|--------------------------------|---------------|---------------------------------------|
| `hxm-cath-licmf-001`  | cath  | Li-Cu-Mn-F          | Li-rich Mn-based, F-substituted | DESIGN       | F-CATH-1: capacity < 250 mAh/g → FAIL |
| `hxm-cath-ni-rich-001`| cath  | LiNi₀.₉Mn₀.₀₅Co₀.₀₅ | Co-minimized NMC variant       | DESIGN        | F-CATH-2: cycle retention < 80% @ 1000 → FAIL |
| `hxm-cath-disord-001` | cath  | DRX (disordered rocksalt) | Li-Mn-Ti-O / fluorinated     | DESIGN        | F-CATH-3: cap/voltage hysteresis > 15% → FAIL |

**Risk-flags**: Li-rich Mn-based F-substituted oxygen-redox HARD_WALL on
voltage decay (Manthiram 2020 review); Ni-rich (≥ 0.9 Ni) capacity-fade /
gas-evolution UNVERIFIED at > 1000 cycles 1C; DRX disordered-rocksalt
cation-mixing kinetics UNVERIFIED at full-cell; cell engineering (coating,
calendering, electrolyte) belongs to `hexa-energy` per CROSS_LINK §3.3 —

### 3.3 Solid electrolytes

| ID                    | class | target              | brief                          | status        | falsifier                             |
|-----------------------|-------|---------------------|--------------------------------|---------------|---------------------------------------|
| `hxm-se-argyrod-001`  | se    | Li-PS-Cl argyrodite | room-T σ > 10⁻² S/cm           | DESIGN        | F-SE-1: σ < 1e-3 S/cm @ 25°C → FAIL   |
| `hxm-se-halide-001`   | se    | Li-In-Cl₆ halide-SE | wide voltage window > 4.5 V    | DESIGN        | F-SE-2: anodic decomp < 4.0 V → FAIL  |

**Risk-flags**: argyrodite Li-PS-Cl ambient-air H₂S evolution HARD_WALL;
halide-SE cathode-interface oxidation UNVERIFIED above 4.5 V; In-supply
geopolitical concentration UNVERIFIED; Li-metal compatibility UNVERIFIED
at ≥ 500 deep cycles (pairs with `hxm-anode-sigr-001` cycle target);
cell-level integration owned by `hexa-energy` per CROSS_LINK §3.3.

### 3.4 Photovoltaic absorbers

| ID                    | class | target              | brief                          | status        | falsifier                             |
|-----------------------|-------|---------------------|--------------------------------|---------------|---------------------------------------|
| `hxm-pv-pb-free-001`  | pv    | Cs-Sn-I₃            | lead-free perovskite, > 20% PCE | DESIGN       | F-PV-1: PCE < 15% (lab) → FAIL        |
| `hxm-pv-tandem-001`   | pv    | Si + perovskite     | 4-terminal tandem > 33% PCE    | DESIGN        | F-PV-2: stability < 1000 h MPP → FAIL |

LK-99 PV variants and HARD_WALL claims preserved
([`PEROVSKITE.md`](PEROVSKITE.md)).

### 3.5 Magnetic materials (rare-earth-free)

**Verb spec link**: see [`magnetic-materials/magnetic-materials.md`](magnetic-materials/magnetic-materials.md) — material-layer authority for all `hxm-mag-*` candidates in this section (REE-free permanent-magnet chemistry).

| ID                    | class | target              | brief                          | status        | falsifier                             |
|-----------------------|-------|---------------------|--------------------------------|---------------|---------------------------------------|
| `hxm-mag-refree-001`  | mag   | Fe₁₆N₂ thin-film    | (BH)max > 35 MGOe              | DESIGN        | F-MAG-1: (BH)max < 25 MGOe → FAIL     |
| `hxm-mag-mnbi-001`    | mag   | MnBi LTP            | Tc > 300°C + high Hc           | DESIGN        | F-MAG-2: Hc < 0.5 T @ 200°C → FAIL    |
| `hxm-mag-tetra-001`   | mag   | tetrataenite        | meteoritic FeNi → terrestrial   | DESIGN        | F-MAG-3: ordered phase fraction < 50% → FAIL |
| `hxm-mag-boride-001`  | mag   | (FeCoNiMnCr)₂B C16 boride | C16 = I4/mcm CuAl₂-type; named film (FeCoNiMn)₂B a=5.05/c=4.25 Å (Beeson Adv. Mater. 2025, DOI 10.1002/adma.202516135); **CHGNet relax of (FeCoNiMn)₂B C16 ordered approximant — stable (a→5.02 Å), abs-magmom 0.64 μB/atom** — see `predictions/hxm-mag-boride-001.json` | SIM-NNP | F-MAG-4: thin-film K₁ < 1.0 MJ/m³ at 300 K OR bulk-scale synthesis not demonstrated → FAIL |
| `hxm-mag-mn2sb-001`   | mag   | Mn₂Sb tetragonal    | arxiv:2507.01849 top-10 (pred Ms=1.76 T, K=1.57 MJ/m³, Tc=2270 K); **MP mp-20664 confirms P4/nmm tetragonal, FM ordering, E_hull=0 (stable), M=15.16 μB** | SIM-DFT | F-MAG-9: measured K < 0.8 MJ/m³ OR Tc < 600 K → FAIL |
| `hxm-mag-mnalc-001`   | mag   | Mn₅₅Al₄₄C₁ τ-phase  | L1₀ ordered intermetallic, REE-free + Co-free | DESIGN | F-MAG-5: sintered (BH)max < 6 MGOe OR τ-phase fraction < 80% after 100 thermal cycles → FAIL |
| `hxm-mag-ferrhd-001`  | mag   | SrFe₁₂O₁₉ Co/La-doped | high-density anisotropic M-type hexaferrite | DESIGN | F-MAG-6: (BH)max < 6 MGOe OR Hc decay > 15% after 1000 h @ 200 °C → FAIL |
| `hxm-mag-lowdy-001`   | mag   | (Nd,Ce,La)₂Fe₁₄B    | heavy-REE (Dy/Tb) content ≤50% of baseline, GB-engineered | DESIGN | F-MAG-7: Hc loss > 15% at 150°C vs commercial NdFeB baseline → FAIL |
| `hxm-mag-aifound-001` | mag   | FeCo₂Ge (Heusler-like) | NEMAD Table 4 top REE-free FM (pred Tc ≈ 1000-1070 K, 3-model); **MP mp-22300 confirms Fm-3m full Heusler, FM ordering, E_hull=0 (stable), M=6.0 μB** | SIM-DFT | F-MAG-8: experimentally-measured Tc < 600 K OR not synthesizable at single-phase purity > 90% → FAIL |
| `hxm-mag-gfcs-001`    | mag   | Ga₃Fe₄Co₈Si         | NEMAD Table 4 **highest-Tc** REE-free FM (pred Tc ≈ 1010-1150 K, 3-model); **MP mp-1225352 confirms R-3m, FM ordering, E_hull=0 (stable)** | SIM-DFT | F-MAG-10: experimentally-measured Tc < 700 K OR not single-phase synthesizable → FAIL |
| `hxm-mag-znfe-001`    | mag   | ZnFe tetragonal     | arxiv:2507.01849 top-10 (pred Ms=1.15 T, κ=0.85); MP mp-1215473 (P4/mmm, FM, E_hull=0.023 — DFT-metastable) | DESIGN | F-MAG-11: measured κ < 0.5 OR not single-phase synthesizable → FAIL |

All entries UNVERIFIED at production. NdFeB/SmCo gold standards via
Hitachi Metals / TDK / Vacuumschmelze / Shin-Etsu / Arnold — their

**Sim handles (2026-05-17)**: `hxm-mag-mn2sb-001` ↔ Materials Project
`mp-20664` (P4/nmm tetragonal, FM, E_hull=0, M=15.16 μB) — note the
arxiv:2507.01849 "Mn₂Sb tetragonal" candidate matches the P4/nmm polymorph,
NOT the metastable `mp-6912` (P6₃/mmc) or `mp-1008875` (F-43m). `hxm-mag-aifound-001`
↔ MP `mp-22300` (Fm-3m full Heusler, FM, E_hull=0, M=6.0 μB). Retrieved via
MP REST summary API direct call — the `_absorption_bridge/materials_project/mp_api_smoke.py`
adapter was bypassed due to a pymatgen 2024.8.9 ↔ emmet-core 0.84.6rc4
version conflict on Python 3.9 (`SymmetryUndeterminedError` import failure).
**SIM-DFT status reflects MP's DFT-computed magnetic ordering + formation
energy only** — Tc and (BH)max remain UNVERIFIED: MP carries no Curie
temperature, and the Tc figures cited above are ML-regressed (NEMAD) or
separate-DFT (arxiv:2507.01849) predictions, NOT measurements (per @F f2 /
g3). `hxm-mag-boride-001` → **SIM-NNP** (2026-05-18): the disordered quinary
(FeCoNiMnCr)₂B of Beeson 2025 has no single MP record, so a CHGNet 0.4.2
relaxation was run on ubu-1 (RTX 5070) for the **ordered (FeCoNiMn)₂B C16
approximant** (the named-film composition of Beeson 2025) — it relaxes
stably (a 5.05→5.02 Å, within 0.5% of the Beeson 2025 film) and retains a
non-zero magnetic moment (abs-magmom 0.64 μB/atom; Fe₂B control 1.32). This
is a real universal-FF computation, NOT a measurement: CHGNet does not
resolve FM/AFM ordering or K₁, and the approximant is quaternary-ordered,
not the disordered quinary candidate — so F-MAG-4 (thin-film K₁ / bulk
synthesis) stays UNVERIFIED and the wet-lab handoff
(`CLOSURE_RESIDUAL_BACKLOG.md` §C-MET C-MET-3) remains open.

### 3.6 High-Entropy Alloys (HEA)

| ID                    | class | target              | brief                          | status        | falsifier                             |
|-----------------------|-------|---------------------|--------------------------------|---------------|---------------------------------------|
| `hxm-hea-refrac-001`  | hea   | W-Mo-Ta-Nb-V        | refractory, T > 1500°C creep   | DESIGN        | F-HEA-1: creep rate > 1e-7 /s @ 1500°C → FAIL |
| `hxm-hea-cantor-001`  | hea   | CrMnFeCoNi variant  | optimized strength + ductility | DESIGN        | F-HEA-2: σy/εf trade < benchmark → FAIL |
| `hxm-hea-light-001`   | hea   | Al-Ti-V-Cr-Mn       | lightweight HEA, ρ < 5 g/cm³   | DESIGN        | F-HEA-3: ρ > 5.5 g/cm³ → FAIL         |

**Risk-flags**: refractory W-Mo-Ta-Nb-V brittle-to-ductile transition
UNVERIFIED at scale; Cantor σy/εf benchmark fragmented across multiple
labs (Cantor 2004, Yeh 2004, Senkov 2010 — no single normalized dataset);
lightweight Al-Ti-V-Cr-Mn phase stability UNVERIFIED above 300 °C;
arc-melt vs. additive-manufactured microstructure variance HARD_WALL;
production-scale availability UNVERIFIED.

### 3.7 MOF for direct-air-capture (DAC)

| ID                    | class | target              | brief                          | status        | falsifier                             |
|-----------------------|-------|---------------------|--------------------------------|---------------|---------------------------------------|
| `hxm-mof-dac-001`     | mof   | amine-functionalized| CO₂ capacity > 4 mmol/g @ 400 ppm | DESIGN     | F-MOF-DAC-1: capacity < 1.5 mmol/g → FAIL |
| `hxm-mof-dac-002`     | mof   | Mg-MOF-74 derivative| cyclic stability > 10000 cycles | DESIGN       | F-MOF-DAC-2: cap loss > 20% @ 5000 cyc → FAIL |

**HARD_WALL preserved**: $100/t DAC economics UNPROVEN. Climeworks
amine-on-MOF baseline at $600-1000/t (per [`MOF.md`](MOF.md)).

### 3.8 2D heterostructures

| ID                    | class | target              | brief                          | status        | falsifier                             |
|-----------------------|-------|---------------------|--------------------------------|---------------|---------------------------------------|
| `hxm-2d-mosi2n-001`   | 2d    | MoSi₂N₄             | predicted in MP / GNoME — verify | DESIGN      | F-2D-1: mobility < 100 cm²/V·s → FAIL |
| `hxm-2d-cri3-stack-001` | 2d  | CrI₃ + hBN + WSe₂   | layered magnetic-2D heterostack | DESIGN       | F-2D-2: T_c < 50 K → FAIL             |

**Risk-flags**: MoSi₂N₄ predicted in MP / GNoME but **PREDICTED ≠ MEASURED**
per `_absorption_bridge/gnome/SOURCES.md`; CrI₃ stacking moiré-twist
mobility UNVERIFIED at wafer scale; CVD wafer-scale 2D growth HARD_WALL
on grain-boundary density; air-stability of CrI₃ HARD_WALL (degrades on
the order of hours at ambient); device-layer integration belongs to
`hexa-chip` per CROSS_LINK §3.2.

### 3.9 Phase-change materials (PCM)

| ID                    | class | target              | brief                          | status        | falsifier                             |
|-----------------------|-------|---------------------|--------------------------------|---------------|---------------------------------------|
| `hxm-pcm-gst-001`     | pcm   | GST + dopant        | < 1 ns set time, > 10¹² cycles | DESIGN        | F-PCM-1: set > 5 ns → FAIL            |
| `hxm-pcm-sbte-001`    | pcm   | Sb₂Te variant        | high contrast for photonic switching | DESIGN  | F-PCM-2: optical contrast < 30% → FAIL |

**Risk-flags**: GST resistance drift HARD_WALL (Boniardi 2010 fundamental
amorphous-state structural relaxation); set-time vs. cycle-endurance
trade-off UNVERIFIED at < 1 ns set + > 10¹² endurance simultaneously;
Sb-Te crystallization-temperature window narrow → archival retention
UNVERIFIED at 85 °C; photonic-switching optical contrast assumes
short-pulse melt-quench cycle UNVERIFIED at integrated-waveguide scale;
device-integration belongs to `hexa-chip` per CROSS_LINK §3.2.

### 3.10 Carbon (CNT yarn / lonsdaleite / carbyne)

| ID                    | class | target              | brief                          | status        | falsifier                             |
|-----------------------|-------|---------------------|--------------------------------|---------------|---------------------------------------|
| `hxm-cnt-yarn-001`    | cnt   | continuous SWCNT yarn | > 10 GPa @ commercial-spool   | DESIGN        | F-CNT-1: production strength < 3 GPa → FAIL |

**HARD_WALL**: CNT yarn 80 GPa = lab mm-scale; commercial 1-3 GPa
preserved verbatim ([`carbon/carbon.md`](carbon/carbon.md) and
[`GRAPHENE-CARBON.md`](GRAPHENE-CARBON.md)). Lonsdaleite, carbyne,
diamond-as-semi wafer all UNVERIFIED.

### 3.11 Metamaterials (engineered EM / acoustic / mechanical)

| ID                    | class | target              | brief                          | status        | falsifier                             |
|-----------------------|-------|---------------------|--------------------------------|---------------|---------------------------------------|
| `hxm-meta-neg-001`    | meta  | negative-index EM   | n_eff < 0 at λ = 1550 nm       | DESIGN        | F-META-1: loss > 5 dB/wavelength → FAIL |
| `hxm-meta-cloak-001`  | meta  | partial cloak       | (PLACEHOLDER — visibility ratio TBD) | DESIGN  | F-META-2: cross-section reduction < 50% → FAIL |
| `hxm-meta-acoustic-001` | meta | phononic crystal   | sub-Hz dispersion engineering  | DESIGN        | F-META-3: bandgap fractional width < 10% → FAIL |

**Risk-flags**: negative-index metamaterial absorption-loss HARD_WALL
(Pendry-Smith split-ring intrinsic Ohmic loss); broadband cloaking is
fundamentally narrow-band UNVERIFIED for visible spectrum; phononic
sub-Hz bandgap requires sample dimension UNVERIFIED at compact form
factor; fabrication tolerance at sub-wavelength feature size HARD_WALL
at λ < 500 nm; all entries UNVERIFIED at engineering deployment scale.

### 3.12 Topological insulators / superconductors

| ID                    | class | target              | brief                          | status        | falsifier                             |
|-----------------------|-------|---------------------|--------------------------------|---------------|---------------------------------------|
| `hxm-top-bi2se3-001`  | top   | doped Bi₂Se₃        | room-T surface conductivity    | DESIGN        | F-TOP-1: SS contribution < 30% → FAIL |
| `hxm-top-sn-001`      | top   | Sn-based TI         | predicted in MP — verify       | DESIGN        | F-TOP-2: bulk bandgap < 0.1 eV → FAIL |
| `hxm-top-majorana-001`| top   | Majorana platform   | TI + s-SC hybrid                | DESIGN        | F-TOP-3: zero-bias peak signature absent → FAIL |

**HARD_WALL**: Majorana fermion identification HOTLY DEBATED (Microsoft
Station Q retractions 2018-2024). Preserved as UNVERIFIED.

### 3.13 Bulk metallic glasses (BMG)

Hypothesis: amorphous Zr-Cu-Al-Ni glass-formers can extend supercooled
liquid region ΔTx and reach larger critical casting thickness Dc than
Vitreloy-1 (Zr₄₁.₂Ti₁₃.₈Cu₁₂.₅Ni₁₀Be₂₂.₅, Dc ~ 25 mm, Johnson 1996 Caltech).
Be-free chemistries with minor lanthanide micro-alloying are the open
search axis. Status starts at DESIGN.

| ID                    | class | target              | brief                          | status        | falsifier                             |
|-----------------------|-------|---------------------|--------------------------------|---------------|---------------------------------------|
| `hxm-bmg-zr-001`      | bmg   | Zr-Cu-Al-Ni-Y       | Be-free Vitreloy alternative; Dc > 30 mm at Y ~ 0.5 at% | DESIGN | F-BMG-1: Dc < 10 mm in arc-melt + suction-cast → FAIL |

**Risk-flags**: thermodynamic GFA (γ, Δ, Trg) not yet computed via
`_python_bridge/metallurgy_alloy_composition.py`; oxide-pickup during
arc-melt UNVERIFIED; cyclic-fatigue / shear-band cracking statistics
UNVERIFIED. SPEC_FIRST only.

### 3.14 Aerogels (ultralow-density solids)

Hypothesis: graphene-oxide / cellulose-nanofiber hybrid aerogels can
combine sub-10 mg/cm³ density with > 1 MPa compressive recovery, beating
classic silica aerogel (ρ ~ 3-150 mg/cm³ but brittle; Kistler 1931 / NASA
JPL). Open question: can the cellulose-nanofiber scaffold survive
supercritical-CO₂ drying without densification > 20%? Status DESIGN.

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-aero-graphene-001`  | aero  | rGO + CNF hybrid    | ρ < 10 mg/cm³; recoverable > 80% strain | DESIGN | F-AERO-1: density > 30 mg/cm³ OR recovery < 50% after 10⁴ cycles → FAIL |

**Risk-flags**: SCD shrinkage UNVERIFIED; thermal-conductivity target
< 25 mW/m·K UNVERIFIED; fire-retardancy via phytate cross-linker
UNVERIFIED; not in MP/GNoME (amorphous network outside crystalline
prediction scope per [`_absorption_bridge/gnome/SOURCES.md`](_absorption_bridge/gnome/SOURCES.md)).

### 3.15 MXenes (2D transition-metal carbides/nitrides)

Hypothesis: Ti₃C₂Tₓ MXenes with mixed -O/-F/-OH surface terminations,
processed via fluorine-free LiF/HCl etching, can sustain EMI shielding
effectiveness > 80 dB at < 100 µm thickness while resisting oxidative
degradation longer than vanilla Ti₃C₂Tₓ (which dies in days at ambient
RH). Open: terminations after MAX-phase etching are
stoichiometry-controlled? Status DESIGN.

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-mxene-ti3c2-001`    | mxene | Ti₃C₂Tₓ (-O,-F,-OH) | EMI SE > 80 dB; 6-month ambient RH oxidative stability | DESIGN | F-MXENE-1: σ loss > 50% after 30 d @ 25 °C / 60% RH → FAIL |
| `hxm-mxene-mo2c-001`     | mxene | Mo₂CTₓ              | HER catalyst, η < 100 mV @ 10 mA/cm² | DESIGN | F-MXENE-2: η > 200 mV @ 10 mA/cm² in 0.5 M H₂SO₄ → FAIL |

**Risk-flags**: HF-free synthesis route UNVERIFIED at gram scale;
terminations not deterministic post-etch; long-term oxidative pathway
(Ti₃C₂ → TiO₂ + amorphous C) HARD_WALL at high RH per Gogotsi 2023
preprint corpus surfaced by `_research_bridge/arxiv/`.

### 3.16 Biomaterials / biodegradable polymers

Hypothesis: PHA copolymer (P3HB-co-3HHx) blended with chitin nanowhiskers
can pass ASTM D7081 marine-biodegradability AND ASTM D6400 industrial
compost simultaneously while keeping film tensile strength > 25 MPa.
Open: chitin filler typically reduces tensile by 20-40%; biodegradation
rate in marine vs. compost is a known trade-off (NatureWorks / Danimer
empirical curves, not lab-replicated here). Status DESIGN.

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-bio-pha-marine-001` | bio   | P3HB-co-3HHx + chitin nano | marine + compost dual-cert film | DESIGN | F-BIO-1: marine BOD₂₈ < 60% OR tensile < 15 MPa → FAIL |

**Risk-flags**: marine-biodegradability UNVERIFIED for most blends (only
specific PHA grades carry D7081); chitin filler dispersion may collapse
to micro-agglomerates above 5 wt%; melt-processing window narrows;
mass-balance vs. additive leaching UNVERIFIED. NatureWorks PLA / Danimer

### 3.17 Liquid-metal alloys (room-T gallium-based)

Hypothesis: a Ga-In-Sn-Bi quaternary can depress Tm below 0 °C while
keeping surface tension < 500 mN/m and oxide-skin thickness < 5 nm under
ambient. EGaIn baseline: Ga₇₅In₂₅ Tm ≈ 15.5 °C; Galinstan (Ga₆₈In₂₂Sn₁₀)
Tm ≈ -19 °C, σ ≈ 533 mN/m (vendor: Geratherm Medical / RGMD). Open: Bi
addition risks segregation. Status DESIGN.

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-liq-gain-001`       | liq   | Ga-In-Sn-Bi         | Tm < -25 °C; σ < 450 mN/m; recovery > 95% on stretch-test | DESIGN | F-LIQ-1: Tm > -10 °C OR Bi segregation > 5 vol% on DSC → FAIL |

**Risk-flags**: GaAl-Au amalgamation contamination of test fixtures
known issue; oxide-skin (Ga₂O₃) re-forms < 1 s in air — wettability vs.
substrate UNVERIFIED; biocompatibility UNVERIFIED for skin contact;
Galinstan vendor (Geratherm) sole-source pricing UNVERIFIED at scale.

### 3.18 Lithium-ion anodes (Si-graphite composite)

Hypothesis: nano-Si (D₅₀ ~ 100 nm) embedded in graphite matrix with
in-situ-grown elastic SEI from FEC + VC additives can hold > 600 mAh/g
reversible capacity for > 500 cycles at 1C without > 30% volume swelling
at electrode level. Vendor authority: Sila Nanotechnologies / Group14 /
Amprius (their published numbers govern at production).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-anode-sigr-001`     | anode | Si-graphite + FEC-SEI | capacity > 600 mAh/g @ 1C for > 500 cycles | DESIGN | F-ANODE-1: cap retention < 70% after 500 cyc @ 1C → FAIL |

**Risk-flags**: SEI re-formation rate vs. FEC consumption UNVERIFIED at
cell level; nano-Si pulverization at > 15 wt% Si still open; cost-parity
to graphite ($/kWh) HARD_WALL; full-cell vs. half-cell discrepancy
typically 20-30% in cycle life. Pairs with `hxm-cath-*` for full-cell
spec (out-of-repo per Category (c)).

### 3.19 Non-PGM ORR catalysts (Fe-N-C atomically-dispersed)

Hypothesis: an Fe-N-C catalyst with atomically-dispersed Fe-N₄ sites on
hierarchical porous carbon, derived from a Zn/Fe bimetallic ZIF precursor
pyrolyzed at 950 °C under Ar then NH₃-activated, can reach acid-PEMFC
ORR half-wave potential E₁/₂ ≥ 0.85 V vs. RHE in 0.5 M H₂SO₄ while
keeping ≤ 30 mV degradation after 30 k AST cycles (0.6–1.0 V, O₂).
Vendor / lab authority: Zelenay group (LANL), Wu group (UB), Pivovar
(NREL), Atanassov (UC Irvine), Dodelet (INRS, pioneering Fe-N-C corpus
since 2009 Science) — their published EXAFS / Mössbauer / RDE data

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-cat-fenc-001`       | cat   | Fe-N₄/C (Zn-Fe-ZIF derived) | acid-PEMFC ORR E₁/₂ ≥ 0.85 V vs. RHE; ≤ 30 mV loss @ 30k AST | DESIGN | F-CAT-1: E₁/₂ < 0.80 V vs. RHE in 0.5 M H₂SO₄ rotating-disk at 1600 rpm OR EXAFS-falsifier — Fe K-edge first-shell coordination ≠ 4 N at R ≈ 2.0 Å, or Fe-Fe scatter > 5% of Fe-N intensity (indicates clustered Fe rather than atomically-dispersed Fe-N₄) → FAIL |

**Risk-flags**: Fenton-active Fe leaching under operating PEM conditions
HARD_WALL (degrades ionomer); MEA-level vs. RDE half-cell discrepancy
typically 30–50% in mass activity (Pivovar 2020 J. Electrochem. Soc.);
NH₃-activation step adds N-content but can volatilize active sites;
$/kW parity to Pt/C UNPROVEN at MEA stack scale. Anti-claim preserved:
no atomically-dispersed Fe-N-C has yet matched Pt/C 4-electron ORR
selectivity (1–2% H₂O₂ yield) at long-term stability per DOE 2025
hydrogen-fuel-cell milestone.

### 3.20 Ferroelectric thin films (HfO₂-ZrO₂)

Hypothesis: a Hf₀.₅Zr₀.₅O₂ (HZO) thin film, ALD-deposited at 280 °C
between TiN electrodes with a 10-nm film thickness and rapid thermal
anneal at 500 °C in N₂, can stabilize the metastable orthorhombic
Pca2₁ (o-phase) ferroelectric phase with remanent polarization
P_r ≥ 25 µC/cm² AND endurance ≥ 10¹¹ cycles at ±3 V before wake-up /
fatigue degrades P_r by > 30%. Vendor / lab authority: Böscke (NaMLab/
Dresden 2011, original HZO ferroelectric discovery), Mikolajick group
(NaMLab/TU Dresden), Tsinghua HfZrO ferroelectric memory group,
GlobalFoundries 22FDX FeFET, Ferroelectric Memory Company (FMC) —
Status DESIGN.

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-ferro-hzo-001`      | ferro | Hf₀.₅Zr₀.₅O₂ / TiN | 10-nm o-phase HZO; P_r ≥ 25 µC/cm²; endurance ≥ 10¹¹ cyc @ ±3 V | DESIGN | F-FERRO-1: P_r < 15 µC/cm² at 10 nm OR endurance < 10⁹ cycles before P_r fatigues > 30% OR 10-yr retention extrapolation falls < 60% of initial P_r at 85 °C → FAIL |

**Risk-flags**: o-phase stabilization is geometry / electrode /
thickness / cap-layer dependent — thinning < 5 nm or thickening > 30 nm
loses ferroelectricity (NaMLab 2018 review); wake-up effect (P_r grows
in first 10³–10⁵ cycles) NOT a defect but precursor distinction, can
mask early fatigue; imprint shift > 0.3 V after 10⁸ cycles common; CMOS
back-end thermal-budget compatibility (≤ 500 °C) UNVERIFIED for
high-volume embedded-FeRAM nodes. Tsinghua HZO group's published P_r ~
20–30 µC/cm² typical; this candidate's ≥ 25 µC/cm² is an aspirational
upper-quartile target, not a record claim.

### 3.21 Thermoelectrics (SnSe polycrystalline)

Hypothesis: a Na-doped polycrystalline SnSe (Sn₀.₉₈Na₀.₀₂Se) with
controlled grain orientation along the b-axis via hot-pressing of
mechanically-alloyed nanoparticles can sustain dimensionless figure-
of-merit ZT ≥ 2.0 at 800 K along the in-plane direction, while keeping
mechanical strength σ_compressive ≥ 50 MPa (single-crystal SnSe is too
brittle for module integration; Zhao 2014 Nature single-crystal ZT ~
2.6 at 923 K is UNREPRODUCED at polycrystalline scale per multiple
retraction/reanalysis cycles 2016–2021). Lab authority: Kanatzidis
group (Northwestern), Zhao/Tian-Xiang SnSe group (SUSTech / Beihang),
Snyder group (Northwestern), Pei group (Tongji), Wuttig group (Aachen)
— their published ZT(T) curves with explicit κ_lat ± error bars govern

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-thermo-snse-001`    | thermo| Sn₀.₉₈Na₀.₀₂Se polycrystal | b-axis textured hot-pressed; ZT ≥ 2.0 @ 800 K | DESIGN | F-THERMO-1: in-plane ZT < 1.5 @ 800 K via 4-probe + laser-flash on independently-measured pellet (≥ 3 labs, ZT_avg) OR thermal conductivity κ_total > 0.8 W/m·K @ 800 K (indicates phonon-scattering target missed) OR mechanical σ_compressive < 30 MPa → FAIL |

**Risk-flags**: SnSe single-crystal ZT > 2.5 record HARD_WALL not
reproduced at polycrystal; ultra-low κ_lat ~ 0.2 W/m·K in single
crystals often turns into 0.5–0.7 W/m·K polycrystal (grain-boundary
phonons added); Se volatilization above 700 K in air UNVERIFIED for
long-duration modules (oxidation to SnO₂ + SeO₂ at hot-end); module-
level ZT typically 30–50% below pellet ZT due to contact resistance
(Cu/Ni metallization to SnSe interfacial layer UNVERIFIED at MTBF
scale). Vendor authority: Marlow Industries / Ferrotec / European
Thermodynamics on Bi₂Te₃ modules — SnSe modules NOT yet commercial.

### 3.22 Gas-separation membranes (MOF mixed-matrix)

Hypothesis: a ZIF-8 / 6FDA-DAM mixed-matrix membrane (MMM) with 30
wt% ZIF-8 loading, prepared by in-situ ZIF growth in polymer dope
followed by phase-inversion casting, can simultaneously achieve H₂
permeance ≥ 500 GPU AND H₂/N₂ selectivity ≥ 100 at 35 °C, 4 bar
feed pressure, while resisting plasticization at CO₂ partial pressure
up to 10 bar (CO₂/CH₄ selectivity loss < 20%). Vendor / lab authority:
KAUST advanced membranes group (Pinnau, Han, Lai), MTR Inc. (Membrane
Technology and Research) polyimide membranes, Air Products /
Helmholtz-Zentrum Geesthacht MMM corpus, Sandia ZIF-8 membrane group
Status DESIGN.

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-membrane-zif8-001`  | membrane | ZIF-8 / 6FDA-DAM MMM | 30 wt% loading; H₂ permeance ≥ 500 GPU; H₂/N₂ sel ≥ 100 | DESIGN | F-MEMBRANE-1: H₂ permeance < 200 GPU at 35 °C 4 bar OR H₂/N₂ selectivity < 50 (below 2008 Robeson upper bound) OR ZIF-8 sieve-in-cage interface void (revealed by SEM cross-section or filler-polymer adhesion via gas-permeance pressure-decay deviation > 25%) → FAIL |

**Risk-flags**: MMM filler-polymer interface void is the #1 failure
mode — voids destroy selectivity by Knudsen short-circuit; ZIF-8
aperture 3.4 Å is gate-flexible (CO₂ ~ 3.3 Å, N₂ ~ 3.64 Å can both
pass under elevated pressure breathing); long-term plasticization at
high-pressure CO₂ HARD_WALL for glassy polyimide hosts (Koros 2017
review); scale-up from coupon to hollow-fiber module loses ~ 50% flux
typically. KAUST membrane group is reference for top-quartile MMM
fabrication; commercial vendor (MTR, Air Liquide MEDAL) hollow-fiber
polyimide selectivity baseline H₂/N₂ ~ 50–80.

### 3.23 Quantum-defect hosts (4H-SiC silicon-vacancy color center)

Hypothesis: the negatively-charged silicon vacancy V_Si⁻ in 4H-SiC,
generated by 2 MeV electron irradiation (10¹³ e⁻/cm²) of
isotopically-purified ²⁸Si ²⁹Si-depleted ¹²C ¹³C-depleted 4H-SiC,
followed by 600 °C anneal in Ar, can sustain spin-coherence time
T₂ ≥ 1 ms at 300 K under dynamical-decoupling (CPMG-N, N up to 256
pulses) while preserving optically-detected magnetic resonance
contrast ≥ 1%. Lab authority: Awschalom group (U. Chicago / Argonne
QIS center) — original V_Si⁻ qubit demonstrations in 4H-SiC at room
temperature 2015 Nat. Mater.; Wrachtrup group (Stuttgart) — NV-center
comparison; Son/Janzen group (Linköping) for SiC growth; STMicro and
Status DESIGN.

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-quantum-sicvv-001`  | quantum | V_Si⁻ in ²⁸Si/¹²C-enriched 4H-SiC | room-T spin qubit; T₂ ≥ 1 ms @ 300 K with CPMG-N=256 | DESIGN | F-QUANTUM-1: Hahn-echo T₂ < 100 µs at 300 K OR CPMG-256 T₂ < 1 ms OR ODMR contrast < 0.3% at 300 K OR isotopic enrichment fails to suppress nuclear-spin bath below natural-abundance baseline (¹³C 1.1%, ²⁹Si 4.7%) → FAIL |

**Risk-flags**: room-T T₂ in natural-abundance 4H-SiC currently ~ 70
µs (Soltamov 2019 Nat. Commun.); reaching ms requires both isotopic
enrichment (²⁸Si, ¹²C) AND dynamical-decoupling — neither is
commercially turn-key; isotopically-enriched ²⁸SiC growth UNVERIFIED
at wafer scale (Si ²⁸Si CVD precursors available from Urenco/Eagle
Picher but ¹²C feedstock for SiC growth is research-scale only);
electron-irradiation damage at 2 MeV introduces unwanted V_C and
divacancy defects competing with V_Si⁻; integrated-photonic coupling
to V_Si⁻ ZPL at 916 nm HARD_WALL — only ~ 6% photons in zero-phonon
line vs. NV-diamond ~ 3%, comparable but still small. NV-diamond
sister candidate (not yet in ledger) would target T₂ > 1 ms at 300 K
already demonstrated (Bar-Gill 2013) — SiC is preferred here for
CMOS-compatibility (4H-SiC power-device wafers from Wolfspeed /
STMicro / Infineon / ROHM scale).

---

## 4. Round 3 — additional candidates (2026-05-13)


Round-3 expansion per [`NOVEL_ROADMAP.md`](NOVEL_ROADMAP.md) §3. Each
candidate ships at status `DESIGN` with a quantitative falsifier and a
risk-flags paragraph (per `selftest/cross_link_integrity_audit.py` B1–B4
numbers; vendor citations verbatim; UNPROVEN markers preserved.
Sister-domain hand-offs annotated where the cell-engineering /
device-integration layer belongs to a sister substrate (per
[`CROSS_LINK.md`](CROSS_LINK.md)).

### 4.A Energy storage

19 candidates spanning battery cathodes (DRX rock-salt · Li-S · Na-ion ·
K-ion Prussian-blue), advanced anodes (Li-metal · Na hard-carbon ·
Wadsley-Roth Nb-oxide), thiophosphate / argyrodite / halide solid
electrolytes, perovskite-Si and all-perovskite tandems plus kesterite /
OPV / CdTe single-junction PV, SOFC + AEM fuel-cell membranes, organic
redox-flow, and MXene supercapacitors. Cell-engineering belongs to
hexa-energy per CROSS_LINK §3.3 — this ledger owns the active-material
layer only.

#### 4.A.1 Li-Mn-Nb-Ti DRX rock-salt cathode

Hypothesis: a Li-rich disordered rock-salt cathode of Li₁.₂Mn₀.₅Nb₀.₂Ti₀.₁O₂
chemistry, sintered at 950 °C in air, can sustain ≥ 280 mAh/g specific
capacity at 0.1C with average discharge voltage ≥ 3.4 V vs Li/Li⁺ in
1M LiPF₆ EC/DMC. Vendor authority: Wolverton (Northwestern) for DRX
design space; CATL / BYD for commodity-cathode scale.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-bat-cath-drx-001` | bat-cath | Li-Mn-Nb-Ti DRX rock-salt | Li-rich disordered rock-salt, Nb/Ti co-substituted | SIM-NNP-PROXY | F-BAT-CATH-1: capacity < 280 mAh/g @ 0.1C OR avg V < 3.4 V vs Li/Li+ in 1M LiPF6 EC/DMC → FAIL |

**Risk-flags**: oxygen-loss HARD_WALL on 1st cycle (Lee 2014 + Manthiram
2020 review — oxygen redox is intrinsic to high-cap DRX); Mn dissolution
UNVERIFIED at extended cycling above 4.4 V; cation-mixing kinetics
UNVERIFIED at full-cell; cell engineering belongs to hexa-energy per
— predicted value vendored as `_absorption_bridge/universal_ff/predictions/hxm-bat-cath-drx-001.json`;
**Verb spec link**: see [`electrode-material/electrode-material.md`](electrode-material/electrode-material.md) — material-layer authority for this candidate's chemistry.

#### 4.A.2 S-PAN Li-S cathode

Hypothesis: sulfurized polyacrylonitrile (S-PAN) with covalently bonded
sulfur in a carbonized PAN matrix can deliver ≥ 4 mAh/cm² areal capacity
and ≥ 70% cycle-500 retention at 1C in carbonate electrolyte (avoiding
the shuttle-effect failure of conventional Li-S). Vendor authority: Wang
(NREL) + Manthiram (UT Austin) S-PAN corpus; CATL Li-S pilot.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-bat-cath-lis-001` | bat-cath | S-PAN Li-S | sulfurized polyacrylonitrile covalent-S cathode | DESIGN | F-BAT-CATH-2: cycle 500 retention < 70% @ 1C OR areal cap < 4 mAh/cm² → FAIL |

**Risk-flags**: polysulfide shuttle effect SOFT_WALL (mitigated, not
eliminated, by covalent-S architecture); Li-metal anode coupling
UNVERIFIED at ≥ 500 cycles (pairs with `hxm-bat-anode-li-metal-001`
SEI HARD_WALL); electrolyte volume / E/S ratio at cell scale UNVERIFIED;

#### 4.A.3 Na₂FeFe(CN)₆ Prussian-blue Na-ion cathode

Hypothesis: a vacancy-free Na₂FeFe(CN)₆ Prussian-blue-analog cathode,
synthesized via slow citrate-controlled co-precipitation, can retain
≥ 80% of room-temperature capacity at -20 °C with self-discharge
< 5%/month — targeted at cold-climate stationary storage. Vendor
authority: CATL Na-ion (gen-2 PBA) / HiNa Battery / Faradion;
Goodenough group historical PBA chemistry.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-bat-cath-naion-001` | bat-cath | Na₂FeFe(CN)₆ Prussian-blue Na-ion | vacancy-controlled PBA cathode for Na-ion | SIM-NNP-PROXY | F-BAT-CATH-3: cap @ -20°C < 80% RT cap OR self-discharge > 5%/mo → FAIL |

**Risk-flags**: water-content sensitivity UNVERIFIED at production
(zeolitic water leads to capacity fade); vacancy formation HARD_WALL
during synthesis (Fe(CN)₆⁴⁻ release); commodity-scale citrate process
C3 honored.
**Verb spec link** (Tier-2, `hxm-bat-cath-naion-001`): see [`electrode-material/electrode-material.md`](electrode-material/electrode-material.md) — material-layer authority for vacancy-controlled Na-PBA cathode chemistry (Na₂Fe[Fe(CN)₆] Prussian-blue; Faradion / CATL Na-ion commercial baseline preserved; cell engineering → hexa-energy per CROSS_LINK §3.3).

#### 4.A.4 K-Mn-Fe Prussian-blue K-ion cathode

Hypothesis: a K-rich K-Mn-Fe Prussian-blue-analog cathode (KₓMnFe(CN)₆
with x ≥ 1.8) processed under controlled humidity can sustain ≥ 140
mAh/g at 0.1C and ≥ 80% cycle-100 retention in non-aqueous K-ion
electrolyte. Vendor authority: Cui (Stanford) + Goodenough K-ion PBA
corpus; HiNa / Altris adjacent PBA know-how.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-bat-cath-kion-001` | bat-cath | K-Mn-Fe Prussian-blue K-ion | KₓMnFe(CN)₆ vacancy-controlled PBA for K-ion | DESIGN | F-BAT-CATH-4: cap < 140 mAh/g @ 0.1C OR cycle-100 retention < 80% → FAIL |

**Risk-flags**: K⁺ ionic radius mismatch vs Mn-Fe lattice spacing
HARD_WALL on structural strain; humidity stability UNVERIFIED (PBA
ambient water uptake degrades K-ion plateau); electrolyte chemistry
UNVERIFIED at full-cell scale. Cell engineering → hexa-energy per

#### 4.A.5 50 µm Li-foil anode on 3D Cu current collector

Hypothesis: pressed 50 µm Li-metal foil laminated to a 3D porous Cu
current collector can hold Coulombic efficiency ≥ 99.5% over 500
cycles in carbonate electrolyte without dendrite penetration to the
separator, given engineered host porosity + LiF-rich SEI from FEC +
LiNO₃ additives. Vendor authority: SES AI / Cuberg / Solid Power Li-metal
prototypes; QuantumScape Li-metal anode-free design.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-bat-anode-li-metal-001` | bat-anode | 50µm Li foil on 3D Cu | pressed Li-metal foil + 3D Cu host | SIM-NNP-PROXY | F-BAT-ANODE-1: CE < 99.5% after 500 cycles in carbonate OR dendrite penetration → FAIL |

**Risk-flags**: Li-metal SEI HARD_WALL — SEI instability remains the
dominant failure mode in carbonate electrolyte (Xu 2014 + Cui 2017
reviews); commercial cell engineering belongs to hexa-energy per
CROSS_LINK §3.3 (cycling protocol / stack pressure / separator /
electrolyte volume all out-of-repo); full-cell vs half-cell CE gap
honored. **SIM-NNP-PROXY status 2026-05-13** — predicted value vendored
as `_absorption_bridge/universal_ff/predictions/hxm-bat-anode-li-metal-001.json`;
honored.
**Verb spec link**: see [`electrode-material/electrode-material.md`](electrode-material/electrode-material.md) — material-layer authority for this candidate's chemistry.

#### 4.A.6 Sucrose-derived hard-carbon Na-ion anode

Hypothesis: sucrose pyrolyzed at 1300 °C in Ar can yield a hard carbon
with closed nanopore volume sufficient for ≥ 300 mAh/g reversible Na
capacity at 0.1C and ≥ 80% initial Coulombic efficiency (ICE), beating
commodity coconut-shell-derived HC. Vendor authority: HiNa Battery /
Faradion / Altris hard-carbon supply; Stevens & Dahn 2000 original HC
characterization.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-bat-anode-na-hardcarbon-001` | bat-anode | sucrose-derived hard C, 1300°C pyrolysis | Na-ion hard-carbon anode from sucrose precursor | DESIGN | F-BAT-ANODE-2: reversible cap < 300 mAh/g @ 0.1C OR ICE < 80% → FAIL |

**Risk-flags**: precursor purity drift UNVERIFIED at commodity scale
(food-grade sucrose lot-to-lot variability changes pore microstructure);
Na⁺ low-voltage plateau width UNVERIFIED across batches; SEI formation
on hard carbon consumes 15–25% Na inventory typically. Cell engineering

#### 4.A.7 TiNb₂O₇ Wadsley-Roth fast-charge anode

Hypothesis: a TiNb₂O₇ Wadsley-Roth shear-structure anode with carbon
coating + Mo-doping can sustain ≥ 85% capacity retention at 10C with
voltage hysteresis ≤ 50 mV — targeted at fast-charge cells. Vendor
authority: Echion Technologies / Nyobolt (UK Wadsley-Roth commercial
push); Toshiba SCiB LTO incumbent for comparator.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-bat-anode-nbo-001` | bat-anode | TiNb₂O₇ Wadsley-Roth fast-charge | Mo-doped C-coated TiNb₂O₇ for high-rate anode | DESIGN | F-BAT-ANODE-3: 10C retention < 85% OR voltage hysteresis > 50 mV → FAIL |

**Risk-flags**: electronic conductivity HARD_WALL — pristine TiNb₂O₇ is
a poor electronic conductor (10⁻⁹ S/cm); Ti⁴⁺ → Ti³⁺ reduction
introduces site-disorder at deep DOD; Nb supply geopolitical concentration
UNVERIFIED at commodity scale (CBMM Brazil ~ 85% Nb supply). Cell

#### 4.A.8 Li₁₀GeP₂S₁₂ (LGPS) thiophosphate solid electrolyte

Hypothesis: Li₁₀GeP₂S₁₂ (LGPS) synthesized via mechanochemical milling
+ 550 °C annealing in sealed Ar can sustain σ_ionic ≥ 6 mS/cm at 25 °C
with electrochemical window ≥ 4.5 V vs Li/Li⁺. Vendor authority: Kanno
group (Tokyo Tech, 2011 Nat. Mater. LGPS discovery); Solid Power /
Idemitsu Kosan sulfide-SE pilot lines.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-se-li10gps-001` | se | Li₁₀GeP₂S₁₂ (LGPS) thiophosphate | mechanochemical + annealed LGPS thiophosphate SE | DESIGN | F-SE-3: σ_ionic @ 25°C < 6 mS/cm OR EC window < 4.5 V → FAIL |

**Risk-flags**: H₂S evolution on air-contact HARD_WALL (sulfide SEs
hydrolyze at ambient RH > 10%); Ge cost UNVERIFIED at scale (Ge is
co-product of Zn smelting, supply ~ 130 t/yr global); Li-metal interface
forms Li-Ge alloy → SEI growth at deep cycling UNVERIFIED; dry-room
processing cost adder. Cell engineering → hexa-energy per CROSS_LINK

#### 4.A.9 Li₆PS₅Cl argyrodite variant solid electrolyte

Hypothesis: a Li₆PS₅Cl argyrodite synthesized via wet-chemical route
with controlled Cl⁻/S²⁻ anion ordering can sustain σ ≥ 4 mS/cm at RT
and support Li-metal stripping current density ≥ 1 mA/cm² without
short-circuit — variant complementing the established Phase A
`hxm-se-argyrod-001` (extends 001 design space with the wet-chemical
synthesis route). Vendor authority: Solid Power / Samsung SDI argyrodite
pilots; Mitsui Kinzoku argyrodite supply; Janek group (Giessen) interface
corpus.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-se-argyrodite-002` | se | Li₆PS₅Cl argyrodite (variant of existing 001) | wet-chemical Cl-ordered Li₆PS₅Cl variant | DESIGN | F-SE-4: σ < 4 mS/cm @ RT OR Li-metal stripping J < 1 mA/cm² → FAIL |

**Risk-flags**: H₂S evolution on ambient HARD_WALL (same as LGPS);
cathode oxidation interface UNVERIFIED above 4.0 V (argyrodite anodic
window narrower than halide-SE); Li-metal compatibility UNVERIFIED at
≥ 500 deep cycles; wet-chemical scale-up UNVERIFIED (mainstream is
solid-state milling). Cell engineering → hexa-energy per CROSS_LINK

#### 4.A.10 Li₃YCl₆ halide solid electrolyte variant

Hypothesis: Li₃YCl₆ halide-SE prepared via ball-milling of LiCl + YCl₃
followed by 350 °C anneal can deliver σ ≥ 1 mS/cm at RT with oxidation
onset ≥ 4.2 V vs Li — variant complementing the established Phase A
`hxm-se-halide-001` (extends 001 design space toward Y-based halide
chemistry vs the In-based variant). Vendor authority: Asano group
(Panasonic, 2018 halide-SE class discovery); Wang group (Maryland)
halide corpus; Mitsui Kinzoku.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-se-halide-002` | se | Li₃YCl₆ halide SE (variant) | Y-based halide SE complementing Li-In-Cl₆ 001 | DESIGN | F-SE-5: σ < 1 mS/cm OR oxidation onset < 4.2 V vs Li → FAIL |

**Risk-flags**: Li-metal compatibility UNVERIFIED — halide SEs reduce
at Li-metal interface (typical reduction onset ~ 0.6 V vs Li); Y supply
not a bottleneck but separation cost UNVERIFIED at battery-grade purity;
moisture sensitivity SOFT_WALL (less aggressive than sulfide but still
requires dry-room). Cell engineering → hexa-energy per CROSS_LINK §3.3.

#### 4.A.11 Perovskite-Si 2T tandem photovoltaic (32% target)

Hypothesis: a 2-terminal monolithic perovskite-Si tandem (1.68 eV
perovskite top / 1.12 eV Si bottom) using a wide-bandgap mixed-halide
perovskite with SAM (self-assembled monolayer) contacts can reach
certified-aperture PCE ≥ 32% with T80 ≥ 1000 h under ISOS-L1 stress —
extends the existing `hxm-pv-tandem-001` 33% PCE design with explicit
ISOS-L1 lifetime gate. Vendor authority: Oxford PV (commercial 2T
perovskite-Si pilot); KAUST / EPFL / HZB perovskite-Si records; NREL
chart authority.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-pv-tandem-002` | pv | perovskite-Si 2T tandem (1.68/1.12 eV) (extends existing 001) | 2T monolithic perovskite-Si with SAM contacts | SIM-NNP-PROXY | F-PV-3: certified-aperture PCE < 32% OR T80 < 1000h @ ISOS-L1 → FAIL |

**Risk-flags**: Br/I segregation in mixed-halide wide-bandgap perovskite
HARD_WALL under operating light (Hoke effect); SAM contact ageing
UNVERIFIED at 25-yr field deployment (25-yr lifetime UNPROVEN for any
perovskite cell at commodity scale); Pb halide migration to encapsulant
HARD_WALL on environmental regulation; module-level CTM ratio loss
predicted value vendored as `_absorption_bridge/universal_ff/predictions/hxm-pv-tandem-002.json`;
**Verb spec link**: see [`perovskite/perovskite.md`](perovskite/perovskite.md) (primary — top-cell perovskite material layer) and [`silicon/silicon.md`](silicon/silicon.md) (Si bottom-cell substrate, 1.12 eV E_g) — material-layer authorities for this candidate's chemistry.

#### 4.A.12 All-perovskite 4T tandem photovoltaic (29% target)

Hypothesis: an all-perovskite 4-terminal tandem (1.78 eV wide-gap top
sub-cell + 1.25 eV Sn-Pb mixed narrow-gap bottom sub-cell) with
SnF₂-stabilized Sn²⁺ + ALD-encap can reach certified PCE ≥ 29% with
T80 ≥ 800 h. Vendor authority: McGehee group (CU Boulder, Sn-Pb perovskite
lead); Yan group (Toledo) all-perovskite tandem corpus; Saule
Technologies / Microquanta (commercial scaling attempts).
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-pv-allper-001` | pv | all-perovskite 4T tandem (1.78/1.25 eV) | wide-gap + Sn-Pb narrow-gap stacked perovskite | DESIGN | F-PV-4: certified PCE < 29% OR T80 < 800h → FAIL |

**Risk-flags**: Sn²⁺ → Sn⁴⁺ oxidation HARD_WALL — narrow-gap Sn-Pb
perovskite is the dominant Achilles' heel of all-perovskite tandems
(Sn²⁺ oxidizes at trace O₂/H₂O even with SnF₂); Pb halide migration
HARD_WALL on encapsulation; 25-yr operational lifetime UNVERIFIED at

#### 4.A.13 Cu₂ZnSn(S,Se)₄ kesterite thin-film photovoltaic

Hypothesis: a Cu₂ZnSn(S,Se)₄ (CZTSSe) kesterite thin-film absorber with
Ag-substitution and Ge-alloying at the Sn site can break the persistent
13% PCE ceiling and the > 0.5 V V_oc-deficit limit that has plagued
kesterite since 2013. Vendor authority: Mitra (IBM, 2013 12.6% record);
Hages (Purdue) Ag-substituted kesterite; Siebentritt (Luxembourg)
defect-chemistry corpus.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-pv-csts-001` | pv | Cu₂ZnSn(S,Se)₄ kesterite thin-film | Ag/Ge-alloyed CZTSSe targeting V_oc-deficit fix | DESIGN | F-PV-5: certified PCE < 13% OR V_oc deficit > 0.5V → FAIL |

**Risk-flags**: Cu/Zn antisite disorder HARD_WALL — Cu_Zn and Zn_Cu
antisites with ~ 100 meV formation energy are intrinsic to kesterite
crystal chemistry and pin V_oc; secondary phases (Cu₂SnSe₃, ZnSe)
UNVERIFIED to fully suppress at scale; Se losses during selenization

#### 4.A.14 Y6-class small-molecule organic photovoltaic

Hypothesis: a Y6-class small-molecule non-fullerene acceptor (NFA)
binary or ternary blend (e.g., PM6:Y6:BTP-eC9) can achieve certified
PCE ≥ 19% and T80 ≥ 5000 h under 1-sun AM1.5G with engineered
morphology + UV-cut encapsulation. Vendor authority: Zou group (CSU,
Y6 discovery 2019 Joule); Yan group (HKUST) NFA corpus; Heliatek
(commercial OPV module).
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-pv-organic-001` | pv | Y6-class small-molecule OPV | PM6:Y6 (and BTP-eC9 ternary) NFA OPV | DESIGN | F-PV-6: certified PCE < 19% OR T80 1-sun AM1.5 < 5000h → FAIL |

**Risk-flags**: morphology drift UNVERIFIED at 5000 h continuous
illumination (NFA bulk-heterojunction phase separation under thermal
stress); encapsulation HARD_WALL required for any > 5 yr operation
(O₂/H₂O permeation degrades NFA); large-area uniformity UNVERIFIED at

#### 4.A.15 CdTe + Se grading thin-film photovoltaic

Hypothesis: a CdTe + Se grading photovoltaic (NREL-style, Se-graded
front interface, with CdSeTe alloy at the absorber surface) can sustain
certified PCE ≥ 23% — pushing above the long-time CdTe ceiling that
First Solar Series-7 modules have probed. Vendor authority: First Solar
(commercial CdTe authority — Series-7 module ~ 22% cert. cell); NREL
CdTe device team; Wolden group (CSM) CdSeTe absorber engineering.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-pv-thinfilm-cdte-001` | pv | CdTe + Se grading (NREL-style) | CdSeTe-graded CdTe thin-film absorber | DESIGN | F-PV-7: certified PCE < 23% → FAIL |

**Risk-flags**: Cd regulatory headwinds UNVERIFIED — EU RoHS / WEEE
end-of-life handling adds cost; Cd toxicity UNPROVEN to be a
field-deployment blocker (First Solar take-back programs handle it but
geographic regulatory variance UNVERIFIED); Te supply (co-product of Cu
refining, ~ 600 t/yr globally) UNVERIFIED at TW-scale deployment.

#### 4.A.16 (Ba,Sr)(Co,Fe)O₃ SOFC cathode @ 600 °C

Hypothesis: a (Ba₀.₅Sr₀.₅)(Co₀.₈Fe₀.₂)O₃₋δ (BSCF) perovskite cathode
with infiltrated nano-CeO₂ catalyst on a 8YSZ-GDC bilayer electrolyte
can sustain area-specific resistance (ASR) ≤ 0.15 Ω·cm² at 600 °C
with ≤ 30% Cr poisoning loss over 1000 h on a Crofer-22-APU
interconnect. Vendor authority: Bloom Energy / Ceres Power /
SOLIDpower (commercial intermediate-T SOFC); Shao + Haile (Berkeley,
2008 Nature BSCF cathode discovery).
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-fc-sofc-bscf-001` | fc-sofc | (Ba,Sr)(Co,Fe)O₃ SOFC cathode @ 600°C | BSCF + CeO₂ infiltrated cathode on bilayer electrolyte | DESIGN | F-FC-1: ASR > 0.15 Ω·cm² @ 600°C OR Cr poisoning loss > 30% over 1000h → FAIL |

**Risk-flags**: Cr poisoning HARD_WALL — volatile CrO₂(OH)₂ from
Crofer-22-APU interconnect is the dominant degradation mode for
Co-bearing SOFC cathodes (Hilpert 1996 thermochemistry); thermal cycling
UNVERIFIED at ≥ 100 cycles (CTE mismatch BSCF vs YSZ); cell-level
balance-of-plant integration → hexa-energy per CROSS_LINK §3.3.

#### 4.A.17 Poly(arylpiperidinium) AEM (PAP-TP)

Hypothesis: a poly(arylpiperidinium) anion-exchange membrane (PAP-TP
backbone with terphenyl spacer, N-piperidinium cation) cast at 30–50 µm
can sustain σ_OH⁻ ≥ 0.1 S/cm at 60 °C and durability ≥ 1000 h at 200
mA/cm² in AEM water electrolysis. Vendor authority: Bae group (KAIST,
PAP-TP corpus 2017 onward); Hickner (Penn State) AEM characterization;
Versogen / Ionomr Innovations (commercial AEM supply).
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-fc-aem-pap-tp-001` | fc-aem | poly(arylpiperidinium) AEM | PAP-TP terphenyl-spacer piperidinium AEM | DESIGN | F-FC-2: σ_OH⁻ < 0.1 S/cm @ 60°C OR durability < 1000h @ 200 mA/cm² → FAIL |

**Risk-flags**: cationic group degradation under alkaline conditions
HARD_WALL — piperidinium > imidazolium > benzyltrimethylammonium for
alkaline stability but no AEM cation is HF-free indefinitely under
0.1 M KOH; carbonate uptake from ambient CO₂ reduces σ_OH⁻ in real
electrolyzer stacks; commercial scale UNVERIFIED at MEA level (lab
samples ~ 25 cm², stacks UNVERIFIED). Cell engineering → hexa-energy

#### 4.A.18 2,6-DHAQ + methyl-viologen organic redox flow

Hypothesis: a 2,6-DHAQ (negolyte) + methyl-viologen (posolyte) aqueous
organic redox-flow chemistry at pH ~ 12 with size-selective AEM separator
can deliver energy density ≥ 30 Wh/L with capacity fade ≤ 0.05%/day
over 30-day cycling. Vendor authority: Aziz group (Harvard, 2014 Nature
DHAQ); Gentry group (CMU) viologen corpus; CMBlu / Quino Energy
(commercial organic flow scaling).
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-bat-flow-org-001` | bat-flow | 2,6-DHAQ + methyl viologen organic flow | DHAQ negolyte + MV posolyte aqueous flow | DESIGN | F-BAT-FLOW-1: energy density < 30 Wh/L OR cap fade > 0.05%/day → FAIL |

**Risk-flags**: organic active-material crossover SOFT_WALL — size-
selective AEM mitigates but does not eliminate; pH window UNVERIFIED at
extended operation (DHAQ disproportionation accelerates above pH 13);
$/kWh parity to vanadium-flow UNVERIFIED at MW-scale (organic chemistry
synthesis cost UNVERIFIED at 10 kt/yr); cell engineering / stack design

#### 4.A.19 Ti₃C₂T_x MXene supercapacitor electrode

Hypothesis: a Ti₃C₂T_x MXene supercapacitor electrode with mixed -O/-F/
-OH surface terminations and intercalated H₂SO₄ can deliver gravimetric
capacitance ≥ 350 F/g at 1 A/g in 1 M H₂SO₄ with ≥ 90% retention over
10,000 cycles. Vendor authority: Gogotsi group (Drexel, MXene discovery
2011 + supercap corpus); Murata MXene films (commercial pilot).
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-cap-mxene-001` | cap | Ti₃C₂T_x MXene supercap | T_x-terminated Ti₃C₂ in 1 M H₂SO₄ | DESIGN | F-CAP-1: C_grav < 350 F/g @ 1 A/g in 1M H₂SO₄ OR cycle-10k retention < 90% → FAIL |

**Risk-flags**: oxidation in ambient HARD_WALL — Ti₃C₂ → TiO₂ + amorphous
C pathway accelerates above 60% RH (Gogotsi 2023 review surfaced via
`_research_bridge/arxiv/`); flake-restacking UNVERIFIED at thick-film
electrodes (> 100 µm loses accessible surface); HF-free etching route
UNVERIFIED at gram scale (companion of §3.15 `hxm-mxene-ti3c2-001`
risk-flags). Cell engineering → hexa-energy per CROSS_LINK §3.3.

---

### 4.B Catalysis + thermal (16 candidates)

#### 4.B.1 Catalysis (extends §3.19 `hxm-cat-fenc-001`)

8 candidates spanning non-PGM ORR · CO₂ reduction · H₂ evolution /
OER · N₂ reduction · photocatalysis. Vendor / lab anchors named
/ Atanassov / Dodelet / Sargent / Buonsanti / Strasser / Markovic
/ Norskov / Nocera / Domen / Hutchings / Schlogl groups + Climeworks
/ Carbon Engineering vendor baselines).

Hypothesis (`hxm-cat-sac-fe-002`): an Fe single-atom catalyst (SAC) on
N-doped graphene — pyrolyzed Fe-phenanthroline on rGO at 900 °C in NH₃
— extends the `hxm-cat-fenc-001` Fe-N₄/C platform with improved Fe-site
density (≥ 1.5 wt% atomically-dispersed Fe by Mössbauer D1+D2 doublets)
and improved mass-transport via hierarchical micro/meso porosity. Same
PGM-displacement target: acid-PEMFC ORR E₁/₂ ≥ 0.85 V vs RHE.

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-cat-sac-fe-002`     | cat   | Fe SAC on N-graphene | extends `fenc-001`; ≥ 1.5 wt% Fe-N₄ | DESIGN | F-CAT-SAC-FE-1: E₁/₂ < 0.80 V vs RHE in 0.5 M H₂SO₄ (RDE 1600 rpm, O₂-sat) → FAIL |

**Risk-flags**: Fe leaching under Fenton-active PEM operating conditions
HARD_WALL (degrades ionomer per Pivovar 2020); Fe-N₄ vs Fe-N₃-C
coordination uncertainty (EXAFS first-shell N count not deterministic
post-NH₃-activation; Wu 2021 J. Am. Chem. Soc.); production-scale Fe-SAC
density UNVERIFIED above 1 wt% at gram scale; cell-level $/kW parity
to Pt/C UNPROVEN at MEA stack scale (cell engineering belongs to
`hexa-energy` per CROSS_LINK §3.3).

Hypothesis (`hxm-cat-mof-mn-001`): a Mn-based MOF-derived ORR catalyst —
ZIF-67(Mn)-templated pyrolysis at 950 °C in Ar/NH₃ — for alkaline AEM
fuel-cell cathode. Target alkaline E₁/₂ ≥ 0.85 V vs RHE with ≤ 20 mV
loss after 100 h at 0.6 V hold (Pivovar / Mustain / Snyder AEM stack
durability protocol).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-cat-mof-mn-001`     | cat   | Mn-MOF-derived ORR  | alkaline AEM cathode; ZIF-67(Mn) → C-Mn-N₄ | DESIGN | F-CAT-MOF-MN-1: alkaline E₁/₂ < 0.85 V vs RHE OR 100 h durability loss > 20 mV → FAIL |

**Risk-flags**: Mn redox-couple stability in alkaline UNVERIFIED above
500 h (Mn³⁺/Mn⁴⁺ disproportionation pathway open); carbonate uptake in
AEM cathode HARD_WALL (Mustain 2023 review); ZIF-67(Mn) precursor
homogeneity not deterministic post-solvothermal; cell-level integration
owned by `hexa-energy` per CROSS_LINK §3.3.

Hypothesis (`hxm-co2-red-cu-001`): Cu nanocube electrocatalyst for
selective CO₂ → C₂H₄ in alkaline flow cell (Sargent / Buonsanti / Kanan
lineage). Cube edge length 35-45 nm via wet-chemical synthesis from
Cu(NO₃)₂ + ascorbic acid, with (100) facet predominance verified by
SAED. Target Faradaic efficiency toward C₂H₄ ≥ 60% at -1.0 V vs RHE
with partial j ≥ 250 mA/cm² (matches Sargent 2023 Nature commercial-
density milestone).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-co2-red-cu-001`     | cat   | Cu nanocube → C₂H₄  | (100)-facet predominant; alkaline flow cell | DESIGN | F-CO2-RED-CU-1: FE_C2H4 < 60% @ -1.0 V vs RHE OR partial j < 250 mA/cm² → FAIL |

**Risk-flags**: Cu surface reconstruction under operating CO₂RR
conditions HARD_WALL (nanocube → polycrystalline aggregate after
minutes per Buonsanti 2021 Nat. Energy); HER competition at high
overpotential UNVERIFIED below pH 12; carbonate crossover in alkaline
flow cell HARD_WALL (carbonate precipitation in cathode GDL); selectivity
vs CH₄/CO branch UNVERIFIED at MEA stack scale; product-separation
energy-overhead UNVERIFIED at commercial concentration.

Hypothesis (`hxm-co2-red-ag-sn-001`): Ag-Sn alloy electrocatalyst for
CO₂ → HCOO⁻ (formate) in flow cell. Ag-rich Ag₃Sn intermetallic via
co-electrodeposition on Ti GDL, targeting selectivity ≥ 90% at j ≥
200 mA/cm² over a ≥ 200 mV operating window (Yeo / Stoerzinger /
Burdyny group benchmark).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-co2-red-ag-sn-001`  | cat   | Ag-Sn → HCOO⁻       | Ag₃Sn intermetallic; formate flow cell | DESIGN | F-CO2-RED-AG-SN-1: FE_HCOO < 90% OR operating window < 200 mV → FAIL |

**Risk-flags**: Sn dissolution under cathodic conditions UNVERIFIED
above 100 h (Sn²⁺ leaching to anolyte); formate downstream separation
HARD_WALL (electro-membrane separation power-overhead 0.5-1 kWh/kg);
Ag supply-chain HARD_WALL at scale (Ag is the limiting price-elastic
metal in CO₂RR-formate economics per Burdyny 2022 review).

Hypothesis (`hxm-h2-elec-nimo-001`): NiMo HER cathode in alkaline AEM
water-electrolyzer. Mo loading ≤ 20 at%, Ni₈₀Mo₂₀ alloy electrodeposited
on Ni-foam substrate. Target overpotential η ≤ 100 mV at j = 100 mA/cm²
in 1 M KOH at 60 °C, with ≥ 2000 h stability in commercial AEM cell
(Mustain / Yan / Bae AEM lineage; Hysata / Enapter / Ohmium vendor
benchmarks).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-h2-elec-nimo-001`   | cat   | NiMo HER alkaline AEM | Ni₈₀Mo₂₀ on Ni-foam; PGM-free | DESIGN | F-H2-ELEC-NIMO-1: η @ 100 mA/cm² > 100 mV OR stability < 2000 h → FAIL |

**Risk-flags**: Mo leaching to KOH electrolyte HARD_WALL above 80 °C
(MoO₄²⁻ formation; Mustain 2021 ACS Energy Lett.); Ni coarsening at
prolonged hold UNVERIFIED above 5000 h; AEM membrane carbonate uptake
HARD_WALL (separate failure mode from cathode); cell-level integration
+ stack engineering owned by `hexa-energy` per CROSS_LINK §3.3.

Hypothesis (`hxm-h2-elec-iro2-doped-001`) **[TIER-1 per NOVEL_ROADMAP
§5]**: Ir-Ru mixed oxide OER anode for PEM water-electrolyzer (acidic).
Composition Ir₀.₇Ru₀.₃O₂ supported on Ti mesh. Target η ≤ 250 mV at
j = 10 mA/cm² with Ir loading ≤ 1 mg/cm² (Strasser / Stoerzinger / NREL
loading-reduction target for commodity-scale PEM electrolysis; ITM
Power / Plug Power / Cummins vendor baselines).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-h2-elec-iro2-doped-001` | cat | Ir-Ru oxide OER PEM | Ir₀.₇Ru₀.₃O₂ on Ti mesh; ≤ 1 mg-Ir/cm² | SIM-NNP-PROXY | F-H2-ELEC-IRO2-1: η @ 10 mA/cm² > 250 mV OR Ir loading > 1 mg/cm² for commodity scale → FAIL |

**Risk-flags**: **Ir scarcity HARD_WALL** — global Ir production ~ 8
t/yr, PEM electrolyzer roll-out to 100 GW would require ≥ 30 t-Ir/yr
at 1 mg/cm² loading (per Bernt 2018 J. Electrochem. Soc. + IRENA 2020
analysis); Ru leaching in acidic OER conditions HARD_WALL (Ru → RuO₄
volatile loss); long-term oxide-support corrosion at j > 2 A/cm²
UNVERIFIED above 50 000 h commercial-warranty target; loading-reduction
to 0.1 mg/cm² is an active research target but NOT a closed milestone
(Strasser 2023 Chem. Rev.); cell-level integration owned by
`hexa-energy` per CROSS_LINK §3.3. **SIM-NNP-PROXY status 2026-05-13** —
predicted value vendored as `_absorption_bridge/universal_ff/predictions/hxm-h2-elec-iro2-doped-001.json`;
`hexa-energy` per CROSS_LINK §3.3.
**Verb spec link**: see [`electrode-material/electrode-material.md`](electrode-material/electrode-material.md) (electrocatalysis sub-section: EM-L15 IrO₂ OER + Pt-ORR anchors) — material-layer authority for this candidate's chemistry.

Hypothesis (`hxm-n2-red-ru-cluster-001`): Ru subnano-cluster (≤ 1 nm)
on N-doped carbon support for electrocatalytic N₂ reduction reaction
(N₂RR) to ambient-pressure NH₃. Target Faradaic efficiency toward NH₃
≥ 20% at -0.3 V vs RHE with NH₃ yield rate ≥ 50 μg/(h·mg-cat) in
acidic aqueous electrolyte under Ar/N₂ atmosphere (MacFarlane / Yu /
Centi N₂RR lineage).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-n2-red-ru-cluster-001` | cat | Ru subnano N₂RR    | ≤ 1 nm Ru on N-C; ambient NH₃ | DESIGN | F-N2-RED-RU-1: FE_NH3 < 20% @ -0.3 V vs RHE OR NH₃ yield < 50 μg/h·mg → FAIL |

**Risk-flags**: **ambient NH₃ contamination HARD_WALL** — most pre-2020
N₂RR papers reported NH₃ from atmospheric / reagent / glassware
contamination, NOT from N₂RR (Andersen 2019 Nature retraction wave +
Choi 2020 Nat. Commun. protocol paper); rigorous ¹⁵N₂ isotope-labeling
required to claim N₂RR activity, including ¹⁵N → ¹⁵NH₃ NMR/IC
verification, NOT optional; HER competition HARD_WALL (N₂ adsorption
energy < H adsorption energy on most metals; Norskov 2019 ACS Catal.);
Ru cost-elasticity HARD_WALL at scale (Ru also under demand pressure
from chlor-alkali + OER markets). Anti-claim preserved: no electrochemical
ambient-pressure N₂RR system has yet matched Haber-Bosch energy
efficiency at any scale.

Hypothesis (`hxm-cat-photo-cds-sb-001`): CdS-Sb₂S₃ tandem photocatalyst
for direct overall water splitting. CdS (E_g 2.4 eV) light-absorber +
Sb₂S₃ (E_g 1.7 eV) bottom junction in nanostructured Z-scheme
configuration. Target solar-to-hydrogen efficiency (STH) ≥ 5% under
10-sun simulated AM1.5 illumination with ≥ 100 h durability before
photocorrosion-induced activity loss > 30% (Domen / Hutchings /
Schlogl group benchmark; Toyota CRDL + UTokyo Domen lab references).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-cat-photo-cds-sb-001` | cat | CdS-Sb₂S₃ tandem photocat | Z-scheme overall water splitting | DESIGN | F-CAT-PHOTO-1: STH < 5% (10-sun AM1.5) OR durability < 100 h before > 30% loss → FAIL |

**Risk-flags**: **Cd toxicity regulatory HARD_WALL** (REACH Annex XVII
restriction, RoHS exempt list under review 2024-2026); photocorrosion
of CdS (CdS + 2h⁺ → Cd²⁺ + S) HARD_WALL without sacrificial reagent
— sacrificial reagent (Na₂S/Na₂SO₃) breaks the "overall water splitting"
claim per Domen 2018 critique; Sb₂S₃ phase-stability under hole-rich
conditions UNVERIFIED above 200 h; 10-sun concentration optics adds
balance-of-plant cost UNVERIFIED at LCOH parity to PEM electrolysis
(per IRENA 2022 green-H₂ LCOH report); MOST PHOTOCATALYTIC OVERALL
WATER SPLITTING SYSTEMS HAVE STH < 1% at 1-sun — this candidate's 5%
@ 10-sun is aspirational, NOT a closed milestone.

---

#### 4.B.2 Thermoelectrics (extends §3.21 `hxm-thermo-snse-001`)

4 candidates spanning half-Heusler · filled skutterudite · nano-BiSbTe
/ Ferrotec / European Thermodynamics** for Bi-Te commodity modules;
**Phononic / Komatsu / Hi-Z** for TE modules; **Northwestern Kanatzidis
group · Snyder group · Pei group (Tongji) · Wuttig group (Aachen)** for
academic SOTA — their published ZT(T) curves with explicit κ_lat ± error
bars govern (no n=6 lattice-fit on vendor ZT data).

Hypothesis (`hxm-te-half-zrnisn-001`) **[TIER-1 per NOVEL_ROADMAP §5]**:
ZrNiSn-based half-Heusler thermoelectric for mid-T waste-heat recovery
(500-800 K). Substitution Zr₀.₅Hf₀.₅NiSn₀.₉₈Sb₀.₀₂ to suppress κ_lat
via mass-fluctuation phonon scattering (Snyder / Tritt half-Heusler
lineage). Target ZT ≥ 1.5 at 800 K with thermal stability > 100 h at
1000 K (matching Toyota CRDL automotive-exhaust waste-heat-recovery
spec).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-te-half-zrnisn-001` | thermo | ZrNiSn half-Heusler | Zr/Hf mass-fluctuation + Sb dop; mid-T waste-heat | SIM-NNP-PROXY | F-TE-HALF-ZRNISN-1: ZT @ 800 K < 1.5 OR 1000 K stability < 100 h → FAIL |

**Verb spec link**: see [`metallurgy/swordsmithing.md`](metallurgy/swordsmithing.md) — material-layer authority for this candidate's half-Heusler intermetallic metallurgy.

**Risk-flags**: Sn-vacancy concentration drift at high-T HARD_WALL
(volatilization above 1000 K → composition shift → ZT drop per Berry
2019 J. Mater. Chem. A); Hf supply scarcity SOFT_WALL (Hf is a
nuclear-grade Zr-coupled byproduct; commercial Hf production ~ 100 t/yr
worldwide); module-level ZT typically 30-50% below pellet ZT due to
contact resistance (matching `hxm-thermo-snse-001` discussion at §3.21).
Vendor authority: **Marlow Industries** (Bi-Te modules, not half-Heusler
— half-Heusler modules NOT yet commercial); **Phononic / Komatsu** (TE
module integration). half-Heusler MODULES NOT YET COMMERCIAL at any
vendor as of 2026 — production-scale UNVERIFIED. **SIM-NNP-PROXY status
2026-05-13** — predicted value vendored as
`_absorption_bridge/universal_ff/predictions/hxm-te-half-zrnisn-001.json`;
vendor as of 2026 — production-scale UNVERIFIED.
**Verb spec link**: see [`metallurgy/swordsmithing.md`](metallurgy/swordsmithing.md) — material-layer authority for this candidate's chemistry (ZrNiSn-based half-Heusler is an intermetallic / metallurgical material; the verb dir hosts the metallurgy spec).

Hypothesis (`hxm-te-skutt-cosb3-001`): Filled CoSb₃ skutterudite —
Yb_x Ba_y Co₄Sb₁₂ with multi-filler rattler concept (Yb + Ba + La
double/triple filling) — for mid-T thermoelectric module (300-500 K
operating range). Target ZT ≥ 1.4 at 500 K with metallization contact
resistance ≤ 5 μΩ·cm² to Cu/Ni interconnect (matching DLR / NASA-JPL
deep-space RTG-cousin module spec).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-te-skutt-cosb3-001` | thermo | filled CoSb₃ skutterudite | Yb/Ba multi-filler rattler; mid-T module | DESIGN | F-TE-SKUTT-COSB3-1: ZT @ 500 K < 1.4 OR contact R > 5 μΩ·cm² → FAIL |

**Risk-flags**: Sb volatilization at module hot-end UNVERIFIED above
500 °C in air (Sb → Sb₂O₃ oxidation); rattler-filler stability under
thermal cycling HARD_WALL — Yb²⁺/Yb³⁺ valence shift can release
filler-atom motion energy as activation barrier collapse (Snyder 2008
APL); Co supply concentration HARD_WALL (DRC > 70% of global Co
production per USGS 2024). Vendor authority: **Phononic** (commercial
TE modules — Bi-Te chemistry not skutterudite); **Komatsu Electronics
TE division** (high-T skutterudite R&D, not yet at production parity
to Bi-Te in commercial catalog).

Hypothesis (`hxm-te-bisbte-001`): Nanostructured Bi₀.₅Sb₁.₅Te₃ pellet
for room-temperature TE module (Peltier cooling + thermal scavenging
applications). Hot-pressed nanocrystalline texture via ball-milling +
spark-plasma-sintering, with phonon-scattering grain-boundary density
optimized for κ_lat suppression. Target ZT ≥ 1.2 at 300 K with
mechanical compressive strength σ_c ≥ 30 MPa for module-grade
robustness.

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-te-bisbte-001`      | thermo | nanostructured BiSbTe RT | SPS-densified; Peltier cooling target | DESIGN | F-TE-BISBTE-1: ZT @ RT < 1.2 OR mechanical σ_c < 30 MPa → FAIL |

**Risk-flags**: Te supply scarcity HARD_WALL (Te is a Cu-refinery
byproduct; global Te production ~ 580 t/yr per USGS 2024 — supply-
inelastic relative to TE demand growth); grain-growth at module hot-end
gradually undoes nanostructuring (Snyder 2014 review); module
contact-resistance via Cu/Ni metallization UNVERIFIED at MTBF scale.
Vendor authority: **Marlow Industries / II-VI Marlow** (commercial
Bi-Te modules — n-type Bi₂Te₃ + p-type Bi₀.₅Sb₁.₅Te₃ are the standard
catalog chemistries; ZT 0.9-1.0 in commercial catalog typical, ZT > 1.2
is aspirational not catalog-shipped); **Ferrotec / European
Thermodynamics** (catalog Peltier modules).

Hypothesis (`hxm-te-org-pedot-001`): PEDOT:PSS-based organic
thermoelectric — solution-processed thin film with post-treatment via
DMSO + EG sequential dipping to enhance σ_electric, doped with
dimethylsulfoxide-induced fibril crystallinity, targeting power factor
(S²σ) ≥ 100 μW/(m·K²) at 300 K with thickness uniformity ≤ 10% across
a 4-inch substrate (Crispin / Mai / Cao group organic-TE benchmark).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-te-org-pedot-001`   | thermo | PEDOT:PSS organic TE | DMSO/EG-treated film; wearable scavenging | DESIGN | F-TE-ORG-PEDOT-1: power factor < 100 μW/(m·K²) @ 300 K OR thickness uniformity > 10% → FAIL |

**Risk-flags**: PEDOT:PSS humidity stability HARD_WALL (sulfonate-based
PSS is hygroscopic; conductivity drops 50%+ at 85% RH per Crispin 2014
review); thermal-stability of doped PEDOT:PSS UNVERIFIED above 120 °C
(de-doping pathway); organic TE ZT < 0.4 typical even with optimal
power factor (κ ~ 0.3 W/(m·K) baseline), so module-level energy
scavenging UNVERIFIED at competitive efficiency to Bi-Te; cost-parity
to Bi-Te modules UNPROVEN at wearable scale. Organic-TE MODULES NOT
YET COMMERCIAL at any major vendor (Marlow / Ferrotec / Phononic /
Komatsu all ship inorganic only).

---

#### 4.B.3 PCM thermal storage (extends §3.9 `hxm-pcm-gst-001`)

2 candidates spanning hydrated-salt low-T storage · sugar-alcohol
medium-T storage. Distinct from §3.9 `pcm` memory class (GST / Sb-Te
for photonic/electronic switching); these are bulk thermal-energy-storage
materials. Vendor / lab authority: **PCM Products Ltd / Rubitherm /
Climator** for commercial PCM panels; **Sharma / Cabeza / Farid** PCM
thermal-storage research groups.

Hypothesis (`hxm-pcm-salt-cacl-001`): CaCl₂·6H₂O hydrated-salt PCM for
low-T building thermal-energy storage (T_m ≈ 29.7 °C). Nucleation
control via additive of SrCl₂·6H₂O at 2 wt% to suppress subcooling;
thickening via cellulose-derivative gel to suppress incongruent
melting. Target latent heat ≥ 180 J/g with cycle-1000 retention ≥ 85%
(matching PCM Products S27 / Rubitherm SP25 commercial baseline).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-pcm-salt-cacl-001`  | pcm   | CaCl₂·6H₂O hydrated salt | building thermal-energy-storage; T_m ≈ 29.7 °C | DESIGN | F-PCM-SALT-CACL-1: latent heat < 180 J/g OR cycle-1000 retention < 85% → FAIL |

**Risk-flags**: incongruent melting HARD_WALL — CaCl₂·6H₂O peritectic
decomposes to CaCl₂·4H₂O + saturated brine on cycling without nucleator
+ thickener (Sharma 2009 Renewable Sustainable Energy Rev.); subcooling
≥ 10 K typical without SrCl₂ nucleator; corrosion of metallic
encapsulation HARD_WALL (CaCl₂ brine on steel / aluminum); long-term
phase-separation UNVERIFIED above 5000 cycles. Vendor authority: **PCM
Products Ltd** (S27 product), **Rubitherm Technologies** (SP25 product),
**Climator Sweden** (ClimSel C24) — their published cycle-life data

Hypothesis (`hxm-pcm-sugar-erythritol-001`): erythritol sugar-alcohol
PCM for medium-T industrial thermal-energy storage (T_m ≈ 117 °C).
Pharma-grade erythritol with anti-supercooling additive (1 wt% xylitol)
and copper-foam encapsulation for thermal-conductivity enhancement.
Target T_m within 117 ± 3 °C with ≥ 500 melt-freeze cycles before
> 10% capacity loss (Cabeza / Farid / Kenisarin sugar-alcohol PCM
benchmark; commercial baseline: BASF erythritol food-grade specs).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-pcm-sugar-erythritol-001` | pcm | erythritol medium-T PCM | T_m 117 °C; sugar-alcohol storage | DESIGN | F-PCM-SUGAR-ERYTHRITOL-1: T_m outside 117 ± 3 °C OR > 500 cycles fail with > 10% latent-heat loss → FAIL |

**Risk-flags**: subcooling 30-50 K typical without nucleator (xylitol
addition reduces but does not eliminate); thermal-cycling degradation
via slow racemization / browning UNVERIFIED above 1000 cycles at T_m;
erythritol food-supply-chain price sensitivity (sweetener market
dynamics decouple from PCM economics); flammability above ignition
point HARD_WALL (sugar-alcohol carbon backbone). Vendor authority:
**Cargill / Mitsubishi Chemical** (erythritol food-grade producers —
NOT marketed as PCM; PCM grade UNVERIFIED at supply); **Rubitherm RT82**
(commercial paraffin alternative for ~100 °C range).

---

#### 4.B.4 Radiative cooling + insulation

2 candidates spanning sub-ambient daytime radiative-cooling paint ·
vacuum insulated panel (VIP). Vendor authority: **3M (Cool Roof
Coatings)**, **PPG Industries**, **Cabot Corp (fumed silica VIP cores)**,
**Va-Q-tec (VIP panels)**, **Kingspan Insulation**, **Panasonic vacuum
C3, no n=6 lattice-fit on vendor data).

Hypothesis (`hxm-rcc-paint-baso4-001`): BaSO₄ acrylic radiative-cooling
paint for sub-ambient daytime cooling. BaSO₄ particle volume fraction
60% (D₅₀ 800 nm) in acrylic binder, optimized for 8-13 μm atmospheric
transparency-window emission and solar-spectrum reflectance.
Target net radiative cooling power ≥ 60 W/m² at solar noon under clear
sky AM1.5 illumination with solar reflectance ≥ 95% (matching Mandal /
Yang / Raman / Fan radiative-cooling group benchmarks; UCLA Aaswath
Raman + Stanford Shanhui Fan + Columbia Yu Yang lineage).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-rcc-paint-baso4-001` | rcc  | BaSO₄ acrylic RC paint | sub-ambient daytime cooling; AM1.5 | DESIGN | F-RCC-PAINT-BASO4-1: net cooling < 60 W/m² noon clear-day AM1.5 OR solar reflectance < 95% → FAIL |

**Risk-flags**: dirt accumulation degradation HARD_WALL — coatings
collect dust/biofilm/pollen, dropping solar reflectance 5-10% over 6
months in real-world deployment (Mandal 2021 Joule); humidity in the
8-13 μm atmospheric window HARD_WALL — cooling power drops 50%+ at
high-humidity conditions (the "atmospheric transparency window" is
weather-dependent); coating mechanical durability UNVERIFIED above
5 yr outdoor weathering at scale; vendor commercial product comparison:
**3M Cool Roof** ~ 0.85 solar reflectance + ~ 0.90 emissivity (NOT
sub-ambient daytime); aspirational ≥ 0.95 solar reflectance approaches
the materials-science upper bound (Wang & Yu 2021 review).

Hypothesis (`hxm-insul-vip-001`): vacuum insulated panel (VIP) with
fumed-silica core + multilayer barrier film. Fumed-silica core
(SiO₂ aerogel-like nanopowder, Cabot Cab-O-Sil EH-5 reference)
compressed to 200 kg/m³ packing density in stainless-steel-foil-
laminated multilayer-barrier envelope. Target thermal conductivity
k ≤ 0.005 W/(m·K) and vacuum lifetime ≥ 20 yr at 25 °C, 50% RH
(matching Va-Q-tec / Panasonic / Kingspan commercial VIP catalog
spec).

| ID                       | class | target              | brief                          | status   | falsifier                             |
|--------------------------|-------|---------------------|--------------------------------|----------|---------------------------------------|
| `hxm-insul-vip-001`      | rcc   | VIP fumed-silica core | barrier-film vacuum panel; building insulation | DESIGN | F-INSUL-VIP-1: k > 0.005 W/(m·K) OR vacuum lifetime < 20 yr → FAIL |

**Risk-flags**: barrier-film gas permeation HARD_WALL — even
metallized-PET multilayer films leak air slowly; vacuum lifetime
strongly temperature-dependent (Arrhenius — 50 yr at 23 °C may be
5 yr at 60 °C per Va-Q-tec datasheet); core compression set under
load UNVERIFIED above 30 yr; panel-edge thermal bridging HARD_WALL
(perimeter heat loss can dominate total panel loss for small panels);
puncture / mechanical-damage failure ends vacuum lifetime catastrophically
HARD_WALL (single puncture → atmospheric pressure restoration in
minutes). Vendor authority: **Va-Q-tec va-Q-vip** (k 0.004 W/(m·K)
catalog, 25 yr warranty); **Panasonic U-Vacua** (k 0.0019 W/(m·K)
ultra-thin VIP); **Kingspan OPTIM-R** (k 0.007 W/(m·K) building VIP);
**Cabot Corp** (fumed-silica core supplier baseline).

---

Round 3 §4.B summary: **16 candidates** spanning catalysis (8) +
thermoelectrics (4) + PCM thermal storage (2) + radiative cooling +
insulation (2). **Tier-1 promotion targets**: `hxm-te-half-zrnisn-001`
and `hxm-h2-elec-iro2-doped-001` per [`NOVEL_ROADMAP.md`](NOVEL_ROADMAP.md)
§5 priority ranking. All entries `status: DESIGN`; quantitative
falsifiers (F-tag + number + condition + pass/fail boundary) per row;
+ SPEC_FIRST. HARD_WALL preservation: Ir scarcity · Cd toxicity
regulatory · ambient NH₃ contamination — preserved verbatim. n=6
lattice MUST NOT be applied to vendor / lab numbers
([`LATTICE_POLICY.md`](LATTICE_POLICY.md) §1.2/§1.3).

---

Round-3 expansion per [`NOVEL_ROADMAP.md`](NOVEL_ROADMAP.md) §3.D + §3.E.
Twenty-one `hxm-*` candidates spanning quantum-defect hosts, skyrmion /
antiferromagnetic memory, magnonics, magnetocaloric, Pb-free piezo,
topological / Weyl / flat-band / time-domain metamaterials, LED / OLED /
μLED / UVC, and LC / QD / electrochromic / NLO. Every entry is
`status = DESIGN`, every falsifier is quantitative with an `F-<CODE>-N`
tag, and every UNPROVEN / HARD_WALL marker (²⁸Si enrichment cost, skyrmion
size, Pb halide migration) is preserved verbatim per
the §3.1–3.23 Round-1 / Round-2 rows are modified — overlap with §3.5
(magnetic), §3.12 (topological), §3.20 (ferroelectric thin films) is
deliberately landed as NEW `-002` / `-001` rows in §4.C, NOT by editing
upstream sections.

### 4.C.1 Quantum-defect hosts (Si:P donor, hBN VB⁻, vanadyl-phthalocyanine)

Hypothesis: three orthogonal quantum-defect host platforms — (a) ³¹P
donor in isotopically-purified ²⁸Si bulk (Kane 1998 scheme), processed
by ion-implantation through Si-on-insulator with global ²⁸Si enrichment
to ≥ 99.99 % (depleting ²⁹Si nuclear-spin bath below 50 ppm), can
sustain electron-spin T₂ ≥ 10 s at 100 mK while supporting single-shot
readout fidelity ≥ 99 % via SET / RF-SET charge sensing; (b) the
negatively-charged boron-vacancy V_B⁻ color center in hexagonal boron
nitride (hBN), generated by ion-irradiation of CVD-grown multilayer hBN,
can deliver ODMR contrast ≥ 1 % at 300 K with Hahn-echo T₂ ≥ 100 ns; (c)
a vanadyl-phthalocyanine (VOPc) molecular qubit, deposited as a sublimed
thin film on Au(111) / α-Al₂O₃, can hold T₁ ≥ 1 ms at 5 K with ensemble
spin-coherence T_M ≥ 100 μs. Lab / vendor authority: **Diraq** and
**Silicon Quantum Computing (SQC)** for Si:P donor qubits (UNSW Kane /
Morello / Dzurak / Simmons lineage); **Wrachtrup-Stuttgart** for hBN
VB⁻ and color-center metrology (also Toth / Aharonovich UTS); Sessoli
(Florence) and van Slageren (Stuttgart) for VOPc / molecular qubits;
isotopic ²⁸Si feedstock from Urenco / International Avogadro Project

| ID                          | class    | target              | brief                                                | status | falsifier                             |
|-----------------------------|----------|---------------------|------------------------------------------------------|--------|---------------------------------------|
| `hxm-quantum-si-donor-001`  | quantum  | ²⁸Si:P donor qubit   | ³¹P donor in ²⁸Si-enriched (≥ 99.99 %) host; Kane-scheme single-shot SET readout | SIM-NNP-PROXY | F-QUANTUM-2: electron-spin T₂ < 10 s @ 100 mK OR single-shot readout fidelity < 99 % → FAIL |
| `hxm-quantum-hbn-vb-001`    | quantum  | hBN V_B⁻ color center | ion-irradiated CVD multilayer hBN; ODMR + Hahn-echo at 300 K | SIM-NNP-PROXY | F-QUANTUM-3: ODMR contrast < 1 % @ 300 K OR Hahn-echo T₂ < 100 ns @ 300 K → FAIL |
| `hxm-quantum-mol-vopc-001`  | quantum  | vanadyl-phthalocyanine (VOPc) | sublimed thin film molecular qubit on Au(111) / α-Al₂O₃; 5 K operation | DESIGN | F-QUANTUM-4: T₁ < 1 ms @ 5 K OR ensemble T_M coherence < 100 μs → FAIL |

**Risk-flags**: ²⁸Si enrichment cost **HARD_WALL** — International
Avogadro Project pricing UNVERIFIED at commodity scale; centrifuge route
(Urenco) carries dual-use export-control friction; sub-50-ppm ²⁹Si
target requires multi-pass enrichment + chemical purification UNVERIFIED
at 200/300-mm wafer scale. hBN V_B⁻ ODMR contrast in natural-abundance
hBN currently ~ 0.3–0.8 % (Gottscholl 2020 Nat. Mater.); reaching ≥ 1 %
at 300 K with usable T₂ requires ¹⁰B / ¹¹B isotope control UNVERIFIED at
wafer scale. VOPc thin-film T_M is highly substrate-dependent; Au(111)
quenches via Kondo, dielectric substrates (α-Al₂O₃) preferred but
deposition control of molecular orientation HARD_WALL at sub-monolayer
coverage. Device-layer integration (qubit array routing, on-chip
microwave delivery) belongs to **hexa-chip** per CROSS_LINK §3.2 — this
ledger owns the MATERIAL layer only.
**Verb spec link** (Tier-2, `hxm-quantum-si-donor-001`): see [`silicon/silicon.md`](silicon/silicon.md) — material-layer authority for ²⁸Si-enriched host chemistry (isotope enrichment + ³¹P donor incorporation = Si material layer; qubit device integration → hexa-chip).
**Verb spec link** (Tier-2, `hxm-quantum-hbn-vb-001`): see [`2d-materials/2d-materials.md`](2d-materials/2d-materials.md) — material-layer authority for hBN V_B⁻ color-center chemistry (ion-irradiated CVD multilayer hBN; ODMR + Hahn-echo room-T metrology; isotope-control UNVERIFIED at wafer scale preserved verbatim).

### 4.C.2 Skyrmions / antiferromagnetic memory (Mn₁.₄PtSn, Mn₃Sn)

Hypothesis: (a) a heterostructure of Mn₁.₄PtSn / Pt grown by co-sputtering
can host a Néel-type skyrmion lattice that remains topologically stable
above 300 K under modest field (B ≤ 50 mT) with average skyrmion radius
≤ 50 nm; (b) a (0001)-textured Mn₃Sn film (kagome-lattice non-collinear
antiferromagnet) grown by molecular-beam epitaxy on MgO can exhibit a
giant intrinsic spin-Hall angle θ_SH ≥ 0.1 and support deterministic
current-induced 180° switching at current density J_sw ≤ 100 mA/cm². Lab
authority: Parkin group (Halle / IBM Almaden lineage, skyrmion-racetrack
corpus 2016–2024); Nakatsuji / Otani (UTokyo / RIKEN) for Mn₃Sn
anomalous-Hall + spin-Hall; Tokura (RIKEN CEMS) for skyrmion materials

| ID                    | class   | target              | brief                                                | status | falsifier                             |
|-----------------------|---------|---------------------|------------------------------------------------------|--------|---------------------------------------|
| `hxm-skyrm-mnptsn-001`| skyrm   | Mn₁.₄PtSn / Pt heterostructure | Néel-type skyrmion lattice; B ≤ 50 mT; T > 300 K stability | DESIGN | F-SKYRM-1: skyrmion lattice stable > 300 K → false → FAIL |
| `hxm-armag-mn3sn-001` | armag   | Mn₃Sn kagome AFM    | (0001)-textured MBE film on MgO; spin-Hall memory      | DESIGN | F-ARMAG-1: spin-Hall angle θ_SH < 0.1 OR switching current J_sw > 100 mA/cm² → FAIL |

**Risk-flags**: skyrmion size **HARD_WALL** — sub-10-nm skyrmions
demand Dzyaloshinskii-Moriya interaction strengths UNVERIFIED in
Mn₁.₄PtSn at RT; competing antiskyrmion / hexagonal-skyrmion phase
boundaries narrow the (T, B) stability window typically < 30 K wide;
substrate-induced strain on Pt buffer UNVERIFIED at wafer scale; Mn₃Sn
domain-wall pinning at grain boundaries UNVERIFIED at < 100 nm device
pitch; antiferromagnetic readout (anomalous Hall, magneto-optical Kerr)
SNR HARD_WALL vs. ferromagnetic readout — typical signal 100–1000× weaker.
Cell / device-layer routing belongs to **hexa-chip** per CROSS_LINK §3.2.

### 4.C.3 Magnonics / magnetocaloric / Pb-free piezo (YIG, LaFeSi, KNN, BNT-BT)

Hypothesis: (a) a Y₃Fe₅O₁₂ (YIG) film of 100–500 nm thickness grown by
pulsed-laser-deposition or liquid-phase-epitaxy on (111)-Gd₃Ga₅O₁₂ (GGG)
substrate can hit Gilbert damping α ≤ 1 × 10⁻⁵ with thickness uniformity
≤ 5 % across a 4-inch wafer (the low-damping reference for magnonic
logic); (b) a La(Fe,Si,Mn)₁₃H_x first-order magnetocaloric alloy near the
Curie point of ~ 290 K can sustain adiabatic temperature change ΔT_ad
≥ 4 K under a 2 T field with thermal hysteresis ≤ 0.5 K; (c) a (K,Na)NbO₃
(KNN) Pb-free piezoceramic processed by templated grain growth + Mn/Li
modifications can hit d₃₃ ≥ 400 pC/N at 25 °C with Curie point T_c ≥ 350
°C; (d) a (1-x)Bi₀.₅Na₀.₅TiO₃ – xBaTiO₃ (BNT-BT) Pb-free piezoceramic at
the morphotropic phase boundary can reach d₃₃ ≥ 300 pC/N with depolarization
temperature T_d ≥ 150 °C. Lab / vendor authority: Schultheiss (Dresden /
IFW), Hillebrands (TU Kaiserslautern) for YIG magnonics; Innovent /
INNOVENT for GGG-substrate epitaxy; Vacuumschmelze / Erbicol /
Krüger-Mecatronic for LaFeSi magnetocaloric (UNVERIFIED at commodity
scale); **PFEIFFER Vacuum / Tasso (TU Darmstadt)** for KNN piezo; Rödel
(TU Darmstadt) for BNT-BT; Murata / TDK / NGK Spark Plug / PI Ceramic /

| ID                    | class   | target              | brief                                                | status | falsifier                             |
|-----------------------|---------|---------------------|------------------------------------------------------|--------|---------------------------------------|
| `hxm-magnon-yig-001`  | magnon  | Y₃Fe₅O₁₂ / GGG (111)  | LPE/PLD film 100–500 nm; magnonic-logic substrate    | DESIGN | F-MAGNON-1: Gilbert damping α > 1 × 10⁻⁵ OR film-thickness uniformity > 5 % on 4-inch wafer → FAIL |
| `hxm-mcal-lafesi-001` | mcal    | La(Fe,Si,Mn)₁₃H_x   | first-order magnetocaloric near 290 K; 2 T field      | DESIGN | F-MCAL-1: adiabatic ΔT_ad < 4 K @ 2 T near 290 K OR hysteresis > 0.5 K → FAIL |
| `hxm-piezo-knn-001`   | piezo   | (K,Na)NbO₃ + Mn/Li  | templated grain growth Pb-free piezoceramic           | DESIGN | F-PIEZO-1: d₃₃ < 400 pC/N @ 25 °C OR Curie T_c < 350 °C → FAIL |
| `hxm-piezo-bnt-bt-001`| piezo   | (1-x)Bi₀.₅Na₀.₅TiO₃ – xBaTiO₃ | morphotropic-phase-boundary Pb-free piezo      | DESIGN | F-PIEZO-2: d₃₃ < 300 pC/N OR depolarization T_d < 150 °C → FAIL |

**Risk-flags**: GGG-substrate epitaxy for YIG is a known
single-supplier (Innovent / SurfaceNet) **HARD_WALL** on 4-inch wafer
diameter; sub-1e-5 α requires sub-nm interface roughness UNVERIFIED at
wafer-uniform process. LaFeSi hydrogen content (H_x) drifts under
thermal cycling — long-term ΔT_ad stability UNVERIFIED past 10⁴ cycles;
hysteresis vs. first-order transition fundamentally entangled, ≤ 0.5 K
target borderline. KNN sintering window narrow (1080–1140 °C) — densification
> 97 % UNVERIFIED at industrial scale; alkali volatilization (K / Na loss)
shifts MPB UNVERIFIED at production. BNT-BT depolarization is intrinsic
to relaxor-ferroelectric thermal evolution; T_d shifts under DC bias
UNVERIFIED at module operating conditions. Pb-free piezo parity with PZT
(d₃₃ ~ 500–600 pC/N) **NOT YET REACHED** at commodity scale — Pb
restriction (RoHS) drives demand but UNVERIFIED at high-strain actuator
applications.

### 4.C.4 Topological / Weyl / flat-band / time-domain (Bi₂Se₃, TaAs, TBG, td-photonic)

Hypothesis: (a) a Bi₂Se₃ topological-insulator film with surface-state
ARPES Dirac-cone gap ≤ 30 meV AND surface-state mobility ≥ 5000 cm²/(V·s)
can be grown by MBE on (111)-Si or Al₂O₃ — this extends the existing
`hxm-top-bi2se3-001` (room-T surface conductivity target) into the
spectroscopic-quality regime; (b) a TaAs Weyl-semimetal single crystal
can display the chiral-anomaly-induced negative longitudinal
magnetoresistance signature of Berry curvature in transport, with
clear deviation from B² Hall background; (c) a magic-angle (1.05–1.10°)
twisted bilayer graphene (TBG) stack can host correlated superconducting
order at T_c ≥ 1.5 K with twist-angle precision better than 0.1°
across the device; (d) a time-domain photonic metamaterial — a structure
periodically modulated in time rather than space, e.g. ITO with sub-ps
optical pumping or graphene gate-modulated at > 100 GHz — can deliver
frequency-conversion efficiency ≥ 10 % with modulation rate ≥ 100 GHz.
Lab authority: Hasan / Bansil / Cava (Princeton) for TI / Weyl ARPES;
Hsieh / Shen (Stanford / MIT) for Bi₂Se₃ ARPES; Jarillo-Herrero (MIT)
+ Andrei (Rutgers) for TBG superconductivity (Cao 2018 Nature); Engheta
(UPenn) + Alù (CUNY Photonics) for time-domain metamaterials; Wolfspeed
production is research-scale, not commodity). Status DESIGN.

| ID                       | class    | target              | brief                                                | status | falsifier                             |
|--------------------------|----------|---------------------|------------------------------------------------------|--------|---------------------------------------|
| `hxm-top-bi2se3-002`     | top      | Bi₂Se₃ TI surface (ARPES quality) | MBE on (111)-Si or Al₂O₃; extends -001 into spectroscopic regime | DESIGN | F-TOP-4: ARPES Dirac-cone gap > 30 meV OR surface-state mobility < 5000 cm²/(V·s) → FAIL |
| `hxm-weyl-tas-001`       | weyl     | TaAs Weyl semimetal | chiral-anomaly negative MR; Berry curvature signature | SIM-NNP-PROXY | F-WEYL-1: Berry curvature absent in Hall measurement (no negative longitudinal MR + no B-linear AHE term) → FAIL |
| `hxm-flatband-tbg-001`   | flatband | magic-angle (1.05–1.10°) TBG | hBN-encapsulated dual-gated stack; correlated SC      | SIM-NNP-PROXY | F-FLATBAND-1: superconducting T_c < 1.5 K OR twist-angle precision worse than 0.1° across device → FAIL |
| `hxm-tdmeta-photonic-001`| tdmeta   | time-domain photonic metamaterial | ITO sub-ps pump or graphene > 100 GHz gate modulation | SIM-NNP-PROXY | F-TDMETA-1: frequency-conversion efficiency < 10 % OR modulation rate < 100 GHz → FAIL |

**Risk-flags**: Bi₂Se₃ surface-state mobility is bulk-Se-vacancy-limited
— intrinsic n-doping HARD_WALL drives Fermi level into bulk conduction
band; reaching ≥ 5000 cm²/(V·s) in the SURFACE channel (not bulk)
UNVERIFIED at thin-film geometry. TaAs Weyl signature is a transport
fingerprint — current jetting + extrinsic magnetoresistance artifacts
contaminate negative-MR claims (Arnold 2016 + Reis 2016 controversies);
Berry-curvature Hall extraction requires careful subtraction of ordinary
+ anomalous Hall components UNVERIFIED outside academic single-crystal
batches. TBG twist-angle precision **HARD_WALL** at 0.1° — drift /
relaxation / lattice reconstruction routinely degrades effective
twist; superconducting fraction depends on encapsulation hBN cleanliness
UNVERIFIED at wafer scale. Time-domain metamaterials are an
arXiv-corpus-young field — > 100 GHz modulation at ≥ 10 % conversion
efficiency UNVERIFIED beyond proof-of-principle 2023–2025 reports;
ITO-pump dispersion limits bandwidth. Device-layer integration belongs
to **hexa-chip** per CROSS_LINK §3.2; none of these candidates claim
RT-SC (per AGENTS.md A4 + `hexa-rtsc` boundary).
**Verb spec link** (Tier-2, `hxm-weyl-tas-001`): see [`compound-semi/compound-semi.md`](compound-semi/compound-semi.md) — material-layer authority for TaAs Weyl-semimetal compound chemistry (CVT single-crystal growth; Berry-curvature transport metrology; Majorana CONTESTED preserved verbatim per §3.12).
**Verb spec link** (Tier-2, `hxm-flatband-tbg-001`): see [`2d-materials/2d-materials.md`](2d-materials/2d-materials.md) — material-layer authority for twisted bilayer graphene moiré-superlattice chemistry (hBN-encapsulated tear-and-stack assembly; magic-angle 1.05-1.10° flat-band; flat-band TBG twist-precision UNVERIFIED preserved verbatim).

### 4.C.5 LED / OLED / μLED / UVC (perovskite LED, blue TADF OLED, InGaN μLED, AlN UVC)

Hypothesis: four display / illumination emitter platforms — (a) a
perovskite LED with a mixed 3D + 2D-Ruddlesden-Popper FAPbBr₃ / quasi-2D
emissive layer can reach external quantum efficiency EQE ≥ 20 % with
T₅₀ lifetime ≥ 10⁴ h at 100 cd/m² luminance and full encapsulation;
(b) a thermally-activated delayed-fluorescence (TADF) blue OLED stack
using a deep-blue donor-acceptor emitter (e.g. v-DABNA-class) can reach
EQE ≥ 30 % at 1000 cd/m² while covering ≥ 80 % of BT.2020 blue gamut;
(c) an InGaN red micro-LED with characteristic device size < 10 μm can
reach EQE ≥ 5 % with sidewall non-radiative loss ≤ 30 % (the open
problem at < 10 μm dot size); (d) an AlN deep-UV LED emitting at 265 nm
(UVC-disinfection band) can reach wall-plug efficiency ≥ 10 % with L₅₀
lifetime ≥ 1000 h. Lab / vendor authority: Friend (Cambridge) /
Sargent (Northwestern formerly Toronto) for perovskite LEDs; Adachi
(Kyushu OPERA) + Wong (HKUST) for TADF blue OLEDs; **Samsung Display /
LG Display / JDI / BOE / Visionox** for OLED display commodity; **Aledia
/ PlayNitride / VueReal / Mojo Vision / Plessey / Jade Bird Display**
for micro-LED; **Crystal IS / Asahi Kasei / NS Nanotech / Bolb /
Trinity Optech / RayVio / DOWA / SETi (Stanley)** for AlN deep-UV LEDs

| ID                              | class       | target              | brief                                                | status | falsifier                             |
|---------------------------------|-------------|---------------------|------------------------------------------------------|--------|---------------------------------------|
| `hxm-display-led-perled-001`    | display-led | mixed 3D + 2D FAPbBr₃ perovskite LED | quasi-2D Ruddlesden-Popper emissive layer; full encapsulation | DESIGN | F-DISPLAY-LED-1: EQE < 20 % OR T₅₀ lifetime < 10⁴ h @ 100 cd/m² → FAIL |
| `hxm-display-led-blueoled-001`  | display-led | deep-blue TADF OLED  | v-DABNA-class donor-acceptor emitter                  | DESIGN | F-DISPLAY-LED-2: EQE < 30 % @ 1000 cd/m² OR BT.2020 blue gamut coverage < 80 % → FAIL |
| `hxm-display-led-microled-001`  | display-led | InGaN red μLED < 10 μm | KOH / ALD sidewall passivation; pick-and-place transfer | DESIGN | F-DISPLAY-LED-3: EQE < 5 % OR sidewall non-radiative loss > 30 % → FAIL |
| `hxm-display-led-uvc-001`       | display-led | AlN UVC LED @ 265 nm | high-Al-content AlGaN MQW on AlN template            | DESIGN | F-DISPLAY-LED-4: wall-plug efficiency < 10 % OR L₅₀ < 1000 h → FAIL |

**Risk-flags**: Pb halide migration **HARD_WALL** in perovskite LEDs —
ion-migration drives roll-off, device degradation, and electrode
corrosion; encapsulation against moisture + ion-egress UNVERIFIED at
10⁴ h L100 (current state of the art ~ 10²–10³ h); RoHS / REACH
restrictions on Pb threaten commodity deployment UNVERIFIED. TADF blue
OLED roll-off at high luminance + T-T annihilation UNVERIFIED at
display lifetime targets; BT.2020 blue (467 nm) requires deeper-blue
emitter than typical TADF donors deliver. Micro-LED sidewall NR loss is
a **fundamental size-scaling** problem — at < 10 μm dot, perimeter /
area ratio inverts the loss budget; KOH + ALD sidewall passivation
helps but UNVERIFIED at mass-transfer yields > 99.999 % required for
4K-display panels (∼ 25M dots per panel). AlN UVC wall-plug record is
~ 10 % (2023, Asahi Kasei), L₅₀ at usable currents UNVERIFIED at 1000
h; high-Al-content AlGaN p-doping (Mg activation) HARD_WALL. Device /
panel-layer integration belongs to **hexa-chip** per CROSS_LINK §3.2 —
this ledger owns the EMITTER MATERIAL layer only.

### 4.C.6 LC / QD / electrochromic / NLO (blue-phase LC, InP/ZnSe QD, NiO/WO₃, KNbO₃)

Hypothesis: four orthogonal photonic / display material platforms —
(a) a polymer-stabilized blue-phase liquid crystal (PS-BPLC) cell can
support sub-ms electro-optic switching (response time τ ≤ 1 ms) over an
operating temperature range ≥ 30 °C (e.g. 0–60 °C); (b) an InP / ZnSe
core / multi-shell Cd-free quantum-dot emitter can deliver photoluminescence
FWHM ≤ 25 nm with quantum yield ≥ 90 % across the visible band; (c) a
NiO / WO₃ all-solid-state electrochromic device (smart window) can
sustain cycle life ≥ 10⁶ with visible-light transmittance contrast
Δτ ≥ 0.6; (d) a KNbO₃ single-crystal nonlinear optical (NLO) plate can
deliver effective second-order coefficient d_eff ≥ 10 pm/V across UV-VIS
with laser-induced damage threshold ≥ 100 GW/cm² (sub-ns pulse). Lab /
vendor authority: **Merck KGaA** (Darmstadt) for liquid-crystal commodity;
Kikuchi (Tokyo Tech) for PS-BPLC; Bawendi (MIT) / Klimov (LANL) /
**Nanoco / Nanosys / Quantum Solutions** for QD; **Saint-Gobain /
SAGE Glass / View Inc. / ChromoGenics / Gentex** for electrochromic;
**Castech / Cristal Laser / Eksma Optics / Newlight Photonics** for

| ID                          | class      | target              | brief                                                | status | falsifier                             |
|-----------------------------|------------|---------------------|------------------------------------------------------|--------|---------------------------------------|
| `hxm-display-lc-bluephase-001` | display-lc | polymer-stabilized blue-phase LC | sub-ms switching; 0–60 °C operating window | DESIGN | F-DISPLAY-LC-1: switching time > 1 ms OR operating-temperature range < 30 °C → FAIL |
| `hxm-display-qd-cdfree-001` | display-qd | InP / ZnSe Cd-free QD | core / multi-shell visible-band emitter | DESIGN | F-DISPLAY-QD-1: FWHM > 25 nm OR quantum yield < 90 % → FAIL |
| `hxm-ec-glass-niowo3-001`   | ec         | NiO / WO₃ EC stack    | all-solid-state smart-window electrochromic device     | DESIGN | F-EC-1: cycle life < 10⁶ OR visible-light contrast Δτ < 0.6 → FAIL |
| `hxm-nlo-knbo3-001`         | nlo        | KNbO₃ single-crystal NLO | UV-VIS d_eff; sub-ns pulse damage threshold        | DESIGN | F-NLO-1: d_eff < 10 pm/V OR laser-induced damage threshold < 100 GW/cm² → FAIL |

**Risk-flags**: PS-BPLC temperature window in pure-bluephase form is
intrinsically narrow (< 5 °C without polymer stabilization); polymer
network broadens to ≥ 30 °C but residual birefringence + hysteresis
HARD_WALL at gray-scale fidelity; commercial deployment UNVERIFIED at
panel scale (Samsung BPLC TV prototype 2008 → discontinued). InP / ZnSe
QD FWHM at red wavelengths (620–640 nm) borderline 25 nm; **In supply
chain** UNVERIFIED at display-volume scale (single-source dependence on
indium-phosphide precursors); Cd-Hg-free regulatory tailwind real,
performance parity to CdSe QY ~ 95 % UNVERIFIED. NiO / WO₃ EC cycle
life **HARD_WALL** on Li-ion intercalation electrolyte stability; > 10⁶
cycles UNVERIFIED at commodity scale (SAGE / View baseline ~ 10⁵
cycles); switching time vs. window size scales unfavorably (large panes
require minutes). KNbO₃ damage threshold is highly sensitive to growth
defects + surface polish — bulk d_eff well-characterized (~ 14–20 pm/V
for d₃₂ at 1064 nm) but at ≥ 100 GW/cm² UNVERIFIED at production
quality; competing β-BaB₂O₄ (BBO) + LiB₃O₅ (LBO) commodity ecosystem
(Castech / EksmaOptics) saturates the NLO-crystal market — KNbO₃
adoption UNVERIFIED at industrial NLO-conversion volume. Module-level
integration (LC panel, QD-LED stack, EC-window glazing, NLO-conversion
laser systems) belongs to **hexa-chip** / **hexa-energy** per CROSS_LINK
§3.2/§3.3 — this ledger owns the EMITTER / SWITCH / NLO-CRYSTAL
MATERIAL layer only.

---

### 4.D Structural + polymers (Round 3 — `NOVEL_ROADMAP.md` §3.F + §3.G)

#### 4.D.1 Titanium alloys (`ti-*`) — 2 candidates

Hypothesis: a β-Ti `Ti-15V-3Cr-3Sn-3Al` (Ti-15-3) cold-rollable
strip optimized via solution-treat + age can deliver σ_y ≥ 1300 MPa
at Young's modulus ≤ 80 GPa, matching the medical-implant
bone-modulus-match target. A parallel intermetallic `γ-TiAl` route
(2nd-gen Boeing 787 LP turbine blade chemistry; GE9X variant)
targets ductile-to-brittle transition (DBTT) ≤ 600 °C with creep
life ≥ 100 h at 800 °C / 250 MPa. Vendor / lab authority: **ATI
Metals** (Ti-15-3 wrought baseline), **Boeing 787 LP turbine** +
**GE Aviation GE9X** (γ-TiAl flight-qualified hot section),
**ASTM F1813** (β-Ti orthopedic standard). Status DESIGN.

| ID                          | class | target              | brief                          | status | falsifier                             |
|-----------------------------|-------|---------------------|--------------------------------|--------|---------------------------------------|
| `hxm-ti-beta-15-3-001`      | ti    | Ti-15V-3Cr-3Sn-3Al  | β-Ti cold-rolled strip, medical-implant modulus match | DESIGN | F-TI-1: σ_y < 1300 MPa OR Young modulus > 80 GPa (medical-implant target) → FAIL |
| `hxm-ti-gamma-tial-001`     | ti    | γ-TiAl intermetallic | 2nd-gen Boeing 787 LP / GE9X-class chemistry | DESIGN | F-TI-2: DBTT > 600 °C OR creep life @ 800 °C / 250 MPa < 100 h → FAIL |

**Risk-flags**: Ti-15-3 oxygen pickup during hot-roll degrades
ductility above 0.25 wt% O — UNVERIFIED at strip-mill scale; β-Ti
medical-implant ion release (V, Cr) regulatory caveat ASTM F1813 +
ISO 10993 — out-of-software (Category (c)); γ-TiAl room-temperature
ductility HARD_WALL (typical < 2% strain-to-fracture); environmental
embrittlement of γ-TiAl in air above 700 °C UNVERIFIED for ≥ 10⁴ h
service; additive-manufactured γ-TiAl porosity / lamellar texture
control UNVERIFIED at production. SPEC_FIRST only — wrought + flight
qualification belongs to Category (c).

#### 4.D.2 Nickel superalloys (`ni-*`) — 2 candidates

Hypothesis: a 4th-generation Ni single-crystal (SX) chemistry that
substitutes Re-bearing γ′-strengthening with Ru / W / Ta / Cr
balance can match CMSX-10 / René N6 creep life @ 1050 °C / 137 MPa
≥ 400 h while keeping oxidation rate ≤ 0.1 mg/cm²/h — eliminating
Re ($10⁵/kg + 50-yr supply concentration). A parallel LPBF route
takes IN939 powder, post-HIP at 1160 °C / 100 MPa / 4 h, and
targets relative density ≥ 99.9% with creep anisotropy ≤ 30%
between build / transverse directions. Vendor / lab authority:
**Special Metals** (IN939 wrought + cast baseline), **GE Aviation**
+ **Rolls-Royce** + **Pratt & Whitney** (SX turbine blade alloy
roadmap), **CMSX-10 / René N6** as Re-bearing comparator,
**Cannon-Muskegon** (master heat).
**Re-free 4th-gen SX UNVERIFIED at production parity preserved
verbatim** (per `superalloy/superalloy.md` row). Status DESIGN.

| ID                          | class | target              | brief                          | status | falsifier                             |
|-----------------------------|-------|---------------------|--------------------------------|--------|---------------------------------------|
| `hxm-ni-4gen-re-free-001`   | ni    | Re-free 4th-gen SX  | Ru/W/Ta/Cr-balanced SX (TIER-2) | SIM-NNP-PROXY | F-NI-1: creep life @ 1050 °C / 137 MPa < 400 h OR oxidation rate > 0.1 mg/cm²/h → FAIL |
| `hxm-ni-am-in939-001`       | ni    | LPBF IN939 post-HIP | additive IN939 + HIP densification | DESIGN | F-NI-2: relative density < 99.9% OR creep anisotropy @ 800 °C / 200 MPa > 30% → FAIL |

**Risk-flags**: **Re-free 4th-gen SX UNVERIFIED at parity** — CMSX-10
+ René N6 incumbents both Re-bearing; CMSX-10K @ 6 wt% Re, René N6
@ 5.4 wt% Re — production parity of Re-free chemistry remains an
open SOFT_WALL per `superalloy/superalloy.md` line; topologically-
close-packed (TCP) phase precipitation in high-W/Ta Re-free
chemistry UNVERIFIED for ≥ 10⁴ h service; LPBF IN939 keyhole
porosity + powder oxygen pickup HARD_WALL at gas-atomized
< 50 ppm O target; post-HIP grain coarsening above 1200 °C
UNVERIFIED for fine-equiax retention; production-scale SX casting
yield to single-crystal grain selector belongs to Category (c)
(Cannon-Muskegon / PCC Airfoils).
**Verb spec link** (Tier-2, `hxm-ni-4gen-re-free-001`): see [`superalloy/superalloy.md`](superalloy/superalloy.md) — material-layer authority for Re-free 4th-gen SX chemistry (UNVERIFIED-at-parity marker preserved in superalloy.md).

#### 4.D.3 Carbon fiber precursors (`cf-*`) — 2 candidates

Hypothesis: a T1100-class PAN-derived carbon fiber (Toray T1100G /
T1100S baseline σ_t = 7.0 GPa, modulus 324 GPa at 6 μm filament)
can be replicated via stabilized PAN spinneret + N₂ carbonization
2000 °C + graphitization 2500 °C, with σ_t ≥ 7 GPa and modulus
≥ 320 GPa. A second route — Oak Ridge National Laboratory's
lignin-precursor route (Kraft-lignin / softwood organosolv-lignin
melt-spun + thermostabilized + carbonized) — targets σ_t ≥ 1.5 GPa
at pilot-scale cost ≤ $5/lb, replacing PAN ($/kg) for non-aerospace
structural composites. Vendor / lab authority: **Toray** (T1100
world record), **Hexcel** + **Mitsubishi Chemical** (PAN-CF
comparator), **Oak Ridge National Laboratory** + **Carbon Nexus
Australia** (lignin-CF pilot lines, **feedstock variability
UNVERIFIED**). Status DESIGN.

| ID                          | class | target              | brief                          | status | falsifier                             |
|-----------------------------|-------|---------------------|--------------------------------|--------|---------------------------------------|
| `hxm-cf-t1100-001`          | cf    | T1100-class PAN CF  | Toray T1100G replication route | DESIGN | F-CF-1: tensile σ < 7 GPa OR modulus < 320 GPa → FAIL |
| `hxm-cf-lignin-001`         | cf    | lignin-derived CF   | Oak Ridge lignin precursor pilot | DESIGN | F-CF-2: tensile σ < 1.5 GPa OR cost > $5/lb at pilot scale → FAIL |

**Risk-flags**: PAN T1100-class spinneret + draw-stretch sequence
HARD_WALL on radial-defect density; sub-1-μm void in T1100 negates
σ_t target; lignin feedstock variability HARD_WALL — Kraft vs.
organosolv vs. soda lignin glass-transition spread 100 °C; lignin
char yield UNVERIFIED above 50% (PAN benchmark ~ 55%); pilot-scale
cost ≤ $5/lb UNVERIFIED at sustained throughput (Oak Ridge
demonstration cell only); environmental footprint of acrylonitrile
monomer (PAN) HARD_WALL (petrochemical, > 8 kg CO₂eq / kg fiber);
prepreg + weave step belongs to Category (c) (Hexcel / Cytec / TenCate).

#### 4.D.4 Ultra-high-temperature ceramics (`uhtc`) — 2 candidates

Hypothesis: a ZrB₂-20vol%SiC composite, hot-pressed at 1900 °C / 30
MPa with 1 vol% graphite, can sustain oxidation rate ≤ 5 μm/min at
2000 °C / 1 atm air while retaining ≥ 70% of room-T flexural
strength after a quench from 1500 °C into 25 °C water (thermal-
shock retention). A second candidate, a TaC-HfC solid solution
(specifically Ta₀.₂Hf₀.₈C, the predicted high-T peak from Andrievskii
1967 + Wuchina 2007 + Cedillos-Barraza 2016), targets T_m ≥ 4200 °C
(world record region 4200–4250 °C) with room-T Vickers hardness
≥ 22 GPa. Vendor / lab authority: **NASA Glenn / Ames** (UHTC
hypersonic leading edge program), **Sandia National Laboratories**
(ZrB₂-SiC oxidation database), **Imperial College London**
(Cedillos-Barraza 2016 T_m measurement), **3M Technical Ceramics**
(SiC powder anchor). Status DESIGN.

| ID                          | class | target              | brief                          | status | falsifier                             |
|-----------------------------|-------|---------------------|--------------------------------|--------|---------------------------------------|
| `hxm-uhtc-zrbsi-001`        | uhtc  | ZrB₂-20vol%SiC      | hypersonic LE composite, oxidation-resistant | DESIGN | F-UHTC-1: oxidation rate @ 2000 °C / 1 atm air > 5 μm/min OR thermal-shock retention < 70% → FAIL |
| `hxm-uhtc-tac-hfc-001`      | uhtc  | TaC-HfC solid soln. | Ta₀.₂Hf₀.₈C, world-record T_m candidate | DESIGN | F-UHTC-2: T_m < 4200 °C OR RT Vickers hardness < 22 GPa → FAIL |

**Risk-flags**: ZrB₂-SiC active-to-passive oxidation transition
2000–2200 °C HARD_WALL — above ~2200 °C SiO₂ scale evaporates;
hot-press densification of ZrB₂-SiC > 99% theoretical density
UNVERIFIED without 1–2 vol% C / B₄C sintering aid (which then
becomes oxidation-active site); TaC-HfC peak T_m position
contested — Cedillos-Barraza 2016 measured 3990 °C max for
Ta₀.₈Hf₀.₂C (NOT 4200 °C — older Agte-Alterthum 1930 value
remains UNREPRODUCED); RT hardness of TaC-HfC solid solution
varies 20–28 GPa with composition + grain size; hypersonic
leading-edge service > 10³ s at Mach 7+ recession allowance
belongs to Category (c) (DARPA HTV / X-51 program).

#### 4.D.5 MAX phase (`cer-maxphase`) — 1 candidate

Hypothesis: a Cr₂AlC MAX phase synthesized by reactive hot-pressing
of Cr / Al / graphite powders at 1450 °C / 30 MPa / 1 h in vacuum
can sustain oxidation rate ≤ 1 μm/h at 1300 °C / 1 atm air via
Al₂O₃-scale self-passivation, while keeping fracture toughness
K_IC ≥ 8 MPa·m^0.5 (10× monolithic Cr₃C₂). Vendor / lab authority:
**Barsoum group (Drexel University)** — MAX-phase mechanical /
oxidation corpus 1996+; **Manoun + Lin** (Cr₂AlC oxidation studies
2007–2012); **Forschungszentrum Jülich** (high-T MAX phase
program); **Sandvik / Kanthal** (ferritic FeCrAl alumina-former
comparator). Status DESIGN.

| ID                              | class | target          | brief                          | status | falsifier                             |
|---------------------------------|-------|-----------------|--------------------------------|--------|---------------------------------------|
| `hxm-cer-maxphase-cr2alc-001`   | cer   | Cr₂AlC MAX phase | alumina-self-passivating MAX, high-K_IC ceramic | DESIGN | F-MAXPHASE-1: oxidation rate @ 1300 °C / 1 atm > 1 μm/h OR fracture toughness K_IC < 8 MPa·m^0.5 → FAIL |

**Risk-flags**: Cr₂AlC oxidation above 1300 °C transitions from
protective α-Al₂O₃ to non-protective spinel + Cr₂O₃ — HARD_WALL on
upper service temperature; phase-pure Cr₂AlC (no Cr₂AlC₂ /
Cr₃AlC₂ side phases) UNVERIFIED at hot-press scale; K_IC > 8
MPa·m^0.5 requires textured (basal-plane oriented) microstructure
which thermal cycling can randomize over 10³ cycles; thermal-spray
deposition of Cr₂AlC coatings on Ni-superalloy substrates
UNVERIFIED at production (alternative deposition route ⇒ HVOF /
cold spray); ETCH-RESISTANT-to-MXene precursor route (Cr₂AlC →
Cr₂C MXene via Al etching) — MXene class falls under §3.15 not
here.

#### 4.D.6 Low-CO₂ cements (`cement`) — 2 candidates

Hypothesis: a MgO-based carbon-negative cement (binder = reactive
MgO + Mg(OH)₂ + carbonate, e.g., Novacem / Calix / Brimstone
chemistry), cured under CO₂-rich atmosphere to form
hydrated-magnesium-carbonates (HMCs: nesquehonite, hydromagnesite,
dypingite), can sequester > 0.1 t CO₂ per m³ of cured concrete
(net-negative LCA boundary including MgO production) while
delivering 28-day compressive strength σ_c ≥ 30 MPa. A second
candidate is **Solidia-class** CO₂-cured low-lime calcium silicate
(wollastonite-rich CaSiO₃ binder, CO₂-cured at 60 °C / 1 atm CO₂
for 24 h to form calcite + amorphous silica), targeting σ_c ≥ 40
MPa with CO₂ uptake ≥ 100 kg/m³. Vendor / lab authority:
**Solidia Technologies** (CO₂-cured wollastonite, $30M-$50M
pilot), **CarbonCure** (CO₂-injected OPC concrete), **Brimstone
Energy** (Ca-silicate cement from non-carbonate feedstock),
**Calix** (calciner-decarbonization route), **Novacem
(defunct 2012, IP archived)** for MgO baseline. Tier-1
promotion per `NOVEL_ROADMAP.md` §5.

| ID                              | class  | target             | brief                          | status | falsifier                             |
|---------------------------------|--------|--------------------|--------------------------------|--------|---------------------------------------|
| `hxm-cement-mgo-co2neg-001`     | cement | MgO-based, CO₂-neg | reactive-MgO + HMC binder (TIER-1) | SIM-NNP-PROXY | F-CEMENT-1: net CO₂ emission per m³ cured > -0.1 t OR 28-day σ_c < 30 MPa → FAIL |
| `hxm-cement-ccs-cured-001`      | cement | Solidia-class      | CO₂-cured wollastonite calcium silicate | DESIGN | F-CEMENT-2: 28-day σ_c < 40 MPa OR CO₂ uptake < 100 kg/m³ → FAIL |

**Risk-flags**: **MgO source carbon-footprint accounting UNVERIFIED**
— MgO from calcined magnesite (MgCO₃ → MgO + CO₂) emits ~ 1.1 t
CO₂ / t MgO; the net-negative claim requires either (a) renewable-
calciner electricity + CCS-equipped calcination, OR (b) brine-
derived MgO route (Brimstone-style); LCA boundary sensitivity
HARD_WALL — net CO₂ varies ±0.3 t/m³ with boundary choice;
**durability UNVERIFIED** — long-term (> 10 yr) HMC carbonation
shrinkage + freeze-thaw resistance not in ASTM C672 corpus;
Solidia route is fundamentally **CO₂-uptake (carbonation)**, not
hydration — wet-service-life UNVERIFIED for ASTM C1543 chloride
ingress; production-scale displacement of OPC (4.3 Gt/yr global)
HARD_WALL — Solidia + CarbonCure combined < 0.1% market share
2024; reinforcement steel passivation requires pH > 12.5, MgO-
HMC binder pH ~ 10–11 ⇒ rebar corrosion HARD_WALL ⇒ glass-fiber
+ basalt-fiber reinforcement (out-of-software, Category (c)).
**SIM-NNP-PROXY status 2026-05-13** — predicted value vendored as
`_absorption_bridge/universal_ff/predictions/hxm-cement-mgo-co2neg-001.json`;
**Verb spec link**: see [`concrete_tech/concrete-technology.md`](concrete_tech/concrete-technology.md) — material-layer authority for this candidate's chemistry (novel binder chemistry home; distinct from `concrete/concrete.md` which anchors OPC mix-design F-CON-Q* falsifiers).

#### 4.D.7 Foams + transparent armor — 2 candidates

Hypothesis: a triply-periodic-minimal-surface (TPMS) lattice
(gyroid / Schwarz-P unit cell, 1 mm node spacing) printed in
Inconel 718 via LPBF + HIP can deliver specific energy absorption
≥ 30 J/g under quasi-static (10⁻³ /s) compression to 50% strain.
A second candidate is AlON (γ-Al₂₃O₂₇N₅, Magnesium Elektron / Surmet
**Spinel-AlON** transparent armor), sintered + HIP at 1900 °C +
1750 °C to ≥ 99.8% theoretical density, targeting **V50 ≥ 1500 m/s**
against 7.62×51 AP at 10 mm thickness with ≥ 80% optical
transmission (400–700 nm). Vendor / lab authority: **Surmet
Corporation** (AlON ALON™ transparent armor, US Army Natick
program), **Magnesium Elektron** (legacy AlON), **EOS / SLM
Solutions** (LPBF Inconel 718 process anchor), **Boeing Phantom
Works** (TPMS lattice impact research), **MIL-STD-662F**
(V50 ballistic test).

| ID                          | class | target              | brief                          | status | falsifier                             |
|-----------------------------|-------|---------------------|--------------------------------|--------|---------------------------------------|
| `hxm-foam-tpms-001`         | foam  | TPMS-lattice Inconel | LPBF + HIP gyroid foam, quasi-static EA | DESIGN | F-FOAM-1: specific energy absorption < 30 J/g @ 50% strain quasi-static → FAIL |
| `hxm-armor-alon-001`        | armor | AlON transparent armor | Surmet-class γ-Al₂₃O₂₇N₅, V50 + optical | DESIGN | F-ARMOR-1: V50 (10 mm, 7.62×51 AP) < 1500 m/s OR optical transmission < 80% (400–700 nm) → FAIL |

**Risk-flags**: TPMS-lattice LPBF dimensional accuracy at 1 mm
node spacing UNVERIFIED — staircase + powder-adhesion artefacts
distort the gyroid surface, reducing the closed-form EA / σ_y
prediction by 20–40%; post-HIP residual porosity UNVERIFIED at
< 0.1% for as-built lattice; strain-rate sensitivity HARD_WALL —
quasi-static (10⁻³ /s) EA does not extrapolate to high-rate
(10³ /s) impact without separate test campaign; AlON V50 vs.
sapphire vs. spinel (MgAl₂O₄) trade-off **vendor-confidential** —
absolute V50 depends on backing-plate spall liner; AlON
fracture-toughness K_IC ~ 2 MPa·m^0.5 ⇒ multi-hit defeat
UNVERIFIED above first impact; optical transmission ≥ 80%
requires < 1 ppm Si + Fe impurity in starting AlN powder —
HARD_WALL at commodity-AlN price.

#### 4.D.8 Vitrimers (recyclable thermoset, `vitrimer`) — 2 candidates

Hypothesis: a Diels-Alder (DA) vitrimer based on furan / maleimide
exchange chemistry can deliver thermal-relaxation transition
T_v ≥ 100 °C (allowing service ≤ 90 °C without flow) AND retain
≥ 50% original strength after 5 thermal-reflow recycle cycles. A
parallel transesterification vitrimer (epoxy / β-hydroxyester /
Zn-acetate catalyst, Leibler 2011 *Science* chemistry) targets
glass-transition T_g ≥ 60 °C with 100% strength retention after 10
reflow cycles. Vendor / lab authority: **Leibler group (ESPCI
Paris)** — vitrimer concept 2011 *Science* foundational paper;
**Mantarro Mantions / Mallinda LLC** (commercial vitrimer
polyimine startup); **Bowman group (CU Boulder)** (DA vitrimer
photoresponsive); **DSM / Aliphatic-Vitrimer Research Consortium**.
Status DESIGN.

| ID                          | class    | target          | brief                          | status | falsifier                             |
|-----------------------------|----------|-----------------|--------------------------------|--------|---------------------------------------|
| `hxm-vitrimer-da-001`       | vitrimer | Diels-Alder     | furan / maleimide DA exchange  | DESIGN | F-VITRIMER-1: relaxation T_v < 100 °C OR strength retention < 50% after 5 reflow cycles → FAIL |
| `hxm-vitrimer-ester-001`    | vitrimer | transesterification | epoxy / β-hydroxyester / Zn-cat Leibler 2011 | DESIGN | F-VITRIMER-2: T_g < 60 °C OR strength retention < 100% after 10 reflow cycles → FAIL |

**Risk-flags**: DA-vitrimer retro-DA above 120 °C
HARD_WALL — bonds reopen, network depolymerizes; furan / maleimide
chromophore yellows on UV exposure UNVERIFIED for outdoor service;
catalyst migration in transesterification vitrimer (Zn-acetate
leaching) reduces creep resistance over time UNVERIFIED at > 1 yr;
solvent-resistance trade-off — easier exchange ⇒ less solvent
resistance, fundamental UNVERIFIED at industrial coating service;
fiber-reinforced vitrimer composite (CFRP-replacement) — interface
hydrolysis HARD_WALL above 80% RH; reflow recyclability ≥ 5 cycles
≠ infinite recycle (Gibbs ΔS_mix HARD_WALL preserved per
`LIMIT_BREAKTHROUGH.md`).

#### 4.D.9 Self-healing polymers (`selfheal`) — 2 candidates

Hypothesis: a PDMS-urea hydrogen-bonded supramolecular elastomer
(Bao group / Stanford 2016 *Nature* chemistry, urea quadruple-H-
bond cross-link) can achieve tensile-strength recovery ≥ 80% after
24 h ambient autonomic healing while delivering strain-to-break
≥ 5× the original modulus length. A second candidate is an
ionogel (ionic-liquid-swollen polymer matrix) self-healing solid
electrolyte targeting ionic-conductivity recovery ≥ 95% within 1 h
and mechanical recovery ≥ 90% within 6 h. Vendor / lab authority:
**Bao group (Stanford)** — PDMS-urea + dynamic-network elastomer
corpus 2016+; **White group (UIUC)** — microcapsule-based self-
healing 2001 *Nature* original; **Aida group (RIKEN)** — ionogel
electrolyte; **Watanabe / Kanno groups (Tokyo Tech)** — ionic-
liquid Li-conductor anchor. Status DESIGN.

| ID                              | class    | target          | brief                          | status | falsifier                             |
|---------------------------------|----------|-----------------|--------------------------------|--------|---------------------------------------|
| `hxm-selfheal-pdms-urea-001`    | selfheal | PDMS-urea elastomer | Bao 2016-class supramolecular | DESIGN | F-SELFHEAL-1: tensile recovery < 80% @ 24 h, 25 °C OR strain-to-break < 5× original → FAIL |
| `hxm-selfheal-iono-001`         | selfheal | ionogel electrolyte | ionic-liquid + dynamic-bond electrolyte | DESIGN | F-SELFHEAL-2: σ_ionic recovery < 95% in 1 h OR mechanical recovery < 90% in 6 h → FAIL |

**Risk-flags**: PDMS-urea creep + permanent set after 100 healing
cycles UNVERIFIED — H-bond network slowly migrates; humidity
sensitivity HARD_WALL — urea H-bonds plasticized above 70% RH;
self-healing rate at low temperature (< 5 °C) drops > 10× ⇒
outdoor cold-climate service UNVERIFIED; ionic-liquid leaching
from ionogel HARD_WALL — capillary-driven loss ≥ 5 wt% / 100 h at
25 °C without barrier; ionogel electrochemical window typically <
4.0 V vs. Li/Li⁺ — high-voltage cathode pairing UNVERIFIED;
biocompatibility of ionic-liquid (imidazolium / phosphonium)
UNVERIFIED for skin-contact wearable use; cell-engineering
integration → `hexa-energy` per CROSS_LINK §3.3 (out-of-software).

#### 4.D.10 Shape memory (`sma`) — 2 candidates

Hypothesis: a Ni-Ti-Hf high-temperature SMA (Ni₅₀.₃Ti₂₉.₇Hf₂₀,
hot-rolled + solution-treated + aged at 550 °C / 3 h) can deliver
austenite-finish temperature A_f in the 100–150 °C operating
window with recoverable strain ≥ 4% over 10³ pseudoelastic cycles.
A parallel candidate is a thermoset shape-memory polymer (SMP)
based on epoxy-acrylate cross-linked network with T_g = 90 °C,
targeting recoverable strain ≥ 100% with recovery-temperature drift
≤ 5 °C over 10² thermal cycles. Vendor / lab authority: **NASA Glenn
Research Center** — Ni-Ti-Hf high-T SMA program for jet engine
chevrons; **Confluent Medical Technologies / SAES Smart Materials**
(NiTi orthopedic + stent vendor); **Mather group (Syracuse)** —
SMP foundational corpus; **CRG Industries / Cornerstone Research
Group** (commercial SMP). Status DESIGN.

| ID                          | class | target          | brief                          | status | falsifier                             |
|-----------------------------|-------|-----------------|--------------------------------|--------|---------------------------------------|
| `hxm-sma-niti-hf-001`       | sma   | Ni-Ti-Hf high-T SMA | A_f in 100–150 °C, 4% recoverable strain | DESIGN | F-SMA-1: A_f outside 100–150 °C OR recoverable strain < 4% → FAIL |
| `hxm-sma-polymer-smp-001`   | sma   | epoxy-acrylate SMP | thermoset SMP, T_g 90 °C, 100% recovery | DESIGN | F-SMA-2: recoverable strain < 100% OR recovery-temperature drift > 5 °C → FAIL |

**Risk-flags**: Ni-Ti-Hf cyclic A_f drift > 10 °C in first 10²
cycles is well-documented — UNVERIFIED whether aging schedule
stabilizes; Hf-rich phase (Ni₅₀Ti₂₀Hf₃₀) embrittles HARD_WALL >
30 at% Hf; cost of Hf metal (~ $1500/kg) HARD_WALL for commodity
applications — limits to aerospace + medical; SMP T_g drift > 5 °C
under repeated thermal cycling UNVERIFIED beyond 50 cycles; SMP
recovery-stress ≤ 5 MPa fundamental HARD_WALL (vs. NiTi ≥ 500 MPa)
⇒ load-bearing SMP UNVERIFIED; biocompatibility of Ni release from
NiTi-Hf for orthopedic implant — out-of-software (Category (c),
FDA ISO 10993 + biocompatibility chain).

#### 4.D.11 Conductive polymers (`polymer-pedot`) — 1 candidate

Hypothesis: a PEDOT:PSS film, post-treated with H₂SO₄ (concentrated
acid annealing, Heeger / Lee 2014 *Nat. Commun.* route) or with
ethylene-glycol secondary dopant, can sustain electrical
conductivity σ ≥ 5000 S/cm at 25 °C while retaining ≥ 90% σ after
1000 h at 85% relative humidity (electronic-skin / OPV / wearable
target). Vendor / lab authority: **Heraeus Clevios** (commercial
PEDOT:PSS PH1000 baseline σ ~ 1000 S/cm), **Heeger group (UC
Santa Barbara)** + **Lee group (Postech)** — H₂SO₄ post-treatment
4000 S/cm 2014; **Agfa-Gevaert Orgacon** (commercial transparent
electrode). Status DESIGN.

| ID                          | class   | target          | brief                          | status | falsifier                             |
|-----------------------------|---------|-----------------|--------------------------------|--------|---------------------------------------|
| `hxm-polymer-pedot-001`     | polymer | PEDOT:PSS > 5000 S/cm | H₂SO₄ or EG post-treatment, humidity-stable | DESIGN | F-POLYMER-1: σ < 5000 S/cm @ 25 °C OR humidity stability < 90% σ retention after 1000 h @ 85% RH → FAIL |

**Risk-flags**: H₂SO₄ post-treatment HARD_WALL — concentrated acid
incompatible with most substrate device stacks; >5000 S/cm σ
requires very thin (~ 50 nm) crystalline-bundle morphology
UNVERIFIED at > 200 nm; humidity-induced σ degradation HARD_WALL —
PSS is hygroscopic, drives π-stack disruption above 70% RH; UV
stability of PEDOT chromophore UNVERIFIED for > 500 h outdoor
service; biocompatibility for wearable / e-skin use — leaching of
PSS UNVERIFIED at ISO 10993 thresholds; alternative dopants
(PSTFSI, perfluoroalkyl-sulfonate) UNVERIFIED at conductivity
parity to H₂SO₄ route.

#### 4.D.12 Aerogels (extends §3.14 `aero`) — 2 candidates

Hypothesis: a polyimide aerogel (BPDA-PPDA or BPDA-ODA dianhydride
+ diamine chemistry, sol-gel + supercritical-CO₂ drying, NASA Glenn
Meador route) can deliver continuous service temperature ≥ 350 °C
in air while keeping thermal conductivity ≤ 0.018 W/(m·K). A second
candidate is a nanocellulose aerogel (TEMPO-oxidized cellulose
nanofiber + freeze-drying or supercritical CO₂), targeting density
≤ 50 mg/cm³ with k ≤ 0.025 W/(m·K) — biodegradable insulation
replacement for petroleum-based PU + XPS foams. Vendor / lab
authority: **NASA Glenn Research Center / Meador group** —
polyimide aerogel for cryogenic + aerospace insulation;
**Blueshift Materials (acquired by Aspen Aerogels)** — commercial
polyimide aerogel; **Aspen Aerogels** (silica aerogel commercial
anchor); **Stora Enso + FPInnovations** (CNF research authority);
**Liangbing Hu group (UMD)** — nanocellulose aerogel corpus.
Status DESIGN.

| ID                          | class | target          | brief                          | status | falsifier                             |
|-----------------------------|-------|-----------------|--------------------------------|--------|---------------------------------------|
| `hxm-aero-polyimide-001`    | aero  | polyimide aerogel | BPDA / Meador aerospace insulation | SIM-NNP-PROXY | F-AERO-2: T service > 350 °C OR thermal conductivity > 0.018 W/(m·K) → FAIL |
| `hxm-aero-cellulose-001`    | aero  | nanocellulose aerogel | TEMPO-CNF biodegradable insulation | DESIGN | F-AERO-3: density > 50 mg/cm³ OR thermal conductivity k > 0.025 W/(m·K) → FAIL |

**Risk-flags**: polyimide aerogel above 400 °C UNVERIFIED long-
term — imide ring degrades > 450 °C in air; cost of dianhydride +
diamine monomer ($300–$1000/kg) HARD_WALL for commodity
insulation; aerogel particulate release / inhalation toxicity
(sub-100 nm fibrils) UNVERIFIED in occupational setting;
**nanocellulose hygroscopic HARD_WALL** preserved — k rises 2–3×
above 70% RH due to water adsorption; CNF aerogel mechanical
modulus ~ 1 MPa fragile — densification > 20% during SCD UNVERIFIED
to prevent; biodegradability claim limited to lab-soil-burial —
ASTM D5511 industrial-compost certification UNVERIFIED at panel
scale; freeze-drying scale-up beyond 30 cm × 30 cm panels
UNVERIFIED.
**Verb spec link** (Tier-2, `hxm-aero-polyimide-001`): see [`aerogel-foam/aerogel-foam.md`](aerogel-foam/aerogel-foam.md) — material-layer authority for polyimide aerogel chemistry (BPDA-PPDA / BPDA-ODA dianhydride-diamine route; supercritical-CO₂ drying; commodity-cost UNPROVEN preserved verbatim in aerogel-foam.md).

#### 4.D.13 MOFs (extends §3.7 `mof`) — 3 candidates

Hypothesis: a UiO-66 framework (Zr₆O₄(OH)₄(BDC)₆, Cavka 2008
chemistry, post-synthetic modification of defective Zr clusters)
can retain BET surface area ≥ 80% and crystallinity loss ≤ 20%
after 1000 h submersion in liquid water at 25 °C — qualifying for
aqueous-phase catalysis + sorbent applications where ZIF-8 and
MOF-5 fail. A second candidate is a MOF for direct-air-capture
(DAC) targeting CO₂ capacity ≥ 2 mmol/g at **400 ppm CO₂, 25 °C,
50% RH** with regeneration energy ≤ 2 MJ/kg-CO₂ — the MFM-300 /
MFM-188 amine-functionalized open-Mg-site chemistry from Schröder
+ Yaghi groups. A third candidate is the **conductive MOF**
Ni₃(HITP)₂ (Dincă group 2014 *J. Am. Chem. Soc.*, π-stacked Ni-
hexaiminotriphenylene), targeting σ ≥ 40 S/cm at 25 °C with ≥ 30
days air stability for electrocatalysis + supercapacitor electrode
use. Vendor / lab authority: **NuMat Technologies** + **Promethean
Particles** (commercial MOF synthesis); **Yaghi group (UC
Berkeley)** + **Long group (UC Berkeley)** — MOF-DAC foundational
corpus; **Schröder group (Manchester)** — MFM-series; **Dincă
group (MIT)** — conductive MOF; **Climeworks** — DAC amine
baseline **$600–1000/t CO₂ preserved verbatim** per `MOF.md`.
Tier-1 promotion (`hxm-mof-dac-mfm-001`) per `NOVEL_ROADMAP.md` §5.

| ID                                  | class | target          | brief                          | status | falsifier                             |
|-------------------------------------|-------|-----------------|--------------------------------|--------|---------------------------------------|
| `hxm-mof-h2o-stable-uio66-001`      | mof   | UiO-66 water-stable | Zr₆ MOF, 1000 h liquid-H₂O endurance | SIM-NNP-PROXY | F-MOF-3: BET area retention < 80% OR crystallinity loss > 20% after 1000 h H₂O @ 25 °C → FAIL |
| `hxm-mof-dac-mfm-001`               | mof   | MOF DAC @ 400 ppm | MFM / amine-MOF DAC capacity (TIER-1) | DESIGN | F-MOF-4: capacity < 2 mmol/g @ 400 ppm 25 °C 50% RH OR regeneration energy > 2 MJ/kg-CO₂ → FAIL |
| `hxm-mof-conductive-001`            | mof   | Ni₃(HITP)₂ MOF  | Dincă-class conductive π-MOF   | DESIGN | F-MOF-5: σ < 40 S/cm @ 25 °C OR air stability < 30 days → FAIL |

**Risk-flags**: UiO-66 water stability claim depends on Zr₆-
cluster defect density — missing-linker defects degrade hydro-
stability HARD_WALL; surfactant-templated UiO-66 scale-up > kg
UNVERIFIED; **magic-MOF DAC $100/t UNPROVEN** preserved verbatim
— Climeworks amine baseline $600–1000/t per
[`MOF.md`](MOF.md); MFM-188 / MFM-300 4 mmol/g capacity at
400 ppm UNVERIFIED at sustained cyclic operation (10⁴ cycles);
amine grafting → Hofmann elimination above 100 °C ⇒ regen
energy ≤ 2 MJ/kg HARD_WALL if regen ≥ 105 °C steam stripping
required; conductive MOF Ni₃(HITP)₂ σ = 40 S/cm is the as-
reported single-crystal axial value — polycrystalline pellet σ
typically 1–5 S/cm; air stability > 30 days for HITP linker
UNVERIFIED (catechol-derived azaaromatic prone to oxidation);
DAC system engineering (sorbent contactor, regen heat
integration) → out-of-software / Category (c) (Climeworks /
Carbon Engineering / Heirloom).
**Verb spec link** (Tier-2, `hxm-mof-h2o-stable-uio66-001`): see [`mof/mof.md`](mof/mof.md) — material-layer authority for water-stable Zr₆-cluster UiO-66 chemistry (MOF-L12 UiO-66 water-stability anchor preserved verbatim; Cavka-Lillerud 2008 reference).

#### 4.D.14 High-strength fiber (`fiber`) — 1 candidate

Hypothesis: the M5 / PIPD fiber (poly[2,6-diimidazo[4,5-b:4',5'-e]
pyridinylene-1,4-(2,5-dihydroxy)phenylene], Magellan Systems →
DuPont post-aramid program 1998–2005) re-spun under modern
sulfuric-acid liquid-crystalline dope conditions can sustain
tensile σ ≥ 5.5 GPa and modulus ≥ 270 GPa — surpassing Kevlar 49
(σ ~ 3.6 GPa, modulus 124 GPa) and Zylon PBO (σ ~ 5.8 GPa,
modulus 270 GPa, but UV-degrading). Vendor / lab authority:
**Magellan Systems International (defunct ~2005)** — original PIPD
discovery; **DuPont** (post-Magellan acquisition, project
discontinued but lab samples documented); **Akzo Nobel** (early
PBO comparator); **Toyobo** (Zylon PBO commercial baseline);
**Sikorsky Aircraft / DuPont MIL-DTL-32439** (ballistic-grade
aramid spec). Status DESIGN.

| ID                          | class | target          | brief                          | status | falsifier                             |
|-----------------------------|-------|-----------------|--------------------------------|--------|---------------------------------------|
| `hxm-fiber-m5-001`          | fiber | M5 / PIPD       | Magellan / DuPont post-aramid revival | DESIGN | F-FIBER-1: σ < 5.5 GPa OR modulus < 270 GPa → FAIL |

**Risk-flags**: PIPD monomer 2,3,5,6-tetraaminopyridine HARD_WALL
on synthesis — multi-step + air-sensitive, > $1000/kg UNVERIFIED
at scale; H₂SO₄ dope (≥ 95%) handling + recovery same caveat as
Kevlar / PBO commercial routes; UV stability of PIPD UNVERIFIED at
parity with aramid (PBO/Zylon known to lose 50% strength after
100 h sunlight); torsional shear-strength UNVERIFIED — anisotropic
fibers typically fail < 0.5% torsional strain; compressive strength
of PIPD HARD_WALL — all rigid-rod fibers fail kink-band at < 1 GPa
compressive load; supplier landscape — sole-source post-Magellan
licensing UNVERIFIED; weaving / prepreg conversion belongs to
Category (c) (Honeywell Spectra / DuPont Kevlar production
equivalents).

---

Round-3 expansion per [`NOVEL_ROADMAP.md`](NOVEL_ROADMAP.md) §3.H
(biomaterials / implants / e-skin) + §3.I (manufacturing-enabled —
AM-alloy / AM-resin / AM-ceramic / continuous roll-to-roll) + §3.J
(electronics — 2D semiconductors / organic semiconductors / PCM
memory / RRAM / neuromorphic / magnetic cores). 19 `hxm-*` candidates
landed in a single section so the §3 ledger above stays a stable
named-class catalog while Round-3 batches accumulate under §4 with a
date-stamped boundary.

- All entries `status = DESIGN`; falsifier is quantitative, threshold-
  based, measurement-attributable; vendor numbers govern at production
  (not the n=6 lattice).
- UNPROVEN markers verbatim: **Y-TZP LTD (low-temperature degradation)
  HARD_WALL**, **phosphorene ambient HARD_WALL**, **GST resistance
  drift HARD_WALL**, **In supply-chain concentration UNVERIFIED**.
- Sister-domain hand-off (device-layer → `hexa-chip` per
  [`CROSS_LINK.md`](CROSS_LINK.md) §3.2) annotated on every 2D /
  organic / RRAM / PCM-memory / neuromorphic candidate. Hand-off to
  `hexa-energy` (cell engineering) and `hexa-bio` (clinical efficacy /
  wet-lab biocompatibility) annotated where applicable.

### 4.E.1 Bone-scaffold (bioactive + bioresorbable composite)

Hypothesis: a 45S5 bioglass (Hench 1971, U. Florida — first FDA-cleared
bioactive ceramic) foam scaffold at 80 vol% porosity sintered from gel-
cast slurry can deliver compressive σ ≥ 2 MPa AND new-bone ingrowth
≥ 30 vol% in a rat-femur critical defect at 8 wk; pair-candidate is a
hydroxyapatite-PCL (HA-PCL) composite (mineralized phase + biodegradable
polyester matrix) that targets osteoblast viability ≥ 90% with
degradation < 20%/wk. Vendor / authority: Mo-Sci (45S5 medical-grade
glass), NovaBone (45S5 putty), Aesculap (synthetic-bone scaffold),
Pinnaclife (HA-PCL paste); Hench 1971 J. Biomed. Mater. Res. and ISO
biocompatibility belongs to `hexa-bio` per
[`CROSS_LINK.md`](CROSS_LINK.md) §3.4 — this candidate owns the
MATERIAL only (composition, porosity, in-vitro mechanics).

| ID                              | class   | target              | brief                                          | status   | falsifier                                                                                       |
|---------------------------------|---------|---------------------|------------------------------------------------|----------|-------------------------------------------------------------------------------------------------|
| `hxm-bone-bioglass-001`         | bone    | 45S5 porous scaffold | 80 vol% porosity gel-cast 45S5; compressive ≥ 2 MPa + ingrowth ≥ 30 % @ 8 wk | DESIGN | F-BONE-1: compressive σ < 2 MPa OR new-bone ingrowth (rat femur) < 30 % in 8 wk → FAIL          |
| `hxm-bone-ha-pcl-001`           | bone    | HA-PCL composite     | mineralized HA in PCL matrix; osteoblast viable ≥ 90 %; degradation < 20 %/wk | DESIGN | F-BONE-2: degradation rate > 20 %/wk OR osteoblast viability < 90 % → FAIL                       |

**Risk-flags**: 45S5 at 80% porosity is intrinsically weak — Hench's
own corpus reports σ_c 1–3 MPa typical, so the 2 MPa floor is a tight
target UNVERIFIED at lot-to-lot reproducibility; ion-release window
(Si, Ca, P, Na bioactive cascade) shifts with porosity > 70%; HA-PCL
phase-segregation at melt-mixing > 180 °C HARD_WALL; rat-femur model
to human clinical efficacy is NOT a closed extrapolation; clinical
trials + biocompatibility owned by `hexa-bio` per CROSS_LINK §3.4 —

### 4.E.2 Implants (PEEK spinal · Y-TZP dental · Mg-Y-Nd dissolvable)

Hypothesis: three implant-class candidates target distinct service
envelopes — (a) PEEK (Victrex / Solvay KetaSpire / Evonik VESTAKEEP)
spinal cage targets fatigue 10⁷ cycles @ σ_max ≥ 35 MPa with creep
≤ 0.1 %/yr; (b) Y-TZP (Tosoh TZ-3YSB-E, Kuraray Noritake Katana — the
two reference yttria-stabilized zirconia dental-crown suppliers)
targets flexural σ ≥ 900 MPa AND survival of LTD-aging at 134 °C /
2 atm / 100 h per ISO 13356; (c) Mg-Y-Nd dissolvable orthopedic
(Syntellix MAGNEZIX, Biotronik AMS) targets full resorption in
6–12 mo with gas-evolution ≤ 10 mL/cm³/wk. Standards: ASTM F2026 (PEEK
medical), ISO 13356 (Y-TZP medical), ASTM F3160 (Mg orthopedic).
`hexa-bio` per [`CROSS_LINK.md`](CROSS_LINK.md) §3.4.

| ID                              | class    | target              | brief                                          | status   | falsifier                                                                                       |
|---------------------------------|----------|---------------------|------------------------------------------------|----------|-------------------------------------------------------------------------------------------------|
| `hxm-implant-peek-001`          | implant  | PEEK spinal cage     | medical-grade PEEK (Victrex/Solvay/Evonik); fatigue 10⁷ @ σ_max ≥ 35 MPa | DESIGN | F-IMPLANT-1: fatigue 10⁷ cycles failure @ σ_max 35 MPa OR creep > 0.1 %/yr → FAIL                |
| `hxm-implant-y-tzp-001`         | implant  | Y-TZP dental crown   | 3Y-TZP via Tosoh TZ-3YSB-E / Kuraray Katana; σ_f ≥ 900 MPa; LTD-resistant per ISO 13356 | DESIGN | F-IMPLANT-2: flexural σ < 900 MPa OR LTD-aging cracking @ 134 °C / 2 atm / 100 h → FAIL          |
| `hxm-implant-mg-re-001`         | implant  | Mg-Y-Nd dissolvable  | Syntellix MAGNEZIX-class Mg-Y-Nd; resorbs 6–12 mo; gas ≤ 10 mL/cm³/wk | DESIGN | F-IMPLANT-3: resorption > 12 mo OR gas evolution > 10 mL/cm³/wk → FAIL                          |

**Risk-flags**: **Y-TZP low-temperature degradation (LTD) HARD_WALL** —
tetragonal-to-monoclinic transformation in aqueous / body-fluid
environment is intrinsic to 3Y-TZP (Chevalier 2007, Lawson 1995); some
vendors (Tosoh TZ-3YSB-E, Kuraray Katana ZR) report ISO 13356 hydrothermal
pass, but multi-decade in-vivo data UNVERIFIED — preserved verbatim.
PEEK creep at body temperature 37 °C UNVERIFIED beyond 10-yr clinical
window. Mg-Y-Nd gas (H₂) evolution rate strongly bone-site-dependent —
MAGNEZIX hand-screw evidence does NOT extrapolate to large weight-
bearing devices. Clinical efficacy belongs to `hexa-bio` per

### 4.E.3 E-skin (graphene strain sensor · PVDF piezo pressure array)

Hypothesis: a graphene-PDMS skin-mounted strain sensor (Wang 2014
Adv. Mater. graphene-rubber composite + Park 2015 Nat. Nanotechnol.
review) can sustain gauge factor ≥ 200 with 10⁴-cycle retention ≥ 80%;
pair-candidate is a poly(vinylidene fluoride) (PVDF) β-phase piezo
pressure-sensor array (Arkema Kynar PVDF / Solvay Solef β-phase film,
electrically-poled) targeting sensitivity ≥ 0.01 kPa⁻¹ with
T-stability drift ≤ 20% over −20 to +60 °C. Material layer only — the
flexible-substrate device integration / readout IC belongs to
`hexa-chip` per [`CROSS_LINK.md`](CROSS_LINK.md) §3.2.

| ID                              | class   | target               | brief                                          | status   | falsifier                                                                                       |
|---------------------------------|---------|----------------------|------------------------------------------------|----------|-------------------------------------------------------------------------------------------------|
| `hxm-eskin-graphene-001`        | eskin   | graphene-PDMS strain | CVD graphene transferred to PDMS; GF ≥ 200; 10⁴-cycle retention ≥ 80 % | DESIGN | F-ESKIN-1: gauge factor < 200 OR cycle 10⁴ retention < 80 % → FAIL                              |
| `hxm-eskin-pvdf-001`            | eskin   | PVDF piezo pressure  | poled β-phase PVDF (Arkema Kynar / Solvay Solef); sensitivity ≥ 0.01 kPa⁻¹ | DESIGN | F-ESKIN-2: sensitivity < 0.01 kPa⁻¹ OR T-stability −20 to 60 °C drift > 20 % → FAIL              |

**Risk-flags**: graphene gauge-factor 200 is a thin-film lab value —
percolation network breaks down at > 30% strain UNVERIFIED at cycle
10⁴; PDMS Mullins-effect hysteresis UNVERIFIED above 50% strain; PVDF
β-phase poling decay above 80 °C HARD_WALL — Arkema datasheets cap
service T at 80 °C for poled film; readout-IC integration / flexible-
PCB owned by `hexa-chip` per CROSS_LINK §3.2; sweat / saline ambient
biocompatibility for skin-contact UNVERIFIED (deferred to `hexa-bio`
per CROSS_LINK §3.4).

### 4.E.4 AM alloys (LPBF IN939 + post-HIP · LPBF Co-Cr-Mo medical)

Hypothesis: laser powder-bed fusion (LPBF) of two distinct AM-alloy
chemistries — (a) IN939 (Ni-base superalloy, Hampshire/Special Metals
heritage; 22Cr-19Co-2W-2Ta-1Nb-1Ti-1Al-Ni-bal) followed by post-HIP at
1160 °C / 100 MPa / 4 h closes residual porosity to density ≥ 99.7%
with mechanical anisotropy ≤ 25%; (b) Co-Cr-Mo medical (ASTM F75 /
F1537; vendors EOS CobaltChrome SP2 / SLM Solutions / 3D Systems
LaserForm) at density ≥ 99.7% with fatigue 10⁷ @ 800 MPa pass.
Standards: ASTM F3055 (Ni superalloy AM), ASTM F3001/F2924 (Ti AM —
sister), ASTM F75 (Co-Cr-Mo cast/wrought baseline). Vendor numbers
variant — IN939 LPBF without HIP is tracked in NOVEL_ROADMAP §3.I.1
as `am-alloy-in939-001` (not duplicated here).

| ID                              | class      | target              | brief                                          | status   | falsifier                                                                                       |
|---------------------------------|------------|---------------------|------------------------------------------------|----------|-------------------------------------------------------------------------------------------------|
| `hxm-am-alloy-in939-002`        | am-alloy   | IN939 LPBF + HIP    | LPBF IN939 + 1160 °C/100 MPa/4 h HIP; density ≥ 99.7 %; anisotropy ≤ 25 % | DESIGN | F-AM-ALLOY-1: density < 99.7 % OR mechanical anisotropy > 25 % → FAIL                            |
| `hxm-am-alloy-cocrmo-001`       | am-alloy   | Co-Cr-Mo medical    | LPBF Co-28Cr-6Mo (ASTM F75 chemistry); density ≥ 99.7 %; fatigue 10⁷ @ 800 MPa pass | DESIGN | F-AM-ALLOY-2: density < 99.7 % OR fatigue 10⁷ @ 800 MPa fails → FAIL                            |

**Risk-flags**: LPBF residual porosity below 99.7% UNVERIFIED at large-
build-plate scale (> 250 mm); columnar-grain anisotropy in
build-direction vs in-plane HARD_WALL without post-HIP heat-treat
(IN939 specifically) — IN939 was originally designed for CASTING, not
AM, so AM-microstructure-property correlation is still open; Co-Cr-Mo
medical-grade carbon-content drift during LPBF UNVERIFIED (carbide
precipitation kinetics shift vs. F75 cast baseline); fatigue-10⁷
internal-defect rejection requires CT inspection at 50-µm
resolution — UNVERIFIED at production-line cadence.

### 4.E.5 AM resins (DLP engineering-grade · DLP biocompatible)

Hypothesis: two distinct DLP (digital-light-processing vat
photopolymerization) resin chemistries — (a) an engineering-grade
acrylate-urethane hybrid (BASF Forward AM Ultracur3D RG / Henkel Loctite
3D / Carbon EPX-class) reaching tensile σ ≥ 50 MPa AND heat-deflection
T (HDT) ≥ 80 °C; (b) a biocompatible (ISO 10993-5/-10 cytotoxicity
grade ≤ 1) resin (Formlabs BioMed, NextDent Surgical Guide, Stratasys
MED610) with print-shrinkage ≤ 2 %. Standards: ISO 10993 (medical
biocompatibility), ASTM D638 (tensile), ASTM D648 (HDT). Vendor
per CROSS_LINK §3.4.

| ID                                       | class      | target                | brief                                          | status   | falsifier                                                                                       |
|------------------------------------------|------------|-----------------------|------------------------------------------------|----------|-------------------------------------------------------------------------------------------------|
| `hxm-am-resin-dlp-engineering-001`       | am-resin   | DLP engineering resin | acrylate-urethane DLP (BASF Ultracur3D RG / Carbon EPX); σ ≥ 50 MPa; HDT ≥ 80 °C | DESIGN | F-AM-RESIN-1: tensile σ < 50 MPa OR HDT < 80 °C → FAIL                                          |
| `hxm-am-resin-bio-001`                   | am-resin   | DLP biocompatible     | ISO 10993-grade DLP (Formlabs BioMed / NextDent / Stratasys MED610); cytotoxicity ≤ grade-1; shrinkage ≤ 2 % | DESIGN | F-AM-RESIN-2: ISO 10993 cytotoxicity > grade-1 OR shrinkage > 2 % → FAIL                        |

**Risk-flags**: post-cure-dependent property anisotropy HARD_WALL —
under-cured DLP parts can drop σ_t by 30–50 %; HDT is correlated with
cross-link density but UNVERIFIED beyond ~ 110 °C for commodity
acrylate-urethane DLP; biocompatible-grade resins typically trade
mechanical strength (σ_t < 50 MPa) for ISO 10993 pass — the dual
target (engineering σ + bio) is NOT a single commercial product;
leachables / extractables UNVERIFIED for long-term (> 30 d) implant
contact; clinical efficacy belongs to `hexa-bio` per CROSS_LINK §3.4

### 4.E.6 AM ceramics (DLP zirconia via slurry)

Hypothesis: a DLP zirconia-slurry resin (3Y-TZP particles dispersed in
acrylate carrier, debinded + sintered at 1450 °C) can reach σ_flexural
≥ 1 GPa with shrinkage anisotropy ≤ 5 % between build-Z and in-plane
X/Y after final sintering. Vendor / authority: Lithoz CeraFab + LCM
process (Vienna, lead DLP-ceramic vendor), 3DCeram Sinto, Admatec —
to §4.E.5 (resin) but with mineralogy as primary value-bearing layer.

| ID                              | class      | target              | brief                                          | status   | falsifier                                                                                       |
|---------------------------------|------------|---------------------|------------------------------------------------|----------|-------------------------------------------------------------------------------------------------|
| `hxm-am-ceram-zro2-001`         | am-ceram   | DLP zirconia        | 3Y-TZP DLP slurry (Lithoz LCM / 3DCeram); σ_flexural ≥ 1 GPa; shrinkage anisotropy ≤ 5 % | DESIGN | F-AM-CERAM-1: σ_flexural < 1 GPa OR shrinkage anisotropy > 5 % → FAIL                            |

**Risk-flags**: same LTD HARD_WALL as §4.E.2 Y-TZP — DLP-printed 3Y-TZP
inherits 134 °C / aqueous tetragonal→monoclinic transformation; debind
+ sinter shrinkage 20–25 % linear means as-printed feature accuracy
< 50 µm UNVERIFIED at full production scale; Lithoz LCM throughput
$/cm³ HARD_WALL vs. injection-molded ceramic; bio-implant-grade
DLP-ceramic large-volume parts (> 100 cm³) UNVERIFIED.

### 4.E.7 Continuous-process (CVD graphene roll-to-roll > 100 m)

Hypothesis: a roll-to-roll (R2R) CVD-graphene process on a Cu-foil
substrate (Bae 2010 Nat. Nanotechnol. Samsung R&D / Sungkyunkwan U.
+ 2D Carbon / Graphenea pre-pilot R2R lines) followed by PMMA-mediated
wet-transfer to PET / SiO₂ yields a > 100 m continuous monolayer
graphene film with sheet resistance ≤ 200 Ω/sq AND carrier mobility
≥ 1000 cm²/(V·s). Vendor / authority: Graphenea (CVD graphene on Cu),
2D Carbon Graphene-on-Si, BGT Materials (Cambridge), General Graphene
C3). Device integration belongs to `hexa-chip` per
[`CROSS_LINK.md`](CROSS_LINK.md) §3.2.

| ID                              | class      | target              | brief                                          | status   | falsifier                                                                                       |
|---------------------------------|------------|---------------------|------------------------------------------------|----------|-------------------------------------------------------------------------------------------------|
| `hxm-roll2roll-graphene-001`    | roll2roll  | CVD graphene > 100 m | Cu-foil R2R CVD → PMMA wet-transfer; Rs ≤ 200 Ω/sq; µ ≥ 1000 cm²/(V·s) | DESIGN | F-R2R-1: sheet resistance > 200 Ω/sq OR carrier mobility < 1000 cm²/(V·s) → FAIL                |

**Risk-flags**: **grain-boundary scattering HARD_WALL** — CVD-graphene
domains 1–100 µm typical; sheet resistance degrades at the
boundaries; mobility loss vs exfoliated single-crystal graphene
(10⁴–10⁵ cm²/(V·s)) HARD_WALL; **PMMA transfer artifacts** (tears,
folds, residue) HARD_WALL — alternative transfer methods (thermal-
release tape, electrochemical bubbling) UNVERIFIED at > 100 m
continuous; Cu-substrate uniformity (grain orientation, surface
roughness) drives graphene quality but UNVERIFIED at R2R-scale;
device-layer integration (FET / transparent electrode / touch sensor)

### 4.E.8 2D semiconductors (wafer-scale MoS₂ · air-stable phosphorene)

Hypothesis: two distinct 2D-semiconductor candidates extending the
§3.8 corpus — (a) 8-inch wafer-scale CVD MoS₂ (multi-source MOCVD via
Mo(CO)₆ + DES sulfur on c-plane sapphire, 750 °C; reference labs:
SUNY-CNSE Buffalo Park 2015, Samsung Adv. Inst. Tech. Lee 2019, 2D
Semiconductors Inc., Sungkyunkwan KAIST Korea) targeting field-effect
mobility ≥ 50 cm²/(V·s) with on-wafer uniformity ≤ 15 %; (b) air-
stable encapsulated phosphorene (hBN/BP/hBN sandwich via Wang 2015
Nat. Nanotechnol. + Korea IBS Cho 2020) targeting ambient lifetime
≥ 6 mo AND mobility ≥ 200 cm²/(V·s). Device integration belongs to
`hexa-chip` per [`CROSS_LINK.md`](CROSS_LINK.md) §3.2.

| ID                                          | class | target              | brief                                          | status   | falsifier                                                                                       |
|---------------------------------------------|-------|---------------------|------------------------------------------------|----------|-------------------------------------------------------------------------------------------------|
| `hxm-2d-mos2-wafer-001`                     | 2d    | 8-inch wafer MoS₂   | MOCVD MoS₂ on sapphire (SUNY-CNSE / SAIT / 2D Semi / Korea KAIST); µ_FE ≥ 50 cm²/(V·s); uniformity ≤ 15 % | DESIGN | F-2D-3: field-effect mobility < 50 cm²/(V·s) OR uniformity > 15 % on wafer → FAIL                |
| `hxm-2d-phosphorene-passivated-001`         | 2d    | hBN-encapsulated BP | hBN/BP/hBN stack (Wang 2015 + IBS Cho 2020); ambient lifetime ≥ 6 mo; µ ≥ 200 cm²/(V·s) | DESIGN | F-2D-4: ambient lifetime < 6 mo OR mobility < 200 cm²/(V·s) → FAIL                              |

**Risk-flags**: wafer-scale MoS₂ mobility is typically 10–100× lower
than exfoliated flakes HARD_WALL (per §3.8 risk-flag corpus +
`2d-materials/2d-materials.md` UNVERIFIED note); grain-boundary
density + sulfur-vacancy distribution UNVERIFIED at 8-inch scale;
**phosphorene ambient HARD_WALL** — bare BP degrades within hours at
ambient (P₂O₅ + H₂O catalysis); encapsulation pinhole at hBN-BP
interface a known failure mode UNVERIFIED beyond 6 mo; isotope-
enriched / dry-glovebox cleanroom requirement HARD_WALL on cost;
device-layer integration (FET / photonics) belongs to `hexa-chip`

### 4.E.9 Organic + PCM-memory + RRAM + neuromorphic

Five device-active material candidates extending §3.9 (PCM) plus four
new electronics-material classes — organic semiconductor, valence-
change RRAM (HfO_x + TaO_x), and ionic-memristor neuromorphic synapse.
All five are MATERIAL-LAYER candidates; device integration / array
architecture / peripheral CMOS belong to `hexa-chip` per
[`CROSS_LINK.md`](CROSS_LINK.md) §3.2.

Hypothesis (per candidate):
- **`hxm-organic-dpp-001`** — a diketopyrrolopyrrole (DPP)-thienothiophene
  donor-acceptor copolymer OFET (P(DPP2OD-TT) per Kang 2013 J. Am.
  Chem. Soc. + Merck KGaA OLITEC commodity DPP); target hole mobility
  µ_h ≥ 5 cm²/(V·s) AND contact resistance R_c · W ≤ 1 kΩ·cm.
- **`hxm-pcm-mem-gst-001`** — Ge₂Sb₂Te₅ (GST225) phase-change memory
  cell extending §3.9 (Numonyx/STMicro/Intel Optane / Xtacking
  Chinese-fab heritage); target set/reset endurance ≥ 10¹⁰ cycles AND
  retention ≥ 10 yr @ 85 °C.
- **`hxm-rram-hfox-001`** — bipolar valence-change HfO_x RRAM cell
  (TSMC 28-nm embedded eFlash replacement R&D, Crossbar Inc. ReRAM
  Fremont fab, Panasonic ReRAM, Tsinghua HfO_x corpus); target
  retention ≥ 10 yr @ 125 °C AND endurance ≥ 10⁹ cycles.
- **`hxm-rram-tao-001`** — multibit TaO_x RRAM (Panasonic TaO_x stack,
  Crossbar Inc., Stanford Wong group multibit corpus); target
  distinct levels ≥ 16 (4-bit/cell) AND write energy ≤ 100 fJ/bit.
- **`hxm-neuromorph-ion-mem-001`** — ionic memristor analog synapse
  (Yang/Williams HP 2008 memristor heritage + IBM Almaden phase-change
  synapse + IMEC ECRAM lithium-ion synapse 2018); target linearity
  drift ≤ 5 %/yr AND cycle-life ≥ 10⁹.

| ID                              | class       | target              | brief                                          | status   | falsifier                                                                                       |
|---------------------------------|-------------|---------------------|------------------------------------------------|----------|-------------------------------------------------------------------------------------------------|
| `hxm-organic-dpp-001`           | organic     | DPP-TT OFET         | P(DPP2OD-TT) (Kang 2013 / Merck OLITEC); µ_h ≥ 5 cm²/(V·s); R_c·W ≤ 1 kΩ·cm | DESIGN | F-ORG-1: hole mobility < 5 cm²/(V·s) OR contact R > 1 kΩ·cm → FAIL                              |
| `hxm-pcm-mem-gst-001`           | pcm         | GST225 PCM cell      | Ge₂Sb₂Te₅ (Intel/STMicro/Numonyx + Xtacking); endurance ≥ 10¹⁰; retention ≥ 10 yr @ 85 °C | DESIGN | F-PCM-3: set/reset endurance < 10¹⁰ OR retention < 10 yr @ 85 °C → FAIL                          |
| `hxm-rram-hfox-001`             | rram        | HfO_x bipolar RRAM   | TSMC 28-nm embedded RRAM R&D / Crossbar / Panasonic / Tsinghua HfO_x; retention ≥ 10 yr @ 125 °C; endurance ≥ 10⁹ | DESIGN | F-RRAM-1: retention < 10 yr @ 125 °C OR endurance < 10⁹ cycles → FAIL                            |
| `hxm-rram-tao-001`              | rram        | TaO_x multibit RRAM  | Panasonic TaO_x / Crossbar / Stanford Wong; ≥ 16 distinct levels (4-bit); ≤ 100 fJ/bit write energy | DESIGN | F-RRAM-2: distinct levels < 16 OR write energy > 100 fJ/bit → FAIL                              |
| `hxm-neuromorph-ion-mem-001`    | neuromorph  | ionic memristor synapse | ECRAM Li-ion ionic memristor (IMEC 2018 + IBM Almaden); linearity drift ≤ 5 %/yr; cycle-life ≥ 10⁹ | DESIGN | F-NEURO-1: linearity drift > 5 %/yr OR cycle-life < 10⁹ → FAIL                                  |

**Risk-flags**: DPP-TT µ_h ≥ 5 cm²/(V·s) is at the upper edge of
solution-processed OFET corpus — single-crystal benchmarks exist
(rubrene 20 cm²/(V·s)) but solution-processable polymer at ≥ 5 is
UNVERIFIED at full-wafer uniformity; gate-bias-stress instability
UNVERIFIED at > 10⁶ s; **GST resistance drift HARD_WALL** — Boniardi
2010 fundamental amorphous-state structural relaxation, preserved
verbatim from §3.9 — multi-level cell (MLC) GST especially affected;
HfO_x RRAM filament-formation variability HARD_WALL (cycle-to-cycle
σ ~ 30 %); TaO_x multibit ≥ 16 levels UNVERIFIED at endurance scale
— 4-bit/cell requires < 6 % I-V drift over 10⁸ cycles, no commercial
product yet at production; ionic-memristor ECRAM Li⁺ diffusion-rate
vs. retention trade-off HARD_WALL; **In (indium) supply-chain
concentration UNVERIFIED** at scale for any In-containing 2D/RRAM
adjacent stack (preserved verbatim from §3.3 / §3.8 corpus);
device-layer integration (1T1R array, peripheral CMOS, BEOL
integration) belongs to `hexa-chip` per CROSS_LINK §3.2 — material

### 4.E.10 Magnetic (FeBSi amorphous core, extends §3.5)

Hypothesis: a Fe-Si-B amorphous ribbon (Metglas 2605SA1 / Hitachi
Metals FT-3M / VAC Vacuumschmelze VITROVAC heritage; ≈ Fe₇₈Si₉B₁₃
chemistry) cast via planar-flow rapid-quench at > 10⁶ K/s and stress-
anneal-relaxed delivers core loss ≤ 50 mW/cm³ at 50 Hz / 1.5 T AND
coercivity H_c ≤ 2 A/m. Vendor / authority: **Hitachi Metals FT-3M /
Metglas (Conway, SC — historical Allied Signal) / Vacuumschmelze
VITROVAC + VITROPERM** publish these numbers directly on datasheets
NOT apply). Extends §3.5 corpus.

| ID                              | class | target              | brief                                          | status   | falsifier                                                                                       |
|---------------------------------|-------|---------------------|------------------------------------------------|----------|-------------------------------------------------------------------------------------------------|
| `hxm-mag-fefbsi-001`            | mag   | Fe-Si-B amorphous core | planar-flow Metglas 2605SA1 / Hitachi FT-3M / VAC VITROVAC; loss ≤ 50 mW/cm³ @ 50 Hz / 1.5 T | DESIGN | F-MAG-4: core loss > 50 mW/cm³ @ 50 Hz / 1.5 T OR coercivity > 2 A/m → FAIL                      |

**Risk-flags**: amorphous-state thermal stability UNVERIFIED above
crystallization T_x ≈ 540 °C (devitrification cascade is irreversible);
stress-annealing-induced anisotropy is process-window-narrow — over-
anneal degrades µ_r by 50 %; planar-flow ribbon thickness 20–30 µm
HARD_WALL on slot-packing factor for transformer-core stacks; Fe-Si-B
vs Fe-Cu-Nb-Si-B (nanocrystalline Finemet) commodity-cost split
UNVERIFIED at 50 Hz vs MHz applications; vendor numbers (Hitachi
NOT lattice-fit per AGENTS.md §"Limits & verification").

---

Round 3 of NOVEL.md ledger expansion (2026-05-13) promotes brainstorming
slots from [`NOVEL_ROADMAP.md`](NOVEL_ROADMAP.md) §3.K through §3.U
(environmental → architectural → special-function → acoustic → cryo →
detectors → storage → frontier → bio-inspired → sports → NTE/auxetic)
into formal `hxm-*` candidates. Per
is `status: DESIGN`; UNPROVEN/UNVERIFIED markers preserved verbatim;
no n=6 lattice-fit applied to vendor / NIST / standards data; sister-repo
boundary preserved (cell engineering → hexa-energy; device → hexa-chip;
mobility → hexa-mobility; bio-substrate → hexa-bio).

### 4.F.1 Environmental — DAC sorbents (`co2-cap`)

Hypothesis (tier-1 promotion of `co2-cap-mof-mfm-001` slot): an
amine-functionalized MFM-series MOF (extending the `hxm-mof-dac-001` row
in §3.7) targeted at sub-2 MJ/kg-CO₂ regeneration with > 1.5 mmol/g
capacity at the 400 ppm ambient set-point is the open testbed of the
MOF-DAC literature (MFM/NOTT family per Schroder/Manchester corpus).

Companion: tetraethylenepentamine (TEPA)-grafted mesoporous silica
captures the amine-on-oxide flank of the same target — the historically
cheapest sorbent class but bottlenecked on oxidative-amine decomposition
(> 5%/cycle ⇒ FAIL).

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-co2-cap-mof-mfm-002` | co2-cap | MFM-MOF DAC variant | functionalized MOF-MFM, distinct from `hxm-mof-dac-001`; cap > 1.5 mmol/g @ 400 ppm, regen < 2 MJ/kg-CO₂ | SIM-NNP-PROXY | F-DAC-MOF-1: capacity @ 400 ppm < 1.5 mmol/g OR regen energy > 2 MJ/kg-CO₂ → FAIL |
| `hxm-co2-cap-amine-002` | co2-cap | TEPA / mesoporous silica | tetraethylenepentamine-grafted SBA-15-class silica DAC sorbent | DESIGN | F-DAC-AMINE-1: CO₂ capacity < 2 mmol/g OR amine oxidation > 5%/cycle → FAIL |

**Risk-flags**: magic-MOF DAC $100/t UNPROVEN preserved verbatim
(Climeworks amine $600–1000/t baseline per [`MOF.md`](MOF.md) +
§3.7 §3.K LIMIT_BREAKTHROUGH row); amine oxidation by trace SO₂ + NO₂ +
O₂ HARD_WALL on calendar-life durability; volumetric throughput at
ambient 400 ppm (~ 1.5 kg-CO₂/h per m³ sorbent best-case) UNVERIFIED at
plant scale; balance-of-plant heat-exchange energy NOT included in the
regen-MJ/kg target. Pairs with §3.7 `hxm-mof-dac-*` ledger.
**SIM-NNP-PROXY status 2026-05-13** — predicted value vendored as
`_absorption_bridge/universal_ff/predictions/hxm-co2-cap-mof-mfm-002.json`;
**Verb spec link**: see [`mof/mof.md`](mof/mof.md) — material-layer authority for this candidate's chemistry (UNPROVEN $100/t DAC-economics marker home; Climeworks $600–1000/t baseline preserved in §9 anti-claims).

### 4.F.2 Environmental — H₂ storage (`h2-store`)

Hypothesis: three independent H₂-storage chemistries — MgH₂ nanocomposite
solid-state, LOHC dibenzyltoluene liquid carrier, NH₃-cracker catalyst —
each face distinct kinetic / thermodynamic walls. MgH₂ catalyzed with
Nb₂O₅ / Ti / V-additive nanocomposites needs to clear 6 wt%/h
absorption at 200 °C (Bogdanovic 1997 / Vajeeston DFT corpus). LOHC
dibenzyltoluene (Hydrogenious vendor) needs < 320 °C dehydrogenation at
95% release. Ru-Cs/CNT NH₃-cracker (extends `h2-elec` corpus) targets
99.97% H₂ purity at 450 °C, ≥ 95% conversion (matching DOE 2025 milestone).

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-h2-store-mghn-001` | h2-store | MgH₂ nanocomposite | Nb₂O₅/Ti/V-doped MgH₂ for solid-state H₂; kinetic 6 wt%/h @ 200 °C; cycle-100 retention ≥ 95% | DESIGN | F-H2-MGH-1: kinetic absorption < 6 wt%/h @ 200 °C OR cycle-100 retention < 95% → FAIL |
| `hxm-h2-store-lohc-dbt-001` | h2-store | LOHC dibenzyltoluene | Hydrogenious-class dibenzyltoluene H₁₈/H₀ carrier; 6.2 wt% H₂; release < 320 °C | DESIGN | F-H2-LOHC-1: H₂ capacity < 6.2 wt% OR dehydrogenation T > 320 °C for 95% release → FAIL |
| `hxm-h2-store-nh3-cracker-001` | h2-store | Ru-Cs/CNT NH₃ cracker | Ru-Cs on CNT support; NH₃ → N₂ + 3/2 H₂ @ 450 °C; ≥ 95% conv | DESIGN | F-H2-NH3-1: H₂ purity < 99.97% OR conversion @ 450 °C < 95% → FAIL |

**Risk-flags**: MgH₂ ΔH_des ≈ -75 kJ/mol H₂ HARD_WALL (thermodynamic, not
kinetic — even ideal catalyst can't make MgH₂ release below ~ 270 °C
without destabilizing additive); LOHC volumetric energy density ~ 1.9
kWh/kg HARD_WALL ceiling vs liquid-NH₃ ~ 5.2 kWh/kg vs LH₂ ~ 33 kWh/kg
gravimetric; Ru cost + supply UNVERIFIED at commodity-cracker scale;
gold-standard vendor: Hydrogenious LOHC GmbH (LOHC), Hydrogen Mem-Tech
(membrane), Topsoe (NH₃ synthesis/cracking) — their published data
`hexa-energy` per CROSS_LINK §3.3.

### 4.F.3 Environmental — Desalination (`desal`)

Hypothesis: two emerging desalination membrane classes — graphene-oxide
RO and MoS₂ nanopore — promise sub-monolayer water permeation paths at
near-perfect salt rejection. GO-RO targets 99% NaCl rejection (RO-spec)
with > 5 L/(m²·h·bar) flux (Mi 2014 / Joshi 2014 corpus); MoS₂-nanopore
targets 99.5% rejection at > 10 L/(m²·h·bar) (Heiranian 2015 / Surwade
2015 MD prediction baseline). Both face vendor authority of DuPont
FilmTec / Toray RO and emerging MoS₂ vendors (Sandia / 2DSense).

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-desal-go-rom-001` | desal | GO RO membrane | graphene-oxide reverse-osmosis membrane; NaCl rej ≥ 99%; flux ≥ 5 L/(m²·h·bar) | DESIGN | F-DESAL-GO-1: NaCl rejection < 99% OR flux < 5 L/(m²·h·bar) → FAIL |
| `hxm-desal-mos2-001` | desal | MoS₂-nanopore | sub-nm-pore MoS₂ desalination membrane; rej ≥ 99.5%; flux ≥ 10 L/(m²·h·bar) | DESIGN | F-DESAL-MOS2-1: salt rejection < 99.5% OR flux < 10 L/(m²·h·bar) → FAIL |

**Risk-flags**: GO interlayer-spacing swelling in water HARD_WALL on
selectivity (humidified GO loses NaCl rejection in days); MoS₂ nanopore
fabrication uniformity at m² UNVERIFIED — best lab-scale MoS₂ membranes
< 10 cm²; vendor authority: DuPont FilmTec SW30 / Toray TM820 SWRO
baseline 99.7% rejection at 1.2 L/(m²·h·bar) for seawater — these
incumbents define the cost-displacement target (not lattice-fit).
Module-scale concentration-polarization HARD_WALL applies regardless
of membrane chemistry.

### 4.F.4 Environmental — Soil & water (`soilrem`, `h2o-harv`)

Hypothesis: biochar pyrolysis residue captures heavy-metal Pb²⁺ via
surface oxygen-functional-group complexation (Ahmad 2014 review); the
target is 80 mg/g Pb²⁺ sorption with 5-yr humid-soil stability. MOF-303
(Al-fumarate hydrate uptake/release; Yaghi 2017 group) targets 0.4
L/kg/day atmospheric water at 25 °C, 30% RH (the original SOURCE-class
demonstration). Salvinia-inspired hierarchical hydrophilic-hydrophobic
fog collectors (Comanns / Barthlott 2017) target ≥ 5 L/m²·d on
coastal-fog nights.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-soilrem-biochar-001` | soilrem | high-surface biochar | pyrolyzed-biomass biochar, BET > 400 m²/g; Pb²⁺ sorption ≥ 80 mg/g; humid-soil stability ≥ 5 yr | DESIGN | F-SOIL-BIO-1: Pb²⁺ sorption < 80 mg/g OR humid-soil stability < 5 yr → FAIL |
| `hxm-h2o-harv-mof-303-001` | h2o-harv | MOF-303 | Al-fumarate-class MOF-303 atmospheric water harvester; ≥ 0.4 L/kg-MOF/day @ 25 °C, 30% RH | DESIGN | F-H2O-MOF-1: water capacity < 0.4 L/kg-MOF/day @ 25 °C 30% RH → FAIL |
| `hxm-h2o-harv-salvinia-001` | h2o-harv | Salvinia bio-inspired | hierarchical hydrophilic-hydrophobic micro-pattern fog collector; ≥ 5 L/m²·d coastal-fog night | DESIGN | F-H2O-SAL-1: water yield < 5 L/m²·d coastal-fog night → FAIL |

**Risk-flags**: biochar Pb²⁺ sorption pH-dependent (capacity collapses
below pH 4) UNVERIFIED across soil-pH range; biochar leachable-PAH
residue regulatory wall in EU/CA (IBI/EBC certified biochar required);
MOF-303 desorption-energy / regeneration-cycle stability UNVERIFIED at
> 1000 cycles ambient; Salvinia fog collection efficiency depends on
fog density and wind UNVERIFIED at non-coastal climate; vendor authority:
Cool Planet / Verora (biochar); Yaghi MOF-303 has no commercial vendor
yet (research-scale only).

### 4.F.5 Environmental — Plastic recycling + mineralization (`recycle-cat`, `co2-mineral`)

Hypothesis: engineered PETase variants (Tournier 2020 LCC Carbios route +
Austin 2018 PETase corpus) target 90% PET depolymerization in 48 h at
50 °C, with enzyme cost ≤ $1/kg-PET as the commodity tipping point.
Basalt accelerated weathering (Matter 2016 CarbFix corpus + Vesta /
Heirloom vendor pilots) targets ≥ 50 kg CO₂ uptake per m³ basalt at
1-year humid-temperate weathering — basalt grain-size kinetics is the
controlling HARD_WALL.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-recycle-pet-petase-001` | recycle-cat | engineered PETase | thermostable PETase variant (LCC-class) for PET depolymerization; 90% in 48 h @ 50 °C; enzyme cost ≤ $1/kg-PET | DESIGN | F-REC-PET-1: depolymerization < 90% in 48h @ 50°C OR enzyme cost > $1/kg-PET → FAIL |
| `hxm-co2-mineral-basalt-001` | co2-mineral | basalt accelerated weathering | crushed-basalt humid-temperate ERW; CO₂ uptake ≥ 50 kg / m³ / 1 yr | DESIGN | F-CO2-BAS-1: CO₂ uptake @ 1yr / m³ < 50 kg → FAIL |

**Risk-flags**: PETase thermostability ceiling ~ 75 °C HARD_WALL (above
this protein unfolds — can't run at hotter, faster solid-state regime);
PET crystallinity > 30% slows enzymatic attack UNVERIFIED at
post-consumer-bottle crystalline grade; basalt grain-size kinetics
HARD_WALL — sub-mm grinding ⇒ huge embodied energy that erodes net
sequestration; Vesta / Heirloom commercial pilots UNVERIFIED at $/t
displacing geological storage; vendor authority: Carbios (PETase pilot
in Clermont-Ferrand), Vesta / Heirloom / 44.01 (basalt ERW) — their

### 4.F.6 Architectural (`bipv`, `coat`, `paint-anticorr`)

Hypothesis: four building-integrated material classes face distinct
endurance walls. BIPV laminated glass (Helia Smart Glass / Onyx Solar
/ Heliatek tandem-on-glass) targets ≥ 15% certified PCE with ≥ 40%
visible transmission. TiO₂ photocatalytic self-clean (Pilkington Activ
baseline + Toto Hydrotect) targets ≥ 5 yr durability with < 30°
contact-angle drift. SLIPS (Slippery Liquid-Infused Porous Surface;
Aizenberg 2011 Wyss Inst.) targets ice adhesion ≤ 10 kPa with < 50%
oil depletion in 1 yr. Graphene-epoxy anti-corrosion (extends `paint`
class) targets ≥ 2000 h salt-spray ASTM B117 to base-metal blister.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-bipv-glass-001` | bipv | BIPV laminated glass | building-integrated PV laminate (perovskite or CIGS on architectural glass); cert PCE ≥ 15%; T_vis ≥ 40% | DESIGN | F-BIPV-1: certified PCE < 15% OR visible transmission < 40% → FAIL |
| `hxm-coat-selfclean-tio2-001` | coat | TiO₂ photocatalytic | TiO₂ photocatalytic self-cleaning coating; outdoor durability ≥ 5 yr | DESIGN | F-COAT-SC-1: durability < 5yr OR contact angle drift > 30° → FAIL |
| `hxm-coat-antiice-slips-001` | coat | SLIPS anti-ice | slippery liquid-infused porous anti-ice surface; ice adhesion ≤ 10 kPa | DESIGN | F-COAT-AI-1: ice adhesion > 10 kPa OR oil depletion > 50% in 1yr → FAIL |
| `hxm-paint-anticorr-graphene-001` | paint-anticorr | graphene-epoxy | graphene-epoxy anti-corrosion paint; salt-spray ASTM B117 ≥ 2000 h | DESIGN | F-PAINT-AC-1: salt-spray ASTM B117 < 2000h to base-metal blister → FAIL |

**Risk-flags**: BIPV laminated glass dual-spec (PV efficiency × visible
transmission) is a fundamental trade — perovskite-on-glass 25-yr lifetime
UNVERIFIED commercial scale (preserved per §3.4 + PEROVSKITE.md); TiO₂
photocatalytic NO_x reduction (separate spec) UNVERIFIED in urban smog
mix; SLIPS oil-depletion HARD_WALL (silicone-oil host evaporates / leaches)
constrains outdoor service life; graphene-epoxy galvanic-coupling at
scratch-edge UNVERIFIED — early literature optimism (Singh 2013 Adv. Mater.)
revised downward by Schriver 2013 corrosion-acceleration finding;
vendor anchors: Helia / Onyx Solar / Heliatek (BIPV); Pilkington Activ /
TOTO Hydrotect (TiO₂); SLIPS Technologies (anti-ice); AkzoNobel Interpon
/ Hempel (anti-corrosion).

### 4.F.7 Special-function & smart materials (`anti-bact`, `anti-foul`, `trigger`)

Hypothesis: three smart-material classes target log-3 or better
functional thresholds. Silver-zeolite antibacterial textile (Sciessent
Agion baseline) targets log-3 bacterial reduction in 24 h with ≤ 10%
Ag loss after 50 home-laundry washes. Fluoropolymer-PDMS antifouling
marine coating (extends Intersleek 1100SR / Hempasil corpus) targets
≤ 30%/cm² barnacle settlement over 30 days. pH-responsive PNIPAm
(Heskins-Guillet 1968 baseline) targets LCST drift bounded to 31–33 °C
across 1000 thermal cycles.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-anti-bact-ag-zeolite-001` | anti-bact | Ag-zeolite textile | silver-zeolite ion-exchanged antibacterial cotton/PET fabric; log-3 reduction in 24h; Ag loss ≤ 10% after 50 washes | DESIGN | F-ANTIBACT-1: log-3 reduction in 24h fails OR > 10% Ag loss after 50 washes → FAIL |
| `hxm-anti-foul-fluoro-pdms-001` | anti-foul | fluoropolymer-PDMS | fluoropolymer-PDMS hybrid antifouling marine coating; barnacle settlement ≤ 30%/cm² over 30 d | DESIGN | F-ANTIFOUL-1: barnacle settlement > 30%/cm² over 30 days → FAIL |
| `hxm-trigger-pnipam-001` | trigger | PNIPAm LCST | poly(N-isopropylacrylamide) thermoresponsive hydrogel; LCST 31–33 °C bounded across 10³ cycles | DESIGN | F-TRIGGER-1: LCST drift outside 31-33°C → FAIL |

**Risk-flags**: silver-zeolite log-3 reduction is for S. aureus / E. coli
standard ISO 22196 only — antimicrobial-resistant strains UNVERIFIED;
EPA / EU regulatory wall on nano-Ag biocide registration HARD_WALL;
fluoropolymer-PDMS PFAS regulatory headwind (EU REACH 2024+ restriction
proposal); PDMS oil-bleed contaminates downstream coatings UNVERIFIED;
PNIPAm LCST 32 °C narrow window — comonomer drift shifts LCST and
hysteresis on cooling ≠ heating (HARD_WALL — not a defect, intrinsic);
vendor anchors: Sciessent Agion (Ag-zeolite); AkzoNobel Intersleek /
Jotun SeaQuantum / Hempel Hempasil (antifouling marine); Polysciences
PNIPAm research-grade only.

### 4.F.8 Acoustic metamaterials (`acoustic`)

Hypothesis: two sub-λ acoustic-absorber architectures cover the low-
frequency wall that conventional porous absorbers (mineral wool / melamine
foam) leave open. Sub-λ Helmholtz absorber (Mei 2012 Science / Yang 2017
locally-resonant corpus) targets absorption coefficient ≥ 0.9 at 250 Hz
within a 5 cm panel — well below quarter-wave λ/4 = 34 cm for that
frequency in air. Locally-resonant phononic crystal (Liu 2000 Science
sonic crystal corpus) targets ≥ 100 Hz wide bandgap with transmission
≤ -20 dB.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-acoustic-meta-helmholtz-001` | acoustic | sub-λ Helmholtz | Helmholtz-resonator array, sub-wavelength acoustic absorber; α ≥ 0.9 @ 250 Hz / 5 cm panel | DESIGN | F-ACOUSTIC-H-1: absorption coefficient < 0.9 @ 250 Hz for 5 cm panel → FAIL |
| `hxm-acoustic-locres-001` | acoustic | locally-resonant phononic | locally-resonant phononic crystal; bandgap ≥ 100 Hz wide; transmission ≤ -20 dB | DESIGN | F-ACOUSTIC-LR-1: bandgap width < 100 Hz OR transmission > -20 dB in bandgap → FAIL |

**Risk-flags**: Helmholtz-resonator bandwidth narrow (Q factor 10–30) — α
≥ 0.9 holds only in ± 10–20 Hz around the resonance UNVERIFIED for
broadband traffic-noise spectra; locally-resonant phononic bandgap
position scales with resonator mass — heavy-mass loading HARD_WALL on
panel weight (kg/m² > 25 for sub-100 Hz typical); manufacturing tolerance
on resonator dimensions ± 1% shifts bandgap centre UNVERIFIED at
mass-production tolerance; gold-standard reference: Mei et al. 2012 Nat.
Comm. dark-acoustic-membrane absorber (α > 0.99 @ 152 Hz, 5 mm thick).

### 4.F.9 Cryogenic + radiation shield (`cryo`, `radshield`)

Hypothesis: four extreme-environment structural / shielding materials.
OFHC Cu for 4 K dilution-fridge stages — RRR ≥ 200 (residual-resistance
ratio per CRC/ASM) and k ≥ 500 W/(m·K) at 4 K (Pobell 2007). LH₂-tank
Ti-6Al-4V variant — Charpy V-notch ≥ 25 J at -253 °C and H-embrittlement
crack growth ≤ 1e-7 m/s (NASA SP-8108 + Boyer 1994). Boron-loaded
polyethylene neutron shield — thermal-neutron attenuation ≥ 50% per 5 cm
(ITER + ASTM E2415 baseline). Tungsten gamma shield for radiotherapy
collimators — ρ ≥ 18.5 g/cm³ with HRC ≤ 35 machinability.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-cryo-cu-001` | cryo | OFHC Cu 4K | oxygen-free high-conductivity Cu for 4 K stage; RRR ≥ 200; k ≥ 500 W/(m·K) @ 4 K | DESIGN | F-CRYO-CU-1: RRR < 200 OR thermal conductivity < 500 W/(m·K) @ 4K → FAIL |
| `hxm-cryo-ti64-lh2-001` | cryo | LH₂-tank Ti-6Al-4V | Ti-6Al-4V variant for LH₂ tank service; Charpy V-notch ≥ 25 J @ -253 °C | DESIGN | F-CRYO-TI64-1: Charpy V-notch @ -253°C < 25 J OR H-embrittlement crack growth > 1e-7 m/s → FAIL |
| `hxm-radshield-bnh-001` | radshield | boron-loaded PE | boron-loaded polyethylene neutron shield; thermal-neutron attenuation ≥ 50% / 5 cm | DESIGN | F-RAD-BNH-1: thermal-neutron attenuation < 50% per 5 cm OR PE softening @ 60°C → FAIL |
| `hxm-radshield-w-001` | radshield | tungsten gamma | tungsten gamma-shield for radiotherapy collimator; ρ ≥ 18.5 g/cm³; HRC ≤ 35 | DESIGN | F-RAD-W-1: density < 18.5 g/cm³ OR machinability HRC > 35 → FAIL |

**Risk-flags**: OFHC RRR ≥ 200 requires annealing UNVERIFIED at large
casting (RRR collapses at machined edge — Pobell 2007); Ti-6Al-4V
H-embrittlement HARD_WALL — sub-surface H ingress at LH₂ interface
governed by Sieverts' law and irreversible crack-growth onset; boron-
loaded PE softening above 60 °C HARD_WALL (PE Tg / Tm constraint) — must
co-locate with cooling at reactor face; tungsten machinability
HARD_WALL (HRC 32–40 typical) constrains fine-collimator geometry; Re-W
alloy alternative UNVERIFIED at radiotherapy commodity cost; vendor
anchors: Aurubis / Mitsubishi Materials (OFHC Cu); Timet / VSMPO-AVISMA
(Ti-6Al-4V); Polymer Industries / Shieldwerx (B-PE); Plansee / H.C. Starck
(W). Cell-engineering integration for reactor / accelerator out-of-scope.

### 4.F.10 Detectors (`detector`)

Hypothesis: three detector classes. CdZnTe (CZT) for room-T gamma
spectroscopy — energy resolution ≤ 1% at 662 keV (Cs-137) and drift
≤ 5%/h (Redlen / Kromek vendor baseline). MAPbBr₃ perovskite X-ray
scintillator — light yield ≥ 30,000 ph/MeV with decay ≤ 100 ns and
> 1 yr operational lifetime (Wei 2016 Nat. Photonics + Heo 2018 / Kovalenko
2020 corpus). MoS₂ SWIR photodetector — D* ≥ 1×10¹⁰ Jones at 1300 nm
with response time ≤ 100 μs.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-detector-cdznte-001` | detector | CZT room-T gamma | CdZnTe (CZT) Cd₀.₉Zn₀.₁Te detector; res ≤ 1% @ 662 keV; drift ≤ 5%/h on Cs-137 | DESIGN | F-DET-CZT-1: energy resolution > 1% @ 662 keV OR drift > 5%/h on Cs-137 → FAIL |
| `hxm-detector-perovx-001` | detector | MAPbBr₃ X-ray scintillator | methylammonium lead bromide perovskite X-ray scintillator; light yield ≥ 30 kph/MeV; decay ≤ 100 ns; lifetime ≥ 1 yr | DESIGN | F-DET-PER-1: light yield < 30,000 ph/MeV OR decay > 100 ns OR lifetime < 1 yr → FAIL |
| `hxm-detector-2dphoto-001` | detector | MoS₂ SWIR | MoS₂ short-wave-IR photodetector @ 1300 nm; D* ≥ 1e10 Jones; τ ≤ 100 μs | DESIGN | F-DET-2D-1: D* < 1e10 Jones @ 1300 nm OR response > 100 μs → FAIL |

**Risk-flags**: CZT polarization (charge trapping) HARD_WALL at high count
rate; CZT grain-boundary defect density limits volume of single-crystal
ingots UNVERIFIED at > 1 cm³ commodity yield; vendor anchors: Redlen
Technologies / Kromek / eV Products (CZT); MAPbBr₃ Pb halide regulatory
+ encapsulation HARD_WALL (preserved per §3.4 + PEROVSKITE.md); perovskite
X-ray scintillator 1-yr operational lifetime UNVERIFIED at clinical CT
flux; MoS₂ SWIR response in 2D wafer-scale CVD UNVERIFIED — grain-boundary
scattering on D* is HARD_WALL per §3.8 + 2D-MATERIALS.md. Device-layer
work belongs to `hexa-chip` per CROSS_LINK §3.2.

### 4.F.11 Information storage (`dna-storage`, `holo`, `glass-storage`)

Hypothesis: three frontier-storage media. DNA digital storage (Church
2012 Science / Goldman 2013 Nature / Twist Bioscience commercial pilot)
targets ≥ 100 PB/g density with retrieval error ≤ 1e-4. Photopolymer
holographic storage (InPhase Technologies / Akonia 2017 corpus) targets
M# (dynamic range) ≥ 20 with ≥ 50 yr shelf life. 5D silica-glass storage
(Project Silica-class — Microsoft Research / Univ. Southampton Kazansky
group 2013+) targets ≥ 360 TB per cubic inch with ≥ 500 °C thermal
stability.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-dna-storage-001` | dna-storage | DNA digital storage | encoded-DNA cold archival substrate; density ≥ 100 PB/g; retrieval error ≤ 1e-4 | DESIGN | F-DNA-1: density < 100 PB/g OR retrieval error > 1e-4 → FAIL |
| `hxm-holo-storage-001` | holo | photopolymer holographic | photopolymer holographic optical-disk media; M# ≥ 20; shelf life ≥ 50 yr | DESIGN | F-HOLO-1: dynamic range M# < 20 OR shelf life < 50 yr → FAIL |
| `hxm-glass-storage-001` | glass-storage | 5D silica glass | femto-laser-written 5D silica glass storage (Project Silica-class); ≥ 360 TB/in³; ≥ 500 °C stable | DESIGN | F-GLASS-1: density < 360 TB/cubic inch OR thermal stability < 500°C → FAIL |

**Risk-flags**: DNA-storage write cost ($/MB) HARD_WALL — Twist
oligo-synthesis cost still $0.001/base; random-access vs sequential-read
trade-off UNVERIFIED at exabyte scale; DNA hydrolysis half-life at 25 °C
~ 500 yr (Allentoft 2012 bone-DNA fit) — refrigeration extends to
millennia; holographic photopolymer shrinkage during cure ≤ 0.1% UNVERIFIED
across multi-page recording; InPhase Tappestry commercial pull-back 2010
HARD_WALL precedent on holographic commercialization; 5D silica glass
read-throughput UNVERIFIED at non-archival rate (femto-laser-written
voxels read sequentially); Project Silica is Microsoft-internal research
program — public reproducibility UNVERIFIED; vendor anchors: Twist
Bioscience / Catalog (DNA); Akonia Holographics → acquired Apple 2018
(holographic); Microsoft Research Project Silica (glass).

### 4.F.12 Frontier / speculative (`time-crystal`, `top`)

Hypothesis: two frontier-physics targets. Driven-Floquet time crystal
(Choi 2017 Nature / Zhang 2017 Nature / Mi 2022 Nature Quantum AI
sycamore corpus) targets subharmonic-response peak ≥ 10× noise floor
with coherence ≥ 100 ms — but the trivial-Floquet vs MBL (many-body-
localized) distinction is a HARD_WALL (a driven system can exhibit
2T-periodic response without being a genuine "discrete time crystal").
Bi₂Te₃ TI (Hsieh 2009 Nature / Zhang 2009 Nat. Phys.) targets bulk
gap ≥ 100 meV with surface conductivity outside the Dirac cone
≤ 1 mS/cm.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-time-crystal-trivial-001` | time-crystal | driven-Floquet TC | driven-Floquet discrete time crystal (Choi/Mi 2022-class); subharmonic ≥ 10× noise; coherence ≥ 100 ms | SIM-NNP-PROXY | F-TC-1: subharmonic peak < 10× noise OR coherence < 100 ms → FAIL |
| `hxm-top-bi2te3-001` | top | Bi₂Te₃ TI | Bi₂Te₃ 3D topological insulator; bulk gap ≥ 100 meV; surface state distinct from bulk | DESIGN | F-TOP-BI2TE3-1: surface conductivity outside Dirac cone < 1 mS/cm OR bulk gap < 100 meV → FAIL |

**Risk-flags**: trivial-time-crystal vs MBL distinction HARD_WALL — a
periodic response is necessary but not sufficient for "discrete time
crystal"; rigorous discrimination requires either MBL-eigenstate spectroscopy
or proof-of-rigidity (Khemani 2016 / Else 2016) UNVERIFIED at lab scale;
2022 Mi sycamore paper widely cited but Floquet-trivial reading remains
academically contested; Bi₂Te₃ TI surface mobility vs bulk thermoelectric
crosstalk HARD_WALL — sample-dependent (Hall coefficient reflects mix);
Majorana fermion identification CONTESTED (preserved per §3.12 + 2D-MATERIALS.md
provenance must come from synchrotron facility, not lattice-fit.

### 4.F.13 Bio-inspired (`mycel`, `algae`, `bio-electron`, `softrobotics`)

Hypothesis: four bio-inspired material classes. Mycelium-substrate
building insulation (Ecovative / Mogu vendor) targets k ≤ 0.06 W/(m·K)
with moisture absorption ≤ 30%. Algae-derived PHA bioplastic (extends
§3.16 `hxm-bio-pha-marine-001`) targets σ_t ≥ 30 MPa with commercial
cost ≤ $5/kg. PLA-PCL transient-electronics substrate (extends Bao
2014 / Rogers 2012 transient corpus) targets ≥ 50% degradation over
6 mo in PBS at 37 °C with substrate resistivity ≥ 10⁶ Ω·cm. PDMS
pneumatic soft-robotics actuator (Whitesides / Wood corpus) targets
≥ 10⁵ cycle life with ≥ 50% fatigue-strain capability.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-mycel-composite-001` | mycel | mycelium insulation | mycelium-substrate hemp/wood-flour insulation panel; k ≤ 0.06 W/(m·K); moisture absorption ≤ 30% | SIM-NNP-PROXY | F-MYCEL-1: thermal conductivity > 0.06 W/(m·K) OR moisture absorption > 30% → FAIL |
| `hxm-algae-plastic-001` | algae | algae-PHA bioplastic | algae-derived PHA fermentation bioplastic; σ_t ≥ 30 MPa; cost ≤ $5/kg | SIM-NNP-PROXY | F-ALGAE-1: tensile σ < 30 MPa OR commercial cost > $5/kg → FAIL |
| `hxm-bio-electron-pla-pcl-001` | bio-electron | PLA-PCL transient | PLA-PCL biodegradable transient electronics substrate; degradation ≥ 50% / 6mo in PBS / 37°C; resistivity ≥ 10⁶ Ω·cm | DESIGN | F-BIOEL-1: degradation < 50% over 6mo in PBS / 37°C OR resistivity < 10⁶ Ω·cm → FAIL |
| `hxm-softrobotics-pneumatic-001` | softrobotics | PDMS pneumatic actuator | PDMS pneumatic soft-robotics actuator; cycle life ≥ 10⁵; fatigue strain ≥ 50% | DESIGN | F-SOFTROBO-1: cycle life < 10⁵ OR fatigue strain < 50% → FAIL |

**Risk-flags**: mycelium fire-classification (Euroclass B/C) UNVERIFIED at
density grade; moisture-cycling stability across humidity swings HARD_WALL
(mycelium is a living-grown then dried substrate); algae-PHA marine-
biodegradable claim UNVERIFIED (preserved per §3.16 + BIODEGRADABLE-PLASTICS.md
+ NatureWorks / Danimer vendor authority); PLA-PCL transient-electronics
biocompatibility ISO 10993 UNVERIFIED at long-term implant; PDMS fatigue-
strain ≥ 50% UNVERIFIED at 10⁵ cycles in salt / sweat environment for
wearable scale; vendor anchors: Ecovative / Mogu (mycelium); Cargill /
NatureWorks / Danimer (PHA); MC10 / Nfinity Wearables (transient); Festo
/ Soft Robotics Inc. (pneumatic).
**Verb spec link** (Tier-2, `hxm-mycel-composite-001`): see [`wood-cellulose/wood-cellulose.md`](wood-cellulose/wood-cellulose.md) — material-layer authority for mycelium-bound cellulosic composite chemistry (chitin-glucan fungal-network binder + hemp / wood-flour substrate; mycelium scaffold biodegradability UNVERIFIED preserved verbatim).
**Verb spec link** (Tier-2, `hxm-algae-plastic-001`): see [`biodegradable-plastics/biodegradable-plastics.md`](biodegradable-plastics/biodegradable-plastics.md) — material-layer authority for algae-derived PHA bioplastic chemistry (PHB-co-PHV copolymer fermentation route; algae-PHA marine-biodegradable claim UNVERIFIED preserved verbatim per §3.16).

### 4.F.14 Sports / textile / consumer (`sports`, `textile-pcm`)

Hypothesis: two consumer-grade materials. Polyurea-coated bat vibration
damper (Easton / Marucci sports authority) targets loss tangent tan δ
≥ 0.3 at 200 Hz with thermal-degradation ≤ 30% retention after
80 °C / 1000 h. Microencapsulated PCM thermal-regulating fabric
(Outlast Technologies + extends §3.C.2 `pcm-*` corpus) targets thermal
buffering capacity ≥ 25 J/g with ≥ 70% retention after 50 wash cycles.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-sports-vibration-damper-001` | sports | polyurea bat damper | polyurea-coated bat / racquet vibration damper; loss tangent tan δ ≥ 0.3 @ 200 Hz; ≤ 30% degradation @ 80°C / 1000h | DESIGN | F-SPORTS-1: loss tangent < 0.3 @ 200 Hz OR thermal degradation @ 80°C/1000h > 30% → FAIL |
| `hxm-textile-pcm-fabric-001` | textile-pcm | microencap PCM fabric | microencapsulated paraffin-PCM thermal-regulating fabric (Outlast-class); ≥ 25 J/g buffering; ≥ 70% wash-50 retention | DESIGN | F-PCMFAB-1: thermal buffering capacity < 25 J/g OR wash-50 retention < 70% → FAIL |

**Risk-flags**: polyurea Tg ~ -30 °C ⇒ tan δ peak generally below 200 Hz
ambient — loss-tangent requirement is borderline UNVERIFIED at room T;
polyurea hydrolytic stability UNVERIFIED at long-duration outdoor
exposure; microencapsulated PCM capsule-rupture during wash HARD_WALL
(Outlast laboratory baseline: 30–40 J/g new fabric, drops to 18–25 J/g
after 50 washes — vendor data); paraffin leakage at hot-laundry > 60 °C
UNVERIFIED; vendor anchors: Easton / Marucci (sports damper); Outlast
Technologies / Schoeller (PCM fabric).

### 4.F.15 Negative thermal expansion + auxetic (`nte`, `auxetic`)

Hypothesis: two anomalous-property materials. ZrW₂O₈ NTE (Mary 1996
Science discovery + Sleight corpus) targets linear CTE in -8 to
-10 ×10⁻⁶ K⁻¹ across the 20–1000 K isotropic window. Auxetic foam
(Lakes 1987 Science discovery) targets ν ≤ -0.5 (effective Poisson)
with ≥ 90% cyclic stability across 10³ cycles.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-nte-zwo3-001` | nte | ZrW₂O₈ NTE | zirconium tungstate isotropic negative-thermal-expansion ceramic; linear CTE -8 to -10 ×10⁻⁶ K⁻¹ over 20–1000 K | DESIGN | F-NTE-1: linear CTE outside -8 to -10 × 10⁻⁶ K⁻¹ over 20-1000 K → FAIL |
| `hxm-auxetic-001` | auxetic | auxetic foam | re-entrant polyurethane / metal auxetic foam; effective ν ≤ -0.5; ≥ 90% cyclic stability over 10³ cycles | DESIGN | F-AUX-1: ν > -0.5 OR cyclic 10³ stability < 90% → FAIL |

**Risk-flags**: ZrW₂O₈ phase boundary at ~ 430 K (α → β transition)
narrows usable window — true isotropic NTE only in α-phase HARD_WALL;
ZrW₂O₈ pressure-induced amorphization above ~ 0.2 GPa HARD_WALL (Perottoni
1998 Science) limits structural-composite application; auxetic foam
ν ≤ -0.5 requires re-entrant cellular topology — fabrication uniformity
at m³ UNVERIFIED at scale; cyclic-stability across 10³ load cycles
HARD_WALL (cell-wall plastic deformation accumulates); not in
MP/GNoME at canonical-database completeness — NTE crystals partially
listed in COD per [`_absorption_bridge/cod/SOURCES.md`](_absorption_bridge/cod/SOURCES.md).

---

## 5. Round 4 — cross-class hybrids + frontier fillers (2026-05-14)


Round-4 expansion per [`NOVEL_ROADMAP.md`](NOVEL_ROADMAP.md) §4 (cross-class
hybrids) + §3.S (bio-inspired) + §3.U (NTE/auxetic-adjacent frontier classes).
Each candidate ships at status `DESIGN` with a quantitative falsifier and a
risk-flags paragraph (per `selftest/cross_link_integrity_audit.py` B1–B4
vendor citations verbatim; UNPROVEN / HARD_WALL markers preserved.
Sister-domain hand-offs annotated where the cell-engineering /
device-integration layer belongs to a sister substrate
(per [`CROSS_LINK.md`](CROSS_LINK.md) §3.2 hexa-chip, §3.3 hexa-energy).

### 5.A Cross-class hybrids (8 candidates)

8 cross-class candidates spanning HEA + amorphous BMG, 2D MOF for
electrocatalysis, perovskite + halide solid electrolyte hybrid, MXene-
or aerogel-confined PCM, hBN/graphene heterostructure qubit hosts,
dye-sensitized molecular catalysts, and piezoelectric e-skin laminates.
All entries adopt the new `cross` class-tag prefix per §1 naming
convention (the cross-class label is a deliberate signal that
falsifier discipline must include BOTH parent-class failure modes).

#### 5.A.1 CoCrFeMnNi-class HEA + Zr-Cu-Al-Ni BMG glass-forming hybrid

Hypothesis: a CoCrFeMnNi-class high-entropy alloy decorated with a
Zr-Cu-Al-Ni amorphous glass-forming surface layer (suction-cast at 10⁴
K/s into a Cu mold) targets critical casting thickness Dc ≥ 5 mm AND
shear-band density ≤ 10⁴ /m at ε = 0.05 plastic strain — a combined
HEA-substrate + BMG-skin failure surface that crystalline-HEA or
monolithic-BMG corpora cannot match individually. Vendor authority:
Yeh 2004 (original HEA definition); Senkov 2010 (refractory-HEA GFA
mapping); Cantor 2004 (CoCrFeMnNi base); Liquidmetal Technologies
Vitreloy Zr-Cu-Al-Ni BMG corpus.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-cross-hea-bmg-001` | cross | HEA + BMG glass-forming | CoCrFeMnNi-class HEA core + amorphous Zr-Cu-Al-Ni glass-forming skin; suction-cast Cu mold 10⁴ K/s | DESIGN | F-X-HEA-BMG-1: Dc < 5 mm OR shear-band density > 10000 /m at ε = 0.05 plastic strain → FAIL |

**Risk-flags**: HEA + BMG glass-forming-ability (GFA) criteria still
empirical (Yeh 2004 + Senkov 2010 + Inoue empirical-GFA rules); GFA
reproduction at Dc ≥ 8 mm UNVERIFIED across multi-lab campaigns;
crystalline-to-amorphous interfacial cohesion HARD_WALL above 0.6 T_m
(devitrification kinetics dominate); Cantor 2004 CoCrFeMnNi single-phase
FCC stability narrows above 1100 °C — multi-element solute drag is
empirically dataset-fragmented; vendor-scale arc-melt vs LPBF
microstructure variance HARD_WALL preserved from §3.6 HEA ledger.

#### 5.A.2 Ni₃(HITP)₂ 2D MOF for electrocatalysis

Hypothesis: a Ni₃(HITP)₂ 2D conductive MOF (hexaiminotriphenylene Ni
triangular sheet, π-conjugated through Ni-N4 nodes) electrodeposited on
glassy carbon supports oxygen-reduction-reaction (ORR) onset ≥ 0.85 V
vs RHE in 0.1 M KOH AND in-plane conductivity ≥ 40 S/cm — bridging the
classical MOF-as-insulator framework and the 2D-conductor regime.
Vendor authority: Dincă (MIT) 2D conductive-MOF corpus; Yaghi group
foundational MOF taxonomy; NuMat Technologies on industrial MOF
deployment.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-cross-mof-2d-001` | cross | Ni₃(HITP)₂ 2D MOF electrocatalyst | conductive 2D MOF for ORR in alkaline; targets ≥ 0.85 V vs RHE onset + ≥ 40 S/cm | DESIGN | F-X-MOF-2D-1: ORR onset < 0.85 V vs RHE in 0.1 M KOH OR in-plane conductivity < 40 S/cm → FAIL |

**Risk-flags**: 2D-MOF stability in liquid water HARD_WALL beyond 100 h
electrocatalysis (ligand hydrolysis + Ni leaching dominate); HITP
linker oxidation under ORR potential UNVERIFIED at full duty cycle;
sheet-to-sheet stacking-fault scattering decreases out-of-plane σ by
3–4 orders of magnitude vs in-plane (Dincă 2014); Pt benchmark
preserved as honesty anchor (0.90–0.95 V vs RHE onset baseline);
not a replacement claim for PGM catalysts at production. Cell
engineering / MEA integration → hexa-energy per CROSS_LINK §3.3.

#### 5.A.3 CsPbBr₃ perovskite + Li₃InCl₆ halide-SE interface

Hypothesis: a CsPbBr₃ all-inorganic perovskite emitter laminated to a
Li₃InCl₆ halide solid electrolyte targets ionic conductivity ≥ 0.5
mS/cm at 25 °C across the laminated stack AND perovskite phase-
segregation ≤ 5% (XRD secondary-phase peak area) after 1000 h at
60 °C / 50% RH — a hybrid perovskite-LED + halide-SE substrate for
on-chip integrated emitter/battery testbeds. Vendor authority:
Sumitomo Chemical (halide perovskite + organic LED corpus); Asano /
Janek 2018 halide-SE foundational papers; CATL Li-halide pilot lots
on halide-SE manufacturing.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-cross-pero-halide-se-001` | cross | CsPbBr₃ + Li₃InCl₆ hybrid | perovskite emitter + halide-SE laminate; targets ≥ 0.5 mS/cm + ≤ 5% perovskite phase segregation after 1000 h | DESIGN | F-X-PHSE-1: ionic conductivity < 0.5 mS/cm @ 25°C OR perovskite phase-segregation > 5% (XRD secondary-phase area) after 1000 h → FAIL |

**Risk-flags**: halide-ion (Br⁻/Cl⁻) migration across the
perovskite/halide-SE interface HARD_WALL (Janek 2018 + Asano 2018 —
mixed-anion gradients drive perovskite decomposition); Sn-perovskite
variants would suffer Sn²⁺ oxidation HARD_WALL preserved (atmospheric
ingress + halide-SE moisture sensitivity); In-supply UNVERIFIED at
commodity scale (geopolitical concentration of In ore); LK-99 NOT
REPRODUCED preserved as antecedent perovskite-SC anti-claim. Device
fabrication / lithography ⇒ hexa-chip per CROSS_LINK §3.2; cell

#### 5.A.4 Ti₃C₂T_x MXene + paraffin PCM conductive composite

Hypothesis: a Ti₃C₂T_x MXene + n-octadecane paraffin PCM composite
(20 vol% MXene network) targets thermal conductivity k_total ≥ 5
W/(m·K) at 25 °C AND ≥ 80% retention of latent heat after 1000 thermal
cycles between 10 °C and 50 °C — a "conductive PCM" intermediate
between Cabot/Aspen MXene aerogel and Rubitherm paraffin baseline.
Vendor authority: Gogotsi 2023 MXene-foam corpus; Cabot for MXene-
aerogel pilot scale; Rubitherm GmbH on commodity-paraffin PCM thermal
testing.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-cross-mxene-pcm-001` | cross | Ti₃C₂T_x MXene + paraffin PCM | MXene-network conductive paraffin PCM composite; targets ≥ 5 W/(m·K) + ≥ 80% latent-heat retention after 1000 cycles | DESIGN | F-X-MXENE-PCM-1: thermal conductivity < 5 W/(m·K) @ 25°C OR phase-change latent-heat retention < 80% after 1000 cycles → FAIL |

**Risk-flags**: MXene oxidation in molten paraffin HARD_WALL above 80 °C
(Ti₃C₂T_x surface terminations -O/-OH/-F lose layer-edge passivation in
hot non-polar solvents); k_total scaling above 20 vol% MXene loading
SOFT_WALL (percolation gain saturates while paraffin loading drops below
practical PCM latent-heat envelope); Cabot pilot-scale MXene aerogel
commercial cost UNVERIFIED (Gogotsi 2023 lab-scale only); Rubitherm
honored.

#### 5.A.5 Silica aerogel-confined paraffin PCM

Hypothesis: a hydrophobic silica aerogel (TEOS sol-gel, supercritical
CO₂ dried, 0.10–0.15 g/cm³) impregnated with n-octadecane paraffin PCM
targets PCM leakage ≤ 1 wt%/cycle (drip mass loss at 50 °C) AND ≥ 85%
latent-heat retention after 1000 thermal cycles — a Cabot/Aspen-
heritage aerogel + Rubitherm-class PCM hybrid for low-grade thermal
storage. Vendor authority: Cabot (Lumira aerogel) + Aspen Aerogels
(Pyrogel) for aerogel pilot; Rubitherm GmbH + PCM Products for
paraffin reference; Hench 1990 sol-gel TEOS corpus.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-cross-aero-pcm-001` | cross | silica aerogel + paraffin PCM | hydrophobic TEOS-derived silica aerogel impregnated with paraffin PCM; targets ≤ 1 wt%/cycle leakage + ≥ 85% latent-heat retention after 1000 cycles | DESIGN | F-X-AERO-PCM-1: leakage rate > 1 wt%/cycle OR thermal-cycling 1000-cycle latent-heat retention < 85% → FAIL |

**Risk-flags**: PCM volumetric expansion (~ 10–15% on melt) crack-
formation in the fragile silica-aerogel skeleton HARD_WALL (cell-wall
strain accumulates; aerogel Young's modulus ~ 1 MPa cannot absorb
paraffin density-change cyclically); aerogel cost-per-kg UNPROVEN at
commodity-foam parity ($20–100/kg insulation vs $2–5/kg PU) preserved
from §3.14 aerogel ledger; supercritical-CO₂ drying production
throughput UNVERIFIED at building-insulation scale; not in MP/GNoME
canonical database — listed in COD per
[`_absorption_bridge/cod/SOURCES.md`](_absorption_bridge/cod/SOURCES.md).

#### 5.A.6 hBN/graphene/hBN heterostructure qubit host

Hypothesis: a tri-layer hBN/graphene/hBN van der Waals heterostructure
(CVD-grown hBN encapsulating exfoliated monolayer graphene) targets
spin-coherence T₂ ≥ 1 μs at 300 K AND hyperfine inhomogeneous
broadening ≤ 10 MHz — a 2D-encapsulated qubit host bridging diamond-NV
and SiC-VV color-center ecosystems with the wafer-scale hBN/graphene
substrate. Vendor authority: Awschalom (UChicago) hBN VB⁻ + qubit
host corpus; Wrachtrup (Stuttgart) ODMR foundational protocols; SAIT
+ IMEC on 2D-heterostructure CVD-stack pilot.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-cross-quantum-2d-001` | cross | hBN/graphene/hBN qubit host | tri-layer van der Waals quantum-defect host; targets T₂ ≥ 1 μs @ 300 K + ≤ 10 MHz hyperfine broadening | DESIGN | F-X-Q-2D-1: T₂ < 1 μs @ 300 K OR hyperfine inhomogeneous broadening > 10 MHz → FAIL |

**Risk-flags**: hBN vacancy-density variance across CVD growth HARD_WALL
(VB⁻ concentration uncontrolled lot-to-lot; Awschalom 2020 et seq.
report 1–3 orders of magnitude spread in measured T₂ across CVD-hBN
batches); graphene Dirac-cone hyperfine coupling to ¹³C nuclear spins
SOFT_WALL (1.1% natural ¹³C abundance dominates broadening below
isotopic purification); device fabrication ⇒ hexa-chip per CROSS_LINK
§3.2 (lithography + photoresist + bonding pads owned by sister); CNT
yarn 80 GPa lab-mm caveat preserved as adjacent 2D-substrate honesty.

#### 5.A.7 Ru-bipyridyl dye-sensitized TiO₂ molecular photocatalyst

Hypothesis: a Ru(bpy)₃²⁺-class polypyridyl complex chemisorbed on
mesoporous anatase TiO₂ (sol-gel + P25 baseline) targets solar-to-fuel
efficiency ≥ 2% over 100 h of AM1.5G illumination AND turnover number
≥ 10⁴ for CO₂ → CO photoreduction — a dye-sensitized molecular-
catalyst photocatalyst hybridizing the Grätzel-cell sensitization
architecture with a CO₂RR molecular catalyst. Vendor authority:
Grätzel (EPFL) dye-sensitization corpus; Fujishima-Honda 1972 TiO₂
photocatalysis foundational; Sumitomo Chemical / Saule on dye-
sensitization pilot.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-cross-cat-photo-001` | cross | Ru-bpy + TiO₂ dye-sensitized photocatalyst | Ru-bipyridyl chemisorbed on mesoporous anatase TiO₂; CO₂RR photoreduction; targets ≥ 2% STF over 100 h + TON ≥ 10000 | DESIGN | F-X-CAT-PHOTO-1: solar-to-fuel efficiency < 2% over 100 h OR turnover number < 10000 → FAIL |

**Risk-flags**: Ru-dye photobleaching HARD_WALL beyond 200 h continuous
AM1.5G illumination (ligand oxidative degradation; Grätzel et al. dye-
stability reviews); Ru supply geopolitical concentration UNVERIFIED at
commodity-photocatalyst scale; CO₂RR selectivity vs HER UNVERIFIED at
high faradaic loading (competitive H₂ evolution dominates in aqueous
systems); STF benchmark 2% remains aspirational vs Grätzel-cell
photovoltaic + electrocatalyst stack (5–10% STF demonstrated in two-

#### 5.A.8 PVDF-TrFE piezoelectric film on stretchable elastomer e-skin

Hypothesis: a 5 μm spin-coated PVDF-TrFE (70/30 mol%) piezoelectric
film bonded to a 100 μm PDMS stretchable elastomer e-skin targets
piezoelectric d₃₁ ≥ 20 pC/N at 50% biaxial strain AND ≥ 70% signal
retention after 10⁵ cyclic-stretch (5–25% range) cycles — a hybrid
piezo-on-elastomer e-skin bridging the rigid-piezo ceramic film
ecosystem with the flexible PDMS/PVDF wearable corpus. Vendor authority:
Rogers (Northwestern + UIUC) flexible-electronics e-skin corpus;
Arkema (Kynar PVDF + PVDF-TrFE polymer); MC10 / Soft Robotics Inc. on
e-skin device integration.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-cross-piezo-eskin-001` | cross | PVDF-TrFE + PDMS e-skin | spin-coated PVDF-TrFE piezo film bonded to PDMS elastomer; targets d₃₁ ≥ 20 pC/N @ 50% strain + ≥ 70% retention after 10⁵ cycles | DESIGN | F-X-PIEZO-ESKIN-1: piezoelectric d₃₁ < 20 pC/N at 50% strain OR cycle 100000 retention < 70% → FAIL |

**Risk-flags**: piezoelectric coefficient degradation under cyclic
stretch HARD_WALL (PVDF-TrFE β-phase fraction depolarizes under
repeated biaxial strain; Rogers 2017 et seq. flexible-piezo reviews
report 30–50% d₃₁ loss after 10⁴–10⁵ cycles in unconstrained PDMS
laminates); PDMS hydrolytic-stability UNVERIFIED at long-duration
sweat / saline contact (typical wearable failure mode); device
fabrication / packaging ⇒ hexa-chip per CROSS_LINK §3.2; PVDF-TrFE
70/30 commodity-grade availability VERIFIED via Arkema Kynar catalog
C3 honored.

### 5.B Missing-class frontier fillers (7 candidates)

7 frontier-class fillers spanning extended-modulation time-domain
photonic metamaterials, alkylamine-decorated low-temperature DAC MOFs,
Fe-based NH₃ cracker catalysts (Ru-substitute), Na-ion hard-carbon
anodes with Prussian-blue SEI engineering, multilayer MXene EMI
shielding (Ti₃C₂ + V₂C), graphene-aerogel + 1-octadecanol PCM, and
mycelium-PHA elastomer composites for soft-robotics. These deliberately
target classes under-represented in the §3.x + §4.x ledgers (cf.
NOVEL_ROADMAP §3.S bio-inspired + §3.U NTE/auxetic adjacency).

#### 5.B.1 Extended time-domain photonic metamaterial

Hypothesis: a vanadium-dioxide / silicon-photonic time-domain
metamaterial (electrically biased VO₂ thin-film modulator on a SOI
photonic-crystal substrate) targets modulation depth ≥ 50% at 100 GHz
RF drive AND insertion loss ≤ 3 dB across the 1530–1565 nm telecom
C-band — extending the §4.C.4 `hxm-tdmeta-photonic-001` time-domain
photonic-metamaterial baseline to the silicon-photonic process node.
Vendor authority: Pendry-Smith metamaterial foundational corpus;
Engheta + Alù time-varying-photonics 2020 review; STMicroelectronics
+ IMEC on SOI photonic-process pilot.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-photonic-tdmeta-002` | photonic | VO₂ SOI time-domain metamaterial | electrically biased VO₂ modulator on SOI photonic-crystal substrate; targets ≥ 50% modulation @ 100 GHz + ≤ 3 dB insertion loss | DESIGN | F-X-TDMETA-1: modulation depth < 50% @ 100 GHz → FAIL |

**Risk-flags**: VO₂ insulator-metal transition (~ 68 °C) hysteresis
HARD_WALL on repeatable modulation (multi-cycle drift dominates
beyond 10⁶ switching events); SOI-photonic + VO₂ thermal cross-talk
UNVERIFIED at C-band insertion-loss budget; time-domain photonic-
metamaterial frequency-conversion beyond ~ 10 GHz UNVERIFIED at
commodity-process node (Engheta + Alù 2020 — lab-scale demonstrations
only). Device fabrication / lithography ⇒ hexa-chip per CROSS_LINK

#### 5.B.2 Alkylamine-decorated low-temperature DAC MOF

Hypothesis: a tetraethylenepentamine (TEPA)-decorated Mg₂(dobpdc) MOF
targets CO₂ capacity ≥ 1 mmol/g at -10 °C / 400 ppm AND amine-loss
≤ 5 wt% after 1000 thermal-swing regeneration cycles — extending the
§3.7 `hxm-mof-dac-002` ambient-temperature baseline into the
cold-climate envelope where Climeworks amine columns lose 30–50%
capacity. Vendor authority: Long group (Berkeley) amine-MOF corpus;
Climeworks Orca/Mammoth deployment data; NuMat Technologies MOF
pilot.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-mof-dac-003` | mof | TEPA / Mg₂(dobpdc) low-T DAC | alkylamine-decorated Mg₂(dobpdc) MOF targeting low-T DAC; targets ≥ 1 mmol/g @ -10 °C / 400 ppm + ≤ 5 wt% amine loss / 1000 cycles | DESIGN | F-MOF-DAC-LOW-T-1: capacity @ -10°C / 400 ppm < 1 mmol/g → FAIL |

**Risk-flags**: alkylamine (TEPA / PEI) oxidative degradation HARD_WALL
under cyclic O₂ exposure (urea / amide product chain dominates above
80 °C regen temperatures; Long group 2015 et seq.); magic-MOF DAC
$100/t UNPROVEN preserved (Climeworks Orca/Mammoth amine-column
baseline $600-1000/t per Climeworks 2024 public LCA); cold-climate
sorbent kinetics UNVERIFIED at sub-zero air-water partial-pressure
regime; not in MP/GNoME canonical database — listed in COD per
[`_absorption_bridge/cod/SOURCES.md`](_absorption_bridge/cod/SOURCES.md).

#### 5.B.3 Fe-based NH₃ cracker (Ru-substitute)

Hypothesis: an Fe-promoted Ce-Al₂O₃ catalyst for NH₃ cracking targets
NH₃ → N₂ + H₂ conversion ≥ 90% at 500 °C / 1 bar / 30 000 h⁻¹ GHSV
AND H₂ purity ≥ 99.97% post-PSA — a cheaper non-Ru substitute for
the Ru/La₂O₃ baseline used in stationary NH₃-economy H₂ release.
Vendor authority: Topsoe Fe-Ce/Al ammonia-decomp corpus; ITM Power
+ Cummins on NH₃-cracker pilot; Ohmium on H₂-purification stack.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-ammonia-cracker-fe-001` | cat | Fe/Ce-Al₂O₃ NH₃ cracker | Fe-promoted Ce-Al₂O₃ catalyst for NH₃ → N₂ + H₂; targets ≥ 90% conv @ 500 °C + ≥ 99.97% H₂ purity post-PSA | DESIGN | F-NH3-FE-1: conversion < 90% @ 500°C OR H₂ purity < 99.97% → FAIL |

**Risk-flags**: Fe nitridation HARD_WALL above 500 °C (Fe₂N / Fe₄N
phase formation deactivates the catalytic site; Topsoe et al. NH₃-
cracker reviews); Ru/La₂O₃ baseline preserved as honesty anchor (Ru
~ 10× more active per gram at 400 °C but 100× more expensive — the
cost-vs-T trade is the falsifier's true axis); cracker-to-fuel-cell
H₂ purity is the limiting integration constraint (PEM FC requires
NH₃ ≤ 0.1 ppm — separation downstream UNVERIFIED at commodity scale);
honored.

#### 5.B.4 Na-hard-carbon anode + Prussian-blue SEI engineering

Hypothesis: a sucrose-derived hard-carbon Na-ion anode (extends
§4.A.6 `hxm-bat-anode-na-hardcarbon-001`) with a Prussian-blue-analog
artificial-SEI overlayer (KₓNiFe(CN)₆, ALD-deposited) targets initial
Coulombic efficiency (ICE) ≥ 85% AND cycle-500 capacity retention
≥ 75% at 1C — improving on the bare-HC ICE 75–80% baseline that
remains the dominant first-cycle Na-loss mode. Vendor authority:
HiNa Battery + Faradion + Altris hard-carbon supply; Cui group
(Stanford) ALD-SEI engineering corpus; CATL Na-ion (gen-2 PBA).
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-anode-na-prussian-001` | bat-anode | hard-C + PBA SEI Na-ion anode | sucrose-derived hard-C with ALD-deposited Prussian-blue-analog artificial SEI; targets ICE ≥ 85% + cycle-500 retention ≥ 75% | DESIGN | F-NA-PB-1: ICE < 85% OR cycle 500 retention < 75% → FAIL |

**Risk-flags**: K⁺/Na⁺ ionic-radius mismatch in PBA SEI HARD_WALL
(K-PBA framework strains under repeated Na⁺ shuttling; Goodenough
PBA corpus + Cui 2017 SEI reviews); ALD-PBA process throughput
UNVERIFIED at commodity-anode scale; first-cycle Na loss to bulk-SEI
on bare HC is empirically 15–25% (Stevens & Dahn 2000), so the
≥ 85% ICE target requires the PBA overlayer to fully suppress
bulk-SEI formation — UNVERIFIED at full-cell scale; cell engineering

#### 5.B.5 Multilayer Ti₃C₂ + V₂C MXene EMI shielding

Hypothesis: a multilayer Ti₃C₂T_x + V₂CT_x MXene stack (alternating
20 nm layers, total 100 μm) targets total electromagnetic-shielding
effectiveness SE_total ≥ 100 dB across 8–12 GHz X-band — leveraging
the Ti-rich + V-rich heterointerface to amplify multiple-reflection
contributions beyond the monolayer-MXene baseline. Vendor authority:
Gogotsi 2023 MXene-foam corpus; Drexel + Berkeley MXene heterostack
literature; Cabot on commodity MXene aerogel pilot.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-mxene-emi-001` | mxene | ML Ti₃C₂ + V₂C EMI shield | multilayer MXene stack alternating Ti₃C₂T_x + V₂CT_x layers; targets SE_total ≥ 100 dB @ 100 μm thickness | DESIGN | F-EMI-1: SE_total < 100 dB at 100 μm thickness across 8-12 GHz X-band → FAIL |

**Risk-flags**: layer mismatch interfacial scattering UNVERIFIED at
arbitrary stack-order (Ti₃C₂T_x and V₂CT_x have differing lattice
parameter ~ 3.04 vs ~ 2.98 Å — stacking-fault density modulates SE
unpredictably across multilayer growth runs; Gogotsi 2023); MXene
oxidation in ambient humidity HARD_WALL preserved from §3.15 MXene
ledger; spray / vacuum-filtration MXene-stack uniformity UNVERIFIED
at m² scale; CNT yarn 80 GPa lab-mm caveat preserved as adjacent

#### 5.B.6 Graphene-aerogel + 1-octadecanol PCM composite

Hypothesis: a graphene-aerogel scaffold (CVD foam, 0.05 g/cm³)
impregnated with 1-octadecanol (stearyl alcohol, T_m ≈ 58 °C) PCM
targets PCM leakage ≤ 0.5 wt%/cycle (drip mass loss at 70 °C) AND
total thermal conductivity k_total ≥ 3 W/(m·K) — pairing the
ultralight graphene-aerogel skeleton with a higher-T PCM than the
§5.A.5 paraffin variant. Vendor authority: Aspen Aerogels (graphene-
aerogel pilot); PCM Products + Rubitherm on stearyl-alcohol PCM
baseline; Tsinghua graphene-aerogel corpus.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-pcm-graphene-aerogel-001` | pcm | graphene-aerogel + 1-octadecanol | CVD graphene-aerogel impregnated with stearyl-alcohol PCM; targets ≤ 0.5 wt%/cycle leakage + k_total ≥ 3 W/(m·K) | DESIGN | F-PCM-GA-1: leakage > 0.5 wt%/cycle OR k_total < 3 W/(m·K) → FAIL |

**Risk-flags**: graphene-aerogel 0.16 kg/m³ density record UNVERIFIED
at production scale (preserved from §3.14 aerogel ledger — Tsinghua
2013 lab-scale only); 1-octadecanol auto-oxidation HARD_WALL above
80 °C (aldehyde / acid product chain); k_total ≥ 3 W/(m·K) requires
graphene-aerogel volume fraction ≥ 10% — at higher loadings PCM
latent-heat per unit composite drops below the practical PCM-
honored.

#### 5.B.7 Mycelium-PHA elastomer composite for soft-robotics

Hypothesis: a Ganoderma-mycelium scaffold infiltrated with poly(3-
hydroxybutyrate-co-3-hydroxyvalerate) PHBV elastomer (50/50 vol%)
targets tensile strength σ ≥ 8 MPa AND cycle 10⁴ fatigue retention
≥ 70% under 20% strain — a bio-composite soft-robotics actuator
material bridging Ecovative mycelium-foam authority and Danimer
Nodax PHA elastomer baseline. Vendor authority: Ecovative + Mogu
on mycelium fabrication; Danimer Scientific Nodax PHBV grades;
Soft Robotics Inc. + Festo on soft-actuator device integration.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-bio-mycel-elastomer-001` | bio | mycelium + PHBV elastomer | Ganoderma-mycelium scaffold + Danimer PHBV elastomer composite for soft-robotics; targets σ ≥ 8 MPa + cycle 10⁴ retention ≥ 70% @ 20% strain | DESIGN | F-MYCEL-ELA-1: tensile σ < 8 MPa OR cycle 10000 fatigue retention < 70% → FAIL |

**Risk-flags**: mycelium-PHA interphase HARD_WALL on cohesion
(hyphal-network hydrophilicity vs PHBV hydrophobic-block incompat
ibility — Ecovative + Mogu fabrication corpora report lap-shear < 1
MPa typical without coupling agent); biodegradability scaffold-to-
compost UNVERIFIED at marine + soil dual-protocol (Danimer Nodax
PHA meets ASTM D6400 industrial-compost but D7081 marine remains
PHA-grade specific; preserved from §3.16 biodegradable ledger);
PHBV grade-to-grade Tg / E variance across Danimer Nodax lots

### 5.C Round 5 — extended frontier (2026-05-14)

10 additional candidates targeting niches not yet covered in §3 / §4 /
§5.A / §5.B: H₃S-class high-pressure superconductor (extending §3.1
ledger into the hydride-superconductor regime), bimetallic MOF for
desert-condition atmospheric water harvesting, PEDOT:PSS conductivity
extension to > 7000 S/cm, PEM electrolyzer membrane with reduced-Pt-Ir
loading, paraffin microcapsule textile thermal regulation, PVDF-TrFE-CFE
relaxor terpolymer high-d₃₃ piezoelectric, BaTiO₃ thin-film ferroelectric
memory, Cu₂O homojunction photovoltaic, ZIF-67 gas-separation membrane,
and an extended 4H-SiC silicon-vacancy chemistry (V₂ vacancy distinct
from §3.23 SiCVV-001 single-vacancy). All entries adopt the existing
class-tag taxonomy per §1; falsifier discipline + risk-flag paragraph
honored throughout — no n=6 lattice-fit on vendor / lab numbers.

#### 5.C.1 H₃S-class high-pressure superconductor

Hypothesis: an H₃S hydrogen-sulfide superconductor (Drozdov / Eremets
2015 Nature 525:73 confirmed Tc ≈ 203 K at 155 GPa) plus alternative
high-pressure hydride chemistries (CaH₆ at ~ 215 GPa, LaH₁₀ at ~ 170
GPa, YH₉ at ~ 200 GPa) targets Tc ≥ 100 K at relaxed pressure ≤ 100
GPa AND pressure-window-relaxed Tc retention ≥ 50 K — pushing the
hydride-SC envelope toward lower-pressure operation while preserving
the Bardeen-Cooper-Schrieffer (BCS) high-Tc mechanism. Vendor authority:
Eremets corpus (MPI Mainz) on Drozdov 2015 + CaH₆ / LaH₁₀ / YH₉
follow-up; Hemley group (GWU) diamond-anvil-cell methodology; Salamat
(UNLV) hydride-SC review 2024. **RT-SC at ambient pressure NOT
REPRODUCED** — LK-99 anti-claim preserved per AGENTS.md A4.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-supraconductor-h3s-001` | sc | H₃S + alt hydrides | H₃S Drozdov 2015 + CaH₆ / LaH₁₀ / YH₉ alternative hydride SC; targets Tc ≥ 100 K @ ≤ 100 GPa + Tc retention ≥ 50 K at pressure-relaxed window | DESIGN | F-X-H3S-1: Tc < 100 K @ ≤ 100 GPa OR pressure-window-relaxed Tc retention < 50 K → FAIL |

**Risk-flags**: pressure-requirement HARD_WALL (Drozdov 2015 + Eremets
corpus — H₃S Tc 203 K requires 155 GPa diamond-anvil-cell pressure;
lower-pressure variants UNVERIFIED at Tc ≥ 100 K floor); **RT-SC at
ambient pressure NOT REPRODUCED** preserved verbatim per LK-99 +
metallic-hydrogen anti-claim ledger; CaH₆ + LaH₁₀ + YH₉ alternative
hydride-SC Tc reproductions across multi-lab campaigns UNVERIFIED
(Salamat 2024 review notes 5–10 K Tc spread across DAC growth runs);
diamond-anvil-cell pressure calibration HARD_WALL above 200 GPa (ruby
fluorescence calibration breaks down); device-layer integration ⇒
honored.

#### 5.C.2 Bimetallic MOF for atmospheric water harvesting

Hypothesis: a bimetallic (Co/Mn or Co/Ni) MOF (extending MOF-303 / 
MOF-801 chemistry into mixed-metal nodes) targets water yield ≥ 0.3
L/kg-MOF/day at 25 °C / 20% RH desert conditions AND cycle-1000
retention ≥ 80% — closing the gap between Climeworks / Source
ambient-RH water capture (> 40% RH) and desert / arid-zone deployment
where current MOF-303 capacity drops to 0.1–0.2 L/kg/day. Vendor
authority: Climeworks Orca/Mammoth deployment data (ambient capture);
Source Global hydropanel corpus (atmospheric water generator pilot);
Yaghi group (Berkeley) MOF-303 / MOF-801 corpus 2017–2024.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-mof-water-harvest-002` | mof | bimetallic MOF for arid AWH | bimetallic Co/Mn or Co/Ni MOF extending MOF-303 chemistry to desert AWH; targets ≥ 0.3 L/kg/day @ 25°C, 20% RH + cycle 1000 retention ≥ 80% | DESIGN | F-X-MOF-H2OH-2: water yield < 0.3 L/kg-MOF/day @ 25°C, 20% RH desert conditions OR cycle 1000 retention < 80% → FAIL |

**Risk-flags**: water-stable MOF UNVERIFIED at desert humidity (most
MOF-303 / MOF-801 reports use 20-40% RH lab condition; cycling at
sub-20% RH humidity drives hysteresis on the adsorption isotherm
that has not been multi-lab reproduced); Yaghi 2017 + 2024 corpus
shows 0.7-2.8 L/kg/day at 30-40% RH lab condition but drops to
0.1-0.2 L/kg/day below 20% RH (Hanikel et al. 2019 Science); Co/Ni
mixed-metal node stability HARD_WALL at high-cycle hydrothermal
cycling (Co leaching into product water UNVERIFIED for potable
spec); Climeworks / Source Global vendor anchor preserved as
honesty baseline (Source hydropanel uses sorbent + solar-thermal

#### 5.C.3 PEDOT:PSS with ionic-liquid post-treatment

Hypothesis: a PEDOT:PSS conductive polymer film with imidazolium ionic-
liquid post-treatment (extending §3.G.4 `polymer-pedot-001` 5000 S/cm
baseline) targets in-plane electrical conductivity σ ≥ 7000 S/cm at
25 °C AND ambient-storage retention ≥ 80% over 5000 h — pushing the
PEDOT:PSS commodity into the 7000 S/cm regime needed for ITO-free
transparent electrodes. Vendor authority: Heraeus Clevios (Clevios
PH1000 PEDOT:PSS commodity supply); Sigma-Aldrich PEDOT:PSS grade
range; Agfa Orgacon ECF for PEDOT:PSS film products.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-poly-electro-pedot-002` | pol | PEDOT:PSS + ionic-liquid post-treatment | Heraeus Clevios PH1000 PEDOT:PSS with imidazolium ionic-liquid post-treatment; targets σ ≥ 7000 S/cm @ 25°C + ambient storage retention ≥ 80% over 5000 h | DESIGN | F-X-PEDOT-2: σ < 7000 S/cm @ 25°C OR storage stability < 80% retention 5000 h ambient → FAIL |

**Risk-flags**: PEDOT:PSS 5000-8000 S/cm reports highly post-treatment-
specific (DMSO / ethylene-glycol / H₂SO₄ / ionic-liquid variants give
2-10× spread); ambient-storage retention 80% over 5000 h UNVERIFIED
at vendor-pilot scale (Heraeus Clevios PH1000 vendor datasheet
specifies retention only to 1000 h at controlled humidity); ionic-
liquid hygroscopicity HARD_WALL above 60% RH (water uptake degrades
σ irreversibly); blue-shift transparency vs conductivity trade-off
preserved as honesty baseline (Worfolk 2015 PNAS 8800 S/cm post-H₂SO₄
treatment but transparency drops); ITO-replacement claim REMAINS
ASPIRATIONAL at the 90% transparency + 7000 S/cm joint envelope.

#### 5.C.4 PEM electrolyzer membrane with reduced-Pt-Ir loading

Hypothesis: a PEM (proton-exchange-membrane) water-electrolyzer
membrane (Nafion-class ionomer + reduced Pt-Ir cathode-anode loading
< 0.3 mg/cm² total) targets voltage @ 2 A/cm² ≤ 1.8 V AND durability
≥ 30000 h — pushing the green-H₂ PEM stack into commodity-economics
range where current 1-2 mg/cm² Ir loading is the dominant CAPEX
driver. Vendor authority: Cummins Hydrogen (Hylyzer PEM stack);
Plug Power PEM electrolyzer pilot; ITM Power Gigastack 2024
deployment; Chemours Nafion ionomer supply; Johnson Matthey Pt/Ir
catalyst-coated membrane (CCM) corpus. **Ir scarcity HARD_WALL
preserved** per §3.B.3 + §4.B.1 `hxm-h2-elec-iro2-doped-001`.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-electrolyzer-pem-002` | h2-elec | reduced Pt-Ir PEM electrolyzer | PEM membrane + reduced Pt-Ir cathode-anode loading < 0.3 mg/cm²; targets V @ 2 A/cm² ≤ 1.8 V + durability ≥ 30000 h | DESIGN | F-X-PEM-2: voltage @ 2 A/cm² > 1.8 V OR durability < 30000 h → FAIL |

**Risk-flags**: Ir scarcity HARD_WALL preserved verbatim (Ir global
mine output 7-9 t/yr; commodity-scale PEM stack at 1-2 mg/cm² Ir
loading is the dominant economic and supply-chain constraint per
Cummins Hydrogen / ITM Power 2024 LCAs); reduced Pt-Ir loading <
0.3 mg/cm² UNVERIFIED at 30000 h durability — Johnson Matthey CCM
benchmarks show 1-2 mg/cm² + 80000 h durability typical, below
0.3 mg/cm² accelerated-stress-test degradation rate UNVERIFIED at
multi-lab campaign; Nafion ionomer chemical stability HARD_WALL
above 90 °C (perfluorosulfonic-acid backbone fluoride release
dominates); cell engineering ⇒ hexa-energy per CROSS_LINK §3.3.

#### 5.C.5 Paraffin microcapsule textile thermal regulation

Hypothesis: paraffin microcapsules (10-50 μm melamine-formaldehyde
shell + n-octadecane core) embedded in a cellulose-fiber carrier
target wash-50 leakage ≤ 0.3 wt% AND ≥ 90% latent-heat retention
after 100 wash cycles — extending the §4.F.14 `hxm-textile-pcm-
fabric-001` Outlast-class fabric to a cellulose-fiber textile
substrate. Vendor authority: Microtek Laboratories (microPCM
commodity manufacturer); Encapsys (encapsulated paraffin PCM
microcapsule); Outlast Technologies (microPCM-fabric incumbent);
Schoeller Technologies (3xDry / micro-PCM finish).
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-pcm-microcapsule-002` | pcm | paraffin microcapsule in cellulose | melamine-formaldehyde-encapsulated n-octadecane paraffin in cellulose fiber; targets leakage ≤ 0.3 wt% after 100 washes + ≥ 90% latent-heat retention | DESIGN | F-X-PCM-MC-2: leakage > 0.3 wt% after 100 wash cycles OR latent heat retention < 90% → FAIL |

**Risk-flags**: microcapsule fragmentation HARD_WALL during repeated
laundry-mechanical agitation (Microtek + Encapsys vendor data show
typical 5-15 wt% capsule rupture after 50 wash cycles in agitator
laundry; commercial-grade target ≤ 0.3 wt% requires shell-thickness
engineering UNVERIFIED at long-cycle); paraffin auto-oxidation
during hot-laundry > 60 °C UNVERIFIED at 100-cycle target; Outlast
Technologies vendor baseline preserved (30-40 J/g new fabric, drops
to 18-25 J/g after 50 washes — leakage is the bottleneck); cellulose-
fiber substrate dye-uptake interference UNVERIFIED at commodity

#### 5.C.6 PVDF-TrFE-CFE relaxor terpolymer

Hypothesis: a PVDF-TrFE-CFE relaxor-ferroelectric terpolymer (vinylidene
fluoride / trifluoroethylene / chlorofluoroethylene, ~ 60/35/5 mol%)
targets piezoelectric coefficient d₃₃ ≥ 50 pC/N AND maximum service
temperature T_max ≥ 90 °C — extending the §5.A.8 `hxm-cross-piezo-
eskin-001` PVDF-TrFE 70/30 baseline into the CFE-relaxor regime where
narrowed polar-region domains improve d₃₃. Vendor authority: Dow /
Arkema (Kynar PVDF + Piezotech PVDF-TrFE-CFE terpolymer commodity);
Solvay (Solef PVDF + ferroelectric copolymer/terpolymer grades).
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-piezo-pvdf-trife-002` | piezo | PVDF-TrFE-CFE relaxor terpolymer | vinylidene-fluoride / trifluoroethylene / chlorofluoroethylene relaxor terpolymer; targets d₃₃ ≥ 50 pC/N + T_max ≥ 90 °C | DESIGN | F-X-PVDF-TER-1: d₃₃ < 50 pC/N OR T_max for use > 90°C → FAIL |

**Risk-flags**: PVDF-TrFE-CFE Curie-Weiss broadening UNVERIFIED at
T_max ≥ 90 °C — Arkema Piezotech vendor data report typical d₃₃
30-50 pC/N + T_use ceiling ~ 80 °C across commodity terpolymer lots;
CFE comonomer ratio HARD_WALL on d₃₃ vs T_max trade-off (more CFE
narrows polar-region but lowers ferroelectric ordering temperature);
Solvay Solef commodity-grade availability VERIFIED but high-purity
relaxor terpolymer remains specialty pricing; device-layer

#### 5.C.7 BaTiO₃ thin-film ferroelectric memory

Hypothesis: a BaTiO₃ (BTO) thin-film (50-200 nm pulsed-laser-deposition
on SrRuO₃ / Pt-Ti / SrTiO₃ substrate) with strain-engineered tetragonal
distortion targets remanent polarization P_r ≥ 30 µC/cm² AND
endurance ≥ 10¹⁰ switching cycles — extending the §3.20 `hxm-ferro-
hzo-001` HfO₂-ZrO₂ ferroelectric baseline into the BTO classical-
perovskite regime for FeRAM / FTJ memory. Vendor authority: Murata
Manufacturing (BTO multilayer ceramic capacitor / FeRAM corpus);
TDK (BTO + BST thin-film capacitor manufacturing); Ramtron / Cypress
Semiconductor (FeRAM IP base, now Infineon).
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-ferroelectric-bto-002` | ferro | BaTiO₃ strain-engineered thin film | PLD BTO thin film 50-200 nm with strain-engineered tetragonal distortion; targets P_r ≥ 30 µC/cm² + endurance ≥ 10¹⁰ cycles @ 85 °C | DESIGN | F-X-BTO-2: ferroelectric P_r < 30 µC/cm² OR endurance < 10¹⁰ cycles → FAIL |

**Risk-flags**: BTO endurance > 10¹⁰ cycles UNVERIFIED at thin-film
geometry (bulk BTO single-crystal endurance > 10¹² achieved; thin-
film geometry shows fatigue-dominated decline at 10⁸-10¹⁰ cycles
across Murata / TDK + academic reviews); strain-engineering window
HARD_WALL on epitaxial-mismatch fatigue (SrRuO₃ / SrTiO₃ template
strain pinning UNVERIFIED at production scale); BTO Curie temperature
~ 120 °C constrains automotive-grade memory deployment; cell

#### 5.C.8 Cu₂O homojunction solar cell

Hypothesis: a Cu₂O homojunction solar cell (oxidized Cu thin-film with
n-Cu₂O / p-Cu₂O junction via deliberate point-defect engineering)
targets certified power-conversion efficiency PCE ≥ 8% AND open-circuit-
voltage deficit ≤ 0.5 V — pushing the earth-abundant Cu₂O photovoltaic
(theoretical Shockley-Queisser limit ~ 20% at Eg 2.1 eV) toward
disruption parity with thin-film CIGS / CdTe. Vendor authority:
Sumitomo Metal Mining (Cu₂O + CuO oxide thin-film expertise);
Toyota Central R&D (Cu₂O homojunction PV corpus 2013-2024); Minami
group (Kanazawa Institute Tech) Cu₂O PV foundational papers.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-photovoltaic-cu2o-001` | pv | Cu₂O homojunction PV | n-Cu₂O / p-Cu₂O homojunction with point-defect engineering; targets certified PCE ≥ 8% + V_oc deficit ≤ 0.5 V | DESIGN | F-X-CU2O-1: certified PCE < 8% OR V_oc deficit > 0.5 V → FAIL |

**Risk-flags**: Cu₂O n-type doping HARD_WALL — intrinsic Cu vacancy
creates p-type only; n-type Cu₂O requires non-equilibrium defect
engineering UNVERIFIED at scalable thin-film process (best lab cells
hit 8.1% PCE in 2019 Minami group, multi-lab reproduction OPEN);
V_oc deficit ~ 0.7-0.9 V typical (Eg 2.1 eV → V_oc 1.2-1.4 V vs
Shockley-Queisser 1.8 V floor) — closing this 0.5 V deficit
UNVERIFIED at production; Sumitomo Metal Mining + Toyota Central
R&D vendor baseline preserved (lab-scale cells only); CdTe / CIGS
incumbents provide 23%+ PCE benchmark — Cu₂O remains a low-cost
honored.

#### 5.C.9 ZIF-67 cobalt-imidazolate MOF gas separation

Hypothesis: a ZIF-67 (zinc/cobalt 2-methylimidazolate framework, sodalite
topology, Yaghi/Park 2006 structural family) membrane targets H₂/N₂
selectivity ≥ 50 (Robeson 2008 upper bound for polymer membranes) AND
thermal-decomposition T_decomp ≥ 250 °C — leveraging the Co-N₄ node
chemistry for higher binding-affinity gas separation vs ZIF-8.
Vendor authority: BASF (Basolite ZIF-8 / ZIF-67 commodity supply);
HKUST-1 / Hong Kong UST MOF-membrane corpus; NuMat Technologies
on industrial MOF deployment. ZIF-67 distinct from §3.22 ZIF-8
membrane.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-membrane-zif-67-001` | membrane | ZIF-67 H₂/N₂ separation | Co 2-methylimidazolate sodalite framework membrane; targets H₂/N₂ selectivity ≥ 50 (Robeson 2008) + T_decomp ≥ 250 °C | DESIGN | F-X-ZIF67-1: H₂/N₂ selectivity < 50 (Robeson 2008 upper bound) OR thermal-stability T_decomp < 250°C → FAIL |

**Risk-flags**: ZIF-67 H₂/N₂ selectivity UNVERIFIED above the
Robeson 2008 upper bound at film-thickness ≥ 1 μm (sub-100 nm films
report higher selectivity but defect-mediated leakage dominates at
m² scale); Co leaching from ZIF-67 framework HARD_WALL above 200 °C
in humid mixed-gas environment (Park 2006 structural-stability
review); BASF Basolite commodity-MOF supply VERIFIED but ZIF-67
membrane fabrication remains a Hong Kong UST / NuMat pilot scale;
permeance vs selectivity trade-off preserved as honesty anchor
(Robeson 2008 upper bound is the canonical reference); MOF defect-

#### 5.C.10 4H-SiC silicon-vacancy V₂ extended chemistry

Hypothesis: a 4H-SiC silicon-vacancy color center with extended V₂
vacancy chemistry (distinct from §3.23 `hxm-quantum-sicvv-001`
single-vacancy V_Si: this is the divacancy V_C-V_Si pair, also called
VV defect) targets spin-coherence T₂ ≥ 5 ms at 4 K AND ODMR contrast
≥ 5% — extending the SiC color-center qubit ecosystem with a different
vacancy-pair chemistry. Vendor authority: Wolfspeed (4H-SiC commodity
wafer supply); STMicroelectronics (SiC power-device wafer); Awschalom
(UChicago) SiC divacancy + V₂ corpus 2011-2024; Son / Janzén (Linköping)
SiC color-center foundational papers.
Status DESIGN.

| ID | class | target | brief | status | falsifier |
|----|-------|--------|-------|--------|-----------|
| `hxm-quantum-sicvv-002` | quantum | 4H-SiC V_C-V_Si divacancy | 4H-SiC silicon-divacancy (V_C-V_Si pair, distinct from §3.23 V_Si single vacancy); targets T₂ ≥ 5 ms @ 4 K + ODMR contrast ≥ 5% | DESIGN | F-X-SIC-V2-2: T₂ < 5 ms @ 4K OR ODMR contrast < 5% → FAIL |

**Risk-flags**: SiC isotopic-purity HARD_WALL on T₂ ceiling — natural-
abundance ²⁹Si (4.7%) + ¹³C (1.1%) nuclear-bath flip-flop limits T₂ to
sub-ms regime; ²⁸Si + ¹²C isotopic purification required to reach the
5 ms target (preserved verbatim from §3.23 + AGENTS.md honesty rail);
divacancy V_C-V_Si formation yield uncontrolled lot-to-lot (Awschalom
2018 et seq. report 0.5-2× spread on ensemble densities across
Wolfspeed 4H-SiC wafers); ODMR contrast > 5% achievable in
Wolfspeed-grade epitaxial layers but UNVERIFIED at commodity-wafer
purity; device-layer integration ⇒ hexa-chip per CROSS_LINK §3.2.

---

## 6. Sim handle convention

When `status >= SIM-*`, the entry must reference the actual sim handle.
Format: `<bridge>/<adapter>/<output-hash>`

Examples:
- `_python_bridge/module/pymatgen_structure_io.py::<md5>`
- `_absorption_bridge/materials_project/mp_api_smoke.py::mp-149` (Si reference)
- `_absorption_bridge/universal_ff/mace_call.py::<input-md5>`
- `_absorption_bridge/gnome/gnome_dataset_smoke.py::<gnome-id>`

This forces SIM claims to point at a real, reproducible artifact (or a
proper SKIP if the adapter wasn't installed at the time, per Phase E
discipline).

---

## 7. Honesty roll-up (per LATTICE_POLICY.md §1.2)

Every entry in §3 above is currently `DESIGN`-only. **No entry has
external measurement evidence.** Production-scale verification belongs to

- **Vendor authority** for production: Wacker (poly-Si) / Wolfspeed (SiC) /
  Stora Enso (CLT) / Hitachi Metals (NdFeB) / TDK / Shin-Etsu / Arnold /
  Vacuumschmelze / Climeworks (DAC) / NatureWorks (PLA) / Danimer (PHA) /
  Element Six (diamond) / Merck KGaA (LC) — see per-verb specs for
  full citations
- **Database authority** for predicted candidates: Materials Project
  (Berkeley/LBNL, CC-BY 4.0) / DeepMind GNoME (CC-BY 4.0, 2.2M predicted
  stable materials, **PREDICTED NOT SYNTHESIZED**) / Meta AI OMat24
  (CC-BY 4.0, 110M structures) / Preferred Networks Matlantis
  (commercial, UNVERIFIED at hexa-matter scale economics) — see
  [`_absorption_bridge/`](_absorption_bridge/README.md)
- **Anti-claim ledger** (HARD_WALL preserved):
  - LK-99 NOT REPRODUCED
  - metallic hydrogen at ambient UNPROVEN
  - infinite-recycle HARD_WALL (Gibbs ΔS_mix)
  - magic-MOF $100/t DAC UNPROVEN (Climeworks $600-1000/t baseline)
  - CNT yarn 80 GPa = lab mm-scale (commercial 1-3 GPa)
  - 50+ story mass-timber UNVERIFIED
  - rare-earth-free > 35 MGOe UNVERIFIED at production
  - Majorana fermion identification CONTESTED
  - Re-free 4th-gen single-crystal superalloy UNVERIFIED at parity

---

## 8. Entry workflow

To add a new candidate:

1. **Pick class-tag** from §1 table; choose a target-tag (3-6 chars).
2. **Define falsifier** — quantitative, threshold-based,
   measurement-attributable. Vague "we want better" claims rejected.
3. **Land DESIGN row** in §3 with target + brief + falsifier columns
   filled, status = `DESIGN`.
4. **Optionally run sim** via `_python_bridge` or `_absorption_bridge` —
   record sim handle, advance status to `SIM-*`.
5. **Propose retrosynthesis** — advance to `SYNTH-ROUTE` only with
   literature precedent or de-novo path written out.
6. **External verification is OUT-OF-REPO**. To advance to
   `EXTERNAL-VERIFIED`, attach an external lab citation with sample-ID
   and measurement protocol. `hxm-*` ledger NEVER self-validates.

Falsified candidates (sim or external evidence contradicts design)
**stay on disk** with `FALSIFIED` status — they are evidence, not noise.
Per [`AXIS_CLOSURE_PLAN.md`](AXIS_CLOSURE_PLAN.md) Category (a) discipline.

---

## 9. Cross-references

- Working ledger sibling: [`hexa-bio/.roadmap.novel_drugs`](https://github.com/dancinlab/hexa-bio/blob/main/.roadmap.novel_drugs)
- Per-verb specs: [`AXIS.md`](AXIS.md)
- Deep chapters: [`SILICON.md`](SILICON.md), [`CERAMIC-ENGINEERING.md`](CERAMIC-ENGINEERING.md), [`METALLURGY-DEEP.md`](METALLURGY-DEEP.md), [`POLYMER-CHEMISTRY.md`](POLYMER-CHEMISTRY.md), [`GRAPHENE-CARBON.md`](GRAPHENE-CARBON.md)
- Roadmap stubs: [`PEROVSKITE.md`](PEROVSKITE.md), [`COMPOUND-SEMI.md`](COMPOUND-SEMI.md), [`2D-MATERIALS.md`](2D-MATERIALS.md), [`MOF.md`](MOF.md), [`SUPERALLOY.md`](SUPERALLOY.md), [`MAGNETIC-MATERIALS.md`](MAGNETIC-MATERIALS.md), [`ELASTOMER.md`](ELASTOMER.md), [`ADHESIVE.md`](ADHESIVE.md), [`BIODEGRADABLE-PLASTICS.md`](BIODEGRADABLE-PLASTICS.md), [`WOOD-CELLULOSE.md`](WOOD-CELLULOSE.md), [`LIQUID-CRYSTAL.md`](LIQUID-CRYSTAL.md)
- Closure framework: [`AXIS_CLOSURE_PLAN.md`](AXIS_CLOSURE_PLAN.md), [`CLOSURE_RESIDUAL_BACKLOG.md`](CLOSURE_RESIDUAL_BACKLOG.md)
- Sim bridges: [`_python_bridge/README.md`](_python_bridge/README.md), [`_absorption_bridge/README.md`](_absorption_bridge/README.md)
- Frontier signal feed: [`_research_bridge/README.md`](_research_bridge/README.md) (arxiv cond-mat.mtrl-sci + vendor datasheet + patent crawl)
- Policy: [`LATTICE_POLICY.md`](LATTICE_POLICY.md), [`LIMIT_BREAKTHROUGH.md`](LIMIT_BREAKTHROUGH.md), [`AGENTS.md`](AGENTS.md)
- Initial extraction state: [`INIT.md`](INIT.md)
