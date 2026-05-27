// StructureViewer — Q6 R3F slot.
// Real React-Three-Fiber wiring lives behind dynamic import to keep zero
// npm install in this PR (R3F + three packages added in a follow-up).
// Until then this is a CSS-3D placeholder that *looks* 3D (rotates on hover)
// so the slot is visually present from PR#5 onward.

"use client";

export type Atom3D = {
  x: number;
  y: number;
  z: number;
  color: string;
  label?: string;
};

export function StructureViewer({
  atoms,
  caption,
}: {
  atoms: Atom3D[];
  caption?: string;
}) {
  // CSS-3D projection — placeholder until R3F is npm-installed.
  // Each atom -> absolute-positioned circle; depth via z-scaled size + opacity.
  const ATOM_SCALE = 22;
  const Z_SCALE = 8;
  const projected = atoms
    .slice()
    .sort((a, b) => a.z - b.z)
    .map((a, i) => {
      const size = ATOM_SCALE + a.z * Z_SCALE;
      const op = 0.55 + Math.min(0.45, Math.max(0, (a.z + 2) / 6));
      return { ...a, size, op, i };
    });

  return (
    <div className="relative h-full w-full overflow-hidden rounded bg-neutral-50 dark:bg-neutral-950">
      {projected.map((a) => (
        <div
          key={a.i}
          title={a.label}
          className="absolute -translate-x-1/2 -translate-y-1/2 rounded-full border border-neutral-700/40 shadow"
          style={{
            left: `${50 + a.x * 8}%`,
            top: `${50 - a.y * 8}%`,
            width: `${a.size}px`,
            height: `${a.size}px`,
            background: a.color,
            opacity: a.op,
          }}
        />
      ))}
      {caption && (
        <div className="absolute bottom-2 left-2 rounded bg-white/80 px-2 py-0.5 text-xs text-neutral-700 dark:bg-neutral-800/80 dark:text-neutral-200">
          🧊 {caption}
        </div>
      )}
    </div>
  );
}
