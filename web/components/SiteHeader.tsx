// Global sticky site header — brand + primary nav + language switcher.
// Server component: resolves its own locale/messages so the root layout
// stays declarative. Rendered once in app/layout.tsx; pages keep only
// their own page-title blocks (not site chrome).

import Link from "next/link";
import { getLocale, getMessages, t } from "@/lib/i18n";
import { LangSwitcher } from "@/components/LangSwitcher";

export async function SiteHeader() {
  const [locale, m] = await Promise.all([getLocale(), getMessages()]);

  const links = [
    { href: "/", label: t(m, "nav.dashboard") },
    { href: "/discover", label: t(m, "nav.discover") },
    { href: "/pricing", label: t(m, "nav.pricing") },
    { href: "/account", label: t(m, "nav.account") },
  ];

  return (
    <header className="sticky top-0 z-50 border-b border-neutral-200 bg-white/80 backdrop-blur-md dark:border-neutral-800 dark:bg-neutral-950/80">
      <div className="mx-auto flex h-14 max-w-5xl items-center justify-between gap-4 px-6">
        <Link href="/" className="flex items-center gap-2 font-mono font-bold">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src="/icon.svg" alt="" width={22} height={22} aria-hidden />
          <span>demiurge</span>
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
