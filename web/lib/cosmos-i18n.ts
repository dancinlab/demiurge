// cosmos-i18n — the serializable i18n bag TYPES for the 3D Domain Cosmos.
//
// COSMOS.md hardening (P6 §1): all user-facing copy on the cosmos surfaces flows
// through the established i18n mechanism (`app_gui.*` keys · web/messages/*.json)
// — NEVER a literal string embedded in a client/R3F component. Server components
// build these plain bags (see cosmos-i18n.server.ts) and hand them down as props,
// so the client components stay pure presentation (no `next/headers`, SSR-safe).
//
// This module is CLIENT-SAFE: it carries ONLY the bag types + the pure `fmt`
// helper, and imports NOTHING from lib/i18n (which pulls in `next/headers`). The
// server-only builders (makeCosmosI18n · makeSurfaceI18n · getCosmosI18n) live in
// cosmos-i18n.server.ts. Mirrors the cosmos.ts / cosmos.server.ts split.

import type { Rung, VerifyState } from "@/lib/cosmos";

export type CosmosI18n = {
  // page header / chrome
  title: string;
  intro: string;
  domainsCount: string; // "{n}"
  verifiedCount: string; // "{n}"
  edgesCount: string; // "{n}"
  loading: string;
  emptyTitle: string;
  emptyBody: string;
  loadErrorTitle: string;
  loadErrorBody: string;
  canvasAria: string;
  nodelistHeading: string;
  // filters + dolly
  filterVerified: string;
  filterNeedsVerify: string;
  filterBuildable: string;
  filterGroupAria: string;
  bigger: string;
  smaller: string;
  biggerTitle: string;
  smallerTitle: string;
  // focus banner / nav
  leafNoChildren: string;
  work: string;
  detail: string;
  backToAll: string;
  carriedBack: string;
  // model overlay
  modelNoData: string;
  modelError: string;
  // rung labels + state labels (badge legend)
  rung: Record<Rung, string>;
  state: Record<VerifyState, string>;
};

// The verb-surface i18n bag (§6 per-verb 3D surfaces). Separate from CosmosI18n
// so a verb page only ships the strings it needs.
export type SurfaceI18n = {
  state: Record<VerifyState, string>;
  modelNoData: string;
  modelError: string;
  discoverHint: string;
  specContract: string;
  specTarget: string;
  specGate: string;
  specCurrent: string;
  specGateValue: string;
  specTargetDefault: string; // "{domain}"
  structureCaption: string;
  structureParts: string;
  noParts: string;
  designCaption: string;
  designInspector: string;
  designLeaf: string;
  designPart: string;
  designVerify: string;
  designValues: string;
  designUndefined: string;
  designDefined: string;
  analyzeHint: string;
  analyzeFix: string;
  analyzeRescan: string;
  analyzeProblems: string; // "{n}"
  analyzeOk: string;
  analyzeSelf: string;
  analyzeAllOk: string;
  synthHint: string;
  synthRunning: string;
  synthRun: string;
  synthOn: string;
  synthOff: string;
  verifyCaption: string;
  verifyScale: string;
  verifyOurs: string;
  verifyRef: string;
  verifyPass: string;
  verifyWait: string;
  handoffCert: string;
  handoffSealed: string;
  handoffPending: string;
};

// fmt — tiny "{n}" / "{token}" interpolation for the count strings (client-safe).
export function fmt(template: string, vars: Record<string, string | number>): string {
  return template.replace(/\{(\w+)\}/g, (_, k) =>
    k in vars ? String(vars[k]) : `{${k}}`,
  );
}
