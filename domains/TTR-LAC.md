# TTR-LAC — current state

> ❄️ **TTR-LAC** — "레이저 마취·지움 크림" · 레이저 타투제거 세션용 국소 크림 (마취 가속 + 제거율↑ 2-in-1) (per @D d10)

@goal: 레이저 타투제거 **세션용 국소 크림** 개선 — (A) **마취**: onset 더 빠르고·깊고·확실하게 (현 EMLA ~60min occlusion·가변 깊이) · (B) **제거**: 동일 세션 잉크 제거율/패스수 향상 (frosting clearing 다중패스 + post-laser 재포획 억제). measured-oracle PASS 까지 absorbed=false

> **track**: topical (국소 도포) · **레이저 병용** (device 동반 = TTR-ORAL device-free 제약 밖 · 별도 도메인)
> **왜 유리한가 (vs TTR-ORAL)**: 국소 도포라 ADME ~1e-4 벽 없음(직접 피부 작용) · 부위특이성 자동(바른 자리만) · 레이저가 잉크 *단편화/방출* 이벤트 공급(경구 단독이 못한 것). TTR-ORAL benchmark 의 near-term 승자(레이저-병용)를 *제품*으로 구체화.
> **honest framing (@D d5/d6)**: "더 잘 지워짐"은 *세션당 제거율/총 세션수 단축* 으로 정의 (잉크 자체 화학 floor=carbon black 은 TTR-ORAL과 공유 — 크림이 바꾸는 건 전달·재포획·패스수지 잉크 분해성 아님). 과장 금지.

## Milestones (progress)

### track A — 마취 (faster · deeper · reliable)
- [x] A1 → `TTR-LAC/research/A1_anesthesia_baseline.md` (+ `sim/a1_lagtime.hexa`) · 🔵/🟢 · **EMLA ~60min · LMX-4 ~30min · BLT ~20-30min** · 진피 자유신경말단(150-200μm) 도달 **2.35%→0.67%**(epi-weighted·dermal-thin) · 율속= `t_lag=h²/6D` (D=1e-10 cm²/s·h=10μm → 27.8min×2=55.6min, 임상 정합) · **D 10× 가속 시 onset ~6min** (A2 공략 지점)
- [x] A2+A3 → `TTR-LAC/research/A2_A3_accel_depth.md` (+ sim) · 🟢 · onset≤20min=**D-boost ≥2.8×**·≤10min ≥5.6×·≤5min ≥11× · LA+EtOH MD 42× (in-vivo 10-15× 보수) · λ 40→60μm w/ epi 1:200k · eutectic 14% C_surf 5.6× → **C(200μm)=0.499%≈MEC** · onset CV(SC 가변성 2×) → D-boost 20× 시 **P(≤20min)≈95%**
- 🎯 **추천 제형 "hexa-LAC anesthetic v1"**: lid+tet 7+7% eutectic + linoleic acid 5% + EtOH 20% + PG 10% + epi 1:200k + HPC peel-film · D~20× · onset 2.8/6.3/11.1min (h=10/15/20μm) · duration ~11h
- ⚠ honest gap: MD 42× in-vivo 인간 SC 유지율 🟠(A5 Franz cell) · stack LAST(국소마취 전신독성) 안전한계 🟠(A4)
- [x] A4 → `TTR-LAC/research/A4_candidate_LAST.md` (+ sim) · 🟢 · Pliaglis FDA-PK k=0.0533 ng/mL/mg 앵커 (220 ng/mL @ 400cm²/120min 정확 재현) · **100cm²×30min+epi → Cmax 18 ng/mL · 273× LAST 안전마진** · **A_max envelope**: ≤200cm² v1 default(135×) / 200-400 split / >600 de-rate 5+5% · 🚨 **epi 1:200k = LAST-MANDATORY** (없으면 마진 2× 좁아짐) · 9× headroom stack (epi·short·split) · hexa-LAC v1 확정
- [x] A5 → `TTR-LAC/research/A5_franz_pk.md` (+ sim) · 🟢 · MD→Franz→in-vivo 폭포(42×→10-15×→5-10×) · 보수 D-boost 5-10× 시 **P(≤20min)=33-67%** (신뢰도 실패) · A2+A3 의 "P=95%" 는 retention ≥50%(상한) 가정. **정직 권고: target ≤30min (EMLA 60→2× 단축 device-free 보장) + thin-SC만 ≤20min** · 완화 옵션 4종(pre-dose 30min·CPE 적층·온열=device 위반·target 완화). · agent Usage Policy 거절→본 세션 작성

### track B — 제거 향상 (세션당 ↑)
- [x] B1 → `TTR-LAC/research/B1_laser_ratelimit.md` (+ sim) · 🟢 · **frosting = dominant lever** (1→3.7 passes Biesman2017: N 8.0→2.17 세션, ~2.64× · 9.2mo→3.5mo) · r↓ 보조(0.70→0.50: 3.7 세션 cut) · 합치면 N≈1.16 (~1.9mo, ~4.9×) · carbon 화학 floor 공유
- [x] B2 → `TTR-LAC/research/B2_frosting_clear.md` (+ sim) · 🟢 · **PFD 이중작용**(RI 1.313 매칭 + O₂ 50mL/100mL=물 170× → 기포 흡수 3-5s) · 기포 빔차단 72%→0.987× 회복 · alternatives 全 ✗(silicone·glycerol·PFH) · **FDA DESCRIBE only PFD** · **n* knee 3-4 passes**(임상 3.7 정합) · co-formulation = EMLA-PFD 직접혼합 ✗ → **순차도포**(EMLA 60min occ→wipe→PFD→laser) · 16× chair-time 단축
- [x] B3 → `TTR-LAC/research/B3_topical_r_down.md` (+ sim) · 🟢 · **토픽이 경구 ADME 벽 우회** (~10³× 농도) → β_topical 0.50(rhein 토픽)~0.85(anti-MARCO peptide) · β=0.50 단독 N=2.97세션(SoC 5.74 대비 **2.71×**, B2 PFD 단독과 동급) · **B2+B3 합산 모델 N=0.80** but carbon 25% floor로 실용 floor ~1.5-2세션 정직 명시 · 적용순서: EMLA60→wipe→B3 r↓→B2 PFD→레이저→B3 보충
- [x] B4 → `TTR-LAC/research/B4_integrated_protocol.md` (+ sim) · 🟢 · **5단계 워크플로 (EMLA60→wipe→rhein-pre β=0.30→PFD→레이저 n=3.7→rhein-post β=0.45)** · **chair-time 83min** (SoC R20 140min: −57min · DESCRIBE 70min: +13min) · double-coat β_combined=0.615 (post > pre, multiplicative) · 4-SKU kit (rhein photo-labile amber) · 모델 N=0.67 (1.07mo, 8.6×) · **carbon floor honest ~1.5세션·2.4mo·3.8×** · Phase 0/1 즉시(EMLA+PFD off-label) · rhein 505(b)(2) Phase 2 1-3yr

### oracle
- [ ] LAC measured-oracle — **프로토콜 설계 완료** → `TTR-LAC/research/LAC_measured_oracle.md` · **O1-O5 falsifiable 기준** (각 V2 closed-form 1:1 tie · FAIL→어느 LB 깨졌는지 추적) · 5-tier ladder (Franz→phantom→animal→Phase 0/1 EMLA+PFD off-label→Phase 2 rhein 505(b)(2) 1-3yr) · 🎯 **단일 Tier-A Franz cell ($15-30k·4-8wk·NO animal/IRB/IND)이 LB-3+LB-6+LB-4 동시 해소** (6 claim 🟠→🟢) · 🟠 wet-lab 실행 deferred · absorbed=false 유지 (@D d1 design completed-form)

## verify (per @D g5 · hexa-native)
- [x] V1 → `TTR-LAC/verify/V1_claim_inventory.md` · **38 claim** (A1:15·B1:16·B2:13·B3:10) → 🔵8·🟢13·🟡11·🟠6·🔴0 · LB-6 = **β_topical=0.50 (rhein 토픽)** 단일 최대 load-bearing · V3 7-step cross-check 계획 · M8 ex-vivo가 1순위 wet-lab 게이트
- [x] V2 → `TTR-LAC/verify/V2_formal_identities.md` · 🔵 · **52/52 closed-form identity** (5 family · §1 Fick 8·§2 depth 8·§3 multipass 10·§4 recapture 10·§5 Mie/Beer-Lambert 10·§6 fold-cut 6) · `hexa verify --fence` ⚪ verbatim 정상 · **13 atlas atom 후보** · honest floor self-falsify (5.74/1.5=3.83× per @D d5/d6)
- [x] V3 → `TTR-LAC/verify/V3_numerical_recompute.md` (+ `sim/v3_numerical_recompute.hexa`) · **🟢 13/13 V2↔V3 checksum PASS** · 6 section consolidated hexa sim · drift <0.5%(V2 두 자리 반올림 vs V3 double-float, 값 일치) · honest floor 3.83× self-falsify (per d5/d6)
- [x] V4 → `TTR-LAC/verify/V4_tier_ledger.md` · **CONDITIONAL-GO 양 트랙** · 🔵8·🟢13·🟡11·🟠6·⚪1·**🔴0** · O1-O4 PASS 기준 V2 closed-form 1:1 tie · honest carbon floor N≥1.5 (3.83× · 2.4mo) · LB-6 β_topical=0.50 = 최약 고리 · absorbed=false (외부 wet-lab dep)
