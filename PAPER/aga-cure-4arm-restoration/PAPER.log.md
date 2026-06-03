# aga-cure-4arm-restoration — paper log

Append-only history sister of `PAPER.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-06-03 — scaffold + draft v1 (11pp, compiles clean)
- [x] copied template (universal-neogenesis-bottleneck-senolytic) → constructive AGA 4-arm design paper
- [x] rewrote main.tex: title, abstract, intro/bg/related, Full Pipeline, Method, Results (4 arms + composition + lock-timing + neogenesis + permanence + delivery + single-param re-gate), Discussion, Limitations, Reproducibility, appendix (claim-record audit + code listing)
- [x] fig01_arms.py — per-arm marginal value (permanence −37.3pp) + composed restoration (78.7% mean) vs ≥70%/≥90% gates
- [x] fig02_locktiming.py — DC6 lock-timing saturation curve (knee ~month 18, 0.946)
- [x] references.bib trimmed to 11 real-DOI entries; added Xu 2021 CasMINI (10.1016/j.molcel.2021.08.008) + Kageyama 2022 follicle organoid (10.1126/sciadv.add4603)
- [x] replaced unicode circled-digit arm markers ①..④ with font-independent \arm{N} (\textcircled) — Latin-Modern has no U+2460 glyphs
- [x] tectonic compile: 0 errors, 0 undefined refs/citations, 11 pages
- [ ] arxiv-prep — pending user go
