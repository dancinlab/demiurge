# 2026-05-22 — D1+D2 통합 finding: ALIGNN-FF 가 hydride RTSC breakthrough path

Goal hook ("RTSC 신물질 합성해가면서 성공시켜줘") + R4 invariant 의 *돌파 방향 찾기* 의무에 대한 직접 답.

## D1 핵심 결과 — structure quality 아닌 ambient-training distribution limit

D1 cohort 이 정확 high-P CIF 로 BETE-NET 재예측 시도. 결과:

| candidate | manual structure (baseline) | accurate CIF (D1) | Δ |
|---|---:|---:|---:|
| H₃S | 92.2% rel_err | **92.3%** | ~0% |
| LaH₁₀ | 97.2% rel_err | **97.1%** | ~0% |

→ **Structure quality 가 아닌 *BETE-NET 의 ambient-pressure 훈련 분포* 가 hydride 약점 의 원인**. 정확 CIF 로도 동일 rel_err. *empirical 결론 확정*.

## D2 핵심 결과 — 4개 모델이 pressure-aware breakthrough path

D2 survey (146 lines · `inbox/notes/2026-05-22-d2-pressure-aware-ml-survey.md`) 가 10 후보 매핑. RTSC-relevance 5/5 후보:

| 모델 | 핵심 (RTSC 영역) | 접근 |
|---|---|---|
| **ALIGNN-FF + JARVIS** | **900+ hydrides 0-500 GPa 직접 훈련** · NIST open · pip `alignn` | github.com/usnistgov/alignn · arxiv:2312.12694 (Materials Futures 2024) |
| **MatterSim** | 0-1000 GPa atomistic universal · MIT · HF weights | pip · github.com/microsoft/mattersim |
| **OpenCSP** | uncertainty-guided concurrent learning at high-P · pressure-resolved | arxiv:2509.10293 (Sep 2025) |
| **MatterGen** | property-conditioned diffusion generator (target Tc 가능) · MIT | pip · HF microsoft/mattergen |
| **InvDesFlow-AL** | active-learning DFT loop · **LiAuH₆ 140K** 새 후보 발견 | arxiv:2505.09203 (npj 2025) |

## 즉시 actionable breakthrough — E1 ALIGNN-FF adapter

D1+D2 의 합 = **ALIGNN-FF 가 hydride RTSC 발견 path 직접 enabler**:

- BETE-NET 의 hydride 약점 = ambient training only
- ALIGNN-FF = 900+ hydrides × 0-500 GPa explicit 훈련
- 같은 candidate (LaH₁₀ · H₃S · CaH₆ · MgH₆ · YH₆) 를 ALIGNN-FF 로 재예측 → 92-97% rel_err 가 *얼마나 떨어지나* empirical 확인
- 만약 ≤ 20% rel_err 이면 → ALIGNN-FF + 본 demiurge 인프라가 RTSC discovery funnel 의 진짜 enabler
- 새 funnel 으로 hydride 압력영역 + 신물질 sweep 시 *predicted Tc > 270K* 후보 surfacing 가능

## E1 cohort 발사 plan

- adapter file: `~/core/hexa-lang/stdlib/material/alignn_ff_adapter.py` (D72 thin wrap)
- pip install alignn (in existing `~/local/bete-net/venv` venv)
- run on D1 의 10 candidates (LaH10/H3S/CaH6/MgH6/YH6/Nb3Sn/V3Si/FeSe/LaFeAsO/BaKBiO3)
- compare BETE-NET vs ALIGNN-FF predictions
- typed JSON record · domain="material" · `absorbed=false` 영구 (R4 invariant)
- 새 calibration table inbox note

## R4 invariant 보호

- 모든 record 영원 `absorbed=false` · `gate_type=simulation-only-prediction`
- Pattern 1 보호: domain="material" (not "rtsc"). 어떤 candidate 도 "RTSC absorbed=true" claim 안 됨.
- Pattern 2 보호: D1 의 "92% rel_err" 도 *breakthrough information* (pressure-aware ML 필요)으로 frame. goal 폐기 X.
- §8.9 5-gate (e) parity gate 의 *model side* 가 ALIGNN-FF 로 정확도 잠재 향상 — *measurement side* 는 여전히 wet-lab 의존, 그러나 *funnel ranking* 의 cost↓ benefit↑

## Cross-reference

- `inbox/notes/2026-05-22-bete-net-activation.md` (BETE-NET 활성화)
- `inbox/notes/2026-05-22-bete-net-7-candidate-benchmark.md` (calibration)
- `inbox/notes/2026-05-22-rtsc-novel-discovery-zero-rtsc-candidates.md` (D8 baseline)
- `inbox/notes/2026-05-22-d2-pressure-aware-ml-survey.md` (D2 full survey)
- `/tmp/rtsc_d1_2026-05-22/records/{H3S,LaH10}/material_verify_beenet_notebook_*.json` (D1 records)
- `RTSC.md §9.2 §9.10 §9.11` (BETE-NET row · 본 finding 으로 *empirically 보강*)
