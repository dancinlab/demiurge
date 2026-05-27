# 🧪 e2e — Playwright QA conformance

`/sbs full` QA 의 마지막 2 ⚠️ (visible/auth · Q13 mobile) 를 닫는 e2e 셋.

## 실행

```bash
cd web
npm install
npm run e2e:install           # 브라우저 바이너리 한 번만
npm run e2e                   # 모든 spec · desktop + iPhone
PLAYWRIGHT_BASE_URL=http://localhost:3000 npm run e2e     # 로컬
DEMIURGE_SESSION_COOKIE=<val> npm run e2e                 # 인증 spec 포함
```

## 스펙

| 파일 | 검증 |
|---|---|
| `conformance.spec.ts › public surfaces` | /library 둘러보기 버튼 · /matter 헤더 · /structure/qubit `data-scene="JosephsonScene"` |
| `conformance.spec.ts › authenticated surface` | /dashboard DashboardSummary 카테고리 카드 (Cookie 없으면 skip) |

## CI

`PLAYWRIGHT_BASE_URL` 미설정 시 기본값 `https://demiurge.dancinlab.org` 로 prod hit. CI 에서는 secret `DEMIURGE_SESSION_COOKIE` 주입.
