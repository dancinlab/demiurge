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
import {
  STATE_BADGE,
  type CosmosTree,
  type VerifyState,
} from "@/lib/cosmos";
import { resolveCosmosNode } from "@/lib/cosmos.server";
import { VERBS } from "@/lib/verbs";
import { DomainModel3D } from "@/components/DomainModel3D";
import { WorkButton } from "@/components/cosmos/WorkButton";

export const dynamic = "force-dynamic";

const STATE_LABEL: Record<VerifyState, string> = {
  "verified-formal": "검증됨(엄밀)",
  verified: "검증됨",
  "needs-verify": "검증필요",
  unverified: "미검증",
  falsified: "반증됨",
};

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
  const { node, decomposition } = await resolveCosmosNode(id);

  if (!node) notFound();

  const rollup = decomposition?.tree.rollup ?? node.state;
  const rows: { tree: CosmosTree; depth: number }[] = [];
  if (decomposition) flatten(decomposition.tree, 0, rows);

  return (
    <div className="space-y-5">
      {/* ── header: identity head (§ d10 icon · NAME · alias) + honest state ── */}
      <header className="space-y-1">
        <div className="flex items-center gap-2">
          <Link href="/cosmos" className="text-xs text-muted hover:text-ink">
            🌌 코스모스
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
            상태: {STATE_BADGE[node.state]} {STATE_LABEL[node.state]}
          </span>
          {decomposition && rollup !== node.state && (
            <span>
              · 구성 포함 종합: {STATE_BADGE[rollup]} {STATE_LABEL[rollup]}
            </span>
          )}
          {node.progress && (
            <span>
              · 진행 {node.progress.done}/{node.progress.total}
            </span>
          )}
          <span>· 단계(rung): {node.rung}</span>
        </div>
      </header>

      <div className="grid gap-5 md:grid-cols-2">
        {/* ── 3D model (descriptor-driven; faithful where data exists, §D3) ── */}
        <section className="space-y-2">
          <h2 className="text-sm font-medium text-ink">3D 모델</h2>
          <div className="h-72 w-full overflow-hidden rounded-xl border border-hairline bg-[#16130f]">
            <DomainModel3D
              domain={node.name}
              rung={node.rung}
              goal={node.goal}
              state={node.state}
            />
          </div>
        </section>

        {/* ── composition tree (decompose) ─────────────────────────────────── */}
        <section className="space-y-2">
          <h2 className="text-sm font-medium text-ink">구성 (무엇으로 이루어지나)</h2>
          {rows.length <= 1 ? (
            <p className="text-sm text-muted">
              하위 도메인이 없는 말단 노드입니다 (직접 검증 대상).
            </p>
          ) : (
            <ul className="space-y-1 text-sm">
              {rows.map(({ tree, depth }, i) => (
                <li
                  key={`${tree.node.name}-${i}`}
                  className="flex items-center gap-2"
                  style={{ paddingLeft: depth * 16 }}
                >
                  <span>{STATE_BADGE[tree.rollup]}</span>
                  {tree.node.icon && <span>{tree.node.icon}</span>}
                  {depth === 0 ? (
                    <span className="font-medium text-ink">{tree.node.name}</span>
                  ) : (
                    <Link
                      href={`/d/${encodeURIComponent(tree.node.name)}`}
                      className="text-body underline-offset-2 hover:underline"
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
          <h2 className="text-sm font-medium text-ink">작업 (8-verb 파이프라인)</h2>
          <WorkButton domain={node.name} verb={VERBS[0].id} />
        </div>
        <div className="flex flex-wrap gap-2">
          {VERBS.map((v, i) => (
            <Link
              key={v.id}
              href={`/${v.id}/${encodeURIComponent(node.name)}`}
              className="rounded-full border border-hairline bg-surface px-3 py-1 text-xs text-body hover:bg-surface-strong"
            >
              <span className="mr-1 text-muted">{i}</span>
              {v.label}
            </Link>
          ))}
        </div>
        <p className="text-xs text-muted">
          작업 페이지로 들어가도 뒤로 가기(브라우저)로 코스모스로 돌아옵니다.
        </p>
      </section>

      {/* legend — honest state vocabulary (§4) */}
      <div className="flex flex-wrap gap-x-4 gap-y-1 text-xs text-muted">
        <span>{STATE_BADGE["verified-formal"]} 검증됨(엄밀)</span>
        <span>{STATE_BADGE.verified} 검증됨</span>
        <span>{STATE_BADGE["needs-verify"]} 검증필요</span>
        <span>{STATE_BADGE.unverified} 미검증</span>
        <span>{STATE_BADGE.falsified} 반증됨</span>
      </div>
    </div>
  );
}
