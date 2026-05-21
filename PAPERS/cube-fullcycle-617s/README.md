# cube-fullcycle-617s — H-formulation cube benchmark full-cycle validation

> Second paper in `PAPERS/`. Documents the GetDP 4.0.0 + life-hts cube
> H-formulation transient solve as a *toolchain validation* (Tier 1
> simulation grade) — establishes that the HTS-grade FEM substrate that
> RTSC.md `§4.3 (s1)` flagged as the next-step caveat is **functional
> on Apple Silicon native, no Linux pool**.
>
> opened: 2026-05-22 KST · status: draft · target ~8-10 pages

## Source

- `main.tex` — single-column arxiv-style LaTeX (article class, 11pt A4)
- `references.bib` — BibTeX with DOI / arxiv / URL provenance
- `Makefile` — `make` builds `main.pdf` (3-pass + bibtex + figure regen)
- `figures/_scripts/fig01_transient_series.py` — matplotlib synthetic
  envelope plot (anchored to RTSC.md §4.2.1.d metrics)

## Build

```bash
cd PAPERS/cube-fullcycle-617s/
make figs       # regenerate figures/*.pdf
make            # → main.pdf (runs check_rtsc_claim first)
make clean
```

## Headline metrics (anchors)

From RTSC.md §4.2.1.d, GetDP 4.0.0 cube benchmark full-cycle run
(2026-05-21 session, macOS arm64 native):

| metric | value |
|---|---|
| wall_time | 617.636 s (10.3 min) |
| cpu_time | 558.961 s |
| memory peak | 177.703 MB |
| final TimeStep | 248–249 (t = 0.025 s, one AC cycle) |
| KSP residual / step | ~5–8 × 10⁻¹⁶ |
| nodes | 1937 · elements 5589 · DOFs 3601 |
| exit | natural `Stopped` (no timeout) |

Cross-validation against linear A-φ FEM `solenoid_axisym` (RTSC.md
§4.2.1.b): B_center closed-form vs FEM Δ = **−1.40 %** (closed-form
0.06939 T, FEM 0.06842 T) — paper §6.

## Honest g3 stance

- **NO `RTSC absorbed=true` claim** — this paper documents Tier 1
  simulation toolchain capability only. `check_rtsc_claim.sh` exits 0
  silently (optimistic-default, no claim present).
- **Tier 1 only**: RTSC.md §8.7 / §9.6 `gate_type =
  simulation-only-prediction · absorbed=false 영구` applies.
- **life-hts license-unclear** (D1 stance, RTSC.md §4.2.1.b row D1):
  cube/cube.pro consumed via thin-adapter
  (`stdlib/rtsc/h_formulation_adapter.py`); source kept under
  gitignored `_external/` cache.
- **No fal.ai / marketing figures** — matplotlib only, synthetic
  envelope captioned explicitly as schematic reconstruction.
- All quantitative anchors trace to RTSC.md §4.2.1.b / §4.2.1.d
  verbatim metrics + bibtex refs with DOI/arxiv/URL.

## Cross-reference

- `~/core/demiurge/RTSC.md` §4.2.1.b · §4.2.1.c · §4.2.1.d · §4.3
- `~/core/hexa-lang/stdlib/rtsc/h_formulation_adapter.py` (SSOT
  producer for the metrics this paper documents)
- `~/core/hexa-lang/stdlib/rtsc/templates/hts_workgroup/` (license-unclear
  source provenance manifests)
- `~/core/demiurge/PAPERS/sample-nb-bcs-absorbed/` (first paper, LTS
  attestation pattern; this paper is the *substrate* counterpart)
