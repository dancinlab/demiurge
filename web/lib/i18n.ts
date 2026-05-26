// i18n — App Router native, zero npm deps.
//
// Locales: en · zh · ru · ja · ko (display order: EN · 中文 · Русский · 日本語 · 한국어).
// Resolution order (server side):
//   1. cookie `lang` (set by /api/lang)
//   2. Accept-Language header (best match)
//   3. fallback = en
//
// Dictionaries live as JSON under web/messages/{locale}.json.

import { cookies, headers } from "next/headers";
import enMessages from "@/messages/en.json";
import zhMessages from "@/messages/zh.json";
import ruMessages from "@/messages/ru.json";
import jaMessages from "@/messages/ja.json";
import koMessages from "@/messages/ko.json";

export const LOCALES = ["en", "zh", "ru", "ja", "ko"] as const;
export type Locale = (typeof LOCALES)[number];
export const DEFAULT_LOCALE: Locale = "en";

export const LOCALE_LABEL: Record<Locale, string> = {
  en: "English",
  zh: "中文",
  ru: "Русский",
  ja: "日本語",
  ko: "한국어",
};

const DICTS = {
  en: enMessages,
  zh: zhMessages,
  ru: ruMessages,
  ja: jaMessages,
  ko: koMessages,
} as const;

export type Messages = typeof enMessages;

function parseAcceptLanguage(header: string): Locale | null {
  // very small parser: "ko,en;q=0.9,..." → top match
  const parts = header
    .split(",")
    .map((p) => {
      const [tag, q] = p.trim().split(";q=");
      return { tag: tag.toLowerCase(), q: q ? Number(q) : 1 };
    })
    .sort((a, b) => b.q - a.q);
  for (const { tag } of parts) {
    const base = tag.split("-")[0] as Locale;
    if ((LOCALES as readonly string[]).includes(base)) return base;
  }
  return null;
}

export async function getLocale(): Promise<Locale> {
  const jar = await cookies();
  const cookieVal = jar.get("lang")?.value;
  if (cookieVal && (LOCALES as readonly string[]).includes(cookieVal)) {
    return cookieVal as Locale;
  }
  const hdrs = await headers();
  const accept = hdrs.get("accept-language");
  if (accept) {
    const detected = parseAcceptLanguage(accept);
    if (detected) return detected;
  }
  return DEFAULT_LOCALE;
}

export async function getMessages(): Promise<Messages> {
  const loc = await getLocale();
  return DICTS[loc] as Messages;
}

// Type-safe deep getter: m("home.title") with autocomplete from the
// `en` dictionary. Falls back to the key string on miss.
export function t(messages: Messages, key: string): string {
  const parts = key.split(".");
  let cur: unknown = messages;
  for (const p of parts) {
    if (cur && typeof cur === "object" && p in (cur as Record<string, unknown>)) {
      cur = (cur as Record<string, unknown>)[p];
    } else {
      return key;
    }
  }
  return typeof cur === "string" ? cur : key;
}
