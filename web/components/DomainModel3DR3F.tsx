// DomainModel3DR3F — the real Three.js / R3F renderer for ANY domain model.
// Lazy-loaded (next/dynamic ssr:false) by DomainModel3D so the SSR boundary is
// clean (three never executes server-side). Generalizes JosephsonR3F: instead
// of hardcoded junction meshes, it mounts a `BuiltModel` produced by the
// data-driven builders in lib/geometry-3d (procedural) OR a glb via useGLTF.
//
// Geometry is NEVER inline here (d · @L10) — it arrives as a descriptor.

"use client";

import { Suspense, useMemo } from "react";
import { Canvas } from "@react-three/fiber";
import { OrbitControls, useGLTF } from "@react-three/drei";
import {
  buildProcedural,
  isStylizedDescriptor,
  type Model3DDescriptor,
  type BuiltPart,
} from "@/lib/geometry-3d";
import type { VerifyState } from "@/lib/cosmos";

// ElevenLabs 팔레트 (WebGL material 은 CSS var 을 못 읽어 hex 직접 — JosephsonR3F
// 와 동기). 무채색 웜 뉴트럴 + 단일 파스텔(orb-peach) accent.
const C = {
  node: "#d6d3d1", // hairline-strong (warm stone)
  bond: "#a8a29e", // muted-soft
  cell: "#78716c", // cell edges / substrate
  ring: "#57534e", // rings / resonators
  body: "#292524", // body-strong ink
  accent: "#f4c5a8", // orb-peach — 유일한 컬러 모먼트
  symbol: "#c4b5a5", // muted stylized placeholder
} as const;

// VerifyState → an overall tint multiplier on the accent role + a wireframe
// hint. Faithful (data) models stay neutral+peach; the symbol/stylized state is
// signalled by desaturation (D3 — fidelity itself encodes data-maturity).
const STATE_ACCENT: Record<VerifyState, string> = {
  "verified-formal": "#7fb3d5", // formal blue
  verified: "#86b97a", // verified green
  "needs-verify": "#e8c46a", // amber
  unverified: "#f4c5a8", // peach (neutral / no claim)
  falsified: "#d98a8a", // muted red
};

function roleColor(role: BuiltPart["role"], accent: string): string {
  switch (role) {
    case "accent":
      return accent;
    case "node":
      return C.node;
    case "bond":
      return C.bond;
    case "cell":
      return C.cell;
    case "ring":
      return C.ring;
    case "body":
      return C.body;
    case "symbol":
      return C.symbol;
    default:
      return C.node;
  }
}

// A single procedural part. Cylinders default to a Y-up axis; for "bond" parts
// the builder centres them but does not orient — we keep them as short stubs
// (orientation refinement is out of scope; bonds read as connective accents).
function Part({
  part,
  accent,
  stylized,
}: {
  part: BuiltPart;
  accent: string;
  stylized: boolean;
}) {
  const color = roleColor(part.role, accent);
  const wire = part.role === "cell"; // EdgesGeometry → render as lines
  return (
    <mesh position={part.position} geometry={part.geometry}>
      {wire ? (
        <lineBasicMaterial color={color} />
      ) : (
        <meshStandardMaterial
          color={color}
          roughness={part.role === "accent" ? 0.4 : 0.7}
          transparent={stylized}
          opacity={stylized ? 0.55 : 1}
          wireframe={stylized && part.role === "symbol"}
        />
      )}
    </mesh>
  );
}

function ProceduralModel({
  descriptor,
  state,
}: {
  descriptor: Extract<Model3DDescriptor, { kind: "procedural" }>;
  state?: VerifyState;
}) {
  const model = useMemo(() => buildProcedural(descriptor), [descriptor]);
  const accent = STATE_ACCENT[state ?? "unverified"];
  // Stylized (D3: no faithful numbers) → desaturate + make translucent. Covers
  // both the legacy `symbol` glyph AND rung-typed generic shapes (the `stylized`
  // flag). Faithful descriptors (real params) render solid.
  const stylized = isStylizedDescriptor(descriptor);
  return (
    <group>
      {model.parts.map((part, i) =>
        // EdgesGeometry parts are LineSegments, not meshes — render via a
        // dedicated primitive so three mounts them correctly.
        part.role === "cell" ? (
          <lineSegments key={i} position={part.position} geometry={part.geometry}>
            <lineBasicMaterial color={roleColor("cell", accent)} />
          </lineSegments>
        ) : (
          <Part key={i} part={part} accent={accent} stylized={stylized} />
        ),
      )}
    </group>
  );
}

function GlbModel({ url, state }: { url: string; state?: VerifyState }) {
  const { scene } = useGLTF(url);
  const accent = STATE_ACCENT[state ?? "unverified"];
  // Clone so repeated mounts don't share/mutate the cached scene graph.
  const cloned = useMemo(() => scene.clone(true), [scene]);
  return (
    <group>
      <primitive object={cloned} />
      {/* a tiny accent marker keys the verify-state even on an opaque glb */}
      <mesh position={[0, 0, 0]} visible={false}>
        <meshStandardMaterial color={accent} />
      </mesh>
    </group>
  );
}

export function DomainModel3DR3F({
  descriptor,
  state,
}: {
  descriptor: Model3DDescriptor;
  state?: VerifyState;
}) {
  return (
    <Canvas
      camera={{ position: [4, 3, 5], fov: 45 }}
      className="h-full w-full rounded bg-canvas-soft dark:bg-canvas"
    >
      <ambientLight intensity={0.45} />
      <directionalLight position={[5, 5, 5]} intensity={0.9} />
      <directionalLight position={[-4, 2, -3]} intensity={0.35} />
      <Suspense fallback={null}>
        {descriptor.kind === "glb" ? (
          <GlbModel url={descriptor.url} state={state} />
        ) : (
          <ProceduralModel descriptor={descriptor} state={state} />
        )}
      </Suspense>
      <OrbitControls enablePan={false} enableZoom={true} />
    </Canvas>
  );
}

export default DomainModel3DR3F;
