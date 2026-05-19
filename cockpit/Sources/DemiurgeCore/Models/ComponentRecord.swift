// ComponentRecord — phase λ-4 (rfc_011 §7 ComponentMode / rfc_002 §4
// F1F2-style record, component variant).
//
// The typed sidecar JSON that travels with an emitted component
// geometry artifact (.usda / .usdz). The cockpit reads it to render
// the honest provenance banner on ComponentMode (g3) — exactly as
// it does for chip F1F2 records.
//
// HONEST (g3): a demiurge-emitted component record carries
// `producer = demiurge_procedural_placeholder` and
// `measurementGate = GATE_OPEN`. It is geometry, not a measured
// thermal / structural verdict — those are separate gates.

import Foundation

/// Provenance block of a `ComponentRecord` — mirrors the chip F1F2
/// provenance discipline (absorbed flag + measurement gate + caveats).
public struct ComponentProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier, e.g. "demiurge_procedural_placeholder".
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    public let scopeCaveats: [String]

    public init(absorbed: Bool, producer: String,
                measurementGate: F1F2Record.MeasurementGate,
                scopeCaveats: [String]) {
        self.absorbed = absorbed
        self.producer = producer
        self.measurementGate = measurementGate
        self.scopeCaveats = scopeCaveats
    }

    enum CodingKeys: String, CodingKey {
        case absorbed
        case producer
        case measurementGate = "measurement_gate"
        case scopeCaveats = "scope_caveats"
    }
}

/// A component-geometry artifact record (rfc_002 §4 F1F2-style).
public struct ComponentRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let displayName: String
    public let layerCount: Int
    public let totalThicknessMM: Double
    public let widthMM: Double
    public let depthMM: Double
    /// Relative file name of the USD ASCII artifact, or nil when the
    /// producer is a CAD kernel (FreeCAD) that does not emit USDA.
    public let usdaFile: String?
    /// Relative file name of the .usdz package, or nil if packaging
    /// (usdcat / usdzip) was unavailable at emit time — honest gap.
    public let usdzFile: String?
    /// Relative file name of a STEP AP214 artifact (parametric CAD
    /// interchange) when the producer is FreeCAD — nil otherwise.
    /// κ-33: introduced for the FreeCAD parametric producer (D54).
    public let stepFile: String?
    /// Relative file name of a native OpenCascade .brep artifact
    /// when the producer is FreeCAD — nil otherwise.
    public let brepFile: String?
    /// Relative file name of an ASCII STL artifact — emitted by both
    /// the FreeCAD producer (triangulated from B-Rep) and absent for
    /// procedural placeholder runs (which write USDA/USDZ only).
    public let stlFile: String?
    /// Relative file name of the producer's sidecar metadata
    /// (`<geometryId>.meta.json`) when the producer is FreeCAD —
    /// captures kernel version, layer table, and honest-gap caveats
    /// straight from the producer.
    public let metaFile: String?
    public let provenance: ComponentProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, displayName: String,
                layerCount: Int, totalThicknessMM: Double,
                widthMM: Double, depthMM: Double,
                usdaFile: String?, usdzFile: String?,
                stepFile: String? = nil, brepFile: String? = nil,
                stlFile: String? = nil, metaFile: String? = nil,
                provenance: ComponentProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.displayName = displayName
        self.layerCount = layerCount
        self.totalThicknessMM = totalThicknessMM
        self.widthMM = widthMM
        self.depthMM = depthMM
        self.usdaFile = usdaFile
        self.usdzFile = usdzFile
        self.stepFile = stepFile
        self.brepFile = brepFile
        self.stlFile = stlFile
        self.metaFile = metaFile
        self.provenance = provenance
    }

    enum CodingKeys: String, CodingKey {
        case interface
        case schemaVersion = "schema_version"
        case recordId = "record_id"
        case producedAtUtc = "produced_at_utc"
        case geometryId = "geometry_id"
        case displayName = "display_name"
        case layerCount = "layer_count"
        case totalThicknessMM = "total_thickness_mm"
        case widthMM = "width_mm"
        case depthMM = "depth_mm"
        case usdaFile = "usda_file"
        case usdzFile = "usdz_file"
        case stepFile = "step_file"
        case brepFile = "brep_file"
        case stlFile = "stl_file"
        case metaFile = "meta_file"
        case provenance
    }

    /// Build the honest record for a FreeCAD parametric producer
    /// run (κ-33 / D54). `producerVersion` is the FreeCAD triple,
    /// e.g. `"1.1.1"`. `artifacts` is keyed by extension stem
    /// (`step`, `brep`, `stl`, `meta`) and carries the relative
    /// file name written under `exports/component/geometry/`.
    ///
    /// HONEST (g3): the geometry is parametric (OpenCascade B-Rep),
    /// NOT a measured BIPV module. `measurement_gate = GATE_OPEN`,
    /// `absorbed = false` — a real measured producer for BIPV lives
    /// in hexa-lang/component (P-⑨); FreeCAD only refines the
    /// placeholder, it does not absorb the part.
    public static func freecad(for g: ComponentGeometry,
                               producedAtUtc: String,
                               producerVersion: String,
                               artifacts: [String: String]) -> ComponentRecord {
        ComponentRecord(
            interface: "hexa-arch:component:geometry-record",
            schemaVersion: "1.1",
            recordId: artifacts["step"].map {
                ($0 as NSString).deletingPathExtension
            } ?? "bipv_freecad_v1",
            producedAtUtc: producedAtUtc,
            geometryId: g.id,
            displayName: g.displayName,
            layerCount: g.layers.count,
            totalThicknessMM: g.totalThicknessMM,
            widthMM: g.widthMM,
            depthMM: g.depthMM,
            usdaFile: nil,
            usdzFile: nil,
            stepFile: artifacts["step"],
            brepFile: artifacts["brep"],
            stlFile:  artifacts["stl"],
            metaFile: artifacts["meta"],
            provenance: ComponentProvenance(
                absorbed: false,
                producer: "freecad@\(producerVersion)",
                measurementGate: .open,
                scopeCaveats: [
                    "FreeCAD parametric geometry (OpenCascade B-Rep) "
                    + "— more precise than the procedural placeholder, "
                    + "but still NOT a measured BIPV module (g3).",
                    "thermal / structural / optical verdicts are "
                    + "separate gates (gmsh + Elmer / Code_Aster) — "
                    + "measurement_gate stays GATE_OPEN until those "
                    + "land.",
                    "absorbed=true is never set by demiurge's FreeCAD "
                    + "producer — a measured component producer lives "
                    + "in hexa-lang/component (P-⑨); demiurge consumes "
                    + "it when it exists.",
                    "layer dimensions mirror "
                    + "ComponentGeometry.bipv5Layer (Swift SSOT) — "
                    + "plausible, not pulled from a datasheet.",
                ]))
    }

    /// Build the honest record for a procedurally-emitted geometry.
    public static func procedural(for g: ComponentGeometry,
                                  producedAtUtc: String,
                                  usdaFile: String,
                                  usdzFile: String?) -> ComponentRecord {
        ComponentRecord(
            interface: "hexa-arch:component:geometry-record",
            schemaVersion: "1.0",
            recordId: g.id,
            producedAtUtc: producedAtUtc,
            geometryId: g.id,
            displayName: g.displayName,
            layerCount: g.layers.count,
            totalThicknessMM: g.totalThicknessMM,
            widthMM: g.widthMM,
            depthMM: g.depthMM,
            usdaFile: usdaFile,
            usdzFile: usdzFile,
            provenance: ComponentProvenance(
                absorbed: false,
                producer: "demiurge_procedural_placeholder",
                measurementGate: .open,
                scopeCaveats: [
                    "procedural placeholder geometry — plausible "
                    + "dimensions, NOT a measured component (g3)",
                    "geometry being well-formed != thermal / "
                    + "structural / EM verdicts being measured — "
                    + "those are separate gates",
                    "a measured component producer lives in "
                    + "hexa-lang/component (P-⑨); demiurge consumes "
                    + "it when it exists",
                ]))
    }
}
