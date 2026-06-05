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
import { mergeGeometries } from "three/examples/jsm/utils/BufferGeometryUtils.js";
import type { Rung } from "@/lib/cosmos";

// ── HelixCurve ────────────────────────────────────────────────────────────────
// A parametric helix as a THREE.Curve, so TubeGeometry can sweep a smooth solid
// tube along it (protein α-helix backbone · the RTSC solenoid winding). Pure,
// SSR-safe (only three math). getPoint(t) = (R·cos(2π·turns·t), lerp(-h/2,h/2,t),
// R·sin(2π·turns·t)) — a constant-radius vertical helix.
export class HelixCurve extends THREE.Curve<THREE.Vector3> {
  constructor(
    private radius: number,
    private height: number,
    private turns: number,
    private phase = 0,
  ) {
    super();
  }
  getPoint(t: number, target = new THREE.Vector3()): THREE.Vector3 {
    const a = Math.PI * 2 * this.turns * t + this.phase;
    return target.set(
      Math.cos(a) * this.radius,
      THREE.MathUtils.lerp(-this.height / 2, this.height / 2, t),
      Math.sin(a) * this.radius,
    );
  }
}

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
  | "helix" // bio rung — protein α-helix / double-helix
  | "molecule" // chem rung — ball-and-stick molecule
  | "die" // chip rung — die / wafer circuit grid
  | "coil" // system rung — torus / coil-pair assembly
  | "symbol";

export type ProceduralDescriptor = {
  kind: "procedural";
  shape: ProceduralShape;
  params: Record<string, number | string>;
  /** optional human label surfaced in the viewer caption. */
  label?: string;
  /**
   * D3 honesty flag: TRUE ⇒ this is a rung-TYPED STYLIZED shape with NO faithful
   * structural numbers (a generic helix / molecule / die / coil derived purely
   * from the rung). The renderer desaturates it and the surface shows the
   * "데이터 없음 / 검증필요" badge — exactly like the legacy `symbol` placeholder,
   * but 3D-richer. FALSE/absent ⇒ the params carry real data (faithful). This is
   * independent of the verify badge: fidelity reflects DATA-PRESENCE only.
   */
  stylized?: boolean;
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
    return {
      kind: "procedural",
      shape,
      params,
      label: asString(o.label),
      stylized: o.stylized === true || undefined,
    };
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
    s === "helix" ||
    s === "molecule" ||
    s === "die" ||
    s === "coil" ||
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

// Rung → a generic default shape when nothing more specific is known. Each of
// the SIX layperson bands (§10) reads visually distinct, reusing the existing
// shape primitives: atom→lattice · materials→supercell · bio→helix · chem→
// molecule · chip→die · system→orbit (full body). Shape primitives are unchanged
// — only the rung keys moved to the 6-band ladder.
const RUNG_DEFAULT_SHAPE: Record<Rung, ProceduralShape> = {
  atom: "lattice",
  materials: "supercell",
  bio: "helix",
  chem: "molecule",
  chip: "die",
  system: "orbit",
};

// Generic default param bags per shape (still DATA, not renderer-inline). These
// are GENERIC numbers (turn count, sphere count) chosen for a recognizable
// silhouette — NOT measured structural values. A rung-typed fallback built from
// these is flagged `stylized: true` (D3 honesty) by deriveProcedural.
function defaultParamsForShape(shape: ProceduralShape): Record<string, number | string> {
  switch (shape) {
    case "lattice":
      return { sigma: 6, tau: 4, phi: 2, rings: 1, a: 1 };
    case "supercell":
      return { a: 3, b: 3, c: 3, nx: 1, ny: 1, nz: 1 };
    case "metacell":
      return { ring: 1, gap: 0.2, splits: 2, depth: 0.2 };
    case "helix":
      // generic α-helix: turns·residuesPerTurn·radius·pitch (no real residue count)
      return { turns: 3, perTurn: 6, radius: 1, pitch: 1.2, strands: 1 };
    case "molecule":
      // generic ball-and-stick: a small branched motif (no real formula)
      return { atoms: 5, bondLen: 1.1, branch: 3 };
    case "die":
      // generic die / wafer grid: rows·cols pads + bond-wire ring (no real pitch)
      return { rows: 4, cols: 4, pitch: 0.55, pad: 0.32, depth: 0.18 };
    case "coil":
      // generic torus / coil-pair: ring radius · winding count (no real geometry)
      return { radius: 2, windings: 16, pairGap: 1.4, tube: 0.18 };
    case "throat":
      return { b0: 1, height: 4, segments: 48 };
    case "orbit":
    default:
      return { radius: 2, bodies: 3 };
  }
}

function deriveProcedural(src: DescriptorSource): ProceduralDescriptor {
  const up = src.name.toUpperCase();
  if (DERIVED_PARAMS[up]) return DERIVED_PARAMS[up];

  // A couple of generic goal-keyword hints (still manifest-free of names). These
  // shape the silhouette from the GOAL prose, not from measured numbers, so they
  // are stylized too.
  const goal = (src.goal ?? "").toLowerCase();
  if (/throat|wormhole|metric|surface.?of.?revolution/.test(goal)) {
    return {
      kind: "procedural",
      shape: "throat",
      params: defaultParamsForShape("throat"),
      stylized: true,
    };
  }
  if (/orbit|trap|loop|ring/.test(goal)) {
    return {
      kind: "procedural",
      shape: "orbit",
      params: defaultParamsForShape("orbit"),
      stylized: true,
    };
  }

  const rung = src.rung ?? "materials";
  const shape = RUNG_DEFAULT_SHAPE[rung];
  // A rung-typed fallback carries NO real structural numbers → stylized (D3).
  return {
    kind: "procedural",
    shape,
    params: defaultParamsForShape(shape),
    stylized: true,
  };
}

// ── (3) stylized symbol placeholder (D3 hybrid — no data → honest stub) ───────
function symbolDescriptor(rung: Rung): ProceduralDescriptor {
  // rung index: atom 0 · materials 1 · bio 2 · chem 3 · chip 4 · system 5 (the 6
  // layperson bands, bottom→top of the ladder).
  const RUNG_NUM: Record<Rung, number> = {
    atom: 0,
    materials: 1,
    bio: 2,
    chem: 3,
    chip: 4,
    system: 5,
  };
  return {
    kind: "procedural",
    shape: "symbol",
    params: { rung: RUNG_NUM[rung] },
    label: "stylized symbol (데이터 없음 / 검증필요)",
    stylized: true,
  };
}

// A descriptor is "stylized" (D3: no faithful structural numbers) when it is the
// rung-keyed symbol placeholder OR a rung-typed generic shape carrying the
// `stylized` flag. Both must show the ⚪ "데이터 없음 / 검증필요" badge and render
// desaturated — a stylized shape MUST NEVER imply verified/measured geometry.
export function isStylizedDescriptor(d?: Model3DDescriptor): boolean {
  if (!d || d.kind !== "procedural") return false;
  return d.stylized === true || d.shape === "symbol";
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
  /** optional explicit quaternion orientation [x,y,z,w] (oriented bonds/shells). */
  quaternion?: [number, number, number, number];
  /** optional non-uniform scale (cheaper than per-part geometry). */
  scale?: [number, number, number];
  /** semantic role → the renderer maps it to a palette slot. */
  role: "node" | "bond" | "cell" | "ring" | "body" | "accent" | "symbol";
  /** optional per-part scalar (e.g. emphasise an accent). */
  emphasis?: number;
  /**
   * Optional MATERIAL HINTS (data-driven, d4). When present the renderer uses
   * them instead of the role-palette default — this is how the faithful coil
   * (RTSC-solenoid-grade) carries its real shell colors / opacities WITHOUT the
   * renderer branching on a domain name. All optional → legacy parts (no hints)
   * render exactly as before via the role palette.
   */
  color?: string;
  /** "standard" (opaque metal) | "physical" (translucent shell) | "transmission" (hero glass). */
  material?: "standard" | "physical" | "transmission";
  metalness?: number;
  roughness?: number;
  emissive?: string;
  emissiveIntensity?: number;
  transparent?: boolean;
  opacity?: number;
  /** explicit transparent sort order (nested shells innermost→outermost). */
  renderOrder?: number;
  /** render both faces (open-ended translucent cylinders). */
  doubleSide?: boolean;
  /** disable depth write (transparent shells — avoid z-fighting/sort errors). */
  depthWrite?: boolean;
  /** clearcoat for a glossy shell finish. */
  clearcoat?: number;
  /** low transmission for a frosted shell (physical material). */
  transmission?: number;
};

// Element-ish CPK-style colors for ball-and-stick molecules (chem rung). A
// small generic palette — the builder cycles through it so a stylized molecule
// reads as "atoms of different kinds" without claiming a real formula.
export const ELEMENT_COLORS = {
  C: "#2b2b2b",
  H: "#e8e8e8",
  O: "#e23b2e",
  N: "#2e57e2",
  S: "#e0c020",
  P: "#e08020",
  F: "#3bd17a",
} as const;
const ELEMENT_CYCLE = ["C", "O", "N", "S", "F", "H"] as const;

// Build the quaternion (as a tuple) that rotates the +Y axis (cylinder default)
// onto a unit direction — for oriented bonds. Pure helper.
function orientYTo(dir: THREE.Vector3): [number, number, number, number] {
  const q = new THREE.Quaternion();
  q.setFromUnitVectors(new THREE.Vector3(0, 1, 0), dir.clone().normalize());
  return [q.x, q.y, q.z, q.w];
}

// An oriented cylinder "bond" part between two points a→b (radius r). The
// builder emits a unit-height cylinder + position(midpoint) + orientation +
// y-scale(length), so the renderer can reuse ONE shared cylinder geometry.
function bondPart(
  a: [number, number, number],
  b: [number, number, number],
  r: number,
  role: BuiltPart["role"],
  geo: THREE.BufferGeometry,
  extra?: Partial<BuiltPart>,
): BuiltPart {
  const av = new THREE.Vector3(...a);
  const bv = new THREE.Vector3(...b);
  const dir = bv.clone().sub(av);
  const len = dir.length() || 1e-6;
  const mid = av.clone().add(bv).multiplyScalar(0.5);
  return {
    geometry: geo,
    position: [mid.x, mid.y, mid.z],
    quaternion: orientYTo(dir),
    scale: [r, len, r],
    role,
    ...extra,
  };
}

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
  const nodeGeo = new THREE.SphereGeometry(0.16 * a, 24, 24);
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

  // nearest-neighbour bonds within a layer (oriented thin cylinders). All bonds
  // here are horizontal (same z) so orientation just spans the in-plane vector.
  const bondGeo = new THREE.CylinderGeometry(1, 1, 1, 8);
  for (let layer = 0; layer < phi; layer++) {
    const z = (layer - (phi - 1) / 2) * layerGap;
    for (let i = 0; i < pts.length; i++) {
      for (let j = i + 1; j < pts.length; j++) {
        const dx = pts[i][0] - pts[j][0];
        const dy = pts[i][1] - pts[j][1];
        const d = Math.hypot(dx, dy);
        if (d < a * 1.8 && d > 1e-6) {
          parts.push(
            bondPart(
              [pts[i][0], pts[i][1], z],
              [pts[j][0], pts[j][1], z],
              0.03 * a,
              "bond",
              bondGeo,
            ),
          );
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
  const cornerGeo = new THREE.SphereGeometry(0.18, 28, 28);
  const centreGeo = new THREE.SphereGeometry(0.12, 24, 24);
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
    geometry: new THREE.IcosahedronGeometry(0.4, 2),
    position: [0, 0, 0],
    role: "body",
    material: "physical",
    metalness: 0.6,
    roughness: 0.3,
    clearcoat: 0.6,
  });
  parts.push({
    geometry: new THREE.TorusGeometry(radius, 0.025, 16, 128),
    position: [0, 0, 0],
    role: "ring",
  });
  const bodyGeo = new THREE.SphereGeometry(0.2, 24, 24);
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
  // top pad (node), bottom pad (bond/muted) — superconducting metal pads
  parts.push({
    geometry: new THREE.BoxGeometry(padW, padH, padD),
    position: [0, gap / 2, 0],
    role: "node",
    material: "physical",
    metalness: 0.9,
    roughness: 0.3,
    clearcoat: 0.4,
  });
  parts.push({
    geometry: new THREE.BoxGeometry(padW, padH, padD),
    position: [0, -gap / 2, 0],
    role: "bond",
    material: "physical",
    metalness: 0.9,
    roughness: 0.35,
  });
  // oxide barrier (the single accent moment)
  parts.push({
    geometry: new THREE.CylinderGeometry(barrierR, barrierR, barrierH, 48),
    position: [0, 0.05, 0],
    role: "accent",
    metalness: 0.7,
    roughness: 0.25,
  });
  // readout resonator: a vertical post + a coupling torus, off to one side
  const rx = padW * 0.68;
  parts.push({
    geometry: new THREE.BoxGeometry(0.15, 1.6, 0.15),
    position: [rx, 0.6, 0],
    role: "body",
  });
  parts.push({
    geometry: new THREE.TorusGeometry(0.4, 0.07, 24, 96),
    position: [rx, -0.3, 0],
    role: "ring",
  });
  return { parts, bound: Math.max(padW, gap + 1.6) * 0.75 };
}

// buildHelix — BIO rung: a protein α-helix (strands=1) or double-helix
// (strands=2). `turns` full turns, `perTurn` backbone beads per turn, `radius`
// the helix radius, `pitch` the rise per turn. Beads = backbone "residues",
// thin cylinders = the inter-strand rungs of a double-helix. Generic — reads as
// "a protein / nucleic-acid coil" without claiming a specific residue count
// unless the descriptor params carry real numbers.
export function buildHelix(params: Record<string, number | string>): BuiltModel {
  const turns = Math.max(1, num(params, "turns", 3));
  const perTurn = Math.max(3, Math.round(num(params, "perTurn", 6)));
  const radius = num(params, "radius", 1);
  const pitch = num(params, "pitch", 1.2);
  const strands = Math.max(1, Math.min(2, Math.round(num(params, "strands", 1))));
  const totalH = turns * pitch;

  const parts: BuiltPart[] = [];

  // Smooth backbone TUBE swept along a HelixCurve, with a per-vertex color
  // gradient along the length (N→C terminus) — the §protein-helix recipe. One
  // tube per strand; a double-helix gets a second π-phased strand + rungs.
  // Tubular segments scale with turns so longer helices stay smooth.
  const tubR = 0.12 * radius;
  const ribbonColor = (a: THREE.Color, b: THREE.Color, geo: THREE.BufferGeometry) => {
    const pos = geo.getAttribute("position");
    const colors = new Float32Array(pos.count * 3);
    const c = new THREE.Color();
    // color by height fraction (low→a, high→b) for a clean N→C gradient
    let minY = Infinity;
    let maxY = -Infinity;
    for (let i = 0; i < pos.count; i++) {
      const y = pos.getY(i);
      if (y < minY) minY = y;
      if (y > maxY) maxY = y;
    }
    const span = maxY - minY || 1;
    for (let i = 0; i < pos.count; i++) {
      const f = (pos.getY(i) - minY) / span;
      c.copy(a).lerp(b, f);
      colors[i * 3] = c.r;
      colors[i * 3 + 1] = c.g;
      colors[i * 3 + 2] = c.b;
    }
    geo.setAttribute("color", new THREE.BufferAttribute(colors, 3));
  };

  const segs = Math.min(900, Math.max(120, Math.round(turns * perTurn * 8)));
  const lo = new THREE.Color("#4a78c2"); // N-terminus (cool)
  const hi = new THREE.Color("#e8a24a"); // C-terminus (warm)
  for (let s = 0; s < strands; s++) {
    const curve = new HelixCurve(radius, totalH, turns, s * Math.PI);
    const tube = new THREE.TubeGeometry(curve, segs, tubR, 16, false);
    ribbonColor(lo, hi, tube);
    parts.push({
      geometry: tube,
      position: [0, 0, 0],
      role: "body",
      material: "standard",
      roughness: 0.45,
      metalness: 0.1,
    });
  }

  // base-pair rungs for a double helix (oriented cylinders between strands)
  if (strands === 2) {
    const rungGeo = new THREE.CylinderGeometry(1, 1, 1, 8);
    const nRungs = Math.max(6, Math.round(turns * perTurn));
    const ptAt = (i: number, s: number): [number, number, number] => {
      const t = i / nRungs;
      const a = Math.PI * 2 * turns * t + s * Math.PI;
      const y = THREE.MathUtils.lerp(-totalH / 2, totalH / 2, t);
      return [Math.cos(a) * radius, y, Math.sin(a) * radius];
    };
    for (let i = 0; i <= nRungs; i++) {
      parts.push(
        bondPart(ptAt(i, 0), ptAt(i, 1), 0.04 * radius, "bond", rungGeo, {
          color: "#9a8f80",
        }),
      );
    }
  }
  return { parts, bound: Math.max(radius * 1.8, totalH / 2 + 0.5) };
}

// buildMolecule — CHEM rung: a ball-and-stick molecule. A central atom with
// `branch` substituent atoms, plus `atoms` total spread on a small shell (a
// recognizable branched motif). `bondLen` sets the bond length. Generic — no
// specific formula is implied unless the descriptor carries one.
export function buildMolecule(params: Record<string, number | string>): BuiltModel {
  const atoms = Math.max(2, Math.round(num(params, "atoms", 5)));
  const bondLen = num(params, "bondLen", 1.1);
  const branch = Math.max(1, Math.round(num(params, "branch", 3)));

  const parts: BuiltPart[] = [];
  // higher-poly atom spheres + a shared unit bond cylinder (oriented per bond).
  const coreGeo = new THREE.SphereGeometry(0.34, 32, 32);
  const subGeo = new THREE.SphereGeometry(0.24, 32, 32);
  const bondGeo = new THREE.CylinderGeometry(1, 1, 1, 12);

  const atomMat = (el: keyof typeof ELEMENT_COLORS): Partial<BuiltPart> => ({
    color: ELEMENT_COLORS[el],
    material: "physical",
    roughness: 0.35,
    metalness: 0.0,
    clearcoat: 0.6,
  });

  // central carbon atom
  parts.push({ geometry: coreGeo, position: [0, 0, 0], role: "node", ...atomMat("C") });

  // place (atoms-1) substituents on a fibonacci sphere for an even spread; cycle
  // element colors so it reads as a real multi-element ball-and-stick motif.
  const sub = atoms - 1;
  const positions: Array<[number, number, number]> = [];
  for (let i = 0; i < sub; i++) {
    const phi = Math.acos(1 - (2 * (i + 0.5)) / sub);
    const theta = Math.PI * (1 + Math.sqrt(5)) * i;
    const x = Math.cos(theta) * Math.sin(phi) * bondLen;
    const y = Math.cos(phi) * bondLen;
    const z = Math.sin(theta) * Math.sin(phi) * bondLen;
    positions.push([x, y, z]);
  }
  positions.forEach((p, i) => {
    const el = i < branch ? ELEMENT_CYCLE[(i + 1) % ELEMENT_CYCLE.length] : "H";
    parts.push({ geometry: subGeo, position: p, role: "node", ...atomMat(el) });
    parts.push(
      bondPart([0, 0, 0], p, 0.07, "bond", bondGeo, {
        color: "#9a9a9a",
        material: "standard",
        roughness: 0.5,
        metalness: 0.2,
      }),
    );
  });
  return { parts, bound: bondLen * 1.6 };
}

// buildDie — CHIP rung: a die / wafer with a `rows`×`cols` pad grid on a
// substrate, a bond-wire ring around the perimeter, and a raised central core.
// `pitch` is the pad-to-pad spacing, `pad` the pad size, `depth` the substrate
// thickness. Generic circuit-grid silhouette — no real feature size implied
// unless the descriptor carries one.
export function buildDie(params: Record<string, number | string>): BuiltModel {
  const rows = Math.max(1, Math.round(num(params, "rows", 4)));
  const cols = Math.max(1, Math.round(num(params, "cols", 4)));
  const pitch = num(params, "pitch", 0.55);
  const pad = num(params, "pad", 0.32);
  const depth = num(params, "depth", 0.18);

  const parts: BuiltPart[] = [];
  const w = cols * pitch;
  const h = rows * pitch;
  // substrate die — a metallic dark-silicon slab (rounded look via renderer hint)
  parts.push({
    geometry: new THREE.BoxGeometry(w + pitch, depth, h + pitch),
    position: [0, -depth, 0],
    role: "cell",
    color: "#2b2f36",
    material: "physical",
    metalness: 0.85,
    roughness: 0.35,
    clearcoat: 0.5,
  });
  // gold pad grid (flush instanced pads)
  const padGeo = new THREE.BoxGeometry(pad, depth * 0.6, pad);
  const ox = (w - pitch) / 2;
  const oz = (h - pitch) / 2;
  for (let i = 0; i < cols; i++) {
    for (let j = 0; j < rows; j++) {
      parts.push({
        geometry: padGeo,
        position: [i * pitch - ox, depth * 0.1, j * pitch - oz],
        role: "node",
        color: "#d9b44a",
        material: "standard",
        metalness: 0.95,
        roughness: 0.3,
      });
    }
  }
  // raised central core (the active logic block) — the single accent
  parts.push({
    geometry: new THREE.BoxGeometry(w * 0.35, depth * 1.6, h * 0.35),
    position: [0, depth * 0.6, 0],
    role: "accent",
    material: "physical",
    metalness: 0.6,
    roughness: 0.3,
    clearcoat: 0.7,
  });
  // perimeter wire-bond ring
  const ring = new THREE.EdgesGeometry(
    new THREE.BoxGeometry(w + pitch, depth * 1.2, h + pitch),
  );
  parts.push({ geometry: ring, position: [0, 0, 0], role: "cell" });

  return { parts, bound: Math.max(w, h) * 0.85 };
}

// buildCoil — SYSTEM rung: a coil-pair / torus assembly. A main torus ring of
// `radius` wound with `windings` short stub segments, plus a SECOND torus
// offset by `pairGap` (a Helmholtz-style coil pair / poloidal+toroidal hint).
// `tube` is the torus tube radius. Generic confinement-coil silhouette — used
// for the system rung default and, with real numbers, for faithful tokamak /
// trap / solenoid-array descriptors.
// SYSTEM rung: an HTS-solenoid-grade assembly = CONCENTRIC translucent shells
// (bore · support · HTS coil · copper jacket · radiation shield · cryostat) +
// a DENSE helical winding swept along a HelixCurve (the §RTSC-coil reference,
// real ring specs from hts_solenoid_proxy_v1.geo.json). Data-driven: `radius`
// sets the coil mean radius, `pairGap`→the solenoid length h, `windings`→helix
// turns, `tube`→a global radial-scale knob. The other shells nest at fixed
// fractions of the coil radius with real air gaps so the renderer can do the
// transparent sort cleanly (ascending renderOrder innermost→outermost). With
// real numbers (UFO/FUSION/ANTIMATTER descriptors) it reads faithful; with the
// generic rung default it reads as a polished confinement coil.
export function buildCoil(params: Record<string, number | string>): BuiltModel {
  const radius = num(params, "radius", 2);
  const turns = Math.max(8, Math.round(num(params, "windings", 16)) * 4);
  const h = Math.max(0.8, num(params, "pairGap", 1.4)) * 1.6; // solenoid length
  const tube = num(params, "tube", 0.18);

  const parts: BuiltPart[] = [];

  // ── the HTS coil winding: a single dense helix swept as a solid tube ────────
  // opaque gold-toned metallic REBCO conductor (#D4A53A) — the hero of the model.
  const coilR = radius;
  const wireR = Math.max(0.018, tube * 0.12);
  const segs = Math.min(2400, Math.max(240, Math.round(18 * turns)));
  const curve = new HelixCurve(coilR, h, turns);
  const winding = new THREE.TubeGeometry(curve, segs, wireR, 10, false);
  parts.push({
    geometry: winding,
    position: [0, 0, 0],
    role: "accent",
    color: "#D4A53A",
    material: "standard",
    metalness: 0.95,
    roughness: 0.28,
    emissive: "#3a1f00",
    emissiveIntensity: 0.25,
  });

  // ── concentric shells (open-ended cylinders, real air gaps) ─────────────────
  // each: r-fraction of coilR · op/color from the real geo.json ring specs.
  // renderOrder ascends innermost→outermost so the transparent sort is correct.
  // shared UNIT open cylinder (r=1,h=1,96-seg,open) — scaled per shell.
  const shellGeo = new THREE.CylinderGeometry(1, 1, 1, 96, 1, true);
  const shell = (
    rFrac: number,
    color: string,
    opacity: number,
    order: number,
    opaque = false,
    hFrac = 1,
  ): BuiltPart => ({
    geometry: shellGeo,
    position: [0, 0, 0],
    scale: [coilR * rFrac, h * hFrac, coilR * rFrac],
    role: "ring",
    color,
    material: "physical",
    transparent: !opaque,
    opacity,
    depthWrite: opaque,
    doubleSide: !opaque,
    renderOrder: order,
    metalness: opaque ? 0.9 : 0.3,
    roughness: opaque ? 0.4 : 0.5,
    clearcoat: opaque ? 0.0 : 0.4,
    transmission: opaque ? 0 : 0.15,
  });

  // bore (innermost, faint) → inner support (opaque steel) → [HTS coil winding] →
  // copper jacket (opaque) → radiation shield (translucent) → cryostat (outer glass)
  parts.push(shell(0.52, "#2A2A2A", 0.15, 1)); // bore
  parts.push(shell(0.74, "#7A7A7A", 1.0, 2, true)); // inner support G10/steel (opaque)
  parts.push(shell(1.18, "#B87333", 1.0, 4, true)); // copper jacket (opaque, just outside coil)
  parts.push(shell(1.42, "#C0C0C0", 0.45, 6)); // radiation shield aluminized-mylar
  // cryostat OVC = the hero translucent glass shell (ONE transmission material)
  parts.push({
    geometry: shellGeo,
    position: [0, 0, 0],
    scale: [coilR * 1.7, h * 1.12, coilR * 1.7],
    role: "ring",
    color: "#5C7A99",
    material: "transmission",
    transparent: true,
    opacity: 0.25,
    depthWrite: false,
    doubleSide: true,
    renderOrder: 8,
  });

  // central confined body (plasma / trapped particle / payload)
  parts.push({
    geometry: new THREE.IcosahedronGeometry(Math.max(0.25, coilR * 0.18), 2),
    position: [0, 0, 0],
    role: "body",
    material: "standard",
    color: "#f4c5a8",
    emissive: "#f4c5a8",
    emissiveIntensity: 0.35,
    roughness: 0.4,
  });

  return { parts, bound: coilR * 1.7 * 1.05 };
}

// buildSymbol — the D3 stylized placeholder. A rung-keyed primitive so the
// shape itself signals scale (molecular→cube · device→octa · component→dodeca ·
// system→torusKnot) while honestly reading as "no data".
export function buildSymbol(params: Record<string, number | string>): BuiltModel {
  // rung index: molecular 0 · device 1 · component 2 · system 3 (4 `.demi` scales).
  const rung = Math.round(num(params, "rung", 0));
  const geo =
    rung <= 0
      ? new THREE.BoxGeometry(1.2, 1.2, 1.2) // molecular
      : rung === 1
        ? new THREE.OctahedronGeometry(1) // device
        : rung === 2
          ? new THREE.DodecahedronGeometry(0.95) // component
          : new THREE.TorusKnotGeometry(0.6, 0.22, 64, 8); // system
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
    case "helix":
      model = buildHelix(d.params);
      break;
    case "molecule":
      model = buildMolecule(d.params);
      break;
    case "die":
      model = buildDie(d.params);
      break;
    case "coil":
      model = buildCoil(d.params);
      break;
    case "symbol":
    default:
      model = buildSymbol(d.params);
      break;
  }
  if (d.label) model.label = d.label;
  return model;
}

// ── OVERVIEW (constellation) shape resolution + low-poly merged geometry ──────
// The Domain Cosmos OVERVIEW draws ~30+ nodes at once. We can't run the full
// async descriptor resolver (disk / HTTP) per node and can't afford the full
// detail of the focus builders. This block provides:
//   (a) overviewShapeFor() — a PURE, SYNCHRONOUS resolution of a node → the
//       rung-typed shape kind (+ stylized flag), mirroring deriveProcedural's
//       priority (registered domain → goal keyword → rung default) WITHOUT I/O.
//   (b) low-poly param presets per shape (fewer beads / segments / cells).
//   (c) mergeBuiltModelToUnit() — merge a BuiltModel's solid (mesh) parts into a
//       SINGLE BufferGeometry, recentred + scaled to a unit bound, so the whole
//       rung silhouette renders as ONE instanced draw call per shape kind.
// `cell`/edge (LineSegments) parts are dropped here — they don't survive triangle
// merging and read as noise at constellation scale; the solid parts carry the
// silhouette. The focus view keeps the full, edge-inclusive model unchanged.

export type OverviewShape = { shape: ProceduralShape; stylized: boolean };

// PURE synchronous shape pick (no disk/HTTP). Used by the overview only, where
// per-node async resolution would jank. Faithful registered domains keep their
// real shape (stylized=false); rung/goal fallbacks are stylized=true (D3).
export function overviewShapeFor(src: DescriptorSource): OverviewShape {
  const up = src.name.toUpperCase();
  const reg = DERIVED_PARAMS[up];
  if (reg) return { shape: reg.shape, stylized: reg.stylized === true };

  const goal = (src.goal ?? "").toLowerCase();
  if (/throat|wormhole|metric|surface.?of.?revolution/.test(goal))
    return { shape: "throat", stylized: true };
  if (/orbit|trap|loop|ring/.test(goal)) return { shape: "orbit", stylized: true };

  const rung = src.rung ?? "materials";
  return { shape: RUNG_DEFAULT_SHAPE[rung], stylized: true };
}

// Reduced-segment / reduced-count params for a constellation glyph. These keep
// the silhouette readable while slashing triangle + part counts vs the focus
// builders (e.g. helix 3→2 turns @ 4/turn; supercell single cell; coil 8 stubs).
function overviewParamsForShape(
  shape: ProceduralShape,
): Record<string, number | string> {
  switch (shape) {
    case "lattice":
      return { sigma: 6, tau: 4, phi: 1, rings: 1, a: 1 };
    case "supercell":
      return { a: 1, b: 1, c: 1, nx: 1, ny: 1, nz: 1 };
    case "metacell":
      return { ring: 1, gap: 0.25, splits: 2, depth: 0.2 };
    case "helix":
      return { turns: 2, perTurn: 4, radius: 1, pitch: 1.1, strands: 2 };
    case "molecule":
      return { atoms: 4, bondLen: 1.0, branch: 3 };
    case "die":
      return { rows: 3, cols: 3, pitch: 0.55, pad: 0.34, depth: 0.18 };
    case "coil":
      return { radius: 2, windings: 8, pairGap: 1.4, tube: 0.2 };
    case "throat":
      return { b0: 1, height: 3.2, segments: 16 };
    case "orbit":
      return { radius: 2, bodies: 3 };
    case "symbol":
    default:
      return defaultParamsForShape(shape);
  }
}

// Merge a BuiltModel's SOLID parts into one geometry, recentred to the origin and
// scaled so the model's bound ≈ `targetBound`. Returns null if nothing mergeable
// (caller falls back to a sphere glyph). The caller owns disposal/caching.
export function mergeBuiltModelToUnit(
  model: BuiltModel,
  targetBound = 1,
): THREE.BufferGeometry | null {
  const solids = model.parts.filter((p) => p.role !== "cell");
  if (solids.length === 0) return null;

  const geos: THREE.BufferGeometry[] = [];
  const _q = new THREE.Quaternion();
  const _s = new THREE.Vector3();
  const _t = new THREE.Vector3();
  const _m = new THREE.Matrix4();
  for (const part of solids) {
    const g = part.geometry.clone();
    // Only merge geometries that expose a triangle 'position' attribute.
    if (!g.getAttribute("position")) continue;
    // Apply the part's full local transform (scale → rotate → translate) so
    // oriented/scaled bonds (unit cylinders) survive the merge at overview scale.
    _t.set(part.position[0], part.position[1], part.position[2]);
    _q.set(...(part.quaternion ?? [0, 0, 0, 1]));
    _s.set(...(part.scale ?? [1, 1, 1]));
    _m.compose(_t, _q, _s);
    g.applyMatrix4(_m);
    geos.push(g);
  }
  if (geos.length === 0) return null;

  let merged: THREE.BufferGeometry | null = null;
  try {
    merged = mergeGeometries(geos, false);
  } catch {
    merged = null;
  }
  // mergeGeometries can return null if attribute sets mismatch — drop normals to
  // retry on a position-only merge (silhouette only; lighting is approximate).
  if (!merged) {
    const posOnly = geos.map((g) => {
      const p = new THREE.BufferGeometry();
      p.setAttribute("position", g.getAttribute("position"));
      const idx = g.getIndex();
      if (idx) p.setIndex(idx);
      return p;
    });
    try {
      merged = mergeGeometries(posOnly, false);
    } catch {
      merged = null;
    }
    posOnly.forEach((p) => p.dispose());
  }
  for (const g of geos) g.dispose();
  if (!merged) return null;

  if (!merged.getAttribute("normal")) merged.computeVertexNormals();

  // Recentre + scale to the requested bound.
  merged.computeBoundingSphere();
  const bs = merged.boundingSphere;
  if (bs) {
    merged.translate(-bs.center.x, -bs.center.y, -bs.center.z);
    const r = bs.radius || model.bound || 1;
    const s = targetBound / r;
    merged.scale(s, s, s);
  }
  merged.computeBoundingSphere();
  return merged;
}

// Convenience: build the low-poly, unit-bounded merged geometry for one rung
// shape kind (one per shape — shared across all nodes of that shape). Returns
// null if the merge fails (→ sphere-glyph fallback).
export function overviewGeometryForShape(
  shape: ProceduralShape,
  targetBound = 1,
): THREE.BufferGeometry | null {
  const model = buildProcedural({
    kind: "procedural",
    shape,
    params: overviewParamsForShape(shape),
  });
  return mergeBuiltModelToUnit(model, targetBound);
}
