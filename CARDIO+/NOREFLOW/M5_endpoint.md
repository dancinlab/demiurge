# M5 — no-reflow / MVO 임상 endpoint 표준 + surrogate 등급

> 마일스톤 M5 산출물 · current-state · no history.
> 출처 = literature + FDA/EMA guidance → 🟡 SUPPORTED-BY-CITATION (hexa recompute 없음).

---

## 1. endpoint 5-layer 체계 (gross → cellular)

epicardial 거시 flow에서 시작해 임상 outcome까지, no-reflow 평가 endpoint는 5층 피라미드 구조. 위층은 측정 쉬움 / 거침, 아래층은 측정 어려움 / 예후 예측력 강함.

```
            ┌─────────────────────────────┐
   Layer 1  │  epicardial flow            │  TIMI 0-3 · cTFC
            │  (조영제 시각)              │  ── 가장 거친 척도, 임상 routine
            ├─────────────────────────────┤
   Layer 2  │  myocardial blush           │  MBG · TMPG
            │  (modeled blush intensity)  │  ── 미세혈관 관류 reflect
            ├─────────────────────────────┤
   Layer 3  │  microcirculation 직접 측정 │  IMR · CFR · doppler
            │  (pressure-wire 침습)       │  ── gold standard, cath lab
            ├─────────────────────────────┤
   Layer 4  │  infarct size + MVO         │  CMR LGE · CMR MVO · biomarker AUC
            │  (조직 손상 정량)           │  ── surrogate endpoint
            ├─────────────────────────────┤
   Layer 5  │  clinical outcome           │  MACE · mortality · HF readmission
            │  (hard endpoint)            │  ── registration trial 표준
            └─────────────────────────────┘
                                    ↓ 예후 예측력 ↑ / 측정 난이도 ↑
```

피라미드 아래쪽으로 갈수록 환자 outcome 예측력은 강해지나 측정 난이도 + cost + n 요구 ↑.

---

## 2. 각 endpoint 정량 cutoff

| Layer | endpoint | 정의 / 계산 | abnormal cutoff | 1차 reference |
|---|---|---|---|---|
| L1 | TIMI flow grade | 조영제 epicardial 흐름 시각 grading 0-3 | ≤ 2 = impaired | TIMI Study Group 1985 |
| L1 | cTFC (corrected TIMI frame count) | 조영제 distal landmark 도달 frame 수 (30 fps 기준), LAD는 × 1.7 보정 | > 23 = no-reflow · > 40 = severe | Gibson 1996 |
| L2 | MBG (Myocardial Blush Grade) | 조영제 myocardial blush 0(없음)-3(정상) van 't Hof grading | ≤ 1 = no-reflow | van 't Hof 1998 |
| L2 | TMPG | TIMI Myocardial Perfusion Grade 0-3 (blush + washout 합) | ≤ 1 = impaired | Gibson 2000 |
| L3 | IMR (Index of Microcirc Resistance) | Pd × Tmn (mean transit time) at maximal hyperemia (adenosine 140 μg/kg/min IV) | > 40 U = MVO+ · 25-40 borderline | Fearon 2003 |
| L3 | CFR (Coronary Flow Reserve) | hyperemic / baseline flow velocity ratio | < 2.0 = impaired | doppler / thermodilution |
| L4 | CMR MVO | LGE 내부 hypoenhanced dark zone (% LV mass) | ≥ 1.5% LV mass = poor prognosis · 존재 자체 = MVO+ | Wu 1998 |
| L4 | CMR LGE (infarct size) | gadolinium late enhancement % LV mass | ≥ 30% LV mass = large infarct · ≥ 40% = transmural | Stone 2016 |
| L4 | CK-MB AUC | 72h serial sampling, normalize to ULN (× upper limit) | peak > 10 × ULN = large MI | classic |
| L4 | hs-troponin AUC | 48-72h AUC, ng/L·h | hs-cTnT AUC > 30,000 ng/L·h ≈ large infarct | Hallén 2010 |
| L5 | 30-day MACE | death + reinfarction + HF + TVR composite | 발생 yes/no | trial-specific |
| L5 | 1y mortality | all-cause death | 발생 yes/no | registry |

### 2.1 IMR 계산 디테일

```
IMR = Pd(mean distal pressure) × Tmn(mean transit time)
      ↑                          ↑
      pressure wire (FFR 동일)   thermodilution (saline 3 ml × 3 bolus)
      adenosine 140 μg/kg/min IV → maximal hyperemia 유도
      
단위: U (= mmHg × s)
정상 < 25 · borderline 25-40 · abnormal > 40
```

---

## 3. endpoint × outcome correlation

각 endpoint의 1y MACE / mortality 예측력 (HR, post-PCI 시점 측정).

| endpoint | abnormal cutoff | 1y MACE HR (vs normal) | 1차 reference |
|---|---|---|---|
| TIMI ≤ 2 | post-PCI | 2.0-3.0 | TIMI 1993 · meta |
| cTFC > 23 | post-PCI | 1.8-2.5 | Gibson 1999 |
| MBG ≤ 1 | post-PCI | 2.5-4.0 | Henriques 2003 |
| IMR > 40 | post-PCI | 4.0-6.0 | Fearon 2013 (IMR-IS) |
| CMR MVO+ | post-MI | 3.0-5.0 | Wu 1998 · de Waha 2017 meta |
| CK-MB peak | per 10 × ULN | 1.5-2.0 | classic biomarker |
| CMR LGE ≥ 30% | post-MI | 2.5-4.0 | Stone 2016 patient-pool |

→ 미세혈관 직접 측정 (IMR · CMR MVO)이 거시 flow (TIMI · MBG)보다 outcome 예측력 약 2배 강함.

---

## 4. surrogate endpoint 등급 (FDA / EMA-style)

| 등급 | 정의 | 해당 endpoint | 사용 trial |
|---|---|---|---|
| **Validated surrogate** | regulatory acceptance, hard endpoint 대체 가능 | **CMR infarct size** (% LV mass) | Stone 2016 patient-level pooled (n = 2,632, 10 RCTs) — infarct size HR predicts 1y mortality / HF re-admission |
| **Clinical endpoint** | registration trial 표준 hard endpoint | MACE composite (death + reinfarction + HF + revasc) | CIRCUS · CYCLE 등 phase 3 |
| **Imaging biomarker (emerging)** | mechanistic, surrogate validation 진행 중 | IMR · CMR MVO | IMR-IS (Fearon 2013) · de Waha 2017 meta |
| **Process measure** | technical success, outcome 직결 약함 | TIMI · cTFC · MBG | angiographic substudy |

### 4.1 endpoint × clinical trial 사용도

| endpoint | phase 2 PoC | phase 3 registration | mechanistic sub-study |
|---|---|---|---|
| CMR infarct size | ★★★ 1차 | ★★ co-primary 가능 | ★★ |
| MACE composite | ★ | ★★★ 1차 | — |
| IMR | ★★ | — | ★★★ |
| CMR MVO | ★★ | ★ subgroup | ★★★ |
| TIMI / MBG | ★★ | — (proc 측정) | ★★ |

---

## 5. trial endpoint 선택 가이드 (M2 / M3 임상 설계 입력)

```
                  [ trial phase ]
                        │
        ┌───────────────┼───────────────┐
        ↓               ↓               ↓
    Phase 2          Phase 3       Mechanistic
    (PoC)            (Registration) sub-study
        │               │               │
        ↓               ↓               ↓
   CMR infarct      MACE composite    IMR (small n)
   ± IMR            ± CMR sub        CMR MVO
        │               │               │
        ↓               ↓               ↓
   n ~ 200-400      n > 2000-5000   n ~ 50-150
   power: 25-30%    power: 15-20%   hypothesis
   infarct ↓        MACE ↓           generating
```

- **Phase 2 PoC**: CMR infarct size를 1차로 → 작은 n으로 효과 detect, Stone 2016 surrogate 근거.
- **Phase 3 registration**: MACE 1차 + CMR sub-study (co-primary 또는 surrogate validation 연장).
- **Mechanistic**: IMR · CMR MVO → MoA confirm, dose-finding.
- **Combined**: CMR + clinical co-primary → Stone 2016 framework 따라 surrogate-clinical concordance 강화.

---

## 6. 한국 다기관 endpoint 표준 + gap

| 출처 | endpoint 사용 | 상태 | gap |
|---|---|---|---|
| KAMIR-NIH | CK-MB AUC + 30d/1y MACE | registry 운영 | CMR 미포함 |
| K-ACTION | cMRI subset (서울대 · 세브란스 · 삼성서울) | 다기관 진행 중 | n 부족 → surrogate 검증 약함 |
| KAMIR-V adenosine | TIMI · MBG (angiographic) | retrospective | IMR 부재 |
| IMR-guided RCT | — | **부재 (한국)** | De Maria 2020 유럽 데이터만 |
| CMR consortium | — | **부재 (한국)** | 사이트별 protocol heterogeneity |

→ M2 / M3 한국 임상 설계 시 **CMR + IMR sub-study 다기관 consortium 구축**이 surrogate 등급 endpoint 활용의 전제.

---

## 7. 참고문헌

- TIMI Study Group (1985) *NEJM* 312:932 — TIMI flow grade 정의
- Gibson CM et al. (1996) *Circulation* 93:879 — cTFC validation + LAD 보정
- van 't Hof AW et al. (1998) *Circulation* 97:2302 — MBG grading
- Gibson CM et al. (2000) *Circulation* 101:125 — TMPG
- Fearon WF et al. (2003) *Circulation* 107:3129 — IMR 정의
- Fearon WF et al. (2013) *Circulation* 127:2436 — IMR outcome (IMR-IS)
- Henriques JP et al. (2003) *JACC* 41:2145 — MBG prognosis
- Wu KC et al. (1998) *Circulation* 97:765 — CMR MVO prognosis (최초)
- de Waha S et al. (2017) *Eur Heart J* 38:3502 — CMR MVO patient-level meta
- Stone GW et al. (2016) *JACC* 67:1674 — CMR infarct size surrogate validation
- De Maria GL et al. (2020) *Eur Heart J* 41:3818 — IMR-guided treatment
- Niccoli G et al. (2009) *Eur Heart J* 30:2705 — no-reflow + endpoint review
- Hallén J (2010) *Heart* 96:1860 — hs-troponin AUC kinetics

---

## 8. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| TIMI · cTFC · MBG 정의 + cutoff | 🟡 SUPPORTED-BY-CITATION | TIMI 1985 · Gibson 1996 · van 't Hof 1998 |
| IMR 공식 + cutoff > 40 | 🟡 SUPPORTED-BY-CITATION | Fearon 2003 / 2013 |
| CMR MVO · LGE prognosis HR | 🟡 SUPPORTED-BY-CITATION | Wu 1998 · de Waha 2017 meta |
| **CMR infarct size = validated surrogate** | 🟡 SUPPORTED-BY-CITATION | Stone 2016 patient-pool (n=2,632) |
| 한국 IMR-guided RCT 부재 / CMR consortium 부재 | 🟠 INSUFFICIENT/DEFERRED | 직접 데이터 부재, gap identification |
| Phase 2 / 3 endpoint 선택 가이드 | 🟡 SUPPORTED-BY-CITATION | Stone 2016 + FDA guidance |

→ M2 / M3 후속 임상 설계는 **CMR infarct size (Phase 2 PoC) + MACE composite (Phase 3)** 2-tier 표준이 surrogate validation 근거 위에서 합리적. 한국 다기관 CMR consortium 구축이 gating 조건.
