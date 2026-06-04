// /d/<DOMAIN> — the node-detail surface (8VERB Cosmos §1 D4 page-routing layer).
//
// Server component: resolves ONE focused node from the cosmos graph
// (cosmos.server resolveCosmosNode — the shared SSOT lookup, d4 single generic
// path), then shows:
//   - the node's 3D model (DomainModel3D, SSR-safe, descriptor-driven)
//   - its composition (decompose) tree with per-child rollup state
//   - its verify state (honest §4 badge)
//   - a row of links to its 8 verb work-pages (/<verb>/<domain>)
//   - a 작업하기 ▶ control → router.push into the first verb (REAL page nav;
//     browser back returns to /cosmos).
//
// [domain] is a single dynamic segment (flat names like UFO / RTSC). Nested
// meta ids (CARDIO+/DAPTPGX) reach the verb pages via the [...domain] catch-all
// there; this detail surface keys on the leaf name (resolveCosmosNode handles
// both forms). force-dynamic — the graph reads NEXUS/roster/ledger off disk.

import Link from "next/link";
import { notFound } from "next/navigation";
import { STATE_BADGE, type CosmosTree } from "@/lib/cosmos";
import { resolveCosmosNode } from "@/lib/cosmos.server";
import { getMessages, t } from "@/lib/i18n";
import { getCosmosI18n } from "@/lib/cosmos-i18n.server";
import { VERBS } from "@/lib/verbs";
import { DomainModel3D } from "@/components/DomainModel3D";
import { WorkButton } from "@/components/cosmos/WorkButton";

export const dynamic = "force-dynamic";

// Flatten the composition tree into indented rows for a compact, honest listing.
function flatten(
  tree: CosmosTree,
  depth: number,
  out: { tree: CosmosTree; depth: number }[],
): void {
  out.push({ tree, depth });
  for (const c of tree.children) flatten(c, depth + 1, out);
}

export default async function DomainDetailPage({
  params,
}: {
  params: Promise<{ domain: string }>;
}) {
  const { domain } = await params;
  const id = decodeURIComponent(domain);
  const [{ node, decomposition }, i18n, messages] = await Promise.all([
    resolveCosmosNode(id),
    getCosmosI18n(),
    getMessages(),
  ]);

  if (!node) notFound();

  const d = (k: string) => t(messages, `app_gui.${k}`);
  const STATE_LABEL = i18n.state;
  const rollup = decomposition?.tree.rollup ?? node.state;
  const rows: { tree: CosmosTree; depth: number }[] = [];
  if (decomposition) flatten(decomposition.tree, 0, rows);

  return (
    <div className="space-y-5">
      {/* ── header: identity head (§ d10 icon · NAME · alias) + honest state ── */}
      <header className="space-y-1">
        <div className="flex items-center gap-2">
          <Link
            href="/cosmos"
            className="text-xs text-muted hover:text-ink focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-primary"
          >
            {d("detail_breadcrumb_cosmos")}
          </Link>
          <span className="text-xs text-muted">/</span>
          <span className="text-xs text-muted">{node.name}</span>
        </div>
        <h1 className="flex items-center gap-2 font-display text-2xl font-light tracking-tight text-ink">
          {node.icon && <span>{node.icon}</span>}
          <span>{node.name}</span>
          <span title={STATE_LABEL[rollup]}>{STATE_BADGE[rollup]}</span>
        </h1>
        {node.alias && <p className="text-sm text-muted">{node.alias}</p>}
        {node.goal && <p className="max-w-prose text-sm text-body">{node.goal}</p>}
        <div className="flex flex-wrap items-center gap-3 pt-1 text-xs text-muted">
          <span>
            {d("detail_state")}: {STATE_BADGE[node.state]} {STATE_LABEL[node.state]}
          </span>
          {decomposition && rollup !== node.state && (
            <span>
              · {d("detail_rollup")}: {STATE_BADGE[rollup]} {STATE_LABEL[rollup]}
            </span>
          )}
          {node.progress && (
            <span>
              · {d("detail_progress")} {node.progress.done}/{node.progress.total}
            </span>
          )}
          <span>· {d("detail_rung")}: {i18n.rung[node.rung]}</span>
        </div>
      </header>

      <div className="grid gap-5 md:grid-cols-2">
        {/* ── 3D model (descriptor-driven; faithful where data exists, §D3) ── */}
        <section className="space-y-2">
          <h2 className="text-sm font-medium text-ink">{d("detail_model_heading")}</h2>
          <div className="h-72 w-full overflow-hidden rounded-xl border border-hairline bg-[#16130f]">
            <DomainModel3D
              domain={node.name}
              rung={node.rung}
              goal={node.goal}
              state={node.state}
              noDataLabel={i18n.modelNoData}
              errorLabel={i18n.modelError}
            />
          </div>
        </section>

        {/* ── composition tree (decompose) ─────────────────────────────────── */}
        <section className="space-y-2">
          <h2 className="text-sm font-medium text-ink">
            {d("detail_composition_heading")}
          </h2>
          {rows.length <= 1 ? (
            <p className="text-sm text-muted">{d("detail_leaf")}</p>
          ) : (
            <ul className="space-y-1 text-sm">
              {rows.map(({ tree, depth }, i) => (
                <li
                  key={`${tree.node.name}-${i}`}
                  className="flex items-center gap-2"
                  style={{ paddingLeft: depth * 16 }}
                >
                  <span title={STATE_LABEL[tree.rollup]}>
                    {STATE_BADGE[tree.rollup]}
                  </span>
                  {tree.node.icon && <span aria-hidden>{tree.node.icon}</span>}
                  {depth === 0 ? (
                    <span className="font-medium text-ink">{tree.node.name}</span>
                  ) : (
                    <Link
                      href={`/d/${encodeURIComponent(tree.node.name)}`}
                      className="text-body underline-offset-2 hover:underline focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-primary"
                    >
                      {tree.node.name}
                    </Link>
                  )}
                  {tree.via?.primitive && (
                    <span className="truncate text-xs text-muted">
                      · {tree.via.primitive}
                    </span>
                  )}
                </li>
              ))}
            </ul>
          )}
        </section>
      </div>

      {/* ── 8-verb work-pages + 작업하기 (D4 node→work-page navigation) ──────── */}
      <section className="space-y-2">
        <div className="flex flex-wrap items-center gap-3">
          <h2 className="text-sm font-medium text-ink">{d("detail_work_heading")}</h2>
          <WorkButton domain={node.name} verb={VERBS[0].id} label={i18n.work} />
        </div>
        <div className="flex flex-wrap gap-2">
          {VERBS.map((v, i) => (
            <Link
              key={v.id}
              href={`/${v.id}/${encodeURIComponent(node.name)}`}
              className="rounded-full border border-hairline bg-surface px-3 py-1 text-xs text-body hover:bg-surface-strong focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-primary"
            >
              <span className="mr-1 text-muted">{i}</span>
              {v.label}
            </Link>
          ))}
        </div>
        <p className="text-xs text-muted">{d("detail_back_note")}</p>
      </section>

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
