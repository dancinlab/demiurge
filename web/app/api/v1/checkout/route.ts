// POST /api/v1/checkout — payment provider switch endpoint.
// User UI is invariant — router reads providers/registry.payment.active and
// hands off to the corresponding provider's checkout flow (Q11).

import { NextRequest, NextResponse } from "next/server";
import { currentUser } from "@/lib/session";
import { getRegistry } from "@/lib/providers";
import { createCheckout as lsCheckout } from "@/lib/lemonsqueezy";

export const runtime = "nodejs";

type CheckoutBody = { tier?: string; redirectUrl?: string };

export async function POST(req: NextRequest) {
  const u = await currentUser();
  if (!u) return NextResponse.json({ error: "unauthenticated" }, { status: 401 });

  let body: CheckoutBody;
  try {
    body = (await req.json()) as CheckoutBody;
  } catch {
    return NextResponse.json({ error: "invalid-json" }, { status: 400 });
  }
  const tier = body.tier ?? "solo";
  const redirectUrl = body.redirectUrl ?? `${req.nextUrl.origin}/account`;

  const registry = await getRegistry();
  const active = registry.payment.active;

  try {
    if (active === "stripe") {
      // Defer to existing /api/stripe/checkout — keep its proven flow intact.
      const stripeRes = await fetch(`${req.nextUrl.origin}/api/stripe/checkout`, {
        method: "POST",
        headers: {
          "content-type": "application/json",
          cookie: req.headers.get("cookie") ?? "",
        },
        body: JSON.stringify({ tier, successUrl: redirectUrl }),
      });
      const data = (await stripeRes.json()) as Record<string, unknown>;
      return NextResponse.json({ provider: "stripe", ...data }, { status: stripeRes.status });
    }
    if (active === "lemonsqueezy") {
      const variantEnv = `LEMONSQUEEZY_VARIANT_${tier.toUpperCase()}`;
      const variantId = process.env[variantEnv];
      if (!variantId) {
        return NextResponse.json({ error: `missing ${variantEnv}` }, { status: 503 });
      }
      const url = await lsCheckout({ variantId, email: u.email, redirectUrl });
      return NextResponse.json({ provider: "lemonsqueezy", url });
    }
    return NextResponse.json({ error: `unknown active provider: ${active}` }, { status: 500 });
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : String(err);
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
