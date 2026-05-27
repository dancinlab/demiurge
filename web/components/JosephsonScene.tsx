// JosephsonScene — Q14′ QUBIT 데모용 Al/AlOx/Al Josephson junction sketch.
// Built on the StructureViewer CSS-3D primitive (no R3F yet — see comment in StructureViewer).
// Layout: two Al pads + thin AlOx barrier + readout coupling capacitor.

import { StructureViewer, type Atom3D } from "./StructureViewer";

function row(z: number, color: string, y: number, count = 6, dx = 0.7): Atom3D[] {
  const half = (count - 1) / 2;
  return Array.from({ length: count }, (_, i) => ({
    x: (i - half) * dx,
    y,
    z,
    color,
  }));
}

const ATOMS: Atom3D[] = [
  // Top Al pad (large island)
  ...row(0.2, "#cbd5e1", 1.8, 8, 0.6),
  ...row(0.4, "#94a3b8", 1.6, 8, 0.6),
  // AlOx barrier (thin · ~2 nm in real life · oxygen ⊕ aluminum)
  ...row(0.5, "#f59e0b", 0.9, 6, 0.5),
  ...row(0.7, "#fbbf24", 0.7, 6, 0.5),
  // Bottom Al pad (capacitor shunt)
  ...row(0.3, "#94a3b8", -0.2, 8, 0.6),
  ...row(0.1, "#cbd5e1", -0.4, 8, 0.6),
  // Readout coupling resonator strip (top-right)
  { x: 3.2, y: 1.5, z: 0.3, color: "#3b82f6", label: "readout" },
  { x: 3.2, y: 1.0, z: 0.3, color: "#3b82f6" },
  { x: 3.2, y: 0.5, z: 0.3, color: "#3b82f6" },
  { x: 3.2, y: 0.0, z: 0.3, color: "#3b82f6" },
];

export function JosephsonScene() {
  return <StructureViewer atoms={ATOMS} caption="QUBIT · Al/AlOx/Al Josephson + readout" />;
}
