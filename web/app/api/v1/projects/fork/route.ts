// POST /api/v1/projects/fork { sourceId } → user's private fork.

import { NextRequest, NextResponse } from "next/server";
import { currentUser } from "@/lib/session";
import { forkPublicDomain } from "@/lib/fork";

export const runtime = "nodejs";

export async function POST(req: NextRequest) {
  const u = await currentUser();
  if (!u) return NextResponse.json({ error: "unauthenticated" }, { status: 401 });
  let body: { sourceId?: string };
  try {
    body = (await req.json()) as { sourceId?: string };
  } catch {
    return NextResponse.json({ error: "invalid-json" }, { status: 400 });
  }
  const sourceId = body.sourceId;
  if (!sourceId) return NextResponse.json({ error: "sourceId required" }, { status: 400 });
  try {
    const { projectId } = await forkPublicDomain(u.localId, sourceId);
    return NextResponse.json({ projectId });
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : String(e);
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
