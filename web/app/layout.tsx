import type { Metadata } from "next";
import { Geist, Geist_Mono, Inter, Cormorant_Garamond } from "next/font/google";
import "./globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

// (app) 셸 본문 폰트 — Inter (ara 톤).
const inter = Inter({
  variable: "--font-inter",
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
});

// (app) 셸 제목 폰트 — Cormorant Garamond 세리프 (ara 톤 · 논문체).
const cormorant = Cormorant_Garamond({
  variable: "--font-cormorant",
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
});

export const metadata: Metadata = {
  metadataBase: new URL("https://demiurge.dancinlab.org"),
  title: {
    default: "demiurge — AI-native technical-design pipeline",
    template: "%s · demiurge",
  },
  description:
    "spec → structure → design → analyze → synthesize → verify → handoff. An AI-native 7-verb technical-design pipeline. Built with Gemini.",
  applicationName: "demiurge",
  icons: {
    icon: [{ url: "/icon.svg", type: "image/svg+xml" }, { url: "/favicon.ico" }],
  },
  openGraph: {
    title: "demiurge — AI-native technical-design pipeline",
    description:
      "spec → structure → design → analyze → synthesize → verify → handoff. Built with Gemini.",
    url: "https://demiurge.dancinlab.org",
    siteName: "demiurge",
    type: "website",
  },
  twitter: {
    card: "summary",
    title: "demiurge — AI-native technical-design pipeline",
    description: "AI-native 7-verb technical-design pipeline. Built with Gemini.",
  },
};

// Root layout is intentionally bare — it owns ONLY <html>/<body>, fonts,
// and metadata. The two surfaces decide their own shell + palette:
//   app/(marketing)/layout.tsx  → Brutalist (black/yellow) + SiteHeader/Footer
//   app/(app)/layout.tsx        → Mono / Terminal (white) workbench, no chrome
// This keeps landing CSS and app CSS fully isolated (no cross-bleed).
export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  // suppressHydrationWarning: next-themes sets the `class`/`style` on <html>
  // before React hydrates (in the (app) surface), so the server/client
  // markup intentionally differs on that element.
  return (
    <html
      lang="en"
      suppressHydrationWarning
      className={`${geistSans.variable} ${geistMono.variable} ${inter.variable} ${cormorant.variable} h-full antialiased`}
    >
      <body className="min-h-full">{children}</body>
    </html>
  );
}
