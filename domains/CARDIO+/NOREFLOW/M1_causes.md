# M1 — no-reflow 4-cause 매핑

> 마일스톤 M1 산출물 · current-state · no history.
> 출처 = literature + 임상 가이드라인 → 🟡 SUPPORTED-BY-CITATION (hexa recompute 없음).

---

## 1. no-reflow 정의

PCI로 epicardial coronary는 뚫렸는데 (TIMI flow 3 회복) **하류 심근 관류는 회복 안 되는** 현상. 4-cause가 겹쳐 발생, 단일 원인 아님.

```
[ 막힌 동맥 ]                [ PCI 시술 후 ]
    ████                       ░░░░ (열림)
    ████   →    epicardial flow 회복
    ████              │
                      ↓
              ─── 미세혈관 (<300 μm) ───
              ↓        ↓        ↓       ↓
           embolic  spasm    edema    ROS/IRI
           (혈전·  (catechol- (재관류  (mPTP
           plaque   amine)    부종)    개방)
           debris)
              ↓        ↓        ↓       ↓
              └────────┴────────┴───────┘
                       MVO (microvascular obstruction)
                       → 심근 관류 X → infarct 확장
```

빈도: STEMI primary PCI 후 angiographic no-reflow **5-25%**, cMRI MVO 기준 **30-50%**.

---

## 2. 4-cause 분해

| 원인 | 약자 | 메커니즘 | 주 발생 시점 | 진단 marker |
|---|---|---|---|---|
| **distal embolization** | DE | thrombus · plaque debris가 미세혈관 폐색 | PCI 직후 (수초~수분) | OCT plaque protrusion · IVUS thrombus burden |
| **vasospasm** | VS | catecholamine · endothelin · 5-HT 매개 평활근 수축 | PCI 직후 + 수 시간 | IC nitroglycerin 후 회복 여부 |
| **edema / 압박** | ED | 재관류 후 endothelial leak → interstitial 부종 → capillary 압박 | 30분 – 수일 | cMRI T2 hyperintensity |
| **ROS / IRI** | IR | 재관류 시 mitochondria ROS burst → mPTP 개방 → cardiomyocyte 사멸 | 재관류 첫 5-10분 (lethal window) | troponin 추가 상승 · cMRI LGE 확장 |

---

## 3. 임상 측정 척도

| 척도 | 풀이 | 컷오프 (no-reflow) | 비고 |
|---|---|---|---|
| TIMI flow grade | 0–3 epicardial flow | ≤ 2 | 가장 거친 척도 |
| TIMI frame count (cTFC) | 조영제 distal 도달 frame 수 | > 23 (LAD 보정 후) | 보다 정량적 |
| MBG (Myocardial Blush Grade) | 0–3 myocardial blush | ≤ 1 | 미세혈관 관류 반영 |
| IMR (Index of Microcirc. Resistance) | pressure-wire 기반 | > 40 U | gold standard, 침습 |
| CMR MVO | LGE 내부 dark zone | 존재 = MVO+ | 비침습 reference |

---

## 4. 4-cause × 대응 전략 매핑 (M2-M4 입력)

| cause | 약물 (M2-M3) | 디바이스 (M4) | 임상 근거 |
|---|---|---|---|
| DE | IIb/IIIa antagonist (abciximab IC) | aspiration thrombectomy · distal filter | TASTE / TOTAL = 일상적 사용 negative |
| VS | adenosine · nicorandil · nitroprusside · verapamil (IC) | — | REOPEN-AMI (adenosine ↓ MVO) |
| ED | osmotic protection (mannitol experimental) | — | 임상 약함 |
| **IR** | **cyclosporin-A** (mPTP) · **MTP-131** · **TRO40303** | controlled reperfusion · postconditioning | **CIRCUS / CYCLE = neutral** → d2 wall |

---

## 5. d2 wall — IR 보호 임상 실패

```
   전임상 (in vitro · 동물)        →    임상 (인간 STEMI)
   ─────────────────────────              ──────────────────────
   CsA · MTP-131 · TRO40303              CIRCUS (CsA · n=970) → neutral
   → infarct size 40-60% ↓               CYCLE (CsA STEMI)    → neutral
                                          EMBRACE (MTP-131)   → neutral
                                          MITOCARE (TRO40303)  → neutral
```

→ M2 후속: **선택성 부족 + 타이밍 부족** 가설 → 신규 mPTP 표적 inventory 필요.

---

## 6. 한국인 데이터 hooks (M8 입력)

| 출처 | 데이터 | 비고 |
|---|---|---|
| KAMIR-NIH | STEMI primary PCI no-reflow ~12-18% | registry 진행 중 |
| K-ACTION | 미세혈관 dysfunction prevalence | IMR sub-study |
| KAMIR-V | adenosine IC vs control no-reflow rate | retrospective |

---

## 7. 참고문헌

- Rezkalla SH, Kloner RA (2002) *Circulation* 105:656 — no-reflow review (cause 분류 원조)
- Niccoli G et al. (2009) *Eur Heart J* 30:2705 — 4-cause framework
- Ndrepepa G et al. (2010) *JACC* 55:2383 — no-reflow 예후
- Heusch G (2016) *Circ Res* 119:1262 — IRI · mPTP review
- Cung TT et al. (2015) *NEJM* 373:1021 — CIRCUS (CsA STEMI)
- Ottani F et al. (2016) *JACC* 67:365 — CYCLE
- Gibson CM et al. (2016) *JACC* 67:1416 — EMBRACE (MTP-131)
- Atar D et al. (2015) *Eur Heart J* 36:112 — MITOCARE
- De Maria GL et al. (2020) *Eur Heart J* 41:3818 — IMR-guided treatment

---

## 8. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| no-reflow 정의 · 4-cause 분류 | 🟡 SUPPORTED-BY-CITATION | Niccoli 2009 framework |
| MBG · IMR · CMR cutoff | 🟡 SUPPORTED-BY-CITATION | guideline + meta-analysis |
| 한국인 빈도 | 🟠 INSUFFICIENT/DEFERRED | KAMIR-V 직접 ratio 미확보 → M8 |
| 4-cause × strategy 매핑 | 🟡 SUPPORTED-BY-CITATION | CIRCUS · CYCLE · EMBRACE 등 |

→ M2 mPTP 후보 inventory에서 d2 wall (전임상→임상 gap) 돌파 path 3가지 도출 예정.
