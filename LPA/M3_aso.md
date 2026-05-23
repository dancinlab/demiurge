# M3 — ASO 후보 (pelacarsen 중심)

> 마일스톤 M3 산출물 · current-state · no history.
> 출처 = literature + ClinicalTrials.gov + Novartis/Ionis IR → 🟡 SUPPORTED-BY-CITATION (outcome 미공개).

---

## 1. ASO 기본 기전 — RNase H mediated mRNA degradation

ASO (antisense oligonucleotide) = 표적 mRNA에 상보적 결합하는 ~20 nt 합성 단일가닥 핵산. 결합 → **RNase H1**이 RNA-DNA 이중가닥의 RNA 가닥 절단 → mRNA 분해 → 단백 합성 차단.

```
   apo(a) mRNA  5'─────────████████████─────────3'
                          │ 상보 결합
                          ▼
   ASO         3'─────────████████████─────────5'  (~20 nt · GalNAc 결합)
                          │
                          ▼  RNase H1 인식
   ┌───────────────────────────────────────────┐
   │  RNase H1 → mRNA 가닥만 절단              │
   │  ASO는 재사용 (catalytic-like)            │
   └───────────────────────────────────────────┘
                          ↓
                  apo(a) 단백질 합성 ↓ → Lp(a) 입자 형성 차단
```

→ **siRNA**와 차이: ASO = RNase H1 (핵 + 세포질) / siRNA = RISC-AGO2 (세포질). ASO가 nuclear pre-mRNA도 잡음 → splice-modulation 응용 가능.

### GalNAc conjugation — 간세포 특이 전달

- **GalNAc**(N-acetylgalactosamine) 3가지 cluster → 간세포 표면 **ASGR1** (asialoglycoprotein receptor, ~500,000 copies/cell) 결합
- 수용체 매개 endocytosis → endosomal escape → 세포질/핵 ASO 도달
- 효과 100배 ↑ (이전 IONIS-APO(a)Rx 300 mg/wk → IONIS-APO(a)-LRx 20 mg/mo)
- apo(a)는 **간 특이 합성** (LPA gene, hepatocyte) → GalNAc 표적 적중

플랫폼: **Ionis** (모핵 기술) · **Akcea** (자회사, Novartis와 라이선스) · **Novartis** (Ph3 단독 진행)

---

## 2. pelacarsen 약동 — IONIS-APO(a)-LRx / TQJ230

| 단계 | 분자명 | 차이 |
|---|---|---|
| 1세대 | **IONIS-APO(a)Rx** | naked ASO, 300 mg/wk SC, -71% (Tsimikas 2015 *Lancet*) |
| 2세대 | **IONIS-APO(a)-LRx** | GalNAc 결합, 20 mg/mo, -80% (Tsimikas 2020 *NEJM*) |
| 임상 코드 | **TQJ230** | Novartis 라이선스 후 코드명 |
| INN | **pelacarsen** | WHO INN |

### Ph2 핵심 데이터 (Tsimikas et al. *NEJM* 2020)

| dose | regimen | Lp(a) 저감 (vs placebo, 6개월) |
|---|---|---|
| 20 mg | Q4W | **-72%** |
| 40 mg | Q4W | **-80%** |
| 60 mg | Q4W | **-72%** |
| 20 mg | Q2W | -58% |
| 20 mg | QW | **-80%** |
| placebo | — | -6% |

→ Ph3 선정 용량 = **80 mg SC Q4W** (월 1회 피하 주사).
→ 약동: SC 흡수 → 간 ASGR1 → t½ ~30일 (조직), plasma t½ ~수시간.
→ apoB / LDL-C / HDL-C / 간기능에 유의 변화 없음.

---

## 3. HORIZON 임상 (Ph3) — NCT04023552

**Lp(a)HORIZON** — first-in-class Lp(a) 표적 cardiovascular outcomes trial. 12월 2019 개시.

### 시험 설계

| 항목 | 값 |
|---|---|
| 디자인 | Ph3, randomized, double-blind, placebo-controlled |
| 등록 | **8,323명** (enrollment complete Sep 2024) |
| 인구 | 2차 예방 (prior MI · stroke · PAD) + Lp(a) **≥ 70 mg/dL** (~175 nmol/L) |
| 투여 | pelacarsen 80 mg SC Q4W vs placebo |
| 추적 | **~4.25년** (median) |
| 1차 endpoint | **expanded MACE** = CV death + non-fatal MI + non-fatal stroke + urgent coronary revasc |
| 2차 endpoint | Lp(a) %저감 · 3-point MACE · 안전성 |
| 종료 | **2026년 2월 (예정)** — primary completion |
| **결과 발표** | **2026 상반기** (Novartis 가이던스) |
| 규제 제출 | **2026 하반기** (예정) |

### Ph2 vs Ph3 비교

| | Ph2 (NEJM 2020) | Ph3 HORIZON |
|---|---|---|
| n | 286 | **8,323** |
| 추적 | 6개월 | **4.25년** |
| Endpoint | **Lp(a) 변화** (surrogate) | **MACE** (hard outcome) |
| Lp(a) cutoff | 60-150 mg/dL | **≥ 70 mg/dL** |
| 결과 | -80% (확정) | **대기** (2026 H1) |

⚠️ **이 trial이 Lp(a) hypothesis 자체의 검증** — Lp(a) 저감이 실제 MACE 감소로 이어지는지 첫 outcome 데이터.

---

## 4. 후속 ASO 분자 — 사실상 부재

apo(a) ASO 파이프라인은 **pelacarsen 단독** — 후속 ASO 분자는 거의 없음. 후발 주자는 모두 **siRNA**로 이동 (M4 참조).

| 분자 | 모달리티 | 상태 |
|---|---|---|
| **pelacarsen** | ASO | **Ph3 (HORIZON) — 유일** |
| olpasiran (Amgen) | siRNA | Ph3 OCEAN(a) (M4) |
| lepodisiran (Lilly) | siRNA | Ph3 ACCLAIM-Lp(a) |
| zerlasiran (Silence) | siRNA | Ph2 |
| muvalaplin (Lilly) | small-molecule oral | Ph2 (apo(a)-apoB 결합 차단) |

→ siRNA의 **-95% 저감 · Q12-24W 투여**가 ASO의 -80% · Q4W를 사실상 압박.
→ pelacarsen이 outcome 결과로 first-in-class 시장을 선점하면 시장 진입 우위, 그 외엔 siRNA에 밀릴 가능성.

---

## 5. 한국 임상 참여

- **HORIZON에 한국 site 포함** — 2021년 *Korea Biomedical Review* 보도: "Korea lines up 1st Lp(a) patients for Novartis' pelacarsen with outcomes in 2026"
- 국내 등록 환자수 공개치 부재 (Novartis 미공개)
- 다국가 8,323명 중 일부 한국인 → readout 시 인종 sub-group 분석 여부가 한국인 임상 적용 핵심
- 동아시아 Lp(a) 분포 (한국 중앙값 ~13 mg/dL, ≥ 70 mg/dL 군 ~5-8% 추정 — M2에서 정량)는 등록 기준 (≥ 70 mg/dL)을 충족하는 환자가 백인 대비 적어 통계 검정력 한계

---

## 6. 잠재 우려

| 항목 | 근거 | 임상 함의 |
|---|---|---|
| **주사 부위 반응** | Ionis ASO 클래스 공통 (mipomersen 60%, inotersen 50%+) | Ph2 pelacarsen ~25-30% — 경증 다수, 중단율 낮음 |
| **flu-like syndrome** | TLR9 자극 가능성 (CpG motif) | Ph2 보고 미미, Ph3 장기 추적 필요 |
| **혈소판 감소** | inotersen (Ionis ASO) Ph3에서 **TTP 사례** (FDA REMS) | pelacarsen Ph2엔 미관찰 — 장기 모니터링 필수 |
| **간독성** | GalNAc-ASO 간 농축 → 이론적 risk | Ph2 ALT/AST 변화 없음, Ph3 장기 미확정 |
| **renal** | 신장 cortex 농축 (ASO 클래스) | Ph2 무 — 장기 미확정 |
| **투여 부담** | Q4W SC, 평생 투여 | siRNA Q12-24W 대비 12배 빈도 → adherence 약점 |

→ Ph3 HORIZON 4.25년 추적이 **장기 안전성의 1차 evidence** — readout 시 safety arm 함께 주목.

---

## 7. 의사결정 분기 — 2026 H1 readout

```
                  HORIZON readout (2026 H1)
                         ┃
              ┏━━━━━━━━━━┻━━━━━━━━━━┓
              ▼                     ▼
        [양성: MACE ↓]        [음성: MACE 차이 X]
              │                     │
              ▼                     ▼
   • first-in-class Lp(a)    • Lp(a) hypothesis 자체
     표적 출시 (2027~)         흔들 → siRNA 파이프라인도
   • Novartis 시장 선점        타격 (M4 olpasiran도 영향)
   • siRNA(M4)와 효능 vs       • Lp(a) drug class 재평가
     투여빈도 경쟁
   • -80% × N년 = ΔMACE       • CETP(obicetrapib, M5)로
     정량화 (M7에서 산출)       weight 이동
              │                     │
              ▼                     ▼
   M8 ranking: pelacarsen      M8 ranking: siRNA보다
   = ASO 1st-line              CETP 우선 재평가
```

siRNA vs ASO 경쟁 구도 한 줄: **pelacarsen이 outcome으로 시장 선점 → siRNA가 효능(-95%) + 편의(Q12-24W)로 빠르게 뒤집기** 가능 시나리오. 의사결정은 **HORIZON 결과 × OCEAN(a) 결과 (M4)** 매트릭스.

---

## 8. 참고문헌

- Tsimikas S et al. (2015) *Lancet* 386:1472 — IONIS-APO(a)Rx Ph1
- Viney NJ et al. (2016) *Lancet* 388:2239 — IONIS-APO(a)Rx + LRx Ph1/2a
- Tsimikas S et al. (2020) *NEJM* 382:244 — **pelacarsen Ph2** (-80%)
- ClinicalTrials.gov **NCT04023552** — Lp(a)HORIZON Ph3
- Ionis Pharmaceuticals (Sep 2024) IR — HORIZON enrollment complete (n=8,325)
- Novartis (2025) IR — Ph3 readout 2026 H1, 규제 제출 2026 H2
- Korea Biomedical Review (2021) — "Korea lines up 1st Lp(a) patients for Novartis' pelacarsen"
- Yeang C et al. (2022) *Eur Heart J* — pelacarsen MOA review
- Kronenberg F et al. (2022) *Eur Heart J* 43:3925 — EAS consensus (Lp(a) 표적)

---

## 9. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| ASO/RNase H1 기전 | 🟡 SUPPORTED-BY-CITATION | Crooke 2017 *Cell Metab* (Ionis 플랫폼) |
| GalNAc-ASGR1 hepatocyte 표적 | 🟡 SUPPORTED-BY-CITATION | Prakash 2014 *NAR* |
| pelacarsen Ph2 -80% | 🟡 SUPPORTED-BY-CITATION | Tsimikas 2020 *NEJM* |
| HORIZON Ph3 디자인 (n=8,323 · MACE) | 🟡 SUPPORTED-BY-CITATION | NCT04023552 · Ionis IR |
| **HORIZON outcome (MACE 감소)** | **🟠 INSUFFICIENT/DEFERRED** | **2026 H1 readout 대기** |
| 한국 site 포함 | 🟡 SUPPORTED-BY-CITATION | KBR 2021 보도 |
| 후속 ASO 부재 (siRNA로 이동) | 🟡 SUPPORTED-BY-CITATION | pipeline review (Empirical Health 2025) |

🔑 핵심 통찰:
- pelacarsen = **first-in-class Lp(a) 표적** + 유일한 ASO 후보 — HORIZON outcome 결과가 Lp(a) hypothesis 자체의 검증
- **2026 H1 readout · 2026 H2 규제 제출** → 2027 출시 가능 → 임팩트 큰 분기점
- siRNA(-95%, Q12-24W)가 ASO(-80%, Q4W)를 효능/편의 양쪽에서 압박 — 시장 선점만 ASO의 우위
- 한국 site 포함 but n 미공개 — 인종 sub-group 통계 검정력 한계 우려
