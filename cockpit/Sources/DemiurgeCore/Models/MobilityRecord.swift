// MobilityRecord — phase: cohort producer prototype (no standalone
// PLAN κ / D-block — post-merge reconstructed).
//
// Typed sidecar for a `mobility + analyze` producer run — a cohort
// domain (after sscb κ-34, energy κ-35, …) wired to a real
// measuring engine tool, and the FIRST mobility / autonomous-driving
// cell. osmnx (MIT, OpenStreetMap road-network analysis) is the
// producer; demiurge spawns it and persists the topology measurements
// as a typed record.
//
// rfc_002 §4 F1F2-style discipline (mirror SSCBRecord / EnergyRecord /
// MatterRecord / ComponentRecord): producer pinned to the library
// identity, measurement_gate honest, scope_caveats embedded with the
// record.
//
// HONESTY (g3 — non-negotiable):
//   * producer = "osmnx@<version>" — pins the library, NOT the
//     road-network data. The current producer builds a *synthetic
//     10x10 Manhattan grid topology fixture* (no real OSM extract,
//     no Overpass network call) so the record is reproducible byte-
//     for-byte across hosts. osmnx.basic_stats() and networkx
//     diameter computation ARE standard graph algorithms — the
//     numbers are real measurements OF the synthetic grid.
//   * absorbed = false — ALWAYS. Same BANNED-absorbed stance as
//     SSCBRecord and EnergyRecord. Real "absorbed" mobility-analyze
//     would need a real OSM extract (or HD map) for a named place,
//     a calibrated traffic-demand matrix, and a SUMO / CARLA micro-
//     simulation validated against measured travel times. None are
//     in scope here.
//   * scope_caveats records that the graph is a *topology fixture*
//     (NOT real Manhattan), that NO traffic flow / travel time /
//     vehicle simulation is run, and that the cell intentionally
//     stops at the road-graph topology layer to keep cohort
//     breadth-coverage tractable.

import Foundation

/// Provenance for a `MobilityRecord` — mirrors EnergyProvenance /
/// SSCBProvenance (same absorbed + measurementGate + caveats
/// discipline; producer points to osmnx not demiurge).
public struct MobilityProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "osmnx@2.1.0" (library identity,
    /// not road-network identity — g3).
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

/// Place parameters echoed from the producer — kept on the record so
/// a downstream sweep can compare locations.
public struct MobilityPlace: Codable, Equatable, Sendable {
    public let label: String
    public let originLat: Double
    public let originLon: Double
    /// True for the cohort-round synthetic fixture; reserved for future
    /// "real OSM fetch" producer runs that flip it to false.
    public let isSynthetic: Bool

    enum CodingKeys: String, CodingKey {
        case label
        case originLat = "origin_lat"
        case originLon = "origin_lon"
        case isSynthetic = "is_synthetic"
    }
}

/// Topology parameters echoed from the producer — the recipe used to
/// synthesise the graph (or, in a future real-OSM variant, the query
/// parameters used to pull it).
public struct MobilityTopology: Codable, Equatable, Sendable {
    public let gridN: Int
    public let blockLengthM: Double
    public let model: String

    enum CodingKeys: String, CodingKey {
        case gridN = "grid_n"
        case blockLengthM = "block_length_m"
        case model
    }
}

/// The headline measurements extracted from the road-network graph —
/// these ARE the real numbers (osmnx.basic_stats + networkx.diameter
/// outputs). The honesty gate is on the *data source* (synthetic
/// grid, not real OSM), not the algorithm.
public struct MobilityMeasurements: Codable, Equatable, Sendable {
    public let nodeCount: Int
    public let edgeCount: Int
    public let intersectionCount: Int
    public let kAvg: Double?
    public let edgeLengthTotalM: Double?
    public let edgeLengthAvgM: Double?
    public let streetsPerNodeAvg: Double?
    /// Histogram of street_count per node — keys "0".."N" → node
    /// count. Stable Codable shape (Swift can't decode Int keys cleanly).
    public let streetsPerNodeCounts: [String: Int]
    public let connectedComponents: Int
    /// Undirected graph diameter (number of hops between the two
    /// furthest-apart intersections); nil if graph is disconnected.
    public let diameterUndirected: Int?

    enum CodingKeys: String, CodingKey {
        case nodeCount = "node_count"
        case edgeCount = "edge_count"
        case intersectionCount = "intersection_count"
        case kAvg = "k_avg"
        case edgeLengthTotalM = "edge_length_total_m"
        case edgeLengthAvgM = "edge_length_avg_m"
        case streetsPerNodeAvg = "streets_per_node_avg"
        case streetsPerNodeCounts = "streets_per_node_counts"
        case connectedComponents = "connected_components"
        case diameterUndirected = "diameter_undirected"
    }
}

/// A mobility road-network analyze record (cohort round, no standalone
/// PLAN κ / D-block — post-merge reconstructed). Captures the
/// road-graph topology stats from `osmnx.basic_stats()` plus the
/// place + topology parameters so cross-host drift (different osmnx
/// versions, different synthesis recipes) is visible.
public struct MobilityRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let osmnxVersion: String
    public let networkxVersion: String
    public let pythonVersion: String
    public let place: MobilityPlace
    public let topology: MobilityTopology
    public let measurements: MobilityMeasurements
    /// Artifact files (relative to `exports/mobility/road/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: MobilityProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, osmnxVersion: String,
                networkxVersion: String, pythonVersion: String,
                place: MobilityPlace, topology: MobilityTopology,
                measurements: MobilityMeasurements,
                artifacts: [String: String],
                provenance: MobilityProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.osmnxVersion = osmnxVersion
        self.networkxVersion = networkxVersion
        self.pythonVersion = pythonVersion
        self.place = place
        self.topology = topology
        self.measurements = measurements
        self.artifacts = artifacts
        self.provenance = provenance
    }

    enum CodingKeys: String, CodingKey {
        case interface
        case schemaVersion = "schema_version"
        case recordId = "record_id"
        case producedAtUtc = "produced_at_utc"
        case geometryId = "geometry_id"
        case osmnxVersion = "osmnx_version"
        case networkxVersion = "networkx_version"
        case pythonVersion = "python_version"
        case place
        case topology
        case measurements
        case artifacts
        case provenance
    }
}
