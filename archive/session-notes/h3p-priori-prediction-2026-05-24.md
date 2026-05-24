# H₃P a priori prediction (group-15 covalent vs group-16 sweet 결정타)

**날짜**: 2026-05-24
**DFT ETA**: ~05:38 KST (5/24, +3-4h from cycle 7-8 closure)
**상태**: PENDING · Vast pod 진행 중 (h3p · group 15 medium)
**역할**: group-15 vs group-16 가설 분리 — covalent-bonding-dominant vs light-X sweet-spot

---

## RTSC.log §9.15 precommit table (h3p 행)

| field            | value         |
| ---------------- | ------------- |
| group            | 15 (P)        |
| mass (u)         | 30.97         |
| celldm seed (a₀) | 6.5           |
| ω_log pred (K)   | 900–1100      |
| λ pred           | 1.3–1.8       |
| Tc(μ=0.10) pred  | **90–150 K**  |
| confidence       | MED           |
| verdict          | ⏳ PENDING    |

근거: H₃S(group 16) 200K · H₃Se 98-128K · H₃Te 72-76K · h3o 191K LANDED — group-16 sweet 가 light X 갈수록 mono ladder. group-15 는 단일 LANDED 없음 → h3p 가 group-15 첫 데이터 포인트.

---

## RTSC.md §9.14 ALIGNN per-cand baseline (cycle 7 family-wide)

| field                  | value              |
| ---------------------- | ------------------ |
| ALIGNN λ               | **0.585**          |
| ALIGNN ω_log (K)       | **77**             |
| ALIGNN Tc-direct (K)   | **2.17**           |
| sign-pathology         | 없음 (정상 mid-range)  |

비교 — group-15 family ALIGNN λ 분산: h3n **−0.18** (sign-path) · h3p **0.585** · h3as 0.13. h3p 는 group-15 에서 유일하게 λ ≥ 0.5 인 정상 mid-range 후보 → ML signal 살아있음 (group 16 sweet 와 동일 zone). DFT λ 는 d7 wall 정량 (DFT/ML ~2.9×) 적용 시 1.4-1.9 추정 — pred range 1.3-1.8 와 일치 방향.

---

## 검증 가설 표 (DFT 도착 후 즉시 settle)

| h3p Tc(μ=0.10) outcome   | 가설 verdict                                                                 |
| ------------------------ | ---------------------------------------------------------------------------- |
| ≥ 150 K (above pred)     | group-15 covalent-bonding-dominant 가설 강화 · group-16 sweet 우위 falsify   |
| 90–150 K (in pred)       | covalent vs sweet co-axis · h3n LANDED 까지 추가 결정 보류                   |
| 60–90 K (below pred)     | group-16 sweet 우위 강화 (h3o 191K > h3p ~80K) · light-X axis dominant       |
| < 60 K                   | group-15 INSUFFICIENT severe · ω_log under-conv 의심 (q-grid 6³ 확인 필요)   |

h3p ↔ h3o (group 16 light) 의 직접 비교 = **group 갈래의 첫 정량 분리**. h3n LANDED 추가 시 group-15 ladder (N → P → As) 완성.

---

## DFT 도착 시 1-line update path

`RTSC.log §9.15` 표 h3p 행: actual Tc · verdict · axis_violated 컬럼 채움 → §9.15.A Bayesian sub-section 에 group-15 ladder 첫 항목 박음 → 본 노트에 `[settled <verdict>]` marker 추가 후 archive.

R4: h3p prediction 은 simulation-only · `absorbed=false` · `gate_type=simulation-only-prediction` (d6 · d7).
