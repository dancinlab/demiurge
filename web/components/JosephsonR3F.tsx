// JosephsonR3F — real Three.js / R3F implementation of the QUBIT scene.
// Lazy-loaded (next/dynamic, ssr=false) from JosephsonScene to keep the SSR
// boundary clean; CSS-3D path remains as fallback when R3F is unavailable.

"use client";

import { Canvas } from "@react-three/fiber";
import { OrbitControls } from "@react-three/drei";

// ElevenLabs 팔레트 (WebGL material 은 CSS var 을 못 읽어 hex 직접 — DESIGN_TOKENS.md
// 와 동기 유지). 무채색 웜 뉴트럴 + 산화막에만 단일 파스텔(orb-peach) 하이라이트.
const C = {
  padTop: "#d6d3d1", // hairline-strong (warm stone)
  padBottom: "#a8a29e", // muted-soft
  barrier: "#f4c5a8", // orb-peach — 유일한 컬러 모먼트
  resonator: "#292524", // body-strong ink
} as const;

function Pad({ y, color }: { y: number; color: string }) {
  return (
    <mesh position={[0, y, 0]}>
      <boxGeometry args={[3.5, 0.18, 2.2]} />
      <meshStandardMaterial color={color} />
    </mesh>
  );
}

function OxideBarrier() {
  return (
    <mesh position={[0, 0.05, 0]}>
      <cylinderGeometry args={[0.5, 0.5, 0.08, 24]} />
      <meshStandardMaterial color={C.barrier} roughness={0.4} />
    </mesh>
  );
}

function ReadoutResonator() {
  return (
    <group position={[2.4, 0.6, 0]}>
      <mesh>
        <boxGeometry args={[0.15, 1.6, 0.15]} />
        <meshStandardMaterial color={C.resonator} />
      </mesh>
      <mesh position={[0, -0.9, 0]}>
        <torusGeometry args={[0.4, 0.07, 16, 32]} />
        <meshStandardMaterial color={C.resonator} />
      </mesh>
    </group>
  );
}

export function JosephsonR3F() {
  return (
    <Canvas
      camera={{ position: [4, 3, 5], fov: 45 }}
      className="h-full w-full rounded bg-canvas-soft dark:bg-ink"
    >
      <ambientLight intensity={0.45} />
      <directionalLight position={[5, 5, 5]} intensity={0.9} />
      <Pad y={0.55} color={C.padTop} />
      <OxideBarrier />
      <Pad y={-0.35} color={C.padBottom} />
      <ReadoutResonator />
      <OrbitControls enablePan={false} enableZoom={true} />
    </Canvas>
  );
}
