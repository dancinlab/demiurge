# CLI+COCKPIT — log

Append-only history sister of `CLI+COCKPIT.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-26T13:45:00Z — 계획 v2: Web GUI = Build with Gemini XPRIZE 2026 출전 엔트리

- [x] **전략 upgrade** — Web GUI = 단순 3rd surface가 아니라 **dancinlab의 XPRIZE 출전 엔트리** (📐 demiurge · phanes와 2-엔트리) — `~/core/growth/XPRIZE.md` 발견 + 통합
- [x] **LLM 변경** — Claude → **Gemini (Vertex AI 경유)** — XPRIZE 규정 "Gemini API ≥1 LLM call (배포 앱)" + "GCP 제품 ≥1 필수"를 Vertex AI로 한 번에 충족 (g0 Occam)
- [x] **인프라 변경** — pool ubu-1/Tailscale → **GCP Cloud Run + Vertex AI + Firebase Auth + Firestore + Cloud Storage** (4 GCP 제품)
- [x] **결제 추가** — Stripe Checkout 통합 (월별 매출 증빙 5~8월 · related-party 라벨링 필수)
- [x] **인증 추가** — Firebase Auth (Google sign-in + 이메일) — 실사용자 onboarding (Tailscale 폐쇄망 폐기 — 공개 SaaS 전환)
- [x] **신규 GCP 프로젝트** — `dancinlab` (XPRIZE 규정 "신규 프로젝트만 — 제출 시작 ≥2026-05-19" 충족 · 결제 계정도 `dancinlab`)
- [x] **마감 일정 등록** — M14 6/9 · M15 6/30 · M16 7/21 · M17 8/4 · 제출 8/17 · 결승 9/25 LA (총 13일 buffer)
- [x] **데모 시나리오** — RTSC 단일 도메인 end-to-end (발견 → verify → handoff) — XPRIZE 영상 <3분
- [x] **카테고리 선택** — Professional Services (phanes도 동일이면 분산 검토 — 별도 phanes 측 결정 필요)
- [x] **심사 강점 축** — ② AI-Native Ops ⅓ (AI가 프로덕션 결정 실행) — demiurge 7-verb 자동 dispatch가 본질적 강점
- [x] RFC v2 작성 — `CLI+COCKPIT/web_gui_rfc.md` 12 섹션 (XPRIZE 규정 충족 매트릭스 · GCP 인프라 다이어그램 · Gemini 호출 4 verb 위치 · 가격 모델 초안 · 비용 추정 · 제출 체크리스트)
- [x] 도메인 SSOT 갱신 — CLI+COCKPIT.md @goal + M14-M17 + M_submit (2026-08-17) 추가
- [ ] **사용자 결정 필요** — phanes와 카테고리 분산 (현재 둘 다 Professional Services 후보 — 같은 칸이면 내부 경쟁)
- [ ] **사용자 결정 필요** — GCP 크레딧 적용 시점 (신규 계정 $300 + XPRIZE 제공분 확인)
- [ ] **사용자 결정 필요** — Stripe 가격 모델 ($29/$99/$299 월정액 vs 사용량 기반)
- [ ] M14 web-foundation 진입 시: `web/` 디렉토리 신설 · Next.js 14 App Router scaffold · GCP project `dancinlab` 생성 · Vertex AI enable · REST fetch 패턴 (SDK 미설치)
- [ ] **commit 보류** — 공유 worktree (3 claude 동시) · land 명령 시 `git worktree add -b feat/xprize-rfc` 격리

🔑 핵심 pivot: Web GUI = **XPRIZE the product**. LLM=Gemini-on-Vertex-AI, 인프라=GCP 4-제품, 결제=Stripe, 인증=Firebase. 마감 D-83 (2026-08-17 제출).
🌱 다음 라운드: 사용자 승인 → M14 진입 (`web/` scaffold + GCP project 생성). 동시 phanes 측에 카테고리 분산 동기화 필요.

## 2026-05-26T13:35:20Z — 계획 변경: 2-surface → 3-surface (Web GUI 신규 · Next.js/TypeScript)

- [x] @goal 갱신 — "두 surface" → "**3 surface** (CLI · Swift Cockpit macOS · Web GUI Next.js)"
- [x] 스택 결정 — Next.js (TypeScript) · Swift Vapor 기각 (Cockpit Swift 재사용 가치 < 새 언어 도입 비용 · React 시각화 생태계 + g1 ai-native + Claude TS/React 코드 강함)
- [x] Swift Cockpit 운명 — **유지 (3-surface 병행)** · deprecate 아님 · 데스크톱 macOS 사용자 surface 보존
- [x] milestone M14-M17 신규 등재 (CLI+COCKPIT.md):
  - M14 web-foundation — Next.js 스캐폴드 + `demiurge cli` subprocess proxy API + 도메인 인덱스
  - M15 web-7verb-surface — 7-verb 페이지 7개 + `hexa verify` verbatim 렌더 + recharts
  - M16 web-realtime — SSE 채널 + `/cycle` 라이브 tail + pool host status polling
  - M17 web-domain-nav — DOMAINS.tape parser + 진행도 dashboard + cross-project linkage map + Tailscale 원격 접속
- [x] RFC 작성 — `CLI+COCKPIT/web_gui_rfc.md` (3-surface 구조 ASCII · 원칙 d3/d4/g1/g_cockpit_isolation/g5 · 7-verb mapping · 라우팅 · realtime · 인증 · 배포 · open questions · 비-목표 11 섹션)
- [x] 핵심 원칙 명시 — Web GUI = **별도 구현 추가 금지**, 모든 dispatch는 `demiurge cli` subprocess 라우팅 (d4 단일 generic 유지)
- [x] 데이터 source 동일 — `exports/**` typed records (Swift Cockpit `g_cockpit_isolation` invariant 평행 적용)
- [x] 배포 호스트 후보 — pool ubu-1 (linux · 항시 가동) 또는 mini (macOS · launchd) · Tailscale magic-DNS
- [ ] 사용자 승인 시 M14 진입 — `web/` 디렉토리 신설 + `package.json` + Next.js App Router scaffold + 첫 API route `app/api/cli/route.ts`
- [ ] open question 5건 (M15-M17 진입 시 결정): typed model 노출 방식 · verify 렌더 server/client · recharts vs plotly · token rotation · pool fallback chain
- [ ] **commit 보류** — 공유 worktree (3 claude 에이전트 동시 사용) · 사용자가 land 명령 시 `git worktree add` 격리 후 PR

🔑 핵심: 2-surface(CLI · Swift Cockpit) → 3-surface (+ Web GUI Next.js). d4 단일 generic 위배 없이 dispatch는 모두 `demiurge cli` subprocess로 라우팅. Swift Cockpit 병행 유지.
🌱 다음 라운드: 사용자 승인 → M14 web-foundation 스캐폴드 (PoC = 도메인 인덱스 + 1개 verb 페이지 + verify verbatim 렌더).

## 2026-05-25T17:50:00Z — swift test 8 fail → 78 tests 0 failures (GREEN) · hexa-lang PR #821

- [x] CLI+COCKPIT M14-M21 + 운영 surface(operate/compose/verify/atlas/backend/owner/project)+cockpit 운영탭+release.hexa = origin/main 머지 (demiurge PR #79·#80·#81·#82·#83 · audit @goal met)
- [x] `swift test` 초기 8 assertion fail(5 case) 전부 `MaterialFalsifierDispatchTests` → 진단: hexa 컴파일러 버그(동명 `let` 리터럴 로컬 함수간 codegen 충돌 → 모든 result에 첫 falsifier id leak)
- [x] **hexa-lang PR #821 MERGED** — `falsifier_dispatch.hexa::dispatch_falsifiers`에서 canonical id/name index re-stamp 워크어라운드 (`--selftest 5/5`)
- [x] probe 경로 반영 + synthetic 샘플 stale json 정리 → **swift test 78 tests · 1 skip · 0 failures GREEN**
- [x] memory: `reference-hexa-let-literal-collision` (미래 함정) · `demiurge owns 작동부` carve-out
- [ ] ⏳ hexa codegen 근본 fix (PR #821=워크어라운드, 버그 LIVE) · docs origin catchup (동시 세션 로그 wipe 반복)

🔑 핵심: 세션 목표(외부 app+CLI 완전운영) 코드 전부 origin 머지 + audit @goal met. 테스트 8 fail은 hexa-lang 컴파일러버그발(내 작업 무관) → PR #821로 78/0 GREEN. ⚠ 이 로그는 동시 세션이 반복 wipe — durable 기록은 PR #79-83·#821 + memory.

## 2026-05-25T07:50:00Z — CARDIO+ 메타도메인 세션 교훈 → CLI/cockpit 개선 milestone M8-M13 등재

- [x] **M8-M13 개선 milestone 등재** (milestone-level only · 구현 후속) — CARDIO+ 메타도메인(X1-X13 + DOCTOR H1-H10 + 인프라 핸드오프 3건) 세션서 induce
  - M8 verify host-health 라우팅 (mini ✅/ubu broken) · M9 macOS-only pool-route 예외 · M10 commit-isolation(d9) 강제 · M11 agent fan-out cap 2-3 · M12 upstream INBOX reflex(g60) 패널 · M13 folder-nested domain (✅ 0.8.x 해소)
- [x] **CARDIO+ 검증사례 섹션 추가** — NOREFLOW 사례와 병렬 · 6 교훈 표(증거→surface→milestone→status) + generic caveats 4개
- [x] generic caveats: honest tier 천장(🟢 vs 🔵) · numerical→causal over-read 경계(X13 red-team) · d6 no-forcing 실증(ICER v7) · `+` 메타도메인 roll-up surface 필요
- [ ] ⏳ M8-M12 구현 (코드/시스템) — 별도 cycle (본 등재는 마일스톤 기준 · 사용자 "matleb 기준만" 지시)

🔑 핵심: CARDIO+ 세션의 실측 마찰(verify 호스트·pool-route·commit 격리·agent cap·INBOX 반사·domain nest)을 CLI+COCKPIT 7-verb surface 개선 milestone으로 전환 — cockpit이 이 교훈들을 embody하면 다음 메타도메인 작업서 재마찰 0.
⚠ status: M13만 해소(domain 0.8.x) · M8-M12는 open (구현 cycle 대기) · M8/M9/M12는 upstream(hexa-lang/sidecar) 부분 진행.

## 2026-05-25T02:30:00Z — DAPTPGX cycle 5 CLI 실증 + 3 spec docs induce (4th reproduction)

- [x] DAPTPGX V1-V4 verify-phase 완료 (M1-M11 + V1-V4 = 14/14)
- [x] `hexa verify rubric` · `hexa verify --expr phi 100 40` 🔵 · `hexa verify --fence` ⚪ × 4 — M6 surface dispatch 4 path 모두 verbatim 캡처
- [x] `hexa atlas stats` 16066 nodes 재확인 (NOREFLOW + ISR + LPA와 ATLAS_HASH 동일 = atlas read-only stable)
- [x] V3 sim — `ssh mini 'hexa run /tmp/v3_recompute.hexa'` 32줄 stdout (HW · phenotype · PM×HBR · ICER · Markov · budget)
- [x] V3 = 🟢 SUPPORTED-NUMERICAL × 2 (HW 0.6279 vs cited 0.60 within 5pp · PM per100 15.21 vs cited 14-15 exact)
- [x] V3 sign mismatch 정직 보고 (ICER -3,221 M/QALY vs cited +34) — d6 framing 준수, 🔴 FALSIFIED 거부, 🟠 reconciliation pending
- [x] V2 promoter 0-proposal bug 만남 → 4 shard staged `/tmp/daptpgx-staging/` + 2 inbox patches
- [x] `cp archive/session-notes/patches/{stdlib-bio-stats,atlas-pgx-kind}.md ~/core/hexa-lang/inbox/patches/daptpgx-*-2026-05-25.md` ✅ — demiurge cli upstream handoff (M7 surface)
- [x] V4 final ledger — 30 claim 분포 (현 🔵 0 + 🟢 5 → V2-bis 후 🔵 4 + 🟢 12 escalation 예상)
- [x] **3 spec docs induce 완료** — `CLI+COCKPIT/M5_synthesize.md` · `M6_verify.md` · `M7_handoff.md` (cross-domain learning을 surface spec으로 결정화)
- [x] CLI+COCKPIT.md DAPTPGX evidence section 추가 (NOREFLOW · ISR · LPA 표 패턴 4번째 확장)
- [x] cross-domain wall 4th confirmation — pool wrapper 컴파일 bug (ssh fallback 일관) + biostat kernel 부재 (PR #665 merge 시 일제 unblock)

## 2026-05-25T02:00:00Z — LPA cycle 4 CLI 실증 (3rd reproduction)

- [x] `hexa --version` = 0.1.0-dispatch 작동 — NOREFLOW + ISR과 동일 환경
- [x] `hexa verify --expr sigma 6 12` → 🔵 SUPPORTED-FORMAL (number-theory sanity 재확인)
- [x] `hexa verify --expr ivw 3 1` → 🟠 INSUFFICIENT (biostat kernel 부재)
- [x] `hexa atlas stats` = 16,066 nodes · F=1,313 · ATLAS_HASH `6fae9277...` (NOREFLOW + ISR과 hash 동일)
- [x] `pool list` 실행 → compile error 재현 (V3a · V3c agent 보고와 일치)
- [x] LPA V3a/V3c agent 우회 = ssh direct (ubu-1 0.58s · ubu-2 0.054s) — 3rd cross-domain reproduction
- [x] LPA V2 agent → hexa-lang **PR #665 OPEN** (`archive/session-notes/2026-05-24-lpa-ivw-mr-formula.md`) — biostat 5 fn 요청
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

