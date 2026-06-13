// /library — ABSORBED into the dashboard domain browser (#6b).
//
// library (공개 도메인 갤러리) is no longer a separate top-level concept — it is a
// VIEW of the single "domain" concept, surfaced as the "public" tab inside the
// dashboard's DomainBrowser (the LibraryGallery component is reused there). This
// route is kept only as a permanent redirect so any old bookmark lands on the
// unified surface.

import { redirect } from "next/navigation";

export const dynamic = "force-dynamic";

export default function LibraryPage() {
  redirect("/dashboard");
}
