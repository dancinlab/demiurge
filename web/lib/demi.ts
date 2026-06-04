// demi.ts — pure parsers for the `.demi` SSOT (the canonical machine-readable
// domain format). COSMOS's data layer is rebased onto `.demi` (COSMOS.md §10):
// this RETIRES the old DOMAINS.tape roster + `@link` edges + `<D>.md` prose-parse
// + matter ledger sources. Two tiers are parsed here, mirroring the hexa CLI's
// `stdlib/demi/domain_catalog.hexa` + `domain_composer.hexa` (DemiParser →
// DomainLoader):
//
//   1. domains/INDEX.demi   — the graph SSOT. `[<id>]` section per domain;
//      `key = value` scalars; `key.sub = ...` dotted keys; `key = [a, b, c]`
//      lists; `#` comments. Presence of `[<id>]` IS cosmos membership; the
//      `prerequisites` list IS the composition-edge set; `facets.scale` IS the
//      rung.
//   2. domains/<id>.demi    — per-domain verb-cell manifest (cellrun Phase-A
//      dialect): `[cell.<verb>]` sections with `gate_default` (OPEN/CLOSED),
//      `absorbed_default` (true/false), and a multi-line `scope_caveats = [ ... ]`
//      array. These give the 8-verb surface + the HONEST verify-state.
//
// PURE: no I/O. The fs reads live in demi.server.ts (readIndexDemi /
// readDomainDemi), so this module is client-safe and unit-testable. Parse rules
// follow domain_composer.hexa byte-for-byte: trailing `#` comment stripped (first
// `#` wins), whitespace trimmed, quoted scalars/list items unquoted.

// ── one parsed INDEX.demi domain record (DcDomain projection) ────────────────
export type DemiDomain = {
  id: string;
  label: string;
  /** facets.scale ∈ molecular · device · component · system (default "system"). */
  scale: string;
  /** canvas_mode presentation hint (3D mode), "" if absent. */
  canvasMode: string;
  keywords: string[];
  /** direct prerequisites = the composition/decompose edges (D82). */
  prerequisites: string[];
};

// ── one parsed <id>.demi verb cell ───────────────────────────────────────────
export type DemiCell = {
  /** the verb the cell drives (specify · structure · … · handoff). */
  verb: string;
  /** gate_default ∈ OPEN | CLOSED (HONEST measurement gate). */
  gateDefault: string;
  /** absorbed_default ∈ true | false (HONEST absorption claim). */
  absorbedDefault: boolean;
  /** scope_caveats — surfaced verbatim, never hidden (honesty). */
  caveats: string[];
};

export type DemiManifest = { cells: DemiCell[] };

// ── trim / unquote / comment helpers (DemiParser parity) ──────────────────────

// Whitespace-trim (space + tab), matching DemiParser's `.whitespaces` trimming.
function trim(s: string): string {
  return s.replace(/^[ \t]+/, "").replace(/[ \t]+$/, "");
}

// Strip a trailing `#`-to-EOL comment (DemiParser: first `#` wins, even mid-line).
// Returns the pre-`#` portion (untrimmed).
function stripComment(line: string): string {
  const h = line.indexOf("#");
  return h < 0 ? line : line.slice(0, h);
}

// Strip surrounding double-quotes if BOTH ends carry one and length >= 2.
function unquote(s: string): string {
  const t = trim(s);
  if (t.length >= 2 && t.startsWith('"') && t.endsWith('"')) {
    return t.slice(1, -1);
  }
  return t;
}

// RHS is a `[ ... ]` list literal?
function isList(v: string): boolean {
  const t = trim(v);
  return t.length >= 2 && t.startsWith("[") && t.endsWith("]");
}

// The body inside `[ ... ]`.
function listInner(v: string): string {
  const t = trim(v);
  return t.slice(1, -1);
}

// Comma-split honoring quoted commas (DemiParser.splitList), trim each, drop
// empties, unquote each.
function splitList(body: string): string[] {
  const out: string[] = [];
  let current = "";
  let inQuotes = false;
  for (const ch of body) {
    if (ch === '"') {
      inQuotes = !inQuotes;
      current += ch;
    } else if (ch === "," && !inQuotes) {
      const t = trim(current);
      if (t.length > 0) out.push(unquote(t));
      current = "";
    } else {
      current += ch;
    }
  }
  const last = trim(current);
  if (last.length > 0) out.push(unquote(last));
  return out;
}

// ── parseIndexDemi(text) → DemiDomain[] (DemiParser.parse + project) ──────────
// Section header `[id]` opens a record; `key = value` scalar; `key.sub = ...`
// dotted (we surface facets.scale). Malformed lines (no `=`, not a header)
// skipped. A record is emitted on the NEXT header or at EOF (flush). A record
// with no `label` is dropped (DomainLoader.project requires a label). Order =
// source order (the cosmos sorts nodes itself).
export function parseIndexDemi(text: string): DemiDomain[] {
  const out: DemiDomain[] = [];
  const lines = text.split("\n");

  let have = false;
  let curId = "";
  let curLabel = "";
  let curScale = "system";
  let curCanvas = "";
  let curKeywords: string[] = [];
  let curPrereqs: string[] = [];

  const flush = (): void => {
    if (have && curLabel.length > 0) {
      out.push({
        id: curId,
        label: curLabel,
        scale: curScale,
        canvasMode: curCanvas,
        keywords: curKeywords,
        prerequisites: curPrereqs,
      });
    }
  };

  for (let i = 0; i <= lines.length; i++) {
    let isHeader = false;
    let headerId = "";
    let raw = "";
    if (i < lines.length) {
      raw = stripComment(lines[i]);
      const line = trim(raw);
      if (line.length === 0) continue;
      if (line.startsWith("[") && line.endsWith("]")) {
        isHeader = true;
        headerId = trim(line.slice(1, -1));
      }
    }
    if (i === lines.length || isHeader) {
      flush();
      if (i === lines.length) break;
      // open the new section
      have = true;
      curId = headerId;
      curLabel = "";
      curScale = "system";
      curCanvas = "";
      curKeywords = [];
      curPrereqs = [];
      continue;
    }
    // key = value
    const line = trim(raw);
    const eq = line.indexOf("=");
    if (eq < 0) continue;
    const key = trim(line.slice(0, eq));
    const val = trim(line.slice(eq + 1));
    if (key === "label") curLabel = unquote(val);
    else if (key === "canvas_mode") curCanvas = unquote(val);
    else if (key === "facets.scale") curScale = unquote(val);
    else if (key === "prerequisites") {
      if (isList(val)) curPrereqs = splitList(listInner(val));
    } else if (key === "keywords") {
      if (isList(val)) curKeywords = splitList(listInner(val));
    }
  }
  return out;
}

// ── parseDomainDemi(text) → DemiManifest (cellrun Phase-A dialect) ────────────
// `[cell.<verb>]` section headers, `key = value` lines, and a multi-line
// `scope_caveats = [ "...", "..." ]` array (the `[` opens, lines accumulate until
// the matching `]`). gate_default / absorbed_default are the HONEST verify-state
// SSOT. A non-cell section (or a bare `[id]`-style header that is not `cell.*`)
// closes the current cell without opening a new one. Other keys are ignored —
// cosmos only needs verb + gate + absorbed + caveats.
export function parseDomainDemi(text: string): DemiManifest {
  const cells: DemiCell[] = [];
  const lines = text.split("\n");

  let inCell = false;
  let curVerb = "";
  let curGate = "OPEN";
  let curAbsorbed = false;
  let curCaveats: string[] = [];

  // multi-line list accumulation (for scope_caveats = [ ... ] spanning lines)
  let inList = false;
  let listBuf = "";

  const flush = (): void => {
    if (inCell && curVerb.length > 0) {
      cells.push({
        verb: curVerb,
        gateDefault: curGate,
        absorbedDefault: curAbsorbed,
        caveats: curCaveats,
      });
    }
  };

  for (let i = 0; i < lines.length; i++) {
    const raw = lines[i];

    // Inside a multi-line list literal — accumulate raw until the closing `]`.
    if (inList) {
      const closeIdx = raw.indexOf("]");
      if (closeIdx < 0) {
        listBuf += raw + "\n";
        continue;
      }
      listBuf += raw.slice(0, closeIdx);
      curCaveats = splitList(listBuf);
      inList = false;
      listBuf = "";
      continue;
    }

    const stripped = stripComment(raw);
    const line = trim(stripped);
    if (line.length === 0) continue;

    // section header `[...]`
    if (line.startsWith("[") && line.endsWith("]")) {
      flush();
      const head = trim(line.slice(1, -1));
      if (head.startsWith("cell.")) {
        inCell = true;
        curVerb = head.slice("cell.".length);
        curGate = "OPEN";
        curAbsorbed = false;
        curCaveats = [];
      } else {
        // a non-cell section closes the current cell (and is not a cell itself)
        inCell = false;
        curVerb = "";
      }
      continue;
    }

    if (!inCell) continue;

    const eq = line.indexOf("=");
    if (eq < 0) continue;
    const key = trim(line.slice(0, eq));
    const val = trim(line.slice(eq + 1));
    if (key === "gate_default") {
      curGate = unquote(val).toUpperCase();
    } else if (key === "absorbed_default") {
      curAbsorbed = unquote(val).toLowerCase() === "true";
    } else if (key === "scope_caveats") {
      if (isList(val)) {
        curCaveats = splitList(listInner(val));
      } else if (trim(val).startsWith("[")) {
        // multi-line list opens here; accumulate until the closing `]`.
        // NOTE: caveat text may contain `#` (e.g. "PR #168"), but cellrun
        // .demi caveats are quoted strings and do not use mid-line comments,
        // so stripComment on the OPENING line only is acceptable; the inner
        // lines are taken raw (above) to preserve any `#` inside quotes.
        inList = true;
        listBuf = trim(val).slice(1) + "\n";
      }
    }
  }
  flush();
  return { cells };
}
