<!-- @authored: 2026-05-13 -->
<!-- @phase: C — GROUP_FAS architectural overview -->

# fashion-architecture — dyeing chemistry, mordant, fiber-dye affinity

> Architectural overview of GROUP_FAS. Wet-process and dye-uptake side of
> textile, distinct from `hexa-fiber/` (FIB; dry-mechanical fiber assembly).

## §1 The FAS chemistry hierarchy

```
                           GROUP_FAS
                              |
              +---------------+---------------+
              |                               |
        fiber substrate                  dye class
              |                               |
   +----------+----------+        +----------+----------+----------+
   |          |          |        |          |          |          |
 natural   synthetic   regen   reactive    direct      vat       disperse
 (cotton,  (nylon,     (rayon, (Procion,   (Congo Red, (Indigo,  (Disperse Red,
  wool,     PET,        viscose, Drimarene  Direct Blue, Anthra-  Disperse Blue —
  silk,     acrylic,    lyocell, Remazol;   etc.)        quinone- polyester
  jute,     spandex,    cellulose covalent              based;    affinity)
  hemp,     UHMWPE)     acetate)  bond to               leuco
  cellulose)                      cellulose             form
                                  -OH)                  → oxidation

                                                                  pigment       acid
                                                                  (insoluble    (Acid Red,
                                                                  particle      Acid Blue;
                                                                  mechanical    amide / wool
                                                                  fixed)        uptake)

                                                                  basic         mordant
                                                                  (cationic    (alum, iron,
                                                                  uptake on    chrome — bridge
                                                                  acrylic)     dye to fiber via
                                                                              metal complex)
```

## §2 Fiber-dye affinity matrix

| Fiber | Reactive | Direct | Vat (indigo) | Disperse | Acid | Basic | Pigment |
|-------|----------|--------|--------------|----------|------|-------|---------|
| Cotton (cellulose) | ✓✓ best | ✓✓ | ✓✓ | ✗ | ✗ | ✗ | ✓ (binder) |
| Linen / hemp (cellulose) | ✓✓ | ✓✓ | ✓ | ✗ | ✗ | ✗ | ✓ |
| Wool (keratin) | ✓ | ✗ | ✓ | ✗ | ✓✓ best | ✗ | ✓ |
| Silk (fibroin) | ✓ | ✗ | ✓ | ✗ | ✓✓ | ✗ | ✓ |
| Nylon (amide) | ✓ | ✗ | ✗ | ✗ | ✓✓ | ✗ | ✓ |
| Polyester (PET) | ✗ | ✗ | ✗ | ✓✓ best | ✗ | ✗ | ✓ |
| Acrylic (PAN) | ✗ | ✗ | ✗ | ✗ | ✗ | ✓✓ | ✓ |
| Rayon / viscose (cellulose II) | ✓✓ | ✓ | ✓ | ✗ | ✗ | ✗ | ✓ |
| Aramid (PPTA) | ✗ | ✗ | ✗ | ✗ | ✗ | ✗ | ✓ (Solution-dyed only — fiber pre-colored at spin) |
| Spandex / Lycra (PU) | ✗ | ✗ | ✗ | ✓ | ✓ | ✗ | ✓ |

## §3 Dye chemistry detail

### §3.1 Reactive dye

- Forms covalent bond with cellulose -OH (Cl-triazinyl reactive group)
- Procion MX (cold-water), Procion H (hot-water), Drimarene, Remazol
- Pioneered by ICI 1956 (Procion)
- ISO 105 reactive-dye fastness standards

**Quantitative falsifier F-FAS-Q1** (real-domain, post-policy): reactive
dye covalent yield ≥ **60 %** on cellulose (cotton) at 60 °C, pH 11
(Na₂CO₃ alkali fixation) per ISO 105-X12 + ICI Procion-H technical
manual + Aspland 1997. Trigger (real-domain): a dye-bath measurement
returning covalent yield < 50 % under the same ISO 105-X12 method (n ≥ 3
swatches, Soxhlet wash-off + UV-Vis residual absorbance) → retire the
"reactive dye industrial parity" claim for that lot.

### §3.2 Vat dye (indigo, anthraquinone)

- Insoluble dye; reduced to soluble leuco form (sodium dithionite)
- Penetrates fiber, then re-oxidized to insoluble
- Indigo: traditional natural dye from Indigofera tinctoria; also bacterial
  fermentation (synbio crossover with `hexa-bio/`)
- Anthraquinone vat: Indanthrene Blue RS, Indanthrene Olive Green B
- High wash-fastness, characteristic blue-jean color

### §3.3 Direct dye

- Adsorbed by H-bond + vdW to cellulose; no covalent bond
- Cheap; lower wash-fastness than reactive
- Used for paper coloration (not just textile)

### §3.4 Disperse dye

- Insoluble particulate; mechanically driven into polyester at 130 °C +
  pressure (high-temp jet dyeing)
- Disperse Red 1, Disperse Blue 79, etc.

### §3.5 Acid dye

- Anionic dye + protonated amide (NH₃⁺) on wool, silk, nylon
- Acid Red 1, Acid Blue 25
- Crocking and washing fastness vary

### §3.6 Basic dye

- Cationic dye + anionic site on acrylic (PAN -CN tautomerized)
- Methylene Blue, Rhodamine B, Malachite Green
- Bright colors; lower lightfastness historically

### §3.7 Mordant dye

- Metal-complex bridge between dye and fiber
- Alum mordant (KAl(SO₄)₂·12H₂O) for wool dyeing
- Iron, chrome, copper, tin mordants
- Traditional natural-dye chemistry (madder, weld, woad)

## §4 Industrial wet-process

| Step | Function | Chemistry / equipment |
|------|----------|------------------------|
| Desizing | Remove warp-sizing starch | enzyme (α-amylase), acid, or alkali |
| Scouring | Remove waxes, oils, surfactants | NaOH 1-3% with surfactant |
| Bleaching | Remove natural color | H₂O₂ (cotton, hemp), reductive bleach (wool, silk) |
| Mercerization | Cotton: NaOH 22-24% under tension → cellulose II | cellulose I → II crystal conversion, luster |
| Dyeing | Apply dye | jet, jig, beck, pad-batch, foam, supercritical CO₂ |
| Soaping (reactive) | Remove unreacted dye | warm-soap detergent rinse |
| Drying / setting | Lock dye in place | tenter frame, calendaring |
| Finishing | Hand, hand-feel | softener, anti-static, water-repel, FR |

## §5 Cross-substrate crossover (FAS ↔ bio)

Indigo fermentation: traditional vat dye from `Indigofera tinctoria` plant
(India, Egypt). Modern revival: bacterial fermentation of glucose to indigo
via engineered E. coli (Genencor / Pivot Bio research; lab-scale).

This crosses into `hexa-bio/` (synbio / microbial fermentation) — the
material output (indigo dye) is FAS; the production route is bio.

## §6 Cross-group interfaces

### §6.1 FAS ↔ FIB

The substrate of dyeing is the fiber (cellulose, protein, synthetic).
Fiber chemistry lives in FIB / POL; dye-uptake lives in FAS.

### §6.2 FAS ↔ POL

Disperse dye on PET, acid dye on nylon are POL chemistry from the
fiber side, FAS chemistry from the dye side.

### §6.3 FAS ↔ PRC

Wet-process is itself a synthesis route. The `synthesis/` verb covers
the upstream dye manufacture; FAS covers application.

### §6.4 FAS ↔ MET

Metallic thread (real gold thread on bullion, kalabattu, sari brocade) +
zipper, snap, button (brass / nickel / steel).

---

*Phase C fashion architecture overview, authored 2026-05-13. Thinnest
group spec depth — pending future expansion per AXIS.md §12 weakness item.*
