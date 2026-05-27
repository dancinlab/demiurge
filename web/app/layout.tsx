import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import { SiteHeader } from "@/components/SiteHeader";
import { SiteFooter } from "@/components/SiteFooter";
import { HideOnDashboard } from "@/components/HideOnDashboard";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
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

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="en"
      className={`${geistSans.variable} ${geistMono.variable} h-full antialiased`}
    >
      <body className="min-h-full flex flex-col">
        <HideOnDashboard><SiteHeader /></HideOnDashboard>
        <div className="flex-1">{children}</div>
        <HideOnDashboard><SiteFooter /></HideOnDashboard>
      </body>
    </html>
  );
}
