// POST /api/stripe/webhook — Stripe → demiurge subscription events.
//
// HMAC SHA-256 signature verification using node:crypto (no SDK).
// On verified event: idempotency-lock via Firestore stripe_events/{id},
// then upsert users/{uid}/subscriptions/{subId} with the relevant
// subscription snapshot.

import { verifyWebhookSignature, getWebhookSecret } from "@/lib/stripe";
import { reserveEvent, setDoc } from "@/lib/firestore";

type StripeEvent = {
  id: string;
  type: string;
  data: { object: Record<string, unknown> };
};

type SubscriptionObject = {
  id: string;
  customer?: string;
  status?: string;
  current_period_end?: number;
  cancel_at_period_end?: boolean;
  metadata?: { uid?: string };
  items?: { data?: Array<{ price?: { id?: string } }> };
};

type CheckoutSessionObject = {
  id: string;
  customer?: string;
  client_reference_id?: string;
  metadata?: { uid?: string };
  subscription?: string;
};

function uidOf(obj: { metadata?: { uid?: string }; client_reference_id?: string }): string | null {
  return obj.metadata?.uid ?? obj.client_reference_id ?? null;
}

export async function POST(request: Request) {
  const sig = request.headers.get("stripe-signature");
  if (!sig) {
    return Response.json({ error: "missing stripe-signature" }, { status: 400 });
  }

  let secret: string;
  try {
    secret = getWebhookSecret();
  } catch (err) {
    return Response.json(
      { error: err instanceof Error ? err.message : String(err) },
      { status: 503 }
    );
  }

  const rawBody = await request.text();
  const ok = verifyWebhookSignature({
    rawBody,
    signatureHeader: sig,
    webhookSecret: secret,
  });
  if (!ok.ok) {
    return Response.json({ error: `signature: ${ok.reason}` }, { status: 400 });
  }

  let event: StripeEvent;
  try {
    event = JSON.parse(rawBody) as StripeEvent;
  } catch {
    return Response.json({ error: "invalid JSON body" }, { status: 400 });
  }

  // Idempotency: reserve event id in Firestore. If reserve returns false,
  // we've already processed this delivery.
  let firstDelivery = true;
  try {
    firstDelivery = await reserveEvent(event.id);
  } catch (err) {
    // Firestore not reachable in local dev (no token); fall back to allow.
    // Production always has the metadata server, so this only ever takes
    // the loud path when Cloud Run is misconfigured — surface but still 200.
    console.warn("reserveEvent failed:", err instanceof Error ? err.message : err);
  }
  if (!firstDelivery) {
    return Response.json({ ok: true, dedup: true });
  }

  try {
    switch (event.type) {
      case "checkout.session.completed": {
        const obj = event.data.object as CheckoutSessionObject;
        const uid = uidOf(obj);
        if (uid && obj.subscription) {
          await setDoc(`users/${uid}/subscriptions/${obj.subscription}`, {
            stripeCustomer: obj.customer ?? null,
            checkoutSession: obj.id,
            status: "pending",
            createdAt: new Date(),
          });
        }
        break;
      }
      case "customer.subscription.created":
      case "customer.subscription.updated":
      case "customer.subscription.deleted": {
        const obj = event.data.object as SubscriptionObject;
        const uid = uidOf(obj);
        if (uid) {
          const priceId = obj.items?.data?.[0]?.price?.id ?? null;
          await setDoc(`users/${uid}/subscriptions/${obj.id}`, {
            stripeCustomer: obj.customer ?? null,
            status: obj.status ?? "unknown",
            priceId,
            currentPeriodEnd: obj.current_period_end
              ? new Date(obj.current_period_end * 1000)
              : null,
            cancelAtPeriodEnd: obj.cancel_at_period_end ?? false,
            updatedAt: new Date(),
          });
        }
        break;
      }
      case "invoice.payment_succeeded":
      case "invoice.payment_failed":
        // Invoice handling lands in M17b once revenue accounting is wired.
        break;
      default:
        break;
    }
  } catch (err) {
    console.warn(
      `webhook persist failed for ${event.type}:`,
      err instanceof Error ? err.message : err
    );
  }

  return Response.json({ ok: true, type: event.type });
}

export async function GET() {
  return Response.json({
    note: "POST-only endpoint. Stripe events persist to Firestore " +
      "stripe_events/{id} (idempotency) + users/{uid}/subscriptions/{subId}.",
  });
}
