# H6 — 한국 first-in-class 4-trial portfolio

> 출처: X5 (korea_trials 압축) · X9 §5 (3-axis panel) · X7 timeline.
> ⚠ 추정 n · phase · 효과크기는 ⚪ proposal (설계 가정). verify verdict 있는 칸만 🟢/🟠 (verbatim).

---

## ◆ portfolio 마스터 표

| trial | 대상 (한국 특이) | 중재 | 1차 종결점 | 추정 n | 규제 경로 | 즉시성 |
|---|---|---|---|---|---|---|
| **A. NICORADENO-MVO** (NOREFLOW) | STEMI PCI · IMR>40 (MVO+ ~40%) · ALDH2\*2 사전지정 | nicorandil PO+IV + IC adenosine 24mg distal + post 7일 | CMR infarct size (% LV) at 30d | ~500 ⚪ | 약물 IND 불요 · CMR consortium MOU 필요 | 6m (enroll) |
| **B. DAPT-PGx-K** (DAPTPGX) | 한국 PCI · CYP2C19 LoF ~40% allele · IM+PM ~60% | CYP2C19 PCR → S4 결정맵 (NM=clopi · IM/PM=prasugrel 5mg/ticagrelor) | 1y MACE + major bleeding (GUSTO/BARC) | 설계 가정 ⚪ (NHIS sensitivity 후) | **PCR 선별급여 + 기존 급여 약제** | **즉시 (0m)** |
| **C. ISR-non-mTOR (ROCK-DCB IIT-1)** (ISR) | 한국 ISR · Mehran I/II · small vessel · NA高 · OCT-guided | fasudil-coated DCB (single-arm FIH → 후속 dual-DCB) | 6m OCT LLL + 30d safety | 60 ⚪ | MFDS FIH IND + PMDA cross-recog | 6m (pre-IND) |
| **D. LPA-siRNA-K (K-LpA-OUTCOMES)** (LPA) | 한국 ASCVD 2차 · Lp(a)≥100 (KSoLA≥50) · KIV-2 3-tier | arm A = statin+PCSK9 · arm B = pelacarsen/olpasiran (HORIZON 후 분기) | 4-point MACE 24m/60m | ~3,000 ⚪ | siRNA 신규 승인 + RSA | 3y |

> g5 fence: 추정 n (A 500 · C 60 · D 3,000) · 효과크기 = 설계 가정 (⚪). verify verdict 있는 칸 = §끝 표.

---

## ◆ 즉시 시작 = B. DAPT-PGx-K (규제 장벽 최저)

```
B. DAPT-PGx-K  ──  오늘 당장 가능
  · CYP2C19 PCR = C5946 선별급여 (₩50,000, 1회) 기존재
  · clopidogrel / prasugrel 5mg / ticagrelor = 전부 기존 급여 약제 (재배치만)
  · → 신규 IND·신규 약물 승인 전혀 불요 · registry-embedded 다음 PCI 환자부터
  · 잔여 작업 = NHIS ICER sensitivity (V5 -503, 🟠 DEFERRED — V6 patch 후속)
```

---

## ◆ 공유 인프라 시너지 — single-build 4-trial unlock (X5 §2.3)

| 공유 자산 | A | B | C | D | 1회 구축 효과 |
|---|:---:|:---:|:---:|:---:|---|
| 카테터 국소전달 PK + carrier core lab | ●(IC adenosine) | — | ●(fasudil-DCB) | — | A·C 공용 |
| 다기관 CMR/OCT imaging consortium | ●(CMR) | ●(pilot) | ●(OCT) | — | A·B·C 공용 |
| 비-IND 분자전달 pilot 거버넌스 | — | ●(NMN) | — | ●(siRNA) | B·D 공용 |
| **3-axis genotype 측정 (PCR)** | ●(ALDH2) | ●(CYP2C19) | — | ●(KIV-2) | **4-trial 공용 (채혈 1회)** |
| KAMIR registry backbone | ● | ● | ● | ● | 4-trial 전부 |

→ imaging consortium (CMR+OCT) + 3-axis PCR lab + KAMIR backbone 3개를 1회 구축하면 4-trial 인프라 의존 동시 해소.

---

## ◆ 3-axis stratification — 채혈 1회 panel (X9 §5 · 최고 임상 leverage)

```
   ALDH2*2 (rs671, 동아시아 ~40%)    CYP2C19 LoF (IM+PM ~60%)    Lp(a) high (≥50, ~12-13%)
   NO↓ · IRI 악화                   clopidogrel 효과 저하        잔여 위험 평생 결정
        │                                │                              │
        ▼ Trial-A PRIMARY axis          ▼ Trial-B PRIMARY axis         ▼ Trial-D PRIMARY axis
   ┌──────────────────────── 단일 PCI 입원 채혈 1회 + PCR panel ──────────────────────┐
   │  CYP2C19 PCR = C5946 선별급여 + Lp(a) routine + ALDH2*2 (선택)                    │
   │  → N4·N5·D1·D4·L1·L2 6 wall 동시 stratify · 기존 NHIS 급여 안 배포               │
   │  → 글로벌 미시도 differentiator = KIV-2 copy stratified + ALDH2*2 enrichment      │
   └──────────────────────────────────────────────────────────────────────────────────┘
```

→ 한국인은 3축 동시 보유 확률이 비-동아시아 대비 현저히 높음 → 채혈 1회로 4-trial stratification 입력 동시 확보.

---

## ◆ 규제 lift 순위 (X5 §5.3)

```
B. DAPT-PGx-K   ░░░░░░░░░░  최저 — PCR 급여 + 약제 재배치 (즉시)
A. NICORADENO   ████░░░░░░  중 — 약물 IND 불요, but CMR/IMR consortium lift
C. ROCK-DCB     ██████░░░░  중-고 — MFDS device IND (PMDA cross-recog 로 완화)
D. siRNA-K      ██████████  최고 — siRNA 신규 승인 + NHIS RSA 협상 (글로벌 readout 의존)
```

---

## ◆ verify verdict verbatim (설계 가정과 분리 · X5 §6)

| trial | 정량 항목 | verdict (verbatim) |
|---|---|---|
| A | primary continuous power @ n=500 | **0.798 (≈0.80, within 0.3%) — 🟢** |
| A | Cox 1y MACE HR 0.75 @ n=500 | **0.157 — 🟠 (secondary only)** |
| A | ALDH2\*2 subgroup (n=201) | **0.654 — 🟠 (exploratory only)** |
| B | CYP2C19 PM freq | **0.1521 (cited 0.14-0.15) — 🟢 (exact)** |
| B | IM+PM 합 | **0.6279 (cited 0.60) — 🟢 (within)** |
| B | S4 ICER (M KRW/QALY) | V5 **-503 (cited +34) — 🟠 DEFERRED (sign 미반전)** |
| D | Schoenfeld events (HR 0.80, 90%) | **D=844 (anticipated 920, adequate) — 🟢** |
| D | MR/IVW β (Lp(a)→CHD 인과) | **-0.3413 (Burgess -0.34249, Δ0.0012) — 🟢** |
| D | NHIS ICER WTP pass rate | **0% (양 threshold, 387-645× 약가) — 🟢** |
| C | fasudil-DCB IIT-1 전체 설계 | **verify verdict 부재 — ⚪ proposal** (fasudil porcine NH 40-50%↓ = 🟡 cite) |

---

## ◆ H6 grade 종합

- power (A 0.798 · D 842/844) · genotype freq (B 0.1521) · MR β (D -0.3413) · NHIS 0% = sub-V 🟢 verbatim. ICER (B V5 -503) = 🟠. 추정 n · 효과크기 가설 · 시너지 = ⚪ proposal.
- 즉시 시작: **B. DAPT-PGx-K** (신규 IND 불요) · 최고 임상 leverage = 채혈 1회 3-axis panel.

**H6 종합**: 🟡 SUPPORTED-BY-CITATION (compositional) — X5 portfolio + X9 §5 verdict VERBATIM 압축. 새 판정 0건 (per @D g5).
