// /dashboard — authenticated MAIN workbench.
// PR#36: (app)/layout.tsx 가 좌측 sidebar (8 verb · 🧑‍🍳 요리선생) + 상단 TopBar
// 모두 갖고 있으므로 page.tsx 는 메인 영역 콘텐츠만 — DomainSwitcher · active
// 도메인 진행도 · DashboardSummary (5 카테고리 카드).
//
// ElevenLabs Home 패턴: 큰 디스플레이 헤딩("무엇을 만들까요?" 톤) + verb 액션
// 카드 그리드. 메인 영역은 흰색(bg-surface)이라 카드는 bg-canvas 틴트 +
// border-hairline 로 구분한다. 시맨틱 토큰만 사용 (DESIGN_TOKENS.md SSOT).

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

// 메인 화면에 띄울 5개 verb 액션 카드 — 각 카드는 한 줄 설명을 동반한다.
const VERB_CARDS: { verb: keyof typeof VERB_PATHS; label: string; blurb: string }[] = [
  { verb: "discover",  label: "discover",  blurb: "새 도메인 발산 · gap 돌파" },
  { verb: "spec",      label: "spec",      blurb: "타겟 · 제약 정의" },
  { verb: "structure", label: "structure", blurb: "구조 · 토폴로지 설계" },
  { verb: "analyze",   label: "analyze",   blurb: "시뮬 · 검증 분석" },
  { verb: "handoff",   label: "handoff",   blurb: "완성형 인계 dossier" },
];

function ActionCard({
  verb,
  label,
  blurb,
  domain,
}: {
  verb: keyof typeof VERB_PATHS;
  label: string;
  blurb: string;
  domain: string;
}) {
  return (
    <Link
      href={`/${verb}/${domain.toLowerCase()}`}
      className="group flex flex-col gap-2 rounded-card border border-hairline bg-canvas p-4 transition hover:border-hairline-strong hover:shadow-card"
    >
      <svg
        viewBox="0 0 24 24"
        width="20"
        height="20"
        fill="none"
        stroke="currentColor"
        strokeWidth="1.6"
        strokeLinecap="round"
        strokeLinejoin="round"
        aria-hidden="true"
        className="h-5 w-5 text-ink"
      >
        <path d={VERB_PATHS[verb]} />
      </svg>
      <span className="font-display text-[15px] font-medium text-ink">{label}</span>
      <span className="text-[13px] text-muted">{blurb}</span>
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
    <div className="space-y-8">
      <header className="space-y-3">
        <h1 className="font-display text-3xl font-light tracking-tight text-ink">
          {t(messages, "dashboard.title")}
        </h1>
        <div className="flex flex-wrap items-center gap-3 text-sm text-muted">
          <DomainSwitcher
            names={domains.map((d) => d.name)}
            current={active?.name ?? ""}
            ariaLabel={t(messages, "app_gui.domain_aria")}
            newProjectLabel={t(messages, "app_gui.domain_new_project")}
          />
          {pct !== null && (
            <span>
              {active!.progress.done}/{active!.progress.total} · {pct}%
            </span>
          )}
        </div>
      </header>

      {active && (
        <section className="space-y-4">
          <h2 className="text-[11px] font-semibold uppercase tracking-wide text-muted">
            {t(messages, "dashboard.active_label")} · {active.name}
          </h2>
          <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
            {VERB_CARDS.map((c) => (
              <ActionCard
                key={c.verb}
                verb={c.verb}
                label={c.label}
                blurb={c.blurb}
                domain={active.name}
              />
            ))}
          </div>
          <details className="text-xs">
            <summary className="cursor-pointer text-muted hover:text-body">
              📜 {t(messages, "dashboard.log_tail")}
            </summary>
            <pre className="mt-2 max-h-72 overflow-auto rounded-panel bg-canvas p-3 font-mono text-[11px] text-body">
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
