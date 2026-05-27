// (app) — shadcn Modern 톤. Server Component: reads currentUser, active domain,
// AND i18n messages in one place. Strings flow down as props — no client t().

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
      {/* 가로 분할: 좌 사이드(연회색) | 우 컬럼(흰색) — 테두리·라운딩 없이 배경색으로만 구분 */}
      <div className="flex h-screen bg-white text-gray-900 antialiased [font-family:var(--font-inter),system-ui,sans-serif]">
        {/* 좌: 세로 전체 사이드 — verb(상단) + 요리선생 채팅(하단). bg-gray-50 으로 우측과 구분 */}
        <aside className="flex w-72 shrink-0 flex-col border-r border-gray-200 bg-gray-50">
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
        {/* 우: TopBar(메인 상단) + main */}
        <div className="flex min-w-0 flex-1 flex-col">
          <TopBar user={safeUser} activeDomain={activeDomain} i18n={i18n} />
          <main className="min-h-0 flex-1 overflow-auto p-6">
            {children}
          </main>
        </div>
      </div>
    </ThemeProvider>
  );
}
