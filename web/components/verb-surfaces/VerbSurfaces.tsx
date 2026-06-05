// VerbSurfaces — the 8 verb 3D-first OUTPUT surfaces (8VERB §6).
//
// §6 reframes each verb as an OPERATION ON A FOCUSED domain-node, rendering a
// 3D-first OUTPUT surface (no input box — the left chat is the input). Every
// model-centric surface reuses the P2 DomainModel3D (real R3F, SSR-safe via its
// own next/dynamic ssr:false). These stay LIGHT — a consistent node surface +
// the §6 per-verb chrome, not full physics. Where data is absent the surface is
// stylized (D3) and clearly marked as such.
//
// d4: ONE generic dispatch — pickVerbSurface(verb, data) maps the canonical verb
// to its surface; the carried node data is a plain serializable bag, no per-
// domain branching.
//
// P6: all copy via the SurfaceI18n bag (NO literal strings); the model surface
// passes the D3 honesty / error labels down to DomainModel3D.

"use client";

import { useMemo, useState } from "react";
import { DomainModel3D } from "@/components/DomainModel3D";
import { STATE_BADGE, type Rung, type VerifyState } from "@/lib/cosmos";
import type { SurfaceI18n } from "@/lib/cosmos-i18n";
import { fmt } from "@/lib/cosmos-i18n";

// The serializable carried-node bag handed from the server page to a surface.
export type SurfaceNode = {
  name: string;
  icon?: string;
  alias?: string;
  rung?: Rung;
  goal?: string | null;
  state: VerifyState;
  /** rolled-up state of the node's subtree (system badge), if decomposed. */
  rollup?: VerifyState;
  /** the immediate composition children (providers reused), for part panels. */
  parts?: Array<{ name: string; icon?: string; state: VerifyState }>;
};

// ── shared 3D stage wrapper (the model-centric spine) ────────────────────────
function ModelStage({
  node,
  i18n,
  poweredOn = false,
  caption,
}: {
  node: SurfaceNode;
  i18n: SurfaceI18n;
  poweredOn?: boolean;
  caption?: string;
}) {
  return (
    <div className="relative h-72 w-full overflow-hidden rounded-control border border-hairline-soft bg-[#16130f]">
      <DomainModel3D
        domain={node.name}
        rung={node.rung}
        goal={node.goal}
        // synth "powers on" the model: a verified tint reads as energized.
        state={poweredOn ? "verified" : node.state}
        noDataLabel={i18n.modelNoData}
        errorLabel={i18n.modelError}
      />
      {caption && (
        <span className="pointer-events-none absolute bottom-2 left-2 rounded bg-black/55 px-2 py-0.5 text-[10px] text-stone-200">
          {caption}
        </span>
      )}
    </div>
  );
}

function Parts({ node, i18n }: { node: SurfaceNode; i18n: SurfaceI18n }) {
  const parts = node.parts ?? [];
  if (parts.length === 0) {
    return <p className="text-[11px] text-muted-soft">{i18n.noParts}</p>;
  }
  return (
    <ul className="space-y-1">
      {parts.map((p) => (
        <li
          key={p.name}
          className="flex items-center gap-2 rounded-control bg-surface-strong px-2 py-1 text-xs"
        >
          <span aria-hidden>{p.icon ?? "⬡"}</span>
          <span className="font-mono text-body-strong">{p.name}</span>
          <span className="ml-auto" title={i18n.state[p.state]}>
            {STATE_BADGE[p.state]}
          </span>
        </li>
      ))}
    </ul>
  );
}

// ── discover — 3D candidate gallery (orbiting node-glyphs) ────────────────────
// Candidates = the node's composition children (the providers it would reuse) +
// the node itself; each rendered as a clickable 3D node-card. Click → focus that
// card's model into the main stage (in-place; no nav). Reuses the overview glyph
// idea but as the P2 faithful model per card.
export function DiscoverSurface({ node, i18n }: { node: SurfaceNode; i18n: SurfaceI18n }) {
  const cards: SurfaceNode[] = useMemo(() => {
    const kids = (node.parts ?? []).map((p) => ({
      name: p.name,
      icon: p.icon,
      state: p.state,
    }));
    return [{ name: node.name, icon: node.icon, state: node.state }, ...kids];
  }, [node]);
  const [focus, setFocus] = useState(0);
  const focused = cards[focus] ?? cards[0];

  return (
    <div className="space-y-3">
      <p className="text-[11px] text-muted">{i18n.discoverHint}</p>
      <ModelStage
        node={{ ...node, name: focused.name, state: focused.state }}
        i18n={i18n}
        caption={`${focused.icon ?? "⬡"} ${focused.name}`}
      />
      <div className="flex flex-wrap gap-2">
        {cards.map((c, i) => (
          <button
            key={c.name}
            onClick={() => setFocus(i)}
            aria-pressed={i === focus}
            aria-label={`${c.name} — ${i18n.state[c.state]}`}
            className={
              "flex items-center gap-1.5 rounded-control border px-2.5 py-1.5 text-xs transition focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-primary " +
              (i === focus
                ? "border-primary bg-canvas-soft text-ink"
                : "border-hairline-soft text-muted hover:bg-surface-strong hover:text-body")
            }
          >
            <span aria-hidden>{c.icon ?? "⬡"}</span>
            <span className="font-mono">{c.name}</span>
            <span aria-hidden>{STATE_BADGE[c.state]}</span>
          </button>
        ))}
      </div>
    </div>
  );
}

// ── spec — 계약서 카드 (목표 + 합격선) pinned beside the node model ───────────
export function SpecSurface({ node, i18n }: { node: SurfaceNode; i18n: SurfaceI18n }) {
  return (
    <div className="grid gap-3 md:grid-cols-[1fr_minmax(0,18rem)]">
      <ModelStage node={node} i18n={i18n} caption={`${node.icon ?? "⬡"} ${node.name}`} />
      <div className="rounded-control border border-hairline-soft bg-canvas-soft p-3">
        <p className="text-[10px] font-semibold uppercase tracking-[0.18em] text-muted-soft">
          {i18n.specContract}
        </p>
        <dl className="mt-2 space-y-2 text-xs">
          <div>
            <dt className="text-muted">{i18n.specTarget}</dt>
            <dd className="mt-0.5 text-body-strong">
              {node.goal ?? fmt(i18n.specTargetDefault, { domain: node.name })}
            </dd>
          </div>
          <div>
            <dt className="text-muted">{i18n.specGate}</dt>
            <dd className="mt-0.5 text-body-strong">{i18n.specGateValue}</dd>
          </div>
          <div className="flex items-center gap-1.5">
            <dt className="text-muted">{i18n.specCurrent}</dt>
            <dd className="font-mono text-body-strong">
              {STATE_BADGE[node.state]} {i18n.state[node.state]}
            </dd>
          </div>
        </dl>
      </div>
    </div>
  );
}

// ── structure — the node's 3D model assembly (parts visible in 3D) ───────────
export function StructureSurface({ node, i18n }: { node: SurfaceNode; i18n: SurfaceI18n }) {
  return (
    <div className="grid gap-3 md:grid-cols-[1fr_minmax(0,16rem)]">
      <ModelStage node={node} i18n={i18n} caption={i18n.structureCaption} />
      <div className="rounded-control border border-hairline-soft bg-canvas-soft p-3">
        <p className="text-[10px] font-semibold uppercase tracking-[0.18em] text-muted-soft">
          {i18n.structureParts}
        </p>
        <div className="mt-2">
          <Parts node={node} i18n={i18n} />
        </div>
      </div>
    </div>
  );
}

// ── design — DomainModel3D + property/inspector panel (click a part) ──────────
export function DesignSurface({ node, i18n }: { node: SurfaceNode; i18n: SurfaceI18n }) {
  const parts = node.parts ?? [];
  const [sel, setSel] = useState<string | null>(parts[0]?.name ?? null);
  const selected = parts.find((p) => p.name === sel) ?? null;

  return (
    <div className="grid gap-3 md:grid-cols-[1fr_minmax(0,18rem)]">
      <ModelStage node={node} i18n={i18n} caption={i18n.designCaption} />
      <div className="rounded-control border border-hairline-soft bg-canvas-soft p-3">
        <p className="text-[10px] font-semibold uppercase tracking-[0.18em] text-muted-soft">
          {i18n.designInspector}
        </p>
        {parts.length === 0 ? (
          <p className="mt-2 text-[11px] text-muted-soft">{i18n.designLeaf}</p>
        ) : (
          <>
            <div className="mt-2 flex flex-wrap gap-1.5">
              {parts.map((p) => (
                <button
                  key={p.name}
                  onClick={() => setSel(p.name)}
                  aria-pressed={sel === p.name}
                  className={
                    "rounded-chip px-2 py-0.5 text-[11px] font-mono transition focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-primary " +
                    (sel === p.name
                      ? "bg-inverted text-on-inverted"
                      : "bg-surface-strong text-muted hover:text-body")
                  }
                >
                  {p.name}
                </button>
              ))}
            </div>
            {selected && (
              <dl className="mt-3 space-y-1.5 text-xs">
                <div className="flex justify-between">
                  <dt className="text-muted">{i18n.designPart}</dt>
                  <dd className="font-mono text-body-strong">{selected.name}</dd>
                </div>
                <div className="flex justify-between">
                  <dt className="text-muted">{i18n.designVerify}</dt>
                  <dd>
                    {STATE_BADGE[selected.state]} {i18n.state[selected.state]}
                  </dd>
                </div>
                <div className="flex justify-between">
                  <dt className="text-muted">{i18n.designValues}</dt>
                  <dd className="text-muted-soft">
                    {selected.state === "unverified"
                      ? i18n.designUndefined
                      : i18n.designDefined}
                  </dd>
                </div>
              </dl>
            )}
          </>
        )}
      </div>
    </div>
  );
}

// ── analyze⟲ — problem parts glow red/amber on the model + [고치기] re-scan ───
export function AnalyzeSurface({ node, i18n }: { node: SurfaceNode; i18n: SurfaceI18n }) {
  const [scan, setScan] = useState(0); // bump = re-scan (remounts the stage)
  const problems = (node.parts ?? []).filter(
    (p) =>
      p.state === "falsified" ||
      p.state === "needs-verify" ||
      p.state === "unverified",
  );
  // the node itself is a problem if it is not yet verified.
  const selfProblem =
    node.state !== "verified" && node.state !== "verified-formal";

  return (
    <div className="space-y-3">
      <div className="flex items-center justify-between gap-2">
        <p className="text-[11px] text-muted">{i18n.analyzeHint}</p>
        <button
          onClick={() => setScan((s) => s + 1)}
          className="rounded-control border border-hairline-soft px-2.5 py-1 text-xs text-body hover:bg-surface-strong focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-primary"
          title={i18n.analyzeRescan}
        >
          {i18n.analyzeFix}
        </button>
      </div>
      <ModelStage
        key={scan}
        node={{
          ...node,
          // a falsified part forces the model tint red; else keep node state.
          state: problems.some((p) => p.state === "falsified")
            ? "falsified"
            : selfProblem
              ? "needs-verify"
              : node.state,
        }}
        i18n={i18n}
        caption={
          problems.length || selfProblem
            ? `⚠ ${fmt(i18n.analyzeProblems, { n: problems.length + (selfProblem ? 1 : 0) })}`
            : i18n.analyzeOk
        }
      />
      {problems.length > 0 ? (
        <ul className="space-y-1">
          {problems.map((p) => (
            <li
              key={p.name}
              className={
                "flex items-center gap-2 rounded-control px-2 py-1 text-xs " +
                (p.state === "falsified"
                  ? "bg-danger/10 text-danger"
                  : "bg-surface-strong text-body")
              }
            >
              <span aria-hidden>{p.state === "falsified" ? "🔴" : "🟡"}</span>
              <span className="font-mono">{p.name}</span>
              <span className="ml-auto text-muted-soft">{i18n.state[p.state]}</span>
            </li>
          ))}
        </ul>
      ) : (
        <p className="text-[11px] text-success">
          {selfProblem ? i18n.analyzeSelf : i18n.analyzeAllOk}
        </p>
      )}
    </div>
  );
}

// ── synth — DomainModel3D "powered on" (animate) + progress strip ────────────
export function SynthSurface({ node, i18n }: { node: SurfaceNode; i18n: SurfaceI18n }) {
  const [running, setRunning] = useState(false);
  return (
    <div className="space-y-3">
      <div className="flex items-center justify-between gap-2">
        <p className="text-[11px] text-muted">{i18n.synthHint}</p>
        <button
          onClick={() => setRunning((r) => !r)}
          aria-pressed={running}
          className={
            "rounded-control px-2.5 py-1 text-xs font-medium transition focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-primary " +
            (running
              ? "bg-primary text-on-primary hover:bg-primary-active"
              : "border border-hairline-soft text-body hover:bg-surface-strong")
          }
        >
          {running ? i18n.synthRunning : i18n.synthRun}
        </button>
      </div>
      <ModelStage
        node={node}
        i18n={i18n}
        poweredOn={running}
        caption={running ? i18n.synthOn : i18n.synthOff}
      />
      <div className="h-1.5 overflow-hidden rounded-full bg-surface-strong">
        <div
          className="h-full rounded-full bg-primary transition-all duration-700"
          style={{ width: running ? "100%" : "8%" }}
        />
      </div>
    </div>
  );
}

// ── verify — 대조 저울 (our value vs reference) + result badge stamp ──────────
export function VerifySurface({ node, i18n }: { node: SurfaceNode; i18n: SurfaceI18n }) {
  const passed = node.state === "verified" || node.state === "verified-formal";
  return (
    <div className="grid gap-3 md:grid-cols-[1fr_minmax(0,18rem)]">
      <div className="relative">
        <ModelStage node={node} i18n={i18n} caption={i18n.verifyCaption} />
        {/* stamped result badge over the model */}
        <span
          className="pointer-events-none absolute right-3 top-3 rounded-full bg-black/65 px-2 py-1 text-base"
          title={i18n.state[node.state]}
        >
          {STATE_BADGE[node.state]}
        </span>
      </div>
      <div className="rounded-control border border-hairline-soft bg-canvas-soft p-3">
        <p className="text-[10px] font-semibold uppercase tracking-[0.18em] text-muted-soft">
          {i18n.verifyScale}
        </p>
        <div className="mt-3 grid grid-cols-2 gap-2 text-center text-xs">
          <div className="rounded-control bg-surface-strong p-2">
            <p className="text-muted">{i18n.verifyOurs}</p>
            <p className="mt-1 font-mono text-body-strong">QFORGE</p>
          </div>
          <div className="rounded-control bg-surface-strong p-2">
            <p className="text-muted">{i18n.verifyRef}</p>
            <p className="mt-1 font-mono text-body-strong">QE</p>
          </div>
        </div>
        <p
          className={
            "mt-3 rounded-control px-2 py-1.5 text-center text-xs font-medium " +
            (passed
              ? "bg-success/10 text-success"
              : "bg-surface-strong text-muted")
          }
        >
          {STATE_BADGE[node.state]}{" "}
          {passed ? i18n.verifyPass : i18n.verifyWait}
        </p>
      </div>
    </div>
  );
}

// ── handoff — 인증서 (certificate + 검증완료 stamp + [⬇ 받기]) ────────────────
// The downloadable dossier itself is HandoffDossier (passed in as `dossier`);
// this surface frames it as a certificate card with the 3D node + stamp.
export function HandoffSurface({
  node,
  i18n,
  dossier,
}: {
  node: SurfaceNode;
  i18n: SurfaceI18n;
  dossier?: React.ReactNode;
}) {
  const sealed =
    node.state === "verified" || node.state === "verified-formal";
  return (
    <div className="space-y-3">
      <div className="relative overflow-hidden rounded-control border border-hairline-strong bg-canvas-soft p-4">
        <div className="flex items-center gap-3">
          <div className="h-24 w-24 shrink-0 overflow-hidden rounded-control border border-hairline-soft bg-[#16130f]">
            <DomainModel3D
              domain={node.name}
              rung={node.rung}
              goal={node.goal}
              state={node.state}
              noDataLabel={i18n.modelNoData}
              errorLabel={i18n.modelError}
            />
          </div>
          <div className="min-w-0">
            <p className="text-[10px] font-semibold uppercase tracking-[0.18em] text-muted-soft">
              {i18n.handoffCert}
            </p>
            <p className="mt-1 truncate text-lg font-semibold text-ink">
              {node.icon ?? "⬡"} {node.name}
            </p>
            {node.alias && (
              <p className="truncate text-xs text-muted-soft">— {node.alias}</p>
            )}
            <p className="mt-1 text-xs text-body">
              {STATE_BADGE[node.state]} {i18n.state[node.state]}
            </p>
          </div>
          {/* 검증완료 stamp */}
          <span
            className={
              "ml-auto rotate-[-12deg] rounded-control border-2 px-2.5 py-1 text-xs font-bold " +
              (sealed
                ? "border-success text-success"
                : "border-muted-soft text-muted-soft")
            }
          >
            {sealed ? i18n.handoffSealed : i18n.handoffPending}
          </span>
        </div>
      </div>
      {/* the real downloadable dossier ([⬇ 받기/PDF] lives inside) */}
      {dossier}
    </div>
  );
}

// ── d4 single dispatch — verb → surface ──────────────────────────────────────
// A CLIENT dispatcher component (not a server-called function), so a server page
// can mount it with plain serializable props (verb · node) + an optional dossier
// slot, without tripping the "use client" reference-proxy quirk.
export function VerbSurfaceClient({
  verb,
  node,
  i18n,
  dossier,
}: {
  verb: string;
  node: SurfaceNode;
  i18n: SurfaceI18n;
  dossier?: React.ReactNode;
}) {
  switch (verb) {
    case "discover":
      return <DiscoverSurface node={node} i18n={i18n} />;
    case "spec":
      return <SpecSurface node={node} i18n={i18n} />;
    case "structure":
      return <StructureSurface node={node} i18n={i18n} />;
    case "design":
      return <DesignSurface node={node} i18n={i18n} />;
    case "analyze":
      return <AnalyzeSurface node={node} i18n={i18n} />;
    case "synth":
      return <SynthSurface node={node} i18n={i18n} />;
    case "verify":
      return <VerifySurface node={node} i18n={i18n} />;
    case "handoff":
      return <HandoffSurface node={node} i18n={i18n} dossier={dossier} />;
    default:
      return null;
  }
}
