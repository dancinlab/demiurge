---
slug: demi-cli-surface-parity
mode: auto
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-05-29
surfaces: hexa demi (hexa-lang side) + sidecar demi (sidecar plugin) → demiurge CLI core
trigger: QFORGE L5 5/5 완성 후 예약 발사분
---

# demi-cli-surface-parity — plan

## task brief
demiurge CLI에는 두 진입로가 있다 — `hexa demi …`(hexa로 부르는 길)와 `sidecar demi …`(sidecar
플러그인으로 부르는 길). 두 입구가 **같은 명령에 다르게 반응**하면 사용자가 혼란스럽다(help 텍스트
불일치 · 에러 문구/포맷 차이 · exit code 불일치 · 플래그 동작 차이 · 한쪽에만 있는 서브커맨드 등).
이 작업은 두 입구를 **audit → 동작 불일치를 열거 → 한 코어로 수렴**시켜 help/에러/exit/플래그가
일치하도록 만든다. discovery-first(먼저 두 입구의 실체를 실측) — `hexa demi`가 전용 서브커맨드인지
래퍼인지, `sidecar demi`가 무엇을 호출하는지 확정한 뒤 실제 갈리는 부분만 고친다.

## locked decisions (AUTO 1:1:1:1)
- Q1 무엇: 두 입구의 **사용감·에러·일관성 PARITY** — help 텍스트 · 에러 문구/포맷 · exit code · 플래그 동작이 두 입구에서 동일하도록. 새 기능 추가가 아니라 일관성/UX/에러 정합.
- Q2 표면: ① `hexa demi`(hexa-lang 측 — `hexa`가 demiurge를 부르는 경로; 서브커맨드/래퍼 실체 확인) ② `sidecar demi`(sidecar 플러그인/미러 커맨드가 demiurge를 부르는 경로). 둘 다 **같은 demiurge 코어로 라우팅**(d4 generic)되게 하고, 실제로 갈리는 곳만 픽스. 이미 일치하는 표면은 정직하게 skip.
- Q3 순서: **DISCOVERY-FIRST**. 먼저 두 입구를 실측(`hexa demi --help`/서브커맨드 dispatch · `sidecar` 미러 · Swift `cockpit/Sources/DemiurgeCLI/main.swift` 코어) → 구체적 불일치 목록 작성 → 그 불일치만 픽스. `hexa demi`의 실체(전용 서브커맨드 vs 부재 vs 래퍼)부터 확정.
- Q4 검증: 표면별 빌드+스모크. Swift(DemiurgeCLI)=Mac `swift build` · hexa 측 = pool(ubu-1, login shell) · `@ci_gate`/스모크로 "같은 입력 → 두 입구 동일 출력/에러/exit" 대조. g5 해당 시 verbatim.
- Q5 실행: repo별 **분리 PR**(hexa-lang ↔ demiurge) · 각 <200줄(g4) · 한쪽에 진짜 불일치가 없으면 그 표면은 정직하게 out-of-scope 보고.

## next-action checklist
- [ ] DISCOVERY: `hexa demi`의 실체 확인 — `hexa demi --help` / hexa 디스패처에서 demiurge 라우팅 위치 grep (hexa-lang stdlib · `hexa` 서브커맨드 테이블). 전용 서브커맨드인가, 래퍼인가, 부재인가?
- [ ] DISCOVERY: `sidecar demi`의 실체 — sidecar 플러그인/미러 커맨드가 demiurge를 어떻게 부르는지 (sidecar repo / mirror 커맨드 정의)
- [ ] DISCOVERY: demiurge 코어 = Swift `cockpit/Sources/DemiurgeCLI/main.swift` — verb/플래그/에러/exit code surface 목록화
- [ ] AUDIT: 같은 명령(예: `discover`, `synth`, `--version`, 잘못된 verb, 누락 인자)을 두 입구에 넣어 help/에러문구/exit code/플래그 동작 **차이 매트릭스** 작성
- [ ] FIX: 차이나는 항목만 한 코어로 수렴 (에러 문구 통일 · exit code 통일 · help 정합 · 플래그 동작 정합). d4 generic — 입구별 하드코딩 분기 금지
- [ ] VERIFY: 표면별 빌드(Swift=Mac · hexa=pool) + 스모크 "동일 입력 → 동일 거동" 대조; verdict verbatim
- [ ] SHIP: repo별 분리 PR(hexa-lang · demiurge) · <200줄 · Korean commit · `gh pr create` · 머지 확인 · `sidecar sync`
- [ ] 한쪽 불일치 없으면 → 그 표면 정직 out-of-scope 보고 (억지 픽스 금지)

## completion criteria
- 두 입구(`hexa demi` · `sidecar demi`)가 같은 명령에 **동일한 help/에러문구/exit code/플래그 동작**을 보임 (실측 차이 매트릭스의 갈리던 항목이 수렴).
- 픽스가 단일 코어 경로 기반(d4) — 입구별 분기 하드코딩 없음.
- 표면별 스모크 PASS (같은 입력 → 동일 거동). PR(들) 머지. 기존 demiurge/hexa 동작 무회귀.
- 진짜 불일치가 없던 표면은 "already-consistent / out-of-scope"로 정직 보고(억지 변경 금지).

## qa-results
