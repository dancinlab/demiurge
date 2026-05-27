// Session cookie helpers — opaque httpOnly cookie wrapping the
// Firebase auth session. Token never reaches JS on the client.
//
// Cookie value = base64url(JSON({idToken, refreshToken, expiresAt,
// localId, email})). Production-grade would HMAC the payload; for now
// the cookie is httpOnly + secure so the trust model is "browser
// storage is private to this device."

import { cookies } from "next/headers";
import type { AuthSession, FirebaseUser } from "./firebase-auth";
import { refreshSession, verifyIdToken } from "./firebase-auth";

const COOKIE_NAME = "demiurge_session";
const DEFAULT_MAX_AGE = 60 * 60 * 24 * 14; // 14 days; refresh kicks in long before expiry

function b64urlEncode(s: string): string {
  return Buffer.from(s, "utf8")
    .toString("base64")
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=+$/, "");
}

function b64urlDecode(s: string): string {
  let p = s.replace(/-/g, "+").replace(/_/g, "/");
  while (p.length % 4 !== 0) p += "=";
  return Buffer.from(p, "base64").toString("utf8");
}

export async function setSession(session: AuthSession): Promise<void> {
  const jar = await cookies();
  jar.set({
    name: COOKIE_NAME,
    value: b64urlEncode(JSON.stringify(session)),
    httpOnly: true,
    sameSite: "lax",
    secure: process.env.NODE_ENV === "production",
    path: "/",
    maxAge: DEFAULT_MAX_AGE,
  });
}

export async function clearSession(): Promise<void> {
  const jar = await cookies();
  jar.delete(COOKIE_NAME);
}

export async function readSession(): Promise<AuthSession | null> {
  const jar = await cookies();
  const raw = jar.get(COOKIE_NAME)?.value;
  if (!raw) return null;
  try {
    return JSON.parse(b64urlDecode(raw)) as AuthSession;
  } catch {
    return null;
  }
}

/**
 * Returns the current Firebase user, refreshing the ID token if it's
 * within 60s of expiry. Returns null if no session, no API key, or
 * refresh/verify failed — and clears the stale cookie when verify
 * fails so a single round-trip is enough to drop the session.
 */
export async function currentUser(): Promise<FirebaseUser | null> {
  let session = await readSession();
  if (!session) return null;
  // FIREBASE_WEB_API_KEY missing → treat as guest, but keep the cookie
  // so a redeploy with the key recovers without re-login.
  if (!process.env.FIREBASE_WEB_API_KEY && !process.env.NEXT_PUBLIC_FIREBASE_WEB_API_KEY) {
    return null;
  }
  if (Date.now() > session.expiresAt - 60_000) {
    try {
      const fresh = await refreshSession(session.refreshToken);
      session = { ...fresh, email: session.email };
      // Best-effort persist. cookies() is read-only during a Server
      // Component render in this Next.js version — a write there throws
      // "Cookies can only be modified in a Server Action or Route
      // Handler" and 500s the page. Swallow it: the refreshed token is
      // valid in-memory for this request and re-persists on the next
      // mutable context (sign-in / route handler).
      await persistBestEffort(session);
    } catch {
      await clearBestEffort();
      return null;
    }
  }
  try {
    return await verifyIdToken(session.idToken);
  } catch {
    await clearBestEffort();
    return null;
  }
}

async function persistBestEffort(session: AuthSession): Promise<void> {
  try {
    await setSession(session);
  } catch {
    /* render-context cookie write not allowed — ignore */
  }
}

async function clearBestEffort(): Promise<void> {
  try {
    await clearSession();
  } catch {
    /* render-context cookie delete not allowed — ignore */
  }
}
