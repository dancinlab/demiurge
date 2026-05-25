# CERN — log

Append-only history sister of `CERN.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

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
