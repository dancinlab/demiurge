// MarketingMobileNav — Brutalist mobile nav for the PUBLIC SiteHeader.
// Client-only hamburger toggle, shown < md. Hydration-safe: closed on both
// server + client first paint (useState(false)). Desktop (≥ md) keeps the
// inline horizontal nav rendered by SiteHeader; this whole block is md:hidden.
// Receives already-translated links + labels as props (no i18n here so the
// server header owns locale resolution).

"use client";

import { useState } from "react";
import Link from "next/link";

export type MarketingNavLink = { href: string; label: string };

export function MarketingMobileNav({
  links,
  openLabel,
  closeLabel,
  langSwitcher,
}: {
  links: MarketingNavLink[];
  openLabel: string;
  closeLabel: string;
  langSwitcher: React.ReactNode;
}) {
  const [open, setOpen] = useState(false);

  return (
    <div className="md:hidden">
      <button
        type="button"
        onClick={() => setOpen((v) => !v)}
        aria-expanded={open}
        aria-label={open ? closeLabel : openLabel}
        className="flex h-10 w-10 items-center justify-center border-2 border-white text-white hover:bg-yellow-300 hover:text-black"
      >
        {/* hamburger / close glyph — pure CSS bars, no extra deps */}
        <span className="relative block h-4 w-5" aria-hidden="true">
          <span
            className={
              "absolute left-0 block h-0.5 w-5 bg-current transition-all " +
              (open ? "top-1/2 -translate-y-1/2 rotate-45" : "top-0")
            }
          />
          <span
            className={
              "absolute left-0 top-1/2 block h-0.5 w-5 -translate-y-1/2 bg-current transition-all " +
              (open ? "opacity-0" : "opacity-100")
            }
          />
          <span
            className={
              "absolute left-0 block h-0.5 w-5 bg-current transition-all " +
              (open ? "top-1/2 -translate-y-1/2 -rotate-45" : "bottom-0")
            }
          />
        </span>
      </button>

      {open && (
        <nav className="absolute inset-x-0 top-14 z-50 border-b-4 border-white bg-black px-6 py-4 text-sm uppercase">
          <ul className="flex flex-col gap-2">
            {links.map((l) => (
              <li key={l.href}>
                <Link
                  href={l.href}
                  onClick={() => setOpen(false)}
                  className="block border-2 border-white px-4 py-3 text-center font-black tracking-wider hover:bg-yellow-300 hover:text-black"
                >
                  {l.label}
                </Link>
              </li>
            ))}
          </ul>
          <div className="mt-4 flex justify-center">{langSwitcher}</div>
        </nav>
      )}
    </div>
  );
}
