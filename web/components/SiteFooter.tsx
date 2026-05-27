// Global site footer — brand chrome shown on every page below the content.
// Page-specific footnotes still live inside each page's own <footer>.

import Link from "next/link";
import { getMessages, t } from "@/lib/i18n";

export async function SiteFooter() {
  const m = await getMessages();
  const year = new Date().getFullYear();

  const links = [
    { href: "/discover", label: t(m, "nav.discover") },
    { href: "/pricing", label: t(m, "nav.pricing") },
    { href: "/account", label: t(m, "nav.account") },
  ];

  return (
    <footer className="mt-auto border-t border-neutral-200 dark:border-neutral-800">
      <div className="mx-auto flex max-w-5xl flex-col gap-4 px-6 py-8 font-mono text-xs text-neutral-500 sm:flex-row sm:items-center sm:justify-between">
        <div className="flex items-center gap-2">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src="/logo.svg" alt="demiurge" width={94} height={24} />
          <span className="text-neutral-400 dark:text-neutral-600">
            · spec → verify → handoff
          </span>
        </div>
        <nav className="flex items-center gap-4">
          {links.map((l) => (
            <Link key={l.href} href={l.href} className="hover:underline">
              {l.label}
            </Link>
          ))}
          <a
            href="https://www.geminixprize.com"
            target="_blank"
            rel="noreferrer"
            className="hover:underline"
          >
            Built with Gemini
          </a>
        </nav>
        <span className="text-neutral-400 dark:text-neutral-600">
          © {year} dancinlab
        </span>
      </div>
    </footer>
  );
}
