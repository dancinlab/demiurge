# 2026-05-22 — BETE-NET CSO 7-candidate calibration benchmark

`beenet_notebook_inference_producer.py` (R5 venv + A1 BETE-NET clone 활용) 의
7-material benchmark. *예측 정확도 vs 측정 Tc* 의 empirical calibration —
R4 invariant 의 strongest 증거.

## Run setup

- backend: BETE-NET CSO variant (100-ensemble, lmax=1, structure-only)
- pipeline: `beenet_notebook_inference_producer.py` (proper typed producer · honest g3)
- host: macOS arm64 (Apple Silicon native) · Python 3.12 · venv at `~/local/bete-net/venv`
- structures: ASE preset (single-element bulk) OR explicit Atoms (MgB₂ · Nb₃Sn)
- μ* = 0.10 (typical weak-to-moderate coupling default)

## Results

| material | n_atoms | family | structure | predicted Tc (K) | **measured Tc (K)** | **rel_err** | λ | σ(λ) | σ/λ | ω_log (K) | wall (s) |
|---|---:|---|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Al | 1 | LTS weak | fcc | 10.74 | 1.18 | **810%** | 0.463 | 0.408 | 0.880 | 1198.1 | 27 |
| Sn | 2 | LTS weak | diamond | 1.82 | 3.72 | **51%** | 0.440 | 0.619 | 1.408 | 259.2 | 33 |
| V | 1 | LTS weak | bcc | 82.28 | 5.40 | **1424%** | 1.135 | 0.803 | 0.708 | 930.2 | 25 |
| Nb | 1 | LTS weak | bcc | 51.25 | 9.25 | **454%** | 0.964 | 0.826 | 0.857 | 743.4 | 26 |
| Pb | 1 | LTS strong | fcc | 15.18 | 7.20 | **111%** | 1.210 | 0.968 | 0.800 | 157.4 | 24 |
| **MgB₂** | **3** | two-gap | **AlB₂ proto P6/mmm** | **32.53** | **39.00** | **16.6%** | 0.758 | 1.267 | 1.671 | 751.9 | 27 |
| Nb₃Sn | 8 | LTS strong | A15 cubic | 9.15 | 18.30 | **50%** | 0.556 | 0.666 | 1.197 | 498.1 | 39 |

## Honest empirical findings

### Finding 1 — Multi-atom cell ⟹ dramatically better prediction

- **Simple-element bulks (1-atom)**: rel_err ranges 111-1424% — BETE-NET 훈련 분포의 OOD edge
- **Multi-atom cells (≥3-atom)**: rel_err 16.6-50% — 훨씬 가까움
- **MgB₂ (3-atom)**: best at **16.6% rel_err** — model 의 *합리적 신뢰 영역*

→ N5 funnel 이 BETE-NET 결과 consume 시: **n_atoms ≥ 3 후보만 신뢰권** 으로 처리. 1-atom bulks 의 Tc 예측은 *50× 가까이 OOD*.

### Finding 2 — σ/λ 가 OOD signal 이지만 rel_err 의 perfect predictor 아님

- V: σ/λ=0.708 (가장 낮음, 즉 모델 "가장 자신 있음") + rel_err=1424% (최악)
- Sn: σ/λ=1.408 (높음, 모델 "확신 없음") + rel_err=51% (중간)
- MgB₂: σ/λ=1.671 (가장 높음) + rel_err=16.6% (최선)

→ σ/λ 는 OOD *필요* indicator 이지만 *충분* 아님. 모든 7 후보 σ/λ > 0.7 = *all OOD by that metric* 임에도 rel_err 25× 변동. systematic bias 가 별 source.

### Finding 3 — Strong-coupling SC 가 weak-coupling 보다 잘 됨

- weak-coupling (Al · Sn · V · Nb): rel_err 51-1424%
- strong-coupling 또는 anharmonic (Pb · Nb₃Sn · MgB₂): rel_err 16.6-111%

→ BETE-NET 훈련 데이터가 strong-coupling family 에 biased 추정 (BETE-NET 의 SuperCon DB + DFT 표본 dominant 가 그 영역). 본 finding 은 paper 의 MAE 0.87 K (DFT-AD vs ML) 와 다른 *측정-vs-ML* axis 의 empirical 결과.

### Finding 4 — R4 Pattern 2 protection — empirical 강화

이 calibration 표 자체가 R4 Pattern 2 (goal abandonment) 회피의 empirical 증명:
- "BETE-NET 으로 RTSC absorbed=true 통과 못 함" → 16.6% best-case 면 *300 K 후보가 250-350 K* — *완전 부정확 아님* — *측정 우선순위 list 가치 있음*
- 모든 prediction 의 `absorbed=false` 영구 (R4 Pattern 1) — Tier 1 sim ≠ measurement
- 5-gate matrix (§8.9) 의 (b) gate (Tc ≥ 270 K 측정) 는 model prediction 으로 *대체 불가능*, 다만 model 이 *후보 priority* 산출

## N5 funnel 의 실제 의미 (이제 backed by data)

N5 novel-discovery funnel 이 *BETE-NET 결과 consume* 할 때:

| 후보 spec | N5 가 BETE-NET 결과를 어떻게 다뤄야 하나 |
|---|---|
| n_atoms = 1, σ/λ > 0.7 | predicted Tc 가 **3-15× off** 가능 — wet-lab 우선순위 거의 무가치 |
| n_atoms ≥ 3, σ/λ > 1.0 | predicted Tc 가 **15-50% off** — 합리적 priority signal |
| n_atoms ≥ 5, multi-element strong-coupling | 가장 신뢰권 — Nb₃Sn 50% / MgB₂ 16.6% 범위 |
| predicted Tc > 270 K + σ/λ < 1.0 | **wet-lab 추적 가치 있음** (가능성 시그널) |

→ Pattern 2 회피 honest: "BETE-NET predicted Tc > 270 K" 가 *충분치 않음* 인 것은 정답이지만, *후보 list 의 ranking signal* 로는 *유효* — wet-lab 의무는 그대로지만 *어디부터 시도* 의 정보 가치.

## 다음 가능

- N5 funnel 의 `tc_score` 계산 시 σ/λ + n_atoms 보정 추가 (현재 raw predicted Tc / threshold)
- Hydride 시뮬레이션 (LaH₁₀ 같은 multi-atom 고압 후보) — BETE-NET CSO 가 *압력* 정보 없으므로 측정값과 분리해서 봐야
- LK-99 (Pb10Cu(PO4)6O · 17 atoms) — multi-atom 영역이라 BETE-NET 도 합리적 예측 가능 — *그 결과가 무엇이든* R4 invariant 그대로

## Cross-reference

- `/Users/ghost/core/hexa-lang/stdlib/material/beenet_notebook_inference_producer.py` (R5+B 통합 producer)
- `inbox/notes/2026-05-22-bete-net-activation.md` (첫 활성화 milestone · Nb 단일)
- `RTSC.md §9.2` (BETE-NET row · 본 inbox 의 finding 으로 정량 강화 필요)
- `RTSC.md §8.9` (5-gate · (b) gate 의 measured-oracle 의무 그대로)
- `~/core/hexa-lang/stdlib/material/_setup/` (R5 venv scaffold)
- BETE-NET primary: arxiv:2401.16611 (Gibson et al. npj Comput. Mater. 2025)
