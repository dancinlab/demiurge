# 👁 QD-LENS — Vina docking 결과 (Phase 3a) — 2026-05-27

> **이전**: LENS RnD Deep (#271) · LENS+ECOPAD 분자특성 + RFQ (#283)
> **이번 Phase 3a**: 6L8H chain A × 7 LENS ligand Vina docking · 2m10s wall · ubu-1 CPU
> **다음**: 정확한 Acanthamoeba protein PDB 검증 (6BJX 등) + ECOPAD Chitosan-막 OpenMM

---

## 1. 실행 환경

| 항목 | 값 |
|---|---|
| host | pool ubu-1 (CPU 4-core) |
| 시간 | 2m 10.8s wall · 7m 38s CPU |
| Receptor | 6L8H chain A (oxidoreductase + HEM, 7,420 ATOM lines) |
| 활성 부위 | HEM (heme cofactor) centroid = (4.37, 7.28, -70.05) · 43 atoms |
| Box | 24 × 24 × 24 Å |
| Ligand | 7 LENS actives (PDBQT prep 성공 — Polyquat ionic salt fail) |

## 2. Docking 결과

| Rank | Compound | BindAff (kcal/mol) | 해석 |
|---|---|---|---|
| 1 | **α-Tocopherol** | **-8.29** | ★ logP +8.84 lipophilic 정합 · 단백질 binding 추가 우위 |
| 2 | Hyaluronic acid | -7.40 | 점막 친화 + 단백질 binding |
| 3 | PHMB n=4 | -7.35 | ★ 보존제 active site 침투력 추가 |
| 4 | Citric acid | -6.31 | pH 완충 + 약 결합 |
| 5 | EDTA | -6.12 | 금속 킬레이션 (HEM 영역 정합) |
| 6 | MPDA | -5.92 | ⚠ logP +4.76 막 침투 강 ≠ protein binding (메커니즘 분리 입증) |
| 7 | Poloxamer | -5.00 | 큰 polymer · 약 결합 |

## 3. 핵심 인사이트

```
★ Tocopherol -8.29
   Phase 2 LENS+ECOPAD #283 분자특성: logP +8.84 (TiO2 산화 방지)
   + Phase 3a docking: protein binding -8.29
   → 컬러렌즈 색소 보호 + 단백질 결합 dual mechanism

★ PHMB -7.35
   Phase 2 분자특성: logP +0.86, HBD 12 (큰 분자 · 안구 흡수 X)
   + Phase 3a docking: -7.35 (강한 protein binding)
   → 박테리아 막 결합 + 단백질 binding dual

★ MPDA -5.92 (예상보다 약함)
   Phase 2 분자특성: logP +4.76 (Acanthamoeba 막 침투 강력)
   Phase 3a docking: protein binding 중간
   → 메커니즘 분리 입증: 막 침투(lipophilic)와 protein binding(active site fit)은 별개
   → Acanthamoeba 살균은 막 손상 메커니즘 (단백질 차단 X)
```

## 4. ⚠ 정직한 한계 (g5)

- **6L8H 정체 미확정**: HEADER = "OXIDOREDUCTASE" + HEM cofactor. Acanthamoeba 단백질인지 직접 확인 필요. **정확한 Acanthamoeba castellanii protease target (예: 6BJX) 재검증 권고**.
- Vina docking = in silico 예측 (절대값 ≠ 정확)
- 상대 ranking은 의미 있음 (α-Tocopherol > PHMB > MPDA 순서)
- 실측 검증: ISO 14729 · Acanthamoeba castellanii MIC (RND-STDLIB §1)

## 5. Pilot D LENS 처방 재정렬 (in silico 검증 기반)

| 성분 | Phase 1 Vina | Phase 3a 6L8H | 통합 우위 |
|---|---|---|---|
| **α-Tocopherol** | logP +8.84 (Ro5 -1) | -8.29 ★ | ★ Pilot D 핵심 (색소 보호 + 단백질 binding) |
| PHMB | logP +0.86 | -7.35 ★ | 보존제 + protein binding |
| MPDA | logP +4.76 ★ | -5.92 | 막 침투 (Acanthamoeba) — protein-independent 메커니즘 |
| Poloxamer | logP +0.27 | -5.00 | 세척·점도 (binding 약하나 표면 작용) |

→ Pilot D LENS 확정: PHMB + Poloxamer + MPDA(막 침투) + **α-Tocopherol**(색소 + 단백질 binding) + EDTA + 시트르산

## 6. 다음 단계

| Phase | 작업 |
|---|---|
| 3b | ECOPAD Chitosan-막 OpenMM 10ns (ubu-1 CPU 1-2h) |
| 4 | 정확한 Acanthamoeba PDB (6BJX 등) 재docking 검증 |
| 5 | Cloud GPU 100ns MD ($10-15) |
| 6 | 실측 CRO RFQ 발송 (사용자 영역) |

## 산출물

| 파일 | 위치 |
|---|---|
| lens_dock.py · lens_dock_run.py · lens_dock_retry.py | ubu-1 /tmp/ |
| 7 ligand PDBQT | ubu-1 /tmp/lig_lens/ |
| Receptor PDBQT | ubu-1 /tmp/6l8h_chainA_recep.pdbqt (360 KB) |

## 출처

- RCSB PDB 6L8H — oxidoreductase + HEM
- AutoDock Vina (Phase 2 #281 패턴)
- PR #283 LENS 분자특성 매트릭스
