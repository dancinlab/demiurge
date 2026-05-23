# ISR — log

Append-only history sister of `ISR.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-25T05:00:00Z — V4 final tier ledger + ISR verify-phase closure

- [x] §0 methodology + ISR @goal 달성도 framework
- [x] §1 🔵 0 current · 28 potential post-unlock (verbatim list)
- [x] §2 🟢 0 current · 10 potential post-unlock
- [x] §3 🟡 150+ citation-locked (RCT · registry · guideline · regulatory · anatomic)
- [x] §4 🟠 V2 7 + V1 15 deferred verbatim
- [x] §5 ⚪ V3 3 + V2 7 fence verbatim
- [x] §6 🔴 0
- [x] §7 atlas register status (16066 nodes · 0 PR)
- [x] §8 dependency map (4 inbox patches + 10 absorbable libs)
- [x] §9 @goal 정량 달성도
- [x] §10 ISR domain 종합 verdict
- [x] §11 다음 단계 (post-closure)
- [x] 산출물 `ISR/verify/V4_tier_ledger.md` (681 lines)

🔑 verdict 분포: 🔵 0/28 (kernel block) · 🟢 0/10 (kernel block) · 🟡 150+ · 🟠 22 · ⚪ 10 · 🔴 0 — LLM self-judge 0건, V2/V3 의 `hexa verify` verbatim verdict 100% paste.
🌱 post-unlock: hexa-lang `bio-verify-kernel-extension-2026-05-25` PR merge (4-5 stacked PR · ~400-600 LOC) 시 7-28 🔵 + 3-10 🟢 escalation 예상 (single hexa-lang PR · cross-domain 50-90 🔵).
🛡 per @D d2 — 32 🟠/⚪ 모두 breakthrough path A/B/C 명시 · concede 0건.
🚪 ISR domain ▓▓▓▓▓▓▓▓▓▓ 100% (15/15) — verify-phase honest closure. 정성 closure 100% · 정량 verified ratio = post-PR-merge 의존.

## 2026-05-25T04:00:00Z — V3 🟢 numerical push first-pass (3 pipelines) 완료

- [x] §0 demiurge 자산 매트릭스 (`hexa cloud` + ubu-1 = aiden-B650M-K · python 3.12.3 · numpy 2.4.4 · scipy 1.17.1; `pool list` 는 compile error → `hexa cloud run ubu-1` 우회)
- [x] §1 NUM-06 PK/PD ODE 1-comp — verdict ⚪ SPECULATION-FENCED (`hexa verify --fence`) · stdout 30d 99.7% released vs lit 80-90%
- [x] §2 NUM-03 Mg Tafel ODE — verdict ⚪ SPECULATION-FENCED · stdout 6.27 mm/yr vs BIOSOLVE-IV 12mo (passivation gap 40x)
- [x] §3 Stokes-Einstein D — verdict ⚪ SPECULATION-FENCED · stdout 1.4-4.1e-11 m²/s vs lit 1e-12 to 1e-11 (upper-bound match)
- [x] §4 Heavy pipelines plan (NUM-01 DFT · NUM-02 MD · NUM-04 CFD · NUM-05 FEA) — DEFERRED 명시 · cost/atom_id/path A/B/C 매핑
- [x] §Σ 3 light × verdict 표 (verbatim `hexa verify --fence` 3건)
- [x] §Δ heavy pipelines 권고: 첫 push = NUM-01 drug-polymer DFT (pool ubu-1 free · $0 · RTSC QE 7.5 전례)
- [x] 산출물 `ISR/verify/V3_numerical_recompute.md` (342 lines)

🔑 verdict 분포: 🔵 0 / 🟢 0 / 🟡 0 / 🟠 0 / 🔴 0 / ⚪ 3 — `hexa verify --expr` float-arg 미지원 + bio.* kernel 부재 (V2 와 동일 wall). LLM-judge 0건, 모두 `hexa verify` verbatim verdict.
🌱 heavy pipelines deferred: 4 (NUM-01 DFT · NUM-02 MD · NUM-04 CFD · NUM-05 FEA) — 다음 batch · 첫 push 권고 NUM-01 (pool ubu-1 free · RTSC 전례).
🛰 demiurge 자산 confirm: `hexa cloud copy-to ubu-1` ×3 (scp exit 0) + `hexa cloud run ubu-1 -- python3 ...` ×3 (remote exit 0) + `hexa verify --fence` ×3. ad-hoc python -c 0 · 로컬 scipy 0 · sympy 0.
🛡 per @D d2 — 3 ⚪ verdict 도 honest fence + 🟢 승격 path 명시 (hexa-lang inbox `bio.*` kernel patch 3건 — pool.hexa compile error · `--expr` float kernel · `cloud run` heredoc).
🥇 다음 milestone 권고 = NUM-01 DFT push (V3-2) 또는 V4 ledger 직행 (현 verdict ledger 만으로도 통합 가능).

## 2026-05-25T03:00:00Z — V2 🔵 closed-form push (7 identities) 완료

- [x] §0 hexa verify CLI signature 확인
- [x] §1 Hill — verdict 🟠 INSUFFICIENT (--expr) · ⚪ SPECULATION-FENCED (--fence)
- [x] §2 Cheng-Prusoff — verdict 🟠 INSUFFICIENT (--expr) · ⚪ SPECULATION-FENCED (--fence)
- [x] §3 Beer-Lambert — verdict 🟠 INSUFFICIENT (--expr) · ⚪ SPECULATION-FENCED (--fence)
- [x] §4 exp release — verdict 🟠 INSUFFICIENT (--expr) · ⚪ SPECULATION-FENCED (--fence)
- [x] §5 LDL Δ% — verdict 🟠 INSUFFICIENT (--expr) · ⚪ SPECULATION-FENCED (--fence)
- [x] §6 Higuchi — verdict 🟠 INSUFFICIENT (--expr) · ⚪ SPECULATION-FENCED (--fence)
- [x] §7 Fick 1차 — verdict 🟠 INSUFFICIENT (--expr) · ⚪ SPECULATION-FENCED (--fence)
- [x] §Σ atlas register PR count: 0 (HONEST DEGRADE per --from-verify · 🟠 시 PR 미생성)
- [x] 산출물 `ISR/verify/V2_formal_identities.md` (~430 lines)

🔑 verdict 분포: 🔵 0 / 🟢 0 / 🟡 0 / 🟠 7 / 🔴 0 / ⚪ 7 — `hexa verify --expr` calc kernel 에 bio fn 부재 + float arg 거부 (int-only) 발견. LLM-judge 0건, 모두 verify CLI verbatim verdict.
🌱 atlas absorption: 0 identities · PR URLs 없음 (HONEST DEGRADE — calc kernel 부재시 `--from-verify` 가 PR 거부).
🛡 per @D d2 — 3 breakthrough path surface: path A (verify_cli.hexa::_recompute extend, ~385 LOC) · path B (V3 numerical 우회, NUM-06 PK/PD ODE local CPU) · path C (atlas append-witness --kind F 으로 🟡 citation-locked 직행).
🥇 다음 milestone 권고 = V3 (path B 직행) — V1 §9.3 top 3 (NUM-06 · NUM-03 · NUM-01) 그대로 진행 가능.

## 2026-05-25T02:00:00Z — V1 claim inventory + tier triage 완료

- [x] §1 Inventory methodology
- [x] §2 🔵 후보 (28 closed-form identities · ≥20 요구 충족)
- [x] §3 🟢 후보 (10 numerical pipelines · ≥6 요구 충족)
- [x] §4 🟡 (50+ RCT inevitable · 대표 50 inline · 전수 V4 ledger)
- [x] §5 🟠 deferred (15+) + breakthrough paths (A/B/C 각각, per @D d2)
- [x] §6 hexa verify 실행 plan (V2 입력) — tier 1~8 batch
- [x] §7 atlas register plan (--from-verify --auto-pr · F/S/X/R kind 매핑)
- [x] §8 V3 numerical pipeline plan (pool ubu-1/2 · RunPod GPU · local CPU per @D d7)
- [x] §9 V4 ledger 미리 보기 (🔵 28 · 🟢 10 · 🟡 150+ · 🟠 15+)
- [x] 산출물 `ISR/verify/V1_claim_inventory.md` (~417 lines)

🔑 핵심: 🔵 28 · 🟢 10 · 🟡 150+ · 🟠 15+ 분포 (200+ total claim) · ISR domain 의 **75% citation-locked** (인체 RCT/registry/guideline 본질).
🥇 V2 첫 push 권고 top 5 🔵 (변수 ≤3 · 즉시 atlas PR): (1) Hill 방정식 · (2) Cheng-Prusoff · (3) Beer-Lambert · (4) first-order exp release · (5) LDL Δ% identity.
🌱 V3 첫 push 권고 top 3 🟢: (1) PK/PD ODE local CPU · (2) Mg Tafel ODE local · (3) drug-polymer DFT pool ubu-1 (RTSC 전례).
🛡 🟠 15 모두 breakthrough path A/B/C 명시 (concede 금지 per @D d2).

## 2026-05-25T01:00:00Z — R3 external libraries inventory + patent + hexa-lang inbox 완료

- [x] §1 stent/balloon suppliers (16 vendor — Big 4 + Mid 4 + DCB 4 + 한국 4)
- [x] §2 drug DBs (7 — DrugBank · ChEMBL · PubChem · BindingDB · STITCH · IUPHAR · Probes & Drugs)
- [x] §3 coronary biomechanics simulators (8 — Abaqus · ANSYS · FEBio · OpenFOAM · CRIMSON · SimVascular · 3D Slicer · CardioFAN)
- [x] §4 OCT/IVUS analysis tools (8 — LightLab · ILUMIEN · Volcano · HD-IVUS · StentOptics · OCTopus · ISIDORA · LCA-OCT)
- [x] §5 PK/pharmacology (5 — Simcyp · PK-Sim/MoBi · GastroPlus · NONMEM · SimBiology)
- [x] §6 AI/ML libraries (8 — MONAI · CardioMRI · DLCA · CorNet · PyRadiomics · TorchIO · MMSeg · OCT-Net)
- [x] §7 registry platforms (5 — REDCap · OpenClinica · K-DES · IMPULSE · Castor)
- [x] §8 patent landscape (top 20 + FTO 🔴 7건 / 🟠 6건 / 🟢 7건)
- [x] §9 hexa-lang absorbable findings — 10 entries filed to `hexa-lang/inbox/notes/2026-05-25-*.md`
- [x] 산출물 `ISR/research/external_libraries.md` (~274 lines)

🔑 핵심: 16 vendors · 20 patents · **10 hexa-lang absorb candidates**.
🔴 FTO red-zone 3: #17 ROCK-CV Markush (Asahi/UTokyo) · #5 dual-DCB (Concept Medical) · #3/#4 sirolimus carrier.
🌱 hexa-lang stdlib namespace 제안: `bio.chem.* · bio.sim.* · bio.pk.pbpk · bio.imaging.med · bio.registry.edc`.
🆕 추가 hook: M3 신규 표적 3종 (JAK/STAT · MK2 · HMGB1) · M4 추가 2종 (GS-4997 ASK1 · CCX140 CCR2) · M6 full FOSS biomech pipeline.

## 2026-05-25T01:00:00Z — R1 arxiv/PubMed deep research sweep 완료

- [x] §0 sweep methodology (10 + 5 novel queries, 2023-01 ~ 2026-05)
- [x] §1-§10 per-query findings (top 3-7 hits each)
- [x] §11-§15 novel angle queries (SGLT2i · ZEUS/BROADWAY · 2024 ESC · VPES · CLEAR SYNERGY)
- [x] §ΣΣ Top 5 insights — (a) M3 top 3 강화 · (b) colchicine/ESC 감속 · (c) M4 12→17 분자 · (d) Freesolve leader 확정 · (e) 5 novel angles
- [x] §Σ M2-M8 갱신 권고 (per-milestone block)
- [x] 산출물 `ISR/research/arxiv_deep_research.md` (~410 lines)

🔑 핵심: (1) M4 short-list 12→17 분자 — SirPlux Duo (dual PTX+SRL 검증 prototype) · empagliflozin (PDGF anti-ISR 직접 MoA) · ziltivekimab (IL-6) · obicetrapib (CETP) · icosapent ethyl 진입, colchicine Tier A→C 격하 (CLEAR SYNERGY null). (2) M3 top 3 (ROCK·PCSK9·GLP-1R) 모두 2023-2025 신증거 강화 — Yang 2025 post-PCI fasudil RCT · HUYGENS fibrous cap +39µm · SELECT/SURPASS non-DM. (3) M5 DCB 적응증 narrowing — 2024 ESC DES>DCB Class I LoE A + AGENT IDE FDA approval (paclitaxel 미국 ISR 진입). (4) M6 Mg-BRS leader = Freesolve (CE 2024 + BIOMAG-I 24m TLF 3.5% + vasomotion 회복) 확정. (5) novel angle: SGLT2i 직접 anti-ISR · IL-6 ZEUS · CETP 부활 (obicetrapib BROADWAY) · physics-informed DL OCT (한국 IIT hook) · VPES carotid 동물 진척.

## 2026-05-25T01:00:00Z — R2 web/regulatory research 완료

- [x] §1 regulatory state matrix (FDA · EMA · MFDS · PMDA)
- [x] §2 guideline ladder (ESC · ACC/AHA · KCSC · NICE)
- [x] §3 ongoing trials inventory (≥10 NCT)
- [x] §4 한국 regulatory + reimbursement
- [x] §5 FDA paclitaxel letter timeline
- [x] §6 breakthrough designations
- [x] §7 M8 IIT 3 후보 정렬
- [x] §8 한국 IIT 우선순위 갱신
- [x] 산출물 `ISR/research/regulatory_pipeline.md` (~302 lines)

🔑 핵심: regulatory window 3 (AGENT MFDS Asia-first · fasudil-DCB MFDS+PMDA cross · Freesolve Korean sites) · ongoing trials white space = ROCK/YAP/GLP-1R local DCB (IIT-1 선점 우위) · IIT-1+IIT-3 동급 1순위 격상 + IIT-1.5 (AGENT 한국 post-approval registry) · IIT-4 (Freesolve Korean sites) 신규 권고.

## 2026-05-25T00:00:00Z — M8 통합 ranking + ISR domain closure

- [x] §1 한국인 registry 매핑 (K-DES · EXCELLENT · HOST · GRAND-DES · K-DCB · K-iDES)
- [x] §2 ranking criteria 7축 (NH 15% · NA 25% · re-endo 15% · safety 20% · maturity 10% · delivery 10% · 한국 evidence 5%)
- [x] §3 최종 top 10 ranking (#1 biolimus+fasudil dual-DCB 80.5 · #2 3G bio-polymer DES 78.0 · #3 PCSK9/GLP-1R systemic 72.0)
- [x] §4 한국 발 IIT 3 후보 설계 (IIT-1 fasudil-DCB FIH · IIT-2 dual-DCB pilot · IIT-3 PCSK9/GLP-1R registry-RCT)
- [x] §5 잔여 wall + d2 breakthrough 3-path (hexa kick · GRAND-DES embedded · 한·일 Asian DCB consortium)
- [x] §6 ISR domain closure + 다음 도메인 hook (DAPTPGX · LPA · NOREFLOW · HERPES)
- [x] 산출물 `ISR/M8_rank.md` (~298 lines)

🏆 차세대 우승 후보: **biolimus + fasudil dual-DCB** (80.5/100)
🎯 한국 발 IIT 우선: **IIT-1 fasudil-DCB first-in-human** (n=60, 15-25억 KRW, KCSC 6-8 sites)
🚪 ISR domain ▓▓▓▓▓▓▓▓▓▓ 100% closure (정성). @goal 달성도 90% (wet-lab IIT 진입 시 100% 정량).

## 2026-05-24T23:00:00Z — M4 후보 분자 short-list 완료

- [x] §1 short-list overview 표 (12 분자 — ROCK 3 + PCSK9 3 + GLP-1R 2 + anti-inflammatory 2 + SGLT2i 2 + biolimus DCB 1)
- [x] §2 top 5 deep-dive (fasudil · evolocumab · semaglutide · colchicine · biolimus A9-DCB)
- [x] §3 delivery route matrix (DES coating · DCB · systemic) + dual-track ASCII
- [x] §4 drug-repurposing logic (fasudil · netarsudil · sema · colchicine · evolocumab · inclisiran · empa)
- [x] §5 M5 DCB combo hooks (biolimus mono · biolimus+fasudil dual · paclitaxel+sirolimus dual)
- [x] §6 한계 + M7/M8 입력 (safety 미검증 10 · 한국인 evidence 6 axis)
- [x] 산출물 `ISR/M4_candidates.md` (~280 lines)

🔑 핵심: short-list 12 · top 3 picks **fasudil-DCB · evolocumab · semaglutide** · dual-track 전략. 차세대 우승 후보 = **biolimus + fasudil dual-DCB** (M3 d2 wall NA + EC 보존 직접 hit · 한국 발 IIT 후보).

## 2026-05-24T23:00:00Z — M6 차세대 BRS 평가 완료

- [x] §1 BRS 개요 + 이론 장점
- [x] §2 Absorb 실패 4원인 (strut 157µm · PLLA recoil · GW2 lesion · sizing)
- [x] §3 2세대 폴리머 BRS 시도 표 (DESolve · MeRes100 · NeoVas · Firesorb · MAGNITUDE)
- [x] §4 Mg 합금 — Magmaris (1G) · Freesolve (2G strut 99-117µm · BIOSOLVE-IV ST 0.5%)
- [x] §5 Zn 합금 emerging (Mg-Fe 부식속도 중간)
- [x] §6 ISR 관점 잔여 wall (early NH 열등 · late NA 잠재 우위)
- [x] §7 비-mTOR 표적 × BRS coating 가능성 (fasudil-Mg-BRS · sirolimus-Zn-BRS)
- [x] §8 한계 + M7/M8 입력
- [x] 산출물 `ISR/M6_brs.md` (302 lines)

🔑 핵심: PLLA 사망 · **Freesolve (Mg 2G)** 현 시점 leader · M3 표적 × Mg/Zn combo 가 진짜 hook.

## 2026-05-24T23:00:00Z — M7 off-target / 안전성 통합 완료

- [x] §1 5대 안전성 도메인 (late ST · delayed healing · NA · 출혈 · systemic off-target)
- [x] §2 late ST 매핑 + ARC-2
- [x] §3 delayed healing & uncovered strut (1G vs 2G vs biopolymer)
- [x] §4 Katsanos 2018 paclitaxel 신호 + 후속 약화
- [x] §5 M3 family safety 통합 표
- [x] §6 M6 BRS 안전성
- [x] §7 후보별 안전성 grading (M8 입력)
- [x] §8 한국인 hooks
- [x] 산출물 `ISR/M7_safety.md` (~293 lines)

🔑 핵심: M3 picks 안전성 grade · Katsanos 신호 약화 trajectory · M6 BRS late ST 학습.

## 2026-05-24T22:00:00Z — M5 DCB 비교 완료

- [x] §1 DCB 원리 + ASCII
- [x] §2 paclitaxel vs sirolimus 표
- [x] §3 carrier 기술 inventory (iopromide · urea · BTHC · PEG-NP · sugar microreservoir)
- [x] §4 Mehran pattern 별 효과 (I★★★★★ · II★★★★ · III★★ · IV★)
- [x] §5 한국인/아시안 evidence (TIS · RESTORE-ISR · ChineseDCB)
- [x] §6 한계 + M7 hook (Katsanos PMA 신호 · re-do DCB · sirolimus retention)
- [x] §7 차세대 DCB (biolimus · 비-mTOR — YAP/TAZ · ROCK · BET combo)
- [x] 산출물 `ISR/M5_dcb.md` (~220 lines)

🔑 핵심: paclitaxel-DCB ESC IA 표준 / sirolimus-DCB carrier 진화중 / **M3 신규 표적 × DCB combo** 차세대 hook.

## 2026-05-24T22:00:00Z — M2 4종 DES 약물 한계 매핑 완료

- [x] §1 4종 약물 개요 표 (sirolimus · everolimus · zotarolimus · biolimus A9)
- [x] §2 mTORC1 공통 표적 + PI3K→AKT→mTORC1→S6K1/4E-BP1 pathway ASCII
- [x] §3 PK / 약물학 차이 표 (logP · IC50 · release t½ · burst · polymer)
- [x] §4 임상 효능 (LLL + TLR @12mo) — SIRIUS · SPIRIT · ENDEAVOR · RESOLUTE · LEADERS · NOBORI · BIOFLOW-V + Korean (EXCELLENT · HOST-REDUCE · RESET · GRAND-DES)
- [x] §5 5가지 미해결 wall — (a) 단일 표적 escape · (b) NA 미해결 · (c) delayed healing → late ST · (d) HBR DAPT 부담 · (e) DES-in-DES 효과 ↓
- [x] §6 M3 hook — 비-mTOR 표적 5축 (lipid·염증 · healing-selective · DAPT-free · 직교내성)
- [x] 산출물 `ISR/M2_current.md` (188 lines)

🔑 핵심: 4종 모두 FKBP12 → mTORC1 단일 경로 의존 → escape · NA 미해결 → M3 비-mTOR 표적 inventory 필수.

## 2026-05-24T22:00:00Z — M3 비-mTOR 신규 표적 inventory 완료

- [x] §1 5 family overview 표
- [x] §2 YAP/TAZ · HIF · ROCK · BET · Wnt deep-dive
- [x] §3 NA 표적 매트릭스
- [x] §4 mTOR 회피 logic + pathway ASCII
- [x] §5 안전성 우려 first-pass
- [x] §6 M4 short-list hooks
- [x] 산출물 `ISR/M3_targets.md` (~276 lines)

🔑 핵심: 5 family 중 **ROCK (fasudil/netarsudil) · PCSK9 · GLP-1R** 가 NA + safety + maturity 3축에서 우수. HIF · Wnt 는 safety red flag (polycythemia/tumor · 골 toxicity) 로 보류.

## 2026-05-24T21:25:00Z — M1 4-axis 기전 매핑 완료

- [x] §1 ISR 정의 + BMS/DES 세대별 빈도
- [x] §2 시간축 — early (NH) vs late (NA) 패러다임 시프트 ASCII
- [x] §3 4-axis (NH · NA · SF · US) × OCT/IVUS finding
- [x] §4 NH 메커니즘 (mTOR 경로 — 현행 DES 모두 동일 표적)
- [x] §5 NA 메커니즘 (d2 wall — 표적 부재) + 신규 표적 short-list (YAP/TAZ · HIF · ROCK · BET · PCSK9 · GLP-1R)
- [x] §6 세대별 ISR rate 표 (BMS / 1G / 2G / bioabsorbable polymer)
- [x] §7 Mehran 1999 패턴 분류 (DCB 효과 hooks)
- [x] §8 한국인 registry hooks (K-DES · EXCELLENT · HOST-IDEA · GRAND-DES)
- [x] 산출물 `ISR/M1_mechanism.md` (~170 lines)
- [ ] M3 신규 표적 효능 ranking
- [ ] M5 DCB Mehran 패턴별 효과

🔑 핵심 통찰:
- 2nd-gen DES 시대 잔여 wall = **neoatherosclerosis (3-10년)** — 늦은 시점이 새로운 적
- 현행 DES 모두 **mTOR 단일 표적 의존** → 비-mTOR 신규 표적 (M3) 필수
- NA → late stent thrombosis · ACS 인과 (Nakazawa 2011 autopsy)

## 2026-05-24T21:00:00Z — scaffold

- [x] @goal 확립 — ISR 비-mTOR 후보 short-list
- [x] M1-M8 milestone 설계
- [x] M1 4-axis 기전 매핑
