# Web GUI RFC — 3rd surface = Gemini XPRIZE 출전 엔트리

> CLI+COCKPIT M14-M17. demiurge 7-verb pipeline의 **브라우저** surface = 동시에 **Build with Gemini XPRIZE 2026** 출전 product. 기존 2 surface(`demiurge cli` · Swift `CockpitApp`)와 **병행** — Swift Cockpit deprecate 아님.
>
> **전략 결정 (2026-05-26)**:
> - LLM = **Gemini** (Claude 아님) · **Vertex AI 경유** → Gemini API + GCP 제품 ≥1 요건 동시 충족
> - 인프라 = **Google Cloud (GCP)** · Cloud Run / Vertex AI / Firebase / Cloud Storage
> - 스택 = **Next.js (TypeScript)** · React 시각화 생태계 + g1 ai-native
> - 마감 = **2026-08-17 제출** · **2026-09-25 LA 결승**
>
> 참고: `~/core/growth/XPRIZE.md` · `~/core/growth/XPRIZE-RULES.md` · `~/core/growth/VERTEX-AI.md`

## 0. 3-surface 구조 (Gemini XPRIZE 정렬)

```
                    ┌─────────── demiurge ───────────┐
                    │                                 │
   ┌──────────┐     │  ┌──────────┐    ┌──────────┐  │
   │   CLI    │     │  │  Swift   │    │   Web    │  │
   │ demiurge │     │  │ Cockpit  │    │   GUI    │  │ ← XPRIZE 출전 엔트리
   │   cli    │     │  │ (macOS)  │    │ (browser)│  │
   └────┬─────┘     │  └────┬─────┘    └─────┬────┘  │
        │           │       │                │       │
        │ AI agent  │       │ desktop user   │ 실사용자 (B2C/B2B SaaS)
        │ (Claude)  │       │ (로컬 LLM)      │ (Gemini via Vertex AI)
        └───────────┴───────┴────────────────┘       │
                            │                        │
                    ┌───────▼────────┐               │
                    │ exports/**     │  (typed records SSOT)
                    └────────────────┘               │
                            │                        │
                    ┌───────▼────────┐               │
                    │ hexa-lang      │               │
                    │ stdlib SSOT    │               │
                    └────────────────┘               │
                                                     │
                    └────────────────────────────────┘
```

| 축 | CLI | Swift Cockpit | Web GUI (= XPRIZE 출전) |
|---|---|---|---|
| 언어 | Swift (`DemiurgeCLI`) | Swift (`CockpitApp`) | TypeScript (Next.js) |
| 사용자 | AI agent · 자동화 | macOS 데스크톱 (개인) | **실사용자 · 매출 발생자** |
| LLM | (개발용 Claude Code) | 로컬 | **Gemini via Vertex AI** |
| 호스팅 | 로컬 바이너리 | `.app` bundle (M18) | **GCP Cloud Run** |
| 인증 | — | macOS local | **Firebase Auth + Stripe Customer** |
| 결제 | — | — | **Stripe 통합** (월별 매출 증빙) |
| 데이터 | `exports/**` typed records | `exports/**` typed records | `exports/**` + GCP Cloud Storage 미러 |
| XPRIZE 역할 | 개발 도구 | local 평가 도구 | **the product** |

## 1. XPRIZE 규정 충족 매트릭스

| 규정 | 충족 방식 | 위치 |
|---|---|---|
| Gemini API ≥1 LLM call (배포 앱) | `hexa drill` proposer · 7-verb spec/design 단계 LLM 어시스트 = **Vertex AI Gemini** | `app/api/llm/route.ts` (서버사이드 호출, API key 노출 금지) |
| Google Cloud 제품 ≥1 필수 | Vertex AI 자체가 GCP 제품 · 동시 Cloud Run 호스팅 + Firebase Auth + Cloud Storage = **GCP 4개 사용** | 전반 |
| 신규 프로젝트만 (제출 시작 ≥ 2026-05-19) | 새 GCP 프로젝트 ID `dancinlab` 신설 (2026-05-27 · 결제 계정도 `dancinlab`) · 기존 demiurge 엔진은 "enhance" disclose | GCP console + Devpost narrative |
| 매출 증빙 월별(5~8월) + related-party 분리 | Stripe 결제 + monthly P&L · 지인/내부 매출은 별도 라벨 + 보고 제외 | `web/lib/billing.ts` · 회계장부 |
| 코드 repo 심사용 공유 (private면 `testing@`/`judging@`) | demiurge repo `Settings → Manage access` → 두 계정 collaborator 추가 (제출 직전) | GitHub settings |
| 데모영상 <3분 영어 YouTube + 500~1000단어 narrative | 결승 trip 전 제작 (M17 완료 후) | 별도 |

## 2. 핵심 원칙 (변경 없음)

| 원칙 | 적용 |
|---|---|
| **d3** 구현 코드는 canonical home 한 곳 | Web GUI는 별도 구현 추가 금지 — 모든 dispatch는 `demiurge cli` subprocess (XPRIZE "기존 엔진 enhance" 패턴과 일치) |
| **d4** 단일 generic dispatch | Web의 모든 verb 호출 = `demiurge cli action <verb> <domain>` subprocess + stdout 파싱 |
| **g1** ai-native + canonical first | Next.js App Router + Server Actions + Vertex AI SDK = canonical 패턴 |
| **g_cockpit_isolation** | Web GUI도 동일 — `exports/**` typed records read만, hexa-lang/stdlib 직접 import 금지 |
| **g5** verify verbatim | `hexa verify` 출력 verbatim 렌더 — LLM(Gemini 포함) 가공 금지 |
| **g0** Occam | Vertex AI = Gemini + GCP 한 도구로 2 요건 동시 충족 |

## 3. 7-verb surface mapping (Web · Gemini 어시스트 위치)

각 verb = Next.js page `/verb/<name>/<domain>` + `app/api/<verb>/route.ts` (CLI proxy).
Gemini 호출 = **🔵 표시** 위치 (배포 앱 LLM call 요건 충족).

| Verb | 페이지 | 핵심 UI | CLI 라우팅 | Gemini 호출 |
|---|---|---|---|---|
| spec | `/spec/<domain>` | `<DOMAIN>.md` viewer + `@goal:` 편집기 + milestone | `demiurge cli action spec <dom>` | 🔵 `@goal` draft 어시스트 (사용자 핫스팟 입력 → Gemini가 spec 초안 제안) |
| structure | `/structure/<domain>` | 의존 graph (cytoscape.js) + ASCII fallback | `demiurge cli action structure <dom>` | — (deterministic) |
| design | `/design/<domain>` | design.md SSOT + D-number reservation | `demiurge cli list-decisions` | 🔵 D-decision 후보 brainstorm (다중 옵션 비교 narrative) |
| analyze | `/analyze/<domain>` | `/cycle` 라이브 tail + iteration 그래프 | `demiurge cli action analyze <dom>` SSE | 🔵 분석 요약 — 라운드 결과를 사용자에게 자연어 요약 |
| synthesize | `/synth/<domain>` | GCP host status grid + dispatch form | `demiurge cli action synth <dom>` SSE | — (deterministic) |
| **verify** | `/verify/<domain>` | rubric 색상 ledger + per-claim 카드 + verbatim 블록 | `hexa verify --expr/--fence` + `hexa atlas stats` | ❌ verify는 g5 — LLM 가공 금지 (verbatim render only) |
| handoff | `/handoff/<domain>` | packet preview + cross-project linkage map | `demiurge cli action verify ... --handoff` | 🔵 handoff narrative 생성 (다음 stage receiver에게 한국어/영어 핸드오버 노트) |

→ **Gemini 호출 4 verb** (spec · design · analyze · handoff). XPRIZE 요건 "≥1 LLM call" 풍부히 초과.

## 4. 라우팅 아키텍처 (GCP 정렬)

```
browser ─HTTPS─▶ Cloud Run  (Next.js Node 20+ 컨테이너)
                   │
                   ├─ React Server Component  (정적 read · exports/** 미러 read)
                   │
                   ├─ API Route /api/<verb>
                   │    │
                   │    └─ child_process.spawn('demiurge', ['cli', ...])
                   │           or
                   │       (CLI를 Cloud Run 컨테이너에 동봉 → in-process exec)
                   │
                   └─ API Route /api/llm
                        │
                        └─ Vertex AI SDK   (@google-cloud/vertexai)
                              │
                              └─ Gemini 2.5 (or latest 모델 ID)

Auth   :  Firebase Auth  (Google sign-in · 이메일 sign-up)
결제   :  Stripe Checkout + webhook → Firestore subscriptions
저장소 :  Cloud Storage 'dancinlab-exports'  (exports/** 미러)
DB     :  Firestore  (user · subscription · audit log)
모니터링:  Cloud Logging + Cloud Monitoring  (g5 verify trail)
```

**컨테이너 전략**: demiurge CLI 바이너리 + hexa stdlib + Next.js prod build을 **단일 Docker 이미지**로 빌드 → Cloud Run 1-region deploy. 콜드 스타트 허용 (실사용자 워크플로 = read-heavy).

## 5. realtime — 장기 동작 관찰

| 동작 | 채널 | 클라이언트 |
|---|---|---|
| `/cycle` 라운드 진행 | SSE (`text/event-stream`) | EventSource API + React state |
| Gemini streaming response | SSE (Vertex AI streamGenerateContent) | 동일 |
| host status (GCP Compute Engine 또는 Vertex AI batch) | Firestore listener (실시간 push) | onSnapshot |
| atlas stats hash | Cloud Run health probe + 30s polling | SWR |

WebSocket 미사용 (Cloud Run = HTTP/1.1 stream OK, WebSocket = 비용 + 복잡성).

## 6. 다중 도메인 navigation

```
/                              ← 도메인 인덱스 (DOMAINS.tape roster + 진행도)
/<DOMAIN>                      ← per-도메인 dashboard (M1-M? 진행 + @goal)
/<DOMAIN>/log                  ← <DOMAIN>.log.md tail
/<DOMAIN>/verify               ← g5 5-tier ledger
/<DOMAIN>/handoff              ← cross-project linkage map
/pricing                       ← Stripe 플랜 (XPRIZE 매출 surface)
/account                       ← Firebase Auth 사용자 dashboard
```

**우선 지원 도메인** (XPRIZE 데모 시연용): demiurge meta · RTSC · NOREFLOW · CARDIO+.

## 7. 인증 · 결제 (XPRIZE 매출 surface)

| 항목 | 방안 |
|---|---|
| 인증 | Firebase Auth (Google sign-in + 이메일 + 패스워드리스 이메일 링크) |
| 결제 | Stripe Checkout — 월정액 SaaS · related-party 라벨링 (대회 보고용) |
| 가격 모델 (초안) | $29/mo Solo · $99/mo Team (5 seat) · $299/mo Org (25 seat) · 14일 무료 trial |
| 권한 | RBAC 4 role: viewer · author · admin · owner |
| 감사 로그 | Cloud Logging + Firestore `audit_logs/{uid}/...` (XPRIZE 매출 증빙 trail) |

⚠ secret(.env 류 키) — GCP Secret Manager로만 inject. local dev = `~/.config/demiurge-web/secrets.json` (gitignore).

## 8. 호스팅 (M18 확장 / GCP)

```
GCP project: dancinlab  (신규 — 2026-05-27 생성 · 결제 계정도 dancinlab)
  ├─ Cloud Run service          'demiurge-web'           (Next.js + CLI 바이너리)
  ├─ Vertex AI                  Gemini 호출 (us-central1)
  ├─ Firebase Auth              사용자 인증
  ├─ Firestore                  user · subscription · audit log
  ├─ Cloud Storage              'dancinlab-exports' (exports/** 미러)
  ├─ Stripe (third-party)       결제 + webhook
  └─ Cloud Build                CI/CD (GitHub repo → 자동 컨테이너 빌드 + Cloud Run deploy)
```

**비용 추정 (월)**:
- Cloud Run: ~$0-50 (cold start, 트래픽 의존)
- Vertex AI Gemini: ~$0.075/1M input · ~$0.30/1M output (트래픽 의존, MVP 단계 ~$50/mo 추정)
- Firestore: free tier (<50k reads/day)
- Firebase Auth: free tier (<50k MAU)
- Cloud Storage: ~$0.02/GB (exports/** 미러 ~10GB → ~$0.2/mo)
- **GCP 크레딧 사용** — 신규 GCP 계정 $300 free credit + XPRIZE 제공 크레딧 (확인 필요)

→ MVP 단계 월 비용 ~$50-100, XPRIZE 크레딧으로 90일 cover 가능 추정.

## 9. 단계 / milestone (CLI+COCKPIT.md M14-M17)

| M | 범위 | 산출 | LOC 예상 | 마감 |
|---|---|---|---|---|
| M14 web-foundation | Next.js 스캐폴드 + `demiurge cli` subprocess proxy API + 도메인 인덱스 + **GCP 프로젝트 생성 + Vertex AI enable** | `web/` · `package.json` · `app/api/cli/route.ts` · `gcp/project.tf` (or manual) | ~700 | 2026-06-09 |
| M15 web-7verb-surface | 7-verb 페이지 + `hexa verify` verbatim + recharts + **Gemini 호출 4 verb** (spec/design/analyze/handoff) | `app/<verb>/<domain>/page.tsx` × 7 + `app/api/llm/route.ts` | ~2000 | 2026-06-30 |
| M16 web-realtime + auth | SSE 채널 + `/cycle` 라이브 tail + **Firebase Auth + Stripe Checkout 통합** | `app/api/stream/route.ts` · `lib/firebase.ts` · `lib/stripe.ts` | ~1000 | 2026-07-21 |
| M17 web-domain-nav + deploy | DOMAINS.tape parser + 진행도 dashboard + **Cloud Run 배포** + 첫 유료 전환 1건 | `lib/domains.ts` · `Dockerfile` · `cloudbuild.yaml` · go-live | ~800 | 2026-08-04 |
| (post-M17) | 데모영상 + narrative + repo 공유 + 제출 | YouTube + Devpost + GitHub access | — | **2026-08-17 제출** |

→ M14 → M17 = **70일** (2026-05-26 ~ 2026-08-04) · 13일 buffer.

## 10. open questions

| Q | 옵션 | 결정자 |
|---|---|---|
| Gemini 모델 버전 | Gemini 2.5 Pro · Gemini 2.5 Flash · 가격/품질 trade-off | M14 진입 시 — Flash로 시작 |
| Cloud Run 컨테이너에 hexa-lang 바이너리 동봉? vs 별도 GCP 서비스 분리? | 동봉 단일 컨테이너 = 단순 · 분리 = 스케일 | M14 PoC 후 결정 |
| `hexa verify` 호출 — 컨테이너 in-process? 또는 외부 호스트 ssh? | in-process = latency ↓ · 외부 = 상태 격리 | M15 진입 시 |
| Stripe 가격 모델 — 월정액 vs 사용량 기반 | 월정액 = 매출 예측 · 사용량 = upside | M16 진입 시 — 월정액 우선 |
| repo 공유 시점 | M17 완료 후 (제출 직전) · 또는 M14 직후 | 제출 직전 (2026-08-14 경) |
| 데모영상 시나리오 | 단일 도메인 end-to-end (예: RTSC 발견 → verify → handoff) vs 다중 도메인 비교 | M17 후 — RTSC 단일 시나리오 우선 |

## 11. 비-목표 (out of scope)

- ❌ Web GUI에서 hexa-lang stdlib 직접 호출 (d3/d4 위배)
- ❌ Web GUI 전용 SSOT 추가
- ❌ Swift Cockpit deprecate (3-surface 병행 유지)
- ❌ AWS · Azure · 기타 cloud (XPRIZE 규정 = GCP only-OK)
- ❌ Claude / OpenAI API를 배포 앱에 사용 (XPRIZE 규정 = Gemini 배포 LLM 필수)
- ❌ 모바일 native 앱 (브라우저 반응형으로만 커버)
- ❌ Tailscale 폐쇄망 배포 (GCP Cloud Run public = XPRIZE 실사용자 onboarding 필요)

## 12. 참고 · 시드

- **XPRIZE 규정**: `~/core/growth/XPRIZE-RULES.md` (로컬 아카이브) · 공식 https://www.geminixprize.com/rules
- **Vertex AI 친근 설명**: `~/core/growth/VERTEX-AI.md`
- **growth Competitions SSOT**: `~/core/growth/XPRIZE.md` (90일 체크리스트)
- Swift Cockpit `cockpit/Package.swift` `g_cockpit_isolation` invariant
- `demiurge cli action verify bio` 출력 패턴 (M6 verify surface verbatim)
- M18_deploy.md `.app` 배포 절차 (Cloud Run deploy 평행 추가)

---

**상태**: DRAFT v2 (XPRIZE 정렬) · GCP 프로젝트 `dancinlab` 생성 완료 (2026-05-27) · 다음 = Vertex AI enable + secret CLI 토큰 주입 + M15 live Gemini 호출 검증.
