// POST /api/lemonsqueezy/webhook — HMAC-SHA256 verified.
// Mirrors stripe webhook surface: subscription_created → mark active in Firestore.
// Pairs with the single-active payment switch (providers/registry.payment.active).

import { NextRequest, NextResponse } from "next/server";
import { verifyWebhook } from "@/lib/lemonsqueezy";
import { setDoc } from "@/lib/firestore";

export const runtime = "nodejs";

type LSEvent = {
  meta?: { event_name?: string; custom_data?: { uid?: string } };
  data?: {
    id?: string;
    attributes?: {
      status?: string;
      ends_at?: string | null;
      product_name?: string;
      variant_name?: string;
      user_email?: string;
    };
  };
};

export async function POST(req: NextRequest) {
  const raw = await req.text();
  const sig = req.headers.get("x-signature");
  if (!verifyWebhook(raw, sig)) {
    return NextResponse.json({ error: "invalid signature" }, { status: 401 });
  }
  let evt: LSEvent;
  try {
    evt = JSON.parse(raw) as LSEvent;
  } catch {
    return NextResponse.json({ error: "bad json" }, { status: 400 });
  }
  const eventName = evt.meta?.event_name ?? "";
  const uid = evt.meta?.custom_data?.uid;
  if (!uid) {
    // No uid attached → ack so LS does not retry, but skip Firestore write.
    return NextResponse.json({ ok: true, skipped: "no-uid" });
  }
  if (eventName === "subscription_created" || eventName === "subscription_updated") {
    const subId = evt.data?.id ?? `ls-${Date.now()}`;
    await setDoc(`users/${uid}/subscriptions/${subId}`, {
      provider: "lemonsqueezy",
      status: evt.data?.attributes?.status ?? "unknown",
      endsAt: evt.data?.attributes?.ends_at ?? null,
      product: evt.data?.attributes?.product_name ?? "",
      variant: evt.data?.attributes?.variant_name ?? "",
      email: evt.data?.attributes?.user_email ?? "",
      receivedAt: new Date().toISOString(),
    });
  }
  return NextResponse.json({ ok: true });
}
