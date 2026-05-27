# 🎨 demiurge web — ElevenLabs 디자인 토큰 SSOT

> (app) 서피스의 라인색·표면·잉크·라운딩·모션의 **단일 출처(single source of truth)**.
> 정의 위치 = `app/globals.css` 의 `@theme` 블록. 이 문서는 그 캐논 레퍼런스다.

## 멱등성 규칙 (반드시 지킬 것)

1. 컴포넌트는 **시맨틱 유틸만** 쓴다 — `bg-canvas` · `bg-surface` · `border-hairline`
   · `text-ink` · `text-muted` · `rounded-panel` · `shadow-card`.
2. **금지** — `bg-white` · `bg-gray-50` · `border-gray-200` · `text-gray-900`
   · `rounded-[6px]` · `rounded-lg`(임의값) 같은 하드코딩 / 비시맨틱 값.
3. 색·라운딩을 바꿔야 하면 **토큰 한 줄만** 고친다 → 전 화면이 일관되게 따라온다.
4. 액센트 컬러(indigo·blue 등) 금지. 유일한 컬러 모먼트 = **파스텔 orb 그라데이션**.

## 팔레트 (ElevenLabs)

| 시맨틱 | 토큰 | 값 | 유틸 |
|---|---|---|---|
| 페이지 캔버스 | `--color-canvas` | `#f5f5f5` | `bg-canvas` |
| 캔버스 soft | `--color-canvas-soft` | `#fafafa` | `bg-canvas-soft` |
| 카드 표면 | `--color-surface` | `#ffffff` | `bg-surface` |
| 표면 strong(뱃지) | `--color-surface-strong` | `#f0efed` | `bg-surface-strong` |
| 다크 표면 elevated | `--color-ink-elevated` | `#1c1917` | `bg-ink-elevated` |
| 잉크(제목) | `--color-ink` | `#0c0a09` | `text-ink` `bg-ink` |
| 본문 | `--color-body` | `#4e4e4e` | `text-body` |
| 본문 strong | `--color-body-strong` | `#292524` | `text-body-strong` |
| muted | `--color-muted` | `#777169` | `text-muted` |
| muted soft | `--color-muted-soft` | `#a8a29e` | `text-muted-soft` |
| CTA pill | `--color-primary` | `#292524` | `bg-primary` |
| CTA active | `--color-primary-active` | `#0c0a09` | `bg-primary-active` |
| 헤어라인 soft | `--color-hairline-soft` | `#f0efed` | `border-hairline-soft` |
| 헤어라인 기본 | `--color-hairline` | `#e7e5e4` | `border-hairline` |
| 헤어라인 strong | `--color-hairline-strong` | `#d6d3d1` | `border-hairline-strong` |
| 성공 | `--color-success` | `#16a34a` | `text-success` |
| 위험 | `--color-danger` | `#dc2626` | `text-danger` |
| orb mint/peach/lavender/sky/rose | `--color-orb-*` | `#a7e5d3` `#f4c5a8` `#c8b8e0` `#a8c8e8` `#e8b8c4` | 그라데이션 전용 |

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

## 타이포

| 토큰 | 폰트 | 비고 |
|---|---|---|
| `--font-display` | Geist (ElevenLabs Waldenburg 대체) | 제목 — `font-display font-light tracking-tight` (weight 300 · -0.02em) |
| `--font-sans` | Inter | 본문·내비·캡션 |
| `--font-mono` | Geist Mono | 코드·식별자 |

## 모션 · 그림자

| 토큰 | 값 | 용도 |
|---|---|---|
| `--ease-brand` | `cubic-bezier(.23,1,.32,1)` | 등장 0.4s · `ease-brand` |
| hover | 0.15s | hover transition |
| `--shadow-card` | `0 4px 16px rgba(0,0,0,.04)` | 카드 hover soft-drop · `shadow-card` |

## 마케팅 서피스 격리

마케팅(`(marketing)`)은 Brutalist(black/yellow)로 **무변경**. 위 토큰은 전부 신규
시맨틱 유틸명이라 마케팅의 기존 클래스(`bg-black`·`rounded-xl` 등)와 충돌하지 않는다.
