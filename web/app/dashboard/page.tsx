// /dashboard — the authenticated MAIN workbench (3-column cockpit).
//   ① left rail   — 8-verb spine (discover at top + the 7-verb pipeline)
//   ② work zone   — active domain: @goal · progress · snapshot · log tail
//   ③ assist rail — Gemini-assisted verb shortcuts
//
// Mono / Terminal tone (sample 1):
//   bg-white · text-neutral-900 · font-mono · neutral-300 borders ·
//   rounded(4px) · no color accents — weight/border for hierarchy only.

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
    <main className="mx-auto flex h-screen max-w-[1600px] flex-col bg-white font-mono text-neutral-900 dark:bg-neutral-950 dark:text-neutral-100">
      {/* top toolbar — sample 1 mono pattern: small badge + 1px border */}
      <div className="flex items-center justify-between gap-4 border-b border-neutral-300 px-6 py-3 dark:border-neutral-700">
        <div className="flex items-center gap-3">
          <Link href="/" className="text-sm font-bold tracking-tight hover:underline">
            demiurge
          </Link>
          <span className="text-neutral-300 dark:text-neutral-700">/</span>
          <span className="text-sm text-neutral-500">{t(m, "dashboard.title")}</span>
          {names.length > 0 && (
            <DomainSwitcher names={names} current={activeName} />
          )}
        </div>
        <div className="flex items-center gap-4">
          {pct !== null && (
            <div className="flex items-center gap-2">
              <span className="text-xs text-neutral-500">
                {active!.progress!.done}/{active!.progress!.total}
              </span>
              <div className="h-1.5 w-40 overflow-hidden rounded-full bg-neutral-200 dark:bg-neutral-800">
                <div
                  className="h-full rounded-full bg-neutral-900 dark:bg-neutral-100"
                  style={{ width: `${pct}%` }}
                />
              </div>
              <span className="text-xs font-semibold">{pct}%</span>
            </div>
          )}
          <Link
            href="/account"
            className="rounded border border-neutral-300 px-2 py-1 text-xs text-neutral-700 hover:border-neutral-900 hover:text-neutral-900 dark:border-neutral-700 dark:text-neutral-300 dark:hover:border-neutral-100 dark:hover:text-neutral-100"
          >
            {user.email}
          </Link>
        </div>
      </div>

      <div className="grid flex-1 grid-cols-[200px_1fr_260px] overflow-hidden">
        {/* ① left rail — 8-verb spine */}
        <nav className="flex flex-col gap-0.5 overflow-y-auto border-r border-neutral-300 p-4 text-sm dark:border-neutral-700">
          <span className="mb-2 text-[11px] uppercase tracking-wider text-neutral-500">
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
                className="flex items-center gap-3 rounded px-2 py-1.5 text-neutral-700 hover:bg-neutral-100 hover:text-neutral-900 dark:text-neutral-300 dark:hover:bg-neutral-900 dark:hover:text-neutral-50"
              >
                <span className="w-4 text-right text-[11px] text-neutral-400">
                  {i === 0 ? "8" : i}
                </span>
                <span>{verb}</span>
                {i === 0 && (
                  <span className="ml-auto text-[10px] uppercase tracking-wider text-neutral-400">
                    head
                  </span>
                )}
              </Link>
            );
          })}
        </nav>

        {/* ② work zone */}
        <section className="overflow-y-auto px-8 py-6">
          {!active ? (
            <p className="text-sm text-neutral-500">{t(m, "dashboard.empty")}</p>
          ) : (
            <>
              <header className="mb-6 border-b border-neutral-200 pb-4 dark:border-neutral-800">
                <span className="inline-block rounded border border-neutral-300 px-2 py-0.5 text-[11px] text-neutral-600 dark:border-neutral-700 dark:text-neutral-400">
                  {active.name}
                </span>
                <h1 className="mt-3 text-2xl font-bold tracking-tight">
                  {active.title ?? active.name}
                </h1>
                {active.goal && (
                  <p className="mt-3 whitespace-pre-line text-sm leading-relaxed text-neutral-600 dark:text-neutral-400">
                    <span className="font-semibold text-neutral-900 dark:text-neutral-100">@goal:</span>{" "}
                    {active.goal}
                  </p>
                )}
              </header>
              <h2 className="mb-2 text-[11px] uppercase tracking-wider text-neutral-500">
                snapshot
              </h2>
              <pre className="mb-6 overflow-x-auto rounded border border-neutral-300 bg-neutral-50 p-4 text-xs leading-relaxed dark:border-neutral-700 dark:bg-neutral-900">
                {mdBody}
              </pre>
              <h2 className="mb-2 text-[11px] uppercase tracking-wider text-neutral-500">
                log
              </h2>
              <pre className="overflow-x-auto rounded border border-neutral-300 bg-neutral-50 p-4 text-xs leading-relaxed dark:border-neutral-700 dark:bg-neutral-900">
                {logTail}
              </pre>
            </>
          )}
        </section>

        {/* ③ assist rail */}
        <aside className="flex flex-col gap-3 overflow-y-auto border-l border-neutral-300 p-4 text-sm dark:border-neutral-700">
          <span className="text-[11px] uppercase tracking-wider text-neutral-500">
            {t(m, "dashboard.assist")}
          </span>
          {activeName && (
            <div className="flex flex-col gap-2">
              <Link
                href={`/spec/${encodeURIComponent(activeName)}`}
                className="rounded border border-neutral-300 px-3 py-2 hover:border-neutral-900 hover:bg-neutral-50 dark:border-neutral-700 dark:hover:border-neutral-100 dark:hover:bg-neutral-900"
              >
                {t(m, "dashboard.assist_spec")}
              </Link>
              <Link
                href={`/analyze/${encodeURIComponent(activeName)}`}
                className="rounded border border-neutral-300 px-3 py-2 hover:border-neutral-900 hover:bg-neutral-50 dark:border-neutral-700 dark:hover:border-neutral-100 dark:hover:bg-neutral-900"
              >
                {t(m, "dashboard.assist_analyze")}
              </Link>
              <Link
                href={`/verify/${encodeURIComponent(activeName)}`}
                className="rounded border border-neutral-300 px-3 py-2 hover:border-neutral-900 hover:bg-neutral-50 dark:border-neutral-700 dark:hover:border-neutral-100 dark:hover:bg-neutral-900"
              >
                {t(m, "dashboard.assist_verify")}
              </Link>
              <Link
                href="/discover"
                className="rounded border border-neutral-300 px-3 py-2 hover:border-neutral-900 hover:bg-neutral-50 dark:border-neutral-700 dark:hover:border-neutral-100 dark:hover:bg-neutral-900"
              >
                {t(m, "dashboard.assist_discover")}
              </Link>
            </div>
          )}
          <p className="mt-2 text-[11px] leading-relaxed text-neutral-500">
            {t(m, "dashboard.assist_note")}
          </p>
        </aside>
      </div>
    </main>
  );
}
