// /icons — DEV-ONLY 8-verb icon-set comparison (debug surface).
//
// This page is a designer scratchpad for picking the verb glyph set; it is NOT
// part of the product. It is never linked from any production nav, and the
// `notFound()` guard below makes the route itself 404 under a production build
// (NODE_ENV === "production"). Under `next dev` it stays reachable at /icons.
//
// Real SVG glyphs (no emoji). Semantic tokens only (DESIGN_TOKENS.md SSOT).

import { notFound } from "next/navigation";

export const dynamic = "force-dynamic";

type IconPath = { id: string; lucide: string; symbol: string };

const VERBS: IconPath[] = [
  { id: "spec",      lucide: "M14 3v4a1 1 0 0 0 1 1h4M5 8V5a2 2 0 0 1 2-2h7l5 5v11a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2v-3M9 12h6M9 16h4", symbol: "📄→◫" },
  { id: "structure", lucide: "M3 7l9-4 9 4-9 4-9-4zM3 12l9 4 9-4M3 17l9 4 9-4",                                                  symbol: "▣→⬢" },
  { id: "design",    lucide: "M12 19l7-7 3 3-7 7-3-3zM18 13l-1.5-7.5L2 2l3.5 14.5L13 18l5-5zM2 2l7.586 7.586",                  symbol: "✎→◐" },
  { id: "analyze",   lucide: "M3 3v18h18M7 16V9M12 16V5M17 16v-5",                                                              symbol: "▤→▦" },
  { id: "synth",     lucide: "M9 2v7.31M15 9.34V2M11 14h2M12 2v0M6.4 22h11.2a2 2 0 0 0 1.84-2.77L15 9V2H9v7L4.56 19.23A2 2 0 0 0 6.4 22z", symbol: "⚗→⚛" },
  { id: "verify",    lucide: "M9 12l2 2 4-4m6 2a9 9 0 1 1-18 0 9 9 0 0 1 18 0z",                                                symbol: "✓→●" },
  { id: "handoff",   lucide: "M16.5 9.4l-9-5.19M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z", symbol: "▱→◰" },
  { id: "discover",  lucide: "M21 21l-6-6m2-5a7 7 0 1 1-14 0 7 7 0 0 1 14 0z",                                                  symbol: "◯→◉" },
];

const SETS = [
  { id: "lucide-out",  name: "Lucide Outline",     stroke: "currentColor", fill: "none",          width: 1.6, accent: false },
  { id: "lucide-bold", name: "Lucide Bold",        stroke: "currentColor", fill: "none",          width: 2.4, accent: false },
  { id: "duotone",     name: "Duotone",            stroke: "currentColor", fill: "currentColor",  width: 1.6, accent: true },
  { id: "solid",       name: "Solid Fill",         stroke: "none",         fill: "currentColor",  width: 0,   accent: false },
  { id: "mono-thin",   name: "Mono Thin",          stroke: "currentColor", fill: "none",          width: 1.0, accent: false },
];

function Glyph({ d, set }: { d: string; set: (typeof SETS)[number] }) {
  return (
    <svg
      viewBox="0 0 24 24"
      width="22"
      height="22"
      fill={set.fill}
      fillOpacity={set.accent ? 0.13 : undefined}
      stroke={set.stroke}
      strokeWidth={set.width}
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <path d={d} />
    </svg>
  );
}

export default function IconsPage() {
  // Hard dev-only gate: production builds 404 this route entirely.
  if (process.env.NODE_ENV === "production") notFound();

  return (
    <main className="min-h-screen bg-canvas px-8 py-8 text-ink antialiased">
      <header className="mb-6">
        <h1 className="font-display text-2xl font-light tracking-tight text-ink">
          dev · 8-verb icon-set comparison
        </h1>
        <p className="mt-1 text-sm text-muted">
          Real SVG glyphs (no emoji). Dev-only scratchpad — pick a set, swap it
          into VerbTreeNav.
        </p>
      </header>

      <div className="overflow-x-auto rounded-card border border-hairline bg-surface shadow-card">
        <table className="w-full text-sm">
          <thead className="border-b border-hairline bg-surface-strong text-xs uppercase text-muted">
            <tr>
              <th className="px-3 py-3 text-left">verb</th>
              {SETS.map((s) => (
                <th key={s.id} className="px-3 py-3 text-center">
                  <div className="font-semibold text-ink">{s.name}</div>
                  <div className="mt-0.5 text-[10px] text-muted-soft">{s.id}</div>
                </th>
              ))}
              <th className="px-3 py-3 text-center">
                <div className="font-semibold text-ink">Symbol Glyph</div>
                <div className="mt-0.5 text-[10px] text-muted-soft">unicode only</div>
              </th>
            </tr>
          </thead>
          <tbody>
            {VERBS.map((v) => (
              <tr key={v.id} className="border-b border-hairline hover:bg-surface-strong">
                <td className="px-3 py-3 font-mono text-xs text-body">{v.id}</td>
                {SETS.map((s) => (
                  <td key={s.id} className="px-3 py-3 text-center">
                    <div
                      className={
                        "inline-flex h-9 w-9 items-center justify-center " +
                        (s.accent ? "text-success" : "text-ink")
                      }
                    >
                      <Glyph d={v.lucide} set={s} />
                    </div>
                  </td>
                ))}
                <td className="px-3 py-3 text-center font-mono text-xl text-ink">{v.symbol}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <section className="mt-8 grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3">
        {SETS.map((s) => (
          <article key={s.id} className="rounded-card border border-hairline bg-surface p-4 shadow-card">
            <header className="mb-3 flex items-baseline justify-between">
              <h3 className="text-sm font-semibold text-ink">{s.name}</h3>
              <code className="text-[10px] text-muted-soft">id={s.id}</code>
            </header>
            <ul className="grid grid-cols-2 gap-2 text-xs">
              {VERBS.map((v) => (
                <li key={v.id} className="flex items-center gap-2 rounded-control px-2 py-1 hover:bg-surface-strong">
                  <span
                    className={
                      "inline-flex h-5 w-5 items-center justify-center " +
                      (s.accent ? "text-success" : "text-body")
                    }
                  >
                    <Glyph d={v.lucide} set={s} />
                  </span>
                  <span className="font-mono text-body">{v.id}</span>
                </li>
              ))}
            </ul>
          </article>
        ))}
      </section>

      <p className="mt-8 text-xs text-muted-soft">
        Tell me a set id (e.g. lucide-out · duotone · solid) to apply it.
      </p>
    </main>
  );
}
