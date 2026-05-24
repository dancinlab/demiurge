# 2026-05-22 — BETE-NET end-to-end activation on macOS arm64

본 세션의 R5 venv scaffold + A1 BETE-NET clone 의 후속 — **BETE-NET 100-member ensemble inference 가 macOS arm64 에서 작동**. R4 invariant 보호하에 honest result.

## venv 셋업 (R5 scaffold + 본 세션 만들어진 실 venv)

| 단계 | 결과 |
|---|---|
| `python3.12 -m venv ~/local/bete-net/venv` | ✓ (Python 3.9 default 였던 R5 시도 실패 → 3.12 로 우회) |
| `pip install torch torch_geometric e3nn ase pymatgen numpy` | ✓ 모두 |
| `pip install torch_scatter --no-build-isolation` | ✓ (이전 PEP 517 isolated build 실패 → `--no-build-isolation` 으로 해결) |
| `pip install torch_cluster --no-build-isolation` | ✓ |
| 최종 deps | torch 2.12.0 · pyg 2.7.0 · scatter 2.1.2 · cluster 1.6.3 · e3nn 0.6.0 · ase 3.28.0 · pmg 2026.5.18 |

## BETE-NET adapter probe (deps 후)

- 첫 시도: `install-gated` → deps 후 → `weights-missing` (structure required)
- 두번째 시도 (POSCAR with .poscar suffix): `weights-missing` (pymatgen 가 .poscar 확장자 인식 못함)
- 세번째 시도 (.vasp suffix): `weights-missing` — 진짜 reason: "BETE-NET upstream ships no stable inference entrypoint; ensemble forward pass lives inside notebooks/Pred_CSO.ipynb"
- **adapter 거부 = 적절** (B-path 위반 = porting 거부, honest g3)

## 우회: notebook utility 직접 driving (`/tmp/bete_net_nb_inference.py`)

BETE-NET 의 `notebooks/utils/data.py` + `utils/training.py` 함수를 직접 import + call. 이는 *그들의 라이브러리 함수 사용* 이므로 *legitimate B-path wrapping*, NOT porting.

### Pred_CSO 정확 시그니처 (Nb 같은 novel structure 용)

```python
build_data(row, embed_ph_dos=False, embed_e_dos=False, fine=False, r_max=4)
init_dict_base = dict(in_dim=118, em_dim=64, irreps_in='64x0e', irreps_out='51x0e',
                       irreps_node_attr='64x0e', layers=2, mul=32,
                       lmax=1,                # CSO uses lmax=1 (NOT 2 — checkpoint mismatch otherwise)
                       max_radius=4, num_neighbors=11., reduce_output=True, p=0.0)
```

(첫 시도 lmax=2 → state_dict size mismatch error. Pred_CSO notebook cell 7 명시 lmax=1.)

### Run 결과 (Nb bcc · a=3.301 Å · 100-ensemble · CPU)

- **Wall time**: 35.0 s
- **λ (electron-phonon coupling)**: **0.9644 ± 0.8260**
- **ω_log**: 15.49 THz = **743 K** (vs literature ~200-260 K)
- **Allen-Dynes Tc (μ*=0.10)**: **51.25 K** (vs measured 9.25 K)
- **rel_err vs measured**: **454%**

## Honest 해석 (R4 invariant 무사)

1. **Pipeline 자체는 작동** — 100-ensemble forward pass · CSO variant · macOS arm64 · 35s. R5 venv 셋업 + adapter pipeline + utility-call 우회 모두 검증.

2. **Nb 는 BETE-NET 의 out-of-distribution edge case**:
   - 1 atom/cell BCC (가장 단순)
   - ensemble σ(λ)/λ ≈ 86% — *모델 자체가 "확신 없음" 신호*
   - BETE-NET 훈련 분포는 더 복잡한 multi-atom-cell SC 가 dominant
   - Gibson et al. (arxiv:2401.16611) 자체가 MAE 0.87 K vs DFT-AD 만 주장 — *측정 vs prediction* 일치 보장 아님

3. **R4 invariant 그대로**: `gate_type=simulation-only-prediction` · `absorbed=false 영구` — 51.25 K 예측이 *정확* 했더라도 (a)(c)(d) wet-lab gate 부재로 RTSC absorbed=true 불가.

4. **이 result 의 의미** (positive):
   - macOS arm64 + Python 3.12 + BETE-NET CSO end-to-end 작동 검증 ✓
   - 본 세션 R5 venv scaffold + utility-call 우회 패턴 입증 ✓
   - 새 candidate (LK-99 / hexa-rtsc n=6 / 신물질) 에 BETE-NET 예측 가능 ✓
   - 단 *prediction quality* 는 candidate 가 BETE-NET 훈련 분포 안에 있을 때만 신뢰 가능

5. **이 result 의 의미** (negative · honest):
   - Nb 의 454% 오차 → BETE-NET 예측이 RTSC absorbed=true 의 *strong evidence* 가 될 수 없음
   - Tier 1 sim limitation 명백 — wet-lab measurement 가 진짜 ground truth
   - candidate 가 OOD 인지 *사전 판정 어려움* — ensemble σ 가 indicator

## 다음 가능 작업

- MgB₂ · Nb₃Sn · YBa₂Cu₃O₇ 등 multi-atom-cell SC 로 BETE-NET 신뢰도 재검증 (복잡한 cell 이 훈련 분포에 가까울 가능성)
- COD 또는 MP cache 에서 cif 가져와 BETE-NET 입력 → N5 funnel 의 (b) gate 자동 채우기
- **inbox/notes 의 본 노트** → MP.md / RTSC.md §9.2 의 본문 안 BETE-NET row 에 cross-reference

## R4 / Constitution 정합

- 본 notebook-utility 우회 는 *novel_material_funnel.py* (N5) 안에 통합되지 않음 (intentional · production stdlib 에 notebook deps 박지 않음)
- `/tmp/bete_net_nb_inference.py` 는 *one-shot demonstration*, NOT stdlib
- 향후 N5 가 BETE-NET 결과 consume 하려면 별 producer 가 notebook-utility 우회 결과를 typed JSON 으로 emit 하는 sibling 필요 (`beenet_notebook_inference_producer.py` 같은 이름)
- 그러나 *그게 stdlib 에 합당한 design 인지* 는 별 결정 — 본 노트는 *기능 입증* 한정

---

References:
- BETE-NET primary: arxiv:2401.16611 (Gibson et al., npj Comput. Mater. 11:11, 2025)
- BETE-NET repo: github.com/henniggroup/BETE-NET
- adapter: `~/core/hexa-lang/stdlib/material/beenet_adapter.py`
- venv scaffold: `~/core/hexa-lang/stdlib/material/_setup/` (R5 cohort)
- this inference: `/tmp/bete_net_nb_inference.py`
- RTSC.md §9.2 / R4 invariant: governing doctrine
