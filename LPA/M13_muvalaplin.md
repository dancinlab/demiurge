# M13 — muvalaplin (oral small molecule · LY3473329)

> 마일스톤 M13 산출물 · current-state · no history.
> 출처 = Nicholls 2023 JAMA (Ph1) · Nissen 2025 JAMA (KRAKEN Ph2) · ClinicalTrials.gov · /gap P1 oral-SM 보강.
> R1 §3 발견(-85.8% intact assay) + M8 Tier-3 wild-card 정식 doc 화.

---

## 1. 분자 — Lilly LY3473329 / muvalaplin

| 속성 | 값 |
|---|---|
| 발견 / 개발 | **Eli Lilly** (단독) |
| 모달리티 | **oral small molecule** (1일 1회 경구) |
| 표적 | **apo(a) ↔ apoB-100 lysine binding site** (KIV-7 / KIV-8 strong-LBS) |
| 작용 시점 | **pre-secretory** — 간세포 분비 전 Lp(a) 입자 조립 차단 |
| 분자량 | ~600 Da급 (정확값 IR 미공개) |
| PK | t½ ~70-100 h (Ph1) · 정상상태 14-21일 |

### 1.1 기전 — lysine binding site 점유 (LBS-blocker)

```
   apoB-100 (LDL) ─── Lys(K) 잔기 (다수)
                          │
                          │ ❌  apo(a) KIV-7/8 strong LBS
                          ▼   ↑ muvalaplin이 LBS 점유 → 결합 차단
   apo(a)  ────────────KIV-2─KIV-7─KIV-8─KIV-9─KIV-10─protease
                                  ↑
                          muvalaplin (small molecule)
                          orthosteric binding pocket

   결과: apoB-100 · apo(a) 공유결합 disulfide bridge 형성 불능
         → Lp(a) 입자 자체가 만들어지지 않음 (pre-secretory)
         → 유리 apo(a) + LDL은 정상 순환
```

→ **M3/M4 (ASO/siRNA) post-secretory mRNA 침묵화와 작용 시점 본질적 차이**
   - ASO/siRNA: 간 hepatocyte 내 apo(a) **단백 합성 차단** → Lp(a) 입자 형성 못함
   - muvalaplin: 단백은 만들어지지만 **입자 조립 차단** → 자유 apo(a) 일부 순환 (assay 차이의 원인)

---

## 2. Ph1 (Nicholls 2023 JAMA) — NCT04472676

| Arm | 결과 |
|---|---|
| SAD 1-800 mg | 안전 · max Cmax 800 mg에서 dose-proportional |
| MAD 30-800 mg × 14 d (healthy) | Lp(a) **-63 to -65%** (conventional assay) |
| Open-label ASCVD (n=16) | Lp(a) -52 to -66% (baseline 60-105 nmol/L) |

→ 안전성: GI mild (오심/설사) · 간 ALT mild grade 1 · DDI signal 미관찰
→ 결과 published *JAMA* 2023;330:1042-53.

---

## 3. Ph2 KRAKEN — NCT05563246 (Nissen 2025 JAMA)

### 3.1 디자인

| 항목 | 값 |
|---|---|
| 등록 | **n=233** · 43 sites · 5 countries |
| 자격 | Lp(a) ≥ 175 nmol/L (≈ 70 mg/dL) · ASCVD or 고위험 |
| Arms | placebo · 10 mg QD · 60 mg QD · **240 mg QD** |
| 기간 | **12 weeks** double-blind |
| Primary | Δ Lp(a) at 12 w (**intact assay** primary · conventional secondary) |

### 3.2 결과 (placebo-adjusted)

| dose | **intact assay** (primary) | conventional apo(a) assay |
|---|---|---|
| 10 mg | **-47.6%** | -40.4% |
| 60 mg | **-81.7%** | -70.0% |
| 240 mg | **-85.8%** | -68.9% |

→ **intact assay 우월** — conventional assay는 유리 apo(a) (입자 미형성)까지 측정 → 진짜 Lp(a) 감소 과소평가
→ Lilly + KRAKEN steering committee: intact assay가 muvalaplin 기전과 정합
→ ⚠ **assay 표준화 미완성** — pelacarsen/olpasiran은 conventional assay 사용 → 직접 % 비교 부적절

### 3.3 안전성

- GI mild (오심/복부 불편) dose-dependent
- ALT >3×ULN: muvalaplin 4건 vs placebo 1건 (small numbers, not significant)
- SAE: muvalaplin 군 5건 (treatment-unrelated adjudicated)
- 약물 중단: drug-related ~3% (240 mg arm)

→ 출처: Nissen et al. *JAMA* 2025;333:222-31 ("Oral Muvalaplin for Lowering of Lipoprotein(a)")

---

## 4. Ph3 MOVE-Lp(a) — NCT07157774

| 항목 | 값 |
|---|---|
| Acronym | **MOVE-Lp(a)** |
| Sponsor | Eli Lilly |
| 등록 상태 | **Recruiting** (as of 2026-02) |
| Primary endpoint | **MACE** (CV death · MI · stroke · urgent coronary revascularization) |
| 자격 | Elevated Lp(a) + ASCVD or high-risk |
| 모달리티 비교 | pelacarsen HORIZON readout 예상 2026, olpasiran OCEAN(a) readout 2026 → muvalaplin **Ph3 MACE readout ~2029-30 추정** |

→ pelacarsen/olpasiran보다 Ph3 약 2-3년 지연 (oral SM 후발) — 만약 Q4-2026 HORIZON null → muvalaplin이 다음 oral 옵션으로 부각

---

## 5. vs 다른 모달리티 — 작용 시점 + adherence

| 분자 | 모달리티 | 투여 | Lp(a) 저감 | 작용 시점 | adherence |
|---|---|---|---|---|---|
| **pelacarsen** | ASO + GalNAc | 80 mg SC **Q4W** | ~-80% (conv) | post-secretory · stoichiometric | 월 1회 주사 |
| **olpasiran** | siRNA + GalNAc | 75-225 mg SC **Q12W** | ~-95% (conv) | post-secretory · **catalytic** RISC | 3개월 1회 주사 |
| **lepodisiran** | siRNA + GalNAc | SC Q24W (target) | ~-94% (conv) | post-secretory · catalytic | 6개월 1회 주사 |
| **muvalaplin** | **oral SM** | 240 mg PO **QD** | -85.8% (intact) / -69% (conv) | **pre-secretory** · LBS 점유 | **매일 경구** |

→ trade-off:
   - **adherence**: 경구 매일 < 주사 분기/반년 1회 (실생활 compliance 우려)
   - **편의성**: 경구 매일 > 주사 (자가 주사 거부감 없음 · 한국 노인 인구)
   - **신속 중단**: 경구는 중단 시 ~7일 내 효과 소실 (siRNA 6개월 잔존 대비 안전성 advantage)
   - **assay 비교 미해결**: -85.8% intact vs -95% conv 직접 비교 불가

---

## 6. 한국 site / NHIS 시나리오

### 6.1 한국 site 가능성

- KRAKEN Ph2: 5개국 · 한국 site 미포함 (US 중심)
- Ph3 MOVE-Lp(a): Lilly Korea CV 파이프라인 존재 (tirzepatide) → 한국 site 추가 합리적 추정
- **KSoLA 2026 Position Paper** (≥50 mg/dL screening) → 한국인 환자 풀 식별 인프라
- 추정 경로: Lilly Korea + KSoLA consortium → Seoul/Yonsei/SNUH/Asan 중심 site

### 6.2 약가 시나리오 (경구 SM)

| 모달리티 | 추정 연 약가 | 한국 NHIS WTP25M 대비 | 출처 |
|---|---|---|---|
| pelacarsen ASO | ~$10-12K/yr | break-even $17.8/yr × **560-670배** | V3c |
| olpasiran siRNA | ~$11.5K/yr | × **645배** | V3c |
| **muvalaplin oral SM** | **~$2-4K/yr (추정)** | × **112-225배** | M13 추정 |

→ 경구 SM은 일반적으로 주사 생물의약품 대비 **1/3 ~ 1/5 약가** (참조: PCSK9 SM AZD0780 개발 중)
→ V3c break-even $17.8/yr 대비 여전히 100-200× 격차 — 그러나 siRNA 400-650× 대비 **2-4배 개선**

---

## 7. catalytic × stoichiometric × pre/post-secretory 3-축 격자

```
                          pre-secretory          post-secretory
                          (입자 형성 차단)        (mRNA 침묵화)
                       ┌──────────────────┬──────────────────┐
  catalytic            │                  │                  │
  (1 효소 → N substr)  │     ─ 없음 ─     │   siRNA-RISC     │
                       │                  │  (olpasiran ·    │
                       │                  │   lepodisiran)   │
                       ├──────────────────┼──────────────────┤
  stoichiometric       │   muvalaplin     │  ASO-RNase H1    │
  (1:1 결합 / 절단)    │  (oral SM · LBS) │   (pelacarsen)   │
                       │  ← M13 ─────────│                  │
                       └──────────────────┴──────────────────┘
                          ↑
                  유일한 경구 옵션 · 입자 조립 차단 · assay 차이 원인
```

→ **muvalaplin = pre-secretory + stoichiometric** = 격자상 유일 점유
→ assay 차이(intact vs conv) 본질: pre-secretory 차단 시 유리 apo(a) 잔존 → conv assay가 이를 측정 → % 저감 작아 보임 → intact assay가 mechanism-faithful

---

## 8. verify rubric

| 주장 | tier | 근거 |
|---|---|---|
| KRAKEN Ph2 240 mg -85.8% intact | 🟡 SUPPORTED-BY-CITATION | Nissen 2025 JAMA |
| Ph1 -63 to -65% (MAD) | 🟡 SUPPORTED-BY-CITATION | Nicholls 2023 JAMA |
| pre-secretory LBS 차단 기전 | 🟡 SUPPORTED-BY-CITATION | KRAKEN discussion + Lilly IR |
| Ph3 MOVE-Lp(a) NCT07157774 recruiting | 🟡 SUPPORTED-BY-CITATION | ClinicalTrials.gov 2026-02 |
| Ph3 MACE readout ~2029-30 | 🟠 INSUFFICIENT/DEFERRED | enrollment 진행 중 · 정확 readout 미공개 |
| intact vs conv assay 표준화 미완성 | 🟡 SUPPORTED-BY-CITATION | Nissen 2025 + Vuorio ATM commentary |
| 경구 약가 $2-4K/yr | 🟢 산술 추정 | SM 일반 가격대 1/3-1/5 of biologic |
| NHIS 100-200× 격차 | 🟢 산술 | V3c break-even $17.8 × (2-4K) |
| 한국 site 가능성 | 🟠 INSUFFICIENT/DEFERRED | KSoLA + Lilly Korea 정황 only |

---

## 9. M8 통합 ranking 영향

### 9.1 Tier 갱신 시그널

- **현재**: M8 후보 Tier-3 wild-card (Ph2 단계 + oral 신규성)
- **Ph3 MOVE-Lp(a) 양성 시**: → **Tier-2 mainline candidate** (pelacarsen/olpasiran과 동급)
- **양성 readout 가정 시점**: 2029-30 → 한국 NHIS 등재 시나리오 2031+

### 9.2 HORIZON 시나리오 분기 (R2 기반)

| HORIZON pelacarsen 결과 (2026 Q4 예상) | muvalaplin 위상 |
|---|---|
| **A. 양성 (MACE -15% 이상)** | ASO/siRNA 우선 · muvalaplin 보조 (adherence 환자) |
| **B. borderline (-5 ~ -15%)** | 격자 분할 · muvalaplin = 경구 옵션 |
| **C. null (-5% 미만)** | **HORIZON null → muvalaplin이 격자 빈자리 채움** · oral SM 모달리티 재평가 |

→ 시나리오 C가 가장 muvalaplin upside — 주사 모달리티 효력 의심 시 경구 SM이 mainline 후보로 격상

### 9.3 한국 임상 적용 advantage (M8 input)

- **노인 환자 adherence**: 경구 매일 > 주사 (Asian 65+ 인구 자가 주사 거부감 ↑)
- **NHIS 등재 협상**: 경구 SM 약가 협상력 > 생물의약품 (참조: PCSK9 SM 협상 트랙)
- **신속 중단 안전성**: 임신/수술 전 단기 wash-out 가능 (siRNA 6개월 vs 경구 7일)

---

## 10. open questions (M8 / 후속 도메인)

1. **intact assay 표준화** — IFCC/CDC reference 채택 시점 (Ph3 primary endpoint 영향)
2. **DDI profile** — CYP3A4 substrate 여부 (한국인 polypharmacy 환자 영향)
3. **장기 안전성** — 12주 KRAKEN beyond, lysine binding 다른 단백 off-target 가능성 (plasminogen LBS 유사성 — 출혈 risk theoretical concern, KRAKEN에서 미관찰)
4. **고용량 ceiling** — 240 mg에서 -85.8%, 더 높은 용량 plateau 여부
5. **Ph3 한국 site 실제 포함 여부** — Lilly Korea CV 파이프라인 확장 시그널 추적

---

## 11. 참고문헌

1. Nicholls SJ et al. **Muvalaplin, an oral small molecule inhibitor of lipoprotein(a) formation** — Ph1 SAD/MAD. *JAMA* 2023;330:1042-53.
2. Nissen SE et al. **Oral Muvalaplin for Lowering of Lipoprotein(a): A Randomized Clinical Trial** — KRAKEN Ph2. *JAMA* 2025;333:222-31.
3. Vuorio A, Kovanen PT. **Promising results with the daily oral small molecule lipoprotein(a) inhibitor, muvalaplin** — commentary. *Ann Transl Med* 2025.
4. ClinicalTrials.gov NCT04472676 (Ph1) · NCT05563246 (KRAKEN Ph2) · **NCT07157774 (MOVE-Lp(a) Ph3 · recruiting)**.
