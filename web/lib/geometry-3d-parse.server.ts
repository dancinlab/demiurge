// geometry-3d-parse.server.ts — AUTO-PROMOTION parser (priority-2 resolver).
//
// Scans a domain's `domains/<DOMAIN>.md` for EXTRACTABLE structural quantities
// and, when enough REAL numbers are present, emits a FAITHFUL Model3DDescriptor
// IN MEMORY (no JSON file is ever written to disk). This is the priority-2 step
// in the resolution chain (geometry-3d.server.ts):
//
//   (1) hand-authored web/public/models/<DOMAIN>/model.3d.json   — highest
//   (2) AUTO-PARSED faithful descriptor (THIS FILE)              — auto-promote
//   (3) rung-typed stylized default                              — current
//
// HONESTY (CLAUDE.md d1/d5/d10 · 8VERB §5.1 D3):
//   - NEVER fabricate a number. If the doc carries no real structural quantity
//     for the node's rung, this returns null → the node stays STYLIZED (the
//     correct, honest outcome).
//   - A PDB id ALONE (no residue / atom count) is NOT enough for a faithful
//     mesh — it is recorded only as a weak hint and never alone trips promotion.
//   - The emitted descriptor is `stylized: false` (it carries real data), but
//     fidelity is INDEPENDENT of the verify badge — deriveState()/the ⚪🟡🟢
//     badge is unchanged. Data-presence ≠ verified-ness.
//   - Every extracted number records PROVENANCE: the matched line text + its
//     1-based line number, folded into params.src exactly like the hand-authored
//     descriptors (e.g. "domains/fusion.md:140 (...)").
//
// PURE-by-design: parseDocToDescriptor(text, src) takes the doc TEXT and is
// node-free (unit-testable without fs). parseDescriptorFromDisk(src) is the thin
// server wrapper that reads the doc off disk via repoDataRoot().

import fs from "node:fs/promises";
import path from "node:path";
import { repoDataRoot } from "@/lib/data-root";
import type { DomainEntry } from "@/lib/domains";
import {
  type DescriptorSource,
  type ProceduralDescriptor,
  type ProceduralShape,
} from "@/lib/geometry-3d";
import type { Rung } from "@/lib/cosmos";

// ── provenance ────────────────────────────────────────────────────────────────
// One extracted quantity + WHERE it came from. `line` is 1-based.
export type Hit = {
  /** the param key this number feeds (e.g. "a", "turns", "atoms"). */
  key: string;
  value: number;
  /** 1-based line number in the doc. */
  line: number;
  /** the trimmed source line (clipped) — the human-auditable evidence. */
  text: string;
};

export type ParseResult = {
  shape: ProceduralShape;
  params: Record<string, number>;
  hits: Hit[];
  /** weak, non-promoting hints (e.g. a bare PDB id with no counts). */
  weakHints: string[];
};

// Clip a matched line for the src field so a giant prose line doesn't bloat the
// descriptor. Keeps the head where the number lives.
function clip(s: string, max = 160): string {
  const t = s.trim().replace(/\s+/g, " ");
  return t.length > max ? t.slice(0, max - 1) + "…" : t;
}

// Walk the doc once, calling `fn` per (lineIndex0, lineText). Cheap + ordered.
function eachLine(text: string, fn: (i: number, line: string) => void): void {
  const lines = text.split(/\r?\n/);
  for (let i = 0; i < lines.length; i++) fn(i, lines[i]);
}

// Push a hit only if a finite, positive, sane number — and only the FIRST hit
// for a given key wins (docs are top-down: the head/spec line is canonical).
function pushHit(
  hits: Hit[],
  seen: Set<string>,
  key: string,
  value: number,
  i: number,
  line: string,
  opts?: { min?: number; max?: number },
): void {
  if (seen.has(key)) return;
  if (!Number.isFinite(value)) return;
  const min = opts?.min ?? 0;
  const max = opts?.max ?? 1e6;
  if (value <= min || value > max) return;
  seen.add(key);
  hits.push({ key, value, line: i + 1, text: clip(line) });
}

// ── per-rung extractors ───────────────────────────────────────────────────────
// Each returns the candidate hits found in the doc for that rung's shape. They
// are intentionally CONSERVATIVE: match an explicit, labelled structural number,
// not any stray digit. Provenance is captured for every hit.

// lattice constants a/b/c in Å (atom rung → lattice / material → supercell).
// Matches "a = 3.6 Å", "a=3.60Å", "lattice constant 6.00 Å", "a 3.6 Angstrom".
function extractLattice(text: string, hits: Hit[], seen: Set<string>): void {
  const ANG = /(?:Å|Angstrom|angstrom|Å|Ångström)/;
  eachLine(text, (i, line) => {
    // a/b/c = N Å
    for (const axis of ["a", "b", "c"] as const) {
      const re = new RegExp(
        `\\b${axis}\\s*[=:]?\\s*([0-9]+(?:\\.[0-9]+)?)\\s*(?:Å|Angstrom|angstrom|Ångström)`,
      );
      const m = line.match(re);
      if (m) pushHit(hits, seen, axis, parseFloat(m[1]), i, line, { min: 0.3, max: 60 });
    }
    // generic "lattice (constant|param) N Å" → a
    const latM = line.match(
      /lattice\s*(?:constant|param(?:eter)?)?\s*[=:]?\s*([0-9]+(?:\.[0-9]+)?)\s*(?:Å|Angstrom|angstrom|Ångström)/i,
    );
    if (latM) pushHit(hits, seen, "a", parseFloat(latM[1]), i, line, { min: 0.3, max: 60 });
    void ANG;
  });
  // supercell repetition counts: "2x2x2 supercell", "3×3×1 cell"
  eachLine(text, (i, line) => {
    const m = line.match(/\b([1-9])\s*[x×]\s*([1-9])\s*[x×]\s*([1-9])\b\s*(?:super)?cell/i);
    if (m) {
      pushHit(hits, seen, "nx", parseInt(m[1], 10), i, line, { min: 0, max: 12 });
      pushHit(hits, seen, "ny", parseInt(m[2], 10), i, line, { min: 0, max: 12 });
      pushHit(hits, seen, "nz", parseInt(m[3], 10), i, line, { min: 0, max: 12 });
    }
  });
  // crystal layer count → phi. CONSERVATIVE: a bare "N layer" is too generic
  // (matches software layers / table prose), so we require an explicit crystal
  // context word on the SAME line (atomic / 원자 / lattice / 격자 / stacking /
  // bilayer-of-a-named-material). Otherwise we DO NOT promote a layer count —
  // staying stylized is the honest outcome (no fabricated structure).
  eachLine(text, (i, line) => {
    const crystalCtx = /lattice|격자|atomic|원자|stacking|적층|unit[- ]?cell|단위[- ]?셀|crystal|결정/i;
    if (!crystalCtx.test(line)) return;
    if (/\bbilayer\b|이중층/i.test(line)) {
      pushHit(hits, seen, "phi", 2, i, line, { min: 0, max: 12 });
      return;
    }
    const m = line.match(/\b([1-9])\s*[- ]?(?:atomic[- ]?layers?|layers?|층)\b/i);
    if (m) pushHit(hits, seen, "phi", parseInt(m[1], 10), i, line, { min: 0, max: 12 });
  });
  // honeycomb σ·τ·φ identity (HEX-N6 family): only accept the FULL dotted-triple
  // form "σ=…·τ=…·φ=…" where all three symbols are independently assigned on one
  // line. A single stray "τ=48" inside a PRODUCT like "σ·τ=48" is NOT a faithful
  // per-symbol value, so we require the complete triple (no fabrication).
  eachLine(text, (i, line) => {
    const sg = line.match(/(?:σ|sigma)\s*=\s*([0-9]+)\b/i);
    const tu = line.match(/(?:τ|tau)\s*=\s*([0-9]+)\b/i);
    const ph = line.match(/(?:φ|phi)\s*=\s*([0-9]+)\b/i);
    if (sg && tu && ph) {
      pushHit(hits, seen, "sigma", parseInt(sg[1], 10), i, line, { min: 0, max: 100 });
      pushHit(hits, seen, "tau", parseInt(tu[1], 10), i, line, { min: 0, max: 100 });
      pushHit(hits, seen, "phi", parseInt(ph[1], 10), i, line, { min: 0, max: 12 });
    }
  });
}

// bio rung → helix: residue/sequence length, helix turns, chain count, PDB hint.
function extractBio(
  text: string,
  hits: Hit[],
  seen: Set<string>,
  weak: string[],
): void {
  eachLine(text, (i, line) => {
    // residue / sequence length → derive turns (3.6 residues/turn α-helix).
    const resM = line.match(
      /\b([0-9]{2,5})\s*(?:residues?|aa\b|amino[- ]?acids?|잔기|residue[- ]?length)/i,
    );
    if (resM) pushHit(hits, seen, "residues", parseInt(resM[1], 10), i, line, { min: 3, max: 5000 });
    const seqM = line.match(/sequence[- ]?length\s*[=:]?\s*([0-9]{2,5})/i);
    if (seqM) pushHit(hits, seen, "residues", parseInt(seqM[1], 10), i, line, { min: 3, max: 5000 });
    // explicit helix turn count
    const turnM = line.match(/\b([0-9]{1,3})\s*(?:helix\s*)?turns?\b/i);
    if (turnM) pushHit(hits, seen, "turns", parseInt(turnM[1], 10), i, line, { min: 1, max: 200 });
    // chain count → strands (cap to {1,2}: monomer / duplex read)
    const chainM = line.match(/\b([1-9])\s*(?:chains?|체인|strands?|가닥)\b/i);
    if (chainM) pushHit(hits, seen, "chains", parseInt(chainM[1], 10), i, line, { min: 1, max: 12 });
    // PDB id — WEAK hint only (4-char alnum, classic PDB form). Never promotes.
    const pdbM = line.match(/\bPDB\b[:\s]*([0-9][A-Za-z0-9]{3})\b/);
    if (pdbM) weak.push(`PDB ${pdbM[1]} @ domains/...:${i + 1}`);
  });
}

// chem rung → molecule: molecular formula → atom count, explicit atom/bond counts.
function extractChem(text: string, hits: Hit[], seen: Set<string>): void {
  eachLine(text, (i, line) => {
    // explicit "N atoms"
    const atomM = line.match(/\b([0-9]{1,4})\s*(?:atoms?|원자)\b/i);
    if (atomM) pushHit(hits, seen, "atoms", parseInt(atomM[1], 10), i, line, { min: 2, max: 2000 });
    // explicit "N bonds"
    const bondM = line.match(/\b([0-9]{1,4})\s*(?:bonds?|결합)\b/i);
    if (bondM) pushHit(hits, seen, "bonds", parseInt(bondM[1], 10), i, line, { min: 1, max: 4000 });
    // molecular formula → sum element subscripts to a total atom count. Match a
    // standalone formula token like "C6H12O6" / "H3S" / "CaH6" (≥2 element groups
    // OR an explicit subscript) so prose words ("In", "He") don't false-match.
    const fm = line.match(/\b((?:[A-Z][a-z]?[0-9]{0,3}){2,})\b/);
    if (fm && /[0-9]/.test(fm[1]) && /formula|화학식|분자식|composition/i.test(line)) {
      const total = sumFormula(fm[1]);
      if (total >= 2) pushHit(hits, seen, "atoms", total, i, line, { min: 2, max: 2000 });
    }
  });
}

// Sum atom counts in a molecular formula token (e.g. C6H12O6 → 24). Unsubscripted
// element = 1. Returns 0 if it doesn't look like a real formula.
export function sumFormula(token: string): number {
  let total = 0;
  let groups = 0;
  const re = /([A-Z][a-z]?)([0-9]{0,3})/g;
  let m: RegExpExecArray | null;
  while ((m = re.exec(token)) !== null) {
    if (!m[1]) continue;
    groups++;
    total += m[2] ? parseInt(m[2], 10) : 1;
  }
  return groups >= 2 ? total : 0;
}

// system rung → coil: radii / diameter (m), ring/winding counts, aspect ratio.
function extractSystem(text: string, hits: Hit[], seen: Set<string>): void {
  eachLine(text, (i, line) => {
    // major radius R = N m  → radius
    const rM = line.match(/\bR(?:_?major)?\s*[=:]\s*([0-9]+(?:\.[0-9]+)?)\s*m\b/i);
    if (rM) pushHit(hits, seen, "radius", parseFloat(rM[1]), i, line, { min: 0.01, max: 1e4 });
    // diameter D = N m → radius = D/2
    const dM = line.match(/\bD(?:iameter)?\s*[=:]\s*([0-9]+(?:\.[0-9]+)?)\s*m\b/i);
    if (dM) pushHit(hits, seen, "radius", parseFloat(dM[1]) / 2, i, line, { min: 0.01, max: 1e4 });
    // height H = N m → pairGap
    const hM = line.match(/\bH(?:eight)?\s*[=:]\s*([0-9]+(?:\.[0-9]+)?)\s*m\b/i);
    if (hM) pushHit(hits, seen, "pairGap", parseFloat(hM[1]), i, line, { min: 0.01, max: 1e4 });
    // elongation κ → pairGap fallback (tokamak shape)
    const kM = line.match(/(?:κ|kappa|elongation)\s*[=:]\s*([0-9]+(?:\.[0-9]+)?)/i);
    if (kM) pushHit(hits, seen, "elongation", parseFloat(kM[1]), i, line, { min: 0.1, max: 10 });
    // explicit winding / solenoid / coil count → windings
    const wM = line.match(/\b([0-9]{1,3})\s*(?:windings?|solenoids?|coils?|turns?|권선)\b/i);
    if (wM) pushHit(hits, seen, "windings", parseInt(wM[1], 10), i, line, { min: 1, max: 1000 });
    // aspect ratio AR = N
    const arM = line.match(/\b(?:AR|aspect[- ]?ratio)\s*[=:]\s*([0-9]+(?:\.[0-9]+)?)/i);
    if (arM) pushHit(hits, seen, "aspect_ratio", parseFloat(arM[1]), i, line, { min: 0.5, max: 100 });
  });
}

// chip rung → die: grid rows/cols, pad pitch (nm/µm). Conservative.
function extractChip(text: string, hits: Hit[], seen: Set<string>): void {
  eachLine(text, (i, line) => {
    const gM = line.match(/\b([0-9]{1,3})\s*[x×]\s*([0-9]{1,3})\b\s*(?:grid|array|crossbar|배열)/i);
    if (gM) {
      pushHit(hits, seen, "rows", parseInt(gM[1], 10), i, line, { min: 1, max: 256 });
      pushHit(hits, seen, "cols", parseInt(gM[2], 10), i, line, { min: 1, max: 256 });
    }
  });
}

// ── rung → shape + minimum-evidence policy ────────────────────────────────────
// §10: the `.demi` `facets.scale` is the rung (4 canonical scales). A scale can
// span MULTIPLE faithful shapes — molecular covers matter (lattice/supercell),
// bio (helix) and chem (molecule); we run every candidate extractor for the scale
// and pick the shape that yields the most promoting hits. CANDIDATE_SHAPES lists
// the shapes (in priority order) each scale may promote to; the per-shape default
// (RUNG_SHAPE) is the stylized fallback shape when no doc number promotes.
// Priority: supercell (bulk crystal · carries nx supercell repeat) before lattice
// (SRR/metamaterial · sigma/phi), then bio (helix) and chem (molecule). A matter
// doc with a lattice constant promotes to the same faithful supercell as before.
const CANDIDATE_SHAPES: Record<Rung, ProceduralShape[]> = {
  atom: ["lattice", "supercell"],
  materials: ["supercell", "lattice"],
  bio: ["helix"],
  chem: ["molecule"],
  chip: ["die", "coil"],
  system: ["coil"],
};

const RUNG_SHAPE: Record<Rung, ProceduralShape> = {
  atom: "lattice",
  materials: "supercell",
  bio: "helix",
  chem: "molecule",
  chip: "die",
  system: "coil",
};

// Run every extractor relevant to a scale (a shape's structural numbers) into a
// shared hit set. molecular runs lattice + bio + chem; device/component run chip;
// system runs the coil/system extractor.
function extractForRung(
  rung: Rung,
  text: string,
  hits: Hit[],
  seen: Set<string>,
  weak: string[],
): void {
  switch (rung) {
    case "atom":
      extractLattice(text, hits, seen);
      break;
    case "materials":
      extractLattice(text, hits, seen);
      break;
    case "bio":
      extractBio(text, hits, seen, weak);
      break;
    case "chem":
      extractChem(text, hits, seen);
      break;
    case "chip":
      extractChip(text, hits, seen);
      extractSystem(text, hits, seen);
      break;
    case "system":
      extractSystem(text, hits, seen);
      break;
  }
}

// The KEYS that, for a given shape, constitute REAL structural evidence. A doc
// promotes only when it yields ≥1 of these. Counts/derived params alone (e.g. a
// lone winding count with no radius) are checked per-shape below.
const PROMOTE_KEYS: Record<ProceduralShape, string[]> = {
  lattice: ["a", "b", "c", "sigma", "phi", "nx"],
  supercell: ["a", "b", "c", "nx"],
  helix: ["residues", "turns"],
  molecule: ["atoms", "bonds"],
  die: ["rows", "cols"],
  coil: ["radius", "windings", "aspect_ratio"],
  metacell: ["ring", "splits"],
  orbit: ["radius", "bodies"],
  throat: ["b0"],
  junction: ["padW"],
  symbol: [],
};

// Map extracted hits → the shape's builder params. Derived conversions live here
// (residues → turns, elongation → pairGap, etc.), all from REAL numbers only.
function toParams(shape: ProceduralShape, hitMap: Map<string, number>): Record<string, number> {
  const p: Record<string, number> = {};
  const get = (k: string) => hitMap.get(k);

  switch (shape) {
    case "lattice": {
      if (get("a")) p.a = get("a")!;
      if (get("sigma")) p.sigma = get("sigma")!;
      if (get("tau")) p.tau = get("tau")!;
      if (get("phi")) p.phi = get("phi")!;
      // rings: scale gently with sigma so a denser identity reads denser.
      if (get("sigma")) p.rings = Math.min(3, Math.max(1, Math.round(get("sigma")! / 6)));
      break;
    }
    case "supercell": {
      const a = get("a");
      if (a) {
        p.a = a;
        p.b = get("b") ?? a;
        p.c = get("c") ?? a;
      }
      if (get("nx")) p.nx = get("nx")!;
      if (get("ny")) p.ny = get("ny")!;
      if (get("nz")) p.nz = get("nz")!;
      break;
    }
    case "helix": {
      const residues = get("residues");
      if (residues) {
        // α-helix geometry: 3.6 residues/turn. turns from the real residue count.
        p.turns = Math.max(1, Math.round(residues / 3.6));
        p.perTurn = 4; // visual beads/turn (kept low-poly)
      } else if (get("turns")) {
        p.turns = get("turns")!;
      }
      const chains = get("chains");
      if (chains) p.strands = Math.min(2, Math.max(1, Math.round(chains)));
      break;
    }
    case "molecule": {
      if (get("atoms")) p.atoms = Math.min(60, get("atoms")!); // cap render cost
      if (get("bonds")) p.branch = Math.min(8, Math.max(1, get("bonds")!));
      break;
    }
    case "die": {
      if (get("rows")) p.rows = get("rows")!;
      if (get("cols")) p.cols = get("cols")!;
      break;
    }
    case "coil": {
      if (get("radius")) p.radius = get("radius")!;
      if (get("windings")) p.windings = get("windings")!;
      if (get("pairGap")) p.pairGap = get("pairGap")!;
      if (get("elongation")) p.pairGap = get("elongation")!; // κ overrides as shape
      if (get("aspect_ratio")) p.aspect_ratio = get("aspect_ratio")!;
      break;
    }
    default:
      break;
  }
  return p;
}

// ── PURE entry: doc TEXT + node src → faithful descriptor OR null ──────────────
// Returns a `stylized:false` faithful descriptor IFF the doc yields ≥1 promoting
// structural number for the node's rung. Otherwise null (caller stays stylized).
// `relPath` is only used to render the human-readable src provenance prefix.
export function parseDocToDescriptor(
  text: string,
  src: DescriptorSource,
  relPath = `domains/${src.name}.md`,
): ProceduralDescriptor | null {
  const rung: Rung = src.rung ?? "materials";

  const hits: Hit[] = [];
  const seen = new Set<string>();
  const weak: string[] = [];
  extractForRung(rung, text, hits, seen, weak);

  const hitMap = new Map(hits.map((h) => [h.key, h.value]));

  // Pick the candidate shape (in priority order) that the doc actually promotes —
  // a scale may span several shapes (molecular = lattice/supercell/helix/molecule).
  // First shape with ≥1 promoting hit AND a non-empty param bag wins; none → stylized.
  let shape: ProceduralShape | null = null;
  let promotingHits: Hit[] = [];
  let params: Record<string, number> = {};
  for (const cand of CANDIDATE_SHAPES[rung]) {
    const ph = hits.filter((h) => PROMOTE_KEYS[cand].includes(h.key));
    if (ph.length === 0) continue;
    const p = toParams(cand, hitMap);
    if (Object.keys(p).length === 0) continue;
    shape = cand;
    promotingHits = ph;
    params = p;
    break;
  }
  if (!shape) return null; // honest: no real numbers → stylized

  // Provenance: fold every promoting hit into params.src, exactly like the
  // hand-authored descriptors ("relPath:line (matched text)").
  const srcLines = promotingHits
    .map((h) => `${relPath}:${h.line} (${h.key}=${h.value} ← "${h.text}")`)
    .join(" · ");
  const weakNote = weak.length ? ` · weak-hint(non-promoting): ${weak.join(", ")}` : "";

  const params2: Record<string, number | string> = {
    ...params,
    src: `[auto-parsed] ${srcLines}${weakNote}`,
  };

  return {
    kind: "procedural",
    shape,
    params: params2,
    label: `${src.name} (auto-parsed faithful · ${promotingHits.length} structural #)`,
    stylized: false, // carries REAL data → faithful (NOT the verify badge)
  };
}

// Inspect-only: full parse result (hits + weak hints) for the audit/report pass.
export function inspectDoc(text: string, src: DescriptorSource): ParseResult {
  const rung: Rung = src.rung ?? "materials";
  const hits: Hit[] = [];
  const seen = new Set<string>();
  const weak: string[] = [];
  extractForRung(rung, text, hits, seen, weak);
  // Report the candidate shape the doc best promotes (else the stylized default).
  let shape: ProceduralShape = RUNG_SHAPE[rung];
  for (const cand of CANDIDATE_SHAPES[rung]) {
    if (hits.some((h) => PROMOTE_KEYS[cand].includes(h.key))) {
      shape = cand;
      break;
    }
  }
  return {
    shape,
    params: toParams(shape, new Map(hits.map((h) => [h.key, h.value]))),
    hits,
    weakHints: weak,
  };
}

// ── SERVER wrapper: read the domain doc off disk, then parse ───────────────────
// Resolves domains/<DOMAIN>.md via the DOMAINS.tape roster when an entry is
// supplied (handles folder-nested + lowercase paths); else falls back to the
// conventional domains/<NAME>.md. Returns null on any read miss (→ stylized).
export async function parseDescriptorFromDisk(
  src: DescriptorSource,
  entry?: Pick<DomainEntry, "mdPath">,
): Promise<ProceduralDescriptor | null> {
  const root = repoDataRoot();
  const rel = entry?.mdPath ?? path.join("domains", `${src.name}.md`);
  const abs = path.isAbsolute(rel) ? rel : path.join(root, rel);
  try {
    const text = await fs.readFile(abs, "utf8");
    return parseDocToDescriptor(text, src, rel);
  } catch {
    // Fallback: the conventional path (the roster may carry a different rel path
    // flavor, or the entry was omitted). Try domains/<NAME>.md once.
    if (entry) {
      try {
        const fallback = path.join(root, "domains", `${src.name}.md`);
        const text = await fs.readFile(fallback, "utf8");
        return parseDocToDescriptor(text, src, path.join("domains", `${src.name}.md`));
      } catch {
        return null;
      }
    }
    return null;
  }
}
