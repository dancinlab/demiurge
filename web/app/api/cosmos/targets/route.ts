// GET /api/cosmos/targets — the cosmos node-name roster for client-side target
// extraction (P5 chat→focus wiring, 8VERB Cosmos D4).
//
// The left chat rail (AssistChat) fetches this once and, when a user message
// names a known target (e.g. "UFO 만들어줘"), dispatches a `demiurge:focus`
// window event so the cosmos focuses that node IN PLACE. Read-only; returns the
// full cosmos node set (roster + edge-endpoint stubs) names + icons.

import { buildCosmos } from "@/lib/cosmos.server";

export const dynamic = "force-dynamic";

export async function GET() {
  try {
    const graph = await buildCosmos();
    const targets = graph.nodes.map((n) => ({ name: n.name, icon: n.icon ?? null }));
    return Response.json({ targets, count: targets.length });
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    return Response.json({ error: msg }, { status: 500 });
  }
}
