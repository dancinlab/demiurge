// /structure/[...domain] — slot = §6 3D-first verb surface (DomainModel3D-centric).
// The node's 3D model assembly (parts visible in 3D) per §6.
// catch-all [...domain] so nested meta/sub ids (e.g. CARDIO+/DAPTPGX) route as
// path segments; flat ids (RTSC) arrive as a 1-element array. Joined with "/".

import { VerbShell } from "@/components/VerbShell";
import { VerbSurfaceSection } from "@/components/verb-surfaces/VerbSurfaceSection";

export const dynamic = "force-dynamic";

export default async function Page({
  params,
}: {
  params: Promise<{ domain: string[] }>;
}) {
  const { domain: seg } = await params;
  const domain = (seg ?? []).map(decodeURIComponent).join("/");
  return (
    <VerbShell
      verb="structure"
      domain={domain}
      statusByVerb={{}}
      slot={<VerbSurfaceSection verb="structure" domain={domain} />}
    />
  );
}
