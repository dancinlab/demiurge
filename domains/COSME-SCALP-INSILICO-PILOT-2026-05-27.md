# 🧪 COSME-SCALP — in silico pilot (RDKit + Meeko + AutoDock Vina) — 2026-05-27

> **외부 라이브러리 포팅 1단계** — pool ubu-1에 RDKit·Vina·Meeko·gemmi venv 셋업 + 9 ligand 분자 특성 + PDBQT prep
> **다음**: 7BW1 (SRD5A2) receptor PDBQT prep + Vina docking (binding affinity)

---

## 1. 환경 셋업 (pool ubu-1)

```
host:       ubu-1 (Ubuntu 24.04, python 3.12.3)
venv:       ~/.venv-cosmedrug
packages:   rdkit · vina · meeko · gemmi · scipy · numpy
PDB:        7BW1.pdb (SRD5A2 Steroid 5α-reductase 2, 4528 lines) → /tmp/7bw1.pdb
ligand out: /tmp/lig/*.pdbqt (9 + 1 reference)
```

## 2. 9 Ligand 분자 특성 (RDKit Descriptors)

| 화합물 | MW | logP | HBD | HBA | TPSA | RotB | Ro5 | 평가 |
|---|---|---|---|---|---|---|---|---|
| 🎯 Finasteride (ref) | 388.6 | +2.93 | 3 | 3 | 78.4 | 1 | 4 | 5αR-II 표준 inhibitor |
| Dutasteride | 512.5 | +6.11 | 2 | 2 | 58.2 | 2 | **2** | ⚠ Ro5 위반 |
| L-Menthol | 156.3 | +2.44 | 1 | 1 | 20.2 | 1 | 4 | ★ 모낭 침투 최강 |
| Salicylic acid | 138.1 | +1.09 | 2 | 2 | 57.5 | 1 | 4 | 각질용해 |
| Caffeine | 194.2 | -1.03 | 0 | 3 | 61.8 | 0 | 4 | 5αR 보조 (logP↓) |
| Niacinamide | 122.1 | +0.18 | 1 | 2 | 56.0 | 1 | 4 | 항염 |
| Biotin | 244.3 | +0.80 | 3 | 3 | 78.4 | 5 | 4 | 모낭 케라틴 |
| Dexpanthenol | 205.3 | -1.14 | 4 | 4 | 89.8 | 6 | 4 | 두피 보습 |
| Adenosine | 267.2 | -1.98 | 4 | 8 | 139.5 | 2 | 4 | 기능성 polar |
| **Procapil** (acetyl) | 301.3 | -1.26 | 6 | 4 | 157.4 | **10** | 3 | ⚠ 침투 어려움 |

Ro5: Lipinski rule-of-five (4=excellent·3=moderate·≤2=poor)

## 3. 침투력 그룹 분류 (logP 기반)

| 그룹 | 화합물 | 처방 전략 |
|---|---|---|
| **Lipophilic (logP>+2)** | L-Menthol(+2.44)·Finasteride(+2.93) | 모낭 침투 우수 — 별도 전달체계 불필요 |
| **균형 (0<logP<+1.5)** | Salicylic acid·Niacinamide·Biotin | 일반 처방 OK |
| **Polar (logP<0)** | Caffeine·Dexpanthenol·Adenosine·Procapil | **80nm 나노에멀젼 필수** (Agent 2 결과 정합) |
| **❌ Ro5 위반** | Dutasteride | 의약품 영역 (화장품 X) |

## 4. R&D 처방 결정 인사이트

```
Pilot D (research 정합 + in silico 검증)
   ① 6대 자동허가 정량 (의무)
   ② Menthol·Salicylic acid·Niacinamide — 일반 처방 (logP 정렬)
   ③ Caffeine·Dexpanthenol — 80nm 나노에멀젼 캡슐화 ★
   ④ Procapil (펩타이드) — 트랜스퍼좀·에토좀 전달체계 필수 ★
   ⑤ Adenosine — 기능성 인증 성분 + 캡슐화
```

→ **나노에멀젼 캡슐화 우선 대상**: Caffeine · Procapil · Adenosine (logP < 0 그룹)
→ **일반 처방 OK**: Menthol · Salicylic acid · Niacinamide · Biotin

## 5. 다음 단계 (Phase 2 — receptor docking)

| Step | 도구 | 산출 |
|---|---|---|
| Receptor prep | meeko mk_prepare_receptor (7BW1.pdb → 7bw1.pdbqt) | PDBQT receptor |
| Box 정의 | NADPH/finasteride binding pocket 좌표 | grid box |
| Vina docking | AutoDock Vina (exhaustiveness=8) | binding affinity kcal/mol |
| 분석 | 9 ligand × binding affinity ranking | 5αR 결합력 정량 |

### 예상 docking ranking 가설 (literature 기반)

```
Finasteride (-9 ~ -10 kcal/mol) ← 표준 inhibitor
Dutasteride (-10 ~ -11)         ← Type I+II dual (강력)
Caffeine    (-4 ~ -6)            ← weak 보조 (literature 일부 5αR 차단 보고)
Procapil    (-7 ~ -9)            ← peptide mimic, 5αR 차단 메커니즘 보고
나머지      (-3 ~ -5)            ← weak/non-specific
```

## 6. Pilot 산출물

| 파일 | 위치 (ubu-1) | 크기 |
|---|---|---|
| dock_pilot.py | /tmp/dock_pilot.py | ~50 lines |
| 7BW1.pdb | /tmp/7bw1.pdb | 4528 lines |
| 9 ligand PDBQT | /tmp/lig/*.pdbqt | 1199-3572 bytes 각 |

## 출처

- [RCSB PDB 7BW1 — SRD5A2 cryo-EM (Han 2021)](https://www.rcsb.org/structure/7BW1)
- [RDKit](https://www.rdkit.org/)
- [AutoDock Vina](https://vina.scripps.edu/)
- [Meeko (Vina prep)](https://github.com/forlilab/Meeko)
- [Lipinski rule-of-five (Lipinski 2001)](https://doi.org/10.1016/S0169-409X(00)00129-0)
