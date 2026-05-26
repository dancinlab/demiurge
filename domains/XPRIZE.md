# XPRIZE — current state

@title: 🏆 XPRIZE — "구글 Gemini 90일 사업 대회"

@goal: dancinlab 단일 엔트리(📐 demiurge — phanes 발견엔진 8th verb로 내장)를 Build with Gemini XPRIZE 2026에 출전 — 90일 빌드(2026-05-19~08-17) + 실매출 증빙 + Vertex AI Gemini 호출 ≥1 + GCP 제품 ≥1 + 2026-08-17 제출 + 2026-09-25 LA 결승 finalist 5팀 진입 + Top-5 상금 획득 ($100K~$500K) 또는 카테고리상/runner-up($50K) 최소 1개. (Track B phanes 별도 출시 폐기 — 2026-05-27 결정 · 엔진은 `demiurge cli discover` 8th verb로 흡수, 차후 post-XPRIZE 분사 옵션 보존)

## Milestones

### Track A — demiurge 출전 (Professional Services · ② AI-Native Ops)

- [x] A1 카테고리 확정 — **Professional Services** (단일 엔트리 · phanes 분리 폐기로 내부 경쟁 0)
- [x] A2 GCP 프로젝트 `dancinlab` 생성 (2026-05-27 · 결제 계정도 `dancinlab`) → 나머지: Vertex AI · Cloud Run · Firebase · Firestore · Cloud Storage 5개 enable
- [ ] A3 Web GUI M14 web-foundation 완료 (마감 2026-06-09) — Next.js scaffold + CLI proxy + Vertex AI SDK
- [ ] A4 Web GUI M15 web-7verb-surface 완료 (마감 2026-06-30) — Gemini 호출 4 verb (spec/design/analyze/handoff)
- [ ] A5 Web GUI M16 web-realtime + auth 완료 (마감 2026-07-21) — Firebase Auth + Stripe Checkout
- [ ] A6 Web GUI M17 web-deploy + first-revenue 완료 (마감 2026-08-04) — Cloud Run go-live + 첫 유료 전환 1건
- [ ] A7 데모영상 <3분 영어 YouTube + narrative 500~1000단어 (마감 2026-08-14)
- [ ] A8 repo 심사용 공유 — `testing@devpost.com` + `judging@hacker.fund` collaborator (마감 2026-08-15)
- [ ] A9 Devpost 제출 (마감 **2026-08-17**) — 영상 + narrative + repo link + GCP 제품 사용 증빙

### ~~Track B — phanes 출전~~ (CLOSED 2026-05-27 · 단일 엔트리 집중 결정)

폐기 사유 — (1) D-83 timeline에 phanes 별도 빌드 시간 부족 · (2) demiurge `discover` 8th verb로 발견엔진 흡수 → ②AI-Native Ops narrative 1개에서 통합 노출 · (3) founder 단독 자원 집중 효과 ↑ · (4) post-XPRIZE 분사 옵션 보존.

- [x] B1 ~~카테고리 확정~~ closed (분산 무효 · A1 Professional Services 단독)
- [x] B2 ~~phanes 신규 GCP 프로젝트~~ closed (별도 프로젝트 불필요 · dancinlab 단일)
- [x] B3 ~~phanes Web product 90일 빌드~~ closed (별도 Cloud Run service 불필요)
- [x] B4 ~~phanes 데모영상 + narrative~~ closed (demiurge 데모에 `discover` 시연 포함)
- [x] B5 ~~phanes Devpost 제출~~ closed (Devpost form 1개만 · demiurge 단독)

**phanes 저장소 소유권 유지** — `bin/phanes` CLI 위치 + OUROBOROS 발견 로직 = phanes 저장소(canonical home, d3). demiurge `discover` verb는 thin subprocess wrapper일 뿐 (d4). XPRIZE 흡수 ≠ demiurge에 코드 이식, 그대로 `phanes cli discover ...` subprocess 호출 패턴 유지. post-XPRIZE 별도 SaaS 출시 시 phanes 저장소에서 그대로 분사 가능.

### Track C — 공통 인프라 (양 엔트리 공유 가능)

- [ ] C1 Stripe 계정 + 월별 장부 (5~8월) + related-party 라벨링 정책
- [ ] C2 GCP 크레딧 확인 — 신규 계정 $300 free + XPRIZE 제공분(확인 필요) → 90일 cover 추정
- [ ] C3 organic 출시 글 — X + Reddit (`growth/txt/xprize-launch.txt` 활용)
- [ ] C4 코드 repo private → judging 공유 설정 자동화 스크립트

### Track D — 결승 (finalist 진입 시)

- [ ] D1 9월 LA finalist 통보 수령 (예상 2026-09-08~15)
- [ ] D2 LA 결승 trip — 데모 + 심사위원 Q&A (2026-09-25)

## XPRIZE 규정 충족 매트릭스

| 규정 | demiurge | phanes |
|---|---|---|
| Gemini API ≥1 LLM call (배포 앱) | Vertex AI spec/design/analyze/handoff 4 verb | `hexa drill` proposer = Gemini |
| Google Cloud 제품 ≥1 | Vertex AI + Cloud Run + Firebase + Firestore + Storage = 5 GCP | Vertex AI ≥1 |
| 신규 프로젝트만 | `dancinlab` (2026-05-27 생성) | 동일 `dancinlab` 프로젝트 내 별도 Cloud Run service (substantially-different 보장은 product narrative로) |
| 매출 증빙 월별(5~8월) | Stripe + 월별 P&L | Stripe + 월별 P&L |
| related-party 분리 | 지인/내부 매출 라벨링 + 보고 제외 | 동일 |
| repo 심사용 공유 | private demiurge → testing@/judging@ | private phanes → testing@/judging@ |
| 데모영상 <3분 영어 YouTube | M17 후 RTSC end-to-end 시나리오 | phanes 자동 발견 시나리오 |
| narrative 500~1000단어 | demiurge 7-verb + ②AI-Native Ops 강조 | phanes verifier-카탈로그 + ②AI-Native Ops 강조 |

## 상금 구조

| 순위 | 상금 | dancinlab 2-엔트리 합산 시나리오 |
|---|---|---|
| 1위 | $500,000 | 1개라도 1위 → $500K |
| 2위 | $200,000 | 1개 2위 → $200K |
| 3-5위 (각) | $100,000 | 둘 다 3-5위 진입 시 $200K |
| runner-up 15팀 (각) | $50,000 | 둘 다 runner-up이면 $100K |
| 카테고리상 5팀 (각) | $50,000 | 카테고리 분산 시 둘 다 카테고리상 가능 → $100K |

**최소 시나리오** (둘 다 runner-up 또는 카테고리상): $100K
**중간 시나리오** (1개 3-5위 + 1개 runner-up): $150K
**최대 시나리오** (1위 + 카테고리상): $550K

## 심사 3축

```
   ① Business Viability   ② AI-Native Operations   ③ Category Impact
        ⅓ (매출)              ⅓ (AI 운영 정도)         ⅓ (카테고리 임팩트)
        └─────────────────────┴─────────────────────┘
                              ▼
                       합산 최고점 = 우승

   dancinlab 강점 = ② (demiurge 7-verb 자동 dispatch · phanes verifier 카탈로그)
   dancinlab 약점 = ① (매출 체급)  →  ③ 임팩트 narrative로 보완 필수
```

## 🏗️ DEMIURGE-GOOGLE-NATIVE — 인수 옵셔널리티 (2026-05-26 결정)

> 설계 목표: demiurge 모든 외부 의존을 Google 자사 서비스로 처음부터 구축 → 인수 시 0-day 전환 (코드 0줄 변경).
> 비유: 이사 갈 집의 가구를 미리 그 집 콘센트 규격으로 사놓기.

```
   현재 (XPRIZE 빌드 단계)         →        Google 인수 후 (0-day)
  ┌────────────────────────┐               ┌────────────────────────┐
  │ LLM:    Gemini Vertex  │               │ LLM:    Gemini (자사)  │
  │ 컴퓨트:  pool + GCP    │  ─acquisition─▶│ 컴퓨트:  Vertex AI 전용 │
  │ TPU:    (미사용)        │               │ TPU:    Cloud TPU       │
  │ DB:     Firestore      │               │ DB:     Firestore (자사) │
  │ Stripe: 결제 증빙       │               │ Stripe: → Google Pay 전환│
  │ Auth:   Firebase       │               │ Auth:   Workspace SSO   │
  │ pool/Vast: 과도기 only  │               │ pool/Vast: 폐기         │
  └────────────────────────┘               └────────────────────────┘
              ↓ 동일 아키텍처 · 동일 SDK · 동일 IAM
       "구글이 인수해도 바꿀 게 없다" = 인수 매력도 ↑
```

| 축 | 현재 plan | 자사-생태계 native 강화 |
|---|---|---|
| LLM | Vertex AI Gemini | ✅ 그대로 (Claude/OpenAI 0%) |
| 컴퓨트 (Web) | Cloud Run | ✅ 그대로 |
| 컴퓨트 (대형 sim) | pool ubu-1/2 + Vast.ai | GCP Compute Engine GPU (A100/H100) + Vertex AI Training (XPRIZE 빌드 후 마이그) |
| 가속기 | (미사용) | Cloud TPU v5e — Vertex AI Training pipeline 연결 (Google 자사 칩) |
| 데이터 분석 | (미사용) | BigQuery — 사용자 텔레메트리 + audit log + verify ledger |
| MLOps | (미사용) | Vertex AI Pipelines — `hexa drill` discovery 파이프라인 자동화 |
| 인증 | Firebase Auth | ✅ + Google Workspace SSO (B2B 고객) |
| 결제 | Stripe | 단계 1: Stripe (XPRIZE 매출 증빙 요구) · 단계 2: Google Pay/Play Billing 마이그 (post-acquisition) |
| 도메인 | 임시 | `dancinlab.org` GCP Cloud DNS zone · 서브도메인 `demiurge.dancinlab.org` + `phanes.dancinlab.org` |
| 모니터링 | Cloud Logging | ✅ + Cloud Trace + Cloud Profiler + Error Reporting (자사 telemetry full-stack) |
| 보안 | IAM | ✅ + VPC Service Controls + Cloud Armor + Secret Manager |
| 비용 | per-call | Committed Use Discounts (CUDs) — 90일 후 1-year commit 가능 |

비교: "AWS-first → GCP 이주"식이 아니라, 처음부터 GCP-only로 설계해 인수 시 코드 0줄 변경. (vs Anthropic이 AWS 의존이라 Amazon이 인수 협상 못 한 케이스 = 자사 의존도가 협상력)

### 후속 milestone (XPRIZE 빌드 단계에서 미리 깔아둘 것)

- [ ] Cloud DNS — `dancinlab.org` zone 생성 + 서브도메인 `demiurge.dancinlab.org` + `phanes.dancinlab.org` 등록 + Cloud Run mapping (M14 동반)
- [ ] BigQuery dataset `demiurge_telemetry` + Cloud Logging sink 연결 (M16 동반)
- [ ] Vertex AI Training pipeline 스텁 (`hexa drill` 호출 wrap) — TPU/GPU 전환 가능 구조 (M17 동반)
- [ ] Cloud TPU v5e 1-region 활성화 + Vertex AI custom training 1회 dry-run (post-M17)
- [ ] Committed Use Discounts (CUDs) 견적 — 90일 사용량 기반 1-year commit 시뮬 (post-제출)
- [ ] Google Workspace SSO 통합 plan (M16 Firebase Auth 위에 stacked)
- [ ] Stripe → Google Pay/Play Billing 마이그 contingency plan (post-acquisition 전용 · 시나리오만)

## Related domains

- `~/core/demiurge/CLI+COCKPIT.md` M14-M17 + M_submit — demiurge Web GUI = XPRIZE the product
- `~/core/demiurge/CLI+COCKPIT/web_gui_rfc.md` — 12 섹션 RFC v2 (XPRIZE 정렬)
- `~/core/growth/XPRIZE.md` — Competitions SSOT (90일 체크리스트 원본)
- `~/core/growth/XPRIZE-RULES.md` — 규정 로컬 아카이브
- `~/core/growth/VERTEX-AI.md` — Vertex AI = Gemini + GCP 동시 충족 경로

## 비-목표 (out of scope)

- ❌ XPRIZE 외 대회 (별도 growth 도메인)
- ❌ AWS · Azure · 기타 cloud (XPRIZE 규정 = GCP only-OK)
- ❌ Claude / OpenAI API를 배포 앱에 사용
- ❌ 매출 인플레이션 (related-party · 지인 매출은 별도 라벨)
- ❌ demiurge/phanes 외 신규 엔트리 (2-엔트리 집중)
