// GET /api/auth/me — current user from session cookie (null when guest).

import { currentUser } from "@/lib/session";

export async function GET() {
  try {
    const u = await currentUser();
    return Response.json({ user: u });
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    const status = msg.includes("FIREBASE_WEB_API_KEY") ? 503 : 500;
    return Response.json({ error: msg }, { status });
  }
}
