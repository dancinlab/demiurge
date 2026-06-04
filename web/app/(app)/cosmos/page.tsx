// /cosmos — 🌌 the MAIN PAGE: the full Domain Cosmos as a 3D constellation.
//
// 8VERB §1 D1 (LOCKED): the app's spine is ONE 3D world showing ALL domains as
// a constellation, positioned by RUNG on a vertical scale axis (원자 bottom →
// 시스템 top), state encoded by color/badge, NEXUS reuse edges drawn as
// connectors. Clicking a node focuses its composition sub-tree (D2 decompose);
// filter chips (D6) dim non-matching nodes; a scale ladder (§2) labels the axis.
//
// This is the layperson on-ramp: the constellation itself IS the answer to
// "무엇을 만들 수 있나?" — no jargon required. Input is the left chat rail
// (owned by (app)/layout.tsx); this main area is OUTPUT-only (no input box).
//
// SSR-safe split (d4 · one generic path): this SERVER component calls
// buildCosmos() (node:fs reads of NEXUS.tape + DOMAINS.tape + the verdict
// ledger) and hands the plain graph to CosmosStage, which mounts the R3F scene
// client-only via next/dynamic(ssr:false). three never executes server-side.

import { STATE_BADGE } from "@/lib/cosmos";
import { buildCosmos } from "@/lib/cosmos.server";
import { CosmosStage } from "@/components/CosmosStage";

export const dynamic = "force-dynamic";

export default async function CosmosPage({
  searchParams,
}: {
  // P5 URL deeplink: /cosmos?target=<DOMAIN> → initial focused node.
  searchParams: Promise<{ target?: string }>;
}) {
  const [graph, sp] = await Promise.all([buildCosmos(), searchParams]);
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

  return (
    <div className="space-y-4">
      <header className="space-y-1">
        <h1 className="font-display text-2xl font-light tracking-tight text-ink">
          🌌 도메인 코스모스
        </h1>
        <p className="max-w-prose text-sm text-muted">
          원자부터 시스템까지, 지금까지 다룬 모든 분야를 하나의 별자리로 봅니다.
          빛나는 노드는 이미 검증된 것, 흐린 노드는 아직 더 필요한 것. 노드를
          누르면 그것이 무엇으로 이루어지는지 펼쳐집니다. (만들고 싶은 것은 왼쪽
          채팅으로 말해 보세요.)
        </p>
        <div className="flex flex-wrap gap-3 pt-1 text-xs text-muted">
          <span>{graph.nodes.length}개 도메인</span>
          <span>·</span>
          <span>
            {STATE_BADGE.verified} 검증됨 {verified}
          </span>
          <span>·</span>
          <span>{graph.edges.length}개 재사용 연결 (NEXUS)</span>
        </div>
      </header>

      <CosmosStage graph={graph} initialFocus={initialFocus} />

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
