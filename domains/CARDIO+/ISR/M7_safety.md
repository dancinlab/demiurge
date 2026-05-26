# M7 — off-target / 안전성 통합

> 마일스톤 M7 산출물 · current-state · no history.
> 입력 = M3 (5 family 후보) · M5 (paclitaxel-DCB · sirolimus-DCB · biolimus-DCB) · M6 (BRS) · M1 §3 axis-US (uncovered strut) · M2 §5 (c)(d) wall (late ST · DAPT 부담).
> 출처 = ARC-2 정의 + Katsanos 2018 JAHA + FDA 2019/2023 letter + pivotal RCT → 🟡 SUPPORTED-BY-CITATION.
> 목표 = 후보별 안전성 grade (A/B/C/D) → M8 통합 ranking 직접 입력.

---

## §1. ISR 분야 5대 안전성 도메인 overview

| 도메인 | 정의 | 임상 outcome | 현행 DES 우려 |
|---|---|---|---|
| **(a) late stent thrombosis (LST/VLST)** | implant 후 ≥30일~수년 stent 내 혈전 | ARC-2 **definite / probable** · sudden death · MI | 현행 2G DES **<0.5%/yr** 잔존 (1G대비 ↓ but 0이 아님) |
| **(b) delayed healing** | endothelial coverage 지연 (OCT uncovered strut) | uncovered strut → LST/VLST anatomic 기질 | 1G (Cypher/Taxus) ≫ 2G (Xience/Resolute) > biodegradable polymer (Orsiro/Synergy) |
| **(c) NA (neoatherosclerosis)** | 신생내막 내 lipid plaque · foam cell · thin-cap | late ACS · 재시술 · VLST trigger | **M1 §5 d2 wall** — 현행 mTOR 약물 표적 부재 (3-10년 시점 주범) |
| **(d) bleeding (DAPT 부담)** | DAPT 강제 시간 + HBR (노인·CKD·AF on OAC·prior bleed) | **BARC 2-5 major bleeding** · 사망률 ↑ | 1G 12m+ · 2G 6-12m 강제 · HBR 환자 부담 큼 (M2 §5 (d) wall) |
| **(e) drug systemic off-target** | 코팅/balloon 약물 시스템 노출 → 비-혈관 toxicity | 후기 사망률 신호 (Katsanos 2018) · 종양 angiogenesis · 골/혈소판 toxicity | **paclitaxel-DCB PAD 사망률 signal** · M3 family별 systemic toxicity 우려 (HIF · BET · Wnt) |

→ (a)·(b) = anatomic axis (US/SF surrogate) · (c) = molecular axis (M1 d2 wall) · (d)·(e) = patient-level systemic axis.

---

## §2. late stent thrombosis (LST) 매핑

### 2.1 ARC-2 (Academic Research Consortium 2017) 정의

| 등급 | 기준 |
|---|---|
| **definite** | 조영술 또는 부검으로 stent 내 혈전 + ACS 또는 사망 |
| **probable** | unexplained death (≤30d) 또는 target-vessel MI (시술 위치) |
| **possible** | 시술 30일 후 unexplained death (다른 원인 없음) |

### 2.2 시간 축 — early / late / very late ST

```
PCI implant
  │
  ├── 0–24h   ─── acute ST          (mechanical · undersizing · dissection)
  │
  ├── 1–30d   ─── subacute ST       (DAPT 중단 · malapposition · platelet)
  │
  ├── 30d–1y  ─── late ST           ◀── 1G DES 부각 (delayed healing)
  │
  └── >1y     ─── very late ST (VLST) ◀── 2G에서도 잔존 (neoatherosclerosis driver)
```

### 2.3 1G vs 2G DES LST 빈도

| 디바이스 | 1y LST (%) | 5y VLST cumulative (%) | 비고 |
|---|---|---|---|
| BMS | 0.5-1.0 | 1.5-2.5 | 대부분 acute/subacute |
| **1G Cypher (sirolimus)** | 0.6-1.4 | **2.5-3.5** | delayed healing · uncovered strut 高 |
| **1G Taxus (paclitaxel)** | 0.8-1.5 | **2.5-3.0** | NA 가속 신호 |
| **2G Xience (everolimus)** | 0.2-0.4 | 1.0-1.5 | LST 최저 · 2G workhorse |
| **2G Resolute (zotarolimus)** | 0.2-0.4 | 1.0-1.5 | LST 낮음 |
| **3G Orsiro (sirolimus + bio-polymer)** | 0.1-0.2 | <1.0 | BIOFLOW-V — VLST 거의 0 |
| **BVS Absorb (PLLA)** | **1.5-1.9** | **3-4** | Absorb III 3y · scaffold thrombosis 신호 → 2017 시장 철수 |

### 2.4 한국인 hooks (M8 입력)

- **K-DES** registry — 2G DES VLST 0.3-0.5%/yr (서양 수치와 일치)
- **EXCELLENT / RESET** — Korean RCT, 1y LST endpoint
- **HOST-REDUCE-POLYTECH-ACS** — DAPT de-escalation 후 LST signal 추적

→ **2G DES 시대 LST <0.5%/yr** 도달 — 그러나 절대 환자 수 큼 · VLST는 NA가 driver.

---

## §3. delayed healing & uncovered strut — OCT/IVUS surrogate

### 3.1 uncovered strut % (OCT surrogate)

| 세대 | 대표 stent | uncovered strut % (6-13m OCT) | DAPT 권고 |
|---|---|---|---|
| **1G** | Cypher (sirolimus) | **15-20%** | 12m+ 강제 |
| **1G** | Taxus (paclitaxel) | **18-22%** (가장 높음) | 12m+ 강제 |
| **2G** | Xience (everolimus) | 5-8% | 6-12m |
| **2G** | Resolute (zotarolimus) | 5-8% | 6-12m |
| **3G bio-polymer** | Orsiro / Synergy / Nobori | **2-5%** | **1-3m 가능** (HBR) |
| BMS | — | 1-3% | 1m |

→ **biodegradable polymer (Orsiro·Synergy·Nobori) = uncovered strut 거의 BMS 수준** + mTOR 약물 효과 보존 → DAPT 단축의 분자 근거.

### 3.2 DAPT 단축 가능성 — HBR pivotal RCT

| RCT | n | 디바이스 | DAPT 단축 | LST signal |
|---|---|---|---|---|
| **LEADERS-FREE** (Urban 2015) | 2466 | BioFreedom (polymer-free biolimus A9) | **1m** | LST 1y 2.0% vs BMS 2.2% (비열등) |
| **ONYX-ONE** (Windecker 2020) | 1996 | Resolute Onyx | **1m** | LST 1y 1.4% vs BioFreedom 1.5% |
| **MASTER-DAPT** (Valgimigli 2021) | 4434 | Ultimaster (sirolimus + bio-polymer) | **1m** vs ≥3m | NACE 비열등 · major bleeding ↓ (HR 0.68) |
| **STOPDAPT-2** (Watanabe 2019) | 3009 | Korean/Japanese DES | **1m DAPT + aspirin off** | LST signal 없음 |

→ **HBR 환자 = 1m DAPT 시대 도래** (2021-) · 단 mTOR 약물 자체의 endothelial 독성은 미해결 (M2 §5 (c) wall 잔존).

---

## §4. Katsanos 2018 — paclitaxel 후기 사망률 signal

### 4.1 원논문

- **Katsanos K et al. (2018)** *JAHA* 7:e011245 — paclitaxel-coated devices (DCB + DES) PAD 하지동맥 시술 28 RCT meta-analysis.
- **2y all-cause mortality HR 1.68** (95% CI 1.15-2.47, p=0.008)
- **5y all-cause mortality HR 1.93** (95% CI 1.27-2.93, p=0.003)
- **dose-dependent**: paclitaxel cumulative dose 와 mortality 상관 (Katsanos hypothesis).

### 4.2 FDA 규제 trajectory

| 시점 | 조치 |
|---|---|
| 2018.12 | Katsanos JAHA 출간 → FDA letter to HCP (Class I) |
| 2019.03 | FDA panel — paclitaxel-DCB/DES PAD 사용 신중 권고 · enrollment pause |
| 2019.08 | FDA letter 갱신 — risk-benefit individualized 결정 |
| 2023.07 | **FDA letter revision** — 후속 데이터 (IN.PACT AV · LEVANT 2 long-term · SWEDEPAD interim) 기반 **black-box 해제** · "no association of paclitaxel devices with increased risk of mortality" 명시 |

### 4.3 signal 약화 trajectory — 후속 데이터

| 출처 | 디자인 | 결과 |
|---|---|---|
| **SWEDEPAD interim** (Nordanstig 2020) | Swedish registry n=2289 | 1-4y 사망률 차이 없음 |
| **IN.PACT AV** (Lookstein 2020) | 5y FU | mortality signal 사라짐 |
| **LEVANT 2 5y** (Ouriel 2020) | 476 | 사망률 NS |
| **VOYAGER PAD pooled** (Bonaca 2021) | 6564 | signal 부재 |
| **Veterans Affairs cohort** (Secemsky 2022) | n=152,234 | mortality risk no signal |

→ **현재 (2026) Katsanos signal 사실상 약화** · FDA 2023 revision 으로 paclitaxel-DCB **관상동맥 적응증 정상화** · PAD 적응증도 회복.

### 4.4 관상동맥 vs 하지동맥 코호트 차이

| 축 | 하지동맥 (Katsanos) | 관상동맥 (DCBs) |
|---|---|---|
| paclitaxel cumulative dose | **수 mg** (긴 lesion · 큰 balloon) | **<1 mg** (짧은 lesion · 작은 balloon) |
| systemic 노출 | **상대적으로 큼** | 매우 작음 |
| 대조군 사망률 baseline | 高 (PAD 환자 vasculopathy) | 低 |
| meta 결과 | 2018 signal · 후속 약화 | **신호 부재** (Sciahbasi · Giacoppo meta) |

→ **dose-dependent toxicity 가설**이 유력 — 관상동맥 paclitaxel-DCB 는 dose 가 낮아 signal 약함.

---

## §5. M3 표적 family — safety 통합 표

| family | 대표 분자 | 주요 toxicity | clinical evidence | DES coating 안전 risk | grade |
|---|---|---|---|---|---|
| **ROCK** | fasudil · netarsudil · K-115 | 저혈압 · 두통 · 간효소 ↑ | **JP 30년 사용 (cerebral vasospasm) · netarsudil US 녹내장 8년** · safe profile | **낮음** (local 시 systemic 노출 거의 0) · NO ↑ → re-endo 보조 | **A** |
| **PCSK9 mAb** | evolocumab · alirocumab | 주사부위 반응 · neurocog 약신호 (FOURIER-OLE) | **FOURIER (n=27,564) · ODYSSEY (n=18,924) 5-7y 안전** | systemic only · DES coating 무관 | **A** (systemic adjunct) |
| **GLP-1R** | semaglutide · liraglutide | 위장관 · 췌장염 (rare) · 갑상선 C-cell (rat) | **LEADER · SUSTAIN-6 · STEP 안전** · global use 수천만 환자 | systemic only · DES coating 무관 | **A** (systemic adjunct) |
| **YAP/TAZ** | verteporfin · IAG933 · GNE-7883 | 광독성 (verteporfin) · TEAD oral 신호 미상 | verteporfin AMD PDT 25년 · TEAD-i Ph1 | local 시 광독성 회피 가능 · TEAD-i 안전성 미검증 | **B** |
| **BET** | apabetalone (RVX-208) · JQ1 · molibresib | **혈소판 감소 · 간독성 · GI · 가역적 정자 감소** | **BETonMACE Ph3 (n=2425) — apabetalone 안전 but MACE NS** · JQ1 계열 toxic | **DES coating 우려 ↑** (local 농도 ↓로 회피 시도 가능) | **B-C** |
| **HIF** (HIF-2-i) | belzutifan (PT2977) · PT2385 | **polycythemia · pulmonary HTN · 종양 angiogenesis** (HIF-1α 활성화 시) | belzutifan FDA 2021 (VHL) — drug label에 anemia + hypoxia 경고 | **DES coating 우려 ↑↑** · 종양 신호 long-term 추적 미흡 | **C** |
| **Wnt** | LGK974 (porcupine i) · ETC-159 · ICG-001 | **골 흡수 · 골절 · 장 stem cell · 미각 변화** (Wnt 미뢰) | Ph1 oncology only · 골 toxicity dose-limiting | **DES coating 우려 ↑↑** · isoform 비선택성 미해결 | **C** |
| NLRP3 | MCC950 · dapansutrile | **간독성** (MCC950 Ph2 중단) | dapansutrile Ph2 진행 | local 시 회피 가능성 | **B-C** |

→ **safety A grade**: ROCK · PCSK9 · GLP-1R (clinical maturity + safety 검증)
→ **safety B grade**: YAP/TAZ · BET (apabetalone) — local 코팅으로 risk 완화 가능
→ **safety C grade (red flag)**: HIF · Wnt · STING — DES local 에서도 보류

---

## §6. M6 BRS 안전성 — Mg dissolution + Absorb 학습

### 6.1 Absorb III/IV — PLLA BRS 학습

| 출처 | n | 시점 | 결과 |
|---|---|---|---|
| **ABSORB III** (Kereiakes 2017) | 2008 | 3y | TLF 13.4% vs Xience 10.4% (HR 1.33, p=0.04) · **scaffold thrombosis 1.9% vs DES 0.8%** |
| **ABSORB IV** (Stone 2018) | 2604 | 3y | TLF 10.0% vs Xience 7.3% · ST 1.4% vs 0.7% |
| **AIDA** (Wykrzykowska 2017) | 1845 | 2y | very late ST 3.5% vs Xience 0.9% |

→ **2017년 Abbott Absorb 시장 철수** (3y TLF + late ST signal) · scaffold thickness (157µm) · 분해 중 strut 강도 ↓ · malapposition 가설.

### 6.2 Mg-BRS (Magmaris / DREAMS 3G) 안전성

- **Magmaris (Biotronik)** — Mg + sirolimus, BIOSOLVE-II/III · 6-12m TLR 6-7% · **scaffold thrombosis 0.7%** (3y) — Absorb 대비 낮음
- **hydrogen evolution** — Mg corrosion 시 H₂ gas 생성, micro-bubble + pH 상승 우려 (in-vitro · 임상적 영향 미상)
- **degradation 12m → 강도 손실** — late recoil 가능성
- **DREAMS 3G** (Biotronik 차세대) — 더 얇은 strut · 강도 ↑ · 임상 진행 중

### 6.3 Zn-BRS

- 임상 데이터 **부족** (전임상 단계) · 분해속도 Mg < Zn < Fe · long-term biocompatibility 미검증
- **safety grade: D (deferred)** — clinical evidence 부재

### 6.4 BRS family 안전성 grade

| 디바이스 | 재료 | safety signal | grade |
|---|---|---|---|
| Absorb (Abbott) | PLLA | 3y TLF + late ST → 철수 | **C** (시장 철수) |
| Magmaris (Biotronik) | Mg + sirolimus | LST 0.7% / 3y (Absorb 대비 ↓) | **B** |
| DREAMS 3G | Mg + sirolimus (얇은 strut) | 임상 진행 중 | **B** (잠정) |
| Zn-BRS | Zn | 전임상만 | **D** (deferred) |

---

## §7. 안전성 ranking — M8 입력 표

후보별 (M4 short-list · M5 DCB · M6 BRS) 안전성 grade. **A: 검증됨 / B: 신호 약함 (완화 가능) / C: red flag / D: clinical 부재**.

| 후보 | family / 디바이스 | safety grade | 주요 risk | M8 입력 시 강등 여부 |
|---|---|---|---|---|
| **2G DES baseline (Xience · Resolute)** | everolimus · zotarolimus | **A** | LST <0.5%/yr | 강등 X · 기준선 |
| **3G bio-polymer DES (Orsiro · Synergy · Nobori)** | sirolimus + biodegradable polymer | **A** | uncovered strut 2-5% · 1m DAPT 가능 | 강등 X · 안전성 우수 |
| **paclitaxel-DCB (SeQuent · IN.PACT)** | paclitaxel + iopromide/urea | **A-** | 관상동맥 dose 낮아 mortality signal 약함 · FDA 2023 black-box 해제 | 강등 X (현재) · 단 long-term 추적 |
| **sirolimus-DCB (AGENT · MagicTouch · SELUTION)** | sirolimus + carrier | **A** | dose 낮음 · 신경독성 無 | 강등 X |
| **biolimus-DCB (Biotronik 차세대)** | biolimus A9 + lipophilic | **A** (잠정) | clinical evidence 적음 | 강등 X (잠정) |
| **ROCK-DES/DCB (fasudil · K-115)** | M3 family | **A** | local 시 systemic 노출 거의 0 · 30년 JP 경험 | 강등 X · **top pick** |
| **PCSK9 systemic adjunct** | evolocumab · alirocumab | **A** | 주사부위 반응 only | 강등 X |
| **GLP-1R systemic adjunct** | semaglutide | **A** | GI · 췌장염 rare | 강등 X |
| **Magmaris Mg-BRS + sirolimus** | M6 BRS | **B** | LST 0.7%/3y · H₂ evolution 미지 | 잠정 · 추적 필요 |
| **YAP/TAZ-DES (verteporfin · IAG933)** | M3 family | **B** | TEAD-i 안전성 미검증 | 1-tier 강등 |
| **BET-DES (apabetalone · JQ1)** | M3 family | **B-C** | 혈소판 · 간 toxicity · BETonMACE MACE NS | **1-2 tier 강등** |
| **DREAMS 3G Mg-BRS** | M6 | **B** (잠정) | 임상 진행 중 | 잠정 |
| **HIF-DES (belzutifan · PT2385)** | M3 family | **C** | polycythemia · tumor · pHTN | **강등 (deferred)** |
| **Wnt-DES (LGK974)** | M3 family | **C** | 골 흡수 · 장 stem cell · 미각 | **강등 (deferred)** |
| **NLRP3-DES (MCC950 · dapansutrile)** | M3 보조 | **B-C** | 간 toxicity · Ph2 단계 | 1-tier 강등 |
| **Absorb PLLA-BRS** | M6 (역사) | **C** | 시장 철수 · 3y late ST signal | 강등 (이미 철수) |
| **Zn-BRS** | M6 | **D** | clinical evidence 부재 | deferred |

→ **M8 ranking 강등 후보**:
- **HIF-DES · Wnt-DES** — safety C red flag · 강등 (deferred tier)
- **BET-DES** — 혈소판/간 신호 + BETonMACE NS · 1-2 tier 강등
- **YAP/TAZ-DES · NLRP3-DES** — clinical maturity 부족 + 안전성 미검증 · 1-tier 강등
- **Absorb PLLA** — 이미 시장 철수 (M6 학습으로만 활용)

→ **M8 top picks (안전성 무강등)**: **ROCK-DES/DCB · 3G bio-polymer DES · sirolimus-DCB · PCSK9/GLP-1R systemic adjunct · biolimus-DCB**.

---

## §8. 미해결 + 한국인 hook

### 8.1 미해결 안전성 질문

- **VLST 잔여 0.3-0.5%/yr** — 절대 0 도달 불가능 · NA driver 미해결 → M3 ROCK/PCSK9/GLP-1R 보조로 risk 감소 가능 가설
- **paclitaxel-DCB long-term (>5y)** — FDA 2023 black-box 해제 후 추적 데이터 축적 중
- **Mg-BRS H₂ evolution** — 임상적 영향 미상 · DREAMS 3G 임상 결과 대기
- **HIF/BET/Wnt local DES 코팅 dose threshold** — systemic toxicity 회피 가능 dose 미정의 → M4 dose-screening 입력

### 8.2 한국인 registry hooks (M8 직접 입력)

| registry | 안전성 endpoint | M8 활용 |
|---|---|---|
| **K-DES** | 2G DES LST/VLST 1-5y · 한국인 BARC 출혈 | grade A 후보 검증 |
| **GRAND-DES** | DES NA 패턴 + late ACS · 한국인 plaque morphology | NA risk 후보 (M3 family) 차등 ranking |
| **EXCELLENT / RESET** | LLL + LST + bleeding endpoint | 2G DES baseline |
| **HOST-REDUCE-POLYTECH-ACS** | DAPT de-escalation + bleeding | 1m DAPT 가능성 hooks |
| **STOPDAPT-2 Korean** | 1m DAPT + aspirin off · LST signal | 3G bio-polymer DES 안전성 |
| **TIS / K-DCB** | DCB ISR · 출혈 profile | paclitaxel/sirolimus-DCB grade |

---

## §9. 참고문헌

- **Katsanos K et al. (2018)** *JAHA* 7:e011245 — paclitaxel PAD 사망률 meta
- **FDA** (2019.03 · 2023.07) — paclitaxel-coated devices letter (Class I → revision)
- Cutlip DE et al. (2007 · 2017 update) *Circulation* — ARC definitions / ARC-2
- Stone GW et al. (2018) *Lancet* 391:31 — ABSORB IV 3y
- Kereiakes DJ et al. (2017) *NEJM* 376:2319 — ABSORB III 3y
- Wykrzykowska JJ et al. (2017) *NEJM* 376:2319 — AIDA Absorb very late ST
- Urban P et al. (2015) *NEJM* 373:2038 — LEADERS-FREE (BioFreedom 1m DAPT)
- Windecker S et al. (2020) *NEJM* 382:1208 — ONYX-ONE (Resolute Onyx 1m DAPT)
- Valgimigli M et al. (2021) *NEJM* 385:1643 — MASTER-DAPT
- Watanabe H et al. (2019) *JAMA* 321:2414 — STOPDAPT-2
- Sabatine MS et al. (2017) *NEJM* 376:1713 — FOURIER (PCSK9 안전성)
- Ray KK et al. (2020) *JAMA* 323:1565 — BETonMACE (apabetalone Ph3)
- Otsuka F et al. (2014) *Eur Heart J* 35:1538 — NA + DES delayed healing
- Nordanstig J et al. (2020) *Circulation* 142:e36 — SWEDEPAD interim (paclitaxel signal 약화)
- Secemsky EA et al. (2022) *Circulation* 145:1781 — VA cohort paclitaxel
- Verheye S et al. (2020) — BIOSOLVE-IV (Magmaris 3y)
- Park SJ et al. (2012) *JACC* 59:2051 — EXCELLENT (Korean)
- Kim HS et al. (2020) *Lancet* 396:1079 — HOST-REDUCE-POLYTECH-ACS

---

## §10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 5대 안전성 도메인 분류 | 🟡 SUPPORTED-BY-CITATION | ARC-2 + Otsuka 2014 |
| LST 빈도 (1G vs 2G vs 3G) | 🟡 SUPPORTED-BY-CITATION | 위 RCT + meta |
| uncovered strut OCT 데이터 | 🟡 SUPPORTED-BY-CITATION | Joner 2006 · OCT atlas |
| 1m DAPT 안전성 | 🟡 SUPPORTED-BY-CITATION | LEADERS-FREE · ONYX-ONE · MASTER-DAPT |
| Katsanos 2018 signal | 🟡 SUPPORTED-BY-CITATION | JAHA original |
| Katsanos 후속 약화 | 🟡 SUPPORTED-BY-CITATION | SWEDEPAD · VA · LEVANT 5y · FDA 2023 |
| M3 family safety grade | 🟡 SUPPORTED-BY-CITATION | 각 family clinical use record |
| BRS safety (Absorb · Magmaris) | 🟡 SUPPORTED-BY-CITATION | ABSORB III/IV · BIOSOLVE |
| 후보별 M8 강등 결정 | 🟠 INSUFFICIENT/DEFERRED | M4/M8 통합 ranking 단계 |

🔑 핵심 통찰:
- **5대 안전성 도메인 (LST · delayed healing · NA · 출혈 · systemic off-target)** — 후보 평가의 통합 격자
- **Katsanos 2018 signal 약화 (2023 FDA black-box 해제)** — paclitaxel-DCB 관상동맥 적응증 정상화 · dose-dependent 가설
- **M3 안전성 top picks (A grade)**: **ROCK · PCSK9 · GLP-1R** = M3 결론과 일치 (clinical maturity + safety + NA 차단 3축)
- **M3 강등 (red flag C)**: **HIF · Wnt** — DES coating 도 보류 · **BET** = 1-2 tier 강등 (BETonMACE NS + 혈소판/간 toxicity)
- **M6 BRS** — Magmaris/DREAMS 3G = B grade (잠정) · Absorb 학습 (시장 철수) · Zn-BRS deferred
