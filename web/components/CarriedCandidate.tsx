// CarriedCandidate — the header strip shown atop EVERY verb page (8VERB §6).
//
// Per §6, each verb operates on a FOCUSED domain-node carried from the prior
// stage of the pipeline. This strip makes that carried candidate visible:
//   icon · name · rung · verify badge  (+ alias) — resolved from cosmos.ts
//   ← cosmos      — back link to the 3D constellation MAIN PAGE
//   stage breadcrumb — discover→…→handoff, the CURRENT verb highlighted
//
// Server component (no client state): it resolves the node off the cosmos graph
// (resolveCosmosNode) and renders. The single generic dispatch (d4) — every verb
// passes its own `verb` + the carried `domain`; nothing is hardcoded per node.

import Link from "next/link";
import { resolveCosmosNode } from "@/lib/cosmos.server";
import { STATE_BADGE, type VerifyState } from "@/lib/cosmos";
import { getCosmosI18n } from "@/lib/cosmos-i18n.server";
import { VERBS, type VerbId } from "@/lib/verbs";

export async function CarriedCandidate({
  domain,
  verb,
}: {
  domain: string;
  verb: VerbId;
}) {
  const [{ node, decomposition }, i18n] = await Promise.all([
    resolveCosmosNode(domain),
    getCosmosI18n(),
  ]);
  const RUNG_LABEL = i18n.rung;
  const STATE_LABEL: Record<VerifyState, string> = i18n.state;

  // the node's carried verify badge — prefer the rolled-up subtree state when a
  // decomposition exists (a system node's badge reflects its parts), else the
  // node's own state. Unknown node → an honest ⚪ placeholder.
  const state: VerifyState =
    decomposition?.tree.rollup ?? node?.state ?? "unverified";
  const icon = node?.icon ?? "⬡";
  const name = node?.name ?? (domain.split("/").pop() ?? domain).toUpperCase();
  const rung = node?.rung;

  return (
    <header className="flex flex-col gap-2 border-b border-hairline-soft pb-3">
      {/* row 1 — back link + the carried candidate identity */}
      <div className="flex flex-wrap items-center gap-x-3 gap-y-1.5">
        <Link
          href="/cosmos"
          className="shrink-0 rounded-control px-2 py-0.5 text-xs text-muted hover:bg-surface-strong hover:text-ink focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-primary"
        >
          {i18n.carriedBack}
        </Link>
        <span className="text-xl leading-none" aria-hidden>
          {icon}
        </span>
        <span className="font-sans text-base font-semibold text-ink">{name}</span>
        {rung && (
          <span className="rounded-chip bg-surface-strong px-1.5 py-0.5 text-[10px] font-medium text-muted">
            {RUNG_LABEL[rung]}
          </span>
        )}
        <span
          className="ml-auto inline-flex items-center gap-1 text-xs text-body"
          title={STATE_LABEL[state]}
        >
          <span className="text-base leading-none">{STATE_BADGE[state]}</span>
          {STATE_LABEL[state]}
        </span>
      </div>

      {node?.alias && (
        <p className="-mt-0.5 pl-9 text-[11px] text-muted-soft">— {node.alias}</p>
      )}

      {/* row 2 — the 8-verb stage breadcrumb (current highlighted) */}
      <nav className="flex flex-wrap items-center gap-1 pl-9 text-[11px]">
        {VERBS.map((v, i) => {
          const active = v.id === verb;
          return (
            <span key={v.id} className="flex items-center gap-1">
              <Link
                href={`/${v.id}/${encodeURIComponent(domain.toLowerCase())}`}
                className={
                  active
                    ? "rounded-chip bg-inverted px-1.5 py-0.5 font-mono font-semibold text-on-inverted"
                    : "rounded-chip px-1.5 py-0.5 font-mono text-muted-soft hover:bg-surface-strong hover:text-body"
                }
                aria-current={active ? "step" : undefined}
              >
                {v.label}
              </Link>
              {i < VERBS.length - 1 && (
                <span className="text-muted-soft" aria-hidden>
                  →
                </span>
              )}
            </span>
          );
        })}
      </nav>
    </header>
  );
}

export default CarriedCandidate;
