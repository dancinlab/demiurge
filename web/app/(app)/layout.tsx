// (app) — the AUTHENTICATED workbench surface. Mono / Terminal tone
// (sample 1). next-themes drives color mode (system/light/dark) via the
// `.dark` class on <html>, which our globals @custom-variant keys off.
// Fully isolated from the (marketing) Brutalist shell.

import { ThemeProvider } from "@/components/ThemeProvider";

export default function AppLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <ThemeProvider>
      <div className="min-h-screen bg-white font-mono text-neutral-900 dark:bg-neutral-950 dark:text-neutral-100">
        {children}
      </div>
    </ThemeProvider>
  );
}
