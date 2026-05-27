// GET  /api/v1/providers — public read of registry (drives Web GUI + CLI routing)
// POST /api/v1/providers — admin-only write (toggle enabled · set active · adjust priority)

import { NextRequest, NextResponse } from "next/server";
import { currentUser } from "@/lib/session";
import { getDoc } from "@/lib/firestore";
import {
  getRegistry,
  writeRegistry,
  type ProviderRegistry,
} from "@/lib/providers";

export const runtime = "nodejs";

export async function GET() {
  const registry = await getRegistry();
  return NextResponse.json({ registry });
}

async function isAdmin(uid: string): Promise<boolean> {
  try {
    const doc = await getDoc(`users/${uid}`);
    return doc !== null && (doc as Record<string, unknown>).role === "admin";
  } catch {
    return false;
  }
}

export async function POST(req: NextRequest) {
  const u = await currentUser();
  if (!u) {
    return NextResponse.json({ error: "unauthenticated" }, { status: 401 });
  }
  if (!(await isAdmin(u.localId))) {
    return NextResponse.json({ error: "admin-only" }, { status: 403 });
  }
  let body: Partial<ProviderRegistry>;
  try {
    body = (await req.json()) as Partial<ProviderRegistry>;
  } catch {
    return NextResponse.json({ error: "invalid-json" }, { status: 400 });
  }
  const current = await getRegistry();
  const next: ProviderRegistry = {
    payment: body.payment ?? current.payment,
    gpu: body.gpu ?? current.gpu,
    llm: body.llm ?? current.llm,
  };
  // Single-active payment invariant — coerce active into available.
  if (!next.payment.available.includes(next.payment.active)) {
    const fallback = next.payment.available[0] ?? "stripe";
    next.payment.active = fallback as "stripe" | "lemonsqueezy";
  }
  await writeRegistry(next);
  return NextResponse.json({ registry: next });
}
