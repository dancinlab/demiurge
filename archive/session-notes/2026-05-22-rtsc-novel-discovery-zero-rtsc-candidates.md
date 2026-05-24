# 2026-05-22 — RTSC novel-discovery 실 funnel run — zero RTSC candidates predicted

Goal hook ("RTSC 신물질 합성해가면서 성공시켜줘") 에 대한 honest g3 답.
*funnel infrastructure 는 성공*, *RTSC discovery 는 zero* — R4 invariant empirical 강화.

## Run summary

- Pipeline: manual Atoms construction (ASE) → `beenet_notebook_inference_producer.py` (CSO 100-ensemble) → α²F → Allen-Dynes Tc → ranking → typed JSON record
- Wall: 3:21 (7 candidates · ~30s each)
- Host: macOS arm64 · Python 3.12 · venv at `~/local/bete-net/venv`
- Output record: `/tmp/rtsc_discovery_2026-05-22/discovery_summary.json`

## 7 candidates ranked by predicted Tc

| candidate | n_atoms | pred Tc (K) | measured (K) | rel_err | σ/λ | structure |
|---|---:|---:|---:|---:|---:|---|
| **MgB₂** | 3 | **32.5** | 39.0 | 16.6% | 1.67 | AlB₂ P6/mmm |
| Nb₃Ge | 8 | 16.4 | 23.0 | 28.8% | 1.12 | A15 Pm-3n |
| H₃S | 4 | 15.9 | 203.0 | 92.2% | 2.06 | Im-3m (high-P 가정) |
| CaH₆ | 7 | 7.1 | 215.0 | 96.7% | 1.54 | Im-3m sodalite |
| LaH₁₀ | 11 | 7.1 | 250.0 | 97.2% | 1.92 | Fm-3m clathrate (simplified) |
| NbTi | 2 | 4.8 | 9.5 | 49.8% | 1.18 | BCC alloy approx |
| NbN | 8 | 4.8 | 16.0 | 70.3% | 1.36 | B1 rocksalt |

**candidate_count_above_RTSC_threshold (270 K) = 0**

## Honest findings (R4 invariant empirical 강화)

### Finding 1 — BETE-NET 으로 RTSC 후보 발견 = **0**
- 7 후보 중 가장 높은 pred Tc = MgB₂ 32.5 K (RTSC threshold 270 K 의 **12%**)
- Hydrides (LaH₁₀, CaH₆, H₃S) — *실제* 측정값 200-250 K — predicted 7-16 K (92-97% rel_err)
- → ML SC predictor 의 *기본 한계*: ambient-pressure 훈련 데이터로 GPa-only candidate 못 잡음

### Finding 2 — Hydrides 가 가장 underpredicted
- Best multi-atom prediction error: MgB₂ 16.6% (model 신뢰권 안)
- Worst: LaH₁₀ 97.2% — model 이 "stable Tc 7K" 라고 *완전히 틀리게* 예측
- 원인:
  - BETE-NET 훈련: ambient-pressure SuperCon DB
  - Hydrides: 200-300 GPa 압력 하에서만 high-Tc 상태
  - 본 run 의 manual structures: 정확한 high-P 상태가 아닌 *simplified ambient-P 구조*
  - 압력 정보 없이 hydride 의 high-Tc 거동 예측 불가능 — 모델 한계, *실험은 그 한계를 벗어남*

### Finding 3 — σ/λ 가 OOD signal 이지만 RTSC 발견의 *직접* tool 아님
- 모든 후보 σ/λ > 1.0 — *all OOD by ensemble σ metric*
- 가장 신뢰권: Nb₃Ge σ/λ=1.12 (rel_err 28.8%) — *그래도* OOD
- σ/λ 가 *낮은 신뢰* 신호는 주지만, 실제 *높은 Tc 후보* 검출에 fail

### Finding 4 — R4 Pattern 2 회피 → empirically vindicated
- Goal 폐기 X — funnel 자체는 작동, 결과 honest 보고
- "현재 물리학 + 현재 ML 로 RTSC 못 잡음" 이 *정확한 honest 결과*
- §8.9 5-gate candidate matrix 의 row 들 (LK-99 · hexa-rtsc n=6 · CSH · hydrides) — 본 run 이 *empirical evidence* 추가
- 미래에 *압력-aware* graph NN 또는 *공정-aware* prediction 이 나오면 즉시 평가 가능 (gate OPEN 유지)

### Finding 5 — R4 Pattern 1 회피 무사
- 모든 record `absorbed=false` 하드코드 (R4 Stage 1 보호)
- gate_type=simulation-only-prediction · NOT "RTSC absorbed=true"
- 7 후보 어느 것도 "RTSC discovered" 라고 *주장* 안 됨
- 본 inbox 노트도 "discovered" 아닌 "predicted (≠ measured)" framing

## 실제 candidate funnel 가치

본 run 이 *RTSC 발견* 아닌 *wet-lab 우선순위 signal* 산출:

| 후보 신뢰권 (BETE-NET 영역 안) | 우선순위 의미 |
|---|---|
| MgB₂ (16.6% off) | *known industrial SC* — 본 funnel 검증용 reference, RTSC 후보 아님 |
| Nb₃Ge (28.8% off) | *known A15 SC* — 같은 의미 |
| Hydrides (92-97% off) | **wet-lab 우선순위 매우 높음** but *현 ML 로 정량 못 함* — 실험 자체가 더 가치 있음 |

→ 본 결과 자체가 *"신물질 합성 우선순위 list" 의 가치는 BETE-NET 만으로 부족* 임을 demonstrate.

## R4 invariant 와 5-gate 의 의미 — 강화

- (a) replicated synthesis ≥ 3 → wet-lab 의존, sim 으로 substitute 못 함
- **(b) Tc ≥ 270 K measurement** → BETE-NET prediction 32.5 K best · *전혀* 270 K 안 됨 → (b) gate empirically blocked
- (c) ambient pressure → hydrides 자동 FAIL (high-P only)
- (d) ≥ 3 independent labs → wet-lab
- (e) measurement-oracle parity → 본 BETE-NET 결과는 *model side*, *measured side* 비어 있음

→ **5/5 gate 어느 하나도 sim 으로 통과 안 됨**. R4 invariant 그대로.

## Cross-reference

- `/tmp/rtsc_discovery_run.py` (one-shot script — production producer 아님)
- `/tmp/rtsc_discovery_2026-05-22/discovery_summary.json` (final record)
- `~/core/hexa-lang/stdlib/material/beenet_notebook_inference_producer.py` (per-candidate producer)
- `inbox/notes/2026-05-22-bete-net-activation.md` (첫 활성화 milestone)
- `inbox/notes/2026-05-22-bete-net-7-candidate-benchmark.md` (LTS calibration · 본 run 의 RTSC-relevant 확장)
- `RTSC.md §8.9 5-gate · §9.10 N5 novel-discovery funnel`
- BETE-NET primary: arxiv:2401.16611 (Gibson et al. npj Comput. Mater. 2025)
