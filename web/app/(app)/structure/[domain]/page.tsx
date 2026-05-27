// M15 structure surface — domain hierarchy / dependency view.
// Deterministic (no LLM); M15 ships ASCII fallback, M16+ adds
// cytoscape graph rendering.

import Link from "next/link";
import { notFound } from "next/navigation";
import { listDomains } from "@/lib/domains";
import { runCli } from "@/lib/cli";

export const dynamic = "force-dynamic";

async function fetchCompose(name: string): Promise<string> {
  try {
    const r = await runCli(["compose", name], { timeoutMs: 10_000 });
    return r.stdout || r.stderr || "(no output)";
  } catch (e) {
    return `(compose unavailable: ${e instanceof Error ? e.message : String(e)})`;
  }
}

export default async function StructurePage({
  params,
}: {
  params: Promise<{ domain: string }>;
}) {
  const { domain: rawName } = await params;
  const name = decodeURIComponent(rawName);
  const domains = await listDomains();
  const entry = domains.find((d) => d.name === name);
  if (!entry) notFound();

  const compose = await fetchCompose(entry.name);

  return (
    <main className="mx-auto max-w-5xl px-6 py-10 font-mono">
      <nav className="mb-4 flex gap-3 text-xs text-neutral-500">
        <Link href="/" className="underline">
          ← all domains
        </Link>
        <Link href={`/${encodeURIComponent(name)}`} className="underline">
          {name}
        </Link>
        <span>/ structure</span>
      </nav>

      <header className="mb-6">
        <h1 className="text-2xl font-bold">
          {entry.title ?? entry.name} · structure
        </h1>
        <p className="mt-1 text-xs text-neutral-500">
          M2 structure surface · `demiurge cli compose` 결과 (deterministic ·
          LLM 없음)
        </p>
      </header>

      <section>
        <h2 className="mb-2 text-lg font-semibold">composition</h2>
        <pre className="overflow-x-auto rounded border border-neutral-200 bg-neutral-50 p-3 text-xs">
          {compose}
        </pre>
      </section>

      <footer className="mt-10 border-t border-neutral-200 pt-4 text-xs text-neutral-500">
        graph 시각화 (cytoscape)는 M16에서 land. 본 페이지는 ASCII fallback
        형태.
      </footer>
    </main>
  );
}
