"use client";

// Hamburger workbench menu (sample 1 Mono). The dropdown panel IS the
// overlay; selecting LANGUAGE / COLOR slides a second pane IN from the
// right WITHIN the same fixed panel (overflow-hidden track, translate-x).
// No center modal, no full-screen drawer, no layout shift. Theme is
// class-based (.dark on <html>), persisted to localStorage; the root
// ThemeScript applies it pre-paint.

import { useEffect, useRef, useState } from "react";

type Theme = "system" | "light" | "dark";
type View = "root" | "lang" | "theme";

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
  const [view, setView] = useState<View>("root");
  const [theme, setTheme] = useState<Theme>("system");
  const [busy, setBusy] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    setTheme((localStorage.getItem("demiurge-theme") as Theme) || "system");
  }, []);

  useEffect(() => {
    if (!open) return;
    const onDown = (e: MouseEvent) => {
      if (ref.current && !ref.current.contains(e.target as Node)) {
        setOpen(false);
        setView("root");
      }
    };
    const onEsc = (e: KeyboardEvent) => {
      if (e.key !== "Escape") return;
      if (view !== "root") setView("root");
      else setOpen(false);
    };
    document.addEventListener("mousedown", onDown);
    document.addEventListener("keydown", onEsc);
    return () => {
      document.removeEventListener("mousedown", onDown);
      document.removeEventListener("keydown", onEsc);
    };
  }, [open, view]);

  function pickTheme(t: Theme) {
    setTheme(t);
    localStorage.setItem("demiurge-theme", t);
    applyTheme(t);
    setView("root");
  }

  async function pickLocale(code: string) {
    if (code === currentLocale) {
      setView("root");
      return;
    }
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

  const localeLabel =
    LOCALES.find((l) => l.code === currentLocale)?.label ?? currentLocale;
  const themeLabel = THEMES.find((t) => t.id === theme)?.label ?? "SYSTEM";

  const rowCls =
    "flex w-full cursor-pointer items-center justify-between rounded border border-neutral-300 px-3 py-2 text-xs text-neutral-700 hover:border-neutral-900 hover:text-neutral-900 dark:border-neutral-700 dark:text-neutral-300 dark:hover:border-neutral-100 dark:hover:text-neutral-100";
  const backCls =
    "mb-2 flex cursor-pointer items-center gap-1 text-[10px] uppercase tracking-[0.2em] text-neutral-500 hover:text-neutral-900 dark:hover:text-neutral-100";
  const pickCls = "cursor-pointer ";

  return (
    <div ref={ref}>
      <button
        onClick={() => setOpen((v) => !v)}
        aria-label="menu"
        aria-expanded={open}
        className="flex h-8 w-8 cursor-pointer items-center justify-center rounded border border-neutral-300 text-neutral-700 hover:border-neutral-900 hover:text-neutral-900 dark:border-neutral-700 dark:text-neutral-300 dark:hover:border-neutral-100 dark:hover:text-neutral-100"
      >
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
          <line x1="3" y1="6" x2="21" y2="6" />
          <line x1="3" y1="12" x2="21" y2="12" />
          <line x1="3" y1="18" x2="21" y2="18" />
        </svg>
      </button>

      {open && (
        <div className="fixed right-4 top-14 z-50 w-60 overflow-hidden rounded border border-neutral-300 bg-white text-sm shadow-xl dark:border-neutral-700 dark:bg-neutral-900">
          {/* 2-pane slide track — root | picker. Translate -50% to reveal picker. */}
          <div
            className="flex w-[200%] transition-transform duration-200 ease-out"
            style={{ transform: view === "root" ? "translateX(0)" : "translateX(-50%)" }}
          >
            {/* pane 0 — root */}
            <div className="flex w-1/2 flex-col gap-1.5 p-2">
              <button onClick={() => setView("lang")} className={rowCls}>
                <span className="uppercase tracking-wider text-neutral-500">language</span>
                <span className="font-semibold">{localeLabel} ›</span>
              </button>
              <button onClick={() => setView("theme")} className={rowCls}>
                <span className="uppercase tracking-wider text-neutral-500">color</span>
                <span className="font-semibold">{themeLabel} ›</span>
              </button>
              <a href="/" className={rowCls}>
                <span className="uppercase tracking-wider text-neutral-500">home</span>
                <span>⌂</span>
              </a>
              <button onClick={signOut} disabled={busy} className={rowCls + " disabled:opacity-40"}>
                <span className="uppercase tracking-wider text-neutral-500">sign out</span>
                <span>⇥</span>
              </button>
            </div>

            {/* pane 1 — picker (language OR theme) */}
            <div className="w-1/2 p-2">
              <button onClick={() => setView("root")} className={backCls}>
                ‹ back
              </button>
              {view === "theme" ? (
                <div className="grid grid-cols-3 gap-1">
                  {THEMES.map((opt) => (
                    <button
                      key={opt.id}
                      onClick={() => pickTheme(opt.id)}
                      className={
                        pickCls + "rounded border px-1.5 py-2 text-[10px] font-semibold " +
                        (theme === opt.id
                          ? "border-neutral-900 bg-neutral-900 text-white dark:border-neutral-100 dark:bg-neutral-100 dark:text-neutral-900"
                          : "border-neutral-300 text-neutral-600 hover:border-neutral-500 dark:border-neutral-700 dark:text-neutral-400")
                      }
                    >
                      {opt.label}
                    </button>
                  ))}
                </div>
              ) : (
                <div className="flex flex-col gap-1">
                  {LOCALES.map((l) => (
                    <button
                      key={l.code}
                      onClick={() => pickLocale(l.code)}
                      disabled={busy}
                      className={
                        pickCls + "rounded border px-3 py-1.5 text-left text-xs " +
                        (l.code === currentLocale
                          ? "border-neutral-900 font-bold text-neutral-900 dark:border-neutral-100 dark:text-neutral-100"
                          : "border-neutral-300 text-neutral-600 hover:border-neutral-500 dark:border-neutral-700 dark:text-neutral-400")
                      }
                    >
                      {l.label}
                    </button>
                  ))}
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
