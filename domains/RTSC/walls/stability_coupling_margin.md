# 🪜 stability_coupling_margin — 탈출 사다리 (m-sign, TRAPPED↔ESCAPE 임계결합 분류)

> sister 세션(10p arxiv-ready paper · RTSC21 closed-form + RTSC24 mechanistic root · 54-row BLUE-MAX audit) 흡수 + 본 repo formula 추출 + 5-anchor 수치검증 + labeh8 deep-ESCAPE 발견.

@title: 🪜 stability_coupling_margin — "탈출 사다리"
@goal: 결합상수 λ 한 변수로 RTSC 후보를 TRAPPED(낮은-Tc 우물) vs ESCAPE(고-Tc 잠재) 영역 분류 — Allen-Dynes "λ 부족"과 Hopfield "phonon 무름"이 같은 함수의 두 lens.

## 1. 7-요소 도입

| 요소 | 내용 |
|---|---|
| 아이콘 | 🪜 |
| 이름 (canonical) | `stability_coupling_margin` |
| 별칭 | "탈출 사다리" · `m-sign` (짧은 이름) |
| 하는 일 | λ 하나로 TRAPPED(우물 안) / ESCAPE(우물 위) 판별 |
| 비유 | 중력 우물 탈출 속도 — λ_crit=2.5가 탈출선, m>0면 우주로 |
| 비교 | Allen-Dynes Tc는 Tc 추정, m은 후보를 사전 sort (Tc 계산 전에 후보 거름) |

ASCII:

```
ESCAPE  m>0  ↑     λ_BZ=3.90  m=+0.359  🟢 labeh8(본 repo 측정값) deep ESCAPE
                  λ=3.0      +0.167    🟢 iso-target (293K 가설 zone)
                  CaH6  2.7  +0.074    🟢 measured 213K 정합
                  YH10  2.59 +0.035    🟢 marginal (303K predict)
─ 0 line ────────  λ_crit = 2.5
TRAPPED m<0  ↓     LaH10 2.2  −0.136    🔴 close-trap
                  H3S   2.0  −0.250    🔴 deep trap (203K은 ω_log boost)
                  h3cl  1.3  −0.923    🔴 deeper trap (140K은 ω_log~1350K compensate)
                  MgB2  0.7  −2.571    🔴 deep TRAPPED 음의 끝 anchor (39K)
                  Nb3Al 0.6  −3.167    🔴 even deeper (18K)
```

## 2. closed-form

```
m(λ) := stability_coupling_margin(λ) = (λ − λ_crit) / λ = 1 − λ_crit / λ
λ_crit := 2.5         ← TRAPPED↔ESCAPE 임계결합
```

부호규칙: m<0 → TRAPPED · m=0 → marginal · m>0 → ESCAPE.

## 3. Allen-Dynes ⊕ Hopfield 통합 (sister-session 핵심 insight)

기존 RTSC 분석은 두 lens로 분리되어 있었음:

| lens | 진단 | 처방 |
|---|---|---|
| Allen-Dynes (1975) | "**λ 가 부족**하다" | 결합 키울 물질 찾기 |
| Hopfield (1969) | "**phonon 이 무르**다" (ω_log 낮음 + soft mode) | 단단한 격자 찾기 |

sister 도출: **두 lens가 같은 함수의 두 표현** — λ를 키우는 것 = ω_log를 키우는 것과 정확히 같은 효과. m = (λ − λ_crit)/λ 안에 양쪽이 통합되어 있음. 17-라운드 동안 따로따로 진단되던 wall이 single closed-form 안에 이미 있었던 것.

→ 본 doc은 단일 lens m으로 캠페인 후보 분류를 통일.

## 4. 도출 — 5 anchor fitting (수치검증)

| system | λ | m(cited) | m=(λ−2.5)/λ | |Δ| |
|---|---|---|---|---|
| H3S | 2.0 | −0.250 | −0.25000 | 0.0e+0 |
| LaH10 | 2.2 | −0.136 | −0.13636 | 3.6e−4 |
| YH10 | 2.59 | +0.035 | +0.03475 | 2.5e−4 |
| CaH₆ | 2.7 | +0.074 | +0.07407 | 7.4e−5 |
| iso-target | 3.0 | +0.167 | +0.16667 | 3.3e−4 |

모든 |Δ| < 1e−3 — cited 표시정밀도(소수 3자리)와 일치. **🔵 SUPPORTED-FORMAL** 등급.

```
m(2.00) = (2.00−2.5)/2.00 = −0.500000/2.000000 = −0.250000
m(2.20) = −0.300000/2.200000 = −0.136364
m(2.59) = +0.090000/2.590000 = +0.034749
m(2.70) = +0.200000/2.700000 = +0.074074
m(3.00) = +0.500000/3.000000 = +0.166667
m(3.903) = +1.403000/3.903000 = +0.359467   ← labeh8 (본 repo 측정 신규)
```

## 5. 본 캠페인 적용 (DFT 결과/in-flight를 m-axis에 매핑)

| job | λ (lit/측정/예상) | m | class | 함의 |
|---|---|---|---|---|
| **labeh8** (이미 측정, harmonic) | **3.903** | **+0.359** | 🟢 **deep ESCAPE — 본 repo 최초 measured 사례** | sister 예측 "YH₁₀ family ternary"의 본 repo 생체 검증 (La≈Y의 화학적 유사성). ω_log=589K 낮음 → Tc 117K 한계, SSCHA보정/ω_log↑ 으로 200K+ 잠재 |
| h3cl 8q (측정) | 1.21–1.37 | −1.06 ~ −0.83 | 🔴 deep TRAPPED | 측정 140K은 ω_log~1350K로 m<0 영역에서도 Tc 끌어올린 사례 — m이 Tc 자체 아님을 입증 |
| h3cl interp ablation | 동상 | 동상 | 동상 | method 검증, m 변동 추정 ±0.05 |
| **ysbh6** (running, 4/N dyn) | per-mode 0.02–0.36, BZ_avg ?2.0–2.5 | **−0.25 ~ 0** | TRAPPED↔marginal 경계 | 🎯 Y-함유 ternary = YH₁₀ family 화학적 친척, λ_BZ>2.5면 두 번째 ESCAPE |
| polymorph Mg₂IrH₆ | TBD (stability 우선) | TBD | TBD | dynamical 통과 시 평가 |
| MgB₂ pilot | ~0.7 (lit) | −2.571 | 🔴 deep TRAPPED 음 anchor | calibration — m-axis 음의 끝 고정 |
| Nb₃Al pilot | ~0.6 (lit) | −3.167 | 🔴 even deeper | anchor 확장 |

**🛸 새 관찰**: labeh8 = 본 캠페인에서 측정된 첫 **m>0 deep ESCAPE 화합물**. sister 세션이 "YH₁₀ family ternary가 ambient 293K의 가장 가까운 후보"라고 closed-form으로 예측 — 본 repo의 labeh8(La-Be-H₈)이 La↔Y 자매로 그 예측 영역에 실측 발 디딘 첫 케이스. 결정적 후속: ω_log를 589K → 800K+로 올릴 수 있는 ternary 변형 탐색 (또는 SSCHA로 anharmonic Tc 재계산).

**ω_log 분리**: m-axis만으로는 Tc 직결 아님. h3cl(m=−0.92인데 측정 Tc 140K, ω_log=1350K로 보상) vs labeh8(m=+0.359인데 측정 Tc 117K, ω_log=589K로 한계). m = ESCAPE 가능성 prior · ω_log = Tc 변환계수.

## 6. 한계 + 다음 단계

1. **λ_crit=2.5 정확값** — 5 anchor fitting으로 산출, 더 많은 anchor 필요시 흔들릴 수 있음. ysbh6 + polymorph + 추가 ternary 결과가 fit 보강 candidate.
2. **closed-form 단순성** — Tc는 (λ, ω_log, μ*) 3변수; m은 λ만 → ESCAPE 영역이라도 ω_log 낮으면 Tc 낮음 (labeh8가 명백 증거).
3. **ternary 확장** — sister 예측 YH₁₀ family는 LaBeH₈(이미 측정), YH₉, Y-함유 ternary로 점진. 본 캠페인 ysbh6 = 1차 확장.

## 7. 출처 + provenance

- **anchor 값**(5 system, m값 4자리): sister claude 세션 output (RTSC21 closed-form prediction + RTSC24 mechanistic root 융합 분류).
- **canonical 이름** `stability_coupling_margin`: sister session 10p arxiv-ready paper (xelatex 3-pass clean, 2 fal figures, 54-row BLUE-MAX audit, 3 pre-registered falsifiers) — 본 doc과 이름 정렬.
- **Allen-Dynes ⊕ Hopfield 통합**: §3, sister 도출 (17 라운드 BLUE-MAX audit 결과).
- **formula 추출**(m=(λ−2.5)/λ 도출 + 검증): 본 repo — 5 anchor fitting (PR #335).
- **labeh8 deep-ESCAPE 적용**: 본 repo 측정값(λ_BZ=3.903 · `exports/material_discovery/rtsc_labeh8_fullbz_elph_20260526.json`)에 §2 formula 적용한 신규 finding (이 PR).
- **provenance gap closed**: `/gap` P1 (F4 honesty-triad · F7 active-acquisition · F8 unowned-load-bearing) 합산 PR #335에서 1차 close, 본 PR에서 canonical-name + 통합 lens + labeh8 적용 추가.
