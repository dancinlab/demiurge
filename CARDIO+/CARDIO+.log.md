# CARDIO+ — log

Append-only history sister of `CARDIO+.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-25T02:50:00Z — CARDIO+.md/.log.md 자체도 CARDIO+/ 내부로 이동

- [x] git mv CARDIO+.md → CARDIO+/CARDIO+.md · CARDIO+.log.md → CARDIO+/CARDIO+.log.md
- [x] 메타도메인 SSOT가 폴더 내부로 fully self-contained — `CARDIO+/` = 1 자족 단위
- [ ] ⚠ domain skill `/domain set CARDIO+` snapshot 경로 = root 가정 → CARDIO+/ 내부 이동 후 skill 재확인 필요
- [ ] 문서 내 경로 표기는 repo-root-relative (`CARDIO+/X1...`) 유지 — 이동해도 유효

🗂 최종 구조: demiurge/CARDIO+/ = { CARDIO+.md · CARDIO+.log.md · X1-X10 · 5 sub (각 .md/.log.md/folder) } — 완전 self-contained 메타도메인

## 2026-05-25T02:40:00Z — 5 sub-domain CARDIO+/ 통합 이동 + X1 완료

- [x] git mv 5 sub (NOREFLOW · DAPTPGX · ISR · LPA · DOCTOR) 폴더 + sister .md/.log.md → `CARDIO+/` (history 보존)
- [x] CARDIO+.md source 경로 갱신 (`CARDIO+/<sub>.md`)
- [x] X1 unified claims 완료 — `CARDIO+/X1_unified_claims.md` (380 lines)
- [ ] ⚠ 다른 세션 path broken 위험 (사용자 결정 수용) — ISR/LPA/DAPTPGX 진행 중 세션은 새 경로 인지 필요
- [ ] domain skill `/domain set <NAME>` root snapshot 경로 — CARDIO+/ 이동 후 재확인 필요

🔑 X1 핵심 (unified inventory):
- **unified claim ~335+** (NOREFLOW 72 + DAPTPGX 30 + ISR ~65 inline + LPA 45 − cross-domain dedup 12)
- **cross-domain dedup 12** (CX01-CX12: KAMIR · TICAKOREA · HOST-EXAM · COLCOT/CLEAR · FOURIER · Mehran · ARC-2 · nicorandil 한국 · hexa-lang inbox 등)
- **tier 합산 현재**: 🔵 1 · 🟢 14 · 🟡 ~133 · 🟠 ~44 · 🔴 1 · ⚪ 3 (+ ISR V4 미할당 ~140)
- **target (V2/V3 push 후)**: 🔵 ~48 · 🟢 ~54 → 🔵+🟢 **15 → ~102 (5-fold escalation)**
- 시너지: **ALDH2*2 × CYP2C19 LoF × Lp(a) high = 한국인 PCI layered care 3-axis** (X9 입력)

## 2026-05-25T02:15:00Z — CARDIO+ 메타도메인 scaffold

- [x] @goal 확립 — 4 cardio sub-domain 동시 심화·골화 컨테이너 + DOCTOR handoff trajectory
- [x] 메타-도메인 구성 표 (NOREFLOW · DAPTPGX · ISR · LPA · DOCTOR) — 각 sub의 현재 진행 / source
- [x] X1-X10 cross-cutting milestone 설계 (claim 통합 · 🔵/🟢/⚪ push 동시 · 한국 trial portfolio · 환자 사례 · DOCTOR feed · 그레이드 ledger · wall map · figures)
- [x] d2 meta governance + handoff flow ASCII
- [ ] X1 unified claims 작성 (다음 cycle)

🎯 메타도메인 의도:
- 4 sub-domain 독립 진행 중 — 각 .md/log.md 자체 owner
- CARDIO+는 cross-cutting 작업만 담당 (중복 제거 · 통합 ledger · 시너지 path)
- DOCTOR가 final handoff surface; CARDIO+는 사이 layer (4 → 1 압축)

📊 4-domain 진행 snapshot (2026-05-25 기준):
- NOREFLOW: 14/16 (87%) — V2/M11 PR #658 merged → unblock pending recompute kernel
- DAPTPGX: 4/8 (other session) — M3 switch · M6 next-gen 진행 중
- ISR: 4/8 (other session) — M2 · M3 · M5 · M7 · V2 → 🟠/🟢 partial
- LPA: 3/8 (other session) — M3 · cycle 4 simulation 진행 + R2 regulatory · V3c ICER

🔑 cross-domain 시너지 후보 (X9 wall map 입력):
- **ALDH2*2 (East Asian 40%) × CYP2C19 LoF × Lp(a) 한국 분포** — 한국인 stratification 3-axis
- **IC delivery PK 우위** (NOREFLOW M4) ↔ **드러그-eluting balloon** (ISR M5) — 카테터 기반 국소 전달 공통 인프라
- **siRNA delivery** (LPA) ↔ **mPTP/SIRT3 NAD+** (NOREFLOW) — 한국 supplement IRB-light pilot 공통 경로
- **단일 PR이 4-domain 동시 unlock** — hexa-lang bio-verify-kernel extension (ISR `bio-verify-kernel-extension` patch 사례)
