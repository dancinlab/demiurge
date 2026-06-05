// WorkButton — P5 node→work-page nav control (8VERB Cosmos D4 page-routing).
//
// A tiny client island used on the server-rendered /d/<DOMAIN> detail page:
// `router.push("/<verb>/<domain>")` gives REAL page navigation, and browser
// back returns to /cosmos (or wherever the user came from). Default verb is the
// pipeline head `discover`.

"use client";

import { useRouter } from "next/navigation";

export function WorkButton({
  domain,
  verb = "discover",
  label,
}: {
  domain: string;
  verb?: string;
  /** REQUIRED — the i18n-resolved button copy (no literal fallback, P6 §1). */
  label: string;
}) {
  const router = useRouter();
  return (
    <button
      onClick={() => router.push(`/${verb}/${encodeURIComponent(domain)}`)}
      className="rounded-full bg-primary px-4 py-1.5 text-sm font-medium text-on-primary hover:bg-primary-active focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-primary"
    >
      {label}
    </button>
  );
}

export default WorkButton;
