# 🤝 HANDOFF — demiurge Web GUI + CLI 9-step plan 인계 (2026-05-28)

이 문서 하나로 다음 세션이 이어받아 계속 빌드할 수 있다.

---

## 1. 어디까지 끝났나

| PR | 제목 | 상태 | merged | 핵심 |
|---|---|---|---|---|
| #388 | PR#0 stdlib-matrix-index | ✅ MERGED | 2026-05-27 | 4 design SSOT manifest |
| #389 | PR#1 api-gateway | ✅ MERGED | 2026-05-27 | /api/v1/{matrix,categories,public-domains,me} |
| #391 | PR#2 provider-registry | ✅ MERGED | 2026-05-27 | Firestore providers/registry + /admin |
| #392 | PR#3 common-components | ✅ MERGED | 2026-05-27 | TopBar · VerbTreeNav · MainSplitPane · CookChefRail |
| #393 | PR#4 8-verb-pages | ✅ MERGED | 2026-05-27 | VerbShell + 8 dynamic [domain] routes |
| #394 | PR#5 r3f-viewer | ✅ MERGED | 2026-05-27 | StructureViewer + QUBIT Josephson scene |
| #395 | PR#6 qubit-demo-seed | ✅ MERGED | 2026-05-27 | sign-up 자동 QUBIT 데모 적재 |
| #396 | PR#7 payment-switch | ✅ MERGED | 2026-05-27 | stripe ⟷ lemonsqueezy 라우터 |

총 7 PR · ~1,300 LOC · 0 npm install · 0 GPU rent.

---

## 2. 설계 SSOT (먼저 읽을 파일)

| 파일 | 역할 |
|---|---|
| `domains/WEB_GUI_DESIGN.md` | 18 라운드 결정 + ASCII 청사진 + 9-step plan |
| `domains/STDLIB_MATRIX.tape` | 140 셀 매트릭스 (20 도메인 × 7 verb) |
| `domains/CATEGORIES.tape` | 5 카테고리 × 20 도메인 |
| `domains/PUBLIC_DOMAINS.tape` | 무료 공개 라이브러리 (QUBIT v1.0 + HBM v0.3) |

---

## 3. 새 API surface

| method · path | 역할 | 권한 |
|---|---|---|
| GET `/api/v1/matrix` | STDLIB_MATRIX → JSON | public |
| GET `/api/v1/categories` | CATEGORIES → JSON | public |
| GET `/api/v1/public-domains` | PUBLIC_DOMAINS → JSON | public |
| GET `/api/v1/me` | session + role | auth |
| GET `/api/v1/providers` | registry 읽기 | public |
| POST `/api/v1/providers` | registry 토글 | admin |
| POST `/api/v1/checkout` | payment switch 진입 | auth |
| POST `/api/lemonsqueezy/webhook` | LS 이벤트 처리 | HMAC verified |

---

## 4. 새 컴포넌트 / lib

```
web/
  lib/
    tape.ts            minimal .tape parser
    providers.ts       Firestore providers/registry CRUD + DEFAULT_REGISTRY
    seed.ts            seedQubitDemo(uid)
    lemonsqueezy.ts    REST + HMAC-SHA256 webhook verify
  components/
    TopBar.tsx         프로젝트 selector + /admin (admin만)
    VerbTreeNav.tsx    8-verb spine · status dot
    MainSplitPane.tsx  3-band (record · slot · history)
    CookChefRail.tsx   🧑‍🍳 항상 펼침
    VerbShell.tsx      8 verb 페이지 공통 셸
    AdminToggles.tsx   client · payment radio + GPU/LLM checkbox
    StructureViewer.tsx  CSS-3D 원자 viewer
    JosephsonScene.tsx   QUBIT Al/AlOx/Al
  app/(app)/
    admin/page.tsx     admin-only (role check redirect)
    {spec,structure,design,analyze,synth,verify,handoff,discover}/[domain]/page.tsx
```

---

## 5. 환경 변수 (서비스 활성 전 필수)

```
FIREBASE_WEB_API_KEY=...                  # 기존
STRIPE_SECRET_KEY=...                     # 기존 (active=stripe 동안)
STRIPE_WEBHOOK_SECRET=...                 # 기존
STRIPE_PRICE_{SOLO,TEAM,ORG}=...          # 기존
LEMONSQUEEZY_API_KEY=...                  # 신규 (PR#7)
LEMONSQUEEZY_STORE_ID=...                 # 신규
LEMONSQUEEZY_WEBHOOK_SECRET=...           # 신규
LEMONSQUEEZY_VARIANT_{SOLO,TEAM,ORG}=...  # 신규
DEMIURGE_DATA_ROOT=...                    # 선택 (없으면 process.cwd()/..)
```

Firestore admin 권한 부여:
```bash
# users/{uid} 도큐먼트에 role 필드 추가
{ "role": "admin" }
```

---

## 6. 아직 안 한 것 (다음 세션 우선순위)

1. **R3F 패키지 도입** — `@react-three/fiber` · `three` · `@react-three/drei`. 현재 CSS-3D 플레이스홀더. JosephsonScene을 진짜 3D로.
2. **8 verb slot 실 viewer** — Q12 매핑 (spec=📜form · design=📐SVG · analyze=📊chart · synth=🧪ladder · verify=🟢matrix · handoff=📦dossier · discover=🌳tree). 현재 placeholder div.
3. **/library 페이지** — `domains/PUBLIC_DOMAINS.tape` 갤러리. 게스트 view OK · 회원 fork.
4. **fork 액션** — `POST /api/v1/projects/fork { sourceId }` → 사용자 private 프로젝트 복제.
5. **discover (8th verb) phanes 브리지** — `~/core/phanes/bin/phanes` subprocess 호출.
6. **/matter ledger 페이지** — material attestation/verdict 노출.
7. **R3F 풀 반응형 터치 컨트롤** (Q13).
8. **dashboard 새 셸로 마이그레이션** — 기존 WorkbenchSpine/WorkbenchMenu → VerbShell 점진 통합.
9. **i18n** — 새 TopBar/VerbTreeNav/CookChefRail 한국어 + en/ja/zh/ru.

---

## 7. 알려진 한계 / 주의

- **PR#4 8-verb-pages**가 기존 `(app)/{verb}/[domain]/page.tsx` 449 LOC를 placeholder 25 LOC로 대체. 기존 verb 로직 코드가 사라짐 — 다음 PR에서 실 viewer로 복원 + 강화 필요.
- **Q17 guard**: 랜딩페이지 (`(marketing)/`) 무변경 유지. 어떤 PR도 marketing 디렉토리 건드리지 않음.
- **payment switch 기본** = `stripe` (XPRIZE 매출 증빙). lemonsqueezy로 토글은 post-XPRIZE.
- **R3F 미설치** = `npm install` 1줄로 활성 (`web/components/StructureViewer.tsx`의 placeholder 주석 따라).
- **tape parser 한계** = 17-type alphabet (@S @U @A @T @R @H @D @K @P @? @I @X @F @N @C @L @V) · multi-line array 미지원 (single-line만).

---

## 8. memory / SSOT 인덱스

다음 세션 시작 시 자동 로드되는 메모리:
- `MEMORY.md` → `project_demiurge_web_gui_design.md` · `project_demiurge_stdlib_matrix.md` · `project_demiurge_7verb_production_gated.md`
- `CLAUDE.md` (이 repo 루트) — d1~d19 거버넌스 + d_paper_* + 카테고리 정책

---

## 9. 한 줄 시작 가이드 (다음 세션이 첫 명령으로 쓸 것)

```
이전 세션이 PR#388~#396 7개를 merge 했어요.
domains/HANDOFF.md 읽고, "다음 우선순위 1번 R3F 패키지 도입" 부터 진행.
```
