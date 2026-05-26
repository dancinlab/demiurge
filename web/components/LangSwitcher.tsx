"use client";

// Tiny language dropdown — POSTs to /api/lang then reloads the page so
// the server-rendered messages refresh. No client-side reactive store.

import { useState } from "react";

// Display order: EN · 中文 · Русский · 日本語 · 한국어
const OPTIONS: Array<{ code: "en" | "zh" | "ru" | "ja" | "ko"; label: string }> = [
  { code: "en", label: "English" },
  { code: "zh", label: "中文" },
  { code: "ru", label: "Русский" },
  { code: "ja", label: "日本語" },
  { code: "ko", label: "한국어" },
];

export function LangSwitcher({ current }: { current: string }) {
  const [busy, setBusy] = useState(false);

  async function pick(code: string) {
    if (code === current) return;
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

  return (
    <select
      value={current}
      disabled={busy}
      onChange={(e) => pick(e.target.value)}
      className="rounded border border-neutral-300 bg-white px-2 py-1 text-xs dark:border-neutral-700 dark:bg-neutral-950"
      aria-label="Language"
    >
      {OPTIONS.map((o) => (
        <option key={o.code} value={o.code}>
          {o.label}
        </option>
      ))}
    </select>
  );
}
