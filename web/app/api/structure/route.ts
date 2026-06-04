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
//               (pLDDT confidence is in the B-factor column)
//   pdb       → https://files.rcsb.org/download/<ID>.cif
//
// Resp: 200 text/plain (mmCIF body) on success · 400 on a bad source/id ·
//       502 on an upstream failure (network or non-2xx).

// id allow-list: 4–10 alphanumerics (covers a 4-char PDB code + a UniProt
// accession like Q8N474 / A0A0B4J2F0). No dots, slashes, or path chars → SSRF-safe.
const ID_RE = /^[A-Za-z0-9]{4,10}$/;

function upstreamUrl(source: string, id: string): string | null {
  if (source === "alphafold") {
    return `https://alphafold.ebi.ac.uk/files/AF-${id}-F1-model_v4.cif`;
  }
  if (source === "pdb") {
    return `https://files.rcsb.org/download/${id}.cif`;
  }
  return null;
}

export async function GET(req: Request): Promise<Response> {
  const { searchParams } = new URL(req.url);
  const source = searchParams.get("source") ?? "";
  const id = searchParams.get("id") ?? "";

  if (!ID_RE.test(id)) {
    return Response.json(
      { error: "invalid id (expected 4–10 alphanumerics)" },
      { status: 400 },
    );
  }
  const url = upstreamUrl(source, id);
  if (!url) {
    return Response.json(
      { error: "invalid source (expected 'alphafold' or 'pdb')" },
      { status: 400 },
    );
  }

  let upstream: Response;
  try {
    upstream = await fetch(url, {
      // Structures are immutable — cache aggressively at the Next data layer.
      cache: "force-cache",
      headers: { Accept: "chemical/x-cif, text/plain, */*" },
    });
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
