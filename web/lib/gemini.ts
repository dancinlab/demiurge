// Vertex AI Gemini REST client — zero npm deps (Node 22 built-in fetch).
//
// Auth strategy (Google-native):
//   1. Cloud Run / GCE / GKE → metadata server (zero secrets, ADC)
//      http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token
//   2. Local dev → env GOOGLE_ACCESS_TOKEN (populate via
//      `gcloud auth application-default print-access-token`)
//   3. Otherwise → error with instructions; no silent fallback to other LLMs.
//
// Why REST, not @google-cloud/vertexai SDK:
//   - 0 npm install (currently blocked by pool-route hook anyway)
//   - 0 node_modules weight on Cloud Run cold start
//   - Still 100% Google-native (Vertex AI REST is the canonical surface;
//     the SDK wraps these exact endpoints)
//   - Migration to SDK is a ~50 LOC swap, no architectural lock-in.
//
// XPRIZE rule: only Gemini may be called from the deployed app (no
// Claude / OpenAI / other-provider). This module enforces that by
// being the sole LLM client in the codebase.

const METADATA_TOKEN_URL =
  "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token";

const DEFAULT_LOCATION = process.env.VERTEX_LOCATION ?? "us-central1";
const DEFAULT_MODEL = process.env.VERTEX_MODEL ?? "gemini-2.5-flash";

let cachedToken: { token: string; expiresAt: number } | null = null;

async function fetchTokenFromMetadata(): Promise<string | null> {
  try {
    const res = await fetch(METADATA_TOKEN_URL, {
      headers: { "Metadata-Flavor": "Google" },
      // metadata server is local; 2s is generous
      signal: AbortSignal.timeout(2000),
    });
    if (!res.ok) return null;
    const body = (await res.json()) as {
      access_token: string;
      expires_in: number;
    };
    cachedToken = {
      token: body.access_token,
      // refresh 60s before expiry
      expiresAt: Date.now() + (body.expires_in - 60) * 1000,
    };
    return body.access_token;
  } catch {
    return null;
  }
}

// Local dev: mint a fresh ADC token via the gcloud CLI. Cached 50min so we
// don't shell out per request. Prod never hits this (NODE_ENV=production →
// metadata server path). Solves the "token expires after 1h → 401" dev pain:
// no more manual .env.local refresh / server restart.
async function fetchTokenFromGcloud(): Promise<string | null> {
  if (process.env.NODE_ENV === "production") return null;
  try {
    const { execFile } = await import("node:child_process");
    const { promisify } = await import("node:util");
    const run = promisify(execFile);
    // GCLOUD_BIN lets dev point at the absolute path — a nohup/GUI-launched
    // server often lacks /opt/homebrew/bin on PATH, so bare "gcloud" ENOENTs.
    const gcloudBin = process.env.GCLOUD_BIN ?? "gcloud";
    const { stdout } = await run(
      gcloudBin,
      ["auth", "application-default", "print-access-token"],
      { timeout: 8000 },
    );
    const token = stdout.trim();
    if (!token) return null;
    cachedToken = { token, expiresAt: Date.now() + 50 * 60 * 1000 };
    return token;
  } catch {
    return null;
  }
}

async function getAccessToken(): Promise<string> {
  if (cachedToken && cachedToken.expiresAt > Date.now()) {
    return cachedToken.token;
  }
  // Dev first: gcloud ADC is always fresh (an env token can go stale at 1h).
  const gcloudToken = await fetchTokenFromGcloud();
  if (gcloudToken) return gcloudToken;

  const envToken = process.env.GOOGLE_ACCESS_TOKEN;
  if (envToken) return envToken;

  const meta = await fetchTokenFromMetadata();
  if (meta) return meta;

  throw new Error(
    "Vertex AI auth unavailable. Set GOOGLE_ACCESS_TOKEN for local dev " +
      "(via `gcloud auth application-default print-access-token`), or " +
      "deploy to Cloud Run / GCE so the metadata server provides ADC."
  );
}

function getProjectId(): string {
  const p = process.env.GCP_PROJECT ?? process.env.GOOGLE_CLOUD_PROJECT;
  if (!p) {
    throw new Error(
      "Vertex AI project unset. Export GCP_PROJECT (e.g. dancinlab)."
    );
  }
  return p;
}

export type GeminiTextRequest = {
  prompt: string;
  model?: string;
  location?: string;
  temperature?: number;
  maxOutputTokens?: number;
};

export type GeminiTextResponse = {
  text: string;
  model: string;
  usage: {
    promptTokens: number;
    candidateTokens: number;
    totalTokens: number;
  };
};

export async function generateText(
  req: GeminiTextRequest
): Promise<GeminiTextResponse> {
  // Q11′ LLM provider registry gate — verify vertex_gemini is enabled
  // before spending a Vertex call. Cheap (single Firestore doc read,
  // cached one-doc) + non-fatal (defaults to active when reg unavailable).
  const { getRegistry } = await import("./providers");
  const reg = await getRegistry();
  const llm = reg.llm.vertex_gemini;
  if (llm && llm.enabled === false) {
    throw new Error("vertex_gemini disabled in providers/registry — toggle in /admin");
  }

  const project = getProjectId();
  const location = req.location ?? DEFAULT_LOCATION;
  const model = req.model ?? DEFAULT_MODEL;
  const token = await getAccessToken();

  const url =
    `https://${location}-aiplatform.googleapis.com/v1/projects/${project}` +
    `/locations/${location}/publishers/google/models/${model}:generateContent`;

  const body = {
    contents: [{ role: "user", parts: [{ text: req.prompt }] }],
    generationConfig: {
      temperature: req.temperature ?? 0.4,
      // Gemini 2.5 consumes thoughtsTokenCount inside the maxOutputTokens
      // budget. Empirically a 150-token cap left ~6 candidate tokens; we
      // need ~2x headroom for production prompts.
      maxOutputTokens: req.maxOutputTokens ?? 2048,
    },
  };

  const res = await fetch(url, {
    method: "POST",
    headers: {
      authorization: `Bearer ${token}`,
      "content-type": "application/json",
    },
    body: JSON.stringify(body),
    signal: AbortSignal.timeout(30_000),
  });

  if (!res.ok) {
    const errText = await res.text();
    throw new Error(`Vertex AI ${res.status}: ${errText.slice(0, 500)}`);
  }

  const data = (await res.json()) as {
    candidates: Array<{
      content: { parts: Array<{ text?: string }> };
    }>;
    usageMetadata: {
      promptTokenCount: number;
      candidatesTokenCount: number;
      totalTokenCount: number;
    };
  };

  const text =
    data.candidates?.[0]?.content?.parts
      ?.map((p) => p.text ?? "")
      .join("") ?? "";

  return {
    text,
    model,
    usage: {
      promptTokens: data.usageMetadata?.promptTokenCount ?? 0,
      candidateTokens: data.usageMetadata?.candidatesTokenCount ?? 0,
      totalTokens: data.usageMetadata?.totalTokenCount ?? 0,
    },
  };
}
