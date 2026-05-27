// (app) — the AUTHENTICATED workbench surface. Mono / Terminal tone.
// PR#33 layout unify: TopBar 가 모든 (app) 페이지 공통 — discover ·
// dashboard · spec/* · matter · library · admin 동일한 상단 띠.
// VerbShell 내부 TopBar 는 중복 방지 위해 제거.

import { ThemeProvider } from "@/components/ThemeProvider";
import { TopBar } from "@/components/TopBar";

export default function AppLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <ThemeProvider>
      <div className="min-h-screen bg-white font-mono text-neutral-900 dark:bg-neutral-950 dark:text-neutral-100">
        <TopBar />
        {children}
      </div>
    </ThemeProvider>
  );
}
