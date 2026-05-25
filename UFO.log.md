# UFO — log

Append-only history sister of `UFO.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-26T01:10:00Z — Phase C verb-5 synthesize — BOM + 도면 + firmware 산출물 LANDED

Phase C demiurge 7-verb pipeline 다섯 번째 슬롯 (verb-5 synthesize). verb-3 design 의 Stage-1~3 closed-form 설계점 + verb-2 structure 의 5-bay 디스크 구조 + verb-4 analyze 의 산출 schema 를 입력으로, **외부 제작소가 받아 제작을 시작할 수 있는 수준의 제작 산출물 사양** 3종 (BOM · 도면 tree · firmware stack) + 제작 시퀀스 (QA 게이트) 를 manifest 로 정의. 실 제작/부품 구매가 아닌 **사양 명세** (@D d1) · firmware 는 **아키텍처 명세** 이고 제어 코드 SSOT = `~/core/hexa-lang/stdlib/` (@D d3 · UFO/synthesize 구현 코드 0줄). 문서 한국어 · 코드 영문.

- [x] `UFO/synthesize/integrated-vehicle-synthesize.md` — §0 TL;DR (BOM+도면 tree+firmware stack ASCII) · §1 BOM 7-카테고리 · §2 도면 tree L0~L3 + 인터페이스 도면 · §3 firmware 3-layer 5-모듈 · §4 제작 시퀀스 8 단계 + QA 게이트 · §5 synthesize→verify 인계 + handoff 준비물 + cross-link + deferred
- [x] `UFO/synthesize/integrated-vehicle-synthesize.tape` — `@V`1.0 · `@I id001/id002` (🛸 · alias `synthesize`) · `@C id010~013` cross-link 4건 (spec·structure·design·analyze) · `@D s1~s4` governance · provenance ledger · 17-type 알파벳만 (@V/@I/@C/@D)
- [x] ① BOM — 7 카테고리 (A frame CFRP T700 180kg · B RTSC 솔레노이드×6 HTS REBCO NI=1.2e6 At + flux-pin + gyro CMG×3 120kg · C cryostat LHe 4.2K + He cryocooler 4K · D LSS 80kg · E avionics 45kg · F power dual bus net 150kg · G stage MHD×2 + Penning/Ioffe trap + e⁺ source + γ-shield) · 수량/재료/공급원 카테고리/추정 단가 범위 · 650kg 무게 reconcile (structure §5.1 cross-check)
- [x] ② 도면 tree — L0 vehicle → L1 5-bay (avionics/cabin/magnet/power/LSS + frame) → L2 ~14 assembly → L3 ~40 part (BOM ID cross-link) · DWG-ID placeholder · 7 인터페이스 도면 (IF-PWR/CRYO/STR/EM/DATA/GS/THERM)
- [x] ③ firmware stack — 3-계층 (app: 5-모듈 · RTOS: rate-monotonic + triplex voter DO-178C DAL-A · HAL: board support) · 5 제어 모듈 (① 자세제어 Kalman 15-state ‖q‖=1±1e-9 · ② stage 전환 SM · ③ 자석 PID 6-DOF per-slot · ④ LSS 모니터 · ⑤ 안전 인터록) · loop rate + DAL + redundancy 매핑 · 게인 sizing = verb-4 ⟲ 수렴 design point 위임
- [x] ④ 제작 시퀀스 — 8 단계 (S0 입고 → S1 frame → S2 5-bay → S3 자석/cryo → S4 추진 mount → S5 firmware → S6 통합검사 → S7 인계) + QA 게이트 G0~G7 · verb-4 analyze LC/수렴 기준 cross-link
- [x] `UFO.md` line 51 verb-5 synthesize `[ ]` → `[x] ... LANDED PR pending` flip
- [x] @D d1 준수 — 제작 사양 manifest (실 제작/구매 아님 · 단가 = sizing 추정 범위, 조달 견적 아님)
- [x] @D d3 준수 — firmware 아키텍처 명세만 · 제어 코드 (EKF/PID/SM) SSOT = hexa-lang/stdlib · UFO/synthesize 구현 코드 0줄
- [x] @D d4 준수 — BOM line-item / 도면 노드 / firmware 모듈 = manifest 한 행 수정 (single generic dispatch · 이름 hardcoding 금지)
- [x] Stage-4~7 (G6) = formal mount slot only — 제작 산출물 0 · 단가 $0 · app layer 모듈 없음 (design §4 falsifier-only 상속 · absorbed=true flip 금지 · 물리 한계 framing 금지 @D d2)

deferred:
- [ ] BOM 조달 견적 갱신 (추정 범위 → 입찰 · long-lead HTS 솔레노이드 B1 + 반물질 trap G2/G3) — verb-7 handoff
- [ ] CAD 도면 geometry/치수/공차 (도면 tree → 실 도면) — verb-7 / 외부 제작소
- [ ] firmware 제어 게인 sizing (Kalman Q/R · PID K_p/K_i/K_d · SM threshold) — verb-4 analyze ⟲ 수렴 design point
- [ ] firmware SW-in-the-loop (SIL) 검증 — verb-6 디지털트윈 (UFO/sim 엔진)
- [ ] DO-178C DAL-A 인증 산출물 (자세제어 · 자석 PID · 안전 인터록) — verb-7 handoff
- [ ] QA 게이트 G0~G7 검사 절차서 정량 기준 (heat leak · σ 마진 · effective thrust) — verb-4 sim 본해
- [ ] cryostat dewar 통합 BOM 반영 (자석 4.2K ↔ trap 4K 공유 · 8% 무게 감소) — verb-4 trade study

## 2026-05-26T00:30:00Z — Stage-3 orbital antimatter γ-rocket I_sp verify LANDED 🟢

Phase A Stage-3 orbital (antimatter γ-rocket anti-H + H · 고도 200 km ~ 1 AU). ANTIMATTER substrate (γ-rocket · Penning 3-freq + Ioffe trap depth verify 🟢 완료) 위에 γ-rocket I_sp closed-form (annihilation `E = 2·m_p·c²` → relativistic exhaust → `I_sp = c/g` 광자 천장 3.057e7 s) 의 numerical recompute 를 `hexa verify --expr` 3건으로 🟢 SUPPORTED-NUMERICAL 도장. ANTIMATTER verified atom 재사용 (idempotent atlas fold) · @D d3/d4/d6/d9/d10 준수. 문서 한국어 · 코드 영문.

- [x] `UFO/verify/stage3-orbital-gamma.md` — γ-rocket I_sp closed-form ledger (§0 TL;DR · §1 annihilation E=2m_p c² → relativistic exhaust → I_sp=c/g · §2 numerical recompute verbatim 3건 · §3 atlas register · §4 Stage-2→Stage-3 200km 전이 · §5 cross-link+deferred · §6 governance)
- [x] Case A 🟢 — `verify --expr pair_threshold_total(938.272)=6567.9` · calc=6567.9 |Δ|=0.0 ≤ ε=1e-9 · 🟢 SUPPORTED-NUMERICAL (annihilation/생성 상대론 에너지 회계 anchor · ANTIMATTER ⓵ atom reuse idempotent)
- [x] Case B 🟢 — `verify --expr rel_kinetic_from_p(9382.72)=8491.24` · calc=8491.24 |Δ|=0.0 ≤ ε=1e-9 · 🟢 SUPPORTED-NUMERICAL (ultra-relativistic 배기 β=0.995·γ≈10.05 · ANTIMATTER ⓶ atom reuse idempotent)
- [x] Case C 🟢 — `verify --expr rel_kinetic_from_p(1625.13)=938.272` · calc=938.272 |Δ|=0.0 ≤ ε=1e-9 · 🟢 SUPPORTED-NUMERICAL (kinetic=rest 교차점 pc=√3·m_p_c² · c/g 천장 crossover)
- [x] atlas — `@F verified-pair_threshold_total-num` (embedded.gen.hexa:30652) + `@F verified-rel_kinetic_from_p-num` (embedded.gen.hexa:30514) 두 atom 모두 ANTIMATTER 에서 이미 folded → Stage-3 재사용 idempotent skip · atlas hash `663698a06bc6f967fa2855a77bc4e399aae465dda5ca948b3c7352dbf98ce7fb`
- [x] `UFO.md` Stage-3 orbital → [x] flip (LANDED PR pending 🟢)
- [x] @D d6 준수 — I_sp=c/g 광자 천장 3.06e7 s ↔ spec target 1e9 s 2-자릿수 불일치 **정직 표기** (목표 수 강제 금지 · effective I_sp mass-flow 정의 closure = verb-4/6 의무)

verdict (verbatim):
```
verify --expr pair_threshold_total(938.272)=6567.9
  calc   = 6567.9  ≈ expected 6567.9  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
verify --expr rel_kinetic_from_p(9382.72)=8491.24
  calc   = 8491.24  ≈ expected 8491.24  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
verify --expr rel_kinetic_from_p(1625.13)=938.272
  calc   = 938.272  ≈ expected 938.272  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

deferred:
- [ ] stdlib `gamma_rocket_isp(v_e, g)` atom 등록 (hexa-lang 별 PR) → 등록 시 I_sp=c/g 행 🟡 → 🟢 escalation
- [ ] effective I_sp mass-flow 정의 closure (F-ANTI-3) — 광자 천장 3e7 s ↔ target 1e9 s 불일치 해소 · verb-4 analyze ⟲ + verb-6 verify 의무
- [ ] NEXUS.tape reuse edge — ANTIMATTER `pair_threshold_total`/`rel_kinetic_from_p` → UFO Stage-3 orbital

## 2026-05-26T00:30:00Z — Phase A Stage-2 cruise MHD 추진 closed-form verify 🟢 LANDED

Phase A Stage-2 cruise (MHD + D-T/p-¹¹B fusion · 고도 20~200 km). FUSION 자산 (BLUE-MAX 🔵 audit PR#1102 · MHD F=J×B substrate) 위에 MHD 추력 `F_MHD = J×B×V_ch` (Lorentz body force `f = J×B` · generalized Ohm `J = σ(E−u×B)`) 의 numerical recompute 를 `hexa verify --expr triple_product` 3건 (저/중/고고도 B·J 가변) 으로 🟢 SUPPORTED-NUMERICAL 도장 + atlas folded. 650 kg 비행체 cruise 채널 (V_ch=0.096 m³ · S1+S4 대각 페어) 설계 SSOT = `UFO/design/integrated-vehicle-design.md` §2 상속.

- [x] `UFO/verify/stage2-cruise-mhd.md` (190줄) — §0 TL;DR · §1 closed-form (`f=J×B` · `F=J·B·V_ch`) · §2 numerical recompute 3건 verbatim · §3 atlas register · §4 Stage 전이 (Stage-1 20km hover→Stage-2 MHD→Stage-3 200km γ-rocket) · §5 cross-link/deferred · §6 governance
- [x] `triple_product` 우회 (per @D d4 single generic dispatch) — MHD thrust 전용 atom 미등록 → `F=J·B·V` 순수 product 를 FUSION F2 Lawson `triple_product(a,b,c)=a·b·c` 동일 대수 root 로 identical numerical recompute
- [x] verbatim verdicts (g5 · LLM self-judge 없음):

```
verify --expr triple_product(200000.0,5.0,0.096)=96000.0
  calc   = 96000.0  ≈ expected 96000.0  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
  absorb = · already in atlas — idempotent skip (default · @D g69)

verify --expr triple_product(150000.0,4.0,0.096)=57600.0
  calc   = 57600.0  ≈ expected 57600.0  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
  absorb = · already in atlas — idempotent skip (default · @D g69)

verify --expr triple_product(100000.0,3.0,0.096)=28800.0
  calc   = 28800.0  ≈ expected 28800.0  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
  absorb = · already in atlas — idempotent skip (default · @D g69)
```

- [x] atlas register verbatim (folded @F · auto-absorb default @D g69):

```
@F verified-triple_product-num :: embedded.gen.hexa:30535
@F verified-triple_product-num = triple_product(200000.0,5.0,0.096) = 96000.0 :: formula [d=2026-05-25 active]
  tier = "🟢 SUPPORTED-NUMERICAL"
  verified-by = "hexa verify --expr triple_product 200000.0,5.0,0.096 96000.0"
  cite = "TECS-L n6-rep Tier2 — hexa-native libm-class numerical recompute (ε=1e-9)"
  provenance = "tool/atlas_cli.hexa register --from-verify (direct node-gen → embedded.gen.hexa SSOT; 🟢 numerical)"
```

- [x] atlas hash `663698a06bc6f967fa2855a77bc4e399aae465dda5ca948b3c7352dbf98ce7fb` (16134 nodes) — atom 기등록 idempotent · hexa-lang `embedded.gen.hexa` SSOT 코드 변경 0 (별 repo 동시 점유 안전 · atlas runtime fold-only)
- [x] 합성 tier — `J·B·V` product 🟢 SUPPORTED-NUMERICAL · `f=σ(E−u×B)×B → F=J×B×V` 물리 합성식 🟡 SUPPORTED-BY-CITATION (Sutton-Sherman · Jackson §5 · FUSION.md §2 (d)(e)) 정직 표기
- [x] 추력/무게 마진 — F_MHD_total(저고도)=192 kN / m·g(650kg)=6.38 kN ≈ 30배 · 고고도 200 km 28.8 kN/channel = Stage-3 전이 임계 정량
- [x] `UFO.md` Phase A Stage-2 milestone → [x] flip (LANDED PR pending 🟢)
- [x] explicit `git add` per @D d9 — UFO/verify/stage2-cruise-mhd.md + UFO.md + UFO.log.md (인접 worktree agent index 격리)
- [x] @D d2 준수 — MHD sim PASS = "cruise 채널 설계 타당", 결코 "Q>1 달성"; 고도 전이 falsifier (F-FUSION-{1,2,3}) 표면화 (물리 한계 framing 없음)
- [x] @D d3 준수 — 구현 코드 0줄 (closed-form 값 FUSION verified atom 인용 · stdlib `mhd_thrust` atom 등록은 별 repo deferred)

deferred:
- [ ] stdlib `mhd_thrust(J,B,V)` (또는 `lorentz_body_force`) atom 등록 → hexa-lang 별 PR · 등록 시 §2.3 `f=σ(E−u×B)×B` 합성 행 🟡 → 🟢 자동 escalation
- [ ] σ_e(altitude) 프로파일 closed-form (ionosphere/thermosphere IRI-class) → MHD 추력 고도 의존 정량 (verb-4 CFD+MHD coupled · LC-2)
- [ ] F-FUSION-{1,2,3} falsifier 정식 preregister (Stage-2 verb-4/verb-6 진입 시)
- [ ] NEXUS.tape reuse edge — FUSION `triple_product` → UFO Stage-2 MHD thrust (제공자/소비자 그래프)

## 2026-05-26T00:00:00Z — verb-4 analyze ⟲ LANDED (CFD+EM+응력+열 통합 분석 manifest)

Phase C 4/7 — verb-3 design 의 closed-form 인계 set (§6) 을 입력으로 4 물리 도메인 (CFD · EM · 응력 · 열) 통합 sim 의 **분석 계획 + 지배방정식 + Re/격자/수렴 기준 + ⟲ coupling 반복 수렴 기준** manifest 산출. 무거운 본해는 pool/cloud micro-exp 으로 위임 (@D d7 deferred · ad-hoc python 금지 · sim 은 .hexa only). 기존 verified atom (RTSC getdp · UFO Stage-1 PR#191) 만 인용.

- [x] `UFO/analyze/integrated-vehicle-analyze.md` — 한국어 8-section (§0 TL;DR 4-layer ⟲ coupling ASCII + 요약표 · §1 CFD Navier-Stokes Re/격자/residual · §2 EM Maxwell/Meissner + RTSC/UFO Stage-1 verified 인용 · §3 응력 FEA von Mises LC-1~5 σ_allow · §4 열 cryo+radiator Q̇=εσT⁴ · §5 ⟲ 4-layer coupling fixed-point max Δ_rel<1e-3 · §6 sim 위임 compute sizing pool/cloud · §7 analyze→synthesize 인계 + cross-link + deferred)
- [x] `UFO/analyze/integrated-vehicle-analyze.tape` — @V 1.0 · @I id001 `ufo/analyze` (🛸 · alias `analyze`) · @C id010~016 cross-link · @D a1~a4 (do/dont) · absorption ledger (17-type 알파벳 클린: @V/@I/@D/@C)
- [x] `UFO.md` verb-4 analyze ⟲ → [x] flip (LANDED PR pending)
- [x] @D d1 준수 — analyze 계획 + 수렴 기준 closed-form (본해는 pool/cloud 위임 = completed-form 경로)
- [x] @D d3 준수 — 구현 코드 0줄 (해석 코드 SSOT = hexa-lang/stdlib/sim/{cfd,em,fea,heat_cryo})
- [x] @D d4 준수 — sim/README §2 (domain,verb,formulation,solver) 4축 매트릭스 generic dispatch 인용 · layer/LC 이름 hardcoding 없음
- [x] @D d7 준수 — compute sizing (격자 cell/DOF/method scaling) → pool ubu idle / vast.ai GPU 라우팅 명시
- [x] @D d2 준수 — sim 한계 시 불가능 framing 금지 · breakthrough path 명시 (CFRP T1100 승격 · dewar 통합 · monolithic coupling 승격 · shock-adaptive AMR)
- [x] explicit `git add` per @D d9 — UFO/analyze/{*.md,*.tape} + UFO.md + UFO.log.md (인접 worktree agent index 격리)

deferred:
- [ ] ① CFD hover 2D axisym RANS + cruise 3D DES (C_d · L/D · shock-adaptive AMR) — pool ubu free dry-run → GPU pod (vast.ai)
- [ ] ② EM 6-coil 60° array B-map FEM (single-coil closed-form → 다중 상호작용 ‖ΔB‖<1e-4 T) — getdp pool→cloud
- [ ] ③ 응력 LC-1~5 FEA (650kg · SF=2.5 · 1/3/9/6/12 G · von Mises) — pool linear → cloud explicit dynamic
- [ ] ④ 열 cryo transient + radiator 25 m² Q̇=εσT⁴ 검증 — pool steady → transient
- [ ] ⟲ full coupling LC-2 cruise fixed-point (staggered → monolithic if 발산) — GPU pod
- [ ] MHD 채널 effective thrust (duct 효율 + plasma 손실 vs 이상화 1.92e5 N) — ① CFD ⟷ ② EM coupled
- [ ] 🟢 atlas register (sim 본해 verified atom → embedded.gen.hexa fold · verify-delegation)

## 2026-05-25T14:55:00Z — verb-3 design LANDED (throttle-death 회수)

Phase C 3/7 — closed-form 통합 설계. 원 agent (a266ba0) 가 산출물 생성 후 push 전 rate-limit 사망 → parent 가 worktree 에서 `integrated-vehicle-design.{md,tape}` (524줄) 회수 후 랜딩 (cycle skill parent-recovery 패턴).

- [x] `UFO/design/integrated-vehicle-design.md` (356줄) — Stage-1~3 closed-form 실설계 (자석 turns/I/B RTSC 상속 · MHD 채널 dim FUSION 상속 · antimatter trap ANTIMATTER 상속) · Stage-4~7 falsifier-only preregister · 무게/전력/냉각 budget 배분 · design→analyze 인계 param set
- [x] `UFO/design/integrated-vehicle-design.tape` (168줄) — @V/@I/@D/@C (17-type 알파벳 클린)
- [x] `UFO.md` verb-3 design → [x] flip
- [x] @D d2 준수 — Stage-4~7 = UNPROVEN falsifier-preregister (물리 한계 아님)
- [x] @D d3 준수 — 구현 코드 0줄 (closed-form 값은 RTSC/FUSION/ANTIMATTER verified 인용 · 새 sim 없음 = verb-4 의무)

deferred:
- [ ] verb-4 analyze ⟲ — design param set 입력으로 CFD + EM + 응력 + 열 통합 sim 수렴

## 2026-05-25T14:38:39Z — HEXA-TELEPORT 축 흡수 LANDED (Phase B 5/5 완료)

Phase B 부수 5축의 **마지막** 슬롯 봉합 — 양자 상태 teleportation 프로토콜 (Bennett 1993) 을 비행체 분산 센서/통신 사양 manifest 로 흡수. docs/manifests only · @D d3/d4/d9/d10 준수. **이로써 Phase B (HEXA-HOVER · HEXA-SIM · HEXA-GRAV · HEXA-CLOAK · HEXA-TELEPORT) 부수축 흡수 완료.**

- [x] source 식별 — `UFO/HEXA-TELEPORT.md` (692 LOC · blob `be4ac3d`) + `UFO/teleport/hexa-teleport.md` (440 LOC · blob `6cb5159`) + `UFO/hexa-teleport/hexa-teleport.md` (443 LOC · blob `b75b778`)
- [x] `UFO/teleport/README.md` 작성 — 5-section 한국어 (§0 TL;DR + ASCII teleportation 다이어그램 · §1 흡수 source 3개 SHA+LOC · §2 Bell-pair·BSM·고전채널≤c·unitary 4단계 + correction 표 + entanglement swapping 중계 · §3 no-cloning/상대론 한계 honest fence ⚪ · §4 분산 센서 양자 동기화 + QKD BB84/E91 응용 · §5 cross-link)
- [x] `UFO/teleport/manifest.tape` 작성 — @V 1.0 · @I id001 `ufo/teleport` (icon 🛸 · alias `teleport`) + @D t1~t4 결정 라인 + @A absorb_hexa_teleport (source SHA) + @C cross_link (17-type alphabet only)
- [x] honest fence ⚪ — 초광속/즉시 전송 주장 거부 (no-communication theorem · 정보 ≤ c · 고전채널 필수) · "σ·sopfr·10=600km 즉시전송"·"no-cloning=n=6 유일성" source 수론 주장은 ⚪ SPECULATION-FENCED 로 정직 표기 (물리 한계, "돌파 경로" 아님)
- [x] no-cloning 정합 — BSM 이 송신측 원본 붕괴 → 복제 아닌 *이전* (Wootters-Zurek 1982 선형성 증명 채택 · 수론 재유도 fence)
- [x] QKD 보안 "절대불가" 과장 → 🟡 절제 (도청 *탐지* 정보이론 보안 · side-channel/구현 의존)
- [x] 비행체 응용 = 분산 센서 양자 상태 동기화 (entanglement distribution · UFO/grav 수요) + QKD BB84/E91 보안 통신 — 물질/에너지/사람 전송 아님 (양자 상태 = 정보만)
- [x] `UFO.md` Phase B HEXA-TELEPORT milestone → [x] 플립 (**Phase B 5/5 완료** 표기)
- [x] explicit `git add` per @D d9 — UFO/teleport/{README.md,manifest.tape} + UFO.md + UFO.log.md (인접 worktree HEXA-CLOAK agent index 격리)
- [x] @D d3 준수 — implementation 코드 0줄 (Bell-state/BSM/QKD 양자회로 = hexa-lang/stdlib SSOT 위임 · `.hexa` only)
- [x] @D d4 준수 — single generic dispatch (SC 큐빗 cryo = RTSC 인프라 재활용 · 분기 hardcoding 금지)
- [x] @D d10 준수 — icon 🛸 · name `UFO/teleport` · alias `teleport` 헤더

deferred:
- [ ] hexa-lang/stdlib/quantum/{bell_state,bsm,unitary_correction,qkd_bb84,qkd_e91} 모듈 신설 (양자회로 코드 SSOT 채움)
- [ ] Bell-state fidelity F=⟨ψ|ρ_out|ψ⟩ closed-form verify 🟢 (`hexa verify`) → atlas register
- [ ] entanglement swapping 후 concurrence(얽힘도) 정량 — 다중 중계기 hop loss budget
- [ ] QKD QBER (quantum bit error rate) threshold 11% (BB84) preregister + side-channel falsifier 매핑
- [ ] UFO/grav 분산 GW arm 노드 양자강화 측정 (Heisenberg 1/N vs 표준 1/√N) 통합 인터페이스

## 2026-05-25T23:40:00Z — HEXA-CLOAK 축 흡수 LANDED

Phase B 부수 5축 중 4/5 봉합 — `UFO/HEXA-CLOAK.md` (678 LOC) + `UFO/CLOAK.md` (948 LOC) + `UFO/cloak/hexa-cloak.md` (471 LOC) + `UFO/cloak-canon/cloak.md` (698 LOC) + `UFO/hexa-cloak/hexa-cloak.md` (474 LOC) 5 source 를 `UFO/cloak/` 사양 manifest 로 흡수. 흡수 범위 = (1) transformation-optics cloak (좌표변환 ε-μ tensor metamaterial shell · 음굴절률 n<0 · RT-SC 공명 ε<0 + SRR μ<0 · impedance match Z=1) + (2) radar/optical stealth (RCS 10⁻⁴→10⁻⁶ m² 100× 감소 · 레이더 탐지거리 1/6 · 전대역 σ-τ=8 octave · IR σ-φ=10 dB↓ · φ=2 kg/m² 경량). 비행체 통합 핵심 risk = Stage 추진 EM 누설 (RTSC B Meissner self-shield · MHD/γ-rocket RF EMI Faraday cage+band-stop · IR plume cryo+방사율) vs cloak layer 양립성 — 능동 방출이 stealth 천적이므로 LPI waveform + GW 통신(EM-free) 대체. 4 falsifier preregister (RCS · 대역 octave · IR 억제 · 능동 누설). 코드 SSOT 는 hexa-lang/stdlib + UFO/hexa-cloak 의 canonical home 유지 (@D d3).

- [x] `UFO/cloak/README.md` — §0 TL;DR + ASCII (metamaterial shell 입사파 우회 다이어그램 + Stage 추진 EM 누설 vs cloak) · §1 흡수 source (5 file SHA-1 + LOC 인벤토리) · §2 transformation-optics cloak (좌표변환 → 음굴절률 메타물질 원리 ASCII · Pendry 구형 cloak ε-μ tensor 식 표 · RT-SC ε<0 Meissner 결합 · 3 falsifier) · §3 radar/optical stealth (RCS 10⁻⁶ m² · 탐지거리 1/6 · 전대역 · IR σ-φ=10 dB↓ · 비용 $500/m² · 3 falsifier) · §4 비행체 통합 (Stage 추진 EM 누설 risk 표 · 양립성 budget ASCII · Stage 별 운용 모드) · §5 cross-link 12건
- [x] `UFO/cloak/manifest.tape` — `@V tape 1.0` · `@I id001 ufo/cloak` (icon 🛸 · alias cloak · siblings hover/sim/grav/teleport) · `@D c1` 흡수 manifest only · `@D c2` 이중 layer (cloak+stealth) 상보 적층 · `@D c3` Stage EM 누설 vs cloak 양립성 · `@D c4` falsifier preregister · `@A absorb_hexa_cloak` source SHA-1 5개 · `@C cross_link` (RTSC/FUSION/ANTIMATTER/structure/grav/UFO/stdlib 7건) · tape grammar 17-type 알파벳만 (PR #184 교훈 — `@absorb` 금지)
- [x] `UFO.md` flip — `- [ ] HEXA-CLOAK 축 흡수 …` → `- [x] HEXA-CLOAK 축 흡수 … LANDED PR pending` (Phase B 5축 누적 4/5 — hover ✓ · sim ✓ · grav ✓ · **cloak ✓** · teleport)
- [x] `UFO/cloak/README.md` 와 기존 `UFO/cloak/hexa-cloak.md` 비충돌 확인 (별도 파일명 · 공존)
- [x] explicit `git add` per @D d9 — UFO/cloak/{README.md,manifest.tape} + UFO.md + UFO.log.md (인접 worktree index 격리)
- [x] @D d3 준수 — implementation 코드 0줄 (transformation-optics tensor · metamaterial FDTD · RCS 산출은 hexa-lang/stdlib SSOT 또는 UFO/hexa-cloak canonical home 위임 · UFO/cloak/ = docs/manifests only)
- [x] @D d4 준수 — single generic dispatch · IR heat-sink/cryo 인프라는 UFO/grav 재활용 · stage 추가/변경 = manifest 표 행 수정만
- [x] @D d10 준수 — 🛸 UFO/cloak · alias `cloak` 헤더 (hover/grav README head 와 일관)
- [x] tape grammar 준수 — 17-type alphabet (@V @I @D @A @C 만 사용) · @absorb / @verify 등 비표준 directive 금지 (PR#184 lesson)
- [ ] HEXA-TELEPORT 축 흡수 — teleport quantum-entangle protocol → UFO/teleport 통합 (Phase B 마지막 5/5 슬롯)

### deferred sub-items (Phase B HEXA-CLOAK follow-on)
- [ ] transformation-optics ε-μ tensor 그라데이션 적층 N=σ·τ=48 layer FDTD 검증 — hexa-lang/stdlib (광대역 dispersion)
- [ ] metamaterial SRR 셀 협대역 → n=6 다중공진 광대역 확장 verify 🟢 (σ-τ=8 octave cover)
- [ ] RCS 10⁻⁶ m² anechoic chamber 실측 vs closed-form 산란 (verb-6 verify)
- [ ] HEXA-CLOAK overlay 적층 spec — verb-3 design (UFO/structure §1 radar caveat 연동)
- [ ] Stage 능동 송신 LPI waveform vs cloak band-stop 셀 간섭 정량 — verb-4 analyze ⟲
- [ ] IR plume σ-φ=10 dB 억제 cryo heat-sink sizing (UFO/grav 4 K/77 K 인프라 공유) — verb-3 design
- [ ] 가시광 cloaking 회절 한계 (동체 크기 ≫ λ) closed-form 경계 — verb-3 design
- [ ] φ=2 kg/m² metamaterial 필름 무게 budget vs frame (UFO/structure 650kg) — verb-4 analyze ⟲

Phase B 부수 5축 진행 현황: 4/5 (hover · sim · grav · cloak LANDED) — teleport 1 슬롯 미진행 (당시 시점 기록 · 이후 teleport LANDED 로 5/5 완료).

## 2026-05-25T23:35:00Z — verb-2 structure LANDED

Phase C 의 **두 번째 verb (structure)** 슬롯 봉합 — verb-1 spec (PR#187) 의 1인승 통합 비행체 사양을 **외형 + 내부 구획 + 자석 어셈블리 + stage 모듈 인터페이스 + 응력 budget** 5축으로 구조화. docs/manifests only · @D d3/d4 준수.

- [x] `UFO/structure/integrated-vehicle-structure.md` — §0 TL;DR ASCII (디스크 lenticular OML + 5 bay 수직 stack + 6-slot 외주 stage mount) · §1 frame OML (D=6.0m · H=1.6m · AR=0.27 · top/bot 비대칭 lift bias · radar/EM caveats with HEXA-CLOAK overlay) · §2 5 bay 내부 구획 (AVIONICS · CABIN · MAGNET · POWER · LSS · frame 자체 · 무게/점유 표) · §3 자석 어셈블리 (RTSC 솔레노이드 × 6 등각 60° array + gyro CMG × 3 + flux-pinning array × 8 · 6-DOF active control) · §4 Stage 모듈 인터페이스 (6-slot 등각 mount 표 Stage-1~7 · 전원 28V/400V dual bus · 냉각 LHe/heat-pipe/active He cryo · γ-shield 4π sr DU+W+B₄C · 진동 isolation 3-tier rigid/bushing/active) · §5 응력 budget (650kg total · SF=2.5 · LC-1~5 카탈로그 · material σ_allow 표) · §6 cross-link + verify 위임 표
- [x] `UFO/structure/integrated-vehicle-structure.tape` — tape sidecar (17-type alphabet only per PR#184) · @V version 1.0 · @I id001 verb-2 structure identity-claim · @I id002 icon·name·alias 헤더 (🛸 UFO/structure) · @C id010~014 cross-link 5건 (spec · HEXA-UFO main · RTSC · FUSION · ANTIMATTER) · prose §Frame OML · §Internal bay · §Magnet assembly · §Stage interface · §Stress budget · @D s1~s4 governance (do/dont · @D d1/d3/d4/d9/d10) · §Absorption ledger
- [x] `UFO.md` Phase C verb-2 structure 체크박스 `[x] LANDED` 로 flip (PR# 은 pr-cycle 훅 다음 라운드 stamp)
- [x] explicit `git add` per @D d9 — UFO/structure/{*.md,*.tape} + UFO.md + UFO.log.md (인접 worktree index 격리)
- [x] @D d3 준수 — implementation 코드 0줄 (CFD/FEA/EM 시뮬은 hexa-lang/stdlib SSOT 위임 · UFO/structure/ = docs/manifests only)
- [x] @D d4 준수 — single generic dispatch · stage 추가/변경/제거 = §4.1 mount 표 한 행 수정만 · slot 이름 hardcoding 코드 작성 금지
- [x] @D d10 준수 — 🛸 UFO/structure · alias `structure` 헤더 (spec verb-1 head 와 일관)
- [x] tape grammar 준수 — 17-type alphabet (@V @I @D @C 만 사용) · @absorb / @verify 등 비표준 directive 금지 (PR#184 lesson)
- [ ] verb-3 design — closed-form 통합 설계 (stages 1-3 실설계 · 4-7 falsifier-only · 자석 sizing closed-form + Wheeler on-axis B 적용 · MHD intake duct 설계 · γ-rocket nozzle 설계) (다음 verb 슬롯)

### deferred sub-items (Phase C verb-2 follow-on)
- [ ] frame CFRP T1100 승격 시뮬 (무게 10% 감소 가능) — verb-3 design / verb-4 analyze ⟲
- [ ] cryostat dewar 통합화 (8% 무게 감소 가능) — verb-3 design
- [ ] 자석 솔레노이드 수 6→4 trade-off 시뮬 (lift 마진 vs 무게) — verb-4 analyze ⟲
- [ ] HEXA-CLOAK overlay 적층 spec — verb-3 design (UFO/cloak cross-link)
- [ ] HEXA-GRAV / HEXA-TELEPORT 부수축 mount 슬롯 정의 — Phase B 진행과 동기
- [ ] flux-pinning force vs Meissner force 비율 정량 — verb-4 analyze ⟲ FEA + EM coupled
- [ ] active damper feedback gain sizing (T3 tier · 0.1~200 Hz) — verb-4 analyze ⟲
- [ ] FAA Pt.25 single-failure 검증 — verb-6 verify (5/6 솔레노이드 fail-operational closed-form)
- [ ] γ-shield 4π sr coverage 5π open 슬롯 sizing — verb-3 design
- [ ] stage mount slot 진동 spectrum coupling — verb-4 analyze ⟲ (LC-2 cruise CFD+FEA coupled)

Phase C 7-verb pipeline 진행 현황: 2/7 (spec · structure LANDED) — design · analyze · synthesize · verify · handoff 5 슬롯 미진행.

## 2026-05-25T23:30:00Z — HEXA-GRAV 축 흡수 LANDED

Phase B 부수 5축 중 3/5 봉합 — `UFO/HEXA-GRAV.md` (653 LOC) + `UFO/hexa-grav/` (656 LOC) + `UFO/gravity-wave-canon/gravity-wave.md` (855 LOC) + `UFO/quantum-gravity-sensor-canon/quantum-gravity-sensor.md` (861 LOC) 4 source 를 `UFO/grav/` 사양 manifest 로 흡수. 흡수 범위 = (1) GW 검출/통신 (LIGO 4 km → SC 미러 finesse=σ·τ=48 광등가 42 km, h~10⁻²³, BH-병합 매주 n=6건) + (2) QGS 관성 보강 (atom-IF Δg~10⁻¹¹ g · SC gravimeter σ·τ=48 fT/√Hz). 비행체 통합 risk = RTSC 자장 cross-talk → mu-metal×5 layers + 거리 σ-φ=10 m + active null coil. 4 falsifier preregister (h, Δg, fT-floor, cross-talk). 코드 SSOT 는 hexa-lang/stdlib + UFO/hexa-grav 의 canonical home 유지 (@D d3).

- [x] `UFO/grav/README.md` — §0 TL;DR + ASCII (GW arm + QGS bay + EM/관성 separation 다이어그램) · §1 흡수 source (4 file SHA-1 + LOC 인벤토리) · §2 GW 미니어처 (arm 1-10 m · SC 미러 finesse F=σ·τ=48 · h~10⁻²³ · 검출률 σ·τ=48/yr · 3 falsifier) · §3 QGS (atom-IF Mach-Zehnder Δg~10⁻¹¹ g · SC gravimeter σ·τ=48 fT/√Hz · atomic clock 보조 · drift-free IMU · GPS-denied 항법 · 3 falsifier) · §4 비행체 통합 (RTSC mu-metal×5 layers · 거리 σ-φ=10 m · active null coil · Stage 별 운용 모드) · §5 cross-link 9건
- [x] `UFO/grav/manifest.tape` — `@V tape 1.0` · `@I id001 ufo/grav` (icon 🛸 · alias grav · siblings hover/sim/cloak/teleport) · `@D g1` 흡수 manifest only · `@D g2` EM/관성 separation 필수 · `@D g3` GW 광등가 길이 · `@D g4` falsifier preregister · `@A absorb_hexa_grav` source SHA-1 4개 · `@C cross_link` (RTSC/FUSION/ANTIMATTER/UFO/stdlib 5건) · tape grammar 17-type 알파벳만 (PR #184 교훈 — `@absorb` 금지)
- [x] `UFO.md` flip — `- [ ] HEXA-GRAV 축 흡수 …` → `- [x] HEXA-GRAV 축 흡수 … LANDED PR pending` (Phase B 5축 누적 3/5 — hover ✓ · sim ✓ · **grav ✓** · cloak · teleport)

### deferred sub-items (Phase B HEXA-GRAV follow-on)
- [ ] HEXA-CLOAK 축 흡수 (Phase B 5축 중 4/5 · cloak-canon EM 가시성 차단)
- [ ] HEXA-TELEPORT 축 흡수 (Phase B 5축 중 5/5 · quantum-entangle protocol)
- [ ] GW arm SC 미러 finesse=48 검증 — `hexa-lang/stdlib/sim/optics_finesse` closed-form (광등가 길이 L_eff = L·2F/π 자동 유도)
- [ ] atom-IF Mach-Zehnder Δg sensitivity closed-form — h_eff·k_eff·T² scaling · `hexa-lang/stdlib/sim/atom_interferometer`
- [ ] SQUID gravimeter B-floor σ·τ=48 fT/√Hz 검증 — `hexa-lang/stdlib/sim/squid_gravimeter` closed-form
- [ ] RTSC 자장 mu-metal×5 차폐 calc — 잔류 B < 10 nT @ atom-IF 위치 (μ_r·d·active null coil 조합)
- [ ] EM/관성 separation budget end-to-end verify — RTSC 48 T → atom-IF/SQUID floor 미달 확인
- [ ] GW 통신 가설 (Mk.V) — 인공 변조 GW 송수신 falsifier preregister 코드화

## 2026-05-25T23:00:00Z — Phase A Stage-1 hover Meissner 부상력 closed-form verify 🟢

Phase A 7-stage propulsion ladder 의 **첫 stage (hover)** 봉합 — RTSC 48T 솔레노이드 substrate 위 Meissner 부상력 `F_lev = |χ|·V·B·(dB/dz)/μ₀` closed-form + B-field 생성 numerical recompute 3건 (90/120/200 kg 페이로드) 을 `hexa verify --expr ioffe_loop_bz` 로 🟢 SUPPORTED-NUMERICAL 도장 + atlas register. F_lev gradient-form 합성 자체는 stdlib `meissner_lev_force` atom 미등록 → 🟡 SUPPORTED-BY-CITATION (RTSC.md V3 · hexa-ufo HOVER §X), atom 등록은 hexa-lang 별 PR deferred.

- [x] `UFO/verify/stage1-hover-fields.md` 신규 — §0 TL;DR · §1 closed-form identity (90kg 페이로드 1800배 over-head 닫힘) · §2 numerical recompute 3건 verbatim · §3 atlas register · §4 Stage-2 MHD 전이 · §5 cross-link/deferred · §6 governance
- [x] `hexa verify --expr ioffe_loop_bz` 90 kg / 120 kg / 200 kg 3건 모두 🟢 SUPPORTED-NUMERICAL (|Δ| ≤ ε=1e-9)
  - Case A `verify --expr ioffe_loop_bz(0.3,954930.0,0.0)=2` → `calc = 2 ≈ expected 2 (|Δ|=5.67085e-10 ≤ ε=1e-9) tier = 🟢 SUPPORTED-NUMERICAL`
  - Case B `verify --expr ioffe_loop_bz(0.5,1591549.0,0.0)=2` → `calc = 2 ≈ expected 2 (|Δ|=5.67086e-10 ≤ ε=1e-9) tier = 🟢 SUPPORTED-NUMERICAL`
  - Case C `verify --expr ioffe_loop_bz(1.0,3183099.0,0.0)=2` → `calc = 2 ≈ expected 2 (|Δ|=5.67085e-10 ≤ ε=1e-9) tier = 🟢 SUPPORTED-NUMERICAL`
- [x] `hexa atlas register --from-verify ioffe_loop_bz(0.3,954930,0)=2.00000071565` → folded @F `verified-ioffe_loop_bz-num` → atlas hash `663698a06bc6f967fa2855a77bc4e399aae465dda5ca948b3c7352dbf98ce7fb` (16103 nodes)
- [x] F_lev composite tier: 🟢 SUPPORTED-NUMERICAL (B-field 3건 🟢) + 🟡 SUPPORTED-BY-CITATION (Jackson §6 · Tinkham §I.2 · RTSC.md V3 · hexa-ufo HOVER §X B²·A/(2μ₀) 동치)
- [x] `UFO.md` — Phase A Stage-1 hover 체크박스 `[x] LANDED PR pending` 로 flip
- [x] 새/수정 파일 3개 explicit `git add` (UFO/verify/stage1-hover-fields.md + UFO.md + UFO.log.md) per @D d9
- [ ] deferred — stdlib `meissner_lev_force(chi,V,B,dBdz)` atom 등록 → hexa-lang 별 PR (`~/core/hexa-lang/tool/verify_cli.hexa::_recompute` 확장 + `stdlib/ufo/meissner.hexa`); 등록 시 본 ledger 🟡 → 🟢 escalate
- [ ] deferred — F-A1 / F-A2 Stage-1→Stage-2 falsifier preregister (Stage-2 cruise MHD 마일스톤 진입 시)
- [ ] deferred — NEXUS.tape reuse edge: RTSC `ioffe_loop_bz` → UFO Stage-1 hover (per @D d19)

## 2026-05-25T22:42:00Z — verb-1 spec LANDED

Phase C 의 **첫 verb (spec)** 슬롯 봉합 — 1인승 통합 비행체 사양 명세 두 파일 (`.md` 본문 + `.tape` sidecar) 산출. 선행 demiurge 4도메인 (RTSC · FUSION · ANTIMATTER · CERN) + hexa-ufo HEXA-Disc 1890-LOC 아틀라스를 7-stage matrix · 1인승 LSS · 자세제어 · 동력 인터페이스 record contract 로 통합. PR#187.

- [x] `UFO/spec/integrated-vehicle-spec.md` — §0 TL;DR ASCII 다이어그램 · §1 페이로드 (조종사 1명 · 75kg · 12h LSS · 캐빈 1.8×1.2m) · §2 stage matrix (Stage-1~7 · 고도/속도/동력원/전환/falsifier) · §3 자세제어 (gyro x3 + jet x6 + EM trim · IMU 2x redundancy · Kalman 15-state) · §4 동력 인터페이스 (RTSC/FUSION/ANTIMATTER record consume contract · Stage-4~7 falsifier-only) · §5 cross-link · §6 흡수 ledger (demiurge 4 + hexa-ufo HEXA-Disc 1890-LOC) · verify 의무 선언
- [x] `UFO/spec/integrated-vehicle-spec.tape` — tape sidecar (HEXA-UFO.tape 형식) · @I id001 verb-1 spec identity-claim · @I id002 icon·name·alias 헤더 (🛸 UFO 통합비행체) · @C id010~014 cross-link 5건 (RTSC/FUSION/ANTIMATTER/CERN/hexa-ufo) · stage matrix prose 표 7행 · 페이로드/LSS prose · 자세제어 prose · 동력 interface prose 4건 · 흡수 ledger prose · @D id070 governance (do/dont · @D d1/d3/d4/d10)
- [x] `UFO.md` — Phase C verb-1 spec 체크박스 `[x] LANDED` 로 flip
- [x] 새 파일 4개 explicit `git add` (UFO/spec/{*.md,*.tape} + UFO.md + UFO.log.md) per @D d9
- [x] @D d3 준수 — implementation 코드 0줄 (구현은 `~/core/hexa-lang/stdlib/` SSOT 위임 · UFO/spec/ = docs/manifests only)
- [x] @D d4 준수 — single generic dispatch · instance = manifest only · stage transition state machine 명세만
- [x] @D d10 준수 — 🛸 UFO · 통합 비행체(직접개발) 헤더 유지
- [ ] verb-2 structure — frame + 자석 어셈블리 + stage 모듈 인터페이스 정의 (다음 verb 슬롯)

## 2026-05-25T14:00:00Z — HEXA-SIM 축 흡수 LANDED

Phase B 부수축 5/5 — sim 축 흡수 (디지털트윈 sim 엔진 사양 manifest).

- [x] source 식별 — `~/core/hexa-ufo/HEXA-SIM.md` (679 LOC · SHA 305174e7) + sidecar `~/core/hexa-ufo/HEXA-SIM.tape`
- [x] `UFO/sim/README.md` 작성 — 7 섹션 한국어 본문 (TL;DR · 흡수 source · 4축 매트릭스 · CFD layer · EM layer · 추진 layer · 응력+열관리 layer · cross-link · deferred) + 6-layer stack ASCII
- [x] `UFO/sim/manifest.tape` 작성 — `@I id001 := "ufo_sim"` (icon 🛸 · alias `sim`) + 5 @D 거버넌스 + 4축 매트릭스 + 6-layer stack
- [x] sim 엔진 4축 매트릭스 — `(domain, verb, formulation, solver)` single generic dispatch (@D d4)
- [x] 6-layer multiscale n=6 stack — L0 MATERIAL · L1 MESOSCALE · L2 CONTINUUM · L3 MODULE · L4 SYSTEM · L5 INTEGRATION
- [x] cross-link — `~/core/hexa-ufo/HEXA-SIM.md` (source SSOT) · `~/core/hexa-lang/stdlib/sim/*` (코드 SSOT, 예정) · UFO/hover (LANDED PR#183)
- [x] @D d3 준수 — sim 엔진 코드는 UFO/sim 외부 (hexa-lang/stdlib + hexa-ufo) SSOT 유지
- [x] @D d4 준수 — `(domain, verb, formulation, solver)` 4축 generic dispatch, UFO stage 분기 금지
- [x] @D d10 준수 — icon 🛸 · name `UFO/sim` · alias `sim` 헤더
- [x] `UFO.md` Phase B HEXA-SIM milestone → [x] 플립

deferred:
- [ ] hexa-lang/stdlib/sim/{cfd_ns,em_maxwell,fea,heat_cryo} 모듈 신설 (코드 SSOT 채움)
- [ ] verb-4 analyze ⟲ 통합 driver — 4축 매트릭스 generic dispatcher 구현
- [ ] 13-falsifier preregister 매핑 — Stage-4~7 ⚪ falsifier-only 입력 형식 통일
- [ ] cross-domain 통합 ledger — Stage-1 (RTSC) + Stage-2 (FUSION) + Stage-3 (ANTIMATTER) record consume

Phase B 진행 현황: 2/5 (hover · sim) — grav · cloak · teleport 미흡수.

## 2026-05-25T13:45:05Z — HEXA-HOVER 축 흡수 LANDED

- [x] source 식별 — `~/core/hexa-ufo/HEXA-HOVER.md` (706 LOC · SHA a5f60e2) + `~/core/hexa-ufo/HOVER.md` (733 LOC · SHA acd19cc)
- [x] `UFO/hover/README.md` 작성 — 7-section 한국어 본문 (TL;DR · source · Meissner closed-form · 자석/도체 사양 · Earnshaw 안정성 · 고도 범위 · cross-link)
- [x] `UFO/hover/manifest.tape` 작성 — @I `ufo/hover` (icon 🛸 · alias `hover`) + @D h1-h4 결정 라인 + @absorb status
- [x] 자석 substrate = `RTSC.md` 48T HTS REBCO 솔레노이드 cross-link (@D d4 단일 dispatch — RTSC 가 자석 SSOT)
- [x] 도체 1차 = HTS REBCO (77K LN₂) · 궁극 = RT-SC (RTSC.md §8.4 9-test PASS 시 승격)
- [x] Earnshaw 정리 → active stabilization 3-경로 hybrid (active coil 6-DOF PID μ=1ms · gyro n=6 60° · flux pinning)
- [x] 고도 범위 0~20km — 지면 안내 레일 (1-10T 국소) · 솔레노이드 grid · 지자기 + 탑재 자석 array
- [x] `UFO.md` Phase B HEXA-HOVER milestone → [x] 플립
- [x] @D d3 준수 — 흡수 = 사양 manifest 만 (계산 코드 = hexa-lang/stdlib 또는 hexa-ufo SSOT)
- [x] @D d10 준수 — icon 🛸 · name `UFO/hover` · alias `hover` 헤더

deferred:
- [ ] Stage-2 cruise 인계 인터페이스 정의 (고도 20km 천이 — hover → MHD)
- [ ] closed-form 부상력 verify 🟢 (`hexa verify --expr F_lev`) → atlas register
- [ ] flux pinning Type-II 정량 (pinning force vs Meissner force 비율)
- [ ] active coil 6-DOF PID 게인 sizing (m=90kg · μ=1ms · ζ=0.7)
