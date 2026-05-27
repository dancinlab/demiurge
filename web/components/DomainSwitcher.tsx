"use client";

// Dashboard domain switcher — navigates to /dashboard?d=<NAME> AND mirrors the
// choice to localStorage so TopBar (and any other client) can render the
// active project name without a server round-trip.
// The trailing "+" starts a new project via the 8th verb (discover).

import { useRouter } from "next/navigation";

export function DomainSwitcher({
  names,
  current,
}: {
  names: string[];
  current: string;
}) {
  const router = useRouter();
  function pick(name: string) {
    if (typeof window !== "undefined") {
      localStorage.setItem("demiurge.active.domain", name);
    }
    router.push(`/dashboard?d=${encodeURIComponent(name)}`);
  }
  return (
    <div className="flex items-center gap-1.5">
      <select
        value={current}
        onChange={(e) => pick(e.target.value)}
        className="cursor-pointer rounded-[6px] border border-slate-200 bg-white px-2 py-1 font-mono text-sm text-slate-900 hover:border-slate-300"
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
        className="flex h-7 w-7 cursor-pointer items-center justify-center rounded-[6px] border border-slate-200 text-slate-600 hover:border-slate-900 hover:text-slate-900"
      >
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
          <line x1="12" y1="5" x2="12" y2="19" />
          <line x1="5" y1="12" x2="19" y2="12" />
        </svg>
      </button>
    </div>
  );
}
