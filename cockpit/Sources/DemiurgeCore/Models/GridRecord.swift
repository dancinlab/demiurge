// GridRecord — phase: cohort producer prototype (D57; no standalone
// PLAN κ entry — post-merge reconstructed).
//
// Typed sidecar for a `grid + structure` producer run — the SECOND
// cohort domain (after κ-34 / D55's `sscb + analyze` ngspice producer)
// wired to a real measuring engine tool. NetworkX 3.2.1 is the
// producer; demiurge spawns it and persists the graph-theoretic
// measurements as a typed record.
//
// rfc_002 §4 F1F2-style discipline (mirror SSCBRecord / MatterRecord /
// ComponentRecord / F1F2Record): producer pinned to the library
// identity, measurement_gate honest, scope_caveats embedded.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "networkx@<version>" — pins the library, NOT the
//     real-world fabric. IEEE 14-bus is a *published reference test
//     case* (Christie 1962, UW Power Systems Test Case Archive,
//     pglib-opf `case14`). The TOPOLOGY is canonical and the metrics
//     NetworkX computes ARE deterministic mathematical facts —
//     therefore measurement_gate = GATE_CLOSED_MEASURED is HONEST
//     here (the graph IS the measurement; same epistemic class as a
//     F1F2 chip record).
//   • absorbed = false ALWAYS — NetworkX is an EXTERNAL Python
//     library, not absorbed into hexa-lang stdlib. The day a
//     `hexa-graph` re-computes these numerically-identically, the
//     absorbed flip happens elsewhere — NOT in Swift.
//   • SCOPE CAVEATS surface three honest gaps:
//       1. IEEE 14-bus is a POWER-GRID reference; the demiurge
//          `grid` domain is AI DATACENTER fabric. Producer
//          demonstrates the WIRING on a canonical graph the field
//          has measured — NOT a real DC fat-tree manifest.
//       2. bisection_min_cut_edges counts LINKS, NOT Gbps. No
//          SerDes channel model. The "real" DC bisection bandwidth
//          gate lives in ns-3 / SST (domains/grid.md §2 ANALYZE)
//          + HFSS / Sigrity SI (§4 gap).
//       3. NetworkX is external — demiurge witnesses, NetworkX
//          measures. The mirror of D17 (hexa-matter is owner,
//          demiurge is consumer) for graph-theoretic verbs.

import Foundation

/// Provenance for a `GridRecord` — mirrors SSCBProvenance / Component-
/// Provenance / MatterProvenance (same absorbed + measurementGate +
/// caveats discipline; producer points to networkx not demiurge).
public struct GridProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "networkx@3.2.1" (library identity,
    /// NOT real-world fabric identity — g3).
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

/// One row of a top-N centrality table.
public struct GridCentralityRow: Codable, Equatable, Sendable {
    public let node: Int
    public let score: Double

    public init(node: Int, score: Double) {
        self.node = node
        self.score = score
    }
}

/// Topology descriptor echoed from the producer — kept on the record
/// so a downstream sweep can compare graph configurations.
public struct GridTopology: Codable, Equatable, Sendable {
    /// Human-readable name (e.g. "IEEE 14-bus").
    public let name: String
    /// Source citation for the canonical edge list.
    public let source: String
    public let nodeCount: Int
    public let edgeCount: Int
    /// Canonical edge list (undirected, integer node IDs).
    public let edges: [[Int]]

    public init(name: String, source: String,
                nodeCount: Int, edgeCount: Int, edges: [[Int]]) {
        self.name = name
        self.source = source
        self.nodeCount = nodeCount
        self.edgeCount = edgeCount
        self.edges = edges
    }

    enum CodingKeys: String, CodingKey {
        case name
        case source
        case nodeCount = "node_count"
        case edgeCount = "edge_count"
        case edges
    }
}

/// The headline graph-theoretic measurements — these ARE the real
/// numbers (NetworkX's IEEE-754 deterministic graph algorithms). The
/// honesty gate is on the *interpretation* (caveats), NOT the
/// *measurement*.
public struct GridMeasurements: Codable, Equatable, Sendable {
    public let nodeCount: Int
    public let edgeCount: Int
    public let isConnected: Bool
    public let density: Double
    /// nil if the graph is disconnected (shortest-path metrics
    /// undefined). For IEEE 14-bus this is always 5.
    public let diameter: Int?
    public let radius: Int?
    public let avgShortestPathHops: Double?
    public let averageClustering: Double
    /// Edge-connectivity (min s-t cut over all node pairs) — counted
    /// in LINKS, not Gbps. nil if disconnected. (g3 caveat #2.)
    public let bisectionMinCutEdges: Int?
    /// Top-N by betweenness (which buses sit on the most shortest
    /// paths) and degree (highest fan-out). N=3 by producer default.
    public let topBetweenness: [GridCentralityRow]
    public let topDegree: [GridCentralityRow]

    enum CodingKeys: String, CodingKey {
        case nodeCount = "node_count"
        case edgeCount = "edge_count"
        case isConnected = "is_connected"
        case density
        case diameter
        case radius
        case avgShortestPathHops = "avg_shortest_path_hops"
        case averageClustering = "average_clustering"
        case bisectionMinCutEdges = "bisection_min_cut_edges"
        case topBetweenness = "top_betweenness"
        case topDegree = "top_degree"
    }
}

/// A grid topology-structure record (D57). Captures the
/// canonical edge list + the graph-theoretic measurements computed by
/// NetworkX, plus the edge-list hash so cross-host drift is visible.
public struct GridRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let edgesSha256_16: String
    public let networkxVersion: String
    public let topology: GridTopology
    public let measurements: GridMeasurements
    public let computeElapsedS: Double?
    /// Artifact files (relative to `exports/grid/structure/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: GridProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, edgesSha256_16: String,
                networkxVersion: String,
                topology: GridTopology,
                measurements: GridMeasurements,
                computeElapsedS: Double?,
                artifacts: [String: String],
                provenance: GridProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.edgesSha256_16 = edgesSha256_16
        self.networkxVersion = networkxVersion
        self.topology = topology
        self.measurements = measurements
        self.computeElapsedS = computeElapsedS
        self.artifacts = artifacts
        self.provenance = provenance
    }

    enum CodingKeys: String, CodingKey {
        case interface
        case schemaVersion = "schema_version"
        case recordId = "record_id"
        case producedAtUtc = "produced_at_utc"
        case geometryId = "geometry_id"
        case edgesSha256_16 = "edges_sha256_16"
        case networkxVersion = "networkx_version"
        case topology
        case measurements
        case computeElapsedS = "compute_elapsed_s"
        case artifacts
        case provenance
    }
}
