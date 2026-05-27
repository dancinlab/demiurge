// GET /api/v1/handoff/[domain] — authoritative dossier endpoint.
// Returns Dossier JSON. `?download=1` sets attachment headers for browser save.
// This is the surface that COMPLETES the handoff verb — user clicks download
// and walks away with every record/decision needed to continue the work.

import { NextRequest, NextResponse } from "next/server";
import { currentUser } from "@/lib/session";
import { buildDossier } from "@/lib/dossier";

export const runtime = "nodejs";

export async function GET(
  req: NextRequest,
  { params }: { params: Promise<{ domain: string }> },
) {
  const u = await currentUser();
  if (!u) return NextResponse.json({ error: "unauthenticated" }, { status: 401 });
  const { domain } = await params;
  const dossier = await buildDossier(u.localId, domain);
  const body = JSON.stringify(dossier, null, 2);
  const isDownload = req.nextUrl.searchParams.get("download") === "1";
  const headers: Record<string, string> = {
    "content-type": "application/json; charset=utf-8",
  };
  if (isDownload) {
    headers["content-disposition"] = `attachment; filename="dossier-${domain}-${dossier.generated_at.slice(0, 10)}.json"`;
  }
  return new Response(body, { headers });
}
