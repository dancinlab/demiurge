// /verify/[...domain] — slot = §6 3D-first verb surface (DomainModel3D-centric).
// 대조 저울 (our value vs reference QE); result badge stamps onto the node.
// catch-all [...domain] so nested meta/sub ids (e.g. CARDIO+/DAPTPGX) route as
// path segments; flat ids (RTSC) arrive as a 1-element array. Joined with "/".

import { VerbShell } from "@/components/VerbShell";
import { VerbSurfaceSection } from "@/components/verb-surfaces/VerbSurfaceSection";

export const dynamic = "force-dynamic";

export default async function Page({ params }: { params: Promise<{ domain: string[] }> }) {
  const { domain: seg } = await params;
  const domain = (seg ?? []).map(decodeURIComponent).join("/");
  return (
    <VerbShell
      verb="verify"
      domain={domain}
      statusByVerb={{}}
      slot={<VerbSurfaceSection verb="verify" domain={domain} />}
    />
  );
}
