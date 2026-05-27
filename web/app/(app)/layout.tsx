// (app) — shadcn Modern 톤 (themes gallery 의 sample 그대로).
// bg #fafafa(zinc-50) · panel #ffffff · border #e5e7eb · text #0f172a slate-900
// muted #64748b · accent #0f172a(검정 slate, NOT 파랑) · accentSoft #f1f5f9
// radius 10px · shadow-sm · Inter font

import { ThemeProvider } from "@/components/ThemeProvider";
import { TopBar } from "@/components/TopBar";
import { VerbTreeNav } from "@/components/VerbTreeNav";
import { CookChefRail } from "@/components/CookChefRail";

export default function AppLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <ThemeProvider>
      <div className="flex h-screen flex-col bg-zinc-50 text-slate-900 antialiased [font-family:Inter,system-ui,sans-serif]">
        <TopBar />
        <div className="flex flex-1 gap-3 overflow-hidden p-3">
          <aside className="shrink-0 rounded-[10px] border border-slate-200 bg-white p-2 shadow-sm">
            <VerbTreeNav />
          </aside>
          <aside className="w-72 shrink-0">
            <CookChefRail domain="" />
          </aside>
          <main className="min-w-0 flex-1 overflow-auto rounded-[10px] border border-slate-200 bg-white p-6 shadow-sm">
            {children}
          </main>
        </div>
      </div>
    </ThemeProvider>
  );
}
