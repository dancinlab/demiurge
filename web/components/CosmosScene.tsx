// CosmosScene — the 3D Domain Cosmos constellation (8VERB §1 D1 / D2 / D6).
//
// SSR-safe: this module is mounted ONLY through next/dynamic(ssr:false) by
// CosmosStage, so `three`/R3F never executes server-side. The server component
// (app/(app)/cosmos/page.tsx) calls buildCosmos() and hands the plain graph
// down as a prop — this file is pure presentation over that data (d4: one
// generic path, no per-domain branching; geometry of the focused node comes
// from the P2 descriptor layer, never hardcoded — @L10).
//
// Layout (D1): every domain is a node placed on a VERTICAL rung axis, SIX bands
//   (§10 layperson ladder · INDEX.demi `facets.rung` data-driven · d4):
//   원자(atom) bottom → 물질(materials) → 바이오(bio) → 화학(chem) → 칩(chip) →
//   시스템(system) top.
// State (§4) is encoded by node color (STATE_ACCENT) + a floating badge.
// Edges (INDEX.demi prerequisites · §10) are drawn as connectors.
//
// Focus (D2): clicking a node (or a parent setting focusTarget) calls
// decompose(target, graph) — the target's composition sub-tree is lit, the rest
// dims; the focused node renders the FULL P2 DomainModel3D (faithful geometry),
// the wide overview uses lightweight glyph meshes for performance (~37 nodes).
//
// P6 hardening: all copy via the i18n prop (NO literal strings); a keyboard-
// accessible node list under the canvas is the text alternative for the WebGL
// view (a11y); filter chips are a labelled toggle group; the focus banner +
// dolly controls carry aria-labels.

"use client";

import {
  Suspense,
  useCallback,
  useEffect,
  useLayoutEffect,
  useMemo,
  useRef,
  useState,
} from "react";
import { useRouter } from "next/navigation";
import { Canvas, type ThreeEvent } from "@react-three/fiber";
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
import type { CosmosI18n } from "@/lib/cosmos-i18n";
import { DomainModel3D } from "@/components/DomainModel3D";
import {
  overviewGeometryForShape,
  overviewShapeFor,
  type ProceduralShape,
} from "@/lib/geometry-3d";

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

// ── overview rung-shape glyphs (perf-tuned) ──────────────────────────────────
// The overview draws each node as its RUNG-TYPED 3D shape (a compact, low-poly
// merged silhouette), grouped into ONE InstancedMesh per shape kind so ~30+
// nodes stay at one draw call per shape (≤ the count of distinct shapes, not the
// node count). PERFORMANCE GUARD: above this node count (or no WebGL2 / low
// hardware-concurrency heuristic) we fall back to the lightweight sphere glyph
// for ALL nodes — the rung-typed silhouette is the nicety, honest state + click
// are the contract and must never jank.
const OVERVIEW_GLYPH_FALLBACK_THRESHOLD = 60;
// World-space radius each rung-shape glyph is scaled to fit (matches the sphere
// glyph footprint so layout/labels are unaffected). Highlighted nodes scale up.
const GLYPH_BOUND = 0.42;
const GLYPH_BOUND_FOCUSED = 0.7;

// ── §2/§10 scale ladder — rung → vertical Y (atom bottom → system top) ────────
// SIX layperson bands (§10 · INDEX.demi `facets.rung`, data-driven), evenly
// spaced 6 units apart: 원자 atom → 물질 materials → 바이오 bio → 화학 chem →
// 칩 chip → 시스템 system.
const RUNG_ORDER: Rung[] = ["atom", "materials", "bio", "chem", "chip", "system"];
const RUNG_Y: Record<Rung, number> = {
  atom: -15,
  materials: -9,
  bio: -3,
  chem: 3,
  chip: 9,
  system: 15,
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
  hovered,
  onClick,
  onHoverName,
}: {
  placed: Placed;
  highlighted: boolean;
  focused: boolean;
  hovered: boolean;
  onClick: (name: string) => void;
  onHoverName: (name: string | null) => void;
}) {
  const { node, pos } = placed;
  const baseColor = highlighted ? STATE_ACCENT[node.state] : DIM;
  // Hover affordance (sphere path): brighten toward white + a slight scale-up,
  // and lift emissive so the node reads as "hot" against the dim/lit scheme.
  const color = hovered
    ? new THREE.Color(baseColor).lerp(new THREE.Color("#ffffff"), 0.4).getStyle()
    : baseColor;
  const r = (focused ? 0.55 : 0.34) * (hovered ? 1.18 : 1);
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
          onHoverName(node.name);
        }}
        onPointerOut={() => {
          document.body.style.cursor = "auto";
          onHoverName(null);
        }}
      >
        <sphereGeometry args={[r, 20, 20]} />
        <meshStandardMaterial
          color={color}
          emissive={color}
          emissiveIntensity={hovered ? 0.7 : highlighted ? 0.35 : 0.04}
          roughness={0.5}
          transparent
          opacity={hovered ? 1 : highlighted ? 1 : 0.45}
        />
      </mesh>
      {/* label + state badge — only readable when highlighted */}
      <Text
        position={[0, r + 0.5, 0]}
        fontSize={0.42}
        color={hovered ? "#ffffff" : highlighted ? "#ece8e3" : "#7a726a"}
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

// ── verify-state tint as a THREE.Color (per-instance color source) ───────────
const STATE_COLOR: Record<VerifyState, THREE.Color> = {
  "verified-formal": new THREE.Color("#7fb3d5"),
  verified: new THREE.Color("#86b97a"),
  "needs-verify": new THREE.Color("#e8c46a"),
  unverified: new THREE.Color("#c4b5a5"),
  falsified: new THREE.Color("#d98a8a"),
};
const DIM_COLOR = new THREE.Color(DIM);
const WHITE = new THREE.Color("#ffffff");
// Per-instance hover boost: scale-up factor + how far to lerp the tint toward
// white (the "hot" affordance — reads cleanly over both the lit verify-tint and
// the dimmed DIM_COLOR scheme).
const HOVER_SCALE = 1.22;
const HOVER_LERP = 0.4;
// Scratch color reused per-instance write (no per-frame allocation).
const TMP_COLOR = new THREE.Color();

// Low-power heuristic + WebGL capability check → should we even attempt the
// rung-shape glyphs? Coarse (navigator.hardwareConcurrency) but cheap; the real
// guard is the node-count threshold. SSR-safe (returns true under no `window`,
// decided again client-side).
function canRenderShapeGlyphs(nodeCount: number): boolean {
  if (nodeCount > OVERVIEW_GLYPH_FALLBACK_THRESHOLD) return false;
  if (typeof navigator !== "undefined") {
    const cores = navigator.hardwareConcurrency;
    if (typeof cores === "number" && cores > 0 && cores < 4) return false;
  }
  return true;
}

// One InstancedMesh for ALL nodes that share a rung shape. Per-instance matrix
// (position + highlight scale) and per-instance color (verify-state tint, dimmed
// when not highlighted). instanceId picking drives click + hover. The merged,
// unit-bounded geometry is built ONCE per shape (shared). Stylized nodes are
// rendered slightly translucent (D3 honesty: no-data shapes never read as solid
// faithful geometry); the ⚪/🟡 badge + label are drawn separately per node.
function RungShapeInstances({
  shape,
  placed,
  geometry,
  highlightOf,
  focusedUp,
  hoveredUp,
  onPick,
  onHoverName,
}: {
  shape: ProceduralShape;
  placed: Placed[]; // already filtered to this shape
  geometry: THREE.BufferGeometry;
  highlightOf: (up: string) => boolean;
  focusedUp: string | null;
  hoveredUp: string | null;
  onPick: (name: string) => void;
  onHoverName: (name: string | null) => void;
}) {
  const ref = useRef<THREE.InstancedMesh>(null);
  const dummy = useMemo(() => new THREE.Object3D(), []);
  // Any stylized node in this shape group → render the whole instanced mesh as
  // translucent (a shape group is homogeneous in stylization for fallback rungs;
  // faithful registered domains are solid). Per-shape, not per-instance, keeps a
  // single material (one draw call).
  const anyStylized = useMemo(
    () =>
      placed.some(
        (p) => overviewShapeFor({ name: p.node.name, rung: p.node.rung, goal: p.node.goal }).stylized,
      ),
    [placed],
  );

  // Ensure the per-instance color buffer exists at first compile so three
  // injects the instancing-color shader chunk (otherwise a buffer added later
  // via setColorAt may not recompile the program on some paths).
  useLayoutEffect(() => {
    const mesh = ref.current;
    if (!mesh) return;
    if (!mesh.instanceColor) {
      mesh.instanceColor = new THREE.InstancedBufferAttribute(
        new Float32Array(placed.length * 3).fill(1),
        3,
      );
    }
  }, [placed.length]);

  // Write matrices + colors whenever the highlight/focus inputs change.
  useLayoutEffect(() => {
    const mesh = ref.current;
    if (!mesh) return;
    placed.forEach((p, i) => {
      const up = p.node.name.toUpperCase();
      const hl = highlightOf(up);
      const focused = focusedUp === up;
      const hovered = hoveredUp === up;
      let s = (focused ? GLYPH_BOUND_FOCUSED : GLYPH_BOUND) * (hl ? 1 : 0.82);
      if (hovered) s *= HOVER_SCALE; // hover affordance: slight scale-up
      dummy.position.set(...p.pos);
      dummy.scale.setScalar(s);
      dummy.rotation.set(0, (i % 8) * 0.4, 0); // slight deterministic yaw variety
      dummy.updateMatrix();
      mesh.setMatrixAt(i, dummy.matrix);
      const base = hl ? STATE_COLOR[p.node.state] : DIM_COLOR;
      if (hovered) {
        // brighten the tint toward white so the hovered node reads as "hot"
        TMP_COLOR.copy(base).lerp(WHITE, HOVER_LERP);
        mesh.setColorAt(i, TMP_COLOR);
      } else {
        mesh.setColorAt(i, base);
      }
    });
    mesh.instanceMatrix.needsUpdate = true;
    if (mesh.instanceColor) mesh.instanceColor.needsUpdate = true;
  }, [placed, geometry, highlightOf, focusedUp, hoveredUp, dummy]);

  if (placed.length === 0) return null;

  return (
    <instancedMesh
      ref={ref}
      args={[geometry, undefined, placed.length]}
      onClick={(e: ThreeEvent<MouseEvent>) => {
        e.stopPropagation();
        const id = e.instanceId;
        if (id == null) return;
        onPick(placed[id].node.name);
      }}
      onPointerOver={(e: ThreeEvent<PointerEvent>) => {
        e.stopPropagation();
        const id = e.instanceId;
        if (id == null) return;
        document.body.style.cursor = "pointer";
        onHoverName(placed[id].node.name);
      }}
      // pointer-move so moving BETWEEN instances of the SAME mesh re-targets the
      // hovered node (onPointerOver only fires on mesh enter, not per-instance).
      onPointerMove={(e: ThreeEvent<PointerEvent>) => {
        e.stopPropagation();
        const id = e.instanceId;
        if (id == null) return;
        onHoverName(placed[id].node.name);
      }}
      onPointerOut={() => {
        document.body.style.cursor = "auto";
        onHoverName(null);
      }}
    >
      <meshStandardMaterial
        roughness={0.55}
        metalness={0.05}
        transparent={anyStylized}
        opacity={anyStylized ? 0.85 : 1}
      />
    </instancedMesh>
  );
}

// Per-node label + state badge overlay (kept separate from the instanced meshes
// so honesty UI — the ⚪/🟡 badge — is unchanged from the sphere-glyph era).
function NodeLabels({
  placed,
  highlightOf,
  focusedUp,
  hoveredUp,
}: {
  placed: Placed[];
  highlightOf: (up: string) => boolean;
  focusedUp: string | null;
  hoveredUp: string | null;
}) {
  return (
    <>
      {placed.map((p) => {
        const up = p.node.name.toUpperCase();
        const hl = highlightOf(up);
        const hovered = hoveredUp === up;
        const r = focusedUp === up ? GLYPH_BOUND_FOCUSED : GLYPH_BOUND;
        return (
          <group key={up} position={p.pos}>
            <Text
              position={[0, r + 0.5, 0]}
              fontSize={hovered ? 0.46 : 0.42}
              color={hovered ? "#ffffff" : hl ? "#ece8e3" : "#7a726a"}
              anchorX="center"
              anchorY="bottom"
              outlineWidth={0.012}
              outlineColor="#1a1714"
            >
              {`${p.node.icon ?? ""}${p.node.icon ? " " : ""}${p.node.name}`}
            </Text>
            <Html position={[r + 0.2, r + 0.2, 0]} center distanceFactor={14}>
              <span
                style={{ fontSize: 18, userSelect: "none", pointerEvents: "none" }}
              >
                {STATE_BADGE[p.node.state]}
              </span>
            </Html>
          </group>
        );
      })}
    </>
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
function ScaleLadder({ rungLabel }: { rungLabel: Record<Rung, string> }) {
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
            {rungLabel[r]}
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
function FocusModel({
  node,
  noDataLabel,
  errorLabel,
}: {
  node: CosmosNode;
  noDataLabel: string;
  errorLabel: string;
}) {
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
          noDataLabel={noDataLabel}
          errorLabel={errorLabel}
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
  rungLabel,
  modelNoData,
  modelError,
}: {
  graph: CosmosGraph;
  placed: Placed[];
  filter: CosmosFilter | null;
  buildable: Set<string>;
  focusTarget: string | null;
  litNames: Set<string>;
  onPick: (name: string) => void;
  rungLabel: Record<Rung, string>;
  modelNoData: string;
  modelError: string;
}) {
  const focusActive = !!focusTarget;
  const focusUp = focusTarget?.toUpperCase() ?? null;
  const focusedNode = focusUp
    ? placed.find((p) => p.node.name.toUpperCase() === focusUp)?.node ?? null
    : null;

  // Hover affordance state (lifted here so BOTH render paths — instanced rung
  // shapes + sphere-glyph fallback — share one hovered node). Stored uppercased
  // to match the highlight/focus keys.
  const [hoveredUp, setHoveredUp] = useState<string | null>(null);
  const onHoverName = useCallback((name: string | null) => {
    setHoveredUp(name ? name.toUpperCase() : null);
  }, []);

  // highlight rule: in focus mode the lit (decomposition) set wins; else the
  // active filter governs. Shared by both the instanced and fallback paths.
  const highlightOf = useCallback(
    (up: string) => {
      if (focusActive) return litNames.has(up);
      const node = placed.find((p) => p.node.name.toUpperCase() === up)?.node;
      return node ? nodeMatches(node, filter, buildable) : false;
    },
    [focusActive, litNames, placed, filter, buildable],
  );

  // PERF guard: rung-shape glyphs only below the node-count threshold AND on
  // non-low-power hardware; otherwise fall back to the lightweight sphere glyphs.
  const useShapeGlyphs = useMemo(
    () => canRenderShapeGlyphs(placed.length),
    [placed.length],
  );

  // Group nodes by their (synchronously-resolved) rung shape → one InstancedMesh
  // per shape kind. Each shape's merged unit geometry is built ONCE here.
  const shapeGroups = useMemo(() => {
    if (!useShapeGlyphs) return [];
    const by = new Map<ProceduralShape, Placed[]>();
    for (const p of placed) {
      const { shape } = overviewShapeFor({
        name: p.node.name,
        rung: p.node.rung,
        goal: p.node.goal,
      });
      (by.get(shape) ?? by.set(shape, []).get(shape)!).push(p);
    }
    const out: { shape: ProceduralShape; placed: Placed[]; geometry: THREE.BufferGeometry }[] =
      [];
    for (const [shape, nodes] of by) {
      const geometry = overviewGeometryForShape(shape, 1); // unit; scaled per-instance
      if (geometry) out.push({ shape, placed: nodes, geometry });
    }
    return out;
  }, [useShapeGlyphs, placed]);

  // Dispose merged geometries when the group set changes / on unmount.
  useEffect(() => {
    return () => {
      for (const g of shapeGroups) g.geometry.dispose();
    };
  }, [shapeGroups]);

  // Nodes that landed in a successful shape group (the rest fall back to sphere).
  const glyphedNames = useMemo(() => {
    const s = new Set<string>();
    for (const g of shapeGroups)
      for (const p of g.placed) s.add(p.node.name.toUpperCase());
    return s;
  }, [shapeGroups]);

  return (
    <>
      <ambientLight intensity={0.5} />
      <directionalLight position={[8, 10, 8]} intensity={0.8} />
      <directionalLight position={[-6, -4, -6]} intensity={0.3} />

      <ScaleLadder rungLabel={rungLabel} />
      <EdgeLines
        graph={graph}
        placed={placed}
        litNames={litNames}
        focusActive={focusActive}
      />

      {/* OVERVIEW glyphs — rung-typed instanced shapes (perf path) + labels;
          any node not covered by a shape group falls back to a sphere glyph. */}
      {useShapeGlyphs ? (
        <>
          {shapeGroups.map((g) => (
            <RungShapeInstances
              key={g.shape}
              shape={g.shape}
              placed={g.placed}
              geometry={g.geometry}
              highlightOf={highlightOf}
              focusedUp={focusUp}
              hoveredUp={hoveredUp}
              onPick={onPick}
              onHoverName={onHoverName}
            />
          ))}
          <NodeLabels
            placed={placed.filter((p) => glyphedNames.has(p.node.name.toUpperCase()))}
            highlightOf={highlightOf}
            focusedUp={focusUp}
            hoveredUp={hoveredUp}
          />
          {placed
            .filter((p) => !glyphedNames.has(p.node.name.toUpperCase()))
            .map((p) => {
              const up = p.node.name.toUpperCase();
              return (
                <NodeGlyph
                  key={up}
                  placed={p}
                  highlighted={highlightOf(up)}
                  focused={focusUp === up}
                  hovered={hoveredUp === up}
                  onClick={onPick}
                  onHoverName={onHoverName}
                />
              );
            })}
        </>
      ) : (
        placed.map((p) => {
          const up = p.node.name.toUpperCase();
          return (
            <NodeGlyph
              key={up}
              placed={p}
              highlighted={highlightOf(up)}
              focused={focusUp === up}
              hovered={hoveredUp === up}
              onClick={onPick}
              onHoverName={onHoverName}
            />
          );
        })
      )}

      {focusedNode && (
        <FocusModel
          node={focusedNode}
          noDataLabel={modelNoData}
          errorLabel={modelError}
        />
      )}

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
  i18n,
}: {
  graph: CosmosGraph;
  /** P5 URL deeplink: initial focused node from /cosmos?target=<DOMAIN>. */
  initialFocus?: string | null;
  i18n: CosmosI18n;
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

  const rungLabel = i18n.rung;

  return (
    <div className="relative h-full w-full">
      {/* ── filter toggles (D6) — dim non-matching, never hard-hide ───────── */}
      <div
        role="group"
        aria-label={i18n.filterGroupAria}
        className="pointer-events-auto absolute left-3 top-3 z-10 flex flex-wrap gap-2"
      >
        <FilterChip
          label={i18n.filterVerified}
          active={filter === "verified"}
          onClick={() => setFilter((f) => (f === "verified" ? null : "verified"))}
        />
        <FilterChip
          label={i18n.filterNeedsVerify}
          active={filter === "needs-verify"}
          onClick={() =>
            setFilter((f) => (f === "needs-verify" ? null : "needs-verify"))
          }
        />
        <FilterChip
          label={i18n.filterBuildable}
          active={filter === "buildable"}
          onClick={() => setFilter((f) => (f === "buildable" ? null : "buildable"))}
        />
      </div>

      {/* ── scale-ladder dolly buttons (§3) ──────────────────────────────── */}
      <div className="pointer-events-auto absolute right-3 top-3 z-10 flex max-w-[40%] flex-col gap-1.5 text-xs">
        <button
          onClick={() => setCameraKey((k) => k + 1)}
          className="rounded bg-black/55 px-2 py-1 text-stone-200 hover:bg-black/75 focus-visible:outline focus-visible:outline-2 focus-visible:outline-orb-peach"
          title={i18n.biggerTitle}
          aria-label={i18n.biggerTitle}
        >
          {i18n.bigger}
        </button>
        {RUNG_ORDER.slice()
          .reverse()
          .map((r) => (
            <button
              key={r}
              onClick={() => setCameraKey((k) => k + 1)}
              className="rounded bg-black/40 px-2 py-1 text-left text-stone-300 hover:bg-black/65 focus-visible:outline focus-visible:outline-2 focus-visible:outline-orb-peach"
            >
              {rungLabel[r]}
            </button>
          ))}
        <button
          onClick={() => setCameraKey((k) => k + 1)}
          className="rounded bg-black/55 px-2 py-1 text-stone-200 hover:bg-black/75 focus-visible:outline focus-visible:outline-2 focus-visible:outline-orb-peach"
          title={i18n.smallerTitle}
          aria-label={i18n.smallerTitle}
        >
          {i18n.smaller}
        </button>
      </div>

      {/* ── focus banner (D2) — carried target + rollup badge ────────────── */}
      {focusedNode && decomposition && (
        <div className="pointer-events-auto absolute bottom-3 left-3 z-10 max-w-[min(24rem,90vw)] rounded-lg bg-black/65 p-3 text-stone-100">
          <div className="flex items-center gap-2 text-sm font-medium">
            <span aria-hidden>{focusedNode.icon}</span>
            <span>{focusedNode.name}</span>
            <span title={i18n.state[decomposition.tree.rollup]}>
              {STATE_BADGE[decomposition.tree.rollup]}
            </span>
            {focusedNode.alias && (
              <span className="text-xs text-stone-400">— {focusedNode.alias}</span>
            )}
          </div>
          <div className="mt-1.5 flex flex-wrap gap-1.5 text-xs">
            {decomposition.tree.children.length === 0 && (
              <span className="text-stone-400">{i18n.leafNoChildren}</span>
            )}
            {decomposition.tree.children.map((c) => (
              <span
                key={c.node.name}
                className="rounded bg-white/10 px-1.5 py-0.5"
                title={c.via?.primitive ?? i18n.state[c.rollup]}
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
              className="rounded-full px-3 py-1 text-xs font-medium hover:opacity-90 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-orb-peach"
              style={{ background: "#f4c5a8", color: "#000" }}
            >
              {i18n.work}
            </button>
            <button
              onClick={() => router.push(`/d/${encodeURIComponent(focusedNode.name)}`)}
              className="rounded-full bg-white/10 px-3 py-1 text-xs text-stone-200 hover:bg-white/20 focus-visible:outline focus-visible:outline-2 focus-visible:outline-orb-peach"
            >
              {i18n.detail}
            </button>
            <button
              onClick={() => setFocusTarget(null)}
              className="text-xs text-stone-400 underline hover:text-stone-200 focus-visible:outline focus-visible:outline-2 focus-visible:outline-orb-peach"
            >
              {i18n.backToAll}
            </button>
          </div>
        </div>
      )}

      <Canvas
        key={cameraKey}
        camera={{ position: [0, 0, 38], fov: 45 }}
        className="bg-[#16130f]"
        aria-label={i18n.canvasAria}
        role="img"
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
            rungLabel={rungLabel}
            modelNoData={i18n.modelNoData}
            modelError={i18n.modelError}
          />
        </Suspense>
      </Canvas>

      {/* ── a11y text alternative (P6 §4): a keyboard-reachable node list. The
          WebGL canvas is pointer-only; this list lets a keyboard / screen-reader
          user focus any node (same onPick) and read its honest state. Visually
          condensed but never hidden from AT. ──────────────────────────────── */}
      <details className="pointer-events-auto absolute bottom-3 right-3 z-10 max-h-[60%] w-56 max-w-[80vw] overflow-auto rounded-lg bg-black/70 text-xs text-stone-200">
        <summary className="cursor-pointer select-none px-3 py-2 font-medium focus-visible:outline focus-visible:outline-2 focus-visible:outline-orb-peach">
          {i18n.nodelistHeading}
        </summary>
        <ul className="space-y-0.5 px-2 pb-2">
          {RUNG_ORDER.map((r) => {
            const rows = graph.nodes.filter((n) => n.rung === r);
            if (rows.length === 0) return null;
            return (
              <li key={r}>
                <p className="px-1 pt-1 text-[10px] uppercase tracking-wide text-stone-400">
                  {rungLabel[r]}
                </p>
                <ul>
                  {rows.map((n) => {
                    const up = n.name.toUpperCase();
                    const active = focusTarget?.toUpperCase() === up;
                    return (
                      <li key={up}>
                        <button
                          onClick={() => onPick(n.name)}
                          aria-pressed={active}
                          aria-label={`${n.name} — ${i18n.state[n.state]}`}
                          className={
                            "flex w-full items-center gap-1.5 rounded px-1 py-0.5 text-left hover:bg-white/10 focus-visible:outline focus-visible:outline-2 focus-visible:outline-orb-peach " +
                            (active ? "bg-white/15" : "")
                          }
                        >
                          <span aria-hidden>{STATE_BADGE[n.state]}</span>
                          {n.icon && <span aria-hidden>{n.icon}</span>}
                          <span className="font-mono">{n.name}</span>
                        </button>
                      </li>
                    );
                  })}
                </ul>
              </li>
            );
          })}
        </ul>
      </details>
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
      aria-pressed={active}
      className={`rounded-full px-3 py-1 text-xs transition focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-orb-peach ${
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
