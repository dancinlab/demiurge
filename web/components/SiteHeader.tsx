// Global sticky site header — Brutalist tone (검정 · 흰 4px 보더 · 노랑 액센트
// · 과대 산세리프 UPPERCASE). Hidden on /dashboard via <HideOnDashboard> wrapper
// in app/layout.tsx so the workbench keeps its own Mono chrome.

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

  const links = signedIn
    ? [
        { href: "/dashboard", label: t(m, "nav.dashboard") },
        { href: "/pricing",   label: t(m, "nav.pricing") },
        { href: "/account",   label: t(m, "nav.account") },
      ]
    : [
        { href: "/pricing", label: t(m, "nav.pricing") },
        { href: "/signin",  label: t(m, "nav.signin") },
      ];

  return (
    <header
      className="sticky top-0 z-50 border-b-4 border-white bg-black text-white"
      style={{ fontFamily: "ui-sans-serif, system-ui, -apple-system, 'Helvetica Neue', sans-serif" }}
    >
      <div className="mx-auto flex h-14 max-w-6xl items-center justify-between gap-4 px-6">
        <Link
          href="/"
          aria-label="demiurge — home"
          className="font-black uppercase tracking-tighter text-white hover:text-yellow-300"
          style={{ fontSize: 22, letterSpacing: "-0.04em" }}
        >
          DEMIURGE<span className="text-yellow-300">.</span>
        </Link>
        <nav className="flex items-center gap-1 text-xs uppercase">
          {links.map((l) => (
            <Link
              key={l.href}
              href={l.href}
              className="border-2 border-white px-3 py-1.5 font-black tracking-wider hover:bg-yellow-300 hover:text-black"
            >
              {l.label}
            </Link>
          ))}
          <span className="ml-2">
            <LangSwitcher current={locale} />
          </span>
        </nav>
      </div>
    </header>
  );
}
