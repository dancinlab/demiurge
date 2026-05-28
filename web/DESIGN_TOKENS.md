# 🎨 demiurge web — ElevenLabs 디자인 토큰 SSOT

> (app) 서피스의 라인색·표면·잉크·라운딩·모션의 **단일 출처(single source of truth)**.
> 정의 위치 = `app/globals.css` 의 `@theme` (라이트) + `.dark { … }` (다크) 블록.
> 값 출처 = ElevenLabs 앱 실제 컴파일 CSS (2026-05-28 사용자 제공) — **쿨 뉴트럴 hue 240**, 저채도.

## 멱등성 규칙 (반드시 지킬 것)

1. 컴포넌트는 **시맨틱 유틸만** 쓴다 — `bg-canvas` · `bg-surface` · `border-hairline`
   · `text-ink` · `text-muted` · `bg-primary` · `text-on-primary` · `bg-inverted`
   · `text-on-inverted` · `rounded-panel` · `shadow-card`.
2. **금지** — `bg-white` · `bg-gray-50` · `border-gray-200` · `text-gray-900`
   · `rounded-[6px]` · `rounded-lg`(임의값) 같은 하드코딩 / 비시맨틱 값.
3. 색·라운딩을 바꿔야 하면 **토큰 한 줄만** 고친다 → 전 화면이 일관되게 따라온다 (라이트·다크 둘 다).
4. 액센트 컬러(indigo·blue 등) 금지. 유일한 컬러 모먼트 = **파스텔 orb 그라데이션**.

## 팔레트 — 라이트 (ElevenLabs 쿨 hue 240)

| 시맨틱 | 토큰 | 값 (HSL) | 유틸 |
|---|---|---|---|
| 페이지 캔버스 | `--color-canvas` | `hsl(0 0% 98%)` ≈ `#fafafa` | `bg-canvas` |
| 캔버스 soft | `--color-canvas-soft` | `hsl(240 5% 96%)` | `bg-canvas-soft` |
| 카드 표면 | `--color-surface` | `#ffffff` | `bg-surface` |
| 표면 strong(active·hover) | `--color-surface-strong` | `hsl(240 5% 96%)` | `bg-surface-strong` |
| ink elevated | `--color-ink-elevated` | `hsl(240 6% 10%)` | `bg-ink-elevated` |
| 잉크(제목 텍스트) | `--color-ink` | `hsl(240 3% 6%)` (= EL foreground) | `text-ink` |
| 본문 | `--color-body` | `hsl(240 4% 36%)` (gray-600) | `text-body` |
| 본문 strong | `--color-body-strong` | `hsl(240 5% 26%)` | `text-body-strong` |
| muted | `--color-muted` | `hsl(240 4% 46%)` (gray-500) | `text-muted` |
| muted soft | `--color-muted-soft` | `hsl(240 5% 65%)` (gray-400) | `text-muted-soft` |
| CTA fill | `--color-primary` | `hsl(240 3% 6%)` (= EL btn-primary `hsl(foreground)`) | `bg-primary` |
| CTA active | `--color-primary-active` | `hsl(240 4% 16%)` | `bg-primary-active` |
| CTA 위 텍스트 | `--color-on-primary` | `#ffffff` | `text-on-primary` |
| 반전 fill(말풍선·배지·progress·avatar) | `--color-inverted` | `hsl(240 3% 6%)` | `bg-inverted` |
| 반전 fill 위 텍스트 | `--color-on-inverted` | `#ffffff` | `text-on-inverted` |
| 헤어라인 soft | `--color-hairline-soft` | `hsl(240 5% 96%)` | `border-hairline-soft` |
| 헤어라인 기본 | `--color-hairline` | `hsl(240 6% 90%)` (gray-200) | `border-hairline` |
| 헤어라인 strong | `--color-hairline-strong` | `hsl(240 5% 84%)` (gray-300) | `border-hairline-strong` |
| 성공 | `--color-success` | `#16a34a` | `text-success` |
| 위험 | `--color-danger` | `#dc2626` | `text-danger` |
| orb mint/peach/lavender/sky/rose | `--color-orb-*` | `#a7e5d3` `#f4c5a8` `#c8b8e0` `#a8c8e8` `#e8b8c4` | 그라데이션 전용 |

## 팔레트 — 다크 `.dark` (ElevenLabs 실제 값)

| 시맨틱 | 다크 값 | 비고 |
|---|---|---|
| `--color-canvas` | `hsl(240 3% 6%)` ≈ `#0f0f10` | EL 다크 bg (순흑 아님) |
| `--color-canvas-soft` | `hsl(240 4% 9%)` | |
| `--color-surface` | `hsl(240 4% 11%)` | 카드 |
| `--color-surface-strong` | `hsl(240 4% 16%)` | active·hover |
| `--color-ink-elevated` | `hsl(240 4% 16%)` | |
| `--color-ink` | `hsl(0 0% 98%)` | 흰 텍스트 |
| `--color-body` | `hsl(240 5% 84%)` | |
| `--color-body-strong` | `hsl(240 6% 90%)` | |
| `--color-muted` | `hsl(240 5% 65%)` | |
| `--color-muted-soft` | `hsl(240 4% 46%)` | |
| `--color-hairline-soft` | `hsl(0 0% 100% / 0.04)` | 흰 alpha |
| `--color-hairline` | `hsl(0 0% 100% / 0.09)` | EL 다크 border = alpha |
| `--color-hairline-strong` | `hsl(0 0% 100% / 0.14)` | |
| `--color-inverted` | `hsl(0 0% 98%)` | **flip** — 다크에선 밝은 fill |
| `--color-on-inverted` | `hsl(240 3% 6%)` | 그 위 검정 텍스트 |
| `--color-primary` | `hsl(0 0% 98%)` | **flip** — 다크 CTA = 흰색 |
| `--color-primary-active` | `hsl(0 0% 90%)` | |
| `--color-on-primary` | `hsl(240 3% 6%)` | |
| `--color-success` | `#22c55e` | |
| `--color-danger` | `#ef4444` | |

## 라운딩 스케일

| 토큰 | 값 | 용도 | 유틸 |
|---|---|---|---|
| `--radius-tag` | 4px | 인라인 태그 | `rounded-tag` |
| `--radius-chip` | 6px | 컴팩트 행·칩 | `rounded-chip` |
| `--radius-control` | 8px | 폼 인풋·버튼 | `rounded-control` |
| `--radius-panel` | 12px | 컴팩트 카드·밴드 | `rounded-panel` |
| `--radius-card` | 16px | 피처 카드 | `rounded-card` |
| `--radius-orb` | 24px | orb 그라데이션 카드 | `rounded-orb` |
| (pill / full) | 9999px | CTA·뱃지·아바타 | `rounded-full` |

## 타이포 (ElevenLabs 앱 실측)

| 토큰 | 폰트 | 비고 |
|---|---|---|
| `--font-sans` | **Atkinson Hyperlegible** | 본문 기본 (EL `body { font-family: Atkinson Hyperlegible }` 와 동일) — 가독성 튜닝 |
| `--font-display` | **Inter** | 제목·헤딩 (EL `h1, h2 { font-family: Inter }` 와 동일) |
| `--font-mono` | Geist Mono | 코드·식별자 |
| `--font-serif` | Cormorant Garamond | legacy 잔존(없애지 않음) |

로더 = `app/layout.tsx` next/font/google. html className 에 모든 `*.variable` 노출.

## 모션 · 그림자

| 토큰 | 값 | 용도 |
|---|---|---|
| `--ease-brand` | `cubic-bezier(.23,1,.32,1)` | 등장 0.4s · `ease-brand` |
| hover | 0.15s | hover transition |
| `--shadow-card` | `0 4px 16px rgba(0,0,0,.04)` | 카드 hover soft-drop · `shadow-card` |

## 다크모드 아키텍처

- 토글 = `components/ThemeToggle.tsx` (next-themes `attribute="class"`, light↔dark).
- `<html>` 에 `.dark` 가 붙으면 `globals.css` 의 `.dark { … }` 오버라이드가 시맨틱 토큰을 전부 다크값으로 뒤집는다 (plain `@theme` → :root CSS var 방출 → `.dark` 재정의 유효).
- **inverted 분리가 핵심**: `--color-ink` 는 *텍스트*(다크에선 밝아짐), `--color-inverted` 는 *fill*(다크에선 밝은 칩으로 반전). 둘을 한 토큰으로 묶으면 다크에서 fill 이 깨지므로 분리.
- fill 유틸은 `bg-ink` 가 아니라 `bg-inverted` + `text-on-inverted` 를 쓴다(말풍선·배지·progress·avatar). primary CTA 위 텍스트는 `text-white` 대신 `text-on-primary`.
- EL btn-primary 패턴: `background: hsl(foreground)` · `color: hsl(background)` → 우리 `--color-primary` = ink 와 같은 값, 다크에서 자동 flip.
- **범위 외**: WebGL 3D 씬(`JosephsonR3F`)의 머티리얼/조명 색은 CSS 토큰을 따르지 않는다 (호스트 캔버스 배경만 추종, 별도 PR 에서 쿨 그레이로 정정 예정).

## 마케팅 서피스 격리

마케팅(`(marketing)`)은 Brutalist(black/yellow)로 **무변경**. 위 토큰은 전부 신규 시맨틱 유틸명이라 마케팅의 기존 클래스(`bg-black`·`rounded-xl` 등)와 충돌하지 않는다.
