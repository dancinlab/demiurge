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
import { getMessages, getLocale, t } from "@/lib/i18n";
import { DomainSwitcher } from "@/components/DomainSwitcher";
import { WorkbenchMenu } from "@/components/WorkbenchMenu";
import { WorkbenchSpine } from "@/components/WorkbenchSpine";
import { AssistChat } from "@/components/AssistChat";

export const dynamic = "force-dynamic";

const REPO_ROOT =
  process.env.DEMIURGE_DATA_ROOT ?? path.resolve(process.cwd(), "..");

export default async function DashboardPage({
  searchParams,
}: {
  searchParams: Promise<{ d?: string; view?: string }>;
}) {
  const [user, m, locale, domains, sp] = await Promise.all([
    currentUser(),
    getMessages(),
    getLocale(),
    listDomains(),
    searchParams,
  ]);
  if (!user) redirect("/signin");

  const names = domains.map((d) => d.name);
  const showProjects = sp.view === "projects";
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
    <main className="flex h-screen w-full flex-col font-mono">
      {/* top toolbar — sample 1 mono pattern: small badge + 1px border */}
      <div className="flex items-center justify-between gap-4 border-b border-neutral-300 px-6 py-3 dark:border-neutral-700">
        <div className="flex items-center gap-3">
          <Link href="/" className="text-sm font-bold tracking-tight hover:underline">
            demiurge
          </Link>
          <span className="text-neutral-300 dark:text-neutral-700">/</span>
          <Link
            href="/dashboard?view=projects"
            className={
              "text-sm hover:text-neutral-900 dark:hover:text-neutral-100 " +
              (showProjects
                ? "font-semibold text-neutral-900 dark:text-neutral-100"
                : "text-neutral-500")
            }
          >
            {t(m, "dashboard.title")}
          </Link>
          {!showProjects && (
            <>
              <span className="text-neutral-300 dark:text-neutral-700">/</span>
              {names.length > 0 && (
                <DomainSwitcher names={names} current={activeName} />
              )}
            </>
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
          <WorkbenchMenu currentLocale={locale} />
        </div>
      </div>

      <div className="grid min-h-0 flex-1 grid-cols-[auto_1fr_340px] overflow-hidden [&>*]:min-w-0">
        {/* ① left rail — 8-verb spine (collapsible) */}
        <WorkbenchSpine activeName={activeName} spineLabel={t(m, "dashboard.spine")} />

        {/* ② work zone */}
        <section className="overflow-y-auto px-8 py-6">
          {showProjects ? (
            <>
              <h1 className="mb-1 text-2xl font-bold tracking-tight">
                {t(m, "dashboard.title")}
              </h1>
              <p className="mb-6 text-[11px] uppercase tracking-[0.2em] text-neutral-500">
                projects · {domains.length}
              </p>
              <div className="grid grid-cols-2 gap-3 xl:grid-cols-3">
                {domains.map((d) => {
                  const dp =
                    d.progress && d.progress.total > 0
                      ? Math.round((100 * d.progress.done) / d.progress.total)
                      : null;
                  return (
                    <Link
                      key={d.name}
                      href={`/dashboard?d=${encodeURIComponent(d.name)}`}
                      className="flex flex-col gap-2 rounded border border-neutral-300 p-4 hover:border-neutral-900 hover:bg-neutral-50 dark:border-neutral-700 dark:hover:border-neutral-100 dark:hover:bg-neutral-900"
                    >
                      <span className="text-sm font-bold tracking-tight">{d.name}</span>
                      {d.goal && (
                        <span className="line-clamp-2 text-[11px] leading-relaxed text-neutral-500">
                          {d.goal}
                        </span>
                      )}
                      {dp !== null && (
                        <div className="mt-auto flex items-center gap-2 pt-1">
                          <div className="h-1 flex-1 overflow-hidden rounded-full bg-neutral-200 dark:bg-neutral-800">
                            <div
                              className="h-full rounded-full bg-neutral-900 dark:bg-neutral-100"
                              style={{ width: `${dp}%` }}
                            />
                          </div>
                          <span className="text-[10px] text-neutral-500">{dp}%</span>
                        </div>
                      )}
                    </Link>
                  );
                })}
              </div>
            </>
          ) : !active ? (
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

        {/* ③ right rail — LLM chat assist (Gemini draft).
            NOTE: old verb-shortcut assist rail disabled; chat panel below. */}
        <AssistChat note={t(m, "dashboard.assist_note")} />
      </div>
    </main>
  );
}
