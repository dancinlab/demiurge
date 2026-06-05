// GET /api/structure — server-side mmCIF proxy for the Mol* fold viewer (§9.1b).
//
// Given a structure ref (`?source=alphafold&id=Q8N474` or `?source=pdb&id=3ZLR`),
// fetch the mmCIF upstream SERVER-SIDE and stream it back. This:
//   - dodges browser CORS (the upstream hosts do not set permissive CORS for a
//     fetch from our origin),
//   - lets Next/CDN cache the (immutable) structure file,
//   - keeps the id on a strict allow-list (no SSRF — we never interpolate an
//     arbitrary URL; the id is regex-validated and slotted into a fixed template).
//
// Upstream URLs (COSMOS.md §9.1b/c):
//   alphafold → https://alphafold.ebi.ac.uk/files/AF-<ID>-F1-model_v4.cif
//               (pLDDT confidence is in the B-factor column · viewer format=cif)
//   pdb       → https://files.rcsb.org/download/<ID>.cif (viewer format=cif)
//   pubchem   → https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/<CID>/SDF
//               ?record_type=3d (small molecule · viewer format=sdf · 3D→2D fallback)
//
// Resp: 200 text/plain (mmCIF / SDF body) on success · 400 on a bad source/id ·
//       502 on an upstream failure (network or non-2xx).

// id allow-lists (SSRF-safe — no dots/slashes/path chars, slotted into a fixed
// template): protein id = 4–10 alphanumerics (4-char PDB code · UniProt accession
// like Q8N474 / A0A0B4J2F0); pubchem CID = 1–9 digits.
const ID_RE = /^[A-Za-z0-9]{4,10}$/;
const CID_RE = /^[0-9]{1,9}$/;

function idValid(source: string, id: string): boolean {
  return source === "pubchem" ? CID_RE.test(id) : ID_RE.test(id);
}

function upstreamUrl(source: string, id: string): string | null {
  if (source === "alphafold") {
    // Fallback template — the model version bumps over time (v4→v6→…); the GET
    // handler resolves the REAL cifUrl from the prediction API first, and only
    // falls back to this template (current latest = v6) if that lookup fails.
    return `https://alphafold.ebi.ac.uk/files/AF-${id}-F1-model_v6.cif`;
  }
  if (source === "pdb") {
    return `https://files.rcsb.org/download/${id}.cif`;
  }
  if (source === "pubchem") {
    return `https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/${id}/SDF?record_type=3d`;
  }
  return null;
}

export async function GET(req: Request): Promise<Response> {
  const { searchParams } = new URL(req.url);
  const source = searchParams.get("source") ?? "";
  const id = searchParams.get("id") ?? "";

  const url = upstreamUrl(source, id);
  if (!url) {
    return Response.json(
      { error: "invalid source (expected 'alphafold', 'pdb', or 'pubchem')" },
      { status: 400 },
    );
  }
  if (!idValid(source, id)) {
    return Response.json(
      { error: "invalid id (protein: 4–10 alphanumerics · pubchem CID: 1–9 digits)" },
      { status: 400 },
    );
  }

  const doFetch = (u: string): Promise<Response> =>
    fetch(u, {
      // Structures are immutable — cache aggressively at the Next data layer.
      cache: "force-cache",
      headers: { Accept: "chemical/x-cif, chemical/x-mdl-sdfile, text/plain, */*" },
    });

  // AlphaFold: resolve the ACTUAL current cifUrl from the prediction API (the
  // model version bumps over time, e.g. v4→v6) — fall back to the template url.
  let fetchUrl = url;
  if (source === "alphafold") {
    try {
      const pred = await fetch(`https://alphafold.ebi.ac.uk/api/prediction/${id}`, {
        cache: "force-cache",
      });
      if (pred.ok) {
        const arr = (await pred.json()) as Array<{ cifUrl?: string }>;
        const cifUrl = arr?.[0]?.cifUrl;
        if (typeof cifUrl === "string" && cifUrl.startsWith("https://alphafold.ebi.ac.uk/")) {
          fetchUrl = cifUrl;
        }
      }
    } catch {
      /* keep the template url */
    }
  }

  let upstream: Response;
  try {
    upstream = await doFetch(fetchUrl);
    // PubChem: not every CID has a precomputed 3D conformer → fall back to 2D.
    if (source === "pubchem" && upstream.status === 404) {
      upstream = await doFetch(
        `https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/${id}/SDF?record_type=2d`,
      );
    }
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    return Response.json({ error: `upstream fetch failed: ${msg}` }, { status: 502 });
  }

  if (!upstream.ok) {
    return Response.json(
      { error: `upstream ${source} returned ${upstream.status} for ${id}` },
      { status: 502 },
    );
  }

  const body = await upstream.text();
  return new Response(body, {
    status: 200,
    headers: {
      "Content-Type": "text/plain; charset=utf-8",
      // immutable structure → long-lived shared cache + SWR safety net.
      "Cache-Control": "public, max-age=86400, s-maxage=604800, stale-while-revalidate=86400",
    },
  });
}
