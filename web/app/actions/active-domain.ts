// Server Action — single source of truth for the user's active domain.
// Replaces the previous localStorage mirror so the server (layout, verb-only
// landings) can read it directly via cookies() without a client round-trip.

"use server";

import { cookies } from "next/headers";

const COOKIE = "demiurge.active.domain";

export async function setActiveDomain(name: string): Promise<void> {
  const c = await cookies();
  c.set({
    name: COOKIE,
    value: name,
    httpOnly: false, // readable client-side too (not a secret)
    sameSite: "lax",
    path: "/",
    maxAge: 60 * 60 * 24 * 365, // 1 year
  });
}

export async function clearActiveDomain(): Promise<void> {
  const c = await cookies();
  c.delete(COOKIE);
}
