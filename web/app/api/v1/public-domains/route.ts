// GET /api/v1/public-domains
//
// Returns founder-curated free public domain library
// (`domains/PUBLIC_DOMAINS.tape`) — drives the /library gallery page.
// Guests may view; fork action requires authenticated session (gated client-side).

import { NextResponse } from "next/server";
import { loadTape } from "@/lib/tape";

export const runtime = "nodejs";

export async function GET() {
  try {
    const nodes = await loadTape("domains/PUBLIC_DOMAINS.tape");
    const entries = nodes
      .filter((n) => n.type === "C")
      .map((n) => ({
        id: n.id,
        subject: n.subject ?? n.id,
        curator: n.fields.curator ?? "",
        version: n.fields.version ?? "",
        status: n.fields.status ?? "",
        composes: Array.isArray(n.fields.composes) ? n.fields.composes : [],
        hero_verb: n.fields.hero_verb ?? "analyze",
        license: n.fields.license ?? "MIT",
        fork_ok: n.fields.fork_ok === true,
        guest_view_ok: n.fields.guest_view_ok === true,
      }));
    const permissions =
      nodes.find((n) => n.id === "permissions")?.fields ?? {};
    return NextResponse.json({ entries, permissions });
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : String(e);
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
