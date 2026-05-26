// POST /api/auth/signup { email, password } → creates user + sets session cookie.

import { signUp } from "@/lib/firebase-auth";
import { setSession } from "@/lib/session";

export async function POST(request: Request) {
  let body: { email?: unknown; password?: unknown };
  try {
    body = await request.json();
  } catch {
    return Response.json({ error: "invalid JSON body" }, { status: 400 });
  }

  const email = typeof body.email === "string" ? body.email.trim() : "";
  const password = typeof body.password === "string" ? body.password : "";
  if (!email || !password) {
    return Response.json(
      { error: "email + password required" },
      { status: 400 }
    );
  }
  if (password.length < 6) {
    return Response.json(
      { error: "password must be ≥6 chars" },
      { status: 400 }
    );
  }

  try {
    const session = await signUp({ email, password });
    await setSession(session);
    return Response.json({ ok: true, email: session.email, localId: session.localId });
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    const status = msg.includes("FIREBASE_WEB_API_KEY") ? 503 : 400;
    return Response.json({ error: msg }, { status });
  }
}
