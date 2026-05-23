# M4 — siRNA 후보 3-way: olpasiran · lepodisiran · zerlasiran

> 마일스톤 M4 산출물 · current-state · no history.
> 출처 = NEJM/JAMA Ph2 + clinicaltrials.gov (Ph3 진행) → 🟡 SUPPORTED-BY-CITATION (Ph2) · 🟠 INSUFFICIENT/DEFERRED (Ph3 outcome).

---

## 1. siRNA 기전 — RISC catalytic + GalNAc 간 표적화

**siRNA** = 21-23 nt 이중가닥 RNA. **RISC** (RNA-induced silencing complex)에 탑재 → guide strand가 표적 mRNA에 상보 결합 → **Argonaute-2 (Ago2) 절단** → mRNA degradation.

```
   siRNA (21-23 nt 이중가닥)
        │
        ▼  RISC loading
   ┌──────────────────┐
   │  RISC + Ago2     │  ◀── guide strand
   │  (catalytic)     │
   └────────┬─────────┘
            │  반복 결합 + 절단
            ▼
   LPA mRNA ─[절단]─▶ degraded ─▶ apo(a) 합성 ↓
        │
        └─ RISC 재사용 → 1개 siRNA가 수천 mRNA 분해 (catalytic)
```

→ **vs ASO**: ASO는 RNase H1 매개 1:1 stoichiometric (그림자), siRNA는 **catalytic** → **지속성 압도적 우위** (Q4W → Q12W~Q24W).

**GalNAc 컨쥬게이션**: 3중 N-acetylgalactosamine → **ASGPR** (간세포 표면 수용체) 결합 → 간세포 특이적 흡수 (LPA mRNA 발현 = 간 100%). SC 투여 → 간 90% 이상 분포.

**플랫폼**: Alnylam (GalNAc + 화학수식 ESC+) · Arrowhead (TRiM™) · Silence (mxRNA).

---

## 2. olpasiran (Amgen, AMG-890)

- **발견·라이선스**: Arrowhead 발견 (ARO-LPA) → 2016 Amgen 라이선스
- **분자**: GalNAc-siRNA, 화학수식 표준, SC 투여
- **투여**: 75-225 mg SC **Q12W** (12주 1회) — Ph2 최적
- **Ph2 OCEAN(a)-DOSE** (281명, NCT04270760)
  - 48주: Lp(a) **-95% to -101%** (placebo-adjusted) at 225 mg Q12W
  - 36주 도달 peak ~**98% 감소**
  - 부작용: 주사부위 반응 mild, ALT 정상 범위 유지
  - 출처: O'Donoghue ML et al. *NEJM* 2022;387:1855
- **Ph3 OCEAN(a)-Outcomes** (NCT05581303)
  - 7,297명 (2차 예방 — ASCVD + Lp(a) ≥ 200 nmol/L)
  - Primary: CHD death + MI + urgent coronary revascularization
  - 상태: **Active, not recruiting** · primary completion **2026-12**
  - Readout: 2027 상반기 예상
- **신규**: **OCEAN(a)-PreEvent** (NCT07136012) — **1차 예방** 확장 트라이얼 (high Lp(a) 무증상자)

---

## 3. lepodisiran (Eli Lilly, LY3819469)

- **발견·라이선스**: Dicerna → Novo Nordisk 인수 (2021) → Lilly 자체 개발 (Dicerna 별도 자산)
- **분자**: GalNAc-siRNA, **ultra-long-acting** (화학수식으로 안정성 극대화)
- **투여**: 16-608 mg SC **single dose → 48-60주 효과 지속** (6-12개월 1회)
- **Ph1** (Nissen SE et al. *JAMA* 2023;330:2075)
  - single dose ~98% Lp(a) 감소 at 60일, 60주 시점 **-94%** 유지
- **Ph2 ALPACA** (Nissen SE et al. *NEJM* 2025) — Ph3 직전 dose-finding 완료
  - 60주 시점 Lp(a) **-94% (peak ~98%)**, single + repeat dose 비교
- **Ph3 ACCLAIM-Lp(a)** (NCT06292013)
  - 12,500명 (ASCVD or high-risk + Lp(a) ≥ 175 nmol/L)
  - Primary: MACE (CV death + nonfatal MI + nonfatal stroke + urgent coronary revasc), 4.5년 추적
  - 상태: 모집 중 · 완료 예상 **2029**

→ 핵심 차별점: **6-12개월 1회 dosing** — adherence 게임 체인저 후보.

---

## 4. zerlasiran (Silence Therapeutics, SLN360)

- **발견**: Silence 자체 (mxRNA 플랫폼)
- **분자**: GalNAc-siRNA, 다른 컨쥬게이션 화학
- **투여**: 300-450 mg SC **Q16W or Q24W**
- **Ph1** (Nissen SE et al. *JAMA* 2023;330:2075 — 함께 보고)
- **Ph2 ALPACAR-360** (178명, NCT05537571)
  - 36주: Lp(a) **>80% time-averaged 감소** (placebo-adjusted)
  - 48주: peak ~**90% 감소** · 60주까지 효과 잔존
  - 출처: Silence Therapeutics 36-week/48-week topline (2024)
- **Ph3**: registrational program 계획 발표 (구체 NCT 미공개, 2025-2026 개시)

→ 후발 주자지만 dosing 빈도 (Q24W) + Ph2 deep reduction은 경쟁력.

---

## 5. 3-way 비교 — 핵심 표

| 항목 | **olpasiran** | **lepodisiran** | **zerlasiran** |
|---|---|---|---|
| **회사** | Amgen (← Arrowhead) | Eli Lilly | Silence Therapeutics |
| **코드** | AMG-890 | LY3819469 | SLN360 |
| **투여 빈도** | SC **Q12W** | SC **Q24-48W (6-12개월 1회)** | SC **Q16W or Q24W** |
| **Lp(a) ↓ (Ph2 peak)** | **~98%** | **~94% (60주)** | **~80-90%** |
| **Ph2 trial** | OCEAN(a)-DOSE | ALPACA | ALPACAR-360 |
| **Ph2 n** | 281 | ~320 | 178 |
| **Ph3 trial** | **OCEAN(a)-Outcomes** (2차예방) + OCEAN(a)-PreEvent (1차) | **ACCLAIM-Lp(a)** | TBD (계획 단계) |
| **Ph3 NCT** | NCT05581303 · NCT07136012 | NCT06292013 | — |
| **Ph3 n** | 7,297 | 12,500 | — |
| **Ph3 readout** | **2026-12 ~ 2027 상반기** | **2029** | 2028+ |
| **Primary endpoint** | CHD death + MI + urgent revasc | MACE (CV death + MI + stroke + revasc) | TBD |
| **한국 site** | 미확인 (글로벌 multi-site → 가능성 ↑) | 미확인 | — |

```
Ph3 readout timeline (대략)
──────────────────────────────────────────────────────────
 2026 ────────────┬───────────────────────────────────────
                  ▼ OCEAN(a)-Outcomes (olpasiran)
 2027 ────────────┤ ← Lp(a) outcome 첫 readout
                  │
 2028 ────────────┤ zerlasiran Ph3 readout?
                  │
 2029 ────────────▼ ACCLAIM-Lp(a) (lepodisiran)
                                ← MACE outcome 종합
──────────────────────────────────────────────────────────
```

→ **olpasiran이 first-to-readout** (2027) → 이 결과가 Lp(a) lowering = MACE 감소 인과의 첫 RCT 증거가 됨 → 전체 분야 분기점.

---

## 6. vs pelacarsen (ASO, M3) — siRNA 우위

| 축 | pelacarsen (ASO) | siRNA (3분자 평균) |
|---|---|---|
| **기전** | RNase H1 매개 1:1 stoichiometric | RISC catalytic (1개가 다회 절단) |
| **투여 빈도** | SC Q4W | SC **Q12W ~ Q24-48W** |
| **Lp(a) ↓** | -80% | **-90 ~ -98%** |
| **지속성** | dosing 중단 시 빠르게 회복 | dosing 중단 후에도 ~60주 효과 |
| **임상 진척** | HORIZON Ph3 (2025 readout 예상) | OCEAN(a) 2027 · ACCLAIM 2029 |

**siRNA 우위**: (i) dosing frequency · (ii) deep reduction (-95% vs -80%) · (iii) **catalytic 지속성**.
**ASO 우위**: (i) Ionis 플랫폼 임상 경험 더 김 · (ii) 더 빠른 Ph3 readout.

→ ASO와 siRNA는 **시간차로 순차 readout** → 임상의는 outcome 데이터 + adherence 트레이드오프로 선택. Lp(a) lowering = MACE 인과는 어느 한쪽이 먼저 증명하면 class effect로 확장 추정.

---

## 7. 한국 임상 site

- **OCEAN(a)-Outcomes**: clinicaltrials.gov 공식 사이트 리스트 직접 조회 필요 (WebSearch 결과 명시 site 미확인). 그러나 7,297명 글로벌 multi-site (북미·유럽·아시아) → 한국 site 포함 가능성 ↑ (이전 Amgen evolocumab FOURIER 시 다수 한국 site).
- **ACCLAIM-Lp(a)**: 12,500명 글로벌 → 한국 site 포함 가능성 ↑ (Lilly 한국 임상 활성).
- **확인 필요**: M8 통합 시 clinicaltrials.gov XML 직접 파싱으로 한국 site 리스트 추출.

→ 🟠 INSUFFICIENT — site별 정밀 정보는 M8에서 확정.

---

## 8. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| siRNA RISC catalytic 기전 | 🔵 SUPPORTED-FORMAL | 분자생물학 정설 |
| GalNAc-ASGPR 간 표적 | 🟡 SUPPORTED-BY-CITATION | Nair JK et al. *JACS* 2014 |
| olpasiran -98% (Ph2) | 🟡 SUPPORTED-BY-CITATION | O'Donoghue *NEJM* 2022 |
| lepodisiran -94% at 60주 | 🟡 SUPPORTED-BY-CITATION | Nissen *JAMA* 2023 |
| zerlasiran -80-90% | 🟡 SUPPORTED-BY-CITATION | Silence topline 36W/48W |
| **Ph3 outcome (MACE 감소)** | **🟠 INSUFFICIENT/DEFERRED** | OCEAN(a) 2027 · ACCLAIM 2029 대기 |
| 한국 site 참여 | 🟠 INSUFFICIENT/DEFERRED | clinicaltrials.gov 직접 파싱 (M8) |

🔑 핵심 통찰:
- **olpasiran -98%** (Ph2 peak) = 3분자 중 최강 reduction · **first-to-Ph3-readout (2027)** = 분야 분기점
- **lepodisiran** = **6-12개월 1회** dosing → adherence 게임체인저, 단 readout 2029로 늦음
- 3분자 모두 **siRNA RISC catalytic** 공통 기반 → outcome 입증되면 **class effect**로 확장
- Lp(a) lowering = MACE 감소 인과의 **첫 RCT 증거**는 OCEAN(a)-Outcomes (2027)에서 출현 예상

---

## 9. 참고문헌

- O'Donoghue ML et al. (2022) *NEJM* 387:1855 — **olpasiran Ph2 OCEAN(a)-DOSE** (-95%)
- Nissen SE et al. (2023) *JAMA* 330:2075 — **lepodisiran Ph1** + zerlasiran 함께
- Nair JK et al. (2014) *J Am Chem Soc* 136:16958 — GalNAc-siRNA 플랫폼 원리
- Silence Therapeutics (2024) — ALPACAR-360 36/48주 topline
- Tsimikas S, Stroes ESG (2024) *Eur Heart J* — Lp(a) silencing 분야 리뷰
- NCT05581303 — OCEAN(a)-Outcomes (clinicaltrials.gov)
- NCT07136012 — OCEAN(a)-PreEvent (1차 예방 확장)
- NCT06292013 — ACCLAIM-Lp(a)
