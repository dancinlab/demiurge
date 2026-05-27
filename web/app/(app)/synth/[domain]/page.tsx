// M15 synth surface — synthesis dispatcher placeholder.
// Deterministic (no LLM); pool/cloud host grid + dispatch form lands
// in M16 (pool host status polling). M15 ships static info.

import Link from "next/link";
import { notFound } from "next/navigation";
import { listDomains } from "@/lib/domains";
import { runCli } from "@/lib/cli";

export const dynamic = "force-dynamic";

async function fetchBackend(): Promise<string> {
  try {
    const r = await runCli(["backend", "list"], { timeoutMs: 10_000 });
    return r.stdout || r.stderr || "(no output)";
  } catch (e) {
    return `(backend unavailable: ${e instanceof Error ? e.message : String(e)})`;
  }
}

export default async function SynthPage({
  params,
}: {
  params: Promise<{ domain: string }>;
}) {
  const { domain: rawName } = await params;
  const name = decodeURIComponent(rawName);
  const domains = await listDomains();
  const entry = domains.find((d) => d.name === name);
  if (!entry) notFound();

  const backends = await fetchBackend();

  return (
    <main className="mx-auto max-w-5xl px-6 py-10 font-mono">
      <nav className="mb-4 flex gap-3 text-xs text-neutral-500">
        <Link href="/" className="underline">
          ← all domains
        </Link>
        <Link href={`/${encodeURIComponent(name)}`} className="underline">
          {name}
        </Link>
        <span>/ synth</span>
      </nav>

      <header className="mb-6">
        <h1 className="text-2xl font-bold">
          {entry.title ?? entry.name} · synth
        </h1>
        <p className="mt-1 text-xs text-neutral-500">
          M5 synthesize surface · dispatch routing per @D d7 · LLM 없음
        </p>
      </header>

      <section className="mb-6">
        <h2 className="mb-2 text-lg font-semibold">available backends</h2>
        <pre className="overflow-x-auto rounded border border-neutral-200 bg-neutral-50 p-3 text-xs">
          {backends}
        </pre>
      </section>

      <section>
        <h2 className="mb-2 text-lg font-semibold">dispatch (M16+)</h2>
        <p className="text-xs text-neutral-500">
          host grid · live status · run form은 M16에서 SSE 채널과 함께 land
          예정. 현재는 터미널에서: <code>demiurge cli action synth {name}</code>
        </p>
      </section>

      <footer className="mt-10 border-t border-neutral-200 pt-4 text-xs text-neutral-500">
        ⚠ synth는 결정론적 dispatch — Gemini 호출 없음. host 라우팅은 d7
        rule을 따름.
      </footer>
    </main>
  );
}
