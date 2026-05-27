"use client";

// next-themes provider — class-based color mode (light/dark).
// Toggles `.dark` on <html>, which our globals @custom-variant keys off.
// Handles no-flash + persistence; replaces the hand-rolled ThemeScript.
// forcedTheme 제거 — ThemeToggle 로 light↔dark 토글 활성화 (ElevenLabs 다크 팔레트).

import { ThemeProvider as NextThemes } from "next-themes";

export function ThemeProvider({ children }: { children: React.ReactNode }) {
  return (
    <NextThemes
      attribute="class"
      defaultTheme="light"
      enableSystem={false}
      storageKey="demiurge-theme-3"
      disableTransitionOnChange
    >
      {children}
    </NextThemes>
  );
}
