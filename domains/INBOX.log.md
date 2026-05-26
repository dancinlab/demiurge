# INBOX — log

Append-only history sister of `INBOX.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-26 — arxiv-a3-antimatter-factory-ingest (hexa-lang ARXIV A3 handoff · g60)

- [ ] Status: open — hexa-lang ARXIV A3(DEMIURGE axis)가 흡수한 반물질 공장 물리 논문 12편 → ANTIMATTER 7공정 cross-link 핸드오프 (g60). owner = demiurge 세션 (7공정 verify atom 보강 + V9 float-driver seed 채택 판단).

**출처**: hexa-lang `ARXIV` 도메인 A3 마일스톤 (PR: hexa-lang `feat(ARXIV): A3 DEMIURGE axis`). verdict(ASCII) = `hexa-lang:ARXIV/.verdicts/arxiv-demiurge-absorb/triage_a3.txt` · docs(한글) = `hexa-lang:ARXIV/docs/a3-demiurge-axis.md` · `hexa-lang:CLAIMS.tape` @C slug=arxiv-demiurge-absorb.

**무엇**: arXiv 6 query → 12편 흡수 (physics.atom-ph·acc-ph·hep-ex; antihydrogen 트랩·감속·냉각·합성·측정). **A3 는 ARXIV 첫 축으로 verify-able recompute 5종을 닫음** — DEMIURGE 가 verify-native 라 RFC-045-style 물리 fn 이 이미 `hexa verify --expr` 에 깔려 있음 (A1·A2 = 0 verify-able 와 대조).

**ANTIMATTER 7공정 cross-link (12 handoff)** — `ANTIMATTER.md` 7공정 spine 매핑:

| 공정 | 흡수 논문 → 기여 | verify 상태 |
|---|---|---|
| **⓵생성** | (공통) pair-production threshold T_th=6·m_p_c² · E_beam=7·m_p_c² | **🔵 VERIFY-CONFIRMED** (`pair_threshold_kinetic/total_factor`, mini arm64 HEAD #1153) |
| **⓶감속** | 1909.07493 GBAR 정전기 감속(수 keV) · 1606.06697 ELENA/USR 빔동역학(100→20 keV) | handoff (V9 빔동역학 수치 후보) |
| **⓷포획** | 1507.04147 reservoir Penning(>1년) · 1401.1939 BASE double-Penning · 1907.01460 Brown-Gabrielse g_s | `penning_invariance` @F 🟢(불변량) + Penning 3주파 float V9 candidate |
| **⓸냉각** | 0307151 ATHENA 양전자-plasma T 제어 | **🔵 VERIFY-CONFIRMED** cooling scaling (`cyclotron_cool_*`, τ_c∝m³·B⁻²) |
| **⓹합성** | 1905.03281 3체 재결합 level-pop power-law · 1409.0705 GBAR 극저온 H̄ | handoff (V9 재결합률 폐형해 후보) |
| **⓺가둠** | 1201.3944 minimum-B(octupole+mirror) 트랩 구분 | RTSC 자석 toolchain(getdp 4.0 · Ioffe-Pritchard) 상속 — 그 device 가 바로 이 논문 |
| **⓻측정** | 0805.4082 CPT 동기 · 2409.04509 1S-2S lineshape · 2002.09348 CPT/EEP/WEP bound · 1409.0705 free-fall · 1401.1939 g-factor CPT | 1S-2S 2.4661 PHz = `h1s2s_rydberg` (V9 float candidate) |

**V9 physics-primitive seed (verify-able-CANDIDATE → 다음 🟢)**:
- Penning 3주파 float form (`penning_omega_plus/minus` 2-arg) — 소스+atlas(`penning_invariance` @F 🟢 fold 2026-05-25)에 이미 존재, **설치 드라이버 `_recompute_float` 의 2-arg dispatch wire 만 없음** → V9 float-driver 재빌드 시 즉시 🟢.
- `h1s2s_rydberg(R∞,c)` = (3/4)·R∞·c ≈ 2.4661 PHz (2-arg float) — 1S-2S 중심주파 (2409.04509 / 0805.4082 / 2002.09348).
- 3체 재결합률 scaling (1905.03281 / 1409.0705 power-law) = ⓹합성 폐형해 recompute 후보.

**필링 이력 (g48 ack)**: A3 가 dirty feature 브랜치(`feat/rtsc-magnet-wheeler-v2`)에서 핸드오프를 working-copy edit 로만 기록(공유 dirty 트리 commit 회피)했고, **hexa-lang ARXIV A6 가 격리 worktree(off origin/main)로 본 항목을 demiurge main 에 커밋했다** (cross-repo handoff 메커니즘 정립 + 3 debt 정산). demiurge 세션은 이 항목을 소비 + Status 갱신만 하면 된다.

**cross-ref**: hexa-lang `ARXIV` 도메인 (A1 ingest-poc + A2 ANIMA + A3 본편 + A6 핸드오프 메커니즘) · sibling V5-IIT lane (verify_cli/stdlib, 동시 진행) · ANTIMATTER ⓷포획 Penning 3-freq 🟢(2026-05-25) · RTSC 자석 toolchain(⓺가둠 상속원).

## 2026-05-24 — `inbox/` 폴더 폐기 → INBOX + archive 통합

구 `inbox/`(notes 108 + INDEX.md + patches 2) 를 폐기하고 단일 INBOX 도메인으로 통합.

- [x] 구 `inbox/notes/`(108) + `inbox/INDEX.md` + `inbox/patches/`(2) → `archive/session-notes/` 로 `git mv` (data loss 0 · git history 보존)
- [x] INDEX.md `pickup-open`(11) + `pickup-blocked`(2) + cross-repo patch(2) = **열린 handoff 15건** 을 `INBOX.md` `- [ ]` 로 이관
- [x] resolved / superseded / archive 노트 (~93건) 는 `archive/session-notes/` 에 그대로 보존 (INBOX.log 범람 방지 — 일괄 archive)
- [x] repo 전역 `inbox/` 경로 인용 (.md · .swift · .sh · .tex · .json export 등 72개 파일) → `archive/session-notes/` 로 일괄 갱신 · 타 repo 인용(`hexa-lang:inbox/` · `~/core/hexa-lang/inbox/` · `~/core/<target>/inbox/`)은 보존
- [x] INBOX.md scope 확장 — cross-repo handoff 전용 → cross-repo + demiurge 자체 cross-session pickup 통합 수신함
