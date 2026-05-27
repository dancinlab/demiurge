// TopBar — server component. Pure presentation: user, activeDomain, and i18n
// strings all come as props from (app)/layout.tsx.
// shadcn Modern 톤: accent = gray-900 (검정).

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
  // ara 톤: gray 회색조 + indigo accent + Cormorant 세리프 로고.
  return (
    <header className="flex items-center gap-3 bg-white px-5 py-3 text-sm">
      <Link
        href="/dashboard"
        className="font-serif text-lg font-semibold tracking-tight text-gray-900 hover:text-gray-900"
      >
        📐 demiurge
      </Link>
      {activeDomain && (
        <>
          <span className="text-gray-300" aria-hidden="true">/</span>
          <Link
            href={`/dashboard?d=${encodeURIComponent(activeDomain)}`}
            title={i18n.topbarActiveProject}
            className="rounded-full bg-gray-100 px-2 py-0.5 font-mono text-xs text-gray-900 hover:bg-gray-200"
          >
            {activeDomain}
          </Link>
        </>
      )}
      <span className="flex-1" />
      <Link
        href="/dashboard"
        className="rounded-full px-2 py-1 text-xs text-gray-600 hover:bg-gray-100 hover:text-gray-900"
      >
        {i18n.topbarDomains}
      </Link>
      {user?.role === "admin" && (
        <Link
          href="/admin"
          className="rounded-full border border-rose-200 bg-rose-50 px-2 py-1 text-xs text-rose-700 hover:bg-rose-100"
        >
          ⚙️ {i18n.topbarAdmin}
        </Link>
      )}
      {user ? (
        <Link
          href="/account"
          className="rounded-full bg-gray-100 px-2.5 py-1 text-xs text-gray-700 hover:bg-gray-200"
        >
          {user.email}
        </Link>
      ) : (
        <Link
          href="/signin"
          className="rounded-full bg-gray-900 px-3 py-1 text-xs font-medium text-white hover:bg-gray-800"
        >
          {i18n.topbarSignIn}
        </Link>
      )}
    </header>
  );
}
