// DomainModel3D — the GENERIC, SSR-safe 3D model surface for ANY domain.
//
// Generalizes the JosephsonScene pattern: a `next/dynamic` ssr:false R3F
// renderer (DomainModel3DR3F) with a CSS-3D fallback for SSR / pre-install.
// Props are `{ domain, descriptor?, state? }`:
//   - `descriptor` supplied (e.g. resolved server-side) → render it directly.
//   - else resolve client-side via loadDescriptorClient (file → procedural →
//     symbol fallback chain in lib/geometry-3d).
// Geometry is data-driven (descriptor) — NEVER hardcoded per domain (d · @L10).

"use client";

import { useEffect, useState } from "react";
import dynamic from "next/dynamic";
import {
  isStylizedDescriptor,
  loadDescriptorClient,
  type Model3DDescriptor,
} from "@/lib/geometry-3d";
import type { Rung, VerifyState } from "@/lib/cosmos";
import { StructureViewer, type Atom3D } from "./StructureViewer";

const DomainModel3DR3F = dynamic(
  () => import("./DomainModel3DR3F").then((m) => ({ default: m.DomainModel3DR3F })),
  {
    ssr: false,
    loading: () => (
      <div className="grid h-full w-full place-items-center text-xs text-muted">
        🧊 loading 3D…
      </div>
    ),
  },
);

export type DomainModel3DProps = {
  domain: string;
  /** pre-resolved descriptor (server-side); else resolved client-side. */
  descriptor?: Model3DDescriptor;
  /** rung hint for the fallback derivation when no descriptor is passed. */
  rung?: Rung;
  /** domain goal text — feeds keyword-based procedural derivation. */
  goal?: string | null;
  /** verify state → tints/badges the model (faithful vs stylized per D3). */
  state?: VerifyState;
  /** override the `data-scene` marker (legacy compat, e.g. "JosephsonScene"). */
  sceneName?: string;
  /** D3 honesty badge copy — shown when the model is a stylized symbol (no real
   *  geometry data) so the user is never misled into reading it as faithful.
   *  i18n-resolved by the parent; falls back to a neutral default. */
  noDataLabel?: string;
  /** copy shown if the (glb) model errors out while loading. */
  errorLabel?: string;
};

// A coarse CSS-3D fallback: project a descriptor (or a default) to a few atoms
// so the SSR HTML / pre-install path still paints SOMETHING domain-shaped.
function fallbackAtoms(descriptor?: Model3DDescriptor): Atom3D[] {
  const accent = "#f4c5a8";
  const stone = "#d6d3d1";
  const ink = "#a8a29e";
  if (descriptor?.kind === "procedural") {
    if (descriptor.shape === "lattice" || descriptor.shape === "supercell") {
      return [
        { x: -1, y: 1, z: 0.2, color: stone },
        { x: 1, y: 1, z: 0.4, color: stone },
        { x: 0, y: 0, z: 0.5, color: accent, label: descriptor.shape },
        { x: -1, y: -1, z: 0.2, color: ink },
        { x: 1, y: -1, z: 0.3, color: ink },
      ];
    }
    if (descriptor.shape === "orbit" || descriptor.shape === "throat") {
      return [
        { x: 0, y: 0, z: 0.5, color: ink, label: descriptor.shape },
        { x: 2, y: 0, z: 0.3, color: accent },
        { x: -2, y: 0, z: 0.3, color: accent },
        { x: 0, y: 2, z: 0.2, color: stone },
      ];
    }
  }
  return [
    { x: 0, y: 1, z: 0.3, color: stone },
    { x: 0, y: 0, z: 0.5, color: accent, label: "symbol" },
    { x: 0, y: -1, z: 0.3, color: ink },
  ];
}

// A resolved descriptor is "stylized" (D3: no faithful geometry data) when it is
// the symbol placeholder OR a rung-typed generic shape carrying the `stylized`
// flag (helix/molecule/die/coil derived purely from the rung, no real numbers).
// Both cases must show the ⚪ "데이터 없음 / 검증필요" badge. Delegated to the
// single source of truth in lib/geometry-3d.
function isStylized(d?: Model3DDescriptor): boolean {
  return isStylizedDescriptor(d);
}

export function DomainModel3D({
  domain,
  descriptor,
  rung,
  goal,
  state,
  sceneName = "DomainModel3D",
  noDataLabel,
  errorLabel,
}: DomainModel3DProps) {
  const [resolved, setResolved] = useState<Model3DDescriptor | undefined>(
    descriptor,
  );
  const [loadFailed, setLoadFailed] = useState(false);

  // Client-side descriptor resolution when none was supplied as a prop.
  useEffect(() => {
    if (descriptor) {
      setResolved(descriptor);
      return;
    }
    let live = true;
    setLoadFailed(false);
    loadDescriptorClient({ name: domain, rung, goal })
      .then((d) => {
        if (live) setResolved(d);
      })
      .catch(() => {
        /* keep undefined → fallback symbol via R3F default */
        if (live) setLoadFailed(true);
      });
    return () => {
      live = false;
    };
  }, [domain, descriptor, rung, goal]);

  // SSR / first paint: CSS-3D fallback so the slot is never empty (mirrors
  // JosephsonScene). `data-scene` lets QA confirm the route was hit.
  if (typeof window === "undefined") {
    return (
      <div
        data-scene={sceneName}
        data-domain={domain}
        data-mode="ssr-fallback"
        className="h-full w-full"
      >
        <StructureViewer
          atoms={fallbackAtoms(descriptor)}
          caption={`${domain} · CSS-3D SSR`}
        />
      </div>
    );
  }

  // Client: real R3F once a descriptor is resolved; CSS-3D until then.
  // D3 honesty: a stylized symbol fallback (or a load failure) is badged so the
  // user is never misled into reading a placeholder as faithful geometry.
  const stylized = isStylized(resolved);
  return (
    <div
      data-scene={sceneName}
      data-domain={domain}
      data-mode={loadFailed ? "error" : resolved ? "r3f" : "resolving"}
      className="relative h-full w-full"
    >
      {resolved ? (
        <DomainModel3DR3F descriptor={resolved} state={state} />
      ) : (
        <StructureViewer
          atoms={fallbackAtoms(descriptor)}
          caption={`${domain} · resolving…`}
        />
      )}
      {loadFailed && errorLabel && (
        <span className="pointer-events-none absolute left-2 top-2 rounded bg-danger/80 px-1.5 py-0.5 text-[10px] font-medium text-white">
          ⚠ {errorLabel}
        </span>
      )}
      {!loadFailed && stylized && noDataLabel && (
        <span className="pointer-events-none absolute left-2 top-2 rounded bg-black/55 px-1.5 py-0.5 text-[10px] text-stone-200">
          ⚪ {noDataLabel}
        </span>
      )}
    </div>
  );
}

export default DomainModel3D;
