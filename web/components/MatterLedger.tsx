// MatterLedger — client view over the material attestation/verdict rows.
// Search (material/compound/family/verdict) + absorbed/open filter + a summary
// strip (records · absorbed · distinct materials). Pure presentation otherwise:
// rows + all copy arrive as props from the server page (no client t()).
// Semantic tokens only (DESIGN_TOKENS.md SSOT).

"use client";

import { useMemo, useState } from "react";
import type { AttestationRow } from "@/lib/matter";
import { PanelStat, PanelEmpty } from "@/components/ui/Panel";
import { SegmentedTabs, type SegItem } from "@/components/ui/SegmentedTabs";

type MatterI18n = {
  searchPlaceholder: string;
  filterAll: string;
  filterAbsorbed: string;
  filterOpen: string;
  summaryTotal: string;
  summaryAbsorbed: string;
  summaryMaterials: string;
  colMaterial: string;
  colKind: string;
  colCompound: string;
  colTc: string;
  colFamily: string;
  colAbsorbed: string;
  colGate: string;
  colVerdict: string;
  kindAttestation: string;
  kindVerdict: string;
  absorbedYes: string;
  absorbedNo: string;
  empty: string;
  emptyFiltered: string;
};

type Filter = "all" | "absorbed" | "open";

function AbsorbedBadge({
  absorbed,
  yes,
  no,
}: {
  absorbed: boolean | null;
  yes: string;
  no: string;
}) {
  if (absorbed === true) {
    return (
      <span className="inline-flex items-center gap-1 rounded-chip bg-success/15 px-2 py-0.5 text-[11px] font-medium text-success">
        ● {yes}
      </span>
    );
  }
  if (absorbed === false) {
    return (
      <span className="inline-flex items-center gap-1 text-[11px] text-body">
        ○ {no}
      </span>
    );
  }
  return <span className="text-muted-soft">—</span>;
}

export function MatterLedger({
  rows,
  i18n,
}: {
  rows: AttestationRow[];
  i18n: MatterI18n;
}) {
  const [query, setQuery] = useState("");
  const [filter, setFilter] = useState<Filter>("all");

  const summary = useMemo(() => {
    const absorbed = rows.filter((r) => r.absorbed === true).length;
    const materials = new Set(rows.map((r) => r.material)).size;
    return { total: rows.length, absorbed, materials };
  }, [rows]);

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    return rows.filter((r) => {
      if (filter === "absorbed" && r.absorbed !== true) return false;
      if (filter === "open" && r.absorbed === true) return false;
      if (!q) return true;
      return [r.material, r.compound, r.family, r.verdict, r.measurement_gate]
        .filter(Boolean)
        .some((v) => (v as string).toLowerCase().includes(q));
    });
  }, [rows, query, filter]);

  const filters: SegItem<Filter>[] = [
    { id: "all", label: i18n.filterAll },
    { id: "absorbed", label: i18n.filterAbsorbed },
    { id: "open", label: i18n.filterOpen },
  ];

  if (rows.length === 0) {
    return <PanelEmpty>{i18n.empty}</PanelEmpty>;
  }

  return (
    <div className="space-y-5">
      {/* summary strip */}
      <div className="grid grid-cols-3 gap-3">
        <PanelStat value={String(summary.total)} label={i18n.summaryTotal} />
        <PanelStat value={String(summary.absorbed)} label={i18n.summaryAbsorbed} />
        <PanelStat value={String(summary.materials)} label={i18n.summaryMaterials} />
      </div>

      {/* controls */}
      <div className="flex flex-wrap items-center gap-3">
        <input
          type="search"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder={i18n.searchPlaceholder}
          className="min-w-0 flex-1 rounded-control border border-hairline bg-surface px-3 py-1.5 text-sm text-ink placeholder:text-muted-soft focus:border-hairline-strong focus:outline-none"
        />
        <SegmentedTabs
          items={filters}
          value={filter}
          onChange={setFilter}
          ariaLabel={i18n.filterAll}
        />
      </div>

      {/* table — table cell separators는 데이터 가독성 affordance 라 유지(드로어 hairline 과 동일 원칙). */}
      {filtered.length === 0 ? (
        <PanelEmpty>{i18n.emptyFiltered}</PanelEmpty>
      ) : (
        <div className="overflow-x-auto">
          <table className="w-full min-w-[44rem] text-left text-sm">
            <thead>
              <tr className="border-b border-hairline text-[11px] uppercase tracking-wide text-muted">
                <th className="px-3 py-2 font-semibold">{i18n.colMaterial}</th>
                <th className="px-3 py-2 font-semibold">{i18n.colKind}</th>
                <th className="px-3 py-2 font-semibold">{i18n.colCompound}</th>
                <th className="px-3 py-2 font-semibold">{i18n.colFamily}</th>
                <th className="px-3 py-2 text-right font-semibold">{i18n.colTc}</th>
                <th className="px-3 py-2 font-semibold">{i18n.colAbsorbed}</th>
                <th className="px-3 py-2 font-semibold">{i18n.colGate}</th>
                <th className="px-3 py-2 font-semibold">{i18n.colVerdict}</th>
              </tr>
            </thead>
            <tbody>
              {filtered.map((r, i) => (
                <tr
                  key={`${r.material}-${r.kind}-${r.file}-${i}`}
                  className="border-b border-hairline last:border-0 hover:bg-surface"
                >
                  <td className="px-3 py-2 font-medium text-ink">{r.material}</td>
                  <td className="px-3 py-2">
                    <span className="font-mono text-[10px] text-body">
                      {r.kind === "verdict" ? i18n.kindVerdict : i18n.kindAttestation}
                    </span>
                  </td>
                  <td className="px-3 py-2 text-body">{r.compound ?? "—"}</td>
                  <td className="px-3 py-2 text-muted">{r.family ?? "—"}</td>
                  <td className="px-3 py-2 text-right font-mono text-xs text-body">
                    {r.tc_k !== null ? r.tc_k : "—"}
                  </td>
                  <td className="px-3 py-2">
                    <AbsorbedBadge
                      absorbed={r.absorbed}
                      yes={i18n.absorbedYes}
                      no={i18n.absorbedNo}
                    />
                  </td>
                  <td className="px-3 py-2 font-mono text-[10px] text-muted">
                    {r.measurement_gate ?? "—"}
                  </td>
                  <td className="px-3 py-2 font-mono text-[10px] text-muted">
                    {r.verdict ?? "—"}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
