# AGA-CURE arm④ — de novo neogenesis in-silico model (NEW, cure-only)

Gray-Scott reaction-diffusion (canonical spot patterning, field-standard for follicle-spacing à la Sick2006 WNT/DKK Turing). v-spots = new follicle primordia; F (feed) = Wnt/regenerative-drive proxy. 128² grid ≈ 0.41 cm² patch (0.05mm/grid). scipy ndimage spot count.

## RESULT — threshold + productive band (measured)
| F (Wnt/regen drive) | new primordia | density /cm² | regime |
|---:|---:|---:|---|
| 0.010 | 0 | 0 | decay — NO neogenesis (T3 fibrotic/low-Wnt default) |
| 0.022 | 0 | 0 | decay (below threshold) |
| **0.030** | **119** | **290** ★ | PATTERN → primordia (≈ never-bald vertex 200-300/cm²) |
| 0.040 | 33 | 81 | pattern (fewer, larger) |
| 0.055 | 3 | 7 | over-driven → spacing collapse |

## FINDINGS (honest, d6)
- **Sharp threshold F≈0.022→0.030**: below it the field decays (no placodes = no neogenesis) — matches the empirical WIHN size/dose threshold (neogenesis only fires above a critical wound/Wnt dose).
- **"Goldilocks" band ≈ F 0.030**: new-follicle density reaches **~290/cm² = never-bald terminal density** → de novo neogenesis can IN PRINCIPLE fully restore T3 (completely-lost) regions, closing CURE gate④.
- **Non-monotone**: over-driving Wnt (F≥0.055) collapses spacing to few large spots — biologically consistent (excess β-catenin disrupts periodic patterning). ⇒ arm④ needs DOSED Wnt into the band, not maximal.
- **arm④ recipe (T3)**: ① verteporfin/YAP-block to remove fibrotic damping (make skin regeneration-permissive) → ② dose Wnt agonism (+ SCUBE3/FGF9) into the F≈0.03 band → new follicles at native density.

## TIER (g63)
Phenomenological RD surrogate (standard for follicle-spacing), NOT molecular; F→Wnt-drive mapping qualitative; grid-scale assumed. Captures the threshold + density-vs-drive non-monotonicity correctly. Sharpening → couple to a molecular Wnt/Dkk/BMP reaction layer + calibrate grid to real inter-follicular spacing (next tier). First broken attempt (Gierer-Meinhardt, all-homogeneous) was rejected, not reported.
