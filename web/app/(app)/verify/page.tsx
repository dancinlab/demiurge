// /verify — verb-only landing. If active domain (?d= or cookie) exists,
// redirect to its canonical /<verb>/<domain>; else go to /dashboard.

import { redirect } from "next/navigation";
import { cookies } from "next/headers";

export default async function VerbLanding({
  searchParams,
}: {
  searchParams: Promise<{ d?: string }>;
}) {
  const [{ d }, c] = await Promise.all([searchParams, cookies()]);
  const active = d ?? c.get("demiurge.active.domain")?.value ?? null;
  if (active) redirect(`/verify/${encodeURIComponent(active.toLowerCase())}`);
  redirect("/dashboard");
}
