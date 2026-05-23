# CLI+COCKPIT — log

Append-only history sister of `CLI+COCKPIT.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-25T02:00:00Z — LPA cycle 4 CLI 실증 (3rd reproduction)

- [x] `hexa --version` = 0.1.0-dispatch 작동 — NOREFLOW + ISR과 동일 환경
- [x] `hexa verify --expr sigma 6 12` → 🔵 SUPPORTED-FORMAL (number-theory sanity 재확인)
- [x] `hexa verify --expr ivw 3 1` → 🟠 INSUFFICIENT (biostat kernel 부재)
- [x] `hexa atlas stats` = 16,066 nodes · F=1,313 · ATLAS_HASH `6fae9277...` (NOREFLOW + ISR과 hash 동일)
- [x] `pool list` 실행 → compile error 재현 (V3a · V3c agent 보고와 일치)
- [x] LPA V3a/V3c agent 우회 = ssh direct (ubu-1 0.58s · ubu-2 0.054s) — 3rd cross-domain reproduction
- [x] LPA V2 agent → hexa-lang **PR #665 OPEN** (`inbox/notes/2026-05-24-lpa-ivw-mr-formula.md`) — biostat 5 fn 요청
- [x] CLI+COCKPIT.md LPA evidence section 추가 (NOREFLOW + ISR 표 패턴 확장)
- [x] cross-domain wall 누적 통계 — 17+ identity × 4 도메인 (LPA + ISR + DAPTPGX + HERPES) 동시 unblock 대기
- [ ] V2 atlas push agent 완료 대기 (in-flight)
- [ ] V3b · V4 · M8 cycle 완료 후 LPA tier ledger CLI+COCKPIT 최종 흡수

🔑 핵심 통찰 (LPA cycle 4 CLI evidence):
- **M5 ssh direct fallback 패턴 = 3-도메인 일관** (ISR · NOREFLOW · LPA) → 권장 표준화 후보
- **M6 biostat wall = 4-도메인 confirmed** (이전 ISR 2건 → 누적 4) → PR #665 merge 가치 강화
- **TTR domain 🔵 22건** = 이번 cycle 최고 사례 (hexa-bio 외부 도메인 적용성 입증)

## 2026-05-25T01:10:00Z — NOREFLOW CLI 실증 (hexa + demiurge dual)

- [x] `hexa verify --fence` ⚪ SPECULATION-FENCED verdict verbatim 확보 (NOREFLOW M2 metaphor 1건)
- [x] `demiurge cli list-domains` → 20 도메인 출력 (NOREFLOW · DAPTPGX · ISR · LPA · TTR · HERPES 미등록 = `bio` 산하 sub-domain 또는 신규 `cardio` 후보)
- [x] `demiurge cli action verify bio` → 7-verb dispatch 작동 ✓ · anima bridge record · GATE_OPEN · absorbed=false (d5 거버넌스 준수)
- [x] `demiurge cli list-decisions` → 0 (design.md SSOT D-number 미사용)
- [x] CLI+COCKPIT.md M6 surface 에 3 verbatim 부착 + upstream 후보 3건 명시
- [ ] cherry-pick(395ad4b) 진행 중 → commit 보류 (다른 세션 LPA conflict 해결 대기)
- [ ] upstream 후보: `cardio` 도메인 등록 + `list-claims` 명령 + `action verify --tier-report` flag

🔑 hexa verify · demiurge cli action verify · demiurge cli list-domains 3 surface 모두 작동 ✓ — M6 verify surface 실증 완료
🔑 NOREFLOW · ISR · DAPTPGX · LPA가 `$DOM:` 미등록 = demiurge cli upstream 기여 후보 (cardio 도메인 신규)

## 2026-05-25T03:30:00Z — ISR cycle 5 verify-phase contribution (CLI 직접 사용)

- [x] `hexa --help` 정찰 — top-level 80+ verbs
- [x] `hexa verify rubric` verbatim — 7-tier 색상 (🔵🟢🟡🟠🟠🔴⚪) 확인
- [x] `hexa verify --expr hill 3 5` → 🟠 INSUFFICIENT (bio kernel 부재 재현)
- [x] `hexa atlas stats` → 16066 nodes · hash `6fae9277...` · F 1313 · L 531 · P 455 · C 5763
- [x] `hexa atlas --help` — read 8 verbs + write (append-witness · register --from-verify --auto-pr · pr --staging)
- [x] inbox patch 2건 file → hexa-lang/inbox/patches/ (bio-verify-kernel-extension + pool-cli-compile-errors)
- [x] CLI+COCKPIT.md M5/M6 surface 에 ISR + NOREFLOW cross-domain wall evidence 통합 (Cross-domain wall analysis ASCII)
- [x] M6 verify wall = leverage point — 단일 PR ≥50-90 🔵 unlock 가능 확인

🔑 핵심: M6 (verify surface) wall은 single hexa-lang PR로 6 도메인 동시 unlock — bio kernel ~400-600 LOC + float-arg parser. M5 (synthesize) `hexa cloud run` 작동 ✓, `pool list` 직접 호출만 wall.
🌱 다음 라운드: hexa-lang impl PR fan-out (bio kernel + pool.hexa fix) 또는 V4 ledger 진행.

## 2026-05-25T00:55:00Z — NOREFLOW cross-domain 검증 사례 추가

- [x] NOREFLOW 12 base + V1-V4 verify schema를 본 M1-M7 surface에 매핑하는 표 추가
- [x] generic learning 7 row + cross-domain caveat 4건 (인덱스 leak · 🔵 atlas dep · ⚪ fence honest · pool CLI 회귀)
- [ ] 본 도메인 M1-M7 milestone scaffold 자체는 아직 작성 안 됨 (NOREFLOW가 surface 사용 사례로 induce만)
- [ ] hexa verify CLI 시연 — M6 verify surface 실증 (다음 entry)

