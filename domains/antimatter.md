# domain — antimatter (antiproton/positron trap + PET)

> Status: **shallow public-surface map** (`design.md` Decision 3 hybrid).
> Boundary: public-surface clean-room (`design.md` Decision 1). Source:
> Agent-3 (cited). Pipeline = 7-verb spine (`HANDOFF.md` §4 · D5).

**Sibling sub-domains** (hexa-antimatter repo): antimatter-factory

## 1. "Design blueprint" deliverable

A Penning / Penning-Malmberg trap electrode + magnet geometry with
electrostatic potential maps and plasma-parameter targets (positron
temperature, density, rotation, space charge); for PET, a cyclotron +
target / radiochemistry facility spec.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (physics case; antihydrogen-yield models) | — |
| 구조 ARCHITECT | (trap topology / cyclotron magnet config; in-tool) | — |
| 설계 DESIGN | Trap models from published refs (Fajans & Surko, RMP 87:247) | — |
| 해석 ANALYZE ⟲ | **Geant4** (antiproton/positron–matter interaction); custom PIC / non-neutral-plasma codes (⚠ **no dominant OSS confirmed** — most groups use bespoke codes) | — |
| 합성 SYNTHESIZE | Plasma-parameter optimization per antihydrogen-yield models (arXiv:2503.22471, arXiv:2603.21168) | — |
| 검증 VERIFY | Geant4 (antiproton stopping/annihilation); PET radionuclide reaction channels from public cyclotron literature | — |
| 인계 HANDOFF | (cyclotron build / trap commissioning; OSS deliverable format 약함) | — |
| ⊥ 자원 | **ARTIQ + Sinara** (open HW/SW ecosystem for trap-control electronics, arXiv:2503.22471) | Commercial PET cyclotrons (compact / SC, e.g. H− SC; Springer S1547477114060132) |

## 3. Notable proprietary (public docs only)

Commercial PET cyclotrons (compact / superconducting) documented in
public literature; cyclotron magnet/RF design overlaps the RTSC and
CERN proprietary EM stack. Design here is dominated by physics
first-principles and bespoke codes rather than a packaged commercial
suite.

## 4. Biggest open-source gap

A standard, packaged open-source non-neutral-plasma / trap-dynamics
simulator — most groups appear to use custom codes (⚠ flagged
uncertain by Agent-3).

## 5. Cited sources

- Geant4 — <https://github.com/Geant4/geant4>
- Fajans & Surko (RMP 87:247) — <https://link.aps.org/accepted/10.1103/RevModPhys.87.247>
- arXiv:2503.22471 (antihydrogen-yield + ARTIQ/Sinara) — <https://arxiv.org/html/2503.22471v2>
- arXiv:2603.21168 — <https://arxiv.org/abs/2603.21168>
- Compact H− SC cyclotron — <https://link.springer.com/article/10.1134/S1547477114060132>

## 6. Design options (workbench shelf)

> rfc_012 §5 ingredient shelf — plain design options per verb.
> Line form `- <verb>: <group> = a / b / c`; ` ; ` separates groups.

- 구조: 트랩 종류 = Penning / Penning-Malmberg
- 설계: 자석 = 영구자석 / 초전도 ; 전극 = 원통형 / 분할형
