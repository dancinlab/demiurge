# domain — CERN (particle accelerator)

> Status: **shallow public-surface map** (`design.md` Decision 3 hybrid;
> chip deep, this domain shallow). Boundary: public-surface clean-room
> (`design.md` Decision 1). Source: Agent-3 (cited). Pipeline = 7-verb
> spine (`HANDOFF.md` §4 · `design.md` Decision 5).

## 1. "Design blueprint" deliverable

A lattice/optics file (MAD-X sequence is the de-facto standard format)
plus magnet & RF-cavity specs, defining element layout, beam-optics
functions, dynamic aperture, and radiation/shielding budgets for a
beamline or storage ring.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 (역량/공백 분석용) |
|---|---|---|
| 명세 SPECIFY | (physics case / CDR; OSS spec-format 약함) | — |
| 구조 ARCHITECT | (ring/lattice topology; in-tool) | — |
| 설계 DESIGN | **MAD-X** (de-facto lattice/optics language); **Xsuite** (Python toolkit) | — |
| 해석 ANALYZE ⟲ | **elegant** (dynamic aperture, 6-D tracking); **Xsuite** (GPU tracking, collective effects); **WarpX/BLAST** (PIC plasma-based) | — |
| 합성 SYNTHESIZE | **MAD-X / Xsuite** optics matching & optimization; magnet/RF engineering design | **CST Microwave Studio**, **OPERA** (3-D RF/magnet EM) |
| 검증 VERIFY | **Geant4** (radiation/shielding); elegant tracking; MAD-X survey/floor coords | **FLUKA** (MC radiation transport; standalone *not publicly distributed*; Geant4 interface to FLUKA hadronic models exists — EPJ N 2024) |
| 인계 HANDOFF | (TDR → construction; OSS deliverable format 약함) | — |

## 3. Notable proprietary (public docs only)

**FLUKA** — Monte-Carlo radiation transport; standalone code not
publicly distributed (only the Geant4 interface to its hadronic models
is open). **CST Microwave Studio**, **OPERA** for 3-D RF/magnet EM.
Open beam-optics/tracking layer (MAD-X, elegant, Xsuite) is mature and
operational; proprietary advantage is concentrated in high-fidelity
3-D EM cavity/magnet design and full FLUKA shielding.

## 4. Biggest open-source gap

Integrated high-fidelity 3-D RF-cavity + superconducting-magnet EM
design — open codes (SUPERFISH 2-D, ACE3P) exist but the practical 3-D
workflow leans on CST / OPERA.

## 5. Cited sources

- MAD-X — <https://uspas.fnal.gov/materials/18ODU/Fund/using-mad-x.html>
- Accelerator physics codes — <https://en.wikipedia.org/wiki/Accelerator_physics_codes>
- Xsuite (IPAC2024) — <https://proceedings.jacow.org/ipac2024/pdf/WEPR56.pdf>
- elegant (radiasoft container) — <https://github.com/radiasoft/container-beamsim>
- Geant4 — <https://github.com/Geant4/geant4>
- Xsuite GPU tracking — <https://home.cern/events/xsuite-multiplatform-python-toolkit-beam-dynamics>
- WarpX / BLAST — <https://blast.lbl.gov/codes/>, <https://warpx.readthedocs.io/en/24.08/theory/intro.html>
- FLUKA Geant4 interface — <https://www.epj-n.org/articles/epjn/full_html/2024/01/epjn20240018/epjn20240018.html>
- CST / OPERA refs — arXiv:2308.09792 ; <https://www.adcomsim.co.il/opera/>

## 6. Design options (workbench shelf)

> rfc_012 §5 ingredient shelf — plain design options per verb.
> Line form `- <verb>: <group> = a / b / c`; ` ; ` separates groups.

- 구조: 격자 = FODO / TME / DBA
- 설계: 자석 = 상전도 / 초전도 ; 가속 = 선형 / 원형
