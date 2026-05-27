# 🪜 m-SIGN — 탈출 사다리 (TRAPPED↔ESCAPE 임계결합 분류)

> sister 세션(RTSC21 closed-form + RTSC24 mechanistic root 융합) 흡수 + 본 세션 formula 추출 + 5-anchor 수치검증.

@title: 🪜 m-SIGN — "탈출 사다리"
@goal: λ 1개로 RTSC 후보를 TRAPPED(낮은-Tc 우물) vs ESCAPE(고-Tc 잠재) 영역으로 분류 — sister 도출 anchor 값에서 formula 추출 + hexa-recompute verify.

## 1. 7-요소 도입

| 요소 | 내용 |
|---|---|
| 아이콘 | 🪜 |
| 이름 | `m-SIGN` |
| 별칭 | "탈출 사다리" |
| 하는 일 | 결합상수 λ 하나로 TRAPPED(우물 안) / ESCAPE(우물 위) 판별 |
| 비유 | 중력 우물 탈출 속도 — λ_crit=2.5가 탈출선, m>0면 우주로 |
| 비교 | Allen-Dynes Tc는 Tc 추정, m-SIGN은 후보를 사전 sort (Tc 계산 전에 후보 거름) |

ASCII:

```
ESCAPE  m>0  ↑     λ=3.0  m=+0.167  🟢 deep escape  (293K iso target)
                  CaH6   +0.074    🟢 measured 정합 213K
                  YH10   +0.035    🟢 marginal (303K predict)
─ 0 line ────────  λ_crit = 2.5
TRAPPED m<0  ↓     LaH10  −0.136    🔴 close-trap
                  H3S    −0.250    🔴 deep trap (203K 측정값은 ω_log로 살려냄)
```

## 2. closed-form

```
m(λ) := (λ − λ_crit) / λ = 1 − λ_crit / λ
λ_crit := 2.5         ← TRAPPED↔ESCAPE 임계결합
```

부호규칙: m<0 → TRAPPED · m=0 → marginal · m>0 → ESCAPE.

## 3. 도출 — 5 anchor fitting

| system | λ | m(cited) | m(λ−2.5)/λ | |Δ| |
|---|---|---|---|---|
| H3S | 2.0 | −0.250 | −0.25000 | 0.0e+0 |
| LaH10 | 2.2 | −0.136 | −0.13636 | 3.6e−4 |
| YH10 | 2.59 | +0.035 | +0.03475 | 2.5e−4 |
| CaH₆ | 2.7 | +0.074 | +0.07407 | 7.4e−5 |
| iso-target | 3.0 | +0.167 | +0.16667 | 3.3e−4 |

모든 |Δ| < 1e−3 — cited 값의 표시정밀도(소수 3자리)와 일치. **🔵 SUPPORTED-FORMAL** 등급.

## 4. verify (numerical recompute · 6자리)

```
m(2.00) = (2.00 − 2.5) / 2.00 = −0.500000 / 2.000000 = −0.250000
m(2.20) = −0.300000 / 2.200000 = −0.136364
m(2.59) = +0.090000 / 2.590000 = +0.034749
m(2.70) = +0.200000 / 2.700000 = +0.074074
m(3.00) = +0.500000 / 3.000000 = +0.166667
```

libm 정밀도(double)로 cited 값 ε≤1e−3 부합 — `hexa verify --expr` 등재 가능 (atlas fn 추가 시).

## 5. 본 캠페인 적용 (in-flight DFT를 m-axis에 매핑)

| job | λ (예상/현재) | m | class | 함의 |
|---|---|---|---|---|
| h3cl 8q (완료) | 1.21–1.37 | −1.06 ~ −0.83 | deep TRAPPED | 측정 140K은 ω_log~1350K로 boost한 결과 — m<0 영역에서도 Tc 유의미 가능 |
| h3cl interp ablation | 동상 | 동상 | 동상 | method 검증, m 변동 추정 ±0.05 |
| **ysbh6** (running, 4/N dyn) | per-mode 0.02–0.36, BZ ?2.0–2.5 | **−0.25 ~ 0** | TRAPPED↔marginal 경계 | 🎯 만일 λ_BZ>2.5 → 첫 비-Ca/Y ESCAPE 후보 |
| polymorph Mg₂IrH₆ | 미정 (stability 게이트 우선) | TBD | TBD | dynamical 통과시 평가 |
| **MgB₂ pilot** | ~0.7 (lit) | **−2.57** | deep TRAPPED 극단 | calibration anchor — m-axis 음의 끝 고정 |
| **Nb₃Al pilot** | ~0.6 (lit) | **−3.17** | even deeper | 더 깊은 trap, anchor 확장 |

**관찰**: λ<1 deep TRAPPED 영역(MgB₂/Nb₃Al)의 측정 Tc(39K/18K)가 m-sign과 일관(λ↓ ⇒ Tc↓). h3cl처럼 λ_crit 아래라도 ω_log로 Tc 끌어올림 가능 → m-SIGN은 **상한 추정 prior**이지 Tc 자체는 아님.

## 6. 한계 + 다음 단계

1. **λ_crit=2.5 정확값** — 5 anchor fitting으로 산출, 더 많은 anchor 필요시 흔들릴 수 있음. ysbh6 + polymorph 결과가 fit 보강 candidate.
2. **closed-form 단순성** — Tc는 (λ, ω_log, μ*) 3변수, m-SIGN은 λ만 — ESCAPE 영역(m>0)이라도 ω_log 낮으면 Tc 낮을 수 있음. m-sign = 1차 필터, 종합판정 아님.
3. **ω_log 의존성** — RTSC24 mechanistic root에서 ω_log가 m formula에 들어가지 않는지 sister 도출과정 추적 필요(현재 anchor만 흡수).

## 7. 출처

- **anchor 값**(5 system, m값 4자리): sister claude 세션 output (RTSC21 closed-form prediction + RTSC24 mechanistic root 융합 분류).
- **formula 추출**(m=(λ−2.5)/λ 도출 + 검증): 본 세션 — 5 anchor fitting.
- **integration**: 본 캠페인 5 in-flight DFT를 m-axis에 매핑(§5).
- **provenance gap closed**: `/gap` P1 (F4 honesty-triad · F7 active-acquisition · F8 unowned-load-bearing) 합산 — 이전 흡수는 citation 0건이었음.
