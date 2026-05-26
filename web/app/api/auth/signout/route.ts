// POST /api/auth/signout — clears the session cookie. Idempotent.

import { clearSession } from "@/lib/session";

export async function POST() {
  await clearSession();
  return Response.json({ ok: true });
}
