# H2 — NOREFLOW handoff (no-reflow / IRI 미세혈관 보호)

> 출처: NOREFLOW.md / M7_rank.md (Tier-A 약물 · 3-path) · X7 4-track 표 (mis-delivered) · X8 §5 (🔴 4 RCT null) · X9 §1 (N1-N5 wall) · X5 §1 (Trial-A NICORADENO).
> ⚠ grade 는 X8 ledger VERBATIM. 효과 추정 = ⚪ proposal.

---

## ◆ 핵심 논지 — mPTP 는 "죽은 표적"이 아니라 mis-delivered

```
4 large RCT (n>2,000) 연속 neutral:
  CIRCUS · CYCLE · EMBRACE · MITOCARE  ──  🔴 FALSIFIED (X8 §5 F1-F4)
                │
                ▼
  왜? CsA 2.5mg/kg IV 1.5h infusion → arm-to-heart lag (IV 30-120s)
      → 재관류 첫 5분 lethal window 미도달
                │
                ▼
  ★ 약물 falsify 가 아니라 전달(delivery) falsify
      IC + reperfusion-synced ODE: 93.5% (CIRCUS) → 56.9% cell death  (Δ=36.6pp)
      → 죽은 표적이 아니라 mis-delivered 표적 (X9 N1 path A, 정량 정당화 완료)
```

→ 임상 함의: IV bolus 실패를 "mPTP 가설 폐기"로 읽는 단일-트랙 review 와 달리, 4-track 통합 관점은 **전달 경로(IC + 동기화)** 를 교정 변수로 분리한다.

---

## ◆ Tier-A 약물 (당장 임상 적용 가능 · 한국 우위) — M7_rank §3.1 VERBATIM

| 약물 | 점수 | 사용 시점 / 술기 | 한국 가용성 | 근거 RCT |
|---|---|---|---|---|
| **adenosine IC 24 mg distal bolus** | 4.85 ★A | TIMI ≤2 발생 시 microcatheter distal injection · 4 mg split (60s 간격) | OK (off-label routine) | REOPEN-AMI (Niccoli 2013) MVO 14% vs 35% (p=0.001) |
| **nicorandil pre-PCI loading** | 4.30 ★A | STEMI activation 시 oral 5-10mg or IV 4-12mg bolus → PCI 후 infusion 4-8mg/h | **OK (한국 등재, 글로벌 우위)** | J-WIND (Kitakaze 2007) LVEF 6mo↑, MACE↓ |
| **tirofiban IC 25 μg/kg** | 3.35 ☆B | 대형 thrombus burden (TIMI thrombus grade ≥4) bailout | OK (off-label) | M3 efficacy + M6 safety 합의 (🟡) |
| (참고) MTP-131 elamipretide | 3.40 ☆B | 단회 IV bolus 0.05mg/kg/h×1h, 재관류 -15min→+1h | 미승인 (수입 IND 필요) | EMBARK 장기 safety + EMBRACE Ph2 후속 |

> 권고 (M7_rank §3.1): **adenosine IC + nicorandil 조합은 한국 보험 내 즉시 진행 가능** · MTP-131 은 후속 Ph2 한국 단독 IND.
> grade: Tier-A 3약물 추천 = 🟡 SUPPORTED-BY-CITATION (M2/M3 efficacy + M6 safety 합의).

---

## ◆ 🔴 닫힌 음성 (closed negative · wall 아님 · audit trail 보존) — X8 §5

| # | falsified 가설 | 근거 | grade |
|---|---|---|---|
| F1 | SGLT2i acute MI MACE | EMPACT-MI HR 0.90 NS (Butler 2024 NEJM) | 🔴 |
| F2 | colchicine acute MI MACE | CLEAR SYNERGY HR 0.99 NS (Jolly 2024 NEJM) | 🔴 |
| F3 | nicorandil 한국 STEMI 6mo infarct size | Korean nicorandil RCT 6mo 차이 없음 (Heart 2023) | 🔴 |
| F4 | nicorandil 동아시아 PO 6mo MACE | CHIPS-PCI 6mo 무효 (Lancet Reg Health W Pac 2023) | 🔴 |

> note: F3/F4 의 6mo null 은 **acute IRI 보호 (peri-procedural IC)** 와 분리된다 — Tier-A 권고는 peri-PCI no-reflow 차단(REOPEN-AMI positive) 이지 장기 PO 가설이 아니다.

---

## ◆ wall → 돌파 path (d2 · X9 §1)

| wall | 돌파 path 2-3개 (포기 아님) |
|---|---|
| **N1** mPTP IV bolus falsify | (A) IC + 재관류 동기 전달 — ODE Δ36.6pp ✅ 정량 완료 · (B) CypD-selective NIM811/debio-025 · (C) 다축 cell-death 차단 (STING-GPX4 ferroptosis, Nature 2025) |
| **N4** mPTP 직접약물 한국 미수입 | (A) NAD+/NMN supplement IRB-light pilot · (B) ALDH2\*2 군 alternative NO donor (BH4) fast track · (C) siRNA delivery 인프라 공유 |
| **N5** Trial-A Cox 1y under-power (0.654) | (A) secondary exploratory 로 정직 명시 · (B) event-driven design · (C) ALDH2\*2 enrichment 로 effect size 증폭 |

---

## ◆ Trial-A: NICORADENO-MVO (X5 §1 carry)

| 항목 | 내용 |
|---|---|
| 대상 | STEMI primary PCI · IMR>40 (MVO+ subset ~40%) · ALDH2\*2 subgroup 사전지정 |
| 중재 | nicorandil PO 10mg loading + IV 4mg bolus pre-PCI + IC adenosine 24mg distal microcatheter · post-PCI nicorandil PO 7일 |
| 1차 종결점 | CMR infarct size (% LV mass) at 30d (Stone 2016 validated surrogate) |
| 추정 n | ~500 (⚪ proposal) · primary continuous **power 0.798 🟢 (≈0.80)** · Cox 1y MACE power 0.157 🟠 · ALDH2\*2 sub 0.654 🟠 |
| 규제 | nicorandil·adenosine 모두 한국 보험 routine → **신규 IND 불요** · 8-기관 CMR consortium MOU + IMR wire cap lift 필요 |
| 한국 우위 | nicorandil 한국 보험 등재 (글로벌 우위) · ALDH2\*2 East Asian ~40% → NO bioavailability↓ → alternative NO donor RCT 글로벌 부재 (first-in-class 기회 — 단 인과부 ⚪) |

---

## ◆ H2 grade 종합

- 🔴 4 (RCT null, closed negative) · 🟢 10 (IRI ODE · IC PK 등) · 🟡 33 (Tier-A·literature) · 🟠 10 (power·wet-lab) · ⚪ 15 (가치판단 9 + metaphor 6).
- 즉시 적용: **adenosine IC + nicorandil 한국 보험 내 즉시** (M7 §3.1). 핵심 = mis-delivered 교정 (IC + 동기).
- 정직성: 4 RCT null = closed negative (audit trail) · IC-sync Δ36.6pp = ODE 정량 (🟢) · "first-in-class 기회" 인과부 ⚪.

**H2 종합**: 🟡 SUPPORTED-BY-CITATION (compositional) — NOREFLOW V4 + X8/X9/X5 verdict VERBATIM. 새 판정 0건 (per @D g5).
