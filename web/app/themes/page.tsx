// /themes — 5 AI agent dashboard frontend OSS reference 갤러리.
// 각 카드 = swatch 3-band + 이름 + 별칭 + 출처. 클릭 → 풀페이지 모달 미리보기.
// 페이지 chrome 자체는 shadcn Modern 톤 (project 영구 톤). 모달 안만 ref tone.

import { ThemesGallery } from "@/components/ThemesGallery";

export const dynamic = "force-dynamic";

export default function ThemesPage() {
  return (
    <main style={{ minHeight: "100vh", background: "#fafafa", color: "#0f172a", fontFamily: "Inter, system-ui, sans-serif" }}>
      <header style={{ padding: "28px 28px 4px", maxWidth: 1280, margin: "0 auto" }}>
        <h1 style={{ fontSize: 24, fontWeight: 700, margin: 0 }}>🎨 demiurge dashboard — 디자인 레퍼런스 갤러리</h1>
        <p style={{ marginTop: 8, fontSize: 13, color: "#64748b", lineHeight: 1.6 }}>
          AI agent dashboard frontend 오픈소스 5 reference. 각 카드 클릭 → 풀페이지 미리보기 모달 (ESC 또는 바깥 클릭으로 닫기).
          현재 (app) 셸의 톤은 <code style={{ background: "#f1f5f9", padding: "1px 6px", borderRadius: 4 }}>shadcn Modern</code> 으로 영구 고정 — 이 페이지는 영감 카탈로그 용도.
        </p>
      </header>
      <div style={{ maxWidth: 1280, margin: "0 auto" }}>
        <ThemesGallery />
      </div>
    </main>
  );
}
