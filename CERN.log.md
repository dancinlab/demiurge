# CERN — log

Append-only history sister of `CERN.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-26T10:25Z — Stage 5 Sternheimer + AZ shell + Bloch + Barkas 본해 완료 (#1296 + #243) · mean Δ 30% closure (정직 부분)

S5 에이전트(hexa-lang PR #1296 substrate + demiurge PR #243 parity export 둘 다 MERGED) — Stage 4 측정한 23.5% 갭에 hexa-native 보정 4종 추가 후 재측정. mid-plateau 거의 닫힘, low-βγ AZ 캘리브 한계로 잔여 surface.

- [x] **substrate 본해** (hexa-lang #1296) — `stdlib/kernels/mc_transport/transport_kernel.py` 에 `sternheimer_density_delta` · `shell_correction_c` (AZ) · `bloch_correction_l2` · `barkas_correction_l1` 추가, `bethe_bloch_dedx(stage=3|5)` 게이팅 · `stdlib/cern/bethe_bloch_stopping.{py,hexa}` Stage 5 wrapper + `evaluate_stage5()` + `selftest_stage5()` · `STERNHEIMER_COEFFS` 테이블(Al/Cu/W/Pb · PDG/Sternheimer 1984) · antiproton z=−1 부호반전
- [x] **28-point parity 재측정** (demiurge #243 export `exports/cern/verify/2026-05-26T10-19-26Z/bethe_bloch_stage5_corrections_parity.json`) — Stage 4 의 Geant4 값 재사용(Geant4 자체는 불변, closed-form bracket 만 변경, JSON honest tag)
- [x] **closure 측정**: **mean |Δ| 6.25% → 4.39% (30% closure)** · max 23.55% → 21.64% (8% — Cu@1MeV) · total |Δ| 29.7% reduction · mid-plateau highlights: Cu@100MeV 1.17%→0.02% (98.6%) · W@30MeV 4.86%→−0.43% (91.1%) · Pb@100MeV 2.61%→−0.04% (98.4%) · W@10MeV 71.5% · Pb@10MeV 78.9%
- [x] **verify atom 4×🟢** (모두 VERBATIM) — `sternheimer_delta_al_bg046` (|Δ|=1.22e-19 ≤ 1e-9 libm) · `shell_correction_cu_bg255` (|Δ|=5.21e-6 round-tolerant 1e-5) · `bloch_l2_beta046_z1` (|Δ|=1.43e-7 round-tolerant 1e-6) · `barkas_l1_cu_bg046_pbar` (|Δ|=2.71e-16 libm)
- [x] **honest residuals** (NO ad-hoc tuning · 교과서 공식 그대로) — Cu@1MeV 21.64%: AZ shell 이 βγ=0.046 에서 out-of-calibration (η<0.05 linear taper-to-0) · Pb@1MeV −2% 과잉: Stage 3 의 lucky 1.1% near-match 는 두 누락 보정 사이 sign-cancellation 이었음 · 300-1000 MeV 약간 over: 교과서 Bloch/Barkas (1.202/1.29) vs Geant4 tabulated L1/L2 미세차
- [x] **d2 breakthrough paths** (Stage 6, above-lane) — ① ICRU-49 / Lindhard-Sørensen 저에너지(η<0.13) → ~15-22% Cu/Al@1-3 MeV 잔여 닫음 ② Andersen-Ziegler 1989 LEAR pbar L1 데이터 → 보편-curve log-normal fit 대체 ③ Mott z²α/β Coulomb → 고-Z(W·Pb) 작지만 비무시 ④ Pb@1MeV 는 closed-form 의 물리적 floor (Geant4 parametrized table 에 도달 불가, 인정)
- [x] **CERN.md reconcile** — §4 line146 Stage 4 entry 정돈 + Stage 5 entry 신규 추가 · §1 verb-map VERIFY (◐→✓) · §2.1 gate + Geant4 cell + Stage 6 next 행 · §4.2 verify cell map ASCII · downstream Geant4 행

## 2026-05-26T09:45Z — Stage 4 Geant4-MC parity 측정 완료 (#241) · absorbed=false-with-gap (정직)

D 에이전트(PR #241) 가 Geant4 11.04-patch-01 (conda-forge `geant4` 11.3.2 pkg) on ubu-1 환경에서 28-point Bethe-Bloch Stage 4 parity 측정. PDG eq.34.5 closed-form ↔ Geant4-MC(보정 포함) Δ% 매핑.

- [x] **28-point parity grid** — Al·Cu·W·Pb × KE {1,3,10,30,100,300,1000} MeV. **max |Δ|=23.55% (Cu @ 1 MeV) · mean |Δ|=6.25%**
- [x] **보정 지배 매핑**(βγ 척도) — βγ<0.3 (1-3 MeV) → shell 보정 (9-24%, PDG §34 매뉴얼 값 정확 일치) · βγ~0.3-1 (30-100 MeV) → Bethe-Bloch plateau (~1%) · βγ>1 (300 MeV-1 GeV) → density-effect onset (<1%)
- [x] **mean-excitation I 일치 확인** — PDG closed-form 의 I 값(Al·Cu·W·Pb) = Geant4 ICRU 37 정확 일치 → I 가 Δ 원인 아님 (보정 항이 원인)
- [x] **Geant4 nuclear stopping = 0** (antiproton, ICRU 49 는 ion 만)
- [x] **absorbed=false-with-measured-gap** (정직) — Δ는 버그 아닌 누락 보정(shell·density·straggling·nuclear)의 *물리적 크기* (closure-is-physical-limit). Stage 3 closed-form 은 선언된 mid-βγ 영역에서 ~1% 일치 그대로 🟢. Stage 5(Sternheimer 밀도효과 + Bloch+Barkas 껍질보정 hexa-native 본해)가 갭 닫는 next-step (above-lane new spec)
- [x] **d2 돌파 — G4EmCalculator EM-loss 테이블 lazy 빌드 segfault** → `BeamOn(0)` after `Initialize()` 로 강제 구성(3-iteration 진단). 메모리 등재 [[reference_geant4_dedx_lazy_tables]]
- [x] **export** `exports/cern/verify/2026-05-26T09-36-53Z/bethe_bloch_stage4_geant4_parity.json` (28 points, oracle=Geant4 11.04-patch-01 · gate_type=sim_wall_measurement · g63 no atlas register)
- [x] **CERN.md reconcile** — §4 L145 [x] + §1 verb-map VERIFY · §2.1 gate/Geant4 cell · downstream Geant4 행 모두 Stage 4 측정값 반영

## 2026-05-26T09:30Z — /cycle 라운드: xsuite analyze cell + Geant4/particle 설치(벽 돌파) + §4 ledger reconciliation

CERN /cycle 2-agent fan-out 결과 land + §4 ledger 정합. A(xsuite) 정상 완료, C(Geant4) rate-limit 사망 → parent 가 checkpoint 회수해 포그라운드 land.

- [x] **A — xsuite analyze cell** (#236) — 7 TeV FODO full twiss-table 특성화 (β_x/y=83.6/81.5m · Q_x=Q_y=0.00424 · 자연색수차 −0.00424 · D_x=0 dipole-free · momentum-compaction≈0). synthesize headline(β_x_max·Q_x)과 cross-consistent. GATE_OPEN(toy textbook FODO · measured-ring 아님). 환경: xtrack 0.104.1 은 py3.9 import 실패(PEP-604) → python3.12 우회(메모리 등재)
- [x] **C — Geant4 + particle 설치·HEXA-PORT 등록** (#239) — particle 0.26.2 (PDG mass/charge 검증) + Geant4 11.3.2 conda-forge(pool ubu-1 env `geant4` py3.12) · smoke PASS(RunManager 구성+NIST G4_Si/G4_WATER I-값 PDG정확+G4ParticleTable). **`geant4_pybind` trampoline segfault 벽 돌파**(@D d2) — 선행 A3 `pip geant4-pybind` pybind11 소유권 segfault 를 conda-forge 공식 빌드(ABI-매칭)로 우회. HEXA-PORT P8 오라클 등재
- [x] **rate-limit 회수** — C 가 PR 직전 throttle 사망(3 checkpoint commit push됨) → parent rebase(stale-base xsuite/UFO 삭제 동반 교정) → fresh 브랜치 land #239
- [x] **§4 ledger reconciliation** — stale flip: line 150 blowout `[ ]`→`[x]`(#235) · line 146 xsuite `[ ]`→`[x]`(#236) · line 144 Geant4 설치 `[ ]`→`[x]`(#239) · line 147 stub `[x]`(substrate 본해는 별 cycle 명시) · §1 verb-map(ANALYZE ✓xsuite · VERIFY ◐Geant4) · §2.1 Geant4 cell · downstream Geant4 행(tooling 벽 돌파 → Stage 4 in-scope 승격)
- [ ] **Bethe-Bloch Stage 4** — Geant4-MC 4-보정 parity → 이제 **runnable**(Geant4 #239 설치), 다음 라운드 dispatch (in-scope 승격 — tooling 벽 해소)

## 2026-05-26T08:30Z — 탁상가속기 2-D 비선형 blowout PIC sweep 완료 (무료 CPU $0 · downstream 당겨 완료)

`## downstream` 의 "2-D blowout PIC (GPU)" 항목을 GPU 없이 **무료 pool CPU(ubu-1)** 로 당겨 완료. FBPIC 2-D cylindrical, a0 강도 사다리 3점 — 모두 6000 step.

- [x] FBPIC 2-D deck `wakefield_pic_2d.py` — Nm=2 azimuthal, moving window v=c (LWFA 필수), a0={0.5,2.0,4.0} sweep
- [x] GPU provisioning 전(全) pool 고장(`hexa cloud rent` no-op) → **무료 CPU 로 pivot** ($0 spent · g64). ubu-1 ~0.7s/step
- [x] **blowout 사다리 재현** — E_z = {1.70, 73.62, 405.64} GV/m = {0.018, 0.766, 4.218} × E_0(96.16):
  - a0=0.5 → diffraction-limited (z_R~79µm ≪ 1.5mm, self-guiding 없음 → E_z ≪ E_0). 인위 saturation 없음 정직 anchor
  - a0=2.0 → blowout 진입 (상대론적 self-focusing → bubble → E_z ~ 0.77 E_0)
  - a0=4.0 → deep blowout (E_z = 4.2 E_0, cold wavebreaking 초과 — closed-form parity 기대 안 함, a0≥2 caveat)
- [x] ledger `exports/sweep/cern-blowout-pic-2026-05-26/ledger.json` (g65 typed surface) + candidate JSON 3종
- [x] **정직 노트** — sim-wall 측정값(PIC field) = verify atom 아님, atlas N/A (g63). 🟢 anchor `wakefield_e0_gv_m` 가 등재 atom; PIC E_z 는 그에 대한 상대 측정. linear cross-check 는 a0=0.5 가 E_0 를 *재현 안 함*(deck docstring 의 naive 기대가 부정확 — E_0 는 wavebreaking 최댓값이지 weak-driver 場 아님). 방어 가능한 cross-check = blowout 전이 재현(✓)
- [ ] design-grade 잔여 (여전히 GPU sweep) — grid/particle convergence · 3-D · a0-별 spot 최적화

## 2026-05-26T05:00Z — BLUE-MAX 탐색 결론: 🔵 N/A (연속 물리량 = 🟢 천장) · 4 atom 🟢 verified · verify=로컬직접 교훈

g69 BLUE-MAX(🔵 algebraic-root pair) 를 CERN wakefield 에 적용 시도 → **🔵 도달 불가가 정직한 결론**. verify-native closure 는 🟢 SUPPORTED-NUMERICAL 에서 완성 (= 원래 tabletop closure 의 천장이 옳았음).

- [x] wakefield verify atom 4종 모두 **🟢 SUPPORTED-NUMERICAL** verify (로컬 Mac 직접, g5 verdict verbatim):
  - `wakefield_e0_gv_m(1.0)=96.159` · `wakefield_lambda_um(1.0)=33.389` (기존)
  - `wakefield_omega_p_sq(1.0)=3.18261e+27` (sqrt-free 대수근) · `wakefield_e0_lambda_product(1.0)=3210.7` (n18-invariant 상수) — 신규 2종 · 4종 모두 `|Δ|≤5e-13` · atlas 등록됨
- [x] **🔵 BLUE-MAX 물리적 N/A 확정** — verify CLI 의 🔵 SUPPORTED-FORMAL 는 정수/symbolic `_recompute`(int) 경로 전용. 연속 EM 물리량(√·무리수 상수곱)은 `_recompute_float` → 무조건 🟢. sqrt-free 대수근(omega_p_sq)을 추가해도 float→🟢 태그. g69 의 🔵 pairing 은 number-theory/정수구조 도메인(antimatter 양자수 등)에만 적용 — CERN wakefield 같은 연속물리엔 적용 불가. **🟢 ≠ 제작불가** (verify tier ⊥ 물리 buildability — LWFA 는 BELLA 8 GeV 등 실재)
- [x] 비싼 교훈 (메모리 박음 [[reference_hexa_verify_host_mini]]) — `hexa verify --expr` 는 **로컬 Mac 직접 Bash 포그라운드**가 정답. pool(ubu-1 segfault·ubu-2 무네트워크/stale·mini-pool stale) + route 훅으로 보내면 "toolchain 붕괴" 오진. INBOX #1137 의 "origin/main 회귀" 주장은 ubu-1 호스트-특정으로 정정 필요(로컬 정상)
- [x] 신규 2 atom hexa-lang land (verify_cli.hexa + calc_dispatch.hexa)

## 2026-05-25T13:30Z — **CERN 도메인 tabletop 기준 구현 완료** (closure decision)

- [x] **completion criterion 정의** — RF 축 4-cell closed-form/algorithm closure + tabletop(plasma-wakefield) 축 cold-linear closed-form + 1-D linear PIC parity. 이것이 demiurge public-surface clean-room scope 안에서 자율적으로 도달 가능한 최대치. 사용자 결정 (2026-05-25, "테이블탑 기준으로 완료")
- [x] CERN.md @goal 갱신 — tabletop completion criterion 명시. @scope 라인 추가 (scope=tabletop, downstream=wet-lab/external/GPU heavy)
- [x] 미달 milestone → `## downstream` 으로 재분류 — Geant4-MC Stage 4 (wet-lab equivalent · pybind11 segfault wall) · measured-ring optics (sourced deck · clean-room risk) · 비선형 blowout PIC (2-D GPU heavy). 셋 다 *도메인 미완성*이 아니라 **scope 외부 dependency** 로 honest 분류
- [x] A3 (Geant4-MC PoC 1점) 백그라운드 stop — A3 가 land 직전 도달한 발견: `geant4_pybind` trampoline ownership 충돌 + G4 physics-list 순서 segfault. 즉 Geant4-MC 본해는 정말로 wet-lab급 깊이 (pybind11 + G4 C++ ownership) 라 demiurge clean-room scope 외 확정. 이 발견 자체가 closure 결정의 근거
- [x] 22:28 ScheduleWakeup 다음 라운드는 자연 종료 — open milestones=0 + no `## deferred` → /cycle depletion test PASS → loop terminates cleanly
- [x] 잔여 라운드 활동: 없음. 도메인 board = 7/7 ✓ (RF 4-cell + tabletop 2-cell + closure marker)

**왜 이게 정직한 완료인가** (g3): RF 축의 LHC급 measured-ring 과 Stage 4 Geant4-MC 는 *외부 wet-lab + 상용 toolchain* 없이는 demiurge 자체 cell 로 닫을 수 없는 본질적 외부성. clean-room scope 안에서 tabletop 축이 RF 축 closed-form 과 동등한 deepest closure 라는 것이 본 도메인의 demiurge-completable surface 의 max. wet-lab equivalent (별 도메인/별 시설) 가 채워지면 그 결과는 record 로 *소비*만 함 — 도메인 boundary 와 정합

## 2026-05-25T13:00Z — /cycle 라운드 1 reconcile: PIC 1-D linear parity 흡수 + C orphan worktree 정리

- [x] **hexa-lang PR #1088 흡수** — `feat(stdlib/cern): plasma-wakefield linear-PIC parity (FBPIC) Δ=3.56% on top of cold-linear closed-form` (Agent C가 rate-limit-kill 직전 land 했으나 CERN.md flip + log entry는 못함 → reconcile)
- [x] FBPIC 1-D linear PIC ⨯ cold-linear closed-form parity Δ=3.56% — `stdlib/cern/plasma_wakefield.hexa` +124-4
- [x] CERN.md L15 milestone → `[◐]` partial (1-D linear 완료 · 비선형 blowout 잔여)
- [x] hexa-lang orphan worktree 정리 — `/private/tmp/hexa-wakefield-pic-60521 [feat/cern-wakefield-pic-parity]` (C가 finalize 단계에서 죽어 cleanup 못한 잔재)
- [x] /cycle 라운드 1 결과: A·C 둘 다 ~130min · 50-67 tool use 후 rate-limit-kill (server-side, `not your usage limit`). B(#161) + C(#1088) 작업 본체는 land 완료, A는 미완 → narrow scope retry 라운드 발사
- [ ] L10/L11 Geant4-MC + Bethe-Bloch Stage 4 — A2 narrow retry (particle pip install + Geant4 가용성 probe만, parity 시도 X)
- [ ] L15 비선형 blowout PIC — 별 cycle (GPU heavy, micro-exp 적합)

## 2026-05-25T10:40Z — 나머지 4-verb honest stub 스캐폴드 (specify · architect · design · handoff)

- [x] 타입드 record 4종 추가 — `Models/Cern{Specify,Structure,Design,Handoff}Record.swift` (R3 cockpit-consumer 디코드 타겟, `CernSynthRecord`/`FirmwareSpecifyRecord` 패턴 동형). 공통 정직 gate 필드: `measurement_gate=GATE_OPEN` · `absorbed=false` · `scope_caveats[0]="stub — <real impl 이 할 일>"` · `accel_mechanism`(CERN.md §1.5 축 선행) · domain-specific headline (specify=target field/energy/luminosity · structure=FODO/TME/DBA+cell count · design=MAD-X/Xsuite deck slot · handoff=TDR deliverable-slot 매니페스트)
- [x] 디스패치 등록 = **@D d4 manifest-driven** — 새 producer class 0개 · `ActionDispatch` 분기 0개. `domains/cern.demi` 의 `[cell.{specify,structure,design,handoff}]` 4 cell 을 UNWIRED→STUB 로 정비 (`python_candidates` + `accel_mechanism=rf_cavity` + `stub — <real impl>` caveat 3종/cell). 런타임 경로: `(verb,"cern")` 미하드코딩 → `ActionDispatch` default arm → `CellrunDispatch.run("cern", verb)` → `cellrun.hexa cern <verb>` → `cern.demi` cell 읽음
- [x] honest gap 유지 — substrate `stdlib/cern/{specify,structure,design,handoff}.py` (hexa-lang d3 SSOT) 미작성이라 cellrun rc=2 (script-missing) honest-skip. record 는 substrate 가 채울 디코드 타겟일 뿐, 가짜 physics 0 (g3)
- [x] cockpit `swift build` GREEN (Build complete! 29.6s · 신규 경고 0 · 기존 RealityKit actor-isolation 경고만)
- [x] 보드 갱신 — milestone L12 `[x]` · §1 verb 표 4 row (SPECIFY/ARCHITECT/DESIGN/HANDOFF → ◐ honest stub)
- [ ] substrate 본해 — `stdlib/cern/{specify,structure,design,handoff}.py` 작성 시 STUB→WIRED 승격 (hexa-lang repo, 별 cycle)

## 2026-05-25T09:25Z — plasma-wakefield cell 착수 (탁상가속기 첫 cell · 🟢 verified · landed)

- [x] `stdlib/cern/plasma_wakefield.hexa` 작성 — clean-room cold-linear wakefield closed-form (ω_p · λ_p · E_0 Dawson 1959 / Esarey RMP 2009), NOT a WarpX re-derivation
- [x] selftest 5/5 GREEN (canonical root ubu-1) — 값 핀 3 + 교과서 계수 교차검증 2 (E_0≈96·√n V/m · λ_p≈3.34e10/√n µm)
- [x] `tool/verify_cli.hexa` 확장 — `wakefield_e0_gv_m` · `wakefield_lambda_um` 2 atom → `hexa verify --expr` 둘 다 🟢 SUPPORTED-NUMERICAL (|Δ|=0.0 ≤ ε=1e-9)
- [x] land — `hexa-lang` PR #1007 MERGED (verify_cli.hexa hot-file 충돌 origin/main merge로 해소, penning+wakefield 양립)
- [x] CERN.md 보드 갱신 — milestone + §1.5 표 + §4 ledger 에 closed-form cell 완료 반영
- [ ] WarpX/FBPIC PIC 본해 (비선형 blowout) — closed-form scaling 위 다음 layer

## 2026-05-25T09:15Z — scope 결정: 탁상가속기 = CERN 가속 메커니즘 축

- [x] 탁상가속기(레이저-플라스마 LWFA/PWFA) 별도 도메인 여부 결정 → **CERN 안의 "가속 메커니즘" 축** (RF | plasma-wakefield | dielectric-laser)
- [x] CERN.md §1.5 가속 메커니즘 축 신설 — RF(현 cell) vs plasma-wakefield(탁상, WarpX/FBPIC) vs DLA · 하류 빔수송/검출기 공유 구조 ASCII
- [x] lazy-split 약속 명시 — plasma-wakefield cell 이 커지면 `LPA.md` 분리 (RTSC→NUCLEAR 선례) · record `accel_mechanism` 필드 선행
- [ ] `plasma-wakefield` cell 개시 (WarpX/FBPIC PIC 1-D wakefield) — 미착수

## 2026-05-25T09:00Z — domain init (CERN 도메인 정식 등록)

- [x] `/domain init CERN` — `CERN.md` + `CERN.log.md` 스캐폴딩
- [x] 기존 `exports/cern/` 작업 흡수 — verify(Bethe-Bloch) · synthesize(Xsuite FODO) · analyze(pylhe LHE) · stopping(11 stamp) 현황 정리
- [x] `@title` · `@goal` · 7 milestones 작성 (실제 export record + stdlib/cern Stage 상태 반영)
- [x] cell 별 정직 gate 명시 — verify=Stage3 GREEN/GATE_OPEN · synthesize=absorbed(알고리즘 closure 한정) · analyze=GATE_OPEN 영구
- [ ] Geant4 + `particle` 설치 → `cern + verify` Geant4-MC 본해 (현재 engine_tool_gap)
- [ ] Bethe-Bloch Stage 4 (Geant4-MC 4-보정 parity) → absorbed 판정

## 2026-05-25T13:00Z — Geant4 engine-tool probe (narrow retry)

- [x] `particle` 모듈 — local Mac `python3.13 -m pip install --user --break-system-packages particle` → `particle-0.26.2` 설치 성공
- [x] `particle` 모듈 — ubu-1 (pool) `pip install --user --break-system-packages particle` → 0.26.2 already-satisfied
- [x] Geant4 availability probe — `geant4_pybind` import OK on ubu-1 (no `__version__` attr but `import` succeeds); system `geant4-config` 없음 / `pip show geant4` 없음 → verdict = **AVAILABLE (pybind on ubu-1)**, local Mac은 미설치 (다음 라운드 cross-host dispatch 필요할 수 있음)
- [x] `demiurge action verify cern` 재실행 (local Mac, python3.13) — `exit=0`, `gate=OPEN absorbed=false caveats=4`, `record → cern_verify_record_20260525T125633Z`, `CERN_G4_RESULT {"ok": true, ..., "particle_version": "0.26.2", "python_version": "3.13.13", "rows": 28}`
- [ ] (이번 라운드 미시도) Stage 4 Geant4-MC parity Δ 측정 — 4-보정 본해 vs Bethe-Bloch closed-form → 다음 cycle
- [ ] (이번 라운드 미시도) L10 / L11 milestone flip — engine 통과는 했으나 closed-form parity 미확인 → 둘 다 `[ ]` 유지 (g3 honest)

**다음 라운드 hint**: (a) Stage 4 parity script 작성 — `bethe_bloch_stopping.py`가 이미 28-row CSV 생성하므로, closed-form Bethe-Bloch (M_p, β, γ, density correction δ) 와 row-by-row Δ ≤ tolerance 검증. (b) Geant4 backend가 Bethe-Bloch closed-form 그 자체인지 / 진짜 MC 인지 cell source `bethe_bloch_stopping.py` L233 근처 확인 (현재 `engine_tool_gap`만 보아 backend가 Geant4 wrapper인지 pure-Python 인지 불확실). (c) 본해가 closed-form wrap이면 cell rename / Stage 4 재정의 필요.
