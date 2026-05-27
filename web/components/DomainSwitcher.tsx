"use client";

// Dashboard domain switcher — navigates to /dashboard?d=<NAME>. Server
// re-renders the workbench for the chosen domain (no client store).
// The trailing "+" starts a new project via the 8th verb (discover) —
// the canonical seed surface for new work.

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
    <div className="flex items-center gap-1.5">
      <select
        value={current}
        onChange={(e) =>
          router.push(`/dashboard?d=${encodeURIComponent(e.target.value)}`)
        }
        className="cursor-pointer rounded border border-neutral-300 bg-white px-2 py-1 font-mono text-sm text-neutral-900 dark:border-neutral-700 dark:bg-neutral-900 dark:text-neutral-100"
        aria-label="domain"
      >
        {names.map((n) => (
          <option key={n} value={n}>
            {n}
          </option>
        ))}
      </select>
      <button
        onClick={() => router.push("/discover")}
        aria-label="new project"
        title="new project (discover)"
        className="flex h-7 w-7 cursor-pointer items-center justify-center rounded border border-neutral-300 text-neutral-600 hover:border-neutral-900 hover:text-neutral-900 dark:border-neutral-700 dark:text-neutral-400 dark:hover:border-neutral-100 dark:hover:text-neutral-100"
      >
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
          <line x1="12" y1="5" x2="12" y2="19" />
          <line x1="5" y1="12" x2="19" y2="12" />
        </svg>
      </button>
    </div>
  );
}
