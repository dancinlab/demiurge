"use client";

import { useState } from "react";

export function CheckoutButton({
  tier,
  label,
}: {
  tier: "solo" | "team" | "org";
  label: string;
}) {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function go() {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch("/api/stripe/checkout", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ tier }),
      });
      const data = (await res.json()) as { url?: string; error?: string };
      if (!res.ok || !data.url) {
        setError(data.error ?? `http ${res.status}`);
        setLoading(false);
        return;
      }
      window.location.href = data.url;
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
      setLoading(false);
    }
  }

  return (
    <div className="space-y-2">
      <button
        onClick={go}
        disabled={loading}
        className="w-full rounded bg-neutral-900 px-3 py-2 text-sm text-white disabled:opacity-40 dark:bg-neutral-100 dark:text-neutral-900"
      >
        {loading ? "..." : label}
      </button>
      {error && (
        <p className="text-xs text-red-700 dark:text-red-300">{error}</p>
      )}
    </div>
  );
}
