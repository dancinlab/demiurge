# 🧬 Phase 3 MD plan — LENS·ECOPAD 분자동역학 — 2026-05-27

> **이전**: SCALP docking #281 · LENS·ECOPAD 분자특성 #283
> **이번**: Phase 3 분자동역학 plan + 실측 환경 평가 + cloud GPU 경로
> **정직 보고**: ubu-1 CPU 4-core 환경에서 진짜 long MD (100ns) 부적합 → cloud GPU pod 필요

---

## 1. 실측 환경 평가 (pool ubu-1)

| 도구 | 상태 |
|---|---|
| GROMACS (gmx) | ❌ 미설치 |
| LAMMPS | ❌ 미설치 |
| **OpenMM 8.5.1** | ✅ Python API (CPU·CUDA·OpenCL) |
| RDKit·Vina·Meeko·PDBFixer | ✅ |
| GPU | ❌ ubu-1 = CPU 4-core only |

→ OpenMM CPU 짧은 시뮬 (10-100ps) 가능. 100ns long MD = cloud GPU pod 필요.

---

## 2. 👁 QD-LENS MD plan

### 2-1. 1차: PHMB-각막세포막 binding MD (cloud GPU)

| 항목 | 내용 |
|---|---|
| 시스템 | POPC bilayer (50 lipids) + PHMB + 5000 water + 0.15M NaCl |
| 시뮬 | 100 ns NPT @ 310K |
| 측정 | PHMB 막 결합 dynamics |
| 도구 | GROMACS + CHARMM36 |
| 환경 | **cloud GPU pod 필수** (V100 100ns ≈ 6-12h · $6) |

### 2-2. 2차: Acanthamoeba protease docking (ubu-1 CPU 무료) ★

| 항목 | 내용 |
|---|---|
| Target | acanthapain (cysteine protease) PDB 3W4C 또는 ribosomal |
| Ligand | PHMB·PQ-1·MPDA·9 cosmetic actives |
| 측정 | Vina binding affinity vs Acanthamoeba |
| 시간 | 30-60분 (Phase 2 패턴) |

→ **권고**: 2차 (ubu-1 CPU) 즉시 진행.

---

## 3. 🌱 QD-ECOPAD MD plan

### 3-1. 1차: 셀룰로오스 SAP swelling (cloud GPU)

| 항목 | 내용 |
|---|---|
| 시스템 | Cellobiose polymer (n=10) + 2000 water + Glycerin 50 + Lactic acid 20 |
| 시뮬 | 50 ns NPT @ 298K |
| 측정 | water uptake rate · swelling ratio |
| 도구 | LAMMPS + OPLS-AA |
| 환경 | V100 50ns ≈ 3-6h · $3 |

### 3-2. 2차: Chitosan-membrane OpenMM 10ns (ubu-1 CPU) ★

| 항목 | 내용 |
|---|---|
| 시스템 | Chitosan trimer + 락토바실러스 모방 PE 막 |
| 시뮬 | 10 ns NPT |
| 측정 | Chitosan 양이온-막 결합 dynamics |
| 환경 | ubu-1 CPU 1-2h |

→ **권고**: 2차 (OpenMM CPU) ubu-1 시도.

---

## 4. 🚀 진입 우선순위

| 순위 | 작업 | 환경 | 시간 | 비용 |
|---|---|---|---|---|
| ★ 1 | LENS Acanthamoeba Vina docking | ubu-1 CPU | 30-60분 | $0 |
| ★ 2 | ECOPAD Chitosan-막 OpenMM 10ns | ubu-1 CPU | 1-2h | $0 |
| 3 | LENS PHMB-POPC 100ns | Vast V100 | 6-12h | $6 |
| 4 | ECOPAD 셀룰로오스 SAP 50ns | Vast V100 | 3-6h | $3 |

Phase 3 cloud 비용 합계: **$10-15**

---

## 5. ⚠ 정직한 한계 (g5)

- ubu-1 CPU 4-core 100ns MD는 1-2주 — 부적합
- OpenMM CPU 짧은 MD (10ns)는 가능하나 통계적 의미 약함
- 본격 MD validation = cloud GPU pod 필수
- in silico Phase 3는 실측 CRO 대체 X · 보강용

## 6. 결정 옵션

| 옵션 | 작업 |
|---|---|
| ★ A | LENS Acanthamoeba Vina docking (ubu-1, 즉시) |
| B | ECOPAD Chitosan-막 OpenMM 10ns (ubu-1, 1-2h) |
| C | A+B 둘 다 (무료·즉시) |
| D | Cloud GPU 100ns MD ($10-15) |
| E | Phase 3 보류, 실측 CRO RFQ 우선 |
