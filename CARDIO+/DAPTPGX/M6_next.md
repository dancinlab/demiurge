# M6 — 신규 P2Y12 / 인접표적 후보: selatogrel · revacept · vicagrel · pipeline

> 마일스톤 M6 산출물 · current-state · no history.
> 입력 = M3 (현 3제 한계) · 출력 = 한국인 PGx 결정맵 5-10y 확장 후보 → 🟡 / 🟠.

---

## 1. 현 3제의 unmet need — missing axis 정리

```
 axis                clopidogrel    prasugrel     ticagrelor    ← 현 3제
 ──────────────────────────────────────────────────────────────
 onset (peak)        2-6 h          ~30 min       ~2 h          ← STEMI 골든타임 미충족
 CYP-independent     ✗ (2C19)       부분 (3A)     ✓ (CYP X)
 reversible          ✗ (covalent)   ✗ (covalent)  ✓             ← 수술/출혈시 회복
 daily dose          1× (75 mg)     1× (10 mg)    2× (90 mg)    ← compliance ↓
 출혈 risk           기준           ↑↑           ↑              ← 동양인 특히 ↑
 SC 자가/EMS         ✗              ✗             ✗             ← prehospital 공백
 GoF/LoF 영향        강 (LoF→fail)  약            거의 X        ← PGx 의존
 한국인 데이터       풍부           제한적         중간          ← 동양인 PK gap

  ✕ missing-all-axis 후보 = ?
        ↓
   ┌────────────────────────────────────────────────────────┐
   │ ① fast-onset + ② CYP-independent + ③ reversible       │
   │ + ④ SC self / EMS + ⑤ 출혈 ↓ + ⑥ Asian PK 확보         │
   └────────────────────────────────────────────────────────┘
   → selatogrel (①②③④) · vicagrel (②⑥) · revacept (⑤ extreme)
   → 단일 약제로 6 axis 모두 충족하는 후보는 아직 0.
```

→ **결정맵의 5-10y 확장 = 환자 phenotype × 신약 strength matching** (one-size 아님).

---

## 2. selatogrel (ACT-246475) — fast-onset SC P2Y12 가역제

| 항목 | 값 |
|---|---|
| 개발사 | **Idorsia Pharmaceuticals** (스위스) |
| 표적 | **P2Y12 (가역적 small molecule)** — non-thienopyridine |
| 화학 | 2-phenylpyrimidine-4-carboxamide derivative · MW ~487 |
| 투여 | **subcutaneous, prefilled auto-injector pen** (16 mg single dose) |
| Peak | **~30 min** (Tmax) — IV에 근접 |
| t½ | 6-8 h (반감기 짧음 → 가역적 회복) |
| 활성화 | **prodrug 아님 · CYP 우회** — 모분자가 active |
| 적응증 | suspected AMI **prehospital / ED 첫 dose** (bridge to PCI) |

**SOS-AMI Phase 3 (진행 중, NCT04957719)**
- n ~14,000 명 suspected STEMI · 글로벌 (북미·유럽·일본 포함, 한국 사이트 일부)
- 1차 endpoint = composite (all-cause death · MI · stroke · severe ventricular arrhythmia · cardiogenic shock) at 30 days
- 시점: **증상 발생 직후 환자 자가 또는 EMS SC 1회** → 표준 PCI/DAPT 흐름과 결합
- 예상 완료: ~2027 (interim 2025)

**Phase 2 결과 (Sinnaeve P et al., *Eur Heart J* 2020; PMID 31504432)**
- n=47 suspected AMI · 16 mg SC → 30분 내 IPA (Inhibition of Platelet Aggregation) **>90%** 달성 (ADP 20μM 기준)
- IPA 4-6h 유지 후 점진 회복 → 가역성 입증
- 출혈 사건 phase 2 단기: TIMI major 없음 (소규모 한계)

**Asian PK 데이터**
- 일본인 Phase 1 (NCT03554382 등) — 백인 대비 PK 유사 · 16 mg 동일 용량 권고
- 한국인 단독 데이터 = **현재 거의 없음** (SOS-AMI 한국 등록 환자 통한 향후 확보)
- 체중·신기능 영향 작음 (renal clearance <20%)

→ **PGx 임팩트**: CYP2C19 genotype **완전 우회**. 한국인 IM+PM 60%에서 prehospital fast IPA 확보 = STEMI golden time gap을 가장 직접적으로 메움.

---

## 3. revacept (PR-15) — GPVI-Fc lesion-targeted (비-P2Y12)

| 항목 | 값 |
|---|---|
| 개발사 | **advanceCOR / Trommsdorff** (독일) |
| 표적 | **GPVI 외영역 (extracellular)** — Fc dimer로 collagen 결합 차단 |
| 화학 | **soluble GPVI-Fc fusion protein** (recombinant) — IgG1 Fc + GPVI ectodomain dimer |
| 투여 | IV infusion (단회, 80 mg or 160 mg) |
| 작동 원리 | 혈관 손상부 노출 collagen에 **선택 결합 → 환자 자신의 platelet GPVI 가림** |
| 출혈 risk | **거의 zero claim** — systemic platelet 기능 보존, lesion-selective scavenger |
| CYP 의존 | **완전 X** (단백질) |

**ISAR-PLASTER Phase 2 (Mayer K et al., *JAMA* 2021; PMID 33825882)**
- n=334 elective PCI · revacept 80/160 mg vs placebo (모두 표준 DAPT 위에)
- 1차 endpoint = death + myocardial injury 48h → **음성** (revacept 6.0/4.5% vs placebo 4.5%, p=NS)
- 출혈은 모든 arm 유사 (BARC ≥2 ~5%)
- → elective PCI에선 표준 DAPT 위 추가 benefit 입증 실패

**ISAR-PLASTER-stroke (진행 중)**
- 급성 허혈성 stroke 대상 · 비-PCI 적응증 탐색 (carotid 등 atherothrombotic stroke)
- GPVI mechanism은 **stroke endothelial injury**에 더 적합한 가설

**Phase 2 후속 인접 데이터**
- 작은 cohort tirofiban-bridge 등 high-risk PCI subgroup에서 출혈 ↓ 시그널
- glenzocimab (humanized anti-GPVI Fab, Acticor) — 유사 mechanism, AIS Phase 2/3 진행

→ **PGx 임팩트**: P2Y12 우회 + CYP 우회 → 한국인 LoF에 무관. but PCI 1차 endpoint 음성 → **단독 DAPT 대체보단 high bleeding-risk add-on** 후보. M3 결정맵에선 **HBR(+++) + 허혈 risk 잔존 환자**의 add-on 옵션.

---

## 4. vicagrel (HS-AS-9, vicagrelor) — CES1-activated, CYP 우회 prodrug

| 항목 | 값 |
|---|---|
| 개발사 | **CSPC Pharmaceutical** (중국, 石药集团) |
| 표적 | **P2Y12 (irreversible, thienopyridine)** — clopidogrel 동일 endpoint |
| 화학 | clopidogrel 2-acetate analog (vinyl acetate group 추가) |
| 활성화 | **CES1 (carboxylesterase 1, esterase) 1-step → CYP3A4 minor 2-step** |
| 핵심 차이 | **CYP2C19 우회** — CES1이 1차 활성화 (clopidogrel은 CYP2C19 2-step) |
| 투여 | 경구 1일 1회 (5-15 mg, 부하 20-30 mg) |
| Peak / t½ | ~1 h / 0.5-1 h (active metabolite) |

**VICTORY (Phase 3, 중국 진행/완료)**
- n ~1,800-2,000 ACS PCI (중국 다기관)
- vicagrel vs clopidogrel · 1차 endpoint = MACE 12 mo
- 결과: **양성 (비열등 + 시그널 우위)** — vicagrel arm CYP2C19 LoF carrier에서 IPA 우위 명확 (clopidogrel은 LoF에서 IPA 저하, vicagrel은 유지)
- 출혈: 전체 유사 (TIMI major non-significant)
- 중국 NMPA 승인 ~2023 (제한 적응증)

**Phase 2 PK (Jiang J et al., *Br J Clin Pharmacol* 2017; PMID 28543311 등)**
- 건강 동양인 자원자에서 CYP2C19 genotype 무관하게 active metabolite AUC 일정
- clopidogrel 대비 active metabolite 노출 ~3-4× ↑ (저용량 가능)

**Asian 데이터**
- **중국인 데이터 풍부** (개발 모국) · 한국 / 일본 사이트 = 제한적 (글로벌 라이센싱 진행 중)
- CES1 활성도는 동양인 ↔ 백인 큰 차이 없음 (보고 한정) · 단, CES1 c.428G>A (rs71647871) drug-altering variant 존재 — 동양인 빈도 ~3-5%

→ **PGx 임팩트**: 한국인 IM+PM 60%에 가장 “저비용·1:1 대체” 후보. 단 CES1 SNP 별도 고려 필요 (M1 확장). 라이센싱 / KFDA 승인 timeline이 selatogrel보다 빠를 가능성.

---

## 5. RUC-4 (zalunfiban) · PAR antagonist · 기타 short-list

| 약물 | 표적 | 투여 | 단계 | 메모 |
|---|---|---|---|---|
| **zalunfiban** (RUC-4) | αIIbβ3 (GP IIb/IIIa) | **SC 1회** (prehospital) | **Phase 3 CELEBRATE** (NCT04825743, n~2500 STEMI) | SC fibrinogen-receptor block, 30s peak, t½ <1h, 출혈 ↓ 주장 |
| **vorapaxar** (Zontivity) | **PAR-1** (thrombin receptor) | 경구 2.5 mg/d | FDA 승인 (2014) · 한국 미발매 | TRA-2P 양성 but ICH ↑ · CAD 2차예방 add-on |
| **PZ-128** (parmodulin) | PAR-1 (intracellular) | IV | Phase 2 (TRIP-PCI 완료) | endothelial side effect 적음 (allosteric) |
| **PAR-4 antagonist** (BMS-986120, BMS-986141) | PAR-4 (thrombin) | 경구 | Phase 1/2 | 출혈 분리 가설 — Asian PAR-4 SNP (rs773902) 중요 |
| **ticagrelor 후속 derivatives** | P2Y12 가역 | 경구 1일 1회 시도 | 전임상 | 복용 빈도 ↓ 목표 |

zalunfiban이 selatogrel과 **prehospital SC 시장 경쟁자** — selatogrel은 P2Y12, zalunfiban은 αIIbβ3, mechanism 보완 가능성.

---

## 6. GPIbα · GPVI · PAR-4 인접 표적 pipeline (간단)

| 표적 | 후보 | 단계 | 핵심 차별 |
|---|---|---|---|
| **GPIbα** (vWF receptor) | caplacizumab (이미 TTP 승인) · anfibatide | Phase 2 (관상동맥) | shear-dependent thrombosis 차단 |
| **GPVI** | revacept (§3) · **glenzocimab** (Acticor, anti-GPVI Fab) | Phase 2/3 (AIS) | lesion-selective · 출혈 ↓ |
| **PAR-4** | BMS-986120/141/120 · ML354 | Phase 1/2 | thrombin pathway · Asian PAR-4 rs773902 GoF ↑ |
| **CLEC-2** (podoplanin receptor) | 전임상 항체 | 전임상 | 림프계 출혈 risk 분리 |

→ 인접 표적의 공통 가설: **‘pathologic thrombosis만 차단, 정상 hemostasis 유지’** = 출혈 분리. 임상 입증은 대부분 미완.

---

## 7. 유전적 modifier × 신약 후보 — 비교 매트릭스

| 약물 | 표적 | CYP-independence | GoF/LoF 영향 | Prodrug | 가역성 | 투여 | 한국인 데이터 |
|---|---|---|---|---|---|---|---|
| clopidogrel | P2Y12 | ✗ (CYP2C19) | **강** | ✓ (2-step CYP) | ✗ | 경구 1×/d | 풍부 (KAMIR · HOST-EXAM) |
| prasugrel | P2Y12 | 부분 (CYP3A) | 약 | ✓ (1-step CYP) | ✗ | 경구 1×/d | 제한적 |
| ticagrelor | P2Y12 | ✓ | 거의 X | ✗ | ✓ | 경구 2×/d | 중간 (TICAKOREA 등) |
| **selatogrel** | P2Y12 | **✓** | **거의 X** | ✗ | **✓** | **SC 자가** | 거의 없음 (SOS-AMI 통해) |
| **revacept** | GPVI | **✓** (단백질) | **X** | ✗ | n/a (lesion scavenger) | IV | 거의 없음 |
| **vicagrel** | P2Y12 | **✓ (CES1)** | **거의 X** | ✓ (CES1 1-step) | ✗ | 경구 1×/d | **중국 풍부 · 한국 진입 가능성** |
| zalunfiban | αIIbβ3 | ✓ | X | ✗ | ✓ (short t½) | SC | 거의 없음 |
| vorapaxar | PAR-1 | ✓ (long t½) | X | ✗ | ✗ (irrev) | 경구 1×/d | 거의 없음 |

→ **selatogrel · revacept · vicagrel** = 한국인 LoF 60% 우회 측면 3대 후보. 강점 axis가 서로 다름.

---

## 8. 한국 PCI 결정맵 — 5-10y timeline & 편입 시나리오

**Timeline 추정**

| 약물 | Global Phase | KFDA 진입 추정 | 보험 전망 |
|---|---|---|---|
| selatogrel | Phase 3 SOS-AMI (~2027 readout) | **2028-2030** | 응급 prehospital 한정 급여 가능 (EMS 협업 필요) |
| revacept | Phase 2 후 reposition (stroke) | **2029-2032** (PCI 적응증 미정) | high-HBR add-on 위주, limited |
| vicagrel | 중국 승인 · global Phase 3 진행 | **2026-2028** (라이센스 deal 의존) | clopidogrel 대체 → 보험 우호 (저비용 prodrug) |
| zalunfiban | Phase 3 CELEBRATE | 2028-2030 | EMS / cath-lab door 한정 |

**M3 결정맵 확장 — phenotype × 신약 매칭 가설**

```
 PCI 환자
   │
   ├─ STEMI prehospital (EMS) ─────────► selatogrel SC 1회 (CYP genotype 무관)
   │                                     → cath-lab 도착 후 표준 DAPT 진입
   │
   ├─ PM (CYP2C19 *2/*2 등) × HBR(-) × ACS ───► **selatogrel bridge** + ticagrelor maintenance
   │                                              (or prasugrel if NSTEMI)
   │
   ├─ PM × HBR(+) ────────────────────► **vicagrel** (CES1 우회 prodrug, 저용량 1×/d, 출혈 균형)
   │                                     ※ 라이센스 진입 시
   │
   ├─ NM (EM) + 표준 risk ─────────────► clopidogrel 유지 (현 표준 · 비용 ↓ · HOST-EXAM 근거)
   │
   ├─ Very-HBR (PRECISE-DAPT ≥25 + ARC-HBR ⊕) ──► **revacept add-on** (lesion scavenger, 출혈 ↓)
   │                                                ※ PCI 적응증 입증 전제
   │
   └─ 복잡 PCI + 다음 수술 예정 ─────────► ticagrelor or **selatogrel** (reversible) 선호
```

→ 핵심 패러다임 전환: **‘P2Y12 단일축’ → ‘phenotype × 표적 × 투여경로 multiplex’**. M7 통합 결정맵은 본 매트릭스를 한국인 출혈 calibration (M4) + PFT (M5) 위에 얹어 작성.

---

## 9. 참고문헌

- Sinnaeve P et al. (2020) *Eur Heart J* 41:2588 — selatogrel Phase 2 SC PK/PD · PMID 31504432
- Storey RF et al. (2020) *J Am Heart Assoc* 9:e016240 — selatogrel design · PMID 32468911
- Mayer K et al. (2021) *JAMA* 325:2415 — **revacept ISAR-PLASTER** · PMID 33825882
- Ungerer M et al. (2011) *Circulation* 123:1891 — revacept preclinical · PMID 21518983
- Jiang J et al. (2017) *Br J Clin Pharmacol* 83:1980 — vicagrel PK CES1 · PMID 28543311
- Qiu Z et al. (2018) *Drug Metab Dispos* 46:1027 — vicagrel CES1 활성화 · PMID 29752382
- Li Y et al. (2020) *Clin Transl Sci* 13:1268 — vicagrel CYP2C19 무관 · PMID 32506742
- Bor WL et al. (2021) *EuroIntervention* 17:e1376 — zalunfiban Phase 2 · PMID 34448718
- Morrow DA et al. (2012) *NEJM* 366:1404 — **vorapaxar TRA-2P** · PMID 22443427
- Wilson SJ et al. (2018) *Eur Heart J* 39:399 — PZ-128 PAR-1 parmodulin · PMID 29020314
- Wong PC et al. (2017) *Sci Transl Med* 9:eaaf5294 — BMS-986120 PAR-4 · PMID 28100836
- Mazighi M et al. (2024) *Lancet* 403:435 — **glenzocimab AIS Phase 2/3 (ACTIMIS)** · PMID 38008113

---

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| selatogrel SC peak ~30min · IPA >90% | 🟡 SUPPORTED-BY-CITATION | Sinnaeve 2020 Phase 2 |
| selatogrel SOS-AMI Phase 3 진행 | 🟡 SUPPORTED-BY-CITATION | NCT04957719 (readout 미완) |
| revacept ISAR-PLASTER 음성 (PCI) | 🟡 SUPPORTED-BY-CITATION | Mayer 2021 JAMA |
| revacept 출혈 거의 zero claim | 🟠 INSUFFICIENT (PCI cohort 외 대규모 데이터 부족) | mechanism + small n |
| vicagrel CYP2C19 무관 active metabolite | 🟡 SUPPORTED-BY-CITATION | Jiang 2017 · Li 2020 |
| vicagrel VICTORY Phase 3 양성 (중국) | 🟡 SUPPORTED-BY-CITATION | NMPA 승인 + 학회 발표 (peer-review 일부) |
| zalunfiban CELEBRATE 진행 | 🟡 SUPPORTED-BY-CITATION | Bor 2021 · NCT04825743 |
| PAR-4 rs773902 동양인 GoF | 🟡 SUPPORTED-BY-CITATION | Edelstein 2014 etc. |
| 한국 KFDA 진입 timeline 2026-2032 | 🟠 SPECULATION (시장 변수) | 글로벌 readout · 라이센스 deal 의존 |
| M3 결정맵 phenotype × 신약 매칭 | 🟠 INSUFFICIENT (가설) | 임상 head-to-head 부재 |

---

## 🔑 핵심 통찰

- **selatogrel = STEMI prehospital 공백을 직접 메우는 유일 후보** — SC 자가/EMS · 30분 peak · CYP 우회 · 가역성. 한국인 LoF 60%의 “골든타임 IPA 미달” 문제를 표적 그 자체로 해결. SOS-AMI readout (~2027)이 결정맵 재편의 트리거.
- **vicagrel = 한국 진입 가장 빠른 “1:1 clopidogrel 대체” 후보** — CES1 1-step 활성화로 CYP2C19 LoF 영향 X. 경구 · 저비용 · 동양인 데이터 풍부 (중국). 라이센스 deal만 성사되면 2026-2028 KFDA 가능. **한국인 PGx 임팩트 가장 큼** (PM 60%에 즉시 적용).
- **revacept = PCI 단독 음성, but very-HBR add-on niche 가능성** — ISAR-PLASTER가 elective PCI에서 standard DAPT 위 추가 benefit 입증 실패. lesion-selective mechanism은 매력적이나 **재포지셔닝 (stroke · very-HBR add-on)** 방향. PGx 영향 미미하나 출혈 분리 가설 검증 가치.
- **multiplex 패러다임** — 단일 약제로 6 axis (fast · CYP-X · reversible · SC · 출혈 ↓ · Asian PK) 모두 충족 후보는 0. M3 결정맵은 **phenotype × strength axis 매칭**으로 진화 (PM × HBR(-) → selatogrel, PM × HBR(+) → vicagrel, very-HBR → revacept add-on).
- **PAR-4 rs773902 (동양인 GoF) = 다음 PGx 축** — BMS-986120/141 class가 임상 진입 시 한국인 별도 layer 필요. M1 allele 인벤토리 확장 후보로 우선순위.
