# §9.15 Precommit Outlier 분석 — h3f/h3cl/h3si vs prediction 양방향 fail

**date** 2026-05-23 · **scope** §9.15 precommit hypothesis 검증 노트 (편집-금지 SSOT 별도)
**status** investigation · 5-가설 inventory + evidence 점수 + 다음-검증 axis 추천

## 1. LANDED 데이터 정밀 비교 (result.txt 직접 인용)

| candidate | group | mass(X) | r_cov(Å) | EN(χ) | celldm | λ_BZ(broad sweep)        | ω_log(K)   | Tc(μ=0.10) | Tc(μ=0.13) |
|-----------|------:|--------:|---------:|------:|-------:|--------------------------|-----------:|-----------:|-----------:|
| h3f       | 17    | 19.00   | 0.71     | 3.98  | 5.127  | 0.816/0.807/0.814/0.822  | 652-670    | 31.8-33.2  | 25.9-27.1  |
| h3si      | 14    | 28.09   | 1.11     | 1.90  | 5.656  | 1.724/1.787/1.811/1.821  | 624-572    | 80.3-76.9  | 74.2-71.3  |
| h3cl      | 17    | 35.45   | 0.99     | 3.16  | 5.659  | 1.135/1.267/1.349/1.406  | 1254-1250  | 104.6-133.8| 92.0-121.1 |
| h3po(ref) | 15    | 30.97   | 1.07     | 2.19  | 6.236  | 3.313/3.052/2.862/2.751  | 258-273    | 48.4-47.3  | 46.2-44.8  |

broad sweep = `[0.015, 0.020, 0.025, 0.030]` Ry · 동일 nq=16 / weights / ref line

## 2. §9.15 가설 vs 실측 — 양방향 violation

```
group 17 light→heavy:    F(19) → Cl(35)
predicted (light-X):     HIGH  → LOW       (ω_log dominant)
observed (Tc μ=0.10):    32 K  → 120 K     [inversion]
                         -38%    +75%       both directions FAIL
```

핵심 불일치: F 가 **light + small celldm(5.13) 임에도 λ=0.82 만 나옴** vs Cl 이 **heavy 임에도 λ=1.27, ω_log=1250K** 라는 (가장 큰 ω_log).

## 3. 5-가설 inventory + evidence 점수 (1-5)

| # | 가설                                                           | evidence | 근거                                                                                    |
|---|----------------------------------------------------------------|---------:|-----------------------------------------------------------------------------------------|
| a | electronegativity damage > light-X benefit                     | **4**    | F(χ=3.98) Tc=32K · Cl(χ=3.16) Tc=120K · Si(χ=1.90) Tc=77K → χ-monotone 약화 명확        |
| b | lattice volume / celldm 효과                                    | **3**    | F celldm=5.13 (조밀) λ=0.82 vs Cl/Si celldm≈5.66 λ=1.27/1.81 → 조밀-cell coupling 약화  |
| c | DOS at E_F (p-orbital filling)                                 | **2**    | direct DOS evidence 없음 · 정황만 (F p^5 너무 채워짐 — bonding band 위로 push)         |
| d | F anharmonicity / imaginary mode 영역 우려                      | **2**    | F sweep flat (0.81-0.82) = 잘 수렴이나 ω_log=660K (Si 보다 살짝 위) — 비정상은 아님    |
| e | h3cl broadening 단조 증가 = under-converged, true λ > 1.41     | **5**    | 1.135→1.267→1.349→1.406 명확 단조 ↑ · 다른 3개는 plateau · grid 미충족 직접 증거       |

**settle 1위**: (e) h3cl grid-convergence 미충족 — broadening sweep 단조 시그니처가 직접 증거
**settle 2위**: (a) electronegativity damage > light-X — χ-Tc 단조 anti-correlation (F 32 < Si 77 · Cl 가 ω_log driver 우세는 별개)

(a) 와 (b) 는 conflated — celldm 과 χ 가 group-17 내에서 동시 변함. h3br LANDED 시 분리 가능 (Br: χ=2.96 lower, celldm 예상 더 큼).

## 4. §9.15 protocol 수정 제안

1. **양방향 outlier 기록 항목 추가** — 단순 PASS/FAIL 이 아니라 `axis_violated=[mass|EN|volume|DOS|convergence]` 로 분류
2. **broadening sweep 단조 시그니처 → re-run trigger** — plateau 미달성 시 dense q-grid (4x4x4) 재시행 권고. h3cl 우선 (1.135→1.406 30% drift)
3. **3-axis predictor 로 격상** — `Tc ~ f(ω_log_X-H, λ_BZ, χ_X)` · 단순 mass-scaling 폐기
4. **electronegativity penalty term** 도입: `Tc_pred *= (1 - α·(χ_X - χ_ref))` (α≈0.15 fit 후보)

## 5. 남은 5 후보 Tc 재예측 (가설 a+b 채택 시)

celldm 추정은 covalent radius proxy · χ damage term α=0.15 · base λ_ref=1.5 (Si scale)

| candidate | group | χ    | r_cov | est.Tc(μ=0.10) old §9.15 | revised est. (a+b) | priority |
|-----------|------:|------|------:|--------------------------|--------------------:|---------:|
| h3o       | 16    | 3.44 | 0.66  | 60-100 K                 | 35-55 K (χ-damp ↑)  | high     |
| h3n       | 15    | 3.04 | 0.71  | 70-110 K                 | 55-75 K             | high     |
| h3p       | 15    | 2.19 | 1.07  | 60-100 K                 | 70-95 K             | mid      |
| h3as      | 15    | 2.18 | 1.19  | 35-65 K                  | 55-80 K (EN low)    | mid      |
| h3br      | 17    | 2.96 | 1.20  | 15-40 K                  | 80-130 K (Cl-like)  | **critical-test** |

**h3br 가 결정적**: group-17 (a) χ-damage vs (b) volume 분리 가능. Br 이 Cl 보다 χ 낮 + celldm 더 큼 → (a) 단독이면 Tc 상승, (b) 단독이면 Tc 더 상승, 둘 다면 (a)+(b) 가산 — Tc>Cl 예상.

## 6. 즉시 검증 가능한 axis 추천

**axis: electronegativity vs Tc 단조성** — 5 LANDED 도착 즉시 χ_X 와 Tc(μ=0.10) scatter plot 으로 (a) 가설 검증. r²>0.7 이면 §9.15 를 χ-driven 으로 재작성. 한편 (e) 는 즉시 actionable: **h3cl dense-grid (4x4x4 q) re-run 큐잉 권고** — current λ=1.41 는 underestimate, true 값 가능성 1.6+ (Tc 150-180K 영역).

---
*참조 read-only*: `~/etc/rtsc-results/{h3cl,h3f,h3si,h3po}/result.txt`
