// geometry-3d.ts — the per-domain 3D descriptor + procedural builder layer.
//
// HARD RULE (8VERB §5.1 · D5 · d "별도파일" · @L10): geometry is EXTERNAL DATA,
// never hardcoded inline for a specific domain. A domain resolves to a
// `Model3DDescriptor` (this module), which a generic R3F component
// (DomainModel3D) turns into meshes. Resolution priority (D5):
//
//   (1) external descriptor file  web/public/models/<DOMAIN>/model.3d.json
//   (2) procedural params derived from the domain doc / cosmos node
//   (3) stylized symbol placeholder keyed off the node's rung (D3 hybrid)
//
// This file is PURE (no JSX, no three import that breaks SSR — only the
// `three` math/geometry classes, which are import-safe on the server). The
// builders return three.js BufferGeometry / Group-param structures so the
// component layer just mounts them. Geometry NUMBERS come from the
// descriptor/params — never a `if (domain === "HEX-N6")` branch (d4).

import * as THREE from "three";
import type { Rung } from "@/lib/cosmos";

// ── descriptor union ─────────────────────────────────────────────────────────
// `procedural` → a named generic shape + a flat param bag (the EXTERNAL numbers).
// `glb`        → a loaded mesh asset (heavy / hand-made) via drei useGLTF.
export type ProceduralShape =
  | "lattice"
  | "supercell"
  | "metacell"
  | "orbit"
  | "throat"
  | "junction"
  | "symbol";

export type ProceduralDescriptor = {
  kind: "procedural";
  shape: ProceduralShape;
  params: Record<string, number | string>;
  /** optional human label surfaced in the viewer caption. */
  label?: string;
};

export type GlbDescriptor = {
  kind: "glb";
  url: string;
  label?: string;
};

export type Model3DDescriptor = ProceduralDescriptor | GlbDescriptor;

// A minimal view of a cosmos node — enough to derive a fallback descriptor
// without importing the full graph builder (keeps this module lightweight and
// usable from both server and client).
export type DescriptorSource = {
  name: string;
  rung?: Rung;
  goal?: string | null;
};

// ── (1) external descriptor file ─────────────────────────────────────────────
// web/public/models/<DOMAIN>/model.3d.json — the priority-1 external data file.
// The SERVER-side disk read of this file lives in geometry-3d.server.ts (it
// pulls node:fs + data-root, which must NOT enter the client bundle). The
// CLIENT path fetches the same file over HTTP via loadDescriptorClient below.

// Type-narrow + sanity a parsed JSON blob into a Model3DDescriptor (or null).
export function validateDescriptor(d: unknown): Model3DDescriptor | null {
  if (!d || typeof d !== "object") return null;
  const o = d as Record<string, unknown>;
  if (o.kind === "glb") {
    return typeof o.url === "string"
      ? { kind: "glb", url: o.url, label: asString(o.label) }
      : null;
  }
  if (o.kind === "procedural") {
    const shape = o.shape;
    if (!isShape(shape)) return null;
    const params =
      o.params && typeof o.params === "object"
        ? (o.params as Record<string, number | string>)
        : {};
    return { kind: "procedural", shape, params, label: asString(o.label) };
  }
  return null;
}

function isShape(s: unknown): s is ProceduralShape {
  return (
    s === "lattice" ||
    s === "supercell" ||
    s === "metacell" ||
    s === "orbit" ||
    s === "throat" ||
    s === "junction" ||
    s === "symbol"
  );
}

function asString(v: unknown): string | undefined {
  return typeof v === "string" ? v : undefined;
}

// ── (2) procedural params derived from the domain doc / node ──────────────────
// A small, GENERIC derivation table: rung → default shape, with a few
// well-known parametric domains seeded from published lattice numbers. This is
// the FALLBACK when no external file exists; the external file (1) always wins,
// so any of these can be overridden by dropping a model.3d.json. The numbers
// here are still "data" (a default param bag), not inline geometry in the
// renderer — the builders never see a domain name.
const DERIVED_PARAMS: Record<string, ProceduralDescriptor> = {
  // HEX-N6 honeycomb lattice from the σ·τ·φ identity (σ=12·τ=4·φ=2).
  "HEX-N6": {
    kind: "procedural",
    shape: "lattice",
    params: { sigma: 12, tau: 4, phi: 2, rings: 2, a: 1 },
    label: "n=6 honeycomb (σ·τ·φ)",
  },
  // RTSC superhydride cubic supercell (Im-3m H₃X family · a≈3.6 Å scaled).
  RTSC: {
    kind: "procedural",
    shape: "supercell",
    params: { a: 3.6, b: 3.6, c: 3.6, nx: 2, ny: 2, nz: 2 },
    label: "H₃X cubic supercell",
  },
  // QUBIT Josephson junction — de-hardcoded from JosephsonR3F into a descriptor.
  QUBIT: {
    kind: "procedural",
    shape: "junction",
    params: { padW: 3.5, padH: 0.18, padD: 2.2, gap: 0.9, barrierR: 0.5, barrierH: 0.08 },
    label: "Josephson junction",
  },
};

// Accessor for a registered procedural descriptor by domain name (the single
// source for the QUBIT junction params — so JosephsonScene does NOT re-hardcode
// geometry). Returns a fresh copy. Falls back to a junction default for QUBIT.
export function registeredDescriptor(domain: string): ProceduralDescriptor | null {
  const d = DERIVED_PARAMS[domain.toUpperCase()];
  return d ? { ...d, params: { ...d.params } } : null;
}

export function qubitDescriptor(): ProceduralDescriptor {
  return (
    registeredDescriptor("QUBIT") ?? {
      kind: "procedural",
      shape: "junction",
      params: { padW: 3.5, padH: 0.18, padD: 2.2, gap: 0.9, barrierR: 0.5, barrierH: 0.08 },
      label: "Josephson junction",
    }
  );
}

// Rung → a generic default shape when nothing more specific is known.
const RUNG_DEFAULT_SHAPE: Record<Rung, ProceduralShape> = {
  atom: "lattice",
  materials: "supercell",
  chip: "metacell",
  system: "orbit",
};

function deriveProcedural(src: DescriptorSource): ProceduralDescriptor {
  const up = src.name.toUpperCase();
  if (DERIVED_PARAMS[up]) return DERIVED_PARAMS[up];

  // A couple of generic goal-keyword hints (still manifest-free of names).
  const goal = (src.goal ?? "").toLowerCase();
  if (/throat|wormhole|metric|surface.?of.?revolution/.test(goal)) {
    return {
      kind: "procedural",
      shape: "throat",
      params: { b0: 1, height: 4, segments: 48 },
    };
  }
  if (/orbit|trap|loop|ring/.test(goal)) {
    return { kind: "procedural", shape: "orbit", params: { radius: 2, bodies: 3 } };
  }

  const rung = src.rung ?? "materials";
  const shape = RUNG_DEFAULT_SHAPE[rung];
  // Sensible default params per shape (still data, not renderer-inline).
  const params: Record<string, number | string> =
    shape === "lattice"
      ? { sigma: 6, tau: 4, phi: 2, rings: 1, a: 1 }
      : shape === "supercell"
        ? { a: 3, b: 3, c: 3, nx: 1, ny: 1, nz: 1 }
        : shape === "metacell"
          ? { ring: 1, gap: 0.2, splits: 2, depth: 0.2 }
          : { radius: 2, bodies: 3 };
  return { kind: "procedural", shape, params };
}

// ── (3) stylized symbol placeholder (D3 hybrid — no data → honest stub) ───────
function symbolDescriptor(rung: Rung): ProceduralDescriptor {
  const RUNG_NUM: Record<Rung, number> = {
    atom: 0,
    materials: 1,
    chip: 2,
    system: 3,
  };
  return {
    kind: "procedural",
    shape: "symbol",
    params: { rung: RUNG_NUM[rung] },
    label: "stylized symbol (데이터 없음 / 검증필요)",
  };
}

// ── derivation fallback (steps 2→3, shared by server + client resolvers) ──────
// Given NO external descriptor, derive a procedural one from params/rung, else
// drop to the honest symbol. Pure — no I/O. The server (geometry-3d.server.ts)
// and client (loadDescriptorClient) resolvers both call this after their own
// external-file lookup (disk vs HTTP).
export function deriveDescriptor(src: DescriptorSource): Model3DDescriptor {
  const up = src.name.toUpperCase();
  if (DERIVED_PARAMS[up] || src.rung) return deriveProcedural(src);
  return symbolDescriptor(src.rung ?? "materials");
}

// CLIENT path — fetch the public descriptor over HTTP, fall back to derived /
// symbol. Pure browser-safe (no node imports). The SERVER resolver lives in
// geometry-3d.server.ts (disk read + this same derivation fallback).
export async function loadDescriptorClient(
  src: DescriptorSource,
): Promise<Model3DDescriptor> {
  try {
    const res = await fetch(
      `/models/${encodeURIComponent(src.name.toUpperCase())}/model.3d.json`,
      { cache: "force-cache" },
    );
    if (res.ok) {
      const parsed = validateDescriptor(await res.json());
      if (parsed) return parsed;
    }
  } catch {
    // ignore — fall through to derivation
  }
  return deriveDescriptor(src);
}

// ── procedural geometry BUILDERS ─────────────────────────────────────────────
// Each returns a `BuiltModel` — a flat list of primitive parts the renderer
// mounts (position + a geometry + a semantic role for tinting). NO JSX, NO
// per-domain branching: a builder reads ONLY its param bag. This keeps the
// renderer dumb and the geometry 100% data-driven.

export type BuiltPart = {
  /** geometry to render (three.js BufferGeometry). */
  geometry: THREE.BufferGeometry;
  position: [number, number, number];
  /** semantic role → the renderer maps it to a palette slot. */
  role: "node" | "bond" | "cell" | "ring" | "body" | "accent" | "symbol";
  /** optional per-part scalar (e.g. emphasise an accent). */
  emphasis?: number;
};

export type BuiltModel = {
  parts: BuiltPart[];
  /** suggested camera framing radius (for fit-to-view). */
  bound: number;
  label?: string;
};

function num(params: Record<string, number | string>, key: string, dflt: number): number {
  const v = params[key];
  return typeof v === "number" ? v : typeof v === "string" && v !== "" && !isNaN(Number(v)) ? Number(v) : dflt;
}

// buildLattice — honeycomb / hexagonal lattice from σ·τ·φ (or generic counts).
// σ drives the in-plane node count density, φ the number of layers (bilayer
// when φ=2), τ a ring-spacing scale. Geometry is generated, not stored.
export function buildLattice(params: Record<string, number | string>): BuiltModel {
  const sigma = num(params, "sigma", 6);
  const phi = Math.max(1, Math.round(num(params, "phi", 1)));
  const rings = Math.max(1, Math.round(num(params, "rings", 1)));
  const a = num(params, "a", 1);

  const parts: BuiltPart[] = [];
  const nodeGeo = new THREE.SphereGeometry(0.16 * a, 16, 16);
  const layerGap = a * 1.2;

  // hex grid points out to `rings` rings; node radius hints scale with σ.
  const pts: Array<[number, number]> = [];
  for (let q = -rings; q <= rings; q++) {
    for (let r = -rings; r <= rings; r++) {
      if (Math.abs(q + r) > rings) continue;
      const x = a * 1.5 * q;
      const y = a * Math.sqrt(3) * (r + q / 2);
      pts.push([x, y]);
    }
  }
  const accentEvery = Math.max(2, Math.round(sigma / 3)); // σ-driven accenting
  for (let layer = 0; layer < phi; layer++) {
    const z = (layer - (phi - 1) / 2) * layerGap;
    pts.forEach(([x, y], i) => {
      parts.push({
        geometry: nodeGeo,
        position: [x, y, z],
        role: i % accentEvery === 0 ? "accent" : "node",
      });
    });
  }

  // nearest-neighbour bonds within a layer (thin cylinders).
  const bondGeo = new THREE.CylinderGeometry(0.03 * a, 0.03 * a, 1, 8);
  for (let layer = 0; layer < phi; layer++) {
    const z = (layer - (phi - 1) / 2) * layerGap;
    for (let i = 0; i < pts.length; i++) {
      for (let j = i + 1; j < pts.length; j++) {
        const dx = pts[i][0] - pts[j][0];
        const dy = pts[i][1] - pts[j][1];
        const d = Math.hypot(dx, dy);
        if (d < a * 1.8 && d > 1e-6) {
          parts.push({
            geometry: bondGeo,
            position: [(pts[i][0] + pts[j][0]) / 2, (pts[i][1] + pts[j][1]) / 2, z],
            role: "bond",
          });
        }
      }
    }
  }

  const bound = a * 1.6 * (rings + 1);
  return { parts, bound };
}

// buildSupercell — a cubic supercell of nx·ny·nz cells (lattice consts a,b,c).
// Corner + body-centred atoms (Im-3m style); generic to any cubic family.
export function buildSupercell(params: Record<string, number | string>): BuiltModel {
  const a = num(params, "a", 3);
  const b = num(params, "b", a);
  const c = num(params, "c", a);
  const nx = Math.max(1, Math.round(num(params, "nx", 1)));
  const ny = Math.max(1, Math.round(num(params, "ny", 1)));
  const nz = Math.max(1, Math.round(num(params, "nz", 1)));
  const scale = 1 / a; // normalise so a≈1 unit visually

  const parts: BuiltPart[] = [];
  const cornerGeo = new THREE.SphereGeometry(0.18, 16, 16);
  const centreGeo = new THREE.SphereGeometry(0.12, 16, 16);
  const ox = ((nx * a) / 2) * scale;
  const oy = ((ny * b) / 2) * scale;
  const oz = ((nz * c) / 2) * scale;

  for (let i = 0; i <= nx; i++) {
    for (let j = 0; j <= ny; j++) {
      for (let k = 0; k <= nz; k++) {
        parts.push({
          geometry: cornerGeo,
          position: [i * a * scale - ox, j * b * scale - oy, k * c * scale - oz],
          role: "node",
        });
      }
    }
  }
  // body-centred accent atoms (the X / H₃ guest)
  for (let i = 0; i < nx; i++) {
    for (let j = 0; j < ny; j++) {
      for (let k = 0; k < nz; k++) {
        parts.push({
          geometry: centreGeo,
          position: [
            (i + 0.5) * a * scale - ox,
            (j + 0.5) * b * scale - oy,
            (k + 0.5) * c * scale - oz,
          ],
          role: "accent",
        });
      }
    }
  }
  // cell-edge wireframe via thin bonds along x of the outer box
  const boxGeo = new THREE.BoxGeometry(nx * a * scale, ny * b * scale, nz * c * scale);
  const edges = new THREE.EdgesGeometry(boxGeo);
  parts.push({ geometry: edges, position: [0, 0, 0], role: "cell" });

  const bound = Math.max(nx * a, ny * b, nz * c) * scale * 0.9;
  return { parts, bound };
}

// buildMetacell — a split-ring-resonator-style metasurface unit cell (CLOAK
// Hex-SRR): a ring of radius `ring`, a `gap`, `splits` cuts, `depth` extrusion.
export function buildMetacell(params: Record<string, number | string>): BuiltModel {
  const ring = num(params, "ring", 1);
  const gap = num(params, "gap", 0.2);
  const splits = Math.max(1, Math.round(num(params, "splits", 2)));
  const depth = num(params, "depth", 0.2);

  const parts: BuiltPart[] = [];
  // substrate plate
  parts.push({
    geometry: new THREE.BoxGeometry(ring * 2.6, ring * 2.6, depth * 0.6),
    position: [0, 0, -depth],
    role: "cell",
  });
  // the split ring: torus arcs separated by `splits` gaps
  const arc = (Math.PI * 2 - splits * gap) / splits;
  for (let s = 0; s < splits; s++) {
    const start = s * (arc + gap);
    const seg = new THREE.TorusGeometry(ring, 0.08 * ring, 12, 48, arc);
    parts.push({ geometry: seg, position: [0, 0, 0], role: "ring", emphasis: start });
  }
  // accent post at centre
  parts.push({
    geometry: new THREE.CylinderGeometry(0.1 * ring, 0.1 * ring, depth, 12),
    position: [0, 0, 0],
    role: "accent",
  });
  return { parts, bound: ring * 1.6 };
}

// buildOrbit — a central body + `bodies` orbiting nodes on a ring of `radius`
// (systems / trap assemblies / candidate galleries).
export function buildOrbit(params: Record<string, number | string>): BuiltModel {
  const radius = num(params, "radius", 2);
  const bodies = Math.max(1, Math.round(num(params, "bodies", 3)));

  const parts: BuiltPart[] = [];
  parts.push({
    geometry: new THREE.IcosahedronGeometry(0.4, 0),
    position: [0, 0, 0],
    role: "body",
  });
  parts.push({
    geometry: new THREE.TorusGeometry(radius, 0.02, 8, 64),
    position: [0, 0, 0],
    role: "ring",
  });
  const bodyGeo = new THREE.SphereGeometry(0.2, 16, 16);
  for (let i = 0; i < bodies; i++) {
    const t = (i / bodies) * Math.PI * 2;
    parts.push({
      geometry: bodyGeo,
      position: [Math.cos(t) * radius, 0, Math.sin(t) * radius],
      role: "accent",
    });
  }
  return { parts, bound: radius * 1.3 };
}

// buildThroat — a wormhole-throat surface of revolution (Morris-Thorne style),
// flared from a throat radius `b0` over `height`, `segments` lathe points.
export function buildThroat(params: Record<string, number | string>): BuiltModel {
  const b0 = num(params, "b0", 1);
  const height = num(params, "height", 4);
  const segments = Math.max(8, Math.round(num(params, "segments", 48)));

  // lathe profile: r(z) = b0 * cosh(z / b0) over z ∈ [-h/2, h/2]
  const profile: THREE.Vector2[] = [];
  for (let i = 0; i <= segments; i++) {
    const z = -height / 2 + (height * i) / segments;
    const r = b0 * Math.cosh(z / Math.max(b0, 1e-3));
    profile.push(new THREE.Vector2(r, z));
  }
  const lathe = new THREE.LatheGeometry(profile, 48);
  const parts: BuiltPart[] = [{ geometry: lathe, position: [0, 0, 0], role: "body" }];
  const maxR = b0 * Math.cosh(height / 2 / Math.max(b0, 1e-3));
  return { parts, bound: Math.max(maxR, height / 2) * 1.1 };
}

// buildJunction — a Josephson junction (QUBIT): two superconducting pads
// separated by a thin oxide barrier + a readout resonator. Visually equivalent
// to the prior hardcoded JosephsonR3F, but now param-driven (pad/barrier/
// resonator sizes are data), closing the @L10 "never hardcoded" lock.
export function buildJunction(params: Record<string, number | string>): BuiltModel {
  const padW = num(params, "padW", 3.5);
  const padH = num(params, "padH", 0.18);
  const padD = num(params, "padD", 2.2);
  const gap = num(params, "gap", 0.9); // top↔bottom pad separation
  const barrierR = num(params, "barrierR", 0.5);
  const barrierH = num(params, "barrierH", 0.08);

  const parts: BuiltPart[] = [];
  // top pad (node), bottom pad (bond/muted)
  parts.push({
    geometry: new THREE.BoxGeometry(padW, padH, padD),
    position: [0, gap / 2, 0],
    role: "node",
  });
  parts.push({
    geometry: new THREE.BoxGeometry(padW, padH, padD),
    position: [0, -gap / 2, 0],
    role: "bond",
  });
  // oxide barrier (the single accent moment)
  parts.push({
    geometry: new THREE.CylinderGeometry(barrierR, barrierR, barrierH, 24),
    position: [0, 0.05, 0],
    role: "accent",
  });
  // readout resonator: a vertical post + a coupling torus, off to one side
  const rx = padW * 0.68;
  parts.push({
    geometry: new THREE.BoxGeometry(0.15, 1.6, 0.15),
    position: [rx, 0.6, 0],
    role: "body",
  });
  parts.push({
    geometry: new THREE.TorusGeometry(0.4, 0.07, 16, 32),
    position: [rx, -0.3, 0],
    role: "ring",
  });
  return { parts, bound: Math.max(padW, gap + 1.6) * 0.75 };
}

// buildSymbol — the D3 stylized placeholder. A rung-keyed primitive so the
// shape itself signals scale (atom→tetra · materials→cube · chip→octa ·
// system→icosa) while honestly reading as "no data".
export function buildSymbol(params: Record<string, number | string>): BuiltModel {
  const rung = Math.round(num(params, "rung", 1));
  const geo =
    rung <= 0
      ? new THREE.TetrahedronGeometry(0.9)
      : rung === 1
        ? new THREE.BoxGeometry(1.2, 1.2, 1.2)
        : rung === 2
          ? new THREE.OctahedronGeometry(1)
          : new THREE.IcosahedronGeometry(1, 0);
  return {
    parts: [{ geometry: geo, position: [0, 0, 0], role: "symbol" }],
    bound: 1.6,
  };
}

// ── dispatch: descriptor → BuiltModel (procedural only; glb is rendered by the
// component via useGLTF). One generic switch on `shape`; never on domain name.
export function buildProcedural(d: ProceduralDescriptor): BuiltModel {
  let model: BuiltModel;
  switch (d.shape) {
    case "lattice":
      model = buildLattice(d.params);
      break;
    case "supercell":
      model = buildSupercell(d.params);
      break;
    case "metacell":
      model = buildMetacell(d.params);
      break;
    case "orbit":
      model = buildOrbit(d.params);
      break;
    case "throat":
      model = buildThroat(d.params);
      break;
    case "junction":
      model = buildJunction(d.params);
      break;
    case "symbol":
    default:
      model = buildSymbol(d.params);
      break;
  }
  if (d.label) model.label = d.label;
  return model;
}
