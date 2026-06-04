// /cosmos — 🌌 the MAIN PAGE: the full Domain Cosmos as a 3D constellation.
//
// 8VERB §1 D1 (LOCKED): the app's spine is ONE 3D world showing ALL domains as
// a constellation, positioned by RUNG on a vertical scale axis (원자 bottom →
// 시스템 top), state encoded by color/badge, DOMAINS.tape @link reuse edges drawn as
// connectors. Clicking a node focuses its composition sub-tree (D2 decompose);
// filter chips (D6) dim non-matching nodes; a scale ladder (§2) labels the axis.
//
// This is the layperson on-ramp: the constellation itself IS the answer to
// "무엇을 만들 수 있나?" — no jargon required. Input is the left chat rail
// (owned by (app)/layout.tsx); this main area is OUTPUT-only (no input box).
//
// SSR-safe split (d4 · one generic path): this SERVER component calls
// buildCosmos() (node:fs reads of DOMAINS.tape roster + @link graph + the verdict
// ledger) and hands the plain graph to CosmosStage, which mounts the R3F scene
// client-only via next/dynamic(ssr:false). three never executes server-side.
//
// P6 hardening: all copy via i18n (app_gui.cosmos_*); honest empty/load-error
// states; a keyboard-accessible node list as the canvas text alternative.

import { STATE_BADGE, type CosmosGraph } from "@/lib/cosmos";
import { buildCosmos } from "@/lib/cosmos.server";
import { fmt } from "@/lib/cosmos-i18n";
import { getCosmosI18n } from "@/lib/cosmos-i18n.server";
import { CosmosStage } from "@/components/CosmosStage";

export const dynamic = "force-dynamic";

export default async function CosmosPage({
  searchParams,
}: {
  // P5 URL deeplink: /cosmos?target=<DOMAIN> → initial focused node.
  searchParams: Promise<{ target?: string }>;
}) {
  const i18n = await getCosmosI18n();

  // Honest load-failure state (P6 §2): if the graph can't be read off disk we
  // show a clear error panel, never a blank canvas presented as "success".
  let graph: CosmosGraph | null = null;
  let loadError = false;
  try {
    graph = await buildCosmos();
  } catch {
    loadError = true;
  }
  const sp = await searchParams;

  if (loadError || !graph) {
    return (
      <div className="space-y-4">
        <header className="space-y-1">
          <h1 className="font-display text-2xl font-light tracking-tight text-ink">
            {i18n.title}
          </h1>
        </header>
        <div
          role="alert"
          className="rounded-xl border border-danger/30 bg-danger/5 p-6 text-sm text-danger"
        >
          <p className="font-medium">{i18n.loadErrorTitle}</p>
          <p className="mt-1 text-danger/80">{i18n.loadErrorBody}</p>
        </div>
      </div>
    );
  }

  const rawTarget = sp.target ?? null;
  // Resolve the deeplink target to a real node name (case-insensitive); ignore
  // an unknown target so a stale link just opens the full cosmos.
  const initialFocus = rawTarget
    ? graph.nodes.find((n) => n.name.toUpperCase() === rawTarget.toUpperCase())?.name ??
      null
    : null;

  const verified = graph.nodes.filter(
    (n) => n.state === "verified" || n.state === "verified-formal",
  ).length;

  // Honest empty state (P6 §2): zero nodes → say so plainly, no empty 3D stage.
  if (graph.nodes.length === 0) {
    return (
      <div className="space-y-4">
        <header className="space-y-1">
          <h1 className="font-display text-2xl font-light tracking-tight text-ink">
            {i18n.title}
          </h1>
          <p className="max-w-prose text-sm text-muted">{i18n.intro}</p>
        </header>
        <div className="rounded-xl border border-hairline bg-canvas-soft p-6 text-sm text-muted">
          <p className="font-medium text-ink">{i18n.emptyTitle}</p>
          <p className="mt-1">{i18n.emptyBody}</p>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-4">
      <header className="space-y-1">
        <h1 className="font-display text-2xl font-light tracking-tight text-ink">
          {i18n.title}
        </h1>
        <p className="max-w-prose text-sm text-muted">{i18n.intro}</p>
        <div className="flex flex-wrap gap-3 pt-1 text-xs text-muted">
          <span>{fmt(i18n.domainsCount, { n: graph.nodes.length })}</span>
          <span>·</span>
          <span>
            {STATE_BADGE.verified} {fmt(i18n.verifiedCount, { n: verified })}
          </span>
          <span>·</span>
          <span>{fmt(i18n.edgesCount, { n: graph.edges.length })}</span>
        </div>
      </header>

      <CosmosStage graph={graph} initialFocus={initialFocus} i18n={i18n} />

      {/* legend — honest state vocabulary (§4) */}
      <div className="flex flex-wrap gap-x-4 gap-y-1 text-xs text-muted">
        <span>
          {STATE_BADGE["verified-formal"]} {i18n.state["verified-formal"]}
        </span>
        <span>
          {STATE_BADGE.verified} {i18n.state.verified}
        </span>
        <span>
          {STATE_BADGE["needs-verify"]} {i18n.state["needs-verify"]}
        </span>
        <span>
          {STATE_BADGE.unverified} {i18n.state.unverified}
        </span>
        <span>
          {STATE_BADGE.falsified} {i18n.state.falsified}
        </span>
      </div>
    </div>
  );
}
