// POST /api/v1/discover { seed, rounds? } — runs phanes discover (8th verb).
// auth required (cost-bearing subprocess).

import { NextRequest, NextResponse } from "next/server";
import { currentUser } from "@/lib/session";
import { discover } from "@/lib/phanes";

export const runtime = "nodejs";

export async function POST(req: NextRequest) {
  const u = await currentUser();
  if (!u) return NextResponse.json({ error: "unauthenticated" }, { status: 401 });
  let body: { seed?: string; rounds?: number };
  try {
    body = (await req.json()) as { seed?: string; rounds?: number };
  } catch {
    return NextResponse.json({ error: "invalid-json" }, { status: 400 });
  }
  const seed = body.seed?.trim();
  if (!seed) return NextResponse.json({ error: "seed required" }, { status: 400 });
  const rounds = Math.max(1, Math.min(8, body.rounds ?? 3));
  const result = await discover(seed, rounds);
  return NextResponse.json(result);
}
