// Stripe REST client — zero SDK, fetch + node:crypto only.
//
// Stripe accepts `application/x-www-form-urlencoded` (NOT JSON) for the
// classic REST API. Their library uses the same wire format under the
// hood, so this stays 100% canonical.
//
// All requests authenticate via Bearer <secret_key>. The secret key
// MUST come from server env only — never expose to client (in contrast
// to the Firebase Web API key, which is intentionally public).

const STRIPE_BASE = "https://api.stripe.com/v1";

function getSecretKey(): string {
  const k = process.env.STRIPE_SECRET_KEY;
  if (!k) {
    throw new Error(
      "STRIPE_SECRET_KEY unset. Get sk_test_ from " +
        "https://dashboard.stripe.com/test/apikeys and " +
        "`secret set stripe.secret_key <key>` then export it."
    );
  }
  return k;
}

/** Encode a nested object as form-urlencoded per Stripe convention:
 *  `{a: {b: 1}}` → `a[b]=1` ; arrays via `a[0]=x&a[1]=y`. */
function encodeForm(obj: Record<string, unknown>, prefix = ""): string {
  const parts: string[] = [];
  const append = (k: string, v: unknown) => {
    if (v === undefined || v === null) return;
    if (Array.isArray(v)) {
      v.forEach((item, i) => {
        if (typeof item === "object" && item !== null) {
          parts.push(encodeForm(item as Record<string, unknown>, `${k}[${i}]`));
        } else {
          parts.push(`${encodeURIComponent(k)}[${i}]=${encodeURIComponent(String(item))}`);
        }
      });
    } else if (typeof v === "object") {
      parts.push(encodeForm(v as Record<string, unknown>, k));
    } else {
      parts.push(`${encodeURIComponent(k)}=${encodeURIComponent(String(v))}`);
    }
  };
  for (const [k, v] of Object.entries(obj)) {
    append(prefix ? `${prefix}[${k}]` : k, v);
  }
  return parts.filter(Boolean).join("&");
}

async function stripeCall<T>(
  path: string,
  init: { method?: string; body?: Record<string, unknown> } = {}
): Promise<T> {
  const url = `${STRIPE_BASE}${path}`;
  const method = init.method ?? "POST";
  const res = await fetch(url, {
    method,
    headers: {
      authorization: `Bearer ${getSecretKey()}`,
      "content-type": "application/x-www-form-urlencoded",
      "stripe-version": "2025-09-30.acacia",
    },
    body: init.body ? encodeForm(init.body) : undefined,
    signal: AbortSignal.timeout(15_000),
  });
  if (!res.ok) {
    const text = await res.text();
    let pretty = text.slice(0, 500);
    try {
      const j = JSON.parse(text) as { error?: { message?: string; code?: string } };
      if (j.error?.message) pretty = `${j.error.code ?? ""} ${j.error.message}`;
    } catch {
      /* leave raw */
    }
    throw new Error(`stripe ${res.status}: ${pretty}`);
  }
  return (await res.json()) as T;
}

export type CheckoutSession = {
  id: string;
  url: string;
  customer: string | null;
  client_reference_id: string | null;
  metadata: Record<string, string>;
};

export async function createCheckoutSession(params: {
  priceId: string;
  customerEmail: string;
  uid: string;
  successUrl: string;
  cancelUrl: string;
  trialPeriodDays?: number;
}): Promise<CheckoutSession> {
  const body: Record<string, unknown> = {
    mode: "subscription",
    "line_items[0][price]": params.priceId,
    "line_items[0][quantity]": 1,
    customer_email: params.customerEmail,
    client_reference_id: params.uid,
    "metadata[uid]": params.uid,
    success_url: params.successUrl,
    cancel_url: params.cancelUrl,
    allow_promotion_codes: true,
  };
  if (params.trialPeriodDays && params.trialPeriodDays > 0) {
    body["subscription_data[trial_period_days]"] = params.trialPeriodDays;
  }
  return stripeCall<CheckoutSession>("/checkout/sessions", { body });
}

export type BillingPortalSession = { id: string; url: string };

export async function createBillingPortalSession(params: {
  customerId: string;
  returnUrl: string;
}): Promise<BillingPortalSession> {
  return stripeCall<BillingPortalSession>("/billing_portal/sessions", {
    body: { customer: params.customerId, return_url: params.returnUrl },
  });
}

// ─── Webhook signature verification (Stripe standard) ──────────────────────
// Header `stripe-signature: t=<unix>,v1=<hmac_sha256>`
// Signed payload = `${t}.${rawBody}` with HMAC SHA-256 using webhook secret.

import { createHmac, timingSafeEqual } from "node:crypto";

export function verifyWebhookSignature(params: {
  rawBody: string;
  signatureHeader: string;
  webhookSecret: string;
  /** Tolerance in seconds; default 5 min. */
  toleranceSeconds?: number;
}): { ok: true; timestamp: number } | { ok: false; reason: string } {
  const tolerance = params.toleranceSeconds ?? 300;
  const fields: Record<string, string> = {};
  for (const seg of params.signatureHeader.split(",")) {
    const [k, v] = seg.split("=");
    if (k && v) fields[k.trim()] = v.trim();
  }
  const t = Number(fields.t);
  if (!t || Number.isNaN(t)) return { ok: false, reason: "missing t" };
  const sig = fields.v1;
  if (!sig) return { ok: false, reason: "missing v1" };
  if (Math.abs(Date.now() / 1000 - t) > tolerance) {
    return { ok: false, reason: "timestamp out of tolerance" };
  }
  const expected = createHmac("sha256", params.webhookSecret)
    .update(`${t}.${params.rawBody}`)
    .digest("hex");
  if (expected.length !== sig.length) {
    return { ok: false, reason: "signature length mismatch" };
  }
  if (!timingSafeEqual(Buffer.from(expected), Buffer.from(sig))) {
    return { ok: false, reason: "signature mismatch" };
  }
  return { ok: true, timestamp: t };
}

export function getWebhookSecret(): string {
  const k = process.env.STRIPE_WEBHOOK_SECRET;
  if (!k) {
    throw new Error(
      "STRIPE_WEBHOOK_SECRET unset. From `stripe listen` (or dashboard webhook), " +
        "`secret set stripe.webhook_secret whsec_...` then export it."
    );
  }
  return k;
}
