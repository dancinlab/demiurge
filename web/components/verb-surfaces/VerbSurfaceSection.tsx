// VerbSurfaceSection — the server-side glue that every verb page mounts as its
// MAIN-AREA slot (8VERB §6). It:
//   1. resolves the carried domain-node off the cosmos graph (resolveCosmosNode),
//   2. builds the serializable SurfaceNode bag (rollup + composition parts),
//   3. stacks the CarriedCandidate header + the verb's 3D-first surface.
//
// d4 single dispatch: ONE generic path — the `verb` selects the surface inside
// the client dispatcher VerbSurfaceClient; nothing branches per domain here.
// The node bag is plain/serializable, so the client boundary is clean.

import { CarriedCandidate } from "@/components/CarriedCandidate";
import {
  VerbSurfaceClient,
  type SurfaceNode,
} from "@/components/verb-surfaces/VerbSurfaces";
import { resolveCosmosNode } from "@/lib/cosmos.server";
import { makeSurfaceI18n } from "@/lib/cosmos-i18n.server";
import { getMessages } from "@/lib/i18n";
import type { VerbId } from "@/lib/verbs";
import type { ReactNode } from "react";

export async function VerbSurfaceSection({
  verb,
  domain,
  dossier,
}: {
  verb: VerbId;
  domain: string;
  /** handoff only — the real downloadable dossier client component. */
  dossier?: ReactNode;
}) {
  const [{ node, decomposition }, messages] = await Promise.all([
    resolveCosmosNode(domain),
    getMessages(),
  ]);
  const surfaceI18n = makeSurfaceI18n(messages);

  // composition children = the providers this node reuses → its "parts".
  const parts: SurfaceNode["parts"] = decomposition
    ? decomposition.tree.children.map((c) => ({
        name: c.node.name,
        icon: c.node.icon,
        state: c.rollup,
      }))
    : [];

  const surfaceNode: SurfaceNode = node
    ? {
        name: node.name,
        icon: node.icon,
        alias: node.alias,
        rung: node.rung,
        goal: node.goal,
        state: node.state,
        rollup: decomposition?.tree.rollup,
        parts,
      }
    : {
        name: (domain.split("/").pop() ?? domain).toUpperCase(),
        state: "unverified",
        rollup: decomposition?.tree.rollup,
        parts,
      };

  return (
    <div className="space-y-4">
      <CarriedCandidate domain={domain} verb={verb} />
      <VerbSurfaceClient
        verb={verb}
        node={surfaceNode}
        i18n={surfaceI18n}
        dossier={dossier}
      />
    </div>
  );
}

export default VerbSurfaceSection;
