# Session journal

페이퍼 작성/검증 세션의 시간순 로그. 각 entry = 한 헤더 + 한 줄 요약.
실험 데이터는 sibling JSON 파일에 (`verify-ledger.json` · `pr-roll.json` · `adapter-defect-catalog.json`); 여기는 사람 읽기용 narrative.

## 2026-05-26 — RTSC monograph SCAFFOLD + BODY

- what changed: scaffolded `rtsc-superconductor/` via paper v0.9.0 `monograph-init`
  (main.tex + 10 appendix stubs + companion/ + pgfplots preamble). Wrote the full
  body (§Intro, §Background, §Full Pipeline, §Dual Axis, §Method, §Results,
  §Context, §Limitations, §Reproducibility, §Conclusion) mirroring the
  HEXA-FUSION 7-gate monograph structure for the RTSC material→magnet domain.
  Renamed appendix files to semantic letters (A McMillan · B Allen-Dynes ·
  C material_verdict · D hydride candidates · E getdp solenoid · F Wheeler M318 ·
  G el-ph inputs · H verify ledger · I PR roll · J reproducibility), each a
  scoped SKELETON with `% TODO (fill batch)` markers. references.bib = 15 real
  entries with DOI. fal.ai cover generated (figures/cover.png).
- what was verified (atom / tier): the pipeline table tier tags are sourced from
  RTSC.md V1-V4 ledger + RTSC.log.md PRs (no invented atoms). verify-ledger.json
  carries 5 atoms (allen_dynes_tc 🟢 |Δ|=2.8e-11 · mcmillan_tc 🟢 · bcs_gap_ratio 🔵
  · solenoid_axis_bz 🟢 · wheeler_fem_bridge 🟢 Δ=+1.42%). Build = 10 pages,
  xelatex clean, 0 undefined refs/citations.
- what stayed open (deferred): appendix BODIES are TODO-marked stubs for the fill
  batches (each appendix needs its comparison pgfplots chart per commons g3 —
  McMillan-vs-Allen-Dynes, measured-vs-predicted Tc, stability-vs-Tc,
  Wheeler-vs-GetDP overlay). absorbed=false is permanent: no room-temperature
  superconductor is claimed; DFT el-ph inputs are sourced, synthesis + multi-lab
  replication are downstream wet-lab (§8.9 5-gate, pipeline stages 8-9).
