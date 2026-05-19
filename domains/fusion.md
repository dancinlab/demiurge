# domain — fusion (tokamak / ICF reactor / powerplant)

> Status: **shallow public-surface map** (Cohort 2, `design.md` Decision 6;
> Decision 3 hybrid pattern). Boundary: public-surface clean-room
> (`design.md` Decision 1). Pipeline = 7-verb spine (`HANDOFF.md` §4 · D5).
> **Note**: shares MC-transport + FEM stack with `cern.md` / `antimatter.md` /
> `energy.md` — strongest cross-cohort tool-class overlap candidate.

## 1. "Design blueprint" deliverable

A reactor concept package — plasma equilibrium + scenario (Grad-Shafranov
solution + scrape-off-layer profile), blanket / divertor neutronics with
tritium-breeding ratio (TBR), magnet / coil layout, plus shielding and
shutdown-dose-rate (SDDR) dossier for licensing.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (physics case / Q-target / TBR-target; IAEA fusion-safety design basis) | — |
| 구조 ARCHITECT | (tokamak / stellarator / ICF topology; magnet + blanket arrangement) | — |
| 설계 DESIGN | **FreeGS** (free-boundary Grad-Shafranov, LGPL; freegs-plasma/freegs); **FreeGSNKE** (time-evolutive extension) | — |
| 해석 ANALYZE ⟲ | **BOUT++** + **Hermes-3** (edge / SOL turbulence, GPL-3); plasma equilibrium iteration via FreeGSNKE | **SOLPS-ITER** (scrape-off-layer plasma; ITER-Org distribution, restricted to ITER-member institutions — ⚠ *public GitHub presence but not open-license*) |
| 합성 SYNTHESIZE | (engineering sizing — magnet / blanket / divertor; no single OSS suite) | **ANSYS** / **COMSOL** (3-D coupled magnet + structural + thermal) |
| 검증 VERIFY | **OpenMC** (Monte-Carlo neutronics, MIT; TBR + SDDR — Argonne tokamak-application workshop 2025; benchmarked vs MCNP / Serpent on SPARC + DEMO + ITER); **Geant4** (radiation transport, public hadronic models); **DAGMC** (CAD-based MC bridge) | **FLUKA** (single-step SDDR for ITER, validated vs FNG-ITER benchmark; standalone distribution restricted — Fusion Sci. Tech. 2024); MCNP (LANL, export-controlled) |
| 인계 HANDOFF | (licensing dossier per IAEA / national regulator; OSS deliverable format 약함) | — |

## 3. Notable proprietary (public docs only)

**SOLPS-ITER** dominates plasma-edge modelling but is distributed only to
ITER-member institutions (the GitHub mirror is access-gated). **FLUKA**
standalone, **MCNP** (LANL, export-controlled), and **ANSYS / COMSOL**
for 3-D coupled multiphysics fill the proprietary stack. Open neutronics
(OpenMC, Geant4 + DAGMC) has reached benchmark-credible status against
the commercial reference (MCNP / Serpent / FLUKA), per the 2024–2025
fusion-neutronics literature.

## 4. Biggest open-source gap

Integrated 3-D coupled engineering simulation of magnet + blanket +
structural + thermal-hydraulic + tritium transport — open codes exist
per sub-physics (FreeGS / BOUT++ / OpenMC) but no unified multiphysics
reactor-engineering workflow. The plasma-edge `SOLPS-ITER` access-gating
is a second, distinct gap (no fully open SOL plasma solver of equal
maturity).

## 5. Cited sources

- FreeGS — <https://github.com/freegs-plasma/freegs>
- FreeGSNKE — <https://github.com/FusionComputingLab/freegsnke>
- BOUT++ / Hermes-3 — <https://boutproject.github.io/>, <https://github.com/boutproject/hermes>, arXiv:2303.12131
- OpenMC tokamak application (ANL 2025) — <https://events.cels.anl.gov/event/610/>
- OpenMC / Geant4 fusion-blanket TBR benchmark — <https://link.springer.com/article/10.1007/s10894-025-00500-8>
- SOLPS-ITER (ITER-Org repo) — <https://github.com/iterorganization/SOLPS-ITER>, <https://www.iter.org/node/20687/new-solps-iter-code-version-launched>
- FLUKA fusion SDDR (FNG-ITER benchmark) — <https://www.tandfonline.com/doi/full/10.1080/15361055.2024.2448414>
- IMAS open-source release — <https://www.iter.org/node/20687/release-imas-infrastructure-and-physics-models-open-source>

## 6. Design options (workbench shelf)

> rfc_012 §5 ingredient shelf — plain design options per verb.
> Line form `- <verb>: <group> = a / b / c`; ` ; ` separates groups.

- 구조: 노형 = 토카막 / 스텔러레이터
- 설계: 자석 = 저온초전도 / 고온초전도 ; 블랭킷 = 액체금속 / 고체
