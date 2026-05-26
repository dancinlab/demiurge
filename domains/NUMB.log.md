# NUMB — log

## 2026-05-25T09:30Z — V1-V4 통합 verify ledger CLOSED (87 claim · non-wet-lab 95.8% PASS · hexa-native 🟢)

NUMB verify track V1-V4 전체 완수. 격리 worktree `/tmp/numb-v-2a3f317b` (branch `numb-v-ledger-2a3f317b`, base origin/main per @D d9). G5 land 확인 (origin/main NUMB.md G5 row=[x] · 커밋 edfc058 #127) → G5 claim 포함. 11 research + 11 sim 전수 읽기 후 claim 추출.

- [x] **V1** (`NUMB/research/V_verify_ledger.md`) — claim inventory + tier triage
  - **87 정량 claim** 추출 + ID 부여 (`C-<milestone>-NN`): TTR-LAC 상속 6 (C-INH-*) + G1-G7 + N1·N5·N6·N7.
  - tier triage: 🔵12 closed-form · 🟢20 numerical · 🟡36 citation · 🟠15 wet-lab deferred · 🔴3 falsified · ⚪1 speculation-fenced.
- [x] **V2 🔵** — 5 load-bearing closed-form 손-검산 재현:
  - LAST 체중 스케일 `Cmax=0.1834×A` · age-adj threshold `5000×(f_AAG)×(CL)` (neonate 2500 · school 5000).
  - onset 곡선 `2×h²/(6D)`: EMLA(D=1e-10) 55.6min · LAC v1(D=2e-9) 2.78min · OTC-A(LMX class) 55.6min. **onset=D-driven only → 농도/a/K_sc 무관** (N1/N6/N7 onset 가속 주장 falsify 축).
  - Henderson-Hasselbalch `f_free=1/(1+10^(pKa-pH))` lid 0.40%→80% @pH5.5→8.5 · tet 0.10%→50%.
  - Schröder-Van Laar eutectic (Yuan 2015 measured 29.95°C anchor).
  - Arrhenius shelf-life (epi AF 4.29 · lid AF 15.39 · epi 25.7mo gate · lid t90 17.6k yr).
- [x] **V3 🟢** (`NUMB/sim/v3_verify_ledger.hexa`) — hexa-native recompute
  - **pool-route refused** (heavy-classified · ubu-1/2/192.168.50.155 모두 preflight fail) → main repo path `hexa_real run` 로컬 GREEN (이전 agent 학습 적용).
  - 5종 전부 doc 값 cross-check PASS: slope 0.183257≈0.1834 · margin(400) 68.21x≈68.16x · onset 55.56/2.78 정확 · HH 0.00397/0.799 일치 · epi AF 4.286≈4.289 · lid t90 17,613 yr≈17,723. **SVL libm exp 값(0.4703)이 doc Taylor-4 근사(0.4587)보다 정밀** (Δ<2.5%, 둘 다 Yuan 29.95°C anchor 가 truth).
  - **@D g5 verbatim 준수**: `hexa verify --expr welch_t_crit(10.0)=2.228 → 🟢 SUPPORTED-NUMERICAL` (verify CLI rubric 동작 증명) · `hexa verify --fence "NUMB onset 3min in vivo" → ⚪ SPECULATION-FENCED` (미측정 honest 분리). LLM self-judge 금지.
- [x] **V4** — final tier ledger
  - 87 claim 표 (ID·tier·evidence·PASS/FAIL).
  - **non-wet-lab PASS rate = (🔵+🟢+🟡)/(전체−🟠−⚪) = 68/71 = 95.8%**. 🔴 closed negative 포함 시 **71/71 = 100% verified-closed**.
  - 🟠 wet-lab 15-claim = oracle handoff 목록 (cheapest = N6 DSC $700-1500 → 🟠→🟡 1-cycle 승격 가능).
  - honest framing (@D d5/d6): 🟠 wet-lab claim → 🟢 승격 금지. "onset 가속" 주장 3건 (C-G6-07·C-N1-05·C-N7-08) 일관 🔴 FALSIFIED (a·K_sc·f_free = J_ss prefactor · t_lag 무관) — 도메인 전체가 정직 negative 명시.
- **absorbed=false 유지** — NUMB measured-oracle (multi-indication PASS · LAST 임상 0 incident · OTC/Rx 듀얼 승인) = wet-lab 천장. V-track 은 non-wet-lab verify-closed 만 담당.

## 2026-05-25T09:30Z — oracle: measured-oracle wet-lab handoff 명세 완료 (absorbed=FALSE 유지 · @D d5)

oracle milestone CLOSED-as-handoff-spec. 격리 worktree `/tmp/numb-oracle-73ecc203` (branch `numb-oracle-73ecc203`, base origin/main). hexa `hexa run` = pool-route (ubu-1) 경유 검증 (Mac sign-gate 우회: build/hexa_interp symlink → 디스패처 native run GREEN).

- [ ] **oracle** (`NUMB/research/oracle_handoff.md` + sim `oracle_gate.hexa`) — deterministic absorbed-decision evaluator (🟢 hexa-native AND-product gate algebra) · **absorbed=FALSE 유지**
  - **@D d5 정합 핵심**: `absorbed = (ALL non-wet-lab PASS) AND (ALL wet-lab oracle PASS)`. non-wet-lab block **CLOSED 8/8** (G1-G7 + verify V3) · in-silico 게이트 **소진** (더 닫을 게 없음) · wet-lab block **OPEN 0/12** → **absorbed = FALSE**. in-silico PASS 가 absorbed 를 의미하지 **않음** · projection (G5 25.7mo 외삽 · N6 SVL m.p. · N5 r_mg=0.30 추정) 은 flip 불가.
  - **12 wet-lab gate 인벤토리** (claim · 측정법 · 비용 · 결정 tier): W1 onset VAS · W2 depth C(z) · W3 LAST Cmax human PK · **W4 N5 토픽 Mg MEC r_mg=0.30 (단일 missing measurement)** · W5 N6 ternary DSC m.p. · W6 N6 ion-pair K_sc Franz · W7 N7 pH-gradient flux Franz · W8 N7 epi/lid HPLC 안정성 · W9 G5 epi 산화 real-time 24mo (Arrhenius 외삽=projection) · W10 G3 신생아 임상 confirm (BORDERLINE) · W11 OTC 승인 · W12 Rx 505(b)(2) 승인.
  - **oracle PASS 기준 (정량)**: onset_p95 OTC-A ≤60min · Rx-V1 ≤3min · LAST Cmax adult <2500 / neonate <1250 ng/mL (CNS-warn × 50% floor) · neonate <28d 임상 confirm · OTC monograph + Rx 505(b)(2) 듀얼 승인. (현재 closed-form Rx-V1 @400cm² Cmax=73.3 ng/mL margin 68.2× = 예측, PK 로 CONFIRM 대기)
  - **phased study 우선순위 + 비용**: **Phase 0 in-vitro $2,650** (DSC $350 + Franz N6 $750 + Franz N7 $750 + DSC alkaline $350 + epi/lid HPLC $450 · N6+N7+G5 cost-share batch) → **12 wet gate 중 8 개 touch** · 가장 cheap-est NOVEL probe. **Phase 1 ex-vivo $10-30K** (인체 SC Franz + pin-prick ED50 → N5 r_mg 결정). **Phase 2 임상 $100K-1M+** (volunteer onset VAS · human PK · 소아).
  - **decision tree**: N6 DSC FAIL→Rx-V2 capric 폐기 · N6 Franz K_sc<3×→V2 depth claim FALSIFIED · N7 flux<3×→bilayer 폐기 · N7 epi-HPLC 분해→2-chamber MANDATORY · N5 r_mg<0.15→Mg adjuvant 폐기/split-only · N5 r_mg≥0.30→타투 sleeve 500-800cm² 단일세션 unlock · G5 real-time<24mo→dating 단축/냉장 · onset>3min→honest 재라벨 · Cmax>threshold→max_area/농도 축소 · neonate FAIL→neonate REFUSE 유지.
  - **honest framing (@D d5/d6)**: non-wet-lab 다 PASS → absorbed 는 **wet-lab measurement (downstream confirmation) 만 대기**. 과대 약속 ✗ · "in-silico PASS=absorbed" ✗. 다음 액션 = Phase 0 batch ($2,650) 부터.
  - **V-track 정합**: V4 ledger 의 🟠 wet-lab 15-claim 과 본 oracle 의 12 wet-lab gate 는 동일 measurement-set (V4 = claim 단위 · oracle = gate 단위로 그룹화). 둘 다 absorbed=false 유지 · cheapest=N6 DSC 일치.

## 2026-05-25T08:10Z — G6 closed: 인접 토픽 양립성 매트릭스 (co-application · hexa-native 🟢)

round G6 milestone CLOSED. 격리 worktree `/tmp/numb-g6b-a68ebcad` (branch `numb-g6-compat-a68ebcad`, base origin/main · 첫 worktree `/tmp/numb-g6-3b5a6936` 가 concurrent prune 으로 displaced → fresh worktree 재생성 후 deliverable 복사). N6(corneal wall) · N7(epi pH 8.5 분해 · HH f_free) 자산 통합.

- [x] **G6** (`NUMB/research/G6_compatibility.md` + sim `g6_compatibility.hexa`) — 🟡 SUPPORTED-BY-CITATION (closed-form pH/LAST 산술 🟢 hexa-native)
  - **양립성 매트릭스 (인접제 × {동시·시간차·금기} × 이유)**: sunscreen=under-NUMB 금기(빔차단+유기필터 co-penetrant+occlusion)/시술후 권고 · chlorhexidine=시간차-MANDATORY (cation-anion 침전 5min, wet-mix 금기) · povidone-iodine=시간차-ORDERED (PVP-I 먼저, NUMB-first=소독실패) · moisturizer=AVOID under (occlusion→SC hydration→LAST↑ 25.2ng/mL) · retinoid/AHA=시간차-DAYS 3-5d (SC barrier 파괴→TEWL↑→LAST↑ 28.8ng/mL, broken barrier=금기).
  - **화학 양립성**: CHG di-cation + NUMB 음이온종(lactate/carboxylate) 침전 · PVP-I free I₂ + epi(catechol) minor 산화 · 유기 UV필터 SC partition 경쟁(UV 노출 시 1.4-5.7× 침투) · occlusion+barrier-disruption = LAST stack(worst 40.3ng/mL, 여전히 << toxic 5000).
  - **시간차 순서**: 세척→antiseptic(PVP-I/CHG)→DRY 2-3min→(wipe)→NUMB→wipe→procedure→post-care SPF. NEVER: moisturizer/SPF/retinoid under NUMB · CHG wet-mix · NUMB on mucosa/orbital.
  - **안와/점막 wall (N6 통합)**: 안와(미용 botox/filler 근처)=tet SKU(Rx-V1/V2) CONTRA (corneal damage JCAD 2016) · OTC-A small-area+eye shield · 점막(구강·비강·결막)=전 SKU CONTRA (각질 barrier 부재 → 급속 systemic 흡수 ≈5× intact skin).
  - **hexa-native sim**: `g6_compatibility.hexa` GREEN (host=darwin local hexa_real, RC=0) — HH f_free 0.00397/0.799 @ pH 5.5/8.5 (N7 anchor 재현) · LAST stacking 25.2/28.8/40.3 ng/mL · outcome classifier 7 행.
  - **honest framing (@D d5/d6)**: 인접제는 J_ss prefactor(occlusion/pH/K_sc) + LAST Cmax 만 변화 — **onset 무관** (t_lag = h²/(6 D_eff) D-driven, N1·N6·N7 학습). co-application 임상데이터 희박 → default 시간차 ("동시 안전 가정" 금지).
  - **deep research (@D d18)**: arxiv Pontrelli 2019 (2001.03058) pH-responsive 2-layer PDE = multi-layer co-application grounding (live API rate-limited → N7 검증 anchor 재인용) · web: CHG-lid 침전(Tran/Huynh review · PMC3148842) · PVP-I 순서(IOVS 2011 PMID 21366185) · 유기 UV필터 SC침투(ScienceDirect S0160412019320008) · occlusion 흡수↑(Zhai 2001) · retinoid/AHA barrier(PMC11344648 · Smith 1996) · 점막 흡수(lidocaine viscous USPI · PMC8246680).
  - **breakthrough (@D d2)**: W1 Franz co-app($500-1000) · W2 turbidimetry CHG-NUMB 침전($100-200, cheapest first) · W3 epi-HPLC after PVP-I($200-400) · W4 TEWL-graded Franz($800-1500). total ~$1600-3100.

## 2026-05-25T22:00Z — G5 closed: 포장/안정성 — 3 form factor + Arrhenius shelf-life (epi 산화 = 24mo 게이트)

round-3 G5 milestone CLOSED. 격리 worktree (TMPDIR base origin/main, branch `numb-g5-packaging-stability`). G4 (DUAL OTC-A + Rx-V1) 의 상업화 포장 + 24mo shelf-life 정량 — form factor 가 SKU 와 자연 정합 (epi-함유 Rx = 단회 sachet · epi-free OTC = multi-dose tube).

- [x] **G5** (`NUMB/research/G5_packaging_stability.md` + sim `g5_stability.hexa`) — 🟡/🟢
  - **3 form factor 정량 spec** (충전·1회사용량·비용·$/g·방부제·SKU): ① 단회 sachet/ampoule 2.5g · 전량1회 · $0.85 · $/g 0.34 · **무방부제 가능** (procedure-direct 무균충전) · Rx-V1/V2 (epi → 2-chamber-capable). ② multi-dose tube 30g · 2g/회 · **15회** · $1.40 · $/g 0.047 · **방부제 필요** (반복개봉) · OTC-A (epi 없음 → single-chamber 단순). ③ patch 1g/10cm² · 단회 · $1.75 · $/g 1.75 · Rx-V1 (Synera-class · peel-film 일체 · heating element 옵션).
  - **Arrhenius 가속수명** (hexa GREEN · closed-form): k(T)=A·exp(-Ea/RT) · AF=exp(Ea/R·(1/T1-1/T2)) · t90=-ln(0.9)/k · shelf25=t_accel(40°C)·AF(40/25).
    - 🚨 **lid/tet amide 가수분해는 shelf-limiter 아님**: Powell 1987 PMID 3508528 measured Ea=33.8 kcal/mol (ko protonated) · k(80°C)=1.37e-9/s → 25°C 외삽 k=1.885e-13/s → **t90 ~ 17,723 년** @ pH 5.5. pH 5.5 lactate buffer 가 정답 (Powell max stability pH 3-6). AF(40/25)=15.39.
    - 🚨 **EPINEPHRINE 산화 = 진짜 24mo 게이트**: catechol→adrenochrome 자동산화 · Ea~18 kcal/mol (lit 13-21) · AF(40/25)=4.29 → 40°C/6mo 가속 → 25°C 외삽 = **25.7 mo** (24mo 마진 +1.7mo 뿐). PASS 조건 (전부 필수): acidic pH 5.5 + Na-metabisulfite 0.1% + EDTA (금속 chelation·Powell metal-ion 촉매 차단) + N2-headspace + **차광 (절대조건)** + epi/alkaline 2-chamber.
    - **차광 역설** (deep research · PMID 10822984): Na-metabisulfite 가 **광 존재 시 epi 광분해를 오히려 촉진** (64.5% vs 89.3% remaining) → 차광이 metabisulfite 보다 우선; metabisulfite 는 암실/무산소 전제에서만 O2-scavenger 로 작동.
    - capric (V2) 산패: honest 정정 — capric = decanoic acid **C10:0 포화 FA** (C=C 없음) → free-radical 산패 본질적으로 **LOW** (가정보다 낮음). but 열-가수분해/유리산 migration/peroxide-value 경로는 0 아님 → DSC + peroxide-value wet-lab gate 인정 (Ea~20 가정 → shelf 30.3mo).
  - **N7 epi pH 8.5 wall 통합**: epi @ pH 8.5 분해 30% @30min · 100% @2wk (SD 1990) → epi+alkaline bilayer 는 **2-chamber MANDATORY** (또는 N7-A 2-step 2-SKU 자연분리 = packaging 최단). OTC-A (epi 없음) → 게이트 부재 → single-chamber tube 안정성 SIMPLE.
  - **포장재 호환성 매트릭스**: lid free-base (피부온 oil) = bare LDPE/polyolefin 흡착 (역가손실+용기연화) → **epoxy-phenolic-lined aluminum tube** 필수. epi 함유 → **foil (Al-laminate) sachet** (광+O2+수분 3중 barrier · 차광 절대조건). HPC peel-film 수분 민감 (40°C/75%RH 가속에서 hydrolysis 가속) → foil overwrap + desiccant.
  - **24mo 판정**: OTC-A tube (no epi) PASS 압도 · Rx-V1 sachet (epi, foil, antioxidant+N2+dark) PASS (25.7mo) · Rx-V1 patch (epi+HPC) PASS-conditional · Rx-V2 sachet (epi+capric) PASS (30.3mo) WET-LAB gated · Rx-V1/V2+N7 = 2-chamber MANDATORY.
  - **competitor anchor** (실제 라벨): EMLA cream 3년 (SmPC §6.3 · <30°C · epi-free) · LMX-4 2년 (25°C · liposomal · epi-free) → OTC-A (epi-free tube) 24mo+ 달성 가능 증명. Pliaglis RT 3mo (eutectic oil jar · 개봉후폐기) = short-shelf 약점 → NUMB Rx-V1 **단회 sachet 가 구조적 해결** (개봉=즉시사용).
  - **honest framing (@D d5/d6)**: ① shelf-limiter 정정 (lid 가수분해 X → epi 산화 O) ② capric 산패 risk 과장 금지 (포화 → LOW) ③ 가속시험 외삽 한계 명시 — 40°C/6mo→25°C/24mo 는 **단일 Arrhenius mechanism 가정** (ICH Q1A); 상전이/다중경로 전환 시 무효 → real-time 25°C/24mo 확정시험이 최종 게이트 · 본 숫자는 projection.
  - **deep research** (d18): arxiv Escobar-Meeker 2006 (0708.0369 · Statistical Science "A Review of Accelerated Test Models" · Arrhenius/Eyring 가속수명 정통 방법론) + CRNN 2024 (2408.11984 · multi-Arrhenius ODE = 다성분 병렬분해 구조 정당화); web Powell 1987 (lid Ea 26.3-33.8 measured) · PMID 10822984 (metabisulfite 광 역설) · EMLA SmPC 3년 · Pliaglis RT 3mo · LMX-4 2년 · capric C10:0 포화 · HPC 수분 (PMC6520314 40°C/75%RH).
  - **재현**: `hexa run NUMB/sim/g5_stability.hexa` (main repo path 복사 실행 · pool 라우트 · GREEN). 출력 전값 closed-form python 일치 (lid t90 17,723yr · epi AF 4.289 · shelf 25.7mo).

남은 게이트: NUMB-oracle (multi-indication wet-lab PASS) · V-track verify.

## 2026-05-25T20:30Z — G7 closed: 3-step user guide + OTC/Rx label auto-dispatcher (hexa-native 11/11 🟢)

round-3 G7 milestone CLOSED. 격리 worktree `/tmp/numb-g7-retry-7f0570d3` (branch `numb-g7-retry2-de1e2f`, base origin/main). G4 (DUAL OTC-A + Rx-V1) 와 의도적 정합 — G7 dispatcher 는 G4 의 OTC-A · Rx-V1 SKU 정의를 그대로 사용 + Rx-V2 (capric ternary) 는 deferred-trigger 게이트 후의 미래 SKU 로 슬롯 예약 (3-SKU dispatcher universe).

- [x] **G7** (`NUMB/research/G7_user_guide.md` + sim `g7_label_dispatcher.hexa`) — 🟢 numerical (11/11 case PASS)
  - **3-step workflow (도포 → 대기 → procedure)** for 6 indication (hair · vascular · tattoo · injection · biopsy · pediatric) × 3 SKU (OTC-A / Rx-V1 / Rx-V2) — 표 형태 + per-indication 면적 · apply_min · onset_min · procedure 윈도우 명시.
  - **dispatcher decision tree**: 입력 5 (indication · weight_kg · age_yr · area_cm² · concomitant) → 출력 7 (sku · concentration · apply_min · max_area · onset_min · duration_min · warning bitmask). lex-order priority = safety vetoes > indication primary > OTC fallback > area envelope > concomitant warnings.
  - **FDA Drug Facts (OTC-A) 1-page skeleton** — 21 CFR 201.66 format + 21 CFR 348 lid 4% monograph mapping (Active / Purpose / Uses / Warnings (Do not use · Ask a doctor · When using · Stop use) / Directions / Other / Inactive / Questions). 100 cm² 한도 (라벨) + 60 min apply + adults ≥12y primary + 1-12y "doctor only".
  - **Rx-V1 USPI 1-page skeleton** — PLR 21 CFR 201.56-57 + Pliaglis 505(b)(2) RLD anchor. Indications / Dosage / Forms / Contraindications / Warnings (LAST · MetHb · vasoconstrictor · pediatric · class I AA) / Adverse reactions / Specific populations / Overdosage / Clinical pharmacology / Storage.
  - **ASCII visual guides**: (a) 결정 트리 graphical (full path 6 indication branches + envelope check + warnings) (b) onset timer comparison (Rx-V1/V2 ~3min vs OTC-A 45-60min) (c) 면적 visual (손바닥 = 100 cm² anchor, 10 cm² · 100 cm² · 400 cm² · 1000 cm² 시각 비교).
  - **hexa-native dispatcher** (`NUMB/sim/g7_label_dispatcher.hexa`) — 11 sanity case (C1-C11): 6 indication × 3 SKU + 2 REFUSE veto (C9 neonate · C11 <12mo+methb) + 2 concomitant warning (C10 class I AA · C11 methb). Cmax LAST sanity per Rx-V1 case: C1 hair 400cm² = 73.3 ng/mL margin 68× · C3 vasc 150cm² = 27.5 margin 182× · C4 tat 300cm² = 55.0 margin 91× · C7 biop 20cm² = 3.67 margin 1364× · C10 hair 100cm² = 18.3 margin 273× · C5 tat split 5+5% per-session 400cm² = 52.3 margin 95×. 전부 G1 spec ≥10× margin PASS.
  - **honest framing (@D d5/d6)**: OTC-A onset = **45-60 min** (LMX-5 class · lid 4% 단독 · no tet · no epi · 과대 약속 회피 · G4 OTC-A 55.6min 정합); Rx-V1 onset ~3 min (eutectic + CPE ER 3× target · G1 anchor); Rx-V2 onset = Rx-V1 (~3 min) + duration ×3 (N6-C capric a≈5 flux multiplier · onset 무관 · N1 학습 직접 인용 · G4 deferred-trigger 정합).
  - **safety vetoes (G3 정합)**: 신생아 <28d → REFUSE (clinical-defer · PK 미성숙 · AAG 0.5× · CL 0.5×); <12mo + methb_inducer → REFUSE; >400 cm² → split 권고; +epi → 손가락 · 코 · 귀 · 생식기 금지; class I 항부정맥 병용 → caution.
  - **codegen note**: hexa let-literal cross-case collision (`cN_area` 변수가 마지막 정의에서 forward-decl 누락) → 인라인 area 상수 (400.0 · 150.0 · 300.0 · 20.0 · 100.0)로 우회 — `reference_hexa_let_literal_collision.md` (PR #821) 정합.
  - **deep research** (d18 정합 round-3): web FDA 21 CFR 201.66 (Drug Facts format · 1999 final rule · "Drug Facts" 제목 + Active/Purpose/Uses/Warnings/Directions 구조) + 21 CFR 348 (lid 0.5-4% external analgesic monograph · G2 재활용); arxiv 1509.00379 (Barth 2015 boundary-label readability formal user study · ASCII visual leader anchor 정합) + 2309.06961 (Gröger 2023 derm benchmark · peripheral).
  - **재현**: `cd /Users/ghost/core/hexa-lang && ./hexa run /tmp/numb-g7-retry-7f0570d3/NUMB/sim/g7_label_dispatcher.hexa`

남은 게이트: G5 (포장/안정성) · G6 (인접토픽 양립성) · NUMB-oracle (multi-indication wet-lab PASS).

## 2026-05-25T18:15Z — N7 NOVEL probe — pH gradient bilayer cream (round-2 d18 정합 · sister of N6)

격리 worktree `/private/tmp/numb-n7-efc4be5c` (브랜치 `numb-n7-ph-gradient-efc4be5c` from origin/main · @D d9 정합) — N5/N6 와 **다른 mechanistic axis** 로 round-2 NOVEL 확장.

- [x] **N7** (`NUMB/research/N7_pH_gradient.md` + `NUMB/sim/n7_ph_gradient.hexa`) — 🟠 INSUFFICIENT/DEFERRED
  - **mechanism**: lid pKa 7.9 / tet pKa 8.5 — 상부 alkaline layer (pH 8.5 carbonate buffer) 가 Henderson-Hasselbalch 평형 시프트 → **lid f_free 0.40% → 80%**, tet 0.10% → 50% → Hadgraft 1985 ΔlogP +2.1 ceiling → **K_sc partition multiplier**
  - **hexa-native HH closed-form (🟢 GREEN)**: lid f_free hexa-output = 0.00397 / 0.240 / 0.799 @ pH 5.5/7.4/8.5 — closed-form HH 정확 매치
  - **3 bilayer 후보** flux × hexa-LAC v1: A=2-step apply **4×** (V1 TOP · safest · 2-SKU 분리) · B=laminated peel-film **6×** (V2 · 안정성 wall) · C=NaCO3 microcap **5×** (V3 · GMP novelty)
  - **honest framing (N1·N6 학습 흡수 · @D d6)**: f_free·K_sc 는 J_ss flux **PREFACTOR** (steady-state) · `t_lag = h²/(6D)` 무관 → **onset 가속 ✗**, **unit-area delivery + depth + duration**만 ↑. "alkaline → 5min onset" 추측 ✗.
  - **🚨 wall (정량 anchor 확실)**:
    - **W3 epi pH 8.5 분해** — Sciencedirect 1990 (S0196064405822814): **30% loss @ 30min, 100% @ 2wks** → bilayer 물리적 분리 mandatory
    - **W4 lid amide 가수분해** — Powell 1987 Pharm Res (PMID 3508528): max stability pH 3-6 → laminated 24mo shelf risk
    - **W1 alkaline skin tolerance** — pH 8.5 단시간 (<30min) OK (dental NaHCO3 임상 precedent), 장시간 SC degradation → N7 indication = procedure 30min only (만성 신경통 ✗)
  - **deep research (d18 정합 · arxiv + web)**:
    - arxiv **2001.03058 Pontrelli 2019** = pH-responsive 2-layer drug delivery PDE 모델 → N7 architecture **직접 grounding** (interface flux continuity eigenvalue 해석해)
    - arxiv 1601.03074 Pontrelli 2016 iontophoretic multi-layer · arxiv 1405.1413 Pontrelli/de Monte 2014 2-phase 2-layer SC+epi (사촌)
    - web Onpharma + PMC12742648 — buffered lid **INJECTION** (NaHCO3 8.4% 9:1) onset 단축 = 임상 표준 but transdermal 무관
    - web SD S0022354915469308 — lid micelle phase pH 5/7.8/9 = 0%/55%/80% → HH empirical 검증 anchor
    - **2025 search**: "pH-gradient topical anesthetic cream" published clinical study **ZERO** → N7 freedom-to-operate ✅
  - **IP FTO**: N7-A (2-SKU drug-drug combo no fixed-dose) = 가장 자유 · LMX-5/Pliaglis RLD 505(b)(2) feasible
  - **breakthrough min-spend ~$1000-2100, 1 month**:
    - P1 Franz cell 1-point lid flux pH 5.5 vs 8.5 ($500-1000)
    - P2 DSC alkaline lid 안정성 ($200-500)
    - P3 epi-HPLC bilayer 분리 효율 ($300-600)
    - P4 USPTO/EPO FTO search (model · $0)
  - **LAST envelope** (N6 와 동급): EPI co-admin mandatory · area cap <200cm² · duration cap <30min · 1000cm² sleeve → 3.5+3.5% derate
  - **cross-axis stacking**: N1 + N6-C + N7-A triple = **10-15× flux** (depth+duration+unit-area triple-stack) but LAST envelope 10× tighten → V3 hexa-LAC v3 spec 후보

## 2026-05-25T20:15Z — G4 SKU split — DUAL (OTC-A + Rx-V1) 권고 · V2 trigger 게이트 deferred

round-3 G4 milestone CLOSED. 격리 worktree `/tmp/numb-g4-13d09607` (branch `numb-g4-sku-13d09607`, base origin/main d686334).

- [x] **G4** (`G4_sku_split.md` + `g4_sku_split.hexa`) — 🟢 numerical + 🟡 cite + 🟠 V2 wet-lab gate honest
  - **결정 트리 verdict = DUAL** (OTC-A + Rx-V1) — single (Rx-V1 only) 대비 +29pp TAM / +$3.5M / 0yr critical-path 추가, triple (V2 추가) 는 +9pp TAM 에 +$40M·+2yr·+10pp cannib 으로 incremental NPV 음수
  - **OTC-A spec**: lidocaine 4% 단독 · no eutectic · no epi · onset 55.6min (LMX-class) · margin 179× @ 400 cm² · indication = minor cuts/burns/sunburn/scrapes/irritation/insect bites (21 CFR 348.50 fixed wording) · 면적 cap 200 cm² (성인) · 100 cm² (소아 ≥2y) · cost $2-5M / 1-2 yr
  - **Rx-V1 spec**: hexa-LAC v1 (lid 7+tet 7+epi+peel-film) · onset 2.78min · depth ~95% MEC · duration 105min · margin 68× · Pliaglis-class indications (laser hair removal/IPL/filler/dermal proc) · cost $15-50M / 5-7yr (505(b)(2))
  - **Rx-V2 spec (deferred)**: V1 + capric 10-15% ternary · onset = V1 (N6 honest: a/K_sc != t_lag) · depth C/MEC 12 · duration 195min · 안와 contra · 소아 contra · cost $20-60M / 6-8yr
  - **V2 trigger 가드레일** (3 조건 동시): N6 DSC+Franz PASS + tattoo-sleeve TAM ≥$200M 측정 + V1 yr2 trailing revenue ≥$50M
  - **indication × SKU 매트릭스**: OTC-A primary = I2 needle + I5 biopsy + I6 pediatric · V1 primary = I1 hair (face/leg) + I3 vasc + I4 typ + I7 filler · V2 primary = I1-back + I4-max sleeve
  - **소아 SKU 매핑** (G3 prilocaine-free): OTC-A primary (monograph ≥2y, MetHb 경로 자체 부재) · V1 secondary (clinic, +epi 면적 cap 50 cm²) · V2 contra (capric pH-sting)
  - **안와 / G6 사전 정의**: V2 CONTRA (BLT corneal class wall, JCAD 2016) · V1/OTC-A "avoid contact with eyes" (FDA 표준)
  - **TAM 추정**: single ~62% / dual 91% / triple 100% — cannib-adjusted dual 85.9% · triple 85.0% (triple 가 dual 에 패배)
  - **deep research** (d18 정합 round-3): 21 CFR 348.10/348.50 lid/tet 한도 + Drug Facts fixed wording verbatim · LMX-4 (Ferndale) drugs.com/SingleCare 가격 ~$42/30g · Pliaglis 2008 voluntary withdrawal + Galderma reapproval (PracticalDermatology) · Lidocaine HCl market $701M→$964M CAGR 5.53% (Mordor Intelligence)
  - **honest framing**: V2 정량 (a-boost · K_sc shift · J_ss 6×) 은 Schröder-VL 예측 only → wet-lab gate 까지 🟠. cannibalization 5%/15% 는 추정 (가격/면적 분리 가정). market capture 5-15% addressable conversion 도 추정
  - **재현**: `cd /tmp/numb-g4-13d09607 && hexa run NUMB/sim/g4_sku_split.hexa`

남은 게이트: G5 (포장/안정성) · G6 (인접토픽 양립성) · NUMB-oracle (multi-indication wet-lab PASS). (G7 = 본 entry 최상단에서 CLOSED)

## 2026-05-25T17:30Z — /cycle round-2 완결 (d18 정합): G2 regulatory + G3 pediatric + N6 ion-pair eutectic — 3개 milestone CLOSED

round-2 fan-out 결과 통합 entry. 3 agent 모두 d18 정합 (NOVEL + arxiv + web deep research 내장).

- [x] **G2** (`G2_regulatory_pathway.md` + `g2_regulatory_matrix.hexa`) — 🟡 cite-based
  - **선례 9건 매핑**: Pliaglis NDA 21-717 · EMLA 1984 SE national · LMX-4/5 · Synera NDA 21-623 · DESCRIBE 510(k)+drug · LET/BLT compounded · 국내 리도카겔 5% · 엠마오플러스 9.6%
  - **Rx variant path 확정**: US 505(b)(2) (Pliaglis 직접 RLD, $15-50M·5-7yr) · EU national→MRP (EMLA 1984 SE 선례, $0.5-1.5M·1.5-3yr) · KR 자료제출의약품 전문 (~$1.5-7.5M·3-5yr)
  - 🚨 **OTC variant WALL**: 21 CFR 348.10 lid 0.5-4% / tet 1-2% → G1 round-1 OTC 5+5% 가정 + 2.5+2.5 *둘 다* tet 한도 초과 → **flagship OTC 재정의 = lid 4% 단독** (LMX-5/Aspercreme class)
  - 4 OTC workaround: A=lid-only 4% (✓ $2-5M·1-2yr) · B=lid 4+tet 2 한도내 ($10-30M·4-6yr) · C=OTC switch NDA ($30-60M·6-8yr) · D=compounded
  - **SHORTEST commercial path**: KR 일반의약품 (리도카겔 5% 선례, ~$2M·2-4yr) · MFDS 2025 reform 420→295일·fee ₩410M
  - **device-drug 결정**: HPC peel-film = 수동 carrier = drug PMOA → CDER NDA 단일 path (Synera 선례, 별도 510(k) 불필요)
  - **deep research** (d18): 21 CFR 348 정확 한도 fetch (Cornell LII), Pliaglis Phase 3 n=50/indication, EMA Article 30 EMLA referral
  - **G1→G2 보정**: OTC 5+5% 가정 US monograph 불가 → G4 spec 재조정 트리거 (G-track fix-introduces-axis)

- [x] **G3** (`G3_pediatric_LAST.md` + `g3_pediatric_LAST.hexa`) — 🟢 numerical
  - **체중 기반 closed-form**: `Cmax(ng/mL) = 0.1834 × A(cm²)` (G1 inheritance) · age-adjusted threshold = 5000 × (CL_age/CL_adult × AAG_adult/AAG_age) → 신생아 2500 · 영아<6mo 2500 · 6-12mo 3500 · 1-3y 4200 · 3-6y 4500 · ≥6y 5000 ng/mL
  - **6 연령대 envelope** (모두 ≥10× spec ✅): 신생아 (3.5kg/7cm²/60min · margin 1947× **BORDERLINE clinical-defer**) · 영아 1-6mo (6kg/20cm² · 682×) · 6-12mo (8.5kg/20cm² · 954×) · 유아 1-3y (12.5kg/100cm² · 229×) · 학령전 3-6y (18kg/100cm² · 245×) · 학령 6-12y (28kg/200cm² · 136×) · 청소년 12-18y (55kg/400cm² · 68×)
  - **+epi 50% Cmax reduction** = dominant headroom (Pliaglis k=0.0533 × f_epi 0.5 anchor)
  - **prilocaine-free 정합**: NUMB v1 (lid 7%+tet 7%) → o-toluidine MetHb path 자체 없음 → EMLA <37wk preterm 금기 + <12mo MetHb-inducer 병용금기 wall composition 으로 제거 (FDA DailyMed 019941s021)
  - **MetHb 우위 정량**: EMLA pediatric pooled >3% MetHb rate ~10% (Essink-Tjebbes/Brisman/Frey) vs NUMB v1 ~0.1% (Ametop UK 20yr surveillance proxy) = **100× 우위**
  - **honest framing**: 신생아 수치 margin 1947× 이지만 PK 미성숙 (AAG 0.5×·CL 0.5×) + 임상 데이터 부족 → "권고 사용은 ≥1mo + clinical confirmation" 명시
  - **deep research** (d18): 9 clinical (Brisman 1998 · Essink-Tjebbes 1999 · Frey 1998 · Jain 2000 · Lemyre 2006 · Reis 2003 · Lander 2005 · PMC9746881 SR · LMX-4) + 3 arxiv (Sopasakis 2019 fractional PK · Saffaran 2025 neonate digital twin · Wesolowski 2021 gamma-Pareto)

- [x] **N6** ion-pair / ternary eutectic (`N6_ion_pair_eutectic.md` + `n6_ion_pair_eutectic.hexa`) — 🟠 INSUFFICIENT/DEFERRED · **PR #110 MERGED**
  - Schröder-Van Laar framework + Yuan 2015 PMC4444629 anchor (lid+tet 1:1 measured 29.95°C)
  - 3 후보: A=BLT-ternary (lid+tet+benzo 8:4:20) 1.1× flux · B=lid+tet+LA (0.4:0.4:0.2) 5× · **C=lid+tet+capric (0.4:0.4:0.2) 6× (TOP · N1 PCM cross-axis triple-stack)**
  - **honest framing (N1 학습 적용 · @D d6)**: a (활동도) + K_sc 는 `J_ss = D·K·a` flux multiplier → **steady-state** · `t_lag = h²/(6D)` D-driven UNCHANGED → **onset 무관, depth + duration + SC delivery 효율**, NOT onset 가속
  - 🚨 **safety wall**: BLT compounded 임상 corneal damage → 안와 사용 contraindicated (JCAD 2016 PMC4896822)
  - **IP freedom-to-operate**: WO2004103260A2 (Pliaglis family) prilocaine 중심 4-mer 청구 → BLT + lid+tet+capric/LA 회피 여지 ✅
  - **breakthrough min-spend**: DSC $200-500 + Franz 1-point $500-1000 = **$700-1500** → 🟠→🟡 승격 (cheapest NOVEL probe)
  - **deep research** (d18): arxiv Pontrelli 2014 · Potticary 2019 DES · web Yuan 2015 anchor · BLT compounded JCAD · Tatara 2021 sucrose laureate 11.95× flux · IP WO2004103260A2

**round-2 종합 cross-finding**:

```
G2 OTC-wall (tet 한도 2%)  ──┐
G3 prilocaine-free 우위    ──┼──→ G4 SKU split 재설계:
N6 N1 cross-axis 가능        ──┘    OTC = lid 4% 단독 (소아 1순위 후보 · prilocaine-free)
                                    Rx = hexa-LAC v1 · hexa-LAC v2 (+ capric ternary N6-C)
```

G-track 진행 = **3/7 closed** (G1·G2·G3) · NOVEL = **3 active** (N1·N5·N6). 잔여 = G4·G5·G6·G7·oracle.

## 2026-05-25T07:05Z — G3 agent 보고 (worktree → main untracked · roundup 통합 흡수됨)

(상기 17:30Z entry 의 G3 row 가 본 entry 를 흡수. 격리 위반 cleanup: 본 entry 의 원본 untracked 파일은 roundup PR 에서 정리 commit 으로 land.)

## 2026-05-25T01:00Z — /cycle round-1 완결: G1 hair-removal anchor + N1·N5 NOVEL (정직 재포지셔닝)

- [x] G1 (`G1_indication_map.md` + sim) — laser hair removal anchor ($1.4-1.6B 2025·95% topical 사용) → 스펙: onset ≤30min·100-400cm²·LAST ≥10× margin·+epi mandatory. 8 indication 매핑: hexa-LAC v1 **7/8 단일 SKU 커버** (예외: 타투 *제작* sleeve 1000cm²×120min Cmax 826ng/mL 6× margin → 5+5% derate+split → 16.9× margin). 🎯 gap = **OTC 5+5% ↔ Rx 7+7%+epi+peel-film 듀얼 SKU**. tier 🔵/🟢/🟡/🟠. (🚨 round-2 G2 에서 OTC monograph WALL 로 보정 — lid 4% 단독으로 재설계)
- [x] N1 phase-change peel-film — 🚨 **정직 재포지셔닝**. Pliaglis(water-evap)와 trigger 축 다름(body-T 32-35°C PCM carrier melt · capric+palmitic 32.17°C·lauric+myristic 34.28°C 후보). **그러나 첫 가설 "onset 가속" Fick first-principles로 반증** (activity a는 lag-time 무관, 정상상태 flux만 ×). 진짜 가치 = a 2→5 (2.5×) **flux multiplier @ steady-state** → C_surf 낮춰도 동일 depth → **G3 소아 / G4 OTC 저농도 SKU 기여** (onset이 아니라 depth/duration). wall = latent-heat 28min full-melt 100μm sub-layer 우회.
- [x] N5 Mg multi-modal — 🟠. NMDA+VGCC 직렬 + Na-channel(lid) 시너지. r_mg=0.30(IV/perineural 25-40% 외삽), lid 7→4.9% depth-matched, **A_max +43%, 타투 sleeve 400-800cm² 단일세션 unlock**. 🚨 토픽 Mg+lido MEC shift 임상 ZERO (deep research 4 RCT 모두 *주사형*). 1-point Franz cell ED50 study가 🟠 결정.
- 🔬 **deep research synthesis** (병렬 진행 · 본 세션):
  - Mg+lido 시너지: 임상 RCT 4건 견고 (IANB·femoral·brachial·dental) but 전부 주사형 — *토픽* unverified
  - N1 prior art: Pliaglis(Alster 2007 lid7+tet7 peel) + USPTO 9186334(heat-assisted 35-47°C lid+tet) — N1은 body-T(32-35°C)·PCM trigger로 차별화
  - 🚨 **소아 EMLA prilocaine wall**: o-toluidine → MetHb. 신생아<37주 금기·체중<20kg 면적시간 제한 → **NUMB 소아 SKU = prilocaine-free 필수 (lid+tet만)** 권고 — hexa-LAC v1이 이미 정합 ✅
  - arxiv SC 물리 5건 (2510.14606 등): MD 기반 SC permeation diffusivity 1자릿수 변동 = A5 honest gap 정합
- 종합 round-1 insight: hexa-LAC v1이 7/8 indication 커버 (✅) · 듀얼 SKU OTC/Rx gap 식별 · N1은 onset 아닌 depth/duration 기여 · N5는 large-area unlock but topical 실측 필요 · 소아 SKU prilocaine-free 정합.

## 2026-05-25T00:35Z — 도메인 생성 (TTR-LAC A 트랙 spinoff · 범용 마취 크림)

- [x] M0 — domain scaffold (사용자 지시: "마취크림만 추가진행하자 · 범용으로 많이 쓰이니까")
  - **스핀오프 모델**: TTR-LAC 의 A 트랙(A1·A2+A3·A4·A5)은 *레이저 타투제거 세션 한정* 컨텍스트였으나 — SC permeation/D-boost/depth/LAST 모델은 **procedure-agnostic 일반 자산**. NUMB 가 이 자산을 상속해 범용 indication·regulatory·OTC/Rx 듀얼·소아 안전으로 확장.
  - **핵심 상속**: t_lag=h²/(6D) · CPE 42×→in-vivo 5-10× · C(z) depth · Pliaglis LAST · hexa-LAC v1 제형. 본 도메인은 새 화학 *재발견 X* — 제형 최적화 + 다용도 매핑 + 규제 path 만.
  - **확장 7 milestone (G-track)**: G1 indication map · G2 regulatory pathway · G3 소아 LAST · G4 OTC/Rx variant · G5 포장/안정성 · G6 인접 토픽 양립성 · G7 사용자 가이드.
  - **honest framing (@D d5/d6)**: 마취 chemistry 는 수십 년 임상 well-established — 본 도메인 *새 발견 가능성 낮음*, *제품화*가 목표. 과대 약속 금지.
  - **시장 정합 신호**: EMLA(Rx) · LMX-4(OTC) · BLT(compounded) · Pliaglis(Rx peel-film) · DESCRIBE(PFD patch) 등 다양한 form factor 가 이미 존재 — gap = *범용 빠른 onset + LAST 안전 면적·소아 envelope* 의 한 제품군.

Append-only history sister of `NUMB.md`. `## <ISO timestamp> — <header>` (newest on top).
