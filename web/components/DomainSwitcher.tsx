"use client";

// DomainSwitcher — calls a Server Action that writes the canonical
// `demiurge.active.domain` cookie, then navigates + refreshes so the layout
// (server component) re-reads cookies and TopBar/VerbTreeNav rerender with
// the new active domain. No localStorage, no client-state.
// The trailing "+" starts a new project via the 8th verb (discover).

import { useRouter } from "next/navigation";
import { useTransition } from "react";
import { setActiveDomain } from "@/app/actions/active-domain";

export function DomainSwitcher({
  names,
  current,
  ariaLabel = "domain",
  newProjectLabel = "new project (discover)",
}: {
  names: string[];
  current: string;
  ariaLabel?: string;
  newProjectLabel?: string;
}) {
  const router = useRouter();
  const [isPending, startTransition] = useTransition();

  function pick(name: string) {
    startTransition(async () => {
      await setActiveDomain(name);
      router.push(`/dashboard?d=${encodeURIComponent(name)}`);
      router.refresh();
    });
  }

  return (
    <div className="flex items-center gap-1.5">
      <select
        value={current}
        onChange={(e) => pick(e.target.value)}
        disabled={isPending}
        className="cursor-pointer rounded-[6px] border border-gray-200 bg-white px-2 py-1 font-mono text-sm text-gray-900 hover:border-gray-300 disabled:opacity-60"
        aria-label={ariaLabel}
      >
        {names.map((n) => (
          <option key={n} value={n}>
            {n}
          </option>
        ))}
      </select>
      <button
        onClick={() => router.push("/discover")}
        aria-label={newProjectLabel}
        title={newProjectLabel}
        className="flex h-7 w-7 cursor-pointer items-center justify-center rounded-[6px] border border-gray-200 text-gray-600 hover:border-gray-900 hover:text-gray-900"
      >
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
          <line x1="12" y1="5" x2="12" y2="19" />
          <line x1="5" y1="12" x2="19" y2="12" />
        </svg>
      </button>
    </div>
  );
}
