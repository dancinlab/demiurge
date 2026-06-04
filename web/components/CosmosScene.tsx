// CosmosScene — the 3D Domain Cosmos constellation (8VERB §1 D1 / D2 / D6).
//
// SSR-safe: this module is mounted ONLY through next/dynamic(ssr:false) by
// CosmosStage, so `three`/R3F never executes server-side. The server component
// (app/(app)/cosmos/page.tsx) calls buildCosmos() and hands the plain graph
// down as a prop — this file is pure presentation over that data (d4: one
// generic path, no per-domain branching; geometry of the focused node comes
// from the P2 descriptor layer, never hardcoded — @L10).
//
// Layout (D1): every domain is a node placed on a VERTICAL rung axis
//   원자(atom) bottom → 물질(materials) → 칩(chip) → 시스템(system) top.
// State (§4) is encoded by node color (STATE_ACCENT) + a floating badge.
// Edges (NEXUS) are drawn as connectors.
//
// Focus (D2): clicking a node (or a parent setting focusTarget) calls
// decompose(target, graph) — the target's composition sub-tree is lit, the rest
// dims; the focused node renders the FULL P2 DomainModel3D (faithful geometry),
// the wide overview uses lightweight glyph meshes for performance (~37 nodes).

"use client";

import { Suspense, useCallback, useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import { Canvas } from "@react-three/fiber";
import { Html, OrbitControls, Text } from "@react-three/drei";
import * as THREE from "three";
import {
  decompose,
  STATE_BADGE,
  type CosmosGraph,
  type CosmosNode,
  type CosmosTree,
  type Rung,
  type VerifyState,
} from "@/lib/cosmos";
import { DomainModel3D } from "@/components/DomainModel3D";

// ── palette (WebGL can't read CSS vars — hex direct, synced w/ DomainModel3DR3F)
const STATE_ACCENT: Record<VerifyState, string> = {
  "verified-formal": "#7fb3d5",
  verified: "#86b97a",
  "needs-verify": "#e8c46a",
  unverified: "#c4b5a5",
  falsified: "#d98a8a",
};

const DIM = "#3a3530";
const EDGE = "#6b6258";
const EDGE_LIT = "#f4c5a8";

// ── §2 scale ladder — rung → vertical Y (atom bottom → system top) ────────────
const RUNG_ORDER: Rung[] = ["atom", "materials", "chip", "system"];
const RUNG_Y: Record<Rung, number> = {
  atom: -6,
  materials: -2,
  chip: 2,
  system: 6,
};
const RUNG_LABEL: Record<Rung, string> = {
  atom: "원자",
  materials: "물질·바이오·화학",
  chip: "칩·상위구조",
  system: "시스템",
};

// Filter chips (D6). A chip narrows which nodes are HIGHLIGHTED; non-matching
// nodes are DIMMED, never hard-hidden (honesty — no silent omission).
export type CosmosFilter = "verified" | "needs-verify" | "buildable";

// ── layout: position every node on its rung row, spread on X (+ Z jitter) ─────
type Placed = { node: CosmosNode; pos: [number, number, number] };

function layout(nodes: CosmosNode[]): Placed[] {
  const byRung = new Map<Rung, CosmosNode[]>();
  for (const r of RUNG_ORDER) byRung.set(r, []);
  for (const n of nodes) byRung.get(n.rung)!.push(n);

  const placed: Placed[] = [];
  for (const r of RUNG_ORDER) {
    const row = byRung.get(r)!;
    const n = row.length;
    const span = Math.max(1, n - 1);
    const width = Math.min(24, Math.max(8, n * 2.2));
    row.forEach((node, i) => {
      const x = n === 1 ? 0 : (i / span - 0.5) * width;
      // deterministic Z jitter so a dense row reads as a constellation, not a line
      const z = ((i * 2654435761) % 1000) / 1000;
      placed.push({ node, pos: [x, RUNG_Y[r], (z - 0.5) * 4] });
    });
  }
  return placed;
}

// A node matches the active filter (→ highlighted). buildable = all composition
// deps verified AND itself not yet verified (지금 만들 수 있는 것).
function nodeMatches(
  node: CosmosNode,
  filter: CosmosFilter | null,
  buildable: Set<string>,
): boolean {
  if (!filter) return true;
  if (filter === "verified")
    return node.state === "verified" || node.state === "verified-formal";
  if (filter === "needs-verify")
    return node.state === "needs-verify" || node.state === "unverified";
  return buildable.has(node.name.toUpperCase());
}

// Compute "buildable" set: a node whose every composition child is verified but
// which is itself not yet verified — i.e. ready to build now.
function computeBuildable(graph: CosmosGraph): Set<string> {
  const stateByName = new Map<string, VerifyState>();
  for (const n of graph.nodes) stateByName.set(n.name.toUpperCase(), n.state);
  const isV = (s?: VerifyState) => s === "verified" || s === "verified-formal";

  const childrenOf = new Map<string, string[]>();
  for (const e of graph.edges) {
    const to = e.to.toUpperCase();
    const from = e.from.toUpperCase();
    if (to === from) continue;
    (childrenOf.get(to) ?? childrenOf.set(to, []).get(to)!).push(from);
  }

  const out = new Set<string>();
  for (const n of graph.nodes) {
    const up = n.name.toUpperCase();
    const kids = childrenOf.get(up);
    if (!kids || kids.length === 0) continue; // a leaf isn't "assembled" from deps
    if (isV(n.state)) continue; // already built
    if (kids.every((k) => isV(stateByName.get(k)))) out.add(up);
  }
  return out;
}

// ── lightweight overview glyph (one per node) ─────────────────────────────────
function NodeGlyph({
  placed,
  highlighted,
  focused,
  onClick,
}: {
  placed: Placed;
  highlighted: boolean;
  focused: boolean;
  onClick: (name: string) => void;
}) {
  const { node, pos } = placed;
  const color = highlighted ? STATE_ACCENT[node.state] : DIM;
  const r = focused ? 0.55 : 0.34;
  return (
    <group position={pos}>
      <mesh
        onClick={(e) => {
          e.stopPropagation();
          onClick(node.name);
        }}
        onPointerOver={(e) => {
          e.stopPropagation();
          document.body.style.cursor = "pointer";
        }}
        onPointerOut={() => {
          document.body.style.cursor = "auto";
        }}
      >
        <sphereGeometry args={[r, 20, 20]} />
        <meshStandardMaterial
          color={color}
          emissive={color}
          emissiveIntensity={highlighted ? 0.35 : 0.04}
          roughness={0.5}
          transparent
          opacity={highlighted ? 1 : 0.45}
        />
      </mesh>
      {/* label + state badge — only readable when highlighted */}
      <Text
        position={[0, r + 0.5, 0]}
        fontSize={0.42}
        color={highlighted ? "#ece8e3" : "#7a726a"}
        anchorX="center"
        anchorY="bottom"
        outlineWidth={0.012}
        outlineColor="#1a1714"
      >
        {`${node.icon ?? ""}${node.icon ? " " : ""}${node.name}`}
      </Text>
      <Html position={[r + 0.2, r + 0.2, 0]} center distanceFactor={14}>
        <span style={{ fontSize: 18, userSelect: "none", pointerEvents: "none" }}>
          {STATE_BADGE[node.state]}
        </span>
      </Html>
    </group>
  );
}

// ── edges as line connectors (lit when both endpoints are in the focus set) ───
function EdgeLines({
  graph,
  placed,
  litNames,
  focusActive,
}: {
  graph: CosmosGraph;
  placed: Placed[];
  litNames: Set<string>;
  focusActive: boolean;
}) {
  const posByName = useMemo(() => {
    const m = new Map<string, [number, number, number]>();
    for (const p of placed) m.set(p.node.name.toUpperCase(), p.pos);
    return m;
  }, [placed]);

  const segments = useMemo(() => {
    const lit: THREE.Vector3[] = [];
    const dim: THREE.Vector3[] = [];
    for (const e of graph.edges) {
      const a = posByName.get(e.from.toUpperCase());
      const b = posByName.get(e.to.toUpperCase());
      if (!a || !b) continue;
      const isLit =
        focusActive &&
        litNames.has(e.from.toUpperCase()) &&
        litNames.has(e.to.toUpperCase());
      const bucket = isLit ? lit : dim;
      bucket.push(new THREE.Vector3(...a), new THREE.Vector3(...b));
    }
    return { lit, dim };
  }, [graph.edges, posByName, litNames, focusActive]);

  const litGeo = useMemo(
    () => new THREE.BufferGeometry().setFromPoints(segments.lit),
    [segments.lit],
  );
  const dimGeo = useMemo(
    () => new THREE.BufferGeometry().setFromPoints(segments.dim),
    [segments.dim],
  );

  return (
    <group>
      <lineSegments geometry={dimGeo}>
        <lineBasicMaterial color={EDGE} transparent opacity={focusActive ? 0.12 : 0.3} />
      </lineSegments>
      <lineSegments geometry={litGeo}>
        <lineBasicMaterial color={EDGE_LIT} transparent opacity={0.85} />
      </lineSegments>
    </group>
  );
}

// ── scale-ladder rung guides + labels (D2/D3 axis) ────────────────────────────
function ScaleLadder() {
  return (
    <group>
      {RUNG_ORDER.map((r) => (
        <group key={r} position={[0, RUNG_Y[r], 0]}>
          <Text
            position={[-15, 0, 0]}
            fontSize={0.6}
            color="#9a9088"
            anchorX="left"
            anchorY="middle"
          >
            {RUNG_LABEL[r]}
          </Text>
          {/* faint rung plane edge */}
          <mesh rotation={[Math.PI / 2, 0, 0]}>
            <ringGeometry args={[0.01, 0.04, 4]} />
            <meshBasicMaterial color="#4a443e" />
          </mesh>
        </group>
      ))}
      {/* the vertical spine */}
      <mesh position={[-14, 0, 0]}>
        <boxGeometry args={[0.03, RUNG_Y.system - RUNG_Y.atom + 2, 0.03]} />
        <meshBasicMaterial color="#5a534c" />
      </mesh>
    </group>
  );
}

// ── focused-node faithful model (P2 DomainModel3D in an Html overlay) ─────────
function FocusModel({ node }: { node: CosmosNode }) {
  const pos = RUNG_Y[node.rung];
  return (
    <Html
      position={[10, pos, 0]}
      transform={false}
      distanceFactor={undefined}
      style={{ pointerEvents: "none" }}
    >
      <div
        style={{
          width: 220,
          height: 180,
          background: "rgba(20,18,16,0.85)",
          borderRadius: 10,
          border: "1px solid #4a443e",
          overflow: "hidden",
        }}
      >
        <DomainModel3D
          domain={node.name}
          rung={node.rung}
          goal={node.goal}
          state={node.state}
        />
      </div>
    </Html>
  );
}

// ── the R3F scene graph (inside <Canvas>) ─────────────────────────────────────
function Scene({
  graph,
  placed,
  filter,
  buildable,
  focusTarget,
  litNames,
  onPick,
}: {
  graph: CosmosGraph;
  placed: Placed[];
  filter: CosmosFilter | null;
  buildable: Set<string>;
  focusTarget: string | null;
  litNames: Set<string>;
  onPick: (name: string) => void;
}) {
  const focusActive = !!focusTarget;
  const focusUp = focusTarget?.toUpperCase() ?? null;
  const focusedNode = focusUp
    ? placed.find((p) => p.node.name.toUpperCase() === focusUp)?.node ?? null
    : null;

  return (
    <>
      <ambientLight intensity={0.5} />
      <directionalLight position={[8, 10, 8]} intensity={0.8} />
      <directionalLight position={[-6, -4, -6]} intensity={0.3} />

      <ScaleLadder />
      <EdgeLines
        graph={graph}
        placed={placed}
        litNames={litNames}
        focusActive={focusActive}
      />

      {placed.map((p) => {
        const up = p.node.name.toUpperCase();
        const matchFilter = nodeMatches(p.node, filter, buildable);
        // highlight rule: in focus mode, lit set wins; else filter governs.
        const highlighted = focusActive ? litNames.has(up) : matchFilter;
        return (
          <NodeGlyph
            key={up}
            placed={p}
            highlighted={highlighted}
            focused={focusUp === up}
            onClick={onPick}
          />
        );
      })}

      {focusedNode && <FocusModel node={focusedNode} />}

      <OrbitControls
        enablePan
        enableZoom
        minDistance={6}
        maxDistance={60}
        target={[0, focusedNode ? RUNG_Y[focusedNode.rung] : 0, 0]}
      />
    </>
  );
}

// First incomplete verb for a node → the verb work-page to push into.
// We can't read per-domain milestone status here (client), so default to the
// pipeline head `discover` (D4: "作업하기 → router.push('/discover/<domain>')").
const FIRST_VERB = "discover";

// ── the public scene component (mounted client-only via CosmosStage) ──────────
export function CosmosScene({
  graph,
  initialFocus,
}: {
  graph: CosmosGraph;
  /** P5 URL deeplink: initial focused node from /cosmos?target=<DOMAIN>. */
  initialFocus?: string | null;
}) {
  const router = useRouter();
  const [filter, setFilter] = useState<CosmosFilter | null>(null);
  // Seed focus from the URL deeplink (?target=) so refresh/share is stable.
  const [focusTarget, setFocusTarget] = useState<string | null>(
    initialFocus || null,
  );
  const [cameraKey, setCameraKey] = useState(0); // bump to dolly to a rung

  const placed = useMemo(() => layout(graph.nodes), [graph.nodes]);
  const buildable = useMemo(() => computeBuildable(graph), [graph]);

  // focus → decompose: the lit set = the target + its composition sub-tree.
  const decomposition = useMemo(
    () => (focusTarget ? decompose(focusTarget, graph) : null),
    [focusTarget, graph],
  );
  const litNames = useMemo(() => {
    const s = new Set<string>();
    if (!decomposition) return s;
    const walk = (t: CosmosTree) => {
      s.add(t.node.name.toUpperCase());
      t.children.forEach(walk);
    };
    walk(decomposition.tree);
    return s;
  }, [decomposition]);

  // Click handler P5 will also drive via a `demiurge:focus` window event.
  const onPick = useCallback((name: string) => {
    setFocusTarget((cur) => (cur && cur.toUpperCase() === name.toUpperCase() ? null : name));
  }, []);

  // P5 wiring surface — listen for `demiurge:focus` { detail: { target } }.
  useEffect(() => {
    const h = (e: Event) => {
      const t = (e as CustomEvent<{ target?: string }>).detail?.target;
      if (typeof t === "string") setFocusTarget(t || null);
    };
    window.addEventListener("demiurge:focus", h as EventListener);
    return () => window.removeEventListener("demiurge:focus", h as EventListener);
  }, []);

  // P5 URL deeplink sync — reflect the focused node into ?target= (shallow,
  // no navigation) so the address bar is shareable + refresh-safe.
  useEffect(() => {
    if (typeof window === "undefined") return;
    const url = new URL(window.location.href);
    if (focusTarget) url.searchParams.set("target", focusTarget);
    else url.searchParams.delete("target");
    window.history.replaceState(window.history.state, "", url.toString());
  }, [focusTarget]);

  const focusedNode = focusTarget
    ? graph.nodes.find((n) => n.name.toUpperCase() === focusTarget.toUpperCase()) ??
      null
    : null;

  return (
    <div className="relative h-full w-full">
      {/* ── filter toggles (D6) — dim non-matching, never hard-hide ───────── */}
      <div className="pointer-events-auto absolute left-3 top-3 z-10 flex flex-wrap gap-2">
        <FilterChip
          label="검증됨"
          active={filter === "verified"}
          onClick={() => setFilter((f) => (f === "verified" ? null : "verified"))}
        />
        <FilterChip
          label="검증필요"
          active={filter === "needs-verify"}
          onClick={() =>
            setFilter((f) => (f === "needs-verify" ? null : "needs-verify"))
          }
        />
        <FilterChip
          label="지금 만들 수 있는 것"
          active={filter === "buildable"}
          onClick={() => setFilter((f) => (f === "buildable" ? null : "buildable"))}
        />
      </div>

      {/* ── scale-ladder dolly buttons (§3) ──────────────────────────────── */}
      <div className="pointer-events-auto absolute right-3 top-3 z-10 flex flex-col gap-1.5 text-xs">
        <button
          onClick={() => setCameraKey((k) => k + 1)}
          className="rounded bg-black/55 px-2 py-1 text-stone-200 hover:bg-black/75"
          title="시스템 쪽으로 (더 크게)"
        >
          ↑ 더 크게
        </button>
        {RUNG_ORDER.slice()
          .reverse()
          .map((r) => (
            <button
              key={r}
              onClick={() => setCameraKey((k) => k + 1)}
              className="rounded bg-black/40 px-2 py-1 text-left text-stone-300 hover:bg-black/65"
            >
              {RUNG_LABEL[r]}
            </button>
          ))}
        <button
          onClick={() => setCameraKey((k) => k + 1)}
          className="rounded bg-black/55 px-2 py-1 text-stone-200 hover:bg-black/75"
          title="원자 쪽으로 (더 작게)"
        >
          ↓ 더 작게
        </button>
      </div>

      {/* ── focus banner (D2) — carried target + rollup badge ────────────── */}
      {focusedNode && decomposition && (
        <div className="pointer-events-auto absolute bottom-3 left-3 z-10 max-w-sm rounded-lg bg-black/65 p-3 text-stone-100">
          <div className="flex items-center gap-2 text-sm font-medium">
            <span>{focusedNode.icon}</span>
            <span>{focusedNode.name}</span>
            <span>{STATE_BADGE[decomposition.tree.rollup]}</span>
            {focusedNode.alias && (
              <span className="text-xs text-stone-400">— {focusedNode.alias}</span>
            )}
          </div>
          <div className="mt-1.5 flex flex-wrap gap-1.5 text-xs">
            {decomposition.tree.children.length === 0 && (
              <span className="text-stone-400">하위 도메인 없음 (말단 노드)</span>
            )}
            {decomposition.tree.children.map((c) => (
              <span
                key={c.node.name}
                className="rounded bg-white/10 px-1.5 py-0.5"
                title={c.via?.primitive ?? undefined}
              >
                {STATE_BADGE[c.rollup]} {c.node.name}
              </span>
            ))}
          </div>
          {/* P5 node→work-page nav (D4 page-routing layer): REAL page nav into
              the node's first verb work-page; browser back returns to /cosmos. */}
          <div className="mt-2 flex flex-wrap items-center gap-2">
            <button
              onClick={() =>
                router.push(`/${FIRST_VERB}/${encodeURIComponent(focusedNode.name)}`)
              }
              className="rounded-full bg-orb-peach px-3 py-1 text-xs font-medium text-black hover:opacity-90"
              style={{ background: "#f4c5a8", color: "#000" }}
            >
              작업하기 ▶
            </button>
            <button
              onClick={() => router.push(`/d/${encodeURIComponent(focusedNode.name)}`)}
              className="rounded-full bg-white/10 px-3 py-1 text-xs text-stone-200 hover:bg-white/20"
            >
              상세 보기
            </button>
            <button
              onClick={() => setFocusTarget(null)}
              className="text-xs text-stone-400 underline hover:text-stone-200"
            >
              전체 보기로 돌아가기
            </button>
          </div>
        </div>
      )}

      <Canvas
        key={cameraKey}
        camera={{ position: [0, 0, 30], fov: 45 }}
        className="bg-[#16130f]"
      >
        <Suspense fallback={null}>
          <Scene
            graph={graph}
            placed={placed}
            filter={filter}
            buildable={buildable}
            focusTarget={focusTarget}
            litNames={litNames}
            onPick={onPick}
          />
        </Suspense>
      </Canvas>
    </div>
  );
}

function FilterChip({
  label,
  active,
  onClick,
}: {
  label: string;
  active: boolean;
  onClick: () => void;
}) {
  return (
    <button
      onClick={onClick}
      className={`rounded-full px-3 py-1 text-xs transition ${
        active
          ? "bg-orb-peach text-black"
          : "bg-black/45 text-stone-200 hover:bg-black/70"
      }`}
      style={active ? { background: "#f4c5a8", color: "#000" } : undefined}
    >
      {label}
    </button>
  );
}

export default CosmosScene;
