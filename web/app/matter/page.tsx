// /matter — ABSORBED into the dashboard domain browser (#6b).
//
// matter (소재 원장) is no longer a separate top-level concept — it is a VIEW of
// the single "domain" concept, surfaced as the "matter" tab inside the
// dashboard's DomainBrowser (the MatterLedger component is reused there). This
// route is kept only as a permanent redirect so any old bookmark lands on the
// unified surface.

import { redirect } from "next/navigation";

export const dynamic = "force-dynamic";

export default function MatterPage() {
  redirect("/dashboard");
}
