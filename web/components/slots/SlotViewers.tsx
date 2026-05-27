// SlotViewers — 6 verb-specific visual slots (Q12 mapping).
// structure (R3F) is in StructureViewer.tsx; handoff dossier is in HandoffDossier.tsx.
// This file collects spec/design/analyze/synth/verify/discover — all server-renderable.

import type { ReactNode } from "react";

// ── 📜 spec — form-style target card ─────────────────────────────────────────
export function SpecForm({ domain, target }: { domain: string; target?: Record<string, unknown> }) {
  const fields = target ?? { goal: `${domain} target`, eta: "TBD" };
  return (
    <div className="space-y-2 text-sm">
      <div className="flex items-center gap-2 text-xs uppercase text-slate-500">📜 spec form</div>
      <dl className="grid grid-cols-2 gap-1 rounded-[6px] border border-slate-200 p-3">
        {Object.entries(fields).map(([k, v]) => (
          <div key={k} className="contents">
            <dt className="text-slate-500">{k}</dt>
            <dd className="font-mono">{String(v)}</dd>
          </div>
        ))}
      </dl>
    </div>
  );
}

// ── 📐 design — block-diagram SVG ────────────────────────────────────────────
export function DesignSchematic({ nodes }: { nodes?: string[] }) {
  const items = nodes ?? ["spec", "compute", "verify", "ship"];
  return (
    <svg viewBox="0 0 400 100" className="h-32 w-full">
      {items.map((n, i) => {
        const x = 20 + i * 95;
        return (
          <g key={n}>
            <rect x={x} y={30} width={80} height={40} rx={4} className="fill-slate-100 stroke-slate-400" />
            <text x={x + 40} y={55} textAnchor="middle" className="fill-slate-900 text-[11px] font-mono">{n}</text>
            {i < items.length - 1 && <path d={`M ${x + 80} 50 L ${x + 95} 50`} className="stroke-slate-500" markerEnd="url(#arr)" />}
          </g>
        );
      })}
      <defs><marker id="arr" markerWidth={6} markerHeight={6} refX={5} refY={3} orient="auto"><path d="M0,0 L6,3 L0,6 Z" className="fill-slate-500" /></marker></defs>
    </svg>
  );
}

// ── 📊 analyze — bar chart (no chart lib · raw SVG) ──────────────────────────
export function AnalyzeChart({ series }: { series?: Array<{ label: string; value: number }> }) {
  const data = series ?? [{ label: "A", value: 0.4 }, { label: "B", value: 0.7 }, { label: "C", value: 0.55 }];
  const max = Math.max(...data.map((d) => d.value), 1);
  return (
    <svg viewBox="0 0 300 120" className="h-32 w-full">
      {data.map((d, i) => {
        const h = (d.value / max) * 80;
        const x = 20 + i * 70;
        return (
          <g key={d.label}>
            <rect x={x} y={100 - h} width={50} height={h} className="fill-green-400 stroke-green-700" />
            <text x={x + 25} y={115} textAnchor="middle" className="fill-slate-600 text-[10px]">{d.label}</text>
            <text x={x + 25} y={100 - h - 4} textAnchor="middle" className="fill-slate-900 text-[10px] font-mono">{d.value.toFixed(2)}</text>
          </g>
        );
      })}
    </svg>
  );
}

// ── 🧪 synth — vertical recipe ladder ────────────────────────────────────────
export function RecipeLadder({ steps }: { steps?: string[] }) {
  const items = steps ?? ["mix precursors", "anneal 200°C", "anti-solvent quench", "spin coat", "post-bake"];
  return (
    <ol className="space-y-1 text-sm">
      {items.map((s, i) => (
        <li key={i} className="flex items-center gap-2 rounded-[6px] border border-slate-200 bg-slate-50 px-2 py-1">
          <span className="rounded-[6px] bg-slate-900 px-1.5 py-0.5 text-xs font-mono text-white">{i + 1}</span>
          <span>{s}</span>
        </li>
      ))}
    </ol>
  );
}

// ── 🟢 verify — g5 tier color matrix ─────────────────────────────────────────
export function VerdictMatrix({ rows }: { rows?: Array<{ claim: string; tier: "🔵" | "🟢" | "🟡" | "🟠" | "🔴" | "⚪" }> }) {
  const data = rows ?? [
    { claim: "claim sample 1", tier: "🟢" as const },
    { claim: "claim sample 2", tier: "🟡" as const },
    { claim: "claim sample 3", tier: "🟠" as const },
  ];
  return (
    <table className="w-full text-sm">
      <tbody>
        {data.map((r, i) => (
          <tr key={i} className="border-b border-slate-200">
            <td className="py-1 pr-2 text-2xl">{r.tier}</td>
            <td className="py-1 font-mono text-xs">{r.claim}</td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}

// ── 🌳 discover — kick/gap branching tree ────────────────────────────────────
export function DiscoverTree({ root }: { root?: { label: string; children?: Array<{ label: string }> } }) {
  const data = root ?? {
    label: "seed",
    children: [{ label: "kick A" }, { label: "kick B" }, { label: "gap" }],
  };
  return (
    <pre className="text-xs font-mono leading-tight">
{`🌳 ${data.label}\n${(data.children ?? []).map((c, i, a) => `${i === a.length - 1 ? "└─" : "├─"} ${c.label}`).join("\n")}`}
    </pre>
  );
}

// ── Slot picker ──────────────────────────────────────────────────────────────
export function pickSlot(verb: string, domain: string): ReactNode {
  switch (verb) {
    case "spec": return <SpecForm domain={domain} />;
    case "design": return <DesignSchematic />;
    case "analyze": return <AnalyzeChart />;
    case "synth": return <RecipeLadder />;
    case "verify": return <VerdictMatrix />;
    case "discover": return <DiscoverTree />;
    default: return null;
  }
}
