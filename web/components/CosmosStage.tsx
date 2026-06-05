// CosmosStage — the SSR boundary for the 3D cosmos (D1 main page).
//
// A thin client component that lazy-loads CosmosScene with next/dynamic
// ssr:false (three/R3F must never run server-side). The server page
// (app/(app)/cosmos/page.tsx) calls buildCosmos() and passes the plain graph
// down as a prop, so the heavy lib code stays out of the SSR pass and the
// browser only fetches the WebGL bundle on the client. Mirrors the
// DomainModel3D / JosephsonScene SSR-safe pattern.
//
// P6: the i18n bag is threaded down so CosmosScene (client) carries NO literal
// copy; the dynamic loading fallback also reads the localized string.

"use client";

import { useMemo } from "react";
import dynamic from "next/dynamic";
import type { CosmosGraph } from "@/lib/cosmos";
import type { CosmosI18n } from "@/lib/cosmos-i18n";

export function CosmosStage({
  graph,
  initialFocus,
  i18n,
}: {
  graph: CosmosGraph;
  /** P5 URL deeplink: /cosmos?target=<DOMAIN> → initial focused node. */
  initialFocus?: string | null;
  i18n: CosmosI18n;
}) {
  // Memoize the dynamic component so the chunk isn't re-created each render;
  // the localized loading label is captured in the closure (stable per locale).
  const CosmosScene = useMemo(
    () =>
      dynamic(
        () =>
          import("@/components/CosmosScene").then((m) => ({
            default: m.CosmosScene,
          })),
        {
          ssr: false,
          loading: () => (
            <div
              role="status"
              aria-live="polite"
              className="grid h-full w-full place-items-center bg-[#16130f] text-sm text-stone-400"
            >
              {i18n.loading}
            </div>
          ),
        },
      ),
    [i18n.loading],
  );

  return (
    <div className="h-[calc(100vh-7rem)] min-h-[420px] w-full overflow-hidden rounded-xl border border-stone-800">
      <CosmosScene graph={graph} initialFocus={initialFocus} i18n={i18n} />
    </div>
  );
}

export default CosmosStage;
