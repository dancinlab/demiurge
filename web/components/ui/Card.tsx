// Card — main 영역 클릭 가능 카드 SSOT (Link/Button wrap).
//
// 재설계 원칙(옵션 H · 완전 평면):
//   1) 배경(bg-surface-strong)·라운딩(rounded-card)·그림자(shadow-card) 없음 —
//      카드 구분은 공간(패딩 + grid gap) + 타이포 위계만.
//   2) 클릭 affordance = hover:opacity 미세 변화 + focus-visible ring(접근성).
//   3) interaction = 항상 단일 Link/anchor/button — 카드 안에 nested clickable
//      금지 (semantic accessibility).
//   4) `as="article"` 변형 — 안에 자체 버튼/링크가 있는 카드(=비-monolithic).
//
// 사용처: dashboard verb quick-launch · DashboardSummary category cards ·
//        LibraryGallery 항목 · MatterLedger summary 등.
//
// 시맨틱 토큰만 (DESIGN_TOKENS.md SSOT).

import Link from "next/link";
import type { ReactNode } from "react";

const BASE =
  "block p-4 transition hover:opacity-70 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ink";

// LinkCard — Next Link wrap. 전체 카드가 한 링크.
export function LinkCard({
  href,
  children,
  className = "",
  title,
  ariaLabel,
}: {
  href: string;
  children: ReactNode;
  className?: string;
  title?: string;
  ariaLabel?: string;
}) {
  return (
    <Link
      href={href}
      title={title}
      aria-label={ariaLabel}
      className={`group ${BASE} ${className}`}
    >
      {children}
    </Link>
  );
}

// ArticleCard — 안에 자체 액션이 있는 비-monolithic 카드 (예: LibraryGallery).
export function ArticleCard({
  children,
  className = "",
}: {
  children: ReactNode;
  className?: string;
}) {
  return (
    <article className={`${BASE} ${className}`}>{children}</article>
  );
}
