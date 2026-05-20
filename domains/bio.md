# domain — bio (molecular biology / proteins / DNA / RNA / drugs)

> Status: **D81 신규 도메인** (2026-05-20). 짧은-id 명칭 (D81-A picked).
> Boundary: public-surface clean-room (D1). Pipeline = 7-verb spine
> (D5). Substrate SSOT (planned): `~/core/hexa-bio/` (D17 sibling-repo
> precedent; GOAL.md NOT 섹션이 이미 cite — "hexa-bio (분자) typed-
> interface consumed").
>
> Graph (D82): prereq = `[chem, matter]`. facets = `{scale: molecular,
> cluster: [bio, chem, life], hostility: macos-clean}`.

**Substrate** (where the .hexa kernels live): sibling `~/core/hexa-bio/` (D17 sibling-repo; T3 .py→.hexa port in progress per `hexa-lang/stdlib/PLAN.md` — D80 pilot WEAVE); no `stdlib/bio/` subtree yet

## 1. Deliverable

A molecular-biology design package — target (protein / DNA / RNA /
drug) structure prediction, binding-site identification, expression
construct (gene synthesis spec), drug-target validation data + safety
panel. For drug-discovery projects: lead-compound spec + ADMET profile.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (target spec: gene of interest, FASTA, UniProt id; clinical-indication if drug) | — |
| 구조 ARCHITECT | (functional decomposition: domain → motif → residue) | — |
| 설계 DESIGN | **AlphaFold 3** (DeepMind, model open Sept 2024); **ESMFold** (Meta, MIT); **Boltz-1** (MIT 2025); **Rosetta Commons** (academic) | **Schrödinger LiveDesign**, **Cresset** (proprietary suites) |
| 해석 ANALYZE ⟲ | **GROMACS** (MD, LGPL); **OpenMM** (MD, MIT); **PyMOL** (open core); **Biopython** (parsers + tools, BSD); **BLAST+** (NCBI) | **Schrödinger Maestro / Desmond** (proprietary MD) |
| 합성 SYNTHESIZE | (gene synthesis order + expression construct generation; protein design via RFdiffusion / ProteinMPNN — both open) | (commercial gene-synthesis vendors — IDT, Twist) |
| 검증 VERIFY | **Foldseek** (structure-search, GPL); **DSSP** (secondary structure); MD trajectory validation (GROMACS) | (wet-lab assay houses, paywalled CRO services) |
| 인계 HANDOFF | (Genbank deposit, PDB deposit, patent filing, FDA IND / EMA CTA for drug) | — |

## 3. Notable proprietary

Schrödinger / Cresset dominate drug-discovery workflows; AlphaFold 3
model release Sept 2024 closed key gap for structure prediction.
Wet-lab validation (binding assays, in-vivo PK/PD, clinical) remains
firmly outside open-source scope — that's the bio gap that demiurge
honestly cannot close in software.

## 4. Biggest open-source gap

Wet-lab assay automation + clinical-trial design + ADMET (Absorption /
Distribution / Metabolism / Excretion / Toxicity) prediction at
regulatory-grade accuracy. Open MD + structure prediction (AlphaFold3 /
ESMFold / GROMACS) are near-state-of-the-art for in-silico modelling.

## 5. Cited sources

- AlphaFold 3 — Abramson, J., et al. *Nature* 630, 493–500 (2024)
- ESMFold — Lin, Z., et al. *Science* 379, 1123–1130 (2023)
- Boltz-1 — Wohlwend, J., et al. arXiv:2411.16107 (2024)
- RFdiffusion — Watson, J. L., et al. *Nature* 620, 1089–1100 (2023)
- ProteinMPNN — Dauparas, J., et al. *Science* 378, 49–56 (2022)
- GROMACS — <https://www.gromacs.org>
- OpenMM — <https://openmm.org>
- Foldseek — van Kempen, M., et al. *Nature Biotechnology* 42, 243–246 (2024)
- BLAST+ — <https://blast.ncbi.nlm.nih.gov>
- PyMOL — <https://pymol.org>

## 6. Workbench shelf — proposed defaults

- 명세: FASTA input + UniProt search
- 구조: domain-architecture diagram (Biopython + matplotlib)
- 설계: AlphaFold3 / ESMFold predicted structure (.pdb)
- 해석: GROMACS MD trajectory + energy plot
- 합성: gene synthesis order .csv + protein-MPNN design batch
- 검증: Foldseek structure-search hits + DSSP report
- 인계: PDB / Genbank deposit form + IND/CTA dossier

## 7. D72 kernel mapping

`kernels/bio_md/` (planned) — GROMACS / OpenMM shared molecular
dynamics kernel for any cell that does MD (currently bio is the only
consumer, so adapter-only). `kernels/bio_struct_pred/` (planned)
— AlphaFold/ESMFold/Boltz unified inference interface when a 2nd
consumer surfaces (e.g., chem ligand-pocket prediction).

## 8. Cross-domain

- prereq: chem (분자 합성 경로 cited), matter (formulation 재료)
- consumes: hexa-bio sibling repo (planned)
- consumed by: brain (cortex biological tissue model), aura (cortical
  tissue interface), ufo (Stage-3 antimatter biosignature panel)
