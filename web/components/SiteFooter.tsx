// Global site footer — Brutalist (검정 · 흰 4px 보더 · 노랑 액센트 · UPPERCASE).
// Hidden on /dashboard via <HideOnDashboard> in app/layout.tsx.

import Link from "next/link";
import { getMessages, t } from "@/lib/i18n";

export async function SiteFooter() {
  const m = await getMessages();
  const year = new Date().getFullYear();

  const links = [
    { href: "/pricing", label: t(m, "nav.pricing") },
    { href: "/account", label: t(m, "nav.account") },
  ];

  return (
    <footer
      className="mt-auto border-t-4 border-white bg-black text-white"
      style={{ fontFamily: "ui-sans-serif, system-ui, -apple-system, 'Helvetica Neue', sans-serif" }}
    >
      <div className="mx-auto flex max-w-6xl flex-col gap-6 px-6 py-10 text-xs uppercase sm:flex-row sm:items-center sm:justify-between">
        <div className="flex items-center gap-3">
          <span className="text-lg font-black tracking-tighter" style={{ letterSpacing: "-0.04em" }}>
            DEMIURGE<span className="text-yellow-300">.</span>
          </span>
          <span className="tracking-widest text-white/60">SPEC → VERIFY → HANDOFF</span>
        </div>
        <nav className="flex items-center gap-1">
          {links.map((l) => (
            <Link
              key={l.href}
              href={l.href}
              className="border-2 border-white px-3 py-1.5 font-black tracking-widest hover:bg-yellow-300 hover:text-black"
            >
              {l.label}
            </Link>
          ))}
          <a
            href="https://www.geminixprize.com"
            target="_blank"
            rel="noreferrer"
            className="border-2 border-white bg-yellow-300 px-3 py-1.5 font-black tracking-widest text-black hover:bg-white"
          >
            BUILT WITH GEMINI
          </a>
        </nav>
        <span className="tracking-widest text-white/60">© {year} DANCINLAB</span>
      </div>
    </footer>
  );
}
