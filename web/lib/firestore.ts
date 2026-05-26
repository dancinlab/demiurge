// Cloud Firestore REST client — zero SDK. Uses the same Vertex AI
// auth strategy (metadata server on Cloud Run, GOOGLE_ACCESS_TOKEN
// for local dev).
//
// Document path convention: `users/{uid}/subscriptions/{subId}` —
// Stripe webhook updates one document per subscription event.

const FIRESTORE_BASE = "https://firestore.googleapis.com/v1";
const METADATA_TOKEN_URL =
  "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token";

let cachedToken: { token: string; expiresAt: number } | null = null;

async function fetchTokenFromMetadata(): Promise<string | null> {
  try {
    const res = await fetch(METADATA_TOKEN_URL, {
      headers: { "Metadata-Flavor": "Google" },
      signal: AbortSignal.timeout(2000),
    });
    if (!res.ok) return null;
    const body = (await res.json()) as { access_token: string; expires_in: number };
    cachedToken = {
      token: body.access_token,
      expiresAt: Date.now() + (body.expires_in - 60) * 1000,
    };
    return body.access_token;
  } catch {
    return null;
  }
}

async function getAccessToken(): Promise<string> {
  if (cachedToken && cachedToken.expiresAt > Date.now()) return cachedToken.token;
  const env = process.env.GOOGLE_ACCESS_TOKEN;
  if (env) return env;
  const meta = await fetchTokenFromMetadata();
  if (meta) return meta;
  throw new Error(
    "Firestore auth unavailable. Set GOOGLE_ACCESS_TOKEN for local dev " +
      "or deploy to Cloud Run for metadata-server ADC."
  );
}

function getProjectId(): string {
  const p = process.env.GCP_PROJECT ?? process.env.GOOGLE_CLOUD_PROJECT;
  if (!p) throw new Error("GCP_PROJECT unset");
  return p;
}

// Firestore REST encodes typed values as { stringValue / integerValue /
// booleanValue / timestampValue / mapValue / arrayValue / nullValue }.
function encodeValue(v: unknown): Record<string, unknown> {
  if (v === null || v === undefined) return { nullValue: null };
  if (typeof v === "string") return { stringValue: v };
  if (typeof v === "boolean") return { booleanValue: v };
  if (typeof v === "number") {
    return Number.isInteger(v)
      ? { integerValue: String(v) }
      : { doubleValue: v };
  }
  if (v instanceof Date) return { timestampValue: v.toISOString() };
  if (Array.isArray(v)) {
    return { arrayValue: { values: v.map(encodeValue) } };
  }
  if (typeof v === "object") {
    return { mapValue: { fields: encodeFields(v as Record<string, unknown>) } };
  }
  return { stringValue: String(v) };
}

function encodeFields(obj: Record<string, unknown>): Record<string, unknown> {
  const fields: Record<string, unknown> = {};
  for (const [k, v] of Object.entries(obj)) {
    fields[k] = encodeValue(v);
  }
  return fields;
}

/** PATCH `documents/<path>` with merge semantics (specified fields only). */
export async function setDoc(
  docPath: string,
  data: Record<string, unknown>
): Promise<void> {
  const token = await getAccessToken();
  const project = getProjectId();
  const fields = Object.keys(data);
  const mask = fields.map((f) => `updateMask.fieldPaths=${encodeURIComponent(f)}`).join("&");
  const url =
    `${FIRESTORE_BASE}/projects/${project}/databases/(default)/documents/${docPath}` +
    `?${mask}`;
  const res = await fetch(url, {
    method: "PATCH",
    headers: {
      authorization: `Bearer ${token}`,
      "content-type": "application/json",
    },
    body: JSON.stringify({ fields: encodeFields(data) }),
    signal: AbortSignal.timeout(10_000),
  });
  if (!res.ok) {
    const text = await res.text();
    throw new Error(`firestore PATCH ${res.status}: ${text.slice(0, 400)}`);
  }
}

/** Idempotency lock — succeeds only if the event document does not yet exist. */
export async function reserveEvent(eventId: string): Promise<boolean> {
  const token = await getAccessToken();
  const project = getProjectId();
  const url =
    `${FIRESTORE_BASE}/projects/${project}/databases/(default)/documents/stripe_events` +
    `?documentId=${encodeURIComponent(eventId)}`;
  const res = await fetch(url, {
    method: "POST",
    headers: {
      authorization: `Bearer ${token}`,
      "content-type": "application/json",
    },
    body: JSON.stringify({ fields: encodeFields({ seenAt: new Date() }) }),
    signal: AbortSignal.timeout(10_000),
  });
  if (res.status === 409) return false; // already exists → duplicate webhook delivery
  if (!res.ok) {
    const text = await res.text();
    throw new Error(`firestore POST ${res.status}: ${text.slice(0, 400)}`);
  }
  return true;
}
