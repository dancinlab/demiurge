# ufo-capstone — UFO 4-domain capstone monograph

Arxiv-style LaTeX monograph for **UFO**, the capstone (integration) volume of the
demiurge stack: a single-seat vehicle that ties the four sibling domains
(**RTSC · FUSION · ANTIMATTER · CERN**) into one 7-stage propulsion ladder and
carries it through the full demiurge 7-verb pipeline (`spec`→`handoff`),
non-wet-lab. Built on the sidecar/paper monograph spine (§Full Pipeline +
companion/ + xelatex), mirroring the HEXA-FUSION and CERN sibling monographs.

## Build

```
make            # xelatex x3 + bibtex -> main.pdf
make figures    # regenerate figures/*.pdf from _scripts/
make pages      # report page count (target >= 10)
make lint       # commons @D g51 extended lint (traverses appendices)
```

Engine is **xelatex** (emoji-native; tier badges render via TikZ colored discs +
an open-circle ⚪ glyph). Do not switch to pdflatex without first stripping
literal emoji (the title carries 🛸).

## Layout

- `main.tex` — the monograph body: §1-9 spine + §Full Pipeline (the 7-stage
  propulsion ladder with the sharp **proven/UNPROVEN wall** ‖ + the 4-domain
  integration map) + §Limitations + §Reproducibility + the absorbed=false gate
  inventory. Appendices A–L wired via `\input`.
- `appendix/A..L.tex` — 12 SKELETON stubs (each `\section` + `\label` + scope
  intro + `% TODO (fill batch)` marker). Filled in later batches.
- `references.bib` — 14 bibtex entries (all carry DOI / stable URL): Alcubierre
  1994, Morris-Thorne 1988, Kaluza 1921 / Klein 1926, Earnshaw 1842 + the four
  sibling-domain primaries (McMillan, Bosch-Hale, antiproton CPT, Esarey LWFA) +
  Wesson, Jackson.
- `figures/cover.png` — fal.ai cover (Fig.1, title page): a lenticular disc
  single-seat vehicle (D=6m) with solenoid field lines + fusion/antimatter glow
  over a starfield.
- `figures/_prompts/cover.txt` — the cover generation prompt (provenance).
- `figures/_scripts/*.tex` — pgfplots/TikZ figure sources.
- `companion/` — the data-record axis: `verify-ledger.json` · `pr-roll.json` ·
  `integration-map.json` · `session-journal.md`. See `companion/README.md`.

## Honesty stance

All records carry **`absorbed=false`**. The vehicle is NOT build-ready: four
non-wet-lab digital-twin gates (CFD, EM 3D, structural FEA, the ⟲ fixed-point
coupling) are unconverged (deferred to pool/cloud), and **Stages 4–7
(warp · wormhole · dim-jump · dim-use) are ⚪ academically UNPROVEN** — a
13-falsifier preregister, ALL OPEN. The proven/UNPROVEN wall (‖) is the
contract: a ⚪ claim never becomes 🟢 by integration. Clearing all non-wet-lab
gates would make the design a *witness of integrated feasibility*, never a built
or flown craft.
