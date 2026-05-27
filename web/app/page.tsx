// Dashboard (landing) — data-driven from the web-facing DOMAINS.tape roster.
// Each card links to the per-domain page + the 7 pipeline-verb stages.

import Link from "next/link";
import { listDomains } from "@/lib/domains";
import { getMessages, t } from "@/lib/i18n";

export const dynamic = "force-dynamic"; // filesystem-backed; never cache

const VERBS = [
  "spec",
  "structure",
  "design",
  "analyze",
  "synth",
  "verify",
  "handoff",
] as const;

export default async function HomePage() {
  const [domains, m] = await Promise.all([listDomains(), getMessages()]);

  return (
    <main className="mx-auto max-w-6xl px-6 py-10 font-mono">
      <header className="mb-8">
        <h1 className="text-2xl font-bold">{t(m, "home.title")}</h1>
        <p className="text-sm text-neutral-500">
          {t(m, "home.subtitle_a")}
          <a
            href="https://www.geminixprize.com"
            className="underline"
            target="_blank"
            rel="noreferrer"
          >
            {t(m, "home.subtitle_link")}
          </a>
          {t(m, "home.subtitle_b")}
        </p>
      </header>

      <section>
        <h2 className="mb-4 text-lg font-semibold">
          {t(m, "home.domains_heading")}{" "}
          <span className="text-neutral-500">({domains.length})</span>
        </h2>
        {domains.length === 0 ? (
          <p className="text-neutral-500">
            {t(m, "home.no_domains_a")}
            <code>{t(m, "home.no_domains_code")}</code>
            {t(m, "home.no_domains_b")}
          </p>
        ) : (
          <ul className="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-3">
            {domains.map((d) => {
              const pct =
                d.progress && d.progress.total > 0
                  ? Math.round((100 * d.progress.done) / d.progress.total)
                  : null;
              return (
                <li
                  key={d.name}
                  className="flex flex-col rounded-lg border border-neutral-200 p-4 transition-colors hover:border-neutral-400 dark:border-neutral-800 dark:hover:border-neutral-600"
                >
                  <Link
                    href={`/${encodeURIComponent(d.name)}`}
                    className="group flex flex-col gap-2"
                  >
                    <div className="flex items-start justify-between gap-2">
                      <span className="font-semibold group-hover:underline">
                        {d.title ?? d.name}
                      </span>
                      {pct !== null && (
                        <span className="shrink-0 text-xs text-neutral-500">
                          {pct}%
                        </span>
                      )}
                    </div>
                    {d.goal && (
                      <p className="line-clamp-2 text-xs leading-relaxed text-neutral-500">
                        {d.goal}
                      </p>
                    )}
                    {pct !== null && (
                      <div className="mt-1 h-1.5 w-full overflow-hidden rounded-full bg-neutral-200 dark:bg-neutral-800">
                        <div
                          className="h-full rounded-full bg-violet-500"
                          style={{ width: `${pct}%` }}
                        />
                      </div>
                    )}
                  </Link>
                  <nav className="mt-3 flex flex-wrap gap-x-2 gap-y-1 border-t border-neutral-100 pt-3 text-[11px] text-neutral-400 dark:border-neutral-900">
                    {VERBS.map((v) => (
                      <Link
                        key={v}
                        href={`/${v}/${encodeURIComponent(d.name)}`}
                        className="hover:text-violet-500 hover:underline"
                      >
                        {v}
                      </Link>
                    ))}
                  </nav>
                </li>
              );
            })}
          </ul>
        )}
      </section>

      <footer className="mt-10 border-t border-neutral-200 pt-4 text-xs text-neutral-500 dark:border-neutral-800">
        {t(m, "home.footer_a")}<code>DOMAINS.tape</code>{t(m, "home.footer_b")}
        <code>demiurge cli</code>{t(m, "home.footer_c")}
      </footer>
    </main>
  );
}
