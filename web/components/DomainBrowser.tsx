// DomainBrowser — the dashboard's single domain surface (#6b). "도메인" is the
// ONE first-class concept; matter (소재 원장) and library (공개 갤러리) are just
// VIEWS of it, folded in here as tabs rather than separate top-level routes.
//
//   ▸ tree    — the recursive meta↔sub domain tree (DomainTree)
//   ▸ public  — founder-curated public-domain gallery (LibraryGallery, #6 reuse)
//   ▸ matter  — material attestation/verdict ledger (MatterLedger, #6 reuse)
//
// Pure presentation tab shell; each tab's body is the existing #6 component, so
// no logic is duplicated (d3/d4). Copy arrives as i18n props (no client t()).
// 재설계 후 — Section + SegmentedTabs SSOT 사용. 컨테이너 테두리 제거.

"use client";

import { useState, type ReactNode } from "react";
import { Section } from "@/components/ui/Section";
import { SegmentedTabs, type SegItem } from "@/components/ui/SegmentedTabs";

export type DomainBrowserI18n = {
  tabTree: string;
  tabPublic: string;
  tabMatter: string;
  heading: string;
};

type TabId = "tree" | "public" | "matter";

export function DomainBrowser({
  i18n,
  tree,
  publicTab,
  matter,
}: {
  i18n: DomainBrowserI18n;
  tree: ReactNode;
  publicTab: ReactNode;
  matter: ReactNode;
}) {
  const [tab, setTab] = useState<TabId>("tree");
  const tabs: SegItem<TabId>[] = [
    { id: "tree", label: i18n.tabTree },
    { id: "public", label: i18n.tabPublic },
    { id: "matter", label: i18n.tabMatter },
  ];

  return (
    <Section
      eyebrow={i18n.heading}
      trailing={
        <SegmentedTabs
          items={tabs}
          value={tab}
          onChange={setTab}
          ariaLabel={i18n.heading}
        />
      }
    >
      <div hidden={tab !== "tree"}>{tree}</div>
      <div hidden={tab !== "public"}>{publicTab}</div>
      <div hidden={tab !== "matter"}>{matter}</div>
    </Section>
  );
}
