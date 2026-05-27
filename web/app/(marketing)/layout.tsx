// (marketing) — the PUBLIC surface. Brutalist tone (black bg · yellow
// accent · heavy sans). Wraps every public page with SiteHeader/Footer.
// Isolated from the (app) workbench shell — no CSS cross-bleed.

import { SiteHeader } from "@/components/SiteHeader";
import { SiteFooter } from "@/components/SiteFooter";

export default function MarketingLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <div
      style={{ colorScheme: "dark" }}
      className="flex min-h-screen flex-col bg-black text-white"
    >
      <SiteHeader />
      <div className="flex-1">{children}</div>
      <SiteFooter />
    </div>
  );
}
