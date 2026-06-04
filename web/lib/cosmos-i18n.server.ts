// cosmos-i18n.server — SERVER-ONLY builders for the Domain Cosmos i18n bags.
//
// These resolve the `app_gui.*` keys (web/messages/*.json) via lib/i18n's t() /
// getMessages() and return the plain serializable CosmosI18n / SurfaceI18n bags
// (types in cosmos-i18n.ts). Kept server-only because getMessages() reads cookies
// / headers (next/headers) — importing lib/i18n into a client chunk would pull
// next/headers into the browser bundle. Server components (cosmos/page ·
// d/[domain] · VerbSurfaceSection · CarriedCandidate) call these and pass the
// result down as props. Mirrors layout.tsx's chatI18n flow.

import { getMessages, t, type Messages } from "@/lib/i18n";
import type { Rung, VerifyState } from "@/lib/cosmos";
import type { CosmosI18n, SurfaceI18n } from "@/lib/cosmos-i18n";

// §10: the 4 canonical `.demi` `facets.scale` rungs.
const RUNG_KEY: Record<Rung, string> = {
  molecular: "app_gui.cosmos_rung_molecular",
  device: "app_gui.cosmos_rung_device",
  component: "app_gui.cosmos_rung_component",
  system: "app_gui.cosmos_rung_system",
};

const STATE_KEY: Record<VerifyState, string> = {
  "verified-formal": "app_gui.state_verified_formal",
  verified: "app_gui.state_verified",
  "needs-verify": "app_gui.state_needs_verify",
  unverified: "app_gui.state_unverified",
  falsified: "app_gui.state_falsified",
};

function rungLabels(m: Messages): Record<Rung, string> {
  return {
    molecular: t(m, RUNG_KEY.molecular),
    device: t(m, RUNG_KEY.device),
    component: t(m, RUNG_KEY.component),
    system: t(m, RUNG_KEY.system),
  };
}

function stateLabels(m: Messages): Record<VerifyState, string> {
  return {
    "verified-formal": t(m, STATE_KEY["verified-formal"]),
    verified: t(m, STATE_KEY.verified),
    "needs-verify": t(m, STATE_KEY["needs-verify"]),
    unverified: t(m, STATE_KEY.unverified),
    falsified: t(m, STATE_KEY.falsified),
  };
}

export function makeCosmosI18n(m: Messages): CosmosI18n {
  const g = (k: string) => t(m, `app_gui.${k}`);
  return {
    title: g("cosmos_title"),
    intro: g("cosmos_intro"),
    domainsCount: g("cosmos_domains_count"),
    verifiedCount: g("cosmos_verified_count"),
    edgesCount: g("cosmos_edges_count"),
    loading: g("cosmos_loading"),
    emptyTitle: g("cosmos_empty_title"),
    emptyBody: g("cosmos_empty_body"),
    loadErrorTitle: g("cosmos_load_error_title"),
    loadErrorBody: g("cosmos_load_error_body"),
    canvasAria: g("cosmos_canvas_aria"),
    nodelistHeading: g("cosmos_nodelist_heading"),
    filterVerified: g("cosmos_filter_verified"),
    filterNeedsVerify: g("cosmos_filter_needs_verify"),
    filterBuildable: g("cosmos_filter_buildable"),
    filterGroupAria: g("cosmos_filter_group_aria"),
    bigger: g("cosmos_bigger"),
    smaller: g("cosmos_smaller"),
    biggerTitle: g("cosmos_bigger_title"),
    smallerTitle: g("cosmos_smaller_title"),
    leafNoChildren: g("cosmos_leaf_no_children"),
    work: g("cosmos_work"),
    detail: g("cosmos_detail"),
    backToAll: g("cosmos_back_to_all"),
    carriedBack: g("carried_back"),
    modelNoData: g("model_no_data"),
    modelError: g("model_error"),
    rung: rungLabels(m),
    state: stateLabels(m),
  };
}

export async function getCosmosI18n(): Promise<CosmosI18n> {
  return makeCosmosI18n(await getMessages());
}

export function makeSurfaceI18n(m: Messages): SurfaceI18n {
  const g = (k: string) => t(m, `app_gui.${k}`);
  return {
    state: stateLabels(m),
    modelNoData: g("model_no_data"),
    modelError: g("model_error"),
    discoverHint: g("surface_discover_hint"),
    specContract: g("surface_spec_contract"),
    specTarget: g("surface_spec_target"),
    specGate: g("surface_spec_gate"),
    specCurrent: g("surface_spec_current"),
    specGateValue: g("surface_spec_gate_value"),
    specTargetDefault: g("surface_spec_target_default"),
    structureCaption: g("surface_structure_caption"),
    structureParts: g("surface_structure_parts"),
    noParts: g("surface_no_parts"),
    designCaption: g("surface_design_caption"),
    designInspector: g("surface_design_inspector"),
    designLeaf: g("surface_design_leaf"),
    designPart: g("surface_design_part"),
    designVerify: g("surface_design_verify"),
    designValues: g("surface_design_values"),
    designUndefined: g("surface_design_undefined"),
    designDefined: g("surface_design_defined"),
    analyzeHint: g("surface_analyze_hint"),
    analyzeFix: g("surface_analyze_fix"),
    analyzeRescan: g("surface_analyze_rescan"),
    analyzeProblems: g("surface_analyze_problems"),
    analyzeOk: g("surface_analyze_ok"),
    analyzeSelf: g("surface_analyze_self"),
    analyzeAllOk: g("surface_analyze_all_ok"),
    synthHint: g("surface_synth_hint"),
    synthRunning: g("surface_synth_running"),
    synthRun: g("surface_synth_run"),
    synthOn: g("surface_synth_on"),
    synthOff: g("surface_synth_off"),
    verifyCaption: g("surface_verify_caption"),
    verifyScale: g("surface_verify_scale"),
    verifyOurs: g("surface_verify_ours"),
    verifyRef: g("surface_verify_ref"),
    verifyPass: g("surface_verify_pass"),
    verifyWait: g("surface_verify_wait"),
    handoffCert: g("surface_handoff_cert"),
    handoffSealed: g("surface_handoff_sealed"),
    handoffPending: g("surface_handoff_pending"),
  };
}
