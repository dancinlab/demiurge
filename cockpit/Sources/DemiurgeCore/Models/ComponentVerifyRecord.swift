// ComponentVerifyRecord — phase κ-34 (P-⑨ verify) — typed sidecar JSON
// for the `component + verify` cell (D55).
//
// The verify cell measures (or, in this honest-staging cycle, *meshes*)
// a parametric component geometry. Right now the producer is gmsh —
// it consumes the .step from `exports/component/geometry/` and emits
// .msh / .med plus a typed stats sidecar. A thermal / structural
// verdict needs Salome-Meca Code_Aster on top of the mesh; that is a
// SEPARATE downstream gate (D55 honest gap ②) — this record carries
// `verdict = nil` until then.
//
// HONESTY (g3 — non-negotiable):
//   * `absorbed = false` is hard-coded in every constructor. demiurge
//     never emits a "measured" verdict for a BIPV part — a measured
//     component producer lives in hexa-lang/component (P-⑨ owner).
//   * `measurement_gate = GATE_OPEN` for mesh-only runs. Even if a
//     future Code_Aster run lands a thermal field, the gate stays
//     GATE_OPEN until a full sweep (multi-load, multi-temperature)
//     lands — single-point measurements are never GATE_B_PINNED_MET
//     (g3 / D54 cite — same discipline as the geometry record).

import Foundation

/// Mesh statistics captured from gmsh's `mesh.json` sidecar. All counts
/// are post-mesh-generate; quality histogram is a 10-bucket jacobian
/// distribution (0.0–1.0, higher is better).
public struct ComponentMeshStats: Codable, Equatable, Sendable {
    public let nodeCount: Int
    public let elementCount: Int
    public let volumeCount: Int
    public let faceCount: Int?
    /// Optional — the CLI mesh path uses gmsh defaults, not a fixed
    /// `element_size_mm`. Kept for the (deprecated) python-driven mesh
    /// path that sets `Mesh.CharacteristicLengthMax` explicitly.
    public let elementSizeMM: Double?
    /// Bucketed (`"0.5-0.6": 1234`) jacobian distribution. Keys are the
    /// bucket label exactly as the Python emitter writes them. Empty
    /// dict if the quality probe failed (honest gap, gmsh-version-
    /// dependent).
    public let qualityHistogram: [String: Int]

    public init(nodeCount: Int, elementCount: Int, volumeCount: Int,
                faceCount: Int?, elementSizeMM: Double?,
                qualityHistogram: [String: Int]) {
        self.nodeCount = nodeCount
        self.elementCount = elementCount
        self.volumeCount = volumeCount
        self.faceCount = faceCount
        self.elementSizeMM = elementSizeMM
        self.qualityHistogram = qualityHistogram
    }

    enum CodingKeys: String, CodingKey {
        case nodeCount = "node_count"
        case elementCount = "element_count"
        case volumeCount = "volume_count"
        case faceCount = "face_count"
        case elementSizeMM = "element_size_mm"
        case qualityHistogram = "quality_histogram"
    }
}

/// A `component + verify` artifact record (rfc_002 §4 F1F2-style,
/// verify variant). Producer = gmsh today; Salome-Meca Code_Aster
/// when the .comm authoring lands (κ-35 candidate).
public struct ComponentVerifyRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    /// Slug of the source component geometry record (e.g.
    /// `"bipv_freecad_v1"`) — cross-link into
    /// `exports/component/geometry/<geometryId>.json`.
    public let geometryId: String
    /// Relative file name of the .msh mesh under
    /// `exports/component/verify/`.
    public let mshFile: String?
    /// Relative file name of the .med mesh (Salome / Code_Aster ingest)
    /// — `nil` if MED export was unavailable (honest gap, surfaced in
    /// scope_caveats).
    public let medFile: String?
    /// Relative file name of the gmsh `mesh.json` stats sidecar.
    public let meshStatsFile: String?
    public let meshStats: ComponentMeshStats?
    /// Salome-Meca docker availability witness — captured by the Swift
    /// harness so the chat/CLI can show whether the next gate can be
    /// attempted. Honest: a true here means the image is local AND
    /// `as_run` is invocable; the .comm authoring + convergence are
    /// still pending (D55 gap ②).
    public let salomeDockerReady: Bool?
    /// Salome-Meca image identifier (e.g. `"tefe/salome-meca:latest"`),
    /// nil if not probed.
    public let salomeImage: String?
    public let provenance: ComponentProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String,
                mshFile: String?, medFile: String?,
                meshStatsFile: String?,
                meshStats: ComponentMeshStats?,
                salomeDockerReady: Bool?,
                salomeImage: String?,
                provenance: ComponentProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.mshFile = mshFile
        self.medFile = medFile
        self.meshStatsFile = meshStatsFile
        self.meshStats = meshStats
        self.salomeDockerReady = salomeDockerReady
        self.salomeImage = salomeImage
        self.provenance = provenance
    }

    enum CodingKeys: String, CodingKey {
        case interface
        case schemaVersion = "schema_version"
        case recordId = "record_id"
        case producedAtUtc = "produced_at_utc"
        case geometryId = "geometry_id"
        case mshFile = "msh_file"
        case medFile = "med_file"
        case meshStatsFile = "mesh_stats_file"
        case meshStats = "mesh_stats"
        case salomeDockerReady = "salome_docker_ready"
        case salomeImage = "salome_image"
        case provenance
    }

    /// Build the honest record for a gmsh mesh-only verify run
    /// (κ-34 / D55). Producer = gmsh; `measurement_gate = GATE_OPEN`,
    /// `absorbed = false`. The Salome-Meca witness fields are filled in
    /// from the docker probe; thermal verdict fields stay nil until
    /// κ-35 lands the .comm authoring.
    public static func gmshMesh(
        geometryId: String,
        producedAtUtc: String,
        gmshVersion: String,
        recordId: String,
        mshFile: String?,
        medFile: String?,
        meshStatsFile: String?,
        meshStats: ComponentMeshStats?,
        salomeDockerReady: Bool?,
        salomeImage: String?
    ) -> ComponentVerifyRecord {
        var caveats: [String] = [
            "gmsh mesh artifact — NOT a measured thermal / structural "
            + "verdict (g3). A mesh proves downstream FEA *can* run; "
            + "the verdict needs Salome-Meca Code_Aster on top.",
            "measurement_gate = GATE_OPEN — single-point or even "
            + "multi-point mesh is never GATE_B_PINNED_MET (full "
            + "sweep + multi-load required; D54 cite — same gate "
            + "discipline as the geometry producer).",
            "absorbed=true is never set by demiurge's gmsh verifier — "
            + "a measured component producer lives in hexa-lang/"
            + "component (P-⑨ owner); demiurge consumes it when it "
            + "exists.",
        ]
        if medFile == nil {
            caveats.append(
                "MED export unavailable in this gmsh build — Salome / "
                + "Code_Aster cannot ingest the mesh until MED writing "
                + "is restored (honest gap; .msh-only fallback).")
        }
        if salomeDockerReady == true {
            caveats.append(
                "Salome-Meca docker probe = ready (as_run invocable) — "
                + "the .comm authoring + convergence run is the next "
                + "pickup (κ-35 candidate, D55 gap ②).")
        } else if salomeDockerReady == false {
            caveats.append(
                "Salome-Meca docker probe = NOT ready (image missing or "
                + "as_run not invocable) — even mesh-handoff to Code_"
                + "Aster is blocked until that lands. honest gap.")
        }
        return ComponentVerifyRecord(
            interface: "hexa-arch:component:verify-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: producedAtUtc,
            geometryId: geometryId,
            mshFile: mshFile,
            medFile: medFile,
            meshStatsFile: meshStatsFile,
            meshStats: meshStats,
            salomeDockerReady: salomeDockerReady,
            salomeImage: salomeImage,
            provenance: ComponentProvenance(
                absorbed: false,
                producer: "gmsh@\(gmshVersion)",
                measurementGate: .open,
                scopeCaveats: caveats))
    }
}
