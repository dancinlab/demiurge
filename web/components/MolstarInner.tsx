"use client";

// MolstarInner — the actual pdbe-molstar (Mol*) mount (COSMOS.md §9.1b).
//
// Loaded ONLY via MolViewer's `dynamic(ssr:false)` boundary — never imported on
// the server (molstar touches window/WebGL at module scope). It:
//   1. mounts a PDBeMolstarPlugin on a useRef <div> in useEffect,
//   2. feeds the structure from OUR proxy `/api/structure?source=…&id=…`
//      (server-side mmCIF fetch — dodges CORS + caches; pLDDT is in the B-factor
//      column of an AlphaFold mmCIF),
//   3. applies `alphafoldView` (the built-in pLDDT confidence colouring) for an
//      alphafold source, plain cartoon for an experimental pdb source,
//   4. disposes the inner Mol* PluginContext on cleanup (no leaked WebGL context).
//
// We import from `pdbe-molstar/lib/viewer` (NOT the package root) on purpose: the
// root entry pulls a `.scss` import that Next's bundler does not process for a
// dependency. We load the prebuilt CSS via a CDN <link> on mount instead.

import { useEffect, useRef } from "react";

export type MolViewerProps = {
  source: "alphafold" | "pdb" | "pubchem";
  id: string;
};

// The body format Mol* must parse per source: protein folds = mmCIF, small
// molecule (pubchem) = SDF.
function viewerFormat(source: MolViewerProps["source"]): "cif" | "sdf" {
  return source === "pubchem" ? "sdf" : "cif";
}

// Prebuilt pdbe-molstar stylesheet (matches the installed major version). Loaded
// once, lazily, on the client — keeps the controls/canvas styled without routing
// the package's .scss through the Next bundler.
const PDBE_CSS_HREF =
  "https://cdn.jsdelivr.net/npm/pdbe-molstar@3.3.0/build/pdbe-molstar.css";

function ensurePdbeCss(): void {
  if (typeof document === "undefined") return;
  if (document.getElementById("pdbe-molstar-css")) return;
  const link = document.createElement("link");
  link.id = "pdbe-molstar-css";
  link.rel = "stylesheet";
  link.href = PDBE_CSS_HREF;
  document.head.appendChild(link);
}

export default function MolstarInner({ source, id }: MolViewerProps) {
  const containerRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const el = containerRef.current;
    if (!el) return;

    ensurePdbeCss();

    let disposed = false;
    // The plugin instance, captured for cleanup. Typed loosely because we
    // import the module dynamically below (keeps it out of the server graph).
    let viewer: { plugin?: { dispose?: () => void } } | null = null;

    (async () => {
      try {
        const { PDBeMolstarPlugin } = await import("pdbe-molstar/lib/viewer");
        if (disposed) return;
        viewer = new PDBeMolstarPlugin();
        await viewer.render(el, {
          customData: {
            url: `/api/structure?source=${source}&id=${encodeURIComponent(id)}`,
            format: viewerFormat(source),
            binary: false,
          },
          // pLDDT confidence colouring — only meaningful for an AlphaFold model.
          alphafoldView: source === "alphafold",
          bgColor: { r: 22, g: 19, b: 15 }, // match the detail-card #16130f panel
          hideControls: true,
          sequencePanel: false,
          landscape: true,
        });
      } catch (err) {
        // Surface load failures honestly in-canvas rather than crashing the page.
        if (!disposed && el) {
          el.innerHTML =
            '<div style="display:flex;height:100%;align-items:center;justify-content:center;color:#a89f93;font-size:12px;padding:8px;text-align:center">3D 구조를 불러오지 못했습니다.</div>';
        }
        // eslint-disable-next-line no-console
        console.error("[MolstarInner] render failed:", err);
      }
    })();

    return () => {
      disposed = true;
      try {
        viewer?.plugin?.dispose?.();
      } catch {
        /* best-effort cleanup */
      }
    };
  }, [source, id]);

  return (
    <div
      ref={containerRef}
      className="relative h-full w-full"
      role="img"
      aria-label={
        source === "pubchem"
          ? `PubChem CID ${id} 분자 3D 구조`
          : `${id} 단백질 3D 구조 (${source === "alphafold" ? "AlphaFold 예측" : "실험 구조"})`
      }
    />
  );
}
