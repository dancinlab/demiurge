"use client";

// next-themes provider — class-based color mode (system/light/dark).
// Toggles `.dark` on <html>, which our globals @custom-variant keys off.
// Handles no-flash + persistence; replaces the hand-rolled ThemeScript.

import { ThemeProvider as NextThemes } from "next-themes";

export function ThemeProvider({ children }: { children: React.ReactNode }) {
  return (
    <NextThemes
      attribute="class"
      forcedTheme="light"
      defaultTheme="light"
      enableSystem={false}
      storageKey="demiurge-theme-3"
      disableTransitionOnChange
    >
      {children}
    </NextThemes>
  );
}
