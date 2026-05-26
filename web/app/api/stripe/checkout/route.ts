// POST /api/stripe/checkout { tier: "solo" | "team" | "org" }
//  → { url } Stripe Checkout 페이지로 redirect.

import { createCheckoutSession } from "@/lib/stripe";
import { priceIdFor, TIERS } from "@/lib/billing";
import { currentUser } from "@/lib/session";

const TIER_IDS = new Set(TIERS.map((t) => t.id));

export async function POST(request: Request) {
  let body: { tier?: unknown };
  try {
    body = await request.json();
  } catch {
    return Response.json({ error: "invalid JSON body" }, { status: 400 });
  }
  const tier = body.tier;
  if (typeof tier !== "string" || !TIER_IDS.has(tier as "solo")) {
    return Response.json({ error: "tier must be one of solo|team|org" }, { status: 400 });
  }

  const user = await currentUser();
  if (!user) {
    return Response.json({ error: "sign in first" }, { status: 401 });
  }

  try {
    const origin = new URL(request.url).origin;
    const session = await createCheckoutSession({
      priceId: priceIdFor(tier as "solo"),
      customerEmail: user.email,
      uid: user.localId,
      successUrl: `${origin}/account?checkout=ok&session_id={CHECKOUT_SESSION_ID}`,
      cancelUrl: `${origin}/pricing?checkout=cancel`,
      trialPeriodDays: 14,
    });
    return Response.json({ url: session.url, id: session.id });
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    const status =
      msg.includes("STRIPE_SECRET_KEY") || msg.includes("STRIPE_PRICE_")
        ? 503
        : 500;
    return Response.json({ error: msg }, { status });
  }
}
