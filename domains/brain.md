# domain — brain (implantable neural interface · Neuralink-class)

> Status: **shallow public-surface map** (`design.md` Decision 3 hybrid).
> Boundary: public-surface clean-room (`design.md` Decision 1). Source:
> Agent-3 (cited). Pipeline = 7-verb spine (`HANDOFF.md` §4 · D5).
> **Note**: proprietary gap is the **largest of the 6** — regulatory-
> grade implant safety sim has no open equivalent.

**Substrate** (where the .hexa kernels live): hexa-lang `stdlib/brain/` + sibling `~/core/hexa-brain/` (born hexa-native + sibling extension)

## 1. "Design blueprint" deliverable

Electrode-array layout (site geometry / pitch, shank dimensions),
interconnect / ASIC integration, hermetic package design, plus
EM/thermal safety dossier and FDA design-control documentation.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (FDA Design Input per 21 CFR 820.30; user needs) | — |
| 구조 ARCHITECT | (probe / shank architecture; Neuropixels CMOS reference: 960–1280 sites/shank, IMEC) | — |
| 설계 DESIGN | Probe architecture from public refs (Neuropixels — Wiley brx2.65, Nature s41378-022-00451-6); **KiCad** for PCB / interconnect (⚠ *plausible / common but not directly evidenced in retrieved sources*) | — |
| 해석 ANALYZE ⟲ | Electrode impedance / site sizing from EIS (Electrochemical Impedance Spectroscopy) methods in literature (PMC10583290); polyimide / SU-8 thin-film mask layout via standard microfab (Nature s41378-022-00466-z) | **Sim4Life** (EM / thermal implant & MRI-safety; ZMT / IT'IS); **COMSOL** FEM (stimulation confinement / volume-conductor) |
| 합성 SYNTHESIZE | (microfab / thin-film process; OSS spec-format 약함) | — |
| 검증 VERIFY | FDA design-control flow (21 CFR 820.30 / Design Controls) as regulatory verify gate | **COMSOL** FEM (MDPI Sensors 16/6/880); **Sim4Life** — first FDA-approved computational-modelling MDDT (MRIxViP, MRI-safety) |
| 인계 HANDOFF | FDA **Design Transfer** (21 CFR 820.30); PMA / 510(k) premarket submission | — |

## 3. Notable proprietary (public docs only)

**Sim4Life** and **COMSOL Multiphysics** dominate verify / simulate;
no equivalent validated open EM-bio-thermal implant simulator
surfaced. Sim4Life's MDDT (Medical Device Development Tool, FDA)
status has no open equivalent.

## 4. Biggest open-source gap

A validated open-source implant EM / thermal / MRI-safety simulator
with regulatory acceptance (Sim4Life's MDDT status has no open
equivalent).

## 5. Cited sources

- Neuropixels CMOS — <https://onlinelibrary.wiley.com/doi/full/10.1002/brx2.65>, <https://www.nature.com/articles/s41378-022-00451-6>
- EIS for electrode sizing — <https://pmc.ncbi.nlm.nih.gov/articles/PMC10583290/>
- Thin-film implant microfab — <https://www.nature.com/articles/s41378-022-00466-z>
- COMSOL stimulation confinement — <https://www.mdpi.com/1424-8220/16/6/880>
- Sim4Life — <https://zmt.swiss/news-and-events/news/sim4life/sim4life-release-v7-0>, <https://sim4life.swiss/mri-modules>

## 6. Design options (workbench shelf)

> rfc_012 §5 ingredient shelf — plain design options per verb.
> Line form `- <verb>: <group> = a / b / c`; ` ; ` separates groups.

- 구조: 패키지 = 밀폐형 / 폴리머
- 설계: 전극 = 표면형 / 침습형 ; 채널 수 = 64 / 256 / 1024
