# TTR-ORAL — current state

> 🦠 **TTR-ORAL** — "면역세포 택배" · device-free 경구 macrophage-migration tattoo fade (per @D d10)

@goal: **순수 경구 (먹기만 · 기구 0 · no needles · no rub-on · no laser) 로 타투 fade — track B (macrophage 이주 가속) 단독 돌파.** 핵심 wall 3종 = (W1) 잉크 *파괴* 아닌 림프 재배치 (fade ≠ erase) · (W2) 속도 (자연 ~7yr) · (W3) 전신 면역조절 therapeutic window. 3종 모두 @D d2 breakthrough path 로 driven · measured-oracle PASS 까지 absorbed=false

> **parent**: `TTR.md` (공유 base inventory)
> **track**: oral / ingestible · **device-free 확정** (전신 경로 · 진피를 혈류로 도달)
> **pivot (2026-05-24)**: 사용자 결정 — 기구 필요한 A (pro-drug + 외부 레이저/초음파 활성화) 는 device-free @goal 과 불일치 → **hybrid 서브트랙으로 분리** (`path_A_prodrug_activation.md` 보존 · 레이저 보조 강화판 참고용). **B 가 유일 device-free lead.** C/D (lymphatic·NP) 는 약함 (보조 toolbox).
> **honest framing (@D d5/d6)**: B 는 잉크를 *부수지 않고* 면역세포가 림프절로 *옮겨* skin 에서 옅게 만드는 fade. 완전 erase 아님 — cosmetic endpoint("skin 비가시")로 정의 시 제품화 가능. "된다"를 압력으로 강제하지 않음.
> **🚨 grounding revision (cycle-1 · 2026-05-24)**: 실측 grounding 으로 두 가정 붕괴 — (1) per-pulse φ 중앙 0.05(가정 0.15는 천장) · (2) **S1P/B2 lever 역부호 폐기** (egress 억제제). 수정 2-lever(k_death CSF1R펄스+r↓ 재포획차단) → **device-free 단독 = ~2-6년 (sub-year 도달불가)**. lead lever S1P→**r↓**. M4/M7(S1P 기반) **개정 필요**. 상세 `cycle1_grounding_reconcile.md`.
> **🔒 scope 확정 (TTR-ORAL 기준 · 2026-05-24)**: TTR-ORAL = **device-free 경구만**. 레이저-병용(BP1d)·prodrug+외부활성(A) = device 필요 → **out-of-scope (별도 트랙 · fallback 아님)**. 벤치마크 "승자"·near-term 도 device-free 안에서만 판정. (전역 governance 아닌 *이 도메인의 기준*.)
> **🏁 CLOSURE (in-silico fixpoint · 2026-05-24)**: /gap=fixpoint 판정 후 마지막 orthogonal probe(N5 광학마스킹·N9 햇빛게이팅) 둘 다 NO-GO. **device-free 경구 ≥90% = 비-wet-lab 탐색 고갈** (공통 천장 = carbon 25% 비분해 + ADME ~1e-4). → **wet-lab 핸드오프**: #1 실험 = 실제 잉크 carbon분율/분해성(feasibility binary) · #2 φ(속도). best 잔존개념 = N1⊗N2(🟠). absorbed=false · 🔴 0(도메인 falsified 아님 · 개별 가정만). 재개 시 cleanup = PK 공유모듈+PARAMETERS SSOT(/gap F6).

## why permanence (M1-ORAL base) — 왜 타투는 안 빠지나

잉크 입자 (40-300 nm 응집체) → 진피 (500-2000 μm) 주입 → 진피 macrophage 가 탐식 → **capture–release–recapture 사이클** (Baranska 2018): 잉크 든 macrophage 가 죽으면 색소 방출 → 즉시 이웃/신규 macrophage 가 재포획 → 제자리 고정 → 영구성. 일부는 국소 림프절로 배출 (타투 림프절 착색 = 자연 fade 경로).

## Milestones (progress)

- [x] M1-ORAL — 잉크 영구성 + capture-release-recapture 기전 inventory + **oral 이 왜 어려운지 (site-specificity wall) 정량화** → `TTR-ORAL/research/oral_feasibility_scope.md`
- [x] M2-ORAL — 경구 ADME wall 분석 (GI 흡수 → first-pass → 전신분포 → 진피 도달 농도 first-principles · 진피 도달 분율 추산) → `TTR-ORAL/research/oral_adme_wall.md` · **f_target ≈ 8.9×10⁻⁵ (~0.009%), amplification 5600× = wall 정량**
- [x] M3-ORAL — site-specificity 돌파 메커니즘 4종 deep-dive (per @D d2): A pro-drug+외부활성화 `path_A_prodrug_activation.md` · B macrophage 이주 `path_B_macrophage_migration.md` · C+D lymphatic/NP `path_CD_lymphatic_nanocarrier.md` · **우선순위 A ≈ B ≫ C > D**
- [x] M4-ORAL — 활성성분/모달리티 후보 → `TTR-ORAL/research/M4_candidates.md` · **B 트랙 lead: B2 S1P/CCR7 이주축 (oral-native) · B1 CSF1R (FDA 경구 pexidartinib)** · (A 트랙 A1/A2 caged chelator = hybrid 참고)
- [x] M5-ORAL — **B pulsed PK/PD 시뮬** (hexa-native `sim/m5_pulsed_pkpd.hexa`) → `TTR-ORAL/research/M5_pulsed_pkpd.md` · **W2 닫힘 (🔵/🟢)** · **W3 수치경로 (펄스+회복 → TI ~10×)** but 독성 회복 timescale 🟠 (→ M9 실측-grounded: 격주 7mo는 안전실패, 안전 timeline=3-4주/~10-13mo) · 🟢 verbatim recompute
- [x] M6-ORAL — 전신 off-target 안전성 → `TTR-ORAL/research/M6_systemic_safety.md` + **re-gate `M6_regate_pulsed_TI.md`** · **B: NO-GO → CONDITIONAL-GO** (펄스 TI recompute · balanced 3-lever 회복효율 η≥0.125~0.375 면 통과 · 🟢 verbatim) · η 실측=🟠 (M9) · absorbed=false 유지
- [x] M-B돌파 — **B 단독 돌파 roadmap** → `TTR-ORAL/research/B_breakthrough_roadmap.md` · 세 벽(W1 fade≠erase=cosmetic endpoint reframe · W2 속도=t_90 closed-form ~26× boost→months · W3 window=pulsed sub-toxic 3-lever 조합) · thesis ⚪ fence verbatim · **W1/W2 닫힘(🔵 수치) · W3 게이트 잔존(🟠 실측 미입증, 닫힌 부정 아님)**
- [x] M7-ORAL — **B 경구 조합 제형** → `TTR-ORAL/research/M7_formulation.md` · S1P1 modulator(etrasimod/ozanimod 연속 backbone=k_emig) + pexidartinib CSF1R 펄스(k_death+r↓) + lymph-flow adjunct · **FDC 기각** (duty-cycle TI 파괴) → co-pack 펄스타이밍 · 격주 on3/14 (TI~4.7×) · Rx-only · DDI(CYP3A4)=🟠
- [ ] M8-ORAL — ex-vivo / PK PoC · **프로토콜 설계 완료** → `TTR-ORAL/research/M8_M9_oracle_wetlab.md` (k_emig·φ·C_dermis 측정) · 🟠 wet-lab 실행 deferred (@D d1)
- [ ] M9-ORAL — in-vivo 마우스 fade-timeline · 프로토콜 설계 + **실측-grounded re-gate** (`M9_lit_grounded_recovery.md`): 문헌 τ_rec~21d(PLX5622)·90d 사이클(Baranska) → **격주 7mo=안전실패(η0.41<η*0.80)** · **3-4주 펄스 ~10-13mo=plausibly-GO(🟡)** · in-vivo 가 좁힐 것=dermal τ_rec + per-pulse φ (🟠)
- [ ] ORAL measured-oracle — **기준 정의 완료** O1∧O2∧O3∧O4 (skin ≥90% · fade ≤12mo · τ_rec<T & TI≥10 · 림프절 한정) · 🟠 wet-lab PASS 까지 absorbed=false

## verify (🔵 SUPPORTED-FORMAL push · per @D g5 · demiurge 자산 필수)

- [x] V1 TTR-ORAL claim inventory + tier triage — 42 claim → 🔵12·🟢8·🟡9·🟠13·⚪1 (🔴0) · V3 handoff host 매핑 → `TTR-ORAL/verify/V1_claim_inventory.md`
- [x] V2 🔵 push — closed-form arithmetic ledger 8/8 PASS (BA product · dermal fraction · 1차 kinetics) + meta-claim ⚪ fence verbatim · hexa verify --expr PK 한계 honest + stdlib 확장 path → `TTR-ORAL/verify/V2_formal_identities.md`
- [x] V3 🟢 push — hexa-native recompute (`sim/v3_numerical_recompute.hexa`) → `TTR-ORAL/verify/V3_numerical_recompute.md` · **6/6 핵심 양 V2↔V3 정합** (f_target 8.89e-5 · ampl 5600× · n90 14.17 · TI η* 0.375) · GPU TDDFT/MD = 🟠 deferred (B path 밖)
- [x] V4 final tier ledger → `TTR-ORAL/verify/V4_tier_ledger.md` · 비-wet-lab 전 게이트 completed · **B = CONDITIONAL-GO · 🔴 0건** · absorbed=false (결정 measurable=τ_rec<T) · 🔵+🟢+🟡 verbatim + 🟠 wet-lab deferred

## 심화 grounding (실측 pin-down · per /cycle round-1)

- [x] M5b-φ grounding → `TTR-ORAL/research/M5b_phi_grounding.md` (+ `sim/m5b_phi.hexa`) · 🚨 **φ 실측 중앙 0.05 (0.02-0.10), 0.15는 낙관 천장** · φ=0.05 시 3-4주 펄스 **~3-3.5년** (10-13mo 아님!) · φ=0.02 시 ~8-9년 → **W2 속도는 φ에 지배 · "months" = r↓ lever가 φ를 0.10-0.15로 올려야 성립 (wet-lab 🟠)**
- [x] M4b-k_emig grounding → `TTR-ORAL/research/M4b_kemig_grounding.md` (+ `sim/m4b_kemig.hexa`) · 🔴 **S1P/B2 = 역부호** (S1PR1 길항제 = egress 억제 · 색소 macrophage sessile) · 15× boost 미지지 (CCR7 천장 3-4×) → **S1P lever 폐기 · k_eff 노브 = k_death(CSF1R펄스)+r↓ 만**
- [x] cycle1 reconcile (M5b+M4b 합산) → `TTR-ORAL/research/cycle1_grounding_reconcile.md` (+ `sim/cycle1_reconcile.hexa`) · 🟢 verbatim · **수정 verdict: device-free 단독 = ~2-6년 (sub-year 도달불가)** · @D d2 돌파경로 4종 (r↓ 차단·림프배출·τ↑·레이저병용)
- [x] BP1 deep-dive — 재포획 차단(r↓) lever 정량 → `TTR-ORAL/research/BP1_recapture_block.md` (+ `sim/bp1_recapture_block.hexa`) · 🟢 · **r↓=dominant 확인 (β0→0.95 = 188→31mo, 6×)** but ⚠ 잉크 재포획=scavenger-receptor(FcγR 아님) → fostamatinib wrong-arm 가능 · 高-β=biologic(비경구) → **경구 단독 months 비현실 · 핵심 미해결=경구 scavenger-receptor 길항제(BP1a) · near-term=레이저병용(BP1d)**
- [x] d11 적용 — 새 lever(배출 k_drain↑) + NOVEL(동기화 bolus 포화 s_sat) 함께 → `TTR-ORAL/research/d11_drainage_bolus_lever.md` (+ `sim/bp2_drainage_bolus.hexa`) · 🟢 · phago 차단제 없이 r 우회 (경구-OK)
- [x] d11b lymphagogue grounding → `TTR-ORAL/research/d11b_lymphagogue_grounding.md` · 🚨 **경구 D 현실 ~1.5× (19× 아님)** → 배출 lever *단독은 약함* (188→150mo) · but **s_sat=0.7 결합 시 ~22mo** → 무거운 일은 **bolus 포화(s_sat)** 가 함 (배출 아님). d11 의 D=19 standalone 정정.
- [x] BP1a scavenger-receptor scout → `TTR-ORAL/research/BP1a_scavenger_receptor_scout.md` (+ `sim/bp1a_sr_blocker_beta.hexa`) · 잉크 재포획 주범=**MARCO+MSR1** · 高-β 차단제 전부 비경구 · 🎯 **rhein(diacerein FDA 경구 prodrug, BA~89%) = 최초 SR-A 억제 small-molecule scaffold-in-hand** → BP1a = de-novo 아닌 **lead-opt** (MARCO/MSR1 선택성 + 색소 β). 안전=SR-A KO 감염취약→펄스 동기화.
- [x] BP1d laser-adjunct 정량 → `TTR-ORAL/research/BP1d_laser_adjunct.md` (+ `sim/bp1d_laser.hexa`) · 🟢 · 경구 r↓ 보조 → **세션 8→4.3 (~1.9× · ~13→7mo)** · Baranska-endorsed 기전 · 🟡 **추천 near-term 제품** · 단 경구 β 미입증 + imiquimod 인체 RCT 음성(주의 anchor)

- [x] benchmark scorecard → `TTR-ORAL/research/benchmark_scorecard.md` (+ `sim/benchmark_levers.hexa`) · 🟢 · **device-free only(기준) 재랭킹**: d11 bolus ~22mo = device-free 최선 · B-core 31mo · drainage 단독 150mo · (레이저-병용 5-7mo·레이저단독 13mo = **out-of-scope 참조선**)
- [x] N1 phagolysosome-pH 게이팅 → `TTR-ORAL/research/N1_phagolysosome_pH_gate.md` (+ `sim/n1_ph_gate.hexa`) · pH-gate 자체 🔵 (ΔE 0.171V · ON/OFF ~794×) but 🔴 **"pH만 부위특이성" falsified** (lysosome=모든 세포 산성 · 잉크는 산성부피의 1.8e-8) → **pH×pigment-proximity AND-gate 필요** (🟠). erase 가능 색소 ~60-70% (carbon black 20-30% 비분해 천장)
- [x] N2 monocyte 트로이목마 → `TTR-ORAL/research/N2_monocyte_trojan_horse.md` (+ `sim/n2_monocyte_trojan.hexa`) · 🟢 · **혈중 monocyte 표적 = ADME 벽 우회 (~5000× 접근)** = 진짜 novelty. but solo 느림(~16yr · k_death amplifier 필요) · 경구 reprogram agent 비특이(metformin 🟡)·표적형 없음(🟠). 정직: reach 이김 · speed 무승부 · selectivity 짐.
- [x] N1⊗N2 emergent — **monocyte(N2)가 N1 pigment-gated 촉매 운반** → 잉크 먹은 세포에 촉매 동승 ⇒ **pH×pigment AND-gate 자동충족 + ADME 우회 + erase**, 전부 device-free. 두 NOVEL이 서로 honest 갭(N1=AND-gate·N2=amplifier/표적) 상보. (개념 🟠 · 다음 deep-dive 후보)

- [x] N1⊗N2 deep-dive → `TTR-ORAL/research/N1xN2_monocyte_catalyst.md` (+ `sim/n1xn2.hexa`) · 🔵 **AND-gate 진짜 해결** (촉매가 monocyte 내부에만 → pigment∧acid∧catalyst 자동 co-localize · ~740× 적은 산성 mL · ~7.4e5× 적은 세포 노출) · but 🟠 **벽이 "경구 순환-monocyte 적재"로 이동** (~5e-4 · oral NP는 gut-resident만 입증, 순환 pool in-vivo 근거 없음) · erase ~0.65 수렴(12mo) · carbon black 25% floor → 절대 ~75% 천장. 🔵4·🟢1·🟡3·🟠3.
- [x] N3 autophagy → `TTR-ORAL/research/N3_autophagy_degradation.md` (+ sim) · 🔴 **near-dead-end** — 병목=색소 화학(autophagy flux 아님) · anthracosis 반례(macrophage 평생 carbon 못 분해) · 분해가능 ~45-55%(azo+Fe) = N1(~60-70%)에 dominated · carbon 25% 🔴 floor. 비특이 전신 autophagy 부작용.
- [x] N4 ink-tagging glue → `TTR-ORAL/research/N4_ink_tagging_glue.md` (+ sim) · 결합 🟢 (**carbon black도 π-stack/catechol 결합 가능**!) · tag→r↓ 3-10× 🟢 · but 🟠 이중벽(ADME 8.9e-5 × 세포내 접근) ~1e-6~1e-8 + stealth↔막투과 모순 · 🎯 niche = **carbon black tag-and-drag 유일 device-free lever**(분해 못하는 25% 대응), 단 freed pool + freeing lever 필요

- [x] N5 optical masking → `TTR-ORAL/research/N5_optical_masking.md` (+ sim) · 🔴 NO-GO — Weber 대비 T² 상쇄(C=0.822 불변 · closed-form) + 경구 태닝=펩타이드 ADME벽 + 전신 부위특이성 + 가역(W1 미달). fixpoint 미돌파.
- [x] N9 sunlight-gated → `TTR-ORAL/research/N9_sunlight_gated.md` (+ sim) · 🟠 WALL — UV 진피 미도달·햇빛 peak ~1.4e9× 약함·전신 sun=부위특이성 0. fixpoint 미돌파 (유일 잔존=sun-ROS∧dermal-gate 2-AND).

### round synthesis (device-free only 기준 · 갱신)
- **device-free 단독 = 다년** (TTR-ORAL 답) — 최선 = d11 bolus ~22mo · 무거운 일은 *s_sat(재탐식 포화)* · 경구 r↓ lever 후보 = **rhein scaffold(BP1a, lead-opt)**.
- **N1 erase 경로**: 색소 ~60-70% *파괴* 가능(relocate 아님)이나 pH-alone 부위특이성 falsified → pH×pigment AND-gate 가 관건 (🟠).
- **round-2 메타**: best device-free 개념 = **N1⊗N2** (AND-gate 🔵 해결, 단 벽이 "경구 순환-monocyte 적재 ~5e-4" 로 relocate). 🧱 모든 분해 lever 공통 HARD floor = **carbon black ~25% 비분해**(anthracosis) → 분해로 ≥90% 불가(천장 ~75%). carbon 유일 경로 = **N4 tag-and-drag**. ⇒ ≥90% 가설 recipe = **N1⊗N2(organic 분해) + N4(carbon 견인) + bolus(freed 공급)** 3중합성(미검증 🟠).
- 🔒 레이저-병용(5-7mo)·prodrug+활성(A) = **out-of-scope** (device 필요 · 별도 트랙 · fallback 아님) — 참조선으로만.
- 미실측 결정 인자(🟠): φ · s_sat · rhein 색소-β · N1 AND-gate · (모두 M8 ex-vivo). absorbed=false · 🔴 0 (도메인 전체는 falsified 아님; 개별 가정만 🔴/falsified).
