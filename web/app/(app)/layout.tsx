// (app) — the AUTHENTICATED workbench surface. Mono / Terminal tone
// (sample 1): white bg · neutral ink · monospace · no brutalist chrome.
// color-scheme:light forces white regardless of OS dark-mode preference.
// Fully isolated from the (marketing) Brutalist shell.

export default function AppLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <div
      style={{ colorScheme: "light" }}
      className="min-h-screen bg-white font-mono text-neutral-900"
    >
      {children}
    </div>
  );
}
