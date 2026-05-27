# 🎨 demiurge Web GUI + CLI — 설계 결정 (2026-05-28)

`/sbs full` 16 라운드 disambiguation 결과. 다음 세션이 이 문서만 봐도 청사진 복원 가능해야 한다.

---

## 0. 표면 (surface) — d10/d4

| 표면 | 사용자 | 진입 |
|---|---|---|
| Web GUI | 고객 (회원 구독자 only) | `demiurge.dancinlab.org` (Next.js 16 · Cloud Run) |
| CLI | 고객 + AI 에이전트 | `demiurge cli <verb>` |

→ 둘 다 같은 uid 인증 · Firestore 동일 적재 (Q-DB).

---

## 1. 16 결정 (Q1~Q16 + Q14′)

| # | 결정 | 메모 |
|---|---|---|
| Q1 | 좌측 = 2 컬럼 (8 verb tree · 🧑‍🍳 AI 요리선생 항상 펼침) | 비유: 식당 메뉴 + 서버 |
| Q2 | 메인 = 위 record JSON · 아래 시각화 슬롯 · 맨아래 history | split layout |
| Q3 | 상단 TopBar = 프로젝트 selector + 사용자 + `/admin`(관리자만) | role: user/admin |
| Q4 | 유료 서비스 = 구독 회원만 (대시보드 접근 게이트) | A |
| Q5 | DB = Firestore (`users/{uid}/projects/{pid}/records`) | g1 |
| Q6 | 3D = React Three Fiber (R3F) | g1 |
| Q7 | 권한 = b+C (handoff 가능 포함) | |
| Q8 | UI 변형 = A | |
| Q9 | 요리선생 = 항상 펼침 (접을 수 없음) | |
| Q10 | 팀 seat = 프로젝트 공동 데이터 공유 | Firestore `members[]` |
| Q11 | 결제 = single-active 스위치 (stripe ⟷ lemonsqueezy) · `/admin`만 토글 · 사용자 UI 불변 | "수도꼭지" |
| Q11' | GPU/LLM = multi-enabled + priority (vast/runpod/vertex · vertex_gemini) · fallback | "택시 디스패처" |
| Q12 | verb별 시각화 슬롯 8종 (아래 표) | |
| Q13 | 풀 반응형 (R3F 터치 컨트롤 포함) | C |
| Q14 | 온보딩 = 데모 프로젝트 사전 적재 (sign-up 직후 dashboard) | C |
| Q14′ | 데모 1건 = **QUBIT** (Google Willow 정렬) | XPRIZE |
| Q15 | ~~SYSTEM 17~~ **폐기 (2026-05-28)** — 5 카테고리 × 20 도메인만 | reverted |
| Q16 | stdlib 정리 = 인덱스 only · demiurge `CATEGORIES.tape` + `STDLIB_MATRIX.tape` · hexa-lang stdlib 무변 (d3) | A |
| Q17 | 랜딩페이지 = **무변경** (현재 디자인 유지) · 변경은 인증 후 surface(/dashboard 등)만 | guard |
| Q18 | **무료 공개 도메인 라이브러리** — founder 계속 등록 · 게스트 view OK · 회원만 fork · `PUBLIC_DOMAINS.tape` 매니페스트 · 단일 도메인 + 합성(HBM 등) 둘 다 등록 가능 | A |

### Q12 verb별 시각화 슬롯

| verb | 슬롯 | 컴포넌트 |
|---|---|---|
| spec | 📜 form | 입력 폼 + 목표 카드 |
| structure | 🧊 3D | R3F viewer (격자·지오메트리) |
| design | 📐 schematic | SVG 블록다이어그램 |
| analyze | 📊 chart | Plotly · pgfplots |
| synthesize | 🧪 ladder | 단계 카드 수직 |
| verify | 🟢 matrix | g5 색 매트릭스 |
| handoff | 📦 dossier | PDF/zip 썸네일 |
| discover | 🌳 tree | kick/gap 분기 |

---

## 2. ASCII 청사진

```
┌─ TopBar ─── 프로젝트 selector · 사용자 · /admin(관리자만) ─────┐
├─ Left-① 8 verb tree ────┬─ Main split ───────────────────────┤
│  📜 spec        ●현재   │  ┌────────────────────────┐         │
│  🧊 structure          │  │ record JSON (위)        │         │
│  📐 design             │  ├────────────────────────┤         │
│  📊 analyze    🟢      │  │ 시각화 슬롯 (verb별)    │         │
│  🧪 synthesize         │  ├────────────────────────┤         │
│  🟢 verify    🟢       │  │ history (아래)          │         │
│  📦 handoff            │  └────────────────────────┘         │
│  🌳 discover           │                                      │
├─ Left-② 🧑‍🍳 요리선생 ──┤  현재 단계 = 테두리 색 강조          │
│  AI 조수 (항상 펼침)    │  완료=🟢 진행중=🟡 미시작=⚪          │
└────────────────────────┴──────────────────────────────────────┘
```

### 백엔드 라우팅 (사용자 UI 불변)

```
        ┌─ stripe ⦿ (active 1개)
   💳 ──┤
        └─ lemonsqueezy ○   ← /admin 스위치 (single-active)

        ┌─ vast    ☑ p1
   🎮 ──┼─ runpod  ☑ p2 (fallback)
        └─ vertex  ☑ p3

   🧠 ── vertex_gemini ☑ p1 (XPRIZE 필수)
```

---

## 3. 분류 (5 카테고리 × 20 도메인)

| 카테고리 | n | 도메인 |
|---|---|---|
| 🔬 ATOM | 3 | qubit · antimatter · fusion |
| 🧱 MATTER | 7 | perovskite · graphene · rtsc · metamaterial · aerogel · spintronic · memristor |
| 🪪 CHIP | 2 | neuromorphic · photonic |
| 🧬 BIO | 4 | gene-edit · rna-therapy · organoid · protein-fold |
| ⚗️ CHEMISTRY | 4 | electrocat · photoredox · co2-capture · green-nh3 |

20 frontier × 7 verb = 140 셀 풀배선 (`STDLIB_MATRIX.tape` 참조). SYSTEM 카테고리는 2026-05-28 폐기.

### 무료 공개 도메인 라이브러리 (`PUBLIC_DOMAINS.tape`)

founder(dancinlab)가 계속 등록 — 사용자/게스트는 `/library`에서 갤러리로 열람, 회원은 fork해서 자기 방향으로.

| 권한 | 게스트 | 회원 | founder |
|---|---|---|---|
| /library 보기 | ✓ | ✓ | ✓ |
| fork → 내 private | ✕ (회원가입 prompt) | ✓ | ✓ |
| 신규 등록 / 버전업 | ✕ | ✕ | ✓ |

엔트리는 단일 도메인 (예: QUBIT v1.0) + 합성 도메인 (예: HBM v0.3 = chip+memristor+matter) 모두 허용. 시간이 지나면서 카탈로그가 계속 자라남.

---

## 4. Firestore 스키마

```
users/{uid}                   { role: "user" | "admin", seats: [...] }
users/{uid}/projects/{pid}    { name, demo: bool, members: [uid,...] }
users/{uid}/projects/{pid}/records/{rid}    { verb, payload, status, ts }
providers/payment             { active: "stripe", available: ["stripe","lemonsqueezy"] }
providers/gpu/{id}            { enabled, priority }
providers/llm/{id}            { enabled, priority }
```

---

## 5. 9-step stacked PR plan (g4)

| # | PR | 내용 | LOC | 상태 |
|---|---|---|---|---|
| 0 | `stdlib-matrix-index` | `STDLIB_MATRIX.tape` + `CATEGORIES.tape` | ~180 | ✅ 작성됨 |
| 1 | `api-gateway` | /api/v1 라우터 + auth middleware | ~150 | |
| 2 | `provider-registry` | Firestore providers/* + admin toggle UI | ~180 | |
| 3 | `common-components` | TopBar · LeftTree · MainSplit · 요리선생 | ~190 | |
| 4 | `8-verb-pages` | spec/structure/.../discover 페이지 살붙이기 | ~190 | |
| 5 | `r3f-viewer` | structure 슬롯 + QUBIT Josephson 3D | ~170 | |
| 6 | `qubit-demo-seed` | sign-up 시 QUBIT 데모 자동 적재 | ~120 | |
| 7 | `payment-switch` | stripe ⟷ lemonsqueezy 라우터 + /admin | ~150 | |
| 8 | ~~`system-domains`~~ | SYSTEM 폐기 (2026-05-28) — 빈 슬롯 | — | dropped |

총 1,510 LOC · g4 stacked · d17 cost-bearing fire (autonomous, vast→runpod fallback).

---

## 6. CLI ↔ stdlib 연결 (Q17)

```
Browser ──▶ /api/v1/run ──▶ Cloud Run ──▶ demiurge cli action <verb> <DOM>
   │                                              │
   │                                              ▼
   │                          ~/.hx/packages/demiurge/domains/<DOM>.demi
   │                                              │
   │                                              ▼
   │                                      cellrun.hexa (hexa-lang)
   │                                              │
   │                                              ▼
   │                                  stdlib/<DOM>/<verb>.hexa (SSOT)
   │                                              │
   ◀──── Firestore record ◀──── exports/<DOM>/<verb>/<stamp>/
```

→ Web/CLI 둘 다 같은 `STDLIB_MATRIX.tape` 인덱스 읽음 (`GET /api/v1/matrix` · `demiurge cli matrix`).

---

## 7. XPRIZE 정렬

- Gemini API ≥1 (Vertex AI · LLM provider)
- GCP 제품 ≥5 (Vertex · Cloud Run · Firebase · Firestore · Storage)
- 매출 증빙 = stripe active (post-XPRIZE lemonsqueezy 토글 가능)
- 데모 = QUBIT (Google Willow 정렬)
- 마감 2026-08-17 Devpost 제출
