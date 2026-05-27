"use client";

// AccountMenu — 계정 아바타 드롭다운 (client). 이메일 첫 글자 아바타 클릭 시
// Account · Settings · Sign out 메뉴를 연다. ElevenLabs 상단 우측 톤.
// 시맨틱 토큰만 — 액센트색 없음.

import Link from "next/link";
import { useState } from "react";
import { User, Settings, LogOut } from "lucide-react";

export function AccountMenu({ email }: { email: string }) {
  const [open, setOpen] = useState(false);
  const initial = email.trim().charAt(0).toUpperCase() || "?";

  return (
    <div className="relative">
      <button
        type="button"
        aria-label={email}
        aria-haspopup="menu"
        aria-expanded={open}
        onClick={() => setOpen((v) => !v)}
        className="grid h-8 w-8 place-items-center rounded-full bg-inverted text-xs font-medium text-on-inverted hover:opacity-90"
      >
        {initial}
      </button>

      {open && (
        <>
          {/* 바깥 클릭 닫기 — 투명 backdrop */}
          <div
            className="fixed inset-0 z-40"
            aria-hidden="true"
            onClick={() => setOpen(false)}
          />
          <div
            role="menu"
            className="absolute right-0 z-50 mt-2 w-56 rounded-card border border-hairline bg-surface p-1.5 shadow-card"
          >
            <div className="px-2 py-1.5 text-xs text-muted">{email}</div>
            <div className="my-1 border-t border-hairline" />
            <Link
              href="/account"
              role="menuitem"
              onClick={() => setOpen(false)}
              className="flex items-center gap-2 rounded-chip px-2 py-1.5 text-sm text-body hover:bg-surface-strong"
            >
              <User className="h-4 w-4" aria-hidden="true" />
              Account
            </Link>
            <Link
              href="/account"
              role="menuitem"
              onClick={() => setOpen(false)}
              className="flex items-center gap-2 rounded-chip px-2 py-1.5 text-sm text-body hover:bg-surface-strong"
            >
              <Settings className="h-4 w-4" aria-hidden="true" />
              Settings
            </Link>
            <Link
              href="/signin"
              role="menuitem"
              onClick={() => setOpen(false)}
              className="flex items-center gap-2 rounded-chip px-2 py-1.5 text-sm text-body hover:bg-surface-strong"
            >
              <LogOut className="h-4 w-4" aria-hidden="true" />
              Sign out
            </Link>
          </div>
        </>
      )}
    </div>
  );
}
