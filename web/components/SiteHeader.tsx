// Global sticky site header — brand + primary nav + language switcher.
// Server component: resolves its own locale/messages so the root layout
// stays declarative. Rendered once in app/layout.tsx; pages keep only
// their own page-title blocks (not site chrome).

import Link from "next/link";
import { getLocale, getMessages, t } from "@/lib/i18n";
import { LangSwitcher } from "@/components/LangSwitcher";
import { readSession } from "@/lib/session";

export async function SiteHeader() {
  const [locale, m, session] = await Promise.all([
    getLocale(),
    getMessages(),
    readSession(),
  ]);
  const signedIn = session !== null;

  // dashboard + account surface only when signed in; discover lives
  // INSIDE the dashboard (8-verb spine), never a public nav item.
  const links = signedIn
    ? [
        { href: "/dashboard", label: t(m, "nav.dashboard") },
        { href: "/pricing", label: t(m, "nav.pricing") },
        { href: "/account", label: t(m, "nav.account") },
      ]
    : [
        { href: "/pricing", label: t(m, "nav.pricing") },
        { href: "/signin", label: t(m, "nav.signin") },
      ];

  return (
    <header className="sticky top-0 z-50 border-b border-neutral-200 bg-white/80 backdrop-blur-md dark:border-neutral-800 dark:bg-neutral-950/80">
      <div className="mx-auto flex h-14 max-w-5xl items-center justify-between gap-4 px-6">
        <Link href="/" aria-label="demiurge — home" className="flex items-center">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src="/logo.svg" alt="demiurge" width={106} height={27} />
        </Link>
        <nav className="flex items-center gap-4 font-mono text-sm">
          {links.map((l) => (
            <Link
              key={l.href}
              href={l.href}
              className="text-neutral-600 hover:text-neutral-950 dark:text-neutral-400 dark:hover:text-neutral-50"
            >
              {l.label}
            </Link>
          ))}
          <LangSwitcher current={locale} />
        </nav>
      </div>
    </header>
  );
}
