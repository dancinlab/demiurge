# hexa-fusion-7gate — HEXA-FUSION 7-gate design-feasibility funnel paper (v2)

Arxiv-style LaTeX paper for **HEXA-FUSION**, a closed-form 7-gate design-feasibility
funnel for magnetic-confinement fusion built on the hexa-lang stdlib. Rebuilt on the
sidecar/paper v0.8.0 9-section spine (§Full Pipeline + companion/ + xelatex).

## Build

```
make            # xelatex x3 + bibtex -> main.pdf
make figures    # regenerate figures/fig03_pipeline.pdf from _scripts/
make pages      # report page count (target >= 10, ideal >= 15)
make lint       # commons @D g51 extended lint
```

Engine is **xelatex** (emoji-native; tier badges 🔵🟢🟡🟠🔴 render directly). Do not
switch to pdflatex without first stripping literal emoji.

## Layout

- `main.tex` — the paper. 16 sections including §Full Pipeline (10-stage D-T fuel table),
  §Method (Bosch-Hale + Lawson), §F-funnel, §Verify (wrap-and-fix + adapter defect catalog),
  §Results (GetDP solenoid bridge), §BLUE-MAX, §Limitations, §Reproducibility.
- `references.bib` — 18 bibtex entries (all carry DOI / arXiv id / stable URL).
- `figures/cover.png` — fal.ai gpt-image-2 cover (Fig.1, title page). User-validated; do not regenerate.
- `figures/_prompts/cover.txt` — the cover generation prompt (provenance).
- `figures/_scripts/fig03_pipeline.tex` — TikZ 10-stage tier-color-coded flow (Fig.2).
- `companion/` — the data-record axis: `verify-ledger.json` · `pr-roll.json` ·
  `adapter-defect-catalog.json` · `session-journal.md`. See `companion/README.md`.

## Honesty stance

All simulation records carry `absorbed=false`. Six non-wet-lab gates passing = a witness of
engineering feasibility, NOT a built or measured reactor. Gate (g) burning-plasma Q>1 is the
only permanent wet-lab boundary; only a JET-class measured oracle ever flips `absorbed=true`.
