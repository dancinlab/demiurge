// M15 spec surface — server reads the domain's current @goal then mounts
// the SpecDraftForm client component for Gemini-assisted drafting.
//
// The Gemini call is a draft, NEVER an automatic write. User reviews
// the draft and pastes manually into <DOMAIN>.md (or `domain goal "..."`).

import Link from "next/link";
import { notFound } from "next/navigation";
import { listDomains } from "@/lib/domains";
import { SpecDraftForm } from "./SpecDraftForm";

export const dynamic = "force-dynamic";

export default async function SpecPage({
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
        <span>/ spec</span>
      </nav>

      <header className="mb-6">
        <h1 className="text-2xl font-bold">
          {entry.title ?? entry.name} · spec
        </h1>
        <p className="mt-1 text-xs text-neutral-500">
          M1 spec surface · @goal 초안 어시스트 (Gemini 2.5 · 자동 적용 안 함)
        </p>
      </header>

      <section className="mb-8">
        <h2 className="mb-2 text-lg font-semibold">현재 @goal</h2>
        <pre className="overflow-x-auto rounded border border-neutral-200 bg-neutral-50 p-3 text-sm">
          {entry.goal ?? "(미설정 — 새 도메인이거나 @goal: 줄이 비어있습니다)"}
        </pre>
      </section>

      <section className="mb-8">
        <h2 className="mb-2 text-lg font-semibold">draft 어시스트</h2>
        <SpecDraftForm domainName={entry.name} currentGoal={entry.goal} />
      </section>

      <footer className="mt-10 border-t border-neutral-200 pt-4 text-xs text-neutral-500">
        Gemini는 초안만 제안 — 검수 후 <code>domain goal &quot;...&quot;</code>{" "}
        또는 <code>&lt;DOMAIN&gt;.md</code> 직접 편집으로만 적용됩니다 (d4
        single dispatch · 직접 write 금지).
      </footer>
    </main>
  );
}
