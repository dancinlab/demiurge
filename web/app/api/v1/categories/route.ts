// GET /api/v1/categories
//
// Returns the 5-category × 20-domain index (`domains/CATEGORIES.tape`) as JSON.
// Public — drives the left-nav category tree in the GUI.

import { NextResponse } from "next/server";
import { loadTape } from "@/lib/tape";

export const runtime = "nodejs";

export async function GET() {
  try {
    const nodes = await loadTape("domains/CATEGORIES.tape");
    const categories = nodes
      .filter((n) => n.type === "C")
      .map((n) => ({
        id: n.id,
        icon: n.fields.icon ?? "",
        name: n.fields.name ?? n.id,
        alias: n.fields.alias ?? "",
        members: Array.isArray(n.fields.members) ? n.fields.members : [],
      }));
    const rollup = nodes.find((n) => n.id === "rollup_categories")?.fields ?? {};
    return NextResponse.json({ categories, rollup });
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : String(e);
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
