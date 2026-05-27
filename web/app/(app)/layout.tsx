// (app) — the AUTHENTICATED workbench surface. Mono / Terminal tone
// (sample 1). Light by default; the workbench color-mode control can flip
// it to dark (class-based .dark on <html>, applied pre-paint by the root
// ThemeScript). Fully isolated from the (marketing) Brutalist shell.

export default function AppLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <div className="min-h-screen bg-white font-mono text-neutral-900 dark:bg-neutral-950 dark:text-neutral-100">
      {children}
    </div>
  );
}
