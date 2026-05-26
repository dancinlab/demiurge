# M6 — off-target / long-term immune 안전성

> 마일스톤 M6 산출물 · current-state · no history.
> ASO/siRNA Lp(a) 침묵화의 두 안전성 축 정리 — (A) Lp(a) ↓ 자체의 미지 후유증 · (B) 약물 클래스 toxicity.

---

## 1. 우려의 2축 — target vs platform

```
   ┌─────────────────────────────────────────────────────────┐
   │              안전성 우려 2축 매트릭스                    │
   ├──────────────────────┬──────────────────────────────────┤
   │   축 A (target)      │   축 B (platform / drug class)   │
   │   Lp(a) ↓ 자체의     │   ASO · siRNA · GalNAc           │
   │   미지 후유증        │   off-target / immune / hepatotox│
   ├──────────────────────┼──────────────────────────────────┤
   │  Mendelian 증거 강함 │  Ph2 OK · 장기 (>5y) 미관찰       │
   │  → null carrier 안전 │  → inclisiran을 가장 가까운        │
   │  (KIV-2 high copy)   │     marketed analog로 활용         │
   └──────────────────────┴──────────────────────────────────┘
```

→ 축 A는 **Mendelian randomization으로 강한 안전 보증** · 축 B는 **장기 누적 미관찰**이 핵심 미지.

---

## 2. Lp(a)의 진화적 역할 — 축 A 안전 근거

- Lp(a)는 **인간 + 구세계 원숭이** (~40 Mya 분기)에만 존재 — 다른 포유류 없음
- 진화적 기능 가설:
  - **wound-healing** — plasminogen homolog → 손상 부위 피브린 결합
  - **innate immunity** — LPS scavenger (apo(a) OxPL 결합)
  - **임신 / placenta** — apo(a) 태반 발현
- 그러나 진화 가설은 **모두 약함** — 명확한 필수 기능 부재

### null carrier 자연실험 (Mendelian randomization)

```
   인구 10%        KIV-2 high copy        Lp(a) nondetectable
   ─────────  →  ─────────────────  →   (< 1 mg/dL)
   (lifelong null)                            ↓
                                       부정 표현형 없음
                                       CV 보호 강함
```

- **KoGES + UK Biobank** Mendelian 분석: Lp(a) lifelong null = CV 보호 + **알려진 부정 표현형 거의 없음**
- → **Lp(a) ↓ 자체는 lifelong null phenotype과 동등 → 안전 강한 보증** (축 A 결론)

---

## 3. ASO 클래스 toxicity (pelacarsen 맥락)

| 위험 | 빈도 | 메커니즘 | 비고 |
|---|---|---|---|
| **flu-like reaction** | ~30% (Q4W 24-48h) | TLR9 · cytokine | Ph2 자주 |
| **platelet drop** (< 50K) | rare | inotersen REMS 사례 | pelacarsen Ph2 신호 없음 |
| **renal** (proximal tubular) | rare | volanesorsen 사례 | GalNAc-ASO는 hepatocyte 좁아짐 → 신호 낮음 |
| **hepatotoxicity** (ALT ↑) | ~5% | GalNAc-ASO 클래스 | 대부분 무증상 · 가역 |
| **항-PEG / 항-약물 항체** | 장기 | 면역원성 | 효과 감소 위험 |

→ pelacarsen은 **GalNAc 컨쥬게이트 → hepatocyte 좁힘** = 1세대 ASO (volanesorsen · inotersen) 대비 안전성 개선.

---

## 4. siRNA 클래스 toxicity (olpasiran · lepodisiran · zerlasiran)

### inclisiran (PCSK9 siRNA, Leqvio) = 가장 가까운 marketed analog

- ORION-9/10/11 종합 — n > 3,600 · 1.5년 follow-up
- ALT/AST 시그널 **미미** · 주사 부위 반응 (~5%) · severe AE 차이 없음
- → **GalNAc-siRNA 플랫폼 안전성 패러다임 확립** — Lp(a) siRNA에 직접 외삽 가능

### olpasiran Ph2 (OCEAN(a)-DOSE)

- major safety signal **없음** · LSR 빈도 위약과 유사
- ALT ↑ 신호 거의 없음

### 잠재 우려 — long-acting siRNA 회수 불가능성

```
   ASO Q4W       →  중단 → 1-2개월 → washout      (회수 high)
   siRNA Q12W    →  중단 → 3-6개월 → washout      (회수 mid)
   siRNA Q24W    →  중단 → 6-12개월 → washout     (회수 low)
   lepodisiran   →  1회 → 1년+ 지속 → 회수 어려움 (회수 매우 낮음)
```

→ idiosyncratic 부작용 발생 시 **약효 reversal 불가** = lepodisiran 장기 dosing의 핵심 우려.

---

## 5. immune sensitization 장기 위험

- **GalNAc 자체** (carbohydrate ligand) — ASGPR 자연 ligand → 항체 형성 가능성 작음
- **apo(a) ↓ → innate immunity 약화?** — 이론적 (LPS scavenger 가설) · 임상 증거 없음
- **누적 노출** — 매년 1-2회 주사 평생 = 10-30년 누적 효과 **미관찰**
- siRNA/ASO Ph3 follow-up ~5년 (HORIZON · OCEAN(a)) → 10-30년 안전성은 시판 후 long-term registry로 확인 필요

---

## 6. 임신 / 가임 여성

- 모든 Ph2/3 시험 **제외군** (pelacarsen · olpasiran · lepodisiran · zerlasiran)
- Lp(a)는 placenta 발현 — siRNA가 태반 통과 불명확하지만 **보수적 회피**
- 가임 여성 처방 시 dosing 중단 → washout 기간 (siRNA Q24W는 1년+) → 임신 timing 제약

---

## 7. 한국인 ethnicity-specific 신호

- **inclisiran 한국 시판 후 안전 데이터** — KSoLA registry 보고 (시그널 미미)
- pelacarsen / olpasiran 한국 site 참여 (KBR 2021 reported) — outcome 발표 후 sub-analysis 가능
- 한국인 특이 신호 (CYP · DPD 등) — Lp(a) siRNA는 hepatocyte uptake 경로 (ASGPR) → ethnicity 변동성 낮음

---

## 8. reversal & rescue 비교

| 약제 | dosing | reversal 시간 | 회수가능성 |
|---|---|---|---|
| pelacarsen ASO | Q4W | 1-2 개월 | **high** |
| olpasiran siRNA | Q12W | 3-6 개월 | mid |
| zerlasiran siRNA | Q12-24W | 6-9 개월 | mid |
| **lepodisiran siRNA** | Q24-48W | **1년+** | **low** |

→ idiosyncratic AE 발생 시 ASO > short-siRNA > long-siRNA 순으로 안전 마진.

---

## 9. 안전성 종합 격자 (핵심 deliverable)

| 약제 | acute (Q1m) | chronic (Q12m) | 회수가능 | Mendelian 지지 |
|---|---|---|---|---|
| **pelacarsen ASO** | flu-like ~30% | ALT 5% | **high** (Q4W) | ✅ |
| **olpasiran siRNA** | LSR ~10% | minimal | mid (Q12W) | ✅ |
| **lepodisiran siRNA** | LSR ~10% | unknown (Q24W+) | **low** (6-12m) | ✅ |
| **zerlasiran siRNA** | LSR ~15% | minimal | mid (Q12-24W) | ✅ |

→ **Mendelian null carrier 증거가 4분자 공통의 강한 안전 보증** — 표적 자체는 안전.
→ **lepodisiran chronic 효과는 unknown · 회수 어려움** = 가장 큰 platform 우려.

---

## 10. verify rubric

| 항목 | 등급 | 근거 |
|---|---|---|
| Mendelian null carrier 안전성 (축 A) | 🟡 SUPPORTED-BY-CITATION | Kronenberg 2022 · Boerwinkle Mendelian · UK Biobank |
| Ph2 acute safety (4분자) | 🟡 SUPPORTED-BY-CITATION | Tsimikas NEJM 2020 · O'Donoghue NEJM 2022 · Nissen JAMA 2023 |
| inclisiran 안전 외삽 (siRNA 플랫폼) | 🟡 SUPPORTED-BY-CITATION | ORION-9/10/11 (Ray NEJM 2020) |
| Long-term chronic (10년+) | 🟠 INSUFFICIENT/DEFERRED | Ph3 follow-up ~5년 · 시판 후 registry 필요 |
| 한국인 sub-population 안전 | 🟠 DEFERRED | KSoLA inclisiran registry만 · pelacarsen/olpasiran 한국 sub-analysis 대기 |
| Long-acting reversal 우려 (lepodisiran) | 🟠 INSUFFICIENT/DEFERRED | Q24-48W washout 임상 데이터 부족 |

---

## 11. 참고문헌

- Kronenberg F et al. (2022) *Eur Heart J* 43:3925 — EAS consensus · Lp(a) null carrier 안전
- Boerwinkle E et al. (1992) *J Clin Invest* 90:52 — KIV-2 copy ↔ Lp(a) Mendelian
- Tsimikas S et al. (2020) *NEJM* 382:244 — pelacarsen Ph2 safety
- O'Donoghue ML et al. (2022) *NEJM* 387:1855 — olpasiran Ph2 OCEAN(a)-DOSE safety
- Nissen SE et al. (2023) *JAMA* 330:2075 — lepodisiran Ph1 safety
- Ray KK et al. (2020) *NEJM* 382:1507 — ORION-10/11 inclisiran (PCSK9 siRNA) 안전 외삽
- Witztum JL et al. (2019) *NEJM* 381:531 — volanesorsen renal · platelet (ASO 1세대)
- Benson MD et al. (2018) *NEJM* 379:22 — inotersen platelet REMS (ASO 1세대)

---

🔑 핵심 통찰:
- **축 A (target) 안전 강한 Mendelian 보증** — KIV-2 high copy null carrier ~10% 인구가 lifelong null + CV 보호 + 부정 표현형 없음 = Lp(a) ↓ 자체는 안전
- **축 B (platform) 핵심 미지 = long-acting siRNA (lepodisiran) reversal 불가능** — Q24-48W dosing 1년+ washout → idiosyncratic AE 발생 시 회수 어려움
- **inclisiran (PCSK9 siRNA, Leqvio) ORION 데이터가 GalNAc-siRNA 플랫폼 안전 패러다임 확립** → Lp(a) siRNA에 직접 외삽
- 10-30년 누적 안전성 + 한국인 sub-population 안전 = 시판 후 long-term registry (KSoLA) 필요
