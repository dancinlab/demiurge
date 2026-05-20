# domain — space (spacecraft / launch / mission)

> Status: **shallow public-surface map** (`design.md` Decision 3 hybrid).
> Boundary: public-surface clean-room (`design.md` Decision 1). Source:
> Agent-3 (cited). Pipeline = 7-verb spine (`HANDOFF.md` §4 · D5).
> **Note**: proprietary gap is the **smallest of the 6** — NASA's open
> stack covers end-to-end.

**Substrate** (where the .hexa kernels live): hexa-lang `stdlib/space/` + `stdlib/kernels/orbital/` + sibling `~/core/hexa-space/` (born hexa-native + sibling extension)

## 1. "Design blueprint" deliverable

A mission trajectory + ΔV / maneuver plan, spacecraft bus sizing, and
(for launch / aero) outer-mould-line geometry — i.e. an optimized
coupled trajectory + vehicle definition.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (Phase A system-level requirements; NASA SE Handbook) | — |
| 구조 ARCHITECT | (Phase A/B system architecture) | — |
| 설계 DESIGN | **NASA GMAT** (trajectory modelling, LEO → lunar → interplanetary); **OpenVSP** (parametric vehicle geometry) | — |
| 해석 ANALYZE ⟲ | **GMAT** trajectory optimization; **Basilisk** (spacecraft-centric mission / ADCS sim, faster-than-real-time); **NASA Trick** (end-to-end physics) | **AGI / Ansys STK** (mission analysis / visualization) — ⚠ *named from general knowledge, not retrieved source* |
| 합성 SYNTHESIZE | **OpenMDAO** (multidisciplinary analysis & optimization, coupled with GMAT for joint trajectory + system optimization); **OpenVSP3Plugin** (OpenVSP ↔ OpenMDAO bridge) | — |
| 검증 VERIFY | GMAT trajectory validation; Trick end-to-end sim | — |
| 인계 HANDOFF | (Phase D launch / production transition; deliverable per NASA SE Handbook) | — |

## 3. Notable proprietary (public docs only)

**AGI / Ansys STK** (Systems Tool Kit) is the well-known commercial
counterpart for mission analysis / visualization (public marketing
docs; ⚠ *not detailed in retrieved sources — flagged*). Open-vs-
proprietary gap here is the smallest of the six: NASA's open stack
(GMAT, OpenMDAO, OpenVSP, Trick, Basilisk) covers model → optimize →
sim end to end.

## 4. Biggest open-source gap

Unified, polished integrated environment / visualization & ops tooling
(the open pieces are strong individually but require glue code;
STK-class integration is proprietary).

## 5. Cited sources

- NASA GMAT — <https://software.nasa.gov/software/GSC-17177-1>, <https://opensource.gsfc.nasa.gov/projects/GMAT/index.php>
- OpenMDAO workshop — <https://openmdao.org/wp-content/uploads/2022/11/1315_Gage_Harris_OpenMDAO_Workshop_Final.pdf>
- OpenVSP3Plugin — <https://github.com/nasa/OpenVSP3Plugin>
- awesome-space (Basilisk / Trick refs) — <https://github.com/orbitalindex/awesome-space>

## 6. Design options (workbench shelf)

> rfc_012 §5 ingredient shelf — plain design options per verb.
> Line form `- <verb>: <group> = a / b / c`; ` ; ` separates groups.

- 명세: 임무 = 지구궤도 / 행성간 / 착륙
- 설계: 추진 = 화학 / 전기 / 핵열
