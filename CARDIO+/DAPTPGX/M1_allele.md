# M1 — CYP2C19 한국인 allele 빈도 + diplotype 분포

> 마일스톤 M1 산출물 · current-state · no history.
> 출처 = CPIC + KoGES + KARE + literature → 🟡 SUPPORTED-BY-CITATION.

---

## 1. CYP2C19 enzyme — clopidogrel 활성화의 단일 병목

```
clopidogrel (prodrug, 비활성)
        │
        ├─ 85% esterase → 비활성 carboxylic acid
        │
        └─ 15% hepatic CYP (주로 CYP2C19) → 2-oxo-clopidogrel
                                                │
                                       CYP2C19 (다시!) → R-130964 (active thiol)
                                                │
                                                ↓
                                       P2Y12 receptor 비가역 차단
                                                │
                                                ↓
                                       platelet aggregation ↓
```

→ CYP2C19 활성이 **2-step 모두** 율속. LoF allele 1개만 있어도 active metabolite 30-50% ↓.

---

## 2. 주요 allele 풀이 + 활성도

| allele | 변이 (rs) | 기능 | enzyme activity |
|---|---|---|---|
| `*1` | wild | normal | 1.0 (reference) |
| `*2` | 681G>A (rs4244285) | **splice defect** → 활성 단백 X | 0 |
| `*3` | 636G>A (rs4986893) | premature stop → 활성 단백 X | 0 |
| `*17` | -806C>T (rs12248560) | promoter ↑ → 과발현 | 1.5-2.0 |

`*2` `*3` = loss-of-function (LoF) · `*17` = gain-of-function (GoF).

---

## 3. 한국인 vs 글로벌 allele 빈도

| allele | 한국인 (KoGES · KARE) | 동아시아 | 백인 (유럽) | 흑인 (아프리카) |
|---|---|---|---|---|
| `*1` | ~57% | ~60% | ~62% | ~67% |
| **`*2`** | **~29-31%** | ~30% | ~15% | ~17% |
| **`*3`** | **~9-11%** | ~7% | < 0.5% | < 0.5% |
| `*17` | ~1-2% | ~3% | ~21% | ~16% |

→ **한국인 LoF allele 합계 ~40%** = 글로벌 최고 수준.
→ 한국인은 `*3` 빈도가 백인 대비 ~20-50배 (백인에선 거의 없음).

---

## 4. Diplotype → phenotype → clopidogrel 반응

| diplotype | 표현형 (CPIC 2022) | 한국인 빈도 (예상) | clopidogrel 반응 |
|---|---|---|---|
| `*1/*1` | NM (Normal Metabolizer) | ~32% | normal |
| `*1/*17` | RM (Rapid) | ~1% | normal-high (출혈위험 ↑) |
| `*17/*17` | UM (Ultrarapid) | < 0.1% | high (출혈위험 ↑↑) |
| `*1/*2` · `*1/*3` | **IM (Intermediate)** | ~45% | **반응 ↓ — alternative 권고** |
| `*2/*17` · `*3/*17` | IM | ~1% | 반응 ↓ |
| **`*2/*2` · `*2/*3` · `*3/*3`** | **PM (Poor)** | **~14-16%** | **반응 X — alternative 강력 권고** |

```
한국인 PCI 환자 100명 가정
─────────────────────────────────
  NM       IM/PM (LoF carrier)
  ~32명    ~60명 ← clopidogrel 효과 ↓ or X
           │
           ├─ IM ~45명 (allele 1개 LoF)
           └─ PM ~15명 (allele 2개 LoF)
  RM/UM ~1명
  기타 ~7명 (rare allele 조합)

   → 한국인 60%가 clopidogrel 비-최적 후보
```

---

## 5. 가이드라인 권고 (CPIC 2022 + ACC/AHA 2025)

| 표현형 | clopidogrel | prasugrel | ticagrelor |
|---|---|---|---|
| NM · RM | **권고** | 대체 OK | 대체 OK |
| IM | **alternative 권고** | 권고 | 권고 |
| PM | **금기 수준** | 권고 | 권고 |
| UM | 권고 (단 출혈위험 모니터) | 대체 | 대체 |

⚠️ **한국인 caveat**: prasugrel/ticagrelor가 동양인에서 출혈 위험 ↑ (TICAKOREA · PHILO). → 단순 switch가 정답 아님 → M3/M4 결정 트리.

---

## 6. 보조 polymorphism (M2 입력)

| 유전자 | 변이 | 효과 |
|---|---|---|
| ABCB1 | 3435C>T (rs1045642) | clopidogrel 흡수 ↓ |
| PON1 | Q192R (rs662) | bioactivation 보조 (논란) |
| ITGB3 | PlA1/A2 | platelet receptor variant |
| P2RY12 | H1/H2 haplotype | P2Y12 receptor variant |

ABCB1 + CYP2C19 조합 시 위험 추가 가중.

---

## 7. 참고문헌

- Scott SA et al. (2013) *Clin Pharmacol Ther* 94:317 — CPIC 1st guideline
- Lee CR et al. (2022) *Clin Pharmacol Ther* 112:959 — **CPIC 2022 update (current)**
- Mega JL et al. (2009) *NEJM* 360:354 — CYP2C19 LoF + clopidogrel outcome
- Mega JL et al. (2010) *JAMA* 304:1821 — meta-analysis (stent thrombosis ↑)
- Lee SJ et al. (2013) *Clin Chim Acta* 425:212 — 한국인 allele freq
- Park KW et al. (2020) *Lancet* 396:1079 — **TICAKOREA** (ticagrelor 한국인 출혈 ↑)
- Kim HS et al. (2020) *JAMA Cardiol* 5:1240 — HOST-EXAM (한국인 deescalation)
- Galli M et al. (2022) *Lancet* 400:1542 — guided antiplatelet meta-analysis

---

## 8. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| allele 기능 (`*2`/`*3` LoF · `*17` GoF) | 🟡 SUPPORTED-BY-CITATION | functional assays + dbSNP |
| 한국인 allele 빈도 | 🟡 SUPPORTED-BY-CITATION | KoGES · KARE · Lee 2013 |
| diplotype → phenotype 매핑 | 🟡 SUPPORTED-BY-CITATION | CPIC 2022 |
| clopidogrel 반응 ↓ 정량 | 🟠 INSUFFICIENT/DEFERRED | platelet reactivity 정량 → M5 (PFT) |
| 한국인 prasugrel/ticagrelor 출혈 위험 | 🟡 SUPPORTED-BY-CITATION | TICAKOREA · HOST-EXAM |

→ M2 pathway 정량(평균 active metabolite 감소율) + M3 switch 결정 트리로 연결.

🔑 한국인 임팩트: **PCI 환자 100명 중 ~60명이 clopidogrel 비-최적** — 단일 환자에 가장 큰 결정 변수.
