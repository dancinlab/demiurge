# TTR-ORAL — log

## 2026-05-24T21:10Z — 🏁 CLOSURE: in-silico fixpoint 확정 → wet-lab 핸드오프

- /gap=fixpoint 판정 후 마지막 orthogonal probe 2종(/cycle-full brainstorm depleted at round 3):
  - [x] N5 optical masking (`N5_optical_masking.md` + sim) — 🔴 NO-GO. closed-form Weber 대비 `C` 가 위 덮개 멜라닌의 T² 인자로 잉크·주변 동시감쇠 → 상쇄(C=0.822 불변, JND 0.02 위). + 경구 태닝=afamelanotide/melanotan 펩타이드(ADME벽) + 전신 부위특이성(타투/체표 5.6e-3) + 마스킹=가역(W1 미달). 4중 벽. 잔존가치=레이저용 topical optical-clearing adjunct만.
  - [x] N9 sunlight-gated (`N9_sunlight_gated.md` + sim) — 🟠 WALL. UV 진피 미도달(~0.005% @1mm)·red/NIR만 통과 · Q-switched 레이저 peak ~1.4e9× 햇빛 · 광열 ~2.4K vs 레이저 ~240K · 전신 sun=공간게이팅 불가(타투 share ~0.625). 유일 잔존=sun-ROS∧dermal-condition 2-AND.
- **사용자 결정 "안깨지면 정리하자" → 둘 다 fixpoint 미돌파 → CLOSURE.**
- 🏁 **in-silico 탐색 고갈 확정**: device-free 경구 ≥90% = 비-wet-lab 닫힘. 공통 천장 = carbon black ~25% 비분해(anthracosis·sp²C-C 5.37eV) + ADME ~1e-4(또는 monocyte 적재 ~5e-4). 모든 lever(B-core·r↓·drainage·bolus·rhein·N1·N2·N1⊗N2·N3·N4·N5·N9)가 이 천장에 수렴.
- → **wet-lab 핸드오프** (gap top-1): #1 실험 = 실제 잉크 carbon분율/분해성(feasibility binary gate) · #2 φ(속도 7× band). best 잔존개념 = **N1⊗N2**(monocyte-운반 pigment-gated 촉매, AND-gate 🔵 해결·적재 🟠).
- 재개 시 정리부채(gap top-3): PK 커널 15/18 sim 복제 → 공유 .hexa 모듈 · φ/k_death/T drift → PARAMETERS.md SSOT · 단일모델 SPOF → 독립 교차검증.
- absorbed=false 유지 · 🔴 0 (도메인 falsified 아님; 개별 가정 S1P·pH-alone·autophagy-flux·optics-T²만 닫힌 부정). 정직 closure (@D d1·d5·d6).

## 2026-05-24T20:45Z — /cycle round-2: N1⊗N2 정량 + N3·N4 NOVEL (device-free only)

- [x] N1⊗N2 deep-dive (`N1xN2_monocyte_catalyst.md` + `sim/n1xn2.hexa`) — 🔵 **AND-gate 진짜 해결**: 촉매가 monocyte 내부에만 존재 → pigment∧acid∧catalyst 자동 co-localize (N1의 1.8e-8 비특이 → 자기충족 site-gate). ~740× 적은 산성 mL · ~7.4e5× 적은 세포 노출. **벽이 사라지지 않고 "경구 순환-monocyte 적재"로 relocate** (~5e-4 · oral NP는 gut-resident만 입증, 순환 pool in-vivo 근거 없음 🟠). erase=0.65×(1−e^(−t/90d))=0.19/0.41/0.56/0.64 @1/3/6/12mo, carbon 25% floor → 절대 ~75% 천장. 🔵4·🟢1·🟡3·🟠3.
- [x] N3 autophagy (`N3_autophagy_degradation.md` + sim) — 🔴 near-dead-end. p_erase=k_dig/(k_dig+k_recap); 경구 inducer(rapamycin/spermidine ~2-3× flux)는 flux만 올림. 결정 반례 = **anthracosis**(macrophage 평생 carbon 못 분해 · Baranska 잉크 세대간 무손상 전달) → 병목=색소 화학 not flux. 분해가능 ~45-55%(azo+Fe azoreductase) = N1(~60-70%)에 dominated · carbon 25% 🔴 + Cu-Pc/Cr₂O₃ 10% wall → ≥90% 불가. 비특이 전신.
- [x] N4 ink-tagging glue (`N4_ink_tagging_glue.md` + sim) — warhead 결합 🟢 (pyrene π-stack carbon ~9 kcal/mol · catechol/DOPA metal-oxide 29 k_BT · bisphosphonate). tag→r↓ 3-10× 🟢. 🟠 이중벽: ADME 8.9e-5 × 세포내 묻힌 잉크 접근(VCC 선례 small-molecule 거의 불가) → 직렬 ~1e-6~1e-8 + stealth(전하/PEG)↔막투과 모순. 🎯 niche = **carbon black tag-and-drag 유일 device-free lever** (분해 못하는 25%) · 단 freed pool + freeing lever 필요.
- **round-2 메타**: best device-free 개념 = N1⊗N2 (AND-gate 🔵, 벽 relocate). 🧱 공통 HARD floor = carbon black ~25% 비분해(anthracosis) → 분해 ≥90% 불가(천장 ~75%). carbon 유일 = N4 tag-drag. ⇒ ≥90% recipe = **N1⊗N2(organic 분해)+N4(carbon 견인)+bolus(freed 공급)** 3중합성(🟠 미검증). absorbed=false · 🔴 0(도메인).
- d11 작동: 4 NOVEL(N1·N2·N3·N4) + 1 emergent(N1⊗N2) + composite recipe 자가도출. 정직 음성(N3)·niche(N4)·relocate(N1⊗N2) 모두 명시.

## 2026-05-24T20:20Z — TTR-ORAL = device-free only 기준 확정 + N1/N2 착지 + N1⊗N2 emergent

- 🔒 **scope 확정 (사용자: "경구는 device-free 로만 · TTR-ORAL 기준")**: 전역 governance 아님 (d12 project.tape 추가 철회). @goal 에 scope line. 레이저-병용(BP1d)·prodrug+외부활성(A) = **out-of-scope (별도 트랙 · fallback 아님)**. 벤치마크 승자도 device-free 안에서만.
- [x] N1 phagolysosome-pH 게이팅 (`N1_phagolysosome_pH_gate.md` + sim) — pH-gate 자체 🔵 (ΔE 0.171V·ON/OFF ~794×, V2§7 CeO₂ 정합) but 🔴 **"pH만 부위특이성" falsified** (lysosome=모든 세포 산성 · 잉크 phagolysosome=전체 산성부피의 1.8e-8). → **pH×pigment-proximity AND-gate 필수**. erase 가능 색소 ~60-70% (carbon black 20-30% sp²C-C 5.37eV 비분해 · Cu-Pc/Cr₂O₃ 10-15% 기존 wall). 🔵1/🟢/🟡/🟠.
- [x] N2 monocyte 트로이목마 (`N2_monocyte_trojan_horse.md` + sim) — 혈중 monocyte 표적 = **ADME 벽 우회 ~5000× 접근** (Lin 2024: 혈중 monocyte = 최강 ink-uptaker). r_eff: τ_rep≈90d turnover 로 r0 0.95→0.66(3mo)→0.56(6mo). solo ~16yr (k_death amplifier 필요) → N2+CSF1R펄스 ~2-2.6yr. 경구 reprogram agent 비특이만(metformin trained-immunity 차단 🟡)·표적형 부재(🟠). reach 이김·speed 무승부·selectivity 짐. 🔵1·🟢2·🟡4·🟠3.
- [x] **N1⊗N2 emergent NOVEL**: monocyte(N2)가 N1 pigment-gated 촉매 운반 → 잉크 먹은 세포에 촉매 동승 ⇒ **AND-gate 자동충족(pigment-proximity=그 monocyte) + ADME 우회 + erase**, device-free. 두 NOVEL이 상보(N1 갭=AND-gate ← N2 운반 · N2 갭=표적/amplifier ← N1 erase). 🟠 개념 · 핵심 다음 deep-dive.
- [x] benchmark scorecard (`benchmark_scorecard.md` + `sim/benchmark_levers.hexa`) device-free 재랭킹 — best=bolus 22mo · 단독 lever 로 incumbent 못 이김 · 판도전환=N1⊗N2.
- ⇒ 4 NOVEL 라운드(N1·N2·d11 bolus·rhein) + benchmark 완료. device-free 승부처 = **N1⊗N2 조합**. absorbed=false · 🔴 0 (도메인). d11 governance 계속 작동 (벽마다 새 lever/조합 자가창발).

## 2026-05-24T20:00Z — NOVEL 계속발굴 + 벤치마킹 (scorecard)

- [x] benchmark scorecard (`benchmark_scorecard.md` + `sim/benchmark_levers.hexa`) — 모든 lever 공통축 점수화 + incumbent 레이저 대비. 🟢 verbatim timeline:
  - 레이저+r↓0.4 = **5.3mo (3.3세션)** ★최단 | 레이저+r↓0.5 = 6.9mo | 레이저 단독(기존) = 12.9mo(8세션) | **d11 bolus = 22.3mo ★device-free best** | B-core = 31.4mo | drainage 단독 = 150mo | S1P = 🔴폐기.
  - 종합: near-term 승자 = **레이저-병용**(device 필요). device-free 단독은 bolus(22mo)도 incumbent(13mo)보다 느림 → device-free 가 이기려면 **패러다임 전환 NOVEL 필요**.
- 🌱 NOVEL 2종 발굴 발사 (background · per @D d11/d2):
  - **N1 phagolysosome-pH 게이팅 in-situ 분해** — 중성 불활성·산성(pH4.5) phagolysosome 에서만 활성 → *erase(재배치 아님)* + 내재 부위특이성 + device-free 경구. TTR base CeO₂ pH-switch(ΔE 0.171V) 직결. honest 관문 = "모든 세포 lysosome 도 pH4.5" specificity.
  - **N2 monocyte 트로이목마** — 영구성=monocyte 보충(Baranska)이니 *혈중 monocyte*(ADME 우회·혈액 접근 쉬움)를 재프로그램 → 들어올 교체세포가 재포획 안 함(r↓). resident 말고 replacement 표적.
- 다음 NOVEL 큐: autophagy 유도(intracellular 분해)·ink-tagging molecular-glue(lymphatic export)·gut-microbiome 활성화 prodrug.

## 2026-05-24T19:45Z — 동시 진행 라운드 (BP1a·BP1d·d11b) 착지 + synthesis

- [x] BP1a — 경구 SR 길항제 scout (`BP1a_scavenger_receptor_scout.md` + sim) — 잉크 재포획 주범 = **MARCO(SR-A6)+MSR1/SR-A1** (KO 흡수실패 입증). 高-β 차단제 전부 비경구(anti-MARCO PY265·fucoidan/poly(I) 48-87% in-vitro). 🎯 **rhein** (diacerein FDA 2008 경구 prodrug, 상대 BA~89%) = *최초 동정 SR-A small-molecule 억제제* → BP1a = de-novo 발굴 아닌 **rhein anthraquinone scaffold lead-opt** (MARCO/MSR1 선택성 SAR + 색소-β 측정). 안전: SR-A/MSR1-KO 감염취약(Listeria/HSV-1) → CSF1R 펄스 동기화 완화. 🟡/🟠.
- [x] BP1d — laser-adjunct 정량 (`BP1d_laser_adjunct.md` + sim) — `c(r)=φ_rel·(1−r)`, `N=log0.1/log(1−c)`, φ_rel=0.83 calib (no-adjunct r0=0.70 → ~8 세션 lit-anchor). 경구 r↓ 0.70→0.50 → **8.0→4.3 세션 (~1.9× · ~13→7mo)**; r→0.40 → ~3.3 세션(~5.3mo). 🟢 verbatim. **🟡 추천 near-term** (Baranska 직접 제안 기전 · 레이저가 monotherapy 에 없는 release event 공급). 단 경구 β 🟠 + imiquimod 인체 RCT 음성(3.2 vs 2.9 NS) = 주의 anchor → 수용체-비의존 배출 선호.
- [x] d11b — lymphagogue D grounding (`d11b_lymphagogue_grounding.md` + sim) — 🚨 경구 D 현실 **~1.2-2.0× (중앙 1.5×), 19× 아님** (Daflon IV dog 흉관 +91-191%는 IV bolus peak·20-25min·비경구; 경구 인체는 tens-of-% edema 개선만). 배출 lever **단독 약함** (D=1.5 → 188→150mo, −20%). but **D=1.5 + s_sat=0.7 → ~22mo** → 무거운 일은 **s_sat(bolus 포화)** 가 함. d11 의 D=19 standalone(31mo) 정정 (>5× 낙관). 🟢/🟡.
- **synthesis**: near-term = **레이저-병용**(BP1d, 세션 절반). device-free 단독 = 다년 (s_sat 이 carry · D·경구 phago 차단 약/부재). 경구 lever 후보 = **rhein scaffold**(BP1a lead-opt). 미실측 결정 = φ·s_sat·rhein β (M8 ex-vivo). absorbed=false · 🔴 0.
- d11 governance 가 라운드에서 작동 입증 — 막힐 때마다 새 lever(배출·bolus) + NOVEL(포화) + scaffold(rhein) 가 자가 제시됨 (정직 하향 포함).

## 2026-05-24T19:25Z — @D d11 land + 즉시 적용 (새 lever+NOVEL 함께) + BP1a 발사

- 🏷️ **project.tape @D d11 추가** (사용자 지시 "막히면 새 dominant lever & NOVEL 함께 제시"): "on a wall — present a NEW dominant lever AND a NOVEL approach together". sign-gate 통과 land.
- [x] d11 적용 (`d11_drainage_bolus_lever.md` + `sim/bp2_drainage_bolus.hexa`) — BP1 벽(경구 phago 차단제 부재) 우회:
  - 🆕 **NEW lever = 배출 가속 (k_drain↑)**: `r=k_phago/(k_phago+k_drain)` 의 분모 공격 → phagocytosis 안 막고 r↓. 경구 lymphagogue 호환. D=19 → r 0.95→0.50 → 31mo (🟢).
  - 🧬 **NOVEL = 동기화 release bolus 포화**: CSF1R 펄스로 잉크-macrophage 동시 사멸 → 색소 bolus 가 국소 재탐식 용량 초과(zero-order 포화) → β 무관 escape. r_eff=r(1−s_sat).
  - **함께**: D=19 + s_sat=0.7 → ~19mo · 둘 다 device-free 경구 호환 → BP1 경구-agent 벽 우회 (비-incremental).
  - 한계: D~19(림프 19× 부스트)·s_sat 절대값 = 🟠 실측. near-term 여전히 레이저-병용 최단.
- 🌱 BP1a 발사 (background) — 경구 scavenger-receptor(MARCO/SR-A) 길항제 발굴 scout (진짜 device-free 핵심 타겟).

## 2026-05-24T19:10Z — BP1 deep-dive: 재포획 차단(r↓) lever (사용자 선택)

- [x] BP1 — r↓ 재포획 차단 lever 정량 (`BP1_recapture_block.md` + `sim/bp1_recapture_block.hexa`)
  - 모델 `r(β)=19(1−β)/(19(1−β)+1)` → k_eff → n90. 🟢 verbatim.
  - ✅ **r↓ = dominant lever 확정**: β 0→0.95 = 188mo→31mo (~6× 단축).
  - ⚠ **oral-agent gap (새 벽)**: 무른 잉크 재포획 = scavenger-receptor(MARCO/SR-A)+actin 일반 phagocytosis, **FcγR 아님** → fostamatinib(경구 Syk/FcγR, FDA ITP)은 잉크에 wrong-arm 가능 (β 낮음). 高-β(β≥0.9·~2.6yr)는 multi-receptor=biologic=**비경구** → device-free 제약 위반. CD47 차단은 역방향(phagocytosis 촉진).
  - @D d2 BP1 내부 돌파: BP1a⭐ 경구 scavenger-receptor 길항제(발굴 타겟·🟠) · BP1b fostamatinib 펄스 시험(🟡) · BP1c actin/PI3Kγ 광범차단(독성 wall) · BP1d⭐ 레이저-병용(단편화→drainage↑·경구 r↓ 시너지·🟡 near-term).
  - **결론**: device-free 경구 *단독* months = 비현실 (高-β 경구 agent 부재 + φ 천장). near-term credible = **BP1d 레이저-병용**. 진정 device-free 핵심 미해결 = **경구 scavenger-receptor 길항제**. absorbed=false.
  - tier: 🟢 recompute · 🟡 fostamatinib/재포획 기전 · 🟠 경구 SR 길항제 高-β.

## 2026-05-24T18:55Z — /cycle round-1: 실측 grounding 2종 → track B 정직한 대폭 하향

- 🌱 auto-seed (prior-turn shortlist): M5b-φ · M4b-k_emig (M8/M9/oracle 3개는 wet-lab 🟠 = fan-out 제외).
- [x] M5b-φ grounding (`M5b_phi_grounding.md` + `sim/m5b_phi.hexa`, agent) — per-pulse φ **직접 측정 논문 없음**; 평생손실(60-99%)/90일 사이클 역산 → **중앙 φ=0.05** (0.02-0.10). 가정 0.15는 7yr+99% 천장. φ=0.05 시 3-4주 펄스=**~3-3.5년** (10-13mo 아님). r 가 dominant lever (r 0.99→0.95 = φ 5×). 🟢 verbatim.
- [x] M4b-k_emig grounding (`M4b_kemig_grounding.md` + `sim/m4b_kemig.hexa`, agent) — 🔴 **S1P/B2 역부호**: fingolimod/ozanimod/etrasimod = S1PR1 *길항제* → skin DC→LN 이주 억제 (k_emig↓). 색소 macrophage = sessile (Baranska). 15× boost 미지지 (CCR7 천장 3-4×). M4 #6 "3-5× 🟢"는 방향 혼동 정정. → S1P 폐기 권고.
- [x] cycle1 reconcile (`cycle1_grounding_reconcile.md` + `sim/cycle1_reconcile.hexa`) — 수정 2-lever(k_death+r↓) 🟢 recompute: r=0.85→89mo · r=0.50→31mo · r=0.30→23mo · 12mo엔 φ=0.162 필요(천장 ~0.12 → **도달불가**). **수정 verdict: device-free 단독 ~2-6년 · sub-year 불가**. W2 ✅닫힘 → 🟠 (φ/r↓ 지배).
- @D d2 돌파경로 4종: BP1 재포획 직접차단(anti-CD64/CD47)⭐ · BP2 림프배출 가속 · BP3 펄스 τ↑ · BP4 레이저-병용/점진fade 재포지셔닝.
- 도메인 영향: @goal framing 에 grounding revision 기록 · **M4/M7 (S1P 기반) 개정 필요** 플래그 · absorbed=false 유지 · B falsified 아님 (lead lever S1P→r↓ 이동).
- ⇒ 정직: 낙관 "months" 가 실측 앞에서 "years" 로 정직 수정 (@D d6). round-2 후보 = r↓ lever deep-dive(BP1) · M4/M7 개정.

## 2026-05-24T18:40Z — 심화: 실측(문헌) grounding → W3 recovery re-gate (M9 deepening)

- [x] M9 deepening — 실측-grounded W3 recovery (`M9_lit_grounded_recovery.md` + `sim/m9_lit_grounded_recovery.hexa`)
  - 문헌 실측 (🟡): τ_rec(CSF1R 재증식)=**14-28d 중앙 21d** [PLX5622 PNAS2020·Diabetologia2023] · capture-release 사이클=**90d** [Baranska2018] · dermal macrophage→LN 이주 수시간 [J Immunol1998].
  - 모델 `η = 1−exp(−t_off/τ_rec)` → M6 re-gate η* 와 비교 (🔵 식 · 🟢 verbatim recompute).
  - 🚨 **정직 발견 (@D d6)**: 격주(T=14d) **η=0.41 < η*=0.80 = 안전실패** → M5 의 "7mo 격주" 낙관치는 실측 τ_rec 하에서 회복 부족. **현실 sweet spot = 3-4주 펄스 → ~10-13mo** (T=21d η0.58>η*0.54 thin · T=28d η0.70>η*0.40 편안). 자연 무펄스=42mo(90d 사이클 정합) → 펄스 3-4× 단축.
  - **W3 verdict: "🟠 assumed" → "🟡 literature-bounded · 3-4주 간격이면 plausibly-GO"**. window 가 현실 숫자에서 열림(단 7mo 아닌 ~10-13mo). dermal-특이 τ_rec + per-pulse φ 직접 실측만 M9 in-vivo (🟠) 남음.
  - thesis ⚪ fence verbatim. absorbed=false 유지.
- ⇒ 실측 grounding 으로 W3 를 "막연한 NO-GO" → "3-4주 펄스 plausibly-GO · 미실측 2개 숫자(dermal τ_rec·φ)만 남음" 까지 좁힘. 비-wet-lab 심화 완료.

## 2026-05-24T18:20Z — 비-wet-lab march 고갈: M6-regate·M7·M8/M9·V3·V4 + d10 네이밍 규칙

- [x] M6 re-gate (`M6_regate_pulsed_TI.md` + `sim/m6_regate_ti.hexa`) — 펄스 TI recompute (🟢) → **B: NO-GO → CONDITIONAL-GO**. balanced 3-lever 회복효율 η*≥0.125(TI≥1)·0.375(TI≥3) 면 통과. 강lever 단독 η*=0.6 (3-lever 우위 정량 지지).
- [x] M7 제형 (`M7_formulation.md`, agent) — S1P1 modulator(etrasimod/ozanimod 연속 backbone) + pexidartinib CSF1R 펄스 + lymph-flow adjunct. **FDC 기각** (단일정 = duty-cycle TI 파괴) → co-pack 펄스타이밍. 격주 on3/14. fingolimod 제외(t½ 6-9d 펄스 부적합). DDI=CYP3A4(🟠). Rx-only.
- [x] M8/M9/oracle (`M8_M9_oracle_wetlab.md`, agent) — M8 ex-vivo 3측정(k_emig·φ·C_dermis) · M9 마우스 6 cohort fade-timeline (결정 endpoint **τ_rec vs T**) · measured-oracle O1∧O2∧O3∧O4. 모두 🟠 wet-lab deferred (@D d1 · 프로토콜=완료).
- [x] V3 🟢 (`V3_numerical_recompute.md` + `sim/v3_numerical_recompute.hexa`) — V2↔V3 6/6 정합 (f_target 8.89e-5·ampl 5600×·n90 14.17·TI η* 0.375). GPU TDDFT/MD=🟠 (B path 밖).
- [x] V4 final ledger (`V4_tier_ledger.md`) — 비-wet-lab 전 게이트 completed · **B = CONDITIONAL-GO · 🔴 0건** · absorbed=false (결정 measurable=τ_rec<T) · 닫힌 부정 없음.
- 🏷️ **d10 네이밍 규칙** (사용자 지시: "도메인마다 icon·name·alias") — project.tape @D d10 추가 시도. lint(≤100자·영문) 통과했으나 **sign-gate BLOCK** → 사용자 `sidecar sign project` 대기. 적용은 선반영: TTR-ORAL 🦠"면역세포 택배" · TTR ✂️"타투 지우개" · TTR-CREAM 🧴"바르는 타투 크림" · TTR-MN 🩹"붙이는 도장 패치".
- ⇒ 진척 12/15 (M1-M7·M-B돌파·V1-V4 ✅) · 남은 3 = M8·M9·measured-oracle = 본질적 wet-lab 🟠. **비-wet-lab 작업 고갈 완료** (@D d1).

## 2026-05-24T18:05Z — M5 B pulsed PK/PD 시뮬 (hexa-native) — W3 window 수치경로 확보

- [x] M5-ORAL — pulsed macrophage-emigration PK/PD (`TTR-ORAL/research/M5_pulsed_pkpd.md` + `sim/m5_pulsed_pkpd.hexa`)
  - .py write 가 project.tape 마커로 차단 → **hexa-native (.hexa) 로 작성** (@D g1 정합 · exp/log/pow 가용). PK/PD ODE trivial → d7 상 pool 불요, 로컬 `hexa run` (hexa-native = ad-hoc python 아님).
  - 모델: `phi = 1−exp(−k_eff·tau)`, `k_eff = k_emig + (1−r)·k_death`, `n90 = log(0.1)/log(1−phi)` (밑 무관).
  - **🟢 verbatim recompute** (hexa run · 손검산 일치): full 3-lever k_eff=0.65 → phi=0.150 → n90=14.17 pulses; 수치 적분 13 pulses vs closed-form 12.84 (whole-pulse ceil 차이만) → self-consistent.
  - **W2 (속도) 닫힘**: full 3-lever 격주 펄스 → ~7 mo skin clearance (월간 ~14 mo). 자연 baseline=409 pulses(~34yr) 가 wall 재확인.
  - **W3 (window) 수치경로**: 펄스가 창 여는 조건 = 비선형 2조건 (독성 펄스간 회복 + 효과 event-driven). 충족 시 `TI_pulsed/TI_chronic ~ period/on` = **~10× (30d/3d)**. M6 NO-GO → "conditional-go (회복 timescale 입증 시)" 격상 정량 경로.
  - 정직: **"독성 회복 timescale < period" 가정이 핵심 measurable → 🟠** (M6 re-gate + wet-lab). absorbed=false 유지.
  - tier: 🔵1 (n90 identity) · 🟢2 (recompute) · 🟡1 (TI 조건부) · 🟠2 (회복가정·phi 절대값).
- ⇒ 진척 9/15. next: M6 re-gate (duty-cycle TI) · M7 (B 경구 제형) · M8/M9 wet-lab.

## 2026-05-24T17:52Z — B 단독 돌파 pivot + 라운드 2 (M4·M6·V1) + B 돌파 roadmap landed

- 🔀 **pivot (사용자 결정 "B 로 돌파")**: device-free 확정 → 기구 필요한 A (pro-drug+레이저/초음파) 는 hybrid 서브트랙으로 분리 (`path_A_prodrug_activation.md` 보존). **B (macrophage 이주) = 유일 device-free lead.** @goal 재작성 (W1/W2/W3 3벽 명시).
- [x] M4-ORAL — 후보 (`M4_candidates.md`, 202L) — B lead: **B2 S1P/CCR7 이주축**(oral-native·k_emig knob) · **B1 CSF1R**(FDA 경구 pexidartinib·k_death knob, 단 고갈 safety=M6 게이트). A1/A2 caged chelator = hybrid 참고. tier 🔵2·🟢1·🟡4·🟠5.
- [x] M6-ORAL — 전신 안전 (`M6_systemic_safety.md`, 247L) — LOCAL→SYSTEMIC reframe (GI>liver>kidney>plasma>CNS>target). **A = CONDITIONAL-GO** (TI_A ∝ 1/r_dark · amplification 무관, 🔵 decoupling) · **B = NO-GO now** (window 미입증 · 강lever=독성겹침 · 안전lever=약함 · clean 경구 CCR7 부재). 둘 다 absorbed=false. tier 🔵5·🟡3·🟠3.
- [x] V1-ORAL — claim inventory (`V1_claim_inventory.md`, 161L) — **42 claim** → 🔵12(8=V2)·🟢8·🟡9·🟠13·⚪1·🔴0. V3 handoff host 매핑 (Φ_u TDDFT→pool/GPU · lymphatic MD→GPU · PK/PD→local CPU).
- [x] M-B돌파 — **B roadmap** (`B_breakthrough_roadmap.md`) — 세 벽 정면돌파:
  - W1 (fade≠erase): cosmetic endpoint("skin 에서 안 보임") reframe — 림프 relocation=자연 sink 가속 → 부분 해소 (림프절 safety 는 M6 게이트 잔존).
  - W2 (속도): `t_90 = ln10/k_eff` closed-form ledger — k_nat≈0.019/month(~10yr) → k_eff 0.5/month(~26× boost)=**4.6 month**. r↓(0.95→0.80)=4× 단일 최대배율. 🔵 수치.
  - W3 (window·핵심게이트): **pulsed sub-toxic 3-lever 조합** — chronic 강lever 대신 pulse(시간적분 TI↓ duty-cycle) + 3 agent sub-threshold(각 안전역 보존, k_eff 합산). first-principles 상 window 넓힘 구조 but 실측 미입증 → 🟠 (M6 NO-GO 미해소, 닫힌 부정 아님).
  - thesis `hexa verify --fence` ⚪ verbatim · M5 를 B pulsed PK/PD 로 재조준.
- ⇒ 진척 8/15 (M-B돌파 추가). next: M5 (B pulsed PK/PD 시뮬 → W3 정량) · M6 re-gate (duty-cycle TI) · M7 (B 경구 제형).

## 2026-05-24T17:38Z — M2 ADME wall 정량 + V2 verify + M3 돌파경로 4종 deep-dive landed

- [x] M2-ORAL — 경구 ADME wall first-principles (`TTR-ORAL/research/oral_adme_wall.md`)
  - ★ dermal delivery fraction `f_target = Kp·F·V_tat/Vd = 1×0.5×0.0075/42 = 8.93×10⁻⁵` (먹은 dose 의 ~1/11,200 만 타투 자리 도달)
  - 전신/표적 dose 증폭률 `Vd/(Kp·V_tat) = 5600×` = site-specificity wall 정량
  - 3 track 비교: MN ~0.5-1.0 · CREAM ~0.01-0.1 · **ORAL ~10⁻⁴** (3-4 자릿수 열세)
  - brute-force 경구 잉크-분해약 1차 판정 🟠 (A/B 우회 존재 — 닫힌 부정 아님)
- [x] V2 🔵 push — closed-form arithmetic ledger 8/8 PASS (`TTR-ORAL/verify/V2_formal_identities.md`)
  - bioavailability product 3/3 · dermal fraction 3/3 · 1차 kinetics 2/2 (hand-verifiable)
  - meta-feasibility 주장 `hexa verify --fence` ⚪ SPECULATION-FENCED verbatim
  - hexa verify --expr PK 미지원 honest 명시 + stdlib 확장 path (hexa-lang INBOX 후보 per @D d8)
- [x] M3-ORAL — 돌파경로 4종 deep-dive (background agent ×3 · 거절 0 · 모두 정직 tiering)
  - **A) pro-drug + 외부 국소 활성화** (`path_A_prodrug_activation.md`, ~210L) — spatial gating 을 "전신 분포 문제 → pro-drug 암흑활성화 r_dark 억제 설계"로 환원 (🔵). 3 modality (photo-uncaging · FUS/photothermal · 잉크-as-photosensitizer 755/1064 nm). active 분자(deferiprone·deferasirox)는 이미 경구 FDA 약 → active 경구장벽 기해소. 판정: wall partly open · hybrid 전제 · 정량 검증 deferred (🔵5/🟡2/🟠4).
  - **B) macrophage 이주 가속** (`path_B_macrophage_migration.md`, ~165L) — 잉크 분해 아닌 내인성 청소 가속. 1차 모델 `dN/dt=−k_eff·N`, 자연 ~7yr → 3-6× boost 시 ~4-14mo. 가장 oral-native. 단 림프절 재배치(파괴 아님)·fade·전신 면역조절 risk → 임상 🟠 (🔵2/🟢1/🟡2/🟠3).
  - **C+D) lymphatic lipid / ink-homing NP** (`path_CD_lymphatic_nanocarrier.md`, ~264L) — C: chylomicron 림프 우회 routing 닫힘(🔵)·간 first-pass 회피(🟢)·lymph:plasma 10-100×(🟡) but 타투 node 특이성 🟠. D: 경구 NP 흡수(~0.1-1%)×진피 호밍(~0.1-1%) 직렬 → 도달 ~10⁻⁶-10⁻⁴ ppm. 둘 다 🟠 · **C > D**.
  - ⇒ 종합 우선순위: **A ≈ B ≫ C > D**. A/B 가 wall 우회, C/D 는 보조 제형/ligand toolbox 가치만.
  - ⇒ next round (M4-M9): A·B 두 lead track 로 M4 활성성분/모달리티 → M5 시뮬 → M6 전신 안전 (핵심 게이트).

## 2026-05-24T17:28Z — sub-domain scaffold + oral feasibility scope landed

- [x] M0-ORAL — domain 생성 (3번째 TTR track · CREAM·MN 에 이은 oral/ingestible) + feasibility scope (`TTR-ORAL/research/oral_feasibility_scope.md`)
  - 핵심 wall 식별: **부위 특이성(site-specificity)** — 경구약은 전신 분포, 타투는 국소 ~10-100 cm². 반응성 화학을 전신 활성화하면 전신 조직 손상.
  - @D d2 breakthrough path 4종 inventory:
    - ⭐ A) **pro-drug + 외부 국소 활성화** — 불활성 pro-drug 경구 → 전신 무해 분포 → 타투 피부에만 외부 trigger(빛/집속초음파/온열, 또는 잉크 자체를 광증감제로) 적용 → 국소 활성화. whole-body → localized 전환으로 wall 돌파. 선례: 5-ALA→PpIX PDT pro-drug, caged compound.
    - ⭐ B) **macrophage 이주 가속 (생리적 fade 가속)** — 잉크 분해가 아닌, 진피 macrophage turnover + 림프 trafficking 자극 → 잉크를 배출 림프절로 운반. 내인성 청소 경로라 전신 호환. 정직 caveat: 잉크를 파괴가 아닌 림프절 재배치 · 완전 소거 아닌 fade · 느림. 선례: Baranska 2018 capture-release 모델이 macrophage 일시 고갈 → laser 제거 개선 시사.
    - C) lymphatic-targeted lipid formulation (chylomicron-hitchhiking · 장 림프 경유 · 정밀도 < A)
    - D) ink-homing 경구 흡수 NP (잉크 표면 친화 functionalize · 경구 BA 가 2차 wall · 투기적)
  - 🚨 정직한 천장: oral track = 3 track 중 부위 특이성 최약 · 전신 독성 risk 최대. "직접 잉크 분해 경구약" 1차 판정 🟠 (per @D d5/d6 강제 안 함).
  - 본 세션 직접 작성 (agent fan-out 없이).

Append-only history sister of `TTR-ORAL.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.
