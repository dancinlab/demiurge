"use client";

// MolViewer — the public entry for the Mol* real-fold viewer (COSMOS.md §9.1b).
//
// Thin wrapper that lazily loads MolstarInner with `ssr: false`. The ssr:false is
// MANDATORY: pdbe-molstar / Mol* touch `window` + WebGL at import time, which would
// crash SSR/static generation of /d/[domain]. Keeping the dynamic import here (in a
// dedicated "use client" boundary) means the server build never evaluates the
// molstar module — only the browser does, after mount.
//
// The detail page renders this ONLY for a node carrying a real `structure` ref
// (facets.uniprot/pdb). All other nodes keep the procedural DomainModel3D.

import dynamic from "next/dynamic";
import type { MolViewerProps } from "./MolstarInner";

const MolstarInner = dynamic(() => import("./MolstarInner"), {
  ssr: false,
  loading: () => (
    <div
      className="flex h-full w-full items-center justify-center text-xs text-muted"
      aria-label="loading 3D structure"
    >
      <span className="animate-pulse">3D 단백질 구조 로딩 중…</span>
    </div>
  ),
});

export function MolViewer(props: MolViewerProps) {
  return <MolstarInner {...props} />;
}

export type { MolViewerProps };
