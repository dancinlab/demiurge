"use client";

// Dashboard domain switcher — navigates to /dashboard?d=<NAME>. Server
// re-renders the workbench for the chosen domain (no client store).

import { useRouter } from "next/navigation";

export function DomainSwitcher({
  names,
  current,
}: {
  names: string[];
  current: string;
}) {
  const router = useRouter();
  return (
    <select
      value={current}
      onChange={(e) =>
        router.push(`/dashboard?d=${encodeURIComponent(e.target.value)}`)
      }
      className="rounded border border-neutral-300 bg-white px-2 py-1 text-sm font-mono"
      aria-label="domain"
    >
      {names.map((n) => (
        <option key={n} value={n}>
          {n}
        </option>
      ))}
    </select>
  );
}
