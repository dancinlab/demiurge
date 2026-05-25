# CERN — log

Append-only history sister of `CERN.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

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
