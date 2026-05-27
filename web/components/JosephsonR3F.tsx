// JosephsonR3F — real Three.js / R3F implementation of the QUBIT scene.
// Lazy-loaded (next/dynamic, ssr=false) from JosephsonScene to keep the SSR
// boundary clean; CSS-3D path remains as fallback when R3F is unavailable.

"use client";

import { Canvas } from "@react-three/fiber";
import { OrbitControls } from "@react-three/drei";

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
      <meshStandardMaterial color="#f59e0b" roughness={0.4} />
    </mesh>
  );
}

function ReadoutResonator() {
  return (
    <group position={[2.4, 0.6, 0]}>
      <mesh>
        <boxGeometry args={[0.15, 1.6, 0.15]} />
        <meshStandardMaterial color="#3b82f6" />
      </mesh>
      <mesh position={[0, -0.9, 0]}>
        <torusGeometry args={[0.4, 0.07, 16, 32]} />
        <meshStandardMaterial color="#3b82f6" />
      </mesh>
    </group>
  );
}

export function JosephsonR3F() {
  return (
    <Canvas
      camera={{ position: [4, 3, 5], fov: 45 }}
      className="h-full w-full rounded bg-neutral-50 dark:bg-neutral-950"
    >
      <ambientLight intensity={0.45} />
      <directionalLight position={[5, 5, 5]} intensity={0.9} />
      <Pad y={0.55} color="#cbd5e1" />
      <OxideBarrier />
      <Pad y={-0.35} color="#94a3b8" />
      <ReadoutResonator />
      <OrbitControls enablePan={false} enableZoom={true} />
    </Canvas>
  );
}
