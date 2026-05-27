// TopBar — Q3 상단 · 프로젝트 selector · 사용자 · /admin (role=admin 만).
// Server component — role checked via Firestore.

import Link from "next/link";
import { currentUser } from "@/lib/session";
import { getDoc } from "@/lib/firestore";

export async function TopBar({ projectId }: { projectId?: string }) {
  const u = await currentUser();
  let role = "guest";
  if (u) {
    role = "user";
    try {
      const doc = await getDoc(`users/${u.localId}`);
      if (doc && (doc as Record<string, unknown>).role === "admin") role = "admin";
    } catch {}
  }
  return (
    <header className="flex items-center gap-3 border-b border-neutral-300 bg-white px-4 py-2 text-sm dark:border-neutral-700 dark:bg-neutral-950">
      <Link href="/dashboard" className="font-bold">📐 demiurge</Link>
      {projectId && (
        <span className="rounded bg-neutral-100 px-2 py-0.5 text-xs dark:bg-neutral-800">
          📁 {projectId}
        </span>
      )}
      <span className="flex-1" />
      <Link href="/library" className="text-xs hover:underline">📖 library</Link>
      {role === "admin" && (
        <Link
          href="/admin"
          className="rounded border border-red-400 px-2 py-0.5 text-xs text-red-500"
        >
          ⚙️ /admin
        </Link>
      )}
      {u ? (
        <Link href="/account" className="text-xs">{u.email}</Link>
      ) : (
        <Link href="/signin" className="text-xs hover:underline">sign in</Link>
      )}
    </header>
  );
}
