// POST /api/stripe/portal { customerId } → Stripe billing portal URL.
// Authenticated user only. customerId은 webhook이 Firestore에 적재한
// 매핑에서 가져오는 게 production 흐름이지만 M16c는 직접 받아 부른다.

import { createBillingPortalSession } from "@/lib/stripe";
import { currentUser } from "@/lib/session";

export async function POST(request: Request) {
  const user = await currentUser();
  if (!user) {
    return Response.json({ error: "sign in first" }, { status: 401 });
  }

  let body: { customerId?: unknown };
  try {
    body = await request.json();
  } catch {
    return Response.json({ error: "invalid JSON body" }, { status: 400 });
  }
  const customerId = body.customerId;
  if (typeof customerId !== "string" || !customerId.startsWith("cus_")) {
    return Response.json({ error: "customerId (cus_*) required" }, { status: 400 });
  }

  try {
    const origin = new URL(request.url).origin;
    const sess = await createBillingPortalSession({
      customerId,
      returnUrl: `${origin}/account`,
    });
    return Response.json({ url: sess.url });
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    const status = msg.includes("STRIPE_SECRET_KEY") ? 503 : 500;
    return Response.json({ error: msg }, { status });
  }
}
