// TopBar — server component. Pure presentation: user, activeDomain, and i18n
// strings all come as props from (app)/layout.tsx.
// ElevenLabs 톤: 흰 surface 바 · hairline 보더 · 우측 액션 클러스터(Docs · 알림 · 계정).
// 클라 상호작용(아바타 드롭다운)만 AccountMenu(client)로 분리 — TopBar 는 server 유지.

import Link from "next/link";
import { BookOpen, Bell } from "lucide-react";
import { AccountMenu } from "@/components/AccountMenu";
import { ThemeToggle } from "@/components/ThemeToggle";

// 테마 토글(Light↔Dark)은 우상단 ☀️/🌙 (ThemeToggle, client). ElevenLabs 다크 팔레트.

type TopBarUser = { email: string; role?: string };

type TopBarI18n = {
  topbarDomains: string;
  topbarActiveProject: string;
  topbarSignIn: string;
  topbarAdmin: string;
};

export function TopBar({
  user,
  i18n,
}: {
  user: TopBarUser | null;
  // activeDomain kept for caller compat — 도메인명 칩 폐기 (브랜드는 사이드바 일원화).
  activeDomain?: string | null;
  i18n: TopBarI18n;
}) {
  // ElevenLabs 상단 우측: Docs · 알림 벨 · domains · admin(조건) · 계정 아바타.
  return (
    <header className="flex items-center gap-3 border-b border-hairline bg-surface px-5 py-3 text-sm">
      <span className="flex-1" />
      <ThemeToggle />
      <a
        href="https://demiurge.dancinlab.org"
        target="_blank"
        rel="noreferrer"
        className="flex items-center gap-1.5 rounded-full px-2 py-1 text-xs text-muted hover:bg-surface-strong hover:text-ink"
      >
        <BookOpen className="h-4 w-4" aria-hidden="true" />
        Docs
      </a>
      <Link
        href="/account"
        aria-label="Notifications"
        className="rounded-full p-1.5 text-muted hover:bg-surface-strong hover:text-ink"
      >
        <Bell className="h-4 w-4" aria-hidden="true" />
      </Link>
      <Link
        href="/dashboard"
        className="rounded-full px-2 py-1 text-xs text-muted hover:bg-surface-strong hover:text-ink"
      >
        {i18n.topbarDomains}
      </Link>
      {user?.role === "admin" && (
        <Link
          href="/admin"
          className="rounded-full border border-danger/20 bg-danger/5 px-2 py-1 text-xs text-danger hover:bg-danger/10"
        >
          ⚙️ {i18n.topbarAdmin}
        </Link>
      )}
      {user ? (
        <AccountMenu email={user.email} />
      ) : (
        <Link
          href="/signin"
          className="rounded-full bg-primary px-3 py-1 text-xs font-medium text-on-primary hover:bg-primary-active"
        >
          {i18n.topbarSignIn}
        </Link>
      )}
    </header>
  );
}
