// /structure/[...domain] — 8-verb shell with R3F-equivalent CSS-3D viewer.
// QUBIT 도메인 = Josephson junction scene (Q14′ 데모) · 그 외 = generic stub.
// catch-all [...domain] so nested meta/sub ids (e.g. CARDIO+/DAPTPGX) route as
// path segments; flat ids (RTSC) arrive as a 1-element array. Joined with "/".

import { VerbShell } from "@/components/VerbShell";
import { StructureViewer } from "@/components/StructureViewer";
import { JosephsonScene } from "@/components/JosephsonScene";

export const dynamic = "force-dynamic";

export default async function Page({
  params,
}: {
  params: Promise<{ domain: string[] }>;
}) {
  const { domain: seg } = await params;
  const domain = (seg ?? []).map(decodeURIComponent).join("/");
  // Compare on the leaf segment so the QUBIT scene still triggers for
  // /structure/qubit (flat); nested ids never collide here.
  const leaf = (seg?.[seg.length - 1] ?? "").toLowerCase();
  const slot =
    leaf === "qubit" ? (
      <JosephsonScene />
    ) : (
      <StructureViewer
        atoms={[
          { x: 0, y: 0, z: 0, color: "#64748b", label: domain },
          { x: 1, y: 0.5, z: 0.3, color: "#94a3b8" },
          { x: -1, y: 0.5, z: 0.3, color: "#94a3b8" },
          { x: 0, y: -1, z: 0.5, color: "#cbd5e1" },
        ]}
        caption={`${domain} · structure stub`}
      />
    );
  return (
    <VerbShell
      verb="structure"
      domain={domain}
      statusByVerb={{}}
      slot={slot}
    />
  );
}
