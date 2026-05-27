// ThemesGallery — 5 AI-agent dashboard frontend OSS references.
// Each card: 3-band color swatch + name + alias + source.
// Click a card → full-page modal preview with that reference's tone applied
// to the same dashboard skeleton (TopBar + verb sidebar + chef rail + main).
//
// The PAGE chrome stays shadcn Modern (project tone, permanently fixed).
// Only the modal interior re-tones to that reference.

"use client";

import { useEffect, useState } from "react";

type Ref = {
  id: string;
  name: string;
  alias: string;
  source: string;
  sourceUrl: string;
  bg: string;
  panel: string;
  border: string;
  text: string;
  muted: string;
  accent: string;
  accentSoft: string;
  signInText: string;
  radius: string;
  font: string;
  swatch: [string, string, string];
};

const REFS: Ref[] = [
  {
    id: "mono",
    name: "Mono Terminal",
    alias: "단조",
    source: "전통적 터미널",
    sourceUrl: "https://en.wikipedia.org/wiki/Computer_terminal",
    bg: "#0a0a0a",
    panel: "#111111",
    border: "#262626",
    text: "#e5e5e5",
    muted: "#737373",
    accent: "#10b981",
    accentSoft: "#064e3b",
    signInText: "#0a0a0a",
    radius: "4px",
    font: "JetBrains Mono, ui-monospace, monospace",
    swatch: ["#0a0a0a", "#10b981", "#262626"],
  },
  {
    id: "shadcn",
    name: "shadcn Modern",
    alias: "모던",
    source: "shadcn/ui",
    sourceUrl: "https://ui.shadcn.com",
    bg: "#fafafa",
    panel: "#ffffff",
    border: "#e5e7eb",
    text: "#0f172a",
    muted: "#64748b",
    accent: "#0f172a",
    accentSoft: "#f1f5f9",
    signInText: "#ffffff",
    radius: "10px",
    font: "Inter, system-ui, sans-serif",
    swatch: ["#fafafa", "#0f172a", "#f1f5f9"],
  },
  {
    id: "vercel",
    name: "Vercel AI SDK",
    alias: "검정",
    source: "Vercel AI Playground",
    sourceUrl: "https://sdk.vercel.ai",
    bg: "#000000",
    panel: "#0a0a0a",
    border: "#262626",
    text: "#fafafa",
    muted: "#888888",
    accent: "#ffffff",
    accentSoft: "#1a1a1a",
    signInText: "#000000",
    radius: "6px",
    font: "Geist, Inter, system-ui, sans-serif",
    swatch: ["#000000", "#ffffff", "#1a1a1a"],
  },
  {
    id: "horizon",
    name: "Horizon AI",
    alias: "파랑",
    source: "Horizon UI Template",
    sourceUrl: "https://horizon-ui.com",
    bg: "#f4f7fe",
    panel: "#ffffff",
    border: "#e0e5f2",
    text: "#1b2559",
    muted: "#a3aed0",
    accent: "#422afb",
    accentSoft: "#eef0ff",
    signInText: "#ffffff",
    radius: "16px",
    font: "DM Sans, Inter, system-ui, sans-serif",
    swatch: ["#f4f7fe", "#422afb", "#eef0ff"],
  },
  {
    id: "copilotkit",
    name: "CopilotKit Agent",
    alias: "AI에",
    source: "CopilotKit demo",
    sourceUrl: "https://copilotkit.ai",
    bg: "#ffffff",
    panel: "#fafaff",
    border: "#e9d5ff",
    text: "#1e1b4b",
    muted: "#6d28d9",
    accent: "#7c3aed",
    accentSoft: "#f5f3ff",
    signInText: "#ffffff",
    radius: "12px",
    font: "Inter, system-ui, sans-serif",
    swatch: ["#ffffff", "#7c3aed", "#f5f3ff"],
  },
];

function FullMockup({ r }: { r: Ref }) {
  // Same dashboard skeleton, only inline tokens differ.
  return (
    <div style={{ background: r.bg, color: r.text, fontFamily: r.font, padding: 20, minHeight: "100%", display: "flex", flexDirection: "column", gap: 16 }}>
      <div style={{ background: r.panel, border: `1px solid ${r.border}`, borderRadius: r.radius, padding: "10px 16px", fontSize: 14, fontWeight: 600, display: "flex", alignItems: "center", gap: 12 }}>
        <span>📐 demiurge</span>
        <span style={{ color: r.muted }}>/</span>
        <span style={{ background: r.accentSoft, color: r.text, padding: "2px 8px", borderRadius: r.radius, fontFamily: "monospace", fontSize: 12 }}>RTSC</span>
        <span style={{ flex: 1 }} />
        <span style={{ color: r.muted, fontSize: 12 }}>📖 library</span>
        <span style={{ color: r.muted, fontSize: 12 }}>⚖️ matter</span>
        <span style={{ background: r.accent, color: r.signInText, padding: "4px 12px", borderRadius: r.radius, fontSize: 12, fontWeight: 500 }}>sign in</span>
      </div>
      <div style={{ display: "flex", gap: 12, flex: 1, minHeight: 0 }}>
        <div style={{ background: r.panel, border: `1px solid ${r.border}`, borderRadius: r.radius, padding: 8, width: 56, display: "flex", flexDirection: "column", gap: 4, alignItems: "center" }}>
          {["📝", "🧊", "🎨", "📈", "⚗️", "✅", "📤", "🔭"].map((ic, i) => (
            <div key={i} style={{ width: 40, height: 40, display: "flex", alignItems: "center", justifyContent: "center", background: i === 2 ? r.accentSoft : "transparent", borderRadius: r.radius, fontSize: 18, fontWeight: i === 2 ? 700 : 400, color: i === 2 ? r.accent : r.text }}>
              {ic}
            </div>
          ))}
        </div>
        <div style={{ background: r.panel, border: `1px solid ${r.border}`, borderRadius: r.radius, padding: 14, width: 220, display: "flex", flexDirection: "column", gap: 8 }}>
          <div style={{ fontWeight: 600, fontSize: 13 }}>🧑‍🍳 요리선생</div>
          <div style={{ color: r.muted, fontSize: 11 }}>always on</div>
          <div style={{ background: r.accentSoft, color: r.text, padding: "8px 10px", borderRadius: r.radius, fontSize: 12 }}>"도메인 정해볼까?"</div>
          <div style={{ color: r.muted, fontSize: 11 }}>안녕! 어떤 재료로 시작할까?</div>
          <div style={{ marginTop: "auto", border: `1px solid ${r.border}`, borderRadius: r.radius, padding: "6px 10px", fontSize: 11, color: r.muted }}>type a message…</div>
        </div>
        <div style={{ background: r.panel, border: `1px solid ${r.border}`, borderRadius: r.radius, padding: 18, flex: 1, display: "flex", flexDirection: "column", gap: 12 }}>
          <div style={{ fontSize: 18, fontWeight: 700 }}>🏠 dashboard</div>
          <div style={{ display: "flex", gap: 8, flexWrap: "wrap" }}>
            {["spec", "structure", "analyze", "handoff"].map((v) => (
              <span key={v} style={{ border: `1px solid ${r.border}`, borderRadius: r.radius, padding: "6px 12px", fontSize: 12, background: r.panel }}>{v}</span>
            ))}
          </div>
          <div style={{ color: r.muted, fontSize: 12 }}>active · RTSC · 72% (5/7 milestones)</div>
          <div style={{ background: r.accentSoft, borderRadius: r.radius, height: 10, overflow: "hidden" }}>
            <div style={{ background: r.accent, height: "100%", width: "72%" }} />
          </div>
          <div style={{ marginTop: 8, fontSize: 11, color: r.muted, fontFamily: "monospace", background: r.bg, padding: 10, borderRadius: r.radius, border: `1px solid ${r.border}` }}>
            📜 [2026-05-28T03:21Z] verify PASS · 5/5 gates green
            <br />[2026-05-28T03:15Z] structure: lattice converged a=4.21 Å
            <br />[2026-05-28T02:58Z] spec: hypothesis registered
          </div>
        </div>
      </div>
    </div>
  );
}

function Modal({ r, onClose }: { r: Ref; onClose: () => void }) {
  useEffect(() => {
    function onKey(e: KeyboardEvent) { if (e.key === "Escape") onClose(); }
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [onClose]);
  return (
    <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(15,23,42,0.7)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 50, padding: 24 }}>
      <div onClick={(e) => e.stopPropagation()} style={{ background: "#ffffff", borderRadius: 10, border: "1px solid #e5e7eb", boxShadow: "0 25px 50px -12px rgba(0,0,0,0.25)", width: "min(1200px, 100%)", height: "min(800px, 100%)", display: "flex", flexDirection: "column", overflow: "hidden" }}>
        <header style={{ display: "flex", alignItems: "center", gap: 12, padding: "12px 16px", borderBottom: "1px solid #e5e7eb", background: "#fafafa", fontFamily: "Inter, system-ui, sans-serif" }}>
          <h2 style={{ margin: 0, fontSize: 16, fontWeight: 700, color: "#0f172a" }}>{r.name}</h2>
          <span style={{ color: "#64748b", fontSize: 13 }}>— "{r.alias}"</span>
          <a href={r.sourceUrl} target="_blank" rel="noreferrer" style={{ color: "#64748b", fontSize: 12, textDecoration: "underline" }}>{r.source} ↗</a>
          <span style={{ flex: 1 }} />
          <button onClick={onClose} style={{ background: "#f1f5f9", color: "#0f172a", border: "1px solid #e5e7eb", borderRadius: 6, padding: "4px 10px", fontSize: 12, cursor: "pointer" }}>닫기 (ESC)</button>
        </header>
        <div style={{ flex: 1, overflow: "auto" }}>
          <FullMockup r={r} />
        </div>
      </div>
    </div>
  );
}

export function ThemesGallery() {
  const [open, setOpen] = useState<Ref | null>(null);
  return (
    <>
      <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fill, minmax(240px, 1fr))", gap: 16, padding: 24 }}>
        {REFS.map((r) => (
          <button
            key={r.id}
            onClick={() => setOpen(r)}
            style={{
              background: "#ffffff", border: "1px solid #e5e7eb", borderRadius: 10,
              boxShadow: "0 1px 2px rgba(0,0,0,.04), 0 1px 3px rgba(0,0,0,.06)",
              padding: 0, cursor: "pointer", overflow: "hidden", textAlign: "left",
              fontFamily: "Inter, system-ui, sans-serif", color: "#0f172a",
              transition: "transform .12s, box-shadow .12s",
            }}
            onMouseEnter={(e) => { e.currentTarget.style.transform = "translateY(-2px)"; e.currentTarget.style.boxShadow = "0 8px 16px rgba(0,0,0,.06), 0 2px 4px rgba(0,0,0,.04)"; }}
            onMouseLeave={(e) => { e.currentTarget.style.transform = "none"; e.currentTarget.style.boxShadow = "0 1px 2px rgba(0,0,0,.04), 0 1px 3px rgba(0,0,0,.06)"; }}
          >
            <div style={{ display: "flex", height: 80 }}>
              {r.swatch.map((c, i) => (
                <div key={i} style={{ flex: 1, background: c }} />
              ))}
            </div>
            <div style={{ padding: 14 }}>
              <div style={{ display: "flex", alignItems: "baseline", gap: 6 }}>
                <h3 style={{ margin: 0, fontSize: 14, fontWeight: 700 }}>{r.name}</h3>
                <span style={{ color: "#64748b", fontSize: 12 }}>"{r.alias}"</span>
              </div>
              <p style={{ margin: "4px 0 0", fontSize: 11, color: "#64748b" }}>출처 · {r.source}</p>
              <p style={{ margin: "6px 0 0", fontSize: 11, color: "#0f172a", fontWeight: 500 }}>클릭 → 풀페이지 미리보기 →</p>
            </div>
          </button>
        ))}
      </div>
      {open && <Modal r={open} onClose={() => setOpen(null)} />}
    </>
  );
}
