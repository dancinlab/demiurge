// Firebase Identity Toolkit REST client — zero SDK, fetch-only.
//
// Endpoints:
//   signUp           POST identitytoolkit.googleapis.com/v1/accounts:signUp?key=
//   signIn(password) POST identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=
//   lookup(idToken)  POST identitytoolkit.googleapis.com/v1/accounts:lookup?key=
//   refreshToken     POST securetoken.googleapis.com/v1/token?key=
//
// Auth strategy:
//   - Firebase Web API key (FIREBASE_WEB_API_KEY) is *public by design*
//     — it gates only the project, never grants user access. Per Google
//     guidance, leaving it on the server side adds no security.
//   - Session is an httpOnly cookie holding { idToken, refreshToken, exp }.
//   - Every protected request runs `verifyIdToken()` which delegates the
//     JWT validation to Firebase (`accounts:lookup`). Switch to local
//     JWKS verify later if call latency becomes the bottleneck.

const IDENTITY_BASE = "https://identitytoolkit.googleapis.com/v1";
const SECURETOKEN_BASE = "https://securetoken.googleapis.com/v1";

function getApiKey(): string {
  const k =
    process.env.FIREBASE_WEB_API_KEY ?? process.env.NEXT_PUBLIC_FIREBASE_WEB_API_KEY;
  if (!k) {
    throw new Error(
      "FIREBASE_WEB_API_KEY unset. Get the Web API key from " +
        "https://console.firebase.google.com/project/dancinlab/settings/general and " +
        "`secret set firebase.web_api_key <key>` then export it."
    );
  }
  return k;
}

export type AuthCredentials = {
  email: string;
  password: string;
};

export type AuthSession = {
  idToken: string;
  refreshToken: string;
  /** Unix epoch ms when idToken expires. */
  expiresAt: number;
  localId: string;
  email: string;
};

export type FirebaseUser = {
  localId: string;
  email: string;
  emailVerified: boolean;
  displayName?: string;
  photoUrl?: string;
};

async function postJson<T>(url: string, body: unknown): Promise<T> {
  const res = await fetch(url, {
    method: "POST",
    headers: { "content-type": "application/json" },
    body: JSON.stringify(body),
    signal: AbortSignal.timeout(15_000),
  });
  if (!res.ok) {
    const text = await res.text();
    // Firebase error format: { error: { code, message: "EMAIL_EXISTS", errors: [...] } }
    let pretty = text.slice(0, 500);
    try {
      const j = JSON.parse(text) as { error?: { message?: string } };
      if (j.error?.message) pretty = j.error.message;
    } catch {
      /* leave raw */
    }
    throw new Error(`firebase ${res.status}: ${pretty}`);
  }
  return (await res.json()) as T;
}

function sessionFromAuthResp(resp: {
  idToken: string;
  refreshToken: string;
  expiresIn: string;
  localId: string;
  email: string;
}): AuthSession {
  return {
    idToken: resp.idToken,
    refreshToken: resp.refreshToken,
    expiresAt: Date.now() + Number(resp.expiresIn) * 1000,
    localId: resp.localId,
    email: resp.email,
  };
}

export async function signUp(c: AuthCredentials): Promise<AuthSession> {
  const url = `${IDENTITY_BASE}/accounts:signUp?key=${getApiKey()}`;
  const resp = await postJson<{
    idToken: string;
    refreshToken: string;
    expiresIn: string;
    localId: string;
    email: string;
  }>(url, { email: c.email, password: c.password, returnSecureToken: true });
  return sessionFromAuthResp(resp);
}

export async function signIn(c: AuthCredentials): Promise<AuthSession> {
  const url = `${IDENTITY_BASE}/accounts:signInWithPassword?key=${getApiKey()}`;
  const resp = await postJson<{
    idToken: string;
    refreshToken: string;
    expiresIn: string;
    localId: string;
    email: string;
  }>(url, { email: c.email, password: c.password, returnSecureToken: true });
  return sessionFromAuthResp(resp);
}

export async function verifyIdToken(idToken: string): Promise<FirebaseUser> {
  const url = `${IDENTITY_BASE}/accounts:lookup?key=${getApiKey()}`;
  const resp = await postJson<{
    users: Array<{
      localId: string;
      email: string;
      emailVerified?: boolean;
      displayName?: string;
      photoUrl?: string;
    }>;
  }>(url, { idToken });
  const user = resp.users?.[0];
  if (!user) throw new Error("token did not resolve to a user");
  return {
    localId: user.localId,
    email: user.email,
    emailVerified: user.emailVerified ?? false,
    displayName: user.displayName,
    photoUrl: user.photoUrl,
  };
}

export async function refreshSession(
  refreshToken: string
): Promise<AuthSession> {
  const url = `${SECURETOKEN_BASE}/token?key=${getApiKey()}`;
  const resp = await postJson<{
    id_token: string;
    refresh_token: string;
    expires_in: string;
    user_id: string;
  }>(url, {
    grant_type: "refresh_token",
    refresh_token: refreshToken,
  });
  return {
    idToken: resp.id_token,
    refreshToken: resp.refresh_token,
    expiresAt: Date.now() + Number(resp.expires_in) * 1000,
    localId: resp.user_id,
    // email is not on the refresh response; caller can re-fetch via verifyIdToken.
    email: "",
  };
}
