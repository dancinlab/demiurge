# LPA — log

Append-only history sister of `LPA.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-24T22:40:00Z — M7 잔여 위험 정량 완료

- [x] §1 정량 프레임워크 (MACE = CV death + MI + stroke + revasc) + dose-response 변수
- [x] §2 Mendelian randomization — Burgess 2018 JAMA Cardiol: Lp(a) 1-SD ↓ (~25 mg/dL) → CHD HR 0.71
- [x] §3 statin/PCSK9 era 잔여 30% + FOURIER Lp(a) subset ~17% RRR
- [x] §4 HORIZON / OCEAN(a) 사전 power — -80% reduction × ~20% RRR target
- [x] §5 ARR 한국인 — ASCVD 2차 5y MACE 15-20% baseline · 5y NNT ~25-35
- [x] §6 외삽 5가지 caveat (ABS/REL · lifelong/late · confounding · 측정 · heterogeneity)
- [x] §7 정량 격자 — 8 시나리오 × {↓%, mg/dL, RRR, NNT, evidence}
- [x] §8 M8 ranking 입력 = ARR/NNT × evidence-weight
- [x] §9 verify rubric — Burgess MR 🟡 · Ph3 RRR 🟠 · 한국 NNT 🟠
- [x] 산출물 `LPA/M7_quant.md` (168 lines)
- [ ] 🟠 Ph3 outcome RRR (HORIZON 2026 · OCEAN(a) 2027) 후 🟢/🔴 확정
- [ ] 🟠 한국인 시판 후 NNT 후향 분석

🔑 핵심 통찰:
- **Best reduction = olpasiran (-98% · 5y NNT ~20-25)** · **best evidence = pelacarsen (HORIZON 2026 H1 first readout)**
- **Burgess MR HR 0.71/SD** = lifelong 인과 황금 표준 — 약물 외삽 ~50% 감쇠 가정
- **한국인 520만 명 ≥50 mg/dL** × ASCVD 2차 → siRNA 도입 시 5y NNT **~25-35**

## 2026-05-24T22:30:00Z — M6 안전성 완료

- [x] §1 우려 2축 매트릭스 — A (target Lp(a) ↓ 자체) vs B (platform ASO/siRNA toxicity)
- [x] §2 Lp(a) 진화적 역할 + KIV-2 high copy null carrier ~10% Mendelian 안전 보증
- [x] §3 ASO 클래스 (flu-like 30% · platelet inotersen 사례 · ALT 5% · 항-약물 항체)
- [x] §4 siRNA 클래스 — inclisiran ORION-9/10/11 marketed analog 외삽 + lepodisiran reversal 우려
- [x] §5 immune sensitization + 누적 10-30년 미관찰
- [x] §6 임신 / 가임 여성 제외군 + Q24W washout 1년+ 제약
- [x] §7 한국인 ethnicity-specific — KSoLA inclisiran registry
- [x] §8 reversal & rescue 비교 (ASO Q4W high · lepodisiran Q24-48W low)
- [x] §9 안전성 종합 격자 (4분자 × acute/chronic/회수/Mendelian)
- [x] §10 verify rubric — Mendelian 🟡 · Ph2 🟡 · long-term 🟠 · 한국인 🟠
- [x] 산출물 `LPA/M6_safety.md` (~174 lines)
- [ ] 🟠 long-term (10년+) 안전성 — 시판 후 KSoLA registry 필요
- [ ] 🟠 한국인 sub-population 안전 — pelacarsen/olpasiran 한국 site sub-analysis 대기

🔑 핵심 통찰:
- **Lp(a) ↓ 자체 안전 = KIV-2 high copy lifelong null carrier ~10% 인구 Mendelian 자연실험** (Kronenberg 2022)
- **lepodisiran Q24-48W → 1년+ washout = idiosyncratic AE reversal 불가능** = 가장 큰 platform 우려
- **inclisiran ORION 데이터가 GalNAc-siRNA 플랫폼 안전 패러다임 확립** → Lp(a) siRNA 외삽

## 2026-05-24T22:10:00Z — M5 CETP/PCSK9 보조 완료

- [x] §1 보조 약제 위치 — 5축 (PCSK9i · obicetrapib · niacin · mipomersen · apheresis)
- [x] §2 PCSK9i evolocumab/alirocumab — Lp(a) ↓ ~25% · FOURIER(O'Donoghue 2019) + ODYSSEY(Bittner 2020) · 한국 ASCVD 2차 급여
- [x] §3 obicetrapib (Newamsterdam) — ROSE2 Ph2 Lp(a) -56% · BROADWAY/PREVAIL Ph3 readout 2026-27 · 표적 specificity 개선 (no aldosterone)
- [x] §4 niacin AIM-HIGH/HPS2-THRIVE outcome neutral → FDA 2016 Lp(a) indication 철회
- [x] §5 mipomersen — apoB ASO HoFH only · 2018 시판 중단 · 한국 미허가
- [x] §6 apheresis — 독일 강력(-60% acute) · 한국 시설 부재 + 보험 미적용
- [x] §7 종합 비교표 (PCSK9i · obicetrapib · niacin · mipomersen · apheresis + 참고 pelacarsen/olpasiran)
- [x] §8 siRNA 출시 전·후 의사결정 — 2026 H1 PCSK9i + 2027 pelacarsen + 2028 olpasiran + obicetrapib 분기
- [x] 산출물 `LPA/M5_adjunct.md` (175 lines)
- [ ] 🟠 obicetrapib PREVAIL Ph3 outcome (2026-27 readout)

🔑 핵심 통찰:
- **siRNA 출시 전 한국 best option = PCSK9 mAb (Lp(a) -25%)** — 잔여 위험 22-23% 미해결
- **obicetrapib PREVAIL 2026-27 readout** = 경구 dual-effect (LDL -45% + Lp(a) -50%) single molecule 부활 분기점 — CETP class 마지막 생존자
- niacin/mipomersen = 역사 코너 · apheresis = KR 시설 부재 → 진정한 Lp(a) 차단은 **2027-28 siRNA 도입 대기**

## 2026-05-24T22:05:00Z — M4 siRNA 3-way 완료

- [x] §1 siRNA 기전 — RISC catalytic vs ASO RNase H1 stoichiometric + GalNAc-ASGPR 간 표적
- [x] §2 olpasiran (Amgen) — Ph2 -98% · Ph3 OCEAN(a)-Outcomes (NCT05581303) 7,297명 readout 2027
- [x] §2+ OCEAN(a)-PreEvent (NCT07136012) 1차 예방 확장 발견
- [x] §3 lepodisiran (Lilly) — Ph1 -94% at 60주 · Ph3 ACCLAIM-Lp(a) (NCT06292013) 12,500명 readout 2029
- [x] §4 zerlasiran (Silence SLN360) — Ph2 ALPACAR-360 -80~90% (Q24W)
- [x] §5 3-way 비교 테이블 (회사 · 빈도 · ↓% · Ph3 · readout) + ASCII timeline
- [x] §6 vs pelacarsen (ASO M3) — siRNA 우위 (catalytic · 지속성 · deep reduction)
- [x] 산출물 `LPA/M4_sirna.md` (179 lines)
- [ ] 🟠 한국 site 참여 — clinicaltrials.gov XML 파싱 (M8 deferred)
- [ ] 🟠 Ph3 outcome (MACE) — OCEAN(a) 2027 · ACCLAIM 2029 대기

🔑 핵심 통찰:
- **olpasiran -98%** (Ph2 peak) = 3분자 최강 reduction · **first-to-Ph3-readout 2027** = 분야 분기점
- **lepodisiran 6-12개월 1회 dosing** = adherence 게임체인저 후보 (readout 2029)
- siRNA 3분자 RISC catalytic 공통 → outcome 입증 시 **class effect** 확장
- Lp(a) ↓ → MACE ↓ 인과 첫 RCT 증거 = **OCEAN(a)-Outcomes 2027** (Amgen olpasiran)

## 2026-05-24T22:00:00Z — M3 ASO/pelacarsen 완료

- [x] §1 ASO/RNase H1 기전 + GalNAc-ASGR1 hepatocyte 표적 ASCII
- [x] §2 pelacarsen 약동 (IONIS-APO(a)Rx → -LRx → TQJ230) — Ph2 -80% (Tsimikas NEJM 2020)
- [x] §3 HORIZON Ph3 (NCT04023552) — n=8,323 · ≥70 mg/dL · MACE · 4.25년 · **readout 2026 H1**
- [x] §4 후속 ASO 부재 — siRNA로 파이프라인 이동 (pelacarsen 단독)
- [x] §5 한국 site 포함 (KBR 2021) — n 미공개
- [x] §6 우려 — flu-like · platelet (inotersen REMS 참고) · hepatotox · Q4W 부담
- [x] §7 의사결정 분기 — 양성(2027 first-in-class) / 음성(Lp(a) hypothesis 흔들)
- [x] 산출물 `LPA/M3_aso.md` (~197 lines)
- [ ] 🟠 HORIZON outcome (2026 H1 대기) — 결과 후 M7 정량 재평가
- [ ] M4 siRNA (olpasiran OCEAN(a)) 대조

🔑 핵심 통찰:
- pelacarsen = **first-in-class Lp(a) 표적 + 유일 ASO** — HORIZON outcome이 Lp(a) hypothesis 자체 검증
- **2026 H1 readout · 2026 H2 규제 제출** → 2027 출시 가능 분기점
- siRNA(-95% · Q12-24W)가 효능/편의 양쪽에서 ASO(-80% · Q4W) 압박 — 시장 선점만 ASO 우위

## 2026-05-24T22:00:00Z — M2 한국인 분포 매핑 완료

- [x] §1 글로벌 인종별 분포 (백인 ~20% · 흑인 ~35-40% · 한국 ~12-13% ≥50 mg/dL)
- [x] §2 한국 코호트 종합 (KoGES Ansan-Ansung · KARE · HEXA-G · KSoLA)
- [x] §3 절대수 추산 — 성인 4,300만 × 12-13% = **~520만 명 ≥ 50 mg/dL** (≥180 ≈ 52만)
- [x] §4 KIV-2 copy + rs10455872 한국인 minor allele freq ~4% (vs 백인 ~7%)
- [x] §5 한국 허가 현실 — pelacarsen/olpasiran 미허가, PCSK9i -20-30%만 가용
- [x] §6 데이터 공백 — KoGES Lp(a) primary lit open-access 부족 · nmol/L 표준화 부재
- [x] §7 verify rubric — 절대수 🟢 SUPPORTED-NUMERICAL · 분포 🟡 · KIV-2 분포 🟠
- [x] 산출물 `LPA/M2_korea.md` (155 lines)
- [ ] 🟠 KoGES Lp(a) re-analysis (nmol/L 환산 + small-isoform stratify) 권고
- [ ] M3 ASO 후보 — pelacarsen HORIZON Ph3 결과 (2026-27)

🔑 핵심 통찰:
- **한국인 ≥ 50 mg/dL ~12-13% → 약 520만 명** (≥180 mg/dL ≈ 52만 — FH 25만의 2배)
- 현재 한국에서 강력 Lp(a) 저감제 = **없음** (PCSK9i 부분 효과만 급여)
- siRNA/ASO Ph3 outcome (2026-28) → 한국 허가·급여 시 잠재 시장 **~500만 명**
- §2 1차 코호트 primary literature open-access 부족 → review-derived 의존 (Tsimikas · Kronenberg · KSoLA fact sheet)

## 2026-05-24T21:30:00Z — M1 구조 + apo(a) isoform 완료

- [x] §1 Lp(a) = LDL + apo(a) disulfide ASCII (Berg 1963)
- [x] §2 apo(a) 도메인 (SP · KIV1 · KIV-2 가변 · KIV3-10 · KV · pseudoprotease)
- [x] §3 KIV-2 copy ↔ plasma level inverse (Boerwinkle 1992)
- [x] §4 cutoff (30 / 50 / 180 mg/dL) + mg/dL vs nmol/L caveat
- [x] §5 인종별 분포 (한국인 ~13 mg/dL · ≥50 ~10-15%)
- [x] §6 3중 위험 (죽상경화 · 혈전촉진 · 염증) + 대동맥 협착
- [x] §7 저감 약제 — siRNA(-95%)/ASO(-80%)만 강력 / 스타틴 무효
- [x] 산출물 `LPA/M1_structure.md` (~155 lines)
- [ ] 🟠 HORIZON · OCEAN(a) Ph3 outcome (2026-2028 대기)
- [ ] M2 한국인 분포 KoGES 정량

🔑 핵심 통찰:
- Lp(a)는 **유전적 결정성 90%** → 식이/스타틴/ezetimibe 무효 → siRNA/ASO만 강력 저감
- 한국인 ≥ 50 mg/dL **~10-15%** → 절대수 ~500만 명대 (M2 확정)
- 임상 outcome 분기점 = **HORIZON (pelacarsen) + OCEAN(a) (olpasiran) Ph3** (2026-2028)

## 2026-05-24T21:00:00Z — scaffold

- [x] @goal 확립 — Lp(a) 잔여 위험 침묵화 후보 short-list
- [x] M1-M8 milestone 설계
- [x] M1 Lp(a) 구조 + isoform
