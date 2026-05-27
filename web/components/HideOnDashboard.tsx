"use client";

// Tone-isolation gate. The site has TWO design languages by intent:
//   public surface  → Brutalist (검정·노랑·과대 산세리프) — global header+footer
//   /dashboard      → Mono (등폭·중립 그레이) — its own self-contained chrome
// This wrapper hides the global Brutalist chrome on /dashboard so the
// workbench renders as a single Mono surface (no double-stacking).

import { usePathname } from "next/navigation";

export function HideOnDashboard({ children }: { children: React.ReactNode }) {
  const p = usePathname() ?? "";
  if (p === "/dashboard" || p.startsWith("/dashboard/")) return null;
  return <>{children}</>;
}
