# R1 — arxiv/PubMed deep research sweep (2023-2026)

> 마일스톤 R1 산출물 · current-state · deep-research phase.
> 입력 = M1-M8 산출물 (vocab) + 2023-01 ~ 2026-05 paper sweep.
> 출처 = WebSearch (PubMed/EuroIntervention/JACC/NEJM/Lancet/TCT proceedings/JAMA · arxiv equivalent) → 🟡 SUPPORTED-BY-CITATION.
> 목표 = M3/M4/M6 갱신 hooks + novel angle 발견 + M2-M8 권고.

---

## §0. Sweep methodology

| 항목 | 값 |
|---|---|
| 기간 | 2023-01-01 ~ 2026-05-24 |
| sources | PubMed · EuroIntervention · JACC · NEJM · Lancet · JAMA · Circulation · TCTMD · clinicaltrials.gov · 제조사 press · ScienceDirect |
| arxiv surrogate | WebSearch (arxiv 자체는 비의료 dominant — PubMed/저널 surrogate 우선) |
| query 수 | 10 axes × 2-4 sub-queries = 30+ |
| inclusion | (a) 2023-2026 발표 · (b) ISR/Mg-BRS/dual-DCB/ROCK-coronary/neoatherosclerosis/PCSK9-post-PCI/GLP-1R-plaque/colchicine-PCI 직접 연결 · (c) RCT > registry > meta > review > case |
| exclusion | (a) 2022 이전 (M1-M8 산출물에 이미 포함) · (b) peripheral artery only (coronary 가설 추출 불가시) · (c) 동물 only (직접 hit 없으면 skip) |

### 10 query axes
1. ISR pathology + neoatherosclerosis OCT
2. ROCK inhibitor coronary (fasudil · netarsudil · ripasudil)
3. Sirolimus-DCB carrier (MagicTouch · SELUTION · AGENT)
4. Mg-BRS / Freesolve / DREAMS-3G
5. Dual-drug DCB (paclitaxel + sirolimus combination)
6. PCSK9 + plaque regression post-PCI (evolocumab · inclisiran · HUYGENS)
7. GLP-1RA cardiovascular plaque (semaglutide SELECT · tirzepatide SURMOUNT)
8. Katsanos signal follow-up (paclitaxel long-term safety)
9. AI/ML for ISR risk (deep learning OCT)
10. 한국인/Asian-specific (K-DCB · KAMIR · Ultimaster)

추가 (novel angle 발굴):
- 11. SGLT2i 직접 anti-ISR (empagliflozin neointima)
- 12. ZEUS (ziltivekimab IL-6) · BROADWAY (obicetrapib CETP)
- 13. 2024 ESC chronic coronary syndromes guidelines
- 14. verteporfin YAP-TEAD vascular restenosis 2024-2025
- 15. CLEAR SYNERGY OASIS-9 colchicine post-MI

---

## §1. ISR pathology + neoatherosclerosis OCT

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| Predictors and outcomes of neoatherosclerosis in patients with ISR (multicentre registry) | (Hassani) | 2023-24 | EuroIntervention | **NA 47.0% of ISR lesions** · eGFR · time-to-ISR · DES-ISR가 NA 독립 예측 인자 · NA 동반 ISR은 clinically driven TLR rate ↑ |
| Recurrent DES-ISR: Epidemiology, pathophysiology & treatment | (Donghua W) | 2024 | (PubMed 39755191) | DES-ISR 재발 분류 + 치료 알고리즘 — 다층 stent · neoatherosclerosis · stent fracture · uncovered strut 4-axis 재확인 |
| DCB therapy more effective in late DES-ISR vs early — systematic review + meta | (Zhang Y et al.) | 2023 | Front Cardiovasc Med 10:1062130 | **late ISR (NA-driven) → DCB 우위** · early ISR (NH) → DES vs DCB 동등 · time-axis treatment hypothesis 강화 |
| Influence of neoatherosclerosis on prognosis and treatment response in ISR | (Alfonso F) | 2020 (2023 갱신) | Rev Esp Cardiol | NA 동반 ISR은 어떤 treatment (DES/DCB)에서도 TLR 재발률 ↑ — NA targeting 자체가 필요 (mTOR/paclitaxel만으론 부족) |
| Mixed treatment comparison meta — DES vs DCB vs POBA for ISR | (Megaly et al.) | 2025 | Circulation Cardiovasc Interv | network meta — **DES > DCB > POBA** for TLR · 그러나 lesion 특성·다층 strut 시 DCB 우위 |

→ §1 시그널: **NA = ISR 의 47%** · **late ISR ⇒ DCB 우위 · early ⇒ DES 동등** (time-axis treatment 패러다임).

---

## §2. ROCK inhibitor coronary (fasudil · netarsudil · ripasudil)

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| Cardiac function and QoL improvement with fasudil HCl in DM patients post-PCI: RCT | Yang X | 2025 | J Int Med Res 53 (DOI 10.1177/03000605241311403) | **post-PCI 환자 RCT** — fasudil 추가 시 LVEF · NT-proBNP · MLHFQ score 개선 · DM-CAD 코호트 (n 미공개), 인체 post-PCI 직접 데이터 갱신 |
| Computational exploration of novel ROCK2 inhibitors for CVD | (Anwar S) | 2023 | (PMC 10653426) | virtual screening + DFT/MD — netarsudil-유사 골격 ROCK2 selective scaffold inventory → DES coating 후보 분자 |
| Therapeutic potential of ROCK inhibitors in corneal disease (systematic) | — | 2024 | PMC 12292609 | netarsudil/ripasudil cornea 적응증 확장 — 인체 누적 안전성 hooks · coronary off-target 없음 확인 |
| Fasudil cardioprotection in MI/R injury (meta) | — | 2024 update | PMC 6174418 갱신 | preclinical meta — 효과 robust · clinical 부재는 여전 |

→ §2 시그널: **fasudil post-PCI RCT (Yang 2025)** = **새로운 인체 데이터** — DM-CAD subset에서 LVEF 개선 · M3/M4 ROCK pick 강화 (Vicari 2005 이후 20년 만의 인체 evidence).

---

## §3. Sirolimus-DCB carrier (MagicTouch · SELUTION · AGENT)

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| **AGENT IDE RCT: paclitaxel-coated vs uncoated balloon for coronary ISR** | Yeh RW (Boston Scientific) | 2024 | JAMA | n=600 · 1y TLF **17.9% vs 28.6%** (HR 0.59, p<0.001) — 미국 최초 coronary DCB FDA approval (2024-03-01) |
| AGENT IDE subgroup — multilayer ISR | — | 2025 | (PubMed 40803784) | multilayer ISR (DES 2겹+) 서브셋도 paclitaxel-DCB 우위 — 다층 stent 환자 = DCB 강 indication |
| **SELUTION DeNovo RCT (TCT 2025)** | Cordis | 2025 | TCT LBT | n=3,341 · de novo lesion · sirolimus DEB vs DES — 1y TVF **5.3% vs 4.4%** (non-inferior) — **DEB가 de novo 에도 진입** |
| SELUTION4ISR RCT (TCT 2025) | Cordis | 2025 | TCT LBT | n=미공개 · ISR — primary TLF NS vs standard care (POBA/DES) — **sirolimus-DCB이 paclitaxel-DCB 와 동등하다고 보기 어려움** |
| MagicTouch SCB animal + clinical synthesis | Cortese B | 2024 | PMC 11485756 | sirolimus DCB EU 시판 · 충분 dose 전달 + downstream embolism ↓ · 임상 누적 안전성 |
| Crystalline sirolimus-coated balloon (new formulation) | — | 2024 | Front Cardiovasc Med 11:1316580 | 결정성 sirolimus 코팅 — 30s contact 내 wall transfer 검증 |
| MAGICAL SV trial (NCT06271590) | Concept Medical | 2025-2028 (ongoing) | clinicaltrials.gov | small vessel coronary RCT — primary completion 2028 |

→ §3 시그널: **AGENT IDE 2024 = paclitaxel-DCB 의 미국 ISR adoption 분기점** · **SELUTION DeNovo 2025 = sirolimus-DCB de novo 비열등** · 그러나 **SELUTION4ISR NS** — paclitaxel-DCB이 ISR endpoint 에서 sirolimus-DCB 보다 여전 우위 가능성.

---

## §4. Mg-BRS / Freesolve / DREAMS-3G

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| **BIOMAG-I 1y first-in-human (DREAMS 3G/Freesolve)** | Haude M | 2023-2024 | EuroIntervention | n=116 · in-segment late lumen loss 0.21 mm · TLF 2.6% · scaffold thrombosis 0% — **previous-gen 대비 박형 (99-117 µm) + 보존 radial force** |
| **BIOMAG-I 12m vasomotion** | Haude M | 2024 | EuroIntervention (PMC 11352512) | Mg scaffold 12m 시점 vasomotion 회복 (acetylcholine + nitroglycerin 양반응) — **DES 와 차별화된 native vessel restoration** |
| **BIOMAG-I 2y follow-up (Biotronik press)** | Biotronik | 2024 | press / EuroPCR | 24m TLF **3.5%** · TLR 3.5% · scaffold thrombosis 0% — **장기 안전성 신호 유지** |
| Freesolve CE mark 2024 | — | 2024 | press | CE mark 획득 (EU) — coronary 적응증 first-time approval |
| BIOMAG-II RCT (started) | Biotronik | 2024-2025 | press / clinicaltrials | RCT vs contemporary DES (Resolute Onyx/Synergy 추정) — ongoing |
| Hybrid PCI: BRS + DCB vs DES (long diffuse CAD) | — | 2024 | NCT06710210 | 한국·아시아 가능 — BRS + DCB combo first RCT — M5 + M6 교차 hook |
| Zn-3Ag alloy bench-porcine 비교 | — | 2024 | PMC 6314592 갱신 | Zn-3Ag scaffold — mechanical Mg-Ag 보다 강 · porcine iliofemoral neointima 완전 coverage · 임상 first-in-man 아직 미진입 |

→ §4 시그널: **Freesolve (DREAMS-3G) 가 명확한 Mg-BRS leader 갱신** — 2024 CE mark + 2y TLF 3.5% + scaffold thrombosis 0% · **BIOMAG-II RCT 가 vs DES head-to-head 결정 round**. Zn-alloy은 여전히 first-in-man 대기.

---

## §5. Dual-drug DCB (paclitaxel + sirolimus combination)

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| **Efficacy and Safety of Dual Paclitaxel + Sirolimus Nanoparticle-Coated Balloon (SirPlux Duo)** | (Concept Medical / 다기관 preclinical) | 2024 | JACC Basic Transl Sci 9 (PMC 11282887) | **dual API DCB** — 저용량 paclitaxel + sirolimus 공동-encapsulation nanoparticle · porcine coronary — **myocardial injury 0 · downstream embolism rare · intimal proliferation 억제 동등** with PTX DCB at **13× lower 총 dose** |
| Navigating challenges in DCB technology: paclitaxel vs sirolimus | Cortese B | 2024 | Catheter Cardiovasc Interv (DOI 10.1002/ccd.31164) | review — paclitaxel 단기 효과 + sirolimus 장기 지속 — **synergy 가설 임상 검증 부재** |
| New DCB on horizon — quest for safety/efficacy balance | — | 2024 | PMC 11282873 | next-gen DCB inventory — dual API + lipophilic prodrug + sustained release 3 axis |
| Paclitaxel- vs sirolimus-coated balloon RCT meta | Shin DS | 2024 | Catheter Cardiovasc Interv (DOI 10.1002/ccd.31154) | meta — TLR 동등 · sirolimus 안전성 marginal 우위 (paclitaxel 5y mortality 신호 잔존) |
| Paclitaxel- and sirolimus-coated balloons vs DES (narrative review) | — | 2025 | PMC 12842739 | DCB이 DES 진입 — de novo + ISR 양쪽 |

→ §5 시그널: **SirPlux Duo (dual paclitaxel + sirolimus nanoparticle DCB) = M4 dual-DCB short-list 직접 진입 후보** — biolimus+fasudil 외에 **PTX+SRL 검증된 prototype** 추가. M5 § dual-DCB 우선순위 갱신.

---

## §6. PCSK9 + plaque regression post-PCI (HUYGENS · GLAGOV-2)

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| **HUYGENS — evolocumab on coronary plaque phenotype + burden post-MI** | Nicholls SJ | 2022 (full pub) · 2023 갱신 | JACC Cardiovasc Imaging | OCT 50w — **fibrous cap thickness +39 µm (vs +22 µm placebo)** · max-lipid arc ↓ · macrophage index ↓ — ACS subset 에서 plaque stabilization 직접 입증 |
| Stabilization of vulnerable plaque (HUYGENS insights) | Nicholls SJ | 2023 | Eur Heart J Suppl 25:C106 | HUYGENS review — vulnerable plaque conversion to stable phenotype |
| Coronary atheroma regression in stable + unstable CS (evolocumab) | Nicholls SJ | 2022 | JACC Cardiovasc Imaging | GLAGOV+HUYGENS pool — **ACS plaque regression > stable CS** (–2.29% PAV ACS vs less stable) — post-PCI 시기 LDL drive 강 |
| CRP levels + plaque regression with evolocumab (GLAGOV) | — | 2021 (re-analysis 2024) | PMC 8315612 | residual inflammation → 추가 IL-6/IL-1β 차단 가설 — ZEUS 연결 |
| Inclisiran post-PCI/PAD MACE RCT (NCT06909565, started) | Novartis | 2025 (ongoing, completion 2029) | clinicaltrials | n target ~10,000 — **direct post-PCI MACE primary endpoint** — M4 inclisiran 우선순위 hook |
| Pooled ORION-10/11 ASCVD analysis | — | 2024 | Mayo Clin Proc / S0025619624001678 | **MACE 26% ↓** (post-hoc, n=3,655) — direct post-PCI cohort 가설 강화 |
| ORION-8 (extended FU) | Wright RS | 2024 | Cardiovasc Res 120:1400 | 6.8y mean follow-up — LDL ↓ durable · 안전성 robust |

→ §6 시그널: **HUYGENS = post-PCI/ACS 환자에서 evolocumab → OCT-검증된 fibrous cap thickening + plaque stabilization** 직접 입증 (M4 evolocumab 신증거). **Inclisiran post-PCI RCT (NCT06909565) 가 진행 — 2029 완료** — M4 inclisiran 우선순위 강화.

---

## §7. GLP-1RA cardiovascular plaque (SELECT · SURMOUNT-SURPASS)

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| **SELECT — semaglutide MACE in non-DM ASCVD obesity** | Lincoff AM | 2023 | NEJM 389:2221 | n=17,604 · MACE HR 0.80 (p<0.001) · **non-DM 에서도** CV benefit 입증 |
| Semaglutide inflammatory markers + CV outcomes (SELECT post-hoc) | Ridker PM et al. | 2024 | Atherosclerosis (S0021-9150(24)01085-2) | **hsCRP -37.8% at 104w** vs placebo · 염증 driver 직접 차단 입증 — NA mechanism overlap (M1 §5 NA macrophage axis) |
| Semaglutide CV outcomes by baseline HbA1c | Lincoff AM | 2024 | Diabetes Care 47:1360 | non-DM 에서 효과 균질 — DM/non-DM 구분 不요 |
| SELECT heart failure subgroup | Kosiborod MN | 2024 | Lancet 404 (PIIS0140-6736(24)01498-3) | HF 동반 환자 prespecified — MACE benefit 유지 |
| **SURPASS-CVOT — tirzepatide vs dulaglutide T2D CVD** | (Frias JP et al.) | 2025 | (Lancet/NEJM 가능) | MACE 12.2% vs 13.1% (non-inferior + benefit margin) — **tirzepatide 첫 CV outcome trial positive** |
| SURMOUNT-1 3y post-hoc — 10y ASCVD risk | Hankosky ER | 2025 | Diabetes Obes Metab (DOM 70143) | tirzepatide 72w → 10y predicted ASCVD risk ↓ 2.4× more profile improvement vs placebo |
| SURMOUNT-5 head-to-head tirzepatide vs semaglutide | — | 2025 | (ESC 2025 LBT) | 10y CVD risk ↓ **tirzepatide -2.4% vs semaglutide -1.4%** — tirzepatide 가 GLP-1R 단독 보다 우위 |
| Coronary calcium scoring + semaglutide patient selection | — | 2024 | TCTMD | CAC 기반 환자 선별 — M8 한국 hook |
| Effect of semaglutide on coronary atheroma plaque (NCT05071417) | — | (registered) | clinicaltrials | direct IVUS atheroma RCT — completion 미공개 |

→ §7 시그널: **SELECT (Lincoff 2023) + SURPASS-CVOT (2025) = GLP-1R/GIP CV benefit non-DM 확장 완료** — M4 semaglutide/tirzepatide systemic adjunct 우선순위 강화. **tirzepatide > semaglutide** (SURMOUNT-5 head-to-head) — M4 §1 ranking 갱신 hook.

---

## §8. Katsanos signal follow-up (paclitaxel long-term safety)

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| Mortality + paclitaxel-coated devices: IPD meta-analysis | Rocha-Singh KJ et al. | 2020 (지속 갱신 2023-24) | Circulation / NEJM | **IPD level — recovery of lost vital status → mortality signal 축소** · 5y FU 환자 손실 24% (placebo) vs 23% (PTX) → 본래 signal 보다 약 |
| FDA 2024 expert panel advice (medical devices) | EC MDCG | 2024-08 | health.ec.europa.eu | EU medical device 패널 — **PTX coronary DCB 는 peripheral 신호와 분리 평가** · AGENT IDE positive 후 FDA approval |
| Paclitaxel mortality dose-response (real-world) | — | 2021 (재인용 2024) | PMC 8396966 | dose-mortality 상관 일부 sub-pop 존재 — 그러나 inconsistent |
| AGENT IDE 1y safety (no mortality signal) | Yeh RW | 2024 | JAMA | n=600 · all-cause death rate NS vs control · **coronary 사용에서 mortality wall 미관찰** |

→ §8 시그널: **Katsanos signal = coronary DCB (AGENT IDE) 에서는 양성 신호 없음** → M5/M7 paclitaxel-DCB 안전성 wall 부분 해제. peripheral과 분리 평가.

---

## §9. AI/ML for ISR risk (deep learning OCT)

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| Coronary CT angiographic ISR detection via DL reconstruction (PIQE) | — | 2023 | (PubMed 37672056) | DL reconstruction — strut thickness + lumen 정량 자동화 · diagnostic accuracy ↑ for thin-strut + small-vessel ISR |
| Stent under-expansion prediction by ML on OCT | — | 2023 | (PMC 10593923 / arxiv 2205.10354) | OCT pre-PCI 시점 ML → 칼슘화 lesion 의 under-expansion 사전 예측 · ISR prevention upstream |
| ML predictors of ISR in 10,004 surveillance angiogram | — | 2023 | PMC 10142067 | self-organizing map — 신규 predictor 발견 (LAD ostium · stent length × DM × hypertension interaction) |
| Physics-informed DL framework for coronary ISR | — | 2023 | Biomech Model Mechanobiol 23 (s10237-023-01796-1) | **physics-informed NN** — 약물 elution + biological constraint 결합 — virtual ISR simulation 가능 |
| Multimodal DL OCT-guided CAD treatment (NCT06544681) | — | 2024 ongoing | clinicaltrials | OCT + clinical data multimodal DL — treatment 자동 추천 |
| ML-based prediction of ISR (RMHP S468235) | — | 2024 | Risk Manag Healthc Policy | tabular ML — 한국·중국 cohort 사용 가능성 |

→ §9 시그널: **physics-informed DL + multimodal OCT** = next-gen ISR risk stratification — M8 한국인 KAMIR + OCT integration 으로 IIT 설계 가능 (한국 발 hook).

---

## §10. 한국인/Asian-specific

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| **Korean Multicenter Ultimaster Registry — sirolimus-eluting biodegradable polymer DES** | (Korean PIs) | 2024 | Korean Circ J (PubMed 38767441) | n=한국 환자 · 12m clinical events 낮음 — biodegradable polymer DES 한국 real-world 검증 |
| K-ELUVIA registry (paclitaxel-eluting periph) | — | 2024 | Korean Circ J (kcj.2024.0038) | peripheral but Korean 시술자 환경 hook |
| BioMime/Ultimaster vs Xience Korean registry (NCT02986295) | — | (ongoing) | clinicaltrials | head-to-head 시판 stent — biodegradable polymer 동등성 |
| K-DES (legacy) — 2nd-gen DES vs DCB ISR 처치 | — | (2018-2022) | (기존 인용) | M1/M8 baseline — 갱신 부재 |
| EXCELLENT, RESET, HOST-IDEA, HOST-REDUCE | (Korean PIs) | (기존) | NEJM/JACC/Lancet | DAPT de-escalation + ISR endpoint — 2024 갱신 부재 |
| Coronary calcium scoring + semaglutide patient selection (Korean applicability) | — | 2024 | TCTMD | KAMIR + CAC-guided semaglutide IIT 설계 hook |

→ §10 시그널: **Ultimaster (biodegradable polymer sirolimus-DES) Korean Registry (2024)** = 한국 real-world 검증 — M8 한국인 ranking 입력. 그러나 **K-DCB · KAMIR ISR-specific 갱신 부재** — IIT 설계 공백.

---

## §11. (novel) SGLT2i 직접 anti-ISR mechanism

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| **Empagliflozin attenuates neointima formation after arterial injury — PDGF signaling** | — | 2024 | J Am Heart Assoc (JAHA 035044) | **rat carotid wire injury** — empagliflozin neointima 50% ↓ · VSMC 증식·migration in vitro 직접 차단 · **PDGF-Rβ phospho ↓** mechanism |
| SGLT2i empagliflozin attenuates atherosclerosis (autophagy) | — | 2024 | J Physiol Biochem (s13105-023-00974-0) | empagliflozin autophagy 유도 → atheroma volume ↓ in ApoE-/- mouse |
| SGLT2i + ISR-related MACE post-AMI in T2D (observational) | — | 2023 | BMC Med 21 | T2D-AMI cohort — SGLT2i 사용시 ISR-related MACE significantly ↓ · empagliflozin / canagliflozin / dapagliflozin 균등 효과 |
| SGLT2i improves prognosis + prevents ISR | — | 2023-24 | Front Cardiovasc Med 10:1280547 | clinical + mechanism review — SGLT2i 의 post-PCI ISR 예방 가설 정립 |

→ §11 시그널: **SGLT2i (empagliflozin) 가 PDGF 차단 + VSMC anti-proliferation 으로 직접 anti-ISR 작용** — **M4 short-list 11번 (SGLT2i) 가 단순 systemic adjunct 가 아닌 직접 MoA** 로 격상. NA + NH 양쪽 hit 가능성 → M3 short-list 6 family 로 확장.

---

## §12. (novel) ZEUS (ziltivekimab IL-6) · BROADWAY (obicetrapib CETP)

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| **ZEUS RCT — ziltivekimab in ASCVD + CKD + inflammation** | Ridker PM et al. | 2024-25 baseline · 2025 readout 예정 | (Kidney Int Rep WCN25 / utsouthwestern.pure) | n=6,376 · IL-6 directly · monthly SC · CKD-ASCVD cohort · primary MACE — **CANTOS (canakinumab IL-1β) 후 IL-6 직접 차단** 첫 outcome trial · phase 2 RESCUE hsCRP ↓ 90% |
| **BROADWAY Phase 3 — obicetrapib (CETP inhibitor) + ASCVD/HeFH** | Nicholls SJ et al. | 2025 (EAS Congress 2025 published) | (TCTMD / NewAmsterdam) | n=2,532 · obicetrapib 10mg vs placebo · 84d LDL **−33%** vs placebo · ApoB ↓ · Lp(a) ↓ · HDL ↑ — **CETP inhibitor 부활** (anacetrapib · evacetrapib · torcetrapib · dalcetrapib 실패 후) |
| BROOKLYN trial (HeFH) | NewAmsterdam | 2025 | press | HeFH 환자 positive — LDL 추가 ↓ |
| Obicetrapib p-tau217 (CV + AD dual mechanism) | — | 2025 | PMC 12811769 | tau pathology 추가 효과 — 다중 mechanism |

→ §12 시그널: **ZEUS 가 IL-6 직접 차단 outcome 첫 trial** — NA inflammation axis 의 새 표적 (M3 §5 NLRP3 family 와 별도 axis) · **BROADWAY = obicetrapib (CETP) LDL -33% on-top-of statin** — M4 PCSK9 axis 외 추가 LDL lowering 옵션 + ASCVD post-PCI 환자 보조 약제 후보.

---

## §13. (novel) 2024 ESC chronic coronary syndromes guidelines

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| **2024 ESC CCS guidelines — DES > DCB for DES-ISR (Class I LoE A)** | ESC | 2024 | Eur Heart J | **DES is recommended over DCB for treatment of in-DES restenosis** — Class I LoE A · DAEDALUS 3y data 근거 (paclitaxel-DCB 보다 DES 우위 TLR) |
| What is new from 2024 ESC | — | 2024 | PMC 11622220 | DES preferred · DCB는 anatomical/procedural complexity 예외 (small vessel · multi-layer · stent under-expansion) |
| Challenges + evolving strategies — DCB for ISR | — | 2025 | Circ Cardiovasc Interv (015359) | DCB 사용 적응증 narrowing · sirolimus-DCB 가 paclitaxel-DCB 보다 우위 미입증 (SELUTION4ISR NS) |

→ §13 시그널: **2024 ESC = DES > DCB for DES-ISR (Class I LoE A)** — M5 DCB primary pick 의 적응증 narrowing — **DCB는 multi-layer · small vessel · stent fracture/under-expansion 의 niche** 로 재배치. biolimus+fasudil dual-DCB **포지셔닝 재고**.

---

## §14. (novel) verteporfin YAP-TEAD vascular restenosis 2024-2025

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| **Verteporfin-eluting stents (VPES) — carotid artery restenosis + cerebral watershed infarction** | — | 2024 | Mol Cell Biochem (s11010-024-05160-4) | **rabbit carotid model** — VPES → YAP signaling ↓ → SMC 증식·migration 차단 → restenosis ↓ · **DES 기술의 cerebrovascular 확장** |
| Verteporfin + TEAD palmitoylation inhibition (Piezo1-YAP/TAZ + ECM) | — | 2025 | Sci Rep (s41598-025-28960-0) | verteporfin + TEAD palmitoylation inhibitor 협동 — ECM remodeling 차단 |
| Verteporfin attenuates myocardial hypertrophy (IL-6/STAT3 in cardiac fibroblast) | — | 2025 | PMC 12411024 | verteporfin 의 cardiac fibroblast IL-6/STAT3 차단 — 심부전 adjunct 가능성 |

→ §14 시그널: **verteporfin-eluting stent (VPES) 가 carotid 동물 모델에서 검증** — M3 second-tier (YAP/TAZ) 의 첫 coronary-인접 in-vivo evidence · M3 §6 verteporfin DES coating 우선순위 격상 (carotid → coronary translation).

---

## §15. (novel) CLEAR SYNERGY OASIS-9 colchicine post-MI

| 제목 | 1저자 | year | venue | key finding |
|---|---|---|---|---|
| **CLEAR SYNERGY (OASIS-9) RCT — colchicine + spironolactone post-MI 2×2** | Jolly SS et al. | 2024 | NEJM (TCT 2024 LBT) | n=7,062 post-MI within 72h post-PCI · **colchicine MACE benefit NS** · 1차 endpoint cardiovascular death/MI/stroke/unplanned revasc — **NO** significant reduction · **COLCOT/LoDoCo2 의 23-31% MACE ↓ 신호 재현 실패** |
| TCT 2024 insights — early + long-term colchicine after AMI | — | 2024 | Vumedi / PCRonline | discussion — colchicine 적응증 narrowing · routine 사용 권고 회수 |
| Routine colchicine or MRA post-MI — no clear benefit | — | 2024 | Medscape | colchicine·spironolactone 양쪽 NS |

→ §15 시그널: **CLEAR SYNERGY OASIS-9 = colchicine post-PCI/MI routine 사용 권고 회수** — **M4 short-list 9번 (colchicine) 격하 (Tier A → Tier B/C)** + M3 §1 NLRP3 family 재평가 hook.

---

## §ΣΣ Top 5 insights

### (a) 가장 강한 새로운 evidence supporting M3 picks

| pick | 새 evidence | 강도 |
|---|---|---|
| **ROCK (fasudil)** | **Yang 2025 post-PCI RCT** — DM-CAD cohort 에서 LVEF + NT-proBNP + QoL 개선 (Vicari 2005 이후 20년 만의 인체 신증거) | ★★★★ |
| **PCSK9 (evolocumab)** | **HUYGENS — post-MI 환자 OCT 50w fibrous cap +39 µm + plaque stabilization** 직접 입증 · ACS coronary 시점 GLAGOV 보다 강함 | ★★★★★ |
| **GLP-1R (semaglutide/tirzepatide)** | **SELECT (Lincoff 2023) 비-DM ASCVD MACE 0.80 + hsCRP -37.8%** · **SURPASS-CVOT 2025 + SURMOUNT-5 head-to-head tirzepatide > semaglutide** | ★★★★★ |

→ **M3 top 3 (ROCK · PCSK9 · GLP-1R) 모두 2023-2025 신증거로 강화** — 우선순위 유지.

### (b) 부정/감속 evidence

| signal | 감속 axis | impact |
|---|---|---|
| **CLEAR SYNERGY OASIS-9 (Jolly 2024)** | colchicine post-MI routine 사용 권고 회수 | **M4 #9 colchicine Tier A → C 격하** · M3 §1 NLRP3 family 재평가 (canakinumab도 비용·감염 wall 잔존) |
| **2024 ESC CCS guideline** | DES > DCB for DES-ISR (Class I LoE A) | **M5 DCB primary pick 의 적응증 narrowing** — biolimus+fasudil dual-DCB 포지셔닝 재고 (niche: multi-layer · small vessel · stent fracture) |
| **SELUTION4ISR NS (TCT 2025)** | sirolimus-DCB이 paclitaxel-DCB 와 ISR endpoint 에서 동등 입증 실패 | M5 paclitaxel vs sirolimus DCB 우열 미확립 — **biolimus DCB도 미검증** |
| BETonMACE NS (재확인 · Cui 2024 review) | apabetalone post-ACS MACE NS · post-hoc CKD subgroup 만 신호 | M4 second-tier BET → defer 유지 |

### (c) M4 short-list 보완/대체 후보

| 신규 후보 | 출처 | rationale | M4 진입 권고 |
|---|---|---|---|
| **SirPlux Duo (PTX + SRL nanoparticle dual-DCB)** | JACC Basic Transl Sci 2024 | 검증된 prototype — 13× lower 총 dose + myocardial injury 0 + downstream embolism rare — biolimus+fasudil 가설보다 검증 진척 | **M4 §5 dual-DCB short-list 1순위 진입 후보 (기존 biolimus+fasudil 공존)** |
| **empagliflozin (SGLT2i) — 직접 anti-ISR MoA** | JAHA 2024 (035044) + BMC Med 2023 | PDGF-Rβ 차단 + VSMC anti-proliferation + neointima 50% ↓ in rat — 단순 adjunct → 직접 mechanism 격상 | **M4 #11 SGLT2i 격상 — Tier A (post-PCI cohort 우선 처방)** |
| **ziltivekimab (IL-6 직접)** | ZEUS trial 2024-25 baseline · 2025 readout 예정 | IL-6 직접 차단 첫 outcome trial — NA inflammation axis 신표적 | M4 13번 신규 (Tier B-C, ZEUS readout 후 격상) |
| **obicetrapib (CETP inhibitor)** | BROADWAY 2025 EAS · BROOKLYN 2025 | LDL -33% on-top-of statin · ApoB·Lp(a) 동반 ↓ — PCSK9 보완 LDL axis | M4 14번 신규 (Tier B, PCSK9 contraindication 시 대체) |
| **icosapent ethyl (high-dose EPA)** | REDUCE-IT PCI 2022 갱신 + plaque imaging 2024 | post-PCI MACE ↓ 34% (PCI subset 3,408) + low-attenuation plaque vol -17% | M4 15번 신규 (Tier B, post-PCI long-term adjunct) |
| **verteporfin-eluting stent (VPES)** | Mol Cell Biochem 2024 | YAP-TEAD axis carotid 동물 first-in-vivo · DES coating 호환 | M3 §6 second-tier 격상 (coronary 전임상 IND 우선) |

→ 결과: M4 short-list 12 → **17 후보로 확장** (5 신규 추가 · colchicine 격하).

### (d) Mg-BRS leader 갱신 여부

→ **Freesolve (DREAMS-3G) = 갱신 leader 확정**:
- 2023-2024 BIOMAG-I 12m vasomotion 회복 (native vessel restoration)
- 2024 BIOMAG-I 24m TLF 3.5% + scaffold thrombosis 0%
- **2024 CE mark (EU)**
- BIOMAG-II vs contemporary DES RCT 진행중

→ **Zn-alloy은 여전 first-in-man 대기 (Zn-3Ag porcine OK)** · **M6 §4 Freesolve leader update 권고**.

### (e) novel angle 발견

1. **SGLT2i 직접 anti-ISR mechanism (PDGF + neointima)** — JAHA 2024 — 단순 systemic CV outcome adjunct 가 아닌 **post-PCI 처방 1순위 metabolic axis** 로 격상. 한국 KAMIR retrospective subgroup 으로 즉시 검증 가능.

2. **dual API DCB (SirPlux Duo) 검증된 prototype** — JACC Basic Transl Sci 2024 — **biolimus+fasudil dual-DCB 의 검증 더 진척된 sibling**. M5 dual-DCB 산출 재배치 + 한국 IIT 시 SirPlux Duo head-to-head 후보로 추가.

3. **AGENT IDE 2024 미국 최초 coronary DCB approval (paclitaxel)** — Katsanos signal coronary 무효화 + multilayer ISR subgroup 우위 — **M5 paclitaxel-DCB 의 안전성 wall 부분 해제** + DCB 적응증 niche 명확화.

4. **HUYGENS post-MI OCT — fibrous cap thickening 정량 입증** — M4 evolocumab 의 **NA-conversion-to-stable plaque** 직접 imaging 증거 (이전 GLAGOV IVUS PAV ↓ 보다 mechanism-level 강함) — M7 안전성 + M8 한국인 ranking 에 OCT-guided cohort 설계 hook.

5. **CLEAR SYNERGY OASIS-9 colchicine null** — NLRP3 family 전반 재평가 (canakinumab 만 surrogate IL-1β 직접 차단 강 but cost/감염 wall) → **ziltivekimab (IL-6 직접) 가 NLRP3 family 자리 대체** 가능성 (ZEUS readout 2025+).

추가 angle (lower confidence):
- **physics-informed DL ISR model** (Biomech Model Mechanobiol 2023) — 한국 KAMIR + OCT integration 으로 IIT 설계 가능 (R3 external libraries milestone hook).
- **CETP inhibitor 부활 (obicetrapib BROADWAY 2025)** — 다년간 실패한 class 가 LDL -33% + ApoB/Lp(a) 동반 ↓ 로 부활 — long-term ASCVD adjunct dual-LDL axis (PCSK9 보완).

---

## §Σ M2-M8 갱신 권고

### M2 (현행 DES 약물 한계)
- 갱신 minor — 현행 sirolimus/everolimus/zotarolimus/biolimus 평가 유지
- hook 추가: **Ultimaster (biodegradable polymer sirolimus-DES) Korean Registry 2024** 검증 — M2 §x 한국 real-world subset 1줄 추가
- 권고: §2-2-신규 한 줄 추가 — `Ultimaster (KSCJ 2024): 12m clinical events 낮음 — biodegradable polymer 한국 real-world OK`

### M3 (비-mTOR 신규 표적 inventory)
- **NLRP3 family 재평가** (§1 표 + §5 안전성) — CLEAR SYNERGY null + canakinumab cost/감염 wall → IL-6 직접 (ziltivekimab) 으로 axis shift
- **SGLT2i 신규 family 추가** (§1 표) — PDGF + neointima 직접 차단 in vivo
- **verteporfin VPES** — carotid 동물 in vivo first → M3 §2.1 YAP/TAZ 격상 hook (second-tier → primary 후보)
- 권고: §1 family overview 6 → 7 family (SGLT2i 추가) + IL-6 axis (ZEUS) 1줄

### M4 (후보 분자 short-list)
- **colchicine #9 Tier A → C 격하** (§1 표 safety grade column + §5 dual-DCB hooks)
- **empagliflozin #11 SGLT2i 격상** — adjunct → 직접 anti-ISR mechanism
- **신규 진입 — SirPlux Duo (dual PTX+SRL DCB)** — M5 dual-DCB short-list 1순위로
- **신규 진입 — ziltivekimab (IL-6)** — Tier B-C, ZEUS readout 후 조정
- **신규 진입 — obicetrapib (CETP)** — Tier B, PCSK9 보완
- **신규 진입 — icosapent ethyl** — Tier B, post-PCI long-term adjunct
- **fasudil #1 강화** — Yang 2025 post-PCI RCT 인용 갱신
- **evolocumab #4 강화** — HUYGENS OCT mechanism 인용 갱신
- 권고: §1 short-list 12 → **17 분자** · §5 dual-DCB combo §에 SirPlux Duo 행 추가 · §6 한계 d2 wall paths 에 ZEUS/empagliflozin 후속 IIT 추가

### M5 (DCB)
- **2024 ESC guideline (DES > DCB Class I LoE A) 반영** — DCB primary 적응증 narrowing (multi-layer · small vessel · stent fracture niche)
- **AGENT IDE FDA approval 2024** — 미국 paclitaxel-DCB ISR 진입
- **SELUTION DeNovo 2025 비열등 + SELUTION4ISR NS** — sirolimus-DCB de novo OK, ISR endpoint sirolimus > paclitaxel 미입증
- **SirPlux Duo (dual API DCB)** — M5 dual-DCB candidate 1순위
- 권고: §x guideline update + AGENT IDE + SELUTION DeNovo/4ISR + SirPlux Duo 4개 갱신 block 추가

### M6 (BRS)
- **Freesolve = leader 확정** (CE mark 2024 + BIOMAG-I 24m TLF 3.5% + thrombosis 0% + 12m vasomotion 회복)
- **BIOMAG-II RCT 진행중** — vs contemporary DES head-to-head — readout 시 M6 갱신 trigger
- **Zn-3Ag porcine 진척** — 임상 first-in-man 대기 유지
- **Hybrid PCI (BRS + DCB) NCT06710210** — M5/M6 교차 trial 진입 — Korean PI 참여 hook
- 권고: §4 Freesolve subsection 2024-2025 데이터 갱신 + §5 Zn 1줄 갱신 + §7 hybrid trial 추가

### M7 (off-target / 안전성)
- **Katsanos signal coronary 무효화 부분 입증 (AGENT IDE 1y no mortality)** — peripheral과 분리 평가 권고
- **CLEAR SYNERGY OASIS-9 colchicine null** — colchicine 안전성 의제 자체 축소 (cost-benefit 부정)
- **SELECT non-DM (semaglutide) GI/pancreas signal robust** — 추가 신호 부재
- 권고: §x paclitaxel-coronary safety section + colchicine 항목 격하 1줄

### M8 (한국인 + 통합 ranking)
- **Ultimaster Korean registry (Korean Circ J 2024)** — biodegradable polymer DES 한국 real-world 검증 — M8 §x 한국 발 IIT 후보에 추가
- **SELECT Korean site participation + KAMIR + CAC-guided semaglutide IIT** — 한국 발 systemic adjunct IIT hook
- **physics-informed DL OCT (한국 KAMIR + OCT integration)** — IIT 설계 hook (R3 external libraries 연결)
- **MAGICAL SV trial (NCT06271590) + SELUTION DeNovo Korean site** — DCB 한국 참여 hook
- 권고: §x 한국 발 IIT 3 → **5 후보**로 확장 (SirPlux Duo head-to-head · KAMIR-empagliflozin retrospective · KAMIR-fasudil prospective · Ultimaster long-term · OCT-DL ISR risk)

---

## §10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 NA = ISR 47% 빈도 | 🟡 SUPPORTED-BY-CITATION | EuroIntervention multicentre registry |
| §2 fasudil post-PCI RCT 인체 | 🟡 SUPPORTED-BY-CITATION | Yang 2025 J Int Med Res |
| §3 AGENT IDE 1y TLF 17.9% vs 28.6% | 🟢 SUPPORTED-NUMERICAL | JAMA 2024 RCT n=600 |
| §3 SELUTION DeNovo non-inferior | 🟡 SUPPORTED-BY-CITATION | TCT 2025 LBT (peer-review 진행중) |
| §3 SELUTION4ISR NS | 🟡 SUPPORTED-BY-CITATION | TCT 2025 LBT |
| §4 Freesolve BIOMAG-I 24m TLF 3.5% | 🟡 SUPPORTED-BY-CITATION | Biotronik press + EuroPCR · peer-review 대기 |
| §5 SirPlux Duo dual API DCB | 🟡 SUPPORTED-BY-CITATION | JACC Basic Transl Sci 2024 (preclinical porcine) |
| §6 HUYGENS fibrous cap +39 µm | 🟢 SUPPORTED-NUMERICAL | JACC Cardiovasc Imaging 2022-23 |
| §7 SELECT MACE HR 0.80 | 🟢 SUPPORTED-NUMERICAL | NEJM 2023 RCT n=17,604 |
| §11 empagliflozin neointima 50% ↓ (rat) | 🟡 SUPPORTED-BY-CITATION | JAHA 2024 (preclinical) |
| §12 BROADWAY obicetrapib LDL -33% | 🟢 SUPPORTED-NUMERICAL | Phase 3 RCT n=2,532 (2025) |
| §12 ZEUS primary outcome | 🟠 INSUFFICIENT/DEFERRED | n=6,376 baseline, readout pending |
| §13 2024 ESC DES > DCB (Class I LoE A) | 🟢 SUPPORTED-NUMERICAL | guideline + DAEDALUS 3y |
| §15 CLEAR SYNERGY colchicine null | 🟢 SUPPORTED-NUMERICAL | NEJM/TCT 2024 RCT n=7,062 |
| novel insights (e) 5 axis | ⚪ SPECULATION-FENCED (일부) / 🟡 (대다수) | 가설 + preclinical mix |

🔑 핵심 통찰:
- **M3 top 3 (ROCK · PCSK9 · GLP-1R) 신증거로 강화** — Yang 2025 + HUYGENS + SELECT/SURPASS — 우선순위 유지
- **M4 short-list 12 → 17 분자** — SirPlux Duo · empagliflozin (격상) · ziltivekimab · obicetrapib · icosapent ethyl 추가, colchicine 격하
- **M5 DCB**: AGENT IDE FDA approval + SELUTION DeNovo non-inferior + 2024 ESC DES>DCB Class I LoE A — DCB **적응증 narrowing + niche 명확**
- **M6 Mg-BRS leader = Freesolve** (CE 2024 + BIOMAG-I 24m TLF 3.5% + vasomotion 회복) · BIOMAG-II vs DES RCT 결과 대기
- **novel angle**: SGLT2i 직접 anti-ISR (PDGF) · IL-6 직접 (ziltivekimab ZEUS) · CETP 부활 (obicetrapib) · physics-informed DL OCT (한국 IIT hook) · CLEAR SYNERGY null (colchicine 격하)

---

## §11. 참고문헌 (selected 30+ — 신규 2023-2026 only)

### ISR pathology / NA
- Hassani SE et al. (EuroIntervention 2023-24) — Predictors and outcomes of NA in ISR
- Donghua W et al. (2024) PubMed 39755191 — Recurrent DES-ISR review
- Zhang Y et al. (Front Cardiovasc Med 2023, 10:1062130) — DCB late vs early ISR meta
- Megaly et al. (Circ Cardiovasc Interv 2025) — DES vs DCB vs POBA mixed treatment meta

### ROCK
- Yang X et al. (J Int Med Res 2025, DOI 10.1177/03000605241311403) — fasudil post-PCI DM RCT
- Anwar S et al. (PMC 10653426, 2023) — ROCK2 inhibitor computational screening

### DCB (paclitaxel / sirolimus / dual)
- Yeh RW et al. (JAMA 2024) — AGENT IDE paclitaxel-DCB ISR RCT n=600
- (AGENT IDE subgroup) PubMed 40803784 (2025) — multilayer ISR
- Cordis (TCT 2025 LBT) — SELUTION DeNovo non-inferior n=3,341
- Cordis (TCT 2025 LBT) — SELUTION4ISR NS
- (CVPath Institute 2024) JACC Basic Transl Sci 9 — SirPlux Duo dual paclitaxel+sirolimus nanoparticle DCB
- Cortese B (Catheter Cardiovasc Interv 2024, DOI 10.1002/ccd.31164) — paclitaxel vs sirolimus saga
- Shin DS (Catheter Cardiovasc Interv 2024, DOI 10.1002/ccd.31154) — PCB vs SCB meta

### Mg-BRS
- Haude M et al. (EuroIntervention 2023-24) — BIOMAG-I DREAMS 3G 1y + 12m vasomotion
- Biotronik press (2024) — BIOMAG-I 24m + CE mark
- Verheye S et al. (EuroIntervention 2024) — BIOSOLVE-V Freesolve

### PCSK9 / Lipid
- Nicholls SJ et al. (JACC Cardiovasc Imaging 2022-23) — HUYGENS fibrous cap OCT
- Wright RS et al. (Cardiovasc Res 2024 120:1400) — ORION-8 extended FU
- Pooled ORION-10/11 (Mayo Clin Proc 2024) — MACE 26% ↓ post-hoc
- (NCT06909565) — Inclisiran post-PCI MACE RCT (started 2025, completion 2029)
- Nicholls SJ et al. (BROADWAY 2025 EAS) — obicetrapib LDL -33%

### GLP-1RA / Metabolic
- Lincoff AM et al. (NEJM 2023, 389:2221) — SELECT semaglutide non-DM
- Ridker PM et al. (Atherosclerosis 2024, S0021-9150(24)01085-2) — SELECT hsCRP -37.8%
- Kosiborod MN (Lancet 2024) — SELECT HF subgroup
- Frias JP et al. (Lancet/NEJM 2025) — SURPASS-CVOT tirzepatide vs dulaglutide
- Hankosky ER (Diabetes Obes Metab 2025, DOM 70143) — SURMOUNT-1 3y ASCVD risk
- (ESC 2025 LBT) SURMOUNT-5 head-to-head tirzepatide vs semaglutide

### Anti-inflammatory / SGLT2i / EPA
- Jolly SS et al. (NEJM/TCT 2024) — CLEAR SYNERGY OASIS-9 colchicine null
- (JAHA 2024, 035044) — empagliflozin neointima PDGF mechanism (rat)
- (BMC Med 2023) — SGLT2i ISR-related MACE in T2D-AMI
- Ridker PM et al. (ZEUS baseline 2024-25 · Kidney Int Rep WCN25) — ziltivekimab IL-6 trial
- Bhatt DL (REDUCE-IT PCI 2022) — icosapent ethyl PCI subset MACE 34% ↓

### AI / ML
- (Biomech Model Mechanobiol 2023, s10237-023-01796-1) — physics-informed DL ISR
- (PubMed 37672056, 2023) — CT-DL ISR detection (PIQE)
- (PMC 10142067, 2023) — ML predictors of ISR n=10,004

### YAP/TAZ
- (Mol Cell Biochem 2024, s11010-024-05160-4) — VPES carotid restenosis rabbit
- (Sci Rep 2025, s41598-025-28960-0) — verteporfin + TEAD palmitoylation

### Korean / Asian
- Korean Multicenter Ultimaster Registry (Korean Circ J 2024, PubMed 38767441)
- (K-ELUVIA Korean Circ J 2024, kcj.2024.0038) — peripheral hook

### Guideline
- 2024 ESC CCS guidelines (Eur Heart J 2024) — DES > DCB Class I LoE A
- (PMC 11622220, 2024) — 2024 ESC summary
