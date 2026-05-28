// /analyze/[...domain] — slot = analyze-specific Q12 viewer.
// catch-all [...domain] so nested meta/sub ids (e.g. CARDIO+/DAPTPGX) route as
// path segments; flat ids (RTSC) arrive as a 1-element array. Joined with "/".

import { VerbShell } from "@/components/VerbShell";
import { pickSlot } from "@/components/slots/SlotViewers";

export const dynamic = "force-dynamic";

export default async function Page({ params }: { params: Promise<{ domain: string[] }> }) {
  const { domain: seg } = await params;
  const domain = (seg ?? []).map(decodeURIComponent).join("/");
  return (
    <VerbShell
      verb="analyze"
      domain={domain}
      statusByVerb={{}}
      slot={pickSlot("analyze", domain)}
    />
  );
}
