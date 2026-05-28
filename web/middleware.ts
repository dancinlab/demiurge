// Next.js 16 canonical auth gate — single source of truth for "is signed in?"
// and "what's the active domain?". Page components can assume currentUser()
// is non-null AND cookies.active is in sync with the URL's ?d= for any
// /(app)/* route.

import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

// Routes under /(app) that require a session.
// library/matter are no longer first-class routes (#6b) — they redirect to
// /dashboard (still gated). Kept here so the redirect itself stays behind auth.
const PROTECTED = /^\/(dashboard|spec|structure|design|analyze|synth|verify|handoff|discover|library|matter|admin|account)(\/.*)?$/;

const ACTIVE_COOKIE = "demiurge.active.domain";

export function middleware(req: NextRequest) {
  const { pathname, searchParams } = req.nextUrl;
  if (!PROTECTED.test(pathname)) return NextResponse.next();

  // 1) Auth gate — no session cookie → /signin?next=<url>
  const session = req.cookies.get("demiurge_session");
  if (!session) {
    const url = req.nextUrl.clone();
    url.pathname = "/signin";
    url.searchParams.set("next", pathname + req.nextUrl.search);
    return NextResponse.redirect(url);
  }

  // 2) Active-domain sync — ?d=<NAME> in URL becomes the cookie SSOT.
  //    This is the canonical single entry: any link/redirect that carries
  //    ?d= updates the cookie, so subsequent verb-only landings + the
  //    (app) layout can read it without a client round-trip.
  const d = searchParams.get("d");
  const res = NextResponse.next();
  if (d) {
    const existing = req.cookies.get(ACTIVE_COOKIE)?.value;
    if (existing !== d) {
      res.cookies.set({
        name: ACTIVE_COOKIE,
        value: d,
        httpOnly: false,
        sameSite: "lax",
        path: "/",
        maxAge: 60 * 60 * 24 * 365,
      });
    }
  }
  return res;
}

export const config = {
  matcher: ["/((?!api|_next/static|_next/image|favicon.ico|icon.svg|robots.txt).*)"],
};
