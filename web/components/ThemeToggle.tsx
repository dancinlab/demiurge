"use client";

// ThemeToggle — light↔dark 토글 (ElevenLabs 우상단 ☀️/🌙).
// next-themes useTheme 로 .dark 클래스 토글. globals.css 의 .dark 오버라이드 블록이
// 시맨틱 토큰(canvas·surface·ink·inverted 등)을 전부 다크값으로 뒤집는다.
// mounted 가드 — SSR 에서 theme 미상이라 hydration mismatch 방지 (마운트 전 정적 폴백).

import { useEffect, useState } from "react";
import { useTheme } from "next-themes";
import { Sun, Moon } from "lucide-react";

export function ThemeToggle() {
  const { theme, setTheme } = useTheme();
  const [mounted, setMounted] = useState(false);

  useEffect(() => setMounted(true), []);

  // 마운트 전 — 서버/클라 동일 마크업으로 hydration 안전 (아이콘 자리만 차지).
  if (!mounted) {
    return (
      <button
        type="button"
        aria-label="Toggle theme"
        className="rounded-full p-1.5 text-muted hover:bg-surface-strong hover:text-ink"
      >
        <Sun className="h-4 w-4" aria-hidden="true" />
      </button>
    );
  }

  const isDark = theme === "dark";
  return (
    <button
      type="button"
      aria-label={isDark ? "Switch to light theme" : "Switch to dark theme"}
      onClick={() => setTheme(isDark ? "light" : "dark")}
      className="rounded-full p-1.5 text-muted hover:bg-surface-strong hover:text-ink"
    >
      {isDark ? (
        <Moon className="h-4 w-4" aria-hidden="true" />
      ) : (
        <Sun className="h-4 w-4" aria-hidden="true" />
      )}
    </button>
  );
}
