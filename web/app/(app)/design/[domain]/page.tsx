// M15 design surface — D-decision brainstorm assist.
//
// Reads current design.md (if present) for context, then mounts the
// DesignDraftForm client component. Gemini proposes 3 trade-off
// options; user picks and reserves a D-number manually (we never
// pre-assign — `feedback_d_number_stale_in_handoff`).

import Link from "next/link";
import { notFound } from "next/navigation";
import { listDomains } from "@/lib/domains";
import { VerbDraftForm } from "@/components/VerbDraftForm";

export const dynamic = "force-dynamic";

export default async function DesignPage({
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
        <span>/ design</span>
      </nav>

      <header className="mb-6">
        <h1 className="text-2xl font-bold">
          {entry.title ?? entry.name} · design
        </h1>
        <p className="mt-1 text-xs text-neutral-500">
          M3 design surface · 3-option trade-off brainstorm (D-number는
          사용자가 지정)
        </p>
      </header>

      <section className="mb-8">
        <h2 className="mb-2 text-lg font-semibold">brainstorm</h2>
        <VerbDraftForm
          verb="design"
          fixedParams={{ domainName: entry.name }}
          fields={[
            {
              name: "question",
              label: "design question — 어떤 결정을 검토하나",
              placeholder:
                "예: Stripe 결제 모델 — 월정액 vs 사용량 기반 vs hybrid?",
              rows: 5,
            },
          ]}
        />
      </section>

      <footer className="mt-10 border-t border-neutral-200 pt-4 text-xs text-neutral-500 dark:border-neutral-800">
        D-number는 ARCH.md §11.4 SSOT를 직접 grep하여 충돌 없는 번호로
        예약하세요 (Gemini가 추측 금지).
      </footer>
    </main>
  );
}
