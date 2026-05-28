// AdminToggles — client component · payment radio + GPU/LLM checkbox grid.
// Persists via POST /api/v1/providers. Optimistic UI; rollback on 4xx/5xx.

"use client";

import { useState } from "react";
import type { ProviderRegistry } from "@/lib/providers";

export type AdminTogglesI18n = {
  payment: string; // "💳 Payment (single-active)"
  gpu: string; // "🎮 GPU (multi · priority)"
  llm: string; // "🧠 LLM (multi · priority)"
};

export function AdminToggles({
  initial,
  i18n,
}: {
  initial: ProviderRegistry;
  i18n: AdminTogglesI18n;
}) {
  const [registry, setRegistry] = useState<ProviderRegistry>(initial);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function save(next: ProviderRegistry) {
    setBusy(true);
    setError(null);
    const before = registry;
    setRegistry(next);
    try {
      const res = await fetch("/api/v1/providers", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify(next),
      });
      if (!res.ok) {
        setRegistry(before);
        setError(`save failed (HTTP ${res.status})`);
      }
    } catch (e: unknown) {
      setRegistry(before);
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setBusy(false);
    }
  }

  function setPayment(active: "stripe" | "lemonsqueezy") {
    save({ ...registry, payment: { ...registry.payment, active } });
  }
  function toggleKind(kind: "gpu" | "llm", id: string) {
    const cur = registry[kind][id];
    save({
      ...registry,
      [kind]: { ...registry[kind], [id]: { ...cur, enabled: !cur.enabled } },
    });
  }

  return (
    <div className="mt-8 space-y-8 text-sm">
      <section>
        <h2 className="mb-2 font-bold">{i18n.payment}</h2>
        {registry.payment.available.map((p) => (
          <label key={p} className="mr-4 inline-flex items-center gap-2">
            <input
              type="radio"
              name="payment"
              checked={registry.payment.active === p}
              disabled={busy}
              onChange={() => setPayment(p as "stripe" | "lemonsqueezy")}
            />
            <span>{p}</span>
          </label>
        ))}
      </section>

      {(["gpu", "llm"] as const).map((kind) => (
        <section key={kind}>
          <h2 className="mb-2 font-bold">
            {kind === "gpu" ? i18n.gpu : i18n.llm}
          </h2>
          <ul>
            {Object.entries(registry[kind])
              .sort((a, b) => a[1].priority - b[1].priority)
              .map(([id, v]) => (
                <li key={id} className="flex items-center gap-3 py-1">
                  <input
                    type="checkbox"
                    checked={v.enabled}
                    disabled={busy}
                    onChange={() => toggleKind(kind, id)}
                  />
                  <span className="w-32">{id}</span>
                  <span className="text-xs text-muted-soft">p{v.priority}</span>
                </li>
              ))}
          </ul>
        </section>
      ))}

      {error && <p className="text-danger">{error}</p>}
    </div>
  );
}
