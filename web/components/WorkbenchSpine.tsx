"use client";

// Left 8-verb spine — collapsible. Top toggle button folds the rail to
// icons-only (w-14) or expands to icon+label (w-52). Collapse state
// persists to localStorage. discover (8th) sits at the top.

import { useEffect, useState } from "react";
import Link from "next/link";
import {
  Telescope, FileText, Network, PenTool, Activity, Combine, CheckCircle2, Send,
  PanelLeftClose, PanelLeftOpen, Repeat,
} from "lucide-react";

// `loop: true` marks the iterative segment (analyze ⟲ synthesize) per the
// 8-verb pipeline — shows a repeat glyph on the right when expanded.
const SPINE: Array<{ verb: string; domainScoped: boolean; Icon: typeof FileText; loop?: boolean }> = [
  { verb: "discover", domainScoped: false, Icon: Telescope },
  { verb: "spec", domainScoped: true, Icon: FileText },
  { verb: "structure", domainScoped: true, Icon: Network },
  { verb: "design", domainScoped: true, Icon: PenTool },
  { verb: "analyze", domainScoped: true, Icon: Activity, loop: true },
  { verb: "synth", domainScoped: true, Icon: Combine },
  { verb: "verify", domainScoped: true, Icon: CheckCircle2 },
  { verb: "handoff", domainScoped: true, Icon: Send },
];

export function WorkbenchSpine({
  activeName,
  spineLabel,
}: {
  activeName: string;
  spineLabel: string;
}) {
  const [collapsed, setCollapsed] = useState(false);

  useEffect(() => {
    setCollapsed(localStorage.getItem("demiurge-spine-collapsed") === "1");
  }, []);

  function toggle() {
    setCollapsed((c) => {
      const next = !c;
      localStorage.setItem("demiurge-spine-collapsed", next ? "1" : "0");
      return next;
    });
  }

  return (
    <nav
      className={
        "flex flex-col gap-2 overflow-y-auto border-r border-neutral-300 p-3 text-sm transition-[width] duration-200 dark:border-neutral-700 " +
        (collapsed ? "w-14" : "w-52")
      }
    >
      <button
        onClick={toggle}
        aria-label={collapsed ? "expand" : "collapse"}
        className="mb-1 flex h-8 cursor-pointer items-center justify-center rounded border border-neutral-300 text-neutral-500 hover:border-neutral-900 hover:text-neutral-900 dark:border-neutral-700 dark:hover:border-neutral-100 dark:hover:text-neutral-100"
      >
        {collapsed ? <PanelLeftOpen size={15} /> : <PanelLeftClose size={15} />}
      </button>

      {!collapsed && (
        <span className="px-1 text-[11px] uppercase tracking-wider text-neutral-500">
          {spineLabel}
        </span>
      )}

      {SPINE.map(({ verb, domainScoped, Icon, loop }) => {
        const href =
          domainScoped && activeName
            ? `/${verb}/${encodeURIComponent(activeName)}`
            : `/${verb}`;
        return (
          <Link
            key={verb}
            href={href}
            title={collapsed ? verb : undefined}
            className={
              "flex items-center gap-2.5 rounded border border-neutral-300 text-neutral-700 hover:border-neutral-900 hover:text-neutral-900 dark:border-neutral-700 dark:text-neutral-300 dark:hover:border-neutral-100 dark:hover:text-neutral-50 " +
              (collapsed ? "justify-center px-0 py-2.5" : "px-3 py-2.5")
            }
          >
            <Icon size={15} className="shrink-0 text-neutral-400" />
            {!collapsed && <span>{verb}</span>}
            {!collapsed && loop && (
              <Repeat size={13} className="ml-auto text-neutral-400" />
            )}
          </Link>
        );
      })}
    </nav>
  );
}
