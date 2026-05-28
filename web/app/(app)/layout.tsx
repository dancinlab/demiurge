// (app) — ElevenLabs 톤. Server Component: reads currentUser, active domain,
// AND i18n messages in one place. Strings flow down as props — no client t().

import fs from "node:fs/promises";
import path from "node:path";
import Link from "next/link";
import { cookies } from "next/headers";
import { ThemeProvider } from "@/components/ThemeProvider";
import { AppShell } from "@/components/AppShell";
import { TopBar } from "@/components/TopBar";
import { VerbTreeNav } from "@/components/VerbTreeNav";
import type { VerbId, VerbStatus } from "@/lib/verbs";
import { CookChefRail } from "@/components/CookChefRail";
import { currentUser } from "@/lib/session";
import { getLocale, getMessages, t } from "@/lib/i18n";
import { listDomains } from "@/lib/domains";
import { parseMilestones, deriveVerbStatus } from "@/lib/verb-status";
import { repoDataRoot } from "@/lib/data-root";

const REPO_ROOT = repoDataRoot();

// Sidebar status dots = real progress derived from the active domain's
// milestones (lib/verb-status). No active domain → all dots stay `todo`.
async function statusForDomain(
  domainName: string | null,
): Promise<Partial<Record<VerbId, VerbStatus>>> {
  if (!domainName) return {};
  try {
    const domains = await listDomains();
    const entry = domains.find(
      (d) => d.name.toLowerCase() === domainName.toLowerCase(),
    );
    if (!entry) return {};
    const md = await fs.readFile(path.join(REPO_ROOT, entry.mdPath), "utf8");
    return deriveVerbStatus(parseMilestones(md));
  } catch {
    return {};
  }
}

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
  const statusByVerb = await statusForDomain(activeDomain);
  const safeUser = user
    ? { email: user.email ?? "", role: (user as { role?: string }).role }
    : null;

  // Pull every layout-level string up here so client components stay pure
  // presentation (no t() · no Messages import · serializable props only).
  const i18n = {
    topbarDomains: t(messages, "app_gui.topbar_domains"),
    topbarDocs: t(messages, "app_gui.topbar_docs"),
    topbarActiveProject: t(messages, "app_gui.topbar_active_project"),
    topbarWorkbench: t(messages, "dashboard.title"),
    topbarSignIn: t(messages, "app_gui.sign_in"),
    topbarAdmin: t(messages, "app_gui.admin"),
    topbarNotifications: t(messages, "app_gui.topbar_notifications"),
    topbarMenu: t(messages, "app_gui.topbar_menu"),
    account: {
      account: t(messages, "app_gui.account_menu_account"),
      settings: t(messages, "app_gui.account_menu_settings"),
      signOut: t(messages, "app_gui.account_menu_sign_out"),
    },
    chefTitle: t(messages, "app_gui.chef_title"),
    chefAwaiting: t(messages, "app_gui.chef_awaiting_domain"),
    chefReady: t(messages, "app_gui.chef_ready"),
    verbtreeCollapse: t(messages, "app_gui.verbtree_collapse"),
    verbtreeExpand: t(messages, "app_gui.verbtree_expand"),
    verbtree8Verbs: t(messages, "app_gui.verbtree_8verbs"),
  };

  // Chat (DEMI) strings — passed to AssistChat via CookChefRail.
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

  // 좌 레일 콘텐츠(server 렌더). AppShell(client)이 >= md 는 static 고정,
  // < md 는 off-canvas 드로어로 배치한다. ElevenLabs 톤: canvas 틴트.
  const rail = (
    <>
      {/* 브랜드 로고 + 8verb 메뉴를 같은 p-2 컨테이너에 두어 동일 그리드.
          로고 Link 도 verb 아이템과 똑같이 px-2 py-1.5 → 좌측이 verb 아이콘 컬럼(16px)에
          정확히 정렬 + 상하 여백도 verb 아이템과 동일 + mb-0.5 로 아이템 간 gap-0.5 리듬 일치.
          폰트는 랜딩 SiteHeader 100% 동일(시스템 산세리프·font-black·22px·-0.04em·노랑 닷). */}
      <div className="shrink-0 p-2">
        <Link
          href="/dashboard"
          aria-label="demiurge — home"
          className="mb-0.5 flex items-center px-2 py-1.5 hover:opacity-80"
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
        <VerbTreeNav
          domain={activeDomain ?? undefined}
          statusByVerb={statusByVerb}
          i18n={i18n}
          locale={locale}
        />
      </div>
      <div className="min-h-0 flex-1">
        <CookChefRail
          domain={activeDomain ?? ""}
          i18n={i18n}
          chatI18n={chatI18n}
          locale={locale}
        />
      </div>
    </>
  );

  return (
    <ThemeProvider>
      {/* ElevenLabs 톤(Create 페이지): 좌 레일=canvas(웜 그레이 틴트) | 우 메인=surface(흰색).
          AppShell = 반응형 셸(client): >= md static 레일 · < md off-canvas 드로어 + overlay. */}
      <AppShell rail={rail}>
        {/* 우: TopBar(메인 상단) + main — 흰색 surface 컬럼 */}
        <TopBar user={safeUser} activeDomain={activeDomain} i18n={i18n} />
        <main className="min-h-0 flex-1 overflow-auto bg-surface p-3 sm:p-6">
          {children}
        </main>
      </AppShell>
    </ThemeProvider>
  );
}
