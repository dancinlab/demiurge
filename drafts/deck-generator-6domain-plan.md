---
slug: deck-generator-6domain
mode: auto
created: 2026-05-29
target: hexa-lang stdlib (deck generator · g61)
---

# 빵틀 — 6 도메인 generic deck generator

## task brief

도메인별 deck/input(.in·.json·.cif·.v·.pdb·.nw) 손작성 반복을 제거하는 generic
generator. `gen_deck(domain, spec)` 골격 + 도메인 emitter 6종. hexa run(문자열 emit,
빌드 불요 — verify_cli bessel 버그 무관). g20(parameterize)·g4(dispatch)·g61(stdlib SSOT).

## locked decisions

- 범위: 6 도메인 generic 전부 (B)
- 골격: gen_deck(domain, spec) → 도메인 emitter dispatch (if-else 또는 lookup)
- emitter: rtsc/nuclear = 완전 구현(입증) · material/chem/chip/bio = best-effort(도메인 stdlib 포맷 참조)
- 실행: hexa run (문자열 emit · 빌드 불요)
- 위치: stdlib/deck/gen.hexa (골격) + 도메인 emitter (stdlib/<domain> 또는 한 파일)
- 회귀검증: rtsc emitter 로 파일럿 deck(MgBeH8/CaAuH3) 재생성 → 기존 origin/main deck 과 diff 일치

## 도메인 emitter 명세

| 도메인 | input | spec | 참조 |
|---|---|---|---|
| rtsc | QE .in 3종 + RUNBOOK | {anchor, 치환, 압력_GPa, q_grid} | 파일럿 deck (exports/rtsc/decks/MgBeH8) |
| nuclear | nuclide .json | {Z, N, Q_α} | n12/n13_funnel top_k schema |
| material | .cif/.poscar/.xyz | {구조 fetch / 조성} | stdlib/material aflow/cod |
| chem | NWChem .nw / .xyz | {molecule, method} | stdlib/chem pubchem |
| chip | verilog .v / .lib | {module, params} | stdlib/chip chip.hexa |
| bio | .pdb / .cif | {seq / struct} | stdlib/bio bio.hexa |

## next-action checklist

- [ ] 골격 gen_deck.hexa — domain dispatch + spec 검증
- [ ] rtsc emitter (완전) — QE .in 3종 emit (d15·nosym·recover·max_seconds·preflight q-grid 자동)
- [ ] nuclear emitter (완전) — nuclide .json emit (Q_α cite)
- [ ] material/chem/chip/bio emitter (best-effort) — 각 도메인 input template emit
- [ ] 회귀검증 — rtsc emitter 로 MgBeH8/CaAuH3 재생성 → origin/main deck diff 일치
- [ ] thin caller — demiurge 가 `hexa run gen_deck rtsc <spec>` → exports/decks emit
- [ ] ship — stdlib/deck/ PR (hexa-lang) + 사용 예시

## completion criteria

- gen_deck(domain, spec) → 6 도메인 input emit 동작
- rtsc/nuclear 완전 (회귀검증 PASS) · 나머지 4 best-effort (확장 슬롯)
- hexa run 동작 (빌드 불요)
- stdlib SSOT (g61) · 다음 deck wave 부터 손작성 제거
