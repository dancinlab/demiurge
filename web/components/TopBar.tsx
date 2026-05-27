// TopBar — server component. Pure presentation: user, activeDomain, and i18n
// strings all come as props from (app)/layout.tsx.
// shadcn Modern 톤: accent = slate-900 (검정).

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
  return (
    <header className="flex items-center gap-3 border-b border-slate-200 bg-white px-5 py-3 text-sm shadow-sm">
      <Link
        href="/dashboard"
        className="font-semibold tracking-tight text-slate-900 hover:text-slate-700"
      >
        📐 demiurge
      </Link>
      {activeDomain && (
        <>
          <span className="text-slate-300" aria-hidden="true">/</span>
          <Link
            href={`/dashboard?d=${encodeURIComponent(activeDomain)}`}
            title={i18n.topbarActiveProject}
            className="rounded-[6px] bg-slate-100 px-2 py-0.5 font-mono text-xs text-slate-700 hover:bg-slate-200"
          >
            {activeDomain}
          </Link>
        </>
      )}
      <span className="flex-1" />
      <Link
        href="/dashboard"
        className="rounded-[6px] px-2 py-1 text-xs text-slate-600 hover:bg-slate-100 hover:text-slate-900"
      >
        {i18n.topbarDomains}
      </Link>
      {user?.role === "admin" && (
        <Link
          href="/admin"
          className="rounded-[6px] border border-rose-200 bg-rose-50 px-2 py-1 text-xs text-rose-700 hover:bg-rose-100"
        >
          ⚙️ {i18n.topbarAdmin}
        </Link>
      )}
      {user ? (
        <Link
          href="/account"
          className="rounded-[6px] bg-slate-100 px-2.5 py-1 text-xs text-slate-700 hover:bg-slate-200"
        >
          {user.email}
        </Link>
      ) : (
        <Link
          href="/signin"
          className="rounded-[6px] bg-slate-900 px-3 py-1 text-xs font-medium text-white hover:bg-slate-800"
        >
          {i18n.topbarSignIn}
        </Link>
      )}
    </header>
  );
}
