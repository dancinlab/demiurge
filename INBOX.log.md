# INBOX — log

Append-only history sister of `INBOX.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-24 — `inbox/` 폴더 폐기 → INBOX + archive 통합

구 `inbox/`(notes 108 + INDEX.md + patches 2) 를 폐기하고 단일 INBOX 도메인으로 통합.

- [x] 구 `inbox/notes/`(108) + `inbox/INDEX.md` + `inbox/patches/`(2) → `archive/session-notes/` 로 `git mv` (data loss 0 · git history 보존)
- [x] INDEX.md `pickup-open`(11) + `pickup-blocked`(2) + cross-repo patch(2) = **열린 handoff 15건** 을 `INBOX.md` `- [ ]` 로 이관
- [x] resolved / superseded / archive 노트 (~93건) 는 `archive/session-notes/` 에 그대로 보존 (INBOX.log 범람 방지 — 일괄 archive)
- [x] repo 전역 `inbox/` 경로 인용 (.md · .swift · .sh · .tex · .json export 등 72개 파일) → `archive/session-notes/` 로 일괄 갱신 · 타 repo 인용(`hexa-lang:inbox/` · `~/core/hexa-lang/inbox/` · `~/core/<target>/inbox/`)은 보존
- [x] INBOX.md scope 확장 — cross-repo handoff 전용 → cross-repo + demiurge 자체 cross-session pickup 통합 수신함
