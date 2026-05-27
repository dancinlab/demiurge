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
  activeDomain,
  i18n,
}: {
  user: TopBarUser | null;
  activeDomain: string | null;
  i18n: TopBarI18n;
}) {
  // ElevenLabs 톤: 웜 뉴트럴 + Geist 라이트 로고 + 파스텔/액센트 무 (CTA=espresso).
  return (
    <header className="flex items-center gap-3 border-b border-hairline bg-surface px-5 py-3 text-sm">
      <Link
        href="/dashboard"
        className="font-display text-lg font-light tracking-tight text-ink hover:text-ink"
      >
        📐 demiurge
      </Link>
      {activeDomain && (
        <>
          <span className="text-muted-soft" aria-hidden="true">/</span>
          <Link
            href={`/dashboard?d=${encodeURIComponent(activeDomain)}`}
            title={i18n.topbarActiveProject}
            className="rounded-full bg-surface-strong px-2 py-0.5 font-mono text-xs text-ink hover:bg-hairline"
          >
            {activeDomain}
          </Link>
        </>
      )}
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
