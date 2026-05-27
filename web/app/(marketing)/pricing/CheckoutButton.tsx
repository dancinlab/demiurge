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
        className="w-full border-4 border-white bg-white px-4 py-3 text-sm font-black uppercase text-black hover:bg-yellow-300 disabled:opacity-40"
      >
        {loading ? "..." : label}
      </button>
      {error && (
        <p className="border-l-4 border-yellow-300 pl-2 text-xs uppercase tracking-wide text-yellow-300">{error}</p>
      )}
    </div>
  );
}
