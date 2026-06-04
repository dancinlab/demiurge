// CosmosStage — the SSR boundary for the 3D cosmos (D1 main page).
//
// A thin client component that lazy-loads CosmosScene with next/dynamic
// ssr:false (three/R3F must never run server-side). The server page
// (app/(app)/cosmos/page.tsx) calls buildCosmos() and passes the plain graph
// down as a prop, so the heavy lib code stays out of the SSR pass and the
// browser only fetches the WebGL bundle on the client. Mirrors the
// DomainModel3D / JosephsonScene SSR-safe pattern.

"use client";

import dynamic from "next/dynamic";
import type { CosmosGraph } from "@/lib/cosmos";

const CosmosScene = dynamic(
  () => import("@/components/CosmosScene").then((m) => ({ default: m.CosmosScene })),
  {
    ssr: false,
    loading: () => (
      <div className="grid h-full w-full place-items-center bg-[#16130f] text-sm text-stone-400">
        🌌 코스모스 불러오는 중…
      </div>
    ),
  },
);

export function CosmosStage({
  graph,
  initialFocus,
}: {
  graph: CosmosGraph;
  /** P5 URL deeplink: /cosmos?target=<DOMAIN> → initial focused node. */
  initialFocus?: string | null;
}) {
  return (
    <div className="h-[calc(100vh-7rem)] min-h-[520px] w-full overflow-hidden rounded-xl border border-stone-800">
      <CosmosScene graph={graph} initialFocus={initialFocus} />
    </div>
  );
}

export default CosmosStage;
