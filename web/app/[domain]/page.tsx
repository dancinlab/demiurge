// M14 per-domain dashboard stub. Reads <DOMAIN>.md + <DOMAIN>.log.md from
// the repo via the roster. Full 7-verb tabs land in M15.

import Link from "next/link";
import { notFound } from "next/navigation";
import { listDomains } from "@/lib/domains";
import fs from "node:fs/promises";
import path from "node:path";

const REPO_ROOT = path.resolve(process.cwd(), "..");

export const dynamic = "force-dynamic";

export default async function DomainPage({
  params,
}: {
  params: Promise<{ domain: string }>;
}) {
  const { domain: rawName } = await params;
  const name = decodeURIComponent(rawName);
  const domains = await listDomains();
  const entry = domains.find((d) => d.name === name);
  if (!entry) notFound();

  let mdBody = "";
  let logTail = "";
  try {
    mdBody = await fs.readFile(path.join(REPO_ROOT, entry.mdPath), "utf8");
  } catch {
    mdBody = "(unable to read .md)";
  }
  try {
    const logFull = await fs.readFile(
      path.join(REPO_ROOT, entry.logPath),
      "utf8"
    );
    logTail = logFull.split("\n").slice(0, 80).join("\n");
  } catch {
    logTail = "(no log yet)";
  }

  return (
    <main className="mx-auto max-w-5xl px-6 py-10 font-mono">
      <nav className="mb-4 text-xs text-neutral-500">
        <Link href="/" className="underline">
          ← all domains
        </Link>
      </nav>
      <header className="mb-6">
        <h1 className="text-2xl font-bold">{entry.title ?? entry.name}</h1>
        {entry.goal && (
          <p className="mt-2 whitespace-pre-line text-sm text-neutral-600 dark:text-neutral-400">
            <span className="font-semibold">@goal:</span> {entry.goal}
          </p>
        )}
        {entry.progress && (
          <p className="mt-1 text-xs text-neutral-500">
            {entry.progress.done}/{entry.progress.total} milestones (
            {entry.progress.total > 0
              ? Math.round((100 * entry.progress.done) / entry.progress.total)
              : 0}
            %)
          </p>
        )}
      </header>

      <section className="mb-8">
        <h2 className="mb-2 text-lg font-semibold">snapshot</h2>
        <pre className="overflow-x-auto rounded border border-neutral-200 bg-neutral-50 p-3 text-xs dark:border-neutral-800 dark:bg-neutral-900">
          {mdBody}
        </pre>
      </section>

      <section>
        <h2 className="mb-2 text-lg font-semibold">log (newest first)</h2>
        <pre className="overflow-x-auto rounded border border-neutral-200 bg-neutral-50 p-3 text-xs dark:border-neutral-800 dark:bg-neutral-900">
          {logTail}
        </pre>
      </section>
    </main>
  );
}
