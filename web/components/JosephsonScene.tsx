// JosephsonScene — Q14′ QUBIT 데모 entry. Real R3F via lazy client-only import.
// Falls back to the CSS-3D StructureViewer when Three / fiber are unavailable
// (e.g. legacy preview that hasn't run `npm install` after PR#16).

"use client";

import dynamic from "next/dynamic";
import { StructureViewer, type Atom3D } from "./StructureViewer";

const JosephsonR3F = dynamic(
  () => import("./JosephsonR3F").then((m) => ({ default: m.JosephsonR3F })),
  {
    ssr: false,
    loading: () => (
      <div className="grid h-full w-full place-items-center text-xs text-muted">
        🧊 loading 3D…
      </div>
    ),
  },
);

// ElevenLabs 팔레트 (DESIGN_TOKENS.md 동기) — 웜 뉴트럴 + orb-peach 단일 하이라이트.
const FALLBACK_ATOMS: Atom3D[] = [
  { x: 0, y: 1.8, z: 0.2, color: "#d6d3d1" },
  { x: 0, y: 0.8, z: 0.5, color: "#f4c5a8", label: "AlOx" },
  { x: 0, y: -0.2, z: 0.3, color: "#a8a29e" },
  { x: 3.2, y: 1.0, z: 0.3, color: "#292524", label: "readout" },
];

export function JosephsonScene() {
  // R3F path renders client-side; SSR uses CSS-3D fallback so the slot is
  // never empty during first paint. The `data-scene` attribute lets QA
  // conformance scripts confirm the route was hit even when ssr=false hides
  // the underlying R3F module from the SSR HTML stream.
  if (typeof window === "undefined") {
    return (
      <div data-scene="JosephsonScene" data-mode="ssr-fallback" className="h-full w-full">
        <StructureViewer atoms={FALLBACK_ATOMS} caption="QUBIT · CSS-3D SSR" />
      </div>
    );
  }
  return (
    <div data-scene="JosephsonScene" data-mode="r3f" className="h-full w-full">
      <JosephsonR3F />
    </div>
  );
}
