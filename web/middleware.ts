// Next.js 16 canonical auth gate — single source of truth for "is signed in?".
// Page components can assume currentUser() is non-null for any /(app)/* route.
// Edge runtime only checks cookie presence; full verify still happens server-side.

import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

// Routes under /(app) that require a session.
const PROTECTED = /^\/(dashboard|spec|structure|design|analyze|synth|verify|handoff|discover|library|matter|admin|account)(\/.*)?$/;

export function middleware(req: NextRequest) {
  const { pathname } = req.nextUrl;
  if (!PROTECTED.test(pathname)) return NextResponse.next();
  const session = req.cookies.get("demiurge_session");
  if (!session) {
    const url = req.nextUrl.clone();
    url.pathname = "/signin";
    url.searchParams.set("next", pathname + req.nextUrl.search);
    return NextResponse.redirect(url);
  }
  return NextResponse.next();
}

export const config = {
  // Skip Next internals, API routes (own auth), static assets.
  matcher: ["/((?!api|_next/static|_next/image|favicon.ico|icon.svg|robots.txt).*)"],
};
