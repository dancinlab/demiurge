# XPRIZE — log

Append-only history sister of `XPRIZE.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-27T01:30:00Z — M16 web-realtime + auth + billing 완료 (3-slice)

- [x] **M16a SSE realtime** — `/api/stream` SSE wrapper + `LiveTail` client component + analyze 페이지 통합 · open/data/exit 이벤트 + allowlist 403 enforce
- [x] **M16b Firebase Auth (REST)** — Identity Toolkit v1 직접 호출 (signUp · signIn · lookup · refreshToken · 0 SDK) + httpOnly 세션 쿠키 + auto-refresh + 4 routes (signup/signin/signout/me) + /signin · /account 페이지
- [x] **M16c Stripe Checkout (REST)** — form-urlencoded REST + node:crypto HMAC SHA-256 webhook verify + 3-tier billing SSOT (Solo $29 · Team $99 · Org $299 · 14d trial) + checkout/portal/webhook routes + /pricing 페이지
- [x] **XPRIZE 매출 surface 구축** — sign-in 후 /pricing → Stripe Checkout → webhook → ledger (M17에서 Firestore 영구화). related-party 라벨링은 회계 단계에서.
- [x] **누적 LOC** — M14 ~500 + M15 ~600 + M16a ~210 + M16b ~500 + M16c ~575 = **~2400 LOC** (RFC 예상 ~1700 · 견고한 인증 + 결제 추가분 포함)
- [x] **0 npm install 유지** — Vertex AI · Firebase · Stripe 3 인프라 전부 REST + node:crypto · 인수 옵셔널리티 완벽 보존
- [ ] M17 진입 시: Dockerfile (multi-stage) + cloudbuild.yaml + Cloud Run 배포 + Firestore subscriptions 적재 + Cloud DNS dancinlab.org + 첫 유료 전환 1건
- [ ] 사용자 secret 5개 셋업 (firebase.web_api_key · stripe.{secret_key,webhook_secret,price_solo,price_team,price_org})

🔑 핵심: Web GUI 전체 stack이 GCP-native + 0 dep. 인수 옵셔널리티 + XPRIZE 규정 완벽 충족 (Gemini ≥1 ✓ · GCP 제품 ≥1 ✓ · 신규 프로젝트 ✓ · 매출 surface 가동 가능).
🌱 다음: 사용자 secret 5개 셋업 → M17 deploy 진입.

## 2026-05-27T03:42:00Z — 🌐 i18n 5-locale (en · ko · ja · zh · ru) · /account tier badge · 테스트 계정 2개

- [x] **PR #285 MERGED** — M14-M17 web 전체 land (Next.js 16 + Vertex AI + Firebase + Stripe REST + Cloud Run · 2700 LOC)
- [x] **PR #287 MERGED** — /account Firestore lookup → Solo/Team/Org pill 배지 + currentPeriodEnd + cancelAtPeriodEnd 경고
- [x] **PR #288 MERGED** — i18n 인프라 (lib/i18n · 5 messages/*.json · /api/lang cookie · LangSwitcher · home 페이지 번역)
- [x] **PR #290 MERGED** — i18n fast-follow (/signin /pricing /account 5-locale 적용)
- [x] **테스트 계정 2개** — `xprize-judge-demo@dancinlab.test` (judging demo) + `dev@dancinlab.test` (founder dev) · 둘 다 Org tier active · related_party=true (XPRIZE 매출 제외)
- [x] **Firestore 직접 적재** — `users/{uid}/subscriptions/sub_*_org` documents · status=active · currentPeriodEnd=2027-01-01 · stripeCustomer=cus_test_*
- [x] **secret keychain** — `demiurge.test_email/password` + `demiurge.dev_email/password` 저장
- [x] **인프라 0 npm SDK 유지** — i18n도 JSON dict + Next.js cookies()/headers() native · Stripe/Firebase/Vertex AI/Firestore 모두 REST + node:crypto · 인수 옵셔널리티 완전 보존
- [ ] Cloud Build 재배포 진행 중 (background `by3difwhx` · i18n production 반영 대기)
- [ ] Stripe 5 secret 셋업 (사용자 manual)
- [ ] 첫 유료 전환 1건 (외부 사용자 · related_party=false · XPRIZE 매출 증빙)
- [ ] phanes Track B 카테고리 분산 결정
- [ ] 데모영상 (D-7~D-3 촬영) + Devpost form 제출 (D-1)

🔑 핵심: production UI 5개 언어 + tier 시각화 + 심사용 + 본인용 계정 모두 활성. XPRIZE 심사 시 누구나 사인업/로그인/요금제 선택 가능 (i18n로 글로벌 심사위원 진입 장벽 0).
🌱 다음: Cloud Build 완료 → 라이브 5-locale 검증 → Stripe 실 결제 라이브화 → 데모영상.

## 2026-05-27T03:10:30Z — 🎉 https://demiurge.dancinlab.org LIVE (custom domain + production SSL)

- [x] **Cloud Build #2 SUCCESS** — image `us-central1-docker.pkg.dev/dancinlab/demiurge/web:44a831a3-...` · 2m52s · revision `demiurge-web-00001-jft`
- [x] **Cloud Run service URL 가동** — `https://demiurge-web-2n7kup3fpa-uc.a.run.app` · 200 OK · TTFB ~1s
- [x] **5/5 endpoint live** — `/` · `/api/domains` · `/signin` · `/pricing` · `/api/llm` 모두 200 (Vertex AI metadata-server ADC 자동 인증 동작)
- [x] **Firestore native DB 프로비전** — `(default)` us-central1 STANDARD edition (M17 webhook 영구화 준비)
- [x] **Cloud DNS 폐기** — `dancinlab.org` zone GCP에서 삭제 · Cloudflare 단독 authoritative 유지 (CDN + DDoS 보호 보존)
- [x] **Site Verification API 자동화** — gcloud ADC + `siteverification` scope 추가 후 token 자동 받기 → Cloudflare TXT @ 자동 등록 → ownership 청구 (브라우저 paste 0회)
- [x] **Cloud Run domain mapping** — `demiurge.dancinlab.org → ghs.googlehosted.com` · Cloudflare CNAME proxy=OFF · Google-managed SSL 자동 발급 (7분 후 GFE edge 전파)
- [x] **production Gemini evidence** — `POST https://demiurge.dancinlab.org/api/llm` → `gemini-2.5-flash` 응답 (`"@goal: XPRIZE 관련 프로젝트를 지원하는 demiurge.dancinlab.org 프로덕션"`) · usage prompt=200/candidate=23/total=796
- [x] **secret 추가** — `cloudflare.email` · `cloudflare.api_token` (Global API Key 갱신)
- [x] **인프라 8/8** — Vertex AI · Cloud Run · Cloud Build · Artifact Registry · Firestore · Firebase Auth · Identity Toolkit · Secret Manager 모두 active
- [ ] **Stripe 5 secret** (사용자 manual) — `secret set stripe.{secret_key, webhook_secret, price_solo, price_team, price_org}`
- [ ] **재배포 (Stripe env 반영)** — `gcloud builds submit --config cloudbuild.yaml --project=dancinlab`
- [ ] **첫 유료 전환 1건** — XPRIZE 매출 증빙 (related-party 라벨링)
- [ ] **commit/PR 정리** — 공유 worktree 격리 후 `git worktree add -b feat/web-m14-m17` 패턴
- [ ] **phanes.dancinlab.org** (별도) — phanes Cloud Run service 준비 후 동일 패턴

🔑 핵심: **XPRIZE production evidence 4/5 확보** — Gemini API ✓ · GCP 7-제품 사용 ✓ · 신규 프로젝트 ✓ · custom domain SSL ✓ · 매출 증빙 ⏳ (Stripe 키 대기). M14-M17 핵심 골자 완성.
🌱 다음: Stripe 키 셋업 → 재배포 → 첫 결제 → commit/PR → Devpost 제출 (2026-08-17).

## 2026-05-27T00:30:00Z — 🎉 첫 live Gemini 호출 (XPRIZE Rule#1 충족)

- [x] **GCP 프로젝트 생성** — `dancinlab` (결제 계정도 `dancinlab`) — 2026-05-27 · XPRIZE 규정 "신규 프로젝트만 ≥2026-05-19" 충족
- [x] **Vertex AI API enable** — `gcloud services enable aiplatform.googleapis.com --project=dancinlab`
- [x] **ADC 인증** — `gcloud auth application-default login` 완료
- [x] **secret keychain 저장** — `secret set gcp.project dancinlab` + `secret set gcp.access_token "$(gcloud auth application-default print-access-token)"` (token 254 chars)
- [x] **live Gemini call 성공** — `POST /api/llm {"prompt":"한 문장으로 RTSC...", "verb":"spec", "maxOutputTokens":150}` → `gemini-2.5-flash` @ us-central1 응답 200 OK
- [x] **응답 schema 확인** — `{"text":"...", "model":"gemini-2.5-flash", "usage":{"promptTokens":20,"candidateTokens":6,"totalTokens":166}}` · 140 토큰 차이 = Gemini 2.5 reasoning(thinking) consumption
- [x] **XPRIZE Rule#1 충족 증거 확보** — "Gemini API ≥1 LLM call (배포 앱)" · 향후 Cloud Run 배포 후 동일 코드 path로 재현 가능 (메타데이터 서버 auto-token)
- [x] **SSOT 13건 정정** — `demiurge-xprize-2026` → `dancinlab` (CLI+COCKPIT.md · log · web_gui_rfc · XPRIZE.md · log · web/lib/gemini.ts · memory)
- [ ] **메모 — production tuning**: `maxOutputTokens` 기본 1024 → 검토 필요 (Gemini 2.5 reasoning 소모분 ~100-200 추가 예상)
- [ ] 다음 — M15 spec 페이지 (`/spec/<domain>`) + Gemini live draft 어시스트 UI

🔑 핵심: XPRIZE 규정 충족 가능성 입증 = LLM 호출 작동 ✓ + GCP 제품 사용 ✓ + 신규 프로젝트 ✓. 남은 작업은 **product surface 살 붙이기**.
🌱 다음: M15 7-verb 페이지 + Stripe + Firebase Auth 진행.

## 2026-05-26T14:35:00Z — M14 web-foundation 진입 — Next.js 16 + App Router scaffold + CLI proxy + DOMAINS parser

- [x] **Next.js scaffold** — `web/` 디렉토리 신설. `npx create-next-app@latest --typescript --app --tailwind --turbopack` 비-인터랙티브 실행
- [x] **버전 확인** — Next.js **16.2.6** · React **19.2.4** · Tailwind v4 · Turbopack ON
- [x] **AGENTS.md/CLAUDE.md 경고 인지** — "This is NOT the Next.js you know" → `node_modules/next/dist/docs/01-app/...` 참조 → Next 16 표준 (`Response.json()` · `params: Promise<{}>`) 적용
- [x] **`web/lib/cli.ts`** — DemiurgeCLI subprocess invocation helper. binary 탐색 순서: `$DEMIURGE_BIN` · PATH · `cockpit/.build/{release,debug}/DemiurgeCLI`. `runCli()` + `streamCli()` async-generator (M16 SSE용)
- [x] **`web/lib/domains.ts`** — `DOMAINS.tape` 파서 (root SSOT `/Users/ghost/core/demiurge/DOMAINS.tape`). 3 형식 tolerant: `@domain NAME := "..."` · `@D ... path = "..."` · bare `NAME path.md`. snapshot 추출: `@title:` · `@goal:` · `- [ ]/[x]` 진척률
- [x] **`web/app/api/cli/route.ts`** — POST proxy + 21-subcommand allowlist (action · discover · verify · atlas · operate · backend · compose · list-* · show · gate-summary · --version · --help). args[] string 강제 + timeout 30s
- [x] **`web/app/api/domains/route.ts`** — GET DOMAINS.tape JSON
- [x] **`web/app/page.tsx`** — 도메인 인덱스 (server component · grid · 진척률 % · @goal 요약)
- [x] **`web/app/[domain]/page.tsx`** — 동적 라우트 dashboard (params Promise · MD body + log tail 80줄)
- [x] **type-check** — `npx tsc --noEmit` GREEN (0 errors)
- [x] **dev 서버 boot** — Turbopack 280ms Ready · localhost:3500
- [x] **smoke test 3건 PASS**:
    - `GET /api/domains` → `{"domains":[AURA, XPRIZE],"count":2}` · @title · @goal · progress 모두 추출 ✓
    - `POST /api/cli {"args":["--version"]}` → exitCode 0 · stdout="demiurge 0.0.2 (phase α-3 + β, read-only — rfc_011 §10)" ✓ — **d4 subprocess dispatch 작동 확인**
    - `GET /` → HTML serve · Geist font + Tailwind 적용 ✓
- [x] **pool-route 우회** — Mac workstation에서 `npm run build`가 heavy-classified → pool route 차단. `next dev` 형태로 검증 (`next build`는 M17 Cloud Run Docker context에서)
- [ ] **M14 잔여**: GCP project `dancinlab` 생성 ✅ (2026-05-27) + Vertex AI enable + Cloud DNS `dancinlab.org` zone
- [ ] **M14 commit 보류** — 공유 worktree 3 claude · land 명령 시 `git worktree add -b feat/web-m14-foundation` 격리 + node_modules .gitignore 확인 + PR
- [ ] M15 진입 시: 7-verb 페이지 + Vertex AI Gemini SDK 통합 + recharts

🔑 핵심: **3 endpoint 작동 검증** = d4 single generic dispatch (CLI subprocess) + d3 canonical home 보존 (Web read-only · 자체 verb 로직 0). LOC ~500 (목표 ~700 미달 = 잔여 GCP wire-up이 차지할 분량).
🌱 다음: 사용자 GCP 결정 → M14 closure → M15 (Gemini-on-Vertex-AI 4 verb 호출 위치 · spec/design/analyze/handoff).

## 2026-05-26T14:20:00Z — 도메인 확정: dancinlab.org 서브도메인

- [x] **사용자 결정** — production 도메인 = `dancinlab.org` (이미 보유) 산하 서브도메인
- [x] demiurge Web GUI → `demiurge.dancinlab.org`
- [x] phanes Web GUI → `phanes.dancinlab.org`
- [x] `demiurge.ai` 가설 폐기 — XPRIZE.md · CLI+COCKPIT.md · XPRIZE.log.md · memory (project_demiurge_google_native) 4 파일에서 일괄 정정
- [x] Cloud DNS plan 갱신 — `dancinlab.org` zone 생성 → 두 서브도메인 A/CNAME 레코드 → Cloud Run domain mapping (Google 관리 SSL 자동)
- [x] ~~사용자 결정 필요 — `dancinlab.org` DNS provider 이관/위임 옵션~~ **보류 closed** (2026-05-26 사용자 결정 · M14 진입 시 기본 옵션으로 그냥 진행)
- [ ] M14 진입 시: GCP Cloud DNS zone 생성 + 서브도메인 등록 + Cloud Run mapping

## 2026-05-26T14:15:00Z — DemiurgeCLI `discover` 8th verb 구현 + GOOGLE-NATIVE 기록

- [x] **GOOGLE-NATIVE 표 기록** — XPRIZE.md `## 🏗️ DEMIURGE-GOOGLE-NATIVE` 섹션 신설: 현재 plan vs 자사 native 강화 12개 축 + 후속 milestone 7건 (Cloud DNS · BigQuery · Vertex AI Training · Cloud TPU · CUDs · Workspace SSO · Google Pay 마이그)
- [x] **설계 원칙 추가** — "구글이 인수해도 바꿀 게 없다" = 인수 매력도 ↑ (vs Anthropic-AWS 의존 사례 비교)
- [x] **방향 정정** — phanes 발견엔진 = **흡수 X, CLI 연결 O** (d3/d4 보존 · phanes가 canonical home · demiurge는 dispatcher)
- [x] **DemiurgeCLI `discover` 구현** — `cockpit/Sources/DemiurgeCLI/main.swift::discoverCmd` (Swift, English authoring per prefs)
- [x] phanes binary 탐색 순서 — `$PHANES_BIN` · `/usr/local/bin/phanes` · `/opt/homebrew/bin/phanes` · `~/core/phanes/bin/phanes`
- [x] 미설치 시 친절한 에러 메시지 + contract 노출 + INBOX.log.md 가이드
- [x] `swift build --product DemiurgeCLI` GREEN ✓ (8.96s · 0 warnings)
- [x] 실행 검증 — `swift run DemiurgeCLI discover` → usage ✓ · `discover "<objective>"` → contract 안내 메시지 ✓
- [x] **phanes 측 contract 핸드오프** — `~/core/phanes/INBOX.log.md` 에 `demiurge-discover-bridge` 항목 등재 (expected CLI signature + JSON schema + 2 구현 옵션)
- [ ] **phanes 측 액션 필요** — `bin/phanes` plain CLI 신설 (Node wrapper or phanes-http `--once` mode)
- [ ] M14 web-foundation에서 Web `/discover/<objective>` 페이지 추가 (Gemini-on-Vertex-AI proposer + demiurge cli discover 호출)

🔑 핵심: `discover` = demiurge의 8th verb (head 위치). phanes CLI subprocess wrapper. **d3 canonical home + d4 single generic 보존**. phanes 측 CLI 신설만 남음 (cross-project handoff 등재 완료).
🌱 다음: GCP 프로젝트 `dancinlab` 생성 + Cloud DNS `dancinlab.org` zone + 서브도메인 `demiurge.dancinlab.org` · `phanes.dancinlab.org` 등록 (M14 진입 동반).

## 2026-05-26T14:00:00Z — phanes 발견엔진 → demiurge 통합 결정

- [x] **사용자 결정** — phanes의 "자동 발견 (objective + verifier → 검증 카탈로그)" 엔진을 demiurge에도 포함 → demiurge = 7-verb 설계 파이프라인 **+ 발견엔진**
- [x] **전략 효과** — demiurge 단독 엔트리만으로도 "발견→설계→검증→handoff" full-stack 커버 → phanes 스크리닝 탈락 시에도 demiurge 생존
- [x] **기존 capability 활용** — `hexa drill` / `hexa kick` (gap breakthrough · discovery engine) 이미 존재 → demiurge가 Gemini proposer로 wrap하면 즉시 surface 가능
- [x] **8th verb 추가 검토** — discover (또는 발견) — spec 앞단에 위치 · objective input → verifier-checked candidate list 출력
- [x] **카테고리 분산 의미 재평가** — 둘 다 Professional Services + 둘 다 발견 기능 = "substantially different" 약화 → A1 카테고리 분산 시급도 ⬆ 🔴
- [ ] **사용자 결정 필요** — phanes 운명: (a) 분리 유지 (현재 plan) (b) demiurge에 흡수 → 1-엔트리 (c) phanes를 다른 카테고리로 분산 (현재 leaning)
- [ ] CLI+COCKPIT.md M_discover (or M_predict) 신규 milestone 등재 — `hexa drill` Gemini-wrapped surface
- [ ] Web GUI RFC 갱신 — 8th verb 페이지 `/discover/<domain>` + Gemini 호출 위치 ⑤번째 추가

🔑 핵심: demiurge가 발견까지 흡수 → 단일 엔트리 strength ↑ · 그러나 phanes와 substantially-different 위험 발생 → 카테고리 분산 즉시 필요.

## 2026-05-26T13:55:00Z — XPRIZE 도메인 init + 3-track 구조 (Track A demiurge · Track B phanes · Track C 공통 · Track D 결승)

- [x] `/domain init XPRIZE domains/` 실행 → `domains/XPRIZE.md` + `XPRIZE.log.md` + DOMAINS.tape 등록
- [x] @title 설정 — 🏆 XPRIZE — "구글 Gemini 90일 사업 대회"
- [x] @goal 설정 — dancinlab 2-엔트리(📐 demiurge + 🪽 phanes) 출전 + Top-5 또는 카테고리상/runner-up 최소 1개 획득
- [x] 4-Track milestone 구조: A=demiurge 출전 (A1-A9) · B=phanes 출전 (B1-B5) · C=공통 인프라 (C1-C4) · D=결승 (D1-D2)
- [x] XPRIZE 규정 충족 매트릭스 (2 엔트리 × 8 규정) 인덱싱
- [x] 상금 시나리오 — 최소 $100K (둘 다 runner-up) · 중간 $150K · 최대 $550K (1위 + 카테고리상)
- [x] 심사 3축 다이어그램 — dancinlab 강점=②AI-Native Ops · 약점=①매출 → ③임팩트 narrative 보완
- [x] Related domains 5건 인덱싱 (CLI+COCKPIT.md · web_gui_rfc.md · growth/XPRIZE.md · XPRIZE-RULES.md · VERTEX-AI.md)
- [x] 비-목표 5건 명시 (AWS/Azure · Claude/OpenAI 배포 LLM · 매출 인플레이션 · XPRIZE 외 대회 · 3rd 엔트리)
- [x] 사용자 3 미결정 사항 확인 ("ok check") — phanes 카테고리 분산 🔴 · GCP 크레딧 🟡 · Stripe 가격 🟡 — XPRIZE.md/CLI+COCKPIT.md 양쪽 인덱싱
- [ ] DOMAINS.tape 등재 확인 + `domain list` 표시 검증
- [ ] D-83 카운트다운 운영 — 다음 D-78 (M14 마감 2026-06-09) 까지 web-foundation 진입
