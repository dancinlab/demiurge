// AppShell — (app) 워크벤치 반응형 셸 (client).
//
// layout.tsx 는 server 라 토글 state 를 가질 수 없으므로, 드로어 토글 · off-canvas
// 슬라이드 · backdrop overlay · 햄버거-토글 배선을 이 client 셸이 전담한다.
// 서버에서 해결한 레일 콘텐츠(rail)와 메인 컬럼(children)은 그대로 slot/children
// 으로 흘려보낸다 — server 컴포넌트를 client 의 children prop 으로 전달하는 것은 안전.
//
//   >= md : 좌 레일 = 현행 static 고정(w-72). 드로어 state 는 무시(레일 항상 표시).
//   <  md : 좌 레일 = fixed off-canvas 드로어(닫힘 -translate-x-full · 열림 0)
//           + 반투명 backdrop overlay(드로어 열렸을 때만).
//
// 토글 state 초기값 = false(닫힘) → 서버/클라 첫 렌더 트리 일치(hydration 안전).
// 라우트(pathname) 이동 시 드로어 자동 닫힘.
//
// 시맨틱 토큰만(bg-canvas · border-hairline · bg-inverted 등). px/hex 하드코딩 없음.

"use client";

import {
  createContext,
  useContext,
  useEffect,
  useState,
  type ReactNode,
} from "react";
import { usePathname } from "next/navigation";

type AppShellCtx = {
  drawerOpen: boolean;
  openDrawer: () => void;
  closeDrawer: () => void;
  toggleDrawer: () => void;
};

const ShellContext = createContext<AppShellCtx | null>(null);

/** 햄버거 버튼(TopBar 내부, client)이 드로어를 토글할 때 쓰는 훅. */
export function useAppShell(): AppShellCtx {
  const ctx = useContext(ShellContext);
  if (!ctx) {
    // 셸 밖에서 호출되면 no-op 폴백 — 렌더는 깨지지 않게.
    return {
      drawerOpen: false,
      openDrawer: () => {},
      closeDrawer: () => {},
      toggleDrawer: () => {},
    };
  }
  return ctx;
}

export function AppShell({
  rail,
  children,
}: {
  /** 서버에서 해결한 좌 레일 콘텐츠(로고 + VerbTreeNav + CookChefRail). */
  rail: ReactNode;
  /** 메인 컬럼(TopBar + main). */
  children: ReactNode;
}) {
  const [drawerOpen, setDrawerOpen] = useState(false);
  const pathname = usePathname();

  const openDrawer = () => setDrawerOpen(true);
  const closeDrawer = () => setDrawerOpen(false);
  const toggleDrawer = () => setDrawerOpen((v) => !v);

  // 라우트 이동 시 드로어 자동 닫힘(모바일 네비게이션 UX).
  useEffect(() => {
    setDrawerOpen(false);
  }, [pathname]);

  // 드로어 열렸을 때 ESC 로 닫기 + body 스크롤 잠금(모바일).
  useEffect(() => {
    if (!drawerOpen) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setDrawerOpen(false);
    };
    document.addEventListener("keydown", onKey);
    return () => document.removeEventListener("keydown", onKey);
  }, [drawerOpen]);

  return (
    <ShellContext.Provider
      value={{ drawerOpen, openDrawer, closeDrawer, toggleDrawer }}
    >
      <div className="flex h-screen bg-canvas text-ink antialiased [font-family:var(--font-inter),system-ui,sans-serif]">
        {/* ── backdrop overlay — < md 에서 드로어 열렸을 때만 ───────────────── */}
        <div
          className={[
            "fixed inset-0 z-30 bg-inverted/40 backdrop-blur-[2px] transition-opacity duration-200 md:hidden",
            drawerOpen
              ? "pointer-events-auto opacity-100"
              : "pointer-events-none opacity-0",
          ].join(" ")}
          aria-hidden="true"
          onClick={closeDrawer}
        />

        {/* ── 좌 레일 ──────────────────────────────────────────────────────
            >= md : static 고정(w-72) — 현행 데스크탑 레이아웃 그대로.
            <  md : fixed off-canvas 드로어(슬라이드 + z-40, overlay 위). */}
        <aside
          className={[
            // 좌 레일(bg-canvas)과 메인(bg-surface) 사이의 톤 차이로 자연 분리.
            // 데스크탑 = 두 표면 사이 경계가 명확해 보이게 hairline 유지(드로어의 functional hairline).
            "flex w-72 shrink-0 flex-col border-r border-hairline bg-canvas",
            // 모바일: fixed 슬라이드 드로어
            "fixed inset-y-0 left-0 z-40 max-w-[85vw] transition-transform duration-200 ease-out",
            drawerOpen ? "translate-x-0" : "-translate-x-full",
            // 데스크탑: static 고정 레일(슬라이드 무효화)
            "md:static md:z-auto md:max-w-none md:translate-x-0",
          ].join(" ")}
        >
          {rail}
        </aside>

        {/* ── 우: 메인 컬럼(TopBar + main) ─────────────────────────────────── */}
        <div className="flex min-w-0 flex-1 flex-col bg-surface">{children}</div>
      </div>
    </ShellContext.Provider>
  );
}
