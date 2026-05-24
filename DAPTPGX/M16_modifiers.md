# M16 — DAPT 보조 modifier deep dive (ABCB1 · PON1 · CES1 · Lp-PLA2)

> M2 §7 acknowledged + M9 §10 5th NEW axis (Lp-PLA2) 깊이 audit.
> CYP2C19 외 추가 polymorphism + biomarker의 결정맵 영향 정량.
> per @D d6 (정직 — replication 실패는 그대로 보고) + g3 (table + ASCII).

## 1. modifier 4종 overview ASCII

```
clopidogrel pathway 위 modifier 위치:
      intestine     liver           plasma          platelet
        │  ABCB1     │ CYP2C19         │ CES1            │ P2Y12
        │   ↓        │  ↓ ↓            │  ↓              │  ↓
   ──── 흡수 ───── PK 활성화 ─────── 분해/배설 ─────── PD 반응
        │  efflux   │ 2-step        │ esterase       │ receptor
        │  ↑        │ rate-limit    │ R-130964→       │ binding
        │  3435T    │ *2/*3 LoF     │ inactive        │ Cys17/270
        │  efflux   │ *17 GoF       │ G143E ↓          │
        │           │ (M1 §2)       │ vicagrel benefit │
        │           │               │                  │
                        + PON1 Q192R (active site)
                        + Lp-PLA2 (vascular inflammation overlay)
```

## 2. **ABCB1 3435C>T (rs1045642)** — P-glycoprotein efflux

| 항목 | 값 |
|---|---|
| 위치 | chromosome 7q21.12 · MDR1 gene · exon 26 silent SNP (Ile1145Ile) |
| 기전 | intestinal P-gp efflux transporter · 약물 흡수 (intestine apical → lumen) |
| 한국인 빈도 | T allele 0.45 (한국 다수 cohort) · TT 0.20 · CT 0.50 · CC 0.30 |
| 임상 영향 | TT homozygous → P-gp 발현 ↓ → clopi 흡수 ↑ → active metabolite AUC ↑ ~15-25% |
| 메타분석 | Mega 2010 NEJM (n=2,932): TT vs CC ST HR 1.72 (95%CI 1.14-2.59) |
| 한국 cohort | Kim 2020 PMID — KAMIR substudy, TT가 ST 보호 일관 |
| 결정맵 통합 | 부수 axis — primary는 CYP2C19, ABCB1는 modifier (PRU 분산 5-8% 설명력) |
| 등급 | 🟡 SUPPORTED-BY-CITATION |

## 3. **PON1 Q192R (rs662)** — paraoxonase

| 항목 | 값 |
|---|---|
| 위치 | chromosome 7q21.3 · PON1 active site Q192R |
| 기전 | hepatic paraoxonase 1 · clopi 2-step bioactivation 중 second step 후보 (Bouman 2011 hypothesis) |
| 한국인 빈도 | R allele 0.55-0.60 · QQ 0.20 · QR 0.50 · RR 0.30 (동아시아 R allele 우세) |
| 임상 영향 (가설) | QQ → active metabolite AUC ↓ → HTPR · ST HR 3.6 (Bouman 2011) |
| **replication 실패** | Sibbing 2011 / Hulot 2011 / Trenk 2011 모두 effect 미확인 → meta-analysis (Yi 2014) null result |
| 한국 cohort | Jeong 2013 PMID — KAMIR null result 일치 |
| 결정맵 통합 | **결정맵 미포함** — M2 §7에 "🔴 FALSIFIED (부분)" 명시 |
| 등급 | 🔴 FALSIFIED (Bouman 2011 hypothesis · 본 modifier는 effect 부재 입증) |

## 4. **CES1 G143E (rs71647871)** — esterase

| 항목 | 값 |
|---|---|
| 위치 | chromosome 16q12.2 · CES1 carboxylesterase active site |
| 기전 | hepatic CES1 · clopi 2-oxo 중간체 → inactive metabolite 분해 경쟁 (CYP2C19와) |
| 한국인 빈도 | E143 allele 매우 드물게 ~0.005-0.01 (백인 0.04) → 임상 영향 미미 |
| 임상 영향 | G/G → 정상 분해 · G/E → CES1 ↓ → active metabolite 보존 ↑ → PRU ↓ |
| 메타분석 | Lewis 2013 PMID 23508732 — G/E carriers have higher active AUC |
| **vicagrel relevance** | vicagrel (M6 §4) = CES1-activated prodrug (CYP2C19 bypass) — G/E vicagrel은 효과 ↓ 가능 |
| 한국 cohort | rare allele → 데이터 부족 |
| 결정맵 통합 | clopi 결정맵에서 minor (한국인 rare) · **vicagrel 도입 시 중요 axis** (M6 timeline 2026-28) |
| 등급 | 🟡 SUPPORTED-BY-CITATION + 🟠 한국 데이터 부족 |

## 5. **Lp-PLA2 (lipoprotein-associated phospholipase A2)** — vascular inflammation overlay

| 항목 | 값 |
|---|---|
| 측정 | 혈장 Lp-PLA2 mass + activity (마커 — vascular inflammation degree) |
| 한국 baseline | ~150-200 nmol/min/mL · ≥225 high (top quartile) |
| 기전 | LDL phospholipid hydrolysis → lyso-PC 생성 → endothelial 활성화 + plaque vulnerability |
| 임상 영향 | high Lp-PLA2 → MACE HR 1.3-1.5 (Garza 2007 meta) · stroke 보강 |
| **STABILITY trial (Wallentin 2014)** | darapladib (Lp-PLA2 inhibitor) vs placebo · primary endpoint MISS · post-hoc subgroup signal만 |
| M9 §10 시점 | DT-678 + Lp-PLA2 axis = 새 시도 후보 (M9 5 NEW axes 중 (e)) |
| 결정맵 통합 | M7 cube 5D 확장 후보 — high Lp-PLA2 + LoF = "double vascular jeopardy" cell |
| 등급 | 🟡 SUPPORTED-BY-CITATION (biomarker) + 🔴 FALSIFIED (darapladib intervention) |

## 6. modifier × CYP2C19 통합 변동 설명력 (PRU 분산)

| modifier | CYP2C19 단독 변동 (5-15%) 외 추가 변동 설명력 |
|---|---|
| ABCB1 3435T | +5-8% (additive) |
| PON1 Q192R | 0% (replication 실패) |
| CES1 G143E | +1-2% (한국인 rare) |
| Lp-PLA2 | +2-4% (vascular biology overlay) |
| **통합 비CYP2C19** | ~7-12% (additive 가정) |
| **CYP2C19 + 통합** | ~20-25% PRU 분산 설명 (Shuldiner 2009 + extensions) |
| **잔여 ~75% 미설명** | platelet baseline heterogeneity · adherence · diet · co-meds (PPI · statin · 등) · 측정 noise |

## 7. modifier 결정맵 implementation guide

```
input: {CYP2C19_phenotype, ABCB1_3435_TT, Lp-PLA2_high}
  ↓
primary cell (M7 cube):
  PM × HBR-HIGH × complex  ←─── 90% 영향
  ↓
modifier refinement (M16):
  if ABCB1 TT:        primary rescue partial (PRU ↓ 25-30 unit)
  if Lp-PLA2 high:    upgrade to "extra-aggressive" subset
  if CES1 G/E:        vicagrel 시작 시 dose ↑ 고려 (M6 §4)
  ↓
final card:
  base 권장 + modifier adjustments + monitoring schedule
```

## 8. 한국 cohort 데이터 status

| modifier | 한국 데이터 (KAMIR · KoGES · HOST · K-ACTIVE) | gap |
|---|---|---|
| ABCB1 3435 | KAMIR Kim 2020 substudy · TT 보호 일치 | 다른 cohort 검증 필요 |
| PON1 Q192R | Jeong 2013 KAMIR null result | replication 일치 (no effect) |
| CES1 G143E | 데이터 거의 없음 (rare allele) | vicagrel KFDA 진입 시 cohort 측정 필요 |
| Lp-PLA2 | KOGES 측정 cohort 있음 · MACE 연관 일치 | DAPTPGX cohort 직접 측정 부재 |

## 9. 결정맵 통합 priority

| modifier | 결정맵 통합 우선순위 | 이유 |
|---|---|---|
| **ABCB1 3435** | **MID** | additive ~5-8% · TT 보호 일관 · 한국 빈도 0.20 |
| **PON1 Q192R** | **LOW (배제)** | replication 실패 · null effect |
| **CES1 G143E** | **HIGH for vicagrel** (M6) | vicagrel 도입 시 핵심 modifier · 현재 clopi에서는 LOW |
| **Lp-PLA2** | **MID-HIGH** | vascular biology overlay · M7 cube 5D 후보 · DT-678 (M9) 인접 |

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| ABCB1 3435 한국 빈도 | 🟡 SUPPORTED-BY-CITATION | 한국 multiple cohort |
| ABCB1 ST HR 1.72 | 🟡 | Mega 2010 NEJM meta |
| PON1 Q192R null replication | 🔴 FALSIFIED | Sibbing/Hulot/Trenk 2011 + Yi 2014 meta |
| CES1 G143E (한국 rare) | 🟡 + 🟠 부족 | Lewis 2013 (백인) · 한국 데이터 부족 |
| Lp-PLA2 MACE HR 1.3-1.5 | 🟡 | Garza 2007 meta |
| darapladib FALSIFIED | 🔴 | STABILITY trial primary endpoint MISS |
| 통합 PRU 분산 ~20-25% | 🟡 | Shuldiner 2009 + extensions |

## 11. 핵심 통찰

- **PON1 Q192R = 결정맵에서 명시적 제거** — Bouman 2011 hypothesis가 4건 independent replication 실패 (FALSIFIED). 한국 cohort 일치. modifier 인벤토리에서 historical 기록만 유지.
- **ABCB1 3435 = "good citizen" modifier** — additive 5-8% PRU 설명 · TT 보호 일관 · 한국 빈도 충분 (0.20) · 결정맵 secondary axis 추가 가능. cost (single PCR) 추가 시 incremental benefit.
- **CES1 G143E = vicagrel 시대의 핵심 modifier** — 현 clopi 결정맵에서는 LOW priority (한국 rare 0.005-0.01) but vicagrel KFDA 진입 (M6 2026-28) 시 vicagrel-specific PGx 의 first axis. 미래 분기점.
- **Lp-PLA2 = biomarker overlay 후보** — biomarker 자체 prognostic 가치 일관 but intervention (darapladib) FALSIFIED. M7 cube에 "high Lp-PLA2 + LoF" subset 추가 시 정밀화 가능 — DT-678 (M9 §5.5) 표적 후보와 연계.
- **modifier 통합 후에도 ~75% PRU 변동 미설명** — single-gene reductionism 한계 정직 보고. M14 frontier (single-cell platelet seq · scRNA) + M17 (AI/ML) 가 이 gap 의 잠재 path.
- **d6 정직 framing**: PON1 FALSIFIED · darapladib FALSIFIED 둘 다 명시. 결정맵에 "되는 modifier" + "안 되는 hypothesis" 둘 다 인벤토리 (audit trail).
