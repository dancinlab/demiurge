// TopBar — server component. Pure presentation: user, activeDomain, and i18n
// strings all come as props from (app)/layout.tsx.
// ElevenLabs 톤: 흰 surface 바 · hairline 보더 · Geist 라이트 로고 · CTA=primary.

import Link from "next/link";

type TopBarUser = { email: string; role?: string };

type TopBarI18n = {
  topbarDomains: string;
  topbarActiveProject: string;
  topbarSignIn: string;
  topbarAdmin: string;
};

export function TopBar({
  user,
  i18n,
}: {
  user: TopBarUser | null;
  // activeDomain kept for caller compat — 도메인명 칩 폐기 (브랜드는 사이드바 일원화).
  activeDomain?: string | null;
  i18n: TopBarI18n;
}) {
  // ElevenLabs 톤: 브랜드는 사이드바에만 — TopBar 는 우측 액션만 (도메인 칩·로고 폐기).
  return (
    <header className="flex items-center gap-3 border-b border-hairline bg-surface px-5 py-3 text-sm">
      <span className="flex-1" />
      <Link
        href="/dashboard"
        className="rounded-full px-2 py-1 text-xs text-muted hover:bg-surface-strong hover:text-ink"
      >
        {i18n.topbarDomains}
      </Link>
      {user?.role === "admin" && (
        <Link
          href="/admin"
          className="rounded-full border border-danger/20 bg-danger/5 px-2 py-1 text-xs text-danger hover:bg-danger/10"
        >
          ⚙️ {i18n.topbarAdmin}
        </Link>
      )}
      {user ? (
        <Link
          href="/account"
          className="rounded-full bg-surface-strong px-2.5 py-1 text-xs text-body hover:bg-hairline"
        >
          {user.email}
        </Link>
      ) : (
        <Link
          href="/signin"
          className="rounded-full bg-primary px-3 py-1 text-xs font-medium text-white hover:bg-primary-active"
        >
          {i18n.topbarSignIn}
        </Link>
      )}
    </header>
  );
}
