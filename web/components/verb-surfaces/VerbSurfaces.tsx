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

"use client";

import { useMemo, useState } from "react";
import { DomainModel3D } from "@/components/DomainModel3D";
import { STATE_BADGE, type Rung, type VerifyState } from "@/lib/cosmos";

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
  poweredOn = false,
  caption,
}: {
  node: SurfaceNode;
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
      />
      {caption && (
        <span className="pointer-events-none absolute bottom-2 left-2 rounded bg-black/55 px-2 py-0.5 text-[10px] text-stone-200">
          {caption}
        </span>
      )}
    </div>
  );
}

function Parts({ node }: { node: SurfaceNode }) {
  const parts = node.parts ?? [];
  if (parts.length === 0) {
    return (
      <p className="text-[11px] text-muted-soft">
        하위 구성 도메인 없음 (말단 노드 — 더 쪼갤 수 없는 단위)
      </p>
    );
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
          <span className="ml-auto" title={p.state}>
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
export function DiscoverSurface({ node }: { node: SurfaceNode }) {
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
      <p className="text-[11px] text-muted">
        🛰 후보 도메인 — 클릭하면 가운데 무대에 띄웁니다 (좌측 채팅이 입력)
      </p>
      <ModelStage
        node={{ ...node, name: focused.name, state: focused.state }}
        caption={`${focused.icon ?? "⬡"} ${focused.name}`}
      />
      <div className="flex flex-wrap gap-2">
        {cards.map((c, i) => (
          <button
            key={c.name}
            onClick={() => setFocus(i)}
            className={
              "flex items-center gap-1.5 rounded-control border px-2.5 py-1.5 text-xs transition " +
              (i === focus
                ? "border-primary bg-canvas-soft text-ink"
                : "border-hairline-soft text-muted hover:bg-surface-strong hover:text-body")
            }
          >
            <span aria-hidden>{c.icon ?? "⬡"}</span>
            <span className="font-mono">{c.name}</span>
            <span>{STATE_BADGE[c.state]}</span>
          </button>
        ))}
      </div>
    </div>
  );
}

// ── spec — 계약서 카드 (목표 + 합격선) pinned beside the node model ───────────
export function SpecSurface({ node }: { node: SurfaceNode }) {
  return (
    <div className="grid gap-3 md:grid-cols-[1fr_minmax(0,18rem)]">
      <ModelStage node={node} caption={`${node.icon ?? "⬡"} ${node.name}`} />
      <div className="rounded-control border border-hairline-soft bg-canvas-soft p-3">
        <p className="text-[10px] font-semibold uppercase tracking-[0.18em] text-muted-soft">
          📜 계약서
        </p>
        <dl className="mt-2 space-y-2 text-xs">
          <div>
            <dt className="text-muted">목표 (target)</dt>
            <dd className="mt-0.5 text-body-strong">
              {node.goal ?? `${node.name} 검증 완료(in-silico)`}
            </dd>
          </div>
          <div>
            <dt className="text-muted">합격선 (gate)</dt>
            <dd className="mt-0.5 text-body-strong">
              비-wet-lab 게이트 전체 PASS → absorbed=true (d1·d5)
            </dd>
          </div>
          <div className="flex items-center gap-1.5">
            <dt className="text-muted">현재</dt>
            <dd className="font-mono text-body-strong">
              {STATE_BADGE[node.state]} {node.state}
            </dd>
          </div>
        </dl>
      </div>
    </div>
  );
}

// ── structure — the node's 3D model assembly (parts visible in 3D) ───────────
export function StructureSurface({ node }: { node: SurfaceNode }) {
  return (
    <div className="grid gap-3 md:grid-cols-[1fr_minmax(0,16rem)]">
      <ModelStage node={node} caption="3D assembly — 부품 조립도" />
      <div className="rounded-control border border-hairline-soft bg-canvas-soft p-3">
        <p className="text-[10px] font-semibold uppercase tracking-[0.18em] text-muted-soft">
          🧩 구성 부품
        </p>
        <div className="mt-2">
          <Parts node={node} />
        </div>
      </div>
    </div>
  );
}

// ── design — DomainModel3D + property/inspector panel (click a part) ──────────
export function DesignSurface({ node }: { node: SurfaceNode }) {
  const parts = node.parts ?? [];
  const [sel, setSel] = useState<string | null>(parts[0]?.name ?? null);
  const selected = parts.find((p) => p.name === sel) ?? null;

  return (
    <div className="grid gap-3 md:grid-cols-[1fr_minmax(0,18rem)]">
      <ModelStage node={node} caption="값 채우기 — 부품을 골라 속성 입력" />
      <div className="rounded-control border border-hairline-soft bg-canvas-soft p-3">
        <p className="text-[10px] font-semibold uppercase tracking-[0.18em] text-muted-soft">
          🔍 인스펙터
        </p>
        {parts.length === 0 ? (
          <p className="mt-2 text-[11px] text-muted-soft">
            말단 노드 — 직접 값을 정의하는 단위입니다.
          </p>
        ) : (
          <>
            <div className="mt-2 flex flex-wrap gap-1.5">
              {parts.map((p) => (
                <button
                  key={p.name}
                  onClick={() => setSel(p.name)}
                  className={
                    "rounded-chip px-2 py-0.5 text-[11px] font-mono transition " +
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
                  <dt className="text-muted">part</dt>
                  <dd className="font-mono text-body-strong">{selected.name}</dd>
                </div>
                <div className="flex justify-between">
                  <dt className="text-muted">verify</dt>
                  <dd>
                    {STATE_BADGE[selected.state]} {selected.state}
                  </dd>
                </div>
                <div className="flex justify-between">
                  <dt className="text-muted">values</dt>
                  <dd className="text-muted-soft">
                    {selected.state === "unverified" ? "미정 (입력 대기)" : "정의됨"}
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
export function AnalyzeSurface({ node }: { node: SurfaceNode }) {
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
        <p className="text-[11px] text-muted">
          🔬 문제 부위는 모델 위에서 붉게/주황으로 점등됩니다
        </p>
        <button
          onClick={() => setScan((s) => s + 1)}
          className="rounded-control border border-hairline-soft px-2.5 py-1 text-xs text-body hover:bg-surface-strong"
          title="재검사"
        >
          ⟲ 고치기
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
        caption={
          problems.length || selfProblem
            ? `⚠ ${problems.length + (selfProblem ? 1 : 0)} 문제`
            : "✅ 문제 없음"
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
              <span>{p.state === "falsified" ? "🔴" : "🟡"}</span>
              <span className="font-mono">{p.name}</span>
              <span className="ml-auto text-muted-soft">{p.state}</span>
            </li>
          ))}
        </ul>
      ) : (
        <p className="text-[11px] text-success">
          {selfProblem
            ? "이 노드 자체가 아직 미검증 — verify 단계로 진행하세요."
            : "모든 구성 부품 검증됨."}
        </p>
      )}
    </div>
  );
}

// ── synth — DomainModel3D "powered on" (animate) + progress strip ────────────
export function SynthSurface({ node }: { node: SurfaceNode }) {
  const [running, setRunning] = useState(false);
  return (
    <div className="space-y-3">
      <div className="flex items-center justify-between gap-2">
        <p className="text-[11px] text-muted">
          ⚡ 모델에 전원을 넣어 시뮬레이션(QFORGE/sim)을 가동합니다
        </p>
        <button
          onClick={() => setRunning((r) => !r)}
          className={
            "rounded-control px-2.5 py-1 text-xs font-medium transition " +
            (running
              ? "bg-primary text-on-primary hover:bg-primary-active"
              : "border border-hairline-soft text-body hover:bg-surface-strong")
          }
        >
          {running ? "⏸ 가동 중" : "▶ 가동"}
        </button>
      </div>
      <ModelStage
        node={node}
        poweredOn={running}
        caption={running ? "⚡ powered on" : "off"}
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
export function VerifySurface({ node }: { node: SurfaceNode }) {
  const passed = node.state === "verified" || node.state === "verified-formal";
  return (
    <div className="grid gap-3 md:grid-cols-[1fr_minmax(0,18rem)]">
      <div className="relative">
        <ModelStage node={node} caption="검증 결과가 노드에 각인됩니다" />
        {/* stamped result badge over the model */}
        <span
          className="pointer-events-none absolute right-3 top-3 rounded-full bg-black/65 px-2 py-1 text-base"
          title={node.state}
        >
          {STATE_BADGE[node.state]}
        </span>
      </div>
      <div className="rounded-control border border-hairline-soft bg-canvas-soft p-3">
        <p className="text-[10px] font-semibold uppercase tracking-[0.18em] text-muted-soft">
          ⚖ 대조 저울
        </p>
        <div className="mt-3 grid grid-cols-2 gap-2 text-center text-xs">
          <div className="rounded-control bg-surface-strong p-2">
            <p className="text-muted">우리 값</p>
            <p className="mt-1 font-mono text-body-strong">QFORGE</p>
          </div>
          <div className="rounded-control bg-surface-strong p-2">
            <p className="text-muted">기준 (ref)</p>
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
          {passed ? "교차검증 일치 → 각인" : "검증 대기 (⚪→🟢)"}
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
  dossier,
}: {
  node: SurfaceNode;
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
            />
          </div>
          <div className="min-w-0">
            <p className="text-[10px] font-semibold uppercase tracking-[0.18em] text-muted-soft">
              🏅 인증서 · certificate
            </p>
            <p className="mt-1 truncate text-lg font-semibold text-ink">
              {node.icon ?? "⬡"} {node.name}
            </p>
            {node.alias && (
              <p className="truncate text-xs text-muted-soft">— {node.alias}</p>
            )}
            <p className="mt-1 text-xs text-body">
              {STATE_BADGE[node.state]} {node.state}
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
            {sealed ? "검증완료" : "검증대기"}
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
  dossier,
}: {
  verb: string;
  node: SurfaceNode;
  dossier?: React.ReactNode;
}) {
  switch (verb) {
    case "discover":
      return <DiscoverSurface node={node} />;
    case "spec":
      return <SpecSurface node={node} />;
    case "structure":
      return <StructureSurface node={node} />;
    case "design":
      return <DesignSurface node={node} />;
    case "analyze":
      return <AnalyzeSurface node={node} />;
    case "synth":
      return <SynthSurface node={node} />;
    case "verify":
      return <VerifySurface node={node} />;
    case "handoff":
      return <HandoffSurface node={node} dossier={dossier} />;
    default:
      return null;
  }
}
