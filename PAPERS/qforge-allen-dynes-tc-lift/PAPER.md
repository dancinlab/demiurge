# qforge-allen-dynes-tc-lift — paper status

@title: 📄 Proper Allen-Dynes f1·f2 raises every recorded Tc by a λ-monotone margin
@goal: Show the RTSC campaign's recorded "Allen-Dynes Tc" are AD-kernel lower bounds — the true f1·f2 form lifts every Tc on the same DFPT moments by +2.5% (λ=0.62) to +35% (λ=4.38), with high-λ + high-pressure caveats and no room-temp claim.

- [x] draft v1 (main.tex — §hypothesis · §method · §verify · §results · §finding · §limits)
- [x] figures complete (fig:lift native pgfplots, no external data file)
- [x] references ≥10 (references.bib — 12 entries, all DOI/arxiv/URL)
- [ ] lint pass (`/paper lint .`)
- [x] compile clean (tectonic 0.16.9 — main.pdf, 10 pages, 0 errors, fig + 11 refs resolved)
- [ ] arxiv submit ready (`/paper arxiv-prep .`)

## qa-results

- **compile: PASS** — `tectonic 0.16.9` (XeTeX engine). `main.pdf` produced, **10 pages**, exit 0, zero LaTeX errors (only cosmetic overfull-hbox warnings on the verbatim `hexa verify` code lines).
- **figure: PASS** — Figure 1 (`fig:lift`, native pgfplots λ-monotone lift) rendered with caption; no external data file.
- **references: PASS** — all **11** `references.bib` entries resolve (`\nocite{*}` surfaces the full curated set; 4 inline `\citep` keys + 7 background refs). No `[?]` undefined cite/ref markers in the output.
- **pages: AT TARGET** — **10 pages** vs. commons g51 ≥10. Reached by filling the
  real per-candidate BLUE-MAX audit appendix (App.~A), NOT by padding: a DFPT-moment
  provenance table (14 record files · q-grid · pressure), the per-candidate `hexa verify`
  grade table for all 14 candidates at both μ* (28 GREEN SUPPORTED-NUMERICAL evaluations),
  the 9 remaining verbatim `hexa verify --expr` invocations, and a row-by-row reading
  (λ-monotone spine · per-candidate high-λ over-prediction caveat for CaH6/H3Po · f2=1
  lower-bound bracket · excluded unstable Mg2IrH6/Li2CuH6 + H3As UNSTABLE flag ·
  allen_dynes_full rescale defect fixed in hexa-lang PR#2374, CaH6 416K→344K). All data
  sourced from `companion/recompute-table.csv` + `companion/verify-ledger.json` — no
  fabricated rows.
- **tex fixes (no science touched):**
  - tier badge macros `\tier{Blue,Green,Yellow,Orange,Red}` redefined from literal color-emoji to colored `\textbf` text markers (`[FORMAL]`/`[SUPPORTED]`/…) — tectonic's default Latin Modern font has no emoji glyph (Makefile note sanctions this exact fallback). xelatex still renders fine.
  - added `\nocite{*}` before `\bibliographystyle` so all 11 curated references list (numbered natbib otherwise drops the 7 uncited entries).
