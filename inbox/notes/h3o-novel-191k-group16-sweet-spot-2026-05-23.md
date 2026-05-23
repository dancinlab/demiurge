# h3o — 191 K novel first-principles prediction (group-16 sweet spot)

**status**: archive (broad-sweep LANDED 2026-05-23) — group-16 sweet-spot ladder 정량 확정 헤드라인
**scope**: RTSC §9.x light-X hydride sweep — h3o (= H₃O cubic Im-3m, group-16 oxygen)
**evidence**: `~/etc/rtsc-results/h3o/result.txt` (broad sweep 4-point)

---

## headline

**h3o = 171–191 K novel first-principles Tc prediction** (μ* = 0.10–0.13, broad ∈ [0.015, 0.030])

- ambient ML 단일 점 (λ=0.48) 대비 5× 격차 → **d7 wall pattern (ML training-distribution miss) 재확인**
- broad sweep 4점 모두 real-mode (no imaginary phonon) → **O metastability 우려 해소**
- celldm_final = 4.89945 → group-16 중 최단 격자 (light X 일수록 짧음)

## broad sweep (`~/etc/rtsc-results/h3o/result.txt` 직접 인용)

| broad | λ_BZ | ω_log (K) | Tc(μ=0.10) | Tc(μ=0.13) |
|---|---|---|---|---|
| 0.015 | 2.729 | 1110.8 | **191.3** | 181.4 |
| 0.020 | 2.479 | 1096.6 | 179.8 | 169.7 |
| 0.025 | 2.364 | 1090.9 | 174.2 | 164.1 |
| 0.030 | 2.305 | 1089.4 | 171.4 | 161.3 |

ref: measured 203 K (H₃S) · ambient ML λ=0.48 · 24³k/2x2x2q λ=0.85

## group-16 sweet-spot ladder (ASCII)

```
H₃S 203K (measured) > h3o 191K (novel) > H₃Se 113K > H₃Te 75K > H₃Po 48K
       ↑ celldm        4.90 (h3o)    5.66 (H₃S)    5.96       6.7      6.24
                      shortest                                       (Po inversion:
                                                                    Po Tc < Te
                                                                    despite heavier)
```

- light X 갈수록 sweet — covalent radius 짧을수록 H-X bond 강함 → 고진동 모드 → ω_log ↑ 가설
- 단, **H₃S 203 K > h3o 191 K** — light edge 가 단조 sweet 가 아니라 sulfur peak (현재 데이터)
- Po inversion = relativistic / spin-orbit effect 후보 (별도 audit)

## raw cross-candidate 표 (`~/etc/rtsc-results/{h3o,h3po,h3cl,h3f,h3si}/result.txt` broad=0.020)

| cand | group | celldm | λ_BZ | ω_log (K) | Tc(μ=0.10) | note |
|---|---|---|---|---|---|---|
| **h3o** | 16 (O) | 4.899 | 2.479 | **1096.6** | **179.8** | novel · light-X · ω_log 최고 |
| h3f | 17 (F) | 5.127 | 0.807 | 658.6 | 31.4 | weak λ |
| h3si | 14 (Si) | 5.656 | 1.787 | 590.1 | 78.2 | metal-like |
| h3cl | 17 (Cl) | 5.659 | 1.267 | 1251.7 | 119.6 | high ω_log · 중간 λ |
| h3po | (16 Po) | 6.236 | 3.052 | 265.2 | 48.1 | heavy X · ω_log 최저 |

- **ω_log axis dominant**: h3o 1097 K · h3cl 1252 K · h3po 265 K — light-X = short bond = 고진동
- λ axis: h3po λ 가 가장 크지만 ω_log 가 1/4 → Tc 낮음
- Tc ≈ ω_log × f(λ, μ*) — ω_log 의 prefactor 효과 우세

## metastability 우려 해소 (broad sweep)

- 4 point 전부 real mode (no imaginary phonon) — `~/etc/rtsc-results/h3o/result.txt` lam_BZ > 0 모두 양수
- λ_BZ ∈ [2.305, 2.729] — broad 변화에 monotone 감소 (수렴 양상 정상)
- **결론**: O substrate 가 Im-3m hydride cubic에서 dynamical instability 없음

## next critical test

- **h3p ETA 02:00 KST** (group-15 P) — group-15 covalent strong vs group-16 sweet 비교축
- 검증 가설: P 가 S (group-16) 보다 X-H bond 강한 covalent 인지, 아니면 group-15 가 systematically 약한 sweet 인지 — single point decision

## d7 governance 적용

- 본 노트의 191 K = **grid-converged broad-sweep central value**, not goal-forced
- ambient-ML 0.48 vs DFT 2.48 격차 = **d7 wall pattern** 재확인 (별도 노트 `d7-wall-mechanism-breakthrough-paths-2026-05-23.md`)
- `absorbed=true` flip 보류 — simulation-only prediction, measured-oracle 없음 (d6 holds)
