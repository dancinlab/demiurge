// DomainModel3DR3F — the real Three.js / R3F renderer for ANY domain model.
// Lazy-loaded (next/dynamic ssr:false) by DomainModel3D so the SSR boundary is
// clean (three never executes server-side). Generalizes JosephsonR3F: instead
// of hardcoded junction meshes, it mounts a `BuiltModel` produced by the
// data-driven builders in lib/geometry-3d (procedural) OR a glb via useGLTF.
//
// Geometry is NEVER inline here (d · @L10) — it arrives as a descriptor. The
// SCENE (lighting · IBL · shadows · tone-map · framing) lives here, and parts
// may carry optional MATERIAL HINTS (color/material/opacity/renderOrder…) so a
// faithful model (the RTSC-solenoid-grade coil) reaches "look good" quality
// WITHOUT the renderer ever branching on a domain name.

"use client";

import { Suspense, useMemo, useRef, useState } from "react";
import * as THREE from "three";
import { Canvas } from "@react-three/fiber";
import {
  OrbitControls,
  useGLTF,
  Environment,
  ContactShadows,
  Bounds,
  Center,
  MeshTransmissionMaterial,
  AdaptiveDpr,
} from "@react-three/drei";
import {
  buildProcedural,
  isStylizedDescriptor,
  type Model3DDescriptor,
  type BuiltPart,
} from "@/lib/geometry-3d";
import type { VerifyState } from "@/lib/cosmos";

// ElevenLabs 팔레트 (WebGL material 은 CSS var 을 못 읽어 hex 직접 — JosephsonR3F
// 와 동기). 무채색 웜 뉴트럴 + 단일 파스텔(orb-peach) accent. Used ONLY when a
// part carries no explicit `color` hint (legacy role-palette fallback).
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

// One procedural part → a mesh. Reads optional MATERIAL HINTS from the part
// (data-driven), falling back to the role palette. Three material tiers:
//   standard    → opaque metal (winding · pads · bonds)
//   physical    → translucent/clearcoat shells + glossy atoms (cheap)
//   transmission→ ONE hero glass shell (drei MeshTransmissionMaterial, FBO cost)
function Part({
  part,
  accent,
  stylized,
}: {
  part: BuiltPart;
  accent: string;
  stylized: boolean;
}) {
  const baseColor = part.color ?? roleColor(part.role, accent);
  const wire = part.role === "cell" && !part.color; // legacy EdgesGeometry → lines

  const quaternion = useMemo(
    () =>
      part.quaternion ? new THREE.Quaternion(...part.quaternion) : undefined,
    [part.quaternion],
  );
  const scale = part.scale;

  // stylized desaturation (D3) applies ONLY to legacy hint-less parts; a faithful
  // part that explicitly carries opacity/material keeps its authored look.
  const transparent = part.transparent ?? (stylized && !part.color);
  const opacity = part.opacity ?? (stylized && !part.color ? 0.55 : 1);

  if (wire) {
    // legacy edge/line part (EdgesGeometry) — render as line segments.
    return (
      <lineSegments position={part.position} geometry={part.geometry}>
        <lineBasicMaterial color={baseColor} />
      </lineSegments>
    );
  }

  const mat = part.material ?? (stylized && !part.color ? "standard" : "standard");
  const castShadow = !transparent;
  const receiveShadow = !transparent;

  return (
    <mesh
      position={part.position}
      quaternion={quaternion}
      scale={scale}
      geometry={part.geometry}
      renderOrder={part.renderOrder ?? 0}
      castShadow={castShadow}
      receiveShadow={receiveShadow}
    >
      {mat === "transmission" ? (
        // ONE hero glass shell (cryostat OVC). Cheap-ish samples/resolution.
        <MeshTransmissionMaterial
          samples={6}
          resolution={256}
          backside
          transmission={0.92}
          thickness={0.6}
          roughness={0.18}
          ior={1.25}
          chromaticAberration={0.02}
          color={baseColor}
          transparent
          opacity={opacity}
          depthWrite={false}
          side={THREE.DoubleSide}
        />
      ) : mat === "physical" ? (
        <meshPhysicalMaterial
          color={baseColor}
          metalness={part.metalness ?? (part.role === "accent" ? 0.5 : 0.2)}
          roughness={part.roughness ?? 0.4}
          clearcoat={part.clearcoat ?? 0}
          clearcoatRoughness={0.3}
          transmission={part.transmission ?? 0}
          emissive={part.emissive ?? "#000000"}
          emissiveIntensity={part.emissiveIntensity ?? 0}
          transparent={transparent}
          opacity={opacity}
          depthWrite={part.depthWrite ?? !transparent}
          side={part.doubleSide ? THREE.DoubleSide : THREE.FrontSide}
          vertexColors={!!part.geometry.getAttribute("color")}
        />
      ) : (
        <meshStandardMaterial
          color={baseColor}
          metalness={part.metalness ?? (part.role === "accent" ? 0.3 : 0.1)}
          roughness={part.roughness ?? (part.role === "accent" ? 0.4 : 0.6)}
          emissive={part.emissive ?? "#000000"}
          emissiveIntensity={part.emissiveIntensity ?? 0}
          transparent={transparent}
          opacity={opacity}
          depthWrite={part.depthWrite ?? !transparent}
          side={part.doubleSide ? THREE.DoubleSide : THREE.FrontSide}
          wireframe={stylized && part.role === "symbol" && !part.color}
          vertexColors={!!part.geometry.getAttribute("color")}
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
      {model.parts.map((part, i) => (
        <Part key={i} part={part} accent={accent} stylized={stylized} />
      ))}
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
  // hover-gated autoRotate: with frameloop="demand" + many cards on /sample, an
  // off-screen / unhovered card costs ~0 (no rAF loop). Hovering re-enables the
  // continuous spin (and the demand loop) only for the focused card.
  const [hovered, setHovered] = useState(false);

  return (
    <Canvas
      dpr={[1, 1.5]}
      shadows
      gl={{ antialias: true, alpha: true }}
      camera={{ fov: 35, position: [3, 2, 4] }}
      frameloop="demand"
      className="h-full w-full rounded bg-canvas-soft dark:bg-canvas"
      onPointerEnter={() => setHovered(true)}
      onPointerLeave={() => setHovered(false)}
    >
      <AdaptiveDpr pixelated />
      {/* key + fill + ambient (recipe). Key casts shadows. */}
      <ambientLight intensity={0.35} />
      <directionalLight
        position={[5, 8, 5]}
        intensity={1.4}
        castShadow
        shadow-mapSize={[1024, 1024]}
        shadow-bias={-0.0002}
      />
      <directionalLight position={[-4, 2, -3]} intensity={0.5} />

      <Suspense fallback={null}>
        {/* clean neutral metal reflections on dark; do NOT set as background */}
        <Environment preset="studio" environmentIntensity={0.8} />
        <Bounds fit clip observe margin={1.2}>
          <Center>
            {descriptor.kind === "glb" ? (
              <GlbModel url={descriptor.url} state={state} />
            ) : (
              <ProceduralModel descriptor={descriptor} state={state} />
            )}
          </Center>
        </Bounds>
      </Suspense>

      <ContactShadows
        position={[0, -1, 0]}
        opacity={0.55}
        scale={8}
        blur={2.6}
        far={4}
        resolution={512}
      />

      <OrbitControls
        enableDamping
        dampingFactor={0.08}
        enablePan={false}
        enableZoom
        autoRotate={hovered}
        autoRotateSpeed={0.6}
      />
    </Canvas>
  );
}

export default DomainModel3DR3F;
