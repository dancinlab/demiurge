// M15 discover surface — phanes CLI bridge (8th verb head).
//
// User enters an objective; we dispatch via demiurge cli discover which
// subprocess-calls phanes (d3/d4). phanes owns the OUROBOROS loop;
// this page is just the operator console. All copy resolved server-side
// (getMessages/t) and passed down as props — no client t().

import Link from "next/link";
import { redirect } from "next/navigation";
import { currentUser } from "@/lib/session";
import { getMessages, t } from "@/lib/i18n";
import { DiscoverForm } from "./DiscoverForm";
import { Section } from "@/components/ui/Section";

export const dynamic = "force-dynamic";

export default async function DiscoverPage() {
  const [user, messages] = await Promise.all([currentUser(), getMessages()]);
  if (!user) redirect("/signin");

  const formI18n = {
    objectiveLabel: t(messages, "discover.objective_label"),
    objectivePlaceholder: t(messages, "discover.objective_placeholder"),
    roundsLabel: t(messages, "discover.rounds_label"),
    submit: t(messages, "discover.submit"),
    calling: t(messages, "discover.calling"),
    failed: t(messages, "discover.failed"),
    stderrLabel: t(messages, "discover.stderr_label"),
  };

  return (
    <main className="mx-auto max-w-5xl space-y-8 px-6 py-10 font-mono">
      <nav className="text-xs text-muted">
        <Link href="/dashboard" className="underline">
          {t(messages, "nav.dashboard")}
        </Link>
        <span> / {t(messages, "discover.breadcrumb")}</span>
      </nav>

      <Section eyebrow={t(messages, "nav.discover")} bodyClassName="mt-1">
        <p className="text-xs text-muted">{t(messages, "discover.subtitle")}</p>
      </Section>

      <Section eyebrow={t(messages, "discover.dispatch")}>
        <DiscoverForm i18n={formI18n} />
      </Section>

      <footer className="pt-4 text-xs text-muted">
        {t(messages, "discover.contract_note")}
      </footer>
    </main>
  );
}
