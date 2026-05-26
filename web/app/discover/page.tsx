// M15 discover surface — phanes CLI bridge (8th verb head).
//
// User enters an objective; we dispatch via demiurge cli discover which
// subprocess-calls phanes (d3/d4). phanes owns the OUROBOROS loop;
// this page is just the operator console.

import Link from "next/link";
import { DiscoverForm } from "./DiscoverForm";

export const dynamic = "force-dynamic";

export default function DiscoverPage() {
  return (
    <main className="mx-auto max-w-5xl px-6 py-10 font-mono">
      <nav className="mb-4 text-xs text-neutral-500">
        <Link href="/" className="underline">
          ← all domains
        </Link>
        <span> / discover</span>
      </nav>

      <header className="mb-6">
        <h1 className="text-2xl font-bold">discover</h1>
        <p className="mt-1 text-xs text-neutral-500">
          8th verb (head) · objective + verifier → verified candidate
          catalog · phanes-owned OUROBOROS loop (d3/d4)
        </p>
      </header>

      <section className="mb-8">
        <h2 className="mb-2 text-lg font-semibold">dispatch</h2>
        <DiscoverForm />
      </section>

      <footer className="mt-10 border-t border-neutral-200 pt-4 text-xs text-neutral-500 dark:border-neutral-800">
        ⚠ phanes CLI (<code>bin/phanes</code>) 미설치 시 friendly error +
        contract 안내 (~/core/phanes/INBOX.log.md::demiurge-discover-bridge).
      </footer>
    </main>
  );
}
