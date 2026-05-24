# H3 — DAPTPGX handoff (항혈소판제 약물유전체 맞춤)

> 출처: DAPTPGX.md / M7_map (결정맵) / M8_econ · X7 4-track 표 (PM 0.1521 / dual jeopardy) · X8 (🟢 5) · X5 §6 (verdict verbatim) · X6 §4 (NM/IM/PM 결정맵) · X9 §2 (D1-D5 wall).
> ⚠ grade 는 X8 ledger VERBATIM. 결정맵 적용 효과 (ST↓X%) = ⚪/🟠 (model assumption).

---

## ◆ 핵심 — 한국인 CYP2C19 LoF ~60% + dual jeopardy

```
한국인 CYP2C19 LoF allele (*2/*3) 합 ~40% = 글로벌 최고 (*3 백인 대비 20-50배)
        │
        ▼
  diplotype:  NM/RM ~33%  ·  IM ~45% (가장 흔함)  ·  PM ~15%
              ─────────       ──────────────────       ────────
  PM phenotype freq = 0.1521 (cited 0.14-0.15)  🟢 SUPPORTED-NUMERICAL (exact)
  IM+PM 합          = 0.6279 (cited 0.60)        🟢 SUPPORTED-NUMERICAL (within)
        │
        ▼
  ★ clopidogrel 비-최적 ~60% (IM+PM)
  ★ 단순 ticagrelor switch = TICAKOREA bleeding 2.8% vs clopi 1.4% (PLATO 1.4% 의 2배)
      → "약효 부족"과 "출혈 과다"의 dual jeopardy → universal ticagrelor 부적합
```

> 🟢 verbatim: PM 0.1521 · IM+PM 0.6279 (DAPTPGX V3 §61, X5 §6 C05/C06). 이 두 항목만 sub-V 에 🟢 verdict — 나머지 효과 추정은 🟡/🟠.

---

## ◆ CYP2C19 결정 트리 (M7 결정맵 · X6 §4 VERBATIM)

```
  CYP2C19 PCR 결과 (C5946 선별급여, ₩50,000, 1회)
        │
        ├─ NM/RM (정상 대사, 한국 ~33%) ──► clopidogrel 대체로 적절 가능
        │     · 환경변수(PPI·신기능·약물상호작용) 있으면 PFT(PRU) 고려
        │
        ├─ IM (중간 대사, 한국 ~45% · 가장 흔함) ──► clopidogrel 효과 부분 저하 가능
        │     · 출혈위험 낮으면 prasugrel 5mg (한국 dose) 고려
        │     · de-escalation (강력제→clopi) 은 PFT (PRU<208) 보조로 안전성 확인
        │
        └─ PM (저대사, 한국 ~15%) ──► clopidogrel 효과 크게 저하 가능 (ST 위험↑)
              · prasugrel 5mg 또는 ticagrelor 고려
              · ★ ticagrelor 는 한국인 출혈위험↑ (TICAKOREA) → 출혈균형이 핵심 (dual jeopardy)
              · PFT (VerifyNow PRU) 로 잔존 효과 확인 후 조정
```

| phenotype | 한국 빈도 | 일반적 고려 방향 (주치의 판단) | 근거 등급 |
|---|---|---|---|
| **NM/RM** | ~33% | clopidogrel 적절 가능 · 환경변수 시 PFT | 🟡 [M7] |
| **IM** | ~45% | clopidogrel 부분 저하 · 위험 낮으면 prasugrel 5mg · de-escalation PFT 보조 | 🟡 [M7] |
| **PM** | ~15% | clopidogrel 회피 고려 · prasugrel 5mg/ticagrelor (출혈균형) · PFT 확인 | 🟡 [M7] + TICAKOREA 🟡 |

> 결정맵 적용 시 ST event 감소 X% = 🟠 (model assumption) / ⚪-성격 — cohort outcome 미측정 (X4 §5 over-claim 후보 #2).

---

## ◆ 즉시 시작 가능 — 모든 약제·검사 기존 NHIS 급여 안

| 항목 | 급여 근거 | 신규 승인 |
|---|---|---|
| CYP2C19 PCR (real-time) | C5946 선별급여 (PCI 환자, ₩50,000, 1회) | 불요 (기존재) |
| clopidogrel · prasugrel 5mg · ticagrelor | 기존 급여 약제 (S4 결정맵 = 약제 재배치만) | 불요 |

→ **B. DAPT-PGx-K = 규제 장벽 최저 (즉시 시작 가능)** · 신규 IND·신규 약물 승인 전혀 불요 · registry-embedded 다음 PCI 환자부터.

---

## ◆ wall → 돌파 path (d2 · X9 §2)

| wall | 돌파 path 2-3개 |
|---|---|
| **D1** 60% 비-최적 + ticag switch 출혈 | (A) CYP2C19-guided 결정 트리 (3-axis cube) · (B) vicagrel/selatogrel CYP2C19-무관 신약 (CES1 1-step, PM 60% 1:1 대체) · (C) HOST-EXAM clopi 단독 chronic (HR 0.73, Kim 2020 Lancet) |
| **D2** ICER sign/magnitude 미반전 | (A) V7 Markov lifetime patch · (B) pool-route 복구 후 재실행 (PR #700 merged unblock) · (C) 🟠 honest DEFERRED 유지 (d6 거짓 🟢 거부) |
| **D4** caller head-to-head 부재 | (A) KOVA VCF → 4 caller (PyPGx·PharmCAT·Aldy·Stargazer) 병렬 confusion matrix · (B) 한국 cohort 첫 검증 · (C) hexa-lang stdlib wrapper |

> ICER honest: V3 -3,221 → V5 -503 M/QALY (cited +34, **sign 미반전 — 🟠 DEFERRED**). vicagrel 도입 시 ICER ~22-28 M/QALY = NHIS WTP 충족 (M8 §6). d6 준수 — 거짓 🟢 강제 금지.

---

## ◆ H3 grade 종합

- 🟢 5 (PM/IM 빈도 · HW phenotype) · 🟡 13~18 (결정맵·literature) · 🟠 9 (ICER·outcome 대기) · ⚪ 3 (5 NEW axes · KSC 격상 예상 · ST KPI 추정) · 🔴 0.
- 즉시 적용: **CYP2C19 PCR (선별급여) + 결정맵 약제 재배치** — 신규 승인 불요, 오늘 가능.
- 정직성: PM 0.1521 / IM+PM 0.6279 만 🟢 (verbatim) · 결정맵 효과 ST↓X% 는 🟠/⚪ (model) · ICER sign 미반전 🟠 DEFERRED (over-claim 차단).

**H3 종합**: 🟡 SUPPORTED-BY-CITATION (compositional) — DAPTPGX V4 + X8/X5/X6 verdict VERBATIM. 새 판정 0건 (per @D g5).
