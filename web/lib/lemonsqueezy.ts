// Lemon Squeezy REST client — Merchant-of-Record alternative to Stripe.
// Zero npm install · raw fetch + node:crypto HMAC for webhook verification.
// Pairs with web/lib/stripe.ts via the single-active switch in providers/registry.

import { createHmac, timingSafeEqual } from "node:crypto";

const API_BASE = "https://api.lemonsqueezy.com/v1";

function apiKey(): string {
  const k = process.env.LEMONSQUEEZY_API_KEY;
  if (!k) throw new Error("LEMONSQUEEZY_API_KEY env var required");
  return k;
}

function storeId(): string {
  const s = process.env.LEMONSQUEEZY_STORE_ID;
  if (!s) throw new Error("LEMONSQUEEZY_STORE_ID env var required");
  return s;
}

export type LSCheckoutInput = {
  variantId: string;
  email: string;
  redirectUrl: string;
};

export async function createCheckout(input: LSCheckoutInput): Promise<string> {
  const res = await fetch(`${API_BASE}/checkouts`, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${apiKey()}`,
      Accept: "application/vnd.api+json",
      "Content-Type": "application/vnd.api+json",
    },
    body: JSON.stringify({
      data: {
        type: "checkouts",
        attributes: {
          checkout_data: { email: input.email },
          product_options: { redirect_url: input.redirectUrl },
        },
        relationships: {
          store: { data: { type: "stores", id: storeId() } },
          variant: { data: { type: "variants", id: input.variantId } },
        },
      },
    }),
  });
  if (!res.ok) {
    const text = await res.text();
    throw new Error(`Lemon Squeezy checkout failed (${res.status}): ${text}`);
  }
  const json = (await res.json()) as { data?: { attributes?: { url?: string } } };
  const url = json.data?.attributes?.url;
  if (!url) throw new Error("Lemon Squeezy did not return a checkout url");
  return url;
}

/**
 * Verify Lemon Squeezy webhook signature (X-Signature header, HMAC-SHA256 over body).
 * Returns true iff signature matches LEMONSQUEEZY_WEBHOOK_SECRET.
 */
export function verifyWebhook(body: string, signature: string | null): boolean {
  const secret = process.env.LEMONSQUEEZY_WEBHOOK_SECRET;
  if (!secret || !signature) return false;
  const digest = createHmac("sha256", secret).update(body).digest("hex");
  try {
    return timingSafeEqual(Buffer.from(digest), Buffer.from(signature));
  } catch {
    return false;
  }
}
