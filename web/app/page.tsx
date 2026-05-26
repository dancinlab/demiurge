// M14 domain index — server component reads DOMAINS.tape roster directly.
// Per-domain dashboards land in M15; this page lists the roster only.

import Link from "next/link";
import { listDomains } from "@/lib/domains";

export const dynamic = "force-dynamic"; // filesystem-backed; never cache

export default async function HomePage() {
  const domains = await listDomains();

  return (
    <main className="mx-auto max-w-5xl px-6 py-10 font-mono">
      <header className="mb-8 flex items-start justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold">demiurge</h1>
          <p className="text-sm text-neutral-500">
            8-verb pipeline · 3-surface (CLI · Cockpit · Web) ·{" "}
            <a
              href="https://www.geminixprize.com"
              className="underline"
              target="_blank"
              rel="noreferrer"
            >
              Gemini XPRIZE 2026
            </a>{" "}
            entry
          </p>
        </div>
        <nav className="flex gap-3 text-sm">
          <Link href="/pricing" className="underline">
            pricing
          </Link>
          <Link href="/account" className="underline">
            account
          </Link>
          <Link href="/discover" className="underline">
            discover
          </Link>
        </nav>
      </header>

      <section>
        <h2 className="mb-3 text-lg font-semibold">
          Domains{" "}
          <span className="text-neutral-500">({domains.length})</span>
        </h2>
        {domains.length === 0 ? (
          <p className="text-neutral-500">
            No domains registered yet. Run{" "}
            <code>demiurge cli list-domains</code> from the repo root.
          </p>
        ) : (
          <ul className="grid grid-cols-1 gap-2 md:grid-cols-2">
            {domains.map((d) => {
              const pct =
                d.progress && d.progress.total > 0
                  ? Math.round((100 * d.progress.done) / d.progress.total)
                  : null;
              return (
                <li key={d.name}>
                  <Link
                    href={`/${encodeURIComponent(d.name)}`}
                    className="block rounded border border-neutral-200 px-4 py-3 hover:bg-neutral-50 dark:border-neutral-800 dark:hover:bg-neutral-900"
                  >
                    <div className="flex items-center justify-between gap-2">
                      <span className="font-semibold">
                        {d.title ?? d.name}
                      </span>
                      {pct !== null && (
                        <span className="shrink-0 text-xs text-neutral-500">
                          {d.progress!.done}/{d.progress!.total} · {pct}%
                        </span>
                      )}
                    </div>
                    {d.goal && (
                      <p className="mt-1 line-clamp-2 text-xs text-neutral-500">
                        {d.goal}
                      </p>
                    )}
                  </Link>
                </li>
              );
            })}
          </ul>
        )}
      </section>

      <footer className="mt-10 border-t border-neutral-200 pt-4 text-xs text-neutral-500 dark:border-neutral-800">
        SSOT: <code>DOMAINS.tape</code> · dispatch: <code>demiurge cli</code> ·
        LLM: Vertex AI Gemini (M15+) · host: Cloud Run · demiurge.dancinlab.org
      </footer>
    </main>
  );
}
