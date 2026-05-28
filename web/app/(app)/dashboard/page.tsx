// /dashboard — authenticated MAIN workbench (surface #3).
//
// (app)/layout.tsx owns the left sidebar (8-verb spine · 🧑‍🍳 Artisan) + TopBar,
// so page.tsx renders the main-area content only:
//   1. header — DomainSwitcher + active-domain progress
//   2. metrics strip — real numbers (domain count · active progress · verbs done)
//   3. pipeline-status row — the active domain's 8-verb status dots (real data)
//   4. verb quick-launch grid — all 8 verbs, i18n labels + blurbs
//   5. trajectory panel — activity from the active domain's log (DEMO fallback)
//   6. DashboardSummary — category trees + stdlib porting rollup
//
// Empty state (no registered domains) shows a "select / create" CTA instead.
//
// ElevenLabs Home tone: large light display heading.
// Main area is bg-surface (white). 재설계 후(옵션 H) — main 콘텐츠 카드/패널은
// 배경·라운딩 0; 구분은 공간(여백) + 타이포 위계만 (Section/Panel/LinkCard SSOT).
// Semantic tokens only (DESIGN_TOKENS.md SSOT). No hardcoded copy — all strings
// resolve through messages/*.json (en fallback) or the inline locale verb map.

import Link from "next/link";
import { redirect } from "next/navigation";
import fs from "node:fs/promises";
import path from "node:path";
import { currentUser } from "@/lib/session";
import { listDomains, listDomainTree, type DomainNode } from "@/lib/domains";
import { getMessages, getLocale, t } from "@/lib/i18n";
import { logToTrajectory, DEMO_TRAJECTORY } from "@/lib/trajectory";
import { parseMilestones, deriveVerbStatus } from "@/lib/verb-status";
import { VERBS, type VerbId, type VerbStatus } from "@/lib/verbs";
import { repoDataRoot } from "@/lib/data-root";
import { readMatterLedger } from "@/lib/matter";
import { DomainSwitcher } from "@/components/DomainSwitcher";
import { DashboardSummary } from "@/components/DashboardSummary";
import { TrajectoryPanel } from "@/components/TrajectoryPanel";
import { DomainBrowser } from "@/components/DomainBrowser";
import { DomainTree, type TreeNode } from "@/components/DomainTree";
import { LibraryGallery } from "@/components/LibraryGallery";
import { MatterLedger } from "@/components/MatterLedger";
import { Section } from "@/components/ui/Section";
import { Panel, PanelStat } from "@/components/ui/Panel";
import { LinkCard } from "@/components/ui/Card";

// Serialize the server DomainNode tree → the plain shape DomainTree (client)
// needs (drops fs-bound fields; keeps name · id · depth · scale · progress).
function toTreeNode(n: DomainNode): TreeNode {
  return {
    name: n.name,
    id: n.id,
    depth: n.depth,
    scale: n.scale,
    progress: n.progress,
    children: n.children.map(toTreeNode),
  };
}

export const dynamic = "force-dynamic";

// Lucide outline SVG paths for the 8 verb chips (mirrors VerbTreeNav).
const VERB_PATHS: Record<VerbId, string> = {
  discover:  "M21 21l-6-6m2-5a7 7 0 1 1-14 0 7 7 0 0 1 14 0z",
  spec:      "M14 3v4a1 1 0 0 0 1 1h4M5 8V5a2 2 0 0 1 2-2h7l5 5v11a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2v-3M9 12h6M9 16h4",
  structure: "M3 7l9-4 9 4-9 4-9-4zM3 12l9 4 9-4M3 17l9 4 9-4",
  design:    "M12 19l7-7 3 3-7 7-3-3zM18 13l-1.5-7.5L2 2l3.5 14.5L13 18l5-5zM2 2l7.586 7.586",
  analyze:   "M3 3v18h18M7 16V9M12 16V5M17 16v-5",
  synth:     "M9 2v7.31M15 9.34V2M11 14h2M12 2v0M6.4 22h11.2a2 2 0 0 0 1.84-2.77L15 9V2H9v7L4.56 19.23A2 2 0 0 0 6.4 22z",
  verify:    "M9 12l2 2 4-4m6 2a9 9 0 1 1-18 0 9 9 0 0 1 18 0z",
  handoff:   "M16.5 9.4l-9-5.19M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z",
};

// i18n verb labels (hybrid: locale label + canonical verb). Same single source
// as VerbTreeNav's VERB_LABELS so card labels and the sidebar agree. en uses the
// canonical verb verbatim, so no entry → falls back to v.label.
const VERB_LABELS: Record<string, Partial<Record<VerbId, string>>> = {
  ko: { discover: "발견", spec: "사양", structure: "구조", design: "설계", analyze: "분석", synth: "합성", verify: "검증", handoff: "인계" },
  ja: { discover: "発見", spec: "仕様", structure: "構造", design: "設計", analyze: "分析", synth: "合成", verify: "検証", handoff: "引継ぎ" },
  ru: { discover: "поиск", spec: "спец", structure: "структура", design: "дизайн", analyze: "анализ", synth: "синтез", verify: "проверка", handoff: "передача" },
  zh: { discover: "发现", spec: "规格", structure: "结构", design: "设计", analyze: "分析", synth: "合成", verify: "验证", handoff: "交接" },
};

const STATUS_COLOR: Record<VerbStatus, string> = {
  complete: "text-success",
  in_progress: "text-body",
  todo: "text-muted-soft",
};
const STATUS_DOT: Record<VerbStatus, string> = {
  complete: "●",
  in_progress: "◐",
  todo: "○",
};

function VerbIcon({ verb }: { verb: VerbId }) {
  return (
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
  );
}

function ActionCard({
  verb,
  label,
  canon,
  blurb,
  status,
  domain,
}: {
  verb: VerbId;
  label: string;
  canon: string;
  blurb: string;
  status: VerbStatus;
  domain: string;
}) {
  return (
    <LinkCard
      href={`/${verb}/${domain.toLowerCase()}`}
      className="flex flex-col gap-2"
    >
      <div className="flex items-center justify-between">
        <VerbIcon verb={verb} />
        <span className={`text-xs ${STATUS_COLOR[status]}`} aria-hidden="true">
          {STATUS_DOT[status]}
        </span>
      </div>
      <span className="flex items-baseline gap-1.5">
        <span className="font-display text-[15px] font-medium text-ink">{label}</span>
        {label !== canon && (
          <span className="font-mono text-[10px] text-muted-soft">{canon}</span>
        )}
      </span>
      <span className="text-[13px] text-muted">{blurb}</span>
    </LinkCard>
  );
}

const REPO_ROOT = repoDataRoot();

export default async function DashboardPage({
  searchParams,
}: {
  searchParams: Promise<{ d?: string }>;
}) {
  const [user, domains, tree, matterRows, sp, messages, locale] =
    await Promise.all([
      currentUser(),
      listDomains(),
      listDomainTree(),
      readMatterLedger(),
      searchParams,
      getMessages(),
      getLocale(),
    ]);
  if (!user) redirect("/signin");

  // If no ?d= in URL but domains exist, redirect to ?d=<first> so middleware
  // syncs the active-domain cookie. Without this, fresh visits leave the
  // cookie empty → verb clicks bounce back to /dashboard.
  if (!sp.d && domains.length > 0) {
    redirect(`/dashboard?d=${encodeURIComponent(domains[0].name)}`);
  }

  const active =
    (sp.d && domains.find((d) => d.name === sp.d)) || domains[0] || null;

  // ── Domain browser (#6b) — the single domain surface: tree · public · matter.
  // matter/library are VIEWS of the one "domain" concept, folded in as tabs
  // here instead of separate top-level routes.
  const treeI18n = {
    scaleAtom: t(messages, "dashboard.scale_atom"),
    scaleMaterial: t(messages, "dashboard.scale_material"),
    scaleChip: t(messages, "dashboard.scale_chip"),
    scaleComponent: t(messages, "dashboard.scale_component"),
    scaleSystem: t(messages, "dashboard.scale_system"),
    open: t(messages, "dashboard.tree_open"),
    emptyTree: t(messages, "dashboard.tree_empty"),
    reorder: t(messages, "dashboard.tree_reorder"),
  };
  const browserI18n = {
    heading: t(messages, "dashboard.browser_heading"),
    tabTree: t(messages, "dashboard.tab_tree"),
    tabPublic: t(messages, "dashboard.tab_public"),
    tabMatter: t(messages, "dashboard.tab_matter"),
  };
  const libraryI18n = {
    title: t(messages, "library.title"),
    subtitle: t(messages, "library.subtitle"),
    searchPlaceholder: t(messages, "library.search_placeholder"),
    filterAll: t(messages, "library.filter_all"),
    filterComplete: t(messages, "library.filter_complete"),
    filterWip: t(messages, "library.filter_wip"),
    countLabel: t(messages, "library.count_label"),
    heroVerbLabel: t(messages, "library.hero_verb_label"),
    composesLabel: t(messages, "library.composes_label"),
    licenseLabel: t(messages, "library.license_label"),
    curatorLabel: t(messages, "library.curator_label"),
    browse: t(messages, "library.browse"),
    fork: t(messages, "library.fork"),
    forkInProgress: t(messages, "library.fork_in_progress"),
    signInToFork: t(messages, "library.sign_in_to_fork"),
    guestNote: t(messages, "library.guest_note"),
    empty: t(messages, "library.empty"),
    emptyFiltered: t(messages, "library.empty_filtered"),
    loading: t(messages, "library.loading"),
    error: t(messages, "library.error"),
  };
  const matterI18n = {
    searchPlaceholder: t(messages, "matter.search_placeholder"),
    filterAll: t(messages, "matter.filter_all"),
    filterAbsorbed: t(messages, "matter.filter_absorbed"),
    filterOpen: t(messages, "matter.filter_open"),
    summaryTotal: t(messages, "matter.summary_total"),
    summaryAbsorbed: t(messages, "matter.summary_absorbed"),
    summaryMaterials: t(messages, "matter.summary_materials"),
    colMaterial: t(messages, "matter.col_material"),
    colKind: t(messages, "matter.col_kind"),
    colCompound: t(messages, "matter.col_compound"),
    colTc: t(messages, "matter.col_tc"),
    colFamily: t(messages, "matter.col_family"),
    colAbsorbed: t(messages, "matter.col_absorbed"),
    colGate: t(messages, "matter.col_gate"),
    colVerdict: t(messages, "matter.col_verdict"),
    kindAttestation: t(messages, "matter.kind_attestation"),
    kindVerdict: t(messages, "matter.kind_verdict"),
    absorbedYes: t(messages, "matter.absorbed_yes"),
    absorbedNo: t(messages, "matter.absorbed_no"),
    empty: t(messages, "matter.empty"),
    emptyFiltered: t(messages, "matter.empty_filtered"),
  };

  const domainBrowser = (
    <DomainBrowser
      i18n={browserI18n}
      tree={
        <DomainTree
          nodes={tree.map(toTreeNode)}
          i18n={treeI18n}
          activeId={active?.name ?? null}
        />
      }
      publicTab={<LibraryGallery i18n={libraryI18n} />}
      matter={<MatterLedger rows={matterRows} i18n={matterI18n} />}
    />
  );

  // ── Empty state — no registered domains. Guide to discover. ──────────────
  if (!active) {
    return (
      <div className="space-y-8">
        <header className="space-y-3">
          <h1 className="font-display text-3xl font-light tracking-tight text-ink">
            {t(messages, "dashboard.title")}
          </h1>
        </header>
        <Panel tone="raised" shape="card" padding="none" className="flex flex-col items-start gap-3 p-8">
          <h2 className="font-display text-lg font-light tracking-tight text-ink">
            {t(messages, "dashboard.empty_title")}
          </h2>
          <p className="max-w-prose text-sm text-muted">
            {t(messages, "dashboard.empty_body")}
          </p>
          <Link
            href="/discover"
            className="rounded-control bg-inverted px-4 py-2 text-sm font-medium text-on-primary transition hover:opacity-90"
          >
            {t(messages, "dashboard.empty_cta")}
          </Link>
        </Panel>
        {domainBrowser}
        <DashboardSummary domainCount={0} />
      </div>
    );
  }

  // ── Active-domain reads (log tail + trajectory + per-verb status). ───────
  let logTail = "";
  let trajectory: ReturnType<typeof logToTrajectory> = [];
  let statusByVerb: Partial<Record<VerbId, VerbStatus>> = {};
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
  try {
    const mdText = await fs.readFile(path.join(REPO_ROOT, active.mdPath), "utf8");
    statusByVerb = deriveVerbStatus(parseMilestones(mdText));
  } catch {
    // no .md → leave statusByVerb empty (cards render `todo`)
  }

  const pct =
    active.progress && active.progress.total > 0
      ? Math.round((100 * active.progress.done) / active.progress.total)
      : null;

  const verbsComplete = VERBS.filter(
    (v) => statusByVerb[v.id] === "complete",
  ).length;

  return (
    <div className="space-y-8">
      <header className="space-y-3">
        <h1 className="font-display text-3xl font-light tracking-tight text-ink">
          {t(messages, "dashboard.title")}
        </h1>
        <div className="flex flex-wrap items-center gap-3 text-sm text-muted">
          <DomainSwitcher
            names={domains.map((d) => d.name)}
            current={active.name}
            ariaLabel={t(messages, "app_gui.domain_aria")}
            newProjectLabel={t(messages, "app_gui.domain_new_project")}
          />
          {pct !== null && (
            <span>
              {active.progress!.done}/{active.progress!.total} · {pct}%
            </span>
          )}
        </div>
      </header>

      {/* ── metrics strip — real numbers ───────────────────────────────── */}
      <Section eyebrow={t(messages, "dashboard.metrics_heading")}>
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-3">
          <PanelStat
            value={String(domains.length)}
            label={t(messages, "dashboard.metric_domains")}
          />
          <PanelStat
            value={pct !== null ? `${pct}%` : "—"}
            label={t(messages, "dashboard.metric_progress")}
          />
          <PanelStat
            value={`${verbsComplete}/${VERBS.length}`}
            label={t(messages, "dashboard.metric_verbs_complete")}
          />
        </div>
      </Section>

      {/* ── pipeline status — active domain's 8-verb dots (real data) ──── */}
      <Section
        eyebrow={`${t(messages, "dashboard.pipeline_heading")} · ${active.name}`}
      >
        <Panel
          tone="raised"
          shape="card"
          padding="none"
          className="flex flex-wrap items-center gap-x-2 gap-y-1.5 px-3 py-2.5"
        >
          {VERBS.map((v, i) => {
            const status: VerbStatus = statusByVerb[v.id] ?? "todo";
            const label = VERB_LABELS[locale]?.[v.id] ?? v.label;
            return (
              <span key={v.id} className="flex items-center gap-2">
                <Link
                  href={`/${v.id}/${active.name.toLowerCase()}`}
                  className="flex items-center gap-1 text-[12px] text-body-strong hover:text-ink"
                  title={v.label}
                >
                  <span className={`text-[11px] ${STATUS_COLOR[status]}`} aria-hidden="true">
                    {STATUS_DOT[status]}
                  </span>
                  <span>{label}</span>
                </Link>
                {i < VERBS.length - 1 && (
                  <span className="text-muted-soft" aria-hidden="true">→</span>
                )}
              </span>
            );
          })}
        </Panel>
      </Section>

      {/* ── verb quick-launch grid — all 8 verbs ───────────────────────── */}
      <Section
        eyebrow={`${t(messages, "dashboard.verbs_heading")} · ${active.name}`}
      >
        <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
          {VERBS.map((v) => (
            <ActionCard
              key={v.id}
              verb={v.id}
              label={VERB_LABELS[locale]?.[v.id] ?? v.label}
              canon={v.label}
              blurb={t(messages, `dashboard.blurb_${v.id}`)}
              status={statusByVerb[v.id] ?? "todo"}
              domain={active.name}
            />
          ))}
        </div>
        <details className="text-xs">
          <summary className="cursor-pointer text-muted hover:text-body">
            📜 {t(messages, "dashboard.log_tail")}
          </summary>
          <pre className="mt-2 max-h-72 overflow-auto py-1 font-mono text-[11px] text-body">
            {logTail}
          </pre>
        </details>
      </Section>

      {/* ── domain browser — the single domain surface (tree · public · matter) */}
      {domainBrowser}

      <TrajectoryPanel
        sessionId={trajectory.length > 0 ? active.name.toLowerCase() : "042"}
        entries={trajectory.length > 0 ? trajectory : DEMO_TRAJECTORY}
      />

      <DashboardSummary domainCount={domains.length} />
    </div>
  );
}
