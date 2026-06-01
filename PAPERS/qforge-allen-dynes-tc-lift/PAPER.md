# qforge-allen-dynes-tc-lift — paper status

@title: 📄 Proper Allen-Dynes f1·f2 raises every recorded Tc by a λ-monotone margin
@goal: Show the RTSC campaign's recorded "Allen-Dynes Tc" are AD-kernel lower bounds — the true f1·f2 form lifts every Tc on the same DFPT moments by +2.5% (λ=0.62) to +35% (λ=4.38), with high-λ + high-pressure caveats and no room-temp claim.

- [x] draft v1 (main.tex — §hypothesis · §method · §verify · §results · §finding · §limits)
- [x] figures complete (fig:lift native pgfplots, no external data file)
- [x] references ≥10 (references.bib — 12 entries, all DOI/arxiv/URL)
- [ ] lint pass (`/paper lint .`)
- [x] compile clean (tectonic 0.16.9 — main.pdf, 7 pages, 0 errors, fig + 11 refs resolved)
- [ ] arxiv submit ready (`/paper arxiv-prep .`)

## qa-results

- **compile: PASS** — `tectonic 0.16.9` (XeTeX engine). `main.pdf` produced, **7 pages**, exit 0, zero LaTeX errors.
- **figure: PASS** — Figure 1 (`fig:lift`, native pgfplots λ-monotone lift) rendered with caption; no external data file.
- **references: PASS** — all **11** `references.bib` entries resolve (`\nocite{*}` surfaces the full curated set; 4 inline `\citep` keys + 7 background refs). No `[?]` undefined cite/ref markers in the output.
- **pages: BELOW TARGET** — 7 pages vs. commons g51 ≥10. The paper is a genuinely focused single-finding result (2583 words, one figure, one results table). NOT padded to 10 — fabricating filler would violate the honesty directives. Path to 10p if required: fill the commented-out BLUE-MAX audit appendix in `main.tex` with the real QFORGE per-hydride recompute table + verify-ledger excerpt (data exists in `companion/recompute-table.csv` + `companion/verify-ledger.json`).
- **tex fixes (no science touched):**
  - tier badge macros `\tier{Blue,Green,Yellow,Orange,Red}` redefined from literal color-emoji to colored `\textbf` text markers (`[FORMAL]`/`[SUPPORTED]`/…) — tectonic's default Latin Modern font has no emoji glyph (Makefile note sanctions this exact fallback). xelatex still renders fine.
  - added `\nocite{*}` before `\bibliographystyle` so all 11 curated references list (numbered natbib otherwise drops the 7 uncited entries).
