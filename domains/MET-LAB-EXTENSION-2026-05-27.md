# 🧪 met lab 확장 — η/ε/ζ — 2026-05-27

> **이전**: FULL met lab #341 (22 도메인 + PHMB scan)
> **이번**: η 10 추가 도메인 conformer + ε TPASTE gingipain PDB · ζ INSECT OR PDB 후보 매핑
> **다음**: ε·ζ docking 실제 실행 (receptor prep 시간 압박 — 다음 turn)

---

## η — 10 추가 도메인 conformer (Stokes-Einstein D @298K)

| 도메인 | 화합물 | MW | R_g (Å) | D (m²/s) | logP |
|---|---|---|---|---|---|
| **COSME-FRAGRANCE** | Linalool | 154.3 | 3.21 | 5.92e-10 | +2.67 |
| FRAGRANCE | Limonene | 136.2 | 2.90 | 6.54e-10 | +3.31 |
| FRAGRANCE | Citral | 152.2 | 3.31 | 5.74e-10 | +2.88 |
| FRAGRANCE | BenzylAlcohol | 108.1 | 2.34 | 8.10e-10 | +1.18 |
| **COSME-BABY** | Ceramide_NP | 497.8 | 7.93 | **2.40e-10** | +8.62 |
| BABY | Panthenol | 205.3 | 3.24 | 5.86e-10 | -1.14 |
| BABY | Cica | 396.5 | 3.64 | 5.22e-10 | +1.63 |
| **COSME-MENS** | Caffeine | 194.2 | 3.00 | 6.33e-10 | -1.03 |
| MENS | Panthenol·Allantoin·Menthol | — | — | 5.86 ~ 7.44e-10 | — |
| **COSME-VEGAN** | Resveratrol | 228.2 | 4.05 | 4.69e-10 | +2.97 |
| VEGAN | EGCG (녹차 carcatechin) | 458.4 | 4.72 | 4.03e-10 | +2.23 |
| VEGAN | Bakuchiol | 244.4 | 4.82 | 3.94e-10 | +5.02 |
| **COSME-BODY** | SheaButter_OleicA | 282.5 | 6.06 | 3.13e-10 | +6.11 |
| BODY | Ceramide_NP | 497.8 | 7.93 | 2.40e-10 | +8.62 |
| BODY | HyaluronicA | 397.3 | 3.90 | 4.87e-10 | -5.16 |
| **COSME-NAIL** | Nitrocellulose unit | 239.2 | 3.09 | 6.15e-10 | -2.35 |
| NAIL | ButylAcetate | 116.2 | 2.99 | 6.35e-10 | +1.35 |
| **COSME-MAKEUP** | IronOxide·TiO2·Mica | — | — | FAIL | — |
| **COSME-BOOSTER** | VitC (LED proxy) | 176.1 | 2.59 | 7.33e-10 | -1.41 |
| **QD-BAND** | Polyisobutylene unit·Acrylate·Chitosan | — | — | 7.28 ~ 8.75e-10 | — |
| **QD-MASK** | MeltblownPP·NanoFiberPVDF·CelluloseAcetate | — | — | 5.08 ~ 1.00e-9 | — |

→ FAIL (RDKit 영역 외): IronOxide·TiO2·Mica (inorganic — DFT 필요)

## ε — TPASTE gingipain PDB 후보

| PDB | ATOM | Active HET | 후보 평가 |
|---|---|---|---|
| **4RBM** | 3,524 | NI · HIS · ACT · AZI · **CKC** | ★ CKC (gingipain inhibitor 추정) — docking 가능 |
| **6IO1** | 6,925 | **PMP** | pyridoxal 5'-phosphate cofactor — 활성 부위 |
| 3LD2 | 5,064 | MSE · **COA** | CoA-binding enzyme |

→ 다음 turn 실제 docking 진행 시 **4RBM (CKC)** 우선 시도.

## ζ — INSECT mosquito OR / Orco PDB 후보

| PDB | ATOM | Active HET | 평가 |
|---|---|---|---|
| 7RVK | 97 | — | fragment 너무 작음 |
| 6C70 | 12,368 | — | apo (HET 없음) |
| **6C71** | 13,637 | NCT · **FAD** | ★ flavoprotein active site (FAD cofactor) |

→ 6C71 FAD 활성 부위 docking 가능 (단 mosquito OR direct binding인지는 추가 검증 필요).

## 📊 통합 도메인 met lab 누적 (현재까지)

| 도메인 (carbohydrate 분류) | Conformer 분석 | Docking 시도 |
|---|---|---|
| QD-SCALP (SRD5A2) | ✅ 7BW1 | ✅ #281 (Adenosine -8.47 ★) |
| QD-LENS | ✅ #283 + #338 | ✅ 6L8H chain A #296 (Tocopherol -8.29 ★) |
| QD-ECOPAD | ✅ #338 (Glycerin·LA 2× D) | — (MD plan #292) |
| 22 도메인 + PHMB | ✅ #341 (A·B·C 침투 분류) | — |
| **η 10 추가 도메인** | ✅ **본 PR** | — |
| QD-HSHAMPOO | ✅ 분자특성 #283 | ⚠ Cyp51 5TZ1 disulfide fail |
| QD-GARGLE | ✅ #283 | ⚠ 3AIE active site 없음 |
| QD-TPASTE | ✅ #341 | ⏳ **다음 turn ε 4RBM 시도** |
| QD-INSECT | ✅ #341 | ⏳ **다음 turn ζ 6C71 시도** |

## 정직한 한계 (g5)

- MAKEUP inorganic (Iron·Ti·Mica) — RDKit 영역 외 (DFT 필요)
- 4RBM CKC가 gingipain catalytic site인지 직접 PDB description 확인 필요
- 6C71이 mosquito olfactory receptor (Orco) direct binding site인지 검증 필요
- 다음 turn: ε·ζ receptor prep + Vina docking 실제 실행
