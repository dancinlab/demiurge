// M15 verify surface — verbatim `hexa verify` output (g5 enforcement).
//
// This page renders `demiurge cli verify --expr ...` / `--fence ...` /
// `rubric` outputs INSIDE a <pre> block, unmodified. No LLM gloss, no
// summarization. The 5-tier rubric is the SSOT; we just show it.
//
// Triple form selector (rubric · --expr · --fence) is the M6 verify
// surface from CLI+COCKPIT.md, mirrored to web.

import Link from "next/link";
import { notFound } from "next/navigation";
import { listDomains } from "@/lib/domains";
import { runCli } from "@/lib/cli";

export const dynamic = "force-dynamic";

async function fetchRubric(): Promise<string> {
  try {
    const r = await runCli(["verify", "rubric"], { timeoutMs: 10_000 });
    return r.stdout || r.stderr || "(no output)";
  } catch (e) {
    return `(rubric unavailable: ${e instanceof Error ? e.message : String(e)})`;
  }
}

export default async function VerifyPage({
  params,
}: {
  params: Promise<{ domain: string }>;
}) {
  const { domain: rawName } = await params;
  const name = decodeURIComponent(rawName);
  const domains = await listDomains();
  const entry = domains.find((d) => d.name === name);
  if (!entry) notFound();

  const rubric = await fetchRubric();

  return (
    <main className="mx-auto max-w-5xl px-6 py-10 font-mono">
      <nav className="mb-4 flex gap-3 text-xs text-neutral-500">
        <Link href="/" className="underline">
          ← all domains
        </Link>
        <Link href={`/${encodeURIComponent(name)}`} className="underline">
          {name}
        </Link>
        <span>/ verify</span>
      </nav>

      <header className="mb-6">
        <h1 className="text-2xl font-bold">
          {entry.title ?? entry.name} · verify
        </h1>
        <p className="mt-1 text-xs text-neutral-500">
          M6 verify surface · g5 5-tier · output rendered VERBATIM (no LLM
          gloss)
        </p>
      </header>

      <section className="mb-8">
        <h2 className="mb-2 text-lg font-semibold">rubric</h2>
        <pre className="overflow-x-auto rounded border border-neutral-200 bg-neutral-50 p-3 text-xs dark:border-neutral-800 dark:bg-neutral-900">
          {rubric}
        </pre>
      </section>

      <section className="mb-8">
        <h2 className="mb-2 text-lg font-semibold">--expr (numerical recompute)</h2>
        <form
          method="POST"
          action="/api/cli"
          className="flex flex-wrap items-end gap-2"
        >
          <p className="basis-full text-xs text-neutral-500">
            POST form is a placeholder UI; live recompute lands in M15 (client
            component). Try via terminal:{" "}
            <code>demiurge cli verify --expr sigma 6 12</code>
          </p>
        </form>
      </section>

      <section>
        <h2 className="mb-2 text-lg font-semibold">--fence (speculation)</h2>
        <p className="text-xs text-neutral-500">
          Honest ⚪ verdict for non-verifiable metaphor / imagination. Try:{" "}
          <code>demiurge cli verify --fence &quot;...&quot;</code>
        </p>
      </section>

      <footer className="mt-10 border-t border-neutral-200 pt-4 text-xs text-neutral-500 dark:border-neutral-800">
        ⚠ verify never calls LLM (g5 invariant) — output is the calculator
        verdict, verbatim.
      </footer>
    </main>
  );
}
