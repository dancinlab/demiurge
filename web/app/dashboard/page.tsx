// /dashboard — the authenticated MAIN workbench. The 3-column cockpit
// (the macOS SwiftUI GUI was scrapped 2026-05-27; this web workbench is
// now the sole user surface). 3 columns:
//   ① left rail   — 8-verb spine (discover at top + the 7-verb pipeline)
//   ② work zone   — active domain: @goal · progress · snapshot · log tail
//   ③ assist rail — Gemini-assisted verb shortcuts
// Auth-gated: guests are redirected to /signin.

import Link from "next/link";
import { redirect } from "next/navigation";
import fs from "node:fs/promises";
import path from "node:path";
import { currentUser } from "@/lib/session";
import { listDomains } from "@/lib/domains";
import { getMessages, t } from "@/lib/i18n";
import { DomainSwitcher } from "@/components/DomainSwitcher";

export const dynamic = "force-dynamic";

const REPO_ROOT =
  process.env.DEMIURGE_DATA_ROOT ?? path.resolve(process.cwd(), "..");

// 8-verb spine — discover (8th, head) sits ABOVE the canonical 7.
const SPINE: Array<{ verb: string; domainScoped: boolean }> = [
  { verb: "discover", domainScoped: false },
  { verb: "spec", domainScoped: true },
  { verb: "structure", domainScoped: true },
  { verb: "design", domainScoped: true },
  { verb: "analyze", domainScoped: true },
  { verb: "synth", domainScoped: true },
  { verb: "verify", domainScoped: true },
  { verb: "handoff", domainScoped: true },
];

export default async function DashboardPage({
  searchParams,
}: {
  searchParams: Promise<{ d?: string }>;
}) {
  const [user, m, domains, sp] = await Promise.all([
    currentUser(),
    getMessages(),
    listDomains(),
    searchParams,
  ]);
  if (!user) redirect("/signin");

  const names = domains.map((d) => d.name);
  const active =
    (sp.d && domains.find((d) => d.name === sp.d)) || domains[0] || null;

  let mdBody = "";
  let logTail = "";
  if (active) {
    try {
      mdBody = await fs.readFile(path.join(REPO_ROOT, active.mdPath), "utf8");
    } catch {
      mdBody = "(unable to read .md)";
    }
    try {
      const logFull = await fs.readFile(
        path.join(REPO_ROOT, active.logPath),
        "utf8"
      );
      logTail = logFull.split("\n").slice(0, 60).join("\n");
    } catch {
      logTail = "(no log yet)";
    }
  }

  const pct =
    active?.progress && active.progress.total > 0
      ? Math.round((100 * active.progress.done) / active.progress.total)
      : null;
  const activeName = active?.name ?? "";

  return (
    <main className="mx-auto flex h-screen max-w-[1600px] flex-col font-mono">
      {/* ④ top toolbar */}
      <div className="flex items-center justify-between gap-4 border-b border-neutral-200 px-6 py-3 dark:border-neutral-800">
        <div className="flex items-center gap-3">
          <span className="text-sm font-bold">{t(m, "dashboard.title")}</span>
          {names.length > 0 && (
            <DomainSwitcher names={names} current={activeName} />
          )}
        </div>
        {pct !== null && (
          <div className="flex items-center gap-2">
            <span className="text-xs text-neutral-500">
              {active!.progress!.done}/{active!.progress!.total}
            </span>
            <div className="h-2 w-40 overflow-hidden rounded-full bg-neutral-200 dark:bg-neutral-800">
              <div
                className="h-full rounded-full bg-neutral-900 dark:bg-neutral-100"
                style={{ width: `${pct}%` }}
              />
            </div>
            <span className="text-xs font-semibold">{pct}%</span>
          </div>
        )}
      </div>

      <div className="grid flex-1 grid-cols-[180px_1fr_240px] overflow-hidden">
        {/* ① left rail — 8-verb spine */}
        <nav className="flex flex-col gap-1 overflow-y-auto border-r border-neutral-200 p-3 text-sm dark:border-neutral-800">
          <span className="mb-1 text-[11px] uppercase tracking-wide text-neutral-400">
            {t(m, "dashboard.spine")}
          </span>
          {SPINE.map(({ verb, domainScoped }, i) => {
            const href =
              domainScoped && activeName
                ? `/${verb}/${encodeURIComponent(activeName)}`
                : `/${verb}`;
            return (
              <Link
                key={verb}
                href={href}
                className="flex items-center gap-2 rounded px-2 py-1.5 text-neutral-600 hover:bg-neutral-100 hover:text-neutral-900 dark:text-neutral-400 dark:hover:bg-neutral-900 dark:hover:text-neutral-50"
              >
                <span className="w-4 text-right text-[11px] text-neutral-400">
                  {i === 0 ? "8" : i}
                </span>
                <span>{verb}</span>
              </Link>
            );
          })}
        </nav>

        {/* ② work zone */}
        <section className="overflow-y-auto px-6 py-5">
          {!active ? (
            <p className="text-neutral-500">{t(m, "dashboard.empty")}</p>
          ) : (
            <>
              <header className="mb-4">
                <h1 className="text-xl font-bold">
                  {active.title ?? active.name}
                </h1>
                {active.goal && (
                  <p className="mt-2 whitespace-pre-line text-sm text-neutral-600 dark:text-neutral-400">
                    <span className="font-semibold">@goal:</span> {active.goal}
                  </p>
                )}
              </header>
              <h2 className="mb-2 text-xs uppercase tracking-wide text-neutral-400">
                snapshot
              </h2>
              <pre className="mb-5 overflow-x-auto rounded border border-neutral-200 bg-neutral-50 p-3 text-xs dark:border-neutral-800 dark:bg-neutral-900">
                {mdBody}
              </pre>
              <h2 className="mb-2 text-xs uppercase tracking-wide text-neutral-400">
                log
              </h2>
              <pre className="overflow-x-auto rounded border border-neutral-200 bg-neutral-50 p-3 text-xs dark:border-neutral-800 dark:bg-neutral-900">
                {logTail}
              </pre>
            </>
          )}
        </section>

        {/* ③ assist rail */}
        <aside className="flex flex-col gap-3 overflow-y-auto border-l border-neutral-200 p-3 text-sm dark:border-neutral-800">
          <span className="text-[11px] uppercase tracking-wide text-neutral-400">
            {t(m, "dashboard.assist")}
          </span>
          {activeName && (
            <div className="flex flex-col gap-2">
              <Link
                href={`/spec/${encodeURIComponent(activeName)}`}
                className="rounded border border-neutral-200 px-3 py-2 hover:border-neutral-500 hover:bg-neutral-50 dark:border-neutral-800 dark:hover:border-neutral-500 dark:hover:bg-neutral-900"
              >
                ✍️ {t(m, "dashboard.assist_spec")}
              </Link>
              <Link
                href={`/analyze/${encodeURIComponent(activeName)}`}
                className="rounded border border-neutral-200 px-3 py-2 hover:border-neutral-500 hover:bg-neutral-50 dark:border-neutral-800 dark:hover:border-neutral-500 dark:hover:bg-neutral-900"
              >
                📡 {t(m, "dashboard.assist_analyze")}
              </Link>
              <Link
                href={`/verify/${encodeURIComponent(activeName)}`}
                className="rounded border border-neutral-200 px-3 py-2 hover:border-neutral-500 hover:bg-neutral-50 dark:border-neutral-800 dark:hover:border-neutral-500 dark:hover:bg-neutral-900"
              >
                ✓ {t(m, "dashboard.assist_verify")}
              </Link>
              <Link
                href="/discover"
                className="rounded border border-neutral-200 px-3 py-2 hover:border-neutral-500 hover:bg-neutral-50 dark:border-neutral-800 dark:hover:border-neutral-500 dark:hover:bg-neutral-900"
              >
                🔭 {t(m, "dashboard.assist_discover")}
              </Link>
            </div>
          )}
          <p className="mt-2 text-[11px] leading-relaxed text-neutral-400">
            {t(m, "dashboard.assist_note")}
          </p>
        </aside>
      </div>
    </main>
  );
}
