# domain — chem (chemistry / reactions / catalysis)

> Status: **D81 신규 도메인** (2026-05-20). 짧은-id 명칭 (D81-A picked).
> Boundary: public-surface clean-room (D1). Pipeline = 7-verb spine
> (D5). Substrate SSOT (planned): `~/core/hexa-chem/` (D17 sibling-repo
> precedent — molecular-scale substrate too large for one hexa-lang
> stdlib subtree).
>
> Graph (D82): prereq = `[matter]`. facets = `{scale: molecular,
> cluster: [chem, matter], hostility: macos-clean}`.

**Substrate** (where the .hexa kernels live): NOT YET — no `stdlib/chem/` subtree and no sibling `~/core/hexa-chem/` repo; substrate SSOT planned via D17 sibling-repo precedent (will reuse `stdlib/{mol,crystal}/` from matter at chain-stage)

## 1. Deliverable

A reaction-route + catalysis design — feedstock → target molecule
synthesis path (mechanism + kinetics + selectivity), catalyst structure
+ active-site spec, thermo / EHS (environment-health-safety) dossier.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (target spec; IUPAC nomenclature; safety datasheet REACH / GHS) | — |
| 구조 ARCHITECT | (reaction tree, retrosynthesis) | **Schrödinger Suite** (proprietary retro) |
| 설계 DESIGN | **RDKit** (cheminformatics, BSD-3); **AiZynthFinder** (retrosynthesis, MIT); **OpenBabel** (file format conversion) | **Reaxys** / **SciFinder** (db, paywall) |
| 해석 ANALYZE ⟲ | **Psi4** (ab initio QM, LGPL); **xTB** (semiempirical, LGPL); **Cantera** (kinetics, BSD) | **Gaussian** (QM, proprietary) |
| 합성 SYNTHESIZE | (lab protocol authoring; reaction monitoring) | — |
| 검증 VERIFY | **OpenMM** + **RDKit** confirmation (energetics + structure); **AutoChem** workflow | (GMP/GLP audit infrastructure) |
| 인계 HANDOFF | (regulatory: REACH / TSCA dossier; patent filing) | — |

## 3. Notable proprietary

Schrödinger / Reaxys / SciFinder / Gaussian dominate retrosynthesis +
db search + QM at high fidelity. Open path (RDKit + Psi4 + xTB +
Cantera + AiZynthFinder) reaches mid-fidelity but not bench-validated
catalyst design at industrial scale yet.

## 4. Biggest open-source gap

Catalyst active-site design with experimentally-validated turnover
prediction — open QM (Psi4) handles thermodynamics, semiempirical (xTB)
handles screening, but the bench-validated active-site → turnover
prediction loop lives in commercial Schrödinger pipelines.

## 5. Cited sources

- RDKit — <https://www.rdkit.org>
- AiZynthFinder — <https://github.com/MolecularAI/aizynthfinder>
- Psi4 — <https://psicode.org>
- xTB — <https://github.com/grimme-lab/xtb>
- Cantera — <https://cantera.org>
- OpenMM — <https://openmm.org>

## 6. Workbench shelf — proposed defaults

- 명세: text editor on `requirements.json` + IUPAC validator
- 구조: RDKit retrosynthesis dendrogram view
- 설계: AiZynthFinder route diff
- 해석: Psi4 / xTB result table
- 합성: lab protocol .md emit
- 검증: OpenMM energy convergence check
- 인계: dossier tar.gz bundle

## 7. D72 kernel mapping

`kernels/chem_qm/` (planned) — Psi4 / xTB / OpenMM shared QM kernel
when a 2nd consumer appears outside chem (e.g., bio molecular dynamics).
For now adapter-only.

## 8. Cross-domain

- prereq: matter (반응 환경 + 촉매 담지체 재료)
- consumes: hexa-chem sibling repo (planned)
- consumed by: bio (분자생물 → 화학 합성 경로), ufo (Stage-2 propellant
  chemistry indirect)
