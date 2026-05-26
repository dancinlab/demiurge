// POST /api/lang { locale: "en"|"ko"|"ja"|"zh"|"ru" } → set lang cookie.

import { cookies } from "next/headers";
import { LOCALES, type Locale } from "@/lib/i18n";

const ALLOWED = new Set<string>(LOCALES);

export async function POST(request: Request) {
  let body: { locale?: unknown };
  try {
    body = await request.json();
  } catch {
    return Response.json({ error: "invalid JSON body" }, { status: 400 });
  }
  const locale = body.locale;
  if (typeof locale !== "string" || !ALLOWED.has(locale)) {
    return Response.json({ error: "locale must be one of en|ko|ja|zh|ru" }, { status: 400 });
  }
  const jar = await cookies();
  jar.set({
    name: "lang",
    value: locale,
    httpOnly: false, // client-readable so LangSwitcher can sync UI
    sameSite: "lax",
    secure: process.env.NODE_ENV === "production",
    path: "/",
    maxAge: 60 * 60 * 24 * 365, // 1 year
  });
  return Response.json({ ok: true, locale: locale as Locale });
}
