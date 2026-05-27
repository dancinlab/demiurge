// GET /api/v1/matter — material attestation/verdict ledger.
// Pulls from exports/material_{attestation,verdict}/<material>/*.json.

import { NextResponse } from "next/server";
import { readMatterLedger } from "@/lib/matter";

export const runtime = "nodejs";

export async function GET() {
  try {
    const rows = await readMatterLedger();
    return NextResponse.json({ rows });
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : String(e);
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
