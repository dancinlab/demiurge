# CLI+COCKPIT — log

Append-only history sister of `CLI+COCKPIT.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

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

