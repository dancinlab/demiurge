# 🌩️ Phase 3D — Cloud GPU MD plan (Vast.ai / RunPod) — 2026-05-27

> **이전**: Phase 3a LENS docking #296 · Phase 3b B 환경 부족 (openff-toolkit pip fail)
> **이번**: Cloud GPU pod 본격 100ns MD plan — 실제 $10-15 rent 전 사용자 confirm 필요

---

## 1. ⚠ 실제 $$$ 외부 발생 작업 — 사용자 confirm 필수

| 비용 | 시간 | 위험 |
|---|---|---|
| Vast.ai V100 × $0.30-0.50/h | 12-24h | rent=real $ · no dry-run |
| 총 예상: $5-15 | | OOM 시 비용 낭비 |

---

## 2. GPU 제공자 비교

| Provider | V100 | 환경 | 비고 |
|---|---|---|---|
| **Vast.ai** | $0.30-0.50/h | vastai CLI | 가장 저렴 |
| RunPod | $0.79-1.20/h | GROMACS 이미지 | 안정·약간 비쌈 |

---

## 3. 시뮬 후보

### LENS — PHMB-각막막 MD

| 항목 | 값 |
|---|---|
| 시스템 | POPC 50 + PHMB n=4 + 5000 water + 0.15M NaCl |
| 시뮬 | 100 ns NPT @ 310K |
| FF | CHARMM36 + CGenFF (PHMB) |
| 시간 | V100 6-12h · $4-6 |

### ECOPAD — 셀룰로오스 SAP swelling MD

| 항목 | 값 |
|---|---|
| 시스템 | Cellobiose n=10 + 2000 water + Glycerin 50 + Lactic 20 |
| 시뮬 | 50 ns NPT @ 298K |
| FF | GROMOS 56A6_CARBO |
| 시간 | V100 3-6h · $2-3 |

---

## 4. 실행 8-step

```
1. Vast.ai vastai CLI + API key 검증
2. V100 search + rent (gromacs/gromacs:2024.1-cuda)
3. ssh + GROMACS preflight
4. input upload (CHARMM-GUI · packmol)
5. mdrun background (nohup)
6. poll 6-12h
7. copy-back + destroy instance
8. 분석 (gmx rms·density·hbond, ubu-1 CPU)
```

---

## 5. 사전 준비물 (사용자 영역)

- [ ] Vast.ai API key (`secret get vast.api_key`)
- [ ] CHARMM-GUI input (PHMB-POPC) — 또는 packmol
- [ ] GROMOS carbo input (cellobiose) — packmol

---

## 6. 비용·시간

| 시나리오 | 비용 | 시간 |
|---|---|---|
| LENS만 | $4-6 | 12h |
| ECOPAD만 | $2-3 | 8h |
| 둘 다 순차 1 instance | $6-9 | 18-22h |
| Setup 실패 재시도 | +$2-3 | +4h |

---

## 7. ⚠ 한계 (g5)

- CHARMM-GUI = 웹 브라우저 사용자 작업
- PHMB CGenFF parameter 직접 생성 필요
- 100ns = 가설 검증 수준 (논문급 마이크로초 X)
- 실측 검증은 in vitro/in vivo CRO

---

## 8. 결정 옵션

| 옵션 | 작업 |
|---|---|
| D1 | Vast.ai LENS 100ns 진행 (사용자 confirm) |
| D2 | RunPod 양쪽 시뮬 |
| **★ D3** | **input 준비 후 진행** (CHARMM-GUI/packmol input 우선) |
| D4 | 더 단순 in silico 대체 (RDKit conformer 등) |
| E | 실측 CRO RFQ 우선 |

권고: D3 — input 준비가 ROI bottleneck.

## 출처

- AutoDock Vina · GROMACS 2024.1 · CHARMM36 · GROMOS 56A6_CARBO
- memory: feedback_vast_elph_safe_launch · reference_hexa_cloud_provisioning
