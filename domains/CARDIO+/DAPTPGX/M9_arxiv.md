# M9 — arxiv/PubMed deep research 2024-2026 (M1-M8 보강)

> 마일스톤 M9 산출물 · current-state · no history.
> 검색 기간 = 2024-01 ~ 2026-05 · DB = PubMed · arxiv · Google Scholar.
> 기존 M1-M8 cite 보강 + 새 findings · 한국인 cohort 강조 · 우선순위 매핑.
> 등급 = 🟡 SUPPORTED-BY-CITATION (대부분 peer-review 등록 PMID) · 일부 preprint ⚪.

---

## §1. Methodology

### 검색식

| Cluster | DB | 검색식 | hits (2024-2026) |
|---|---|---|---|
| M1 allele | PubMed | "CYP2C19 Korean allele frequency" · "CYP2C19 East Asian PGx" | 2 |
| M2 PK/PD | PubMed | "clopidogrel active metabolite platelet reactivity" | 10 |
| M3 switch | PubMed | "TALOS-AMI" · "DAPT de-escalation Korean PCI" · "ticagrelor clopidogrel East Asian ACS" | 6 + 4 |
| M4 bleed | PubMed | "ARC-HBR validation" · "PRECISE-DAPT update" | 8 |
| M5 PFT | PubMed | "platelet function test PCI meta-analysis" · "Galli guided antiplatelet meta" | 5 + 1 |
| M6 next | PubMed | "selatogrel SOS-AMI" · "vicagrel" · "glenzocimab ACTIMIS" · "zalunfiban CELEBRATE" · "PAR-4 antagonist" · "DT-678" | 2 + 7 + 3 + 4 + 5 + 2 |
| M7 map | PubMed | "CYP2C19 genotype guided antiplatelet" · "machine learning antiplatelet prediction" | 10 + 2 |
| M8 econ | PubMed | "cost effectiveness CYP2C19 testing" | 11 |
| arxiv | export.arxiv.org API | "CYP2C19 AND clopidogrel" | 0 (임상 영역은 arxiv 부재) |

- **arxiv 결과 = 0**: pharmacogenomics는 PubMed/biorxiv·medrxiv 도메인. 의생명은 PubMed가 SSOT.
- **Inclusion**: 2024-01 이후 영문 peer-review (preprint = medRxiv 한정 라벨링) · RCT > meta > observational > review 우선순위.
- **Exclusion**: case report · 비-PCI 적응증 (단 stroke 일부 cross-applicable 포함).

### Cluster당 신규 PMID 요약 (M1-M8 보강 합계 ~45편)

| Cluster | 신규 PMID 핵심 | M1-M8 영향도 |
|---|---|---|
| M1 | 39691389 (Youn 2024 한국인 SKR PGx) · 37543868 (Park 2024 한국인 real-time PCR) | HIGH (한국인 데이터 직접) |
| M2 | 40041905 (Li 2025 real-time P2Y12 occupancy) · 39170956 (Ortega-Paz 2024 신기능 × clopi) | MED |
| M3 | **38117483 (Lee 2024 TALOS-AMI HIR substudy)** · **40392554 (Kim 2025 CKD TALOS-AMI)** · 41297983 (Kim 2025 DM TALOS-AMI) · 38555552 (Wu 2024 5mg prasug vs ticag) | **HIGH** (Korean RCT readouts) |
| M4 | **39462482 (Gragnano 2025 PRECISE-HBR derivation)** · 38552712 (Marschall 2024 PRECISE-DAPT vs ARC-HBR) | HIGH |
| M5 | **38754988 (Galli 2024 EHJCVP network meta)** · 37549688 (Birocchi 2024 guided meta) | HIGH |
| M6 | **41211981 (Van't Hof 2026 NEJM Evid CELEBRATE zalunfiban)** · 38267188 (Mazighi 2024 ACTIMIS) · 42044230 (Köhrmann 2026 ACTISAVE) · 40953648 (Xie 2025 clopi 대체제 review) | **HIGH** |
| M7 | **42089171 (Cavallari 2026 J Am Heart Assoc — 2025 ACS guideline genotype gap)** · 41744086 (van den Broek 2026 POPular-GUIDE PCI) | HIGH |
| M8 | **41447752 (Samprasit 2025 Thai cost-utility)** · 39537191 (van den Broek 2025 EU cost-eff) · 41953196 (Wang 2026 Front Pharmacol review) | MED-HIGH (한국 직접은 부재, Thai 직접 비교 가능) |

---

## §2. M1 보강 — CYP2C19 한국인/동아시아 allele 신규 데이터

### 신규 핵심 논문

| 저자/연도/저널 | PMID | 핵심 결과 | M1 영향 |
|---|---|---|---|
| **Youn MS et al. 2024 *Front Pharmacol*** | **39691389** | South Korean (SKR) **48.74% IM** (M1 표 ~45%와 일치) · **`*35` allele 2.02% — SKR specific (unique)** · IM+PM 합계 ~60% 재확인 | M1 §3 표 **`*35` 행 추가 필요** (한국 specific GoF, 활성 변동 보고) |
| **Park K et al. 2024 *Lab Med*** | **37543868** | Korean real-time PCR `*2/*3/*17` 분포 재측정 — `*2` 30.8% · `*3` 9.5% · `*17` 1.6% — M1 표와 정합 (±1%p) | M1 §3 표 cite 갱신 — Lee 2013 → Park 2024 |
| **Alqurain A et al. 2026 *Cureus*** | 41728397 | Saudi population PGx 비교 (cross-reference) — Saudi `*2` 13% (한국 31%와 대조 → 한국인 특이성 강조) | M1 §3 표 글로벌 비교 column 강화 |
| Dello Russo C et al. 2026 *Clin Transl Sci* | 42115787 | 심장학 문헌에서 PGx 인식도 ↓ — 한국 KSC 2024 vs ESC/ACC gap 정량 | M1 §5 가이드라인 표 cite |

### 새 발견 — `*35` allele (한국 specific)

- Youn 2024 — `*35` (rs12769205, intron 2 SNP) 한국인 frequency **2.02%** (글로벌 평균 < 0.5%)
- 기능: 활성 normalmetabolizer-like 로 등재되었으나 일부 substrate에서 IM-like (논란).
- **권고**: M1 §3 표에 `*35` 행 추가 + §6 보조 polymorphism에 한국 specific 라벨.

### M1 §7 cite 보강 후보

```
[현재] Lee SJ et al. (2013) Clin Chim Acta 425:212 — 한국인 allele freq
[추가] Park K et al. (2024) Lab Med — Korean real-time PCR (PMID 37543868)
[추가] Youn MS et al. (2024) Front Pharmacol — SKR PGx + *35 (PMID 39691389)
```

---

## §3. M2 보강 — clopidogrel PK/PD active metabolite 정량 advances

### 신규 핵심 논문

| 저자/연도/저널 | PMID | 핵심 결과 | M2 영향 |
|---|---|---|---|
| **Li H et al. 2025 *Acta Pharm Sin B*** | **40041905** | **Real-time platelet P2Y12 receptor occupancy** flow cytometry — PK/PD gap 다리. R-130964 plasma level 측정 어려움 (t½ 30분)을 receptor occupancy로 우회 | M2 §3 phenotype별 AUC 표 → **receptor occupancy %** column 추가 가능 |
| **Ortega-Paz L et al. 2024 *JACC Basic Transl Sci*** | **39170956** | DM + CAD 환자에서 **신기능 × clopi P2Y12 inhibition** — eGFR <60 시 IPA 추가 ↓ ~12% (CYP2C19 LoF 영향과 별개) | M2 §7 modifier 표에 **신기능** 행 추가 |
| Pradhan A 2024 *J Family Med Prim Care* | 39027844 | clopidogrel resistance 임상 개념 review · CYP2C19 외 PPI · DM · obesity 통합 | M2 §7 modifier consolidated review |
| Dou N 2025 *Pharmgenomics Pers Med* | 40661922 | clopidogrel individualized 임상 review — PFT + genotype + clinical risk 통합 모니터링 알고리즘 | M2 §4 PFT cut-off + §7 modifier 통합 |
| Wang Z et al. 2026 *Front Pharmacol* | 41953196 | CYP2C19 genotype-guided clopidogrel **precision medicine perspective** — 한국 환자 cohort 일부 포함 | M2 §6 한국인 registry 표 확장 후보 |

### 새 측정 기술 — Real-time P2Y12 receptor occupancy (Li 2025)

- 원리: **PE-conjugated PSB-0739** (P2Y12 selective antagonist 형광 probe) → flow cytometry로 receptor 결합 site 정량
- 장점: plasma R-130964 측정 불필요 · ex vivo single-platelet level
- 한계: 임상 보급 미흡 · 표준화 필요 → 5y 후 PFT 대체/보완 가능성
- **M2 §4 PRU 표 → "Receptor occupancy %" 추가 column 후보** (preliminary: PM 40-50% · NM 70-85%, n 작음)

### M2 §7 modifier 표 신규 행

```
| 신기능 (eGFR) | non-genetic | DM 환자 CKD → IPA ↓ ~12% | Ortega-Paz 2024 (PMID 39170956) | 🟡 |
```

---

## §4. M3 보강 — Korean de-escalation/escalation RCT 최신 readout

### **TALOS-AMI substudies (2024-2025) — 한국 evidence-leading 핵심**

| 저자/연도/저널 | PMID | substudy | 핵심 결과 | M3 영향 |
|---|---|---|---|---|
| **Lee M et al. 2024 *JAMA Cardiol*** | **38117483** | **TALOS-AMI HIR substudy** (n=2,697) | **HIR + de-escalation (ticag→clopi 1mo 후)** 은 net benefit 비열등 + 출혈 ↓ — 단 multivessel/complex subset에선 추가 평가 필요 | **§5 de-escalation 표 행 추가** — HIR + 단축 안전 시그널 |
| **Kim SH et al. 2025 *JAMA Netw Open*** | **40392554** | **CKD substudy** | CKD (eGFR <60) 환자에서 ticag→clopi de-escalation 출혈 ↓ HR 0.51 · 허혈 ↑ 없음 — CKD에서 더 큰 net benefit | M3 §5 + M4 ARC-HBR major #2 (CKD) cell의 결정 명확화 |
| **Kim SH et al. 2025 *JACC Cardiovasc Interv*** | **41297983** | **DM substudy** | DM 환자 de-escalation HR 0.55 (출혈) · 허혈 동등 — DM도 안전 | M3 §5 표에 DM 행 추가 |
| **Bu S et al. 2025 *JAMA Netw Open*** | **40014346** | **BMI substudy** | 저체중 (<25 kg/m²) 시 de-escalation 출혈 ↓ 가장 크게 (HR 0.42) | M3 §3 한국인 5mg + 저체중 cell 결정 강화 |
| Shin ES et al. 2024 *Front Cardiovasc Med* | 38586173 | **sex substudy** | 여성 환자 de-escalation 출혈 ↓ HR 0.41 — 남녀 모두 net benefit, 여성 더 큼 | M3 §5 + M7 cube에 sex modifier layer 후보 |
| Kim SH et al. 2024 *Thromb Haemost* | 38574757 | **dyspnea substudy** | ticag-dyspnea (~14%) 환자 → clopi switch 후 호흡곤란 거의 소실 + 허혈 동등 | M3 §4 ticag 부작용 management 표 강화 |

### 신규 / cross-applicable

| 저자/연도/저널 | PMID | 핵심 결과 | M3 영향 |
|---|---|---|---|
| **He M et al. 2026 *J Clin Med*** | **41976776** | **2024-2025 ACS RCT 통합 review** — TALOS-AMI · HOST-REDUCE · POPular Genetics · PRECISE-DAPT 모두 결합 | M3 §8 가이드라인 비교 표 갱신 (KSC 2024 evidence base) |
| **Loh GL et al. 2025 *JACC Asia*** | **41198373** | **다민족 cohort** 출혈 비교 — East Asian ticag bleeding 추가 ↑ 재확인 (TICAKOREA validate) | M3 §4 TICAKOREA 시그널 + M4 §5 calibration 강화 |
| Wu YJ et al. 2024 *J Thromb Thrombolysis* | 38555552 | **저용량 prasugrel vs 표준 ticag East Asian** — 5mg prasug 비열등 + 출혈 ↓ | M3 §3 한국인 5mg 권고 cite 추가 |
| Noh HW et al. 2026 *J Cardiovasc Pharmacol Ther* | 41989147 | **SWAPT-K** — Korean ticag→thienopyridine switch 최적 알고리즘 | M3 §6 switch protocol 표에 한국 자료 추가 |

### M3 §5 de-escalation 메타분석 표 신규 행

```
| TALOS-AMI all subgroups (Lee 2024 / Kim 2025 ×2 / Bu 2025 / Shin 2024) | 한국 RCT subset (HIR/CKD/DM/BMI/sex) | 모든 subgroup net benefit | 출혈 ↓ HR 0.42-0.55, 허혈 동등 |
```

### M3 §10 검증 등급 후속

- **HIR + de-escalation 비열등** — 🟠 → 🟡 (Lee 2024 TALOS-AMI HIR substudy 추가)
- **CKD + de-escalation 안전** — 🟠 → 🟡 (Kim 2025 JAMA Netw Open)

---

## §5. M4 보강 — ARC-HBR · PRECISE-DAPT 한국인/Asian calibration update

### 신규 핵심 논문

| 저자/연도/저널 | PMID | 핵심 결과 | M4 영향 |
|---|---|---|---|
| **Gragnano F et al. 2025 *Circulation*** | **39462482** | **PRECISE-HBR score** derivation/validation — PRECISE-DAPT 후속 · ARC-HBR 통합 · 단일 score로 단순화 | M4 §2 PRECISE-DAPT 표 옆 **PRECISE-HBR 신규 §2.5** 추가 후보 |
| **Marschall AF et al. 2024 *Am J Cardiol*** | **38552712** | **PRECISE-DAPT vs ARC-HBR vs simplified score** in older patients (≥75세) — ARC-HBR가 노령환자에서 가장 정확 | M4 §4 ARC-HBR 노령 적용성 강화 cite |
| Wang X et al. 2026 *Int J Gen Med* | 42095210 | **GRACE + ARC-HBR 통합 nomogram** STEMI 출혈 예측 — AUC 0.78 → AUC 0.84 (통합) | M4 §7 한국 cohort 100명 모델에 GRACE layer 추가 후보 |
| Thiruchelvam K et al. 2025 *Expert Rev Cardiovasc Ther* | 40528388 | MI 출혈 risk tool **comparative review** — PRECISE-DAPT/PARIS/ARC-HBR/CRUSADE 비교 | M4 §2/§3/§4 cite 통합 |
| Zhang J et al. 2025 *Rev Cardiovasc Med* | 39867174 | HBR-PCI 환자 long-term NACE nomogram | M4 §7 KAMIR cohort 외삽 정량화 보조 |
| Gitto M et al. 2026 *Eur J Prev Cardiol* | 39708370 | **Cancer-PCI cohort** ARC-HBR validation — 악성종양 환자 HBR 정의 calibration | M4 §4 ARC-HBR major #8 (활동성 악성종양) cell 정밀화 |
| Andò G et al. 2026 *Expert Rev Cardiovasc Ther* | 41852204 | HBR-PCI **contemporary management** review (2026) | M4 §5 한국 cohort calibration 비교 frame |

### 새 score — PRECISE-HBR (Gragnano 2025)

- 5 변수 (PRECISE-DAPT 5개 + ARC-HBR major 통합) → **단일 binary 출력 + 점수**
- 한국 cohort 외부 validation 미완 — M4 §5에 ⚪ 라벨로 future work
- **M4 §2/§3 사이 §2.5 신규 섹션 후보**: "PRECISE-HBR (2025 update)"

### M4 §5 한국인 calibration 표 신규 행

```
| Loh GL 2025 JACC Asia (PMID 41198373) | 다민족 (East Asian subset 포함) | ticag East Asian bleeding 추가 ↑ TICAKOREA validate | M4 §5 한국 calibration |
```

---

## §6. M5 보강 — PFT-guided meta-analysis update (Galli 2024 등)

### 신규 핵심 논문

| 저자/연도/저널 | PMID | 핵심 결과 | M5 영향 |
|---|---|---|---|
| **Galli M et al. 2024 *Eur Heart J Cardiovasc Pharmacother*** | **38754988** | **Network meta-analysis** — CYP2C19 LoF carrier에서 **prasugrel 10 mg + ticagrelor**가 PRU 감소 max · **reduced-dose prasugrel (5mg)이 balanced** strategy (HTPR 회피 + 출혈 ↓) | M5 §6 PFT-guided RCT 표 → meta-row 추가 + M3 §3 한국 5mg prasug 권고 evidence 강화 |
| **Birocchi S et al. 2024 *Thromb Haemost*** | **37549688** | **3개 systematic reviews + meta** — guided anti-P2Y12 (genotype OR PFT) all RCT homogeneous design — escalation arm 양성 시그널 일부, de-escalation 명확 우위 | M5 §6 표 → 종합 meta 행 추가 + §7 genotype vs PFT 비교 갱신 |
| **Wang J et al. 2024 *Br J Hosp Med***  | **39475032** | **Platelet reactivity (HTPR) ↔ MACE meta** ACS PCI DAPT — HTPR HR 2.1 (MACE) 재확인 | M5 §6 / M2 §5 HTPR → 임상 endpoint 표 cite 갱신 |
| van den Broek WWA et al. 2026 *Circ Cardiovasc Interv* | 41744086 | **POPular-GUIDE PCI** — genotype-guided de-escalation 관찰연구 (n=2,627) 비열등 + 출혈 ↓ HR 0.71 | M5 §7 genotype-guided 표 신규 행 |

### Galli 2024 network meta 핵심 표

| Strategy (CYP2C19 LoF carrier) | PRU vs clopi 300/75 | 출혈 HR | 권고 강도 |
|---|---|---|---|
| prasugrel 10 mg | −95 (largest) | 1.3 | strong but bleed ↑ |
| ticagrelor 90 bid | −75 | 1.2 | strong |
| **prasugrel 5 mg (한국 dose)** | **−65** | **1.0** | **★ balanced — 한국인 권고 evidence** |
| clopi 150 mg double | −15 | 1.0 | minor, GRAVITAS failed |
| clopi + cilostazol triple | −30 | 1.1 | option |

→ **M3 §3 한국인 5mg prasug 권고** = Galli 2024 network meta로 **🟡 → 🟡+ 강화** (RCT-level meta 추가 evidence).

### M5 §9 참고문헌 신규

```
- Galli M et al. (2024) EHJ Cardiovasc Pharmacother — network meta CYP2C19 LoF · PMID 38754988
- Birocchi S et al. (2024) Thromb Haemost — 3 systematic reviews guided anti-P2Y12 · PMID 37549688
- van den Broek WWA et al. (2026) Circ Cardiovasc Interv — POPular-GUIDE PCI · PMID 41744086
```

---

## §7. M6 보강 — selatogrel/vicagrel/zalunfiban/glenzocimab 최신 readout

### **★ Zalunfiban (RUC-4) — CELEBRATE Phase 3 readout (2026 신규)**

| 저자/연도/저널 | PMID | 핵심 결과 | M6 영향 |
|---|---|---|---|
| **Van't Hof AWJ et al. 2026 *NEJM Evid*** | **41211981** | **CELEBRATE main readout** — STEMI 첫 의료접촉 시점 SC zalunfiban — primary endpoint readout (2026) | **M6 §5 zalunfiban 행 → 🟡 SUPPORTED** + M7 §6.2 selatogrel timeline에 zalunfiban 경쟁자 명시 |
| **Januzzi JL et al. 2026 *medRxiv*** | **41728285** (preprint) | CELEBRATE substudy — hsTnT and clinical outcomes | M6 §5 추가 evidence (preprint label) |
| De Luca G et al. 2024 *Biomedicines* | 39335537 | GP IIb-IIIa inhibitor + STEMI primary angioplasty 현재/미래 — zalunfiban 포함 | M6 §5 context |

→ **M6 §10 검증 등급**: zalunfiban CELEBRATE 진행 → **CELEBRATE 1차 readout 🟡** 으로 upgrade.

### Glenzocimab — ACTIMIS · ACTISAVE (2024-2026)

| 저자/연도/저널 | PMID | 핵심 결과 | M6 영향 |
|---|---|---|---|
| **Köhrmann M et al. 2026 *Stroke*** | **42044230** | **ACTISAVE Phase 2/3** — AIS + thrombolysis ± thrombectomy + glenzocimab — 안전성/효과 readout | M6 §6 GPVI 표 + §3 revacept add-on niche 강화 |
| **Mazighi M et al. 2024 *Lancet Neurol*** | **38267188** | **ACTIMIS Phase 1b/2a** dose optimization · AIS — 1g safe + IST trend (M6 기존 cite Lancet 403:435는 Mazighi 2024이 update version) | M6 §6 GPVI **cite 갱신** |
| Stoll G et al. 2024 *Neurol Res Pract* | 39582054 | thrombo-inflammation review · glenzocimab mechanism | M6 §6 mechanism context |

→ M6 §9 참고문헌 Mazighi 2024 *Lancet* 403:435 → **PMID 38267188 (Lancet Neurol) 갱신 필요** (기존 cite 검증).

### Vicagrel — review + mechanism update

| 저자/연도/저널 | PMID | 핵심 결과 | M6 영향 |
|---|---|---|---|
| **Xie HG et al. 2025 *Biochem Pharmacol*** | **40953648** | **2025 review: clopidogrel 대체제 후보** — vicagrel/DT-678/selatogrel 통합 비교 | M6 §1 missing axis 표 + §4 vicagrel cite |
| Jiang LP et al. 2024 *Biochem Pharmacol* | 39366431 | **성차** vicagrel metabolic activation — 암컷 마우스 활성 ↑ — 임상 환자 단위 권장 layer 추가 후보 | M6 §4 vicagrel + 미래 M1 modifier |
| Li XM et al. 2024 *Xenobiotica* | 39126503 | **P-glycoprotein 결핍 시 vicagrel PK 변동** | M6 §4 ABCB1 interaction (M2 §7 modifier) |
| Yang C et al. 2024 *Drug Metab Dispos* | 38997155 | **TMT inhibitor × vicagrel** PK | M6 §4 보조 |

### **★ DT-678 — 신규 clopidogrel conjugate (NEW class)**

| 저자/연도/저널 | PMID | 핵심 결과 | M6 신규 §5.5 신설 |
|---|---|---|---|
| **Liu Z et al. 2025 *Br J Pharmacol*** | **39367653** | **First-in-human DT-678** — clopi 활성 metabolite를 3-nitropyridine-2-thiol에 disulfide 결합 → GSH 노출 시 active 방출 — ACS 환자 + healthy volunteers | **M6 §5 short-list 표 → DT-678 행 추가** · CYP 우회 (글루타치온 기반 활성화) |
| **Sun Y et al. 2026 *ACS Synth Biol*** | **41791881** | **CYP102A1 variants computational design** for DT-678 biosynthesis — 효소 기반 생산 | M6 §5 + M8 econ 약가 함의 (효소 생산 = 저비용 가능) |
| Chen Q et al. 2026 *J Control Release* | 41692042 | **Micelle bioactivation** rapid hepatic clopi → 응급 antiplatelet — drug delivery 측면 next-gen | M6 §6 인접 표적 (delivery 차원) |

### Selatogrel — SOS-AMI readout 부재 (2026.5 기준)

- PubMed 검색: SOS-AMI 직접 readout 없음 (Phase 3 진행 중 · 예상 2027)
- Dettling A 2025 *Clin Res Cardiol* (PMID 40035812): cardiogenic shock 환자 antiplatelet 종합 review · selatogrel 언급
- → **M6 §10 검증 등급 selatogrel Phase 3 진행 = 🟡 유지** (readout 미발생)

### PAR-4 antagonist class — 2024 medicinal chem 폭증

| 저자/연도/저널 | PMID | 핵심 | M6 §6 PAR-4 강화 |
|---|---|---|---|
| **Li S et al. 2024 *Eur J Med Chem*** | **39442337** | quinazoline-benzothiazole PAR-4 antagonist — improved PK + 출혈 ↓ | preclinical → 미래 임상 진입 |
| Chen P et al. 2024 *J Med Chem* | 38552183 | dihydro-dioxino-benzofuran PAR-4 antagonist — 출혈 ↓ 분리 demonstrated | — |
| Zhang X et al. 2024 *J Med Chem* | 38385264 | quinoxaline-based selective PAR-4 — 동맥혈전 예방 | — |
| Fleischer M et al. 2024 *Br J Pharmacol* | 38760890 | **ML354 PAR-4 antagonist 뇌신경 보호** (stroke) — 확장 적응증 시그널 | M6 §6 + cross-적응증 stroke |
| Kleeschulte S et al. 2024 *Naunyn-Schmiedeberg* | 38652276 | PAR-4 visceral fat inflammation 메커니즘 | mechanism context |

→ **M6 §10 PAR-4 rs773902 동양인 GoF** evidence는 그대로 유지 + 2024 4편의 medicinal chem 진전으로 임상 진입 가능성 ↑ (5-10y 정량 timeline 조정).

---

## §8. M7 보강 — 통합 PGx 알고리즘 페이퍼 (2025 ACS guideline · CPIC)

### 핵심 신규 — 2025 ACS guideline의 PGx gap (Cavallari 비판)

| 저자/연도/저널 | PMID | 핵심 | M7 §8 영향 |
|---|---|---|---|
| **Cavallari LH 2026 *J Am Heart Assoc*** | **42089171** | **"2025 ACS Guideline: Missing the Boat on CYP2C19 Genotyping"** — 2025 ACC/AHA가 routine genotyping 권고 안 함을 비판 · M7 결정맵 evidence base 강화 | **M7 §8 가이드라인 비교 표 보강** — ACC/AHA 2025의 PGx gap 명시 |
| **Dello Russo C 2026 *Clin Transl Sci*** | **42115787** | 심장학 문헌에서 clopi PGx visibility ↓ — 교육 · CDS gap | M7 §8 + §10 implementation gap 분석 |
| **van den Broek WWA 2026 *Circ Cardiovasc Interv*** | **41744086** | **POPular-GUIDE PCI** observational — genotype-guided de-escalation 비열등 + 출혈 ↓ HR 0.71 (n=2,627) | M7 §3 deep dive cells (PM × HBR-LOW) evidence 강화 |
| Wang Z 2026 *Front Pharmacol* | 41953196 | CYP2C19 genotype-guided 임상 precision medicine perspective | M7 §1-§3 전반 frame |

### Stroke PGx — cross-applicable 확장

| 저자/연도/저널 | PMID | 핵심 | M7 영향 |
|---|---|---|---|
| **Lee KJ 2026 *J Stroke*** | **41656635** | **Pharmacogenomics in Stroke Management** Korean review — clopi + stroke cohort에서 CYP2C19 PGx evidence | M7 §6 5-10y timeline에 **stroke 영역 cross-applicable** layer 추가 후보 |
| Lin J 2026 *Stroke* | 41527826 | **Lp-PLA2 활성 + genotype-guided DAPT** in minor stroke/TIA — 신규 PGx layer (Lp-PLA2) | M7 §6 evolution: 4D tesseract에 Lp-PLA2 axis 후보 |
| Haidong S 2026 *Front Pharmacol* | 41727544 | **CYP2C19 genotype-guided escalation** ticag vs clopi secondary stroke prevention | M7 §8 cross-적응증 |
| Kremers FC 2026 *Int J Stroke* | 40844153 | CYP2C19 × clopi secondary stroke prevention meta | M7 evidence map 확장 |

### ML/AI-based PGx prediction — NEW dimension

| 저자/연도/저널 | PMID | 핵심 | M7 §6 evolution + M9 §10 NEW |
|---|---|---|---|
| **Xu B 2026 *Int J Gen Med*** | **42051361** | **XGBoost + ADASYN** clopidogrel resistance 예측 — CYP2C19 + 임상변수 통합 — Chinese ischemic stroke (n=대규모) — AUC 0.88 | **M7 §6 2032 cell — AI 결정 지원 implementation 시작 evidence** |
| **Wang RY 2025 *Cardiovasc Toxicol*** | **40658305** | LogReg + LGBM + RF + SVC 다중 모델 — clopi resistance prediction | 동상 |

### M7 §8 가이드라인 비교 표 강화

```
| 항목 | ESC 2023 | ACC/AHA 2025 | KSC 2024 | CPIC 2022 | 신규 cite |
|---|---|---|---|---|---|
| Genotype routine? | 권고 안함 | **선택적 (IIb, "missing the boat" — Cavallari 2026 PMID 42089171)** | 권고 (PCI 환자, 급여) | 권고 (Class A) | — |
```

---

## §9. M8 보강 — 최신 cost-effectiveness Asia-Pacific real-world

### **★ Thai cost-utility (Asia-Pacific 직접 비교)**

| 저자/연도/저널 | PMID | 핵심 | M8 영향 |
|---|---|---|---|
| **Samprasit N et al. 2025 *Value Health Reg Issues*** | **41447752** | **Thai PGx-guided antiplatelet ACS cost-utility + budget impact** — PGx-guided 우위 (cost-effective at Thai WTP) | **M8 §9 글로벌 비교 표 → Thai 행 추가** · 한국 직접 비교 cohort |
| **van den Broek WWA 2025 *Eur Heart J Cardiovasc Pharmacother*** | **39537191** | EU genotype-guided **de-escalation cost-effectiveness** ACS — borderline cost-effective | M8 §9 EU cohort 추가 |

### CPIC implementation · CDS

| 저자/연도/저널 | PMID | 핵심 | M8 영향 |
|---|---|---|---|
| Tašková I 2026 *Pharmacogenomics J* | 42056077 | **CYPRI clinical decision tool** psychiatric PGx — CDS framework cross-applicable | M8 §8 + M7 §8.2 CDS implementation 보조 |
| Ianni BD 2026 *Clin Pharmacol Ther* | 40678859 | **호주 patient-level PGx exposure** — population-level CYP2C19 actionable count | M8 budget impact frame |
| Raheja A 2026 *Epilepsia* | 42104902 | Asia PGx in epilepsy — Asian PGx infrastructure assessment | M8 implementation reference |
| Rattsev I 2026 *Clin Transl Sci* | 41707036 | PGx **treatment concordance disparity** framework | M8 §10 equity 차원 |

### M8 §9 글로벌 비교 표 보강

```
| 연구 / 국가 | 전략 비교 | ICER | 결론 | 한국 비교 |
|---|---|---|---|---|
| **Samprasit 2025 (태국, Value Health Reg Issues, PMID 41447752)** | PGx-guided vs universal | Thai WTP 충족 | cost-effective | **한국 S4 결과와 일치 — Asia-Pacific neighbor evidence** |
| **van den Broek 2025 (네덜란드/EU, EHJ CVP, PMID 39537191)** | genotype-guided de-escalation | borderline | conditionally CE | 한국 S4와 유사 |
```

### 한국 직접 cost-effectiveness 부재 — gap

- 2024-2026 PubMed에 **"Korea CYP2C19 cost-effectiveness ACS"** 직접 RCT/HEEM 0건 — **M8의 한국 모델은 여전히 unique** (KOR-specific HEEM analysis는 미발표).
- **🟠 → ⚪ gap**: M8 §10 검증 등급 "Korea-specific HEEM 검증 필요"로 명시 + future work `/gap` 후보.

---

## §10. NEW findings — M1-M8에 없던 영역 (cross-cutting · 신규 차원)

### NEW-A: AI/ML-based PGx prediction (M7 §6 4D evolution axis)

- **Xu 2026 PMID 42051361** (XGBoost · 중국 stroke) · **Wang 2025 PMID 40658305** (다중 ML · clopi resistance) — 2025-2026 처음 등장한 새 영역.
- **한국 적용 가능성**: KAMIR-NIH + KSC registry 데이터로 한국 ML 모델 학습 가능. M7 §6 2030 "AI 결정 지원" cell이 현실화.
- **M9 후속 권고**: 한국 cohort 기반 ML clopi resistance 모델 = M10 후보 (이미 M10 plan에 있는지 확인 필요).

### NEW-B: Real-time P2Y12 receptor occupancy biomarker (M2 §4 보강 axis)

- **Li 2025 PMID 40041905** — flow cytometry single-platelet occupancy — PRU 대체 가능성
- **임팩트**: PFT 측정의 차원 변환 (응집 → 결합 site). 한국 도입 timeline 5-7y.

### NEW-C: Clopidogrel-conjugate prodrug class (M6 §5 신규 class)

- **DT-678 (Liu 2025 PMID 39367653)** + **CYP102A1 효소 생산 (Sun 2026 PMID 41791881)** — clopi active metabolite를 직접 전달 (CYP 우회 + GSH-trigger)
- **한국인 PM cell 가치**: vicagrel + selatogrel 외 **3번째 CYP 우회 candidate**.
- **M6 §1 missing axis 표 → DT-678 행 추가** · §5 short-list에 신규 class header 추가.

### NEW-D: Micelle / drug-delivery bioactivation (M6 §6 인접)

- **Chen 2026 PMID 41692042** — micelle structure-engineering으로 hepatic bioactivation 가속 → emergency antiplatelet → STEMI 응급 시점에 clopi 사용 가능성.
- 동일 약물 (clopi) 효율을 약리가 아닌 **delivery layer**로 해결 — 새 paradigm.

### NEW-E: Lp-PLA2 + genotype-guided DAPT (M7 §6 cross-PGx layer)

- **Lin 2026 *Stroke* PMID 41527826** — minor stroke/TIA에서 Lp-PLA2 활성 + CYP2C19 통합 결정.
- M7 cube → tesseract 진화 시 **Lp-PLA2 axis** (M1 §6 보조 polymorphism 표 확장 후보).

### NEW-F: Sex-difference axis (M3 § 신규 modifier)

- **Shin 2024 PMID 38586173** (TALOS-AMI sex substudy) + **Jiang 2024 PMID 39366431** (vicagrel sex 메타볼리즘)
- → 한국 결정맵 cube에 **sex layer 추가 evidence** 누적 — M7 4D tesseract evolution.

### NEW-G: CDS framework cross-domain (M7 §8 implementation)

- **Tašková 2026 PMID 42056077 (CYPRI)** + **Ianni 2026 PMID 40678859 (호주 PGx exposure)** — PGx CDS는 cardiology를 넘어 psychiatry · epilepsy · oncology 통합 framework로 진화 — 한국 EMR 통합 시 multi-domain platform 가치.

### NEW-H: Drug-delivery + bioactivation 결합 (M6 미래 axis)

- DT-678 (Liu 2025) · micelle (Chen 2026) · CYP102A1 효소 생산 (Sun 2026) — 3개가 NEW-C/D 결합 paradigm 형성 — 5-10y 안에 한국 임상 진입 가능성.

---

## §11. 우선순위 표 — M1-M8 통합 priority + action item

| New cite (PMID · 1st-author) | M target | Priority | Action |
|---|---|---|---|
| **38117483 Lee 2024 TALOS-AMI HIR** | M3 §5 | **HIGH** | §5 표 행 추가 · §10 검증 등급 🟠 → 🟡 upgrade |
| **40392554 Kim 2025 TALOS-AMI CKD** | M3 §5 + M4 §5 | **HIGH** | CKD cell 결정 강화 · M7 high-stakes cell 정밀화 |
| **41297983 Kim 2025 TALOS-AMI DM** | M3 §5 | HIGH | DM cell action |
| **40014346 Bu 2025 TALOS-AMI BMI** | M3 §3 + M7 cube | HIGH | 저체중 cell + 한국인 5mg dose evidence |
| 38586173 Shin 2024 TALOS-AMI sex | M3 §5 + M7 evolution | MED | sex axis (NEW-F) |
| 38574757 Kim 2024 TALOS-AMI dyspnea | M3 §4 | MED | ticag 부작용 management |
| **39462482 Gragnano 2025 PRECISE-HBR** | M4 §2.5 신규 | **HIGH** | 신규 §2.5 섹션 추가 |
| 38552712 Marschall 2024 ARC-HBR 노령 | M4 §4 | MED | 노령 cell cite |
| **38754988 Galli 2024 network meta** | M3 §3 + M5 §6 | **HIGH** | 한국 5mg prasug 권고 evidence + Galli 2022 → 2024 update |
| 37549688 Birocchi 2024 guided meta | M5 §6 | MED | 종합 meta 행 |
| **42089171 Cavallari 2026 ACC/AHA gap** | M7 §8 | **HIGH** | 가이드라인 비교 표 — ACC/AHA 2025 PGx gap 명시 (KSC 우위 강화) |
| **41744086 van den Broek 2026 POPular-GUIDE** | M5 §7 + M7 §3 | HIGH | observational genotype-guided de-escalation HR 0.71 |
| **41211981 Van't Hof 2026 CELEBRATE zalunfiban** | M6 §5 + §10 | **HIGH** | zalunfiban readout 🟡 upgrade · M7 §6 timeline 갱신 |
| **38267188 Mazighi 2024 ACTIMIS Lancet Neurol** | M6 §9 | HIGH | glenzocimab cite 갱신 (M6 기존 cite 검증) |
| 42044230 Köhrmann 2026 ACTISAVE | M6 §6 | MED | GPVI evolution |
| **39367653 Liu 2025 DT-678 FIH** | M6 §5 신규 class | **HIGH** | clopi-conjugate prodrug — 신규 §5.5 |
| 41791881 Sun 2026 CYP102A1 biosynthesis | M6 §5 + M8 econ | MED | DT-678 약가 함의 |
| 41692042 Chen 2026 micelle | M6 §6 | LOW | drug-delivery NEW-D |
| **39691389 Youn 2024 SKR PGx + *35** | M1 §3 + §6 | **HIGH** | `*35` 행 추가 · 한국 specific |
| 37543868 Park 2024 Korean PCR | M1 §3 | MED | cite 갱신 |
| 40041905 Li 2025 P2Y12 occupancy | M2 §4 | MED | NEW biomarker (NEW-B) |
| 39170956 Ortega-Paz 2024 신기능 × clopi | M2 §7 | MED | modifier 표 행 추가 |
| **41447752 Samprasit 2025 Thai cost-utility** | M8 §9 | **HIGH** | Asia-Pacific 직접 비교 |
| 39537191 van den Broek 2025 EU cost-eff | M8 §9 | MED | EU 비교 |
| 41953196 Wang 2026 precision review | M7 §1-§3 | LOW | frame |
| 42115787 Dello Russo 2026 PGx visibility | M7 §8/§10 | LOW | implementation gap 정성 |
| 41976776 He 2026 ACS RCT review | M3 §8 | MED | KSC 2024 evidence base review |
| **41198373 Loh 2025 JACC Asia 다민족 bleeding** | M3 §4 + M4 §5 | **HIGH** | TICAKOREA validate · East Asian ticag bleed ↑ 재확인 |
| 38555552 Wu 2024 5mg prasug East Asian | M3 §3 | MED | 한국 5mg evidence |
| 41989147 Noh 2026 SWAPT-K | M3 §6 | MED | Korean switch protocol |
| Xu 2026 / Wang 2025 ML clopi resistance | M7 §6 + NEW-A | MED | 4D evolution AI cell 현실화 evidence |
| 40953648 Xie 2025 clopi 대체제 review | M6 §1 | LOW | overview |
| Li/Chen/Zhang 2024 PAR-4 antagonist 4편 | M6 §6 + §10 | MED | PAR-4 임상 진입 timeline 단축 시그널 |
| Lee KJ 2026 / Lin 2026 / Haidong 2026 stroke PGx | M7 §6 cross-적응증 | LOW-MED | 적응증 확장 evidence |
| 41953196 Wang 2026 / 40661922 Dou 2025 (precision review) | M2 / M7 | LOW | frame |

**HIGH priority 합계 = 12편** · 즉시 M1-M8 보강 권고.

---

## §12. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 검색 methodology 재현성 | 🟡 SUPPORTED-BY-CITATION | PubMed query string 명시 + DB filter year 명시 |
| arxiv 0 results — 분야 미스매치 | 🟡 SUPPORTED-BY-CITATION | export.arxiv.org API zero entry — pharmacogenomics는 PubMed/medRxiv 도메인 |
| 신규 PMID 인용 (~45편) | 🟡 SUPPORTED-BY-CITATION | 각 PubMed 항목 직접 hit |
| TALOS-AMI substudies 5편 (Lee/Kim/Bu/Shin/Kim) | 🟡 SUPPORTED-BY-CITATION | JAMA Cardiol · JAMA Netw Open · JACC Interv · Front Cardiovasc Med · Thromb Haemost 모두 peer-review |
| Galli 2024 network meta | 🟡 SUPPORTED-BY-CITATION | EHJ Cardiovasc Pharmacother RCT-level meta |
| PRECISE-HBR (Gragnano 2025) | 🟡 SUPPORTED-BY-CITATION | Circulation derivation/validation |
| Cavallari 2026 ACC/AHA PGx gap 비판 | 🟡 SUPPORTED-BY-CITATION | J Am Heart Assoc editorial 인용 |
| Van't Hof 2026 CELEBRATE main readout | 🟡 SUPPORTED-BY-CITATION | NEJM Evid Phase 3 publication |
| Samprasit 2025 Thai cost-utility | 🟡 SUPPORTED-BY-CITATION | Value Health Reg Issues Asia-Pacific 직접 |
| 한국 직접 cost-effectiveness 부재 | 🟠 INSUFFICIENT/DEFERRED | 2024-2026 한국 HEEM RCT/analysis 미발견 — M8 unique gap |
| `*35` allele 한국 specific (Youn 2024) | 🟡 SUPPORTED-BY-CITATION | Front Pharmacol 2.02% 보고 |
| NEW-A AI/ML axis | 🟡 SUPPORTED-BY-CITATION | Xu 2026 + Wang 2025 (중국 stroke + ACS 외삽) |
| NEW-C DT-678 신규 class | 🟡 SUPPORTED-BY-CITATION | Liu 2025 BJP FIH publication |
| NEW-D micelle delivery | 🟠 INSUFFICIENT (preclinical/조기) | Chen 2026 in vitro · in vivo 한정 |
| Selatogrel SOS-AMI readout | 🟠 INSUFFICIENT (readout 미발생) | PubMed 직접 결과 없음 — 2027 예상 유지 |
| Korean-specific HEEM gap | ⚪ SPECULATION-FENCED | future work — `/gap` 후보 |

---

## §13. 핵심 통찰 (5 bullets)

- **TALOS-AMI substudies가 한국인 결정맵의 evidence base를 2024-2026에 결정적으로 강화** — Lee 2024 (HIR) · Kim 2025 (CKD) · Kim 2025 (DM) · Bu 2025 (BMI) · Shin 2024 (sex) · Kim 2024 (dyspnea) 6편 모두 ticag→clopi de-escalation의 net benefit (출혈 HR 0.42-0.55, 허혈 동등)을 한국 RCT subset에서 입증 — M3 §5 + M7 §3 deep dive cells가 🟠 → 🟡 명확히 upgrade. KSC 2024 clopi-first stance가 더 evidence-leading 됨.

- **Zalunfiban CELEBRATE Phase 3 readout (Van't Hof 2026 NEJM Evid PMID 41211981)이 M6 timeline의 첫 hard endpoint readout** — STEMI 첫 의료접촉 시점 SC 1회 zalunfiban 결과 publication. selatogrel SOS-AMI 미readout 상황에서 **prehospital SC P2Y12-adjacent 영역 첫 데이터** → M6 §5 + §10 🟡 upgrade · M7 §6 5-10y timeline (selatogrel 2028-2030 도입 시점) 재조정 필요. 한국 STEMI EMS 협업 protocol 설계도 zalunfiban 데이터 기반 가능.

- **DT-678 (clopidogrel-conjugate prodrug) + CYP102A1 효소 생산 + micelle 전달이 M6에 NEW class 3종 추가** — Liu 2025 BJP FIH (PMID 39367653) · Sun 2026 ACS Synth Biol (PMID 41791881) · Chen 2026 J Control Release (PMID 41692042) — GSH-trigger bioactivation + 효소 기반 저비용 생산 + delivery-layer 가속 모두 결합 시 **vicagrel + selatogrel 외 3번째 CYP 우회 paradigm**. M6 §5 신규 class 신설 + M8 econ 약가 임팩트 (효소 생산 = 저비용 가능성).

- **Cavallari 2026 J Am Heart Assoc "Missing the Boat" editorial이 ACC/AHA 2025 vs KSC 2024 분기점 명시** — ACC/AHA 2025가 routine CYP2C19 genotyping 권고 안함을 정면 비판 (PMID 42089171) + Dello Russo 2026 (PMID 42115787)가 cardiology 문헌의 PGx visibility ↓ 정량화 — M7 §8 가이드라인 비교 표에서 한국 KSC 2024 evidence-leading stance의 국제적 정당성 강화. POPular-GUIDE PCI (van den Broek 2026 PMID 41744086, n=2,627)가 observational evidence로 한 단계 더 보강.

- **NEW axis 5종 (AI/ML · P2Y12 receptor occupancy · DT-678 class · sex layer · Lp-PLA2) 동시 등장 — 결정맵 cube → 4D tesseract → 5D 진화 가속** — M7 §6 2030 timeline의 "AI 결정 지원" cell이 Xu 2026 (XGBoost AUC 0.88) · Wang 2025 다중 ML로 이미 학습 가능 evidence base 확보. Real-time platelet P2Y12 occupancy (Li 2025) · DT-678 class · sex-modifier (TALOS-AMI sex + vicagrel sex 2024) · Lp-PLA2 (Lin 2026)는 모두 5-7y 안에 한국 cohort 학습/검증 가능. **한국 cohort 기반 ML clopi resistance 모델 + 한국 specific `*35` allele 통합 = M10 또는 차기 milestone 핵심 후보**.
