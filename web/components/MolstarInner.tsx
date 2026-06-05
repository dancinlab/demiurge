"use client";

// MolViewerInner — the 3Dmol.js structure mount (COSMOS.md §9.1b).
//
// Loaded ONLY via MolViewer's `dynamic(ssr:false)` boundary — never imported on
// the server (3Dmol touches window/WebGL at module scope). It:
//   1. creates a $3Dmol viewer on a useRef <div> in useEffect,
//   2. feeds the structure from OUR proxy `/api/structure?source=…&id=…`
//      (server-side mmCIF / SDF fetch — dodges CORS + caches),
//   3. styles per source: alphafold → cartoon coloured by B-factor (pLDDT
//      confidence) · pdb → cartoon spectrum · pubchem → ball-and-stick molecule,
//   4. clears the viewer/canvas on cleanup (no leaked WebGL context).
//
// We use 3Dmol.js (BSD-3) instead of pdbe-molstar/Mol*: Mol* pulls
// molstar → h264-mp4-encoder, whose bare `require("fs")` breaks the Next/Turbopack
// production build. 3Dmol has no such transitive dep and loads PDB/mmCIF + SDF.

import { useEffect, useRef } from "react";

export type MolViewerProps = {
  source: "alphafold" | "pdb" | "pubchem";
  id: string;
};

// The body format 3Dmol must parse per source: protein folds = mmCIF, small
// molecule (pubchem) = SDF.
function viewerFormat(source: MolViewerProps["source"]): "cif" | "sdf" {
  return source === "pubchem" ? "sdf" : "cif";
}

export default function MolstarInner({ source, id }: MolViewerProps) {
  const containerRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const el = containerRef.current;
    if (!el) return;

    let disposed = false;
    // The viewer instance, captured for cleanup. Typed loosely — the module is
    // imported dynamically below (keeps it out of the server graph).
    let viewer: { clear?: () => void } | null = null;

    (async () => {
      try {
        // 3dmol's package main is a UMD build; default-or-namespace interop.
        const mod = (await import("3dmol")) as unknown as Record<string, unknown>;
        const $3Dmol = (mod.default ?? mod) as {
          createViewer: (el: HTMLElement, cfg: Record<string, unknown>) => {
            addModel: (data: string, fmt: string) => void;
            setStyle: (sel: Record<string, unknown>, style: Record<string, unknown>) => void;
            zoomTo: () => void;
            render: () => void;
            clear: () => void;
            resize: () => void;
          };
        };
        if (disposed) return;

        // Source URLs. For pubchem, prefer a COMMITTED static SDF
        // (`/structures/pubchem-<CID>.sdf`) so production never depends on the
        // PubChem PUG REST endpoint — which 503-rate-limits Cloud Run's shared
        // egress IP. Fall back to the /api/structure proxy for un-committed CIDs.
        const proxyUrl = `/api/structure?source=${source}&id=${encodeURIComponent(id)}`;
        let res: Response;
        if (source === "pubchem") {
          res = await fetch(`/structures/pubchem-${encodeURIComponent(id)}.sdf`);
          if (!res.ok) res = await fetch(proxyUrl);
        } else {
          res = await fetch(proxyUrl);
        }
        if (!res.ok) throw new Error(`structure fetch ${res.status}`);
        const data = await res.text();
        if (disposed) return;

        const v = $3Dmol.createViewer(el, { backgroundColor: 0x16130f });
        viewer = v;
        v.addModel(data, viewerFormat(source));
        if (source === "pubchem") {
          // small molecule — ball-and-stick.
          v.setStyle({}, { stick: { radius: 0.15 }, sphere: { scale: 0.28 } });
        } else if (source === "alphafold") {
          // colour the cartoon by B-factor = pLDDT confidence (high→blue).
          v.setStyle(
            {},
            { cartoon: { colorscheme: { prop: "b", gradient: "roygb", min: 50, max: 90 } } },
          );
        } else {
          // experimental fold — rainbow spectrum cartoon.
          v.setStyle({}, { cartoon: { color: "spectrum" } });
        }
        v.zoomTo();
        v.render();
        v.resize();
      } catch (err) {
        // Surface load failures honestly in-canvas rather than crashing the page.
        if (!disposed && el) {
          el.innerHTML =
            '<div style="display:flex;height:100%;align-items:center;justify-content:center;color:#a89f93;font-size:12px;padding:8px;text-align:center">3D 구조를 불러오지 못했습니다.</div>';
        }
        // eslint-disable-next-line no-console
        console.error("[MolViewerInner] render failed:", err);
      }
    })();

    return () => {
      disposed = true;
      try {
        viewer?.clear?.();
        if (el) el.innerHTML = "";
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
