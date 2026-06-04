// JosephsonScene — QUBIT demo entry, now a THIN wrapper over the GENERIC
// DomainModel3D path. The junction geometry is no longer hardcoded here: QUBIT
// resolves to its external descriptor (web/public/models/QUBIT/model.3d.json →
// procedural "junction"), built by lib/geometry-3d. This closes the @L10
// "geometry never hardcoded" lock — QUBIT is just another registered model.
//
// The `data-scene="JosephsonScene"` marker (+ data-mode) is preserved via
// DomainModel3D's `sceneName` prop for the conformance e2e. We pass the QUBIT
// descriptor directly (sourced from lib/geometry-3d's registered params) so the
// client renders R3F immediately (no resolving flash).

"use client";

import { DomainModel3D } from "./DomainModel3D";
import { qubitDescriptor } from "@/lib/geometry-3d";

export function JosephsonScene() {
  return (
    <DomainModel3D
      domain="QUBIT"
      descriptor={qubitDescriptor()}
      rung="atom"
      state="verified"
      sceneName="JosephsonScene"
    />
  );
}
