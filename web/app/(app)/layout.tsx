// (app) — shadcn Modern 톤. Server Component: reads currentUser + active domain
// from cookies in one place, passes as props. No client fetch round-trip,
// no localStorage mirror — single source of truth.

import { cookies } from "next/headers";
import { ThemeProvider } from "@/components/ThemeProvider";
import { TopBar } from "@/components/TopBar";
import { VerbTreeNav } from "@/components/VerbTreeNav";
import { CookChefRail } from "@/components/CookChefRail";
import { currentUser } from "@/lib/session";

export default async function AppLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  const [user, c] = await Promise.all([currentUser(), cookies()]);
  const activeDomain = c.get("demiurge.active.domain")?.value ?? null;
  const safeUser = user
    ? { email: user.email ?? "", role: (user as { role?: string }).role }
    : null;

  return (
    <ThemeProvider>
      <div className="flex h-screen flex-col bg-zinc-50 text-slate-900 antialiased [font-family:var(--font-inter),system-ui,sans-serif]">
        <TopBar user={safeUser} activeDomain={activeDomain} />
        <div className="flex flex-1 gap-3 overflow-hidden p-3">
          <aside className="shrink-0 rounded-[10px] border border-slate-200 bg-white p-2 shadow-sm">
            <VerbTreeNav domain={activeDomain ?? undefined} />
          </aside>
          <aside className="w-72 shrink-0">
            <CookChefRail domain={activeDomain ?? ""} />
          </aside>
          <main className="min-w-0 flex-1 overflow-auto rounded-[10px] border border-slate-200 bg-white p-6 shadow-sm">
            {children}
          </main>
        </div>
      </div>
    </ThemeProvider>
  );
}
