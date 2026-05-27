"use client";

// Breadcrumb "워크벤치" crumb — clicking it drops a project (domain) list.
// Selecting one navigates to /dashboard?d=<NAME>. Mono / Terminal tone.

import { useEffect, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import { ChevronDown } from "lucide-react";

export function ProjectsMenu({
  label,
  projects,
  current,
}: {
  label: string;
  projects: Array<{ name: string; goal?: string | null }>;
  current: string;
}) {
  const [open, setOpen] = useState(false);
  const router = useRouter();
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!open) return;
    const onDown = (e: MouseEvent) => {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
    };
    const onEsc = (e: KeyboardEvent) => e.key === "Escape" && setOpen(false);
    document.addEventListener("mousedown", onDown);
    document.addEventListener("keydown", onEsc);
    return () => {
      document.removeEventListener("mousedown", onDown);
      document.removeEventListener("keydown", onEsc);
    };
  }, [open]);

  return (
    <div ref={ref} className="relative">
      <button
        onClick={() => setOpen((v) => !v)}
        aria-expanded={open}
        className="flex cursor-pointer items-center gap-1 text-sm text-neutral-500 hover:text-neutral-900 dark:hover:text-neutral-100"
      >
        {label}
        <ChevronDown size={13} />
      </button>

      {open && (
        <div className="absolute left-0 top-7 z-50 max-h-80 w-72 overflow-y-auto rounded border border-neutral-300 bg-white p-1.5 shadow-xl dark:border-neutral-700 dark:bg-neutral-900">
          <div className="px-2 py-1 text-[10px] uppercase tracking-[0.3em] text-neutral-400">
            projects · {projects.length}
          </div>
          {projects.map((p) => (
            <button
              key={p.name}
              onClick={() => {
                router.push(`/dashboard?d=${encodeURIComponent(p.name)}`);
                setOpen(false);
              }}
              className={
                "flex w-full cursor-pointer flex-col gap-0.5 rounded px-2 py-2 text-left hover:bg-neutral-100 dark:hover:bg-neutral-800 " +
                (p.name === current ? "bg-neutral-100 dark:bg-neutral-800" : "")
              }
            >
              <span
                className={
                  "text-xs " +
                  (p.name === current
                    ? "font-bold text-neutral-900 dark:text-neutral-100"
                    : "text-neutral-700 dark:text-neutral-300")
                }
              >
                {p.name}
              </span>
              {p.goal && (
                <span className="line-clamp-1 text-[10px] text-neutral-400">{p.goal}</span>
              )}
            </button>
          ))}
        </div>
      )}
    </div>
  );
}
