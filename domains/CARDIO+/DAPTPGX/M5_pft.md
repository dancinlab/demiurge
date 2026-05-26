# M5 — Platelet Function Test (PFT) 통합: VerifyNow · LTA · MEA

> 마일스톤 M5 산출물 · current-state · no history.
> 출처 = 핵심 임상시험 + 한국인 코호트 → 🟡 SUPPORTED-BY-CITATION.

---

## 1. PFT 측정 원리 비교

```
  LTA (Light Transmission)        VerifyNow (cartridge)         MEA / Multiplate (impedance)
  ─────────────────────           ─────────────────────         ─────────────────────────────
  PRP (platelet-rich plasma)      whole blood → cartridge       whole blood + saline (1:1)
        │                                │                              │
        │ ADP 5/20 μM 첨가               │ ADP + PGE1 (P2Y12 카트리지)   │ ADPtest 6.5 μM 첨가
        ↓                                ↓                              ↓
   ▓░░░░░ (응집 전: turbid)         fibrinogen-coated beads        2 pairs Ag-coated wires
        │                                │                              │
        │ aggregation → clears            │ 응집체 → 광투과 ↑             │ 응집 → 임피던스 ↑
        ↓                                ↓                              ↓
   ░░░░░░ (응집 후: clear)            PRU (P2Y12 Reaction Unit)      AUC (Aggregation Units × min)
   max aggregation %                  0-400+ scale                   0-200 U scale
   (~30 min, 숙련 필요)               (~5 min, 자동화)                 (~6 min, 반자동)
```

세 방법 모두 ADP-induced P2Y12-mediated aggregation을 측정 — but matrix (PRP vs whole blood), 감지 원리 (optical vs impedance), automation 수준이 다름.

---

## 2. VerifyNow P2Y12 — 한국 임상 1순위 POC

| 항목 | 값 |
|---|---|
| 측정 단위 | **PRU** (P2Y12 Reaction Unit) |
| Matrix | whole blood (citrate, 2 mL) |
| Agonist | 20 μM ADP + 22 nM PGE1 (P2Y12 specific) |
| Turnaround | ~5 분 (cartridge, 자동) |
| 측정 범위 | 0 - 400+ PRU |

**Cut-off (consensus, Working Group 2013 + Tantry 2013)**

| 구간 | PRU | 의미 | 임상 함의 |
|---|---|---|---|
| **HTPR** (High On-Treatment Platelet Reactivity) | **≥ 208** | clopidogrel 효과 ↓ | 허혈 사건 ↑ (stent thrombosis · MI) |
| Optimal therapeutic window | 85 - 208 | 적정 억제 | 균형 |
| **LTPR** (Low) | **≤ 85** | 과도 억제 | 출혈 ↑ (특히 동양인) |

→ 한국인 KAMIR-NIH 등록환자 분석 (Jeong YH et al. 2014): clopidogrel 600 mg 부하 후 24h PRU 평균 **~220 ± 90** — 백인 (~180) 대비 유의 ↑. **HTPR 비율 ~50-60%** (한국인) vs ~30% (백인). CYP2C19 LoF allele 빈도 + 동양인 baseline reactivity ↑ 둘 다 기여 (CYP2C19 단독으론 PRU variance ~12% 설명).

---

## 3. LTA (Light Transmission Aggregometry) — Gold Standard

| 항목 | 값 |
|---|---|
| 측정 단위 | **Max aggregation %** (또는 late aggregation 6분) |
| Matrix | PRP (centrifugation 필요) |
| Agonist | ADP **5 μM** 또는 **20 μM** |
| Turnaround | ~30 분 (PRP prep + run + 분석) |
| 표준화 | CLSI H58-A · ISTH SSC 권고 |

**Cut-off (Bonello consensus 2010 + Breet 2010)**

| Agonist | HTPR cut-off | LTPR cut-off (출혈위험) |
|---|---|---|
| ADP **20 μM** | **> 46%** | < ~10-15% |
| ADP **5 μM** | **> 59%** (일부 > 46%) | < ~10% |

LTA는 historically gold standard but: ① 숙련 필요 ② lab-to-lab variability ③ time-consuming → POC가 아님. CYP2C19 LoF carrier 식별 능력은 PFT 중 가장 강함 (CYP2C19 *2 hetero → ADP 5μM max aggregation +12-18% 평균).

---

## 4. MEA (Multiple Electrode Aggregometry · Multiplate)

| 항목 | 값 |
|---|---|
| 측정 단위 | **AUC** (Aggregation Units × min, U) |
| Matrix | whole blood (hirudin, 300 μL × 2 channel) |
| Agonist | **ADPtest** 6.5 μM ADP |
| Turnaround | ~6 분 (반자동) |
| 측정 범위 | 0 - 200 U |

**Cut-off (Sibbing 2010 + ISAR-HPR registry)**

| 구간 | AUC | 의미 |
|---|---|---|
| **HTPR** | **≥ 46 U** | clopidogrel 효과 ↓ |
| Optimal | 19 - 46 U | 적정 |
| **LTPR** | **≤ 19 U** | 출혈위험 ↑ |

MEA는 유럽 (특히 독일·이탈리아) 우세. POC 가까운 신속성 + whole blood = LTA보다 편리. ADPtest 외에 ASPItest (arachidonic acid, aspirin 효과) · TRAPtest (PAR-1) 동시 측정 가능 — 다중-pathway 평가 강점.

---

## 5. 3개 assay 일치율 / 상관도

| 비교 쌍 | Pearson r | Cut-off 결정 일치율 | 비고 |
|---|---|---|---|
| VerifyNow ↔ MEA | ~0.60 - 0.70 | ~75-80% | 둘 다 whole blood, ADP single agonist |
| VerifyNow ↔ LTA | ~0.50 - 0.60 | ~70-75% | matrix 차이 (whole vs PRP) |
| MEA ↔ LTA | ~0.55 - 0.65 | ~70-75% | impedance vs optical |

→ **세 방법 모두 동일 환자를 ‘HTPR’로 분류하는 비율은 ~60-70%**. 즉 1/3 환자는 assay 선택에 따라 분류가 바뀜 → cut-off는 assay-specific, **상호 변환 불가**.

CYP2C19 genotype과의 상관: 어떤 PFT도 단독으로 LoF carrier 식별 sensitivity > 70% 못 넘김 (LoF는 metabolism level, PFT는 표현형 level — 환경·동시투약 영향).

---

## 6. PFT-guided treatment 임상시험 (large RCT)

| 시험명 (연도) | n | 환자군 | 개입 (PFT arm) | Primary endpoint | 결과 |
|---|---|---|---|---|---|
| **GRAVITAS** (2011) | 2,214 | PCI + HTPR by VerifyNow | clopidogrel 150 mg vs 75 mg | CV death/MI/ST 6mo | **음성** (2.3% vs 2.3%) |
| **TRIGGER-PCI** (2012) | 423 | elective PCI + HTPR | prasugrel vs clopidogrel | CV death/MI 6mo | **조기 중단** (사건 너무 적음) |
| **ARCTIC** (2012) | 2,440 | scheduled PCI | PFT-guided dose adjust vs 표준 | death/MI/ST/UR/stroke 1yr | **음성** (34.6% vs 31.1%) |
| **ANTARCTIC** (2016) | 877 | ≥75세 ACS PCI | PFT-guided (escalate or de-esc) vs 표준 prasugrel 5mg | CV death/MI/ST/stroke/UR/bleeding 1yr | **음성** (28% vs 28%) |
| **TROPICAL-ACS** (2017) | 2,610 | ACS PCI | PFT-guided **de-escalation** (prasugrel → clopidogrel if PFT OK) vs prasugrel 12mo | net clinical benefit | **비열등** (7% vs 9%, p=0.0004 비열등) |

**총평**: routine PFT-guided **escalation**은 hard endpoint benefit 입증 실패 (GRAVITAS · ARCTIC · ANTARCTIC). **De-escalation** (TROPICAL-ACS) 방향만 일부 시그널 — 출혈 ↓ 효과. High-risk subset (당뇨 · ACS + multivessel) 메타분석에선 PFT-guided 가 허혈 사건 reduce 시그널 (Galli 2022 Lancet).

---

## 7. CYP2C19 genotype + PFT 통합 알고리즘

| 시험 (연도) | n | 비교 | Primary endpoint | 결과 |
|---|---|---|---|---|
| **POPular Genetics** (2019) | 2,488 | genotype-guided (NM → clopidogrel · LoF → ticagrelor/prasugrel) vs 표준 (ticagrelor/prasugrel 모두) | net clinical benefit 1yr | **비열등 + 출혈 ↓** (5.1% vs 5.9%) |
| **TAILOR-PCI** (2020) | 5,302 | genotype-guided (LoF → ticagrelor) vs clopidogrel | CV death/MI/ST/stroke/SR ischemia 1yr | **음성** (4.0% vs 5.9%, p=0.06) — 사전 등록 효과 size 미달 |
| **HOST-EXAM** (2020, 한국) | 5,438 | clopidogrel vs aspirin (chronic, PCI 후 12mo+) | thrombotic + bleeding 24mo | **clopidogrel 우위** (5.7% vs 7.7%) |

**Genotype vs PFT — 어느 쪽이 우세?**
- Genotype = 고정·1회 측정·결과 빠름 (PCR 1-2h, 일부 POC 1h) · 약물·식이 영향 X
- PFT = 환경 통합 (real-time 표현형) · but assay variability + interim drug-on-board 필요
- **POPular Genetics 결과** → genotype-guided가 PFT-guided보다 simpler · equivalent · 일부 우위 (출혈 ↓)
- 한국 가이드라인 흐름: **genotype 1st-line · PFT는 보조** (특히 PCI 직후 부하 응답 의심 시)

---

## 8. 한국 임상 현장 — PFT 가용성 + 보험

| 항목 | 현황 |
|---|---|
| PFT 보유 병원 (대학병원 기준) | ~30% (3차 의료기관 위주) |
| 가장 흔한 assay | **VerifyNow** > LTA > MEA |
| 보험 급여 | 항혈소판제 효과 평가 명목 **일부 인정** (PCI 후 stent thrombosis 의심 / 재시술 등 specific indication) — routine screening 비급여 |
| CYP2C19 genotyping 급여 | 2018년부터 PCI 환자 대상 **선별 급여** (DUR 권고) — POC genotyping (Spartan RX 등) 일부 대학병원 도입 |
| 임상 현장 결정 변수 | 대부분 ① 임상 risk (ACS vs elective) ② genotype (가용 시) ③ 출혈 risk score (PRECISE-DAPT · ARC-HBR) — **PFT는 routine 아님** |

→ 한국 현실: PFT는 ‘response 의심 case’ 보조 도구. 1st-line 결정은 genotype + clinical risk (M3 트리에서 통합).

---

## 9. 참고문헌

- Tantry US et al. (2013) *JACC* 62:2261 — PFT cut-off Working Group consensus · PMID 24076493
- Bonello L et al. (2010) *JACC* 56:919 — LTA cut-off consensus · PMID 20828644
- Breet NJ et al. (2010) *JAMA* 303:754 — 5 PFT comparison · PMID 20179285
- Sibbing D et al. (2010) *Thromb Haemost* 103:151 — MEA cut-off ISAR · PMID 19938277
- Jeong YH et al. (2014) *JACC Cardiovasc Interv* 7:1241 — 한국인 KAMIR PRU · PMID 25459038
- Price MJ et al. (2011) *JAMA* 305:1097 — **GRAVITAS** · PMID 21406646
- Trenk D et al. (2012) *JACC* 59:2159 — **TRIGGER-PCI** · PMID 22520250
- Collet JP et al. (2012) *NEJM* 367:2100 — **ARCTIC** · PMID 23121439
- Cayla G et al. (2016) *Lancet* 388:2015 — **ANTARCTIC** · PMID 27581531
- Sibbing D et al. (2017) *Lancet* 390:1747 — **TROPICAL-ACS** · PMID 28855078
- Claassens DMF et al. (2019) *NEJM* 381:1621 — **POPular Genetics** · PMID 31479209
- Pereira NL et al. (2020) *JAMA* 324:761 — **TAILOR-PCI** · PMID 32840598
- Kim HS et al. (2020) *Lancet* 397:2487 — **HOST-EXAM** (한국) · PMID 34010616
- Galli M et al. (2022) *Lancet* 400:1542 — guided antiplatelet meta-analysis · PMID 36215970

---

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| VerifyNow PRU cut-off (208/85) | 🟡 SUPPORTED-BY-CITATION | Tantry 2013 consensus |
| LTA cut-off (46%/59%) | 🟡 SUPPORTED-BY-CITATION | Bonello 2010 + Breet 2010 |
| MEA AUC cut-off (46/19 U) | 🟡 SUPPORTED-BY-CITATION | Sibbing 2010 ISAR |
| 한국인 HTPR ~50-60% | 🟡 SUPPORTED-BY-CITATION | Jeong 2014 KAMIR |
| Assay 상호 r ~0.5-0.7 | 🟡 SUPPORTED-BY-CITATION | Breet 2010 head-to-head |
| PFT-guided escalation = no hard benefit | 🟡 SUPPORTED-BY-CITATION | GRAVITAS · ARCTIC · ANTARCTIC |
| Genotype-guided ≥ PFT-guided | 🟡 SUPPORTED-BY-CITATION | POPular Genetics |

---

## 🔑 핵심 통찰

- **Cut-off는 assay-specific, 상호 변환 불가** — VerifyNow PRU 208 ≠ LTA 46% ≠ MEA 46U. 단일 환자라도 assay 따라 분류 ~30% 바뀜.
- **한국인 HTPR 비율 ~50-60%** (PRU ≥208) — 백인 ~30% 대비 압도적. CYP2C19 LoF + 동양인 baseline reactivity ↑ 합산.
- **Routine PFT-guided escalation = hard endpoint benefit X** — GRAVITAS · ARCTIC · ANTARCTIC 모두 음성. PFT만으론 ‘who to escalate’ 결정 부족.
- **De-escalation 방향만 시그널** — TROPICAL-ACS: prasugrel → clopidogrel switch (PFT OK 시) 비열등 + 출혈 ↓. PFT의 본질적 역할은 **‘낮춰도 안전한가’** 확인.
- **Genotype 1st-line + PFT 보조** — POPular Genetics → genotype 단독이 PFT보다 simpler · 비열등 · 출혈 ↓. 한국 현장에서도 genotype POC 확산이 PFT보다 우선순위 — M3 결정 트리는 **CYP2C19 → 임상 risk → (선택적) PFT** 순.
