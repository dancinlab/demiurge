"use client";

// next-themes provider — class-based color mode (system/light/dark).
// Toggles `.dark` on <html>, which our globals @custom-variant keys off.
// Handles no-flash + persistence; replaces the hand-rolled ThemeScript.

import { ThemeProvider as NextThemes } from "next-themes";

export function ThemeProvider({ children }: { children: React.ReactNode }) {
  return (
    <NextThemes
      attribute="class"
      defaultTheme="system"
      enableSystem
      storageKey="demiurge-theme"
      disableTransitionOnChange
    >
      {children}
    </NextThemes>
  );
}
