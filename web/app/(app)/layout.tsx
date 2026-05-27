// (app) — the AUTHENTICATED workbench surface.
// PR#34 layout 3-column unify · 가로배치 (8verb | LLM | MAIN):
//   row1 = TopBar 공통 (프로젝트 selector · 사용자 · /admin)
//   row2 col-1 = 🌳 VerbTreeNav  (persistent · SPA navigation 안 재마운트)
//        col-2 = 🧑‍🍳 CookChefRail (persistent · 상태 유지)
//        col-3 = children       (page.tsx 메인 영역 · 갱신되는 유일한 영역)

import { ThemeProvider } from "@/components/ThemeProvider";
import { TopBar } from "@/components/TopBar";
import { VerbTreeNav } from "@/components/VerbTreeNav";
import { CookChefRail } from "@/components/CookChefRail";

export default function AppLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <ThemeProvider>
      <div className="flex h-screen flex-col bg-white font-mono text-neutral-900 dark:bg-neutral-950 dark:text-neutral-100">
        <TopBar />
        <div className="flex flex-1 gap-3 overflow-hidden p-3">
          <aside className="w-48 shrink-0 rounded border border-neutral-300 bg-white p-2 dark:border-neutral-700 dark:bg-neutral-900">
            <VerbTreeNav />
          </aside>
          <aside className="w-72 shrink-0">
            <CookChefRail domain="" />
          </aside>
          <main className="min-w-0 flex-1 overflow-auto rounded border border-neutral-300 bg-white p-4 dark:border-neutral-700 dark:bg-neutral-900">
            {children}
          </main>
        </div>
      </div>
    </ThemeProvider>
  );
}
