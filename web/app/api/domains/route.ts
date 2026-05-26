// GET /api/domains — list domains from DOMAINS.tape roster (Next 16 style).
//
// Read-only. exports/** typed records + roster are the only filesystem
// reads; no hexa-lang/stdlib imports (g_cockpit_isolation parallel).

import { listDomains } from "@/lib/domains";

export async function GET() {
  try {
    const domains = await listDomains();
    return Response.json({ domains, count: domains.length });
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    return Response.json({ error: msg }, { status: 500 });
  }
}
