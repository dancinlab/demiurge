# brand assets — canonical generator

데미우르지 로고 자산은 **단일 스크립트**가 결정론적으로 생성합니다. 채팅에서 ad-hoc Python으로 만들지 마세요(재발 방지 — 과거 다섯 차례 화살표/루프 미세결함의 원인).

## 무엇을 만드나

| 산출물 | 경로 | 용도 |
|---|---|---|
| favicon | `web/app/icon.svg` | 브라우저 탭(다크모드 자동 적응) |
| 가로 워드마크 | `web/public/logo.svg` | 헤더·푸터·문서 |
| apple-icon (180²) | `web/app/apple-icon.png` | iOS 홈 추가 |
| OG (1200×630) | `web/app/opengraph-image.png` | 링크 공유 카드 |

## 디자인 불변식 (HARD-asserted)

스크립트가 **빌드-실패**로 강제하는 두 가지:

```
i1  loop_outer ≤ hex_inner − safety   ⇒ 루프가 육각형 안에 확실히 들어옴
i2  hex 정점들 ⊆ viewBox               ⇒ 마크가 SVG 영역 밖으로 잘리지 않음
```

루프 비율(`LR`)·stroke 비율·viewBox 크기·중심 좌표 어느 하나라도 잘못 건드리면 스크립트가 즉시 에러 + 위반 수치를 찍고 종료합니다.

## 어떻게 재생성

```bash
# 사전 1회: 시스템에 rsvg-convert (apple-icon/OG PNG 변환용)
brew install librsvg

# 실행
cd web && node scripts/gen-brand.mjs
# 또는 repo root에서: node web/scripts/gen-brand.mjs
```

성공 시 4개 자산이 갱신되고 `i1 clearance` 수치가 출력됩니다. `git diff`로 의도된 변경인지 확인 후 커밋하세요.

## 튜닝 노브 (한 곳에서만)

`gen-brand.mjs` 상단의 `LR`, `STROKE_RATIO`, `GAP_*`, `CHEVRON_*`, `PALETTE`만 만지면 모든 자산이 일관되게 따라옵니다. 임시 변형을 위해 자산을 직접 손편집하지 마세요 — 다음 실행에서 덮어쓰입니다.

## 재발 방지 사례

| 과거 사고 | 이번에 막힌 메커니즘 |
|---|---|
| 화살표가 곡선에서 떨어져 보임 | 셰브론 + 유한차분 접선 (생성기에 내장) |
| 루프가 육각 밖으로 벗어남 | invariant **i1** (수치 clearance assert) |
| 워드마크 마크가 잘림 | invariant **i2** (viewBox bbox assert) |
| 자산 갱신이 라이브 반영 안 됨 | 단일 생성기 → 한 번에 4개 동시 갱신 → diff 단일 PR |
