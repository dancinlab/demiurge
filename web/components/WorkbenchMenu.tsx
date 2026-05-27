"use client";

// Single hamburger-icon workbench menu (sample 1 Mono). Click → panel with
// LANGUAGE (5 locales) · COLOR MODE (system/light/dark) · HOME · SIGN OUT.
// Panel is position:fixed so opening it never disturbs the toolbar layout.
// Theme is class-based (.dark on <html>), persisted to localStorage
// ('demiurge-theme'); the root ThemeScript applies it pre-paint.

import { useEffect, useRef, useState } from "react";

type Theme = "system" | "light" | "dark";

const LOCALES: Array<{ code: string; label: string }> = [
  { code: "en", label: "English" },
  { code: "zh", label: "中文" },
  { code: "ru", label: "Русский" },
  { code: "ja", label: "日本語" },
  { code: "ko", label: "한국어" },
];

const THEMES: Array<{ id: Theme; label: string }> = [
  { id: "system", label: "SYSTEM" },
  { id: "light", label: "LIGHT" },
  { id: "dark", label: "DARK" },
];

function applyTheme(t: Theme) {
  const dark =
    t === "dark" ||
    (t === "system" &&
      window.matchMedia("(prefers-color-scheme: dark)").matches);
  const el = document.documentElement;
  el.classList.toggle("dark", dark);
  el.style.colorScheme = dark ? "dark" : "light";
}

export function WorkbenchMenu({ currentLocale }: { currentLocale: string }) {
  const [open, setOpen] = useState(false);
  const [theme, setTheme] = useState<Theme>("system");
  const [busy, setBusy] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    setTheme((localStorage.getItem("demiurge-theme") as Theme) || "system");
  }, []);

  useEffect(() => {
    if (!open) return;
    const onDown = (e: MouseEvent) => {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
    };
    const onEsc = (e: KeyboardEvent) => e.key === "Escape" && setOpen(false);
    document.addEventListener("mousedown", onDown);
    document.addEventListener("keydown", onEsc);
    return () => {
      document.removeEventListener("mousedown", onDown);
      document.removeEventListener("keydown", onEsc);
    };
  }, [open]);

  function pickTheme(t: Theme) {
    setTheme(t);
    localStorage.setItem("demiurge-theme", t);
    applyTheme(t);
  }

  async function pickLocale(code: string) {
    if (code === currentLocale || busy) return;
    setBusy(true);
    try {
      await fetch("/api/lang", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ locale: code }),
      });
      window.location.reload();
    } catch {
      setBusy(false);
    }
  }

  async function signOut() {
    setBusy(true);
    try {
      await fetch("/api/auth/signout", { method: "POST" });
    } finally {
      window.location.href = "/";
    }
  }

  return (
    <div ref={ref}>
      <button
        onClick={() => setOpen((v) => !v)}
        aria-label="menu"
        aria-expanded={open}
        className="flex h-8 w-8 items-center justify-center rounded border border-neutral-300 text-neutral-700 hover:border-neutral-900 hover:text-neutral-900 dark:border-neutral-700 dark:text-neutral-300 dark:hover:border-neutral-100 dark:hover:text-neutral-100"
      >
        {/* hamburger */}
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
          <line x1="3" y1="6" x2="21" y2="6" />
          <line x1="3" y1="12" x2="21" y2="12" />
          <line x1="3" y1="18" x2="21" y2="18" />
        </svg>
      </button>

      {open && (
        <div className="fixed right-4 top-14 z-50 w-60 rounded border border-neutral-300 bg-white p-3 text-sm shadow-xl dark:border-neutral-700 dark:bg-neutral-900">
          {/* language */}
          <div className="mb-1 text-[10px] uppercase tracking-[0.2em] text-neutral-500">
            language
          </div>
          <div className="mb-3 flex flex-col gap-0.5">
            {LOCALES.map((l) => (
              <button
                key={l.code}
                onClick={() => pickLocale(l.code)}
                disabled={busy}
                className={
                  "rounded px-2 py-1 text-left text-xs hover:bg-neutral-100 dark:hover:bg-neutral-800 " +
                  (l.code === currentLocale
                    ? "font-bold text-neutral-900 dark:text-neutral-100"
                    : "text-neutral-600 dark:text-neutral-400")
                }
              >
                {l.label}
              </button>
            ))}
          </div>

          {/* color mode */}
          <div className="mb-1 text-[10px] uppercase tracking-[0.2em] text-neutral-500">
            color mode
          </div>
          <div className="mb-3 grid grid-cols-3 gap-1">
            {THEMES.map((opt) => (
              <button
                key={opt.id}
                onClick={() => pickTheme(opt.id)}
                className={
                  "rounded border px-1.5 py-1 text-[10px] font-semibold " +
                  (theme === opt.id
                    ? "border-neutral-900 bg-neutral-900 text-white dark:border-neutral-100 dark:bg-neutral-100 dark:text-neutral-900"
                    : "border-neutral-300 text-neutral-600 hover:border-neutral-500 dark:border-neutral-700 dark:text-neutral-400")
                }
              >
                {opt.label}
              </button>
            ))}
          </div>

          {/* actions */}
          <div className="flex flex-col gap-1">
            <a
              href="/"
              className="flex items-center gap-2 rounded border border-neutral-300 px-2 py-1.5 text-xs text-neutral-700 hover:border-neutral-900 hover:text-neutral-900 dark:border-neutral-700 dark:text-neutral-300 dark:hover:border-neutral-100 dark:hover:text-neutral-100"
            >
              <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <path d="M3 11l9-8 9 8" />
                <path d="M5 10v10h14V10" />
              </svg>
              home
            </a>
            <button
              onClick={signOut}
              disabled={busy}
              className="flex items-center gap-2 rounded border border-neutral-300 px-2 py-1.5 text-left text-xs text-neutral-700 hover:border-neutral-900 hover:text-neutral-900 disabled:opacity-40 dark:border-neutral-700 dark:text-neutral-300 dark:hover:border-neutral-100 dark:hover:text-neutral-100"
            >
              <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
                <path d="M16 17l5-5-5-5" />
                <path d="M21 12H9" />
              </svg>
              sign out
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
