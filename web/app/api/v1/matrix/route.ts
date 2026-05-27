// GET /api/v1/matrix
//
// Returns the porting-status matrix (`domains/STDLIB_MATRIX.tape`) as JSON.
// Public — no auth required (governance manifest is open by design).
//
// Optional ?status=📋 filter — substring match against the analyze/verify/scaffold lines.

import { NextRequest, NextResponse } from "next/server";
import { loadTape } from "@/lib/tape";

export const runtime = "nodejs";

export async function GET(req: NextRequest) {
  const status = req.nextUrl.searchParams.get("status");
  try {
    const nodes = await loadTape("domains/STDLIB_MATRIX.tape");
    const domains = nodes
      .filter((n) => n.type === "D")
      .map((n) => ({
        id: n.id,
        category: n.fields.category ?? "",
        analyze: n.fields.analyze ?? "",
        verify: n.fields.verify ?? "",
        scaffold: n.fields.scaffold ?? "",
      }))
      .filter((d) => {
        if (!status) return true;
        const blob = `${d.analyze}${d.verify}${d.scaffold}`;
        return blob.includes(status);
      });
    const rollup = nodes.find((n) => n.id === "rollup_summary")?.fields ?? {};
    return NextResponse.json({ domains, rollup });
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : String(e);
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
