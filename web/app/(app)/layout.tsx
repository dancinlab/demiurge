// (app) — ElevenLabs 톤. Server Component: reads currentUser, active domain,
// AND i18n messages in one place. Strings flow down as props — no client t().

import Link from "next/link";
import { cookies } from "next/headers";
import { ThemeProvider } from "@/components/ThemeProvider";
import { TopBar } from "@/components/TopBar";
import { VerbTreeNav } from "@/components/VerbTreeNav";
import { CookChefRail } from "@/components/CookChefRail";
import { currentUser } from "@/lib/session";
import { getLocale, getMessages, t } from "@/lib/i18n";

export default async function AppLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  const [user, c, messages, locale] = await Promise.all([
    currentUser(),
    cookies(),
    getMessages(),
    getLocale(),
  ]);
  const activeDomain = c.get("demiurge.active.domain")?.value ?? null;
  const safeUser = user
    ? { email: user.email ?? "", role: (user as { role?: string }).role }
    : null;

  // Pull every layout-level string up here so client components stay pure
  // presentation (no t() · no Messages import · serializable props only).
  const i18n = {
    topbarDomains: t(messages, "app_gui.topbar_domains"),
    topbarActiveProject: t(messages, "app_gui.topbar_active_project"),
    topbarWorkbench: t(messages, "dashboard.title"),
    topbarSignIn: t(messages, "app_gui.sign_in"),
    topbarAdmin: t(messages, "app_gui.admin"),
    chefTitle: t(messages, "app_gui.chef_title"),
    chefAwaiting: t(messages, "app_gui.chef_awaiting_domain"),
    chefReady: t(messages, "app_gui.chef_ready"),
    verbtreeCollapse: t(messages, "app_gui.verbtree_collapse"),
    verbtreeExpand: t(messages, "app_gui.verbtree_expand"),
    verbtree8Verbs: t(messages, "app_gui.verbtree_8verbs"),
  };

  // Chat (요리선생) strings — passed to AssistChat via CookChefRail.
  const chatI18n = {
    greeting: t(messages, "app_gui.chat_greeting"),
    placeholder: t(messages, "app_gui.chat_placeholder"),
    send: t(messages, "app_gui.chat_send"),
    clear: t(messages, "app_gui.chat_clear"),
    thinking: t(messages, "app_gui.chat_thinking"),
    seedSpec: t(messages, "app_gui.chat_seed_spec"),
    seedStructure: t(messages, "app_gui.chat_seed_structure"),
    seedVerify: t(messages, "app_gui.chat_seed_verify"),
    seedSimilar: t(messages, "app_gui.chat_seed_similar"),
    seedNewDiscover: t(messages, "app_gui.chat_seed_new_discover"),
    seedSpecHowto: t(messages, "app_gui.chat_seed_spec_howto"),
    seedRef: t(messages, "app_gui.chat_seed_ref"),
  };

  return (
    <ThemeProvider>
      {/* ElevenLabs 톤(Create 페이지): 좌 레일=canvas(웜 그레이 틴트) | 우 메인=surface(흰색) */}
      <div className="flex h-screen bg-canvas text-ink antialiased [font-family:var(--font-inter),system-ui,sans-serif]">
        {/* 좌: 세로 전체 레일 — canvas 틴트(복구). 최상단 브랜드 로고 + verb(상단) + 요리선생 채팅(하단) */}
        <aside className="flex w-72 shrink-0 flex-col border-r border-hairline bg-canvas">
          {/* 브랜드 로고 — 랜딩 SiteHeader 워드마크와 폰트 100% 동일:
              시스템 산세리프 · font-black · uppercase · 22px · letterSpacing -0.04em · 노랑 닷.
              본체만 text-ink 토큰(다크 자동 추종) — 랜딩은 검정 위 white(배경만 다름).
              여백 px-4 = 8verb 메뉴 좌측 인셋(래퍼 p-2 + 아이템 px-2 = 16px)과 동일 정렬. */}
          <Link
            href="/dashboard"
            aria-label="demiurge — home"
            className="flex shrink-0 items-center px-4 py-3 hover:opacity-80"
          >
            <span
              className="font-black uppercase leading-none text-ink"
              style={{
                fontFamily:
                  "ui-sans-serif, system-ui, -apple-system, 'Helvetica Neue', sans-serif",
                fontSize: 22,
                letterSpacing: "-0.04em",
              }}
            >
              demiurge<span className="text-yellow-300">.</span>
            </span>
          </Link>
          <div className="shrink-0 p-2">
            <VerbTreeNav domain={activeDomain ?? undefined} i18n={i18n} />
          </div>
          <div className="min-h-0 flex-1">
            <CookChefRail
              domain={activeDomain ?? ""}
              i18n={i18n}
              chatI18n={chatI18n}
              locale={locale}
            />
          </div>
        </aside>
        {/* 우: TopBar(메인 상단) + main — 흰색 surface 컬럼 */}
        <div className="flex min-w-0 flex-1 flex-col bg-surface">
          <TopBar user={safeUser} activeDomain={activeDomain} i18n={i18n} />
          <main className="min-h-0 flex-1 overflow-auto bg-surface p-6">
            {children}
          </main>
        </div>
      </div>
    </ThemeProvider>
  );
}
