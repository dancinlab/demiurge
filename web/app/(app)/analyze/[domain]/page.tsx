// M15 analyze surface — round result summarization.
//
// User pastes /cycle round output; Gemini summarizes in 3 axes (발견 /
// 막힘 / 다음 라운드 후보). M16 will add live SSE tail from
// `demiurge cli action analyze <domain>`.

import Link from "next/link";
import { notFound } from "next/navigation";
import { listDomains } from "@/lib/domains";
import { VerbDraftForm } from "@/components/VerbDraftForm";
import { LiveTail } from "@/components/LiveTail";

export const dynamic = "force-dynamic";

export default async function AnalyzePage({
  params,
}: {
  params: Promise<{ domain: string }>;
}) {
  const { domain: rawName } = await params;
  const name = decodeURIComponent(rawName);
  const domains = await listDomains();
  const entry = domains.find((d) => d.name === name);
  if (!entry) notFound();

  return (
    <main className="mx-auto max-w-5xl px-6 py-10 font-mono">
      <nav className="mb-4 flex gap-3 text-xs text-neutral-500">
        <Link href="/" className="underline">
          ← all domains
        </Link>
        <Link href={`/${encodeURIComponent(name)}`} className="underline">
          {name}
        </Link>
        <span>/ analyze</span>
      </nav>

      <header className="mb-6">
        <h1 className="text-2xl font-bold">
          {entry.title ?? entry.name} · analyze
        </h1>
        <p className="mt-1 text-xs text-neutral-500">
          M4 analyze surface · /cycle 라운드 결과 3축 요약 (발견 · 막힘 · 다음
          라운드 후보)
        </p>
      </header>

      <section className="mb-8">
        <h2 className="mb-2 text-lg font-semibold">
          라이브 tail{" "}
          <span className="text-xs font-normal text-neutral-500">
            (SSE · demiurge cli action analyze {entry.name})
          </span>
        </h2>
        <LiveTail args={["action", "analyze", entry.name]} label="run analyze" />
      </section>

      <section className="mb-8">
        <h2 className="mb-2 text-lg font-semibold">요약 어시스트</h2>
        <VerbDraftForm
          verb="analyze"
          fixedParams={{ domainName: entry.name }}
          fields={[
            {
              name: "rounds",
              label: "rounds — /cycle 라운드 결과 paste",
              placeholder:
                "예: 라운드 3 — V1 ledger 72 claim · 🔵 11 · 🟢 13 · ...",
              rows: 12,
            },
          ]}
          maxOutputTokens={2048}
        />
      </section>

      <footer className="mt-10 border-t border-neutral-200 pt-4 text-xs text-neutral-500 dark:border-neutral-800">
        ⚠ Gemini는 입력에 없는 수치 추론 금지 — 요약만. 라이브 tail은
        M16에서 SSE 채널로 land.
      </footer>
    </main>
  );
}
