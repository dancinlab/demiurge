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

// Decode a Firestore Value back to a JS primitive. Only the value
// kinds we actually emit need to be handled.
function decodeValue(v: Record<string, unknown>): unknown {
  if ("stringValue" in v) return v.stringValue;
  if ("booleanValue" in v) return v.booleanValue;
  if ("integerValue" in v) return Number(v.integerValue);
  if ("doubleValue" in v) return v.doubleValue;
  if ("timestampValue" in v) return new Date(String(v.timestampValue));
  if ("nullValue" in v) return null;
  if ("mapValue" in v) {
    const f = (v.mapValue as { fields?: Record<string, Record<string, unknown>> }).fields ?? {};
    return Object.fromEntries(Object.entries(f).map(([k, vv]) => [k, decodeValue(vv)]));
  }
  if ("arrayValue" in v) {
    const arr = (v.arrayValue as { values?: Array<Record<string, unknown>> }).values ?? [];
    return arr.map(decodeValue);
  }
  return undefined;
}

function decodeFields(
  fields: Record<string, Record<string, unknown>> | undefined
): Record<string, unknown> {
  if (!fields) return {};
  const out: Record<string, unknown> = {};
  for (const [k, v] of Object.entries(fields)) out[k] = decodeValue(v);
  return out;
}

/** GET a single document. Returns null on 404. */
export async function getDoc(
  docPath: string
): Promise<Record<string, unknown> | null> {
  const token = await getAccessToken();
  const project = getProjectId();
  const url = `${FIRESTORE_BASE}/projects/${project}/databases/(default)/documents/${docPath}`;
  const res = await fetch(url, {
    headers: { authorization: `Bearer ${token}` },
    signal: AbortSignal.timeout(10_000),
  });
  if (res.status === 404) return null;
  if (!res.ok) {
    const text = await res.text();
    throw new Error(`firestore GET ${res.status}: ${text.slice(0, 400)}`);
  }
  const json = (await res.json()) as {
    fields?: Record<string, Record<string, unknown>>;
  };
  return decodeFields(json.fields);
}

/** List a subcollection — returns the documents (excluding the doc id
 *  itself; caller can map by index if order matters). */
export async function listSubcollection(
  parentPath: string,
  subcollection: string
): Promise<Array<Record<string, unknown>>> {
  const token = await getAccessToken();
  const project = getProjectId();
  const url =
    `${FIRESTORE_BASE}/projects/${project}/databases/(default)/documents/` +
    `${parentPath}/${subcollection}`;
  const res = await fetch(url, {
    headers: { authorization: `Bearer ${token}` },
    signal: AbortSignal.timeout(10_000),
  });
  if (res.status === 404) return [];
  if (!res.ok) {
    const text = await res.text();
    throw new Error(`firestore LIST ${res.status}: ${text.slice(0, 400)}`);
  }
  const json = (await res.json()) as {
    documents?: Array<{ fields?: Record<string, Record<string, unknown>> }>;
  };
  return (json.documents ?? []).map((d) => decodeFields(d.fields));
}

/** Returns the user's active subscription snapshot, or null. Picks the
 *  first one whose `status === "active"` to keep the surface simple. */
export async function getActiveSubscription(
  uid: string
): Promise<Record<string, unknown> | null> {
  try {
    const subs = await listSubcollection(`users/${uid}`, "subscriptions");
    return subs.find((s) => s.status === "active") ?? null;
  } catch {
    return null;
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
