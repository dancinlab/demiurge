# qforge-screened-vertex-localfield-fxc — paper status

@title: 📄 The missing local field: a live f_xc[ρ(r)] convolution lets a from-scratch screened el-ph vertex cross the bare baseline
@goal: Show that round-7 of the QFORGE screened-vertex search REVERSES the prior 6-round "closed-negative / bare-is-best" ruling — engaging the structurally dead local-field f_xc[ρ(r)] convolution raises CaH6 λ to 4.1518, the first of seven rounds to cross bare 4.137 (rel-ε 5.12% < bare 5.47%); gap reduced ~6×; gate ≤1% still not met (residual = LDA-vs-QE XC functional, R8 testing GGA), hybrid (1.65e-7) remains production.

- [x] draft v1 (main.tex — §hypothesis · §method · §measurement · §finding · §limits · §conclusion)
- [x] λ-trajectory table + figure (R7=4.1518, first to cross bare — native pgfplots, no external data)
- [x] references ≥10 (references.bib — 13 entries, all DOI/URL)
- [x] slug rename — `closed-negative` retired (FALSIFIED by R7); slug = `localfield-fxc`
- [ ] lint pass (`/paper lint .`)
- [x] compile clean (tectonic — main.pdf)
- [ ] arxiv submit ready (`/paper arxiv-prep .`)

## provenance

- Central result verbatim from `.verdicts/qforge-cah6-fxc-localfield-r7/VERDICT.md` (d6 — not tuned).
- R3–R6 trajectory rows from `.verdicts/qforge-cah6-{lindhard,rpa-chi0-r4,dvscf-r5,phonon-scr-r6}/`.
- Bare baseline 4.13647 (5.47%) from `qforge-lane1-basis-sweep`.
- Engine-status SSOT: `QFORGE/QFORGE.md` ⭐ ENGINE STATUS mode (c).

## correction note

This paper SUPERSEDES the (never-committed, lost-with-swept-worktree) draft
`qforge-screened-vertex-closed-negative`. That draft's central claim
("from-scratch screened is CLOSED, bare paradoxically best") is FALSIFIED by
R7: the missing piece was the live local-field f_xc[ρ(r)], found in R7; the
screened vertex now ENHANCES past bare. The slug `closed-negative` is therefore
misleading and retired; the corrected slug names the finding (`localfield-fxc`).
Honest gate status preserved: ≤1% NOT met at 5.12%; hybrid remains production.
