// GET /api/v1/me
//
// Returns the authenticated user's session (uid · email · role).
// Role is read from Firestore `users/{uid}.role` — defaults to "user".
// Used by client to gate /admin · fork action · subscription pages.

import { NextResponse } from "next/server";
import { currentUser } from "@/lib/session";
import { getDoc } from "@/lib/firestore";

export const runtime = "nodejs";

export async function GET() {
  const u = await currentUser();
  if (!u) {
    return NextResponse.json({ authenticated: false }, { status: 401 });
  }
  let role = "user";
  try {
    const doc = await getDoc(`users/${u.localId}`);
    if (doc && (doc as Record<string, unknown>).role === "admin") role = "admin";
  } catch {
    // Firestore unreachable -> default to "user"; do not 500.
  }
  return NextResponse.json({
    authenticated: true,
    uid: u.localId,
    email: u.email,
    role,
  });
}
