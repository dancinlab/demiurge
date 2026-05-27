// /dashboard — authenticated MAIN workbench.
// PR#36: (app)/layout.tsx 가 좌측 sidebar (8 verb · 🧑‍🍳 요리선생) + 상단 TopBar
// 모두 갖고 있으므로 page.tsx 는 메인 영역 콘텐츠만 — DomainSwitcher · active
// 도메인 진행도 · DashboardSummary (5 카테고리 카드).

import Link from "next/link";
import { redirect } from "next/navigation";
import fs from "node:fs/promises";
import path from "node:path";
import { currentUser } from "@/lib/session";
import { listDomains } from "@/lib/domains";
import { getMessages, t } from "@/lib/i18n";
import { logToTrajectory, DEMO_TRAJECTORY } from "@/lib/trajectory";
import { DomainSwitcher } from "@/components/DomainSwitcher";
import { DashboardSummary } from "@/components/DashboardSummary";
import { TrajectoryPanel } from "@/components/TrajectoryPanel";

export const dynamic = "force-dynamic";

// Lucide outline path (subset for dashboard verb chips · same as VerbTreeNav).
// Lucide outline path subset for dashboard verb chips. discover 가 최상단.
const VERB_PATHS: Record<string, string> = {
  discover:  "M21 21l-6-6m2-5a7 7 0 1 1-14 0 7 7 0 0 1 14 0z",
  spec:      "M14 3v4a1 1 0 0 0 1 1h4M5 8V5a2 2 0 0 1 2-2h7l5 5v11a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2v-3M9 12h6M9 16h4",
  structure: "M3 7l9-4 9 4-9 4-9-4zM3 12l9 4 9-4M3 17l9 4 9-4",
  analyze:   "M3 3v18h18M7 16V9M12 16V5M17 16v-5",
  handoff:   "M16.5 9.4l-9-5.19M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z",
};

function VerbChip({ verb, label, domain }: { verb: keyof typeof VERB_PATHS; label: string; domain: string }) {
  return (
    <Link
      href={`/${verb}/${domain.toLowerCase()}`}
      className="inline-flex items-center gap-1.5 rounded-full border border-gray-200 bg-white px-3 py-1 text-gray-700 hover:bg-gray-50 hover:text-gray-900"
    >
      <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
        <path d={VERB_PATHS[verb]} />
      </svg>
      {label}
    </Link>
  );
}

const REPO_ROOT =
  process.env.DEMIURGE_DATA_ROOT ?? path.resolve(process.cwd(), "..");

export default async function DashboardPage({
  searchParams,
}: {
  searchParams: Promise<{ d?: string }>;
}) {
  const [user, domains, sp, messages] = await Promise.all([
    currentUser(),
    listDomains(),
    searchParams,
    getMessages(),
  ]);
  if (!user) redirect("/signin");

  // If no ?d= in URL but domains exist, redirect to ?d=<first> so middleware
  // syncs the active-domain cookie. Without this, fresh visits leave the
  // cookie empty → verb clicks bounce back to /dashboard (the P0 symptom).
  if (!sp.d && domains.length > 0) {
    redirect(`/dashboard?d=${encodeURIComponent(domains[0].name)}`);
  }

  const active =
    (sp.d && domains.find((d) => d.name === sp.d)) || domains[0] || null;

  let logTail = "";
  let trajectory: ReturnType<typeof logToTrajectory> = [];
  if (active) {
    try {
      const logFull = await fs.readFile(
        path.join(REPO_ROOT, active.logPath),
        "utf8",
      );
      logTail = logFull.split("\n").slice(0, 30).join("\n");
      trajectory = logToTrajectory(logFull);
    } catch {
      logTail = "(no log yet)";
    }
  }

  const pct =
    active?.progress && active.progress.total > 0
      ? Math.round((100 * active.progress.done) / active.progress.total)
      : null;

  return (
    <div className="space-y-6">
      <header className="flex items-center gap-3">
        <h1 className="font-serif text-2xl font-semibold tracking-tight text-gray-900">🏠 {t(messages, "dashboard.title")}</h1>
        <DomainSwitcher
          names={domains.map((d) => d.name)}
          current={active?.name ?? ""}
          ariaLabel={t(messages, "app_gui.domain_aria")}
          newProjectLabel={t(messages, "app_gui.domain_new_project")}
        />
        {pct !== null && (
          <span className="text-xs text-gray-500">
            {active!.progress.done}/{active!.progress.total} · {pct}%
          </span>
        )}
      </header>

      {active && (
        <section className="space-y-3">
          <h2 className="text-[11px] font-semibold uppercase tracking-wide text-gray-500">
            {t(messages, "dashboard.active_label")} · {active.name}
          </h2>
          <div className="flex flex-wrap gap-2 text-xs">
            <VerbChip verb="discover"  label="discover"  domain={active.name} />
            <VerbChip verb="spec"      label="spec"      domain={active.name} />
            <VerbChip verb="structure" label="structure" domain={active.name} />
            <VerbChip verb="analyze"   label="analyze"   domain={active.name} />
            <VerbChip verb="handoff"   label="handoff"   domain={active.name} />
          </div>
          <details className="text-xs">
            <summary className="cursor-pointer text-gray-500 hover:text-gray-700">📜 {t(messages, "dashboard.log_tail")}</summary>
            <pre className="mt-1 max-h-72 overflow-auto bg-gray-50 p-2 font-mono text-[11px] text-gray-700">
              {logTail}
            </pre>
          </details>
        </section>
      )}

      {active && (
        <TrajectoryPanel
          sessionId={trajectory.length > 0 ? active.name.toLowerCase() : "042"}
          entries={trajectory.length > 0 ? trajectory : DEMO_TRAJECTORY}
        />
      )}

      <DashboardSummary />
    </div>
  );
}
