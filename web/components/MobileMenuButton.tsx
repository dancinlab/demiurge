// MobileMenuButton — TopBar 좌측 햄버거(client). < md 에서만 표시.
// AppShell 컨텍스트의 toggleDrawer 로 off-canvas 좌 레일을 연다.
// aria-label 은 다국어 prop(i18n) — 하드코딩 텍스트 없음.

"use client";

import { Menu } from "lucide-react";
import { useAppShell } from "@/components/AppShell";

export function MobileMenuButton({ label }: { label: string }) {
  const { toggleDrawer, drawerOpen } = useAppShell();
  return (
    <button
      type="button"
      onClick={toggleDrawer}
      aria-label={label}
      aria-expanded={drawerOpen}
      className="-ml-1 shrink-0 rounded-control p-1.5 text-muted hover:bg-surface-strong hover:text-ink md:hidden"
    >
      <Menu className="h-5 w-5" aria-hidden="true" />
    </button>
  );
}
