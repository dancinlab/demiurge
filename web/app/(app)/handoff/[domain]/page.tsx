// M15 handoff surface — cross-stage receiver narrative (KO + EN).

import Link from "next/link";
import { notFound } from "next/navigation";
import { listDomains } from "@/lib/domains";
import { VerbDraftForm } from "@/components/VerbDraftForm";

export const dynamic = "force-dynamic";

export default async function HandoffPage({
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
        <span>/ handoff</span>
      </nav>

      <header className="mb-6">
        <h1 className="text-2xl font-bold">
          {entry.title ?? entry.name} · handoff
        </h1>
        <p className="mt-1 text-xs text-neutral-500">
          M7 handoff surface · 다음 stage receiver 핸드오버 노트 (한/영 2버전)
        </p>
      </header>

      <section className="mb-8">
        <h2 className="mb-2 text-lg font-semibold">narrative 생성</h2>
        <VerbDraftForm
          verb="handoff"
          fixedParams={{ domainName: entry.name }}
          fields={[
            {
              name: "packet",
              label: "packet — 핸드오프 packet (yaml/text/list 모두 가능)",
              placeholder:
                "예: scope: ... · evidence: ... · risk: ... · next: ...",
              rows: 10,
            },
          ]}
          maxOutputTokens={2560}
        />
      </section>

      <footer className="mt-10 border-t border-neutral-200 pt-4 text-xs text-neutral-500">
        Gemini는 packet에 명시된 사실만 사용 (추측 금지). 한국어 먼저 → 영어
        2 버전 출력.
      </footer>
    </main>
  );
}
