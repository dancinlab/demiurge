"use client";

// Hamburger workbench menu (sample 1 Mono). Compact: each control is ONE
// row showing its current value; tapping LANGUAGE / COLOR MODE opens a
// centered modal to pick. HOME · SIGN OUT are direct rows.
// Theme is class-based (.dark on <html>), persisted to localStorage
// ('demiurge-theme'); the root ThemeScript applies it pre-paint.

import { useEffect, useRef, useState } from "react";

type Theme = "system" | "light" | "dark";
type Modal = null | "lang" | "theme";

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
  const [modal, setModal] = useState<Modal>(null);
  const [theme, setTheme] = useState<Theme>("system");
  const [busy, setBusy] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    setTheme((localStorage.getItem("demiurge-theme") as Theme) || "system");
  }, []);

  useEffect(() => {
    if (!open) return;
    const onDown = (e: MouseEvent) => {
      if (ref.current && !ref.current.contains(e.target as Node) && !modal)
        setOpen(false);
    };
    const onEsc = (e: KeyboardEvent) => {
      if (e.key !== "Escape") return;
      if (modal) setModal(null);
      else setOpen(false);
    };
    document.addEventListener("mousedown", onDown);
    document.addEventListener("keydown", onEsc);
    return () => {
      document.removeEventListener("mousedown", onDown);
      document.removeEventListener("keydown", onEsc);
    };
  }, [open, modal]);

  function pickTheme(t: Theme) {
    setTheme(t);
    localStorage.setItem("demiurge-theme", t);
    applyTheme(t);
    setModal(null);
  }

  async function pickLocale(code: string) {
    if (code === currentLocale) {
      setModal(null);
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
    "flex w-full items-center justify-between rounded border border-neutral-300 px-3 py-2 text-xs text-neutral-700 hover:border-neutral-900 hover:text-neutral-900 dark:border-neutral-700 dark:text-neutral-300 dark:hover:border-neutral-100 dark:hover:text-neutral-100";

  return (
    <div ref={ref}>
      <button
        onClick={() => setOpen((v) => !v)}
        aria-label="menu"
        aria-expanded={open}
        className="flex h-8 w-8 items-center justify-center rounded border border-neutral-300 text-neutral-700 hover:border-neutral-900 hover:text-neutral-900 dark:border-neutral-700 dark:text-neutral-300 dark:hover:border-neutral-100 dark:hover:text-neutral-100"
      >
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
          <line x1="3" y1="6" x2="21" y2="6" />
          <line x1="3" y1="12" x2="21" y2="12" />
          <line x1="3" y1="18" x2="21" y2="18" />
        </svg>
      </button>

      {open && (
        <div className="fixed right-4 top-14 z-50 flex w-56 flex-col gap-1.5 rounded border border-neutral-300 bg-white p-2 text-sm shadow-xl dark:border-neutral-700 dark:bg-neutral-900">
          {/* language — one row */}
          <button onClick={() => setModal("lang")} className={rowCls}>
            <span className="uppercase tracking-wider text-neutral-500">language</span>
            <span className="font-semibold">{localeLabel} ›</span>
          </button>
          {/* color mode — one row */}
          <button onClick={() => setModal("theme")} className={rowCls}>
            <span className="uppercase tracking-wider text-neutral-500">color</span>
            <span className="font-semibold">{themeLabel} ›</span>
          </button>
          {/* home */}
          <a href="/" className={rowCls}>
            <span className="uppercase tracking-wider text-neutral-500">home</span>
            <span>⌂</span>
          </a>
          {/* sign out */}
          <button onClick={signOut} disabled={busy} className={rowCls + " disabled:opacity-40"}>
            <span className="uppercase tracking-wider text-neutral-500">sign out</span>
            <span>⇥</span>
          </button>
        </div>
      )}

      {/* modal — language / color picker */}
      {modal && (
        <div
          className="fixed inset-0 z-[60] flex items-center justify-center bg-black/40 p-4"
          onClick={() => setModal(null)}
        >
          <div
            className="w-72 rounded border border-neutral-300 bg-white p-4 shadow-2xl dark:border-neutral-700 dark:bg-neutral-900"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="mb-3 flex items-center justify-between">
              <span className="text-[11px] uppercase tracking-[0.3em] text-neutral-500">
                {modal === "lang" ? "language" : "color mode"}
              </span>
              <button
                onClick={() => setModal(null)}
                aria-label="close"
                className="text-neutral-400 hover:text-neutral-900 dark:hover:text-neutral-100"
              >
                ✕
              </button>
            </div>

            {modal === "lang" && (
              <div className="flex flex-col gap-1">
                {LOCALES.map((l) => (
                  <button
                    key={l.code}
                    onClick={() => pickLocale(l.code)}
                    disabled={busy}
                    className={
                      "rounded border px-3 py-2 text-left text-sm " +
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

            {modal === "theme" && (
              <div className="grid grid-cols-3 gap-2">
                {THEMES.map((opt) => (
                  <button
                    key={opt.id}
                    onClick={() => pickTheme(opt.id)}
                    className={
                      "rounded border px-2 py-2 text-[11px] font-semibold " +
                      (theme === opt.id
                        ? "border-neutral-900 bg-neutral-900 text-white dark:border-neutral-100 dark:bg-neutral-100 dark:text-neutral-900"
                        : "border-neutral-300 text-neutral-600 hover:border-neutral-500 dark:border-neutral-700 dark:text-neutral-400")
                    }
                  >
                    {opt.label}
                  </button>
                ))}
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
}
