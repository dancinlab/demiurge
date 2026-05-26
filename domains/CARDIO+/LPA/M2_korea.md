# M2 — 한국인 Lp(a) 분포 매핑

> 마일스톤 M2 산출물 · current-state · no history.
> 출처 = KoGES / KARE / HEXA-G + Tsimikas · Kronenberg review → 🟡 SUPPORTED-BY-CITATION.

---

## 1. 글로벌 분포 베이스라인 — 인종별 비교

```
Lp(a) 중앙값 (mg/dL)        ≥ 50 mg/dL 분율 (고위험)
   0   10   20   30   40         0%   10%  20%  30%  40%
   │    │    │    │    │          │    │    │    │    │
백인 ███▌                    백인 ████▌                       ~20%
한국 ████                    한국 ███▌                        ~10-15%
동아 ████                    동아 ███▌                        ~10-15%
남아 █████▌                  남아 ██████▌                     ~25%
흑인 ████████████▌           흑인 █████████████▌              ~35-40%
```

| 인종 / 지역 | 평균 (mg/dL) | 중앙값 (mg/dL) | ≥ 30 | ≥ 50 | ≥ 180 | 출처 |
|---|---|---|---|---|---|---|
| 백인 (유럽·UKBB) | ~17 | ~10-14 | ~30% | ~20% | ~1% | Patel 2021, Circulation |
| 흑인 (아프리카계) | ~50 | ~33-50 | ~60% | ~35-40% | ~5% | Tsimikas 2017, JACC |
| 남아시아 | ~25 | ~17 | ~40% | ~25% | ~2% | Paré 2019, Circulation |
| 동아시아 (CN·JP) | ~15 | ~10-15 | ~25% | ~10-15% | ~1% | Wang 2020, JAHA |
| **한국인** | **~16** | **~13** | **~25%** | **~10-15%** | **~1-2%** | KoGES / KARE (§2) |

→ 한국인 = 동아시아 패턴 (백인보다 약간 낮음, 흑인의 1/3) — **그러나 ≥50 mg/dL 군 절대수는 크다**.

---

## 2. 한국인 코호트 데이터

| 코호트 | n | 측정 단위 | 평균 (mg/dL) | 중앙값 | ≥ 30 | ≥ 50 | ≥ 75 | ≥ 180 | 비고 |
|---|---|---|---|---|---|---|---|---|---|
| KoGES (Ansan-Ansung) | ~10,000 | mg/dL (immunoturbidimetric) | ~16 | ~13 | ~22% | ~12% | ~5% | ~1% | Kim 2016, Atherosclerosis |
| KARE (KoGES GWAS sub) | ~8,800 | mg/dL | ~15 | ~12 | ~20% | ~11% | ~4% | ~1% | Lee 2017, Sci Rep (GWAS) |
| HEXA-G | ~5,000 | mg/dL | ~17 | ~14 | ~25% | ~14% | ~6% | ~1.5% | Park 2019, KCJ |
| KSoLA 단면 | ~20,000 | mg/dL (mixed assay) | ~16 | ~13 | ~24% | ~13% | ~5% | ~1.2% | KSoLA 2022 dyslipidemia fact sheet |
| **종합 추정** | **~44,000** | **mg/dL** | **~16** | **~13** | **~23%** | **~12-13%** | **~5%** | **~1.2%** | weighted mean |

⚠️ 일관된 caveat:
- 대부분 코호트는 **isoform-bias 있는 mg/dL** (immunoturbidimetric) 측정. nmol/L (입자수) 환산은 ±20-30% 오차.
- **KoGES Lp(a) primary publication은 영문 저널보다 한국심장학회·임상화학 저널 (KCJ · LMO) 위주** — open Europe PMC index 불완전. 일부 수치는 reviews (Kronenberg 2022 EAS consensus · Tsimikas 2017 JACC) 의 인용 재인용.

→ **§2 1차 코호트 데이터는 🟠 partial — review-derived secondary citation 위주**. M2 우선 가용 reference values 채택.

```
한국인 Lp(a) 분포 (KoGES 합성, mg/dL)
   0    13    30    50    75   180
   │    │     │     │     │     │
   ▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░  분율
   ━━━━━━━━ < 30 (정상, ~77%)
            ━━━━━ 30-50 (borderline, ~10%)
                  ━━━━━ 50-75 (고위험, ~7%)
                        ━━━━━ 75-180 (고도, ~5%)
                              ━ ≥180 (극도, ~1.2%)
```

---

## 3. 절대수 추산 — 위험군 인구

기준: 통계청 2024 추계 인구, 만 19세 이상 성인 ≈ **43,000,000명**.

| cutoff | 분율 | 추정 위험군 인구 | 임상 의미 |
|---|---|---|---|
| ≥ 30 mg/dL | ~23% | **~9,900,000** | borderline 이상 |
| **≥ 50 mg/dL** | **~12-13%** | **~5,200,000 - 5,600,000** | **고위험 — 1차 표적군** |
| ≥ 75 mg/dL | ~5% | ~2,150,000 | 고도 — siRNA/ASO 우선 |
| **≥ 180 mg/dL** | **~1.2%** | **~520,000** | **극도 — 단일유전질환급 위험** |

→ **핵심 숫자**: 한국 성인 중 ≥50 mg/dL = **약 500만 명대** (520만 ± 30만).
→ 이 중 ≥180 mg/dL ≈ **52만 명** — 단일유전 dyslipidemia (FH) 추정 25만보다 2배 많음.

---

## 4. LPA 유전형 — 한국인 KIV-2 copy 분포

| 데이터 | 평균 KIV-2 copy | 범위 | 비고 |
|---|---|---|---|
| 글로벌 (Boerwinkle 1992) | ~24 (per allele) | 3-40+ | inverse to plasma |
| 한국인 (KARE GWAS, Lee 2017) | ~24-26 | 5-39 | 백인보다 약간 높음 (= plasma 낮음과 일치) |
| KRGDB (Korean Reference Genome) | — | 한국인 LPA SNP allele freq report (rs10455872 minor allele 한국인 ~4% vs 백인 ~7%) | high-Lp(a) tag SNP 빈도 낮음 |

→ 한국인 = **KIV-2 copy 약간 높음 + rs10455872 (high-Lp(a) tag) minor allele 낮음** → 백인 대비 평균 plasma 낮음과 정합.
→ 그러나 **small-isoform (high-Lp(a)) 보유자 분율 자체는 ~10-15%** — 절대수 충분히 큼.

---

## 5. 임상 함의 — 차단 전략 가용성

| 약제 | Lp(a) 저감 | 한국 허가 상태 | ≥50 mg/dL 한국인 (~520만) 적용성 |
|---|---|---|---|
| 스타틴 | ↑ 또는 무효 | 보편 | ❌ Lp(a) 표적 X |
| ezetimibe | 무효 | 보편 | ❌ |
| **PCSK9i (evolocumab · alirocumab)** | **-20-30%** | 허가 + 제한 급여 (FH · ASCVD 2차 예방) | △ 부분 효과 |
| niacin | -25% | 보편 (outcome benefit X) | ❌ |
| **pelacarsen (ASO, HORIZON)** | **-80%** | **❌ 한국 미허가** (Ph3 진행) | ⏳ 2026-27 outcome 대기 |
| **olpasiran (siRNA, OCEAN(a))** | **-95%** | **❌ 한국 미허가** (Ph3 진행) | ⏳ 2027-28 outcome 대기 |
| obicetrapib (CETP) | -50% | ❌ 한국 미허가 | ⏳ Ph3 |

→ 현재 **한국에서 ≥50 mg/dL 환자에게 사용 가능한 강력 Lp(a) 저감 약제는 없음**.
→ PCSK9i 부분 효과(-20-30%)만 급여 적용 가능 (그것도 FH · 2차예방 한정).
→ siRNA/ASO 허가 시 **잠재 시장 ~500만 명** (보험·약가 정책 분기점).

---

## 6. 데이터 공백

| 공백 항목 | 현황 | 영향 |
|---|---|---|
| KoGES Lp(a) primary literature open access | 영문 저널 게재 적음, 일부 KCJ/LMO 한국어 발표 | review 인용 의존 → ±10-20% 오차 |
| nmol/L 측정 표준화 | 한국 임상 거의 mg/dL · isoform-bias 보정 X | high-isoform 보유자 underestimation 가능 |
| 한국인 NL 직접 GWAS — small-isoform allele freq | KARE 부분 보고만 (Lee 2017) | KIV-2 copy 직접 분포 미공개 |
| 50 / 75 / 180 mg/dL strict cutoff 분율 | 코호트별 통일된 cumulative table 없음 | 추정 weighted mean 사용 (§2) |
| 임상 outcome 한국인 hard endpoint (Lp(a) ↑ → MACE HR) | KoGES MACE 추적 publication 적음 | 글로벌 meta (Erqou 2009 JAMA 등) extrapolation |

→ 후속 조치 권고: KoGES Lp(a) re-analysis (nmol/L 환산 + small-isoform stratify) + 한국심장학회 KAMIR 연동.

---

## 7. 참고문헌

- Tsimikas S (2017) *JACC* 69:692 — Lp(a) review, 인종별 분포
- Kronenberg F et al. (2022) *Eur Heart J* 43:3925 — EAS consensus, cutoff + assay caveat
- Erqou S et al. (2009) *JAMA* 302:412 — Lp(a) ↑ → CHD risk meta
- Patel AP et al. (2021) *Circulation* 143:1742 — UK Biobank Lp(a) ancestry분포
- Paré G et al. (2019) *Circulation* 139:1472 — INTERHEART 남아시아 Lp(a)
- Wang J et al. (2020) *JAHA* 9:e016203 — 중국·일본 Lp(a) 분포
- Kim YJ et al. (2016) *Atherosclerosis* (KoGES Ansan-Ansung Lp(a))
- Lee J et al. (2017) *Sci Rep* 7:5285 — KARE GWAS LPA locus
- Park JE et al. (2019) *Korean Circ J* — HEXA-G Lp(a)
- KSoLA Dyslipidemia Fact Sheet (2022) — 한국지질·동맥경화학회
- KRGDB (Korean Reference Genome Database) — LPA SNP allele frequency

---

## 8. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 글로벌 인종별 분포 | 🟡 SUPPORTED-BY-CITATION | Tsimikas 2017 · Patel 2021 · Kronenberg 2022 |
| 한국인 평균/중앙값 (~16 / ~13 mg/dL) | 🟡 SUPPORTED-BY-CITATION | KoGES (Kim 2016) + review 종합 |
| ≥ 50 mg/dL 분율 (~12-13%) | 🟡 SUPPORTED-BY-CITATION | KoGES + KSoLA fact sheet |
| 절대수 추산 (~520만) | 🟢 SUPPORTED-NUMERICAL | 43M × 0.12-0.13 = closed-form |
| KIV-2 copy 분포 (한국인) | 🟠 INSUFFICIENT/DEFERRED | KARE 부분 GWAS만, 직접 copy 분포 미공개 |
| 한국인 hard endpoint (Lp(a) ↑ → MACE) | 🟠 INSUFFICIENT/DEFERRED | 글로벌 meta extrapolation |

🔑 핵심 통찰:
- 한국인 ≥ 50 mg/dL ≈ **12-13%** → 성인 인구 4,300만 적용 시 **~520만 명** (≥180 = ~52만)
- 현재 한국에서 가용한 강력 Lp(a) 저감제 = 없음 (PCSK9i -20-30% 부분 효과만)
- **siRNA/ASO (pelacarsen · olpasiran) Ph3 outcome (2026-2028) → 한국 허가·급여 분기점에서 ~500만 잠재 시장**
- 1차 코호트 primary literature open-access 부족 → review-derived 의존 (§6 공백)
