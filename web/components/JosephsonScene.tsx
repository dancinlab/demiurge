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
      <div className="grid h-full w-full place-items-center text-xs text-neutral-500">
        🧊 loading 3D…
      </div>
    ),
  },
);

const FALLBACK_ATOMS: Atom3D[] = [
  { x: 0, y: 1.8, z: 0.2, color: "#cbd5e1" },
  { x: 0, y: 0.8, z: 0.5, color: "#f59e0b", label: "AlOx" },
  { x: 0, y: -0.2, z: 0.3, color: "#94a3b8" },
  { x: 3.2, y: 1.0, z: 0.3, color: "#3b82f6", label: "readout" },
];

export function JosephsonScene() {
  // R3F path renders client-side; SSR uses CSS-3D fallback so the slot is
  // never empty during first paint.
  if (typeof window === "undefined") {
    return <StructureViewer atoms={FALLBACK_ATOMS} caption="QUBIT · CSS-3D SSR" />;
  }
  return <JosephsonR3F />;
}
