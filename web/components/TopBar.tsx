// TopBar — Q3 상단 · 로고 + 선택된 프로젝트 · 우측 매뉴 / sign in / admin.
// shadcn Modern 톤: accent = slate-900 (검정), accentSoft = slate-100.
//
// 활성 도메인 추출 우선순위:
//   1) pathname `/<verb>/<domain>` 안의 domain
//   2) `/dashboard?d=<NAME>` 의 query
//   3) localStorage `demiurge.active.domain` (DomainSwitcher 가 박아둠)
// 검출 시 localStorage 에도 mirror — SPA navigation 후 셸 어디서든 일관 표시.

"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useEffect, useState } from "react";

type Me = { authenticated: boolean; email?: string; role?: string };

const VERB_DOMAIN_RE =
  /^\/(spec|structure|design|analyze|synth|verify|handoff|discover)\/([^/?#]+)/;

function useActiveDomain(): string | null {
  const pathname = usePathname() ?? "";
  const [domain, setDomain] = useState<string | null>(null);
  useEffect(() => {
    if (typeof window === "undefined") return;
    const m = pathname.match(VERB_DOMAIN_RE);
    if (m) {
      setDomain(m[2]);
      localStorage.setItem("demiurge.active.domain", m[2]);
      return;
    }
    const sp = new URLSearchParams(window.location.search);
    const d = sp.get("d");
    if (d) {
      setDomain(d);
      localStorage.setItem("demiurge.active.domain", d);
      return;
    }
    setDomain(localStorage.getItem("demiurge.active.domain"));
  }, [pathname]);
  return domain;
}

export function TopBar() {
  const [me, setMe] = useState<Me | null>(null);
  const activeDomain = useActiveDomain();
  useEffect(() => {
    let live = true;
    fetch("/api/v1/me")
      .then((r) => (r.ok ? r.json() : { authenticated: false }))
      .then((d: Me) => { if (live) setMe(d); })
      .catch(() => { if (live) setMe({ authenticated: false }); });
    return () => { live = false; };
  }, []);

  return (
    <header className="flex items-center gap-3 border-b border-slate-200 bg-white px-5 py-3 text-sm shadow-sm">
      <Link href="/dashboard" className="font-semibold tracking-tight text-slate-900 hover:text-slate-700">
        📐 demiurge
      </Link>
      {activeDomain && (
        <>
          <span className="text-slate-300" aria-hidden="true">/</span>
          <Link
            href={`/dashboard?d=${encodeURIComponent(activeDomain)}`}
            title="active project"
            className="rounded-[6px] bg-slate-100 px-2 py-0.5 font-mono text-xs text-slate-700 hover:bg-slate-200"
          >
            {activeDomain}
          </Link>
        </>
      )}
      <span className="flex-1" />
      <Link href="/library" className="rounded-[6px] px-2 py-1 text-xs text-slate-600 hover:bg-slate-100 hover:text-slate-900">📖 library</Link>
      <Link href="/matter" className="rounded-[6px] px-2 py-1 text-xs text-slate-600 hover:bg-slate-100 hover:text-slate-900">⚖️ matter</Link>
      {me?.role === "admin" && (
        <Link href="/admin" className="rounded-[6px] border border-rose-200 bg-rose-50 px-2 py-1 text-xs text-rose-700 hover:bg-rose-100">
          ⚙️ admin
        </Link>
      )}
      {me?.authenticated ? (
        <Link href="/account" className="rounded-[6px] bg-slate-100 px-2.5 py-1 text-xs text-slate-700 hover:bg-slate-200">{me.email}</Link>
      ) : (
        <Link href="/signin" className="rounded-[6px] bg-slate-900 px-3 py-1 text-xs font-medium text-white hover:bg-slate-800">sign in</Link>
      )}
    </header>
  );
}
